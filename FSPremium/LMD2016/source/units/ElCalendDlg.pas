unit ElCalendDlg;
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

ElCalendDlg unit
----------------

Changes
-------
Release 6.0 (March 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Dialogs, SysUtils, Messages, Classes, Graphics, Controls, StdCtrls,
  Types,TypInfo,
  ElCalendarDefs, ElDTPick, ElClock,
  ElStyleMan, ElComponent, ElVCLUtils, ElXPThemedControl,ExtCtrls;

type

  TElCalendarDialog = class(TElBaseDlgComponent)
  private
    FDate : TDateTime;
    FCurrentDayBitmap: TBitmap;
    FCurrentDayUseBitmap: Boolean;
    FLineBorderColor : TColor;
    FShowHolidays : Boolean;
    FShowPeriods : Boolean;
    FStartOfWeek : TDayOfWeek;
    FUseCurrentDate : Boolean;
    FShowWeekNum : Boolean;
    FWeekEndDays : TElWeekEndDays;
    FPeriodStart : TDateTime;
    FPeriodLength: Word;
    FPeriodInterval: Word;
    FPeriodColor : TColor;
    FHolidayColor : TColor;
    FWeekEndColor : TColor;
    FUseSystemStartOfWeek: Boolean;
    FHolidays : TElHolidays;
    FShowClock: Boolean;
    FOnChange : TNotifyEvent;

    procedure PrepareDialog(FrmDialogComponent : TElCalendarForm);
  protected
    FSelectionBorder: TElFlatBorderType;
    FDayCellBorder: TElFlatBorderType;
    FCurrentDayBorder: TElFlatBorderType;
    FUseLineColors: Boolean;
    FLineColorDark: TColor;
    FLineColorLight: TColor;
    FTranslateDays: Boolean;
    FOnDetermineHoliday: TElHolidayEvent;
    FUseXPThemes: Boolean;
    FFlatButtons: Boolean;
    FStyleManager: TElStyleManager;
    FStyleName: string;
    FGridVertLines: Boolean;
    FGridHorzLines: Boolean;
    FGridLineColor: TColor;
    FOnBeforeCellDraw: TBeforeCellDrawEvent;
    FOtherMonthDayColor: TColor;
    FShowOtherMonthDays: Boolean;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    procedure DefineProperties(Filer : TFiler); override;
    procedure Notification(AComponent : TComponent; Operation : TOperation);
        override;
    procedure SetCurrentDayBitmap(Value : TBitmap);
    //FTitleColor : TColor;
    //procedure SetTitleColor(FColor : TColor);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function Execute : boolean; override;
  published
    property ShowClock: Boolean read FShowClock write FShowClock;
    property Date : TDateTime read FDate write FDate;
    property FlatButtons : Boolean read FFlatButtons write FFlatButtons default true;
    property ShowHolidays : Boolean read FShowHolidays write FShowHolidays default true;
    property ShowPeriods : Boolean read FShowPeriods write FShowPeriods;
    property StartOfWeek : TDayOfWeek read FStartOfWeek write FStartOfWeek;
    property UseCurrentDate : Boolean read FUseCurrentDate write FUseCurrentDate;
    property ShowWeekNum : Boolean read FShowWeekNum write FShowWeekNum default false;
    property WeekEndDays : TElWeekEndDays read FWeekEndDays write FWeekEndDays;
    property PeriodStart : TDateTime read FPeriodStart write FPeriodStart;
    property PeriodLength: Word read FPeriodLength write FPeriodLength default 1;
    property PeriodInterval: Word read FPeriodInterval write FPeriodInterval
        default 28;
    property PeriodColor : TColor read FPeriodColor write FPeriodColor default clAqua;
    property HolidayColor : TColor read FHolidayColor write FHolidayColor;
    property WeekEndColor : TColor read FWeekEndColor write FWeekEndColor default clBtnText;
    //property TitleColor : TColor read FTitleColor write SetTitleColor default clBtnFace;
    property Holidays : TElHolidays read FHolidays;

    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    property UseSystemStartOfWeek: Boolean read FUseSystemStartOfWeek write
        FUseSystemStartOfWeek;
    property SelectionBorder: TElFlatBorderType read FSelectionBorder write
        FSelectionBorder;
    property DayCellBorder: TElFlatBorderType read FDayCellBorder write
        FDayCellBorder;
    property CurrentDayBorder: TElFlatBorderType read FCurrentDayBorder write
        FCurrentDayBorder;
    property CurrentDayUseBitmap: Boolean read FCurrentDayUseBitmap write FCurrentDayUseBitmap default false;
    property CurrentDayBitmap: TBitmap read FCurrentDayBitmap write SetCurrentDayBitmap;
    property UseLineColors: Boolean read FUseLineColors write FUseLineColors;
    property LineColorDark: TColor read FLineColorDark write FLineColorDark default clBtnShadow;
    property LineColorLight: TColor read FLineColorLight write FLineColorLight default clWindow;
    property LineBorderColor: TColor read FLineBorderColor write FLineBorderColor default clWindowText;
    property TranslateDays: Boolean read FTranslateDays write FTranslateDays
        default true;
    property OnDetermineHoliday: TElHolidayEvent read FOnDetermineHoliday write
        FOnDetermineHoliday;
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    property UseXPThemes: Boolean read FUseXPThemes write FUseXPThemes default true;
    property GridVertLines: Boolean read FGridVertLines write FGridVertLines
        default true;
    property GridHorzLines: Boolean read FGridHorzLines write FGridHorzLines
        default true;
    property GridLineColor: TColor read FGridLineColor write FGridLineColor default
        clBtnFace;
    property OnBeforeCellDraw: TBeforeCellDrawEvent read FOnBeforeCellDraw write
        FOnBeforeCellDraw;
    property OtherMonthDayColor: TColor read FOtherMonthDayColor write
        FOtherMonthDayColor default clGrayText;
    property ShowOtherMonthDays: Boolean read FShowOtherMonthDays write
        FShowOtherMonthDays default false;
  end;

implementation
uses ElEdits, Forms;

type
  THackClock = class(TElTClock)
  end;

procedure TElCalendarDialog.PrepareDialog(FrmDialogComponent : TElCalendarForm);
var
  ADay, AMonth, AYear : word;
  i : integer;
  PropInfo   : PPropInfo;

begin
  with FrmDialogComponent do
  begin
    FlatButtons := FFlatButtons;
    Color := clBtnFace;
    DecodeDate(Date, AYear, AMonth, ADay);
    Calendar.Day := ADay;
    Calendar.Month := AMonth;
    Calendar.Year := AYear;
    Calendar.ShowHolidays := FShowHolidays;
    Calendar.ShowPeriods := FShowPeriods;
    Calendar.StartOfWeek := FStartOfWeek;
    Calendar.UseSystemStartOfWeek := FUseSystemStartOfWeek;
    Calendar.UseCurrentDate := FUseCurrentDate;
    Calendar.ShowWeekNum := ShowWeekNum;
    Calendar.WeekEndDays := WeekEndDays;
    Calendar.PeriodStart := PeriodStart;
    Calendar.PeriodLength := PeriodLength;
    Calendar.PeriodInterval := PeriodInterval;
    Calendar.PeriodColor := PeriodColor;
    Calendar.HolidayColor := HolidayColor;
    Calendar.WeekEndColor := WeekEndColor;
    Calendar.Holidays.Assign(FHolidays);
    Calendar.SelectionBorder := SelectionBorder;
    Calendar.DayCellBorder := DayCellBorder;
    Calendar.CurrentDayBorder := CurrentDayBorder;
    Calendar.UseLineColors := UseLineColors;
    Calendar.LineColorDark := LineColorDark;
    Calendar.LineColorLight := LineColorLight;
    Calendar.TranslateDays := TranslateDays;
    Calendar.OnDetermineHoliday := OnDetermineHoliday;
    Calendar.GridVertLines := GridVertLines;
    Calendar.GridHorzLines := GridHorzLines;
    Calendar.GridLineColor := GridLineColor;
    Calendar.OnBeforeCellDraw := OnBeforeCellDraw;
    Calendar.ShowOtherMonthDays := ShowOtherMonthDays;
    Calendar.OtherMonthDayColor := OtherMonthDayColor;
    Calendar.LineBorderColor := FLineBorderColor;
    if not FCurrentDayBitmap.Empty then
      Calendar.CurrentDayBitmap.Assign(FCurrentDayBitmap);
    Calendar.CurrentDayUseBitmap := FCurrentDayUseBitmap;
    ShowClock := Self.FShowClock;
    CancelBtn.Visible := True;

    if UseCurrentDate then
      THackClock(Clock).FDT := Now
    else
      THackClock(Clock).FDT := Date;
    for i := 0 to ComponentCount - 1 do
    begin
      PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleManager');
      if PropInfo <> nil then
        SetObjectProp(Components[i], PropInfo, Self.StyleManager);
      PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleName');
      if PropInfo <> nil then
        SetStrProp(Components[i], PropInfo, Self.StyleName);
    end;
    Font.Assign(Calendar.Font);
//    for i := 0 to ComponentCount - 1 do
//    begin
//      PropInfo := TypInfo.GetPropInfo(Components[i].ClassInfo, 'UseXPThemes');
//      if PropInfo <> nil then
//        SetOrdProp(Components[i], PropInfo, Ord(UseXPThemes));
//    end;
    FrmDialogComponent.SetFormThemed(UseXPThemes);
    FrmDialogComponent.CalcFormSizes;
    FrmDialogComponent.RangeButtons;
  end;
end;

function TElCalendarDialog.Execute : boolean;
var
  FrmDialogComponent : TElCalendarForm;

  ADay, AMonth, AYear : word;

begin
  result := false;
  if csDesigning in ComponentState then
    FrmDialogComponent := TElCalendarForm.CreateNew(nil, 0)
  else
    FrmDialogComponent := TElCalendarForm.CreateNew(self, 0);
  try
    PrepareDialog(FrmDialogComponent);

    FrmDialogComponent.ClearBtn.Visible := false;
    FrmDialogComponent.IsModal := true;
    FrmDialogComponent.OnChange := OnChange;
    if (FrmDialogComponent.ShowModal = mrYes) then
      result := true;
    if result then
    begin
      ADay := FrmDialogComponent.Calendar.Day;
      AMonth := FrmDialogComponent.Calendar.Month;
      AYear := FrmDialogComponent.Calendar.Year;
      if (FShowClock) then
        FDate := Trunc(FrmDialogComponent.Calendar.Date) + Frac(FrmDialogComponent.Clock.DT)
      else
        FDate := EncodeDate(AYear, AMonth, ADay);
  end;
  finally
    FrmDialogComponent.Free;
  end;
end;

destructor TElCalendarDialog.Destroy;
begin
  FHolidays.Free;
  FCurrentDayBitmap.Free;
  inherited Destroy;
end;

constructor TElCalendarDialog.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FHolidays := TElHolidays.Create(nil);
  FShowWeekNum := False;
  FWeekEndDays := [Sat, Sun];
  FWeekEndColor := clBtnText;
  FShowHolidays := True;
  FPeriodLength := 1;
  FPeriodInterval := 28;
  FPeriodColor := clAqua;
  FDate := Now;
  FUseXPThemes := true;
  FTranslateDays := true;
  FGridLineColor := clBtnFace;
  FGridVertLines := true;
  FGridHorzLines := true;
  FShowClock := True;
  FLineColorDark := clBtnShadow;
  FLineColorLight := clWindow;
  FCurrentDayBitmap := TBitmap.Create;
  FCurrentDayUseBitmap := False;
  FLineBorderColor := clWindowText;
  FFlatButtons := True;
end;

procedure TElCalendarDialog.DefineProperties(Filer : TFiler);
begin
  inherited;
  with GetElReader do
    Filer.DefineProperty('GridLineWidth', FakeInteger, nil, false);
end;

procedure TElCalendarDialog.Notification(AComponent : TComponent; Operation :
    TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FStyleManager then
      StyleManager := nil;
  end;
end;

procedure TElCalendarDialog.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
    if (FStyleManager <> nil) then
    if not (csDestroying in FStyleManager.ComponentState) then
      FStyleManager.RemoveFreeNotification(Self);
    FStyleManager := Value;
    if FStyleManager <> nil then
      FStyleManager.FreeNotification(Self);
  end;
end;

procedure TElCalendarDialog.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
    FStyleName := Value;
end;

procedure TElCalendarDialog.SetCurrentDayBitmap(Value: TBitmap);
begin
  FCurrentDayBitmap.Assign(Value);
end;

end.
