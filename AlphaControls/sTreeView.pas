unit sTreeView;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ComCtrls, Commctrl,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF DELPHI_XE2} UITypes, {$ENDIF}
  {$IFDEF TNTUNICODE} TntComCtrls, {$ENDIF}
  sConst, sCommonData, sMessages, acSBUtils;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFDEF TNTUNICODE}
  TsTreeView = class(TTntTreeView)
{$ELSE}
  TsTreeView = class(TTreeView)
{$ENDIF}
{$IFNDEF NOTFORHELP}
  private
    FBoundLabel: TsBoundLabel;
    FCommonData: TsScrollWndData;
    FOldDrawItem: TTVAdvancedCustomDrawItemEvent;
    function FontStored: boolean;
    function ColorStored: boolean;
  protected
    FLastHoverItem: TTreeNode;
    procedure WndProc(var Message: TMessage); override;
{$IFDEF DELPHI7UP}
    function IsCustomDrawn(Target: TCustomDrawTarget; Stage: TCustomDrawStage): Boolean; override;
{$ENDIF}
    procedure Loaded; override;
    procedure InitEvents; virtual;
    procedure SkinCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
  public
    ListSW: TacScrollWnd;
    FRightNode: TTreeNode;
    constructor Create(AOwner: TComponent); override;
    procedure AfterConstruction; override;
    destructor Destroy; override;
    procedure UpdateLastHoverNode;
  published
    property Color stored ColorStored;
    property Font stored FontStored;
    property ParentFont stored FontStored;
    property RowSelect default True;
{$ENDIF} // NOTFORHELP
    property BoundLabel: TsBoundLabel    read FBoundLabel write FBoundLabel;
    property SkinData:   TsScrollWndData read FCommonData write FCommonData;
  end;


{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
  TsTreeViewEx = class(TsTreeView)
{$IFNDEF NOTFORHELP}
  private
    FCheckboxes,
    CheckRemoving,
    FColorsUpdated,
    FAutoChildCheck,
    FAutoParentCheck: boolean;

    FLastHoverItem: TTreeNode;
    procedure SetLastHoverItem(const Value: TTreeNode);
    procedure SetCheckboxes(const Value: boolean);
    procedure PaintItems(DC: hdc);
    procedure WMPaint     (var Message: TWMPaint); message WM_PAINT;
    procedure WMEraseBkGnd(var Message: TWMPaint);
    procedure WMNCPaint   (var Message: TMessage);
    property LastHoverItem: TTreeNode read FLastHoverItem write SetLastHoverItem;
  protected
    procedure UpdateColors;
    procedure InitEvents; override;
    function DrawItem(aDC: hdc; Node: TTreeNode; State: TCustomDrawState): boolean;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CreateWnd; override;
    procedure WndProc(var Message: TMessage); override;
    function GetChecked(Node: TTreeNode): Boolean;
    procedure SetChecked(Node: TTreeNode; Checked: Boolean);
  published
{$ENDIF} // NOTFORHELP
    property AutoChildCheck:  boolean read FAutoChildCheck  write FAutoChildCheck  default False;
    property AutoParentCheck: boolean read FAutoParentCheck write FAutoParentCheck default False;
    property Checkboxes:      boolean read FCheckboxes      write SetCheckboxes    default False;
  end;


function GetNodeByText(const TreeView: TCustomTreeView; const s: acString): TTreeNode;

implementation

uses
  StdCtrls, math, ExtCtrls,
  {$IFDEF LOGGED}sDebugMsgs, {$ENDIF}
  sVclUtils, acgpUtils, sStyleSimply, acntUtils, sGraphUtils, sAlphaGraph, sSkinManager, sThirdParty, acAlphaImageList;


function GetNodeByText(const TreeView: TCustomTreeView; const s: acString): TTreeNode;
var
  i: integer;
begin
  Result := nil;
  with TTreeView(TreeView) do
    for i := 0 to Items.Count - 1 do
      if acSameText(Items[i].Text, s) then begin
        Result := Items[i];
        Break;
      end;
end;


procedure TsTreeView.AfterConstruction;
begin
  inherited;
  FCommonData.Loaded(False);
  if HandleAllocated then
    RefreshTreeScrolls(SkinData, ListSW, Self is TsTreeViewEx);
end;


function TsTreeView.ColorStored: boolean;
begin
  Result := not SkinData.Skinned or SkinData.CustomColor;
end;


constructor TsTreeView.Create(AOwner: TComponent);
begin
  FCommonData := TsScrollWndData.Create(Self, True);
  FCommonData.COC := COC_TsTreeView;
  inherited;
  FBoundLabel := TsBoundLabel.Create(Self, FCommonData);
  FLastHoverItem := nil;
  FOldDrawItem := nil;
  FRightNode := nil;
  RowSelect := True;
end;


destructor TsTreeView.Destroy;
begin
  FreeAndNil(ListSW);
  FreeAndNil(FBoundLabel);
  FreeAndNil(FCommonData);
  inherited Destroy;
end;


function TsTreeView.FontStored: boolean;
begin
  Result := IsCustomFont(Self, Font, not SkinData.Skinned or SkinData.CustomFont);
end;


procedure TsTreeView.InitEvents;
var
  TempEvent: TTVAdvancedCustomDrawItemEvent;
begin
  if not (csDesigning in ComponentState) then begin
    if Assigned(OnAdvancedCustomDrawItem) and not Assigned(FOldDrawItem) then begin
      TempEvent := SkinCustomDrawItem;
      if addr(TempEvent) <> addr(OnAdvancedCustomDrawItem) then
        FOldDrawItem := OnAdvancedCustomDrawItem;
    end;
    OnAdvancedCustomDrawItem := SkinCustomDrawItem;
  end;
end;


{$IFDEF DELPHI7UP}
function TsTreeView.IsCustomDrawn(Target: TCustomDrawTarget; Stage: TCustomDrawStage): Boolean;
begin
  if (SkinData <> nil) and (SkinData.FUpdateCount > 0) then
    Result := False
  else
    Result := inherited IsCustomDrawn(Target, Stage);
end;
{$ENDIF}


procedure TsTreeView.Loaded;
begin
  inherited Loaded;
  FCommonData.Loaded(False);
  RefreshTreeScrolls(SkinData, ListSW, Self is TsTreeViewEx);
  InitEvents;
end;


const
  TVIS_CHECKED = $2000;

  LT_FIRST  = 1;
  LT_MIDDLE = 2;
  LT_LAST   = 4;
  LT_ARROW  = 8;
  LT_LINEALL = LT_FIRST or LT_MIDDLE or LT_LAST or LT_ARROW;

  BtnSize = 9;

type
  TtvLineType = (ltNone, ltFirst, Closed, ltOpened, ltChild);
  TBtnArray = array [0..BtnSize - 1, 0..BtnSize - 1] of byte;


const
  BArrayClosed: TBtnArray = (
    (  0,   0, $60, $30,   0,   0,   0,   0,   0),
    (  0,   0, $70, $70, $30,   0,   0,   0,   0),
    (  0,   0, $70, $30, $70, $30,   0,   0,   0),
    (  0,   0, $70,   0, $30, $70, $30,   0,   0),
    (  0,   0, $70,   0,   0, $30, $70, $30,   0),
    (  0,   0, $70,   0, $30, $70, $30,   0,   0),
    (  0,   0, $70, $30, $70, $30,   0,   0,   0),
    (  0,   0, $70, $70, $30,   0,   0,   0,   0),
    (  0,   0, $60, $30,   0,   0,   0,   0,   0)
  );
  BArrayOpened: TBtnArray = (
    (  0,   0,   0,   0,   0,   0,   0,   0,   0),
    (  0,   0,   0,   0,   0, $50, $A0,   0,   0),
    (  0,   0,   0,   0, $50, $EF, $EF,   0,   0),
    (  0,   0,   0, $50, $EF, $C0, $EF,   0,   0),
    (  0,   0, $50, $EF, $C0, $C0, $EF,   0,   0),
    (  0, $50, $EF, $C0, $C0, $C0, $EF,   0,   0),
    (  0, $A0, $EF, $EF, $EF, $EF, $D0,   0,   0),
    (  0,   0,   0,   0,   0,   0,   0,   0,   0),
    (  0,   0,   0,   0,   0,   0,   0,   0,   0)
  );


procedure TsTreeView.SkinCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
var
  RowBmp, TmpBmp, Bmp: TBitmap;
  DisabledKind: TsDisabledKind;
  fRect, nRect, aRect: TRect;
  SavedStyle: TFontStyles;
  b, bSelected: boolean;
  NodeAtPos: TTreeNode;
  DrawStyle: Cardinal;
  cx, sNdx: integer;
  CI: TCacheInfo;
  p: TPoint;

  function NodeIsBold: boolean;
  var
    Item: TTVItem;
  begin
    Item.mask := TVIS_BOLD;
    Item.hItem := Node.ItemId;
    TreeView_GetItem(Handle, Item);
    Result := Item.state and TVIS_BOLD <> 0;
  end;

  procedure CallEvents;
  begin
    DefaultDraw := True;
    if Assigned(FOldDrawItem) then
      FOldDrawItem(Sender, Node, State, Stage, PaintImages, DefaultDraw);

    if Assigned(OnCustomDrawItem) then
      OnCustomDrawItem(Sender, Node, State, DefaultDraw);
  end;

  procedure PaintBtn(aPoint: TPoint; aClosed: boolean; const CI: TCacheInfo);
  var
    Rct: TRect;
    Col: TsColor;
    BtnArray: TBtnArray;
    S, S0: PRGBAArray_S;
    D, D0: PRGBAArray_D;
    X, Y, DeltaS, DeltaD, DeltaX: integer;
  begin
    Rct.Left := aPoint.X - BtnSize div 2;
    Rct.Top  := aPoint.Y - BtnSize div 2;
    Rct.Right := Rct.Left + BtnSize;
    Rct.Bottom := Rct.Top + BtnSize;
    Col.C := SkinData.SkinManager.GetHighLightFontColor(Focused);

    if aClosed then
      BtnArray := BArrayClosed
    else
      BtnArray := BArrayOpened;

    if Rct.Left < 0 then begin
      DeltaX := BtnSize + Rct.Left;
      Rct.Left := 0;
    end
    else
      DeltaX := BtnSize;

    if InitLine(RowBmp, Pointer(D0), DeltaD) and InitLine(Ci.Bmp, Pointer(S0), DeltaS) then
      for Y := 0 to BtnSize - 1 do
        if Rct.Top + Y + CI.Y < CI.Bmp.Height then begin
          D := Pointer(PAnsiChar(D0) + DeltaD * (Rct.Top + Y));
          S := Pointer(PAnsiChar(S0) + DeltaS * (Rct.Top + Y + CI.Y));
          for X := 0 to DeltaX - 1 do
            with D[Rct.Left + X], S[Rct.Left + X + CI.X], Col do begin
              DR := ((R - SR) * BtnArray[Y, X] + SR shl 8) shr 8;
              DG := ((G - SG) * BtnArray[Y, X] + SG shl 8) shr 8;
              DB := ((B - SB) * BtnArray[Y, X] + SB shl 8) shr 8;
              DA := MaxByte;
            end;
        end;
  end;

begin
  if not (csDesigning in ComponentState) and DefaultDraw and (Node <> nil) then
    if SkinData.Skinned then begin
      // Init color and font properties
      Canvas.Brush.Color := Color;
      Canvas.Font.Color := Font.Color;
      CallEvents;
      // Paint over std output
      if cdPostPaint = Stage then begin
//      if cdPrePaint <> Stage then begin
        // If DefaultDraw was reinitialized in events
        if not DefaultDraw then
          Exit;

        DefaultDraw := False;
        // Check a hot state of node
        p := ScreenToClient(acMousePos);
{$IFDEF DELPHI6UP}
        NodeAtPos := GetNodeAt(p.X, p.Y);
        if (DragMode = dmAutomatic) and (GetCapture <> 0) and (NodeAtPos <> nil) and HotTrack then begin
          bSelected := NodeAtPos = Node;
          if GetCapture <> 0 then
            FLastHoverItem := NodeAtPos;
        end
        else
{$ENDIF}
        begin
          NodeAtPos := nil;
          bSelected := ((cdsSelected in State) or (Selected = Node) or HotTrack and (cdsHot in State)) and (Focused or not HideSelection) or (FRightNode = Node);
        end;

        nRect := Node.DisplayRect(True);
        if NodeIsBold then begin
          SavedStyle := Canvas.Font.Style;
          Canvas.Font.Style := SavedStyle + [fsBold];
          cx := GetStringSize(Canvas.Font.Handle, Node.Text).cx;
          Canvas.Font.Style := SavedStyle;
          inc(nRect.Right, cx - GetStringSize(Canvas.Font.Handle, Node.Text).cx);
        end;

        if IsRectEmpty(nRect) or not RectInRect(ClientRect, nRect, False) then
          Exit;

        // Check if RowBmp should be created
        if RowSelect and not ShowLines and bSelected then begin
          fRect := Node.DisplayRect(False);
          RowBmp := CreateBmp32(fRect);
        end
        else begin
          RowBmp := nil;
          fRect := nRect;
        end;

        if True{HotTrack} or (RowSelect and bSelected) then begin // Fix of glyphs painting std bug
          if Images <> nil then
            cx := 4{SkinData.CommonSkinData.Spacing} + 2 + GetImageWidth(Images, -1, GetPPI(SkinData))
//            cx := 4{SkinData.CommonSkinData.Spacing} + 2 + GetImageWidth(Images, -1{, GetPPI(SkinData)}) + 1
          else
            cx := 1;

          dec(nRect.Left, cx);
          inc(nRect.Right, 2);
        end
        else
          cx := 0;

        // Paint text on bmp before output on Canvas (flickering avoiding)
        Bmp := CreateBmp32(nRect);
        aRect := MkRect(Bmp);
        CI.Bmp := nil;
        CI.Ready := False;
        CI.FillColor := ColorToRGB(Canvas.Brush.Color);
        if bSelected then begin
          sNdx := SkinData.SkinManager.SkinCommonInfo.Sections[ssSelection];
          if RowBmp <> nil then
            TmpBmp := RowBmp
          else
            TmpBmp := Bmp;

          if sNdx < 0 then
            FillDC(TmpBmp.Canvas.Handle, MkRect(TmpBmp), SkinData.SkinManager.GetHighLightColor((cdsFocused in State) and bSelected))
          else
            PaintItem(sNdx, CI, True, integer(Focused and bSelected or (NodeAtPos <> nil)), MkRect(TmpBmp), MkPoint, TmpBmp, SkinData.CommonSkinData);

          if {HotTrack and }(cdsHot in State) and (Selected <> Node) then begin
            DisabledKind := [dkBlended];
            BmpDisabledKind(TmpBmp, DisabledKind, Parent, CI, Point(3, nRect.Top + 3));
          end;
          if RowBmp <> nil then begin
            if Node.HasChildren then begin
              p.X := nRect.Left - 5 - BtnSize div 2;
              p.Y := HeightOf(nRect) div 2;
              PaintBtn(p, not Node.Expanded, MakeCacheInfo(RowBmp, 0, 0));
            end;
            BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, RowBmp.Canvas.Handle, nRect.Left - fRect.Left, 0, SRCCOPY);
          end;
        end
        else begin
          sNdx := -1;
          if SkinData.SkinSection = '' then
            // Quick fill by color
            FillDC(Bmp.Canvas.Handle, aRect, CI.FillColor)
          else
            if ListSW <> nil then
              BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, SkinData.FCacheBmp.Canvas.Handle, nRect.Left + ListSW.cxLeftEdge, nRect.Top + ListSW.cyTopEdge, SRCCOPY)
            else
              BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, SkinData.FCacheBmp.Canvas.Handle, nRect.Left, nRect.Top, SRCCOPY);
        end;

        // Draw text on Bmp
        Bmp.Canvas.Font.Assign(Canvas.Font);
        if NodeIsBold then
          Bmp.Canvas.Font.Style := Bmp.Canvas.Font.Style + [fsBold];

        InflateRect(aRect, -1, 0);
        aRect.Left := aRect.Left + 1 + cx;
        DrawStyle := DT_NOPREFIX or DT_EXPANDTABS or DT_SINGLELINE or DT_VCENTER or DT_NOCLIP or DT_ALPHATEXT * Cardinal(SkinData.TranspMode = TM_FULL);
        if bSelected then
          Bmp.Canvas.Font.Color := SkinData.SkinManager.GetHighLightFontColor(cdsFocused in State);

        if sNdx < 0 then begin
          Bmp.Canvas.Brush.Style := bsClear;
          AcDrawText(Bmp.Canvas.Handle, {$IFDEF TNTUNICODE}TTntTreeNode{$ENDIF}(Node).Text, aRect, DrawStyle);
        end
        else
          acWriteTextEx(Bmp.Canvas, PacChar({$IFDEF TNTUNICODE}TTntTreeNode{$ENDIF}(Node).Text), True, aRect, DrawStyle, sNdx, Focused or SkinData.FMouseAbove and MayBeHot(SkinData), SkinData.SkinManager);

        if bSelected and (SkinData.TranspMode > TM_OPAQUE) or (SkinData.TranspMode = TM_PARTIAL) then
          FillAlphaRect(Bmp, aRect);

        if (True{HotTrack} or (RowBmp <> nil) or RowSelect and bSelected) and (Images <> nil) then begin // Fix of glyphs painting std bug
          SetImagesPPI(Images, GetPPI(SkinData));
          if bSelected then begin
            SetImagesState(Images, 1);
            Images.Draw(Bmp.Canvas, 4, (Bmp.Height - GetImageHeight(Images, -1, GetPPI(SkinData))) div 2, Node.ImageIndex);
//            Images.Draw(Bmp.Canvas, 4, (Bmp.Height - GetImageHeight(Images, -1{, GetPPI(SkinData)})) div 2, Node.ImageIndex);
            SetImagesState(Images, 0); // Reset
          end
          else
            Images.Draw(Bmp.Canvas, 4, (Bmp.Height - GetImageHeight(Images, -1, GetPPI(SkinData))) div 2, Node.ImageIndex);
        end;
        if Focused then begin
          if (sNdx < 0) and bSelected then begin
            InflateRect(aRect, 1, 0);
            aRect.Left := 0;
            DrawFocusRect(Bmp.Canvas.Handle, aRect);
          end;
        end
        else
          if not Enabled then begin
            DisabledKind := [dkBlended];
            BmpDisabledKind(Bmp, DisabledKind, Parent, CI, Point(nRect.Left + 3, nRect.Top + 3));
          end;

        if RowBmp <> nil then begin
          BitBlt(RowBmp.Canvas.Handle, nRect.Left - fRect.Left, 0, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
          BitBlt(Sender.Canvas.Handle, fRect.Left, fRect.Top, RowBmp.Width, RowBmp.Height, RowBmp.Canvas.Handle, 0, 0, SRCCOPY);
          RowBmp.Free;
        end
        else
          BitBlt(Sender.Canvas.Handle, nRect.Left, nRect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);

        Bmp.Free;
        DefaultDraw := False;
      end
      else
        if RowSelect and not HotTrack and (GetCapture = Handle) then
          if (ListSW = nil) or not ListSW.fThumbTracking then begin
            b := True;
            SkinCustomDrawItem(Self, Node, [cdsSelected], cdPostPaint, b, b);
            DefaultDraw := False;
          end;
    end
    else
      CallEvents
end;


procedure TsTreeView.UpdateLastHoverNode;
begin
  if FLastHoverItem <> nil then begin
    FLastHoverItem := nil;
    Refresh;
  end;
end;


procedure TsTreeView.WndProc(var Message: TMessage);
var
  PS: TPaintStruct;
  i: integer;
  b: boolean;
begin
{$IFDEF LOGGED}
  if Tag = 0 then
    AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_CTRLHANDLED: begin
          Message.Result := 1;
          Exit;
        end;

        AC_SETSCALE:
          if SkinData.SkinManager <> nil then begin
            i := TreeView_GetItemHeight(Handle);
            i := MulDiv(i, Message.LParam, SkinData.CurrentPPI);
            TreeView_SetItemHeight(Handle, i);
            RecreateWnd;
            Exit;
          end;

        AC_REMOVESKIN:
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            if ListSW <> nil then
              FreeAndNil(ListSW);

            Exit;
          end;

        AC_SETNEWSKIN:
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            CommonWndProc(Message, FCommonData);
            Exit;
          end;

        AC_REFRESH:
          if RefreshNeeded(SkinData, Message) then begin
            RefreshTreeScrolls(SkinData, ListSW, Self is TsTreeViewEx);
            if FCommonData.Skinned then begin
              if not FCommonData.CustomColor then
{$IFNDEF DELPHI6UP}
                TreeView_SetBkColor(Handle, ColorToRGB(FCommonData.CommonSkinData.gd[FCommonData.SkinIndex].Props[0].Color))
{$ELSE}
                Color := FCommonData.CommonSkinData.gd[FCommonData.SkinIndex].Props[0].Color
{$ENDIF}
              else
                if ListSW <> nil then
                  TacTreeViewWnd(ListSW).Color := Color;
            end;
            SetWindowPos(Handle, 0, 0, 0, 0, 0, SWPA_FRAMECHANGED);
            Exit;
          end;

        AC_PREPARECACHE: begin
          CommonMessage(Message, SkinData);
          Exit;
        end;

        AC_GETDEFSECTION: begin
          Message.Result := 0 + 1;
          Exit;
        end;

        AC_GETDEFINDEX: begin
          if FCommonData.SkinManager <> nil then
            Message.Result := FCommonData.SkinManager.SkinCommonInfo.Sections[ssEdit] + 1;

          Exit;
        end

        else
          CommonMessage(Message, SkinData);
      end;
  end;

  if not ControlIsReady(Self) or not FCommonData.Skinned then
    inherited
  else begin
    case Message.Msg of
      CN_CTLCOLOREDIT: begin
        if ({$IFDEF 2010}(csGlassPaint in ControlState) or {$ENDIF}(SkinData.TranspMode > TM_OPAQUE)) and not TacEditWnd(ListSW).FInBufferedPrintClient then begin
          TacEditWnd(ListSW).FInBufferedPrintClient := True;
          PostMessage(Handle, SM_ALPHACMD, MakeWParam(0, AC_BUFFEREDPRINTCLIENT), 0);
        end;
        SetTextColor(hdc(Message.WParam), ColorToRGB(Font.Color));
        SetBkColor(hdc(Message.WParam), ColorToRGB(Brush.Color));
        Message.Result := LRESULT(Brush.Handle);
        Exit;
      end;

      CM_VISIBLECHANGED, CM_ENABLEDCHANGED, WM_MOVE:
        FCommonData.BGChanged := True;

      WM_NCPAINT, WM_ERASEBKGND:
        if InUpdating(SkinData) then
          Exit;

      WM_PAINT: begin
        SkinData.TranspMode := GetTransMode(SkinData);
        if InUpdating(SkinData) then begin
          BeginPaint(Handle, PS);
          EndPaint(Handle, PS);
          Exit;
        end;
      end;

      WM_SETREDRAW:
        FCommonData.FUpdating := Message.WParam <> 1;

      CM_MOUSEENTER:
        if ac_AllowHotEdits and MayBeHot(SkinData) and (Color <> SkinData.CommonSkinData.gd[SkinData.SkinIndex].Props[1].Color) and not SkinData.CustomColor then begin
          SkinData.BGChanged := True;
          SkinData.FMouseAbove := True;
          Color := SkinData.CommonSkinData.gd[SkinData.SkinIndex].Props[1].Color;
          TreeView_SetBkColor(Handle, ColorToRGB(Color));
          Application.ProcessMessages;
          Repaint;
        end;

      WM_RBUTTONDOWN:
        if RightClickSelect and (FRightNode <> Selected) and HandleAllocated then begin
          FRightNode := GetNodeAt(TWMNCHitMessage(Message).XCursor, TWMNCHitMessage(Message).YCursor);
          if Selected <> nil then
            SkinCustomDrawItem(Self, Selected, [], cdPostPaint, b, b);

          if FRightNode <> nil then
            SkinCustomDrawItem(Self, FRightNode, [cdsSelected], cdPostPaint, b, b);
        end;

      WM_SETFONT:
        if SkinData.CtrlSkinState and ACS_CHANGING <> 0 then
          Exit;

      WM_NCHITTEST:
        if RightClickSelect and (FRightNode <> nil) then begin
          SkinCustomDrawItem(Self, FRightNode, [], cdPostPaint, b, b);
          FRightNode := nil;
          if Selected <> nil then
            SkinCustomDrawItem(Self, Selected, [cdsSelected], cdPostPaint, b, b);
        end;
    end;
    if CommonWndProc(Message, FCommonData) then
      Exit;

    inherited;
    case Message.Msg of
      CM_SHOWINGCHANGED:
        RefreshTreeScrolls(SkinData, ListSW, Self is TsTreeViewEx);
    end;
  end;
  if Assigned(BoundLabel) then
    BoundLabel.HandleOwnerMsg(Message, Self);
end;


constructor TsTreeViewEx.Create(AOwner: TComponent);
begin
  inherited;
  FColorsUpdated := False;
  FAutoChildCheck := False;
  FAutoParentCheck := False;
  FLastHoverItem := nil;
  FCheckboxes := False;
end;


procedure TsTreeViewEx.CreateWnd;
begin
  inherited;
  SetCheckBoxes(FCheckBoxes);
end;


const
  iLeftOffset = 10;

function TsTreeViewEx.DrawItem(aDC: hdc; Node: TTreeNode; State: TCustomDrawState): boolean;
var
  DC: hdc;
  p: TPoint;
  Bmp: TBitmap;

  Item: TTVItem;
  CI: TCacheInfo;
  lType: Cardinal;
  BakColor: TColor;
  bFocused: boolean;
  LastItem: TTreeNode;
  DrawStyle: Cardinal;
  DisabledKind: TsDisabledKind;
  bSelected, DefaultDraw: boolean;
  LineOffset, w, h, bw, sNdx: integer;
  StateRect, ImgRect, CheckRect, SelRect, nRect, rText: TRect;

  NewPen: TPen;
  PenHandle: HPEN;
  LineColor: TColor;
  BrushStyle: tagLOGBRUSH;

  procedure CallEvents(Stage: TCustomDrawStage);
  var
    b: boolean;
  begin
    DefaultDraw := True;
    if Assigned(OnCustomDrawItem) then
      OnCustomDrawItem(Self, Node, State, DefaultDraw);

    if Assigned(OnAdvancedCustomDrawItem) then begin
      b := True;
      OnAdvancedCustomDrawItem(Self, Node, State, Stage, b, DefaultDraw);
    end;
  end;

  function HasNode(ANode, Child: TTreeNode): boolean;
  begin
    if Child <> nil then begin
      Result := (ANode = Child) or (ANode = Child.Parent);
      if not Result then
        Result := HasNode(ANode, Child.Parent);
    end
    else
      Result := False;
  end;

  function LineType: Cardinal;
  begin
    if ShowLines then
      if (ShowRoot or (Node.Parent <> nil)) then
{$IFDEF DELPHI6UP}
        if Node.IsFirstNode then
{$ELSE}
        if not Node.Deleting and (Node.Parent = nil) and (Node.GetPrevSibling = nil) then
{$ENDIF}
          Result := LT_FIRST
        else begin
          if (TreeView_GetNextSibling(Handle, Node.ItemId) = nil) or HasNode(Node, LastItem) then
            Result := LT_LAST
          else
            Result := LT_MIDDLE
        end
      else
        Result := 0
    else
      Result := LT_ARROW;
  end;

  procedure DrawParentLine(ANode: TTreeNode; Pos: TPoint);
  var
    NewPos: TPoint;
    pRect: TRect;
  begin
    if (ANode <> nil) and not HasNode(ANode, LastItem) then
      if ANode.Parent = nil then begin
        NewPos := Point(iLeftOffset, 0);
        if (ListSW <> nil) and (ListSW.sBarHorz <> nil) and ListSW.sBarHorz.fScrollVisible then
          dec(NewPos.x, ListSW.sBarHorz.ScrollInfo.nTrackPos);

        acgpDrawLine(Bmp.Canvas.Handle, NewPos.X, 0, NewPos.X, Bmp.Height, LineColor);
      end
      else begin
        pRect := ANode.DisplayRect(True);
        NewPos := Point(pRect.Left - LineOffset - 8, 0);
        if ANode.Parent.Count > ANode.Index + 1 then
          acgpDrawLine(Bmp.Canvas.Handle, NewPos.X, 0, NewPos.X, Bmp.Height, LineColor);

        DrawParentLine(ANode.Parent, NewPos);
      end;
  end;

  procedure PaintBtn(aPoint: TPoint; aClosed: boolean; CI: TCacheInfo);
  var
    Rct: TRect;
    Col: TsColor;
    BtnArray: TBtnArray;
    S, S0: PRGBAArray_S;
    D, D0: PRGBAArray_D;
    X, Y, DeltaS, DeltaD, DeltaX: integer;
  begin
    Rct.Left := aPoint.X - BtnSize div 2;
    Rct.Top  := aPoint.Y - BtnSize div 2;
    Rct.Right := Rct.Left + BtnSize;
    Rct.Bottom := Rct.Top + BtnSize;
    Col.C := BrushStyle.lbColor;//Bmp.Canvas.Font.Color;

    if aClosed then
      BtnArray := BArrayClosed
    else
      BtnArray := BArrayOpened;

    if Rct.Left < 0 then begin
      DeltaX := BtnSize + Rct.Left;
      Rct.Left := 0;
    end
    else
      DeltaX := BtnSize;

    if CI.X < -Rct.Left then
      CI.X := -Rct.Left;

    if InitLine(Bmp, Pointer(D0), DeltaD) and InitLine(CI.Bmp, Pointer(S0), DeltaS) then
      for Y := 0 to BtnSize - 1 do
        if Rct.Top + Y + CI.Y < CI.Bmp.Height then begin
          D := Pointer(PAnsiChar(D0) + DeltaD * (Rct.Top + Y));
          S := Pointer(PAnsiChar(S0) + DeltaS * (Rct.Top + Y + CI.Y));
          for X := 0 to DeltaX - 1 do
            with D[Rct.Left + X], S[Rct.Left + X + CI.X], Col do begin
              DR := ((R - SR) * BtnArray[Y, X] + SR shl 8) shr 8;
              DG := ((G - SG) * BtnArray[Y, X] + SG shl 8) shr 8;
              DB := ((B - SB) * BtnArray[Y, X] + SB shl 8) shr 8;
              DA := MaxByte;
            end;
        end;
  end;

begin
  Result := True;
  if Node <> nil then begin
    bFocused := Focused;
    if aDC = 0 then
      DC := GetDC(Handle)
    else
      DC := aDC;

    if ListSW <> nil then
      bw := ListSW.cxLeftEdge
    else
      bw := 3 * integer(BorderStyle = bsSingle);

    Canvas.Handle := DC;
    // Init color and font properties
    Canvas.Brush.Color := Color;
    Canvas.Font.Assign(Font);
    CallEvents(cdPrePaint);
    nRect := Node.DisplayRect(False);
    if not IsRectEmpty(nRect) and (nRect.Top < Height) and (nRect.Bottom > 0) then begin
      if DefaultDraw then begin
        rText := Node.DisplayRect(True);
        OffsetRect(rText, 0, - nRect.Top);

        if nRect.Right <= rText.Right then
          nRect.Right := rText.Right + 1;

        Bmp := CreateBmp32(nRect);
        Bmp.Canvas.Font.Assign(Canvas.Font);
        CI := MakeCacheInfo(SkinData.FCacheBmp);
        CI.FillColor := ColorToRGB(Canvas.Brush.Color);

        p := ScreenToClient(acMousePos);
{$IFDEF DELPHI6UP}
        if (DragMode = dmAutomatic) and Mouse.IsDragging and PtInRect(MkRect(Self), p) and HotTrack then begin
          LastHoverItem := GetNodeAt(p.X, p.Y);
          bSelected := FLastHoverItem = Node;
        end
        else
{$ENDIF}
        begin
          if Selected = Node then begin
            LastHoverItem := nil;
            bSelected := True;
          end
          else
            if FRightNode = Node then begin
              LastHoverItem := nil;
              bSelected := True;
            end
            else
              if HotTrack and SkinData.FMouseAbove then begin
                LastHoverItem := GetNodeAt(min(p.X, Width - 2), p.Y);
                bSelected := FLastHoverItem = Node;
              end
              else begin
                LastHoverItem := nil;
                bSelected := False;
              end;
        end;
        LineOffset := 4;
        BitBlt(Bmp.Canvas.Handle, -nRect.Left, 0, Bmp.Width, Bmp.Height, SkinData.FCacheBmp.Canvas.Handle, nRect.Left + bw, nRect.Top + bw, SRCCOPY);
        // Get img rect
        ImgRect.Right := rText.Left;
        if (Images <> nil) and IsValidIndex(Node.ImageIndex, GetImageCount(Images)) then begin
          dec(ImgRect.Right, 4 {spacing});
          w := GetImageWidth(Images, -1, GetPPI(SkinData));
          h := GetImageHeight(Images, -1, GetPPI(SkinData));
          ImgRect.Left := ImgRect.Right - w;
          ImgRect.Top := (Bmp.Height - h) div 2;
          ImgRect.Bottom := ImgRect.Top + h;
          LineOffset := rText.Left - ImgRect.Left + w div 2 - 6;
        end
        else
          ImgRect.Left := ImgRect.Right;

        // Get state img rect
        StateRect.Right := ImgRect.Left;
        if (StateImages <> nil) and IsValidIndex(max(0, Node.StateIndex), GetImageCount(StateImages)) then begin
          dec(StateRect.Right, 4 {spacing});
          w := GetImageWidth(StateImages, -1, GetPPI(SkinData));
          h := GetImageHeight(StateImages, -1, GetPPI(SkinData));
          StateRect.Left := StateRect.Right - w;
          StateRect.Top := (Bmp.Height - h) div 2;
          StateRect.Bottom := StateRect.Top + h;
          LineOffset := rText.Left - StateRect.Left + w div 2 - 6;
          CheckRect.Right := StateRect.Left;
          CheckRect.Left := CheckRect.Right; // Empty checkrect
        end
        else begin // If state image is not defined
          StateRect.Left := StateRect.Right;
          // Get checkbox rect
          CheckRect.Right := StateRect.Left;
          if Checkboxes then begin
            dec(CheckRect.Right, 2 {spacing});
            w := FCheckWidth;
            h := FCheckHeight;
            CheckRect.Top := (Bmp.Height - h) div 2;
            CheckRect.Left := CheckRect.Right - w;
            CheckRect.Bottom := CheckRect.Top + h;
            LineOffset := rText.Left - CheckRect.Left + w div 2 - 2;
          end
          else
            CheckRect.Left := CheckRect.Right;
        end;
        // Paint selection
        if bSelected or (HotTrack and (FLastHoverItem = Node)) then begin
          // Get selection rect
          if RowSelect and not ShowLines then
            SelRect := MkRect(WidthOf(nRect), HeightOf(nRect))
          else begin
            SelRect := rText;
            SelRect.Left := ImgRect.Left;
            InflateRect(SelRect, 1, 0);
            SelRect.Left := max(0, SelRect.Left);
            SelRect.Right := min(SelRect.Right, Bmp.Width);
          end;
          // Paint selection
          sNdx := SkinData.SkinManager.SkinCommonInfo.Sections[ssSelection];
          if sNdx < 0 then begin
            Bmp.Canvas.Font.Color := Font.Color;
            FillDC(Bmp.Canvas.Handle, SelRect, SkinData.SkinManager.GetHighLightColor(bFocused and bSelected));
          end
          else begin
            Bmp.Canvas.Font.Color := SkinData.SkinManager.GetHighLightFontColor(bFocused and bSelected);
            PaintItem(sNdx, CI, True, integer(bFocused and bSelected or (HotTrack and (FLastHoverItem <> nil))),
                       SelRect,
                       nRect.TopLeft, Bmp, SkinData.CommonSkinData);
          end;
          if HotTrack and ((cdsHot in State) or (FLastHoverItem = Node)) and (Selected <> Node) then
            BlendTransRectangle(Bmp, SelRect.Left, 0, CI.Bmp, SelRect, Byte(160));
        end
        else begin
          Bmp.Canvas.Font.Color := Font.Color;
          sNdx := -1;
        end;

        Item.mask := TVIS_BOLD;
        Item.hItem := Node.ItemId;
        TreeView_GetItem(Handle, Item);
        if Item.state and TVIS_BOLD <> 0 then
          Bmp.Canvas.Font.Style := Bmp.Canvas.Font.Style + [fsBold];

        DrawStyle := DT_NOPREFIX or DT_EXPANDTABS or DT_SINGLELINE or DT_VCENTER or DT_NOCLIP or DT_ALPHATEXT * Cardinal(SkinData.TranspMode = TM_FULL);
        if sNdx < 0 then begin
//          if bSelected then
//            Bmp.Canvas.Font.Color := SkinData.SkinManager.GetHighLightFontColor(bFocused);
          Bmp.Canvas.Brush.Style := bsClear;
          AcDrawText(Bmp.Canvas.Handle, {$IFDEF TNTUNICODE}TTntTreeNode{$ENDIF}(Node).Text, rText, DrawStyle);
        end
        else
          acWriteTextEx(Bmp.Canvas, PacChar({$IFDEF TNTUNICODE}TTntTreeNode{$ENDIF}(Node).Text), True, rText, DrawStyle, sNdx, bFocused or (SkinData.FMouseAbove and (FLastHoverItem = Node)) {and MayBeHot(SkinData)}, SkinData.SkinManager);

        if bSelected and (SkinData.TranspMode > TM_OPAQUE) or (SkinData.TranspMode = TM_PARTIAL) then
          FillAlphaRect(Bmp, rText);

        if (ImgRect.Left <> ImgRect.Right) and (ImgRect.Right > 0) then begin
          SetImagesPPI(Images, GetPPI(SkinData));
          if bSelected then
            SetImagesState(Images, 1);

          if Node.OverlayIndex < 0 then
            Images.Draw(Bmp.Canvas, ImgRect.Left, ImgRect.Top, Node.ImageIndex)
          else
            Images.DrawOverlay(Bmp.Canvas, ImgRect.Left, ImgRect.Top, Node.ImageIndex, Node.OverlayIndex);

          if bSelected then
            SetImagesState(Images, 0);
        end;

        if (StateRect.Left <> StateRect.Right) and (StateRect.Right > 0) then begin
          SetImagesPPI(StateImages, GetPPI(SkinData));
          StateImages.Draw(Bmp.Canvas, StateRect.Left, StateRect.Top, max(0, Node.StateIndex));
        end;

        if (CheckRect.Left <> CheckRect.Right) and (CheckRect.Right > 0) then
          acDrawCheck(CheckRect, CheckBoxStates[integer(GetChecked(Node))], True, Bmp, CI, SkinData.CommonSkinData);

        LastItem := Items.GetNode(TreeView_GetLastVisible(Handle));
        lType := LineType;
        p.Y := Bmp.Height div 2;
        if Node.Parent = nil then begin
          p.X := iLeftOffset;
          if (ListSW <> nil) and (ListSW.sBarHorz <> nil) and ListSW.sBarHorz.fScrollVisible then
            dec(p.x, ListSW.sBarHorz.ScrollInfo.nTrackPos);
        end
        else
          p.X := rText.Left - LineOffset - 8;

        if lType and LT_LINEALL <> 0 then begin
          BakColor := Bmp.Canvas.Font.Color;
          Bmp.Canvas.Font.Color := Font.Color;
          Bmp.Canvas.Pen.Style := psDot;
          BrushStyle.lbStyle := BS_SOLID;
          if bSelected then
            BrushStyle.lbColor := BlendColors(ColorToRGB(Color), ColorToRGB(GetFontColor(Self, SkinData.SkinIndex, SkinData.SkinManager, 0, SkinData)), 102)
          else
            BrushStyle.lbColor := BlendColors(ColorToRGB(Color), ColorToRGB(Bmp.Canvas.Font.Color), 102);

          BrushStyle.lbHatch := 0;
          PenHandle := ExtCreatePen(PS_GEOMETRIC or PS_DOT, Bmp.Canvas.Pen.Width, BrushStyle, 0, nil);
          NewPen := TPen.Create;
          try
            if lType and LT_ARROW = 0 then begin
              LineColor := Font.Color or $33000000;
              NewPen.Handle := PenHandle;
              Bmp.Canvas.Pen := NewPen;
              acgpDrawLine(Bmp.Canvas.Handle, p.X + 1, p.Y, p.X + 8, p.Y, LineColor);
              Bmp.Canvas.Brush.Color := 0;
              case lType and LT_LINEALL of
                LT_FIRST:
                  acgpDrawLine(Bmp.Canvas.Handle, p.X, p.Y + 1, p.X, Bmp.Height, LineColor);

                LT_LAST: begin
                  acgpDrawLine(Bmp.Canvas.Handle, p.X, 0, p.X, p.Y, LineColor);
                  DrawParentLine(Node.Parent, p);//Point(p.X, p.Y));
                end;

                LT_MIDDLE: begin
                  acgpDrawLine(Bmp.Canvas.Handle, p.X, 0, p.X, Bmp.Height, LineColor);
                  DrawParentLine(Node.Parent, p);//Point(p.X, p.Y));
                end;
              end;
            end;
            if Node.HasChildren and ShowButtons then
              PaintBtn(p, not Node.Expanded, MakeCacheInfo(Bmp));
          finally
            if PenHandle <> 0 then
              DeleteObject(PenHandle);

            NewPen.Free;
            Bmp.Canvas.Font.Color := BakColor;
          end;
        end;
        if bFocused and (sNdx < 0) and bSelected then begin
          InflateRect(rText, 1, 0);
          DrawFocusRect(Bmp.Canvas.Handle, rText);
        end;
        if not Enabled then begin
          DisabledKind := [dkBlended];
          BmpDisabledKind(Bmp, DisabledKind, Parent, CI, Point(nRect.Left + bw, nRect.Top + bw));
        end;
        BitBlt(DC, nRect.Left, nRect.Top, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
        FreeAndNil(Bmp);
        if aDC = 0 then
          ReleaseDC(Handle, DC);

        CallEvents(cdPostPaint);
      end
    end
    else
      Result := False;
  end
end;


function TsTreeViewEx.GetChecked(Node: TTreeNode): Boolean;
var
  Item: TTVItem;
begin
  Item.Mask := TVIF_STATE;
  Item.hItem := Node.ItemId;
  TreeView_GetItem(Node.TreeView.Handle, Item);
  Result := Item.State and TVIS_CHECKED = TVIS_CHECKED;
end;


procedure CheckSubNode(Sender: TsTreeViewEx; Node: TTreeNode);
var
  Flag: boolean;
begin
  if Node.HasChildren then begin
    Flag := Sender.GetChecked(Node);
    Node := Node.GetFirstChild;
    while Assigned(Node) do begin
      Sender.SetChecked(Node, flag);
      CheckSubNode(Sender, Node);
      Node := Node.GetNextChild(Node);
    end;
  end;
end;


procedure CheckParentNode(Sender: TsTreeViewEx; Node: TTreeNode);
begin
  if Node.Parent <> nil then begin
    Sender.SetChecked(Node.Parent, Sender.GetChecked(Node));
    CheckParentNode(Sender, Node.Parent);
  end;
end;


procedure TsTreeViewEx.InitEvents;
begin
  // Do nothing
end;


procedure TsTreeViewEx.UpdateColors;
var
  i: integer;
begin
  if not FColorsUpdated then begin
    FColorsUpdated := True;
    i := GetFontIndex(Self, SkinData.SkinIndex, SkinData.SkinManager);
    if i >= 0 then
      Font.Color := FCommonData.CommonSkinData.gd[i].Props[0].FontColor.Color
    else
      Font.Color := FCommonData.CommonSkinData.gd[FCommonData.SkinIndex].Props[0].FontColor.Color;

    if HandleAllocated then
      TreeView_SetTextColor(Handle, Font.Color);
  end;
end;


procedure TsTreeViewEx.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Node: TTreeNode;
begin
  inherited;
  if FAutoChildCheck then begin
    Node := GetNodeAt(X, Y);
    if (Node <> nil) and (GetHitTestInfoAt(X, Y) = [htOnItem, htOnStateIcon]) then
      CheckSubNode(Self, Node);
  end;
  if FAutoParentCheck then begin
    Node := GetNodeAt(X, Y);
    if (Node <> nil) and (GetHitTestInfoAt(X, Y) = [htOnItem, htOnStateIcon]) then
      CheckParentNode(Self, Node);
  end;
end;


procedure TsTreeViewEx.PaintItems(DC: hdc);
var
  SavedDC: hdc;
  Item: HTreeItem;
  Node: TTreeNode;
  LastBottom: integer;
begin
  if ListSW <> nil then begin
    SkinData.TranspMode := GetTransMode(SkinData);
    Item := TreeView_GetFirstVisible(Handle);
    Node := Items.GetNode(Item);
    LastBottom := 0;
    while Node <> nil do begin
      SavedDC := SaveDC(DC);
      try
        if DrawItem(DC, Node, []) then begin
          LastBottom := Node.DisplayRect(False).Bottom;
          Item := TreeView_GetNextVisible(Handle, Item);
          Node := Items.GetNode(Item);
          if Node <> nil then
            LastBottom := Node.DisplayRect(False).Bottom;
        end
        else
          Node := nil;
      finally
        RestoreDC(DC, SavedDC);
      end;
    end;
    BitBlt(DC, 0, LastBottom, Width, Height, SkinData.FCacheBmp.Canvas.Handle, ListSW.cxLeftEdge, ListSW.cyTopEdge + LastBottom, SRCCOPY);
  end;
end;


procedure TsTreeViewEx.SetCheckboxes(const Value: boolean);
var
  Flags: Cardinal;
begin
  if ((FCheckboxes <> Value) or Value) and not CheckRemoving then begin
    FCheckboxes := Value;
    Flags := GetWindowLong(Handle, GWL_STYLE);
    if FCheckboxes then
      SetWindowLong(Handle, GWL_STYLE, Flags or TVS_CHECKBOXES)
    else begin
      CheckRemoving := True;  
      SetWindowLong(Handle, GWL_STYLE, Flags and not TVS_CHECKBOXES);
      RecreateWnd;
      CheckRemoving := False;  
    end;
    Repaint;
  end;
end;


procedure TsTreeViewEx.SetChecked(Node: TTreeNode; Checked: Boolean);
var
  Item: TTVItem;
begin
  FillChar(Item, SizeOf(TTVItem), 0);
  with Item do begin
    hItem := Node.ItemId;
    Mask := TVIF_STATE;
    StateMask := TVIS_STATEIMAGEMASK;
    if Checked then
      Item.State := TVIS_CHECKED
    else
      Item.State := TVIS_CHECKED shr 1;

    TreeView_SetItem(Node.TreeView.Handle, Item);
  end;
end;


procedure TsTreeViewEx.SetLastHoverItem(const Value: TTreeNode);
var
  DC, SavedDC: hdc;
  TmpNode: TTreeNode;
begin
  if FLastHoverItem <> Value then
    if FLastHoverItem <> nil then begin
      TmpNode := FLastHoverItem;
      FLastHoverItem := Value;
      SavedDC := Canvas.Handle;
      DC := GetDC(Handle);
      Canvas.Handle := DC;
      Canvas.Lock;
      try
        if Selected = TmpNode then
          DrawItem(DC, TmpNode, [cdsSelected])
        else
          DrawItem(DC, TmpNode, []);
      finally
        Canvas.Unlock;
        Canvas.Handle := SavedDC;
      end;
      ReleaseDC(Handle, DC);
    end
    else
      FLastHoverItem := Value;
end;


procedure TsTreeViewEx.WMEraseBkGnd(var Message: TWMPaint);
var
  R: TRect;
  Item: HTreeItem;
  Node: TTreeNode;
  SavedDC, DC: hdc;
begin
  if not InUpdating(SkinData) and (ListSW <> nil) then begin
    if Message.DC <> 0 then
      DC := Message.DC
    else
      DC := GetWindowDC(Handle);

    SavedDC := SaveDC(DC);
    try
      if SkinData.BGChanged then
        PrepareCache(SkinData, Handle);

      Item := TreeView_GetFirstVisible(Handle);
      Node := Items.GetNode(Item);
      if Node <> nil then begin
        R := Node.DisplayRect(True);
        R.Left := 0;
        if (ListSW.sBarHorz <> nil) and (ListSW.sBarHorz.ScrollInfo.nTrackPos <> 0) then
          OffsetRect(R, -ListSW.sBarHorz.ScrollInfo.nTrackPos - ListSW.cxLeftEdge, 0);

        ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
        while True do begin
          Item := TreeView_GetNextVisible(Handle, Item);
          Node := Items.GetNode(Item);
          if Node = nil then
            Break;

          R := Node.DisplayRect(True);
          R.Left := 0;
          if (ListSW.sBarHorz <> nil) and (ListSW.sBarHorz.ScrollInfo.nTrackPos <> 0) then
            OffsetRect(R, -ListSW.sBarHorz.ScrollInfo.nTrackPos - ListSW.cxLeftEdge, 0);

          ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
        end;
      end;
      BitBlt(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, ListSW.cxLeftEdge, ListSW.cyTopEdge, SRCCOPY);
    finally
      RestoreDC(DC, SavedDC);
      if Message.DC = 0 then
        ReleaseDC(Handle, DC);
    end;
  end;
end;


procedure TsTreeViewEx.WMNCPaint(var Message: TMessage);
var
  bw: integer;
  DC: hdc;
begin
  if not InUpdating(SkinData) then begin
    if ListSW <> nil then
      bw := ListSW.cxLeftEdge
    else
      bw := 3 * integer(BorderStyle = bsSingle);

    if bw > 0 then begin
      DC := GetWindowDC(Handle);
      try
        if SkinData.BGChanged then
          PrepareCache(SkinData, Handle);

        BitBltBorder(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, bw);
      finally
        ReleaseDC(Handle, DC);
      end;
    end;
  end;
end;


procedure TsTreeViewEx.WMPaint(var Message: TWMPaint);
var
  DC: hdc;
  PS: TPaintStruct;
begin
  if SkinData.Skinned then begin
    UpdateColors;
    BeginPaint(Handle, PS);
    if not InUpdating(SkinData) then begin
      if Message.DC <> 0 then
        DC := Message.DC
      else
        DC := GetDC(Handle);

      try
        if Message.DC = 0 then
          with PS.rcPaint do
            IntersectClipRect(DC, Left, Top, Right, Bottom);

        PaintItems(DC);
      finally
        if Message.DC = 0 then
          ReleaseDC(Handle, DC);
      end;
    end;
    EndPaint(Handle, PS);
  end
  else inherited;
end;


procedure TsTreeViewEx.WndProc(var Message: TMessage);
var
  bw: integer;
  DC, SavedDC: hdc;
begin
{$IFDEF LOGGED}
//  AddToLog(Message);
{$ENDIF}
  if ControlIsReady(Self) and FCommonData.Skinned then
    case Message.Msg of
      SM_ALPHACMD:
        case Message.WParamHi of
          AC_REMOVESKIN, AC_REFRESH:
            FColorsUpdated := False;
        end;

      WM_ERASEBKGND: begin
        WMEraseBkGnd(TWMPaint(Message));
        Exit;
      end;

      WM_NCPAINT: begin
        WMNCPaint(Message);
        Exit;
      end;

      WM_PRINT: begin
        SkinData.Updating := False;
        SkinData.BGChanged := True;
        DC := TWMPaint(Message).DC;
        PrepareCache(SkinData, Handle);
        UpdateCorners(SkinData, 0);
        if ListSW <> nil then
          bw := ListSW.cxLeftEdge
        else
          bw := 3 * integer(BorderStyle = bsSingle);

        SavedDC := SaveDC(DC);
        try
          if (BidiMode = bdRightToLeft) and (ListSW <> nil) and (ListSW.sBarVert <> nil) and ListSW.sBarVert.fScrollVisible then
            MoveWindowOrg(DC, bw + GetScrollMetric(ListSW.sbarVert, SM_SCROLLWIDTH), bw)
          else
            MoveWindowOrg(DC, bw, bw);

          with SkinData.FCacheBmp do
            if PRF_CLIENT and Message.LParam = PRF_CLIENT then // Patch for using with BE
              BitBlt(DC, 0, 0, Width, Height, Canvas.Handle, 0, 0, SRCCOPY)
            else
              BitBlt(DC, 0, 0, Width, Height, Canvas.Handle, bw, bw, SRCCOPY);

{$IFNDEF D2005}
          if SkinData.FOwnerControl is TCustomListBox then begin // Fix empty ListBox drawing bug, fixed in latest Delphi versions
            if TCustomListBox(SkinData.FOwnerControl).Items.Count <> 0 then
              SendMessage(Handle, WM_PAINT, WPARAM(DC), 0);
          end
          else
{$ENDIF}
            SendMessage(Handle, WM_PAINT, WPARAM(DC), 0);
        finally
          RestoreDC(DC, SavedDC);
        end;
        if ListSW <> nil then begin
          BitBltBorder(DC, 0, 0, SkinData.FCacheBmp.Width, SkinData.FCacheBmp.Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, ListSW.cxLeftEdge);
          Ac_NCDraw(ListSW, Handle, -1, DC);
        end;
        Message.Result := 2; // Processed already
        Exit;
      end;

      WM_SIZE:
        SkinData.BGChanged := True;

      WM_PAINT: begin
        WMPaint(TWMPaint(Message));
        Exit;
      end;

      WM_SETFOCUS, WM_KILLFOCUS:
        FColorsUpdated := False;

      WM_MOUSEWHEEL, WM_VSCROLL: if SkinData.Skinned and (SkinData.CommonSkinData.gd[SkinData.SkinIndex].Props[0].Transparency > 0) then begin
        SetRedraw(Handle, 0);
        inherited;
        SetRedraw(Handle, 1);
        RedrawWindow(Handle, nil, 0, RDWA_ALLNOW);
        Exit;
      end;
    end;

  inherited;
  case Message.Msg of
    WM_HSCROLL:
      if (ListSW <> nil) and (ListSW.sBarHorz.ScrollInfo.nTrackPos = 0) then
        RedrawWindow(Handle, nil, 0, RDWA_ALLNOW);

    WM_MOUSELEAVE:
      LastHoverItem := nil;

    SM_ALPHACMD:
      case Message.WParamHi of
        AC_REMOVESKIN:
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) and HandleAllocated then begin
            if not SkinData.CustomColor then
              TreeView_SetBkColor(Handle, ColorToRGB(Color));

            if not SkinData.CustomColor then
              TreeView_SetTextColor(Handle, ColorToRGB(Font.Color));
          end;
      end;
  end;
end;

end.

