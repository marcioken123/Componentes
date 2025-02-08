unit LMDCustomNImage;
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

LMDCustomNImage unit ()
-----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  Graphics,
  LMDGraph,
  LMDTransparent,
  LMDBaseImage;

type
  {--------------------------- TLMDCustomNImage -------------------------------}
  TLMDCustomNImage = class(TLMDBaseImage)
  private
    FBitmap:TBitmap;
    FControl:TLMDCustomNImage;
    FTransparentStyle:TLMDTransparent;
    procedure SetBitmap(aValue:TBitmap);
    procedure SetControl(aControl:TLMDCustomNImage);
    procedure SetTransparentStyle(aValue:TLMDTransparent);
  protected
    function CorrectBounds:Boolean;override;
    function GetBitmap(tmp:TBitmap):TBitmap;virtual;
    function GetEmpty:Boolean;override;
    function GetPalette:HPalette;override;
    function HasControl:Boolean;
    procedure Notification(AComponent: TComponent;Operation:TOperation);override;
    procedure Paint;override;
    {protected properties}
    property Bitmap:TBitmap read FBitmap write SetBitmap;
    property Control:TLMDCustomNImage read FControl write SetControl;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  published
    property Align;
    property BackFX;
    property Bevel;
    property Color;
    property DragCursor;
    property DragMode;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property QuickDraw;
    property ShowHint;
    property Style;
    property TransparentStyle:TLMDTransparent read FTransparentStyle write SetTransparentStyle;
    property Transparent default True;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;
    property OnEndDock;
    property OnStartDock;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;

implementation
uses
  Controls, SysUtils, LMDUtils, LMDGraphUtils;

{------------------------- Private---------------------------------------------}
procedure TLMDCustomNImage.SetBitmap(aValue:TBitmap);
begin
  FBitmap.Assign(aValue);
  PaletteChanged(False);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomNImage.SetControl(aControl:TLMDCustomNImage);
begin
  if (aControl<>FControl) and (aControl<>self) then
    begin
      FControl:=aControl;
      if FControl<>nil then FControl.FreeNotification(Self);
      InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDCustomNImage.SetTransparentStyle(aValue:TLMDTransparent);
begin
  FTransparentStyle.Assign(aValue);
end;

{------------------------ Protected -------------------------------------------}
function TLMDCustomNImage.CorrectBounds:Boolean;
var
  w, h:Integer;
begin
  result:=false;
  if Style=sbAutosize then
    begin
      if GetEmpty then
        begin
          w:=20+DblBevelExt;
          h:=20+DblBevelExt;
        end
      else
        begin
          w:=GetBitmap(nil).Width+DblBevelExt;
          h:=GetBitmap(nil).Height+DblBevelExt;
        end;
      if (w<>Width) or (h<>Height) then
        begin
          SetBounds(Left, Top, w, h);
          result:=True;
        end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomNImage.GetBitmap(tmp:TBitmap):TBitmap;
begin
  if HasControl then result:=FControl.Bitmap else result:=FBitmap;
end;

{------------------------------------------------------------------------------}
function TLMDCustomNImage.GetEmpty:Boolean;
begin
  result:=GetBitmap(nil).Empty and {$IFNDEF LMDCOMP10} not (csPaintCopy in ControlState) {$ELSE}
          not ((csPaintCopy in ControlState) and not (csDesigning in ComponentState));
          {$ENDIF}
end;

{------------------------------------------------------------------------------}
function TLMDCustomNImage.GetPalette: HPALETTE;
begin
  Result := 0;
  if not GetBitmap(nil).Empty then Result := GetBitmap(nil).Palette
end;

{------------------------------------------------------------------------------}
function TLMDCustomNImage.HasControl:Boolean;
begin
  result:=FControl<>nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomNImage.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent=FControl) and (Operation = opRemove) then
    begin
      FControl:=nil;
      InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomNImage.Paint;
var
  aRect:TRect;
  flags:WORD;
  transColor:TColor;
  t, t2:TBitmap;
begin
  if (csLoading in ComponentState) or CorrectBounds then exit;

  if not Transparent then
    FillControl
  else
    if GetEmpty and (BevelExt=0) then
      begin
        inherited Paint;
        Exit;
      end;

  aRect:=Bevel.PaintBevel(Canvas, GetClientRect, inherited Transparent);
  if GetEmpty then exit;

  (*if (csPaintCopy in ControlState) {$IFDEF LMDCOMP10}and not (csDesigning in ComponentState){$ENDIF} then
    begin
      //t:=TBitmap.Create;
      t:=GetBitmap(t);
    end
  else*)
  t:=GetBitmap(nil); //getbitmap ignores parameter [VB March 2012]

  try
    flags:=0;
    transColor:=0;
    case FTransparentStyle.Mode of
      tpTransparentColor:
        begin
          flags:=DSF_BRUSHCOPY;
          transColor:=FTransparentStyle.Color;
        end;
      tpRestoreBack:
        begin
          flags:=DSF_TRANSPARENCY;
          transColor:=t.TransparentColor;
        end;
      tpRBTranspColor:
         begin
          flags:=DSF_TRANSPARENCY;
          transColor:=FTransparentStyle.Color
        end;
    end;

    try
      AddStyleFlags(flags);
      if not QuickDraw then
        begin
          SelectPalette(Canvas.Handle, t.Palette, True);
          RealizePalette(Canvas.Handle);
        end;

//      if (AlphaBlend.Fillobject.Style <> sfNone) and (AlphaBlending.Strength <> 1) then
        begin
          t2 := TBitmap.Create;
          try
            t2.Width := t.Width;
            t2.Height := t.Height;
            t2.PixelFormat := pf24Bit;
            t2.Canvas.Draw (0,0,t);

            BackFX.Draw (t2);

            LMDBmpClipDraw(Canvas, aRect, t2, flags, MakeLong(Left, Top), transColor);
          finally
            t2.Free;
          end;
        end
//      else
//        LMDBmpClipDraw(Canvas, aRect, t, flags, MakeLong(Left, Top), transColor);
    except
      on exception do exit;
    end;
  finally
    //if Assigned(t) and (t <> FBitmap) and (csPaintCopy in ControlState) {$IFDEF LMDCOMP10} and not (csDesigning in ComponentState){$ENDIF} then
    //  t.Free;
  end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDCustomNImage.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FBitmap:=TBitmap.Create;
  FBitmap.OnChange:=GetChange;
  FTransparentStyle:=TLMDTransparent.Create;
  FTransparentStyle.OnChange:=GetChange;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomNImage.Destroy;
begin
  FBitmap.OnChange:=nil;
  FTransparentStyle.OnChange:=nil;
  FBitmap.Free;
  FTransparentStyle.Free;
  inherited Destroy;
end;

end.
 
