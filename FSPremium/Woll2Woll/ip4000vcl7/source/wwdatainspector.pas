unit wwDataInspector;
{$R-}
{
//
// Components : TwwDataInspector
//
// Copyright (c) 1999 by Woll2Woll Software
//
// 11/15/99 - Fix problem for active cell updating in detail query
// 11/18/99 - Make sure this is a valid row when resizing row
// 12/2/99 - Dbl-click should be passed to base class to handle, and
//           dbl-click in customcombo when it does not have focus originally
//           should still work.
// 1/21/2000-Check for nil pointer in SetEditText
// 1/28/2000 - Send to parent form, not parent
// 2/24/00 - Fire OnItemChanged event when exiting control
// 3/6/2000 - Flush changes when expanding
// 3/6/00 - Check for nil active control
// 3/11/00 - Clear modified for inplaceeditor
// 3/21/00 - Honor setting of text for cbsEllipsis combo style when it is bound
// 4/21/00 - Fix expand/collapse button click problem when cell font changed during painting
// 4/25/00 - Make sure Obj is not nil.  This can happen when reassigning the datasource. (PYW)
// 4/26/00 - Check for nil obj in GetField method
// 5/3/00 - Make sure obj.edittext is updated to inplaceeditor's value
//          This is only necessary because when a picture mask is assigned, the obj.edittext
//          is not updated for some reason
// 5/4/00   Unbound with custom control item was losing original text
// 6/23/00 - Handle needs to be created to avoid blank display in some cases
// 7/19/00 - RSW - Don't remove inplaceeditor painting if it has the focus
// 7/19/00 - Richedit paint problem when dragging dialog in front
// 7/20/00 - ovTabToVisibleOnly should use 2nd paramater, not first
// 8/1/00 - ValidateRect put back in to avoid flicker when expanding all
// 8/5/00 - Add method Flush contents to force cell to flush its changes
// 12/4/00 - Support EditText to update inplaceeditor
// 12/17/00 - Already updated when toggling checkbox
// 1/22/00 - Add support for ActionLists (PYW)
// 5/11/2001 - PYW - Make sure that obj <> nil.
// 6/11/2001 - PYW - Fixed ToolTip Cell Hint Issues.
// 7/21/01 - Fix invisible inplaceeditor bug when
//           running in 120 pixels per inch
// 8/7/01 - Fix problem where unbound default combobox was having text
//          cleared.  Also fix problem with painting of combobox
//
// 8/9/01 - If no active item then have GetActiveEdit method return nil
// 09/04/01 - Set row to 1st not-fixed row when resetActiveitem tab style
// 1/21/02 - Add new event CalcCustomEdit to allow developer to prevent customedit
//           for selected records when the dataset moves to the record
// 3/18/2002-Call OnMouseUp event if assigned.
// 4/11/2002 - Verify control is focused if calling setfocuscell (PYW)
// 5/7/2002-PYW-Handles problem with main menu and return key when datainspector has focus.
// 5/8/2002 -PYW- Handled column Sizing bug when clicking on edge of Datainspector when embedded in grid.
// 6/13/02 - RSW Fix editor.text uipdating when inspector first receives focus
// 6/13/02 - Inspector in Grid problem where right/left arrows exited inspector during editing of inspector cell
//           It should instead just move within the edit control
}
{$i wwIfDef.pas}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, db, dbtables, dbctrls, wwstr, stdctrls, wwcommon, wwdbedit, wwpict, wwsystem,
  wwdbdatetimepicker, wwdbcomb, wwdblook, wwdotdot, wwframe, wwriched, extctrls,
  wwbitmap, wwpaintoptions;

type
  TwwInspectorCollection = class;
  TwwDataInspector = class;
  TwwInspectorItem = class;

  TwwInspectorHintWindow=class(THintWindow)
  private
  protected
     procedure Paint; override;
  public
     Field: TField;
     WordWrap: boolean;
     Alignment: TAlignment;
     CenterVertically: boolean;
  end;

  TwwDataInspectorDataLink = class(TDataLink)
  private
    FObjectView: TwwDataInspector;
    FInUpdateData: Boolean;
    FModified: Boolean;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    procedure FocusControl(Field: TFieldRef); override;
    procedure EditingChanged; override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;

  public
    constructor Create(AObjectView: TwwDataInspector);
    procedure Modified;
    procedure Reset;
    property isFieldModified : boolean read FModified;
  end;

  TwwInspectorPickList = class(TPersistent)
  private
    FItems: TStrings;
    FMapped: boolean;
    FDisplayAsCheckbox: boolean;
    FStyle: TComboBoxStyle;
    FShowMatchText: boolean;
    FAllowClearKey: boolean;
    FButtonStyle: TwwComboButtonStyle;
    FButtonGlyph: TBitmap;
    FButtonWidth: integer;
    procedure SetItems(val: TStrings);
    procedure SetButtonGlyph(Value: TBitmap);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Items: TStrings read FItems write SetItems;
    property MapList: boolean read FMapped write FMapped default false;
    property Style: TComboBoxStyle read FStyle write FStyle default stdctrls.csDropDown;
    property ShowMatchText: boolean read FShowMatchText write FShowMatchText default true;
    property AllowClearKey: boolean read FAllowClearKey write FAllowClearKey default false;
    property ButtonStyle : TwwComboButtonStyle read FButtonStyle write FButtonStyle default cbsDownArrow;
    property DisplayAsCheckbox : boolean read FDisplayAsCheckbox write FDisplayAsCheckbox default False;
    property ButtonGlyph : TBitmap read FButtonGlyph write SetButtonGlyph;
    property ButtonWidth : integer read FButtonWidth write FButtonWidth default 0;
  end;


  TwwInspectorItemOption = (iioAutoDateTimePicker, iioAutoLookupCombo);
  TwwInspectorItemOptions = set of TwwInspectorItemOption;
  TwwInspectorItemChanged = procedure (
    Sender: TwwDataInspector;
    Item: TwwInspectorItem; NewValue: string) of object;
  TwwInspectorItemNotifyEvent = procedure (
    Sender: TwwDataInspector;
    Item: TwwInspectorItem) of object;
  TwwInspectorNotifyEvent = procedure (Sender: TwwDataInspector) of object;


  TwwInspectorItem = class(TCollectionItem)
  private
    FEditText: string;
    FItems: TwwInspectorCollection;
    FReadOnly: boolean;
    FCustomControlName: TWinControl;
    FCustomControlAlwaysPaints: boolean;
    FCaption: string;
    FCellHeight: integer;
    FDataField: string;
    FDataLink: TFieldDataLink;
    FExpanded: boolean;
    FPickList: TwwInspectorPickList;
    FPicture: TwwDBPicture;
    FParentItem: TwwInspectorItem;
    FResizeable: boolean;
    FVisible: boolean;
    FTag: integer;
    FTagString: string;
    FOptions: TwwInspectorItemOptions;
    FTabStop: boolean;
    FItemChanged: TwwInspectorItemChanged;
    FWordWrap: boolean;
    FDisableDefaultEditor: boolean;
    FActiveRecord: boolean;
//    FWantArrowKeys: boolean;

    FOnEditButtonClick: TwwInspectorItemNotifyEvent;
    FAlignment: TAlignment;
    FCustomControlHighlight: boolean;
    FEnabled: boolean;
//    procedure ComboDropDownEvent(Sender: TObject);
//    OrigEditText: string;

    procedure SetItems(Value: TwwInspectorCollection);
    function GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);
    function GetDataField: string;
    procedure SetDataField(const Value: string);
    procedure SetCaption(const Value: string);
    Function GetControl: TComponent;
    Function GetField: TField;
    procedure SetCellHeight(const Value: integer);
    function GetLevel: integer;
    procedure SetCustomControl(val: TWinControl);
    procedure SetVisible(val: boolean);
    procedure SetExpanded(val: boolean);
    function GetChecked: boolean;
    procedure SetChecked(val: boolean);
    function GetDataLink: TDataLink;
    function GetDisplayText: string;
    procedure SetDisplayText(val: string);
    procedure SetEditText(val: string);

  protected
    ButtonPoint: TPoint; { 4/21/00 - Save buttonpt as if user changed font during
                         paint events, then buttonpt would not be consistent.  This
                         fixes problem where button click not being recognized. }
    property DataLink: TDataLink read GetDataLink;
    function HaveItems: boolean; virtual;
    Function GetDesigner: TControl;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoItemTextChanged; virtual;
    Function UseDefaultComboBox: boolean;
    Function GetMappedPaintText(StoredValue: string): string; virtual;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    Function HaveVisibleItem: boolean;
    function GetDisplayName: string; override;
    function GetNamePath: string; override;
    procedure Assign(Source: TPersistent); override;
    property ActiveRecord: boolean read FActiveRecord write FActiveRecord; // Only valid within DrawDataCell and DrawIndicatorCell
    property Field: TField read GetField;
    property Control: TComponent read GetControl;
    property Level: integer read GetLevel;
    property ParentItem : TwwInspectorItem read FParentItem write FParentItem;
    function GetFirstChild(VisibleItemsOnly: boolean = True;
                           ExpandedOnly: boolean = False): TwwInspectorItem;
    function GetLastChild(VisibleItemsOnly: boolean = True;
                          ExpandedOnly: boolean = False): TwwInspectorItem;
    function GetPrior(VisibleItemsOnly: boolean = True;
                      ExpandedOnly: boolean = False): TwwInspectorItem;
    function GetNext(VisibleItemsOnly: boolean = True;
                     ExpandedOnly: boolean = False): TwwInspectorItem;
    function GetNextSibling(VisibleItemsOnly: boolean = True): TwwInspectorItem;
    function GetPriorSibling(VisibleItemsOnly: boolean = True): TwwInspectorItem;
    property Checked: boolean read GetChecked write SetChecked;
    property DisplayText: string read GetDisplayText write SetDisplayText;

  published
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DataField: string read GetDataField write SetDataField;
    property Caption: string read FCaption write SetCaption;
    property CellHeight: integer read FCellHeight write SetCellHeight default 0;
    property EditText: string read FEditText write SetEditText; { Design-time settings only applicable if unbound item }

    property Alignment: TAlignment read FAlignment write FAlignment default taLeftJustify;
    property ReadOnly: boolean read FReadOnly write FReadOnly default false;
    property CustomControl: TWinControl read FCustomControlName write SetCustomControl;
    property CustomControlAlwaysPaints: boolean read FCustomControlAlwaysPaints write FCustomControlAlwaysPaints default True;
    property CustomControlHighlight: boolean read FCustomControlHighlight write FCustomControlHighlight default False;
    property Expanded: boolean read FExpanded write SetExpanded default false;
    property PickList: TwwInspectorPickList read FPickList write FPickList;
    property Picture: TwwDBPicture read FPicture write FPicture;
    property Resizeable: boolean read FResizeable write FResizeable default false;
    property Items: TwwInspectorCollection read FItems write SetItems stored HaveItems;
    property Visible : boolean read FVisible write SetVisible default True;
    property Tag: integer read FTag write FTag default 0;
    property TagString: string read FTagString write FTagString;
    property TabStop: boolean read FTAbStop write FTabStop default True;
    property Options: TwwInspectorItemOptions read FOptions write FOptions default [iioAutoDateTimePicker];
    property WordWrap: boolean read FWordWrap write FWordWrap; { 12/11/99 - Removed default as it did not match constructor before }
    property DisableDefaultEditor: boolean read FDisableDefaultEditor write FDisableDefaultEditor default False;
    property Enabled : boolean read FEnabled write FEnabled default True;

    property OnItemChanged: TwwInspectorItemChanged read
       FItemChanged write FItemChanged;
    property OnEditButtonClick: TwwInspectorItemNotifyEvent read FOnEditButtonClick write FOnEditButtonClick;
  end;

  TwwInspectorCollection = class(TCollection)
  private
    FParentItem: TwwInspectorItem;
    function GetItem(Index: Integer): TwwInspectorItem;
    procedure SetItem(Index: Integer; Value: TwwInspectorItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    Control: TComponent;
    property ParentItem : TwwInspectorItem read FParentItem;

    constructor Create(Control: TComponent);
    destructor Destroy; override;
    function Add: TwwInspectorItem;
    function Insert(index: integer): TwwInspectorItem;
    procedure SaveToStream(s: TStream);
    procedure LoadFromStream(s: TStream);
    procedure SaveToFile(const FileName: string);
    procedure LoadFromFile(const FileName: string);
    property Items[Index: Integer]: TwwInspectorItem read GetItem write SetItem; default;
  end;

  TwwInspectorItemCallback = procedure(obj: TwwInspectorItem;
                           UserData: Pointer; var AContinue: boolean) of object;

  TwwDataInspectorOption = (ovColumnResize, ovRowResize,
     ovTabExits,
     ovEnterToTab, ovHighlightActiveRow,
     ovHideVertDataLines,
     ovCenterCaptionVert, ovTabToVisibleOnly,
     ovShowTreeLines, ovShowCaptionHints, ovShowCellHints,
     ovFillNonCellArea, ovActiveRecord3DLines,
     ovAllowInsert, ovHideCaptionColumn, ovHideVertFixedLines,
     ovUseOwnBackgroundColors);
     // 8/2/02 - When UseOwnBackgroundcolors is true, then
     // inspector fills its background using its color and captioncolor properties.
     // This allows an inspector in a grid to still use its own colors instead of the alternating colors
  TwwDataInspectorOptions = set of TwwDataInspectorOption;

  TwwDataInspectorLineStyle = (ovNoLines, ovDottedLine, ovLight3DLine, ovDark3DLine, ovButtonLine);

  // 1/21/02
  TwwInspectorCalcCustomEditEvent = procedure (
    Sender: TwwDataInspector;
    Item: TwwInspectorItem;
    CustomEdit: TWinControl;
    var AllowCustomEdit: boolean) of object;

  TwwInspectorDrawDataCellEvent = procedure (
    Sender: TwwDataInspector;
    ObjItem: TwwInspectorItem;
    ASelected: boolean;
    ACellRect: TRect;
    var DefaultDrawing: boolean) of object;

  TwwInspectorDrawICellEvent = procedure (
    Sender: TwwDataInspector;
    ACol: integer;
    ACellRect: TRect;
    var DefaultDrawing: boolean) of object;

  TwwInspectorDrawCaptionEvent = procedure (
    Sender: TwwDataInspector;
    ObjItem: TwwInspectorItem;
    ASelected: boolean;
    ACellRect: TRect;
    var ACaptionRect: TRect;
    var DefaultTextDrawing: boolean) of object;

  TwwDataInspectorEdit = class(TInplaceEdit)
    private
      FwwPicture: TwwDBPicture;
      FWordWrap: boolean;
      ParentGrid: TwwDataInspector;
      FUsePictureMask: boolean;
      FCanvas: TControlCanvas;

      procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
      procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
      procedure WMPaste(var Message: TMessage); message WM_PASTE;  {10/28/96 }
      procedure CMExit(var Message: TMessage); message CM_EXIT;
      procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
      procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBkgnd;

    protected
      procedure BoundsChanged; override;
      procedure KeyDown(var Key: Word; Shift: TShiftState); override;
      procedure CreateParams(var Params: TCreateParams); override;
      procedure KeyUp(var Key: Word; Shift: TShiftState); override;
      procedure KeyPress(var Key: Char); override;
      procedure SetWordWrap(val: boolean);
      procedure UpdateContents; override;
    public
      constructor wwCreate(AOwner: TComponent; dummy: integer); virtual;
      destructor Destroy; override;
      function IsValidPictureValue(s: string): boolean;
      Function HavePictureMask: boolean;

      property Picture: TwwDBPicture read FwwPicture write FwwPicture;
      property WordWrap: boolean read FWordWrap write SetWordWrap;
      property Color;
      property Font;
    end;

  TwwInspectorFieldChangedEvent =
      procedure (Sender: TwwDataInspector; Field: TField) of object;
  TwwInspectorCreateDTPEvent = procedure(Sender: TwwDataInspector;
       ADateTimePicker: TwwDBCustomDateTimePicker) of object;
  TwwInspectorCreateComboEvent = procedure(Sender: TwwDataInspector;
       Combo: TwwDBComboBox) of object;
  TwwInspectorBeforeSelectCellEvent = procedure (Sender: TwwDataInspector;
     ObjItem: TwwInspectorItem; var CanSelect: boolean) of object;
  TwwInspectorAfterSelectCellEvent = procedure (Sender: TwwDataInspector;
     ObjItem: TwwInspectorItem) of object;

  TwwInspectorCanExpandEvent = procedure (Sender: TwwDataInspector;
     ObjItem: TwwInspectorItem; var CanExpand: boolean) of object;
  TwwInspectorCanCollapseEvent = procedure (Sender: TwwDataInspector;
     ObjItem: TwwInspectorItem; var CanCollapse: boolean) of object;
  TwwInspectorExpandedEvent = procedure (Sender: TwwDataInspector;
     ObjItem: TwwInspectorItem) of object;
  TwwInspectorCollapsedEvent = procedure (Sender: TwwDataInspector;
     ObjItem: TwwInspectorItem) of object;


  TwwInspectorTabSetFocusStyle = (itsPreserveActiveItem, itsResetActiveItem);
  TwwInspectorButtonOptions = class(TPersistent)
  private
     FExpandGlyph: TBitmap;
     FCollapseGlyph: TBitmap;
     Control: TWinControl;
     FTransparentGlyphs: boolean;
     procedure SetExpandGlyph(Value: TBitmap);
     procedure SetCollapseGlyph(Value: TBitmap);
  public
     constructor Create(AOwner: TComponent);
     destructor Destroy; override;
  published
     property ExpandGlyph: TBitmap read FExpandGlyph write SetExpandGlyph;
     property CollapseGlyph: TBitmap read FCollapseGlyph write SetCollapseGlyph;
     property TransparentGlyphs: Boolean read FTransparentGlyphs write FTransparentGlyphs default false;
  end;

  TwwInspectorPaintTextEvent = procedure (Sender: TwwDataInspector; Item: TwwInspectorItem; var PaintText: string) of object;
  TwwInspectorValidationError = procedure (Sender: TwwDataInspector;
     Item: TwwInspectorItem; var Msg: string; var DoDefault: boolean) of object;
  TwwCreateInspectorHintWindowEvent =
    procedure (Sender: TObject;
      HintWindow: TwwInspectorHintWindow;
      AField: TField; R: TRect;
      var WordWrap: boolean;
      var MaxWidth, MaxHeight: integer;
      var DoDefault: boolean) of object;

  TwwInspectorIndicatorRow=class(TPersistent)
  private
     FEnabled: boolean;
     FCaption: string;
     FHeight: integer;
     FColor: TColor;
     FTextAlignment: TAlignment;
     procedure SetColor(Value: TColor);
     procedure SetEnabled(Value: Boolean);
     procedure SetHeight(Value: integer);
     procedure SetCaption(Value: string);
     procedure SetTextAlignment(Value: TAlignment);
  public
     Inspector: TwwDataInspector;
     constructor Create(Owner: TComponent);
     procedure Invalidate;
  published
     property TextAlignment: TAlignment read FTextAlignment write SetTextAlignment default taLeftJustify;
     property Color: TColor read FColor write SetColor default clBtnFace;
     property Enabled: boolean read FEnabled write SetEnabled default False;
     property Caption: string read FCaption write SetCaption;
     property Height: integer read FHeight write SetHeight default 0;
  end;

  TwwDataInspector = class(TCustomGrid)
  private
     SkipUpdateCustomControlInFocus: boolean;
     NewMouseRow: integer;
     FIndicators: TImageList;
     FOnDrawDataCell: TwwInspectorDrawDataCellEvent;
     FOnDrawIndicatorCell: TwwInspectorDrawICellEvent;
     FOnTopLeftChanged: TNotifyEvent;
     FOnCalcCustomEdit: TwwInspectorCalcCustomEditEvent; // 1/21/02

     FOptions: TwwDataInspectorOptions;
     FPaintOptions: TwwGridPaintOptions;
     FDesigner: TControl;
     FItems: TwwInspectorCollection;

     FDataLink: TwwDataInspectorDataLink;
     FCaptionWidth: integer;
     FInactiveFocusColor: TColor;

     FEditText: string;
     FSizingIndex: integer;
     FSizingPos, FSizingOfs: Integer;
     FOnCheckValue: TwwValidateEvent;
     FOnFieldChanged: TwwInspectorFieldChangedEvent;
     FOnItemChanged: TwwInspectorItemChanged;
     FReadOnly: boolean;
     FCaptionIndent: integer;
     FDateTimePicker: TwwDBCustomDateTimePicker;
     FCombo: TwwDBComboBox;
     FOnCreateDateTimePicker: TwwInspectorCreateDTPEvent;
     FOnCreateDefaultCombo: TwwInspectorCreateComboEvent;
     FPictureMaskFromDataSet: boolean;
     FDefaultRowHeight: integer;
     FCaptionFont: TFont;
     FLineStyleData: TwwDataInspectorLineStyle;
     FLineStyleCaption: TwwDataInspectorLineStyle;
     FDottedLineColor: TColor;
     FUpdateCount: Integer;
     InvalidateInEndUpdate: boolean;
     FButtonOptions: TwwInspectorButtonOptions;
     FSetFocusTabStyle : TwwInspectorTabSetFocusStyle;

     FOnDrawCaptionCell: TwwInspectorDrawCaptionEvent;
     FOnBeforePaint: TwwInspectorNotifyEvent;
     FOnGetEditMask: TGetEditEvent;
     FOnBeforeSelectCell: TwwInspectorBeforeSelectCellEvent;
     FOnAfterSelectCell: TwwInspectorAfterSelectCellEvent;
     FOnCanExpand: TwwInspectorCanExpandEvent;
     FOnCanCollapse: TwwInspectorCanCollapseEvent;
     FOnExpanded : TwwInspectorExpandedEvent;
     FOnCollapsed : TwwInspectorCollapsedEvent;
     FOnCalcDataPaintText: TwwInspectorPaintTextEvent;
     FOnValidationErrorUsingMask: TwwInspectorValidationError;
     FOnCreateHintWindow: TwwCreateInspectorHintWindowEvent;

     TextIsSame: boolean;
     LastDefaultRowHeight: integer;
     SkipErase: boolean;
     CheckRowCount: boolean;

     FPaintCanvas: TCanvas;
     FPaintBitmap: TBitmap;
     UseTempCanvas: boolean;
     OldDesigning: boolean;
     LastActiveItem: TwwInspectorItem;

     FActiveItem, FTopItem: TwwInspectorItem;
     FMinRowHeight: integer;
     OldTopRow: integer;
     DoBeginUpdateInSelectCell: boolean;
     SelectCellUpdateRect: TRect;
     ChildDataChanged: boolean; // 2/10/2000 - Clear inplaceeditor if child datalink is changed.
     FDataColumns: integer;
     FTreeLineColor: TColor;
     FFixedDataRows: integer;
//     FAlternatingRowColor: TColor;
//     FActiveColumnColor: TColor;

     // Cell hint support
     lastMouseX, lastMouseY: integer;
     HintWindow: THintWindow;
     HintTimer: TTimer;
     HintTimerCount: integer;
     FCustomControlKeyMode: boolean;

     UpdateRect: TRect;
//     OldClientRect: TRect;
//     InitBlendBitmapsFlag: boolean;
     OldBoundsRect: TRect;
     FScrollBars: TScrollStyle;
//     FIndicatorCaption: string;
     FIndicatorRow: TwwInspectorIndicatorRow;
//     PaintCopyBrushColor: TColor;
     PaintCopyTextColor: TColor;
     SkipSetFocus: boolean;
     SkipUpdateEditText: boolean;
     lastMouseCoord: TGridCoord;
     HotCol, HotRow: integer;
     FDisableThemes: boolean;

     procedure HintTimerEvent(Sender: TObject);

     procedure EditingChanged;
     procedure SetDataSource(value : TDataSource);
     Function GetDataSource: TDataSource;
     procedure SetCaptionWidth(value: integer);
     procedure FieldChanged(Field: TField);

     procedure RecordChanged(Field: TField);
     procedure UpdateData;
     function GetPageHeight: integer;
     function InValidColSizingArea(x: integer): boolean;
     function GetDateTimePicker: TwwDBCustomDateTimePicker;
     function DataRow(ARow: integer): integer;

     procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
     procedure WMSize(var Message: TWMSize); message WM_SIZE;
     procedure WMKillFocus(var Message: TMessage); message WM_KillFocus;
     procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
     procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
     procedure CMExit(var Message: TMessage); message CM_EXIT;
     procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
     procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBkgnd;
     procedure WMChar(var Msg: TWMChar); message WM_CHAR;
     procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
     procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
     procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
     procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
     procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
     procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;

     Function IsHighlightRowVisible: boolean;
     Procedure GetActiveItemCallback(
       Item: TwwInspectorItem;
       UserData: Pointer; var AContinue: boolean);
     Procedure GetActiveRowsCallback(
       Item: TwwInspectorItem;
       UserData: Pointer; var AContinue: boolean);
     Procedure ApplySettingsCallback(
       Item: TwwInspectorItem;
       UserData: Pointer; var AContinue: boolean);
     Procedure LinkActiveCallback(
       Item: TwwInspectorItem;
       UserData: Pointer; var AContinue: boolean);
     Function GetActiveRows: integer;
     procedure SetCaptionIndent(val: integer);

     procedure SetItems(Value: TwwInspectorCollection);
     procedure SetOptions(Value: TwwDataInspectorOptions);
//     procedure SetPaintOptions(Value: TwwInspectorPaintOptions);
     procedure SetDefaultRowHeight(Value: integer);
     procedure SetCaptionFont(Value: TFont);
     procedure CaptionFontChanged(Sender: TObject);
     procedure ToggleCheckbox(obj: TwwInspectorItem);
     procedure SetLineStyleCaption(val: TwwDataInspectorLineStyle);
     procedure SetLineStyleData(val: TwwDataInspectorLineStyle);
     procedure SetUpdateState(Updating: Boolean);
     function isFocused: boolean;
     Procedure SetActiveItem(obj: TwwInspectorItem);
     function GetActiveItem: TwwInspectorItem;
     function GetCaptionColor: TColor;
     function GetTreeLineColor: TColor;
     procedure SetCaptionColor(val: TColor);
     procedure SetTreeLineColor(val: TColor);
     Function GetTopItem: TwwInspectorItem;
     procedure UpdateRowCount;
     procedure EditDataLinkDataChange(Sender: TObject);
     procedure EditDataLinkUpdateData(Sender: TObject);
     Function GetActiveEdit: TWinControl;
     procedure SetDottedLineColor(val: TColor);
     procedure SetDataColumns(val:integer);
     procedure SetScrollBars(Value: TScrollStyle);
     procedure SetFixedDataRows(Value: integer);
//     procedure SetIndicatorCaption(val: string);
  protected
    CurrentCustomEdit: TWinControl; //CustomEdit;
    CurrentCustomEditRow: integer;
    CurrentCustomEditCol: integer;
    InTracking: boolean;
    FFocused: boolean;
    FastDesign: boolean;  { Need to test more with this as true }
    TempRichEdit: TwwDBRichEdit;

    // 1/21/02
    procedure CurrentCustomEditSetfocus; virtual;
    procedure DoCalcCustomEdit(Item: TwwInspectorItem;
       CustomEdit: TWinControl;
       var AllowCustomEdit: boolean); virtual;
    function RecordCountIsValid: boolean; virtual;
    function GetClientRect: TRect; override;
    procedure UpdateScrollBar; virtual;
    procedure CreateWnd; override;
    procedure Scroll(Distance: Integer); virtual;
    Function CreateHintWindow: THintWindow; virtual;
    procedure HintMouseMove(Shift: TShiftState; X, Y: Integer); virtual;
    procedure DisplayIndicatorCell(ACol: integer; ARect: TRect); virtual;
    Function EffectiveFocused: boolean;

    procedure DoCreateHintWindow(
      HintWindow: TwwInspectorHintWindow;
      AField: TField; R: TRect;
      var WordWrap: boolean;
      var MaxWidth, MaxHeight: integer;
      var DoDefault: boolean); virtual;

    procedure UpdateCurrentEditPosition;
    function ControlRect(ACol, ARow: integer): TRect;
    procedure UpdateCustomEdit;
    procedure FreeHintWindow; virtual;
    function IsActiveControl: Boolean;
    procedure ChangeOrientation(RightToLeftOrientation: Boolean);
    procedure InheritedPaint;
    procedure FirstTimePaint; virtual;

    procedure SetDesigner(Value: TControl); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function CreateDateTimePicker: TwwDBCustomDateTimePicker; virtual;
    function CreateDefaultCombo: TwwDBComboBox; virtual;
    procedure DoCreateDateTimePicker(ADateTimePicker: TwwDBCustomDateTimePicker); virtual;
    procedure DoCreateDefaultCombo(ACombo: TwwDBComboBox); virtual;
    procedure LinkActive(Value: Boolean); virtual;
    function CanEditModify: Boolean; override;
    procedure DoFieldChanged(Field: TField); virtual;
    procedure DoItemChanged(Item: TwwInspectorItem; NewValue: string); virtual;

    function CreateEditor: TInplaceEdit; override;
    procedure DoExit; override;
    procedure TopLeftChanged; override;
    function CanEditShow: Boolean; override;
    procedure DrawCell(ACol, ARow: Integer; ARect: TRect; AState: TGridDrawState); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
         X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
         X, Y: Integer); override;
    procedure CalcSizingState(X, Y: Integer; var State: TGridState;
      var Index: Longint; var SizingPos, SizingOfs: Integer;
      var FixedInfo: TGridDrawInfo); override;
    procedure UpdateDataColumnWidth; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    function GetEditText(ACol, ARow: Longint): string; override;
    function GetEditMask(ACol, ARow: Longint): string; override;
    procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
    procedure Loaded; override;
    function AcquireFocus: Boolean; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Paint; override;
    procedure SetFocusCell(ACol, ARow: integer); virtual;
    function SelectCell(ACol, ARow: Longint): Boolean; override;
    procedure DataChanged; virtual;
    procedure UpdateActive; virtual;
    function GetField(ARow: integer): TField;
    function UseDefaultEditor: boolean; virtual;
    function UseCheckbox(ARow: integer): boolean; virtual;
    function ButtonPt(ARect: TRect; Obj: TwwInspectorItem): TPoint; virtual;
    function CheckboxRect(ARect: TRect; Obj: TwwInspectorItem): TRect; virtual;
    procedure DrawSizingLine(const DrawInfo: TGridDrawInfo);
    procedure RowHeightsChanged; override;
    procedure DoDrawDataCell(ObjItem: TwwInspectorItem;
       ASelected: boolean;
       ACellRect: TRect;
       var DefaultDrawing: boolean); virtual;
//    procedure DoDrawIndicatorCell(ObjItem: TwwInspectorItem;
//       ACellRect: TRect;
//       var DefaultDrawing: boolean); virtual;
    procedure InitCustomEdit(customEdit: TWinControl; Obj: TwwInspectorItem); virtual;
    procedure DoDrawCaptionCell(ObjItem: TwwInspectorItem;
       ASelected: boolean;
       ACellRect: TRect;
       var ACaptionRect: TRect;
       var DefaultTextDrawing: boolean); virtual;
     Function GetCanvas: TCanvas; virtual;
     Function IsDefaultDateTimePicker(Obj: TwwInspectorItem): boolean;
     Function IsDefaultLookupCombo(Obj: TwwInspectorItem): boolean;
     procedure DoCollapse(ObjItem: TwwInspectorItem); virtual;
     procedure DoExpand(ObjItem: TwwInspectorItem); virtual;
    procedure Click; override;
    procedure PaintLines(item: TwwInspectorItem); virtual;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure DoCalcDataPaintText(item: TwwInspectorItem; var PaintText: string); virtual;
    procedure ValidationErrorUsingMask(Item: TwwInspectorItem); virtual;
    procedure FillWithFixedBitmap(TempRect: TRect; CurRelRow: integer); virtual;
    procedure FillWithAlternatingRowBitmap(TempRect: TRect); virtual;
    property InactiveFocusColor: TColor read FInactiveFocusColor write FInactiveFocusColor default clNone;
    property TopItem: TwwInspectorItem read GetTopItem; { Currently not implemented so leave as protected }

  public
     property Col;
     property ColWidths;
     property EditorMode;
     property GridHeight;
     property GridWidth;
     property LeftCol;
     property Selection;
     property Row;
     property RowHeights;
     property TabStops;
     property TopRow;
     property RowCount;
     property ActiveEdit: TWinControl read GetActiveEdit;
     {$ifdef wwdelphi4up}
     function ExecuteAction(Action: TBasicAction): Boolean; override;
     function UpdateAction(Action: TBasicAction): Boolean; override;
     {$endif}

     property DataLink: TwwDataInspectorDataLink read FDataLink;
     property DefaultDateTimePicker: TwwDBCustomDateTimePicker read GetDateTimePicker;
     property DefaultCombo: TwwDBComboBox read FCombo;
     property Canvas: TCanvas read GetCanvas;
     property CustomControlKeyMode: boolean read FCustomControlKeyMode write FCustomControlKeyMode;

     Function LevelRect(item: TwwInspectorItem): TRect;
     procedure MouseToCell(X, Y: Integer; var ACol, ARow: Longint);
     function MouseToItem(X, Y: Integer): TwwInspectorItem;
     function RefreshActiveItem: TwwInspectorItem;
     procedure BeginUpdate;
     procedure EndUpdate(Repaint: boolean = false);
     constructor Create(AOwner: TComponent); override;
     destructor Destroy; override;
     procedure ApplySettings;
     procedure RefreshItem(Item: TwwInspectorItem); virtual;
//     procedure Click; override;
     Function GetRowByItem(AItem: TwwInspectorItem): integer; virtual;
     procedure IterateItems(CallBack: TwwInspectorItemCallback;
                 ExpandedOnly: boolean; UserData: Pointer);
     procedure InvalidateRow(ARow: integer);
     procedure InvalidateRowCol(ARow: integer; ACol: integer = -1);
//     procedure RefreshCustomControl;
     Function GetItemByFieldName(AFieldName: string): TwwInspectorItem;
     Function GetItemByRow(ARow: integer; Optimize: boolean = True): TwwInspectorItem; virtual;
     Function GetItemByCaption(ACaption: string): TwwInspectorItem;
     Function GetItemByTagString(ATagString: string): TwwInspectorItem;
     Function HaveVisibleItem: boolean;
     function GetFirstChild(VisibleItemsOnly: boolean = True): TwwInspectorItem;
     procedure FlushContents; // 8/5/00 New method
     property Designer: TControl read FDesigner write SetDesigner;
     property ActiveRows: integer read GetActiveRows;
     property InplaceEditor;
     property ActiveItem: TwwInspectorItem read GetActiveItem write SetActiveItem;
//     property DefaultDrawing;
     { Perhaps publish later, but this event seems unncessary as the OnItemChanged event can do the job }
     property OnFieldChanged: TwwInspectorFieldChangedEvent read FOnFieldChanged write FOnFieldChanged;

     // FixeddataRows Not published now as it is not fully functional.
     // 1. Need to resolve scrolling down from fixed row as it should not jump 2 2nd row
     // but instead it should jump to the current top row.
     //  2. Some lines are not drawn in their proper location when fixeddatarows is assigned
     property FixedDataRows: integer read FFixedDataRows write SetFixedDataRows default 0;

  published
     property DisableThemes : boolean read FDisableThemes write FDisableThemes;
     property Align;
     property Anchors;
//     property AlternatingRowColor: TColor read FAlternatingRowColor write FAlternatingRowColor default $00B1B1B1;
//     property ActiveColumnColor: TColor read FActiveColumnColor write FActiveColumnColor default clNone;
     property BiDiMode;
     property BorderStyle;
     property Color default clBtnFace;
     property Constraints;
     property Ctl3D;
//     property DefaultDrawing;
     property DragCursor;
     property DragKind;
     property DragMode;
     property Enabled;
     property CaptionColor : TColor read GetCaptionColor write SetCaptionColor default clBtnFace;
     property TreeLineColor : TColor read GetTreeLineColor write SetTreeLineColor default clWhite;
//     property FixedColor;
     property Font;
     property DataColumns: integer read FDataColumns write SetDataColumns default 1;
//     property IndicatorCaption: string read FIndicatorCaption write SetIndicatorCaption;
     property IndicatorRow: TwwInspectorIndicatorRow read FIndicatorRow write FIndicatorRow;
     property ParentBiDiMode;
     property ParentColor;
     property ParentCtl3D;
     property ParentFont;
     property ParentShowHint;
     property PopupMenu;
     property ScrollBars : TScrollStyle read FScrollBars write SetScrollBars default ssVertical;
     property ShowHint;
     property TabOrder;
     property TabStop;
     property PictureMaskFromDataSet: boolean read FPictureMaskFromDataSet write FPictureMaskFromDataSet default False;
     property DataSource: TDataSource read GetDataSource write SetDataSource;
     property Items: TwwInspectorCollection read FItems write SetItems;
     property DefaultRowHeight: integer read FDefaultRowHeight write SetDefaultRowHeight default 0;
     property CaptionWidth: integer read FCaptionWidth write SetCaptionWidth;
//     property WordWrap : boolean read FWordWrap write FWordWrap;
     property Options: TwwDataInspectorOptions read FOptions write SetOptions;
     property PaintOptions: TwwGridPaintOptions read FPaintOptions write FPaintOptions;//SetPaintOptions;
     property CaptionFont: TFont read FCaptionFont write SetCaptionFont;
     property LineStyleCaption: TwwDataInspectorLineStyle read FLineStyleCaption write SetLineStyleCaption default ovDark3DLine;
     property LineStyleData: TwwDataInspectorLineStyle read FLineStyleData write SetLineStyleData default ovDark3DLine;
     property DottedLineColor: TColor read FDottedLineColor write SetDottedLineColor default clBtnShadow;
//     property InactiveFocusColor: TColor read FInactiveFocusColor write FInactiveFocusColor default clNone;
     property ButtonOptions: TwwInspectorButtonOptions read FButtonOptions write FButtonOptions;
     property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
     property CaptionIndent: integer read FCaptionIndent write SetCaptionIndent default 12;
     property SetFocusTabStyle : TwwInspectorTabSetFocusStyle read FSetFocusTabStyle write FSetFocusTabStyle default itsPreserveActiveItem;
     property Visible;

     // 1/21/02
     property OnCalcCustomEdit: TwwInspectorCalcCustomEditEvent read FOnCalcCustomEdit write FOnCalcCustomEdit;
     property OnClick;
     property OnCreateHintWindow : TwwCreateInspectorHintWindowEvent read FOnCreateHintWindow write FOnCreateHintWindow;
     property OnDblClick;
     property OnDragDrop;
     property OnDragOver;
     property OnDrawDataCell: TwwInspectorDrawDataCellEvent read FOnDrawDataCell write FOnDrawDataCell;
     property OnDrawIndicatorCell: TwwInspectorDrawICellEvent read FOnDrawIndicatorCell write FOnDrawIndicatorCell;
     property OnEndDock;
     property OnEndDrag;
     property OnEnter;
     property OnExit;
     property OnKeyDown;
     property OnKeyPress;
     property OnKeyUp;
     property OnMouseDown;
     property OnMouseMove;
     property OnMouseUp;
     property OnMouseWheelDown;
     property OnMouseWheelUp;
     property OnBeforeSelectCell: TwwInspectorBeforeSelectCellEvent read FOnBeforeSelectCell write FOnBeforeSelectCell;
     property OnAfterSelectCell: TwwInspectorAfterSelectCellEvent read FOnAfterSelectCell write FOnAfterSelectCell;
     property OnStartDock;
     property OnStartDrag;
     property OnTopLeftChanged: TNotifyEvent read FOnTopLeftChanged write FOnTopLeftChanged;
     property OnContextPopup;

     property OnCreateDateTimePicker: TwwInspectorCreateDTPEvent
             read FOnCreateDateTimePicker write FOnCreateDateTimePicker;
     property OnCreateDefaultCombo: TwwInspectorCreateComboEvent
             read FOnCreateDefaultCombo write FOnCreateDefaultCombo;
     property OnDrawCaptionCell: TwwInspectorDrawCaptionEvent
        read FOnDrawCaptionCell write FOnDrawCaptionCell;
     property OnBeforePaint : TwwInspectorNotifyEvent read FOnBeforePaint write FOnBeforePaint;
     property OnCanExpand: TwwInspectorCanExpandEvent read FOnCanExpand write FOnCanExpand;
     property OnCanCollapse: TwwInspectorCanCollapseEvent read FOnCanCollapse write FOnCanCollapse;
     property OnExpanded : TwwInspectorExpandedEvent read FOnExpanded write FOnExpanded;
     property OnCollapsed : TwwInspectorCollapsedEvent read FOnCollapsed write FOnCollapsed;
//     property OnCheckValue: TwwValidateEvent read FOnCheckValue write FOnCheckValue;
     property OnItemChanged: TwwInspectorItemChanged read FOnItemChanged write FOnItemChanged;
//     property OnGetEditMask: TGetEditEvent read FOnGetEditMask write FOnGetEditMask;
     property OnCalcDataPaintText: TwwInspectorPaintTextEvent read FOnCalcDataPaintText write FOnCalcDataPaintText;
     property OnValidationErrorUsingMask: TwwInspectorValidationError
               read FOnValidationErrorUsingMask
               write FOnValidationErrorUsingMask;
  end;

 { 12/15/99 - Support dbl-click }
 TwwInspectorComboBox = class(TwwDBComboBox)
   private
     Inspector: TwwDataInspector;
   protected
     FClickTime: integer;
     procedure CloseUp(Accept: boolean); override;
     procedure DblClick; override;
     procedure WndProc(var Message: TMessage); override;
   public
     procedure DropDown; override;
     constructor Create(AOwner: TComponent); override;
 end;

procedure Register;

implementation

uses consts, wwtypes{, wwblend},
     {$ifdef wwDelphi7Up}
     themes,
     {$endif}
     wwdbgrid;
{$R WWDATAIN.RES}

  procedure TwwInspectorComboBox.WndProc(var Message: TMessage);
  begin
    case Message.Msg of
      WM_LBUTTONDOWN:
        begin
          if UINT(GetMessageTime - FClickTime) < GetDoubleClickTime then
           Message.Msg := WM_LBUTTONDBLCLK;
          FClickTime := 0;
        end;
    end;
    inherited WndProc(Message);
  end;

 procedure TwwInspectorComboBox.DblClick;
 begin
   inherited;
   Inspector.DblClick;
 end;

 constructor TwwInspectorComboBox.Create(AOwner: TComponent);
 begin
    inherited Create(AOwner);
    TabStop:= false;
    Inspector:= AOwner as TwwDataInspector;
 end;

 procedure TwwInspectorComboBox.CloseUp(Accept: boolean);
 var WasDroppedDown: boolean;
     OldEditText: string;
 begin
     WasDroppedDown:= IsDroppedDown;
     if Inspector.ActiveItem<>nil then
        OldEditText:= Inspector.ActiveItem.EditText
     else OldEditText:= '';
     inherited CloseUp(Accept);
     if Accept and WasDroppedDown then begin
       if Inspector.ActiveItem=nil then exit;
       Inspector.ActiveItem.editText:= GetComboValue(Text);
       if OldEditText<>Inspector.ActiveItem.EditText then
         Inspector.ActiveItem.DoItemTextChanged;
     end
 end;

procedure TwwInspectorComboBox.DropDown;
begin
   with Inspector.ActiveItem do begin
     if Assigned(FOnEditButtonClick) then
     begin
       FOnEditButtonClick(Inspector, Inspector.ActiveItem);
       if Inspector.CurrentCustomEdit is TwwDBComboBox then begin
         if (TwwDBComboBox(Inspector.CurrentCustomEdit).buttonStyle=cbsellipsis) then
         begin
            if Inspector.CanEditModify then begin { 3/21/00 - Check text property for cbsEllipsis style }
               EditText:= TwwDBComboBox(Inspector.CurrentCustomEdit).value;
               Inspector.FEditText:=EditText;
            end
         end
         else
            EditText:= TwwDBComboBox(Inspector.CurrentCustomEdit).value;
       end
     end
     else inherited DropDown;
   end
end;

procedure TwwDataInspectorDataLink.DataSetChanged;
begin
  FObjectView.DataChanged;
  FModified := False;
end;

procedure TwwDataInspectorDataLink.Modified;
begin
  FModified := True;
end;

procedure TwwDataInspectorDataLink.Reset;
begin
  if FModified then begin
     RecordChanged(nil);
     FObjectView.InvalidateEditor;
  end
  else exit;
{  else begin
     if ((DataSource.DataSet.State = dsEdit) or (DataSource.DataSet.State = dsInsert)) and
	 dataSet.modified then
     begin
	 if MessageDlg(wwInternational.UserMessages.wwDBGridDiscardChanges,
		    mtConfirmation, [mbYes,mbNo], 0)<>mrYes then exit;
     end;
     Dataset.Cancel;
  end}
end;

procedure TwwDataInspectorDataLink.UpdateData;
begin
  FInUpdateData := True;
  try
    if FModified then FObjectView.UpdateData;
    FModified := False;
  finally
    FInUpdateData := False;
  end;
end;

constructor TwwDataInspectorDataLink.Create(AObjectView: TwwDataInspector);
begin
  inherited Create;
  FObjectView:= AObjectView;
  VisualControl:= true;
end;

procedure TwwDataInspectorDataLink.EditingChanged;
begin
  FObjectView.EditingChanged;
end;

procedure TwwDataInspectorDataLink.RecordChanged(Field: TField);
begin
  if (Field = nil) or not FInUpdateData then
  begin
    FObjectView.RecordChanged(Field);
    FModified := False;
  end;

  if (Field<>Nil) and (Dataset.State in [dsEdit, dsInsert]) then
  begin
     FObjectView.FieldChanged(Field);
     FObjectView.TextIsSame:= True;
  end
end;

procedure TwwDataInspectorDataLink.LayoutChanged;
begin
  { 11/15/99 - Fixes problem for active cell updating in detail query }
  FObjectView.InvalidateEditor;
  FObjectView.invalidate;
//  FRecordViewPanel.LinkActive(Active);
end;

procedure TwwDataInspectorDataLink.ActiveChanged;
begin
   FObjectView.LinkActive(Active);
end;

procedure TwwDataInspectorDataLink.DataSetScrolled(Distance: Integer);
begin
  FObjectView.Scroll(Distance);
end;

{ TDrawGrid }

Function TwwDataInspector.MouseToItem(X, Y: Integer): TwwInspectorItem;
var ACol, ARow: integer;
begin
   MouseToCell(X, Y, ACol, ARow);
   result:= GetItemByRow(ARow);
end;

procedure TwwDataInspector.MouseToCell(X, Y: Integer; var ACol, ARow: Longint);
var
  Coord: TGridCoord;
begin
  Coord := MouseCoord(X, Y);
  ACol := Coord.X;
  ARow := Coord.Y;
end;


Function GetCenterPoint(ARect: TRect): TPoint;
var r: TRect;
begin
   r:= ARect;
   result.y:= r.Top + (wwRectHeight(r)) div 2;
   result.x:= r.Left + (wwRectWidth(r)) div 2;
end;

procedure TwwInspectorIndicatorRow.Invalidate;
var r: TRect;
begin
   if Enabled then
   begin
      r:= Inspector.CellRect(0, 0);
      r.right:= Inspector.ClientWidth;
      InvalidateRect(Inspector.Handle, @r, True);
   end
end;

procedure TwwInspectorIndicatorRow.SetColor(Value: TColor);
begin
   if FColor<>Value then
   begin
      FColor:= Value;
      Inspector.PaintOptions.Row1Color:= Value;
      Inspector.PaintOptions.InitBlendBitmapsFlag:=True;
      Invalidate;
   end
end;

procedure TwwInspectorIndicatorRow.SetTextAlignment(Value: TAlignment);
begin
   if FTextAlignment<>Value then
   begin
      FTextAlignment:= Value;
      if Enabled then Inspector.invalidateCell(0,0);
   end
end;

procedure TwwInspectorIndicatorRow.SetEnabled(Value: Boolean);
begin
   if FEnabled<>Value then
   begin
      FEnabled:= Value;
      Inspector.ApplySettings;
   end
end;

procedure TwwInspectorIndicatorRow.SetHeight(Value: integer);
begin
   if FHeight<>Value then
   begin
      FHeight:= Value;
      if (Inspector.RowCount>0) and Enabled then
         Inspector.RowHeights[0]:= Value;
   end
end;

procedure TwwInspectorIndicatorRow.SetCaption(Value: string);
begin
   if FCaption<>Value then
   begin
      FCaption:= Value;
      if Enabled then Inspector.invalidateCell(0,0);
   end
end;

constructor TwwInspectorIndicatorRow.Create(Owner: TComponent);
begin
  Inspector:= Owner as TwwDataInspector;
  FColor:= clBtnFace;
end;

constructor TwwDataInspector.Create(AOwner: TComponent);
const
  bmArrow = 'WWINSPECTORARROW';
  bmEdit = 'WWINSPECTOREDIT';
  bmInsert = 'WWINSPECTORINSERT';
var
  Bmp: TBitmap;
begin
  inherited Create(AOwner);
  NewMouseRow:= -1;
//  FAlternatingRowColor:=$00B1B1B1;
//  FActiveColumnColor:= clNOne;
  FPaintBitmap:= TBitmap.create;
  FPaintCanvas:= FPaintBitmap.Canvas;
  ControlStyle:= ControlStyle + [csReplicatable];

  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromResourceName(HInstance, bmArrow);
    FIndicators := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmEdit);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmInsert);
    FIndicators.AddMasked(Bmp, clWhite);
  finally
    Bmp.Free;
  end;


  SetFocusTabStyle := itsPreserveActiveItem;
  Color:= clBtnFace;
  ScrollBars:= ssVertical;
  FLineStyleData:= ovDark3DLine;
  FlineStyleCaption:= ovDark3DLine;
  FSaveCellExtents:= false;

  FDottedLineColor:= clBtnShadow;
  FDataLink:= TwwDataInspectorDataLink.create(self);
  FItems:= TwwInspectorCollection.Create(self);
//  FSelected:= TStringList.create;
//  FControlType:= TStringList.create;
  FixedCols:= 0;
  FCaptionIndent:= 12;
  ColCount:= 2;
  RowCount:= 1;
  FixedRows:=0;
  FCaptionWidth:= 100;

  inherited Options := [goColSizing,
     goTabs, goEditing, goAlwaysShowEditor];
  Options:= [ovColumnResize, ovRowResize, ovHighlightActiveRow,
             ovCenterCaptionVert, ovEnterToTab];
  DefaultDrawing := False;

  FCaptionFont := TFont.Create;
  FCaptionFont.OnChange := CaptionFontChanged;
  FInactiveFocusColor:= clNone;
  FButtonOptions:= TwwInspectorButtonOptions.create(self);
  FDataColumns:= 1;
  FTreeLineColor:= clWhite;

  FIndicatorRow:= TwwInspectorIndicatorRow.create(self);
  FPaintOptions:= TwwGridPaintOptions.create(self, FPaintBitmap);
  FPaintOptions.Row1Color:= IndicatorRow.Color;
  FPaintOptions.Column1Color:= CaptionColor;

  FixedDataRows:= 0;
end;

var KeyHook : HHOOK;

type TCheatCast = class(TwwDataInspector)
end;

function wwHookKeyProc(nCode: Integer; wParam: Integer; lParam: Integer): LResult; stdcall;
type
  TSelection = record
    StartPos, EndPos: Integer;
  end;
var ac: TWinControl;
    Inspector: TwwDataInspector;

    Function IsChildOfInspector(var Inspector: TwwDataInspector): boolean;
    var tc: TWinControl;
    begin
       tc:= screen.activecontrol;
       if not (tc is TwwDataInspector) then
       begin
          repeat
             tc:= tc.parent;
          until (tc=nil) or (tc is TwwDataInspector);
       end;
       result:=  (tc is TwwDataInspector);
       if result then Inspector:= TwwDataInspector(tc)
       else Inspector:=nil;
    end;

  function Selection: TSelection;
  begin
    SendMessage(ac.Handle, EM_GETSEL, Longint(@Result.StartPos), Longint(@Result.EndPos));
  end;


  Function AllSelected: boolean;
  begin
     with ac do
      with Selection do
        result:= (StartPos=0) and (EndPos=GetTextLen);
  end;

  function RightSide: Boolean;
  begin
    with ac do
      with Selection do
        Result := ((StartPos = 0) or (EndPos = StartPos)) and
          (EndPos = GetTextLen);
  end;

  function LeftSide: Boolean;
  begin
    with ac do
      with Selection do
        Result := (StartPos = 0) and
        ((EndPos = 0) or (EndPos = GetTextLen) {or (isMasked and (EndPos=1))});
    if ac is TwwDBCustomEdit then with TwwDBCustomEdit(ac) do
       if isMasked and (Selection.EndPos=1) then result:= True;
  end;

  function IsInExpandedGrid: boolean;
  begin
     result:= false;
     if (Inspector.parent is TwwDBGrid) then
        with TDrawGrid(Inspector.parent) do begin
           if Inspector.Height+2 < RowHeights[Row] then
              result:= True;
        end
  end;

begin
    ac:= screen.activecontrol;
    if ac is TwwDataInspector then  // inplaceeditor doesn't update ac
    begin
       if (TwwDataInspector(ac).inplaceeditor<>nil) and
          (TwwDataInspector(ac).inplaceeditor.handle = GetFocus) then
       begin
          ac:= TwwDataInspector(ac).inplaceeditor;
       end
    end;

    result := CallNextHookEx(KeyHook, nCode, wParam, lParam);
    if result=1 then exit;  // if someone else has processed the key then skip below code
    if ac=nil then exit;

    if ((wparam = 13) or (wparam = 9)) and
       not (GetKeyState(vk_control)<0) and
       not (GetKeyState(vk_menu)<0) and
       (GetFocus=ac.handle) then
    begin
       if (lparam and $80000000)=0 then begin
         if IsChildOfInspector(Inspector) then
         begin
           if (ovEnterToTab in Inspector.Options) or (wparam=vk_tab) then
           begin
             //5/7/2002-PYW-Handles problem with main menu and return key.
             PostMessage(Inspector.handle, WM_KEYDOWN, wparam, 0);
             result:=1;
           end
         end
       end
       else result:=1
    end
    else if (wparam = vk_f2) and
       not (GetKeyState(vk_control)<0) and
       not (GetKeyState(vk_menu)<0) then
    begin
       if IsChildOfInspector(Inspector) then
       begin
         if (lparam and $80000000)=0 then
           Inspector.FCustomControlKeyMode:= not Inspector.FCustomControlKeyMode;
       end
    end
    // Need obj property to see if we should pass vk_down, vk_up, vk_next, and vk_prior to inspector
    // Always pass vk_left, vk_right
    else if (wparam in [vk_right, vk_left, vk_down, vk_up, vk_next, vk_prior]) and
        ((lparam and $80000000)=0) and
        (GetKeyState(vk_control)<0) then
    begin
        if IsChildOfInspector(Inspector) and (ac<>Inspector)  then
        begin
           PostMessage(Inspector.handle, WM_KEYDOWN, wparam, 0);
           result:=1;
        end
    end
    else if (wparam in [vk_left, vk_right, vk_down, vk_up, vk_next, vk_prior]) and
       not (GetKeyState(vk_control)<0) and
       not (GetKeyState(vk_menu)<0) then
    begin
       if wwHaveVisibleChild(ac) then exit;

       if (lparam and $80000000)=0 then begin
         if IsChildOfInspector(Inspector) then
         begin
            // Send to inspector navigation keys
            if (ac is TCustomEdit) then
            begin
               case wparam of
                 VK_LEFT:
                          if (Inspector.parent is TwwDBGrid) then // 6/13/02 - Left arrow can leave inspector when inspector is in grid
                          begin
                             if (not IsInExpandedGrid) and AllSelected then
                             begin
                                PostMessage(Inspector.Parent.handle, WM_KEYDOWN, wparam, 0);
                                result:=1;
                             end;
                             exit;
                          end
                          else if (Inspector.ColCount<=2) or (not LeftSide) then exit;

                 VK_Right:
                          if (Inspector.parent is TwwDBGrid) then // 6/13/02 - Left arrow can leave inspector when inspector is in grid
                          begin
                             if (not IsInExpandedGrid) and AllSelected then
                             begin
                                 PostMessage(Inspector.Parent.handle, WM_KEYDOWN, wparam, 0);
                                 result:=1;
                             end;
                             exit;
                          end
                          else if (Inspector.ColCount<=2) or (not RightSide) then exit;
//                 VK_RIGHT: if (Inspector.ColCount<=2) or (not RightSide) then exit;
               end
            end;

            if Inspector.FCustomControlKeyMode then exit
            else PostMessage(Inspector.handle, WM_KEYDOWN, wparam, 0);

            result:=1;
         end
       end
       else result:=1
    end

end;


destructor TwwDataInspector.Destroy;
begin
  if KeyHook<>0 then begin
     UnhookWindowsHookEx(KeyHook);
     KeyHook:= 0;
  end;
  FPaintOptions.Free;
  FIndicators.Free;
  FIndicators:=nil;

  if Designer <> nil then
  begin
     Designer.Free;
  end;
  FreeHintWindow;
  if HintTimer<>nil then
  begin
     HintTimer.enabled:= False;
     HintTimer:=nil;
  end;
  FDesigner:= nil;
  FItems.Free;

  FCaptionFont.Free;
  FCaptionFont:= Nil;

  FDataLink.free;
  FDataLink:= nil;
  FPaintBitmap.Free;
  FButtonOptions.Free;
  FIndicatorRow.Free;

  inherited;
end;

procedure TwwDataInspector.SetItems(Value: TwwInspectorCollection);
begin
  FItems.Assign(Value);
//  RowCount:= ActiveRows;
end;

procedure TwwDataInspector.SetDataSource(value : TDataSource);
begin
   FDataLink.dataSource:= value;
end;

Function TwwDataInspector.GetDataSource: TDataSource;
begin
   Result:= FdataLink.dataSource as TDataSource;
end;


Function TwwDataInspector.GetRowByItem(AItem: TwwInspectorItem): integer;
var curIndex, i: integer;
    found: boolean;
  function Scan(Item: TwwInspectorItem): boolean;
  var i: Integer;
  begin
     Result:= True;
     if Item=AItem then exit;
     inc(curIndex);
     if Item.Expanded then
     begin
        for i:= 0 to Item.Items.Count-1 do
           if Item.Items[i].visible and Scan(Item.Items[i]) then begin
              result:= True;
              exit;
           end
     end;
     result:=False;
  end;
begin
   if IndicatorRow.enabled then curIndex:= 1
   else curIndex:=0;
   found:= false;
   for i:= 0 to Items.count-1 do
      if Items[i].visible and Scan(Items[i]) then begin
         found:= True;
         break;
      end    ;
   if not found then curIndex:= -1;
   Result:= curIndex;
end;

Procedure TwwDataInspector.GetActiveRowsCallback(Item: TwwInspectorItem; UserData: Pointer; var AContinue: boolean);
begin
   if Item.visible then
      PInteger(UserData)^:= PInteger(UserData)^+1;
end;

Procedure TwwDataInspector.GetActiveItemCallback(Item: TwwInspectorItem; UserData: Pointer; var AContinue: boolean);
begin
   if Item.visible then
   begin
      if PInteger(UserData)^=Row then begin
         AContinue:= false;
         FActiveItem:= Item;
      end
      else PInteger(UserData)^:= PInteger(UserData)^+1;
   end
end;

Function TwwDataInspector.GetActiveRows: integer;
var ActiveRowCount: integer;
begin
   if IndicatorRow.enabled then ActiveRowCount:=1
   else ActiveRowCount:= 0;
   IterateItems(GetActiveRowsCallBack, True, @ActiveRowCount);
   Result:= ActiveRowCount;
end;

Function TwwDataInspector.RefreshActiveItem: TwwInspectorItem;
var ActiveRowCount: integer;
begin
   if FastDesign then
   begin
      if IndicatorRow.enabled then ActiveRowCount:=1
      else ActiveRowCount:= 0;
      IterateItems(GetActiveItemCallBack, True, @ActiveRowCount);
      Result:= FActiveItem;
   end
   else result:= ActiveItem;
end;

function TwwDataInspector.GetFirstChild(VisibleItemsOnly: boolean = True): TwwInspectorItem;
var i: integer;
begin
   result:= nil;

   for i:= 0 to Items.count-1 do begin
      if (not VisibleItemsOnly) or TwwInspectorItem(Items[i]).visible then begin
         result:= TwwInspectorItem(Items[i]);
         break;
      end
   end;
end;

Function TwwDataInspector.GetTopItem: TwwInspectorItem;
begin
  if FTopItem=nil then
  begin
     FTopItem:= GetFirstChild;
  end;

  if not FastDesign then
  begin
     FTopItem:= GetItemByRow(TopRow);
  end;

  result:= FTopItem;
end;

Function TwwDataInspector.GetItemByRow(ARow: integer; Optimize: boolean = True): TwwInspectorItem;
var curIndex: integer;
    RetObjItem: TwwInspectorItem;
    i: integer;

  function Scan(Item: TwwInspectorItem): boolean;
  var i: Integer;
  begin
     if not Item.visible then begin
        Result:= False;
        exit;
     end;

     Result:= True;

     inc(curIndex);
     if curIndex=ARow then
     begin
        RetObjItem:= Item;
        exit;
     end;
     if Item.Expanded then
     begin
        for i:= 0 to Item.Items.Count-1 do
           if Scan(Item.Items[i]) then break;
     end;
     result:=False;
  end;

begin
   if Optimize and FastDesign then
   begin
      if ARow=Row then begin
         result:= ActiveItem;
         exit;
      end
      else if (ARow>=TopRow) and (ARow<=TopRow+100) then
      begin
         retObjItem:= TopItem;
         if retObjItem<>nil then begin
            for i:= 1 to ARow-TopRow do
               retObjItem:= retObjItem.GetNext(True);
         end;
         result:= retObjItem;
         exit;
      end
   end;

   if Row<0 then begin
      result:= nil;
      exit;
   end;

   curIndex:= -1;
   if IndicatorRow.enabled then curIndex:=0;
   retObjItem:= nil;
   for i:= 0 to Items.count-1 do
      if Scan(Items[i]) then break;
   result:= retObjItem;
end;

Function TwwDataInspector.GetItemByCaption(ACaption: string): TwwInspectorItem;
var
    curItem: TwwInspectorItem;
begin
    result:= nil;
    curItem:= GetFirstChild(False);
    ACaption:= AnsiUppercase(ACaption);

    while curItem<>nil do
    begin
       if AnsiUppercase(curItem.caption) = ACaption then
       begin
          result:= curItem;
          break;
       end;
       curItem:= curItem.GetNext(False);
    end;
end;

Function TwwDataInspector.GetItemByTagString(ATagString: string): TwwInspectorItem;
var
    curItem: TwwInspectorItem;
begin
    result:= nil;
    curItem:= GetFirstChild(False);
    ATagString:= AnsiUppercase(ATagString);

    while curItem<>nil do
    begin
       if AnsiUppercase(curItem.tagstring) = ATagString then
       begin
          result:= curItem;
          break;
       end;
       curItem:= curItem.GetNext(False);
    end;
end;

Function TwwDataInspector.GetItemByFieldName(AFieldName: string): TwwInspectorItem;
var
    curItem: TwwInspectorItem;
begin
    result:= nil;
    curItem:= GetFirstChild(False);
    AFieldName:= AnsiUppercase(AFieldName);

    while curItem<>nil do
    begin
       if AnsiUppercase(curItem.datafield) = AFieldName then
       begin
          result:= curItem;
          break;
       end;
       curItem:= curItem.GetNext(False);
    end;
end;

function TwwDataInspector.ButtonPt(ARect: TRect; Obj: TwwInspectorItem): TPoint;
var pt: TPoint;
    MinY: integer;
    tempHeight: integer;
begin
   if Obj=nil then exit;

   if ovCenterCaptionVert in Options then
   begin
      MinY:= (Canvas.TextHeight('Y')+2) div 2;
      pt.y:= ARect.Top + wwMax(MinY, (ARect.Bottom-ARect.Top-2) div 2);
   end
   else begin

      tempHeight:= Canvas.TextHeight('Y')+2;
      if (not obj.Expanded) and (ButtonOptions.ExpandGlyph.Handle<>0) then
         tempHeight:= wwMax(ButtonOptions.ExpandGlyph.Height, tempHeight)
      else if (Obj.Expanded) and (ButtonOptions.CollapseGlyph.Handle<>0) then
         tempHeight:= wwMax(ButtonOptions.CollapseGlyph.Height, tempHeight);

      pt.y:= ARect.Top + (TempHeight) div 2;
   end;
   pt.x:= ARect.Left +(Obj.Level)*CaptionIndent + (CaptionIndent div 2) +1;
   result:= pt;
end;

function TwwDataInspector.CheckboxRect(ARect: TRect; Obj: TwwInspectorItem): TRect;
var cp: TPoint;
    offset: integer;
begin
   cp:= GetCenterPoint(ARect);
   Offset:= 5;
   Result:= Rect(ARect.Left + 3, cp.y-offset-2, ARect.Left+3*offset+5, cp.y+offset+1);
end;

procedure TwwDataInspector.DoDrawCaptionCell(ObjItem: TwwInspectorItem;
       ASelected: boolean;
       ACellRect: TRect;
       var ACaptionRect: TRect;
       var DefaultTextDrawing: boolean);
begin
   if Assigned(FOnDrawCaptionCell) then
       FOnDrawCaptionCell(self, ObjItem, ASelected, ACellRect, ACaptionRect,
       DefaultTextDrawing);
end;

procedure TwwDataInspector.DoDrawDataCell(ObjItem: TwwInspectorItem;
       ASelected: boolean;
       ACellRect: TRect;
       var DefaultDrawing: boolean);
begin
   if Assigned(FOnDrawDataCell) then
   begin
       FOnDrawDataCell(self, ObjItem, ASelected, ACellRect,
       DefaultDrawing);
   end;
end;

{procedure TwwDataInspector.DoDrawIndicatorCell(ObjItem: TwwInspectorItem;
       ACellRect: TRect;
       var DefaultDrawing: boolean);
begin
   if Assigned(FOnDrawIndicatorCell) then
   begin
       FOnDrawIndicatorCell(self, ObjItem, ACellRect, DefaultDrawing);
   end;
end;
}
function TwwDataInspector.isFocused: boolean;
begin
   result:= (Screen.ActiveControl=self) or { 3/6/00 - Check for nil active control}
            (Assigned(Screen.ActiveControl) and (Screen.ActiveControl.parent=self))
end;

Function TwwDataInspector.IsDefaultDateTimePicker(Obj: TwwInspectorItem): boolean;
begin
   result:= (iioAutoDateTimePicker in obj.Options) and
            (obj.Field is TDateTimeField)
end;

Function TwwDataInspector.IsDefaultLookupCombo(Obj: TwwInspectorItem): boolean;
begin
   result:= (iioAutoLookupCombo in obj.Options) and (obj.Field<>nil) and
            (obj.Field.Lookup)
end;

function TwwInspectorItem.GetChecked: boolean;
var value: string;
begin
   if field=nil then value:=EditText
   else value:= field.text;
   result:= (picklist.items.count>0) and (Value = picklist.items[0]);
end;

procedure TwwInspectorItem.SetChecked(val: boolean);
begin
   if picklist.items.count<2 then exit;

   if field<>nil then
   begin
      if not TwwDataInspector(Control).CanEditModify then exit;
      if val then
         field.text:= picklist.items[0]
      else
         field.text:= picklist.items[1];
      EditText:= field.text;
   end
   else begin
      if val then
         EditText:= picklist.items[0]
      else
         EditText:= picklist.items[1]
   end;

end;

procedure TwwDataInspector.DoCalcDataPaintText(item: TwwInspectorItem; var PaintText: string);
begin
   if Assigned(FOnCalcDataPaintText) then
      FOnCalcDataPaintText(self, Item, PaintText);
end;

{procedure TwwInspectorItem.ComboDropDownEvent(Sender: TObject);
var inspector: TwwDataInspector;
begin
   if Assigned(FOnEditButtonClick) then begin
      inspector:= Control as TwwDataInspector;
      FOnEditButtonClick(Inspector, self);
      if Inspector.CurrentCustomEdit is TwwDBComboBox then
         EditText:= TwwDBComboBox(Inspector.CurrentCustomEdit).value;
   end
end;
}

Function TwwInspectorItem.UseDefaultComboBox: boolean;
begin
   result:= not (PickList.DisplayAsCheckbox) and
            (PickList.Items.Count>0) or Assigned(FOnEditButtonClick)
end;

function TwwInspectorItem.GetDisplayText: string;
begin
   result:= GetMappedPaintText(EditText);
end;


procedure TwwInspectorItem.SetEditText(val: string);
begin
   if FEditText<>val then
   begin
      FEditText:= Val;
   end
end;

procedure TwwInspectorItem.SetDisplayText(val: string);
var i, curpos: integer;
    DisplayVal, StoredVal, OrigEditText: string;

   procedure UpdateActiveEdit;
   begin
     { If active control then update the control as well }
     if (Control is TwwDataInspector) then
        with (Control as TwwDataInspector) do
        begin
           if ActiveItem=self then
           begin
              if CurrentCustomEdit<>nil then
              begin
                 TEdit(CurrentCustomEdit).Text:= val
              end
              else if UseDefaultEditor and (InplaceEditor<>nil) then
              begin
                 InplaceEditor.text:= val;
              end
           end
        end;
    end;

begin
   OrigEditText:= EditText;

   if (not PickList.MapList) then begin
     EditText:= val;
     UpdateActiveEdit; // 12/4/00 
     if EditText<>OrigEditText then DoItemTextChanged;
     exit;
   end;

   for i:= 0 to PickList.Items.count-1 do begin
      curpos:= 1;
      DisplayVal:= strGetToken(PickList.Items[i], #9, curPos);
      StoredVal:= strGetToken(PickList.Items[i], #9, curPos);
      if wwEqualStr(DisplayVal, val) then begin
         editText:= StoredVal;
         break;
      end
   end;

   { If active control then update the control as well }
   UpdateActiveEdit;
   if EditText<>OrigEditText then DoItemTextChanged;

end;

Function TwwInspectorItem.GetMappedPaintText(StoredValue: string): string;
var i, curpos: Integer;
    DisplayVal : string;
begin
   result:= '';

{   if Field=nil then
      StoredValue:= EditText
   else StoredValue:= Field.asString;
}
   if not PickList.MapList then begin
     result:= StoredValue;
     exit;
   end;

   for i:= 0 to PickList.Items.count-1 do begin
      curpos:= 1;
      DisplayVal:= strGetToken(PickList.Items[i], #9, curPos);
      if strGetToken(PickList.Items[i], #9, curPos)=StoredValue then
      begin
         result:= DisplayVal;
         break;
      end
   end;
end;

  function sameRect(rect1, rect2: TRect): boolean;
  begin
     result:=
      (rect1.left = rect2.left) and
      (rect1.right = rect2.right) and
      (rect1.top = rect2.top) and
      (rect1.bottom = rect2.bottom);
  end;

function TwwDataInspector.ControlRect(ACol, ARow: integer): TRect;
begin
     result:= CellRect(ACol, ARow);
     result.Left:= result.Left +1;
//   if ColCount>2 then
     if ovActiveRecord3dlines in Options then
        result.right:= result.right-1
     else
        result.right:= result.right-1;
     result.Top:= result.Top;
     result.Bottom:= result.Top + RowHeights[ARow]-1; //obj.cellHeight;
end;

  procedure TwwDataInspector.FillWithAlternatingRowBitmap(TempRect: TRect);
  begin
         if PaintOptions.AlternatingColorBitmap<>nil then
            Canvas.CopyRect(TempRect,PaintOptions.AlternatingColorBitmap.canvas,TempRect)
         else begin
            Canvas.Brush.Color:= PaintOptions.AlternatingRowColor;
            Canvas.FillRect(TempRect);
         end
  end;

procedure TwwDataInspector.FillWithFixedBitmap(
   TempRect: TRect; CurRelRow: integer);
begin
     if (PaintOptions.AlternatingRowColor<>clNone) and
        (arrFixedColumns in PaintOptions.AlternatingRowRegions) and
        (CurRelRow>=0) and
        Odd(CurRelRow) then
     begin
         FillWithAlternatingRowBitmap(TempRect);
     end
     else if PaintOptions.Column1Bitmap<>nil then begin
        Canvas.CopyRect(TempRect,PaintOptions.Column1Bitmap.canvas,TempRect);
     end
     else if (parent is TwwDBGrid) and (CaptionColor=clNone) then
     begin
//         if not (csPaintCopy in ControlState) then
//            TwwDBGrid(parent).PaintActiveRowBackground(Canvas, TempRect);
     end
     else if not Assigned(FOnBeforePaint) and (CaptionColor<>clNone) then begin
        Canvas.Brush.Color:=PaintOptions.Column1Color;
        Canvas.FillRect(TempRect);
     end
end;

procedure TwwDataInspector.DisplayIndicatorCell(aCol: integer; ARect: TRect);
const
  AlignFlags : array [TAlignment] of Integer =
    ( DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX,
      DT_RIGHT or DT_EXPANDTABS or DT_NOPREFIX,
      DT_CENTER or DT_EXPANDTABS or DT_NOPREFIX );
var Indicator: integer;
    ALeft: integer;
    Flags: integer;
    DefaultDrawing: boolean;
   Function GetTitleRect: TRect;
   var TitleRect: TRect;
   begin
      result:= TitleRect;
   end;
begin
      DefaultDrawing:= True;
      if Assigned(FOnDrawIndicatorCell) then
      begin
          FOnDrawIndicatorCell(self, ACol, ARect, DefaultDrawing);
          if not DefaultDrawing then exit;
      end;

      if (ACol=0) and (IndicatorRow.Caption<>'') then
      begin
         SetBkMode(Canvas.Handle, TRANSPARENT);
         if IndicatorRow.TextAlignment = taLeftJustify then
            ARect:= Rect(ARect.Left + CaptionIndent, ARect.Top + 1,
                          ARect.Right, ARect.Bottom)
         else
            ARect:= Rect(ARect.Left, ARect.Top + 1,
                          ARect.Right, ARect.Bottom);

         try
            Flags:= AlignFlags[IndicatorRow.TextAlignment];
            DrawText(Canvas.Handle, PChar(IndicatorRow.Caption), length(IndicatorRow.Caption),
                        ARect, Flags);
         finally
           SetBkMode(Canvas.Handle, OPAQUE);
         end
      end;

      if (not FDataLink.Active) or ((ACol-1) <> FDataLink.ActiveRecord) then exit;

      Indicator := 0;
      if FDataLink.DataSet <> nil then
      begin
        case FDataLink.DataSet.State of
            dsEdit: Indicator := 1;
            dsInsert: Indicator := 2;
            dsBrowse:;
        end;
      end;
//      FIndicators.BkColor := FixedColor;
      ALeft:= wwMax(0, ((ARect.Right+ARect.Left)-FIndicators.Width) div 2);
//      ALeft := ARect.Right - FIndicators.Width;
//       if Canvas.CanvasOrientation = coRightToLeft then Inc(ALeft);
//      Canvas.Brush.Color:= FixedColor;
      FIndicators.Draw(Canvas, ALeft,
          (ARect.Top + ARect.Bottom - FIndicators.Height) shr 1, Indicator, True);
end;

procedure TwwDataInspector.DrawCell(ACol, ARow: Integer;
  ARect: TRect; AState: TGridDrawState);
var
   obj: TwwInspectorItem;
   customEdit: TWinControl;
//   FoundCustomEdit: boolean;
   DrawTextRect, TitleRect: TRect;
   TextHeight: integer;
   Flags: integer;
   DefaultDrawing, DefaultTextDrawing: boolean;
//   LookupCombo: TwwDBLookupCombo;
   PaintText: string;
   StoredValue: string;
   OldActiveRecord: integer;
//   bm: TBitmap;
   TempRect: TRect;
   savedDC: integer;
   BackRect: TRect;
   NoData: boolean;
//   t: integer;
   {$ifdef wwDelphi7Up}
   Details: TThemedElementDetails;
   {$endif}

  procedure PaintInactiveCustomControl;
  var exStyle, origStyle: longint;
      tempRect: TRect;
    procedure PaintControl(Control: TWinControl; ARect: TRect);
    var i: integer;
        SaveIndex: integer;
    begin
      Control.ControlState:= Control.ControlState + [csPaintCopy] ;
      SaveIndex := SaveDC(Canvas.Handle);
      MoveWindowOrg(Canvas.Handle, ARect.Left, ARect.Top);
      IntersectClipRect(Canvas.Handle, 0, 0, ARect.Right-ARect.Left,
         ARect.Bottom - ARect.Top);
      Control.Perform(WM_PAINT, Canvas.Handle,
                      ARect.Bottom - ARect.Top);
      with Control do begin
         for I := 0 to ControlCount - 1 do
         begin
            if Controls[i] is TWinControl then
              with TWinControl(Controls[I]) do
                 if Visible then
                    PaintTo(Canvas.Handle, Left, Top);
         end
      end;
      RestoreDC(Canvas.Handle, SaveIndex);
      Control.ControlState:= Control.ControlState - [csPaintCopy];
    end;
  begin
     CustomEdit:= obj.CustomControl;
     InitCustomEdit(CustomEdit, obj);

     if (obj.datafield='') or (obj.datasource=nil) then
     begin
        CustomEdit.HandleNeeded;
        if CustomEdit is TCustomEdit then
           TEdit(CustomEdit).Text:= obj.EditText;
     end;

     temprect:= ControlRect(ACol, ARow);
     if (temprect.right-temprect.left<>customEdit.Width) or
       (temprect.bottom-temprect.top<>customEdit.height) then
     begin
        customEdit.width:= tempRect.Right-tempRect.Left;
        customEdit.Height:= tempRect.Bottom-TempRect.Top;
     end;
//     if (customEdit.Width<>ARect.Right-ARect.Left-2) or
//        (customEdit.Height<>ARect.Bottom-ARect.Top-1) then
//     begin
//        customEdit.width:= ARect.Right-ARect.Left-2;
//        customEdit.Height:= ARect.Bottom-ARect.Top-1;
//     end;
//     customEdit.BoundsRect:= ControlRect(ACol, ARow);

     begin
        OrigStyle:= Windows.GetWindowLong(customEdit.handle, GWL_EXSTYLE);
        exStyle:= OrigStyle or WS_EX_TRANSPARENT;

        Canvas.Lock;
        try
          Windows.SetWindowLong(customEdit.handle, GWL_EXSTYLE, exStyle);
{          if (ARow=Row) and (ACol=Col) then
          begin
            Canvas.Brush.Color:= clHighlight;
            Canvas.FillRect(ARect);
          end;
}
          SetBkMode(Canvas.Handle, TRANSPARENT);
          if (customEdit is TwwDBRichEdit) and (obj.field<>nil) and False then
          begin
             if tempRichEdit=Nil then begin
                tempRichEdit:= TwwDBRichEdit.create(self);
                tempRichEdit.visible:= False;
                tempRichEdit.parent:= self;
                tempRichEdit.borderStyle:= bsNone;
                if csDesigning in ComponentState then {otherwise shows up at design time }
                  ShowWindow(tempRichEdit.handle, sw_hide);
                Windows.SetWindowLong(tempRichEdit.handle, GWL_EXSTYLE, exStyle);
             end;
             tempRichEdit.Lines.Assign(obj.Field);
             TempRect:= ARect;
             TempRect.Bottom:= TempRect.Bottom - 2;
             TempRect.Right:= TempRect.Right - 6;
             tempRichEdit.BoundsRect:= TempRect;//customEdit.BoundsRect;
             tempRichEdit.PaintTo(Canvas.Handle, TempRect.Left, TempRect.Top);
          end
          else //customEdit.PaintTo(Canvas.Handle, ARect.Left+1, ARect.Top);
          begin
             TempRect:= ARect;
             TempRect.Left:= TempRect.Left  + 1;
             PaintControl(CustomEdit, TempRect);
          end;

        finally
          SetBkMode(Canvas.Handle, OPAQUE);
          Canvas.Unlock;
          Windows.SetWindowLong(customEdit.handle, GWL_EXSTYLE, OrigStyle);
//          customEdit.Update;
        end;

     end;

  end;

   procedure PaintCheckbox;
   const MaxCheckboxSize = 6;
        ItemChecked: array[Boolean] of Integer = (0, DFCS_CHECKED);
        Grayed: array[Boolean] of Integer = (0, DFCS_INACTIVE);
   var
      value: string;
      val: boolean;
      {$ifdef wwDelphi7Up}
      CheckboxStyle: TThemedButton;
      Details: TThemedElementDetails;
      PaintRect: TRect;
      {$endif}
      sp, cp: TPoint;
      cr: TRect;
   begin
      if obj.field=nil then value:=obj.EditText
      else value:= obj.field.text;

      if wwUseThemes(self) then
      begin
         {$ifdef wwDelphi7Up}
         val:= value=obj.picklist.items[0];
         if obj.ReadOnly or (not obj.Enabled) then
         begin
            if val then CheckboxStyle:= tbCheckboxCheckedDisabled
            else CheckboxStyle:= tbCheckboxUnCheckedDisabled
         end
         else begin
            GetCursorPos(cp);
            sp:= self.ScreenToClient(cp);
            cr:= cellrect(ACol, ARow);

            // Only change mouseover for active record
            if (ptinrect(cr, sp)) and (Col=ACol) then begin
               HotCol:= ACol;
               HotRow:= ARow;
               if val then CheckboxStyle:= tbCheckboxCheckedHot
               else CheckboxStyle:= tbCheckboxUnCheckedHot
            end
            else begin
               if val then CheckboxStyle:= tbCheckboxCheckedNormal
               else CheckboxStyle:= tbCheckboxUnCheckedNormal
            end;
         end;
         Details := ThemeServices.GetElementDetails(CheckboxStyle);
         PaintRect := CheckboxRect(ARect, obj);
         ThemeServices.DrawElement(Canvas.Handle, Details, PaintRect);
         {$endif}
      end
      else
         DrawFrameControl(Canvas.Handle, CheckboxRect(ARect, obj),
             DFC_BUTTON, Grayed[not obj.Enabled] or
             DFCS_BUTTONCHECK or ItemChecked[value=obj.picklist.items[0]]);
   end;

   procedure PaintButton;
   var pt: TPoint;
       offset: integer;
       OrigColor: TColor;
       buttonsize: integer;
       buttonoffset: integer;
       buttonRect: TRect;
       src, dest: TRect;
      {$ifdef wwDelphi7Up}
       style: TThemedTreeview;
       Details: TThemedElementDetails;
       {$endif}
   begin
      pt:= ButtonPt(ARect, obj);
      obj.ButtonPoint:= pt;

      if not obj.expanded then
      begin
         with ButtonOptions.ExpandGlyph do
         begin
            if Handle<>0 then
            begin
               src:= Rect(0, 0, Width, Height);
               src.bottom:= wwMin(Height, ARect.Bottom-ARect.Top-1);
               dest.left:= pt.x - (Width div 2);
               if ovCenterCaptionVert in Options then
                  dest.top:= pt.y - ((Height-1) div 2)
               else
                  dest.top:= pt.y - (Height div 2);
               dest.right:= dest.left + src.right;
               dest.bottom:= dest.top + src.bottom;
               if ButtonOptions.TransparentGlyphs then begin
                  TransparentMode := tmAuto;
                  Transparent:= True;
                  self.Canvas.Draw(dest.left, dest.top,ButtonOptions.ExpandGlyph);
               end
               else self.Canvas.CopyRect(dest, Canvas, src);
               exit;
            end
         end
      end
      else begin
         with ButtonOptions.CollapseGlyph do
         begin
            if Handle<>0 then
            begin
               src:= Rect(0, 0, Width, Height);
               src.bottom:= wwMin(Height, ARect.Bottom-ARect.Top-1);
               dest.left:= pt.x - (Width div 2);
               if ovCenterCaptionVert in Options then
                  dest.top:= pt.y - ((Height-1) div 2)
               else
                  dest.top:= pt.y - (Height div 2);
               dest.right:= dest.left + src.right;
               dest.bottom:= dest.top + src.bottom;

               if ButtonOptions.TransparentGlyphs then begin
                  TransparentMode := tmAuto;
                  Transparent:= True;
                  self.Canvas.Draw(dest.left, dest.top,ButtonOptions.CollapseGlyph);
               end
               else self.Canvas.CopyRect(dest, Canvas, src);

               exit;
            end
         end
      end;

      if wwUseThemes(self) then
      begin
          {$ifdef wwDelphi7Up}
          buttonsize:= 5;
          buttonoffset:= 0;
          buttonRect:= Rect(pt.x-buttonsize, pt.y-(buttonsize-1)+ buttonoffset,
                   pt.x+buttonsize-1, pt.y+buttonsize+ buttonoffset);
          if obj.expanded then
             Style:= ttGlyphOpened
          else
             Style:= ttGlyphClosed;
          Details := ThemeServices.GetElementDetails(Style);
          ThemeServices.DrawElement(Canvas.Handle, Details, ButtonRect);
          exit;
          {$endif}
      end;
      buttonsize:= 5;
      buttonoffset:= 0;
      OrigColor:= Canvas.Brush.Color;
      Offset:= 2;
      Canvas.Brush.Color := clWindow;
      Canvas.FillRect(Rect(pt.x-(buttonsize-2), pt.y-(buttonsize-1)+buttonoffset,
                        pt.x+buttonsize-2, pt.y+buttonsize-1+ buttonoffset));
      Canvas.Pen.Color := clBlack;
      Canvas.Rectangle(pt.x-buttonsize, pt.y-(buttonsize-1)+ buttonoffset,
                   pt.x+buttonsize-1, pt.y+buttonsize+ buttonoffset);
      Canvas.Pen.Color := clBlack;
      if not obj.expanded then
         Canvas.Polyline([Point(pt.x-1, pt.y-Offset+ buttonoffset),
                          Point(pt.x-1, pt.y+Offset+1+buttonoffset)]);
      Canvas.Polyline([Point(pt.x-Offset-1, pt.y+buttonoffset),
                             Point(pt.x+Offset, pt.y+buttonoffset)]);
      Canvas.Brush.Color:= OrigColor;
   end;

   Function GetTitleRect: TRect;
   var TitleRect: TRect;
   begin
      TitleRect:= Rect(ARect.Left + (Obj.Level+1) * CaptionIndent, ARect.Top + 1,
                          ARect.Right, ARect.Bottom);
      result:= TitleRect;
   end;

  function DefaultDrawCell(obj: TwwInspectorItem): boolean;
  var
    Hold: Integer;
    DefaultDrawing: boolean;
  begin
    DefaultDrawing:= True;
    if Assigned(FOnDrawDataCell) then
    begin
      if UseRightToLeftAlignment then
      begin
        ARect.Left := ClientWidth - ARect.Left;
        ARect.Right := ClientWidth - ARect.Right;
        Hold := ARect.Left;
        ARect.Left := ARect.Right;
        ARect.Right := Hold;
        ChangeOrientation(False);
      end;
      ARect.Bottom:= ARect.Bottom - 1;
      Obj.ActiveRecord:= ACol=Col;
      DoDrawDataCell(Obj, ARow=Row, ARect, DefaultDrawing);
//      FOnDrawDataCell(Self, Obj, ARow=Row, ARect, DefaultDrawing);
      ARect.Bottom:= ARect.Bottom + 1;
      if UseRightToLeftAlignment then ChangeOrientation(True);
    end;

    result:= DefaultDrawing;
  end;

  Function CustomEditHasFocus: boolean;
  var ac: TWinControl;
  begin
    // 7/16/01 - Inspector in grid should always paint custom controls
    if csPaintCopy in ControlState then
    begin
       result:= false;
       exit;
    end;
    if ((Row<>ARow) or (Col<>ACol)) then
    begin
       result:=False;
       exit;
    end;

    result:= False;
    ac:= Screen.ActiveControl;
    if (ac<>nil) then
    begin
       if (ac=obj.CustomControl) or
          (ac.parent=obj.CustomControl) then result:= True;
    end;
  end;


begin
    if UseTempCanvas then begin
//       if (ACol=1) and (not UseCheckbox(ARow)) then exit { Paint caption area only }
    end
    else begin
       if (ACol=0) or UseCheckbox(ARow) then exit; { Paint data area only }
    end;

{  if csPaintCopy in ControlState then
  begin
     screen.cursor:= crarrow;
  end;
}
   if IndicatorRow.enabled and (ARow=0) then
   begin
      Canvas.Font.Assign(FCaptionFont);
      if PaintOptions.Row1Bitmap<>nil then begin
         if ovHideVertFixedLines in Options then
            TempRect:= Rect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom)
         else TempRect:= Rect(ARect.Left+1, ARect.Top, ARect.Right-1, ARect.Bottom);
         Canvas.CopyRect(TempRect, PaintOptions.Row1Bitmap.canvas, TempRect);
         DisplayIndicatorCell(ACol, ARect);
      end
      else begin
         Canvas.Brush.Color:= IndicatorRow.Color;
         Canvas.FillRect(Rect(ARect.Left+1, ARect.Top-1, ARect.Right-1, ARect.Bottom));
         DisplayIndicatorCell(ACol, ARect);
      end;
      exit;
   end;

   Obj:= GetItemByRow(ARow);

   if Obj=nil then exit;

   if FDataLink.Active and ((ACol>1) or ((ACol>0) and (ColCount>2))) then
   begin
      NoData:= False;
      if (FDataLink.RecordCount=0) and (ACol>1) then NoData:= true; // If no record, then only paint 1 data column
      if (FDataLink.RecordCount<>0) and
         (FDataLink.RecordCount<=ACol-1) then NoData:= True;
      if NoData then
      begin
         TempRect:= Rect(ARect.Left, ARect.Top, ARect.Right-1, ARect.Bottom);
         TempRect.Left:= TempRect.Left-1;
         if PaintOptions.HaveBackgroundForDataCells then begin
            Canvas.CopyRect(TempRect, PaintOptions.OrigBitmap.canvas,TempRect);
         end
         else begin
            Canvas.Brush.Color:= Color;
            Canvas.FillRect(TempRect);
         end;
         exit;
      end;

      OldActiveRecord:= FDataLink.ActiveRecord;
      FDataLink.ActiveRecord:= ACol-1;
   end
   else OldActiveRecord:=-1;

   SavedDC:= 0;
   BackRect:= ARect;
   BackRect.left:= ARect.left-1;
//   if ovHideVertDataLines in Options then ARect.Left:= ARect.Left -1;

   try with Obj do begin

      if ACol=0 then begin
         if (InactiveFocusColor=clNone) or (ARow<>Row) or IsFocused then
            Canvas.Brush.Color:= FixedColor
         else
            Canvas.Brush.Color:= InactiveFocusColor;
         Canvas.Font.Assign(FCaptionFont);
         if (PaintCopyTextColor<>clNone) and (csPaintCopy in ControlState) {and
            (PaintOptions.OrigBitmap=nil) }then
         begin
            Canvas.Font.Color:= PaintCopyTextColor;
         end;

         try
           TitleRect:= GetTitleRect;

           SetBkMode(Canvas.Handle, TRANSPARENT);
           Flags:= DT_LEFT or DT_END_ELLIPSIS{ or DT_WORDBREAK};
           TextHeight:=
              DrawText(Canvas.Handle, PChar(obj.Caption), length(obj.Caption), TitleRect, Flags or DT_CALCRECT);
           TitleRect:= GetTitleRect;
           if ovCenterCaptionVert in self.Options then begin
              TitleRect.Top:= TitleRect.Top +
                           ((TitleRect.bottom-TitleRect.Top) - (TextHeight+2)) div 2;
           end;

           SetBkMode(Canvas.Handle, TRANSPARENT); { could be reset by PaintButton }
           DefaultTextDrawing:= True;
           ARect.Right:= ARect.Right - 1;
           FillWithFixedBitmap(ARect, ARow);

//           ARect.Bottom:= ARect.Bottom - 1;
(*           if (PaintOptions.AlternatingRowColor<>clNone) and
              (arrFixedColumn in PaintOptions.AlternatingRowRegions) and
              Odd(ARow) then
           begin
               TempRect:= Rect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
               if PaintOptions.AlternatingColorBitmap<>nil then
                  Canvas.CopyRect(TempRect,PaintOptions.AlternatingColorBitmap.canvas,TempRect)
               else begin
                  Canvas.Brush.Color:= PaintOptions.AlternatingRowColor;
                  Canvas.FillRect(TempRect);
               end
           end
           else if (PaintOptions.Column1Bitmap<>nil) { and not (csPaintCopy in ControlState) } then begin
               TempRect:= Rect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
               Canvas.CopyRect(TempRect,PaintOptions.Column1Bitmap.canvas,TempRect);
           end;
*)
           DoDrawCaptionCell(obj, (ARow=Row), ARect, TitleRect,
              DefaultTextDrawing);
           ARect.Bottom:= ARect.Bottom + 1;
           ARect.Right:= ARect.Right + 1;

           if DefaultTextDrawing then begin
              DrawText(Canvas.Handle, PChar(obj.Caption), length(obj.Caption), TitleRect, Flags);
              if obj.HaveVisibleItem then PaintButton;
              PaintLines(obj);
           end
         finally
           SetBkMode(Canvas.Handle, OPAQUE);
         end

      end
      else begin
         Canvas.Font.Assign(self.Font);
         if (PaintCopyTextColor<>clNone) and (csPaintCopy in ControlState) then
         begin
            Canvas.Font.Color:= PaintCopyTextColor;
         end;
         if (InactiveFocusColor=clNone) or (ARow<>Row) or Focused then
            Canvas.Brush.Color:= Color
         else
            Canvas.Brush.Color:= InactiveFocusColor;
         if (Color<>clNone) and (ARow=Row) and OldDesigning then Canvas.FillRect(BackRect);

         // Bug in new ado delphi5 update pack 2 requires this
         if (Field<>nil) and (field.dataset<>nil) and (field.dataset.active) then
            PaintText:= Field.DisplayText
         else PaintText:= obj.EditText;


         if (parent is TwwDBGrid) then
         begin
         end
         else if (PaintOptions.AlternatingRowColor<>clNone) and Odd(ARow) and
            (((ACol=Col) and (arrActiveDataColumn in PaintOptions.AlternatingRowRegions)) or
             ((ACol<>Col) and (arrDataColumns in PaintOptions.AlternatingRowRegions))) then
         begin
            TempRect:= Rect(ARect.Left, ARect.Top, ARect.Right-1, ARect.Bottom);
            if (ovHideVertDataLines in self.Options) then TempRect.Left:= TempRect.Left-1;
            if PaintOptions.AlternatingColorBitmap<>nil then
               Canvas.CopyRect(TempRect,PaintOptions.AlternatingColorBitmap.canvas,TempRect)
            else begin
               Canvas.Brush.Color:= PaintOptions.AlternatingRowColor;
               Canvas.FillRect(TempRect);
            end
         end
         else if (ACol=Col) and (PaintOptions.ActiveRecordColor<>clNone) then begin
            TempRect:= Rect(ARect.Left, ARect.Top, ARect.Right-1, ARect.Bottom);
            if (ovHideVertDataLines in self.Options) then TempRect.Left:= TempRect.Left-1;
            if PaintOptions.ActiveRecordBitmap<>nil then
              Canvas.CopyRect(TempRect,PaintOptions.ActiveRecordBitmap.canvas,TempRect)
            else begin
              Canvas.Brush.Color:= PaintOptions.ActiveRecordColor;
              Canvas.FillRect(TempRect);
            end
         end
         else if PaintOptions.HaveBackgroundForDataCells then begin
            TempRect:= Rect(ARect.Left, ARect.Top, ARect.Right-1, ARect.Bottom);
            if (ovHideVertDataLines in self.Options) then TempRect.Left:= TempRect.Left-1;
            Canvas.CopyRect(TempRect, PaintOptions.OrigBitmap.canvas,TempRect);
         end;

         DefaultDrawing:= DefaultDrawCell(Obj);

         if DefaultDrawing then
         begin
            DoCalcDataPaintText(obj, PaintText);

            if (obj.CustomControl<>nil) and (obj.CustomControlAlwaysPaints) then
            begin
               if (not CustomEditHasFocus) then
               begin
                  PaintInactiveCustomControl;
                  exit;
               end
            end;

            if (ACol=Col) and (ARow=Row) and (ColCount>2) and EffectiveFocused then
            begin
               if ((obj.CustomControl<>nil) and
                  (not wwGetAlwaysTransparent(obj.CustomControl))) or
                  ((obj.customcontrol=nil)) then
               begin
                 savedDC:= SaveDC(Canvas.Handle);
                 //10/09/2001-Suggestion to add new property to respect diabledefaulteditor property add focusrect instead of highlight. (PYW)
//                 if (obj.CustomControl<>nil) or not (obj.disabledefaulteditor) then begin
                    Canvas.Brush.Color:= clHighlight;
                    Canvas.FillRect(Rect(ARect.Left+1, ARect.Top, ARect.Right-1, ARect.Bottom-1));
                    SetTextColor(Canvas.Handle, ColorToRGB(clHighlightText));
//                 end
//                 else Canvas.DrawFocusRect(Rect(ARect.Left+1, ARect.Top, ARect.Right-1, ARect.Bottom-1));
               end
            end;

{            if FFocused then
               begin
                   if wwGetAlwaysTransparent(obj.CustomControl) then
                   begin
                     TempRect:= Rect(ARect.Left+1, ARect.Top, ARect.Right-1, ARect.Bottom);
                     Canvas.CopyRect(TempRect, OrigBitmap.canvas,TempRect);
                   end
               end
            end
            else }if (Field is TBlobField) and (TBlobField(Field).datatype in [ftMemo, ftOraBlob, ftOraCLob]) then
            begin
               SetBkMode(Canvas.Handle, TRANSPARENT);
               try
                  Flags:= DT_LEFT or DT_END_ELLIPSIS or DT_NOPREFIX;
                  if obj.WordWrap then Flags:= Flags or DT_WORDBREAK;
                  DrawTextRect:= ARect;
                  DrawTextRect.Left:= ARect.Left + 2;
                  DrawTextRect.Top:= ARect.Top + 1;
                  DrawText(Canvas.Handle, PChar(Field.asString), length(Field.asString),
                        DrawTextRect, Flags);
               finally
                  SetBkMode(Canvas.Handle, OPAQUE);
               end
            end
            else if (obj.PickList.items.count>0) and (obj.PickList.DisplayAsCheckbox) then begin
               PaintCheckbox;
            end
            else if (obj.CustomControl=nil) or not obj.CustomControlAlwaysPaints then
            begin
               SetBkMode(Canvas.Handle, TRANSPARENT);
               try
                  DrawTextRect:= ARect;
                  DrawTextRect.Left:= ARect.Left + 2;
                  DrawTextRect.Top:= ARect.Top + 1;
                  if obj.Alignment=taRightJustify then
                  begin
                     Flags:= DT_RIGHT or DT_END_ELLIPSIS or DT_NOPREFIX;
                     DrawTextRect.Right:= DrawTextRect.Right-2;
                  end
                  else
                     Flags:= DT_LEFT or DT_END_ELLIPSIS or DT_NOPREFIX;
                  if obj.WordWrap then Flags:= Flags or DT_WORDBREAK;

                  if obj.UseDefaultComboBox then
                  begin
                     if (Field=nil) then StoredValue:= EditText
                     else if self.FDataLink.Active then // 8/7/01 - Avoid error if inactive
                        StoredValue:= Field.asString
                     else StoredValue:= '';
                     PaintText:= obj.GetMappedPaintText(StoredValue);
                  end;

                  if (not obj.Enabled) then
                  begin
                     if wwUseThemes(self) then
                     begin
                        {$ifdef wwDelphi7Up}
                        Details := ThemeServices.GetElementDetails(teEditTextDisabled);
//                        ThemeServices.DrawElement(Canvas.Handle, Details, DrawTextRect);
                        ThemeServices.DrawText(Canvas.Handle, Details, PaintText, DrawtextRect, Flags, 0);
                        exit;
                        {$endif}
                     end
                     else
                        Canvas.font.color:= clGrayText;
                  end;
                  DrawText(Canvas.Handle, PChar(PaintText), length(PaintText),
                        DrawTextRect, Flags);
               finally
                  SetBkMode(Canvas.Handle, OPAQUE);
               end
            end
(*            else begin
               //! Maybe draw focus rect instead for active column
{               if (ACol=Col) and (ARow=Row) then
               begin
                  InflateRect(ARect, -1, -1);
                  InflateRect(ARect, 1, 1);
               end;
}
               SetBkMode(Canvas.Handle, TRANSPARENT);
               try
                  DrawTextRect:= ARect;
                  DrawTextRect.Left:= ARect.Left + 2;
                  DrawTextRect.Top:= ARect.Top + 1;
                  if obj.Alignment=taRightJustify then
                  begin
                     Flags:= DT_RIGHT or DT_END_ELLIPSIS or DT_NOPREFIX;
                     DrawTextRect.Right:= DrawTextRect.Right-2;
                  end
                  else
                     Flags:= DT_LEFT or DT_END_ELLIPSIS or DT_NOPREFIX;
                  if obj.WordWrap then Flags:= Flags or DT_WORDBREAK;
                  DrawText(Canvas.Handle, PChar(PaintText), length(PaintText),
                      DrawTextRect, Flags);
               finally
                  SetBkMode(Canvas.Handle, OPAQUE);
               end
            end;
*)
         end
      end
   end;
   finally
      if FDataLink.Active and ((ACol>1) or ((ACol>0) and (ColCount>2))) then
         FDataLink.ActiveRecord:= OldActiveRecord;
      if savedDC<>0 then
        RestoreDC(Canvas.Handle, savedDC);
   end

end;

function TwwDataInspector.GetEditText(ACol, ARow: Longint): string;
var Obj: TwwInspectorItem;
begin
   obj:= GetItemByRow(ARow);
   if obj=nil then exit;

   if obj.Field=nil then begin
      result:= obj.EditText;
      exit;
   end;
   // 2/28/01 - Check that dataset is open (required for closed dataset's that
   // can't handle reference to text property, i.e. TADOTable)
   // This probelm is introduced with delphi5 update pack 2
   if (obj.field.dataset<>nil) and (not obj.field.dataset.active) then
   begin
      result:= ''
   end
   else if (obj.Field is TBlobField) and (TBlobField(obj.Field).DataType in [ftMemo, ftOraBlob, ftOraCLob]) then
   begin
      result:= obj.Field.asString;
   end
   else begin
      result:= obj.Field.text;
   end;
//   obj.OrigEditText:= result;
//   obj.EditText:= result;
   FEditText:= Result;
end;

procedure TwwDataInspector.SetEditText(ACol, ARow: Longint; const Value: string);
var Obj: TwwInspectorItem;
begin
   if SkipUpdateEditText then exit;

   obj:= GetItemByRow(ARow);
   if obj<>nil then obj.EditText:= Value; { 1/21/2000-Check for nil pointer in SetEditText}
   FEditText := Value;
end;

procedure TwwDataInspector.UpdateDataColumnWidth;
var NewColWidth1, ACol: integer;
    ECaptionWidth: integer;
begin
   if (ovHideCaptionColumn in Options) then ECaptionWidth:= 0
   else ECaptionWidth:= CaptionWidth;

   if VisibleRowCount>RowCount then
     NewColWidth1:= ClientWidth - ECaptionWidth -
                    GetSystemMetrics(SM_CXHThumb)// - (ColCount-2)
//   else if parent is TCustomGrid then
//     NewColWidth1:= Width - 15 - ColWidths[0]
   else
     NewColWidth1:= ClientWidth - ECaptionWidth;// - (ColCount-2);

   if ColCount=2 then
      ColWidths[1]:= NewColWidth1
   else begin
//     DefaultColWidth:= (NewColWidth1 div (DataColumns));
     for ACol:= 1 to ColCount-1 do
     begin
        ColWidths[ACol]:= //(NewColWidth1 div (ColCount-1));
                       ((NewColWidth1) div (DataColumns));
     end;

     // Force data columns to all be same size
//     ColWidths[0]:= ClientWidth - DataColumns*ColWidths[1]

     // Be as close to possible as CaptionWidth, never less
     // 6/7/01
//     ColWidths[0]:= (CaptionWidth + DataColumns-1) * DataColumns div DataColumns
       ColWidths[0]:= ClientWidth-(ColWidths[1]*DataColumns);
   end;

   if CurrentCustomEdit<>nil then
   begin
      CurrentCustomEdit.BoundsRect:= ControlRect(Col, Row);
   end;

end;

procedure TwwDataInspector.UpdateRowCount;
var numRows: integer;
begin
   if not (csLoading in ComponentState) and CheckRowCount then
   begin
      numRows:= GetActiveRows;
      if (RowCount<>NumRows) and (NumRows>0) then
      begin
        RowCount:= NumRows;
      end;
      CheckRowCount:= False;
   end;
end;

procedure TwwDataInspector.RefreshItem(Item: TwwInspectorItem);
var curRow: integer;
//    numRows: integer;
begin
   if csLoading in ComponentState then exit;
   if Items.UpdateCount>0 then exit;

{   if not (csLoading in ComponentState) and CheckRowCount then
   begin
      numRows:= GetActiveRows;
      if (RowCount<>NumRows) and (NumRows>0) then
        RowCount:= NumRows;
      CheckRowCount:= False;
   end;
}
   if Item=nil then exit;
   curRow:= GetRowByItem(Item);
   if (curRow>=0) then begin
      if Item.CellHeight=0 then RowHeights[curRow]:= inherited DefaultRowHeight
      else RowHeights[curRow]:= Item.CellHeight;
   end
end;

Procedure TwwDataInspector.ApplySettingsCallback(Item: TwwInspectorItem; UserData: Pointer; var AContinue: boolean);
var currentRow: PInteger;
begin
   currentRow:= PInteger(UserData);
   if Item.CustomControl<>nil then
   begin

      if Item.CustomControl.handleAllocated then
         Item.CustomControl.Enabled:= Item.Enabled;

      TEdit(Item.CustomControl).ControlStyle:=
           TEdit(Item.CustomControl).ControlStyle + [csNoDesignVisible];
   end;
   if not Item.visible then exit;

   if Item.CellHeight>0 then
      RowHeights[CurrentRow^]:= Item.CellHeight
   else RowHeights[CurrentRow^]:= inherited DefaultRowHeight;
   CurrentRow^:= CurrentRow^ + 1;
end;

procedure TwwDataInspector.ApplySettings;
var i: Integer;
    Item: TwwInspectorItem;
    curRow: integer;
    numRows: integer;
begin
   if csLoading in ComponentState then exit;

   BeginUpdate;

   Canvas.Font.Assign(self.Font);

   FMinRowHeight:= Canvas.TextHeight('0')+3;
   if DefaultRowHeight=0 then begin
      if FMinRowHeight<>inherited DefaultRowHeight then
         inherited DefaultRowHeight:= FMinRowHeight;
   end;

   if (Items.Count=0) and (Datasource<>nil) and (DataSource.DataSet<>nil) and
       DataLink.Active then with DataSource.DataSet do
   begin
      for i:=0 to FieldCount-1 do
      begin
         Item:= TwwInspectorItem.create(Items);
         Item.Caption:= Fields[i].DisplayLabel;
         Item.CustomControl:= nil;
         Item.ReadOnly:= Fields[i].ReadOnly;
         Item.CellHeight:= 0;
         Item.Expanded:= False;
         Item.DataField:= Fields[i].FieldName;
      end
   end;


   if not (csLoading in ComponentState) then
   begin
      numRows:= GetActiveRows;
//      if ovIndicatorRow in Options then numRows:= numRows + 1;
      if (RowCount<>NumRows) and (NumRows>0) then
        RowCount:= NumRows;
   end;

//   RowCount:= ActiveRows;

   if IndicatorRow.enabled then CurRow:=1
   else CurRow:= 0;
   IterateItems(ApplySettingsCallback, True, @CurRow);

   if IndicatorRow.enabled and (RowCount>1) then // Fixed rows must be less than rowcount
   begin
      FixedRows:= 1 + FFixedDataRows;
      if IndicatorRow.height<>0 then
         RowHeights[0]:=IndicatorRow.height
      else
         RowHeights[0]:= inherited DefaultRowHeight;
   end
   else FixedRows:= FixedDataRows;

   UpdateDataColumnWidth;
   ColCount:= FDataColumns + 1;
   FDataLink.BufferCount:=DataColumns;
   if FDataLink.Active then
   begin
     if (FDataLink.RecordCount<DataColumns) and (FDataLink.RecordCount>0) then
     begin
//        ColCount:= FDataLink.RecordCount+1;
     end;
   end;
   if (ColCount>1) and (Col=0) then Col:= 1;
{   Col:= 1;}

//   { Create controls }
//   DateTimePicker:= TwwDBDateTimePicker.create(self);
//   Update; { Complete erase background }
   EndUpdate(True);

   { Collapse on checkbox causes inplaceeditor to not become visible even though it should }
   if UseDefaultEditor then ShowEditor;

end;

procedure TwwDataInspector.SetCaptionWidth(value: integer);
var NewWidth: integer;
begin
   NewWidth:= wwMax(10, wwMin(value, ClientWidth-20));
   if NewWidth<>FCaptionWidth then begin
      if (ovHideCaptionColumn in Options) and (ColCount=2) then
         ColWidths[0]:= 0
      else begin
         ColWidths[0]:= wwMax(10, wwMin(value, ClientWidth-20));
         FCaptionWidth:= ColWidths[0];
      end;
      invalidate;
   end
end;

function TwwDataInspector.AcquireFocus: Boolean;
begin
  Result := True;
  if CanFocus and not (csDesigning in ComponentState) then
  begin
    SetFocus;
//    if InplaceEditor<>nil then
//       TEdit(InplaceEditor).Font.Color:= clWindowText; { Change later to be based on property FocusTextColor }
    Result := FFocused or (InplaceEditor <> nil) and InplaceEditor.Focused;
  end;
end;

function TwwDataInspector.UseCheckbox(ARow: integer): boolean;
var
  obj: TwwInspectorItem;
begin
   obj:= GetItemByRow(ARow);
   if obj=nil then
   begin
      result:= false;
      exit;
   end;
   result:= (obj.CustomControl=nil) and
            not IsDefaultDateTimePicker(obj) and
           (obj.PickList.items.count>0) and
           (obj.PickList.DisplayAsCheckbox)
end;

function TwwDataInspector.UseDefaultEditor: boolean;
var
    obj: TwwInspectorItem;
begin
   obj:= GetItemByRow(Row);
   if (obj=nil) or (obj.DisableDefaultEditor) {or (not obj.enabled) }then
   begin
      result:= false;
      exit;
   end;

   result:=
      not
       ((obj.CustomControl<>nil) or
        IsDefaultDateTimePicker(obj) or
        (obj.PickList.items.count>0) or
        obj.UseDefaultComboBox or
        ((obj.Field<>nil) and IsDefaultLookupCombo(obj)))
end;


procedure TwwInspectorItem.DoItemTextChanged;
begin
//   if EditText<>OrigEditText then
//   begin
      if Assigned(FItemChanged) then
         FItemChanged((Control as TwwDataInspector), self, EditText);
      (Control as TwwDataInspector).DoItemChanged(self, EditText);
//      OrigEditText:= EditText;
//   end;
end;

Function TwwDataInspector.GetActiveEdit: TWinControl;
begin
   result:= nil;

   if CurrentCustomEdit<>nil then result:= CurrentCustomEdit
   else if not UseCheckbox(Row) then begin
      // 8/9/01 - If no active item then return nil
      if (ActiveItem<>nil) and (not ActiveItem.DisableDefaultEditor) and
        ActiveItem.Enabled then
         result:= InplaceEditor
   end

end;

procedure TwwDataInspector.InitCustomEdit(customEdit: TWinControl;
    Obj: TwwInspectorItem);
begin
      if customEdit.parent<>self then
      begin
          customEdit.parent:= self;
          // 6/23/00 - Handle needs to be created to avoid blank display in some cases
          customEdit.HandleNeeded;
      end;

      if (obj.datafield<>wwGetControlDataField(customEdit)) or
         (obj.datasource<>wwGetControlDataSource(customEdit)) then
      begin
         wwSetControlDataField(customEdit, '');
         if (obj.DataSource<>nil) and (obj.DataField='') then
         begin
//           if (obj.datasource<>wwGetControlDataSource(customEdit)) then
//              wwSetControlDataSource(customEdit, nil);
         end
         else begin
           if (obj.datasource<>wwGetControlDataSource(customEdit)) then
              wwSetControlDataSource(customEdit, obj.DataSource);
           wwSetControlDataField(customEdit, obj.DataField);
         end;

         { Select all after painting }
         if not (customedit is TCustomMemo) then
         begin
            if (customEdit<>nil) and customEdit.enabled then
              PostMessage(CustomEdit.Handle, EM_SETSEL, 0, -1);
         end
      end;

      if CustomEdit is TWinControl then
      begin
         TEdit(CustomEdit).ctl3d:= False;
         if TEdit(CustomEdit).ParentFont then
            TEdit(CustomEdit).font:= self.font;
         TEdit(CustomEdit).TabStop:= false;
         wwSetBorder(CustomEdit, False);
//         if (CustomEdit is TCustomEdit) and (TEdit(CustomEdit).BorderStyle<> bsNone) then
//            TEdit(CustomEdit).BorderStyle:= bsNone;
      end;

      { 11/3/99 - Update picture mask property of TwwDBCustomEdit }
      if (CustomEdit is TwwDBCustomEdit) then begin
         TwwDBCustomEdit(CustomEdit).Picture.Assign(obj.Picture);
         TwwDBCustomEdit(CustomEdit).Picture.PictureMaskFromDataSet:= False;
      end;

end;

procedure TwwDataInspector.UpdateCustomEdit;
var FoundCustomEdit: boolean;
    obj: TwwInspectorItem;
    customEdit: TWinControl;
    lookupCombo: TwwDBLookupCombo;

{  function ControlRect: TRect;
  begin
     result:= CellRect(Col, Row);
//     result:= ARect;
     result.Left:= result.Left +1;
     result.Bottom:= result.Bottom -1;
  end;
}
begin
   Obj:= ActiveItem;
   if Obj=nil then exit;    //5/11/2001 - PYW - Make sure that obj <> nil.
   CustomEdit:=nil; // Make compiler happy about its warnings

   if (not (csDesigning in ComponentState)) and
       (EffectiveFocused or //2/7/01 - Use FFocused instead as
       (Assigned(Screen.ActiveControl) and { 3/6/00 - Check for nil active control }
       (Screen.ActiveControl.parent=self))) then
   begin
//      DirtyCustomInfo:= False;
      FoundCustomEdit:= False;
      if obj.CustomControl<>nil then
      begin
         customEdit:= obj.CustomControl;
         FoundCustomEdit:= True;
      end
      else if (obj.UseDefaultComboBox) then begin
         FoundCustomEdit:= True;
         if FCombo=Nil then
         begin
            FCombo:= CreateDefaultCombo;
            FCombo.Parent:= self;
            FCombo.font:= self.font;
            FCombo.visible:= False;
            (FCombo as TwwInspectorComboBox).FClickTime := GetMessageTime; { 12/2/99 - Support dbl-click}
         end;
         customEdit:= FCombo;
         FCombo.Items.assign(obj.PickList.Items);
         FCombo.MapList:= obj.PickList.MapList;
         FCombo.ShowMatchText:= obj.PickList.ShowMatchText;
         FCombo.Style:= obj.PickList.Style;
         FCombo.ButtonStyle:= obj.PickList.ButtonStyle;
         FCombo.AllowClearKey:= obj.PickList.AllowClearKey;
         FCombo.ButtonGlyph.Handle:= 0;
         FCombo.ButtonGlyph.Assign(obj.PickList.ButtonGlyph);
         FCombo.ButtonWidth:= obj.PickList.ButtonWidth;
         FCombo.ApplyList;
//         FCombo.OnDropDown:= obj.ComboDropDownEvent;
         if (obj.DataSource=nil) or (obj.DataField='') then
           FCombo.Value:= obj.EditText;
      end
      else if IsDefaultLookupCombo(obj) then begin
         FoundCustomEdit:= True;
         if obj.CustomControl=nil then
         begin
            LookupCombo:= TwwDBLookupCombo.create(self);
            obj.CustomControl:= LookupCombo;
         end
         else if obj.CustomControl is TwwDBLookupCombo then
            LookupCombo:= TwwDBLookupCombo(obj.CustomControl)
         else exit;

         LookupCombo.font:= self.font;
         LookupCombo.visible:= False;
         LookupCombo.parent:= self;
         LookupCombo.LookupTable:= obj.field.LookupDataSet;
         LookupCombo.Selected.Add(
            obj.field.LookupResultField + #9 +
            inttostr(obj.field.displaywidth) + #9 +
            obj.field.DisplayLabel);
         LookupCombo.ShowMatchText:= True;
         LookupCombo.LookupField:= obj.Field.LookupKeyFields;
         LookupCombo.tabStop:= false;
         customEdit:= LookupCombo;
//             DoCreateLookupCombo(LookupCombo);
      end
      else if IsDefaultDateTimePicker(obj) then begin
         FoundCustomEdit:= True;
         if FDateTimePicker=Nil then
         begin
             FDateTimePicker:= CreateDateTimePicker;
             FDateTimePicker.visible:= False;
             FDateTimePicker.font:= self.font;
             FDateTimePicker.TabStop:= false;

             DoCreateDateTimePicker(FDateTimePicker);
         end;
         customEdit:= FDateTimePicker;
         FDateTimePicker.ShowButton:= not (obj.Field is TTimeField);
      end;

      DoCalcCustomEdit(obj, CustomEdit, FoundCustomEdit);      //1/21/02

      if FoundCustomEdit then begin
         if not sameRect(customEdit.BoundsRect, ControlRect(Col, Row)) then
         begin
            customEdit.BoundsRect:= ControlRect(Col, Row);
         end;
         InitCustomEdit(customEdit, obj);
         customEdit.BoundsRect:= ControlRect(Col, Row);
         wwSetReadOnly(CustomEdit, obj.ReadOnly or self.ReadOnly);

         { 5/4/00 - Unbound with custom control item was losing original text when changing rows }
         if CurrentCustomEdit<>Customedit then begin
            if (not obj.CustomControlAlwaysPaints) or
               (obj.UseDefaultComboBox) then // 8/7/01 - Also reset text for defautl combo box
            begin
              if (obj.datafield='') or (obj.datasource=nil) then
              begin
                CustomEdit.HandleNeeded;
                TEdit(CustomEdit).Text:= obj.DisplayText;
              end;
           end;
           CurrentCustomEditRow:= Row;
           CurrentCustomEditCol:= Col;
         end;

         CurrentCustomEdit:= CustomEdit;
      end;
   end;

   // 8/21/02 - Support obj.enabled property
   if CurrentCustomEdit<>nil then
      CurrentCustomEdit.enabled:= obj.enabled;

end;

procedure UpdateCustomEditPaint(CurrentCustomEdit: TWinControl);
var i: integer;
begin
     with CurrentCustomEdit do
       for i:= 0 to CurrentCustomEdit.ControlCount-1 do
          Controls[i].Update;

     CurrentCustomEdit.Update;
end;

procedure TwwDataInspector.SetFocusCell(ACol, ARow: integer);
var OldRow: integer;
    obj: TwwInspectorItem;
    PrevTopRow: integer;
    CurrentUpdateCount: integer;
//    InvalidateAll: boolean;
    DrawInfo: TGridDrawInfo;
begin
   if (ACol=Col) and (ARow=Row) then begin
      // Scrolling right/left when cell doesn't change should
      // invalidate currentcustomedit

  if {((CurrentCustomEditRow<>ARow) or (CurrentCustomEditCol<>ACol)) and }(CurrentCustomEdit<>nil) then
   begin
      // 7/26/02 - Only set focus if inspector is on the active form
      if FFocused and (Screen.ActiveForm = GetParentForm(self)) then  // 5/2/01
         SetFocus;
      CurrentCustomEdit.visible:= False;
      CurrentCustomEdit:= nil;
      CurrentCustomEditRow:= -1;
      CurrentCustomEditCol:= -1;
   end;

      UpdateCustomEdit;
      if CurrentCustomEdit<>nil then begin
         CurrentCustomEdit.visible:=True;

         UpdateCustomEditPaint(CurrentCustomEdit);
         // 7/26/02 - Only set focus if inspector is on the active form
         if FFocused and (Screen.ActiveForm = GetParentForm(self)) then  // 5/2/01
            CurrentCustomEditSetFocus;
      end;
      exit;
   end;
   if IndicatorRow.enabled and (ARow<1) then ARow:=Row;

   if (ARow<>Row) or (ACol<>Col) then
   begin
      FCustomControlKeyMode:= False;
      TwwDataInspectorDataLink(FDatalink).UpdateData;
   end;

   OldRow:= Row;
   PrevTopRow:= TopRow;

   obj:= GetItemByRow(OldRow);

   if (obj<>nil) and (CurrentCustomEdit<>nil) then
   begin
       if CurrentCustomedit is TwwDBComboBox then
         obj.EditText:= TwwDBComboBox(CurrentCustomEdit).Value
       else
         obj.EditText:= TEdit(CurrentCustomEdit).Text;
   end;

   if CurrentCustomEdit<>nil then
   begin
      if CurrentCustomEdit.HandleAllocated then
        if SendMessage(CurrentCustomEdit.Handle, EM_GETMODIFY, 0, 0)<>0 then
//      if TEdit(CurrentCustomEdit).modified then
           obj.DoItemTextChanged;
   end
   else begin
    { Check for checkbox }
       if (InplaceEditor<>nil) and Inplaceeditor.modified then
       begin
           { 5/3/00 - Make sure obj.edittext is updated to inplaceeditor's value }
           { This is only necessary because when a picture mask is assigned, the obj.edittext
             is not updated for some reason }
           if inplaceeditor.text<>obj.edittext then
              obj.edittext:=InplaceEditor.text;

           obj.DoItemTextChanged;
           InplaceEditor.modified:= false; { 3/11/00 - Clear modified }
       end
   end;

//   UpdateRect:= FPaintCanvas.ClipRect;
//   windows.GetUpdateRect(Handle, UpdateRect, false);
//   BeginUpdate;
   CurrentUpdateCount:= FUpdateCount;
   try
   // 2/10/01 - RSW Calling BeginUpdate prevents closing combo-box from invalidating its pop-up window area
   // However not calling it makes scrolling painting occur!
   // So we make temporary flag to invalidate whole inspector if drop-down was previously
   // showing before changing cell

//      DoBeginUpdateInSelectCell:= True; { Do BeginUpdate after BeforeSelect event }
//      InvalidateAll:= HaveVisibleChild(CurrentCustomEdit);

      // Inherited calls ScrollWindowEx, so disable painting if this
      // will be called so that we don't get this scrolling
      CalcDrawInfo(DrawInfo);
      with DrawInfo do
      begin
         if (ACol > Horz.LastFullVisibleCell) or
            (ARow > Vert.LastFullVisibleCell) or
            (ACol < LeftCol) or (ARow < TopRow) then
         begin
            DoBeginUpdateInSelectCell:= True; { Do BeginUpdate after BeforeSelect event }
         end
      end;

      MoveColRow(ACol, ARow, True, True)
   finally
      if (PrevTopRow<>TopRow) and (FixedDataRows>0) then
      begin
         if TopRow<FixedRows then TopRow:= PrevTopRow; //FixedRows;
      end;
      if FUpdateCount>CurrentUpdateCount then EndUpdate;
//      if InvalidateAll then Invalidate;
   end;

   if ((CurrentCustomEditRow<>ARow) or (CurrentCustomEditCol<>ACol)) and (CurrentCustomEdit<>nil) then
   begin
      CurrentCustomEdit.visible:= False;
      CurrentCustomEdit:= nil;
      CurrentCustomEditRow:= -1;
      CurrentCustomEditCol:= -1;
   end;

   if useDefaultEditor then
   begin
      SkipSetFocus:= True; // 6/13/01 - Don't set inplaceeditor focus when inspector receives focus
      try
         ShowEditor;
      finally
         SkipSetFocus:= false;
      end;
   end
   else HideEditor;

   if (PrevTopRow<>TopRow) then
   begin
      if TopRow<FixedRows then TopRow:=FixedRows;
      invalidate;
      Update;// 2/23/01 - Make sure no problem when on last visible row and enter downa-arrow.
   end
   else begin
//      Invalidate;
      InvalidateRect(Handle, @SelectCellUpdateRect, False);
      InvalidateRow(OldRow);
      InvalidateRow(ARow);
   end;

//   if SkipUpdateCustomControl then exit;

   UpdateCustomEdit;
   if CurrentCustomEdit<>nil then begin
     CurrentCustomEdit.visible:=True;
     UpdateCustomEditPaint(CurrentCustomEdit);
//     CurrentCustomEdit.Update;  // 1/31/01 - RSW - Without this its not getting painted
     if FFocused then  // 5/2/01
        CurrentCustomEditSetFocus;
   end
end;

function TwwDataInspector.SelectCell(ACol, ARow: Longint): Boolean;
var obj: TwwInspectorItem;
begin
   FreeHintWindow;

   Result := True;
   obj:= GetItemByRow(ARow);

   if Assigned(FOnBeforeSelectCell) then begin
      FOnBeforeSelectCell(Self, Obj, Result);
   end;

   if DoBeginUpdateInSelectCell then
   begin
      Windows.GetUpdateRect(Handle, SelectCellUpdateRect, false);
      BeginUpdate;
      DoBeginUpdateInSelectCell:= False;
   end;

   if result then begin
      if ACol=0 then begin
         result:= False;
         exit;
      end;
      if ((CurrentCustomEditRow<>ARow) or (CurrentCustomEditCol<>ACol)) and (CurrentCustomEdit<>nil) then
      begin
         SkipErase:= True;
         { 9/29/99 - Need to move focus to inspector since custom edit is not visible }
         if CurrentCustomEdit.visible then SetFocus;
         CurrentCustomEdit.visible:= False;
         SkipErase:= False;
         CurrentCustomEdit:= nil;
         CurrentCustomEditRow:= -1;
         CurrentCustomEditCol:= -1;
      end;

      { Initialize edit text values when it receives focus }
      if obj<>nil then
         obj.EditText:= GetEditText(1, ARow);
//      obj.OrigEditText:= Obj.EditText;

      InvalidateRow(Row);
      InvalidateRow(ARow);

      if (ARow<>Row) and FastDesign then
         FActiveItem:= GetItemByRow(ARow);

   end;

end;

procedure TwwDataInspector.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var DrawInfo: TGridDrawInfo;
  NewSize: Integer;

  function ResizeLine(const AxisInfo: TGridAxisDrawInfo): Integer;
  var
    I: Integer;
  begin
    with AxisInfo do
    begin
      Result := FixedBoundary;
      for I := FirstGridCell to FSizingIndex - 1 do
        Inc(Result, GetExtent(I) + EffectiveLineWidth);
      Result := FSizingPos - Result;
    end;
  end;

begin
  CalcDrawInfo(DrawInfo);
  if FGridState=gsColSizing then try
     if UseRightToLeftAlignment then
        FSizingPos := ClientWidth - FSizingPos;
     NewSize := ResizeLine(DrawInfo.Horz);
     if NewSize > 1 then
     begin
        CaptionWidth:= NewSize;
        UpdateDataColumnWidth;
        UpdateDesigner;
     end;
     if Assigned(OnMouseUp) then OnMouseUp(self, Button, Shift, X,Y);
  finally
    FGridState := gsNormal;
  end
  else if FGridState=gsRowSizing then
  begin
     inherited;
     if CurrentCustomEdit<>nil then
     begin
        CurrentCustomEditSetFocus;
//        TEdit(CurrentCustomEdit).Font.Color:= clBlack; { Change later to be based on property FocusTextColor }
     end;

     RowHeights[FSizingIndex]:= wwMax(RowHeights[FSizingIndex], FMinRowHeight);
     if GetItemByRow(FSizingIndex)<>nil then { 11/18/99 - Make sure this is a valid row }
        GetItemByRow(FSizingIndex).CellHeight:= RowHeights[FSizingIndex];
     invalidateRow(FSizingIndex);
  end
  else if FGridState in [gsSelecting, gsColMoving, gsRowMoving] then inherited
  else if Assigned(OnMouseUp) then OnMouseUp(self, Button, Shift, X,Y); //3/18/2002-Call OnMouseUp event if assigned.
end;

procedure TwwDataInspector.DrawSizingLine(const DrawInfo: TGridDrawInfo);
var
  OldPen: TPen;
begin
  OldPen := TPen.Create;
  try
    with Canvas, DrawInfo do
    begin
      OldPen.Assign(Pen);
      Pen.Style := psDot;
      Pen.Mode := pmXor;
      Pen.Width := 1;
      try
        if FGridState = gsRowSizing then
        begin
          MoveTo(0, FSizingPos);
          LineTo(Horz.GridBoundary, FSizingPos);
        end
        else
        begin
          MoveTo(FSizingPos, 0);
          LineTo(FSizingPos, Vert.GridBoundary);
        end;
      finally
        Pen := OldPen;
      end;
    end;
  finally
    OldPen.Free;
  end;
end;

procedure TwwDataInspector.DoCollapse(ObjItem: TwwInspectorItem);
var AllowCollapse: boolean;
begin
   AllowCollapse:= True;
   if Assigned(FOnCanCollapse) then FOnCanCollapse(self, ObjItem, AllowCollapse);
   if AllowCollapse then begin
      ObjItem.expanded:= False;
      if not (csLoading in ComponentState) then
      begin
         if Assigned(FOnCollapsed) then FOnCollapsed(self, ObjItem)
      end
   end
end;

procedure TwwDataInspector.DoExpand(ObjItem: TwwInspectorItem);
var AllowExpand: boolean;
begin
   AllowExpand:= True;
   if Assigned(FOnCanExpand) then FOnCanExpand(self, ObjItem, AllowExpand);
   if AllowExpand then begin
      ObjItem.expanded:= True;
      if not (csLoading in ComponentState) then
      begin
         if Assigned(FOnExpanded) then FOnExpanded(self, ObjItem)
      end
   end;

end;


procedure TwwDataInspector.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  DrawInfo: TGridDrawInfo;
  Cell: TGridCoord;
  obj: TwwInspectorItem;
  r: TRect;
  pt: TPoint;
  SendMouseMessage: boolean;
  MouseControl: TControl;
  OldTopRow: integer;
//  OldRow: integer;
begin
  FreeHintWindow;

  Cell := MouseCoord(X, Y);

  { Don't set focus if clicking on first column of active row }
  if (not IsFocused) or (Cell.X <>0) or (Cell.Y<>Row) and isFocused then
  begin
     if FFocused then SkipUpdateCustomControlInFocus:= True;
     if not AcquireFocus then Exit;
     SkipUpdateCustomControlInFocus:= False;
  end;

  if (Cell.X < 0) and (Cell.Y < 0) or (ssDouble in Shift) then  { 12/2/99 - Dbl-click should be passed to base class to handle}
  begin
    // 7/17/01
    TwwDataInspectorDataLink(FDatalink).UpdateData; // Flush editor contents so its not lost
    inherited MouseDown(Button, Shift, X, Y);
    // 5/8/2002 - Bug when clicking on edge of Datainspector when embedded in grid.
    if (parent is TCustomGrid) and (Cell.X < 0) and (Cell.Y < 0) then FGridState := gsNormal;
    Exit;
  end;

 { 12/2/99 - Support dbl-click}
   if DefaultCombo <> nil then (DefaultCombo as TwwInspectorComboBox).FClickTime := GetMessageTime;

  obj:= GetItemByRow(Cell.Y);
  if (Cell.X=0) and (obj<>nil) then begin
     pt:= obj.ButtonPoint;
     if (obj.Items.Count>0) and
        (((abs(x-pt.x)<=4) and (abs(y-pt.y)<=4)) or (ssDouble in Shift)) then
     begin
//       OldRow:= Row;
       SetFocusCell(Col, GetRowByItem(obj)); { 3/6/2000 - Flush changes when expanding }

//       Row:= GetRowByItem(obj);  { Must set row before updating obj.expanded as otherwise
//                             error when flusing edit contents}
       if UseDefaultEditor then ShowEditor else HideEditor;
       if obj.Expanded then DoCollapse(obj)
       else DoExpand(obj);

       if Assigned(OnMouseDown) then OnMouseDown(Self, Button, Shift, X, Y);
       exit;
     end
  end;

  if ((Cell.X>=0) and (Cell.x<=ColCount)) and
     (not Sizing(X,Y) or not InValidColSizingArea(x)) then begin
     if Assigned(OnMouseDown) then OnMouseDown(Self, Button, Shift, X, Y);

     SendMouseMessage:=((Row<>Cell.Y) or (Col<>Cell.X)) and (Cell.X<>0);  // Changed rows so send mouse to custom control
     OldTopRow:= TopRow;

     if Cell.X=0 then
        SetFocusCell(Col, Cell.Y)
     else begin
        if (Cell.X<>Col) then
        begin
          if CurrentCustomEdit<>nil then
          begin
             SetFocus;
             CurrentCustomEdit.visible:=false;
          end;

          NewMouseRow:= Cell.Y;
          try
            if FDataLink.Active then FDatalink.Dataset.MoveBy(Cell.X-Col);
          finally
            NewMouseRow:=-1;
          end
        end
        else begin
          Cell.X:= wwMin(Cell.X, ColCount-1);
          SetFocusCell(Cell.X, Cell.Y);
        end;

//        FCustomControlKeyMode:= True;

     end;

     // Send mouse message to control that has just become visible
     if SendMouseMessage and (CurrentCustomEdit<>nil) and
        (CurrentCustomEdit.visible) and (TopRow=OldTopRow) then
     begin
        pt:= Point(x-CurrentCustomEdit.Left, y-CurrentCustomEdit.Top);
        MouseControl:= CurrentCustomEdit.ControlAtPos(pt,False,True);

        if (MouseControl<>nil) and (MouseControl is TWinControl) then
        begin
          MouseControl.ScreenToClient(pt);
          SendMessage(TWinControl(MouseControl).handle, wm_lbuttondown,
           0, MakeLParam(pt.x-MouseControl.Left, pt.y-MouseControl.Top));

          // 2/10/01 - Sending up as well to take care of problem of combo-button
          // remaining down if clicked when it is not visible.
          SendMessage(TWinControl(MouseControl).handle, wm_lbuttonUp,
           0, MakeLParam(pt.x-MouseControl.Left, pt.y-MouseControl.Top));
//          MouseControl.ControlState:=MouseControl.ControlState-[cslButtonDown];
        end
        else begin
           // i.e. embedded TwwCheckbox
           if CurrentCustomEdit.Enabled then
              SendMessage(CurrentCustomEdit.handle, wm_lbuttondown,
                0, MakeLParam(x-CurrentCustomEdit.Left, y-CurrentCustomEdit.Top));
        end
     end;

     r:= CheckboxRect(CellRect(Cell.X, Row), obj);
     InflateRect(r, 1, 1);
     if (Cell.x>=1) and UseCheckbox(Cell.y) and
        PtInRect(r, Point(x,y)) then
     begin
        ToggleCheckbox(obj);
        InvalidateCell(1, Cell.Y);
     end;
     exit;
  end;

  { Flush data }
  CalcDrawInfo(DrawInfo);
  CalcSizingState(X, Y, FGridState, FSizingIndex, FSizingPos, FSizingOfs,
      DrawInfo);
  if (FGridState = gsColSizing) or (FGridState = gsRowSizing) then
     FDataLink.UpdateData;

  inherited;

  if (FGridState = gsColSizing) or (FGridState = gsRowSizing) then
  begin
    CalcDrawInfo(DrawInfo);
    { Check grid sizing }
    CalcSizingState(X, Y, FGridState, FSizingIndex, FSizingPos, FSizingOfs,
      DrawInfo);

    if FGridState=gsColSizing then
    begin
       if not InValidColSizingArea(X) then FGridState:= gsNormal;
       DrawSizingLine(DrawInfo);  { Undo sizing line }
    end
  end;
end;


procedure TwwDataInspector.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  DrawInfo: TGridDrawInfo;
  NewSize: integer;
  OldCaptionWidth: integer;
  coord: TGridCoord;

  function ResizeLine(const AxisInfo: TGridAxisDrawInfo): Integer;
  var
    I: Integer;
  begin
    with AxisInfo do
    begin
      Result := FixedBoundary;
      for I := FirstGridCell to FSizingIndex - 1 do
        Inc(Result, GetExtent(I) + EffectiveLineWidth);
      Result := FSizingPos - Result;
    end;
  end;

begin
  CalcDrawInfo(DrawInfo);
  case FGridState of
    gsSelecting, gsColMoving, gsRowMoving:;

    gsRowSizing: ;

    gsColSizing:
      begin
        NewSize := ResizeLine(DrawInfo.Horz);
        if (NewSize > 1) then
        begin
          OldCaptionWidth:= CaptionWidth;
          CaptionWidth:= NewSize;
          if CaptionWidth<>OldCaptionWidth then
          begin
             UpdateDataColumnWidth;
             UpdateDesigner;
          end
        end;
        FSizingPos := X + FSizingOfs;
        exit;
      end;
  end;
  inherited MouseMove(Shift, X, Y);

// Following code to paint mouseenter for themes
// Problems implementing as it only works when control has the focus anyways
// If we support this, then we should only invalidate if it has the focus
// Code also causes flicker in active cell as mouse is moved
  if wwUseThemes(self) then begin
     {$ifdef wwDelphi7Up}
     coord:= MouseCoord(X,Y);
     if ((lastMouseCoord.x<>coord.X) or (lastMouseCoord.y<>coord.y)) then
     begin
       if (HotCol<>0) or (HotRow<>0) then
       begin
//          InvalidateCell(LastMouseCoord.x, LastMouseCoord.y);
          InvalidateCell(HotCol, HotRow); // MouseExit
          HotCol:=0;
          HotRow:=0;
       end;
//       if not ((coord.x=Col) and (coord.y=Row)) then
       if coord.x=Col then // Only do for active record
          InvalidateCell(coord.x, coord.y);
     end;
     lastMouseCoord:= coord;
     {$endif}
  end;

  HintMouseMove(Shift,X, Y);
end;

procedure TwwDataInspector.CalcSizingState(X, Y: Integer; var State: TGridState;
  var Index: Longint; var SizingPos, SizingOfs: Integer;
  var FixedInfo: TGridDrawInfo);

  procedure CalcAxisState(const AxisInfo: TGridAxisDrawInfo; Pos: Integer;
    NewState: TGridState);
  var
    I, Line, Back, Range: Integer;
    tolerance: integer;
    obj: TwwInspectorItem;
  begin
    if NewState=gsColSizing then tolerance:= 7
    else tolerance:= 5;

    if UseRightToLeftAlignment then
      Pos := ClientWidth - Pos;
    with AxisInfo do
    begin
      Line := FixedBoundary;
      Range := EffectiveLineWidth;
      Back := 0;
      if Range < tolerance then
      begin
        Range := tolerance;
        Back := (Range - EffectiveLineWidth) shr 1;
      end;

      for I := FirstGridCell to GridCellCount - 1 do
      begin
        Inc(Line, GetExtent(I));
        if Line > GridBoundary then Break;
        if (Pos >= Line - Back) and (Pos <= Line - Back + Range) then
        begin
          if NewState=gsRowSizing then
          begin
            obj:= GetItemByRow(i);
            if (obj<>nil) and not obj.Resizeable then exit;
          end;

          State := NewState;
          SizingPos := Line;
          SizingOfs := Line - Pos;
          Index := I;
          Exit;
        end;
        Inc(Line, EffectiveLineWidth);
      end;
      if (GridBoundary = GridExtent) and (Pos >= GridExtent - Back)
        and (Pos <= GridExtent) then
      begin
        if NewState=gsRowSizing then
        begin
          obj:= GetItemByRow(i);
          if (obj<>nil) and not obj.Resizeable then exit;
        end;
        State := NewState;
        SizingPos := GridExtent;
        SizingOfs := GridExtent - Pos;
        Index := LastFullVisibleCell + 1;
      end;
    end;
  end;

  function XOutsideHorzFixedBoundary: Boolean;
  begin
    with FixedInfo do
      if not UseRightToLeftAlignment then
        Result := X > Horz.FixedBoundary
      else
        Result := X < ClientWidth - Horz.FixedBoundary;
  end;

  function XOutsideOrEqualHorzFixedBoundary: Boolean;
  begin
    with FixedInfo do
      if not UseRightToLeftAlignment then
        Result := X >= Horz.FixedBoundary
      else
        Result := X <= ClientWidth - Horz.FixedBoundary;
  end;


var
  EffectiveOptions: TGridOptions;
begin
  State := gsNormal;
  Index := -1;
  EffectiveOptions := inherited Options;
  if csDesigning in ComponentState then
    EffectiveOptions := EffectiveOptions + DesignOptionsBoost;
  if [goColSizing, goRowSizing] * EffectiveOptions <> [] then
    with FixedInfo do
    begin
      Vert.GridExtent := ClientHeight;
      Horz.GridExtent := ClientWidth;
      if (goColSizing in EffectiveOptions) then
      begin
        CalcAxisState(Horz, X, gsColSizing);
      end;

      if (State<>gsColSizing) and (goRowSizing in EffectiveOptions) then
      begin
        if X>ColWidths[0] then exit;
        CalcAxisState(Vert, Y, gsRowSizing);
      end;
    end;
end;

function TwwDataInspector.GetPageHeight: integer;
var DrawInfo: TGridDrawInfo;
    PageHeight: integer;
begin
  CalcDrawInfo(DrawInfo);
  PageHeight := (DrawInfo.Vert.LastFullVisibleCell+1) - TopRow;
  if PageHeight < 1 then PageHeight := 1;
  result:= PageHeight;
end;

// Return true row from data row number
function TwwDataInspector.DataRow(ARow: integer): integer;
begin
   if IndicatorRow.enabled then result:= ARow+1
   else result := ARow;
end;

procedure TwwDataInspector.KeyDown(var Key: Word; Shift: TShiftState);
  procedure SetCustomControlFocus;
  begin
    if (CurrentCustomEdit<>nil) and (CurrentCustomEdit.visible) then
       CurrentCustomEditSetFocus;
  end;
var obj: TwwInspectorItem;
    ParentForm: TCustomForm;
begin
   if Assigned(OnKeyDown) then OnKeyDown(Self, Key, Shift);

   if (ovEnterToTab in Options) and (Key=VK_RETURN) then Key:= 9;

   if (ssCtrl in Shift) or (ColCount<=2) then
   begin
     case key of
      vk_right: begin
           obj:= GetItemByRow(Row);
           if ((obj.readonly) or (ssCtrl in Shift)) and
               (obj.Items.count>0) and (not obj.expanded) then begin
              DoExpand(obj);
              key:= 0;
           end;
        end;
      vk_left: begin
           obj:= GetItemByRow(Row);
           if ((obj.readonly) or (ssCtrl in Shift)) and
              (obj.Items.count>0) and obj.expanded then begin
              DoCollapse(obj);
              key:= 0;
           end;
        end;
      vk_home:
       begin
          SetFocusCell(Col,DataRow(0))
       end;
      vk_end:
       begin
          SetFocusCell(Col, RowCount-1);
       end;
     end;
   end;

   begin

     case key of
      vk_Next:
        begin
          SetFocusCell(Col, wwMin(RowCount-1, Row + GetPageHeight));
        end;

      vk_Prior:
        begin
          SetFocusCell(Col, wwMax(DataRow(0), Row - GetPageHeight));
        end;

      vk_right:
       begin
          if (ColCount>2) and {(Col<ColCount-1) and }FDataLink.Active and
             not (FDataLink.DataSet.Eof) then
          begin
             if CurrentCustomEdit<>nil then
             begin
                SetFocus;
                CurrentCustomEdit.visible:=false;
             end;
             FDataLink.MoveBy(1);//SetFocusCell(Col+1, Row)
             key:= 0;
          end
          else if parent is TCustomGrid then begin
             PostMessage(parent.handle, wm_keydown, key,
                wwGetEventShift(Shift));
          end
       end;

      vk_left:
       begin
          if (ColCount>2) and FDataLink.Active and
             not (FDataLink.DataSet.Bof) then
          begin
             if CurrentCustomEdit<>nil then
             begin
                SetFocus;
                CurrentCustomEdit.visible:=false;
             end;
             FDataLink.MoveBy(-1); //SetFocusCell(Col-1, Row)
             key:= 0;
          end
          else if parent is TCustomGrid then begin
             PostMessage(parent.handle, wm_keydown, key,
                wwGetEventShift(Shift));
          end
       end;
      vk_Up:
       begin
          if Row>DataRow(0) then SetFocusCell(Col, Row - 1)
          else if parent is TCustomGrid then begin
             SendMessage(parent.handle, wm_keydown, key,
                wwGetEventShift(Shift));
             Row:= RowCount-1;
             // 8/1/02 - Call SetFocusCell instead of setteing Row so focus is set
             // correctly to inplaceeditor or customcontrol
             SetFocusCell(Col, RowCount-1);
          end

       end;

      vk_Down:
       begin
          if Row<RowCount-1 then SetFocusCell(Col, Row+1)
          else if parent is TCustomGrid then begin
             SendMessage(parent.handle, wm_keydown, key,
                wwGetEventShift(Shift));
             Row:= DataRow(0);
             // 8/1/02 - Call SetFocusCell instead of setteing Row so focus is set
             // correctly to inplaceeditor or customcontrol
             SetFocusCell(Col, 0);
          end
       end;

      vk_tab:
       begin
         if ssShift in Shift then
         begin
            obj:= GetItemByRow(Row);
            if obj<>nil then repeat { 7/20/00 - ovTabToVisibleOnly should use 2nd paramater, not first }
                obj:= obj.GetPrior(True, (ovTabToVisibleOnly in Options))
            until (obj=nil) or ((obj.tabStop=True) and (obj.Enabled)) ;
            if obj<>nil then ActiveItem:= obj
            else begin
                if parent is TCustomGrid then
                begin
                   PostMessage(parent.handle, wm_keydown, vk_tab,
                      wwGetEventShift(Shift));
                end
                else begin
                   { 1/28/2000 - Send to parent form, not parent }
                   ParentForm := GetParentForm(Self);
                   if Assigned(ParentForm) then
                      ParentForm.Perform(wm_nextdlgctl, 1, 0);
                end
            end
         end
         else begin
            obj:= GetItemByRow(Row);
            if obj<>nil then repeat { 7/20/00 - ovTabToVisibleOnly should use 2nd paramater, not first }
                obj:= obj.GetNext(True, (ovTabToVisibleOnly in Options))
            until (obj=nil) or ((obj.tabStop=True) and (obj.Enabled)) ;
            if obj<>nil then ActiveItem:= obj
            else begin
                if parent is TCustomGrid then
                begin
                   PostMessage(parent.handle, wm_keydown, vk_tab, 0);
                end
                else begin
                   { 1/28/2000 - Send to parent form, not parent }
                   ParentForm := GetParentForm(Self);
                   if Assigned(ParentForm) then
                      ParentForm.Perform(wm_nextdlgctl, 0, 0);
                end
            end;
         end
       end;

      13: begin
          if CurrentCustomEdit<>nil then begin
            if CurrentCustomEdit is TCustomEdit then
            begin
               with TEdit(CurrentCustomEdit) do
                 SelectAll;
            end;
          end
       end;

      VK_ESCAPE:
       begin
          TwwDataInspectorDataLink(FDatalink).Reset;
          { Highlight entire inplaceedit upon escape }
          if (InplaceEditor<>nil) and (InplaceEditor.visible) then
             InplaceEditor.SelectAll;

       end;
     end
   end;

   SetCustomControlFocus;//   inherited;
end;



Function TwwDataInspector.GetCanvas: TCanvas;
begin
   if UseTempCanvas and not (csPaintCopy in ControlState) then
      result:= FPaintCanvas
   else
      result:= inherited Canvas;
end;

Function TwwDataInspector.HaveVisibleItem: boolean;
var i: integer;
begin
   result:= False;

   for i:= 0 to Items.count-1 do begin
      if TwwInspectorItem(Items[i]).visible then begin
         result:= true;
         break;
      end
   end;
end;

Function TwwInspectorItem.HaveVisibleItem: boolean;
var i: integer;
begin
   result:= False;

   for i:= 0 to Items.count-1 do begin
      if TwwInspectorItem(Items[i]).visible then begin
         result:= true;
         break;
      end
   end;
end;

    function TwwDataInspector.IsHighlightRowVisible: boolean;
    begin
       result:= (ovHighlightActiveRow in Options) and FFocused and
           not (csPaintCopy in ControlState)
    end;

procedure TwwDataInspector.Paint;
var RowPixel: integer;
    CurRow: integer;
    DrawInfo: TGridDrawInfo;
    TempRect: TRect;
    obj: TwwInspectorItem;
    SkipPaintIndicatorLines: boolean;

    procedure DottedDataLine;
    var ACol: integer;
        r: TRect;
        TempColCount: integer;
    begin
//       if (parent is TCustomGrid) and (CurRow>DrawInfo.Vert.LastFullVisibleCell) then exit;

       TempColCount:= ColCount;
       if FDataLink.Active and (ColCount>2) then
          TempColCount:= wwMax(1, wwMin(ColCount, FDataLink.RecordCount+1));

       for ACol:= 1 to TempColCount-1 do begin
          r:= CellRect(ACol, CurRow);

          if EffectiveFocused and (CurRow=Row+1) and
             (Col=ACol) then continue
          else if (CurRow=TopRow) and IndicatorRow.enabled then
          begin
             if (Col=ACol) and (ovActiveRecord3dlines in Options) then
             begin
                Canvas.Pen.Color:= clBtnShadow;
                Canvas.MoveTo(r.left, RowPixel-1);
                Canvas.LineTo(r.right, RowPixel-1);
             end
             else begin
                Canvas.Pen.Color:= clBtnHighlight;
                Canvas.MoveTo(r.left, RowPixel-1);
                Canvas.LineTo(r.right, RowPixel-1);
             end;
             continue;
          end;

          Canvas.Pen.Color:= DottedLineColor;
          wwDottedLine(Canvas,
                Point(r.left, RowPixel-1),
                Point(r.right, RowPixel-1));
       end;
    end;

    procedure DottedCaptionLine;
    begin
       Canvas.Pen.Color:= DottedLineColor;
       if IsHighlightRowVisible and (curRow=Row+1) then exit; { Don't draw dotted line for top of next row }

       wwDottedLine(Canvas,
          Point(0, RowPixel-1),
          Point(ColWidths[0], RowPixel-1));
    end;

    procedure LightDataLine;
    var ACol: integer;
        r: TRect;
        TempColCount: integer;
    begin
       TempColCount:= ColCount;
       if FDataLink.Active and (ColCount>2) then
          TempColCount:= wwMax(1, wwMin(ColCount, FDataLink.RecordCount+1));

       for ACol:= 1 to TempColCount-1 do begin
          r:= CellRect(ACol, CurRow);
          // Don't paint dbl-btnhighlight or shadow
          if (CurRow=TopRow) and IndicatorRow.enabled and
             ((ACol<>Col) or (DataColumns=1) or
              not (ovActiveRecord3dlines in Options)) then
          begin
             Canvas.Pen.Color:= clBtnHighlight;
             Canvas.MoveTo(r.left, RowPixel-1);
             Canvas.LineTo(r.right, RowPixel-1);
             continue;
          end
          else begin
             Canvas.Pen.Color:= clBtnShadow;
             Canvas.MoveTo(r.left, RowPixel-1);
             Canvas.LineTo(r.right, RowPixel-1);
             if IsHighlightRowVisible and (curRow=Row) then continue;

             Canvas.Pen.Color:= clBtnHighlight;
             Canvas.MoveTo(r.left, RowPixel);
             Canvas.LineTo(r.right, RowPixel);
          end;
{
          if EffectiveFocused and (CurRow=Row) then
          begin
             if ACol<>Col then
             begin
               Canvas.Pen.Color:= clBtnShadow;
               Canvas.MoveTo(r.left, RowPixel-1);
               Canvas.LineTo(r.right, RowPixel-1);
             end;
             if not IsHighlightRowVisible then
             begin
               Canvas.Pen.Color:= clBtnHighlight;
               Canvas.MoveTo(r.left, RowPixel);
               Canvas.LineTo(r.right, RowPixel);
             end
          end;
}
       end
    end;

    procedure NoDataLine;
    var r: TRect;
    begin
       r:= CellRect(Col, Row);
//       Canvas.Pen.Color:= clBlack;
       Canvas.Pen.Color:= clSilver;
       Canvas.MoveTo(r.left, r.top-1);
       Canvas.LineTo(r.right, r.top-1);
       Canvas.MoveTo(r.left, r.bottom-1);
       Canvas.LineTo(r.right, r.bottom-1);
    end;

    procedure DarkDataLine;
    var ACol: integer;
        r: TRect;
        TempColCount: integer;
    begin
       TempColCount:= ColCount;
       if FDataLink.Active and (ColCount>2) then
          TempColCount:= wwMax(1, wwMin(ColCount, FDataLink.RecordCount+1));

       for ACol:= 1 to TempColCount-1 do begin
          r:= CellRect(ACol, CurRow);
          // Don't paint dbl-btnhighlight or shadow
          if (CurRow=TopRow) and IndicatorRow.enabled and
             ((ACol<>Col) or (DataColumns=1) or
              not (ovActiveRecord3dlines in Options)) then
          begin
             Canvas.Pen.Color:= clBtnHighlight;
             Canvas.MoveTo(r.left, RowPixel-1);
             Canvas.LineTo(r.right, RowPixel-1);
             continue;
          end
          else begin
             Canvas.Pen.Color:= clBlack;
             Canvas.MoveTo(r.left, RowPixel-1);
             Canvas.LineTo(r.right, RowPixel-1);
             if IsHighlightRowVisible and (curRow=Row) then continue;
             Canvas.Pen.Color:= clBtnHighlight;
             Canvas.MoveTo(r.left, RowPixel);
             Canvas.LineTo(r.right, RowPixel);
          end;
       end;
       exit;
{
       for ACol:= 1 to ColCount do begin
          r:= CellRect(ACol, CurRow);
          if EffectiveFocused and (CurRow=Row) then
          begin
             if ACol<>Col then
             begin
               Canvas.Pen.Color:= clBlack;
               Canvas.MoveTo(r.left, RowPixel-1);
               Canvas.LineTo(r.right, RowPixel-1);
             end;
             if not IsHighlightRowVisible then
             begin
               Canvas.Pen.Color:= clBtnHighlight;
               Canvas.MoveTo(r.left, RowPixel);
               Canvas.LineTo(r.right, RowPixel);
             end
          end
          else begin
             Canvas.Pen.Color:= clBlack;
             Canvas.MoveTo(r.left, RowPixel-1);
             Canvas.LineTo(r.right, RowPixel-1);
             Canvas.Pen.Color:= clBtnHighlight;
             Canvas.MoveTo(r.left, RowPixel);
             Canvas.LineTo(r.right, RowPixel);
          end
       end
}
    end;

    { Draw separater line }
    procedure DrawSeparatorLines;
    var ACol: integer;
        r: TRect;
        BottomLine,TopLine: integer;
        TempColCount: integer;
    begin
      TempColCount:= ColCount;
      if FDataLink.Active and (ColCount>2) then
         TempColCount:= wwMax(1, wwMin(ColCount, FDataLink.RecordCount+1));

      for ACol:= 1 to ColCount-1 do
      begin
        r:= CellRect(ACol, TopRow);

        if (parent is TCustomGrid) then
           Canvas.Pen.Color:= clBtnShadow
        else
          Canvas.Pen.Color:= clBlack;

        if ((ACol>1) or (ColCount=2)) and
           ((ovHideVertDataLines in Options) or (ACol>TempColCount)) then
        begin
           BottomLine:=0;
           if IndicatorRow.enabled then
              BottomLine:= CellRect(0,0).Bottom-1
        end
        else BottomLine:=RowPixel-1;

        // Support dotted vertical line in grid
        if not (ovHideVertFixedLines in Options) or not (ovHideVertDataLines in Options) then
        if (not (parent is TCustomGrid)) or not (LineStyleData=ovDottedLine) then
        begin
           TopLine := 0;
           if ovHideVertFixedLines in Options then TopLine := CellRect(0,0).Bottom-1;
           Canvas.MoveTo(r.left-1, TopLine);
           Canvas.LineTo(r.left-1, BottomLine);
           if (LineStyleData<>ovButtonLine) then begin
              Canvas.Pen.Color:= clBtnHighlight;
              Canvas.MoveTo(r.left, TopLine);
              Canvas.LineTo(r.left, BottomLine);
           end;
        end
        else begin
           Canvas.Pen.Color:= DottedLineColor;
           wwDottedLine(Canvas,
                Point(r.left-1, 1),
                Point(r.left-1, BottomLine));
        end;
      end;

      // Not enough records to fill inspector so paint last vertical line
      if (ColCount>TempColCount) then BottomLine:= CellRect(0, 0).bottom
      else BottomLine:= RowPixel;
//      BottomLine:= RowPixel;

      if (ColCount<=DataColumns+1) and not (parent is TCustomGrid) then
      begin
        r:= CellRect(ColCount-1, TopRow);
        Canvas.Pen.Color:= clBtnShadow;
        Canvas.MoveTo(r.right-1, 0);
        Canvas.LineTo(r.right-1, BottomLine-1);
        Canvas.Pen.Color:= clBtnHighlight;
        Canvas.MoveTo(r.right, 0);
        Canvas.LineTo(r.right, BottomLine-1);
      end
    end;

    procedure ButtonDataLine;
    var ACol: integer;
        r: TRect;
    begin
//       if FFocused and (CurRow=Row+1) then exit;
       for ACol:= 1 to ColCount do begin
          r:= CellRect(ACol, CurRow);
          if EffectiveFocused and (CurRow=Row) then
          begin
             Canvas.Pen.Color:= clBlack;
             Canvas.MoveTo(r.left, RowPixel-1);
             Canvas.LineTo(r.right, RowPixel-1);
             Canvas.Pen.Color:= clBtnShadow;
             Canvas.MoveTo(r.left, RowPixel-2);
             Canvas.LineTo(r.right, RowPixel-2);
             Canvas.Pen.Color:= clBtnShadow;
             Canvas.MoveTo(r.left, RowPixel);
             Canvas.LineTo(r.right, RowPixel);
          end
          else begin
             Canvas.Pen.Color:= clBtnShadow;
             Canvas.MoveTo(r.left, RowPixel-2);
             Canvas.LineTo(r.right, RowPixel-2);

             Canvas.Pen.Color:= clBlack;
             Canvas.MoveTo(r.left, RowPixel-1);
             Canvas.LineTo(r.right, RowPixel-1);

             Canvas.Pen.Color:= clBtnHighlight;
             Canvas.MoveTo(r.left, RowPixel);
             Canvas.LineTo(r.right, RowPixel);
          end
        end
    end;

    procedure LightCaptionLine;
    begin
       if (CurRow=TopRow) and IndicatorRow.enabled then exit;
       if IsHighlightRowVisible and (CurRow=Row) then exit;

       Canvas.Pen.Color:= clBtnShadow;
       Canvas.MoveTo(0, RowPixel-1);
       Canvas.LineTo(ColWidths[0]-1, RowPixel-1);
       Canvas.Pen.Color:= clBtnHighlight;
       Canvas.MoveTo(0, RowPixel);
       Canvas.LineTo(ColWidths[0], RowPixel);
    end;

    procedure DarkCaptionLine;
    begin
       if (CurRow=TopRow) and IndicatorRow.enabled  then exit;
       if IsHighlightRowVisible and (CurRow=Row) then exit;

       Canvas.Pen.Color:= clBlack;
       Canvas.MoveTo(0, RowPixel-1);
       Canvas.LineTo(ColWidths[0]-1, RowPixel-1);
       Canvas.Pen.Color:= clBtnHighlight;
       Canvas.MoveTo(0, RowPixel);
       Canvas.LineTo(ColWidths[0], RowPixel);
    end;

    procedure ButtonCaptionLine;
    begin
       if (CurRow=TopRow) and IndicatorRow.enabled  then exit;
{       if IsCaptionLinesVisible and (CurRow=Row+1) then
       begin
       end
       else }if IsHighlightRowVisible and (CurRow=Row) then
       begin
          Canvas.Pen.Color:= clBlack;
          Canvas.MoveTo(0, RowPixel-1);
          Canvas.LineTo(ColWidths[0]-1, RowPixel-1);
          Canvas.Pen.Color:= clBtnShadow;
          Canvas.MoveTo(0, RowPixel-2);
          Canvas.LineTo(ColWidths[0]-1, RowPixel-2);
          Canvas.Pen.Color:= clBtnShadow;
          Canvas.MoveTo(0, RowPixel);
          Canvas.LineTo(ColWidths[0]-1, RowPixel);
       end
       else begin
          Canvas.Pen.Color:= clBtnShadow;
          Canvas.MoveTo(0, RowPixel-2);
          Canvas.LineTo(ColWidths[0]-1, RowPixel-2);
          Canvas.Pen.Color:= clBlack;
          Canvas.MoveTo(0, RowPixel-1);
          Canvas.LineTo(ColWidths[0]-1, RowPixel-1);
          Canvas.Pen.Color:= clBtnHighlight;
          Canvas.MoveTo(0, RowPixel);
          Canvas.LineTo(ColWidths[0], RowPixel);
       end;
    end;

   procedure EndPainting;
   var r, sourceRect: TRect;
       PaintClipRect: TRect;
       tempRect: TRect;
   begin
     if (inherited Canvas = Canvas) then exit;
     r := ClientRect;

     OffsetRect(r, 1, 0);
      if csPaintCopy in ControlState then
         Canvas.CopyMode:= cmSrcAnd
      else
         Canvas.CopyMode:= cmSrcCopy;
//     (inherited Canvas).CopyMode:= cmSrcCopy;

     PaintClipRect:= FPaintCanvas.ClipRect;
     if PaintClipRect.Right>ClientRect.Right then
     begin
        PaintClipRect.Right:= ClientRect.Right;
     end;
     if UpdateRect.Bottom>ClientRect.Bottom then
     begin
        UpdateRect.Bottom:= ClientRect.Bottom;
     end;

     if (UpdateRect.Top=0) and (UpdateRect.Bottom=0) and
        (UpdateRect.Left=0) and (UpdateRect.Right=0) then
        UpdateRect:= PaintClipRect;
     SourceRect:= Rect(0,UpdateRect.Top,
        PaintClipRect.Right, UpdateRect.Bottom );
     { Remove painting of currently edited cell }
     if not (csDesigning in ComponentState) and (EffectiveFocused) and (HaveVisibleItem) then
     begin
       if Col<=1 then
          TempRect:= CellRect(1,Row)
       else
          TempRect:= CellRect(Col,Row);
       TempRect.Left:= TempRect.Left + 1; { Used to be +2, but richedit gray line would show after resizing }
       TempRect.Bottom:= TempRect.Bottom - 2;  // 2/5/01 - Need to paint bottom so -1 subtracted
       tempRect.Right:= tempRect.Right - 1;

       { 7/19/00 - RSW - Don't remove inplaceeditor painting if it has the focus}
       // 2/20/01 - Don't remove activeedit area as it causes problem with AlwaysTransparent of checkbox
       if (ActiveEdit<>nil) and (ActiveEdit<>InplaceEditor) and (not UseCheckbox(Row)) then
          if not wwGetAlwaysTransparent(ActiveEdit) then
             FPaintCanvas.CopyRect(tempRect, inherited Canvas, tempRect);
     end;

     SourceRect:= Rect(0, 0, ClientRect.Right, ClientRect.Bottom);
     inherited Canvas.CopyRect(SourceRect, FPaintCanvas, SourceRect);
   end;

  procedure DrawHighlightCustomControlLines;
  var r: TRect;
  begin
     obj:= ActiveItem;
     if (obj<>nil) and (obj.CustomControlHighlight) then
     begin
        Canvas.Brush.Color := clWindowFrame;
        r:= CellRect(Col, Row);
        r.Right:= r.right+1;
        Canvas.FrameRect(r);
     end;
  end;

  procedure PaintIndicatorLines;
  var ACol: integer;
      TempColCount: integer;
      lineoffset:integer;
  begin

     if IndicatorRow.enabled then
     begin
//        Canvas.Pen.Color:= clBtnHighlight;
//        Canvas.MoveTo(0, 0);
//        Canvas.LineTo(CellRect(ColCount-1, 0).right, 0);
        Canvas.Pen.Color:= clBtnHighlight;
        TempColCount:= ColCount;
        if FDataLink.Active and (ColCount>2) then
           TempColCount:= wwMax(1, wwMin(ColCount, FDataLink.RecordCount+1));

        for ACol:= 0 to ColCount-1 do
        begin
           Canvas.Pen.Color:= clBtnHighlight;
           Canvas.MoveTo(CellRect(ACol, 0).Left, 0);
           lineoffset := 0;
           if ACol<=TempColCount then lineoffset := 1;
           if ovHideVertFixedLines in Options then lineoffset := 0;
           Canvas.LineTo(CellRect(ACol, 0).right-lineoffset, 0);

           if ACol<=TempColCount then lineoffset := 1;
           Canvas.MoveTo(CellRect(ACol, 0).Left, RowHeights[0]-1);
           Canvas.LineTo(CellRect(ACol, 0).right-lineoffset, RowHeights[0]-1);

           Canvas.Pen.Color:= clBlack;
           Canvas.MoveTo(CellRect(ACol, 0).Right, RowHeights[0]-2);
           Canvas.LineTo(CellRect(ACol, 0).right, RowHeights[0]-2);
        end;

        Canvas.Pen.Color:= clBlack;
        Canvas.MoveTo(0, RowHeights[0]-2);
        Canvas.LineTo(CellRect(0, 0).right, RowHeights[0]-2);
{        Canvas.Pen.Color:= clBtnHighlight;
        Canvas.MoveTo(0, RowHeights[0]-1);
        Canvas.LineTo(CellRect(0, 0).right-1, RowHeights[0]-1);}
        Canvas.Pen.Color:= clBlack;
        Canvas.MoveTo(CellRect(0, 0).Right, RowHeights[0]-2);
        Canvas.LineTo(CellRect(ColCount-1, 0).right, RowHeights[0]-2);
(*        for i:= 0 to ColCount-2 do
        begin
          Canvas.Pen.Color:= clBtnHighlight;
          Canvas.MoveTo(CellRect(i, 0).right, 0);
          Canvas.LineTo(CellRect(i, 0).right, RowHeights[0]-1);
          Canvas.Pen.Color:= clBlack;
          Canvas.MoveTo(CellRect(i, 0).right-1, 0);
          Canvas.LineTo(CellRect(i, 0).right-1, RowHeights[0]-1);
          // Enables button look for fixed cells
 {         Canvas.Pen.Color:= clBtnShadow;
          Canvas.MoveTo(CellRect(i, 0).right-2, 0);
          Canvas.LineTo(CellRect(i, 0).right-2, RowHeights[0]-1);
}
        end;
*)
     end;
   end;
   procedure DrawActiveVerticalLine;
   var Bottom, Top: integer;
      procedure DrawLine(cr: TRect; StartY, EndY: integer);
//      var flags: integer;
      begin
{         cr.top:=starty;
         cr.bottom:=endy;
         cr.right:=cr.right+1;
         cr.left:= cr.left-1;
         flags:= bf_left+bf_right;
//         DrawEdge(Canvas.Handle, cr, EDGE_BUMP, flags);
         DrawEdge(Canvas.Handle, cr, EDGE_raised, flags);
         exit;
}
            Canvas.Pen.Color:= clBtnShadow;
//            Canvas.Pen.Color:= clSilver;
            Canvas.MoveTo(cr.Left-1, StartY);
            Canvas.LineTo(cr.Left-1, EndY);
            Canvas.Pen.Color:= clBlack;
//            Canvas.Pen.Color:= clWhite;
            Canvas.MoveTo(cr.Left, StartY-1);
            Canvas.LineTo(cr.Left, EndY);

            Canvas.Pen.Color:= clSilver;
//            Canvas.Pen.Color:= clBtnShadow;
            Canvas.MoveTo(cr.Right-1, StartY);
            Canvas.LineTo(cr.Right-1, EndY);
            Canvas.Pen.Color:= clWhite;
//            Canvas.Pen.Color:= clBlack;
            Canvas.MoveTo(cr.Right, StartY);
            Canvas.LineTo(cr.Right, EndY);
//            Canvas.Pen.Color:= clWhite;
//            Canvas.MoveTo(cr.Right+1, StartY);
//            Canvas.LineTo(cr.Right+1, EndY);
//            Canvas.Pen.Color:= clGray;
//            Canvas.MoveTo(cr.Right+1, StartY);
//            Canvas.LineTo(cr.Right+1, EndY);
      end;

   begin
      if IndicatorRow.Enabled then Top:= CellRect(0, 0).Bottom
      else Top:=0;

      if (RowCount-1 = DrawInfo.Vert.LastFullVisibleCell) then begin
        Bottom:= CellRect(Col, RowCount-1).Bottom;
      end
      else
        Bottom:= ClientHeight;

      if IsHighlightRowVisible then
      begin
         DrawLine(CellRect(Col, Row), Top, CellRect(Col, Row).Top);
         DrawLine(CellRect(Col, Row), CellRect(Col, Row).Bottom, Bottom);
      end
      else begin
         DrawLine(CellRect(Col, Row), Top, Bottom);
      end
   end;

begin
   if not IsFocused then
   begin
      HideEditor;  { Make sure inplaceeditor is not visible when inspector doesn't have focus }
   end;

   OldDesigning:= csDesigning in ComponentState;

   UseTempCanvas:= True;
   if PaintOptions.InitBlendBitmapsFlag then PaintOptions.InitBlendBitmaps;

   FPaintBitmap.Width := ClientWidth;
   FPaintBitmap.Height:= ClientHeight;

   CalcDrawInfo(DrawInfo);
   // Fill data area
   if Color=clNone then
      Canvas.Brush.Color:= clWindow
   else
      Canvas.Brush.Color:= Color;
   TempRect:= ClientRect;
   TempRect.Left:= ColWidths[0];

   if (ovUseOwnBackgroundColors in Options) or not (csPaintCopy in ControlState) then
     Canvas.FillRect(TempRect);

   // Fill bottom data area
   if not (csPaintCopy in ControlState) then with DrawInfo do
   begin
      if (RowCount-1 = Vert.LastFullVisibleCell) then begin
         TempRect:= CellRect(0, RowCount-1);
         TempRect.Top:= TempRect.Bottom;
         TempRect.Bottom:= ClientHeight;
         TempRect.Right:= ClientWidth;
         if (ovFillNonCellArea in Options) then
         begin
            if PaintOptions.Column1Bitmap<>nil then
               Canvas.CopyRect(TempRect, PaintOptions.Column1Bitmap.Canvas, TempRect)
            else begin
               if FixedColor=clNone then
                  Canvas.Brush.Color:= clWindow
               else
                  Canvas.Brush.Color:= FixedColor;
               Canvas.FillRect(TempRect);
            end
         end
         else begin
            TempRect.Left:= ColWidths[0];
            if PaintOptions.HaveBackgroundForDataCells then
               Canvas.CopyRect(TempRect, PaintOptions.OrigBitmap.Canvas, TempRect)
            else begin
               Canvas.Brush.Color:= Color;
               Canvas.FillRect(TempRect);
            end
         end
      end;
   end;

   // 8/2/02
   if (not (ovUseOwnBackgroundColors in Options)) and (parent is TwwDBGrid) and not (csPaintCopy in ControlState) then
      TwwDBGrid(parent).PaintActiveRowBackground(Canvas, ClientRect);

   // Fill caption area
   TempRect:= ClientRect;
   TempRect.Right:= ColWidths[0];

   // Honor CaptionColor = clNone
   if (not (csPaintCopy in ControlState) and not (Parent is TwwDBGrid))
      or (CaptionColor <> clNone) then
   begin
      if PaintOptions.Column1Bitmap<>nil then
         Canvas.CopyRect(TempRect, PaintOptions.Column1Bitmap.Canvas, TempRect)
      else begin
         if FixedColor=clNone then
            Canvas.Brush.Color:= clWindow
         else
            Canvas.Brush.Color:= FixedColor;
         Canvas.FillRect(TempRect);
      end;
   end;

   try
     if Assigned(FOnBeforePaint) then
     begin
        FOnBeforePaint(self);
     end;
     if CheckRowCount then FirstTimePaint;
     UpdateRowCount;

     CalcDrawInfo(DrawInfo);

     RowPixel:= 0;
     if IndicatorRow.enabled then RowPixel:= RowHeights[0];

     InheritedPaint;

     for CurRow:= TopRow to RowCount do
     begin
        if (parent is TCustomGrid) and (CurRow=RowCount) then break;

        case LineStyleCaption of
          ovNoLines: if curRow = RowCount then LightCaptionLine;
          ovDottedLine : DottedCaptionLine;
          ovLight3DLine: LightCaptionLine;
          ovDark3DLine: DarkCaptionLine;
          ovButtonLine : ButtonCaptionLine;
        end;

        if (CurRow>=TopRow) then
        begin
          case LineStyleData of
            ovNoLines:
              begin
               if (curRow = RowCount) then LightDataLine
               else if (CurRow=TopRow) and IndicatorRow.enabled then
//                  LightDataLine
               else NoDataLine;
              end;

            ovDottedLine : DottedDataLine;
            ovLight3DLine: LightDataLine;
            ovDark3DLine: DarkDataLine;
            ovButtonLine: ButtonDataLine;
          end;
        end;

        if (LineStyleData = ovButtonLine) and
           (CurRow <> Row){ and (CurRow <> Row+1)} and
           (CurRow<RowCount) then begin
          Canvas.Pen.Color:= clBtnShadow;
          Canvas.MoveTo(ColWidths[0]-2, RowPixel);
          Canvas.LineTo(ColWidths[0]-2, RowPixel+RowHeights[CurRow]);
          Canvas.Pen.Color:= clBtnHighlight;
          Canvas.MoveTo(0, RowPixel);
          Canvas.LineTo(0, RowPixel+RowHeights[CurRow]);
          Canvas.Pen.Color:= clBtnShadow;
          Canvas.MoveTo(ColWidths[0]+ColWidths[1]-1, RowPixel);
          Canvas.LineTo(ColWidths[0]+ColWidths[1]-1, RowPixel+RowHeights[CurRow]);
        end
        else if (LineStyleData = ovButtonLine) and
           (CurRow = Row) and (CurRow<RowCount) then begin
          if not IsHighlightRowVisible then begin
            Canvas.Pen.Color:= clBtnShadow;
            Canvas.MoveTo(ColWidths[0], RowPixel);
            Canvas.LineTo(ColWidths[0], RowPixel+RowHeights[CurRow]);
            Canvas.MoveTo(ColWidths[0]-2, RowPixel);
            Canvas.LineTo(ColWidths[0]-2, RowPixel+RowHeights[CurRow]);
          end;

          if not IsHighlightRowVisible then
            Canvas.Pen.Color:= clBtnHighlight
          else Canvas.Pen.Color:= clBtnShadow;
          Canvas.MoveTo(0, RowPixel);
          Canvas.LineTo(0, RowPixel+RowHeights[CurRow]);

          if BorderStyle = bsNone then begin
             Canvas.Pen.Color:= clBtnHighlight;
             Canvas.MoveTo(ColWidths[0]+ColWidths[1]-1, RowPixel);
             Canvas.LineTo(ColWidths[0]+ColWidths[1]-1, RowPixel+RowHeights[CurRow]);
          end;
        end;

        if curRow<RowCount then inc(RowPixel, RowHeights[CurRow]);
        if RowPixel>DrawInfo.Vert.GridBoundary then break;
     end;

     DrawSeparatorLines;
     DrawHighlightCustomControlLines;
     SkipPaintIndicatorLines:= False;

     { Draw caption highlight line for active row }
     if EffectiveFocused then
     begin
       RowPixel:= CellRect(0, Row).Top;

       if ColorToRGB(CaptionColor)=ColorToRGB(clBtnHighlight) then
          Canvas.Pen.Color:= clBlack
       else Canvas.Pen.Color:= clBtnHighlight;
       Canvas.Pen.Color:= clBtnShadow;

       if IsHighlightRowVisible then
       begin
          PaintIndicatorLines;
          SkipPaintIndicatorLines:= True;
          Canvas.Pen.Color:= clBtnShadow;
          Canvas.MoveTo(0, RowPixel-2);
          Canvas.LineTo(CellRect(ColCount-1, Row).Right, RowPixel-2);
          Canvas.Pen.Color:= clBlack;
          Canvas.MoveTo(0, RowPixel-1);
          Canvas.LineTo(CellRect(ColCount-1, Row).Right, RowPixel-1);
          RowPixel:= CellRect(0, Row).Bottom;
          Canvas.Pen.Color:= clSilver;
          Canvas.MoveTo(0, RowPixel-1);
          Canvas.LineTo(CellRect(ColCount-1, Row).Right-1, RowPixel-1);
          Canvas.Pen.Color:= clBtnHighlight;
          Canvas.MoveTo(0, RowPixel);
          Canvas.LineTo(CellRect(ColCount-1, Row).Right, RowPixel);
       end
       else begin
          if (Row<>TopRow) then
          begin
            Canvas.MoveTo(CellRect(Col, Row).left, RowPixel-1);
            Canvas.LineTo(CellRect(Col, Row).Right, RowPixel-1);
          end;
{          RowPixel:= CellRect(0, Row).Bottom;
          Canvas.MoveTo(CellRect(Col, Row).left, RowPixel-2);
          Canvas.LineTo(CellRect(Col, Row).Right, RowPixel-2);}
       end;
     end;

     if (ovActiveRecord3dlines in Options) then
     begin
        DrawActiveVerticalLine;
     end;
     if not SkipPaintIndicatorLines then PaintIndicatorLines;

     EndPainting;

     if useDefaultEditor and (inplaceeditor<>nil) then begin
        inplaceeditor.invalidate;
        inplaceeditor.update;
     end
     else begin
        if CurrentCustomEdit<>nil then begin
          UpdateCustomEditPaint(CurrentCustomEdit);
        end;
     end;

     obj:= ActiveItem;
     if obj<>LastActiveItem then
     begin
        LastActiveItem:= obj;
        if Assigned(FOnAfterSelectCell) then begin
           FOnAfterSelectCell(Self, Obj);
        end;
     end;

   finally
     UseTempCanvas:= False;
     ValidateRect(handle, nil);  // Don't paint again
   end;

end;

function TwwDataInspector.CanEditShow: Boolean;
//var
//   customEdit: TCustomEdit;
//   obj: TwwInspectorItem;
begin
  Result := inherited CanEditShow;
  if Result then
  begin
//     obj:= GetItemByRow(Row);
     result:= UseDefaultEditor;
//     result:= (Obj<>nil) and (obj.CustomControl=nil) and not (obj.Field is TDateTimeField)
  end;

end;

procedure TwwDataInspector.UpdateCurrentEditPosition;
var  DrawInfo: TGridDrawInfo;
begin
  if CurrentCustomEdit<>nil then
  begin
     CalcDrawInfo(DrawInfo);
     if (Row<TopRow) or (Row>DrawInfo.Vert.LastFullVisibleCell+1) then
     begin
        if Screen.activecontrol=CurrentCustomEdit then SetFocus;
        CurrentCustomEdit.Hide;
     end
     else begin
        CurrentCustomEdit.BoundsRect:= ControlRect(Col, Row);
        CurrentCustomEdit.visible:=true;
        CurrentCustomEditSetFocus;
     end;
  end;
end;

(*
procedure TwwDataInspector.InitBlendBitmaps(ForceInit: boolean = False);
var ARect: TRect;
    NewboundsRect: TRect;
    DrawInfo: TGridDrawInfo;
    HaveBackgroundBitmap: boolean;
    i,j: integer;
    MemDC: HDC;
begin
   if (not ForceInit) and (not InitBlendBitmapsFlag) then exit;

{   NewboundsRect:= Rect(0, 0, BoundsRect.right-BoundsRect.left, BoundsRect.bottom-BoundsRect.top);
   if SameRect(OldBoundsRect, NewBoundsRect) then exit;
   OldboundsRect:= NewBoundsRect;
}
   NewboundsRect:= Rect(0, 0, BoundsRect.right-BoundsRect.left, BoundsRect.bottom-BoundsRect.top);

   CalcDrawInfo(DrawInfo);
   UseTempCanvas:=True;
   try
      FPaintBitmap.Width := NewBoundsRect.right;
      FPaintBitmap.Height:= NewBoundsRect.Bottom;

      Canvas.Brush.Color:= clWhite;
      Canvas.FillRect(newBoundsRect);

      if not (PaintOptions.BackgroundBitmap.Width=0) then
      begin
         HaveBackgroundBitmap:=True;
         case PaintOptions.BackgroundBitmapDrawStyle of
           bdsTile:
             begin
                with PaintOptions.BackgroundBitmap do begin
                   for i := 0 to (Self.Width div Width) do
                     for j := 0 to (Self.Height div Height) do
                       Canvas.Draw(i*Width, j*Height,Graphic);
                end
             end;
           bdsTopLeft:
             begin
                with PaintOptions.BackgroundBitmap do
                   Canvas.Draw(0, 0, Graphic);
             end;
           bdsCenter:
             begin
                with PaintOptions.BackgroundBitmap do
                   Canvas.Draw((self.width-Width)div 2,
                               (self.Height-Height) div 2, Graphic);
             end;
           bdsStretch:
             begin
                with PaintOptions.BackgroundBitmap do
                   Canvas.StretchDraw(Rect(0, 0, newBoundsRect.right, NewBoundsRect.bottom), Graphic);
             end;
         end;
      end
      else if Assigned(FOnBeforePaint) then
      begin
         FOnBeforePaint(self);
         HaveBackgroundBitmap:= True;
      end
      else HaveBackgroundBitmap:=False;

      // If 256 colors or less then no blending
      MemDC := GetDC(0);
      try
        if GetDeviceCaps(MemDC, BITSPIXEL)<=8 then exit;
      finally
        ReleaseDC(0, MemDC);
      end;

      if HaveBackgroundBitmap then
      begin
        if (OrigBitmap=nil) then
           OrigBitmap := TBitmap.Create;
        ARect:= NewBoundsRect;
        OrigBitmap.Assign(FPaintBitmap);
      end
      else begin
         OrigBitmap.Free;
         OrigBitmap:= nil;
      end;

      if (PaintOptions.ActiveColumnColor<>clNone) and
         HaveBackgroundBitmap and (coBlendActiveColumn in PaintOptions.BlendBitmapOptions) then
      begin
         if ActiveColumnBitmap = nil then
            ActiveColumnBitmap := TwwBitmap.Create;
         ARect:= newBoundsRect;//ClientRect;
         ActiveColumnBitmap.SetSize(ARect.Right, ARect.Bottom);
         ActiveColumnBitmap.canvas.CopyRect(ARect, Canvas, ARect);
         with wwGetColor(ColorToRGB(PaintOptions.ActiveColumnColor)) do
            ActiveColumnBitmap.Colorize(r,g,b);
      end
      else begin
         ActiveColumnBitmap.Free;
         ActiveColumnBitmap:= nil;
      end;

      if (PaintOptions.AlternatingRowColor<>clNone) and
         (PaintOptions.AlternatingRowRegions<>[]) and
         HaveBackgroundBitmap and (coBlendAlternatingRow in PaintOptions.BlendBitmapOptions) then
      begin
         if AlternatingColorBitmap = nil then
            AlternatingColorBitmap := TwwBitmap.Create;

         ARect:= NewBoundsRect;
         AlternatingColorBitmap.SetSize(ARect.Right, ARect.Bottom);
         AlternatingColorBitmap.canvas.CopyRect(ARect, Canvas, ARect);

         with wwGetColor(ColorToRGB(PaintOptions.AlternatingRowColor)) do
            AlternatingColorBitmap.Colorize(r,g,b);
      end
      else begin
         AlternatingColorBitmap.Free;
         AlternatingColorBitmap:= nil;
      end;

      if IndicatorRow.enabled and
         HaveBackgroundBitmap and (coBlendIndicatorRow in PaintOptions.BlendBitmapOptions) then
      begin
        if IndicatorRowBitmap=nil then
           IndicatorRowBitmap:= TwwBitmap.create;
        ARect:= CellRect(0,0);
        ARect.Right:= NewBoundsRect.Right;

        IndicatorRowBitmap.SetSize(ARect.Right, ARect.Bottom);
        IndicatorRowBitmap.Canvas.CopyRect(ARect, Canvas, ARect);

        with wwGetColor(ColorToRGB(IndicatorRow.Color)) do
           IndicatorRowBitmap.Colorize(r,g,b);
      end
      else begin
         IndicatorRowBitmap.Free;
         IndicatorRowBitmap:= nil;
      end;

      if HaveBackgroundBitmap and (coBlendCaptionColumn in PaintOptions.BlendBitmapOptions) then
      begin
        if CaptionColumnBitmap=nil then
           CaptionColumnBitmap:= TwwBitmap.create;
//        ARect:= CellRect(0,0);
//        ARect.Bottom:= NewBoundsRect.bottom;
        if ovFillNonCellArea in Options then ARect:= NewBoundsRect;
        ARect:= NewBoundsRect;

        CaptionColumnBitmap.SetSize(ARect.Right, ARect.Bottom);
        CaptionColumnBitmap.Canvas.CopyRect(ARect, Canvas, ARect);

        if (FixedColor<>clNone) then
        begin
          with wwGetColor(ColorToRGB(FixedColor)) do
             CaptionColumnBitmap.Colorize(r,g,b);
        end
      end
      else begin
         CaptionColumnBitmap.Free;
         CaptionColumnBitmap:= nil;
      end;
   finally
      UseTempCanvas:= False;
      InitBlendBitmapsFlag:= False;
   end
end;
*)
procedure TwwDataInspector.TopLeftChanged;
var NextItem: TwwInspectorItem;
    i: integer;
begin
  FreeHintWindow;

  inherited;
  if Assigned(FOnTopLeftChanged) then FOnTopLeftChanged(Self);
//  InitBlendBitmaps;

  UpdateCurrentEditPosition;

  if not FastDesign then exit;

  if FTopItem=nil then
  begin
     FTopItem:= GetFirstChild;
     if FTopItem=nil then exit;
  end;

  if (TopRow>OldTopRow) then
  begin
     if (TopRow-OldTopRow<100) then begin
        for i:= 1 to TopRow-OldTopRow do
        begin
           NextItem:= FTopItem.GetNext(True);
           if NextItem<>nil then FTopItem:=NextItem
           else break;
        end
     end
     else FTopItem:= GetItemByRow(TopRow, False);
  end
  else begin
     if (OldTopRow-TopRow<100) then
     begin
        for i:= 1 to OldTopRow-TopRow do
        begin
           NextItem:= FTopItem.GetPrior(True);
           if NextItem<>nil then FTopItem:=NextItem
           else break;
        end;
     end
     else FTopItem:= GetItemByRow(TopRow, False)
  end;

  OldTopRow:= TopRow;
end;

procedure TwwDataInspector.DoExit;
begin
   if CurrentCustomEdit<>nil then
   begin
      CurrentCustomEdit.hide;
      CurrentCustomEdit:= nil;
   end;
   HideEditor;
   inherited doExit;
end;

function TwwDataInspector.CreateEditor: TInplaceEdit;
begin
  Result := TwwDataInspectorEdit.wwCreate(Self, 0);
end;

constructor TwwDataInspectorEdit.wwCreate(AOwner: TComponent; dummy: integer);
begin
  Create(AOwner);
  FwwPicture:= TwwDBPicture.create(self);
  ParentGrid:= Owner as TwwDataInspector;
  FWordWrap:= False;
//  FWordWrap:= TwwDataInspector(ParentGrid).WordWrap;
  {$ifdef wwDelphi3Up}
  ImeMode := ParentGrid.ImeMode;
  ImeName := ParentGrid.ImeName;
  {$endif}
  ControlStyle:= ControlStyle + [csReplicatable];
end;

destructor TwwDataInspectorEdit.Destroy;
begin
  FwwPicture.Free;
  FCanvas.Free;
  inherited Destroy;
end;

{ Convert cr to tab }
procedure TwwDataInspectorEdit.KeyDown(var Key: Word; Shift: TShiftState);
type
  TSelection = record
    StartPos, EndPos: Integer;
  end;
  procedure SendToParent;
  begin
     ParentGrid.setFocus;
     ParentGrid.KeyDown(Key, Shift);
     Key := 0;
     Update;
  end;

  procedure SendToObjectView;
  begin
//    ParentGrid.setFocus;
     ParentGrid.KeyDown(Key, Shift);
  end;

  function Selection: TSelection;
  begin
    SendMessage(Handle, EM_GETSEL, Longint(@Result.StartPos), Longint(@Result.EndPos));
  end;

  function RightSide: Boolean;
  begin
    with Selection do
      Result := ((StartPos = 0) or (EndPos = StartPos)) and
        (EndPos = GetTextLen);
  end;

  function LeftSide: Boolean;
  begin
    with Selection do
      Result := (StartPos = 0) and
      ((EndPos = 0) or (EndPos = GetTextLen) or (isMasked and (EndPos=1)));
  end;

  procedure ParentEvent;
  var
    GridKeyDown: TKeyEvent;
  begin
    GridKeyDown := ParentGrid.OnKeyDown;
    if Assigned(GridKeyDown) then GridKeyDown(ParentGrid, Key, Shift);
  end;

  function Ctrl: Boolean;
  begin
    Result := ssCtrl in Shift;
  end;

  function InspectorInGrid: boolean;
  begin
      result:= parentGrid.parent is TwwDBGrid;
  end;


begin
  case Key of
    VK_RETURN:
	 if ovEnterToTab in ParentGrid.Options then
	 begin
	    SendToParent;
	 end;
    VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT, VK_ESCAPE: SendToParent;
    VK_INSERT:
      if Shift = [] then SendToParent
      else if (Shift = [ssShift]) and not ParentGrid.CanEditModify then Key := 0;
    VK_LEFT:  if (Ctrl or (not InspectorInGrid)) and (ParentGrid.ColCount<=2) then SendToObjectView; // 6/13/02 - Don't send unless Ctrl
    VK_RIGHT:  if (Ctrl or (not InspectorInGrid)) and (ParentGrid.ColCount<=2) then SendToObjectView; // 6/13/02 - Don't send unless Ctrl
    VK_HOME: if Ctrl then SendToParent;
    VK_END: if Ctrl then SendToParent;
    VK_F2:
      begin
        ParentEvent;
        if Key = VK_F2 then
        begin
          Deselect;
          Exit;
        end;
      end;
    VK_TAB: if not (ssAlt in Shift) then SendToParent;
  end;
  if (Key = VK_DELETE) and not ParentGrid.CanEditModify then Key := 0;
  if Key <> 0 then
  begin
    ParentEvent;
    if IsMasked then
       inherited KeyDown(Key, Shift)
    else if Assigned(OnKeyDown) then OnKeyDown(Self, Key, Shift);
  end;
end;

procedure TwwDataInspectorEdit.BoundsChanged;
var
  R: TRect;
begin
  { Inplaceeditor is one pixel too tall and wide, so shrink it }
  SetWindowPos(Handle, HWND_TOP, Left+1, Top, Width-2, Height-1,
        SWP_SHOWWINDOW or SWP_NOREDRAW);
        
  R := Rect(1, 1, Width - 2, Height);
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
end;

procedure TwwDataInspectorEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
   if (ovEnterToTab in ParentGrid.Options)and (Key=VK_RETURN) then Key:= 9;
   inherited KeyUp(Key, Shift);
   if (Key= VK_DELETE) then
   begin
      if Assigned(parentGrid.FOnCheckValue) then
	 IsValidPictureValue(Text);
   end
end;

procedure TwwDataInspectorEdit.KeyPress(var Key: Char);
var pict: TwwPictureValidator;
    s: string;
    res: TwwPicResult;
    padlength, OldSelStart, Oldlen, OldSelLen: integer;
    DisplayTextIsInvalid, skipInvalidValueTest: boolean;

   Function NewText: string;
   var curStr : string;
   begin
      curStr:= Text;
      if (ord(key)=vk_back) then begin
	 if (length(curstr)>=1) then
	    delete(curstr, selStart, 1);
	 result:= curStr;
      end
      else
	 result:= copy(curStr, 1, selStart+1-1) +
	       char(Key) + copy(curStr, selStart + 1 + length(SelText), 32767);
   end;


begin
  if (ovEnterToTab in ParentGrid.Options) and (ord(Key)=VK_RETURN) then Key:= #9;
  inherited KeyPress(Key);

  if HavePictureMask then begin
     if (ord(Key) = VK_BACK) then
     begin
       if Assigned(parentGrid.FOnCheckValue) then IsValidPictureValue(NewText);
       exit;
     end;
     if (ord(key)<VK_SPACE) then exit;

     s:= NewText;
     if (Maxlength>0) and (length(s)>MaxLength) and (length(s)>length(Text)) then exit; { Limit to maxlength }

     pict:= TwwPictureValidator.create(FwwPicture.PictureMask, FwwPicture.AutoFill);
     res:= Pict.picture(s, FwwPicture.AutoFill);
     DisplayTextIsInvalid:= False;
     SkipInvalidValueTest:= False;

     oldSelStart:= SelStart;
     oldLen:= length(Text);
     oldSelLen:= SelLength;

     case res of
       prError: begin
	     { If at end of list }
	     if (selStart + length(selText) >= length(Text)) then begin
		key:= char(0);
		MessageBeep(0);
               SkipInvalidValueTest:= True; { 2/4/98 - Rely upon previous call }
	     end
	     else DisplayTextIsInvalid:= True;
	 end;

       prIncomplete: begin
	    padLength := length(s) - length(text);
	    text:= s;
	    (Owner as TwwDataInspector).FEditText:= Text;
	    if (oldSelLen=oldLen) then selStart:= length(s)
	    else selStart:= OldSelStart + padLength;
	    key:= char(0);
	    DisplayTextIsInvalid:= True;
	    end;

       prComplete: begin
            {11/21/96 - Workaround for Delphi 2 bug in scrolling in unbordered control}
             text:= s;
             (Owner as TwwDataInspector).FEditText:= s;
             if (oldSelLen=oldLen) then selStart:= length(s)
             else if (length(s)>oldlen) then
                selStart:= oldSelStart + (length(s)-oldlen) {Move caret to the right}
             else selStart:= oldSelStart + 1;  { 11/26/96 }
             selLength:= 0;  { 8/12/97 }
             key:= char(0);
             modified:= true; { 11/3/99 - Allow inspector item change event to fire }
	 end;

     end;
     pict.Free;

     if (not SkipInvalidValueTest) and
        Assigned(parentGrid.FOnCheckValue) then
	parentGrid.FOnCheckValue(self, not DisplayTextIsInvalid);

  end;
end;

{ Allow paste to change text - 10/29/96 }
procedure TwwDataInspectorEdit.WMPaste(var Message: TMessage);
begin
  inherited;
  if not ParentGrid.CanEditModify then exit;
end;

procedure TwwDataInspectorEdit.SetWordWrap(val: boolean);
begin
   FWordWrap:= val;
   RecreateWnd;
end;

procedure TwwDataInspectorEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style and not (ES_AUTOVSCROLL or ES_WANTRETURN);
  if (BorderStyle = bsNone) or WordWrap then Params.Style:= Params.Style or ES_MULTILINE;
  if WordWrap then Params.Style := (Params.Style or ES_AUTOVSCROLL) and not ES_AUTOHSCROLL;
end;

function TwwDataInspectorEdit.IsValidPictureValue(s: string): boolean;
var pict: TwwPictureValidator;
    res: TwwPicResult;
begin
   if s='' then
      result:= True
   else if not HavePictureMask then
      result:= True
   else begin
      pict:= TwwPictureValidator.create(FwwPicture.PictureMask, FwwPicture.AutoFill);;
      res:= Pict.picture(s, False);
      result := res = prComplete;
      pict.Free;
   end;
   if Assigned(parentGrid.FOnCheckValue) then
      parentGrid.FOnCheckValue(self, result);
end;

procedure TwwDataInspectorEdit.UpdateContents;
var obj: TwwInspectorItem;
    ARect: TRect;
begin
   inherited;
   obj:= ParentGrid.GetItemByRow(ParentGrid.Row);
   if obj=nil then exit;  //4/25/2000 PYW Make sure Obj is not nil.  This can happen when reassigning the datasource.
   ReadOnly:= obj.ReadOnly;
   ARect:= ParentGrid.CellRect(ParentGrid.Row, 1);
   FWordWrap:= (obj.WordWrap) or
               (obj.field is TBlobField) {and
               (not wwIsSingleLineEdit(ParentGrid.Canvas.Handle, ARect, 0))};
   Enabled:= obj.Enabled; // 8/21/02
   
   ParentGrid.SkipSetFocus:= True;
   Try
     RecreateWnd;
   finally
     ParentGrid.SkipSetFocus:= False;
     SetFocus;
   end;

end;

procedure TwwDataInspectorEdit.WMSetFocus(var Message: TWMSetFocus);
var tempMask: string;
    tempAutoFill: boolean;
    obj: TwwInspectorItem;
begin
  // 7/21/01 - Fix invisible combo bug
  with ParentGrid do
     if inplaceeditor<>nil then
        tedit(inplaceeditor).font:= font;

  inherited;
  with ParentGrid do begin
     obj:= GetItemByRow(Row);

     if parentGrid.PictureMaskFromDataSet and (obj.Field<>nil) then begin
        if (parentGrid.datasource=nil) or (parentGrid.datasource.dataset=nil) then exit;
        wwPictureByField(Datasource.dataset, obj.Field.FieldName, True,
    		      tempMask, tempAutoFill, FUsePictureMask);
        FwwPicture.PictureMask:= tempMask;
        FwwPicture.AutoFill:=tempAutoFill;
        FwwPicture.AllowInvalidExit:= False;
        IsValidPictureValue(obj.Field.text)
     end
     else TwwDataInspectorEdit(InplaceEditor).Picture.Assign(obj.Picture);
  end;

end;


Function TwwDataInspectorEdit.HavePictureMask: boolean;
begin
   result:=
//     FUsePictureMask and
     (FwwPicture.PictureMask<>'')
end;

procedure TwwDataInspectorEdit.CMFontChanged(var Message: TMessage);
var
  Loc: TRect;
begin
  inherited;
  Loc.Bottom :=ClientHeight;
  Loc.Right := ClientWidth-1;
  if BorderStyle = bsNone then begin
     Loc.Top := 2;
     Loc.Left := 2;
  end
  else begin
     Loc.Top := 0;
     Loc.Left := 0;
  end;
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));  { Use 2 pixel border on top and left }
end;

procedure TwwDataInspector.ValidationErrorUsingMask(Item: TwwInspectorItem);
var msg: string;
    doDefault: boolean;
begin
  msg:= Format(SMaskEditErr, ['']);
  DoDefault:= True;
  if Assigned(FOnValidationErrorUsingMask) then
     FOnValidationErrorUsingMask(self, Item, msg, doDefault);
  if doDefault then
  begin
     MessageBeep(0);
     raise EInvalidOperation.create(msg);
  end
end;

procedure TwwDataInspector.UpdateData;
var NewDate, NewTime: TDateTime;
    obj: TwwInspectorItem;
    editor: TwwDataInspectorEdit;
    FloatValue: Extended;
begin
  if UseCheckBox(Row) then exit; // 12/17/00 - RSW - Already updated when toggling checkbox
  obj:= GetItemByRow(Row);

  if (InplaceEditor <> nil) then
  begin
     editor:= TwwDataInspectorEdit(InplaceEditor);
     if (editor.HavePictureMask) and
        (FDataLink as TwwDataInspectorDataLink).isFieldModified and
        (not editor.IsValidPictureValue(editor.Text)) and
        (not editor.Picture.AllowInvalidExit) then
     begin
         ValidationErrorUsingMask(obj);
         exit;
     end
  end;

  if obj.Field<>nil then begin
     { Handle 2 digit year logic }
     TextIsSame:= (obj.Field.Text = FEditText);

     if (obj.Field is TBlobField) and (obj.Field.DataType in [ftMemo, ftOraBlob, ftOraCLob]) then
     begin
        obj.Field.asString:= FEditText;
     end
     else if (obj.Field is TDateTimeField) and
        wwStrToDate(FEditText) then
     begin
        { Uses 1950 as Epoch Date for 2 digt years }
        if wwScanDate(FEditText, NewDate) then { 10/12/98 - Avoid converting 4 digit years}
        begin
           NewTime:= Frac(StrToDateTime(FEditText));
           TDateTimeField(obj.Field).asDateTime:= NewDate + NewTime;
        end;
     end
     else if ((obj.field is TIntegerField) or
           (obj.field is TFloatField)) and
           (FEditText<>'') and // 8/15/02 - Allow clearing of field (If text is blank then don't do formatting code)
          (TNumericField(obj.field).DisplayFormat<>'') then
     begin
        if wwStrToFloat2(FEditText, FloatValue, TNumericField(obj.field).DisplayFormat) then
        begin
           if obj.field is TFloatField then
              obj.field.asFloat:= FloatValue
           else if obj.field is TIntegerField then begin
              obj.field.asInteger:= Round(FloatValue)
           end
        end
        else obj.Field.Text := FEditText;
     end
     else
        obj.Field.Text := FEditText;

     if not TextIsSame then
        FieldChanged(obj.Field);
  end
end;

procedure TwwDataInspector.FieldChanged(Field: TField);
var i: integer;
    obj: TwwInspectorItem;
begin
  DoFieldChanged(Field);
  for i:= TopRow to TopRow + VisibleRowCount-1 do
  begin
     obj:= GetItemByRow(i);
     if (obj<>nil) and (Field<>nil) and (obj.Field=Field) then
        InvalidateRow(i);
  end;
end;

procedure TwwDataInspector.DoItemChanged(Item: TwwInspectorItem; NewValue: string);
begin
  if Assigned(FOnItemChanged) then
     FOnItemChanged(self, Item, NewValue);
end;

procedure TwwDataInspector.DoFieldChanged(Field: TField);
begin
  if Assigned(FOnFieldChanged) then
     FOnFieldChanged(self, Field);
end;

procedure TwwDataInspector.RecordChanged(Field: TField);
var
  R: TRect;
  obj: TwwInspectorItem;
  OldSelStart, OldSelLength: integer;
  SameText: boolean;
begin
  if not HandleAllocated then Exit;

  obj:= GetItemByRow(Row);

  R:= CellRect(1, Row);
  InvalidateRect(Handle, @R, False);

  SameText:= (obj.field<>nil) and (obj.Field.Text = FEditText);
  if SameText and (InplaceEditor<>nil)and InplaceEditor.HandleAllocated then
  begin
    OldSelStart:= InplaceEditor.SelStart;
    OldSelLength:= InplaceEditor.SelLength;
  end
  else begin // make compiler happy
     OldSelStart:= 0;
     OldSelLength:= 0;
  end;

 // ? Calling InvalidateEditor would cause the text to all get selected when going into edit mode
 // 8/21/01 - Uncomment code so tfield assignments change active editor.  At this point
 // the below code was commented but the problem described above does not occur
 // in testing.
  if ((Field = nil) or ((obj.Field<>nil) and (obj.Field = Field)) and
    (obj.Field.Text <> FEditText)) then
  begin
    InvalidateEditor;
    { This code would cause the text to go to the end of instead of replacing the highlighted text }
    { Perhaps should make this a property instead to enable this behavior }
    if SameText and (InplaceEditor<>nil) and InplaceEditor.HandleAllocated then
    begin
       InplaceEditor.SelStart:= OldSelStart;
       InplaceEditor.SelLength:= OldSelLength;
    end;
//    if (not AllSelected) and (InplaceEditor <> nil) then InplaceEditor.Deselect;
  end;

end;

procedure TwwDataInspector.DataChanged;
begin
  if not HandleAllocated then Exit;

  // Adjust ColCount for inserting new record
  if (DataColumns>1) and (FDataLink.RecordCount<>ColCount-1) and (FDataLink.RecordCount>0) then
  begin
//     ColCount:= wwmin(FDataLink.RecordCount+1, DataColumns+1);
     ColCount:= DataColumns+1;
     UpdateDataColumnWidth;
  end;

  if FDataLink.Active and FFocused then  //4/11/2002 - Verify control is focused if calling setfocuscell
  begin
     if NewMouseRow >=0 then
       SetFocusCell(FDataLink.ActiveRecord+1, NewMouseRow)
     else
       SetFocusCell(FDataLink.ActiveRecord+1, Row);
  end;

  UpdateScrollBar;
  UpdateActive; // 7/23/02

  if activeitem<>nil then
     if (activeitem.datasource=datasource) or ChildDataChanged then
       InvalidateEditor;

  ValidateRect(Handle, nil);
  Invalidate;

end;

// 7/23/02 - New method to reposition column based on active record
// For instance, if dataset is opened, or locate is called on dataset
procedure TwwDataInspector.UpdateActive;
begin
  // 8/28/02 - Index out of range when setting table to active before
  if (DataSource=nil) or (DataSource.DataSet=nil) or (not DataSource.DataSet.Active) then exit;

  // 8/28/02 - HideCaptionCol irrelevant to column as caption column is really always there
  if FDataLink.ActiveRecord+1<=ColCount-1 then
      Col := FDatalink.ActiveRecord + 1
end;

function TwwDataInspector.GetField(ARow: integer): TField;
var obj: TwwInspectorItem;
begin
  obj:= GetItemByRow(Row); { 4/26/00 - Check for nil obj }
  if obj=nil then result:=nil
  else result:= obj.Field;
end;

function TwwDataInspector.CanEditModify: Boolean;
var obj: TwwInspectorItem;
    DoEdit: boolean;
begin
  Result := False;
  obj:= GetItemByRow(Row);

  if FDataLink.DataSet=nil then
//  if obj.DataLink.DataSet=nil then
  begin
     Result:=  (not ReadOnly) and (not obj.ReadOnly) and (RowCount>0);
     exit;
  end;

  { Don't allow insert/edit if no records and ovallowinsert is false }
  if (datasource<>nil) and (datasource.dataset<>nil) and
     Datasource.dataset.BOF and datasource.dataset.EOF and
     (datasource.state = dsBrowse) and not (ovAllowInsert in Options) then
  begin
     exit;
  end;

  DoEdit:=  not ReadOnly and
            FDatalink.Active and not FDatalink.Readonly and
            (RowCount > 0) and (not obj.ReadOnly);


  if obj.Field<>nil then begin
     DoEdit:= DoEdit and
       ((obj.Field.CanModify) or (not obj.Field.ReadOnly));
  end;

  if DoEdit then
  begin
{     FDatalink.Edit;
     Result := FDatalink.Editing;
     if Result then TwwDataInspectorDataLink(FDatalink).Modified;
}
     if FDataLink <> obj.DataLink then  { Related table need to go into edit mode }
     begin
        obj.Datalink.Edit;
        Result := obj.Datalink.Editing;
        if Result then TFieldDataLink(obj.DataLink).Modified;
        if Result then TwwDataInspectorDataLink(FDatalink).Modified;
     end
     else begin
        FDatalink.Edit;
        Result := FDatalink.Editing;
        if Result then TwwDataInspectorDataLink(FDatalink).Modified;
     end;

  end;
end;

procedure TwwDataInspector.WMVScroll(var Message: TWMVScroll);
var PrevTopRow: integer;
begin
   PrevTopRow:= TopRow;
   BeginUpdate;

   case Message.ScrollCode of
     SB_THUMBTRACK:
       begin
          InTracking:= True;
          TabStop:= False;
       end;

     SB_ENDSCROLL:
       begin
          if InTracking then
          begin
             inherited;
             TabStop:= True;
             InTracking:= False;
             EndUpdate;
             invalidateRow(Row); {otherwise caret does not seem to show }
             exit;
          end;
       end;

   end;

{  if csDesigning in ComponentState then
  begin
    SpecialHide:= False;
  end;
}
  tabstop:= false;
  inherited;
  tabstop:= true;

   EndUpdate;
   if PrevTopRow<>TopRow then
   begin
      if useDefaultEditor then ShowEditor
      else HideEditor;
      invalidate;
      Update;  { So that if scrollbar is dragged quickly causing multiple scrolling
                 operations, the control does not omit painting any area.  This can
                 happen since wm_setreddraw loses the area that is not valid.
                 Alternatively, we could save the cliprect and restore it.  }
   end

end;


function TwwDataInspector.GetEditMask(ACol, ARow: Longint): string;
var Field: TField;
begin
  Result := '';
  if FDatalink.Active then
     Field:= GetField(ARow)
  else Field:= nil;
  if Assigned(Field) then Result := Field.EditMask;
  if Assigned(FOnGetEditMask) then FOnGetEditMask(Self, ACol, ARow, Result);
end;

Procedure TwwDataInspector.LinkActiveCallback(Item: TwwInspectorItem; UserData: Pointer; var AContinue: boolean);
begin
   if Item.CustomControl<>nil then
   begin
      Item.CustomControl.visible:= false;
      wwSetControlDataField(Item.CustomControl, '');
   end
end;

procedure TwwDataInspector.LinkActive(Value: Boolean);
begin
  if (DefaultDateTimePicker<>Nil) then begin
     wwSetControlDataField(FDateTimePicker, ''); {8/5/98 }
  end;
  if (FCombo<>Nil) then begin
     wwSetControlDataField(FCombo, ''); {8/5/98 }
  end;
  if not Value then HideEditor;

  if (csDestroying in ComponentState) then exit;

  IterateItems(LinkActiveCallback, False, nil);
  CurrentCustomEdit:= nil;

  if InplaceEditor<>nil then TwwDataInspectorEdit(InplaceEditor).UpdateContents;
  ApplySettings;
  UpdateActive; // 7/23/02
  UpdateScrollBar;


end;

procedure TwwDataInspector.DoCreateDefaultCombo(ACombo: TwwDBComboBox);
begin
   if Assigned(FOnCreateDefaultCombo) then
      FOnCreateDefaultCombo(self, FCombo);
end;

procedure TwwDataInspector.DoCreateDateTimePicker(ADateTimePicker: TwwDBCustomDateTimePicker);
begin
   if Assigned(FOnCreateDateTimePicker) then
      FOnCreateDateTimePicker(self, FDateTimePicker);
end;

function TwwDataInspector.CreateDateTimePicker: TwwDBCustomDateTimePicker;
begin
   result:= TwwDBDateTimePicker.create(self);
end;


function TwwDataInspector.CreateDefaultCombo: TwwDBComboBox;
begin
   result:= TwwInspectorComboBox.create(self);
end;

function TwwDataInspector.GetDateTimePicker: TwwDBCustomDateTimePicker;
begin
   if FDateTimePicker=nil then
   begin
      FDateTimePicker:= CreateDateTimePicker;
      DoCreateDateTimePicker(FDateTimePicker);
   end;
   Result:= FDateTimePicker;
end;

procedure TwwDataInspector.WMSize(var Message: TWMSize);
var NewBoundsRect: TRect;
begin
  inherited;
  UpdateDataColumnWidth;

  NewboundsRect:= Rect(0, 0, BoundsRect.right-BoundsRect.left, BoundsRect.bottom-BoundsRect.top);
  if SameRect(OldBoundsRect, NewBoundsRect) then exit;
  OldboundsRect:= NewBoundsRect;
  PaintOptions.InitBlendBitmapsFlag:= True;

//  if not SameRect(ClientRect, OldClientRect) then
//     InitBlendBitmaps;
//  OldClientRect:= ClientRect;
end;

procedure TwwDataInspector.Notification(AComponent: TComponent;
  Operation: TOperation);
var i: integer;

  procedure ClearCustomControl(Item: TwwInspectorItem);
  var i: Integer;
  begin
     if Item.CustomControl=AComponent then
        Item.CustomControl:= nil;
     for i:= 0 to Item.Items.Count-1 do
        ClearCustomControl(Item.Items[i]);
  end;

begin
  inherited Notification(AComponent, Operation);
  if csDestroying in ComponentState then exit;
  if (Operation = opRemove) then
  begin
     for i:= 0 to Items.count-1 do
        ClearCustomControl(Items[i]);
  end
end;

procedure TwwDataInspector.SetDesigner(Value: TControl);
begin
  FDesigner := Value;
end;

procedure TwwDataInspector.SetCaptionIndent(val: integer);
begin
   if FCaptionIndent<>val then
   begin
      FCaptionIndent:= val;
      invalidate;
   end;
end;

procedure TwwDataInspector.WMKillFocus(var Message: TMessage);
begin
   inherited;
end;

procedure TwwDataInspector.WMSetFocus(var Msg: TWMSetFocus);
var Obj: TwwInspectorItem;
begin
//  if (Col=0) and (ColCount>1) then Col:= 1;
  inherited;
  if SkipSetFocus then exit;  // 6/13/01 - Don't move focus to inplaceeditor during its recreatewnd

  if not UseDefaultEditor then begin
      SkipUpdateEditText:=True;  // 6/13/02 - Just Receiving focus, so updating obj.EditText is not correct
      HideEditor;
      SkipUpdateEditText:=False;
  end
  else begin
     ShowEditor;
     InplaceEditor.SelectAll;
  end;

   if (not SkipUpdateCustomControlInFocus) and (CurrentCustomEdit=nil) then
   begin
      UpdateCustomEdit;

      // 6/13/02 - Make sure custom edit is updated when inspector receives focus
      Obj:= ActiveItem;
      if (CurrentCustomEdit<>nil) and (Obj<>nil) and
         ((obj.datafield='') or (obj.datasource=nil)) then
      begin
         if (CurrentCustomEdit.HandleAllocated) and
           (CurrentCustomEdit is TCustomEdit) then
            TEdit(CurrentCustomEdit).Text:= obj.EditText;
      end;

      if CurrentCustomEdit<>nil then begin
        CurrentCustomEdit.visible:=True;
        UpdateCustomEditPaint(CurrentCustomEdit);
//        CurrentCustomEdit.Update;
        CurrentCustomEditSetFocus;
      end
   end;

//   if KeyHook=0 then
//      KeyHook := SetWindowsHookEx(WH_KEYBOARD, @wwHookKeyProc, HINSTANCE, GetCurrentThreadID);


//  invalidate; { Takes care of problem of notepad in front }
end;

procedure TwwDataInspector.Click;
//var obj: TwwInspectorItem;
begin
   inherited;

   { 11/2/99 - Editor is being shown but it shouldn't be, so hide it }
   if (not useDefaultEditor) and
      ((inplaceEditor<>nil) and inplaceEditor.focused) then
      HideEditor;

{   obj:= GetItemByRow(Row);
   if obj=nil then exit;
   if InplaceEditor=nil then exit;}
end;

procedure TwwDataInspector.IterateItems(
    CallBack: TwwInspectorItemCallback;
    ExpandedOnly: boolean; UserData: Pointer);
var i: Integer;
    continue: boolean;
  procedure Scan(Item: TwwInspectorItem);
  var i: Integer;
  begin
     CallBack(Item, UserData, continue);
     if not continue then exit;

     if not ExpandedOnly or (Item.Expanded and Item.Visible) then
     begin
        for i:= 0 to Item.Items.Count-1 do
           Scan(Item.Items[i]);
     end;
  end;
begin
   continue:= true;
   for i:= 0 to Items.count-1 do
   begin
      Scan(Items[i]);
      if not continue then exit;
   end
end;
{
procedure TwwInspectorPaintOptions.SetAlternateRowCaptionColors(Value: Boolean);
begin
   if Value<>AlternateRowCaptionColors then
   begin
      FAlternateRowCaptionColors:= Value;
      Inspector.InitBlendBitmapsFlag:=True;
      Inspector.Invalidate;
   end
end;

procedure TwwInspectorPaintOptions.SetAlternateRowDataColors(Value: Boolean);
begin
   if Value<>AlternateRowDataColors then
   begin
      FAlternateRowDataColors:= Value;
      Inspector.InitBlendBitmapsFlag:=True;
      Inspector.Invalidate;
   end
end;
}
procedure TwwDataInspector.SetOptions(Value: TwwDataInspectorOptions);
const
  LayoutOptions = [{ovWordWrap, }ovHighlightActiveRow,
                   ovCenterCaptionVert, ovShowTreelines,
                   ovHideCaptionColumn];
var
  NewGridOptions: TGridOptions;
  ChangedOptions: TwwDataInspectorOptions;
begin
  if FOptions <> Value then
  begin
    NewGridOptions := [goEditing, goAlwaysShowEditor, goThumbTracking];
    if ovRowResize in Value then
      NewGridOptions := NewGridOptions + [goRowSizing];
    if ovColumnResize in Value then
      NewGridOptions := NewGridOptions + [goColSizing, goColMoving];
    if not (ovTabExits in Value) then Include(NewGridOptions, goTabs);
    inherited Options := NewGridOptions;
    ChangedOptions := (FOptions + Value) - (FOptions * Value);
{    if (ovWordWrap in Value) <> (ovWordWrap in FOptions) then
    begin
       if (InplaceEditor<>Nil) then
	  (InplaceEditor as TwwDataInspectorEdit).WordWrap:= (ovWordWrap in Value);
    end;}
    FOptions := Value;
    if ovHideCaptionColumn in LayoutOptions then
    begin
       if (ovHideCaptionColumn in FOptions) and (ColCount=2) then
          ColWidths[0]:= 0
       else
          ColWidths[0]:= CaptionWidth;
       if HandleAllocated then UpdateDataColumnWidth;
    end;
    if ChangedOptions * LayoutOptions <> [] then invalidate; //LayoutChanged;
  end;


end;

procedure TwwDataInspector.RowHeightsChanged;
begin
  inherited;
  if LastDefaultRowHeight<>inherited DefaultRowHeight then
  begin
     ApplySettings;
  end;
  LastDefaultRowHeight:= inherited DefaultRowHeight;
end;

procedure TwwDataInspector.SetDefaultRowHeight(Value: integer);
begin
   FDefaultRowHeight:= Value;
   if FDefaultRowHeight=0 then begin
      ApplySettings;
   end
   else begin
      inherited DefaultRowHeight:= DefaultRowHeight;
   end
end;

procedure TwwDataInspector.SetCaptionFont(Value: TFont);
begin
  FCaptionFont.Assign(Value);
  Invalidate;
end;

procedure TwwDataInspector.CaptionFontChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TwwDataInspector.InvalidateRow(ARow: integer);
begin
   InvalidateRowCol(ARow, -1);
end;

procedure TwwDataInspector.InvalidateRowCol(ARow: integer; ACol: integer = -1);
var
  InvalidRect: TRect;
begin
  if not HandleAllocated then Exit;
  if ACol=-1 then
  begin
    InvalidRect:= BoxRect(0, ARow, ColCount, ARow);
    InvalidRect.Top:= InvalidRect.Top -2;
    InvalidRect.Bottom:= InvalidRect.Bottom + 1;
    InvalidRect.Left:= InvalidRect.Left - 1;
    InvalidRect.Right:=ClientWidth;  // Not accurate when ColWidths[0] is 0 so let us overwrite value
    Windows.InvalidateRect(Handle, @InvalidRect, False);
  end
  else begin
    InvalidRect:= BoxRect(ACol, ARow, ACol+1, ARow);
    InvalidRect.Top:= InvalidRect.Top -2;
    InvalidRect.Bottom:= InvalidRect.Bottom + 1;
    InvalidRect.Left:= InvalidRect.Left - 1;
    Windows.InvalidateRect(Handle, @InvalidRect, False);
  end;
end;

procedure TwwDataInspectorEdit.WMPaint(var Message: TWMPaint);
  procedure CanvasNeeded;
  begin
    if FCanvas = nil then
    begin
      FCanvas := TControlCanvas.Create;
      FCanvas.Control := Self;
    end;
  end;
begin
   if csPaintCopy in ControlState then
   begin
      message.result:=1;
      exit;
//      DrawCell(Col, Row);
{      CanvasNeeded;
      DC := Message.DC;
      if IsInGridPaint(self.parent) and (message.dc<>0) then
         tc:= GetTextColor(message.dc);
      if DC = 0 then DC := BeginPaint(Handle, PS);
      FCanvas.Handle := DC;
      try
         Focused := GetFocus = Handle;
         FCanvas.Font := Font;
         with FCanvas do
         begin
            ARect := ClientRect;
            else if IsInGridPaint(self) and (message.dc<>0) then

//      inherited;
//      message.result:=1;
}
   end
   else inherited;
end;

procedure TwwDataInspectorEdit.CMExit(var Message: TMessage);
begin
{   try
     ParentGrid.FDataLink.UpdateData;
   except
     SetFocus;
     raise;
   end;
}
   inherited;
//   ParentGrid.invalidateRow(ParentGrid.Row);
end;

procedure TwwDataInspector.FlushContents;
var obj: TwwInspectorItem;
begin
      obj:= GetItemByRow(Row);
      if obj<>nil then begin
         if CurrentCustomEdit<>nil then
         begin
            if CurrentCustomedit is TwwDBComboBox then
               obj.EditText:= TwwDBComboBox(CurrentCustomEdit).Value
            else
               obj.EditText:= TEdit(CurrentCustomEdit).Text;

            if TEdit(CurrentCustomEdit).modified then
               obj.DoItemTextChanged;
         end
         else begin
            if (InplaceEditor<>nil) and Inplaceeditor.modified then
            begin
                obj.DoItemTextChanged;
                InplaceEditor.modified:= false; { 3/11/00 - Clear modified }
            end
         end;
      end;
      FDataLink.UpdateData;
end;

procedure TwwDataInspector.CMExit(var Message: TMessage);
//var obj: TwwInspectorItem;
begin
   if keyHook<>0 then
   begin
     UnhookWindowsHookEx(keyHook);
     keyHook:= 0;
   end;

   try
      FlushContents;
   except
     SetFocus;
     raise;
   end;

   inherited;

   FFocused:= False;
   invalidateRow(Row);
end;

function TwwDataInspector.InValidColSizingArea(x: integer): boolean;
begin
   result:= (X<=ColWidths[0]+3);
end;

procedure TwwDataInspector.WMSetCursor(var Msg: TWMSetCursor);
var
  DrawInfo: TGridDrawInfo;
  State: TGridState;
  Index: Longint;
  Pos, Ofs: Integer;
//  Cur: HCURSOR;
begin
//  Cur := 0;
  with Msg do
  begin
    if HitTest = HTCLIENT then
    begin
      if FGridState = gsNormal then
      begin
        CalcDrawInfo(DrawInfo);
        CalcSizingState(self.HitTest.X, self.HitTest.Y, State, Index, Pos, Ofs,
          DrawInfo);
      end else State := FGridState;

      if State = gsColSizing then
      begin
        if not InValidColSizingArea(self.HitTest.X) then
        begin
           exit;
        end
      end
    end;
  end;
  inherited;

end;

procedure TwwDataInspectorEdit.WMEraseBkgnd(var Message: TWmEraseBkgnd);
//var r: TRect;
begin
  if csPaintCopy in ControlState then begin
     Message.result:= 1;
  end
  // 8/1/02 - Theme - Otherwise lots of flicker when it gets the focus
  // 8/8/02 - Does not seem necessary anymore after latest beta build so
  // comment out awaiting further testing
{  else if false and ThemeServices.ThemesEnabled then
  begin
     r:= ClientRect;
     if FCanvas<>nil then
       Windows.FillRect(message.dc, r, FCanvas.brush.handle );
     message.result:=1
  end}
  else
    inherited;
end;

procedure TwwDataInspector.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if True or SkipErase then begin
     Message.result:= 1;
     exit;
  end
  else inherited;
end;

procedure TwwDataInspector.ToggleCheckbox(obj: TwwInspectorItem);
begin
   if not obj.Enabled then exit;

   if obj.field<>nil then
   begin
      if not CanEditModify then exit;
      if obj.field.text=obj.picklist.items[0] then
         obj.field.text:= obj.picklist.items[1]
      else
         obj.field.text:= obj.picklist.items[0];
      obj.EditText:= obj.field.text;


   end
   else begin
      if ReadOnly or obj.ReadOnly then exit;

      if obj.EditText=obj.picklist.items[0] then
         obj.EditText:= obj.picklist.items[1]
      else
         obj.EditText:= obj.picklist.items[0]
   end;

   obj.DoItemTextChanged;
//   if Assigned(obj.FItemChanged) then
//      obj.FItemChanged(self, obj, obj.EditText);
end;

procedure TwwDataInspector.WMChar(var Msg: TWMChar);
var obj: TwwInspectorItem;
begin
  if UseCheckbox(Row) then begin
     if (goEditing in inherited Options) and
        (Char(Msg.CharCode) = #32) then
     begin
        Obj:= GetItemByRow(Row);
        ToggleCheckbox(obj);
        InvalidateCell(1, Row);
     end
  end;
//  inherited;
end;

procedure TwwDataInspector.WMPaint(var Message: TWMPaint);
begin
//if csPaintCopy in ControlState then exit;
  windows.GetUpdateRect(Handle, UpdateRect, false);

  PaintCopyTextColor:= clNone;
  if IsInGridPaint(self) and (message.dc<>0) then
  begin
     PaintCopyTextColor:= GetTextColor(message.dc);
  end;

  inherited;
end;

procedure TwwDataInspector.SetLineStyleCaption(val: TwwDataInspectorLineStyle);
begin
   FLineStyleCaption:= val;
   invalidate;
end;

procedure TwwDataInspector.SetDottedLineColor(val: TColor);
begin
   FDottedLineColor:= val;
   invalidate;
end;

procedure TwwDataInspector.SetLineStyleData(val: TwwDataInspectorLineStyle);
begin
   FLineStyleData:= val;
   invalidate;
end;

{ TCustomGrid }
function PointInGridRect(Col, Row: Longint; const Rect: TGridRect): Boolean;
begin
  Result := (Col >= Rect.Left) and (Col <= Rect.Right) and (Row >= Rect.Top)
    and (Row <= Rect.Bottom);
end;


procedure TwwDataInspector.InheritedPaint;
type
  PIntArray = ^TIntArray;
  TIntArray = array[0..MaxCustomExtents] of Integer;
var
  DrawInfo: TGridDrawInfo;
  Sel: TGridRect;
  UpdateRect: TRect;
  FColOffset: integer;

  procedure DrawCells(ACol, ARow: Longint; StartX, StartY, StopX, StopY: Integer;
    Color: TColor; IncludeDrawState: TGridDrawState);
  var
    CurCol, CurRow: Longint;
    Where: TRect;
    DrawState: TGridDrawState;
//    Focused: Boolean;
  begin
    CurRow := ARow;
    Where.Top := StartY;
    while (Where.Top < StopY) and (CurRow < RowCount) do
    begin
      CurCol := ACol;
      Where.Left := StartX;
      Where.Bottom := Where.Top + RowHeights[CurRow];
      while (Where.Left < StopX) and (CurCol < ColCount) do
      begin
        Where.Right := Where.Left + ColWidths[CurCol];
        if (Where.Right > Where.Left) and
           RectVisible(Canvas.Handle, Where) then
        begin
          DrawState := IncludeDrawState;
//          Focused := IsActiveControl;
          if EffectiveFocused and (CurRow = Row) {and (CurCol = Col) } then
            Include(DrawState, gdFocused);
          if PointInGridRect(CurCol, CurRow, Sel) then
            Include(DrawState, gdSelected);
          if not ((gdFocused in DrawState) and (CurCol=Col)) or
            not (goEditing in inherited Options) or
            not EditorMode or (csDesigning in ComponentState) or
            (csPaintCopy in ControlState) then
          begin
            DrawCell(CurCol, CurRow, Where, DrawState);
          end;
        end;
        Where.Left := Where.Right + DrawInfo.Horz.EffectiveLineWidth;
        Inc(CurCol);
      end;
      Where.Top := Where.Bottom + DrawInfo.Vert.EffectiveLineWidth;
      Inc(CurRow);
    end;
  end;

begin
  if UseRightToLeftAlignment then ChangeOrientation(True);
  UpdateRect := Canvas.ClipRect;
  CalcDrawInfo(DrawInfo);
  with DrawInfo do
  begin
    { Draw the cells in the four areas }
    Sel := Selection;

    FColOffset:= 0;
    DrawCells(0, 0, 0, 0, Horz.FixedBoundary, Vert.FixedBoundary, IndicatorRow.Color,
      [gdFixed]);
    DrawCells(LeftCol, 0, Horz.FixedBoundary - FColOffset, 0, Horz.GridBoundary,  //!! clip
      Vert.FixedBoundary, FixedColor, [gdFixed]);
    DrawCells(0, TopRow, 0, Vert.FixedBoundary, Horz.FixedBoundary,
      Vert.GridBoundary, FixedColor, [gdFixed]);
    DrawCells(LeftCol, TopRow, Horz.FixedBoundary - FColOffset,                   //!! clip
      Vert.FixedBoundary, Horz.GridBoundary, Vert.GridBoundary, Color, []);

  end;

  if UseRightToLeftAlignment then ChangeOrientation(False);
end;

function TwwDataInspector.IsActiveControl: Boolean;
var
  H: Hwnd;
  ParentForm: TCustomForm;
begin
  Result := False;
  ParentForm := GetParentForm(Self);
  if Assigned(ParentForm) then
  begin
    if (ParentForm.ActiveControl = Self) then
      Result := True
  end
  else
  begin
    H := GetFocus;
    while IsWindow(H) and (Result = False) do
    begin
      if H = WindowHandle then
        Result := True
      else
        H := GetParent(H);
    end;
  end;
end;

procedure TwwDataInspector.ChangeOrientation(RightToLeftOrientation: Boolean);
var
  Org: TPoint;
  Ext: TPoint;
begin
  if RightToLeftOrientation then
  begin
    Org := Point(ClientWidth,0);
    Ext := Point(-1,1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X*ClientWidth, Ext.Y*ClientHeight, nil);
  end
  else
  begin
    Org := Point(0,0);
    Ext := Point(1,1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, ClientHeight, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X*ClientWidth, Ext.Y*ClientHeight, nil);
  end;
end;

procedure TwwDataInspector.BeginUpdate;
begin
  if not Showing then exit;
  if FUpdateCount = 0 then SetUpdateState(True);
  Inc(FUpdateCount);
end;

procedure TwwDataInspector.SetUpdateState(Updating: Boolean);
begin
  SendMessage(Handle, WM_SETREDRAW, Ord(not Updating), 0);
end;

procedure TwwDataInspector.EndUpdate(Repaint: boolean = False);
begin
  if not Showing then exit;
  if Repaint then InvalidateInEndUpdate:= True;

  if FUpdateCount>0 then Dec(FUpdateCount);
  if FUpdateCount = 0 then begin
     SetUpdateState(False);
     if InvalidateInEndUpdate then Invalidate;
     InvalidateInEndUpdate:= False;
  end
end;

{Function TwwDataInspector.ItemByFieldName(AFieldName: string): TwwInspectorItem;
begin
   result:= nil;
end;
}

procedure TwwInspectorButtonOptions.SetExpandGlyph(Value: TBitmap);
begin
  FExpandGlyph.Assign(Value);
  Control.Invalidate;
end;

procedure TwwInspectorButtonOptions.SetCollapseGlyph(Value: TBitmap);
begin
  FCollapseGlyph.Assign(Value);
  Control.Invalidate;
end;


constructor TwwInspectorButtonOptions.Create(AOwner: TComponent);
begin
   FExpandGlyph:= TBitmap.create;
   FCollapseGlyph:= TBitmap.create;
   Control:= AOwner as TWinControl;
end;

destructor TwwInspectorButtonOptions.Destroy;
begin
  FExpandGlyph.Free;
  FCollapseGlyph.Free;
  inherited Destroy;
end;

procedure TwwDataInspector.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    { Remove horizontal scrollbar }
    if DataColumns<=1 then
       if ScrollBars in [ssHorizontal, ssBoth] then Style := Style and not WS_HSCROLL;
  end;
end;

Procedure TwwDataInspector.SetActiveItem(obj: TwwInspectorItem);
var temprow: integer;
    parentobj: TwwInspectorItem;
    SomethingExpanded: boolean;
begin
   FActiveItem:= obj;

   if obj=nil then exit
   else begin
     { Need to expand parents if necessary }
     parentobj:= obj.parentItem;
     SomethingExpanded:=false;
     while parentobj<>nil do begin
        // 8/1/00 - Otherwise shift-tab causes vertical scrollbar to disappear.
        if (not parentobj.expanded) and (not SomethingExpanded) then begin
           Beginupdate;
           SomethingExpanded:=true;
        end;
        parentobj.expanded:= true;
        parentobj:= parentobj.parentItem;
     end;

     temprow:=GetRowByItem(obj);
     if temprow>=0 then begin
        SetFocusCell(Col, TempRow)
     end;
     if SomethingExpanded then Endupdate;
   end
end;

Function TwwDataInspector.GetActiveItem: TwwInspectorItem;
begin
   if FastDesign then begin
      result:= FActiveItem;
      if result=nil then result:= GetItemByRow(Row, False);
   end
   else
      result:= GetItemByRow(Row, False);
end;

procedure TwwDataInspector.Loaded;
begin
  inherited;
  ApplySettings;
  UseTempCanvas:= True;
  PaintOptions.InitBlendBitmaps;
  UseTempCanvas:= False;
end;

function TwwDataInspector.GetCaptionColor: TColor;
begin
   result:= FixedColor;
end;

procedure TwwDataInspector.SetCaptionColor(val: TColor);
begin
   FixedColor:= val;
   PaintOptions.Column1Color:= FixedColor;
   PaintOptions.InitBlendBitmapsFlag:=True;
   Invalidate;
end;

function TwwDataInspector.GetTreeLineColor: TColor;
begin
   result:= FTreeLineColor;
end;

procedure TwwDataInspector.SetTreeLineColor(val: TColor);
begin
   FTreeLineColor:= val;
end;

constructor TwwInspectorPickList.Create;
begin
   inherited;
   FItems:= TStringList.create;
   FShowMatchText:= True;
   FButtonStyle:= cbsDownArrow;
   FButtonGlyph := TBitmap.Create;
end;

destructor TwwInspectorPickList.Destroy;
begin
   FItems.Free;
   FButtonGlyph.Free;
   inherited Destroy;
end;

procedure TwwInspectorPickList.SetItems(val: TStrings);
begin
   FItems.assign(val);
end;

procedure TwwInspectorPickList.SetButtonGlyph(Value: TBitmap);
begin
  FButtonGlyph.Assign(Value);
end;

procedure TwwInspectorPickList.AssignTo(Dest: TPersistent);
begin
  with Dest as TwwInspectorPickList do
  begin
    Items.Assign(self.Items);
    MapList:= self.MapList;
    DisplayAsCheckbox:= self.DisplayAsCheckbox;
    Style:= self.Style;
    ShowMatchText:= self.ShowMatchText;
    AllowClearKey:= self.AllowClearKey;
    ButtonStyle:= self.ButtonStyle;
    ButtonGlyph.Assign(self.ButtonGlyph);
    ButtonWidth:= self.ButtonWidth;
  end;
end;

function TwwInspectorItem.HaveItems: boolean;
begin
   result:= FItems.count>0;
end;

type
  TwwInspectorFieldDataLink = class(TFieldDataLink)
  protected
    procedure DataSetChanged; override;
  public
    InspectorItem: TwwInspectorItem;
  end;

procedure TwwInspectorFieldDataLink.DataSetChanged;
begin
   inherited;

   { 2/10/2000 - Updates inplaceeditor for this row - Only do if this is the active item}
   if (InspectorItem.Control is TwwDataInspector) then begin
      if InspectorItem = (InspectorItem.Control as TwwDataInspector).ActiveItem then
      begin
         with (InspectorItem.Control as TwwDataInspector) do
         begin
            ChildDataChanged:= True;
            Datalink.DataSetChanged;
            ChildDataChanged:= False;
         end
      end
   end

end;

constructor TwwInspectorItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FEnabled:= True;
  FAlignment:= taLeftJustify;
  FWordWrap:= False; {12/11/99 - Default of true was wrong }
  FCustomControlAlwaysPaints:= True;
  FItems:= TwwInspectorCollection.Create(TwwInspectorCollection(Collection).Control);
  FItems.FParentItem:= self;
  FParentItem:= TwwInspectorCollection(Collection).ParentItem;
  FPickList:= TwwInspectorPickList.create;
  FPicture:= TwwDBPicture.create(nil);
  FVisible:= True;
  FResizeable:= false;
  FOptions:= [iioAutoDateTimePicker];
   FTabStop:= True;

  FDataLink := TwwInspectorFieldDataLink.Create;
  TwwInspectorFieldDataLink(FDataLink).InspectorItem:= self;
  FDataLink.Control:= TwwInspectorCollection(Collection).Control;
  if Control is TwwDataInspector then begin
     FDataLink.onDataChange:= (FDataLink.Control as TwwDataInspector).EditDataLinkDataChange;
     FDataLink.onUpdateData:= (FDataLink.Control as TwwDataInspector).EditDataLinkUpdateData;
     TwwDataInspector(Control).CheckRowCount:= True;
  end;
end;

procedure TwwDataInspector.EditDataLinkDataChange(Sender: TObject);
begin
//   TwwDataInspectorDataLink(FDatalink).DataSetChanged;
   invalidate;
end;

procedure TwwDataInspector.EditDataLinkUpdateData(Sender: TObject);
begin
   TwwDataInspectorDataLink(FDatalink).UpdateData;
end;

destructor TwwInspectorItem.Destroy;
begin
   if not (csDestroying in Control.ComponentState) and
      (csDesigning in Control.ComponentState) and
      (CustomControl<>nil) then
   begin
      CustomControl:=nil; // make custom control visible for design-time manipulation
   end;

   FItems.Free;
   FPickList.Free;
   FPicture.Free;
{   if UseDefaultLookupComboBox then
   begin
      if (CustomControl is TwwDBLookupCombo) and (CustomControl<>nil) then
      begin
         CustomControl.Free;
         CustomControl:= nil;
      end
   end;
}
   if not (csDestroying in Control.ComponentState) and
     (Control is TwwDataInspector) then
   begin
     TwwDataInspector(Control).CheckRowCount:= True;
     TwwDataInspector(Control).Invalidate;
   end;
   FDataLink.Free;
   FDataLink := nil;
   inherited Destroy;
end;

function TwwInspectorItem.GetLevel: integer;
var level: integer;
    tempParent: TwwInspectorItem;
begin
   tempParent:= ParentItem;
   level:= 0;
   while tempParent<>nil do
   begin
       tempParent:= tempParent.ParentItem;
       level:= level + 1;
   end;

   result:= level;

end;

procedure TwwInspectorItem.SetCustomControl(val: TWinControl);
begin
   if val=Control then exit;

   if (FCustomControlName<>val) then
   begin
      if (val=nil) then
      begin
         FCustomControlName.ControlStyle:=
            FCustomControlName.ControlStyle - [csNoDesignVisible];
         FCustomControlname.parent:= GetParentForm(FCustomControlName);
      end
      else begin
         val.ControlStyle:=
            val.ControlStyle + [csNoDesignVisible];
         val.visible:= false; { 9/27/99 }

         // Following sets datasource/datafield to valid problem
         // where change record before control is visible causes
         // wrong value to be remembered by contorl such as month calendar
         if (GetDataSource<>nil) then // 12/19/01 - Not necessary for unbound
                                      // Can cause streaming to be overwritten in some cases if InitCustomEidt called
            TwwDataInspector(Control).InitCustomEdit(val, self);
      end;

      FCustomControlName:= val;
   end;
   if (TwwInspectorCollection(Collection).UpdateCount=0) and
     (Control is TwwDataInspector) then
   begin
     TwwDataInspector(Control).Update;
     TwwDataInspector(Control).Invalidate; //RefreshItem(self);
     TwwDataInspector(Control).Update;
   end
end;

Function TwwInspectorItem.GetField: TField;
begin
   if (DataSource<>nil) and (DataSource.dataset<>nil) then
      result:= DataSource.DataSet.FindField(DataField)
   else result:= nil;
end;

Function TwwInspectorItem.GetControl: TComponent;
begin
   Result:= TwwInspectorCollection(Collection).Control;
end;

procedure TwwInspectorItem.SetCellHeight(const Value: integer);
begin
   if FCellHeight<>Value then
   begin
     FCellHeight:= Value;
     if Control is TwwDataInspector then
        TwwDataInspector(Control).RefreshItem(self)
   end
end;

procedure TwwInspectorItem.SetVisible(val: boolean);
begin
   if FVisible<>val then
   begin
      FVisible:= val;
      if Control is TwwDataInspector then
        TwwDataInspector(Control).ApplySettings
   end
end;

procedure TwwInspectorItem.SetExpanded(val: boolean);
var inspector: TwwDataInspector;
begin
   if FExpanded<>val then
   begin
      FExpanded:= val;
      if Control is TwwDataInspector then
      begin
        inspector:= TwwDataInspector(Control);
        Inspector.ApplySettings;
      end
   end
end;

procedure TwwInspectorItem.SetCaption(const Value: string);
begin
   FCaption:= Value;
   if GetDesigner<>nil then begin
      GetDesigner.Update;
      if Control is TwwDataInspector then
         TWinControl(Control).Invalidate;
   end
end;

function TwwInspectorItem.GetDataLink: TDataLink;
begin
  result:= FDataLink;
  if (FDataLink<>Nil) and (FDataLink.DataSource=nil) then begin
     if Control is TwwDataInspector then
        result:= TwwDataInspector(Control).DataLink
  end;
end;

function TwwInspectorItem.GetDataSource: TDataSource;
begin
  result := nil;
  if (FDataLink<>Nil) then
     Result := FDataLink.DataSource;
  if result=nil then begin
     if Control is TwwDataInspector then
        result:= TwwDataInspector(Control).DataSource;
  end
end;

procedure TwwInspectorItem.SetDataSource(Value: TDataSource);
begin
   if Control is TwwDataInspector then
   begin
      if Value<>TwwDataInspector(Control).DataSource then
         FDataLink.DataSource := Value
      else
         FDataLink.DataSource:= nil;
   end
   else
      FDataLink.DataSource:= Value;
end;

function TwwInspectorItem.GetDataField: string;
begin
   if FDataLink.DataSource<>nil then
      Result := FDataLink.FieldName
   else
      Result:= FDataField
end;

procedure TwwInspectorItem.SetDataField(const Value: string);
begin
//  if not (csDesigning in ComponentState) then
//    ResetMaxLength(Self);
//   if FDataLink.DataSource<>nil then
      FDataLink.FieldName := Value;
//   else
      FDataField:= Value
end;


procedure TwwInspectorItem.Assign(Source: TPersistent);
begin
  if Source is TwwInspectorItem then
  begin
    EditText:= TwwInspectorItem(Source).EditText;
    Caption:= TwwInspectorItem(Source).Caption;
    CellHeight:= TwwInspectorItem(Source).CellHeight;
    ReadOnly:= TwwInspectorItem(Source).ReadOnly;
    CustomControl:= TwwInspectorItem(Source).CustomControl;
    DataField:= TwwInspectorItem(Source).DataField;
    Resizeable:= TwwInspectorItem(Source).Resizeable;
    Visible:= TwwInspectorItem(Source).visible;
    Tag:= TwwInspectorItem(Source).tag;
    TagString:= TwwInspectorItem(Source).TagString;
    Expanded:= TwwInspectorItem(Source).Expanded;
    if TwwInspectorItem(Source).Items.count>0 then
       Items.Assign(TwwInspectorItem(Source).Items);
    PickList.assign(TwwInspectorItem(Source).PickList);
    Exit;
  end;
  inherited Assign(Source);
end;

function TwwInspectorItem.GetNamePath: string;
var tempName: string;
    tempItem: TwwInspectorItem;
begin
   result:= inherited GetNamePath;
   tempName:= '';
   tempItem:= self;
   repeat
     tempName:= 'Items[' + inttostr(tempItem.index)+ ']' + tempName;
     tempItem:= tempItem.parentItem;
   until tempItem=nil;
   tempName:= Control.name + '.' + tempName;
   result:= tempName;
end;

function TwwInspectorItem.GetDisplayName: string;
var TempText: string;
begin
  if Caption = '' then TempText:= '<InspectorItem>'
  else TempText:= Caption;
  Result := inttostr(Index) + ' - ' + TempText;
end;

function TwwInspectorItem.GetPrior(
      VisibleItemsOnly: boolean = True;
      ExpandedOnly: boolean = False): TwwInspectorItem;
var NextItem, LastChild: TwwInspectorItem;
begin
   nextItem:= GetPriorSibling(VisibleItemsOnly);
   if nextItem<>nil then
   begin
      lastChild:= nextItem.GetLastChild(VisibleItemsOnly, ExpandedOnly);
      if lastChild=nil then result:= nextItem
      else result:= lastChild;
      exit;
   end;

   Result:= ParentItem;
end;

function TwwInspectorItem.GetFirstChild(
   VisibleItemsOnly: boolean = True;
   ExpandedOnly: boolean = False): TwwInspectorItem;
var i: integer;
begin
   result:= nil;
   if ExpandedOnly and (not expanded) then exit;

   for i:= 0 to Items.count-1 do begin
      if (not visibleItemsOnly) or TwwInspectorItem(Items[i]).visible then begin
         result:= TwwInspectorItem(Items[i]);
         break;
      end
   end;
end;

function TwwInspectorItem.GetLastChild(
   VisibleItemsOnly: boolean = True;
   ExpandedOnly: boolean = False): TwwInspectorItem;
var i: integer;
begin
   result:= nil;
   if ExpandedOnly and (not expanded) then exit;

   for i:= Items.count-1 downto 0 do begin
      if (not visibleItemsOnly) or TwwInspectorItem(Items[i]).visible then begin
         result:= TwwInspectorItem(Items[i]);
         break;
      end
   end;
end;

function TwwInspectorItem.GetNext(
      VisibleItemsOnly: boolean = True;
      ExpandedOnly: boolean = False): TwwInspectorItem;
var NextItem, CurItem: TwwInspectorItem;
begin
   nextItem:= GetFirstChild(VisibleItemsOnly, ExpandedOnly);

   if nextItem<>nil then
   begin
      result:= nextItem;
      exit;
   end;

   nextItem:= GetNextSibling(VisibleItemsOnly);
   curItem:= self;

   while (nextItem = nil) and (curItem<>nil) do
   begin
       curItem:= curItem.ParentItem;
       if curItem<>nil then nextItem:= curItem.GetNextSibling(VisibleItemsOnly)
   end;
   Result := nextItem;
end;

function TwwInspectorItem.GetNextSibling(VisibleItemsOnly: boolean = True): TwwInspectorItem;
var i: integer;
begin
   result:= nil;
   for i:= index+1 to Collection.count-1 do begin
      if (not VisibleItemsOnly) or TwwInspectorItem(Collection.Items[i]).visible then begin
         result:= TwwInspectorItem(collection.Items[i]);
         break;
      end
   end;
end;

function TwwInspectorItem.GetPriorSibling(VisibleItemsOnly: boolean = True): TwwInspectorItem;
var i: Integer;
begin
   result:= nil;
   for i:= index-1 downto 0 do begin
      if (not VisibleItemsOnly) or TwwInspectorItem(Collection.Items[i]).visible then begin
         result:= TwwInspectorItem(collection.Items[i]);
         break;
      end
   end;
end;

constructor TwwInspectorCollection.Create(Control: TComponent);
begin
  inherited Create(TwwInspectorItem);
  self.Control:= Control;
end;

destructor TwwInspectorCollection.Destroy;
begin
   inherited Destroy;
end;

function TwwInspectorCollection.Insert(index: integer): TwwInspectorItem;
begin
  Result := TwwInspectorItem(inherited Insert(index));
end;

function TwwInspectorCollection.Add: TwwInspectorItem;
begin
  Result := TwwInspectorItem(inherited Add);
end;

function TwwInspectorCollection.GetItem(Index: Integer): TwwInspectorItem;
begin
  Result := TwwInspectorItem(inherited GetItem(Index));
end;

function TwwInspectorCollection.GetOwner: TPersistent;
begin
  Result := Control;
end;

procedure TwwInspectorCollection.SetItem(Index: Integer; Value: TwwInspectorItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TwwInspectorCollection.Update(Item: TCollectionItem);
begin
end;

procedure TwwInspectorItem.SetItems(Value: TwwInspectorCollection);
begin
  FItems.Assign(Value);
end;

Function TwwInspectorItem.GetDesigner: TControl;
begin
   result:= nil;
   if Control is TwwDataInspector then
      result:= TwwDataInspector(TwwInspectorCollection(Collection).Control).Designer;
end;

procedure TwwInspectorItem.DefineProperties(Filer: TFiler);
begin
//  Filer.DefineProperty('ItemsTest', ReadItems, WriteItems, HaveItems);
  inherited DefineProperties(Filer);
end;
{
procedure TwwDataInspector.Click;
begin
   inherited Click;
end;
}
procedure TwwDataInspector.CMEnter(var Message: TCMEnter);
var IndicatorOffset: integer;
begin
  inherited;
  FFocused:= True;
  if IndicatorRow.enabled then IndicatorOffset:=1
  else IndicatorOffset:=0;

  if SetFocusTabStyle = itsResetActiveItem then begin
     Row:= IndicatorOffset; // 09/04/01 - Set row to 1st not-fixed row
  end;
  InvalidateRow(Row);

  if KeyHook=0 then
     KeyHook := SetWindowsHookEx(WH_KEYBOARD, @wwHookKeyProc, HINSTANCE, GetCurrentThreadID);

end;

type
  TwwCollectionStreamComponent=class(Tcomponent)
  private
     FItems: TwwInspectorCollection;
  public
     constructor Create(AOwner: TComponent); override;
     destructor Destroy; override;
  published
     property Items: TwwInspectorCollection read FItems write FItems;
  end;

  constructor TwwCollectionStreamComponent.create(AOwner: TComponent);
  begin
     inherited Create(AOwner);
     FItems:= TwwInspectorCollection.create(self);
  end;

  destructor TwwCollectionStreamComponent.Destroy;
  begin
     FItems.Free;
     inherited Destroy;
  end;

procedure TwwInspectorCollection.SaveToStream(s: TStream);
var tempC: TwwCollectionStreamComponent;
begin
  tempC:= TwwCollectionStreamComponent.create(Control);
  with tempC do begin
     Items.assign((Control as TwwDataInspector).Items);
     s.WriteComponent(tempC);
     free;
  end;
end;

procedure TwwInspectorCollection.LoadFromStream(s: TStream);
var tempC: TwwCollectionStreamComponent;
begin
  if (Control is TwwDataInspector) then
     TwwDataInspector(Control).HideEditor;
  tempC:= TwwCollectionStreamComponent.create(Control);
  with tempC do begin
     s.ReadComponent(tempC);
     (Control as TwwDataInspector).Items.assign(items);
     free;
  end;
end;

procedure TwwInspectorCollection.SaveToFile(const FileName: string);
var Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TwwInspectorCollection.LoadFromFile(const FileName: string);
var Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

function TwwDataInspector.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
   SendMessage(Handle, wm_vscroll, sb_linedown, 0);
   result:= true;
end;

function TwwDataInspector.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  SendMessage(Handle, wm_vscroll, sb_lineup, 0);
  result := True;
end;

procedure TwwDataInspector.FirstTimePaint;
begin
end;

    // 1/22/00 - Add support for ActionLists (PYW)
function TwwDataInspector.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TwwDataInspector.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

{procedure TwwDataInspector.RefreshCustomControl;
begin
   DirtyCustomInfo:= True;
   Invalidate;
end;
}
procedure TwwDataInspector.WMLButtonDown(var Message: TWMLButtonDown);
begin
//  LastActiveControl:= Screen.ActiveControl;
  inherited;


end;

procedure TwwDataInspector.WMHScroll(var Message: TWMHScroll);
  procedure NextRow;
  begin
    with FDatalink.Dataset do
    begin
      if (State = dsInsert) and not Modified and not FDatalink.FModified then
	if EOF then Exit else Cancel
      else begin
	 { Already pointing to end of table but active record is before this. 10/15/96 - dsInsert should not increment}
	 if Eof and (FDataLink.ActiveRecord>=0) and  { IP2 - Used to be >0, now >=0 }
	     (FDataLink.ActiveRecord<FDataLink.RecordCount-1) and not (State=dsInsert) then
	    FDataLink.ActiveRecord:= FDataLink.ActiveRecord + 1
	 else begin
            Next;
         end
      end;
    end;
  end;

  procedure PriorRow;
  begin
    with FDatalink.Dataset do
      if (State = dsInsert) and not Modified and EOF and
	not FDatalink.FModified then
	Cancel
      else begin
	if BOF and (FDataLink.ActiveRecord>0) then
	   FDataLink.ActiveRecord:= FDataLink.ActiveRecord - 1
	else Prior;
      end
  end;

  Function Sequencable: boolean;
  begin
     result:= FDataLink.DataSet.isSequenced;
  end;

  procedure ParadoxPosition;
  var SI: TScrollInfo;
  begin
     with FDataLink.DataSet do begin
        { Support proportional scrollbar }
        SI.cbSize := sizeof(SI);
        SI.fMask := SIF_ALL;
        GetScrollInfo(Self.Handle, SB_VERT, SI);
        CheckBrowseMode;
        if SI.nTrackPos <= 1 then First
        else if SI.nTrackPos >= RecordCount then Last
        else RecNo := SI.nTrackPos;
        Resync([]);
     end;
  end;

begin
  if Message.ScrollBar=0 then   // Ignore scrolling message from scrollbar/trackbar control
  begin
     if not AcquireFocus then Exit;
     if FDatalink.Active then
       with Message, FDataLink.DataSet, FDatalink do
         case ScrollCode of
            SB_LINEUP: PriorRow;
            SB_LINEDOWN: NextRow;
            SB_PAGEUP: MoveBy(-(VisibleColCount-1));
            SB_PAGEDOWN: MoveBy(VisibleColCount-1);
            SB_THUMBPOSITION:
             begin
	         if Sequencable then begin
                    ParadoxPosition;
                 end
                 else begin
                    case Pos of
                       0: First;
                       1: MoveBy(-VisibleColCount);
                       2: exit;
                       3: MoveBy(VisibleColCount);
                       4: Last;
                    end;
                 end
             end;

            SB_BOTTOM: Last;
            SB_TOP: First;
         end;
//     inherited
  end
  else
     message.result:=0;
end;

procedure TwwDataInspector.UpdateScrollBar;
var
  sequencable: boolean;
  SIOld, SINew: TScrollInfo;
begin
  if not (ScrollBars in [ssHorizontal, ssBoth]) then exit;

  //2/1/2001 - Add check to see if dataset is active as well. (PYW)
  if FDatalink.Active and FDataLink.Dataset.Active and HandleAllocated then
  begin
    { Set scroll bar precisely }
    sequencable:= FDataLink.DataSet.isSequenced;
    if sequencable then FDataLink.DataSet.UpdateCursorPos;

    { Support proportional scrollbar }
    SIOld.cbSize := sizeof(SIOld);
    SIOld.fMask := SIF_ALL;
    GetScrollInfo(Self.Handle, SB_HORZ, SIOld);
    SINew := SIOld;

    if sequencable then with FDataLink.DataSet do
    begin
       SINew.nMin := 1;
       SINew.nPage := Self.VisibleRowCount;
       SINew.nMax := Integer(DWORD(RecordCount) + SINew.nPage - 1);
       if State in [dsInactive, dsBrowse, dsEdit] then
          SINew.nPos := RecNo;  // else keep old pos
    end
    else begin
       SINew.nMin := 0;
       SINew.nPage := 0;
       SINew.nMax := 4;
       if FDataLink.BOF then SINew.nPos := 0
       else if FDataLink.EOF then SINew.nPos := 4
       else SINew.nPos := 2;
    end;

    if (SINew.nMin <> SIOld.nMin) or (SINew.nMax <> SIOld.nMax) or
       (SINew.nPage <> SIOld.nPage) or (SINew.nPos <> SIOld.nPos) then
    begin
       SINew.fMask:= SIF_ALL;
       // SIF_DisableNoScroll does not seem to work reliably so do not
       // use it. Instead just make scrollbar thumb as large as the scrollbar
       // so there is nothing to scroll.
       if SINew.nMax-SINew.nMin<=1 {SINew.nPage} then begin
          SINew.nPage:= 1000;
          SINew.nMax:= 1001;
          SINew.nMin:= 1;
//          SINew.fMask:= SIF_ALL or SIF_DISABLENOSCROLL;
       end;
       SetScrollInfo(Self.Handle, SB_HORZ, SINew, True);
    end
  end;

end;

procedure TwwDataInspector.SetScrollBars(Value: TScrollStyle);
begin
  if FScrollBars <> Value then
  begin
    FScrollBars := Value;
    if FScrollBars in [ssVertical, ssBoth] then
       inherited ScrollBars:= ssVertical
    else
       inherited ScrollBars:= ssNone;
    RecreateWnd;
  end;
end;




procedure TwwDataInspector.SetDataColumns(val:integer);
begin
   if val<>FDataColumns then
   begin
     FDataColumns:= val;
     ColCount:= FDataColumns + 1;
     if (ColCount>1) and (Col=0) then Col:= 1;
     FDataLink.BufferCount:=val;
     UpdateDataColumnWidth;
   end;


end;


procedure TreeLine(Canvas: TCanvas; p1, p2: TPoint);
var i: integer;
    x, y: integer;
    tot: integer;
begin
  Canvas.Pen.Color:= clBlack;
  Canvas.PolyLine([p1, p2]);
  Canvas.Pen.Color:= clWhite;
  if (p1.y=p2.y) then
  begin
    p1.y:= p1.y+1;
    p2.y:= p2.y+1;
    p1.x:= p1.x+1;
  end
  else begin
    p1.x:= p1.x+1;
    p2.x:= p2.x+1;
  end;
  Canvas.PolyLine([p1, p2]);
  exit;
//  Refresh;
  x := p1.x;
  y := p1.y;
  tot := wwMax(Abs(p2.y - p1.y), Abs(p2.x - p1.x));
  for i := 0 to tot do if i mod 2 = 0 then
  begin
    Canvas.Polyline([Point(x,y), Point(x+1,y+1)]);
    inc(x, (p2.x - p1.x) div wwMax(1, (tot div 2)));
    inc(y, (p2.y - p1.y) div wwMax(1, (tot div 2)));
  end;
end;

Function TwwDataInspector.LevelRect(item: TwwInspectorItem): TRect;
var ARow: Integer;
begin
   result:= Rect(0, 0, 0, 0);
   ARow:= GetRowByItem(item);
   if ARow>=0 then
      result:= CellRect(0, ARow);
end;

procedure TwwDataInspector.PaintLines(item: TwwInspectorItem);
var LevelNode: TwwInspectorItem;
    LineStartX:integer;
    LineTop, LineBottom: TPoint;
    x, y:integer;
    r: TRect;
    pt: TPoint;

   Function GetTitleRect2: TRect;
   var TitleRect: TRect;
   begin
      TitleRect:= Rect(r.Left + (item.Level+1) * CaptionIndent, r.Top + 1,
                          r.Right, r.Bottom);
      result:= TitleRect;
   end;

   Function GetTitleRect(ARect: TRect): TRect;
   var TitleRect: TRect;
   begin
      TitleRect:= Rect(ARect.Left + (Item.Level+1) * CaptionIndent-1, ARect.Top + 1,
                          ARect.Right, ARect.Bottom);
      if Item.havevisibleitem then
         TitleRect.Left:= ButtonPt(ARect, Item).x - 7;
      result:= TitleRect;
   end;

    Function GetStartX(Item: TwwInspectorItem): integer;
//    const MaxCheckboxSize = 6;
    var r: TRect;
        pt: TPoint;
    begin
        result:= 0;
        r := LevelRect(Item);
        Item:= Item.ParentItem;
        if Item=nil then exit;
        if Item.HaveItems then
        begin
          pt:= ButtonPt(r, item);
          result:= pt.x-1;
        end;
    end;


begin
  r:= LevelRect(Item);
  if ovShowTreeLines in Options then
  begin
//    FPaintCanvas.Pen.Color := FLineColor; //clBtnShadow; { for line drawing }
    FPaintCanvas.Pen.Color := clBtnShadow; { for line drawing }
    FPaintCanvas.Pen.Color := clWhite; { for line drawing }
    LevelNode := Item;
    if Item.Expanded and Item.HaveVisibleItem then
    begin
       pt:= ButtonPt(r, item);
       LineTop:= Point(pt.x-1, pt.y+7);
       LineBottom:= Point(pt.x-1, r.bottom);
       TreeLine(FPaintCanvas, LineTop, LineBottom);
    end;

    while (LevelNode <> nil) and ((LevelNode.Level = 0) or (LevelNode.ParentItem <> nil)) do
    begin
      LineStartX:= GetStartX(LevelNode);
      LineTop:= Point(LineStartX, r.Top);
      LineBottom:= Point(LineStartX, r.Bottom);

      if LevelNode.Level = Item.Level then
      begin
       if (Item.GetPriorSibling = nil) and (Item.ParentItem = nil) then
          inc(LineTop.y, GetCenterPoint(r).y);
        if Item.GetNextSibling = nil then begin
          dec(LineBottom.y, wwRectHeight(r) div 2 - 1)
        end
      end;
      if (LevelNode.GetNextSibling <> nil) or (LevelNode.Level = Item.Level) then
         if LevelNode.Level>0 then //LineStartX>0 then
            TreeLine(FPaintCanvas, LineTop, LineBottom);
//        TreeLine(FPaintCanvas, Point(LineTop.x, r.bottom-1), Point(r.right, r.bottom-1));
//        TreeLine(FPaintCanvas,LineTop, LineBottom);
      LevelNode := LevelNode.ParentItem;
    end;

    // Horizontal line
    r := LevelRect(Item);
    if {(tvoShowRoot in Options) or }(Item.Level <> 0) then
    begin
      if ovCenterCaptionVert in Options then
         y:= GetCenterPoint(r).y
      else begin
         y  := ButtonPt(r, item).y;
      end;
      x:= GetStartX(Item);
      TreeLine(FPaintCanvas, Point(x, y), Point(GetTitleRect(r).Left, y));
{      TreeLine(FPaintCanvas, Point(2+GetTitleRect2.left+Canvas.TextWidth(item.caption), y),
               Point(r.right-8,y));
      TreeLine(FPaintCanvas, Point(r.right-8, ((r.Bottom+r.Top) div 2)-4),
                             Point(r.right-8, ((r.Bottom+r.Top) div 2)+4));
      TreeLine(FPaintCanvas, Point(r.right-8, ((r.Bottom+r.Top) div 2)-4),
                             Point(r.right-2, ((r.Bottom+r.Top) div 2)));
      TreeLine(FPaintCanvas, Point(r.right-2, ((r.Bottom+r.Top) div 2)),
                             Point(r.right-8, ((r.Bottom+r.Top) div 2)+4));
}
//      2+GetTitleRect2.left+Canvas.TextWidth(item.caption), y),
//               Point(r.right-4,y));

//      FPaintCanvas.Ellipse(Rect(r.right-6,r.Top,r.Right-2,r.bottom));

//      TreeLine(FPaintCanvas, Point(x, r.bottom-1), Point(r.right, r.bottom-1));
//      DottedLine(FPaintCanvas, Point(r.right-105, y), Point(r.right-2,y));
    end
  end;
end;

procedure TwwDataInspector.FreeHintWindow;
begin
   HintTimerCount:= 0;
   SkipErase:= True;
   HintWindow.Free;
   SkipErase:= False;
   HintWindow:= nil;
   if HintTimer<>nil then HintTimer.enabled:= False;
end;

Function TwwDataInspector.CreateHintWindow: THintWindow;
begin
   HintWindow:= TwwInspectorHintWindow.create(self);
   HintWindow.Color:= GetSysColor(COLOR_INFOBK);
   HintWindow.Canvas.Brush.Color:= GetSysColor(COLOR_INFOBK);
   HintWindow.Canvas.Font:= self.Font;
   HintWindow.Canvas.Font.Color:= GetSysColor(COLOR_INFOTEXT);
   HintWindow.Canvas.Pen.Color:= clBlack;
   result:= HintWindow;
end;

procedure TwwDataInspector.HintTimerEvent(Sender: TObject);
var
    sp, cp: TPoint;
    OutsideClient: boolean;
    cr: TRect;
    hintTimerInterval: integer;
begin
   if not (HintWindow<>nil) then exit;

   GetCursorPos(cp);

   sp:= self.ScreenToClient(cp);
   cr:= cellrect(lastmousex, lastmousey);
   inflaterect(cr, 1, 1);
   if not (ptinrect(cr, sp)) then begin
      FreeHintWindow;
      LastMouseX:= 0; LastMouseY:= 0;
      exit;
   end;

   sp:= self.ClientToScreen(Point(0, 0));

   if (cp.x<sp.x) or (cp.x>sp.x+ClientRect.Right-ClientRect.Left) or
      (cp.y<sp.y) or (cp.y>sp.y+ClientRect.Bottom-ClientRect.Top) then
   begin
      OutsideClient:= True;
   end
   else OutsideClient:= False;

   { Process Hint Timer clean-up}
   if OutsideClient then
   begin
      FreeHintWindow;
      LastMouseX:= 0; LastMouseY:= 0;
   end
   else begin
      inc(HintTimerCount);
      HintTimerInterval:= HintTimer.interval;
      if HintTimerCount>
         wwMax(Application.HintHidePause div HintTimerInterval, 16) then
      begin
         FreeHintWindow;
      end
   end

end;

function TwwDataInspector.RecordCountIsValid: boolean;
begin
  result:=
     (FDataLink<>nil) and
     FDatalink.Active and (FDataLink.DataSet<>nil) and
     FDataLink.Dataset.Active;
end;

procedure TwwDataInspector.HintMouseMove(Shift: TShiftState; X, Y: Integer);
var
    R: TRect;
    sp: TPoint;
    AHintText: string;
    drawrect: trect;
    drawflags: Integer;
    maxwidth, maxheight, hintwidth: Integer;
    DoDefault: boolean;
    VerticalFits, HorizontalFits: boolean;
    obj: TwwInspectorItem;
    oldDrawRect: TRect;
    OldActiveRecord: integer;
    OldMaxHeight: integer;

   Function GetTitleRect: TRect;
   var TitleRect: TRect;
       ARect: TRect;
   begin
      ARect:= CellRect(LastMouseX, LastMouseY);
      TitleRect:= Rect(ARect.Left + (Obj.Level+1) * CaptionIndent, ARect.Top + 1,
                          ARect.Right, ARect.Bottom);
      result:= TitleRect;
   end;

  function GetHintText: string;
  var AHintText: string;
  begin
     if (obj.field<>nil) then
     begin
        if obj.field is TBlobField then
        begin
           if obj.Field.dataType in [ftMemo, ftOraBlob, ftOraCLob] then
              AHintText:= obj.field.asstring;
        end
        else AHintText:= obj.Field.DisplayText
     end
     else AHintText:= obj.EditText;
     result:= AHintText;
  end;

begin
   if (ovShowCellHints in Options) and (csDesigning in ComponentState) then exit;
   with MouseCoord(x,y) do
   begin
      if not (ovShowCaptionHints in Options) and (x=0) then exit;
      if not (ovShowCellHints in Options) and (x>=1) then exit;
      if ((x<>lastMouseX) or (y<>lastMouseY)) then begin
         R:= CellRect(x,y);
         lastMouseX:= x;
         lastMouseY:= y;
         FreeHintWindow;
         HintTimer.Free;
         HintTimer:= nil;

         if (x=Col) and (y=Row) then begin
            if (InplaceEditor<>nil) and (InplaceEditor.visible) then exit;
            if (TcheatCast(self).currentcustomedit<>nil) and
               (TCheatCast(self).currentcustomedit.visible) then exit;
         end;
         obj:= GetItemByRow(Y);
         if obj=nil then exit;

         if obj.CustomControlAlwaysPaints and
            (obj.customcontrol<>nil) then exit;


         if x=0 then
            AHintText:= obj.Caption
         else begin
            if RecordCountIsValid and (x-1<FDataLink.RecordCount) then
            begin
               OldActiveRecord:= FDataLink.ActiveRecord;
               FDataLink.ActiveRecord:= x-1;
               AHintText:= GetHintText;
               FDataLink.ActiveRecord:= OldActiveRecord;
            end
            else AHintText:= GetHintText;
         end;
         if AHintText='' then exit;

         drawflags:= DT_NOPREFIX;
         if x=0 then
         begin
            drawRect := GetTitleRect;
            Canvas.Font.assign(CaptionFont); { 8/24/00 - Set default before calling calccellcolors}
         end
         else begin
            drawRect := Rect(0, 0, r.Right-r.left-4, 0);
            if obj.WordWrap then drawflags:= drawflags or DT_EDITCONTROL or DT_WORDBREAK;
            Canvas.Font.assign(Font); { 8/24/00 - Set default before calling calccellcolors}
         end;
         if pos(#9, AHintText)>0 then drawFlags:= drawFlags or DT_EXPANDTABS; // 9/7/00

         OldDrawRect:= drawRect;
         DrawTextEx(Canvas.Handle, PChar(AHintText),
                   Length(AHintText), drawrect, DrawFlags or DT_CALCRECT, nil);
         VerticalFits:= (drawrect.bottom-drawrect.top<=r.bottom-r.top);
         HorizontalFits:= (drawrect.Right-drawrect.Left<oldDrawRect.right-oldDrawRect.left-1);
//         HorizontalFits:= (drawrect.Right-drawrect.Left<r.right-r.left-1);
         if VerticalFits and HorizontalFits then exit;

         HintWindow:= CreateHintWindow;
         HintWindow.Canvas.Font.assign(Canvas.Font); { Default to current cell's font }
         HintTimer:= TTimer.create(self);
         HintTimer.OnTimer:=HintTimerEvent;
         HintTimer.Interval:=250;
         HintTimer.Enabled:= True;

         sp:= self.ClientToScreen(Point(0, 0));
         with TwwInspectorHintWindow(HintWindow) do
         begin
            DoDefault:= True;
            MaxHeight:= r.bottom-r.top-2;
            OldMaxHeight:= MaxHeight;
            MaxWidth:= Screen.Width;
            Caption:= AHintText; // 9/7/00

            WordWrap:= obj.WordWrap;
            CenterVertically := False;
            DoCreateHintWindow(TwwInspectorHintWindow(HintWindow),
                obj.Field,
                R, WordWrap,
                MaxWidth, MaxHeight, DoDefault);

//                  { 2/29/00 - subtract 4 to be consistent with above calculation }
//            MaxWidth := wwmax((r.right-r.left-4), MaxWidth);

            if not DoDefault then exit;

            R.bottom:= R.Bottom -2;

            drawflags:= DT_NOPREFIX;
            if x=0 then begin
               drawRect := GetTitleRect;
//               drawRect := Rect(0,0,MaxWidth,MaxHeight);
               if ovCenterCaptionVert in Options then
                  CenterVertically := True;
               Wordwrap := False;
            end
            else begin
               drawRect := Rect(0, 0, MaxWidth, MaxHeight);
//               drawRect := Rect(0, 0, r.Right-r.left-4, 0);
               if WordWrap then drawflags:= drawflags or DT_EDITCONTROL or DT_WORDBREAK;
            end;
            if pos(#9, AHintText)>0 then drawFlags:= drawFlags or DT_EXPANDTABS; // 9/7/00
            DrawTextEx(Canvas.Handle, PChar(AHintText),
                Length(AHintText), drawrect, DrawFlags or DT_CALCRECT, nil);
            hintwidth := drawrect.right-drawrect.left;
            if drawrect.right-drawrect.left>MaxWidth then drawrect.right:= MaxWidth;
            if drawrect.bottom-drawrect.top>Maxheight then drawrect.bottom:= MaxHeight;
            if (MaxHeight<>OldMaxHeight) then
               r.bottom:= wwmax(r.top + (drawrect.bottom-drawrect.top), r.bottom);

            if r.left + drawrect.right + 8<=MaxWidth then
               r.right:= r.Left + drawrect.right + 8
            else if MaxWidth<>0 then begin
               if r.left + DrawRect.right + 8 > Screen.Width then
                  r.left:= r.right - drawrect.right - 8
               else
                  r.right:= r.left + hintwidth + 8;
            end;
            if x=0 then
            begin
              R.Left:= drawRect.Left-2;
              R.Top:= drawRect.Top-1;//2;
            end;
            OffsetRect(R, sp.x-1, sp.y-2);
            ActivateHint(R, AHintText);
         end;
      end
   end
end;

procedure TwwDataInspector.DoCreateHintWindow(
  HintWindow: TwwInspectorHintWindow;
  AField: TField;
  R: TRect;
  var WordWrap: boolean;
  var MaxWidth, MaxHeight: integer;
  var DoDefault: boolean);
begin
  if Assigned(FOnCreateHintWindow) then
     FOnCreateHintWindow(self, HintWindow, AField, R, WordWrap,
        MaxWidth, MaxHeight, DoDefault);
end;

procedure TwwInspectorHintWindow.Paint;
var
  R: TRect;
  WriteOptions: TwwWriteTextOptions;
begin
  R := ClientRect;
  Inc(R.Left, 2);
  Inc(R.Top, 2);
  Canvas.Font.Color := clInfoText;

  if WordWrap then
     WriteOptions:= [wtoWordWrap]
  else WriteOptions:= [];

  if CenterVertically then
     WriteOptions:= WriteOptions + [wtoCenterVert];

  wwWriteTextLinesT(Canvas, R, 0, 0, PChar(Caption), Alignment,
    WriteOptions);
end;

procedure TwwDataInspector.EditingChanged;
begin
  if IndicatorRow.enabled then InvalidateCell(Col, 0);
end;

procedure TwwDataInspector.CreateWnd;
begin
  inherited CreateWnd;

  UpdateScrollBar;
end;


procedure TwwDataInspector.Scroll(Distance: Integer);
var ColWidth: integer;
    OldRect, NewRect: TRect;
begin
  if not HandleAllocated then Exit;  { 6/2/97}

  OldRect := BoxRect(Col, 0, Col, RowCount-1);
  if FDataLink.Active then
  begin
     if NewMouseRow >=0 then
       SetFocusCell(FDataLink.ActiveRecord+1, NewMouseRow)
     else
       SetFocusCell(FDataLink.ActiveRecord+1, Row);
  end;

  UpdateScrollBar;
  UpdateActive; // 7/23/02

  NewRect := BoxRect(Col, 0, Col, RowCount-1);
  ValidateRect(Handle, @OldRect);
//  if ovHideVertDataLines in Options then
  begin
    OldRect.Right:= OldRect.Right+1;
    OldRect.Left:= OldRect.Left-1;
    NewRect.Right:= NewRect.Right+1;
    NewRect.Left:= NewRect.Left-1;
  end;
  InvalidateRect(Handle, @OldRect, False);
  InvalidateRect(Handle, @NewRect, False);

  if (Distance <> 0) and (ColCount>2) then
  begin
    try
      if (Abs(Distance) > VisibleColCount) or (not PaintOptions.FastRecordScrolling) then
      begin
	Invalidate;
	Exit;
      end
      else
      begin
	ColWidth := ColWidths[1];
        NewRect:= BoxRect(1, 0, ColCount-1, RowCount-1);
        ScrollWindowEx(Handle, -ColWidth * Distance, 0, @NewRect, @NewRect,
          0, nil, SW_Invalidate);
      end;
    finally
    end;
  end;

  if activeitem<>nil then
     if (activeitem.datasource=datasource) or ChildDataChanged then
     begin
        SkipSetFocus:= True;
        try
           InvalidateEditor;
        finally
           SkipSetFocus:= False;
        end
     end
end;

function TwwDataInspector.GetClientRect: TRect;
begin
   result:= inherited GetClientRect;
//   result.bottom := result.bottom - 16;
end;

procedure Register;
begin
  RegisterComponents('IP Controls', [TwwDataInspector]);
end;
{
procedure TwwDataInspector.SetIndicatorCaption(val: string);
begin
   FIndicatorCaption:= val;
   if ovShowIndicatorRow in Options then InvalidateCell(0, 0);
end;
}

procedure TwwDataInspector.SetFixedDataRows(Value: integer);
var IndicatorOffset: integer;
begin
  FFixedDataRows:= Value;
  if IndicatorRow.enabled then IndicatorOffset:=1
  else IndicatorOffset:=0;
  RowCount:= wwmax(Value+IndicatorOffset, RowCount);
  FixedRows:= Value;
end;

procedure TwwDataInspector.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

Function TwwDataInspector.EffectiveFocused: boolean;
begin
   result:= FFocused and not (csPaintCopy in ControlState)
end;

procedure TwwDataInspectorDataLink.FocusControl(Field: TFieldRef);
begin
  if Assigned(Field) and Assigned(Field^) then
  begin
     FObjectView.ActiveItem:= FObjectView.GetItemByFieldName(Field^.FieldName);
     if FObjectView.ActiveItem<>nil then
     begin
       if (FObjectView.ActiveItem.field = Field^) and FObjectView.AcquireFocus then
       begin
          Field^ := nil;
       end;
     end
  end;
end;

//1/21/02
Procedure TwwDataInspector.DoCalcCustomEdit(Item: TwwInspectorItem;
   CustomEdit: TWinControl;
   var AllowCustomEdit: boolean);
begin
   if Assigned(FOnCalcCustomEdit) then
      FOnCalcCustomEdit(self, Item, CustomEdit, AllowCustomEdit);
end;

procedure TwwDataInspector.CMMouseLeave(var Message: TMessage);
begin
  if wwUseThemes(self) then begin
     InvalidateCell(LastMouseCoord.x, LastMouseCoord.y);
  end;
  inherited;
end;

procedure TwwDataInspector.CMMouseEnter(var Message: TMessage);
var pt: TPoint;
    coord: TGridCoord;
begin
  if wwUseThemes(self) then begin
     GetCursorPos(pt);
     pt:= self.ScreenToClient(pt);
     coord:= MouseCoord(pt.x,pt.y);

     if coord.x=Col then // Only do for active record
       InvalidateCell(coord.x, coord.y);
  end;
  inherited;
end;

procedure TwwDataInspector.CurrentCustomEditSetfocus;
begin
   if CurrentCustomEdit<>nil then
   begin
      if CurrentCustomEdit.enabled then
         CurrentCustomEdit.SetFocus;
   end
end;


end.

