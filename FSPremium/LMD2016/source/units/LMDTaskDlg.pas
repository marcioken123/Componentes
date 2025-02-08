unit LMDTaskDlg;
{$I LMDCmps.inc}

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

LMDTaskDlg unit (AH)
--------------------


Changes
-------
Release 8.0 (December 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Graphics, Forms, Classes, Windows, intfLMDBase, LMDProcs, LMDSysIn,
  {$IFDEF LMDCOMP11}CommCtrl,{$ENDIF} LMDTypes, LMDCustomComponent, LMDTaskDialog,
  LMDClass;

type
  TLMDTaskDialog = class;

  TLMDTaskDlgProgressState = (tdpsNormal, tdpsError, tdsPaused);

  TLMDTaskDlgIcon = (tdiBlank, tdiWarning, tdiQuestion, tdiError,
                       tdiInformation, tdiBlankAgain, tdiShield);

  TLMDTaskDialogCommonButton = (tdcbOk, tdcbYes, tdcbNo, tdcbCancel, tdcbRetry, tdcbClose);
  TLMDTaskDialogCommonButtons = set of TLMDTaskDialogCommonButton;

  TLMDTaskDialogFlag = (tdfEnableHyperlinks,
                          tdfUseHiconMain,
                          tdfUseHiconFooter,
                          tdfAllowDialogCancellation,
                          tdfUseCommandLinks,
                          tdfUseCommandLinksNoIcon,
                          tdfExpandFooterArea,
                          tdfExpandedByDefault,
                          tdfVerificationFlagChecked,
                          tdfShowProgressBar,
                          tdfShowMarqueeProgressBar,
                          tdfCallbackTimer,
                          tdfPositionRelativeToWindow,
                          tdfRtlLayout,
                          tdfNoDefaultRadioButton,
                          tdfCanBeMinimized);

  TLMDTaskDialogFlags = set of TLMDTaskDialogFlag;

  // Custom events for handle task dialog notifications
  TLMDOnTaskDialogHyperlink = procedure (Sender: TObject; AHref: WideString) of object;
  TLMDOnTaskDialogTimer = procedure (Sender: TObject; ATickCount: Cardinal) of object;
  TLMDOnTaskDialogChecked = procedure (Sender: TObject; AState: Boolean) of object;
  TLMDOnTaskDialogButtonClick = procedure (Sender: TObject; var ANoCloseDialog: Boolean) of object;
  TLMDOnTaskDialogCommonButtonClick = procedure(Sender: TObject; AButtonId: TLMDTaskDialogCommonButton; var ANoCloseDialog: Boolean) of object;

  TLMDTaskDlgControl = class(TPersistent)
  protected
    FOwner: TLMDTaskDialog;
    procedure InitControl; virtual; abstract;
  public
    constructor Create(AOwner: TLMDTaskDialog); virtual;
  end;

  TLMDTaskProgressBar = class(TLMDTaskDlgControl)
  private
    FMin: Integer;
    FPosition: Integer;
    FMax: Integer;
    FState: TLMDTaskDlgProgressState;
    FMarquee: Boolean;
    FMarqueeSpeed: Integer;
    procedure SetMax(const Value: Integer);
    procedure SetMin(const Value: Integer);
    procedure SetPosition(const Value: Integer);
    procedure SetState(const Value: TLMDTaskDlgProgressState);
    procedure SetMarquee(const Value: Boolean);
    procedure SetMarqueeSpeed(const Value: Integer);
  protected
    procedure InitControl; override;
  public
    constructor Create(AOwner: TLMDTaskDialog); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Marquee: Boolean read FMarquee write SetMarquee default False;
    property MarqueSpeed: Integer read FMarqueeSpeed write SetMarqueeSpeed default 0;
    property State: TLMDTaskDlgProgressState read FState write SetState default tdpsNormal;
    property Min: Integer read FMin write SetMin default 0;
    property Max: Integer read FMax write SetMax default 100;
    property Position: Integer read FPosition write SetPosition default 0;
  end;

  TLMDTaskDlgBaseButton = class(TCollectionItem)
  private
    FButtonId: Integer;
    FCaption: WideString;
    FEnabled: Boolean;
    function GetTaskDialog: TLMDTaskDialog;
  protected
    function GetIsDefault: Boolean; virtual; abstract;
    procedure InitButton; virtual; abstract;
    procedure SetEnabled(const Value: Boolean); virtual; abstract;
    procedure SetIsDefault(const Value: Boolean); virtual; abstract;
    property TaskDialog: TLMDTaskDialog read GetTaskDialog;
  public
    procedure Click; virtual; abstract;
  published
    property ButtonId: Integer read FButtonId write FButtonId;
    property Caption: WideString read FCaption write FCaption;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property IsDefault: Boolean read GetIsDefault write SetIsDefault default False;
  end;

  TLMDTaskDlgRadioButton = class(TLMDTaskDlgBaseButton)
  private
    FOnClick: TNotifyEvent;
  protected
    function GetIsDefault: Boolean; override;
    procedure TriggerClick(Sender: TObject); virtual;
    procedure SetEnabled(const Value: Boolean); override;
    procedure SetIsDefault(const Value: Boolean); override;
    procedure InitButton; override;
  public
    procedure Click; override;
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TLMDTaskDlgButton = class(TLMDTaskDlgBaseButton)
  private
    FIsElevationButton: Boolean;
    FOnClick: TLMDOnTaskDialogButtonClick;
    procedure SetIsElevationButton(const Value: Boolean);
  protected
    procedure TriggerClick(Sender: TObject; var ANoCloseDialog: Boolean); virtual;
    procedure SetEnabled(const Value: Boolean); override;
    procedure SetIsDefault(const Value: Boolean); override;
    procedure InitButton; override;
    function GetIsDefault: Boolean; override;
  public
    procedure Click; override;
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property IsElevationButton: Boolean read FIsElevationButton write SetIsElevationButton default False;
    property OnClick: TLMDOnTaskDialogButtonClick read FOnClick write FOnClick;
  end;

  TLMDTaskDlgButtons = class(TOwnedCollection)
  private
    function IntGetOwner: TLMDTaskDialog;
    function GetButton(Index: Integer): TLMDTaskDlgBaseButton;
  protected
    property TaskDialog: TLMDTaskDialog read IntGetOwner;
    function GetNativeArray: Pointer;
    procedure FreeNativeArray(AArray: Pointer);
    public
    property Buttons[Index: Integer]: TLMDTaskDlgBaseButton read GetButton;
  end;

  TLMDTaskDialog = class(TLMDCustomComponent, ILMDComponent)
  private
    FHandle: THandle;
    FConfig: TASKDIALOGCONFIG;
    FResetTimer: Boolean;
    FIsNavigate: Boolean;
    FProgressBar: TLMDTaskProgressBar;
    FFlags: TLMDTaskDialogFlags;
    FFooterIcon: TLMDTaskDlgIcon;
    FMainIcon: TLMDTaskDlgIcon;
    FCustomFooterIcon: TIcon;
    FCustomMainIcon: TIcon;
    FRadioButtons: TLMDTaskDlgButtons;
    FButtons: TLMDTaskDlgButtons;
    FOnDialogConstructed: TNotifyEvent;
    FOnHelp: TNotifyEvent;
    FOnDestroyed: TNotifyEvent;
    FOnNavigated: TNotifyEvent;
    FOnCreated: TNotifyEvent;
    FOnHyperlink: TLMDOnTaskDialogHyperlink;
    FOnTimer: TLMDOnTaskDialogTimer;
    FOnVerificationClicked: TLMDOnTaskDialogChecked;
    FOnExpandoButtonClicked: TLMDOnTaskDialogChecked;
    FResultRadioButtonId: integer;
    FResultButtonId: integer;
    FResultVerificationState: Boolean;
    FCollapsedControlText: WideString;
    FVerificationText: WideString;
    FFooterText: WideString;
    FExpandedInformation: WideString;
    FTitle: WideString;
    FExpandedControlText: WideString;
    FMainInstruction: WideString;
    FContent: WideString;
    FCommonButtons: TLMDTaskDialogCommonButtons;
    FOnCommonButtonClick: TLMDOnTaskDialogCommonButtonClick;
    FThemeMode: TLMDThemeMode;
    FThemeGlobalMode: Boolean;
    procedure SetHandle(const Value: THandle);
    procedure SetCollapsedControlText(const Value: WideString);
    procedure SetContent(const Value: WideString);
    procedure SetCustomFooterIcon(const Value: TIcon);
    procedure SetCustomMainIcon(const Value: TIcon);
    procedure SetExpandedControlText(const Value: WideString);
    procedure SetExpandedInformation(const Value: WideString);
    procedure SetFooterText(const Value: WideString);
    procedure SetFooterIcon(const Value: TLMDTaskDlgIcon);
    procedure SetMainIcon(const Value: TLMDTaskDlgIcon);
    procedure SetMainInstruction(const Value: WideString);
    procedure SetTitle(const Value: WideString);
    procedure SetVerificationText(const Value: WideString);
    procedure SetButtons(const Value: TLMDTaskDlgButtons);
    procedure SetFlags(const Value: TLMDTaskDialogFlags);
    procedure SetProgressBar(const Value: TLMDTaskProgressBar);
    procedure SetRadioButtons(const Value: TLMDTaskDlgButtons);
    function GetWidth: Integer;
    procedure SetWidth(const Value: Integer);
    procedure SetCommonButtons(const Value: TLMDTaskDialogCommonButtons);
    procedure UpdateFlags;
    procedure SetOnCustomize(const Value: TLMDTaskDlgCustomizationEvent);
    function GetOnCustomize: TLMDTaskDlgCustomizationEvent;
    function GetDefaultButton: Integer;
    procedure SetDefaultButton(const Value: Integer);
    procedure SetThemeGlobalMode(const Value: Boolean);
    procedure SetThemeMode(const Value: TLMDThemeMode);
  protected
    function GetResetTimer: Boolean;
    function SendMessageToDialog(Msg: Cardinal; wParam: WPARAM; lParam: LPARAM): Integer;
    function TriggerButtonClicked(AButtonId: integer): Boolean; virtual;

    //handle theme changes
    procedure DoThemeChanged; virtual;
    // UseThemeMode returns active theme, depending on global settings etc.
    function UseThemeMode: TLMDThemeMode;

    procedure TriggerCreated; virtual;
    procedure TriggerRadionButtonClicked(AButtonId: integer); virtual;
    procedure TriggerHyperlink(AHref: WideString); virtual;
    procedure TriggerNavigated; virtual;
    procedure TriggerTimer(ATickCount: Dword); virtual;
    procedure TriggerDestroyed; virtual;
    procedure TriggerDialogConstructed; virtual;
    procedure TriggerVerificationClicked(AChecked: Boolean); virtual;
    procedure TriggerHelp; virtual;
    procedure TriggerExpandoButtonCliked(AExpanded: Boolean); virtual;
    procedure TriggerCommonButtonClick(Sender: TObject; AButtonId: TLMDTaskDialogCommonButton; var ANoCloseDialog: Boolean); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function HandleAllocated: Boolean;
    procedure InitTaskDialog;
    procedure BeginNavigate;
    procedure Navigate;
    procedure ResetTimer;
    procedure VerificationClick(ACheckBoxState: Boolean; ASetFocusToVerificationCheckBox: Boolean);
    function Execute: boolean; overload;
    function Execute(AParentHandle: THandle): boolean; overload;
    procedure Assign(Source: TPersistent); override;

    property Handle: THandle read FHandle write SetHandle;
    property ResultButtonId: Integer read FResultButtonId;
    property ResultRadioButtonId: integer read FResultRadioButtonId;
    property ResultVerificationState: Boolean read FResultVerificationState;
  published
    property About;
    property Title: WideString read FTitle write SetTitle;
    property MainInstruction: WideString read FMainInstruction write SetMainInstruction;
    property VerificationText: WideString read FVerificationText write SetVerificationText;
    property ExpandedInformation: WideString read FExpandedInformation write SetExpandedInformation;
    property ExpandedControlText: WideString read FExpandedControlText write SetExpandedControlText;
    property CollapsedControlText: WideString read FCollapsedControlText write SetCollapsedControlText;
    property FooterText: WideString read FFooterText write SetFooterText;
    property Content: WideString read FContent write SetContent;

    property MainIcon: TLMDTaskDlgIcon read FMainIcon write SetMainIcon default tdiBlank;
    property CustomMainIcon: TIcon read FCustomMainIcon write SetCustomMainIcon;
    property FooterIcon: TLMDTaskDlgIcon read FFooterIcon write SetFooterIcon default tdiBlank;
    property CustomFooterIcon: TIcon read FCustomFooterIcon write SetCustomFooterIcon;
    property Flags: TLMDTaskDialogFlags read FFlags write SetFlags default [tdfEnableHyperlinks, tdfExpandFooterArea, tdfNoDefaultRadioButton];
    property ProgressBar: TLMDTaskProgressBar read FProgressBar write SetProgressBar;
    property RadioButtons: TLMDTaskDlgButtons read FRadioButtons write SetRadioButtons;
    property Buttons: TLMDTaskDlgButtons read FButtons write SetButtons;
    property CommonButtons: TLMDTaskDialogCommonButtons read FCommonButtons write SetCommonButtons default [tdcbOk];
    property DefaultButton: Integer read GetDefaultButton write SetDefaultButton;
    property Width: Integer read GetWidth write SetWidth default 0;

    property OnCustomize: TLMDTaskDlgCustomizationEvent read GetOnCustomize write SetOnCustomize;
    property OnCreated: TNotifyEvent read FOnCreated write FOnCreated;
    property OnHelp: TNotifyEvent read FOnHelp write FOnHelp;
    property OnNavigated: TNotifyEvent read FOnNavigated write FOnNavigated;
    property OnDestroyed: TNotifyEvent read FOnDestroyed write FOnDestroyed;
    property OnDialogConstructed: TNotifyEvent read FOnDialogConstructed write FOnDialogConstructed;
    property OnHyperlink: TLMDOnTaskDialogHyperlink read FOnHyperlink write FOnHyperlink;
    property OnTimer: TLMDOnTaskDialogTimer read FOnTimer write FOnTimer;
    property OnVerificationClicked: TLMDOnTaskDialogChecked read FOnVerificationClicked write FOnVerificationClicked;
    property OnExpandoButtonClicked: TLMDOnTaskDialogChecked read FOnExpandoButtonClicked write FOnExpandoButtonClicked;
    property OnCommonButtonClick: TLMDOnTaskDialogCommonButtonClick read FOnCommonButtonClick write FOnCommonButtonClick;
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
  end;

function LMDTaskDialogCommonButtonToID(AButton: TLMDTaskDialogCommonButton): Integer;

implementation

function LMDTaskDialogProc(hwndDlg: HWND; Msg: UINT; wp: WPARAM; lp: LPARAM; dwRefData: LONG_PTR): HRESULT; stdcall;
var
  LTaskDlg: TLMDTaskDialog;
begin
  Result := E_FAIL;
  LTaskDlg := TLMDTaskDialog(Pointer(dwRefData));
  if not Assigned(LTaskDlg) then
    exit;
  LTaskDlg.Handle := hwndDlg;
  case Msg of
  TDN_CREATED:
    LTaskDlg.TriggerCreated;
  TDN_NAVIGATED:
    LTaskDlg.TriggerNavigated;
  TDN_BUTTON_CLICKED:
  begin
    Result := HRESULT(LTaskDlg.TriggerButtonClicked(wp));
    exit;
  end;
  TDN_HYPERLINK_CLICKED:
    LTaskDlg.TriggerHyperlink(WideString(PWideChar(lp)));
    TDN_TIMER:
  begin
    LTaskDlg.TriggerTimer(wp);
    Result := HResult(LTaskDlg.GetResetTimer);
    exit;
  end;
  TDN_DESTROYED:
    LTaskDlg.TriggerDestroyed;
  TDN_RADIO_BUTTON_CLICKED:
    LTaskDlg.TriggerRadionButtonClicked(wp);
  TDN_DIALOG_CONSTRUCTED:
    LTaskDlg.TriggerDialogConstructed;
  TDN_VERIFICATION_CLICKED:
    LTaskDlg.TriggerVerificationClicked(Boolean(wp = 1));
  TDN_HELP:
    LTaskDlg.TriggerHelp;
  TDN_EXPANDO_BUTTON_CLICKED:
    LTaskDlg.TriggerExpandoButtonCliked(Boolean(wp));
  end;
  Result := S_OK;
end;

function LMDTaskDialogCommonButtonToID(AButton: TLMDTaskDialogCommonButton): Integer;
begin
  Result := -1;
  case AButton of
    tdcbOk:
      Result := IDOK;
    tdcbYes:
      Result := IDYES;
    tdcbNo:
      Result := IDNO;
    tdcbCancel:
      Result := IDCANCEL;
    tdcbRetry:
      Result := IDRETRY;
    tdcbClose:
      Result := IDCLOSE;
  end;
end;

{ TLMDTaskProgressBar }

procedure TLMDTaskProgressBar.Assign(Source: TPersistent);
begin
  if Source is TLMDTaskProgressBar then
  begin
    with Source as TLMDTaskProgressBar do
    begin
      Self.Min := Min;
      Self.Max := Max;
      Self.Position := Position;
      Self.State := State;
      Self.Marquee := Marquee;
      Self.MarqueSpeed := MarqueSpeed;
    end;
  end
  else
    inherited;
end;

constructor TLMDTaskProgressBar.Create(AOwner: TLMDTaskDialog);
begin
  inherited;
  FMin := 0;
  FMax := 100;
  FState := tdpsNormal;
  FPosition := 0;
  FMarquee := False;
end;

procedure TLMDTaskProgressBar.InitControl;
begin
  FOwner.SendMessageToDialog(TDM_SET_PROGRESS_BAR_MARQUEE, WPARAM(FMarquee), FMarqueeSpeed);
  FOwner.SendMessageToDialog(TDM_SET_PROGRESS_BAR_RANGE, 0, MAKELPARAM(FMin, FMax));
  FOwner.SendMessageToDialog(TDM_SET_PROGRESS_BAR_POS, FPosition, 0);
  FOwner.SendMessageToDialog(TDM_SET_PROGRESS_BAR_STATE, WPARAM(FState), 0);
end;

procedure TLMDTaskProgressBar.SetMarquee(const Value: Boolean);
begin
  if Value <> FMarquee then
  begin
    FMarquee := Value;
    FOwner.SendMessageToDialog(TDM_SET_PROGRESS_BAR_MARQUEE, WPARAM(FMarquee), FMarqueeSpeed);
  end;
end;

procedure TLMDTaskProgressBar.SetMarqueeSpeed(const Value: Integer);
begin
  if FMarqueeSpeed <> Value then
  begin
    FMarqueeSpeed := Value;
    FOwner.SendMessageToDialog(TDM_SET_PROGRESS_BAR_MARQUEE, WPARAM(FMarquee), FMarqueeSpeed);
  end;
end;

procedure TLMDTaskProgressBar.SetMax(const Value: Integer);
begin
  if FMax <> Value then
  begin
    FMax := Value;
    FOwner.SendMessageToDialog(TDM_SET_PROGRESS_BAR_RANGE, 0, MAKELPARAM(FMin, FMax));
  end;
end;

procedure TLMDTaskProgressBar.SetMin(const Value: Integer);
begin
  if FMin <> Value then
  begin
    FMin := Value;
    FOwner.SendMessageToDialog(TDM_SET_PROGRESS_BAR_RANGE, 0, MAKELPARAM(FMin, FMax));
  end;
end;

procedure TLMDTaskProgressBar.SetPosition(const Value: Integer);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    FOwner.SendMessageToDialog(TDM_SET_PROGRESS_BAR_POS, WParam(Value), 0);
  end;
end;

procedure TLMDTaskProgressBar.SetState(const Value: TLMDTaskDlgProgressState);
begin
  if FState <> Value then
  begin
    FState := TLMDTaskDlgProgressState(Integer(Value) + 1);
    FOwner.SendMessageToDialog(TDM_SET_PROGRESS_BAR_STATE, WPARAM(FState), 0);
  end;
end;

{ TLMDTaskDialog }

procedure TLMDTaskDialog.Assign(Source: TPersistent);
begin
  if Source is TLMDTaskDialog then
  begin
    with Source as TLMDTaskDialog do
    begin
      Self.MainInstruction := MainInstruction;
      Self.Content := Content;
      Self.ProgressBar.Assign(ProgressBar);
      Self.RadioButtons.Assign(RadioButtons);
      Self.Buttons.Assign(Buttons);
      Self.VerificationText := VerificationText;
      Self.CollapsedControlText := CollapsedControlText;
      Self.ExpandedControlText := ExpandedControlText;
      Self.Flags := Flags;
      Self.CommonButtons := CommonButtons;
      Self.Title := Title;
      Self.ExpandedInformation := ExpandedInformation;
      Self.FooterText := FooterText;
      Self.MainIcon := MainIcon;
      Self.CustomMainIcon := CustomMainIcon;
      Self.FooterIcon := FooterIcon;
      Self.CustomFooterIcon := CustomFooterIcon;
      Self.Width := Width;
      Self.DefaultButton := DefaultButton;
    end;
  end
  else
    inherited;
end;

procedure TLMDTaskDialog.BeginNavigate;
begin
  FIsNavigate := True;
end;

constructor TLMDTaskDialog.Create(AOwner: TComponent);
begin
  inherited;
  FHandle := 0;
  FThemeMode := ttmPlatform;
  FThemeGlobalMode := False;
  ZeroMemory(@FConfig, sizeof(FConfig));
  FConfig.pfCallback := LMDTaskDialogProc;
  FConfig.lpCallbackData := TLMDPtrInt(Self);
  CommonButtons := [tdcbOk];
  Flags := [tdfEnableHyperlinks, tdfExpandFooterArea, tdfNoDefaultRadioButton];
  FProgressBar := TLMDTaskProgressBar.Create(Self);
  FCustomFooterIcon := TIcon.Create;
  FCustomMainIcon := TIcon.Create;
  FRadioButtons := TLMDTaskDlgButtons.Create(Self, TLMDTaskDlgRadioButton);
  FButtons := TLMDTaskDlgButtons.Create(Self, TLMDTaskDlgButton);

  FIsNavigate := False;
  FResetTimer := False;
end;

destructor TLMDTaskDialog.Destroy;
begin
  FButtons.FreeNativeArray(FConfig.pButtons);
  FRadioButtons.FreeNativeArray(FConfig.pRadioButtons);

  FreeAndNil(FButtons);
  FreeAndNil(FRadioButtons);
  FreeAndNil(FCustomFooterIcon);
  FreeAndNil(FCustomMainIcon);
  FreeAndNil(FProgressBar);
  inherited;
end;

procedure TLMDTaskDialog.DoThemeChanged;
begin
  if (UseThemeMode = ttmPlatform) then
    SwitchToPlatform()
  else
    SwitchToNative();
  SetMainIcon(FMainIcon);
  SetFooterIcon(FFooterIcon);
end;

function TLMDTaskDialog.Execute: boolean;
begin
  if (Assigned(Owner)) and (Owner is TCustomForm) then
    Result := Execute(TCustomForm(Owner).Handle)
  else
    Result := Execute(0);
end;

function TLMDTaskDialog.Execute(AParentHandle: THandle): boolean;
var
  LResult: HRESULT;
  LButtons: PLMDTaskButtonArray;
  LRadioButtons: PLMDTaskButtonArray;
begin
  FConfig.cbSize := SizeOf(FConfig);

  FConfig.hwndParent := AParentHandle;
  FConfig.hInstance := 0;

  LButtons := FConfig.pButtons;
  LRadioButtons := FConfig.pRadioButtons;

  FConfig.pButtons := FButtons.GetNativeArray;
  FConfig.cButtons := FButtons.Count;

  FConfig.pRadioButtons := FRadioButtons.GetNativeArray;
  FConfig.cRadioButtons := FRadioButtons.Count;

  UpdateFlags;

  LResult := TaskDialogIndirect(FConfig, FResultButtonId, FResultRadioButtonId,
                                FResultVerificationState);
  if LResult <> S_OK then
    RaiseLastOSError;

  FButtons.FreeNativeArray(LButtons);
  FRadioButtons.FreeNativeArray(LRadioButtons);

  Result := (LResult = S_OK) and (FResultButtonId <> IDCANCEL);
end;

procedure TLMDTaskDialog.UpdateFlags;
var
  i: Cardinal;
begin
  FConfig.dwFlags := 0;
  for i := Integer(Low(TLMDTaskDialogFlag)) to Integer(High(TLMDTaskDialogFlag)) do
  begin
    if TLMDTaskDialogFlag(i) in Flags then
      FConfig.dwFlags := FConfig.dwFlags or (1 shl i);
  end;

  if FIsNavigate then
    SendMessageToDialog(TDM_UPDATE_FLAGS, 0, FConfig.dwFlags);
end;

function TLMDTaskDialog.GetDefaultButton: Integer;
begin
  Result := FConfig.nDefaultButton;
end;

function TLMDTaskDialog.GetOnCustomize: TLMDTaskDlgCustomizationEvent;
begin
  Result := GOnCustomizationEvent;
end;

function TLMDTaskDialog.GetResetTimer: Boolean;
begin
  Result := FResetTimer;
  FResetTimer := False;
end;

function TLMDTaskDialog.HandleAllocated: Boolean;
begin
  Result := FHandle <> 0;
end;

procedure TLMDTaskDialog.InitTaskDialog;
var
  i: integer;
begin
  if ([tdfShowProgressBar, tdfShowMarqueeProgressBar] * Flags <> []) then
    FProgressBar.InitControl;

  for i := 0 to FButtons.Count - 1 do
    FButtons.Buttons[i].InitButton;

  for i := 0 to FRadioButtons.Count - 1 do
    FRadioButtons.Buttons[i].InitButton;
end;

procedure TLMDTaskDialog.Navigate;
var
  LButtons: Pointer;
  LRadioButtons: Pointer;
  begin
  FIsNavigate := False;

  // Save previous button arrays
  LButtons := FConfig.pButtons;
  LRadioButtons := FConfig.pRadioButtons;

  FConfig.pButtons := FButtons.GetNativeArray;
  FConfig.cButtons := FButtons.Count;
  FConfig.pRadioButtons := FRadioButtons.GetNativeArray;
  FConfig.cRadioButtons := FRadioButtons.Count;

  SendMessageToDialog(TDM_NAVIGATE_PAGE, 0, LPARAM(@FConfig));
  FButtons.FreeNativeArray(LButtons);
  FRadioButtons.FreeNativeArray(LRadioButtons);
end;

function TLMDTaskDialog.SendMessageToDialog(Msg: Cardinal; wParam: WPARAM; lParam: LPARAM): Integer;
begin
  Result := -1;
  if (not FIsNavigate) and (HandleAllocated) then
    Result := SendMessage(Handle, Msg, wParam, lParam);
end;

procedure TLMDTaskDialog.SetButtons(const Value: TLMDTaskDlgButtons);
begin
  FButtons.Assign(Value);
end;

procedure TLMDTaskDialog.SetCollapsedControlText(const Value: WideString);
begin
  if FCollapsedControlText <> Value then
  begin
    FCollapsedControlText := Value;
    FConfig.pszCollapsedControlText := int_RefW(FCollapsedControlText);
  end;
end;

procedure TLMDTaskDialog.SetContent(const Value: WideString);
begin
  if FContent <> Value then
  begin
    FContent := Value;
    FConfig.pszContent := int_RefW(FContent);
    SendMessageToDialog(TDM_SET_ELEMENT_TEXT, TDE_CONTENT, LPARAM(FConfig.pszContent));
    end;
end;

procedure TLMDTaskDialog.SetCustomFooterIcon(const Value: TIcon);
begin
  if (FCustomFooterIcon <> Value) then
  begin
    FCustomFooterIcon.Assign(Value);
    if tdfUseHiconFooter in Flags then
    begin
      FConfig.hFooterIcon := Value.Handle;
      SendMessageToDialog(TDM_UPDATE_ICON, TDIE_ICON_FOOTER, Value.Handle);
    end;
  end;
end;

procedure TLMDTaskDialog.SetCustomMainIcon(const Value: TIcon);
begin
  if FCustomMainIcon <> Value then
  begin
    FCustomMainIcon.Assign(Value);
    if tdfUseHiconMain in Flags then
    begin
      FConfig.hMainIcon := Value.Handle;
      SendMessageToDialog(TDM_UPDATE_ICON, TDIE_ICON_MAIN, Value.Handle);
    end;
  end;
end;

procedure TLMDTaskDialog.SetDefaultButton(const Value: Integer);
begin
  FConfig.nDefaultButton := Value;
end;

procedure TLMDTaskDialog.SetExpandedControlText(const Value: WideString);
begin
  if FExpandedControlText <> Value then
  begin
    FExpandedControlText := Value;
    FConfig.pszExpandedControlText := int_RefW(FExpandedControlText);
  end;
end;

procedure TLMDTaskDialog.SetExpandedInformation(const Value: WideString);
begin
  if FExpandedInformation <> Value then
  begin
    FExpandedInformation := Value;
    FConfig.pszExpandedInformation := int_RefW(FExpandedInformation);
    SendMessageToDialog(TDM_SET_ELEMENT_TEXT, TDE_EXPANDED_INFORMATION, LPARAM(FConfig.pszExpandedInformation));
    end;
end;

procedure TLMDTaskDialog.SetFooterText(const Value: WideString);
begin
  if FFooterText <> Value then
  begin
    FFooterText := Value;
    FConfig.pszFooter := int_RefW(FFooterText);
    SendMessageToDialog(TDM_SET_ELEMENT_TEXT, TDE_FOOTER, LPARAM(FConfig.pszFooter));
    end;
end;

procedure TLMDTaskDialog.SetFlags(const Value: TLMDTaskDialogFlags);
begin
  if FFlags <> Value then
    FFlags := Value;

  UpdateFlags;
end;

procedure TLMDTaskDialog.SetFooterIcon(const Value: TLMDTaskDlgIcon);
var
  LIcon: LPARAM;
begin
  if {(FFooterIcon <> Value) and }(not (tdfUseHiconFooter in Flags)) then
  begin
    FFooterIcon := Value;
    if LMDSIWindowsVistaUp and CIsNativeTaskDialog then
    begin
      case FFooterIcon of
      tdiWarning:
        begin
          FConfig.pszFooterIcon := TD_WARNING_ICON;
          LIcon := LPARAM(FConfig.pszFooterIcon);
          end;
      tdiError:
        begin
          FConfig.pszFooterIcon := TD_ERROR_ICON;
          LIcon := LPARAM(FConfig.pszFooterIcon);
          end;
      tdiInformation:
        begin
          FConfig.pszFooterIcon := TD_INFORMATION_ICON;
          LIcon := LPARAM(FConfig.pszFooterIcon);
          end;
      tdiShield:
        begin
          FConfig.pszFooterIcon := TD_SHIELD_ICON;
          LIcon := LPARAM(FConfig.pszFooterIcon);
          end;
      tdiQuestion:
        begin
          FConfig.pszFooterIcon := MakeIntResourceW(32514);
          LIcon := LPARAM(FConfig.pszFooterIcon);
          end;
      else
        begin
          FConfig.pszFooterIcon := nil;
          LIcon := LPARAM(FConfig.pszFooterIcon);
          end;
      end;
    end
    else
    begin
      FConfig.pszFooterIcon := MAKEINTRESOURCEW(Ord(Value) + 100);
      LIcon := LPARAM(FConfig.pszFooterIcon);
      end;
    SendMessageToDialog(TDM_UPDATE_ICON, TDIE_ICON_FOOTER, LIcon);
  end;
end;

procedure TLMDTaskDialog.SetHandle(const Value: THandle);
begin
  FHandle := Value;
end;

procedure TLMDTaskDialog.SetMainIcon(const Value: TLMDTaskDlgIcon);
var
  LIcon: LPARAM;
begin
  if {(FMainIcon <> Value) and} (not (tdfUseHiconMain in Flags)) then
  begin
    FMainIcon := Value;
    if LMDSIWindowsVistaUp and CIsNativeTaskDialog then
    begin
      case FMainIcon of
      tdiWarning:
        begin
          FConfig.pszMainIcon := TD_WARNING_ICON;
          LIcon := LPARAM(FConfig.pszMainIcon);
          end;
      tdiError:
        begin
          FConfig.pszMainIcon := TD_ERROR_ICON;
          LIcon := LPARAM(FConfig.pszMainIcon);
          end;
      tdiInformation:
        begin
          FConfig.pszMainIcon := TD_INFORMATION_ICON;
          LIcon := LPARAM(FConfig.pszMainIcon);
          end;
      tdiShield:
        begin
          FConfig.pszMainIcon := TD_SHIELD_ICON;
          LIcon := LPARAM(FConfig.pszMainIcon);
          end;
      tdiQuestion:
        begin
          FConfig.pszMainIcon := MakeIntResourceW(32514);
          LIcon := LPARAM(FConfig.pszMainIcon);
          end;
      else
        begin
          FConfig.pszMainIcon := nil;
          LIcon := LPARAM(FConfig.pszMainIcon);
          end;
      end;
    end
    else
    begin
      FConfig.pszMainIcon := MAKEINTRESOURCEW(Ord(Value) + 100);
      LIcon := LPARAM(FConfig.pszMainIcon);
      end;
    SendMessageToDialog(TDM_UPDATE_ICON, TDIE_ICON_MAIN, LIcon);
  end;
end;

procedure TLMDTaskDialog.SetMainInstruction(const Value: WideString);
begin
  if FMainInstruction <> Value then
  begin
    FMainInstruction := Value;
    FConfig.pszMainInstruction := int_RefW(FMainInstruction);
    SendMessageToDialog(TDM_SET_ELEMENT_TEXT, TDE_MAIN_INSTRUCTION, LPARAM(FConfig.pszMainInstruction));
    end;
end;

procedure TLMDTaskDialog.SetOnCustomize(const Value: TLMDTaskDlgCustomizationEvent);
begin
  GOnCustomizationEvent := Value;
end;

procedure TLMDTaskDialog.SetProgressBar(const Value: TLMDTaskProgressBar);
begin
  FProgressBar.Assign(Value);
end;

procedure TLMDTaskDialog.SetRadioButtons(const Value: TLMDTaskDlgButtons);
begin
  FRadioButtons := Value;
end;

procedure TLMDTaskDialog.SetThemeGlobalMode(const Value: Boolean);
begin
  FThemeGlobalMode := Value;
end;

function TLMDTaskDialog.UseThemeMode: TLMDThemeMode;
begin
  if FThemeGlobalMode then
    result := LMDApplication.ThemeGlobalMode
  else
    result := FThemeMode;
end;

procedure TLMDTaskDialog.SetThemeMode(const Value: TLMDThemeMode);
begin
  if (FThemeMode <> Value) then
  begin
    FThemeMode := Value;
    DoThemeChanged;
  end;
end;

procedure TLMDTaskDialog.SetTitle(const Value: WideString);
begin
  if FTitle <> Value then
  begin
    FTitle := Value;
    FConfig.pszWindowTitle := int_RefW(FTitle);
  end;
end;

procedure TLMDTaskDialog.SetVerificationText(const Value: WideString);
begin
  if FVerificationText <> Value then
  begin
    FVerificationText := Value;
    FConfig.pszVerificationText := int_RefW(FVerificationText);
  end;
end;

function TLMDTaskDialog.TriggerButtonClicked(AButtonId: integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  if AButtonId <= Integer(tdcbClose)  then
  begin
    if TLMDTaskDialogCommonButton(AButtonId - 1) in FCommonButtons then
    begin
      TriggerCommonButtonClick(Self, TLMDTaskDialogCommonButton(AButtonId), Result);
      exit;
    end;
  end;

  for i := 0 to FButtons.Count - 1 do
  begin
    if FButtons.Buttons[i].ButtonId = AButtonId then
    begin
      TLMDTaskDlgButton(FButtons.Buttons[i]).TriggerClick(Self, Result);
      exit;
    end;
  end;
end;

procedure TLMDTaskDialog.TriggerRadionButtonClicked(AButtonId: integer);
var
  i: Integer;
begin
  for i := 0 to FRadioButtons.Count - 1 do
  begin
    if FRadioButtons.Buttons[i].ButtonId = AButtonId then
      TLMDTaskDlgRadioButton(FRadioButtons.Buttons[i]).TriggerClick(Self);
  end;
end;

procedure TLMDTaskDialog.TriggerCommonButtonClick(Sender: TObject;
  AButtonId: TLMDTaskDialogCommonButton; var ANoCloseDialog: Boolean);
begin
  if Assigned(FOnCommonButtonClick) then
    FOnCommonButtonClick(Sender, AButtonId, ANoCloseDialog);
end;

procedure TLMDTaskDialog.TriggerCreated;
begin
  InitTaskDialog;
  if Assigned(FOnCreated) then
    FOnCreated(Self);
end;

procedure TLMDTaskDialog.TriggerDestroyed;
begin
  if Assigned(FOnDestroyed) then
    FOnDestroyed(Self);
end;

procedure TLMDTaskDialog.TriggerDialogConstructed;
begin
  if Assigned(FOnDialogConstructed) then
    FOnDialogConstructed(Self);
end;

procedure TLMDTaskDialog.TriggerExpandoButtonCliked(AExpanded: Boolean);
begin
  if Assigned(FOnExpandoButtonClicked) then
    FOnExpandoButtonClicked(Self, AExpanded);
end;

procedure TLMDTaskDialog.TriggerHelp;
begin
  if Assigned(FOnHelp) then
    FOnHelp(Self);
end;

procedure TLMDTaskDialog.TriggerHyperlink(AHref: WideString);
begin
  if Assigned(FOnHyperlink) then
    FOnHyperlink(Self, AHref);
end;

procedure TLMDTaskDialog.TriggerNavigated;
begin
  if Assigned(FOnNavigated) then
    FOnNavigated(Self);
end;

procedure TLMDTaskDialog.TriggerTimer(ATickCount: Dword);
begin
  if Assigned(FOnTimer) then
    FOnTimer(Self, ATickCount);
end;

procedure TLMDTaskDialog.TriggerVerificationClicked(AChecked: Boolean);
begin
  if Assigned(FOnVerificationClicked) then
    FOnVerificationClicked(Self, AChecked);
end;

procedure TLMDTaskDialog.VerificationClick(ACheckBoxState, ASetFocusToVerificationCheckBox: Boolean);
begin
  SendMessageToDialog(TDM_CLICK_VERIFICATION, WPARAM(ACheckBoxState), LPARAM(ASetFocusToVerificationCheckBox));
end;

function TLMDTaskDialog.GetWidth: Integer;
begin
  Result := FConfig.cxWidth;
end;

procedure TLMDTaskDialog.SetWidth(const Value: Integer);
begin
  FConfig.cxWidth := Value;
end;

procedure TLMDTaskDialog.SetCommonButtons(const Value: TLMDTaskDialogCommonButtons);
var
  i: integer;
begin
  if FCommonButtons <> Value then
  begin
    FCommonButtons := Value;
    FConfig.dwCommonButtons := 0;
    for i := Integer(Low(TLMDTaskDialogCommonButton)) to Integer(High(TLMDTaskDialogCommonButton)) do
    begin
      if TLMDTaskDialogCommonButton(i) in FCommonButtons then
        FConfig.dwCommonButtons := FConfig.dwCommonButtons or (1 shl i);
    end;
  end;
end;

procedure TLMDTaskDialog.ResetTimer;
begin
  FResetTimer := True;
end;

{ TLMDTaskDlgControl }

constructor TLMDTaskDlgControl.Create(AOwner: TLMDTaskDialog);
begin
  inherited Create;
  FOwner := AOwner;
end;

{ TLMDTaskDlgButton }

procedure TLMDTaskDlgButton.Assign(Source: TPersistent);
begin
  if Source is TLMDTaskDlgButton then
  begin
    with Source as TLMDTaskDlgButton do
    begin
      Self.Caption := Caption;
      Self.Enabled := Enabled;
      Self.ButtonId := ButtonId;
      Self.IsDefault := IsDefault;
      Self.IsElevationButton := IsElevationButton;
      Self.OnClick := OnClick;
    end;
  end
  else
    inherited;
end;

procedure TLMDTaskDlgButton.Click;
begin
  TaskDialog.SendMessageToDialog(TDM_CLICK_BUTTON, FButtonId, 0);
end;

constructor TLMDTaskDlgButton.Create(Collection: TCollection);
begin
  inherited;
  FEnabled := True;
  FButtonId := 200 + ID;
end;

function TLMDTaskDlgButton.GetIsDefault: Boolean;
begin
  Result := (TaskDialog.FConfig.nDefaultButton = FButtonId);
end;

procedure TLMDTaskDlgButton.InitButton;
begin
  TaskDialog.SendMessageToDialog(TDM_ENABLE_BUTTON, FButtonId, LPARAM(FEnabled));
  TaskDialog.SendMessageToDialog(TDM_SET_BUTTON_ELEVATION_REQUIRED_STATE, FButtonId, LPARAM(FIsElevationButton));
end;

procedure TLMDTaskDlgButton.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    TaskDialog.SendMessageToDialog(TDM_ENABLE_BUTTON, FButtonId, LPARAM(Value));
  end;
end;

procedure TLMDTaskDlgButton.SetIsDefault(const Value: Boolean);
var
  LTask: TLMDTaskDialog;
begin
  LTask := TLMDTaskDlgButtons(GetOwner).TaskDialog;
  if Value then
    LTask.FConfig.nDefaultButton := FButtonId
  else
    if TaskDialog.FConfig.nDefaultButton = FButtonId then
      LTask.FConfig.nDefaultButton := 0;
end;

procedure TLMDTaskDlgButton.SetIsElevationButton(const Value: Boolean);
begin
  if FIsElevationButton <> Value then
  begin
    FIsElevationButton := Value;
    TaskDialog.SendMessageToDialog(TDM_SET_BUTTON_ELEVATION_REQUIRED_STATE, FButtonId, LPARAM(Value));
  end;
end;

procedure TLMDTaskDlgButton.TriggerClick(Sender: TObject; var ANoCloseDialog: Boolean);
begin
  if Assigned(FOnClick) then
    FOnClick(Sender, ANoCloseDialog);
end;

{ TLMDTaskDlgRadioButton }

procedure TLMDTaskDlgRadioButton.Assign(Source: TPersistent);
begin
  if Source is TLMDTaskDlgRadioButton then
  begin
    with Source as TLMDTaskDlgRadioButton do
    begin
      Self.Caption := Caption;
      Self.Enabled := Enabled;
      Self.ButtonId := ButtonId;
      Self.IsDefault := IsDefault;
      Self.OnClick := OnClick;
    end;
  end
  else
    inherited;
end;

procedure TLMDTaskDlgRadioButton.Click;
begin
  TaskDialog.SendMessageToDialog(TDM_CLICK_RADIO_BUTTON, FButtonId, 0);
end;

constructor TLMDTaskDlgRadioButton.Create(Collection: TCollection);
begin
  inherited;
  FEnabled := True;
  FButtonId := 300 + ID;
end;

function TLMDTaskDlgRadioButton.GetIsDefault: Boolean;
begin
  Result := Boolean(TaskDialog.FConfig.nDefaultRadioButton = FButtonId);
end;

procedure TLMDTaskDlgRadioButton.InitButton;
begin
  TaskDialog.SendMessageToDialog(TDM_ENABLE_RADIO_BUTTON, FButtonId, LPARAM(FEnabled));
end;

procedure TLMDTaskDlgRadioButton.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    TaskDialog.SendMessageToDialog(TDM_ENABLE_RADIO_BUTTON, FButtonId, LPARAM(Value));
  end;
end;

procedure TLMDTaskDlgRadioButton.SetIsDefault(const Value: Boolean);
var
  LTask: TLMDTaskDialog;
begin
  LTask := TLMDTaskDlgButtons(GetOwner).TaskDialog;
  if Value then
    LTask.FConfig.nDefaultRadioButton := FButtonId
  else
    if TaskDialog.FConfig.nDefaultRadioButton = FButtonId then
      LTask.FConfig.nDefaultRadioButton := 0;
end;

{ TLMDTaskDlgButtons }

procedure TLMDTaskDlgButtons.FreeNativeArray(AArray: Pointer);

begin
  if AArray <> nil then
    FreeMem(AArray);
  end;

function TLMDTaskDlgButtons.GetButton(Index: Integer): TLMDTaskDlgBaseButton;
begin
  Result := TLMDTaskDlgBaseButton(Items[Index]);
end;

function TLMDTaskDlgButtons.GetNativeArray: Pointer;

var
  i: Integer;
  LBegin: PLMDTaskButtonArray;
  begin
  GetMem(LBegin, Count * SizeOf(TASKDIALOG_BUTTON));
  Result := LBegin;
  try
    for i := 0 to Count - 1 do
    begin
      LBegin^[i].nButtonId := TLMDTaskDlgBaseButton(Items[i]).ButtonId;
      LBegin^[i].pszButtonText := PWideChar(TLMDTaskDlgBaseButton(Items[i]).Caption);
    end;
  except
    FreeAndNil(LBegin);
    Result := nil;
  end;
end;

function TLMDTaskDlgButtons.IntGetOwner: TLMDTaskDialog;
begin
  Result := TLMDTaskDialog(GetOwner);
end;

{ TLMDTaskDlgBaseButton }

function TLMDTaskDlgBaseButton.GetTaskDialog: TLMDTaskDialog;
begin
  Result := TLMDTaskDlgButtons(GetOwner).TaskDialog;
end;

procedure TLMDTaskDlgRadioButton.TriggerClick(Sender: TObject);
begin
  if Assigned(FOnClick) then
    FOnClick(Sender);
end;

end.
