unit LMDCustomFormComboBox;
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

LMDCustomFormComboBox unit (VB)
--------------------------------

Changes
-------
Release 8.0 (August 2012)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LMDClass,
  LMDTypes, LMDCustomMaskEdit, LMDDropdownForm,
  LMDButtonBase, LMDButton, LMDSimplePanel, LMDBevel;

type
  TLMDOnCloseUpEvent = procedure(Sender : TObject; var NewText: TLMDString; OldText: TLMDString; Control: TWinControl; var aAcceptValue: boolean) of object;

type
  TLMDControlForm = class(TLMDDropDownForm)
  private
    FMainPanel: TLMDSimplePanel;
    FControlPanel: TLMDSimplePanel;
    FButtonPanel: TLMDSimplePanel;
    FOkBtn: TLMDButton;
    FCancelBtn: TLMDButton;
    FOldControlParent: TWinControl;

    procedure FormCreate(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure FormDestroy(Sender : TObject);

    procedure CMDeactivate(var Msg : TMessage); message CM_DEACTIVATE;
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure WMActivate(var Msg : TWMActivate); message WM_ACTIVATE;
  public
    constructor CreateNew(AOwner : TComponent; Dummy: Integer); override;
    procedure CreateParams(var Params : TCreateParams); override;
    procedure InitControl; virtual;
    procedure InitButtons; virtual;
  end;

type
  TLMDCustomFormComboBox = class(TLMDCustomMaskEdit)
  private
    FDroppedDown: boolean;
    FDropDownAlignment: TAlignment;
    FForm      : TLMDControlForm;
    FFormWidth: integer;
    FFormHeight: integer;
    FFormBorderWidth: integer;

    FEditorEnabled: Boolean;

    FAllowDropDown : Boolean;

    FOnDropDown: TNotifyEvent;
    FOnCloseUp: TLMDOnCloseUpEvent;

    FFormColor,
    FControlPanelColor,
    FButtonPanelColor: TColor;

    FKeepWithinForm: boolean;
    FOkCaption, FCancelCaption: TLMDString;
    FShowOkCancelButtons: boolean;

    FControl: TWinControl;
    FMainPanelBevel: TLMDBevel;

    procedure CMEnabledChanged (var Message : TMessage); message CM_ENABLEDCHANGED;
    procedure WMKILLFOCUS (var Message : TWMKillFocus); message WM_KILLFOCUS;
    procedure FormChange(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);

    procedure SetAllowDropDown(const Value: Boolean);
    procedure SetControl(const Value: TWinControl);
    procedure SetMainPanelBevel(const Value: TLMDBevel);
    function GetButtonPanel: TLMDSimplePanel;
    function GetControlPanel: TLMDSimplePanel;
    function GetMainPanel: TLMDSimplePanel;
  protected
    function AllowedOperation(textToInsert : TLMDString) : Boolean; override;
    procedure DoAClick (Btn : TObject; index : Integer); override;
    procedure DoDropDown; virtual;
    procedure DropDown; virtual;
    procedure DoThemeChanged; override;

    procedure DoCloseUp(var NewText: TLMDString; OldText: TLMDString; Control: TWinControl; var aAcceptValue: boolean);

    procedure CloseUp(AcceptValue : boolean); virtual;
    procedure CMCancelMode(var Msg: TCMCancelMode); message CM_CANCELMODE;
    procedure DestroyWnd; override;

    procedure GetCommandKey (var KeyCode : Word; Shift : TShiftState); override;
    procedure GetChange (Sender : TObject); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseExit; override;
    procedure ModifyPaintRect; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
  public
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;
    property DroppedDown: boolean read FDroppedDown;
    property MainPanel: TLMDSimplePanel read GetMainPanel;
    property ControlPanel: TLMDSimplePanel read GetControlPanel;
    property ButtonPanel: TLMDSimplePanel read GetButtonPanel;
  published
    property AutoSize;
    property Alignment;
    property CustomButtons;
    property CustomButtonsStyle default ubsCombo;
    property CustomButtonWidth;
    property CustomButtonParentCtlXP;

    property Control: TWinControl read FControl write SetControl;

    property FormColor: TColor read FFormColor write FFormColor default clBtnFace;
    property FormWidth: integer read FFormWidth write FFormWidth default -1;
    property FormHeight: integer read FFormHeight write FFormHeight default -1;
    property FormBorderWidth: integer read FFormBorderWidth write FFormBorderWidth default 0;
    property MainPanelBevel: TLMDBevel read FMainPanelBevel write SetMainPanelBevel;
    property ControlPanelColor: TColor read FControlPanelColor write FControlPanelColor default clBtnFace;
    property ButtonPanelColor: TColor read FButtonPanelColor write FButtonPanelColor default clBtnFace;

    property KeepWithinForm: boolean read FKeepWithinForm write FKeepWithinForm default false;

    property AllowDropDown: Boolean read FAllowDropDown write SetAllowDropDown default true;  { Published }

    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default true;

    property OkCaption: TLMDString read FOkCaption write FOkCaption;
    property CancelCaption: TLMDString read FCancelCaption write FCancelCaption;

    property ShowOkCancelButtons: boolean read FShowOkCancelButtons write FShowOkCancelButtons;

    property ReadOnly;

    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property OnCloseUp: TLMDOnCloseUpEvent read FOnCloseUp write FOnCloseUp;

    property Options;
    property MaskType;
    property Mask;
  end;


implementation

uses
  Math, LMDProcs, LMDBaseEdit, LMDGraph, LMDStrings;

{ ------------------------- private ------------------------------------------ }
procedure TLMDCustomFormComboBox.SetAllowDropDown(const Value: Boolean);
begin
  if (FAllowDropDown <> Value) then
  begin
    FAllowDropDown := Value;
    if FAllowDropDown then
    begin
      CustomButtons.Insert(0);
      CustomButtons.Items[0].Btn.Style:=ubsCombo;
      CustomButtons.Items[0].Btn.ThemeMode := Self.ThemeMode;


      FForm := TLMDControlForm.CreateNew(Self, 0);

      //FForm.Font.Assign(Font);
      FForm.Visible := false;
      FForm.FormStyle := fsStayOnTop;
      FForm.Position := poDesigned;
      FForm.BorderStyle := bsNone;

      //FForm.OnKeyDown := CalendarKeyDown;
      FForm.OnChange := FormChange;
      FForm.OnDeactivate := FormDeactivate;
    end
    else
    begin
      CustomButtons.Delete(0);
      if Assigned(FForm) then
        FreeAndNil(FForm);
    end;
  end;  { if }
end;  { SetAllowDropDown }

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.WMKILLFOCUS (var Message : TWMKillFocus);
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.FormChange(Sender: TObject);
begin
  if not Assigned(FForm) then
    exit;
  if true then //in range
    CloseUp(true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.FormDeactivate(Sender: TObject);
begin
  if not Assigned(FForm) then
    exit;
  if FForm.ModalResult = mrYes then
  begin
    CloseUp(True);
    FForm.ModalResult := mrNone;
  end
  else
    CloseUp(False);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.CloseUp(AcceptValue: boolean);
var
  s: TLMDString;
begin
  if not Assigned(FForm) then exit;
  if DroppedDown then
  begin
    if FForm.Visible then
    begin
      SetWindowPos(FForm.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
        SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
      FForm.Visible := False;
    end;

    DoCloseUp(s, Text, FControl, AcceptValue);
    if AcceptValue then
      Text := s;

    FDroppedDown := false;

    CustomButtons.Items[0].Btn.Down := false;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.CMCancelMode(var Msg: TCMCancelMode);
begin
  if (Msg.Sender <> Self) and
     (Msg.Sender <> CustomButtons.Items[0].Btn) and (Msg.Sender <> FForm) then
   CloseUp(False);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.CMEnabledChanged (var Message : TMessage);
begin
  inherited;
end;

{ ------------------------- protected ---------------------------------------- }
procedure TLMDCustomFormComboBox.DoAClick(Btn: TObject; index: Integer);
begin
  inherited;
  if index = 0 then
    DropDown;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.DoDropDown;
begin
  if Assigned(FOnDropDown) then FOnDropDown(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.DropDown;
var
  P, P1: TPoint;
  AForm : TCustomForm;

begin
  if not Assigned(FForm) then exit;

  if FForm.Visible then
  begin
    CloseUp(False);
  end
  else
  begin
    if not ReadOnly then
    begin

      with FForm do
      begin
        if Assigned(MainPanelBevel) then
          FMainPanel.Bevel.Assign(MainPanelBevel);
        FMainPanel.Visible := true;
        BorderWidth := TLMDCustomFormComboBox(Owner).FormBorderWidth;
      end;

      FForm.Color := FControlPanelColor;

      if not Focused then
        SetFocus;

      P := Parent.ClientToScreen(Point(Left, Top));

      Inc(P.Y, Height);
      if P.Y + FForm.Height > Screen.DesktopHeight then
        P.Y := P.Y - FForm.Height - Height;

      Inc(P.X, Width);
      if (FDropDownAlignment = TAlignment(taRightJustify)) {xor RightAlignedView} then
        Dec(P.X, FForm.Width)
      else
        Dec(P.X, self.Width);

      if (P.X + FForm.Width > Screen.DesktopWidth) then
      begin
        P1 := P;
        P1.x := (Left + Width) - FForm.Width;
        P1 := Parent.ClientToScreen(P1);
        P.X := P1.x;
      end;

      if KeepWithinForm then
      begin
        AForm := GetParentForm(Self);
        if AForm <> nil then
        begin
          if P.Y + FForm.Height > AForm.Top + AForm.Height then
            P.Y := P.Y - FForm.Height - Height;

          if P.X + FForm.Width > AForm.Left + AForm.Width then
          begin
            P1 := P;
            P1.x := (Left + Width) - TForm(FForm).Width;
            P1 := Parent.ClientToScreen(P1);
            P.X := P1.x;
          end;
        end;
      end;

      SetWindowPos(FForm.Handle, HWND_TOPMOST, P.X, P.Y, 0, 0,
        SWP_NOACTIVATE or SWP_SHOWWINDOW or SWP_NOSIZE or SWP_NOZORDER);

      FDroppedDown := true;

      DoDropDown;
      FForm.Visible := True;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.GetCommandKey (var KeyCode : Word; Shift : TShiftState);
begin
   inherited GetCommandKey (KeyCode, Shift);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.GetChange (Sender : TObject);
begin
  inherited GetChange (Sender);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomFormComboBox.AllowedOperation(textToInsert : TLMDString) : Boolean;
begin
  result := inherited AllowedOperation(textToInsert) and FEditorEnabled;
end;


{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove (Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.MouseExit;
begin
  inherited MouseExit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.DoThemeChanged;
begin
  inherited;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDCustomFormComboBox.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);

  FKeepWithinForm := false;

  FFormWidth := -1;
  FFormHeight :=  -1;

  FFormColor := clBtnFace;
  FControlPanelColor := clBtnFace;
  FButtonPanelColor := clBtnFace;
  FShowOkCancelButtons := true;

  FEditorEnabled := true;
  FMainPanelBevel := TLMDBevel.Create(nil);
  FFormBorderWidth := 0;

  BeginUpdate;
  try
    inherited CustomButtonsStyle:=ubsCombo;
  finally
    EndUpdate;
  end;

  AllowDropDown := true;
end;




{ ---------------------------------------------------------------------------- }
destructor TLMDCustomFormComboBox.Destroy;
begin
  inherited Destroy;
  FMainPanelBevel.Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.DestroyWnd;
begin
  if DroppedDown then
    CloseUp(false);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.Loaded;
begin
  inherited Loaded;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.ModifyPaintRect;
begin
  inherited ModifyPaintRect;
end;


{ ----------------------------- TLMDControlForm ----------------------------- }
procedure TLMDControlForm.CMDeactivate(var Msg: TMessage);
begin
  inherited;
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDControlForm.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited CreateNew(AOwner, Dummy);
  Width := 360;
  Height := 220;
  OnCreate := FormCreate;
  OnClose := FormClose;
  OnShow := FormShow;
  OnDestroy := FormDestroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDControlForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := WS_POPUP {or WS_BORDER};
    ExStyle := WS_EX_TOPMOST;
  end;
end;

procedure TLMDControlForm.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
end;

procedure TLMDControlForm.FormCreate(Sender: TObject);
begin
  FMainPanel := TLMDSimplePanel.Create(Self);

  with FMainPanel do
  begin
    Parent := Self;
    Transparent := true;
    Visible := false;
    Align := alClient;
  end;

  if TLMDCustomFormComboBox(Owner).ShowOkCancelButtons then
  begin
    FButtonPanel := TLMDSimplePanel.Create(Self);
    with FButtonPanel do
    begin
      Parent := FMainPanel;
      Visible := false;
      Align := alBottom;
      Height := 30;
      FCancelBtn := TLMDButton.Create(FButtonPanel);
      FCancelBtn.Parent := FButtonPanel;
      FCancelBtn.Caption := 'Cancel';
      FCancelBtn.ModalResult := mrCancel;
      FCancelBtn.OnClick := CancelBtnClick;
      FOkBtn := TLMDButton.Create(FButtonPanel);
      FOkBtn.ModalResult := mrYes;
      FOkBtn.Parent := FButtonPanel;
      FOkBtn.Caption := 'Ok';
      FOkBtn.OnClick := OkBtnClick;
    end;
  end;

  FControlPanel := TLMDSimplePanel.Create(Self);
  with FControlPanel do
  begin
    Parent := FMainPanel;
    Visible := false;
    Align := alClient;
  end;

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDControlForm.FormShow(Sender: TObject);
begin
  if TLMDCustomFormComboBox(Owner).FormWidth > 0 then
    Width := TLMDCustomFormComboBox(Owner).FormWidth;
  if TLMDCustomFormComboBox(Owner).FormHeight > 0 then
    Height := TLMDCustomFormComboBox(Owner).FormHeight;
  if TLMDCustomFormComboBox(Owner).ShowOkCancelButtons then
    InitButtons;
 InitControl;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDControlForm.InitControl;
var
  lControl: TWinControl;
begin
  lControl := TLMDCustomFormComboBox(Owner).FControl;
  if Assigned(lControl) then
  begin
    FControlPanel.Visible := true;
    FOldControlParent := lControl.Parent;
    lControl.Parent := FControlPanel;
    lControl.Align := alClient;
    lControl.Visible := true;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDControlForm.InitButtons;
var
  r, br: TRect;
  m: integer;
begin
  if TLMDCustomFormComboBox(Owner).ShowOkCancelButtons then
  begin
    FButtonPanel.Visible := true;
    FButtonPanel.Color := TLMDCustomFormComboBox(Owner).ButtonPanelColor;;
    r := FButtonPanel.ClientRect;
    br := r;
    m := (r.Left + r.Right) div 2;
    br.Right := m;
    InflateRect(br, -20, -5);
    FCancelBtn.SetBounds(br.Left, br.Top, br.Right - br.Left, br.Bottom - br.Top);
    if TLMDCustomFormComboBox(Owner).FCancelCaption <> '' then
      FCancelBtn.Caption := TLMDCustomFormComboBox(Owner).FCancelCaption;
    OffSetRect(br, m, 0);
    FOkBtn.SetBounds(br.Left, br.Top, br.Right - br.Left, br.Bottom - br.Top);
    if TLMDCustomFormComboBox(Owner).FOkCaption <> '' then
      FOkBtn.Caption := TLMDCustomFormComboBox(Owner).FOkCaption;
  end;
end;


{ ---------------------------------------------------------------------------- }
procedure TLMDControlForm.WMActivate(var Msg: TWMActivate);
begin
  inherited;
  if Msg.Active = WA_INACTIVE then
  begin
    if Assigned(FOnDeactivate) then FOnDeactivate(Self);
  end
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.DoCloseUp(var NewText: TLMDString; OldText: TLMDString; Control: TWinControl; var aAcceptValue: boolean);
begin
  if Assigned(FOnCloseUp) then
    FOnCloseUp(Self, NewText, OldText, FControl, aAcceptValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (aComponent = FControl) then
    FControl := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDControlForm.FormDestroy(Sender: TObject);
begin
//
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.SetControl(const Value: TWinControl);
begin
  if Value <> Self then
    FControl := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFormComboBox.SetMainPanelBevel(const Value: TLMDBevel);
begin
  MainPanelBevel.Assign(Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomFormComboBox.GetButtonPanel: TLMDSimplePanel;
begin
  if Assigned(FForm) then
    result := FForm.FButtonPanel
  else
    result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomFormComboBox.GetControlPanel: TLMDSimplePanel;
begin
  if Assigned(FForm) then
    result := FForm.FControlPanel
  else
    result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomFormComboBox.GetMainPanel: TLMDSimplePanel;
begin
  if Assigned(FForm) then
    result := FForm.FMainPanel
  else
    result := nil;
end;

end.
