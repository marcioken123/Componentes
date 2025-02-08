unit LMDCalendarComboBox;
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

LMDCalendarComboBox unit (JH)
-----------------------------

Edit control (combobox) for selecting dates. Integrated drop down calendar 
control for visual date selection.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, LMDCal, LMDClass,
  LMDCalendar, LMDCustomExtCombo;

type
  TLMDCalendarOpenEvent = procedure (Sender: TObject; Calendar: TLMDCalendar) of object;

  TLMDCalendarComboBox = class (TLMDCustomExtCombo)
  private
    FOld    : String;
    FCalOpen: TLMDCalendarOpenEvent;
    FToday  : Boolean;
    FStartDay: Byte;
    FCalendarStyle: TLMDCalendarStyle;
    FCalendarColorScheme: TLMDColorScheme;
    function GetCalendar:TLMDCalendar;
    function GetValue: TDateTime;
    procedure SetDValue(const Value: TDateTime);
  protected
    procedure CreateControl; override;
    procedure ModifyControl; override;
    procedure DisplayControl; override;
    procedure DoThemeChanged;override;
    procedure BeforeDropDown; override;
    procedure Cancel; override;
    procedure Accept; override;
    procedure GetCommandKey (var KeyCode : Word; Shift : TShiftState); override; //added April 02 JH
    procedure DoTodayClick(Sender:TObject);
    procedure DoDateSel(Sender: TObject; Date: TDateTime); virtual;
    procedure DoMouseClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Loaded; override;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Init; override;
    property Calendar:TLMDCalendar read GetCalendar;
    property Value:TDateTime read GetValue write SetDValue;
  published
    property CalendarStyle: TLMDCalendarStyle read FCalendarStyle write FCalendarStyle;
    property CalendarColorScheme: TLMDColorScheme read FCalendarColorScheme write FCalendarColorScheme;
    property DateSettings;
    property DropDownWidth;
    property DropDownHeight;
    property ShowTodayButton:Boolean read FToday write FToday default false;
    property OnCalendarOpen: TLMDCalendarOpenEvent read FCalOpen write FCalOpen;
    // 8.0
    property StartDay:Byte read FStartDay write FStartDay default 1;

  end;

  TLMDLabeledCalendarComboBox = class(TLMDCalendarComboBox)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation

uses
  Windows, Graphics, Messages, SysUtils,
  LMDGraph, LMDConst, LMDButtonBase, LMDCustomMaskEdit, LMDCustomSpeedButton;
  { ****************** TLMDCalendarComboBox *************************************}
{----------------------- private ----------------------------------------------}
procedure TLMDCalendarComboBox.SetDValue(const Value: TDateTime);
begin
  inherited SetValue(Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCalendarComboBox.GetValue: TDateTime;
begin
  result:=AsDate;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCalendarComboBox.GetCalendar:TLMDCalendar;
begin
  result:=TLMDCalendar(FControl);
end;

{----------------------- protected --------------------------------------------}
procedure TLMDCalendarComboBox.CreateControl;
begin
  FControl := TLMDCalendar.Create (self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarComboBox.ModifyControl;
begin

  if DropDownWidth = 0 then
    FControl.Width := 200
  else
    FControl.Width := DropDownWidth;
  if DropDownHeight = 0 then
    FControl.Height := 150
  else
    FControl.Height := DropDownHeight;

  with TLMDCalendar(FControl) do
  begin
    BeginUpdate;
    if CalendarStyle <> clsSimple then
    begin
      Style := FCalendarStyle;
      ColorScheme := FCalendarColorScheme;
    end
    else
    begin
      ThemeMode := self.ThemeMode;
      //StartWithActualDate := true;
      Header.Elements := [heMonthName, heMonthBtns, heYearBtns, heYear];
      //Color := clWhite; removed 07/07/00 JH - works without this - error if included (will turn edit back to clWhite)
      Header.Style.FillObject.Style := sfBrush;
      Header.Style.FillObject.Brush.Color := clActiveCaption;
      Header.Style.Font.Color := clWhite;
      FillObject.Style := sfBrush;
      FillObject.Brush.Color := clWhite;
      ShowGrid := false;

      SelectedCellStyle.Bevel.Mode := bmStandard;
      SelectedCellStyle.Bevel.StandardStyle := lsSingle;
      DayCaptionCellStyle.FillObject.Style := sfNone;
      DayCaptionCellStyle.Bevel.Mode := bmEdge;
      DayCaptionCellStyle.Bevel.EdgeStyle := etBump;
      DayCaptionCellStyle.Bevel.BorderSides := [fsBottom];
    end;
    Bevel.Mode := bmStandard;
    Bevel.StandardStyle := lsSingle;

    StartDay:=self.StartDay;
    OnMouseClick := DoMouseClick;
    OnDateSel := DoDateSel;
    EndUpdate(true);
  end;

  if FToday then
    with TLMDCustomSpeedButton.Create(FControl) do
    begin
      Parent:=FControl;
      Width:=40;
      Height:=16;
      Visible:=false;
      Caption:=IDS_ACTUALDATE;
      Font.Color:=clRed;
      Left:=TLMDCalendar(FControl).ClientWidth-Width-1;
      Top:=TLMDCalendar(FControl).ClientHeight-Height-1;
      Style:=ubsExplorer;
      ThemeMode := self.ThemeMode;
      Visible:=True;
      Anchors:=[akRight,akBottom];
      OnCLick:=DoTodayClick;
    end;

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarComboBox.BeforeDropDown;
begin
  FOld := Text;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarComboBox.DoThemeChanged;
begin
  inherited;
  if Assigned(Control) then ModifyControl
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarComboBox.DisplayControl;
begin
  TLMDCalendar(FControl).Date := AsDate;

  if Assigned (FCalOpen) then FCalOpen (self, TLMDCalendar(FControl));
//  FControl.SetFocus;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarComboBox.Cancel;
begin
  Text := FOld;
  inherited;
end;

procedure TLMDCalendarComboBox.CMCancelMode(var Message: TCMCancelMode);
begin
  if Assigned (Message.Sender) and (Message.Sender <> Self) and (Message.Sender <> FControl) and (Message.Sender.Parent <> FControl)
    and (Message.Sender <> CustomButtons.Items[0].Btn) then
    begin
      Close(False);
      FClickHandled := false;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarComboBox.Accept;
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarComboBox.GetCommandKey (var KeyCode : Word; Shift : TShiftState);
begin
  if not DroppedDown then inherited; //added April 02, JH
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarComboBox.DoDateSel(Sender: TObject; Date: TDateTime);
begin
  Text := DateSettings.DateToStr (Date);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarComboBox.DoMouseClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Close (true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarComboBox.DoTodayClick(Sender:TObject);
begin
  Text := DateSettings.DateToStr (SysUtils.Date);
  Close (true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarComboBox.Loaded;
begin
  inherited Loaded;
  Init;
end;

{----------------------- public -----------------------------------------------}
constructor TLMDCalendarComboBox.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  AllowDownKey := true;
  FStartDay := 1;
end;
{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarComboBox.Init;
begin
  MaskType := meDate;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledCalendarComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
