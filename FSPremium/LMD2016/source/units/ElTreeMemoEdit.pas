unit ElTreeMemoEdit;
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

ElTreeMemoEdit unit
-------------------


Changes
-------
Release 7.0, 2008 (EK)
 + Validation support added;
 - Invalid typecaset fixed (elpack newgroup message "Bug" from Sanyin 14.05.2009)

Release 6.0 (February 2007)
 - Initial Release


###############################################################################}

interface

uses
  Windows, Messages, Controls, Forms, Graphics, SysUtils, Classes, Types,
  StdCtrls, Math,
  LMDThemes, UxTheme, Themes, LMDClass, LMDProcs, LMDGraph, LMDVldBase,
  ElStyleMan, ElTree, ElHeader, ElEdits, ElTreeInplaceEditors, ElVCLUtils;

type
  TElTreeInplaceMemoEdit = class;

  TMemoForm = class(TForm)
  private
    FTreeMemoEdit: TElTreeInplaceMemoEdit;
    procedure WMMouseActivate(var Msg: TWMMouseActivate); message WM_MOUSEACTIVATE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMNCHitTest(var Msg : TWMNCHitTest); message WM_NCHITTEST;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMEnterSizeMove(var Message: TMessage); message WM_ENTERSIZEMOVE;
    procedure WMExitSizeMove(var Message: TMessage); message WM_EXITSIZEMOVE;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
        WM_WINDOWPOSCHANGED;
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
  public
    constructor CreateNew(AOwner : TComponent; Dummy : integer =
        0);  override;
  end;

  TElInpMemo = class(TElMemo)
  private
    FTreeMemoEdit: TElTreeInplaceMemoEdit;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
  protected
    procedure Paint; override;
  end;

  TElTreeInplaceMemoEdit = class(TElTreeInplaceEditor)
  private
    FForm : TMemoForm;
    FShowGripper: Boolean;
    FIgnoreFocus: Boolean;
    procedure SetHeight(value: Integer);
    function GetHeight: Integer;
    procedure SetShowGripper(Value: Boolean);
    procedure SetStressShortCut(Value: TShortCut);
    function GetStressShortCut: TShortCut;
    function GetValidationMsgString: string;
    function GetValidator: TLMDValidationEntity;
    procedure SetValidationMsgString(const Value: string);
    procedure SetValidator(const Value: TLMDValidationEntity);
    function GetOnValidationError: TLMDValidationErrorEvent;
    procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
  protected
    procedure SetFont(const Value: TFont);
    procedure AdjustBounds; override;
    function GetEditor: TElMemo;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted : boolean); override;
    function GetVisible: Boolean; override;
    procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
        boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
    procedure SetEditorParent; override;
    function GetStyleManager: TElStyleManager;
    function GetStyleName: string;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure TriggerValidateResult(var InputValid: boolean); override;
    property Editor: TElMemo read GetEditor;
  published
    property Font;
    property Height: integer read GetHeight write SetHeight default 89;
    property StyleManager: TElStyleManager read GetStyleManager write
        SetStyleManager;
    property StyleName: string read GetStyleName write SetStyleName;
    property ShowGripper: Boolean read FShowGripper write SetShowGripper default
        false;
    property StressShortCut: TShortCut read GetStressShortCut write SetStressShortCut default 0;
    property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
  end;

implementation

uses
  ElXtree

  ;

constructor TElTreeInplaceMemoEdit.Create(AOwner : TComponent);
begin
  inherited;
  FForm := TMemoForm.CreateNew(Self);
  FForm.Visible := False;
  FForm.BorderStyle := bsNone;
  FForm.FormStyle := fsStayOnTop;
//  with TElFormPersist.Create(FForm) do
//    TopMost := true;

  FEditor := TElInpMemo.Create(FForm);
  (FEditor as TElInpMemo).FTreeMemoEdit := Self;
  Editor.BorderColorDkShadow := clBlack;
  Editor.BorderColorFace := clBlack;
  Editor.BorderColorShadow := clBlack;
  Editor.BorderColorHighlight := clBlack;
  Editor.BorderColorWindow := clBlack;
  FEditor.parent := FForm;
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  Editor.HandleDialogKeys := true;

  FTypes := [sftText, sftMemo];
  FForm.Height := 89;
  FForm.Width := 10;
end;

destructor TElTreeInplaceMemoEdit.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  FForm.Free;
  inherited;
end;

procedure TElTreeInplaceMemoEdit.SetStressShortCut(Value: TShortCut);
begin
  Editor.StressShortCut := Value;
end;

function TElTreeInplaceMemoEdit.GetStressShortCut: TShortCut;
begin
  Result := Editor.StressShortCut;
end;

procedure TElTreeInplaceMemoEdit.DoStartOperation;
begin
  FForm.Visible := True;
  FEditor.SetFocus;
end;

procedure TElTreeInplaceMemoEdit.DoStopOperation(Accepted : boolean);
begin
  FForm.Visible := false;
  FForm.Parent := nil;
  inherited;
end;

type THackElTree = class(TCustomElTree);

function TElTreeInplaceMemoEdit.GetVisible: Boolean;
begin
  Result := FForm.Visible;
end;

procedure TElTreeInplaceMemoEdit.TriggerAfterOperation(var Accepted : boolean;
    var DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := Editor.Text;
end;

procedure TElTreeInplaceMemoEdit.TriggerBeforeOperation(var DefaultConversion :
    boolean);
var
  TempH: integer;
begin
  inherited;
  if Item is TElXTreeItem then
    TempH := (Item as TElXTreeItem).Height
  else
    TempH := (Item as TElTreeItem).Height;

  if DefaultConversion then
    Editor.Text := ValueAsText;
  if (Editor.Lines.Count > Round(FForm.Height/TempH)) then
    Editor.ScrollBars := ssVertical
  else
    Editor.ScrollBars := ssNone;

  AdjustBounds;

end;

procedure TElTreeInplaceMemoEdit.TriggerValidateResult(var InputValid: boolean);
begin
  if Assigned(Validator) then
    InputValid := Validator.Validate(Editor, false) = 0;
  inherited TriggerValidateResult(InputValid);
end;

procedure TElTreeInplaceMemoEdit.SetEditorParent;
begin
//  FEditor.Parent := FTree.View;
//  FForm.Parent := GetParentForm(FTree.View);
end;

procedure TElTreeInplaceMemoEdit.SetFont(const Value: TFont);
begin
  FFont := Value;
end;

function TElTreeInplaceMemoEdit.GetHeight: Integer;
begin
  if Assigned(FForm) then
    Result := FForm.Height
  else
    Result := 0;
end;

procedure TElTreeInplaceMemoEdit.SetHeight(value: Integer);
begin
  if Assigned(FForm) then
    FForm.Height := Value;
end;

function TElTreeInplaceMemoEdit.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElTreeInplaceMemoEdit.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElTreeInplaceMemoEdit.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElTreeInplaceMemoEdit.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

{ TMemoForm }

constructor TMemoForm.CreateNew(AOwner: TComponent; Dummy: integer);
begin
  inherited CreateNew(nil);
  FTreeMemoEdit := TElTreeInplaceMemoEdit(AOwner);
end;

procedure TMemoForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_POPUP{ or WS_BORDER};
    ExStyle := ExStyle or WS_EX_TOOLWINDOW;
    WndParent := GetDesktopWindow;
  end;
end;

procedure TMemoForm.WMEnterSizeMove(var Message: TMessage);
begin
  inherited;
  FTreeMemoEdit.FIgnoreFocus := true;
end;

procedure TMemoForm.WMExitSizeMove(var Message: TMessage);
var AForm : TCustomForm;
begin
  AForm := GetParentForm(FTreeMemoEdit.FTree);
  if (AForm <> nil) and (AForm.CanFocus) then
    AForm.SetFocus;
  Windows.SetFocus(FTreeMemoEdit.FEditor.Handle);
  FTreeMemoEdit.FIgnoreFocus := false;
  inherited;
end;

procedure TElTreeInplaceMemoEdit.SetShowGripper(Value: Boolean);
begin
  if FShowGripper <> Value then
  begin
    FShowGripper := Value;
    SetWindowPos(FForm.Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER or SWP_NOACTIVATE or SWP_FRAMECHANGED);
  end;
end;

procedure TMemoForm.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
var
  tp: PMinMaxInfo;
  begin
  inherited;
//  tp := PMinMaxInfo(Message.LParam);
  tp := Message.MinMaxInfo;
  tp.ptMinTrackSize.y := FTreeMemoEdit.FCellRect.Bottom - FTreeMemoEdit.FCellRect.Top;

  if FTreeMemoEdit.Editor.VertScrollBarStyles.Visible then
  begin
    if FTreeMemoEdit.Editor.UseCustomScrollBars then
      inc(tp.ptMinTrackSize.x, FTreeMemoEdit.Editor.VertScrollBarStyles.Depth)
    else
      inc(tp.ptMinTrackSize.x, GetSystemMetrics(SM_CYVSCROLL));
  end;

  if FTreeMemoEdit.FShowGripper then
    inc(tp.ptMinTrackSize.y, GetSystemMetrics(SM_CYHSCROLL));
  inc(tp.ptMinTrackSize.y, GetSystemMetrics(SM_CYBORDER) * 2);
  Message.MinMaxInfo := tp;
  Message.Result := 1;
end;

procedure TMemoForm.WMMouseActivate(var Msg: TWMMouseActivate);
begin
  Msg.Result := MA_NOACTIVATE;
end;

procedure TMemoForm.WMNCHitTest(var Msg: TWMNCHitTest);
var
  R : TRect;
begin
  inherited;
  if FTreeMemoEdit.FShowGripper and
    (Msg.Result <> HTVSCROLL) and (Msg.Result <> HTHSCROLL){}
  then
  begin
    R := BoundsRect;
    OffsetRect(R, -Left, -Top);
    R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL);
    R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL);
    if PtInRect(R, ScreenToClient(SmallPointToPoint(Msg.Pos))) then
      Msg.Result := HTBOTTOMRIGHT
    else
    if R.Top < ScreenToClient(SmallPointToPoint(Msg.Pos)).Y then
      Msg.Result := HTNOWHERE;
  end;
end;

procedure TMemoForm.WMSetFocus(var Message: TWMSetFocus);
begin
  Windows.SetFocus(Message.FocusedWnd);
end;

procedure TMemoForm.WMWindowPosChanged(var Message: TWMWindowPosChanged);
var
  adj : integer;
begin
  inherited;
  if FTreeMemoEdit.FShowGripper then
    adj := GetSystemMetrics(SM_CYHSCROLL)
  else
    adj := 0;
  FTreeMemoEdit.FEditor.SetBounds(0, 0, Message.WindowPos.cx, Message.WindowPos.cy - adj);
  FTreeMemoEdit.FEditor.Invalidate;
end;

{ TElInpMemo }
  procedure TElInpMemo.Paint;
var DC : HDC;
    R  : TRect;
    LUseThemeMode: TLMDThemeMode;
    LDetails: TThemedElementDetails;
begin
  inherited;
  LUseThemeMode := UseThemeMode;
  if FTreeMemoEdit.ShowGripper then
  begin
    DC := GetWindowDC(FTreeMemoEdit.FForm.Handle);
    GetWindowRect(FTreeMemoEdit.FForm.Handle, R);

    OffsetRect(R, -R.Left, -R.Top);
    R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL) - 1;
    if FTreeMemoEdit.Editor.IsThemed and (BorderStyle = bsSingle) then
      begin
        LDetails.Element := teListView;
        LDetails.Part := 0;
        LDetails.State := 0;
        LMDThemeServices.DrawElement(LUseThemeMode, DC, LDetails, R, nil);

      end
    else
      with FTreeMemoEdit do
        ElVCLUtils.DrawFlatFrameEx2(DC, R, clWindowFrame, Color, False, True,[ebsLeft, ebsRight, ebsBottom], fbtColorLineBorder, clBlack,clBlack,clBlack,clBlack, clBlack);
    // fill rect:
    GetWindowRect(FTreeMemoEdit.FForm.Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    InflateRect(R, -GetSystemMetrics(SM_CXEDGE), 0);
    Dec(R.Bottom, GetSystemMetrics(SM_CYEDGE));
    R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL)+2;
    if FTreeMemoEdit.Editor.IsThemed then
    begin
      FillRect(DC, R, HBRUSH(LMDThemeServices.GetThemeSysColor(FTreeMemoEdit.Editor.UseThemeMode, teEdit, clBtnFace) + 1));
      R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL);
      LDetails.Element := teStatus;
      LDetails.Part := SP_GRIPPER;
      LDetails.State := CBS_SCROLLSIZEGRIP;
      LMDThemeServices.DrawElement(LUseThemeMode, DC, LDetails, R, nil);

    end
    else
      DrawFrameControl(DC, R, DFC_SCROLL, DFCS_SCROLLSIZEGRIP);
    ReleaseDC(FTreeMemoEdit.FForm.Handle, DC);
  end;
end;

procedure TElInpMemo.WMKeyDown(var Message: TWMKeyDown);
var InputValid : boolean;
begin
  if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
  begin
    if TWMKey(Message).CharCode = VK_RETURN then
    begin
      InputValid := true;
      FTreeMemoEdit.FEditing := false;
      FTreeMemoEdit.TriggerValidateResult(InputValid);
      FTreeMemoEdit.FEditing := true;
      if InputValid then
      begin
        FTreeMemoEdit.CompleteOperation(true);
        TWMKey(Message).CharCode := 0;
        exit;
      end
      else
        SetFocus;
      TWMKey(Message).CharCode := 0;
    end
    else
    if TWMKey(Message).CharCode = VK_ESCAPE then
    begin
      FTreeMemoEdit.CompleteOperation(false);
      TWMKey(Message).CharCode := 0;
      exit;
    end;
  end;
  inherited;
end;

procedure TElInpMemo.WMKillFocus(var Msg: TWMKillFocus);
var InputValid : boolean;
begin
  if FTreeMemoEdit.FEditing and (not FTreeMemoEdit.FIgnoreFocus) then
  begin
    if THackElTree(FTreeMemoEdit.Tree).ExplorerEditMode then
    begin
      if not FTreeMemoEdit.InputChecked then
      begin
        InputValid := true;
        FTreeMemoEdit.TriggerValidateResult(InputValid);
        FTreeMemoEdit.CompleteOperation(InputValid);
      end
      else
        FTreeMemoEdit.CompleteOperation(true);
    end
    else
      FTreeMemoEdit.CompleteOperation(false);
  end;
end;

procedure TElTreeInplaceMemoEdit.AdjustBounds;
var
  P: TPoint;
  W, H, H1, TempH: integer;
begin
  P := FTree.ClientToScreen(Point(FCellRect.Left,FCellRect.Bottom));

  if FTree is TElXTree then
    begin
      if TElXTree(FTree).ShowColumns then
        TempH := TElXTree(FTree).HeaderHeight
      else
        TempH := 0;
    end
  else
    begin
      if TElTree(FTree).ShowColumns then
        TempH := TElTree(FTree).HeaderHeight
      else
        TempH := 0;
    end;

  Inc(P.Y, TempH);

//  P := GetParentForm(FTree).ClientToScreen(Point(FCellRect.Left + FTree.Left,FCellRect.Bottom + FTree.Top));
//  Inc(P.Y,2*GetSystemMetrics(SM_CXEDGE));
  W := max((FCellRect.Right - FCellRect.Left),FForm.Width);
  H := FForm.Height;
  H1 := FForm.Height - (FCellRect.Bottom - FCellRect.Top);
  if ((FCellRect.Bottom + H) > self.Tree.Height) and ((FCellRect.Bottom - H) > 0) then
    Dec(P.Y, H1 + 2*(FCellRect.Bottom - FCellRect.Top));
  FForm.SetBounds(P.X, P.Y, W, H);
end;

function TElTreeInplaceMemoEdit.GetEditor: TElMemo;
begin
  Result := FEditor as TElMemo;
end;

function TElTreeInplaceMemoEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElTreeInplaceMemoEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElTreeInplaceMemoEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElTreeInplaceMemoEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElTreeInplaceMemoEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElTreeInplaceMemoEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

end.
