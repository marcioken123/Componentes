unit IWBS4Input;

interface
{$Include IWBootstrap4.inc}

uses
  SysUtils, Classes, DB, StrUtils, Controls, IWAppForm, IWControl,
  IWRenderContext, IWRegion, IWHTMLTag, IWBS4CommonInterfaces, IWBS4Moab,
  IWBaseHTMLControl, IWApplication, IWBS4Common, IWBS4CustomInput,
  IWBS4InputTypes, IWBS4Region, IWTypes, DateUtils, Math, clipbrd;

type
  {$include IWPlatformAttrib.inc}
  TIWBS4Input = class(TIWBS4CustomTextInput)
  private
    FDescribedBy: string;

  protected
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
  published
    property InputType default bs4itText;
    property DescribedBy: string read FDescribedBy write FDescribedBy;
  public
    constructor Create(AOwner: TComponent); override;
  end;

type
  TIWBS4DateCaleranSide = (bs4dcasBottom, bs4dcasTop, bs4dcasLeft, bs4dcasRight, bs4dcasCenter);

  TIWBS4DateCaleranRangeOrientation = (bs4dcroHorizontal, bs4dcroVertical);

const
  aIWBS4DateCaleranSide: array[bs4dcasBottom..bs4dcasCenter] of string = ('bottom', 'top', 'left', 'right', 'center');
  aIWBS4DateCaleranRangeOrientation: array[bs4dcroHorizontal..bs4dcroVertical] of string = ('horizontal', 'vertical');

type

  {$include IWPlatformAttrib.inc}
  TIWBS4DateCaleranInput = class(TIWBS4CustomTextInput)
  private
    FDescribedBy: string;

    FApplyLabel: string;
    FArrowOn: TIWBS4DateCaleranSide;
    FAutoAlign: Boolean;
    FAutoCloseOnSelect: Boolean;
    FCalendarCount: Integer;
    FCancelLabel: string;
    FContinuous: Boolean;
    FDateFrom: TDateTime;
    FDateMax: TDateTime;
    FDateMin: TDateTime;
    FDateSeperator: string;
    FDateTo: TDateTime;
    FDisableOnlyEnd: Boolean;
    FDisableOnlyStart: Boolean;
    FEnableKeyboard: Boolean;
    FEnableMonthSwitcher: Boolean;
    FEnableSwipe: Boolean;
    FEnableYearSwitcher: Boolean;
    FHideOutOfRange: Boolean;
    FIconImageURL: string;
    FInlineCalendar: Boolean;
    FIsHotelBooking: Boolean;
    FMinSelectedDays: Integer;
    FMonthSwitcherFormat: string;
    FNumericMonthSwitcher: Boolean;
    FOneCalendarWidth: Integer;
    FRangeLabel: string;
    FRangeOrientation: TIWBS4DateCaleranRangeOrientation;
    FShowButtons: Boolean;
    FShowFooter: Boolean;
    FShowHeader: Boolean;
    FShowOn: TIWBS4DateCaleranSide;
    FShowWeekNumbers: Boolean;
    FSingleDate: Boolean;
    FStartOnMonday: Boolean;
    FStartEmpty: Boolean;
    FVerticalRangeWidth: Integer;

    FOnCallbackAfterHide: TIWAsyncEvent;
    FOnCallbackAfterMonthChange: TIWAsyncEvent;
    FOnCallbackAfterYearChange: TIWAsyncEvent;
    FOnCallbackAfterSelect: TIWAsyncEvent;
    FOnCallbackAfterShow: TIWAsyncEvent;
    FOnCallbackBeforeDestroy: TIWAsyncEvent;
    FOnCallbackBeforeHide: TIWAsyncEvent;
    FOnCallbackBeforeInit: TIWAsyncEvent;
    FOnCallbackBeforeMonthChange: TIWAsyncEvent;
    FOnCallbackBeforeSelect: TIWAsyncEvent;
    FOnCallbackBeforeShow: TIWAsyncEvent;
    FOnCallbackDraw: TIWAsyncEvent;
    FOnCallbackFirstSelect: TIWAsyncEvent;
    FOnCallbackInit: TIWAsyncEvent;
    FOnCallbackRangeSelect: TIWAsyncEvent;

    procedure CheckDates;
    procedure DoOnCallbackAfterHide(AParams: TStringList);
    procedure DoOnCallbackAfterMonthChange(AParams: TStringList);
    procedure DoOnCallbackAfterYearChange(AParams: TStringList);
    procedure DoOnCallbackAfterSelect(AParams: TStringList);
    procedure DoOnCallbackAfterShow(AParams: TStringList);
    procedure DoOnCallbackBeforeDestroy(AParams: TStringList);
    procedure DoOnCallbackBeforeHide(AParams: TStringList);
    procedure DoOnCallbackBeforeInit(AParams: TStringList);
    procedure DoOnCallbackBeforeMonthChange(AParams: TStringList);
    procedure DoOnCallbackBeforeSelect(AParams: TStringList);
    procedure DoOnCallbackBeforeShow(AParams: TStringList);
    procedure DoOnCallbackDraw(AParams: TStringList);
    procedure DoOnCallbackFirstSelect(AParams: TStringList);
    procedure DoOnCallbackInit(AParams: TStringList);
    procedure DoOnCallbackRangeSelect(AParams: TStringList);

    procedure SetApplyLabel(strLabel: string);
    procedure SetArrowOn(nSide: TIWBS4DateCaleranSide);
    procedure SetAutoAlign(bAlign: Boolean);
    procedure SetAutoCloseOnSelect(bAutoClose: Boolean);
    procedure SetCalendarCount(nCount: Integer);
    procedure SetCancelLabel(strCaption: string);
    procedure SetContinuous(bContinuous: Boolean);
    procedure SetDateFrom(nDate: TDateTime);
    procedure SetDateMax(nDate: TDateTime);
    procedure SetDateMin(nDate: TDateTime);
    procedure SetDateSeperator(strSeperator: string);
    procedure SetDateTo(nDate: TDateTime);
    procedure SetDisableOnlyEnd(bDisable: Boolean);
    procedure SetDisableOnlyStart(bDisable: Boolean);
    procedure SetEnableKeyboard(bEnable: Boolean);
    procedure SetEnableMonthSwitcher(bEnable: Boolean);
    procedure SetEnableSwipe(bEnable: Boolean);
    procedure SetEnableYearSwitcher(bEnable: Boolean);
    procedure SetHideOutOfRange(bHide: Boolean);
    procedure SetIconImageURL(strURL: string);
    procedure SetInlineCalendar(bInline: Boolean);
    procedure SetIsHotelBooking(bHotelBooking: Boolean);
    procedure SetMinSelectedDays(nCount: Integer);
    procedure SetMonthSwitcherFormat(strFormat: string);
    procedure SetNumericMonthSwitcher(bNumericMonth: Boolean);
    procedure SetOneCalendarWidth(nCalendarWidth: Integer);
    procedure SetRangeLabel(strLabel: string);
    procedure SetRangeOrientation(nOrientation: TIWBS4DateCaleranRangeOrientation);
    procedure SetShowButtons(bShow: Boolean);
    procedure SetShowFooter(bShow: Boolean);
    procedure SetShowHeader(bShow: Boolean);
    procedure SetShowOn(nSide: TIWBS4DateCaleranSide);
    procedure SetShowWeekNumbers(bShow: Boolean);
    procedure SetSingleDate(bShow: Boolean);
    procedure SetStartOnMonday(bStartOnMonday: Boolean);
    procedure SetStartEmpty(bStartEmpty: Boolean);
    procedure SetVerticalRangeWidth(nWidth: Integer);

    procedure UpdateDatesText;

  protected
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); override;
  published
    property DescribedBy: string read FDescribedBy write FDescribedBy;

    property ApplyLabel: string read FApplyLabel write SetApplyLabel;
    property ArrowOn: TIWBS4DateCaleranSide read FArrowOn write SetArrowOn default bs4dcasLeft;
    property AutoAlign: Boolean read FAutoAlign write SetAutoAlign default true;
    property AutoCloseOnSelect: Boolean read FAutoCloseOnSelect write SetAutoCloseOnSelect default false;
    property CalendarCount: Integer read FCalendarCount write SetCalendarCount default 1;
    property CancelLabel: string read FCancelLabel write SetCancelLabel;
    property Continuous: Boolean read FContinuous write SetContinuous default false;
    property DateFrom: TDateTime read FDateFrom write SetDateFrom;
    property DateMax: TDateTime read FDateMax write SetDateMax;
    property DateMin: TDateTime read FDateMin write SetDateMin;
    property DateSeperator: string read FDateSeperator write SetDateSeperator;
    property DateTo: TDateTime read FDateTo write SetDateTo;
    property DisableOnlyEnd: Boolean read FDisableOnlyEnd write SetDisableOnlyEnd default false;
    property DisableOnlyStart: Boolean read FDisableOnlyStart write SetDisableOnlyStart default false;
    property EnableKeyboard: Boolean read FEnableKeyboard write SetEnableKeyboard default true;
    property EnableMonthSwitcher: Boolean read FEnableMonthSwitcher write SetEnableMonthSwitcher default true;
    property EnableSwipe: Boolean read FEnableSwipe write SetEnableSwipe default true;
    property EnableYearSwitcher: Boolean read FEnableYearSwitcher write SetEnableYearSwitcher default true;
    property HideOutOfRange: Boolean read FHideOutOfRange write SetHideOutOfRange default true;
    property IconImageURL: string read FIconImageURL write SetIconImageURL;
    property InlineCalendar: Boolean read FInlineCalendar write SetInlineCalendar default false;
    property IsHotelBooking: Boolean read FIsHotelBooking write SetIsHotelBooking default false;
    property MinSelectedDays: Integer read FMinSelectedDays write SetMinSelectedDays default 0;
    property MonthSwitcherFormat: string read FMonthSwitcherFormat write SetMonthSwitcherFormat;
    property NumericMonthSwitcher: Boolean read FNumericMonthSwitcher write SetNumericMonthSwitcher default false;
    property OnCallbackAfterHide: TIWAsyncEvent read FOnCallbackAfterHide write FOnCallbackAfterHide default nil;
    property OnCallbackAfterMonthChange: TIWAsyncEvent read FOnCallbackAfterMonthChange write FOnCallbackAfterMonthChange default nil;
    property OnCallbackAfterYearChange: TIWAsyncEvent read FOnCallbackAfterYearChange write FOnCallbackAfterYearChange default nil;
    property OnCallbackAfterSelect: TIWAsyncEvent read FOnCallbackAfterSelect write FOnCallbackAfterSelect default nil;
    property OnCallbackAfterShow: TIWAsyncEvent read FOnCallbackAfterShow write FOnCallbackAfterShow default nil;
    property OnCallbackBeforeDestroy: TIWAsyncEvent read FOnCallbackBeforeDestroy write FOnCallbackBeforeDestroy default nil;
    property OnCallbackBeforeHide: TIWAsyncEvent read FOnCallbackBeforeHide write FOnCallbackBeforeHide default nil;
    property OnCallbackBeforeInit: TIWAsyncEvent read FOnCallbackBeforeInit write FOnCallbackBeforeInit default nil;
    property OnCallbackBeforeMonthChange: TIWAsyncEvent read FOnCallbackBeforeMonthChange write FOnCallbackBeforeMonthChange default nil;
    property OnCallbackBeforeSelect: TIWAsyncEvent read FOnCallbackBeforeSelect write FOnCallbackBeforeSelect default nil;
    property OnCallbackBeforeShow: TIWAsyncEvent read FOnCallbackBeforeShow write FOnCallbackBeforeShow default nil;
    property OnCallbackDraw: TIWAsyncEvent read FOnCallbackDraw write FOnCallbackDraw default nil;
    property OnCallbackFirstSelect: TIWAsyncEvent read FOnCallbackFirstSelect write FOnCallbackFirstSelect default nil;
    property OnCallbackInit: TIWAsyncEvent read FOnCallbackInit write FOnCallbackInit default nil;
    property OnCallbackRangeSelect: TIWAsyncEvent read FOnCallbackRangeSelect write FOnCallbackRangeSelect default nil;
    property OneCalendarWidth: Integer read FOneCalendarWidth write SetOneCalendarWidth default 230;
    property RangeLabel: string read FRangeLabel write SetRangeLabel;
    property RangeOrientation: TIWBS4DateCaleranRangeOrientation read FRangeOrientation write SetRangeOrientation default bs4dcroHorizontal;
    property ShowButtons: Boolean read FShowButtons write SetShowButtons default true;
    property ShowFooter: Boolean read FShowFooter write SetShowFooter default true;
    property ShowHeader: Boolean read FShowHeader write SetShowHeader default true;
    property ShowOn: TIWBS4DateCaleranSide read FShowOn write SetShowOn default bs4dcasBottom;
    property ShowWeekNumbers: Boolean read FShowWeekNumbers write SetShowWeekNumbers default false;
    property SingleDate: Boolean read FSingleDate write SetSingleDate default true;
    property StartOnMonday: Boolean read FStartOnMonday write SetStartOnMonday;
    property StartEmpty: Boolean read FStartEmpty write SetStartEmpty default false;
    property VerticalRangeWidth: Integer read FVerticalRangeWidth write SetVerticalRangeWidth default 150;

  public
    constructor Create(AOwner: TComponent); override;
  end;

  {$include IWPlatformAttrib.inc}
  TIWBS4Memo = class(TIWBS4CustomTextInput)
  private
    FLines: TStringList;
    FResizeDirection: TIWBS4ResizeDirection;
    FRows: Integer;
    FVertScrollBar: Boolean;
    procedure OnLinesChange(ASender: TObject);
    procedure SetLines(const AValue: TStringList);
  protected
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: Boolean); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure InternalRenderStyle(AStyle: TStringList); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetText(const AValue: TCaption); override;
  published
    property Lines: TStringList read FLines write SetLines;
    property ResizeDirection: TIWBS4ResizeDirection read FResizeDirection write FResizeDirection default bs4rdDefault;
    property Rows: Integer read FRows write FRows default 5;
    property VertScrollBar: Boolean read FVertScrollBar write FVertScrollBar default True;
  end;

type
  TIWBS4CheckBoxType = (bs4cbtDefault, bs4cbtFancy, bs4cbtSwitch);

  {$include IWPlatformAttrib.inc}
  TIWBS4CheckBox = class(TIWBS4CustomInput)
  private
    FCheckBoxType: TIWBS4CheckBoxType;
    FChecked: Boolean;
    FValueChecked: string;
    FValueUnchecked: string;
    FDataTarget: TIWCustomRegion;  // do not use interfaces here!!!
    FDataTargetRegion: TIWBS4Region;
    FDataTargetMoab: TIWBS4Moab;
  protected
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: Boolean); override;
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure SetCheckBoxType(AValue: TIWBS4CheckBoxType);
    procedure SetChecked(AValue: Boolean);
    procedure SetDataTarget(const Value: TIWCustomRegion);
    procedure SetDataTargetRegion(const Value: TIWBS4Region);
    procedure SetDataTargetMoab(const Value: TIWBS4Moab);
    procedure SetName(const AValue: TComponentName); override;
  public
    procedure SetText(const AValue: TCaption); override;
  published
    constructor Create(AOwner: TComponent); override;
    property CheckBoxType: TIWBS4CheckBoxType read FCheckBoxType write SetCheckBoxType default bs4cbtDefault;
    property Checked: Boolean read FChecked write SetChecked default False;
    property DataTarget: TIWCustomRegion read FDataTarget write SetDataTarget;
    property DataTargetRegion: TIWBS4Region read FDataTargetRegion write SetDataTargetRegion;
    property DataTargetMoab: TIWBS4Moab read FDataTargetMoab write SetDataTargetMoab;
    property ValueChecked: string read FValueChecked write FValueChecked;
    property ValueUnchecked: string read FValueUnchecked write FValueUnchecked;
  end;

  {$include IWPlatformAttrib.inc}
  TIWBS4RadioButton = class(TIWBS4CustomInput)
  private
    FChecked: Boolean;
    FGroup: string;
    FSaveUnchecked: Boolean;
    FValueChecked: string;
    FValueUnchecked: string;
  protected
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: Boolean); override;
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure SetChecked(AValue: Boolean);
    procedure SetName(const AValue: TComponentName); override;
    function InputSuffix: string; override;
  public
    procedure SetText(const AValue: TCaption); override;
  published
    constructor Create(AOwner: TComponent); override;
    property Checked: Boolean read FChecked write SetChecked default False;
    property SaveUnchecked: Boolean read FSaveUnchecked write FSaveUnchecked default True;
    property Group: string read FGroup write FGroup;
    property ValueChecked: string read FValueChecked write FValueChecked;
    property ValueUnchecked: string read FValueUnchecked write FValueUnchecked;
  end;

type
  TIWBS4RangeSliderHandleCount = (bs4rshcSingle, bs4rshcDouble);

  TIWBS4RangeSliderSkin = (bs4rssFlat, bs4rssBig, bs4rssModern, bs4rssSharp, bs4rssRound, bs4rssSquare);

  TIWBS4RangeSliderType = (bs4rstCalendar, bs4rstTimeDuration, bs4rstUser);

const
  aIWBS4RangeSliderHandleCount: array[bs4rshcSingle..bs4rshcDouble] of string = ('single', 'double');
  aIWBS4RangeSliderSkin: array[bs4rssFlat..bs4rssSquare] of string = ('flat', 'big', 'modern', 'sharp', 'round', 'square');

type

  {$include IWPlatformAttrib.inc}
  TIWBS4RangeSliderInput = class(TIWBS4CustomTextInput)
  private
    FDescribedBy: string;

    FBasicAllowKeyboard: boolean;
    FBasicFromValue: double;
    FBasicMaxValue: double;
    FBasicMinValue: double;
    FBasicStepValue: double;
    FBasicToValue: double;

    FCalendarDateMax: TDateTime;
    FCalendarDateMin: TDateTime;
    FCalendarDateFrom: TDateTime;
    FCalendarDateTo: TDateTime;

    FDataDisabled: boolean;
    FDataInputValuesSeparator: string;

    FGridEnabled: boolean;
    FGridMargin: boolean;
    FGridNumberOfUnits: double;
    FGridSnap: boolean;

    FHandleCount: TIWBS4RangeSliderHandleCount;
    FHandleFromFixed: boolean;
    FHandleFromMaxValue: double;
    FHandleFromMinValue: double;
    FHandleFromShadow: boolean;
    FHandleToFixed: boolean;
    FHandleToMaxValue: double;
    FHandleToMinValue: double;
    FHandleToShadow: boolean;

    FIntervalDrag: boolean;
    FIntervalMax: double;
    FIntervalMin: double;

    FOnCallbackChange: TIWAsyncEvent;
    FOnCallbackFinish: TIWAsyncEvent;
    FOnCallbackStart: TIWAsyncEvent;
    FOnCallbackUpdate: TIWAsyncEvent;

    FPrettifyDecorateBothValues: boolean;
    FPrettifyEnabled: boolean;
    FPrettifyMaxPostfix: string;
    FPrettifyPostfix: string;
    FPrettifyPrefix: string;
    FPrettifySeparator: string;
    FPrettifyValuesSeparator: string;

    FSliderType: TIWBS4RangeSliderType;

    FUIBLock: boolean;
    FUIForceEdges: boolean;
    FUIHideFromToLabels: boolean;
    FUIHideMinMaxLabels: boolean;
    FUILock: boolean;
    FUISkin: TIWBS4RangeSliderSkin;

    procedure CheckCalendarDates;

    procedure DoOnCallbackChange(AParams: TStringList);
    procedure DoOnCallbackFinish(AParams: TStringList);
    procedure DoOnCallbackStart(AParams: TStringList);
    procedure DoOnCallbackUpdate(AParams: TStringList);

    procedure SetDataDisabled(bDisabled: boolean);
    procedure SetDataInputValuesSeparator(strSeparator: string);

    procedure SetBasicFromValue(fValue: double);
    procedure SetBasicMaxValue(fMaxValue: double);
    procedure SetBasicMinValue(fMinValue: double);
    procedure SetBasicStepValue(fStepValue: double);
    procedure SetBasicToValue(fToValue: double);

    procedure SetCalendarDateFrom(nDate: TDateTime);
    procedure SetCalendarDateMax(nDate: TDateTime);
    procedure SetCalendarDateMin(nDate: TDateTime);
    procedure SetCalendarDateTo(nDate: TDateTime);

    procedure SetGridEnabled(bEnabled: boolean);
    procedure SetGridMargin(bMargin: boolean);
    procedure SetGridNumberOfUnits(fNumberOfUnits: double);
    procedure SetGridSnap(bSnap: boolean);

    procedure SetHandleCount(nType: TIWBS4RangeSliderHandleCount);
    procedure SetHandleFromFixed(bFixed: boolean);
    procedure SetHandleFromMaxValue(fMaxValue: double);
    procedure SetHandleFromMinValue(fMinValue: double);
    procedure SetHandleFromShadow(bShadow: boolean);
    procedure SetHandleToFixed(bFixed: boolean);
    procedure SetHandleToMaxValue(fMaxValue: double);
    procedure SetHandleToMinValue(fMinValue: double);
    procedure SetHandleToShadow(bShadow: boolean);

    procedure SetIntervalDrag(bDrag: boolean);
    procedure SetIntervalMax(fMax: double);
    procedure SetIntervalMin(fMin: double);

    procedure SetPrettifyDecorateBothValues(bBothValues: boolean);
    procedure SetPrettifyEnabled(bEnabled: boolean);
    procedure SetPrettifyMaxPostfix(strPostfix: string);
    procedure SetPrettifyPostfix(strPostfix: string);
    procedure SetPrettifyPrefix(strPrefix: string);
    procedure SetPrettifySeparator(strSeparator: string);
    procedure SetPrettifyValuesSeparator(strSeparator: string);

    procedure SetSliderType(nType: TIWBS4RangeSliderType);

    procedure SetUIBlock(bBlock: boolean);
    procedure SetUIForceEdges(bForceEdges: boolean);
    procedure SetUIHideFromToLabels(bHide: boolean);
    procedure SetUIHideMinMaxLabels(bHide: boolean);
    procedure SetUILock(bLock: boolean);
    procedure SetUISkin(nSkin: TIWBS4RangeSliderSkin);

    procedure UpdateValuesFromCallback(AParams: TStringList);

  protected
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); override;
  published
    property DescribedBy: string read FDescribedBy write FDescribedBy;

    property BasicAllowKeyboard: boolean read FBasicAllowKeyboard write FBasicAllowKeyboard default True;
    property BasicFromValue: double read FBasicFromValue write SetBasicFromValue;
    property BasicMaxValue: double read FBasicMaxValue write SetBasicMaxValue;
    property BasicMinValue: double read FBasicMinValue write SetBasicMinValue;
    property BasicStepValue: double read FBasicStepValue write SetBasicStepValue;
    property BasicToValue: double read FBasicToValue write SetBasicToValue;

    property CalendarDateMax: TDateTime read FCalendarDateMax write SetCalendarDateMax;
    property CalendarDateMin: TDateTime read FCalendarDateMin write SetCalendarDateMin;
    property CalendarDateFrom: TDateTime read FCalendarDateFrom write SetCalendarDateFrom;
    property CalendarDateTo: TDateTime read FCalendarDateTo write SetCalendarDateTo;

    property DataDisabled: boolean read FDataDisabled write SetDataDisabled default False;
    property DataInputValuesSeparator: string read FDataInputValuesSeparator write SetDataInputValuesSeparator;

    property GridEnabled: boolean read FGridEnabled write SetGridEnabled default False;
    property GridMargin: boolean read FGridMargin write SetGridMargin default True;
    property GridNumberOfUnits: double read FGridNumberOfUnits write SetGridNumberOfUnits;
    property GridSnap: boolean read FGridSnap write SetGridSnap default False;

    property HandleCount: TIWBS4RangeSliderHandleCount read FHandleCount write SetHandleCount default bs4rshcSingle;
    property HandleFromFixed: boolean read FHandleFromFixed write SetHandleFromFixed default False;
    property HandleFromMaxValue: double read FHandleFromMaxValue write SetHandleFromMaxValue;
    property HandleFromMinValue: double read FHandleFromMinValue write SetHandleFromMinValue;
    property HandleFromShadow: boolean read FHandleFromShadow write SetHandleFromShadow default True;
    property HandleToFixed: boolean read FHandleToFixed write SetHandleToFixed default False;
    property HandleToMaxValue: double read FHandleToMaxValue write SetHandleToMaxValue;
    property HandleToMinValue: double read FHandleToMinValue write SetHandleToMinValue;
    property HandleToShadow: boolean read FHandleToShadow write SetHandleToShadow default True;

    property IntervalDrag: boolean read FIntervalDrag write SetIntervalDrag default True;
    property IntervalMax: double read FIntervalMax write SetIntervalMax;
    property IntervalMin: double read FIntervalMin write SetIntervalMin;

    property OnCallbackChange: TIWAsyncEvent read FOnCallbackChange write FOnCallbackChange default nil;
    property OnCallbackFinish: TIWAsyncEvent read FOnCallbackFinish write FOnCallbackFinish default nil;
    property OnCallbackStart: TIWAsyncEvent read FOnCallbackStart write FOnCallbackStart default nil;
    property OnCallbackUpdate: TIWAsyncEvent read FOnCallbackUpdate write FOnCallbackUpdate default nil;

    property PrettifyDecorateBothValues: boolean read FPrettifyDecorateBothValues write SetPrettifyDecorateBothValues default True;
    property PrettifyEnabled: boolean read FPrettifyEnabled write SetPrettifyEnabled default True;
    property PrettifyMaxPostfix: string read FPrettifyMaxPostfix write SetPrettifyMaxPostfix;
    property PrettifyPostfix: string read FPrettifyPostfix write SetPrettifyPostfix;
    property PrettifyPrefix: string read FPrettifyPrefix write SetPrettifyPrefix;
    property PrettifySeparator: string read FPrettifySeparator write SetPrettifySeparator;
    property PrettifyValuesSeparator: string read FPrettifyValuesSeparator write SetPrettifyValuesSeparator;

    property SliderType: TIWBS4RangeSliderType read FSliderType write SetSliderType default bs4rstUser;

    property UIBlock: boolean read FUIBlock write SetUIBlock default False;
    property UIForceEdges: boolean read FUIForceEdges write SetUIForceEdges default False;
    property UIHideFromToLabels: boolean read FUIHideFromToLabels write SetUIHideFromToLabels default False;
    property UIHideMinMaxLabels: boolean read FUIHideMinMaxLabels write SetUIHideMinMaxLabels default False;
    property UILock: boolean read FUILock write SetUILock default False;
    property UISkin: TIWBS4RangeSliderSkin read FUISkin write SetUISkin default bs4rssBig;

  public
    constructor Create(AOwner: TComponent); override;
  end;

type
  TIWBS4SelectedTextFormat = (bs4stfValues, bs4stfStatic, bs4stfCount, bs4stfCountGtX);

const
  aIWBS4SelectedTextFormat: array[bs4stfValues..bs4stfCountGtX] of string = ('values', 'static', 'count', 'count > x');

type

  {$include IWPlatformAttrib.inc}
  TIWBS4Select = class(TIWBS4CustomSelectInput)
  private
    //FDeselectAllButtonCaption : string;
    FDropDownWidth: string;
    FItemsSelected: array of Boolean;
    //FMaxSelectedItemsCount    : Integer;
    FMultiSelect: Boolean;
    //FNoneSelectedText         : string;
    //FSelectAllButtonCaption   : string;
    //FSelectedTextFormat       : TIWBS4SelectedTextFormat;
    //FSelectedTextFormatCount  : Integer;
    FShowActionsPanel: Boolean;
    FShowTick: Boolean;
    FSize: Integer;
    FTitle: string;
    procedure ResetItemsSelected;
    procedure SetSize(AValue: Integer);
    //procedure SetSelectedTextFormatCount(AValue : Integer);
  protected
    function GetIndexesOfItemsSelected: string;
    function GetValuesOfItemsSelected: string;
    procedure InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: Boolean); override;
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    procedure OnItemsChange(ASender: TObject); override;
    procedure SetItemIndex(AValue: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SelectItemsByValues(const AValues: string; const ADelimiter: string);
    procedure SetText(const AValue: TCaption); override;
  published
    //property DeselectAllButtonCaption : string read FDeselectAllButtonCaption write FDeselectAllButtonCaption;
    //property DropDownWidth : string read FDropDownWidth write FDropDownWidth;
    //property MaxSelectedItemsCount : Integer read FMaxSelectedItemsCount write FMaxSelectedItemsCount default 0;
    property MultiSelect: Boolean read FMultiSelect write FMultiSelect default False;
    //property NoneSelectedText : string read FNoneSelectedText  write FNoneSelectedText;
    //property SelectAllButtonCaption : string read FSelectAllButtonCaption write FSelectAllButtonCaption;
    //property SelectedTextFormat : TIWBS4SelectedTextFormat read FSelectedTextFormat write FSelectedTextFormat default bs4stfValues;
    //property SelectedTextFormatCount : Integer read FSelectedTextFormatCount write SetSelectedTextFormatCount default 0;
    //property ShowActionsPanel : Boolean read FShowActionsPanel write FShowActionsPanel default False;
    //property ShowTick : Boolean read FShowTick write FShowTick default True;
    property Size: Integer read FSize write SetSize default 1;
    //property Title : string read FTitle write FTitle;
  public
    property IndexsOfItemsSelected: string read GetIndexesOfItemsSelected;
    property ValuesOfItemsSelected: string read GetValuesOfItemsSelected;
  end;

  {$include IWPlatformAttrib.inc}
  TIWBS4RadioGroup = class(TIWBS4CustomSelectInput)
  protected
    procedure InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication); override;
    procedure InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag); override;
    function InputSelector: string; override;
    function InputSuffix: string; override;
  end;

implementation

uses {$IFDEF  IW_14_3_0_UP}
  IW.Common.SysTools, {$ELSE} IW.Common.System, {$ENDIF}
  IWBS4InputCommon, IWBS4InputForm, IWBS4Utils;

{$region 'TIWBS4Input'}

constructor TIWBS4DateCaleranInput.Create(AOwner: TComponent);
begin
  inherited;

  Cursor := crHandPoint;
  InputType := bs4itText;
  ReadOnly := true;

  FApplyLabel := 'Apply';
  FArrowOn := bs4dcasLeft;
  FAutoAlign := true;
  FAutoCloseOnSelect := false;
  FCalendarCount := 1;
  FCancelLabel := 'Cancel';
  FContinuous := false;
  FDateFrom := Date();
  FDateMax := Date();
  FDateMin := Date();
  FDateSeperator := ' - ';
  FDateTo := Date();
  FDisableOnlyEnd := false;
  FDisableOnlyStart := false;
  FEnableKeyboard := true;
  FEnableMonthSwitcher := true;
  FEnableSwipe := true;
  FEnableYearSwitcher := true;
  FHideOutOfRange := true;
  FIconImageURL := '';
  FInlineCalendar := false;
  FIsHotelBooking := false;
  FMinSelectedDays := 0;
  FMonthSwitcherFormat := 'MMMM';
  FNumericMonthSwitcher := false;
  FOneCalendarWidth := 230;
  FRangeLabel := 'Date Options';
  FRangeOrientation := bs4dcroHorizontal;
  FShowButtons := true;
  FShowFooter := true;
  FShowHeader := true;
  FShowOn := bs4dcasBottom;
  FShowWeekNumbers := false;
  FSingleDate := true;
  FStartOnMonday := true;
  FStartEmpty := false;
  FVerticalRangeWidth := 150;

  FOnCallbackAfterHide := nil;
  FOnCallbackAfterMonthChange := nil;
  FOnCallbackAfterYearChange := nil;
  FOnCallbackAfterSelect := nil;
  FOnCallbackAfterShow := nil;
  FOnCallbackBeforeDestroy := nil;
  FOnCallbackBeforeHide := nil;
  FOnCallbackBeforeInit := nil;
  FOnCallbackBeforeMonthChange := nil;
  FOnCallbackBeforeSelect := nil;
  FOnCallbackBeforeShow := nil;
  FOnCallbackDraw := nil;
  FOnCallbackFirstSelect := nil;
  FOnCallbackInit := nil;
  FOnCallbackRangeSelect := nil;

end;

procedure TIWBS4DateCaleranInput.CheckDates;
begin
   // Check date from
  if (FDateFrom < FDateMin) then
  begin
    FDateFrom := FDateMin;
  end
  else if (FDateFrom > FDateMax) then
  begin
    FDateFrom := FDateMax;
  end;

   // Check date to
  if (FDateTo < FDateMin) then
  begin
    FDateTo := FDateMin;
  end
  else if (FDateTo > FDateMax) then
  begin
    FDateTo := FDateMax;
  end;
end;

procedure TIWBS4DateCaleranInput.DoOnCallbackAfterHide(AParams: TStringList);
begin
  if (Assigned(FOnCallbackAfterHide) = true) then
  begin
    OnCallbackAfterHide(Self, AParams);
  end;
end;

procedure TIWBS4DateCaleranInput.DoOnCallbackAfterMonthChange(AParams: TStringList);
begin
  if (Assigned(FOnCallbackAfterMonthChange) = true) then
  begin
    OnCallbackAfterMonthChange(Self, AParams);
  end;
end;

procedure TIWBS4DateCaleranInput.DoOnCallbackAfterYearChange(AParams: TStringList);
begin
  if (Assigned(FOnCallbackAfterYearChange) = true) then
  begin
    OnCallbackAfterYearChange(Self, AParams);
  end;
end;

procedure TIWBS4DateCaleranInput.DoOnCallbackAfterSelect(AParams: TStringList);
begin
  // Update values
  FDateFrom := StrToDateDef(AParams.Values['DateFrom'], FDateFrom);
  FDateTo := StrToDateDef(AParams.Values['DateTo'], FDateTo);

  if (Assigned(FOnCallbackAfterSelect) = true) then
  begin
    OnCallbackAfterSelect(Self, AParams);
  end;

  if (Assigned(OnAsyncChange) = true) then
  begin
    OnAsyncChange(Self, AParams);
  end;
end;

procedure TIWBS4DateCaleranInput.DoOnCallbackAfterShow(AParams: TStringList);
begin
  if (Assigned(FOnCallbackAfterShow) = true) then
  begin
    OnCallbackAfterShow(Self, AParams);
  end;
end;

procedure TIWBS4DateCaleranInput.DoOnCallbackBeforeDestroy(AParams: TStringList);
begin
  if (Assigned(FOnCallbackBeforeDestroy) = true) then
  begin
    OnCallbackBeforeDestroy(Self, AParams);
  end;
end;

procedure TIWBS4DateCaleranInput.DoOnCallbackBeforeHide(AParams: TStringList);
begin
  if (Assigned(FOnCallbackBeforeHide) = true) then
  begin
    OnCallbackBeforeHide(Self, AParams);
  end;
end;

procedure TIWBS4DateCaleranInput.DoOnCallbackBeforeInit(AParams: TStringList);
begin
  if (Assigned(FOnCallbackBeforeInit) = true) then
  begin
    OnCallbackBeforeInit(Self, AParams);
  end;
end;

procedure TIWBS4DateCaleranInput.DoOnCallbackBeforeMonthChange(AParams: TStringList);
begin
  if (Assigned(FOnCallbackBeforeMonthChange) = true) then
  begin
    OnCallbackBeforeMonthChange(Self, AParams);
  end;
end;

procedure TIWBS4DateCaleranInput.DoOnCallbackBeforeSelect(AParams: TStringList);
begin
  if (Assigned(FOnCallbackBeforeSelect) = true) then
  begin
    OnCallbackBeforeSelect(Self, AParams);
  end;
end;

procedure TIWBS4DateCaleranInput.DoOnCallbackBeforeShow(AParams: TStringList);
begin
  if (Assigned(FOnCallbackBeforeShow) = true) then
  begin
    OnCallbackBeforeShow(Self, AParams);
  end;
end;

procedure TIWBS4DateCaleranInput.DoOnCallbackDraw(AParams: TStringList);
begin
  if (Assigned(FOnCallbackDraw) = true) then
  begin
    OnCallbackDraw(Self, AParams);
  end;
end;

procedure TIWBS4DateCaleranInput.DoOnCallbackFirstSelect(AParams: TStringList);
begin
  if (Assigned(FOnCallbackFirstSelect) = true) then
  begin
    OnCallbackFirstSelect(Self, AParams);
  end;
end;

procedure TIWBS4DateCaleranInput.DoOnCallbackInit(AParams: TStringList);
begin
  if (Assigned(FOnCallbackInit) = true) then
  begin
    OnCallbackInit(Self, AParams);
  end;
end;

procedure TIWBS4DateCaleranInput.DoOnCallbackRangeSelect(AParams: TStringList);
begin
  if (Assigned(FOnCallbackRangeSelect) = true) then
  begin
    OnCallbackRangeSelect(Self, AParams);
  end;
end;

procedure TIWBS4DateCaleranInput.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  AFeedbackTag: TIWHTMLTag;
begin
  inherited;

  if FIsStatic then
  begin
    // This is wrong, static do not render as <p>, if they ever did
    AHTMLTag := TIWHTMLTag.CreateTag('p');
    try
      AHTMLTag.AddClassParam(ActiveCss);
      AHTMLTag.AddStringParam('id', AHTMLName);
      AHTMLTag.AddStringParam('style', ActiveStyle);
      AHTMLTag.Contents.AddText(TextToHTML(FText));
    except
      FreeAndNil(AHTMLTag);
      raise;
    end;
  end
  else
  begin
    AHTMLTag := TIWHTMLTag.CreateTag('input');
    try
      AHTMLTag.AddStringParam('type', 'text');
      AHTMLTag.AddClassParam('caleran');
      AHTMLTag.AddClassParam(ActiveCss);
      AHTMLTag.AddStringParam('id', AHTMLName);
      AHTMLTag.AddStringParam('name', AHTMLName);

      if ShowHint and (Hint <> '') then
        AHTMLTag.AddStringParam('title', Hint);
      if AutoFocus then
        AHTMLTag.Add('autofocus');
      if IsReadOnly then
        AHTMLTag.Add('readonly');
      if IsDisabled then
        AHTMLTag.Add('disabled');
      if MaxLength > 0 then
        AHTMLTag.AddIntegerParam('maxlength', MaxLength);
      AHTMLTag.AddStringParam('value', TextToHTML(FText));

      if Required then
        AHTMLTag.Add('required');

      if PlaceHolder <> '' then
        AHTMLTag.AddStringParam('placeholder', TextToHTML(PlaceHolder));

      if TabIndex <> 0 then
        AHTMLTag.AddStringParam('tabindex', IntToStr(TabIndex));

      AHTMLTag.AddStringParam('style', ActiveStyle);

      if Required = True then
      begin
        if (ValidFeedback <> '') then
        begin
          AFeedbackTag := TIWHTMLTag.CreateTag('div');
          try
            AFeedbackTag.AddClassParam('valid-feedback');
            AFeedbackTag.Contents.AddText(TIWBaseHTMLControl.TextToHTML(ValidFeedback));
            AHTMLTag.Contents.AddTagAsObject(AFeedbackTag);
          except
            FreeAndNil(AFeedbackTag);
            raise;
          end;
        end;

        if (InvalidFeedback <> '') then
        begin
          AFeedbackTag := TIWHTMLTag.CreateTag('div');
          try
            AFeedbackTag.AddClassParam('invalid-feedback');
            AFeedbackTag.Contents.AddText(TIWBaseHTMLControl.TextToHTML(InvalidFeedback));
            AHTMLTag.Contents.AddTagAsObject(AFeedbackTag);
          except
            FreeAndNil(AFeedbackTag);
            raise;
          end;
        end;
      end;

    except
      FreeAndNil(AHTMLTag);
      raise;
    end;
  end;

{ if not (Parent is TIWBS4InputGroup) and (InputType <> bs4itHidden) then
  begin
    AHTMLTag := IWBS4CreateInputFormGroup(Self, Parent, AHTMLTag, Caption, AHTMLName);
  end;}
end;

procedure TIWBS4DateCaleranInput.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
var
  strJavaScriptObjectName: string;
begin
  inherited;

  AScript.Add('function FormatDate(date)');
  AScript.Add('{');
  AScript.Add('  var d = new Date(date),');
  AScript.Add('  month = "" + (d.getMonth() + 1),');
  AScript.Add('  day 	= "" + d.getDate(),');
  AScript.Add('  year	= "" + d.getFullYear();');
  AScript.Add('	if (month.length < 2)');
  AScript.Add('  {');
  AScript.Add('    month = "0" + month;');
  AScript.Add('  }');
  AScript.Add('  if (day.length < 2)');
  AScript.Add('  {');
  AScript.Add('    day = "0" + day;');
  AScript.Add('  }');
  AScript.Add('  return [month,day,year].join("/");');
  AScript.Add('}');

  if (True) then
  begin
    strJavaScriptObjectName := 'var' + AHTMLName;

    AScript.Add('var ' + strJavaScriptObjectName + '= null;');
  end;

  AScript.Add('$("#' + AHTMLName + '").caleran(');
  AScript.Add('{');

  AScript.Add(format('startDate: moment("%d/%d/%d","MM/DD/YYYY"),', [MonthOf(DateFrom), DayOf(DateFrom), YearOf(DateFrom)]));
  AScript.Add(format('endDate: moment("%d/%d/%d","MM/DD/YYYY"),', [MonthOf(DateTo), DayOf(DateTo), YearOf(DateTo)]));
  AScript.Add(format('minDate: moment("%d/%d/%d","MM/DD/YYYY"),', [MonthOf(DateMin), DayOf(DateMin), YearOf(DateMin)]));
  AScript.Add(format('maxDate: moment("%d/%d/%d","MM/DD/YYYY"),', [MonthOf(DateMax), DayOf(DateMax), YearOf(DateMax)]));
  AScript.Add('applyLabel: "' + ApplyLabel + '",');
  AScript.Add('arrowOn: "' + aIWBS4DateCaleranSide[ArrowOn] + '",');
  AScript.Add('autoAlign: ' + BoolToStr(AutoAlign, true) + ',');
  AScript.Add('autoCloseOnSelect: ' + BoolToStr(AutoCloseOnSelect, true) + ',');
  AScript.Add('calendarCount: ' + IntToStr(CalendarCount) + ',');
  AScript.Add('cancelLabel: "' + CancelLabel + '",');
  AScript.Add('continuous: ' + BoolToStr(Continuous, true) + ',');

   //disableDays: function(day)
   //{
   //  return day.day() != 3;
   //},
   //disableOnlyStart: false,
   //disabledRanges:
   //[
   //  { "start": moment("03/10/2019","MM/DD/YYYY"),"end": moment("03/18/2019", "MM/DD/YYYY") },
   //  { "start": moment("04/01/2019","MM/DD/YYYY"),"end": moment("04/05/2019", "MM/DD/YYYY") },
   //  { "start": moment("04/11/2019","MM/DD/YYYY"),"end": moment("04/15/2019", "MM/DD/YYYY") }
   //],

  AScript.Add('enableKeyboard: ' + BoolToStr(EnableKeyboard, true) + ',');
  AScript.Add('enableMonthSwitcher: ' + BoolToStr(EnableMonthSwitcher, true) + ',');
  AScript.Add('enableSwipe: ' + BoolToStr(EnableSwipe, true) + ',');
  AScript.Add('enableYearSwitcher: ' + BoolToStr(EnableYearSwitcher, true) + ',');
  AScript.Add('hideOutOfRange: ' + BoolToStr(HideOutOfRange, true) + ',');
  AScript.Add('inline: ' + BoolToStr(InlineCalendar, true) + ',');
  AScript.Add('isHotelBooking: ' + BoolToStr(IsHotelBooking, true) + ',');
  AScript.Add('minSelectedDays: ' + IntToStr(MinSelectedDays) + ',');
  AScript.Add('monthSwitcherFormat: "' + MonthSwitcherFormat + '",');
  AScript.Add('numericMonthSwitcher: ' + BoolToStr(NumericMonthSwitcher, true) + ',');

  if (OneCalendarWidth = 0) then
  begin
    AScript.Add('oneCalendarWidth: auto,');
  end
  else
  begin
    AScript.Add('oneCalendarWidth: ' + IntToStr(OneCalendarWidth) + ',');
  end;

  AScript.Add('rangeLabel: "' + RangeLabel + '",');
  AScript.Add('rangeOrientation: "' + aIWBS4DateCaleranRangeOrientation[RangeOrientation] + '",');
  AScript.Add('showButtons: ' + BoolToStr(ShowButtons, true) + ',');
  AScript.Add('showOn: "' + aIWBS4DateCaleranSide[ShowOn] + '",');
  AScript.Add('startEmpty: ' + BoolToStr(StartEmpty, true) + ',');
  AScript.Add('showFooter: ' + BoolToStr(ShowFooter, true) + ',');
  AScript.Add('showHeader: ' + BoolToStr(ShowHeader, true) + ',');
  AScript.Add('showWeekNumbers: ' + BoolToStr(ShowWeekNumbers, true) + ',');
  AScript.Add('singleDate: ' + BoolToStr(SingleDate, true) + ',');
  AScript.Add('startOnMonday: ' + BoolToStr(StartOnMonday, true) + ',');
   //target: $("#caleran-ex-11-target")},
  AScript.Add('verticalRangeWidth: ' + IntToStr(VerticalRangeWidth) + ',');

  if (Assigned(OnCallbackAfterHide) = true) then
  begin
    AScript.Add('onafterhide: function(caleran)');
    AScript.Add('{');
      //AScript.Add('   console.log("onafterhide()");');
    AScript.Add('   executeAjaxEvent(null,null,"' + AHTMLName + '.DoOnCallbackAfterHide",false, null, false);');
    AScript.Add('},');

    AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackAfterHide', DoOnCallbackAfterHide);
  end;

  if (Assigned(OnCallbackAfterMonthChange) = true) then
  begin
    AScript.Add('onaftermonthchange: function(caleran, month)');
    AScript.Add('{');
      //AScript.Add('   console.log("onaftermonthchange()");');
    AScript.Add('   executeAjaxEvent(null,null,"' + AHTMLName + '.DoOnCallbackAfterMonthChange",false, null, false);');
    AScript.Add('},');

    AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackAfterMonthChange', DoOnCallbackAfterMonthChange);
  end;

  AScript.Add('onafterselect: function(caleran, startDate, endDate)');
  AScript.Add('{');
  AScript.Add('   strValues = "&DateFrom=" + FormatDate(startDate._i) + "&DateTo=" + FormatDate(endDate._i);');
  //AScript.Add('   console.log("onafterselect() - " + strValues);');
  AScript.Add('   executeAjaxEvent(strValues, null,"' + AHTMLName + '.DoOnCallbackAfterSelect",false, null, false);');
  AScript.Add('},');

  AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackAfterSelect', DoOnCallbackAfterSelect);

  if (Assigned(OnCallbackAfterShow) = true) then
  begin
    AScript.Add('onaftershow: function(caleran)');
    AScript.Add('{');
      //AScript.Add('   console.log("onaftershow()");');
    AScript.Add('   executeAjaxEvent(null,null,"' + AHTMLName + '.DoOnCallbackAfterShow",false, null, false);');
    AScript.Add('},');

    AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackAfterShow', DoOnCallbackAfterShow);
  end;

  if (Assigned(OnCallbackAfterYearChange) = true) then
  begin
    AScript.Add('onafteryearchange: function(caleran, year)');
    AScript.Add('{');
      //AScript.Add('   console.log("onafteryearchange()");');
    AScript.Add('   executeAjaxEvent(null,null,"' + AHTMLName + '.DoOnCallbackAfterYearChange",false, null, false);');
    AScript.Add('},');

    AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackAfterYearChange', DoOnCallbackAfterYearChange);
  end;

  if (Assigned(OnCallbackBeforeDestroy) = true) then
  begin
    AScript.Add('onBeforeDestroy: function(caleran)');
    AScript.Add('{");');
      //AScript.Add('   console.log("onBeforeDestory()");');
    AScript.Add('   executeAjaxEvent(null,null,"' + AHTMLName + '.DoOnCallbackBeforeDestroy",false, null, false);');
    AScript.Add('   return true;');
    AScript.Add('},');
    AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackBeforeDestroy', DoOnCallbackBeforeDestroy);
  end;

  if (Assigned(OnCallbackBeforeHide) = true) then
  begin
    AScript.Add('onbeforehide: function(caleran)');
    AScript.Add('{');
      //AScript.Add('   console.log("onbeforehide()");');
    AScript.Add('   executeAjaxEvent(null,null,"' + AHTMLName + '.DoOnCallbackBeforeHide",false, null, false);');
    AScript.Add('},');

    AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackBeforeHide', DoOnCallbackBeforeHide);
  end;

  if (Assigned(OnCallbackBeforeInit) = true) then
  begin
    AScript.Add('onBeforeInit: function(caleran)');
    AScript.Add('{');
      //AScript.Add('   console.log("onBeforeInit()");');
    AScript.Add('   executeAjaxEvent(null,null,"' + AHTMLName + '.DoOnCallbackBeforeInit",false, null, false);');
    AScript.Add('},');
    AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackBeforeInit', DoOnCallbackBeforeInit);
  end;

  if (Assigned(OnCallbackBeforeMonthChange) = true) then
  begin
    AScript.Add('onbeforemonthchange: function(caleran, month, direction)');
    AScript.Add('{');
      //AScript.Add('  console.log("onbeforemonthchange()");');
    AScript.Add('  executeAjaxEvent(null,null,"' + AHTMLName + '.DoOnCallbackBeforeMonthChange",false, null, false);');
    AScript.Add('  return true;');
    AScript.Add('},');

    AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackBeforeMonthChange', DoOnCallbackBeforeMonthChange);
  end;

  if (Assigned(OnCallbackBeforeSelect) = true) then
  begin
    AScript.Add('onbeforeselect: function(caleran, startDate, endDate)');
    AScript.Add('{');
      //AScript.Add('   console.log("onbeforeselect()");');
    AScript.Add('   executeAjaxEvent(null,null,"' + AHTMLName + '.DoOnCallbackBeforeSelect",false, null, false);');
    AScript.Add('   return true;');
    AScript.Add('},');

    AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackBeforeSelect', DoOnCallbackBeforeSelect);
  end;

  if (Assigned(OnCallbackBeforeShow) = true) then
  begin
    AScript.Add('onbeforeshow: function(caleran)');
    AScript.Add('{');
      //AScript.Add('   console.log("onbeforeshow()");');
    AScript.Add('   executeAjaxEvent(null,null,"' + AHTMLName + '.DoOnCallbackBeforeShow",false, null, false);');
    AScript.Add('},');

    AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackBeforeShow', DoOnCallbackBeforeShow);
  end;

  if (Assigned(OnCallbackDraw) = true) then
  begin
    AScript.Add('ondraw: function(caleran)');
    AScript.Add('{');
      //AScript.Add('   console.log("ondraw()");');
      //AScript.Add('caleran.calendars.find(".caleran-disabled").css("background-color", "red");');
      //AScript.Add('caleran.calendars.find(".caleran-day").css("background-color", "green");');
    AScript.Add('   executeAjaxEvent(null,null,"' + AHTMLName + '.DoOnCallbackDraw",false, null, false);');
    AScript.Add('}');

    AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackDraw', DoOnCallbackDraw);
  end;

  if (Assigned(OnCallbackFirstSelect) = true) then
  begin
    AScript.Add('onfirstselect: function(elem,start)');
    AScript.Add('{');
      //AScript.Add('   console.log("onfirstselect()");');
    AScript.Add('   executeAjaxEvent(null,null,"' + AHTMLName + '.DoOnCallbackFirstSelect",false, null, false);');
    AScript.Add('//  elem.config.startDate      = moment(start).startOf("week");');
    AScript.Add('//  elem.config.endDate        = moment(start).endOf("week");');
    AScript.Add('//  elem.globals.endSelected   = true;');
    AScript.Add('//  elem.globals.startSelected = false;');
    AScript.Add('//  elem.globals.hoverDate     = null;');
    AScript.Add('//  elem.$elem.find( ".caleran-apply" ).removeAttr( "disabled");');
    AScript.Add('//  elem.updateInput();');
    AScript.Add('},');

    AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackFirstSelect', DoOnCallbackFirstSelect);
  end;

  AScript.Add('oninit: function(caleran)');
  AScript.Add('{');
   //AScript.Add('  console.log("oninit()");');
  if (True) then
  begin
    AScript.Add(strJavaScriptObjectName + '= caleran;');
  end;
  if (Assigned(OnCallbackInit) = true) then
  begin
    AScript.Add('  executeAjaxEvent(null,null,"' + AHTMLName + '.DoOnCallbackInit",false, null, false);');
    AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackInit', DoOnCallbackInit);
  end;
  AScript.Add('},');

  if ((Assigned(OnCallbackRangeSelect) = true)) then
  begin
    AScript.Add('onrangeselect: function(caleran, range)');
    AScript.Add('{');
      //AScript.Add('  console.log("onrangeselect()");');
    AScript.Add('  executeAjaxEvent(null,null,"' + AHTMLName + '.DoOnCallbackRangeSelect",false, null, false);');
    AScript.Add('},');

    AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackRangeSelect', DoOnCallbackRangeSelect);
  end;

  if (AScript.Strings[AScript.Count - 1] = '},') then
  begin
    AScript.Strings[AScript.Count - 1] := '}';
  end;

  AScript.Add('}');
  AScript.Add(');');

   // Convert True / False to lower case
  AScript.Text := ReplaceText(AScript.Text, 'False', 'false');
  AScript.Text := ReplaceText(AScript.Text, 'True', 'true');

   //Clipboard.AsText  := AScript.Text;
end;

procedure TIWBS4DateCaleranInput.SetApplyLabel(strLabel: string);
begin
  FApplyLabel := strLabel;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetArrowOn(nSide: TIWBS4DateCaleranSide);
begin
  FArrowOn := nSide;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetAutoAlign(bAlign: Boolean);
begin
  FAutoAlign := bAlign;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetAutoCloseOnSelect(bAutoClose: Boolean);
begin
  FAutoCloseOnSelect := bAutoClose;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetCalendarCount(nCount: Integer);
begin
  FCalendarCount := Min(nCount, 1);

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetCancelLabel(strCaption: string);
begin
  FCancelLabel := strCaption;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetContinuous(bContinuous: Boolean);
begin
  FContinuous := bContinuous;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetDateFrom(nDate: TDateTime);
begin
  FDateFrom := nDate;

  CheckDates;

  UpdateDatesText;
end;

procedure TIWBS4DateCaleranInput.SetDateMax(nDate: TDateTime);
begin
  FDateMax := nDate;

  if (FDateMin > nDate) then
  begin
    FDateMin := nDate;
  end;

  CheckDates;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetDateMin(nDate: TDateTime);
begin
  FDateMin := nDate;

  if (FDateMax < nDate) then
  begin
    FDateMax := nDate;
  end;

  CheckDates;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetDateSeperator(strSeperator: string);
begin
  FDateSeperator := strSeperator;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetDateTo(nDate: TDateTime);
begin
  FDateTo := nDate;

  CheckDates;

  UpdateDatesText;
end;

procedure TIWBS4DateCaleranInput.SetDisableOnlyEnd(bDisable: Boolean);
begin
  FDisableOnlyEnd := bDisable;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetDisableOnlyStart(bDisable: Boolean);
begin
  FDisableOnlyStart := bDisable;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetEnableKeyboard(bEnable: Boolean);
begin
  FEnableKeyboard := bEnable;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetEnableMonthSwitcher(bEnable: Boolean);
begin
  FEnableMonthSwitcher := bEnable;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetEnableSwipe(bEnable: Boolean);
begin
  FEnableSwipe := bEnable;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetEnableYearSwitcher(bEnable: Boolean);
begin
  FEnableYearSwitcher := bEnable;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetHideOutOfRange(bHide: Boolean);
begin
  FHideOutOfRange := bHide;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetIconImageURL(strURL: string);
var
  nStyleIndex: Integer;
  nPosIndex: Integer;
begin
  FIconImageURL := strURL;

   // Delete back-ground styles if already set
  for nStyleIndex := Style.Count - 1 downto 0 do
  begin
    nPosIndex := AnsiPos('background', Style[nStyleIndex]);
    if (nPosIndex > 0) then
    begin
      Style.Delete(nStyleIndex);
    end;
  end;

   // Add background styles if set
  if (FIconImageURL <> '') then
  begin
    Style.Add('background: white url(' + FIconImageURL + ') right center no-repeat;');
    Style.Add('background-origin: content-box;');
  end;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetInlineCalendar(bInline: Boolean);
begin
  FInlineCalendar := bInline;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetIsHotelBooking(bHotelBooking: Boolean);
begin
  FIsHotelBooking := bHotelBooking;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetMinSelectedDays(nCount: Integer);
begin
  FMinSelectedDays := 0;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetMonthSwitcherFormat(strFormat: string);
begin
  FMonthSwitcherFormat := strFormat;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetNumericMonthSwitcher(bNumericMonth: Boolean);
begin
  FNumericMonthSwitcher := bNumericMonth;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetOneCalendarWidth(nCalendarWidth: Integer);
begin
  FOneCalendarWidth := nCalendarWidth;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetRangeLabel(strLabel: string);
begin
  FRangeLabel := strLabel;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetRangeOrientation(nOrientation: TIWBS4DateCaleranRangeOrientation);
begin
  FRangeOrientation := nOrientation;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetShowButtons(bShow: Boolean);
begin
  FShowButtons := bShow;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetShowFooter(bShow: Boolean);
begin
  FShowFooter := bShow;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetShowHeader(bShow: Boolean);
begin
  FShowHeader := bShow;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetShowOn(nSide: TIWBS4DateCaleranSide);
begin
  FShowOn := nSide;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetShowWeekNumbers(bShow: Boolean);
begin
  FShowWeekNumbers := bShow;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetSingleDate(bShow: Boolean);
begin
  FSingleDate := bShow;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetStartOnMonday(bStartOnMonday: Boolean);
begin
  FStartOnMonday := bStartOnMonday;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetStartEmpty(bStartEmpty: Boolean);
begin
  FStartEmpty := bStartEmpty;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.SetVerticalRangeWidth(nWidth: Integer);
begin
  FVerticalRangeWidth := nWidth;

  Invalidate;
end;

procedure TIWBS4DateCaleranInput.UpdateDatesText;
begin
  Text := FormatDateTime('MM/DD/YYYY', DateFrom) + DateSeperator + FormatDateTime('MM/DD/YYYY', DateTo);
end;

{$endregion}

{$region 'TIWBS4Input'}

constructor TIWBS4Input.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TIWBS4Input.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  AFeedbackTag: TIWHTMLTag;
begin
  inherited;

  if FIsStatic then
  begin
    // This is wrong, static do not render as <p>, if they ever did
    AHTMLTag := TIWHTMLTag.CreateTag('p');
    try
      AHTMLTag.AddClassParam(ActiveCss);
      AHTMLTag.AddStringParam('id', AHTMLName);
      AHTMLTag.AddStringParam('style', ActiveStyle);
      AHTMLTag.Contents.AddText(TextToHTML(FText));
    except
      FreeAndNil(AHTMLTag);
      raise;
    end;
  end
  else
  begin
    AHTMLTag := TIWHTMLTag.CreateTag('input');
    try
      AHTMLTag.AddStringParam('type', aIWBS4InputType[InputType]);
      AHTMLTag.AddClassParam(ActiveCss);
      AHTMLTag.AddStringParam('id', AHTMLName);
      AHTMLTag.AddStringParam('name', AHTMLName);

      if ShowHint and (Hint <> '') then
        AHTMLTag.AddStringParam('title', Hint);
      if AutoFocus then
        AHTMLTag.Add('autofocus');
      if IsReadOnly then
        AHTMLTag.Add('readonly');
      if IsDisabled then
        AHTMLTag.Add('disabled');
      if MaxLength > 0 then
        AHTMLTag.AddIntegerParam('maxlength', MaxLength);
      AHTMLTag.AddStringParam('value', TextToHTML(FText));

      if Required then
        AHTMLTag.Add('required');
      if PlaceHolder <> '' then
        AHTMLTag.AddStringParam('placeholder', TextToHTML(PlaceHolder));
      if TabIndex <> 0 then
        AHTMLTag.AddStringParam('tabindex', IntToStr(TabIndex));
      AHTMLTag.AddStringParam('style', ActiveStyle);

      if Required = True then
      begin
        if (ValidFeedback <> '') then
        begin
          AFeedbackTag := TIWHTMLTag.CreateTag('div');
          try
            AFeedbackTag.AddClassParam('valid-feedback');
            AFeedbackTag.Contents.AddText(TIWBaseHTMLControl.TextToHTML(ValidFeedback));
            AHTMLTag.Contents.AddTagAsObject(AFeedbackTag);
          except
            FreeAndNil(AFeedbackTag);
            raise;
          end;
        end;

        if (InvalidFeedback <> '') then
        begin
          AFeedbackTag := TIWHTMLTag.CreateTag('div');
          try
            AFeedbackTag.AddClassParam('invalid-feedback');
            AFeedbackTag.Contents.AddText(TIWBaseHTMLControl.TextToHTML(InvalidFeedback));
            AHTMLTag.Contents.AddTagAsObject(AFeedbackTag);
          except
            FreeAndNil(AFeedbackTag);
            raise;
          end;
        end;
      end;

    except
      FreeAndNil(AHTMLTag);
      raise;
    end;
  end;

 {if not (Parent is TIWBS4InputGroup) and (InputType <> bs4itHidden) then
  begin
    AHTMLTag := IWBS4CreateInputFormGroup(Self, Parent, AHTMLTag, Caption, AHTMLName);
  end;}
end;

{$endregion}

{$region 'TIWBSMemo'}
constructor TIWBS4Memo.Create(AOwner: TComponent);
begin
  inherited;
  FLines := TStringList.Create;
  FLines.OnChange := OnLinesChange;
  FResizeDirection := bs4rdDefault;
  FRows := 5;
  FVertScrollBar := True;
  Height := 101;
  Width := 121;
end;

destructor TIWBS4Memo.Destroy;
begin
  FreeAndNil(FLines);
  inherited;
end;

procedure TIWBS4Memo.OnLinesChange(ASender: TObject);
begin
  FText := FLines.Text;
  Invalidate;
  if Script.Count > 0 then
  begin
    AsyncRefreshControl;
  end;
end;

procedure TIWBS4Memo.SetLines(const AValue: TStringList);
begin
  FLines.Assign(AValue);
end;

procedure TIWBS4Memo.SetText(const AValue: TCaption);
begin
  inherited;

  FLines.Text := FText;
  FText := FLines.Text; // this autoadjust linebreaks
end;

procedure TIWBS4Memo.InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: Boolean);
begin
  FLines.Text := ASubmitValue;
  ATextValue := FLines.Text;
end;

procedure TIWBS4Memo.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  inherited;

  AHTMLTag := TIWHTMLTag.CreateTag('textarea');
  try
    AHTMLTag.AddStringParam('id', AHTMLName);
    AHTMLTag.AddClassParam(ActiveCss);
    AHTMLTag.AddStringParam('name', AHTMLName);
    if ShowHint and (Hint <> '') then
      AHTMLTag.AddStringParam('title', Hint);
    if AutoFocus then
      AHTMLTag.Add('autofocus');
    if IsReadOnly then
      AHTMLTag.Add('readonly');
    if IsDisabled then
      AHTMLTag.Add('disabled');
    if MaxLength > 0 then
      AHTMLTag.AddIntegerParam('maxlength', MaxLength);
    if Required then
      AHTMLTag.Add('required');
    if PlaceHolder <> '' then
      AHTMLTag.AddStringParam('placeholder', TextToHTML(PlaceHolder));
    AHTMLTag.AddIntegerParam('rows', FRows);
    if TabIndex <> 0 then
      AHTMLTag.AddStringParam('tabindex', IntToStr(TabIndex));
    AHTMLTag.AddStringParam('style', ActiveStyle);
    AHTMLTag.Contents.AddText(TextToHTML(FText, False, False));
  except
    FreeAndNil(AHTMLTag);
    raise;
  end;

  if ((not (Parent is TIWBS4InputGroup)) and (not (Parent is TIWBS4FormGroup)) and (not ((Parent is TIWBS4Region) and (TIWBS4Region(Parent).BSRegionType = bs4rtFormGroup)))) then
  begin
    AHTMLTag := IWBS4CreateInputFormGroup(Self, Parent, AHTMLTag, Caption, HTMLName);
  end;
end;

procedure TIWBS4Memo.InternalRenderStyle(AStyle: TStringList);
begin
  if not FVertScrollBar then
  begin
    AStyle.Values['overflow'] := 'hidden';
  end;
  if FResizeDirection <> bs4rdDefault then
  begin
    AStyle.Values['resize'] := aIWBS4ResizeDirection[FResizeDirection];
  end;
end;
{$endregion}

{$region 'TIWBS4CheckBox'}

constructor TIWBS4CheckBox.Create(AOwner: TComponent);
begin
  inherited;
  FCheckBoxType := bs4cbtDefault;
  FChecked := False;
  FValueChecked := 'true';
  FValueUnchecked := 'false';
  FText := FValueUnchecked;
end;

procedure TIWBS4CheckBox.SetName(const AValue: TComponentName);
begin
  if Caption = Name then
  begin
    Caption := AValue;
  end;

  inherited;
end;

procedure TIWBS4CheckBox.SetCheckBoxType(AValue: TIWBS4CheckBoxType);
begin
  FCheckBoxType := AValue;
  Invalidate;
end;

procedure TIWBS4CheckBox.SetChecked(AValue: Boolean);
begin
  FChecked := AValue;
  if AValue then
    FText := FValueChecked
  else
    FText := FValueUnchecked;
  Invalidate;
end;

procedure TIWBS4Checkbox.SetDataTarget(const Value: TIWCustomRegion);
begin
  if FDataTarget <> Value then
  begin
    FDataTarget := Value;
    Invalidate;
  end;
end;

procedure TIWBS4Checkbox.SetDataTargetRegion(const Value: TIWBS4Region);
begin
  FDataTargetRegion := Value;
  Invalidate;
end;

procedure TIWBS4Checkbox.SetDataTargetMoab(const Value: TIWBS4Moab);
begin
  FDataTargetMoab := Value;
  Invalidate;
end;

procedure TIWBS4CheckBox.SetText(const AValue: TCaption);
begin
  inherited;
  FChecked := FText = FValueChecked;
end;

procedure TIWBS4CheckBox.InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: Boolean);
begin
  FChecked := ASubmitValue = 'on';
  if FChecked then
    ATextValue := FValueChecked
  else
    ATextValue := FValueUnchecked;
end;

procedure TIWBS4CheckBox.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
begin
  inherited;
  if FText <> FOldText then
  begin
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + HTMLName + '").prop("checked", ' + iif(Checked, 'true', 'false') + ');', False, True);
    FOldText := FText;
  end;
end;

procedure TIWBS4CheckBox.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  ACheckBoxLabelTag: TIWHTMLTag;
  ACheckBoxTag: TIWHTMLTag;
begin
  inherited;

  AHTMLTag := TIWHTMLTag.CreateTag('div');
  try
    if (CheckBoxType = bs4cbtDefault) then
    begin
    end
    else if (CheckBoxType = bs4cbtFancy) then
    begin
      AHTMLTag.AddClassParam('custom-control custom-checkbox');
    end
    else if (CheckBoxType = bs4cbtSwitch) then
    begin
      AHTMLTag.AddClassParam('custom-control custom-switch');
    end;

    AHTMLTag.AddClassParam(ActiveCss);
     // Create checkbox
    ACheckBoxTag := TIWHTMLTag.CreateTag('input');
    try
      ACheckBoxTag.AddStringParam('id', AHTMLName);
      ACheckBoxTag.AddStringParam('name', AHTMLName);
      if (CheckBoxType <> bs4cbtDefault) then
      begin
        ACheckBoxTag.AddClassParam('custom-control-input');
      end;
      ACheckBoxTag.AddStringParam('type', 'checkbox');
      if IsDisabled then
      begin
        ACheckBoxTag.Add('disabled');
      end;
      if Checked then
      begin
        ACheckBoxTag.Add('checked');
      end;
      if TabIndex <> 0 then
      begin
        ACheckBoxTag.AddStringParam('tabindex', IntToStr(TabIndex));
      end;
      ACheckBoxTag.AddStringParam('style', ActiveStyle);

      AHTMLTag.Contents.AddTagAsObject(ACheckBoxTag);

    except
      FreeAndNil(ACheckBoxTag);
      raise;
    end;

     // Create checkbox label
    ACheckBoxLabelTag := TIWHTMLTag.CreateTag('label');
    try
      if (CheckBoxType <> bs4cbtDefault) then
      begin
        ACheckBoxLabelTag.AddClassParam('custom-control-label');
      end;
      ACheckBoxLabelTag.AddStringParam('for', AHTMLName);
      ACheckBoxLabelTag.Contents.AddText(Caption);

      AHTMLTag.Contents.AddTagAsObject(ACheckBoxLabelTag);

       // See if we have a collapse target
      if Assigned(FDataTarget) then
      begin
        ACheckBoxLabelTag.AddStringParam('data-toggle', 'collapse');
        ACheckBoxLabelTag.AddStringParam('data-target', '#' + FDataTarget.HTMLName);
      end;

      if Assigned(FDataTargetRegion) then
      begin
        ACheckBoxLabelTag.AddStringParam('data-toggle', 'collapse');
        ACheckBoxLabelTag.AddStringParam('data-target', '#' + FDataTargetRegion.HTMLName);
      end;

      if Assigned(FDataTargetMoab) then
      begin
        ACheckBoxLabelTag.AddStringParam('data-target', '#' + FDataTargetMoab.HTMLName);
      end;

    except
      FreeAndNil(ACheckBoxLabelTag);
      raise;
    end;

  except
    FreeAndNil(AHTMLTag);
    raise;
  end;
end;

{$endregion}

{$region 'TIWBS4RadioButton'}
constructor TIWBS4RadioButton.Create(AOwner: TComponent);
begin
  inherited;

  FChecked := False;
  FGroup := 'group';
  FSaveUnchecked := True;
  FValueChecked := 'true';
  FValueUnchecked := 'false';
  FText := FValueUnchecked;
end;

function TIWBS4RadioButton.InputSuffix: string;
begin
  Result := '_INPUT';
end;

procedure TIWBS4RadioButton.SetName(const AValue: TComponentName);
begin
  if Caption = Name then
  begin
    Caption := AValue;
  end;

  inherited;
end;

procedure TIWBS4RadioButton.SetChecked(AValue: Boolean);
var
  LParent: TWinControl;
  LControl: TControl;
  i: Integer;
begin
  if FChecked <> AValue then
  begin
    FChecked := AValue;
    if FChecked then
    begin
      FText := FValueChecked;
      LParent := Self.Parent;
      for i := 0 to LParent.ControlCount - 1 do
      begin
        LControl := LParent.Controls[i];
        if (LControl <> Self) and (LControl is TIWBS4RadioButton) and TIWBS4RadioButton(LControl).Checked and SameText(TIWBS4RadioButton(LControl).Group, Self.Group) then
        begin
          TIWBS4RadioButton(LControl).Checked := False;
        end;
      end;
    end
    else
    begin
      FText := FValueUnchecked;
    end;
    Invalidate;
  end;
end;

procedure TIWBS4RadioButton.SetText(const AValue: TCaption);
begin
  inherited;
  FChecked := FText = FValueChecked;
end;

procedure TIWBS4RadioButton.InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: Boolean);
begin
  if ASubmitValue = 'on' then
  begin
    ATextValue := FValueChecked
  end
  else
  begin
    ATextValue := FValueUnchecked;
    ASetFieldValue := FSaveUnchecked;
  end;
end;

procedure TIWBS4RadioButton.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
begin
  inherited;

  if FText <> FOldText then
  begin
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + HTMLName + InputSuffix + '").prop("checked", ' + iif(Checked, 'true', 'false') + ');', False, True);
    FOldText := FText;
  end;
end;

procedure TIWBS4RadioButton.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
begin
  inherited;

  AHTMLTag := TIWHTMLTag.CreateTag('input');
  try
    AHTMLTag.AddStringParam('id', AHTMLName + InputSuffix);
    AHTMLTag.AddStringParam('name', FGroup);
    AHTMLTag.AddClassParam(ActiveCss);
    AHTMLTag.AddStringParam('type', 'radio');
    if IsDisabled then
    begin
      AHTMLTag.Add('disabled');
    end;
    if FChecked then
    begin
      AHTMLTag.Add('checked');
    end;
    // OnClick is not hooked using inline JavaScript anymore (CSP compatibility)
    // See CreateIWCLObject in IWCL.js
    //AHTMLTag.AddStringParam('onclick', 'radioButtonClick(event, ''' + FGroup + ''',''' + AHTMLName+InputSuffix + ''');');
    AHTMLTag.AddStringParam('value', 'on');
    if TabIndex <> 0 then
    begin
      AHTMLTag.AddStringParam('tabindex', IntToStr(TabIndex));
    end;
    AHTMLTag.AddStringParam('style', ActiveStyle);
  except
    FreeAndNil(AHTMLTag);
    raise;
  end;

  if Parent is TIWBS4InputGroup then
    AHTMLTag := IWBS4CreateInputGroupAddOn(AHTMLTag, AHTMLName, 'addon')
  else
  begin
    AHTMLTag := IWBS4CreateCheckBoxFormGroup(Parent, AHTMLTag, 'radio', Caption, Hint, AHTMLName, ShowHint);
    AHTMLTag.AddStringParam('data-type', 'IWRADIOBUTTON');
  end;
end;
{$endregion}

{$region 'TIWBS4RangeSliderInput'}

constructor TIWBS4RangeSliderInput.Create(AOwner: TComponent);
begin
  inherited;

  FBasicAllowKeyboard := True;
  FBasicFromValue := 0.0;
  FBasicMaxValue := 100.0;
  FBasicMinValue := 0.0;
  FBasicStepValue := 1.0;
  FBasicToValue := 100.0;

  FCalendarDateMax := Date;
  FCalendarDateMin := Date;
  FCalendarDateFrom := Date;
  FCalendarDateTo := Date;

  FOnCallbackChange := nil;
  FOnCallbackFinish := nil;
  FOnCallbackStart := nil;
  FOnCallbackUpdate := nil;

  FDataDisabled := False;
  FDataInputValuesSeparator := ':';

  FGridEnabled := False;
  FGridMargin := True;
  FGridNumberOfUnits := 4.0;
  FGridSnap := False;

  FHandleCount := bs4rshcSingle;
  FHandleFromFixed := False;
  FHandleFromMaxValue := 0.0;
  FHandleFromMinValue := 0.0;
  FHandleFromShadow := True;
  FHandleToFixed := False;
  FHandleToMaxValue := 0.0;
  FHandleToMinValue := 0.0;
  FHandleToShadow := True;

  FIntervalDrag := True;
  FIntervalMax := 0.0;
  FIntervalMin := 0.0;

  FPrettifyDecorateBothValues := True;
  FPrettifyEnabled := True;
  FPrettifyMaxPostfix := '';
  FPrettifyPostfix := '';
  FPrettifyPrefix := '';
  FPrettifySeparator := ',';
  FPrettifyValuesSeparator := '--';

  FSliderType := bs4rstUser;

  FUISkin := bs4rssBig;
  FUIForceEdges := False;
  FUIHideFromToLabels := False;
  FUIHideMinMaxLabels := False;
  UILock := False;
end;

procedure TIWBS4RangeSliderInput.CheckCalendarDates;
begin
   // Check date start
  if (FCalendarDateFrom < FCalendarDateMin) then
  begin
    FCalendarDateFrom := FCalendarDateMin;
  end
  else if (FCalendarDateFrom > FCalendarDateMax) then
  begin
    FCalendarDateFrom := FCalendarDateMax;
  end;

   // Check date end
  if (FCalendarDateTo < FCalendarDateMin) then
  begin
    FCalendarDateTo := FCalendarDateMin;
  end
  else if (FCalendarDateTo > FCalendarDateMax) then
  begin
    FCalendarDateTo := FCalendarDateMax;
  end;
end;

procedure TIWBS4RangeSliderInput.DoOnCallbackChange(AParams: TStringList);
begin
   // Update values
  UpdateValuesFromCallback(AParams);

   // Call event if one defined
  if (Assigned(OnCallbackChange) = True) then
  begin
    OnCallbackChange(Self, AParams);
  end;
end;

procedure TIWBS4RangeSliderInput.DoOnCallbackFinish(AParams: TStringList);
begin
   // Update values
  UpdateValuesFromCallback(AParams);

   // Call event if one defined
  if (Assigned(OnCallbackFinish) = True) then
  begin
    OnCallbackFinish(Self, AParams);
  end;
end;

procedure TIWBS4RangeSliderInput.DoOnCallbackStart(AParams: TStringList);
begin
   // Call event if one defined
  if (Assigned(OnCallbackStart) = True) then
  begin
    OnCallbackStart(Self, AParams);
  end;
end;

procedure TIWBS4RangeSliderInput.DoOnCallbackUpdate(AParams: TStringList);
begin
   // Update values
  UpdateValuesFromCallback(AParams);

   // Call event if one defined
  if (Assigned(OnCallbackUpdate) = True) then
  begin
    OnCallbackUpdate(Self, AParams);
  end;
end;

procedure TIWBS4RangeSliderInput.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  LFormatSettings: TFormatSettings;
begin
  inherited;

  if FIsStatic then
  begin
    // This is wrong, static do not render as <p>, if they ever did
    AHTMLTag := TIWHTMLTag.CreateTag('p');
    try
      AHTMLTag.AddClassParam(ActiveCss);
      AHTMLTag.AddStringParam('id', AHTMLName);
      AHTMLTag.AddStringParam('style', ActiveStyle);
      AHTMLTag.Contents.AddText(TextToHTML(FText));
    except
      FreeAndNil(AHTMLTag);
      raise;
    end;
  end
  else
  begin
    AHTMLTag := TIWHTMLTag.CreateTag('input');
    try
      AHTMLTag.AddClassParam('js-range-slider');
      AHTMLTag.AddStringParam('type', 'text');
      AHTMLTag.AddClassParam(ActiveCss);
      AHTMLTag.AddStringParam('id', AHTMLName);
      AHTMLTag.AddStringParam('name', AHTMLName);

      // Basic
      AHTMLTag.AddBoolParam('data-keyboard', BasicAllowKeyboard);
      if ((SliderType = bs4rstTimeDuration) or (SliderType = bs4rstUser)) then
      begin
        AHTMLTag.AddStringParam('data-min', FloatToStr(BasicMinValue, LFormatSettings));
        AHTMLTag.AddStringParam('data-max', FloatToStr(BasicMaxValue, LFormatSettings));
        AHTMLTag.AddStringParam('data-from', FloatToStr(BasicFromValue, LFormatSettings));
        AHTMLTag.AddStringParam('data-to', FloatToStr(BasicToValue, LFormatSettings));
      end;
      AHTMLTag.AddStringParam('data-step', FloatToStr(BasicStepValue, LFormatSettings));

      // Data
      AHTMLTag.AddBoolParam('data-disable', DataDisabled);
      AHTMLTag.AddStringParam('data-input-values-separator', DataInputValuesSeparator);

      // Grid
      if (GridEnabled = True) then
      begin
        AHTMLTag.AddBoolParam('data-grid', GridEnabled);
        AHTMLTag.AddBoolParam('data-grid-margin', GridMargin);
        AHTMLTag.AddStringParam('data-grid-num', FloatToStr(GridNumberOfUnits, LFormatSettings));
        AHTMLTag.AddBoolParam('data-grid-snap', GridSnap);
      end;

      // Handles
      AHTMLTag.AddStringParam('data-type', aIWBS4RangeSliderHandleCount[HandleCount]);
      AHTMLTag.AddBoolParam('data-from-fixed', HandleFromFixed);
      if (HandleFromMinValue < HandleFromMaxValue) then
      begin
        AHTMLTag.AddStringParam('data-from-min', FloatToStr(HandleFromMinValue, LFormatSettings));
        AHTMLTag.AddStringParam('data-from-max', FloatToStr(HandleFromMaxValue, LFormatSettings));
      end;
      AHTMLTag.AddBoolParam('data-from-shadow', HandleFromShadow);
      AHTMLTag.AddBoolParam('data-to-fixed', HandleToFixed);
      if (HandleToMinValue < HandleToMaxValue) then
      begin
        AHTMLTag.AddStringParam('data-to-min', FloatToStr(HandleToMinValue, LFormatSettings));
        AHTMLTag.AddStringParam('data-to-max', FloatToStr(HandleToMaxValue, LFormatSettings));
      end;
      AHTMLTag.AddBoolParam('data-to-shadow', HandleToShadow);

      // Intervals
      AHTMLTag.AddBoolParam('data-drag-interval', IntervalDrag);
      if ((IntervalMin <> 0) or (IntervalMax <> 0)) then
      begin
        AHTMLTag.AddStringParam('data-min-interval', FloatToStr(IntervalMin, LFormatSettings));
        AHTMLTag.AddStringParam('data-max-interval', FloatToStr(IntervalMax, LFormatSettings));
      end;

      // Prettify
      AHTMLTag.AddBoolParam('data-prettify-enabled', PrettifyEnabled);
      if ((PrettifyDecorateBothValues = True) and ((PrettifyPrefix <> '') or (PrettifyPostfix <> ''))) then
      begin
        AHTMLTag.AddBoolParam('data-decorate-both', PrettifyDecorateBothValues);
        AHTMLTag.AddStringParam('data-prefix', PrettifyPrefix);
        AHTMLTag.AddStringParam('data-postfix', PrettifyPostfix);
      end;
      if (PrettifyMaxPostfix <> '') then
      begin
        AHTMLTag.AddStringParam('data-max-postfix', PrettifyMaxPostfix);
      end;
      AHTMLTag.AddStringParam('data-prettify-separator', PrettifySeparator);
      AHTMLTag.AddStringParam('data-values-separator', PrettifyValuesSeparator);

      // UI
      AHTMLTag.AddStringParam('data-skin', aIWBS4RangeSliderSkin[UISkin]);
      AHTMLTag.AddBoolParam('data-block', UIBlock);
      AHTMLTag.AddBoolParam('data-force-edges', UIForceEdges);
      AHTMLTag.AddBoolParam('data-hide-from-to', UIHideFromToLabels);
      AHTMLTag.AddBoolParam('data-hide-min-max', UIHideMinMaxLabels);
      AHTMLTag.AddBoolParam('data-lock', UILock);

      if ShowHint and (Hint <> '') then
        AHTMLTag.AddStringParam('title', Hint);
      if AutoFocus then
        AHTMLTag.Add('autofocus');
      if IsReadOnly then
        AHTMLTag.Add('readonly');
      if IsDisabled then
        AHTMLTag.Add('disabled');

      AHTMLTag.AddStringParam('value', TextToHTML(FText));

      if Required then
        AHTMLTag.Add('required');
      if PlaceHolder <> '' then
        AHTMLTag.AddStringParam('placeholder', TextToHTML(PlaceHolder));
      if TabIndex <> 0 then
        AHTMLTag.AddStringParam('tabindex', IntToStr(TabIndex));
      AHTMLTag.AddStringParam('style', ActiveStyle);

    except
      FreeAndNil(AHTMLTag);
      raise;
    end;
  end;

 {if not (Parent is TIWBS4InputGroup) and (InputType <> bs4itHidden) then
  begin
    AHTMLTag := IWBS4CreateInputFormGroup(Self, Parent, AHTMLTag, Caption, AHTMLName);
  end;}
end;

procedure TIWBS4RangeSliderInput.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
var
  strValues: string;
begin
  inherited;

  if (SliderType = bs4rstCalendar) then
  begin
    AScript.Add('function dateToTS (date)');
    AScript.Add('{');
    AScript.Add('  return date.valueOf();');
    AScript.Add('}');

    AScript.Add('function tsToDate (ts)');
    AScript.Add('{');
    AScript.Add('  var d = new Date(ts);');
    AScript.Add('  return d.toLocaleDateString("en-US", { year: "numeric", month: "numeric",day: "numeric"});');
    AScript.Add('}');

    AScript.Add('$("#' + AHTMLName + '").ionRangeSlider(');
    AScript.Add('{');
    AScript.Add(format('min: dateToTS(new Date(%d,%d,%d)),', [YearOf(CalendarDateMin), MonthOf(CalendarDateMin) - 1, DayOf(CalendarDateMin)]));
    AScript.Add(format('max: dateToTS(new Date(%d,%d,%d)),', [YearOf(CalendarDateMax), MonthOf(CalendarDateMax) - 1, DayOf(CalendarDateMax)]));
    AScript.Add(format('from: dateToTS(new Date(%d,%d,%d)),', [YearOf(CalendarDateFrom), MonthOf(CalendarDateFrom) - 1, DayOf(CalendarDateFrom)]));
    AScript.Add(format('to: dateToTS(new Date(%d,%d,%d)),', [YearOf(CalendarDateTo), MonthOf(CalendarDateTo) - 1, DayOf(CalendarDateTo)]));
    AScript.Add('prettify: tsToDate,');
  end
  else if (SliderType = bs4rstTimeDuration) then
  begin
    AScript.Add('function TimeDurationToText(nTimeInMinutes)');
    AScript.Add('{');
    AScript.Add('  var nHours =  ~~(nTimeInMinutes / 60);');
    AScript.Add('  var nMinutes = nTimeInMinutes % 60;');
    AScript.Add('  var strTime = "";');
    AScript.Add('  if (nHours == 0 && nMinutes == 0)');
    AScript.Add('  {');
    AScript.Add('    strTime = "0H";');
    AScript.Add('  }');
    AScript.Add('   if (nHours > 0)');
    AScript.Add('   {');
    AScript.Add('       strTime = strTime + nHours + "H";');
    AScript.Add('   }');
    AScript.Add('   if (nMinutes > 0)');
    AScript.Add('   {');
    AScript.Add('       strTime = strTime + nMinutes + "M";');
    AScript.Add('   }');
    AScript.Add('   return strTime;');
    AScript.Add('}');
    AScript.Add('$("#' + AHTMLName + '").ionRangeSlider(');
    AScript.Add('{');
    AScript.Add('prettify: TimeDurationToText,');
  end
  else
  begin
    AScript.Add('$("#' + AHTMLName + '").ionRangeSlider(');
    AScript.Add('{');
  end;

  strValues := 'var strValues = "&From=" + data.from + "&FromPercent=" + data.from_percent + "&FromPretty=" + data.from_pretty +' + '"&FromValue=" + data.from_value + "&To=" + data.to + "&ToPercent=" + data.to_percent +' + '"&ToPretty=" + data.to_pretty +"&ToValue=" + data.to_value;';

  if (Assigned(FOnCallbackChange) = true) then
  begin
    AScript.Add('onChange: function (data)');
    AScript.Add('{');
    AScript.Add(strValues);
      //AScript.Add('  console.log("onChange() - " + strValues);');
    AScript.Add('  executeAjaxEvent(strValues, null,"' + AHTMLName + '.DoOnCallbackChange",false, null, false);');
    AScript.Add('},');
  end;

  if ((Assigned(FOnCallbackChange) = false) or (Assigned(FOnCallbackFinish) = true)) then
  begin
    AScript.Add('onFinish: function (data)');
    AScript.Add('{');
    AScript.Add(strValues);
      //AScript.Add('  console.log("onFinish() - " + strValues);');
    AScript.Add('  executeAjaxEvent(strValues, null,"' + AHTMLName + '.DoOnCallbackFinish",false, null, false);');
    AScript.Add('},');
  end;

  AScript.Add('onStart: function (data)');
  AScript.Add('{');
  AScript.Add(strValues);
  //AScript.Add('  console.log("onStart() - " + strValues);');
  AScript.Add('  executeAjaxEvent(strValues, null,"' + AHTMLName + '.DoOnCallbackStart",false, null, false);');
  AScript.Add('},');

  AScript.Add('onUpdate: function (data)');
  AScript.Add('{');
  AScript.Add(strValues);
  //AScript.Add('  console.log("onUpdate() - " + strValues);');
  AScript.Add('  executeAjaxEvent(strValues, null,"' + AHTMLName + '.DoOnCallbackUpdate",false, null, false);');
  AScript.Add('}');
  AScript.Add('}');
  AScript.Add(');');

  AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackChange', DoOnCallbackChange);
  AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackFinish', DoOnCallbackFinish);
  AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackStart', DoOnCallbackStart);
  AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnCallbackUpdate', DoOnCallbackUpdate);
end;

procedure TIWBS4RangeSliderInput.SetBasicFromValue(fValue: double);
begin
  FBasicFromValue := fValue;

  if (FBasicFromValue > FBasicToValue) then
  begin
    FBasicToValue := fValue;
  end;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetBasicMaxValue(fMaxValue: double);
begin
  FBasicMaxValue := fMaxValue;

  if (FBasicToValue > FBasicMaxValue) then
  begin
    FBasicToValue := FBasicMaxValue;
  end;

  if (FBasicMinValue > FBasicMaxValue) then
  begin
    FBasicMinValue := FBasicMaxValue;

    if (FBasicFromValue < FBasicMinValue) then
    begin
      FBasicFromValue := FBasicMinValue;
    end;
  end;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetBasicMinValue(fMinValue: double);
begin
  FBasicMinValue := fMinValue;

  if (FBasicFromValue < FBasicMinValue) then
  begin
    FBasicFromValue := FBasicMinValue;
  end;

  if (FBasicMaxValue < FBasicMinValue) then
  begin
    FBasicMaxValue := FBasicMinValue;

    if (FBasicToValue > FBasicMaxValue) then
    begin
      FBasicToValue := FBasicMaxValue;
    end;
  end;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetBasicStepValue(fStepValue: double);
begin
  FBasicStepValue := fStepValue;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetBasicToValue(fToValue: double);
begin
  FBasicToValue := fToValue;
  if (FBasicToValue < FBasicMinValue) then
  begin
    FBasicToValue := FBasicMinValue;
  end
  else if (FBasicToValue > FBasicMaxValue) then
  begin
    FBasicToValue := FBasicMaxValue;
  end;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetHandleCount(nType: TIWBS4RangeSliderHandleCount);
begin
  FHandleCount := nType;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetCalendarDateMax(nDate: TDateTime);
begin
  FCalendarDateMax := nDate;
  FCalendarDateMin := Min(FCalendarDateMin, nDate);

  CheckCalendarDates;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetCalendarDateMin(nDate: TDateTime);
begin
  FCalendarDateMin := nDate;
  FCalendarDateMax := Max(FCalendarDateMax, nDate);

  CheckCalendarDates;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetCalendarDateFrom(nDate: TDateTime);
begin
  FCalendarDateFrom := nDate;

  if (nDate > FCalendarDateTo) then
  begin
    FCalendarDateTo := nDate;
  end;

  CheckCalendarDates;

  Invalidate();
end;

procedure TIWBS4RangeSliderInput.SetCalendarDateTo(nDate: TDateTime);
begin
  if (nDate < FCalendarDateFrom) then
  begin
    FCalendarDateTo := FCalendarDateFrom;
  end
  else
  begin
    FCalendarDateTo := nDate;
  end;

  CheckCalendarDates;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetDataDisabled(bDisabled: boolean);
begin
  FDataDisabled := bDisabled;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetDataInputValuesSeparator(strSeparator: string);
begin
  FDataInputValuesSeparator := strSeparator;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetGridEnabled(bEnabled: boolean);
begin
  FGridEnabled := bEnabled;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetGridMargin(bMargin: boolean);
begin
  FGridMargin := bMargin;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetGridNumberOfUnits(fNumberOfUnits: double);
begin
  FGridNumberOfUnits := Max(0, fNumberOfUnits);

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetGridSnap(bSnap: boolean);
begin
  FGridSnap := bSnap;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetHandleFromFixed(bFixed: boolean);
begin
  FHandleFromFixed := bFixed;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetHandleFromMaxValue(fMaxValue: double);
begin
   // I should do range checking but...
  FHandleFromMaxValue := fMaxValue;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetHandleFromMinValue(fMinValue: double);
begin
   // I should do range checking but...
  FHandleFromMinValue := fMinValue;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetHandleFromShadow(bShadow: boolean);
begin
  FHandleFromShadow := bShadow;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetHandleToFixed(bFixed: boolean);
begin
  FHandleToFixed := bFixed;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetHandleToMaxValue(fMaxValue: double);
begin
   // I should do range checking but...
  FHandleToMaxValue := fMaxValue;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetHandleToMinValue(fMinValue: double);
begin
   // I should do range checking but...
  FHandleToMinValue := fMinValue;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetHandleToShadow(bShadow: boolean);
begin
  FHandleToShadow := bShadow;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetIntervalDrag(bDrag: boolean);
begin
  FIntervalDrag := bDrag;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetIntervalMax(fMax: double);
begin
  FIntervalMax := Max(IntervalMin, fMax);

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetIntervalMin(fMin: double);
begin
  FIntervalMin := Min(fMin, FIntervalMax);

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetPrettifyDecorateBothValues(bBothValues: boolean);
begin
  FPrettifyDecorateBothValues := bBothValues;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetPrettifyEnabled(bEnabled: boolean);
begin
  FPrettifyEnabled := bEnabled;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetPrettifyMaxPostfix(strPostfix: string);
begin
  FPrettifyMaxPostfix := strPostfix;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetPrettifyPostfix(strPostfix: string);
begin
  FPrettifyPostfix := strPostfix;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetPrettifyPrefix(strPrefix: string);
begin
  FPrettifyPrefix := strPrefix;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetPrettifySeparator(strSeparator: string);
begin
  FPrettifySeparator := strSeparator;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetPrettifyValuesSeparator(strSeparator: string);
begin
  FPrettifyValuesSeparator := strSeparator;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetSliderType(nType: TIWBS4RangeSliderType);
begin
  FSliderType := nType;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetUIBlock(bBlock: boolean);
begin
  FUIBlock := bBlock;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetUIForceEdges(bForceEdges: boolean);
begin
  FUIForceEdges := bForceEdges;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetUIHideFromToLabels(bHide: boolean);
begin
  FUIHideFromToLabels := bHide;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetUIHideMinMaxLabels(bHide: boolean);
begin
  FUIHideMinMaxLabels := bHide;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetUILock(bLock: boolean);
begin
  FUILock := bLock;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.SetUISkin(nSkin: TIWBS4RangeSliderSkin);
begin
  FUISkin := nSkin;

  Invalidate;
end;

procedure TIWBS4RangeSliderInput.UpdateValuesFromCallback(AParams: TStringList);
begin
   // Get values
  if (SliderType = bs4rstCalendar) then
  begin
    FCalendarDateFrom := StrToDateDef(AParams.Values['FromPretty'], CalendarDateMin);
    FCalendarDateTo := StrToDateDef(AParams.Values['ToPretty'], FCalendarDateFrom);
  end
  else
  begin
    FBasicFromValue := StrToFloatDef(AParams.Values['From'], BasicMinValue);
    FBasicToValue := StrToFloatDef(AParams.Values['To'], FBasicFromValue);
  end;
end;
{$endregion}


{$region 'TIWBS4Select'}

constructor TIWBS4Select.Create(AOwner: TComponent);
var
  OwnerForm: TIWAppForm;
begin
  inherited;

  // Default values
  FDropDownWidth := 'false';
  FMultiSelect := False;
  FShowActionsPanel := False;
  FShowTick := true;
  FSize := 1;

  // Add styles if not already added
  OwnerForm := FindOwnerForm(AOwner);
  if Assigned(OwnerForm) then
  begin
    if Pos('.bootstrap-select.show-tick', OwnerForm.ExtraHeader.Text) = 0 then
    begin
      OwnerForm.ExtraHeader.Add('<style>' + sLineBreak + '.bootstrap-select.show-tick .dropdown-menu .selected span.check-mark' + sLineBreak + '{' + sLineBreak + '   left: 10px;' + sLineBreak + '}' + sLineBreak + '.bootstrap-select.btn-group .dropdown-toggle .filter-option' + sLineBreak + '{' + sLineBreak + '    display: inline-block;' + sLineBreak + '    overflow: hidden;' + sLineBreak + '    text-align: left;' + sLineBreak + '    white-space: normal;' + sLineBreak + '    width: 100%;' + sLineBreak + '    word-wrap: break-word;' + sLineBreak + '}' + sLineBreak + '.bootstrap-select .filter-option' + sLineBreak + '{' + sLineBreak + '  white-space: normal;' + sLineBreak + '}' + sLineBreak + '</style>');
    end;
  end;
end;

function TIWBS4Select.GetIndexesOfItemsSelected: string;
var
  bAddCommas: boolean;
  nIndex: integer;
begin
  Result := '';

  bAddCommas := False;

  for nIndex := 0 to Length(FItemsSelected) - 1 do
  begin
    if (FItemsSelected[nIndex] = True) then
    begin

      // Add comma if needed
      if (bAddCommas = True) then
      begin
        Result := Result + ',';
      end
      else
      begin
        bAddCommas := True;
      end;

      // Add item
      Result := Result + IntToStr(nIndex);
    end;
  end;
end;

function TIWBS4Select.GetValuesOfItemsSelected: string;
var
  bAddCommas: boolean;
  nIndex: integer;
  strValue: string;
begin
  bAddCommas := False;

  if (ItemsHaveValues = True) then
  begin
    Result := '';

    for nIndex := 0 to Length(FItemsSelected) - 1 do
    begin
      if (FItemsSelected[nIndex] = True) then
      begin
        // Get value
        strValue := Items.ValueFromIndex[nIndex];

        // Add comma if needed
        if (bAddCommas = True) then
        begin
          Result := Result + ',';
        end
        else
        begin
          bAddCommas := True;
        end;

        // Add item
        Result := Result + strValue;
      end;
    end;
  end
  else
  begin
    Result := IntToStr(ItemIndex);
  end;
end;

procedure TIWBS4Select.OnItemsChange(ASender: TObject);
begin
  inherited;

  SetLength(FItemsSelected, Items.Count);
  ResetItemsSelected;
  AsyncRefreshControl;
end;

procedure TIWBS4Select.SelectItemsByValues(const AValues: string; const ADelimiter: string);
var
  nItemIndex, nValueIndex: Integer;
  pSelectedValuesList: TStringList;
begin

  if (FMultiSelect = True) and (ADelimiter <> '') then
  begin
    ResetItemsSelected;

    pSelectedValuesList := TStringList.Create;
    try
      pSelectedValuesList.StrictDelimiter := True;
      pSelectedValuesList.CommaText := AValues;
      for nValueIndex := 0 to pSelectedValuesList.Count - 1 do
      begin
        for nItemIndex := 0 to Items.Count - 1 do
        begin
          if AnsiSameStr(IfThen(ItemsHaveValues, Items.ValueFromIndex[nItemIndex], Items[nItemIndex]), pSelectedValuesList[nValueIndex]) then
          begin
            FItemsSelected[nItemIndex] := True;
            Break;
          end;
        end;
      end;
    finally
      pSelectedValuesList.Free;
    end;

    Invalidate;
  end;
end;

procedure TIWBS4Select.SetItemIndex(AValue: Integer);
begin
  if not FMultiSelect and (AValue < 0) and (Items.Count > 0) then
  begin
    AValue := 0;
  end;

  inherited;

  ResetItemsSelected;
end;

procedure TIWBS4Select.ResetItemsSelected;
var
  i: Integer;
begin
  for i := 0 to Length(FItemsSelected) - 1 do
  begin
    FItemsSelected[i] := False;
  end;
  if (FItemIndex >= 0) and (FItemIndex < Length(FItemsSelected)) then
  begin
    FItemsSelected[FItemIndex] := True;
  end;
end;

{procedure TIWBS4Select.SetSelectedTextFormatCount(AValue : Integer);
begin

  if ((AValue < 0) OR (AValue > Items.Count)) then
  begin
    AValue := 0;
  end;

  if ((AValue = 0) AND (SelectedTextFormat = bs4stfCountGtX)) then
  begin
   FSelectedTextFormat := bs4stfCount;
  end;

  FSelectedTextFormatCount := AValue;

  Invalidate;

end;}

procedure TIWBS4Select.SetSize(AValue: Integer);
begin
  FSize := AValue;
  Invalidate;
end;

procedure TIWBS4Select.SetText(const AValue: TCaption);
var
  LSelectedVal: TStringList;
  i, j: Integer;
begin
  FText := AValue;
  if FMultiSelect and AnsiContainsStr(FText, ',') then
  begin
    ResetItemsSelected;
    LSelectedVal := TStringList.Create;
    try
      LSelectedVal.StrictDelimiter := True;
      LSelectedVal.CommaText := FText;
      for i := 0 to LSelectedVal.Count - 1 do
      begin
        for j := 0 to Items.Count - 1 do
          if AnsiSameStr(IfThen(ItemsHaveValues, Items.ValueFromIndex[j], Items[j]), LSelectedVal[i]) then
          begin
            FItemsSelected[j] := True;
          end;
      end;
    finally
      LSelectedVal.Free;
    end;
  end
  else
  begin
    FItemIndex := FindValue(FText);
    if not FMultiSelect and (FItemIndex < 0) and (Items.Count > 0) then
    begin
      FItemIndex := 0;
      FText := IfThen(ItemsHaveValues, Items.ValueFromIndex[FItemIndex], Items[FItemIndex]);
    end;
    ResetItemsSelected;
  end;
  Invalidate;
end;

procedure TIWBS4Select.InternalSetValue(const ASubmitValue: string; var ATextValue: string; var ASetFieldValue: Boolean);
var
  LSelectedIdx, LSelectedVal: TStringList;
  i, v: Integer;
begin
  if FMultiSelect and AnsiContainsStr(ASubmitValue, ',') then
  begin
    FItemIndex := -1;
    ResetItemsSelected;
    LSelectedIdx := TStringList.Create;
    LSelectedVal := TStringList.Create;
    try
      LSelectedIdx.CommaText := ASubmitValue;
      for i := 0 to LSelectedIdx.Count - 1 do
        if TryStrToInt(LSelectedIdx[i], v) and (v >= 0) and (v < Items.Count) then
        begin
          if i = 0 then
            FItemIndex := v
          else if ItemsHaveValues then
            LSelectedVal.Add(Items.ValueFromIndex[v])
          else
            LSelectedVal.Add(Items[v]);
          FItemsSelected[v] := True;
        end;
      LSelectedVal.StrictDelimiter := True;
      ATextValue := LSelectedVal.CommaText;
    finally
      LSelectedIdx.Free;
      LSelectedVal.Free;
    end;
  end
  else
  begin
    inherited InternalSetValue(ASubmitValue, ATextValue, ASetFieldValue);
    ResetItemsSelected;
  end;
end;

procedure TIWBS4Select.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
var
  LSelectedIdx: string;
  i: Integer;
begin
  inherited;

  if FText <> FOldText then
  begin
    LSelectedIdx := '';
    if FMultiSelect then
    begin
      for i := 0 to Length(FItemsSelected) - 1 do
        if FItemsSelected[i] then
        begin
          if LSelectedIdx <> '' then
          begin
            LSelectedIdx := LSelectedIdx + ',';
          end;
          LSelectedIdx := LSelectedIdx + IntToStr(i);
        end;
    end
    else if FItemIndex >= 0 then
    begin
      LSelectedIdx := IntToStr(FItemIndex);
    end;
    IWBS4ExecuteAsyncJScript(AApplication, '$("#' + AHTMLName + '").val([' + LSelectedIdx + ']);', False, True);
    FOldText := FText;
  end;
end;

procedure TIWBS4Select.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  i: Integer;
begin
  inherited;
  AHTMLTag := TIWHTMLTag.CreateTag('select');
  try
    AHTMLTag.AddClassParam('selectpicker');
    //if (FShowTick = true) then
    //begin
    //  AHTMLTag.AddClassParam('show-tick');
    //end;

    AHTMLTag.AddStringParam('id', AHTMLName);
    AHTMLTag.AddClassParam(ActiveCss);
    AHTMLTag.AddStringParam('name', AHTMLName);
    if FSize > 0 then
      AHTMLTag.AddIntegerParam('size', FSize)
    else
      AHTMLTag.AddIntegerParam('size', Items.Count);

    if FMultiSelect then
    begin
      AHTMLTag.Add('multiple');

{      if (FMaxSelectedItemsCount <= 0) then
      begin
        AHTMLTag.AddBoolParam('data-max-options',false);
      end
      else
      begin
        AHTMLTag.AddIntegerParam('data-max-options',Min(FMaxSelectedItemsCount,Items.Count));
      end;

      if (NoneSelectedText.IsEmpty = False) then
      begin
         AHTMLTag.AddStringParam('data-none-selected-text',NoneSelectedText);
      end;

      if (FSelectedTextFormat = bs4stfCountGtX) then
      begin
        if (FSelectedTextFormatCount = 0) then
        begin
          AHTMLTag.AddStringParam('data-selected-text-format',aIWBS4SelectedTextFormat[bs4stfValues]);
        end
        else
        begin
          AHTMLTag.AddStringParam('data-selected-text-format',Format('count > %d',[FSelectedTextFormatCount]));
        end;
      end
      else
      begin
        AHTMLTag.AddStringParam('data-selected-text-format',aIWBS4SelectedTextFormat[FSelectedTextFormat]);
      end;

      if (FShowActionsPanel = True) then
      begin
         AHTMLTag.AddBoolParam('data-actions-box',true);

         if (FDeselectAllButtonCaption <> '') then
         begin
            AHTMLTag.AddStringParam('data-deselect-all-text',FDeselectAllButtonCaption);
         end;

         if (FSelectAllButtonCaption <> '') then
         begin
            AHTMLTag.AddStringParam('data-select-all-text',FSelectAllButtonCaption);
         end;

         if (FMaxSelectedItemsCount = 0) then
         begin
            AHTMLTag.AddBoolParam('data-max-options',false);
         end
         else
         begin
            AHTMLTag.AddIntegerParam('data-max-options',FMaxSelectedItemsCount);
         end;
      end;
}
    end;

{
    if (FDropDownWidth.IsEmpty = false) then
    begin
     AHTMLTag.AddStringParam('data-width',FDropDownWidth);
    end;
}
    if (FTitle <> '') then
    begin
      AHTMLTag.AddStringParam('data-title', FTitle);
    end;

    if IsDisabled then
    begin
      AHTMLTag.Add('disabled');
    end;
    if AutoFocus then
    begin
      AHTMLTag.Add('autofocus');
    end;
    if TabIndex <> 0 then
    begin
      AHTMLTag.AddStringParam('tabindex', IntToStr(TabIndex));
    end;

    for i := 0 to Items.Count - 1 do
    begin
      with AHTMLTag.Contents.AddTag('option') do
      begin
        AddStringParam('value', IntToStr(i));
        if FItemsSelected[i] then
        begin
          Add('selected');
        end;
        Contents.AddText(TextToHTML(iif(ItemsHaveValues, Items.Names[i], Items[i])));
      end;
    end;
  except
    FreeAndNil(AHTMLTag);
    raise;
  end;

  if ((not (Parent is TIWBS4InputGroup)) and (not (Parent is TIWBS4FormGroup)) and (not ((Parent is TIWBS4Region) and (TIWBS4Region(Parent).BSRegionType = bs4rtFormGroup)))) then
  begin
    AHTMLTag := IWBS4CreateInputFormGroup(Self, Parent, AHTMLTag, Caption, AHTMLName);
  end;
end;
{$endregion}

{$region 'TIWBS4RadioGroup'}

function TIWBS4RadioGroup.InputSelector: string;
begin
  Result := ' input';
end;

function TIWBS4RadioGroup.InputSuffix: string;
begin
  Result := '_INPUT';
end;

procedure TIWBS4RadioGroup.InternalRenderAsync(const AHTMLName: string; AApplication: TIWApplication);
begin
  inherited;
  if FText <> FOldText then
  begin
    if FItemIndex >= 0 then
      IWBS4ExecuteAsyncJScript(AApplication, '$("#' + AHTMLName + '_INPUT_' + IntToStr(FItemIndex) + '").prop("checked", true);', False, True)
    else
      IWBS4ExecuteAsyncJScript(AApplication, '$("#' + AHTMLName + ' input").prop("checked", false);', False, True);
    FOldText := FText;
  end;
end;

procedure TIWBS4RadioGroup.InternalRenderHTML(const AHTMLName: string; AContext: TIWCompContext; var AHTMLTag: TIWHTMLTag);
var
  i: Integer;
begin
  inherited;

  AHTMLTag := TIWHTMLTag.CreateTag('div');
  try
    AHTMLTag.AddStringParam('id', AHTMLName);
    AHTMLTag.AddClassParam('radio');
    if TabIndex <> 0 then
    begin
      AHTMLTag.AddStringParam('tabindex', IntToStr(TabIndex));
    end;
    AHTMLTag.AddStringParam('style', ActiveStyle);
    for i := 0 to Items.Count - 1 do
    begin
      with AHTMLTag.Contents.AddTag('label') do
      begin
        with Contents.AddTag('input') do
        begin
          AddStringParam('type', 'radio');
          Add(iif(FItemIndex = i, 'checked'));
          AddStringParam('name', AHTMLName + InputSuffix);
          AddStringParam('id', AHTMLName + InputSuffix + '_' + IntToStr(i));
          AddStringParam('value', IntToStr(i));
          if IsDisabled then
          begin
            Add('disabled');
          end;
        end;
        Contents.AddText(TextToHTML(iif(ItemsHaveValues, Items.Names[i], Items[i])));
      end;
      AHTMLTag.Contents.AddText('<br>');
    end;
  except
    FreeAndNil(AHTMLTag);
    raise;
  end;

  if Parent is TIWBS4InputGroup then
    AHTMLTag := IWBS4CreateInputGroupAddOn(AHTMLTag, AHTMLName, 'addon')
  else
    AHTMLTag := IWBS4CreateInputFormGroup(Self, Parent, AHTMLTag, Caption, AHTMLName);
end;
{$endregion}

end.

