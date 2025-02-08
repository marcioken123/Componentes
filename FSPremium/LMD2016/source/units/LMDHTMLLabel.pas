unit LMDHTMLLabel;
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

LMDHTMLLabel unit (DD, RM, VB)
------------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, SysUtils, Types, Graphics, Controls, StdCtrls, Messages,
  Themes, LMDGraphicControl, LMDBase, LMDClass, LMDHTMLUnit, LMDTypes;

type
  TLMDCustomHTMLLabel = class(TLMDGraphicControl)
  private
    FAlignment: TAlignment;
    FAlreadyInSetBounds: Boolean;
    FCaption : TLMDHTMLString;
    FCursor: TCursor;
    FLineGap : integer;
    FOnLinkClick: TLMDHTMLLinkClickEvent;
    FOnImageNeeded: TLMDHTMLImageNeededEvent;
    FOnVariableNeeded: TLMDHTMLVariableNeededEvent;
    FRender: TLMDHTMLRender;
    FTextLayout: TTextLayout;
    FWordWrap: boolean;
    FUpdating: boolean;
    FOnAdjustControlPosition: TLMDHTMLControlPositionNeededEvent;
    FOnControlCreated: TLMDHTMLControlCreatedEvent;
    FOnTagFound: TLMDHTMLTagFoundEvent;

    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    {$IFDEF LMDCOMP12}
    procedure CMThemeChanged(var Message: TMessage); message CM_THEMECHANGED;
    {$ENDIF}
    procedure SetAlignment(const Value: TAlignment);
    procedure SetCaption(const Value: TLMDHTMLString);
    procedure SetLineGap(const Value: integer);
    procedure SetWordWrap(AValue : Boolean);
    procedure SetTextLayout(const Value: TTextLayout);
  protected
    procedure AdjustBounds;
    procedure AdjustSize; override;
    function  CalcTextRect: TRect;
    procedure DoUpdate; virtual;
    function  GetThemedTextColor: TColor;
    function  GetEmpty:Boolean; override;
    procedure MouseEnter; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseExit; override;
    procedure Loaded; override;
    procedure Resize; override;
    procedure Paint; override;
    procedure TriggerLinkClickEvent(HRef : TLMDString);
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; Image : TPicture);
    procedure TriggerVariableNeededEvent(Sender : TObject; const aVar : TLMDString; var aVal: TLMDString);
    procedure TriggerAdjustControlPositionEvent(Sender : TObject; aControl: TControl; aData: Pointer; var X: integer; var Y: integer);
    procedure TriggerControlCreatedEvent(Sender : TObject; aControl: TControl);
    procedure TriggerTagFoundEvent(Sender : TObject; var Tag: TLMDString;  var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing:boolean; aSupported: boolean);
    property  Alignment: TAlignment read FAlignment write SetAlignment;
    property  Caption: TLMDHTMLString read FCaption write SetCaption;
    property  Layout: TTextLayout read FTextLayout write SetTextLayout;
    property  LineGap: integer read FLineGap write SetLineGap default 0;
    property  WordWrap: boolean read FWordWrap write SetWordWrap default true;
  public
    constructor Create(AOwner: TComponent); override;
    procedure  Click; override;
    destructor Destroy; override;
  published
    property About;
    property OnImageNeeded : TLMDHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnVariableNeeded : TLMDHTMLVariableNeededEvent read FOnVariableNeeded write FOnVariableNeeded;
    property OnLinkClick : TLMDHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnControlCreated: TLMDHTMLControlCreatedEvent read FOnControlCreated write FOnControlCreated;
    property OnAdjustControlPosition: TLMDHTMLControlPositionNeededEvent read FOnAdjustControlPosition write FOnAdjustControlPosition;
    property OnTagFound: TLMDHTMLTagFoundEvent read FOnTagFound write FOnTagFound;
  end;

  TLMDHTMLLabel=class(TLMDCustomHTMLLabel)
  published
    property Align;
    property AutoSize;
    property Bevel;

    property Alignment;
    property Caption;
    property Layout;
    property LineGap;
    property WordWrap;

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

    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;

implementation

uses
  Forms, LMDGraphUtils, LMDProcs;

{ *********************** TLMDCustomHTMLLabel ***************************************}
{ ----------------------------- private -------------------------------------- }
procedure TLMDCustomHTMLLabel.CMFontChanged(var Message: TMessage);
begin
  DoUpdate;
end;

{$IFDEF LMDCOMP12}
procedure TLMDCustomHTMLLabel.CMThemeChanged(var Message: TMessage);
begin
  inherited;
  DoUpdate;
end;
{$ENDIF}

{------------------------------------------------------------------------------}
procedure TLMDCustomHTMLLabel.SetAlignment(const Value: TAlignment);
begin
  if  FAlignment <> Value then
    begin
      FAlignment := Value;
      Invalidate;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.SetCaption(const Value: TLMDHTMLString);
begin
  if FCaption<>Value then
    begin
      FCaption := Value;
      DoUpdate;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.SetLineGap(const Value: integer);
begin
  if FLineGap <> Value then
    begin
      FLineGap := Value;
      DoUpdate;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.SetWordWrap(AValue: Boolean);
begin
  if FWordWrap <> AValue then
    begin
      FWordWrap := AValue;
      DoUpdate;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.SetTextLayout(const Value: TTextLayout);
begin
  if FTextLayout <> Value then
    begin
      FTextLayout := Value;
      DoUpdate;
    end;
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDCustomHTMLLabel.AdjustBounds;
var
  Bw: integer;
begin
  if (not (csLoading in ComponentState)) and AutoSize then
    begin
      if (FRender.Data.TextSize.CX = 0) and (not FAlreadyInSetBounds) then
        DoUpdate;
      Bw := Bevel.BorderWidth + Bevel.WidthInner + Bevel.WidthOuter + Bevel.BorderInnerWidth;
      SetBounds(Left, Top, FRender.Data.TextSize.CX +  Bw * 2, FRender.Data.TextSize.CY + Bw * 2);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.AdjustSize;
begin
  inherited;
  DoUpdate;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomHTMLLabel.CalcTextRect: TRect;
begin
  if Layout = tlCenter then
    LMDCenterRects(ClientWidth, ClientWidth, FRender.Data.TextSize.cy, ClientHeight, Result)
  else
    if Layout = tlBottom then
      begin
        Result := ClientRect;
        Result.Top := Result.Bottom - 1 - FRender.Data.TextSize.cy;
      end
    else
      Result := ClientRect;
  if Alignment = taRightJustify then
    begin
      Result.Right := ClientWidth;
      Result.Left := Result.Right - FRender.Data.TextSize.cx;
    end
  else
    if Alignment = taCenter then
      begin
        Result.Left := (ClientWidth - FRender.Data.TextSize.cx) div 2;
        Result.Right := Result.Left + FRender.Data.TextSize.cx;
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.Click;
var
  P : TPoint;
  R : TRect;
  href : TLMDString;
  Bw: integer;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  R := CalcTextRect;
  Bw := Bevel.BorderWidth + Bevel.WidthInner + Bevel.WidthOuter + Bevel.BorderInnerWidth;
  dec(P.x, R.Left + Bw);
  dec(P.y, R.Top + Bw);
  if FRender.IsCursorOverLink(P, Point(0, 0), R, href) then
     TriggerLinkClickEvent(href)
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.DoUpdate;
var
  Bw: integer;
begin
  if FUpdating or (FRender = nil) or ([csLoading, csReading, csDestroying] *
     ComponentState<>[]) then
    Exit;

  FUpdating := True;
  Bw        := Bevel.BorderWidth + Bevel.WidthInner + Bevel.WidthOuter +
               Bevel.BorderInnerWidth;

  FRender.Data.DefaultStyle := Font.Style;
  FRender.Data.DefaultFont  := Font.Name;
  FRender.Data.Charset      := Font.Charset;
  FRender.Data.DefaultColor := GetThemedTextColor; // Font.Color;
  FRender.Data.DefaultHeight:= Font.Height;
  FRender.Data.LineGap      := LineGap;

  if WordWrap then
  begin
    FRender.PrepareText(Caption, ClientWidth - Bw * 2, True);
    FAlreadyInSetBounds := True;
    AdjustBounds;
  end
  else
  begin
    FRender.PrepareText(Caption, ClientWidth - Bw * 2, False);
    FAlreadyInSetBounds := True;
    if AutoSize then
      AdjustBounds;
  end;

  FAlreadyInSetBounds := False;
  Invalidate;
  FUpdating := false;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomHTMLLabel.GetEmpty:Boolean;
begin
  result:=(FCaption='') and (Bevel.BevelExtend=0);
end;

function TLMDCustomHTMLLabel.GetThemedTextColor: TColor;
{$IFDEF LMDCOMP16}
const
  C_STATES: array[Boolean] of TThemedTextLabel = (ttlTextLabelDisabled,
                                                  ttlTextLabelNormal);
var
  dtls: TThemedElementDetails;
{$ENDIF}
begin
  {$IFDEF LMDCOMP16}
  if (UseThemeMode = ttmPlatform) and StyleServices.Enabled and
     TStyleManager.IsCustomStyleActive then
  begin
    dtls := StyleServices.GetElementDetails(C_STATES[Enabled]);
    if not StyleServices.GetElementColor(dtls, ecTextColor, Result) then
      Result := clWindowText;
  end
  else
  {$ENDIF}
    Result := Font.Color;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.MouseEnter;
begin
  FCursor := Screen.Cursor;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.MouseExit;
begin
  inherited;
  Screen.Cursor := FCursor;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.MouseMove(Shift: TShiftState; X, Y: Integer);
var href : TLMDString;
    R    : TRect;
    Bw: integer;
begin
  R := CalcTextRect;
  Bw := Bevel.BorderWidth + Bevel.WidthInner + Bevel.WidthOuter + Bevel.BorderInnerWidth;
  if FRender.IsCursorOverLink(Point(X - R.Left - Bw, Y - R.Top - Bw), Point(0, 0), R, href) then
     Screen.Cursor := crHandPoint
  else
     Screen.Cursor := inherited Cursor;
  inherited MouseMove(Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.Loaded;
begin
  inherited;
  DoUpdate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.Resize;
begin
  inherited;
  DoUpdate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.Paint;
var
  R, RB:TRect;
  Bmp: TBitmap;
  Bw: integer;
begin
  if not Transparent then
    FillControl;

  if GetEmpty then
    begin
      inherited Paint;
      exit;
    end;

  R := Bevel.PaintBevel(Canvas, ClientRect, Transparent);
  Bw := Bevel.BorderWidth + Bevel.WidthInner + Bevel.WidthOuter + Bevel.BorderInnerWidth;
  with Canvas do
    begin
      Brush.Style := bsClear;
      Font := self.Font;

      if Layout = tlCenter then
        begin
          LMDCenterRects(ClientWidth - Bw * 2, ClientWidth - Bw * 2, FRender.Data.TextSize.cy, ClientHeight - Bw * 2, R);
          //LMDCenterRects(BeveledRect.Left ClientWidth - Bevel.Bw * 2, ClientWidth - Bw * 2, FRender.Data.TextSize.cy, ClientHeight - Bw * 2, R);
          OffsetRect(R, Bw, Bw);
        end
      else
        if Layout = tlBottom then
          begin
            R := ClientRect;
            InflateRect(R, -Bw, -Bw);
            R.Top := R.Bottom - 1 - FRender.Data.TextSize.cy;
          end
        else
          begin
            R := ClientRect;
            InflateRect(R, -Bw, -Bw);
          end;
      if Alignment = taRightJustify then
        begin
          R.Right := ClientWidth - Bw;
          R.Left := R.Right - FRender.Data.TextSize.cx;
        end
      else
        if Alignment = taCenter then
          begin
            R.Left := (ClientWidth - FRender.Data.TextSize.cx) div 2;
            R.Right := R.Left + FRender.Data.TextSize.cx;
          end;
      Bmp := TBitmap.Create;
      try
        Bmp.Handle := CreateCompatibleBitmap(Canvas.Handle, R.Right - R.Left, R.Bottom - R.Top);
        bitblt(Bmp.Canvas.Handle, 0, 0, R.Right - R.Left, R.Bottom - R.Top, Canvas.Handle, R.Left, R.Top, SRCCOPY);
        RB := R;
        OffsetRect(RB, -RB.Left, -RB.Top);
        Bmp.Canvas.Brush.Color := Color;
        if Enabled then
          FRender.DrawText(Bmp.Canvas, Point(0, 0), RB, clNone)
        else
          FRender.DrawTextEx(Bmp.Canvas, Point(0, 0), RB, True, clGrayText, clNone, clNone, clNone, clBlack);
        bitblt(Canvas.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
      finally
        Bmp.Free;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.TriggerImageNeededEvent(Sender: TObject;
  Src: TLMDString; Image: TPicture);
begin
  if (Assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src, Image);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.TriggerLinkClickEvent(HRef: TLMDString);
begin
  if Assigned(FOnLinkClick) then
    FOnLinkClick(Self, HRef);
end;

{----------------------------- public -----------------------------------------}
constructor TLMDCustomHTMLLabel.Create(AOwner: TComponent);
begin
  inherited;
  FRender := TLMDHTMLRender.Create;
  FRender.OnImageNeededEx := TriggerImageNeededEvent;
  FRender.OnVariableNeeded := TriggerVariableNeededEvent;
  FRender.OnControlCreated := TriggerControlCreatedEvent;
  FRender.OnTagFound := TriggerTagFoundEvent;
  FRender.OnAdjustControlPosition := TriggerAdjustControlPositionEvent;
  FRender.Control := Self;
  FWordWrap := true;
  FAlreadyInSetBounds := False;
  FUpdating := false;

  Width:=100;
  Height:=100;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomHTMLLabel.Destroy;
begin
  FreeAndNil(FRender);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.TriggerVariableNeededEvent(Sender: TObject; const aVar: TLMDString;
  var aVal: TLMDString);
begin
  if Assigned(FOnVariableNeeded) then
    FOnVariableNeeded(Self, aVar, aVal);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.TriggerControlCreatedEvent(Sender : TObject; aControl: TControl);
begin
  if Assigned(FOnControlCreated) then
    FOnControlCreated(Self, aControl);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.TriggerAdjustControlPositionEvent(Sender : TObject; aControl: TControl; aData: Pointer; var X: integer; var Y: integer);
begin
  if Assigned(FOnAdjustControlPosition) then
    FOnAdjustControlPosition(Self, aControl, aData, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomHTMLLabel.TriggerTagFoundEvent(Sender: TObject;
  var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing,
  aSupported: boolean);
begin
  if Assigned(FOnTagFound) then
    FOnTagFound(Self, Tag, Item, Params, aClosing, aSupported);
end;

end.
