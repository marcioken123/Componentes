unit LMDCal;
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

LMDCal unit (JH)
----------------

Changes
-------
Release 8.05
 - BTS 592 fixed

Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls, Menus,
  Forms, Dialogs,
  LMDClass, LMDProcs, LMDGraphUtils, LMDGraph, LMDDateL, LMDButtonBase, LMDFillObject,
  LMD3DCaption, LMDFXCaption, LMDBevel, LMDObject, LMDSpeedButton, LMDTypes,
  LMDSimpleLabel, LMDCustomPanelFill, LMDDateUtils;

type

  {****************************************************************************}
  TLMDDayCaptions = (dpFirst, dpSecond, dpNone{, dpDay}, dpBoth);
  TLMDDayDirections = (ddLeftRight, ddTopBottom);
  TLMDCalendarStyle = (clsSimple, clsWinXP, clsVista);

  TLMDCalendarRecord = RECORD
    GoFurther,                    { FGridPen Width }
    X,Y,                          { x,y cell of calendar which is currently selected }
    GoX,                          { size of a column  }
    GoY              : Integer;   { size of a row     }
    cols,                         { number of columns }
    lines            : Integer;   { number of rows    }
    FirstDay         : TPoint;    { first day in field number X,Y }
    FromTop,                      { top border  (bottom border is equal) }
    FromLeft         : Integer;   { left border (right border is equal) }
    DaysRect         : TRect;
  End;

  TLMDAlarmMode = (amBefore, amOn, amAfter);
  {------------------------TLMDAlarmObject-------------------------------------}
  TLMDAlarmObject = class (TLMDObject)
  private
    FRegHours,
    FRegMinutes,
    FEnabled : Boolean;
    FAlarm   : TLMDAlarmMode;
    FDays,
    FMonths,
    FHours,
    FMinutes : Integer;

    procedure SetBoolean (index : Integer;aValue : Boolean);
    procedure SetInteger (index, aValue : Integer);
    procedure SetAlarm (aValue : TLMDAlarmMode);
  public
    constructor Create(Owner:TPersistent=nil); override;
    procedure Assign (Source : TPersistent); override;
  published
    property Enabled : Boolean index 0 read FEnabled write SetBoolean default false;
    property RegardHours : Boolean index 1 read FRegHours write SetBoolean default true;
    property RegardMinutes : Boolean index 2 read FRegMinutes write SetBoolean default false;
    property Alarm   : TLMDAlarmMode read FAlarm write SetAlarm default amOn;
    property OffsetDays : Integer index 0 read FDays write SetInteger default 0;
    property OffsetMonths : Integer index 1 read FMonths write SetInteger default 0;
    property OffsetHours : Integer index 2 read FHours write SetInteger default 0;
    property OffsetMinutes : Integer index 3 read FMinutes write SetInteger default 0;
  end;

  TLMDDrawCellEvent = procedure (Sender : TObject; Canvas : TCanvas; aRect : TRect; Day : Integer) of object;

  {---------------------TLMDCalendarCell---------------------------------------}
  TLMDCalendarCell = class (TLMDObject)
  private
    FFont          : TFont;
    FFont3D        : TLMD3DCaption;
    FBevel         : TLMDBevel;
    FFillObject    : TLMDFillObject;
    FMask          : String;
    FAlignment     : TLMDAlignment;

    procedure SetFont (aValue : TFont);
    procedure SetFont3D (aValue : TLMD3DCaption);
    procedure SetBevel (aValue : TLMDBevel);
    procedure SetFillObject (aValue : TLMDFillObject);
    procedure SetMask (aValue : String);
    procedure SetAlignment (aValue : TLMDAlignment);
  public
    constructor Create(Owner:TPersistent=nil);override;
    destructor Destroy; override;
    procedure Assign (Source : TPersistent); override;
  published
    property Font : TFont read FFont write SetFont;
    property Font3D : TLMD3DCaption read FFont3D write SetFont3D;
    property Bevel : TLMDBevel read FBevel write SetBevel;
    property FillObject : TLMDFillObject read FFillObject write SetFillObject;
    property Mask : String read FMask write SetMask;
    property Alignment : TLMDAlignment read FAlignment write SetAlignment default agCenter;
  end;

  TLMDHeaderElementAlignment = (taLeftJustify, taRightJustify, taCenter);

  TLMDHeaderObject = class (TLMDObject)
  private
    FAlignment: TLMDHeaderElementAlignment;
    FCaptionAlignment: TLMDAlignment;
    FIndex    : Integer;
    FImageIndex: Integer;
    FCaption: TLMDString;
    FUseCaption: boolean;
    FUseGlyph: boolean;

    procedure SetAlignment (aValue: TLMDHeaderElementAlignment);
    procedure SetIndex (aValue: Integer);
    procedure SetImageIndex(const aValue: Integer);
    procedure SetCaption(const aValue: TLMDString);
    procedure SetUseCaption(const Value: boolean);
    procedure SetUseGlyph(const Value: boolean);
    procedure SetCaptionAlignment(const Value: TLMDAlignment);
  public
    constructor Create(Owner: TPersistent=nil); override;
    procedure Assign (Source: TPersistent); override;
  published
    property Alignment: TLMDHeaderElementAlignment read FAlignment write SetAlignment;
    property Order: Integer read FIndex write SetIndex;
    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1;
    property Caption: TLMDString read FCaption write SetCaption;
    property CaptionAlignment: TLMDAlignment read FCaptionAlignment write SetCaptionAlignment default agCenter;
    property UseCaption: boolean read FUseCaption write SetUseCaption default false;
    property UseGlyph: boolean read FUseGlyph write SetUseGlyph default true;
  end;

  TLMDHeaderElement = (heMonthName, heMonthBtns, heYear, heYearBtns,
                       heMonthCombo, heYearCombo, heTodayBtn);
  TLMDHeaderElements = set of TLMDHeaderElement;

  {---------------------TLMDCalendarHeader-------------------------------------}
  TLMDCalendarHeader = class (TLMDObject)
  private
    FStyle           : TLMDCalendarCell;
    FElements        : TLMDHeaderElements;
    FRepeatedBtnClick,
    FBtnFitToOutput,
    FUseLongMonthNames: Boolean;
    FBtnStyle        : TLMDUserButtonStyle;
    FBtnFont         : TFont;
    FBtnFontFX       : TLMDFXCaption;
    FYearListDelta   : Word;
    FBtnWidth,
    FRepeatingInterval,
    FMinHeight       : Integer;
    FRect            : TRect;

    FTodayObj,
    FMComboObj,
    FYComboObj,
    FMonthObj,
    FYearObj,
    FYearUpObj,
    FYearDnObj,
    FMonthUpObj,
    FMonthDnObj      : TLMDHeaderObject;
    FArrowsColor: TColor;

    procedure SetStyle (aValue : TLMDCalendarCell);
    procedure SetElements (aValue : TLMDHeaderElements);
    procedure SetBoolean (index : Integer;aValue : Boolean);
    procedure SetInteger (aValue : Integer);
    procedure SetBtnStyle (aValue : TLMDUserButtonStyle);
    procedure SetMinHeight (aValue : Integer);
    procedure SetFont (aValue : TFont);
    procedure SetFontFX (aValue : TLMDFXCaption);
    procedure SetHeaderObject(index: Integer; aValue: TLMDHeaderObject);
    procedure SetArrowsColor(const Value: TColor);
  public
    constructor Create(Owner:TPersistent=nil); override;
    destructor Destroy; override;
    procedure Assign (Source : TPersistent); override;
  published
    property ArrowsColor: TColor read FArrowsColor write SetArrowsColor default clBlack;
    property Style : TLMDCalendarCell read FStyle write SetStyle;
    property Elements : TLMDHeaderElements read FElements write SetElements default [heMonthName];
    property UseLongMonthNames : Boolean index 0 read FUseLongMonthNames write SetBoolean default true;
    property ButtonsToText : Boolean index 1 read FBtnFitToOutput write SetBoolean default false;
    property RepeatedBtnClick : Boolean index 2 read FRepeatedBtnClick write SetBoolean default true;
    property RepeatingInterval : Integer read FRepeatingInterval write FRepeatingInterval default 100;
    property ButtonStyle : TLMDUserButtonStyle read FBtnStyle write SetBtnStyle default ubsWin40;
    property ButtonFont : TFont read FBtnFont write SetFont;
    property ButtonFontFX : TLMDFXCaption read FBtnFontFX write SetFontFX;
    property ButtonWidth : Integer read FBtnWidth write SetInteger default 16;
    property MinHeight : Integer read FMinHeight write SetMinHeight default 16;
    property MonthName: TLMDHeaderObject index 0 read FMonthObj write SetHeaderObject;
    property YearValue: TLMDHeaderObject index 1 read FYearObj write SetHeaderObject;
    property MonthUp: TLMDHeaderObject index 2 read FMonthUpObj write SetHeaderObject;
    property MonthDn: TLMDHeaderObject index 3 read FMonthDnObj write SetHeaderObject;
    property YearUp: TLMDHeaderObject index 4 read FYearUpObj write SetHeaderObject;
    property YearDn: TLMDHeaderObject index 5 read FYearDnObj write SetHeaderObject;
    property YearListDelta: Word read FYearListDelta write FYearListDelta default 5;
    property MonthCombo: TLMDHeaderObject index 6 read FMComboObj write SetHeaderObject;
    property YearCombo: TLMDHeaderObject index 7 read FYComboObj write SetHeaderObject;
    property Today: TLMDHeaderObject index 8 read FTodayObj write SetHeaderObject;
  end;

  TLMDCustomCalendar = class;
  TLMDVisibleMode = (vmDefault, vmHintOnly, vmHidden, vmPaintOnly);
  TLMDVisibleModes = set of TLMDVisibleMode;

  {---------------------TLMDSpecialDates---------------------------------------}
  TLMDSpecialDates = class (TCollectionItem)
  private
    FStyle   : TLMDCalendarCell;
    FDates   : TLMDDateList;
    FAlarm   : TLMDAlarmObject;
    FOnDraw  : TLMDDrawCellEvent;
    FCaption : String;
    FVisibleMode : TLMDVisibleMode;
    FAddTimeToHint : Boolean;

    //procedure SetAlarm (aValue : TLMDAlarmObject);
    procedure SetStyle (aValue : TLMDCalendarCell);
    procedure SetDates (aValue : TLMDDateList);
    procedure SetCaption (aValue : String);
    procedure SetVisibleMode (aValue : TLMDVisibleMode);

    procedure GetChange (Sender : TObject);
    procedure ReadData (Reader : TReader);
    procedure WriteData (Writer : TWriter);
  protected
    procedure DefineProperties (Filer : TFiler); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Style : TLMDCalendarCell read FStyle write SetStyle;
    property Dates : TLMDDateList read FDates write SetDates;
//    property Alarm : TLMDAlarmObject read FAlarm write SetAlarm;
    property Caption : String read FCaption write SetCaption;
    property AddTimeToHintText : Boolean read FAddTimeToHint write FAddTimeToHint default false;
    property VisibleMode : TLMDVisibleMode read FVisibleMode write SetVisibleMode default vmDefault;
    property Index;
    property DisplayName;
    property OnDraw : TLMDDrawCellEvent read FOnDraw write FOnDraw;
  end;

  {---------------------TLMDSpecialDateGroups----------------------------------}
  TLMDSpecialDateGroups = class (TCollection)
  private
    FCalendar: TLMDCustomCalendar;
    function GetItem(Index: Integer): TLMDSpecialDates;
    procedure SetItem(Index: Integer; Value: TLMDSpecialDates);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Calendar: TLMDCustomCalendar);
    destructor Destroy; override;
    function Add: TLMDSpecialDates;
    property Items[Index: Integer]: TLMDSpecialDates read GetItem write SetItem; default;
  end;

  TLMDOnDateSelEvent = procedure (Sender : TObject; Date : TDateTime) of object;
  TLMDOnYearChange = procedure (Sender : TObject; Year : Integer) of object;
  TLMDOnMonthChange = procedure (Sender : TObject; Month : Integer) of object;
  TLMDOnDayChange = procedure (Sender : TObject; Day : Integer) of object;

  TLMDOnGetCellSettings = procedure (Sender : TObject; day : Integer; var Mask : String; var Alignment : TLMDAlignment; Font : TFont; Font3D : TLMD3DCaption; Bevel : TLMDBevel; FillObject : TLMDFillObject) of object;

  {---------------------TLMDCalendar-------------------------------------------}
  TLMDCustomCalendar = class(TLMDCustomPanelFill)
  private
    FPainting      : Boolean;
    FMinDate,
    FMaxDate{,
    FDate}          : TDateTime;
    FDays          : TLMDDayCaptions;
    FDayDirection  : TLMDDayDirections;
    FTimerId       : TLMDTimer;
    FDay,
    FMonth,
    FYear          : Word;
    FGridPen       : TPen;
    FAligning,
    FReadOnly,
    FModified,
    FFixedDimens,
    FAdjustSize,
    FShowGrid,
    FUseLongDayNames,
    FShowSpecialDayHint,
    FActualDate,
    FShowDayHint   : Boolean;
    FMarkedDay,
    FMarkedDay2,
    FStartDay      : Byte;
    FCalInfos      : TLMDCalendarRecord;
    oday           : integer;
    HintWnd        : THintWindow;
    FHeader        : TLMDCalendarHeader;

    FDayCaptionCellStyle,
    FMarkerCellStyle,
    FMarker2CellStyle,
    FDayCellStyle,
    FInactiveCellStyle,
    FSelectedCellStyle : TLMDCalendarCell;

    FSpecialDates  : TLMDSpecialDateGroups;

    FOnKeyPressed  : TNotifyEvent;
    FOnMouseClick  : TMouseEvent;

    FOnDraw        : TLMDDrawCellEvent;
    FOnDateSel     : TLMDOnDateSelEvent;
    FOnYear        : TLMDOnYearChange;
    FOnMonth       : TLMDOnMonthChange;
    FOnDay         : TLMDOnDayChange;
    FOnGetCellSettings : TLMDOnGetCellSettings;

    FAlarmList     : TLMDDateList;
    FMLabel,
    FYLabel        : TLMDSimpleLabel;
    FTBtn,
    FYCombo,
    FMCombo,
    FYBtn1, FYBtn2,
    FMBtn1, FMBtn2 : TLMDSpeedButton;
    FComboList     : TPopupMenu;
    FStyle: TLMDCalendarStyle;
    FColorScheme: TLMDColorScheme;


    procedure SetGridPen (aValue : TPen);
    procedure SetDays (aValue : TLMDDayCaptions);
    procedure SetDayDirection (aValue : TLMDDayDirections);
    function checkDate (dateval : TDateTime) : Boolean;
    procedure SetWord (index:Integer;aValue : Word);
//    procedure SetFillStyle (aValue : TLMDFillObject);
    procedure SetStartDay (aValue : Byte);
    procedure SetMarkedDay (index : Integer; aValue : Byte);
    procedure SetDate (index: Integer; aValue : TDateTime);
    function GetDate(index : Integer) : TDateTime;

    procedure SetBoolean (index : Integer; aValue : Boolean);
    procedure SetSpecialDates (aValue : TLMDSpecialDateGroups);
    procedure SetCellStyle (index : Integer; aValue : TLMDCalendarCell);
    procedure SetHeader (aValue : TLMDCalendarHeader);

    procedure CMLeftMouseClick(var Message: TWMLButtonDown); message {WM_MOUSEACTIVATE}WM_LBUTTONDOWN {And WM_RBUTTONDOWN};
//    procedure WMKeyDown(var Msg : TWMKeyDown); message WM_KEYDOWN;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;

    function MakeOutStr (aValue : String; Mask : String) : String;

    procedure PaintCell (pStyle : TLMDCalendarCell; aRect : TRect;day : Integer);
    procedure PaintTextCell (pStyle : TLMDCalendarCell; aRect : TRect; s : String);
    procedure PaintADay (pday, x1, y1 : integer); overload;
    procedure PaintADay (AYear, AMonth, pday, x1, y1 : integer); overload;
    procedure WMSize (var Msg : TWMSize); message WM_SIZE;
    function getRect (x1, y1 : Integer) : TRect;
    procedure GetPaintParams(var x1f, y1f, x2f, y2f, CurDays, Days: Integer);
    procedure PaintMonth(restoreBack: Boolean);
    procedure PaintMonthBack(restoreBack: Boolean);
    procedure SetCalendarStyle(const Value: TLMDCalendarStyle);
    procedure SetColorScheme(const Value: TLMDColorScheme);
  protected
    procedure AssignStandardGlyph(Btn: TLMDSpeedButton; aDir: TLMDArrowDir; aDoubleArrow: boolean); virtual;
    procedure KeyDown(var Key : Word;Shift : TShiftState); override;
    procedure DoDateChange; virtual;
    procedure DoOnBtnClick (Sender : TObject);
    procedure DoOnYearSelect (Sender : TObject);
    procedure DoOnMonthSelect (Sender : TObject);
    procedure MouseClick(XPos, YPos : Integer); virtual;
    function GetDayStrings (y, m, d : Word) : String;
    procedure MouseMove (Shift: TShiftState;X,Y : Integer); override;
    procedure MouseExit; override;
    procedure TextOut (x1,y1,w,h : integer;text : string;Effect : TLMD3DCaption;alignm : TLMDAlignment);
    procedure AlignControls(AControl: TControl; var aRect: TRect); override;

    procedure CalcAlarmList;
    procedure DoOnTimer (Sender : TObject);
    procedure GetChange (Sender : TObject); override;
    procedure   Paint; override;
    procedure   Loaded; override;

    procedure RestoreCurrentBack(pday : Integer);
  public
    constructor Create (aOwner : TComponent); override;
    destructor  Destroy; override;
    function    GetEmpty : Boolean; override;
    function DateInList (Date : TDateTime; modeSet : TLMDVisibleModes) : TPoint; // moved from protected to public RM, Dec 04
    function DayAtPos(var XPos, YPos : Integer) : integer; //moved from protected
                                                           //('MouseAboveDay') to public ('DayAtPos') JH, Sept 02
    function BackDrawArea(Canvas:TCanvas; const dest:TRect; const src:TPoint; flags:Word):Boolean; override;

    procedure AddSpecialDate (groupIndex : Integer; datetime : TDateTime; des : String);
    procedure RemoveSpecialDate (groupIndex, dateIndex : Integer);
    procedure SetSpecialDateDescription (groupIndex, dateIndex : Integer; des : String);
    procedure SetSpecialDateDT (groupIndex, dateIndex : Integer; dt : TDateTime);

    property CellStyle : TLMDCalendarCell index 0 read FDayCellStyle write SetCellStyle;
    property SelectedCellStyle : TLMDCalendarCell index 1 read FSelectedCellStyle write SetCellStyle;
    property SpecialDates : TLMDSpecialDateGroups read FSpecialDates write SetSpecialDates;
    property Header : TLMDCalendarHeader read FHeader write SetHeader;

    property DayDirection : TLMDDayDirections read FDayDirection write SetDayDirection default ddLeftRight;
    property Day : Word index 0 read FDay write SetWord default 30;
    property Month : Word index 1 read FMonth write SetWord default 12;
    property Year : Word index 2 read FYear write SetWord default 1899;

    property StartWithActualDate : Boolean index 0 read FActualDate write SetBoolean default false;
    property CtlXP default false; // compatibility
    property DayCaptions : TLMDDayCaptions read FDays write SetDays default dpFirst;
    property DayCaptionCellStyle : TLMDCalendarCell index 3 read FDayCaptionCellStyle write SetCellStyle;

//    property FillObject : TLMDFillObject read FFillObject write SetFillStyle;

    property ShowDayHint : Boolean index 1 read FShowDayHint write SetBoolean default false;
    property UseLongDayNames : Boolean index 2 read FUseLongDayNames write SetBoolean default false;
    property ShowSpecialDayHint : Boolean index 3 read FShowSpecialDayHint write SetBoolean default true;

    property StartDay : Byte read FStartDay write SetStartDay;
    property Date : TDateTime index 0 read GetDate write SetDate;
    property MinDate : TDateTime index 1 read FMinDate write SetDate;
    property MaxDate : TDateTime index 2 read FMaxDate write SetDate;
    property MarkedDay : Byte index 0 read FMarkedDay write SetMarkedDay default 0;
    property MarkedDay2 : Byte index 1 read FMarkedDay2 write SetMarkedDay default 0;
    property MarkedCellStyle : TLMDCalendarCell index 2 read FMarkerCellStyle write SetCellStyle;
    property Marked2CellStyle : TLMDCalendarCell index 4 read FMarker2CellStyle write SetCellStyle;
    property InactiveCellStyle: TLMDCalendarCell index 5 read FInactiveCellStyle write SetCellStyle;
    property GridPen : TPen read FGridPen write SetGridPen;
    property ShowGrid : Boolean index 4 read FShowGrid write SetBoolean default true;
    property ReadOnly : Boolean index 7 read FReadOnly write SetBoolean default false;
    property Modified : Boolean index 8 read FModified write SetBoolean default false;
//    property AdjustSize : Boolean index 5 read FAdjustSize write SetBoolean default true;
    property FixedDimens : Boolean index 6 read FFixedDimens write SetBoolean default true;
    property OnMouseClick : TMouseEvent read FOnMouseClick write FOnMouseClick;
    property OnKeyPressed : TNotifyEvent read FOnKeyPressed write FOnKeyPressed;
    property OnDraw : TLMDDrawCellEvent read FOnDraw write FOnDraw;
    property OnDateSel : TLMDOnDateSelEvent read FOnDateSel write FOnDateSel;
    property OnYearChange : TLMDOnYearChange read FOnYear write FOnYear;
    property OnMonthChange : TLMDOnMonthChange read FOnMonth write FOnMonth;
    property OnDayChange : TLMDOnDayChange read FOnDay write FOnDay;
    property OnGetCellSettings : TLMDOnGetCellSettings read FOnGetCellSettings write FOnGetCellSettings;
  published
    property Style: TLMDCalendarStyle read FStyle write SetCalendarStyle default clsSimple;
    property ColorScheme: TLMDColorScheme read FColorScheme write SetColorScheme default csDefaultScheme;
    property ParentBackground default false;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
    property ThemeMode default ttmPlatform;
    property ThemeGlobalMode;    
  end;

{ ------------------------------------- Header functions ----------------------}
procedure ApplyCalendarStyleToHeader(var Header: TLMDCalendarHeader; Style: TLMDCalendarStyle);

{ ------------------------------------- Date functions ------------------------}
procedure CalcCelebrationDays(var table : TLMDDateList;Year : Word);

implementation

uses
  Types, Variants,
  LMDConst;

{ ------------------------------------- Header functions ----------------------}
procedure ApplyCalendarStyleToHeader(var Header: TLMDCalendarHeader; Style: TLMDCalendarStyle);
begin
  case Style of
    clsSimple:
    begin
      with Header do
      begin
        Elements := [heMonthName];
        Style.Font.Charset := DEFAULT_CHARSET;
        Style.Font.Height := -11;
        Style.Font.Name := 'Tahoma';
        Style.Font.Style := [];
        Style.Font3d.Style := tdNone;
        Style.Bevel.Mode := bmCustom;
        ButtonFont.Charset := DEFAULT_CHARSET;
        ButtonFont.Height := -11;
        ButtonFont.Name := 'Tahoma';
        ButtonFont.Style := [];
        MonthName.Alignment := taCenter;
        MonthName.Order := 0;
        MonthName.UseCaption := True;
        MonthName.UseGlyph := False;
        YearValue.Alignment := taCenter;
        YearValue.Order := 0;
        YearValue.UseCaption := True;
        YearValue.UseGlyph := False;
        MonthUp.Alignment := taRightJustify;
        MonthUp.Order := 15;
        MonthUp.Caption := '>';
        MonthDn.Alignment := taLeftJustify;
        MonthDn.Order := -15;
        MonthDn.Caption := '<';
        YearUp.Alignment := taRightJustify;
        YearUp.Order := 20;
        YearUp.Caption := '>>';
        YearDn.Alignment := taLeftJustify;
        YearDn.Order := -20;
        YearDn.Caption := '<<';
        MonthCombo.Alignment := taLeftJustify;
        MonthCombo.Order := 0;
        YearCombo.Alignment := taLeftJustify;
        YearCombo.Order := 0;
        Today.Alignment := taLeftJustify;
        Today.Order := 0;
        Today.Caption := 'Today';
        Today.UseCaption := True;
        Today.UseGlyph := False;
      end;
    end;

    clsWinXP:
    begin
      with Header do
      begin
        Style.FillObject.Style := sfNone;
        Elements := [heMonthCombo, heYearCombo];
        MonthCombo.Alignment := taLeftJustify;
        MonthCombo.CaptionAlignment := agCenterLeft;
        YearCombo.Alignment := taRightJustify;
        ButtonStyle := ubsOfficeTransp;
        ButtonFont.Charset := DEFAULT_CHARSET;
        ButtonFont.Height := -11;
        ButtonFont.Name := 'Tahoma';
        ButtonFont.Style := [];
        MinHeight := 22;
      end;
    end;

    clsVista:
    begin
      with Header do
      begin
        with Style do
        begin
          Font.Name := 'Tahoma';
          Font.Style := [fsBold];
          Font3D.Style := tdNone;
        end;
        Elements := [heMonthBtns, heMonthName, heYear];
        ButtonStyle := ubsOfficeTransp;
        ButtonFont.Charset := DEFAULT_CHARSET;
        ButtonFont.Height := -11;
        ButtonFont.Name := 'Tahoma';
        ButtonFont.Style := [];
        MinHeight := 22;
        MonthName.Alignment := taCenter;
        MonthName.Order := 0;
        YearValue.Alignment := taCenter;
        YearValue.Order := 0;
        MonthUp.Alignment := taRightJustify;
        MonthUp.Order := 15;
        MonthDn.Alignment := taLeftJustify;
        MonthDn.Order := -15;
        YearUp.Alignment := taRightJustify;
        YearUp.Order := 20;
        YearDn.Alignment := taLeftJustify;
        YearDn.Order := -20;
        MonthCombo.Alignment := taCenter;
        MonthCombo.Order := 0;
        YearCombo.Alignment := taCenter;
        YearCombo.Order := 0;
        Today.Alignment := taCenter;
        Today.Order := 0;
      end;
    end;
  end;

end;

{ ************************ TLMDAlarmObject *********************************** }
{ ------------------------ private ------------------------------------------- }
procedure TLMDAlarmObject.SetBoolean (index : Integer;aValue : Boolean);
begin
  case index of
    0: if aValue <> FEnabled then
         begin
           FEnabled := aValue;
           GetChange (nil);
         end;
    1: if aValue <> FRegHours then
         begin
           FRegHours := aValue;
           GetChange (nil);
         end;
    2: if aValue <> FRegMinutes then
         begin
           FRegMinutes := aValue;
           GetChange (nil);
         end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmObject.SetInteger (index, aValue : Integer);
begin
  case index of
    0 : if aValue <> FDays then
          begin
            FDays := aValue;
            GetChange (nil);
          end;
    1 : if aValue <> FMonths then
          begin
            FMonths := aValue;
            GetChange (nil);
          end;
    2 : if aValue <> FHours then
          begin
            FHours := aValue;
            GetChange (nil);
          end;
    3 : if aValue <> FMinutes then
          begin
            FMinutes := aValue;
            GetChange (nil);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmObject.SetAlarm (aValue : TLMDAlarmMode);
begin
  if aValue <> FAlarm then
    begin
      FAlarm := aValue;
      GetChange (nil);
    end;
end;

{ ------------------------ public -------------------------------------------- }
constructor TLMDAlarmObject.Create;
begin
  inherited Create;
  FEnabled := false;
  FRegHours := true;
  FRegMinutes := false;
  FAlarm := amOn;
  FDays := 0;
  FMonths := 0;
  FHours := 0;
  FMinutes := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmObject.Assign (Source : TPersistent);
begin
  if Source is TLMDAlarmObject then
    with Source as TLMDAlarmObject do
      begin
        self.FDays := OffsetDays;
        self.FMonths := OffsetMonths;
        self.FHours := OffsetHours;
        self.FMinutes := OffsetMinutes;
        self.FEnabled := Enabled;
        self.FAlarm := Alarm;
        self.FRegHours := RegardHours;
        self.FRegMinutes := RegardMinutes;
      end
  else
    inherited Assign(Source);
end;

{ **************************** TLMDCustomCalendarCell ****************************** }
{ ----------------------------------- private -------------------------------- }
procedure TLMDCalendarCell.SetFont (aValue : TFont);
begin
  FFont.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarCell.SetFont3D (aValue : TLMD3DCaption);
begin
  FFont3D.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarCell.SetFillObject (aValue : TLMDFillObject);
begin
  FFillObject.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarCell.SetBevel (aValue : TLMDBevel);
begin
  FBevel.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarCell.SetMask (aValue : String);
begin
  if aValue <> FMask then
    begin
      FMask := aValue;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarCell.SetAlignment (aValue : TLMDAlignment);
begin
  if aValue <> FAlignment then
    begin
      FAlignment := aValue;
      GetChange (nil);
    end;
end;

{ ----------------------------------- public --------------------------------- }
constructor TLMDCalendarCell.Create;
begin
  inherited Create;

  FFont := TFont.Create;
  FFont.OnChange := GetChange;

  FFont3D := TLMD3DCaption.Create;
  FFont3D.OnChange := GetChange;

  FBevel := TLMDBevel.Create;
  FBevel.OnChange := GetChange;

  FFillObject := TLMDFillObject.Create;
  FFillObject.OnChange := GetChange;

  FMask := '';
  FAlignment := agCenter;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCalendarCell.Destroy;
begin

  FFillObject.OnChange := nil;
  FFillObject.Free;

  FBevel.OnChange := nil;
  FBevel.Free;

  FFont3D.OnChange := nil;
  FFont3D.Free;

  FFont.OnChange := nil;
  FFont.Free;

  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarCell.Assign (Source : TPersistent);
var
  S: TLMDCalendarCell;
begin
  if Source is TLMDCalendarCell then
    begin
      S := TLMDCalendarCell(Source);
      FFont.Assign (S.Font);
      FFont3D.Assign (S.Font3D);
      FBevel.Assign (S.Bevel);
      FFillObject.Assign (S.FillObject);
      FMask := S.Mask;
      FAlignment := S.Alignment;
    end
  else
    inherited Assign(Source);
end;

{ *************** TLMDHeaderObject ***************************************** }
procedure TLMDHeaderObject.Assign (Source: TPersistent);
begin
  if Source is TLMDHeaderObject then
  begin
    FAlignment := TLMDHeaderObject(Source).Alignment;
    FIndex := TLMDHeaderObject(Source).Order;
    FImageIndex := TLMDHeaderObject(Source).ImageIndex;
    FCaption := TLMDHeaderObject(Source).Caption;
    FUseCaption := TLMDHeaderObject(Source).UseCaption;
    FUseGlyph := TLMDHeaderObject(Source).UseGlyph;
    FCaptionAlignment := TLMDHeaderObject(Source).CaptionAlignment;
    exit;
  end;
  inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDHeaderObject.Create(Owner: TPersistent);
begin
  inherited;
  FImageIndex := -1;
  FCaption := '';
  FUseGlyph := true;
  FUseCaption := false;
  FCaptionAlignment := agCenter;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderObject.SetAlignment (aValue: TLMDHeaderElementAlignment);
begin
  if aValue <> FAlignment then
  begin
    FAlignment := aValue;
    GetChange(nil);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderObject.SetCaption(const aValue: TLMDString);
begin
  if aValue <> FCaption then
  begin
    FCaption := aValue;
    GetChange(nil);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderObject.SetCaptionAlignment(const Value: TLMDAlignment);
begin
  if FCaptionAlignment <> Value then
  begin
    FCaptionAlignment := Value;
    GetChange(nil);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderObject.SetImageIndex(const aValue: Integer);
begin
  if aValue <> FImageIndex then
  begin
    FImageIndex := aValue;
    GetChange(nil);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderObject.SetIndex (aValue: Integer);
begin
  if aValue <> FIndex then
  begin
    FIndex := aValue;
    GetChange(nil);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderObject.SetUseCaption(const Value: boolean);
begin
  if FUseCaption <> Value then
  begin
    FUseCaption := Value;
    GetChange(nil);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderObject.SetUseGlyph(const Value: boolean);
begin
  if FUseGlyph <> Value then
  begin
    FUseGlyph := Value;
    GetChange(nil);
  end;
end;

{ *************** TLMDCustomCalendarHeader ***************************************** }
{ --------------- private ---------------------------------------------------- }
procedure TLMDCalendarHeader.SetStyle (aValue : TLMDCalendarCell);
begin
  FStyle.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarHeader.SetElements (aValue : TLMDHeaderElements);
begin
  if aValue <> FElements then
    begin
      FElements := aValue;
      GetChange (self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarHeader.SetArrowsColor(const Value: TColor);
begin
  if FArrowsColor <> Value then
  begin
    FArrowsColor := Value;
    GetChange (nil);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarHeader.SetBoolean (index : Integer;aValue : Boolean);
begin
  case index of
    0 : if aValue <> FUseLongMonthNames then
          begin
            FUseLongMonthNames := aValue;
            GetChange (self);
          end;
    1 : if aValue <> FBtnFitToOutput then
          begin
            FBtnFitToOutput := aValue;
            GetChange (self);
          end;
    2 : if aValue <> FRepeatedBtnClick then
          begin
            FRepeatedBtnClick := aValue;
            GetChange (nil);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarHeader.SetInteger (aValue : Integer);
begin
  if FBtnWidth <> aValue then
    begin
      FBtnWidth := aValue;
      GetChange (self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarHeader.SetBtnStyle (aValue : TLMDUserButtonStyle);
begin
  if aValue <> FBtnStyle then
    begin
      FBtnStyle := aValue;
      if heMonthBtns in FElements then
        GetChange(self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarHeader.SetMinHeight (aValue : Integer);
begin
  if (aValue <> FMinHeight) and (aValue > 7) then
    begin
      FMinHeight := aValue;
      GetChange (self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarHeader.SetFont (aValue : TFont);
begin
  FBtnFont.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarHeader.SetFontFX (aValue : TLMDFXCaption);
begin
  FBtnFontFX.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarHeader.SetHeaderObject(index: Integer; aValue: TLMDHeaderObject);
begin
  case index of
    0: FMonthObj.Assign(aValue);
    1: FYearObj.Assign(aValue);
    2: FMonthUpObj.Assign(aValue);
    3: FMonthDnObj.Assign(aValue);
    4: FYearUpObj.Assign(aValue);
    5: FYearDnObj.Assign(aValue);
    6: FMComboObj.Assign(aValue);
    7: FYComboObj.Assign(aValue);
    8: FTodayObj.Assign(aValue);
  end;
end;

{ --------------- public ----------------------------------------------------- }
constructor TLMDCalendarHeader.Create;

   procedure createHeaderObject(var hobj: TLMDHeaderObject);
   begin
     hobj := TLMDHeaderObject.Create;
     hobj.Alignment := taLeftJustify;
     hobj.Order := 0;
     hobj.OnChange := GetChange;
   end;

begin
  inherited Create;
  FArrowsColor := clBlack;
  FStyle := TLMDCalendarCell.Create;
  FStyle.OnChange := GetChange;
  FMinHeight := 16;

  FUseLongMonthNames := true;
  FBtnFitToOutput := false;
  FRepeatedBtnClick := true;
  FRepeatingInterval := 100;
  FBtnStyle := ubsWin40;
  FElements := [heMonthName];

  FBtnFont := TFont.Create;
  FBtnFont.OnChange := GetChange;
  FBtnFontFX := TLMDFXCaption.Create;
  FBtnFontFX.OnChange := GetChange;
  FBtnWidth := 16;
  FYearListDelta := 5;

  createHeaderObject (FTodayObj);
  FTodayObj.UseGlyph := false;
  FTodayObj.UseCaption := true;
  FTodayObj.Caption := IDS_ACTUALDATE;

  createHeaderObject (FMComboObj);
  createHeaderObject (FYComboObj);
  createHeaderObject (FMonthObj);
  FMonthObj.Alignment := taCenter;
  FMonthObj.UseGlyph := false;
  FMonthObj.UseCaption := true;
  createHeaderObject (FYearObj);
  FYearObj.Alignment := taCenter;
  FYearObj.UseGlyph := false;
  FYearObj.UseCaption := true;

  createHeaderObject (FYearUpObj);
  FYearUpObj.Alignment := taRightJustify;
  FYearUpObj.Order := 20;
  FYearUpObj.Caption := '>>';

  createHeaderObject (FYearDnObj);
  FYearDnObj.Order := -20;
  FYearDnObj.Caption := '<<';

  createHeaderObject (FMonthUpObj);
  FMonthUpObj.Alignment := taRightJustify;
  FMonthUpObj.Order := 15;
  FMonthUpObj.Caption := '>';

  createHeaderObject (FMonthDnObj);
  FMonthDnObj.Order := -15;
  FMonthDnObj.Caption := '<';
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCalendarHeader.Destroy;

  procedure destroyHeaderObject (hobj: TLMDHeaderObject);
  begin
    hobj.OnChange := nil;
    FreeAndNil(hobj);
  end;

begin
  destroyHeaderObject (FTodayObj);
  destroyHeaderObject (FMComboObj);
  destroyHeaderObject (FYComboObj);
  destroyHeaderObject (FMonthObj);
  destroyHeaderObject (FYearObj);
  destroyHeaderObject (FYearUpObj);
  destroyHeaderObject (FYearDnObj);
  destroyHeaderObject (FMonthUpObj);
  destroyHeaderObject (FMonthDnObj);

  FBtnFont.OnChange := nil;
  FBtnFont.Free;
  FBtnFontFX.OnChange := nil;
  FBtnFontFX.Free;
  FStyle.OnChange := nil;
  FStyle.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCalendarHeader.Assign (Source : TPersistent);
begin
  if Source is TLMDCalendarHeader then
  begin
    BeginUpdate;
    FElements := TLMDCalendarHeader(Source).Elements;
    FArrowsColor := TLMDCalendarHeader(Source).ArrowsColor;
    FStyle.Assign (TLMDCalendarHeader(Source).Style);
    FUseLongMonthNames := TLMDCalendarHeader(Source).UseLongMonthNames;
    FBtnFitToOutput := TLMDCalendarHeader(Source).ButtonsToText;
    FRepeatedBtnClick := TLMDCalendarHeader(Source).RepeatedBtnClick;
    FBtnStyle := TLMDCalendarHeader(Source).ButtonStyle;
    FBtnFont.Assign (TLMDCalendarHeader(Source).ButtonFont);
    FBtnFontFX.Assign (TLMDCalendarHeader(Source).ButtonFontFX);
    FRepeatingInterval := TLMDCalendarHeader(Source).RepeatingInterval;
    FBtnWidth := TLMDCalendarHeader(Source).ButtonWidth;
    FMinHeight := TLMDCalendarHeader(Source).MinHeight;
    FMonthObj.Assign(TLMDCalendarHeader(Source).MonthName);
    FYearObj.Assign(TLMDCalendarHeader(Source).YearValue);
    FMonthUpObj.Assign(TLMDCalendarHeader(Source).MonthUp);
    FMonthDnObj.Assign(TLMDCalendarHeader(Source).MonthDn);
    FYearUpObj.Assign(TLMDCalendarHeader(Source).YearUp);
    FYearDnObj.Assign(TLMDCalendarHeader(Source).YearDn);
    FYearListDelta := TLMDCalendarHeader(Source).YearListDelta;
    FMComboObj.Assign(TLMDCalendarHeader(Source).MonthCombo);
    FYComboObj.Assign(TLMDCalendarHeader(Source).YearCombo);
    FTodayObj.Assign(TLMDCalendarHeader(Source).Today);
    EndUpdate(false);
  end
  else
    inherited Assign (Source);
end;

{ *************** TLMDSpecialDates ******************************************* }
{ --------------- private ---------------------------------------------------- }
{procedure TLMDSpecialDates.SetAlarm (aValue : TLMDAlarmObject);
begin
  FAlarm.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialDates.SetStyle (aValue : TLMDCalendarCell);
begin
  FStyle.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialDates.SetDates (aValue : TLMDDateList);
begin
  FDates := aValue;
//  FDates.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialDates.SetCaption (aValue : String);
begin
  FCaption := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialDates.SetVisibleMode (aValue : TLMDVisibleMode);
begin
  if aValue <> FVisibleMode then
    begin
      FVisibleMode := aValue;
      GetChange(self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialDates.GetChange (Sender : TObject);
begin
  Changed (false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialDates.ReadData (Reader : TReader);
var
  newDate : TLMDDateListRecord;
begin
  Reader.ReadListBegin;
//    FDates.Clear;
  while not Reader.EndOfList do
    begin
      newDate.Date := Reader.ReadFloat;
      newDate.DateString := AnsiString(Reader.ReadString);
      FDates.AddDate (newDate);
    end;
  Reader.ReadListEnd;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialDates.WriteData (Writer : TWriter);
var
  i : integer;
begin
  Writer.WriteListBegin;
  for i := 0 to FDates.Count - 1 do
    begin
      Writer.WriteFloat(FDates.Dates[i].Date);
      Writer.WriteString(String(FDates.Dates[i].DateString));
    end;
  Writer.WriteListEnd;
end;

{ ------------------------- protected ---------------------------------------- }
procedure TLMDSpecialDates.DefineProperties (Filer : TFiler);
begin
  inherited DefineProperties (Filer);
  Filer.DefineProperty ('FDates', ReadData, WriteData, true);
end;

{ ---------------------- public ---------------------------------------------- }
constructor TLMDSpecialDates.Create(Collection: TCollection);
begin
  inherited Create (Collection);
  FStyle := TLMDCalendarCell.Create;
  FStyle.OnChange := GetChange;
  FDates := TLMDDateList.Create;
//  FDates.OnChange := GetChange;
  FAlarm := TLMDAlarmObject.Create;
  FAlarm.OnChange := GetChange;
  FVisibleMode := vmDefault;
  FAddTimeToHint := false;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSpecialDates.Destroy;
begin
  FAlarm.Free;
  FDates.Free;
  FStyle.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialDates.Assign(Source: TPersistent);
begin
  if Source is TLMDSpecialDates then
    with Source as TLMDSpecialDates do
      begin
        FStyle.Assign (Style);
//        FDates.Assign (Dates);
      end
  else
    inherited Assign (Source);
end;
{ ---------------------------------------------------------------------------- }

{ ------------------- TLMDSpecialDateGroups ---------------------------------- }
function TLMDSpecialDateGroups.GetItem(Index: Integer): TLMDSpecialDates;
begin
  result := TLMDSpecialDates(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialDateGroups.SetItem(Index: Integer; Value: TLMDSpecialDates);
begin
  inherited SetItem(Index, Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpecialDateGroups.GetOwner: TPersistent;
begin
  result := FCalendar;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpecialDateGroups.Update(Item: TCollectionItem);
begin
{  if Item <> nil then
    FCalendar.UpdatePanel(Item.Index) else
    FCalendar.RePaint; }
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDSpecialDateGroups.Create(Calendar: TLMDCustomCalendar);
begin
  inherited Create(TLMDSpecialDates);
  FCalendar := Calendar;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSpecialDateGroups.Destroy;
begin
  FCalendar := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpecialDateGroups.Add: TLMDSpecialDates;
begin
  result := TLMDSpecialDates(inherited Add);
end;

{ ---------------------------------------------------------------------------- }

{ ---------------------------------TLMDCustomCalendar------------------------------- }
{ --------------------------------- private ---------------------------------- }
procedure TLMDCustomCalendar.SetBoolean (index : Integer;aValue : Boolean);
begin
  case index of
    0 : if aValue <> FActualDate then
          begin
            FActualDate := aValue;
            If FActualDate Then
              DecodeDate (now, FYear, FMonth, FDay);
            GetChange (nil);
          end;
    1 : FShowDayHint := aValue;
    2 : if aValue <> FUseLongDayNames then
          begin
            FUseLongDayNames := aValue;
            GetChange (nil);
          end;
    3 : FShowSpecialDayHint := aValue;
    4 : if aValue <> FShowGrid then
          begin
            FShowGrid := aValue;
            GetChange (nil);
          end;
    5 : if aValue <> FAdjustSize then
          begin
            FAdjustSize := aValue;
            GetChange (nil);
          end;
    6 : if aValue <> FFixedDimens then
          begin
            FFixedDimens := aValue;
            GetChange(nil);
          end;
    7 : FReadOnly := aValue;
    8 : FModified := aValue;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.SetGridPen (aValue : TPen);
begin
  FGridPen.Assign(aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.SetDays (aValue : TLMDDayCaptions);
begin
  if FDays <> aValue then
    begin
      FDays := aValue;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.SetDayDirection (aValue : TLMDDayDirections);
begin
  if aValue <> FDayDirection then
    begin
      FDayDirection := aValue;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCalendar.checkDate (dateval : TDateTime) : Boolean;
begin
  result := true;
  if (double(FMaxDate) <> 0.0) then result := (dateval <= FMaxDate); //= added Dec 2001, by JH
  if result then
    result := (dateval >= FMinDate);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.SetWord (index : Integer; aValue : Word);
var
  i : integer;
  aDate: TDateTime;
begin
  case index of
    0 : if aValue <> FDay then
          begin
            try
              aDate := EncodeDate(FYear, FMonth, aValue);
            except
              exit;
            end;
            if not checkDate (aDate) then exit;
            i := FDay;
            if aValue < 1 then aValue := 1;
            FDay := aValue;
            if FDay > MonthDays[IsLeapYear(FYear),FMonth] then
              FDay := MonthDays[IsLeapYear(FYear),FMonth];
            RestoreCurrentBack (i);
            with FCalInfos do
              begin
                if FDayDirection = ddLeftRight then
                  PaintADay (FDay, ((FCalInfos.FirstDay.X*-1 + FDay) mod 7{cols}),
                                   (FCalInfos.FirstDay.Y + (FCalInfos.FirstDay.X*-1 + FDay) div 7{lines}) - 1)
                else
                  PaintADay (FDay, (FCalInfos.FirstDay.Y*-1 + FDay ) div 7+ FCalInfos.FirstDay.X - 1,
                                   (FCalInfos.FirstDay.Y*-1 + FDay)  mod 7);

              end;
            if Assigned (FOnDay) then FOnDay (self, FDay);
          end;
    1 : if aValue <> FMonth then
          begin
            //if not checkDate (EncodeDate(FYear, aValue, FDay)) then exit; will crash on 30.02.
            if aValue < 1 then aValue := 1;
            if aValue > 12 then aValue := 12;
            FMonth := aValue;
            if FDay > MonthDays[IsLeapYear(FYear),FMonth] then
              FDay := MonthDays[IsLeapYear(FYear),FMonth];
            PaintMonth(true);
            //GetChange (nil);
            if Assigned (FOnMonth) then FOnMonth (self, FMonth);
          end;
    2 : if aValue <> FYear then
          begin
            try
              aDate := EncodeDate(aValue, FMonth, FDay);
            except
              exit;
            end;
            if not checkDate (aDate) then exit;
            FYear := aValue;
            if FDay > MonthDays[IsLeapYear(FYear),FMonth] then
              FDay := MonthDays[IsLeapYear(FYear),FMonth];
            PaintMonth(true);
            //GetChange (nil);
            if Assigned (FOnYear) then FOnYear (self, FYear);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDCustomCalendar.SetFillStyle (aValue : TLMDFillObject);
begin
//  FFillObject.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.SetStartDay (aValue : Byte);
begin
  if not (aValue in [1..7]) then
    aValue := 1;
  FStartDay := aValue;
  GetChange (nil);
end;


{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.SetDate (index : Integer; aValue : TDateTime);
begin
  case index of
    0 : begin
          //if aValue < FMinDate then exit; replaced by checkDate, July 2001, JH
          //if aValue > FMaxDate then exit;
          if not checkDate (aValue) then exit;
          DecodeDate (aValue,FYear,FMonth,FDay);
          PaintMonth(true);
          if Assigned (FOnYear) then FOnYear (self, FYear);
          if Assigned (FOnMonth) then FOnMonth (self, FMonth);
          if Assigned (FOnDay) then FOnDay (self, FDay);  // Fix 7.01.10 
        end;
    1 : begin
          if (FMaxDate <> 0.0) and (FMinDate > FMaxDate) then
            exit;
          FMinDate := aValue;
        end;
    2 : begin
          if (FMinDate <> 0.0) and (FMinDate < FMaxDate) then
            exit;
          FMaxDate := aValue;
        end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCalendar.GetDate(index : Integer) : TDateTime;
begin
  Result := EncodeDate (FYear,FMonth,FDay);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.SetMarkedDay (index : Integer; aValue : Byte);
begin
  if aValue > 7 then aValue := 0;
  case index of
    0 : FMarkedDay := aValue;
    1 : FMarkedDay2 := aValue;
  end;
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.SetSpecialDates (aValue : TLMDSpecialDateGroups);
begin
  FSpecialDates.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.SetCalendarStyle(const Value: TLMDCalendarStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    ApplyCalendarStyleToHeader(FHeader, FStyle);
    case FStyle of
      clsSimple:
      begin
        with GridPen do
        begin
          Style := psSolid;
          Width := 1;
          Mode := pmCopy;
        end;
        with Bevel do
        begin
          Mode := bmStandard;
          StandardStyle := lsNone;
        end;
        with CellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [];
          Font3d.Style := tdNone;
          Bevel.Mode := bmStandard;
          Bevel.StandardStyle := lsNone;
        end;
        with DayCaptionCellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [];
          Bevel.Mode := bmStandard;
          Bevel.StandardStyle := lsRaisedspb;
        end;
        with InactiveCellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [];
          Bevel.Mode := bmStandard;
          Bevel.StandardStyle := lsNone;
        end;
        with MarkedCellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [];
          Bevel.Mode := bmStandard;
          Bevel.StandardStyle := lsNone;
        end;
        with Marked2CellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [];
          Bevel.Mode := bmStandard;
          Bevel.StandardStyle := lsNone;
        end;
        with SelectedCellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [];
          Font3d.Style := tdNone;
          Bevel.Mode := bmStandard;
          Bevel.StandardStyle := lsNone;
        end;
        ColorScheme := csDefaultScheme;
      end;

      clsWinXP:
      begin
        Bevel.Mode := bmStandard;
        Bevel.StandardStyle := lsNone;
        with CellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [];
          Font3D.Style := tdNone;
          Bevel.Mode := bmStandard;
          Bevel.StandardStyle := lsNone;
        end;
        with InactiveCellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [];
          Font3D.Style := tdNone;
          Bevel.Mode := bmStandard;
          Bevel.StandardStyle := lsNone;
        end;
        with DayCaptionCellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [fsBold];
          Bevel.StyleOuter := bvLowered;
          Bevel.Mode := bmStandard;
          Bevel.StandardStyle := lsNone;
        end;
        GridPen.Style := psClear;
        GridPen.Width := 0;
        with MarkedCellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [];
          Bevel.Mode := bmCustom;
        end;
        with Marked2CellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [];
          Bevel.Mode := bmCustom;
        end;
        with SelectedCellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [fsBold];
          Font3D.Style := tdShadow;
          Bevel.StyleInner := bvLowered;
          Bevel.StyleOuter := bvNormal;
          Bevel.BorderWidth := 1;
          Bevel.Mode := bmCustom;
        end;
        ThemeMode := ttmPlatform;
        ColorScheme := csBlue;
      end;

      clsVista:
      begin
        Bevel.Mode := bmStandard;
        Bevel.StandardStyle := lsNone;
        with CellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [fsBold];
          Font3D.Style := tdSunken;
          Bevel.StyleInner := bvShadow;
          Bevel.StyleOuter := bvShadow;
          Bevel.Mode := bmCustom;
        end;
        with InactiveCellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [];
          Font3D.Style := tdNone;
          Bevel.Mode := bmStandard;
          Bevel.StandardStyle := lsNone;
        end;
        with DayCaptionCellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [fsBold];
          Bevel.StyleOuter := bvLowered;
          Bevel.Mode := bmEdge;
          Bevel.EdgeStyle := etEtched;
          Bevel.BorderSides := [fsBottom];
        end;
        GridPen.Style := psClear;
        GridPen.Width := 0;
        with MarkedCellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [];
          Bevel.Mode := bmCustom;
        end;
        with Marked2CellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [];
          Bevel.Mode := bmCustom;
        end;
        with SelectedCellStyle do
        begin
          Font.Charset := DEFAULT_CHARSET;
          Font.Height := -11;
          Font.Name := 'Tahoma';
          Font.Style := [fsBold];
          Font3D.Style := tdShadow;
          Bevel.StyleInner := bvLowered;
          Bevel.StyleOuter := bvNormal;
          Bevel.BorderWidth := 1;
          Bevel.Mode := bmCustom;
        end;
        ThemeMode := ttmPlatform;
        ColorScheme := csVistaBasic;
      end;
    end;
  end;

end;

procedure TLMDCustomCalendar.SetCellStyle (index : Integer; aValue : TLMDCalendarCell);
begin
  case index of
    0: FDayCellStyle.Assign (aValue);
    1: FSelectedCellStyle.Assign (aValue);
    2: FMarkerCellStyle.Assign (aValue);
    3: FDayCaptionCellStyle.Assign (aValue);
    4: FMarker2CellStyle.Assign (aValue);
    5: FInactiveCellStyle.Assign(aValue);
  end;
end;

procedure TLMDCustomCalendar.SetColorScheme(const Value: TLMDColorScheme);

  procedure set2ColorsGradient(aFillObject: TLMDFillObject; aStartColor, aEndColor: TColor);
  begin
    aFillObject.Style := sfGradient;
    aFillObject.Gradient.ColorCount := 16;
    aFillObject.Gradient.TwoColors := True;
    aFillObject.Gradient.Color := aStartColor;
    aFillObject.Gradient.EndColor := aEndColor;
    aFillObject.Gradient.InitPalette;
  end;

begin
  FColorScheme := Value;
  BeginUpdate;
  case Style of
    clsSimple:
    begin
      Color := clBtnFace;
      GridPen.Color := clBlack;
      with CellStyle do
      begin
        Font.Color := clWindowText;
        FillObject.Style := sfBrush;
        FillObject.Brush.Color := clBtnFace;
      end;
      with DayCaptionCellStyle do
      begin
        Font.Color := clWindowText;
        FillObject.Style := sfBrush;
        FillObject.Brush.Color := clBtnFace;
      end;
      with Header do
      begin
        Style.Font.Color := clWindowText;
        ButtonFont.Color := clWindowText;
        Color := clBtnFace;
      end;
      with InactiveCellStyle do
      begin
        Font.Color := clInactiveCaption;
        FillObject.Style := sfBrush;
        FillObject.Brush.Color := clBtnFace;
      end;
      with MarkedCellStyle do
      begin
        Font.Color := clWindowText;
        FillObject.Style := sfBrush;
        FillObject.Brush.Color := clWhite;
      end;
      with Marked2CellStyle do
      begin
        Font.Color := clWindowText;
        FillObject.Style := sfBrush;
        FillObject.Brush.Color := clGray;
      end;
      with SelectedCellStyle do
      begin
        Font.Color := clNavy;
        FillObject.Style := sfBrush;
        FillObject.Brush.Color := clSilver;
      end;
    end;

    clsWinXP:
    begin
      Color := clWhite;
      with CellStyle do
      begin
        Font.Color := 5392449;
        Font3D.LightColor := clSilver;
        Font3D.ShadowColor := clGradientActiveCaption;
        FillObject.Style := sfBrush;
        case FStyle of
          clsSimple:
            FillObject.Brush.Color := 16311512;
          clsWinXP:
            FillObject.Brush.Color := clWhite;
          clsVista:
            set2ColorsGradient(FillObject, 15790320, 15329769);
        end;
      end;
      with DayCaptionCellStyle do
      begin
        Font.Color := 16311512;
        FillObject.Style := sfBrush;
        FillObject.Brush.Color := 14653050;
      end;
      FillObject.Style := sfNone;
      GridPen.Width := 0;
      with Header do
      begin
        Style.FillObject.Style := sfNone;
      end;
      with MarkedCellStyle do
      begin
        Font.Color := clWhite;
        FillObject.Style := sfBrush;
        FillObject.Brush.Color := 14898176;
      end;
      with Marked2CellStyle do
      begin
        Font.Color := clWhite;
        FillObject.Style := sfBrush;
        FillObject.Brush.Color := 14898176;
      end;
      with SelectedCellStyle do
      begin
        Font.Color := clWhite;
        Font3d.Style := tdNone;
        Bevel.Mode := bmStandard;
        Bevel.StandardStyle := lsNone;
        FillObject.Style := sfBrush;
        FillObject.Brush.Color := 14898176;
      end;
      with InactiveCellStyle do
      begin
        Font.Color := clWhite;
        FillObject.Style := sfBrush;
        FillObject.Brush.Color := clWhite
      end;
      case ColorScheme of
        csDefaultScheme,csBlue:;
        csMetallic:
        begin
          SelectedCellStyle.FillObject.Brush.Color := 10592674;
          DayCaptionCellStyle.FillObject.Brush.Color := clWhite;
          DayCaptionCellStyle.Font.Color := 12632256;
        end;
        csHomestead:
        begin
          SelectedCellStyle.FillObject.Brush.Color := 6922635;
          DayCaptionCellStyle.FillObject.Brush.Color := 12244692;
          DayCaptionCellStyle.Font.Color := 3693887;
        end;
        csBlack:
        begin
          Color := 14341071;
          SelectedCellStyle.FillObject.Brush.Color := 5460819;
          DayCaptionCellStyle.FillObject.Brush.Color := 5460819;
          DayCaptionCellStyle.Font.Color := clWhite;
          CellStyle.Font.Color := clBlack;
          CellStyle.FillObject.Brush.Color := 14341071;
          InactiveCellStyle.Font.Color := 14341071;
          InactiveCellStyle.FillObject.Brush.Color := 14341071;
        end;
        csVistaBasic:
        begin
          SelectedCellStyle.FillObject.Brush.Color := 16110779;
          DayCaptionCellStyle.FillObject.Brush.Color := 12753016;
          DayCaptionCellStyle.Font.Color := clWhite;
        end;
      end;
    end;

    clsVista:
    begin
      if ColorScheme = csBlack then
      begin
        Color := 7500402;
        with Header do
        begin
          Header.ArrowsColor := 14406864;
          Header.Style.Font.Color := clWhite;
          Header.Style.FillObject.Style := sfBrush;
          Header.Style.FillObject.Brush.Color := 14406864;
        end;
        with CellStyle do
        begin
          Font.Color := clWhite;
          Font3D.LightColor := 5392449;
          Font3D.ShadowColor := 14406864;
          set2ColorsGradient(FillObject, 7500402, 6052956);
          Bevel.LightColor := 14341071;
          Bevel.ShadowColor := 7500402;
        end;
        with InactiveCellStyle do
        begin
          Font.Color := 5392449;
          FillObject.Style := sfBrush;
          FillObject.Brush.Color := 7500402;
        end;
        with DayCaptionCellStyle do
        begin
          Font.Color := clGray;
          FillObject.Style := sfBrush;
          FillObject.Brush.Color := 14406864;
          Bevel.Mode := bmStandard;
          Bevel.StandardStyle := lsNone;
        end;
        FillObject.Style := sfNone;
        GridPen.Width := 0;
        with Header do
        begin
          Style.FillObject.Style := sfNone;
          ButtonFont.Color := clWindowText;
        end;
        with MarkedCellStyle do
        begin
          Font.Color := clWindowText;
          FillObject.Style := sfBrush;
          FillObject.Brush.Color := clActiveCaption;
        end;
        with Marked2CellStyle do
        begin
          Font.Color := clWindowText;
          Bevel.Mode := bmCustom;
        end;
        with SelectedCellStyle do
        begin
          Font.Color := clWhite;
          Font3D.ShadowColor := clBlack;
          Bevel.BorderColor := clGray;
          Bevel.LightColor := 14406864;
          Bevel.ShadowColor := 14341071;
          set2ColorsGradient(FillObject, 15855855, 14406864);
          FillObject.Brush.Color := 14406864;
        end;
      end
      else
      begin
        Header.Style.Font.Color := clBlack;
        Header.ArrowsColor := clBlack;
        Color := clWhite;
        Bevel.BorderColor := clGradientActiveCaption;
        with CellStyle do
        begin
          Font.Color := 5392449;
          Font3D.LightColor := clSilver;
          Font3D.ShadowColor := clGradientActiveCaption;
          set2ColorsGradient(FillObject, 15790320, 15329769);
          Bevel.LightColor := clWhite;
          Bevel.ShadowColor := 14341071;
        end;
        with InactiveCellStyle do
        begin
          Font.Color := 5392449;
          FillObject.Style := sfBrush;
          FillObject.Brush.Color := clWhite;
        end;
        with DayCaptionCellStyle do
        begin
          Font.Color := clGray;
          FillObject.Style := sfNone;
          FillObject.AlphaLevel := 255;
          Bevel.BorderColor := 15329769;
        end;
        FillObject.AlphaLevel := 0;
        FillObject.Brush.Color := clBtnFace;
        FillObject.Style := sfNone;
        GridPen.Color := clSilver;
        with Header do
        begin
          Style.FillObject.Style := sfNone;
          ButtonFont.Color := clWindowText;
        end;
        with MarkedCellStyle do
        begin
          Font.Color := clWindowText;
          FillObject.Style := sfBrush;
          FillObject.Brush.Color := clActiveCaption;
        end;
        with Marked2CellStyle do
        begin
          Font.Color := clWindowText;
          Bevel.Mode := bmCustom;
        end;
        with SelectedCellStyle do
        begin
          Font.Color := clWhite;
          Font3D.ShadowColor := clBlack;
          Bevel.BorderColor := clGray;
          Bevel.LightColor := 15647132;
          Bevel.ShadowColor := 15647132;
          set2ColorsGradient(FillObject, 16511713, 14662002);
          FillObject.Brush.Color := clSkyBlue;
        end;
      end;
    end;
  end;
  EndUpdate(true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.SetHeader (aValue : TLMDCalendarHeader);
begin
  FHeader.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.TextOut (x1,y1,w,h : integer;text : string;Effect : TLMD3DCaption;alignm : TLMDAlignment);
Var
  a : TRect;
begin
  Canvas.Brush.Style:=bsClear;
  //Canvas.Brush.Color:=Color;
  a := Rect (x1,y1,x1+w,y1+h);
  LMDDrawTextExt(Canvas, Text, Effect, a,DT_EXPANDTABS or
                 TLMDAlignFlags[alignm] or
                 DT_SINGLELINE or DT_NOPREFIX,
             [TLMDDrawTextStyle(Enabled)], nil);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCalendar.DateInList (Date : TDateTime; modeSet : TLMDVisibleModes) : TPoint;
var
  i, j : word;
begin
  result := Point (-1, -1);
  if FSpecialDates.Count = 0 then exit;
  for i := 0 to FSpecialDates.Count - 1 do
    if FSpecialDates[i].Dates.Count <> 0 then
      if (FSpecialDates[i].VisibleMode in ModeSet) or (ModeSet = []) then //new from 5.X on -> only find dates with specialized modeFlag, for old behaviour just pass []
        for j := 0 to FSpecialDates[i].Dates.Count - 1 do
          if Date = (Int(FSpecialDates[i].Dates.Dates[j].Date)) then
            begin;
              result := Point (i, j);
              Exit;
            end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCalendar.MakeOutStr (aValue : String;Mask : String) : String;
var
  i : Integer;
begin
  if Mask = '' then Mask := 'd';
  result := aValue;
  i := 1;
  while (Mask[i] <> 'd') and (Length(Mask) > i) do
    begin
      inc(i);
      if (Mask[i-1] = '/') and (Mask[i] = 'd') then
        inc(i);
    end;
  result := Copy (Mask, 1, i - 1) + result + Copy (Mask, i + 1, Length(Mask) - i);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.CMLeftMouseClick(var Message: TWMLButtonDown);
Var
  XPos, YPos : Integer;
begin
  if Visible then //added Mai 2001, JH
    if not Focused then SetFocus;
  inherited;
  XPos := Message.XPos;
  YPos := Message.YPos;
  MouseClick(XPos,YPos);
  if Assigned (FOnMouseClick) then FOnMouseClick (self, mbLeft, [], XPos, YPos);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.KeyDown(var Key : Word;Shift : TShiftState);
var
  oldDate : TDateTime;

  procedure decDay (amount : Integer);
  begin
    if amount >= day then
      day := 1
    else
      day := day - amount;
    //date := date - amount; (will switch months, too)
  end;

  procedure incDay (amount : Integer);
  begin
    if day + amount <= MonthDays[IsLeapYear(FYear),FMonth] then //added March 2002, JH
      day := day + amount;
    //date := date + amount; (will switch months, too)
  end;

begin
  inherited KeyDown (Key, Shift);
  oldDate := Date;
  case Key of
    VK_LEFT : if FDayDirection = ddLeftRight then
                decDay (1)
              else
                decDay (7);
    VK_RIGHT : if FDayDirection = ddLeftRight then
                 incDay (1)
               else
                 incDay (7);
    VK_UP : if FDayDirection = ddLeftRight then
                decDay (7)
              else
                decDay (1);
    VK_DOWN : if FDayDirection = ddLeftRight then
                 incDay (7)
               else
                 incDay (1);
    VK_NEXT : if ssShift in Shift then
                Year := Year + 1
               else
                 begin
                   if Month < 12 then
                     Month := Month + 1
                   else
                     begin
                       Month := 1;
                       Year := Year + 1;
                     end;
                 end;
    VK_PRIOR : if ssShift in Shift then
                 Year := Year - 1
               else
                 if Month > 1 then
                   Month := Month - 1
                 else
                   begin
                     Year := Year - 1;
                     Month := 12;
                   end;
  end;
  if Date <> oldDate then
    if Assigned (FOnDateSel) then FOnDateSel (self, self.Date);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.WMGetDlgCode(var Msg : TWMGetDlgCode);
begin
  inherited;
  Msg.Result := Msg.Result {or DLGC_WANTCHARS} or DLGC_WANTARROWS;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.PaintCell (pStyle : TLMDCalendarCell; aRect : TRect; day : Integer);
var
  myStyle : TLMDCalendarCell;
  s       : String;
begin
  if Assigned(FOnGetCellSettings) then
    begin
      myStyle := TLMDCalendarCell.Create;
      myStyle.Assign (pStyle);

      with myStyle do
        begin
          s := myStyle.Mask;
          FOnGetCellSettings (self, day, s, myStyle.FAlignment, myStyle.FFont, myStyle.FFont3D, myStyle.FBevel, myStyle.FFillObject);
          myStyle.Mask := s;
        end;
    end
  else
    myStyle := pStyle;

  with myStyle do
    begin
//      if FillObject.Style <> sfNone then
        FillObject.FillCanvas (Canvas, aRect, Color);
{      else
        BackDrawArea (Canvas, aRect, Point (0, 0), 0);}
      Bevel.PaintBevel (Canvas, aRect, true);
      Canvas.Font.Assign (Font);
      TextOut (aRect.Left,aRect.Top,aRect.Right - aRect.Left, aRect.Bottom - aRect.Top,MakeOutStr (IntToStr(Day), myStyle.Mask), Font3D, Alignment);
    end;

  //pStyle.Assign (myStyle);
  if pStyle <> myStyle then
    myStyle.Free;
{  if DateInList (EncodeDate (fyear, fmonth, fday)).X <> -1 then
    begin
      bRect := aRect;
      LMDDrawTextCalcExt (Canvas, s, nil, bRect, Canvas.Font, false, false, 0, 0);
      case pStyle.Alignment of
        agCenterLeft,
        agCenterRight,
        agCenter : aRect.Top := bRect.Bottom;//aRect.Top := aRect.Top + (aRect.Bottom - aRect.Top) div 2 + (bRect.Bottom - bRect.Top) div 2;
        agTopCenter,
        agTopRight,
        agTopLeft : aRect.Top := aRect.Top + bRect.Bottom - bRect.Top;
        agBottomCenter,
        agBottomLeft,
        agBottomRight : aRect.Bottom := aRect.Bottom - bRect.Bottom - bRect.Top;
      end;
      s := GetDayStrings (Year, Month, day);
      Canvas.Font.Name := 'Arial';
      Canvas.Font.Size := 6;
      TextOut (aRect.Left, aRect.Top, FCalInfos.GoX, FCalInfos.GoY, s, pStyle.Font3D, agBottomLeft);
    end;}
//  if Assigned (FOnDraw) then FOnDraw (self, Canvas, aRect, Day);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.PaintTextCell (pStyle : TLMDCalendarCell; aRect : TRect; s : String);
begin
//  if pStyle.FillObject.Style <> sfNone then
   pStyle.FillObject.FillCanvas (Canvas, aRect, Color);
{  else
    BackDrawArea (Canvas, aRect, Point(0,0), 0);}
  aRect := pStyle.Bevel.PaintBevel (Canvas, aRect, true);
  Canvas.Font.Assign (pStyle.Font);
  TextOut (aRect.Left,aRect.Top,aRect.Right - aRect.Left, aRect.Bottom - aRect.Top,MakeOutStr (s, pStyle.Mask), pStyle.Font3D, pStyle.Alignment);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.WMSize (var Msg : TWMSize);
begin
  inherited;
end;

{ ----------------------------- public --------------------------------------- }
constructor TLMDCustomCalendar.Create (aOwner : TComponent);

   procedure createBtn(var aBtn: TLMDSpeedButton; aCapt: String);
   begin
     aBtn := TLMDSpeedButton.Create (self);
     aBtn.Parent := self;
     aBtn.Visible:=False;
     aBtn.Caption := aCapt;
     aBtn.OnClick := DoOnBtnClick;
     aBtn.ImageIndex := -1;
   end;

begin
  inherited Create (aOwner);
  //ControlStyle:=ControlStyle-[csAcceptsControls, csSetCaption,csParentBackground]
  //                          +[csOpaque];
  ControlStyle:=ControlStyle-[csAcceptsControls, csSetCaption{$IFDEF LMDCOMP7},csParentBackground{$ENDIF}]
                            +[csOpaque];
  {$IFNDEF LMDCOMP7}
  ParentBackground := false;
  {$ENDIF}

  FThemeMode := ttmPlatform;
  FAlarmList := nil;

  HintWnd := THintWindow.Create(self);

  FAligning := false;

  FDayCellStyle := TLMDCalendarCell.Create;
  FDayCellStyle.OnChange := GetChange;

  FInactiveCellStyle := TLMDCalendarCell.Create;
  FInactiveCellStyle.OnChange := GetChange;

  FSelectedCellStyle := TLMDCalendarCell.Create;
  FSelectedCellStyle.OnChange := GetChange;
  FSelectedCellStyle.Font.Color := clNavy;

  FMarkerCellStyle := TLMDCalendarCell.Create;
  FMarkerCellStyle.OnChange := GetChange;
  FMarker2CellStyle := TLMDCalendarCell.Create;
  FMarker2CellStyle.OnChange := GetChange;

  FDayCaptionCellStyle := TLMDCalendarCell.Create;
  FDayCaptionCellStyle.OnChange := GetChange;
  with FDayCaptionCellStyle do
  begin
    Bevel.Mode := bmStandard;
    Bevel.StandardStyle := lsRaisedspb;
    FillObject.Style := sfBrush;
    FillObject.Brush.Color := clBtnFace;
  end;

  FGridPen := TPen.Create;
  FGridPen.OnChange := GetChange;
  FShowGrid := true;

  FHeader := TLMDCalendarHeader.Create;
  FHeader.OnChange := GetChange;

  FSpecialDates := TLMDSpecialDateGroups.Create(self);

  FFixedDimens := true;
  FActualDate := false;
  FUseLongDayNames := false;
  FShowSpecialDayHint := true;
  FShowDayHint := false;
  FDayDirection := ddLeftRight;
  FDays := dpFirst;
  FMonth := 12;
  FYear := 1899;
  FDay := 30;
  FStartDay := 1;
  FMarkedDay := 0;
  FMarkedDay2 := 0;


  createBtn (FMBtn1, '<');
  FMBtn1.RepeatingInterval := 500;
  FMBtn1.ButtonLayout.Alignment := agCenter;
  AssignStandardGlyph(FMBtn1, eadLeft, false);

  createBtn (FMBtn2, '>');
  FMBtn2.RepeatingInterval := 500;
  FMBtn2.ButtonLayout.Alignment := agCenter;
  AssignStandardGlyph(FMBtn2, eadRight, false);

  createBtn (FYBtn1, '<<');
  FYBtn1.ButtonLayout.Alignment := agCenter;
  AssignStandardGlyph(FYBtn1, eadLeft, true);

  createBtn (FYBtn2, '>>');
  FYBtn2.ButtonLayout.Alignment := agCenter;
  AssignStandardGlyph(FYBtn2, eadRight, true);


  createBtn (FTBtn, IDS_ACTUALDATE);
  FComboList := TPopupMenu.Create (self);

  createBtn (FYCombo, '#');
  FYCombo.ButtonLayout.Alignment := FHeader.FYComboObj.CaptionAlignment;

  createBtn (FMCombo, '#');
  FMCombo.ButtonLayout.Alignment := FHeader.FMComboObj.CaptionAlignment;

  FMLabel := TLMDSimpleLabel.Create(self);
  FMLabel.Parent := self;
  FMLabel.Visible := false;
  FMLabel.Transparent := true;
  FYLabel := TLMDSimpleLabel.Create(self);
  FYLabel.Parent := self;
  FYLabel.Visible := false;
  FYLabel.Transparent := true;

  // 7.0
  FTimerID:=TLMDTimer.Create(60000, DoOnTimer, false);

  Bevel.Mode := bmStandard;
  Bevel.StandardStyle := lsLoweredspb;
  NeedInvalidate := false;
  FModified := false;
  FReadOnly := false;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomCalendar.Destroy;
begin
  FreeAndNil(FTimerID);

  FGridPen.OnChange := nil;
  FreeAndNil(FGridPen);

  FYLabel.Free;
  FMLabel.Free;
  FComboList.Free;
  FYCombo.Free;
  FMCombo.Free;
  FTBtn.Free;

  FMBtn2.Free;
  FMBtn1.Free;

  FYBtn2.Free;
  FYBtn1.Free;

  if FAlarmList <> nil then FAlarmList.Free;

  FHeader.OnChange := nil;
  FHeader.Free;

  FDayCellStyle.OnChange := nil;
  FDayCellStyle.Free;
  FInactiveCellStyle.OnChange := nil;
  FInactiveCellStyle.Free;
  FSelectedCellStyle.OnChange := nil;
  FSelectedCellStyle.Free;
  FMarkerCellStyle.OnChange := nil;
  FMarkerCellStyle.Free;
  FMarker2CellStyle.OnChange := nil;
  FMarker2CellStyle.Free;
  FDayCaptionCellStyle.OnChange := nil;
  FDayCaptionCellStyle.Free;

  FSpecialDates.Free;

{  FFillObject.OnChange := nil;
  FFillObject.Free;}
  HintWnd.Free;

  inherited Destroy;
end;

procedure TLMDCustomCalendar.PaintADay(pday, x1, y1 : integer);
begin
  PaintADay(FYear, FMonth, pday, x1, y1);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.PaintADay(AYear, AMonth, pday, x1, y1 : integer);
var
  res : TPoint;
  LDayStyle: TLMDCalendarCell;
begin
  if (csLoading in ComponentState) or not HandleAllocated then exit;
  with FCalInfos do
  begin
    { if day is a special day }
    res := DateInList(EncodeDate(AYear, AMonth, pday), [vmDefault, vmPaintOnly]);
    if (res.X <> -1) then
    begin
      with FSpecialDates[res.X] do
        if not Assigned (FSpecialDates[res.X].OnDraw) then
          PaintCell (Style, getRect (x1,y1), pday)
        else
          FSpecialDates[res.X].OnDraw (self, Canvas, getRect (x1,y1), pday)
    end
    else //not the current day or a special day
    begin
      { one row/column can be marked (e.g. all Sundays)}
      if DayOfWeek(EncodeDate (AYear, AMonth, pday)) = FMarkedDay Then
        PaintCell (FMarkerCellStyle, getRect (x1,y1), pday)
      else // second marked day?
      begin
        if DayOfWeek(EncodeDate (AYear, AMonth, pday)) = FMarkedDay2 Then
          PaintCell (FMarker2CellStyle, getRect (x1,y1), pday)
        else // a normal cell or inactive cell (not for current month)
        begin
          if AMonth = FMonth then
            LDayStyle := FDayCellStyle
          else
            LDayStyle := FInactiveCellStyle;

          if not Assigned(FOnDraw) then
            PaintCell(LDayStyle, getRect (x1,y1), pday)
          else
            FOnDraw (self, Canvas,getRect (x1,y1), pday);
        end;
      end;
    end;

    if (pday = FDay) and (AMonth = FMonth) then
    begin
      FCalInfos.X := X1;
      FCalInfos.Y := Y1;
      if not BackDrawArea(Canvas, getRect (x1,y1) , Point (0,0) {Rect (x1,y1).Left, getRect (x1,y1).Top)}, 0) then
      begin
        Canvas.Brush.Style := bsSolid;
        Canvas.Brush.Color := Color;
        Canvas.FillRect (getRect (x1,y1));
      end;
      // hier FOnDraw
      PaintCell (FSelectedCellStyle, getRect (x1,y1), pday)
    end
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCalendar.getRect (x1, y1 : Integer): TRect;
begin
  //result is the rect around the calendar cell (x1, y1)
  with FCalInfos do
    if GoFurther mod 2 = 1 then
      result := Rect (FromLeft + GoX * x1 + GoFurther div 2 + 1,
                      FromTop + GoY * y1 + GoFurther div 2 + 1,
                      FromLeft + GoX * (x1+1) - GoFurther div 2,
                      FromTop + GoY * (y1+1) - GoFurther div 2)
    else
      result := Rect (FromLeft + GoX * x1 + GoFurther div 2,
                      FromTop + GoY * y1 + GoFurther div 2,
                      FromLeft + GoX * (x1+1) - GoFurther div 2,
                      FromTop + GoY * (y1+1) - GoFurther div 2);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.GetPaintParams(var x1f, y1f, x2f, y2f, CurDays, Days: Integer);
var
  DayOf,
  weeks,
  lines, cols: Integer;
  aRect: TRect;
begin
    aRect := GetClientRect;
    InflateRect (aRect, - GetBevel.BevelExtend, - GetBevel.BevelExtend);

    if FHeader.Elements <> [] then
      inc(aRect.Top, FHeader.FRect.Bottom);

    //get the first day of the current month
    If StartDay > DayOfWeek(EncodeDate (FYear,FMonth,1)) Then
      DayOf := DayOfWeek(EncodeDate (FYear,FMonth,1))+(7-FStartDay)
    Else
      DayOf := DayOfWeek(EncodeDate (FYear,FMonth,1))-FStartDay;
    //get the amount of days of the month
    Days := MonthDays[IsLeapYear(FYear), FMonth];
    CurDays := 1 - DayOf;

    { calculate number of weeks in the month }
    weeks := (Days+DayOf-1) div 7 + 1;

    If FDayDirection = ddLeftRight Then
      begin
        cols  := 7; { seven days per week }
        if FFixedDimens then
          lines := 6
        else
          lines := weeks; { weeks this month }
      end
    else
      begin
        if FFixedDimens then
          cols := 6
        else
          cols := weeks; { weeks this month }
        lines := 7; { seven days per week }
      end;
    x1f := 0;
    x2f := 0;
    y1f := 0;
    y2f := 0;
    Case FDays Of
      dpFirst  : if FDayDirection = ddLeftRight then
                   begin
                     FCalInfos.FirstDay.Y := 2;
                     FCalInfos.FirstDay.X := CurDays;
                     INC(lines);
                     y1f := 1;
                   end
                 else
                   begin
                     FCalInfos.FirstDay.X := 2;
                     FCalInfos.FirstDay.Y := CurDays;
                     INC(cols);
                     x1f := 1;
                   end;
      dpSecond : if FDayDirection = ddLeftRight then
                   begin
                     FCalInfos.FirstDay.Y := 1;
                     FCalInfos.FirstDay.X := CurDays;
                     INC(lines);
                     y2f := 1;
                   end
                 else
                   begin
                     FCalInfos.FirstDay.X := 1;
                     FCalInfos.FirstDay.Y := CurDays;
                     INC(cols);
                     x2f := 1;
                   end;
      dpBoth   : if FDayDirection = ddLeftRight then
                   begin
                     FCalInfos.FirstDay.Y := 2;
                     FCalInfos.FirstDay.X := CurDays;
                     INC(lines,2);
                     y1f := 1;
                     y2f := 1;
                   end
                 else
                   begin
                     FCalInfos.FirstDay.X := 2;
                     FCalInfos.FirstDay.Y := CurDays;
                     INC(cols,2);
                     x1f := 1;
                     x2f := 1;
                   end;
  {    dpDay,}
      dpNone : If FDayDirection = ddLeftRight Then
                 begin
                   FCalInfos.FirstDay.Y := 1;
                   FCalInfos.FirstDay.X := CurDays;
                 end
               else
                 begin
                   FCalInfos.FirstDay.X := 1;
                   FCalInfos.FirstDay.Y := CurDays;
                 end;
    End;

    if FShowGrid then
      FCalInfos.GoFurther := FGridPen.Width
    else
      FCalInfos.GoFurther := 0;

    { calculate colwidth and lineheight }
    FCalInfos.GoX := (aRect.Right - aRect.Left) div cols;
    FCalInfos.GoY := (aRect.Bottom - aRect.Top) div lines;
    FCalInfos.FromTop := aRect.Top + ((aRect.Bottom - aRect.Top)-FCalInfos.GoY*lines) div 2;
    FCalInfos.FromLeft := aRect.Left + ((aRect.Right - aRect.Left)-FCalInfos.GoX*cols) div 2;

    FCalInfos.DaysRect := Rect (FCalInfos.FromLeft + x1f * FCalInfos.GoX,
                                FCalInfos.FromTop + y1f * FCalInfos.GoY,
                                FCalInfos.FromLeft + (cols - x2f) * FCalInfos.GoX,
                                FCalInfos.FromTop + (lines - y2f) * FCalInfos.GoY);

    FCalInfos.Cols := Cols;
    FCalInfos.Lines := Lines;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.PaintMonth(restoreBack: Boolean);
var
  y1f, x1f, x2f, y2f, CurDays, Days,
  x,y: Integer;
  LMonth: Integer;
  LDays: Word;

     function GetCurrentMonth:String;
     begin
       if FHeader.UseLongMonthNames then
         result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongMonthNames[FMonth]
       else
         result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortMonthNames[FMonth];
     end;

begin
  GetPaintParams (x1f, y1f, x2f, y2f, CurDays, Days);

  PaintMonthBack (restoreBack);

  FYLabel.Caption := IntToStr (FYear);
  FMLabel.Caption := GetCurrentMonth;
  FYCombo.Caption := FYLabel.Caption;
  FMCombo.Caption := FMLabel.Caption;

  { give out days }
  if FDayDirection = ddLeftRight then
    for y := y1f to FCalInfos.Lines-y2f do
      for x := x1f to FCalInfos.Cols-1-x2f do
         begin
           if not ((CurDays < 1) or (CurDays > Days)) then
             PaintADay(CurDays, x, y)
           else if (CurDays > Days) then
           begin
             LMonth := FMonth + 1;
             if LMonth > 12 then
               LMonth := 1;
             PaintADay(FYear, LMonth, CurDays - Days, x, y);
           end
           else if (CurDays < 1) then
           begin
             LMonth := FMonth - 1;
             if LMonth < 1 then
               LMonth := 12;
             LDays := MonthDays[IsLeapYear(FYear), LMonth];

             PaintADay(FYear, LMonth, LDays + CurDays, x, y);
           end;
           inc( CurDays );
         end //end of for
  else //FDayDirection = ddTopBottom
    For x := x1f to FCalInfos.Cols-x2f do
      For y := y1f to FCalInfos.Lines-1-y2f do
         begin
           if not ((CurDays < 1) or (CurDays > Days)) then
             PaintADay (CurDays, x, y);
           inc( CurDays );
         end; //end of for
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.PaintMonthBack(restoreBack: Boolean);
var
  x,y: Integer;
begin
  if restoreBack then
    if not BackDrawArea (Canvas, FCalInfos.DaysRect, Point(0,0), 0) then
      begin
        Canvas.Brush.Style := bsSolid;
        if Transparent and not BackBitmapCheck then //two lines added JH, July 02
          ParentColor := true;
        Canvas.Brush.Color := Color;
        Canvas.FillRect (FCalInfos.DaysRect);
      end;

  if FShowGrid then
    begin
      Canvas.Pen.Assign (FGridPen);
      for x := 0 to FCalInfos.Cols do
        begin
          Canvas.MoveTo (FCalInfos.FromLeft + x * FCalInfos.GoX, FCalInfos.FromTop);
          Canvas.LineTo (FCalInfos.FromLeft + x * FCalInfos.GoX, FCalInfos.FromTop + FCalInfos.lines * FCalInfos.GoY);
        end;
      for y := 0 to FCalInfos.lines do
        begin
          Canvas.MoveTo (FCalInfos.FromLeft, FCalInfos.FromTop + y * FCalInfos.GoY);
          Canvas.LineTo (FCalInfos.FromLeft + FCalInfos.cols * FCalInfos.GoX, FCalInfos.FromTop + y * FCalInfos.GoY);
        end;
    end;

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.Paint;
var
  x, y: integer;
  x1f, y1f, x2f, y2f, CurDays, Days: Integer;
  bRect : TRect;
  //ms: String;

     function dc (val : integer) : string;
     begin
       If val > 7 Then Val := Val mod 7; //-7;
       if FUseLongDayNames then
         result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongDayNames[val]
       else
         result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDayNames[val];
     end;

begin
  if (csLoading in ComponentState) or FPainting or not HandleAllocated then exit;

  if FAligning then exit;

  FPainting:=True;
  inherited Paint;
  try

    { fill inner of the calendar }
//    if not Transparent then FFillObject.FillCanvas (Canvas, aRect, Color);

//    PaintHeader;
    //paint the header back
    if FHeader.Elements <> [] then
    begin
      bRect := FHeader.FRect;
      bRect := FHeader.Style.Bevel.PaintBevel (Canvas, bRect, true);
      FHeader.Style.FillObject.FillCanvas (Canvas, bRect, Color);
    end;

    GetPaintParams (x1f,y1f,x2f, y2f, CurDays, Days);

    { give out day captions }
    if y1f = 1 then { top row }
      for x := 0 to 6 do
        PaintTextCell (FDayCaptionCellStyle, getRect (x, 0), DC(x+FstartDay));
    if y2f = 1 then { bottom row }
      for x := 0 to 6 do
        PaintTextCell (FDayCaptionCellStyle, getRect (x,FCalInfos.lines-1),DC(x+FStartDay));
    if x1f = 1 then { left column }
      for y := 0 to 6 do
        PaintTextCell (FDayCaptionCellStyle, getRect (0,y),DC(y+FStartDay));
    if x2f = 1 then { bottom column }
      for y := 0 to 6 do
        PaintTextCell (FDayCaptionCellStyle, getRect (FCalInfos.cols-1,y),DC(y+FstartDay));

    PaintMonth(false);
  finally
    FPainting:=False;
  end;
end; //end of Paint

{------------------------------------------------------------------------------}
function TLMDCustomCalendar.GetEmpty;
begin
  result := false; //never empty
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.Loaded;
begin
  inherited Loaded;

  { calculate "month start" }
  If FActualDate Then
    DecodeDate (Now,FYear,FMonth,FDay);

  CalcAlarmList;

end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCalendar.BackDrawArea(Canvas:TCanvas; const dest:TRect; const src:TPoint; flags:Word):Boolean;
begin
  result:= inherited BackDrawArea (Canvas, dest, src, flags);
{  if (Header.Style.FillObject.Style <> sfNone) and (LMDRectinRect(dest, Header.FRect)) then
    begin
      Header.Style.FillObject.FillCanvas(Canvas, dest, Color);
      result := true;
    end;}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.AddSpecialDate (groupIndex : Integer; datetime : TDateTime; des : String);

var
  dlr : TLMDDateListRecord;

begin
  if groupIndex >= FSpecialDates.Count then exit;

  dlr.Date := datetime;
  dlr.DateString := AnsiString(des);
  dlr.active := true;
  dlr.calculated := false;

  FSpecialDates[groupIndex].Dates.AddDate (dlr);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.RemoveSpecialDate (groupIndex, dateIndex : Integer);
begin
  if groupIndex >= FSpecialDates.Count then exit;
  if dateIndex >= FSpecialDates[groupIndex].Dates.Count then exit;

  FSpecialDates[groupIndex].Dates.Delete (dateIndex);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.SetSpecialDateDescription (groupIndex, dateIndex : Integer; des : String);
var
  R: PLMDDateListRecord;
begin
  R := PLMDDateListRecord(FSpecialDates[groupIndex].Dates[DateIndex]);
  R.DateString := AnsiString(des);
  FSpecialDates[groupIndex].Dates[DateIndex] := R;
//  PLMDDateListRecord(FSpecialDates[groupIndex].Dates[DateIndex]).DateString := des;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.SetSpecialDateDT (groupIndex, dateIndex : Integer; dt : TDateTime);
var
  R: PLMDDateListRecord;
begin
  R := PLMDDateListRecord(FSpecialDates[groupIndex].Dates[DateIndex]);
  R.Date := dt;
  FSpecialDates[groupIndex].Dates[DateIndex] := R;
end;

{ ----------------------------- protected ------------------------------------ }
procedure TLMDCustomCalendar.DoDateChange;
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.DoOnBtnClick (Sender : TObject);

var
  p: TPoint;
  tempmsg:TMsg;
  CursorPos: TPoint;

  function Max (a,b: Integer): Integer;
  begin
    result := a;
    if b > a then result := b;
  end;

  procedure addYears;
  var
    delta,
    i,
    j : Integer;
    mi: TMenuItem;
  begin
    delta := Header.YearListDelta;
    j := Max (Year - delta, 1899) - Year;
    //j >= - delta and j <= 0
    for i := Max (Year - delta, 1899) to Year + 2 * delta + j do
      begin
        mi := TMenuItem.Create(FComboList);
        mi.OnClick := DoOnYearSelect;
        mi.Caption := IntToStr (i);
        FComboList.Items.Add (mi);
      end;
  end;

  procedure addMonths;
  var
    i: Integer;
    mi: TMenuItem;
  begin
    for i := 1 to 12 do
      begin
        mi := TMenuItem.Create(FComboList);
        mi.OnClick := DoOnMonthSelect;
        mi.Tag := i;
        if Header.UseLongMonthNames then
          mi.Caption := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongMonthNames[i]
        else
          mi.Caption := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortMonthNames[i];
        FComboList.Items.Add (mi);
      end;
  end;

begin
  if Sender = FMBtn1 then
    begin
      if Month > 1 then
        Month := Month - 1
      else
        begin
          Year := FYear - 1;
          Month := 12;
        end;
      exit;
    end;
  if Sender = FMBtn2 then
    begin
      if Month < 12 then
        Month := Month + 1
      else
        begin
          Year := FYear + 1;
          Month := 1;
        end;
      exit;
    end;
  if Sender = FYBtn1 then
    begin Year := FYear - 1; exit; end;
  if Sender = FYBtn2 then
    begin Year := FYear + 1; exit; end;
  if Sender = FTBtn then
    begin self.Date := SysUtils.Date; exit; end;

  p := Point ((Sender as TLMDSpeedButton).Left,
                   (Sender as TLMDSpeedButton).Top +
                   (Sender as TLMDSpeedButton).Height);
  p := ClientToScreen (p);
  if Sender = FYCombo then
    begin
      FComboList.Items.Clear;
      addYears;
      FYCombo.DoStateChange(bsDown);
      FComboList.Popup(p.X, p.Y);
      // RM  --> a GraphicControl can't detect selection from PopupMenu
      while PeekMessage(tempMsg,HWND(0),WM_MOUSEFIRST,WM_MOUSELAST,PM_REMOVE) do ;
      if GetCapture<>0 then
        SendMessage(GetCapture,WM_CANCELMODE,0,0);
      GetCursorPos(CursorPos);
      CursorPos := self.ScreenToClient(CursorPos);
      if PtInRect(FYCombo.BoundsRect, CursorPos) then
        FYCombo.DoStateChange(bsMouseOver, True)
      else
        FYCombo.DoStateChange(bsUp, True);
      // --
    end;
  if Sender = FMCombo then
    begin
      FComboList.Items.Clear;
      addMonths;
      FMCombo.DoStateChange(bsDown);
      FComboList.Popup(p.X, p.Y);
      // RM  --
      while PeekMessage(tempMsg,HWND(0),WM_MOUSEFIRST,WM_MOUSELAST,PM_REMOVE) do ;
      if GetCapture<>0 then
        SendMessage(GetCapture,WM_CANCELMODE,0,0);
      GetCursorPos(CursorPos);
      CursorPos := self.ScreenToClient(CursorPos);
      if PtInRect(FMCombo.BoundsRect, CursorPos) then
        FMCombo.DoStateChange(bsMouseOver, True)
      else
        FMCombo.DoStateChange(bsUp, True);
      // --
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.DoOnYearSelect (Sender : TObject);
  function rs(s: String): String;
  begin
    while Pos ('&', s) <> 0 do
      Delete (s, Pos ('&', s), 1);
    result := s;
  end;
begin
  Year := StrToInt(rs((Sender as TMenuItem).Caption));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.DoOnMonthSelect (Sender : TObject);
begin
  Month := (Sender as TMenuItem).Tag;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.RestoreCurrentBack (pday : integer);
var
  aRect : TRect;
begin
  with FCalInfos do
    begin
      HintWnd.ReleaseHandle;
      aRect := getRect (X,Y);
      if not BackDrawArea(Canvas, aRect , Point(0{aRect.Left},0{aRect.Top}), 0) then
        begin
          Canvas.Brush.Style := bsSolid;
          if Transparent and not BackBitmapCheck then //two lines added JH, July 02
            ParentColor := true;
//          else
            Canvas.Brush.Color := Color;
          Canvas.FillRect (aRect);
        end;
      PaintADay (pday, X, Y); //repaint original cell content
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.MouseClick(XPos, YPos : Integer);
Var
  i,
  TempDay : Word;
begin
  if FReadOnly then exit;
  TempDay := DayAtPos(XPos,YPos);
  If TempDay In [1..MonthDays[IsLeapYear(FYear),FMonth]] Then
    with FCalInfos do
    begin
      if not checkDate (EncodeDate (FYear, FMonth, TempDay)) then exit;
      i := FDay;
      FDay := TempDay;
      RestoreCurrentBack (i);
      PaintADay (FDay, XPos-1, YPos); //paint new selected
      DoDateChange;
      FModified := true;
      if Assigned (FOnDateSel) then FOnDateSel (self, self.Date);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCalendar.GetDayStrings(y, m, d : Word) : String;
var
  i, j : Integer;
  dt : TDateTime;
  FIns,
  FFirst,
  FList : Boolean;
  toAdd : String;
begin
  FList := false;

  if FList then
    toAdd := ';'
  else
    toAdd := #10#13;

  dt := EncodeDate (y, m, d);
  result := '';
  for i := 0 to FSpecialDates.Count - 1 do
    begin
      FFirst := true; //next item found is the first of this special date group
      if FSpecialDates[i].VisibleMode in [vmDefault, vmHintOnly] then //> 5.X
        for j := 0 to FSpecialDates[i].Dates.Count - 1 do
          if dt = (Int(FSpecialDates[i].Dates.Dates[j].Date)) then
            begin
              FIns := false;
              if FFirst then //first
                begin
                  // FIns := true; //inserted Caption - removed 20.04 JH (otherwise first date will not be shown)

                  if FSpecialDates[i].Caption <> '' then //if no caption is entered there will be no topic ...
                    //if there is already some text - from previous groups
                    if result <> '' then
                      result := result+toAdd+FSpecialDates[i].Caption+':'
                    else //this is there first caption to be added
                      result := FSpecialDates[i].Caption+':';

                  if (not FList) and (result <> '') then result := result + #13+#10;

                  FFirst := false; //next item cannot be the first one
                end;
              if not FIns then
                begin
                  if (result <> '') then
                    begin
                      //if the entered special date i snot named it will not be shown
                      if FSpecialDates[i].Dates.Dates[j].DateString <> '' then
                        if FList then
                          result := result+';'+String(FSpecialDates[i].Dates.Dates[j].DateString)
                        else
                          result := result+#13+#10+String(FSpecialDates[i].Dates.Dates[j].DateString);
                    end
                  else
                    result := result {<- FIns} + String(FSpecialDates[i].Dates.Dates[j].DateString);

                  //only add the time to the output if it is wanted
                  if (FSpecialDates[i].AddTimeToHintText) then
                    result := result + '('+TimeToStr (FSpecialDates[i].Dates.Dates[j].Date)+')';
                end;
            end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.MouseMove (Shift: TShiftState;X,Y : Integer);
var
  res,
  a : TPoint;
  tempday : integer;
  s : string;
  aRect : TRect;
begin
  inherited MouseMove (Shift,X,Y);
  tempday := DayAtPos (x,y);
  If (tempday <> 0) and (tempday <> oday) Then
    begin
      HintWnd.ReleaseHandle;
      oday := tempday;
      GetCursorPos (a);
      a.x:= a.x+20;
      a.y:= a.y+20;
      res := DateInList (EncodeDate(Year, Month, tempday), [vmDefault, vmHintOnly]);
      if (res.x <> -1) and (FShowSpecialDayHint) then
        begin
          s := GetDayStrings (Year, Month, tempday);
          if s = '' then exit;
          aRect := Rect (0,0,1000,1000);
          LMDDrawTextCalcExt (HintWnd.Canvas, s, nil, aRect, HintWnd.Canvas.Font, true, false, 0, 0);
          OffSetRect (aRect, a.x, a.y);
          inc(aRect.Right, 4);
          HintWnd.ActivateHint (aRect, s)
        end
      else
        If FShowDayHint Then
          begin
            s := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDayNames[DayOfWeek(EncodeDate(FYear,FMonth,tempday))]+', '+ IntToStr(tempday)+'.'+IntToStr(FMonth)+'.';
            HintWnd.ActivateHint (Rect (a.x,a.y,a.x+5+HintWnd.Canvas.TextWidth(s),a.y+15),s)
          end;
    end
  else
    If tempday = 0 then
      HintWnd.ReleaseHandle;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.MouseExit;
begin
  HintWnd.ReleaseHandle;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomCalendar.DayAtPos(var XPos, YPos : Integer) : integer;
var
  tempday : integer;
begin
  tempday := 0; //to calm down compiler warning
  with FCalInfos do
    begin
      if (gox = 0) or (goy = 0) or (xpos <= 0) or (ypos <= 0) then begin result := 0; exit; end;
      if FDayDirection = ddLeftRight then
        begin
          XPos := (XPos-FromLeft) div GoX + 1;
          YPos := (YPos-FromTop) div GoY - FirstDay.Y + 2;
          if XPos in[1..7] then
            case YPos Of
              1 : if XPos >= FirstDay.X then
                    TempDay := XPos+FirstDay.X-1;
              else
                  TempDay := (YPos-2) * 7 + 6 + FirstDay.X + XPos;
            end;
          if (FDays in [dpNone, dpSecond]) then dec(ypos);
        end
      else
        begin
          XPos := (XPos-FromLeft) div GoX - FirstDay.X +2;
          YPos := (YPos-FromTop) div GoY;
          if YPos in [0..6] then
            case XPos of
              1 : If YPos >= FirstDay.Y-1 then
                    TempDay := YPos+FirstDay.Y;
              else
                  TempDay := ((XPos-1) * 7) + FirstDay.Y+YPos;
            end
          else
            tempday := 0;
          if (FDays in [dpFirst, dpBoth]) then inc(xpos);
        end;
    end;
  if TempDay in [1..MonthDays[IsLeapYear(FYear),FMonth]] then
    result := TempDay
  else
    result := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.AlignControls(AControl: TControl; var aRect: TRect);

  procedure AlignHeaderControls;
  const
    dist_const = 1;
  type
    headerelements= (heYearDn, heYearUp, heMonthDn, heMonthUp,
                     heToday, heYCombo, heMCombo, heYValue, heMName);
  var
    ms{, s} : String;
    //GoX,
    GoY,
    x,
    ButtonWidth : Integer;
    pRect,
    bRect,
    btnCaptionRect: TRect;
    xi: headerelements;
    a: Array[Low(headerelements)..High(headerelements)] of TLMDAlignRect;

    function convAlign (Align: TLMDHeaderElementAlignment): TLMDRectAlignment;
    begin
      case Align of
        taLeftJustify: result := raLeft;
        taCenter: result := raCenter;
        taRightJustify: result := raRight;
      else
        result := raLeft;
      end;
    end;

    procedure setupBtn (FBtn: TLMDSpeedButton);
    begin
      FBtn.BeginUpdate;
      FBtn.ImageList := Self.ImageList;
      FBtn.Style := FHeader.ButtonStyle;
      FBtn.ThemeMode:=self.ThemeMode;
      FBtn.FontFx.BeginUpdate;
      FBtn.FontFx.Assign (FHeader.ButtonFontFX);
      FBtn.FontFx.EndUpdate(false);
      FBtn.Font.Assign (FHeader.ButtonFont);
      FBtn.EndUpdate(false);
    end;

    procedure AdjustControl(Ctrl: TControl; i: headerelements;
                    Kind: TLMDHeaderElement);
    begin
      with  a[i].rect do
        Ctrl.SetBounds (Left, Top, Right, Bottom);

      Ctrl.Visible := (Kind in FHeader.Elements);
    end;

  begin
    { paint header }
    if FHeader.Elements <> [] then
      begin
        pRect := GetClientRect;
        InflateRect (pRect, - Bevel.BevelExtend, - Bevel.BevelExtend);
        for xi := Low(headerelements) to High(headerelements) do
          begin
            a[xi].align := raLeft;
            a[xi].index := 0;
            a[xi].rect := Rect(0, 0, 0, 0);
          end;

        ButtonWidth := FHeader.ButtonWidth;
        GoY := FHeader.Style.Bevel.BevelExtend*2;

        //GoX := 16; //if there are buttons and not text
        if FHeader.UseLongMonthNames then
          ms := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongMonthNames[FMonth]
        else
          ms := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortMonthNames[FMonth];
        //pre calc the needed height
        if (heYear in FHeader.Elements) then
          begin
            //FYLabel.Caption := IntToStr(Year);
            FYLabel.Alignment := FHeader.Style.FAlignment;
            FYLabel.Font.Assign (FHeader.Style.Font);
            FYLabel.Font3D.Assign(FHeader.Style.Font3D);
            bRect := pRect;
            //get the text extension
            LMDDrawTextCalc(IntToStr(Year), FHeader.Style.Font3D, bRect,
                            FHeader.Style.Font, false, false, 0, TLMDAlignFlags[FHeader.Style.Alignment]);
            a[heYValue].rect := bRect;
            a[heYValue].index := Header.FMonthObj.Order;
            a[heYValue].align := convAlign(Header.FMonthObj.Alignment);
          end;
        if (heMonthName in FHeader.Elements) then
          begin
            //FMLabel.Caption := ms;
            FMLabel.Alignment := FHeader.Style.FAlignment;
            FMLabel.Font.Assign (FHeader.Style.Font);
            FMLabel.Font3D.Assign(FHeader.Style.Font3D);
            bRect := pRect;
            //get the text extension
            LMDDrawTextCalc(ms, FHeader.Style.Font3D, bRect,
                            FHeader.Style.Font, false, false, 0, TLMDAlignFlags[FHeader.Style.Alignment]);
            a[heMName].rect := bRect;
            a[heMName].index := Header.FMonthObj.Order;
            a[heMName].align := convAlign(Header.FMonthObj.Alignment);
          end;

        if (heMonthName in FHeader.Elements) or (heYear in FHeader.Elements) then
          begin
            GoY := GoY + bRect.Bottom;
            //GoX := bRect.Right;
          end
        else //only buttons are visible
          GoY := GoY + FHeader.MinHeight;

        if GoY < FHeader.MinHeight then
          GoY := FHeader.MinHeight;

        bRect := pRect;
        bRect.Bottom := pRect.Top + GoY + 4;

        FHeader.FRect := bRect;

        InflateRect (bRect, -FHeader.Style.Bevel.BevelExtend, - FHeader.Style.Bevel.BevelExtend);

        a[heMName].rect := Rect(a[heMName].rect.Left, a[heMName].rect.Top, a[heMName].rect.Right, bRect.Bottom);
        a[heYValue].rect := Rect(a[heYValue].rect.Left, a[heYValue].rect.Top, a[heYValue].rect.Right, bRect.Bottom);

        //GoX := (bRect.Right - bRect.Left - GoX) div 2;
        if heYearBtns in FHeader.Elements then
          begin
            setupBtn (FYBtn1);
            FYBtn1.ButtonLayout.Alignment := FHeader.FYearDnObj.CaptionAlignment;

            setupBtn (FYBtn2);
            FYBtn2.ButtonLayout.Alignment := FHeader.FYearUpObj.CaptionAlignment;

            if Header.FYearDnObj.UseGlyph then
            begin
              FYBtn1.ImageIndex := Header.FYearDnObj.ImageIndex;
              if FYBtn1.ImageIndex = -1 then
                AssignStandardGlyph(FYBtn1, eadLeft, true);
            end;

            FYBtn1.Caption := Header.FYearDnObj.Caption;
            FYBtn1.UseCaption := Header.FYearDnObj.UseCaption;

            if Header.FYearUpObj.UseGlyph then
            begin
              FYBtn2.ImageIndex := Header.FYearUpObj.ImageIndex;
              if FYBtn2.ImageIndex = -1 then
                AssignStandardGlyph(FYBtn2, eadRight, true);
            end;

            FYBtn2.Caption := Header.FYearUpObj.Caption;
            FYBtn2.UseCaption := Header.FYearUpObj.UseCaption;

            a[heYearDn].index := Header.FYearDnObj.Order;
            a[heYearUp].index := Header.FYearUpObj.Order;
            a[heYearDn].rect := Rect (0, bRect.Top, ButtonWidth, bRect.Bottom - bRect.Top - dist_const);
            a[heYearUp].rect := Rect (0, bRect.Top, ButtonWidth, bRect.Bottom - bRect.Top - dist_const);
            a[heYearDn].align := convAlign (Header.FYearDnObj.Alignment);
            a[heYearUp].align := convAlign (Header.FYearUpObj.Alignment);

            if FHeader.ButtonsToText then
              begin
                a[heYearUp].align := raCenter;
                a[heYearDn].align := raCenter;
              end;

            FYBtn1.RepeatedClick := FHeader.RepeatedBtnClick;
            FYBtn2.RepeatedClick := FHeader.RepeatedBtnClick;

            FYBtn1.RepeatingInterval := FHeader.RepeatingInterval;
            FYBtn2.RepeatingInterval := FHeader.RepeatingInterval;

          end;

        if heMonthBtns in FHeader.Elements then
          begin
            setupBtn (FMBtn1);
            FMBtn1.ButtonLayout.Alignment := FHeader.FMonthDnObj.CaptionAlignment;

            setupBtn (FMBtn2);
            FMBtn2.ButtonLayout.Alignment := FHeader.FMonthUpObj.CaptionAlignment;

            if Header.FMonthDnObj.UseGlyph then
            begin
              FMBtn1.ImageIndex := Header.FMonthDnObj.ImageIndex;
              if FMBtn1.ImageIndex = -1 then
                AssignStandardGlyph(FMBtn1, eadLeft, false);
            end;

            if Header.FMonthUpObj.UseGlyph then
            begin
              FMBtn2.ImageIndex := Header.FMonthUpObj.ImageIndex;
              if FMBtn2.ImageIndex = -1 then
                AssignStandardGlyph(FMBtn2, eadRight, false);
            end;

            FMBtn1.Caption := Header.FMonthDnObj.Caption;
            FMBtn1.UseCaption := Header.FMonthDnObj.UseCaption;
            FMBtn2.Caption := Header.FMonthUpObj.Caption;
            FMBtn2.UseCaption := Header.FMonthUpObj.UseCaption;

            FMBtn1.RepeatedClick := FHeader.RepeatedBtnClick;
            FMBtn2.RepeatedClick := FHeader.RepeatedBtnClick;

            FMBtn1.RepeatingInterval := FHeader.RepeatingInterval;
            FMBtn2.RepeatingInterval := FHeader.RepeatingInterval;

            a[heMonthDn].index := Header.FMonthDnObj.Order;
            a[heMonthUp].index := Header.FMonthUpObj.Order;
            a[heMonthDn].rect := Rect (0, bRect.Top, ButtonWidth, bRect.Bottom - bRect.Top - dist_const);
            a[heMonthUp].rect := Rect (0, bRect.Top, ButtonWidth, bRect.Bottom - bRect.Top - dist_const);
            a[heMonthDn].align := convAlign (Header.FMonthDnObj.Alignment);
            a[heMonthUp].align := convAlign (Header.FMonthUpObj.Alignment);

            if FHeader.ButtonsToText then
              begin
                a[heMonthUp].align := raCenter;
                a[heMonthDn].align := raCenter;
              end
          end;

        if heTodayBtn in FHeader.Elements then
          begin
            setupBtn (FTBtn);
            FTBtn.ImageIndex := Header.FTodayObj.ImageIndex;
            FTBtn.Caption := Header.FTodayObj.Caption;
            FTBtn.UseCaption := Header.FTodayObj.UseCaption;
            btnCaptionRect := FTBtn.GetNeededSizeRect;
            x := btnCaptionRect.Right - btnCaptionRect.Left + 4;

            a[heToday].rect := Rect(0, bRect.Top, x, bRect.Bottom - bRect.Top - dist_const);
            a[heToday].align := convAlign (Header.FTodayObj.Alignment);
            a[heToday].index := Header.FTodayObj.Order;
          end;

        if heYearCombo in FHeader.Elements then
          begin
            setupBtn (FYCombo);
            FYCombo.BeginUpdate;
            FYCombo.Caption := IntToStr (Year);
            FYCombo.ButtonLayout.Alignment := FHeader.FYComboObj.CaptionAlignment;
            FYCombo.ButtonLayout.Arrow := true;
            btnCaptionRect := FYCombo.GetNeededSizeRect;
            FYCombo.EndUpdate(false);
            x := btnCaptionRect.Right - btnCaptionRect.Left + 4;
            a[heYCombo].rect := Rect(0, bRect.Top, x, bRect.Bottom - bRect.Top - dist_const);
            a[heYCombo].align := convAlign (Header.FYComboObj.Alignment);
            a[heYCombo].index := Header.FYComboObj.Order;
          end;

        if heMonthCombo in FHeader.Elements then
          begin
            setupBtn (FMCombo);
            FMCombo.BeginUpdate;
            FMCombo.Caption := ms;
            FMCombo.ButtonLayout.Alignment := FHeader.FMComboObj.CaptionAlignment;
            FMCombo.ButtonLayout.Arrow := true;
            FMCombo.EndUpdate(false);
            x := ButtonWidth * 5;
            a[heMCombo].rect := Rect(0, bRect.Top, x, bRect.Bottom - bRect.Top - dist_const);
            a[heMCombo].align := convAlign (Header.FMComboObj.Alignment);
            a[heMCombo].index := Header.FMComboObj.Order;
          end;

        inc (pRect.Top, GoY+4);

      end
    else
      begin
      end;

//    LMDCheckRects (a);
    LMDAlignRects (bRect, a);

    AdjustControl(FYBtn1, heYearDn, heYearBtns);
    AdjustControl(FYBtn2, heYearUp, heYearBtns);

    AdjustControl(FMBtn1, heMonthDn, heMonthBtns);
    AdjustControl(FMBtn2, heMonthUp, heMonthBtns);

    AdjustControl(FTBtn, heToday, heTodayBtn);

    AdjustControl(FYCombo, heYCombo, heYearCombo);

    AdjustControl(FMCombo, heMCombo, heMonthCombo);

    AdjustControl(FYLabel, heYValue, heYear);

    AdjustControl(FMLabel, heMName, heMonthName);
  end;

begin
  FAligning := true;
  try
    AlignHeaderControls;
  finally
    FAligning := false;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.AssignStandardGlyph(Btn: TLMDSpeedButton; aDir: TLMDArrowDir;
  aDoubleArrow: boolean);
var
  Bmp: TBitmap;
begin
  Bmp := TBitmap.Create;
  Bmp.Width := 10;
  Bmp.Height := 9;
  Bmp.PixelFormat := pf8Bit;
  if aDoubleArrow then
  begin
    LMDDrawArrow(Bmp.Canvas, aDir, Rect(2,0,10,8), Header.ArrowsColor, true);
    LMDDrawArrow(Bmp.Canvas, aDir, Rect(-2,0,6,8), Header.ArrowsColor, true);
  end
  else
    LMDDrawArrow(Bmp.Canvas, aDir, Rect(0,0,10,8), Header.ArrowsColor, true);
  Btn.Glyph.Assign(Bmp);
  Bmp.Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.CalcAlarmList;

  function Get(st : String; mode : TLMDAlarmMode;OffDay, OffMonth, OffH, OffM : Integer) : String;
  var
    TT, DT : TDateTime;
    h, m, s, ms : word;
  begin
    DT := StrToDate (Copy (st, 1, Pos(';',st) -1));

    Delete (st, 1, Pos(';',st));
    TT := StrToTime (Copy (st, 1, Pos(';',st) -1));

    case mode of
      amOn : begin
               DecodeTime (TT, h, m, s, ms);
               TT := EncodeTime (h, m, 0, 0);
               DT := DT + TT;
             end;
      amBefore : DT := LMDOffsetDateTime(DT+TT,
                             0, -OffMonth, -OffDay,
                             -OffH, -OffM, 0, 0);
      amAfter : DT := LMDOffsetDateTime (DT+TT,
                           0, OffMonth, OffDay,
                           OffH, OffM, 0, 0);

    end;
    result := DateTimeToStr (DT);
  end;

begin
  FTimerId.Enabled := false;
{  if FAlarmList <> nil then FAlarmList.Free;
  if FSpecialDates.Count = 0 then exit;
  FAlarmList := TLMDDateList.Create;
  for i := 0 to FSpecialDates.Count - 1 do
    if FSpecialDates[i].Dates.Count <> 0 then
      if FSpecialDates[i].Alarm.Enabled then
        for j := 0 to FSpecialDates[i].Dates.Count-1 do
          with FSpecialDates[i] do
            FAlarmList.Add (Get (Dates[j], Alarm.Alarm, Alarm.OffsetDays,
                                                        Alarm.OffsetMonths,
                                                        Alarm.OffsetHours,
                                                        Alarm.OffsetMinutes));
  LMDApplication.Timer[FTimerId].Enabled := true;
  LMDApplication.Timer[FTimerId].Interval := 100;}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.DoOnTimer (Sender : TObject);
begin
  if FAlarmList = nil then
    begin
      FTimerId.Enabled := false;
      Exit;
    end;
{  d := Now;
  DecodeTime (d, hour, min, sec, msec);
  DecodeDate (d, year, month, day);
  d := EncodeDate (year, month, day) + EncodeTime (hour, min, 0, 0);
  if StrToDateTime (FAlarmList[0]) = d then
    begin
      FAlarmList.Delete (0);
    end;
  LMDApplication.Timer[FTimerId].Interval := 60000;}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomCalendar.GetChange (Sender : TObject);
var
  aRect: TRect;
begin
  if csLoading in ComponentState then exit; //RM
  if Sender is TLMDCalendarHeader then //added Aug 02, JH
  begin
    aRect := GetClientRect;
    AlignControls (nil, aRect);
    RePaint;
    exit;
  end;
  inherited GetChange (sender);
end;

{ ----------------------------------Datumsroutinen---------------------------- }
procedure CalcCelebrationDays(var table : TLMDDateList;Year : Word);
CONST
    Pfingsten = 50;
    Chr_Himmelfahrt = 40;

{ Berechnung des Osterfeiertages }
function EasterDate(Jahr : Word) : TDateTime;
var a, b, c, d, e, f, g, h, i, k, l, m, n, p : integer;

begin
   a := Jahr mod 19;
   b := Jahr div 100;
   c := Jahr mod 100;
   d := b div 4;
   e := b mod 4;
   f := (b+8) div 25;
   g := (b-f+1) div 3;
   h := (19*a+b-d-g+15) mod 30;
   i := c div 4;
   k := c mod 4;
   l := (32+2*e+2*i-h-k) mod 7;
   m := (a+11*h+22*1) div 451;
   n := (h+l-7*m+114) div 31;
   p := (h+l-7*m+114) mod 31;
   Result := EncodeDate (Jahr,n,p+1);
end; { Ende Procedure Osterdatum }

{ Berechnung des Buß- und Bettages }
function Buss_Bettag(Jahr : Word) : TDateTime;
VAR
  found : byte;
  Date : TDateTime;
begin
  Date := EncodeDate (Jahr, 12,25);
  found := 0;
  repeat
   Date := Date - 1;
   IF DayOfWeek (Date) = 1 Then INC(found); { Sunday }
  until found = 5;
  Result := Date - 4;
end; { Ende Procedure Buss- und Bettag }

{ Berechnen des Fronleichnamdatums }
function fronleichnam(datum : TDateTime) : TDateTime;
var
  found : byte;
begin
  found := 0;
  repeat
   If DayOfWeek(datum) = 5 Then { Thursday }
     INC(found);
   If found <> 2 then
     datum := datum + 1; { next day }
  until found = 2;
  result := datum;
end; { Ende procedure Fronleichnam}

//var
  //date : TLMDDateListRecord;

begin
{  New (date);}

{  date.date := Trunc(EncodeDate (Year,1,1));
  date.DateString := 'Neujahr';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(EasterDate (Year)-48);
  date.DateString := 'Rosenmontag';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(EasterDate (Year)-47);
  date.DateString := 'Fastnacht';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(EasterDate (Year)-2);
  date.DateString := 'Karfreitag';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(EasterDate (Year));
  date.DateString := 'Ostersonntag';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(EasterDate (Year)+1);
  date.DateString := 'Ostermontag';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(EasterDate (Year) + Chr_Himmelfahrt-1);
  date.DateString := 'Christi Himmelfahrt';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(EasterDate (Year) + Pfingsten-1);
  date.DateString := 'Pfingstsonntag';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(EasterDate (Year) + Pfingsten);
  date.DateString := 'Pfingstmontag';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(Fronleichnam(EasterDate (Year) + Pfingsten));
  date.DateString := 'Fronleichnam';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(Buss_Bettag (Year));
  date.DateString := 'Buß und Bettag';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(EncodeDate (Year,1,6));
  date.DateString := 'Heilige 3 Könige';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(EncodeDate (Year,5,1));
  date.DateString := 'Tag der Arbeit';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(EncodeDate (Year,10,3));
  date.DateString := 'Tag der deutschen Einheit';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(EncodeDate (Year,11,1));
  date.DateString := 'Allerheiligen';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(EncodeDate (Year,12,24));
  date.DateString := 'Heilig Abend';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(EncodeDate (Year,12,25));
  date.DateString := '1. Weihnachten';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(EncodeDate (Year,12,26));
  date.DateString := '2. Weihnachten';
  date. active := true;
  table.adddate (date);

  date.date := Trunc(EncodeDate (Year,12,31));
  date.DateString := 'Sylvester';
  date. active := true;
  table.adddate (date);}

{  Dispose (date);}
end;

end.
