{ Summary
  Unit that contains the dialog sheet specific wrapper functions.
  Description
  Use the methods available in this unit to avoid having to place a TJSDialogSheet component on a form at designtime. }
unit JSDialogSheets;

interface

{$I lmddlgcmps.inc}

uses
  Controls, JSDialog, JSDialogSheet, JSDialogs;

{ Summary
  Displays a dialog sheet with the information icon visible.
  Description
  Call this method when you want to display an information info sheet with a close button. The dialog will be modal
  and display using the Instruction and Content values passed in.
  The display location of the sheet is determined by the value of the ALocation parameter. }
procedure ShowInfoSheet(const AInstruction, AContent: string; ALocation: TJSSheetLocation);
{ Summary
  Displays a dialog sheet that will close after a specific time period.
  Description
  Call this method to display a time sensitive sheet dialog. The default timeout period is three seconds but this can
  be modified by making sure the ATimeOut parameter is set.
  By default this method will display non-modal. To display the sheet as modal set the AIsModal parameter to True.
  Define the buttons you want to be visible on the dialog by setting the AButtons parameter to contain the list of possible
  common buttons. To have no button bar section of the dialog visible, set the AButtons parameter to an empty set ([]).
  Remarks
  The ATimeOut parameter is in seconds NOT milliseconds                                                           }
function ShowTimedInfoSheet(const AInstruction, AContent: string; ALocation: TJSSheetLocation; AButtons: TCommonButtons = [cbClose];
  const ATimeOut: Integer = 3; const AIsModal: Boolean = False; ACloseCallback: TDialogCloseEvent = nil; ATimerCallback: TTimerEvent = nil): TModalResult;
function ShowModalTimedInfoSheet(const AInstruction, AContent: string; ALocation: TJSSheetLocation; AButtons: TCommonButtons = [cbClose];
  const ATimeOut: Integer = 3): TModalResult;

implementation

uses
  Forms, Classes, Contnrs, SysUtils;

type
  TTimerItem = class
  private
    FTimeout: Integer;
    FCallback: TTimerEvent;
  public
    constructor Create(const ATimeout: Integer; ACallback: TTimerEvent);
    property Timeout: Integer read FTimeout write FTimeout;
  end;

  TJSDialogSheetEvents = class
  private
    FTimers: TObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    function AddTimerEvent(const ATimeOut: Integer; ATimerCallback: TTimerEvent): Integer;
    procedure CallCallback(const ATimerId: Integer; ASender: TObject; const ATimeSince: Cardinal);
    function DecTimer(const ATimerId: Integer): Integer;
    procedure TimerHandler(Sender: TObject; const TimeSince: Cardinal);
  end;

var
  _Events: TJSDialogSheetEvents;

procedure ShowInfoSheet(const AInstruction, AContent: string; ALocation: TJSSheetLocation);
var
  LDlg: TJSDialogSheet;
begin
  LDlg := TJSDialogSheet.Create(Application);
  try
    LDlg.Instruction.Text := AInstruction;
    LDlg.Content.Text := AContent;
    LDlg.Sheet.Location := ALocation;
    LDlg.MainIcon := tdiInformation;
    LDlg.ButtonBar.Buttons := [cbClose];
    LDlg.ButtonBar.Default := cbClose;
    LDlg.ButtonBar.Cancel := cbClose;
    LDlg.Execute;
  finally
    LDlg.Free;
  end;
end;

function ShowTimedInfoSheet(const AInstruction, AContent: string; ALocation: TJSSheetLocation; AButtons: TCommonButtons = [cbClose];
  const ATimeOut: Integer = 3; const AIsModal: Boolean = False; ACloseCallback: TDialogCloseEvent = nil; ATimerCallback: TTimerEvent = nil): TModalResult;
var
  LDlg: TJSDialogSheet;
begin
  LDlg := TJSDialogSheet.Create(Application);
  try
    LDlg.Instruction.Text := AInstruction;
    LDlg.Content.Text := AContent;
    LDlg.Sheet.Location := ALocation;
    LDlg.MainIcon := tdiInformation;
    LDlg.ButtonBar.Buttons := AButtons;
    if AButtons = [] then
      LDlg.ButtonBar.Visible := False
    else
      LDlg.ButtonBar.DetermineDefaults;
    LDlg.DialogOptions := LDlg.DialogOptions + [doTimer];
    if not AIsModal then
      LDlg.DialogOptions := LDlg.DialogOptions - [doModal];
    LDlg.Tag := _Events.AddTimerEvent(ATimeOut, ATimerCallback);
    LDlg.OnTimer := _Events.TimerHandler;
    LDlg.OnDialogClose := ACloseCallback;
    Result := LDlg.Execute;
    if not AIsModal then
      Result := mrIgnore;
  finally
    if AIsModal then
      LDlg.Free;
  end;
end;

function ShowModalTimedInfoSheet(const AInstruction, AContent: string; ALocation: TJSSheetLocation; AButtons: TCommonButtons = [cbClose];
  const ATimeOut: Integer = 3): TModalResult;
begin
  Result := ShowTimedInfoSheet(AInstruction, AContent, ALocation, AButtons, ATimeOut, True, nil, nil);
end;

{ TJSDialogSheetEvents }

function TJSDialogSheetEvents.AddTimerEvent(const ATimeOut: Integer; ATimerCallback: TTimerEvent): Integer;
begin
  Result := FTimers.Add(TTimerItem.Create(ATimeOut, ATimerCallback));
end;

procedure TJSDialogSheetEvents.CallCallback(const ATimerId: Integer; ASender: TObject; const ATimeSince: Cardinal);
var
  LItem: TTimerItem;
begin
  LItem := TTimerItem(FTimers[ATimerId]);
  if LItem <> nil then
  begin
    if Assigned(LItem.FCallback) then
      LItem.FCallback(ASender, ATimeSince);
  end;
end;

constructor TJSDialogSheetEvents.Create;
begin
  FTimers := TObjectList.Create;
end;

function TJSDialogSheetEvents.DecTimer(const ATimerId: Integer): Integer;
var
  LItem: TTimerItem;
begin
  LItem := TTimerItem(FTimers[ATimerId]);
  if LItem <> nil then
  begin
    Result := LItem.Timeout;
    Dec(Result);
    LItem.Timeout := Result;
  end
  else
    Result := 0;
end;

destructor TJSDialogSheetEvents.Destroy;
begin
  FTimers.Free;
  inherited;
end;

procedure TJSDialogSheetEvents.TimerHandler(Sender: TObject; const TimeSince: Cardinal);
var
  LEventId: Integer;
  LResult: Integer;
begin
  LEventId := TJSCustomDialog(Sender).Tag;
  _Events.CallCallback(LEventId, Sender, TimeSince);
  LResult := _Events.DecTimer(LEventId);
  if LResult = 0 then
  begin
    TJSCustomDialog(Sender).Close();
  end;
end;

{ TTimerItem }

constructor TTimerItem.Create(const ATimeout: Integer; ACallback: TTimerEvent);
begin
  FTimeout := ATimeout;
  FCallback := ACallback;
end;

initialization
  _Events := TJSDialogSheetEvents.Create;
finalization
  _Events.Free;

end.
