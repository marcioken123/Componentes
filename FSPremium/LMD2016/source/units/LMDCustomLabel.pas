unit LMDCustomLabel;
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

LMDCustomLabel unit (??)
------------------------

custom label control

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Messages, Classes, Controls,
  LMDGraph, LMDBevel, LMDFXCaption, LMDBaseLabel;

type
  {-------------------TLMDCustomLabel------------------------------------------}
  TLMDCustomLabel=class(TLMDBaseLabel)
  private
    FBevel:TLMDBevel;
    FFontFx:TLMDFxCaption;
    procedure SetBevel(aValue:TLMDBevel);
    procedure SetFontFx(aValue:TLMDFxCaption);
    procedure CMFontChanged(var Message:TMessage);message CM_FONTCHANGED;
  protected
    procedure FontChange(Sender:TObject);override;
    function GetBevelExtend:Integer;
    procedure GetChange(Sender:TObject);override;
    function  GetEmpty:Boolean;override;
    function GetStatusControl: Boolean;override;    
    procedure Paint;Override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure CorrectBounds;override;
  published
    property Bevel:TLMDBevel read FBevel write SetBevel;
    property FontFX:TLMDFxCaption read FFontFx write SetFontFx;

    property About;
    property Align;
    property Alignment;
    property AutoSize;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property MultiLine;
    property Options;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Transparent;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    {3.0}
    property OnMouseEnter;
    property OnMouseExit;
    {---}
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

    {4.0}
    //properties
    property Anchors;
    property BiDiMode;
    property DragKind;
    property Constraints;
    property ParentBiDiMode;
    //events
    property OnEndDock;
    property OnStartDock;

    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;

implementation
uses
  Windows, Graphics, SysUtils,
  LMDClass, LMDCustomStatusBar, LMDBase, LMDUtils, LMDGraphUtils;

{************************ Class TLMDCustomLabel *******************************}
{----------------------- Private ----------------------------------------------}
Procedure  TLMDCustomLabel.SetBevel(aValue:TLMDBevel);
begin
  FBevel.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomLabel.SetFontFx(aValue:TLMDFxCaption);
begin
  FFontFx.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomLabel.CMFontChanged(var Message: TMessage);
begin
  inherited;
  FontChange(Font);
end;

{----------------------- Protected --------------------------------------------}
procedure TLMDCustomLabel.CorrectBounds;
var
  aRect:TRect;
  flags:LongInt;

begin
  // 7.0.61: Align test
  if (Align=alNone) and AutoSize and not (csLoading in ComponentState) then
    begin
      aRect:=ClientRect;
      flags:=GetOptionsFlag;
      flags:=flags or DrawTextBiDiModeFlags(flags);
      if not Multiline then              //Added VB Oct 2009
        flags := flags or DT_SINGLELINE;

      LMDDrawTextCalcExt(Canvas, GetLabelText, FFontFx, aRect, Font, MultiLine,
                         ShowAccelChar, Bevel.BevelExtend, flags);

      if (Parent is TLMDCustomStatusBar) then
        aRect.Right := aRect.Right+TLMDCustomStatusBar(parent).GetControlGap;
      SetBounds(Left, Top, aRect.Right, aRect.Bottom);
    end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDCustomLabel.FontChange(Sender:TObject);
begin
  if csLoading in ComponentState then exit;
  if sender=Font then ParentFont:=False;
  Canvas.Font:=self.Font;
  if (FFontFx.Angle<>0) and not LMDIsTrueTypeFontCheck(Canvas) then
  if Sender=Font then
    FontFx.Angle:=0
  else
    if sender=FFontFx then
      begin
        Font.Name:=LMD_DEFAULTFONT;
        exit;
      end;
  GetChange(Sender);
end;

{------------------------------------------------------------------------------}
function TLMDCustomLabel.GetBevelExtend:Integer;
begin
  result:=FBevel.BevelExtend;
end;

{------------------------------------------------------------------------------}
Procedure TLMDCustomLabel.GetChange(Sender:TObject);
begin
  {if FAutoSize then} CorrectBounds;
  InvalidateControl;
end;

{------------------------------------------------------------------------------}
function TLMDCustomLabel.GetEmpty:Boolean;
begin
  result:=Transparent and (GetLabelText='') and (GetBevelExtend=0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomLabel.GetStatusControl: Boolean;
begin
  result:=true;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomLabel.Paint;
var
  aRect:TRect;
  flags :Word;
  extflags:TLMDDrawTextStyles;
  RgnRect:TRect;
  Text:String;
begin
  if Painting or (csLoading in ComponentState) then
    exit;

  if GetEmpty then
  begin
    inherited Paint;
    exit;
  end;

  Text:=GetLabelText;

  Painting:=True;
  try
    {check, if TransparentFlag is set - if not, fill the client-rect...}
    if not Transparent then FillControl;

    aRect:=GetClientRect;
    if (parent is TLMDCustomStatusBar) then
      aRect.Left := aRect.Left+(parent as TLMDCustomStatusBar).GetControlGap;

    extflags:=[TLMDDrawTextStyle(Enabled)];

    {If Bevel-Settings - draw them!}
    if Bevel.BevelExtend<>0 then
      begin
        aRect:=Bevel.PaintBevel(Canvas, aRect, (Bevel.BorderColor=Color) or Transparent);
       {Clipping Region}
        with aRect do RgnRect:=Bounds(Self.Left+Left,Self.Top+Top, Right-Left, Bottom-Top);
        extflags:=extflags+[dtClip];
      end;

    flags:=0;
    flags:=DrawTextBiDiModeFlags(flags);
    if not MultiLine then
      flags:=flags or DT_SINGLELINE;

    if not AutoSize then
      if FFontFx.Angle>0 then
        begin
          //flags:=flags or DT_SINGLELINE;  //VB Oct 2009 now we support angles for multiline text
          if not (Alignment=agTopLeft) then
            aRect:=LMDAlignTextRect(Alignment, Text, FFontFx, aRect, Font,
                                    MultiLine, ShowAccelChar, flags)
        end
      else
        begin
          if (FontFX.Tracing > 0) or
             (FontFX.Tracing = 0) and
               (not (Alignment in [agTopLeft, agTopCenter, agTopRight])) then
            aRect:=LMDAlignTextRect(Alignment, Text, FFontFx, aRect, Font,
                                    MultiLine, ShowAccelChar, flags);
        end;
    {Flags for DrawText}
    flags := flags or DT_EXPANDTABS or DT_WORDBREAK or
             TLMDAlignFlags[Alignment] or GetOptionsFlag;
    if not ShowAccelChar then
      Flags := Flags or DT_NOPREFIX;

    Canvas.Brush.Color := Color;
    Canvas.Font.Color  := GetThemedTextColor; // Was Font.Color;

    if FTwinkleFlag then
      LMDDrawTextExt(Canvas, Text, FFontFX, aRect, flags,
                    extflags, @RgnRect)
    else
      if TwinkleColor <> clNone then
      begin
        Canvas.Font.Color := TwinkleColor;
        LMDDrawTextExt(Canvas, Text, FFontFX, aRect, flags,
                       extflags, @RgnRect)

      end;
  finally
    Painting := False;
  end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDCustomLabel.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FBevel:=TLMDBevel.Create;
  FBevel.OnChange:=GetChange;
  FFontFx:=TLMDFxCaption.Create;
  FFontFx.OnChange:=FontChange;
end;

{------------------------------------------------------------------------------}
Destructor TLMDCustomLabel.Destroy;
begin
  FBevel.OnChange:=nil;
  FFontFx.OnChange:=nil;
  FreeAndNil(FFontFx);
  FreeAndNil(FBevel);
  inherited Destroy;
end;

end.
