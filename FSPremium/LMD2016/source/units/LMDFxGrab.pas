unit LMDFxGrab;
{$I LMDCmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDFxEffect unit (RM, AH)
------------------------

Note
----
LMD FxPack is based on code licensed from Eugene Kryukov

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Graphics, Controls, Forms, Classes, SysUtils,
  LMDFxUtils, LMDFxBitmap, LMDFxEffect;

type
  TLMDFxGrabberControlClass = class of TControl;

  { ************************ class TLMDFxGrabber ***************************** }
  TLMDFxGrabber = class(TObject)
  private
  public
    procedure GrabToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl; ARect: TRect); virtual;
    class function GetGrabberClassType: TLMDFxGrabberControlClass; virtual;
    class function GetGrabberClassName: string; virtual;
  end;

  TLMDFxGrabberClass = class of TLMDFxGrabber;

function LMDFxGrabDesktopToBitmap(ARect: TRect; ABitmap: TBitmap = nil): TBitmap;
function LMDFxGrabDesktopToKeBitmap(ARect: TRect; ABitmap: TLMDFxBitmap = nil): TLMDFxBitmap;

function LMDFxGrabToBitmap(AControl: TControl; ARect: TRect; ABitmap: TBitmap = nil): TBitmap;
function LMDFxGrabToKeBitmap(AControl: TControl; ARect: TRect; ABitmap: TLMDFxBitmap = nil): TLMDFxBitmap;

procedure LMDFxRegisterGrabber(AGrabber: TLMDFxGrabberClass);

implementation

uses
  LMDFxGrabClass;

type
  TWControl = TWinControl;

var
  GrabberList: TList = nil;

{ ---------------------------------------------------------------------------- }
procedure LMDFxRegisterGrabber(AGrabber: TLMDFxGrabberClass);
begin
  if GrabberList = nil then
    GrabberList := TList.Create;

  GrabberList.Add(AGrabber);
  end;

{ ************************ class TLMDFxGrabber ******************************* }
{ ------------------------------ public -------------------------------------- }

{ -----------------------------------------------------------------------------}
class function TLMDFxGrabber.GetGrabberClassName: string;
begin
  Result := '';
end;

{ ---------------------------------------------------------------------------- }
class function TLMDFxGrabber.GetGrabberClassType: TLMDFxGrabberControlClass;
begin
  Result := nil;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxGrabber.GrabToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl; ARect: TRect);
begin
end;

{ Main grabber routines =======================================================}
procedure LMDFxGrabControlToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl; ARect: TRect);
var
  i: integer;
  Grabber: TLMDFxGrabber;
  IsGrabbed: boolean;
  Child: TControl;
  ChildRect: TRect;
  ChildX, ChildY: integer;
  ClipRgn: Cardinal;

begin
  { Search registered Grabber }
  IsGrabbed := false;

  { Correct ARect }
  IntersectRect(ARect, ARect, Rect(0, 0, AControl.Width, AControl.Height));
  if IsRectEmpty(ARect) then Exit;

  ClipRgn := CreateRectRgn(X + ARect.Left, Y +ARect.Top, X +ARect.Right, Y + ARect.Bottom);
  SelectClipRgn(ABitmap.Canvas.Handle, ClipRgn);

  { Grab }
  if (GrabberList <> nil) and (GrabberList.Count > 0) then
    for i := GrabberList.Count - 1 downto 0 do
    begin
      if (AControl is TLMDFxGrabberClass(GrabberList[i]).GetGrabberClassType) or
         (Pos(LowerCase(AControl.ClassName), TLMDFxGrabberClass(GrabberList[i]).GetGrabberClassName) > 0) then
      begin
        Grabber := TLMDFxGrabberClass(GrabberList[i]).Create;
        try
          Grabber.GrabToBitmap(ABitmap, X, Y, AControl, ARect);
        finally
          Grabber.Free;
        end;

        IsGrabbed := true;

        Break;
      end;
    end;

  { if Grabber not exists use default Win\Widget grabber routines }
  if not IsGrabbed then
  begin
    Grabber := TLMDFxWControlGrabber.Create;
    try
      Grabber.GrabToBitmap(ABitmap, X, Y, AControl, ARect);
    finally
      Grabber.Free;
    end;
  end;

  { Grab children }
  if (AControl is TWControl) and (TWControl(AControl).ControlCount > 0) then
  begin
    for i := 0 to TWControl(AControl).ControlCount - 1 do
    begin
      Child := TWControl(AControl).Controls[i];

      if Child is TGraphicControl then Continue;
      if not Child.Visible then Continue;

      ChildRect := GetRealBoundsRect(Child);
      ChildX := ChildRect.Left;
      ChildY := ChildRect.Top;
      IntersectRect(ChildRect, ChildRect, ARect);
      { Check ClientRect }
      IntersectRect(ChildRect, ChildRect, TWControl(AControl).ClientRect);

      with GetClientOrigin(AControl) do
      begin
        ChildX := ChildX + X;
        ChildY := ChildY + Y;
      end;

      OffsetRect(ChildRect, -ChildRect.Left, -ChildRect.Top);
      LMDFxGrabControlToBitmap(ABitmap, X + ChildX, Y + ChildY, Child, ChildRect);
    end;
  end; 

  DeleteObject(ClipRgn);
  SelectClipRgn(ABitmap.Canvas.Handle, 0);
end;

{ Control grabber =============================================================}
function LMDFxGrabToBitmap(AControl: TControl; ARect: TRect; ABitmap: TBitmap = nil): TBitmap;
begin
  Result := TBitmap.Create;
  try
    Result.Width := RectWidth(ARect);
    Result.Height := RectHeight(ARect);

    if (RectWidth(ARect) <= 0) or (RectHeight(ARect) <= 0) then Exit;

    LMDFxGrabControlToBitmap(Result, -ARect.Left, -ARect.Top, AControl, ARect);
  except
    FreeAndNil(Result);
    raise ;
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDFxGrabToKeBitmap(AControl: TControl; ARect: TRect; ABitmap: TLMDFxBitmap = nil): TLMDFxBitmap;
var
  TempB: TBitmap;
begin
  Result := TLMDFxBitmap.Create;
  try
    TempB := LMDFxGrabToBitmap(AControl, ARect);

    if TempB <> nil then
    begin
      Result.Assign(TempB);

      TempB.Free;
    end;
  except
    FreeAndNil(Result);
    raise ;
  end;
end;

{ Desktop grabber =============================================================}
function LMDFxGrabDesktopToBitmap(ARect: TRect; ABitmap: TBitmap = nil): TBitmap;
var
  DC: HDC;
begin
  Result := TBitmap.Create;
  try
    Result.Width := RectWidth(ARect);
    Result.Height := RectHeight(ARect);

    DC := GetDC(0);
    try
      BitBlt(Result.Canvas.Handle, 0, 0, Result.Width, Result.Height, DC, ARect.Left, ARect.Top, SRCCOPY);
    finally
      ReleaseDC(0, DC);
    end;
  except
    FreeAndNil(Result);
    raise ;
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDFxGrabDesktopToKeBitmap(ARect: TRect; ABitmap: TLMDFxBitmap = nil): TLMDFxBitmap;
var
  TempB: TBitmap;
begin
  Result := TLMDFxBitmap.Create;
  try
    TempB := LMDFxGrabDesktopToBitmap(ARect);
    if TempB <> nil then
    try
      Result.Assign(TempB);
    finally
      TempB.Free;
    end;
  except
    FreeAndNil(Result);
    raise ;
  end;
end;

initialization

finalization
  if GrabberList <> nil then
    GrabberList.Free;
end.
