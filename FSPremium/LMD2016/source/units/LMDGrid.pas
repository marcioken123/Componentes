unit LMDGrid;
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

LMDGrid unit (VT)
-------------------
Unit contains main code of LMD Grid.

Changes
-------
Release 1.0 (July 2009)
 - Initial Release
 - Code formatting (YB, FEB 2011)

###############################################################################}

interface

uses
  Windows, Classes, Controls, Graphics, GraphUtil, ExtCtrls, Grids, Contnrs,
  Messages, Forms, StdCtrls, SysUtils, ComCtrls, DB, Menus, Mask, MaskUtils,
  ImgList, LMDTypes, LMDStrings, LMDCustomMemo, LMDCal, LMDCalc, intfLMDBase,
  LMDThemes, LMDClass, LMDBevel;

const
  {$IFNDEF LMDCOMP7}
  WM_THEMECHANGED   = $031A;
  {$ENDIF}
  HIDEPOPUP_MESSAGE = WM_USER + 1;

type
  ELMDGridError  = class(Exception);
  TLMDCustomGrid = class;
  TLMDGridStyle  = class;
  TLMDGridColumn = class;

  //== Types ===================================================================

  PLMDString         = ^TLMDString;
  TLMDGridBoolArray  = array of Boolean;

  {$IFNDEF LMDCOMP9}
  TVerticalAlignment = (taAlignTop, taAlignBottom, taVerticalCenter);
  TSelection = record
    StartPos: Integer;
    EndPos:   Integer;
  end;
  {$ENDIF}

  TLMDGridCellState  = (csPressed, csHover, csInSelectedArea, csSelectedCell,
                        csSingleCellSelection, csSizingCol, csSizingRow,
                        csMovingCol, csMovingRow, csColumnUnbound, csInvalidValue,
                        csDesignerSelected, csEditing, csSelLeft, csSelTop,
                        csSelRight, csSelBottom);
  TLMDGridCellStates = set of TLMDGridCellState;
  TLMDGridCellKind   = (ckHeader, ckData, ckIndicator, ckNewRow, ckDummyHeader);
  TLMDGridRowState   = (rsCurrentNewRow, rsCurrentEditing, rsCurrentNormal,
                        rsNormal);
  TLMDGridSortKind   = (skNone, skAsc, skDesc);

  {$IFDEF LMDCOMP14} // BCB2010 hack.
  {$HPPEMIT 'namespace Lmdgrid ' }
  {$HPPEMIT '{ ' }
  {$HPPEMIT '  typedef Set<Db::TFieldType, Db::ftUnknown, Db::ftSingle>  TLMDGridFieldTypes;' }
  {$HPPEMIT '  typedef Set<Db::TFieldKind, Db::fkData, Db::fkAggregate>  TLMDGridFieldKinds;' }
  (*$HPPEMIT '}'  *)

  {$EXTERNALSYM TLMDGridFieldTypes}
  TLMDGridFieldTypes = set of TFieldType;
  {$EXTERNALSYM TLMDGridFieldTypes}
  TLMDGridFieldKinds = set of TFieldKind;
  {$ELSE}
  TLMDGridFieldTypes = set of TFieldType;
  TLMDGridFieldKinds = set of TFieldKind;
  {$ENDIF}

  //== ILMDGridEmbeddedEdit ====================================================

  TLMDGridEditParentHelper = class;

  ILMDGridFirstInputKind = (fikNone, fikChar, fikMouseDown, fikDelPress);
  TLMDGridFirstInput     = record
    Kind:      ILMDGridFirstInputKind;
    Char:      TLMDChar;
    Button:    TMouseButton;
    CursorPos: TPoint;
    Shift:     TShiftState;
  end;

  ILMDGridEmbeddedEdit = interface
    function  AsControl: TWinControl;
    procedure SetData(const AKey, AValue: Variant; AInitValue: Boolean);
    procedure GetData(var AKey, AValue: Variant);
    procedure SetGrid(AGridHelper: TLMDGridEditParentHelper);
    function  Column: TLMDGridColumn;
    procedure HandleFirstInput(const AInput: TLMDGridFirstInput);
    procedure SetReadOnly(AValue: Boolean);
    function  GetReadOnly: Boolean;
    procedure SetThemeMode(AThemeMode: TLMDThemeMode;
                           AThemeGlobalMode: Boolean);
  end;

  TLMDGridKeyProcessSource = (psEdit, psChooser, psGrid);

  TLMDGridEditParentHelper = class
  public
    procedure WMGetDlgCode(const Ed: ILMDGridEmbeddedEdit;
                           var Message: TWMGetDlgCode); virtual; abstract;
    procedure KeyDownPreprocess(var Key: Word; Shift: TShiftState;
                                Source: TLMDGridKeyProcessSource); virtual; abstract;
    procedure KeyDownPostprocess(var Key: Word; Shift: TShiftState;
                                 Source: TLMDGridKeyProcessSource); virtual; abstract;
    function  WndProc(const Edit: ILMDGridEmbeddedEdit;
                      var Message: TMessage): Boolean; virtual; abstract;
    procedure EditorChanged; virtual; abstract;
    procedure DrawEditBg(ARect: TRect; ACanvas: TCanvas); virtual; abstract;
    function  AsControl: TLMDCustomGrid; virtual; abstract;
    procedure NeedDelayedHideChooser; virtual; abstract;
    function  DoMouseWheelDown(Shift: TShiftState): Boolean; virtual; abstract;
    function  DoMouseWheelUp(Shift: TShiftState): Boolean; virtual; abstract;
  end;

  //== TLMDGridCustomSource ====================================================

  TLMDGridCustomSourceProp  = (spCanEdit, spCanChangeRows, spCanChangeCols,
                               spCanSort);
  TLMDGridCustomSourceProps = set of TLMDGridCustomSourceProp;

  TLMDGridCustomSource = class
  public
    function  GetProps: TLMDGridCustomSourceProps; virtual;
    function  GetDataCell(ACol, ARow: Integer): Variant; virtual;
    procedure SetDataCell(ACol, ARow: Integer; const Value: Variant;
                          ABlockSort: Boolean; out NewRow: Integer); virtual;
    function  RowCount: Integer; virtual;
    procedure SetRowCount(ACount: Integer; var CorrIndex: Integer); virtual;
    procedure InsertRow(ADest: Integer); virtual;
    procedure DeleteRow(ARow: Integer; var CorrIndex: Integer); virtual;
    procedure MoveRow(ASrc, ADest: Integer); virtual;
    procedure ColumnAdded(ACol: TLMDGridColumn); virtual;
    procedure ColumnDeleting(ACol: TLMDGridColumn); virtual;
    procedure ColumnMoved(ACol: TLMDGridColumn; AMoveTo: Integer); virtual;
    procedure Sort(ACol: TLMDGridColumn; AKind: TLMDGridSortKind;
                   var CorrIndex: Integer); virtual;
    procedure UpdateSort(var CorrIndex: Integer); virtual;
  end;

  //== TLMDGridColumnChooser ===================================================

  TLMDGridColumnChooser      = class;
  TLMDGridColumnChooserClass = class of TLMDGridColumnChooser;
  TLMDGridChooserBtnStyle    = (bsEllipsis, bsPickList, bsBitmap);
  TLMDGridChooserLayout      = (clUnderEdit, clUnderCell);
  TLMDGridChooserKind        = (ckControl, ckModalDialog);

  TLMDGridChooserGetValueEvent = procedure(Grid: TObject; Column: TLMDGridColumn;
                                           var Value: Variant;
                                           var Result: Boolean) of object;

  TLMDGridChooserDescr = class
  public
    ChooserClass:         TLMDGridColumnChooserClass;
    ChooserName:          string;
    Description:          TLMDString;
    Image:                TBitmap;
    FieldKinds:           TLMDGridFieldKinds;
    MainFieldTypes:       TLMDGridFieldTypes;
    MainPriority:         Integer;
    CompatibleFieldTypes: TLMDGridFieldTypes;
    CompatiblePriority:   Integer;
    PaintStyle:           TLMDGridChooserBtnStyle;

    destructor Destroy; override;
  end;

  TLMDGridColumnChooser = class(TComponent)
  private
    FValid:       Boolean;
    FIsEmpty:     Boolean;
    FUpdateCnt:   Integer;
    FButtonImage: TBitmap;
    FEnabled:     Boolean;

    procedure SetButtonImage(const Value: TBitmap);
    procedure SetEnabled(const Value: Boolean);
    procedure SetValid(AValue: Boolean);
    function  IsValid: Boolean;
  protected
    FColumn:   TLMDGridColumn;

    procedure CheckCol;
    function  GetColumnField: TField;
    function  GetColumnFieldKey: TField;
    function  GetEditHelper: TLMDGridEditParentHelper;
    function  GetData(var AKey: Variant; var AValue: Variant): Boolean; virtual; abstract;
    procedure SetData(const AKey: Variant; const AValue: Variant); virtual; abstract;
    function  ShowModal: Boolean; virtual; abstract;
    procedure SetBounds(ARect: TRect); virtual; abstract;
    function  GetControlSize: TSize; virtual; abstract;
    procedure SetControlParent(AParent: TWinControl); virtual;
    procedure SetFocus; virtual; abstract;
    procedure ColumnNotifyPropChanged;
    function  GetChooserKind: TLMDGridChooserKind; virtual;
    function  GetLayout: TLMDGridChooserLayout; virtual;
    function  NeedOkButton: Boolean; virtual;
    function  CanResize: Boolean; virtual;
    property  Tag;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Assign(AValue: TPersistent); override;

    class procedure RegisterChooserClass(AChooserClass: TLMDGridColumnChooserClass;
                                         AChooserName: string; ADescription: TLMDString;
                                         AImage: TBitmap; AMainFieldTypes: TLMDGridFieldTypes;
                                         AMainPriority: Integer;
                                         ACompatibleFieldTypes: TLMDGridFieldTypes;
                                         ACompatiblePriority: Integer;
                                         AFieldKinds: TLMDGridFieldKinds;
                                         APaintStyle: TLMDGridChooserBtnStyle);
    class function RegisteredChooserClassesCount: Integer;
    class function GetRegisteredChooserClass(AIndex: Integer): TLMDGridChooserDescr; overload;
    class function GetRegisteredChooserClass(AFieldType: TFieldType;
                                             AFieldKind: TFieldKind): TLMDGridChooserDescr; overload;
    class function GetRegisteredChooserClass(const AChooserName: string): TLMDGridChooserDescr; overload;
    class function GetRegisteredChooserClass(AChooserClass: TClass): TLMDGridChooserDescr; overload;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property ButtonImage: TBitmap read FButtonImage write SetButtonImage;
  end;

  TLMDGridCustomChooser = class(TLMDGridColumnChooser)
  protected
    FValue:       Variant;
    FChooserShow: TLMDGridChooserGetValueEvent;

    procedure SetChooserShow(const Value: TLMDGridChooserGetValueEvent);
    function  GetData(var AKey: Variant; var AValue: Variant): Boolean; override;
    procedure SetData(const AKey: Variant; const AValue: Variant); override;
    function  ShowModal: Boolean; override;
    function  GetChooserKind: TLMDGridChooserKind; override;
    procedure SetFocus; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled default False;
    property OnChooserShow: TLMDGridChooserGetValueEvent read FChooserShow write SetChooserShow;
  end;

  TLMDGridPickListChooser = class(TLMDGridColumnChooser)
  private
    FView:          TCustomListBox;
    FItems:         TStrings;
    FItemHeight:    Integer;
    FDropDownCount: Integer;
    FDefWidth:      Integer;

    procedure SetItems(const Value: TStrings);
    procedure SetItemHeight(const Value: Integer);
    procedure PaintItem(Control: TWinControl; Index: Integer;
                        ARect: TRect; State: TOwnerDrawState);
    procedure SetDropDownCount(const Value: Integer);
    function  CalkHeight: Integer;
  protected
    function  GetData(var AKey: Variant; var AValue: Variant): Boolean; override;
    procedure SetData(const AKey: Variant; const AValue: Variant); override;
    procedure SetFocus; override;
    function  GetLayout: TLMDGridChooserLayout; override;
    function  GetChooserKind: TLMDGridChooserKind; override;
    procedure SetBounds(ARect: TRect); override;
    function  GetControlSize: TSize; override;
    procedure SetControlParent(AParent: TWinControl); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Items: TStrings read FItems write SetItems;
    property ItemHeight: Integer read FItemHeight write SetItemHeight default 18;
    property DropDownCount: Integer read FDropDownCount write SetDropDownCount default 7;
  end;

  TLMDGridCalendarChooser = class(TLMDGridColumnChooser)
  private
    FCalendar:        TLMDCustomCalendar;
    FDefWidth:        Integer;
    FDefHeight:       Integer;
    FHeaderColor:     TColor;
    FHeaderTextColor: TColor;

    function  CreateCalendar(AParent: TWinControl): TLMDCustomCalendar;
    procedure SetHeaderColor(const Value: TColor);
    procedure SetHeaderTextColor(const Value: TColor);
  protected
    function  GetData(var AKey: Variant; var AValue: Variant): Boolean; override;
    procedure SetData(const AKey: Variant; const AValue: Variant); override;
    procedure SetFocus; override;
    function  GetLayout: TLMDGridChooserLayout; override;
    function  GetChooserKind: TLMDGridChooserKind; override;
    procedure SetBounds(ARect: TRect); override;
    function  GetControlSize: TSize; override;
    procedure SetControlParent(AParent: TWinControl); override;
    function  NeedOkButton: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property HeaderColor: TColor read FHeaderColor write SetHeaderColor default $00F2CEB4;
    property HeaderTextColor: TColor read FHeaderTextColor write SetHeaderTextColor default clWindowText;
  end;

  TLMDGridCalculatorChooser = class(TLMDGridColumnChooser)
  private
    FCalculator:   TLMDCustomCalculator;
    FDefWidth:     Integer;
    FDefHeight:    Integer;
    FPrecision:    Integer;
    FDigits:       Integer;
    FDisplayColor: TColor;

    function  CreateCalculator(AParent: TWinControl): TLMDCustomCalculator;
    procedure SetPrecision(const Value: Integer);
    procedure SetDigits(const Value: Integer);
    procedure SetDisplayColor(const Value: TColor);
  protected
    function  GetData(var AKey: Variant; var AValue: Variant): Boolean; override;
    procedure SetData(const AKey: Variant; const AValue: Variant); override;
    procedure SetFocus; override;
    function  GetLayout: TLMDGridChooserLayout; override;
    function  GetChooserKind: TLMDGridChooserKind; override;
    procedure SetBounds(ARect: TRect); override;
    function  GetControlSize: TSize; override;
    procedure SetControlParent(AParent: TWinControl); override;
    function  NeedOkButton: Boolean; override;
    function  CanResize: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Digits: Integer read FDigits write SetDigits default 5;
    property Precision: Integer read FPrecision write SetPrecision default 5;
    property DisplayColor: TColor read FDisplayColor write SetDisplayColor default $00F2CEB4;
  end;

  TLMDGridMemoChooser = class(TLMDGridColumnChooser)
  private
    FMemo:        TCustomMemo;
    FDefWidth:    Integer;
    FDefHeight:   Integer;
    FWantTabs:    Boolean;
    FWantReturns: Boolean;

    function CreateMemo(AParent: TWinControl): TCustomMemo;
  protected
    function  GetData(var AKey: Variant; var AValue: Variant): Boolean; override;
    procedure SetData(const AKey: Variant; const AValue: Variant); override;
    procedure SetFocus; override;
    function  GetLayout: TLMDGridChooserLayout; override;
    function  GetChooserKind: TLMDGridChooserKind; override;
    procedure SetBounds(ARect: TRect); override;
    function  GetControlSize: TSize; override;
    procedure SetControlParent(AParent: TWinControl); override;
    function  NeedOkButton: Boolean; override;
    function  CanResize: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property WantTabs: Boolean read FWantTabs write FWantTabs default True;
    property WantReturns: Boolean read FWantReturns write FWantReturns default True;
  end;

  //== TLMDGridColumn ==========================================================

  TLMDGridColumnClass = class of TLMDGridColumn;

  TLMDGridColumnDescr = class
  public
    ColClass:    TLMDGridColumnClass;
    Description: TLMDString;
    Image:       TBitmap;
    FieldTypes:  TLMDGridFieldTypes;

    destructor Destroy; override;
  end;

  TLMDColSetting  = (csAlignment, csAlignmentV, csReadOnly, csWidth, csFont,
                     csCaption, csVisible, csMinValue, csMaxValue, csMask,
                     csChooserModified);
  TLMDColSettings = set of TLMDColSetting;

  TLMDGridColumnTitle = class(TPersistent)
  private
    FSettings:  TLMDColSettings;
    FFont:      TFont;
    FCaption:   TLMDString;
    FAlignment: TAlignment;
    FColumn:    TLMDGridColumn;
    FVertAlign: TVerticalAlignment;

    function  IsAlignmentStored: Boolean;
    function  IsAlignmentVStored: Boolean;
    function  IsFontStored: Boolean;
    function  IsCaptionStored: Boolean;
    procedure SetAlignment(const Value: TAlignment);
    procedure SetCaption(const Value: TLMDString);
    procedure SetFont(const Value: TFont);
    procedure OnFontChange(ASender: TObject);
    procedure SetVertAlign(const Value: TVerticalAlignment);
    function  GetCaption: TLMDString;
    function  GetAlignment: TAlignment;
    function  GetVertAlign: TVerticalAlignment;
    function  GetFont: TFont;
    procedure RefreshDefaultFont;
  public
    constructor Create(AColumn: TLMDGridColumn);
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
  published
    property Caption: TLMDString read GetCaption write SetCaption stored IsCaptionStored;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
    property Alignment: TAlignment read GetAlignment write SetAlignment stored IsAlignmentStored;
    property VertAlignment: TVerticalAlignment read GetVertAlign write SetVertAlign stored IsAlignmentVStored;
  end;

  TLMDGridCompareFunc          = function(Val1: PVariant;
                                          Val2: PVariant): Integer of object;
  TLMDGridColumnTextParseEvent = procedure(Grid: TObject;
                                           Column: TLMDGridColumn;
                                           var TextValue: TLMDString;
                                           var ResultValue: Variant;
                                           var IsNull: Boolean;
                                           var ParsedOk: Boolean;
                                           PErrMsg: PLMDString;
                                           CanRaiseError: Boolean) of object;
  TLMDGridColumnTextFormatEvent = procedure(Grid: TObject;
                                            Column: TLMDGridColumn;
                                            const CellValue: Variant;
                                            IsNull: Boolean;
                                            var ResultText: TLMDString) of object;

  TLMDGridColumnCanEditEvent = procedure(Grid: TObject; Column: TLMDGridColumn;
                                         var ACanEdit: Boolean) of object;

  TLMDGridColumn = class(TComponent)
  private
    FFont:                    TFont;
    FVisible:                 Boolean;
    FWidth:                   Integer;
    FPosition:                Integer;
    FGrid:                    TLMDCustomGrid;
    FSortKind:                TLMDGridSortKind;
    FSortingAllowed:          Boolean;
    FAlignment:               TAlignment;
    FVertAlign:               TVerticalAlignment;
    FTitle:                   TLMDGridColumnTitle;
    FPaddings:                array [0..3] of Integer;
    FComparer:                TLMDGridCompareFunc;
    FOnFormatEdit:            TLMDGridColumnTextFormatEvent;
    FOnFormatPaint:           TLMDGridColumnTextFormatEvent;
    FOnParse:                 TLMDGridColumnTextParseEvent;
    FFieldName:               string;
    FReadOnly:                Boolean;
    FChooser:                 TLMDGridColumnChooser;
    FAutoColDesignerSelected: Boolean;
    FDummyLookupRoot:         TComponent;
    FFramesUpdating:          Boolean;
    FTmpRoot:                 TComponent;
    FTmpAnc:                  TPersistent;
    FTmpRootAnc:              TComponent;
    FChooserDsgHelper:        TPersistent;
    FColor:                   TColor;
    FAltrernateColor:         TColor;
    FAltrernateLoaded:        Boolean;
    FDefaultColor:            Boolean;
    FAllowUndefinedValue:     Boolean;
    FOnCanEdit:               TLMDGridColumnCanEditEvent;

    procedure BeginUpdate;
    procedure EndUpdate;
    procedure SetVisible(const Value: Boolean);
    procedure SetWidth(const Value: Integer);
    procedure SetPosition(const Value: Integer);
    procedure SetGrid(const Value: TLMDCustomGrid);
    procedure SetSortKind(const Value: TLMDGridSortKind);
    procedure SetAlignment(const Value: TAlignment);
    function  IsFontStored: Boolean;
    function  IsReadOnlyStored: Boolean;
    procedure SetFont(const Value: TFont);
    procedure OnFontChange(ASender: TObject);
    procedure SetTitle(const Value: TLMDGridColumnTitle);
    procedure SetVertAlign(const Value: TVerticalAlignment);
    function  GetPadding(const Index: Integer): Integer;
    procedure SetPadding(const Index, Value: Integer);
    procedure SetFieldName(const Value: string);
    procedure SetReadOnly(const Value: Boolean);
    function  IsAlignmentStored: Boolean;
    function  IsVisibleStored: Boolean;
    function  IsWidthStored: Boolean;
    function  GetReadOnly: Boolean;
    function  GetFont: TFont;
    function  GetAlignment: TAlignment;
    function  GetWidth: Integer;
    function  GetVisible: Boolean;
    procedure RefreshDefaultFont;
    procedure RefreshDefaultColor;
    function  GetDefaultChooserDescr: TLMDGridChooserDescr;
    function  CreateChooser(ADescr: TLMDGridChooserDescr): TLMDGridColumnChooser;
    function  CreateDefChooser: TLMDGridColumnChooser;
    procedure CheckChooserDsc(const ADescr: TLMDGridChooserDescr);
    procedure SetChooserByClass(const Value: TClass);
    procedure SetChooserByDescr(const ADescr: TLMDGridChooserDescr);
    function  GetChooserClass: TClass;
    procedure ChooserPropChanged;
    procedure SetAutoColumnDesignerSelected(AValue: Boolean);
    function  GetAutoColumnDesignerSelected: Boolean;
    function  GetDsgHelper: TPersistent;
    procedure SetDefaultColor(const Value: Boolean);
    procedure SetColor(const Value: TColor);
    function  IsColorStored: Boolean;
    procedure SetAltrernateColor(const Value: TColor);
    function  IsAltrernateColorStored: Boolean;
    procedure SetAllowUndefinedValue(const Value: Boolean);
    procedure SetSortingAllowed(const Value: Boolean);
  protected
    FDefaultDataType: TFieldType;
    FSettings:        TLMDColSettings;
    FEditor:          TControl;

    procedure CheckColumnDataTypeChange;
    procedure RemoveSetting(ASet: TLMDColSetting);
    function  IsValueValid(Value: PVariant; AErrMsg: PLMDString): Boolean; virtual;
    procedure NormalizeValue(ASrcValue, ADestValue: PVariant); virtual;
    procedure Updated; override;
    procedure Loaded; override;
    procedure ReadState(Reader: TReader); override;
    procedure DefineProperties(Filer: TFiler); override;
    function  IsDefaultChooserClass(AClass: TClass): Boolean;
    function  IsDefaultChooserClassName(AClassName: string): Boolean;
    procedure ReadChooser(Reader: TReader);
    procedure WriteChooser(Writer: TWriter);
    procedure DetachEmbeddedEditor;
    function  GetEmbeddedEditor: ILMDGridEmbeddedEdit; virtual; abstract;
    procedure ResetEmbeddedEditor; virtual; abstract;
    procedure PaintCellBG(ACanvas: TCanvas; ADataRow: Integer; ARect: TRect;
                          ACellState: TLMDGridCellStates; AWithFrame: Boolean;
                          APaddingRect: TRect; var ContentRect: TRect); virtual;
    procedure PaintFormattedCellData(ACanvas: TCanvas; ARect: TRect;
                                     const AData: Variant; AAlignment: TAlignment;
                                     ACellState: TLMDGridCellStates); virtual;
    function  CompareColValues(Val1: PVariant;
                               Val2: PVariant): Integer; virtual; abstract;
    function  IsSortingAllowed: Boolean; virtual;
    procedure DefTextOut(ACanvas: TCanvas; ARect: TRect; const S: TLMDString;
                         AAlignment: TAlignment; AWrapWords, AExpandTabs: Boolean;
                         ACellState: TLMDGridCellStates; AStyle: TLMDGridStyle); overload;
    procedure DefTextOut(ACanvas: TCanvas; ARect: TRect; const S: TLMDString;
                         AAlignment: TAlignment; AWrapWords, AExpandTabs: Boolean;
                         AGlyphW: Integer; ACellState: TLMDGridCellStates;
                         AStyle: TLMDGridStyle; var TextR: TRect); overload;
    function ParseEditorData(const AEditData: Variant; ARaiseError: Boolean;
                             PErrMsg: PLMDString; var Res: Variant): Boolean; virtual;
    function FormatEditorData(const AGridData: Variant): Variant; virtual;
    function FormatPaintData(const AGridData: Variant): Variant; virtual;
    function GetColumnCompatDataTypes: TLMDGridFieldTypes; virtual;
    function IsFieldTypeCompatibleWithColSettings(AField: TField;
                                                  PErrMessage: PLMDString): Boolean; virtual;
    procedure CheckInitPropsForField; virtual;
    procedure ResetPaintCache; dynamic;
    function  GetChooserName: string;
    procedure SetChooserName(Value: string);
    function  CanEdit: Boolean; virtual;

    property OnFormatEdit: TLMDGridColumnTextFormatEvent read FOnFormatEdit write FOnFormatEdit;
    property OnFormatPaint: TLMDGridColumnTextFormatEvent read FOnFormatPaint write FOnFormatPaint;
    property OnParse: TLMDGridColumnTextParseEvent read FOnParse write FOnParse;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Assign(ASrc: TPersistent); override;
    procedure SetParentComponent(AParent: TComponent); override;
    function  GetParentComponent: TComponent; override;
    function  HasParent: Boolean; override;

    class procedure RegisterColumnClass(AColClass: TLMDGridColumnClass;
                                        ADescription: TLMDString; AImage: TBitmap;
                                        ADataTypes: TLMDGridFieldTypes);
    class function RegisteredColumnClassesCount: Integer;
    class function GetRegisteredColumnClass(AIndex: Integer): TLMDGridColumnDescr; overload;
    class function GetRegisteredColumnClass(AFieldType: TFieldType): TLMDGridColumnDescr; overload;

    function GetColumnKind: TFieldKind;
    function GetColumnDataType: TFieldType;

    property Grid: TLMDCustomGrid read FGrid write SetGrid;
    property ChooserClass: TClass read GetChooserClass write SetChooserByClass;
    property Chooser: TLMDGridColumnChooser read FChooser;
  published
    property ChooserName: string read GetChooserName write SetChooserName stored False;
    property FieldName: string read FFieldName write SetFieldName;
    property Visible: Boolean read GetVisible write SetVisible stored IsVisibleStored;
    property Width: Integer read GetWidth write SetWidth stored IsWidthStored;
    property Position: Integer read FPosition write SetPosition default -1;
    property SortKind: TLMDGridSortKind read FSortKind write SetSortKind default skNone;
    property SortingAllowed: Boolean read FSortingAllowed write SetSortingAllowed default True;
    property Alignment: TAlignment read GetAlignment write SetAlignment stored IsAlignmentStored;
    property VertAlignment: TVerticalAlignment read FVertAlign write SetVertAlign default taVerticalCenter;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
    property Title: TLMDGridColumnTitle read FTitle write SetTitle;
    property Comparer: TLMDGridCompareFunc read FComparer write FComparer;
    property ReadOnly: Boolean read GetReadOnly write  SetReadOnly stored IsReadOnlyStored;
    property PaddingLeft: Integer index 0 read GetPadding write SetPadding default 3;
    property PaddingRight: Integer index 1 read GetPadding write SetPadding default 3;
    property PaddingTop: Integer index 2 read GetPadding write SetPadding default 3;
    property PaddingBottom: Integer index 3 read GetPadding write SetPadding default 3;
    property DsgHelper: TPersistent read GetDsgHelper stored False;
    property Color: TColor read FColor write SetColor stored IsColorStored;
    property DefaultColor: Boolean read FDefaultColor write SetDefaultColor default True;
    property AltrernateColor: TColor read FAltrernateColor write SetAltrernateColor stored IsAltrernateColorStored;
    property AllowUndefinedValue: Boolean read FAllowUndefinedValue write SetAllowUndefinedValue default True;
    property OnCanEdit: TLMDGridColumnCanEditEvent read FOnCanEdit write FOnCanEdit;
  end;

  TLMDGridColumns = class(TPersistent)
  private
    FGrid: TLMDCustomGrid;
    FCols: TObjectList;

    function  GetCount: Integer;
    function  GetItem(AIndex: Integer): TLMDGridColumn;
    procedure AddColLow(ACol: TLMDGridColumn);
    procedure RemoveColLow(ACol: TLMDGridColumn);
    procedure UpdateColPositions;
  public
    constructor Create(AGrid: TLMDCustomGrid);
    destructor Destroy; override;

    procedure Add(ACol: TLMDGridColumn);
    procedure Remove(ACol: TLMDGridColumn); overload;
    procedure Clear;
    function  HaveCol(ACol: TLMDGridColumn): Boolean;
    property  ParentGrid: TLMDCustomGrid read FGrid;
    property  Count: Integer read GetCount;
    property  Items[AIndex: Integer]: TLMDGridColumn read GetItem; default;
  end;

  TLMDGridMaskedReturnKind = (rkMasked, rkUnmasked, rmMaskedTrim);
  TLMDGridTextColumn = class(TLMDGridColumn)
  private
    FMask:                 TEditMask;
    FMaskedTextReturnKind: TLMDGridMaskedReturnKind;
    FFormatPaintByMask:    Boolean;
    FWordWrap:             Boolean;

    function  VarToStr(const V: Variant): TLMDString;
    function  GetMask: TEditMask;
    function  IsMaskStored: Boolean;
    procedure SetMask(const Value: TEditMask);
    procedure InitEditor;
    procedure SetFormatPaintByMask(const Value: Boolean);
    procedure SetWordWrap(const Value: Boolean);
  protected
    procedure NormalizeValue(ASrcValue, ADestValue: PVariant); override;
    function  CompareColValues(Val1: PVariant; Val2: PVariant): Integer; override;
    procedure PaintFormattedCellData(ACanvas: TCanvas; ARect: TRect;
                                     const AData: Variant; AAlignment: TAlignment;
                                     ACellState: TLMDGridCellStates); override;
    function  FormatPaintData(const AGridData: Variant): Variant; override;
    function  FormatEditorData(const AGridData: Variant): Variant; override;
    function  ParseEditorData(const AEditData: Variant; ARaiseError: Boolean;
                              PErrMsg: PLMDString; var Res: Variant): Boolean; override;
    function  GetEmbeddedEditor: ILMDGridEmbeddedEdit; override;
    procedure ResetEmbeddedEditor; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Mask: TEditMask read GetMask write SetMask stored IsMaskStored;
    property MaskedTextReturnKind: TLMDGridMaskedReturnKind read FMaskedTextReturnKind write FMaskedTextReturnKind default rmMaskedTrim;
    property FormatPaintByMask: Boolean read FFormatPaintByMask write SetFormatPaintByMask default False;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default True;
    property OnFormatEdit;
    property OnFormatPaint;
    property OnParse;
  end;

  TLMDGridIntegerColumn = class(TLMDGridColumn)
  private
    FStep:       Integer;
    FLargeStep:  Integer;
    FMinValue:   Integer;
    FMaxValue:   Integer;
    FShowButtons: Boolean;

    function  VarToIntDef(V: PVariant): Integer;
    procedure SetInteger(const Index, Value: Integer);
    procedure InitEditor;
    function  IsValueStored(const Index: Integer): Boolean;
    function  GetInteger(const Index: Integer): Integer;
    function  GetField: TIntegerField;
    procedure SetShowButtons(const Value: Boolean);
  protected
    function  ParseEditorData(const AEditData: Variant; ARaiseError: Boolean;
                              PErrMsg: PLMDString; var Res: Variant): Boolean; override;
    function  CompareColValues(Val1: PVariant; Val2: PVariant): Integer; override;
    procedure NormalizeValue(ASrcValue, ADestValue: PVariant); override;
    procedure PaintFormattedCellData(ACanvas: TCanvas; ARect: TRect;
                                     const AData: Variant; AAlignment: TAlignment;
                                     ACellState: TLMDGridCellStates); override;
    function  GetEmbeddedEditor: ILMDGridEmbeddedEdit; override;
    procedure ResetEmbeddedEditor; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Step: Integer index 0 read GetInteger write SetInteger default 1;
    property LargeStep: Integer index 1 read GetInteger write SetInteger default 10;
    property MinValue: Integer index 2 read GetInteger write SetInteger stored IsValueStored;
    property MaxValue: Integer index 3 read GetInteger write SetInteger stored IsValueStored;
    property ShowButtons: Boolean read FShowButtons write SetShowButtons default True;
    property OnFormatEdit;
    property OnFormatPaint;
    property OnParse;
  end;

  TLMDGridSpinColumn = class(TLMDGridIntegerColumn); // Deprecated.

  TLMDGridDateColumn = class(TLMDGridColumn)
  private
    FDateFormat: string;

    function  VarToDateDef(V: PVariant): TDateTime;
    procedure SetDateFormat(const Value: string);
    procedure InitEditor;
    procedure FormatGen(const AGridData: Variant; var Res: TLMDString;
                        var IsNull: Boolean);
  protected
    function  ParseEditorData(const AEditData: Variant; ARaiseError: Boolean;
                              PErrMsg: PLMDString; var Res: Variant): Boolean; override;
    function  FormatEditorData(const AGridData: Variant): Variant; override;
    function  FormatPaintData(const AGridData: Variant): Variant; override;
    function  CompareColValues(Val1: PVariant; Val2: PVariant): Integer; override;
    procedure NormalizeValue(ASrcValue, ADestValue: PVariant); override;
    procedure PaintFormattedCellData(ACanvas: TCanvas; ARect: TRect;
                                     const AData: Variant; AAlignment: TAlignment;
                                     ACellState: TLMDGridCellStates); override;
    function  GetEmbeddedEditor: ILMDGridEmbeddedEdit; override;
    procedure ResetEmbeddedEditor; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property DateFormat: string read FDateFormat write SetDateFormat;
    property OnFormatEdit;
    property OnFormatPaint;
    property OnParse;
  end;

  TLMDGridFloatColumn = class(TLMDGridColumn)
  private
    FPrecision:      Integer;
    FDigits:         Integer;
    FFloatFormat:    string;
    FIsCurrencyMode: Boolean;
    FCurrencyString: string;

    function  VarToFloatDef(V: PVariant): Double;
    procedure InitEditor;
    procedure SetDigits(Value: Integer);
    procedure SetPrecision(Value: Integer);
    procedure SetFloatFormat(const Value: string);
    procedure FormatGen(const AGridData: Variant; var Res: TLMDString;
                        var IsNull: Boolean; AForEdit: Boolean);
    procedure SetIsCurrencyMode(const Value: Boolean);
    procedure SetCurrencyString(const Value: string);
  protected
    procedure CheckInitPropsForField; override;
    function  ParseEditorData(const AEditData: Variant; ARaiseError: Boolean;
                              PErrMsg: PLMDString; var Res: Variant): Boolean; override;
    function  FormatEditorData(const AGridData: Variant): Variant; override;
    function  FormatPaintData(const AGridData: Variant): Variant; override;
    function  CompareColValues(Val1: PVariant; Val2: PVariant): Integer; override;
    procedure NormalizeValue(ASrcValue, ADestValue: PVariant); override;
    procedure PaintFormattedCellData(ACanvas: TCanvas; ARect: TRect;
                                     const AData: Variant; AAlignment: TAlignment;
                                     ACellState: TLMDGridCellStates); override;
    function  GetEmbeddedEditor: ILMDGridEmbeddedEdit; override;
    procedure ResetEmbeddedEditor; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Precision: Integer read FPrecision write SetPrecision default 5;
    property Digits: Integer read FDigits write SetDigits default 5;
    property FloatFormat: string read FFloatFormat write SetFloatFormat;
    property IsCurrencyMode: Boolean read FIsCurrencyMode write SetIsCurrencyMode;
    property CurrencyString: string read FCurrencyString write SetCurrencyString;
    property OnFormatEdit;
    property OnFormatPaint;
    property OnParse;
  end;

  TLMDGridCheckBoxColumn   = class;
  TLMDGridCheckBoxDataType = (dtBoolean, dtString, dtInteger);
  TLMDGridCheckBoxColumnSP = (spCheckedValue, spUncheckedValue, spUndefinedValue,
                              spCheckedDescr, spUncheckedDescr, spUndefinedDescr);

  TStringPropsArr = array[Low(TLMDGridCheckBoxColumnSP)..
                          High(TLMDGridCheckBoxColumnSP)] of TLMDString;

  TLMDGridCheckBoxStateValues = class(TPersistent)
  private
    FCol: TLMDGridCheckBoxColumn;

    function  GetStrProp(const Index: Integer): TLMDString;
    procedure SetStrProp(const Index: Integer; const Value: TLMDString);
    function  IsStrPropStored(const Index: Integer): Boolean;
  public
    constructor Create(ACol: TLMDGridCheckBoxColumn);
    procedure   Assign(Source: TPersistent); override;
  published
    property CheckedValue: TLMDString index spCheckedValue read GetStrProp write SetStrProp stored IsStrPropStored;
    property UncheckedValue: TLMDString index spUncheckedValue read GetStrProp write SetStrProp stored IsStrPropStored;
    property UndefinedValue: TLMDString index spUndefinedValue read GetStrProp write SetStrProp stored IsStrPropStored;
    property CheckedDescr: TLMDString index spCheckedDescr read GetStrProp write SetStrProp stored IsStrPropStored;
    property UncheckedDescr: TLMDString index spUncheckedDescr read GetStrProp write SetStrProp stored IsStrPropStored;
    property UndefinedDescr: TLMDString index spUndefinedDescr read GetStrProp write SetStrProp stored IsStrPropStored;
  end;

  TLMDGridCheckBoxInfo = record
    Width:  Integer;
    Height: Integer;
    Flags:  Integer;
  end;

  TLMDGridCheckBoxColumn = class(TLMDGridColumn)
  private
    FStringProps:         TStringPropsArr;
    FDefStringProps:      TStringPropsArr;
    FDataType:            TLMDGridCheckBoxDataType;
    FStateValues:         TLMDGridCheckBoxStateValues;
    FDrawCB:              Boolean;
    FDrawDescr:           Boolean;
    FDrawGrayed:          Boolean;

    function  GetCheckBoxInfo(ACanvas: TCanvas; AState: TCheckBoxState; APressed,
                              AHot: Boolean; AUseTheme: TLMDThemeMode): TLMDGridCheckBoxInfo;
    procedure PaintCheckBox(ACanvas: TCanvas; const P: TPoint;
                            AUseTheme: TLMDThemeMode;
                            const AInfo: TLMDGridCheckBoxInfo);

    procedure SetDataType(const Value: TLMDGridCheckBoxDataType);
    function  IsStrPropStored(const Index: TLMDGridCheckBoxColumnSP): Boolean;
    function  GetStrProp(const Index: TLMDGridCheckBoxColumnSP): TLMDString;
    procedure SetStrProp(const Index: TLMDGridCheckBoxColumnSP;
                         const Value: TLMDString);
    procedure BeginUpdate;
    procedure EndUpdate(ADataTypeChanged: Boolean);
    procedure SetStateValues(const Value: TLMDGridCheckBoxStateValues);
    procedure SetDrawCB(const Value: Boolean);
    procedure SetDrawDescr(const Value: Boolean);
    function  FieldDataTypeToColDataType(ADataType: TFieldType): TLMDGridCheckBoxDataType;
    procedure SetDrawGrayed(const Value: Boolean);
  protected
    function  CompareColValues(Val1: PVariant; Val2: PVariant): Integer; override;
    function  IsValueValid(Value: PVariant; AErrMsg: PLMDString): Boolean; override;
    procedure NormalizeValue(ASrcValue, ADestValue: PVariant); override;
    procedure PaintFormattedCellData(ACanvas: TCanvas; ARect: TRect;
                                     const AData: Variant; AAlignment: TAlignment;
                                     ACellState: TLMDGridCellStates); override;
    function  GetEmbeddedEditor: ILMDGridEmbeddedEdit; override;
    procedure ResetEmbeddedEditor; override;
    function  IsFieldTypeCompatibleWithColSettings(AField: TField;
                                                   PErrMessage: PLMDString): Boolean; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadDescrsEmpty(Reader: TReader);
    function  GetDescrsEmpty(const ADescrs: TStringPropsArr): string;
    procedure WriteDescrsEmpty(Writer: TWriter);
    procedure CheckInitPropsForField; override;
    procedure InitDefValues;
    procedure SetDefValues(ASetDescr: Boolean);
    procedure CheckGridEmpty;
    procedure CheckStrForState(const AStr: TLMDString);
    function  StrToVar(const AStr: TLMDString): Variant;
    function  VarToStr(AVar: PVariant): TLMDString;
    function  StateToStr(AState: TCheckBoxState): TLMDString;
    function  StrToState(const AStr: TLMDString): TCheckBoxState;
    function  StateToDescr(AState: TCheckBoxState): TLMDString;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Alignment default Classes.taCenter;
    property DataType: TLMDGridCheckBoxDataType read FDataType write SetDataType default dtBoolean;
    property StateValues: TLMDGridCheckBoxStateValues read FStateValues write SetStateValues;
    property DrawCheckBox: Boolean read FDrawCB write SetDrawCB default True;
    property DrawDescription: Boolean read FDrawDescr write SetDrawDescr default False;
    property DrawGrayed: Boolean read FDrawGrayed write SetDrawGrayed default False;
  end;

  TLMDGridImageColumn = class(TLMDGridColumn)
  private
    FImages:          TCustomImageList;
    FEmptyImageIndex: TImageIndex;

    function  VarToIntDef(V: PVariant): Integer;
    procedure SetImages(const Value: TCustomImageList);
    procedure SetEmptyImageIndex(const Value: TImageIndex);
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    function  CompareColValues(Val1: PVariant; Val2: PVariant): Integer; override;
    procedure NormalizeValue(ASrcValue, ADestValue: PVariant); override;
    procedure PaintFormattedCellData(ACanvas: TCanvas; ARect: TRect;
                                     const AData: Variant; AAlignment: TAlignment;
                                     ACellState: TLMDGridCellStates); override;
    function  GetEmbeddedEditor: ILMDGridEmbeddedEdit; override;
    procedure ResetEmbeddedEditor; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Alignment default Classes.taCenter;
    property Images: TCustomImageList read FImages write SetImages;
    property EmptyImageIndex: TImageIndex read FEmptyImageIndex write SetEmptyImageIndex default -1;
  end;

  TLMDGridRatingLayout = record
    Left:       Integer;
    ItemWidth:  Integer;
    ItemCount:  Integer;
  end;

  TLMDGridRatingColumn = class(TLMDGridColumn)
  private
    FGlyph:               TPicture;
    FMaxRating:           Integer;
    FEmptyGlyph:          TPicture;
    FTransparent:         Boolean;
    FLastDrawn:           TLMDGridRatingLayout;

    procedure GlyphsChanged(Sender: TObject);
    procedure UpdateTransparent;
    procedure SetGlyph(const Value: TPicture);
    procedure SetEmptyGlyph(const Value: TPicture);
    procedure SetMaxRating(const Value: Integer);
    procedure SetTransparent(const Value: Boolean);
  protected
    function  CompareColValues(Val1: PVariant; Val2: PVariant): Integer; override;
    procedure NormalizeValue(ASrcValue, ADestValue: PVariant); override;
    procedure PaintFormattedCellData(ACanvas: TCanvas; ARect: TRect;
                                     const AData: Variant; AAlignment: TAlignment;
                                     ACellState: TLMDGridCellStates); override;
    function  GetEmbeddedEditor: ILMDGridEmbeddedEdit; override;
    procedure ResetEmbeddedEditor; override;
    function  VarToRating(AVar: PVariant; out AIsNull: Boolean): Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Glyph: TPicture read FGlyph write SetGlyph;
    property EmptyGlyph: TPicture read FEmptyGlyph write SetEmptyGlyph;
    property MaxRating: Integer read FMaxRating write SetMaxRating default 5;
    property Transparent: Boolean read FTransparent write SetTransparent default True;
  end;

  TLMDGridProgressLayout = record
    Content: TRect;
  end;

  TLMDGridProgressColumn = class(TLMDGridColumn)
  private
    FMinValue:            Integer;
    FMaxValue:            Integer;
    FBarHeight:           Integer;
    FBarWidth:            Integer;
    FBarBorderColor:      TColor;
    FBarColor:            TColor;
    FChunkColor:          TColor;
    FLastDrawn:           TLMDGridProgressLayout;

    procedure SetMaxValue(const Value: Integer);
    procedure SetMinValue(const Value: Integer);
    procedure SetBarHeight(const Value: Integer);
    procedure SetBarWidth(const Value: Integer);
    procedure SetBarBorderColor(const Value: TColor);
    procedure SetBarColor(const Value: TColor);
    procedure SetChunkColor(const Value: TColor);
  protected
    function  CompareColValues(Val1: PVariant; Val2: PVariant): Integer; override;
    procedure NormalizeValue(ASrcValue, ADestValue: PVariant); override;
    procedure PaintFormattedCellData(ACanvas: TCanvas; ARect: TRect;
                                     const AData: Variant; AAlignment: TAlignment;
                                     ACellState: TLMDGridCellStates); override;
    function  GetEmbeddedEditor: ILMDGridEmbeddedEdit; override;
    procedure ResetEmbeddedEditor; override;
    function  VarToProgress(AVar: PVariant; out AIsNull: Boolean): Integer;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Alignment default Classes.taCenter;
    property MinValue: Integer read FMinValue write SetMinValue default 0;
    property MaxValue: Integer read FMaxValue write SetMaxValue default 100;
    property BarWidth: Integer read FBarWidth write SetBarWidth default -1;
    property BarHeight: Integer read FBarHeight write SetBarHeight default 12;
    property BarColor: TColor read FBarColor write SetBarColor default clWindow;
    property BarBorderColor: TColor read FBarBorderColor write SetBarBorderColor default clBtnShadow;
    property ChunkColor: TColor read FChunkColor write SetChunkColor default clHighlight;
  end;

  //== TLMDCustomGrid ==========================================================

   TLMDGridOption = (opHeaderVertLine, opIndicatorHorzLine, opVertLine,
                    opHorzLine, opRangeSelect, opRowSelect, opDrawFocusSelected,
                    opRowSizing, opColSizing, opRowMoving, opColMoving, opEditing,
                    opTabs, opAlwaysShowEditor, opThumbTracking, opShowIndicator,
                    opShowHeader, opConfirmDeleteRow, opCancelOnExit,
                    opHighlightHeaders, opShowEmptyBanner, opShowColumnsChooser);
  TLMDGridOptions = set of TLMDGridOption;

  TLMDGridInternalState  = (isHaveVisibleCols, isHaveVisibleRows, isDestroing,
                            isEditing, isColSizing, isRowSizing, isColMoving,
                            isRowMoving, isSelExtending, isBlockPressedMouseAct,
                            isNewRecord, isRowEdit, isRowEditChanged,
                            isInplaceEditChanged, isInplaceEditHiding,
                            isWasEditorShown, isNeedRestoreEditor,
                            isNeedFullRepaint, isNoClick);
  TLMDGridInternalStates = set of TLMDGridInternalState;
  TLMDGridScrollDir      = (sdUp, sdDown, sdLeft, sdRight, sdUpLeft, sdUpRight,
                            sdDownLeft, sdDownRight, sdNone);
  TLMDGridImage          = (giIndicatorCurrent, giIndicatorEditing,
                            giIndicatorNewRow, giDropArrowColumn,
                            giDropArrowRow, giSortArrowAsc, giSortArrowDesc,
                            giChooserButton, giColumnsChoose);
  TLMDGridChangeFlag     = (cfCurrent, cfTopLeft);
  TLMDGridChangeFlags    = set of TLMDGridChangeFlag;

  TLMDGridStyle = class(TPersistent)
  private
    FGrid:              TLMDCustomGrid;
    FColors:            array[0..10] of TColor;
    FImages:            array[Low(TLMDGridImage)..High(TLMDGridImage)] of TBitmap;
    FIndicatorWidth:    Integer;
    FHeaderRowHeight:   Integer;
    FEmptyBannerFont:   TFont;
    FEmptyBanner:       TLMDString;

    function  GetColor(const Index: Integer): TColor;
    procedure SetColor(const Index: Integer; const Value: TColor);
    function  GetImg(const Index: Integer): TBitmap;
    procedure SetImg(const Index: Integer; const Value: TBitmap);
    procedure ObjChanged(Sender: TObject);
    procedure SetHeaderRowHeight(const Value: Integer);
    procedure SetIndicatorWidth(const Value: Integer);
    procedure SetEmptyBanner(const Value: TLMDString);
    procedure SetEmptyBannerFont(const Value: TFont);
  public
    constructor Create(AGrid: TLMDCustomGrid);
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure EndUpdate;
  published
    property SortArrowColor: TColor index 0 read GetColor write SetColor default clBtnShadow;
    property HeaderBgColor: TColor index 1 read GetColor write SetColor default clBtnFace;
    property HeaderHighlightColor: TColor index 2 read GetColor write SetColor default clBtnHighlight;
    property HeaderMovingColor: TColor index 8 read GetColor write SetColor default clBtnShadow;
    property IndicatorBgColor: TColor index 3 read GetColor write SetColor default clBtnFace;
    property CellBgColor: TColor index 4 read GetColor write SetColor default clWindow;
    property AlternateBgColor: TColor index 10 read GetColor write SetColor default clWindow;
    property SelectedCellBgColor: TColor index 5 read GetColor write SetColor default clHighlight;
    property SelectedCellTextColor: TColor index 6 read GetColor write SetColor default clHighlightText;
    property SelectBorderColor: TColor index 9 read GetColor write SetColor default clNone;
    property CellGridLinesColor: TColor index 7 read GetColor write SetColor default clBtnFace;
    property IndicatorCurrentImg: TBitmap index Integer(giIndicatorCurrent) read GetImg write SetImg;
    property IndicatorEditingImg: TBitmap index Integer(giIndicatorEditing) read GetImg write SetImg;
    property IndicatorNewRowImg: TBitmap index Integer(giIndicatorNewRow) read GetImg write SetImg;
    property DropArrowColumnImg: TBitmap index Integer(giDropArrowColumn) read GetImg write SetImg;
    property DropArrowRowImg: TBitmap index Integer(giDropArrowRow) read GetImg write SetImg;
    property SortArrowAscImg: TBitmap index Integer(giSortArrowAsc) read GetImg write SetImg;
    property SortArrowDescImg: TBitmap index Integer(giSortArrowDesc) read GetImg write SetImg;
    property ChooserButtonImg: TBitmap index Integer(giChooserButton) read GetImg write SetImg;
    property ChooseColumnsImg: TBitmap index Integer(giColumnsChoose) read GetImg write SetImg;
    property IndicatorColWidth: Integer read FIndicatorWidth write SetIndicatorWidth default 10;
    property HeaderRowHeight: Integer read FHeaderRowHeight write SetHeaderRowHeight default 20;
    property EmptyBanner: TLMDString read FEmptyBanner write SetEmptyBanner;
    property EmptyBannerFont: TFont read FEmptyBannerFont write SetEmptyBannerFont;
  end;

  TLMDGridColumnNameSetCallback = procedure(ACol: TLMDGridColumn) of object;

  TKeyPressWEvent = procedure(Sender: TObject;
                              var Key: TLMDChar) of object;

  TLMDGridChangeEvent = procedure(Sender: TObject;
                                  AChangedFlags: TLMDGridChangeFlags) of object;

  TLMDGridGetCellColorEvent = procedure(Sender: TObject;
                                        ACellState: TLMDGridCellStates;
                                        ARowState: TLMDGridRowState;
                                        const AData: Variant;
                                        AColumn: TLMDGridColumn;
                                        ARow: Integer;
                                        var AColor: TColor) of object;

  TLMDGridDrawDataCellEvent = procedure(Sender: TObject;
                                        ACanvas: TCanvas;
                                        const ARect: TRect;
                                        ACellState: TLMDGridCellStates;
                                        ARowState: TLMDGridRowState;
                                        const AData: Variant;
                                        const AFormattedData: Variant;
                                        AColumn: TLMDGridColumn;
                                        ARow: Integer) of object;

  TLMDGridDrawHeaderCellEvent = procedure(Sender: TObject;
                                          ACanvas: TCanvas;
                                          const ARect: TRect;
                                          ACellState: TLMDGridCellStates;
                                          var ACaption: TLMDString;
                                          AIsDummyHeader: Boolean;
                                          AColumn: TLMDGridColumn) of object;

  TLMDGridDrawIndicatorEvent = procedure(Sender: TObject;
                                         ACanvas: TCanvas;
                                         const ARect: TRect;
                                         ACellState: TLMDGridCellStates;
                                         ARowState: TLMDGridRowState;
                                         ARow: Integer) of object;

  TLMDGridDelRowEvent = procedure(Sender: TObject; Row: Integer;
                                  var DoDelete: Boolean;
                                  var BeepIfDisagree: Boolean) of object;

  TLMDGridPaintEmptyBannerEvent = procedure(Sender: TObject; ACanvas: TCanvas;
                                            ARect: TRect) of object;

  TLMDCustomGrid = class(TCustomGrid, ILMDComponent)
  private
    FAbout:            TLMDAboutVar;
    FEditHelper:       TLMDGridEditParentHelper;
    FStore:            TObject;
    FUpdateCnt:        Integer;
    FInternalCnt:      Integer;
    FSetColDefModeCnt: Integer;
    FInitColModeCnt:   Integer;
    FState:            TLMDGridInternalStates;
    FChangeFlags:      TLMDGridChangeFlags;
    FHoverCell:        TGridCoord;
    FColumns:          TLMDGridColumns;
    FStyle:            TLMDGridStyle;
    FThemeMode:        TLMDThemeMode;
    FThemeGlobalMode:  Boolean;
    FMouseDownPt:      TPoint;
    FMouseMovePt:      TPoint;
    FOptions:          TLMDGridOptions;
    FCellBmp:          Graphics.TBitmap;
    FMovingBmp:        Graphics.TBitmap;
    FEditPanel:        TControl;
    FSizeMoveIdx:      Integer;
    FMoveOffset:       TPoint;
    FMoveDropIdx:      Integer;
    FSizingNewSize:    Integer;
    FMoveSizeTimer:    TTimer;
    FMoveSizeTimerDir: TLMDGridScrollDir;
    FSelectionAnchor:  TPoint;
    FBeforeRowDelete:  TLMDGridDelRowEvent;
    FPaintEmptyBanner: TLMDGridPaintEmptyBannerEvent;
    FColumnsVisible:   TLMDGridBoolArray;
    FColumnsReadOnly:  TLMDGridBoolArray;
    FOnKeyPressW:      TKeyPressWEvent;
    FOnChange:         TLMDGridChangeEvent;
    FOnGetCellColor:   TLMDGridGetCellColorEvent;
    FOnDrawDataCell:   TLMDGridDrawDataCellEvent;
    FOnDrawHeaderCell: TLMDGridDrawHeaderCellEvent;
    FOnDrawIndicator:  TLMDGridDrawIndicatorEvent;
    FOldCol:           Integer;
    FOldRow:           Integer;
    FOldTop:           Integer;
    FOldLeft:          Integer;
    FCustomSource:     TLMDGridCustomSource;
    FScrollBarsStyle:  TScrollStyle;

    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
    procedure WMThemeChanged (var Msg : TMessage); message WM_THEMECHANGED;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMChar(var Msg: TWMChar); message WM_CHAR;
    procedure WMCancelMode(var Msg: TWMCancelMode); message WM_CANCELMODE;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMCancelMode(var Msg: TCMCancelMode); message CM_CANCELMODE;
    procedure HidePopupMessage(var Msg: TMessage); message HIDEPOPUP_MESSAGE;
    function  IsActiveControl: Boolean;
    procedure SetThemeGlobalMode(const Value: Boolean);
    procedure SetThemeMode(const Value: TLMDThemeMode);
    function  GetCurrentColumn: Integer;
    function  GetCurrentRow: Integer;
    procedure SetCurrentColumn(const ACol: Integer);
    procedure SetCurrentRow(const ARow: Integer);
    function  IsInteractiveState: Boolean;
    function  NoMovingSizingState: Boolean;
    function  MovingState: Boolean;
    function  SizingState: Boolean;
    procedure SetIndicatorHeaderOptionsLow(AShowIndicator, AShowHeaders,
                                           AShowIndicatorOld, AShowHeadersOld: Boolean);
    procedure SetBaseOptions(const Value: TLMDGridOptions);
    procedure SetOptions(const Value: TLMDGridOptions);
    procedure ResetHoverCell;
    procedure InvalidateBySelectCell(ANewCol, ANewRow: Integer); overload;
    procedure InvalidateIndicator(ARow: Integer = -1);
    procedure InvalidateMovingPt(OldX, OldY, X, Y: Integer);
    function  GetMoveDropIndex(X, Y: Integer; AColMoving: Boolean): Integer;
    function  GetMoveDropRect(AIndex: Integer; AColMoving: Boolean): TRect;
    procedure OnMoveSizeTimer(ASender: TObject);
    procedure OnFontChange(ASender: TObject);
    procedure DoThemeChanged;
    function  GetMouseSizingState(X, Y: Integer; var SizingIdx: Integer): TLMDGridInternalStates;
    procedure ExitFromSizingMoving(ACancelMoveSize: Boolean; X, Y: Integer);
    procedure SetStyle(const Value: TLMDGridStyle);
    procedure FillColumnsChooseMenu(AMenu: TPopupMenu);
    procedure OnColumnsMenuClick(Sender: TObject);
    procedure SetDataCell(ACol, ARow: Integer; const Value: Variant);
    function  GetDataCell(ACol, ARow: Integer): Variant;
    procedure SetDataCellLow(ACol, ARow: Integer; const Key: Variant;
                             const Value: Variant);
    procedure GetDataCellLow(ACol, ARow: Integer; var Key: Variant;
                             var Value: Variant);
    procedure OnDesignSelectonChanged(ASender: TObject);
    procedure SelectAutoColumn(ACol: TLMDGridColumn; ADoAdd: Boolean);
    function  HaveSelectedAutoColumns: Boolean;
    procedure SetCustomSource(const Value: TLMDGridCustomSource);
    procedure SetScrollBarsStyle(const Value: TScrollStyle);
    function IsOptionsStored: Boolean;
  protected
    { ILMDComponent }

    function getLMDPackage: TLMDPackageID;
  protected
    function DesignWndProc(var Message: TMessage): Boolean; override;
    function  IsUpdating: Boolean;
    function  HaveVisibleData: Boolean;
    function  HaveVisibleCols: Boolean;
    function  HaveRows: Boolean;
    procedure EnterInitMode;
    procedure ExitInitMode;
    function  InInitMode: Boolean;

    // Columns synchronization.

    procedure RebuildColsSaved;
    procedure CheckDataLayoutChange;
    function  IsSortingAllowed(ACol: TLMDGridColumn): Boolean;

    // States.

    procedure IncludeState(AState: TLMDGridInternalState);
    procedure ExcludeState(AState: TLMDGridInternalState);  overload;
    procedure ExcludeState(AState: TLMDGridInternalStates); overload;
    procedure IncludeChange(AChange: TLMDGridChangeFlag);
    procedure ScrollToCurrent;

    // Utilites for inplace editors.

    procedure ED_WMGetDlgCode(const Ed: ILMDGridEmbeddedEdit; var Message: TWMGetDlgCode);
    function  ED_WndProc(const Edit: ILMDGridEmbeddedEdit; var Message: TMessage): Boolean;
    procedure ED_KeyDown(var Key: Word; Shift: TShiftState; APreprocess: Boolean;
                         Source: TLMDGridKeyProcessSource);
    procedure ED_EditorChanged;
    function  ED_IsEditorChanged: Boolean;
    function  ED_DoMouseWheelDown(Shift: TShiftState): Boolean;
    function  ED_DoMouseWheelUp(Shift: TShiftState): Boolean;

    function  GetInplaceEditRect: TRect;
    function  ShowInplaceEditor: Boolean; overload;
    function  ShowInplaceEditor(const AInput: TLMDGridFirstInput): Boolean; overload;
    procedure HideInplaceEditor(ACommitData, AReturnFocus: Boolean);
    procedure HidePopupChooserDelayed;
    procedure UpdateInplaceEditState;
    procedure ReFocusInplaceEditor(AFocusFrom: HWND);
    procedure InplaceEditDoCancelMode(ASender: TControl);

    // Keys and mouse.

    procedure KeyDownLow(var Key: Word; Shift: TShiftState;
                         Source: TLMDGridKeyProcessSource);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyPressW(var Key: TLMDChar); virtual;
    procedure DoKeyPressW(var AMsg: TWMKey);
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Click; override;

    // Hacks on TGustomGrid.

    function  SelectCell(ACol, ARow: Longint): Boolean; override;
    function  CanEditShow: Boolean; override;
    procedure CreateParams(var Params: TCreateParams); override;
    function  CreateEditor: TInplaceEdit; override;
    procedure Resize; override;
    procedure CreateWnd; override;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure RowHeightsChanged; override;
    function  DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function  DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;

    // Data set operations.

    procedure InternalDeleteDataRow(ARow: Integer; var CorrIndex: Integer); virtual;
    procedure InternalDataSourceSort(AColumn: TLMDGridColumn; Value: TLMDGridSortKind;
                                     var ACorrectIdx: Integer); virtual;
    procedure InternalSetDataCell(ACol, ARow: Integer; Key, Value: PVariant;
                                  ABlockSort: Boolean; out NewRow: Integer); virtual;
    procedure InternalGetDataCell(ACol, ARow: Integer; Key, Value: PVariant); virtual;
    function InternalDataSourceCanSort: Boolean; virtual;

    // Column related.

    procedure GetAvailableColumnFieldNames(ACol: TLMDGridColumn; AList: TStrings); virtual;
    function  GetColumnField(AColumn: TLMDGridColumn): TField; virtual;
    function  GetColumnFieldKey(AColumn: TLMDGridColumn): TField; virtual;
    function  GetDefaultColumnCaption(AColumn: TLMDGridColumn): TLMDString; virtual;
    function  GetDefaultColumnAlignment(AColumn: TLMDGridColumn): TAlignment; virtual;
    function  GetDefaultColumnVisible(AColumn: TLMDGridColumn): Boolean; virtual;
    function  GetDefaultColumnReadOnly(AColumn: TLMDGridColumn): Boolean; virtual;
    function  GetDefaultColumnWidth(AColumn: TLMDGridColumn): Integer; virtual;
    procedure ResetColumnsPaintCache;

    // Auto columns mode.

    function  GetAutoColumnsMode: Boolean; virtual;
    procedure SetAutoColumnsMode(AMode: Boolean); virtual;
    function  CanFillColumnsFromStore: Boolean; virtual;
    procedure FillColumnsFromStore(ANameSetProc: TLMDGridColumnNameSetCallback); virtual;
    procedure ColumnAdding(AColumn: TLMDGridColumn); virtual;
    procedure ColumnAdded(AColumn: TLMDGridColumn); virtual;
    procedure ColumnDeleting(AColumn: TLMDGridColumn); virtual;
    procedure ColumnMoving(AFrom, ATo: Integer); virtual;
    procedure MoveDataRow(AFrom, ATo: Integer); virtual;
    function  IsEOF: Boolean; virtual;
    procedure InternalColumnDataTypeChanged(ACol: TLMDGridColumn); virtual;
    procedure InternalDataLayoutChange; virtual;
    procedure InternalEnterNewRecMode(ADestIndex: Integer); virtual;
    procedure InternalExitNewRecMode(ACommit: Boolean;
                                     out ACurrentIndex: Integer); virtual;
    procedure InternalEnterRowEditMode; virtual;
    procedure InternalExitRowEditMode(ACommit: Boolean;
                                      out ACurrentIndex: Integer); virtual;
    procedure InternalSetColumnFieldName(AColumn: TLMDGridColumn; const Value: string;
                                         ABefore: Boolean); virtual;
    procedure InternalSetColumnGrid(AColumn: TLMDGridColumn); virtual;
    function  InternalIsColumnDataBound(ACol: Integer): Boolean; virtual;
    procedure InternalSetDefaultColWidth(AColumn: TLMDGridColumn); virtual;
    procedure InternalSetDefaultColPos(AColumn: TLMDGridColumn); virtual;
    procedure InternalAfterSyncGridStore; virtual;
    procedure InternalUpdateStore; virtual;
    function  InternalMoveVert(ANewCurrent, ANewTop: Integer): Boolean; virtual;
    procedure InternalRestrictDataPoint(var ACol: Integer; var ARow: Integer); virtual;
    procedure InternalSetupScrollBarsStyle; virtual;
    procedure InternalEndUpdateLow; virtual;
    function  GetDataRowCount: Integer; virtual;
    procedure SetDataRowCount(const Value: Integer); virtual;
    procedure Beep; virtual;
    function  ConfirmDeleteCurrentRow: Boolean; virtual;
    function  CanStoreEdit: Boolean; virtual;
    function  CanStoreInsert: Boolean; virtual;
    function  CanStoreRemove: Boolean; virtual;
    function  CanStoreMoveCol: Boolean; virtual;
    function  CanStoreMoveRow: Boolean; virtual;
    function  CanStoreRowEdit: Boolean; virtual;
    procedure PageSizeChanged; virtual;
    function  GetSelRect: TRect; virtual;
    function  IsSelectionValid: Boolean; virtual;
    procedure CancelSelectionLow; virtual;

    // Editor related.

    function GetEditorHelper: TLMDGridEditParentHelper;

    // Non-hack overrides on TCustomGrid.

    function  GetStyle: TLMDGridStyle; virtual;
    function  UseAlternate: Boolean; virtual;
    function  GetStyledColor(C: TColor): TColor;
    procedure DrawStyledEdge(C: TCanvas; var R: TRect; AFlags: Integer);
    function  GetDataCellColor(AColumn: TLMDGridColumn;
                               ACellState: TLMDGridCellStates;
                               ADataRow: Integer): TColor;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AMoving: Boolean;
                       ACanvas: TCanvas);  reintroduce;
    procedure Paint; override;
    procedure ColumnMoved(FromIndex, ToIndex: Longint); override;
    procedure RowMoved(FromIndex, ToIndex: Longint); override;
    procedure TopLeftChanged; override;
    procedure DoExit; override;
    procedure DoEnter; override;
    function  BeginColumnDrag(var Origin, Destination: Integer;
                              const MousePt: TPoint): Boolean; override;
    function  BeginRowDrag(var Origin, Destination: Integer;
                           const MousePt: TPoint): Boolean; override;
    function  EndColumnDrag(var Origin, Destination: Integer;
                            const MousePt: TPoint): Boolean; override;
    function  EndRowDrag(var Origin, Destination: Integer;
                         const MousePt: TPoint): Boolean; override;

    // Descendant utilites.

    function  SetCurrent(ACol, ARow: Integer; WithSelection: Boolean;
                         AClickEvent: Boolean = True): Boolean; overload;
    function  SetCurrent(ACol, ARow, ALeftCol, ATopRow: Integer;
                         WithSelection: Boolean;
                         AClickEvent: Boolean = True): Boolean; overload;
    procedure DeleteCurrentRow;
    procedure RestrictDataPoint(var ACol: Integer; var ARow: Integer; ARestrictRow: Boolean);
    function  TopDataRow: Integer;
    function  LeftDataCol: Integer;
    function  VisibleColumnsCount: Integer;
    function  IsColVisible(ADataCol: Integer): Boolean;
    function  VisibleColToCol(AVisCol: Integer): Integer;
    function  FindNearVisibleCol(ADataCol: Integer; ABack: Boolean): Integer;
    procedure RemoveColumn(AColumn: TLMDGridColumn);
    procedure InsertColumn(AColumn: TLMDGridColumn);
    procedure ClearColumns;
    procedure SetColPositionLow(AColumn: TLMDGridColumn; Value: Integer);
    procedure SetColWidthLow(AColumn: TLMDGridColumn; Value: Integer;
                             out FieldVal: Integer);
    procedure SetColVisibleLow(AColumn: TLMDGridColumn; Value: Boolean;
                               out FieldVal: Boolean);
    procedure SetColReadOnlyLow(AColumn: TLMDGridColumn; Value: Boolean;
                                out FieldVal: Boolean);
    procedure SetColFieldNameLow(AColumn: TLMDGridColumn; const Value: string;
                                 var FieldVal: string);
    function  SetSortLow(AColumn: TLMDGridColumn;
                         Value: TLMDGridSortKind): TLMDGridSortKind;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    procedure CheckColumnsNotSet;
    procedure CheckStyleNotSet;
    procedure CheckCellIdx(ACol, ARow: Integer);
    procedure CheckColumnIdx(Value: Integer);
    procedure CheckColumnVisible(ACol: Integer);
    procedure CheckRowIdx(ARow: Integer);
    procedure BeginUpdateLow(ANeedRestoreEditor, AFullRepaint: Boolean);
    procedure EndUpdateLow(ABlockRestoreEditor: Boolean = False);
    procedure BeginInternal;
    procedure EndInternal;
    function  InInternal: Boolean;
    procedure SyncGridStore;
    function  PageExtents: TSize;
    function  PageHeight: Integer;
    function  PageWidth: Integer;
    function  CanEdit: Boolean;
    function  CanInsert: Boolean;
    function  CanRemove: Boolean;
    function  CanMoveCol: Boolean;
    function  CanMoveRow: Boolean;

    // New record mode.

    function  IsNewRecMode: Boolean;
    function  InitNewRecMode(AInsertBefore: Boolean): Boolean;
    procedure ExitNewRecMode(ACommit: Boolean; out Cancelled: Boolean); overload;
    procedure ExitNewRecMode(ACommit: Boolean); overload;
    function  IsRowEditMode: Boolean;
    procedure InitRowEditMode;
    procedure ExitRowEditMode(ACommit: Boolean);

    // Selection-related.

    procedure CancelSelection;
    function  InSelection(ADataCol, ADataRow: Integer): Boolean;
    procedure InvalidateGridRect(ARect: TRect);
    procedure InvalidateSelRect;

    // Cell properties.

    function IsHeaderRow(ARow: Integer): Boolean;
    function IsDataCol(ACol: Integer): Boolean;
    function IsDataRow(ARow: Integer): Boolean;
    function IsDataCell(ACol, ARow: Integer): Boolean;
    function IsIndicatorCol(ACol: Integer): Boolean;
    function GetCellState(ACol, ARow: Integer): TLMDGridCellStates;
    function GetCellKind(ACol, ARow: Integer): TLMDGridCellKind;
    function GetCellRowState(ACol, ARow: Integer): TLMDGridRowState;

    function GetShiftState: TShiftState;
    procedure DeleteDataRow(ARow: Integer);

    // Properties.

    property DefaultRowHeight default 18;
    property Cells[ACol: Integer; ARow: Integer]: Variant read GetDataCell write SetDataCell;
    property DataRowCount: Integer read GetDataRowCount write SetDataRowCount;
    property CurrentRow: Integer read GetCurrentRow write SetCurrentRow;
    property Columns: TLMDGridColumns read FColumns stored False;
    property Style: TLMDGridStyle read GetStyle write SetStyle;
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default False;
    property Options: TLMDGridOptions read FOptions write SetOptions stored IsOptionsStored;
    property ScrollBarsStyle: TScrollStyle read FScrollBarsStyle write SetScrollBarsStyle default ssBoth;
    property OnBeforeRowDelete: TLMDGridDelRowEvent read FBeforeRowDelete write FBeforeRowDelete;
    property OnPaintEmptyBanner: TLMDGridPaintEmptyBannerEvent read FPaintEmptyBanner write FPaintEmptyBanner;
    property OnGetCellColor: TLMDGridGetCellColorEvent read FOnGetCellColor write FOnGetCellColor;
    property OnDrawDataCell: TLMDGridDrawDataCellEvent read FOnDrawDataCell write FOnDrawDataCell;
    property OnDrawHeaderCell: TLMDGridDrawHeaderCellEvent read FOnDrawHeaderCell write FOnDrawHeaderCell;
    property OnDrawIndicator: TLMDGridDrawIndicatorEvent read FOnDrawIndicator write FOnDrawIndicator;
    property OnKeyPressW: TKeyPressWEvent read FOnKeyPressW write FOnKeyPressW;
    property OnChange: TLMDGridChangeEvent read FOnChange write FOnChange;
    property CustomSource: TLMDGridCustomSource read FCustomSource write SetCustomSource;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function  UseThemeMode: TLMDThemeMode;
    procedure BeginUpdate;
    procedure EndUpdate;
    function  IsEditorShown: Boolean;
    function  Edit: Boolean;
    procedure EndEditing(ACommit: Boolean);
    function  GridColToDataCol(ACol: Integer): Integer;
    function  DataColToGridCol(ACol: Integer): Integer;
    function  GridRowToDataRow(ARow: Integer): Integer;
    function  DataRowToGridRow(ARow: Integer): Integer;
    function  DataRectToGridRect(ARect: TRect): TRect;
    function  MouseCoord(X, Y: Integer): TGridCoord;
    function  CellRect(ACol, ARow: Longint): TRect;
    property  CurrentColumn: Integer read GetCurrentColumn write SetCurrentColumn;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
  end;

  //== TLMDGrid ================================================================

  TLMDGrid = class(TLMDCustomGrid)
  public
    procedure DeleteDataRow(ARow: Integer);
    property  Cells;
    property  DataRowCount;
    property  CurrentRow;
    property  CustomSource;
  published
    property Columns;
    property Style;
    property DefaultColWidth;
    property DefaultRowHeight;
    property ScrollBarsStyle;
    property ThemeMode;
    property ThemeGlobalMode;
    property Options;
    property OnBeforeRowDelete;
    property OnPaintEmptyBanner;
    property OnGetCellColor;
    property OnDrawDataCell;
    property OnDrawHeaderCell;
    property OnDrawIndicator;
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    {$IFDEF LMDCOMP12}
    property ParentDoubleBuffered;
    {$ENDIF}    	
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;    
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    {$IFDEF LMDCOMP10}
    property OnMouseEnter;
    property OnMouseLeave;
	{$ENDIF}
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    {$IFDEF LMDCOMP14}
    property OnGesture;
    property Touch;
    {$ENDIF}	
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}   
  end;

  //== Globals =================================================================

type
  TLMDDesignerSelectComponent = procedure(ADsgControl: TControl;
                                          AComponent: TComponent;
                                          ADoAddSelection: Boolean);

  TLMDDesignerIsComponentSelected = function(ADsgControl: TControl;
                                             AComponent: TComponent): Boolean;

  TLMDDesignSelectionNotifyRegister = procedure(ADsgControl: TControl;
                                                AIsRegister: Boolean;
                                                ANotifyProc: TNotifyEvent);

var
  LMDDesignerSelectComponentProc:   TLMDDesignerSelectComponent;
  LMDDesignerIsComponentSelected:   TLMDDesignerIsComponentSelected;
  LMDDesignSelectionNotifyRegister: TLMDDesignSelectionNotifyRegister;

function IsVarEmpty(Val: PVariant): Boolean;

implementation

uses
  Themes, UxTheme, Dialogs, LMDGridConst, LMDGridImages, Variants, Math,
  LMDCustomEdit, LMDBaseEdit, LMDArrayUtils, LMDGraph, LMDGraphUtils,
  LMDSpinEdit, LMDCustomCheckBox, LMDButtonControl, LMDButtonBase,
  Buttons, LMDCustomMaskEdit, LMDUnicodeControl, LMDUnicode, LMDSpeedButton,
  LMDSysIn, TypInfo;

const
  MOUSE_MOVE_DIFF          = 3;
  MIN_COL_WIDTH            = 5;
  MIN_ROW_HEIGHT           = 5;
  MOVE_SIZE_TIMER_INTERVAL = 30;
  DATE_COMPARE_EPS         = 0.000001;
  CHOOSER_BTNWIDTH         = 18;

  IntTypes          = [ftSmallint, ftInteger, ftLargeint, ftWord
                       {$IFDEF LMDCOMP12}, ftLongWord, ftShortint,
                       ftByte {$ENDIF}];
  FloatTypes        = [DB.ftFloat, DB.ftCurrency, DB.ftBCD {$IFDEF LMDCOMP14},
                       DB.ftSingle{$ENDIF}{$IFDEF LMDCOMP12}, DB.ftExtended{$ENDIF}];
  DateTimeTypes     = [ftDate, ftTime, ftDateTime, ftTimeStamp];
  StringParseTypes  = [ftString, ftBoolean, ftDate, ftTime, ftDateTime,
                       ftAutoInc, ftFixedChar, ftWideString,
                       ftGuid, ftTimeStamp] +
                       IntTypes + FloatTypes;
  StringFormatTypes = [ftString, ftFixedChar, ftWideString, ftMemo, ftFmtMemo
                       {$IFDEF LMDCOMP12} , ftFixedWideChar, ftWideMemo {$ENDIF}];
  MemoTypes         = [ftMemo, ftFmtMemo {$IFDEF LMDCOMP12}, ftWideMemo {$ENDIF}];
  DefOptions        = [opHeaderVertLine, opIndicatorHorzLine, opVertLine,
                       opHorzLine, opRangeSelect, opDrawFocusSelected,
                       opRowSizing, opColSizing, opRowMoving, opColMoving,
                       opEditing, opThumbTracking, opShowIndicator, opShowHeader,
                       opConfirmDeleteRow, opCancelOnExit, opHighlightHeaders,
                       opShowEmptyBanner, opShowColumnsChooser];

var
  FLOAT_COMPARE_EPS: Double;

type
  TWinControlAccess = class(TWinControl);
  TLMDCalcAccess    = class(TLMDCustomCalculator);
  TReaderAccess     = class(TReader);
  TWriterAccess     = class(TWriter);
  TWriterHack       = class(TFiler)
  private
    FRootAncestor: TComponent;
    FPropPath:     string;
  end;

  TVarArray = array of Variant;
  TRow      = class
    Values: TVarArray;
  end;

  TInternalStore = class
  private
    FGrid:       TLMDCustomGrid;
    FRows:       TObjectList;
    FSortedRows: TLMDIntArray;
    FSortKind:   TLMDGridSortKind;
    FSortCol:    Integer;
    FColCount:   Integer;
    FColIndexes: TLMDIntArray;
    FErrMsg:     TLMDString;

    procedure CheckRowIdx(ARow: Integer);
    procedure CheckColIdx(ACol: Integer);
    procedure CheckSortedRows;
    function  AppendRow: Integer;
  public
    constructor Create(AGrid: TLMDCustomGrid);
    destructor Destroy; override;

    function  GetDataCell(ACol, ARow: Integer): PVariant;
    procedure SetDataCell(ACol, ARow: Integer; Value: PVariant;
                          ABlockSort: Boolean; out NewRow: Integer);
    function  RowCount: Integer;
    procedure SetRowCount(ACount: Integer; var CorrIndex: Integer);
    function  ColumnCount: Integer;
    procedure InsertRow(ADest: Integer);
    procedure DeleteRow(ARow: Integer; var CorrIndex: Integer);
    procedure MoveRow(ASrc, ADest: Integer);
    function  AppendColumn: Integer;
    procedure DeleteColumn(ACol: Integer);
    procedure ClearColumn(ACol: Integer);
    procedure MoveColumn(ASrc, ADest: Integer);
    procedure Sort(ACol: Integer; AKind: TLMDGridSortKind;
                   var CorrIndex: Integer);  overload;
    procedure Sort(var CorrIndex: Integer); overload;
  end;

  TEditHelper = class(TLMDGridEditParentHelper)
  private
    FGrid: TLMDCustomGrid;
  public
    constructor Create(AGrid: TLMDCustomGrid);

    procedure WMGetDlgCode(const Ed: ILMDGridEmbeddedEdit;
                           var Message: TWMGetDlgCode); override;
    procedure KeyDownPreprocess(var Key: Word; Shift: TShiftState;
                                Source: TLMDGridKeyProcessSource); override;
    procedure KeyDownPostprocess(var Key: Word; Shift: TShiftState;
                                 Source: TLMDGridKeyProcessSource); override;
    function  WndProc(const Edit: ILMDGridEmbeddedEdit;
                      var Message: TMessage): Boolean; override;
    procedure EditorChanged; override;
    procedure DrawEditBg(ARect: TRect; ACanvas: TCanvas); override;
    function  AsControl: TLMDCustomGrid; override;
    procedure NeedDelayedHideChooser; override;
    function  DoMouseWheelDown(Shift: TShiftState): Boolean; override;
    function  DoMouseWheelUp(Shift: TShiftState): Boolean; override;
  end;

  TEditPanel    = class;
  TMsgBtnsArray = array[Low(TMsgDlgBtn)..High(TMsgDlgBtn)] of TLMDSpeedButton;

  TPopupPanel = class(TCustomPanel)
  private
    FEditPanel:    TEditPanel;
    FButtonsSet:   TMsgDlgButtons;
    FButtons:      TMsgBtnsArray;
    FButtonHeight: Integer;
    FButtonPad:    Integer;

    procedure WMActivate(var Message: TWMActivate); message WM_Activate;
    procedure WMNCActivate(var Message: TWMNCActivate); message WM_NCACTIVATE;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
  protected
    procedure AlignControls(AControl: TControl; var ARect: TRect); override;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent; AEditPanel: TEditPanel;
                       ABtns: TMsgDlgButtons; AOkEvent,
                       ACancelEvent: TNotifyEvent); reintroduce;
    destructor Destroy; override;
  end;

  TEditPanel = class(TCustomPanel)
  private
    FInitMode:          Boolean;
    FGrid:              TLMDCustomGrid;
    FColumn:            TLMDGridColumn;
    FPopupPanel:        TPopupPanel;
    FEdit:              ILMDGridEmbeddedEdit;
    FChooser:           TLMDGridColumnChooser;
    FChooserButton:     TSpeedButton;
    FChooserShown:      Boolean;
    FInShowMethod:      Boolean;

    procedure WMEraseBkGnd(var Message: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure OnChooserBtnMouseDown(Sender: TObject; Button: TMouseButton;
                                    Shift: TShiftState; X, Y: Integer);
    procedure OnChooserOk(Sender: TObject);
    procedure OnChooserCancel(Sender: TObject);
    function  GridToScreen(ARect: TRect): TRect;
    procedure SyncChooserToEdit(AForHide: Boolean);
    procedure AssignEditProps;
  protected
    procedure AlignControls(AControl: TControl; var ARect: TRect); override;
    procedure Paint; override;
  public
    constructor Create(AGrid: TLMDCustomGrid); reintroduce;
    destructor Destroy; override;

    procedure SetColumn(AColumn: TLMDGridColumn);
    procedure Show(ARect: TRect; const AInput: TLMDGridFirstInput);
    procedure Refocus;
    function  OwnsHandle(AHandle: THandle): Boolean;
    procedure GetData(var AKey: Variant; var AValue: Variant);
    procedure SetData(const AKey: Variant; const AValue: Variant; AInitValue: Boolean);
    procedure CancelMode(ASender: TControl);
    procedure Update(ABoundsRect: TRect); reintroduce;
    procedure UpdateAll;
    procedure Hide;
    procedure HideChooser(ASyncEdit, AFocusToEdit: Boolean);
    procedure ShowChooser;
    function  ReadOnly: Boolean;

    property Grid: TLMDCustomGrid read FGrid;
    property ChooserChown: Boolean read FChooserShown;
    property Chooser: TLMDGridColumnChooser read FChooser;
  end;

  TDefaultEmbeddedEditor = class(TCustomControl, ILMDGridEmbeddedEdit)
  private
    FGrid:     TLMDGridEditParentHelper;
    FCol:      TLMDGridColumn;
    FInitMode: Boolean;
    FKey:      Variant;
    FValue:    Variant;

    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  protected
    procedure WndProc(var Message: TMessage); override;
    procedure Paint; override;
    function  DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function  DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(ACol: TLMDGridColumn); reintroduce;

    function  AsControl: TWinControl; virtual;
    procedure SetData(const AKey, AValue: Variant; AInitValue: Boolean); virtual;
    procedure GetData(var AKey, AValue: Variant); virtual;
    procedure SetGrid(AGridHelper: TLMDGridEditParentHelper); virtual;
    function  Column: TLMDGridColumn; virtual;
    procedure HandleFirstInput(const AInput: TLMDGridFirstInput); virtual;
    procedure SetReadOnly(AValue: Boolean); virtual;
    function  GetReadOnly: Boolean; reintroduce; virtual;
    procedure SetThemeMode(AThemeMode: TLMDThemeMode; AThemeGlobalMode: Boolean); virtual;
  end;

  TEmbeddedText = class(TLMDCustomMaskEdit, ILMDGridEmbeddedEdit)
  private
    FGrid:             TLMDGridEditParentHelper;
    FCol:              TLMDGridColumn;
    FKey:              Variant;
    FInKeyDown:        Boolean;
    FInit:             Boolean;
    FMaskedReturnKind: TLMDGridMaskedReturnKind;
    FTextColor:        TColor;

    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure SetEmpty(AValue: Boolean);
    function  GetTrimmedText: TLMDString;
  protected
    procedure Change; override;
    procedure WndProc(var Message: TMessage); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function  DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function  DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure RedefineTextColor(C: TCanvas); override;
  public
    constructor Create(ACol: TLMDGridColumn;
                       AMaskedReturnKind: TLMDGridMaskedReturnKind); reintroduce;

    function  AsControl: TWinControl;
    procedure SetData(const AKey, AValue: Variant; AInitValue: Boolean);
    procedure GetData(var AKey, AValue: Variant);
    procedure SetGrid(AGridHelper: TLMDGridEditParentHelper);
    function  Column: TLMDGridColumn;
    procedure HandleFirstInput(const AInput: TLMDGridFirstInput);
    procedure SetReadOnly(AValue: Boolean); reintroduce;
    function  GetReadOnly: Boolean; reintroduce;
    procedure SetThemeMode(AThemeMode: TLMDThemeMode; AThemeGlobalMode: Boolean);
  end;

  TEmbeddedSpin = class(TLMDCustomSpinEdit, ILMDGridEmbeddedEdit)
  private
    FGrid:      TLMDGridEditParentHelper;
    FCol:       TLMDGridColumn;
    FInitMode:  Boolean;
    FKey:       Variant;
    FTextColor: TColor;

    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure SetEmpty(AValue: Boolean);
    procedure UpdateColors;
  protected
    procedure Change; override;
    procedure WndProc(var Message: TMessage); override;
    procedure CreateHandle; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function  DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function  DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure RedefineTextColor(C: TCanvas); override;
  public
    constructor Create(ACol: TLMDGridColumn); reintroduce;

    function  AsControl: TWinControl;
    procedure SetData(const AKey, AValue: Variant; AInitValue: Boolean);
    procedure GetData(var AKey, AValue: Variant);
    procedure SetGrid(AGridHelper: TLMDGridEditParentHelper);
    function  Column: TLMDGridColumn;
    procedure HandleFirstInput(const AInput: TLMDGridFirstInput);
    procedure SetReadOnly(AValue: Boolean);
    function  GetReadOnly: Boolean; reintroduce;
    procedure SetThemeMode(AThemeMode: TLMDThemeMode; AThemeGlobalMode: Boolean);
    procedure SetShowButtons(AShowButtons: Boolean);
  end;

  TEmbeddedCheckBox = class(TCustomControl, ILMDGridEmbeddedEdit)
  private
    FGrid:            TLMDGridEditParentHelper;
    FCol:             TLMDGridCheckBoxColumn;
    FInitMode:        Boolean;
    FAllowUndefined:  Boolean;
    FKey:             Variant;
    FState:           TCheckBoxState;
    FReadOnly:        Boolean;
    FHover:           Boolean;
    FPressedByMouse:  Boolean;
    FPressedByKey:    Boolean;

    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMCancelMode(var Msg: TWMCancelMode); message WM_CANCELMODE;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure Changed;
    procedure SetState(const Value: TCheckBoxState);
    function  GetNextState(ACurState: TCheckBoxState): TCheckBoxState;
    procedure UpdateHoverState;
    function  IsHover: Boolean;
  protected
    procedure WndProc(var Message: TMessage); override;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer;
                        Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer;
                      Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    function  DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function  DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(ACol: TLMDGridCheckBoxColumn); reintroduce;

    function  AsControl: TWinControl;
    procedure SetData(const AKey, AValue: Variant; AInitValue: Boolean);
    procedure GetData(var AKey, AValue: Variant);
    procedure SetGrid(AGridHelper: TLMDGridEditParentHelper);
    function  Column: TLMDGridColumn;
    procedure HandleFirstInput(const AInput: TLMDGridFirstInput);
    procedure SetReadOnly(AValue: Boolean);
    function  GetReadOnly: Boolean; reintroduce;
    procedure SetThemeMode(AThemeMode: TLMDThemeMode; AThemeGlobalMode: Boolean);

    property State: TCheckBoxState read FState write SetState;
    property ReadOnly: Boolean read FReadOnly;
  end;

  TEmbeddedImage = class(TDefaultEmbeddedEditor)
  private
    FReadOnly: Boolean;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    procedure HandleFirstInput(const AInput: TLMDGridFirstInput); override;
    procedure SetReadOnly(AValue: Boolean); override;
    function  GetReadOnly: Boolean; override;
  end;

  TEmbeddedRating = class(TDefaultEmbeddedEditor)
  private
    FLayout:   TLMDGridRatingLayout;
    FReadOnly: Boolean;
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer;
                        Y: Integer); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    procedure HandleFirstInput(const AInput: TLMDGridFirstInput); override;
    procedure SetReadOnly(AValue: Boolean); override;
    function  GetReadOnly: Boolean; override;
  end;

  TEmbeddedProgress = class(TDefaultEmbeddedEditor)
  private
    FLayout:   TLMDGridProgressLayout;
    FReadOnly: Boolean;
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer;
                        Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    procedure HandleFirstInput(const AInput: TLMDGridFirstInput); override;
    procedure SetReadOnly(AValue: Boolean); override;
    function  GetReadOnly: Boolean; override;
  end;

  TPopupCalendar = class(TLMDCustomCalendar)
  private
    FGrid:       TLMDGridEditParentHelper;
    FIsDayClick: Boolean;

    procedure WMActivate(var Message: TWMActivate); message WM_Activate;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
  protected
    constructor Create(AOwner: TComponent;
                       AGrid: TLMDGridEditParentHelper); reintroduce;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer;
                      Y: Integer); override;
  published
    property Color;
  end;

  TPopupCalculator = class(TLMDCustomCalculator)
  private
    FGrid: TLMDGridEditParentHelper;

    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
  protected
    constructor Create(AOwner: TComponent;
                       AGrid: TLMDGridEditParentHelper); reintroduce;
    procedure   KeyDown(var Key: Word; Shift: TShiftState); override;
  end;

  TPopupMemo = class(TCustomMemo) { TODO : TLMDCustomMemo }
  private
    FGrid:        TLMDGridEditParentHelper;
    FWantTabs:    Boolean;
    FWantReturns: Boolean;

    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
  protected
    constructor Create(AOwner: TComponent;
                       AWantTabs, AWantReturns: Boolean;
                       AGrid: TLMDGridEditParentHelper); reintroduce;
    procedure   KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    property BorderStyle;
  end;

  TPopupListBox = class(TCustomListBox)
  private
    FGrid:        TLMDGridEditParentHelper;
    FItemClicked: Boolean;

    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
  protected
    constructor Create(AOwner: TComponent;
                       AGrid: TLMDGridEditParentHelper); reintroduce;

    procedure  KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure  MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer;
                         Y: Integer); override;
    procedure  MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer;
                       Y: Integer); override;
  end;

  TChooserButton = class(TSpeedButton)
  public
    Style:     TLMDGridChooserBtnStyle;
    ThemeMode: TLMDThemeMode;

    constructor Create(AOwner: TComponent); override;
    procedure   Paint; override;
  end;

  TChooserDsgHelper = class;

  TCollectionDsgHelperItem = class(TCollectionItem)
  private
    function GetChooser: TPersistent;
  published
    property Chooser: TPersistent read GetChooser stored False;
  end;

  TCollectionDsgHelper = class(TCollection)
  private
    FParent: TChooserDsgHelper;
  public
    constructor Create(AParent: TChooserDsgHelper);
  end;

  TChooserDsgHelper = class(TPersistent)
  private
    FColumn: TLMDGridColumn;
    FColl:   TCollectionDsgHelper;
  public
    constructor Create(AColumn: TLMDGridColumn);
    destructor Destroy; override;
  published
    property Coll: TCollectionDsgHelper read FColl stored False;
  end;

{$ifndef LMDCOMP7}
type
  TFormatSettings = record
    CurrencyFormat: Byte;
    NegCurrFormat: Byte;
    ThousandSeparator: Char;
    DecimalSeparator: Char;
    CurrencyDecimals: Byte;
    DateSeparator: Char;
    TimeSeparator: Char;
    ListSeparator: Char;
    CurrencyString: string;
    ShortDateFormat: string;
    LongDateFormat: string;
    TimeAMString: string;
    TimePMString: string;
    ShortTimeFormat: string;
    LongTimeFormat: string;
    ShortMonthNames: array[1..12] of string;
    LongMonthNames: array[1..12] of string;
    ShortDayNames: array[1..7] of string;
    LongDayNames: array[1..7] of string;
    TwoDigitYearCenturyWindow: Word;
  end;

  function FloatToStrF(Value: Extended; Format: TFloatFormat; Precision, Digits: Integer;
                       const FormatSettings: TFormatSettings): string; overload; forward;
  function FormatCurr(const Format: string; Value: Currency;
                      const FormatSettings: TFormatSettings): string; forward;
  function TryFloatToCurr(const Value: Extended; out AResult: Currency): Boolean; forward;
  function TryStrToCurr(const S: string; out Value: Currency;
                        const FormatSettings: TFormatSettings): Boolean; overload; forward;
{$ENDIF}

var
  ColumnClasses:        TObjectList;
  ChooserClasses:       TObjectList;
  ChooserClassesMain:   TObjectList;
  ChooserClassesCompat: TObjectList;
  NullVariant:          Variant;

//== Globals ===================================================================

{$ifndef LMDCOMP7}

function FloatToStrF(Value: Extended; Format: TFloatFormat; Precision,
  Digits: Integer; const FormatSettings: TFormatSettings): string;
var
  oldCur: string;
begin
  oldCur := CurrencyString;
  CurrencyString := FormatSettings.CurrencyString;
  try
    Result := SysUtils.FloatToStrF(Value, Format, Precision, Digits);
  finally
    CurrencyString := oldCur;
  end;
end;

function FormatCurr(const Format: string; Value: Currency;
  const FormatSettings: TFormatSettings): string;
var
  oldCur: string;
begin
  oldCur := CurrencyString;
  CurrencyString := FormatSettings.CurrencyString;
  try
    Result := SysUtils.FormatCurr(Format, Value);
  finally
    CurrencyString := oldCur;
  end;
end;

function TryFloatToCurr(const Value: Extended; out AResult: Currency): Boolean;
begin
  Result := (Value >= MinCurrency) and (Value <= MaxCurrency);
  if Result then
    AResult := Value;
end;

function TryStrToCurr(const S: string; out Value: Currency;
  const FormatSettings: TFormatSettings): Boolean;
begin
  Result := TextToFloat(PChar(S), Value, fvCurrency);
end;

{$ENDIF}

procedure RegisterStdColumns;

  procedure _ClearBmp(ABmp: TBitmap);
  begin
    ABmp.Height := 0;
    ABmp.Width := 0;
  end;

var
  bmp: TBitmap;
begin
  bmp := TBitmap.Create;
  try
    TLMDGridColumn.RegisterColumnClass(TLMDGridTextColumn,
                                       SLMDGridDsgTextColumnDescr,
                                       nil, StringFormatTypes);

    _ClearBmp(bmp);
    LMDGridImagesForm.Images.GetBitmap(0, bmp);
    TLMDGridColumn.RegisterColumnClass(TLMDGridIntegerColumn,
                                       SLMDGridDsgSpinColumnDescr, bmp,
                                       IntTypes + [ftAutoInc]);

    _ClearBmp(bmp);
    LMDGridImagesForm.Images.GetBitmap(1, bmp);
    TLMDGridColumn.RegisterColumnClass(TLMDGridDateColumn,
                                       SLMDGridDsgDateColumnDescr,
                                       bmp,
                                       DateTimeTypes);

    _ClearBmp(bmp);
    LMDGridImagesForm.Images.GetBitmap(2, bmp);
    TLMDGridColumn.RegisterColumnClass(TLMDGridCheckBoxColumn,
                                       SLMDGridDsgCheckBoxColumnDescr,
                                       bmp,
                                       [ftBoolean] + IntTypes +
                                       StringFormatTypes);

    _ClearBmp(bmp);
    LMDGridImagesForm.Images.GetBitmap(3, bmp);
    TLMDGridColumn.RegisterColumnClass(TLMDGridFloatColumn,
                                       SLMDGridDsgFloatColumnDescr,
                                       bmp,
                                       FloatTypes);

    _ClearBmp(bmp);
    LMDGridImagesForm.Images.GetBitmap(4, bmp);
    TLMDGridColumn.RegisterColumnClass(TLMDGridImageColumn,
                                       SLMDGridImageColumnDescr, bmp,
                                       IntTypes);


    _ClearBmp(bmp);
    LMDGridImagesForm.Images.GetBitmap(5, bmp);
    TLMDGridColumn.RegisterColumnClass(TLMDGridRatingColumn,
                                       SLMDGridRatingColumnDescr, bmp,
                                       IntTypes);

    _ClearBmp(bmp);
    LMDGridImagesForm.Images.GetBitmap(6, bmp);
    TLMDGridColumn.RegisterColumnClass(TLMDGridProgressColumn,
                                       SLMDGridProgressColumnDescr, bmp,
                                       IntTypes);

    TLMDGridColumnChooser.RegisterChooserClass(TLMDGridCalendarChooser,
                                               'DateChooser',
                                               SLMDGridDateChooserDescr,
                                               nil,
                                               DateTimeTypes,
                                               1,
                                               StringFormatTypes,
                                               0,
                                               [fkData],
                                               bsPickList);

    TLMDGridColumnChooser.RegisterChooserClass(TLMDGridCalculatorChooser,
                                               'CalculatorChooser',
                                               SLMDGridCalculatorChooserDescr,
                                               nil,
                                               FloatTypes,
                                               1,
                                               IntTypes +
                                               StringFormatTypes,
                                               0,
                                               [fkData],
                                               bsPickList);

    TLMDGridColumnChooser.RegisterChooserClass(TLMDGridCustomChooser,
                                               'CustomChooser',
                                               SLMDGridCustomChooserDescr,
                                               nil,
                                               [], 0,
                                               [Low(TFieldType)..High(TFieldType)],
                                               2,
                                               [Low(TFieldKind)..High(TFieldKind)],
                                               bsEllipsis);


    TLMDGridColumnChooser.RegisterChooserClass(TLMDGridPickListChooser,
                                               'PickList',
                                               SLMDGridPickListChooserDescr,
                                               nil,
                                               [], 0,
                                               StringParseTypes, 1,
                                               [fkData], bsPickList);

    TLMDGridColumnChooser.RegisterChooserClass(TLMDGridMemoChooser,
                                               'MemoChooser',
                                               SLMDGridMemoListChooserDescr,
                                               nil,
                                               MemoTypes, 2,
                                               StringFormatTypes, 0,
                                               [fkData], bsPickList);
  finally
    bmp.Free;
  end;
end;

function FindFloatEPS: Double;
begin
  Result := 1;
  while (1 + (Result / 2)) > 1 do
    Result := Result / 2;
end;

procedure GetCurrFmt(AColumn: TLMDGridFloatColumn; out AFmt: TFormatSettings);
begin
  FillMemory(@AFmt, SizeOf(AFmt), 0);

  if AColumn.FCurrencyString = '' then
    AFmt.CurrencyString := SysUtils.{$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}CurrencyString
  else
    AFmt.CurrencyString := AColumn.FCurrencyString;

  AFmt.CurrencyFormat := SysUtils.{$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}CurrencyFormat;
  AFmt.NegCurrFormat := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}NegCurrFormat;
  AFmt.ThousandSeparator := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ThousandSeparator;
  AFmt.DecimalSeparator := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator;
  AFmt.CurrencyDecimals := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}CurrencyDecimals;
  AFmt.ListSeparator := {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ListSeparator;
end;

procedure NoWarnWrHack(AWr: TWriterHack);
begin
  Assert(False);
  AWr.FRootAncestor := nil;
end;

function GetNameOfChooser(AChooser: TLMDGridColumnChooser): string;
var
  dsc: TLMDGridChooserDescr;
begin
  dsc := TLMDGridColumnChooser.GetRegisteredChooserClass(AChooser.ClassType);
  if dsc <> nil then
    Result := dsc.ChooserName
  else
  begin
    Result := '';
    Assert(False);
  end;
end;

function IsVarEmpty(Val: PVariant): Boolean;
begin
  Result := (Val = nil) or VarIsEmpty(Val^) or VarIsNull(Val^) or
            VarIsClear(Val^);
end;

procedure IntArrayMove(ASrc, ADest: Integer; var Arr: TLMDIntArray);
var
  i, x: Integer;
begin
  x := Arr[ASrc];

  if ASrc < ADest then
    for i := ASrc to ADest - 1 do
      Arr[i] := Arr[i + 1]
  else
    for i := ASrc downto ADest + 1 do
      Arr[i] := Arr[i - 1];

  Arr[ADest] := x;
end;

function Store(AGrid: TLMDCustomGrid): TInternalStore;
begin
  Result := AGrid.FStore as TInternalStore;
end;

function EditPanel(AGrid: TLMDCustomGrid): TEditPanel;
begin
  Result := AGrid.FEditPanel as TEditPanel;
end;

procedure CheckIntValue(const AName: string; AVal: Integer;
  LowBound: Integer); overload;
begin
  if AVal < LowBound then
    raise ELMDGridError.CreateFmt(SLMDGridBadIntValueOneBound, [AName, AVal,
                                                                LowBound]);
end;

procedure CheckIntValue(const AName: string; AVal: Integer; LowBound,
  HighBound: Integer); overload;
begin
  if (AVal < LowBound) or (AVal > HighBound) then
    raise ELMDGridError.CreateFmt(SLMDGridBadIntValueTwoBound, [AName, AVal,
                                                                LowBound,
                                                                HighBound]);
end;

procedure PaintThemedBtnBmp(AStyle: TLMDGridChooserBtnStyle; ACanvas: TCanvas;
  AThemeMode: TLMDThemeMode; AEnabled, AHover, APress: Boolean;
  const ARect: TRect);
var
  details: TThemedElementDetails;
  x, y, w: Integer;
  flags:   DWORD;
  dc:      HDC;
  r:       TRect;
begin
  if AStyle = bsBitmap then
    Exit;

  if AThemeMode <> ttmNone then
  begin
    case AStyle of
      bsEllipsis:
      begin
        if not AEnabled then
          details := ThemeServices.GetElementDetails(tbPushButtonDisabled)
        else if AHover then
          details := ThemeServices.GetElementDetails(tbPushButtonHot)
        else if APress then
          details := ThemeServices.GetElementDetails(tbPushButtonPressed)
        else
          details := ThemeServices.GetElementDetails(tbPushButtonNormal);
      end;
      bsPickList:
      begin
        if not AEnabled then
          details := ThemeServices.GetElementDetails(tcDropDownButtonDisabled)
        else if AHover then
          details := ThemeServices.GetElementDetails(tcDropDownButtonHot)
        else if APress then
          details := ThemeServices.GetElementDetails(tcDropDownButtonPressed)
        else
          details := ThemeServices.GetElementDetails(tcDropDownButtonNormal);
      end;
    end;

    dc := ACanvas.Handle;
    LMDThemeServices.DrawElement(AThemeMode, dc, details, ARect);

    if AStyle = bsEllipsis then
    begin
      x := ARect.Left + ((ARect.Right - ARect.Left) shr 1) - 1;
      y := ARect.Top + ((ARect.Bottom - ARect.Top) shr 1) - 1;
      w := Max(1, (ARect.Right - ARect.Left) shr 3);

      PatBlt(dc, x, y, w, w, BLACKNESS);
      PatBlt(dc, x - (w * 2), y, w, w, BLACKNESS);
      PatBlt(dc, x + (w * 2), y, w, w, BLACKNESS);
    end;
  end
  else
  begin
    case AStyle of
      bsEllipsis:
      begin
        if APress then
          flags := BF_FLAT
        else
          flags := 0;

        dc := ACanvas.Handle;
        r  := ARect;
        DrawEdge(dc, r, EDGE_RAISED, BF_RECT or BF_MIDDLE or flags);

        x := ARect.Left + ((ARect.Right - ARect.Left) shr 1) - 1;
        y := ARect.Top + ((ARect.Bottom - ARect.Top) shr 1) - 1;
        w := Max(1, (ARect.Right - ARect.Left) shr 3);

        PatBlt(dc, x, y, w, w, BLACKNESS);
        PatBlt(dc, x - (w * 2), y, w, w, BLACKNESS);
        PatBlt(dc, x + (w * 2), y, w, w, BLACKNESS);
      end;
      bsPickList:
      begin
        if not AEnabled then
          flags := DFCS_INACTIVE
        else if APress then
          flags := DFCS_PUSHED
        else if AHover then
          flags := DFCS_HOT
        else
          flags := 0;

        dc := ACanvas.Handle;
        DrawFrameControl(dc, ARect, DFC_SCROLL, flags or DFCS_SCROLLCOMBOBOX);
      end;
    end;
  end;
end;

//== TLMDCustomGrid ============================================================

function TLMDCustomGrid.GetDefaultColumnCaption(
  AColumn: TLMDGridColumn): TLMDString;
begin
  Result := '';
end;

function TLMDCustomGrid.GetDefaultColumnAlignment(
  AColumn: TLMDGridColumn): TAlignment;
begin
  Result := Classes.taLeftJustify;
end;

function TLMDCustomGrid.GetDefaultColumnVisible(
  AColumn: TLMDGridColumn): Boolean;
begin
  Result := True;
end;

function TLMDCustomGrid.GetDefaultColumnReadOnly(
  AColumn: TLMDGridColumn): Boolean;
begin
  Result := False;
end;

function TLMDCustomGrid.GetDefaultColumnWidth(
  AColumn: TLMDGridColumn): Integer;
begin
  Result := 50;
end;

function TLMDCustomGrid.GetEditorHelper: TLMDGridEditParentHelper;
begin
  Result := FEditHelper;
end;

function TLMDCustomGrid.GetInplaceEditRect: TRect;
begin
  Result := CellRect(Col, Row);
  if opVertLine in FOptions then
    Dec(Result.Right);
  if opHorzLine in FOptions then
    Dec(Result.Bottom);
  Inc(Result.Top, 1);
  Inc(Result.Left, 1);
end;

function TLMDCustomGrid.TopDataRow: Integer;
begin
  Result := GridRowToDataRow(TopRow);
end;

procedure TLMDCustomGrid.PageSizeChanged;
begin
end;

procedure TLMDCustomGrid.CreateWindowHandle(const Params: TCreateParams);
begin
  Assert(not (csDestroying in ComponentState));
  LMDCreateControlHandle(Self, Params, '');
end;

procedure TLMDCustomGrid.CreateWnd;
begin
  inherited;
  PageSizeChanged;
end;

function TLMDCustomGrid.CanStoreRowEdit: Boolean;
begin
  Result := False;
end;

procedure TLMDCustomGrid.InternalEnterRowEditMode;
begin
  // Do nothing
end;

procedure TLMDCustomGrid.InternalExitRowEditMode(ACommit: Boolean;
  out ACurrentIndex: Integer);
begin
  // Do nothing.
end;

procedure TLMDCustomGrid.InternalGetDataCell(ACol, ARow: Integer;
  Key, Value: PVariant);
begin
  CheckCellIdx(ACol, ARow);

  Key^ := Null;
  if FCustomSource <> nil then
    Value^ := FCustomSource.GetDataCell(ACol, ARow)
  else
    Value^ := (FStore as TInternalStore).GetDataCell(ACol, ARow)^;
end;

function TLMDCustomGrid.IsRowEditMode: Boolean;
begin
  Result := isRowEdit in FState;
end;

procedure TLMDCustomGrid.ExitRowEditMode(ACommit: Boolean);
var
  curIdx: Integer;
  cancel: Boolean;
begin
  if not IsRowEditMode then
    Exit;

  BeginUpdateLow(False, True);
  try
    Cancel := not (ACommit and
                   ((isInplaceEditChanged in FState) or
                    (isRowEditChanged in FState)));

    BeginInternal;
    try
      HideInplaceEditor(not Cancel, True);
    finally
      EndInternal;
    end;

    ExcludeState([isRowEdit, isRowEditChanged, isInplaceEditChanged]);

    CurIdx := CurrentRow;
    if not InInternal then
      InternalExitRowEditMode(not Cancel, CurIdx);

    CurrentRow := CurIdx;
    SyncGridStore;
  finally
    EndUpdateLow;
  end;
end;

procedure TLMDCustomGrid.InitRowEditMode;
begin
  Include(FState, isRowEdit);
  InternalEnterRowEditMode;
end;

procedure TLMDCustomGrid.InplaceEditDoCancelMode(ASender: TControl);
begin
  if IsEditorShown then
    EditPanel(Self).CancelMode(ASender);
end;

procedure TLMDCustomGrid.InternalDeleteDataRow(ARow: Integer;
  var CorrIndex: Integer);
begin
  if FCustomSource <> nil then
    FCustomSource.DeleteRow(ARow, CorrIndex)
  else
    Store(Self).DeleteRow(ARow, CorrIndex);
end;

procedure TLMDCustomGrid.RestrictDataPoint(var ACol: Integer;
  var ARow: Integer; ARestrictRow: Boolean);
var
  maxX, maxY: Integer;
begin
  maxX := Columns.Count - 1;

  if ACol > maxX then
    ACol := maxX
  else if ACol < 0 then
    ACol := 0;

  if ARestrictRow then
  begin
    maxY := DataRowCount - 1;

    if ARow > maxY then
      ARow := maxY
    else if ARow < 0 then
      ARow := 0;
  end;
end;

function TLMDCustomGrid.LeftDataCol: Integer;
begin
  Result := GridColToDataCol(LeftCol);
end;

function TLMDCustomGrid.SetCurrent(ACol, ARow: Integer;
  WithSelection, AClickEvent: Boolean): Boolean;
begin
  Result := SetCurrent(ACol, ARow, LeftDataCol, TopDataRow,
                       WithSelection, AClickEvent);
end;

function TLMDCustomGrid.InternalMoveVert(ANewCurrent,
  ANewTop: Integer): Boolean;
begin
  Row    := DataRowToGridRow(ANewCurrent);
  TopRow := DataRowToGridRow(ANewTop);

  Result := True;
end;

procedure TLMDCustomGrid.InternalRestrictDataPoint(var ACol: Integer;
  var ARow: Integer);
begin
  RestrictDataPoint(ACol, ARow, True);
end;

function TLMDCustomGrid.IsSelectionValid: Boolean;
begin
  Result := FSelectionAnchor.X <> -1;
end;

function TLMDCustomGrid.IsEOF: Boolean;
begin
  Result := CurrentRow = (DataRowCount - 1);
end;

procedure TLMDCustomGrid.TopLeftChanged;
begin
  UpdateInplaceEditState;
  Invalidate;
end;

procedure TLMDCustomGrid.BeginUpdate;
begin
  BeginUpdateLow(True, False);
end;

procedure TLMDCustomGrid.BeginUpdateLow(ANeedRestoreEditor,
  AFullRepaint: Boolean);
begin
  Inc(FUpdateCnt);

  if (FUpdateCnt = 1) and IsEditorShown then
    IncludeState(isWasEditorShown);

  if AFullRepaint then
    IncludeState(isNeedFullRepaint);

  if ANeedRestoreEditor then
    IncludeState(isNeedRestoreEditor);

  if FUpdateCnt = 1 then
  begin
    FChangeFlags := [];

    FOldCol  := Col;
    FOldRow  := Row;
    FOldTop  := TopRow;
    FOldLeft := LeftCol;
  end;
end;

procedure TLMDCustomGrid.CheckCellIdx(ACol, ARow: Integer);
begin
  if (ACol < 0) or (ACol >= Columns.Count) or
     (ARow < 0) or (ARow >= DataRowCount) then
    raise ELMDGridError.CreateFmt(SLMDGridInvalidCellIdx, [ACol, ARow,
                                                           Columns.Count - 1,
                                                           DataRowCount - 1]);

end;

procedure TLMDCustomGrid.CheckColumnIdx(Value: Integer);
begin
  if (Value < 0) or (Value >= FColumns.Count) then
    raise ELMDGridError.CreateFmt(SLMDGridInvalidColumnIdx,
                                  [Value, FColumns.Count - 1]);
end;

procedure TLMDCustomGrid.CheckColumnsNotSet;
begin
  if FColumns <> nil then
    raise ELMDGridError.Create(SLMDGridInternalClass);
end;

procedure TLMDCustomGrid.CheckColumnVisible(ACol: Integer);
begin
  if not IsColVisible(ACol) then
    raise ELMDGridError.Create(SLMDGridVisibleColumnRequired);
end;

procedure TLMDCustomGrid.CheckRowIdx(ARow: Integer);
begin
  if (ARow < 0) or (ARow >= DataRowCount) then
    raise ELMDGridError.CreateFmt(SLMDGridInvalidRowIdx,
                                  [ARow, DataRowCount - 1]);
end;

procedure TLMDCustomGrid.CheckStyleNotSet;
begin
  if FStyle <> nil then
    raise ELMDGridError.Create(SLMDGridInternalClass);
end;

procedure TLMDCustomGrid.ScrollToCurrent;
var
  changed: Boolean;
begin
  changed := True;
  if Col < LeftCol then
    LeftCol := Col
  else if Col >= LeftCol + PageWidth then
    LeftCol := Col - PageWidth
  else
    changed := False;

  if Row < TopRow then
    TopRow := Row
  else if Row >= TopRow + PageHeight then
    TopRow := Row - PageHeight + 1
  else
    changed := False;

  if changed then
    IncludeState(isNeedFullRepaint);
end;

procedure TLMDCustomGrid.RebuildColsSaved;
var
  i: Integer;
begin
  SetLength(FColumnsVisible, Columns.Count);
  SetLength(FColumnsReadOnly, Columns.Count);

  for i := 0 to Columns.Count - 1 do
  begin
    FColumnsVisible[i] := Columns[i].Visible;
    FColumnsReadOnly[i] := Columns[i].ReadOnly;
  end;

  for i := 0 to Columns.Count - 1 do
    Columns[i].CheckColumnDataTypeChange;
end;

procedure TLMDCustomGrid.ReFocusInplaceEditor(AFocusFrom: HWND);
begin
  if not IsEditorShown then
    Exit;

  Assert(HaveVisibleData);

  UpdateInplaceEditState;
  if not EditPanel(Self).OwnsHandle(AFocusFrom) then
    EditPanel(Self).Refocus;
end;

procedure TLMDCustomGrid.SelectAutoColumn(ACol: TLMDGridColumn; ADoAdd: Boolean);
var
  i: Integer;
begin
  if not ADoAdd then
  begin
    for i := 0 to Columns.Count - 1 do
      Columns[i].SetAutoColumnDesignerSelected(False);
  end;
  if ACol <> nil then
    ACol.SetAutoColumnDesignerSelected(True);

  Invalidate;
end;

function TLMDCustomGrid.SelectCell(ACol, ARow: Integer): Boolean;
begin
  Result := True;
  InvalidateBySelectCell(ACol, ARow);
end;

function TLMDCustomGrid.CanEditShow: Boolean;
begin
  Result := False;
end;

procedure TLMDCustomGrid.SetDataCell(ACol, ARow: Integer; const Value: Variant);
begin
  SetDataCellLow(ACol, ARow, Null, Value);
end;

procedure TLMDCustomGrid.FillColumnsFromStore(
  ANameSetProc: TLMDGridColumnNameSetCallback);
begin
  // Do nothing.
end;

procedure TLMDCustomGrid.Beep;
begin
  MessageBeep(0);
end;

procedure TLMDCustomGrid.SetDataCellLow(ACol, ARow: Integer;
  const Key, Value: Variant);
var
  newRow: Integer;
  oldRow: Integer;
  curRow: Integer;
begin
  CheckCellIdx(ACol, ARow);
  BeginUpdateLow(False, False);
  try
    InternalSetDataCell(ACol, ARow, @Key, @Value, IsNewRecMode, newRow);
    InvalidateIndicator;

    if ARow = newRow then
    begin
      if IsColVisible(ACol) then
        InvalidateCell(DataColToGridCol(ACol),
                       DataRowToGridRow(ARow));
    end
    else
    begin
      oldRow := ARow;
      curRow := CurrentRow;

      if oldRow = curRow then
        CurrentRow := newRow
      else if (curRow < oldRow) and (newRow < oldRow) then
        CurrentRow := curRow + 1
      else if (curRow > oldRow) and (newRow > oldRow) then
        CurrentRow := curRow - 1;

      IncludeState(isNeedFullRepaint);

      CancelSelection;
    end;
  finally
    EndUpdateLow;
  end;
end;

procedure TLMDCustomGrid.SetColFieldNameLow(AColumn: TLMDGridColumn;
  const Value: string; var FieldVal: string);
begin
  if ([isColMoving, isColSizing] * FState) <> [] then
    raise ELMDGridError.Create(SLMDGridCantSetColVisibleInMode);

  InternalSetColumnFieldName(AColumn, Value, True);

  BeginUpdateLow(False, True);
  try
    ExitNewRecMode(False);
    ExitRowEditMode(False);
    HideInplaceEditor(True, True);

    FieldVal := Value;
    InternalSetColumnFieldName(AColumn, Value, False);
    RebuildColsSaved;
  finally
    EndUpdateLow;
  end;
end;

procedure TLMDCustomGrid.SetColPositionLow(AColumn: TLMDGridColumn;
  Value: Integer);
var
  old: Integer;
begin
  CheckColumnIdx(Value);

  old := AColumn.Position;
  ColumnMoving(old, Value);

  FColumns.FCols.Remove(AColumn);
  FColumns.FCols.Insert(Value, AColumn);

  FColumns.UpdateColPositions;

  if AColumn.Visible then
  begin
    BeginInternal;
    try
      MoveColumn(DataColToGridCol(old), DataColToGridCol(Value));
    finally
      EndInternal;
    end;

    UpdateInplaceEditState;
  end;

  InternalSetDefaultColPos(AColumn);
  RebuildColsSaved;
end;

procedure TLMDCustomGrid.SetColReadOnlyLow(AColumn: TLMDGridColumn;
  Value: Boolean; out FieldVal: Boolean);
begin
  FieldVal := Value;

  if AColumn.Visible and IsEditorShown and Value and
     (AColumn.Position = CurrentColumn) then
    HideInplaceEditor(False, True);

  RebuildColsSaved;
end;

procedure TLMDCustomGrid.SetColVisibleLow(AColumn: TLMDGridColumn;
  Value: Boolean; out FieldVal: Boolean);
var
  curCol, colI: Integer;
begin
  if ([isColMoving, isColSizing] * FState) <> [] then
    raise ELMDGridError.Create(SLMDGridCantSetColVisibleInMode);

  BeginInternal;
  try
    ExitNewRecMode(False);
    ExitRowEditMode(False);
    HideInplaceEditor(True, True);

    if Value then
    begin
      FieldVal := Value;
      colI := DataColToGridCol(AColumn.Position);

      inherited ColCount := inherited ColCount + 1;
      inherited MoveColumn(ColCount - 1, colI);
      ColWidths[colI] := AColumn.Width;
    end
    else
    begin
      colI := DataColToGridCol(AColumn.Position);
      curCol := Col;

      inherited DeleteColumn(colI);

      if colI = curCol then
      begin
        if colI < ColCount then
          Col := colI
        else
          Col := ColCount - 1;
      end
      else if curCol > colI then
        Col := curCol - 1;

      FieldVal := Value;
    end;

    RebuildColsSaved;
    SyncGridStore;

    if HaveVisibleCols then
      CancelSelectionLow;
  finally
    EndInternal;
  end;
end;

procedure TLMDCustomGrid.SetCurrentColumn(const ACol: Integer);
begin
  if CurrentColumn = ACol then
    Exit;

  if Columns.Count = 0 then
    raise ELMDGridError.Create(SLMDGridNoColumns);

  if not IsColVisible(ACol) then
    raise ELMDGridError.Create(SLMDGridVisibleColumnRequired);

  SetCurrent(ACol, CurrentRow, False);
end;

procedure TLMDCustomGrid.SetColWidthLow(AColumn: TLMDGridColumn;
  Value: Integer; out FieldVal: Integer);
begin
  BeginInternal;
  try
    FieldVal := Value;
    ColWidths[DataColToGridCol(AColumn.Position)] := Value;
    InternalSetDefaultColWidth(AColumn);
  finally
    EndInternal;
  end;
end;

procedure TLMDCustomGrid.ResetColumnsPaintCache;
var
  i: Integer;
begin
  for i := 0 to Columns.Count - 1 do
    Columns[i].ResetPaintCache;
end;

procedure TLMDCustomGrid.ResetHoverCell;
begin
  FHoverCell.X := -1;
  FHoverCell.Y := -1;
end;

procedure TLMDCustomGrid.Resize;
begin
  BeginUpdateLow(False, True);
  try
    inherited;
    PageSizeChanged;
  finally
    EndUpdateLow;
  end;
end;

procedure TLMDCustomGrid.CheckDataLayoutChange;
var
  i, j:   Integer;
  oldVis: TLMDGridBoolArray;
  oldRo:  TLMDGridBoolArray;
begin
  oldVis := Copy(FColumnsVisible);
  oldRo  := Copy(FColumnsReadOnly);

  Assert(Length(oldVis) = Columns.Count);

  BeginUpdateLow(False, False);
  try
    for i := 0 to Columns.Count - 1 do
    begin
//      This code seems to do nothing, but if its become uncommented,the
//      Assert in TLMDCustomGrid.DataColToGridCol can be violated in case of
//      using TdxMemData (in-memory dataset). YB-2015.
//
//      if Columns[i].Visible <> oldVis[i] then
//        SetColVisibleLow(Columns[i], Columns[i].Visible, oldVis[i]);

      if Columns[i].ReadOnly <> oldRo[i] then
        SetColReadOnlyLow(Columns[i], Columns[i].ReadOnly, oldRo[i]);

      if Columns[i].Visible then
      begin
        j := DataColToGridCol(i);
        ColWidths[j] := Columns[i].Width;
      end;

      Columns[i].CheckColumnDataTypeChange;
    end;

    if (CurrentColumn <> -1) and
       (not InternalIsColumnDataBound( CurrentColumn ))
    then
      HideInplaceEditor(False, True);
  finally
    EndUpdateLow;
  end;
end;

procedure TLMDCustomGrid.SetScrollBarsStyle(const Value: TScrollStyle);
begin
  FScrollBarsStyle := Value;
  InternalSetupScrollBarsStyle;
end;

function TLMDCustomGrid.SetSortLow(AColumn: TLMDGridColumn;
  Value: TLMDGridSortKind): TLMDGridSortKind;
var
  i:      Integer;
  curRow: Integer;
begin
  if not IsSortingAllowed(AColumn) then
    Result := skNone
  else
  begin
    Result := Value;

    if Value <> skNone then
    begin
      BeginUpdateLow(True, True);
      try
        CancelSelection;

        HideInplaceEditor(True, True);

        for i := 0 to Columns.Count - 1 do
          if Columns[i] <> AColumn then
            Columns[i].FSortKind := skNone;

        curRow := CurrentRow;
        InternalDataSourceSort(AColumn, AColumn.SortKind, curRow);

        CurrentRow := curRow;

        CancelSelection;
      finally
        EndUpdateLow;
      end;
    end;
  end;
end;

procedure TLMDCustomGrid.InvalidateBySelectCell(ANewCol, ANewRow: Integer);
begin
  if (opShowIndicator in Options) and (ANewRow <> Row) and
     HaveVisibleData
  then
  begin
    InvalidateIndicator(Row);
    InvalidateIndicator(ANewRow);
  end;
end;

procedure TLMDCustomGrid.InvalidateIndicator(ARow: Integer);
begin
  if opShowIndicator in Options then
  begin
    if ARow = -1 then
      ARow := Row;
    InvalidateCell(0, ARow);
  end;
end;

procedure TLMDCustomGrid.InvalidateMovingPt(OldX, OldY, X, Y: Integer);
var
  cell, oldCell: TGridCoord;
  h, w, moveTo:  Integer;
  r:             TRect;
  colMove:       Boolean;
begin
  if not HaveVisibleCols then
    Exit;

  colMove   := ([isColMoving, isColSizing] * FState) <> [];
  w         := 0;
  h         := 0;
  cell.X    := -1;
  cell.Y    := -1;
  oldCell.X := -1;
  oldCell.Y := -1;

  if X <> -1 then
    cell := MouseCoord(X, Y);
  if OldX <> -1 then
    oldCell := MouseCoord(OldX, OldY);

  if MovingState then
  begin
    if colMove then
    begin
      if X <> -1 then
      begin
        r       := CellRect(cell.X, 0);
        w       := ColWidths[FSizeMoveIdx];
        r.Left  := X - FMoveOffset.X;
        r.Right := r.Left + w;

        InvalidateRect(Handle, @r, False);
      end;

      if OldX <> -1 then
      begin
        r       := CellRect(oldCell.X, 0);
        r.Left  := OldX - FMoveOffset.X;
        r.Right := r.Left + w;

        InvalidateRect(Handle, @r, False);
      end;
    end
    else
    begin
      if X <> -1 then
      begin
        r        := CellRect(0, cell.Y);
        h        := RowHeights[FSizeMoveIdx];
        r.Top    := Y - FMoveOffset.Y;
        r.Bottom := Y + h;

        InvalidateRect(Handle, @r, False);
      end;

      if OldX <> -1 then
      begin
        r        := CellRect(0, oldCell.Y);
        r.Top    := OldY - FMoveOffset.Y;
        r.Bottom := OldY + h;

        InvalidateRect(Handle, @r, False);
      end;
    end;

    if X <> -1 then
      moveTo := GetMoveDropIndex(X, Y, colMove)
    else
      moveTo := -1;

    if moveTo <> FMoveDropIdx then
    begin
      r := GetMoveDropRect(moveTo, colMove);
      InvalidateRect(Self.Handle, @r, False);

      r := GetMoveDropRect(FMoveDropIdx, colMove);
      InvalidateRect(Self.Handle, @r, False);

      FMoveDropIdx := moveTo;
    end;
  end
  else if SizingState then
  begin
    if colMove then
    begin
      r := CellRect(FSizeMoveIdx, 0);
      r.Right := Max(r.Right, X);
      InvalidateRect(Handle, @r, False);

      r := CellRect(FSizeMoveIdx, 0);
      r.Right := Max(r.Right, OldX);
      InvalidateRect(Handle, @r, False);

      FSizingNewSize := Max(X - r.Left, MIN_COL_WIDTH);
    end
    else
    begin
      r := CellRect(0, FSizeMoveIdx);
      r.Bottom := Max(r.Bottom, Y);
      InvalidateRect(Handle, @r, False);

      r := CellRect(0, FSizeMoveIdx);
      r.Bottom := Max(r.Right, OldY);
      InvalidateRect(Handle, @r, False);

      FSizingNewSize := Max(Y - r.Top, MIN_ROW_HEIGHT);
    end;
  end
  else
  begin
    Assert(isSelExtending in FState);
    if (cell.X <> -1) and IsDataCell(cell.X, cell.Y) then
    begin
      cell.X := GridColToDataCol(cell.X);
      cell.Y := GridRowToDataRow(cell.Y);
      SetCurrent(cell.X, cell.Y, True);
    end;
  end;
end;

function TLMDCustomGrid.GetMouseSizingState(X, Y: Integer;
  var SizingIdx: Integer): TLMDGridInternalStates;
var
  drawInfo: TGridDrawInfo;
  dummy:    Integer;
  state:    TGridState;
  res:      TLMDGridOption;
begin
  CalcDrawInfo(drawInfo);

  { Check grid sizing }

  CalcSizingState(X, Y, state, SizingIdx, dummy, dummy, drawInfo);

  Result := [];
  res := TLMDGridOption(-1);
  case state of
    gsRowSizing:
      if HaveRows then
        res := opRowSizing;
    gsColSizing:
      res := opColSizing;
  end;

  if res in Options then
  begin
    case res of
      opRowSizing: Result := [isRowSizing];
      opColSizing: Result := [isColSizing];
    else
      Assert(False);
    end;
  end;
end;

function TLMDCustomGrid.GetMoveDropIndex(X, Y: Integer;
  AColMoving: Boolean): Integer;
var
  cell: TGridCoord;
  r:    TRect;
begin
  if AColMoving then
  begin
    r := CellRect(LeftCol, 0);

    X := Max(r.Left, X);
    r := CellRect(LeftCol + PageWidth, 0);
    X := Min(r.Right, X);
  end
  else
  begin
    r := CellRect(LeftCol, TopRow);

    Y := Max(r.Top, Y);
    r := CellRect(LeftCol, TopRow + PageHeight);
    Y := Min(r.Bottom, Y);
  end;

  cell := MouseCoord(X, Y);
  r := CellRect(cell.X, cell.Y);

  if AColMoving then
  begin
    if X < ((r.Left + r.Right) div 2) then
      Result := cell.X
    else
      Result := cell.X + 1;
  end
  else
  begin
    if Y < ((r.Top + r.Bottom) div 2) then
      Result := cell.Y
    else
      Result := cell.Y + 1;
  end;

  Result := Max(Result, DataColToGridCol(VisibleColToCol(0)));
end;

function TLMDCustomGrid.GetMoveDropRect(AIndex: Integer;
  AColMoving: Boolean): TRect;
var
  r:          TRect;
  imgs:       TImageList;
  bmp:        TBitmap;
  wdth, hght: Integer;
begin
  if AColMoving then
  begin
    r   := CellRect(AIndex, 0);
    bmp := Style.DropArrowColumnImg;
  end
  else
  begin
    r   := CellRect(0, AIndex);
    bmp := Style.DropArrowRowImg;
  end;

  if bmp.Empty then
  begin
    imgs := LMDGridImagesForm.ArrowImages;
    wdth := imgs.Width;
    hght := imgs.Height;
  end
  else
  begin
    wdth := bmp.Width;
    hght := bmp.Height;
  end;

  if AColMoving then
  begin
    Result.Left := r.Left - (wdth div 2);
    Result.Top  := r.Bottom + 2;
  end
  else
  begin
    Result.Left := r.Right + 2;
    Result.Top  := r.Top - (hght div 2);
  end;

  Result.Bottom := Result.Top + wdth;
  Result.Right  := Result.Left + hght;
end;

procedure TLMDCustomGrid.OnMoveSizeTimer(ASender: TObject);
var
  x0, y0, xm, ym: Integer;
begin
  x0 := DataColToGridCol(VisibleColToCol(0));
  xm := DataColToGridCol(VisibleColToCol(VisibleColumnsCount - 1));
  y0 := DataRowToGridRow(0);
  ym := DataRowToGridRow(DataRowCount - 1);

  BeginUpdateLow(False, False);
  try
    case FMoveSizeTimerDir of
      sdUp:           TopRow  := Max(y0, TopRow - 1);
      sdDown:         TopRow  := Min(ym, TopRow + 1);
      sdLeft:         LeftCol := Max(x0, LeftCol - 1);
      sdRight:        LeftCol := Min(xm, LeftCol + 1);
      sdUpLeft:       begin
                        LeftCol := Max(x0, LeftCol - 1);
                        TopRow  := Max(y0, TopRow - 1);
                      end;
      sdUpRight:      begin
                        LeftCol := Min(xm, LeftCol + 1);
                        TopRow  := Max(y0, TopRow - 1);
                      end;
      sdDownLeft:     begin
                        LeftCol := Max(x0, LeftCol - 1);
                        TopRow  := Min(ym, TopRow + 1);
                      end;
      sdDownRight:    begin
                        LeftCol := Min(xm, LeftCol + 1);
                        TopRow  := Min(ym, TopRow + 1);
                      end;
      sdNone:         ; // Do nothing.
    end;
  finally
    EndUpdateLow;
  end;
end;

function TLMDCustomGrid.IsEditorShown: Boolean;
begin
  Result := isEditing in FState;
end;

procedure TLMDCustomGrid.SetStyle(const Value: TLMDGridStyle);
begin
  if Value = FStyle then
    Exit;
  if Value = nil then
    raise ELMDGridError.CreateFmt(SLMDGridNilArgument, ['SetStyle, arg: Value']);

  FStyle.Assign(Value);
end;

procedure TLMDCustomGrid.FillColumnsChooseMenu(AMenu: TPopupMenu);
var
  i:   Integer;
  itm: TMenuItem;
begin
  AMenu.Items.Clear;

  for i := 0 to Columns.Count - 1 do
  begin
    itm := TMenuItem.Create(AMenu.Owner);
    itm.Caption := Columns[i].Title.Caption;
    itm.Checked := Columns[i].Visible;
    itm.OnClick := OnColumnsMenuClick;
    itm.Tag := i;

    AMenu.Items.Add(itm);
  end;
end;

procedure TLMDCustomGrid.OnColumnsMenuClick(Sender: TObject);
var
  itm: TMenuItem;
begin
  itm := Sender as TMenuItem;
  Columns[itm.Tag].Visible := not Columns[itm.Tag].Visible;
end;

procedure TLMDCustomGrid.SetIndicatorHeaderOptionsLow(AShowIndicator,
  AShowHeaders, AShowIndicatorOld, AShowHeadersOld: Boolean);
var
  oldCol, oldRow: Integer;
  i, j, k:        Integer;
begin
  oldCol := Col;
  oldRow := Row;

  BeginUpdateLow(True, True);
  BeginInternal;
  try
    if AShowIndicator <> AShowIndicatorOld then
    begin
      if AShowIndicator then
      begin
        ColCount := ColCount + 1;
        FixedCols := 1;
        ColWidths[0] := Style.IndicatorColWidth;

        Col := oldCol + 1;
      end
      else
      begin
        ColCount := ColCount - 1;
        FixedCols := 0;

        Col := Max(0, oldCol - 1);
      end;
      Row := Min(RowCount - 1, oldRow);

      for i := 0 to VisibleColumnsCount - 1 do
      begin
        j := VisibleColToCol(i);
        if AShowIndicator then
          k := j + 1
        else
          k := j;

        ColWidths[k] := Columns[j].Width;
      end;
    end;

    if AShowHeaders <> AShowHeadersOld then
    begin
      if AShowHeaders then
      begin
        RowCount := RowCount + 1;
        MoveRow(RowCount - 1, 0);
        FixedRows := 1;

        Row := oldRow + 1;

        RowHeights[0] := Style.HeaderRowHeight;
      end
      else
      begin
        FixedRows := 0;

        for i := 0 to RowCount - 2 do
          RowHeights[i] := RowHeights[i + 1];

        if RowCount > 1 then
          RowCount := RowCount - 1
        else
          RowHeights[0] := DefaultRowHeight;

        Row := Max(0, oldRow - 1);
      end;
      Col := Min(ColCount - 1, oldCol);
    end;
  finally
    EndInternal;
    EndUpdateLow;
  end;
end;

procedure TLMDCustomGrid.SetAutoColumnsMode(AMode: Boolean);
begin
  // Do nothing.
end;

procedure TLMDCustomGrid.SetBaseOptions(const Value: TLMDGridOptions);
var
  op:       TLMDGridOption;
  baseOpts: TGridOptions;
  baseOp:   TGridOption;
begin
  baseOpts := [goFixedVertLine, goFixedHorzLine];
  baseOp := Low(baseOp);
  for op := Low(op) to High(op) do
  begin
    case op of
      opVertLine:      baseOp := goVertLine;
      opHorzLine:      baseOp := goHorzLine;
      opRangeSelect:   baseOp := goRangeSelect;
      opRowSizing:     baseOp := goRowSizing;
      opColSizing:     baseOp := goColSizing;
      opRowMoving:     baseOp := goRowMoving;
      opColMoving:     baseOp := goColMoving;
      opEditing:       baseOp := goEditing;
      opTabs:          baseOp := goTabs;
      opThumbTracking: baseOp := goThumbTracking;

      opAlwaysShowEditor:  baseOp := goAlwaysShowEditor;
      opDrawFocusSelected: baseOp := goDrawFocusSelected;
    else
      Continue;
    end;

    if op in Value then
      Include(baseOpts, baseOp);
  end;

  inherited Options := baseOpts;
end;

procedure TLMDCustomGrid.SetOptions(const Value: TLMDGridOptions);
var
  oldShowInd, oldShowHead: Boolean;
  showInd, showHead:       Boolean;
begin
  if Value = Options then
    Exit;

  BeginUpdateLow(True, True);
  try
    oldShowInd := opShowIndicator in FOptions;
    oldShowHead := opShowHeader in FOptions;
    showInd := opShowIndicator in Value;
    showHead := opShowHeader in Value;

    FOptions := Value;
    SetBaseOptions(Value);

    if (oldShowInd <> showInd) or (oldShowHead <> showHead) then
      SetIndicatorHeaderOptionsLow(showInd, showHead, oldShowInd, oldShowHead);

    if not (opRangeSelect in FOptions) then
      CancelSelection;
  finally
    EndUpdateLow;
  end;
end;

procedure TLMDCustomGrid.SetCurrentRow(const ARow: Integer);
begin
  if CurrentRow = ARow then
    Exit;

  if DataRowCount = 0 then
    raise ELMDGridError.Create(SLMDGridNoRows);

  SetCurrent(CurrentColumn, ARow, False);
end;

procedure TLMDCustomGrid.SetCustomSource(const Value: TLMDGridCustomSource);
begin
  BeginUpdateLow(False, True);
    FCustomSource := Value;
    SyncGridStore;
  EndUpdateLow;
end;

function TLMDCustomGrid.IsInteractiveState: Boolean;
begin
  Result := not (csDesigning in ComponentState);
end;

function TLMDCustomGrid.IsNewRecMode: Boolean;
begin
  Result := isNewRecord in FState;
end;

function TLMDCustomGrid.IsOptionsStored: Boolean;
begin
  Result := (FOptions <> DefOptions);
end;

procedure TLMDCustomGrid.EnterInitMode;
begin
  Inc(FInitColModeCnt);
end;

procedure TLMDCustomGrid.ExitInitMode;
begin
  Assert(FInitColModeCnt > 0);
  Dec(FInitColModeCnt);
end;

procedure TLMDCustomGrid.IncludeChange(AChange: TLMDGridChangeFlag);
begin
  Include(FChangeFlags, AChange);
end;

procedure TLMDCustomGrid.IncludeState(AState: TLMDGridInternalState);
begin
  Include(FState, AState);
end;

function TLMDCustomGrid.InInitMode: Boolean;
begin
  Result := FInitColModeCnt > 0;
end;

function TLMDCustomGrid.InInternal: Boolean;
begin
  Result := FInternalCnt > 0;
end;

function TLMDCustomGrid.InitNewRecMode(AInsertBefore: Boolean): Boolean;
begin
  Result := (not IsNewRecMode) and HaveVisibleCols and CanInsert;
  if not Result then
    Exit;

  BeginUpdateLow(True, True);
  try
    HideInplaceEditor(True, True);
    if IsRowEditMode then
      ExitRowEditMode(True);

    IncludeState(isNewRecord);

    if not InInternal then
    begin
      if AInsertBefore then
        InternalEnterNewRecMode(CurrentRow)
      else
        InternalEnterNewRecMode(CurrentRow + 1);
    end;

    CancelSelection;
  finally
    EndUpdateLow;
  end;
end;

function TLMDCustomGrid.NoMovingSizingState: Boolean;
begin
  Result := (FState * [isRowSizing, isColSizing, isRowMoving, isColMoving,
                       isSelExtending]) = [];
end;

function TLMDCustomGrid.MovingState: Boolean;
begin
  Result := (FState * [isRowMoving, isColMoving]) <> [];
end;

function TLMDCustomGrid.SizingState: Boolean;
begin
  Result := (FState * [isRowSizing, isColSizing]) <> [];
end;

procedure TLMDCustomGrid.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
  begin
    FThemeGlobalMode := Value;
    DoThemeChanged;
  end;
end;

procedure TLMDCustomGrid.SetThemeMode(const Value: TLMDThemeMode);
begin
  if (FThemeMode <> Value) then
  begin
    FThemeMode := Value;
    if not FThemeGlobalMode then
      DoThemeChanged;
  end;
end;

function TLMDCustomGrid.ShowInplaceEditor: Boolean;
var
  inpt: TLMDGridFirstInput;
begin
  inpt.Kind := fikNone;
  Result    := ShowInplaceEditor(inpt);
end;

function TLMDCustomGrid.ShowInplaceEditor(
  const AInput: TLMDGridFirstInput): Boolean;
var
  k, v: Variant;
  from: TCustomForm;
begin
  from   := GetParentForm(Self);
  Result := HandleAllocated and IsActiveControl and Visible and Enabled and
            (not IsEditorShown) and HaveVisibleCols and CanEdit and
            (CurrentColumn <> -1) and InternalIsColumnDataBound( CurrentColumn ) and
            ((from = nil) or (from.Visible and from.Enabled));

  if not Result then
    Exit;

  BeginInternal;
  try
    if not (isHaveVisibleRows in FState) then
      InitNewRecMode(True)
    else if (not IsNewRecMode) and (not IsRowEditMode) and CanStoreRowEdit then
      InitRowEditMode;
  finally
    EndInternal;
  end;

  GetDataCellLow(CurrentColumn, CurrentRow, k, v);
  EditPanel(Self).SetColumn(Columns[CurrentColumn]);
  EditPanel(Self).SetData(k, v, True);
  EditPanel(Self).Show(GetInplaceEditRect, AInput);

  Include(FState, isEditing);
  InvalidateIndicator;
end;

procedure TLMDCustomGrid.ClearColumns;
var
  col: TLMDGridColumn;
begin
  while Columns.Count > 0 do
  begin
    col := Columns[0];
    RemoveColumn(col);

    col.Free;
  end;
end;

procedure TLMDCustomGrid.Click;
begin
  if not (isNoClick in FState) then
    inherited;
end;

procedure TLMDCustomGrid.ColumnDeleting(AColumn: TLMDGridColumn);
begin
  if FCustomSource <> nil then
    FCustomSource.ColumnDeleting(AColumn)
  else
    TInternalStore(FStore).DeleteColumn(AColumn.Position);
end;

procedure TLMDCustomGrid.ColumnMoved(FromIndex, ToIndex: Integer);
begin
  Assert(InInternal);
end;

procedure TLMDCustomGrid.ColumnMoving(AFrom, ATo: Integer);
var
  col: TLMDGridColumn;
begin
  if FCustomSource <> nil then
    FCustomSource.ColumnMoved(FColumns[AFrom], ATo)
  else
    TInternalStore(FStore).MoveColumn(AFrom, ATo);

  col := Columns[AFrom];
  if col.Visible then
  begin
    if AFrom = FSelectionAnchor.X then
      FSelectionAnchor.X := ATo
    else if (AFrom > FSelectionAnchor.X) and (ATo <= FSelectionAnchor.X) then
      Inc(FSelectionAnchor.X)
    else if (AFrom < FSelectionAnchor.X) and (ATo > FSelectionAnchor.X) then
      Dec(FSelectionAnchor.X);
  end;
end;

procedure TLMDCustomGrid.MoveDataRow(AFrom, ATo: Integer);
begin
  if AFrom = ATo then
    Exit;

  BeginUpdateLow(True, True);
  try
    if FCustomSource <> nil then
      FCustomSource.MoveRow(AFrom, ATo)
    else
      TInternalStore(FStore).MoveRow(AFrom, ATo);
  finally
    EndUpdateLow;
  end;
end;

function TLMDCustomGrid.ConfirmDeleteCurrentRow: Boolean;
begin
  Result := MessageDlg(SLMDGridConfirmRowDel, mtConfirmation,
                       [mbOk, mbCancel], 0) = mrOk;
end;

procedure TLMDCustomGrid.ColumnAdded(AColumn: TLMDGridColumn);
var
  hasvis: Boolean;
  i: Integer;
begin
  if FCustomSource <> nil then
    FCustomSource.ColumnAdded(AColumn)
  else
    TInternalStore(FStore).AppendColumn;

  if AColumn.Visible then
  begin
    if (Columns.Count > 1) and (AColumn.Position <= CurrentColumn) then
    begin
      hasvis := False;
      for i := AColumn.Position + 1 to Columns.Count - 1 do
        if Columns[i].Visible then
        begin
          hasvis := True;
          Break; // for
        end;

      if hasvis then
        CurrentColumn := CurrentColumn + 1;
    end;

    if AColumn.Position <= FSelectionAnchor.X then
      Inc(FSelectionAnchor.X);
  end;
end;

procedure TLMDCustomGrid.ColumnAdding(AColumn: TLMDGridColumn);
begin
  // Do nothing.
end;

constructor TLMDCustomGrid.Create(AOwner: TComponent);
begin
  inherited;

  FCustomSource := nil;
  FStyle := nil;
  FChangeFlags := [];
  FScrollBarsStyle := ssBoth;

  FEditHelper := TEditHelper.Create(Self);
  FMoveSizeTimer := TTimer.Create(nil);
  FMoveSizeTimer.OnTimer := OnMoveSizeTimer;
  FMoveSizeTimer.Interval := MOVE_SIZE_TIMER_INTERVAL;
  FMoveSizeTimer.Enabled := False;
  FSizeMoveIdx := -1;

  FEditPanel := TEditPanel.Create(Self);

  FCellBmp := TBitmap.Create;
  FMovingBmp := TBitmap.Create;

  FOptions := DefOptions;
  SetBaseOptions(FOptions);

  Font.OnChange := OnFontChange;

  FThemeMode := ttmPlatform;
  FThemeGlobalMode := False;

  FUpdateCnt := 0;
  FInternalCnt := 0;
  FSetColDefModeCnt := 0;
  FInitColModeCnt := 0;

  FStore := TInternalStore.Create(Self);

  FColumns := nil;
  FColumns := TLMDGridColumns.Create(Self);

  FStyle  := nil;
  FStyle  := TLMDGridStyle.Create(Self);

  FSaveCellExtents := False;

  ResetHoverCell;

  FState := [];
  SyncGridStore;

  DefaultDrawing := False;
  VirtualView := True;
  DefaultRowHeight := 18;

  CancelSelectionLow;

  if Assigned(LMDDesignSelectionNotifyRegister) then
    LMDDesignSelectionNotifyRegister(Self, True, OnDesignSelectonChanged);

  InternalSetupScrollBarsStyle;
end;

procedure TLMDCustomGrid.DeleteCurrentRow;
begin
  if CurrentRow = -1 then
    raise ELMDGridError.Create(SLMDGridNoCurrentRow);
  DeleteDataRow(CurrentRow);
end;

procedure TLMDCustomGrid.DeleteDataRow(ARow: Integer);
var
  curidx: Integer;
begin
  CheckRowIdx(ARow);

  curidx := CurrentRow;
  BeginUpdateLow(True, True);
  try
    CancelSelection;

    if (ARow = CurrentRow) and IsNewRecMode then
      ExitNewRecMode(False)
    else
    begin
      if IsRowEditMode then
      begin
        Assert(ARow = CurrentRow);

        HideInplaceEditor(False, True);
        ExitRowEditMode(False)
      end
      else
        HideInplaceEditor(curidx <> ARow, True);

      InternalDeleteDataRow(ARow, curidx);
      SyncGridStore;

      if DataRowCount > 0 then
        CurrentRow := curidx;
    end;

    CancelSelection;
  finally
    EndUpdateLow;
  end;
end;

function TLMDCustomGrid.DesignWndProc(var Message: TMessage): Boolean;
var
  x, y:     Integer;
  cell:     TGridCoord;
  isHeader: Boolean;
begin
  // All real processing is done in CM_DESIGNHITTEST, but this
  // code is also required to prevent design-time flickering.

  if (Message.Msg = WM_LBUTTONDOWN) and NoMovingSizingState then
  begin
    x        := TWMLButtonDown(Message).XPos;
    y        := TWMLButtonDown(Message).YPos;
    cell     := MouseCoord(x, y);
    isHeader := IsDataCol(cell.x) and IsHeaderRow(cell.y);

    if isHeader then
    begin
      Result := True;
      Exit;
    end
  end;

  Result := inherited DesignWndProc(Message);
end;

destructor TLMDCustomGrid.Destroy;
begin
  if Assigned(LMDDesignSelectionNotifyRegister) then
    LMDDesignSelectionNotifyRegister(Self, False, OnDesignSelectonChanged);

  FMoveSizeTimer.Enabled := False;
  IncludeState(isDestroing);
  ClearColumns;
  FreeAndNil(FStore);
  FreeAndNil(FColumns);
  FreeAndNil(FCellBmp);
  FreeAndNil(FMovingBmp);
  FreeAndNil(FEditPanel);
  FreeAndNil(FMoveSizeTimer);
  FreeAndNil(FStyle);
  FreeAndNil(FEditHelper);

  inherited;
end;

procedure TLMDCustomGrid.DoEnter;
begin
  inherited;
end;

procedure TLMDCustomGrid.DoExit;
begin
  if InInternal then
    Exit;

  if Assigned(OnExit) then
    OnExit(Self);
  try
    BeginUpdateLow(False, False);
    try
      if opCancelOnExit in Options then
      begin
        HideInplaceEditor(False, False);
        ExitNewRecMode(False);
        ExitRowEditMode(False);
      end
      else if not (opAlwaysShowEditor in Options) then
        HideInplaceEditor(True, False);
    finally
      EndUpdateLow(True);
    end;
  except
    SetFocus;
    raise;
  end;
end;

procedure TLMDCustomGrid.DoKeyPressW(var AMsg: TWMKey);
var
  from: TCustomForm;
  key:  TLMDChar;
begin
  key  := LMDGetCharFromMsg(AMsg);
  from := GetParentForm(Self);

  if (from <> nil) and (from <> TWinControl(Self)) and from.KeyPreview and
    (key <= High(AnsiChar)) and TWinControlAccess(from).DoKeyPress(AMsg)
  then
    Exit;

  if (csNoStdEvents in ControlStyle) then
    Exit;

  if Assigned(FOnKeyPressW) then
    FOnKeyPressW(Self, key);

  if (TLMDChar(key) <> #0) and 
     (TLMDChar(key) <> #$1B) then // #$1B is escape char. Strange...
    KeyPressW(key);
end;

function TLMDCustomGrid.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := False;
  if Assigned(OnMouseWheelDown) then
    OnMouseWheelDown(Self, Shift, MousePos, Result);

  if not Result and not (csDesigning in ComponentState) then
  begin
    CurrentRow := CurrentRow + 1;
    Result     := True; // Handled.
  end;
end;

function TLMDCustomGrid.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := False;
  if Assigned(OnMouseWheelUp) then
    OnMouseWheelUp(Self, Shift, MousePos, Result);

  if not Result and not (csDesigning in ComponentState) then
  begin
    CurrentRow := CurrentRow - 1;
    Result     := True; // Handled.
  end;
end;

function TLMDCustomGrid.BeginColumnDrag(var Origin, Destination: Integer;
  const MousePt: TPoint): Boolean;
begin
  Result := IsDataCol(Origin);
end;

procedure TLMDCustomGrid.BeginInternal;
begin
  Inc(FInternalCnt);
end;

function TLMDCustomGrid.BeginRowDrag(var Origin, Destination: Integer;
  const MousePt: TPoint): Boolean;
begin
  Result := IsDataRow(Origin);
end;

function TLMDCustomGrid.EndColumnDrag(var Origin, Destination: Integer;
  const MousePt: TPoint): Boolean;
var
  dest: Integer;
begin
  BeginUpdateLow(False, True);
  try
    if Origin < Destination then
      Dec(Destination);

    CancelSelection;

    dest := Max(0, Destination);
    Columns[GridColToDataCol(Origin)].Position := GridColToDataCol(dest);

    CancelSelection;

    Origin := dest; // Column already moved; so, prevent futher
                    // actions in inherited code.
    Result := True;
  finally
    EndUpdateLow;
  end;
end;

procedure TLMDCustomGrid.EndEditing(ACommit: Boolean);
begin
  ExitRowEditMode(ACommit); // For sure
  HideInplaceEditor(ACommit, True);
end;

procedure TLMDCustomGrid.EndInternal;
begin
  Dec(FInternalCnt);
  Assert(FInternalCnt >= 0);
end;

function TLMDCustomGrid.EndRowDrag(var Origin, Destination: Integer;
  const MousePt: TPoint): Boolean;
begin
  BeginUpdateLow(False, True);
  try
    CancelSelection;

    if Origin >= Destination then
      MoveRow(Origin, Destination)
    else
      MoveRow(Origin, Destination - 1);

    CancelSelection;
    Result := True;
  finally
    EndUpdateLow;
  end;
end;

procedure TLMDCustomGrid.DoThemeChanged;
begin
  ResetColumnsPaintCache;
  if IsEditorShown then
    EditPanel(Self).UpdateAll;

  Invalidate;
end;

procedure TLMDCustomGrid.UpdateInplaceEditState;
begin
  if not IsEditorShown then
    Exit;

  Assert(HaveVisibleData);
  EditPanel(Self).Update(GetInplaceEditRect);
end;

function TLMDCustomGrid.IsUpdating: Boolean;
begin
  Result := FUpdateCnt <> 0;
end;

function TLMDCustomGrid.UseAlternate: Boolean;
begin
  Result := True;
end;

function TLMDCustomGrid.UseThemeMode: TLMDThemeMode;
begin
  if FThemeGlobalMode then
    Result := LMDApplication.ThemeGlobalMode
  else
    Result := FThemeMode;

  Result := LMDThemeServices.UseTheme(Result);
end;

function TLMDCustomGrid.VisibleColToCol(AVisCol: Integer): Integer;
var
  i, j: Integer;
begin
  Assert(HaveVisibleCols);
  j := 0;
  while not Columns[j].Visible  do
    Inc(j);

  i := 0;
  while i <> AVisCol do
  begin
    Inc(i);
    Inc(j);

    while not Columns[j].Visible  do
      Inc(j);
  end;

  Result := j;
end;

function TLMDCustomGrid.VisibleColumnsCount: Integer;
var
  i: Integer;
begin
  Result := 0;

  for i := 0 to Columns.Count - 1 do
  begin
    if Columns[i].Visible then
      Inc(Result);
  end;
end;

function TLMDCustomGrid.CreateEditor: TInplaceEdit;
begin
  Result := nil;
  Assert(False);
end;

procedure TLMDCustomGrid.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AMoving: Boolean; ACanvas: TCanvas);
const
  PadH = 3; PadV = 2; ArrW = 9; ArrH = 4;
var
  kind:          TLMDGridCellKind;
  colObj:        TLMDGridColumn;
  cs:            TLMDGridCellStates;
  luseThemeMode: TLMDThemeMode;
  details:       TThemedElementDetails;
  hdr:           TThemedHeader;
  arrowColor, clr: TColor;
  arrState:      Integer;
  p1, p2, p3:    TPoint;
  i, sortW:      Integer;
  r, textR:      TRect;
  calkFlags, frameFlags, flags, x0, y0, h, w: Integer;
  dataCol, grCol, dataRow: Integer;
  s:             TLMDString;
  tm:            TTextMetric;
  imgs:          TImageList;
  bmp:           TBitmap;
  cli:           Integer;
  v, formattedV: Variant;
  rowState:      TLMDGridRowState;
  dsclr:         TColor;
begin
  frameFlags    := 0;
  luseThemeMode := UseThemeMode;
  cs            := GetCellState(ACol, ARow); // csHover.
  kind          := GetCellKind(ACol, ARow);
  rowState      := GetCellRowState(ACol, ARow);

  case kind of
    ckHeader, ckDummyHeader:
    begin
      if opHeaderVertLine in Options then
        frameFlags := frameFlags or BF_RIGHT;
      if opIndicatorHorzLine in Options then
        frameFlags := frameFlags or BF_BOTTOM;
    end;
    ckIndicator:
    begin
      if opIndicatorHorzLine in Options then
        frameFlags := frameFlags or BF_BOTTOM;
      if opHeaderVertLine in Options then
        frameFlags := frameFlags or BF_RIGHT;
    end;
    ckData, ckNewRow:
    begin
      if opVertLine in Options then
        frameFlags := frameFlags or BF_RIGHT;
      if opHorzLine in Options then
        frameFlags := frameFlags or BF_BOTTOM;
    end;
  end;

  case kind of
    ckIndicator:
    begin
      if AMoving then
      begin
        ACanvas.Brush.Color := Style.HeaderMovingColor;
        ACanvas.FillRect(ARect);
        textR := ARect;
      end
      else
      begin
        r := ARect;

        ACanvas.Brush.Color := GetStyledColor(Style.IndicatorBgColor);
        ACanvas.FillRect(r);

        DrawStyledEdge(ACanvas, r, frameFlags or BF_ADJUST);
        h := (ARect.Bottom - r.Bottom) div 2;

        textR        := r;
        textR.Top    := ARect.Top + h;
        textR.Bottom := ARect.Bottom - h;

        if (BF_BOTTOM and frameFlags) <> 0 then
        begin
          r := ARect;
          Dec(r.Right);
          DrawStyledEdge(ACanvas, r, BF_TOP);
        end;
      end;

      if (rowState <> rsNormal) and (not AMoving) then
      begin
        imgs := LMDGridImagesForm.IndicatorImages;

        case rowState of
          rsCurrentNormal:
          begin
            bmp := Style.IndicatorCurrentImg;
            i := 0;
          end;
          rsCurrentEditing:
          begin
            bmp := Style.IndicatorEditingImg;
            i := 1;
          end;
          rsCurrentNewRow:
          begin
            bmp := Style.IndicatorNewRowImg;
            i := 2;
          end
        else
          i := -1;
          bmp := nil;
        end;

        if bmp.Empty then
        begin
          w := imgs.Width;
          h := imgs.Height;
        end
        else
        begin
          w := bmp.Width;
          h := bmp.Height;
        end;

        r.Left := (textR.Left + textR.Right - w) div 2;
        r.Top  := (textR.Top + textR.Bottom - h) div 2;

        if bmp.Empty then
          imgs.Draw(ACanvas, r.Left, r.Top, i)
        else
          ACanvas.Draw(r.Left, r.Top, bmp);
      end;

      if Assigned(FOnDrawIndicator) then
        FOnDrawIndicator(Self, ACanvas, ARect, cs, rowState,
                         GridRowToDataRow(ARow));
    end;

    ckHeader,
    ckDummyHeader:
    begin
      if kind = ckHeader then
        colObj := Columns[ GridColToDataCol(ACol) ]
      else
        colObj := nil;

      if csColumnUnbound in cs then
        hdr := thHeaderItemNormal
      else if kind = ckDummyHeader then
        hdr := thHeaderItemNormal
      else if ([csPressed, csMovingCol, csMovingRow] * cs) <> []  then
        hdr := thHeaderItemPressed
      else if (csHover in cs) and (opHighlightHeaders in Options) then
        hdr := thHeaderItemHot
      else
        hdr := thHeaderItemNormal;

      if (isColSizing in FState) and (not AMoving) then
        grCol := FSizeMoveIdx
      else
        grCol := -1;

      if luseThemeMode <> ttmNone then
      begin
        details := ThemeServices.GetElementDetails(hdr);

        if AMoving then
          cli := TMT_EDGESHADOWCOLOR
        else
          cli := TMT_EDGELIGHTCOLOR;

        clr := LMDThemeServices.GetThemeColor(luseThemeMode, teHeader,
                                              HP_HEADERITEM, HIS_NORMAL,
                                              cli);
        if clr = clNone then  // Native themes report clNone.
          clr := clBtnShadow; //

        ACanvas.Brush.Color := clr;
        ACanvas.FillRect(ARect);

        if AMoving then
          textR := ARect
        else
        begin
          LMDThemeServices.DrawElement(luseThemeMode, ACanvas.Handle, details, ARect);
          textR := LMDThemeServices.ContentRect(luseThemeMode, ACanvas.Handle, details, ARect);

          if (textR.Left >= textR.Right) or   // VCL themes report empty
             (textR.Top >= textR.Bottom) then // content rect.
            textR := ARect;
        end;
      end
      else
      begin
        if hdr = thHeaderItemHot then
          ACanvas.Brush.Color := Style.HeaderHighlightColor
        else if AMoving then
          ACanvas.Brush.Color := Style.HeaderMovingColor
        else
          ACanvas.Brush.Color := Style.HeaderBgColor;

        if AMoving or (grCol = ACol) then
        begin
          ACanvas.FillRect(ARect);
          textR := ARect;
        end
        else
        begin
          r := ARect;
          DrawEdge(ACanvas.Handle, r, EDGE_ETCHED, frameFlags or BF_ADJUST);
          textR := r;

          w := (ARect.Right - r.Right) div 2;
          ACanvas.FillRect(ARect);

          r := ARect;
          Inc(r.Right, w);
          DrawEdge(ACanvas.Handle, r, EDGE_ETCHED, frameFlags);

          r := ARect;
          r.Left := ARect.Left - 10;
          r.Right := ARect.Left + w;

          DrawEdge(ACanvas.Handle, r, EDGE_ETCHED, frameFlags);

          textR.Left := ARect.Left + w;
          textR.Right := ARect.Right - w;
        end;
      end;

      if (colObj <> nil) and (grCol <> ACol) then
      begin
        if csDesignerSelected in cs then
        begin
          {$IFDEF LMDCOMP9}
          dsclr := $FFA300; // Match new IDE blue selection style.
          {$ELSE}
          dsclr := clBlack; // Old Delphi7 black selection style.
          {$ENDIF}

          r := Rect(ARect.Left, ARect.Top + 2, ARect.Left + 2,
                    ARect.Bottom - 2 - 1);
          LMDAlphaFillRect(ACanvas, r, dsclr, 200);

          r := Rect(ARect.Left, ARect.Top, ARect.Right - 1, ARect.Top + 2);
          LMDAlphaFillRect(ACanvas, r, dsclr, 200);

          r := Rect(ARect.Right - 2 - 1, ARect.Top + 2, ARect.Right - 1,
                    ARect.Bottom - 2 - 1);
          LMDAlphaFillRect(ACanvas, r, dsclr, 200);

          r := Rect(ARect.Left - 1, ARect.Bottom - 2 - 1, ARect.Right - 1, ARect.Bottom - 1);
          LMDAlphaFillRect(ACanvas, r, dsclr, 200);
        end;

        bmp := nil;
        if colObj.SortKind <> skNone then
        begin
          case colObj.SortKind of
            skAsc: bmp := Style.SortArrowAscImg;
            skDesc: bmp := Style.SortArrowDescImg;
          end;

          if bmp.Empty then
            sortW := ArrW
          else
            sortW := bmp.Width;
        end
        else
          sortW := 0;

        s := colObj.Title.Caption;
        flags := DT_NOPREFIX or DT_SINGLELINE;

        case colObj.Title.Alignment of
          Classes.taLeftJustify:  flags := flags or DT_LEFT;
          Classes.taRightJustify: flags := flags or DT_RIGHT;
          Classes.taCenter:       flags := flags or DT_CENTER;
        end;

        case colObj.Title.VertAlignment of
          taAlignTop:       flags := flags or DT_TOP;
          taAlignBottom:    flags := flags or DT_BOTTOM;
          taVerticalCenter: flags := flags or DT_VCENTER;
        end;

        Inc(textR.Left, PadH);
        Inc(textR.Top, PadV);
        Dec(textR.Bottom, PadV);

        if sortW <> 0 then
          Dec(textR.Right, sortW + PadH * 2)
        else
          Dec(textR.Right, PadH);

        ACanvas.Font.Assign(colObj.Title.Font);

        if csColumnUnbound in cs then
          ACanvas.Font.Color := clGrayText
        else if luseThemeMode <> ttmNone then
        begin
          clr := LMDThemeServices.GetThemeColor(luseThemeMode, details,
                                                TMT_TEXTCOLOR);
          if clr = clNone then
            clr := clWindowText;
          ACanvas.Font.Color := clr;
        end;

        r := textR;
        calkFlags := DT_NOPREFIX or DT_SINGLELINE or DT_LEFT or
                     DT_TOP or DT_CALCRECT;

        ACanvas.Brush.Style := bsClear;
        ACanvas.Refresh;

        h := LMDDrawText(ACanvas.Handle, s, Length(s), r, calkFlags);
        w := r.Right - r.Left;

        r := textR;
        LMDDrawText(ACanvas.Handle, s, Length(s), r, flags);

        if colObj.SortKind <> skNone then
        begin
          GetTextMetrics(ACanvas.Handle, tm);

          case colObj.Title.Alignment of
            Classes.taLeftJustify:  x0 := textR.Left + w + PadH;
            Classes.taCenter:       x0 := ((textR.Left + textR.Right + w) div 2) + PadH;
            Classes.taRightJustify: x0 := textR.Right + PadH;
          else
            x0 := -1;
          end;

          p1.X := x0;
          p2.X := p1.X + sortW - 1;
          p3.X := (p1.X + p2.X) div 2;

          case colObj.Title.VertAlignment of
            taAlignTop:       y0 := textR.Top + tm.tmInternalLeading + 1;
            taVerticalCenter: y0 := textR.Top + (((textR.Bottom - textR.Top) - h) div 2) +
                                    tm.tmInternalLeading + 1;
            taAlignBottom:    y0 := textR.Bottom - h + tm.tmInternalLeading + 1;
          else
            y0 := -1;
          end;

          case colObj.SortKind of
            skDesc:
            begin
              arrState := HSAS_SORTEDDOWN;

              p1.Y := y0;
              p2.Y := p1.Y;
              p3.Y := p1.Y + ArrH;
            end;

            skAsc:
            begin
              arrState := HSAS_SORTEDUP;

              p3.Y := y0;
              p1.Y := p3.Y + ArrH;
              p2.Y := p1.Y;
            end;
          else
            arrState := -1;
            Assert(False);
          end;

          if bmp.Empty then
          begin
            if luseThemeMode <> ttmNone then
              arrowColor := LMDThemeServices.GetThemeColor(luseThemeMode, teHeader,
                                                           HP_HEADERSORTARROW, arrState,
                                                           TMT_EDGESHADOWCOLOR)
            else
              arrowColor := Style.SortArrowColor;


            ACanvas.Brush.Style := bsSolid;
            ACanvas.Brush.Color := arrowColor;
            ACanvas.Pen.Color := arrowColor;

            ACanvas.Polygon([p1, p2, p3]);
          end
          else
            ACanvas.Draw(p1.X, y0, bmp);
        end;
      end
      else if kind = ckDummyHeader then
      begin
        if opShowColumnsChooser in Options then
        begin
          bmp := Style.ChooseColumnsImg;

          imgs := LMDGridImagesForm.OtherImages;
          if bmp.Empty then
          begin
            r.Left := (ARect.Left + ARect.Right - imgs.Width) div 2 - 1;
            r.Top  := (ARect.Top + ARect.Bottom - imgs.Height) div 2;

            imgs.Draw(ACanvas, r.Left, r.Top, 0)
          end
          else
          begin
            r.Left := (ARect.Left + ARect.Right - bmp.Width) div 2 - 1;
            r.Top  := (ARect.Top + ARect.Bottom - bmp.Height) div 2;

            ACanvas.Draw(r.Left, r.Top, bmp);
          end;
        end;
      end;

      if Assigned(FOnDrawHeaderCell) then
      begin
        if colObj <> nil then
        begin
          s := colObj.Title.Caption;
          FOnDrawHeaderCell(Self, ACanvas, ARect, cs, s, False, colObj);
        end
        else
        begin
          s := '';
          FOnDrawHeaderCell(Self, ACanvas, ARect, cs, s, True, nil);
        end;
      end;
    end;

    ckData,
    ckNewRow:
    begin
      Assert(HaveVisibleCols);

      dataCol := GridColToDataCol(ACol);
      dataRow := GridRowToDataRow(ARow);
      colObj  := Columns[dataCol];

      if InSelection(dataCol, dataRow) then
      begin
        cs := cs + [csInSelectedArea];

        if not InSelection(dataCol - 1, dataRow) then
          cs := cs + [csSelLeft];
        if not InSelection(dataCol, dataRow - 1) then
          cs := cs + [csSelTop];
        if not InSelection(dataCol + 1, dataRow) then
          cs := cs + [csSelRight];
        if not InSelection(dataCol, dataRow + 1) then
          cs := cs + [csSelBottom];

        if (dataRow = CurrentRow) and (dataCol = CurrentColumn) then
        begin
          cs := cs + [csSelectedCell];
          r  := GetSelRect;
          if ((r.Left - r.Right) = 0) and ((r.Top - r.Bottom) = 0) then
            cs := cs + [csSingleCellSelection];
          if isEditing in FState then
            cs := cs + [csEditing];
        end;
      end;

      with colObj do
        r := Rect(PaddingLeft, PaddingTop, PaddingRight, PaddingBottom);

      colObj.PaintCellBG(ACanvas, dataRow, ARect, cs, True, r, textR);

      if isHaveVisibleRows in FState then
      begin
        if not (csColumnUnbound in cs) then
        begin
          v          := GetDataCell(dataCol, dataRow);
          formattedV := colObj.FormatPaintData(v);

          ACanvas.Refresh;
          colObj.PaintFormattedCellData(ACanvas, textR, formattedV,
                                        colObj.Alignment, cs);
        end
        else
        begin
          v          := Null;
          formattedV := Null;
        end;

        if Assigned(FOnDrawDataCell) then
          FOnDrawDataCell(Self, ACanvas, ARect, cs, rowState, v, formattedV,
                          colObj, dataRow);
      end;
    end;
  else
    Assert(False);
  end;
end;

procedure TLMDCustomGrid.DrawStyledEdge(C: TCanvas; var R: TRect;
  AFlags: Integer);
var
  rct:   TRect;
  hlght: TColor;
  shdw:  TColor;
begin
  rct   := R;
  hlght := GetStyledColor(clBtnHighlight);
  shdw  := GetStyledColor(clBtnShadow);

  if (BF_RIGHT and AFlags) <> 0 then
  begin
    C.Pen.Color := shdw;
    C.MoveTo(rct.Right - 1, rct.Top);
    C.LineTo(rct.Right - 1, rct.Bottom);
    Dec(rct.Right);
  end;

  if (BF_BOTTOM and AFlags) <> 0 then
  begin
    C.Pen.Color := shdw;
    C.MoveTo(rct.Left, rct.Bottom - 1);
    C.LineTo(rct.Right, rct.Bottom - 1);
    Dec(rct.Bottom);
  end;

  if (BF_LEFT and AFlags) <> 0 then
  begin
    C.Pen.Color := hlght;
    C.MoveTo(rct.Left, rct.Top);
    C.LineTo(rct.Left, rct.Bottom);
    Inc(rct.Left);
  end;

  if (BF_TOP and AFlags) <> 0 then
  begin
    C.Pen.Color := hlght;
    C.MoveTo(rct.Left, rct.Top);
    C.LineTo(rct.Right, rct.Top);
    Inc(rct.Top);
  end;

  if (BF_ADJUST and AFlags) <> 0 then
    R := rct;
end;

function TLMDCustomGrid.PageExtents: TSize;
var
  drawInfo: TGridDrawInfo;
begin
  if HandleAllocated then
  begin
    CalcDrawInfo(drawInfo);
    Result.cx := drawInfo.Horz.LastFullVisibleCell - LeftCol + 1;

    if Result.cx < 1 then
      Result.cx := 1;

    Result.cy := drawInfo.Vert.LastFullVisibleCell - TopRow + 1;

    if Result.cy < 1 then
      Result.cy := 1;
  end
  else
  begin
    Result.cx := 1;
    Result.cy := 1;
  end;
end;

function TLMDCustomGrid.PageHeight: Integer;
begin
  Result := PageExtents.cy;
end;

function TLMDCustomGrid.PageWidth: Integer;
begin
  Result := PageExtents.cx;
end;

function TLMDCustomGrid.CanEdit: Boolean;
begin
  Result := (opEditing in Options) and HaveVisibleData and CanStoreEdit;
end;

function TLMDCustomGrid.CanInsert: Boolean;
begin
  Result := (opEditing in Options) and HaveVisibleCols and CanStoreInsert;
end;

function TLMDCustomGrid.CanMoveCol: Boolean;
begin
  Result := (opColMoving in Options) and HaveVisibleCols and CanStoreMoveCol;
end;

function TLMDCustomGrid.CanMoveRow: Boolean;
begin
  Result := (opRowMoving in Options) and HaveVisibleData and CanStoreMoveRow;
end;

function TLMDCustomGrid.CanRemove: Boolean;
begin
  Result := (opEditing in Options) and HaveVisibleData and CanStoreRemove;
end;

function TLMDCustomGrid.CanStoreEdit: Boolean;
begin
  Result := (FCustomSource = nil) or (spCanEdit in FCustomSource.GetProps);
end;

function TLMDCustomGrid.CanStoreInsert: Boolean;
begin
  Result := (FCustomSource = nil) or (spCanChangeRows in FCustomSource.GetProps);
end;

function TLMDCustomGrid.CanStoreMoveCol: Boolean;
begin
  Result := (FCustomSource = nil) or (spCanChangeCols in FCustomSource.GetProps);
end;

function TLMDCustomGrid.CanStoreMoveRow: Boolean;
begin
  Result := (FCustomSource = nil) or (spCanChangeRows in FCustomSource.GetProps);
end;

function TLMDCustomGrid.CanStoreRemove: Boolean;
begin
  Result := (FCustomSource = nil) or (spCanChangeRows in FCustomSource.GetProps);
end;

function TLMDCustomGrid.MouseCoord(X, Y: Integer): TGridCoord;
begin
  Result := inherited MouseCoord(X, Y);
  if not HaveVisibleCols then
  begin
    Result.X := -1;
    Result.Y := -1;
  end
  else if (not HaveRows) and (Result.Y > 0) then
  begin
    Result.X := -1;
    Result.Y := -1;
  end;
end;

function TLMDCustomGrid.CellRect(ACol, ARow: Longint): TRect;
begin
  Result := Rect(0, 0, 0, 0);

  if HaveVisibleCols then
  begin
    if HaveRows or IsHeaderRow(ARow) then
      Result := inherited CellRect(ACol, ARow);
  end;
end;

procedure TLMDCustomGrid.Paint;

  function ScreenToScroll(ACol, ARow: Integer): TPoint;
  begin
    if ACol < FixedCols then
      Result.X := ACol
    else
      Result.X := LeftCol + (ACol - FixedCols);

    if ARow < FixedRows then
      Result.Y := ARow
    else
      Result.Y := TopRow + (ARow - FixedRows);
  end;

  function IsFixed(ACol, ARow: Integer): Boolean;
  begin
    Result := (ACol < FixedCols) or (ARow < FixedRows);
  end;

var
  updateRect:          TRect;
  col, row:            Integer;
  lastX, lastY:        Integer;
  idx:                 Integer;
  w, rh, h:            Integer;
  cell:                TPoint;
  r, r0, ri:           TRect;
  bmpRect, moveRect:   TRect;
  mr, mr2:             TRect;
  bmp:                 TBitmap;
  s:                   TLMDString;
  autoColumnsSelected: Boolean;
  flags:               Integer;
begin
  if FUpdateCnt > 0 then
    Exit;

  autoColumnsSelected := (csDesigning in ComponentState) and
                         HaveSelectedAutoColumns;
  updateRect          := Canvas.ClipRect;

  if MovingState then
  begin
    if isColMoving in FState then
    begin
      r              := CellRect(LeftCol, 0);
      moveRect       := r;
      moveRect.Left  := FMouseMovePt.X - FMoveOffset.X;
      moveRect.Right := moveRect.Left + ColWidths[FSizeMoveIdx];
    end
    else
    begin
      r               := CellRect(0, TopRow);
      moveRect        := r;
      moveRect.Top    := FMouseMovePt.Y - FMoveOffset.Y;
      moveRect.Bottom := moveRect.Top + RowHeights[FSizeMoveIdx];
    end;

    w := moveRect.Right - moveRect.Left;
    h := moveRect.Bottom - moveRect.Top;

    if FMovingBmp.Width < w then
      FMovingBmp.Width  := w;

    if FMovingBmp.Height < h then
      FMovingBmp.Height := h;

    bmpRect := Rect(0, 0, w, h);
    if isColMoving in FState then
      DrawCell(FSizeMoveIdx, 0, bmpRect, True, FMovingBmp.Canvas)
    else
      DrawCell(0, FSizeMoveIdx, bmpRect, True, FMovingBmp.Canvas);
  end
  else if SizingState then
  begin
    if isColSizing in FState then
    begin
      r := CellRect(FSizeMoveIdx, 0);
      moveRect := r;
      moveRect.Right := r.Left + FSizingNewSize;
    end
    else
    begin
      r := CellRect(0, FSizeMoveIdx);
      moveRect := r;
      moveRect.Bottom := r.Top + FSizingNewSize;
    end;

    w := moveRect.Right - moveRect.Left;
    h := moveRect.Bottom - moveRect.Top;

    if FMovingBmp.Width < w then
      FMovingBmp.Width  := w;

    if FMovingBmp.Height < h then
      FMovingBmp.Height := h;

    bmpRect := Rect(0, 0, w, h);
    if isColSizing in FState then
      DrawCell(FSizeMoveIdx, 0, bmpRect, True, FMovingBmp.Canvas)
    else
      DrawCell(0, FSizeMoveIdx, bmpRect, True, FMovingBmp.Canvas);
  end;

  row := 0;
  col := 0;
  lastX := 0; lastY := 0;

  cell := ScreenToScroll(0, 0);
  r0   := CellRect(cell.X, cell.Y);
  Inc(r0.Right, GridLineWidth);
  Inc(r0.Bottom, GridLineWidth);
  r := r0;

  if VisibleColumnsCount > 0 then
  begin
    while True do
    begin
      lastX := r.Right;
      lastY := r.Bottom;

      if IntersectRect(ri, updateRect, r) then
      begin
        w := r.Right - r.Left;
        h := r.Bottom - r.Top;

        if FCellBmp.Width < w then
          FCellBmp.Width  := w;

        if FCellBmp.Height < h then
          FCellBmp.Height := h;

        bmpRect := Rect(0, 0, w, h);
        DrawCell(cell.X, cell.Y, bmpRect, False, FCellBmp.Canvas);

        if MovingState or SizingState then
        begin
          if IntersectRect(mr, r, moveRect) then
          begin
            mr.Left := moveRect.Left - r.Left;
            mr.Right := moveRect.Right - r.Left;
            mr.Top := moveRect.Top - r.Top;
            mr.Bottom := moveRect.Bottom - r.Top;

            mr2.Left := 0;
            mr2.Top := 0;
            mr2.Right := moveRect.Right - moveRect.Left;
            mr2.Bottom := moveRect.Bottom - moveRect.Top;


            LMDAlphaCopyRect(FCellBmp.Canvas.Handle,
                             mr,
                             FMovingBmp.Canvas.Handle,
                             mr2,
                             150, True);
          end;
        end;

        Canvas.CopyRect(r, FCellBmp.Canvas, bmpRect);
      end;

      Inc(col);

      cell := ScreenToScroll(col, row);

      if (cell.X < ColCount) and (r.Right < updateRect.Right) then
      begin
        r.Left := r.Right;
        r.Right := r.Left + ColWidths[cell.X] + GridLineWidth;
      end
      else
      begin
        col := 0;
        Inc(row);
        cell := ScreenToScroll(col, row);
        idx := GridRowToDataRow(cell.Y);
        if (idx < DataRowCount) and (not autoColumnsSelected) then
        begin
          r.Left := r0.Left;
          r.Right := r0.Right;

          r.Top := r.Bottom;
          r.Bottom := r.Top + RowHeights[cell.Y] + GridLineWidth;

          if r.Top > updateRect.Bottom then
            Break;
        end
        else
          Break;
      end;
    end;
  end;

  ///////////////
  Canvas.Brush.Color := GetStyledColor(Color);

  if (([isColMoving, isColSizing] * FState) <> []) and
     (moveRect.Right > lastX)
  then
  begin
    if moveRect.Left < lastX then
      ExcludeClipRect(Canvas.Handle, moveRect.Left, moveRect.Top, lastX, moveRect.Bottom);

    mr := Rect(0, 0, moveRect.Right - moveRect.Left, moveRect.Bottom - moveRect.Top);
    Canvas.CopyRect(moveRect, FMovingBmp.Canvas, mr);

    ExcludeClipRect(Canvas.Handle, moveRect.Left, moveRect.Top, moveRect.Right, moveRect.Bottom);
  end;

  r.Left := lastX;
  r.Right := ClientWidth;
  r.Top := 0;
  r.Bottom := ClientHeight;

  Canvas.FillRect(r);
  ///////////////

  if (([isRowMoving, isRowSizing] * FState) <> []) and
     (moveRect.Bottom > lastY) then
  begin
    if moveRect.Top < lastY then
      ExcludeClipRect(Canvas.Handle, moveRect.Left, moveRect.Top, moveRect.Right, lastY);

    mr := Rect(0, 0, moveRect.Right - moveRect.Left, moveRect.Bottom - moveRect.Top);
    Canvas.CopyRect(moveRect, FMovingBmp.Canvas, mr);

    ExcludeClipRect(Canvas.Handle, moveRect.Left, moveRect.Top, moveRect.Right, moveRect.Bottom);
  end;

  r.Left := 0;
  r.Right := lastX;
  r.Top := lastY;
  r.Bottom := ClientHeight;

  Canvas.FillRect(r);
  ///////////////

  if ([isColMoving, isRowMoving] * FState) <> [] then
  begin
    r := GetMoveDropRect(FMoveDropIdx, isColMoving in FState);

    if isColMoving in FState then
    begin
      bmp := Style.DropArrowColumnImg;
      idx := 1;
    end
    else
    begin
      bmp := Style.DropArrowRowImg;
      idx := 0;
    end;

    if bmp.Empty then
      LMDGridImagesForm.ArrowImages.Draw(Canvas, r.Left, r.Top, idx)
    else
      Canvas.Draw(r.Left, r.Top, bmp);
  end;

  if (not HaveRows) or autoColumnsSelected then
  begin
    r.Left := 0;
    r.Right := ClientWidth;
    r.Top := lastY;
    r.Bottom := ClientHeight;

    if autoColumnsSelected then
    begin
      Canvas.Font.Assign(Style.EmptyBannerFont);

      s := SLMDGridAutoColumnsSelected;

      flags := DT_NOPREFIX or DT_WORDBREAK or DT_VCENTER or DT_CENTER;
      rh := r.Bottom - r.Top;
      r0 := r;
      h := LMDDrawText(Canvas.Handle, s, Length(s), r, flags or DT_CALCRECT);
      h := Min(h, rh);

      r0.Top := r.Top + ((rh - h) div 2);

      LMDDrawText(Canvas.Handle, s, Length(s), r0, DT_NOPREFIX or
                  DT_WORDBREAK or DT_CENTER);
    end
    else if opShowEmptyBanner in Options then
    begin
      if Assigned(FPaintEmptyBanner) then
        FPaintEmptyBanner(Self, Canvas, r)
      else
      begin
        Canvas.Font.Assign(Style.EmptyBannerFont);

        s := Style.EmptyBanner;
        if s = '' then
          s := SLMDGridEmptyBanner;

        LMDDrawText(Canvas.Handle, s, Length(s), r, DT_NOPREFIX or
                    DT_SINGLELINE or DT_VCENTER or DT_CENTER);
      end;
    end;
  end;
end;

procedure TLMDCustomGrid.ED_EditorChanged;
begin
  if not (InInternal or (isInplaceEditChanged in FState)) then
  begin
    IncludeState(isInplaceEditChanged);
    InvalidateIndicator;
  end;
end;

function TLMDCustomGrid.ED_IsEditorChanged: Boolean;
begin
  Result := isInplaceEditChanged in FState;
end;

function TLMDCustomGrid.Edit: Boolean;
begin
  Result := ShowInplaceEditor;
end;

function TLMDCustomGrid.ED_DoMouseWheelDown(Shift: TShiftState): Boolean;
begin
  Result := DoMouseWheelDown(Shift, Point(-1, -1));
end;

function TLMDCustomGrid.ED_DoMouseWheelUp(Shift: TShiftState): Boolean;
begin
  Result := DoMouseWheelUp(Shift, Point(-1, -1));
end;

procedure TLMDCustomGrid.ED_KeyDown(var Key: Word; Shift: TShiftState;
  APreprocess: Boolean; Source: TLMDGridKeyProcessSource);
begin
  if APreprocess then
  begin
    case Source of
      psEdit:
      begin
        case Key of
          VK_ESCAPE,
          VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT,
          VK_F4, VK_F2,
          VK_RETURN,
          VK_TAB:
            KeyDownLow(Key, Shift, Source);
        else
          if (Key = VK_BACK) and (ssCtrl in Shift) then
            KeyDownLow(Key, Shift, Source);
        end;
      end;

      psChooser:
      begin
        case Key of
          VK_ESCAPE:
          begin
            EditPanel(Self).HideChooser(False, True);
            Key := 0;
          end;

          VK_RETURN:
          begin
            EditPanel(Self).HideChooser(True, True);
            Key := 0;
          end;
        end;
      end;
    end;
  end
  else
    KeyDownLow(Key, Shift, Source);
end;

procedure TLMDCustomGrid.ED_WMGetDlgCode(const Ed: ILMDGridEmbeddedEdit;
  var Message: TWMGetDlgCode);
begin
  if opTabs in Options then
    Message.Result := Message.Result or DLGC_WANTTAB;
end;

function TLMDCustomGrid.ED_WndProc(const Edit: ILMDGridEmbeddedEdit;
  var Message: TMessage): Boolean;
var
  contr: TWinControl;
begin
  case Message.Msg of
    WM_SETFOCUS:
      begin
        contr := Edit.AsControl;
        Assert(contr <> nil);

        if (GetParentForm(contr) = nil) or
           GetParentForm(contr).SetFocusedControl(Self)
        then
          contr.Dispatch(Message);

        Result := True;
      end;
  else
    Result := False;
  end;
end;

procedure TLMDCustomGrid.EndUpdate;
begin
  EndUpdateLow;
end;

procedure TLMDCustomGrid.EndUpdateLow(ABlockRestoreEditor: Boolean);
var
  doRestore: Boolean;
begin
  Dec(FUpdateCnt);
  if FUpdateCnt < 0 then
    raise ELMDGridError.Create(SLMDGridBedBeginEndUpdate);

  if FUpdateCnt = 0 then
  begin
    if HandleAllocated and (not (isDestroing in FState)) then
    begin
      if isNeedFullRepaint in FState then
        Invalidate;

      doRestore := (not ABlockRestoreEditor) and
                   ((opAlwaysShowEditor in Options) or
                    ((isWasEditorShown in FState) and
                     (isNeedRestoreEditor in FState))) and
                    (not (csDesigning in ComponentState));

      if DataRowCount = 0 then
        HideInplaceEditor(False, True)
      else if doRestore then
      begin
        if IsEditorShown then
          UpdateInplaceEditState
        else
          ShowInplaceEditor;
      end;
    end;

    ExcludeState([isNeedRestoreEditor, isNeedFullRepaint, isWasEditorShown]);

    if HandleAllocated then
      Windows.UpdateWindow(Self.Handle);

    InternalEndUpdateLow;

    if FOldCol  <> Col then
      Include(FChangeFlags, cfCurrent);
    if FOldRow  <> Row then
      Include(FChangeFlags, cfCurrent);

    if FOldTop  <> TopRow then
      Include(FChangeFlags, cfTopLeft);
    if FOldLeft <> LeftCol then
      Include(FChangeFlags, cfTopLeft);

    if (FChangeFlags <> []) and Assigned(FOnChange) then
      FOnChange(Self, FChangeFlags);

    FChangeFlags := [];
  end;
end;

procedure TLMDCustomGrid.ExcludeState(AState: TLMDGridInternalState);
begin
  ExcludeState([AState]);
end;

procedure TLMDCustomGrid.ExcludeState(AState: TLMDGridInternalStates);
begin
  FState := FState - AState;
end;

function TLMDCustomGrid.SetCurrent(ACol, ARow, ALeftCol, ATopRow: Integer;
  WithSelection, AClickEvent: Boolean): Boolean;
var
  curChange: Boolean;
  leftChange: Boolean;
  oldLeft: Integer;
  oldRow, oldCol: Integer;
begin
  oldRow     := Row;
  oldCol     := Col;
  oldLeft    := LeftCol;
  leftChange := LeftDataCol <> ALeftCol;
  InternalRestrictDataPoint(ACol, ARow);
  InternalRestrictDataPoint(ALeftCol, ATopRow);

  curChange := (CurrentColumn <> ACol) or (CurrentRow <> ARow);
  Result := (curChange or (TopDataRow <> ATopRow) or leftChange) and
            HaveVisibleData;

  if (not Result) or (ACol >= Columns.Count) then
    Exit;

  CheckColumnVisible(ACol);

  BeginUpdateLow(False, False);
  BeginInternal;
  try
    if not (isInplaceEditHiding in FState) then
      HideInplaceEditor(True, True);

    if opAlwaysShowEditor in Options then
      IncludeState(isNeedRestoreEditor);

    InvalidateSelRect;

    Include(FState, isNoClick);
    try
      Result := InternalMoveVert(ARow, ATopRow); // No Click inside.

      if oldLeft <> LeftCol then
        IncludeState(isNeedFullRepaint);

      if Result then
      begin
        Col := DataColToGridCol(ACol); // No Click inside.
        if leftChange then
          LeftCol := DataColToGridCol(ALeftCol);

        if not WithSelection or IsNewRecMode or
           not (opRangeSelect in Options) then
          CancelSelection;

        InvalidateSelRect;

        if curChange then
          ScrollToCurrent;
      end;
    finally
      Exclude(FState, isNoClick);
    end;

    if AClickEvent and ((Col <> oldCol) or (Row <> oldRow)) then
      Click; // Only once, as in TCustomGrid.
  finally
    if oldLeft <> LeftCol then
      IncludeState(isNeedFullRepaint);
    EndInternal;
    EndUpdateLow;
  end;
end;

function TLMDCustomGrid.CanFillColumnsFromStore: Boolean;
begin
  Result := False;
end;

procedure TLMDCustomGrid.CancelSelection;
begin
  BeginUpdateLow(False, False);
  try
    if not InInternal then
      InvalidateSelRect;

    CancelSelectionLow;

    if not InInternal then
      InvalidateSelRect;
  finally
    EndUpdateLow;
  end;
end;

procedure TLMDCustomGrid.CancelSelectionLow;
begin
  FSelectionAnchor := Point(CurrentColumn, CurrentRow);
end;

function TLMDCustomGrid.InSelection(ADataCol, ADataRow: Integer): Boolean;
var
  r: TRect;
begin
  r      := GetSelRect;
  Result := (ADataCol >= r.Left) and (ADataCol <= r.Right) and
            (ADataRow >= r.Top) and (ADataRow <= r.Bottom);
end;

function TLMDCustomGrid.GetSelRect: TRect;
var
  x0, x1, y0, y1: Integer;
begin
  x0 := Min(FSelectionAnchor.X, CurrentColumn);
  x1 := Max(FSelectionAnchor.X, CurrentColumn);

  y0 := Min(FSelectionAnchor.Y, CurrentRow);
  y1 := Max(FSelectionAnchor.Y, CurrentRow);

  Result := Rect(x0, y0, x1, y1);
  if opRowSelect in Options then
  begin
    Result.Left := 0;
    Result.Right := Columns.Count - 1;
  end;
end;

procedure TLMDCustomGrid.InvalidateGridRect(ARect: TRect);
var
  x, y: Integer;
begin
  for x := ARect.Left to ARect.Right do
    for y := ARect.Top to ARect.Bottom do
      InvalidateCell(x, y);
end;

procedure TLMDCustomGrid.InvalidateSelRect;
begin
  if IsSelectionValid then
    InvalidateGridRect(DataRectToGridRect(GetSelRect));
end;

procedure TLMDCustomGrid.ExitFromSizingMoving(ACancelMoveSize: Boolean;
  X, Y: Integer);
var
  block:  Boolean;
  st:     TLMDGridInternalStates;
  dropTo: Integer;
begin
  block := isBlockPressedMouseAct in FState;

  FMoveSizeTimer.Enabled := False;
  dropTo := FMoveDropIdx;
  FMoveDropIdx := -1;
  if (not NoMovingSizingState) and (not block) then
    InvalidateMovingPt(FMouseMovePt.X, FMouseMovePt.Y, X, Y);

  st := FState * [isColSizing, isRowSizing, isColMoving, isRowMoving,
                  isSelExtending];
  ExcludeState([isColSizing, isRowSizing,    isColMoving,
                isRowMoving, isSelExtending, isBlockPressedMouseAct]);

  FMouseMovePt := Point(-1, -1);
  MouseCapture := False;

  if not ACancelMoveSize then
  begin
    if isColSizing in st then
      Columns[GridColToDataCol(FSizeMoveIdx)].Width := FSizingNewSize
    else if isRowSizing in st then
      RowHeights[FSizeMoveIdx] := FSizingNewSize
    else if isColMoving in st then
      EndColumnDrag(FSizeMoveIdx, dropTo, FMouseMovePt)
    else if isRowMoving in st then
      EndRowDrag(FSizeMoveIdx, dropTo, FMouseMovePt);

    if st <> [] then
      UpdateDesigner;
  end;
end;

procedure TLMDCustomGrid.ExitNewRecMode(ACommit: Boolean);
var
  dummy: Boolean;
begin
  ExitNewRecMode(ACommit, dummy);
end;

function TLMDCustomGrid.FindNearVisibleCol(ADataCol: Integer;
  ABack: Boolean): Integer;
begin
  while (ADataCol >= 0) and (ADataCol < Columns.Count) and
        (not Columns[ADataCol].Visible) do
  begin
    if ABack then
      Dec(ADataCol)
    else
      Inc(ADataCol);
  end;

  Result := ADataCol;
end;

procedure TLMDCustomGrid.ExitNewRecMode(ACommit: Boolean;
  out Cancelled: Boolean);
var
  curidx: Integer;
begin
  if not IsNewRecMode then
    Exit;

  BeginUpdateLow(False, True);
  try
    Cancelled := not (ACommit and (isInplaceEditChanged in FState));
    HideInplaceEditor(not Cancelled, True);

    ExcludeState([isNewRecord, isInplaceEditChanged]);

    curidx := CurrentRow;
    if Cancelled then
    begin
      InternalExitNewRecMode(False, curidx);
      SyncGridStore;
    end
    else
    begin
      InternalExitNewRecMode(True, curidx);

      if curidx <> CurrentRow then
        CurrentRow := curidx;
    end;
  finally
    EndUpdateLow;
  end;
end;

function TLMDCustomGrid.GetDataCell(ACol, ARow: Integer): Variant;
var
  k, v: Variant;
begin
  GetDataCellLow(ACol, ARow, k, v);
  Result := v;
end;

function TLMDCustomGrid.GetDataCellColor(AColumn: TLMDGridColumn;
  ACellState: TLMDGridCellStates; ADataRow: Integer): TColor;
var
  rst: TLMDGridRowState;
  v:   Variant;
begin
  if UseAlternate and ((ADataRow mod 2) <> 0) then
    Result := AColumn.FAltrernateColor
  else
    Result := AColumn.FColor;

  if Assigned(FOnGetCellColor) then
  begin
    rst := GetCellRowState(DataColToGridCol(AColumn.Position),
                           DataRowToGridRow(ADataRow));
    v   := GetDataCell(AColumn.Position, ADataRow);

    FOnGetCellColor(Self, ACellState, rst, v, AColumn,
                    ADataRow, Result);
  end;

  Result := GetStyledColor(Result); // After custom event.
end;

procedure TLMDCustomGrid.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  i: Integer;
begin
  for i := 0 to FColumns.Count - 1 do
    if FColumns[i].Owner = Root then
      Proc(FColumns[i] as TComponent);
end;

function TLMDCustomGrid.GetColumnField(AColumn: TLMDGridColumn): TField;
begin
  Result := nil;
end;

function TLMDCustomGrid.GetColumnFieldKey(AColumn: TLMDGridColumn): TField;
begin
  Result := nil;
end;

function TLMDCustomGrid.GetCurrentColumn: Integer;
begin
  if Columns.Count > 0 then
    Result := GridColToDataCol(Col)
  else
    Result := -1;
end;

function TLMDCustomGrid.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_GRID;
end;

procedure TLMDCustomGrid.InsertColumn(AColumn: TLMDGridColumn);
begin
  ColumnAdding(AColumn);

  FColumns.AddColLow(AColumn);
  AColumn.FreeNotification(Self);

  BeginInternal;
  try
    if Columns.Count > 1 then
      ColCount := ColCount + 1;

    SyncGridStore;
    ColWidths[ColCount - 1] := AColumn.Width;

    RebuildColsSaved;

    ColumnAdded(AColumn);
    CancelSelectionLow;
  finally
    EndInternal;
  end;
end;

procedure TLMDCustomGrid.InternalDataLayoutChange;
begin
  // Do nothing.
end;

function TLMDCustomGrid.InternalDataSourceCanSort: Boolean;
begin
  if FCustomSource <> nil then
    Result := spCanSort in FCustomSource.GetProps
  else
    Result := True;
end;

procedure TLMDCustomGrid.InternalDataSourceSort(AColumn: TLMDGridColumn;
  Value: TLMDGridSortKind; var ACorrectIdx: Integer);
begin
  if FCustomSource <> nil then
    FCustomSource.Sort(AColumn, Value, ACorrectIdx)
  else
    Store(Self).Sort(AColumn.Position, Value, ACorrectIdx);
end;

procedure TLMDCustomGrid.InternalEndUpdateLow;
begin
  // Do nothing.
end;

procedure TLMDCustomGrid.InternalEnterNewRecMode(ADestIndex: Integer);
begin
  if FCustomSource <> nil then
    FCustomSource.InsertRow(ADestIndex)
  else
    Store(Self).InsertRow(ADestIndex);

  SyncGridStore;  
  CurrentRow := ADestIndex;
end;

procedure TLMDCustomGrid.InternalExitNewRecMode(ACommit: Boolean;
  out ACurrentIndex: Integer);
begin
  if ACommit then
  begin
    ACurrentIndex := CurrentRow;
    if FCustomSource <> nil then
      FCustomSource.UpdateSort(ACurrentIndex)
    else
      Store(Self).Sort(ACurrentIndex);
  end
  else if FCustomSource <> nil then
    FCustomSource.DeleteRow(CurrentRow, ACurrentIndex)
  else
    Store(Self).DeleteRow(CurrentRow, ACurrentIndex);
end;

function TLMDCustomGrid.InternalIsColumnDataBound(ACol: Integer): Boolean;
begin
  Result := True;
end;

procedure TLMDCustomGrid.InternalSetColumnFieldName(AColumn: TLMDGridColumn;
  const Value: string; ABefore: Boolean);
begin
  // Do nothing.
end;

procedure TLMDCustomGrid.InternalSetColumnGrid(AColumn: TLMDGridColumn);
begin
  // Do nothing.
end;

procedure TLMDCustomGrid.InternalSetDataCell(ACol, ARow: Integer;
  Key, Value: PVariant; ABlockSort: Boolean; out NewRow: Integer);
begin
  CheckCellIdx(ACol, ARow);

  if FCustomSource <> nil then
    FCustomSource.SetDataCell(ACol, ARow, Value^, ABlockSort, NewRow)
  else
    (FStore as TInternalStore).SetDataCell(ACol, ARow, Value, ABlockSort, NewRow);
end;

procedure TLMDCustomGrid.InternalSetDefaultColPos(AColumn: TLMDGridColumn);
begin
  // Do nothing.
end;

procedure TLMDCustomGrid.InternalSetDefaultColWidth(AColumn: TLMDGridColumn);
begin
  // Do nothing.
end;

procedure TLMDCustomGrid.InternalSetupScrollBarsStyle;
begin
  inherited ScrollBars := FScrollBarsStyle;
end;

procedure TLMDCustomGrid.InternalUpdateStore;
begin
  // Do nothing.
end;

procedure TLMDCustomGrid.InternalAfterSyncGridStore;
begin
  // Do nothing.
end;

procedure TLMDCustomGrid.InternalColumnDataTypeChanged(ACol: TLMDGridColumn);
begin
  Store(Self).ClearColumn(ACol.Position);
end;

procedure TLMDCustomGrid.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (AComponent is TLMDGridColumn) then
    RemoveColumn(AComponent as TLMDGridColumn);
end;

procedure TLMDCustomGrid.RemoveColumn(AColumn: TLMDGridColumn);
var
  i:                   Integer;
  curCol, colI:        Integer;
  noDestr, vis, destr: Boolean;
begin
  if FColumns.HaveCol(AColumn) then
  begin
    destr := isDestroing in FState;
    vis := (not destr) and AColumn.Visible;

    BeginUpdateLow(True, vis);
    try
      colI := -1;
      curCol := -1;
      if vis then
      begin
        curCol := Col;

        noDestr := not (isDestroing in FState);
        HideInplaceEditor(noDestr, noDestr);
        AColumn.DetachEmbeddedEditor;

        i := AColumn.Position;
        colI := DataColToGridCol(i);
      end;

      ColumnDeleting(AColumn);

      EditPanel(Self).SetColumn(nil);
      AColumn.RemoveFreeNotification(Self);
      FColumns.RemoveColLow(AColumn);

      if vis then
      begin
        BeginInternal;
        try
          for i := colI to ColCount - 2 do
            ColWidths[i] := ColWidths[i + 1];

          ColCount := ColCount - 1;

          SyncGridStore;

          if colI = curCol then
          begin
            if colI < ColCount then
              Col := colI
            else
              Col := ColCount - 1;
          end
          else if curCol > colI then
            Col := curCol - 1;

          CancelSelectionLow;          
        finally
          EndInternal;
        end;
      end;

      if not destr  then
        RebuildColsSaved;
    finally
      EndUpdateLow;
    end;
  end;
end;

procedure TLMDCustomGrid.RowHeightsChanged;
begin
  UpdateInplaceEditState;
  PageSizeChanged;
end;

procedure TLMDCustomGrid.RowMoved(FromIndex, ToIndex: Integer);
begin
  if not InInternal then
  begin
    FromIndex := GridRowToDataRow(FromIndex);
    ToIndex := GridRowToDataRow(ToIndex);
    MoveDataRow(FromIndex, ToIndex);
  end;
end;

procedure TLMDCustomGrid.WMChar(var Msg: TWMChar);
begin
  if csDestroying in ComponentState then
    Exit;
  DoKeyPressW(Msg);
end;

procedure TLMDCustomGrid.WMEraseBkgnd(var Msg: TMessage);
begin
  Msg.Result := 1;
end;

procedure TLMDCustomGrid.WMThemeChanged(var Msg : TMessage);
begin
  DoThemeChanged;
  Msg.Result := 0;
end;

procedure TLMDCustomGrid.WMSetCursor(var Msg: TWMSetCursor);
var
  dummy: Integer;
  state: TLMDGridInternalStates;
  cur: HCURSOR;
  win: TPoint;
begin
  if isDestroing in FState then
    Exit;

  cur := Screen.Cursors[crDefault];

  if (Msg.HitTest = HTCLIENT) and (Msg.CursorWnd = Handle) and NoMovingSizingState then
  begin
    Windows.GetCursorPos(win);
    win := ScreenToClient(win);

    state := GetMouseSizingState(win.X, win.Y, dummy);

    if isRowSizing in state then
      cur := Screen.Cursors[crVSplit]
    else if isColSizing in state then
      cur := Screen.Cursors[crHSplit];
  end;

  if GetCursor <> cur then
    SetCursor(cur);
end;

procedure TLMDCustomGrid.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  ReFocusInplaceEditor(Msg.FocusedWnd);
end;

procedure TLMDCustomGrid.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style or WS_CLIPCHILDREN;
end;

procedure TLMDCustomGrid.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  cell:           TGridCoord;
  xg, xl, yg, yl: Boolean;
  r:              TRect;
  cr:             TRect;
begin
  BeginUpdateLow(False, False);
  try
    cell := MouseCoord(X, Y);
    cr   := CellRect(cell.X, cell.Y);

    if ((Abs(X - FMouseDownPt.X) > MOUSE_MOVE_DIFF) or
        (Abs(Y - FMouseDownPt.Y) > MOUSE_MOVE_DIFF)) and
       (ssLeft in Shift) and NoMovingSizingState and
       not (isBlockPressedMouseAct in FState) then
    begin
      FMouseMovePt := Point(-1, -1);
      FMoveDropIdx := -1;

      if IsHeaderRow(cell.Y) then
      begin
        if CanMoveCol and BeginColumnDrag(cell.X, cell.X, Point(X, Y)) then
        begin
          FSizeMoveIdx := cell.X;
          FMoveOffset  := Point(X - cr.Left, Y - cr.Top);
          IncludeState(isColMoving);
        end;
      end
      else if IsIndicatorCol(cell.X) and (not IsHeaderRow(cell.Y)) and
              HaveVisibleData then
      begin
        if CanMoveRow and BeginRowDrag(cell.Y, cell.Y, Point(X, Y)) then
        begin
          FSizeMoveIdx := cell.Y;
          FMoveOffset  := Point(X - cr.Left, Y - cr.Top);
          IncludeState(isRowMoving);
        end;
      end
      else if IsDataCell(cell.X, cell.Y) and not (opAlwaysShowEditor in Options) and
              (not IsEditorShown) then
        IncludeState(isSelExtending);

      if not NoMovingSizingState then
        MouseCapture := True
      else
        IncludeState(isBlockPressedMouseAct);
    end;

    if NoMovingSizingState then
    begin
      if (cell.X <> FHoverCell.X) or (cell.Y <> FHoverCell.Y) then
      begin
        if FHoverCell.X <> -1 then
        begin
          Assert(FHoverCell.Y <> -1);
          InvalidateCell(FHoverCell.X, FHoverCell.Y);
        end;

        InvalidateCell(cell.X, cell.Y);
        FHoverCell := cell;
      end;
    end
    else
    begin
      r.Left := Left;
      r.Top := Top;

      if isSelExtending in FState then
      begin
        if opShowIndicator in Options then
          r.Left := CellRect(0, 0).Right;

        if opShowHeader in Options then
          r.Top := CellRect(0, 0).Bottom;
      end;

      r.Right := Left + ClientWidth;
      r.Bottom := Top + ClientHeight;

      xl := X < r.Left;
      xg := X > r.Right;
      yl := Y < r.Top;
      yg := Y > r.Bottom;

      if xg then
      begin
        if yg then
          FMoveSizeTimerDir := sdDownRight
        else if yl then
          FMoveSizeTimerDir := sdUpRight
        else
          FMoveSizeTimerDir := sdRight;
      end
      else if xl then
      begin
        if yg then
          FMoveSizeTimerDir := sdDownLeft
        else if yl then
          FMoveSizeTimerDir := sdUpLeft
        else
          FMoveSizeTimerDir := sdLeft;
      end
      else
      begin
        if yg then
          FMoveSizeTimerDir := sdDown
        else if yl then
          FMoveSizeTimerDir := sdUp
        else
          FMoveSizeTimerDir := sdNone;
      end;

      if isColMoving in FState then
      begin
        if FMoveSizeTimerDir in [sdLeft, sdUpLeft, sdDownLeft] then
          FMoveSizeTimerDir := sdLeft
        else if FMoveSizeTimerDir in [sdRight, sdUpRight, sdDownRight] then
          FMoveSizeTimerDir := sdRight
        else
          FMoveSizeTimerDir := sdNone;
      end
      else if isRowMoving in FState then
      begin
        if FMoveSizeTimerDir in [sdUp, sdUpLeft, sdUpRight] then
          FMoveSizeTimerDir := sdUp
        else if FMoveSizeTimerDir in [sdDown, sdDownLeft, sdDownRight] then
          FMoveSizeTimerDir := sdDown
        else
          FMoveSizeTimerDir := sdNone;
      end
      else if ([isColSizing, isRowSizing] * FState) <> [] then
        FMoveSizeTimerDir := sdNone;

      FMoveSizeTimer.Enabled := FMoveSizeTimerDir <> sdNone;

      InvalidateMovingPt(FMouseMovePt.X, FMouseMovePt.Y, X, Y);

      FMouseMovePt := Point(X, Y);
    end;
  finally
    EndUpdateLow(True);
  end;

  inherited;
end;

procedure TLMDCustomGrid.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  cell:              TGridCoord;
  state:             TLMDGridInternalStates;
  cancel, BlockMove: Boolean;
  oldRow:            Integer;
  colObj:            TLMDGridColumn;
  p:                 TPoint;
  inpt:              TLMDGridFirstInput;
begin
  FMouseDownPt := Point(X, Y);

  BeginUpdateLow(False, False);
  try
    cell := MouseCoord(X, Y);

    if not (csDesigning in ComponentState) and
      (CanFocus or (GetParentForm(Self) = nil)) then
    begin
      Windows.SetFocus(Self.Handle);
      if not IsActiveControl then
        MouseCapture := False;
    end;

    if Button = mbLeft then
    begin
      FSizeMoveIdx := -1;
      state := GetMouseSizingState(X, Y, FSizeMoveIdx);

      if isColSizing in state then
      begin
        IncludeState(isColSizing);
        MouseCapture := True;
        FSizingNewSize := ColWidths[FSizeMoveIdx];
      end
      else if isRowSizing in state then
      begin
        IncludeState(isRowSizing);
        MouseCapture := True;
        FSizingNewSize := RowHeights[FSizeMoveIdx];
      end;

      if (state = []) and IsDataCell(cell.X, cell.Y) then
      begin
        if not (csDesigning in ComponentState) then
        begin
          oldRow := Row;
          cancel := False;

          if IsNewRecMode and (cell.Y <> Row) then
          begin
            ExitNewRecMode(True, cancel);
            if cancel or (cell.Y > oldRow) then
              Dec(cell.Y);
          end
          else if IsRowEditMode and (cell.Y <> Row) then
            ExitRowEditMode(True)
          else
            HideInplaceEditor(True, True);

          BlockMove := (not cancel) and (Row <> oldRow);

          if ((cell.X = Col) and (cell.Y = Row) and (not cancel)) or (ssDouble in Shift) then
          begin
            CancelSelection;

            inpt.Kind      := fikMouseDown;
            inpt.Shift     := Shift;
            inpt.Button    := Button;
            inpt.CursorPos := ClientToScreen(Point(X, Y));
            ShowInplaceEditor(inpt);
          end
          else if cell.X <> -1 then
          begin
            if BlockMove then
            begin
              cell.Y := Row;
              cell.X := Col;
            end;

            InvalidateCell(Col, Row);
            InvalidateCell(cell.X, cell.Y);

            cell.X := GridColToDataCol(cell.X);
            cell.Y := GridRowToDataRow(cell.Y);

            SetCurrent(cell.X, cell.Y, ssShift in Shift, False);

            if opAlwaysShowEditor in Options then
            begin
              inpt.Kind      := fikMouseDown;
              inpt.Shift     := Shift;
              inpt.Button    := Button;
              inpt.CursorPos := ClientToScreen(Point(X, Y));
              ShowInplaceEditor(inpt);
            end;
          end;
        end;
      end
      else if IsHeaderRow(cell.Y) then
      begin
        InvalidateCell(cell.X, cell.Y);

        if (csDesigning in ComponentState) and
           Assigned(LMDDesignerSelectComponentProc) and
           IsDataCol(cell.X)
        then
        begin
          if NoMovingSizingState then
            colObj := Columns[ GridColToDataCol(cell.X) ]
          else
            colObj := Columns[ FSizeMoveIdx - 1];

          if GetAutoColumnsMode then
            SelectAutoColumn(colObj, ssShift in Shift)
          else
            LMDDesignerSelectComponentProc(Self, colObj, ssShift in Shift);
        end
        else if GetCellKind(cell.X, cell.Y) = ckDummyHeader then
        begin
          p := ClientToScreen(Point(X, Y));
          FillColumnsChooseMenu(LMDGridImagesForm.SelectColumnsMenu);
          LMDGridImagesForm.SelectColumnsMenu.Popup(p.X, p.Y);
        end;
      end;
    end;
  finally
    EndUpdateLow;
  end;

  inherited;
end;

procedure TLMDCustomGrid.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  cell:   TGridCoord;
  colObj: TLMDGridColumn;
begin
  try
    if IsInteractiveState and NoMovingSizingState then
    begin
      cell := MouseCoord(X, Y);
      InvalidateCell(cell.X, cell.Y);

      if IsDataCol(cell.X) and IsHeaderRow(cell.Y) and
         (not (isBlockPressedMouseAct in FState))
      then
      begin
        colObj := Columns[ GridColToDataCol(cell.X) ];

        if IsSortingAllowed(colObj) then
        begin
          case colObj.SortKind of
            skNone: colObj.SortKind := skAsc;
            skAsc:  colObj.SortKind := skDesc;
            skDesc: colObj.SortKind := skAsc;
          else
            Assert(False);
          end;
        end
        else
          Beep;
      end;
    end;
  finally
    ExitFromSizingMoving(False, X, Y);
  end;

  inherited;
end;

procedure TLMDCustomGrid.CMDesignHitTest(var Msg: TCMDesignHitTest);
var
  x, y:     Integer;
  cell:     TGridCoord;
  isHeader: Boolean;
begin
  if NoMovingSizingState then
  begin
    x := Msg.XPos;
    y := Msg.YPos;

    cell     := MouseCoord(x, y);
    isHeader := IsDataCol(cell.x) and IsHeaderRow(cell.y);

    if (Msg.Keys and MK_LBUTTON) <> 0 then
    begin
      if isHeader then
        Msg.Result := 1
      else
      begin
        if HaveSelectedAutoColumns then
          SelectAutoColumn(nil, False);

        Msg.Result := 0;
      end;
    end
    else if Msg.Keys <> 0 then
      Msg.Result := 0
    else if isHeader then
      Msg.Result := 1
    else
      Msg.Result := 0;
  end
  else
    Msg.Result := 1;
end;

procedure TLMDCustomGrid.WMCancelMode(var Msg: TWMCancelMode);
begin
  inherited;
  ExitFromSizingMoving(True, -1, -1);
end;

procedure TLMDCustomGrid.CMCancelMode(var Msg: TCMCancelMode);
begin
  inherited;
  InplaceEditDoCancelMode(Msg.Sender);
  ExitFromSizingMoving(True, -1, -1);
end;

procedure TLMDCustomGrid.CMMouseLeave(var Message: TMessage);
var
  cell: TGridCoord;
begin
  if FHoverCell.X <> -1 then
  begin
    cell := FHoverCell;
    ResetHoverCell;
    InvalidateCell(cell.X, cell.Y);
  end;

  inherited;
end;

procedure TLMDCustomGrid.CMShowingChanged(var Message: TMessage);
begin
  inherited;

  if Showing then
    PageSizeChanged;
end;

function TLMDCustomGrid.GetCurrentRow: Integer;
begin
  if DataRowCount <> 0 then
    Result := GridRowToDataRow(Row)
  else
    Result := 0;
end;

function TLMDCustomGrid.GetShiftState: TShiftState;
begin
  Result := [];

  if (GetKeyState(VK_CONTROL) and $80) <> 0 then
    Include(Result, ssCtrl);

  if (GetKeyState(VK_SHIFT) and $80) <> 0 then
    Include(Result, ssShift);

  if (GetKeyState(VK_MENU) and $80) <> 0 then
    Include(Result, ssAlt);

  if (GetKeyState(VK_MBUTTON) and $80) <> 0 then
    Include(Result, ssMiddle);

  if (GetKeyState(VK_LBUTTON) and $80) <> 0 then
    Include(Result, ssLeft);

  if (GetKeyState(VK_RBUTTON) and $80) <> 0 then
    Include(Result, ssRight);
end;

function TLMDCustomGrid.GetStyle: TLMDGridStyle;
begin
  Result := FStyle;
end;

function TLMDCustomGrid.GetStyledColor(C: TColor): TColor;
var
  useTheme: TLMDThemeMode;
begin
  useTheme := UseThemeMode;
  if (C < 0) and (useTheme <> ttmNone) then
    Result := LMDThemeServices.GetThemeSysColor(useTheme, teEdit,
                                                C and $000000FF)
  else
    Result := C;
end;

procedure TLMDCustomGrid.OnFontChange(ASender: TObject);
var
  i: Integer;
begin
  BeginUpdateLow(True, True);
  try
    for i := 0 to Columns.Count - 1 do
      Columns[i].RefreshDefaultFont;
  finally
    EndUpdateLow;
  end;
end;

function TLMDCustomGrid.GetCellState(ACol, ARow: Integer): TLMDGridCellStates;
var
  shift:   TShiftState;
  dataCol: Integer;
  colObj:  TLMDGridColumn;
begin
  Result := [];
  shift  := GetShiftState;

  if IsHeaderRow(ARow) and (isColMoving in FState) and (FSizeMoveIdx = ACol) then
    Include(Result, csMovingCol)
  else if IsIndicatorCol(ACol) and (isRowMoving in FState) and (FSizeMoveIdx = ARow) then
    Include(Result, csMovingRow)
  else if IsHeaderRow(ARow) and (isColSizing in FState) and (FSizeMoveIdx = ACol) then
    Include(Result, csSizingCol)
  else if IsIndicatorCol(ACol) and (isRowSizing in FState) and (FSizeMoveIdx = ARow) then
    Include(Result, csSizingRow)
  else if (FHoverCell.X = ACol) and (FHoverCell.Y = ARow) and NoMovingSizingState and
          (not (isBlockPressedMouseAct in FState)) and
          (not (csDesigning in ComponentState)) then
    Include(Result, csHover);

  if IsDataCol(ACol) then
  begin
    dataCol := GridColToDataCol(ACol);
    if not InternalIsColumnDataBound(dataCol) then
      Include(Result, csColumnUnbound);

    if (csDesigning in ComponentState) and
       ((Result * [csSizingCol, csSizingRow, csMovingCol, csMovingRow]) = []) and
       IsHeaderRow(ARow) then
    begin
      colObj := Columns[dataCol];

      if (Assigned(LMDDesignerIsComponentSelected) and
          LMDDesignerIsComponentSelected(Self, colObj)) or
         colObj.GetAutoColumnDesignerSelected then
      begin
        Include(Result, csDesignerSelected);
        Exclude(Result, csHover);
      end;
    end;
  end;
end;

procedure TLMDCustomGrid.GetDataCellLow(ACol, ARow: Integer;
  var Key, Value: Variant);
begin
  InternalGetDataCell(ACol, ARow, @Key, @Value);
end;

procedure TLMDCustomGrid.OnDesignSelectonChanged(ASender: TObject);
begin
  Invalidate;
end;

function TLMDCustomGrid.GetDataRowCount: Integer;
begin
  if FCustomSource <> nil then
    Result := FCustomSource.RowCount
  else
    Result := (FStore as TInternalStore).RowCount;
end;

procedure TLMDCustomGrid.SetDataRowCount(const Value: Integer);
var
  curRow: Integer;
begin
  CheckIntValue('DataRowCount', Value, 0);

  if Columns.Count = 0 then
    raise ELMDGridError.Create(SLMDGridRequireHaveCols);

  if Value <> DataRowCount then
  begin
    BeginUpdateLow(True, True);
    try
      if CurrentRow >= Value then
        HideInplaceEditor(True, True);

      curRow := CurrentRow;
      if FCustomSource <> nil then
        FCustomSource.SetRowCount(Value, curRow)
      else
        (FStore as TInternalStore).SetRowCount(Value, curRow);

      SyncGridStore;

      if DataRowCount > 0 then
        CurrentRow := curRow;

      CancelSelection;
    finally
      EndUpdateLow;
    end;
  end;
end;

procedure TLMDCustomGrid.SyncGridStore;
begin
  BeginInternal;
  try
    if VisibleColumnsCount = 0 then
    begin
      FixedRows := 0;
      FixedCols := 0;
      RowCount := 0;
      ColCount := 0;

      FState := FState - [isHaveVisibleCols, isHaveVisibleRows];
      CancelSelectionLow;
    end
    else if DataRowCount = 0 then
    begin
      RowCount := 2;
      FixedRows := 1;

      FState := FState - [isHaveVisibleRows] + [isHaveVisibleCols];
      CancelSelectionLow;
    end
    else
      FState := FState + [isHaveVisibleRows, isHaveVisibleCols];

    if HaveVisibleCols then
    begin
      if opShowIndicator in Options then
      begin
        ColCount := VisibleColumnsCount + 1;
        FixedCols := 1;
        ColWidths[0] := Style.IndicatorColWidth;
      end
      else
      begin
        FixedCols := 0;
        ColCount := VisibleColumnsCount;
      end;
    end;

    if HaveRows then
    begin
      if opShowHeader in Options then
      begin
        RowCount := DataRowCount + 1;
        FixedRows := 1;
        RowHeights[0] := Style.HeaderRowHeight;
      end
      else
      begin
        FixedRows := 0;
        RowCount := DataRowCount;
      end;
    end;

    InternalAfterSyncGridStore;
  finally
    EndInternal;
  end;
end;

function TLMDCustomGrid.DataColToGridCol(ACol: Integer): Integer;
var
  i: Integer;
begin
  Assert(IsColVisible(ACol));

  Result := 0;
  for i := 0 to ACol - 1 do
    if Columns[i].Visible then
      Inc(Result);

  if opShowIndicator in Options then
    Result := Result + 1
  else
    Result := Result;
end;

function TLMDCustomGrid.DataRowToGridRow(ARow: Integer): Integer;
begin
  if opShowHeader in Options then
    Result := ARow + 1
  else
    Result := ARow;
end;

function TLMDCustomGrid.DataRectToGridRect(ARect: TRect): TRect;
var
  l, r: Integer;
begin
  Assert(HaveVisibleCols);

  l := FindNearVisibleCol(ARect.Left, True);
  if l = -1 then
    l := FindNearVisibleCol(ARect.Left, False);

  r := FindNearVisibleCol(ARect.Right, False);
  if r = Columns.Count then
    r := FindNearVisibleCol(ARect.Right, True);

  Result.Left := DataColToGridCol(l);
  Result.Right := DataColToGridCol(r);
  Result.Top := DataRowToGridRow(ARect.Top);
  Result.Bottom := DataRowToGridRow(ARect.Bottom);
end;

function TLMDCustomGrid.IsHeaderRow(ARow: Integer): Boolean;
begin
  Result := (ARow >= 0) and (GridRowToDataRow(ARow) < 0);
end;

function TLMDCustomGrid.IsActiveControl: Boolean;
var
  h:    HWND;
  form: TCustomForm;
begin
  Result := False;
  form   := GetParentForm(Self);

  if Assigned(form) then
  begin
    if (form.ActiveControl = Self) and (form = Screen.ActiveForm) then
      Result := True;
  end
  else
  begin
    h := GetFocus;

    while IsWindow(h) and (Result = False) do
    begin
      if h = WindowHandle then
        Result := True
      else
        h := GetParent(h);
    end;
  end;
end;

function TLMDCustomGrid.IsColVisible(ADataCol: Integer): Boolean;
begin
  Result := Columns[ADataCol].Visible;
end;

function TLMDCustomGrid.IsDataCol(ACol: Integer): Boolean;
begin
  Result := GridColToDataCol(ACol) >= 0;
end;

function TLMDCustomGrid.IsDataRow(ARow: Integer): Boolean;
begin
  Result := GridRowToDataRow(ARow) >= 0;
end;

function TLMDCustomGrid.IsDataCell(ACol, ARow: Integer): Boolean;
begin
  Result := IsDataCol(ACol) and (not IsHeaderRow(ARow));
end;

function TLMDCustomGrid.IsIndicatorCol(ACol: Integer): Boolean;
begin
  Result := (opShowIndicator in Options) and (ACol = 0);
end;

function TLMDCustomGrid.IsSortingAllowed(ACol: TLMDGridColumn): Boolean;
var
  f: TField;
begin
  Assert(ACol <> nil);

  f      := GetColumnField(ACol);
  Result := ACol.FSortingAllowed and InternalDataSourceCanSort and
            InternalIsColumnDataBound(ACol.Position) and
            ((f = nil) or (f.FieldKind in [fkData, fkInternalCalc])) and
            ACol.IsSortingAllowed;
end;

procedure TLMDCustomGrid.KeyDown(var Key: Word; Shift: TShiftState);
begin
  KeyDownLow(Key, Shift, psGrid);
end;

procedure TLMDCustomGrid.KeyDownLow(var Key: Word; Shift: TShiftState;
  Source: TLMDGridKeyProcessSource);
var
  NewTopLeft:      TPoint;
  NewCurrent:      TPoint;
  ChangePosKey:    Boolean;
  NewRecDown:      Boolean;
  Ok, Cancel:      Boolean;
  DoBeep, WithSel: Boolean;
  inpt:            TLMDGridFirstInput;

  procedure DoChangePosKey(ACancel: Boolean);
  begin
    if ssCtrl in Shift then
      case Key of
        VK_UP:    Dec(NewTopLeft.Y);

        VK_DOWN:  Inc(NewTopLeft.Y);

        VK_LEFT:  Dec(NewTopLeft.X);

        VK_RIGHT: Inc(NewTopLeft.X);

        VK_PRIOR: NewCurrent.Y := TopRow;

        VK_NEXT:  NewCurrent.Y := TopRow + PageHeight - 1;

        VK_HOME:  NewCurrent.Y := - MaxInt div 2;

        VK_END:   NewCurrent.Y := MaxInt div 2;
      end
    else
      case Key of
        VK_UP:
          if not ACancel then
            Dec(NewCurrent.Y);

        VK_DOWN:
          if not ACancel then
            Inc(NewCurrent.Y);

        VK_LEFT:  Dec(NewCurrent.X);

        VK_RIGHT: Inc(NewCurrent.X);

        VK_NEXT:
        if not ACancel then
        begin
          Inc(NewCurrent.Y, PageHeight);
          Inc(NewTopLeft.Y, PageHeight);
        end;

        VK_PRIOR:
        if not ACancel then
        begin
          Dec(NewCurrent.Y, PageHeight);
          Dec(NewTopLeft.Y, PageHeight);
        end;

        VK_HOME:  NewCurrent.X := FixedCols;

        VK_END:   NewCurrent.X := ColCount - 1;

        VK_TAB:
          if not (ssAlt in Shift) then
          repeat
            if ssShift in Shift then
            begin
              Dec(NewCurrent.X);
              if NewCurrent.X < FixedCols then
              begin
                NewCurrent.X := ColCount - 1;
                Dec(NewCurrent.Y);
                if NewCurrent.Y < FixedRows then
                  NewCurrent.Y := RowCount - 1;
              end;
              Shift := [];
            end
            else
            begin
              Inc(NewCurrent.X);
              if NewCurrent.X >= ColCount then
              begin
                NewCurrent.X := FixedCols;
                if IsEOF then
                  NewCurrent.Y := -(MAXINT div 2)
                else
                  Inc(NewCurrent.Y);
              end;
            end;
          until TabStops[NewCurrent.X] or (NewCurrent.X = Col);
      end;
  end;

  procedure DoMove;
  begin
    WithSel := ssShift in Shift;

    if NewCurrent.X < 0 then
      NewCurrent.X := 0
    else if NewCurrent.X >= ColCount then
      NewCurrent.X := ColCount - 1;

    if NewTopLeft.X < 0 then
      NewTopLeft.X := 0
    else if NewTopLeft.X >= ColCount then
      NewTopLeft.X := ColCount - 1;

    NewCurrent.X := GridColToDataCol(NewCurrent.X);
    NewCurrent.Y := GridRowToDataRow(NewCurrent.Y);
    NewTopLeft.X := GridColToDataCol(NewTopLeft.X);
    NewTopLeft.Y := GridRowToDataRow(NewTopLeft.Y);

    NewRecDown := IsEOF and (Key = VK_DOWN) and CanInsert;
    Ok := (not NewRecDown) and
          SetCurrent(NewCurrent.X, NewCurrent.Y,
                     NewTopLeft.X, NewTopLeft.Y, WithSel);
  end;

begin
  if Assigned(OnKeyDown) then
    OnKeyDown(Self, Key, Shift);

  if not CanGridAcceptKey(Key, Shift) then
    Key := 0;

  ChangePosKey := Key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT,
                          VK_PRIOR, VK_NEXT, VK_HOME, VK_END, VK_TAB];

  BeginUpdateLow(False, False);
  try
    if ChangePosKey then
    begin
//      DoSuppress := True;

      NewCurrent := Point(Col, Row);
      NewTopLeft := Point(LeftCol, TopRow);

      Cancel := False;
      DoChangePosKey(Cancel);

      if (not (IsEof and (Key = VK_DOWN))) and
         (NewCurrent.Y <> Row) then
      begin
        if IsNewRecMode then
          ExitNewRecMode(True, Cancel)
        else if IsEditorShown then
          HideInplaceEditor(True, True)
        else if IsRowEditMode then
          ExitRowEditMode(True);
      end;

      NewCurrent := Point(Col, Row);
      NewTopLeft := Point(LeftCol, TopRow);

      DoChangePosKey(Cancel);

      if not (PointsEqual(NewTopLeft, Point(LeftCol, TopRow)) and
              PointsEqual(NewCurrent, Point(Col, Row))) then
      begin
        DoMove;

        if not Ok then
        begin
          NewRecDown := IsEOF and (Key = VK_DOWN) and CanInsert;

          if NewRecDown then
          begin
            if IsNewRecMode then
            begin
              Ok := isInplaceEditChanged in FState;
              if Ok then
              begin
                ExitNewRecMode(True);
                Ok := InitNewRecMode(False);
              end;
            end
            else
              Ok := InitNewRecMode(False);

            if not Ok then
              Beep;
          end
          else if Key = VK_TAB then
          begin
            NewCurrent := Point(Col, Row);
            NewTopLeft := Point(LeftCol, TopRow);

            DoChangePosKey(Cancel);
            DoMove;

            if not Ok then
              Beep;
          end
          else
            Beep;
        end;
      end;

      Key := 0;
    end
    else
      case Key of
        VK_F2:
        begin
          if IsEditorShown then
            HideInplaceEditor(True, True)
          else if ShowInplaceEditor then
            ScrollToCurrent
          else
            Beep;

          Key := 0;
        end;

        VK_F4:
        begin
          if not (ssAlt in Shift) then
          begin
            if not IsEditorShown then
            begin
              if ShowInplaceEditor then
              begin
                ScrollToCurrent;
                EditPanel(Self).ShowChooser;
              end
              else
                Beep;
            end
            else if not EditPanel(Self).ChooserChown then
              EditPanel(Self).ShowChooser
            else
              EditPanel(Self).HideChooser(True, True);

            Key := 0;
          end;
        end;

        VK_ESCAPE:
        begin
          if IsEditorShown then
            HideInplaceEditor(False, True)
          else if IsNewRecMode then
            ExitNewRecMode(False, Cancel)
          else if IsRowEditMode then
            ExitRowEditMode(False);

          Key := 0;
        end;

        VK_BACK:
        begin
          if ssCtrl in Shift then
          begin
            Ok := CanEdit;
            if Ok then
            begin
              if IsEditorShown then
              begin
                if not IsRowEditMode then
                  InitRowEditMode;

                EditPanel(Self).SetData(Null, Null, False)
              end
              else
              begin
                if CanStoreRowEdit and (not IsRowEditMode) then
                  InitRowEditMode;

                SetDataCell(CurrentColumn, CurrentRow, Null);

                if IsRowEditMode then
                  IncludeState(isRowEditChanged);
              end;
            end
            else
              Beep;

            Key := 0;
          end;
        end;

        VK_DELETE:
        begin
          if ssCtrl in Shift then
          begin
            Ok := CanRemove;

            if Ok then
            begin
              if Assigned(FBeforeRowDelete) then
              begin
                DoBeep := True;
                FBeforeRowDelete(Self, CurrentRow, Ok, DoBeep)
              end
              else if opConfirmDeleteRow in Options then
              begin
                DoBeep := False;
                Ok     := ConfirmDeleteCurrentRow;
              end;
            end
            else
              DoBeep := True;

            if Ok then
              DeleteCurrentRow
            else if DoBeep then
              Beep;

            Key := 0;
          end
          else
          begin
            if not (opAlwaysShowEditor in Options) then
            begin
              if IsEditorShown then
                HideInplaceEditor(True, True)
              else
              begin
                inpt.Kind := fikDelPress;
                if not ShowInplaceEditor(inpt) then
                  Beep;
              end;

              Key := 0;
            end;
          end;
        end;

        VK_INSERT:
        begin
          if not InitNewRecMode(True) then
            Beep;
          Key := 0;
        end;

        VK_RETURN:
        begin
          if not (opAlwaysShowEditor in Options) then
          begin
            if IsEditorShown then
              HideInplaceEditor(True, True)
            else if not ShowInplaceEditor then
              Beep;

            Key := 0;
          end;
        end;
      end;
  finally
    EndUpdateLow;
  end;
end;

procedure TLMDCustomGrid.KeyPress(var Key: Char);
begin
  // No inherited.
end;

procedure TLMDCustomGrid.KeyPressW(var Key: TLMDChar);
var
  inpt: TLMDGridFirstInput;
begin
  inpt.Kind  := fikChar;
  inpt.Char  := Key;
  inpt.Shift := [];

  if not IsEditorShown and not ShowInplaceEditor(inpt) then
    Beep;
end;

function TLMDCustomGrid.GetAutoColumnsMode: Boolean;
begin
  Result := False;
end;

procedure TLMDCustomGrid.GetAvailableColumnFieldNames(ACol: TLMDGridColumn;
  AList: TStrings);
begin
  // Do nothing.
end;

function TLMDCustomGrid.GetCellKind(ACol, ARow: Integer): TLMDGridCellKind;
begin
  if (isHaveVisibleRows in FState) and (isHaveVisibleCols in FState) then
  begin
    if IsHeaderRow(ARow) and IsDataCol(ACol) then
      Result := ckHeader
    else if IsHeaderRow(ARow) and (not IsDataCol(ACol)) then
      Result := ckDummyHeader
    else if (not IsHeaderRow(ARow)) and (not IsDataCol(ACol)) then
      Result := ckIndicator
    else if IsNewRecMode and (ARow = Row) then
      Result := ckNewRow
    else
      Result := ckData;
  end
  else if isHaveVisibleCols in FState then
  begin
    if IsHeaderRow(ARow) and IsDataCol(ACol) then
      Result := ckHeader
    else if IsHeaderRow(ARow) and (not IsDataCol(ACol)) then
      Result := ckDummyHeader
    else if (not IsHeaderRow(ARow)) and (not IsDataCol(ACol)) then
      Result := ckIndicator
    else
      Result := ckNewRow;
  end
  else
  begin
    Assert(not (isHaveVisibleRows in FState));

    if IsHeaderRow(ARow) then
      Result := ckDummyHeader
    else if (not IsHeaderRow(ARow)) and IsIndicatorCol(ACol) then
      Result := ckIndicator
    else
      Result := ckNewRow;
  end
end;

function TLMDCustomGrid.GetCellRowState(ACol, ARow: Integer): TLMDGridRowState;
var
  ck: TLMDGridCellKind;
begin
  Result := rsNormal;
  if ARow = Row then
  begin
    if IsIndicatorCol(ACol) then
      ck := GetCellKind(ACol + 1, ARow)
    else
      ck := GetCellKind(ACol, ARow);

    if ck = ckNewRow then
      Result := rsCurrentNewRow
    else if (IsEditorShown and (isInplaceEditChanged in FState)) or
             IsRowEditMode then
      Result := rsCurrentEditing
    else
      Result := rsCurrentNormal;
  end;
end;

function TLMDCustomGrid.GridColToDataCol(ACol: Integer): Integer;
var
  res, i, j: Integer;
begin
  if isHaveVisibleCols in FState then
  begin
    if opShowIndicator in Options then
      res := ACol - 1
    else
      res := ACol;

    if res >= 0 then
    begin
      j := 0;
      while (j < Columns.Count) and not Columns[j].Visible do
        Inc(j);

      i := 0;
      while i <> res do
      begin
        Inc(j);
        Inc(i);

        while (j < Columns.Count) and not Columns[j].Visible do
          Inc(j);
      end;

      Result := j;
    end
    else
      Result := res;

    if Result = Columns.Count then
      Result := -1; // No visible columns.
  end
  else
    Result := -1;
end;

function TLMDCustomGrid.GridRowToDataRow(ARow: Integer): Integer;
begin
  if opShowHeader in Options then
    Result := ARow - 1
  else
    Result := ARow;
end;

function TLMDCustomGrid.HaveVisibleData: Boolean;
begin
  Result := (isHaveVisibleCols in FState) and (isHaveVisibleRows in FState);
end;

function TLMDCustomGrid.HaveVisibleCols: Boolean;
begin
  Result := isHaveVisibleCols in FState;
end;

function TLMDCustomGrid.HaveRows: Boolean;
begin
  Result := isHaveVisibleRows in FState;
end;

function TLMDCustomGrid.HaveSelectedAutoColumns: Boolean;
var
  i: Integer;
begin
  for i := 0 to Columns.Count - 1 do
    if Columns[i].GetAutoColumnDesignerSelected then
    begin
      Result := True;
      Exit;
    end;

  Result := False;
end;

procedure TLMDCustomGrid.HideInplaceEditor(ACommitData, AReturnFocus: Boolean);
var
  k, v:   Variant;
  colObj: TLMDGridColumn;
begin
  if IsEditorShown then
  begin
    IncludeState(isInplaceEditHiding);
    try
      if ACommitData then
      begin
        Assert(isHaveVisibleCols in FState);
        Assert(isHaveVisibleRows in FState);

        colObj := Columns[CurrentColumn];
        if (isInplaceEditChanged in FState) and colObj.CanEdit then
        begin
          EditPanel(Self).GetData(k, v);
          SetDataCellLow(CurrentColumn, CurrentRow, k, v);
        end;
      end;

      ExcludeState(isEditing);
      BeginInternal;
      try
        TEditPanel(FEditPanel).Hide;
      finally
        EndInternal;
      end;

      if ACommitData and (isInplaceEditChanged in FState) and IsRowEditMode then
        IncludeState(isRowEditChanged);

      if not (isRowEditChanged in FState) then
        ExitRowEditMode(False);

      if not (IsNewRecMode or IsRowEditMode) then
        ExcludeState(isInplaceEditChanged);

      InvalidateIndicator;
      if AReturnFocus then
        Windows.SetFocus(Self.Handle);
    finally
      ExcludeState(isInplaceEditHiding);
    end;
  end;
end;

procedure TLMDCustomGrid.HidePopupChooserDelayed;
begin
  if not IsEditorShown then
    Exit;
  PostMessage(Handle, HIDEPOPUP_MESSAGE, 0, 0);
end;

procedure TLMDCustomGrid.HidePopupMessage(var Msg: TMessage);
begin
  if IsEditorShown then
    EditPanel(Self).HideChooser(False, False);
end;

//== TLMDGrid ==================================================================

procedure TLMDGrid.DeleteDataRow(ARow: Integer);
begin
  inherited DeleteDataRow(ARow);
end;

//== TEmbeddedEdit =============================================================

function GetTextEditor(ACol: TLMDGridColumn): TEmbeddedText;
begin
  Result := ACol.FEditor as TEmbeddedText;
end;

function TEmbeddedText.AsControl: TWinControl;
begin
  Result := Self;
end;

procedure TEmbeddedText.Change;
begin
  inherited;

  if (FGrid = nil) or FInit then
    Exit;
  SetEmpty(False);
  FGrid.EditorChanged;
end;

procedure TEmbeddedText.WndProc(var Message: TMessage);
begin
  if (FGrid = nil) or (not FGrid.WndProc(Self, Message)) then
    inherited WndProc(Message);
end;

function TEmbeddedText.Column: TLMDGridColumn;
begin
  Result := FCol;
end;

constructor TEmbeddedText.Create(ACol: TLMDGridColumn;
  AMaskedReturnKind: TLMDGridMaskedReturnKind);
begin
  inherited Create(nil);

  Font                := ACol.Font;
  TabStop             := False;
  Bevel.Mode          := bmStandard;
  Bevel.StandardStyle := lsNone;
  FCol                := ACol;
  FInKeyDown          := False;
  FMaskedReturnKind   := AMaskedReturnKind;
  FTextColor          := clWindowText;
end;

function TEmbeddedText.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := FGrid.DoMouseWheelDown(Shift);
end;

function TEmbeddedText.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := FGrid.DoMouseWheelUp(Shift);
end;

procedure TEmbeddedText.GetData(var AKey, AValue: Variant);
begin
  if IsEmpty or (Text = '') then
  begin
    if FCol.AllowUndefinedValue then
      AValue := Null
    else
      AValue := '';
    AKey   := Null;
  end
  else
  begin
    if MaskType <> meMask then
      AValue := Text
    else
    begin
      case FMaskedReturnKind of
        rkMasked:       AValue := Text;
        rkUnmasked:     AValue := UnMaskedText;
        rmMaskedTrim:   AValue := GetTrimmedText;
      else
        Assert(False);
      end;
    end;

    AKey := FKey;
  end;
end;

function TEmbeddedText.GetReadOnly: Boolean;
begin
  Result := ReadOnly;
end;

function TEmbeddedText.GetTrimmedText: TLMDString;
var
  s:         TLMDString;
  l, r, cnt: Integer;

  function FindBound(AStart, AEnd, AStep: Integer): Integer;
  var
      i: Integer;
  begin
    i := AStart;

    while i <> AEnd do
    begin
      if isLiteral(i) or (s[i] = TLMDChar(BlankChar)) then
        Inc(i, AStep)
      else
        Break;
    end;

    Result := i;
  end;

begin
  Assert(MaskType = meMask);

  s := Text;

  l := FindBound(1, Length(s) + 1, 1);
  r := FindBound(Length(s), l - 1, -1);

  cnt := r - l + 1;
  if cnt <> 0 then
    Result := System.Copy(s, l, cnt)
  else
    Result := '';
end;

procedure TEmbeddedText.HandleFirstInput(const AInput: TLMDGridFirstInput);
begin
  case AInput.Kind of
    fikChar:      begin
                    SelectAll;
                    Perform(WM_CHAR, Integer(AInput.Char), 0);
                  end;
    fikMouseDown: SelectAll; // Do nothing.
    fikDelPress:  if not GetReadOnly then
                  begin
                    Text    := '';
                    if FCol.AllowUndefinedValue then
                      IsEmpty := True;
                    FGrid.EditorChanged;
                  end;
  end;
end;

procedure TEmbeddedText.KeyDown(var Key: Word; Shift: TShiftState);
var
  selS, l: Integer;
begin
  if (Self.Parent as TEditPanel).FInShowMethod or FInKeyDown then
  begin
    inherited;
    Exit;
  end;

  FInKeyDown := True;
  try
    FGrid.KeyDownPreprocess(Key, Shift, psEdit);

    if Key <> 0 then
    begin
      if Key = VK_RETURN then
      begin
        if (SelStart = 0) and (SelLength = GetTextLen) then
          SelLength := 0
        else
        begin
          SelStart := 0;
          SelLength := GetTextLen;
        end;
        Key := 0;
      end
      else
      begin
        selS := SelStart;
        l := GetTextLen;

        if ((selS = 1) and (Key = VK_LEFT)) or
           ((selS > l) and (Key = VK_RIGHT)) then
          FGrid.KeyDownPostprocess(Key, Shift, psEdit)
        else
          inherited KeyDown(Key, Shift);
      end;
    end;
  finally
    FInKeyDown := False;
  end;
end;

procedure TEmbeddedText.RedefineTextColor(C: TCanvas);
begin
  C.Font.Color := FTextColor;
end;

procedure TEmbeddedText.SetGrid(AGridHelper: TLMDGridEditParentHelper);
begin
  FGrid := nil;
  Text  := '';
  FGrid := AGridHelper;

  ThemeMode       := FGrid.AsControl.ThemeMode;
  ThemeGlobalMode := FGrid.AsControl.ThemeGlobalMode;
  Color           := FGrid.AsControl.GetStyledColor(FCol.FColor);
  FTextColor      := FGrid.AsControl.GetStyledColor(FCol.Font.Color);
end;

procedure TEmbeddedText.SetReadOnly(AValue: Boolean);
begin
  ReadOnly := AValue;
end;

procedure TEmbeddedText.SetThemeMode(AThemeMode: TLMDThemeMode;
  AThemeGlobalMode: Boolean);
begin
  ThemeMode       := AThemeMode;
  ThemeGlobalMode := AThemeGlobalMode;
end;

procedure TEmbeddedText.SetData(const AKey, AValue: Variant;
  AInitValue: Boolean);
begin
  FInit := AInitValue;
  try
    SetEmpty(IsVarEmpty(@AValue) and IsVarEmpty(@AKey));
    FKey := AKey;

    if not IsEmpty then
    begin
      if IsVarEmpty(@AValue) then
        Text := ''
      else
        UnMaskedText := AValue;
    end;

    if (not AInitValue) and (FGrid <> nil) then
      FGrid.EditorChanged;

    if not IsVarEmpty(@AKey) then
      SetReadOnly(True);
  finally
    FInit := False;
  end;
end;

procedure TEmbeddedText.SetEmpty(AValue: Boolean);
begin
  inherited IsEmpty := AValue;
end;

procedure TEmbeddedText.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  FGrid.WMGetDlgCode(Self, Message);
end;

//== TLMDGridEmbeddedSpin ======================================================

function TEmbeddedSpin.AsControl: TWinControl;
begin
  Result := Self;
end;

procedure TEmbeddedSpin.Change;
begin
  inherited;

  if FInitMode then
    Exit;
  SetEmpty(False);
  Assert(FGrid <> nil);
  FGrid.EditorChanged;
end;

procedure TEmbeddedSpin.WndProc(var Message: TMessage);
begin
  if (FGrid = nil) or (not FGrid.WndProc(Self, Message)) then
    inherited WndProc(Message);
end;

function TEmbeddedSpin.Column: TLMDGridColumn;
begin
  Result := FCol;
end;

constructor TEmbeddedSpin.Create(ACol: TLMDGridColumn);
begin
  FInitMode := True;
  try
    inherited Create(nil);

    // Font         := FCol.Font;         // Moved into CreateHandle.
    // SpinBtnWidth := CHOOSER_BTNWIDTH;  //

    TabStop             := False;
    Bevel.Mode          := bmStandard;
    Bevel.StandardStyle := lsNone;
    Value               := 0;
    IsEmpty             := True;
    FCol                := ACol;
    FTextColor          := clWindowText;
  finally
    FInitMode := False;
  end;
end;

procedure TEmbeddedSpin.CreateHandle;
begin
  inherited;
  Font         := FCol.Font;
  SpinBtnWidth := CHOOSER_BTNWIDTH;
  UpdateColors;
end;

function TEmbeddedSpin.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := FGrid.DoMouseWheelDown(Shift);
end;

function TEmbeddedSpin.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := FGrid.DoMouseWheelUp(Shift);
end;

procedure TEmbeddedSpin.GetData(var AKey, AValue: Variant);
begin
  if IsEmpty then
  begin
    AValue := Null;
    AKey   := Null;
  end
  else
  begin
    AValue := Value;
    AKey   := FKey;
  end;
end;

function TEmbeddedSpin.GetReadOnly: Boolean;
begin
  Result := ReadOnly;
end;

procedure TEmbeddedSpin.HandleFirstInput(const AInput: TLMDGridFirstInput);
begin
  case AInput.Kind of
    fikChar:      begin
                    SelectAll;
                    Perform(WM_CHAR, Integer(AInput.Char), 0);
                  end;
    fikMouseDown: ; // Do nothing.
    fikDelPress:  if not GetReadOnly then
                  begin
                    Value := 0;
                    if FCol.AllowUndefinedValue then
                      IsEmpty := True;
                    FGrid.EditorChanged;
                  end;
  end;
end;

procedure TEmbeddedSpin.KeyDown(var Key: Word; Shift: TShiftState);
var
  handled:       Boolean;
  step:          Integer;
  selS, selL, l: Integer;
begin
  FGrid.KeyDownPreprocess(Key, Shift, psEdit);

  if Key <> 0 then
  begin
    handled := False;

    case Key of
      VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT:
      begin
        handled := ssCtrl in Shift;
        if handled then
        begin
          case Key of
            VK_UP:      step := LineSize;
            VK_DOWN:    step := -LineSize;
            VK_PRIOR:   step := PageSize;
            VK_NEXT:    step := -PageSize;
          else
            step := -1;
            Assert(False);
          end;

          if not ReadOnly then
            Value := Value + step;
        end;
      end;
      VK_RETURN:
      begin
        handled := True;

        if Key <> 0 then
        begin
          if (SelStart = 0) and (SelLength = GetTextLen) then
            SelLength := 0
          else
          begin
            SelStart  := 0;
            SelLength := GetTextLen;
          end;
        end;
      end;
    end;

    if not handled then
    begin
      selS := SelStart;
      selL := SelLength;
      l    := GetLength;

      inherited KeyDown(Key, Shift);

      if (selS = SelStart) and (selL = SelLength) and (l = GetLength) then
        FGrid.KeyDownPostprocess(Key, Shift, psEdit);
    end
    else
      Key := 0;
  end;
end;

procedure TEmbeddedSpin.RedefineTextColor(C: TCanvas);
begin
  C.Font.Color := FTextColor;
end;

procedure TEmbeddedSpin.SetData(const AKey, AValue: Variant;
  AInitValue: Boolean);
begin
  FKey := AKey;

  FInitMode := True;
  try
    SetEmpty(IsVarEmpty(@AValue) and IsVarEmpty(@AKey));

    if not IsEmpty then
    begin
      if IsVarEmpty(@AValue) then
        Value := 0
      else
        Value := AValue;
    end;
  finally
    FInitMode := False;
  end;

  if not IsVarEmpty(@AKey) then
    SetReadOnly(True);

  if (not AInitValue) and (FGrid <> nil) then
    FGrid.EditorChanged;
end;

procedure TEmbeddedSpin.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  FGrid.WMGetDlgCode(Self, Message);
end;

procedure TEmbeddedSpin.SetEmpty(AValue: Boolean);
begin
  inherited IsEmpty := AValue;
end;

procedure TEmbeddedSpin.SetGrid(AGridHelper: TLMDGridEditParentHelper);
begin
  FGrid           := AGridHelper;
  ThemeMode       := FGrid.AsControl.ThemeMode;
  ThemeGlobalMode := FGrid.AsControl.ThemeGlobalMode;
  UpdateColors;
end;

procedure TEmbeddedSpin.SetReadOnly(AValue: Boolean);
begin
  ReadOnly := AValue;
end;

procedure TEmbeddedSpin.SetShowButtons(AShowButtons: Boolean);
begin
  SpinBtnVisible := AShowButtons;
end;

procedure TEmbeddedSpin.SetThemeMode(AThemeMode: TLMDThemeMode;
  AThemeGlobalMode: Boolean);
begin
  ThemeMode       := AThemeMode;
  ThemeGlobalMode := AThemeGlobalMode;
end;

procedure TEmbeddedSpin.UpdateColors;
begin
  if (FGrid <> nil) and HandleAllocated then
  begin
    Color      := FGrid.AsControl.GetStyledColor(FCol.FColor);
    FTextColor := FGrid.AsControl.GetStyledColor(FCol.Font.Color);
  end;
end;

//== TLMDGridColumn ============================================================

procedure TLMDGridColumn.BeginUpdate;
begin
  if Grid <> nil then
    Grid.BeginUpdateLow(True, True);
end;

constructor TLMDGridColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Assert(not (csLoading in ComponentState));
  FPaddings[0] := 3;
  FPaddings[1] := 3;
  FPaddings[2] := 3;
  FPaddings[3] := 3;

  FAutoColDesignerSelected := False;

  FSortingAllowed := True;
  FReadOnly := False;
  FVisible := True;
  FWidth   := 50;
  FPosition := -1;
  FGrid := nil;

  FFont := TFont.Create;
  FFont.OnChange := OnFontChange;

  FAlignment := Classes.taLeftJustify;
  FVertAlign := taVerticalCenter;
  FSettings := [];

  FTitle := TLMDGridColumnTitle.Create(Self);

  FChooser := CreateDefChooser;

  FDummyLookupRoot := TComponent.Create(nil);
  FFramesUpdating := False;
  FChooserDsgHelper := TChooserDsgHelper.Create(Self);

  FDefaultColor        := True;
  FColor               := clWindow;
  FAltrernateColor     := clWindow;
  FAltrernateLoaded    := False;
  FAllowUndefinedValue := True;
end;

function TLMDGridColumn.CreateChooser(
  ADescr: TLMDGridChooserDescr): TLMDGridColumnChooser;
begin
  Result := ADescr.ChooserClass.Create(Self);
end;

destructor TLMDGridColumn.Destroy;
begin
  Grid := nil;
  FreeAndNil(FTitle);
  if FEditor <> nil then
  begin
    FEditor.Parent := nil;
    FreeAndNil(FEditor);
  end;
  FreeAndNil(FFont);
  FreeAndNil(FChooser);
  FreeAndNil(FDummyLookupRoot);
  FreeAndNil(FChooserDsgHelper);

  inherited;
end;

procedure TLMDGridColumn.EndUpdate;
begin
  if Grid <> nil then
    Grid.EndUpdateLow;
end;

function TLMDGridColumn.GetAlignment: TAlignment;
begin
  if (csAlignment in FSettings) or (Grid = nil) then
    Result := FAlignment
  else
    Result := Grid.GetDefaultColumnAlignment(Self);
end;

function TLMDGridColumn.GetAutoColumnDesignerSelected: Boolean;
begin
  Result := FAutoColDesignerSelected;
end;

function TLMDGridColumn.GetColumnDataType: TFieldType;
var
  f: TField;
begin
  if FGrid <> nil then
    f := FGrid.GetColumnField(Self)
  else
    f := nil;

  if f = nil then
    Result := FDefaultDataType
  else
    Result := f.DataType;
end;

function TLMDGridColumn.GetColumnCompatDataTypes: TLMDGridFieldTypes;
var
  cnt, i:    Integer;
  cur, best: TLMDGridColumnDescr;
begin
  Result := [];
  cnt    := TLMDGridColumn.RegisteredColumnClassesCount;
  best   := nil;

  for i := 0 to cnt - 1 do
  begin
    cur := TLMDGridColumn.GetRegisteredColumnClass(i);

    if Self.InheritsFrom(cur.ColClass) then
    begin
      if (best = nil) or cur.ColClass.InheritsFrom(best.ColClass) then
        best := cur;
      if best.ColClass = ClassType then
        Break; // for
    end;
  end;

  if best <> nil then
    Result := best.FieldTypes;

  Assert(Result <> []);
end;

function TLMDGridColumn.GetColumnKind: TFieldKind;
var
  f: TField;
begin
  if FGrid <> nil then
    f := FGrid.GetColumnField(Self)
  else
    f := nil;

  if f = nil then
    Result := fkData
  else
    Result := f.FieldKind;
end;

function TLMDGridColumn.ParseEditorData(const AEditData: Variant;
  ARaiseError: Boolean; PErrMsg: PLMDString; var Res: Variant): Boolean;
begin
  Res    := AEditData;
  Result := True;
end;

function TLMDGridColumn.GetFont: TFont;
var
  save: TNotifyEvent;
begin
  if (csFont in FSettings) or (Grid = nil) or
     ((FFont.Handle = Grid.Font.Handle) and (FFont.Color = Grid.Font.Color))
  then
    Result := FFont
  else
  begin
    save := FFont.OnChange;
    FFont.OnChange := nil;
    FFont.Assign(Grid.Font);
    FFont.OnChange := save;

    Result := FFont;
  end;
end;

function TLMDGridColumn.GetPadding(const Index: Integer): Integer;
begin
  Result := FPaddings[Index];
end;

function TLMDGridColumn.GetParentComponent: TComponent;
begin
  if Grid <> nil then
    Result := Grid
  else
    Result := inherited GetParentComponent;
end;

class function TLMDGridColumn.GetRegisteredColumnClass(
  AIndex: Integer): TLMDGridColumnDescr;
begin
  CheckIntValue('GetRegisteredColumnClass, AIndex arg', AIndex, 0,
                RegisteredColumnClassesCount - 1);
  Result := ColumnClasses[AIndex] as TLMDGridColumnDescr;
end;

function TLMDGridColumn.GetReadOnly: Boolean;
var
  f:                  TField;
  fieldRO, unboundRO: Boolean;
begin
  fieldRO := False;
  unboundRO := False;

  if Grid <> nil then
  begin
    f := Grid.GetColumnField(Self);
    if f <> nil then
      fieldRO := f.ReadOnly or (not (f.FieldKind in [fkData, fkLookup,
                                                     fkInternalCalc]));
  end;
      
  if (Grid = nil) or (csReadOnly in FSettings) then
    Result := FReadOnly
  else
    Result := Grid.GetDefaultColumnReadOnly(Self);

  if Grid <> nil then
    unboundRO := not Grid.InternalIsColumnDataBound(Position);

  Result := Result or fieldRO or unboundRO;
end;

class function TLMDGridColumn.GetRegisteredColumnClass(
  AFieldType: TFieldType): TLMDGridColumnDescr;
var
  i:     Integer;
  descr: TLMDGridColumnDescr;
begin
  Result := nil;
  for i := 0 to ColumnClasses.Count - 1 do
  begin
    descr := ColumnClasses[i] as TLMDGridColumnDescr;

    if AFieldType in descr.FieldTypes then
    begin
      Result := descr;
      Exit;
    end;
  end;
end;

function TLMDGridColumn.GetVisible: Boolean;
begin
  if (csVisible in FSettings) or (Grid = nil) then
    Result := FVisible
  else
    Result := Grid.GetDefaultColumnVisible(Self);
end;

function TLMDGridColumn.GetWidth: Integer;
begin
  if (csWidth in FSettings) or (Grid = nil) then
    Result := FWidth
  else
    Result := Grid.GetDefaultColumnWidth(Self);
end;

function TLMDGridColumn.HasParent: Boolean;
begin
  if Grid <> nil then
    Result := True
  else
    Result := inherited HasParent;
end;

procedure TLMDGridColumn.CheckInitPropsForField;
begin
end;

function TLMDGridColumn.IsAlignmentStored: Boolean;
begin
  Result := csAlignment in FSettings;
end;

function TLMDGridColumn.IsAltrernateColorStored: Boolean;
begin
  Result := not FDefaultColor and (FAltrernateColor <> FColor);
end;

function TLMDGridColumn.IsColorStored: Boolean;
begin
  Result := not FDefaultColor;
end;

function TLMDGridColumn.IsDefaultChooserClass(AClass: TClass): Boolean;
begin
  Result := IsDefaultChooserClassName(AClass.ClassName);
end;

function TLMDGridColumn.IsDefaultChooserClassName(AClassName: string): Boolean;
begin
  Result := AClassName = TLMDGridCustomChooser.ClassName;
end;

function TLMDGridColumn.IsFieldTypeCompatibleWithColSettings(
  AField: TField; PErrMessage: PLMDString): Boolean;
begin
  Result := AField.DataType in GetColumnCompatDataTypes;
  if (not Result) and (PErrMessage <> nil) then
    PErrMessage^ := Format(SLMDGridIncompatibleField, [AField.Name]);
end;

function TLMDGridColumn.IsFontStored: Boolean;
begin
  Result := csFont in FSettings;
end;

function TLMDGridColumn.IsReadOnlyStored: Boolean;
begin
  Result := csReadOnly in FSettings;
end;

function TLMDGridColumn.IsValueValid(Value: PVariant;
  AErrMsg: PLMDString): Boolean;
var
  res: Variant;
begin
  Result := ParseEditorData(Value^, False, AErrMsg, res);
end;

function TLMDGridColumn.IsVisibleStored: Boolean;
begin
  Result := csVisible in FSettings;
end;

function TLMDGridColumn.IsWidthStored: Boolean;
begin
  Result := csWidth in FSettings;
end;

procedure TLMDGridColumn.NormalizeValue(ASrcValue, ADestValue: PVariant);
begin
  ADestValue^ := ASrcValue^;
end;

procedure TLMDGridColumn.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);

  if Reader.Parent is TLMDCustomGrid then
    Grid := Reader.Parent as TLMDCustomGrid;
end;

procedure TLMDGridColumn.RefreshDefaultColor;
begin
  if FDefaultColor and (FGrid <> nil) then
  begin
    FColor := FGrid.Style.CellBgColor;
    FAltrernateColor := FGrid.Style.AlternateBgColor;
  end;
end;

procedure TLMDGridColumn.RefreshDefaultFont;
var
  save: TNotifyEvent;
begin
  if (csFont in FSettings) or (Grid = nil) then
    Exit;

  save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(Grid.Font);
  finally
    FFont.OnChange := save;
  end;

  Title.RefreshDefaultFont;
end;

procedure TLMDGridColumn.DetachEmbeddedEditor;
begin
  FEditor.Parent := nil;
end;

function TLMDGridColumn.GetDefaultChooserDescr: TLMDGridChooserDescr;
begin
  Result := TLMDGridColumnChooser.GetRegisteredChooserClass(GetColumnDataType,
                                                            GetColumnKind);
end;

function TLMDGridColumn.GetDsgHelper: TPersistent;
begin
  Result := FChooserDsgHelper;
end;

procedure TLMDGridColumn.PaintCellBG(ACanvas: TCanvas;
  ADataRow: Integer; ARect: TRect; ACellState: TLMDGridCellStates;
  AWithFrame: Boolean; APaddingRect: TRect; var ContentRect: TRect);
var
  r, sr:       TRect;
  needFocRect: Boolean;
  isSingleSel: Boolean;
begin
  r                   := ARect;
  ACanvas.Brush.Style := bsSolid;
  ACanvas.Font        := Self.Font;
  needFocRect         := (csSelectedCell in ACellState) and
                         (opDrawFocusSelected in Grid.Options);
  isSingleSel         := csSingleCellSelection in ACellState;

  if not (csEditing in ACellState) and (csInSelectedArea in ACellState) then
  begin
    ACanvas.Brush.Color := Grid.GetStyledColor(Grid.Style.SelectedCellBgColor);
    ACanvas.Font.Color  := Grid.GetStyledColor(Grid.Style.SelectedCellTextColor);
  end
  else
  begin
    ACanvas.Brush.Color := Grid.GetDataCellColor(Self, ACellState, ADataRow);
    ACanvas.Font.Color  := Grid.GetStyledColor(Font.Color);
  end;

  ACanvas.FillRect(r);

  if AWithFrame then
  begin
    { Grid lines }

    ACanvas.Pen.Handle := 0; // Bug fix of XE2 VCL themes. Otherwise,
                             // grid lines will be drawn in random color.
    ACanvas.Pen.Width  := Grid.GridLineWidth;
    ACanvas.Pen.Color  := Grid.GetStyledColor(Grid.Style.CellGridLinesColor);

    if opVertLine in Grid.Options then
    begin
      ACanvas.MoveTo(r.Right - 1, r.Top);
      ACanvas.LineTo(r.Right - 1, r.Bottom);
      Dec(r.Right);
    end;
    if opHorzLine in Grid.Options then
    begin
      ACanvas.MoveTo(r.Left,  r.Bottom - 1);
      ACanvas.LineTo(r.Right, r.Bottom - 1);
      Dec(r.Bottom);
    end;

    { Selection border }

    if (Grid.Style.SelectBorderColor <> clNone) and
       not (needFocRect and isSingleSel and (csEditing in ACellState)) then
    begin
      ACanvas.Brush.Color := Grid.Style.SelectBorderColor;
      sr                  := ARect;

      if csSelRight in ACellState then
        sr.Right := r.Right;
      if csSelBottom in ACellState then
        sr.Bottom := r.Bottom;

      if csSelLeft in ACellState then
        ACanvas.FillRect(Rect(sr.Left, sr.Top, sr.Left + 1, sr.Bottom));
      if csSelTop in ACellState then
        ACanvas.FillRect(Rect(sr.Left, sr.Top, sr.Right, sr.Top + 1));
      if csSelRight in ACellState then
        ACanvas.FillRect(Rect(sr.Right - 1, sr.Top, sr.Right, sr.Bottom));
      if csSelBottom in ACellState then
        ACanvas.FillRect(Rect(sr.Left, sr.Bottom - 1, sr.Right, sr.Bottom));
    end;

    { Focus rect }

    if needFocRect then
      DrawFocusRect(ACanvas.Handle, r);
  end;

  Inc(r.Left,   APaddingRect.Left);
  Inc(r.Top,    APaddingRect.Top);
  Dec(r.Right,  APaddingRect.Right);
  Dec(r.Bottom, APaddingRect.Bottom);

  ContentRect := r;
end;

procedure TLMDGridColumn.PaintFormattedCellData(ACanvas: TCanvas;
  ARect: TRect; const AData: Variant; AAlignment: TAlignment;
  ACellState: TLMDGridCellStates);
begin
  // Do nothing.
end;

function TLMDGridColumn.IsSortingAllowed: Boolean;
begin
  Result := True;
end;

procedure TLMDGridColumn.DefTextOut(ACanvas: TCanvas; ARect: TRect;
  const S: TLMDString; AAlignment: TAlignment; AWrapWords,
  AExpandTabs: Boolean; ACellState: TLMDGridCellStates; AStyle: TLMDGridStyle);
var
  r: TRect;
begin
  DefTextOut(ACanvas, ARect, S, AAlignment, AWrapWords, AExpandTabs,
             0, ACellState, AStyle, r);
end;

procedure TLMDGridColumn.DefineProperties(Filer: TFiler);
var
  ancCol: TLMDGridColumn;
  doSave: Boolean;
  ms:     TMemoryStream;
  wr:     TWriter;

  function CompareChoosers(ARoot1, ARoot2: TComponent; ALookRoot1,
                           ALookRoot2: TComponent; ACh1,
                           ACh2: TLMDGridColumnChooser): Boolean;
  var
    ms1, ms2: TMemoryStream;
    wr1, wr2: TWriter;
  begin
    ms1 := TMemoryStream.Create;
    ms2 := TMemoryStream.Create;
    try
      wr1 := TWriter.Create(ms1, 1024);
      wr2 := TWriter.Create(ms2, 1024);
      try
        wr1.Root := ARoot1;
        TComponent((@wr1.LookupRoot)^) := ALookRoot1;

        wr2.Root := ARoot2;
        TComponent((@wr2.LookupRoot)^) := ALookRoot2;

        TWriterAccess(wr1).WriteProperties(ACh1);
        TWriterAccess(wr2).WriteProperties(ACh2);
      finally
        wr1.Free;
        wr2.Free;
      end;

      Result := (ms1.Size = ms2.Size) and
                CompareMem(ms1.Memory, ms2.Memory, ms1.Size);
    finally
      ms1.Free;
      ms2.Free;
    end;
  end;

begin
  inherited;
  FFramesUpdating := not ((Filer is TReader) or (Filer is TWriter));

  if Filer is TReader then
    doSave := False
  else if Filer.Ancestor <> nil then
  begin
    ancCol := Filer.Ancestor as TLMDGridColumn;
    doSave := ancCol.ChooserClass <> ChooserClass;
    if not doSave then
    begin
      if FFramesUpdating then
        doSave := not CompareChoosers(Owner, ancCol.Owner,
                                      Owner, ancCol.Owner,
                                      Chooser, ancCol.Chooser)
      else
        doSave := not CompareChoosers(Filer.Root, ancCol.Owner,
                                      Filer.LookupRoot, FDummyLookupRoot,
                                      Chooser, ancCol.Chooser);
    end;
  end
  else
  begin
    Assert(Chooser <> nil);

    doSave := not IsDefaultChooserClass(Chooser.ClassType);
    if not doSave then
    begin
      ms := TMemoryStream.Create;
      wr := TWriter.Create(ms, 1024);
      try
        wr.Root := Owner;
        TWriterAccess(wr).WriteProperties(Chooser);
        doSave := wr.Position <> 0;
      finally
        wr.Free;
        ms.Free;
      end;
    end;
  end;

  FTmpRoot := Filer.Root;
  FTmpAnc  := Filer.Ancestor;
  if FTmpAnc <> nil then
    FTmpRootAnc := (FTmpAnc as TComponent).Owner
  else
    FTmpRootAnc := nil;

  Filer.DefineProperty('ChooserData', ReadChooser, WriteChooser, doSave);
end;

procedure TLMDGridColumn.DefTextOut(ACanvas: TCanvas; ARect: TRect;
  const S: TLMDString; AAlignment: TAlignment; AWrapWords, AExpandTabs: Boolean;
  AGlyphW: Integer; ACellState: TLMDGridCellStates; AStyle: TLMDGridStyle;
  var TextR: TRect);
var
  flags, h, rh, w: Integer;
  r:               TRect;
begin
  if csInvalidValue in ACellState then
    ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];

  ACanvas.Brush.Style := bsClear;
  flags               := DT_NOPREFIX or DT_WORD_ELLIPSIS;

  case AAlignment of
    Classes.taLeftJustify:  flags := flags or DT_LEFT;
    Classes.taRightJustify: flags := flags or DT_RIGHT;
    Classes.taCenter:       flags := flags or DT_CENTER;
  end;

  case VertAlignment of
    taAlignTop:       flags := flags or DT_TOP;
    taAlignBottom:    flags := flags or DT_BOTTOM;
    taVerticalCenter: flags := flags or DT_VCENTER;
  end;

  if AWrapWords then
    flags := flags or DT_WORDBREAK
  else
    flags := flags or DT_SINGLELINE;

  rh := ARect.Bottom - ARect.Top;
  r := ARect;
  h := LMDDrawText(ACanvas.Handle, S, Length(S), r, flags or DT_CALCRECT);
  h := Min(h, rh);
  w := r.Right - r.Left;

  case VertAlignment of
    taVerticalCenter: TextR.Top := (ARect.Bottom + ARect.Top - h) div 2;
    taAlignBottom:    TextR.Top := ARect.Bottom - h;
    taAlignTop:       TextR.Top := ARect.Top;
  end;
  TextR.Bottom := TextR.Top + h;

  case AAlignment of
    Classes.taLeftJustify:  TextR.Left := ARect.Left + AGlyphW;
    Classes.taRightJustify: TextR.Left := ARect.Right - w;
    Classes.taCenter:       TextR.Left := (ARect.Left + ARect.Right - w + AGlyphW) div 2;
  end;
  TextR.Right := TextR.Left + w;

  LMDDrawText(ACanvas.Handle, S, Length(S), TextR, flags);
end;

procedure TLMDGridColumn.Assign(ASrc: TPersistent);
var
  col: TLMDGridColumn;
begin
  if ASrc = Self then
    Exit;

  if ASrc is TLMDGridColumn then
  begin
    col := ASrc as TLMDGridColumn;
    BeginUpdate;
    try
      if csFont in col.FSettings then
      begin
        Include(FSettings, csFont);
        FFont.Assign(col.Font);
      end;

      if csAlignment in col.FSettings then
      begin
        Include(FSettings, csAlignment);
        FAlignment := col.Alignment;
      end;

      if csAlignmentV in col.FSettings then
      begin
        Include(FSettings, csAlignmentV);
        FVertAlign := col.VertAlignment;
      end;

      Visible := col.Visible;
      Width := col.Width;
      Position := col.Position;
      SortKind := col.SortKind;

      Title.Assign(col.Title);
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(ASrc);
end;

class procedure TLMDGridColumn.RegisterColumnClass(
  AColClass: TLMDGridColumnClass; ADescription: TLMDString;
  AImage: TBitmap; ADataTypes: TLMDGridFieldTypes);
var
  descr: TLMDGridColumnDescr;
  i:     Integer;
begin
  for i := 0 to ColumnClasses.Count - 1 do
    if TLMDGridColumnDescr(ColumnClasses[i]).ColClass = AColClass then
      raise ELMDGridError.Create(SLMDGridDuplicateColClass);

  descr := TLMDGridColumnDescr.Create;

  descr.ColClass := AColClass;
  descr.Description := ADescription;
  descr.FieldTypes := ADataTypes;

  if AImage <> nil then
  begin
    descr.Image := TBitmap.Create;
    descr.Image.Assign(AImage);
  end
  else
    descr.Image := nil;

  ColumnClasses.Add(descr);
end;

class function TLMDGridColumn.RegisteredColumnClassesCount: Integer;
begin
  if ColumnClasses <> nil then
    Result := ColumnClasses.Count
  else
    Result := 0;
end;

procedure TLMDGridColumn.RemoveSetting(ASet: TLMDColSetting);
begin
  Exclude(FSettings, ASet);
end;

procedure TLMDGridColumn.ResetPaintCache;
begin
  // Do nothing.
end;

procedure TLMDGridColumn.SetAlignment(const Value: TAlignment);
begin
  if Alignment = Value then
    Exit;

  BeginUpdate;
  Include(FSettings, csAlignment);
  FAlignment := Value;
  EndUpdate;
end;

procedure TLMDGridColumn.SetAllowUndefinedValue(const Value: Boolean);
begin
  if FAllowUndefinedValue <> Value then
  begin
    BeginUpdate;
    FAllowUndefinedValue := Value;
    EndUpdate;
  end;
end;

procedure TLMDGridColumn.SetAltrernateColor(const Value: TColor);
begin
  if FAltrernateColor <> Value then
  begin
    BeginUpdate;
    FAltrernateColor  := Value;
    FAltrernateLoaded := (csLoading in ComponentState);
    FDefaultColor     := False;
    EndUpdate;
  end;
end;

procedure TLMDGridColumn.SetAutoColumnDesignerSelected(AValue: Boolean);
begin
  FAutoColDesignerSelected := AValue;
end;

procedure TLMDGridColumn.SetChooserByClass(const Value: TClass);
var
    Dsc: TLMDGridChooserDescr;
begin
  Assert(Value <> nil);

  Dsc := TLMDGridColumnChooser.GetRegisteredChooserClass(Value);
  if Dsc = nil then
    raise ELMDGridError.CreateFmt(SLMDGridCantFindChooserByClass,
                                  [Value.ClassName]);
  SetChooserByDescr(Dsc);
end;

function TLMDGridColumn.FormatEditorData(const AGridData: Variant): Variant;
begin
  Result := AGridData;
end;

function TLMDGridColumn.FormatPaintData(const AGridData: Variant): Variant;
begin
  Result := FormatEditorData(AGridData);
end;

procedure TLMDGridColumn.SetFieldName(const Value: string);
begin
  if FFieldName = Value then
    Exit;

  BeginUpdate;
  try
    if (Grid <> nil) and (not Grid.InInitMode) then
      Grid.SetColFieldNameLow(Self, Value, FFieldName)
    else
      FFieldName := Value;

    CheckColumnDataTypeChange;
  finally
    EndUpdate;
  end;
end;

procedure TLMDGridColumn.SetFont(const Value: TFont);
begin
  if Font = Value then
    Exit;

  BeginUpdate;
  try
    Include(FSettings, csFont);
    FFont.Assign(Value);
  finally
    EndUpdate;
  end;
end;

procedure TLMDGridColumn.OnFontChange(ASender: TObject);
begin
  BeginUpdate;
  try
    Include(FSettings, csFont);
    Title.RefreshDefaultFont;
  finally
    EndUpdate;
  end;
end;

procedure TLMDGridColumn.SetTitle(const Value: TLMDGridColumnTitle);
begin
  if FTitle <> Value then
  begin
    BeginUpdate;
    try
      FTitle.Assign(Value);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TLMDGridColumn.SetGrid(const Value: TLMDCustomGrid);
begin
  if FGrid <> Value then
  begin
    if FGrid <> nil then
      FGrid.RemoveColumn(Self);

    FGrid := Value;

    if Grid <> nil then
    begin
      Grid.BeginUpdateLow(False, True);
      try
        Grid.InsertColumn(Self);

        RefreshDefaultFont;
        RefreshDefaultColor;

        Grid.InternalSetColumnGrid(Self);

        if SortKind <> skNone then
          FSortKind := Grid.SetSortLow(Self, SortKind);

        Grid.RebuildColsSaved;
        CheckColumnDataTypeChange;

        Grid.InternalUpdateStore;
      finally
        Grid.EndUpdateLow;
      end;
    end
    else
      FPosition := -1;
  end;
end;

procedure TLMDGridColumn.SetDefaultColor(const Value: Boolean);
begin
  if FDefaultColor <> Value then
  begin
    BeginUpdate;
    FDefaultColor := Value;
    RefreshDefaultColor;
    EndUpdate;
  end;
end;

procedure TLMDGridColumn.SetPadding(const Index, Value: Integer);
var
  n: string;
begin
  if FPaddings[Index] <> Value then
  begin
    case Index of
      0: n := 'PaddingLeft';
      1: n := 'PaddingRight';
      2: n := 'PaddingTop';
      3: n := 'PaddingBottom';
    end;

    CheckIntValue(n, Value, 0);

    BeginUpdate;
    FPaddings[Index] := Value;
    EndUpdate;
  end;
end;

procedure TLMDGridColumn.SetParentComponent(AParent: TComponent);
begin
  if (not (csLoading in ComponentState)) and (AParent is TLMDCustomGrid) then
    Grid := AParent as TLMDCustomGrid;
end;

procedure TLMDGridColumn.SetPosition(const Value: Integer);
begin
  if FPosition = Value then
    Exit;

  BeginUpdate;
  try
    if FGrid <> nil then
      FGrid.SetColPositionLow(Self, Value)
    else
      FPosition := Value;
  finally
    EndUpdate;
  end;
end;

procedure TLMDGridColumn.SetReadOnly(const Value: Boolean);
begin
  if ReadOnly = Value then
    Exit;

  BeginUpdate;
  try
    Include(FSettings, csReadOnly);
    if Grid <> nil then
      Grid.SetColReadOnlyLow(Self, Value, FReadOnly)
    else
      FReadOnly := Value;
  finally
    EndUpdate;
  end;
end;

procedure TLMDGridColumn.SetSortingAllowed(const Value: Boolean);
begin
  if FSortingAllowed <> Value then
  begin
    FSortingAllowed := Value;
    if not Value then
      SortKind := skNone;
  end;
end;

procedure TLMDGridColumn.SetSortKind(const Value: TLMDGridSortKind);
begin
  if FSortKind = Value then
    Exit;

  BeginUpdate;
  try
    FSortKind := Value;

    if FGrid <> nil then
    begin
      if Value <> skNone then
        FSortingAllowed := True;
      FSortKind := FGrid.SetSortLow(Self, Value);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TLMDGridColumn.SetVertAlign(const Value: TVerticalAlignment);
begin
  if VertAlignment = Value then
    Exit;

  BeginUpdate;
  try
    Include(FSettings, csAlignmentV);
    FVertAlign := Value;
  finally
    EndUpdate;
  end;
end;

procedure TLMDGridColumn.SetVisible(const Value: Boolean);
begin
  if Visible = Value then
    Exit;

  BeginUpdate;
  try
    Include(FSettings, csVisible);

    if FGrid <> nil then
      FGrid.SetColVisibleLow(Self, Value, FVisible)
    else
      FVisible := Value;
  finally
    EndUpdate;
  end;
end;

procedure TLMDGridColumn.SetWidth(const Value: Integer);
begin
  if Width = Value then
    Exit;

  BeginUpdate;
  try
    Include(FSettings, csWidth);

    if FGrid <> nil then
      FGrid.SetColWidthLow(Self, Value, FWidth)
    else
      FWidth := Value;
  finally
    EndUpdate;
  end;
end;

procedure TLMDGridColumn.Updated;
begin
  inherited;
  if FChooser = nil then
    FChooser := CreateDefChooser;
end;

procedure TLMDGridColumn.ReadChooser(Reader: TReader);
var
  ChName: string;
  r: TReaderAccess absolute Reader;
  ppath: string;
begin
  r.CheckValue(vaCollection);
  if not r.EndOfList then
  begin
    r.ReadListBegin;

    ppath := r.ReadStr;
    if ppath <> 'ChooserName' then
      raise ELMDGridError.Create(SLMDGridBadChooserData);

    ChName := r.ReadString;
    SetChooserName(ChName);

    while not r.EndOfList do
      r.ReadProperty(Chooser);

    r.ReadListEnd;
  end;

  r.ReadListEnd;
end;

procedure TLMDGridColumn.WriteChooser(Writer: TWriter);
var
  w:             TWriterAccess absolute Writer;
  oldpth:        string;
  oldanc:        TPersistent;
  chname:        string;
  oldroot:       TComponent;
  oldlroot:      TComponent;
  oldrootanc:    TComponent;
  OldAncestor:   TPersistent;
  ancestorValid: Boolean;
  ancChooser:    TLMDGridColumnChooser;

begin
  oldpth := TWriterHack(w).FPropPath;
  oldanc := w.Ancestor;
  oldroot := w.Root;
  oldrootanc := w.RootAncestor;
  oldlroot := w.LookupRoot;

  TWriterHack(w).FPropPath := '';

  if FFramesUpdating then
  begin
    w.Root := FTmpRoot;
    w.Ancestor := FTmpAnc;
    w.RootAncestor := FTmpRootAnc;
    TComponent((@w.LookupRoot)^) := FTmpRoot;
  end;

  try
    w.WriteValue(vaCollection);
    w.WriteListBegin;

    w.WritePropName('ChooserName');
    chname := GetNameOfChooser(Chooser);
    w.WriteString(chname);

    OldAncestor := w.Ancestor;
    try
      ancestorValid := (w.Ancestor <> nil) and (w.RootAncestor <> nil) and
                        w.Root.InheritsFrom(w.RootAncestor.ClassType);

      if ancestorValid then
      begin
        ancChooser := (w.Ancestor as TLMDGridColumn).Chooser;
        if ancChooser.ClassType = Chooser.ClassType then
          TWriterAccess(w).Ancestor := ancChooser
        else
          TWriterAccess(w).Ancestor := nil;
      end;

      TWriterAccess(w).WriteProperties(Chooser);
    finally
      TWriterHack(w).Ancestor := OldAncestor;
    end;

    w.WriteListEnd;
    w.WriteListEnd;
  finally
    TWriterHack(w).Ancestor := oldanc;
    w.Root := oldroot;
    TWriterHack(w).FPropPath := oldpth;
    w.RootAncestor := oldrootanc;
    TComponent((@w.LookupRoot)^) := oldlroot;
  end;
end;

function TLMDGridColumn.CanEdit: Boolean;
begin
  Result := not ReadOnly;
  if Assigned(FOnCanEdit) then
    FOnCanEdit(Grid, Self, Result);
end;

procedure TLMDGridColumn.CheckChooserDsc(const ADescr: TLMDGridChooserDescr);
var
  ft: TFieldType;
  fk: TFieldKind;
begin
  Assert(ADescr <> nil);

  ft := GetColumnDataType;
  fk := GetColumnKind;

  if not (((ft in ADescr.MainFieldTypes) and (fk in ADescr.FieldKinds)) or
          ((ft in ADescr.CompatibleFieldTypes) and (fk in ADescr.FieldKinds)))
  then
    raise ELMDGridError.CreateFmt(SLMDGridIncompatibleChooserClass,
                                  [ClassName, ADescr.ChooserName]);
end;

procedure TLMDGridColumn.CheckColumnDataTypeChange;
var
  ft: TFieldType;
  fk: TFieldKind;
  descr, descrBetter: TLMDGridChooserDescr;
  valid: Boolean;
begin
  if FChooser = nil then
    Exit;

  ft := GetColumnDataType;
  fk := GetColumnKind;

  descr := TLMDGridColumnChooser.GetRegisteredChooserClass(FChooser.ClassType);
  descrBetter := TLMDGridColumnChooser.GetRegisteredChooserClass(ft, fk);

  valid := ((ft in descr.MainFieldTypes) or
            (ft in descr.CompatibleFieldTypes)) and
           (fk in descr.FieldKinds);

  FChooser.SetValid(valid);
  if FGrid <> nil then
    FGrid.UpdateInplaceEditState;

  if ((not valid) or (descr <> descrBetter)) and
      (not (csChooserModified in FSettings))
  then
  begin
    FreeAndNil(FChooser);
    FChooser := CreateChooser(descrBetter);
  end;
end;

procedure TLMDGridColumn.ChooserPropChanged;
begin
  Include(FSettings, csChooserModified);
end;

//== TInternalStorage ==========================================================

function TInternalStore.AppendColumn: Integer;
var
  i:   Integer;
  row: TRow;
begin
  for i := 0 to FRows.Count - 1 do
  begin
    if FRows[i] <> nil then
    begin
      row := TRow(FRows[i]);
      SetLength( row.Values, FColCount + 1 );
      row.Values[ FColCount ] := Null;
    end;
  end;

  Inc(FColCount);
  SetLength(FColIndexes, FColCount);
  FColIndexes[FColCount - 1] := FColCount - 1;

  Result := FColCount;
end;

function TInternalStore.AppendRow: Integer;
begin
  CheckSortedRows;
  Result := FRows.Add(nil);
  LMDIntArrayInsertOne(Result, Result, FSortedRows);
end;

function TInternalStore.RowCount: Integer;
begin
  Result := FRows.Count;
end;

procedure TInternalStore.CheckColIdx(ACol: Integer);
begin
  Assert(ACol >= 0);
  Assert(ACol < ColumnCount);
end;

procedure TInternalStore.CheckSortedRows;
begin
  Assert(Length(FSortedRows) = FRows.Count);
end;

procedure TInternalStore.ClearColumn(ACol: Integer);
var
  i, colI: Integer;
  row:     TRow;
begin
  colI := FColIndexes[ACol];
  for i := 0 to RowCount - 1 do
    if FRows[i] <> nil then
    begin
      row := TRow(FRows[i]);
      row.Values[colI] := Null;
    end;
end;

procedure TInternalStore.CheckRowIdx(ARow: Integer);
begin
  Assert(ARow >= 0);
  Assert(ARow < RowCount);
end;

function TInternalStore.ColumnCount: Integer;
begin
  Result := FColCount;
end;

constructor TInternalStore.Create(AGrid: TLMDCustomGrid);
begin
  Assert(AGrid <> nil);

  FGrid := AGrid;
  FRows := TObjectList.Create(True);
  SetLength(FSortedRows, 0);

  FSortKind := skNone;
  FSortCol := -1;

  FColCount := 0;
  SetLength(FColIndexes, 0);
end;

procedure TInternalStore.DeleteColumn(ACol: Integer);
var
  i, j:      Integer;
  row:       TRow;
  move:      Boolean;
  internCol: Integer;
begin
  CheckColIdx(ACol);
  Assert(FColCount = Length(FColIndexes));

  internCol := FColIndexes[ACol];

  if FColCount = 1 then
  begin
    FRows.Clear;
    SetLength(FSortedRows, 0);
  end
  else
  begin
    for i := 0 to FRows.Count - 1 do
      if FRows[i] <> nil then
      begin
        row := TRow(FRows[i]);

        for j := internCol + 1 to FColCount - 1 do
          row.Values[j - 1] := row.Values[j];

        SetLength( row.Values, FColCount - 1 );
      end;
  end;

  if FSortCol = ACol then
  begin
    FSortKind := skNone;
    FSortCol  := -1;
  end
  else if FSortCol > ACol then
    Dec(FSortCol);

  for i := 0 to FColCount - 1 do
  begin
    if FColIndexes[i] > internCol then
      Dec(FColIndexes[i]);
  end;

  move := False;
  for i := 0 to FColCount - 1 do
  begin
    if not move then
      move := (FColIndexes[i] = internCol)
    else
      FColIndexes[i - 1] := FColIndexes[i]
  end;

  Dec(FColCount);
  SetLength(FColIndexes, FColCount);
end;

procedure TInternalStore.DeleteRow(ARow: Integer; var CorrIndex: Integer);
var
  i, idx: Integer;
begin
  CheckRowIdx(ARow);
  CheckSortedRows;

  idx := FSortedRows[ARow];
  FRows.Delete(idx);
  LMDIntArrayDelete(ARow, 1, FSortedRows);

  for i := 0 to Length(FSortedRows) - 1 do
    if FSortedRows[i] > idx then
      Dec(FSortedRows[i]);

  if CorrIndex > ARow then
    Dec(CorrIndex)
  else if CorrIndex = ARow then
    CorrIndex := Min(ARow, RowCount - 1);
end;

destructor TInternalStore.Destroy;
begin
  FRows.Free;
  inherited;
end;

function TInternalStore.GetDataCell(ACol, ARow: Integer): PVariant;
var
  row: TRow;
begin
  CheckRowIdx(ARow);
  CheckColIdx(ACol);

  row := TRow(FRows[ FSortedRows[ARow] ]);

  if row = nil then
    Result := @NullVariant
  else
    Result := @row.Values[ FColIndexes[ACol] ];
end;

procedure TInternalStore.InsertRow(ADest: Integer);
var
  idx: Integer;
begin
  if ADest <> RowCount then
    CheckRowIdx(ADest);

  CheckSortedRows;
  idx := FRows.Add(nil);
  LMDIntArrayInsertOne(ADest, idx, FSortedRows);
end;

procedure TInternalStore.MoveColumn(ASrc, ADest: Integer);
begin
  CheckColIdx(ASrc);
  CheckColIdx(ADest);

  if ASrc = ADest then
    Exit;

  if FSortCol = ASrc then
    FSortCol := ADest
  else if (ASrc < ADest) and (FSortCol > ASrc) and (FSortCol < ADest) then
    Dec(FSortCol)
  else if (ASrc > ADest) and (FSortCol >= ADest) and (FSortCol < ASrc) then
    Inc(FSortCol);

  IntArrayMove(ASrc, ADest, FColIndexes);
end;

procedure TInternalStore.Sort(ACol: Integer; AKind: TLMDGridSortKind;
  var CorrIndex: Integer);
var
  internCol:  Integer;
  colObj:     TLMDGridColumn;
  comparer:   TLMDGridCompareFunc;
  i, pi:      Integer;

  function Cell(ARow: Integer): PVariant;
  var
    row: TRow;
  begin
    row := TRow(FRows[ FSortedRows[ARow] ]);

    if row <> nil then
      Result := @row.Values[internCol]
    else
      Result := @NullVariant;
  end;

  procedure SortLow(L, R: Integer; comparer: TLMDGridCompareFunc);
  var
    i, j, w: Integer;
    cellM: PVariant;
  begin
    i := L; j := R;
    cellM := Cell((L + R) div 2);

    repeat
      case FSortKind of
        skAsc:
        begin
          while comparer(Cell(i), cellM) < 0 do
            Inc(i);

          while comparer(Cell(j), cellM) > 0 do
            Dec(j);
        end;

        skDesc:
        begin
          while comparer(Cell(i), cellM) > 0 do
            Inc(i);

          while comparer(Cell(j), cellM) < 0 do
            Dec(j);
        end;

        skNone:
          Assert(False);
      end;

      if i <= j then
      begin
        if i = CorrIndex then
          CorrIndex := j
        else if j = CorrIndex then
          CorrIndex := i;

        w := FSortedRows[i];
        FSortedRows[i] := FSortedRows[j];
        FSortedRows[j] := w;

        Inc(i); Dec(j);
      end;
    until i > j;

    if L < j then
      SortLow(L, j, comparer);

    if R > i then
      SortLow(i, R, comparer);
  end;

begin
  CheckSortedRows;

  if FRows.Count = 0 then
    Exit;

  if CorrIndex <> -1 then
  begin
    CheckRowIdx(CorrIndex);
    pi := FSortedRows[CorrIndex];
  end
  else
    pi := -1;

  for i := 0 to FRows.Count - 1 do
    FSortedRows[i] := i;

  CorrIndex := pi;
  FSortKind := AKind;

  if AKind <> skNone then
  begin
    FSortCol := ACol;

    colObj := FGrid.Columns[ACol];
    if Assigned(colObj.comparer) then
      comparer := colObj.comparer
    else
      comparer := colObj.CompareColValues;

    internCol := FColIndexes[ACol];
    SortLow(0, RowCount - 1, comparer);
  end
  else
    FSortCol := -1;
end;

procedure TInternalStore.MoveRow(ASrc, ADest: Integer);
var
  dummy: Integer;
begin
  CheckRowIdx(ASrc);
  if ADest <> RowCount then
    CheckRowIdx(ADest);
  CheckSortedRows;

  if ASrc = ADest then
    Exit;

  IntArrayMove(ASrc, ADest, FSortedRows);

  dummy := -1;
  if (FSortKind <> skNone) and (FSortCol <> -1) then
    Sort(FSortCol, FSortKind, dummy);
end;

procedure TInternalStore.SetDataCell(ACol, ARow: Integer;
  Value: PVariant; ABlockSort: Boolean; out NewRow: Integer);
var
  row:        TRow;
  i:          Integer;
  colObj:     TLMDGridColumn;
  colI, rowI: Integer;

  procedure RaiseErr;
  begin
    raise ELMDGridError.Create(FErrMsg);
  end;

begin
  CheckRowIdx(ARow);
  CheckColIdx(ACol);
  CheckSortedRows;
  Assert(Value <> nil);

  colObj := FGrid.Columns[ACol];
  if (not IsVarEmpty(Value)) and (not colObj.IsValueValid(Value, @FErrMsg)) then
    RaiseErr;

  NewRow := ARow;

  rowI := FSortedRows[ARow];
  colI := FColIndexes[ACol];
  //////////

  row := TRow(FRows[rowI]);

  if row = nil then
  begin
    row := TRow.Create;

    FRows[rowI] := row;

    SetLength(row.Values, FColCount);

    for i := 0 to FColCount - 1 do
      row.Values[i] := Null;
  end;

  colObj.NormalizeValue(Value, @row.Values[colI]);

  if (FSortKind <> skNone) and (not ABlockSort) then
    Sort(FSortCol, FSortKind, NewRow);
end;

procedure TInternalStore.SetRowCount(ACount: Integer; var CorrIndex: Integer);
var
  i, cnt: Integer;
begin
  cnt := RowCount;

  if ACount > cnt then
  begin
    for i := 0 to ACount - cnt - 1 do
      AppendRow;
    Sort(FSortCol, FSortKind, CorrIndex);
  end
  else
  begin
    for i := 0 to cnt - ACount - 1 do
      DeleteRow(RowCount - 1, CorrIndex);
  end;
end;

procedure TInternalStore.Sort(var CorrIndex: Integer);
begin
  if (FSortKind <> skNone) and (FSortCol <> -1) then
    Sort(FSortCol, FSortKind, CorrIndex);
end;

procedure TLMDGridColumn.SetChooserByDescr(const ADescr: TLMDGridChooserDescr);
var
  dsc: TLMDGridChooserDescr;
begin
  if FChooser <> nil then
    dsc := TLMDGridColumnChooser.GetRegisteredChooserClass(FChooser.ClassType)
  else
    dsc := nil;

  if dsc = ADescr then
    Exit;

  if not (csLoading in ComponentState) then
    CheckChooserDsc(ADescr);

  FreeAndNil(FChooser);
  FChooser := CreateChooser(ADescr);
  ChooserPropChanged;
  CheckColumnDataTypeChange;
end;

function TLMDGridColumn.GetChooserClass: TClass;
begin
  Result := Chooser.ClassType;
end;

function TLMDGridColumn.GetChooserName: string;
begin
  Result := GetNameOfChooser(Chooser);
end;

procedure TLMDGridColumn.SetChooserName(Value: string);
var
  dsc: TLMDGridChooserDescr;
begin
  if (Chooser <> nil) and (GetNameOfChooser(Chooser) = Value) then
    Exit;

  dsc := TLMDGridColumnChooser.GetRegisteredChooserClass(Value);
  if dsc = nil then
    raise ELMDGridError.CreateFmt(SLMDGridCantFindChooserByName, [Value]);

  SetChooserByDescr(dsc);
end;

procedure TLMDGridColumn.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    BeginUpdate;
    if (csDesigning in ComponentState) and (FAltrernateColor = FColor) then
      FAltrernateColor := Value;
    FColor        := Value;
    FDefaultColor := False;
    EndUpdate;
  end;
end;

procedure TLMDGridColumn.Loaded;
begin
  inherited;
  if not FDefaultColor and not FAltrernateLoaded then
    FAltrernateColor := FColor;
  if FChooser = nil then
    FChooser := CreateDefChooser;
end;

function TLMDGridColumn.CreateDefChooser: TLMDGridColumnChooser;
var
  descr: TLMDGridChooserDescr;
begin
  descr := GetDefaultChooserDescr;
  Assert(descr <> nil);
  Result := CreateChooser(descr);
end;

//== TLMDGridTextColumn ========================================================

function TLMDGridTextColumn.VarToStr(const V: Variant): TLMDString;
begin
  Result := V;
end;

function TLMDGridTextColumn.CompareColValues(Val1: PVariant;
  Val2: PVariant): Integer;
var
  s1, s2: TLMDString;
begin
  if not IsVarEmpty(Val1) then
    s1 := VarToStr(Val1^);

  if not IsVarEmpty(Val2) then
    s2 := VarToStr(Val2^);

  Result := LMDCompareStr(s1, s2);
end;

constructor TLMDGridTextColumn.Create(AOwner: TComponent);
begin
  FDefaultDataType := ftString;
  FMask := '';
  FMaskedTextReturnKind := rmMaskedTrim;
  FFormatPaintByMask := False;
  FWordWrap := True;

  inherited;

  FEditor := TEmbeddedText.Create(Self, FMaskedTextReturnKind);
  InitEditor;
end;

function TLMDGridTextColumn.FormatEditorData(const AGridData: Variant): Variant;
var
  s:      TLMDString;
  isNull: Boolean;
begin
  isNull := IsVarEmpty(@AGridData);
  if isNull then
    s := ''
  else
    s := AGridData;

  if Assigned(FOnFormatEdit) then
    FOnFormatEdit(Grid, Self, AGridData, isNull, s);

  if isNull then
    Result := Null
  else
    Result := s;
end;

function TLMDGridTextColumn.FormatPaintData(const AGridData: Variant): Variant;
var
  s:      TLMDString;
  isNull: Boolean;
begin
  isNull := IsVarEmpty(@AGridData);
  if isNull then
    s := ''
  else if FFormatPaintByMask then
  begin
    s := AGridData;
    s := (FEditor as TEmbeddedText).FormatTextByMask(s);
  end
  else
    s := AGridData;

  if Assigned(FOnFormatPaint) then
    FOnFormatPaint(Grid, Self, AGridData, isNull, s);

  Result := s;
end;

function TLMDGridTextColumn.GetEmbeddedEditor: ILMDGridEmbeddedEdit;
begin
  Result := FEditor as TEmbeddedText;
end;

function TLMDGridTextColumn.GetMask: TEditMask;
var
  f: TField;
begin
  f := nil;
  if Grid <> nil then
    f := Grid.GetColumnField(Self);

  if (not IsMaskStored) and (f <> nil) then
    Result := f.EditMask
  else
    Result := FMask;
end;

procedure TLMDGridTextColumn.InitEditor;
var
  ed:   TEmbeddedText;
  mask: TLMDString;
begin
  ed   := GetTextEditor(Self);
  mask := Self.GetMask;

  if mask = '' then
  begin
    ed.MaskType := meNone;
    ed.mask     := '';
  end
  else
  begin
    ed.MaskType := meMask;
    ed.mask     := convertVCLMask2LMDMask(mask);
  end;
end;

function TLMDGridTextColumn.IsMaskStored: Boolean;
begin
  Result := csMask in FSettings;
end;

procedure TLMDGridTextColumn.NormalizeValue(ASrcValue, ADestValue: PVariant);
var
  s: TLMDString;
begin
  if IsVarEmpty(ASrcValue) then
    ADestValue^ := ASrcValue^
  else
  begin
    s := ASrcValue^;
    ADestValue^ := s;
  end;
end;

procedure TLMDGridTextColumn.PaintFormattedCellData(ACanvas: TCanvas;
  ARect: TRect; const AData: Variant; AAlignment: TAlignment;
  ACellState: TLMDGridCellStates);
var
  s: TLMDString;
begin
  if IsVarEmpty(@AData) then
    s := ''
  else
    s := AData;

  DefTextOut(ACanvas, ARect, s, AAlignment, FWordWrap, True,
             ACellState, Grid.Style);
end;

function TLMDGridTextColumn.ParseEditorData(const AEditData: Variant;
  ARaiseError: Boolean; PErrMsg: PLMDString; var Res: Variant): Boolean;
var
  s:      TLMDString;
  isNull: Boolean;
begin
  Result := inherited ParseEditorData(AEditData, ARaiseError, PErrMsg, Res);
  if Assigned(FOnParse) then
  begin
    isNull := IsVarEmpty(@AEditData);
    if isNull then
      s := ''
    else
      s := AEditData;

    FOnParse(Grid, Self, s, Res, isNull, Result, PErrMsg, ARaiseError);
  end;
end;

procedure TLMDGridTextColumn.ResetEmbeddedEditor;
begin
  DetachEmbeddedEditor;
  FEditor.Free;
  FEditor := TEmbeddedText.Create(Self, FMaskedTextReturnKind);
  InitEditor;
end;

procedure TLMDGridTextColumn.SetFormatPaintByMask(const Value: Boolean);
begin
  if FFormatPaintByMask = Value then
    Exit;

  BeginUpdate;
  FFormatPaintByMask := Value;
  EndUpdate;
end;

procedure TLMDGridTextColumn.SetMask(const Value: TEditMask);
begin
  if Value = GetMask then
    Exit;

  BeginUpdate;
  try
    FMask := Value;
    Include(FSettings, csMask);

    InitEditor;
  finally
    EndUpdate;
  end;
end;

procedure TLMDGridTextColumn.SetWordWrap(const Value: Boolean);
begin
  if FWordWrap = Value then
    Exit;

  BeginUpdate;
  FWordWrap := Value;
  EndUpdate;
end;

//== TLMDGridColumns ===========================================================

procedure TLMDGridColumns.Add(ACol: TLMDGridColumn);
begin
  if ACol = nil then
    raise ELMDGridError.CreateFmt(SLMDGridNilArgument, ['ACol']);

  ACol.Grid := FGrid;
end;

procedure TLMDGridColumns.AddColLow(ACol: TLMDGridColumn);
begin
  FCols.Add(ACol);
  ACol.FPosition := FCols.Count - 1;
end;

procedure TLMDGridColumns.Clear;
begin
  FGrid.ClearColumns;
end;

constructor TLMDGridColumns.Create(AGrid: TLMDCustomGrid);
begin
  if AGrid = nil then
    raise ELMDGridError.Create(SLMDGridParentGridIsNil);

  AGrid.CheckColumnsNotSet;
  FCols := TObjectList.Create(False);
  FGrid := AGrid;
end;

destructor TLMDGridColumns.Destroy;
begin
  FCols.Free;
  inherited;
end;

function TLMDGridColumns.GetCount: Integer;
begin
  Result := FCols.Count;
end;

function TLMDGridColumns.GetItem(AIndex: Integer): TLMDGridColumn;
begin
  FGrid.CheckColumnIdx(AIndex);

  Result := FCols[AIndex] as TLMDGridColumn;
end;

function TLMDGridColumns.HaveCol(ACol: TLMDGridColumn): Boolean;
begin
  Result := FCols.IndexOf(ACol) <> -1;
end;

procedure TLMDGridColumns.Remove(ACol: TLMDGridColumn);
begin
  if ACol = nil then
    raise ELMDGridError.CreateFmt(SLMDGridNilArgument, ['ACol']);
  ACol.Grid := nil;
end;

procedure TLMDGridColumns.RemoveColLow(ACol: TLMDGridColumn);
begin
  FCols.Remove(ACol);
  UpdateColPositions;
end;

procedure TLMDGridColumns.UpdateColPositions;
var
    i: Integer;
begin
  for i := 0 to Count - 1 do
    (FCols[i] as TLMDGridColumn).FPosition := i;
end;

//== TLMDGridIntegerColumn =====================================================

function GetSpinEditor(ACol: TLMDGridIntegerColumn): TEmbeddedSpin;
begin
  Result := ACol.FEditor as TEmbeddedSpin;
end;

function TLMDGridIntegerColumn.VarToIntDef(V: PVariant): Integer;
begin
  if not IsVarEmpty(V) then
    Result := V^
  else
    Result := -MaxInt div 2;
end;

function TLMDGridIntegerColumn.CompareColValues(Val1: PVariant;
  Val2: PVariant): Integer;
begin
  Result := VarToIntDef(Val1) - VarToIntDef(Val2);
end;

procedure TLMDGridIntegerColumn.InitEditor;
var
  ed: TEmbeddedSpin;
begin
  ed := GetSpinEditor(Self);

  ed.LineSize := Step;
  ed.PageSize := LargeStep;
  ed.MinValue := MinValue;
  ed.MaxValue := MaxValue;
  ed.SetShowButtons(FShowButtons);
end;

function TLMDGridIntegerColumn.IsValueStored(const Index: Integer): Boolean;
var
  cs: TLMDColSetting;
begin
  cs := TLMDColSetting(-1);
  case Index of
    2: cs := csMinValue;
    3: cs := csMaxValue;
  end;

  Result := cs in FSettings;
end;

procedure TLMDGridIntegerColumn.NormalizeValue(ASrcValue, ADestValue: PVariant);
var
  i: Integer;
begin
  if IsVarEmpty(ASrcValue) then
    ADestValue^ := ASrcValue^
  else
  begin
    i           := ASrcValue^;
    ADestValue^ := i;
  end;
end;

procedure TLMDGridIntegerColumn.PaintFormattedCellData(ACanvas: TCanvas;
  ARect: TRect; const AData: Variant; AAlignment: TAlignment;
  ACellState: TLMDGridCellStates);
var
  s: TLMDString;
begin
  if not IsVarEmpty(@AData) then
    s := AData
  else
    s := '';
  DefTextOut(ACanvas, ARect, s, AAlignment, False, False,
             ACellState, Grid.Style);
end;

function TLMDGridIntegerColumn.ParseEditorData(const AEditData: Variant;
  ARaiseError: Boolean; PErrMsg: PLMDString; var Res: Variant): Boolean;
var
  s: string;
  i: Integer;
begin
  if IsVarEmpty(@AEditData) then
  begin
    Result := True;
    Res    := Null;
  end
  else
  begin
    s      := AEditData;
    Result := TryStrToInt(s, i);

    if Result then
      Res := i
    else if ARaiseError then
      raise ELMDGridError.CreateFmt(SLMDGridIntegerValueRequired, [s])
    else
    begin
      Res := Null;
      if PErrMsg <> nil then
        PErrMsg^ := Format(SLMDGridIntegerValueRequired, [s]);
    end;
  end;
end;

procedure TLMDGridIntegerColumn.ResetEmbeddedEditor;
begin
  DetachEmbeddedEditor;
  FEditor.Free;
  FEditor := TEmbeddedSpin.Create(Self);
  InitEditor;
end;

procedure TLMDGridIntegerColumn.SetInteger(const Index, Value: Integer);
begin
  if Value = GetInteger(Index) then
    Exit;

  case Index of
    0:  FStep := Value;
    1:  FLargeStep := Value;
    2:  begin
          FMinValue := Value;
          Include(FSettings, csMinValue);
        end;
    3:  begin
          FMaxValue := Value;
          Include(FSettings, csMaxValue);
        end;
  else
    Assert(False);
  end;

  InitEditor;
end;

procedure TLMDGridIntegerColumn.SetShowButtons(const Value: Boolean);
begin
  BeginUpdate;
  FShowButtons := Value;
  EndUpdate;
end;

constructor TLMDGridIntegerColumn.Create(AOwner: TComponent);
begin
  FDefaultDataType := ftInteger;
  inherited;

  FStep        := 1;
  FLargeStep   := 10;
  FMinValue    := 0;
  FMaxValue    := 100;
  FShowButtons := True;
  FEditor      := TEmbeddedSpin.Create(Self);
  InitEditor;
end;

function TLMDGridIntegerColumn.GetEmbeddedEditor: ILMDGridEmbeddedEdit;
begin
  Result := FEditor as TEmbeddedSpin;
end;

function TLMDGridIntegerColumn.GetField: TIntegerField;
var
  f:  TIntegerField;
  fo: TField;
begin
  f := nil;
  if Grid <> nil then
  begin
    fo := Grid.GetColumnField(Self);
    if (fo <> nil) and (fo is TIntegerField) then
      f := fo as TIntegerField;
  end;

  Result := f;
end;

function TLMDGridIntegerColumn.GetInteger(const Index: Integer): Integer;
var
  f: TIntegerField;
begin
  f := GetField;

  Result := -1;
  if (not IsValueStored(Index)) and (f <> nil) then
  begin
    case Index of
      0: Result := FStep;
      1: Result := FLargeStep;
      2:
      begin
        if f.MinValue <> 0 then
         Result := f.MinValue
        else
         Result := -MAXINT;
      end;

      3:
      begin
        if f.MaxValue <> 0 then
         Result := f.MaxValue
        else
         Result := MAXINT;
      end
    else
      Assert(False);
    end;
  end
  else
  begin
    case Index of
      0: Result := FStep;
      1: Result := FLargeStep;
      2: Result := FMinValue;
      3: Result := FMaxValue;
    else
      Assert(False);
    end;
  end;
end;

//== TLMDGridColumnTitle =======================================================

constructor TLMDGridColumnTitle.Create(AColumn: TLMDGridColumn);
begin
  FSettings := [];

  FFont := TFont.Create;
  FFont.OnChange := OnFontChange;

  FCaption := '';

  FAlignment := AColumn.Alignment;
  FVertAlign := AColumn.VertAlignment;

  FColumn := AColumn;
end;

destructor TLMDGridColumnTitle.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TLMDGridColumnTitle.Assign(Source: TPersistent);
var
  title: TLMDGridColumnTitle;
begin
  if Source = Self then
    Exit;

  if Source is TLMDGridColumnTitle then
  begin
    FColumn.BeginUpdate;
    try
      title := Source as TLMDGridColumnTitle;

      if csCaption in title.FSettings then
        Caption := title.Caption;

      if csAlignment in title.FSettings then
        Alignment := title.Alignment;

      if csAlignmentV in title.FSettings then
        VertAlignment := title.VertAlignment;

      if csFont in title.FSettings then
        Font := title.Font;
    finally
      FColumn.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TLMDGridColumnTitle.IsAlignmentStored: Boolean;
begin
  Result := csAlignment in FSettings;
end;

function TLMDGridColumnTitle.IsAlignmentVStored: Boolean;
begin
  Result := csAlignmentV in FSettings;
end;

function TLMDGridColumnTitle.IsCaptionStored: Boolean;
begin
  Result := csCaption in FSettings;
end;

function TLMDGridColumnTitle.IsFontStored: Boolean;
begin
  Result := csFont in FSettings;
end;

procedure TLMDGridColumnTitle.SetAlignment(const Value: TAlignment);
begin
  if Alignment = Value then
    Exit;

  FColumn.BeginUpdate;
  try
    Include(FSettings, csAlignment);
    FAlignment := Value;
  finally
    FColumn.EndUpdate;
  end;
end;

procedure TLMDGridColumnTitle.SetCaption(const Value: TLMDString);
begin
  if Caption = Value then
    Exit;

  FColumn.BeginUpdate;
  try
    Include(FSettings, csCaption);
    FCaption := Value;
  finally
    FColumn.EndUpdate;
  end;
end;

procedure TLMDGridColumnTitle.SetFont(const Value: TFont);
begin
  if Font = Value then
    Exit;

  FColumn.BeginUpdate;
  try
    FFont.Assign(Value);
  finally
    FColumn.EndUpdate;
  end;
end;

procedure TLMDGridColumnTitle.SetVertAlign(const Value: TVerticalAlignment);
begin
  if VertAlignment = Value then
    Exit;

  FColumn.BeginUpdate;
  try
    Include(FSettings, csAlignmentV);
    FVertAlign := Value;
  finally
    FColumn.EndUpdate;
  end;
end;

procedure TLMDGridColumnTitle.OnFontChange(ASender: TObject);
begin
  Include(FSettings, csFont);
  FColumn.BeginUpdate;
  FColumn.EndUpdate;
end;

procedure TLMDGridColumnTitle.RefreshDefaultFont;
var
  save: TNotifyEvent;
begin
  if (csFont in FSettings) then
    Exit;

  save := FFont.OnChange;
  FFont.OnChange := nil;
  try
    FFont.Assign(FColumn.Font);
  finally
    FFont.OnChange := save;
  end;
end;

function TLMDGridColumnTitle.GetCaption: TLMDString;
begin
  if csCaption in FSettings then
    Result := FCaption
  else if FColumn.Grid <> nil then
    Result := FColumn.Grid.GetDefaultColumnCaption(FColumn);
end;

function TLMDGridColumnTitle.GetFont: TFont;
var
  save: TNotifyEvent;
  def:  TFont;
begin
  if not (csFont in FSettings) then
  begin
    def := FColumn.Font;
    if (FFont.Handle <> def.Handle) or (FFont.Color <> def.Color) then
    begin
      save := FFont.OnChange;
      FFont.OnChange := nil;
      FFont.Assign(def);
      FFont.OnChange := save;
    end;
  end;
  Result := FFont;
end;

function TLMDGridColumnTitle.GetVertAlign: TVerticalAlignment;
begin
  if csAlignmentV in FSettings then
    Result := FVertAlign
  else
    Result := FColumn.VertAlignment;
end;

function TLMDGridColumnTitle.GetAlignment: TAlignment;
begin
  if csAlignment in FSettings then
    Result := FAlignment
  else
    Result := FColumn.Alignment;
end;

//== TLMDGridDateColumn ========================================================

function TLMDGridDateColumn.CompareColValues(Val1, Val2: PVariant): Integer;
var
  diff: TDateTime;
begin
  diff := VarToDateDef(Val1) - VarToDateDef(Val2);

  if Abs(diff) < DATE_COMPARE_EPS then
    Result := 0
  else if diff > 0 then
    Result := 1
  else
    Result := -1;
end;

constructor TLMDGridDateColumn.Create(AOwner: TComponent);
begin
  FDefaultDataType := ftDateTime;
  inherited;

  FDateFormat := '';
  FEditor     := TEmbeddedText.Create(Self, rmMaskedTrim);
  InitEditor;
end;

function TLMDGridDateColumn.FormatEditorData(const AGridData: Variant): Variant;
var
  s:      TLMDString;
  isNull: Boolean;
begin
  FormatGen(AGridData, s, isNull);

  if Assigned(FOnFormatEdit) then
    FOnFormatEdit(Grid, Self, AGridData, isNull, s);

  if isNull then
    Result := ''
  else
    Result := s;
end;

procedure TLMDGridDateColumn.FormatGen(const AGridData: Variant;
  var Res: TLMDString; var IsNull: Boolean);
var
  dt: TDateTime;
  ts: TTimeStamp;
  tz: TTimeStamp;
  dz: TDateTime;
begin
  IsNull := IsVarEmpty(@AGridData);
  if IsNull then
    Res := ''
  else
  begin
    dt := AGridData;
    if FDateFormat = '' then
    begin
      dz := Time;
      ts := DateTimeToTimeStamp(dt);
      tz := DateTimeToTimeStamp(dz);

      if ts.Date = tz.Date then
        Res := FormatDateTime('hh:mm', dt)
      else if ts.Time = 0 then
        Res := DateToStr(dt)
      else
        Res := FormatDateTime('ddddd hh:mm', dt);
    end
    else
      Res := FormatDateTime(FDateFormat, dt);
  end;
end;

function TLMDGridDateColumn.FormatPaintData(const AGridData: Variant): Variant;
var
  s:      TLMDString;
  isNull: Boolean;
begin
  FormatGen(AGridData, s, isNull);

  if Assigned(FOnFormatPaint) then
    FOnFormatPaint(Grid, Self, AGridData, isNull, s);

  if isNull then
    Result := ''
  else
    Result := s;
end;

function TLMDGridDateColumn.GetEmbeddedEditor: ILMDGridEmbeddedEdit;
begin
  Result := FEditor as TEmbeddedText;
end;

procedure TLMDGridDateColumn.InitEditor;
var
  ed: TEmbeddedText;
begin
  ed := GetTextEditor(Self);
  ed.MaskType := meNone;
  ed.Mask := '';
end;

procedure TLMDGridDateColumn.NormalizeValue(ASrcValue, ADestValue: PVariant);
var
  d: TDateTime;
begin
  if IsVarEmpty(ASrcValue) then
    ADestValue^ := ASrcValue^
  else
  begin
    d := ASrcValue^;
    ADestValue^ := d;
  end;
end;

procedure TLMDGridDateColumn.PaintFormattedCellData(ACanvas: TCanvas;
  ARect: TRect; const AData: Variant; AAlignment: TAlignment;
  ACellState: TLMDGridCellStates);
var
  s: TLMDString;
begin
  if IsVarEmpty(@AData) then
    s := ''
  else
    s := AData;

  DefTextOut(ACanvas, ARect, s, AAlignment, False, False,
             ACellState, Grid.Style);
end;

function TLMDGridDateColumn.ParseEditorData(const AEditData: Variant;
  ARaiseError: Boolean; PErrMsg: PLMDString; var Res: Variant): Boolean;
var
  s:      TLMDString;
  dt:     TDateTime;
  isNull: Boolean;
begin
  isNull := IsVarEmpty(@AEditData);
  if isNull then
  begin
    Result := True;
    s := '';
    Res := Null
  end
  else
  begin
    s := AEditData;
    if s = '' then
    begin
      Result := True;
      Res := Null;
    end
    else
    begin
      Result := TryStrToDateTime(s, dt);
      if Result then
        Res := dt
      else
        Res := Null;
    end;
  end;

  if Assigned(FOnParse) then
    FOnParse(Grid, Self, s, Res, isNull, Result, PErrMsg, ARaiseError);

  if not Result then
  begin
    if ARaiseError then
      raise ELMDGridError.CreateFmt(SLMDGridDateTimeValueRequired, [s])
    else if PErrMsg <> nil then
      PErrMsg^ := Format(SLMDGridDateTimeValueRequired, [s]);
  end;
end;

procedure TLMDGridDateColumn.ResetEmbeddedEditor;
begin
  DetachEmbeddedEditor;
  FEditor.Free;
  FEditor := TEmbeddedText.Create(Self, rmMaskedTrim);
  InitEditor;
end;

procedure TLMDGridDateColumn.SetDateFormat(const Value: string);
begin
  if FDateFormat = Value then
    Exit;

  BeginUpdate;
  FDateFormat := Value;
  EndUpdate;
end;

function TLMDGridDateColumn.VarToDateDef(V: PVariant): TDateTime;
begin
  if not IsVarEmpty(V) then
    Result := V^
  else
    Result := 0;
end;

//== TLMDGridFloatColumn =======================================================

function TLMDGridFloatColumn.CompareColValues(Val1, Val2: PVariant): Integer;
var
  diff: Double;
begin
  diff := VarToFloatDef(Val1) - VarToFloatDef(Val2);
  if Abs(diff) < FLOAT_COMPARE_EPS then
    Result := 0
  else if diff > 0 then
    Result := 1
  else
    Result := -1;
end;

constructor TLMDGridFloatColumn.Create(AOwner: TComponent);
begin
  FDefaultDataType := ftFloat;
  inherited;

  FPrecision      := 5;
  FDigits         := 5;
  FIsCurrencyMode := False;
  FEditor         := TEmbeddedText.Create(Self, rmMaskedTrim);
  InitEditor;
end;

function TLMDGridFloatColumn.ParseEditorData(const AEditData: Variant;
  ARaiseError: Boolean; PErrMsg: PLMDString; var Res: Variant): Boolean;
var
  s:      TLMDString;
  d:      Currency;
  f:      Double;
  isnull: Boolean;
  fmt:    TFormatSettings;
begin
  isnull := IsVarEmpty(@AEditData);
  
  if isnull then
  begin
    Result := True;
    s      := '';
    Res    := Null
  end
  else
  begin
    s      := AEditData;
    Result := False;
    
    if IsCurrencyMode then
    begin
      GetCurrFmt(Self, fmt);
      Result := TryStrToCurr(s, d, fmt);
      if Result then
        Res := d;
    end;

    if not Result then
    begin
      Result := TryStrToFloat(s, f);
      if Result then
        Res := f
      else
        Res := Null;
    end;
  end;

  if Assigned(FOnParse) then
    FOnParse(Grid, Self, s, Res, isnull, Result, PErrMsg, ARaiseError);

  if not Result then
  begin
    if ARaiseError then
      raise ELMDGridError.CreateFmt(SLMDGridFloatValueRequired, [s])
    else if PErrMsg <> nil then
      PErrMsg^ := Format(SLMDGridFloatValueRequired, [s]);
  end;
end;

function TLMDGridFloatColumn.GetEmbeddedEditor: ILMDGridEmbeddedEdit;
begin
  Result := FEditor as TEmbeddedText;
end;

procedure TLMDGridFloatColumn.InitEditor;
begin
  GetTextEditor(Self).Mask := '';
  GetTextEditor(Self).MaskType := meNone;
end;

procedure TLMDGridFloatColumn.NormalizeValue(ASrcValue, ADestValue: PVariant);
var
  d: Double;
begin
  if IsVarEmpty(ASrcValue) then
    ADestValue^ := ASrcValue^
  else
  begin
    d := ASrcValue^;
    ADestValue^ := d;
  end;
end;

procedure TLMDGridFloatColumn.PaintFormattedCellData(ACanvas: TCanvas;
  ARect: TRect; const AData: Variant; AAlignment: TAlignment;
  ACellState: TLMDGridCellStates);
var
  s: TLMDString;
begin
  s := AData;
  DefTextOut(ACanvas, ARect, s, AAlignment, False, False,
             ACellState, Grid.Style);
end;

procedure TLMDGridFloatColumn.ResetEmbeddedEditor;
begin
  DetachEmbeddedEditor;
  FEditor.Free;
  FEditor := TEmbeddedText.Create(Self, rmMaskedTrim);
  InitEditor;
end;

procedure TLMDGridFloatColumn.SetIsCurrencyMode(const Value: Boolean);
begin
  if FIsCurrencyMode = Value then
    Exit;

  BeginUpdate;
  FIsCurrencyMode := Value;
  EndUpdate;
end;

procedure TLMDGridFloatColumn.SetCurrencyString(const Value: string);
begin
  if FCurrencyString = Value then
    Exit;

  BeginUpdate;
  FCurrencyString := Value;
  EndUpdate;
end;

procedure TLMDGridFloatColumn.SetDigits(Value: Integer);
begin
  if FDigits = Value then
    Exit;

  BeginUpdate;
  FDigits := Value;
  EndUpdate;
end;

function TLMDGridFloatColumn.FormatEditorData(const AGridData: Variant): Variant;
var
  s:      TLMDString;
  isNull: Boolean;
begin
  FormatGen(AGridData, s, isNull, True);

  if Assigned(FOnFormatEdit) then
    FOnFormatEdit(Grid, Self, AGridData, isNull, s);

  if isNull then
    Result := ''
  else
    Result := s;
end;

procedure TLMDGridFloatColumn.FormatGen(const AGridData: Variant;
  var Res: TLMDString; var IsNull: Boolean; AForEdit: Boolean);
var
  d:    Currency;
  f:    Double;
  fmt:  TFormatSettings;
  curr: Boolean;
begin
  IsNull := IsVarEmpty(@AGridData);

  if not IsNull then
  begin
    f := AGridData;
    curr := (not AForEdit) and FIsCurrencyMode and TryFloatToCurr(f, d);
  end
  else
  begin
    curr := False;
    f := 0;
  end;

  if IsNull then
    Res := ''
  else if curr then
  begin
    GetCurrFmt(Self, fmt);

    if FFloatFormat = '' then
      Res := FloatToStrF(d, ffCurrency, FPrecision, FDigits, fmt)
    else
      Res := FormatCurr(FFloatFormat, d, fmt);
  end
  else
  begin
    if FFloatFormat = '' then
      Res := SysUtils.FloatToStrF(f, ffGeneral, FPrecision, FDigits)
    else
      Res := FormatFloat(FFloatFormat, AGridData);
  end;
end;

function TLMDGridFloatColumn.FormatPaintData(const AGridData: Variant): Variant;
var
  s:      TLMDString;
  isNull: Boolean;
begin
  FormatGen(AGridData, s, isNull, False);

  if Assigned(FOnFormatPaint) then
    FOnFormatPaint(Grid, Self, AGridData, isNull, s);

  if isNull then
    Result := ''
  else
    Result := s;
end;

procedure TLMDGridFloatColumn.SetPrecision(Value: Integer);
begin
  if FPrecision = Value then
    Exit;

  BeginUpdate;
  FPrecision := Value;
  EndUpdate;
end;

function TLMDGridFloatColumn.VarToFloatDef(V: PVariant): Double;
begin
  if not IsVarEmpty(V) then
    Result := V^
  else
    Result := 0;
end;

procedure TLMDGridFloatColumn.CheckInitPropsForField;
var
  field: TField;
  ff:    TFloatField;
begin
  Assert(Grid <> nil);

  field := Grid.GetColumnField(Self);
  if (field <> nil) and (field is TFloatField) then
  begin
    ff := TFloatField(field);
    Precision := ff.Precision;
    IsCurrencyMode := ff.Currency;
    FloatFormat := ff.EditFormat;
  end;
end;

procedure TLMDGridFloatColumn.SetFloatFormat(const Value: string);
begin
  if FFloatFormat = Value then
    Exit;
  BeginUpdate;
  FFloatFormat := Value;
  EndUpdate;
end;

//== TEditPanel ================================================================

procedure TEditPanel.AlignControls(AControl: TControl; var ARect: TRect);
var
  edit:                                   TControl;
  l, r, t, b, w, h, contrW, contrH:       Integer;
  chooserW:                               Integer;
  editL, editT, editB, editW, scrW, scrH: Integer;
  dl, dr, dt, db:                         Integer;
  dls, drs, dts, dbs:                     Integer;
  contrRect:                              TRect;
begin
  if FInitMode or (FEdit = nil) then
    Exit;

  { Adjust edit position }

  edit := FEdit.AsControl;
  if (FChooser <> nil) and FChooserButton.Visible then
    chooserW := CHOOSER_BTNWIDTH
  else
    chooserW := 0;

  w := (ARect.Right - ARect.Left) - chooserW;
  h := (ARect.Bottom - ARect.Top);
  l := ARect.Left;
  t := ARect.Top;

  edit.SetBounds(l, t, w, h);

  editL := l;
  editW := w;
  editT := t;
  editB := t + h;

  { Adjust chooser button position }

  if chooserW <> 0 then
  begin
    r := l + w;
    w := chooserW;
    h := ARect.Bottom - ARect.Top;
    l := r;
    t := ARect.Top;

    FChooserButton.SetBounds(l, t, w, h);
  end;

  { Adjust popup panel position }

  scrW := Screen.Width;
  scrH := Screen.Height;

  if (FChooser <> nil) and (FChooser.GetChooserKind = ckControl) and
     FPopupPanel.Visible then
  begin
    contrW := FPopupPanel.Width;
    contrH := FPopupPanel.Height;

    case FChooser.GetLayout of
      clUnderEdit:
      begin
        l := editL + Self.Left;
        w := editW + chooserW;
      end;
      clUnderCell:
      begin
        r   := Self.Left + contrW;
        drs := scrW - FGrid.ClientToScreen(Point(r, 0)).X;
        l   := Self.Left + Self.Width - contrW;
        dls := FGrid.ClientToScreen(Point(l, 0)).X;
        dr  := FGrid.Width - r;
        dl  := l;

        if ((drs > 0) and (dls < 0)) or (dr > dl) then
          l := Self.Left;
        w := contrW;
      end;
    else
      Assert(False);
    end;

    b   := Self.Top + Self.Height + contrH;
    dbs := scrH - FGrid.ClientToScreen(Point(0, b)).Y;
    t   := Self.Top + editT - contrH;
    dts := FGrid.ClientToScreen(Point(0, t)).Y;
    db  := FGrid.Height - b;
    dt  := t;

    if ((dbs > 0) and (dts < 0)) or (db > dt) then
      t := Self.Top + editB;

    h         := contrH;
    contrRect := Rect(l, t, l, t);
    contrRect := GridToScreen(contrRect);

    with contrRect do
    begin
      if FChooser.CanResize then
        FPopupPanel.SetBounds(Left, Top, w, h)
      else
        FPopupPanel.SetBounds(Left, Top, contrW, contrH);
    end;
  end;
end;

procedure TEditPanel.AssignEditProps;
var
  ro:             Boolean;
  bmp, styledBmp: TBitmap;
  imgs:           TImageList;
  descr:          TLMDGridChooserDescr;
begin
  Assert(FEdit <> nil);

  styledBmp := nil;
  ro := not FColumn.CanEdit;

  FEdit.SetGrid(FGrid.FEditHelper);
  FEdit.AsControl.Visible := True;
  FEdit.AsControl.Parent := Self;
  FEdit.SetReadOnly(ro);
  FEdit.SetThemeMode(FGrid.ThemeMode, FGrid.ThemeGlobalMode);

  FChooserButton.Parent := Self;
  FChooserButton.Visible := FChooser.Enabled and (not ro);

  bmp := FChooser.ButtonImage;
  try
    TChooserButton(FChooserButton).Style := bsBitmap;
    if bmp.Empty then
    begin
      descr := TLMDGridColumnChooser.GetRegisteredChooserClass(FChooser.ClassType);

      if descr.Image <> nil then
        bmp := descr.Image
      else
        bmp := FGrid.Style.ChooserButtonImg;

      if bmp.Empty then
      begin
        styledBmp := TBitmap.Create;
        bmp := styledBmp;
        bmp.Width := LMDGridImagesForm.ChooserImages.Width;
        bmp.Height := LMDGridImagesForm.ChooserImages.Height;

        TChooserButton(FChooserButton).ThemeMode := FGrid.UseThemeMode;
        TChooserButton(FChooserButton).Style := descr.PaintStyle;
      end;
    end;

    FChooserButton.Glyph.Height := 0;
    FChooserButton.Glyph.Width := 0;

    if not bmp.Empty then
      FChooserButton.Glyph := bmp
    else
    begin
      imgs := LMDGridImagesForm.ChooserImages;
      imgs.GetBitmap(0, FChooserButton.Glyph);
    end;
  finally
    styledBmp.Free;
  end;
end;

procedure TEditPanel.OnChooserCancel(Sender: TObject);
begin
  HideChooser(False, True);
end;

procedure TEditPanel.CancelMode(ASender: TControl);
begin
  Assert(FEdit <> nil);
  FEdit.AsControl.Perform(CM_CANCELMODE, 0, 0);

  if ChooserChown and (ASender <> FChooserButton) then
    HideChooser(False, True);
end;

constructor TEditPanel.Create(AGrid: TLMDCustomGrid);
begin
  Assert(AGrid <> nil);

  inherited Create(nil);

  ControlStyle := ControlStyle - [csAcceptsControls];
  Caption := '';
  BevelOuter := Low(TBevelCut);
  FGrid := AGrid;
  Visible := False;

  Parent := FGrid;
  FEdit := nil;

  FChooserShown := False;
  FPopupPanel := nil;
  FInitMode := False;
  FColumn := nil;

  FInShowMethod := False;

  FChooserButton := TChooserButton.Create(nil);
  FChooserButton.Parent := Self;
  FChooserButton.OnMouseDown := OnChooserBtnMouseDown;
end;

destructor TEditPanel.Destroy;
begin
  FChooserButton.Free;
  FPopupPanel.Free;

  inherited;
end;

procedure TEditPanel.GetData(var AKey: Variant; var AValue: Variant);
var
  k, v: Variant;
begin
  Assert(FEdit <> nil);

  FEdit.GetData(k, v);
  FColumn.ParseEditorData(v, True, nil, AValue);
  AKey := k;
end;

function TEditPanel.GridToScreen(ARect: TRect): TRect;
var
  p1, p2: TPoint;
begin
  Assert(FGrid <> nil);

  p1 := FGrid.ClientToScreen(ARect.TopLeft);
  p2 := FGrid.ClientToScreen(ARect.BottomRight);

  Result := Rect(p1, p2);
end;

function TEditPanel.ReadOnly: Boolean;
begin
  Assert(FEdit <> nil);
  Result := FEdit.GetReadOnly;
end;

procedure TEditPanel.Refocus;
begin
  if FGrid.Focused then
  begin
    if FEdit <> nil then
      Windows.SetFocus(FEdit.AsControl.Handle);
    if GetParentForm(FGrid) <> nil then
      GetParentForm(FGrid).SetFocusedControl(FGrid);
  end;
end;

procedure TEditPanel.Hide;
begin
  Assert(FColumn <> nil);

  HideChooser(False, True);
  Visible := False;
  SetColumn(nil);
end;

procedure TEditPanel.OnChooserBtnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  wprm: DWORD;
begin
  if FChooserShown then
    HideChooser(True, True)
  else
    ShowChooser;

  wprm := MakeWParam(FChooserButton.Left + 5, FChooserButton.Top + 5);
  PostMessage(Handle, WM_LBUTTONUP, 0, wprm);
end;

procedure TEditPanel.OnChooserOk(Sender: TObject);
begin
  FGrid.ED_EditorChanged;
  HideChooser(True, True);
end;

function TEditPanel.OwnsHandle(AHandle: THandle): Boolean;
begin
  Assert(Visible);
  Result := (FEdit <> nil) and (AHandle = FEdit.AsControl.Handle);
end;

procedure TEditPanel.Paint;
var
  r, rt, rp: TRect;
  col, row:  Integer;
  colObj:    TLMDGridColumn;
begin
  r      := ClientRect;
  rp     := Rect(0, 0, 0, 0);
  col    := FGrid.CurrentColumn;
  row    := FGrid.CurrentRow;
  colObj := FGrid.Columns[col];

  colObj.PaintCellBG(Canvas, row, r, [], False, rp, rt);
end;

procedure TEditPanel.SetColumn(AColumn: TLMDGridColumn);
var
  btns:             TMsgDlgButtons;
  okEvt, cancelEvt: TNotifyEvent;
begin
  if AColumn = FColumn then
    Exit;

  FInitMode := True;
  try
    FChooserShown := False;
    FColumn       := AColumn;

    if FColumn = nil then
    begin
      FEdit.AsControl.Visible := False;
      FEdit := nil;

      if FChooser <> nil then
        FChooser.SetControlParent(nil);

      FChooser := nil;
      FChooserButton.Parent := nil;

      FreeAndNil(FPopupPanel);
    end
    else
    begin
      Assert(FEdit = nil);

      FColumn.ResetEmbeddedEditor;

      FChooser := FColumn.Chooser;
      FEdit    := FColumn.GetEmbeddedEditor;

      Assert(FEdit <> nil);
      Assert(FChooser <> nil);

      if FChooser.NeedOkButton then
      begin
        okEvt := OnChooserOk;
        cancelEvt := OnChooserCancel;

        btns := [mbOk, mbCancel];
      end
      else
      begin
        okEvt := nil;
        cancelEvt := nil;

        btns := [];
      end;

      FPopupPanel         := TPopupPanel.Create(Owner, Self, btns,
                                                okEvt, cancelEvt);
      FPopupPanel.Visible := False;
      FPopupPanel.Parent  := Self;

      if FChooser.GetChooserKind = ckControl then
        FChooser.SetControlParent(FPopupPanel);

      AssignEditProps;
    end;
  finally
    FInitMode := False;
  end;
end;

procedure TEditPanel.SetData(const AKey: Variant; const AValue: Variant;
  AInitValue: Boolean);
var
    V: Variant;
begin
  Assert(FColumn <> nil);
  Assert(FEdit <> nil);

  V := FColumn.FormatEditorData(AValue);
  FEdit.SetData(AKey, V, AInitValue);

  if FChooser <> nil then
    FChooser.SetData(AKey, AValue);
end;

procedure TEditPanel.Show(ARect: TRect; const AInput: TLMDGridFirstInput);
begin
  FInShowMethod := True;
  try
    Assert(FColumn <> nil);
    Update(ARect); // Position and show.

    if FEdit.AsControl <> nil then
      Windows.SetFocus(FEdit.AsControl.Handle);
    if (AInput.Kind <> fikNone) and (FEdit <> nil) then
      FEdit.HandleFirstInput(AInput);
  finally
    FInShowMethod := False;
  end;
end;

procedure TEditPanel.ShowChooser;
var
  sz: TSize;
begin
  if Chooser = nil then
    Exit;
  Realign;

  if FChooser.GetChooserKind = ckControl then
  begin
    sz := FChooser.GetControlSize;

    Inc(sz.cx, FPopupPanel.Width - FPopupPanel.ClientWidth);
    Inc(sz.cy, FPopupPanel.FButtonHeight + 2 * FPopupPanel.FButtonPad +
        (FPopupPanel.Height - FPopupPanel.ClientHeight));

    FPopupPanel.Width   := sz.cx;
    FPopupPanel.Height  := sz.cy;
    FPopupPanel.Visible := True;
    FChooser.SetFocus;

    FChooserShown := True;
  end
  else if FChooser.ShowModal then
  begin
    SyncChooserToEdit(False);
    FChooserShown := False;
  end;
end;

procedure TEditPanel.Update(ABoundsRect: TRect);
begin
  with ABoundsRect do
    SetBounds(Left, Top, Right - Left, Bottom - Top);
  Visible := True;
  Realign;

  if FChooser <> nil then
  begin
    FChooserButton.Enabled := FChooser.IsValid and FColumn.CanEdit;
    if not FChooserButton.Enabled then
      HideChooser(False, True);
    FChooserButton.Visible := FChooser.Enabled;
  end;

  if FEdit <> nil then
    FEdit.SetReadOnly(not FColumn.CanEdit);
end;

procedure TEditPanel.UpdateAll;
begin
  AssignEditProps;
  Realign;
  Invalidate;
end;

procedure TEditPanel.WMEraseBkGnd(var Message: TWMEraseBkGnd);
begin
  Message.Result := 1;
end;

procedure TEditPanel.HideChooser(ASyncEdit, AFocusToEdit: Boolean);
begin
  Assert(FColumn <> nil);

  if FChooserShown and (FChooser.GetChooserKind = ckControl) then
  begin
    if ASyncEdit then
      SyncChooserToEdit(True);

    FPopupPanel.Visible := False;
    FChooserShown := False;

    if AFocusToEdit then
      Windows.SetFocus(FEdit.AsControl.Handle);
  end;
end;

procedure TEditPanel.SyncChooserToEdit(AForHide: Boolean);
var
  k, v: Variant;
begin
  Assert(FEdit <> nil);

  if (not AForHide) or FGrid.ED_IsEditorChanged then
  begin
    if FChooser.GetData(k, v) then
    begin
      v := FColumn.FormatEditorData(v);
      FEdit.SetData(k, v, False);
    end;
  end;
end;

//== TLMDGridStyle =============================================================

procedure TLMDGridStyle.Assign(Source: TPersistent);
var
  src: TLMDGridStyle;
  i:   Integer;
begin
  if Source is TLMDGridStyle then
  begin
    src := Source as TLMDGridStyle;

    BeginUpdate;
    try
      for i := Low(FColors) to High(FColors) do
        SetColor(i, src.GetColor(i));

      for i := Integer(Low(FImages)) to Integer(High(FImages)) do
        SetImg(i, src.GetImg(i));

      IndicatorColWidth := src.IndicatorColWidth;
      HeaderRowHeight := src.HeaderRowHeight;

      EmptyBanner := src.EmptyBanner;
      EmptyBannerFont.Assign(src.EmptyBannerFont);
    finally
      EndUpdate;
    end;
  end
  else
    inherited;
end;

procedure TLMDGridStyle.BeginUpdate;
begin
  if FGrid <> nil then
    FGrid.BeginUpdateLow(True, True);
end;

constructor TLMDGridStyle.Create(AGrid: TLMDCustomGrid);
var
  i: TLMDGridImage;
begin
  if AGrid <> nil then
    AGrid.CheckStyleNotSet;

  FGrid := AGrid;

  for i := Low(i) to High(i) do
  begin
    FImages[i] := TBitmap.Create;
    FImages[i].Transparent := True;
    FImages[i].TransparentMode := tmAuto;
    FImages[i].OnChange := ObjChanged;
  end;

  FColors[0]  := clBtnShadow;
  FColors[1]  := clBtnFace;
  FColors[2]  := clBtnHighlight;
  FColors[3]  := clBtnFace;
  FColors[4]  := clWindow;
  FColors[5]  := clHighlight;
  FColors[6]  := clHighlightText;
  FColors[7]  := clBtnFace;
  FColors[8]  := clBtnShadow;
  FColors[9]  := clNone;
  FColors[10] := clWindow;

  FIndicatorWidth    := 10;
  FHeaderRowHeight   := 20;

  FEmptyBannerFont := TFont.Create;
  FEmptyBannerFont.OnChange := ObjChanged;
end;

destructor TLMDGridStyle.Destroy;
var
  i: TLMDGridImage;
begin
  for i := Low(i) to High(i) do
    FImages[i].Free;

  FEmptyBannerFont.Free;

  inherited;
end;

procedure TLMDGridStyle.EndUpdate;
begin
  if FGrid <> nil then
    FGrid.EndUpdateLow;
end;

function TLMDGridStyle.GetColor(const Index: Integer): TColor;
begin
  Result := FColors[Index];
end;

procedure TLMDGridStyle.SetColor(const Index: Integer;
  const Value: TColor);
begin
  if Value = GetColor(Index) then
    Exit;

  BeginUpdate;
  try
    FColors[Index] := Value;
  finally
    EndUpdate;
  end;
end;

procedure TLMDGridStyle.SetEmptyBanner(const Value: TLMDString);
begin
  if Value = FEmptyBanner then
    Exit;

  BeginUpdate;
  try
    FEmptyBanner := Value;
  finally
    EndUpdate;
  end;
end;

procedure TLMDGridStyle.SetEmptyBannerFont(const Value: TFont);
begin
  if Value = nil then
    raise ELMDGridError.CreateFmt(SLMDGridNilArgument,
                                  ['SetEmptyBannerFont, arg: Value']);

  FEmptyBannerFont := Value;
  if Value = FEmptyBannerFont then
    Exit;
  BeginUpdate;
  try
    FEmptyBannerFont.Assign(Value);
  finally
    EndUpdate;
  end;
end;

procedure TLMDGridStyle.SetHeaderRowHeight(const Value: Integer);
begin
  if Value = FHeaderRowHeight then
    Exit;

  CheckIntValue('HeaderRowHeight', Value, 1);
  BeginUpdate;
  try
    FHeaderRowHeight := Value;
    if (FGrid <> nil) and (opShowHeader in FGrid.Options) then
      FGrid.RowHeights[0] := FHeaderRowHeight;
  finally
    EndUpdate;
  end;
end;

function TLMDGridStyle.GetImg(const Index: Integer): TBitmap;
begin
  Result := FImages[TLMDGridImage(Index)];
end;

procedure TLMDGridStyle.ObjChanged(Sender: TObject);
begin
  BeginUpdate;
  EndUpdate;
end;

procedure TLMDGridStyle.SetImg(const Index: Integer; const Value: TBitmap);
var
  id: TLMDGridImage;
begin
  if Value = GetImg(Index) then
    Exit;

  BeginUpdate;
  try
    id := TLMDGridImage(Index);

    if Value = nil then
    begin
      FImages[id].Height := 0;
      FImages[id].Width := 0;
    end
    else
    begin
      FImages[id].Assign(Value);
      FImages[id].TransparentMode := tmAuto;
      FImages[id].Transparent := True;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TLMDGridStyle.SetIndicatorWidth(const Value: Integer);
begin
  if Value = FIndicatorWidth then
    Exit;

  BeginUpdate;
  try
    FIndicatorWidth := Value;

    if (FGrid <> nil) and (opShowIndicator in FGrid.Options) then
      FGrid.ColWidths[0] := FIndicatorWidth;
  finally
    EndUpdate;
  end;
end;

//== TLMDGridCheckBoxColumn ====================================================

procedure TLMDGridCheckBoxColumn.BeginUpdate;
begin
  if FGrid <> nil then
    FGrid.BeginUpdateLow(False, True);
end;

procedure TLMDGridCheckBoxColumn.CheckGridEmpty;
begin
  if (FGrid <> nil) and (FGrid.DataRowCount > 0) then
    raise ELMDGridError.Create(SLMDGridEmptyGridRequired);
end;

procedure TLMDGridCheckBoxColumn.CheckStrForState(const AStr: TLMDString);
begin
  StrToVar(AStr);
end;

function TLMDGridCheckBoxColumn.CompareColValues(Val1, Val2: PVariant): Integer;
var
  i1, i2: Integer;
  s1, s2: TLMDString;
begin
  case FDataType of
    dtBoolean, dtInteger:
    begin
      if IsVarEmpty(Val1) then
      begin
        if IsVarEmpty(Val2) then
          Result := 0
        else
          Result := -1;
      end
      else if IsVarEmpty(Val2) then
      begin
        if IsVarEmpty(Val1) then
          Result := 0
        else
          Result := 1;
      end
      else
      begin
        i1 := Val1^;
        i2 := Val2^;
        Result := i1 - i2;
      end;
    end;
    dtString:
    begin
      if IsVarEmpty(Val1) then
        s1 := Val1^
      else
        s1 := '';

      if IsVarEmpty(Val1) then
        s2 := Val2^
      else
        s2 := '';

      Result := LMDCompareStr(s1, s2);
    end;
  else
    Assert(False);
    Result := 0;
  end;
end;

constructor TLMDGridCheckBoxColumn.Create(AOwner: TComponent);
begin
  FDefaultDataType := ftBoolean;
  inherited;

  FDrawCB              := True;
  FDrawDescr           := False;
  FStateValues         := TLMDGridCheckBoxStateValues.Create(Self);
  FDataType            := dtBoolean;

  InitDefValues;
  SetDefValues(True);

  FEditor   := TEmbeddedCheckBox.Create(Self);
  Alignment := Classes.taCenter;
end;

destructor TLMDGridCheckBoxColumn.Destroy;
begin
  inherited;

  FStateValues.Free;
end;

procedure TLMDGridCheckBoxColumn.EndUpdate(ADataTypeChanged: Boolean);
begin
  if FGrid <> nil then
  begin
    if (not FGrid.InInitMode) and ADataTypeChanged then
      FGrid.InternalColumnDataTypeChanged(Self);
    FGrid.EndUpdateLow;
  end;
end;

function TLMDGridCheckBoxColumn.GetCheckBoxInfo(ACanvas: TCanvas;
  AState: TCheckBoxState; APressed, AHot: Boolean;
  AUseTheme: TLMDThemeMode): TLMDGridCheckBoxInfo;
var
  sz: TSize;
  d:  TThemedElementDetails;
begin
  if AUseTheme = ttmNone then
  begin
    Result.Width  := 15;
    Result.Height := 15;
    Result.Flags  := 0;

    case AState of
      cbUnchecked: Result.Flags := DFCS_BUTTONCHECK;
      cbChecked:   Result.Flags := DFCS_BUTTONCHECK or DFCS_CHECKED;
      cbGrayed:    Result.Flags := DFCS_BUTTON3STATE or DFCS_INACTIVE or
                                   DFCS_CHECKED;
    end;

    if AHot then
      Result.Flags := Result.Flags or DFCS_HOT;
  end
  else
  begin
    Result.Flags := 0;

    if APRessed then
    begin
      case AState of
        cbUnchecked: Result.Flags := Integer(tbCheckBoxUncheckedPressed);
        cbChecked:   Result.Flags := Integer(tbCheckBoxCheckedPressed);
        cbGrayed:    Result.Flags := Integer(tbCheckBoxMixedPressed);
      end;
    end
    else if AHot then
    begin
      case AState of
        cbUnchecked: Result.Flags := Integer(tbCheckBoxUncheckedHot);
        cbChecked:   Result.Flags := Integer(tbCheckBoxCheckedHot);
        cbGrayed:    Result.Flags := Integer(tbCheckBoxMixedHot);
      end;
    end
    else
    begin
      case AState of
        cbUnchecked: Result.Flags := Integer(tbCheckBoxUncheckedNormal);
        cbChecked:   Result.Flags := Integer(tbCheckBoxCheckedNormal);
        cbGrayed:    Result.Flags := Integer(tbCheckBoxMixedNormal);
      end;
    end;

    d := LMDThemeServices.GetDetails(teButton, Result.Flags);
    if LMDThemeServices.GetThemePartSize(AUseTheme, ACanvas.Handle,
                                         d, sz) then
    begin
      Result.Width  := sz.cx;
      Result.Height := sz.cy;
    end
    else
    begin
      Result.Width  := 15;
      Result.Height := 15;
    end;
  end;
end;

function TLMDGridCheckBoxColumn.GetDescrsEmpty(const ADescrs: TStringPropsArr): string;
var
  s: string;
begin
  s := '';

  if ADescrs[spCheckedDescr] = '' then
    s := s + 't';
  if ADescrs[spUncheckedDescr] = '' then
    s := s + 'f';
  if ADescrs[spUndefinedDescr] = '' then
    s := s + 'u';

  Result := s;
end;

function TLMDGridCheckBoxColumn.GetEmbeddedEditor: ILMDGridEmbeddedEdit;
begin
  if not (FEditor is TEmbeddedCheckBox) then
    Assert(False);
  Result := FEditor as TEmbeddedCheckBox;
end;

function TLMDGridCheckBoxColumn.GetStrProp(
  const Index: TLMDGridCheckBoxColumnSP): TLMDString;
begin
  Result := FStringProps[Index];
end;

procedure TLMDGridCheckBoxColumn.InitDefValues;
begin
  case FDataType of
    dtBoolean,
    dtString:
    begin
      FDefStringProps[spCheckedValue] := 'True';
      FDefStringProps[spUncheckedValue] := 'False';
    end;

    dtInteger:
    begin
      FDefStringProps[spCheckedValue] := '1';
      FDefStringProps[spUncheckedValue] := '0';
    end;

  else
    Assert(False);
  end;
  FDefStringProps[spUndefinedValue] := '';

  FDefStringProps[spCheckedDescr] := 'True';
  FDefStringProps[spUncheckedDescr] := 'False';
  FDefStringProps[spUndefinedDescr] := '';
end;

procedure TLMDGridCheckBoxColumn.CheckInitPropsForField;
var
  field: TField;
  dt:    TLMDGridCheckBoxDataType;
begin
  Assert(Grid <> nil);

  field := Grid.GetColumnField(Self);
  if field <> nil then
  begin
    dt := FieldDataTypeToColDataType(field.DataType);
    if dt <> TLMDGridCheckBoxDataType(-1) then
      DataType := dt;
  end;
end;

function TLMDGridCheckBoxColumn.IsFieldTypeCompatibleWithColSettings(
  AField: TField; PErrMessage: PLMDString): Boolean;
var
  dt: TLMDGridCheckBoxDataType;
begin
  Result := inherited IsFieldTypeCompatibleWithColSettings(AField, PErrMessage);
  if Result then
  begin
    dt := FieldDataTypeToColDataType(AField.DataType);
    Result := dt = DataType;
    if (not Result) and (PErrMessage <> nil) then
      PErrMessage^ := Format(SLMDGridFieldTypeIncompatibleWithSettings,
                             [AField.Name, 'DataType']);
  end;
end;

function TLMDGridCheckBoxColumn.IsStrPropStored(
  const Index: TLMDGridCheckBoxColumnSP): Boolean;
begin
  Result := FStringProps[Index] <> FDefStringProps[Index];
end;

function TLMDGridCheckBoxColumn.IsValueValid(Value: PVariant;
  AErrMsg: PLMDString): Boolean;
var
  s: TLMDString;
begin
  try
    NormalizeValue(Value, nil);
    s := VarToStr(Value);

    Result := (s = FStringProps[spCheckedValue]) or
              (s = FStringProps[spUncheckedValue]) or
              (s = FStringProps[spUndefinedValue]);

    if not Result then
      AErrMsg^ := SLMDGridCBColumnStateValueRequired;
  except
    on E: Exception do
    begin
      Result := False;
      case FDataType of
        dtBoolean: AErrMsg^ := SLMDGridCBColumnBoolRequired;
        dtString: AErrMsg^ := SLMDGridCBColumnStrRequired;
        dtInteger: AErrMsg^ := SLMDGridCBColumnIntRequired;
      end;
    end;
  end;
end;

procedure TLMDGridCheckBoxColumn.NormalizeValue(ASrcValue,
  ADestValue: PVariant);
var
  b: Boolean;
  i: Integer;
  s: TLMDString;
begin
  if IsVarEmpty(ASrcValue) then
  begin
    if ADestValue <> nil then
      ADestValue^ := ASrcValue^;

    Exit;
  end;

  case FDataType of
    dtBoolean:
    begin
      b := ASrcValue^;

      if ADestValue <> nil then
        ADestValue^ := b;
    end;
    dtString:
    begin
      s := ASrcValue^;

      if ADestValue <> nil then
        ADestValue^ := s;
    end;
    dtInteger:
    begin
      i := ASrcValue^;

      if ADestValue <> nil then
        ADestValue^ := i;
    end;
  else
    Assert(False);
  end;
end;

procedure TLMDGridCheckBoxColumn.PaintCheckBox(ACanvas: TCanvas;
  const P: TPoint; AUseTheme: TLMDThemeMode;
  const AInfo: TLMDGridCheckBoxInfo);
var
  r: TRect;
begin
  r := Rect(P.X, P.Y, P.X + AInfo.Width, P.Y + AInfo.Height);

  if AUseTheme = ttmNone then
    DrawFrameControl(ACanvas.Handle, r, DFC_BUTTON, AInfo.Flags)
  else
    LMDThemeServices.DrawElement(AUseTheme, ACanvas.Handle,
                                 TThemedButton(AInfo.Flags), r);
end;

procedure TLMDGridCheckBoxColumn.PaintFormattedCellData(ACanvas: TCanvas;
  ARect: TRect; const AData: Variant; AAlignment: TAlignment;
  ACellState: TLMDGridCellStates);
const
  Pad = 3;
var
  s:     TLMDString;
  state: TCheckBoxState;
  cbW:   Integer;
  textR: TRect;
  cbp:   TPoint;
  cbnfo: TLMDGridCheckBoxInfo;
begin
  cbW   := 0;
  s     := VarToStr(@AData);
  state := StrToState(s);
  
  if (state = cbGrayed) and not FDrawGrayed then
    Exit;

  if FDrawCB then
  begin
    cbnfo := GetCheckBoxInfo(ACanvas, state, csPressed in ACellState,
                             csHover in ACellState, Grid.UseThemeMode);
    cbW   := cbnfo.Width;
  end;

  textR.Left   := (ARect.Right + ARect.Left) div 2 + cbW - 1;
  textR.Right  := textR.Left; // Zero width rect.
  textR.Top    := ARect.Top;
  textR.Bottom := ARect.Bottom;

  if FDrawDescr then
    case state of
      cbUnchecked: s := FStringProps[spUncheckedDescr];
      cbChecked:   s := FStringProps[spCheckedDescr];
      cbGrayed:    s := FStringProps[spUndefinedDescr];
    end
  else
    s := ''; // Need to output the text in any case
             // to calc textR rect.

  DefTextOut(ACanvas, ARect, s, AAlignment, True, True,
             cbW + Pad, ACellState, Grid.Style, textR);

  if FDrawCB then
  begin
    cbp.X := textR.Left - cbW - Pad;
    cbp.Y := (textR.Top + textR.Bottom - cbnfo.Height) div 2;

    PaintCheckBox(ACanvas, cbp, Grid.UseThemeMode, cbnfo);
  end;
end;

procedure TLMDGridCheckBoxColumn.ResetEmbeddedEditor;
begin
  DetachEmbeddedEditor;
  FEditor.Free;
  FEditor := TEmbeddedCheckBox.Create(Self);
end;

procedure TLMDGridCheckBoxColumn.SetDataType(
  const Value: TLMDGridCheckBoxDataType);
begin
  if Value <> FDataType then
  begin
    BeginUpdate;
    try
      FDataType := Value;
      InitDefValues;
      SetDefValues(False);
    finally
      EndUpdate(True);
    end;
  end;
end;

procedure TLMDGridCheckBoxColumn.SetDefValues(ASetDescr: Boolean);
begin
  FStringProps[spCheckedValue]   := FDefStringProps[spCheckedValue];
  FStringProps[spUncheckedValue] := FDefStringProps[spUncheckedValue];
  FStringProps[spUndefinedValue] := FDefStringProps[spUndefinedValue];

  if ASetDescr then
  begin
    FStringProps[spCheckedDescr]   := FDefStringProps[spCheckedDescr];
    FStringProps[spUncheckedDescr] := FDefStringProps[spUncheckedDescr];
    FStringProps[spUndefinedDescr] := FDefStringProps[spUndefinedDescr];
  end;
end;

procedure TLMDGridCheckBoxColumn.SetDrawCB(const Value: Boolean);
begin
  if FDrawCB <> Value then
  begin
    BeginUpdate;
    FDrawCB := Value;
    EndUpdate(False);
  end;
end;

procedure TLMDGridCheckBoxColumn.SetDrawDescr(const Value: Boolean);
begin
  if FDrawDescr <> Value then
  begin
    BeginUpdate;
    FDrawDescr := Value;
    EndUpdate(False);
  end;
end;

procedure TLMDGridCheckBoxColumn.SetDrawGrayed(const Value: Boolean);
begin
  if FDrawGrayed <> Value then
  begin
    BeginUpdate;
    FDrawGrayed := Value;
    EndUpdate(False);
  end;
end;

procedure TLMDGridCheckBoxColumn.SetStateValues(
  const Value: TLMDGridCheckBoxStateValues);
begin
  if FStateValues <> Value then
    FStateValues.Assign(Value);
end;

procedure TLMDGridCheckBoxColumn.SetStrProp(const Index: TLMDGridCheckBoxColumnSP;
  const Value: TLMDString);

  procedure SwapIf(const S: TLMDString; var S1: TLMDString; var S2: TLMDString);
  var
    tmp: TLMDString;
  begin
    if LMDLowerCase(S) = LMDLowerCase(S1) then
    begin
      tmp := S1;
      S1  := S2;
      S2  := tmp;
    end;
  end;

var
  s:      TLMDString;
  i1, i2: TLMDGridCheckBoxColumnSP;
begin
  if FStringProps[Index] = Value then
    Exit;
  s := LMDLowerCase(Value);

  case Index of
    spCheckedValue,
    spUncheckedValue,
    spUndefinedValue:
    begin
      if not (csReading in ComponentState) then
      begin
        SwapIf(s, FStringProps[spCheckedValue], FStringProps[Index]);
        SwapIf(s, FStringProps[spUncheckedValue], FStringProps[Index]);
        SwapIf(s, FStringProps[spUndefinedValue], FStringProps[Index]);
      end;

      case Index of
        spCheckedValue:
        begin
          i1 := spUncheckedValue;
          i2 := spUndefinedValue;
        end;

        spUncheckedValue:
        begin
          i1 := spCheckedValue;
          i2 := spUndefinedValue;
        end;

        spUndefinedValue:
        begin
          i1 := spCheckedValue;
          i2 := spUncheckedValue;
        end;
      else
        i1 := TLMDGridCheckBoxColumnSP(-1);
        i2 := i1;
      end;

      if (FStringProps[i1] <> '') and (FStringProps[i2] <> '') and (Value <> '') then
        raise ELMDGridError.Create(SLMDGridCBColumnNoNullValueSet);

      CheckStrForState(Value);
    end;
  end;

  BeginUpdate;
  try
    if (FDataType = dtBoolean) and
       (Index in [spCheckedValue, spUncheckedValue, spUndefinedValue])
    then
      FStringProps[Index] := LMDTrim(s)
    else
      FStringProps[Index] := Value;
  finally
    EndUpdate(True);
  end;
end;

function TLMDGridCheckBoxColumn.FieldDataTypeToColDataType(
  ADataType: TFieldType): TLMDGridCheckBoxDataType;
var
  dt: TLMDGridCheckBoxDataType;
begin
  Assert(Grid <> nil);

  if ADataType in StringFormatTypes then
    dt := dtString
  else if ADataType in IntTypes then
    dt := dtInteger
  else if ADataType = ftBoolean then
    dt := dtBoolean
  else
    dt := TLMDGridCheckBoxDataType(-1);

  Result := dt;
end;

function TLMDGridCheckBoxColumn.StateToDescr(
  AState: TCheckBoxState): TLMDString;
begin
  Result := '';
  case AState of
    cbUnchecked: Result := FStringProps[spUncheckedDescr];
    cbChecked:   Result := FStringProps[spCheckedDescr];
    cbGrayed:    Result := FStringProps[spUndefinedDescr];
  else
    Assert(False);
  end;
end;

function TLMDGridCheckBoxColumn.StateToStr(AState: TCheckBoxState): TLMDString;
begin
  Result := '';
  case AState of
    cbUnchecked: Result := FStringProps[spUncheckedValue];
    cbChecked:   Result := FStringProps[spCheckedValue];
    cbGrayed:    Result := FStringProps[spUndefinedValue];
  else
    Assert(False);
  end;
end;

function TLMDGridCheckBoxColumn.StrToState(
  const AStr: TLMDString): TCheckBoxState;
begin
  CheckStrForState(AStr);

  if AStr = FStringProps[spCheckedValue] then
    Result := cbChecked
  else if AStr = FStringProps[spUncheckedValue] then
    Result := cbUnchecked
  else if not FAllowUndefinedValue then
    Result := cbUnchecked
  else
    Result := cbGrayed;
end;

function TLMDGridCheckBoxColumn.StrToVar(const AStr: TLMDString): Variant;
var
  s: TLMDString;
  i: Integer;
begin
  s := LMDLowerCase(AStr);

  case FDataType of
    dtBoolean:
    begin
      if s = 'true' then
        Result := True
      else if s = 'false' then
        Result := False
      else if s = '' then
      begin
        if FAllowUndefinedValue then
          Result := NullVariant
        else
          Result := False;
      end
      else
        raise ELMDGridError.Create(SLMDGridCBColumnBoolRequired);
    end;
    dtString:
      Result := AStr;
    dtInteger:
    begin
      if TryStrToInt(AStr, i) then
        Result := i
      else if s = '' then
      begin
        if FAllowUndefinedValue then
          Result := NullVariant
        else
          Result := 0;
      end
      else
        raise ELMDGridError.Create(SLMDGridCBColumnIntRequired);
    end;
  end;
end;

function TLMDGridCheckBoxColumn.VarToStr(AVar: PVariant): TLMDString;
begin
  if IsVarEmpty(AVar) then
    Result := ''
  else
  begin
    case FDataType of
      dtBoolean:
      begin
        if Boolean(AVar^) then
          Result := 'True'
        else
          Result := 'False';
      end;
      dtString:
        Result := AVar^;
      dtInteger:
        Result := IntToStr(Integer(AVar^));
    end;
  end;
end;

//== TLMDGridEmbeddedCheckBox ==================================================

function TEmbeddedCheckBox.AsControl: TWinControl;
begin
  Result := Self;
end;

function TEmbeddedCheckBox.Column: TLMDGridColumn;
begin
  Result := FCol;
end;

constructor TEmbeddedCheckBox.Create(ACol: TLMDGridCheckBoxColumn);
begin
  FInitMode := True;
  try
    inherited Create(nil);

    ControlStyle    := ControlStyle - [csCaptureMouse]; // Manual capture.
    Font            := ACol.Font;
    TabStop         := False;
    FCol            := ACol;
    FAllowUndefined := ACol.AllowUndefinedValue;
  finally
    FInitMode := False;
  end;
end;

procedure TEmbeddedCheckBox.GetData(var AKey, AValue: Variant);
var
  s: TLMDString;
begin
  s      := FCol.StateToStr(State);
  AValue := FCol.StrToVar(s);
  AKey   := FKey;
end;

function TEmbeddedCheckBox.GetNextState(
  ACurState: TCheckBoxState): TCheckBoxState;
const
  NEXT_STATE: array[TCheckBoxState] of TCheckBoxState = (
    cbGrayed,    // cbUnchecked
    cbUnchecked, // cbChecked
    cbChecked    // cbGrayed
  );
begin
  // States changes like in Windows. Important: after Grayed state it is 
  // good to switch to checked state, because when grayed state is painted 
  // as a white space, click on it intuitively assumes to check, not to 
  // uncheck.

  Result := NEXT_STATE[ACurState]; 
    
  if not (FAllowUndefined and FCol.FDrawGrayed) and 
     (Result = cbGrayed) then
    Result := GetNextState(Result);
end;

function TEmbeddedCheckBox.GetReadOnly: Boolean;
begin
  Result := FReadOnly;
end;

procedure TEmbeddedCheckBox.HandleFirstInput(const AInput: TLMDGridFirstInput);
var
  key: Word;
  p:   TSmallPoint;
begin
  case AInput.Kind of
    fikChar:      begin
                    key := Ord(AInput.Char);
                    KeyDown(key, []);
                  end;
    fikMouseDown: if ssLeft in AInput.Shift then
                  begin
                    Update; // At least one painting is required
                            // to calc control's layout.

                    p := PointToSmallPoint(ScreenToClient(AInput.CursorPos));
                    Perform(WM_LBUTTONDOWN, MK_LBUTTON, LPARAM(Integer(p)))
                  end;
    fikDelPress:  begin
                    key := VK_DELETE;
                    KeyDown(key, []);
                  end;
  end;
end;

function TEmbeddedCheckBox.IsHover: Boolean;
var
  p: TPoint;
begin
  p      := ScreenToClient(Mouse.CursorPos);
  Result := PtInRect(ClientRect, p);
end;

procedure TEmbeddedCheckBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FGrid.KeyDownPreprocess(Key, Shift, psEdit);

  if not FReadOnly and not FPressedByKey then
    case Key of
      VK_SPACE:   begin
                    Key           := 0;
                    FPressedByKey := True;
                    Invalidate;
                  end;
      VK_DELETE:  begin
                    Key := 0;
                    if FCol.AllowUndefinedValue then
                      State := cbGrayed
                    else
                      State := cbUnchecked;
                  end;
    end;

  if Key <> 0 then
    FGrid.KeyDownPostprocess(Key, Shift, psEdit);
end;

procedure TEmbeddedCheckBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if FPressedByKey and (Key = VK_SPACE) then
  begin
    FPressedByKey := False;
    Key           := 0;
    State         := GetNextState(FState);
  end;

  inherited;
end;

procedure TEmbeddedCheckBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if (ssLeft in Shift) and not FReadOnly then
  begin
    MouseCapture    := True;
    FPressedByMouse := True;
    Invalidate;
  end;
  UpdateHoverState;
  inherited;
end;

procedure TEmbeddedCheckBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  UpdateHoverState;
end;

procedure TEmbeddedCheckBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if FPressedByMouse then
  begin
    State           := GetNextState(FState);
    FPressedByMouse := False;
    MouseCapture    := False;
    Invalidate;
  end;
  UpdateHoverState;
  inherited;
end;

function TEmbeddedCheckBox.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := FGrid.DoMouseWheelDown(Shift);
end;

function TEmbeddedCheckBox.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := FGrid.DoMouseWheelUp(Shift);
end;

procedure TEmbeddedCheckBox.Changed;
begin
  if FInitMode then
    Exit;

  Assert(FGrid <> nil);
  Assert(FCol <> nil);

  FGrid.EditorChanged;
end;

procedure TEmbeddedCheckBox.CMMouseLeave(var Message: TMessage);
begin
  UpdateHoverState;
  inherited;
end;

procedure TEmbeddedCheckBox.WndProc(var Message: TMessage);
begin
  if (FGrid = nil) or (not FGrid.WndProc(Self, Message)) then
    inherited WndProc(Message);
end;

procedure TEmbeddedCheckBox.Paint;
var
  r:        TRect;
  key, val: Variant;
  cstate:   TLMDGridCellStates;
begin
  FGrid.DrawEditBg(ClientRect, Canvas);

  r := ClientRect;
  Inc(r.Left, FCol.PaddingLeft - 1);
  Inc(r.Top, FCol.PaddingTop - 1);
  Dec(r.Right, FCol.PaddingRight - 1);
  Dec(r.Bottom, FCol.PaddingBottom - 1);

  cstate := [];
  FHover := IsHover;
  if (FHover and FPressedByMouse) or FPressedByKey then
    Include(cstate, csPressed)
  else if FHover then
    Include(cstate, csHover);

  GetData(key, val);
  FCol.PaintFormattedCellData(Canvas, r, val, FCol.Alignment, cstate);
end;

procedure TEmbeddedCheckBox.SetData(const AKey, AValue: Variant;
  AInitValue: Boolean);
var
  s: TLMDString;
begin
  FKey      := AKey;
  FInitMode := True;
  try
    s               := FCol.VarToStr(@AValue);
    State           := FCol.StrToState(s);
    FAllowUndefined := FCol.AllowUndefinedValue;

    if not IsVarEmpty(@AKey) then
      SetReadOnly(True);
  finally
    FInitMode := False;
  end;

  if (not AInitValue) and (FGrid <> nil) then
    FGrid.EditorChanged;
end;

procedure TEmbeddedCheckBox.SetGrid(AGridHelper: TLMDGridEditParentHelper);
begin
  FGrid := AGridHelper;
end;

procedure TEmbeddedCheckBox.SetReadOnly(AValue: Boolean);
begin
  FReadOnly := AValue;
end;

procedure TEmbeddedCheckBox.SetState(const Value: TCheckBoxState);
begin
  if FState <> Value then
  begin
    FState := Value;
    Invalidate;
    Changed;
  end;
end;

procedure TEmbeddedCheckBox.SetThemeMode(AThemeMode: TLMDThemeMode;
  AThemeGlobalMode: Boolean);
begin
  // Do nothing.
end;

procedure TEmbeddedCheckBox.UpdateHoverState;
var
  hvr: Boolean;
begin
  hvr := IsHover;
  if FHover <> hvr then
  begin
    FHover := hvr; // Prevents frequent invalidations.
    Invalidate;
  end;
end;

procedure TEmbeddedCheckBox.WMCancelMode(var Msg: TWMCancelMode);
begin
  if FPressedByMouse then
  begin
    FPressedByMouse := False;
    MouseCapture    := False;
    Invalidate;
  end;
  inherited;
end;

procedure TEmbeddedCheckBox.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;

  FGrid.WMGetDlgCode(Self, Message);
  Message.Result := Message.Result or DLGC_WANTARROWS;
end;

procedure TEmbeddedCheckBox.WMKillFocus(var Msg: TWMKillFocus);
begin
  if FPressedByKey then
  begin
    FPressedByKey := False;
    Invalidate;
  end;
  inherited;
end;

procedure TLMDGridCheckBoxColumn.DefineProperties(Filer: TFiler);
var
  haveEmptyDescr:                  Boolean;
  col:                             TLMDGridCheckBoxColumn;
  emptyStr, emptyDefStr, emptyAnc: string;
begin
  inherited;

  if Filer.Ancestor <> nil then
  begin
    col := Filer.Ancestor as TLMDGridCheckBoxColumn;
    emptyAnc := col.GetDescrsEmpty(col.FStringProps);
  end
  else
    emptyAnc := '';

  emptyStr := GetDescrsEmpty(FStringProps);
  emptyDefStr := GetDescrsEmpty(FDefStringProps);

  haveEmptyDescr := (emptyStr <> emptyDefStr) and (emptyStr <> emptyAnc);

  Filer.DefineProperty('DescrsEmpty', ReadDescrsEmpty, WriteDescrsEmpty,
                       haveEmptyDescr);
end;

procedure TLMDGridCheckBoxColumn.ReadDescrsEmpty(Reader: TReader);
var
  s: string;
begin
  s := Reader.ReadString;
  if Pos('f', s) <> 0 then
    StateValues.UncheckedDescr := '';

  if Pos('t', s) <> 0 then
    StateValues.CheckedDescr := '';

  if Pos('u', s) <> 0 then
    StateValues.UndefinedDescr := '';
end;

procedure TLMDGridCheckBoxColumn.WriteDescrsEmpty(Writer: TWriter);
begin
  Writer.WriteString(GetDescrsEmpty(FStringProps));
end;

//== TLMDGridCheckBoxStateValues ===============================================

procedure TLMDGridCheckBoxStateValues.Assign(Source: TPersistent);
var
  src: TLMDGridCheckBoxStateValues;
begin
  if Source = Self then
    Exit;

  if Source is TLMDGridCheckBoxStateValues then
  begin
    FCol.BeginUpdate;
    try
      src := Source as TLMDGridCheckBoxStateValues;

      CheckedValue   := src.CheckedValue;
      UncheckedValue := src.UncheckedValue;
      UndefinedValue := src.UndefinedValue;
      CheckedDescr   := src.CheckedDescr;
      UncheckedDescr := src.UncheckedDescr;
      UndefinedDescr := src.UndefinedDescr;
    finally
      FCol.EndUpdate(False);
    end;
  end
  else
    inherited Assign(Source);
end;

constructor TLMDGridCheckBoxStateValues.Create(ACol: TLMDGridCheckBoxColumn);
begin
  if ACol = nil then
    raise ELMDGridError.Create(SLMDGridParentColIsNil);

  FCol := ACol;
end;

function TLMDGridCheckBoxStateValues.GetStrProp(
  const Index: Integer): TLMDString;
begin
  Result := FCol.GetStrProp(TLMDGridCheckBoxColumnSP(Index));
end;

function TLMDGridCheckBoxStateValues.IsStrPropStored(
  const Index: Integer): Boolean;
begin
  Result := FCol.IsStrPropStored(TLMDGridCheckBoxColumnSP(Index));
end;

procedure TLMDGridCheckBoxStateValues.SetStrProp(const Index: Integer;
  const Value: TLMDString);
begin
  FCol.SetStrProp(TLMDGridCheckBoxColumnSP(Index), Value);
end;

//== TEditHelper ===============================================================

function TEditHelper.AsControl: TLMDCustomGrid;
begin
  Result := FGrid;
end;

constructor TEditHelper.Create(AGrid: TLMDCustomGrid);
begin
  FGrid := AGrid;
end;

function TEditHelper.DoMouseWheelDown(Shift: TShiftState): Boolean;
begin
  Result := FGrid.ED_DoMouseWheelDown(Shift);
end;

function TEditHelper.DoMouseWheelUp(Shift: TShiftState): Boolean;
begin
  Result := FGrid.ED_DoMouseWheelUp(Shift);
end;

procedure TEditHelper.DrawEditBg(ARect: TRect; ACanvas: TCanvas);
var
  rt, rp:   TRect;
  colObj:   TLMDGridColumn;
  col, row: Integer;
begin
  col := FGrid.CurrentColumn;
  row := FGrid.CurrentRow;
  colObj := FGrid.Columns[ col ];

  rp := Rect(0, 0, 0, 0);
  colObj.PaintCellBG(ACanvas, row, ARect, [], False, rp, rt);
end;

procedure TEditHelper.EditorChanged;
begin
  FGrid.ED_EditorChanged;
end;

procedure TEditHelper.KeyDownPreprocess(var Key: Word;
  Shift: TShiftState; Source: TLMDGridKeyProcessSource);
begin
  FGrid.ED_KeyDown(Key, Shift, True, Source);
end;

procedure TEditHelper.NeedDelayedHideChooser;
begin
  // Do nothing.
end;

procedure TEditHelper.KeyDownPostprocess(var Key: Word;
  Shift: TShiftState; Source: TLMDGridKeyProcessSource);
begin
  FGrid.ED_KeyDown(Key, Shift, False, Source);
end;

procedure TEditHelper.WMGetDlgCode(const Ed: ILMDGridEmbeddedEdit;
  var Message: TWMGetDlgCode);
begin
  FGrid.ED_WMGetDlgCode(Ed, Message);
end;

function TEditHelper.WndProc(const Edit: ILMDGridEmbeddedEdit;
  var Message: TMessage): Boolean;
begin
  Result := FGrid.ED_WndProc(Edit, Message);
end;

//== TLMDGridColumnChooser =====================================================

procedure TLMDGridColumnChooser.Assign(AValue: TPersistent);
var
  src: TLMDGridColumnChooser;
begin
  if AValue is TLMDGridColumnChooser then
  begin
    src := AValue as TLMDGridColumnChooser;
    Self.Enabled     := src.Enabled;
    Self.ButtonImage := src.ButtonImage;
  end
  else
    inherited Assign(AValue);
end;

constructor TLMDGridColumnChooser.Create(AOwner: TComponent);
begin
  FUpdateCnt := 0;
  FValid := False;
  FEnabled := True;
  FIsEmpty := False;

  inherited Create(AOwner);

  Name := 'Chooser';
  //Do not need it... Also, this causes a bug on loading (GlobalLoaded..Loaded)
  //SetSubComponent(True);

  Assert(AOwner <> nil);
  Assert(AOwner is TLMDGridColumn);

  FColumn := AOwner as TLMDGridColumn;
  FButtonImage := TBitmap.Create;
end;

destructor TLMDGridColumnChooser.Destroy;
begin
  FreeAndNil(FButtonImage);
  inherited;
end;

function TLMDGridColumnChooser.GetChooserKind: TLMDGridChooserKind;
begin
  Result := ckControl;
end;

function TLMDGridColumnChooser.GetColumnField: TField;
begin
  CheckCol;
  Result := FColumn.Grid.GetColumnField(FColumn);
end;

function TLMDGridColumnChooser.GetColumnFieldKey: TField;
begin
  CheckCol;
  Result := FColumn.Grid.GetColumnFieldKey(FColumn);
end;

function TLMDGridColumnChooser.GetEditHelper: TLMDGridEditParentHelper;
begin
  CheckCol;
  Result := FColumn.FGrid.FEditHelper;
end;

function TLMDGridColumnChooser.GetLayout: TLMDGridChooserLayout;
begin
  Result := clUnderEdit;
end;

class function TLMDGridColumnChooser.GetRegisteredChooserClass(
  AChooserClass: TClass): TLMDGridChooserDescr;
var
  i:   Integer;
  dsc: TLMDGridChooserDescr;
begin
  for i := 0 to ChooserClasses.Count - 1 do
  begin
    dsc := ChooserClasses[i] as TLMDGridChooserDescr;
    if dsc.ChooserClass = AChooserClass then
    begin
      Result := dsc;
      Exit;
    end;
  end;

  Result := nil;
end;

function TLMDGridColumnChooser.IsValid: Boolean;
begin
  Result := FValid;
end;

function TLMDGridColumnChooser.NeedOkButton: Boolean;
begin
  Result := False;
end;

class function TLMDGridColumnChooser.GetRegisteredChooserClass(
  const AChooserName: string): TLMDGridChooserDescr;
var
  i:   Integer;
  dsc: TLMDGridChooserDescr;
begin
  for i := 0 to ChooserClasses.Count - 1 do
  begin
    dsc := ChooserClasses[i] as TLMDGridChooserDescr;
    if dsc.ChooserName = AChooserName then
    begin
      Result := dsc;
      Exit;
    end;
  end;

  Result := nil;
end;

class function TLMDGridColumnChooser.GetRegisteredChooserClass(
  AFieldType: TFieldType; AFieldKind: TFieldKind): TLMDGridChooserDescr;
var
  i:     Integer;
  descr: TLMDGridChooserDescr;
begin
  for i := 0 to ChooserClassesMain.Count - 1 do
  begin
    descr := ChooserClassesMain[i] as TLMDGridChooserDescr;
    if (AFieldType in descr.MainFieldTypes) and
       (AFieldKind in descr.FieldKinds)
    then
    begin
      Result := descr;
      Exit;
    end;
  end;

  for i := 0 to ChooserClassesCompat.Count - 1 do
  begin
    descr := ChooserClassesCompat[i] as TLMDGridChooserDescr;
    if (AFieldType in descr.CompatibleFieldTypes) and
       (AFieldKind in descr.FieldKinds)
    then
    begin
      Result := descr;
      Exit;
    end;
  end;

  Result := GetRegisteredChooserClass(TLMDGridCustomChooser);
end;

class function TLMDGridColumnChooser.GetRegisteredChooserClass(
  AIndex: Integer): TLMDGridChooserDescr;
begin
  Result := ChooserClasses[AIndex] as TLMDGridChooserDescr;
end;

class procedure TLMDGridColumnChooser.RegisterChooserClass(
  AChooserClass: TLMDGridColumnChooserClass; AChooserName: string;
  ADescription: TLMDString; AImage: TBitmap; AMainFieldTypes: TLMDGridFieldTypes;
  AMainPriority: Integer; ACompatibleFieldTypes: TLMDGridFieldTypes;
  ACompatiblePriority: Integer; AFieldKinds: TLMDGridFieldKinds;
  APaintStyle: TLMDGridChooserBtnStyle);
var
  descr, d: TLMDGridChooserDescr;
  i:        Integer;
  found:    Boolean;
begin
  for i := 0 to ChooserClasses.Count - 1 do
    with TLMDGridChooserDescr(ChooserClasses[i]) do
      if (ChooserClass = AChooserClass) or (ChooserName = AChooserName) then
        raise ELMDGridError.Create(SLMDGridDuplicateChooserClass);

  descr := TLMDGridChooserDescr.Create;

  descr.ChooserClass := AChooserClass;
  descr.ChooserName := AChooserName;
  descr.Description := ADescription;
  descr.MainFieldTypes := AMainFieldTypes;
  descr.MainPriority := AMainPriority;
  descr.CompatibleFieldTypes := ACompatibleFieldTypes;
  descr.CompatiblePriority := ACompatiblePriority;

  descr.FieldKinds := AFieldKinds;
  descr.PaintStyle := APaintStyle;


  if AImage <> nil then
  begin
    descr.Image := TBitmap.Create;
    descr.Image.Assign(AImage);
  end
  else
    descr.Image := nil;

  ChooserClasses.Add(descr);

  found := False;
  if descr.MainFieldTypes <> [] then
  begin
    for i := 0 to ChooserClassesMain.Count - 1 do
    begin
      d := TLMDGridChooserDescr(ChooserClassesMain[i]);
      found := d.MainPriority < descr.MainPriority;
      if found then
      begin
        ChooserClassesMain.Insert(i, descr);
        Break;
      end;
    end;

    if not found then
      ChooserClassesMain.Add(descr);
  end;

  if descr.CompatibleFieldTypes <> [] then
  begin
    for i := 0 to ChooserClassesCompat.Count - 1 do
    begin
      d := TLMDGridChooserDescr(ChooserClassesCompat[i]);
      found := d.CompatiblePriority < descr.CompatiblePriority;
      if found then
      begin
        ChooserClassesCompat.Insert(i, descr);
        Break;
      end;
    end;

    if not found then
      ChooserClassesCompat.Add(descr);
  end;
end;

class function TLMDGridColumnChooser.RegisteredChooserClassesCount: Integer;
begin
  Result := ChooserClasses.Count;
end;

procedure TLMDGridColumnChooser.SetButtonImage(const Value: TBitmap);
begin
  if Value = FButtonImage then
    Exit;

  if Value = nil then
  begin
    FButtonImage.Height := 0;
    FButtonImage.Width := 0;
  end
  else
    FButtonImage.Assign(Value);

  ColumnNotifyPropChanged;
end;

procedure TLMDGridColumnChooser.SetControlParent(AParent: TWinControl);
begin
  // Do nothing.
end;

procedure TLMDGridColumnChooser.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    ColumnNotifyPropChanged;
  end;
end;

procedure TLMDGridColumnChooser.SetValid(AValue: Boolean);
begin
  FValid := AValue;
end;

procedure TLMDGridColumnChooser.CheckCol;
begin
  Assert((FColumn <> nil) and (FColumn.FGrid <> nil));
end;

procedure TLMDGridColumnChooser.ColumnNotifyPropChanged;
begin
  FColumn.ChooserPropChanged;
end;

function TLMDGridColumnChooser.CanResize: Boolean;
begin
  Result := True;
end;

//== TLMDGridPickListChooser ===================================================

function TLMDGridPickListChooser.CalkHeight: Integer;
var
  cnt:     Integer;
  borderH: Integer;
begin
  borderH := FView.Height - FView.ClientHeight;

  cnt := Max(Min(FDropDownCount, FItems.Count), 3);
  Result := FItemHeight * cnt + borderH;
end;

constructor TLMDGridPickListChooser.Create(AOwner: TComponent);
begin
  inherited;

  FDropDownCount := 7;
  FItems         := TStringList.Create;
  FItemHeight    := 18;
end;

destructor TLMDGridPickListChooser.Destroy;
begin
  FreeAndNil(FView);
  FreeAndNil(FItems);

  inherited;
end;

function TLMDGridPickListChooser.GetControlSize: TSize;
begin
  Assert(FView <> nil);

  Result.cy := CalkHeight;
  Result.cx := FDefWidth;
end;

function TLMDGridPickListChooser.GetChooserKind: TLMDGridChooserKind;
begin
  Result := ckControl;
end;

function TLMDGridPickListChooser.GetData(var AKey, AValue: Variant): Boolean;
var
  s: TLMDString;
  v: Variant;
begin
  Assert(FColumn <> nil);

  Result := FView.ItemIndex <> -1;
  if Result then
  begin
    s := FItems[FView.ItemIndex];
    v := s;

    Result := FColumn.ParseEditorData(v, False, nil, AValue);
    if Result then
      AKey := Null;
  end;
end;

function TLMDGridPickListChooser.GetLayout: TLMDGridChooserLayout;
begin
  Result := clUnderEdit;
end;

procedure TLMDGridPickListChooser.PaintItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
  v:      Variant;
  s:      string;
  ok:     Boolean;
  cnv:    TCanvas;
  cellSt: TLMDGridCellStates;
  rt:     TRect;
  grid:   TLMDCustomGrid;
begin
  s    := FItems[Index];
  grid := FColumn.Grid;

  cnv := TPopupListBox(Control).Canvas;
  ok  := FColumn.ParseEditorData(s, False, nil, v);
  if ok then
    s := FColumn.FormatEditorData(v);

  if ok then
    cellSt := []
  else
    cellSt := [csInvalidValue];

  if odSelected in State then
  begin
    cellSt          := cellSt + [csInSelectedArea];
    cnv.Brush.Color := grid.GetStyledColor(grid.Style.SelectedCellBgColor);
    cnv.Font.Color  := grid.GetStyledColor(grid.Style.SelectedCellTextColor);
  end
  else
  begin
    cnv.Brush.Color := grid.GetStyledColor(grid.Style.CellBgColor);
    cnv.Font.Color  := grid.GetStyledColor(FColumn.Font.Color);
  end;

  cnv.FillRect(ARect);

  rt := ARect;
  InflateRect(rt, -1, -1);

  FColumn.PaintFormattedCellData(cnv, rt, s, Classes.taLeftJustify, cellSt);
end;

procedure TLMDGridPickListChooser.SetBounds(ARect: TRect);
begin
  FView.BoundsRect := ARect;
end;

procedure TLMDGridPickListChooser.SetControlParent(AParent: TWinControl);
begin
  CheckCol;

  if AParent <> nil then
  begin
    FView := TPopupListBox.Create(AParent.Owner,
                                  FColumn.Grid.FEditHelper);

    TPopupListBox(FView).OnDrawItem := PaintItem;
    TPopupListBox(FView).ItemHeight := FItemHeight;
    FView.Align                     := alClient;
    FView.Visible                   := True;
    FDefWidth                       := FView.Width;
    FView.Parent                    := AParent;
    TPopupListBox(FView).Style      := lbVirtualOwnerDraw;
    FView.Count                     := FItems.Count;
  end
  else
  begin
    FView.Parent := nil;
    FreeAndNil(FView);
  end;
end;

procedure TLMDGridPickListChooser.SetData(const AKey, AValue: Variant);
var
  s: string;
  v: Variant;
  i: Integer;
begin
  Assert(FColumn <> nil);
  FView.ItemIndex := -1;

  for i := 0 to FItems.Count - 1 do
  begin
    s := FItems[i];

    if FColumn.ParseEditorData(s, False, nil, v) then
    begin
      if FColumn.CompareColValues(@v, @AValue) = 0 then
      begin
        FView.ItemIndex := i;
        Break;
      end;
    end;
  end;
end;

procedure TLMDGridPickListChooser.SetDropDownCount(const Value: Integer);
begin
  if Value = FDropDownCount then
    Exit;

  FDropDownCount := Value;
  ColumnNotifyPropChanged;
end;

procedure TLMDGridPickListChooser.SetFocus;
begin
  Assert(FView.HandleAllocated);
  Windows.SetFocus(FView.Handle);
end;

procedure TLMDGridPickListChooser.SetItemHeight(const Value: Integer);
begin
  if Value = FItemHeight then
    Exit;

  FItemHeight := Value;
  ColumnNotifyPropChanged;
end;

procedure TLMDGridPickListChooser.SetItems(const Value: TStrings);
begin
  if (Value = nil) or (Value = FItems) then
    Exit;

  FItems.Assign(Value);
  ColumnNotifyPropChanged;
end;

//== TLMDGridCustomChooser =====================================================

constructor TLMDGridCustomChooser.Create(AOwner: TComponent);
begin
  inherited;
  FEnabled := False;
end;

destructor TLMDGridCustomChooser.Destroy;
begin
  inherited Destroy;
end;

function TLMDGridCustomChooser.GetChooserKind: TLMDGridChooserKind;
begin
  Result := ckModalDialog;
end;

function TLMDGridCustomChooser.GetData(var AKey, AValue: Variant): Boolean;
begin
  Result := FColumn.ParseEditorData(FValue, False, nil, AValue);
end;

procedure TLMDGridCustomChooser.SetChooserShow(
  const Value: TLMDGridChooserGetValueEvent);
begin
  FChooserShow := Value;
  ColumnNotifyPropChanged;
end;

procedure TLMDGridCustomChooser.SetData(const AKey, AValue: Variant);
begin
  FValue := AValue;
end;

procedure TLMDGridCustomChooser.SetFocus;
begin
  // Do nothing.
end;

function TLMDGridCustomChooser.ShowModal: Boolean;
begin
  Result := Assigned(FChooserShow);
  if Result then
    FChooserShow(FColumn.FGrid, FColumn, FValue, Result);
end;

//== TLMDGridCalendarChooser ===================================================

constructor TLMDGridCalendarChooser.Create(AOwner: TComponent);
begin
  inherited;

  FDefWidth        := 0;
  FDefHeight       := 0;
  FCalendar        := nil;
  FHeaderColor     := $00F2CEB4;
  FHeaderTextColor := clWindowText;
end;

function TLMDGridCalendarChooser.CreateCalendar(
  AParent: TWinControl): TLMDCustomCalendar;
var
  grid: TLMDCustomGrid;
  pc:   TPopupCalendar;
begin
  grid       := FColumn.Grid;
  FDefWidth  := 200;
  FDefHeight := 150;
  pc         := TPopupCalendar.Create(AParent.Owner, grid.FEditHelper);
  try
    pc.Align     := alClient;
    pc.Parent    := AParent;

    pc.CtlXP                                      := True;
    pc.Color                                      := grid.GetStyledColor(clWindow);
    pc.Bevel.StandardStyle                        := lsNone;
    pc.GridPen.Style                              := psClear;
    pc.CellStyle.Font.Color                       := grid.GetStyledColor(clWindowText);
    pc.SelectedCellStyle.FillObject.Style         := sfBrush;
    pc.SelectedCellStyle.FillObject.Brush.Color   := grid.GetStyledColor(clHighlight);
    pc.SelectedCellStyle.Font.Color               := grid.GetStyledColor(clHighlightText);
    pc.DayCaptionCellStyle.FillObject.Style       := sfBrush;
    pc.DayCaptionCellStyle.FillObject.Brush.Color := grid.GetStyledColor(clBtnFace);
    pc.DayCaptionCellStyle.Font.Color             := grid.GetStyledColor(clBtnText);
    pc.DayCaptionCellStyle.Bevel.StandardStyle    := lsNone;
    pc.InactiveCellStyle.Font.Color               := grid.GetStyledColor(clGrayText);
    pc.Header.ButtonStyle                         := ubsFlat;
    pc.Header.Elements                            := [heMonthBtns, heMonthName, heYear];
    pc.Header.Style.FillObject.Style              := sfBrush;
    pc.Header.Style.FillObject.Brush.Color        := grid.GetStyledColor(FHeaderColor);
    pc.Header.Style.Font.Color                    := grid.GetStyledColor(FHeaderTextColor);
  except
    pc.Free;
    raise;
  end;
  Result := pc;
end;

destructor TLMDGridCalendarChooser.Destroy;
begin
  FreeAndNil(FCalendar);
  inherited;
end;

function TLMDGridCalendarChooser.GetChooserKind: TLMDGridChooserKind;
begin
  Result := ckControl;
end;

function TLMDGridCalendarChooser.GetControlSize: TSize;
begin
  Result.cx := FDefWidth;
  Result.cy := FDefHeight;
end;

function TLMDGridCalendarChooser.GetData(var AKey, AValue: Variant): Boolean;
begin
  AKey   := Null;
  AValue := FCalendar.Date;
  Result := True;
end;

function TLMDGridCalendarChooser.GetLayout: TLMDGridChooserLayout;
begin
  Result := clUnderCell;
end;

function TLMDGridCalendarChooser.NeedOkButton: Boolean;
begin
  Result := False;
end;

procedure TLMDGridCalendarChooser.SetBounds(ARect: TRect);
begin
  FCalendar.BoundsRect := ARect;
end;

procedure TLMDGridCalendarChooser.SetControlParent(AParent: TWinControl);
begin
  CheckCol;

  if AParent <> nil then
    FCalendar := CreateCalendar(AParent)
  else
  begin
    FCalendar.Parent := nil;
    FreeAndNil(FCalendar);
  end;
end;

procedure TLMDGridCalendarChooser.SetData(const AKey, AValue: Variant);
var
  valTS:       TTimeStamp;
  zeroTS:      TTimeStamp;
  zeroD, valD: TDateTime;
  ok:          Boolean;
begin
  if IsVarEmpty(@AValue) then
    FCalendar.Date := Now
  else
  begin
    if VarIsStr(AValue) then
      ok := TryStrToDateTime(AValue, valD)
    else
    begin
      valD := AValue;
      ok   := True;
    end;

    if ok then
    begin
      zeroD  := Time;
      valTS  := DateTimeToTimeStamp(valD);
      zeroTS := DateTimeToTimeStamp(zeroD);

      if valTS.Date = zeroTS.Date then
        FCalendar.Date := Now
      else
        FCalendar.Date := valD;
    end
    else
      FCalendar.Date := Now
  end;
end;

procedure TLMDGridCalendarChooser.SetFocus;
begin
  Windows.SetFocus(FCalendar.Handle);
end;

procedure TLMDGridCalendarChooser.SetHeaderColor(const Value: TColor);
begin
  if FHeaderColor <> Value then
  begin
    FHeaderColor := Value;
    ColumnNotifyPropChanged;
  end;
end;

procedure TLMDGridCalendarChooser.SetHeaderTextColor(const Value: TColor);
begin
  if FHeaderTextColor <> Value then
  begin
    FHeaderTextColor := Value;
    ColumnNotifyPropChanged;
  end;
end;

//== TPopupPanel ===============================================================

procedure TPopupPanel.WMActivate(var Message: TWMActivate);
begin
  if Message.Active <> WA_INACTIVE then
    SendMessage(Message.ActiveWindow, WM_NCACTIVATE, WPARAM(True), 0);
  inherited;
end;

procedure TPopupPanel.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  GetParentForm(Self).SetFocusedControl(FEditPanel.Grid);
end;

procedure TPopupPanel.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := WS_POPUP;
end;

destructor TPopupPanel.Destroy;
var
  b: TMsgDlgBtn;
begin
  for b := Low(b) to High(b) do
    FreeAndNil(FButtons[b]);
  inherited;
end;

procedure TPopupPanel.AlignControls(AControl: TControl; var ARect: TRect);
var
  i: Integer;
  b: TMsgDlgBtn;

  function GetW(ABtn: TLMDSpeedButton): Integer;
  var
    w, borders: Integer;
  begin
    if HandleAllocated then
    begin
      borders := ABtn.Width - ABtn.ClientWidth;

      Canvas.Font.Assign(ABtn.Font);
      w := Canvas.TextWidth(ABtn.Caption) + FButtonPad;
      Inc(w, borders + FButtonPad * 2);
    end
    else
      w := FButtons[b].Width;

    Result := w;
  end;

  procedure DoAlign(AContr: TControl);
  var
    wOk, wCancel: Integer;
    r:            TRect;
  begin
    if AContr is TLMDSpeedButton then
    begin
      r := ARect;
      Dec(r.Right,  FButtonPad);
      Dec(r.Bottom, FButtonPad);

      r.Top := r.Bottom - FButtonHeight;
      b     := Low(b);

      while b <= High(b) do
      begin
        if FButtons[b] = AContr then
          Break
        else
          Inc(b);
      end;
      Assert(b <= High(b));

      wOk     := GetW(FButtons[mbOK]);
      wCancel := GetW(FButtons[mbCancel]);

      case b of
        mbOK:
        begin
          r.Left  := r.Right - wOk - wCancel - FButtonPad;
          r.Right := r.Left + wOk;
        end;
        mbCancel:
        begin
          r.Left  := r.Right - wCancel;
          r.Right := r.Left + wCancel;
        end;
      end;

      AContr.SetBounds(r.Left, r.Top, r.Right - r.Left, r.Bottom - r.Top);
    end
    else
      AContr.SetBounds(ARect.Left, ARect.Top, ARect.Right,
                       ARect.Bottom - FButtonHeight - 2 * FButtonPad);
  end;

begin
  if ControlCount > 1 then
  begin
    for i := 0 to ControlCount - 1 do
      DoAlign(Controls[i]);
  end
  else
    inherited;
end;

constructor TPopupPanel.Create(AOwner: TComponent;
  AEditPanel: TEditPanel; ABtns: TMsgDlgButtons;
  AOkEvent, ACancelEvent: TNotifyEvent);
var
  b: TMsgDlgBtn;
begin
  inherited Create(AOwner);

  ControlStyle  := ControlStyle - [csAcceptsControls];
  BevelInner    := Low(TBevelCut);
  BevelOuter    := Low(TBevelCut);
  BevelKind     := bkFlat;
  FButtonsSet   := ABtns;
  FEditPanel    := AEditPanel;
  FButtonHeight := 0;
  FButtonPad    := 3;

  for b := Low(b) to High(b) do
  begin
    if b in ABtns then
    begin
      FButtons[b] := TLMDSpeedButton.Create(nil);

      case b of
        mbOK:
        begin
          FButtons[b].Caption := SLMDGridChooserOkCaption;
          FButtons[b].OnClick := AOkEvent;
        end;
        mbCancel:
        begin
          FButtons[b].Caption := SLMDGridChooserCancelCaption;
          FButtons[b].OnClick := ACancelEvent;
        end;
      end;

      FButtons[b].ButtonStyle     := ubsFlat;
      FButtons[b].ThemeMode       := FEditPanel.Grid.ThemeMode;
      FButtons[b].ThemeGlobalMode := FEditPanel.Grid.ThemeGlobalMode;
      FButtons[b].Visible         := True;
      FButtons[b].Parent          := Self;
      FButtonHeight               := FButtons[b].Height;
    end;
  end;

  if FButtonHeight = 0 then
    FButtonPad := 0;
end;

//== TPopupCalendar ============================================================

procedure TPopupPanel.WMNCActivate(var Message: TWMNCActivate);
begin
  if not Message.Active then
    FEditPanel.FGrid.HidePopupChooserDelayed;
  inherited;
end;

//== TPopupCalendar ============================================================

constructor TPopupCalendar.Create(AOwner: TComponent;
  AGrid: TLMDGridEditParentHelper);
begin
  inherited Create(AOwner);

  FGrid           := AGrid;
  Color           := clWindow;
  ThemeMode       := FGrid.AsControl.ThemeMode;
  ThemeGlobalMode := FGrid.AsControl.ThemeGlobalMode;
end;

procedure TPopupCalendar.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then // Report change before hiding.
    FGrid.EditorChanged;  //

  FGrid.KeyDownPreprocess(Key, Shift, psChooser);
  if Key <> 0 then
    inherited KeyDown(Key, Shift);
end;

procedure TPopupCalendar.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  FIsDayClick := (ssLeft in Shift) and (DayAtPos(X, Y) > 0);
end;

procedure TPopupCalendar.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  key: Word;
begin
  inherited;

  if FIsDayClick then
  begin
    key := VK_RETURN;
    KeyDown(key, []);
  end;
end;

procedure TPopupCalendar.WMActivate(var Message: TWMActivate);
begin
  inherited;
  if Message.Active <> WA_INACTIVE then
    SendMessage(Message.ActiveWindow, WM_NCACTIVATE, WPARAM(True), 0);
end;

procedure TPopupCalendar.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  GetParentForm(Self).SetFocusedControl(FGrid.AsControl);
end;

//== TPopupListBox =============================================================

procedure TPopupListBox.CNDrawItem(var Message: TWMDrawItem);
begin
  with Message.DrawItemStruct^ do             // No focus rect.
    itemState := itemState and not ODS_FOCUS; //
  inherited;
end;

constructor TPopupListBox.Create(AOwner: TComponent;
  AGrid: TLMDGridEditParentHelper);
begin
  inherited Create(AOwner);
  FGrid       := AGrid;
  BorderStyle := bsNone;
end;

procedure TPopupListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then // Report change before hiding.
    FGrid.EditorChanged;  //

  FGrid.KeyDownPreprocess(Key, Shift, psChooser);
  if Key <> 0 then
    inherited KeyDown(Key, Shift);
end;

procedure TPopupListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  FItemClicked := (ssLeft in Shift) and (ItemAtPos(Point(X, Y), True) <> -1);
end;

procedure TPopupListBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  key: Word;
begin
  inherited;

  if FItemClicked then
  begin
    key := VK_RETURN;
    KeyDown(key, []);
  end;
end;

procedure TPopupListBox.WMActivate(var Message: TWMActivate);
begin
  inherited;

  if Message.Active <> WA_INACTIVE then
    SendMessage(Message.ActiveWindow, WM_NCACTIVATE, WPARAM(True), 0);
end;

procedure TPopupListBox.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  GetParentForm(Self).SetFocusedControl(FGrid.AsControl);
end;

//== TChooserButton ============================================================

constructor TChooserButton.Create(AOwner: TComponent);
begin
  inherited;

  Height := 20;
  Width := 19;
  Flat := True;
  Margin := -1;
  Spacing := 1;
  Transparent := True;
  Layout := blGlyphLeft;
  NumGlyphs := 1;
end;

procedure TChooserButton.Paint;
var
  r: TRect;
begin
  if Style <> bsBitmap then
  begin
    r := ClientRect;
    PaintThemedBtnBmp(Style, Canvas, ThemeMode, Enabled, MouseInControl,
                      FState = bsDown, r);
  end
  else
    inherited;
end;

//== TLMDGridCustomStore =======================================================

procedure TLMDGridCustomSource.ColumnAdded(ACol: TLMDGridColumn);
begin
  // Do nothing.
end;

procedure TLMDGridCustomSource.ColumnDeleting(ACol: TLMDGridColumn);
begin
  // Do nothing.
end;

procedure TLMDGridCustomSource.ColumnMoved(ACol: TLMDGridColumn;
  AMoveTo: Integer);
begin
  // Do nothing.
end;

procedure TLMDGridCustomSource.DeleteRow(ARow: Integer; var CorrIndex: Integer);
begin
  // Do nothing.
end;

function TLMDGridCustomSource.GetDataCell(ACol, ARow: Integer): Variant;
begin
  Result := Null;
end;

function TLMDGridCustomSource.GetProps: TLMDGridCustomSourceProps;
begin
  Result := [];
end;

procedure TLMDGridCustomSource.InsertRow(ADest: Integer);
begin
  // Do nothing.
end;

procedure TLMDGridCustomSource.MoveRow(ASrc, ADest: Integer);
begin
  // Do nothing.
end;

function TLMDGridCustomSource.RowCount: Integer;
begin
  Result := 0;
end;

procedure TLMDGridCustomSource.SetDataCell(ACol, ARow: Integer;
  const Value: Variant; ABlockSort: Boolean; out NewRow: Integer);
begin
  NewRow := ARow;
end;

procedure TLMDGridCustomSource.SetRowCount(ACount: Integer;
  var CorrIndex: Integer);
begin
  // Do nothing.
end;

procedure TLMDGridCustomSource.Sort(ACol: TLMDGridColumn;
  AKind: TLMDGridSortKind; var CorrIndex: Integer);
begin
  // Do nothing.
end;

procedure TLMDGridCustomSource.UpdateSort(var CorrIndex: Integer);
begin
  // Do nothing.
end;

//== TLMDGridCalculatorChooser =================================================

function TLMDGridCalculatorChooser.CanResize: Boolean;
begin
  Result := False;
end;

constructor TLMDGridCalculatorChooser.Create(AOwner: TComponent);
begin
  inherited;

  FDigits       := 5;
  FPrecision    := 5;
  FCalculator   := nil;
  FDisplayColor := $00F2CEB4;
end;

function TLMDGridCalculatorChooser.CreateCalculator(
  AParent: TWinControl): TLMDCustomCalculator;
var
  pc: TPopupCalculator;
begin
  pc := TPopupCalculator.Create(AParent.Owner, FColumn.Grid.FEditHelper);
  try
    FDefWidth     := pc.Width;
    FDefHeight    := pc.Height;

    pc.Align  := alClient;
    pc.CtlXP  := True;
    pc.Parent := AParent;

    pc.Decimals              := FDigits;
    pc.Precision             := FPrecision;
    pc.Bevel.Mode            := bmStandard;
    pc.Bevel.StandardStyle   := lsNone;
    pc.ButtonStyle           := ubsFlat;
    pc.DisplaySettings.Color := FDisplayColor;
  except
    pc.Free;
    raise;
  end;
  Result := pc;
end;

destructor TLMDGridCalculatorChooser.Destroy;
begin
  FreeAndNil(FCalculator);
  inherited;
end;

function TLMDGridCalculatorChooser.GetChooserKind: TLMDGridChooserKind;
begin
  Result := ckControl;
end;

function TLMDGridCalculatorChooser.GetControlSize: TSize;
begin
  Result.cx := FDefWidth;
  Result.cy := FDefHeight;
end;

function TLMDGridCalculatorChooser.GetData(var AKey, AValue: Variant): Boolean;
begin
  AKey   := Null;
  AValue := TLMDCalcAccess(FCalculator).Value;
  Result := True;
end;

function TLMDGridCalculatorChooser.GetLayout: TLMDGridChooserLayout;
begin
  Result := clUnderCell;
end;

function TLMDGridCalculatorChooser.NeedOkButton: Boolean;
begin
  Result := True;
end;

procedure TLMDGridCalculatorChooser.SetBounds(ARect: TRect);
begin
  FCalculator.BoundsRect := ARect;
end;

procedure TLMDGridCalculatorChooser.SetControlParent(AParent: TWinControl);
begin
  CheckCol;

  if AParent <> nil then
    FCalculator := CreateCalculator(AParent)
  else
  begin
    FCalculator.Parent := nil;
    FreeAndNil(FCalculator);
  end;
end;

procedure TLMDGridCalculatorChooser.SetData(const AKey, AValue: Variant);
var
  s:  string;
  d:  Double;
  ok: Boolean;
begin
  if IsVarEmpty(@AValue) then
    TLMDCalcAccess(FCalculator).Value := 0
  else
  begin
    if VarIsStr(AValue) then
      ok := TryStrToFloat(AValue, d)
    else
      ok := True;

    if ok then
    begin
      s := SysUtils.FloatToStrF(AValue, ffGeneral, Precision, Digits);
      d := StrToFloat(s);
      TLMDCalcAccess(FCalculator).Value := d;
    end;
  end;
end;

procedure TLMDGridCalculatorChooser.SetDigits(const Value: Integer);
begin
  if Value = FDigits then
    Exit;

  FDigits := Max(1, Value);
  ColumnNotifyPropChanged;
end;

procedure TLMDGridCalculatorChooser.SetDisplayColor(const Value: TColor);
begin
  if FDisplayColor <> Value then
  begin
    FDisplayColor := Value;
    ColumnNotifyPropChanged;
  end;
end;

procedure TLMDGridCalculatorChooser.SetFocus;
begin
  Windows.SetFocus(FCalculator.Handle);
end;

procedure TLMDGridCalculatorChooser.SetPrecision(const Value: Integer);
begin
  if Value = FPrecision then
    Exit;

  FPrecision := Max(1, Value);
  ColumnNotifyPropChanged;
end;

//== TLMDGridMemoChooser =======================================================

function TLMDGridMemoChooser.CanResize: Boolean;
begin
  Result := True;
end;

constructor TLMDGridMemoChooser.Create(AOwner: TComponent);
begin
  inherited;

  FWantTabs := True;
  FWantReturns := True;

  FMemo := nil;
end;

function TLMDGridMemoChooser.CreateMemo(AParent: TWinControl): TCustomMemo;
begin
  Result := TPopupMemo.Create(AParent.Owner, FWantTabs, FWantReturns,
                              FColumn.Grid.FEditHelper);

  FDefWidth := 150;
  FDefHeight := 100;

  Result.Align  := alClient;
  TPopupMemo(Result).BorderStyle := bsNone;
  Result.Parent := AParent;
end;

destructor TLMDGridMemoChooser.Destroy;
begin
  FreeAndNil(FMemo);
  inherited;
end;

function TLMDGridMemoChooser.GetChooserKind: TLMDGridChooserKind;
begin
  Result := ckControl;
end;

function TLMDGridMemoChooser.GetControlSize: TSize;
begin
  Result.cx := FDefWidth;
  Result.cy := FDefHeight;
end;

function TLMDGridMemoChooser.GetData(var AKey, AValue: Variant): Boolean;
begin
  AKey  := Null;
  AValue := FMemo.Text;
  Result := True;
end;

function TLMDGridMemoChooser.GetLayout: TLMDGridChooserLayout;
begin
  Result := clUnderCell;
end;

function TLMDGridMemoChooser.NeedOkButton: Boolean;
begin
  Result := True;
end;

procedure TLMDGridMemoChooser.SetBounds(ARect: TRect);
begin
  FMemo.BoundsRect := ARect;
end;

procedure TLMDGridMemoChooser.SetControlParent(AParent: TWinControl);
begin
  CheckCol;

  if AParent <> nil then
    FMemo := CreateMemo(AParent)
  else
  begin
    FMemo.Parent := nil;
    FreeAndNil(FMemo);
  end;
end;

procedure TLMDGridMemoChooser.SetData(const AKey, AValue: Variant);
begin
  if IsVarEmpty(@AValue) then
    FMemo.Text := ''
  else
    FMemo.Lines.Text := AValue;
end;

procedure TLMDGridMemoChooser.SetFocus;
begin
  Windows.SetFocus(FMemo.Handle);
end;

//== TPopupCalculator ==========================================================

constructor TPopupCalculator.Create(AOwner: TComponent;
  AGrid: TLMDGridEditParentHelper);
begin
  inherited Create(AOwner);

  FGrid           := AGrid;
  Color           := clWindow;
  ThemeMode       := FGrid.AsControl.ThemeMode;
  ThemeGlobalMode := FGrid.AsControl.ThemeGlobalMode;
end;

procedure TPopupCalculator.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FGrid.KeyDownPreprocess(Key, Shift, psChooser);
  if Key <> 0 then
    inherited KeyDown(Key, Shift);
end;

procedure TPopupCalculator.WMActivate(var Message: TWMActivate);
begin
  inherited;

  if Message.Active <> WA_INACTIVE then
    SendMessage(Message.ActiveWindow, WM_NCACTIVATE, WPARAM(True), 0);
end;

procedure TPopupCalculator.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  GetParentForm(Self).SetFocusedControl(FGrid.AsControl);
end;

//== TPopupMemo ================================================================

constructor TPopupMemo.Create(AOwner: TComponent; AWantTabs,
  AWantReturns: Boolean; AGrid: TLMDGridEditParentHelper);
begin
  inherited Create(AOwner);

  FWantTabs := AWantTabs;
  FWantReturns := AWantReturns;

  inherited WantTabs := FWantTabs;
  inherited WantReturns := FWantReturns;

  FGrid := AGrid;
end;

procedure TPopupMemo.KeyDown(var Key: Word; Shift: TShiftState);
var
  preprocess: Boolean;
begin
  preprocess := (not (Key in [VK_TAB, VK_RETURN])) or
                ((Key = VK_TAB) and (not FWantTabs)) or
                ((Key = VK_RETURN) and (not FWantReturns));

  if preprocess then
    FGrid.KeyDownPreprocess(Key, Shift, psChooser);

  if Key <> 0 then
    inherited KeyDown(Key, Shift);
end;

procedure TPopupMemo.WMActivate(var Message: TWMActivate);
begin
  inherited;

  if Message.Active <> WA_INACTIVE then
    SendMessage(Message.ActiveWindow, WM_NCACTIVATE, WPARAM(True), 0);
end;

procedure TPopupMemo.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  GetParentForm(Self).SetFocusedControl(FGrid.AsControl);
end;

//== TLMDGridColumnDescr =======================================================

destructor TLMDGridColumnDescr.Destroy;
begin
  FreeAndNil(Image);
  inherited;
end;

//== TLMDGridChooserDescr ======================================================

destructor TLMDGridChooserDescr.Destroy;
begin
  FreeAndNil(Image);
  inherited;
end;

//== TChooserDsgHelper =========================================================

constructor TChooserDsgHelper.Create(AColumn: TLMDGridColumn);
begin
  FColumn := AColumn;
  FColl := TCollectionDsgHelper.Create(Self);
  FColl.Add;
end;

destructor TChooserDsgHelper.Destroy;
begin
  FreeAndNil(FColl);
end;

//== TCollectionDsgHelperItem ==================================================

function TCollectionDsgHelperItem.GetChooser: TPersistent;
begin
  Result := (Collection as TCollectionDsgHelper).FParent.FColumn.Chooser;
end;

//== TCollectionDsgHelper ======================================================

constructor TCollectionDsgHelper.Create(AParent: TChooserDsgHelper);
begin
  inherited Create(TCollectionDsgHelperItem);
  FParent := AParent;
end;

//== Initialization ============================================================

{ TLMDGridImageColumn }

function TLMDGridImageColumn.CompareColValues(Val1, Val2: PVariant): Integer;
begin
  Result := VarToIntDef(Val1) - VarToIntDef(Val2);
end;

constructor TLMDGridImageColumn.Create(AOwner: TComponent);
begin
  FDefaultDataType := ftInteger;
  inherited;

  FEditor          := TEmbeddedImage.Create(Self);
  FEmptyImageIndex := -1;
  Alignment        := Classes.taCenter;
end;

destructor TLMDGridImageColumn.Destroy;
begin
  Images := nil;
  inherited;
end;

function TLMDGridImageColumn.GetEmbeddedEditor: ILMDGridEmbeddedEdit;
begin
  Result := FEditor as TEmbeddedImage;
end;

procedure TLMDGridImageColumn.NormalizeValue(ASrcValue, ADestValue: PVariant);
var
  i: Integer;
begin
  if IsVarEmpty(ASrcValue) then
    ADestValue^ := ASrcValue^
  else
  begin
    i           := ASrcValue^;
    ADestValue^ := i;
  end;
end;

procedure TLMDGridImageColumn.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FImages) then
    Images := nil;
end;

procedure TLMDGridImageColumn.PaintFormattedCellData(ACanvas: TCanvas;
  ARect: TRect; const AData: Variant; AAlignment: TAlignment;
  ACellState: TLMDGridCellStates);
var
  idx: Integer;
  p:   TPoint;
begin
  if FImages = nil then
    idx := -1
  else if IsVarEmpty(@AData) then
    idx := FEmptyImageIndex
  else
    idx := AData;

  if (idx < 0) or (idx >= FImages.Count) then
    Exit;

  case AAlignment of
    Classes.taLeftJustify:  p.X := ARect.Left;
    Classes.taRightJustify: p.X := ARect.Right - FImages.Width;
    Classes.taCenter:       p.X := (ARect.Left + ARect.Right -
                                    FImages.Width) div 2;
  else
    Assert(False);
  end;

  case FVertAlign of
    taAlignTop:       p.Y := ARect.Top;
    taAlignBottom:    p.Y := ARect.Bottom - FImages.Height;
    taVerticalCenter: p.Y := (ARect.Top + ARect.Bottom -
                              FImages.Height) div 2;
  else
    Assert(False);
  end;

  FImages.Draw(ACanvas, p.X, p.Y, idx);
end;

procedure TLMDGridImageColumn.ResetEmbeddedEditor;
begin
  DetachEmbeddedEditor;
  FEditor.Free;
  FEditor := TEmbeddedImage.Create(Self);
end;

procedure TLMDGridImageColumn.SetEmptyImageIndex(const Value: TImageIndex);
begin
  if FEmptyImageIndex <> Value then
  begin
    BeginUpdate;
    FEmptyImageIndex := Value;
    EndUpdate;
  end;
end;

procedure TLMDGridImageColumn.SetImages(const Value: TCustomImageList);
begin
  if FImages <> Value then
  begin
    BeginUpdate;
    FImages := Value;
    EndUpdate;
  end;
end;

function TLMDGridImageColumn.VarToIntDef(V: PVariant): Integer;
begin
  if not IsVarEmpty(V) then
    Result := V^
  else
    Result := -MaxInt div 2;
end;

{ TEmbeddedImage }

function TDefaultEmbeddedEditor.AsControl: TWinControl;
begin
  Result := Self;
end;

function TDefaultEmbeddedEditor.Column: TLMDGridColumn;
begin
  Result := FCol;
end;

constructor TDefaultEmbeddedEditor.Create(ACol: TLMDGridColumn);
begin
  FInitMode := True;
  try
    inherited Create(nil);

    TabStop := False;
    FCol    := ACol;
  finally
    FInitMode := False;
  end;
end;

function TDefaultEmbeddedEditor.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := FGrid.DoMouseWheelDown(Shift);
end;

function TDefaultEmbeddedEditor.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  Result := FGrid.DoMouseWheelUp(Shift);
end;

procedure TDefaultEmbeddedEditor.GetData(var AKey, AValue: Variant);
begin
  AKey   := FKey;
  AValue := FValue;
end;

function TDefaultEmbeddedEditor.GetReadOnly: Boolean;
begin
  Result := True; // Always read-only.
end;

procedure TDefaultEmbeddedEditor.HandleFirstInput(const AInput: TLMDGridFirstInput);
begin
  // Do nothing.
end;

procedure TDefaultEmbeddedEditor.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FGrid.KeyDownPreprocess(Key, Shift, psEdit);
  if Key <> 0 then
    FGrid.KeyDownPostprocess(Key, Shift, psEdit);
end;

procedure TDefaultEmbeddedEditor.Paint;
var
  r:        TRect;
  key, val: Variant;
begin
  FGrid.DrawEditBg(ClientRect, Canvas);

  r := ClientRect;
  Inc(r.Left, FCol.PaddingLeft - 1);
  Inc(r.Top, FCol.PaddingTop - 1);
  Dec(r.Right, FCol.PaddingRight - 1);
  Dec(r.Bottom, FCol.PaddingBottom - 1);

  GetData(key, val);
  FCol.PaintFormattedCellData(Canvas, r, val, FCol.Alignment, []);
end;

procedure TDefaultEmbeddedEditor.SetData(const AKey, AValue: Variant;
  AInitValue: Boolean);
begin
  FKey   := AKey;
  FValue := AValue;

  if (not AInitValue) and (FGrid <> nil) then
  begin
    FGrid.EditorChanged;
    Invalidate;
  end;
end;

procedure TDefaultEmbeddedEditor.SetGrid(AGridHelper: TLMDGridEditParentHelper);
begin
  FGrid := AGridHelper;
end;

procedure TDefaultEmbeddedEditor.SetReadOnly(AValue: Boolean);
begin
  // Do nothing.
end;

procedure TDefaultEmbeddedEditor.SetThemeMode(AThemeMode: TLMDThemeMode;
  AThemeGlobalMode: Boolean);
begin
  // Do nothing.
end;

procedure TDefaultEmbeddedEditor.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;

  FGrid.WMGetDlgCode(Self, Message);
  Message.Result := Message.Result or DLGC_WANTARROWS;
end;

procedure TDefaultEmbeddedEditor.WndProc(var Message: TMessage);
begin
  if (FGrid = nil) or (not FGrid.WndProc(Self, Message)) then
    inherited WndProc(Message);
end;

{ TEmbeddedImage }

function TEmbeddedImage.GetReadOnly: Boolean;
begin
  Result := FReadOnly;
end;

procedure TEmbeddedImage.HandleFirstInput(const AInput: TLMDGridFirstInput);
var
  key: Word;
begin
  case AInput.Kind of
    fikChar:      ; // Do nothing.
    fikMouseDown: ; // Do nothing.
    fikDelPress:  begin
                    key := VK_DELETE;
                    KeyDown(key, []);
                  end;
  end;
end;

procedure TEmbeddedImage.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FGrid.KeyDownPreprocess(Key, Shift, psEdit);

  if (Key = VK_DELETE) and not FReadOnly then
  begin
    Key := 0;
    if FCol.AllowUndefinedValue then
      FValue := Null;
    Invalidate;
    FGrid.EditorChanged;
  end;

  if Key <> 0 then
    FGrid.KeyDownPostprocess(Key, Shift, psEdit);
end;

procedure TEmbeddedImage.SetReadOnly(AValue: Boolean);
begin
  FReadOnly := AValue;
end;

{ TLMDGridRatingColumn }

function TLMDGridRatingColumn.CompareColValues(Val1, Val2: PVariant): Integer;

  function _VarToIntDef(V: PVariant): Integer;
  begin
    if not IsVarEmpty(V) then
      Result := V^
    else
      Result := -MaxInt div 2;
  end;

begin
  Result := _VarToIntDef(Val1) - _VarToIntDef(Val2);
end;

constructor TLMDGridRatingColumn.Create(AOwner: TComponent);
begin
  FDefaultDataType := ftInteger;
  inherited;

  FEditor              := TEmbeddedRating.Create(Self);
  FGlyph               := TPicture.Create;
  FGlyph.OnChange      := GlyphsChanged;
  FEmptyGlyph          := TPicture.Create;
  FEmptyGlyph.OnChange := GlyphsChanged;
  FMaxRating           := 5;
  FTransparent         := True;
end;

destructor TLMDGridRatingColumn.Destroy;
begin
  FGlyph.Free;
  FEmptyGlyph.Free;
  inherited;
end;

function TLMDGridRatingColumn.GetEmbeddedEditor: ILMDGridEmbeddedEdit;
begin
  Result := FEditor as TEmbeddedRating;
end;

procedure TLMDGridRatingColumn.GlyphsChanged(Sender: TObject);
begin
  BeginUpdate;
  UpdateTransparent;
  EndUpdate;
end;

procedure TLMDGridRatingColumn.NormalizeValue(ASrcValue, ADestValue: PVariant);
var
  i: Integer;
begin
  if IsVarEmpty(ASrcValue) then
    ADestValue^ := ASrcValue^
  else
  begin
    i           := ASrcValue^;
    ADestValue^ := i;
  end;
end;

procedure TLMDGridRatingColumn.PaintFormattedCellData(ACanvas: TCanvas;
  ARect: TRect; const AData: Variant; AAlignment: TAlignment;
  ACellState: TLMDGridCellStates);
var
  rtng:   Integer;
  isnull: Boolean;
  wdth:   Integer;
  itmwd:  Integer;
  hght:   Integer;
  p:      TPoint;
  i:      Integer;
begin
  FLastDrawn.Left       := 0;
  FLastDrawn.ItemWidth  := 0;
  FLastDrawn.ItemCount  := 0;
  rtng                  := VarToRating(@AData, isnull);

  if FGlyph.Graphic = nil then
    Exit;
  if isnull then
  begin
    if FAllowUndefinedValue then
      Exit // Nothing to draw.
    else
      rtng := 0;
  end;

  itmwd := Max(FGlyph.Width, FEmptyGlyph.Width);
  wdth  := (rtng + (FMaxRating - rtng) * Ord(FGlyph.Graphic <> nil)) * itmwd;
  hght  := Max(FGlyph.Height, FEmptyGlyph.Height);

  case AAlignment of
    Classes.taLeftJustify:  p.X := ARect.Left;
    Classes.taRightJustify: p.X := ARect.Right - wdth;
    Classes.taCenter:       p.X := (ARect.Left + ARect.Right - wdth) div 2;
  else
    Assert(False);
  end;
  if p.X < ARect.Left + 2 then // Some small space is required to allow
    p.X := ARect.Left + 2;     // to set a zero rating by clicking on it.

  case FVertAlign of
    taAlignTop:       p.Y := ARect.Top;
    taAlignBottom:    p.Y := ARect.Bottom - hght;
    taVerticalCenter: p.Y := (ARect.Top + ARect.Bottom - hght) div 2;
  else
    Assert(False);
  end;

  FLastDrawn.Left       := p.X;
  FLastDrawn.ItemWidth  := itmwd;

  for i := 0 to rtng - 1 do
  begin
    if p.X >= ARect.Right then
      Break; // for

    ACanvas.Draw(p.X, p.Y, FGlyph.Graphic);
    Inc(p.X, itmwd);
    Inc(FLastDrawn.ItemCount);
  end;

  if FEmptyGlyph.Graphic <> nil then
  begin
    for i := rtng to FMaxRating - 1 do
    begin
      if p.X >= ARect.Right then
        Break; // for

      ACanvas.Draw(p.X, p.Y, FEmptyGlyph.Graphic);
      Inc(p.X, itmwd);
      Inc(FLastDrawn.ItemCount);
    end;
  end;
end;

procedure TLMDGridRatingColumn.ResetEmbeddedEditor;
begin
  DetachEmbeddedEditor;
  FEditor.Free;
  FEditor := TEmbeddedRating.Create(Self);
end;

procedure TLMDGridRatingColumn.SetEmptyGlyph(const Value: TPicture);
begin
  FEmptyGlyph.Assign(Value);
end;

procedure TLMDGridRatingColumn.SetGlyph(const Value: TPicture);
begin
  FGlyph.Assign(Value);
end;

procedure TLMDGridRatingColumn.SetMaxRating(const Value: Integer);
begin
  if FMaxRating <> Value then
  begin
    BeginUpdate;
    FMaxRating := Value;
    EndUpdate;
  end;
end;

procedure TLMDGridRatingColumn.SetTransparent(const Value: Boolean);
begin
  if FTransparent<> Value then
  begin
    BeginUpdate;
    FTransparent := Value;
    UpdateTransparent;
    EndUpdate;
  end;
end;

procedure TLMDGridRatingColumn.UpdateTransparent;
begin
  if FGlyph.Graphic <> nil then
    FGlyph.Graphic.Transparent := FTransparent;
  if FEmptyGlyph.Graphic <> nil then
    FEmptyGlyph.Graphic.Transparent := FTransparent;
end;

function TLMDGridRatingColumn.VarToRating(AVar: PVariant;
  out AIsNull: Boolean): Integer;
begin
  if IsVarEmpty(AVar) then
  begin
    AIsNull := True;
    Result  := -1;
  end
  else
  begin
    AIsNull := False;
    Result  := AVar^;

    if Result > FMaxRating then
      Result := FMaxRating;
  end;
end;

{ TEmbeddedRating }

function TEmbeddedRating.GetReadOnly: Boolean;
begin
  Result := FReadOnly;
end;

procedure TEmbeddedRating.HandleFirstInput(const AInput: TLMDGridFirstInput);
var
  p:   TSmallPoint;
  key: Word;
begin
  case AInput.Kind of
    fikChar:      Perform(WM_CHAR, WPARAM(AInput.Char), 0);
    fikMouseDown: if ssLeft in AInput.Shift then
                  begin
                    Update; // At least one painting is required
                            // to calc control's layout.

                    p := PointToSmallPoint(ScreenToClient(AInput.CursorPos));
                    Perform(WM_LBUTTONDOWN, MK_LBUTTON, LPARAM(Integer(p)))
                  end;
    fikDelPress:  begin
                    key := VK_DELETE;
                    KeyDown(key, []);
                  end;
  end;
end;

procedure TEmbeddedRating.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FGrid.KeyDownPreprocess(Key, Shift, psEdit);

  if not GetReadOnly and (Key = VK_DELETE) then
  begin
    Key := 0;
    if FCol.AllowUndefinedValue then
      FValue := Null
    else
      FValue := 0;
    Invalidate;
    FGrid.EditorChanged;
  end;

  if Key <> 0 then
    FGrid.KeyDownPostprocess(Key, Shift, psEdit);
end;

procedure TEmbeddedRating.KeyPress(var Key: Char);
var
  c:    AnsiChar;
  col:  TLMDGridRatingColumn;
  rtng: Integer;
begin
  c   := AnsiChar(Key);
  col := TLMDGridRatingColumn(FCol);

  if c in ['0'..'9'] then
  begin
    rtng := Ord(c) - Ord('0');
    if rtng > col.FMaxRating then
      rtng := col.FMaxRating;

    FValue := rtng;
    Key    := #0;
    Invalidate;
    FGrid.EditorChanged;
  end
  else
    inherited;
end;

procedure TEmbeddedRating.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  col:  TLMDGridRatingColumn;
  rtng: Integer;
begin
  if (ssLeft in Shift) and not GetReadOnly then
  begin
    col := TLMDGridRatingColumn(FCol);

    if FLayout.ItemWidth = 0 then // Not yet drawn, so we have no valid 
    begin                         // layout, try to draw.
      FValue := 0;
      Refresh; // Need immediate window update.
    end;

    if (X < FLayout.Left) or (FLayout.ItemWidth = 0) then
      rtng := 0
    else
    begin
      rtng := 1 + (X - FLayout.Left) div FLayout.ItemWidth;
      if rtng > col.FMaxRating then
        rtng := col.FMaxRating;
    end;

    FValue := rtng;
    Invalidate;
    FGrid.EditorChanged;
  end;

  inherited;
end;

procedure TEmbeddedRating.Paint;
begin
  inherited;
  FLayout := TLMDGridRatingColumn(FCol).FLastDrawn;
end;

procedure TEmbeddedRating.SetReadOnly(AValue: Boolean);
begin
  FReadOnly := AValue;
end;

{ TLMDGridProgressColumn }

function TLMDGridProgressColumn.CompareColValues(Val1, Val2: PVariant): Integer;

  function _VarToIntDef(V: PVariant): Integer;
  begin
    if not IsVarEmpty(V) then
      Result := V^
    else
      Result := -MaxInt div 2;
  end;

begin
  Result := _VarToIntDef(Val1) - _VarToIntDef(Val2);
end;

constructor TLMDGridProgressColumn.Create(AOwner: TComponent);
begin
  FDefaultDataType := ftInteger;
  inherited;

  FEditor         := TEmbeddedProgress.Create(Self);
  FMinValue       := 0;
  FMaxValue       := 100;
  FBarWidth       := -1;
  FBarHeight      := 12;
  FBarColor       := clWindow;
  FBarBorderColor := clBtnShadow;
  FChunkColor     := clHighlight;
  Alignment       := Classes.taCenter;
end;

function TLMDGridProgressColumn.GetEmbeddedEditor: ILMDGridEmbeddedEdit;
begin
  Result := FEditor as TEmbeddedProgress;
end;

procedure TLMDGridProgressColumn.NormalizeValue(ASrcValue,
  ADestValue: PVariant);
var
  i: Integer;
begin
  if IsVarEmpty(ASrcValue) then
    ADestValue^ := ASrcValue^
  else
  begin
    i           := ASrcValue^;
    ADestValue^ := i;
  end;
end;

procedure TLMDGridProgressColumn.PaintFormattedCellData(ACanvas: TCanvas;
  ARect: TRect; const AData: Variant; AAlignment: TAlignment;
  ACellState: TLMDGridCellStates);
var
  val:    Integer;
  isnull: Boolean;
  wdth:   Integer;
  hght:   Integer;
  vwdth:  Integer;
  p:      TPoint;
  dc:     HDC;
  barr:   TRect;
  cntr:   TRect;
  valr:   TRect;
  useTheme: TLMDThemeMode;
begin
  FLastDrawn.Content := Rect(0, 0, 0, 0);
  val                := VarToProgress(@AData, isnull);
  useTheme           := Grid.UseThemeMode;

  if isnull then
  begin
    if FAllowUndefinedValue then
      Exit // Nothing to draw.
    else
      val := FMinValue;
  end;

  wdth := Min(FBarWidth, ARect.Right - ARect.Left);
  hght := Min(FBarHeight, ARect.Bottom - ARect.Top);

  if wdth = -1 then
    wdth := ARect.Right - ARect.Left;
  if hght = -1 then
    hght := ARect.Bottom - ARect.Top;

  case AAlignment of
    Classes.taLeftJustify:  p.X := ARect.Left;
    Classes.taRightJustify: p.X := ARect.Right - wdth;
    Classes.taCenter:       p.X := (ARect.Left + ARect.Right - wdth) div 2;
  else
    Assert(False);
  end;

  case FVertAlign of
    taAlignTop:       p.Y := ARect.Top;
    taAlignBottom:    p.Y := ARect.Bottom - hght;
    taVerticalCenter: p.Y := (ARect.Top + ARect.Bottom - hght) div 2;
  else
    Assert(False);
  end;

  dc   := ACanvas.Handle;
  barr := Rect(p.X, p.Y, p.X + wdth, p.Y + hght);

  if useTheme = ttmNone then
  begin
    cntr := barr;
    InflateRect(cntr, -2, -2);
  end
  else
  begin
    cntr := LMDThemeServices.ContentRect(useTheme, dc, LMDThemeServices.
                                         GetDetails(teProgress, Ord(tpBar)),
                                         barr);
    if IsRectEmpty(cntr) then
    begin
      cntr := barr;
      InflateRect(cntr, -1, -1); // Don't know how to handle...
    end;
  end;

  FLastDrawn.Content := cntr;

  vwdth := MulDiv(val - FMinValue, cntr.Right - cntr.Left,  // Returns -1 in a
                  FMaxValue - FMinValue);                   // zero-div case.
  vwdth := Min(Max(vwdth, 0), cntr.Right - cntr.Left);
  valr  := Rect(cntr.Left, cntr.Top, cntr.Left + vwdth, cntr.Bottom);

  if useTheme = ttmNone then
  begin
    ACanvas.Brush.Color := FBarColor;
    ACanvas.Pen.Color   := FBarBorderColor;
    ACanvas.Rectangle(barr);

    ACanvas.Brush.Color := FChunkColor;
    ACanvas.FillRect(valr);
  end
  else
  begin
    LMDThemeServices.DrawElement(useTheme, dc, tpBar, barr);
    LMDThemeServices.DrawElement(useTheme, dc, tpChunk, valr);
  end;
end;

procedure TLMDGridProgressColumn.ResetEmbeddedEditor;
begin
  DetachEmbeddedEditor;
  FEditor.Free;
  FEditor := TEmbeddedProgress.Create(Self);
end;

procedure TLMDGridProgressColumn.SetBarBorderColor(const Value: TColor);
begin
  if FBarBorderColor <> Value then
  begin
    BeginUpdate;
    FBarBorderColor := Value;
    EndUpdate;
  end;
end;

procedure TLMDGridProgressColumn.SetBarColor(const Value: TColor);
begin
  if FBarColor <> Value then
  begin
    BeginUpdate;
    FBarColor := Value;
    EndUpdate;
  end;
end;

procedure TLMDGridProgressColumn.SetBarHeight(const Value: Integer);
begin
  if FBarHeight <> Value then
  begin
    BeginUpdate;
    FBarHeight := Value;
    EndUpdate;
  end;
end;

procedure TLMDGridProgressColumn.SetBarWidth(const Value: Integer);
begin
  if FBarWidth <> Value then
  begin
    BeginUpdate;
    FBarWidth := Value;
    EndUpdate;
  end;
end;

procedure TLMDGridProgressColumn.SetChunkColor(const Value: TColor);
begin
  if FChunkColor <> Value then
  begin
    BeginUpdate;
    FChunkColor := Value;
    EndUpdate;
  end;
end;

procedure TLMDGridProgressColumn.SetMaxValue(const Value: Integer);
begin
  if FMaxValue <> Value then
  begin
    BeginUpdate;
    FMaxValue := Value;
    if FMinValue > FMaxValue then
      FMinValue := FMaxValue;
    EndUpdate;
  end;
end;

procedure TLMDGridProgressColumn.SetMinValue(const Value: Integer);
begin
  if FMinValue <> Value then
  begin
    BeginUpdate;
    FMinValue := Value;
    if FMaxValue < FMinValue then
      FMaxValue := FMinValue;
    EndUpdate;
  end;
end;

function TLMDGridProgressColumn.VarToProgress(AVar: PVariant;
  out AIsNull: Boolean): Integer;
begin
  if IsVarEmpty(AVar) then
  begin
    AIsNull := True;
    Result  := -1;
  end
  else
  begin
    AIsNull := False;
    Result  := AVar^;

    if Result > FMaxValue then
      Result := FMaxValue;
    if Result < FMinValue then
      Result := FMinValue;
  end;
end;

{ TEmbeddedProgress }

function TEmbeddedProgress.GetReadOnly: Boolean;
begin
  Result := FReadOnly;
end;

procedure TEmbeddedProgress.HandleFirstInput(const AInput: TLMDGridFirstInput);
var
  p:   TSmallPoint;
  key: Word;
begin
  case AInput.Kind of
    fikChar:      Perform(WM_CHAR, WPARAM(AInput.Char), 0);
    fikMouseDown: if ssLeft in AInput.Shift then
                  begin
                    Update; // At least one painting is required
                            // to calc control's layout.

                    p := PointToSmallPoint(ScreenToClient(AInput.CursorPos));
                    Perform(WM_LBUTTONDOWN, MK_LBUTTON, LPARAM(Integer(p)))
                  end;
    fikDelPress:  begin
                    key := VK_DELETE;
                    KeyDown(key, []);
                  end;
  end;
end;

procedure TEmbeddedProgress.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FGrid.KeyDownPreprocess(Key, Shift, psEdit);

  if not GetReadOnly and (Key = VK_DELETE) then
  begin
    Key := 0;
    if FCol.AllowUndefinedValue then
      FValue := Null
    else
      FValue := TLMDGridProgressColumn(FCol).FMinValue;
    Invalidate;
    FGrid.EditorChanged;
  end;

  if Key <> 0 then
    FGrid.KeyDownPostprocess(Key, Shift, psEdit);
end;

procedure TEmbeddedProgress.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  col: TLMDGridProgressColumn;
  val: Integer;
begin
  if (ssLeft in Shift) and not GetReadOnly then
  begin
    col := TLMDGridProgressColumn(FCol);

    if IsRectEmpty(FLayout.Content) then // Not yet drawn, so we have no  
    begin                                // valid layout, try to draw.
      FValue := col.FMinValue;
      Refresh; // Need immediate window update.
    end;
    
    if IsRectEmpty(FLayout.Content) then
      val := col.FMinValue
    else
    begin
      val := col.FMinValue + MulDiv(X - FLayout.Content.Left,
                                    col.FMaxValue - col.FMinValue,
                                    FLayout.Content.Right - FLayout.Content.Left);
      if val < col.FMinValue then
        val := col.FMinValue
      else if val > col.FMaxValue then
        val := col.FMaxValue;
    end;

    FValue := val;
    Invalidate;
    FGrid.EditorChanged;
  end;

  inherited;
end;

procedure TEmbeddedProgress.Paint;
begin
  inherited;
  FLayout := TLMDGridProgressColumn(FCol).FLastDrawn;
end;

procedure TEmbeddedProgress.SetReadOnly(AValue: Boolean);
begin
  FReadOnly := AValue;
end;

initialization
  NullVariant                      := Null;
  FLOAT_COMPARE_EPS                := FindFloatEPS;
  LMDDesignerSelectComponentProc   := nil;
  LMDDesignerIsComponentSelected   := nil;
  LMDDesignSelectionNotifyRegister := nil;
  ColumnClasses                    := TObjectList.Create(True);
  ChooserClasses                   := TObjectList.Create(True);
  ChooserClassesMain               := TObjectList.Create(False);
  ChooserClassesCompat             := TObjectList.Create(False);

  RegisterStdColumns;

finalization
  LMDDesignerSelectComponentProc   := nil;
  LMDDesignerIsComponentSelected   := nil;
  LMDDesignSelectionNotifyRegister := nil;
  FreeAndNil(ColumnClasses);
  FreeAndNil(ChooserClasses);
  FreeAndNil(ChooserClassesMain);
  FreeAndNil(ChooserClassesCompat);

end.
