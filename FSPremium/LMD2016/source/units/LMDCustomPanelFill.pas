unit LMDCustomPanelFill;
{$I lmdcmps.INC}

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

LMDCustomPanelFill unit (RM)
----------------------------


Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Classes, Controls, Graphics, Forms,
  LMDGraph, LMDFillObject, LMD3DCaption, LMDFXCaption, LMDCustomParentPanel;

type
  {--------------------- TLMDCustomPanelFill ----------------------------------------}
  TLMDCustomPanelFill = class(TLMDCustomParentPanel)
  private
    FAlignment        : TLMDAlignment;
    FFontFx           : TLMDFxCaption;
    FFillObject       : TLMDFillObject;
    FTransparentBorder: Boolean;

    procedure SetAlignment(aValue: TLMDAlignment);
    procedure SetCaptionFx(aValue: TLMDFxCaption);
    procedure SetFillObject(aValue: TLMDFillObject);
    procedure SetTransparentBorder(aValue: Boolean);
    procedure CMEnabledChanged(var Message: TMessage);message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage);message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage);message CM_TEXTCHANGED;
  protected
    procedure AdjustClientRect(var Rect: TRect);override;
    procedure CreateBack(aValue: Boolean); override;
    procedure DrawBack(Canvas: TCanvas; aRect:TRect);
    procedure DrawCaption(aRect: TRect; aAlignment:TLMDAlignment); virtual;
    procedure GetChange(Sender: TObject); override;
    procedure GetIMLChange(Sender: TObject); override;
    function  GetEmpty: Boolean; override;
    function  GetPalette: HPalette;override;
    procedure Loaded; override;
    procedure Paint; override;
    procedure Resize; override;

    procedure MouseEnter; override;
    procedure MouseExit; override;

    function GetFillObject: TLMDFillObject; override;
    function GetFont3D    : TLMD3DCaption; override;

    property Alignment: TLMDAlignment read FAlignment write SetAlignment default agCenter;
    property FontFX: TLMDFxCaption read FFontFx write SetCaptionFx;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    property FillObject: TLMDFillObject read FFillObject write SetFillObject;
    property TransparentBorder: Boolean read FTransparentBorder write SetTransparentBorder default false;
  end;

implementation
uses
  Types, SysUtils,
  LMDClass, LMDCont, LMDBase, LMDUtils, LMDProcs, LMDCustomImageList, LMDGraphUtils;

{************************ Class TLMDCustomPanelFill ***************************}
{------------------------- Private --------------------------------------------}
procedure TLMDCustomPanelFill.SetAlignment(aValue:TLMDAlignment);
begin
  if aValue<>FAlignment then
    begin
      FAlignment:=aValue;
      GetChange(Font);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPanelFill.SetCaptionFx(aValue:TLMDFxCaption);
begin
  FFontFx.Assign(aValue);
end;

{------------------------------------------------------------------------------}
Procedure TLMDCustomPanelFill.SetFillObject(aValue:TLMDFillObject);
begin
  FFillObject.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPanelFill.SetTransparentBorder(aValue:Boolean);
begin
  if aValue<>FTransparentBorder then
    begin
      FTransparentBorder:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPanelFill.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  GetChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPanelFill.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ParentFont:=False;
  GetChange(FontFx);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPanelFill.CMTextChanged(var Message: TMessage);
begin
  inherited;
  GetChange(nil);
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDCustomPanelFill.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
  //InFlateRect(Rect, -BevelExt, -BevelExt);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPanelFill.CreateBack(aValue:Boolean);
var
  b: TBitmap;
  tmpt:Boolean;
  r: TRect;
begin
  //if [csLoading, csDestroying]*ComponentState<>[] then exit;
  if not HandleAllocated then
    exit;

  tmpt:=GetTransparent;
  if ((GetFillObject.Empty and not tmpt) or (tmpt and not ((GetBackFX.Enabled) and (BackFXPass)))) then
    begin
      if FBack <> nil then FreeAndNil(FBack);
      NeedInvalidate:=True;
      exit;
    end;

  if FBack=nil then
    FBack:=TBitmap.Create;

  if (not aValue) and (GetFillObject.Style<>sfGradient) then
    if LMDRectInRect(ClientRect, Rect(0,0,FBack.Width, FBack.Height)) then exit;

  FBack.Width := Width;
  FBack.Height:= Height;

  if tmpt and BackFXPass then
  begin
    FreeAndNil(FBack);
    if BackBitmap = nil then
    begin
      {NeedInvalidate := true;}
      exit;
    end;
    b := TBitmap.Create;
    try
      b.Width := Width+1;
      b.Height := Height+1;
      //get the background image
      r := ClientRect;
      BackDrawArea (b.Canvas, r, Point (0,0), 0);
      FBack := TBitmap.Create;
      FBack.Assign (b);
    finally
      b.Free;
    end
  end
  else
    GetFillObject.FillCanvas(FBack.Canvas, Rect(0,0, FBack.Width, FBack.Height), Color);

  FBack.PixelFormat := pf24Bit;
  GetBackFX.Draw (FBack);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPanelFill.DrawBack(Canvas:TCanvas; aRect:TRect);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPanelFill.DrawCaption(aRect:TRect; aAlignment:TLMDAlignment);
var
  flags:LongInt;
begin
  Canvas.Brush.Style:=bsClear;
  Canvas.Brush.Color:=Color;
  Canvas.Font:=GetFont;
  flags:=0;
  flags:=DrawTextBiDiModeFlags(flags);
  if (GetFont3D is TLMDFXCaption) and (TLMDFXCaption(GetFont3D).Angle>0) and not (FAlignment=agTopLeft) then
    aRect:=LMDAlignTextRect(FAlignment, Caption, GetFont3D, aRect, GetFont,
                            False, False, flags);
  flags:=flags or DT_EXPANDTABS or TLMDAlignFlags[aAlignment] or
         DT_SINGLELINE or DT_NOPREFIX;
  LMDDrawTextExt(Canvas, Caption, GetFont3D, aRect, flags, [TLMDDrawTextStyle(Enabled), dtClip],
                 nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPanelFill.GetIMLChange(Sender:TObject);
begin
  if not IMLEmpty then
    LMDIMLItemBitmap(ImageList, ListIndex, ImageIndex, FFillObject.ListBitmap)
  else
    FFillObject.ListBitmap:=nil;
  GetChange(FFillObject);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPanelFill.GetChange(Sender:TObject);
begin
  //inherited GetChange(Sender);
  if IsUpdating then exit;
  if sender=FFontFx then
    begin
      Canvas.Font:=Font;
      if (FontFx.Angle<>0) and not LMDIsTrueTypeFontCheck(Canvas) then
      if Sender=Font then FontFx.Angle:=0 else Font.Name:=LMD_DEFAULTFONT;
      BackUpdate;
      exit;
    end;
  if [csLoading, csReading, csDestroying]*ComponentState<>[] then exit;
  CreateBack(true);
  if (sender=Bevel) then
    begin
      Perform(CM_LMDBEVELCHANGED,0,0);
      NotifyControls(CM_ColorChanged);
    end
  else
    begin
      Invalidate;
      if (sender=FillObject) or (sender=GetBackFX) then
        BackUpdate;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPanelFill.GetEmpty;
begin
  result:=inherited GetEmpty and (Caption='') and GetFillObject.Empty;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPanelFill.GetPalette: HPALETTE;
begin
  result:=GetFillObject.Palette;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPanelFill.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) and CheckOptimized then
    BackUpdate;
  if BackFxPass then
    DoForwardBackFX
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPanelFill.Paint;
var
  aRect:TRect;
begin
  if (csLoading in ComponentState) or
     ((Owner is TCustomForm) and not Showing) then exit;

  FillControl;

  if GetEmpty then
    begin
      if csDesigning in ComponentState then DrawDashedFrame;
      exit;
    end;

  if (not Flat or Entered) or
     ((FaceController <> nil) and (FaceController.GetBevel (self) <> nil)) then
    aRect:=GetBevel.PaintBevel(Canvas, GetClientRect, TransparentBorder)
  else
    aRect := GetClientRect;
  DrawCaption(aRect, Alignment);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPanelFill.Resize;
begin
  inherited Resize;
  if FillObject.Style=sfGradient then NotifyControls(CM_ColorChanged);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPanelFill.MouseEnter;
begin
  inherited MouseEnter;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomPanelFill.MouseExit;
begin
  inherited MouseExit;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPanelFill.GetFillObject: TLMDFillObject;
begin
  result := inherited GetFillObject;
  if result = nil then result := FFillObject;
end;

{------------------------------------------------------------------------------}
function TLMDCustomPanelFill.GetFont3D      : TLMD3DCaption;
begin
  result := inherited GetFont3D;
  if result = nil then result := FFontFX;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDCustomPanelFill.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  ControlStyle:=ControlStyle + [csSetCaption];
  FTransparentBorder:=False;
  FFillObject:=TLMDFillObject.Create;
  FFillObject.OnChange:=GetChange;
  FAlignment:=agCenter;
  FFontFx:=TLMDFxCaption.Create;
  FFontFx.OnChange:=GetChange;
end;

{------------------------------------------------------------------------------}
Destructor TLMDCustomPanelFill.Destroy;
begin
  FFontFx.OnChange:=nil;
  FFillObject.OnChange:=nil;
  FreeAndNil(FFontFx);
  FreeAndNil(FFillObject);
  inherited Destroy;
end;

end.
