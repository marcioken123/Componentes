unit LMDBarHTMLLabel;
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

LMDBarHTML unit
---------------
Simple HTML label control.

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}
interface

uses
  Windows, Classes, SysUtils, Graphics, Controls, StdCtrls, Messages,
  LMDClass, LMDBarBase, LMDBaseGraphicControl, LMDHTMLUnit,
  LMDGraph, LMDTypes;

type
  TLMDBarHTMLString=type String;
  TLMDBarHTMLLabel=class(TLMDBaseGraphicControl)
  private
    FAlreadyInSetBounds: Boolean;
    FBorder: TLMDBorderStyle;
    FBorderWidth: Byte;
    FCaption : TLMDBarHTMLString;
    FLineGap : integer;
    FRender: TLMDHTMLRender;

    procedure SetBorder(const Value: TLMDBorderStyle);
    procedure SetBorderWidth(const Value: Byte);
    procedure SetCaption(const Value: TLMDBarHTMLString);
    procedure SetLineGap(const Value: integer);
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    procedure AdjustBounds;
    procedure AdjustSize; override;
    procedure DoUpdate; virtual;
    procedure Loaded; override;
    procedure Paint; override;
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getLMDPackage:TLMDPackageID; override;
  published
    property About;
    property AutoSize;
    property Align;
    property Border: TLMDBorderStyle read FBorder write SetBorder default lsNone;
    property BorderWidth: Byte read FBorderWidth write SetBorderWidth default 0;
    property Caption: TLMDBarHTMLString read FCaption write SetCaption;
    property LineGap: integer read FLineGap write SetLineGap default 0;

    property Transparent;
    property OnMouseEnter;
    property OnMouseExit;

    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
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

  end;

implementation

uses
  LMDGraphUtils, Types
  {$IFDEF LMD_DEBUGTRACE},dialogs;{$I C2.INC}{$ELSE};{$ENDIF}

{ *********************** TLMDBarHTMLLabel ************************************}
{ ----------------------------- private -------------------------------------- }
procedure TLMDBarHTMLLabel.SetBorder(const Value: TLMDBorderStyle);
begin
  if Value <> FBorder then
    begin
      FBorder := Value;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBarHTMLLabel.SetBorderWidth(const Value: Byte);
begin
  if FBorderWidth <> Value then
    begin
      FBorderWidth := Value;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBarHTMLLabel.SetCaption(const Value: TLMDBarHTMLString);
begin
  if FCaption <> Value then
    begin
      FCaption := Value;
      DoUpdate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBarHTMLLabel.SetLineGap(const Value: integer);
begin
  if FLineGap <> Value then
    begin
      FLineGap := Value;
      DoUpdate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBarHTMLLabel.CMFontChanged(var Message: TMessage);
begin
  DoUpdate;
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDBarHTMLLabel.AdjustBounds;
begin
  inherited;
  if (not (csLoading in ComponentState)) and AutoSize then
    begin
      if (FRender.Data.TextSize.CX = 0) and (not FAlreadyInSetBounds) then
        DoUpdate;
      SetBounds(Left, Top, FRender.Data.TextSize.CX + FBorderWidth * 2, FRender.Data.TextSize.CY + FBorderWidth * 2);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBarHTMLLabel.AdjustSize;
begin
  inherited;
  DoUpdate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBarHTMLLabel.DoUpdate;
begin
  if (FRender = nil) or (csLoading in ComponentState) then
    exit;
  FRender.Data.DefaultStyle := Font.Style;
  FRender.Data.DefaultFont  := Font.Name;
  FRender.Data.Charset      := Font.Charset;
  FRender.Data.DefaultColor := Font.Color;
  FRender.Data.DefaultHeight:= Font.Height;
  FRender.Data.LineGap  := LineGap;
  FRender.PrepareText(Caption, Width - FBorderWidth * 2, True);
  FAlreadyInSetBounds := True;
  AdjustBounds;
  FAlreadyInSetBounds := False;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBarHTMLLabel.Loaded;
begin
  inherited;
  DoUpdate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBarHTMLLabel.Paint;
var
  R, RB:TRect;
  Bmp: TBitmap;
begin
  if not Transparent then
    FillControl;

  if (csDesigning in ComponentState) then
    if (Caption='') and (FBorder=lsNone) then
      begin
        DrawDashedFrame;
        exit;
      end;

  R := ClientRect;
  LMDDrawStdFrame(Canvas, R, FBorder,0);
  InflateRect(R, -FBorderWidth, -FBorderWidth);

  with Canvas do
    begin
      Brush.Style := bsClear;
      Font := self.Font;
      Bmp := TBitmap.Create;
      try
        Bmp.Handle := CreateCompatibleBitmap(Canvas.Handle, R.Right - R.Left, R.Bottom - R.Top);
        BitBlt(Bmp.Canvas.Handle, 0, 0, R.Right - R.Left, R.Bottom - R.Top, Canvas.Handle, R.Left, R.Top, SRCCOPY);
        RB := R;
        OffsetRect(RB, -RB.Left, -RB.Top);
        FRender.DrawText(Bmp.Canvas, Point(0, 0), RB, clNone);
        BitBlt(Canvas.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
      finally
        Bmp.Free;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBarHTMLLabel.Resize;
begin
  inherited;
  DoUpdate;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDBarHTMLLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRender := TLMDHTMLRender.Create;
  FAlreadyInSetBounds := False;

  Width:=100;
  Height:=100;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDBarHTMLLabel.Destroy;
begin
  FreeAndNil(FRender);
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDBarHTMLLabel.GetLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_BAR
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C3.INC}
{$ENDIF}

end.
