unit LMDCustomLabelFill;
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

LMDCustomLabelFill unit (??)
----------------------------

custom label with filled letters

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Classes, Graphics, Controls,
  LMDGraph, LMDFillObject, LMDCustomLabel;

type
  {------------------------ TLMDCustomLabelFill -------------------------------}
  TLMDCustomLabelFill = class(TLMDCustomLabel)
  private
    FBrushBack:TColor;
    FFillObject: TLMDFillObject;
//    FTransparent:Boolean;
    procedure SetBrushBack(aValue:TColor);
    procedure SetFillObject(aValue:TLMDFillObject);
//    procedure SetTransparent(aValue:Boolean);
    procedure CMEnabledChanged(var Message: TMessage);message CM_ENABLEDCHANGED;
  protected
    procedure GetIMLChange(Sender:TObject); override;
    procedure GetChange(Sender: TObject);override;
    procedure Paint;override;
  public
    constructor Create(aOwner: TComponent);override;
    destructor Destroy;override;
  published
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property BrushBackColor: TColor read FBrushBack write SetBrushBack default clBtnFace;
    property FillObject: TLMDFillObject read FFillObject write SetFillObject;
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
    property FontFX;
    //property FontSmoothing;
    property MultiLine;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;

//    property Transparent:Boolean read FTransparent write SetTransparent default false;

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
  Types,
  LMDClass, LMDProcs, LMDGraphUtils, LMDBase, LMDCont, LMDCustomImageList;

{************************ class TLMDCustomLabelFill ***************************}
{------------------------- Private --------------------------------------------}
procedure TLMDCustomLabelFill.SetBrushBack(aValue:TColor);
begin
  if FBrushBack<>aValue then
    begin
      FBrushBack:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomLabelFill.SetFillObject(aValue:TLMDFillObject);
begin
  FFillObject.Assign(aValue);
end;

{------------------------------------------------------------------------------}
{procedure TLMDCustomLabelFill.SetTransparent(aValue:Boolean);
begin
  if FTransparent<>aValue then
    begin
      if aValue then
        ControlStyle:=ControlStyle-[csOpaque]
      else
        ControlStyle:=ControlStyle+[csOpaque];
      FTransparent:=aValue;
      GetChange(nil);
    end;
end;}

{------------------------------------------------------------------------------}
procedure TLMDCustomLabelFill.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  InvalidateControl;
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDCustomLabelFill.GetChange(Sender: TObject);
begin
  if csLoading in ComponentState then exit;
  inherited GetChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomLabelFill.GetIMLChange(Sender:TObject);
begin
  if not IMLEmpty then
    TLMDCustomImageList(ImageList).GetBitmapItem(ListIndex, ImageIndex, FFillObject.ListBitmap)
  else
    FFillObject.ListBitmap:=nil;
  if (csLoading in ComponentState) or Painting then exit;
  inherited GetIMLChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomLabelFill.Paint;
var
  FPaintCanvas, FBitmap: TBitmap;
  aRect, bRect: TRect;
  Flags: Word;
  Text:String;
begin
  if Painting or (csLoading in ComponentState) then exit;
  if FFillObject.Empty or not Enabled then
    begin
      inherited Paint;
      exit;
    end;
  Text:=GetLabelText;
  Painting:=True;
  try
     aRect:=GetClientRect;
     if not {F}Transparent then
       FillControl;

    aRect:=Bevel.PaintBevel(Canvas, ClientRect, (Bevel.BorderColor=Color) or Transparent);

    FPaintCanvas:=TBitmap.Create;
    with FPaintCanvas do
      try
//        PixelFormat:=pf24Bit;  // workarounds error with ATI drivers in 32bit mode
        LMDBmpCreateFromRect(FPaintCanvas, aRect, FBrushBack);
        PixelFormat:=pf24Bit;  // workarounds error with ATI drivers in 32bit mode
        bRect:=Rect(0,0, FPaintCanvas.Width, FPaintCanvas.Height);
        flags:=GetOptionsFlag;
        flags:=DrawTextBiDiModeFlags(flags);

        if not Autosize then
          if FontFx.Angle>0 then
            begin
              flags:=flags or DT_SINGLELINE;
              if not (Alignment=agTopLeft) then
              bRect:=LMDAlignTextRect(Alignment, Text, FontFx, bRect, Font,
                                  MultiLine, ShowAccelChar, flags)
            end
          else
            if not MultiLine then
              flags:=flags or DT_SINGLELINE
            else
              if not (Alignment in [agTopLeft, agTopCenter, agTopRight]) then
                bRect:=LMDAlignTextRect(Alignment, Text, FontFx, bRect, Font,
                                        MultiLine, ShowAccelChar, flags);
        flags:=flags or DT_EXPANDTABS or DT_WORDBREAK or TLMDAlignFlags[Alignment];
        if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;

        Canvas.Brush.Color:=Color;
        Canvas.Font:=self.Font;

        LMDDrawTextExt(Canvas, Text, FontFx, bRect, flags, [TLMDDrawTextStyle(Enabled)], nil);
        FBitmap:=TBitmap.Create;
        try
          bRect:=Rect(0,0, FPaintCanvas.Width, FPaintCanvas.Height);
          FBitmap.Width:=BRect.Right;
          FBitmap.Height:=bRect.Bottom;

          if FFillObject.Style=sfBrush then
            FFillObject.FillCanvas(FBitmap.Canvas, bRect, FBrushBack)
          else
            FFillObject.FillCanvas(FBitmap.Canvas, bRect, Font.Color);

          LMDMaskBmpDraw(Self.Canvas, aRect, FPaintCanvas, FBitmap, Font.Color, FBrushBack);

        finally
          FBitmap.Free;
        end;

      finally
        FPaintCanvas.Free;
      end;
  finally
    Painting:=False;
  end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDCustomLabelFill.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
//  DisableTransMode;
//  FTransparent:=False;
  FBrushBack:=clBtnFace;
  FFillObject:=TLMDFillObject.Create;
  FFillObject.OnChange:=GetChange;
  Painting:=True;
  Font.Name:=LMD_DEFAULTFONT;
  Font.Size:=28;
  Painting:=False;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomLabelFill.Destroy;
begin
  FFillObject.OnChange:=nil;
  FFillObject.Free;
  inherited Destroy;
end;

end.
