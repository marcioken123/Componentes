unit LMDSysLocaleObject;
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

LMDSysLocaleObject unit (JH, AH)
--------------------------------
Contains info about a system locale

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, SysConst, 
  LMDSysObject, LMDSysBase, LMDSysConst;

const
  LMDSysLocaleDayNames:array[0..6] of string=(SLongDayNameMon, SLongDayNameTue, SLongDayNameWed,
                                              SLongDayNameThu, SLongDayNameFri, SLongDayNameSat,
                                              SLongDayNameSun);

type
  TLMDSysLocaleNumberInfo=(lpidLanguage, lpidLanguageEnglish, lpidLanguageSymbol, lpidCountryCode,
                           lpidCountry, lpidCountrySymbol,
                           lpidDecimalSeparator, lpidDigits, lpidThousandSeparator, lpidGrouping,  lpidNegativeSign,
                           lpidNegativeFormat, lpidPositiveSign, lpidShowLeadingZero,
                           lpidListSeparator, lpidMeasurement
                           );
  TLMDSysLocaleNumberInfos=set of TLMDSysLocaleNumberInfo;

const
  LMDSysLocaleNumberProps:array[TLMDSysLocaleNumberInfo] of TLMDSysProperty =(
    (Name: sLMDSysLocalePropTitleLanguage; Description: sLMDSysLocalePropDescLanguage),
    (Name: sLMDSysLocalePropTitleLanguageEnglish; Description: sLMDSysLocalePropDescLanguageEnglish),
    (Name: sLMDSysLocalePropTitleLanguageSymbol; Description: sLMDSysLocalePropDescLanguageSymbol),
    (Name: sLMDSysLocalePropTitleCountryCode; Description: sLMDSysLocalePropDescCountryCode),
    (Name: sLMDSysLocalePropTitleCountry; Description: sLMDSysLocalePropDescCountry),
    (Name: sLMDSysLocalePropTitleCountrySymbol; Description: sLMDSysLocalePropDescCountrySymbol),
    (Name: sLMDSysLocalePropTitleDecimalSeparator; Description: sLMDSysLocalePropDescDecimalSeparator),
    (Name: sLMDSysLocalePropTitleDigits; Description: sLMDSysLocalePropDescDigits),
    (Name: sLMDSysLocalePropTitleThousandSeparator; Description: sLMDSysLocalePropDescThousandSeparator),
    (Name: sLMDSysLocalePropTitleGrouping; Description: sLMDSysLocalePropDescGrouping),
    (Name: sLMDSysLocalePropTitleNegativeSign; Description: sLMDSysLocalePropDescNegativeSign),
    (Name: sLMDSysLocalePropTitleNegativeFormat; Description: sLMDSysLocalePropDescNegativeFormat),
    (Name: sLMDSysLocalePropTitlePositiveSign; Description: sLMDSysLocalePropDescPositiveSign),
    (Name: sLMDSysLocalePropTitleShowLeadingZero; Description: sLMDSysLocalePropDescShowLeadingZero),
    (Name: sLMDSysLocalePropTitleListSeparator; Description: sLMDSysLocalePropDescListSeparator),
    (Name: sLMDSysLocalePropTitleMeasurement; Description: sLMDSysLocalePropDescMeasurement)
    );

  def_TLMDSysLocaleNumberInfos=[lpidLanguage, lpidLanguageEnglish, lpidLanguageSymbol, lpidCountryCode,
                                  lpidCountry, lpidCountrySymbol,
                                  lpidDecimalSeparator, lpidDigits, lpidGrouping,  lpidNegativeSign,
                                  lpidNegativeFormat, lpidPositiveSign, lpidShowLeadingZero,
                                  lpidListSeparator, lpidMeasurement, lpidThousandSeparator];

type
  TLMDSysLocaleDateTimeInfo=(lpidCalendarType, lpidYearDigits, lpidFirstDayOfWeek, lpidFirstWeekOfYear,
                             lpidDateSeparator, lpidLongDateFormat, lpidLongDateOrder,
                             lpidShortDateFormat, lpidShortDateOrder, lpidClockMode,
                             lpidTimeSeparator, lpidTimeFormat, lpidMorningSymbol, lpidAfternoonSymbol
                             );
  TLMDSysLocaleDateTimeInfos=set of TLMDSysLocaleDateTimeInfo;

const
  LMDSysLocaleDateTimeProps:array[TLMDSysLocaleDateTimeInfo] of TLMDSysProperty =(
    (Name: sLMDSysLocalePropTitleCalendarType; Description: sLMDSysLocalePropDescCalendarType),
    (Name: sLMDSysLocalePropTitleYearDigits; Description: sLMDSysLocalePropDescYearDigits),
    (Name: sLMDSysLocalePropTitleFirstDayOfWeek; Description: sLMDSysLocalePropDescFirstDayOfWeek),
    (Name: sLMDSysLocalePropTitleFirstWeekOfYear; Description: sLMDSysLocalePropDescFirstWeekOfYear),
    (Name: sLMDSysLocalePropTitleDateSeparator; Description: sLMDSysLocalePropDescDateSeparator),
    (Name: sLMDSysLocalePropTitleLongDateFormat; Description: sLMDSysLocalePropDescLongDateFormat),
    (Name: sLMDSysLocalePropTitleLongDateOrder; Description: sLMDSysLocalePropDescLongDateOrder),
    (Name: sLMDSysLocalePropTitleShortDateFormat; Description: sLMDSysLocalePropDescShortDateFormat),
    (Name: sLMDSysLocalePropTitleShortDateOrder; Description: sLMDSysLocalePropDescShortDateOrder),
    (Name: sLMDSysLocalePropTitleClockMode; Description: sLMDSysLocalePropDescClockMode),
    (Name: sLMDSysLocalePropTitleTimeSeparator; Description: sLMDSysLocalePropDescTimeSeparator),
    (Name: sLMDSysLocalePropTitleTimeFormat; Description: sLMDSysLocalePropDescTimeFormat),
    (Name: sLMDSysLocalePropTitleMorningSymbol; Description: sLMDSysLocalePropDescMorningSymbol),
    (Name: sLMDSysLocalePropTitleAfternoonSymbol; Description: sLMDSysLocalePropDescAfternoonSymbol)
    );

  def_TLMDSysLocaleDateTimeInfos=[lpidCalendarType, lpidYearDigits, lpidFirstDayOfWeek, lpidFirstWeekOfYear,
                             lpidDateSeparator, lpidLongDateFormat, lpidShortDateFormat,
                             lpidShortDateOrder, lpidLongDateOrder, lpidClockMode,
                             lpidTimeSeparator, lpidTimeFormat, lpidMorningSymbol, lpidAfternoonSymbol];

type
  TLMDSysLocaleCurrencyInfo=(lpidCurrencySymbol, lpidInternationalCurrencySymbol, lpidPositiveCurrencyFormat,
                             lpidNegativeCurrencyFormat, lpidCurrencyDecimalSeparator, lpidCurrencyDigits,
                             lpidCurrencyGroupingSign, lpidCurrencyGrouping);
  TLMDSysLocaleCurrencyInfos=set of TLMDSysLocaleCurrencyInfo;

const
  LMDSysLocaleCurrencyProps:array[TLMDSysLocaleCurrencyInfo] of TLMDSysProperty =(
    (Name: sLMDSysLocalePropTitleCurrencySymbol; Description: sLMDSysLocalePropDescCurrencySymbol),
    (Name: sLMDSysLocalePropTitleInternationalCurrencySymbol; Description: sLMDSysLocalePropDescInternationalCurrencySymbol),
    (Name: sLMDSysLocalePropTitlePositiveCurrencyFormat; Description: sLMDSysLocalePropDescPositiveCurrencyFormat),
    (Name: sLMDSysLocalePropTitleNegativeCurrencyFormat; Description: sLMDSysLocalePropDescNegativeCurrencyFormat),
    (Name: sLMDSysLocalePropTitleCurrencyDecimalSeparator; Description: sLMDSysLocalePropDescCurrencyDecimalSeparator),
    (Name: sLMDSysLocalePropTitleCurrencyDigits; Description: sLMDSysLocalePropDescCurrencyDigits),
    (Name: sLMDSysLocalePropTitleCurrencyGroupingSign; Description: sLMDSysLocalePropDescCalendarType),
    (Name: sLMDSysLocalePropTitleCurrencyGrouping; Description: sLMDSysLocalePropDescCurrencyGrouping)
    );

  def_TLMDSysLocaleCurrencyInfos=[lpidCurrencySymbol, lpidInternationalCurrencySymbol, lpidPositiveCurrencyFormat,
                             lpidNegativeCurrencyFormat, lpidCurrencyDecimalSeparator, lpidCurrencyDigits,
                             lpidCurrencyGroupingSign, lpidCurrencyGrouping];

type
  { ************************************************************************** }
  TLMDSysLocaleObject = class(TLMDSysObject)
  private
    FCalendarType,
    FCurrencyDigits,
    FPositiveCurrencyFormat,
    FDigits,
    FFirstDayOfWeek,
    FFirstWeekOfYear,
    FMeasurement,
    FNegativeCurrFormat,
    FShowLeadingZero,
    FNegativeFormat,
    FClockMode,
    FMorningSymbol,
    FAfternoonSymbol,
    FCurrencySymbol,
    FDateSeparator,
    FDecimalSeparator,
    FGrouping,
    FListSeparator,
    FLongDateFormat,
    FCurrencyDecimalSeparator,
    FCurrencyGrouping,
    FCurrencyGroupingSign,
    FNegativeSign,
    FPositiveSign,
    FTimeFormat,
    FThousandSeparator,
    FTimeSeparator,
    FShortDateOrder,
    FLongDateOrder,
    FYearDigits,
    FIntCurSymbol,
    FLanguage,
    FLanguageEnglish,
    FLanguageSymbol,
    FCountryCode,
    FCountry,
    FCountrySymbol,
    FShortDateFormat: string;
    FCurrencyInfo: TLMDSysLocaleCurrencyInfos;
    FDateTimeInfo: TLMDSysLocaleDateTimeInfos;
    FNumberInfo: TLMDSysLocaleNumberInfos;

    procedure SetString(aIndex: LongInt; aValue: string);
    procedure repIt(rep, w: string; var s: string);
    procedure InitArrays(var pos_cur: array of string;
                         var neg_cur: array of string;
                         var neg_num: array of string;
                         var lz: array of string;
                         var cm: array of string);
    procedure SetDisplayInfoC(const Value: TLMDSysLocaleCurrencyInfos);
    procedure SetDisplayInfoD(const Value: TLMDSysLocaleDateTimeInfos);
    procedure SetDisplayInfoN(const Value: TLMDSysLocaleNumberInfos);
   protected
     procedure DoFilterProperty(const Name:String; var Cancel:Boolean);override;
     procedure RegisterProperties; override;
  public
    constructor Create;override;
    //    procedure GetValues(aText: TStrings); override;
    procedure Refresh; override;
    procedure Apply; override;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  published
    property CalendarType: string index 0 read FCalendarType write SetString stored false;
    property CurrencyDigits: string index 1 read FCurrencyDigits write SetString stored false;
    property PositiveCurrencyFormat: string index 2 read FPositiveCurrencyFormat write SetString stored false;
    property Digits: string index 3 read FDigits write SetString stored false;
    property FirstDayOfWeek: string index 4 read FFirstDayOfWeek write SetString stored false;
    property FirstWeekOfYear: string index 5 read FFirstWeekOfYear write SetString stored false;
    property ShowLeadingZero: string index 6 read FShowLeadingZero write SetString stored false;
    property Measurement: string index 7 read FMeasurement write SetString stored false;
    property NegativeCurrencyFormat: string index 8 read FNegativeCurrFormat write SetString stored false;
    property NegativeFormat: string index 9 read FNegativeFormat write SetString stored false;
    property ClockMode: string index 10 read FClockMode write SetString stored false;
    property MorningSymbol: string index 11 read FMorningSymbol write SetString stored false;
    property AfternoonSymbol: string index 12 read FAfternoonSymbol write SetString stored false;
    property CurrencySymbol: string index 13 read FCurrencySymbol write SetString stored false;
    property DateSeparator: string index 14 read FDateSeparator write SetString stored false;
    property DecimalSeparator: string index 15 read FDecimalSeparator write SetString stored false;
    property Grouping: string index 16 read FGrouping write SetString stored false;
    property ListSeparator: string index 17 read FListSeparator write SetString stored false;
    property LongDateFormat: string index 18 read FLongDateFormat write SetString stored false;
    property CurrencyDecimalSeparator: string index 19 read FCurrencyDecimalSeparator write SetString stored false;
    property CurrencyGrouping: string index 20 read FCurrencyGrouping write SetString stored false;
    property CurrencyGroupingSign: string index 21 read FCurrencyGroupingSign write SetString stored false;
    property NegativeSign: string index 22 read FNegativeSign write SetString stored false;
    property PositiveSign: string index 23 read FPositiveSign write SetString stored false;
    property ShortDateFormat: string index 24 read FShortDateFormat write SetString stored false;
    property ThousandSeparator: string index 25 read FThousandSeparator write SetString stored false;
    property TimeSeparator: string index 26 read FTimeSeparator write SetString stored false;
    property TimeFormat: string index 27 read FTimeFormat write SetString stored false;
    property ShortDateOrder: string index 28 read FShortDateOrder write SetString stored false;
    property LongDateOrder: string index 29 read FLongDateOrder write SetString stored false;
    property YearDigits: string index 30 read FYearDigits write SetString stored false;
    property InternationalCurrencySymbol: string index 31 read FIntCurSymbol write SetString stored false;
    property Language: string index 32 read FLanguage write SetString stored false;
    property LanguageEnglish: string index 33 read FLanguageEnglish write SetString stored false;
    property LanguageSymbol: string index 34 read FLanguageSymbol write SetString stored false;
    property CountryCode: string index 35 read FCountryCode write SetString stored false;
    property Country: string index 36 read FCountry write SetString stored false;
    property CountrySymbol: string index 37 read FCountrySymbol write SetString stored false;

    // Allows programmer to select which information is shown
    property DisplayCurrencyInfo:TLMDSysLocaleCurrencyInfos read FCurrencyInfo write SetDisplayInfoC default def_TLMDSysLocaleCurrencyInfos;
    property DisplayNumberInfo:TLMDSysLocaleNumberInfos read FNumberInfo write SetDisplayInfoN default def_TLMDSysLocaleNumberInfos;
    property DisplayDateTimeInfo:TLMDSysLocaleDateTimeInfos read FDateTimeInfo write SetDisplayInfoD default def_TLMDSysLocaleDateTimeInfos;
  end;

implementation

uses
  SysUtils,
  LMDSysLogStrings;

{ **************************************************************************** }
{ --------------------------------- private ---------------------------------- }
procedure TLMDSysLocaleObject.SetString(aIndex: LongInt; aValue: string);

  procedure InternalSet(aProp: string; var oldValue: string);
  begin
    if oldValue <> aValue then
      begin
        RememberChange(aProp, oldValue, aValue);
        oldValue:= aValue;
      end;
  end;

begin
  case aIndex of
    0: InternalSet(strCalendarType, FCalendarType);
    1: InternalSet(strCurrencyDigits, FCurrencyDigits);
    2: InternalSet(strPositiveCurrencyFormat, FPositiveCurrencyFormat);
    3: InternalSet(strDigits, FDigits);
    4: InternalSet(strFirstDayOfWeek, FFirstDayOfWeek);
    5: InternalSet(strFirstWeekOfYear, FFirstWeekOfYear);
    6: InternalSet(strShowLeadingZero, FShowLeadingZero);
    7: InternalSet(strMeasurement, FMeasurement);
    8: InternalSet(strNegativeCurrencyFormat, FNegativeCurrFormat);
    9: InternalSet(strNegativeFormat, FNegativeFormat);
    10: InternalSet(strClockMode, FClockMode);
    11: InternalSet(strMorningSymbol, FMorningSymbol);
    12: InternalSet(strAfternoonSymbol, FAfternoonSymbol);
    13: InternalSet(strCurrencySymbol, FCurrencySymbol);
    14: InternalSet(strDateSeparator, FDateSeparator);
    15: InternalSet(strDecimalSeparator, FDecimalSeparator);
    16: InternalSet(strGrouping, FGrouping);
    17: InternalSet(strListSeparator, FListSeparator);
    18: InternalSet(strLongDateFormat, FLongDateFormat);
    19: InternalSet(strCurrencyDecimalSeparator, FCurrencyDecimalSeparator);
    20: InternalSet(strCurrencyGrouping, FCurrencyGrouping);
    21: InternalSet(strCurrencyGroupingSign, FCurrencyGroupingSign);
    22: InternalSet(strNegativeSign, FNegativeSign);
    23: InternalSet(strPositiveSign, FPositiveSign);
    24: InternalSet(strShortDateFormat, FShortDateFormat);
    25: InternalSet(strThousandSeparator, FThousandSeparator);
    26: InternalSet(strTimeSeparator, FTimeSeparator);
    27: InternalSet(strTimeFormat, FTimeFormat);
    28: InternalSet(strShortDateOrder, FShortDateOrder);
    29: InternalSet(strLongDateOrder, FLongDateOrder);
    30: InternalSet(strYearDigits, FYearDigits);
    31: InternalSet(strInternationalCurrencySymbol, FIntCurSymbol);
    32: InternalSet(strLanguage, FLanguage);
    33: InternalSet(strLanguageEnglish, FLanguageEnglish);
    34: InternalSet(strLanguageSymbol, FLanguageSymbol);
    35: InternalSet(strCountryCode, FCountryCode);
    36: InternalSet(strCountry, FCountry);
    37: InternalSet(strCountrySymbol, FCountrySymbol);
  end;
end;

{ ---------------------------------------------------------------------------- }
//procedure TLMDSysLocaleObject.GetValues(aText: TStrings);
//begin
//end;

{ ---------------------------------------------------------------------------- }

procedure TLMDSysLocaleObject.repIt(rep, w: string; var s: string);
var
  j: Integer;
begin
  j:= Pos(rep, s);
  if j <> 0 then
    begin
      Delete(s, j, Length(rep));
      Insert(w, s, j);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysLocaleObject.InitArrays(var pos_cur: array of string;
                                         var neg_cur: array of string;
                                         var neg_num: array of string;
                                         var lz: array of string;
                                         var cm: array of string);

  procedure FillArray(var ar: array of String; values: String);
  var
    i: Integer;
  begin
    i := Low(ar);
    while (Pos(';', values) <> 0) and (i <= High(ar)) do
      begin
        ar[i] := Copy (values, 1, Pos (';',values)-1);
        inc(i);
        Delete (values, 1, Pos (';',values));
      end;
    //the last one ...
    if (values <> '') and (i = High(ar)) then
      ar[i] := values;
  end;

begin
  FillArray (pos_cur, '¤1,1' + ';1,1¤' + ';¤ 1,1' + ';1,1 ¤');
  FillArray (neg_cur, '(¤1,1)' + ';-¤1,1' + ';¤-1,1' + ';¤1,1-' + ';(1,1¤)' +
                      ';-1,1¤'  + ';1,1-¤'  + ';1,1¤-' + ';-1,1 ¤'+ ';-¤ 1,1' +
                      ';1,1 ¤-' + ';¤ 1,1-' + ';¤ -1,1'+ ';1,1- ¤'+ ';( ¤1,1)'+
                      ';(1,1 ¤)');
  FillArray (neg_num, '(1,1)' + ';-1,1' + ';- 1,1' + ';1,1-' + ';1,1 -');
  FillArray (lz, ',7' + ';0,7');
  FillArray (cm, '12' + ';24');
end;

{------------------------------------------------------------------------------}
procedure TLMDSysLocaleObject.SetDisplayInfoC(const Value: TLMDSysLocaleCurrencyInfos);
begin
  if FCurrencyInfo<>Value then
    begin
      FCurrencyInfo:=Value;
      RegisterProperties;
    end;

end;
{------------------------------------------------------------------------------}
procedure TLMDSysLocaleObject.SetDisplayInfoD(const Value: TLMDSysLocaleDateTimeInfos);
begin
  if FDateTimeInfo<>Value then
    begin
      FDateTimeInfo := Value;
      RegisterProperties;
    end;

end;

{------------------------------------------------------------------------------}
procedure TLMDSysLocaleObject.SetDisplayInfoN(const Value: TLMDSysLocaleNumberInfos);
begin
  if FNumberInfo<>Value then
    begin
      FNumberInfo := Value;
      RegisterProperties;
    end;
end;

{ --------------------------------- protected -------------------------------- }
procedure TLMDSysLocaleObject.DoFilterProperty(const Name: String; var Cancel: Boolean);
begin
  Cancel:=(Name='DisplayCurrencyInfo') or (Name='DisplayNumberInfo') or (Name='DisplayDateTimeInfo');
end;

{------------------------------------------------------------------------------}
procedure TLMDSysLocaleObject.RegisterProperties;
var
  i:TLMDSysLocaleNumberInfo;
  j:TLMDSysLocaleCurrencyInfo;
  k:TLMDSysLocaleDateTimeInfo;
  tmp:Integer;
begin
  FPropertiesDesc.Clear;
  tmp:=0;
  for i:=Low(TLMDSysLocaleNumberInfo) to High(TLMDSysLocaleNumberInfo) do
    if i in FNumberInfo then
      begin
        FPropertiesDesc.Add(tmp, LMDSysLocaleNumberProps[i].Name, LMDSysLocaleNumberProps[i].Description);
        Inc(tmp);
      end;
  for j:=Low(TLMDSysLocaleCurrencyInfo) to High(TLMDSysLocaleCurrencyInfo) do
    if j in FCurrencyInfo then
      begin
        FPropertiesDesc.Add(tmp, LMDSysLocaleCurrencyProps[j].Name, LMDSysLocaleCurrencyProps[j].Description);
        Inc(tmp);
      end;
  for k:=Low(TLMDSysLocaleDateTimeInfo) to High(TLMDSysLocaleDateTimeInfo) do
    if k in FDateTimeInfo then
      begin
        FPropertiesDesc.Add(tmp, LMDSysLocaleDateTimeProps[k].Name, LMDSysLocaleDateTimeProps[k].Description);
        Inc(tmp);
      end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysLocaleObject.GetElementTitle : string;
begin
  result := sLMDSysLocaleObjectsTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysLocaleObject.GetElementDescription : string;
begin
  result := sLMDSysLocaleObjectsDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysLocaleObject.GetElementType : TLMDSysInfoType;
begin
  result := itLocale;
end;

{ --------------------------------- public ----------------------------------- }
constructor TLMDSysLocaleObject.Create;
begin
  FNumberInfo:=def_TLMDSysLocaleNumberInfos;
  FDateTimeInfo:=def_TLMDSysLocaleDateTimeInfos;
  FCurrencyInfo:=def_TLMDSysLocaleCurrencyInfos;
  inherited;  //call inherited after that
end;

{------------------------------------------------------------------------------}
procedure TLMDSysLocaleObject.Refresh;
var
  j:TLMDSysLocaleCurrencyInfo;
  k:TLMDSysLocaleDateTimeInfo;
  l:TLMDSysLocaleNumberInfo;
  DefaultLCID: LCID;
  i: Integer;
  pos_cur: array[0..3] of string;
  neg_cur: array[0..15] of string;
  neg_num: array[0..4] of string;
  lz: array[0..1] of string;
  cm: array[0..1] of string;
  tmp:Integer;

  function getStr(locale: Integer): string;
  begin
    Result := GetLocaleStr(DefaultLCID, locale, 'Hallo');
  end;

begin
  DoProgress(sLMDSysLocaleObjectsTitle, 100, 0);
  FPropertiesDesc.InvalidateProperties;
  InitArrays (pos_cur, neg_cur, neg_num, lz, cm);

  DefaultLCID:= GetThreadLocale;

  FNegativeSign:= getStr(LOCALE_SNEGATIVESIGN);
  FDecimalSeparator:= getStr(LOCALE_SDECIMAL);
  FCurrencyDecimalSeparator:= getStr(LOCALE_SMONDECIMALSEP);
  for i:= 0 to 3 do
    repIt(',', FCurrencyDecimalSeparator, pos_cur[i]);
DoProgress(sLMDSysLocaleObjectsTitle, 100, 20);

  for i:= 0 to 15 do
    begin
      repIt(',', FCurrencyDecimalSeparator, neg_cur[i]);
      repIt('-', FNegativeSign, neg_cur[i]);
    end;
DoProgress(sLMDSysLocaleObjectsTitle, 100, 40);

  for i:= 0 to 4 do
    begin
      repIt(',', FDecimalSeparator, neg_num[i]);
      repIt('-', FNegativeSign, neg_num[i]);
    end;
DoProgress(sLMDSysLocaleObjectsTitle, 100, 60);

  for i:= 0 to 1 do
    repIt(',', FDecimalSeparator, lz[i]);

  FCalendarType:= getStr(LOCALE_ICALENDARTYPE);
  FCurrencyDigits:= getStr(LOCALE_ICURRDIGITS);
  FPositiveCurrencyFormat:= pos_cur[StrToInt(getStr(LOCALE_ICURRENCY))];
  FDigits:= getStr(LOCALE_IDIGITS);
  FFirstDayOfWeek:= getStr(LOCALE_IFIRSTDAYOFWEEK);
  FFirstWeekOfYear:= getStr(LOCALE_IFIRSTWEEKOFYEAR);
  FShowLeadingZero:= lz[StrToInt(getStr(LOCALE_ILZERO))];
  FMeasurement:= getStr(LOCALE_IMEASURE);
  FNegativeCurrFormat:= neg_cur[StrToInt(getStr(LOCALE_INEGCURR))];
  FNegativeFormat:= neg_num[StrToInt(getStr(LOCALE_INEGNUMBER))];
  FClockMode:= cm[StrToInt(getStr(LOCALE_ITIME))];
  FMorningSymbol:= getStr(LOCALE_S1159);
  FAfternoonSymbol:= getStr(LOCALE_S2359);
  FCurrencySymbol:= getStr(LOCALE_SCURRENCY);
  FDateSeparator:= getStr(LOCALE_SDATE);
  FGrouping:= getStr(LOCALE_SGROUPING);
  FListSeparator:= getStr(LOCALE_SLIST);
  FLongDateFormat:= getStr(LOCALE_SLONGDATE);
  FCurrencyGrouping:= getStr(LOCALE_SMONGROUPING);
  FCurrencyGroupingSign:= getStr(LOCALE_SMONTHOUSANDSEP);
  FPositiveSign:= getStr(LOCALE_SPOSITIVESIGN);
  FShortDateFormat:= getStr(LOCALE_SSHORTDATE);
  FThousandSeparator:= getStr(LOCALE_STHOUSAND);
  FTimeSeparator:= getStr(LOCALE_STIME);
  FTimeFormat:= getStr(LOCALE_STIMEFORMAT);
  FShortDateOrder:= getStr(LOCALE_IDATE);
  case FShortDateOrder[1] of
    '0': FShortDateOrder:= 'MDY';
    '1': FShortDateOrder:= 'DMY';
    '2': FShortDateOrder:= 'YMD';
  end;
  FLongDateOrder:= getStr(LOCALE_ILDATE);
  case FLongDateOrder[1] of
    '0': FLongDateOrder:= 'MDY';
    '1': FLongDateOrder:= 'DMY';
    '2': FLongDateOrder:= 'YMD';
  end;
  FYearDigits:= getStr(LOCALE_ICENTURY);
  FIntCurSymbol:= getStr(LOCALE_SINTLSYMBOL);

  FLanguage:= getStr(LOCALE_SLANGUAGE);
  FLanguageEnglish:= getStr(LOCALE_SENGLANGUAGE);
  FLanguageSymbol:= getStr(LOCALE_SABBREVLANGNAME);
  FCountryCode:= getStr(LOCALE_ICOUNTRY);
  FCountry:= getStr(LOCALE_SCOUNTRY);
  FCountrySymbol:= getStr(LOCALE_SABBREVCTRYNAME);

  tmp:=0;
  for l:=Low(TLMDSysLocaleNumberInfo) to High(TLMDSysLocaleNumberInfo) do
    if l in FNumberInfo then
      begin
        with FPropertiesDesc.PropertyByID(tmp) do
          case l of
            lpidLanguage: Text:= FLanguage;
            lpidLanguageEnglish: Text:=FLanguageEnglish;
            lpidLanguageSymbol: Text:= FLanguageSymbol;
            lpidCountryCode: Text:=FCountryCode;
            lpidCountry: Text:=  FCountry;
            lpidCountrySymbol: Text:=  FCountrySymbol;
            lpidDecimalSeparator: Text:=  FDecimalSeparator;
            lpidDigits: Text:= FDigits;
            lpidGrouping: Text:=   FGrouping;
            lpidNegativeSign: Text:=  FNegativeSign;
            lpidNegativeFormat: Text:= FNegativeFormat;
            lpidPositiveSign: Text:= FPositiveSign;
            lpidShowLeadingZero: Text:= FShowLeadingZero;
            lpidListSeparator: Text:= FListSeparator;
            lpidMeasurement: Text:= FMeasurement;
            lpidThousandSeparator: Text:=FThousandSeparator;
          end;
          Inc(tmp);
        end;

  for j:=Low(TLMDSysLocaleCurrencyInfo) to High(TLMDSysLocaleCurrencyInfo) do
    if j in FCurrencyInfo then
      begin
        with FPropertiesDesc.PropertyByID(tmp) do
          case j of
            lpidCurrencySymbol: Text:=   FCurrencySymbol;
            lpidInternationalCurrencySymbol: Text:=FIntCurSymbol;
            lpidPositiveCurrencyFormat: Text:=  FPositiveCurrencyFormat;
            lpidNegativeCurrencyFormat: Text:= FNegativeCurrFormat;
            lpidCurrencyDecimalSeparator: Text:= FCurrencyDecimalSeparator;
            lpidCurrencyDigits: Text:= FCurrencyDigits;
            lpidCurrencyGroupingSign: Text:= FCurrencyGroupingSign;
            lpidCurrencyGrouping: Text:=  FCurrencyGrouping;
          end;
        Inc(tmp);
      end;

  for k:=Low(TLMDSysLocaleDateTimeInfo) to High(TLMDSysLocaleDateTimeInfo) do
    if k in FDateTimeInfo then
      begin
        with FPropertiesDesc.PropertyByID(tmp) do
          case k of
            lpidCalendarType: Text:=FCalendarType;
            lpidYearDigits: Text:= FYearDigits;
            lpidFirstDayOfWeek: Text:=LMDSysLocaleDayNames[StrToIntDef(FFirstDayOfWeek,0)];
            lpidFirstWeekOfYear: Text:=  FFirstWeekOfYear;
            lpidDateSeparator: Text:= FDateSeparator;
            lpidLongDateFormat: Text:= FLongDateFormat;
            lpidLongDateOrder: Text:=  FLongDateOrder;
            lpidShortDateFormat: Text:= FShortDateFormat;
            lpidShortDateOrder: Text:=  FShortDateOrder;
            lpidClockMode: Text:=  FClockMode;
            lpidTimeSeparator: Text:=  FTimeSeparator;
            lpidTimeFormat: Text:=  FTimeFormat;
            lpidMorningSymbol: Text:= FMorningSymbol;
            lpidAfternoonSymbol: Text:=  FAfternoonSymbol;
          end;
        Inc(tmp);
      end;

  DoProgress(sLMDSysLocaleObjectsTitle, 100, 100);
  DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysLocaleObject.Apply;
const
  mmm: array[0..2] of string = ('MDY', 'DMY', 'YMD');

var
  i: LongInt;
  DefaultLCID: LCID;
  pos_cur: array[0..3] of string;
  neg_cur: array[0..15] of string;
  neg_num: array[0..4] of string;
  lz: array[0..1] of string;
  cm: array[0..1] of string;

  procedure InternalSet(aProp: string; aLocale: LongInt; aVal: string);
  begin
    if PropChanged(aProp) then
      begin
        WriteToLog(aProp);
        SetLocaleInfo(DefaultLCID, aLocale, PChar(aVal));
        end;
  end;

begin

  InitArrays (pos_cur, neg_cur, neg_num, lz, cm);

  DefaultLCID:= GetThreadLocale;

  for i:= 0 to 3 do
    repIt(',', FCurrencyDecimalSeparator, pos_cur[i]);
  for i:= 0 to 15 do
    begin
      repIt(',', FCurrencyDecimalSeparator, neg_cur[i]);
      repIt('-', FNegativeSign, neg_cur[i]);
    end;
  for i:= 0 to 4 do
    begin
      repIt(',', FDecimalSeparator, neg_num[i]);
      repIt('-', FNegativeSign, neg_num[i]);
    end;
  for i:= 0 to 1 do
    repIt(',', FDecimalSeparator, lz[i]);

  InternalSet(strNegativeSign, LOCALE_SNEGATIVESIGN, FNegativeSign);
  InternalSet(strDecimalSeparator, LOCALE_SDECIMAL, FDecimalSeparator);
  InternalSet(strCurrencyDecimalSeparator, LOCALE_SMONDECIMALSEP, FCurrencyDecimalSeparator);
  InternalSet(strCalendarType, LOCALE_ICALENDARTYPE, FCalendarType);
  InternalSet(strCurrencyDigits, LOCALE_ICURRDIGITS, FCurrencyDigits);
  InternalSet(strDigits, LOCALE_IDIGITS, FDigits);
  InternalSet(strFirstDayOfWeek, LOCALE_IFIRSTDAYOFWEEK, FFirstDayOfWeek);
  InternalSet(strFirstWeekOfYear, LOCALE_IFIRSTWEEKOFYEAR, FFirstWeekOfYear);
  InternalSet(strMeasurement, LOCALE_IMEASURE, FMeasurement);
  InternalSet(strMorningSymbol, LOCALE_S1159, FMorningSymbol);
  InternalSet(strAfternoonSymbol, LOCALE_S2359, FAfternoonSymbol);
  InternalSet(strCurrencySymbol, LOCALE_SCURRENCY, FCurrencySymbol);
  InternalSet(strDateSeparator, LOCALE_SDATE, FDateSeparator);
  InternalSet(strGrouping, LOCALE_SGROUPING, FGrouping);
  InternalSet(strListSeparator, LOCALE_SLIST, FListSeparator);
  InternalSet(strLongDateFormat, LOCALE_SLONGDATE, FLongDateFormat);
  InternalSet(strCurrencyGrouping, LOCALE_SMONGROUPING, FCurrencyGrouping);
  InternalSet(strCurrencyGroupingSign, LOCALE_SMONTHOUSANDSEP, FCurrencyGroupingSign);
  InternalSet(strPositiveSign, LOCALE_SPOSITIVESIGN, FPositiveSign);
  InternalSet(strShortDateFormat, LOCALE_SSHORTDATE, FShortDateFormat);
  InternalSet(strThousandSeparator, LOCALE_STHOUSAND, FThousandSeparator);
  InternalSet(strTimeSeparator, LOCALE_STIME, FTimeSeparator);
  InternalSet(strTimeFormat, LOCALE_STIMEFORMAT, FTimeFormat);

  if PropChanged(strShortDateOrder) then
    begin
      WriteToLog(strShortDateOrder);
      for i:= 0 to 15 do
        if mmm[i] = FShortDateOrder then
          SetLocaleInfo(DefaultLCID, LOCALE_IDATE, PChar(IntToStr(i)));
          end;

  if PropChanged(strLongDateOrder) then
    begin
      WriteToLog(strLongDateOrder);
      for i:= 0 to 15 do
        if mmm[i] = FLongDateOrder then
          SetLocaleInfo(DefaultLCID, LOCALE_ILDATE, PChar(IntToStr(i)));
          end;

  InternalSet(strYearDigits, LOCALE_ICENTURY, FYearDigits);
  InternalSet(strInternationalCurrencySymbol, LOCALE_SINTLSYMBOL, FIntCurSymbol);
  InternalSet(strLanguage, LOCALE_SLANGUAGE, FLanguage);
  InternalSet(strLanguageEnglish, LOCALE_SENGLANGUAGE, FLanguageEnglish);
  InternalSet(strLanguageSymbol, LOCALE_SABBREVLANGNAME, FLanguageSymbol);
  InternalSet(strCountryCode, LOCALE_ICOUNTRY, FCountryCode);
  InternalSet(strCountry, LOCALE_SCOUNTRY, FCountry);
  InternalSet(strCountrySymbol, LOCALE_SABBREVCTRYNAME, FCountrySymbol);

  if PropChanged(strClockMode) then
    begin
      WriteToLog(strClockMode);
      if FClockMode = '12' then
        SetLocaleInfo(DefaultLCID, LOCALE_ITIME, '0')
      else
        SetLocaleInfo(DefaultLCID, LOCALE_ITIME, '1');
    end;

  if PropChanged(strNegativeFormat) then
    begin
      WriteToLog(strNegativeFormat);
      for i:= 0 to 4 do
        if neg_num[i] = FNegativeFormat then
          SetLocaleInfo(DefaultLCID, LOCALE_INEGNUMBER, PChar(IntToStr(i)));
          end;

  if PropChanged(strNegativeCurrencyFormat) then
    begin
      WriteToLog(strNegativeCurrencyFormat);
      for i:= 0 to 15 do
        if neg_cur[i] = FNegativeCurrFormat then
          SetLocaleInfo(DefaultLCID, LOCALE_INEGCURR, PChar(IntToStr(i)));
          end;

  if PropChanged(strPositiveCurrencyFormat) then
    begin
      WriteToLog(strPositiveCurrencyFormat);
      for i:= 0 to 3 do
        if pos_cur[i] = FPositiveCurrencyFormat then
          SetLocaleInfo(DefaultLCID, LOCALE_ICURRENCY, PChar(IntToStr(i)));
          end;

  if PropChanged(strShowLeadingZero) then
    begin
      WriteToLog(strShowLeadingZero);
      for i:= 0 to 1 do
        if lz[i] = FShowLeadingZero then
          SetLocaleInfo(DefaultLCID, LOCALE_ILZERO, PChar(IntToStr(i)));
          end;

end;

end.
