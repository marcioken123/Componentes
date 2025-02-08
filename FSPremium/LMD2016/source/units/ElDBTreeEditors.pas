unit ElDBTreeEditors;
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

ElDBTreeEditors unit
--------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

12 February, 2008 (EK)
 - Validation support added;

###############################################################################}

interface

uses
  LMDTypes, Windows, Messages, StdCtrls, Controls, Forms, Dialogs, Graphics, SysUtils, Classes,
  db,
  dbctrls,

  Types,

  ElStyleMan,
  ElTree,
  ElHeader,

  ElEdits,
  ElDBSpin,
  ElDBCurrEdit,
  LMDUnicodeStrings,
  {$ifndef NO_CALC_IN_CURREDIT}
  ElCalc,
  {$endif}
  ElDBXTree,
  ElDBTree,
  ElDBCtrls,
  ElDBDTPick,
  ElCombos,
  ElTreeCombo,
  ElDBWideLookupComboGrid,
  ElDBBoxes,
  ElCurrEdit,
  ElDBWideLookupControls,
  LMDElDBConst, LMDUnicode,
  LMDThemes,
  Themes,
  Math,
  ElDBLookupCtrls,
//  ElFrmPers,
  ElVCLUtils,
  LMDGraph,
  LMDUtils,
  ElDTPick,
  LMDProcs,
  LMDVldBase;

type

  THackTreeCombo = class (TCustomElTreeCombo)
  end;

  THackEditorCombo = class (TCustomElComboBox)
  end;

  THackElTree = class (TElDBTree)
    property ExplorerEditMode;
  end;

  THackElDBEdit = class (TElDBEdit)
  end;

  {$IFDEF LMD_UNICODE}
  THackElWideDBEdit = class (TElWideDBEdit)
  end;
  {$ENDIF}

  THackDBInplaceCurrencyEdit = class (TElDBCurrencyEdit)
  end;

  THackControl = class(TControl)
  end;

  THackDBComboBox = class(TElDBComboBox)
  protected
    procedure ComboWndProc(var Message: TMessage; ComboWnd: THandle; ComboProc: Pointer); override;
  end;

  TElDBTreeLookupComboGridEdit = class(TElDBTreeInplaceEditor)
  private
    FAccepted: Boolean;
    FOldVal: variant;
//    FIgnoreFocus: Boolean;
    SaveWndProc: TWndMethod;
    FWidth: integer;
  {$ifdef LMD_UNICODE}
    procedure SetStressShortCut(Value: TShortCut);
    function GetStressShortCut: TShortCut;
  {$endif}
    procedure EditorWndProc(var Message : TMessage);
    procedure SetShowGripper(Value: Boolean);
    function GetShowGripper: Boolean;
    function GetListFieldName: string;
    procedure SetListFieldName(const Value: string);
    procedure SetNullValueKey(Value : TShortCut);
    function GetNullValueKey:TShortCut;
    function GetValidationMsgString: string;
    function GetValidator: TLMDValidationEntity;
    procedure SetValidationMsgString(const Value: string);
    procedure SetValidator(const Value: TLMDValidationEntity);
    function GetOnValidationError: TLMDValidationErrorEvent;
    procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
  protected
    function GetEditor: TElWideDBLookupComboGrid;
    procedure SetEditorParent; override;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted : boolean); override;
    function GetVisible: Boolean; override;
    procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
        boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
    function GetStyleManager: TElStyleManager;
    function GetStyleName: string;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
 public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    procedure StartOperation; override;
    procedure CompleteOperation(Accepted: boolean); override;

    property Editor: TElWideDBLookupComboGrid read GetEditor;
  published
    property StyleManager: TElStyleManager read GetStyleManager write
        SetStyleManager;
    property StyleName: string read GetStyleName write SetStyleName;
    property Font: TFont read FFont write SetFont stored True;
    property ShowGripper: Boolean read GetShowGripper write SetShowGripper default false;
    property ListField: string read GetListFieldName write SetListFieldName;
  property NullValueKey:TShortCut read GetNullValueKey write SetNullValueKey default 0;
  {$ifdef LMD_UNICODE}
    property StressShortCut: TShortCut read GetStressShortCut write SetStressShortCut default 0;
  {$endif}
    property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
  end;

  TElDBTreeLookupComboBoxEdit = class(TElDBTreeInplaceEditor)
  private
    FAccepted: Boolean;
    FOldVal: variant;
    SaveWndProc: TWndMethod;
  {$ifdef LMD_UNICODE}
    procedure SetStressShortCut(Value: TShortCut);
    function GetStressShortCut: TShortCut;
  {$endif}
    procedure EditorWndProc(var Message : TMessage);
{$IFDEF LMD_UNICODE}
    procedure SetShowGripper(Value: Boolean);
    function GetShowGripper: Boolean;
    procedure SetNullValueKey(Value : TShortCut);
    function GetNullValueKey:TShortCut;
    function GetValidationMsgString: string;
    function GetValidator: TLMDValidationEntity;
    procedure SetValidationMsgString(const Value: string);
    procedure SetValidator(const Value: TLMDValidationEntity);
    function GetOnValidationError: TLMDValidationErrorEvent;
    procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
{$endif}
  protected
    FInitiallyDropped : boolean;

{$IFDEF LMD_UNICODE}
    function GetEditor: TElWideDBLookupComboBox;
{$else}
    function GetEditor: TElDBLookupComboBox;
{$endif}
    procedure SetEditorParent; override;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted : boolean); override;
    function GetVisible: Boolean; override;
    procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
        boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
    {$IFDEF LMD_UNICODE}
    function GetStyleManager: TElStyleManager;
    function GetStyleName: string;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    {$endif}
 public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    procedure StartOperation; override;
    procedure CompleteOperation(Accepted: boolean); override;

{$IFDEF LMD_UNICODE}
    property Editor: TElWideDBLookupComboBox read GetEditor;
{$else}
    property Editor: TElDBLookupComboBox read GetEditor;
{$endif}
  published
{$IFDEF LMD_UNICODE}
  property NullValueKey:TShortCut read GetNullValueKey write SetNullValueKey default 0;
  {$endif}
    property InitiallyDropped : boolean read FInitiallyDropped write FInitiallyDropped default false;
    property Font: TFont read FFont write SetFont stored True;
{$IFDEF LMD_UNICODE}
    property StyleManager: TElStyleManager read GetStyleManager write
        SetStyleManager;
    property StyleName: string read GetStyleName write SetStyleName;
    property ShowGripper: Boolean read GetShowGripper write SetShowGripper default false;
    property StressShortCut: TShortCut read GetStressShortCut write SetStressShortCut default 0;
    property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
{$endif}
  end;

  {$IFDEF LMD_UNICODE}
  TElDBTreeWideStringEdit = class (TElDBTreeInplaceEditor)
  private
    FAccepted: Boolean;
    SaveWndProc: TWndMethod;
    procedure EditorWndProc(var Message: TMessage);
    function GetUnicodeMode : TElDBUnicodeMode;
    procedure SetUnicodeMode(Value: TElDBUnicodeMode);
    procedure SetStressShortCut(Value: TShortCut);
    function GetStressShortCut: TShortCut;
    function GetValidationMsgString: string;
    function GetValidator: TLMDValidationEntity;
    procedure SetValidationMsgString(const Value: string);
    procedure SetValidator(const Value: TLMDValidationEntity);
    function GetOnValidationError: TLMDValidationErrorEvent;
    procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
  protected
    function GetEditor: TElWideDBEdit;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted: boolean); override;
    function GetVisible: Boolean; override;
    procedure SetEditorParent; override;
    procedure TriggerAfterOperation(var Accepted: boolean; var
            DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure CompleteOperation(Accepted: boolean); override;
    procedure StartOperation; override;

    property Editor: TElWideDBEdit read GetEditor;
  published
    property Font: TFont read FFont write SetFont stored True;
    property UnicodeMode: TElDBUnicodeMode read GetUnicodeMode write SetUnicodeMode default umFieldType;
    property StressShortCut: TShortCut read GetStressShortCut write SetStressShortCut default 0;
    property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
  end;
  {$ENDIF}

  TElDBTreeSpinEdit = class (TElDBTreeInplaceEditor)
  private
    FAccepted1: Boolean;
    SaveWndProc: TWndMethod;
    procedure EditorWndProc(var Message: TMessage);
    procedure SetMaxValue(Value: Integer);
    function GetMaxValue: Integer;
    procedure SetMinValue(Value: Integer);
    function GetMinValue: Integer;
    function GetValidationMsgString: string;
    function GetValidator: TLMDValidationEntity;
    procedure SetValidationMsgString(const Value: string);
    procedure SetValidator(const Value: TLMDValidationEntity);
    function GetOnValidationError: TLMDValidationErrorEvent;
    procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
  protected
    function GetEditor: TElDBSpinEdit;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted: boolean); override;
    function GetVisible: Boolean; override;
    procedure SetEditorParent; override;
    procedure TriggerAfterOperation(var Accepted: boolean; var
            DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
    function GetStyleManager: TElStyleManager;
    function GetStyleName: string;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure CompleteOperation(Accepted: boolean); override;
    procedure StartOperation; override;

    property Editor: TElDBSpinEdit read GetEditor;
  published
    property Font: TFont read FFont write SetFont stored True;
    property StyleManager: TElStyleManager read GetStyleManager write
        SetStyleManager;
    property StyleName: string read GetStyleName write SetStyleName;
    property MaxValue: Integer read GetMaxValue write SetMaxValue default 10000000;
    property MinValue: Integer read GetMinValue write SetMinValue default -10000000;
    property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
  end;

  TElDBTreeFloatSpinEdit = class (TElDBTreeInplaceEditor)
  private
    FAccepted1: Boolean;
    SaveWndProc: TWndMethod;
    function IsStoreMax: boolean;
    function IsStoreMin: boolean;
    procedure EditorWndProc(var Message: TMessage);
    procedure SetMaxValue(Value: Double);
    function GetMaxValue: Double;
    procedure SetMinValue(Value: Double);
    function GetMinValue: Double;
    procedure SetDigits(Value: Integer);
    function GetDigits: Integer;
    function GetValidationMsgString: string;
    function GetValidator: TLMDValidationEntity;
    procedure SetValidationMsgString(const Value: string);
    procedure SetValidator(const Value: TLMDValidationEntity);
    function GetOnValidationError: TLMDValidationErrorEvent;
    procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
  protected
    function GetEditor: TElDBFloatSpinEdit;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted: boolean); override;
    function GetVisible: Boolean; override;
    procedure SetEditorParent; override;
    procedure TriggerAfterOperation(var Accepted: boolean; var
            DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
    function GetStyleManager: TElStyleManager;
    function GetStyleName: string;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure CompleteOperation(Accepted: boolean); override;
    procedure StartOperation; override;

    property Editor: TElDBFloatSpinEdit read GetEditor;
  published
    property Font: TFont read FFont write SetFont stored True;
    property StyleManager: TElStyleManager read GetStyleManager write
        SetStyleManager;
    property StyleName: string read GetStyleName write SetStyleName;
    property MaxValue: Double read GetMaxValue write SetMaxValue stored IsStoreMax;
    property MinValue: Double read GetMinValue write SetMinValue stored IsStoreMin;
    property Digits: Integer read GetDigits write SetDigits default 3;
    property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
  end;

  {$ifdef LMD_UNICODE}
  TElWideDBTEdit = class(TElWideDBEdit)
  protected
    procedure DataChange(Sender: TObject);override;
  end;
  {$endif}

  TElDBTreeEdit = class (TElDBTreeInplaceEditor)
  private
    FAccepted: Boolean;
    SaveWndProc: TWndMethod;
    procedure EditorWndProc(var Message: TMessage);
  {$ifdef LMD_UNICODE}
    procedure SetStressShortCut(Value: TShortCut);
    function GetStressShortCut: TShortCut;
  {$endif}
    function GetValidationMsgString: string;
    function GetValidator: TLMDValidationEntity;
    procedure SetValidationMsgString(const Value: string);
    procedure SetValidator(const Value: TLMDValidationEntity);
    function GetOnValidationError: TLMDValidationErrorEvent;
    procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
  protected
  {$ifdef LMD_UNICODE}
    function GetEditor: TElWideDBEdit;
  {$else}
    function GetEditor: TElDBEdit;
  {$endif}
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted: boolean); override;
    function GetVisible: Boolean; override;
    procedure SetEditorParent; override;
    procedure TriggerAfterOperation(var Accepted: boolean; var
            DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure CompleteOperation(Accepted: boolean); override;
    procedure StartOperation; override;

  {$ifdef LMD_UNICODE}
    property Editor: TElWideDBEdit read GetEditor;
  {$else}
    property Editor: TElDBEdit read GetEditor;
  {$endif}
  published
    property Font: TFont read FFont write SetFont stored True;
  {$ifdef LMD_UNICODE}
    property StressShortCut: TShortCut read GetStressShortCut write SetStressShortCut default 0;
  {$endif}
    property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
  end;

  TElDBTreeMemoEdit = class;

  TDBMemoForm = class(TForm)
  private
    FTreeMemoEdit: TElDBTreeMemoEdit;
    procedure WMMouseActivate(var Msg: TWMMouseActivate); message WM_MOUSEACTIVATE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMNCHitTest(var Msg : TWMNCHitTest); message WM_NCHITTEST;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMEnterSizeMove(var Message: TMessage); message WM_ENTERSIZEMOVE;
    procedure WMExitSizeMove(var Message: TMessage); message WM_EXITSIZEMOVE;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
  public
    constructor CreateNew(AOwner : TComponent; Dummy : integer =
        0);  override;
  end;

{$IFDEF LMD_UNICODE}
  TElInpDBMemo = class(TElWideDBMemo)
{$else}
  TElInpDBMemo = class(TElDBMemo)
{$endif}
  private
    FTreeMemoEdit: TElDBTreeMemoEdit;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
  protected
{$IFDEF LMD_UNICODE}
    procedure Paint; override;
{$endif}
  end;

  TElDBTreeMemoEdit = class(TElDBTreeInplaceEditor)
  private
    FAccepted: Boolean;
    FShowGripper: Boolean;
    FForm : TDBMemoForm;
    FIgnoreFocus: Boolean;
    procedure SetHeight(value: Integer);
    function GetHeight: Integer;
{$IFDEF LMD_UNICODE}
    function GetUnicodeMode : TElDBUnicodeMode;
    procedure SetUnicodeMode(Value: TElDBUnicodeMode);
    procedure SetStressShortCut(Value: TShortCut);
    function GetStressShortCut: TShortCut;
{$endif}
    procedure SetShowGripper(Value: Boolean);
    function GetValidationMsgString: string;
    function GetValidator: TLMDValidationEntity;
    procedure SetValidationMsgString(const Value: string);
    procedure SetValidator(const Value: TLMDValidationEntity);
    function GetOnValidationError: TLMDValidationErrorEvent;
    procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
  protected
{$IFDEF LMD_UNICODE}
    function GetEditor: TElWideDBMemo;
{$else}
    function GetEditor: TElDBMemo;
{$endif}
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted: boolean); override;
    function GetVisible: Boolean; override;
    procedure SetEditorParent; override;
    procedure TriggerAfterOperation(var Accepted: boolean; var
            DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
    {$IFDEF LMD_UNICODE}
    function GetStyleManager: TElStyleManager;
    function GetStyleName: string;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    {$endif}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure CompleteOperation(Accepted: boolean); override;
    procedure StartOperation; override;

{$IFDEF LMD_UNICODE}
    property Editor: TElWideDBMemo read GetEditor;
{$else}
    property Editor: TElDBMemo read GetEditor;
{$endif}
    published
    property Font: TFont read FFont write SetFont stored True;
    property Height: integer read GetHeight write SetHeight stored True default 89;
{$IFDEF LMD_UNICODE}
    property StressShortCut: TShortCut read GetStressShortCut write SetStressShortCut default 0;
    property StyleManager: TElStyleManager read GetStyleManager write
        SetStyleManager;
    property StyleName: string read GetStyleName write SetStyleName;
    property UnicodeMode: TElDBUnicodeMode read GetUnicodeMode write SetUnicodeMode default umFieldType;
{$endif}
    property ShowGripper: Boolean read FShowGripper write SetShowGripper default false;
    property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
  end;

  TElDBTreeCheckBoxEdit = class (TElDBTreeInplaceEditor)
  private
    FAccepted: Boolean;
    SaveWndProc: TWndMethod;
    procedure EditorWndProc(var Message: TMessage);
  protected
    function GetEditor: TElDBCheckBox;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted: boolean); override;
    function GetVisible: Boolean; override;
    procedure SetEditorParent; override;
    procedure TriggerAfterOperation(var Accepted: boolean; var
            DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure CompleteOperation(Accepted: boolean); override;
    procedure StartOperation; override;

    property Editor: TElDBCheckBox read GetEditor;
  published
    property Font: TFont read FFont write SetFont stored True;
  end;

  TElDBTreeDateTimePickerEdit = class (TElDBTreeInplaceEditor)
  private
    FAccepted: Boolean;
    SaveWndProc: TWndMethod;
    procedure EditorWndProc(var Message: TMessage);
    procedure SetShowPopupCalendar(Value: Boolean);
    function GetShowPopupCalendar: Boolean;
    procedure SetShowCalendarClock(Value: Boolean);
    function GetShowCalendarClock: Boolean;
    procedure SetFormat(Value: TElDatePickerFormat);
    function GetFormat: TElDatePickerFormat;
  protected
    FIgnoreKillFocus  : boolean;
    function GetEditor: TElDBDateTimePicker;
    procedure CalDropDown(Sender : TObject);
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted: boolean); override;
    function GetVisible: Boolean; override;
    procedure SetEditorParent; override;
    procedure TriggerAfterOperation(var Accepted: boolean; var
            DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
    function GetStyleManager: TElStyleManager;
    function GetStyleName: string;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure CompleteOperation(Accepted: boolean); override;
    procedure StartOperation; override;

    property Editor: TElDBDateTimePicker read GetEditor;
  published
    property Font: TFont read FFont write SetFont stored True;
    property StyleManager: TElStyleManager read GetStyleManager write
        SetStyleManager;
    property StyleName: string read GetStyleName write SetStyleName;
    property ShowPopupCalendar: Boolean read GetShowPopupCalendar write SetShowPopupCalendar default false;
    property Format : TElDatePickerFormat read GetFormat write SetFormat default edfShortDateLongTime;
    property CalendarShowClock: Boolean read GetShowCalendarClock write SetShowCalendarClock default false;
  end;

  TElDBTreeCurrencyEdit = class (TElDBTreeInplaceEditor)
  private
    FAccepted: Boolean;
    FCalcDlgButtonVisible: Boolean;
    FOldVal: variant;
    SaveIntWndProc1: TWndMethod;
    SaveIntWndProc2: TWndMethod;
    SaveWndProc: TWndMethod;
    function GetValidationMsgString: string;
    function GetValidator: TLMDValidationEntity;
    procedure SetValidationMsgString(const Value: string);
    procedure SetValidator(const Value: TLMDValidationEntity);
    function GetOnValidationError: TLMDValidationErrorEvent;
    procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
    procedure EditorWndProc(var Message: TMessage);
    procedure IntEditorWndProc1(var Message: TMessage);
    procedure IntEditorWndProc2(var Message: TMessage);
    procedure SetNegativeSignColor(Value: TColor);
    function GetNegativeSignColor: TColor;
    procedure SetSign(Value: Boolean);
    function GetSign: Boolean;
    procedure SetEnableSign(Value: Boolean);
    function GetEnableSign: Boolean;
    procedure SetNegativeValueTextColor(Value: TColor);
    function GetNegativeValueTextColor: TColor;
    procedure SetDecimalPlaces(Value: Byte);
    function GetDecimalPlaces: Byte;
    procedure SetUseSystemDecimalPlaces(Value: Boolean);
    function GetUseSystemDecimalPlaces: Boolean;
    procedure SetCurrencySymbol(Value: TLMDString);
    function GetCurrencySymbol: TLMDString ;
    procedure SetCurrencySymbolPosition(Value: TElCurrencySymbolPosition);
    function GetCurrencySymbolPosition: TElCurrencySymbolPosition;
    procedure SetUseSystemCurrencySymbol(Value: Boolean);
    function GetUseSystemCurrencySymbol: Boolean;
    procedure SetUseThousandSeparator(Value: Boolean);
    function GetUseThousandSeparator: Boolean;
  protected
    FIgnoreKillFocus : boolean;
    function GetEditor: TElDBCurrencyEdit;
    function GetStyleManager: TElStyleManager;
    function GetStyleName: string;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted: boolean); override;
    function GetVisible: Boolean; override;
    procedure RealWndProc(var Message: TMessage);
    procedure SetEditorParent; override;
    procedure TriggerAfterOperation(var Accepted: boolean; var
            DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
    procedure OnCalcDlg(Sender : TObject);
    procedure OnCalcDlgClose(Sender : TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CompleteOperation(Accepted: boolean); override;
    procedure StartOperation; override;
    property Editor: TElDBCurrencyEdit read GetEditor;
  published
    property StyleManager: TElStyleManager read GetStyleManager write
        SetStyleManager;
    property StyleName: string read GetStyleName write SetStyleName;
    property Font: TFont read FFont write SetFont stored True;
    property Sign: Boolean read GetSign write SetSign default false;
    property EnableSign: Boolean read GetEnableSign write SetEnableSign default false;
    property NegativeSignColor: TColor read GetNegativeSignColor write
      SetNegativeSignColor default clNone;
    property NegativeValueTextColor: TColor read GetNegativeValueTextColor write
      SetNegativeValueTextColor default clNone;
    property DecimalPlaces: Byte read GetDecimalPlaces write SetDecimalPlaces default 2;
    property UseSystemDecimalPlaces: Boolean read GetUseSystemDecimalPlaces write
      SetUseSystemDecimalPlaces default true;
    property CurrencySymbol: TLMDString read GetCurrencySymbol write
    SetCurrencySymbol;
    property CurrencySymbolPosition: TElCurrencySymbolPosition read
      GetCurrencySymbolPosition write SetCurrencySymbolPosition default ecsPosRight;
    property UseSystemCurrencySymbol: Boolean read GetUseSystemCurrencySymbol write
      SetUseSystemCurrencySymbol default false;
    {$ifndef NO_CALC_IN_CURREDIT}
    property CalcDlgButtonVisible: Boolean read FCalcDlgButtonVisible write FCalcDlgButtonVisible default false;
    {$endif}
    property UseThousandSeparator: Boolean read GetUseThousandSeparator write SetUseThousandSeparator default false;
    property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
  end;

  TElDBTreeComboBoxEdit = class(TElDBTreeInplaceEditor)
  private
    FAccepted: Boolean;
    SaveWndProc: TWndMethod;
    FOldVal: variant;
    procedure EditorWndProc(var Message : TMessage);
    function GetItems: TLMDStrings;
    procedure SetItems(Value: TLMDStrings);
  {$ifdef LMD_UNICODE}
    procedure SetStressShortCut(Value: TShortCut);
    function GetStressShortCut: TShortCut;
    procedure SetShowGripper(Value: Boolean);
    function GetShowGripper: Boolean;
  {$endif}
    function GetValidationMsgString: string;
    function GetValidator: TLMDValidationEntity;
    procedure SetValidationMsgString(const Value: string);
    procedure SetValidator(const Value: TLMDValidationEntity);
    function GetOnValidationError: TLMDValidationErrorEvent;
    procedure SetOnValidationError(const Value: TLMDValidationErrorEvent);
  protected
    FInitiallyDropped : boolean;
    function GetEditor: TElDBComboBox;
    procedure SetEditorParent; override;
    procedure DoStartOperation; override;
    procedure DoStopOperation(Accepted : boolean); override;
    function GetVisible: Boolean; override;
    procedure TriggerAfterOperation(var Accepted : boolean; var DefaultConversion :
        boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion : boolean); override;
    function GetStyleManager: TElStyleManager;
    function GetStyleName: string;
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure TriggerValidateResult(var InputValid: boolean); override;
    procedure StartOperation; override;
    procedure CompleteOperation(Accepted: boolean); override;

    property Editor: TElDBComboBox read GetEditor;
  published
    property StyleManager: TElStyleManager read GetStyleManager write
        SetStyleManager;
    property StyleName: string read GetStyleName write SetStyleName;
    property InitiallyDropped : boolean read FInitiallyDropped write FInitiallyDropped default false;
    property Font: TFont read FFont write SetFont stored True;
    {$IFDEF LMD_UNICODE}
    property Items: TLMDWideStrings read GetItems write SetItems stored True;
    property ShowGripper: Boolean read GetShowGripper write SetShowGripper default false;
    property StressShortCut: TShortCut read GetStressShortCut write SetStressShortCut default 0;
    {$ELSE}
    property Items: TLMDStrings read GetItems write SetItems stored True;
    {$ENDIF}
    property ValidationMsgString : string read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read GetOnValidationError write SetOnValidationError;
  end;

implementation

uses

  ElSpin, ElTreeInplaceEditors, ElXPThemedControl;

{$ifdef LMD_UNICODE}

procedure TElWideDBTEdit.DataChange(Sender: TObject);
begin
  DataChangeText;
end;
{$ENDIF}
{ TElDBTreeInplaceEdit }

{
******************************** TElDBTreeEdit *********************************
}

constructor TElDBTreeEdit.Create(AOwner: TComponent);
begin
  inherited;
  {$ifdef LMD_UNICODE}
  FEditor := TElWideDBTEdit.Create(Self);
  {$else}
  FEditor := TElDBEdit.Create(Self);
  {$endif}
  FEditor.Visible := false;
  THackElDBEdit(FEditor).AutoSize := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := Self.EditorWndProc;
  FTypes := [sftText];
end;

destructor TElDBTreeEdit.Destroy;
begin
  FEditor.WindowProc := SaveWndProc;
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

{$ifdef LMD_UNICODE}
procedure TElDBTreeEdit.SetStressShortCut(Value: TShortCut);
begin
  Editor.StressShortCut := Value;
end;

function TElDBTreeEdit.GetStressShortCut: TShortCut;
begin
  Result := Editor.StressShortCut;
end;
{$endif}

procedure TElDBTreeEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElDBTreeEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSource;
  fieldname, oldv: string;
begin
  DS := TDataSource.Create(Owner);
  DS.DataSet := Editor.DataSource.DataSet;
  oldv := Editor.Text;
  fieldname := Editor.Field.FieldName;
  DS.DataSet.DisableControls;
  inherited CompleteOperation(accepted);
//  THackElDBEdit(FEditor).Reset;
  DS.DataSet.EnableControls;
  if (FAccepted) and (Accepted) and (DS.DataSet.FieldByName(fieldname).AsString <> oldv) then
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(fieldname).AsString := oldv;
  end;
  try
    DS.DataSet.CheckBrowseMode;
  except
    DS.DataSet.Cancel;
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(fieldname).AsString := oldv;
    DS.DataSet.CheckBrowseMode;
  end;
  DS.Free;
  TriggerAfterCompleteOperation;
end;

procedure TElDBTreeEdit.DoStopOperation(Accepted: boolean);
begin
  FEditor.Visible := false;
  Editor.DataField := '';
  Editor.DataSource := nil;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElDBTreeEdit.StartOperation;
begin
  SetEditorParent;
  Editor.BiDiMode := Editor.Parent.BiDiMode;
  if (Tree is TCustomElDBTree) then
  begin
    Editor.DataSource := (Item as TElDBTreeItem).GetDataSource;
    Editor.DataField := (Item as TElDBTreeItem).EditingField;
  end
  else
  begin
    Editor.DataSource := (Item as TElDBXTreeItem).GetDataSource;
    Editor.DataField := (Item as TElDBXTreeItem).EditingField;
  end;
  inherited;
end;

procedure TElDBTreeEdit.EditorWndProc(var Message: TMessage);
var
  InputValid: Boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        CompleteOperation(true);
        exit;
      end
      else
        if TWMKey(Message).CharCode = VK_ESCAPE then
        begin
          CompleteOperation(false);
          exit;
        end;
    end;
  end
  else
    if (Message.Msg = WM_CANCELMODE) or
      ((Message.Msg = CM_CANCELMODE) and
      (TObject(Pointer(Message.lParam)) <> Editor)
      ) or  (Message.Msg = WM_KILLFOCUS) then
      if FEditing then
      begin
        if THackElTree(Tree).ExplorerEditMode then
        begin
          InputValid := true;
          TriggerValidateResult(InputValid);
          CompleteOperation(InputValid);
          exit;
        end
        else
        begin
          CompleteOperation(false);
          exit;
        end;
      end;
  SaveWndProc(Message);
end;

function TElDBTreeEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeEdit.TriggerAfterOperation(var Accepted: boolean; var
        DefaultConversion: boolean);
begin
  Editor.OnExit := nil;
  inherited;
  {$IFDEF LMD_UNICODE}
  THackElWideDBEdit(FEditor).Reset;
  {$else}
  THackElDBEdit(FEditor).Reset;
  {$endif}
  FAccepted := Accepted;
end;

procedure TElDBTreeEdit.TriggerBeforeOperation(var DefaultConversion: boolean);
begin
  Editor.AutoSize := False;
  FEditor.BoundsRect := FCellRect;
// EK - temporary solution to change scaled control
//  {$IFDEF LMD_UNICODE}
//  if (Tree is TCustomElDBXTree) then
//    THackElWideDBEdit(FEditor).Font.Size := (Item as TElDBXTreeItem).CurrentStyle.FontSize;
//  {$endif}
  inherited;
end;

function TElDBTreeEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElDBTreeEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElDBTreeEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElDBTreeEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElDBTreeEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElDBTreeEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

{ TElDBTreeMemoEdit }
{
****************************** TElDBTreeMemoEdit *******************************
}
constructor TElDBTreeMemoEdit.Create(AOwner: TComponent);
begin
  inherited;
  FForm := TDBMemoForm.CreateNew(Self);
  FForm.Visible := False;
  FForm.BorderStyle := bsNone;
  FForm.FormStyle := fsStayOnTop;
//  with TElFormPersist.Create(FForm) do
//    TopMost := true;

  FEditor := TElInpDBMemo.Create(FForm);
  (FEditor as TElInpDBMemo).FTreeMemoEdit := Self;
{$IFDEF LMD_UNICODE}
  Editor.BorderColorDkShadow := clBlack;
  Editor.BorderColorFace := clBlack;
  Editor.BorderColorShadow := clBlack;
  Editor.BorderColorHighlight := clBlack;
  Editor.BorderColorWindow := clBlack;
{$endif}
  FEditor.parent := FForm;
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  Editor.HandleDialogKeys := true;

  FTypes := [sftMemo];
  FForm.Height := 89;
  FForm.Width := 10;
end;

destructor TElDBTreeMemoEdit.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  FForm.Free;
  inherited;
end;

procedure TElDBTreeMemoEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSource;
  fieldname: string;
begin
  DS := TDataSource.Create(Owner);
  DS.DataSet := Editor.DataSource.DataSet;
  fieldname := Editor.Field.FieldName;
  if not Accepted then Editor.DataSource.DataSet.Cancel;
  inherited CompleteOperation(Accepted);
  if not FAccepted then
    DS.DataSet.Cancel;
  DS.DataSet.CheckBrowseMode;
  DS.Free;
  TriggerAfterCompleteOperation;
end;

procedure TElDBTreeMemoEdit.DoStopOperation(Accepted: boolean);
begin
  FForm.Visible := false;
  Editor.DataField := '';
  Editor.DataSource := nil;
  FForm.Parent := nil;
//  FEditor.Parent := nil;
  inherited;
end;

function TElDBTreeMemoEdit.GetVisible: Boolean;
begin
  Result := FForm.Visible;
end;

procedure TElDBTreeMemoEdit.SetEditorParent;
begin
//  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeMemoEdit.TriggerAfterOperation(var Accepted: boolean; var
        DefaultConversion: boolean);
begin
  Editor.OnExit := nil;
  inherited;
  FAccepted := Accepted;
end;

procedure TElDBTreeMemoEdit.TriggerBeforeOperation(var DefaultConversion:
        boolean);
var
  P: TPoint;
  W,H, H1 : integer;
begin
  inherited;
//  P := FTree.Parent.ClientToScreen(Point(FCellRect.Left+ FTree.Left,FCellRect.Bottom + FTree.Top));
  P := FTree.ClientToScreen(Point(FCellRect.Left,FCellRect.Bottom));
  W := max((FCellRect.Right - FCellRect.Left),FForm.Width);
  H := FForm.Height;
  H1 := FForm.Height - (FCellRect.Bottom - FCellRect.Top);
  if ((FCellRect.Top + H) > self.Tree.Height) and ((FCellRect.Bottom - H) > 0) then
    Dec(P.Y, H1);
  FForm.SetBounds(P.X,P.Y, W, H);

  if (Tree is TCustomElDBTree) then
  begin
    Editor.DataField := (Item as TElDBTreeItem).EditingField;
    if (Editor.Lines.Count > Round(FForm.Height/(Item as TElTreeItem).Height)) then
      Editor.ScrollBars := ssVertical
    else
      Editor.ScrollBars := ssNone;
  end
  else
  begin
    Editor.DataField := (Item as TElDBXTreeItem).EditingField;
    if (Editor.Lines.Count > Round(FForm.Height/(Item as TElDBXTreeItem).Height)) then
      Editor.ScrollBars := ssVertical
    else
      Editor.ScrollBars := ssNone;
  end;
end;

function TElDBTreeMemoEdit.GetHeight: Integer;
begin
  if Assigned(FEditor) then
    Result := FEditor.Height
  else
    Result := 0;
end;

{$IFDEF LMD_UNICODE}
procedure TElDBTreeMemoEdit.SetStressShortCut(Value: TShortCut);
begin
  Editor.StressShortCut := Value;
end;

function TElDBTreeMemoEdit.GetStressShortCut: TShortCut;
begin
  Result := Editor.StressShortCut;
end;

procedure TElDBTreeMemoEdit.SetUnicodeMode(value: TElDBUnicodeMode);
begin
  if Assigned(FEditor) then
    Editor.UnicodeMode := Value;
end;

function TElDBTreeMemoEdit.GetUnicodeMode: TElDBUnicodeMode;
begin
  if Assigned(FEditor) then
    Result := Editor.UnicodeMode
  else
    Result := umFieldType;
end;
{$endif}
procedure TElDBTreeMemoEdit.SetHeight(value: Integer);
begin
  if Assigned(FEditor) then
    FEditor.Height := Value;
end;

{$IFDEF LMD_UNICODE}
function TElDBTreeMemoEdit.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElDBTreeMemoEdit.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElDBTreeMemoEdit.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElDBTreeMemoEdit.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;
{$endif}

function TElDBTreeMemoEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElDBTreeMemoEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElDBTreeMemoEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElDBTreeMemoEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElDBTreeMemoEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElDBTreeMemoEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

{ TElDBTreeCheckBoxEdit }
{
**************************** TElDBTreeCheckBoxEdit *****************************
}
constructor TElDBTreeCheckBoxEdit.Create(AOwner: TComponent);
begin
  inherited;
  FEditor := TElDBCheckBox.Create(Self);
  FEditor.Visible := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := Self.EditorWndProc;
  FTypes := [sftBool];
end;

destructor TElDBTreeCheckBoxEdit.Destroy;
begin
  FEditor.WindowProc := SaveWndProc;
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElDBTreeCheckBoxEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSource;
  fieldname: string;
  oldv: variant;
begin
  DS := TDataSource.Create(Owner);
  DS.DataSet := Editor.DataSource.DataSet;
  fieldname := Editor.Field.FieldName;
  oldv := DS.DataSet.FieldByName(fieldname).Value;
  //  DS.DisableControls;
  //  FEditor.DataSource.DataSet.Cancel;
  inherited CompleteOperation(accepted);
  //  DS.EnableControls;
  if (not FAccepted) and (DS.DataSet.FieldByName(FieldName).Value <> oldv) then
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := oldv;
  end;
  DS.DataSet.CheckBrowseMode;
  Ds.Free;
  TriggerAfterCompleteOperation;
end;

procedure TElDBTreeCheckBoxEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElDBTreeCheckBoxEdit.DoStopOperation(Accepted: boolean);
begin
  FEditor.Visible := false;
  Editor.DataField := '';
  Editor.DataSource := nil;
  Editor.Parent := nil;
  inherited;
end;

procedure TElDBTreeCheckBoxEdit.EditorWndProc(var Message: TMessage);
var
  InputValid: Boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        CompleteOperation(true);
        exit;
      end
      else
        if TWMKey(Message).CharCode = VK_ESCAPE then
        begin
          CompleteOperation(false);
          exit;
        end;
    end;
  end
  else
    if (Message.Msg = WM_CANCELMODE) or
      ((Message.Msg = CM_CANCELMODE) and
      (TObject(Pointer(Message.lParam)) <> Editor)
      ) or (Message.Msg = WM_KILLFOCUS) then
      if FEditing then
      begin
        if THackElTree(Tree).ExplorerEditMode then
        begin
          InputValid := true;
          TriggerValidateResult(InputValid);
          CompleteOperation(InputValid);
          exit;
        end
        else
        begin
          CompleteOperation(false);
          exit;
        end;
      end;
  SaveWndProc(Message);
end;

function TElDBTreeCheckBoxEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeCheckBoxEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeCheckBoxEdit.TriggerAfterOperation(var Accepted: boolean;
        var DefaultConversion: boolean);
begin
  Editor.OnExit := nil;
  inherited;
  FAccepted := Accepted;
end;

procedure TElDBTreeCheckBoxEdit.TriggerBeforeOperation(var DefaultConversion:
        boolean);
begin
  FEditor.BoundsRect := FCellRect;
  inherited;
end;

{ TElDBTreeDateTimePickerEdit }

{
************************* TElDBTreeDateTimePickerEdit **************************
}
constructor TElDBTreeDateTimePickerEdit.Create(AOwner: TComponent);
begin
  inherited;
  FEditor := TElDBDateTimePicker.Create(Self);
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  FEditor.Visible := false;
  Editor.HandleDialogKeys := true;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := Self.EditorWndProc;
  Editor.OnDropDown := CalDropDown;
  FTypes := [sftDateTime, sftTime, sftDate];
end;

destructor TElDBTreeDateTimePickerEdit.Destroy;
begin
  FEditor.WindowProc := SaveWndProc;
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElDBTreeDateTimePickerEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSource;
  fieldname: string;
  oldv, newval : variant;
begin
  DS := TDataSource.Create(Owner);
  DS.DataSet := Editor.DataSource.DataSet;
  fieldname := Editor.Field.FieldName;
  oldv := DS.DataSet.FieldByName(FieldName).Value;
  newval := Editor.DateTime;
  inherited CompleteOperation(accepted);
  if (not FAccepted) then
  begin
    if (DS.DataSet.FieldByName(fieldname).AsDateTime <> oldv) then
    begin
      DS.DataSet.Edit;
      DS.DataSet.FieldByName(FieldName).Value := oldv;
    end;
  end
  else
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := newval;
  end;
  DS.DataSet.CheckBrowseMode;
  Ds.Free;
  TriggerAfterCompleteOperation;
end;

procedure TElDBTreeDateTimePickerEdit.DoStopOperation(Accepted: boolean);
begin
  FEditor.Visible := false;
  Editor.DataField := '';
  Editor.DataSource := nil;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElDBTreeDateTimePickerEdit.EditorWndProc(var Message: TMessage);
var
  InputValid: Boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        CompleteOperation(true);
        exit;
      end
      else
        if TWMKey(Message).CharCode = VK_ESCAPE then
        begin
          CompleteOperation(false);
          exit;
        end;
    end;
  end
  else
    if (Message.Msg = WM_CANCELMODE) or
      ((Message.Msg = CM_CANCELMODE) and
      ((Message.lParam = 0) or
      ((TControl(TObject(Pointer(Message.lParam))).Parent <> Editor)) and
      (TObject(Pointer(Message.lParam)) <> Editor))) or
      ((Message.Msg = WM_KILLFOCUS)  and (not FIgnoreKillFocus)) then
      if FEditing then
      begin
        if THackElTree(Tree).ExplorerEditMode then
        begin
          InputValid := true;
          TriggerValidateResult(InputValid);
          CompleteOperation(InputValid);
          exit;
        end
        else
        begin
          CompleteOperation(false);
          exit;
        end;
      end;
  SaveWndProc(Message);
end;

procedure TElDBTreeDateTimePickerEdit.CalDropDown(Sender : TObject);
begin
  FIgnoreKillFocus := Editor.DroppedDown;
end;

function TElDBTreeDateTimePickerEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeDateTimePickerEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeDateTimePickerEdit.TriggerAfterOperation(var Accepted:
        boolean; var DefaultConversion: boolean);
begin
  Editor.OnExit := nil;
  inherited;
  FAccepted := Accepted;
end;

procedure TElDBTreeDateTimePickerEdit.TriggerBeforeOperation(var
        DefaultConversion: boolean);
begin
  Editor.AutoSize := False;
  FEditor.BoundsRect := FCellRect;
  inherited;
end;

function TElDBTreeDateTimePickerEdit.GetShowPopupCalendar: Boolean;
begin
  if Assigned(FEditor) then
    Result := Editor.ShowPopupCalendar
  else
    Result := False;
end;

procedure TElDBTreeDateTimePickerEdit.SetShowPopupCalendar(
  Value: Boolean);
begin
  if Assigned(FEditor) then
    Editor.ShowPopupCalendar := Value;
end;

function TElDBTreeDateTimePickerEdit.GetShowCalendarClock: Boolean;
begin
  if Assigned(FEditor) then
    Result := Editor.CalendarShowClock
  else
    Result := False;
end;

procedure TElDBTreeDateTimePickerEdit.SetShowCalendarClock(
  Value: Boolean);
begin
  if Assigned(FEditor) then
    Editor.CalendarShowClock := Value;
end;

function TElDBTreeDateTimePickerEdit.GetFormat: TElDatePickerFormat;
begin
  if Assigned(FEditor) then
    Result := Editor.Format
  else
    Result := edfShortDateLongTime;
end;

procedure TElDBTreeDateTimePickerEdit.SetFormat(
  Value: TElDatePickerFormat);
begin
  if Assigned(FEditor) then
    Editor.Format := Value;
end;

function TElDBTreeDateTimePickerEdit.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElDBTreeDateTimePickerEdit.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElDBTreeDateTimePickerEdit.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElDBTreeDateTimePickerEdit.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

{ TElDBTreeCurrencyEdit }
{
**************************** TElDBTreeCurrencyEdit *****************************
}
constructor TElDBTreeCurrencyEdit.Create(AOwner: TComponent);

begin
  inherited;
  FEditor := TElDBCurrencyEdit.Create(Self);
  FEditor.Visible := false;
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  Editor.HandleDialogKeys := true;
  Editor.CalcDlgDefZeroValue := false;
  Editor.CalcDlgOnButtonClick := OnCalcDlg;
  Editor.CalcDlgOnClose := OnCalcDlgClose;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FTypes := [sftCurrency];
  SaveIntWndProc1 := THackControl(THackDBInplaceCurrencyEdit(FEditor).FPartEditors[1]).WindowProc;
  SaveIntWndProc2 := THackControl(THackDBInplaceCurrencyEdit(FEditor).FPartEditors[2]).WindowProc;
  THackControl(THackDBInplaceCurrencyEdit(FEditor).FPartEditors[1]).WindowProc := IntEditorWndProc1;
  THackControl(THackDBInplaceCurrencyEdit(FEditor).FPartEditors[2]).WindowProc := IntEditorWndProc2;
  end;

destructor TElDBTreeCurrencyEdit.Destroy;
begin
  FEditor.WindowProc := SaveWndProc;
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElDBTreeCurrencyEdit.OnCalcDlg(Sender : TObject);
begin
  FIgnoreKillFocus := true;
  Editor.ReadOnly := false;
end;

procedure TElDBTreeCurrencyEdit.OnCalcDlgClose(Sender : TObject);
begin
//  FIgnoreKillFocus := false;
end;

procedure TElDBTreeCurrencyEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSet;
  fieldname: string;
  newv: variant;
  // pr : Boolean;
begin
  DS := Editor.DataSource.DataSet;
  // pr := true;
  newv := Editor.Value;
  fieldname := Editor.Field.FieldName;
  DS.DisableControls;
  inherited CompleteOperation(Accepted);
  DS.EnableControls;
  if (FAccepted) and (Accepted) then
  begin
    DS.Edit;
    DS.FieldByName(FieldName).Value := newv
  end
  else
  begin
    DS.Edit;
    DS.FieldByName(FieldName).Value := FOldVal
  end;
  DS.CheckBrowseMode;
  TriggerAfterCompleteOperation;
end;

procedure TElDBTreeCurrencyEdit.DoStopOperation(Accepted: boolean);
begin
  if Accepted then FEditor.Visible := false;
  FIgnoreKillFocus := false;
  Editor.DataSource := nil;
  Editor.DataField := '';
  FEditor.Visible := false;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElDBTreeCurrencyEdit.EditorWndProc(var Message: TMessage);
begin
  RealWndProc(Message);
  SaveWndProc(Message);
end;

function TElDBTreeCurrencyEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeCurrencyEdit.IntEditorWndProc1(var Message: TMessage);
begin
  RealWndProc(Message);
  SaveIntWndProc1(Message);
end;

procedure TElDBTreeCurrencyEdit.IntEditorWndProc2(var Message: TMessage);
begin
  RealWndProc(Message);
  SaveIntWndProc2(Message);
end;

procedure TElDBTreeCurrencyEdit.RealWndProc(var Message: TMessage);
var
  InputValid: Boolean;
  ACtl: TWinControl;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        CompleteOperation(true);
        exit;
      end
      else
        if TWMKey(Message).CharCode = VK_ESCAPE then
        begin
          CompleteOperation(false);

          TWMKey(Message).CharCode := 0;
          exit;
        end;
    end;
  end
  else
    if (Message.Msg = WM_CANCELMODE) or
      ((Message.Msg = CM_CANCELMODE) and
      ((Message.lParam = 0) or
      ((TControl(TObject(Pointer(Message.lParam))).Parent <> Editor)) and
      (TObject(Pointer(Message.lParam)) <> Editor))) or
      ((Message.Msg = WM_KILLFOCUS) and (not FIgnoreKillFocus)) then
    begin
      if Message.Msg = WM_KILLFOCUS then
      begin
        ACtl := FindControl(TWMKillFocus(Message).FocusedWnd);
        if (ACtl <> nil) and (ACtl.Parent = Editor) then
        begin
          SaveWndProc(Message);
          exit;
        end;
      end;
      if FEditing then
      begin
        if THackElTree(Tree).ExplorerEditMode then
        begin
          InputValid := true;
          TriggerValidateResult(InputValid);
          CompleteOperation(InputValid);
          exit;
        end
        else
        begin
          CompleteOperation(false);
          exit;
        end;
      end;
    end;
end;

procedure TElDBTreeCurrencyEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeCurrencyEdit.TriggerAfterOperation(var Accepted: boolean;
        var DefaultConversion: boolean);
begin
  Editor.OnExit := nil;
  inherited;
  FAccepted := Accepted;
end;

procedure TElDBTreeCurrencyEdit.TriggerBeforeOperation(var DefaultConversion:
        boolean);
begin
  FEditor.BoundsRect := FCellRect;
  inherited;
end;

function TElDBTreeCurrencyEdit.GetCurrencySymbol: TLMDString;
begin
  if Assigned(FEditor) then
    Result := Editor.CurrencySymbol
  else
    Result := '';
end;

function TElDBTreeCurrencyEdit.GetCurrencySymbolPosition: TElCurrencySymbolPosition;
begin
  if Assigned(FEditor) then
    Result := Editor.CurrencySymbolPosition
  else
    Result := ecsPosLeft;
end;

function TElDBTreeCurrencyEdit.GetDecimalPlaces: Byte;
begin
  if Assigned(FEditor) then
    Result := Editor.DecimalPlaces
  else
    Result := 0;
end;

function TElDBTreeCurrencyEdit.GetEnableSign: Boolean;
begin
  if Assigned(FEditor) then
    Result := Editor.EnableSign
  else
    Result := false;
end;

function TElDBTreeCurrencyEdit.GetNegativeSignColor: TColor;
begin
  if Assigned(FEditor) then
    Result := Editor.NegativeSignColor
  else
    Result := clNone;
end;

function TElDBTreeCurrencyEdit.GetNegativeValueTextColor: TColor;
begin
  if Assigned(FEditor) then
    Result := Editor.NegativeValueTextColor
  else
    Result := clNone;
end;

function TElDBTreeCurrencyEdit.GetSign: Boolean;
begin
  if Assigned(FEditor) then
    Result := Editor.Sign
  else
    Result := false;
end;

function TElDBTreeCurrencyEdit.GetUseSystemCurrencySymbol: Boolean;
begin
  if Assigned(FEditor) then
    Result := Editor.UseSystemCurrencySymbol
  else
    Result := false;
end;

function TElDBTreeCurrencyEdit.GetUseSystemDecimalPlaces: Boolean;
begin
  if Assigned(FEditor) then
    Result := Editor.UseSystemDecimalPlaces
  else
    Result := false;
end;

procedure TElDBTreeCurrencyEdit.SetNegativeSignColor(Value: TColor);
begin
  if Assigned(FEditor) then
    Editor.NegativeSignColor := Value;
end;

procedure TElDBTreeCurrencyEdit.SetNegativeValueTextColor(
  Value: TColor);
begin
  if Assigned(FEditor) then
    Editor.NegativeValueTextColor := Value;
end;

procedure TElDBTreeCurrencyEdit.SetSign(Value: Boolean);
begin
  if Assigned(FEditor) then
    Editor.Sign := Value;
end;

procedure TElDBTreeCurrencyEdit.SetCurrencySymbol(Value: TLMDString);
begin
  if Assigned(FEditor) then
    Editor.CurrencySymbol := Value;
end;

procedure TElDBTreeCurrencyEdit.SetEnableSign(Value: Boolean);
begin
  if Assigned(FEditor) then
    Editor.EnableSign := Value;
end;

procedure TElDBTreeCurrencyEdit.SetDecimalPlaces(Value: Byte);
begin
  if Assigned(FEditor) then
    Editor.DecimalPlaces := Value;
end;

procedure TElDBTreeCurrencyEdit.SetUseSystemCurrencySymbol(
  Value: Boolean);
begin
  if Assigned(FEditor) then
    Editor.UseSystemCurrencySymbol := Value;
end;

procedure TElDBTreeCurrencyEdit.SetUseSystemDecimalPlaces(
  Value: Boolean);
begin
  if Assigned(FEditor) then
    Editor.UseSystemDecimalPlaces := Value;
end;

procedure TElDBTreeCurrencyEdit.SetCurrencySymbolPosition(
  Value: TElCurrencySymbolPosition);
begin
  if Assigned(FEditor) then
    Editor.CurrencySymbolPosition := Value;
end;

function TElDBTreeCurrencyEdit.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElDBTreeCurrencyEdit.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElDBTreeCurrencyEdit.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElDBTreeCurrencyEdit.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

function TElDBTreeCurrencyEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElDBTreeCurrencyEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElDBTreeCurrencyEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElDBTreeCurrencyEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElDBTreeCurrencyEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElDBTreeCurrencyEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

{ TElDBTreeInplaceSpinEdit }

{
****************************** TElDBTreeSpinEdit *******************************
}
constructor TElDBTreeSpinEdit.Create(AOwner: TComponent);
begin
  inherited;
  FEditor := TElDBSpinEdit.Create(Self);
  FEditor.Visible := false;
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  Editor.AutoSelect := true;
  Editor.HandleDialogKeys := true;
  editor.MaxValue := 10000000;
  Editor.MinValue := -10000000;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FTypes := [sftNumber];
  FAccepted1 := True;
end;

destructor TElDBTreeSpinEdit.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElDBTreeSpinEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSource;
  fieldname: string;
  oldv, newv: variant;
begin
  DS := TDataSource.Create(Owner);
  DS.DataSet := Editor.DataSource.DataSet;
  fieldname := Editor.Field.FieldName;
  oldv := DS.DataSet.FieldByName(FieldName).Value;
  newv := Editor.Value;
  DS.DataSet.DisableControls;
  inherited CompleteOperation(true);
  DS.DataSet.EnableControls;
  if (not FAccepted1) and (DS.DataSet.FieldByName(fieldname).AsInteger <> oldv) then
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := oldv;
  end
  else
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := newv;
  end;
  DS.DataSet.CheckBrowseMode;
  Ds.Free;
  TriggerAfterCompleteOperation;
end;

procedure TElDBTreeSpinEdit.DoStopOperation(Accepted: boolean);
begin
  FEditor.Visible := false;
  Editor.DataField := '';
  Editor.DataSource := nil;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElDBTreeSpinEdit.EditorWndProc(var Message: TMessage);
var
  InputValid: Boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        InputValid := true;
        FEditing := false;
        TriggerValidateResult(InputValid);
        FEditing := true;
        if InputValid then
        begin
          CompleteOperation(true);
          exit;
        end
        else
          Editor.SetFocus;
        TWMKey(Message).CharCode := 0;
        exit;
      end
      else
        if TWMKey(Message).CharCode = VK_ESCAPE then
        begin
          CompleteOperation(false);
          TWMKey(Message).CharCode := 0;
          exit;
        end;
    end;
  end
  else
    if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      ((Message.lParam = 0) and
      //vAd:+
      (
        (Message.lParam=0)
        or
        ( (TControl(TObject(Pointer(Message.lParam))).Parent <> Editor) and
          (TObject(Pointer(Message.lParam)) <> Editor))
        )
      )
      //Vad:+.
     ) or
      (Message.Msg = WM_KILLFOCUS) then
      if FEditing then
      begin
        if THackElTree(Tree).ExplorerEditMode then
        begin
          InputValid := true;
          TriggerValidateResult(InputValid);
          CompleteOperation(InputValid);
          exit;
        end
        else
        begin
          CompleteOperation(false);
          exit;
        end;
      end;
  SaveWndProc(Message);
end;

function TElDBTreeSpinEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeSpinEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeSpinEdit.TriggerAfterOperation(var Accepted: boolean; var
        DefaultConversion: boolean);
begin
  Editor.OnExit := nil;
  inherited;
  FAccepted1 := Accepted;
end;

procedure TElDBTreeSpinEdit.TriggerBeforeOperation(var DefaultConversion:
        boolean);
begin
  Editor.AutoSize := False;
  FEditor.BoundsRect := FCellRect;
  inherited;
end;

function TElDBTreeSpinEdit.GetMaxValue: Integer;
begin
  Result := Editor.MaxValue;
end;

function TElDBTreeSpinEdit.GetMinValue: Integer;
begin
  Result := Editor.MinValue;
end;

procedure TElDBTreeSpinEdit.SetMaxValue(Value: Integer);
begin
  Editor.MaxValue := value;
end;

procedure TElDBTreeSpinEdit.SetMinValue(Value: Integer);
begin
  Editor.MinValue := value;
end;
function TElDBTreeSpinEdit.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElDBTreeSpinEdit.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElDBTreeSpinEdit.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElDBTreeSpinEdit.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

function TElDBTreeSpinEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElDBTreeSpinEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElDBTreeSpinEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElDBTreeSpinEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElDBTreeSpinEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElDBTreeSpinEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

{ TElDBTreeFloatSpinEdit }

{
**************************** TElDBTreeFloatSpinEdit ****************************
}
constructor TElDBTreeFloatSpinEdit.Create(AOwner: TComponent);
begin
  inherited;
  FEditor := TElDBFloatSpinEdit.Create(Self);
  FEditor.Visible := false;
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  Editor.AutoSelect := true;
  Editor.HandleDialogKeys := true;
  editor.MaxValue := 10000000;
  Editor.MinValue := -10000000;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FTypes := [sftFloating];
  FAccepted1 := True;
end;

destructor TElDBTreeFloatSpinEdit.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

function TElDBTreeFloatSpinEdit.IsStoreMax: boolean;
begin
  Result := not (Editor.MaxValue = 10000000)
end;

function TElDBTreeFloatSpinEdit.IsStoreMin: boolean;
begin
  Result := not (Editor.MinValue = -10000000)
end;

procedure TElDBTreeFloatSpinEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSource;
  fieldname: string;
  oldv, newv: variant;
begin
  DS := TDataSource.Create(Owner);
  DS.DataSet := Editor.DataSource.DataSet;
  fieldname := Editor.Field.FieldName;
  oldv := DS.DataSet.FieldByName(FieldName).Value;
  newv := Editor.Value;
  DS.DataSet.DisableControls;
  inherited CompleteOperation(Accepted);
  DS.DataSet.EnableControls;
  if (not FAccepted1) and (DS.DataSet.FieldByName(fieldname).AsFloat <> oldv) then
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := oldv;
    DS.DataSet.CheckBrowseMode;
  end
  else
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := newv;
    DS.DataSet.CheckBrowseMode;
  end;
  Ds.Free;
  TriggerAfterCompleteOperation;
end;

procedure TElDBTreeFloatSpinEdit.DoStopOperation(Accepted: boolean);
begin
  FEditor.Visible := false;
  Editor.DataField := '';
  Editor.DataSource := nil;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElDBTreeFloatSpinEdit.EditorWndProc(var Message: TMessage);
var
  InputValid: Boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        InputValid := true;
        FEditing := false;
        TriggerValidateResult(InputValid);
        FEditing := true;
        if InputValid then
        begin
          CompleteOperation(true);
          exit;
        end
        else
          Editor.SetFocus;
        TWMKey(Message).CharCode := 0;
        end
      else
        if TWMKey(Message).CharCode = VK_ESCAPE then
        begin
          CompleteOperation(false);
          TWMKey(Message).CharCode := 0;
          exit;
        end;
    end;
  end
  else
    if (Message.Msg = WM_CANCELMODE) or
      ((Message.Msg = CM_CANCELMODE) and
      ((Message.lParam = 0) or
      ((TControl(TObject(Pointer(Message.lParam))).Parent <> Editor)) and
      (TObject(Pointer(Message.lParam)) <> Editor))) or
      (Message.Msg = WM_KILLFOCUS) then
      if FEditing then
      begin
        if THackElTree(Tree).ExplorerEditMode then
        begin
          InputValid := true;
          TriggerValidateResult(InputValid);
          CompleteOperation(InputValid);
          exit;
        end
        else
        begin
          CompleteOperation(false);
          exit;
        end;
      end;
  SaveWndProc(Message);
end;

function TElDBTreeFloatSpinEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeFloatSpinEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeFloatSpinEdit.TriggerAfterOperation(var Accepted: boolean;
        var DefaultConversion: boolean);
begin
  Editor.OnExit := nil;
  inherited;
  FAccepted1 := Accepted;
end;

procedure TElDBTreeFloatSpinEdit.TriggerBeforeOperation(var DefaultConversion:
        boolean);
begin
  Editor.AutoSize := False;
  FEditor.BoundsRect := FCellRect;
  inherited;
end;

function TElDBTreeFloatSpinEdit.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElDBTreeFloatSpinEdit.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElDBTreeFloatSpinEdit.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElDBTreeFloatSpinEdit.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

function TElDBTreeFloatSpinEdit.GetMaxValue: Double;
begin
  Result := Editor.MaxValue;
end;

function TElDBTreeFloatSpinEdit.GetMinValue: Double;
begin
  Result := Editor.MinValue;
end;

procedure TElDBTreeFloatSpinEdit.SetMaxValue(Value: Double);
begin
  Editor.MaxValue := value;
end;

procedure TElDBTreeFloatSpinEdit.SetMinValue(Value: Double);
begin
  Editor.MinValue := value;
end;

function TElDBTreeFloatSpinEdit.GetDigits: Integer;
begin
  Result := Editor.Digits;
end;

procedure TElDBTreeFloatSpinEdit.SetDigits(Value: Integer);
begin
  Editor.Digits := value;
end;

function TElDBTreeFloatSpinEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElDBTreeFloatSpinEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElDBTreeFloatSpinEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElDBTreeFloatSpinEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElDBTreeFloatSpinEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElDBTreeFloatSpinEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

{ TElDBTreeInplaceEdit }
{$IFDEF LMD_UNICODE}

//*************************** TElDBTreeWideStringEdit ****************************

constructor TElDBTreeWideStringEdit.Create(AOwner: TComponent);
begin
  inherited;
  FEditor := TElWideDBTEdit.Create(Self);
  FEditor.Visible := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := Self.EditorWndProc;
  FTypes := [sftText];
end;

destructor TElDBTreeWideStringEdit.Destroy;
begin
  FEditor.WindowProc := SaveWndProc;
  FEditor.Free;
  FEditor := nil;
  inherited;
end;
{$IFDEF LMD_UNICODE}
procedure TElDBTreeWideStringEdit.SetStressShortCut(Value: TShortCut);
begin
  Editor.StressShortCut := Value;
end;

function TElDBTreeWideStringEdit.GetStressShortCut: TShortCut;
begin
  Result := Editor.StressShortCut;
end;
{$ENDIF}
procedure TElDBTreeWideStringEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSource;
  fieldname: string;
  oldv: WideString;
  st: AnsiString;
begin
  DS := TDataSource.Create(Owner);
  DS.DataSet := Editor.DataSource.DataSet;
  oldv := Editor.Lines.Text;
  fieldname := Editor.Field.FieldName;
  DS.DataSet.DisableControls;
//  THackElWideDBEdit(FEditor).Reset;
  inherited CompleteOperation(accepted);
  DS.DataSet.EnableControls;
  if (FAccepted) and (Accepted) and (DS.DataSet.FieldByName(fieldname).AsVariant <> oldv) then
  begin
    DS.DataSet.Edit;
    if ((UnicodeMode = umForceUTF8) or ((DS.DataSet.FieldByName(FieldName).DataType <> ftWideString) and (UnicodeMode = umForceUnicode))) and
       (LMDConvertUTF16toUTF8(oldv, st, strictConversion, false) <> sourceIllegal)
    then
      DS.DataSet.FieldByName(FieldName).Value := st
    else
    begin
      if (DS.DataSet.FieldByName(FieldName).DataType = ftWideString) then
      begin
        DS.DataSet.FieldByName(FieldName).Value := oldv;
      end
      else
      DS.DataSet.FieldByName(FieldName).Text := oldv;
    end;

//    DS.DataSet.FieldByName(FieldName).Value := oldv;
  end;
  try
    DS.DataSet.CheckBrowseMode;
  except
    DS.DataSet.Cancel;
    DS.DataSet.CheckBrowseMode;
  end;
  DS.Free;
  TriggerAfterCompleteOperation;
end;

procedure TElDBTreeWideStringEdit.DoStopOperation(Accepted: boolean);
begin
  FEditor.Visible := false;
  Editor.DataField := '';
  Editor.DataSource := nil;
  FEditor.Parent := nil;
  inherited;
end;

function TElDBTreeWideStringEdit.GetUnicodeMode: TElDBUnicodeMode;
begin
  if Assigned(FEditor) then
    Result := Editor.UnicodeMode
  else
    Result := umFieldType;
end;

procedure TElDBTreeWideStringEdit.SetUnicodeMode(value: TElDBUnicodeMode);
begin
  if Assigned(FEditor) then
    Editor.UnicodeMode := Value;
end;

procedure TElDBTreeWideStringEdit.EditorWndProc(var Message: TMessage);
var
  InputValid: Boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        CompleteOperation(true);
        Message.Msg := 0;
        exit;
      end
      else
        if TWMKey(Message).CharCode = VK_ESCAPE then
        begin
          CompleteOperation(false);
          exit;
        end;
    end;
  end
  else
    if (Message.Msg = WM_CANCELMODE) or
      ((Message.Msg = CM_CANCELMODE) and
      (TObject(Pointer(Message.lParam)) <> Editor)
      ) or
      (Message.Msg = WM_KILLFOCUS) then
      if FEditing then
      begin
        if THackElTree(Tree).ExplorerEditMode then
        begin
          InputValid := true;
          TriggerValidateResult(InputValid);
          CompleteOperation(InputValid);
          exit;
        end
        else
        begin
          CompleteOperation(false);
          exit;
        end;
      end;
  SaveWndProc(Message);
end;

function TElDBTreeWideStringEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeWideStringEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeWideStringEdit.TriggerAfterOperation(var Accepted: boolean;
        var DefaultConversion: boolean);
begin
  Editor.OnExit := nil;
  inherited;
  THackElWideDBEdit(FEditor).Reset;
  FAccepted := Accepted;
end;

procedure TElDBTreeWideStringEdit.TriggerBeforeOperation(var DefaultConversion:
        boolean);
begin
  Editor.AutoSize := False;
  FEditor.BoundsRect := FCellRect;
  inherited;
end;

procedure TElDBTreeWideStringEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElDBTreeWideStringEdit.StartOperation;
begin
  SetEditorParent;
  if (Tree is TCustomElDBTree) then
  begin
    Editor.DataSource := (Item as TElDBTreeItem).GetDataSource;
    Editor.DataField := (Item as TElDBTreeItem).EditingField;
  end
  else
  begin
    Editor.DataSource := (Item as TElDBXTreeItem).GetDataSource;
    Editor.DataField := (Item as TElDBXTreeItem).EditingField;
  end;
  inherited;
end;

function TElDBTreeWideStringEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElDBTreeWideStringEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElDBTreeWideStringEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElDBTreeWideStringEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElDBTreeWideStringEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElDBTreeWideStringEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

{$ENDIF}

procedure TElDBTreeSpinEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElDBTreeFloatSpinEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElDBTreeMemoEdit.DoStartOperation;
begin
  FForm.Visible := True;
  FForm.SetFocus;
end;

procedure TElDBTreeDateTimePickerEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElDBTreeCurrencyEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  {$ifndef NO_CALC_IN_CURREDIT}
  Editor.CalcDlgButtonVisible := FCalcDlgButtonVisible;
  FIgnoreKillFocus := FCalcDlgButtonVisible;
  {$endif}
  FEditor.Visible := true;
  FEditor.SetFocus;
end;

procedure TElDBTreeSpinEdit.StartOperation;
begin
  SetEditorParent;
  if (Tree is TCustomElDBTree) then
  begin
    Editor.DataSource := (Item as TElDBTreeItem).GetDataSource;
    Editor.DataField := (Item as TElDBTreeItem).EditingField;
  end
  else
  begin
    Editor.DataSource := (Item as TElDBXTreeItem).GetDataSource;
    Editor.DataField := (Item as TElDBXTreeItem).EditingField;
  end;
  inherited;
end;

procedure TElDBTreeFloatSpinEdit.StartOperation;
begin
  SetEditorParent;
  if (Tree is TCustomElDBTree) then
  begin
    Editor.DataSource := (Item as TElDBTreeItem).GetDataSource;
    Editor.DataField := (Item as TElDBTreeItem).EditingField;
  end
  else
  begin
    Editor.DataSource := (Item as TElDBXTreeItem).GetDataSource;
    Editor.DataField := (Item as TElDBXTreeItem).EditingField;
  end;
  inherited;
end;

procedure TElDBTreeMemoEdit.StartOperation;
begin
  SetEditorParent;
  if (Tree is TCustomElDBTree) then
  begin
    Editor.DataSource := (Item as TElDBTreeItem).GetDataSource;
//    FEditor.DataField := (Item as TElDBTreeItem).EditingField;
  end
  else
  begin
    Editor.DataSource := (Item as TElDBXTreeItem).GetDataSource;
//    FEditor.DataField := (Item as TElDBXTreeItem).EditingField;
  end;
  inherited;
end;

procedure TElDBTreeCheckBoxEdit.StartOperation;
begin
  SetEditorParent;
  if (Tree is TCustomElDBTree) then
  begin
    Editor.DataSource := (Item as TElDBTreeItem).GetDataSource;
//    if (Item as TElDBTreeItem).ShowCheckBox then
//      FEditor.DataField := (Item as TElDBTreeItem).CheckBoxField
//    else
      Editor.DataField := (Item as TElDBTreeItem).EditingField;
    Editor.Color := TCustomElDBTree((Item as TElDBTreeItem).TreeView).BkColor;
  end
  else
  begin
    Editor.DataSource := (Item as TElDBXTreeItem).GetDataSource;
//    if (Item as TElDBXTreeItem).ShowCheckBox then
//      FEditor.DataField := (Item as TElDBXTreeItem).CheckBoxField
//    else
    Editor.DataField := (Item as TElDBXTreeItem).EditingField;
    Editor.Color := TCustomElDBXTree((Item as TElDBXTreeItem).TreeView).BackgroundColor;
  end;
  inherited;
end;

procedure TElDBTreeDateTimePickerEdit.StartOperation;
begin
  SetEditorParent;
  if (Tree is TCustomElDBTree) then
  begin
    Editor.DataSource := (Item as TElDBTreeItem).GetDataSource;
    Editor.DataField := (Item as TElDBTreeItem).EditingField;
  end
  else
  begin
    Editor.DataSource := (Item as TElDBXTreeItem).GetDataSource;
    Editor.DataField := (Item as TElDBXTreeItem).EditingField;
  end;
  inherited;
end;

procedure TElDBTreeCurrencyEdit.StartOperation;
begin
  SetEditorParent;
  if (Tree is TCustomElDBTree) then
  begin
    Editor.DataSource := (Item as TElDBTreeItem).GetDataSource;
    Editor.DataField := (Item as TElDBTreeItem).EditingField;
  end
  else
  begin
    Editor.DataSource := (Item as TElDBXTreeItem).GetDataSource;
    Editor.DataField := (Item as TElDBXTreeItem).EditingField;
  end;
  FOldVal := Editor.Field.Value ;
  inherited;
end;

constructor TElDBTreeComboBoxEdit.Create(AOwner : TComponent);
begin
  inherited;
  FEditor := THackDBComboBox.Create(Self);
  FEditor.Visible := false;
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  Editor.HandleDialogKeys := true;
  Editor.AutoSize := false;
  SaveWndProc := FEditor.WindowProc;
  FEditor.WindowProc := EditorWndProc;
  FTypes := [sftEnum];
end;

destructor TElDBTreeComboBoxEdit.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;
{$IFDEF LMD_UNICODE}
procedure TElDBTreeComboBoxEdit.SetStressShortCut(Value: TShortCut);
begin
  Editor.StressShortCut := Value;
end;

function TElDBTreeComboBoxEdit.GetStressShortCut: TShortCut;
begin
  Result := Editor.StressShortCut;
end;
{$ENDIF}
procedure TElDBTreeComboBoxEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeComboBoxEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
  Editor.DroppedDown := InitiallyDropped;
end;

procedure TElDBTreeComboBoxEdit.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  Editor.DataField := '';
  Editor.DataSource := nil;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElDBTreeComboBoxEdit.EditorWndProc(var Message : TMessage);
var
  InputValid : boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        if Editor.DroppedDown then
          THackDBComboBox(FEditor).CloseUp(true);
        InputValid := true;
        FEditing := false;
        TriggerValidateResult(InputValid);
        FEditing := true;
        if InputValid then
        begin
          CompleteOperation(true);
          TWMKey(Message).CharCode := 0;
          exit;
        end
        else
          Editor.SetFocus;
        TWMKey(Message).CharCode := 0;
        end
      else
      if TWMKey(Message).CharCode = VK_ESCAPE then
      begin
        CompleteOperation(false);
        TWMKey(Message).CharCode := 0;
        end;
    end;
  end
  else
  if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      ((Message.lParam = 0) or
      ((TControl(TObject(Pointer(Message.lParam))).Parent <> Editor)) and
      (TObject(Pointer(Message.lParam)) <> Editor))) or
      (Message.Msg = WM_KILLFOCUS) then
  begin
    if FEditing and (not THackEditorCombo(FEditor).FIgnoreFocus) then
    begin
      if THackElTree(Tree).ExplorerEditMode then
      begin
        InputValid := true;
        TriggerValidateResult(InputValid);
        CompleteOperation(InputValid);
        exit;
      end
      else
        CompleteOperation(false);
//      PostMessage(Editor.Handle, TM_CLOSEINPLACEEDITOR, 0, 0);
    end;
  end
  else
  if (Message.Msg = TM_CLOSEINPLACEEDITOR) then
    if THackElTree(Tree).ExplorerEditMode then
    begin
      InputValid := true;
      TriggerValidateResult(InputValid);
      CompleteOperation(InputValid);
      exit;
    end
    else
    begin
      CompleteOperation(false);
      exit;
    end;
  SaveWndProc(Message);
end;

function TElDBTreeComboBoxEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeComboBoxEdit.TriggerAfterOperation(var Accepted : boolean;
    var DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := Editor.Text;
  FAccepted := Accepted;
end;

procedure TElDBTreeComboBoxEdit.TriggerBeforeOperation(var DefaultConversion :
    boolean);
begin
  Editor.AutoSize := False;
  FEditor.BoundsRect := FCellRect;
  inherited;
  if DefaultConversion then
    Editor.Text := ValueAsText;
end;

procedure TElDBTreeComboBoxEdit.TriggerValidateResult(var InputValid: boolean);
begin
  inherited;
end;

function TElDBTreeComboBoxEdit.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElDBTreeComboBoxEdit.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElDBTreeComboBoxEdit.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElDBTreeComboBoxEdit.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

procedure THackDBComboBox.ComboWndProc(var Message: TMessage; ComboWnd: THandle; ComboProc: Pointer);
var
  InputValid : boolean;
begin
  with TElDBTreeComboBoxEdit(Owner) do
  begin
    if Message.Msg = WM_KEYDOWN then
    begin
      with TWMKey(Message) do
      if KeyDataToShiftState(KeyData) = [] then
      begin
        if CharCode = VK_RETURN then
        begin
          InputValid := true;
          TElDBTreeComboBoxEdit(Owner).TriggerValidateResult(InputValid);
          if InputValid then
          begin
            CompleteOperation(true);
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
    if (Message.Msg = WM_KILLFOCUS) then
    begin
//      if FEditing and (not THackEditorCombo(FEditor).FIgnoreFocus) then
//        PostMessage(Editor.Handle, TM_CLOSEINPLACEEDITOR, 0, 0);
    end
    else
    if (Message.Msg = TM_CLOSEINPLACEEDITOR) then
      if THackElTree(Tree).ExplorerEditMode then
      begin
        InputValid := true;
        TriggerValidateResult(InputValid);
        CompleteOperation(InputValid);
        exit;
      end
      else
      begin
        CompleteOperation(false);
        exit;
      end;
  end;
  inherited;
end;

procedure TElDBTreeComboBoxEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSource;
  fieldname: string;
begin
  if Accepted and
  THackElTree(Tree).ExplorerEditMode
  and (Editor.DataSource.DataSet.State = dsEdit) then
  begin
    FEditing := false;
    Editor.DataSource.DataSet.UpdateRecord;
    FEditing := True;
  end;
  DS := TDataSource.Create(Owner);
  DS.DataSet := Editor.DataSource.DataSet;
  fieldname := Editor.Field.FieldName;
  inherited CompleteOperation(accepted);
  if (not FAccepted) and (DS.DataSet.FieldByName(FieldName).Value <> FOldVal) then
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := FOldVal;
  end;
  try
    DS.DataSet.CheckBrowseMode;
  except
    DS.DataSet.Cancel;
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(fieldname).Value := FOldVal;
    DS.DataSet.CheckBrowseMode;
  end;
  Ds.Free;
  TriggerAfterCompleteOperation;
end;

//type
//  THackElDBTreeItem = class (TElDBTreeItem)
//  end;

procedure TElDBTreeComboBoxEdit.StartOperation;
begin
  SetEditorParent;
  if (Tree is TCustomElDBTree) then
  begin
    Editor.DataSource := (Item as TElDBTreeItem).GetDataSource;
//    if (Item as TElDBTreeItem).ShowCheckBox then
//      FEditor.DataField := (Item as TElDBTreeItem).CheckBoxField
//    else
      Editor.DataField := (Item as TElDBTreeItem).EditingField;
    Editor.Color := TCustomElDBTree((Item as TElDBTreeItem).TreeView).Color;
  end
  else
  begin
    Editor.DataSource := (Item as TElDBXTreeItem).GetDataSource;
//    if (Item as TElDBTreeItem).ShowCheckBox then
//      FEditor.DataField := (Item as TElDBXTreeItem).CheckBoxField
//    else
      Editor.DataField := (Item as TElDBXTreeItem).EditingField;
    Editor.Color := TCustomElDBXTree((Item as TElDBXTreeItem).TreeView).Color;
  end;
  FOldVal := Editor.Field.Value;
  inherited;
end;

function TElDBTreeComboBoxEdit.GetItems: TLMDStrings;
begin
  if Assigned(Editor) then
    Result := Editor.Items
  else
    Result := nil;
end;

procedure TElDBTreeComboBoxEdit.SetItems(Value: TLMDStrings);
begin
  if Assigned(Editor) then
  begin
    Editor.Items.Assign(Value);
  end;
end;

function TElDBTreeComboBoxEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElDBTreeComboBoxEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElDBTreeComboBoxEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElDBTreeComboBoxEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElDBTreeComboBoxEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElDBTreeComboBoxEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

// *****************             TElDBTreeLookupComboBox

constructor TElDBTreeLookupComboBoxEdit.Create(AOwner : TComponent);
begin
  inherited;
//  FEditor := THackDBComboBox.Create(Self);
{$IFDEF LMD_UNICODE}
  FEditor := TElWideDBLookupComboBox.Create(Self);
{$else}
  FEditor := TElDBLookupComboBox.Create(Self);
{$endif}
  FEditor.Visible := false;
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  Editor.HandleDialogKeys := true;

  SaveWndProc := FEditor.WindowProc;

  FEditor.WindowProc := EditorWndProc;

  FTypes := [sftEnum];
end;

destructor TElDBTreeLookupComboBoxEdit.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

{$IFDEF LMD_UNICODE}
procedure TElDBTreeLookupComboBoxEdit.SetStressShortCut(Value: TShortCut);
begin
  Editor.StressShortCut := Value;
end;

function TElDBTreeLookupComboBoxEdit.GetStressShortCut: TShortCut;
begin
  Result := Editor.StressShortCut;
end;
{$endif}
procedure TElDBTreeLookupComboBoxEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeLookupComboBoxEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  FEditor.SetFocus;
  Editor.DroppedDown := InitiallyDropped;
end;

procedure TElDBTreeLookupComboBoxEdit.DoStopOperation(Accepted : boolean);
begin
  FEditor.Visible := false;
  Editor.DataField := '';
  Editor.DataSource := nil;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElDBTreeLookupComboBoxEdit.EditorWndProc(var Message : TMessage);
var
  InputValid : boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        if Editor.DroppedDown then
          THackDBComboBox(FEditor).CloseUp(true);
        InputValid := true;
        FEditing := false;
        TriggerValidateResult(InputValid);
        FEditing := true;
        if InputValid then
        begin
          CompleteOperation(true);
          TWMKey(Message).CharCode := 0;
          exit;
        end
        else
          Editor.SetFocus;
        TWMKey(Message).CharCode := 0;
        end
      else
      if TWMKey(Message).CharCode = VK_ESCAPE then
      begin
        CompleteOperation(false);
        TWMKey(Message).CharCode := 0;
        end;
    end;
  end
  else
  if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      ((Message.lParam = 0) or
      ((TControl(TObject(Pointer(Message.lParam))).Parent <> Editor)) and
      (TObject(Pointer(Message.lParam)) <> Editor))) or
      (Message.Msg = WM_KILLFOCUS) then
  begin
    if (FEditing) and (not THackEditorCombo(FEditor).FIgnoreFocus) then
    begin
        if Editor.DroppedDown then
          THackDBComboBox(FEditor).CloseUp(true);
        InputValid := true;
        FEditing := false;
        TriggerValidateResult(InputValid);
        FEditing := true;
        if InputValid then
        begin
          CompleteOperation(true);
          TWMKey(Message).CharCode := 0;
          exit;
        end
        else
          Editor.SetFocus;
        TWMKey(Message).CharCode := 0;
        //      PostMessage(Editor.Handle, TM_CLOSEINPLACEEDITOR, 0, 0);
    end;
  end
  else
  if (Message.Msg = TM_CLOSEINPLACEEDITOR) then
    if THackElTree(Tree).ExplorerEditMode then
    begin
      InputValid := true;
      TriggerValidateResult(InputValid);
      CompleteOperation(InputValid);
    end
    else
      CompleteOperation(false);

  SaveWndProc(Message);
end;

function TElDBTreeLookupComboBoxEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeLookupComboBoxEdit.TriggerAfterOperation(var Accepted : boolean;
    var DefaultConversion : boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := Editor.Text;
  FAccepted := Accepted;
end;

procedure TElDBTreeLookupComboBoxEdit.TriggerBeforeOperation(var DefaultConversion :
    boolean);
begin
{$IFDEF LMD_UNICODE}
  Editor.AutoSize := False;
{$ENDIF}  
  FEditor.BoundsRect := FCellRect;
  inherited;
  if DefaultConversion then
    Editor.Text := ValueAsText;
end;

{$IFDEF LMD_UNICODE}
function TElDBTreeLookupComboBoxEdit.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElDBTreeLookupComboBoxEdit.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

procedure TElDBTreeLookupComboBoxEdit.SetStyleManager(Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElDBTreeLookupComboBoxEdit.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;
{$endif}
procedure TElDBTreeLookupComboBoxEdit.CompleteOperation(Accepted: boolean);
var
  DS: TDataSource;
  fieldname: string;
  newv: variant;
begin
  DS := TDataSource.Create(Owner);
  DS.DataSet := Editor.DataSource.DataSet;
  fieldname := Editor.Field.FieldName;
  newv := Editor.Text;
  inherited CompleteOperation(accepted);
  if (not FAccepted) then
  begin
    DS.DataSet.Cancel;
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := FOldVal;
  end
  else
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := newv;
  end;
  try
    DS.DataSet.CheckBrowseMode;
  except
    DS.DataSet.Cancel;
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(fieldname).Value := FOldVal;
    DS.DataSet.CheckBrowseMode;
  end;
  DS.Free;
  TriggerAfterCompleteOperation;
end;

procedure TElDBTreeLookupComboBoxEdit.StartOperation;
begin
  SetEditorParent;
  if (Tree is TCustomElDBTree) then
  begin
    Editor.DataSource := (Item as TElDBTreeItem).GetDataSource;
    Editor.DataField := (Item as TElDBTreeItem).EditingField;
  end
  else
  begin
    Editor.DataSource := (Item as TElDBXTreeItem).GetDataSource;
    Editor.DataField := (Item as TElDBXTreeItem).EditingField;
  end;
  FOldVal := Editor.Text;
  inherited;
end;

{$IFDEF LMD_UNICODE}
function TElDBTreeComboBoxEdit.GetShowGripper: Boolean;
begin
  Result := Editor.ShowGripper;
end;

procedure TElDBTreeComboBoxEdit.SetShowGripper(Value: Boolean);
begin
  Editor.ShowGripper := Value;
end;

function TElDBTreeLookupComboBoxEdit.GetShowGripper: Boolean;
begin
  Result := Editor.ShowGripper;
end;

procedure TElDBTreeLookupComboBoxEdit.SetShowGripper(Value: Boolean);
begin
  Editor.ShowGripper := Value;
end;
{$endif}

{$IFDEF LMD_UNICODE}
function TElDBTreeLookupComboBoxEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElDBTreeLookupComboBoxEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElDBTreeLookupComboBoxEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElDBTreeLookupComboBoxEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElDBTreeLookupComboBoxEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElDBTreeLookupComboBoxEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;
{$ENDIF}
{ TDBMemoForm }

constructor TDBMemoForm.CreateNew(AOwner: TComponent; Dummy: integer);
begin
  inherited;
  FTreeMemoEdit := TElDBTreeMemoEdit(AOwner);
end;

procedure TDBMemoForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_POPUP{ or WS_BORDER};
    ExStyle := ExStyle or WS_EX_TOOLWINDOW;
    WndParent := GetDesktopWindow;
  end;
end;

procedure TDBMemoForm.WMEnterSizeMove(var Message: TMessage);
begin
  inherited;
  FTreeMemoEdit.FIgnoreFocus := true;
end;

procedure TDBMemoForm.WMExitSizeMove(var Message: TMessage);
var
  AForm : TCustomForm;
begin
  AForm := GetParentForm(FTreeMemoEdit.Tree);
  if (AForm <> nil) and (AForm.CanFocus) then
    AForm.SetFocus;
  Windows.SetFocus(FTreeMemoEdit.Editor.Handle);
  FTreeMemoEdit.FIgnoreFocus := false;
  inherited;
end;

procedure TDBMemoForm.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
var
  tp: PMinMaxInfo;
  begin
  inherited;
  tp := Message.MinMaxInfo;
  tp.ptMinTrackSize.y := FTreeMemoEdit.CellRect.Bottom - FTreeMemoEdit.CellRect.Top;

{$IFDEF LMD_UNICODE}
  if FTreeMemoEdit.Editor.VertScrollBarStyles.Visible then
  begin
    if FTreeMemoEdit.Editor.UseCustomScrollBars then
      inc(tp.ptMinTrackSize.x, FTreeMemoEdit.Editor.VertScrollBarStyles.Depth)
    else
      inc(tp.ptMinTrackSize.x, GetSystemMetrics(SM_CYVSCROLL));
  end;

  if FTreeMemoEdit.FShowGripper then
    inc(tp.ptMinTrackSize.y, GetSystemMetrics(SM_CYHSCROLL));
{$else}
  if FTreeMemoEdit.Editor.ScrollBars in [ssVertical, ssBoth] then
    inc(tp.ptMinTrackSize.x, GetSystemMetrics(SM_CYVSCROLL));
{$endif}
  inc(tp.ptMinTrackSize.y, GetSystemMetrics(SM_CYBORDER) * 2);
  Message.Result := 1;
end;

procedure TDBMemoForm.WMMouseActivate(var Msg: TWMMouseActivate);
begin
  Msg.Result := MA_NOACTIVATE;
end;

procedure TDBMemoForm.WMNCHitTest(var Msg: TWMNCHitTest);
var
  R : TRect;
begin
  inherited;
  if FTreeMemoEdit.FShowGripper and
    (Msg.Result <> HTVSCROLL) and (Msg.Result <> HTHSCROLL){}
  then
  begin
    R := BoundsRect;
    OffsetRect(R, -Left, -Top);
    R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL);
    R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL);
    if PtInRect(R, ScreenToClient(SmallPointToPoint(Msg.Pos))) then
      Msg.Result := HTBOTTOMRIGHT
    else
    if R.Top < ScreenToClient(SmallPointToPoint(Msg.Pos)).Y then
      Msg.Result := HTNOWHERE;
  end;
end;

procedure TDBMemoForm.WMSetFocus(var Message: TWMSetFocus);
begin
  Windows.SetFocus(Message.FocusedWnd);
end;

procedure TDBMemoForm.WMWindowPosChanged(var Message: TWMWindowPosChanged);
var adj : integer;
begin
  inherited;
  if FTreeMemoEdit.FShowGripper then
    adj := GetSystemMetrics(SM_CYHSCROLL)
  else
    adj := 0;
  FTreeMemoEdit.Editor.SetBounds(0, 0, Message.WindowPos.cx, Message.WindowPos.cy - adj);
  FTreeMemoEdit.Editor.Invalidate;
end;

procedure TElDBTreeMemoEdit.SetShowGripper(Value: Boolean);
begin
  if FShowGripper <> Value then
  begin
    FShowGripper := Value;
    SetWindowPos(FForm.Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER or SWP_NOACTIVATE or SWP_FRAMECHANGED);
  end;
end;

{ TElInpDBMemo }

{$IFDEF LMD_UNICODE}
procedure TElInpDBMemo.Paint;
var DC : HDC;
    R: TRect;
    LThemeMode: TLMDThemeMode;
    LThemed: Boolean;
begin
  inherited;
  LThemeMode := UseThemeMode;
  LThemed := FTreeMemoEdit.Editor.IsThemed;
  if FTreeMemoEdit.ShowGripper then
  begin
    DC := GetWindowDC(FTreeMemoEdit.FForm.Handle);
    GetWindowRect(FTreeMemoEdit.FForm.Handle, R);

    OffsetRect(R, -R.Left, -R.Top);
    R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL)-1;
    if LThemed and (BorderStyle = bsSingle) then
      LMDThemeServices.DrawElement(LThemeMode, DC, tlListviewDontCare, R, nil)
    else
      with FTreeMemoEdit do
        ElVCLUtils.DrawFlatFrameEx2(DC, R, clWindowFrame, Color, False, True,[ebsLeft, ebsRight, ebsBottom], fbtColorLineBorder, clBlack,clBlack,clBlack,clBlack, clBlack);
    // fill rect:
    GetWindowRect(FTreeMemoEdit.FForm.Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    InflateRect(R, -GetSystemMetrics(SM_CXEDGE), 0);
    Dec(R.Bottom, GetSystemMetrics(SM_CYEDGE));
    R.Top := R.Bottom - GetSystemMetrics(SM_CYHSCROLL)+2;
    if LThemed then
    begin
      FillRect(DC, R, HBRUSH(LMDThemeServices.GetThemeSysColor(LThemeMode, teEdit, clBtnFace) + 1));
      R.Left := R.Right - GetSystemMetrics(SM_CXVSCROLL);
      LMDThemeServices.DrawElement(LThemeMode, DC, tsGripper, R, nil);
    end
    else
      DrawFrameControl(DC, R, DFC_SCROLL, DFCS_SCROLLSIZEGRIP);
    ReleaseDC(FTreeMemoEdit.FForm.Handle, DC);
  end;
end;
{$endif}
procedure TElInpDBMemo.WMKeyDown(var Message: TWMKeyDown);
//var InputValid : boolean;
begin
  if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
  begin
    if TWMKey(Message).CharCode = VK_RETURN then
    begin
      FTreeMemoEdit.CompleteOperation(true);
      Message.Msg := 0;
    end
    else
      if TWMKey(Message).CharCode = VK_ESCAPE then
        FTreeMemoEdit.CompleteOperation(false);
  end;
  inherited;
end;

procedure TElInpDBMemo.WMKillFocus(var Msg: TWMKillFocus);
var
  InputValid : boolean;
begin
  if FTreeMemoEdit.Editing and (not FTreeMemoEdit.FIgnoreFocus) then
  begin
    if THackElTree(FTreeMemoEdit.Tree).ExplorerEditMode then
    begin
      InputValid := true;
      FTreeMemoEdit.TriggerValidateResult(InputValid);
      FTreeMemoEdit.CompleteOperation(InputValid)
    end
    else
      FTreeMemoEdit.CompleteOperation(false);
  end;
end;

{ TElDBTreeLookupComboGridEdit }

procedure TElDBTreeLookupComboGridEdit.CompleteOperation(
  Accepted: boolean);
var
  DS: TDataSource;
  fieldname: string;
  newv: variant;
begin
  DS := TDataSource.Create(Owner);
  DS.DataSet := Editor.DataSource.DataSet;
  fieldname := Editor.Field.FieldName;
  newv := Editor.Text;
  inherited CompleteOperation(accepted);
  if (not FAccepted) then
  begin
    DS.DataSet.Cancel;
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := FOldVal;
  end
  else
  begin
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(FieldName).Value := newv;
  end;
  try
    DS.DataSet.CheckBrowseMode;
  except
    DS.DataSet.Cancel;
    DS.DataSet.Edit;
    DS.DataSet.FieldByName(fieldname).Value := FOldVal;
    DS.DataSet.CheckBrowseMode;
  end;
  Ds.Free;
  TriggerAfterCompleteOperation;
end;

constructor TElDBTreeLookupComboGridEdit.Create(AOwner: TComponent);
begin
  inherited;
  FEditor := TElWideDBLookupComboGrid.Create(Self);
  FEditor.Visible := false;
  Editor.ParentCtl3D := false;
  Editor.Ctl3D := false;
  Editor.HandleDialogKeys := true;

  SaveWndProc := FEditor.WindowProc;

  FEditor.WindowProc := EditorWndProc;

  FTypes := [sftEnum];
end;
{$IFDEF LMD_UNICODE}
procedure TElDBTreeLookupComboGridEdit.SetStressShortCut(Value: TShortCut);
begin
  Editor.StressShortCut := Value;
end;

function TElDBTreeLookupComboGridEdit.GetStressShortCut: TShortCut;
begin
  Result := Editor.StressShortCut;
end;
{$ENDIF}
destructor TElDBTreeLookupComboGridEdit.Destroy;
begin
  FEditor.Free;
  FEditor := nil;
  inherited;
end;

procedure TElDBTreeLookupComboGridEdit.DoStartOperation;
begin
  FEditor.Visible := true;
  Editor.DropWidth := FWidth;
  FEditor.SetFocus;
end;

procedure TElDBTreeLookupComboGridEdit.DoStopOperation(Accepted: boolean);
begin
  FEditor.Visible := false;
  Editor.DataField := '';
  Editor.DataSource := nil;
  FEditor.Parent := nil;
  inherited;
end;

procedure TElDBTreeLookupComboGridEdit.EditorWndProc(var Message: TMessage);
var
  InputValid : boolean;
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if KeyDataToShiftState(TWMKey(Message).KeyData) = [] then
    begin
      if TWMKey(Message).CharCode = VK_RETURN then
      begin
        if Editor.Dropped then
          Editor.Dropped := false;
//          THackDBComboBox(FEditor).CloseUp(true);
        InputValid := true;
        FEditing := false;
        TriggerValidateResult(InputValid);
        FEditing := true;
        if InputValid then
        begin
          CompleteOperation(true);
          TWMKey(Message).CharCode := 0;
          exit;
        end
        else
          Editor.SetFocus;
        TWMKey(Message).CharCode := 0;
        end
      else
      if TWMKey(Message).CharCode = VK_ESCAPE then
      begin
        CompleteOperation(false);
        TWMKey(Message).CharCode := 0;
        end;
    end;
  end
  else
  if (Message.Msg = WM_CANCELMODE) or
     ((Message.Msg = CM_CANCELMODE) and
      ((Message.lParam = 0) or
      ((TControl(TObject(Pointer(Message.lParam))).Parent <> Editor)) and
      (TObject(Pointer(Message.lParam)) <> Editor))) or
      (Message.Msg = WM_KILLFOCUS) then
  begin
    if (FEditing) and (not THackTreeCombo(FEditor).IgnoreFocus) then
    begin
        if Editor.Dropped then
          Editor.Dropped := false;
        InputValid := true;
        FEditing := false;
        TriggerValidateResult(InputValid);
        FEditing := true;
        if InputValid then
        begin
          CompleteOperation(true);
          TWMKey(Message).CharCode := 0;
          exit;
        end
        else
          Editor.SetFocus;
        TWMKey(Message).CharCode := 0;
        //      PostMessage(Editor.Handle, TM_CLOSEINPLACEEDITOR, 0, 0);
    end;
  end
  else
  if (Message.Msg = TM_CLOSEINPLACEEDITOR) then
    if THackElTree(Tree).ExplorerEditMode then
    begin
      InputValid := true;
      TriggerValidateResult(InputValid);
      CompleteOperation(InputValid);
    end
    else
      CompleteOperation(false);

  SaveWndProc(Message);
end;

function TElDBTreeLookupComboGridEdit.GetEditor: TElWideDBLookupComboGrid;
begin
  Result := FEditor as TElWideDBLookupComboGrid;
end;

function TElDBTreeLookupComboGridEdit.GetListFieldName: string;
begin
  Result := Editor.ListField;
end;

function TElDBTreeLookupComboGridEdit.GetNullValueKey: TShortCut;
begin
  Result := Editor.NullValueKey;
end;

function TElDBTreeLookupComboGridEdit.GetShowGripper: Boolean;
begin
  Result := Editor.ShowGripper;
end;

function TElDBTreeLookupComboGridEdit.GetStyleManager: TElStyleManager;
begin
  Result := Editor.StyleManager;
end;

function TElDBTreeLookupComboGridEdit.GetStyleName: string;
begin
  Result := Editor.StyleName;
end;

function TElDBTreeLookupComboGridEdit.GetVisible: Boolean;
begin
  Result := FEditor.Visible;
end;

procedure TElDBTreeLookupComboGridEdit.SetEditorParent;
begin
  FEditor.Parent := FTree.View;
end;

procedure TElDBTreeLookupComboGridEdit.SetListFieldName(
  const Value: string);
begin
  Editor.ListField := Value;
end;

function TElDBTreeLookupComboGridEdit.GetValidationMsgString: string;
begin
  Result := GetEditor.ValidationMsgString;
end;

function TElDBTreeLookupComboGridEdit.GetValidator: TLMDValidationEntity;
begin
  Result := GetEditor.Validator;
end;

procedure TElDBTreeLookupComboGridEdit.SetValidationMsgString(const Value: string);
begin
  GetEditor.ValidationMsgString := value;
end;

procedure TElDBTreeLookupComboGridEdit.SetValidator(const Value: TLMDValidationEntity);
begin
  GetEditor.Validator := Value;
end;

function TElDBTreeLookupComboGridEdit.GetOnValidationError: TLMDValidationErrorEvent;
begin
  Result := GetEditor.OnValidationError;
end;

procedure TElDBTreeLookupComboGridEdit.SetOnValidationError(const Value: TLMDValidationErrorEvent);
begin
  GetEditor.OnValidationError := Value;
end;

procedure TElDBTreeLookupComboGridEdit.SetNullValueKey(Value: TShortCut);
begin
  if Value <> Editor.NullValueKey then
    Editor.NullValueKey := Value;
end;

procedure TElDBTreeLookupComboGridEdit.SetShowGripper(Value: Boolean);
begin
  Editor.ShowGripper := Value;
end;

procedure TElDBTreeLookupComboGridEdit.SetStyleManager(
  Value: TElStyleManager);
begin
  Editor.StyleManager := Value;
end;

procedure TElDBTreeLookupComboGridEdit.SetStyleName(const Value: string);
begin
  Editor.StyleName := Value;
end;

procedure TElDBTreeLookupComboGridEdit.StartOperation;
begin
  SetEditorParent;
  if (Tree is TCustomElDBTree) then
  begin
    Editor.DataSource := (Item as TElDBTreeItem).GetDataSource;
    Editor.DataField := (Item as TElDBTreeItem).EditingField;
  end
  else
  begin
    Editor.DataSource := (Item as TElDBXTreeItem).GetDataSource;
    Editor.DataField := (Item as TElDBXTreeItem).EditingField;
  end;
  FOldVal := Editor.Text;
  inherited;
end;

procedure TElDBTreeLookupComboGridEdit.TriggerAfterOperation(var Accepted,
  DefaultConversion: boolean);
begin
  Editor.OnExit := nil;
  inherited;
  if DefaultConversion then
    ValueAsText := Editor.Text;
  FAccepted := Accepted;
end;

procedure TElDBTreeLookupComboGridEdit.TriggerBeforeOperation(
  var DefaultConversion: boolean);
begin
  Editor.AutoSize := False;
  FEditor.BoundsRect := FCellRect;
  FWidth := max(Editor.DropWidth,(FCellRect.Right - FCellRect.Left));
  inherited;
  if DefaultConversion then
    Editor.Text := ValueAsText;
end;

{$IFDEF LMD_UNICODE}

function TElDBTreeLookupComboBoxEdit.GetNullValueKey: TShortCut;
begin
  Result := Editor.NullValueKey;
end;

procedure TElDBTreeLookupComboBoxEdit.SetNullValueKey(Value: TShortCut);
begin
  if Value <> Editor.NullValueKey then
    Editor.NullValueKey := Value;
end;

{$ENDIF}

function TElDBTreeCurrencyEdit.GetUseThousandSeparator: Boolean;
begin
  if Assigned(FEditor) then
    Result := Editor.UseThousandSeparator
  else
    Result := false;
end;

procedure TElDBTreeCurrencyEdit.SetUseThousandSeparator(Value: Boolean);
begin
  if Assigned(FEditor) then
    Editor.UseThousandSeparator := Value;
end;

function TElDBTreeCheckBoxEdit.GetEditor: TElDBCheckBox;
begin
  Result := FEditor as TElDBCheckBox;
end;

function TElDBTreeDateTimePickerEdit.GetEditor: TElDBDateTimePicker;
begin
  Result := FEditor as TElDBDateTimePicker;
end;

function TElDBTreeCurrencyEdit.GetEditor: TElDBCurrencyEdit;
begin
  Result := FEditor as TElDBCurrencyEdit;
end;

function TElDBTreeComboBoxEdit.GetEditor: TElDBComboBox;
begin
  Result := FEditor as TElDBComboBox;
end;

{$IFDEF LMD_UNICODE}
function TElDBTreeLookupComboBoxEdit.GetEditor: TElWideDBLookupComboBox;
begin
  Result := FEditor as TElWideDBLookupComboBox;
end;
{$else}
function TElDBTreeLookupComboBoxEdit.GetEditor: TElDBLookupComboBox;
begin
  Result := FEditor as TElDBLookupComboBox;
end;
{$endif}

{$IFDEF LMD_UNICODE}
function TElDBTreeWideStringEdit.GetEditor: TElWideDBEdit;
begin
  Result := FEditor as TElWideDBEdit;
end;
{$endif}
function TElDBTreeSpinEdit.GetEditor: TElDBSpinEdit;
begin
  Result := FEditor as TElDBSpinEdit;
end;

function TElDBTreeFloatSpinEdit.GetEditor: TElDBFloatSpinEdit;
begin
  Result := FEditor as TElDBFloatSpinEdit;
end;

  {$ifdef LMD_UNICODE}
function TElDBTreeEdit.GetEditor: TElWideDBEdit;
begin
  Result := FEditor as TElWideDBEdit;
end;
  {$else}
function TElDBTreeEdit.GetEditor: TElDBEdit;
begin
  Result := FEditor as TElDBEdit;
end;
  {$endif}

{$IFDEF LMD_UNICODE}
function TElDBTreeMemoEdit.GetEditor: TElWideDBMemo;
begin
  Result := FEditor as TElWideDBMemo;
end;
{$else}
function TElDBTreeMemoEdit.GetEditor: TElDBMemo;
begin
  Result := FEditor as TElDBMemo;
end;
{$endif}

end.
