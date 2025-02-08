unit LMDCustomPanel;
{$I lmdcmps.inc}

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

LMDCustomPanel unit (RM)
-----------------------

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Classes, Graphics, Themes, LMDClass, LMDCustomControl;

type
  {-------------------TLMDCustomPanel------------------------------------------}
  TLMDCustomPanel = class(TLMDCustomControl)
  private
    FLocked  : Boolean;
    procedure WMMOVE(var Message: TWMMOVE); message WM_MOVE;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    function GetThemedBkColor: TColor;
    function GetBackColor: TColor; override;
    property Color default clBtnFace;
    property Locked:Boolean read FLocked write FLocked default False;
    property ParentColor default False;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    {supporting transparency}
    function BackBitmapCheck: Boolean; override;
    function BackBitmap: TBitmap; override;
    function BackMapPoint(const aValue: TPoint): TPoint; override;
    function BackDrawArea(Canvas: TCanvas; const dest: TRect; const src: TPoint; flags: Word=0): Boolean;override;
  end;

implementation
uses
  Forms, Controls,
  intfLMDBackground;

{provides OnSize-Event}
{************************ Class TLMDCustomPanel *******************************}
{------------------------- Private---------------------------------------------}
procedure TLMDCustomPanel.WMSize(var Message: TWMSize);
begin
  inherited;
  //!!
  GetBackFX.DestroyBuffer;
  //!!
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPanel.WMMOVE(var Message: TWMMOVE);
begin
  inherited;
  if CheckOptimized then
    BackUpdate;
end;

{------------------------- Protected ------------------------------------------}
function TLMDCustomPanel.BackBitmapCheck:Boolean;
begin
 result := LMDBackBitmapCheck (self);
end;

{------------------------------------------------------------------------------}
function TLMDCustomPanel.BackBitmap:TBitmap;
begin
  result:=inherited BackBitmap;
  if BackBitmapCheck then
    begin
//      result := LMDBackBitmap (self);

      if GetBackFX.Enabled and (result <> nil) then
        result.PixelFormat := pf24Bit;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPanel.BackMapPoint(const aValue:TPoint):TPoint;
begin
  if BackBitmapCheck then
    begin
      result := LMDBackMapPoint (self, aValue);
      //difference between Client / ClipRect -> only if a Windows border is painted (Bevel.Mode = bmWindows or std control border (without bevel))
      if ClientWidth <> Width then //border is painted
        result.X := result.X + (Width - ClientWidth) div 2;
      if ClientHeight <> Height then
        result.Y := result.Y + (Height - ClientHeight) div 2;
    end
  else
    result:=inherited BackMapPoint(aValue);
end;

{------------------------------------------------------------------------------}
function TLMDCustomPanel.BackDrawArea(Canvas:TCanvas; const dest:TRect; const src:TPoint; flags:Word):Boolean;
var
  b : TBitmap;
  srcRect,
  aRect : TRect;
begin
  result:=inherited BackDrawArea(Canvas, dest, src, flags);
  if (csLoading in ComponentState) or (csDestroying in ComponentState) then exit;

  if BackBitmap<>nil then
    begin

      //copy rect (of size dest) from srcPoint to dest

      //get control's rect relative to control which contains the relevant BackBitmap
      aRect.Left := Left;
      aRect.Top := Top;

      aRect.TopLeft := BackMapPoint (Point(0,0));

      //just calculate the bottom right corner
      aRect.BottomRight := Point (aRect.Left + Width - (Width - ClientWidth), aRect.Top + Height - (Height - ClientHeight));

      //aRect now contains controls area relative to actual BackBitmap

      //:-)

      //aRect is now a corrected rect (Windows border present)

      //let's calculate the source rect
      //-> dest is a Rect with TopLeft relative to (0,0) of this control
      srcRect := dest;

      //make srcRect position in the control relative to parent control

      //src : TPoint ... if destination (Canvas) is not euqal to control's canvas we have to move our srcRect
      //
      OffsetRect (srcRect, +aRect.Left+src.X, +aRect.Top+src.Y);

      //now srcRect describes the area to be taken from the BackBitmap

      if (GetBackFX.Enabled) and not BackFXPass then
        begin
          OffsetRect (srcRect, -aRect.Left, -aRect.Top);
          if not GetBackFX.BufferValid then
            begin
              b := TBitmap.Create;
              try
                //including Left and Right => +2
                b.Width := aRect.Right - aRect.Left + 2;
                b.Height := aRect.Bottom - aRect.Top + 2;
                b.PixelFormat := pf24Bit;
                BackBitmap.PixelFormat := pf24Bit;

                //aRect = this control's rect on BackBitmap
                //dest = area to be repainted

                //calculate effects for whole image

                GetBackFX.DrawCutRect2 (BackBitmap, aRect, b, b.Canvas.ClipRect);

                //let's make srcRect relative to control's (0,0) not to BackBitmap (0,0)

                Canvas.CopyRect (dest, b.Canvas, srcRect);
              finally
                b.Free;
              end
            end
          else
            Canvas.CopyRect (dest, GetBackFX.BufferBitmap.Canvas, srcRect);
        end
      else
        Canvas.CopyRect(dest, BackBitmap.Canvas, srcRect);

      result:=True;
    end;
end;

{---------------------------------- Public ------------------------------------}
constructor TLMDCustomPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csAcceptsControls, csReplicatable];
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomPanel.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPanel.GetBackColor: TColor;
begin
  Result := GetThemedBkColor;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPanel.GetThemedBkColor: TColor;
{$IFDEF LMDCOMP16}
var
  dtls: TThemedElementDetails;
{$ENDIF}
begin
  {$IFDEF LMDCOMP16}
  if (UseThemeMode = ttmPlatform) and StyleServices.Enabled and
     TStyleManager.IsCustomStyleActive then
  begin
    dtls := StyleServices.GetElementDetails(tpPanelBackground);
    if not StyleServices.GetElementColor(dtls, ecFillColor, Result) or
       (Result = clNone) then
      Result := clBtnFace;
  end
  else
  {$ENDIF}
    Result := Color;
end;

end.
