unit ElTreeDTPickEdit;
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

ElTreeDTPickEdit unit
---------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  Controls,
  Forms,
  Graphics,
  SysUtils,
  Classes,
  Types,
  LMDProcs,
  ElStyleMan,
  ElTree,
  ElHeader,
  ElDTPick,
  ElTreeInplaceEditors;

type

    TElTreeInplaceDateTimePicker = class(TElTreeInplaceEditor)
    private
      SaveWndProc: TWndMethod;
      procedure EditorWndProc(var Message : TMessage);
      procedure SetShowPopupCalendar(Value: Boolean);
      function GetShowPopupCalendar: Boolean;
      procedure SetShowCalendarClock(Value: Boolean);
      function GetShowCalendarClock: Boolean;
      procedure SetFormat(Value: TElDatePickerFormat);
      function GetFormat: TElDatePickerFormat;
    protected
      FIgnoreKillFocus  : boolean;
      procedure AdjustBounds; override;
      function GetEditor: TElDateTimePicker;
      procedure CalDropDown(Sender : TObject);
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
      property Editor: TElDateTimePicker read GetEditor;
    published
      property StyleManager: TElStyleManager read GetStyleManager write
          SetStyleManager;
      property StyleName: string read GetStyleName write SetStyleName;
      property Font;
      property ShowPopupCalendar: Boolean read GetShowPopupCalendar write SetShowPopupCalendar stored True;
      property Format : TElDatePickerFormat read GetFormat write SetFormat stored True;
      property CalendarShowClock: Boolean read GetShowCalendarClock write SetShowCalendarClock stored True;
    end;

implementation

constructor TElTreeInplaceDateTimePicker.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := TElDateTimePicker.Create(Self);
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  FEditor.Visible := false;
  Editor.HandleDialogKeys := true;
  Editor.ShowPopupCalendar := True;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  Editor.OnDropDown := CalDropDown;
  FTypes := [sftDate, sftTime, sftDateTime];
end;

destructor TElTreeInplaceDateTimePicker.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElTreeInplaceDateTimePicker.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElTreeInplaceDateTimePicker.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

function TElTreeInplaceDateTimePicker.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElTreeInplaceDateTimePicker.CalDropDown(Sender : TObject);
begin
  FIgnoreKillFocus := Editor.DroppedDown;
end;

procedure TElTreeInplaceDateTimePicker.TriggerAfterOperation(var Accepted :
    boolean; var DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
  case Self.DataType of
    sftDate: ValueAsText := DateToStr(Editor.Date);
    sftTime: ValueAsText := TimeToStr(Editor.Time);
    sftDateTime: ValueAsText := DateTimeToStr(Editor.DateTime);
  end;
end;

procedure TElTreeInplaceDateTimePicker.TriggerBeforeOperation(var
    DefaultConversion : boolean);
begin
  AdjustBounds;
  inherited;
  if DefaultConversion then
  try
    case Self.DataType of
      sftDate: Editor.Date := StrToDate(ValueAsText);
      sftTime: Editor.Time := StrToTime(ValueAsText);
      sftDateTime: Editor.DateTime := StrToDateTime(ValueAsText);
    end;
  except
    on E: EConvertError do
      Editor.DateTime := Now;
  end;
end;

type THackElTree = class(TCustomElTree);
     THackDTPick = class(TElDateTimePicker);

procedure TElTreeInplaceDateTimePicker.EditorWndProc(var Message : TMessage);
var
  InputValid : boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    TriggerKeyDown(TWMKey(Message));
    with TWMKey(Message) do
    if KeyDataToShiftState(KeyData) = [] then
    begin
      if CharCode = VK_RETURN then
      begin
        InputValid := true;
        FEditing := false;
        TriggerValidateResult(InputValid);
        FEditing := true;
        if InputValid then
        begin
          CompleteOperation(true);
          CharCode := 0;
          exit;
        end
        else
          Editor.SetFocus;
        CharCode := 0;
      end
      else
      if CharCode = VK_ESCAPE then
      begin
        CompleteOperation(false);
        CharCode := 0;
        exit;
      end;
    end;
  end
  else
    if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      ((Message.lParam = 0) or
      ((TControl(TObject(Pointer(Message.lParam))).Parent <> Editor) and
      (TObject(Pointer(Message.lParam)) <> Editor)))
      ) or
     ((Message.Msg = WM_KILLFOCUS) and (not FIgnoreKillFocus)) then
    if FEditing then
    begin
      if THackElTree(Tree).ExplorerEditMode then
      begin
        EndEditWithInputChecked;
      end
      else
        CompleteOperation(false);
    end;
  SaveWndProc(Message);
end;

procedure TElTreeInplaceDateTimePicker.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

function TElTreeInplaceDateTimePicker.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElTreeInplaceDateTimePicker.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElTreeInplaceDateTimePicker.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElTreeInplaceDateTimePicker.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

function TElTreeInplaceDateTimePicker.GetShowPopupCalendar: Boolean;
begin
  if Assigned(FEditor) then
    Result := Editor.ShowPopupCalendar
  else
    Result := False;
end;

function TElTreeInplaceDateTimePicker.GetShowCalendarClock: Boolean;
begin
  if Assigned(FEditor) then
    Result := Editor.CalendarShowClock
  else
    Result := False;
end;

procedure TElTreeInplaceDateTimePicker.SetShowCalendarClock(
  Value: Boolean);
begin
  if Assigned(FEditor) then
    Editor.CalendarShowClock := Value;
end;

procedure TElTreeInplaceDateTimePicker.SetShowPopupCalendar(
  Value: Boolean);
begin
  if Assigned(FEditor) then
    Editor.ShowPopupCalendar := Value;
end;

function TElTreeInplaceDateTimePicker.GetFormat: TElDatePickerFormat;
begin
  if Assigned(FEditor) then
    Result := Editor.Format
  else
    Result := edfShortDateLongTime;
end;

procedure TElTreeInplaceDateTimePicker.SetFormat(
  Value: TElDatePickerFormat);
begin
  if Assigned(FEditor) then
    Editor.Format := Value;
end;

procedure TElTreeInplaceDateTimePicker.AdjustBounds;
var
  r: TRect;
begin
  r := FCellRect;
  InflateRect(r, 1, 1);
  AdjustBoundsRect(r);
  FEditor.BoundsRect := r;
end;

function TElTreeInplaceDateTimePicker.GetEditor: TElDateTimePicker;
begin
  Result := FEditor as TElDateTimePicker;
end;

end.
