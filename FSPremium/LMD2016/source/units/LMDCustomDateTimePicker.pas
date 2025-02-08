unit LMDCustomDateTimePicker;
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

LMDCustomDateTimePicker unit (VB)
--------------------------------



Changes
-------
Release 8.0 (August 2012)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LMDClass,
  LMDTypes, LMDCustomMaskEdit, LMDDropdownForm, LMDCalendar, LMDSpinButton,
  LMDButtonBase, LMDCal, LMDButton, LMDPanelFill, LMDMaskEdit, LMDClock;

type
  TLMDOnValueChangingEvent = procedure(Sender : TObject; var Val: double; var CanModify: boolean) of object;
  TLMDOnValueChangedEvent = procedure(Sender : TObject; OldVal, NewVal: double) of object;

type
  TLMDCalendarFormOption = (cfoShowOkCancelBtns, cfoShowClock, cfoCloseupOnDayClick);

type
  TLMDCalendarFormOptions = set of TLMDCalendarFormOption;

type
  TLMDCalendarForm = class(TLMDDropDownForm)
  private
    FCalendar: TLMDCalendar;
    FCalendarPanel: TLMDPanelFill;
    FClockPanel: TLMDPanelFill;
    FButtonPanel: TLMDPanelFill;
    FOkBtn: TLMDButton;
    FCancelBtn: TLMDButton;
    FTimePicker: TLMDMaskEdit;
    FClock: TLMDClock;

    procedure CalendarClick(Sender: TObject);
    procedure FormCreate(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure TimeChanged(Sender : TObject);
    procedure CMDeactivate(var Msg : TMessage); message CM_DEACTIVATE;
  protected
    function Options: TLMDCalendarFormOptions;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure WMActivate(var Msg : TWMActivate); message WM_ACTIVATE;
  public
    constructor CreateNew(AOwner : TComponent; Dummy: Integer); override;
    procedure CreateParams(var Params : TCreateParams); override;
    procedure InitCalendar; virtual;
    procedure InitClock; virtual;
    procedure InitButtons; virtual;
    property Calendar: TLMDCalendar read FCalendar;
    property CalendarPanel: TLMDPanelFill read FCalendarPanel;
    property Clock: TLMDClock read FClock;
    property ClockPanel: TLMDPanelFill read FClockPanel;
    property ButtonPanel: TLMDPanelFill read FButtonPanel;
    property OkBtn: TLMDButton read FOkBtn;
    property CancelBtn: TLMDButton read FCancelBtn;
    property TimePicker: TLMDmaskEdit read FTimePicker;
  end;

type
  TLMDCustomDateTimePicker = class(TLMDCustomMaskEdit)
  private
    FCalendarFormOptions: TLMDCalendarFormOptions;
    FDroppedDown: boolean;
    FDropDownAlignment: TAlignment;
    FForm      : TLMDCalendarForm;
    FFormWidth: integer;
    FFormHeight: integer;

    FAutoDisableButtons: boolean;
    FSpinBtn      : TLMDSpinButton;
    FSpinBtnWidth : Integer;
    FEditorEnabled: Boolean;

    FShowPopupCalendar : Boolean;

    FOnUpClick: TNotifyEvent;
    FOnDownClick: TNotifyEvent;
    FOnDropDown: TNotifyEvent;

    FOnValueChanged: TLMDOnValueChangedEvent;
    FOnValueChanging: TLMDOnValueChangingEvent;

    FCalendarFormColor,
    FCalendarPanelColor,
    FClockPanelColor,
    FButtonPanelColor: TColor;

    FCalendarStyle: TLMDCalendarStyle;
    FCalendarColorScheme: TLMDColorScheme;
    FClockStyle: TLMDClockStyle;
    FClockColorScheme: TLMDColorScheme;

    FKeepCalendarWithinForm: boolean;
    FOkCaption, FCancelCaption: TLMDString;

    FCalendarHeader: TLMDCalendarHeader;
    FStartDay: byte;

    procedure SetInteger (index, aValue : Integer);

    procedure SetColor(Index:Integer; const Value: TColor);
    procedure SetDiag(const Value: Boolean);


    function GetColor(Index:Integer): TColor;

    function GetDiag: Boolean;

    procedure CMEnabledChanged (var Message : TMessage); message CM_ENABLEDCHANGED;
    procedure WMKILLFOCUS (var Message : TWMKillFocus); message WM_KILLFOCUS;
    procedure SetAutoDisableButtons(const Value: boolean);
    function GetSpinBtnVisible: Boolean;
    procedure SetSpinBtnVisible(const Value: Boolean);
    procedure SetShowPopupCalendar(const Value: Boolean); virtual;
    procedure SetCalendarFormOptions(const Value: TLMDCalendarFormOptions);
    function GetMaxDateTime: TDateTime;
    function GetMinDateTime: TDateTime;
    procedure SetMaxDateTime(const Value: TDateTime);
    procedure SetMinDateTime(const Value: TDateTime);
    procedure SetCalendarStyle(const Value: TLMDCalendarStyle);
    procedure SetStartDay(const Value: byte);
  protected
    function AllowedOperation(textToInsert : TLMDString) : Boolean; override;
    procedure DoAClick (Btn : TObject; index : Integer); override;
    procedure DoDropDown; virtual;
    procedure DropDown; virtual;
    procedure DoInc(Sender : TObject);virtual;
    procedure DoDec(Sender : TObject);virtual;
    procedure DoThemeChanged; override;
    procedure CloseUp(AcceptValue : boolean); virtual;
    procedure CalendarFormDeactivate(Sender: TObject); virtual;
    procedure CalendarChange(Sender: TObject);
    procedure CMCancelMode(var Msg: TCMCancelMode); message CM_CANCELMODE;
    procedure DestroyWnd; override;

    procedure DoValueChanging(Sender : TObject; var Val: double; var CanModify: boolean); virtual;
    procedure DoValueChanged(Sender : TObject; OldVal, NewVal: double); virtual;
    procedure GetCommandKey (var KeyCode : Word; Shift : TShiftState); override;
    procedure GetChange (Sender : TObject); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseExit; override;
    procedure ModifyPaintRect; override;
    procedure Loaded; override;

    procedure UpdateSpinButtons;

    property SpinBtnVisible: Boolean  read GetSpinBtnVisible
                                      write SetSpinBtnVisible
                                      default true;
  public
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;
    property DroppedDown: boolean read FDroppedDown;
    function CalendarForm: TLMDCalendarForm;
    function Calendar: TLMDCalendar;
  published
    property AutoSize;
    property AutoDisableButtons: boolean read FAutoDisableButtons write SetAutoDisableButtons default false;
    property Alignment;
    property CalendarFormOptions: TLMDCalendarFormOptions read FCalendarFormOptions write SetCalendarFormOptions;
    property CustomButtons;
    property CustomButtonsStyle default ubsCombo;
    property CustomButtonWidth;
    property CustomButtonParentCtlXP;

    property MinDateTime: TDateTime read GetMinDateTime write SetMinDateTime;
    property MaxDateTime: TDateTime read GetMaxDateTime write SetMaxDateTime;

    property CalendarFormColor: TColor read FCalendarFormColor write FCalendarFormColor default clWhite;
    property CalendarFormWidth: integer read FFormWidth write FFormWidth default -1;
    property CalendarFormHeight: integer read FFormHeight write FFormHeight default -1;
    property CalendarPanelColor: TColor read FCalendarPanelColor write FCalendarPanelColor default clWhite;
    property ClockPanelColor: TColor read FClockPanelColor write FClockPanelColor default clWhite;
    property DateSettings;
    property ButtonPanelColor: TColor read FButtonPanelColor write FButtonPanelColor default clWhite;

    property CalendarStyle: TLMDCalendarStyle read FCalendarStyle write SetCalendarStyle default clsVista;
    property CalendarColorScheme: TLMDColorScheme read FCalendarColorScheme write FCalendarColorScheme default csDefaultScheme;
    property ClockStyle: TLMDClockStyle read FClockStyle write FClockStyle default csWindows7;
    property ClockColorScheme: TLMDColorScheme read FClockColorScheme write FClockColorScheme default csDefaultScheme;

    property KeepCalendarWithinForm: boolean read FKeepCalendarWithinForm write FKeepCalendarWithinForm default false;

    property ShowPopupCalendar: Boolean read FShowPopupCalendar write SetShowPopupCalendar default true;  { Published }
    property SpinBtnWidth : Integer index 0 read FSpinBtnWidth write SetInteger default -1;
    property SpinBtnColor:  TColor index 0 read GetColor write SetColor default clBtnFace;
    property SpinBtnDiag: Boolean read GetDiag write SetDiag default false;
    property SpinBtnHotColor:TColor index 1 read GetColor write SetColor default def_SPINHOTCOLOR;
    property StartDay: byte read FStartDay write SetStartDay;

    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default true;

    property OkCaption: TLMDString read FOkCaption write FOkCaption;
    property CancelCaption: TLMDString read FCancelCaption write FCancelCaption;

    property CalendarHeader: TLMDCalendarHeader read FCalendarHeader write FCalendarHeader;

    property ReadOnly;

    property OnSpinBtnUpClick:TNotifyEvent read FOnUpClick write FOnUpClick;
    property OnSpinBtnDownClick:TNotifyEvent read FOnDownClick write FOnDownClick;
    property OnDropDownClick:TNotifyEvent read FOnDropDown write FOnDropDown;

    property OnValueChanged: TLMDOnValueChangedEvent read FOnValueChanged write FOnValueChanged;
    property OnValueChanging: TLMDOnValueChangingEvent read FOnValueChanging write FOnValueChanging;

    property Options;
    property TimeSettings;

  end;


implementation

uses
  Math, LMDProcs, LMDBaseEdit, LMDTimeFormat, LMDGraph, LMDStrings;

{ ------------------------- private ------------------------------------------ }
procedure TLMDCustomDateTimePicker.SetAutoDisableButtons(
  const Value: boolean);
begin
  if Value <> FAutoDisableButtons then
    begin
      FAutoDisableButtons := Value;
      UpdateSpinButtons;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.SetInteger (index, aValue : Integer);
begin
  case index of
    0 : if aValue <> FSpinBtnWidth then
          begin
            FSpinBtnWidth := aValue;
            SetupRects;
            GetChange(nil);
          end;
  end;
end;


{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.SetMaxDateTime(const Value: TDateTime);
begin
  MaxValue := TDateTime(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.SetMinDateTime(const Value: TDateTime);
begin
  MinValue := TDateTime(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.SetShowPopupCalendar(const Value: Boolean);
begin
  if (FShowPopupCalendar <> Value) then
  begin
    FShowPopupCalendar := Value;
    if FShowPopupCalendar then
    begin
      CustomButtons.Insert(0);
      CustomButtons.Items[0].Btn.Style:=ubsCombo;
      CustomButtons.Items[0].Btn.ThemeMode := Self.ThemeMode;


      FForm := TLMDCalendarForm.CreateNew(Self, 0);

      //FForm.Font.Assign(Font);
      FForm.Visible := false;
      FForm.FormStyle := fsStayOnTop;
      FForm.Position := poDesigned;
      FForm.BorderStyle := bsNone;


      //FForm.OnKeyDown := CalendarKeyDown;
      FForm.OnChange := CalendarChange;
      FForm.OnDeactivate := CalendarFormDeactivate;
    end
    else
    begin
      CustomButtons.Delete(0);
      if Assigned(FForm) then
        FreeAndNil(FForm);
    end;
  end;  { if }
end;  { SetShowPopupCalendar }

procedure TLMDCustomDateTimePicker.SetSpinBtnVisible(const Value: Boolean);
begin
  FSpinBtn.Visible := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.SetStartDay(const Value: byte);
begin
  if Value in [1..7] then
    FStartDay := Value;
end;

(*
{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.SetValue (index : Integer; aValue : Double);
var
  lCanModify: boolean;
  //lOldValue: TDateTime;
begin
  //if (aValue <> FValue) then
  begin
    lCanModify := true;
    //lOldValue := AsDateTime;
    DoValueChanging(Self, aValue, lCanModify);
    //if lCanModify then
    //  FValue := aValue;
    //if FCheckBounds or not FCheckOnExitOnly then
     { begin
        if (Value > MaxValue) then
          FValue := MaxValue;
        if (FValue < MinValue) then
          FValue := MinValue;
      end;}
    if FAutoDisableButtons then
      UpdateSpinButtons;
    //Text := GetOutString (FValue);
    //if FValue <> lOldValue then
    //  DoValueChanged(Self, lOldValue, FValue);
  end;
end;
*)

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.SetCalendarFormOptions(
  const Value: TLMDCalendarFormOptions);
begin
  FCalendarFormOptions := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.SetCalendarStyle(
  const Value: TLMDCalendarStyle);
begin
  FCalendarStyle := Value;
  ApplyCalendarStyleToHeader(FCalendarHeader, FCalendarStyle);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.SetColor(index:Integer; const Value: TColor);
begin
  case Index of
    0: FSpinBtn.Color:=Value;
    1: FSpinBtn.HotColor:=Value;
  end;

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.SetDiag(const Value: Boolean);
begin
  FSpinBtn.OldStyle := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDateTimePicker.GetColor(Index:Integer): TColor;
begin
  case Index of
    0: result:=FSpinBtn.Color;
    1: result:=FSpinBtn.HotColor;
  else
    result:=clNone;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDateTimePicker.GetDiag: Boolean;
begin
  result:=FSpinBtn.OldStyle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDateTimePicker.GetMaxDateTime: TDateTime;
begin
  result := TDateTime(MaxValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDateTimePicker.GetMinDateTime: TDateTime;
begin
  result := TDateTime(MinValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.WMKILLFOCUS (var Message : TWMKillFocus);
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDateTimePicker.Calendar: TLMDCalendar;
begin
  if TLMDCalendarForm(FForm) <> nil then
    result := TLMDCalendarForm(FForm).Calendar
  else
    result := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.CalendarChange(Sender: TObject);
begin
  if not Assigned(FForm) then
    exit;
  if LMDInRangeF(FForm.FCalendar.Date + Frac(FForm.FClock.FixedTime.DateTimeValue), MinDateTime, MaxDateTime) then
    CloseUp(true);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDateTimePicker.CalendarForm: TLMDCalendarForm;
begin
  result := TLMDCalendarForm(FForm);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.CalendarFormDeactivate(Sender: TObject);
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
procedure TLMDCustomDateTimePicker.CloseUp(AcceptValue: boolean);
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

    FDroppedDown := false;
    if AcceptValue then
       AsDateTime := Trunc(FForm.FCalendar.Date) + IfThen(cfoShowClock in CalendarFormOptions, Frac(FForm.FClock.FixedTime.DateTimeValue), Frac(AsTime));

    CustomButtons.Items[0].Btn.Down := false;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.CMCancelMode(var Msg: TCMCancelMode);
begin
  if (Msg.Sender <> Self) and
     (Msg.Sender <> CustomButtons.Items[0].Btn) and (Msg.Sender <> FForm) then
   CloseUp(False);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.CMEnabledChanged (var Message : TMessage);
begin
  inherited;
  FSpinBtn.Enabled := Enabled;
end;

{ ------------------------- protected ---------------------------------------- }
procedure TLMDCustomDateTimePicker.DoInc(Sender : TObject);
begin
  FClickCount := 0;
  if Showing then
    Windows.SetFocus(Handle);

  DateTimeInc(1);
  if Assigned(FOnUpClick) then
    FOnUpClick(self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.DoAClick(Btn: TObject; index: Integer);
begin
  inherited;
  if index = 0 then
    DropDown;
end;

procedure TLMDCustomDateTimePicker.DoDec(Sender : TObject);
begin
  FClickCount := 0;
  if Showing then
    Windows.SetFocus(Handle);

  DateTimeDec(1);
  if Assigned(FOnDownClick) then
    FOnDownClick(self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.DoValueChanged(Sender: TObject; OldVal,
  NewVal: double);
begin
  if Assigned(FOnValueChanged) then
    FOnValueChanged(Sender, OldVal, NewVal);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.DoValueChanging(Sender: TObject;
  var Val: double; var CanModify: boolean);
begin
  if Assigned(FOnValueChanging) then
    FOnValueChanging(Sender, Val, CanModify);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.DoDropDown;
begin
  if Assigned(FOnDropDown) then FOnDropDown(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.DropDown;
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
    FForm.Calendar.StartDay := FStartDay;
    if not ReadOnly then
    begin
      FForm.Color := FCalendarFormColor;

      if not Focused then
        SetFocus;
      if cfoShowOkCancelBtns in CalendarFormOptions then
        FForm.InitButtons;
      if cfoShowClock in CalendarFormOptions then
        FForm.InitClock;

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

      if KeepCalendarWithinForm then
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
procedure TLMDCustomDateTimePicker.GetCommandKey (var KeyCode : Word; Shift : TShiftState);
begin
   inherited GetCommandKey (KeyCode, Shift);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.GetChange (Sender : TObject);
begin
  inherited GetChange (Sender);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDateTimePicker.AllowedOperation(textToInsert : TLMDString) : Boolean;
begin
  result := inherited AllowedOperation(textToInsert) and FEditorEnabled;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomDateTimePicker.GetSpinBtnVisible: Boolean;
begin
  Result := FSpinBtn.Visible;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove (Shift, X, Y);
  FSpinBtn.MouseLeave;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.MouseExit;
begin
  inherited MouseExit;
  FSpinBtn.MouseLeave;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.DoThemeChanged;
begin
  FSpinBtn.ThemeMode := self.ThemeMode;
  inherited;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDCustomDateTimePicker.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);

  FKeepCalendarWithinForm := false;
  FCalendarHeader := TLMDCalendarHeader.Create;

  FFormWidth := -1;
  FFormHeight :=  -1;

  MinDateTime := -693593;
  MaxDateTime := 999999;

  FCalendarFormColor := clWhite;
  FCalendarPanelColor := clWhite;
  FClockPanelColor := clWhite;
  FButtonPanelColor := clWhite;

  FCalendarStyle := clsVista;
  FCalendarColorScheme := csDefaultScheme;
  FClockStyle := csWindows7;
  FClockColorScheme := csDefaultScheme;

  FAutoDisableButtons := false;
  FForceOverwriteMode := true;
  FSpinBtn := TLMDSpinButton.Create (self);
  FSpinBtn.ThemeMode := FThemeMode;
  FSpinBtn.Parent := self;
  FSpinBtn.Color := clBtnFace;
  FSpinBtnWidth := -1;
  FSpinBtn.SpinButtons := [sbUp, sbDown];
  FSpinBtn.ExtStyle := seSpinEdit;
  FSpinBtn.OnTopClick := DoInc;
  FSpinBtn.OnBottomClick := DoDec;
  FSpinBtn.OnLeftClick := DoInc;
  FSpinBtn.OnRightClick := DoDec;
  FSpinBtn.Cursor := crArrow;
  FSpinBtn.OldStyle := false;

  FCalendarFormOptions := [cfoShowClock, cfoCloseupOnDayClick, cfoShowOkCancelBtns];

  FMaskType := meDateTime;
  //TimeSettings.Format := tfShortSystem;
  //TimeSettings.FormatStr := 'HH:MM:SS';

  FEditorEnabled := true;
  BeginUpdate;
  try
    inherited CustomButtonsStyle:=ubsCombo;
    AsDateTime := now;
  finally
    EndUpdate;
  end;

  ShowPopupCalendar := true;
end;




{ ---------------------------------------------------------------------------- }
destructor TLMDCustomDateTimePicker.Destroy;
begin
  if Assigned(FSpinBtn) then
    FreeAndNil(FSpinBtn);
  if Assigned(FCalendarHeader) then
    FreeAndNil(FCalendarHeader);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.DestroyWnd;
begin
  if DroppedDown then
    CloseUp(false);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.Loaded;
begin
  inherited Loaded;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.ModifyPaintRect;
var
  w : Integer;
begin
  inherited ModifyPaintRect;
  w := FSpinBtnWidth;
  if w = -1 then //autosize btn
    w := FPaintRect.Bottom - FPaintRect.Top;
  //substract btn width from paintable area
  FPaintRect.Right := FPaintRect.Right - w;
  FSpinBtn.SetBounds (FPaintRect.Right {+ 1}, FPaintRect.Top, w , FPaintRect.Bottom - FPaintRect.Top); //VB March 2008
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDateTimePicker.UpdateSpinButtons;
begin
  FSpinBtn.Perform(CM_ENABLEDCHANGED, 1, Ord(bpsNormal));
  FSpinBtn.Perform(CM_ENABLEDCHANGED, 2, Ord(bpsNormal));
  if (AsDateTime >= MaxDateTime) and FAutoDisableButtons then
      FSpinBtn.Perform(CM_ENABLEDCHANGED, 2, Ord(bpsDisabled));
  if (AsDateTime <= MaxDateTime) and FAutoDisableButtons then
     FSpinBtn.Perform(CM_ENABLEDCHANGED, 1, Ord(bpsDisabled));
 end;

{ ----------------------------- TLMDCalendarForm ----------------------------- }
procedure TLMDCalendarForm.CalendarClick(Sender: TObject);
begin
  TriggerChangeEvent;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarForm.CMDeactivate(var Msg: TMessage);
begin
  inherited;
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDCalendarForm.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited CreateNew(AOwner, Dummy);
  Width := 360;
  Height := 220;
  OnCreate := FormCreate;
  OnClose := FormClose;
  OnShow := FormShow;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := WS_POPUP or WS_BORDER;
    ExStyle := WS_EX_TOPMOST;
  end;
end;

procedure TLMDCalendarForm.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
end;

procedure TLMDCalendarForm.FormCreate(Sender: TObject);
begin
  FCalendarPanel := TLMDPanelFill.Create(Self);
  BorderWidth := 4;

  if cfoShowOkCancelBtns in Options then
  begin
    FButtonPanel := TLMDPanelFill.Create(Self);
    with FButtonPanel do
    begin
      Parent := Self;
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

  if cfoShowClock in Options then
  begin
    FClockPanel := TLMDPanelFill.Create(Self);
    with FClockPanel do
    begin
      Parent := Self;
      Visible := false;
      Align := alRight;
      FClock := TLMDClock.Create(FClockPanel);
      FClock.Parent := FClockPanel;
      FTimePicker := TLMDMaskEdit.Create(FClockPanel);
      FTimePicker.Parent := FClockPanel;
      FTimePicker.MaskType := meTime;
      Width := 120;
    end;
    FTimePicker.TimeSettings.Assign(TLMDCustomDateTimePicker(Owner).TimeSettings);
  end;

  with FCalendarPanel do
  begin
    Parent := Self;
    Align := alClient;
  end;

  FCalendar := TLMDCalendar.Create(Self);
  FCalendar.StartDay := TLMDCustomDateTimePicker(Owner).StartDay;
  if cfoCloseUpOndayClick in TLMDCustomDateTimePicker(Owner).CalendarFormOptions then
    FCalendar.OnClick := CalendarClick
  else
    FCalendar.OnClick := nil;
  FCalendar.Visible := false;
  FCalendar.Align := alClient;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarForm.FormShow(Sender: TObject);
begin
  if TLMDCustomDateTimePicker(Owner).CalendarFormWidth > 0 then
    Width := TLMDCustomDateTimePicker(Owner).CalendarFormWidth;
  if TLMDCustomDateTimePicker(Owner).CalendarFormHeight > 0 then
    Height := TLMDCustomDateTimePicker(Owner).CalendarFormHeight;
  InitCalendar;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarForm.InitButtons;
var
  r, br: TRect;
  m: integer;
begin
  if cfoShowOkCancelBtns in Options then
  begin
    FButtonPanel.Visible := true;
    FButtonPanel.Color := TLMDCustomDateTimePicker(Owner).ButtonPanelColor;
    r := FButtonPanel.ClientRect;
    br := r;
    m := (r.Left + r.Right) div 2;
    br.Right := m;
    InflateRect(br, -20, -5);
    FCancelBtn.SetBounds(br.Left, br.Top, br.Right - br.Left, br.Bottom - br.Top);
    if TLMDCustomDateTimePicker(Owner).FCancelCaption <> '' then
      FCancelBtn.Caption := TLMDCustomDateTimePicker(Owner).FCancelCaption;
    OffSetRect(br, m, 0);
    FOkBtn.SetBounds(br.Left, br.Top, br.Right - br.Left, br.Bottom - br.Top);
    if TLMDCustomDateTimePicker(Owner).FOkCaption <> '' then
      FOkBtn.Caption := TLMDCustomDateTimePicker(Owner).FOkCaption;
  end;
end;

procedure TLMDCalendarForm.InitCalendar;
begin
  if FCalendar <> nil then
  begin
    FCalendar.Parent := FCalendarPanel;
    with FCalendarPanel do
    begin
      Color := TLMDCustomDateTimePicker(Owner).CalendarPanelColor;
      FillObject.Style := sfNone;
    end;
    FCalendar.Style := TLMDCustomDateTimePicker(Owner).CalendarStyle;
    FCalendar.ColorScheme := TLMDCustomDateTimePicker(Owner).CalendarColorScheme;
    FCalendar.Date := TLMDCustomDateTimePicker(Owner).AsDate;
    FCalendar.Header.Assign(TLMDCustomDateTimePicker(Owner).CalendarHeader);
    FCalendar.Visible := true;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarForm.InitClock;
var
  R, R1: TRect;
  W, vdelta: integer;
  P: TPoint;
  s :string;
begin
  vdelta := 6;

  FClockPanel.Visible := true;
  FClockPanel.Color := TLMDCustomDateTimePicker(Owner).ClockPanelColor;

  R := FClockPanel.ClientRect;
  InflateRect(R, -4, -4);

  W := Min(R.Right - R.Left, R.Bottom - R.Top);
  P := LMDMiddlePoint(R.TopLeft, R.BottomRight);
  R := Rect(p.X - W div 2, p.Y - W div 2 - vdelta, p.X + W div 2, p.Y + W div 2 - vdelta);

  FClock.SetBounds(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
  FClock.Style := csWindows7;

  R1.Left := (R.Left + R.Right) div 2 - 25;
  R1.Right := R1.Left + 50;
  R1.Top := R.Bottom + 3;
  R1.Bottom := R.Bottom + 20;

  FTimePicker.Options := FTimePicker.Options + [eoNarrowHeight];
  FTimePicker.SetBounds(R1.Left, R1.Top, R1.Right - R1.Left, R1.Bottom - R1.Top);
  FTimePicker.Visible := true;
  //FTimePicker.TimeSettings.Format := tfShortSystem;
  //FTimePicker.TimeSettings.FormatStr := 'HH:MM:SS';
  FTimePicker.AsTime := TLMDCustomDateTimePicker(Owner).AsTime;
  FClock.FixedTime.DateTimeValue := FTimePicker.AsTime;
  s := FTimePicker.TimeSettings.TimeToStr(FTimePicker.AsTime);
  FClock.Options := [coShowAnalog, coFixed];
  FClock.Style := TLMDCustomDateTimePicker(Owner).ClockStyle;
  FClock.ColorScheme := TLMDCustomDateTimePicker(Owner).ClockColorScheme;
  FClock.Color := FClockPanel.Color;

  FTimePicker.OnChange := TimeChanged;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCalendarForm.Options: TLMDCalendarFormOptions;
begin
  result := TLMDCustomDateTimePicker(Owner).CalendarFormOptions;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarForm.TimeChanged(Sender: TObject);
begin
  FClock.FixedTime.DateTimeValue := FTimePicker.AsTime;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarForm.WMActivate(var Msg: TWMActivate);
begin
  inherited;
  if Msg.Active = WA_INACTIVE then
  begin
    if Assigned(FOnDeactivate) then FOnDeactivate(Self);
  end

end;

end.
