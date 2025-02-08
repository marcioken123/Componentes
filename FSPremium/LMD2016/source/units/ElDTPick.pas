unit ElDTPick;
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

ElDTPick unit
--------------
TElDateTimePicker component.

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

November 2007 (EV):

[+] edfShortDateShortTime was added in the list of possible formats.

###############################################################################}

interface

uses
  SysUtils,
  Classes,
  TypInfo,
  Math,
  Types,
  Windows,
  Messages,
  Graphics,
  Controls,
  StdCtrls,
  Forms,
  Buttons,
  Menus,
  ExtCtrls,
  Clipbrd,
  ComCtrls,
  CommCtrl,
  ImgList,
  Grids,
  Themes,
  Variants,

  LMDTypes,
  LMDProcs,
  LMDDateUtils,
  LMDObjectList,
  LMDSysIn,
  LMDGraphUtils,
  LMDThemes,
  {$ifdef LMD_UNICODE}LMDUnicode,{$endif}
  LMDGlyphs,
  LMDStrings,
  LMDElConst,
  LMDClass,
  LMDGraph,
  LMDDropdownForm,

  ElImgFrm,
  ElSpinBtn,
  ElPopBtn,
  ElCalendarDefs,
  ElClock,
  ElVCLUtils,
  ElXPThemedControl,
  ElPanel,
  ElGroupBox,
  ElCalendar,
  ElSpin,
  ElCombos,
  ElBtnCtl;

type

  {
  Possible values for DPart :
  -1: plain text
  0 : year long (4 digits)
  1 : year short (2 digits)
  2 : month
  3 : day
  4 : hour long (24 hours)
  5 : hour short (12 hours)
  6 : minute
  7 : second
  8 : am/pm sign
  9 : separator
  10: day name
  11: milliseconds
  }
  TElCalendarForm = class;

  TDTFPart = record
  Text   : string;
    DPart  : integer;
    TSPos,
    TEPos,
    SPos,
    EPos   : integer;
  end;
  PDTFPart = ^TDTFPart;
  TElDatePickerFormat = (edfShortDateLongTime,
                         edfShortDateShortTime,
                         edfLongDate,
                         edfShortDate,
                         edfLongTime,
                         edfShortTime,
                         edfCustom);

  TElCalendarStyle = (csElCalendar, csMonthCalendar);

  TElDateTimePicker = class(TElXPThemedControl)
  private
    FUserNavigation: Boolean;
    function GetCalendarUserNavigation: Boolean;
    procedure SetCalendarUserNavigation(const Value: Boolean);
    procedure SetCalendarFormFont(const Value: TFont);
  protected
    FCustomCalendarNames: TElCustomCalendarNames;
    FIgnoreReadOnlyState: Boolean;
    FUnassignedChar : TLMDChar;
    FHandleDialogKeys: Boolean;
    FModified : Boolean;
    FShowCheckBox : Boolean;
    FChecked : Boolean;
    FAltChangeMethod : Boolean;
    FShowPopupCalendar : Boolean;
    FNavigationInPopup : boolean;
    FBorderStyle : TBorderStyle;
    FOnChange : TNotifyEvent;
    Use12Hours : boolean;
    FCalButton : TElGraphicButton;
    FButton    : TElSpinButton;
    FBtnWidth  : Integer;
    DTFParts   : TLMDObjectList;
    FFormatStr : string;
    FFormat    : TElDatePickerFormat;
    FDate      : TDateTime;
    FFocused   : boolean;
    FCurPart   : integer;
    FAlignment : TAlignment;
    FMouseOver : boolean;
    FForm      : TElCalendarForm;
    TmpDC      : HDC;
    FOnDropDown: TNotifyEvent;
    FGradientSteps : Integer;
    FGradientStartColor : TColor;
    FGradientEndColor : TColor;
    FTmpBmp : TBitmap;
    FTransparent : Boolean;
    FBackground : TBitmap;
    FBackgroundType : TLMDBackgroundType;
    FImgFormChLink  : TImgFormChangeLink;
    FImgForm : TElImageForm;
    FActiveBorderType : TElFlatBorderType;
    FInactiveBorderType : TElFlatBorderType;
    FFlat : boolean;
    FMinDate: TDateTime;
    FMaxDate: TDateTime;
    FFontMargin: Integer;

    FDI   : string;
    FText : TLMDString;
    FDroppedDown : boolean;
    InDblClick   : boolean;
    FOnCheckBoxChange: TNotifyEvent;
    FBorderSides: TLMDBorderSides;
    //FButtonWidth: Integer;
    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;
    FButtonVisible: Boolean;
    FUnassigned: Boolean;
    FUnassignedColor: TColor;
    FUnassignedAllowed: Boolean;
    FReadOnly: Boolean;
    FButtonShowOnFocus: Boolean;
    FUseCurrentDate: Boolean;
    FButtonThinFrame: Boolean;
    FAutoSize: Boolean;
    FAlwaysResetUnassigned: Boolean;
    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}
    FShowBlankWhenZero: Boolean;
    FAutoAdvance: Boolean;
    FFocusedSelectColor: TColor;
    FFocusedSelectTextColor: TColor;
    FHideSelectColor: TColor;
    FHideSelectTextColor: TColor;
    FHideSelection: Boolean;
    FHighlightAlphaLevel: Integer;
    FButtonColor: TColor;
    FButtonShowBorder: Boolean;
    FLinkedControlPosition: TElLinkCtlPos;
    FLinkedControl: TControl;
    FLinkedControlSpacing: Integer;
    FDropDownAlignment: TAlignment;
    FCalendarKeepWithinForm: Boolean;
    FButtonFlat: Boolean;
    FButtonOldStyled: Boolean;
    FDisabledColor: TColor;
    FDisabledFontColor: TColor;
    FUseDisabledColors: Boolean;
    FButtonUseSystemWidth: Boolean;
    FBorderColorDkShadow: TColor;
    FBorderColorFace: TColor;
    FBorderColorHighlight: TColor;
    FBorderColorShadow: TColor;
    FBorderColorWindow: TColor;
    FCalendarShowClock: Boolean;
    FShowTodayButton: Boolean;
    FLineColorLight: TColor;
    FLineColorDark: TColor;
    FCalendarBackColor: TColor;
    FCalendarFormColor: TColor;
    FCalendarFormFont: TFont;
    FStartOfWeek: TDayOfWeek;
    FWeekEndDays: TElWeekEndDays;
    FUseSystemStartOfWeek: Boolean;
    FUseLineColors: Boolean;
    FWeekendColor: TColor;
    FCalendarGridVertLines: Boolean;
    FCurrentDayBorder: TElFlatBorderType;
    FCalendarDayCellBorder: TElFlatBorderType;
    FCalendarSelectionBorder: TElFlatBorderType;
    FTranslateDays: Boolean;
    FCalendarHolidays: TElHolidays;
    FCalendarShowWeekNum: Boolean;
    FOnDetermineHoliday: TElHolidayEvent;
    FCalendarHolidayColor: TColor;
    FCalendarGridHorzLines: Boolean;
    FCalendarGridLineColor: TColor;
    FCalendarOtherMonthDayColor: TColor;
    FOnBeforeCellDraw: TBeforeCellDrawEvent;
    FCalendarShowOtherMonthDays: Boolean;
    FDisplayReadOnlyOptions: TElDisplayOptions;
    FCalendarLineBorderColor : TColor;
    FCalendarCurrentDayBitmap: TBitmap;
    FCalendarCurrentDayUseBitmap: Boolean;
    FOldFontChanged: TNotifyEvent;
    FUseMonthCalendar: Boolean;
    FCalendarFlatButtons: Boolean;
    function GetCalendarLiveClock(): Boolean;
    procedure SetCalendarLiveClock(AValue: Boolean);

    function GetThemedElementDetails(): TThemedElementDetails;

    procedure NamesChanged(Sender: TObject);
    procedure SetCustomCalendarNames(const Value: TElCustomCalendarNames);
    procedure ChangeBtnGlyph;
    function GetCalendarStyle: TElCalendarStyle;
    procedure SetCalendarStyle(const Value: TElCalendarStyle);
    procedure ChangeToNearValid(var ST: TSystemTime; Param: Integer);
    procedure FontChanged(Sender: TObject);
    procedure CalendarFormFontChange(Sender: TObject);
    procedure CalcFormSizes;
    procedure WMSize(var Msg : TWMSize); message WM_SIZE;
    procedure WMSysKeyDown(var Msg: TWMKeyDown); message WM_SYSKEYDOWN;
    procedure CMCancelMode(var Msg: TCMCancelMode); message CM_CANCELMODE;
    procedure CMCtl3DChanged(var Msg : TMessage); message CM_CTL3DCHANGED;
    procedure CMFontChanged(var Msg : TMessage); message CM_FONTCHANGED;
    procedure CMSysColorChange(var Msg : TMessage); message CM_SYSCOLORCHANGE;
    procedure CMMouseEnter(var Msg : TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure CMMouseWheel(var Msg: TMessage); message WM_MOUSEWHEEL;// CM_MOUSEWHEEL;
    procedure WMNCPaint(var Msg : TWMNCPaint); message WM_NCPAINT;
    procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
    procedure WMEraseBkgnd(var Msg : TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CMEnabledChanged(var Msg : TMessage); message CM_ENABLEDCHANGED;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMNCCalcSize(var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure IFMRepaintChildren(var Message: TMessage); message IFM_REPAINTCHILDREN;
    procedure KeyDown(var Key : Word; Shift : TShiftState); override;

    procedure SetDisplayReadOnlyOptions(const Value: TElDisplayOptions);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetImageForm(newValue : TElImageForm);
    procedure SetTransparent(newValue : boolean);
    procedure SetBackground(newValue : TBitmap);
    procedure SetBackgroundType(newValue : TLMDBackgroundType);
    procedure ImageChange(Sender : TObject);
    procedure CurrDayImageChange(Sender : TObject);
    procedure ImageFormChange(Sender : TObject);
    procedure SetGradientStartColor(newValue : TColor);
    procedure SetGradientEndColor(newValue : TColor);
    procedure SetGradientSteps(newValue : Integer);
    procedure RedoTmpBmp;
    procedure DrawFlatBorder;
    procedure PaintWindow(DC: HDC); override;
    procedure InvalidateEdit;
    procedure CloseUp(AcceptValue : boolean); virtual;
    procedure CalendarDeactivate(Sender : TObject);

    procedure SpinUpClick(Sender : TObject; Increment : Double);
    procedure SpinDownClick(Sender : TObject; Increment : Double);
    procedure CalBtnClick(Sender : TObject);

    procedure IncValue(Increment : integer);
    procedure ParseFormat(AFormat : string);
    procedure UpdatePart;
    procedure UpdateFrame;
    procedure UpdateText(ADate: TDateTime = 0); overload;
    procedure UpdateText(ST: TSystemTime); overload;
    procedure OnDTFPartDelete(Sender: TObject; var Item: TxListItem);

    function GetTextColor: TColor; virtual;
    function GetBkColor: TColor; virtual;

    function GetStdFormat(Fmt : TElDatePickerFormat) : string;
    procedure TuneupCalendarControls;

    function GetCalendarUseLineColors: Boolean;
    procedure SetCalendarUseLineColors(Value: Boolean);

    function StoreStartOfWeek: Boolean;
    function GetCalendarWeekendColor: TColor;
    procedure SetCalendarWeekendColor(Value: TColor);
    procedure DrawFlatFrame(Canvas : TCanvas; R : TRect);
    procedure SetBorderSides(Value: TLMDBorderSides);
    procedure SetFormat(newValue : TElDatePickerFormat); virtual;
    procedure SetFormatStr(newValue : String); virtual;
    procedure SetDateTime(newValue: TDateTime); virtual;
    procedure SetAlignment(Value: TAlignment); virtual;
    function  GetBtnWidth   : integer; virtual;
    function  GetCheckDims  : integer; virtual;
    function  GetCheckWidth : integer; virtual;
    procedure SetEditRect;
    function GetShowTodayButton: boolean;
    procedure SetShowTodayButton(Value: boolean);
    procedure DropDown; virtual;
    procedure Paint; override;
    procedure DoDropDown; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure TriggerChangeEvent; virtual;
    procedure SetActiveBorderType(newValue : TElFlatBorderType); virtual;
    procedure SetInactiveBorderType(newValue : TElFlatBorderType); virtual;
    procedure SetFlat(newValue : Boolean); virtual;
    procedure SetNavigationInPopup(newValue : boolean); virtual;
    procedure SetDate(newValue : TDateTime); virtual;
    function GetDate : TDateTime; virtual;

    procedure DisplayOptionsChange(Sender: TObject);

    procedure SetTime(newValue : TDateTime); virtual;
    function GetTime : TDateTime; virtual;
    function GetDroppedDown : boolean;
    procedure SetDroppedDown(newValue : boolean); virtual;
    function GetStartOfWeek: TDayOfWeek;
    procedure SetStartOfWeek(Value: TDayOfWeek);
    function GetWeekEndDays: TElWeekEndDays;
    procedure SetWeekEndDays(Value: TElWeekEndDays);
    procedure SetCalendarLineColorLight(Value: TColor);
    function GetCalendarLineColorDark: TColor;
    procedure SetCalendarLineColorDark(Value: TColor);
    function GetCalendarLineColorLight: TColor;
    function GetCalendarBackColor: TColor;
    procedure SetCalendarBackColor(Value: TColor);
    function GetCalendarFormColor: TColor;
    procedure SetCalendarFormColor(Value: TColor);
    procedure SetCalendarFlatBtn(Value: Boolean);
    function GetCalendarFlatBtn: Boolean;
    function GetUseSystemStartOfWeek: Boolean;
    procedure SetUseSystemStartOfWeek(Value: Boolean);

    procedure Notification(AComponent : TComponent; operation : TOperation); override;
    procedure CreateParams(var Params : TCreateParams); override;
    procedure Loaded; override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure AdjustHeight;
    procedure UpdateHeight;
    procedure CreateWnd; override;
    procedure SetShowPopupCalendar(newValue : Boolean); virtual;
    procedure CalendarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CalendarChange(Sender: TObject);

    procedure DblClick; override;

    procedure SetShowCheckBox(newValue : Boolean); virtual;
    procedure SetChecked(newValue : Boolean); virtual;
    procedure SetModified(newValue : Boolean); virtual;
    procedure TriggerCheckboxChangeEvent;
    function GetCalendarCurrentDayBorder: TElFlatBorderType;
    procedure SetCalendarCurrentDayBorder(Value: TElFlatBorderType);
    function GetCalendarDayCellBorder: TElFlatBorderType;
    procedure SetCalendarDayCellBorder(Value: TElFlatBorderType);
    function GetCalendarSelectionBorder: TElFlatBorderType;
    procedure SetCalendarSelectionBorder(Value: TElFlatBorderType);
    procedure SetMinDate(Value: TDateTime);
    procedure SetMaxDate(Value: TDateTime);
    function DoSetDateTime(ADate : TDateTime): Boolean;
    function GetThemedElement: TThemedElement; override;
    procedure SetUseXPThemes(const Value: Boolean); override;
    procedure DoThemeChanged; override;
    function GetButtonDir: TElSpinBtnDir;
    procedure SetButtonDir(Value: TElSpinBtnDir);
    function GetButtonType: TElSpinBtnType;
    procedure SetButtonType(Value: TElSpinBtnType);
    procedure SetButtonWidth(Value: Integer);
    procedure SetLineBorderActiveColor(Value: TColor);
    procedure SetLineBorderInactiveColor(Value: TColor);
    procedure UpdateButtonStyles;
    procedure SetButtonVisible(Value: Boolean);
    procedure SetUnassigned(Value: Boolean);
    procedure SetUnassignedColor(Value: TColor);
    procedure SetUnassignedAllowed(Value: Boolean);
    function GetReadOnly: Boolean; virtual;
    procedure SetReadOnly(Value: Boolean); virtual;
    procedure SetButtonShowOnFocus(Value: Boolean);
    function IsDateTimeStored: Boolean;
    procedure SetButtonThinFrame(Value: Boolean);
    procedure SetAutoSize(Value: Boolean); reintroduce;

    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message:TCMHintShow); message CM_HINTSHOW;
    {$endif}
    function GetUnassignedChar: TLMDString;
    procedure SetUnassignedChar(Value: TLMDString);
    function MakeUnassignedString(Length : integer): TLMDString;
    function GetTranslateDays: Boolean;
    procedure SetTranslateDays(Value: Boolean);
    function GetCalendarHolidays: TElHolidays;
    procedure SetCalendarHolidays(Value: TElHolidays);
    function SeparatorValue(Symbol : char): Char;
    procedure KeyPress(var Key : char); override;
    function GetCalendarShowWeekNum: Boolean;
    procedure SetCalendarShowWeekNum(Value: Boolean);
    function GetOnDetermineHoliday: TElHolidayEvent;
    procedure SetOnDetermineHoliday(Value: TElHolidayEvent);
    function GetCalendarHolidayColor: TColor;
    procedure SetCalendarHolidayColor(Value: TColor);
    procedure AdvancePosition;
    procedure SetFocusedSelectColor(newValue: TColor);
    procedure SetFocusedSelectTextColor(newValue: TColor);
    procedure SetHideSelectColor(newValue: TColor);
    procedure SetHideSelectTextColor(newValue: TColor);
    procedure SetHideSelection(Value: Boolean);
    procedure SetHighlightAlphaLevel(Value: Integer);
    procedure SetButtonColor(Value: TColor);
    procedure SetButtonShowBorder(Value: Boolean);
    procedure SetLinkedControlPosition(Value: TElLinkCtlPos);
    procedure SetLinkedControl(Value: TControl);
    procedure SetLinkedControlSpacing(Value: Integer);
    procedure UpdateLinkedControl;
    function GetCalendarGridVertLines: Boolean;
    procedure SetCalendarGridVertLines(Value: Boolean);
    function GetCalendarGridHorzLines: Boolean;
    procedure SetCalendarGridHorzLines(Value: Boolean);
    function GetCalendarGridLineColor: TColor;
    procedure SetCalendarGridLineColor(Value: TColor);
    function GetCalendarLineBorderColor: TColor;
    procedure SetCalendarLineBorderColor(Value : TColor);
    function GetCalendarCurrentDayBitmap: TBitmap;
    procedure SetCalendarCurrentDayBitmap(Value : TBitmap);
    function GetCalendarCurrentDayUseBitmap: Boolean;
    procedure SetCalendarCurrentDayUseBitmap(Value : Boolean);
    procedure SetButtonFlat(Value: Boolean);
    procedure SetButtonOldStyled(Value: Boolean);
    procedure SetDisabledColor(Value: TColor);
    procedure SetDisabledFontColor(Value: TColor);
    procedure SetUseDisabledColors(Value: Boolean);
    procedure ReadChangeDisabledText(Reader : TReader);
    procedure DefineProperties(Filer : TFiler); override;
    procedure SetButtonUseSystemWidth(Value: Boolean);
    function GetActiveButtonWidth: Integer;
    function GetText : String;
    procedure DestroyWnd; override;
    function GetCalendarOtherMonthDayColor: TColor;
    procedure SetCalendarOtherMonthDayColor(Value: TColor);
    function GetOnBeforeCellDraw : TBeforeCellDrawEvent;
    procedure SetOnBeforeCellDraw(Value: TBeforeCellDrawEvent);
    function GetCalendarShowOtherMonthDays: Boolean;
    procedure SetCalendarShowOtherMonthDays(Value: Boolean);
    procedure SetCalendarShowClock(Value: Boolean);
    procedure SetBorderColorDkShadow(Value: TColor);
    procedure SetBorderColorFace(Value: TColor);
    procedure SetBorderColorHighlight(Value: TColor);
    procedure SetBorderColorShadow(Value: TColor);
    procedure SetBorderColorWindow(Value: TColor);

    procedure Clipbrd_Copy;
    procedure Clipbrd_Paste;
    procedure Clipbrd_Cut;
    procedure WMSetRedraw(var Message: TWMSetRedraw); message WM_SETREDRAW;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    procedure SetCalendarDate(Date : TDateTime);

    property MouseOver   : boolean read FMouseOver;

    property DroppedDown : boolean read GetDroppedDown write SetDroppedDown;
    property AlwaysResetUnassigned: Boolean read FAlwaysResetUnassigned write
        FAlwaysResetUnassigned default false;

    property Date : TDateTime read GetDate write SetDate;
    property Time : TDateTime read GetTime write SetTime;
    property ShowBlankWhenZero: Boolean read FShowBlankWhenZero write
        FShowBlankWhenZero default false;
    property CalendarHolidays: TElHolidays read GetCalendarHolidays write
        SetCalendarHolidays;
    property Text : String read GetText;

  published
    property CustomCalendarNames: TElCustomCalendarNames read FCustomCalendarNames write SetCustomCalendarNames;
    property DisplayReadOnlyOptions: TElDisplayOptions read FDisplayReadOnlyOptions write SetDisplayReadOnlyOptions;
    property Format : TElDatePickerFormat read FFormat write SetFormat default edfShortDateLongTime;
    property FormatString : String read FFormatStr write SetFormatStr;  { Published }
    property DateTime: TDateTime read FDate write SetDateTime stored IsDateTimeStored;
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property ImageForm : TElImageForm read FImgForm write SetImageForm;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default true;
    property GradientStartColor : TColor read FGradientStartColor write SetGradientStartColor default clBlack;  { Protected }
    property GradientEndColor : TColor read FGradientEndColor write SetGradientEndColor default clBlack;  { Protected }
    property GradientSteps : Integer read FGradientSteps write SetGradientSteps default 16;  { Protected }
    property Background : TBitmap read FBackground write SetBackground;
    property BackgroundType : TLMDBackgroundType read FBackgroundType write SetBackgroundType default bgtColorFill;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property BorderColorDkShadow: TColor read FBorderColorDkShadow write
        SetBorderColorDkShadow default cl3DDkShadow;
    property BorderColorFace: TColor read FBorderColorFace write SetBorderColorFace
        default clBtnFace;
    property BorderColorHighlight: TColor read FBorderColorHighlight write
        SetBorderColorHighlight default clBtnHighlight;
    property BorderColorShadow: TColor read FBorderColorShadow write
        SetBorderColorShadow default clBtnShadow;
    property Transparent : Boolean read FTransparent write SetTransparent default false; { Protected }
    property ActiveBorderType : TElFlatBorderType read FActiveBorderType write SetActiveBorderType default fbtSunken;
    property InactiveBorderType : TElFlatBorderType read FInactiveBorderType write SetInactiveBorderType default fbtSunkenOuter;
    property Flat : Boolean read FFlat write SetFlat default false;
    property FontMargin: Integer read FFontMargin write FFontMargin default 1;
    property ShowPopupCalendar : Boolean read FShowPopupCalendar write SetShowPopupCalendar default false;  { Published }
    property NavigationInPopup : boolean read FNavigationInPopup write SetNavigationInPopup default true;
    property AltChangeMethod : Boolean read FAltChangeMethod write FAltChangeMethod default False;  { Published }
    property ShowCheckBox : Boolean read FShowCheckBox write SetShowCheckBox default False;  { Published }
    property ShowTodayButton: boolean read GetShowTodayButton write SetShowTodayButton stored True default True;
    property Checked  : Boolean read FChecked write SetChecked default True;  { Published }
    property Modified : Boolean read FModified write SetModified default False;  { Published }
    property HighlightAlphaLevel: Integer read FHighlightAlphaLevel write SetHighlightAlphaLevel default 255;
    property BtnWidth : integer read GetBtnWidth;
    property DisabledColor: TColor read FDisabledColor write SetDisabledColor default clBtnFace;
    property DisabledFontColor: TColor read FDisabledFontColor write
        SetDisabledFontColor default clGrayText;
    property UseDisabledColors: Boolean read FUseDisabledColors write
        SetUseDisabledColors default false;

    property CalendarLineColorDark: TColor read GetCalendarLineColorDark write
        SetCalendarLineColorDark stored True default clBtnFace;
    property CalendarLineColorLight: TColor read GetCalendarLineColorLight write
        SetCalendarLineColorLight stored True default clWindow;
    property CalendarBackColor: TColor read GetCalendarBackColor write
        SetCalendarBackColor stored True default clWindow;
    property CalendarFormColor: TColor read GetCalendarFormColor write
        SetCalendarFormColor stored True default clBtnFace;
    property CalendarFormFont: TFont read FCalendarFormFont write SetCalendarFormFont;
    property StartOfWeek: TDayOfWeek read GetStartOfWeek write SetStartOfWeek
        stored True default 0;
    property UseSystemStartOfWeek: Boolean read GetUseSystemStartOfWeek write
        SetUseSystemStartOfWeek stored True default True;
    property WeekEndDays: TElWeekEndDays read GetWeekEndDays write SetWeekEndDays stored true;
    property CalendarUseLineColors: Boolean read GetCalendarUseLineColors write
        SetCalendarUseLineColors stored true default False;
    property CalendarWeekendColor: TColor read GetCalendarWeekendColor write
        SetCalendarWeekendColor stored true default clRed;
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides default [ebsLeft, ebsRight, ebsTop, ebsBottom];
    property CalendarCurrentDayBorder: TElFlatBorderType read
        GetCalendarCurrentDayBorder write SetCalendarCurrentDayBorder default fbtSunken;
    property CalendarCurrentDayUseBitmap: Boolean read GetCalendarCurrentDayUseBitmap write SetCalendarCurrentDayUseBitmap default False;
    property CalendarCurrentDayBitmap: TBitmap read GetCalendarCurrentDayBitmap write SetCalendarCurrentDayBitmap;
    property CalendarLineBorderColor: TColor read GetCalendarLineBorderColor write SetCalendarLineBorderColor default clWindowText;
    property CalendarDayCellBorder: TElFlatBorderType read GetCalendarDayCellBorder
        write SetCalendarDayCellBorder default fbtLine;
    property CalendarSelectionBorder: TElFlatBorderType read
        GetCalendarSelectionBorder write SetCalendarSelectionBorder default fbtSunken;
    property MinDate: TDateTime read FMinDate write SetMinDate;
    property MaxDate: TDateTime read FMaxDate write SetMaxDate;
    property HandleDialogKeys: Boolean read FHandleDialogKeys write
        FHandleDialogKeys default false;
    property ButtonDir: TElSpinBtnDir read GetButtonDir write SetButtonDir default sbdUpDown;
    property ButtonType: TElSpinBtnType read GetButtonType write SetButtonType default sbtUpDown;
    property ButtonWidth: Integer read FBtnWidth write SetButtonWidth nodefault;
    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor default clBtnFace;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor default clBtnFace;
    property ButtonVisible: Boolean read FButtonVisible write SetButtonVisible
        default true;
    property Unassigned: Boolean read FUnassigned write SetUnassigned default false;
    property UnassignedColor: TColor read FUnassignedColor write SetUnassignedColor
        default clRed;
    property UnassignedAllowed: Boolean read FUnassignedAllowed write
        SetUnassignedAllowed default false;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default false;
    property ButtonShowOnFocus: Boolean read FButtonShowOnFocus write
        SetButtonShowOnFocus default false;
    property UseCurrentDate: Boolean read FUseCurrentDate write FUseCurrentDate
        default false;
    property ButtonThinFrame: Boolean read FButtonThinFrame write
        SetButtonThinFrame default True;
    property UnassignedChar: TLMDString read GetUnassignedChar write
        SetUnassignedChar;
    property TranslateDays: Boolean read GetTranslateDays write SetTranslateDays default False;
    property CalendarShowWeekNum: Boolean read GetCalendarShowWeekNum write
        SetCalendarShowWeekNum default False;
    property CalendarFlatButtons: Boolean read GetCalendarFlatBtn write SetCalendarFlatBtn default True;
    property OnDetermineHoliday: TElHolidayEvent read GetOnDetermineHoliday write
        SetOnDetermineHoliday;
    property CalendarHolidayColor: TColor read GetCalendarHolidayColor write
        SetCalendarHolidayColor default clWindowText;
    property AutoAdvance: Boolean read FAutoAdvance write FAutoAdvance default
        false;
    property FocusedSelectColor: TColor read FFocusedSelectColor write
        SetFocusedSelectColor default clHighlight;
    property FocusedSelectTextColor: TColor read FFocusedSelectTextColor write
        SetFocusedSelectTextColor default clHighlightText;
    property HideSelectColor: TColor read FHideSelectColor write SetHideSelectColor
        default clBtnFace;
    property HideSelectTextColor: TColor read FHideSelectTextColor write
        SetHideSelectTextColor default LMDElHideSelectTextColor;
    property HideSelection: Boolean read FHideSelection write SetHideSelection
        default true;
    property ButtonColor: TColor read FButtonColor write SetButtonColor default
        clBtnFace;
    property ButtonShowBorder: Boolean read FButtonShowBorder write
        SetButtonShowBorder default true;
    property LinkedControlPosition: TElLinkCtlPos read FLinkedControlPosition write
        SetLinkedControlPosition default lcpTopLeft;
    property LinkedControl: TControl read FLinkedControl write SetLinkedControl;
    property LinkedControlSpacing: Integer read FLinkedControlSpacing write
        SetLinkedControlSpacing default 0;
    property DropDownAlignment: TAlignment read FDropDownAlignment write
        FDropDownAlignment  default taRightJustify;
    property CalendarKeepWithinForm: Boolean read FCalendarKeepWithinForm write
        FCalendarKeepWithinForm default false;
    property CalendarGridVertLines: Boolean read GetCalendarGridVertLines write
        SetCalendarGridVertLines stored True default True;
    property CalendarGridHorzLines: Boolean read GetCalendarGridHorzLines write
        SetCalendarGridHorzLines stored True default True;
    property CalendarGridLineColor: TColor read GetCalendarGridLineColor write
        SetCalendarGridLineColor default clBtnFace;
    property ButtonFlat: Boolean read FButtonFlat write SetButtonFlat default false;
    property ButtonOldStyled: Boolean read FButtonOldStyled write
        SetButtonOldStyled default false;
    property ButtonUseSystemWidth: Boolean read FButtonUseSystemWidth write
        SetButtonUseSystemWidth default false;
    property CalendarOtherMonthDayColor: TColor read GetCalendarOtherMonthDayColor
        write SetCalendarOtherMonthDayColor default clGrayText;
    property CalendarShowOtherMonthDays: Boolean read GetCalendarShowOtherMonthDays
        write SetCalendarShowOtherMonthDays default False;
    property CalendarUserNavigation: Boolean read GetCalendarUserNavigation
        write SetCalendarUserNavigation default False;

    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property OnBeforeCellDraw: TBeforeCellDrawEvent read GetOnBeforeCellDraw write
        SetOnBeforeCellDraw;
    property OnCheckBoxChange: TNotifyEvent read FOnCheckBoxChange write
        FOnCheckBoxChange;

    property CalendarShowClock: Boolean read FCalendarShowClock write
        SetCalendarShowClock default False;
    property CalendarStyle: TElCalendarStyle read GetCalendarStyle write SetCalendarStyle default csElCalendar;
    property CalendarLiveClock: Boolean read GetCalendarLiveClock write SetCalendarLiveClock default False;

    property Anchors;
    property Constraints;
    property DockOrientation;
    property DragKind;
    property Align;
    property Color default clWindow;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor default False;
    property ImeMode;
    property ImeName;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;

    { Inherited events: }
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

    property OnStartDock;
    property OnEndDock;
    property BorderColorWindow: TColor read FBorderColorWindow write
        SetBorderColorWindow default clWindow;

  end;  { TElDateTimePicker }

  TElTClock = class(TElClock)
  protected
    FOnKick: TNotifyEvent;
  public
    procedure Kick; override;
    property OnKick: TNotifyEvent read FOnKick write FOnKick;
  end;

  TElCalendarForm = class(TLMDDropDownForm)
    procedure FormCreate(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure TodayBtnClick(Sender : TObject);
    procedure CalendarChange(Sender : TObject);
    procedure CalendarClick(Sender: TObject);
    procedure ClearBtnClick(Sender : TObject);
    procedure RangeButtons;
  private
    FCustomCalendarNames: TElCustomCalendarNames;
    FFlatButtons: Boolean;
    FShowTodayButton: boolean;
    FShowClock: Boolean;
    FUseMonthCalendar: Boolean;
    FCalendarLiveClock: Boolean;
    FTag: Integer;
    procedure WMNotify(var Msg : TWMNotify); message WM_NOTIFY;
    procedure WMActivate(var Msg : TWMActivate); message WM_ACTIVATE;
    procedure SetShowTodayButton(const Value: Boolean);
    procedure SetShowClock(const Value: Boolean);
    procedure SetFlatButtons(const Value: Boolean);
    procedure SetUseMonthCalendar(const Value: Boolean);
    procedure SetCustomCalendarNames(const Value: TElCustomCalendarNames);
  public
    Unassigned : boolean;
    TodayBtn: TElPopupButton;
    ClearBtn: TElPopupButton;
    Panel3  : TElPanel;
    OkBtn: TElPopupButton;
    CancelBtn: TElPopupButton;

    CalendarGB : TElGroupBox;
    ClockGB : TElGroupBox;
    ClockPanel  : TElPanel;
    CalendarPanel  : TElPanel;
    Calendar: TElCalendar;
    Panel1: TElPanel;
    PrevMonBtn: TElPopupButton;
    PrevYearBtn: TElPopupButton;
    NextMonBtn: TElPopupButton;
    NextYearBtn: TElPopupButton;
    YearSpin: TElSpinEdit;
    MonthCombo: TElComboBox;
    Clock: TElTClock;
    PanelCl  : TElPanel;
    TimeDTP: TELDateTimePicker;
    MCalendar: TMonthCalendar;

    procedure SetFormThemed(Value: Boolean);  override;
    procedure SetThemeMode(AMode: TLMDThemeMode); override;

    procedure CalcFormSizes;
    procedure ClockKick(Sender : TObject);
    procedure TimeChange(Sender : TObject);
//    procedure TimesSpinChange(Sender : TObject);
    procedure PrevYearBtnClick(Sender : TObject);
    procedure PrevMonBtnClick(Sender : TObject);
    procedure MonthComboChange(Sender : TObject);
    procedure NextMonBtnClick(Sender : TObject);
    procedure NextYearBtnClick(Sender : TObject);
    procedure YearSpinChange(Sender : TObject);

    procedure SetNames;
    procedure UpdateLabel;
    destructor Destroy; override;
    constructor CreateNew(AOwner : TComponent; Dummy: Integer); override;
    property FlatButtons: Boolean read FFlatButtons write SetFlatButtons default True;
    property ShowTodayButton: Boolean read FShowTodayButton write SetShowTodayButton default True;
    property ShowClock: Boolean read FShowClock write SetShowClock default True;
    property UseMonthCalendar: Boolean read FUseMonthCalendar write SetUseMonthCalendar default False;
    property CustomCalendarNames: TElCustomCalendarNames read FCustomCalendarNames write SetCustomCalendarNames;
    property CalendarLiveClock: Boolean read FCalendarLiveClock write FCalendarLiveClock;
  end;

var ClearCap,
    TodayCap,
    OkCap,
    CancelCap,
    CalendarCap,
    CapCalendarGB,
    CapClockGB,
    NextYearHint,
    NextMonthHint,
    PrevYearHint,
    PrevMonthHint : TLMDString;

implementation

uses
  ElCalendDlg,
  LMDUtils,
  ElEdits,
  UxTheme;

procedure TElDateTimePicker.IncValue(Increment : integer);
var
  Part : PDTFPart;
  ST   : TSystemTime;
  DT   : TDateTime;
  i, j : integer;
begin
  if FCurPart = -1 then exit;
  Part := PDTFPart(DTFParts[FCurPart]);
  DateTimeToSystemTime(FDate, ST);
  case Part.DPart of
    0:
       begin
         if FAltChangeMethod then
         begin
           if (Increment > 0) or (FDate >= 367) then
           begin
             if Increment < 0 then
             begin
               if IsLeapYear(ST.wYear - 1) then
                  DoSetDateTime(FDate - 366)
               else
                  DoSetDateTime(FDate - 365);
             end else
             begin
               if IsLeapYear(ST.wYear + 1) then
                  DoSetDateTime(FDate + 366)
               else
                  DoSetDateTime(FDate + 365);
             end;
           end;
           DateTimeToSystemTime(FDate, ST);
           FDate := FDate - 1;
         end
         else
         begin
           ST.wYear := ST.wYear + Increment;
           ST.wDay := Min(LMDDaysPerMonth(ST.wYear, ST.wMonth), ST.wDay);
         end;
       end;
    1: begin
         if FAltChangeMethod then
         begin
           if (Increment > 0) or (FDate >= 367) then
           begin
             if Increment < 0 then
             begin
               if IsLeapYear(ST.wYear - 1) then
                  DoSetDateTime(FDate - 366)
               else
                  DoSetDateTime(FDate - 365);
             end else
             begin
               if IsLeapYear(ST.wYear) then
                  DoSetDateTime(FDate + 366)
               else
                  DoSetDateTime(FDate + 365);
             end;
           end;
           DateTimeToSystemTime(FDate, ST);
           FDate := FDate - 1;
         end else
         begin
           i := ST.wYear mod 100;
           i := i + Increment;
           if i > 100 then
              i := i mod 100
           else
           if i < 0 then
              i := 100 + (i mod 100);
           if i > 50 then
              ST.wYear := 1900 + i
           else
              ST.wYear := 2000 + i;
           ST.wDay := Min(LMDDaysPerMonth(ST.wYear, ST.wMonth), ST.wDay);
         end;
       end;
    2: begin
         if FAltChangeMethod then
         begin
           if Increment < 0 then
           begin
             if ST.wMonth = 1 then
                i := LMDDaysPerMonth(ST.wYear - 1, 12)
             else
                i := LMDDaysPerMonth(ST.wYear, ST.wMonth - 1);
             if st.wDay > i then
               DoSetDateTime(FDate - LMDDaysPerMonth(ST.wYear, ST.wMonth))
             else
               DoSetDateTime(FDate - i);
           end else
           begin
             if ST.wMonth = 12 then
                i := LMDDaysPerMonth(ST.wYear + 1, 1)
             else
                i := LMDDaysPerMonth(ST.wYear, ST.wMonth + 1);
             if ST.wDay > i then
               DoSetDateTime(FDate + LMDDaysPerMonth(ST.wYear, ST.wMonth) - st.wDay + i)
             else
               DoSetDateTime(FDate + LMDDaysPerMonth(ST.wYear, ST.wMonth));
           end;
           DateTimeToSystemTime(FDate, ST);
           FDate := FDate - 1;
         end
         else
         begin
           j := ST.wMonth;
           j := j + Increment;
           if j > 12 then
              j := j mod 12;
           if j < 1 then
              j := 12 + j mod 12;
           if j = 0 then j := 12;
           ST.wMonth := j;
           ST.wDay := Min(LMDDaysPerMonth(ST.wYear, ST.wMonth), ST.wDay);
         end;
       end;
    3,
    10:begin
         if FAltChangeMethod then
         begin
           DoSetDateTime(FDate + Increment);
           DateTimeToSystemTime(FDate, ST);
           FDate := FDate - 1;
         end
         else
         begin
           i := LMDDaysPerMonth(ST.wYear, ST.wMonth);
           ST.wDay := ST.wDay + Increment;
           if ST.wDay > i then
              ST.wDay := ST.wDay mod i;
           if ST.wDay < 1 then
              ST.wDay := i + ST.wDay mod i;
           if ST.wDay = 0 then ST.wDay := i;
         end;
       end;
    4,
    5: begin
         if FAltChangeMethod then
         begin
           DoSetDateTime(LMDIncTime(FDate, Increment, 0, 0, 0));
           DateTimeToSystemTime(FDate, ST);
           FDate := FDate - 1;
         end
         else
         begin
           i := 24;
           j := ST.wHour;
           j := j + Increment;
           if j >= i then
              j := j mod i;
           if j < 0 then
              j := i + j mod i;
           ST.wHour := j;
         end;
       end;
    6: begin
         if FAltChangeMethod then
         begin
           DoSetDateTime(LMDIncTime(FDate, 0, Increment, 0, 0));
           DateTimeToSystemTime(FDate, ST);
           FDate := FDate - 1;
         end
         else
         begin
           i := 59;
           j := ST.wMinute;
           j := j + Increment;
           if j > i then
              j := (j - 1) mod i;
           if j < 0 then
              j := i + (j + 1) mod i;
           if j < 0 then
              j := i;
           ST.wMinute := j;
         end;
       end;
    7: begin
         if FAltChangeMethod then
         begin
           DoSetDateTime(LMDIncTime(FDate, 0, 0, Increment, 0));
           DateTimeToSystemTime(FDate, ST);
           FDate := FDate - 1;
         end else
         begin
           i := 59;
           j := ST.wSecond;
           j := j + Increment;
           if j > i then
              j := (j - 1) mod i;
           if j < 0 then
              j := i + (j + 1) mod i;
           if j < 0 then
              j := i;
           ST.wSecond := j;
         end;
       end;
    11: begin
         if FAltChangeMethod then
         begin
           DoSetDateTime(LMDIncTime(FDate, 0, 0, 0, Increment));
           DateTimeToSystemTime(FDate, ST);
           FDate := FDate - 1;
         end
         else
         begin
           i := 999;
           j := ST.wMilliseconds;
           j := j + Increment;
           if j > i then
              j := (j - 1) mod i;
           if j < 0 then
              j := i + (j + 1) mod i;
           if j < 0 then
              j := i;
           ST.wMilliseconds := j;
         end;
       end;
    8: begin
         if FAltChangeMethod then
         begin
           if Increment > 0 then
              DoSetDateTime(LMDIncTime(FDate, 12, 0, 0, 0))
           else
              DoSetDateTime(LMDIncTime(FDate, -12, 0, 0, 0));

           DateTimeToSystemTime(FDate, ST);
           FDate := FDate - 1;
         end else
         begin
           if ST.wHour >= 12 then
              ST.wHour := ST.wHour - 12
           else
              ST.wHour := ST.wHour + 12;
         end;
       end;
  end;
  DT := SystemTimeToDateTime(ST);
  if DT <> FDate then
  begin
    DoSetDateTime(DT);
    UpdateText;
    TriggerChangeEvent;
    InvalidateEdit;
  end;
end;

procedure TElDateTimePicker.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TElDateTimePicker.UpdatePart;
var
  i: integer;
  Part: PDTFPart;
begin
  if (FCurPart <> -1) then
     Part := PDTFPart(DTFParts[FCurPart])
  else
     Part := nil;
  if (Part = nil) or (not (Part.DPart in [0, 1, 2, 3, 4, 6, 7, 8, 11])) then
  begin
    for i := 0 to DTFParts.Count - 1 do
    begin
      Part := PDTFPart(DTFParts[i]);
      if (Part.DPart in [0, 1, 2, 3, 4, 6, 7, 8, 11]) then
      begin
        FCurPart := i;
        FDI := '';
        exit;
      end;
    end;
    FCurPart := -1;
    FDI := '';
  end;
end;

procedure TElDateTimePicker.UpdateText(ADate: TDateTime = 0);
var
  ST : TSystemTime;
begin
  if ADate = 0 then
    ADate := FDate;
  DateTimeToSystemTime(ADate, ST);
  ST.WDayOfWeek := DayOfWeek(ADate) - 1;
  UpdateText(ST);
end;

procedure TElDateTimePicker.UpdateText(ST: TSystemTime);
var i  : integer;
    s,
    S1 : TLMDString;
    Part : PDTFPart;
    R  : TRect;
    x  : integer;
begin
  S := '';
  x := 0;

  Canvas.Font.Assign(Font);

  for i := 0 to DTFParts.Count - 1 do
  begin
    Part := PDTFPart(DTFParts[i]);
    case Part.DPart of
      -1: begin
            S1 := Part.Text;
            //Part.SPos := Length(S) + 1;
            //Part.EPos := Part.SPos + Length(S1);
          end;
       0: begin
            if Unassigned then
              S1 := MakeUnassignedString(4)
            else
            begin
              S1 := SysUtils.Format('%4u', [ST.wYear]);
              if S1[1] = ' ' then S1[1] := '0';
              if S1[2] = ' ' then S1[2] := '0';
              if S1[3] = ' ' then S1[3] := '0';
            end;
          end;
       1: begin
            if Unassigned then
              S1 := MakeUnassignedString(2)
            else
            begin
              S1 := SysUtils.Format('%.2d', [ST.wYear mod 100]);
//              if S1[1] = ' ' then S1[1] := '0';
            end;
          end;
       2: begin
            if Unassigned then
              S1 := MakeUnassignedString(2)
            else
            begin
              if Part.Text = 'M' then
                S1 := IntToStr(St.wMonth)
              else
              if Part.Text = 'MM' then
              begin
                if ST.wMonth < 10 then
                  S1 := '0' + IntToStr(St.wMonth)
                else
                  S1 := IntToStr(St.wMonth);
              end else
              if Part.Text = 'MMM' then
                S1 := FCustomCalendarNames.GetShortMonthNames(St.wMonth)
              else
              if Part.Text = 'MMMM' then
                S1 := FCustomCalendarNames.GetLongMonthNames(St.wMonth);
            end;
          end;
       3: begin
            if Unassigned then
              S1 := MakeUnassignedString(2)
            else
            begin
              if Length(Part.Text) = 1 then
              begin
                S1 := IntToStr(St.wDay)
              end else
              begin
                if St.wDay < 10 then
                  S1 := '0' + IntToStr(St.wDay)
                else
                  S1 := IntToStr(St.wDay);
              end;
            end;
          end;
       4: begin
            if Unassigned then
              S1 := MakeUnassignedString(2)
            else
            begin
              if Use12Hours then
              begin
                if ST.wHour mod 12 = 0 then
                   S1 := '12'
                else
                   S1:= IntToStr(ST.wHour mod 12);
                if (Length(Part.Text) = 2) and (Length(S1) = 1) then
                  Insert('0', S1, 1);
              end
              else
              begin
                S1:= IntToStr(ST.wHour);
                if (Length(Part.Text) = 2) and (Length(S1) = 1) then
                  Insert('0', S1, 1);
              end;
            end;
          end;
       6: begin
            if Unassigned then
              S1 := MakeUnassignedString(2)
            else
            begin
              if Length(Part.Text) = 1 then
              begin
                S1 := IntToStr(St.wMinute)
              end else
              begin
                if St.wMinute < 10 then
                  S1 := '0' + IntToStr(St.wMinute)
                else
                  S1 := IntToStr(St.wMinute);
              end;
            end;
          end;
       7: begin
            if Unassigned then
              S1 := MakeUnassignedString(2)
            else
            begin
              if Length(Part.Text) = 1 then
              begin
                S1 := IntToStr(St.wSecond)
              end else
              begin
                if St.wSecond < 10 then
                  S1 := '0' + IntToStr(St.wSecond)
                else
                  S1 := IntToStr(St.wSecond);
              end;
            end;
          end;
       8: begin
            if Unassigned then
              S1 := 'am'
            else
            begin
              S1 := lowercase(Part.Text);
              if s1 = 'ampm' then
              begin
                if ST.wHour < 12 then
                   S1 := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimeAMString
                else
                   S1 := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimePMString;
              end else
              if s1 = 'am/pm' then
              begin
                if ST.wHour < 12 then
                   S1 := Copy(Part.Text, 1, 2)
                else
                   S1 := Copy(Part.Text, 4, 2);
              end else
              if s1 = 'a/p' then
              begin
                if ST.wHour < 12 then
                   S1 := Part.Text[1]
                else
                   S1 := Part.Text[3];
              end;
            end;
          end;
       9: begin
            if Part.Text = '/' then
               S1 := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DateSeparator
            else
            if Part.Text = ':' then
               S1 := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimeSeparator;
          end;
       10:begin
            if Length(Part.Text) = 3 then
               S1 := FCustomCalendarNames.GetShortDayNames(ST.wDayOfWeek + 1)
            else
               S1 := FCustomCalendarNames.GetLongDayNames(ST.wDayOfWeek + 1);
          end;
       11:begin
            if Unassigned then
              S1 := MakeUnassignedString(3)
            else
            begin
              if Part.Text = 'Z' then
                S1 := IntToStr(St.wMilliseconds)
              else
              if Part.Text = 'ZZZ' then
              begin
                if ST.wMilliseconds < 10 then
                  S1 := '00' + IntToStr(St.wMilliseconds)
                else
                if ST.wMilliseconds < 100 then
                  S1 := '0' + IntToStr(St.wMilliseconds)
                else
                  S1 := IntToStr(St.wMilliseconds);
              end;
            end;
          end;
    end;

    Part.TSPos := Length(S) + 1;
    Part.TEPos := Part.TSPos + Length(S1);

    Part.SPos := X;

    SetRectEmpty(R);

    LMDDrawText(Canvas.Handle, S1, Length(S1), R, DT_LEFT or DT_SINGLELINE or DT_TOP or DT_CALCRECT);
    Part.EPos := Part.SPos + R.Right - R.Left + 1;

    if Canvas.Font.Style = [fsBold] then
      Inc(X, (R.Right - R.Left) - FFontMargin)
    else
    if (Canvas.Font.Style = [fsItalic]) then
      Inc(X, (R.Right - R.Left) - FFontMargin + 5)
    else
    if (Canvas.Font.Style = [fsItalic, fsBold]) then
      Inc(X, (R.Right - R.Left) - FFontMargin + 6)
    else
      Inc(X, R.Right - R.Left);

    S := S + S1;
  end;

  {$warnings off}
  if Unassigned and (not Focused) and (Length(S) > 0) then
    S := MakeUnassignedString(Length(S));

  SetRectEmpty(R);
  {$warnings on}
  LMDDrawText(Canvas.Handle, S, Length(S), R, DT_LEFT or DT_SINGLELINE or DT_TOP or DT_CALCRECT);
  x := R.Right - R.Left + 1;

  SetEditRect;

  case Alignment of
    taLeftJustify:   x := GetCheckWidth;
    taRightJustify:  x := (ClientWidth - BtnWidth - GetCheckWidth - x);
    taCenter: x := (ClientWidth - BtnWidth - GetCheckWidth - x) div 2;
  end;

  X := Max(x, GetCheckWidth + GetSystemMetrics(SM_CYBORDER) * 2);

  if x > 0 then
  begin
    for i := 0 to DTFParts.Count - 1 do
    begin
      Part := PDTFPart(DTFParts[i]);
      Inc(Part.SPos, x);
      Inc(Part.EPos, x);
    end;
  end;

  FText := S;
end;

procedure TElDateTimePicker.ParseFormat(AFormat : string);
var
  P : PChar;
  i: Integer;

  pt: char;
  CurText : string;
  dtp : PDTFPart;
  Starter : Char;
  Count : integer;
  LastToken: char;
  c : integer;
  b : boolean;
  Format : string;

  procedure GetCount;
  var
    St : char;
  begin
    Count := 0;
    ST := UpCase(Starter);
    while UpCase(P^) = St do
    begin
      Inc(P);
      Inc(Count);
    end;
    dec(P);
  end;

  function LReturnCurrChar(P: PChar): Char;
  begin
    Result := P^;
  end;

begin
  Format := StrPas(PChar(AFormat));
  pt := #0;
  CurText := '';
  Use12Hours := false;
  P := PChar(Format);
  LastToken := #0;
  while LReturnCurrChar(P) <> #0 do
  begin

    if (UpCase(LReturnCurrChar(P)) = 'M') and (Upcase(LastToken) = 'H') then
       P^ := 'N';
       if ((LReturnCurrChar(P) = '''') or (LReturnCurrChar(P) = '"')) then
    begin
      if pt = #0 then
         pt := LReturnCurrChar(P)
      else
      if pt = LReturnCurrChar(P) then
      begin
        New(dtp);
        dtp.Text := CurText;
        LastToken := #0;
        CurText  := '';
        dtp.DPart := -1;
        DTFParts.Add(dtp);
        pt := #0;
      end
      else
        CurText := CurText + LReturnCurrChar(P);
    end
    else
    if pt <> #0 then
       CurText := CurText + LReturnCurrChar(P)
    else
    begin
      if CurText <> '' then
      begin
        New(dtp);
        dtp.Text := CurText;
        LastToken := #0;
        CurText  := '';
        dtp.DPart := -1;
        DTFParts.Add(dtp);
      end;
      if Upcase(LReturnCurrChar(P)) = 'Y' then
      begin
        LastToken := LReturnCurrChar(P);
        Starter := LReturnCurrChar(P);
        GetCount;
        New(dtp);
        DTFParts.Add(dtp);
        if Count <= 2 then
        begin
          dtp.DPart := 1;
          dtp.Text := 'YY';
        end else
        begin
          dtp.DPart := 0;
          dtp.Text := 'YYYY';
        end;
      end else
      if Upcase(LReturnCurrChar(P)) = 'M' then
      begin
        LastToken := LReturnCurrChar(P);
        Starter := LReturnCurrChar(P);
        GetCount;
        New(dtp);
        dtp.DPart := 2;
        DTFParts.Add(dtp);
        SetLength(dtp.Text, Count);

        for i := 1 to Count do
          dtp.Text[i] := 'M';
      end else
      if Upcase(LReturnCurrChar(P)) = 'D' then
      begin
        LastToken := LReturnCurrChar(P);
        Starter := LReturnCurrChar(P);
        GetCount;
        if Count < 3 then
        begin
          New(dtp);
          dtp.DPart := 3;
          DTFParts.Add(dtp);
          SetLength(dtp.Text, Count);
          for i := 1 to Count do
            dtp.Text[i] := 'D';
        end
        else
        if Count < 5 then
        begin
          New(dtp);
          dtp.DPart := 10;
          DTFParts.Add(dtp);
          SetLength(dtp.Text, Count);
          for i := 1 to Count do
            dtp.Text[i] := 'D';
        end
        else
        begin
          c := (P - PChar(Format)) - count + 2;
          if count = 6 then
          begin
            Delete(Format, C, 6);
            Insert({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongDateFormat, Format, C);
            P := PChar(Format) + C - 2;
            end
          else
          begin
            Delete(Format, C, 5);
            Insert({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDateFormat, Format, C);
            P := PChar(Format) + C - 2;
            end;
        end;
      end else
      if Upcase(LReturnCurrChar(P)) = 'H' then
      begin
        LastToken := LReturnCurrChar(P);
        inc(p);
        if (LReturnCurrChar(P) = 'H') or (LReturnCurrChar(P) = 'h') then
           Count := 2
        else
        begin
          Count := 1;
          dec(P);
        end;
        New(dtp);
        dtp.DPart := 4;
        DTFParts.Add(dtp);
        SetLength(dtp.Text, Count);
        for i := 1 to Count do
          dtp.Text[i] := 'H';
      end else
      if Upcase(LReturnCurrChar(P)) = 'N' then
      begin
        LastToken := LReturnCurrChar(P);
        inc(p);
        if (LReturnCurrChar(P) = 'N') or (LReturnCurrChar(P) = 'n') or (LReturnCurrChar(P)='M') or (LReturnCurrChar(P)='m') then
           Count := 2
        else
        begin
          Count := 1;
          dec(P);
        end;
        New(dtp);
        dtp.DPart := 6;
        DTFParts.Add(dtp);
        SetLength(dtp.Text, Count);
        for i := 1 to Count do
          dtp.Text[i] := 'N';
      end else
      if Upcase(LReturnCurrChar(P)) = 'S' then
      begin
        LastToken := LReturnCurrChar(P);
        inc(p);
        if (LReturnCurrChar(P) = 'S') or (LReturnCurrChar(P) = 's') then
           Count := 2
        else
        begin
          Count := 1;
          dec(P);
        end;
        New(dtp);
        dtp.DPart := 7;
        DTFParts.Add(dtp);
        SetLength(dtp.Text, Count);
        for i := 1 to Count do
          dtp.Text[i] := 'S';
      end
      else
      if Upcase(LReturnCurrChar(P)) = 'Z' then
      begin
        LastToken := LReturnCurrChar(P);
        Starter := LReturnCurrChar(P);
        GetCount;
        New(dtp);
        dtp.DPart := 11;
        DTFParts.Add(dtp);
        SetLength(dtp.Text, Count);
        for i := 1 to Count do
          dtp.Text[i] := 'Z';
      end
      else
      if Upcase(LReturnCurrChar(P)) = 'C' then
      begin
        LastToken := LReturnCurrChar(P);
        c := P - PChar(Format);
        Delete(Format, C + 1, 1);
        Insert({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDateFormat + #32 + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongTimeFormat, Format, C);
        P := PChar(Format) + C - 1;
        end
      else
      if Upcase(LReturnCurrChar(P)) = 'T' then
      begin
        LastToken := LReturnCurrChar(P);
        c := P - PChar(Format);
        inc(P);
        if (LReturnCurrChar(P) = 't') or (LReturnCurrChar(P) = 'T') then
        begin
          Delete(Format, C + 1, 2);
          Insert({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongTimeFormat, Format, C + 1);
          P := PChar(Format) + C - 1;
          end
        else
        begin
          dec(p);
          Delete(Format, C + 1, 1);
          Insert({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortTimeFormat, Format, C + 1);
          P := PChar(Format) + C - 1;
          end;
      end else
      if Upcase(LReturnCurrChar(P)) = 'A' then
      begin
        LastToken := LReturnCurrChar(P);
        if ( (StrLIComp(P, 'AM/PM', 5) = 0)
           or (StrLIComp(P, 'A/P',   3) = 0)
           or (StrLIComp(P, 'AMPM',  4) = 0) ) then
        Use12Hours := true;
        b := false;
        if StrLIComp(P, 'AM/PM', 5) = 0 then
        begin
          c := 5;
          b := true;
        end else
        if StrLIComp(P, 'A/P', 3) = 0 then
        begin
          c := 3;
          b := true;
        end else
        if StrLIComp(P, 'AMPM', 4) = 0 then
        begin
          c := 4;
          b := true;
        end else
        if StrLIComp(P, 'AAAA', 4) = 0 then
        begin
          c := 4;
          b := false;
        end else
        if StrLIComp(P, 'AAA', 3) = 0 then
        begin
          c := 3;
          b := false;
        end else c:= 0;
        if b then
        begin
          New(dtp);
          dtp.DPart := 8;
          DTFParts.Add(dtp);
          SetLength(dtp.Text, c);
          StrPLCopy(PChar(dtp.Text), P, c);
          end
        else
        if c <> 0 then
        begin
          New(dtp);
          dtp.DPart := 10;
          DTFParts.Add(dtp);
          SetLength(dtp.Text, c);
          StrPLCopy(PChar(dtp.Text), P, c);
          end;
        if C > 0 then
          inc(P, C - 1);
      end
      else
      if ((LReturnCurrChar(P) = {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DateSeparator) or (LReturnCurrChar(P) = {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimeSeparator)) and (DTFParts.Count > 0) and (PDTFPart(DTFParts.Last).DPart in [0, 1, 2, 3, 4, 5, 6, 7]) then
      begin
        New(dtp);
        dtp.DPart := 9;
        DTFParts.Add(dtp);
        if LReturnCurrChar(P) = {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DateSeparator then
          dtp.Text := '/'
        else
        if LReturnCurrChar(P) = {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimeSeparator then
          dtp.Text := ':'
        else
          dtp.Text := P;
          end
      else
      if (LReturnCurrChar(P) = '/') or (LReturnCurrChar(P) = ':') then
      begin
        New(dtp);
        dtp.DPart := 9;
        DTFParts.Add(dtp);
        dtp.Text := LReturnCurrChar(P);
      end else
      if (AnsiChar(LReturnCurrChar(P)) in [' ', '.', ',', ';', '\', '-', '_', '@']) then
        CurText := CurText + LReturnCurrChar(P);
    end;
    inc(P);
  end;
end;

function TElDateTimePicker.GetStdFormat(Fmt : TElDatePickerFormat) : string;
begin
  case Fmt of
    edfShortDateLongTime : result := 'c';
    edfShortDateShortTime: result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDateFormat + ' ' + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortTimeFormat;
    edfLongDate          : result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongDateFormat;
    edfShortDate         : result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDateFormat;
    edfLongTime          : result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongTimeFormat;
    edfShortTime         : result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortTimeFormat;
    edfCustom            : result := 'c';
  end;
end;

procedure TElDateTimePicker.SetFormat(newValue : TElDatePickerFormat);
var AF : string;
begin
  if FFormat <> newValue then
  begin
    FFormat := newValue;
    FCurPart := -1;
    FDI := '';
    DTFParts.Clear;
    if FFormat = edfCustom then
       AF := FFormatStr
    else
       AF := GetStdFormat(FFormat);
    ParseFormat(AF);
    UpdatePart;
    if HandleAllocated then
    begin
      UpdateText;
      InvalidateEdit;
    end;
  end;
end;

procedure TElDateTimePicker.SetFormatStr(newValue : String);
var AF : string;
begin
  if (FFormatStr <> newValue) then
  begin
    if newValue = '' then
       newValue := 'c';
    FFormatStr := newValue;
    FCurPart := -1;
    FDI := '';
    DTFParts.Clear;
    if FFormat = edfCustom then
       AF := FFormatStr
    else
       AF := GetStdFormat(FFormat);
    ParseFormat(AF);
    UpdatePart;
    if HandleAllocated then
    begin
      UpdateText;
      InvalidateEdit;
    end;
  end;  { if }
end;  { SetFormat }

function TElDateTimePicker.GetText:String;
begin
//  Result := DateTimeToStr(DateTime, LFormat);
  if (FFormat = edfCustom) then
    DateTimeToString(Result, FFormatStr, DateTime)
  else
    DateTimeToString(Result, GetStdFormat(FFormat), DateTime);
end; { GetText }

procedure TElDateTimePicker.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    if HandleAllocated then
    begin
      UpdateText;
      InvalidateEdit;
    end;
  end;
end;

procedure TElDateTimePicker.SetDate(newValue : TDateTime);
begin
  SetDateTime(Frac(FDate) + Trunc(newValue));
end;

function TElDateTimePicker.GetDate : TDateTime;
begin
  result := Trunc(FDate);
end;

procedure TElDateTimePicker.SetTime(newValue : TDateTime);
begin
  SetDateTime(Trunc(FDate) + Frac(newValue));
end;

function TElDateTimePicker.GetTime : TDateTime;
begin
  result := Frac(FDate);
end;

procedure TElDateTimePicker.SetDateTime(newValue: TDateTime);
{ Sets data member FDate to newValue. }
begin
  if (FDate <> newValue) then
  begin
    if (NewValue <= MaxDate) and (NewValue >= MinDate) then
    begin
      FDate := newValue;
//      if FDate = 0 then
//        FDate := 2;
      if AlwaysResetUnassigned then
        Unassigned := false;
      if ShowBlankWhenZero and (newValue = 0) then
        Unassigned := true;
      if HandleAllocated then
      begin
        UpdateText;
        InvalidateEdit;
      end;
    end;
  end;  { if }
end;  { SetDate }

function TElDateTimePicker.GetCheckDims  : integer;
begin
  result := ClientHeight +1 - GetSystemMetrics(SM_CYBORDER) * 2;
end;

function TElDateTimePicker.GetCheckWidth : integer;
begin
  if FShowCheckBox then
    result := ClientHeight
  else
    result := 0;
end;

function TElDateTimePicker.GetBtnWidth : integer;
var ActWidth : integer;
begin
  ActWidth := GetActiveButtonWidth;

  if FShowPopupCalendar then
     result := actWidth * 2
  else
     result := actWidth;
  if not (ButtonVisible and ((not ButtonShowOnFocus) or Focused)) then
    dec(Result, actWidth);
end;

procedure TElDateTimePicker.DoDropDown;
begin
  if Assigned(FOnDropDown) then FOnDropDown(Self);
end;

procedure TElDateTimePicker.CloseUp(AcceptValue : boolean);
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
    begin
      if FForm.Unassigned and UnassignedAllowed then
      begin
        if FUseMonthCalendar then
          DateTime := FForm.MCalendar.Date
        else
          DateTime := FForm.Calendar.Date;
        Unassigned := true
      end
      else
      begin
        if FUseMonthCalendar then
          DateTime := Trunc(FForm.MCalendar.Date) + IfThen(CalendarShowClock, Frac(FForm.Clock.DT), Frac(DateTime))
        else
          DateTime := Trunc(FForm.Calendar.Date) + IfThen(CalendarShowClock, Frac(FForm.Clock.DT), Frac(DateTime));
        Unassigned := false;
      end;
      Modified := true;
      TriggerChangeEvent;
    end;
    FCalButton.Down := false;
    DoDropDown;
  end;
end;

type
  TElDTPickButton = class(TElGraphicButton)
  protected
    function GetDetails: TThemedElementDetails; override;
    function GetShowGlyph: Boolean; override;
  end;

type
  THackClock = class(TElClock);

  THackCalendar = class(TElCalendar)
  end;

  THackCalendarForm = class(TElCalendarForm)
  private
    procedure CMDeactivate(var Msg : TMessage); message CM_DEACTIVATE;
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
  public
    procedure CreateParams(var Params : TCreateParams); override;
  end;

procedure THackCalendarForm.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
end;

procedure THackCalendarForm.CMDeactivate(var Msg : TMessage);
begin
  inherited;
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
end;

procedure THackCalendarForm.CreateParams(var Params : TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := WS_POPUP or WS_BORDER;//  or WS_DLGFRAME;
    ExStyle := (*WS_EX_TOOLWINDOW or *)WS_EX_TOPMOST;
  end;
end;

procedure TElDateTimePicker.DropDown;
var
  P, P1: TPoint;

var AForm : TCustomForm;

  procedure UpdateFormStyles;
  var
    i : integer;
    PropInfo   : PPropInfo;
  begin
    with FForm do
      for i := 0 to ComponentCount - 1 do
      begin
        PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleManager');
        if PropInfo <> nil then
          SetObjectProp(Components[i], PropInfo, Self.StyleManager);
        PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleName');
        if PropInfo <> nil then
          SetStrProp(Components[i], PropInfo, Self.StyleName);
      end;
  end;

begin
  if not Assigned(FForm) then exit;

  TuneupCalendarControls;
  if FForm.Visible then
  begin
    CloseUp(False);
  end
  else
  begin
    if not ReadOnly then
    begin
      if not FFocused then
         SetFocus;

      UpdateFormStyles;
//      FForm.Height := FForm.Panel1.Height + FForm.Panel3.Height + FForm.Calendar.GetEffectiveHeight + GetSystemMetrics(SM_CXBORDER) * 2;
//      FForm.Width := FForm.Calendar.GetEffectiveWidth + GetSystemMetrics(SM_CYBORDER) * 2;
      if CalendarShowClock then
      begin
//        FForm.Width := FForm.Width + FForm.ClockPanel.Width;
        FForm.ShowClock := True;
      end;
      FForm.UseMonthCalendar := FUseMonthCalendar;
      if FUseMonthCalendar then
        FForm.MCalendar.Date := FDate
      else
        FForm.Calendar.Date := FDate;
      THackClock(FForm.Clock).FDT := FDate;
      CalcFormSizes;
      FForm.Refresh;
      P := Parent.ClientToScreen(Point(Left, Top));

      Inc(P.Y, Height);
      if P.Y + FForm.Height > GetDesktopBottom then
        P.Y := P.Y - FForm.Height - Height;

      Inc(P.X, Width);
      if (FDropDownAlignment = taRightJustify) {xor RightAlignedView} then
        Dec(P.X, FForm.Width)
      else
        Dec(P.X, self.Width);

      if (P.X + FForm.Width > GetDesktopRight) then
      begin
        P1 := P;
        P1.x := (Left + Width) - FForm.Width;
        P1 := Parent.ClientToScreen(P1);
        P.X := P1.x;
      end;

      if CalendarKeepWithinForm then
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

//      FForm.Calendar.Date := FDate;
//      THackClock(FForm.Clock).FDT := FDate;
      FCalButton.Down := true;
      FDroppedDown := true;
      FForm.ClearBtn.Visible := UnassignedAllowed;
      FForm.RangeButtons;
      FForm.Unassigned := false;

      DoDropDown;

      FForm.Visible := True;
      if FUseMonthCalendar then
        FForm.MCalendar.SetFocus
      else
        FForm.Calendar.SetFocus;
    end;
  end;
end;

procedure TElDateTimePicker.SetEditRect;  { protected }
var
  R : TRect;
  ActWidth : integer;
begin
  if HandleAllocated then
  begin
    ActWidth := GetActiveButtonWidth;
    R := Rect(ClientWidth - ActWidth, 0, ClientWidth, ClientHeight);
    if FShowPopupCalendar then
    begin
      FCalButton.BoundsRect := R;
      FCalButton.Visible := true;
      if ButtonVisible and ((not ButtonShowOnFocus) or Focused) then
        R := Rect(ClientWidth - ActWidth * 2, 0, ClientWidth - ActWidth, ClientHeight)
      else
        R := Rect(ClientWidth - ActWidth, 0, ClientWidth, ClientHeight)
    end
    else
    begin
      if csDesigning in ComponentState then
         FCalButton.BoundsRect := Rect(-1, -1, -1, -1)
      else
         FCalButton.Visible := false;
    end;

    FButton.BoundsRect := R;
    if ButtonVisible and ((not ButtonShowOnFocus) or Focused) then
      FButton.Visible := true
    else
    if csDesigning in ComponentState then
      FButton.BoundsRect := Rect(-1, -1, -1, -1)
    else
      FButton.Visible := false;
  end;
end; {SetEditRect}

function TElDateTimePicker.GetShowTodayButton: boolean;
begin
  if Assigned(FForm) then
    Result := FForm.ShowTodayButton
  else
    Result := FShowTodayButton;
end;

procedure TElDateTimePicker.SetShowTodayButton(Value: boolean);
begin
  FShowTodayButton := Value;
  if Assigned(FForm) then
    FForm.ShowTodayButton := Value;
end;

procedure TElDateTimePicker.DrawFlatBorder;
var
  DC : HDC;
  R,
  R1 : TRect;
  ax,
  ay : integer;
  b  : boolean;
  BS : TElFlatBorderType;
  AColor : TColor;
begin
  R := Rect(0, 0, Width, Height);
  DC := GetWindowDC(Handle);
  try
    if IsThemed and (BorderStyle = bsSingle) then
    begin
      R1 := ClientRect;
      R1.TopLeft := Parent.ScreenToClient(ClientToScreen(R1.TopLeft));

      ax := Left - R1.Left;
      ay := Top  - R1.Top;

      R1 := ClientRect;
      OffsetRect(R1, -ax, -ay);

      with R1 do
        ExcludeClipRect(DC, Left, Top, Right, Bottom);

      if LMDSIWindowsVistaUp then
        LMDThemeServices.DrawElement(UseThemeMode, DC, GetThemedElementDetails, R)
      else
        LMDThemeServices.DrawElement(UseThemeMode, DC, teEditDontCare, R);
    end
    else
    if BorderStyle = bsSingle then
    begin
      b := Focused or FMouseOver;
      if b then
         BS := FActiveBorderType
      else
         BS := FInactiveBorderType;
      if Focused or FMouseOver then
        AColor := LineBorderActiveColor
      else
        AColor := LineBorderInactiveColor;

      DrawFlatFrameEx2(DC, R, AColor, Color, b, Enabled, FBorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
    end;
  finally
    ReleaseDC(Handle, DC);
  end;
end;

procedure TElDateTimePicker.RedoTmpBmp;
var BgRect,
    BgRect2 : TRect;
begin
  if LMDBackgroundIsGradient(BackgroundType) or (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then
  begin
    FTmpBmp.FreeImage;
  end else
  begin
    if (ClientWidth <> 0) and (ClientHeight <> 0) then
    begin
      FTmpBmp.Height := ClientHeight - 1;
      FTmpBmp.Width := ClientWidth - 1;
      BgRect := ClientRect;
      BgRect2 := BgRect;
      OffsetRect(BgRect2, BgRect2.Left, BgRect2.Top);
      LMDExtDrawBkgnd(FTmpBmp.Canvas.Handle, BgRect, BgRect, BgRect, BgRect2, false, Color, Color, Background, BackgroundType);
    end;
  end;
end;

procedure TElDateTimePicker.CMMouseEnter(var Msg : TMessage);  { private }

begin
  inherited;
  FMouseOver := true;
  if LMDSIWindowsVistaUp and IsThemed then
    DrawFlatBorder;
  if (Flat and (not Focused)) and (not IsThemed) then DrawFlatBorder;
  if Flat and ShowCheckBox then Invalidate;
  if ButtonVisible then
    FButton.Invalidate;
end;  { CMMouseEnter }

procedure TElDateTimePicker.SetGradientStartColor(newValue : TColor);
{ Sets data member FGradientStartColor to newValue. }
begin
  if (FGradientStartColor <> newValue) then
  begin
    FGradientStartColor := newValue;
    if LMDBackgroundIsGradient(FBackgroundType) then InvalidateEdit;
  end;  { if }
end;  { SetGradientStartColor }

procedure TElDateTimePicker.SetGradientEndColor(newValue : TColor);
{ Sets data member FGradientEndColor to newValue. }
begin
  if (FGradientEndColor <> newValue) then
  begin
    FGradientEndColor := newValue;
    if LMDBackgroundIsGradient(FBackgroundType) then InvalidateEdit;
  end;  { if }
end;  { SetGradientEndColor }

procedure TElDateTimePicker.SetGradientSteps(newValue : Integer);
{ Sets data member FGradientSteps to newValue. }
begin
  if (FGradientSteps <> newValue) and (newValue > 0) then
  begin
    FGradientSteps := newValue;
    if LMDBackgroundIsGradient(FBackgroundType) then InvalidateEdit;
  end;  { if }
end;  { SetGradientSteps }

procedure TElDateTimePicker.SetBackground(newValue : TBitmap);
begin
  FBackground.Assign(newValue);
  if (FBackground.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap])
     then BackgroundType := bgtColorFill;
end; {SetBackground}

procedure TElDateTimePicker.SetBackgroundType(newValue : TLMDBackgroundType);
begin
  if (FBackgroundType <> newValue) then
  begin
    FBackgroundType := newValue;
    if (FBackground.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap])
       then FBackgroundType := bgtColorFill;
    RedoTmpBmp;
    InvalidateEdit;
  end; {if}
end; {SetBackgroundType}

procedure TElDateTimePicker.ImageChange(Sender : TObject);
begin
  if ((FBackground.Height = 0) or (FBackground.Width = 0)) then
    BackgroundType := bgtColorFill
  else
  begin
    if not (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then RedoTmpBmp;
    Invalidate;
  end;
end;

procedure TElDateTimePicker.ImageFormChange(Sender : TObject);
begin
  InvalidateEdit;
end;

procedure TElDateTimePicker.CurrDayImageChange(Sender : TObject);
begin
  if Assigned(FForm) and FUseMonthCalendar then
    FForm.Calendar.CurrentDayBitmap.Assign(FCalendarCurrentDayBitmap);
end;

procedure TElDateTimePicker.SetTransparent(newValue : Boolean);
{ Sets data member FTransparent to newValue. }
begin
  if (FTransparent <> newValue) then
  begin
    FTransparent := newValue;
    if FTransparent then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    RecreateWnd;
    end; { if }
end; { SetTransparent }

procedure TElDateTimePicker.SetImageForm(newValue : TElImageForm);
begin
  if (FImgForm <> newValue) then
  begin
    if FImgForm <> nil then
    begin
      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);
      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    FImgForm := newValue;
    if (newValue <> nil) then
    begin
      newValue.FreeNotification(Self);
      FImgForm.RegisterChanges(FImgFormChLink);
    end;
    if not (csDesigning in ComponentState) then InvalidateEdit;
  end;  { if }
end;  { SetImageForm }

procedure TElDateTimePicker.CMMouseLeave(var Msg : TMessage);  { private }
begin
  FMouseOver := false;
  if LMDSIWindowsVistaUp and IsThemed then
    DrawFlatBorder;
    if (Msg.LParam = 0) or (Msg.LParam = TLMDPtrInt(Self)) then
    begin
      if (Flat and (not Focused)) and (not IsThemed) then DrawFlatBorder;
      if Flat and ShowCheckBox then Invalidate;
    end;
  if ButtonVisible then
    FButton.Invalidate;
  inherited;
end;  { CMMouseLeave }

procedure TElDateTimePicker.CMSysColorChange(var Msg : TMessage);  { private }

begin
  inherited;
  InvalidateEdit;
end;  { CMSysColorChange }

procedure TElDateTimePicker.CMFontChanged(var Msg : TMessage);  { private }

begin
  inherited;
  if (csFixedHeight in ControlStyle) and
     not ((csDesigning in ComponentState) and
     (csLoading in ComponentState)) then
    AdjustHeight;
  if HandleAllocated then
  begin
    UpdateText;
    SetEditRect;
  end;
end;  { CMFontChanged }

procedure TElDateTimePicker.CMCtl3DChanged(var Msg : TMessage); { private }
begin
  inherited;
  if HandleAllocated then
    RecreateWnd;
end; { CMCtl3DChanged }

procedure TElDateTimePicker.SetActiveBorderType(newValue : TElFlatBorderType);
begin
  if (FActiveBorderType <> newValue) then
  begin
    FActiveBorderType := newValue;

    UpdateButtonStyles;

    if (Focused or FMouseOver) then UpdateFrame;
    end;  { if }
end;  { SetActiveBorderType }

procedure TElDateTimePicker.SetInactiveBorderType(newValue : TElFlatBorderType);
{ Sets data member FInactiveBorderType to newValue. }
begin
  if (FInactiveBorderType <> newValue) then
  begin
    FInactiveBorderType := newValue;
    if (not (Focused or FMouseOver)) then UpdateFrame;
    UpdateButtonStyles;

  end;  { if }
end;  { SetInactiveBorderType }

procedure TElDateTimePicker.SetNavigationInPopup(newValue : boolean);
begin
  if FNavigationInPopup <> newValue then
  begin
    FNavigationInPopup := newValue;
    if Assigned(FForm) and not FUseMonthCalendar then
    begin
      if newValue then
      begin
        FForm.Panel1.Visible := true;
        FForm.Height := FForm.Height + FForm.Panel1.Height;
      end else
      begin
        FForm.Panel1.Visible := false;
        FForm.Height := FForm.Height - FForm.Panel1.Height;
      end;
    end;
  end;
end;

procedure TElDateTimePicker.SetFlat(newValue : Boolean);
{ Sets data member FFlat to newValue. }
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    UpdateButtonStyles;
    UpdateFrame;
    end;  { if }
end;  { SetFlat }

procedure TElDateTimePicker.WMSize(var Msg : TWMSize);  { private }

begin
  inherited;
  if HandleAllocated and (not FModified) then
  begin
    UpdateText;
    SetEditRect;
    InvalidateEdit;
  end;
  if IsThemed or (Flat and (BorderStyle <> bsNone)) then
    DrawFlatBorder;

end;  { WMSize }

procedure TElDateTimePicker.CalBtnClick(Sender : TObject);
begin
  DropDown;
end;

procedure TElDateTimePicker.SpinUpClick(Sender : TObject; Increment : Double);
begin
  if CanFocus
  and (Windows.GetFocus <> Handle)
  then SetFocus;
  if not ReadOnly then
  begin
    if Unassigned then
    begin
      Unassigned := false;
      TriggerChangeEvent;
      Modified := true;
    end
    else
    begin
      Modified := true;
      IncValue(1);
    end;
  end;
end;

procedure TElDateTimePicker.SpinDownClick(Sender : TObject; Increment : Double);
begin
  if CanFocus
  and (Windows.GetFocus <> Handle)
  then SetFocus;
  if not ReadOnly then
  begin
    if Unassigned then
    begin
      Unassigned := false;
      TriggerChangeEvent;
      Modified := true;
    end
    else
    begin
      IncValue(-1);
      Modified := true;
    end;
  end;
end;

procedure TElDateTimePicker.WMSysKeyDown(var Msg: TWMKeyDown);
begin
  if (KeyDataToShiftState(Msg.KeyData) = [ssAlt]) and
     ShowPopupCalendar and
     (Not ShowCheckBox or Checked) then
  begin
    if (Msg.CharCode = VK_DOWN) then
    begin
      Msg.CharCode := 0;
      DroppedDown := true
    end
    else
    if (Msg.CharCode = VK_UP) then
    begin
      Msg.CharCode := 0;
      DroppedDown := false;
    end;
  end;
  inherited;
end;

procedure TElDateTimePicker.KeyDown(var Key : Word; Shift : TShiftState);
var i, ov: integer;
    Part : PDTFPart;
    b    : boolean;
    ST   : TSystemTime;
    ch   : boolean;
    wasPM: boolean;
    DoAdvance : boolean;
  LDaysPerMonth: Integer;
begin
  inherited;
  if ReadOnly then
     exit;
  DoAdvance := false;
  if (Shift = []) then
  begin
    if (Key = VK_F4) and FCalButton.Enabled then
    begin
      DroppedDown := not DroppedDown;
    end
    else
    if (Key = VK_SPACE) and (ShowCheckBox and (FCurPart = -1)) then
    begin
      if ShowCheckBox then
      begin
        if not ReadOnly then
        begin
          Checked := not Checked;
          Modified := true;
          TriggerCheckboxChangeEvent;
        end;
      end;
      Key := 0;
    end
    else
    if ((not ShowCheckBox) or Checked) then
    begin
      if (Key = VK_DELETE) and (UnassignedAllowed) then
      begin
        if not ReadOnly then
        begin
          Unassigned := true;
          Modified := true;
          TriggerChangeEvent;
          Key := 0;
        end;
      end
      else
      if Key = VK_UP then
      begin
        if not ReadOnly then
        begin
          if Unassigned then
            Unassigned := false
          else
            IncValue(1);
          Modified := true;
        end;
        Key := 0;
      end
      else
      if Key = VK_DOWN then
      begin
        if not ReadOnly then
        begin
          if Unassigned then
            Unassigned := false
          else
            IncValue(-1);
          Modified := true;
        end;
        Key := 0;
      end
      else
      if Key = VK_LEFT then
      begin
        b := false;
        if FCurPart > 0 then
        for i := FCurPart - 1 downto 0 do
        begin
          Part := PDTFPart(DTFParts[i]);
          if (Part.DPart in [0, 1, 2, 3, 4, 6, 7, 8, 11]) then
          begin
            FCurPart := i;
            FDI := '';
            UpdateText;
            InvalidateEdit;
            b := true;
            break;
          end;
        end;
        if not b and (ShowCheckBox) then
        begin
          if FCurPart = -1 then
          begin
            for i := DTFParts.Count - 1 downto 0 do
            begin
              Part := PDTFPart(DTFParts[i]);
              if (Part.DPart in [0, 1, 2, 3, 4, 6, 7, 8, 11]) then
              begin
                FCurPart := i;
                FDI := '';
                UpdateText;
                InvalidateEdit;
                break;
              end;
            end;
          end else
          begin
            FCurPart := -1;
            InvalidateEdit;
          end;
        end;
        Key := 0;
      end else
      if (Key = VK_RIGHT) or (Key = VK_SPACE) then
      begin
        if FCurPart <= DTFParts.Count - 1 then
        begin
          b := false;
          for i := FCurPart + 1 to DTFParts.Count - 1 do
          begin
            Part := PDTFPart(DTFParts[i]);
            if (Part.DPart in [0, 1, 2, 3, 4, 6, 7, 8, 11]) then
            begin
              FCurPart := i;
              FDI := '';
              UpdateText;
              InvalidateEdit;
              b := true;
              break;
            end;
          end;
          if not b and (ShowCheckBox) then
          begin
            FCurPart := -1;
            InvalidateEdit;
          end;
        end;
        Key := 0;
      end
      else
      begin
        if FCurPart = -1 then
        begin
          inherited;
          exit;
        end;
        Part := PDTFPart(DTFParts[FCurPart]);
        ch := false;
        if (Part.DPart in [0, 1, 2, 3, 4, 6, 7, 8, 11]) and
           (
            (Key in [VK_NUMPAD0..VK_NUMPAD9]) or
            (AnsiChar(Key) in
             ['0'..'9', 'a', 'A', 'p', 'P',
              AnsiChar(GetTimeAMChar),
              AnsiChar(GetTimePMChar),
              AnsiChar(Upcase(GetTimeAMChar)),
              AnsiChar(Upcase(GetTimePMChar)),
              AnsiChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DateSeparator),
              AnsiChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimeSeparator)])) then
        begin
          if Key in [VK_NUMPAD0..VK_NUMPAD9] then
            Key := Key - (VK_NUMPAD0 - ord('0'));
          DateTimeToSystemTime(FDate, ST);
          if AnsiChar(Key) in ['0'..'9'] then
          begin
            FDI := FDI + Char(Key);

            i := StrToIntDef(FDI, 1);
            case Part.DPart of
              0: begin
                   if Length(FDI) >= 4 then
                     DoAdvance := true;
                   begin
                     if (i <= 0) or (i > 9999) then
                     begin
                       if i = 0 then
                       begin
                         if Length(FDI) >= Length(Part.Text) then
                           FDI := Char(Key);
                       end;
                       //i := StrToIntDef(FDI + Char(Key), 1);
                       while (Length(FDI) > 1) and (not LMDInRange(StrToInt(FDI), 1, 9999)) do
                         Delete(FDI, 1, 1);
                       i := StrToIntDef(FDI, st.wYear);
                       if (not LMDInRange(StrToInt(FDI), 1, 9999)) then
                         i := st.wYear;

                       //FDI := FDI[Length(FDI)];
                       //i := Byte(Key - ord('0') + 1900);
                     end;
                     //if Length(FDI) >= 4 then
                     begin
                       if ST.wYear <> i then
                       begin
                         ST.wYear := i;
                         ST.wDay := Min(LMDDaysPerMonth(ST.wYear, ST.wMonth), ST.wDay);
                         Modified := true;
                         ch := true;
                       end;
                     end;
                     //DoAdvance := true;
                   end;
                 end;
              1: begin
                   if Length(FDI) >= 2 then
                     DoAdvance := true;
                   if (i < 1) or (i > 99) then
                   begin
                     while (Length(FDI) > 1) and (not LMDInRange(StrToInt(FDI), 1, 99)) do
                       Delete(FDI, 1, 1);
                     i := StrToIntDef(FDI, st.wYear mod 100);
                     if (not LMDInRange(StrToInt(FDI), 1, 99)) then
                       i := st.wYear mod 100;
                   end;
                   ov := ST.wYear;

                   if i > {$IFDEF LMDCOMP17}FormatSettings.{$ELSE} SysUtils.{$ENDIF}TwoDigitYearCenturyWindow then

                      ST.wYear := 1900 + i
                   else
                      ST.wYear := 2000 + i;
                   if ov <> st.wYear then
                   begin
                     ST.wDay := Min(LMDDaysPerMonth(ST.wYear, ST.wMonth), ST.wDay);
                     Modified := true;
                     ch := true;
                   end;
                 end;
              2: begin
                   if Length(FDI) >= 2 then
                     DoAdvance := true;

                   if (i < 1) or (i > 12) then
                   begin

                     while (Length(FDI) > 1) and (not LMDInRange(StrToInt(FDI), 1, 12)) do
                         Delete(FDI, 1, 1);
                     i := StrToIntDef(FDI, st.wMonth);
                     if (not LMDInRange(StrToInt(FDI), 1, 12)) then
                       i := st.wMonth;
                   end;

                   if ST.wMonth <> i then
                   begin
                     ch := true;
                     ST.wMonth := i;
                     ST.wDay := Min(LMDDaysPerMonth(ST.wYear, ST.wMonth), ST.wDay);
                     if SystemTimeToDateTime(ST) < FMinDate then
                       ChangeToNearValid(ST, 2);
                     Modified := true;
                   end;
                 end;
              3: begin
                   if Length(FDI) >= 2 then
                     DoAdvance := true;
                   LDaysPerMonth := LMDDaysPerMonth(ST.wYear, ST.wMonth);
                   if (i < 1) or (i > LDaysPerMonth) then
                   begin
                     while (Length(FDI) > 1) and (not LMDInRange(StrToInt(FDI), 1, LDaysPerMonth)) do
                       Delete(FDI, Length(FDI), 1);
                     i := StrToIntDef(FDI, st.wDay);
                     if (not LMDInRange(StrToInt(FDI), 1, LMDDaysPerMonth(ST.wYear, ST.wMonth))) then
                       i := st.wDay;
                   end;

                   if St.wDay <> i then
                   begin
                     ST.wDay := i;
                     if SystemTimeToDateTime(ST) < FMinDate then
                       ChangeToNearValid(ST, 3);
                     Modified := true;
                     ch := true;
                   end;
                 end;
              4,
              5: begin
                   if Length(FDI) >= 2 then
                     DoAdvance := true;

                   (*
                   if Use12Hours then
                   begin
                     if (i < 1) or (i > 23) then
                     begin
                       while (Length(FDI) > 1) and (not InRange(0, 23, StrToInt(FDI))) do
                           Delete(FDI, 1, 1);
                       i := StrToIntDef(FDI, st.wHour mod 24);
                       if (not InRange(0, 23, StrToInt(FDI))) then
                         i := st.wHour;
                     end;
                   end
                   else
                   *)
                   begin

                     if (i < 0) or (i > 23) then
                     begin

                       while (Length(FDI) > 1) and (not LMDInRange(StrToInt(FDI), 0, 23)) do
                           Delete(FDI, 1, 1);
                       i := StrToIntDef(FDI, st.wHour);
                       if (not LMDInRange(StrToInt(FDI), 0, 23)) then
                         i := st.wHour;
                     end;
                   end;

                   ov := ST.wHour;

                   if Use12Hours then
                   begin
                     wasPM := (ST.wHour >= 12) and ((Length(FDI) = 0) or (FDI[1] <> '0'));
                     if wasPM and (i < 12) then
                        ST.wHour := i + 12
                     else
                     if (not wasPM) and (i = 12) then// user wants 12 AM.
                     begin
                       ST.wHour := 0;
                     end
                     else
                       ST.wHour := i;
                   end
                   else
                   begin
                     ST.wHour := i;
                   end;

                   if ov <> ST.wHour then
                   begin
                     Modified := true;
                     ch := true;
                   end;
                   if SystemTimeToDateTime(ST) < FMinDate then
                     ChangeToNearValid(ST, 4);
                 end;
              6: begin
                   if Length(FDI) >= 2 then
                     DoAdvance := true;
                   if (i < 0) or (i > 59) then
                   begin
                     while (Length(FDI) > 1) and (not LMDInRange(StrToInt(FDI), 0, 59)) do
                         Delete(FDI, 1, 1);
                     i := StrToIntDef(FDI, st.wMinute);
                     if (not LMDInRange(StrToInt(FDI), 0, 59)) then
                       i := st.wMinute;
                   end;
                   if i <> ST.wMinute then
                   begin
                     ST.wMinute := i;
                     Modified := true;
                     ch := true;
                   end;
                   if SystemTimeToDateTime(ST) < FMinDate then
                     ChangeToNearValid(ST, 4);
                 end;
              7: begin
                   if Length(FDI) >= 2 then
                     DoAdvance := true;
                   if (i < 0) or (i > 59) then
                   begin
                     while (Length(FDI) > 1) and (not LMDInRange(StrToInt(FDI), 0, 59)) do
                         Delete(FDI, 1, 1);
                     i := StrToIntDef(FDI, st.wSecond);
                     if (not LMDInRange(StrToInt(FDI), 0, 59)) then
                       i := st.wSecond;
                   end;
                   if i <> ST.wSecond then
                   begin
                     ST.wSecond := i;
                     Modified := true;
                     ch := true;
                   end;
                   if SystemTimeToDateTime(ST) < FMinDate then
                     ChangeToNearValid(ST, 4);
                 end;
              11:begin
                   if Length(FDI) >= 3 then
                     DoAdvance := true;
                   if (i < 0) or (i > 999) then
                   begin
                     while (Length(FDI) > 1) and (not LMDInRange(StrToInt(FDI), 0, 999)) do
                         Delete(FDI, 1, 1);
                     i := StrToIntDef(FDI, st.wMilliseconds);
                     if (not LMDInRange(StrToInt(FDI), 0, 999)) then
                       i := st.wMilliseconds;
                   end;
                   if i <> ST.wMilliseconds then
                   begin
                     ST.wMilliseconds := i;
                     Modified := true;
                     ch := true;
                   end;
                   if SystemTimeToDateTime(ST) < FMinDate then
                     ChangeToNearValid(ST, 4);
                 end;
            end;
          end
          else
          if Part.DPart = 8 then
          begin
            if ((Length({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimeAMString) > 0) and
                 ((Char(Key) = UpCase({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimeAMString[1])) or (Char(Key - 32) = UpCase({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimeAMString[1])))) then
            begin
              if ST.wHour >= 12 then
              begin
                Dec(ST.wHour, 12);
                Modified := true;
                ch := true;
              end;
            end
            else
            if ((Length({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimePMString) > 0) and
                 ((Char(Key) = UpCase({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimePMString[1])) or (Char(Key - 32) = UpCase({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimePMString[1])))) then
            begin
              if ST.wHour < 12 then
              begin
                Inc(ST.wHour, 12);
                Modified := true;
                ch := true;
              end;
            end else
            if ((LowerCase(Part.Text) = 'am/pm') and
                 (AnsiChar(Key) in ['a', 'p', 'a', 'p'])) then
            begin
              if (UpCase(Char(Key)) = 'A') and (ST.wHour >= 12) then
              begin
                Dec(ST.wHour, 12);
                Modified := true;
                ch := true;
              end
              else
              if (UpCase(Char(Key)) = 'P') and (St.wHour < 12) then
              begin
                Inc(ST.wHour, 12);
                Modified := true;
                ch := true;
              end;
            end;
          end;
          if ch and not ReadOnly then
          begin
            if Unassigned then
              Unassigned := false;
            if Assigned(Part) {and (Length(FDI) >= Length(Part.Text)) //VB Dec 2012} then
              DoSetDateTime(SystemTimeToDateTime(ST));
            if AutoAdvance and DoAdvance then
              AdvancePosition;
          end;
          UpdateText(ST);
//          if ch and not ReadOnly then
//            TriggerChangeEvent;
          InvalidateEdit;
        end;
      end;
    end;
  end
  else
  if (ssCtrl in Shift) then
  begin
    if not (ssShift in Shift) then
    case Key of
      Ord('C'), Ord('c'),
      VK_INSERT:
        Clipbrd_Copy;
      Ord('V'), Ord('v'):
        Clipbrd_Paste;
      Ord('X'), Ord('x'):
        Clipbrd_Cut;
    end;
  end
  else
  if (ssShift in Shift) and (Key = VK_INSERT) then
    Clipbrd_Paste;
end;

function GetClipboardText:String;
begin
 Clipboard.Open;
 Result := Clipboard.AsText;
 Clipboard.Close;
end;

procedure SetClipboardText(const Value :String);
begin
 Clipboard.Open;
 Clipboard.AsText := Value;
 Clipboard.Close;
 end;

procedure TElDateTimePicker.Clipbrd_Copy;
begin
  if not Unassigned then
    SetClipboardText( Text )
  else
    SetClipboardText( '' );
end;

procedure TElDateTimePicker.Clipbrd_Paste;
var
  ClipboardText: String;
  NewDateTime: TDateTime;
begin
  if ReadOnly then
    exit;
  ClipboardText := GetClipboardText;
  try
    if Length(ClipboardText)>0 then
      NewDateTime := StrToDateTime(ClipboardText)
    else
      NewDateTime := 0;
  except
    exit;
  end;
  if (NewDateTime = DateTime) or
     ( (NewDateTime=0) and (not UnassignedAllowed) )
  then
    exit;
  DateTime := NewDateTime;
  if NewDateTime <> NewDateTime then
    exit;
  if NewDateTime = 0 then
    Unassigned := True
  else
    Unassigned := False;
  Modified := True;
  TriggerChangeEvent;
end;

procedure TElDateTimePicker.Clipbrd_Cut;
begin
  if ReadOnly and (not UnassignedAllowed) then
    Clipbrd_Copy
  else
  begin
    if not Unassigned then
      SetClipboardText( Text )
    else
      SetClipboardText( '' );
    if not Unassigned then
    begin
      DateTime := 0;
      Unassigned := True;
      Modified := True;
      TriggerChangeEvent;
    end;
  end
end;

procedure TElDateTimePicker.OnDTFPartDelete(Sender: TObject; var Item: TxListItem);
begin
  if Item <> nil then
    begin
      Dispose(PDTFPart(Item));
      Item := nil;
    end;
end;

procedure TElDateTimePicker.UpdateFrame;
var R : TRect;
begin
  if not HandleAllocated then
     exit;
  R := Rect(0, 0, Width, Height);
  RedrawWindow( Handle, @R, 0, rdw_Invalidate or rdw_UpdateNow or rdw_Frame );
end;

procedure TElDateTimePicker.Loaded;
var Fmt : string;
begin
  inherited;
  FButton.Width := GetActiveButtonWidth;
  if MinDate > MaxDate then
    MinDate := MaxDate;
  if UseCurrentDate then
    Date := Now;
  if Date < MinDate then
    Date := MinDate;
  if Date > MaxDate then
    Date := MaxDate;
  Fmt := FFormatStr;
  FFormatStr := '~~~';
  SetFormatStr(Fmt);
  if ButtonVisible then
  begin
    SetEditRect;
    Invalidate;
  end;
  HandleNeeded;
  UpdateText;
//  DisplayOptionsChange(Self);
  UpdateLinkedControl;
  Perform(CM_SHOWINGCHANGED, 0, 0);
end;

procedure TElDateTimePicker.CreateParams;
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or BorderStyles[FBorderStyle] or WS_CLIPCHILDREN;
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
    if Transparent then
       ExStyle := ExStyle or WS_EX_TRANSPARENT
    else
       ExStyle := ExStyle and not WS_EX_TRANSPARENT;
    with Params.WindowClass do
      style := style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

procedure TElDateTimePicker.Paint;  { protected }
var
  R: TRect;
  Rct: TRect;
  R1: TRect;
  ax, ay, bx, by: integer;
  ACtl: TWinControl;
  BgRect: TRect;
  P: TPoint;
  APart: PDTFPart;
  AText: TLMDString;
  AColor: TColor;
  LDetail: TThemedEdit;
  LCDetail: TThemedButton;
const
  DArray : array[boolean, boolean] of TThemedButton = ((tbCheckBoxUncheckedDisabled, tbCheckBoxCheckedDisabled),(tbCheckBoxUncheckedNormal, tbCheckBoxCheckedNormal));
//  SIDArray : array[boolean, boolean] of integer = ((CBS_UNCHECKEDDISABLED, CBS_CHECKEDDISABLED),(CBS_UNCHECKEDNORMAL, CBS_CHECKEDNORMAL));
begin

  if Flat and (not IsThemed) then
    DrawFlatBorder;

  R := ClientRect;
  if ButtonVisible then
    Dec(R.Right, BtnWidth - 1);

  if not Transparent then
  begin
    if (FImgForm <> nil) and (not (csDesigning in FImgForm.ComponentState)) then
    begin
      if FImgForm.Control <> Self then
      begin
        ACtl := FImgForm.GetRealControl;
        BgRect := R;
        BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
        P := Parent.ClientToScreen(Point(Left, Top));

        BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
        BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
        BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);
        FImgForm.PaintBkgnd(Canvas.Handle, R, BgRect.TopLeft, false);
      end;
    end
    else
    begin
      if (not LMDApplication.ThemeUseColorProperty) and IsThemed then
      begin

        Rct := Rect(0, 0, Width, Height);
        ay := abs(Rct.Bottom - R.Bottom);
        OffsetRect(Rct, -ay, -ay);
        InflateRect(Rct, ay, ay);
        if not Enabled then
          LDetail := teEditTextDisabled
        else
        if ReadOnly then
        begin
          if FIgnoreReadOnlyState then
            LDetail := teEditTextNormal
          else
            LDetail := teEditTextReadOnly
        end
        else
        if Focused then
          LDetail := teEditTextFocused
        else
          LDetail := teEditTextNormal;
        bx := GetSystemMetrics(SM_CXBORDER);
        by := GetSystemMetrics(SM_CYBORDER);
        if (BorderStyle = bsNone) then
        begin
          InflateRect(Rct, bx, by);
        end;
//{$IFDEF LMDDISABLE_LMDTHEMES}
//        DrawThemeBackground(Theme, Canvas.Handle, EP_EDITTEXT, sid, Rct, nil);
//{$ELSE}
//        DrawThemeBackground(Theme, Canvas.Handle, EP_BACKGROUND, sid, Rct, nil);
//{$ENDIF}
        //TODO: Vista support?
        LMDThemeServices.DrawElement(ThemeMode, Canvas.Handle, LDetail, Rct);
        if (BorderStyle = bsNone) then
        begin
          InflateRect(Rct, -bx, -by);
        end;
      end
      else
      begin
        with Canvas do
        case BackgroundType of //
          bgtColorFill :
            begin
              Brush.Color := GetBkColor;
              FillRect(R);
            end;
          bgtHorzGradient, bgtVertGradient, bgtSquareGradient, bgtEllipticGradient,
          bgtTopLeftGradient, bgtTopRightGradient, bgtBottomLeftGradient,
          bgtBottomRightGradient, bgtTopLeftDiagonalGradient, bgtTopRightDiagonalGradient:
            LMDGradientPaint(Canvas, R, GradientStartColor, GradientEndColor, GradientSteps,LMDBackgroundType2GradientStyle[BackgroundType], 0, 0);
          bgtStretchBitmap,
          bgtTileBitmap:
            begin
              CopyRect(R, FTmpBmp.Canvas, Rect(0, 0, FTmpBmp.Width, FTmpBmp.Height));
            end;
          bgtCenterBitmap :
            begin
              Brush.Color := GetBkColor;

              Rct := R;
              FillRect(Rct);
              R := Rect(0, 0, FBackground.Width, FBackground.Height);
              LMDCenterRects(FBackground.Width, Rct.Right - Rct.Left, FBackground.Height, Rct.Bottom - Rct.Top, R1);
              OffsetRect(R1, Rct.Left, Rct.Top);
              CopyRect(R1, FBackground.Canvas, Rect(0, 0, FBackground.Width, FBackground.Height));
            end;
        end; // case
      end; // else
    end;
  end
  else
  begin
    GetClipBox(Canvas.Handle, R);
    R1 := R;
    P := Parent.ScreenToClient(ClientToScreen(Point(0, 0)));
    with P do
      OffsetRect(R1, X, Y);
    if Assigned(parent) then
      SendMessage(Parent.Handle, WM_ERASEBKGND, Canvas.Handle, Canvas.Handle);
//    RedrawWindow(Parent.Handle, @R1, 0, RDW_ERASE or RDW_INVALIDATE or RDW_NOCHILDREN or RDW_UPDATENOW);

    with R do
      BitBlt(Canvas.Handle, Left, Top, Right, Bottom, TmpDC, R.Left, R.Top, SRCCOPY);
  end;

  R := ClientRect;
  if ButtonVisible then
    Dec(R.Right, BtnWidth - 1);

  if ShowCheckBox then
  begin
    R1 := Rect(0, 0, ClientHeight + 1, 0);
    R1.Bottom := R1.Right;
    ax := GetCheckDims;
    LMDCenterRects(ax, R1.Right, ax, R1.Bottom, Rct);
    if IsThemed then
    begin
      try
        LCDetail := DArray[Enabled, Checked];
        LMDThemeServices.DrawElement(UseThemeMode, Canvas.Handle, LCDetail, Rct);
      finally
      end;
    end
    else
    begin
      if Checked then
        ay := DFCS_CHECKED
      else
        ay := 0;
      if not Enabled and UseDisabledColors then
        Ay := Ay or DFCS_INACTIVE;
      DrawFrameControl(Canvas.Handle, Rct, DFC_BUTTON, DFCS_BUTTONCHECK or ay);
      if Flat then
        DrawFlatFrame(Canvas, Rct);
      if FFocused and (FCurPart = -1) then
         Canvas.DrawFocusRect(Rct);
    end;

    Inc(R.Left, ClientHeight);
  end;

  if DTFParts.Count > 0 then
  begin
    R1 := R;

    APart  := PDTFPart(DTFParts[0]);
    R1.Left := APart.SPos;
    APart  := PDTFPart(DTFParts.Last);
    R1.Right := APart.EPos + 1;

    Canvas.Brush.Style := bsClear;
    Canvas.Font.Assign(Font);

    Canvas.Font.Color := GetTextColor;
//    if (not Enabled) and UseDisabledColors then
//      Canvas.Font.Color := DisabledFontColor;

    LMDDrawText(Canvas.Handle,FText, Length(FText), R1, DT_LEFT or DT_SINGLELINE or DT_VCENTER);
    if Unassigned and Focused then
    begin
      Canvas.Pen.Color := UnassignedColor;
      Canvas.MoveTo(R1.Left, R1.Bottom - 1);
      Canvas.LineTo(R1.Right, R1.Bottom - 1);
    end;

    if not ReadOnly and ((FCurPart > - 1) and (FFocused or not HideSelection)) and ((not ShowCheckBox) or Checked) then
    begin
      R1 := R;
      APart := PDTFPart(DTFParts[FCurPart]);
      R1.Left := APart.SPos;
      R1.Right := APart.EPos;
      if Focused then
      begin
        AColor := FocusedSelectColor;
        Canvas.Font.Color := FocusedSelectTextColor;
      end
      else
      begin
        AColor := HideSelectColor;
        Canvas.Font.Color := HideSelectTextColor;
      end;

      if HighlightAlphaLevel = 255 then
        Canvas.Brush.Color := AColor;
      AText := Copy(FText, APart.TSPos, APart.TEPos - APart.TSPos);
      LMDDrawText(Canvas.Handle, AText, Length(AText), R1, DT_LEFT or DT_SINGLELINE or DT_VCENTER);
      if HighlightAlphaLevel < 255 then
         LMDAlphaFillRect(Canvas, R1, AColor, HighlightAlphaLevel);
      end;
  end;
end;  { Paint }

procedure TElDateTimePicker.Notification(AComponent : TComponent; operation : TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin
    if FLinkedControl = AComponent then
      LinkedControl := nil;
    if (AComponent = FImgForm) then
      ImageForm := nil;
    end;  { if }
end;  { Notification }

procedure TElDateTimePicker.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);  { protected }
var
    APart : PDTFPart;
    i : integer;
    b : boolean;
begin
  inherited;
  if InDblClick then
     InDblClick := false
  else
  begin
    if CanFocus and (not FFocused) then
      SetFocus;
    if ShowCheckBox and (X < GetCheckWidth) then
    begin
      FCurPart := -1;
      FDI := '';
      Checked := not Checked;
      Modified := true;
      TriggerCheckboxChangeEvent;
    end
    else
    if (not ShowCheckBox) or Checked then
    begin
      FCurPart := -1;
      FDI := '';
      b := false;
      APart := nil;
      for i := 0 to DTFParts.Count - 1 do
      begin
        APart := PDTFPart(DTFParts[i]);
        if (X >= APart.SPos) and (X < APart.EPos) then
        begin
          if (APart.DPart in [0, 1, 2, 3, 4, 6, 7, 8, 10, 11]) then
              b := true;
          break;
        end;
      end;

      if b then
      begin
        FCurPart := DTFParts.IndexOf(APart);
        FDI := '';
        InvalidateEdit;
      end
      else
      if DTFParts.Count > 0 then
      begin
        FCurPart := 0;
        FDI := '';
        InvalidateEdit;
      end;
    end;
  end;
end;  { MouseDown }

procedure TElDateTimePicker.WMNCPaint(var Msg : TWMNCPaint);  { private }
var DC : HDC;
begin
  if (not Flat) and (BorderStyle = bsSingle) then
    inherited;
  // if Flat and (not IsThemed) then
  if Flat or (IsThemed and (BorderStyle = bsSingle)) then
  begin
    //DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
    //if DC <> 0 then
    //   DrawFlatBorder
    //else
    begin
      DC := GetWindowDC(Handle);
      DrawFlatBorder;
    end;
    ReleaseDC(Handle, DC);
    Msg.Result := 0;
  end
  else
    inherited;
end;  { WMNCPaint }

procedure TElDateTimePicker.WMSetFocus(var Msg : TWMSetFocus);  { private }

begin
  inherited;
  FFocused := true;
  if Flat then UpdateFrame;
  //if (FCurPart = -1) and (DTFParts.Count > 0) then
    FCurPart := 0;
  if ButtonVisible and ButtonShowOnFocus then
  begin
    SetEditRect;
    Invalidate;
  end;
  if Unassigned then
    UpdateText;
  InvalidateEdit;
end;  { WMSetFocus }

procedure TElDateTimePicker.WMKillFocus(var Msg : TWMKillFocus);  { private }
begin
  FFocused := false;
  inherited;
  if LMDSIWindowsVistaUp and IsThemed and HandleAllocated then
    DrawFlatBorder;
  if Flat then
    if HandleAllocated then
      UpdateFrame;
  //FCurPart := -1;
  if ButtonVisible and ButtonShowOnFocus then
  begin
    SetEditRect;
    Invalidate;
  end;
  if Unassigned and HandleAllocated then
    UpdateText;
  InvalidateEdit;
end;  { WMKillFocus }

procedure TElDateTimePicker.InvalidateEdit;
var R : TRect;
begin
  if (csDestroying in ComponentState) or (Parent = nil) then
     exit;
  R := ClientRect;
  if not Transparent then
     Dec(R.Right, BtnWidth - 1);
  InvalidateRect(Handle, @R, true);
  end;

procedure TElDateTimePicker.WMEraseBkgnd(var Msg : TWMEraseBkgnd);  { private }
begin
  Msg.Result := 1;
end;  { WMEraseBkgnd }

procedure TElDateTimePicker.WMGetDlgCode(var Msg : TWMGetDlgCode);  { private }
begin
  with TMessage(Msg) do
  begin
    Result := DefWindowProc(Handle, Msg, wParam, lParam);
    Result := (Result and (not DLGC_WANTALLKEYS)) or DLGC_WANTARROWS or DLGC_WANTCHARS;
    if HandleDialogKeys then
      result := result or DLGC_WANTALLKEYS;
  end;
end;  { WMGetDlgCode }

procedure TElDateTimePicker.TriggerChangeEvent;
begin
  if (assigned(FOnChange)) then
    FOnChange(Self);
end;  { TriggerChangeEvent }

(*
procedure TElDateTimePicker.WMChar(var Msg : TWMChar);  { private }
var Part : PDTFPart;
    i    : integer;
    ST   : TSystemTime;
    b    : boolean;
    ch   : boolean;
begin
  inherited;
  if FCurPart = -1 then
     exit;
  Part := PDTFPart(DTFParts[FCurPart]);
  ch := false;
  if (Part.DPart in [0, 1, 2, 3, 4, 6, 7, 8]) then
  begin
    DateTimeToSystemTime(FDate, ST);
    if Char(Msg.CharCode) in ['0'..'9'] then
    begin
      FDI := FDI + Char(Msg.CharCode);

      i := StrToIntDef(FDI, 1);
      case Part.DPart of
        0: begin
             if Length(FDI) >= 4 then
             begin
               if (i < 1900) or (i > 9999) then
               begin
                 FDI := FDI[Length(FDI)];
                 i := Byte(Msg.CharCode - ord('0') + 1900);
               end;
               if Length(FDI) >= 4 then
               begin
                 ST.wYear := i;
                 ST.wDay := Min(LMDDaysPerMonth(ST.wYear, ST.wMonth), ST.wDay);
                 Modified := true;
                 ch := true;
               end;
             end;
           end;
        1: begin
             if (i < 0) or (i > 99) then
             begin
               FDI := FDI[Length(FDI)];
               i := Byte(Msg.CharCode - ord('0'));
             end;
             if i > 50 then
                ST.wYear := 1900 + i
             else
                ST.wYear := 2000 + i;
             ST.wDay := Min(LMDDaysPerMonth(ST.wYear, ST.wMonth), ST.wDay);
             Modified := true;
             ch := true;
           end;
        2: begin
             if (i < 1) or (i > 12) then
             begin
               if Byte(Msg.CharCode - Ord('0')) = 0 then
               begin
                 i := st.wMonth;
                 FDI := '';
               end
               else
               begin
                 i := Byte(Msg.CharCode - ord('0'));
                 FDI := FDI[Length(FDI)];
               end;
             end;
             ST.wMonth := i;
             ST.wDay := Min(LMDDaysPerMonth(ST.wYear, ST.wMonth), ST.wDay);
             Modified := true;
             ch := true;
           end;
        3: begin
             if (i < 1) or (i > LMDDaysPerMonth(ST.wYear, ST.wMonth)) then
             begin
               if Byte(Msg.CharCode - Ord('0')) = 0 then
               begin
                 i := st.wDay;
                 FDI := '';
               end
               else
               begin
                 i := Byte(Msg.CharCode - ord('0'));
                 FDI := FDI[Length(FDI)];
               end;
             end;
             ST.wDay := i;
             Modified := true;
             ch := true;
           end;
        4,
        5: begin
             if Use12Hours then
             begin
               if (i < 0) or (i > 11) then
               begin
                 FDI := FDI[Length(FDI)];
                 i := Byte(Msg.CharCode - ord('0'));
               end;
             end else
             begin
               if (i < 0) or (i > 23) then
               begin
                 FDI := FDI[Length(FDI)];
                 i := Byte(Msg.CharCode - ord('0'));
               end;
             end;
             ST.wHour := i;
             Modified := true;
             ch := true;
           end;
        6: begin
             if (i < 0) or (i > 59) then
             begin
               FDI := FDI[Length(FDI)];
               i := Byte(Msg.CharCode - ord('0'));
             end;
             ST.wMinute := i;
             Modified := true;
             ch := true;
           end;
        7: begin
             if (i < 0) or (i > 59) then
             begin
               FDI := FDI[Length(FDI)];
               i := Byte(Msg.CharCode - ord('0'));
             end;
             ST.wSecond := i;
             Modified := true;
             ch := true;
           end;
      end;
    end else
    if (FCurPart < DTFParts.Count - 2) and
       ((PDTFPart(DTFParts[FCurPart + 1]).DPart = 9) or
        ((PDTFPart(DTFParts[FCurPart + 1]).DPart = -1) and
         ((Part.DPart in [0..3]) and
          (PDTFPart(DTFParts[FCurPart + 1]).Text = DateSeparator)) or
         ((Part.DPart in [4..7]) and
          (PDTFPart(DTFParts[FCurPart + 1]).Text = TimeSeparator)))) then
    begin
      if Char(Msg.CharCode) = PDTFPart(DTFParts[FCurPart + 1]).Text then
      begin
        b := false;
        for i := FCurPart + 1 to DTFParts.Count - 1 do
        begin
          Part := PDTFPart(DTFParts[i]);
          if (Part.DPart in [0, 1, 2, 3, 4, 6, 7, 8]) then
          begin
            FCurPart := i;
            FDI := '';
            UpdateText;
            InvalidateEdit;
            b := true;
            break;
          end;
        end;
        if not b and (ShowCheckBox) then
        begin
          FCurPart := -1;
          InvalidateEdit;
        end;
      end;
    end
    else
    if Part.DPart = 8 then
    begin
      if ((Length(TimeAMString) > 0) and
           ((Char(Msg.CharCode) = UpCase(TimeAMString[1])) or (Char(Msg.CharCode - 32) = UpCase(TimeAMString[1])))) then
      begin
        if ST.wHour >= 12 then
        begin
          Dec(ST.wHour, 12);
          Modified := true;
          ch := true;
        end;
      end else
      if ((Length(TimePMString) > 0) and
           ((Char(Msg.CharCode) = UpCase(TimePMString[1])) or (Char(Msg.CharCode - 32) = UpCase(TimePMString[1])))) then
      begin
        if ST.wHour < 12 then
        begin
          Inc(ST.wHour, 12);
          Modified := true;
          ch := true;
        end;
      end else
      if ((LowerCase(Part.Text) = 'am/pm') and
           (Char(Msg.CharCode) in ['a', 'p', 'a', 'p'])) then
      begin
        if (UpCase(Char(Msg.CharCode)) = 'A') and (ST.wHour >= 12) then
        begin
          Dec(ST.wHour, 12);
          Modified := true;
          ch := true;
        end else
        if (UpCase(Char(Msg.CharCode)) = 'P') and (St.wHour < 12) then
        begin
          Inc(ST.wHour, 12);
          Modified := true;
          ch := true;
        end;
      end;
    end;
    DoSetDateTime(SystemTimeToDateTime(ST));
    UpdateText;
    if ch then
      TriggerChangeEvent;
    InvalidateEdit;
  end;
end;  { WMChar }
*)

procedure TElDateTimePicker.CreateWindowHandle(const Params: TCreateParams);  { protected }

var Fmt : string;
begin
  inherited;
  if not (csLoading in ComponentState) then
  begin
    Fmt := FFormatStr;
    FFormatStr := '~~~';
    SetFormatStr(Fmt);
  end;
  FButton.Width := GetActiveButtonWidth;
  SetEditRect;
end;  { CreateWindowHandle }

procedure TElDateTimePicker.CMCancelMode(var Msg: TCMCancelMode);
begin
  if (Msg.Sender <> Self) and
     (Msg.Sender <> FCalButton)
     and (Msg.Sender <> FForm)
     then
     CloseUp(False);
end;

procedure TElDateTimePicker.CalendarChange(Sender: TObject);
begin
  if not Assigned(FForm) then
    exit;
  if FUseMonthCalendar then
  begin
    if LMDInRangeF(FForm.MCalendar.Date, MinDate, MaxDate) or FForm.Unassigned then
      CloseUp(true);
  end
  else
  begin
    if LMDInRangeF(FForm.Calendar.Date + Frac(FForm.Clock.DT), MinDate, MaxDate) or FForm.Unassigned then
      CloseUp(true);
  end;
end;

procedure TElDateTimePicker.CalendarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((Key = VK_ESCAPE) or (Key = VK_F4)) and (Shift = []) then
    CloseUp(false);
end;

procedure TElDateTimePicker.SetShowPopupCalendar(newValue : Boolean);
{ Sets data member FShowPopupCalendar to newValue. }
begin
  if (FShowPopupCalendar <> newValue) then
  begin
    FShowPopupCalendar := newValue;
    if FShowPopupCalendar then
    begin
      FForm := THackCalendarForm.CreateNew(nil, 0);
      //FForm.
      FForm.Font.Assign(FCalendarFormFont);
      FForm.FTag := 1;
      FForm.Visible := false;
      FForm.CustomCalendarNames.Assign(FCustomCalendarNames);
      if not FForm.UseMonthCalendar then
      begin
        FForm.Calendar.CustomCalendarNames.Assign(FCustomCalendarNames);
        FForm.SetNames;
      end;
      {
      with TElFormPersist.Create(FForm) do
        TopMost := true;
      }
      FForm.FormStyle := fsStayOnTop;
      FForm.Position := poDesigned;
      FForm.BorderStyle := bsNone;
//      FForm.Height := FForm.Height - FForm.Panel2.Height;
//      FForm.Panel2.Visible := false;
      if not FForm.UseMonthCalendar then
        FForm.Calendar.Tag := TLMDPtrInt(Pointer(Self));
      FForm.Calendar.TabStop := false;
      FForm.Calendar.ShowHint := false;
      FCalendarShowClock := False;
      FForm.ShowClock := False;
      FForm.Calendar.UserNavigation := false;
      FForm.YearSpin.MinValue := 0;
      FForm.AutoSize := false;
      FForm.OnKeyDown := CalendarKeyDown;
      FForm.OnChange := CalendarChange;
      FForm.OnDeactivate := CalendarDeactivate;
      // TuneupCalendarControls;
    end
    else
      if Assigned(FForm) then
        FreeAndNil(FForm);
    if HandleAllocated then
    begin
      UpdateText;
      InvalidateEdit;
    end;
  end;  { if }
end;  { SetShowPopupCalendar }

destructor TElDateTimePicker.Destroy;
begin
  FCalendarHolidays.Free;
  if Assigned(FForm) then
    FreeAndNil(FForm);
  FreeAndNil(DTFParts);
  FreeAndNil(FButton);
  FreeAndNil(FCalButton);
  FreeAndNil(FDisplayReadOnlyOptions);
  FreeAndNil(FCalendarCurrentDayBitmap);
  ImageForm := nil;
  FreeAndNil(FImgFormChLink);
  FreeAndNil(FTmpBmp);
  FreeAndNil(FBackground);
  FreeAndNil(FCustomCalendarNames);
  FreeAndNil(FCalendarFormFont);
  inherited Destroy;
end;  { Destroy }

procedure TElDateTimePicker.CalendarDeactivate(Sender : TObject);
begin
  if not Assigned(FForm) then
    exit;
  if FForm.ModalResult = 6 then
  begin
    CloseUp(True);
    FForm.ModalResult := 0;
  end
  else
    CloseUp(False);
end;

procedure TElDateTimePicker.CalendarFormFontChange(Sender: TObject);
begin
  if Assigned(FForm) then
    FForm.Font.Assign(FCalendarFormFont);
end;

type
  TElHackThemedControl = class(TElXPThemedControl);

procedure TElDateTimePicker.TuneupCalendarControls;
var
  i : Integer;
begin
  if not Assigned(FForm) then
    Exit;
  FForm.ShowTodayButton := FShowTodayButton;
  FForm.FlatButtons := FCalendarFlatButtons;
  if not FUseMonthCalendar then
  begin
    FForm.MonthCombo.HighlightAlphaLevel := FHighlightAlphaLevel;
    FForm.YearSpin.HighlightAlphaLevel := FHighlightAlphaLevel;
    FForm.Calendar.HighlightAlphaLevel := FHighlightAlphaLevel;
    FForm.Calendar.LineColorLight := FLineColorLight;
    FForm.Calendar.LineColorDark := FLineColorDark;
    FForm.Calendar.Color := FCalendarBackColor;
    FForm.Color := FCalendarFormColor;
    FForm.Calendar.StartOfWeek := FStartOfWeek;
    FForm.Calendar.WeekEndDays := FWeekEndDays;
    FForm.Calendar.UseSystemStartOfWeek := FUseSystemStartOfWeek;
    FForm.Calendar.UseLineColors := FUseLineColors;
    FForm.Calendar.WeekEndColor := FWeekendColor;
    FForm.Calendar.GridVertLines := FCalendarGridVertLines;
    FForm.Calendar.CurrentDayBorder := FCurrentDayBorder;
    FForm.Calendar.DayCellBorder := FCalendarDayCellBorder;
    FForm.Calendar.SelectionBorder := FCalendarSelectionBorder;
    FForm.Calendar.TranslateDays := FTranslateDays;
    FForm.Calendar.Holidays.Assign(FCalendarHolidays);
    FForm.Calendar.ShowWeekNum := FCalendarShowWeekNum;
    FForm.Calendar.OnDetermineHoliday :=  FOnDetermineHoliday;
    FForm.Calendar.HolidayColor := FCalendarHolidayColor;
    FForm.Calendar.FocusedSelectColor := FFocusedSelectColor;
    FForm.Calendar.FocusedSelectTextColor := FFocusedSelectTextColor;
    FForm.Calendar.HideSelectColor := FHideSelectColor;
    FForm.Calendar.HideSelectTextColor := FHideSelectTextColor;
    FForm.Calendar.HideSelection := FHideSelection;
    FForm.Calendar.GridHorzLines := FCalendarGridHorzLines;
    FForm.Calendar.GridLineColor := FCalendarGridLineColor;
    FForm.Calendar.OtherMonthDayColor := FCalendarOtherMonthDayColor;
    FForm.Calendar.OnBeforeCellDraw := FOnBeforeCellDraw;
    FForm.Calendar.ShowOtherMonthDays := FCalendarShowOtherMonthDays;
    FForm.Calendar.LineBorderColor := FCalendarLineBorderColor;
    if not FCalendarCurrentDayBitmap.Empty then
      FForm.Calendar.CurrentDayBitmap.Assign(FCalendarCurrentDayBitmap);
    FForm.Calendar.CurrentDayUseBitmap := FCalendarCurrentDayUseBitmap;
    FForm.YearSpin.FocusedSelectColor := FFocusedSelectColor;
    FForm.MonthCombo.FocusedSelectColor := FFocusedSelectColor;
    FForm.YearSpin.FocusedSelectTextColor := FFocusedSelectTextColor;
    FForm.MonthCombo.FocusedSelectTextColor := FFocusedSelectTextColor;
    FForm.YearSpin.HideSelectColor := FHideSelectColor;
    FForm.MonthCombo.HideSelectColor := FHideSelectColor;
    FForm.YearSpin.HideSelectTextColor := FHideSelectTextColor;
    FForm.MonthCombo.HideSelectTextColor := FHideSelectTextColor;
    FForm.YearSpin.HideSelection := FHideSelection;
    FForm.MonthCombo.HideSelection := FHideSelection;
    if FNavigationInPopup then
    begin
      FForm.Panel1.Visible := true;
    end
    else
    begin
      FForm.Panel1.Visible := false;
      FForm.Height := FForm.Height - FForm.Panel1.Height;
    end;
  end;
  FForm.ShowClock := FCalendarShowClock;
  for i := 0 to FForm.ComponentCount - 1 do
  begin
    if FForm.Components[i] is TWinControl then
      TWinControl(FForm.Components[i]).TabStop := false;
  end;
 // FForm.SetFormThemed(UseXPThemes);
  FForm.SetThemeMode(UseThemeMode);
  CalcFormSizes;
end;

procedure TElDateTimePicker.DblClick;  { public }

begin
  inherited;
  if ((not ShowCheckBox) or Checked) then
  begin
    if ShowCheckBox and (ScreenToClient(Mouse.CursorPos).X < GetCheckWidth) then
    begin
      InDblClick := true;
      exit;
    end;

    InDblClick := true;
    if ShowPopupCalendar then DropDown;
  end;
end;  { DblClick }

procedure TElDateTimePicker.SetDroppedDown(newValue : boolean);
begin
  if not Assigned(FForm) then
    exit;
  if FForm.Visible <> newValue then
     DropDown;
end;

function TElDateTimePicker.GetDroppedDown;
begin
  result := FDroppedDown;//FForm.Visible;
end;

procedure TElDateTimePicker.SetShowCheckBox(newValue : Boolean);
begin
  if (FShowCheckBox <> newValue) then
  begin
    FShowCheckBox := newValue;

    if FShowCheckBox then
    begin
      FButton.Enabled := FChecked;
      FCalButton.Enabled := FChecked;
    end else
    begin
      FButton.Enabled := true;
      FCalButton.Enabled := true;
    end;
    // FButton.Flat := Flat and ((not (Focused or FMouseOver))  or ((not Checked) and ShowCheckBox and Flat));

    if HandleAllocated then
    begin
      UpdateText;
      Invalidate;
    end;
  end;
end;  { SetShowCheckBox }

procedure TElDateTimePicker.SetModified(newValue : Boolean);
begin
  if FModified <> newValue then
  begin
    FModified := newValue;
//    if FModified then
//      TriggerChangeEvent;
  end;
end;

procedure TElDateTimePicker.SetChecked(newValue : Boolean);
begin
  if (FChecked <> newValue) then
  begin
    FChecked := newValue;
    if ShowCheckBox then
    begin
      FButton.Enabled := FChecked;
      FCalButton.Enabled := FChecked;
    end;
    Invalidate;
  end;  { if }
end;  { SetChecked }

procedure TElDateTimePicker.ChangeBtnGlyph;
var
  ABmp : TBitmap;
begin
  ABMP := TBitmap.Create;
  ABmp.Width := 9;
  Abmp.Height := (MulDiv(FCalButton.Height, Screen.PixelsPerInch, 96) - 5) div 2;
  Abmp.PixelFormat := pf24bit;
  Abmp.TransparentMode := tmFixed;
  Abmp.TransparentColor := clWhite;
  Abmp.Canvas.Brush.Color := clWhite;
  LMDDrawArrow(ABmp.Canvas, eadDown, Rect(0, 1, 9, ABmp.Height), clBtnText, FCalButton.Enabled);
//  ElVCLUtils.DrawArrow(ABmp.Canvas, eadDown, Rect(0, 1, 9, 5), clBtnText, FCalButton.Enabled);
  FCalButton.Glyph := ABmp;
  ABmp.Free;
end;

procedure TElDateTimePicker.CMEnabledChanged(var Msg : TMessage);  { private }
begin
  inherited;
  FButton.Enabled := not ((not Enabled) or (ShowCheckBox and (not Checked))) and not FReadOnly;
  FCalButton.Enabled := FButton.Enabled and not FReadOnly;
  if not (csDesigning in ComponentState) then
    ChangeBtnGlyph;
  if UseDisabledColors or UseXPThemes then
    Invalidate;
end;  { CMEnabledChanged }

constructor TElDateTimePicker.Create(AOwner : TComponent);
begin
  BeginCreate;
  inherited Create(AOwner);
  FCalendarFormFont := TFont.Create;
  FCalendarFormFont.OnChange := CalendarFormFontChange;
  FBorderSides := [ebsLeft, ebsTop, ebsRight, ebsBottom];
  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;
  FButtonThinFrame := True;
  FLineBorderActiveColor := clBtnFace;
  FLineBorderInactiveColor := clBtnFace;
  FCustomCalendarNames := TElCustomCalendarNames.Create;
  FCustomCalendarNames.OnChange := NamesChanged;
  FFontMargin := 1;

  FUnassignedChar := ' ';
  FButtonVisible := true;
  FBtnWidth := GetSystemMetrics(SM_CXVSCROLL);
  //FButtonWidth := FBtnWidth;

  FImgFormChLink  := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  FButtonShowBorder := true;
  FButton := TElSpinButton.Create(Self);
  FButton.DoubleBuffered := True;

  FButton.StyleManager := nil;
  FButton.Increment := 1;
  FButton.OnUpClick := SpinUpClick;
  FButton.OnDownClick := SpinDownClick;
  FButton.UseDrag := false;
  FButton.Flat := false;

  FCalButton := TElDTPickButton.Create(Self);
  FCalButton.StyleManager := nil;
  FCalButton.Visible := false;
  FCalButton.Parent := Self;
  FCalButton.ParentColor := false;
  FCalButton.Color   := clBtnFace;
  FCalButton.OnClick := CalBtnClick;
  FCalButton.Spacing := 0;
  FCalButton.Layout  := blGlyphTop;
  FCalButton.IsSwitch := true;
  FCalButton.Cursor := crArrow;
  FCalButton.AdjustSpaceForGlyph := false;
  FCalButton.Flat := false;

  FDisplayReadOnlyOptions := TElDisplayOptions.Create;
  FDisplayReadOnlyOptions.OnChange := DisplayOptionsChange;
  ChangeBtnGlyph;

{  ABMP := TBitmap.Create;
  ABmp.Width := 9;
  Abmp.Height := 5;
  Abmp.PixelFormat := pf24bit;
  Abmp.TransparentMode := tmFixed;
  Abmp.TransparentColor := clWhite;
  Abmp.Canvas.Brush.Color := clWhite;
  ElVCLUtils.DrawArrow(ABmp.Canvas, eadDown, Rect(0, 1, 9, 5), clBtnText, true);
  // ElVCLUtils.DrawArrow(ABmp.Canvas, eadDown, Rect(9, 1, 17, 5), clBtnText, false);
  ///ABmp.SaveToFile('c:\ground2.bmp');
  // ABmp.Transparent := true;
  FCalButton.Glyph := ABmp;
  // FCalButton.NumGlyphs := 2;
  ABmp.Free;}

  DTFParts := TLMDObjectList.Create;
  DTFParts.OnDelete := OnDTFPartDelete;
  FAutoSize := true;
  FButtonShowBorder := true;

  FBackground := TBitmap.Create;
  FBackground.OnChange := ImageChange;
  FBackgroundType := bgtColorFill;
  FGradientSteps := 16;
  FBackgroundType := bgtColorFill;
  FTmpBmp := TBitmap.Create;
  FDate := Now;
  Width := 120;
  Height := 21;
  ParentColor := False;
  Color := clWindow;
  FDropDownAlignment := taRightJustify;
  FButtonColor := clBtnFace;
  FDisabledColor := clBtnFace;
  FDisabledFontColor := clGrayText;

  FBorderStyle := bsSingle;
  FNavigationInPopup := true;

  FInactiveBorderType := fbtSunkenOuter;
  FActiveBorderType := fbtSunken;

  FMinDate := -693593;
  FMaxDate := 999999;
  FChecked := True;

  TabStop := true;
  HighlightAlphaLevel := 255;

  FHideSelection := true;
  FFocusedSelectColor := clHighlight;
  FFocusedSelectTextColor := clHighlightText;
  FHideSelectColor := clBtnFace;
  FHideSelectTextColor := LMDElHideSelectTextColor;

  FUnassignedColor := clRed;
  FLinkedControlPosition := lcpTopLeft;

  // this must be the last
  FButton.Parent := Self;
  FCalButton.Parent  := Self;
  FLineColorLight := clWindow;
  FLineColorDark := clBtnShadow;
  FCalendarBackColor := clWindow;
  FCalendarFormColor := clBtnFace;
  FWeekEndDays := [Sat, Sun];
  FUseSystemStartOfWeek := True;
  FUseLineColors := false;
  FWeekendColor := clRed;
  FCalendarGridVertLines := True;
  FCurrentDayBorder := fbtSunken;
  FCalendarDayCellBorder := fbtLine;
  FCalendarSelectionBorder := fbtSunken;
  FTranslateDays := false;
  FCalendarHolidays := TElHolidays.Create(Self);
  FCalendarShowWeekNum := false;
  FCalendarHolidayColor := clWindowText;
  FCalendarGridHorzLines := True;
  FCalendarGridLineColor := clBtnFace;
  FCalendarOtherMonthDayColor := clGrayText;
  FCalendarShowOtherMonthDays := false;
  FShowTodayButton := True;
  FIgnoreReadOnlyState := false;
  FCalendarCurrentDayBitmap := TBitmap.Create;
  FCalendarCurrentDayBitmap.OnChange := CurrDayImageChange;
  FCalendarCurrentDayUseBitmap := False;
  FCalendarLineBorderColor := clWindowText;
  FOldFontChanged := Font.OnChange;
  Font.OnChange := FontChanged;
  FUseMonthCalendar := False;
  FCalendarFlatButtons := True;
  EndCreate;
end;  { Create }

procedure TElDateTimePicker.SetCalendarLineColorLight(Value: TColor);
begin

  FLineColorLight := Value;
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.LineColorLight := Value;
end;

procedure TElDateTimePicker.SetCalendarLineColorDark(Value: TColor);
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.LineColorDark := Value;
  FLineColorDark := Value;
end;

function TElDateTimePicker.GetCalendarLineColorDark: TColor;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    result := FForm.Calendar.LineColorDark
  else
    result := FLineColorDark;
end;

function TElDateTimePicker.GetCalendarLineColorLight: TColor;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    result := FForm.Calendar.LineColorLight
  else
    result := FLineColorLight;
end;

procedure TElDateTimePicker.SetCalendarBackColor(Value: TColor);
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.Color := Value;
  FCalendarBackColor := value;
end;

procedure TElDateTimePicker.SetCalendarFlatBtn(Value: Boolean);
begin
  if Assigned(FForm) then
    FForm.FlatButtons := Value;
  FCalendarFlatButtons := value;
end;

procedure TElDateTimePicker.SetCalendarFormColor(Value: TColor);
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Color := Value;
  FCalendarFormColor := Value;
end;

procedure TElDateTimePicker.SetCalendarFormFont(const Value: TFont);
begin
  FCalendarFormFont.Assign(Value);
end;

function TElDateTimePicker.GetCalendarFlatBtn: Boolean;
begin
  if Assigned(FForm)  then
    result := FForm.FlatButtons
  else
    Result := FCalendarFlatButtons;
end;

function TElDateTimePicker.GetCalendarFormColor: TColor;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    Result := FForm.Color
  else
    Result := FCalendarFormColor;
end;

function TElDateTimePicker.GetCalendarBackColor: TColor;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    result := FForm.Calendar.Color
  else
    Result := FCalendarBackColor;
end;

function TElDateTimePicker.GetStartOfWeek: TDayOfWeek;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    Result := FForm.Calendar.StartOfWeek
  else
    Result := FStartOfWeek;
end;

procedure TElDateTimePicker.SetStartOfWeek(Value: TDayOfWeek);
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.StartOfWeek := Value;
  FStartOfWeek := Value;
end;

function TElDateTimePicker.GetWeekEndDays: TElWeekEndDays;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    Result := FForm.Calendar.WeekEndDays;
  Result := FWeekEndDays;
end;

procedure TElDateTimePicker.SetWeekEndDays(Value: TElWeekEndDays);
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.WeekEndDays := Value;
  FWeekEndDays := Value;
end;

function TElDateTimePicker.GetUseSystemStartOfWeek: Boolean;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    Result := FForm.Calendar.UseSystemStartOfWeek
  else
    Result := FUseSystemStartOfWeek;
end;

procedure TElDateTimePicker.SetUseSystemStartOfWeek(Value: Boolean);
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.UseSystemStartOfWeek := Value;
  FUseSystemStartOfWeek := Value;
end;

procedure TElDateTimePicker.TriggerCheckboxChangeEvent;
begin
  if assigned(FOnCheckboxChange) then
    FOnCheckboxChange(Self);
end;

function TElDateTimePicker.GetCalendarUseLineColors: Boolean;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    Result := FForm.Calendar.UseLineColors
  else
    Result := FUseLineColors;
end;

function TElDateTimePicker.GetCalendarUserNavigation: Boolean;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    Result := FForm.Calendar.UserNavigation
  else
    Result := FUserNavigation;
end;

procedure TElDateTimePicker.SetCalendarUseLineColors(Value: Boolean);
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.UserNavigation := Value;
  FUserNavigation := Value;
end;

procedure TElDateTimePicker.SetCalendarUserNavigation(const Value: Boolean);
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.UseLineColors := Value;
  FUseLineColors := Value;
end;

function TElDateTimePicker.GetCalendarWeekendColor: TColor;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    result := FForm.Calendar.WeekEndColor
  else
    Result := FWeekendColor;
end;

procedure TElDateTimePicker.SetCalendarWeekendColor(Value: TColor);
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.WeekEndColor := Value;
  FWeekendColor := Value;
end;

function TElDateTimePicker.GetCalendarGridVertLines: Boolean;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    result := FForm.Calendar.GridVertLines
  else
    Result := FCalendarGridVertLines;
end;

procedure TElDateTimePicker.SetCalendarGridVertLines(Value: Boolean);
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.GridVertLines := Value;
  FCalendarGridVertLines := Value;
end;

procedure TElDateTimePicker.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TElDateTimePicker.WMNCCalcSize(var Message : TWMNCCalcSize);

begin
  inherited;
  if (BorderStyle = bsSingle) and (not IsThemed) then
    begin
      if not (ebsLeft in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(SM_CYEDGE));
      if not (ebsTop in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(SM_CXEDGE));
      if not (ebsRight in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(SM_CYEDGE));
      if not (ebsBottom in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(SM_CXEDGE));
      end;
end;

function TElDateTimePicker.StoreStartOfWeek: Boolean;
begin
  Result := not UseSystemStartOfWeek;
end;

function TElDateTimePicker.GetCalendarCurrentDayBorder: TElFlatBorderType;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    result := FForm.Calendar.CurrentDayBorder
  else
    Result := FCurrentDayBorder;
end;

procedure TElDateTimePicker.SetCalendarCurrentDayBorder(Value:
    TElFlatBorderType);
begin
  FCurrentDayBorder := Value;
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.CurrentDayBorder := Value;
end;

function TElDateTimePicker.GetCalendarDayCellBorder: TElFlatBorderType;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    result := FForm.Calendar.DayCellBorder
  else
    result := FCalendarDayCellBorder;
end;

procedure TElDateTimePicker.SetCalendarDayCellBorder(Value: TElFlatBorderType);
begin
  FCalendarDayCellBorder := value;
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.DayCellBorder := Value;
end;

function TElDateTimePicker.GetCalendarSelectionBorder: TElFlatBorderType;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    result := FForm.Calendar.SelectionBorder
  else
    result := FCalendarSelectionBorder;
end;

procedure TElDateTimePicker.SetCalendarSelectionBorder(Value:
    TElFlatBorderType);
begin
  FCalendarSelectionBorder := Value;
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.SelectionBorder := Value;
end;

function TElDateTimePicker.GetTranslateDays: Boolean;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    Result := FForm.Calendar.TranslateDays
  else
    result := FTranslateDays;
end;

procedure TElDateTimePicker.SetTranslateDays(Value: Boolean);
begin
  FTranslateDays := Value;
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.TranslateDays := Value;
end;

procedure TElDateTimePicker.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;

procedure TElDateTimePicker.WMWindowPosChanged(var Message:
    TWMWindowPosChanged);
begin
  inherited;
  UpdateLinkedControl;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
end;

procedure TElDateTimePicker.DrawFlatFrame(Canvas : TCanvas; R : TRect);
var
  clr1, clr2 : TColor;
begin
  if ((Focused or FMouseOver) and (ActiveBorderType = fbtColorLineBorder)) or
     ((not (Focused or FMouseOver)) and (InactiveBorderType = fbtColorLineBorder)) then
  begin
    if Enabled then
      clr2 := clWindow
    else
      clr2 := clBtnFace;
    if Focused or FMouseOver then
      clr1 := LineBorderActiveColor
    else
      clr1 := LineBorderInactiveColor;
    ELVCLUtils.DrawFlatFrameEx2(Canvas.Handle, R, clr1, clr2, false, true, AllBorderSides, fbtColorLineBorder, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
  end
  else
  begin
    if Enabled or not UseDisabledColors then
      clr2 := clWindow
    else
      clr2 := clBtnFace;

    ElVCLUtils.DrawFlatFrame(Canvas.Handle, R, clr2, false);
  end;
end;

procedure TElDateTimePicker.SetMinDate(Value: TDateTime);
begin
  if (FMinDate <> Value) then
  begin
    //if Value < 2 then
    //  Value := 2;
    FMinDate := Value;
    if (not (csLoading in ComponentState)) and (FDate < FMinDate) then
    begin
      FDate := FMinDate;
      if HandleAllocated then
      begin
        UpdateText;
        InvalidateEdit;
      end;
    end;
  end;
end;

procedure TElDateTimePicker.SetMaxDate(Value: TDateTime);
begin
  if FMaxDate <> Value then
  begin
    FMaxDate := Value;
    if (not (csLoading in ComponentState)) and (FDate > FMaxDate) then
    begin
      FDate := FMaxDate;
      if HandleAllocated then
      begin
        UpdateText;
        InvalidateEdit;
      end;
    end;
  end;
end;

function TElDateTimePicker.DoSetDateTime(ADate : TDateTime): Boolean;
begin
  Result := false;
  if (FDate <> ADate) then
  begin
    if (ADate <= MaxDate) and (ADate >= MinDate) then
    begin
      //if ADate < 2 then
      //   ADate := 2;
      FDate := ADate;
      TriggerChangeEvent;
      Result := True;
    end;
  end;
end;

function TElDateTimePicker.GetThemedElement: TThemedElement;
begin
  Result := teEdit;
end;

procedure TElDateTimePicker.SetUseXPThemes(const Value: Boolean);
begin
  inherited;
 { FButton.ThemeMode := LMDCtlXP[Value];
  FCalButton.ThemeMode := LMDCtlXP[Value];
  if Assigned(FForm) then
    FForm.SetFormThemed(Value); }
end;

procedure TElDateTimePicker.DoThemeChanged;
begin
  inherited;
  FButton.ThemeMode := ThemeMode;
  FButton.ThemeGlobalMode := ThemeGlobalMode;
  FCalButton.ThemeMode := ThemeMode;
  FCalButton.ThemeGlobalMode := ThemeGlobalMode;
  if Assigned(FForm) then
    FForm.SetFormThemed(GetUseXpThemes);
end;

function TElDateTimePicker.GetButtonDir: TElSpinBtnDir;
begin
  Result := FButton.ButtonDirection;
end;

procedure TElDateTimePicker.SetButtonDir(Value: TElSpinBtnDir);
begin
  FButton.ButtonDirection := Value;
end;

function TElDateTimePicker.GetButtonType: TElSpinBtnType;
begin
  Result := FButton.ButtonType;
end;

procedure TElDateTimePicker.SetButtonType(Value: TElSpinBtnType);
begin
  FButton.ButtonType := Value;
end;

procedure TElDateTimePicker.SetButtonWidth(Value: Integer);
begin
  if FBtnWidth <> Value then
  begin
    FBtnWidth := Value;
    if not (csLoading in ComponentState) then
      SetEditRect;
  end;
end;

procedure TElDateTimePicker.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;

    UpdateButtonStyles;

    if Flat and (Focused or FMouseOver) then
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TElDateTimePicker.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;

    UpdateButtonStyles;

    if Flat and not (Focused or FMouseOver) then
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TElDateTimePicker.UpdateButtonStyles;
begin
  FButton.MoneyFlat := Flat and (InactiveBorderType = fbtColorLineBorder) and (ActiveBorderType = fbtColorLineBorder);
  FButton.MoneyFlatActiveColor := LineBorderActiveColor;
  FButton.MoneyFlatInactiveColor := LineBorderInactiveColor;
  FButton.MoneyFlatDownColor := LineBorderActiveColor;

  FCalButton.MoneyFlat := FButton.MoneyFlat;
  FCalButton.MoneyFlatActiveColor := LineBorderActiveColor;
  FCalButton.MoneyFlatInactiveColor := LineBorderInactiveColor;
  FCalButton.MoneyFlatDownColor := LineBorderActiveColor;
end;

procedure TElDateTimePicker.SetButtonVisible(Value: Boolean);
begin
  if FButtonVisible <> Value then
  begin
    FButtonVisible := Value;
    SetEditRect;
    Invalidate;
  end;
end;

procedure TElDateTimePicker.SetUnassigned(Value: Boolean);
begin
  if FUnassigned <> Value then
  begin
    FUnassigned := Value;
    if HandleAllocated then
    begin
      UpdateText;
      InvalidateEdit;
    end;
  end;
end;

procedure TElDateTimePicker.SetUnassignedColor(Value: TColor);
begin
  if FUnassignedColor <> Value then
  begin
    FUnassignedColor := Value;
    if Unassigned and HandleAllocated and Focused then
      InvalidateEdit;
  end;
end;

procedure TElDateTimePicker.SetUnassignedAllowed(Value: Boolean);
begin
  if FUnassignedAllowed <> Value then
  begin
    FUnassignedAllowed := Value;
    if Unassigned and (not FUnassignedAllowed) then
      Unassigned := false;
  end;
end;

function TElDateTimePicker.GetReadOnly: Boolean;
begin
  Result := FReadOnly;
end;

procedure TElDateTimePicker.SetReadOnly(Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    if FDisplayReadOnlyOptions.Enabled then
      Invalidate;
    FButton.Enabled := not FReadOnly;
    FCalButton.Enabled := not FReadOnly;
    if not (csDesigning in ComponentState) then
      ChangeBtnGlyph;
  end;
end;

procedure TElDateTimePicker.SetButtonShowOnFocus(Value: Boolean);
begin
  if FButtonShowOnFocus <> Value then
  begin
    FButtonShowOnFocus := Value;
    if ButtonVisible then
    begin
      if not Focused then
      begin
        SetEditRect;
        Invalidate;
      end;
    end;
  end;
end;

function TElDateTimePicker.IsDateTimeStored: Boolean;
begin
  Result := not UseCurrentDate;
end;

procedure TElDateTimePicker.SetButtonThinFrame(Value: Boolean);
begin
  if FButtonThinFrame <> Value then
  begin
    FButtonThinFrame := Value;
    FButton.ThinFrame := Value;
    FCalButton.ThinFrame := Value;
  end;
end;

procedure TElDateTimePicker.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    UpdateHeight;
    end;
end;

procedure TElDateTimePicker.AdjustHeight;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TLMDTextMetric;
begin
  DC := GetDC(0);
  LMDGetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  LMDGetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);

  if Ctl3D then
    I := GetSystemMetrics(SM_CYEDGE) * 4
  else
    I := GetSystemMetrics(SM_CYBORDER) * 6;

  Height := Metrics.tmHeight + I;
end;

procedure TElDateTimePicker.UpdateHeight;
begin
  if FAutoSize {and (BorderStyle = bsSingle)} then
  begin
    ControlStyle := ControlStyle + [csFixedHeight];
    AdjustHeight;
  end
  else
    ControlStyle := ControlStyle - [csFixedHeight];
end;

procedure TElDateTimePicker.CreateWnd;
begin
  inherited;
  UpdateHeight;
end;

{$ifdef LMD_UNICODE}
procedure TElDateTimePicker.CMHintShow(var Message: TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message); //outcommented VB Dec 2008
end;

procedure TElDateTimePicker.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF}

function TElDateTimePicker.GetUnassignedChar: TLMDString;
begin
  Result := FUnassignedChar;
end;

procedure TElDateTimePicker.SetUnassignedChar(Value: TLMDString);
begin
  if Length(Value) = 0 then
    FUnassignedChar := ' '
  else
    FUnassignedChar := Value[1];
  if Unassigned and HandleAllocated then
  begin
    UpdateText;
    InvalidateEdit;
  end;
end;

function TElDateTimePicker.MakeUnassignedString(Length : integer): TLMDString;
begin
  {$ifdef LMD_UNICODE}
  Result := LMDWideMakeString(Length, FUnassignedChar);
  {$else}
  Result := LMDAnsiMakeString(Length, FUnassignedChar);
  {$endif}
end;

procedure TElDateTimePicker.SetCalendarDate(Date : TDateTime);
begin
  if Assigned(FForm) and DroppedDown then
  begin
    if FUseMonthCalendar then
      FForm.MCalendar.Date := Date
    else
      FForm.Calendar.Date := Date;
  end;
end;

function TElDateTimePicker.GetCalendarHolidays: TElHolidays;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    result := FForm.Calendar.Holidays
  else
    Result := FCalendarHolidays;
end;

procedure TElDateTimePicker.SetCalendarHolidays(Value: TElHolidays);
begin
  FCalendarHolidays := value;
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.Holidays := value;
end;

function TElDateTimePicker.SeparatorValue(Symbol : char):Char;
begin
  if Symbol = '/' then
    Result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DateSeparator
  else
    if Symbol = ':' then
      Result := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimeSeparator
    else
      Result := #0;
end;

procedure TElDateTimePicker.KeyPress(var Key : char);
var
  Part : PDTFPart;
begin
  inherited;
  if FCurPart >= 0 then
  begin
    Part := PDTFPart(DTFParts[FCurPart]);
    if ((not ShowCheckBox) or Checked) then
      if (Part.DPart in [0, 1, 2, 3, 4, 6, 7, 8, 11]) and
        (DTFParts.Count > FCurPart + 1) and (PDTFPart(DTFParts[FCurPart + 1]).DPart = 9) and
          (Key = SeparatorValue(PDTFPart(DTFParts[FCurPart + 1]).Text[1])) then
      begin
        AdvancePosition;
        Key := #0;
      end;
  end;
end;

function TElDateTimePicker.GetCalendarShowWeekNum: Boolean;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    result := FForm.Calendar.ShowWeekNum
  else
    Result := FCalendarShowWeekNum;
end;

procedure TElDateTimePicker.SetCalendarShowWeekNum(Value: Boolean);
begin
  FCalendarShowWeekNum := value;
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.ShowWeekNum := value;
end;

function TElDateTimePicker.GetOnDetermineHoliday: TElHolidayEvent;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    result := FForm.Calendar.OnDetermineHoliday
  else
    Result := FOnDetermineHoliday;
end;

procedure TElDateTimePicker.SetOnDetermineHoliday(Value: TElHolidayEvent);
begin
  FOnDetermineHoliday := Value;
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.OnDetermineHoliday := value;
end;

function TElDateTimePicker.GetCalendarHolidayColor: TColor;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    result := FForm.Calendar.HolidayColor
  else
    Result := FCalendarHolidayColor;
end;

procedure TElDateTimePicker.SetCalendarHolidayColor(Value: TColor);
begin
  FCalendarHolidayColor := Value;
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.HolidayColor := value;
end;

procedure TElDateTimePicker.AdvancePosition;
var i    : integer;
    Part : PDTFPart;
    b    : boolean;
begin
  b := false;
  for i := FCurPart + 1 to DTFParts.Count - 1 do
  begin
    Part := PDTFPart(DTFParts[i]);
    if (Part.DPart in [0, 1, 2, 3, 4, 6, 7, 8, 11]) then
    begin
      FCurPart := i;
      FDI := '';
      UpdateText;
      InvalidateEdit;
      b := true;
      break;
    end;
  end;
  if not b and (ShowCheckBox) then
  begin
    FCurPart := -1;
    InvalidateEdit;
  end;
end;

procedure TElDateTimePicker.SetFocusedSelectColor(newValue: TColor);
begin
  if (FFocusedSelectColor <> newValue) then
  begin
    FFocusedSelectColor := newValue;
    if Assigned(FForm) and not FUseMonthCalendar then
    begin
      FForm.Calendar.FocusedSelectColor := newValue;
      FForm.YearSpin.FocusedSelectColor := newValue;
      FForm.MonthCombo.FocusedSelectColor := newValue;
    end;
    if (Focused or (not FHideSelection)) then Invalidate;
  end;  {if}
end;

procedure TElDateTimePicker.SetFocusedSelectTextColor(newValue: TColor);
begin
  if (FFocusedSelectTextColor <> newValue) then
  begin
    FFocusedSelectTextColor := newValue;
    if Assigned(FForm) and not FUseMonthCalendar then
    begin
      FForm.Calendar.FocusedSelectTextColor := newValue;
      FForm.YearSpin.FocusedSelectTextColor := newValue;
      FForm.MonthCombo.FocusedSelectTextColor := newValue;
    end;
    if (Focused or (not FHideSelection)) then Invalidate;
  end;  {if}
end;

procedure TElDateTimePicker.SetHideSelectColor(newValue: TColor);
begin
  if (FHideSelectColor <> newValue) then
  begin
    FHideSelectColor := newValue;
    if Assigned(FForm) and not FUseMonthCalendar then
    begin
      FForm.Calendar.HideSelectColor := newValue;
      FForm.YearSpin.HideSelectColor := newValue;
      FForm.MonthCombo.HideSelectColor := newValue;
    end;
    if not Focused and not FHideSelection then Invalidate;
  end;  {if}
end;

procedure TElDateTimePicker.SetHideSelectTextColor(newValue: TColor);
begin
  if (FHideSelectTextColor <> newValue) then
  begin
    FHideSelectTextColor := newValue;
    if Assigned(FForm) and not FUseMonthCalendar then
    begin
      FForm.Calendar.HideSelectTextColor := newValue;
      FForm.YearSpin.HideSelectTextColor := newValue;
      FForm.MonthCombo.HideSelectTextColor := newValue;
    end;
    if not Focused and not FHideSelection then Invalidate;
  end;  {if}
end;

procedure TElDateTimePicker.SetHideSelection(Value: Boolean);
begin
  if FHideSelection <> Value then
  begin
    FHideSelection := Value;
    if Assigned(FForm) and not FUseMonthCalendar then
    begin
      FForm.Calendar.HideSelection := value;
      FForm.YearSpin.HideSelection := value;
      FForm.MonthCombo.HideSelection := value;
    end;
    if not Focused then Invalidate;
  end;
end;

procedure TElDateTimePicker.SetHighlightAlphaLevel(Value: Integer);
begin
  if FHighlightAlphaLevel <> Value then
  begin
    FHighlightAlphaLevel := Value;
    if Assigned(FForm) and not FUseMonthCalendar then
    begin
      FForm.Calendar.HighlightAlphaLevel := value;
      FForm.YearSpin.HighlightAlphaLevel := value;
      FForm.MonthCombo.HighlightAlphaLevel := value;
    end;
  end;
  if Focused or not HideSelection then
    Invalidate;
end;

procedure TElDateTimePicker.SetButtonColor(Value: TColor);
begin
  if FButtonColor <> Value then
  begin
    FButtonColor := Value;
    FButton.Color := Value;
    FCalButton.Color := Value;
  end;
end;

procedure TElDateTimePicker.SetButtonShowBorder(Value: Boolean);
begin
  if FButtonShowBorder <> Value then
  begin
    FButtonShowBorder := Value;
    FButton.ShowBorder := Value;
    FCalButton.ShowBorder := Value;
  end;
end;

procedure TElDateTimePicker.SetLinkedControlPosition(Value: TElLinkCtlPos);
begin
  if FLinkedControlPosition <> Value then
  begin
    FLinkedControlPosition := Value;
    UpdateLinkedControl;
  end;
end;

procedure TElDateTimePicker.SetLinkedControl(Value: TControl);
begin
  if (FLinkedControl <> Value) and (Value <> Self) then
  begin
    if FLinkedControl <> nil then
      if not (csDestroying in FLinkedControl.ComponentState) then
        FLinkedControl.RemoveFreeNotification(Self);
    FLinkedControl := Value;
    if FLinkedControl <> nil then
      FLinkedControl.FreeNotification(Self);
    UpdateLinkedControl;
  end;
end;

procedure TElDateTimePicker.SetLinkedControlSpacing(Value: Integer);
begin
  if FLinkedControlSpacing <> Value then
  begin
    FLinkedControlSpacing := Value;
    UpdateLinkedControl;
  end;
end;

procedure TElDateTimePicker.UpdateLinkedControl;
begin
  if FLinkedControl <> nil then
  begin
    case FLinkedControlPosition of
      lcpLeftTop:
        FLinkedControl.SetBounds(Left - FLinkedControl.Width - FLinkedControlSpacing, Top, FLinkedControl.Width, FLinkedControl.Height);
      lcpLeftBottom:
        FLinkedControl.SetBounds(Left - FLinkedControl.Width - FLinkedControlSpacing, Top + Height - FLinkedControl.Height, FLinkedControl.Width, FLinkedControl.Height);
      lcpLeftCenter:
        FLinkedControl.SetBounds(Left - FLinkedControl.Width - FLinkedControlSpacing, Top + (Height - FLinkedControl.Height) div 2, FLinkedControl.Width, FLinkedControl.Height);
      lcpTopLeft:
        FLinkedControl.SetBounds(Left, Top - FLinkedControl.Height - FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpTopRight:
        FLinkedControl.SetBounds(Left + Width - FLinkedControl.Width, Top - FLinkedControl.Height - FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpTopCenter:
        FLinkedControl.SetBounds(Left + (Width - FLinkedControl.Width) div 2, Top - FLinkedControl.Height - FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpRightTop:
        FLinkedControl.SetBounds(Left + Width + FLinkedControlSpacing, Top, FLinkedControl.Width, FLinkedControl.Height);
      lcpRightBottom:
        FLinkedControl.SetBounds(Left + Width + FLinkedControlSpacing, Top + Height - FLinkedControl.Height, FLinkedControl.Width, FLinkedControl.Height);
      lcpRightCenter:
        FLinkedControl.SetBounds(Left + Width + FLinkedControlSpacing, Top + (Height - FLinkedControl.Height) div 2, FLinkedControl.Width, FLinkedControl.Height);
      lcpBottomLeft:
        FLinkedControl.SetBounds(Left, Top + Height + FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpBottomRight:
        FLinkedControl.SetBounds(Left + Width - FLinkedControl.Width, Top + Height + FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpBottomCenter:
        FLinkedControl.SetBounds(Left + (Width - FLinkedControl.Width) div 2, Top + Height + FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
    end;
  end;
end;

procedure TElDateTimePicker.SetDisplayReadOnlyOptions(const Value: TElDisplayOptions);
begin
  FDisplayReadOnlyOptions.Assign(Value);
end;

function TElDateTimePicker.GetBkColor: TColor;
begin
  if UseDisabledColors and (not Enabled) then
    result := DisabledColor
  else
    if (FDisplayReadOnlyOptions.Enabled) and (ReadOnly) then
      Result := FDisplayReadOnlyOptions.BkColor
    else
      Result := Color;
end;

function TElDateTimePicker.GetTextColor: TColor;
begin
  if IsThemed then
  begin
    if not Enabled then
      Result := GetSysColor(COLOR_GRAYTEXT)
    else
      if (ShowCheckBox and (not Checked)) then
        Result := clGrayText
      else
        if (FDisplayReadOnlyOptions.Enabled) and (ReadOnly) then
          Result := FDisplayReadOnlyOptions.TextColor
        else
        begin
          if Assigned(Font) and (Font.Color <> clNone) then
            Result := Font.Color
          else
            Result := GetSysColor(COLOR_WINDOWTEXT);
        end;
  end
  else
    if UseDisabledColors and (not Enabled) then
      result := DisabledFontColor
    else
      if (ShowCheckBox and (not Checked)) then
        Result := clGrayText
      else
        if (FDisplayReadOnlyOptions.Enabled) and (ReadOnly) then
          Result := FDisplayReadOnlyOptions.TextColor
        else
          Result := Font.Color;
end;

procedure TElDateTimePicker.CMMouseWheel(var Msg : TMessage);  { private }

var
  Dy : integer;
  sl : integer;
begin
  if LMDSIWindowsNTUp or LMDSIWindows98 then
    SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE)
  else
    sl := 3;
  if sl = 0 then sl := 1;
  (*sl := 1;  *)
  Dy := TWMMouseWheel(Msg).WheelDelta div (MOUSE_WHEEL_DELTA div sl);
  if Dy <> 0 then
  begin
    if not ReadOnly then
    begin
      if Unassigned then
        Unassigned := false
      else
        IncValue(Dy);
      Modified := true;
    end;
  end;
  Msg.Result := 1;
  inherited;
end;  { CMMouseWheel }

function TElDateTimePicker.GetCalendarGridHorzLines: Boolean;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    result := FForm.Calendar.GridHorzLines
  else
    result := FCalendarGridHorzLines;
end;

procedure TElDateTimePicker.SetCalendarGridHorzLines(Value: Boolean);
begin
  FCalendarGridHorzLines := value;
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.GridHorzLines := Value;
end;

function TElDateTimePicker.GetCalendarGridLineColor: TColor;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    result := FForm.Calendar.GridLineColor
  else
    Result := FCalendarGridLineColor;
end;

procedure TElDateTimePicker.SetCalendarGridLineColor(Value: TColor);
begin
  FCalendarGridLineColor := Value;
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.GridLineColor := Value;
end;

function TElDateTimePicker.GetCalendarCurrentDayBitmap: TBitmap;
begin
  Result := nil;
  if Assigned(FCalendarCurrentDayBitmap) then
    Result := FCalendarCurrentDayBitmap;
end;

function TElDateTimePicker.GetCalendarCurrentDayUseBitmap: Boolean;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    Result := FForm.Calendar.CurrentDayUseBitmap
  else
    Result := FCalendarCurrentDayUseBitmap;
end;

function TElDateTimePicker.GetCalendarLineBorderColor: TColor;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    Result := FForm.Calendar.LineBorderColor
  else
    Result := FCalendarLineBorderColor;
end;

procedure TElDateTimePicker.SetCalendarCurrentDayBitmap(Value: TBitmap);
begin
  FCalendarCurrentDayBitmap.Assign(Value);
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.CurrentDayBitmap.Assign(Value);
end;

procedure TElDateTimePicker.SetCalendarCurrentDayUseBitmap(Value: Boolean);
begin
  FCalendarCurrentDayUseBitmap := Value;
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.CurrentDayUseBitmap := Value;
end;

procedure TElDateTimePicker.SetCalendarLineBorderColor(Value: TColor);
begin
  FCalendarLineBorderColor := Value;
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.LineBorderColor := Value;
end;

procedure TElDateTimePicker.SetButtonFlat(Value: Boolean);
begin
  if FButtonFlat <> Value then
  begin
    FButtonFlat := Value;
    FButton.Flat := Value;
    FCalButton.Flat := Value;
  end;
end;

procedure TElDateTimePicker.SetButtonOldStyled(Value: Boolean);
begin
  if FButtonOldStyled <> Value then
  begin
    FButtonOldStyled := Value;
    FButton.OldStyled := Value;
    FCalButton.OldStyled := Value;
  end;
end;

procedure TElDateTimePicker.SetDisabledColor(Value: TColor);
begin
  if FDisabledColor <> Value then
  begin
    FDisabledColor := Value;
    if (not Enabled) and UseDisabledColors then
      InvalidateEdit;
  end;
end;

procedure TElDateTimePicker.SetDisabledFontColor(Value: TColor);
begin
  if FDisabledFontColor <> Value then
  begin
    FDisabledFontColor := Value;
    if (not Enabled) and UseDisabledColors then
      InvalidateEdit;
  end;
end;

procedure TElDateTimePicker.SetUseDisabledColors(Value: Boolean);
begin
  if FUseDisabledColors <> Value then
  begin
    FUseDisabledColors := Value;
    if not Enabled then
      InvalidateEdit;
  end;
end;

procedure TElDateTimePicker.PaintWindow(DC: HDC);
var
  MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  R : TRect;
  ARgn : HRGN;
begin
  MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
  MemDC := CreateCompatibleDC(DC);
  OldBitmap := SelectObject(MemDC, MemBitmap);
  try
    GetClipBox(DC, R);
    with R do
      ARgn := CreateRectRgn(Left, Top, Right, Bottom);
    SelectClipRgn(MemDC, ARgn);
    //InvalidateRect(MemDC, @R, false);
    //Perform(WM_ERASEBKGND, MemDC, MemDC);
    Canvas.Lock;
    try
      Canvas.Handle := MemDC;
      try
        TControlCanvas(Canvas).UpdateTextFlags;
        Paint;
      finally
        Canvas.Handle := 0;
      end;
    finally
      Canvas.Unlock;
    end;

    SelectClipRgn(MemDC, 0);
    //SelectClipRgn(DC, ARgn);
    with R do
      BitBlt(DC, Left, Top, Right, Bottom, MemDC, Left, Top, SRCCOPY);
    if ARgn <> 0 then
      DeleteObject(ARgn);
  finally
    SelectObject(MemDC, OldBitmap);
    DeleteDC(MemDC);
    DeleteObject(MemBitmap);
  end;
end;

procedure TElDateTimePicker.ReadChangeDisabledText(Reader : TReader);
begin
  UseDisabledColors := Reader.ReadBoolean;
end;

procedure TElDateTimePicker.DefineProperties(Filer : TFiler);
begin
  inherited;
  Filer.DefineProperty('ChangeDisabledText', ReadChangeDisabledText, nil, false);
end;

procedure TElDateTimePicker.SetButtonUseSystemWidth(Value: Boolean);
begin
  if FButtonUseSystemWidth <> Value then
  begin
    FButtonUseSystemWidth := Value;
    SetEditRect;
  end;
end;

function TElDateTimePicker.GetActiveButtonWidth: Integer;

begin
  if FButtonUseSystemWidth then
  Result := GetSystemMetrics(SM_CYVSCROLL)
  else
    Result := FBtnWidth;
end;

procedure TElDateTimePicker.DestroyWnd;
begin
  if DroppedDown then
    CloseUp(false);
  inherited;
end;

function TElDateTimePicker.GetCalendarOtherMonthDayColor: TColor;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    Result := FForm.Calendar.OtherMonthDayColor
  else
    result := FCalendarOtherMonthDayColor;
end;

procedure TElDateTimePicker.SetCalendarOtherMonthDayColor(Value: TColor);
begin
  FCalendarOtherMonthDayColor := Value;
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.OtherMonthDayColor := Value;
end;

function TElDateTimePicker.GetOnBeforeCellDraw: TBeforeCellDrawEvent;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    Result := FForm.Calendar.OnBeforeCellDraw
  else
    Result := FOnBeforeCellDraw;
end;

procedure TElDateTimePicker.SetOnBeforeCellDraw(Value: TBeforeCellDrawEvent);
begin
  FOnBeforeCellDraw := Value;
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.OnBeforeCellDraw := Value;
end;

function TElDateTimePicker.GetCalendarShowOtherMonthDays: Boolean;
begin
  if Assigned(FForm) and not FUseMonthCalendar then
    Result := FForm.Calendar.ShowOtherMonthDays
  else
    Result := FCalendarShowOtherMonthDays;
end;

procedure TElDateTimePicker.SetCalendarShowOtherMonthDays(Value: Boolean);
begin
  FCalendarShowOtherMonthDays := Value;
  if Assigned(FForm) and not FUseMonthCalendar then
    FForm.Calendar.ShowOtherMonthDays := Value;
end;

procedure TElDateTimePicker.SetCalendarShowClock(Value: Boolean);
begin
  if Assigned(FForm) then
    FForm.ShowClock := Value;
  FCalendarShowClock := Value;
end;

procedure TElDateTimePicker.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    if Flat then
      DrawFlatBorder;
    end;
end;

procedure TElDateTimePicker.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    if Flat then
      DrawFlatBorder;
    end;
end;

procedure TElDateTimePicker.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    if Flat then
      DrawFlatBorder;
    end;
end;

procedure TElDateTimePicker.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    if Flat then
      DrawFlatBorder;
    end;
end;

procedure TElDateTimePicker.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    if Flat then
      DrawFlatBorder;
    end;
end;

procedure TElDateTimePicker.WMSetRedraw(var Message: TWMSetRedraw);
begin
  inherited;
  if Message.Redraw = 1 then
  begin
    if ButtonVisible then
      FButton.Invalidate;
    if ShowPopupCalendar then
      FCalButton.Invalidate;
  end;
end;

{function TElDTPickButton.GetThemePartID: Integer;
begin
  result := CP_DROPDOWNBUTTON;
  ShowGlyph := not IsThemed;
end;}

function TElDTPickButton.GetDetails: TThemedElementDetails;
begin
  if not Enabled then
    result := ThemeServices.GetElementDetails(tcDropDownButtonDisabled)
  else
    if FState in [ebsDown, ebsExclusive] then
    result := ThemeServices.GetElementDetails(tcDropDownButtonPressed)
  else
    if MouseInControl then
    result := ThemeServices.GetElementDetails(tcDropDownButtonHot)
  else
    result := ThemeServices.GetElementDetails(tcDropDownButtonNormal);
end;

function TElDTPickButton.GetShowGlyph: Boolean;
begin
  if Parent <> nil then
    Result := (not TElDateTimePicker(Parent).IsThemed)
  else
    result := true;
end;

{ElCalendarForm}
destructor TElCalendarForm.Destroy;
begin
  FCustomCalendarNames.Free;
  inherited;
end;

procedure TElCalendarForm.WMActivate(var Msg : TWMActivate);
begin
  inherited;
  if Msg.Active = WA_INACTIVE then
  begin
    Clock.OnKick := nil;
    if Assigned(FOnDeactivate) then FOnDeactivate(Self);
  end
  else
  begin
    if ClockPanel.Visible then
      Clock.OnKick := ClockKick;
  end;
end;

procedure TElCalendarForm.SetShowTodayButton(const Value: Boolean);
begin
  FShowTodayButton := Value;
  Panel3.Visible := Value;
end;

procedure TElCalendarForm.SetNames;
var
  i : integer;
begin
  if not FUseMonthCalendar then
  begin
    MonthCombo.Items.Clear;
    for i := 1 to 12 do
      MonthCombo.Items.Add(FCustomCalendarNames.GetLongMonthNames(i));
  end;
end;

procedure TElCalendarForm.UpdateLabel;
begin
  if not FUseMonthCalendar then
  begin
    MonthCombo.ItemIndex := Calendar.Month - 1;
    YearSpin.Value := Calendar.Year;
    Clock.UseTimer := CalendarLiveClock;
    // Clock.UseTimer := ( abs(Now - Calendar.Date) < 0.6 );
  end;
  TimeDTP.Time := Clock.DT;
end;

procedure TElCalendarForm.PrevYearBtnClick(Sender : TObject);
begin
  Calendar.Year := Calendar.Year - 1;
  UpdateLabel;
end;

procedure TElCalendarForm.PrevMonBtnClick(Sender : TObject);
begin
  if Calendar.Month = 1 then
  begin
    Calendar.Month := 12;
    Calendar.Year := Calendar.Year - 1;
  end
  else
    Calendar.Month := Calendar.Month - 1;
  UpdateLabel;
end;

procedure TElCalendarForm.FormCreate(Sender : TObject);
var
  Bmp : TBitmap;
  wd: integer;
  bh: integer;
begin
  FCustomCalendarNames := TElCustomCalendarNames.Create;
  FFlatButtons := True;

  if FShowClock then
    wd := Canvas.TextWidth('Cancel') + 30
  else
    wd := Canvas.TextWidth('Cancel') + 10;
  bh := GetSystemMetrics(SM_CYSMCAPTION);

  Calendar := TElCalendar.Create(Self);
  Calendar.AutoSize := True;
  CalendarPanel := TElPanel.Create(Self);
  CalendarGB := TElGroupBox.Create(Self);

  with CalendarPanel do
  begin
    Left := 0;
    Top := 22;
    Parent := Self;
    Align := alClient;
    BevelOuter := bvNone;
    BevelKind := bkNone;
    BevelInner := bvNone;
    BorderWidth := 2;
    ParentColor := True;
  end;

  with CalendarGB do
  begin
    Left := 0;
    Top := 22;
    Parent := CalendarPanel;
    ParentColor := True;
    Align := alClient;
    Caption := CapCalendarGB;
  end;

  with Calendar do
  begin
    Left := 0;
    Top := 22;
    Width := 194;
    Height := 100;
    Parent := CalendarGB;
    Align := alClient;
    StartOfWeek := 0;
    WeekEndDays := [Sun, Sat];
    WeekEndColor := clRed;
    ShowPeriods := False;
    HolidayColor := clBlack;
    ActiveBorderType := fbtNone;
    InactiveBorderType := fbtNone;
    BorderStyle := bsNone;
    UserNavigation := False;
    LineColorDark := clWindow;
    TabOrder := 1;
    OnClick := CalendarClick;
    OnChange := CalendarChange;
    DockOrientation := doNoOrient;
    DoubleBuffered := False;
  end;

  Panel3 := TElPanel.Create(Self);
  TodayBtn := TElPopupButton.Create(Self);
  ClearBtn := TElPopupButton.Create(Self);
  OkBtn := TElPopupButton.Create(Self);
  CancelBtn := TElPopupButton.Create(Self);

  with Panel3 do
  begin
    Parent := Self;
    Left := 0;
    Top := 142;
    Width := 194;
    Height := 30;
    Align := alBottom;
    BevelOuter := bvNone;
    TabOrder := 1;
    ParentColor := True;
  end;

  with TodayBtn do
  begin
    Parent := Panel3;
    Left := 2;
    Top := 3;
    Width := wd;
    Height := 23;
    Cursor := crDefault;
    ImageIndex := 0;
    DrawDefaultFrame := False;
    PopupPlace := ppRight;
    LinkStyle := [fsUnderline];
    NumGlyphs := 1;
    Caption := TodayCap;
    TabOrder := 0;
    Flat := FFlatButtons;
    OnClick := TodayBtnClick;
    {$ifdef CAENDAR_USE_WINDOWS_CALENDAR}
    Visible := false;
    {$endif}
  end;

  with ClearBtn do
  begin
    Parent := Panel3;
    Left := wd + 4;
    Top := 3;
    Width := wd;
    Height := 23;
    Cursor := crDefault;
    ImageIndex := 0;
    DrawDefaultFrame := False;
    PopupPlace := ppRight;
    LinkStyle := [fsUnderline];
    NumGlyphs := 1;
    Caption := ClearCap;
    TabOrder := 1;
    Color := clBtnFace;
    Flat := FFlatButtons;
    ParentColor := False;
    OnClick := ClearBtnClick;
  end;

  ClockPanel := TElPanel.Create(Self);
  ClockGB := TElGroupBox.Create(Self);

  with ClockPanel do
  begin
    Parent := Self;
    Left := 0;
    Top := 143;
    Width := 120;
    Visible := FShowClock;
    Height := 134;
    Align := alRight;
    BevelOuter := bvNone;
    BevelKind := bkNone;
    BevelInner := bvNone;
    TabOrder := 2;
    BorderWidth := 2;
    ParentColor := True;
  end;

  with ClockGB do
  begin
    Parent := ClockPanel;
    Left := 0;
    Top := 143;
    Width := 110;
    Height := 124;
    Align := alClient;
    BevelOuter := TBevelCut(bvNone);
    BevelInner := TBevelCut(bvNone);
    TabOrder := 0;
    Caption := CapClockGB;
    ParentColor := True;
  end;

  PanelCl := TElPanel.Create(Self);

  with Panelcl do
  begin
    Parent := ClockGB;
    Height := 30;
    Width := 110;
    Align := alBottom;
    BevelOuter := bvNone;
    TabOrder := 2;
  end;

  TimeDTP := TElDateTimePicker.Create(Self);

  with TimeDTP do
  begin
    Parent := Panelcl;
    Format := edfLongTime;
    Alignment := taRightJustify;
    Flat := True;
    Width := 80;
    Left := 2;
    Top := 3;
    ButtonThinFrame := False;
    OnChange := TimeChange;
  end;

  Panelcl.Height := TimeDTP.Height + 6;
  Clock := TElTClock.Create(self);

  with Clock do
  begin
    Parent := ClockGb;
//    Height := Calendar.Height;
    Align := alClient;
    BevelOuter := bvNone;
    BevelInner := bvNone;
    ClockMode := cmAnalog;
    ClockStyle:= csWin95;
    TabOrder := 1;
//    Transparent := True;
    Color := Self.Color;
  end;

  with OkBtn do
  begin
    Parent := Panel3;
    if ClearBtn.Visible then
      Left := 2*wd + 6
    else
      Left := wd + 4;
    Top := 3;
    Width := wd;
    Flat := FFlatButtons;
    ModalResult := 6;
    LinkStyle := [fsUnderline];
    DrawDefaultFrame := False;
    PopupPlace := ppRight;
    Height := 23;
    Cursor := crDefault;
    ImageIndex := 0;
    NumGlyphs := 1;
    TabOrder := 1;
    Caption := OkCap;
    OnClick := OkBtnClick;
  end;

  with CancelBtn do
  begin
    Parent := Panel3;
    Left := 128;
    Top := 3;
    Width := 65;
    Height := 23;
    Cursor := crDefault;
    ImageIndex := 0;
    DrawDefaultFrame := False;
    PopupPlace := ppRight;
    Cancel := True;
    ModalResult := 2;
    LinkStyle := [fsUnderline];
    NumGlyphs := 1;
    Caption := CancelCap;
    TabOrder := 2;
    OnClick := CancelBtnClick;
    Flat := FFlatButtons;
  end;

  Panel1 := TElPanel.Create(Self);
  PrevMonBtn := TElPopupButton.Create(Self);
  PrevYearBtn := TElPopupButton.Create(Self);
  NextMonBtn := TElPopupButton.Create(Self);
  NextYearBtn := TElPopupButton.Create(Self);
  YearSpin := TElSpinEdit.Create(Self);
  MonthCombo := TElComboBox.Create(Self);

  with Panel1 do
  begin
    Parent := CalendarGB;
    Left := 0;
    Top := 0;
    Width := 194;
    Height := bh;
    Align := alTop;
    BevelOuter := bvNone;
    TabOrder := 0;
    ParentColor := True;
  end;

  Bmp := TBitmap.Create;
  Bmp.Width := 10;
  Bmp.Height := 8;
  Bmp.PixelFormat := pf1Bit;
  try
    with PrevMonBtn do
    begin
      Parent := Panel1;
      Left := 14;
      Top := 0;
      Width := 14;
      Height := bh;
      Hint := PrevMonthHint;
      ImageIndex := 0;
      Flat := true;
      LMDDrawArrow(Bmp.Canvas, eadLeft, Rect(0,0,10,8), clBtnText, true);
      Glyph.Assign(Bmp);
      ShowText := false;
      ShowGlyph := true;
      ShowFocus := False;
      TextDrawType := tdtNormal;
      Transparent := False;
      TabStop := False;
      TabOrder := 0;
      ThinFrame := true;
      Align := alLeft;
      OnClick := PrevMonBtnClick;
    end;

    with PrevYearBtn do
    begin
      Parent := Panel1;
      Left := 0;
      Top := 0;
      Width := 14;
      Height := bh;
      Hint := PrevYearHint;
      ImageIndex := 0;
      Flat := true;
      Bmp.Assign(nil);
      Bmp.Width := 10;
      Bmp.Height := 8;
      LMDDrawArrow(Bmp.Canvas, eadLeft, Rect(2,0,10,8), clBtnText, true);
      LMDDrawArrow(Bmp.Canvas, eadLeft, Rect(-2,0,6,8), clBtnText, true);
      Glyph := Bmp;
      ShowText := false;
      ShowGlyph := true;
      ShowFocus := False;
      TextDrawType := tdtNormal;
      Transparent := False;
      TabStop := False;
      TabOrder := 1;
      ThinFrame := true;
      Align := alLeft;
      OnClick := PrevYearBtnClick;
    end;

    with NextMonBtn do
    begin
      Parent := Panel1;
      Left := 166;
      Top := 0;
      Width := 14;
      Height := bh;
      Hint := NextMonthHint;
      ImageIndex := 0;
      Flat := true;
      Bmp.Assign(nil);
      Bmp.Width := 10;
      Bmp.Height := 8;
      LMDDrawArrow(Bmp.Canvas, eadRight, Rect(0,0,10,8), clBtnText, true);
      Bmp.Transparent := true;
      Glyph := Bmp;
      ShowText := false;
      ShowGlyph := true;
      ShowFocus := False;
      TextDrawType := tdtNormal;
      Transparent := False;
      TabStop := False;
      TabOrder := 2;
      ThinFrame := true;
      Align := alRight;
      OnClick := NextMonBtnClick;
    end;

    with NextYearBtn do
    begin
      Parent := Panel1;
      Left := 180;
      Top := 0;
      Width := 14;
      Height := bh;
      Hint := NextYearHint;
      ImageIndex := 0;
      Flat := true;
      Bmp.Assign(nil);
      Bmp.Width := 10;
      Bmp.Height := 8;
      LMDDrawArrow(Bmp.Canvas, eadRight, Rect(0,0,6,8), clBtnText, true);
      LMDDrawArrow(Bmp.Canvas, eadRight, Rect(4,0,10,8), clBtnText, true);
      Glyph := Bmp;
      ShowText := false;
      ShowGlyph := true;
      ShowFocus := False;
      TextDrawType := tdtNormal;
      Transparent := False;
      TabStop := False;
      TabOrder := 3;
      ThinFrame := true;
      Align := alRight;
      OnClick := NextYearBtnClick;
    end;
  finally
    Bmp.Free;
  end;

  with YearSpin do
  begin
    Parent := Panel1;
    Left := 109;
    Top := 0;
    Width := 57;
    Height := bh;
    Value := 1;
    MaxValue := 4636;
    MinValue := 1;
    Increment := 1;
    LargeIncrement := 10;
    Align := alRight;
    AutoSize := False;
    Ctl3D := True;
    Flat := True;
    Color := clBtnFace;
    LineBorderActiveColor := clBtnFace;
    LineBorderInactiveColor := clBtnFace;
    ButtonFlat := true;
    BorderStyle := bsNone;
    ParentCtl3D := False;
    ButtonThinFrame := true;
    TabOrder := 5;
    OnChange := YearSpinChange;
  end;

  with MonthCombo do
  begin
    Parent := Panel1;
    Left := 28;
    Top := 0;
    AutoSize := false;
    Width := 81;
    Height := bh;
    Style := csDropDownList;
    DropDownCount := 12;
    ParentFont := True;
    ListColor := clBtnFace;
    ItemHeight := 13;
    TabOrder := 4;
    AlignBottom := False;
    TopMargin := 0;
    OnChange := MonthComboChange;
    Align := alClient;
    Flat := True;
    ButtonFlat := true;
    ButtonThinFrame := true;
    Color := clBtnFace;
    ActiveBorderType := fbtNone;
    InactiveBorderType := fbtNone;
  end;

  SetNames;
end;

procedure TElCalendarForm.SetThemeMode;
begin
  inherited;
  if not FUseMonthCalendar then
  begin
    MonthCombo.TopMargin := -2;
    if AMode <> ttmNone then
    begin
      YearSpin.BorderStyle := bsSingle;
//      YearSpin.Color := clWindow;
//      MonthCombo.Color := clWindow;
    end
    else
    begin
      YearSpin.BorderStyle := bsNone;
//      YearSpin.Color := clBtnFace;
//      MonthCombo.Color := clBtnFace;
    end;
  end;
end;

procedure TElCalendarForm.SetFormThemed(Value: Boolean);
begin
  inherited;
  if LMDThemeServices.ThemesEnabled(LMDCtlXP[Value]) and Value then
  begin
    YearSpin.BorderStyle := bsSingle;
//    YearSpin.Color := clWindow;
//    MonthCombo.Color := clWindow;
  end
  else
  begin
    YearSpin.BorderStyle := bsNone;
//    YearSpin.Color := clBtnFace;
//    MonthCombo.Color := clBtnFace;
  end;
end;

procedure TElCalendarForm.MonthComboChange(Sender : TObject);
begin
  if (MonthCombo.ItemIndex >= 0) and (MonthCombo.ItemIndex < 12) then
    Calendar.Month := MonthCombo.ItemIndex + 1;
end;

procedure TElCalendarForm.NextMonBtnClick(Sender : TObject);
begin
  if Calendar.Month = 12 then
  begin
    Calendar.Month := 1;
    Calendar.Year := Calendar.Year + 1;
  end
  else
    Calendar.Month := Calendar.Month + 1;
  UpdateLabel;
end;

procedure TElCalendarForm.NextYearBtnClick(Sender : TObject);
begin
  Calendar.Year := Calendar.Year + 1;
  UpdateLabel;
end;

procedure TElCalendarForm.YearSpinChange(Sender : TObject);
var
  FSaveYear : integer;
begin
  FSaveYear := Calendar.Year;
  try
    Calendar.Year := Trunc(YearSpin.Value);
  except
    Calendar.Year := FSaveYear;
    raise Exception.Create('The entered year is invalid');
  end;
end;

procedure TElCalendarForm.FormShow(Sender : TObject);
var
  r: integer;
begin
  if FUseMonthCalendar then
  begin
    r := Left + Width;
    MCalendar.SetBounds(0, 0, 0, 0);
    CalcFormSizes;
    r := r - Width;
    Left := R;
  end;
  Panel3.Visible := FShowTodayButton;
  UpdateLabel;
end;

procedure TElCalendarForm.TodayBtnClick(Sender : TObject);
var
  Time : TSystemTime;
begin
  DateTimeToSystemTime(Now, Time);
  if FUseMonthCalendar then
    MCalendar.Date := Now
  else
    begin
      Calendar.Day := Time.wDay;
      Calendar.Month := Time.wMonth;
      Calendar.Year := Time.wYear;
      UpdateLabel;
    end;
  if ShowClock and (FTag = 1)  then
    Clock.UseTimer := CalendarLiveClock;//True;
end;


procedure TElCalendarForm.CalendarChange(Sender : TObject);
begin
  UpdateLabel;
end;

procedure TElCalendarForm.CalendarClick(Sender: TObject);
begin
  {
  if FUseMonthCalendar then
    Clock.UseTimer := (MCalendar.Date = Now)
  else
    Clock.UseTimer := (Calendar.Date = Now);
  }
  Clock.UseTimer := CalendarLiveClock;
  TriggerChangeEvent;
end;

constructor TElCalendarForm.CreateNew(AOwner : TComponent; Dummy: Integer);
begin
  inherited CreateNew(AOwner, Dummy);
  Width := 202;
  Height := 200;

  FShowTodayButton := true;
  Caption := CalendarCap;
  KeyPreview := True;
  OnCreate := FormCreate;
  OnClose := FormClose;
  OnShow := FormShow;
  Ftag := 0;
end;

procedure TElCalendarForm.ClearBtnClick(Sender : TObject);
begin
  if FUseMonthCalendar then
    MCalendar.Date := 0
  else
    Calendar.Date := 0;
  Unassigned := true;
  TriggerChangeEvent;
end;

procedure TElCalendarForm.CalcFormSizes;
var
  wd: integer;
  hpanel, hbutton, hbpanel, dtp, CalendarWidth : integer;
  tm : TLMDTextMetric;
  VertLineHeight : integer;
begin
  TimeDTP.FModified := True;
  LMDGetTextMetrics(Canvas.Handle, tm);

  if not FUseMonthCalendar and (goVertLine in THackCalendar(Calendar).Options) then
    VertLineHeight := THackCalendar(Calendar).GridLineWidth
  else
    VertLineHeight := 0;
  hbpanel := tm.tmHeight + 16;
  hpanel := tm.tmHeight + 13;
  hbutton := tm.tmHeight + 10;
  wd := GetSystemMetrics(SM_CXVSCROLL);
  dtp := Canvas.TextWidth(TimeToStr(TimeDTP.time)) + 2*GetSystemMetrics(SM_CXVSCROLL) + 12;
  if FUseMonthCalendar then
  begin
    CalendarWidth := MCalendar.Width
  end
  else
  begin
  Calendar.AutoSize := True;
  THackCalendar(Calendar).CalcSizes;
    //  THackCalendar(Calendar).DefaultColWidth := tm.tmAveCharWidth * 5;
  //  THackCalendar(Calendar).DefaultRowHeight := tm.tmHeight + 8;
  //  CalendarWidth := THackCalendar(Calendar).ColCount * (tm.tmAveCharWidth * 5 + VertLineHeight);
//    CalendarWidth := Calendar.GetEffectiveWidth;
    CalendarWidth := max(Calendar.GetEffectiveWidth, 8 * wd + Canvas.TextWidth('8888february')+ 4);
  end;
  if ShowClock then
    Width := CalendarWidth + 8 + dtp
  else
    Width := CalendarWidth + 8;
  if FUseMonthCalendar then
    Height := MCalendar.Height + 12 + hbpanel
  else
    Height := THackCalendar(Calendar).RowCount * (tm.tmHeight + 8 + VertLineHeight) + hbpanel + hpanel + 4;
    //  Panel2.Height := hbpanel;
  Panel3.Height := hbpanel;
  TodayBtn.Height := hbutton;
  ClearBtn.Height := hbutton;
  CancelBtn.Height := hbutton;
  OkBtn.Height := hbutton;
  with ClockPanel do
  begin
    Width := dtp;
    Height := CalendarPanel.Height;
  end;
  Panelcl.Height := hbpanel;
  with TimeDTP do
  begin
    Height := hbutton;
    Width := dtp - 12;
  end;
  if not FUseMonthCalendar then
  begin
    NextMonBtn.Width := wd;
    NextYearBtn.Width := wd;
    YearSpin.Width := Canvas.TextWidth('8888 ') + GetSystemMetrics(SM_CXVSCROLL)+4;
    PrevMonBtn.Width := wd;
    PrevYearBtn.Width := wd;
    MonthCombo.Height := Panel1.Height;
    YearSpin.Left := MonthCombo.Left + MonthCombo.Width;
    NextMonBtn.Left := YearSpin.Left + YearSpin.Width;
    NextYearBtn.Left := NextMonBtn.Left + NextMonBtn.Width;
    Panel1.Height :=  tm.tmHeight + tm.tmHeight div 2;
  end;
  TimeDTP.FModified := False;
  Constraints.MinHeight := Height;
  Constraints.MinWidth := Width;
end;

procedure TElCalendarForm.RangeButtons;
var
  wd: integer;
  s: TLMDString;
begin
  s := TodayCap;
  if Length(s) < Length(OkCap) then
    s := OkCap;
  if Length(s) < Length(CancelCap) then
    s := CancelCap;
  if FShowClock then
    wd := Canvas.TextWidth(s) + 30
  else
    wd := Canvas.TextWidth(s) + 10;

  if wd*3 > Width then
  begin
    s := OkCap;
    if Length(s) < Length(CancelCap) then
      s := CancelCap;
    wd := Canvas.TextWidth(s) + 10;
    TodayBtn.Width := max(wd, Width - 2*wd - 18);
  end
  else
    TodayBtn.Width := wd;
  ClearBtn.Width := wd;
  OkBtn.Width := wd;
  CancelBtn.Width := wd;
  TodayBtn.Left := 4;
  ClearBtn.Left := wd + 6;
  with CancelBtn do
  begin
    Left := Panel3.Width - CancelBtn.Width - 4;
//    if FShowClock then
//    begin
//      Left := CancelBtn.Left + ClockPanel.Width;
//    end;
  end;
  OkBtn.Left := CancelBtn.Left - 4 - OkBtn.Width;
end;

procedure TElCalendarForm.SetFlatButtons(const Value: Boolean);
begin
  FFlatButtons := Value;
  TodayBtn.Flat := Value;
  OkBtn.Flat := Value;
  CancelBtn.Flat := Value;
  ClearBtn.Flat := Value;
end;

procedure TElCalendarForm.SetShowClock(const Value: Boolean);
begin
  FShowClock := Value;
  if (Value) and (not ClockPanel.Visible) then
    Width := Width + ClockPanel.Width;
  if (not Value) and (ClockPanel.Visible) then
    Width := Width - ClockPanel.Width;
  ClockPanel.Visible := Value;
end;

procedure TElTClock.Kick;
begin
  inherited;
  if Assigned(FOnKick) then FOnKick(Self);
end;

{ TElTClock }

procedure TElCalendarForm.ClockKick(Sender: TObject);
begin
  TimeDTP.Time := Clock.FDT;
end;

procedure TElCalendarForm.TimeChange(Sender: TObject);
begin
  Clock.UseTimer := CalendarLiveClock;
  Clock.FDT := TimeDTP.DateTime;
  Clock.Refresh;
end;

procedure TElDateTimePicker.DisplayOptionsChange(Sender: TObject);
begin
  FIgnoreReadOnlyState := not FDisplayReadOnlyOptions.Enabled;
  Invalidate;
end;

procedure TElDateTimePicker.FontChanged(Sender: TObject);
begin
  if Assigned(FOldFontChanged) then
    FOldFontChanged(Sender);
  if AutoSize then
    AdjustHeight;
  if HandleAllocated then
  begin
    UpdateText;
    Invalidate;
  end;
end;

procedure TElDateTimePicker.CalcFormSizes;
begin
  if FShowPopupCalendar then
    FForm.CalcFormSizes;
end;

procedure TElDateTimePicker.ChangeToNearValid(var ST: TSystemTime;
  Param: Integer);
var
  mdt: TSystemTime;
begin
  DateTimeToSystemTime(FMaxDate, mdt);

  if LMDInRange(Param, 0, 2) then  //year
  begin
    while (SystemTimeToDateTime(ST) < FMinDate) and (ST.wYear < mdt.wYear) do
    begin
      if (ST.wYear < mdt.wYear) then
        ST.wYear := ST.wYear + 1;
    end;
  end;
  if Param = 3 then // month
  begin
    while (SystemTimeToDateTime(ST) < FMinDate) and (ST.wYear < mdt.wYear) do
    begin
      if (ST.wMonth < 11) then
      begin
        ST.wMonth := ST.wMonth + 1;
        if (St.wDay > LMDDaysPerMonth(ST.wYear, ST.wMonth)) then
          St.wMonth := St.wMonth + 1; // this safe because december has 31 day
      end
      else
        ChangeToNearValid(ST, 2);
    end;
  end;
  if Param = 4 then // day
  begin
    while (SystemTimeToDateTime(ST) < FMinDate) and (ST.wYear < mdt.wYear) do
    begin
      if (ST.wDay + 1 < LMDDaysPerMonth(ST.wYear, ST.wMonth)) then
        ST.wDay := ST.wDay + 1
      else
        ChangeToNearValid(ST, 3);
    end;
  end;
end;

procedure TElCalendarForm.SetUseMonthCalendar(const Value: Boolean);
var
  Bmp : TBitmap;
  bh: integer;
begin
  bh := GetSystemMetrics(SM_CYSMCAPTION);
  if FUseMonthCalendar <> Value then
  begin
    FUseMonthCalendar := Value;
    if Visible then
      Close;
    if Value then
    begin
      if Assigned(Calendar) then
      begin
        FreeAndNil(PrevMonBtn);
        FreeAndNil(PrevYearBtn);
        FreeAndNil(NextMonBtn);
        FreeAndNil(NextYearBtn);
        FreeAndNil(YearSpin);
        FreeAndNil(MonthCombo);
        FreeAndNil(Panel1);
        FreeAndNil(Calendar);
      end;
      MCalendar := TMonthCalendar.Create(Self);
      MCalendar.AutoSize := True;
      with MCalendar do
      begin
        Left := 0;
        Top := 22;
        Width := 194;
        Height := 100;
        Parent := CalendarGB;
        Align := alClient;
        BorderStyle := bsNone;
        TabOrder := 1;
        OnClick := CalendarClick;
        OnChange := CalendarChange;
        DockOrientation := doNoOrient;
        DoubleBuffered := False;
      end;
    end
    else
    begin
      if Assigned(MCalendar) then
      begin
        FreeAndNil(MCalendar);
      end;
      Panel1 := TElPanel.Create(Self);
      PrevMonBtn := TElPopupButton.Create(Self);
      PrevYearBtn := TElPopupButton.Create(Self);
      NextMonBtn := TElPopupButton.Create(Self);
      NextYearBtn := TElPopupButton.Create(Self);
      YearSpin := TElSpinEdit.Create(Self);
      MonthCombo := TElComboBox.Create(Self);
      with Panel1 do
      begin
        Parent := CalendarGB;
        Left := 0;
        Top := 0;
        Width := 194;
        Height := bh;
        Align := alTop;
        BevelOuter := bvNone;
        TabOrder := 0;
      end;
      Bmp := TBitmap.Create;
      Bmp.Width := 10;
      Bmp.Height := 8;
      Bmp.PixelFormat := pf1Bit;
      try
        with PrevMonBtn do
        begin
          Parent := Panel1;
          Left := 14;
          Top := 0;
          Width := 14;
          Height := bh;
          Hint := PrevMonthHint;
          ImageIndex := 0;
          Flat := true;
          LMDDrawArrow(Bmp.Canvas, eadLeft, Rect(0,0,10,8), clBtnText, true);
          Glyph.Assign(Bmp);
          ShowText := false;
          ShowGlyph := true;
          ShowFocus := False;
          TextDrawType := tdtNormal;
          Transparent := False;
          TabStop := False;
          TabOrder := 0;
          ThinFrame := true;
          Align := alLeft;
          OnClick := PrevMonBtnClick;
        end;
        with PrevYearBtn do
        begin
          Parent := Panel1;
          Left := 0;
          Top := 0;
          Width := 14;
          Height := bh;
          Hint := PrevYearHint;
          ImageIndex := 0;
          Flat := true;
          Bmp.Assign(nil);
          Bmp.Width := 10;
          Bmp.Height := 8;
          LMDDrawArrow(Bmp.Canvas, eadLeft, Rect(2,0,10,8), clBtnText, true);
          LMDDrawArrow(Bmp.Canvas, eadLeft, Rect(-2,0,6,8), clBtnText, true);
          Glyph := Bmp;
          ShowText := false;
          ShowGlyph := true;
          ShowFocus := False;
          TextDrawType := tdtNormal;
          Transparent := False;
          TabStop := False;
          TabOrder := 1;
          ThinFrame := true;
          Align := alLeft;
          OnClick := PrevYearBtnClick;
        end;
        with NextMonBtn do
        begin
          Parent := Panel1;
          Left := 166;
          Top := 0;
          Width := 14;
          Height := bh;
          Hint := NextMonthHint;
          ImageIndex := 0;
          Flat := true;
          Bmp.Assign(nil);
          Bmp.Width := 10;
          Bmp.Height := 8;
          LMDDrawArrow(Bmp.Canvas, eadRight, Rect(0,0,10,8), clBtnText, true);
          Bmp.Transparent := true;
          Glyph := Bmp;
          ShowText := false;
          ShowGlyph := true;
          ShowFocus := False;
          TextDrawType := tdtNormal;
          Transparent := False;
          TabStop := False;
          TabOrder := 2;
          ThinFrame := true;
          Align := alRight;
          OnClick := NextMonBtnClick;
        end;
        with NextYearBtn do
        begin
          Parent := Panel1;
          Left := 180;
          Top := 0;
          Width := 14;
          Height := bh;
          Hint := NextYearHint;
          ImageIndex := 0;
          Flat := true;
          Bmp.Assign(nil);
          Bmp.Width := 10;
          Bmp.Height := 8;
          LMDDrawArrow(Bmp.Canvas, eadRight, Rect(0,0,6,8), clBtnText, true);
          LMDDrawArrow(Bmp.Canvas, eadRight, Rect(4,0,10,8), clBtnText, true);
          Glyph := Bmp;
          ShowText := false;
          ShowGlyph := true;
          ShowFocus := False;
          TextDrawType := tdtNormal;
          Transparent := False;
          TabStop := False;
          TabOrder := 3;
          ThinFrame := true;
          Align := alRight;
          OnClick := NextYearBtnClick;
        end;
      finally
        Bmp.Free;
      end;
      with YearSpin do
      begin
        Parent := Panel1;
        Left := 109;
        Top := 0;
        Width := 57;
        Height := bh;
        Value := 1;
        MaxValue := 4636;
        MinValue := 1;
        Increment := 1;
        LargeIncrement := 10;
        Align := alRight;
        AutoSize := False;
        Ctl3D := True;
        Flat := True;
        Color := clBtnFace;
        //ButtonThinFrame := true;
        //InactiveBorderType := fbtColorLineBorder;
        //ActiveBorderType := fbtColorLineBorder;
        LineBorderActiveColor := clBtnFace;
        LineBorderInactiveColor := clBtnFace;
        ButtonFlat := true;
    //    BorderStyle := bsNone;
        ParentCtl3D := False;
        ButtonThinFrame := true;
        TabOrder := 5;
        OnChange := YearSpinChange;
      end;
      with MonthCombo do
      begin
        Parent := Panel1;
        Left := 28;
        Top := 0;
        AutoSize := false;
        Width := 81;
        Height := bh;
        Style := csDropDownList;
        DropDownCount := 12;
        ParentFont := True;
    //    Font := Panel1.Font;
        // Dropdownlist should use this color
        ListColor := clBtnFace;
        ItemHeight := 13;
        TabOrder := 4;
        AlignBottom := False;
        TopMargin := -2;
        OnChange := MonthComboChange;
        Align := alClient;
        Flat := True;
        ButtonFlat := true;
        ButtonThinFrame := true;
        Color := clBtnFace;
        ActiveBorderType := fbtNone;
        InactiveBorderType := fbtNone;
        //BorderStyle := bsSingle;
      end;
      Calendar := TElCalendar.Create(Self);
     Calendar.AutoSize := True;
     with Calendar do
      begin
        Left := 0;
        Top := 22;
        Width := 194;
        Height := 100;
        Parent := CalendarGB;
        Align := alClient;
        StartOfWeek := 0;
        WeekEndDays := [Sun, Sat];
        WeekEndColor := clRed;
        ShowPeriods := False;
        HolidayColor := clBlack;
        ActiveBorderType := fbtNone;
        InactiveBorderType := fbtNone;
        BorderStyle := bsNone;
        UserNavigation := False;
        LineColorDark := clWindow;

        TabOrder := 1;
        OnClick := CalendarClick;
        OnChange := CalendarChange;

        DockOrientation := doNoOrient;
        DoubleBuffered := False;
      end;
    end;
  end;
end;

function TElDateTimePicker.GetCalendarStyle: TElCalendarStyle;
begin
  if FUseMonthCalendar then
    Result := csMonthCalendar
  else
    Result := csElCalendar;
end;

procedure TElDateTimePicker.SetCalendarStyle(
  const Value: TElCalendarStyle);
begin
  case Value of
    csMonthCalendar: FUseMonthCalendar := True;
  else
    FUseMonthCalendar := False;
  end;
end;

procedure TElCalendarForm.WMNotify(var Msg: TWMNotify);
begin
  if FUseMonthCalendar then
    if (Msg.NMHdr.code = MCN_SELECT) then
    begin
      TriggerChangeEvent;
    end;
  inherited;
end;

procedure TElDateTimePicker.SetCustomCalendarNames(const Value: TElCustomCalendarNames);
begin
  FCustomCalendarNames.Assign(Value);
end;

function TElDateTimePicker.GetCalendarLiveClock(): Boolean;
begin
  Result := False;
  if Assigned(FForm) then
      Result := FForm.CalendarLiveClock;
end;

procedure TElDateTimePicker.SetCalendarLiveClock(AValue: Boolean);
begin
  if Assigned(FForm) then
//    if Assigned(FForm.Clock) then
      FForm.CalendarLiveClock := AValue ;//Clock.UseTimer := AValue
end;

procedure TElCalendarForm.SetCustomCalendarNames(const Value: TElCustomCalendarNames);
begin
  FCustomCalendarNames.Assign(Value);
end;

procedure TElDateTimePicker.NamesChanged(Sender: TObject);
begin
  if HandleAllocated then
    invalidate;
end;

function TElDateTimePicker.GetThemedElementDetails(): TThemedElementDetails;
begin
  Result.Element := GetThemedElement();
  Result.Part := EP_EDITBORDER_NOSCROLL;
  Result.State := ETS_NORMAL;
  if not Enabled then
    Result.State := ETS_DISABLED
  else
  if FFocused then
    Result.State := ETS_SELECTED
  else
  if FMouseOver then
    Result.State := ETS_HOT;
end;

initialization
  NextYearHint := SLMDHintNextYear;
  NextMonthHint := SLMDHintNextMonth;
  PrevYearHint := SLMDHintPrevYear;
  PrevMonthHint := SLMDHintPrevMonth;
  ClearCap := SLMDCapClear;
  TodayCap := SLMDCapToday;
  OkCap := SLMDCapOk;
  CancelCap := SLMDCapCancel;
  CalendarCap := SLMDCapCalendar;
  CapCalendarGB := SLMDCapCalendarGB;
  CapClockGB := SLMDCapClockGB;

finalization

end.
