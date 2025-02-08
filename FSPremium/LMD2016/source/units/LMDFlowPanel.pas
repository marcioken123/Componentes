unit LMDFlowPanel;
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

LMDFlowPanel unit (AH)
----------------------

Changes
-------
Release 10.08 (October 2010)
 - Initial Release

###############################################################################}

interface

uses
  ExtCtrls, Contnrs, Controls, Types, Classes, Messages, LMDCustomBevelPanel,
  LMDTypes, LMDGraph;

type
  TLMDFlowStyle = (lfsLeftRightTopBottom, lfsRightLeftTopBottom, lfsLeftRightBottomTop, lfsRightLeftBottomTop,
                lfsTopBottomLeftRight, lfsBottomTopLeftRight, lfsTopBottomRightLeft, lfsBottomTopRightLeft);

  TLMDCustomFlowPanel = class(TLMDCustomBevelPanel)
  private
    FControlList: TObjectList;
    FAutoWrap: Boolean;
    FFlowStyle: TLMDFlowStyle;
    FControlsPaddingX: Integer;
    FControlsPaddingY: Integer;
    FBorderMargins: TLMDMargins;
    FVerticalAlign: TLMDVerticalAlign;
    procedure SetAutoWrap(Value: Boolean);
    procedure SetLMDFlowStyle(Value: TLMDFlowStyle);
    {$IFDEF LMDCOMP11}
    procedure CMControlListChanging(var Message: TCMControlListChanging); message CM_CONTROLLISTCHANGING;
    {$ELSE}
    procedure CMControlListChange(var Message: TCMControlListChange); message CM_CONTROLLISTCHANGE;
    {$ENDIF}
    procedure SetBorderMargins(const Value: TLMDMargins);
    procedure SetControlsPaddingX(const Value: Integer);
    procedure SetControlsPaddingY(const Value: Integer);
    procedure SetVerticalAlign(const Value: TLMDVerticalAlign);
  protected
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    function CanResize(var ANewWidth, ANewHeight: Integer): Boolean; override;
    procedure DoBordersMarginChanged(Sender: TObject);
    procedure DoThemeChanged; override;

    property AutoWrap: Boolean read FAutoWrap write SetAutoWrap default True;
    property FlowStyle: TLMDFlowStyle read FFlowStyle write SetLMDFlowStyle default lfsLeftRightTopBottom;
    property BorderMargins: TLMDMargins read FBorderMargins write SetBorderMargins;
    property ControlsPaddingX: Integer read FControlsPaddingX write SetControlsPaddingX default 3;
    property ControlsPaddingY: Integer read FControlsPaddingY write SetControlsPaddingY default 3;
    property VerticalAlign: TLMDVerticalAlign read FVerticalAlign write SetVerticalAlign default vaTop;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function GetControlIndex(AControl: TControl): Integer;
    procedure SetControlIndex(AControl: TControl; Index: Integer);
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
  end;

  TLMDFlowPanel = class(TLMDCustomFlowPanel)
  public
    property DockManager;
  published
    property Align;
    property Bevel;
    property Anchors;
    property AutoSize;
    property AutoWrap;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property FlowStyle;
    property Locked;
    property BorderMargins;
    property ControlsPaddingX;
    property ControlsPaddingY;
    property ParentBiDiMode;
    property ParentBackground;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property ThemeMode;
    property ThemeGlobalMode;
    property VerticalAlign;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  TLMDFlowPanelSeparator = class (TWinControl)
  public
    constructor Create(AComponent: TComponent); override;
  end;

implementation

uses
  Graphics,
  SysUtils,
  LMDProcs;

{ TLMDFlowPanelSeparator }
constructor TLMDFlowPanelSeparator.Create(AComponent: TComponent);
begin
  inherited;
  Visible := True;
  Color := clBtnFace;
//  BevelInner := TBevelCut.bvRaised;
//  BevelOuter := TBevelCut.bvRaised;
  BevelKind := bkFlat;
end;
{ TLMDCustomFlowPanel }

procedure TLMDCustomFlowPanel.AlignControls(AControl: TControl; var Rect: TRect);
const
  XIncDir: array[TLMDFlowStyle] of Integer = (1, -1, 1, -1, 1, 1, -1, -1);
  YIncDir: array[TLMDFlowStyle] of Integer = (1, 1, -1, -1, 1, -1, 1, -1);
  YDeltaConst: array[TLMDFlowStyle] of Integer = (0, 0, -1, -1, 0, 0, 0, 0);
  XDeltaConst: array[TLMDFlowStyle] of Integer = (0, 0, 0, 0, 0, 0, -1, -1);
var
  I: Integer;
  MaxHeight, MaxWidth: Integer;
  YDelta, XDelta: Integer;
  Position: TPoint;
  Size: TSize;
  PrevControl, Control: TControl;

  LOriginalList: TList;

  type
    TOrderDirection = (odLMDLeftRight, odLMDRightLeft, odLMDTopBottom, odLMDBottomTop);

  function DiffPosition(AControl1, AControl2: TControl; AOrderDirection: TOrderDirection): Boolean;
  begin
    case AOrderDirection of
      odLMDLeftRight:
        Result := AControl1.Left < AControl2.Left;
      odLMDRightLeft:
        Result := AControl1.Left > AControl2.Left;
      odLMDTopBottom:
        Result := AControl1.Top < AControl2.Top;
      odLMDBottomTop:
        Result := AControl1.Top > AControl2.Top;
      else
        Result := false;
    end;
  end;

  function Reorder(AOriginalList: TList; AOrderDirection: TOrderDirection):TList;
  var
    n: Integer;
    LC1, LC2: TControl;
    LBool: boolean;
  begin
    Result := TList.Create;
    Result.Clear;
    while AOriginalList.Count > 0 do
      begin
        n := Result.Count;
        if n = 0 then
        begin
          Result.Add(AOriginalList[0]);
          AOriginalList.Delete(0);
        end
        else
        begin
          LC1 := TControl(AOriginalList[0]);
          LC2 := TControl(Result[n - 1]);
          LBool := DiffPosition(LC1, LC2, AOrderDirection);
          while LBool do
          begin
            Dec(n);
            if n = 0 then
              break;
            LC2 := TControl(Result[n - 1]);
            LBool := DiffPosition(LC1, LC2, AOrderDirection);
          end;
          Result.Insert(n, LC1);
          AOriginalList.Delete(0);
        end;
      end;
  end;

  procedure AlignVertical(ATop: Integer; AMaxHeight: Integer);
  var
    j: Integer;
  begin
    for j := 0 to ControlCount - 1 do
    begin
      case FVerticalAlign of
        vaMiddle:
          Controls[j].Top := ((AMaxHeight - Controls[j].Height) div 2) + ATop;
        vaBottom:
          Controls[j].Top := (AMaxHeight - Controls[j].Height) + ATop;
      end;
    end;
  end;

begin
  LOriginalList:= TList.Create;
  LOriginalList.Clear;
  for i := 0 to ControlCount - 1 do
    LOriginalList.Add({FControlList[I]}Controls[i]);

  case FFlowStyle of
    lfsLeftRightTopBottom:
      begin
        LOriginalList := Reorder(LOriginalList, odLMDLeftRight);
        LOriginalList := Reorder(LOriginalList, odLMDTopBottom);
      end;
    lfsRightLeftTopBottom:
      begin
        LOriginalList := Reorder(LOriginalList, odLMDRightLeft);
        LOriginalList := Reorder(LOriginalList, odLMDTopBottom);
      end;
    lfsLeftRightBottomTop:
      begin
        LOriginalList := Reorder(LOriginalList, odLMDLeftRight);
        LOriginalList := Reorder(LOriginalList, odLMDBottomTop);
      end;
    lfsRightLeftBottomTop:
      begin
        LOriginalList := Reorder(LOriginalList, odLMDRightLeft);
        LOriginalList := Reorder(LOriginalList, odLMDBottomTop);
      end;
    lfsTopBottomLeftRight:
      begin
        LOriginalList := Reorder(LOriginalList, odLMDTopBottom);
        LOriginalList := Reorder(LOriginalList, odLMDLeftRight);
      end;
    lfsTopBottomRightLeft:
      begin
        LOriginalList := Reorder(LOriginalList, odLMDTopBottom);
        LOriginalList := Reorder(LOriginalList, odLMDRightLeft);
      end;
    lfsBottomTopLeftRight:
      begin
        LOriginalList := Reorder(LOriginalList, odLMDBottomTop);
        LOriginalList := Reorder(LOriginalList, odLMDLeftRight);
      end;
    lfsBottomTopRightLeft:
      begin
        LOriginalList := Reorder(LOriginalList, odLMDBottomTop);
        LOriginalList := Reorder(LOriginalList, odLMDRightLeft);
      end;
  end;

  if ControlCount > 0 then
  begin
    MaxHeight := 0;
    MaxWidth := 0;
    AdjustClientRect(Rect);
    if AutoSize then
    begin
//      Rect := Classes.Rect(
//        Rect.Left,
//        Rect.Top,
//        Rect.Left + Width - (Rect.Right - Rect.Left),
//        Rect.Top + Height - (Rect.Bottom - Rect.Top));
    end;

    Rect.Left := Rect.Left + FBorderMargins.Left;
    Rect.Top := Rect.Top + FBorderMargins.Top;
    Rect.Right := Rect.Right + FBorderMargins.Right;
    Rect.Bottom := Rect.Bottom + FBorderMargins.Bottom;

    case FFlowStyle of
      lfsLeftRightTopBottom,
      lfsTopBottomLeftRight:
        Position := Rect.TopLeft;
      lfsRightLeftTopBottom,
      lfsTopBottomRightLeft:
        Position := Point(Rect.Right, Rect.Top);
      lfsLeftRightBottomTop,
      lfsBottomTopLeftRight:
        Position := Point(Rect.Left, Rect.Bottom);
      lfsRightLeftBottomTop,
      lfsBottomTopRightLeft:
        Position := Rect.BottomRight;
    end;
    PrevControl := nil;
    for I := 0 to ControlCount - 1 do
    begin
      if I > 0 then
        PrevControl := TControl(LOriginalList[i - 1]);

      Control := TControl(LOriginalList[i]);
      if not Control.Visible and not (csDesigning in ComponentState) then
        Continue;
      Size.cx := Control.Width;
      Size.cy := Control.Height;

      case FFlowStyle of
      lfsLeftRightTopBottom,
      lfsLeftRightBottomTop,
      lfsRightLeftTopBottom,
      lfsRightLeftBottomTop:
        if Control is TLMDFlowPanelSeparator then
        begin
          Size.cy := MaxHeight;
          Size.cx := 4;
          if Size.cy = 0 then Size.cy := 24;
        end;
      lfsTopBottomLeftRight,
      lfsTopBottomRightLeft,
      lfsBottomTopLeftRight,
      lfsBottomTopRightLeft:
        if Control is TLMDFlowPanelSeparator then
        begin
          Size.cx := MaxWidth;
          Size.cy := 4;
          if Size.cx = 0 then Size.cx := 4;
        end;
      end;

      case FFlowStyle of
        lfsLeftRightTopBottom,
        lfsLeftRightBottomTop:
          if ((MaxHeight > 0) and (Position.X + Size.cx + FBorderMargins.Right >= Rect.Right) and FAutoWrap) or (PrevControl is TLMDFlowPanelSeparator) then
          begin
            Inc(Position.Y, MaxHeight * YIncDir[FFlowStyle] + FControlsPaddingY);
            if Height < Position.Y + MaxHeight then
            begin
//              Height := Height + FControlsPaddingY + MaxHeight;
              Height := Position.Y + MaxHeight + FBorderMargins.Bottom;
            end;
//            if FVerticalAlign <> vaTop then
//              AlignVertical(MaxHeight, Position.Y);
            MaxHeight := 0;
            Position.X := Rect.Left;
          end;
        lfsRightLeftTopBottom,
        lfsRightLeftBottomTop:
          begin
            Dec(Position.X, Size.cx);
            if ((MaxHeight > 0) and (Position.X <= 0) and FAutoWrap) or (PrevControl is TLMDFlowPanelSeparator) then
            begin
              Inc(Position.Y, MaxHeight * YIncDir[FFlowStyle] + FControlsPaddingY);
//              if FVerticalAlign <> vaTop then
//                AlignVertical(MaxHeight, Position.Y);
              MaxHeight := 0;
              Position.X := Rect.Right - Size.cx;
            end;
          end;
        lfsTopBottomLeftRight,
        lfsTopBottomRightLeft:
          if ((MaxWidth > 0) and (Position.Y + Size.cy >= Rect.Bottom{ - FBorderMargins.Bottom}) and FAutoWrap) or (PrevControl is TLMDFlowPanelSeparator) then
          begin
            Inc(Position.X, MaxWidth * XIncDir[FFlowStyle] + FControlsPaddingX);
            MaxWidth := 0;
            Position.Y := Rect.Top;
          end;
        lfsBottomTopLeftRight,
        lfsBottomTopRightLeft:
          begin
            Dec(Position.Y, Size.cy);
            if ((MaxWidth > 0) and (Position.Y <= 0) and FAutoWrap) or (PrevControl is TLMDFlowPanelSeparator) then
            begin
              Inc(Position.X, MaxWidth * XIncDir[FFlowStyle] + FControlsPaddingX);
              MaxWidth := 0;
              Position.Y := Rect.Bottom - Size.cy;
            end;
          end;
      end;
      YDelta := YDeltaConst[FFlowStyle] * Size.cy{ + FBorderMargins.Top};
      XDelta := XDeltaConst[FFlowStyle] * Size.cx{ + FBorderMargins.Left};
      if Size.cy > MaxHeight then
        MaxHeight := Size.cy;
      if Size.cx > MaxWidth then
        MaxWidth := Size.cx;
      Control.SetBounds(Position.X + XDelta, Position.Y + YDelta, Size.cx, Size.cy);
      if FFlowStyle in [lfsLeftRightTopBottom, lfsLeftRightBottomTop] then
        Inc(Position.X, Size.cx * XIncDir[FFlowStyle] + FControlsPaddingX)
      else if FFlowStyle in [lfsTopBottomLeftRight, lfsTopBottomRightLeft] then
        Inc(Position.Y, Size.cy + YIncDir[FFlowStyle] + FControlsPaddingY);
    end;
    //AlignVertical(MaxHeight);
    if (LMDRectWidth(Rect) <= MaxWidth + FBorderMargins.Right) then
      Rect.Right := Rect.Left + MaxWidth + FBorderMargins.Right;
    if (LMDRectHeight(Rect) <= MaxHeight + FBorderMargins.Top + FControlsPaddingY) then
      Rect.Bottom := Rect.Bottom + MaxHeight + FControlsPaddingY;
    if (Height > Position.Y + MaxHeight + FBorderMargins.Bottom) then
      Height := Position.Y + MaxHeight + FBorderMargins.Bottom;
    ControlsAligned;
  end;


  if Showing then
    AdjustSize;
  LOriginalList.Free;
end;

function TLMDCustomFlowPanel.CanResize(var ANewWidth, ANewHeight: Integer): Boolean;
begin
  Result := inherited CanResize(ANewWidth, ANewHeight);
  if AutoSize then
  begin
    ANewWidth := ANewWidth + FBorderMargins.Left + FBorderMargins.Right;
    ANewHeight := ANewHeight + FBorderMargins.Top + FBorderMargins.Bottom;
  end;
end;

{$IFDEF LMDCOMP11}
procedure TLMDCustomFlowPanel.CMControlListChanging(var Message: TCMControlListChanging);
begin
  inherited;
  if Message.Inserting and (Message.ControlListItem.Parent = Self) then
  begin
    if FControlList.IndexOf(Message.ControlListItem.Control) < 0 then
      FControlList.Add(Message.ControlListItem.Control);
  end else
    FControlList.Remove(Message.ControlListItem.Control);
end;
{$ELSE}
procedure TLMDCustomFlowPanel.CMControlListChange(var Message: TCMControlListChange);
begin
  inherited;
  if Message.Inserting then
  begin
    if FControlList.IndexOf(Message.Control) < 0 then
      FControlList.Add(Message.Control);
  end else
    FControlList.Remove(Message.Control);
end;
{$ENDIF}

constructor TLMDCustomFlowPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutoWrap := True;
  FControlList := TObjectList.Create(False);
  FBorderMargins := TLMDMargins.Create(15, 15, 15, 15);
  FBorderMargins.OnChange := DoBordersMarginChanged;
  FControlsPaddingX := 3;
  FControlsPaddingY := 3;
end;

destructor TLMDCustomFlowPanel.Destroy;
begin
  FBorderMargins.OnChange := nil;
  inherited;
  FreeAndNil(FBorderMargins);
  FreeAndNil(FControlList);
end;

procedure TLMDCustomFlowPanel.DoBordersMarginChanged(Sender: TObject);
begin
  Realign;
end;

procedure TLMDCustomFlowPanel.DoThemeChanged;
begin
  inherited;
  Realign;
end;

procedure TLMDCustomFlowPanel.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  Control: TControl;
begin
  for I := 0 to FControlList.Count - 1 do
  begin
    Control := TControl(FControlList[I]);
    if Control.Owner = Root then Proc(Control);
  end;
end;

function TLMDCustomFlowPanel.GetControlIndex(AControl: TControl): Integer;
begin
  Result := FControlList.IndexOf(AControl);
end;

procedure TLMDCustomFlowPanel.SetAutoWrap(Value: Boolean);
begin
  if FAutoWrap <> Value then
  begin
    FAutoWrap := Value;
    Realign;
  end;
end;

procedure TLMDCustomFlowPanel.SetBorderMargins(const Value: TLMDMargins);
begin
  FBorderMargins.Assign(Value);
end;

procedure TLMDCustomFlowPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;

end;

procedure TLMDCustomFlowPanel.SetControlIndex(AControl: TControl; Index: Integer);
var
  CurIndex: Integer;
begin
  CurIndex := GetControlIndex(AControl);
  if (CurIndex > -1) and (CurIndex <> Index) and (Index < FControlList.Count) then
  begin
    FControlList.Move(CurIndex, Index);
    Realign;
  end;
end;

procedure TLMDCustomFlowPanel.SetControlsPaddingX(const Value: Integer);
begin
  if (FControlsPaddingX <> Value) then
  begin
    FControlsPaddingX := Value;
    Realign;
  end;
end;

procedure TLMDCustomFlowPanel.SetControlsPaddingY(const Value: Integer);
begin
  if (FControlsPaddingY = Value) then
  begin
    FControlsPaddingY := Value;
    Realign;
  end;
end;

procedure TLMDCustomFlowPanel.SetLMDFlowStyle(Value: TLMDFlowStyle);
begin
  if FFlowStyle <> Value then
  begin
    FFlowStyle := Value;
    Realign;
  end;
end;

procedure TLMDCustomFlowPanel.SetVerticalAlign(const Value: TLMDVerticalAlign);
begin
  if FVerticalAlign <> Value then
  begin
    FVerticalAlign := Value;
    Realign;
  end;
end;

end.
