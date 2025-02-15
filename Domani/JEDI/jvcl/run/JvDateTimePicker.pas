{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvDateTimePicker.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is S?stien Buysse [sbuysse att buypin dott com]
Portions created by S?stien Buysse are Copyright (C) 2001 S?stien Buysse.
All Rights Reserved.

Contributor(s):
Michael Beck [mbeck att bigfoot dott com]

Peter Thrnqvist [peter3 att peter3 dott com]:
* Added NullDate, NullText and DropDownDate properties
  * Bug: When TDateTImePicker is used for TIMES, it is impossible to turn
     off the NullDate feature. It should be optional! -W.Postma.

Marc Geldon [marcgeldon att web dott de]
* Fixed CheckNullValue (any nonformat characters must be enclosed within single quotes!)


You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:
* (p3) To make NullDate and NullText maximally useful, set ParseInput to True and handle the
  OnUserInput something like this:
    if UserString = '' then
      DateAndTime := JvDateTimePicker1.NullDate;

-----------------------------------------------------------------------------}
// $Id: JvDateTimePicker.pas,v 1.37 2006/01/08 13:38:30 obones Exp $

unit JvDateTimePicker;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Windows, Messages, SysUtils, Classes, Controls, ComCtrls,
  JvExComCtrls;

type
  TJvDateTimePicker = class(TJvExDateTimePicker)
  private
    FNullText: string;
    FNullDate: TDateTime;
    FDropDownDate: TDate;
    FWeekNumbers: Boolean;
    FKeepNullText: string;
    FShowTodayCircle: Boolean;
    FShowToday: Boolean;
    {$IFDEF COMPILER5}
    FFormat: string;
    procedure SetFormat(const Value: string);
    {$ENDIF COMPILER5}
    procedure CNNotify(var Msg: TWMNotify); message CN_NOTIFY;
    procedure SetNullDate(const Value: TDateTime);
    procedure SetNullText(const Value: string);
    procedure UpdateCalendar(CalHandle: THandle);
  protected
    function WithinDelta(Val1, Val2: TDateTime): Boolean; virtual;
    // returns True if NullDate matches Date or frac(NullDate) matches frac(Time) depending on Kind
    function CheckNullValue: Boolean; overload;
    function CheckNullValue(const ANullText, AFormat: string; AKind: TDateTimeKind; ADateTime, ANullDate: TDateTime): Boolean; overload; virtual;
    procedure Change; override;
    function MsgSetDateTime(Value: TSystemTime): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    {$IFDEF COMPILER5}
    property Format: string read FFormat write SetFormat;
    {$ENDIF COMPILER5}
    // The initial date to display when the drop-down calendar is shown and NullDate = Date/Time
    property DropDownDate: TDate read FDropDownDate write FDropDownDate;
    // The Date/Time (depending on the Kind property) that represents an empty "null" value, default is 1899-12-31
    property NullDate: TDateTime read FNullDate write SetNullDate;
    // The text to display when NullDate = Date/Time
    property NullText: string read FNullText write SetNullText;
    property WeekNumbers: Boolean read FWeekNumbers write FWeekNumbers default False;
    property ShowToday: Boolean read FShowToday write FShowToday default True;
    property ShowTodayCircle: Boolean read FShowTodayCircle write FShowTodayCircle default True;
    property HintColor;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnParentColorChange;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$RCSfile: JvDateTimePicker.pas,v $';
    Revision: '$Revision: 1.37 $';
    Date: '$Date: 2006/01/08 13:38:30 $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  CommCtrl,
  JvVCL5Utils,
//  JvJCLUtils,
  JvResources;

procedure SetCalendarStyle(AHandle: THandle; Value: Integer; UseStyle: Boolean);
var
  Style: Integer;
begin
  if AHandle <> 0 then
  begin
    Style := GetWindowLong(AHandle, GWL_STYLE);
    if UseStyle then
      Style := Style or Value
    else
      Style := Style and not Value;
    SetWindowLong(AHandle, GWL_STYLE, Style);
  end;
end;

constructor TJvDateTimePicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//   FNullText := RsNoneCaption;  XXX Don't do this unless you also set the 'default' specifier in the property declaration above! Causes problems. -WP
  FDropDownDate := SysUtils.Date;
  FShowToday := True;
  FShowTodayCircle := True;
end;

function TJvDateTimePicker.WithinDelta(Val1, Val2: TDateTime): Boolean;
const
  cOneSecond = 1 / 86400;
begin
  Result := Abs(Frac(Val1) - Frac(Val2)) <= cOneSecond;
end;

function TJvDateTimePicker.CheckNullValue: Boolean;
begin
  Result := CheckNullValue(NullText, Format, Kind, DateTime, NullDate);
end;

function TJvDateTimePicker.CheckNullValue(const ANullText, AFormat: string;
  AKind: TDateTimeKind; ADateTime, ANullDate: TDateTime): Boolean;
begin
 // Warren added NullText length check so that this feature can be disabled if not used!
  if ANullText = '' then
    Result := False
  else
    Result := ((AKind = dtkDate) and (Trunc(ADateTime) = Trunc(ANullDate)) or
      ((AKind = dtkTime) and WithinDelta(ADateTime, ANullDate)));

  if Result then
    SendMessage(Handle, DTM_SETFORMAT, 0, Integer(PChar('''' + ANullText + '''')))
  else
    SendMessage(Handle, DTM_SETFORMAT, 0, Integer(PChar(AFormat)));
end;

procedure TJvDateTimePicker.SetNullDate(const Value: TDateTime);
begin
  FNullDate := Trunc(Value);
  CheckNullValue;
end;

procedure TJvDateTimePicker.SetNullText(const Value: string);
begin
  if FNullText <> Value then
  begin
    FNullText := Value;
//    FKeepNullText := Value;
    CheckNullValue;
  end;
end;

{$IFDEF COMPILER5}
procedure TJvDateTimePicker.SetFormat(const Value: string);
begin
  if FFormat <> Value then
  begin
    FFormat := Value;
    CheckNullValue;
  end;
end;
{$ENDIF COMPILER5}

function TJvDateTimePicker.MsgSetDateTime(Value: TSystemTime): Boolean;
begin
  Result := inherited MsgSetDateTime(Value);
  CheckNullValue(NullText, Format, Kind, SystemTimeToDateTime(Value), NullDate);
end;

procedure TJvDateTimePicker.Change;
begin
  inherited Change;
  CheckNullValue;
end;

function IsBlankSysTime(const St: TSystemTime): Boolean;
begin
  with St do
    Result := (wYear = 0) and (wMonth = 0) and
      (wDayOfWeek = 0) and (wDay = 0) and
      (wHour = 0) and (wMinute = 0) and
      (wSecond = 0) and (wMilliseconds = 0);
end;

procedure TJvDateTimePicker.UpdateCalendar(CalHandle: THandle);
var
  rect : TRect;
  width, colWidth : Integer;
begin
  if CalHandle <> 0 then
  begin
    // Mantis 3399: If we are showing week numbers then we need an additional
    // column in the calendar. Its width is one seventh of the original width
    // of the calendar before it was showing the week numbers.
    if WeekNumbers then
    begin
      GetWindowRect(CalHandle, rect);
      width := rect.Right - rect.Left;
      colWidth := width div 7;
      rect.Right := rect.Right + colWidth;
      SetWindowPos(CalHandle, 0, 0, 0, rect.Right-rect.Left, rect.Bottom-rect.Top, SWP_NOMOVE or SWP_NOZORDER);
    end;
    SetCalendarStyle(CalHandle,MCS_WEEKNUMBERS, WeekNumbers);
    SetCalendarStyle(CalHandle,MCS_NOTODAY, not ShowToday);
    SetCalendarStyle(CalHandle,MCS_NOTODAYCIRCLE, not ShowTodayCircle);
  end;
end;

procedure TJvDateTimePicker.CNNotify(var Msg: TWMNotify);
var
  ACal: THandle;
  St: TSystemTime;
  Dt: TDateTime;
  AllowChange: Boolean;
begin
  with Msg, NMHdr^ do
    case code of
      DTN_DROPDOWN:
        begin
          inherited;
          ACal := DateTime_GetMonthCal(Handle);
          UpdateCalendar(ACal);
          if CheckNullValue and (ACal <> 0) then
          begin
            DateTimeToSystemTime(FDropDownDate, St);
            if not IsBlankSysTime(St) then
              MonthCal_SetCurSel(ACal, St);
          end;
        end;
      DTN_USERSTRING:
        begin
          with PNMDateTimeString(NMHdr)^ do
          begin
            if not TryStrToDateTime(pszUserString, Dt) then
              Dt := NullDate;
            if Assigned(OnUserInput) then
            begin
              AllowChange := True;
              OnUserInput(Self, pszUserString, Dt, AllowChange);
              dwFlags := Ord(not AllowChange);
            end
            else
              dwFlags := Ord(False);
            DateTimeToSystemTime(Dt, St);
          end;
        end;
      NM_SETFOCUS:
        begin
          FKeepNullText := NullText;
          NullText := '';
          inherited;
        end;
      NM_KILLFOCUS:
        begin
          NullText := FKeepNullText;
          inherited;
        end;
    else
      inherited;
    end;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.

