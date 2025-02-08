unit LMDHeader;
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

LMDHeader unit (JH)
-------------------

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Classes, Controls, Messages,
  LMDGraph, LMDCont, LMDCustomPanelFill, LMDCustomHeaderPanel, LMDCustomImageList,
  LMDBitmapList;

type
  TLMDHeader = class (TLMDCustomPanelFill)
  private
    FHeaderPanel: TLMDCustomHeaderPanel;
    FTextRect   : TRect;
    FOverText   : Boolean;
    FGlyph      : TBitmap;

    procedure SetHeaderPanel (aValue: TLMDCustomHeaderPanel);
    procedure WMMOUSEMOVE(var Message:TWMMouseMove); message WM_MOUSEMOVE;

  protected
    procedure DrawCaption(aRect: TRect; aAlignment: TLMDAlignment); override;
    procedure DoModeChange (Sender: TObject);
    procedure MouseMove (Shift: TShiftState;X: Integer; Y: Integer); override;
    procedure MouseExit; override;
    procedure Click; override;
    procedure Notification (AComponent: TComponent; Operation: TOperation); override;
    procedure TextEnter;
    procedure TextExit;
  public

    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetCaption (aCaption: String); overload;
    procedure SetCaption (aCaption: String; aGlyph: TBitmap); overload;
    procedure SetCaption (aCaption: String; anImageList: TImageList; anImageIndex: Integer); overload;
    procedure SetCaption (aCaption: String; anImageList: TLMDCustomImageList; anImageIndex, aListIndex: Integer); overload;
    procedure SetCaption (aCaption: String; aBitmapList: TLMDBitmapList; anImageIndex: Integer); overload;
  published
    property HeaderPanel: TLMDCustomHeaderPanel read FHeaderPanel write SetHeaderPanel;
    property Caption;
    property Flat;
    property BackFX;
    property Color;
    property FillObject;
    property Bevel;
    property Transparent;
    property Font;

     // V4 enhancements
    property Anchors;
    property AutoSize;
    property Constraints;
    property UseDockManager default false;
    property DockSite;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;

    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;

    Property About;
    property Align;

    property DragCursor;
    property DragMode;
    property Enabled;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
    property ThemeGlobalMode;
    property ThemeMode;
    end;

implementation
uses
  Types, TypInfo,
  LMDUtils, LMDGraphUtils, LMDProcs;

type
  TLMDHPCrack = class (TLMDCustomHeaderPanel)
  public
    property OnModeChange;
  end;

{ --------------------------------- private ---------------------------------- }
procedure TLMDHeader.SetHeaderPanel (aValue: TLMDCustomHeaderPanel);
var
  M: TNotifyEvent;
begin
  if Assigned (FHeaderPanel) then

    TLMDHPCrack(FHeaderPanel).OnModeChange := nil;

  FHeaderPanel := aValue;
  if Assigned (FHeaderPanel) then
    begin
      M := self.DoModeChange;

      TLMDHPCrack(FHeaderPanel).OnModeChange := M;

      DoModeChange (self); //update ourselves ...
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeader.WMMOUSEMOVE(var Message:TWMMouseMove);
begin
  inherited;

  if PtInRect (FTextRect, Point (Message.XPos, Message.YPos)) then
    TextEnter
  else
  if FOverText then
    TextExit;
end;

{-------------------------------- protected -----------------------------------}
procedure TLMDHeader.DrawCaption(aRect:TRect; aAlignment:TLMDAlignment);
const
  arrowSize = 3;
var
  flags:LongInt;
begin
  Canvas.Brush.Style:=bsClear;
  Canvas.Brush.Color:=Color;
  Canvas.Font:=Font;
  flags:=0;
  flags:=DrawTextBiDiModeFlags(flags);

  InflateRect (aRect, -1, -1);

  Canvas.Draw (aRect.Right -  FGlyph.Width - 1, aRect.Top, FGlyph);

  LMDDrawTextCalcExt (Canvas, Caption, FontFx, aRect, Font, false, false, 1, 0);

  if (FontFx.Angle>0) and not (Alignment=agTopLeft) then
    aRect:=LMDAlignTextRect(Alignment, Caption, FontFx, aRect, Font,
                            False, False, flags);
  flags:=flags or DT_EXPANDTABS or TLMDAlignFlags[aAlignment] or
         DT_SINGLELINE or DT_NOPREFIX;
  LMDDrawTextExt(Canvas, Caption, FontFx, aRect, flags, [TLMDDrawTextStyle(true), dtClip],
                 nil);

  if Enabled and Assigned(FHeaderPanel) then
    begin
      if FHeaderPanel.UnPinned then
        begin
          LMDDrawTriangle (Canvas, aRect.Right, aRect.Bottom - arrowSize * 2, arrowSize, Font.Color, true, true);
          inc (aRect.Right, arrowSize * 4);
          FTextRect := aRect;
          if HeaderPanel.Visible then
            begin
              with FTextRect do
                begin
                  Canvas.Pen.Color := clBlack;
                  Canvas.MoveTo (Left, Bottom);
                  Canvas.LineTo (Left, Top);
                  Canvas.LineTo (Right, Top);

                  Canvas.Pen.Color := clWhite;
                  Canvas.LineTo (Right, Bottom);
                  Canvas.LineTo (Left, Bottom);
                end;
            end
          else
            if FOverText then
              LMDDrawStdFrame (Canvas, FTextRect, lsWindowBorder, 0);
        end;
    end;
  FTextRect := aRect;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeader.DoModeChange (Sender: TObject);
begin
  Enabled := FHeaderPanel.UnPinned;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeader.MouseMove (Shift: TShiftState;X: Integer; Y: Integer);
begin
  inherited MouseMove (Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeader.MouseExit;
begin
  inherited MouseExit;
  if FOverText then TextExit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeader.Click;
begin
  inherited;
  if FOverText then
    if Assigned (FHeaderPanel) then
      if not FHeaderPanel.Visible then
        begin
          FHeaderPanel.Open;
          Invalidate;
        end
{      else  removed Aug 02, by JH -> will be done automatically, because of
                                      click outside header panel
        begin
          FHeaderPanel.Close;
          Invalidate;
        end;}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeader.TextEnter;
begin
  if FOverText then exit;
  FOverText := true;

  if Assigned (FHeaderPanel) then
    begin
      if (FHeaderPanel.UnPinned) and FHeaderPanel.Visible then exit;
      Invalidate;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeader.TextExit;
begin
  FOverText := false;

{  if Assigned (FHeaderPanel) then
    if FHeaderPanel.UnPinned then exit;}

  Invalidate;
end;

{ --------------------------------- public ----------------------------------- }
procedure TLMDHeader.Notification (AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification (AComponent, Operation);
  if (AComponent = FHeaderPanel) and (Operation = opRemove) then HeaderPanel := nil;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDHeader.Create(aOwner: TComponent);
begin
  inherited Create (aOwner);
  FGlyph := TBitmap.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDHeader.Destroy;
begin
  if Assigned (FGlyph) then
    FGlyph.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeader.SetCaption (aCaption: String);
begin
  Caption := aCaption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeader.SetCaption (aCaption: String; aGlyph: TBitmap);
begin
  SetCaption (aCaption);
  FGlyph.Assign (aGlyph);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeader.SetCaption (aCaption: String; anImageList: TImageList; anImageIndex: Integer);
begin
  anImageList.GetBitmap (anImageIndex, FGlyph);
  SetCaption (aCaption);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeader.SetCaption (aCaption: String; anImageList: TLMDCustomImageList; anImageIndex, aListIndex: Integer);
begin
  anImageList.GetBitmapItem (aListIndex, anImageIndex, FGlyph);
  SetCaption (aCaption);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeader.SetCaption (aCaption: String; aBitmapList: TLMDBitmapList; anImageIndex: Integer);
begin
  SetCaption (aCaption, aBitmapList, 0, anImageIndex);
end;

end.
