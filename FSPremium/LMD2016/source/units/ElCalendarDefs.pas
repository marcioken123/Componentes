unit ElCalendarDefs;
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

ElCalendarDefs unit
-------------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses  Classes, SysUtils,
     Types,
     Controls,
     Graphics,
    {$IFDEF LMD_UNICODE}
     Windows,
     LMDUnicode,
    {$endif}
     LMDStrings,
     LMDTypes;

type

  TElCalendarCellType = (cctDayName, cctWeekNum, cctToday, cctOtherMonth, cctWeekEnd, cctInPeriod, cctHoliday, cctEmpty, cctSelected);
  TElCalendarCellTypes = set of TElCalendarCellType;

  TBeforeCellDrawEvent = procedure(Sender : TObject; Canvas : TCanvas; RowNum, ColNum : integer; Date : TDateTime; CellType : TElCalendarCellTypes) of object;

  TDayOfWeek = 0..6;

  TElWeekEndDay = (Sun, Mon, Tue, Wed, Thu, Fri, Sat);

  TElWeekEndDays = set of TElWeekEndDay;

  TElHolidayEvent = procedure(Sender : TObject; ADay, AMonth, AYear : word; var IsHoliday : boolean) of object;

  TElCustomCalendarNames = class(TPersistent)
  protected
    FLongMonthNames: TLMDStrings;
    FShortMonthNames: TLMDStrings;
    FLongDayNames: TLMDStrings;
    FShortDayNames: TLMDStrings;
    FOnChange: TNotifyEvent;
    procedure SetLongMonthNames(const Value: TLMDStrings);
    procedure SetLongDayNames(const Value: TLMDStrings);
    procedure SetShortDayNames(const Value: TLMDStrings);
    procedure SetShortMonthNames(const Value: TLMDStrings);
    procedure DoChange(Sender: TObject);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetShortDayNames(Index: integer): TLMDString;
    function GetShortMonthNames(Index: integer): TLMDString;
    function GetLongDayNames(Index: integer): TLMDString;
    function GetLongMonthNames(Index: integer): TLMDString;
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property LongMonthNames: TLMDStrings read FLongMonthNames write SetLongMonthNames;
    property ShortMonthNames: TLMDStrings read FShortMonthNames write SetShortMonthNames;
    property LongDayNames: TLMDStrings read FLongDayNames write SetLongDayNames;
    property ShortDayNames: TLMDStrings read FShortDayNames write SetShortDayNames;
  end;

  TElHoliday = class(TCollectionItem)
  private
    FDescription : AnsiString;
    FFixedDate : Boolean;
    FDay : Word;
    FDayOfWeek : Word;
    FMonth : Word;
    FIsRest : Boolean;
    procedure SetFixedDate(newValue : Boolean);
    procedure SetDay(newValue : Word);
    procedure SetDayOfWeek(newValue : Word);
    procedure SetMonth(newValue : Word);
    procedure SetIsRest(newValue : Boolean);
  public
    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source : TPersistent); override;
    procedure SaveToStream(Stream : TStream);
    procedure LoadFromStream(Stream : TStream);
  published
    property FixedDate : Boolean read FFixedDate write SetFixedDate default True;
    property Day : Word read FDay write SetDay;
    property DayOfWeek : Word read FDayOfWeek write SetDayOfWeek;
    property Month : Word read FMonth write SetMonth;
    property IsRest : Boolean read FIsRest write SetIsRest;
    property Description : AnsiString read FDescription write FDescription;
  end;

  TElHolidays = class(TCollection)
  private
    FOwner : TPersistent;
    function GetItems(Index : integer) : TElHoliday;
    procedure SetItems(Index : integer; newValue : TElHoliday);
  protected
    function GetOwner : TPersistent; override;
    procedure Update(Item : TCollectionItem); override;
  public
    constructor Create(AOwner : TComponent);
    function Add : TElHoliday;
    procedure SaveToStream(Stream : TStream);
    procedure LoadFromStream(Stream : TStream);
    property Items[Index : integer] : TElHoliday read GetItems write SetItems; default;
  end;

implementation
uses
  LMDProcs ;

procedure TElHoliday.Assign(Source : TPersistent);
begin
  if Source is TElHoliday then
  begin
    with Source as TElHoliday do
    begin
      Self.FFixedDate := FFixedDate;
      Self.FDay := FDay;
      Self.FDayOfWeek := FDayOfWeek;
      Self.FMonth := FMonth;
      Self.FIsRest := FIsRest;
      Self.FDescription := FDescription;
    end;
  end
  else
    inherited;
end;

constructor TElHoliday.Create;
begin
  inherited;
  FFixedDate := True;
  FDay := 1;
  FMonth := 1;
  Description := 'New Year Day';
  FIsRest := true;
end;

destructor TElHoliday.Destroy;
begin
  inherited;
end;

procedure TElHoliday.SetFixedDate(newValue : Boolean);
begin
  if (FFixedDate <> newValue) then
  begin
    FFixedDate := newValue;
    Self.Changed(False);
  end; {if}
end;

procedure TElHoliday.SetDay(newValue : Word);
begin
  if (FDay <> newValue) then
  begin
    if (newValue > 31) or (newValue < 1) then raise Exception.Create('Day should be between 1 and the number of days in the month');
    FDay := newValue;
    Changed(False);
  end; {if}
end;

procedure TElHoliday.SetDayOfWeek(newValue : Word);
begin
  if (FDayOfWeek <> newValue) then
  begin
    if (newValue > 6) then raise Exception.Create('Day of Week number should be between 0 and 6');
    FDayOfWeek := newValue;
    Changed(False);
  end; {if}
end;

procedure TElHoliday.SetMonth(newValue : Word);
begin
  if (FMonth <> newValue) then
  begin
    if (newValue > 12) or (newValue < 1) then raise Exception.Create('Month number should be between 1 and 12');
    FMonth := newValue;
    Changed(False);
  end; {if}
end;

procedure TElHoliday.SetIsRest(newValue : Boolean);
begin
  if (FIsRest <> newValue) then
  begin
    FIsRest := newValue;
    Changed(False);
  end; {if}
end;

procedure TElHoliday.SaveToStream(Stream : TStream);
begin
  Stream.WriteBuffer(FIsRest, SizeOf(FIsRest));
  Stream.WriteBuffer(FMonth, SizeOf(FMonth));
  Stream.WriteBuffer(FDayOfWeek, SizeOf(FDayOfWeek));
  Stream.WriteBuffer(FDay, SizeOf(FDay));
  Stream.WriteBuffer(FFixedDate, SizeOf(FFixedDate));
  LMDAnsiWriteStringToStream(Stream, FDescription);
end;

procedure TElHoliday.LoadFromStream(Stream : TStream);
begin
  Stream.ReadBuffer(FIsRest, SizeOf(FIsRest));
  Stream.ReadBuffer(FMonth, SizeOf(FMonth));
  Stream.ReadBuffer(FDayOfWeek, SizeOf(FDayOfWeek));
  Stream.ReadBuffer(FDay, SizeOf(FDay));
  Stream.ReadBuffer(FFixedDate, SizeOf(FFixedDate));
  LMDAnsiReadStringFromStream(Stream, FDescription);
end;

function TElHolidays.GetItems(Index : integer) : TElHoliday;
begin
  Result := TElHoliday(inherited GetItem(Index));
end;

procedure TElHolidays.SetItems(Index : integer; newValue : TElHoliday);
begin
  inherited SetItem(Index, newValue);
end;

function TElHolidays.GetOwner : TPersistent;
begin
  Result := FOwner;
end;

procedure TElHolidays.Update(Item : TCollectionItem);
begin
  if Assigned(FOwner) and (FOwner is TControl) and (not (csDestroying in TControl(FOwner).ComponentState)) then
    TControl(FOwner).Invalidate;
end;

function TElHolidays.Add : TElHoliday;
begin
  Result := TElHoliday(inherited Add);
end;

procedure TElHolidays.SaveToStream(Stream : TStream);
var
  i : integer;
begin
  i := Count;
  Stream.WriteBuffer(i, SizeOf(integer));
  for i := 0 to Count - 1 do // Iterate
  begin
    Items[i].SaveToStream(Stream);
  end; // for
end;

procedure TElHolidays.LoadFromStream(Stream : TStream);
var
  i, j : integer;
  AHoliday : TElHoliday;
begin
  Clear;
  Stream.ReadBuffer(i, SizeOf(integer));
  for j := 0 to i - 1 do // Iterate
  begin
    AHoliday := Add;
    AHoliday.LoadFromStream(Stream);
  end; // for
end;

constructor TElHolidays.Create(AOwner : TComponent);
begin
  FOwner := AOwner;
  inherited Create(TElHoliday);
end;

{ TElCustomNames }
procedure TElCustomCalendarNames.Assign(Source: TPersistent);
begin
  if (Source is TElCustomCalendarNames) then
  begin
    FLongMonthNames.Assign((Source as TElCustomCalendarNames).FLongMonthNames);
    FShortMonthNames.Assign((Source as TElCustomCalendarNames).FShortMonthNames);
    FLongDayNames.Assign((Source as TElCustomCalendarNames).FLongDayNames);
    FShortDayNames.Assign((Source as TElCustomCalendarNames).FShortDayNames);
  end
  else
    inherited Assign(Source);
end;

constructor TElCustomCalendarNames.Create;
begin
  inherited;
  FShortMonthNames := TLMDMemoryStrings.Create;
  TLMDMemoryStrings(FShortMonthNames).OnChange := DoChange;
  FLongMonthNames := TLMDMemoryStrings.Create;
  TLMDMemoryStrings(FLongMonthNames).OnChange := DoChange;
  FShortDayNames := TLMDMemoryStrings.Create;
  TLMDMemoryStrings(FShortDayNames).OnChange := DoChange;
  FLongDayNames := TLMDMemoryStrings.Create;
  TLMDMemoryStrings(FLongDayNames).OnChange := DoChange;
end;

destructor TElCustomCalendarNames.Destroy;
begin
  FreeAndnil(FShortMonthNames);
  FreeAndnil(FLongMonthNames);
  FreeAndnil(FShortDayNames);
  FreeAndnil(FLongDayNames);
  inherited;
end;

procedure TElCustomCalendarNames.DoChange(Sender: TObject);
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

function TElCustomCalendarNames.GetLongDayNames(Index: integer): TLMDString;
begin
  if (LMDInRange(Index - 1, 0, FLongDayNames.Count - 1)) then
    Result := FLongDayNames[Index - 1]
  else
    Result := {$IFDEF LMDCOMP17}FormatSettings.{$ELSE}SysUtils.{$ENDIF}LongDayNames[Index];
end;

function TElCustomCalendarNames.GetLongMonthNames(Index: integer): TLMDString;
var
{$IFDEF LMD_UNICODE}
  L: Integer;
  Buffer: array[0..255] of WideChar;
  lstr: WideString;
{$else}
  lstr: String;
{$endif}
begin
  if (LMDInRange(Index - 1, 0, FLongMonthNames.Count - 1)) then
    Result := FLongMonthNames[Index - 1]
  else
  begin
  {$IFDEF LMD_UNICODE}
      L := GetLocaleInfoW(LOCALE_USER_DEFAULT, LOCALE_SMONTHNAME1 + Index - 1, Buffer, SizeOf(Buffer));
      if L > 0 then
        LMDWideSetString(lstr, Buffer, L - 1)
      else
      {$endif}
        lstr := {$IFDEF LMDCOMP17}FormatSettings.{$ELSE}SysUtils.{$ENDIF}LongMonthNames[Index];
    Result := lstr;
  end;
end;

function TElCustomCalendarNames.GetShortDayNames(Index: integer): TLMDString;
begin
  if (LMDInRange(Index - 1, 0, FShortDayNames.Count - 1)) then
    Result := FShortDayNames[Index - 1]
  else
    Result := {$IFDEF LMDCOMP17}FormatSettings.{$ELSE}SysUtils.{$ENDIF}ShortDayNames[Index];
end;

function TElCustomCalendarNames.GetShortMonthNames(Index: integer): TLMDString;
begin
  if (LMDInRange(Index - 1, 0, FShortMonthNames.Count - 1)) then
    Result := FShortMonthNames[Index - 1]
  else
    Result := {$IFDEF LMDCOMP17}FormatSettings.{$ELSE}SysUtils.{$ENDIF}ShortMonthNames[Index];
end;

procedure TElCustomCalendarNames.SetLongDayNames(const Value: TLMDStrings);
begin
  FLongDayNames.Assign(Value);
end;

procedure TElCustomCalendarNames.SetLongMonthNames(const Value: TLMDStrings);
begin
  FLongMonthNames.Assign(Value);
end;

procedure TElCustomCalendarNames.SetShortDayNames(const Value: TLMDStrings);
begin
  FShortDayNames.Assign(Value);
end;

procedure TElCustomCalendarNames.SetShortMonthNames(const Value: TLMDStrings);
begin
  FShortMonthNames.Assign(Value);
end;

end.
