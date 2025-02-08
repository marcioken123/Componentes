{
//
// Components : TwwDBCustomGrid
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
//
//  7/10/97 - Unselect all only if left button is clicked - Allows popupmenu to work.
//  7/10/97 - Support bitmaps with lookup fields - Only 1 field lookups supported
//  7/18/97 - Call hidecontrols in Layoutchanged so displayed embedded control
//            does not remain visible when column order is changed.
//  7/23/97 - Display bitmaps even in insert mode if lookup bitmap
//  7/31/97 - Don't use displaylabel property when useTFields=False
//  8/12/97 - Checkmark checkboxes optimized to use DisplayBitmap canvas
//  8/12/97 - Clear selLength when handling mask in keypress event.  This fixes
//            a bug which updated the text incorrectly.
//  10/15/97- Save and restore pen color later to allow column-moving line to be
//            drawn correctly
//  10/15/97- Allow resize even if titlebuttons is True
//  11/2/97 - Added to take care of wordwrap bug in memos displayed in grid
//  12/8/97 - Use ScrollWindowEx so background isn't cleared before painting
//  12/11/97 - Insert in front instead of switching columns
//  12/15/97 - Paint indicator button now so blank space isn't displayed too long
//  12/21/97 - Use goColMoving instead of dgColumnResize.  Developer can
//             then progmatically set goColMoving to False, while leaving the
//             column sizing as True.  This allows the developer a way of
//             removing the column dragging vertical bar.
//  1/28/98 -  Clear multi-select last record
//  2/4/98 -   Don't call OnCheckValue if character is not accepted
//  2/9/98 -   Only depress currently clicked column
//  3/30/98 -  Support ampersands in titles
//  3/30/98 -  Support imagelist to display bitmaps
//  3/31/98 -  If CenterJustify then allow DrawText to properly center text
//  3/31/98 -  Check to see if this is a single line edit control to
//               determine if we should or should not have word breaks
//  4/28/98 - IsMemoField uses ftMemo
//  5/13/98 - Fix memory leak for ShiftSelectBookmark
//  8/24/98 - Support Delphi 4 ActionLists
//  8/24/98 - Don't allow insert/edit if no records and dgallowinsert is false
//  9/2/98 -  Fixed 2 digit year bug in method UpdateData
//  9/2/98 -  FieldChanged event not fired in some cases.  This problem
//            is corrected by using UpdateData instead when using the
//            default inplaceeditor.  Also previous call to FieldChanged
//            is only called when a customedit is attached.
// 9/2/98 -   Fix bug where footer is not cleared when maximizing grid with
//            no records.
// 9/15/98 - Test for GoFoward when going back to previous row
// 9/21/98 - Make DoCalcTitleImage virtual for Delphi 4
// 9/22/98 - Don't call inherited if fail to set focus as this would
             lead to OnValidate getting called twice
// 9/24/98 - Prevent recursion in OnFieldChanged event by comparing text
// 10/2/98 - Allow editing if editing in CanEditModify
// 10/12/98 - Avoid converting 4 digit years to prevent 1900 from converting to 2000
// 10/26/98 - Truncate to character boundary in SetColumnAttributes.  Prevents problem
//            of column changing size when sizing another column.
// 10/28/98 - Subtract -4 from ColWidths in SetColumnAttributes.  Also undo change made on
//            10/26/98
// 11/11/98 - Invisible grid problem when width=0
// 11/24/98 - Check for nil curbookmark in DoCheckRowChanged
// 12/4/98  - Fix problem when descenders cutoff when dgRowLines=False.  Indirectly
//            fixes problem with lookupcombos with this problem.
// 12/7/98 - Correct OnColWidthChanged event passing the wrong column
// 12/9/98 - Just call RequestAlign in CMShowingChanged
// 1/8/99 - Fix descendor cutoff problem when wordwrap is true
// 1/31/99 - Support OnRowChanged for insert
// 2/17/99 - If append in grid, custom controls were not automatically moved to new row
// 2/17/99 - Added MouseWheel support by overriding virtual methods DoMouseWheelUp and DoMouseWheelDown (Delphi 4 Only)
// 2/21/99 - RSW, Don't highlight if fixed row multi-select cell
// 3/30/99 - Only include Insert if the dataset is not empty
// 4/21/99 - Free ShiftSelectBookmark first to fix memory leak.
// 4/28/99 - Fix problem where fixed column didn't fire event after drag operation
// 6/11/99 - Make sure adding never subtracting
// 1/13/2000 - Updated to use UseRightToLeftAlignment instead to test for Bidi mode
// 2/21/2000 - Fix bug introduced by Delphi 5 Patch 1 -
//             Need to make sure this code is not executed for lookupcombo
// 2/29/00 - subtract 4 to be consistent with above calculation
// 5/2/00 - Add method to clear last bookmark values
// 6/8/00 - Don't need to change grid layout when setting color
// 6/29/00 - PYW - Compute hint position correctly in different screen resolutions
//                 like 800x600 and when setting MaxLength in event.
// 7/2/2000 - Check for nil Screen.ActiveControl
// 9/7/00 - Expand tabs when computing hint window size
// 7/26/01 - Added code to handle abort in OnDrawDataCell event to prevent default customcontrol painting. - PYW
// 7/26/01 - Make sure datalink is active if showing hints. -PYW
// 8/8/2001- PYW - Make sure Datalink is active before going to next or prior record with mouse wheel.
// 9/24/2001 - If UseTFields is True, then have column return the fields displaywidth. -PYW
// 9/27/2001 - OnKeyUp not firing for tab or return key.
// 10/01/2001 - Don't allow setting smaller than defaultrowheight. -PYW
// 11/30/2001 - Made isMemoField virtual method.
// 12/12/01 - Set rowcount to 1+FTitleOffset if recordcount is not valid
// 12/21/01 - Fix hint not showing bug
// 1/4/02 - Don't paint data columns to the left of data area.
// 1/9/2002 - Call raise when patch variable set to allow messages from onvalidate to fire when focus exits grid.
// 1/21/02 - Fix left/right column scrolling problem where it didn't exit column when inplaceeditor being used (RSW)
// 2/11/2002 - Need to place in a begin/end block as following code only applies to above case -PYW
// 2/13/2002 - Don't call InitBlendBitmaps if no background bitmap loaded.
// 2/20/2002-PYW-When displaying bitmap take into account colline and rowlines.
// 3/3/2002-PYW-Don't showeditor if this is the right mouse button.
// 3/18/2002 - Make sure top line is drawn.
// 4/4/2002 -PYW- Check if Scrollbar has moved.  If so, then need to call DoTopROwChanged.
// 4/9/2002 -PYW - Preserve Cursor before URLPaint
// 5/9/2002 - PYW - Need to handle exception or hook raises it and it closes form.
// 6/17/02 - Allow transparent image when using alternating colors in grid
// 7/16/02 - Fixed bug where 1st horintal line in fixed column for 1st row
//           was previously missing when dgTitles was false
}
unit Wwdbigrd;

{$R-}

{$i wwIfDef.pas}

interface

uses SysUtils, Windows, Messages, Classes, Controls, Forms,
     Graphics, Menus, StdCtrls, DB, DBTables, Grids, DBCtrls,
     wwTable, wwStr, wwdbedit, wwtypes, buttons, wwlocate, wwsystem, extctrls,
     wwriched, wwdbdatetimepicker, wwpaintoptions;


//const icBlack = clBlack;
//      icYellow = clYellow;
type
  TwwCustomDBGrid = class;

  TwwEditControlOption = (ecoCheckboxSingleClick, ecoSearchOwnerForm,
                          ecoDisableCustomControls, ecoDisableDateTimePicker,
                          ecoDisableEditorIfReadOnly);
  TwwEditControlOptions = set of TwwEditControlOption;

  TwwGridHintWindow=class(THintWindow)
  private
  protected
     procedure Paint; override;
  public
     Field: TField;
     WordWrap: boolean;
     Alignment: TAlignment;
  end;

  TwwTitleImageAttributes = record
     ImageIndex: integer;
     Alignment: TAlignment;
     Margin: integer;
     IsGroupHeader: boolean;
  end;

  TTitleButtonClickEvent =
     procedure (Sender: TObject; AFieldName: string) of object;
  TCalcCellColorsEvent =
     procedure (Sender: TObject; Field: TField; State: TGridDrawState;
		Highlight: boolean; AFont: TFont; ABrush: TBrush) of object;
  TCalcTitleAttributesEvent =
     procedure (Sender: TObject; AFieldName: string; AFont: TFont; ABrush: TBrush;
		var ATitleAlignment: TAlignment) of object;

  TwwDrawTitleCellEvent =
      procedure (Sender: TObject; Canvas: TCanvas;
       Field: TField; Rect: TRect; var DefaultDrawing: boolean) of object;

  TwwDrawGroupHeaderCellEvent =
      procedure (Sender: TObject; Canvas: TCanvas;
        GroupHeaderName: string;
        Rect: TRect; var DefaultDrawing: boolean) of object;

  TwwCalcTitleImageEvent =
      procedure (Sender: TObject; Field: TField;
         var TitleImageAttributes: TwwTitleImageAttributes) of object;

  TDrawFooterCellEvent =
     procedure (Sender : TObject; Canvas: TCanvas; FooterCellRect: TRect;
                Field: TField;
                FooterText: string; var DefaultDrawing: boolean) of object;

  TColWidthChangedEvent =
     procedure (Sender: TObject; Column: integer) of object;

  TAllowColResizeEvent =
     procedure (Sender: TObject; Column: integer; var Accept:Boolean) of object;

  TwwLeftColChangedEvent =
     procedure (Sender: TObject; NewLeftCol: integer) of object;

  TwwCreateGridHintWindowEvent =
    procedure (Sender: TObject;
      HintWindow: TwwGridHintWindow;
      AField: TField; R: TRect;
      var WordWrap: boolean;
      var MaxWidth, MaxHeight: integer;
      var DoDefault: boolean) of object;

  TwwMultiSelectOption = (msoAutoUnselect, msoShiftSelect);
  TwwMultiSelectOptions = set of TwwMultiSelectOption;
  TwwFieldChangedEvent =
      procedure (Sender: TObject; Field: TField) of object;

  TwwGridDataLink = class(TDataLink)
  private
    FGrid: TwwCustomDBGrid;
    FFieldCount: Integer;
    FFieldMapSize: Integer;
    FModified: Boolean;
    FInUpdateData: Boolean;
    FFieldMap: Pointer;
    function GetDefaultFields: Boolean;
    function GetFields(I: Integer): TField;
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
    constructor Create(AGrid: TwwCustomDBGrid);
    destructor Destroy; override;
    function AddMapping(const FieldName: string): Boolean;
    procedure ClearMapping;
    procedure Modified;
    procedure Reset;
    property DefaultFields: Boolean read GetDefaultFields;
    property FieldCount: Integer read FFieldCount;
    property Fields[I: Integer]: TField read GetFields;
    property isFieldModified : boolean read FModified;
  end;

  TwwDBGridOption = (dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator,
    dgColumnResize, dgColLines, dgRowLines,
    dgTabs, dgRowSelect, {dgRowSelectEditable,}
    dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit,
    dgWordWrap, dgPerfectRowFit, dgMultiSelect, dgShowFooter, dgFooter3DCells,
    dgNoLimitColSize,  dgTrailingEllipsis, dgShowCellHint, dgTabExitsOnLastCol,
    dgFixedResizable, dgFixedEditable, dgProportionalColResize, dgRowResize,
    dgRowLinesDisableFixed, dgColLinesDisableFixed, dgFixedProportionalResize,
    dgHideBottomDataLine, dgDblClickColSizing);
  TwwDBGridOptions = set of TwwDBGridOption;
  TwwDBGridKeyOption = (dgEnterToTab, dgAllowDelete, dgAllowInsert);
  TwwDBGridKeyOptions = set of TwwDBGridKeyOption;
  TwwDrawDataCellEvent = procedure (Sender: TObject; const Rect: TRect; Field: TField;
    State: TGridDrawState) of object;

  TwwCustomDrawGridCellInfo = class
    Rect: TRect;
    Field: TField;
    State: TGridDrawState;
    DataCol, DataRow: integer;
    DefaultDrawBackground: boolean;
    DefaultDrawHorzTopLine: boolean;
    DefaultDrawHorzBottomLine: boolean;
    DefaultDrawContents: boolean;
  end;

  TwwCustomDrawCellEvent = procedure (
    Sender: TwwCustomDBGrid;
    DrawCellInfo: TwwCustomDrawGridCellInfo) of object;

  TIndicatorColorType = (icBlack, icYellow);
//  TIndicatorColorType = TColor;
  TwwBitmapSizeType = (bsOriginalSize, bsStretchToFit, bsFitHeight, bsFitWidth);
//  TwwWriteTextOption = (wtoAmpersandToUnderline, wtoEllipsis, wtoWordWrap, wtoMergeCanvas);
//  TwwWriteTextOptions = Set of TwwWriteTextOption;

  TwwIButton=class(TSpeedButton)
  public
     procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
     procedure Loaded; override;
     procedure Paint; override;
  end;

  TwwInplaceEdit = class(TInplaceEdit)
    private
      FwwPicture: TwwDBPicture;
      FWordWrap: boolean;
      ParentGrid: TwwCustomDBGrid;
      FUsePictureMask: boolean;

      procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
      procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
      procedure WMPaste(var Message: TMessage); message WM_PASTE;  {10/28/96 }

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

  TwwColumn = class
  private
//     FReadOnly: boolean;
//     FDisplayLabel: string;
//     FDisplayWidth: integer;

     FFieldName: string;
     Grid: TwwCustomDBGrid;
     FFooterValue: string;
     FGroupName: string;
     FDisableSizing: boolean;
     function GetReadOnly: boolean;
     function GetDisplayLabel: string;
     function GetDisplayWidth: integer;
     function GetGroupName: string;
     procedure SetReadOnly(val: boolean);
     procedure SetDisplayLabel(val: string);
     procedure SetDisplayWidth(val: integer);
     procedure SetFooterValue(val: string);
     procedure SetGroupName(val: string);
  public
     ColumnFlags: PByteArray; //array[0..255] of byte;  // Support max 256 rows for line groupings
     property FieldName: string read FFieldName;
     property ReadOnly : boolean read GetReadOnly write SetReadOnly;
     property DisplayLabel: string read GetDisplayLabel write SetDisplayLabel;
     property DisplayWidth: integer read GetDisplayWidth write SetDisplayWidth;
     property FooterValue: string read FFooterValue write SetFooterValue;
     property GroupName: string read GetGroupName write SetGroupName;
     property DisableSizing: boolean read FDisableSizing write FDisableSizing;
     constructor Create(AOwner: TComponent; AFieldName: string);
     destructor Destroy; override;
  end;

  TwwGridURLOpenEvent = procedure(
     Sender : TObject; var URLLink: string; Field: TField;
     var UseDefault: boolean) of object;
  TwwPadColumnStyle = (pcsPlain, pcsPadHeader, pcsPadHeaderAndData);

  TwwCacheColInfoItem = class
    CustomControl: TWinControl;
    ControlType: string;
    ControlData: string;
    AlwaysPaints: boolean;
    IsWhiteBackground: boolean;
//    PaintedBrushColor: TColor;
  end;
  TwwGridLineStyle= (glsSingle, gls3D, glsDynamic);

  TwwGridLineColors = class(TPersistent)
  private
     FDataColor: TColor;
     FHighlightColor: TColor;
     FShadowColor: TColor;
     FFixedColor: TColor;
  published
     property DataColor: TColor read FDataColor write FDataColor default clSilver;
     property HighlightColor: TColor read FHighlightColor write FHighlightColor default clBtnHighlight;
     property ShadowColor: TColor read FShadowColor write FShadowColor default clBtnShadow;
     property FixedColor: TColor read FFixedColor write FFixedColor default clBlack;
  end;

  TwwCustomDBGrid = class(TCustomGrid)
  private
    FShowHorzScrollBar: boolean;
    FOnBeforePaint: TNotifyEvent;
    FSelected : TStrings;
    FLineColors: TwwGridLineColors;
//    FDataLineColor:TColor;
    FTitleFont: TFont;
    FTitleColor: TColor;
    FFooterColor: TColor;
    FFooterCellColor: TColor;
    FFooterHeight: integer;
    FReadOnly: Boolean;
    FUserChange: Boolean;
//    FDataChanged: Boolean;
//    FEditRequest: Boolean;
    FUpdatingColWidths: integer;
    FOptions: TwwDBGridOptions;
    FKeyOptions: TwwDBGridKeyOptions;
    FTitleOffset: Byte;
    FUpdateLock: Byte;
    FInColExit: Boolean;
    FDefaultDrawing: Boolean;
    FSelfChangingTitleFont: Boolean;
    FSelRow: Integer;
    FDataLink: TwwGridDataLink;
//    FVDataLink: TwwGridDataLink;
    FOnColEnter: TNotifyEvent;
    FOnColExit: TNotifyEvent;
    FOnDrawDataCell: TwwDrawDataCellEvent;
    FOnCalcCellColors: TCalcCellColorsEvent;
    FOnCalcTitleAttributes: TCalcTitleAttributesEvent;
    FOnDrawTitleCell: TwwDrawTitleCellEvent;
    FOnDrawGroupHeaderCell: TwwDrawGroupHeaderCellEvent;
    FOnCalcTitleImage: TwwCalcTitleImageEvent;
    FOnTitleButtonClick: TTitleButtonClickEvent;
    FOnCheckValue: TwwValidateEvent;
    FOnTopRowChanged: TNotifyEvent;
    FOnRowChanged: TNotifyEvent;
    FOnCellChanged: TNotifyEvent;
    FOnLeftColChanged: TwwLeftColChangedEvent;
    FEditText: string;
    FIndicatorColor: TIndicatorColorType;
    FIndicatorIconColor: TColor;
    FTitleAlignment: TAlignment;
    FRowHeightPercent: Integer;
    FTitleLines: integer;
    FShowVertScrollBar: boolean;
    FOnColumnMoved: TMovedEvent;
    FOnColWidthChanged: TColWidthChangedEvent;
    FOnAllowColResize: TAllowColResizeEvent;
    FTitleButtons: boolean;
    FEditCalculated : boolean;
    FUseTFields: boolean;
    FIndicatorWidth: integer;
    FIndicatorButton: TwwIButton;
    FImageList: TImageList;
    FTitleImageList: TImageList;
    FOnDrawFooterCell: TDrawFooterCellEvent;
    FOnFieldChanged: TwwFieldChangedEvent;
    FOnUpdateFooter: TNotifyEvent;
    FOnCreateHintWindow: TwwCreateGridHintWindowEvent;
    FOnURLOpen: TwwGridURLOpenEvent;
//    FOnValidationErrorUsingMask: TwwPictureValidationError;
    FSavePrevGridWidth:Integer;
    FHideAllLines: boolean;
    FSavedCursor:TCursor; // 4/9/2002 -PYW - Preserve Cursor before URLPaint    

    URLLinkActiveRow: integer;
    URLLinkActiveCol: integer;
    InUpdateRowCount: boolean;
    FCalcCellRow, FCalcCellCol: integer;
    isWhiteBackground: boolean;
    isDrawFocusRect: boolean;
    SkipLineDrawing: boolean;
    TitleClickColumn: integer;
    TitleClickRow: integer;
    TitleClickGroupTitle:Boolean;    // PYW - Added to determine if the enduser clicked on the TitleGroup button or the Title SubGroup Buttons.
    MouseOverGroupTitle: boolean;

    FMultiSelectOptions: TwwMultiSelectOptions;
    DisableCellChangedEvent: boolean;
    ColItems: TList;

    { Suport drag/drop of titles }
    UseDragCanvas: boolean;
    CaptureTitleBitmap: TBitmap;
    FDragVertOffset: integer;
    SkipTitleButtonClick: boolean;

    FControlType: TStrings;
    FControlInfoInDataset: boolean;
    FPictureMasks: TStrings;
    FPictureMaskFromDataSet: boolean;
    CallColEnter: Boolean;
    LastBookmark, LastMasterBookmark: TBookmark;
    TempLastCol: integer; { Used when dataset is made active to fire ColEnter only once}
    ShouldUpdateFooter: boolean;
    DummyColumn: TwwColumn;

    lastMouseX, lastMouseY: integer;
    titleLastMouseX, titleLastMouseY: integer;
    HintTimer: TTimer;
    HintTimerCount: integer;
    FUpdateCount: Integer;
    FPadColumnStyle: TwwPadColumnStyle;
    FPaintCanvas: TCanvas;
    FPaintBitmap: TBitmap;
//    Membitmap: HBitmap;
//    UseTempCanvas: boolean;
    FEditControlOptions: TwwEditControlOptions;
    FPaintOptions: TwwGridPaintOptions;
    UpdateRect: TRect;
    ChangedBrushColor: boolean;
    AlternatingEven: boolean;
    FSizingIndex:Integer;
    FPriorSizingWidth: integer;
    FRowOffset: integer;
    FLineStyle: TwwGridLineStyle;

    ClickedOnGroupName:boolean;
    ClickedOnGroupChild:boolean;
    FCompareBookmarksAltMethod: boolean;
    FOnBeforeDrawCell: TwwCustomDrawCellEvent;
    FOnAfterDrawCell: TwwCustomDrawCellEvent;

    function CalcCoordFromPoint(X, Y: Integer;
      const DrawInfo: TGridDrawInfo): TGridCoord;
    procedure SetRowOffset(value: integer);
//    FFocused: boolean;

    procedure SetUseTFields(Val: boolean);
    Function GetPictureControl: TComponent;
    procedure HintTimerEvent(Sender: TObject);
    procedure MouseLoop_DragColumn(HitTest: Integer; X, Y: Integer);
    Function IsScrollBarVisible: boolean;
    function AcquireFocus: Boolean;
    procedure EditingChanged;
//    function Edit: Boolean;
    function GetDataSource: TDataSource;
    function GetFieldCount: Integer;
    function GetFields(Index: Integer): TField;
    function GetSelectedField: TField;
    function GetSelectedIndex: Integer;
    procedure RecordChanged(Field: TField);
    procedure FieldChanged(Field: TField);
    procedure SetDataSource(Value: TDataSource);
    procedure SetOptions(Value: TwwDBGridOptions);
    procedure SetSelectedField(Value: TField);
    procedure SetSelectedIndex(Value: Integer);
    procedure SetTitleFont(Value: TFont);
    procedure SetIndicatorIconColor(Value: TColor);
    procedure SetTitleAlignment(sel: TAlignment);
    procedure SetTitleLines(sel: integer);
    procedure SetRowHeightPercent(sel: Integer);
    Procedure SetShowVertScrollBar(val: boolean);
    Procedure SetTitleButtons(val: boolean);
    Function GetShowHorzScrollBar: Boolean;
    Procedure SetShowHorzScrollBar(val: boolean);
    function GetSelectedFields: TStrings;
    procedure SetSelectedFields(sel : TStrings);
{    Procedure SetWordWrap(val: boolean);}

    function GetColWidthsPixels(Index: Longint): Integer;  {4/23/97}
    procedure SetColWidthsPixels(Index: Longint; Value: Integer); {4/23/97}
    procedure SetIndicatorWidth(val: integer);

    procedure TitleFontChanged(Sender: TObject);
    procedure UpdateData;
    procedure UpdateActive;
    {$ifdef wwDelphi4Up}
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBkgnd;
    {$endif}
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMExit(var Message: TMessage); message CM_EXIT;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
    {$ifdef wwdelphi4up}
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    {$endif}
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    function GetColumn(Index: Integer): TwwColumn;
    procedure SetFooterColor(sel: TColor);
    procedure SetFooterCellColor(sel: TColor);
    procedure SetFooterHeight(val: integer);
//    function GetColumnByName(Index: string): TwwColumn;
    function GetCanvas: TCanvas;
    procedure SetPictureMasks(val: TStrings);
    procedure SetControlType(val: TStrings);
    procedure SetUpdateState(Updating: Boolean);
    procedure InheritedPaint;
    procedure SetIndicatorColor(Value: TIndicatorColorType);
    function GetCalcCellRow: integer;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
{    procedure ModifyScrollBar(ScrollBar, ScrollCode, Pos: Cardinal;
       UseRightToLeft: Boolean);
    function CalcMaxTopLeft(const Coord: TGridCoord;
      const DrawInfo: TGridDrawInfo): TGridCoord;
}
    function CalcMaxTopLeft(const Coord: TGridCoord;
     const DrawInfo: TGridDrawInfo): TGridCoord;
  protected
    FCacheColInfo: TList; //PwwCustomControlItem;
    FTopRecord: integer;
    FIndicatorOffset: Byte;
    TempRichEdit: TwwDBRichEdit;
    FUpdateFields: Boolean;
    FAcquireFocus: Boolean;
    SuppressShowEditor: boolean;
    ShiftSelectMode: boolean;
    ShiftSelectBookmark: TBookmark;
    dummy1, dummy2: string;
    TitleTextOffset: integer;
    FieldMappedText: boolean;
    URLLinkActive: boolean;
//    RichEditBufferList: TStrings;
    HintWindow: THintWindow;
    OrigColWidths: PWordArray;
    OrigColWidthsCount: integer;
    DrawCellInfo: TwwCustomDrawGridCellInfo;

    {$ifdef wwDelphi4Up}
    SkipErase: boolean;   { 1/26/99 - Prevent clearing of grid when hiding controls }
    {$endif}

    CurrentCustomEdit: TWinControl;
    FDateTimePicker: TwwDBCustomDateTimePicker;
    FFocused: boolean;

    function UseAlternateBuffering: boolean; virtual;
    function GetGridDataBottom(DrawInfo: TGridDrawInfo): integer; virtual;
    procedure ResetTitleClick;
    procedure UpdateLeftCol(ACol: integer);
    procedure ShowEditor; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MoveCol(ACol: Integer);
    procedure DoCreateHintWindow(
      HintWindow: TwwGridHintWindow;
      AField: TField; R: TRect;
      var WordWrap: boolean;
      var MaxWidth, MaxHeight: integer;
      var DoDefault: boolean); virtual;
    Function IsProportionalColumns: boolean; virtual;
//    procedure InitIndicators;
    procedure DoURLOpen(var URLLink: string; Field: TField; var UseDefault: boolean); virtual;
    Function IsDropDownGridFocused: boolean;
    Function IsDropDownGridShowing: boolean;
    procedure FillWithAlternatingRowBitmap(TempRect: TRect); virtual;
    procedure LayoutChanged; virtual;
    procedure CalcRowHeight; dynamic;
    function RecordCountIsValid: boolean;
//    function CalcVariableRowCount: integer; virtual;
    Function AllowCancelOnExit: boolean; dynamic;
    function CanEditAcceptKey(Key: Char): Boolean; override;
    function CanEditModify: Boolean; override;
    function GetEditLimit: Integer; override;
    procedure ColumnMoved(FromIndex, ToIndex: Longint); override;
    procedure ColEnter; dynamic;
    procedure ColExit; dynamic;
    procedure Scroll(Distance: Integer); virtual;
    procedure ColWidthsChanged; override;
    function HighlightCell(DataCol, DataRow: Integer; const Value: string;
      AState: TGridDrawState): Boolean; virtual;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    function GetEditMask(ACol, ARow: Longint): string; override;
    function GetEditText(ACol, ARow: Longint): string; override;
    procedure SetEditText(ACol, ARow: Longint; const Value: string); override;
    function GetColField(ACol: Integer): TField;
    function GetFieldValue(ACol: Integer): string; dynamic;
    procedure DefineFieldMap; virtual;
    procedure DrawDataCell(const Rect: TRect; Field: TField;
      State: TGridDrawState); dynamic;
    procedure ProportionalColWidths; virtual;
    procedure SetColumnAttributes; virtual;
    procedure KeyPress(var Key: Char); override;
    procedure LinkActive(Value: Boolean); virtual;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure TimedScroll(Direction: TGridScrollDirection); override;
    procedure CreateWnd; override;
    function IsWWControl(ACol, ARow: integer): boolean; virtual;
    procedure InvalidateTitle; virtual;

    property DefaultDrawing: Boolean read FDefaultDrawing write FDefaultDrawing default True;
    property DataSource: TDataSource read GetDataSource write SetDataSource; {W2W}
//    property VDataLink: TwwGridDataLink read FVDataLink;
    property ParentColor default False;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property TitleColor: TColor read FTitleColor write FTitleColor default clBtnFace;
//    property DataLineColor: TColor read FDataLineColor write FDataLineColor default clSilver;
    property FooterColor: TColor read FFooterColor write SetFooterColor default clBtnFace;
    property FooterCellColor: TColor read FFooterCellColor write SetFooterCellColor default clBtnFace;
    property FooterHeight: integer read FFooterHeight write SetFooterHeight default 0;
    property TitleFont: TFont read FTitleFont write SetTitleFont;
    property OnColEnter: TNotifyEvent read FOnColEnter write FOnColEnter;
    property OnColExit: TNotifyEvent read FOnColExit write FOnColExit;
    property OnDrawDataCell: TwwDrawDataCellEvent read FOnDrawDataCell write FOnDrawDataCell;
//    procedure DoCalcCellColors(Field: TField; State: TGridDrawState;
//	     highlight: boolean; AFont: TFont; ABrush: TBrush); virtual;
    procedure DoTitleButtonClick(AFieldName: string); virtual;
//    procedure DoCalcTitleAttributes(AFieldName: string; AFont: TFont; ABrush: TBrush;
//	     var FTitleAlignment: TAlignment); virtual;
    procedure DoDrawTitleCell(ACanvas: TCanvas;
       Field: TField; ARect: TRect; var DefaultDrawing: boolean); virtual;
    procedure DoDrawGroupHeaderCell(ACanvas: TCanvas;
       GroupHeaderName: string; ARect: TRect; var DefaultDrawing: boolean); virtual;
    procedure DoCalcTitleImage(Sender: TObject; Field: TField;
         var TitleImageAttributes: TwwTitleImageAttributes); {$ifdef wwdelphi4up} virtual; {$endif}

    {$ifdef wwDelphi4Up}
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    {$endif}

    function UseRightToLeftAlignmentForField(const AField: TField;
      Alignment: TAlignment): Boolean;
    procedure UpdateScrollBar;
    Function IsValidCell(ACol, ARow: integer): boolean;
    function DbCol(col: integer): integer;
    function DbRow(row: integer): integer;
    procedure Draw3DLines(ARect: TRect; ACol, ARow: integer;
	    AState: TGridDrawState);
    Function CellColor(ACol, ARow: integer): TColor; virtual;
    procedure DrawCheckBox(ARect: TRect; ACol, ARow: integer; val: boolean); virtual;
    procedure DrawCheckBox_Checkmark(ARect: TRect; ACol, ARow: integer; val: boolean);
    procedure RefreshBookmarkList; virtual;
    function CreateEditor: TInplaceEdit; override;
    procedure HideControls; virtual;
    property OnColWidthChanged: TColWidthChangedEvent read FOnColWidthChanged write FOnColWidthChanged;
    property OnAllowColResize: TAllowColResizeEvent read FOnAllowColResize write FOnAllowColResize;
    property OnColumnMoved: TMovedEvent read FOnColumnMoved write FOnColumnMoved;
    Procedure UnselectAll; virtual;
    Function IsSelectedCheckbox(ACol: integer): boolean;
    procedure DataChanged; virtual;
    Function IsSelectedRow(DataRow: integer): boolean; dynamic;
    procedure DoTopRowChanged; virtual;
    procedure DoRowChanged; virtual;
    procedure DoCellChanged; virtual;
    procedure DoCheckRowChanged; virtual;
    { Renamed property for C++ Builder conflicts }
    property IndicatorButtonWidth: integer read FIndicatorWidth write SetIndicatorWidth;
    {$ifdef win32}
     {$ifdef wwDelphi3Up}
     procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
     {$else}
     procedure GetChildren(Proc: TGetChildProc); override;
     {$endif}
    {$else}
    procedure WriteComponents(Writer: TWriter); override;
    {$endif}

    procedure TopLeftChanged; override;
    function GetClientRect: TRect; override;
    procedure Paint; override;

    function GetControlType: TStrings;
    procedure GetControlInfo(AFieldName: string;
       var AControlType: string; var AParameters: string); virtual;
    procedure DoFieldChanged(Field: TField); virtual;
    procedure DoUpdateFooter; virtual;
    Function GetFooterRect: TRect; virtual;
    procedure CheckFooterUpdate; virtual;
    procedure MouseMove(Shift: TShiftState; AX, AY: Integer); override;
    procedure FreeHintWindow; virtual;
    Function CreateHintWindow(AField: TField): THintWindow; virtual;
    procedure ValidationErrorUsingMask(Field: TField); virtual;
    procedure ChangeOrientation(RightToLeftOrientation: Boolean);
    procedure DrawLines; virtual;
    procedure PaintClickedTitleButton; virtual;
    function AdjustBoundsRect(ACurrentCustomEdit: TWinControl): boolean;
    procedure CalcSizingState(X, Y: Integer; var State: TGridState;
      var Index: Longint; var SizingPos, SizingOfs: Integer;
      var FixedInfo: TGridDrawInfo); override;
    procedure InitCacheColInfo; virtual;
    Function UseThemesInTitle: boolean;

  public
    AlternatePaintBuffering: boolean;
    SkipHideControls: boolean;  { IP Internal - Set by TwwDBLookupCombo DropDown method }
    SkipDataChange: boolean;    { IP Internal - Set by TwwDBLookupComboDlg }
    AlwaysShowControls: boolean; { Undocumented: when true controls will display even when grid is readonly}
//    DragImages: TImageList;
//    Indicators: TImageList;
    MinRowHeightPercent:Integer;  // Original rowheightpercent before user changes it

    property RowOffset: integer read FRowOffset write SetRowOffset;
    property TitleOffset: byte read FTitleOffset;
    property CompareBookmarksAltMethod: boolean read
                FCompareBookmarksAltMethod write FCompareBookmarksAltMethod default false;

//    OriginalCellText: string;

    procedure FillWithBlendBitmap(TempRect: TRect; CurRelRow: integer;
       FillColor: TColor=clNone); virtual;
    procedure FillWithFixedBitmap(TempRect: TRect; CurRelRow: integer;
       FillColor: TColor=clNone); virtual;
    procedure UpdateCustomEdit;
    procedure ResetProportionalWidths;
    Function ShouldShowCustomControls: boolean;
    function CanEditGrid: Boolean; virtual;
    procedure ClearURLPaint;
    Function ActiveExpandButton: TWinControl;
    procedure CalcDrawInfo(var DrawInfo: TGridDrawInfo); virtual;
    function HasFocus: boolean;  // Return true if we or a child of us has the focus;
    function IsActiveRowAlternatingColor: boolean;
    procedure CollapseChildGrid;
    procedure AddField(FieldName: string;
        Position: integer = -1; Redraw: boolean=True);
    procedure RemoveField(FieldName: string; Redraw: boolean = True);

    Function HaveAnyRowLines: boolean;
    {$ifdef wwdelphi4up}
    function ExecuteAction(Action: TBasicAction): Boolean; override; { 8/24/98 }
    function UpdateAction(Action: TBasicAction): Boolean; override; {8/24/98}
    {$endif}
    procedure GetURLLink(Value: string;
       var URLDisplayString: string; var URLLinkAddress: string); virtual;
    Procedure InvalidateCurrentRow;
    procedure InvalidateFooter;
    procedure FlushChanges; virtual;
    procedure UpdateRowCount;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override; {public to allow child to send keys to parent }
    Procedure SizeLastColumn;
    procedure BeginUpdate;
    procedure EndUpdate(Repaint: boolean = false);
    function IsCustomEditCell(col, row: integer; var customEdit: TWinControl) : boolean;
    function TitleCellRect(ACol, ARow: Longint): TRect; virtual;
    function GroupNameCellRect(ACol, ARow: Longint; var StartCol, EndCol: LongInt; VisibleOnly: boolean = True): TRect; virtual;
    function DragTitleCellRect(ACol, x, y: Longint): TRect; virtual;
    function CellRect(ACol, ARow: integer): TRect; virtual;
    procedure RestoreRowHeights;
    procedure ApplySelected; virtual;

    Procedure PaintActiveRowBackground(ACanvas: TCanvas; ARect: TRect);

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsCheckBox(col,row: integer; var checkboxon, checkboxoff: string): boolean;
    Function IsMemoField(Acol, Arow: integer): boolean; virtual; // 11/30/2001 - Made isMemoField virtual method.
    Function IsSelected: boolean; dynamic;
    function AllowPerfectFit: boolean;
    Function DoPerfectFit: boolean;
    Function DoShrinkToFit: boolean;
    Procedure SelectRecord; virtual;
    Procedure UnselectRecord; virtual;
    Procedure SetPictureMask(FieldName: string; Mask: string);
    Procedure SetPictureAutoFill(FieldName: string; AutoFill: boolean);
    Procedure ClearLastBookmarks; { 5/2/00 - Add method to clear last bookmark values }
    Function FieldName(Acol: integer): string;
    Function GetHighlightColor: TColor;

    procedure DefaultDrawDataCell(const Rect: TRect; Field: TField; State: TGridDrawState);
    // 4/19/2001 - PYW - Moved so Exporting unit can call these events.
    procedure DoCalcTitleAttributes(AFieldName: string; AFont: TFont; ABrush: TBrush;
	     var FTitleAlignment: TAlignment); virtual;
    procedure DoCalcCellColors(Field: TField; State: TGridDrawState;
	     highlight: boolean; AFont: TFont; ABrush: TBrush); virtual;
    procedure DoCalcCellColorsDetect(Field: TField; State: TGridDrawState;
	     highlight: boolean; AFont: TFont; ABrush: TBrush); virtual;
    Function XIndicatorOffset: integer;
    Function GetComponent(thisName: string): TWinControl;

    function GetEffectiveFooterHeight: integer;

    // 7/5/01 - Inherited MouseCoord does not work for Bide mode with fixed-editable
    function MouseCoord(X, Y: Integer): TGridCoord;
    Procedure AutoSizeColumn(ACol: integer);


    function GetPriorRecordText(AFieldname: string; var AText: string): boolean;
    function GetNextRecordText(AFieldname: string; var AText: string): boolean;

    property DataLink: TwwGridDataLink read FDataLink;
    property RowHeights;
    property ColWidthsPixels[Index: Longint]: Integer read GetColWidthsPixels write SetColWidthsPixels;
    property EditorMode;
    property FieldCount: Integer read GetFieldCount;
    property Fields[Index: Integer]: TField read GetFields;
    property SelectedField: TField read GetSelectedField write SetSelectedField;
    property SelectedIndex: Integer read GetSelectedIndex write SetSelectedIndex;
    property IndicatorColor: TIndicatorColorType read FIndicatorColor write SetIndicatorColor;
    property IndicatorIconColor: TColor read FIndicatorIconColor write SetIndicatorIconColor default clBlack;
    property Options: TwwDBGridOptions read FOptions write SetOptions
       default [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines,
      dgRowLines,
      dgTabs, dgConfirmDelete, dgCancelOnExit,
      dgWordWrap{, dgVariableRowHeight}];
    property KeyOptions : TwwDBGridKeyOptions read FKeyOptions write FKeyOptions
       default [dgAllowInsert, dgAllowDelete];
    property TitleAlignment: TAlignment read FTitleAlignment write setTitleAlignment;
    property TitleLines : integer read FTitleLines write setTitleLines;
    property OnCalcCellColors: TCalcCellColorsEvent read FOnCalcCellColors write FOnCalcCellColors;
    property OnCalcTitleAttributes: TCalcTitleAttributesEvent read FOnCalcTitleAttributes write FOnCalcTitleAttributes;
    property OnDrawTitleCell: TwwDrawTitleCellEvent read FOnDrawTitleCell write FOnDrawTitleCell;
    property OnDrawGroupHeaderCell: TwwDrawGroupHeaderCellEvent read FOnDrawGroupHeaderCell write FOnDrawGroupHeaderCell;
    property OnCalcTitleImage: TwwCalcTitleImageEvent read FOnCalcTitleImage write FOnCalcTitleImage;
    property OnTitleButtonClick: TTitleButtonClickEvent read FOnTitleButtonClick write FOnTitleButtonClick;
    property RowHeightPercent : Integer read FRowHeightPercent write SetRowHeightPercent Default 100;
    property ShowVertScrollBar: boolean read FShowVertScrollBar write setShowVertScrollBar default True;
    property ShowHorzScrollBar: boolean read getShowHorzScrollBar write setShowHorzScrollBar;
    property OnCheckValue: TwwValidateEvent read FOnCheckValue write FOnCheckValue;
    property OnTopRowChanged: TNotifyEvent read FOnTopRowChanged write FOnTopRowChanged;
    property OnRowChanged: TNotifyEvent read FOnRowChanged write FOnRowChanged;
    property OnCellChanged: TNotifyEvent read FOnCellChanged write FOnCellChanged;
    property OnLeftColChanged: TwwLeftColChangedEvent read FOnLeftColChanged write FOnLeftColChanged;
    property OnFieldChanged: TwwFieldChangedEvent read FOnFieldChanged write FOnFieldChanged;
    property OnUpdateFooter: TNotifyEvent read FOnUpdateFooter write FOnUpdateFooter;
    property CalcCellRow: integer read GetCalcCellRow;  {onCalcCellColor Row}
    property CalcCellCol: integer read FCalcCellCol;  {onCalcCellColor Column}
    property TitleButtons: boolean read FTitleButtons write SetTitleButtons;
    property EditCalculated : boolean read FEditCalculated write FEditCalculated default False;
    property MultiSelectOptions: TwwMultiSelectOptions read FMultiSelectOptions write FMultiSelectOptions default [];
    property Selected : TStrings read getSelectedFields write setSelectedFields;
    property UseTFields: boolean read FUseTFields write SetUseTFields default True;
    property IndicatorButton: TwwIButton read FIndicatorButton write FIndicatorButton stored False;
    property ImageList: TImageList read FImageList write FImageList;
    property TitleImageList: TImageList read FTitleImageList write FTitleImageList;
    property LineColors: TwwGridLineColors read FLineColors write FLineColors;

    property Columns[Index: Integer]: TwwColumn read GetColumn; // write SetColumn;
    Function ColumnByName(Index: String): TwwColumn; // read GetColumnByName; // write SetColumn;
    property OnDrawFooterCell: TDrawFooterCellEvent read FOnDrawFooterCell write FOnDrawFooterCell;
    property OnCreateHintWindow : TwwCreateGridHintWindowEvent read FOnCreateHintWindow write FOnCreateHintWindow;
    property OnBeforePaint : TNotifyEvent read FOnBeforePaint write FOnBeforePaint;
    property OnURLOpen: TwwGridURLOpenEvent read FOnURLOpen write FOnURLOpen;
//    property OnValidationErrorUsingMask: TwwPictureValidationError read FOnValidationErrorUsingMask write FOnValidationErrorUsingMask;

    property Canvas : TCanvas read GetCanvas;
    property DragVertOffset: integer read FDragVertOffset write FDragVertOffset default 15;

    property ControlInfoInDataset: boolean
             read FControlInfoInDataset write FControlInfoInDataSet default True;
    property ControlType : TStrings read FControlType write SetControlType;
    property PictureMaskFromDataSet: boolean
             read FPictureMaskFromDataSet write FPictureMaskFromDataSet default True;
    property PictureMasks: TStrings read FPictureMasks write SetPictureMasks;
    property LeftCol;
    property PadColumnStyle: TwwPadColumnStyle read FPadColumnStyle write FPadColumnStyle default pcsPadHeaderAndData;
    property EditControlOptions: TwwEditControlOptions read FEditControlOptions write FEditControlOptions
             default [ecoSearchOwnerForm];
    property PaintOptions: TwwGridPaintOptions read FPaintOptions write FPaintOptions;//SetPaintOptions;
    property LineStyle: TwwGridLineStyle read FLineStyle write FLineStyle default glsDynamic;
    property HideAllLines: boolean read FHideAllLines write FHideAllLines default False;
    property OnBeforeDrawCell: TwwCustomDrawCellEvent read FOnBeforeDrawCell write FOnBeforeDrawCell;
    property OnAfterDrawCell: TwwCustomDrawCellEvent read FOnAfterDrawCell write FOnAfterDrawCell;
    property VisibleRowCount;
  end;

   TwwUpdateSelected=(sptUpdateField, sptUpdateWidth, sptUpdateLabel, sptUpdateReadOnly,
      sptUpdateGroup);

procedure UpdateSelectedProp(Selected: TStrings;
   FieldName: string; val: string;
   SelectedProperty: TwwUpdateSelected; Index: integer = -1);

function GetSelectedProp(Selected: TStrings;
   FieldName: string;
   SelectedProperty: TwwUpdateSelected): string;

Procedure wwWriteTextLines(ACanvas: TCanvas;
    const ARect: TRect; DX, DY: Integer; S: PChar; Alignment: TAlignment;
    WriteOptions: TwwWriteTextOptions);


implementation

uses DBConsts,
  {$ifdef wwDelphi6Up}
  VDBConsts,
  {$endif}
  Consts, Dialogs, wwcommon, wwpict, wwintl, wwdbgrid, math,
  {$ifdef wwDelphi7Up}
  themes,
  {$endif}
bde, wwcheckbox, shellapi, imglist;

{$IFDEF WIN32}
{$R WWDBI32.RES}
{$ELSE}
{$R WWDBIGRD.RES}
{$ENDIF}

const
  bmArrow = 'WWDBGARROW';
  bmEdit = 'WWDBEDIT';
  bmInsert = 'WWDBINSERT';
  bmMultiSelect = 'WWDBMULTISELECT';
  bmMultiArrow = 'WWDBMULTIARROW';
  bmArrowYellow = 'WWDBGARROWYELLOW';
  bmEditYellow = 'WWDBEDITYELLOW';
  bmInsertYellow = 'WWDBINSERTYELLOW';
  bmMultiSelectYellow = 'WWDBMULTISELECTYELLOW';
  bmMultiArrowYellow = 'WWDBMULTIARROWYELLOW';

  MaxMapSize = 65520 div SizeOf(Integer);
//  GridScrollSize = 200;

  NormalPad = 2;

  ctmdNone = 0;
  ctmdForward = 1;
  ctmdBackward = 2;
  wwDisableDrawBottomLine = 1;
  wwDisableDrawHorzTopLine = 2;

var
    DragImages: TImageList;
    Indicators: TImageList;
    UserCount: Integer;

procedure InitIndicators;
var Bmp: TBitmap;
begin
  Indicators.Free;
  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromResourceName(HInstance, bmArrow);
//    ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
    Indicators := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    Indicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmEdit);
//    ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
    Indicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmInsert);
//    ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
    Indicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiSelect);
//    ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
    Indicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiArrow);
//    ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
    Indicators.AddMasked(Bmp, clWhite);
//    Indicators.BkColor:= clWhite;
  finally
    Bmp.Free;
  end;

end;

procedure UsesBitmap;
var Bmp: TBitmap;
begin
  if UserCount = 0 then
  begin
    InitIndicators;
    Bmp := TBitmap.Create;
    try
      Bmp.LoadFromResourceName(HInstance, 'WWRIGHT');
      DragImages := TImageList.CreateSize(Bmp.Width, Bmp.Height);
      DragImages.AddMasked(Bmp, clWhite);
      Bmp.LoadFromResourceName(HInstance, 'WWLEFT');
      DragImages.AddMasked(Bmp, clWhite);
      DragImages.BkColor:= clWhite;
    finally
      Bmp.Free;
    end;
  end;
  Inc(UserCount);
end;

procedure ReleaseBitmap;
begin
  Dec(UserCount);
  if UserCount = 0 then begin
     Indicators.Free;
     Indicators:=nil;
     DragImages.Free;
     DragImages:=nil;
  end;
end;

//var
//  BrowseIndicatorBitmap, EditIndicatorBitmap,
//  InsertIndicatorBitmap, MultiSelectBitmap, MultiArrowBitmap: TBitmap;

{type
  TwwGridHintWindow=class(THintWindow)
  private
     Field: TField;
     WordWrap: boolean;
  protected
     procedure Paint; override;
  public
     HintText: string;
  end;
}
var KeyHook : HHOOK;

function wwHookKeyProc(nCode: Integer; wParam: Integer; lParam: Integer): LResult; stdcall;
type
  TSelection = record
    StartPos, EndPos: Integer;
  end;
var ac: TWinControl;
    Grid: TwwCustomDBGrid;

    Function IsImmediateChildOfGrid: boolean;
    var tc: TWinControl;
    begin
       tc:= screen.activecontrol;
       result:=  tc.parent is TCustomGrid;
    end;

    Function GetwwDBgrid(var Grid: TwwCustomDBGrid): boolean;
    var tc: TWinControl;
    begin
       tc:= screen.activecontrol;
       if not (tc is TwwCustomDBGrid) then
       begin
          repeat
             tc:= tc.parent;
          until (tc=nil) or (tc is TwwCustomDBGrid);
       end;
       result:=  (tc is TwwCustomDBGrid);
       if result then
          Grid:= TwwCustomDBGrid(tc)
       else
          Grid:=nil;
    end;

    Function IsChildOfGrid(var Inspector: TwwCustomDBGrid): boolean;
    var tc: TWinControl;
        grid: TwwCustomDBGrid;
    begin
       GetwwDBGrid(Grid);
       if (Grid=Nil) or Grid.IsDropDownGridFocused then begin
          result:= False;
          exit;
       end;
       tc:= screen.activecontrol;
       if not (tc is TCustomGrid) then
       begin
          repeat
             tc:= tc.parent;
          until (tc=nil) or (tc is TCustomGrid);
       end;
       result:=  (tc is TCustomGrid);
       if result and wwIsClass(tc.classtype, 'TwwCustomDBGrid') then
          Inspector:= TwwCustomDBGrid(tc)
       else begin
          Inspector:=nil;
          result:= false;
       end
    end;

  function Selection: TSelection;
  begin
    SendMessage(ac.Handle, EM_GETSEL, Longint(@Result.StartPos), Longint(@Result.EndPos));
  end;


  Function AllSelected: boolean;
  begin
     with ac do
       with Selection do
        Result := (StartPos = 0) and
                  (EndPos = GetTextLen);
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

  function TrueFocusIsGrid: boolean;
  begin
     result:= IsChild(Grid.Handle, GetFocus) or (GetFocus=Grid.Handle);
  end;

begin
    ac:= screen.activecontrol;
    if ac is TCustomGrid then  // inplaceeditor doesn't update ac
    begin
       if (TwwCustomDBGrid(ac).inplaceeditor<>nil) and
          (TwwCustomDBGrid(ac).inplaceeditor.handle = GetFocus) then
       begin
          ac:= TwwCustomDBGrid(ac).inplaceeditor;
       end
    end;

    result := CallNextHookEx(KeyHook, nCode, wParam, lParam);
    if ac=nil then exit;

    if ((wparam = 13) or (wparam = 9)) and
       not (GetKeyState(vk_control)<0) and
       not (GetKeyState(vk_menu)<0) and
       (GetFocus=ac.handle) then
    begin
       if (lparam and $80000000)=0 then begin
         if IsChildOfGrid(Grid) then
         begin
           if (dgEnterToTab in Grid.KeyOptions) or (wparam=vk_tab) then
           begin
//             Inspector.SetFocus;
//             PostMessage(Grid.handle, WM_KEYDOWN, VK_TAB, 0);
             PostMessage(Grid.handle, WM_KEYDOWN, wparam, 0);
             result:=1;
           end
         end
       end
       // 6/20/01
       else if not IsChildOfGrid(Grid) then // Another form is active
          result:=0
//       else result:=1
       else result:=0      // 9/27/01 - Allow KeyUp to fire for grid
    end
{    else if (wparam = vk_f2) and
       not (GetKeyState(vk_control)<0) and
       not (GetKeyState(vk_menu)<0) then
    begin
       if IsChildOfInspector(Inspector) then
       begin
         if (lparam and $80000000)=0 then
           Inspector.FCustomControlKeyMode:= not Inspector.FCustomControlKeyMode;
       end
    end}
    // Collapse expand button on Ctrl-left
    else if (wparam in [vk_left]) and
        ((lparam and $80000000)=0) and
        (GetKeyState(vk_control)<0) and
        GetwwDBgrid(Grid) and Grid.IsDropDownGridFocused then begin
       Grid.CollapseChildGrid;
       result:= 1; // 9/18/02 - Eat keystroke so focus does not jump out of grid
    end
    // Need obj property to see if we should pass vk_down, vk_up, vk_next, and vk_prior to inspector
    // Always pass vk_left, vk_right
    else if (wparam in [vk_home, vk_end, vk_right, vk_left, vk_down, vk_up, vk_next, vk_prior,
                        vk_delete]) and
        ((lparam and $80000000)=0) and
        (GetKeyState(vk_control)<0) then
    begin
        // So dropped-down combos get keystrokes, check if radio-group is still ok
        if wwHaveVisibleChild(ac) then exit;

        if IsChildOfGrid(Grid) and (ac<>Grid)  then
        begin
           PostMessage(Grid.handle, WM_KEYDOWN, wparam, 0);
           result:=1;
        end
    end
    else if (wparam in [vk_left, vk_right, vk_down, vk_up, vk_next, vk_prior,
       vk_insert, vk_home]) and // 1/21/00 - Allow home to go to first column if all selected
       not (GetKeyState(vk_control)<0) and
       not (GetKeyState(vk_menu)<0) then
    begin
       if wwHaveVisibleChild(ac) then exit;

       if (lparam and $80000000)=0 then begin
         // Immediate child used to support radiogroup in TwwDBGrid
//         if IsChildOfGrid(Inspector) and // Initialize inspector
//            IsImmediateChildOfGrid and (ac<>Inspector) then
         if IsChildOfGrid(Grid) then
         begin
            if not TrueFocusIsGrid then exit;
//            if not IsImmediateChildOfGrid and (ac<>Grid) then
            if not IsImmediateChildOfGrid and (screen.activecontrol<>Grid) then // 1/21/02 RSW (If inplaceeditor then its not a radiogroiup item so don't geo into this path )
            begin
               if (wparam in [vk_left, vk_right, vk_up, vk_down]) then exit; // radiogroup item has focus
            end;

            // Send to inspector navigation keys
            if (ac is TCustomEdit) then
            begin
               case wparam of
                 VK_HOME: if not LeftSide then exit;
                 VK_LEFT: if not LeftSide then exit;
                 VK_RIGHT: if not RightSide then exit;
                 VK_UP: if not AllSelected then exit;  // 1/21/02 - 
                 VK_DOWN: if not AllSelected then exit; // 1/21/02
               end
            end;

            if Grid.Focused then exit
            else begin
               PostMessage(Grid.handle, WM_KEYDOWN, wparam, 0);
            end;

            result:=1;
         end
       end
       // 6/20/01
       else if not IsChildOfGrid(Grid) then // Another form is active
          result:=0
//       else result:=1
       // 9/12/01 - Allow KeyUp to fire for grid
       else result:=0
    end

end;

procedure TwwGridHintWindow.Paint;
var
  R: TRect;
  WriteOptions: TwwWriteTextOptions;
begin
  R := ClientRect;
  Inc(R.Left, 1);
  Inc(R.Top, 2);
  Canvas.Font.Color := clInfoText;
  if WordWrap then
     WriteOptions:= [wtoWordWrap];
//  if (Field<>nil) and
//      TwwCustomDBGrid(Owner).UseRightToLeftAlignmentForField(Field, Alignment) then
//     WriteOptions:= WriteOptions + [wtoRightToLeft];

  wwWriteTextLinesT(Canvas, R, 0, 0, PChar(Caption), Alignment,
    WriteOptions);
//  SetBkMode(Canvas.Handle, TRANSPARENT);
//  DrawText(Canvas.Handle, PChar(Caption), -1, R,
//     DT_LEFT or DT_NOPREFIX {or DT_WORDBREAK });
end;


function TwwCustomDBGrid.UseAlternateBuffering: boolean;
begin
   result:= AlternatePaintBuffering or
      UseRightToLeftAlignment or (wwInternational.GridPaintStyle = gpsDynamicDeviceContext);
  if result and (csPaintCopy in ControlState) then
     result:= false;
end;

function TwwCustomDBGrid.GetCanvas: TCanvas;
begin
  if useDragCanvas then
     result:= CaptureTitleBitmap.Canvas
  else if not UseAlternateBuffering then
     result:= FPaintCanvas
  else
     result:= inherited Canvas;
//     result:= inherited Canvas;
end;

procedure UpdateSelectedProp(Selected: TStrings;
   FieldName: string; val: string;
   SelectedProperty: TwwUpdateSelected; Index: integer = -1);
var APos: integer;
    FieldWidth, DisplayLabel, ReadOnly, GroupName: wwSmallString;
begin
   if Index=-1 then
   begin
      if not wwFindSelected(Selected, FieldName, index) then exit;
   end;

   begin
      APos:=1;
      FieldName:= strGetToken(Selected[index], #9, apos);
      FieldWidth:= strGetToken(Selected[index], #9, apos);
      DisplayLabel:= strGetToken(Selected[index], #9, apos);
      ReadOnly:= strGetToken(Selected[index], #9, apos);
      if ReadOnly='' then ReadOnly:= 'F';
      GroupName:= strGetToken(Selected[index], #9, apos);
      case SelectedProperty of
         sptUpdateGroup: GroupName:= val;
         sptUpdateWidth: FieldWidth:= val;
         sptUpdateLabel: DisplayLabel:= val;
         sptUpdateReadOnly: ReadOnly:= val;
      end;
      Selected[index]:= FieldName + #9 + FieldWidth + #9 +
         DisplayLabel + #9 + ReadOnly;
      if GroupName<>'' then
         Selected[index]:= Selected[index] + #9 + GroupName;
   end;
end;

function GetSelectedProp(Selected: TStrings;
   FieldName: string;
   SelectedProperty: TwwUpdateSelected): string;
var APos, index: integer;
    FieldWidth, DisplayLabel, ReadOnly, GroupName: wwSmallString;
begin
   if wwFindSelected(Selected, FieldName, index) then
   begin
      APos:=1;
      FieldName:= strGetToken(Selected[index], #9, apos);
      FieldWidth:= strGetToken(Selected[index], #9, apos);
      DisplayLabel:= strGetToken(Selected[index], #9, apos);
      ReadOnly:= strGetToken(Selected[index], #9, apos);
      if ReadOnly='' then ReadOnly:= 'F';
      GroupName:= strGetToken(Selected[index], #9, apos);
      case SelectedProperty of
         sptUpdateGroup: result:= GroupName;
         sptUpdateField: result:= FieldName;
         sptUpdateWidth: result:= FieldWidth;
         sptUpdateLabel: result:= DisplayLabel;
         sptUpdateReadOnly: result:= ReadOnly;
      end;
   end
end;

Function min(x,y: integer): integer;
begin
   if x<y then min:= x
   else min:= y;
end;

{ Error reporting }
procedure RaiseGridError(const S: string);
begin
  raise EInvalidGridOperation.Create(S);
end;

{procedure GridError(S: Word);
begin
  RaiseGridError(LoadStr(S));
end;

procedure GridErrorFmt(S: Word; const Args: array of const);
begin
  RaiseGridError(FmtLoadStr(S, Args));
end;
}

{ TwwGridDataLink }
type
  TIntArray = array[0..MaxMapSize] of Integer;
  PIntArray = ^TIntArray;

  TBitmapCacheType=class
    Bitmap: TBitmap;
    LookupValue: string;
    curField: TField;
  end;

constructor TwwGridDataLink.Create(AGrid: TwwCustomDBGrid);
begin
  inherited Create;
  FGrid := AGrid;
  VisualControl:= True;
end;

destructor TwwGridDataLink.Destroy;
begin
  ClearMapping;
  inherited Destroy;
end;

function TwwGridDataLink.GetDefaultFields: Boolean;
begin
  Result := True;
  if DataSet <> nil then Result := DataSet.DefaultFields;
end;

function TwwGridDataLink.GetFields(I: Integer): TField;
begin
  if I < FFieldCount then
    Result := DataSet.Fields[PIntArray(FFieldMap)^[I]]
  else Result:= nil;
end;

function TwwGridDataLink.AddMapping(const FieldName: string): Boolean;
var
  Field: TField;
  NewSize: Integer;
  NewMap: Pointer;
begin
  if FFieldCount >= MaxMapSize then
  {$ifdef wwDelphi3Up}
     RaiseGridError(STooManyColumns);
  {$else}
     GridError(STooManyColumns);
  {$endif}
  Field := DataSet.FindField(FieldName);
  Result := Field <> nil;
  if Result then
  begin
    if FFieldMapSize = 0 then
    begin
      FFieldMapSize := 8;
      GetMem(FFieldMap, FFieldMapSize * SizeOf(Integer));
    end
    else if FFieldCount = FFieldMapSize then
    begin
      NewSize := FFieldMapSize;
      Inc(NewSize, NewSize);
      if (NewSize > MaxMapSize) or (NewSize < FFieldCount) then
	NewSize := MaxMapSize;
      GetMem(NewMap, NewSize * SizeOf(Integer));
      Move(FFieldMap^, NewMap^, SizeOf(Integer) * FFieldCount);
      FreeMem(FFieldMap, SizeOf(Integer) * FFieldCount);
      FFieldMapSize := NewSize;
      FFieldMap := NewMap;
    end;
    PIntArray(FFieldMap)^[FFieldCount] := Field.Index;
{    if FGrid.useTFields then
       PIntArray(FFieldMap)^[FFieldCount] := Field.Index
    else if wwFindSelected(FGrid.Selected, Field.FieldName, AIndex) then
       PIntArray(FFieldMap)^[FFieldCount] := AIndex;}
    Inc(FFieldCount);
  end;
end;

procedure TwwGridDataLink.ActiveChanged;
begin
  FGrid.LinkActive(Active);
end;

procedure TwwGridDataLink.ClearMapping;
begin
  if FFieldMap <> nil then
  begin
    FreeMem(FFieldMap, FFieldMapSize * SizeOf(Integer));
    FFieldMap := nil;
    FFieldMapSize := 0;
    FFieldCount := 0;
  end;
end;

procedure TwwGridDataLink.Modified;
begin
  FModified := True;
end;

procedure TwwGridDataLink.DataSetChanged;
begin
  FGrid.DataChanged;
  FModified := False;
end;

procedure TwwGridDataLink.FocusControl(Field: TFieldRef);
begin
  if Assigned(Field) and Assigned(Field^) then
  begin
    FGrid.SelectedField := Field^;
    if (FGrid.SelectedField = Field^) and FGrid.AcquireFocus then
    begin
      Field^ := nil;
{      with FGrid do
      begin
         if (dgAlwaysShowEditor in Options) and (not isWWControl(SelectedIndex, 1)) and
            (not isMemoField(SelectedIndex, 1)) then
            ShowEditor;
      end}
//      FGrid.ShowEditor;
    end;
  end;
end;

procedure TwwGridDataLink.DataSetScrolled(Distance: Integer);
begin
  FGrid.Scroll(Distance);
end;

procedure TwwGridDataLink.LayoutChanged;
begin
{  if FGrid.useTFields then} FGrid.LayoutChanged;
end;

procedure TwwGridDataLink.EditingChanged;
begin
  FGrid.EditingChanged;

  { Update footer later, when encountering edit or insert mode }
  if (datasource<>nil) and  { 10/7/98 }
     ((datasource.state=dsInsert) or (datasource.state=dsEdit)) then
  begin
    FGrid.ShouldUpdateFooter:= True;
  end;
end;

procedure TwwGridDataLink.RecordChanged(Field: TField);
begin
  if (Field = nil) or not FInUpdateData then
  begin
    FGrid.RecordChanged(Field);
    FModified := False;
  end;

  if (Field<>Nil) and (Dataset.State in [dsEdit, dsInsert]) then
  begin
     FGrid.FieldChanged(Field);
     if (FGrid is TwwDBGrid) then TwwDBGrid(FGrid).Patch[0]:=True;
  end
end;

procedure TwwGridDataLink.UpdateData;
begin
  FInUpdateData := True;
  try
    if FModified then FGrid.UpdateData;
    FModified := False;
  finally
    FInUpdateData := False;
  end;
end;

procedure TwwGridDataLink.Reset;
begin
  if FModified then RecordChanged(nil) else begin
     if ((DataSource.DataSet.State = dsEdit) or (DataSource.DataSet.State = dsInsert)) and
	 dataSet.modified then
     begin
	 if MessageDlg(wwInternational.UserMessages.wwDBGridDiscardChanges,
		    mtConfirmation, [mbYes,mbNo], 0)<>mrYes then exit;
     end;
     Dataset.Cancel;
  end
end;

{ TwwCustomDBGrid }

(*
var
//  DrawBitmap: TBitmap;
  UserCount: Integer;

procedure UsesBitmap;
begin
   exit;
  if UserCount = 0 then
  begin
//    DrawBitmap := TBitmap.Create;
  end;
  Inc(UserCount);
end;


procedure ReleaseBitmap;
begin
  Dec(UserCount);
  if UserCount = 0 then begin
//     DrawBitmap.Free;
//     DrawBitmap:= Nil;
     EditIndicatorBitmap.Free;
     BrowseIndicatorBitmap.Free;
     InsertIndicatorBitmap.Free;
     MultiSelectBitmap.Free;
     MultiArrowBitmap.Free;
     EditIndicatorBitmap:= Nil;
     BrowseIndicatorBitmap:= Nil;
     InsertIndicatorBitmap:= Nil;
     MultiSelectBitmap := Nil;
     MultiArrowBitmap := Nil;
  end;
end;
*)

function Max(X, Y: Integer): Integer;
begin
  Result := Y;
  if X > Y then Result := X;
end;

(*
procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment; ARightToLeft: Boolean);
const
  AlignFlags : array [TAlignment] of Integer =
    ( DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX );
  RTL: array [Boolean] of Integer = (0, DT_RTLREADING);
var
  B, R: TRect;
  Hold, Left: Integer;
  I: TColorRef;
begin
  I := ColorToRGB(ACanvas.Brush.Color);
//  if GetNearestColor(ACanvas.Handle, I) = I then
  begin                       { Use ExtTextOut for solid colors }
    { In BiDi, because we changed the window origin, the text that does not
      change alignment, actually gets its alignment changed. }
    if (ACanvas.CanvasOrientation = coRightToLeft) and (not ARightToLeft) then
      ChangeBiDiModeAlignment(Alignment);
    case Alignment of
      taLeftJustify:
        Left := ARect.Left + DX;
      taRightJustify:
        Left := ARect.Right - ACanvas.TextWidth(Text) - 3;
    else { taCenter }
      Left := ARect.Left + (ARect.Right - ARect.Left) shr 1
        - (ACanvas.TextWidth(Text) shr 1);
    end;
    ACanvas.TextRect(ARect, Left, ARect.Top + DY, Text);
  end
end;
*)
Procedure wwWriteTextLines(ACanvas: TCanvas;
    const ARect: TRect; DX, DY: Integer; S: PChar; Alignment: TAlignment;
    WriteOptions: TwwWriteTextOptions);
const
  AlignFlags : array [TAlignment] of Integer =
    ( DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX,
      DT_RIGHT or DT_EXPANDTABS or DT_NOPREFIX,
      DT_CENTER or DT_EXPANDTABS or DT_NOPREFIX );
  RTL: array [Boolean] of Integer = (0, DT_RTLREADING);
var
  R, DrawRect: TRect;
  Flags: integer;
  ADrawCanvas: TCanvas;
  TEMP: INTEGER;
  tempRect: TRect;
begin

//   WriteText(ACanvas, ARect, DX, DY, S, Alignment, True);
//   exit;

    ADrawCanvas:= ACanvas;

    if (ACanvas.CanvasOrientation = coRightToLeft) then
        ChangeBiDiModeAlignment(Alignment);

    with ARect do
    begin                     { brush origin tics in painting / scrolling.    }
      if Alignment=taRightJustify then
         R := Rect(DX, DY, Right - Left -2, Bottom - Top - 1) { 7/10/98 - Make width 1 less }
      else if Alignment=taLeftJustify then
         R := Rect(DX, DY, Right - Left, Bottom - Top - 1)
      else  {3/31/98 - If CenterJustify then allow DrawText to properly center text}
      begin
         if DX>=3 then
            R := Rect(2, DY, Right - Left, Bottom - Top - 1)
         else
            R := Rect(0, DY, Right - Left, Bottom - Top - 1)
      end;
      R.Left:= R.Left + ARect.Left;
      R.Right:= R.Right + ARect.Left;
      R.Top:= R.Top + ARect.Top;
      R.Bottom:= R.Bottom + ARect.Top;
    end;

    with ADrawCanvas do
    begin
      Font := ACanvas.Font;
      Font.Color := ACanvas.Font.Color;
      Brush := ACanvas.Brush;
      Brush.Style := bsSolid;
      if not (wtoTransparent in WriteOptions) then
      begin
         TempRect:= ARect;
{         TempRect.Left:= TempRect.Left - 1;
}
         FillRect(TempRect);
      end;

      SetBkMode(Handle, TRANSPARENT);
      Flags:= AlignFlags[Alignment];
      if (ACanvas.CanvasOrientation = coRightToLeft) then { 9/25/98 - Support bidi mode }
      begin
         if wtoAmpersandToUnderline in WriteOptions then
            Flags:= Flags and (not  DT_NOPREFIX);
         if wtoWordWrap in WriteOptions then
            Flags := Flags or DT_WORDBREAK;
         DrawRect:= ARect;
         DrawTextEx(Handle, PChar(s),
                      Length(s), drawrect, Flags or DT_CALCRECT, nil);
         if DrawRect.Left-DrawRect.right>Arect.Right-Arect.left then
         begin
            DrawRect.Left:= DrawRect.Right +
               Arect.Right-Arect.left;
         end;

         if DrawRect.Left<DrawRect.Right then DrawRect.Left:=DrawRect.Right;

         If Alignment =taLeftJustify then
         begin
            temp:= r.left;
            r.left:= r.right -2;
            r.right:= temp;
         end
         else if Alignment = taRightJustify then begin
            Flags:= AlignFlags[taLeftJustify] {or DT_RTLREADING};
            r.Left:= wwMin(ARect.Right-2, ARect.Left + ACanvas.TextWidth(s) + 2);
            r.Right:= ARect.Left;
         end
         else begin
            Flags:= AlignFlags[taLeftJustify] {or DT_RTLREADING};
            r.right:= ARect.Left + ((ARect.Right-ARect.Left) - (DrawRect.left-DrawRect.right)) div 2;
            r.left:= ARect.Right - ((ARect.Right-ARect.Left) - (DrawRect.left-DrawRect.right)) div 2;
         end;
      end;
      if wtoAmpersandToUnderline in WriteOptions then
         Flags:= Flags and (not  DT_NOPREFIX);

      if wtoWordWrap in WriteOptions then
         Flags := Flags or DT_WORDBREAK;

      {3/31/98 - Check to see if this is a single line edit control to
       determine if we should or should not have word breaks}
      if wwIsSingleLineEdit(Handle,R,Flags) or (wtoEllipsis in WriteOptions) then
          Flags := Flags and not DT_WORDBREAK;
      if wtoEllipsis in WriteOptions then
      begin
         Flags:= Flags or DT_END_ELLIPSIS;  { If text does not fit then put ellipsis at end }
         DrawText(Handle, S, StrLen(S), R, Flags);
      end
      else begin
         DrawText(Handle, S, StrLen(S), R, Flags);
      end
    end;
end;


procedure ChangeColorBitmap(bitmap: TBitmap; NewColor, OldColor: TColor);
var r: TRect;
    b: TBitmap;
begin
   b:= TBitmap.create;
   try
     b.assign(bitmap);

     { Substitute indicator color for black}
     Bitmap.Canvas.Brush.Color:= NewColor;
     r:= Rect(0, 0, Bitmap.Width, Bitmap.Height);
     Bitmap.Canvas.BrushCopy(r, b, r, OldColor);
   finally
     b.free;
   end
end;

(*procedure TwwCustomDBGrid.InitIndicators;
var Bmp: TBitmap;
begin
  Indicators.Free;
  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromResourceName(HInstance, bmArrow);
    ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
    Indicators := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    Indicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmEdit);
    ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
    Indicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmInsert);
    ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
    Indicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiSelect);
    ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
    Indicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiArrow);
    ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
    Indicators.AddMasked(Bmp, clWhite);
//    Indicators.BkColor:= clWhite;
  finally
    Bmp.Free;
  end;

end;
*)
constructor TwwCustomDBGrid.Create(AOwner: TComponent);
//var
//  Bmp: TBitmap;
begin
  UsesBitmap;

  DrawCellInfo:= TwwCustomDrawGridCellInfo.create;
  OrigColWidths:=nil;
  TempLastCol:= -1;
  FSizingIndex:=-1;
  FCacheColInfo:= TList.create;

  inherited Create(AOwner);
  inherited DefaultDrawing := False;
  FShowHorzScrollBar:= True;
  LineStyle:= glsDynamic;
  FAcquireFocus := True;
//  Bmp := TBitmap.Create;
  try
{    Bmp.Handle := LoadBitmap(HInstance, bmArrow);
    if BrowseIndicatorBitmap=Nil then begin
       BrowseIndicatorBitmap:= TBitmap.create;
       BrowseIndicatorBitmap.assign(Bmp);
    end;
    Bmp.Handle := LoadBitmap(HInstance, bmEdit);
    if EditIndicatorBitmap=Nil then begin
       EditIndicatorBitmap:=TBitmap.create;
       editIndicatorBitmap.assign(Bmp);
    end;
    Bmp.Handle := LoadBitmap(HInstance, bmInsert);
    if InsertIndicatorBitmap=Nil then begin
       InsertIndicatorBitmap:= TBitmap.create;
       InsertIndicatorBitmap.assign(Bmp);
    end;
    Bmp.Handle := LoadBitmap(HInstance, bmMultiSelect);
    if MultiSelectBitmap=Nil then begin
       MultiSelectBitmap:= TBitmap.create;
       MultiSelectBitmap.assign(Bmp);
    end;
    Bmp.Handle := LoadBitmap(HInstance, bmMultiArrow);
    if MultiArrowBitmap=Nil then begin
       MultiArrowBitmap:= TBitmap.create;
       MultiArrowBitmap.assign(Bmp);
    end;
}
    FIndicatorColor := icBlack;
    FIndicatorIconColor:= clBlack;

{    Bmp.LoadFromResourceName(HInstance, 'WWRIGHT');
    DragImages := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    DragImages.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, 'WWLEFT');
    DragImages.AddMasked(Bmp, clWhite);
    DragImages.BkColor:= clWhite;
}
{    Bmp.LoadFromResourceName(HInstance, bmArrow);
    Indicators := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    Indicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmEdit);
    Indicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmInsert);
    Indicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiSelect);
    Indicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiArrow);
    Indicators.AddMasked(Bmp, clWhite);}
//    Indicators.BkColor:= clWhite;
  finally
//    Bmp.Free;
  end;

//  InitIndicators;
  FTitleOffset := 1;
  FIndicatorOffset := 1;
  FUpdateFields := True;
  FOptions := [dgEditing, dgTitles, dgIndicator, dgColumnResize,
    dgColLines, dgRowLines,
    dgTabs, dgConfirmDelete, dgCancelOnExit,
    dgWordWrap{, dgVariableRowHeight}];
  FKeyOptions:= [dgAllowInsert, dgAllowDelete];
//  UsesBitmap;
  ScrollBars := ssHorizontal;
  inherited Options := [goFixedHorzLine, goFixedVertLine, goHorzLine,
    goVertLine, goColSizing, goColMoving, goTabs, goEditing];
  inherited RowCount := 2;
  inherited ColCount := 2;
  FDataLink := TwwGridDataLink.Create(Self);
//  FVDataLink := TwwGridDataLink.Create(Self);
  Color := clWindow;
  ParentColor := False;
  FTitleFont := TFont.Create;
  FTitleFont.OnChange := TitleFontChanged;
  FTitleColor := clBtnFace;
  FFooterColor:= clBtnFace;
  FFooterCellColor:= clBtnFace;
  FSaveCellExtents := False;
  FUserChange := True;
  FDefaultDrawing := True;
  HideEditor;

  FTitleAlignment:= taLeftJustify;
  FRowHeightPercent:= 100;
  MinRowHeightPercent:=100;

  FTitleLines:= 1;
  ShowVertScrollBar:= True;

  InUpdateRowCount:= False;
  TitleClickColumn:= -1;
  TitleClickGroupTitle := False;

  FSelected:= TStringList.create;
  UseTFields:= True;
  FIndicatorWidth:= 11;
  ColItems:= TList.Create;

  FDragVertOffset:= 15;

  FControlType:= TStringList.create;
  FControlInfoInDataset:= True;
  FPictureMasks:= TStringList.create;
  FPictureMaskFromDataSet:= True;

  DummyColumn:= TwwColumn.Create(self, '');
  FPadColumnStyle := pcsPadHeaderAndData;
//  FPadColumnStyle:= pcsPadHeader;
//  FPadColumnStyle:= pcsPlain;

  FPaintBitmap:= TBitmap.create;
  FPaintCanvas:= FPaintBitmap.Canvas;

  FEditControlOptions := [ecoSearchOwnerForm];
  FPaintOptions:= TwwGridPaintOptions.create(self, FPaintBitmap);

  FLineColors:= TwwGridLineColors.create;
  FLineColors.DataColor := clSilver;
  FLineColors.HighlightColor := clBtnHighlight;
  FLineColors.ShadowColor:= clBtnShadow;
  FLineColors.FixedColor:= clBlack;
//  DoubleBuffered:=True;

  TitleLastMouseX:= -1;
  TitleLastMouseY:= -1;

end;

destructor TwwCustomDBGrid.Destroy;
var i: integer;
begin
  if KeyHook<>0 then begin
     UnhookWindowsHookEx(KeyHook);
     KeyHook:= 0;
  end;

  DrawCellInfo.Free;
  DrawCellInfo:= nil;
  ReleaseBitmap;

  for i:= 0 to FCacheColInfo.count-1 do TwwCacheColInfoItem(FCacheColInfo[i]).Free;
  FCacheColInfo.Free;
  FCacheColInfo:=nil;
  FIndicatorButton.Free;

  FSelected.Free;
  FSelected := Nil;

  FDataLink.Free;
  FDataLink := nil;
//  FVDataLink.Free;
//  FVDataLink := nil;
  FTitleFont.Free;
  FTitleFont:= Nil;

  for i:= 0 to ColItems.Count-1 do TwwColumn(ColItems[i]).Free;
  ColItems.Free;
  ColItems:=nil;

  CaptureTitleBitmap.Free;
  CaptureTitleBitmap:= nil;
  FControlType.Free;
  FPictureMasks.Free;

  ClearLastBookmarks;
  FPaintOptions.Free;

  ResetProportionalWidths;

(*  {$ifdef wwdelphi4up}
  if LastBookmark<>Nil then FreeMem(LastBookmark);
  LastBookmark:= nil;
  if LastMasterBookmark<>Nil then FreeMem(LastMasterBookmark);
  LastMasterBookmark:= nil;
  {$else}
  if LastBookmark<>Nil then StrDispose(LastBookmark);
  LastBookmark:= nil;
  if LastMasterBookmark<>Nil then StrDispose(LastMasterBookmark);
  LastMasterBookmark:= nil;
  {$endif}
*)
//  DragImages.Free;
//  Indicators.Free;
  DummyColumn.Free;
  DummyColumn:= nil;
  FPaintBitmap.Free;
  FPaintBitmap:=nil;
  FLineColors.Free;

  inherited Destroy;
//  ReleaseBitmap;
end;

Procedure TwwCustomDBGrid.ClearLastBookmarks;
begin
  {$ifdef wwdelphi4up}
  if LastBookmark<>Nil then FreeMem(LastBookmark);
  LastBookmark:= nil;
  if LastMasterBookmark<>Nil then FreeMem(LastMasterBookmark);
  LastMasterBookmark:= nil;
  {$else}
  if LastBookmark<>Nil then StrDispose(LastBookmark);
  LastBookmark:= nil;
  if LastMasterBookmark<>Nil then StrDispose(LastMasterBookmark);
  LastMasterBookmark:= nil;
  {$endif}
end;

procedure TwwCustomDBGrid.DefineFieldMap;
var
  I: Integer;
  APos: integer;
  FldName: string;
  TempList: TList;
  {ExistingColumn, }CurColumn: TwwColumn;
begin

  if FDataLink.DataSet=nil then exit;

  with FDatalink.Dataset do begin
    if useTFields then begin
       for I := 0 to FieldCount - 1 do
       begin
         with Fields[I] do if Visible then FDatalink.AddMapping(Fieldname);
       end
    end
    else begin
       i:= 0;
       while i<=Selected.count-1 do
       begin
          APos:= 1;
          FldName:= strGetToken(selected[i], #9, APos);
          if FDataLink.Active and (FindField(FldName)=Nil) then
          begin
             Selected.delete(i);
             continue;
          end
          else begin
             FDatalink.AddMapping(FldName);
          end;
          inc(i);
       end
    end
  end;

  { Create templist for TwwColumns - saves existing properties }
  TempList:= TList.create;
  for i:= 0 to FieldCount-1 do
  begin
     curColumn:= TwwColumn.Create(self, Fields[i].FieldName);
//     ExistingColumn:= ColumnByName(Fields[i].FieldName);
//     if ExistingColumn<>nil then curColumn.FooterValue:= ExistingColumn.FooterValue;
     curColumn.FooterValue:= ColumnByName(Fields[i].FieldName).FooterValue;
     TempList.Add(curColumn);
  end;

  { Free prior column list - Do after creating new tempList}
  for i:= 0 to ColItems.Count-1 do TwwColumn(ColItems[i]).Free;
  ColItems.Clear;

  { Transfer tempitems over to Items }
  for i:= 0 to TempList.count-1 do ColItems.Add(TempList[i]);
  TempList.Free;

end;

procedure TwwCustomDBGrid.DrawDataCell(const Rect: TRect; Field: TField;
  State: TGridDrawState);
begin
  if Assigned(FOnDrawDataCell) then FOnDrawDataCell(Self, Rect, Field, State);
end;


procedure TwwCustomDBGrid.ProportionalColWidths;//(UpdateTrailing: boolean);
var TotalTempGridWidth: integer;
    GridLineWidth, ColSpace, AvailSpace, i: Integer;
    StartCol: integer;
//    ACount: integer;
    ScrollBarOffset: integer;
    StartGroupCol, EndGroupCol: integer;
    TotalGroupWidth, ChangeWidth: integer;
    MinWidth: integer;
begin
   if OrigColWidths=nil then exit;
   if OrigColWidthsCount<ColCount-1 then exit;
   if UseTfields then exit;
   if selected.count=0 then exit;

//   ShowMessage(Selected[Selected.count-1]);

//   if dgIndicator in Options then ACount:= ColCount-1
//   else ACount:= ColCount;

   if dgColLines in Options then GridLineWidth:= 1
   else GridLineWidth:= 0;

   MinWidth:= Canvas.TextWidth('0') * 2 + 4;

   if FSizingIndex>=0 then
   begin
      TotalTempGridWidth:= -1;
      StartCol:= FSizingIndex;

      // Divide evenly the increase or decrease of the resized column with
      // its fellow group memebers
      // Still need to handle if resized column is in the middle of group.
      // If so, then we need to handle this
      if (Columns[dbCol(FSizingIndex)].GroupName <> '') then
      begin
         GroupNameCellRect(FSizingIndex, 0, StartGroupCol, EndGroupCol, False);
         ChangeWidth:= ColWidths[FSizingIndex] - FPriorSizingWidth; //OrigColWidths[FSizingIndex]; // FOrigSizingWidth;
         TotalGroupWidth:= 0;
         for I := StartGroupCol to EndGroupCol do
         begin
            if i=EndGroupCol then
              TotalGroupWidth:= TotalGroupWidth +
                 FPriorSizingWidth + GridLineWidth
            else
              TotalGroupWidth:= TotalGroupWidth +
                 OrigColWidths[I] + GridLineWidth;
         end;

         if FSizingIndex = EndGroupCol then
         begin
           for I := StartGroupCol to EndGroupCol do
           begin
              if i=EndGroupCol then begin
                ColWidths[i]:= wwMax(MinWidth, FPriorSizingWidth + ChangeWidth);
              end
              else begin
                ColWidths[i]:= wwMax(MinWidth, (OrigColWidths[i] * (TotalGroupWidth + ChangeWidth))
                           div TotalGroupWidth);
              end;
              ChangeWidth:= ChangeWidth - (ColWidths[i]-OrigColWidths[i]);
              TotalGroupWidth:= TotalGroupWidth - OrigColWidths[i];
           end
         end
      end;


      for I := StartCol+1 to ColCount-1 do
         TotalTempGridWidth:= TotalTempGridWidth +
             OrigColWidths[I] + GridLineWidth;
      if TotalTempGridWidth<=0 then exit;
   end
   else begin
      StartCol:= 0; //FIndicatorOffset;
      TotalTempGridWidth:= -1;
      for I := FIndicatorOffset to ColCount-1 do //Count - 1 do
         TotalTempGridWidth:= TotalTempGridWidth +
            OrigColWidths[I] + GridLineWidth;
      if TotalTempGridWidth<=0 then exit;
   end;

{   if UseRightToLeftAlignment then
     IndicatorWidth:= CellRect(StartCol, 0).Right -
                      CellRect(StartCol, 0).Left
   else begin
     IndicatorWidth:= CellRect(StartCol, 0).Right;
     IndicatorWidth:= CellRect(StartCol, 0).right-
                      CellRect(StartCol, 0).Left
   end;
}
   if (dgIndicator in Options) then
   begin
     if UseRightToLeftAlignment then
        AvailSpace:= ClientWidth - (ClientWidth-Cellrect(StartCol, 0).Left) - 2
     else
        AvailSpace:= ClientWidth - Cellrect(StartCol, 0).Right - 2
   end
   else begin
     if FSizingIndex>=0 then
     begin
        if UseRightToLeftAlignment then
           AvailSpace:= ClientWidth - (ClientWidth-Cellrect(StartCol, 0).Left) - 2
        else
           AvailSpace:= ClientWidth - Cellrect(StartCol, 0).Right - 2
     end
     else
        AvailSpace:= ClientWidth-2
   end;

   // If scrollbar not showing but it will be later then adjust
   // AvailSpace and ColWidths later.
   If ShowVertScrollBar and (Width-ClientWidth<10) then
      ScrollBarOffset:= GetSystemMetrics(SM_CXHThumb) + 1
   else ScrollBarOffset:=0;
   AvailSpace:= AvailSpace - ScrollBarOffset;


   if FSizingIndex>=0 then inc(startcol)
   else startcol:= startcol+FIndicatorOffset;

   inc(FUpdatingColWidths);

   try
     for I := startCol to ColCount-1 do
     begin
        if TotalTempGridWidth=0 then continue;
        ColSpace:=
           ((OrigColWidths[I]+1) * AvailSpace) div
           TotalTempGridWidth;

        ColSpace:= ((ColSpace-4) div Canvas.TextWidth('0')) * Canvas.TextWidth('0') + 4;
        ColSpace:= wwMax(MinWidth, ColSpace);

        if i=ColCount-1 then
        begin
  //         ColWidths[I]:= (ClientWidth-ScrollBarOffset)-1-CellRect(I, 0).Left;
           ColWidths[I]:= wwmax(AvailSpace, 0);
        end
        else
           ColWidths[I]:= ColSpace;

        UpdateSelectedProp(Selected, '',
           inttostr(((ColWidths[I]-4) div Canvas.TextWidth('0'))) ,
//         inttostr(((ColSpace-4) div Canvas.TextWidth('0'))) ,
           sptUpdateWidth, I-FIndicatorOffset);

        AvailSpace:= AvailSpace - ColSpace - GridLineWidth;
        TotalTempGridWidth:= TotalTempGridWidth - OrigColWidths[I] - GridLineWidth;
//        OrigColWidths[I]:= ColWidths[I];
     end;
   finally
     dec(FUpdatingColWidths);
   end
end;

procedure TwwCustomDBGrid.SetColumnAttributes;
var
  I: Integer;
  CWidth: Integer;
  parts: TStrings;
  tempField: TField;
  tempCount: integer;
  ResetWidths: boolean;
  AFieldName: string;

  Function GetTitleWidth(lbl: string): integer;
  var APos, currentTitleWidth, lineWidth: integer;
      line: string;
  begin
     APos:= 1;
     lineWidth:= 0;
     while True do begin
	line:= strGetToken(lbl, '~', APos);
	if (line='') and ((APos<=0) or (APos>=length(line))) then break;
	currentTitleWidth:= Canvas.TextWidth(line);
	if currentTitleWidth>LineWidth then lineWidth:= currentTitleWidth;
     end;
     result:= lineWidth + 4;
  end;

  Function GetDisplayWidth: integer;
  begin
     result:= 64; // Give some value
     if useTFields then
     begin
        if (tempField<>nil) then
           result:= tempField.DisplayWidth * Canvas.TextWidth('0') + 4
     end
     else result:= strtoint(parts[1]) * Canvas.TextWidth('0') + 4;
  end;

  Function GetDisplayLabel(index: integer): string;
  begin
     if useTFields then result:= Fields[i].DisplayLabel
     else if parts.count>2 then result:= parts[2] {7/31/97}
     else if tempField<>nil then result:= tempField.DisplayLabel;
  end;

  procedure CleanupControlCache;
  var i: integer;
  begin
     for i:= 0 to FCacheColInfo.count-1 do
       TwwCacheColInfoItem(FCacheColInfo[i]).Free;
     FCacheColInfo.Clear;
  end;


begin
   if datasource=nil then exit;
   if datasource.dataset=nil then exit; {3/15/97}

   if useTFields then TempCount:= FieldCount
   else begin
      TempCount:= selected.Count;
      parts := TStringList.create;
   end;

   ResetWidths:= True;

   if IsProportionalColumns then
   begin
      if (OrigColWidths<>nil) then
      begin
         ResetProportionalWidths;
         OrigColWidths:= PWordArray(AllocMem(SizeOf(Word)*(TempCount+1)));
         OrigColWidthsCount:= TempCount+1;
         ResetWidths:= False;
         for i:= FIndicatorOffset to TempCount-1+FIndicatorOffset do
         begin
            OrigColWidths[i]:= ColWidthsPixels[i];
         end
      end
      else begin
         OrigColWidths:= PWordArray(AllocMem(SizeOf(Word)*(TempCount+1)));
         OrigColWidthsCount:= TempCount+1;
      end
   end;

   for I := 0 to TempCount - 1 do
   begin
       if useTFields then
       begin
         tempField:= Fields[i];
         AFieldName:= tempfield.FieldName;
       end
       else begin
         AFieldName:= FieldName(i+FIndicatorOffset); // Pass absolute column
         strBreakApart(selected[i], #9, parts);
         tempField:= DataSource.DataSet.FindField(parts[0]);
//         if tempField=nil then continue;
       end;
       Canvas.Font := Font;
       CWidth := GetDisplayWidth;
//       { 10/26/98 - Truncate to character }
//       CWidth:= (GetDisplayWidth(i) div Canvas.TextWidth('0')) * Canvas.TextWidth('0');

       if not IsProportionalColumns and
          (dgTitles in Options) and not (dgNoLimitColSize in Options) then
       begin
           Canvas.Font := TitleFont;
              if CWidth < GetTitleWidth(GetDisplayLabel(i)) then
                 CWidth:= GetTitleWidth(GetDisplaylabel(i));
       end;
       if IsProportionalColumns and ResetWidths then
          OrigColWidths[I + FIndicatorOffset] := CWidth
       else
          ColWidths[I + FIndicatorOffset] := CWidth;

       if TempField<>nil then
       begin
          TabStops[I + FIndicatorOffset] := (not TempField.ReadOnly);
          if {(ColumnByName(TempField.FieldName)<>Nil) and }
             (ColumnByName(AFieldName).ReadOnly) then
             TabStops[I + FIndicatorOffset]:= False;

          if TabStops[I + FIndicatorOffset] and (not EditCalculated) then
             TabStops[I + FIndicatorOffset] := (not TempField.Calculated);
       end;
   end;

   if IsProportionalColumns then
      if TempCount>0 then ProportionalColWidths;

{   for I := 0 to TempCount - 1 do
   begin
       TabStops[I + FIndicatorOffset] := (not TempField.ReadOnly);
       if   (ColumnByName(TempField.FieldName).ReadOnly) then
          TabStops[I + FIndicatorOffset]:= False;

       if TabStops[I + FIndicatorOffset] and (not EditCalculated) then
          TabStops[I + FIndicatorOffset] := (not TempField.Calculated);
   end;
}
   if not useTFields then parts.Free;
   CleanupControlCache;
   InitCacheColInfo;
   FSavePrevGridWidth := ClientWidth;

//   FreeMem(TempColWidths);
end;

procedure TwwCustomDBGrid.CalcRowHeight;
var TempDefaultRowHeight: integer;
    RowHeight0: integer;
begin
   if (CurrentCustomEdit is TwwExpandButton) then
      TwwExpandButton(CurrentCustomEdit).Expanded:= False;
   Canvas.Font := Font;

   // Don't set if not changed DefaultRowHeight so we don't have flicker
   TempDefaultRowHeight:= Canvas.Textheight('W') + NormalPad;
   if HaveAnyRowLines then TempDefaultRowHeight:= TempDefaultRowHeight + 1;
   RowHeight0:= TempDefaultRowHeight;

   TempDefaultRowHeight:= (TempDefaultRowHeight * RowHeightPercent) div 100;
   if DefaultRowHeight<>TempDefaultRowHeight then
      DefaultRowHeight:= TempDefaultRowHeight;

   if dgTitles in Options then
   begin
      Canvas.Font := TitleFont;
      if parent is TCustomGrid then  // Make rows a multiple of defaultRowHeight so rows fit evenly
         RowHeights[0] := RowHeight0 * TitleLines + (TitleLines-1)
      else
         RowHeights[0] := Canvas.TextHeight('W') * TitleLines + 4;

      {$ifndef win32}
      rowHeights[0]:= RowHeights[0] + 1;
      {$endif}

      { Increase by 1 in order to show 3D effects }
      if (not HaveAnyRowLines) {and Ctl3D} then
	 rowHeights[0]:= RowHeights[0] + 1;

   end;

   if (dgIndicator in Options) and (FIndicatorButton<>Nil) then
   begin
      TitleTextOffset:= 2 +
         (max(RowHeights[0], FIndicatorButton.height) - rowHeights[0]) div 2;
      if HaveAnyRowLines then
         RowHeights[0]:= max(RowHeights[0], FIndicatorButton.height)-1  {5/09/97 Removed -1}
      else RowHeights[0]:= max(RowHeights[0], FIndicatorButton.height)+1;  {5/09/97 Removed -1}
   end
   else TitleTextOffset:= 2;

end;

procedure TwwCustomDBGrid.SetIndicatorWidth(val: integer);
begin
   if FIndicatorWidth<>val then
   begin
      FIndicatorWidth:= val;
   end
end;

procedure TwwCustomDBGrid.LayoutChanged;
var
  J: Integer;
  PrevVisibleRowCount: integer;
begin
  if csLoading in ComponentState then Exit;
  if not HandleAllocated then Exit;
  if FUpdateLock <> 0 then Exit;
  Inc(FUpdateLock);
  try
    FSavePrevGridWidth := ClientWidth;
    inc(FUpdatingColWidths);
    try
      FTitleOffset := 0;

      // Hide horizontal scrollbars in this special case
      if ShowHorzScrollBar and IsProportionalColumns and
         (ScrollBars in [ssBoth, ssHorizontal]) then
         ShowHorzScrollBar:= ShowHorzScrollBar;

      if dgTitles in Options then FTitleOffset := 1;

      calcRowHeight;

      FIndicatorOffset := 0;
      if dgIndicator in Options then FIndicatorOffset := 1;

      FDatalink.ClearMapping;
      if FDatalink.Active then DefineFieldMap;
      if not useTFields and (FieldCount=0) then j:= Selected.Count
      else J := FieldCount;
      if J = 0 then J := 1;
      inherited ColCount := J + FIndicatorOffset;
      if dgIndicator in Options then ColWidths[0] := FIndicatorWidth;
      if (dgIndicator in Options) and (Col=0) then Col:= 1; {5/31/95 - Avoid }

      HideControls;   {7/18/97 - in case of re-order }
      UpdateRowCount;

      PrevVisibleRowCount:= VisibleRowCount;
      SetColumnAttributes;
      if VisibleRowCount<>PrevVisibleRowCount then UpdateRowCount;  {6/1/95}
      CheckFooterUpdate;
    finally
      dec(FUpdatingColWidths);
    end;
    UpdateActive;
    FSavedCursor := Cursor;   //4/9/2002 - PYW - Preserve Cursor before URLPaint
    ClearURLPaint; // Clear variables for highlight url address

    if AllowPerfectFit then DoPerfectFit;
    Invalidate;
    if PaintOptions<>nil then
    begin
      PaintOptions.Column1Color:= TitleColor;
      PaintOptions.Row1Color:= TitleColor;
    end

  finally
    Dec(FUpdateLock);
  end;
end;

procedure TwwCustomDBGrid.LinkActive(Value: Boolean);
begin

  if not Value then HideEditor;
  LayoutChanged;
  UpdateScrollBar;

  { 1/28/98 - Clear multi-select last record }
  { 4/21/99 - Free ShiftSelectBookmark first }
  {$ifdef wwdelphi4up}
  If Value then begin
     if ShiftSelectBookmark<>Nil then FreeMem(ShiftSelectBookmark);
     ShiftSelectBookmark:= nil;
     ShiftSelectMode:= False;
  end;
  if LastBookmark<>Nil then FreeMem(LastBookmark);
  LastBookmark:= nil;
  if LastMasterBookmark<>Nil then FreeMem(LastMasterBookmark);
  LastMasterBookmark:= nil;
  {$else}
  If Value then begin
     if ShiftSelectBookmark<>Nil then StrDispose(ShiftSelectBookmark);
     ShiftSelectBookmark:= nil;
     ShiftSelectMode:= False;
  end;
  if LastBookmark<>Nil then StrDispose(LastBookmark);
  LastBookmark:= nil;
  if LastMasterBookmark<>Nil then StrDispose(LastMasterBookmark);
  LastMasterBookmark:= nil;
  {$endif}

  if Value then begin
     if (not HandleAllocated) then CallColEnter:= True
     else begin
        if Col<>TempLastCol then ColEnter;
        TempLastCol:= Col;
     end;
     ShouldUpdateFooter:= True; { Update footer first time after active }
  end
  else TempLastCol:= -1;
end;

procedure TwwCustomDBGrid.CreateWnd;
//var SINew: TScrollInfo;
begin
  inherited CreateWnd;

  LayoutChanged;
  UpdateScrollBar;
  DoCheckRowChanged;

//  SINew.cbSize := sizeof(SINew);
//  SINew.fMask:= SIF_DISABLENOSCROLL;
//  SetScrollInfo(Self.Handle, SB_VERT, SINew, False);

  // Support recursive grids
//  if (parent<>nil) and wwIsClass(parent.classtype, 'TCustomGrid') then
//      windows.setparent(self.handle, GetParentForm(self).handle);


end;

function TwwCustomDBGrid.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TwwCustomDBGrid.CanEditAcceptKey(Key: Char): Boolean;
begin
  Result := FDatalink.Active and (FieldCount > 0) and
    Fields[SelectedIndex].IsValidChar(Key);
end;

function TwwCustomDBGrid.GetEditLimit: Integer;
begin
  Result := 0;
  if (FieldCount > 0) and (SelectedField is TStringField) then
    Result := TStringField(SelectedField).Size;
end;

function TwwCustomDBGrid.CanEditModify: Boolean;
var colInfo: TwwColumn;
begin
  Result := False;

  {8/24/98 - Don't allow insert/edit if no records and dgallowinsert is false }
  {10/2/98 - Fix this fix.  Allow editing if editing. }
  if (datasource<>nil) and (datasource.dataset<>nil) and
     (not (dgAllowInsert in KeyOptions)) and
     Datasource.dataset.BOF and datasource.dataset.EOF and
     (datasource.state = dsBrowse) then
  begin
     exit;
  end;

  if not ReadOnly and FDatalink.Active and not FDatalink.Readonly and
    (FieldCount > 0) and
    (Fields[SelectedIndex].CanModify or
    (FEditCalculated and wwisNonPhysicalField(Fields[SelectedIndex]) {5/9/97}
     and not (Fields[SelectedIndex].ReadOnly))) then
  begin
    colInfo:= ColumnByName(Fields[SelectedIndex].FieldName);
    if {(colInfo<>nil) and }(colInfo.ReadOnly) then exit;

    FDatalink.Edit;
    Result := FDatalink.Editing;
    if Result then FDatalink.Modified;
  end;
end;

function TwwCustomDBGrid.GetEditMask(ACol, ARow: Longint): string;
begin
  Result := '';
  if FDatalink.Active and (ACol - FIndicatorOffset < FieldCount) then
    Result := Fields[ACol - FIndicatorOffset].EditMask;
end;

function TwwCustomDBGrid.GetEditText(ACol, ARow: Longint): string;
begin
  Result := '';
  if FDatalink.Active and (ACol - FIndicatorOffset < FieldCount) then
    Result := Fields[ACol - FIndicatorOffset].Text;
  FEditText := Result;
end;

procedure TwwCustomDBGrid.SetEditText(ACol, ARow: Longint; const Value: string);
begin
  FEditText := Value;
end;

function TwwCustomDBGrid.GetFieldCount: Integer;
begin
  Result := FDatalink.FieldCount;
{  if Result=0 then
   result:= Selected.count}
end;

function TwwCustomDBGrid.GetFields(Index: Integer): TField;
begin
  Result := FDatalink.Fields[Index];
end;

procedure TwwCustomDBGrid.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
//  FVDataLink.DataSource:= Value;
  LinkActive(FDataLink.Active);
end;

function TwwCustomDBGrid.GetSelectedField: TField;
begin
  Result := nil;
  if SelectedIndex < FieldCount then Result := Fields[SelectedIndex];
end;

function TwwCustomDBGrid.GetSelectedIndex: Integer;
begin
  Result := Col - FIndicatorOffset;
end;

procedure TwwCustomDBGrid.SetSelectedField(Value: TField);
var
  I: Integer;
begin
  for I := 0 to FieldCount - 1 do
    if Fields[I] = Value then SelectedIndex := I;
end;

procedure TwwCustomDBGrid.SetSelectedIndex(Value: Integer);
begin
  if Value<FixedCols-FIndicatorOffset then
  begin
     FDataLink.UpdateData; // 9/17/02 Allow fixed column to update
     HideControls;
     MoveColRow(Value+FIndicatorOffset, Row, True, False);
     InvalidateEditor;
     ColEnter;
  end
  else MoveCol(Value);
end;

procedure TwwCustomDBGrid.CheckFooterUpdate;
var MasterBookmark: TBookmark;
    MasterSource: TDatasource;
    res: CmpBkmkRslt;
begin
  if not Assigned(FOnUpdateFooter) then exit;
  
  if not HandleAllocated then Exit;
  if (datasource<>nil) and (datasource.state=dsBrowse) then { 10/21/98 - Check datsource<>nil}
  begin
     { If child dataset then update when master moves to a new record }
     if not ShouldUpdatefooter then
     begin
        MasterSource:= wwGetControlDataSource(datasource.dataset);
        if MasterSource=nil then
           MasterSource:= wwGetControlMasterSource(datasource.dataset);
        if (MasterSource<>Nil) and (MasterSource.Dataset<>Nil) then
        begin
           MasterBookmark:= MasterSource.dataset.GetBookmark;
           if MasterBookmark<>nil then { 1/9/98 - Check for nil bookmark }
           begin
              res:= wwDataSetCompareBookmarks(MasterSource.DataSet,
                     MasterBookmark, lastMasterBookmark);
              if CompareBookmarksAltMethod then
              begin
                if (res<>0) then
                   ShouldUpdateFooter:= True;
              end
              else begin
                if (res<>CMPKeyEql) and (res<>CMPEql) then
                   ShouldUpdateFooter:= True;
              end;
              MasterSource.dataset.FreeBookmark(LastMasterBookmark);
              LastMasterBookmark:= MasterBookmark;
           end
        end;
     end;

     { Handles record deletions }
     if not ShouldUpdateFooter then
     begin
        if (lastbookmark<>nil) and
           (not datasource.dataset.bookmarkvalid(lastbookmark)) then
           ShouldUpdateFooter:= True;
     end;

     if ShouldUpdateFooter then DoUpdateFooter;
     ShouldUpdateFooter:= False;
  end;

end;

procedure TwwCustomDBGrid.DataChanged;
//var OldLeftCol: integer;
begin
//  if dgVariableRowHeight in Options then CalcRowHeight;
  if not HandleAllocated then Exit;
  if SkipDataChange then exit;

  CheckFooterUpdate;

  { Fix - (8/25/96) Required when canceling insert with navigator }
  { 2/12/97 - This line used to be after the call to InvalidateEditor }
  { By putting it before UpdateRowCount then screen painting is more optimized }
  { 2/17/99 - Include dsInsert as Hidecontrols case }
  { 3/30/99 - Only include Insert if the dataset is not empty }
  if (not SkipHideControls) and (DataSource.state = dsInsert) and
     not (Datasource.dataset.bof and Datasource.Dataset.eof) then
     HideControls;
  if (not SkipHideControls) and (DataSource.state in [dsBrowse]) then HideControls;


{  if (dgRowSelect in Options) then
  begin
    OldLeftCol:= LeftCol;
    BeginUpdate;
    UpdateRowCount;
    if OldLeftCol<ColCount then LeftCol:= OldLeftCol;
    EndUpdate(False);
  end
  else}
    UpdateRowCount;

  UpdateScrollBar;
  UpdateActive;
  InvalidateEditor;

  { Fix - (8/25/96) Required when canceling insert with navigator }
{  if (not SkipHideControls) and (DataSource.state=dsBrowse) then HideControls;}

  ValidateRect(Handle, nil);
  Invalidate;

  DoCheckRowChanged;
end;

procedure TwwCustomDBGrid.EditingChanged;
begin
  if dgIndicator in Options then InvalidateCell(0, FSelRow);
end;

procedure TwwCustomDBGrid.RecordChanged(Field: TField);
var
  R: TRect;
  InvBegin, InvEnd: Integer;
begin
  if not HandleAllocated then Exit;

  InvBegin := 0;
  if Field = nil then InvEnd := ColCount - 1 else
  begin
    for InvBegin := 0 to FieldCount - 1 do
      if Fields[InvBegin] = Field then Break;
    InvEnd := InvBegin;
  end;
  R := BoxRect(InvBegin + FIndicatorOffset, Row, InvEnd + FIndicatorOffset,
    Row);
  InvalidateRect(Handle, @R, False);
  if ((Field = nil) or (SelectedField = Field)) and
    (SelectedIndex<FieldCount) and  { 6/17/97}
    (Fields[SelectedIndex].Text <> FEditText) then
  begin
    InvalidateEditor;
    if InplaceEditor <> nil then InplaceEditor.Deselect;
  end;

end;

procedure TwwCustomDBGrid.FieldChanged(Field: TField);
begin
  DoFieldChanged(Field);
end;

procedure TwwCustomDBGrid.DoFieldChanged(Field: TField);
begin
  if Assigned(FOnFieldChanged) then
     FOnFieldChanged(self, Field);
end;

{function TwwCustomDBGrid.Edit: Boolean;
begin
  Result := False;
  if not ReadOnly then
  begin
    FDataChanged := False;
    FEditRequest := True;
    try
      FDataLink.Edit;
    finally
      FEditRequest := False;
    end;
    Result := FDataChanged;
  end;
end;
}
procedure TwwCustomDBGrid.Scroll(Distance: Integer);
var
  OldRect, NewRect: TRect;
  RowHeight: Integer;
begin
  if not HandleAllocated then Exit;  { 6/2/97}
{  if dgVariableRowHeight in Options then UpdateRowCount;
  if (Distance<>0) then
  begin
    if dgVariableRowHeight in Options then CalcRowHeight;
  end;
}
  // Adjust for child grid
//  Row:= FDataLink.ActiveRecord+FTitleOffset;
//  RowOffset:= 0;

  OldRect := BoxRect(0, Row, ColCount - 1, Row);
  UpdateScrollBar;
  UpdateActive;
  NewRect := BoxRect(0, Row, ColCount - 1, Row);
//  NewRect.Bottom:= NewRect.Bottom + 1;  // In case of scrolling
  ValidateRect(Handle, @OldRect);
  InvalidateRect(Handle, @OldRect, False);
  InvalidateRect(Handle, @NewRect, False);

  {$ifdef win32}
  HideEditor;  { 10/20/96 - Always hide editor if this method is called }
  {$endif}

  if Distance <> 0 then
  begin
    {$ifndef win32}
    HideEditor;
    {$endif}

    HideControls;
    try
      if Abs(Distance) > VisibleRowCount then
      begin
	{ Update bookmarks }
	Invalidate;
	Exit;
      end
      else
      begin
	RowHeight := DefaultRowHeight;
	if HaveAnyRowLines then Inc(RowHeight);

        if odd(Distance) then AlternatingEven:=not AlternatingEven;
        if not PaintOptions.FastRecordScrolling then
        begin
           if not (dgTitles in Options) then begin
              NewRect := BoxRect(0,0,ClientWidth,ClientHeight);
           end else
              NewRect := BoxRect(0,FTitleOffset,ClientWidth,ClientHeight);
           InvalidateRect(Handle, @NewRect, False);
        end
        else begin
           // Include Indicator Column.
           NewRect := BoxRect(0, FTitleOffset, ColCount - 1, 1000);
//           NewRect := BoxRect(FIndicatorOffset, FTitleOffset, ColCount - 1, 1000);
           { 12/8/97 - Use ScrollWindowEx so background isn't cleared before painting }

           ScrollWindowEx(Handle, 0, -RowHeight * Distance, @NewRect, @NewRect,
              0, nil, SW_Invalidate);
(*           if (dgHideBottomDataLine in Options) then // Bottom of scroll area needs to be invalidated when scrolling
           begin
             NewRect.Top:= NewRect.Bottom;
             NewRect.Bottom:= NewRect.Bottom + 1;
             InvalidateRect(Handle, @NewRect, False);
           end;
*)
           if dgIndicator in Options then
           begin
              OldRect := BoxRect(0, FSelRow, ColCount - 1, FSelRow);
              InvalidateRect(Handle, @OldRect, False);
              NewRect := BoxRect(0, Row, ColCount - 1, Row);
              InvalidateRect(Handle, @NewRect, False);
           end;
        end
      end;
    finally {1/2/96 - Don't show editor for memo}
      if (dgAlwaysShowEditor in Options) and (not isWWControl(col, row)) and
	 (not isMemoField(Col, Row)) then
	 ShowEditor;
    end;
  end;
//  if (not SuppressShowEditor) and visible then Update;
  if (Distance<>0) then DoTopRowChanged;
  DoCheckRowChanged;
end;

procedure TwwCustomDBGrid.DoTopRowChanged;
begin
   if Assigned(FOnTopRowChanged) then FOnTopRowChanged(self);
end;

procedure TwwCustomDBGrid.DoRowChanged;
begin
   if Assigned(FOnRowChanged) then FOnRowChanged(self);
   DoCellChanged;
end;

procedure TwwCustomDBGrid.DoCheckRowChanged;
var curBookmark: TBookmark;
    res: CmpBkmkRslt;
    tempDisable: boolean;
begin
//   if GetColField(dbCol(Col))<>Nil then
//      OriginalCellText:= GetColField(dbCol(Col)).asString
//   else OriginalCellText:= '';

   tempDisable:= DisableCellChangedEvent;
   try
      if (Datasource<>nil) and (Datasource.dataset<>Nil) and
         (Datasource.dataset.active) and
         (Assigned(FOnRowChanged) or
          Assigned(FOnCellChanged) or
          Assigned(FOnUpdateFooter)) then
      begin
         curBookmark:= Datasource.dataset.GetBookmark;
         if lastBookmark=nil then begin
            DoRowChanged;
            DisableCellChangedEvent:= True;
         end
         else if curBookmark<>nil then begin { 11/24/98 - Check for nil curbookmark }
            res:= wwDataSetCompareBookmarks(DataSource.DataSet, curBookmark, lastBookmark);
            if CompareBookmarksAltMethod then
            begin
              if (res<>0) then
              begin
                 DoRowChanged;
                 DisableCellChangedEvent:= True;
              end
            end
            else if (res<>CMPKeyEql) and (res<>CMPEql) then begin
               DoRowChanged;
               DisableCellChangedEvent:= True;
            end
         end
         else if (datasource.state=dsInsert) then begin { 1/31/99 - Support OnRowChanged for insert }
            if (lastBookmark<>nil) then begin
               DoRowChanged;
               DisableCellChangedEvent:= True;
            end
         end;

         if lastbookmark<>nil then Datasource.dataset.FreeBookmark(lastBookmark);
         lastBookmark:= curBookmark;
      end;

      if CallColEnter then begin
         CallColEnter:= False;
         ColEnter;
         DoUpdateFooter;
      end;
   finally
      DisableCellChangedEvent:= tempDisable;
   end;

   FreeHintWindow;

end;

procedure TwwCustomDBGrid.TitleFontChanged(Sender: TObject);
begin
  if (not FSelfChangingTitleFont) and not (csLoading in ComponentState) then
    ParentFont := False;
  if dgTitles in Options then LayoutChanged;
end;

procedure TwwCustomDBGrid.UpdateData;
var NewDate, NewTime: TDateTime;
    editor: TwwInplaceEdit;
    FOnInvalidValue: TwwInvalidValueEvent;
    curField: TField;
    FloatValue: Extended;
begin
   if (InplaceEditor <> nil) then
   begin
      editor:= TwwInplaceEdit(InplaceEditor);
      if (editor.HavePictureMask) and FDataLink.isFieldModified and
	 (not editor.IsValidPictureValue(editor.Text)) and
	    (not editor.Picture.AllowInvalidExit) then
      begin
//	 editor.SelectAll;
//	 editor.SetFocus;
//	 FDataLink.Modified; {SetFocus clears modified so set it back to true }

         {7/3/97 - Use OnInvalidValue }
         FOnInvalidValue := wwGetOnInvalidValue(FDataLink.DataSet);
         if Assigned(FOnInvalidValue) then
         begin
            FOnInvalidValue(FDataLink.DataSet, GetColField(dbCol(Col)));
         end
         else ValidationErrorUsingMask(GetColField(dbCol(Col)));

	 exit;
      end
   end;


  if FieldCount > 0 then with Fields[SelectedIndex] do
  begin
     curField:= Fields[SelectedIndex];

     { Handle 2 digit year logic }
     if (self is TwwDBGrid) then
        TwwDBGrid(self).Patch[0]:= (Text=FEditText); { 9/24/98 - Prevent recursion by comparing text}

     if (Fields[SelectedIndex] is TDateTimeField) and
        wwStrToDate(FEditText) then
     begin
        { Uses 1950 as Epoch Date for 2 digt years }
        if wwScanDate(FEditText, NewDate) then { 10/12/98 - Avoid converting 4 digit years}
        begin
           NewTime:= Frac(StrToDateTime(FEditText));
           TDateTimeField(Fields[SelectedIndex]).asDateTime:= NewDate + NewTime;
        end;
     end
     else begin
{        if JustHaveLiteralTemplate then
           Clear
        else}
        if ((curField is TIntegerField) or
           (curField is TFloatField)) and
           (FEditText<>'') and // If text is blank then don't do formatting code
          (TNumericField(curField).DisplayFormat<>'') then
        begin
            if wwStrToFloat2(FEditText, FloatValue, TNumericField(curField).DisplayFormat) then
            begin
               if curField is TFloatField then
                  curField.asFloat:= FloatValue
               else if curField is TIntegerField then begin
                  curField.asInteger:= Round(FloatValue)
               end
           end
           else Text := FEditText;
        end
        else
           Text := FEditText;
     end;

     if (self is TwwDBGrid) and (TwwDBGrid(self).Patch[0]=False) then
        FieldChanged(Fields[SelectedIndex]); { 9/2/98 }
  end
end;

procedure TwwCustomDBGrid.UpdateActive;
var
  NewRow: Integer;
begin
  if FDatalink.Active then
  begin
    NewRow := FDatalink.ActiveRecord + FTitleOffset + RowOffset;
    if Row <> NewRow then
    begin
      if not (dgAlwaysShowEditor in Options) then HideEditor;
      if NewRow>VisibleRowCount then
      begin
	 UpdateRowCount; { Avoid index out of range }
	 NewRow:= VisibleRowCount + FTitleOffset - 1;  { 12/7/96 - Subtract 1 }
      end;
      {$ifdef win32}
      MoveColRow(Col, NewRow, False, False);
      {$else}
      Row := NewRow;
      {$endif}
    end;
    { 2/21/2000 - Fix bug introduced by Delphi 5 Patch 1 - Need to make sure this code is not executed for lookupcombo  }
    if not wwIsClass(parent.classtype, 'TwwDBCustomLookupcombo') then begin
      if (SelectedIndex>=0) and
         (FieldCount > 0) and (Fields[SelectedIndex].Text <> FEditText) then
        InvalidateEditor;
    end
  end;
end;

function TwwCustomDBGrid.GetColField(ACol: Integer): TField;
begin
  Result := nil;
  if (ACol >= 0) and FDatalink.Active and (ACol < FDataLink.FieldCount) then
    Result := FDatalink.Fields[ACol];
end;

function TwwCustomDBGrid.GetFieldValue(ACol: Integer): string;
var
  Field: TField;
begin
  Result := '';
  Field := GetColField(ACol);
  if Field <> nil then Result := Field.DisplayText;
end;

function TwwCustomDBGrid.RecordCountIsValid: boolean;
begin
  result:=
     (FDataLink<>nil) and
     FDatalink.Active and (FDataLink.DataSet<>nil) and
     FDataLink.Dataset.Active;
end;

procedure TwwCustomDBGrid.UpdateScrollBar;
var
  sequencable: boolean;
  SIOld, SINew: TScrollInfo;
begin
  if not FShowVertScrollBar then exit;

  //2/1/2001 - Add check to see if dataset is active as well. (PYW)
  if FDatalink.Active and FDataLink.Dataset.Active and HandleAllocated then
  begin
    { Set scroll bar precisely }
    sequencable:= FDataLink.DataSet.isSequenced;
    if sequencable then FDataLink.DataSet.UpdateCursorPos;

    { Support proportional scrollbar }
    SIOld.cbSize := sizeof(SIOld);
    SIOld.fMask := SIF_ALL;
    GetScrollInfo(Self.Handle, SB_VERT, SIOld);
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
       SetScrollInfo(Self.Handle, SB_VERT, SINew, True);
    end
  end

end;
{
function TwwCustomDBGrid.CalcVariableRowCount: integer;
var TotalRowHeight: integer;
    i: Integer;
    NewActiveRecord, OldActiveRecord, shiftamount: integer;
begin
   if dgVariableRowHeight in Options then
   begin
     TotalRowHeight:= RowHeights[0];
     if FVDataLink.Active then begin
       OldActiveRecord:= DataLink.ActiveRecord;
       NewActiveRecord:= FVDataLink.ActiveRecord;
       ShiftAmount:= NewActiveRecord-OldActiveRecord;

       // Increase buffercount so that later rows can be checked.
       FVDataLink.BufferCount:=
          FVDataLink.BufferCount + ShiftAmount;
       NewActiveRecord:= FVDataLink.ActiveRecord;
       ShiftAmount:= NewActiveRecord-OldActiveRecord;

       for i:= 0 to FVDataLink.RecordCount-1 do begin
         FVDataLink.ActiveRecord:= i+ShiftAmount;
         if odd(datasource.dataset.fieldbyname('customer no').asinteger) then
            TotalRowHeight:= TotalRowHeight + 15 + 2
         else
            TotalRowHeight:= TotalRowHeight + 45 + 2;
         if TotalRowHeight>ClientHeight then break;
         if i+ShiftAmount>=FVDataLink.RecordCount then break;
       end;
       FVDataLink.ActiveRecord:= NewActiveRecord;
       result:= i+1;
     end
     else result:= RowCount;


   end;
end;
}

procedure TwwCustomDBGrid.UpdateRowCount;
var OldLeftCol: integer;
//    TempUpdateRect: TRect;
begin
  if InUpdateRowCount then exit;  { Prevent recursion }
  InUpdateRowCount:= True;
  OldLeftCol:= 1; { Make compiler happy}

  if (dgRowSelect in Options) or
     ((dgFixedEditable in Options) and(LeftCol<=FixedCols)) then
  begin
    OldLeftCol:= LeftCol;
//    Windows.GetUpdateRect(Handle, tempUpdateRect, false);
    BeginUpdate;
  end;

  if RowCount <= FTitleOffset then RowCount := FTitleOffset + 1;
  FixedRows := FTitleOffset;
  with FDataLink do
    // 12/12/01 - Set rowcount to 1+FTitleOffset if recordcount is not valid
    // Otherwise can set rowcount to 0, which is not desirable in this case.
    if (not Active) or (not RecordCountIsValid) or (RecordCount = 0) then
//    if (not Active) or (RecordCountIsValid and (RecordCount = 0)) then
      RowCount := 1 + FTitleOffset
    else
    begin
      RowCount := 1000;

      {6/23/97 - Toprow has changed so repaint grid }
      if (FDataLink.Buffercount>VisibleRowCount) and (row>=VisibleRowCount+FTitleOffset) then
      begin
         invalidate;
         DoTopRowChanged;
      end;

{      if dgVariableRowHeight in Options then
      begin
        FVDataLink.BufferCount:= ClientHeight div DefaultRowHeight;
        FDataLink.BufferCount := CalcVariableRowCount -1;
        RowCount := RecordCount + 1 + FTitleOffset;
      end
      else begin
}
        FDataLink.BufferCount := VisibleRowCount;
        RowCount := RecordCount + FTitleOffset {-RowOffset};
{      end;}
      UpdateActive;
    end;

  if (dgRowSelect in Options) or
     ((dgFixedEditable in Options) and(LeftCol<=FixedCols)) then
  begin
    UpdateRowCount;
    if OldLeftCol<ColCount then LeftCol:= OldLeftCol;
    EndUpdate(False);
//    InvalidateRect(Handle, @TempUpdateRect, False);
    Invalidate;
  end;
  InUpdateRowCount:= False;
end;

function TwwCustomDBGrid.AcquireFocus: Boolean;
begin
  Result := True;
  if FAcquireFocus and CanFocus and not (csDesigning in ComponentState) then
  begin
    SetFocus;
    Result := Focused or (InplaceEditor <> nil) and InplaceEditor.Focused;
  end;
end;

procedure TwwCustomDBGrid.CMParentFontChanged(var Message: TMessage);
begin
  inherited;
  if ParentFont then
  begin
    FSelfChangingTitleFont := True;
    try
      TitleFont := Font;
    finally
      FSelfChangingTitleFont := False;
    end;
    LayoutChanged;
  end;
end;

Function TwwCustomDBGrid.AllowCancelOnExit: boolean;
begin
   result:= True;
end;

procedure TwwCustomDBGrid.CMEnter(var Message: TCMEnter);
begin
  inherited;
  FFocused:= True;
  if (PaintOptions.ActiveRecordColor<>clNone) and
     not (dgAlwaysShowSelection in Options) then
     InvalidateCurrentRow;

  if KeyHook=0 then
     KeyHook := SetWindowsHookEx(WH_KEYBOARD, @wwHookKeyProc, HINSTANCE, GetCurrentThreadID);

end;

procedure TwwCustomDBGrid.CMExit(var Message: TMessage);
begin
   if (keyHook<>0) and not (parent is TCustomGrid) then
   begin
     UnhookWindowsHookEx(keyHook);
     keyHook:= 0;
   end;

  try
    if FDatalink.Active then
      with FDatalink.Dataset do
	if (dgCancelOnExit in Options) and (State = dsInsert) and
	  not Modified and not FDatalink.FModified and AllowCancelOnExit then
	  Cancel else
	  FDataLink.UpdateData;
    if not (dgAlwaysShowSelection in Options) then InvalidateCurrentRow;
  except
    SetFocus;
    // 1/9/2002 - Call raise when patch variable set to allow messages from onvalidate to fire when focus exits grid.
    if (FDatalink.FGrid<>nil) and (FDataLink.FGrid is TwwDBGrid) and TwwDBGrid(FDatalink.FGrid).Patch[5] then raise
    else exit;  { Raise causes problems with Delphi being confused on who has focus }
//    raise;
  end;
  inherited;
  FFocused:= False;

end;

procedure TwwCustomDBGrid.CMFontChanged(var Message: TMessage);
begin
  inherited;
  LayoutChanged;
end;

procedure TwwCustomDBGrid.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
  inherited;
  if Msg.Result = 0 then
    with MouseCoord(Msg.Pos.X, Msg.Pos.Y) do
      if (X >= FIndicatorOffset) and (Y < FTitleOffset) then Msg.Result := 1;
  if (Msg.Result = 1) and ((FDataLink = nil) or FDataLink.DefaultFields or
    not FDataLink.Active) then
    Msg.Result := 0;
end;

procedure TwwCustomDBGrid.WMSetCursor(var Msg: TWMSetCursor);
begin
  if (csDesigning in ComponentState) and ((FDataLink = nil) or
    not FDataLink.Active) then
    Windows.SetCursor(LoadCursor(0, IDC_ARROW))
  else inherited;
end;

procedure TwwCustomDBGrid.WMSize(var Message: TWMSize);
begin
  CollapseChildGrid;  // Don't show child grid when resizing grid

  if IsProportionalColumns then
  begin
     if ColCount-FIndicatorOffset>0 then begin
       // 6/13/2001- PYW-Add ability to keep FixedColumns to remain the same width when resizing grid.
       if (dgFixedProportionalResize in Options) and (FixedCols > 1) then begin
          FSizingIndex := FixedCols-1;
          ProportionalColWidths; // Called too often!
          FSizingIndex := -1;
       end
       else
         ProportionalColWidths; // Called too often!
     end;
  end;
{
     if (FSavePrevGridWidth <> ClientWidth) and (FieldCount > 0) then begin
        if dgIndicator in Options then begin
           startcol := 1;
           sFactor := (ClientWidth-4-ColWidthsPixels[0])/(FSavePrevGridWidth-4-ColWidthspixels[0]);
        end
        else begin
           startcol := 0;
           sFactor := (ClientWidth-4)/(FSavePrevGridWidth-4);
        end;
        for i:= startcol to ColCount-1 do
          ColWidthsPixels[i]:=Trunc((ColWidthsPixels[i]*sFactor)+0.5);
     end;
     FSavePrevGridWidth := ClientWidth;
  end
  else ProportionalColWidths(ColCount-FIndicatorOffset);  // Called too often!
}

  inherited;
  if FUpdateLock = 0 then
  begin
     HideControls;   {10/9/96 - in case of resize}
     HideEditor;     {10/9/96 - in case of resize }
     UpdateRowCount;
     if AllowPerfectFit then DoPerfectFit;

     { 9/2/98 - Fix bug where footer is not cleared when maximizing}
     if (Datasource<>nil) and (datasource.dataset<>nil) and
        (FDataLink<>Nil) and (FDataLink.Active) and
        (Datasource.dataset.bof and datasource.dataset.eof) then Invalidate;
  end;
  PaintOptions.InitBlendBitmapsFlag:= True;

  if useRightToLeftAlignment then
  begin
    if IndicatorButton<>nil then
      with IndicatorButton do
         SetBounds(Left, Top, Width, Height);
  end;

end;

Function TwwCustomDBGrid.IsScrollBarVisible: boolean;
  function getWidth: integer;
  var i: integer;
      CWidth: Integer;
      tempGridLineWidth: integer;
  begin
     if dgColLines in Options then tempGridLineWidth:= GridLineWidth
     else tempGridLineWidth:= 0;

     cWidth:= 1;
     if ShowVertScrollBar then cwidth:= GetSystemMetrics(SM_CXHThumb) + 1;
     for i:= 0 to ColCount-1 do
	CWidth:= CWidth + ColWidths[i] + TempGridLineWidth;
     result:= CWidth;
  end;
begin
    if (GetWidth > Width) then
    begin
       if ScrollBars in [ssBoth, ssHorizontal] then
//       if ShowHorzScrollBar then
	  result:= True
       else result:= False;
    end
    else result:= False;
end;

Function TwwCustomDBGrid.AllowPerfectFit: boolean;
begin
   result:= False;
   if not (Align in [alTop, alBottom, alClient]) and
      (dgPerfectRowFit in Options) then
      if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
	 result:= True;
end;

Function TwwCustomDBGrid.DoPerfectFit: boolean;
var newHeight: integer;
    NextToBottomCell: TRect;
    BottomCellTop: integer;
    offset: integer;
    ScrollBarVisible: boolean;
begin
//   if dgVariableRowHeight in Options then exit;
   NextToBottomCell:= CellRect(0, RowCount-1);
   BottomCellTop:= NextToBottomCell.Top + DefaultRowHeight + 1;
   newHeight:= Height;
   ScrollBarVisible:=  isScrollBarVisible;
   {$ifdef win32}
   if ScrollBarVisible then offset:= 5
   else offset:= 4;
   if not Ctl3D then offset:= offset - 3;
   {$else}
   if ScrollBarVisible then offset:= 3
   else offset:= 2;
   if not (HaveAnyRowLines) then offset:= offset - 1;
   {$endif}
   if (ScrollBarVisible) then begin
      if ((BottomCellTop + GetSystemMetrics(SM_CYHSCROLL) + DefaultRowHeight + offset - 1)>self.height) then
      begin
	 newHeight:= BottomCellTop + GetSystemMetrics(SM_CYHSCROLL) + offset - 1;
      end
   end
   else begin
      if ((BottomCellTop + DefaultRowHeight + offset)>self.height) then
      begin
	 newHeight:= BottomCellTop + offset;
      end
   end;

   { Auto-shrink grid height}
   if (newHeight<>height) then begin
      height:= newHeight;
      result:= True;
   end
   else result:= False;
end;

Function TwwCustomDBGrid.DoShrinkToFit: boolean;
var newHeight: integer;
    NextToBottomCell: TRect;
    BottomCellTop: integer;
//    offset: integer;
    ScrollBarVisible: boolean;
begin
//   if dgVariableRowHeight in Options then exit;
   NextToBottomCell:= CellRect(0, RowCount-1);
   BottomCellTop:= NextToBottomCell.Top + DefaultRowHeight + 1;
   ScrollBarVisible:=  isScrollBarVisible;
//   if ScrollBarVisible then offset:= 5
//   else offset:= 4;
   if (ScrollBarVisible) then begin
      newHeight:= BottomCellTop + GetSystemMetrics(SM_CYHSCROLL) + 1;
   end
   else begin
      newHeight:= BottomCellTop + 1;
   end;

   newheight:= newheight + GetEffectiveFooterHeight;

   { Auto-shrink grid height}
   if (newHeight<height) then begin
      height:= newHeight;
      result:= True;
   end
   else result:= False;
end;

procedure TwwCustomDBGrid.WMVScroll(var Message: TWMVScroll);
  procedure NextRow;
  begin
    with FDatalink.Dataset do
    begin
      if (State = dsInsert) and not Modified and not FDatalink.FModified then
	if EOF then Exit else Cancel
      else begin
	 { Already pointing to end of table but active record is before this. 10/15/96 - dsInsert should not increment}
	 if Eof and (FDataLink.ActiveRecord>=0) and
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
    flag:boolean;
  begin
     flag := False;
     with FDataLink.DataSet do begin
        { Support proportional scrollbar }
        SI.cbSize := sizeof(SI);
        SI.fMask := SIF_ALL;
        GetScrollInfo(Self.Handle, SB_VERT, SI);
        CheckBrowseMode;
        // 4/4/2002-PYW-Check if Trackbar has moved.  If so, then need to call DoTopROwChanged.
        if SI.nTrackPos <> RecNo then flag := True;
        if SI.nTrackPos <= 1 then First
        else if SI.nTrackPos >= RecordCount then Last
        else RecNo := SI.nTrackPos;
        Resync([]);
        if flag then DoTopRowChanged;
     end;
  end;

begin
  if CurrentCustomEdit<>nil then CurrentCustomEdit.Left:= ClientWidth+10;

  if not AcquireFocus then Exit;
  if FDatalink.Active then
    with Message, FDataLink.DataSet, FDatalink do
      case ScrollCode of
	SB_LINEUP: PriorRow;
	SB_LINEDOWN: NextRow;
	SB_PAGEUP: MoveBy(-VisibleRowCount);
	SB_PAGEDOWN: MoveBy(VisibleRowCount);
	SB_THUMBPOSITION:
	  begin
	    if Sequencable then begin
               ParadoxPosition;
	    end
	    else begin
	       case Pos of
		 0: First;
		 1: MoveBy(-VisibleRowCount);
		 2: exit;
		 3: MoveBy(VisibleRowCount);
		 4: Last;
	       end;
	    end
	  end;

	SB_BOTTOM: Last;
	SB_TOP: First;
      end;
end;

function TwwCustomDBGrid.HighlightCell(DataCol, DataRow: Integer;
  const Value: string; AState: TGridDrawState): Boolean;
begin
  Result := (gdSelected in AState) or
            ((DataRow=dbRow(Row)) and (PaintOptions.ActiveRecordColor<>clNone));// (dgRowSelectEditable in Options));
  if Result then
  begin
     if not ((dgAlwaysShowSelection in Options) or
        (FFocused and not IsDropDownGridFocused)) then Result:= False;
  end;
//  Result := (gdSelected in AState) and ((dgAlwaysShowSelection in Options) or
//    (FFocused and not IsDropDownGridFocused));
  if (dgMultiSelect in Options) and not (gdFixed in AState) then { 2/21/99 - RSW, Don't highlight if fixed }
  begin
     result:= isSelectedRow(DataRow);
  end
end;

function TwwCustomDBGrid.UseRightToLeftAlignmentForField(const AField: TField;
  Alignment: TAlignment): Boolean;
begin
  Result := False;
  if IsRightToLeft then
    Result := OkToChangeFieldAlignment(AField, Alignment);
end;

procedure TwwCustomDBGrid.DefaultDrawDataCell(const Rect: TRect; Field: TField;
  State: TGridDrawState);
//const
//  Formats: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT,
//    DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX);
var
  Alignment: TAlignment;
  Value: string;
  ACol: integer;
  curField: TField;
  WriteOptions: TwwWriteTextOptions;
  CustomControl: TWinControl;
begin
  for ACol:= 0 to colCount-1 do begin
     curField:= GetColField(ACol);
     if curField=Nil then continue;
     if curField = Field then break;
  end;
//  if TwwCacheColInfoItem(FCacheColInfo[ACol+FIndicatorOffset]).ControlType<>'' then exit;
  if (TwwCacheColInfoItem(FCacheColInfo[ACol+FIndicatorOffset]).ControlType<>'') then
  begin
     CustomControl := TwwCacheColInfoItem(FCacheColInfo[ACol+FIndicatorOffset]).CustomControl;

     if (CustomControl=nil) then exit; // i.e. imageindex, checkbox, etc.

     // 3/14/02 - Only exit for alwayspaints or in all cases for certain Infopower controls
     if
       wwIsClass(CustomControl.classType, 'TwwExpandButton') or
       wwIsClass(CustomControl.classType, 'TwwRadioGroup') or
       wwIsClass(CustomControl.classType, 'TwwCheckbox') or
       wwIsClass(CustomControl.classType, 'TwwMonthCalendar') then exit;
  end;

  Alignment := taLeftJustify;
  Value := '';
  if Field <> nil then
  begin
    Alignment := Field.Alignment;
    Value := Field.DisplayText;
  end;
  WriteOptions:= [];
//  if (Field<>nil) and
//      UseRightToLeftAlignmentForField(Field, Alignment) then
//     WriteOptions:= WriteOptions + [wtoRightToLeft];
  wwWriteTextLines(Canvas, Rect, 2, 2, PChar(Value), Alignment, WriteOptions);
end;

  Function TwwCustomDBGrid.CellColor(ACol, ARow: integer): TColor;
  begin
     result:= Color;
  end;

    procedure TwwCustomDBGrid.DrawCheckBox_Checkmark(ARect: TRect; ACol, ARow:
      integer; val: boolean);
    const ItemChecked: array[Boolean] of Integer = (0, DFCS_CHECKED);
          CheckBoxFlat: array[Boolean] of Integer = (0, DFCS_FLAT);
          CheckboxDisabled: array[Boolean] of Integer = (0, DFCS_INACTIVE);
    var temp: integer;
        {$ifdef wwDelphi7Up}
        Details: TThemedElementDetails;
        CheckboxStyle: TThemedButton;
        PaintRect: TRect;
        {$endif}
    begin
       ARect.Left:= ARect.Left - 1;
       ARect.Top:= ARect.Top - 1;
       ARect.Right:= ARect.Right + 2;
       ARect.Bottom:= ARect.Bottom + 2;
       if useRightToLeftAlignment then // 6/29/02 - Workaround bug in DrawFrameControl with bidi mode
       begin
          temp:= ARect.Left;
          ARect.Left:= ARect.Right-1;
          ARect.Right:= ARect.Right + ARect.Right-temp-1;
       end;

//    tbCheckBoxUncheckedNormal, tbCheckBoxUncheckedHot, tbCheckBoxUncheckedPressed, tbCheckBoxUncheckedDisabled,
//    tbCheckBoxCheckedNormal, tbCheckBoxCheckedHot, tbCheckBoxCheckedPressed, tbCheckBoxCheckedDisabled,
//    tbCheckBoxMixedNormal, tbCheckBoxMixedHot, tbCheckBoxMixedPressed, tbCheckBoxMixedDisabled,

       if wwUseThemes(self) then
       begin
         {$ifdef wwDelphi7Up}
         if ColumnByName(GetColField(dbCol(ACol)).FieldName).ReadOnly then
         begin
            if val then CheckboxStyle:= tbCheckboxCheckedDisabled
            else CheckboxStyle:= tbCheckboxUnCheckedDisabled
         end
         else begin
            if val then CheckboxStyle:= tbCheckboxCheckedNormal
            else CheckboxStyle:= tbCheckboxUnCheckedNormal
         end;
         Details := ThemeServices.GetElementDetails(CheckboxStyle);
         PaintRect := ARect;
         ThemeServices.DrawElement(Canvas.Handle, Details, PaintRect);
         PaintRect := ThemeServices.ContentRect(Canvas.Handle, Details, PaintRect);
         {$endif}
       end
       else begin
         DrawFrameControl(Canvas.Handle, ARect,
           DFC_BUTTON,
           DFCS_BUTTONCHECK or ItemChecked[val] or
           CheckboxFlat[wwInternational.CheckBoxInGridStyle=cbStyleCheckmarkFlat] or
           CheckboxDisabled[ColumnByName(GetColField(dbCol(ACol)).FieldName).ReadOnly]);
       end
    end;

  procedure TwwCustomDBGrid.DrawCheckBox(ARect: TRect; ACol, ARow: integer; val: boolean);
  const CheckboxDisabled: array[Boolean] of Integer = (0, DFCS_INACTIVE);
  var ACanvas : TCanvas;
      tempRect: TRect;
      temp: integer;
  begin
      if (wwInternational.CheckBoxInGridStyle in [cbStyleCheckmark, cbStyleCheckmarkFlat]) or
         (NewStyleControls and (wwInternational.CheckBoxInGridStyle=cbStyleAuto)) then
      begin
         DrawCheckBox_Checkmark(ARect, ACol, ARow, val);
         exit;
      end;

      tempRect:= Rect(ARect.Left-1, ARect.Top-1, ARect.Right+2, ARect.Bottom+2);
      if useRightToLeftAlignment then // 6/29/02 - Workaround bug in DrawFrameControl with bidi mode
      begin
         temp:= TempRect.Left;
         tempRect.Left:= TempRect.Right-1;
         tempRect.Right:= tempRect.Right + (tempRect.Right-temp-1);
      end;

      DrawFrameControl(Canvas.Handle, TempRect,
           DFC_BUTTON,
           DFCS_BUTTONCHECK or
           CheckboxDisabled[ColumnByName(GetColField(dbCol(ACol)).FieldName).ReadOnly]);

      ACanvas:= Canvas;
      ACanvas.Pen.Width:= 1;
      if val then begin
	 ACanvas.Pen.Color:= clBlack;

         { Draw checkbox lines }
	 ACanvas.MoveTo(ARect.right-2, ARect.Top+2);
	 ACanvas.LineTo(ARect.left+1, ARect.Bottom-1);
	 ACanvas.MoveTo(ARect.right-3, ARect.Top+2);
	 ACanvas.LineTo(Arect.left+1, ARect.Bottom-2);
	 ACanvas.MoveTo(ARect.right-2, ARect.Top+3);
	 ACanvas.LineTo(ARect.left+2, ARect.Bottom-1);

	 ACanvas.MoveTo(ARect.left+2, ARect.Top+2);
	 ACanvas.LineTo(ARect.right-1, ARect.Bottom-1);
	 ACanvas.MoveTo(ARect.left+3, ARect.Top+2);
	 ACanvas.LineTo(ARect.right-1, ARect.Bottom-2);
	 ACanvas.MoveTo(ARect.left+2, ARect.Top+3);
	 ACanvas.LineTo(ARect.right-2, ARect.Bottom-1);
     end;
  end;

  procedure TwwCustomDBGrid.FillWithAlternatingRowBitmap(TempRect: TRect);
  var OldBrushColor: TColor;
  begin
         if PaintOptions.AlternatingColorBitmap<>nil then
            Canvas.CopyRect(TempRect,PaintOptions.AlternatingColorBitmap.canvas,TempRect)
         else begin
            OldBrushColor:= canvas.Brush.Color;
            Canvas.Brush.Color:= PaintOptions.AlternatingRowColor;
            Canvas.FillRect(TempRect);
            Canvas.Brush.Color:= OldBrushColor;
         end
  end;

  procedure TwwCustomDBGrid.FillWithBlendBitmap(
     TempRect: TRect; CurRelRow: integer; FillColor: TColor=clNone);
  begin
     if (PaintOptions.AlternatingRowColor<>clNone) and
        (arrDataColumns in PaintOptions.AlternatingRowRegions) and
        (CurRelRow>=0) and
        (Odd(CurRelRow) xor AlternatingEven) then
     begin
        if not (dgColLinesDisableFixed in Options) then
           TempRect.Left:= TempRect.Left-1;
        if not (dgRowLines in Options) and
           not (dgHideBottomDataLine in Options) then TempRect.Bottom:= TempRect.Bottom+1;
        FillWithAlternatingRowBitmap(TempRect);
     end
     else if PaintOptions.HaveBackgroundForDataCells then begin
        // Don't expand rectangle, as it makes focusrect miss some lines when other cells draw
//        TempRect:= Rect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
        if not (dgRowLines in Options) and
           not (dgHideBottomDataLine in Options) then TempRect.Bottom:= TempRect.Bottom+1;
        Canvas.CopyRect(TempRect, PaintOptions.OrigBitmap.canvas,TempRect);
     end
     else if Assigned(FOnBeforePaint) then exit
     else if FillColor = clNone then
     begin
        Canvas.FillRect(TempRect);
     end
     else begin
        Canvas.Brush.Color:=FillColor;
        Canvas.FillRect(TempRect);
     end;
  end;

  procedure TwwCustomDBGrid.FillWithFixedBitmap(
     TempRect: TRect; CurRelRow: integer; FillColor: TColor=clNone);
  begin
     if (PaintOptions.AlternatingRowColor<>clNone) and
        (arrFixedColumns in PaintOptions.AlternatingRowRegions) and
        (CurRelRow>=0) and
        (Odd(CurRelRow) xor AlternatingEven) then
     begin
         FillWithAlternatingRowBitmap(TempRect);
     end
     else if PaintOptions.Column1Bitmap<>nil then begin
        Canvas.CopyRect(TempRect,PaintOptions.Column1Bitmap.canvas,TempRect);
     end
     else if FillColor = clNone then
     begin
        Canvas.FillRect(TempRect);
     end
     else begin
        Canvas.Brush.Color:=FillColor;
        Canvas.FillRect(TempRect);
     end;
  end;

Function TwwCustomDBGrid.UseThemesInTitle: boolean;
begin
   result:= False;
   if ThemeServices.ThemesEnabled then
   begin
      if PaintOptions.Row1Bitmap=nil then
      begin
         result:= True;
      end
   end
end;

Procedure TwwCustomDBGrid.DrawCell(ACol, ARow: Longint;
	 ARect: TRect; AState: TGridDrawState);
type
  TLineOption = (loNoVertLine);
  TLineOptions = Set of TLineOption;
var
  OldActive: Integer;
  Alignment: TAlignment;
  Highlight: Boolean;
  Value: string;
  ATitleAlignment: TAlignment;
  TempDisplayLabel: string;
  APos, Index : integer;
  DrawInfo: TGridDrawInfo;

  defaultTitleDrawing: boolean;
  ATextRect,TempRect: TRect;
  TitleImageAttributes: TwwTitleImageAttributes;
  TitleOffset: integer;
  CurRelRow :integer;
  TempFieldName: string;
  SkipDefaultDrawing: boolean;
  pressed: boolean;
//  startCol, EndCol: integer;
//  ACursor: TPoint;

  procedure showHighlight(ACanvas: TCanvas; const ARect: TRect; DX, DY: Integer);
  var text: string;
      S: array[0..1] of char;
  begin
     text:= '';
     s[0]:= #0;
     with ACanvas do
       ExtTextOut(Handle, ARect.Right - TextWidth(Text) - 3, ARect.Top + DY,
	   ETO_OPAQUE or ETO_CLIPPED, @ARect, s, Length(Text), nil)
  end;

  procedure Display(S: string; Alignment: TAlignment; Transparent: boolean=True);
  const
    Formats: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT,
      DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX);
  var
    ButtonOffset: integer;
    NumLines, startOffset: integer;
    WriteOptions: TwwWriteTextOptions;
    TempRect: TRect;
  begin
    if not DrawCellInfo.DefaultDrawContents then exit;

    {11/26/97 - Only for title row}
    { 2/9/98 - Only depress currently clicked column }
    ButtonOffset := 0;

    if FTitleButtons and (not UseDragCanvas) and (TitleClickColumn>=0) and (ARow<0) then
    begin
       if (TitleClickGroupTitle) then
       begin
          // Paint group or sub-group button
          if (TitleClickGroupTitle and (ARect.Top=0)) then
             ButtonOffset:= 1;
       end
       else if (ACol+FIndicatorOffset=TitleClickColumn) then
       begin
          if (ARect.Top>0) or (Columns[ACol].GroupName='') then
             ButtonOffset:=1
       end;
    end;

    if (ARow<0) then begin
       if FTitleLines=1 then NumLines:= 1
       else NumLines:= strCount(s, '~')+1;
       startOffset:= Trunc(((ATextRect.bottom-ATextRect.Top)/2)
                    -(0.5*NumLines *Canvas.Textheight(s)));
       s:= strReplaceChar(s, '~',#13);
       WriteOptions:= [wtoEllipsis];
       WriteOptions:= WriteOptions + [wtoTransparent];
       If Assigned(FOnDrawTitleCell) then WriteOptions:= WriteOptions + [wtoMergeCanvas];
       If Assigned(FOnDrawGroupHeaderCell) then WriteOptions:= WriteOptions + [wtoMergeCanvas];
       if not useTfields then WriteOptions:= WriteOptions + [wtoAmpersandToUnderline];

       // 1/4/02 - Don't paint data columns to the left of data area.
       // Group case where 1st part of group is not visible
        if (ARect.Left < 0) or
          ((ACol+FIndicatorOffset >= LeftCol) and (ARect.Left<CellRect(LeftCol, 0).Left) and
          (not UseDragCanvas)) then
       begin
          ExcludeClipRect(Canvas.Handle, 0, 0,
             CellRect(LeftCol, 0).Left, ClientHeight);  // Don't paint before leftcol
          wwWriteTextLines(Canvas, ATextRect, 2+ButtonOffset, startOffset+ButtonOffset, PChar(s),
             Alignment, WriteOptions);
          SelectClipRgn(Canvas.Handle, 0);  // Restore normal clipping rectangle
       end
       else
         wwWriteTextLines(Canvas, ATextRect, 2+ButtonOffset, startOffset+ButtonOffset, PChar(s),
              Alignment, WriteOptions);

    end
    else begin
       WriteOptions:= [];
       if Transparent then
          WriteOptions:= WriteOptions + [wtoTransparent];
       { Ellipsis only supported for single line }
       if (dgTrailingEllipsis in Options) and
          wwIsSingleLineEdit(Canvas.Handle,ARect,
                DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX) then
          WriteOptions:= WriteOptions + [wtoEllipsis];

       if not (dgWordWrap in Options) then begin
          TempRect:= ARect;
          if (dgTrailingEllipsis in Options) then
             WriteOptions:= WriteOptions + [wtoEllipsis];

          { 12/4/98 - Fix problem when descenders cutoff when dgRowLines=False}
          if HaveAnyRowLines then ButtonOffset:= 1;
	  wwWriteTextLines(Canvas, TempRect, 2{+ButtonOffset} { 2/20/99 - Comment out ButtonOffset, Text too far to right before },
              (NormalPad div 2)+ButtonOffset, PChar(s), Alignment, WriteOptions); { 5/21/98 }
       end
       else begin
          WriteOptions:= WriteOptions + [wtoWordWrap];
          TempRect:= ARect;
          if not (HaveAnyRowLines) then { 1/8/99 - Fix descendor cutoff problem when wordwrap is true }
             wwWriteTextLines(Canvas, TempRect, 2+ButtonOffset,
                (NormalPad div 2)+ButtonOffset, PChar(s), Alignment, WriteOptions)
          else wwWriteTextLines(Canvas, TempRect, 2+ButtonOffset,
                (NormalPad div 2)+1+ButtonOffset, PChar(s), Alignment, WriteOptions);
       end;
    end;
  end;


  procedure SaveToBitmap(Bitmap: TBitmap; tempField: TField);
  type
    TGraphicHeader = record
      Count: Word;                { Fixed at 1 }
      HType: Word;                { Fixed at $0100 }
      Size: Longint;              { Size not including header }
    end;

  var
     {$ifdef wwDelphi3Up}
     BlobStream: TStream;
     {$else}
     BlobStream: TwwMemoStream;
     {$endif}
     Size: Longint;
     Header: TGraphicHeader;
  begin
     {$ifdef wwDelphi3Up}
     { Support TClientDataSet by using CreateBlobStream instead }
     BlobStream:= tempField.dataset.CreateBlobStream(tempField, bmRead);
     {$else}
     BlobStream := TwwMemoStream.Create(tempField as TBlobField);
     {$endif}

     try { Use try/except instead of try/finally for efficiency}
       Size := BlobStream.Size;
       if Size >= SizeOf(TGraphicHeader) then
       begin
	 BlobStream.Read(Header, SizeOf(Header));
	 if (Header.Count <> 1) or (Header.HType <> $0100) or
	   (Header.Size <> Size - SizeOf(Header)) then
	   BlobStream.Position := 0;
       end;
       Bitmap.LoadFromStream(BlobStream);
       BlobStream.Free;
     except
       BlobStream.Free;
     end;
  end;

  procedure DrawCellColors(tempField: TField; DrawFocus: boolean);
  var pf: TCustomForm;
  begin
      with Canvas do begin
	 if gdFixed in AState then Brush.Color := TitleColor
	 else Brush.Color := Color;

	 FCalcCellRow:= ARow;
	 if dgTitles in Options then Dec(FCalcCellRow, 1);
	 FCalcCellCol:= ACol;
	 if dgIndicator in Options then Dec(FCalcCellcol, 1);

	 Highlight := HighlightCell(ACol, FCalcCellRow, Value, AState);
	 if Highlight then
	 begin
           Brush.Color := GetHighlightColor;
           if not (dgRowSelect in Options) and
             (ARow=Row) and (ACol=Col) then
             Brush.Color:= clHighlight;
	   Font.Color := clHighlightText;
	 end;

	 DoCalcCellColorsDetect(tempField, AState, Highlight, Font, Brush); {new code}

         if Highlight then
         begin
            if (not IsDropDownGridFocused) or
               ((dgRowSelect in Options) or (PaintOptions.ActiveRecordColor<>clNone)) then
               showHighlight(Canvas, ARect, 2, 2) {Call after brush and font are set }
         end;

	 if Highlight then begin
           pf:= GetParentForm(self);
           if not (csDesigning in ComponentState) and (pf<>nil) and
               (pf.ActiveControl = Self) then
	   begin
	      if not (dgRowSelect in Options) then begin
		 isDrawFocusRect:= True;
	      end
	   end
	 end;
      end;
  end;

  procedure DisplayBitMap(tempField: TField; Parameters: string);
  var myBitmap: TBitmap;
      SRect, DRect : TRect;
      tempBitmapField: TField; {win95}
      tempLookupValue: string;
      tempHeight, tempWidth: Longint;
      bitmapSubsetWidth, bitmapSubsetHeight: integer;
      PrevCopyMode: TCopyMode;
      bitmapSize, rasterOperation: string;
      APos: integer;
      cellWidth, cellHeight: integer;
      rowlineoffset,collineoffset:integer;

      Function GetCopyMode(cm: string): TCopyMode;
      begin
	  Result:= cmSrcCopy;
	  if cm='Source Copy' then Result:= cmSrcCopy
	  else if cm='Source Paint' then Result:= cmSrcPaint
	  else if cm='Source And' then Result:= cmSrcAnd
	  else if cm='Source Invert' then Result:= cmSrcInvert
	  else if cm='Source Erase' then Result:= cmSrcErase
	  else if cm='Not Source Copy' then Result:= cmNotSrcCopy
	  else if cm='Not Source Erase' then Result:= cmNotSrcErase
	  else if cm='Merge Paint' then Result:= cmMergePaint
      end;

  begin
      Apos:= 1;
      BitmapSize:= strGetToken(Parameters, ';', APos);
      RasterOperation:= strGetToken(Parameters, ';', APos);
      cellWidth:= ARect.Right - ARect.Left;
      cellHeight:= ARect.Bottom - ARect.Top;

      if tempField.calculated then
      begin
	 if not wwDataSetLookupDisplayField(tempField, tempLookupValue, tempBitmapField) then
	 begin
	    DrawCellColors(tempField, True);   { Lookup failed }
	    exit;
	 end
      end

      { 7/10/97 - Support bitmaps with lookup fields - Only 1 field lookups supported}
      {$ifdef win32}
      else if tempField.lookup then begin
         if not wwDataSetFindRecord(tempField.LookupDataSet,
               tempField.DataSet.fieldByName(tempField.KeyFields).asString,
               tempField.LookupKeyFields, mtExactMatch, False) then
         begin
	    DrawCellColors(tempField, True);   { Lookup failed }
	    exit;
         end
         else TempBitmapField:= tempField.LookupDataSet.FieldByname(tempField.LookupResultField);
      end
      {$endif}
      else begin
	tempBitmapField:= tempField;
      end;

      myBitmap := TBitmap.Create;

      {7/23/97 - Display bitmaps even in insert mode if lookup bitmap }
      if tempField.calculated or
         {$ifdef win32}
         tempField.Lookup or
         {$endif}
         not ((DataSource.DataSet.State = dsInsert) and
	      (dbRow(row)=DataLink.ActiveRecord+RowOffset)) then SaveToBitmap(myBitmap, tempBitmapField);

      if (MyBitmap.height<=0) or (MyBitmap.width<=0) then
      begin
	 DrawCellColors(tempField, True);
	 myBitmap.Free;
	 exit;
      end;

      SRect  := classes.Rect(0, 0, myBitmap.Width, myBitmap.Height);

      PrevCopyMode:= Canvas.CopyMode;
      Canvas.CopyMode:= GetCopyMode(rasterOperation);
      DrawCellColors(tempField, True);

      // 2/20/2002-PYW-When displaying bitmap take into account colline and rowlines.
      if dgCollines in Options then collineoffset := 1
      else collineoffset := 0;
      if dgrowlines in Options then rowlineoffset := 1
      else rowlineoffset := 0;

      if BitmapSize='Original Size' then
      begin
	 tempHeight:= cellHeight;
	 tempWidth:= cellWidth;
	 SRect  := classes.Rect(0, 0, min(myBitmap.Width, tempWidth-1),
				      min(myBitmap.Height, tempHeight - 1));
	 DRect  := classes.Rect(ARect.Left+collineoffset, ARect.Top + rowlineoffset,
		ARect.Left + 1 + (SRect.Right - SRect.Left),
		ARect.Top + 1 + (SRect.Bottom - SRect.Top));

	 Canvas.CopyRect(DRect, myBitmap.Canvas, SRect);
      end
      else if BitmapSize='Stretch To Fit' then
      begin
	 Canvas.StretchDraw(ARect, myBitmap);
      end
      else if BitmapSize='Fit Height' then begin
	 { Paint bitmap portion that is shown.                  }
	 { BitmapSubsetWidth is portion of bitmap that is drawn }
	 tempHeight:= cellHeight;
	 tempWidth:= (myBitmap.Width * tempHeight) div myBitmap.Height;
	 if tempWidth > CellWidth then begin
	    BitmapSubsetWidth:= (myBitmap.width * cellWidth) div tempWidth;
	    tempWidth:= cellWidth; { Limit to cell's width }
	 end
	 else BitmapSubsetWidth:= myBitmap.width;

	 if (tempWidth>2) and (tempHeight>2) then begin
	    DRect  := classes.Rect(ARect.Left+collineoffset, ARect.Top,
		ARect.Left + tempWidth,
		ARect.Top + tempHeight - rowlineoffset);
	    SRect  := classes.Rect(0, 0, BitmapSubsetWidth, myBitmap.Height);
	    Canvas.CopyRect(DRect, myBitmap.Canvas, SRect);
	 end
      end
      else if BitmapSize='Fit Width' then
      begin
	 { Paint bitmap portion that is shown.                   }
	 { BitmapSubsetHeight is portion of bitmap that is drawn }
	 tempWidth:= cellWidth;
	 tempHeight:= (myBitmap.Height * tempWidth) div myBitmap.Width;
	 if tempHeight > CellHeight then begin
	    BitmapSubsetHeight:= (myBitmap.height * cellHeight) div tempHeight;
	    tempHeight:= cellHeight; { Limit to cell's height }
	 end
	 else BitmapSubsetHeight:= myBitmap.Height;

	 if (tempWidth>2) and (tempHeight>2) then begin
	    DRect  := classes.Rect(ARect.Left+collineoffset, ARect.Top ,
		     ARect.Left+ tempWidth,
		     ARect.Top + tempHeight - rowlineoffset);
	    SRect  := classes.Rect(0, 0, myBitmap.Width, BitmapSubsetHeight);
	    Canvas.CopyRect(DRect, myBitmap.Canvas, SRect);
	 end
      end;

      if Highlight then begin
	 Canvas.Brush.Color := clHighlight;
	 Canvas.FrameRect(ARect);
	 SkipLineDrawing:= True;
      end;
      Canvas.CopyMode:= PrevCopyMode;

      myBitmap.Free;
  end;



  procedure DisplayBitmapFromImageList(tempField: TField; Parameters: string);
  var myBitmap: TBitmap;
      SRect, DRect, bitmapRect : TRect;
      APos: integer;
      BitmapSize: string;
  begin
        DrawCellColors(tempField, False);
        myBitmap := TBitmap.Create;
        myBitmap.width:= ImageList.width;
        myBitmap.height:= ImageList.height;
        BitmapRect  := classes.Rect(0, 0, ImageList.width, ImageList.height);
        myBitmap.Canvas.Brush.Color:= Canvas.Brush.Color;
        SRect  := classes.Rect(0, 0, min(ARect.right-Arect.Left-2, myBitmap.Width),
                            min(Arect.Bottom-Arect.Top-2, myBitmap.Height));

        // 6/17/02 - Initialize earlier
        DRect.left:= max(ARect.Left, (ARect.Left + ARect.right - ImageList.Width) div 2);
        DRect.top:= max(ARect.Top, (ARect.Top + ARect.Bottom - ImageList.height) div 2);
        DRect.right:= DRect.left +
           Min(myBitmap.width, ARect.right - ARect.left);
        DRect.bottom:= DRect.Top +
           Min(myBitmap.height, ARect.bottom - ARect.top);

        // 6/17/02 - Allow transparent image when using alternating colors in grid
        if ImageList.DrawingStyle = dsTransparent then
           myBitmap.Canvas.CopyRect(SRect, Canvas, DRect)
        else
           myBitmap.Canvas.FillRect(BitmapRect);

        if (not tempField.isNull) then
        begin
           if (tempField is TIntegerField) and (tempField.asInteger>=0) then
             ImageList.Draw(MyBitmap.Canvas, 0, 0, tempField.asInteger)
           else if (tempField is TFloatField) and (tempField.asFloat>=0) then
             ImageList.Draw(MyBitmap.Canvas, 0, 0, trunc(tempField.asFloat))
        end;

         Apos:= 1;
         BitmapSize:= strGetToken(Parameters, ';', APos);

         if (BitmapSize = 'Shrink To Fit') then
            Canvas.StretchDraw(DRect, myBitmap)
         else
            Canvas.CopyRect(DRect, myBitmap.Canvas, SRect);

         if IsDrawFocusRect then
           wwDrawFocusRect(Canvas, ARect);

        myBitmap.Free;
  end;

  procedure PaintInactiveCustomControl(CustomEdit: TWinControl; tempField: TField);

    procedure PaintControl(Control: TWinControl; ARect: TRect);
    var i: integer;
        SaveIndex: integer;
    begin
      Control.ControlState:= Control.ControlState + [csPaintCopy] ;
      SaveIndex := SaveDC(Canvas.Handle);
      if UseRightToLeftAlignment then
      begin
        ChangeOrientation(False);
        if wwGetBorder(Control)then // if border then add 1 offset
           MoveWindowOrg(Canvas.Handle, ClientWidth-ARect.right+1, ARect.Top+1)
        else
           MoveWindowOrg(Canvas.Handle, ClientWidth-ARect.right, ARect.Top);
      end
      else begin
         if wwGetBorder(Control)then // if border then add 1 offset
           MoveWindowOrg(Canvas.Handle, ARect.Left+1, ARect.Top+1)
         else
           MoveWindowOrg(Canvas.Handle, ARect.Left, ARect.Top);
      end;

      IntersectClipRect(Canvas.Handle, 0, 0, ARect.Right-ARect.Left,
         ARect.Bottom - ARect.Top);
      Control.Perform(WM_PAINT, Canvas.Handle,
                      ARect.Bottom - ARect.Top);

      // Don't paint children of inspector, as it already does this on its own
      if not (wwIsClass(Control.classtype, 'TwwDataInspector')) then with Control do begin
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
  var abortflag:boolean;
  begin
     if (customEdit.Width<>ARect.Right-ARect.Left) or
        (customEdit.Height<>ARect.Bottom-ARect.Top) then
     begin
        if Columns[dbCol(ACol)].DisableSizing then
        begin
           if abs(ARect.Right-ARect.Left)>customEdit.Width then
             customEdit.width:= ARect.Right-ARect.Left;

           if abs(ARect.Bottom-ARect.Top)>customEdit.Height then
           begin
              customEdit.Height:= ARect.Bottom-ARect.Top;
           end;
        end
        else begin
          customEdit.width:= ARect.Right-ARect.Left;
          customEdit.Height:= ARect.Bottom-ARect.Top;
        end
     end;

     Canvas.Lock();
     try
        SetBkMode(Canvas.Handle, TRANSPARENT);
        DrawCellColors(tempField, True);
        abortflag := False;
        // 7/26/2001 - PYW - Added code to handle abort in OnDrawDataCell event to prevent default customcontrol painting.
        try
          DrawDataCell(ARect, GetColField(dbCol(ACol)), AState);
        except
          abortflag := True;
        end;

        if not abortflag then begin
          if ChangedBrushColor then
          begin
             Canvas.FillRect(ARect);
          end;
          PaintControl(CustomEdit, ARect);
        end;

     finally
        Canvas.UnLock();
        SetBkMode(Canvas.Handle, OPAQUE);
     end;


  end;

  procedure FillWithTitleBitmaps(ARect: TRect; FillColor: TColor = clNone);
  begin
     TempRect:= Rect(ARect.Left-1, ARect.Top, ARect.Right, ARect.Bottom);
     if PaintOptions.Row1Bitmap<>nil then begin
        Canvas.CopyRect(TempRect,PaintOptions.Row1Bitmap.canvas,TempRect);
     end
     else if FillColor=clNone then begin
        Canvas.FillRect(TempRect);
     end
     else begin
        Canvas.Brush.Color:=FillColor; //PaintOptions.Row1Color;
        Canvas.FillRect(TempRect);
     end
  end;

  Function HandleWWControls: boolean;
  var tempField: TField;
      Rect: TRect;
      ControlType, Parameters: string;
      checkboxOn, checkBoxOff: string;
      APos: integer;
      customEdit: TWinControl;
      r: TRect;
  begin
     result:= False;
     if not isValidCell(ACol, ARow) then exit;
     tempField:= GetColField(dbCol(ACol));
     if tempField=Nil then exit;
     if ACol<FixedCols then
     begin
        r:= ARect;
        r.left:= r.left-1;
        if (dgRowLinesDisableFixed in Options) and
           (dgRowLines in Options) then
           r.Top:= r.Top -1;
        if DrawCellInfo.DefaultDrawBackground then
           FillWithFixedBitmap(r, CurRelRow, TitleColor);
     end
     else if DrawCellInfo.DefaultDrawBackground then
        FillWithBlendBitmap(ARect, CurRelRow, clNone);

     ARect:= CellRect(ACol, ARow);
     ControlType:=
        TwwCacheColInfoItem(FCacheColInfo[ACol]).ControlType;
     Parameters:=
        TwwCacheColInfoItem(FCacheColInfo[ACol]).ControlData;

     {  Bitmap support }
     if ControlType='Bitmap' then begin
       OldActive:= DataLink.ActiveRecord;
       try
	  DataLink.ActiveRecord:= dbRow(ARow)+RowOffset;
          DisplayBitMap(tempField, Parameters);
       finally
	  DataLink.ActiveRecord:= OldActive;
       end;

       Draw3DLines(ARect, ACol, ARow, AState);

       result:= True;
       exit;
    end
    else if ControlType='ImageIndex' then begin
       OldActive:= DataLink.ActiveRecord;
       try
	  DataLink.ActiveRecord:= dbRow(ARow)+RowOffset;
          DrawCellColors(tempField, True);
          if ChangedBrushColor then
             Canvas.FillRect(ARect);

          if (tempField is TIntegerField) or
             (tempField is TFloatField) then
          begin
             if (FImageList<>Nil) then
               DisplayBitmapFromImageList(tempField, Parameters)
          end
       finally
	  DataLink.ActiveRecord:= OldActive;
       end;

       Draw3DLines(ARect, ACol, ARow, AState);

       result:= True;
       exit;
    end
    else if ControlType='CheckBox' then begin
      APos:= 1;
      checkBoxOn:= strGetToken(Parameters, ';', APos);
      checkBoxOff:= strGetToken(Parameters, ';', APos);
      OldActive:= DataLink.ActiveRecord;
      Value:= '';
      try
	 DataLink.ActiveRecord:= dbRow(ARow)+RowOffset;
	 if tempField.calculated and (lowercase(tempField.fieldName)='selected') then begin
	    if isSelected then value:= checkBoxOn
	    else value:= checkBoxOff;
	 end
	 else begin
	    value:= GetFieldValue(dbCol(ACol));
	 end;

	 DrawCellColors(tempField, True);
         if ChangedBrushColor then
         begin
            Canvas.FillRect(ARect);
         end;

      finally
	 DataLink.ActiveRecord:= OldActive;
      end;

      rect.left:= (ARect.right + ARect.left - 10) div 2;
      rect.right:= rect.left + 10;

      rect.Top:= ((ARect.Top + ARect.Bottom - 10) div 2);
      rect.Bottom:= rect.Top + 10;

      DrawCheckBox(rect, ACol, ARow, wwEqualStr(value, checkBoxOn));  { 2/11/97 Case insensitive check}

      Draw3DLines(ARect, ACol, ARow, AState);
      result:= True;
      exit;
   end
   else if (ControlType = 'CustomEdit') or (ControlType = 'RichEdit') then
   begin
      if IsCustomEditCell(ACol, ARow, customEdit) and
         (customEdit <> FDateTimePicker) then
      begin
        if TwwCacheColInfoItem(FCacheColInfo[ACol]).AlwaysPaints or
           wwIsClass(Customedit.classType, 'TwwExpandButton') or
           wwIsClass(Customedit.classType, 'TwwRadioGroup') or
           wwIsClass(Customedit.classType, 'TwwCheckbox') or
           wwIsClass(Customedit.classType, 'TwwMonthCalendar') then
        begin
           OldActive:= DataLink.ActiveRecord;
           try
              DataLink.ActiveRecord:= dbRow(ARow)+RowOffset;

              // This code fixes problem where the expand icon
              // was not painting as expanded for expanded active row
              if (not CustomEdit.visible) or
                 ((Row<>ARow) or (Col<>ACol)) then
              begin
                 if (customEdit is TwwExpandButton) and
                     IsDropDownGridShowing and
                    ((Row=ARow) and (Col=ACol)) then
                 begin
                    TwwExpandButton(customEdit).PaintAsExpanded:=True;
                    PaintInactiveCustomControl(customEdit, tempField);
                    TwwExpandButton(customEdit).PaintAsExpanded:=False;
                 end
                 else
                    PaintInactiveCustomControl(customEdit, tempField);
              end;
           finally
          	  DataLink.ActiveRecord:= OldActive;
           end;
           Draw3DLines(ARect, ACol, ARow, AState);
           result:= True;
        end;
      end;
   end
  end;

  {4/31/97 - Use extra temp bitmap due to bug in Delphi 3 BrushCopy method }
  procedure ShowIndicator;
  var TempIndicators: TImagelist;
      Bmp: TBitmap;
  begin
     Index:= -1;
     if FDataLink.DataSet = nil then Index:=0
     else begin
       case FDataLink.DataSet.State of
	  dsEdit: if ARow = FDataLink.ActiveRecord - RowOffset then Index:= 1;
          dsInsert: if ARow = FDataLink.ActiveRecord - RowOffset then Index:= 2;
          else begin
             if ARow = FDataLink.ActiveRecord - RowOffset then begin
                if (dgMultiSelect in Options) and
                   isSelectedRow(ARow) then
                   Index:= 4
                else Index:=0
             end
             else if (dgMultiSelect in Options) and isselectedRow(ARow) then
                Index:= 3
          end
       end
     end;
     if Index>=0 then
     begin
        TempIndicators := TImageList.CreateSize(Indicators.Width,
                                             Indicators.Height);
        Bmp:= TBitmap.Create;
        try
          Indicators.GetBitmap(Index, Bmp);
          ChangeColorBitmap(Bmp, IndicatorIconColor, clBlack);
          TempIndicators.AddMasked(Bmp, clWhite);
          TempIndicators.Draw(Canvas,
                    ((ARect.right-Indicators.Width) div 2)+1,
                    (ARect.Top + ARect.Top + DefaultRowHeight - Indicators.Height) div 2,
                    0, True);
        finally
          Bmp.Free;
          TempIndicators.Free;
        end;
     end;
  end;

  procedure DoOnAfterDrawCell;
  begin
    if Assigned (OnAfterDrawCell) then
    begin
       if DrawCellInfo.DataRow>=0 then begin
          OldActive:= FDataLink.ActiveRecord;
          FDataLink.ActiveRecord:= DrawCellInfo.DataRow;
       end;
       try
          FOnAfterDrawCell(self, DrawCellInfo);
       finally
          if DrawCellInfo.DataRow>=0 then
             FDataLink.ActiveRecord:= OldActive;
       end;
    end
  end;

  procedure DoThemeBackground(pressed: boolean;
               Options: TLineOptions;
               tempRect: TRect);
  var Details: TThemedElementDetails;

     Function InGroupRange: boolean;
     var AbsCol: integer;
         startcol, endcol: integer;
     begin
        result:= false;
        if MouseOverGroupTitle and (Columns[ACol].GroupName<>'') then
        begin
           if TitleLastMouseX=ACol+FIndicatorOffset then result:= true;
           if TitleLastMouseX>=FIndicatorOffset then
           begin
             GroupNameCellRect(TitleLastMouseX, 0, StartCol,EndCol);
             AbsCol:= ACol+FIndicatorOffset;
             if (AbsCol>=StartCol) and (AbsCol<=EndCol) then result:= True;
           end
        end
     end;

  begin
       if pressed then
          Details := ThemeServices.GetElementDetails(thHeaderItemPressed)
       else begin
          if loNoVertLine in Options then
             Details := ThemeServices.GetElementDetails(thHeaderItemLeftNormal)
          else if TitleButtons and
             (TitleLastMouseY=0) and
             ((TitleLastMouseX-FIndicatorOffset=ACol) or InGroupRange) and
             (not UseDragCanvas) then
          begin
             if Columns[ACol].GroupName<>'' then
             begin
                Details := ThemeServices.GetElementDetails(thHeaderItemHot);
                if MouseOverGroupTitle and (ARect.Top>0) then
                   Details := ThemeServices.GetElementDetails(thHeaderItemNormal)
                else if not MouseOverGroupTitle and (ARect.Top<=0) then
                   Details := ThemeServices.GetElementDetails(thHeaderItemNormal)
             end
             else Details := ThemeServices.GetElementDetails(thHeaderItemHot)
          end
          else begin
             Details := ThemeServices.GetElementDetails(thHeaderItemNormal);
          end
       end;
       tempRect.right:= tempRect.right+1;
       ThemeServices.DrawElement(Canvas.Handle, Details, tempRect);
  end;

begin {.DrawCell}
  CurRelRow:= ARow;
  if dgTitles in Options then Dec(CurRelRow, 1);
  CalcDrawInfo(DrawInfo);
  if ARow>DrawInfo.Vert.LastFullVisibleCell then exit;
  if RecordCountIsValid then
  begin
     if (dbRow(ARow) >=FDataLink.RecordCount - RowOffset) and
       (FDataLink.RecordCount>0) then exit;  // If no records, then still display
  end;

  // Don't paint rows unless completely visible
  isDrawFocusRect:= False;
  SkipLineDrawing:= False;
  if (ARect.Right>2*Width) then ARect.Right:= 2*Width; { 2/24/00 - Limit display rectangle's right border }
  {3/1/00 - Use 10*width in case of horizontal scolling }
  ATextRect:= ARect;

  if gdFixed in AState then
    Canvas.Font := TitleFont
  else
    Canvas.Font := Font;

  with DrawCellInfo do begin
     Rect:=ARect;
     State:= AState;
     DataRow:= ARow;
     DataCol:= ACol;
     if dgIndicator in Options then DataCol:= DataCol-1;
     if dgTitles in Options then Dec(DataRow, 1);

     if DataCol<0 then DrawCellInfo.Field:=nil
     else DrawCellInfo.Field:= Fields[DataCol];

     DefaultDrawBackground:= True;
     DefaultDrawHorzBottomLine:= True;
     DefaultDrawHorzTopLine:= True;
     DefaultDrawContents:= True;
  end;

  if Assigned (OnBeforeDrawCell) then
  begin
     if DrawCellInfo.DataRow>=0 then begin
       OldActive:= FDataLink.ActiveRecord;
       FDataLink.ActiveRecord:= DrawCellInfo.DataRow;
     end;

     try
       FOnBeforeDrawCell(self, DrawCellInfo);

//       if (not DrawCellInfo.DefaultDrawHorzBottomLine) or
//          (not DrawCellInfo.DefaultDrawHorzTopLine) then
       if (DrawCellInfo.DataCol<=ColItems.Count-1) and
          (DrawCellInfo.DataCol>=0) then with DrawCellInfo do
       begin
           if Columns[DataCol].ColumnFlags=nil then
           begin
              Columns[DataCol].ColumnFlags:= PByteArray(AllocMem(SizeOf(Byte)*(256)));
           end
       end;


       if
          (DrawCellInfo.DataRow>=0) and
          (DrawCellInfo.DataRow<256) and
          (DrawCellInfo.DataCol<ColItems.Count-1) and
          (DrawCellInfo.DataCol>=0) and
          (Columns[DrawCellInfo.DataCol].ColumnFlags<>nil) then with DrawCellInfo do
       begin
         if not DefaultDrawHorzBottomLine then
            Columns[DataCol].ColumnFlags[DataRow]:= Columns[DataCol].ColumnFlags[DataRow] or wwDisableDrawBottomLine
         else
            Columns[DataCol].ColumnFlags[DataRow]:= Columns[DataCol].ColumnFlags[DataRow] and not wwDisableDrawBottomLine;
         if not DrawCellInfo.DefaultDrawHorzTopLine then
            Columns[DataCol].ColumnFlags[DataRow]:= Columns[DataCol].ColumnFlags[DataRow] or wwDisableDrawHorzTopLine
         else
            Columns[DataCol].ColumnFlags[DataRow]:= Columns[DataCol].ColumnFlags[DataRow] and not wwDisableDrawHorzTopLine;
       end;

     finally

       if DrawCellInfo.DataRow>=0 then
          FDataLink.ActiveRecord:= OldActive;
     end
  end;

  with Canvas do
  begin
    if gdFixed in AState then
      Brush.Color := TitleColor else
      Brush.Color := Color;

    if HandleWWControls then begin
       DoOnAfterDrawCell;
       exit;
    end;

    if dgTitles in Options then Dec(ARow, 1);
    if dgIndicator in Options then Dec(ACol, 1);

    if (ARow < 0) {and (ACol>=0) }then begin
      ATitleAlignment:= FTitleAlignment;
      if (ACol >= 0) and
         ((ACol < FieldCount) or (not useTFields)) then begin
        {12/15/97 - Paint indicator button now so blank space isn't displayed too long }
        if (ACol=0) and (dgIndicator in Options) then
           if (IndicatorButton<>Nil) and
              IndicatorButton.visible then IndicatorButton.paint;
        {7/31/97 - Don't use displaylabel property when useTFields=False }
        if ACol <FieldCount then
           tempDisplayLabel:= Fields[ACol].DisplayLabel
        else tempDisplayLabel:= '';

        if not useTFields then begin
           if FieldCount=0 then
           begin
              if (ACol>=0) and (ACol<Selected.count) then
              begin
                 APos:=1;
                 TempFieldName:= strGetToken(Selected[ACol], #9, APos);
              end;
           end
           else TempFieldName:= Fields[ACol].FieldName;
           if wwFindSelected(Selected, TempFieldName, index) then
           begin
              APos:= 1;
              strGetToken(Selected[Index], #9, APos); { 11/11/98 - Changed ACol to Index }
              strGetToken(Selected[Index], #9, APos); { Changed ACol to Index }
              tempDisplayLabel:= strGetToken(Selected[index], #9, APos);
           end;
        end
        else TempFieldName:= Fields[ACol].FieldName;
//        ARect:= TitleCellRect(OrigACol, OrigARow);
        ATextRect:= ARect;
        TitleImageAttributes.ImageIndex:= -1;
        TitleImageAttributes.IsGroupHeader:=
           (Columns[ACol].GroupName<>'') and (ARect.Top=0);
        TitleImageAttributes.Alignment:= taRightJustify;
        TitleImageAttributes.Margin:= 3;

        if TitleImageAttributes.IsGroupHeader then
        begin
           TempFieldName:= Columns[ACol].GroupName;
           ATitleAlignment:= taCenter;
        end;
	DoCalcTitleAttributes(TempFieldName, Font, Brush, ATitleAlignment);

//        Canvas.FillRect(ARect);
        TempRect:= ARect;
        if (not UseDragCanvas) and
           (TempRect.Right>DrawInfo.Horz.FixedBoundary) and
           (TempRect.Left<DrawInfo.Horz.FixedBoundary) then
           TempRect.Left:= wwMax(TempRect.Left, DrawInfo.Horz.FixedBoundary);

        if DrawCellInfo.DefaultDrawBackground then
        begin

          if UseThemesInTitle then //ThemeServices.ThemesEnabled then
          begin
             pressed:= FTitleButtons and (not UseDragCanvas) and (TitleClickColumn>=0);

             if pressed then
             begin
               if (TitleClickGroupTitle) then
               begin
                  pressed:= (TitleClickGroupTitle and (ARect.Top=0));
               end
               else if (ACol+FIndicatorOffset=TitleClickColumn) then
               begin
                  pressed:= (ARect.Top>0) or (Columns[ACol].GroupName='');
               end;
             end;

             DoThemeBackground(pressed, [], tempRect);
          end
          else if ChangedBrushColor then
             Canvas.FillRect(TempRect)
          else
             FillWithTitleBitmaps(TempRect);
        end;

        if ACol<FieldCount then
           DoCalcTitleImage(Self, Fields[ACol], TitleImageAttributes);

        titleOffset:= 0;
        if FTitleButtons and (not UseDragCanvas) and (TitleClickColumn>=0) then
        begin
           if (TitleClickGroupTitle) then
           begin
           // Paint group or sub-group button
             if (TitleClickGroupTitle and (ARect.Top=0)) then TitleOffset:= 1;
           end
           else if (ACol+FIndicatorOffset=TitleClickColumn) then
           begin
              if (ARect.Top>0) or (Columns[ACol].GroupName='') then TitleOffset:=1
           end;
        end;

        if (TitleImageAttributes.ImageIndex>=0) and (TitleImageList<>Nil) and
           DrawCellInfo.DefaultDrawBackground then begin
           case TitleImageAttributes.Alignment of
             taRightJustify: begin
                 TitleImageList.Draw(Canvas,
                     ARect.Right-TitleImageList.Width-TitleImageAttributes.Margin + TitleOffset,
                     (ARect.Top + Arect.Bottom - TitleImageList.Height) div 2 + TitleOffset,
                     TitleImageAttributes.ImageIndex);
                 ATextRect:= ARect;
                 ATextRect.Right:=
                    wwmax(ARect.Right - TitleImageList.Width - TitleImageAttributes.Margin, ARect.Left)
               end;
             taLeftJustify: begin
                 TitleImageList.Draw(Canvas,
                     ARect.Left + TitleImageAttributes.Margin + TitleOffset,
                     (ARect.Top + Arect.Bottom - TitleImageList.Height) div 2 + TitleOffset,
                     TitleImageAttributes.ImageIndex);
                 ATextRect:= ARect;
                 ATextRect.Left:=
                    wwmin(ARect.Left + TitleImageList.Width + TitleImageAttributes.Margin, ARect.Right)
               end;
             taCenter: begin
                 TitleImageList.Draw(Canvas,
                     (ARect.Left + ARect.Right - TitleImageList.Width) div 2 + TitleOffset,
                     (ARect.Top + Arect.Bottom - TitleImageList.Height) div 2+ TitleOffset,
                     TitleImageAttributes.ImageIndex);
                 ATextRect:= ARect;
               end;
           end
        end;

        defaultTitleDrawing:= True;

        // Do we really need this as it currently paints in too big an area?
        {        if (ARect.Top>0) then // Subgroup case
        begin
            // Fill sub-grouping area
            if (not UseDragCanvas) or
               (UseDragCanvas and TitleClickGroupTitle) then
               FillWithTitleBitmaps(Rect(ARect.Left, CellRect(ACol, ARow).Top, ARect.Right, ARect.Top))
            else
              arow:= arow;
        end;
}
        if ACol<FieldCount then
        begin
           if (ARect.Top>0) or (Columns[ACol].GroupName='') then
             DoDrawTitleCell(Canvas, Fields[ACol], ARect, defaultTitleDrawing)
           else
             DoDrawGroupHeaderCell(Canvas, Columns[ACol].GroupName, ARect, defaultTitleDrawing)
        end;
        if DefaultTitleDrawing and (TitleImageAttributes.Alignment<>taCenter) then
        begin
          //3/30/2001 - PYW - Change DisplayLabel to the GroupName if we are drawing a group Title Cell.
          if (ACol>=0) and (Columns[ACol].GroupName<>'') then
          begin
             if (not (UseDragCanvas and ClickedOnGroupChild)) and
               (ARect.Top=0) then
                TempDisplayLabel := Columns[ACol].GroupName;
          end;

          Display(TempDisplayLabel, ATitleAlignment, (not ChangedBrushColor));
        end;
      end
      else begin
        if UseThemesIntitle then
        begin
           DoThemeBackground(False, [loNoVertLine], ARect)
        end
        else if DrawCellInfo.DefaultDrawBackground then
            FillWithTitleBitmaps(ARect);
      end
    end
    else if ACol < 0 then
    begin
      TempRect:= Rect(ARect.Left-1, ARect.Top-1, ARect.Right, ARect.Bottom+1);
      if (dgHideBottomDataLine in Options) then TempRect.Bottom:= TempRect.Bottom-1;

      if UseThemesInTitle then // ThemeServices.ThemesEnabled then
      begin
         DoThemeBackground(False, [loNoVertLine], TempRect)
      end
      else if DrawCellInfo.DefaultDrawBackground then
         FillWithFixedBitmap(TempRect, -1, {CurRelRow, }TitleColor);
      //3/30/2001 - PYW - Always Call ShowIndicator to support MultiSelect indicators in indicator column.
      if (DataLink<>nil) and DataLink.Active then
      begin
         ShowIndicator;
         if ARow = FDataLink.ActiveRecord-RowOffset then
         begin
            FSelRow := ARow + FTitleOffset;
         end;
      end
    end
    else if (DataLink = nil) or not DataLink.Active then begin
//       if not PaintOptions.HaveBackgroundForDataCells then FillRect(ARect)
    end
    else begin
      Value := '';
      OldActive := DataLink.ActiveRecord;
      try
	DataLink.ActiveRecord := ARow+FTopRecord+RowOffset;
	FCalcCellRow:= ARow;
	FCalcCellCol:= ACol;

        FieldMappedText:= False;
	Value := GetFieldValue(ACol);

	Highlight := HighlightCell(ACol, ARow, Value, AState);
        if TwwCacheColInfoItem(FCacheColInfo[ACol+FIndicatorOffset]).ControlType = 'URL-Link' then
        begin
          if (ACol + FIndicatorOffset = URLLinkActiveCol) and
             (ARow + FTitleOffset = URLLinkActiveRow) then
          begin
            Font.Color:= clRed;
            Font.Style:= Canvas.Font.Style + [fsUnderline];
          end
          else begin
            Font.Color:= clBlue;
            Font.Style:= Canvas.Font.Style + [fsUnderline];
          end
        end;

        SkipDefaultDrawing:= False;
	if Highlight then
	begin
           // 7/24/02 - Don't paint highlight background for cell with focus control if have themes
           if wwUseThemes(self) and IsChild(self.handle, GetFocus) then
               SkipDefaultDrawing:= True  // Don't paint cell as control is painting itself
           else if (not wwUseThemes(self)) or
              (not IsChild(self.handle, GetFocus))  then
           begin
              Brush.Color := GetHighlightColor;
              if not (dgRowSelect in Options) and
                (ARow=dbRow(Row)) and (ACol=dbCol(Col)) then
                Brush.Color:= clHighlight;

              Font.Color := clHighlightText;
           end
	end;

	DoCalcCellColorsDetect(GetColField(ACol), AState, Highlight, Font, Brush);

	Alignment := taLeftJustify;
	if ACol < FieldCount then Alignment := Fields[ACol].Alignment;
        if FieldMappedText then Alignment:= taLeftJustify;

        if DrawCellInfo.DefaultDrawBackground then
        begin
          if (ACol<FixedCols-FIndicatorOffset) then
          begin
             TempRect:= Rect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom+1);
             if (dgHideBottomDataLine in Options) then TempRect.Bottom:= TempRect.Bottom-1;
{             if ThemeServices.ThemesEnabled then
             begin
                DoThemeBackground(False, [loNoVertLine], TempRect)
             end
             else }FillWithFixedBitmap(TempRect, CurRelRow);
          end
          else if PaintOptions.HaveBackgroundForDataCells then begin
              FillWithBlendBitmap(ARect, CurRelRow);
          end
        end;

	if DefaultDrawing and (not SkipDefaultDrawing) and
           DrawCellInfo.DefaultDrawContents then begin
	   Display(Value, Alignment, (not Highlight) and (not ChangedBrushColor));
        end;

        try
   	  DrawDataCell(ARect, GetColField(ACol), AState);
        except
          // Do nothing if there was an exception.
        end;
      finally
	DataLink.ActiveRecord := OldActive;
      end;

      // Only Required if want row lines in drop-down list
//      if DrawCellInfo.DefaultDrawHorzLines then
         Draw3DLines(ARect, ACol+FIndicatorOffset, ARow+FTitleOffset, AState);
    end;

    DoOnAfterDrawCell;

  end;

end;

procedure TwwCustomDBGrid.ValidationErrorUsingMask(Field: TField);
//var msg: string;
//    doDefault: boolean;
begin
  wwInternational.ValidationErrorUsingMask(self, Field);
{  msg:= Format(SMaskEditErr, ['']);
  DoDefault:= True;
  if Assigned(FOnValidationErrorUsingMask) then
     FOnValidationErrorUsingMask(self, Field, msg, doDefault);
  if doDefault then
  begin
     MessageBeep(0);
     raise EInvalidOperation.create(Format(SMaskEditErr, ['']));
  end}
end;


{ Will move LeftCol so that Col is in view }
function TwwCustomDBGrid.CalcMaxTopLeft(const Coord: TGridCoord;
  const DrawInfo: TGridDrawInfo): TGridCoord;

  function CalcMaxCell(const Axis: TGridAxisDrawInfo; Start: Integer): Integer;
  var
    Line: Integer;
    I, Extent: Longint;
  begin
    Result := Start;
    with Axis do
    begin
      Line := GridExtent + EffectiveLineWidth;
      for I := Start downto FixedCellCount do
      begin
        Extent := GetExtent(I);
        if Extent > 0 then
        begin
          Dec(Line, Extent);
          Dec(Line, EffectiveLineWidth);
          if Line < FixedBoundary then
          begin
            if (Result = Start) and (GetExtent(Start) <= 0) then
              Result := I;
            Break;
          end;
          Result := I;
        end;
      end;
    end;
  end;

begin
  Result.X := CalcMaxCell(DrawInfo.Horz, Coord.X);
  Result.Y := CalcMaxCell(DrawInfo.Vert, Coord.Y);
end;

// Update LeftCol in case of fixed editable rows
procedure TwwCustomDBGrid.UpdateLeftCol(ACol: integer);
var
  DrawInfo: TGridDrawInfo;
  MaxTopLeft: TGridCoord;
  OldTopLeft: TGridCoord;
  Coord: TGridCoord;
begin
  if not HandleAllocated then Exit;
  CalcDrawInfo(DrawInfo);
  Coord.x:= ACol;
  Coord.y:= Row;
  with DrawInfo, Coord do
  begin
    if (X > Horz.LastFullVisibleCell) or
      (Y > Vert.LastFullVisibleCell) or (X < LeftCol) or (Y < TopRow) then
    begin
      OldTopLeft.x:=LeftCol;
      OldTopLeft.y:= TopRow;
      MaxTopLeft := CalcMaxTopLeft(Coord, DrawInfo);
//      Update;  // Complete painting
      if (X < LeftCol) and (X>=inherited FixedCols) then
      begin
         BeginUpdate;
         LeftCol := X;
         EndUpdate;
         TopLeftChanged;
         Invalidate;
      end
      else if X > Horz.LastFullVisibleCell then
      begin
         BeginUpdate;
         LeftCol := MaxTopLeft.X;
         EndUpdate;
         TopLeftChanged;
         Invalidate;
      end;
    end;
  end;
end;

procedure TwwCustomDBGrid.MoveCol(ACol: Integer);
var
  OldCol: Integer;
  DrawInfo: TGridDrawInfo;
  OldTopLeft, NewTopleft, Delta: TGridCoord;
  R: TRect;
//  editor: TwwInplaceEdit;
//  FOnInvalidValue: TwwInvalidValueEvent;

  function CalcScroll(const AxisInfo: TGridAxisDrawInfo;
    OldPos, CurrentPos: Integer; var Amount: Longint): Boolean;
  var
    Start, Stop: Longint;
    I: Longint;
  begin
    Result := False;
    with AxisInfo do
    begin
      if OldPos < CurrentPos then
      begin
        Start := OldPos;
        Stop := CurrentPos;
      end
      else
      begin
        Start := CurrentPos;
        Stop := OldPos;
      end;
      Amount := 0;
      for I := Start to Stop - 1 do
      begin
        Inc(Amount, GetExtent(I) + EffectiveLineWidth);
        if Amount > (GridBoundary - FixedBoundary) then
          Exit;
      end;
      if OldPos < CurrentPos then Amount := -Amount;
    end;
    Result := True;
  end;

begin

  FDatalink.UpdateData;
  if ACol >= FieldCount then ACol := FieldCount - 1;
  if ACol < 0 then ACol := 0;
  if not (dgFixedEditable in Options) and (ACol < (FixedCols - FIndicatorOffset)) then begin
     { Don't allow movement to a fixed column }
     ACol:= FixedCols - FIndicatorOffset;
  end;

  OldCol := Col - FIndicatorOffset;
  if ACol <> OldCol then
  begin
    OldTopLeft.x:=LeftCol;
    OldTopLeft.y:= TopRow;

    if not FInColExit then
    begin
      FInColExit := True;
      try
	ColExit;
      finally
	FInColExit := False;
      end;
      if Col - FIndicatorOffset <> OldCol then Exit;
    end;

    HideEditor;
    if (not SuppressShowEditor) and
       (dgAlwaysShowEditor in Options) and not isWWControl(ACol + FIndicatorOffset, row) then
    begin
       HideControls;
    end;

    if dgFixedEditable in Options then
    begin
      CalcDrawInfo(DrawInfo);
      if (ACol+FIndicatorOffset>DrawInfo.Horz.LastFullVisibleCell) or
         (ACol+FIndicatorOffset<LeftCol)  then
      begin
         inherited DefaultDrawing:=True; // Prevent background from erasing when horizontal scrolling
         // By calling MoveColRow, LeftCol is not automatically reset
         // We avoid LeftCol assignment so that we can move to a fixed
         // column without LeftCol changing
         MoveColRow(ACol+FIndicatorOffset, Row, True, False);

         // Now we need to set LeftCol in case the active column is not visible
         UpdateLeftCol(Col); //If Column not in view then Set LeftCol so it is in view

         inherited DefaultDrawing:=False;
      end
      else Col := ACol + FIndicatorOffset;
    end
    else
      Col := ACol + FIndicatorOffset;

    if (not SuppressShowEditor) and
       (dgAlwaysShowEditor in Options) and not isWWControl(ACol + FIndicatorOffset, row) then
    begin
       { 12/19/96 - Don't call showeditor if going to memo field}
       if (not isMemoField(ACol + FIndicatorOffset, row)) then
       begin
          if not (ecoDisableEditorIfReadonly in EditControlOptions) or
             (not Columns[ACol].ReadOnly) then
             inherited ShowEditor;
       end
    end;

    ColEnter;

    // Fix Scrolling painting bug with vertical line
    begin
      NewTopLeft.x:= Leftcol;
      NewtopLeft.y:= Toprow;
      CalcDrawInfo(DrawInfo);
      if (NewTopLeft.x<>OldTopLeft.x) then
      begin
        if CalcScroll(DrawInfo.Horz, OldTopLeft.X, NewTopLeft.X, Delta.X) then
        begin
           if UseRightToleftAlignment then
           begin
             r:= Rect(-Delta.X, 0, -Delta.X+1, ClientHeight);
             InvalidateRect(handle, @r, False);
           end
           else begin
             // 7/11/01 - White fixed line is scrolled into data area, so remove by repainting.
             r:= Rect(DrawInfo.Horz.FixedBoundary+Delta.X, 0,
                      DrawInfo.Horz.FixedBoundary+Delta.X+1, ClientHeight);
             if Delta.X>0 then
                InvalidateRect(handle, @r, False);
           end
        end
      end
    end
  end;
end;

function TwwCustomDBGrid.IsWWControl(ACol, ARow: integer): boolean;
begin
   result:= False;
end;

function TwwCustomDBGrid.CreateEditor: TInplaceEdit;
begin
  Result := TwwInplaceEdit.wwCreate(Self, 0);
end;

procedure TwwCustomDBGrid.KeyDown(var Key: Word; Shift: TShiftState);
var
  KeyDownEvent: TKeyEvent;
  editor: TwwInplaceEdit;
  DrawInfo: TGridDrawInfo;

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
            if CurrentCustomEdit<>nil then
            begin
//               currentCustomEdit.Left:= ClientWidth+10;
//               self.setfocus;
//               CurrentCustomEdit.visible:=False;
//               CurrentCustomEdit:=nil;
            end;
            Next;
         end
      end;
      if EOF and CanModify and (dgEditing in Options) and (dgAllowInsert in KeyOptions) then
      begin
	HideControls;
	Append;
      end;
    end
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

  procedure Tab(GoForward: Boolean);
  var
    ACol, Original: Integer;
    ParentForm: TCustomForm;
  begin

    ACol := SelectedIndex;
    Original := ACol;
    ParentForm := GetParentForm(Self) as TCustomForm;  { 12/6/99 - tab to next control in form }
//    if  = FixedCols then

    while True do
    begin

      if GoForward then
	Inc(ACol) else
	Dec(ACol);
      if ACol >= FieldCount then
      begin
	HideControls; { Necessary when all columns fit in grid's view }
        if (dgTabExitsOnLastCol in Options) then begin
           if ParentForm<>nil then ParentForm.Perform(wm_nextdlgctl, 0, 0);
           break;
        end
        else begin
           if (Original=0) and TabStops[FIndicatorOffset] then SuppressShowEditor:= True;
           NextRow;
{           if dgFixedEditable in Options then
              ACol:= 1
           else}
              ACol := 0;
        end
      end
      { 9/15/98 - Test for GoFoward when going back to previous row }
//      else if (not GoForward) and (dgFixedEditable in Options) and (ACol < (FixedCols - FIndicatorOffset)) then
//      begin
//      end
      else if (dgFixedEditable in Options) and (not GoForward) and (ACol < 0) then
      begin
	HideControls;
        if (dgTabExitsOnLastCol in Options) then begin
           if ParentForm<>nil then ParentForm.Perform(wm_nextdlgctl, 1, 0);
           break;
        end
        else begin
           if (FieldCount-1<>Original) and TabStops[(FieldCount-1) + FIndicatorOffset] then SuppressShowEditor:= True;
           PriorRow;
           ACol := FieldCount - 1;
        end
      end
      else if not (dgFixedEditable in Options) and (not GoForward) and (ACol < (FixedCols - FIndicatorOffset)) then { 7/10/98 - Support fixed columns }
      begin
	HideControls;
        if (dgTabExitsOnLastCol in Options) then begin
           if ParentForm<>nil then ParentForm.Perform(wm_nextdlgctl, 1, 0);
           break;
        end
        else begin
           if (FieldCount-1<>Original) and TabStops[(FieldCount-1) + FIndicatorOffset] then SuppressShowEditor:= True;
           PriorRow;
           ACol := FieldCount - 1;
        end
      end;
      if ACol = Original then Exit;
      if TabStops[ACol + FIndicatorOffset] then
      begin
	SuppressShowEditor:= False;
        if (ACol=FixedCols-FIndicatorOffset) and GoForward and (dgFixedEditable in Options) then
            ACol:= DrawInfo.Horz.FirstGridCell-FIndicatorOffset;
        if (ACol<FixedCols-FIndicatorOffset) and (dgFixedEditable in Options) then
        begin
          FDataLink.UpdateData; // 9/17/02 Allow fixed column to update
          HideControls;
          MoveColRow(ACol+FIndicatorOffset, Row, True, False);
          ColEnter; // Make sure event is fired
          invalidateEditor;
          LeftCol:= FixedCols;
          Exit;
        end
        else begin
          MoveCol(ACol);
          Exit;
        end
      end;

      SuppressShowEditor:= False;
    end;
  end;

  function DeletePrompt: Boolean;
  begin
    Result := not (dgConfirmDelete in Options) or
      (MessageDlg(
         {$ifdef wwDelphi3Up}
         SDeleteRecordQuestion,
         {$else}
         LoadStr(SDeleteRecordQuestion),
         {$endif}
         mtConfirmation, mbOKCancel, 0) <> idCancel);
  end;

  Function ShouldShowEditor: boolean;
  var tempField: TField;
  begin
      result:= False;
      tempField:= GetColField(dbCol(Col));
      if tempField=Nil then exit;
      if (tempField is TBlobField) then exit;  { Changed to TBlobField}
      if isWWControl(Col, Row) then exit;  {10/12/96 - Don't show editor for any customEdit }

      result:= True;
  end;

  function CustomEditChildHasFocus: boolean;
  begin
     if (currentCustomEdit<>nil) and
        (screen.activecontrol<>nil) and
        (screen.activecontrol.parent=currentcustomedit) then
        result:=True
     else result:=False
  end;


begin
  if IsDropDownGridFocused then exit;

  KeyDownEvent := OnKeyDown;

  if Assigned(KeyDownEvent) then KeyDownEvent(Self, Key, Shift);
  if not FDatalink.Active or not CanGridAcceptKey(Key, Shift) then Exit;

  CalcDrawInfo(DrawInfo);

  // SetFocus; // Important for radiogroup when radioitem has focus

  if key in [vk_up, vk_down, vk_next, vk_prior] then // Prevent flicker
  begin
     Update; // 3/9/01 - Allow previous scroll to complete
     if CurrentCustomEdit<>nil then CurrentCustomEdit.Left:= ClientWidth+10;
     if not AcquireFocus then exit;
  end;

  if not (ssCtrl in Shift) and UseRightToLeftAlignment then
  begin
    if Key = VK_LEFT then
      Key := VK_RIGHT
    else if Key = VK_RIGHT then
      Key := VK_LEFT;
  end;

  with FDatalink.DataSet do
    if ssCtrl in Shift then
    begin
{      if (Key in [vk_up, vk_prior, vk_down, vk_next, vk_left, vk_right,
                 vk_home, vk_end, vk_delete]) and CustomEditChildHasFocus then
         SetFocus;}
      case Key of
	VK_UP, VK_PRIOR: MoveBy(-FDatalink.ActiveRecord);
	VK_DOWN, VK_NEXT: MoveBy(FDatalink.BufferCount - FDatalink.ActiveRecord - 1);
	VK_LEFT: if parent is TwwDBGrid then
          begin
             TwwDBGrid(parent).CollapseChildGrid;
          end
          else if (CurrentCustomEdit is TwwExpandButton) then
          begin
             CollapseChildGrid;
          end
          else MoveCol(0);
	VK_RIGHT: if (CurrentCustomEdit is TwwExpandButton) then
                  begin
                     if not (IsDropDownGridShowing) then
                     begin
//                        RestoreRowHeights;
//                        TwwExpandButton(CurrentcustomEdit).Top:= Cellrect(Col, Row).Top;
//                        TwwExpandButton(CurrentcustomEdit).Height:= CellRect(Col, Row).Bottom-Cellrect(Col, Row).Top;
                        TwwExpandButton(CurrentCustomEdit).Expanded:=true;
                     end
                  end
                  else MoveCol(FieldCount - 1);
	VK_HOME: First;
	VK_END: Last;
	VK_DELETE: begin
	      if (dgAllowDelete in KeyOptions) and (not ReadOnly) and CanModify and
		 (dgEditing in Options) and DeletePrompt then
	      begin
		 Delete;
		 HideEditor; {10/3/96}
	      end;
	      Key:= 0; {10/3/96 }
	   end;
      end
    end
    else begin
      if (Key in [vk_up, vk_down, vk_left, vk_right,
                 vk_home, vk_end, vk_next, vk_prior, vk_delete,
                 vk_insert, vk_tab, vk_return]) and CustomEditChildHasFocus then begin
         SetFocus;
         {2/11/2002 - Need to place in a begin/end block as following code only applies to above case}
         if not AcquireFocus then exit;
      end;

      case Key of
	VK_UP: PriorRow;
	VK_DOWN: NextRow;
	VK_LEFT:
	  if dgRowSelect in Options then
	    PriorRow else
          begin
{            if (dgFixedEditable in Options) and (SelectedIndex<=FixedCols-FIndicatorOffset) then
            begin
               if (SelectedIndex>0) then
               begin
                 HideControls;
                 MoveColRow(SelectedIndex-1+FIndicatorOffset, Row, True, False);
                 InvalidateEditor;
               end
            end
	    else }
              MoveCol(SelectedIndex - 1);
          end;
	VK_RIGHT:
	  if dgRowSelect in Options then NextRow
          else begin
            if (dgFixedEditable in Options) and (SelectedIndex<FixedCols-FIndicatorOffset) then
            begin
               if SelectedIndex=FixedCols-FIndicatorOffset-1 then
                  MoveCol(DrawInfo.Horz.FirstGridCell-FIndicatorOffset)
               else MoveCol(SelectedIndex+1);
{               HideControls;
               if SelectedIndex=FixedCols-FIndicatorOffset-1 then
                  MoveColRow(DrawInfo.Horz.FirstGridCell, Row, False, False)
               else MoveColRow(SelectedIndex+1+FIndicatorOffset, Row, True, False);
              InvalidateEditor;
}
            end
	    else MoveCol(SelectedIndex + 1);
          end;
	VK_HOME:
	  if (FieldCount = 1) or (dgRowSelect in Options) then
	    First else
          begin
{              if (dgFixedEditable in Options) then
              begin
                 MoveCol(0);
                 HideControls;
                 MoveColRow(FIndicatorOffset, Row, True, False);
                 InvalidateEditor;

              end
              else}
                 MoveCol(0);
          end;
	VK_END:
	  if (FieldCount = 1) or (dgRowSelect in Options) then
	    Last else
	    MoveCol(FieldCount - 1);
	VK_NEXT: MoveBy(VisibleRowCount);
	VK_PRIOR: MoveBy(-VisibleRowCount);
	VK_INSERT: if not ReadOnly and
		  (dgEditing in Options) and (dgAllowInsert in KeyOptions) then Insert;
	VK_TAB:  if not (ssAlt in Shift) then Tab(not (ssShift in Shift));
	VK_RETURN: if dgEnterToTab in KeyOptions then Tab(not (ssShift in Shift));
	VK_ESCAPE:
	  begin
	    FDatalink.Reset;
	    if not (dgAlwaysShowEditor in Options) then HideEditor
	    else if Assigned(FOnCheckValue) then begin
	       if (InplaceEditor <> nil) then
	       begin
		  editor:= TwwInplaceEdit(InplaceEditor);
		  editor.IsValidPictureValue(editor.Text);
	       end
	    end
	  end;
	VK_F2: if ShouldShowEditor then EditorMode := True;
      end;
    end;
end;

type TCheatCast = class(TwwCustomDBGrid);

procedure TwwCustomDBGrid.KeyPress(var Key: Char);
var OrigKey: char;
begin
  OrigKey:= Key;
  if (dgEnterToTab in KeyOptions) and (ord(Key)=VK_RETURN) then Key:= #9;
  if not (dgAlwaysShowEditor in Options) and (Key = #13) then
    FDatalink.UpdateData;

  inherited KeyPress(Key);

  if not (dgAlwaysShowEditor in Options) and (OrigKey = #13) then
  begin
     if (not CanEditShow) and EditorMode then EditorMode:= false;

     if (not CanEditShow) or
       ((TCheatCast(self).CurrentCustomEdit<>nil) and
        wwGetWantReturns(TCheatCast(self).CurrentCustomEdit)) then
        Key:= OrigKey;
  end
end;

    procedure TwwCustomDBGrid.InvalidateTitle;
    var i: Integer;
    begin
       for i:= FIndicatorOffset to LeftCol + VisibleColCount do
       begin
          InvalidateCell(i, 0);
       end
    end;

procedure TwwCustomDBGrid.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var temp: integer;
    field: TField;
    Cell: TGridCoord;
    tempSizing: boolean;
    curgridstate:TGridState;
    NewHeight,DefaultRowHeight:Integer;
    temppercent:Integer;
    TempRect:TRect;
    StartCol,EndCol:Integer;

{    procedure InvalidateTitle;
    var i: Integer;
    begin
       for i:= FIndicatorOffset to LeftCol + VisibleColCount do
       begin
          InvalidateCell(i, 0);
       end
    end;
}
begin
   curgridstate := FGridState;
   tempSizing:= Sizing(X,Y);
   inherited MouseUp(Button, Shift, x, y);

   if TempSizing and (curGridState=gsColSizing) and Assigned(FOnColWidthChanged) then
   begin
      { 12/7/98 - Correct OnColWidthChanged event passing the wrong column }
      if (self is TwwDBGrid) then
        FOnColWidthChanged(Self, TwwDBGrid(self).Patch[2]);
   end;

   if (curGridState=gsRowSizing) and TempSizing and (dgRowResize in Options) and
      (FSizingIndex>=0) then
   begin
      if (Self is TwwDBGrid) then
      begin
         Canvas.Font := Font;
         DefaultRowHeight:= Canvas.Textheight('W') + NormalPad;
         if HaveAnyRowLines then DefaultRowHeight:= DefaultRowHeight + 1;

         NewHeight := RowHeights[FSizingIndex];
         if dgTitles in Options then
            NewHeight := wwMin(NewHeight, Trunc((ClientHeight-RowHeights[0]-1)))
         else
            NewHeight := wwMin(NewHeight, Trunc((ClientHeight-1)));

//         RowHeightPercent := Trunc((NewHeight*100.0) / DefaultRowHeight);

         tempPercent := wwMax(Trunc((NewHeight*100.0) / DefaultRowHeight), MinRowHeightPercent);
         if tempPercent <> FRowHeightPercent then begin
            RowHeights[FSizingIndex]:= NewHeight;
            FRowHeightPercent := tempPercent;
            LayoutChanged;
         end
         else begin // 10/01/2001 - Don't allow setting smaller than defaultrowheight. -PYW
            RowHeights[FSizingIndex]:= Trunc((DefaultRowHeight*MinRowHeightPercent)/100.0);
            FRowHeightPercent := tempPercent;
            LayoutChanged;
         end;
      end;
//      FSizingIndex:= -1;
   end;

   if (TitleClickColumn>=0) then begin
      Cell := MouseCoord(X, Y);
      Temp:= TitleClickColumn;
      TitleClickColumn:= -1;
      TitleClickGroupTitle := False;

{      if (dbCol(Cell.x)>=0) then begin
         if (Columns[dbCol(Cell.X)].GroupName = '') then
            InvalidateCell(Temp, 0)
         else begin
            TempRect := GroupNameCellRect(Cell.X,0,StartCol,EndCol);
            TempRect.Bottom := RowHeights[0]+1;
            TempRect.Right := TempRect.Right+1;
            InvalidateRect(Handle,@TempRect,False);
         end;
      end
      else begin
         InvalidateCell(Temp, 0)
      end;}
      InvalidateTitle; // 8/2/01

      if (Cell.X=Temp) and (Cell.Y=TitleClickRow) and (Y>=0) then
      begin
	 field:= GetColField(dbCol(Cell.X));
	 if (field<>nil) and (not SkipTitleButtonClick) then
         begin
            // 3/30/2001 - PYW - Call OnTitleButtonClick
            TempRect := TitleCellRect(Cell.X,0);
            if (dbCol(Cell.x)>=0) and (Columns[dbCol(Cell.X)].GroupName <> '') then begin
               TempRect := GroupNameCellRect(Cell.X,0,StartCol,EndCol);
               if PtInRect(TempRect,Point(X,Y)) then
                  DoTitleButtonClick(Columns[dbCol(Cell.X)].GroupName)
                  else DoTitleButtonClick(Field.FieldName)
            end
            else DoTitleButtonClick(Field.FieldName)
         end;
      end;
   end;
   //Clear Title Click Flags.
   ResetTitleClick;

  { 4/28/99 - Fix problem where fixed column didn't fire event after drag operation}
   SkipTitleButtonClick:= False;

   FSizingIndex:=-1;
end;

procedure TwwCustomDBGrid.DoTitleButtonClick(AFieldName: string);
begin
  if Assigned(FOnTitleButtonClick) then
     FOnTitleButtonClick(Self, AFieldName)
end;

procedure TwwCustomDBGrid.MouseLoop_DragColumn(HitTest: Integer; X, Y: Integer);
var ACursor: TPoint;
    DrawInfo: TGridDrawInfo;
    Msg: TMsg;
    FirstTime: boolean;
    RootRect, ATitleCellRect: TRect;
    DestRect{, TempRect}: TRect;
    tempx: integer;
    dragTo: integer;
    Cell, OrigCell: TGridCoord;
    Scrolled: boolean;

    CaptureTitleXOffset: integer;
    CaptureTitleMouseDirection: integer;
    CaptureTitleLastMovedPosition: integer;
    LastDestRect: TRect;
    DragFrom: integer;

    MaxWidth: integer;
    GridDisplayWidth: integer;
    ExtraDragOffset: integer;
    i, StartCol,EndCol: Integer;
    LastDragTo: integer;
    DragHorzTolerance: integer;

    procedure InvalidateThisRow;
    var i: Integer;
    begin
       for i:= LeftCol  to LeftCol + VisibleColCount do
       begin
          InvalidateCell(i, 0);
       end
    end;
    procedure UpdateDestRect;
    begin
       DestRect:= Rect(tempx, ExtraDragOffset+DragVertOffset,
                  tempx+CaptureTitleBitmap.Width,
                  ExtraDragOffset + DragVertOffset+CaptureTitleBitmap.Height);
    end;

    function ValidRect(ACol, ARow: integer): boolean;
    var r: TRect;
    begin
       r:= CellRect(ACol, ARow);
       result:=
         not( (r.left=0) and (r.right=0) and (r.top=0) and (r.bottom=0))
    end;

    procedure DrawDragLines(offsetleft:integer = 0);
    begin
        if CaptureTitleBitmap = nil then exit;

        CaptureTitleBitmap.Canvas.Pen.Color:= clBlack;
        CaptureTitleBitmap.Canvas.MoveTo(RootRect.Right-1, RootRect.Top);
        CaptureTitleBitmap.Canvas.LineTo(RootRect.Right-1, RootRect.Bottom-1);
        CaptureTitleBitmap.Canvas.LineTo(RootRect.Left, RootRect.Bottom-1);

        CaptureTitleBitmap.Canvas.Pen.Color:= clBtnHighlight;
        CaptureTitleBitmap.Canvas.MoveTo(RootRect.Right-1, RootRect.Top);
        CaptureTitleBitmap.Canvas.LineTo(RootRect.Left+offsetleft, RootRect.Top);
        CaptureTitleBitmap.Canvas.LineTo(RootRect.Left+offsetleft, RootRect.Bottom);
    end;

  procedure GroupMove;
  var
    curGroupName, destGroupName:string;
//    ClickedOnGroupName:boolean;
//    ClickedOnGroupChild:boolean;
    i,j: integer;
//    TempDragTo: integer;
  begin
     if ClickedOnGroupName or ClickedOnGroupChild then
     begin
        curGroupName := Columns[dbcol(OrigCell.x)].Groupname;
        if (ClickedOnGroupName) then
        begin
           // Update Drag to so that its not in middle of group
           DestGroupName := Columns[dbcol(DragTo)].Groupname;
           if (DestGroupName <>'') then
           begin
              if not ClickedOnGroupChild then
              begin
                 GroupNameCellRect(DragTo, 0, StartCol,EndCol);
                 if (DragTo<DragFrom) then DragTo:= StartCol
                 else DragTo:= EndCol;
              end
           end;

           GroupNameCellRect(DragFrom, 0, StartCol, EndCol, False); // Drag all group columns
{           startcol := 0;
           for i:=FIndicatorOffset to colcount-1 do begin
              if (dbcol(i)>=0) and (Columns[dbcol(i)].GroupName = curgroupname) then begin
                 if startcol = 0 then startcol := i;
                 endcol := i;
              end;
           end;
}
           if dragto > dragfrom then begin  // Dragging later
              j:=0;
              if (dragto > endcol) then begin
                 for i:= endcol downto startcol do begin
                    MoveColumn(i, DragTo-j);
                    inc(j);
                 end;
              end
           end
           else begin // Dragging before
              j:=0;
              if dragto < startcol then begin
                 for i:=  startcol to endcol do begin
                    MoveColumn(i, DragTo+j);
                    inc(j);
                 end;
              end
           end;
        end
        else begin
           // !!!! Still need to restrict cell.x to valid group range
           if (Cell.X>=FIndicatorOffset) and
             (ATitleCellRect.Top > 0) and (curGroupName = Columns[dbcol(Cell.x)].Groupname) then
              MoveColumn(DragFrom, DragTo)
        end;
     end
     else begin
       if (ATitleCellRect.Top = 0) or
          ((DragFrom > DragTo) and (TitleCellRect(Cell.X-1,0).Top=0))
          or ((DragFrom < DragTo) and (TitleCellRect(Cell.X+1,0).Top=0)) then
          begin
            GroupNameCellRect(DragTo,0,StartCol,EndCol, False);
            if (DragTo>=StartCol) and (DragTo<=EndCol) then
            begin
               if DragFrom>DragTo then // backwards movement to before group
                 DragTo:= StartCol
               else
                 DragTo:= EndCol;
            end;
            MoveColumn(DragFrom, DragTo);
            UpdateLeftCol(DragTo);
          end
          else if (TitleCellRect(DragTo,0).Top>0) then
          begin
             GroupNameCellRect(DragTo,0,StartCol,EndCol, False);
             if (CaptureTitleMouseDirection= ctmdBackward) then
                MoveColumn(DragFrom, StartCol)
             else if (CaptureTitleMouseDirection= ctmdForward) then
                MoveColumn(DragFrom, EndCol);
          end;
     end;

//    InvalidateThisRow;
end;

  // Paint drag icon here
  procedure PaintDragIcon(ForceRefresh: boolean = False);
  var TempDragTo: integer;
      TempRect: TRect;
      DragIconWidth: integer;
//      i: integer;
      curGroupName: string;
      TempTop: integer;

      function DragBefore: boolean;
      begin
         if useRightToleftAlignment then
            result:= (TempDragTo>DragFrom)
         else
            result:= (TempDragTo<DragFrom)
      end;

      function DragAfter: boolean;
      begin
         if useRightToleftAlignment then
            result:= (TempDragTo<DragFrom)
         else
            result:= (TempDragTo>DragFrom)
      end;

  begin
     if useRightToLeftAlignment then ChangeOrientation(True);
     Cell := MouseCoord(ACursor.X, 0); //ACursor.Y);
     DragIconWidth:= DragImages.Width;

     if (LeftCol+VisibleColCount>=ColCount) and
        (ACursor.X>CellRect(ColCount-1, 0).Right) then
        TempDragTo:= ColCount-1
     else begin
        TempDragTo:= Min(Cell.X, ColCount-1);
        TempDragTo:= Max(TempDragTo, inherited FixedCols);
     end;

     // Don't allow painting in any group header because we
     // started from a group child
     curGroupName := Columns[dbcol(TempDragTo)].Groupname;
     if (curGroupName <>'') then
     begin
        if not ClickedOnGroupChild then
        begin
           GroupNameCellRect(TempDragTo, 0, StartCol,EndCol);
           if (TempDragTo<DragFrom) then
           begin
              TempDragTo:= StartCol;
           end
           else
              TempDragTo:= EndCol;
        end
     end;

     if ClickedOnGroupChild then
     begin
        // Force to be in group
        GroupNameCellRect(DragFrom,0,StartCol,EndCol, False);
        if (TempDragTo<StartCol) then TempDragTo:= StartCol
        else if (TempDragTo>EndCol) then TempDragTo:= EndCol;
     end;

     if (TempDragTo<>LastDragTo) or ForceRefresh then
     begin
         CalcDrawInfo(DrawInfo);

         if dgIndicator in Options then // Don't repaint indicator header
         begin
            if UseRightToleftAlignment then
              TempRect:= Rect(0, 0, ClientWidth-ColWidths[0]-1, RowHeights[0])
            else
              TempRect:= Rect(ColWidths[0]+1, 0, ClientWidth, RowHeights[0])
         end
         else
            TempRect:= Rect(0, 0, ClientWidth, RowHeights[0]);
         InvalidateRect(Handle, @TempRect, False);

         // Leave title drag box validated so it does not flicker
         tempx:= ACursor.x - CaptureTitleXOffset;
         UpdateDestRect;
         ValidateRect(Handle, @DestRect);

         Update;

         // Need to be dragging before group to show arrows
         if ClickedOnGroupName and
            (Columns[dbCol(DragFrom)].GroupName =
             Columns[dbCol(TempDragTo)].GroupName) then exit;

         tempTop:= 0;
         if ClickedOnGroupChild then
           tempTop:= TitleCellRect(DragFrom, 0).Top;

         if DragBefore then
         begin
            if Not ValidRect(TempDragTo, 0) then exit;
            // Need to be dragging in group to show arrows

            if TempDragTo>FIndicatorOffset then
               DragImages.Draw(inherited Canvas, CellRect(TempDragTo, 0).Left-DragIconWidth, TempTop, 0, True);
            DragImages.Draw(inherited Canvas, CellRect(TempDragTo, 0).Left+1, TempTop, 1, True);
         end
         else if DragAfter then begin
            if Not ValidRect(TempDragTo, 0) then exit;

            if TempDragTo>DrawInfo.Horz.LastFullVisibleCell + 1 then
            begin
               DragImages.Draw(inherited Canvas,
                  ClientWidth-DragIconWidth, TempTop, 0, True);
            end
            else begin
                DragImages.Draw(inherited Canvas,
                    wwMin(CellRect(TempDragTo, 0).Right, ClientWidth)-
                    DragIconWidth, TempTop, 0, True);
                DragImages.Draw(inherited Canvas,
                    CellRect(TempDragTo, 0).Right, TempTop, 1, True);
            end
         end
      end;
      LastDragTo:= TempDragTo;
      if useRightToLeftAlignment then ChangeOrientation(False);
   end;

begin
   SetCapture(Handle);
   FirstTime:= True;
//   if useRightToLeftAlignment then ChangeOrientation(True);

   { Make compiler happy with the following 3 assignments }
   CaptureTitleMouseDirection:= ctmdNone;
   CaptureTitleLastMovedPosition:= 0;
   CaptureTitleXOffset:= 0;
   ClickedOnGroupName:=False;
   ClickedOnGroupChild:=False;

   DragFrom:= 0;
   GridDisplayWidth:= Width;
   SkipTitleButtonClick:= False;

   try
      while GetCapture = Handle do
      begin
         GetCursorPos(ACursor);
         ACursor := ScreenToClient(ACursor);

         // Force to be within grid's boundaries
         ACursor.X:= wwLimit(ACursor.x, 0, ClientWidth);
         ACursor.Y:= wwLimit(ACursor.y, 0, ClientHeight);

         case Integer(GetMessage(Msg, 0, 0, 0)) of
           -1: Break;
           0: begin PostQuitMessage (Msg.WParam); Break; end;
         end;

         case Msg.Message of
            WM_TIMER: begin
               if (msg.hwnd<>Handle) then
               begin
                  TranslateMessage(Msg);
                  DispatchMessage(Msg);
                  continue;
               end;

               if CaptureTitleBitmap=nil then continue;

               Scrolled:= False;
//               if (ACursor.x-CaptureTitleXOffset+CaptureTitleBitmap.Width>GridDisplayWidth) and
               DragHorzTolerance:= 10;
               if (ACursor.x>GridDisplayWidth-DragHorzTolerance) and
                  (CaptureTitleMouseDirection = ctmdForward) then
               begin
                  // Don't scroll if end of group is already fully visible
                  if ClickedOnGroupChild then
                  begin
                    GroupNameCellRect(DragFrom,0,StartCol,EndCol, False);
                    if (EndCol<=DrawInfo.Vert.LastFullVisibleCell) then
                       continue;
                  end;

                  if LeftCol+VisibleColCount>=ColCount then
                     continue;
                  BeginUpdate;
                  LeftCol:= LeftCol + 1;
                  EndUpdate;
                  Invalidate;
                  Scrolled:= True;
               end
               else if ((ACursor.x-DragHorzTolerance)<CellRect(LeftCol, 0).Left) and
//               else if (ACursor.x-CaptureTitleXOffset<CellRect(LeftCol, 0).Left) and
                  (CaptureTitleMouseDirection = ctmdBackward) then
               begin
                  if LeftCol<=inherited FixedCols then continue;
                  // Don't scroll if end of group is already fully visible
                  if ClickedOnGroupChild then
                  begin
                    GroupNameCellRect(DragFrom,0,StartCol,EndCol, False);
                    if (StartCol< LeftCol) then
                       continue;
                  end;
                  BeginUpdate;
                  LeftCol:= LeftCol - 1;
                  EndUpdate;
                  Invalidate;
                  Scrolled:= True;
//                  Update;
//                  PaintDragIcon(True);
               end;
               if Scrolled then
               begin
                  tempx:= ACursor.x - CaptureTitleXOffset;
                  UpdateDestRect;
//                  InvalidateRect(Handle, @LastDestRect, False);
                  ValidateRect(Handle, @DestRect);
                  Update;
                  PaintDragIcon(True);
               end;

(*               if Scrolled then
               begin
                  tempx:= ACursor.x - CaptureTitleXOffset;
                  UpdateDestRect;
                  ValidateRect(Handle, @DestRect);
                  Update;
                  // Use inherited canvas as don't need temp canvas for drag
                  inherited Canvas.CopyRect(DestRect, CaptureTitleBitmap.Canvas, RootRect);
                  LastDestRect:= DestRect;
                  Update;
               end
*)
            end;

            WM_MOUSEMOVE: begin
               if FirstTime then begin
                  if (abs(X-ACursor.X)<=2) and (abs(y-ACursor.Y)<=2) then continue;

                  //Clear Title Click Flags.
                  ResetTitleClick;

                  SkipTitleButtonClick:= True;
                  Cell := MouseCoord(X, Y);
                  OrigCell:= Cell;
//                  ATitleCellRect:= TitleCellRect(Cell.X, Cell.Y);
                  ATitleCellRect:= DragTitleCellRect(Cell.X,ACursor.X,ACursor.Y);

                  //Set flags based on where the initial click was.
                  if (ATitleCellRect.Top = 0) then
                  begin
                     if (dbCol(Cell.x)>=0) and
                        (Columns[dbCol(Cell.X)].GroupName <> '') then
                        ClickedOnGroupName := true
                  end
                  else if (ATitleCellRect.Top > 0) then
                     ClickedOnGroupChild := True;

                  ExtraDragOffset:= ATitleCellRect.Top-CellRect(Cell.X, Cell.Y).Top;
                  CaptureTitleBitmap:= TBitmap.create;
                  CaptureTitleBitmap.Width:= max(ATitleCellRect.Right-ATitleCellRect.Left, ColWidths[Cell.X]);
                  MaxWidth:= Width-10;

                  if ShowVertScrollBar then MaxWidth:= MaxWidth - GetSystemMetrics(SM_CXHThumb) + 1;
                  if dgIndicator in Options then MaxWidth:= MaxWidth - ColWidths[0] - 2;

                  CaptureTitleBitmap.Width:= min(CaptureTitleBitmap.Width, MaxWidth);
                  CaptureTitleBitmap.Height:= ATitleCellRect.Bottom-ATitleCellRect.Top;
                  CaptureTitleXOffset:= X-ATitleCellRect.Left;
                  RootRect:= Rect(0, 0, CaptureTitleBitmap.Width, CaptureTitleBitmap.Height);
                  UseDragCanvas:= True;

                  if ClickedOnGroupName then begin  // Paint Group and its sub-items
                     GroupNameCellRect(Cell.X,Cell.Y,StartCol,EndCol, False);
                     RootRect.Bottom := CaptureTitleBitmap.Height div 2;
                     DrawCell(Cell.X, Cell.Y, RootRect, [gdFixed]);
                     DrawDragLines;
                     RootRect.Top := (CaptureTitleBitmap.Height div 2);
                     RootRect.Bottom := CaptureTitleBitmap.Height;
                     for i:= StartCol to EndCol do begin
                        RootRect.right := RootRect.Left +TitleCellRect(i,Cell.Y).right-TitleCellRect(i,Cell.Y).left;
                        DrawCell(i, Cell.Y, RootRect, [gdFixed]);
                        DrawDragLines(-1);
                        RootRect.Left := RootRect.Right + 1;
                     end;
                     RootRect:= Rect(0, 0, CaptureTitleBitmap.Width, CaptureTitleBitmap.Height);
                  End
                  else begin
                     DrawCell(Cell.X, Cell.Y, RootRect, [gdFixed]);
                  end;

                  UseDragCanvas:= False;

                  DrawDragLines;

                  DragFrom:= Cell.X;
//                  GroupDrag:= TitleCellRect(Cell.Y, 0).Top=0;
                  CaptureTitleMouseDirection:= ctmdNone;
                  CaptureTitleLastMovedPosition:= X;
                  LastDestRect:= Rect(0,0,0,0);

                  SetTimer(Handle, 1, 100, nil);
                  if IsScrollBarVisible then
                     GridDisplayWidth:= Width - GetSystemMetrics(SM_CXHThumb)
                  else
                     GridDisplayWidth:= Width;

                  FirstTime:= False;
                  LastDragTo:= -1;
               end
               else begin // Not first time
                  tempx:= ACursor.x - CaptureTitleXOffset;
                  UpdateDestRect;
                  InvalidateRect(Handle, @LastDestRect, False);
                  ValidateRect(Handle, @DestRect);
                  Update;

                  // Use inherited canvas as don't need temp canvas for drag
                  inherited Canvas.CopyRect(DestRect, CaptureTitleBitmap.Canvas, RootRect);
                  LastDestRect:= DestRect;
                  if ACursor.X>CaptureTitleLastMovedPosition then
                     CaptureTitleMouseDirection:= ctmdForward
                  else if ACursor.X<CaptureTitleLastMovedPosition then // 1/21/01
                     CaptureTitleMouseDirection:= ctmdBackward;
                  CaptureTitleLastMovedPosition:= ACursor.X;

                  PaintDragIcon;
               end;
            end;

            WM_LBUTTONUP: begin
               if not FirstTime then
               begin
                  if useRightToLeftAlignment then ChangeOrientation(true);

                  KillTimer(Handle, 1);
                  InvalidateRect(Handle, @LastDestRect, False);
                  CaptureTitleBitmap.Free;
                  CaptureTitleBitmap:= nil;
                  Cell := MouseCoord(ACursor.X, 5); //ACursor.Y);
                  LastDestRect:= Rect(0,0,0,0);

                  { Make sure that DragTo isn't more than last column }
                  if (LeftCol+VisibleColCount>=ColCount) and
                     (ACursor.X>CellRect(ColCount-1, 0).Right) then
                     DragTo:= ColCount-1
                  else begin
                     DragTo:= Min(Cell.X, ColCount-1);
                     DragTo:= Max(DragTo, inherited FixedCols);
                  end;
                  TitleClickColumn:= -1;
                  if DragFrom<>DragTo then
                  begin
                     // If group is involved in drag operation
                     if ClickedOnGroupName or // RSW - TitleCellRect not valid for non-visible columns
//                     if (TitleCellRect(DragFrom,0).Top>0) or
                        ClickedOnGroupChild or
                        (TitleCellRect(DragTo,0).Top>0) then
                     begin
                        GroupMove;
                     end
                     else MoveColumn(DragFrom, DragTo)
                  end;
                  if useRightToLeftAlignment then ChangeOrientation(False);
                  InvalidateThisRow;
//                  else InvalidateCell(OrigCell.X, 0);
               end;
               if GetCapture = Handle then ReleaseCapture;
               TranslateMessage(Msg);
               DispatchMessage(Msg);
            end
            else begin
               TranslateMessage(Msg);
               DispatchMessage(Msg);
            end
         end { Case }
      end;
   finally
       if GetCapture = Handle then ReleaseCapture;
   end;
end;


procedure TwwCustomDBGrid.DoCellChanged;
begin
  if not DisableCellChangedEvent then
  begin
     CollapseChildGrid;
{     for i:= 0 to ControlCount-1 do begin
        if (Controls[i] is TwwExpandButton) then
        begin
            expandButton:= TwwExpandButton(Controls[i]);
            if (expandbutton.grid<>nil) and
               (expandButton.Grid.visible) then
            begin
               ExpandButton.checked:= False;
               break;
            end
        end
     end;
 }
     if Assigned(FOnCellChanged) then
        FOnCellChanged(self);
  end;
end;

procedure TwwCustomDBGrid.DoURLOpen(var URLLink: string; Field: TField; var UseDefault: boolean);
begin
   if Assigned(FOnURLOpen) then FOnURLOpen(self, URLLink, Field, UseDefault);
end;

procedure TwwCustomDBGrid.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Cell: TGridCoord;
  CellChanged: boolean;
  TempOnMouseDown: TMouseEvent;
  NewRow: boolean;
  TempShiftSelectBookmark: TBookmark;
  SendMouseMessage: boolean;
  OldLeftCol: integer;
  pt: TPoint;
  MouseControl: TControl;
  OrigRowOffset, OrigRow: integer;
  SaveUpdateRect: TRect;
  DrawInfo:TGridDrawInfo;
  adummy:Integer;
  curGridState:TGridState;
  TempCustomEdit: TWinControl;
  GlyphRect: TRect;
  UseDefault: boolean;
  LinkAddress: string;
  URLDisplay: string;
  pos1, pos2: integer;
  CustomEdit: TWinControl;

  Procedure CallMouseDown;
  begin
    TempOnMouseDown:= OnMouseDown;
    if Assigned(TempOnMouseDown) then begin
       update;
       TempOnMouseDown(Self, Button, Shift, X, Y);
    end
  end;
{
  procedure ProcessTitleClick;
  begin
    if TitleButtons and (ssLeft in Shift) and not (csDesigning in ComponentState) then
    begin
       Cell := MouseCoord(X, Y);
       if (Cell.Y < FTitleOffset) then
       begin
	  TitleClickColumn:= Cell.X;
	  TitleClickRow:= Cell.y;
	  InvalidateCell(Cell.X, 0);
       end
    end;
  end;
}
  procedure ProcessTitleClick;
  var StartCol,EndCol:Integer;
      TempRect: TRect;
  begin
    if TitleButtons and (ssLeft in Shift) and not (csDesigning in ComponentState) then
    begin
       Cell := MouseCoord(X, Y);
       if (Cell.Y < FTitleOffset) and (Cell.X>=FIndicatorOffset) then // 9/16/02 (Ignore Title buttons for indicator column)
       begin
	  TitleClickColumn:= Cell.X;
	  TitleClickRow:= Cell.y;
	  InvalidateCell(Cell.X, 0);

          TitleClickGroupTitle := False;
          if (dbCol(Cell.x)>=0) then begin
             if (Columns[dbCol(Cell.X)].GroupName <> '') then begin
               TempRect := GroupNameCellRect(Cell.X,0,StartCol,EndCol);
               if Y <= TempRect.Bottom then begin
                 TitleClickGroupTitle := True;
               end
               else TempRect := TitleCellRect(Cell.X,0);
               TempRect.Right := TempRect.Right+1;
               TempRect.Bottom := TempRect.Bottom+1;
               InvalidateRect(Handle,@TempRect,False);
             end;
          end
       end
    end;
  end;

  procedure CheckAutoSizeColumn;
  var gc:TGridCoord;
      pt:TPoint;
  begin
     if not (dgDblClickColSizing in Options) then exit;
     pt := ScreenToClient(Mouse.CursorPos);
     pt.X := pt.x-5;
     gc := MouseCoord(pt.x,pt.y);
     if (gc.y>=FTitleOffset) then exit; 
     if pt.X < TitleCellRect(gc.x,0).Right-8 then exit;
     AutoSizeColumn(gc.X);
  end;

begin
// 3/8/00 - AcquireFocus not blindly called as it causes currentcustomedit to repaint
// which may cause slight flicker for active cell
//  if not AcquireFocus then Exit;
  FSizingIndex:= -1;
  FPriorSizingWidth:= 0;
  FreeHintWindow;
  OrigRow:= Row;
  OrigRowOffset:=0;
  NewRow:= False;
  if (CurrentCustomEdit is TwwExpandButton) then
     OrigRowOffset:= RowOffset;

  if (ssDouble in Shift) and (Button = mbLeft) then
  begin
    if not AcquireFocus then Exit;
    DblClick;
    CheckAutoSizeColumn;
    Exit;
  end;
  if Sizing(X, Y) then begin
    if (dgRowResize in Options) or
       (IsProportionalColumns) then
    begin
       CalcDrawInfo(DrawInfo);
       CalcSizingState(X, Y, curGridState, FSizingIndex, aDummy, aDummy, DrawInfo);
       if curGridState = gsColSizing then
          FPriorSizingWidth:= ColWidths[FSizingIndex];
    end;
    { 12/7/98 - Correct OnColWidthChanged event passing the wrong column }
    Cell := MouseCoord(X-8, Y);
    if Self is TwwDBGrid then TwwDBGrid(self).Patch[2]:= Cell.X;

    FDataLink.UpdateData;    { 2/7/97 - Flush data to TField if modified }
    inherited MouseDown(Button, Shift, X, Y)
  end
  else begin
    Cell := MouseCoord(X, Y);
    SendMouseMessage:=((Row<>Cell.Y) or (Col<>Cell.X)) and
      (Cell.X>=FIndicatorOffset);
    OldLeftCol:= LeftCol;

//    if Cell.Y<FTitleOffset then begin  // 5/18/01 - Use FTitleOffset intead
    if Cell.Y<0 then begin
       if not AcquireFocus then Exit;
       CallMouseDown;
       exit;
    end;
    {12/21/97 - Use goColMoving instead of dgColumnResize.  Developer can
     then progmatically set goColMoving to False, while leaving the column
     sizing as True. }
    if ((csDesigning in ComponentState) or (goColMoving in inherited Options)) and
      (Cell.Y < FTitleOffset) then
    begin
       if not AcquireFocus then Exit;

       {10/15/97 - Allow resize even if titlebuttons is True }
       ProcessTitleClick;

       { Copy title snapshot to bitmap - Use when mouse moves }
       if Cell.X>=inherited FixedCols then
       begin
           if ssLeft in Shift then MouseLoop_DragColumn(0, X, Y);
           CallMouseDown;
           exit;
       end;

       inherited MouseDown(Button, Shift, X, Y);
    end
    else if (not (goColMoving in inherited Options)) and (Cell.Y < FTitleOffset) then
    begin
       if not AcquireFocus then Exit;
       ProcessTitleClick
    end
    else begin
      if FDatalink.Active then
	with Cell do
	begin
	  if (X = Col) and (Y = Row) and not isWWControl(col, row) and
	    (not isMemoField(col, row)) then
               //3/3/2002-PYW-Don't showeditor if this is the right mouse button.
               if Button<>mbRight then ShowEditor;  { Don't show internal editor if memo field }
	  NewRow:=(Y >= FTitleOffset) and (Y - Row <> 0);
	  if NewRow then SuppressShowEditor:= True;

          CellChanged:= (y<>row) or (x<>col);
          DisableCellChangedEvent:= True;
          if CellChanged and (CurrentCustomEdit<>nil) then
             currentCustomEdit.Left:= ClientWidth+10;
          if not AcquireFocus then Exit;

          if not (dgRowSelect in Options) then { 9/3/99 - Don't reset LeftCol }
          begin
             if (X >= inherited FixedCols) then
                MoveCol(X - FIndicatorOffset)
             else if (dgFixedEditable in Options) then
             begin
                MoveCol(X - FIndicatorOffset);
//                HideControls;
//                MoveColRow(X, Row, True, False);
//                invalidateEditor;
//                LeftCol:= FixedCols;
             end
          end;
	  SuppressShowEditor:= False;

	  if NewRow then begin
             // Temporary hide currentcustomedit so it nots painted until after we move to a new record
             FDatalink.Dataset.MoveBy(Y - OrigRow);
          end;
          DisableCellChangedEvent:= False;

          if CellChanged then DoCellChanged;

          // Support url links
          if (x>=0) and (Button = mbLeft) and
            (TwwCacheColInfoItem(FCacheColInfo[x]).ControlType='URL-Link') then
          begin
             UseDefault:= True;
             if Fields[X-FIndicatorOffset]<>nil then
             begin
                GetURLLink(FDataLink.DataSet.FieldByName(Fields[X-FIndicatorOffset].FieldName).asString,
                           URLDisplay, LinkAddress);
                DoURLOpen(LinkAddress,
                   Fields[x-FIndicatorOffset], UseDefault);
                if UseDefault then
                begin
                   if AnsiPos('MAILTO:', AnsiUpperCase(LinkAddress))<=0 then
                   begin
                      pos1:= AnsiPos('@', LinkAddress);
                      pos2:= AnsiPos('.', LinkAddress);
                      if (pos1>1) and (pos2>pos1) then
                         LinkAddress:= 'MailTo:' + LinkAddress;
                   end;

                   Screen.Cursor:= crHourGlass;
                   ShellExecute(Handle, 'OPEN', PChar(LinkAddress), nil, nil, sw_shownormal);
                   Screen.Cursor:= crDefault; { 10/30/98 - Restore to default cursor }
                end
             end
          end;

          TempShiftSelectBookmark:= ShiftSelectBookmark; { 5/13/98 }

	  if (dgMultiSelect in Options) and not isSelectedCheckbox(X) then
          begin
             if ((ssCtrl in Shift) or (ssShift in Shift)) then
             begin
                if isSelected then UnselectRecord
                else SelectRecord;
             end
             else begin {7/10/97 - Unselect all only if left button is clicked - Allows popupmenu}
                if (msoAutoUnselect in MultiSelectOptions) and (ssLeft in Shift) then
                begin
                   UnselectAll;
                   SelectRecord;
                end
             end
          end;

          if (dgMultiSelect in Options) and
             ((ssShift in Shift) or (ssCtrl in Shift) or (msoAutoUnselect in MultiSelectOptions)) then
          begin
             if (msoShiftSelect in MultiSelectOptions) then
             begin
                ShiftSelectMode:= True;
                FDataLink.dataset.checkBrowseMode;

                { 5/13/98 - Only Getbookmark one time as SelectRecord can get bookmark}
                if TempShiftSelectBookmark=ShiftSelectBookmark then
                   ShiftSelectBookmark:= FDataLink.DataSet.GetBookmark;
             end
          end

	end;

     // Send mouse message to control that has just become visible
     InvalidateCell(Col, Row);

     // Don't call Update until later if expandbutton collapsing and expanding
     //Update currentCustomEdit manually instead of by calling update
     if (not (ecoDisableCustomControls in EditControlOptions)) and
//         ((dgEditing in Options) and (not ReadOnly)) and
         isCustomEditCell(Col, Row, customEdit) and
         (CustomEdit is TwwExpandButton) then
     begin
        // Following code prevents flicker when collapsing and expanding
        UpdateCustomEdit;
     end
     else begin
        // Following code prevents flicker when collapsing and expanding
        Windows.GetUpdateRect(Handle, SaveUpdateRect, false);
        ValidateRect(handle, nil);
        InvalidateCell(Col, Row);
        Update; // Allows CurrentCustomEdit to be assigned correctly
        InvalidateRect(Handle, @SaveUpdateRect, False);
     end;

      // Following code prevents flicker when collapsing and expanding
{      Windows.GetUpdateRect(Handle, SaveUpdateRect, false);
      ValidateRect(handle, nil);
      InvalidateCell(Col, Row);
      Update; // Allows CurrentCustomEdit to be assigned correctly
      InvalidateRect(Handle, @SaveUpdateRect, False);
}

{     if not (SendMouseMessage and NewRow and (OrigRowOffset<>0) and
             (Leftcol=OldLeftCol) and (Cell.X=Col)) then
     begin
//        Update; // Allows CurrentCustomEdit to be updated
        Windows.GetUpdateRect(Handle, SaveUpdateRect, false);
        ValidateRect(handle, nil);
        InvalidateCell(Col, Row);
        Update; // Allows CurrentCustomEdit to be updated
        InvalidateRect(Handle, @SaveUpdateRect, False);
     end
     else begin
        // Following code prevents flicker when collapsing and expanding
        Windows.GetUpdateRect(Handle, SaveUpdateRect, false);
        ValidateRect(handle, nil);
        InvalidateCell(Col, Row);
        Update; // Allows CurrentCustomEdit to be updated
        InvalidateRect(Handle, @SaveUpdateRect, False);
     end;
}

     if SendMouseMessage and (CurrentCustomEdit<>nil) and
       not wwIsClass(CurrentCustomEdit.ClassType, 'TCustomEdit') and
       (LeftCol=OldLeftCol) and not (ssCtrl in Shift) then
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
//           1. Get Control for Cell.X column
//           2. If expand button and on left-side then try to expand
           if IsCustomEditCell(Cell.X, Cell.Y, tempCustomEdit) and
              (tempCustomEdit = CurrentCustomEdit) and
              (CurrentCustomEdit is TwwExpandButton) and NewRow then //and (OrigRowOffset>0) then
           begin
                TwwExpandButton(CurrentCustomEdit).ComputeGlyphRect(glyphRect);
                InflateRect(GlyphRect, 4, 3);
                GlyphRect.Top:= 0;
                pt:= Point(x-CurrentCustomEdit.Left, 7);
                if ptInRect(GlyphRect, pt) then
                begin
                   if NewRow and (OrigRow+OrigRowOffset>Row) and (OrigRowOffset>0) then
                      TwwExpandButton(CurrentCustomEdit).DesiredRow:= Cell.Y
                   else TwwExpandButton(CurrentCustomEdit).DesiredRow:= -1;

                   RowOffset:= OrigRowOffset;
                   try
                      TwwExpandButton(CurrentCustomEdit).Expanded:=True;
//                Update; // Update after assigning rowoffset, so no flicker
                   finally
                      TwwExpandButton(CurrentCustomEdit).DesiredRow:= -1;
                   end
                end
           end
           else begin
             //! Don't want to send message unless its a button kind of control
             if not (CurrentCustomEdit is TCustomEdit) then
               SendMessage(CurrentCustomEdit.handle, wm_lbuttondown,
                0, MakeLParam(x-CurrentCustomEdit.Left, y-CurrentCustomEdit.Top));
           end;
        end
     end;
    end;
    CallMouseDown;
  end;

  if (CurrentCustomEdit<>nil) and
     wwIsClass(CurrentCustomEdit.classtype, 'TwwDBRichEdit') then
     TwwDBRichEdit(CurrentCustomEdit).ClickTime := GetMessageTime;
     // Save last MouseDown time
     // Use in custom control if it wants to
     // send dbl-click to the grid

end;

procedure TwwCustomDBGrid.InvalidateFooter;
var FooterRect: TRect;
begin
   FooterRect:= GetFooterRect;
   InvalidateRect(Handle, @FooterRect, false);
end;

procedure TwwCustomDBGrid.ColEnter;
begin
//  if GetColField(dbCol(Col))<>Nil then
//     OriginalCellText:= GetColField(dbCol(Col)).asString
//  else OriginalCellText:= '';

  if Assigned(FOnColEnter) then begin
     FOnColEnter(Self);
  end;
  DoCellChanged;
end;

procedure TwwCustomDBGrid.ColExit;
begin
  if Assigned(FOnColExit) then FOnColExit(Self);
end;

procedure TwwCustomDBGrid.ColumnMoved(FromIndex, ToIndex: Longint);
var temp: string;
    FooterRect: TRect;
begin
  FromIndex:= FromIndex  - FIndicatorOffset;
  ToIndex := ToIndex - FIndicatorOffset;

  if useTFields then begin
     if FDatalink.Active and (FieldCount > 0) then
       Fields[FromIndex].Index := Fields[ToIndex].Index;
  end
  else begin
     { 12/11/97 - Insert in front instead of switching columns }
     Temp:= Selected[FromIndex];
     Selected.Delete(FromIndex);
     Selected.Insert(ToIndex, Temp);
     LayoutChanged;
  end;
  FooterRect:= GetFooterRect;
  Windows.InvalidateRect(Canvas.Handle, @FooterRect, False);

  if Assigned(FOnColumnMoved) then FOnColumnMoved(Self, FromIndex, ToIndex);

end;

procedure TwwCustomDBGrid.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
      if (FDataLink <> nil) and (AComponent = DataSource)  then
         DataSource := nil
      else if (FIndicatorButton=AComponent) then
         FIndicatorButton:= nil
      else if (FImageList=AComponent) then
         FImageList:= nil
      else if (FTitleImageList=AComponent) then
         FTitleImageList:= nil
  end;
end;

procedure TwwCustomDBGrid.TimedScroll(Direction: TGridScrollDirection);
begin
  if FDatalink.Active then
  begin
    with FDatalink do
    begin
      if sdUp in Direction then
      begin
	DataSet.MoveBy(-ActiveRecord - 1);
	Exclude(Direction, sdUp);
      end;
      if sdDown in Direction then
      begin
	DataSet.MoveBy(RecordCount - ActiveRecord);
	Exclude(Direction, sdDown);
      end;
    end;
    if Direction <> [] then inherited TimedScroll(Direction);
  end;
end;

procedure TwwCustomDBGrid.ColWidthsChanged;
var
  I: Integer;
  CWidth: Integer;
  ParentForm: TCustomForm;
  tempSelected, Parts: TStrings;
begin
  inherited ColWidthsChanged;
  if (FUpdatingColWidths=0) and FUpdateFields and FDatalink.Active and
    HandleAllocated then
  begin
    Inc(FUpdateLock);
    tempSelected:= nil;
    parts:= nil;

//    if dgProportionalColResize in Options then
//       ProportionalColWidths(False);  // Update colWidths

    try
      Canvas.Font := Font;
      CWidth := Canvas.TextWidth('0');

      { 10/28/98 - Substract 4 from ColWidths to be consistent with setting of ColWidths }
      if useTFields then begin
         for I := 0 to FieldCount - 1 do
            { 6/11/99 - Make sure adding never subtracting }
            Fields[I].DisplayWidth := ((ColWidths[I + FIndicatorOffset]-4) +
               wwMax(0, CWidth div 2 - 3)) div CWidth;
      end
      else begin
         tempSelected:= TStringList.create;
         parts:= TStringList.create;
         tempSelected.assign(Selected);
         Selected.clear;
         for I := 0 to tempSelected.count-1 do
         begin
             strBreakApart(tempselected[i], #9, parts);
             { 6/11/99 - Make sure adding never subtracting }
             Selected.Add(parts[0] + #9 +
               inttostr(((ColWidths[I + FIndicatorOffset]-4) + wwMax(0, CWidth div 2 - 3)) div CWidth)
                  +#9 + parts[2]);
//             Selected.Add(parts[0] + #9 +
//               inttostr(((ColWidths[I + FIndicatorOffset]-4) {+ wwMax(0, CWidth div 2 - 3)}) div CWidth)
//                  +#9 + parts[2]);
             if parts.count>3 then Selected[i]:= Selected[i] + #9 + parts[3];
             if parts.count>4 then Selected[i]:= Selected[i] + #9 + parts[4];
         end;
      end;

      ParentForm := GetParentForm(Self) as TCustomForm;  { -ksw (6/22/98) }
      if (ParentForm <> nil) and (TForm(ParentForm).Designer <> nil) then
      begin
	ParentForm.Designer.Modified;
      end
    finally
      Dec(FUpdateLock);
      tempSelected.Free;
      Parts.Free;
    end;
    LayoutChanged;
{    SizelastColumn; {!!! 4/7/97}
  end;
end;

procedure TwwCustomDBGrid.Loaded;
begin
  inherited Loaded;
  LayoutChanged;
  if Parent <> nil then begin //2/13/2002 - Don't call InitBlendBitmaps if no background bitmap loaded.
     if (PaintOptions.BackgroundBitmap.Width<>0) then PaintOptions.InitBlendBitmaps;
//     PaintOptions.InitBlendBitmaps;  //10/04/2001-InitBlendBitmaps will fail if Parent is nil.(PYW)
  end;
end;

procedure TwwCustomDBGrid.SetOptions(Value: TwwDBGridOptions);
const
  LayoutOptions = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator,
    dgColLines, dgRowLines,
    dgRowSelect, dgAlwaysShowSelection, dgPerfectRowFit,
    dgShowFooter{, dgVariableRowHeight}, dgProportionalColResize];
var
  NewGridOptions: TGridOptions;
  ChangedOptions: TwwDBGridOptions;
begin
  if FOptions <> Value then
  begin
    NewGridOptions := [];
    if dgColLines in Value then
      NewGridOptions := NewGridOptions + [goFixedVertLine, goVertLine];
    if dgRowLines in Value then
      NewGridOptions := NewGridOptions + [{goFixedHorzLine, }goHorzLine];
    if not (dgRowLinesDisableFixed in Value) then
      NewGridOptions := NewGridOptions + [goFixedHorzLine{, goHorzLine}];
    if dgColumnResize in Value then
      NewGridOptions := NewGridOptions + [goColSizing, goColMoving];
    if dgRowResize in Value then
      NewGridOptions := NewGridOptions + [goRowSizing];
    if dgTabs in Value then Include(NewGridOptions, goTabs);
    if dgRowSelect in Value then Include(NewGridOptions, goRowSelect);
    if (dgEditing in Value) and not (dgRowSelect in Value) then  {edit not allowed if RowSelect}
       Include(NewGridOptions, goEditing);
    if dgAlwaysShowEditor in Value then Include(NewGridOptions, goAlwaysShowEditor);
    inherited Options := NewGridOptions;
    ChangedOptions := (FOptions + Value) - (FOptions * Value);
//    if dgProportionalColResize in ChangedOptions then
//    begin
//      ShowHorzScrollBar:= ShowHorzScrollBar; // Refreshes based on proportional property
//    end;

    if (dgWordWrap in Value) <> (dgWordWrap in FOptions) then
    begin
       if (InplaceEditor<>Nil) then
	  (InplaceEditor as TwwInplaceEdit).WordWrap:= (dgWordWrap in Value);
       Invalidate; { if wordwrap changed }
    end;
    FOptions := Value;
    if ChangedOptions * [dgIndicator] <> [] then
       ResetProportionalWidths;
    if ChangedOptions * LayoutOptions <> [] then LayoutChanged;
  end;


end;

procedure TwwCustomDBGrid.SetTitleFont(Value: TFont);
begin
  FTitleFont.Assign(Value);
  LayoutChanged;
end;

procedure TwwCustomDBGrid.SetIndicatorIconColor(Value: TColor);
var i :integer;
begin
  FIndicatorIconColor:= Value;
//  InitIndicators;
  for i:= 0 to colCount-1 do InvalidateCell(i, row);
end;

procedure TwwCustomDBGrid.SetTitleAlignment(sel: TAlignment);
begin
   if sel<>FtitleAlignment then
   begin
      FTitleAlignment:= sel;
      LayoutChanged;
   end
end;

procedure TwwCustomDBGrid.SetTitleLines(sel: integer);
begin
   if sel<=0 then exit;
   if sel<>FTitleLines then
   begin
      FTitleLines:= sel;
      LayoutChanged;
   end
end;

procedure TwwCustomDBGrid.SetRowHeightPercent(sel: Integer);
begin
   if sel<=0 then begin
      FRowHeightPercent:= 100;
      exit;
   end;

   if sel<>FRowHeightPercent then
   begin
      FRowHeightPercent:= sel;
      LayoutChanged;
   end;
   MinRowHeightPercent:= FRowHeightPercent;
end;

procedure TwwCustomDBGrid.DoCalcTitleImage(Sender: TObject; Field: TField;
         var TitleImageAttributes: TwwTitleImageAttributes);
begin
  if Assigned(FOnCalcTitleImage) then
     FOnCalcTitleImage(Sender, Field, TitleImageAttributes);
end;

procedure TwwCustomDBGrid.DoDrawTitleCell(ACanvas: TCanvas;
     Field: TField; ARect: TRect; var DefaultDrawing: boolean);
begin
  if Assigned(FOnDrawTitleCell) then
     FOnDrawTitleCell(Self, ACanvas, Field, ARect, DefaultDrawing);
end;

procedure TwwCustomDBGrid.DoDrawGroupHeaderCell(ACanvas: TCanvas;
     GroupHeaderName: string; ARect: TRect; var DefaultDrawing: boolean);
begin
  if Assigned(FOnDrawGroupHeaderCell) then
     FOnDrawGroupHeaderCell(Self, ACanvas, GroupHeaderName, ARect, DefaultDrawing);
end;

procedure TwwCustomDBGrid.DoCalcTitleAttributes(AFieldName: string; AFont: TFont; ABrush: TBrush;
	     var FTitleAlignment: TAlignment);
var OldBrushColor: TColor;
begin
  OldBrushColor:= Canvas.Brush.Color;
  if Assigned(FOnCalcTitleAttributes) then
     FOnCalcTitleAttributes(Self, AFieldName, AFont, ABrush, FTitleAlignment);
  ChangedBrushColor:= OldBrushColor<>Canvas.Brush.Color;
end;

procedure TwwCustomDBGrid.DoCalcCellColors(Field: TField; State: TGridDrawState;
	     highlight: boolean; AFont: TFont; ABrush: TBrush);
//var OldBrushColor: TColor;
begin
//  OldBrushColor:= Canvas.Brush.Color;
{  if dgRowSelectEditable in Options then
  begin
     if (CalcCellRow=dbRow(Row)) and not (gdFixed in State) then
     begin
        ABrush.Color:= clHighlight;
        AFont.Color:= clHighlightText;
     end
  end;
}
  if Assigned(FOnCalcCellColors) then
     FOnCalcCellColors(Self, Field, State, highlight, AFont, ABrush);
//  isWhiteBackground:= ColorToRGB(Canvas.Brush.Color)=clWhite;
//  ChangedBrushColor:= OldBrushColor<>Canvas.Brush.Color;
end;

procedure TwwCustomDBGrid.DoCalcCellColorsDetect(Field: TField; State: TGridDrawState;
	     highlight: boolean; AFont: TFont; ABrush: TBrush);
var OldBrushColor: TColor;
begin
  OldBrushColor:= Canvas.Brush.Color;
  DoCalcCellColors(Field, State, highlight, AFont, ABrush);
  isWhiteBackground:= ColorToRGB(Canvas.Brush.Color)=clWhite;
  ChangedBrushColor:= OldBrushColor<>Canvas.Brush.Color;
end;

Function TwwCustomDBGrid.GetShowHorzScrollBar: Boolean;
begin
   result:= FShowHorzScrollBar;
//   result:= (ScrollBars in [ssBoth, ssHorizontal]) and
//             (not IsProportionalColumns);
end;

Procedure TwwCustomDBGrid.SetShowHorzScrollBar(val: boolean);
begin
   if (val and (not IsProportionalColumns)) then ScrollBars:= ssHorizontal
   else ScrollBars:= ssNone;
   FShowHorzScrollBar:= Val;
end;

Procedure TwwCustomDBGrid.SetShowVertScrollBar(val: boolean);
begin
   FShowVertScrollBar:= val;
   UpdateScrollBar;
   if (IndicatorButton<>nil) and UseRightToLeftAlignment then
      with IndicatorButton do
         SetBounds(Left, Top, Width, Height);
   invalidate;
end;

Function TwwCustomDBGrid.IsMemoField(Acol, Arow: integer): boolean;
var Field: TField;
begin
   Result:= False;
   if dbRow(ARow)<0 then exit;
   Field := GetColField(dbCol(Acol));
   if (Field = nil) then exit;
   if not (Field is TBlobField) then exit;
   if (not (Field.DataType in [ftMemo, ftOraBlob, ftOraclob])) and { 6/8/98 - return true if richedit field }
       (not wwIsRichEditField(Field, False)) then exit;

   Result:= True;
end;

function TwwCustomDBGrid.IsCheckBox(col, row: integer; var checkboxOn, checkboxOff: string): boolean;
var fldName: string;
    i: integer;
    parts : TStrings;
    controlType: TStrings;
begin
   result:= False;
   if not isValidCell(col, row) then exit;

   fldName:= DataLink.fields[dbCol(col)].fieldName;
   parts:= TStringList.create;

   controlType:= GetControlType;
   for i:= 0 to ControlType.count-1 do begin
      strBreakapart(controlType[i], ';', parts);
      if parts.count<4 then continue;
      if parts[0]<>fldName then continue;
      if parts[1]='CheckBox' then begin
	 CheckBoxOn:= parts[2];
	 CheckBoxOff:= parts[3];
	 result:= True;
	 break;
      end
   end;

   parts.free;
end;

Function TwwCustomDBGrid.isValidCell(ACol, ARow: integer): boolean;
begin
   Result:= False;
   if dataSource=Nil then exit;
   if dataSource.dataSet=Nil then exit;
   ACol:= dbCol(ACol);
   ARow:= dbRow(ARow);
   if (ACol<0) or (ACol>=DataLink.FieldCount) then exit;
   if (ARow<0) then exit;
   if not (wwDataSet(DataSource.dataSet)) then exit;
   Result:= True;
end;

function TwwCustomDBGrid.DbCol(col: integer): integer;
begin
   result:= col;
   if dgIndicator in Options then result:= col - 1;
end;

function TwwCustomDBGrid.DbRow(row: integer): integer;
begin
   result:= row;
   if dgtitles in Options then result:= row - 1;
end;

Function TwwCustomDBGrid.IsSelected: boolean;
begin
   result:= False;
end;

Function TwwCustomDBGrid.IsSelectedRow(DataRow: integer): boolean;
begin
   result:= False;
end;

procedure TwwCustomDBGrid.RefreshBookmarkList;
begin
end;

procedure TwwCustomDBGrid.HideControls;
begin
end;

constructor TwwInplaceEdit.wwCreate(AOwner: TComponent; dummy: integer);
begin
  Create(AOwner);
  FwwPicture:= TwwDBPicture.create(self);
  ParentGrid:= Owner as TwwCustomDBGrid;
  FWordWrap:= dgWordWrap in ParentGrid.Options;
  {$ifdef wwDelphi3Up}
  ImeMode := ParentGrid.ImeMode;
  ImeName := ParentGrid.ImeName;
  {$endif}
end;

destructor TwwInplaceEdit.Destroy;
begin
  FwwPicture.Free;
  inherited Destroy;
end;

procedure TwwInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);
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

  procedure SendToParent2;
  begin
     ParentGrid.KeyDown(Key, Shift);
     Key := 0;
  end;

  function Ctrl: Boolean;
  begin
    Result := ssCtrl in Shift;
  end;

  function ForwardMovement: Boolean;
  begin
    Result := dgAlwaysShowEditor in ParentGrid.Options;
  end;

  function Selection: TSelection;
  begin
    SendMessage(Handle, EM_GETSEL, Longint(@Result.StartPos), Longint(@Result.EndPos));
  end;

  function RightSide: Boolean;
  begin
    with Selection do
      Result :=
        ((StartPos = 0) or (EndPos = StartPos)) and (EndPos = GetTextLen);
   end;

  function LeftSide: Boolean;
  begin
    with Selection do
      Result := (StartPos = 0) and
        ((EndPos = 0) or (EndPos = GetTextLen));
  end;

begin
   if UseRightToLeftAlignment then
   begin
     case Key of
       VK_LEFT: if ForwardMovement and (Ctrl or LeftSide) then SendToParent2;
       VK_RIGHT: if ForwardMovement and (Ctrl or RightSide) then SendToParent2;
     end
   end;

   case Key of
      VK_RETURN:
	 if dgEnterToTab in ParentGrid.KeyOptions then
	 begin
	    SendToParent;
	 end;

      VK_DELETE: if (Ctrl) then SendToParent;
   end;

   inherited KeyDown(Key, Shift);
end;

procedure TwwInplaceEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
   if (dgEnterToTab in ParentGrid.KeyOptions) and (Key=VK_RETURN) then Key:= 9;
   inherited KeyUp(Key, Shift);
   if (Key= VK_DELETE) then
   begin
      if Assigned(parentGrid.FOnCheckValue) then
	 IsValidPictureValue(Text);
   end
end;

procedure TwwInplaceEdit.KeyPress(var Key: Char);
var pict: TwwPictureValidator;
    s: string;
    res: TwwPicResult;
    padlength, OldSelStart, Oldlen, OldSelLen: integer;
    DisplayTextIsInvalid, skipInvalidValueTest: boolean;
    Delphi2: boolean;

   Function NewText(Key: Char): string;
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
  if (dgEnterToTab in ParentGrid.KeyOptions) and (ord(Key)=VK_RETURN) then Key:= #9;

  inherited KeyPress(Key);

  // 1/31/01 - Don't allow Control-Enter
  with ParentGrid do
    if (Key=#10) and (GetColField(dbCol(Col)) is TFloatField) then
    key:= #0;

  if HavePictureMask then begin
     if (ord(Key) = VK_BACK) then
     begin
       if Assigned(parentGrid.FOnCheckValue) then IsValidPictureValue(NewText(Key));
       exit;
     end;
     if (ord(key)<VK_SPACE) then exit;

     s:= NewText(key);
     if (Maxlength>0) and (length(s)>MaxLength) and (length(s)>length(Text)) then exit; { Limit to maxlength }

     pict:= TwwPictureValidator.create(FwwPicture.PictureMask, FwwPicture.AutoFill);
     res:= Pict.picture(s, FwwPicture.AutoFill);
     DisplayTextIsInvalid:= False;
     SkipInvalidValueTest:= False;

     oldSelStart:= SelStart;
     oldLen:= length(Text);
     oldSelLen:= SelLength;

     if FwwPicture.AutoFill and
        (parent is TwwDBGrid) and (not TwwDBGrid(parent).Patch[3]) then begin { Autofill prefix }
       if (res = prError) {and
          ((selStart = selLength) or (SelText=Text))} then begin
          s:= NewText(' ');
          res:= Pict.picture(s, FwwPicture.AutoFill);
          if res <> prError then begin
             s:= s + char(key);
             res:= Pict.picture(s, FwwPicture.AutoFill);
          end;
       end
     end;

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
	    (Owner as TwwCustomDBGrid).FEditText:= Text;
	    if (oldSelLen=oldLen) then selStart:= length(s)
	    else selStart:= OldSelStart + padLength;
	    key:= char(0);
	    DisplayTextIsInvalid:= True;
	    end;

       prComplete: begin
            {$ifdef win32}
            {$ifndef wwDelphi3Up}
            Delphi2:= True;
            {$else}
            Delphi2:= False;
            {$endif}
            {$else}
            Delphi2:= False;
            {$endif}

            {11/21/96 - Workaround for Delphi 2 bug in scrolling in unbordered control}
            if Delphi2 then begin
               if (length(s)>1) then text:= copy(s, 1, oldSelStart) + copy(s, oldSelStart+2, length(s)-1)
               else text:= '';
               selStart:= OldSelStart;
               (Owner as TwwCustomDBGrid).FEditText:= s;
               if (length(s)>0) then
                  key:= s[oldSelStart+1];
            end
            else begin
               text:= s;
               (Owner as TwwCustomDBGrid).FEditText:= s;
               if (oldSelLen=oldLen) then selStart:= length(s)
               else if (length(s)>oldlen) then
                  selStart:= oldSelStart + (length(s)-oldlen) {Move caret to the right}
               else selStart:= oldSelStart + 1;  { 11/26/96 }
               selLength:= 0;  { 8/12/97 }

               key:= char(0);
            end
	 end;

     end;
     pict.Free;

     if (not SkipInvalidValueTest) and
        Assigned(parentGrid.FOnCheckValue) then
	parentGrid.FOnCheckValue(self, not DisplayTextIsInvalid);

  end;
end;

{ Allow paste to change text - 10/29/96 }
procedure TwwInplaceEdit.WMPaste(var Message: TMessage);
begin
  inherited;
  if not ParentGrid.CanEditModify then exit;
//  ParentGrid.edit;
//  ParentGrid.DataLink.modified;
end;

procedure TwwInplaceEdit.SetWordWrap(val: boolean);
begin
   FWordWrap:= val;
   RecreateWnd;
end;

procedure TwwInplaceEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style and not (ES_AUTOVSCROLL or ES_WANTRETURN);
  if (BorderStyle = bsNone) or WordWrap then Params.Style:= Params.Style or ES_MULTILINE;
  if WordWrap then Params.Style := (Params.Style or ES_AUTOVSCROLL) and not ES_AUTOHSCROLL;
end;

function TwwInplaceEdit.IsValidPictureValue(s: string): boolean;
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

procedure TwwInplaceEdit.UpdateContents;
begin
   inherited;
   if TwwCacheColInfoItem(ParentGrid.FCacheColInfo[ParentGrid.Col]).ControlType = 'URL-Link' then
      WordWrap:= False
   else
      WordWrap:= dgWordWrap in ParentGrid.Options;
//   RecreateWnd;
end;

procedure TwwInplaceEdit.WMSetFocus(var Message: TWMSetFocus);
var tempMask: string;
    tempAutoFill: boolean;
begin
  inherited;
  if (parentGrid.datasource=nil) or (parentGrid.datasource.dataset=nil) then exit;
  with ParentGrid do begin
     if GetColField(dbCol(Col))=nil then exit;
     wwPictureByField(ParentGrid.GetPictureControl, GetColField(dbCol(Col)).FieldName, True,
	      tempMask, tempAutoFill, FUsePictureMask);
     FwwPicture.PictureMask:= tempMask;
     FwwPicture.AutoFill:=tempAutoFill;
     FwwPicture.AllowInvalidExit:= False;
     IsValidPictureValue(GetColField(dbCol(Col)).text);
  end
end;

Function TwwInplaceEdit.HavePictureMask: boolean;
begin
   result:=
     FUsePictureMask and
     (FwwPicture.PictureMask<>'')
end;

procedure TwwInplaceEdit.CMFontChanged(var Message: TMessage);
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

Procedure TwwCustomDBGrid.SelectRecord;
begin
end;

Procedure TwwCustomDBGrid.UnselectRecord;
begin
end;

Procedure TwwCustomDBGrid.SetTitleButtons(val: boolean);
begin
   if (FTitleButtons<>val) then
   begin
      FTitleButtons:= val;
      invalidate;
   end
end;

Function TwwCustomDBGrid.GetPictureControl: TComponent;
begin
   result:= wwGetPictureControl(self);
//   if (Datasource=nil) then
//      result:= wwGetPictureControl(self, nil)
//   else
//      result:= wwGetPictureControl(self, DataSource.DataSet)
end;

Procedure TwwCustomDBGrid.SetPictureMask(FieldName: string; Mask: string);
begin
   if DataSource=nil then exit;
   wwSetPictureMask(GetPictureControl, FieldName, Mask, True, True,
		    True, False, False);
end;

Procedure TwwCustomDBGrid.SetPictureAutoFill(FieldName: string; AutoFill: boolean);
begin
   if DataSource=nil then exit;
   wwSetPictureMask(GetPictureControl, FieldName, '', AutoFill, True,
		    False, True, False);
end;

Procedure TwwCustomDBGrid.UnselectAll;
begin
end;

    function TwwCustomDBGrid.GetSelectedFields: TStrings;
    begin
         Result:= FSelected;
    end;

    procedure TwwCustomDBGrid.SetPictureMasks(val: TStrings);
    begin
       FPictureMasks.assign(val);
    end;

    procedure TwwCustomDBGrid.SetControlType(val: TStrings);
    begin
       ControlType.assign(val);
    end;

    procedure TwwCustomDBGrid.SetSelectedFields(sel : TStrings);
    begin
         FSelected.assign(sel);
    end;

Function TwwCustomDBGrid.IsSelectedCheckbox(ACol: integer): boolean;
var tempField: TField;
begin
    if isCheckBox(ACol, 1, dummy1, dummy2) then
    begin
       tempField:=GetColField(dbCol(ACol));
       if tempField=nil then result:= False
       else result:= (lowercase(tempField.fieldName)='selected');
    end
    else result:= False;
end;


Procedure TwwCustomDBGrid.SizeLastColumn;
var i, FieldsSize: integer;
begin
   if csLoading in ComponentState then Exit;
   if not HandleAllocated then Exit;

   inc(FUpdatingColWidths);
   try
     SetColumnAttributes;
   finally
     dec(FUpdatingColWidths);
   end;

   if ShowVertScrollBar then FieldsSize:= GetSystemMetrics(SM_CXHThumb) + 5
   else FieldsSize:= 0;

   if dgIndicator in Options then FieldsSize:= FieldsSize + colWidths[0] + GridLineWidth;

   for i:= LeftCol to ColCount-2 do
      FieldsSize:= FieldsSize + colWidths[i] + GridLineWidth;
   if FieldsSize>Width then exit;  { Last column is not visble }

   FieldsSize:= FieldsSize + ColWidths[ColCount-1] + GridLineWidth;

   inc(FUpdatingColWidths);
   try
     if Width-FieldsSize>0 then
        colWidths[ColCount-1]:= colWidths[ColCount-1] + (Width - FieldsSize);
   finally
     dec(FUpdatingColWidths);
   end
end;

function TwwCustomDBGrid.GetColWidthsPixels(Index: Longint): Integer;
begin
  result:= inherited ColWidths[Index];
end;

procedure TwwCustomDBGrid.SetColWidthsPixels(Index: Longint; Value: Integer);
begin
   inc(FUpdatingColWidths);
   try
     ColWidths[Index]:= Value;
   finally
     dec(FUpdatingColWidths);
   end
end;

procedure TwwCustomDBGrid.FlushChanges;
begin
   DataLink.UpdateData;
end;

procedure TwwIButton.Loaded;
begin
  inherited Loaded;
  if parent is TwwCustomDBGrid then
  begin
     (parent as TwwCustomDBGrid).FIndicatorButton:= self;
     {$ifdef win32}
     (parent as TwwCustomDBGrid).FIndicatorWidth:= Width-1;
     {$else}
     (parent as TwwCustomDBGrid).FIndicatorWidth:= Width-2;
     {$endif}
  end;
end;

procedure TwwIButton.Paint;
begin
   inherited Paint;
{   if parent is TwwDBGrid then
      with (parent as TwwDBGrid) do begin
         InvalidateCell(0,1);
         Update;
      end}
end;

procedure TwwIButton.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var SizeChanging: boolean;
begin
  if ALeft>0 then ALeft:= 0;
  if ATop>0 then ATop:= 0;

  SizeChanging:= (AWidth<>Width) or (AHeight<>Height);
  {$ifdef wwdelphi4up}
  if (parent is TwwCustomDBGrid) and
     parent.UseRightToLeftAlignment then
    with (parent as TwwCustomDBGrid) do
       inherited SetBounds(ClientWidth - AWidth + 1, ATop, AWidth, AHeight)
  else
  {$endif}
    inherited SetBounds(ALeft, ATop, AWidth, AHeight);

  if (parent=nil) then exit;

  if SizeChanging and (not (csLoading in ComponentSTate)) then
  begin
     with (parent as TwwCustomDBGrid) do begin
        {$ifdef win32}
        FIndicatorWidth:= self.Width-1;
        {$else}
        FIndicatorWidth:= self.Width-2;
        {$endif}
        LayoutChanged;
     end
  end;

end;

{$ifdef win32}
{$ifdef wwDelphi3Up}
procedure TwwCustomDBGrid.GetChildren(Proc: TGetChildProc; Root: TComponent);
{$else}
procedure TwwCustomDBGrid.GetChildren(Proc: TGetChildProc);
{$endif}
begin
   if FIndicatorButton<>Nil then begin
      Proc(FIndicatorButton);
   end;
end;
{$else}
procedure TwwCustomDBGrid.WriteComponents(Writer: TWriter);
begin
   if FIndicatorButton<>Nil then Writer.WriteComponent(FIndicatorButton);
end;
{$endif}

procedure TwwColumn.SetDisplayLabel(val: string);
begin
   if self=Grid.DummyColumn then exit;
   try
      Inc(Grid.FUpdateLock);
      UpdateSelectedProp(Grid.Selected, FFieldName, val, sptUpdateLabel);
      if Grid.useTFields then
        Grid.Datasource.dataset.fieldbyname(FFieldName).DisplayLabel:= val;
      Grid.SetColumnAttributes;
      Grid.Invalidate;
   finally
     Dec(Grid.FUpdateLock);
   end
end;

procedure TwwColumn.SetGroupName(val: string);
begin
   if self=Grid.DummyColumn then exit;
   try
      Inc(Grid.FUpdateLock);
      UpdateSelectedProp(Grid.Selected, FFieldName, val, sptUpdateGroup);
      Grid.Invalidate;
   finally
     Dec(Grid.FUpdateLock);
   end
end;

procedure TwwColumn.SetFooterValue(val: string);
begin
   if self=Grid.DummyColumn then exit;
   if FFooterValue<>val then
   begin
      FFooterValue:= val;
      Grid.InvalidateFooter;
   end;
end;

procedure TwwColumn.SetDisplayWidth(val: integer);
var s: string;
begin
   if self=Grid.DummyColumn then exit;
   s:= inttostr(val);
   try
      Inc(Grid.FUpdateLock);
      UpdateSelectedProp(Grid.Selected, FFieldName, s, sptUpdateWidth);
      if Grid.useTFields then
        Grid.Datasource.dataset.fieldbyname(FFieldName).DisplayWidth:= val;
      Grid.SetColumnAttributes;
   finally
     Dec(Grid.FUpdateLock);
   end;

end;

procedure TwwColumn.SetReadOnly(val: boolean);
var s: string;
begin
   if self=Grid.DummyColumn then exit;
   if val then
      s:= 'T'
   else s:= 'F';
   UpdateSelectedProp(Grid.Selected, FFieldName, s, sptUpdateReadOnly);
end;

function TwwColumn.GetReadOnly: boolean;
begin
   if self=Grid.DummyColumn then result:= False
   else result:= (GetSelectedProp(Grid.Selected, FFieldName, sptUpdateReadOnly) = 'T')
end;

function TwwColumn.GetGroupName: string;
begin
   if self=Grid.DummyColumn then result:= ''
   else result:= GetSelectedProp(Grid.Selected, FFieldName, sptUpdateGroup)
end;

function TwwColumn.GetDisplayLabel: string;
begin
   if self=Grid.DummyColumn then result:= ''
   else begin
      //8/24/2001 - If UseTFields is True, then have column return the fields displaylabel. {PYW}
      if (Grid.UseTFields) and (Grid.FDataLink <>Nil) and (Grid.FDatalink.Dataset<>Nil) and
         (Grid.FDataLink.DataSet.FieldByName(FFieldName)<>nil) then
         result := Grid.FDataLink.DataSet.FieldByName(FFieldName).DisplayLabel
      else result:= GetSelectedProp(Grid.Selected, FFieldName, sptUpdateLabel);
   end;
end;

function TwwColumn.GetDisplayWidth: integer;
begin
   if self=Grid.DummyColumn then result:= 0
   else begin
      //9/24/2001 - If UseTFields is True, then have column return the fields displaywidth. {PYW}
      if (Grid.UseTFields) and (Grid.FDataLink <>Nil) and (Grid.FDatalink.Dataset<>Nil) and
         (Grid.FDataLink.DataSet.FieldByName(FFieldName)<>nil) then
         result := Grid.FDataLink.DataSet.FieldByName(FFieldName).DisplayWidth
      else result:= strtoInt(GetSelectedProp(Grid.Selected, FFieldName, sptUpdateWidth));
   end;
end;

function TwwCustomDBGrid.GetColumn(Index: Integer): TwwColumn;
var apos: integer;
    FieldName: string;
begin
   if FieldCount=0 then
   begin
      if Index>=Selected.count then result:= DummyColumn
      else begin
         APos:= 1;
         FieldName:= strGetToken(Selected[index], #9, apos);
         result:= ColumnByName(FieldName);
      end
   end
   else begin
     if Index>=FieldCount then result:= DummyColumn
     else result:= ColumnByName(Fields[index].FieldName)
   end
end;

function TwwCustomDBGrid.ColumnByName(Index: string): TwwColumn;
var i: integer;
begin
   result:= DummyColumn;
   for i:= 0 to ColItems.count-1 do begin
      if wwEqualStr(TwwColumn(ColItems[i]).FFieldName, Index) then
      begin
         result:= TwwColumn(ColItems[i]);
         exit;
      end
   end;
end;

destructor TwwColumn.Destroy;
begin
   if ColumnFlags<>nil then FreeMem(ColumnFlags);
   ColumnFlags:=nil;
   inherited;
end;

constructor TwwColumn.Create(AOwner: TComponent; AFieldName: string);
begin
   Grid:= AOwner as TwwCustomDBGrid;
   FFieldName:= AFieldName;
   FGroupName := '';
   ColumnFlags:=nil;
end;

procedure TwwCustomDBGrid.TopLeftChanged;
var FooterRect: TRect;
   {$ifdef wwdelphi4up}
   PatchRect: TRect;
   DrawInfo: TGridDrawInfo;
   {$endif}
   r: TRect;
begin
   FreeHintWindow;
   CollapseChildGrid;

   inherited TopLeftChanged;
   if Assigned(FOnLeftColChanged) then
      FOnLeftColChanged(self, LeftCol);

   //Invalidate TitleRect to handle horizontal scroll painting issues.
   r:= Rect(0, 0, Width, RowHeights[0]);
   InvalidateRect(Handle, @r, False);

   if dgShowFooter in Options then
   begin
      FooterRect:= GetFooterRect;
      FooterRect.Bottom:= FooterRect.Bottom + 1;
      Windows.InvalidateRect(Handle, @FooterRect, False);
   end;

   {8/5/98 - Delphi 4 patch for bug in TCustomGrid }
   {$ifdef wwdelphi4up}
   CalcDrawInfo(DrawInfo);
   PatchRect:= Rect(DrawInfo.Horz.GridExtent-1, 0,
                    DrawInfo.Horz.GridExtent, height);
   Windows.InvalidateRect(Handle, @PatchRect, False);
   {$endif}


end;

function TwwCustomDBGrid.GetClientRect: TRect;
begin
  result:= inherited GetClientRect;
  if dgShowFooter in Options then
  begin
     if FooterHeight=0 then
     begin
        Result.Bottom:= result.bottom -  (Canvas.Textheight('W') + NormalPad + 4);
     end
     else
        Result.Bottom := result.Bottom - FooterHeight;
     if dgFooter3DCells in Options then
        Result.Bottom:= Result.Bottom - 2;
  end
end;

Function TwwCustomDBGrid.GetFooterRect: TRect;
var FooterRect: TRect;
   Drawinfo:TGridDrawInfo;
begin
   CalcDrawInfo(DrawInfo);
   FooterRect.Top := DrawInfo.vert.FullVisBoundary+1;
   FooterRect.Bottom := ClientHeight;
   FooterRect.Left := 0;
   FooterRect.Right := Drawinfo.Horz.FullVisBoundary+1;
   {$ifdef wwdelphi4up}
(*   if UseRightToLeftAlignment then
   begin
      FooterRect.Left:= FooterRect.Right;
      FooterRect.right:= 0;
   end
   else *)
   {$endif}
      FooterRect.right:= ClientWidth;
   if dgShowFooter in Options then
      FooterRect.Top:= ClientRect.Bottom
   else
      FooterRect.Top:= FooterRect.Bottom + 3; // 1/19/01;

   if FooterHeight=0 then
      FooterRect.Bottom:= FooterRect.Top +
        Canvas.Textheight('W') + NormalPad + 4
//        DefaultRowHeight+3
   else
      FooterRect.Bottom := FooterRect.Top + FooterHeight-1;
   if dgFooter3DCells in Options then
      FooterRect.Bottom:= FooterRect.Bottom + 2;
   result:= FooterRect;
end;

function TwwCustomDBGrid.GetEffectiveFooterHeight: integer;
var b: integer;
begin
   if dgShowFooter in Options then
   begin
      if FooterHeight=0 then
      begin
         b:= Canvas.Textheight('W') + NormalPad + 4;
      end
      else
         b:= FooterHeight-1;
      if dgFooter3DCells in Options then
         b:= b + 2;
      result:= b+2;
   end
   else result:= 0;
end;

   procedure TwwCustomDBGrid.InitCacheColInfo;
   var APos, i: integer;
       TempControlType, TempControlData: string;
       customEdit: TWinControl;
       TempControlInfo: TwwCacheColInfoItem;
       tempCol: integer;
   begin
      FCacheColInfo.Clear;

      for i:= 0 to ColCount-1 do
      begin
         tempControlInfo:= TwwCacheColInfoItem.create;
         with tempControlInfo do begin
            CustomControl:=nil;
            ControlType:= '';
            ControlData:= '';
            AlwaysPaints:= False;
            IsWhiteBackground:= True;
//            PaintedBrushColor:= clWindow;
         end;
         FCacheColInfo.add(tempControlInfo);

         tempCol:= dbCol(i);

         if (tempCol<0) then continue;
         if tempCol>=FieldCount then continue;
         if Fields[tempCol]=nil then continue;

         GetControlInfo(Fields[tempCol].FieldName, TempControlType, TempControlData);

         with tempControlInfo do
         begin
            ControlType:= TempControlType;
            ControlData:= TempControlData;
         end;

         if IsWWEditControl(TempControlType) then
         begin
            with tempControlInfo do
            begin
//               ControlType:= TempControlType;
//               ControlData:= TempControlData;
               APos:=1;
               strGetToken(ControlData, ';', APos);
               AlwaysPaints:= (strGetToken(ControlData, ';', APos)='T');
               if isCustomEditCell(i, 1, customEdit) and
                (customEdit <> FDateTimePicker) then
                  CustomControl:= customEdit
               else begin
                  AlwaysPaints:= False;
                  ControlType:= '';
               end;
            end;
         end
      end
    end;

Procedure TwwCustomDBGrid.Paint;
const AlignFlags : array [TAlignment] of Integer =
    ( DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX );
var FooterRect: TRect;
    TempRect, FooterCellRect,LastFooterCellRect: TRect;
    ACol: integer;
    ACanvas: TCanvas;
//    UpdateRect: TRect;
    DrawInfo:TGridDrawInfo;

    Function GetFooterCellRect(Col: integer): TRect;
    var FooterCellRect: TRect;
    begin
//       FooterCellRect:= CellRect(ACol, RowCount-1);
       FooterCellRect:= CellRect(ACol, 0);
       if FooterCellRect.left<>FooterCellRect.right then
       begin
          FooterCellRect.Top:= FooterRect.Top;
          FooterCellRect.Bottom:= FooterRect.Bottom;
       end;
//       InflateRect(FooterCellRect, -2, -2);
       result:= FooterCellRect;
    end;

    procedure DrawFooterLines(rect: TRect; Col, Row: integer);
    begin
        with ACanvas do begin
//           Pen.color:= clBtnShadow;
           Pen.Color:= LineColors.ShadowColor;
           MoveTo(rect.left+1, rect.bottom-2);
           LineTo(rect.left+1, rect.top+1);
           LineTo(rect.right-1, rect.top+1);

           if dgFooter3DCells in Options then //(ColorToRGB(Brush.Color)=clWhite) then
           begin
              Pen.color:= clBlack;
              MoveTo(rect.left+2, rect.bottom-2);
              LineTo(rect.left+2, rect.top+2);
              LineTo(rect.right-1, rect.top+2);

//              Pen.color:= clBtnHighlight;
              Pen.Color:= LineColors.HighlightColor;
              MoveTo(rect.left+2, rect.bottom-2);
              LineTo(rect.right-1, rect.bottom-2);
              LineTo(rect.right-1, rect.top+1);

              Pen.color:= clBtnFace;
              MoveTo(rect.left+3, rect.bottom-3);
              LineTo(rect.right-2, rect.bottom-3);
              LineTo(rect.right-2, rect.top+1);
           end
           else begin
//              Pen.color:= clBtnHighlight;
              Pen.Color:= LineColors.HighlightColor;
              MoveTo(rect.left+2, rect.bottom-2);
              LineTo(rect.right-1, rect.bottom-2);
              LineTo(rect.right-1, rect.top+1);
           end
        end
    end;

    procedure ProcessFooterCell(ACol: integer);
    var FooterText: string;
        Flags : integer;
        DefaultDrawing: boolean;
        temp: integer;
    begin
//       FooterCellRect:= CellRect(ACol, RowCount-1);
       FooterCellRect:= CellRect(ACol, 0);  // RowCount-1 may return 0,0,0,0
       if FooterCellRect.left<>FooterCellRect.right then
       begin
          FooterText:= Columns[dbCol(ACol)].FooterValue;
          DefaultDrawing:= true;
          ACanvas.Brush.Color:= FFooterCellColor;
          ACanvas.Font.Assign(Font);
          ACanvas.Refresh;
//          ACanvas.Font.Color:= ColorToRGB(Font.Color); // Refresh font color to canvas handle

          FooterCellRect:= GetFooterCellRect(ACol);
          InflateRect(FooterCellRect, 0, -2);

          If Assigned(FOnDrawFooterCell) then
          begin
             FOnDrawFooterCell(self, ACanvas, FooterCellRect,
                   Fields[dbCol(ACol)], FooterText, DefaultDrawing);
          end;

          if not DefaultDrawing then exit;
          if FooterText='' then exit;

          { Fill with brush color for cell }
          FillWithFixedBitmap(FooterCellRect, -1);
//          ACanvas.FillRect(FooterCellRect);

          FooterCellRect.Top:= FooterRect.Top+1;
          FooterCellRect.Bottom:= FooterRect.Bottom-1;
          FooterCellRect.Left:= FooterCellRect.Left - 1;
          {9/12/2000 - Adjust last cell's footer rect to be wider.}
          if (ACol = ColCount - 1) and (PadColumnStyle <> pcsPlain) then
            if FooterCellRect.Right+1 <= ClientWidth -1 then
               FooterCellRect.Right:= FooterCellRect.Right + 1;
          DrawFooterLines(FooterCellRect,  ACol, RowCount);

          Flags:= AlignFlags[Fields[dbCol(ACol)].Alignment];
          FooterCellRect.Top:= FooterCellRect.Top +
             (FooterCellRect.Bottom - FooterCellRect.Top - ACanvas.TextHeight('A')) div 2;
          FooterCellRect.Left:= FooterCellRect.Left + 5;
          {9/12/2000 - Adjusted Right part of text rect from -9 to -7}
          FooterCellRect.Right := FooterCellRect.Left + ColWidths[ACol] - 7;

//          ACanvas.Font.Color:= clBlack;
//          SetTextColor(ACanvas.Handle, ACanvas.Font.Color);
          SetBkMode(ACanvas.Handle, TRANSPARENT);
          if UseRightToLeftAlignment then
          begin
            Temp:= footerCellRect.left;
            FooterCellRect.left:= footerCellRect.right;
            FooterCellRect.Right:=Temp;
          end;
          DrawText(ACanvas.Handle, PChar(FooterText), length(FooterText),
                   FooterCellRect, Flags);

       end
    end;

    procedure DrawPadColumn;
    var r, tempRect: TRect;
    begin
       if DrawInfo.Horz.LastFullVisibleCell <> ColCount-1 then exit;
       r:= CellRect(ColCount-1, 0);
       r.left:= r.right+1;
       r.right:= ClientWidth;
       if (PadColumnStyle=pcsPadHeaderAndData) or (PaintOptions.HaveBackgroundForDataCells) then begin
         r.Bottom:= ClientHeight;
       end
       else if (PadColumnStyle = pcsPadHeader) then begin
          if HaveAnyRowLines then
             r.bottom := r.bottom+1;
          if not (dgTitles in Options) then exit;
       end
       else exit;

       if not (dgColLines in Options) then
          r.Left := r.Left-1;

{       if UseRightToLeftAlignment then
       begin
//          temp:= r.Left;
          r.Left:= r.right;
          r.right:= 0; //temp;
       end;
}
       if PadColumnStyle=pcsPadHeaderandData then begin
          if HideAllLines then
             FillWithFixedBitmap(Rect(r.left-1, r.top, r.right, r.bottom), -1, TitleColor)
          else
             FillWithFixedBitmap(r, -1, TitleColor)
       end
       else if PadColumnStyle=pcsPadHeader then begin
          if HideAllLines then
             FillWithFixedBitmap(rect(r.left-1,r.top,r.right,CellRect(ColCount-1, 0).Bottom), -1, TitleColor)
          else
             FillWithFixedBitmap(rect(r.left,r.top,r.right,CellRect(ColCount-1, 0).Bottom+1), -1, TitleColor);
          FillWithBlendBitmap(rect(r.left,CellRect(ColCount-1, 0).Bottom+1,r.right,r.Bottom), -1, Color);
       end
       else begin
          Windows.GetClientRect(Handle, tempRect);
          FillWithBlendBitmap(rect(r.left,r.top,r.right,TempRect.bottom), -1, Color);
       end;
       Canvas.Pen.Color:= LineColors.HighlightColor; // looks more 3D with this line
       if PadColumnStyle=pcsPadHeaderandData then
       begin
          if (not HideAllLines) then
             Canvas.PolyLine([Point(r.Left, r.Top), Point(r.Left, r.bottom)])
       end
       else if (dgColLines in Options) then
       begin
          if (not HideAllLines) then
             Canvas.PolyLine([Point(r.Left, r.Top), Point(r.Left, DrawInfo.Vert.GridBoundary+1)]);
       end
    end;

   procedure EndPainting;
   var sourceRect: TRect;
       PaintClipRect: TRect;
       tempRect: TRect;
       customEdit: TWinControl;
       r: TRect;
//       tempCanvas: TCanvas;
   begin
     if (inherited Canvas = Canvas) then exit;

//     (inherited Canvas).CopyMode:= cmSrcCopy;
//     Sourcerect:= ClientRect;
//     inherited Canvas.CopyRect(SourceRect, FPaintCanvas, SourceRect);
//     exit;

     PaintClipRect:= (inherited Canvas).ClipRect;
     if PaintClipRect.Right>ClientRect.Right then
     begin
        PaintClipRect.Right:= ClientRect.Right;
     end;
     if UpdateRect.Bottom>inherited GetClientRect.Bottom then
     begin
        UpdateRect.Bottom:= inherited ClientRect.Bottom;
     end;

     if (UpdateRect.Top=0) and (UpdateRect.Bottom=0) and
        (UpdateRect.Left=0) and (UpdateRect.Right=0) then
        UpdateRect:= PaintClipRect;
     SourceRect:= UpdateRect;
//     SourceRect:= Rect(0,UpdateRect.Top,
//        PaintClipRect.Right, UpdateRect.Bottom );

     { Remove painting of currently edited cell }
     if not (csDesigning in ComponentState) and (FFocused) then
     begin
       TempRect:= CellRect(Col,Row);
       TempRect.Left:= TempRect.Left + 1; { Used to be +2, but richedit gray line would show after resizing }

       { 7/19/00 - RSW - Don't remove inplaceeditor painting if it has the focus}
//       if CurrentCustomEdit<>nil then
//
//       if FFocused and
//         (not isMemoField(col, row)) and (isWWControl(col, row)) then
       if FFocused and IsCustomEditCell(Col, Row, customEdit) and
          (not IsDropDownGridFocused) and
          (ShouldShowCustomControls {or (customEdit is TwwExpandButton)}) then
           FPaintCanvas.CopyRect(tempRect,
              inherited Canvas, tempRect);
{
           if IsDropDownGridShowing then // Leave current screen intact in pop-up grid area
           begin
              with TwwExpandButton(CustomEdit) do
              begin
                r:= Rect(Grid.Left, Grid.Top, Grid.Left + Grid.Width, Grid.Top+Grid.Height);
                FPaintCanvas.CopyRect(r, inherited Canvas, r);
              end
           end;
}
     end;

     // Leave current screen intact in pop-up grid area
     if not (csDesigning in ComponentState) and IsDropDownGridShowing then
     begin
         with TwwExpandButton(CurrentCustomEdit) do
         begin
            r:= Rect(Grid.Left, Grid.Top, Grid.Left + Grid.Width, Grid.Top+Grid.Height);
            FPaintCanvas.CopyRect(r, inherited Canvas, r);
         end
     end;

     inherited Canvas.CopyRect(SourceRect, FPaintCanvas, SourceRect);
   end;

{    procedure Cleanup;
    var i: integer;
    begin
       for i:= 0 to FCacheColInfo.count-1 do
         TwwCacheColInfoItem(FCacheColInfo[i]).Free;
       FCacheColInfo.Clear;
    end;
}

begin
//   GetUpdateRect(Handle, UpdateRect, False);
//   InitCacheColInfo;
   if not UseAlternateBuffering then
   begin
     if dgShowFooter in Options then
     begin
       FPaintBitmap.Width := Width;
       FPaintBitmap.Height:= Height;
     end
     else begin
       FPaintBitmap.Width := ClientWidth;
       FPaintBitmap.Height:= ClientHeight;
     end;
   end;

   //2/13/2002 - Don't call InitBlendBitmaps if no background bitmap loaded.
   if PaintOptions.InitBlendBitmapsFlag and
      (PaintOptions.BackgroundBitmap.Width<>0) then PaintOptions.InitBlendBitmaps;

   if (not PaintOptions.HaveBackgroundForDataCells) then
   begin
     Canvas.Brush.Color:= Color;
     Canvas.FillRect(UpdateRect);
//     Canvas.FillRect(Rect(0, 0, Width, Height)); //
   end
   else begin
      FillWithBlendBitmap(UpdateRect, -1); // 5/16/01 - Clear old data area
   end;

   if (DataLink=nil) or not (DataLink.Active) then
   begin
       TempRect:= inherited ClientRect;
       FillWithFixedBitmap(TempRect, -1, TitleColor);

       TempRect:= CellRect(LeftCol, FTitleOffset);
       TempRect.Right:= ClientWidth;
       TempRect.Bottom:= ClientHeight;
       FillWithBlendBitmap(TempRect, -1, Color);
   end;

   if Assigned(FOnBeforePaint) then
   begin
      FOnBeforePaint(self);
   end;

   inheritedPaint;
   FCalcCellRow:= dbRow(Row); // Set to row in case CalcCellColors called by different control
   FCalcCellCol:= dbRow(Col);
   ACanvas:= Canvas;
   CalcDrawInfo(DrawInfo);
   if UseRightToLeftAlignment then ChangeOrientation(True);
   DrawPadColumn;
   DrawLines;

   // Draw focus rect for inplaceeditor
   if not (csDesigning in ComponentState) and (GetParentForm(self)<>nil)
    and (GetParentForm(Self).ActiveControl = Self) then
   begin
       if (DataLink<>nil) and DataLink.Active and
          // CustomEdit is showing
          ((CurrentCustomEdit=nil) or (not CurrentCustomEdit.visible))
//           ((dgMultiSelect in Options) and
//             (not TwwCacheColInfoItem(FCacheColInfo[Col]).AlwaysPaints)))
            and Focused and
          not (dgAlwaysShowEditor in Options)
          and not (dgRowSelect in Options) then
       begin
          if (Col>=LeftCol) and (Col<=DrawInfo.Horz.LastFullVisibleCell) then
           wwDrawFocusRect(Canvas, CellRect(Col, Row))

          // Draw focus rect for fixed column
//          else if (dgRowLinesDisableFixed in Options) and
          else if (dgFixedEditable in Options) and
               (Col<LeftCol) and (Col>=FIndicatorOffset) then
           wwDrawFocusRect(Canvas, CellRect(Col, Row))
       end
   end;

   for ACol:= LeftCol to ColCount-1 do
   begin
      FooterCellRect:= CellRect(ACol, RowCount-1);
      if FooterCellRect.left=FooterCellRect.right then break;
      LastFooterCellRect:= FooterCellRect;
   end;

   // Draw 3d border line and fill bottom with fixed color to remove whitespace
(*   FooterRect:= GetFooterRect;
   FooterRect.Top:= FooterRect.Top -1;
   FooterRect.Bottom:= FooterRect.Bottom +1;

   if PadColumnStyle = pcsPadHeaderandData then
      FooterRect.Right:= ClientWidth-1
   else FooterRect.Right:= LastFooterCellRect.Right -1;
   FooterRect.Bottom:= ClientHeight-1;
   FooterRect.Top := DrawInfo.vert.FullVisBoundary+1;
   FooterRect.Right := FooterRect.Right+1;
   if not (dgColLines in Options) then begin
      FooterRect.Top := FooterRect.Top-1;
   end;
*)

   if not (dgShowFooter in Options) then begin
      if UseRightToLeftAlignment then ChangeOrientation(false);
      EndPainting;
      exit;
   end;

   { Fill with Footer color, up to right-most visible cell }
   FooterRect:= GetFooterRect;

   {9/12/2000 - Changed FooterRect to be the Entire ClientWidth when padding columns}
   if (PadColumnStyle = pcsPlain) then
      FooterRect.Right:= LastFooterCellRect.Right//+1
   else begin
      // Don't change left as it then paints left footer area with wrong lines
//      if PadColumnStyle = pcsPadHeaderAndData then
//        inc(FooterRect.Left);
      FooterRect.Right:= ClientWidth;
   end;

//   {1/13/2000 - Updated to use UseRightToLeftAlignment instead to test for Bidi mode}
{   if UseRightToLeftAlignment then
   begin
      Temp:= FooterRect.Right;
      FooterRect.Right:= LastFooterCellRect.Left;
      FooterRect.Left:= Temp;
   end;
}
   FillWithFixedBitmap(FooterRect, -1, FFooterColor);

   ACanvas.Pen.Color:= LineColors.HighlightColor;
   ACanvas.MoveTo(FooterRect.Left, FooterRect.Top-1);
   ACanvas.LineTo(FooterRect.Left, FooterRect.Bottom);

   if (PadColumnStyle = pcsPlain) or ((PadColumnStyle = pcsPadHeader) and (BorderStyle <> bsNone)) then
   begin
     ACanvas.Pen.Color:= clBlack;
     ACanvas.MoveTo(FooterRect.Left, FooterRect.Top-1);
     ACanvas.LineTo(FooterRect.Right, FooterRect.Top-1);
     ACanvas.LineTo(FooterRect.Right, FooterRect.Bottom+1);

//     FillWithFixedBitmaps(FooterRect, -1, FFooterColor);

     ACanvas.Pen.Color:= LineColors.HighlightColor;
     ACanvas.MoveTo(FooterRect.Left, FooterRect.Top);
     ACanvas.LineTo(FooterRect.Right, FooterRect.Top);
     ACanvas.MoveTo(FooterRect.Left, FooterRect.Top);
     ACanvas.LineTo(FooterRect.Left, FooterRect.Bottom);

     ACanvas.Pen.Color:= clBlack;
     ACanvas.MoveTo(FooterRect.Left, FooterRect.Bottom-1);
     ACanvas.LineTo(FooterRect.Right, FooterRect.Bottom-1);
   end;

   ACanvas.Pen.Color:= clBlack;
   ACanvas.MoveTo(FooterRect.Left, FooterRect.Bottom);
   ACanvas.LineTo(FooterRect.Right, FooterRect.Bottom);

   if FDatalink.Active then
   begin
      for ACol:= FIndicatorOffset to (inherited FixedCols)-FIndicatorOffset do
         ProcessFooterCell(ACol);
      for ACol:= LeftCol to ColCount-1 do
         ProcessFooterCell(ACol);
   end;

//   EndPainting;
{
   FooterRect:= GetFooterRect;
   FooterRect.Top:= FooterRect.Top -1;
   FooterRect.Bottom:= FooterRect.Bottom +1;
   TempRect:= FooterRect;
   if (ACanvas.CanvasOrientation = coRightToLeft) then
   begin
      TempRect.Left := FooterRect.Right;
      TempRect.Right := FooterRect.Left;
   end;
   inherited Canvas.CopyRect(TempRect, ACanvas, TempRect);
}
   if UseRightToLeftAlignment then ChangeOrientation(false);
   EndPainting;
end;

procedure TwwCustomDBGrid.SetFooterColor(sel: TColor);
begin
   if sel<>FFootercolor then
   begin
      FFooterColor:= sel;
      LayoutChanged;
   end;
end;

procedure TwwCustomDBGrid.SetFooterCellColor(sel: TColor);
begin
   if sel<>FFooterCellColor then
   begin
      FFooterCellColor:= sel;
      LayoutChanged;
   end;
end;

procedure TwwCustomDBGrid.SetFooterHeight(val: integer);
begin
   if (val<>FFooterHeight) then
   begin
      if FFooterHeight<0 then FFooterHeight:= 0
      else FFooterHeight:= val;
      LayoutChanged;
   end;
end;


(*
procedure TwwCustomDBGrid.PaintWindow(DC: HDC);
var GridRect: TRect;
    TempRect: TRect;
    tempDC: HDC;
    save: HBitmap;
    PS: TPaintStruct;
//    bm: HBitmap;
    DrawBitmap2: TBitmap;
    tempDC: HDC;
begin
  DrawBitmap2 := TBitmap.Create;
  DrawBitmap2.Height:= Height;
  DrawBitmap2.Width:= Width;

//  BeginPaint(Handle, PS);

  Canvas.Lock;
  tempDC:= CreateCompatibleDC(DC);

//  bm:= CreateCompatibleBitmap(tempDC, Width, Height);
//  Save:= SelectObject(tempDC, bm);

  Save:= SelectObject(tempDC, DrawBitmap2.handle);
  Canvas.Handle:= tempDC;

  try
    RealCanvas.Handle := DC;
    GridRect:= Rect(0, 0, Width, Height);

    try
      TempRect:= RealCanvas.ClipRect;
      Paint;
      RealCanvas.CopyRect(TempRect, Canvas, TempRect);
    finally
      Canvas.Handle := 0;
      RealCanvas.Handle := 0;
    end;
  finally
    Canvas.Unlock;
    SelectObject(tempDC, Save);
    DeleteObject(tempDC);
//    DeleteDC(tempDC);
//    DeleteObject(bm);
//    DrawBitmap2.Free;
  end;
end;
*)

procedure TwwCustomDBGrid.GetControlInfo(AFieldName: string;
      var AControlType: string; var AParameters: string);
var TempComponent: TComponent;
begin
   if ControlInfoInDataset then begin
      TempComponent:= Datasource.dataset;
      if (DataSource.DataSet=nil) or (wwGetControlType(Datasource.dataset)=nil) then TempComponent:= self;
   end
   else TempComponent:= self;
   WWDataSet_GetControl(TempComponent, AFieldName, AControlType, AParameters);
end;

function TwwCustomDBGrid.GetControlType: TStrings;
begin
   result:= nil;
   if ControlInfoInDataset then result:= wwGetControlType(Datasource.dataset);
   if result=nil then  { Delphi5}
      result:= controlType;
end;

procedure TwwCustomDBGrid.DoUpdateFooter;
begin
   if Assigned(FOnUpdateFooter) then FOnUpdateFooter(self);
end;

procedure TwwCustomDBGrid.WMRButtonDown(var Message: TWMRButtonDown);
var parentform: TCustomForm;
begin
  if not (csDesigning in ComponentState) then
  begin
     ParentForm := GetParentForm(Self) as TCustomForm;
     if (ParentForm<>Nil) and
        (TForm(ParentForm).FormStyle = fsMDIChild) then
     begin
        {7/2/2000 - Check for nil Screen.ActiveControl}
        if (Screen.ActiveControl=nil) or (GetParentForm(Screen.ActiveControl)<>ParentForm) then
        begin
           Windows.SetFocus(handle);
           { 9/22/98 - Don't call inherited if fail to set focus as this would
             lead to OnValidate getting called twice }
           if Windows.GetFocus<>self.handle then exit;
        end
     end
  end;
  inherited;
end;

procedure TwwCustomDBGrid.WMLButtonDown(var Message: TWMLButtonDown);
var parentform: TCustomForm;
begin
  if not (csDesigning in ComponentState) then
  begin
     ParentForm := GetParentForm(Self) as TCustomForm;
     if (ParentForm<>Nil) and
        (TForm(ParentForm).FormStyle = fsMDIChild) then
     begin
        {7/2/2000 - Check for nil Screen.ActiveControl}
        if (Screen.ActiveControl=nil) or (GetParentForm(Screen.ActiveControl)<>ParentForm) then
        begin
           { 9/22/98 - Don't call inherited if fail to set focus as this would
             lead to OnValidate getting called twice }
           Windows.SetFocus(handle);
           if Windows.GetFocus<>self.handle then exit;
        end
     end
  end;
  inherited;
end;

//8/8/2001- PYW - Make sure Datalink is active before going to next or prior record with mouse wheel.
{$ifdef wwdelphi4up}
function TwwCustomDBGrid.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
     if (FDataLink<>nil) and FDataLink.Active then DataSource.DataSet.Next;
  result := True;
end;

function TwwCustomDBGrid.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
     if (FDataLink<>nil) and FDataLink.Active then DataSource.DataSet.Prior;
  result := True;
end;

function TwwCustomDBGrid.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TwwCustomDBGrid.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TwwCustomDBGrid.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  if Showing and ((Height=0) or (Width=0)) and (Align<>alNone) and { 11/11/98 - Check width too}
    (self is TwwDBGrid) and (TwwDBGrid(self).Patch[1]=False) then
  begin
     RequestAlign; { 10/21/98 }
  end;
//  if not Showing then CollapseChildGrid;

end;
{$endif}

procedure TwwCustomDBGrid.DoCreateHintWindow(
  HintWindow: TwwGridHintWindow;
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

procedure TwwCustomDBGrid.ClearURLPaint;
begin
   URLLinkActive:= False;
   if (URLLinkActiveRow>=0) then
   begin
      Cursor:= FSavedCursor; // 4/9/2002 -PYW - Restore saved Cursor.  Preserve Cursor before URLPaint
      if IsValidCell(URLLinkActiveCol, URLLinkActiveRow) then
      begin
         InvalidateCell(URLLinkActiveCol, URLLinkActiveRow);
      end;
   end;
   URLLinkActiveRow:= -1;
   URLLinkActiveCol:= -1;
end;

procedure TwwCustomDBGrid.MouseMove(Shift: TShiftState; AX, AY: Integer);
var PriorRow: integer;
    indicatoroffset, titleoffset: integer;
    R: TRect;
    sp: TPoint;
    AHintText: string;
    drawrect: trect;
    drawflags: Integer;
    oldmaxheight, maxwidth, maxheight, hintwidth: Integer;
    DoDefault: boolean;
    VerticalFits, HorizontalFits: boolean;
    curField: TField;
    i: integer;
    startcol, endcol: integer;
    checkHot: boolean;
begin
   inherited;
//   form1.edit1.text:= form1.edit1.text + '1';
   with MouseCoord(Ax,Ay) do
   begin

      // Support url links
      if (x>=0) and (y>=FTitleOffset) and (x<FCacheColInfo.count) and
         (TwwCacheColInfoItem(FCacheColInfo[x]).ControlType='URL-Link') then
      begin
         if (URLLinkActiveCol<>x) or (URLLinkActiveRow<>y) then
         begin
            // 4/9/2002 -PYW - Preserve current Cursor.
            if cursor <> crHandPoint then FSavedCursor := Cursor;
            Cursor:= crHandPoint;
            URLLinkActive:= True;
            if URLLinkActiveRow<>0 then
               InvalidateCell(URLLinkActiveCol, URLLinkActiveRow);
            URLLinkActiveRow:= y;
            URLLinkActiveCol:= x;
            r:= CellRect(URLLinkActiveCol, URLLinkActiveRow);
            InvalidateRect(Handle, @r, False);
         end
      end
      else if (Cursor = crHandPoint) and URLLinkActive then
      begin
         Cursor:= FSavedCursor; // 4/9/2002 -PYW - Restore saved cursor
         URLLinkActive:= False;
         if URLLinkActiveRow<>0 then
         // Don't use InvalidateCell as it repaints the entire cell
         // instead of just the top part.
//            InvalidateCell(URLLinkActiveCol, URLLinkActiveRow);
         begin
            r:= CellRect(URLLinkActiveCol, URLLinkActiveRow);
            InvalidateRect(Handle, @r, False);
         end;
         URLLinkActiveRow:= -1;
         URLLinkActiveCol:= -1;
      end;

      checkHot:= false;
      if (x>=FIndicatorOffset) and (Columns[dbCol(x)].GroupName <> '') then
      begin
         R := GroupNameCellRect(x,0,StartCol,EndCol);
         if AY <= R.Bottom then begin
            if not MouseOverGroupTitle then CheckHot:= True;
         end
         else if MouseOverGroupTitle then CheckHot:= True
      end;

      if ((x<>TitlelastMouseX) or (y<>TitlelastMouseY)) or CheckHot then
      begin
         if ThemeServices.themesenabled and not (cslButtonDown in ControlState) then
         begin
            if (y<FTitleOffset) then
            begin
               InvalidateCell(x,y);
            end;
            if titlelastmousey<FTitleoffset then
            begin
               InvalidateCell(titlelastmousex,titlelastmousey);
            end;

            MouseOverGroupTitle := False;
            if (dbCol(x)>=0) and (dbRow(y)<0) then begin
             if (Columns[dbCol(x)].GroupName <> '') then begin
               R := GroupNameCellRect(x,0,StartCol,EndCol);
               if AY <= R.Bottom then begin
                 MouseOverGroupTitle := True;
               end;
             end
            end;

            InvalidateTitle;
            TitlelastMouseX:= x;
            TitlelastMouseY:= y;
         end;
      end;

      if not (dgShowCellHint in Options) then exit;
      if not Datalink.Active then exit;  //7/26/2001-PYW-Make sure datalink is active if showing hints.

      if ((x<>lastMouseX) or (y<>lastMouseY)) then begin
         R:= inherited CellRect(x,y); // 12/21/01 - Fix hint not showing bug

         lastMouseX:= x;
         lastMouseY:= y;
         FreeHintWindow;
         HintTimer.Free;
         HintTimer:= nil;

         if (x=Col) and (y=Row) then begin
            if (InplaceEditor<>nil) and (InplaceEditor.visible) then exit;
            if self is TwwDBGrid then begin
              if (TcheatCast(self).currentcustomedit<>nil) and
                 (TCheatCast(self).currentcustomedit.visible) then exit;
            end
         end;

         indicatorOffset:= 0;
         titleoffset:= 0;
         if dgIndicator in Options then indicatorOffset:= 1;
         if dgTitles in Options then titleOffset:= 1;
         if (y>=titleOffset) and (x>=IndicatorOffset) then
         begin
            curField:= Fields[x-indicatorOffset];
            PriorRow:= DataLink.ActiveRecord;  // Recursive grids should rely on prior activerecord
            DataLink.ActiveRecord:= y-titleoffset+RowOffset;
            AHintText:= '';
            try
              if x-indicatorOffset<ColCount then
              begin
                 if curField is TBlobField then
                 begin
                    if curField.dataType in [ftMemo, ftOraBlob, ftOraClob] then
                       AHintText:= GetFieldValue(x-indicatorOffset)
                 end
                 else begin
                    AHintText:= GetFieldValue(x-indicatorOffset)
                 end;
              end;
            finally
              DataLink.ActiveRecord:= PriorRow;
            end;

            if AHintText='' then exit;

            drawRect := Rect(0, 0, r.Right-r.left-4, 0);
            drawflags:= DT_NOPREFIX;
            if dgWordWrap in Options then drawflags:= drawflags or DT_EDITCONTROL or DT_WORDBREAK;
            if pos(#9, AHintText)>0 then drawFlags:= drawFlags or DT_EXPANDTABS; // 9/7/00
            Canvas.Font.assign(Font); { 8/24/00 - Set default before calling calccellcolors}
            DoCalcCellColorsDetect(curField, [], False, Canvas.Font, Canvas.Brush);

            DrawTextEx(Canvas.Handle, PChar(AHintText),
                      Length(AHintText), drawrect, DrawFlags or DT_CALCRECT, nil);

            VerticalFits:= (drawrect.bottom-drawrect.top<=r.bottom-r.top);
            HorizontalFits:= (drawrect.Right-drawrect.Left<r.right-r.left-1);
            if VerticalFits and HorizontalFits then exit;

            HintWindow:= CreateHintWindow(Fields[x-indicatoroffset]);
            HintWindow.Canvas.Font.assign(Canvas.Font); { Default to current cell's font }
            HintTimer:= TTimer.create(self);
            HintTimer.OnTimer:=HintTimerEvent;
            HintTimer.Interval:=250;
            HintTimer.Enabled:= True;

            sp:= self.ClientToScreen(Point(0, 0));
            with TwwGridHintWindow(HintWindow) do
            begin
               if FieldMappedText or (curField.Alignment = taLeftJustify) then
                 Alignment:= taLeftJustify
               else
                 Alignment:= curField.Alignment;

               DoDefault:= True;
               WordWrap:= True;
               MaxHeight:= r.bottom-r.top-2;
               OldMaxHeight:= MaxHeight;
               MaxWidth:= Screen.Width;
               Caption:= AHintText; // 9/7/00
               DoCreateHintWindow(TwwGridHintWindow(HintWindow),
                   Fields[x-indicatoroffset],
                   R, WordWrap,
                   MaxWidth, MaxHeight, DoDefault);

               { 2/29/00 - subtract 4 to be consistent with above calculation }
               MaxWidth := max((r.right-r.left-4), MaxWidth);

               if not DoDefault then exit;

               R.bottom:= R.Bottom -2;

//               MaxWidth:= wwmax(r.Right-r.left, MaxWidth);
               drawRect := Rect(0, 0, MaxWidth, MaxHeight);
               drawflags:= DT_NOPREFIX;
               if WordWrap then drawflags:= drawflags or DT_EDITCONTROL or DT_WORDBREAK;
               if pos(#9, AHintText)>0 then drawFlags:= drawFlags or DT_EXPANDTABS; // 9/7/00
               DrawTextEx(Canvas.Handle, PChar(AHintText),
                   Length(AHintText), drawrect, DrawFlags or DT_CALCRECT, nil);
               hintwidth := drawrect.right-drawrect.left;
               if drawrect.right>MaxWidth then
                  drawrect.right:= MaxWidth;
               if drawrect.bottom>Maxheight then
                  drawrect.bottom:= MaxHeight;

               if MaxHeight<>OldMaxHeight then
                  r.bottom:= wwmax(r.top + drawrect.bottom, r.bottom);

               { FieldMappedText set to True by GetFieldValue if its mapped }
               if (Alignment = taLeftJustify) then
               begin
                  if r.left + drawrect.right + 8<=MaxWidth then
                     r.right:= r.Left + drawrect.right + 8
                  else if MaxWidth<>0 then begin
                     //r.right := r.Left + MaxWidth + 8
                  //6/29/2000 - PYW - Compute hint position correctly in different screen resolutions
                  //                  like 800x600 and when setting MaxLength in event.
                      if r.left + DrawRect.right + 8 > Screen.Width then
                         r.left:= r.right - drawrect.right - 8
                      else
                         r.right:= r.left + hintwidth + 8;
                  end;
               end
               else
                  r.left:= r.right - drawrect.right - 8;


               OffsetRect(R, sp.x, sp.y-1);
               ActivateHint(R, AHintText);
            end;
         end;
      end
   end
end;

procedure TwwCustomDBGrid.FreeHintWindow;
begin
   HintTimerCount:= 0;
   SkipErase:= True;
   HintWindow.Free;
   SkipErase:= False;
   HintWindow:= nil;
   if HintTimer<>nil then HintTimer.enabled:= False;
end;

Function TwwCustomDBGrid.CreateHintWindow(AField: TField): THintWindow;
begin
   HintWindow:= TwwGridHintWindow.create(self);
   HintWindow.Color:= GetSysColor(COLOR_INFOBK);
   HintWindow.Canvas.Brush.Color:= GetSysColor(COLOR_INFOBK);
   HintWindow.Canvas.Font:= self.Font;
   HintWindow.Canvas.Font.Color:= GetSysColor(COLOR_INFOTEXT);
   HintWindow.Canvas.Pen.Color:= clBlack;
   TwwGridHintWindow(HintWindow).Field:= AField;
   result:= HintWindow;
end;

procedure TwwCustomDBGrid.HintTimerEvent(Sender: TObject);
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

{$ifdef wwDelphi4Up}
procedure TwwCustomDBGrid.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if True or  // try never erasea background as with buffered paint this
              // unnecessary.  In addition, it would cause flicker when
              // resizing column
     (parent is TCustomGrid) or
     SkipErase or (PaintOptions.OrigBitmap<>nil) then begin
     Message.result:= 1;
     exit;
  end
  else inherited;
end;

{$endif}

procedure TwwCustomDBGrid.BeginUpdate;
begin
  if not HandleAllocated then exit;
  if not Showing then exit;
  if FUpdateCount = 0 then SetUpdateState(True);
  Inc(FUpdateCount);
end;

procedure TwwCustomDBGrid.SetUpdateState(Updating: Boolean);
begin
  SendMessage(Handle, WM_SETREDRAW, Ord(not Updating), 0);
end;

procedure TwwCustomDBGrid.EndUpdate(Repaint: boolean = False);
begin
  if not HandleAllocated then exit;
  if not Showing then exit;

  if FUpdateCount>0 then Dec(FUpdateCount);
  if FUpdateCount = 0 then begin
     SetUpdateState(False);
     if Repaint then Invalidate;
  end
end;

Procedure TwwCustomDBGrid.InvalidateCurrentRow;
var i :integer;
begin
    for i:= 0 to colCount-1 do InvalidateCell(i, row);
end;

{ TCustomGrid }
function PointInGridRect(Col, Row: Longint; const Rect: TGridRect): Boolean;
begin
  Result := (Col >= Rect.Left) and (Col <= Rect.Right) and (Row >= Rect.Top)
    and (Row <= Rect.Bottom);
end;

(*
procedure FillDWord(var Dest; Count, Value: Integer); register;
asm
  XCHG  EDX, ECX
  PUSH  EDI
  MOV   EDI, EAX
  MOV   EAX, EDX
  REP   STOSD
  POP   EDI
end;

{ StackAlloc allocates a 'small' block of memory from the stack by
  decrementing SP.  This provides the allocation speed of a local variable,
  but the runtime size flexibility of heap allocated memory.  }
function StackAlloc(Size: Integer): Pointer; register;
asm
  POP   ECX          { return address }
  MOV   EDX, ESP
  ADD   EAX, 3
  AND   EAX, not 3   // round up to keep ESP dword aligned
  CMP   EAX, 4092
  JLE   @@2
@@1:
  SUB   ESP, 4092
  PUSH  EAX          { make sure we touch guard page, to grow stack }
  SUB   EAX, 4096
  JNS   @@1
  ADD   EAX, 4096
@@2:
  SUB   ESP, EAX
  MOV   EAX, ESP     { function result = low memory address of block }
  PUSH  EDX          { save original SP, for cleanup }
  MOV   EDX, ESP
  SUB   EDX, 4
  PUSH  EDX          { save current SP, for sanity check  (sp = [sp]) }
  PUSH  ECX          { return to caller }
end;

{ StackFree pops the memory allocated by StackAlloc off the stack.
- Calling StackFree is optional - SP will be restored when the calling routine
  exits, but it's a good idea to free the stack allocated memory ASAP anyway.
- StackFree must be called in the same stack context as StackAlloc - not in
  a subroutine or finally block.
- Multiple StackFree calls must occur in reverse order of their corresponding
  StackAlloc calls.
- Built-in sanity checks guarantee that an improper call to StackFree will not
  corrupt the stack. Worst case is that the stack block is not released until
  the calling routine exits. }
procedure StackFree(P: Pointer); register;
asm
  POP   ECX                     { return address }
  MOV   EDX, DWORD PTR [ESP]
  SUB   EAX, 8
  CMP   EDX, ESP                { sanity check #1 (SP = [SP]) }
  JNE   @@1
  CMP   EDX, EAX                { sanity check #2 (P = this stack block) }
  JNE   @@1
  MOV   ESP, DWORD PTR [ESP+4]  { restore previous SP  }
@@1:
  PUSH  ECX                     { return to caller }
end;

*)
procedure TwwCustomDBGrid.InheritedPaint;
type
  PIntArray = ^TIntArray;
  TIntArray = array[0..MaxCustomExtents] of Integer;
var
//  LineColor: TColor;
  DrawInfo: TGridDrawInfo;
  Sel: TGridRect;
//  UpdateRect: TRect;
  FColOffset: integer;
//  PaintClipRect: TRect;
//  R: TRect;

  procedure DrawCells(ACol, ARow: Longint; StartX, StartY, StopX, StopY: Integer;
    Color: TColor; IncludeDrawState: TGridDrawState);
  var
    CurCol, CurRow: Longint;
    Where,curRect,GroupTitleRect: TRect;
    DrawState: TGridDrawState;
    curGroupName:String;
    startcol, endcol: integer;
    TempRect: TRect;

    function IntersectingRects(r1, r2: TRect) : boolean;
    var r: TRect;
    begin
       result:= IntersectRect(r, r1, r2);
    end;

  begin
    CurRow := ARow;
    Where.Top := StartY;
    while (Where.Top < StopY) and (CurRow < RowCount) do
    begin
      CurCol := ACol;
      GroupTitleRect:=Rect(0,0,0,0);
      curGroupName := '';
      Where.Left := StartX;
      Where.Bottom := Where.Top + RowHeights[CurRow];
      while (Where.Left < StopX) and (CurCol < ColCount) do
      begin
//        DrawGroupTitle := False;
        Where.Right := Where.Left + ColWidths[CurCol];
           TempRect:= updateRect;
//        if UseRightToLeftAlignment then { 10/18/98 }
        if (Canvas.CanvasOrientation = coRightToLeft) then
        begin
           TempRect.right:= ClientWidth-UpdateRect.Left;
           TempRect.left:= ClientWidth-UpdateRect.Right;
        end;

        if (Where.Right > Where.Left) and RectVisible((inherited Canvas).Handle, Where) and
           ((not UseAlternateBuffering) or IntersectingRects(TempRect, Where)) then
//        if (Where.Right > Where.Left) and RectVisible((inherited Canvas).Handle, Where) then
        begin
//          PaintClipRect:= (inherited Canvas).ClipRect;

          DrawState := IncludeDrawState;
          if Focused and (CurRow = Row) and (CurCol = Col)  then
            Include(DrawState, gdFocused);
          if PointInGridRect(CurCol, CurRow, Sel) then
            Include(DrawState, gdSelected);
          if not ((gdFocused in DrawState) and (CurCol=Col)) or
            not (goEditing in inherited Options) or
            not EditorMode or (csDesigning in ComponentState) then
          begin
            curRect:= Where;

            // !!! Later optimize so called just for one group
            if (curRow=0) and (dgTitles in Options) then // Support hierarchical titles
            begin
               curRect:= TitleCellRect(curCol, curRow); // override rectangle for sub-group headings
               if (dbCol(curCol)>=0) and (Columns[dbCol(curCol)].GroupName <> '') then
               begin
                 GroupTitleRect := GroupNameCellRect(curCol,curRow,startcol,endcol, False);
                 DrawCell(CurCol,CurRow,GroupTitleRect,DrawState);
               end;
            end;
            DrawCell(CurCol, CurRow, curRect, DrawState);
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

//  UpdateRect := Canvas.ClipRect;
  CalcDrawInfo(DrawInfo);
  with DrawInfo do
  begin
    { Draw the cells in the four areas }
    Sel := Selection;

    FColOffset:= 0;
{    if (DataLink=nil) or (not DataLink.Active) then
    begin
       r:= inherited ClientRect;
       FillWithFixedBitmaps(r, -1, TitleColor);
    end;
}
    DrawCells(0, 0, 0, 0, Horz.FixedBoundary, Vert.FixedBoundary, FixedColor,
      [gdFixed]);
    DrawCells(LeftCol, 0, Horz.FixedBoundary - FColOffset, 0, Horz.GridBoundary,  //!! clip
        Vert.FixedBoundary, FixedColor, [gdFixed]);

    if (DataLink<>nil) and (DataLink.Active) then
    begin
      DrawCells(0, TopRow, 0, Vert.FixedBoundary, Horz.FixedBoundary,
         Vert.GridBoundary, FixedColor, [gdFixed]);
      DrawCells(LeftCol, TopRow, Horz.FixedBoundary - FColOffset,                   //!! clip
        Vert.FixedBoundary, Horz.GridBoundary, Vert.GridBoundary, Color, []);
    end
    else begin
//       R:= CellRect(LeftCol, FTitleOffset);
//       R.Right:= ClientWidth;
//       R.Bottom:= ClientHeight;
//       FillWithBlendBitmap(R, -1, Color);
    end;
{
    if dgIndicator in Options then
    begin
      R:= CellRect(0, 0);
      R.Top:= BottomData; //Vert.FullVisBoundary;
      R.top:= CellRect(0, DrawInfo.Vert.LastFullVisibleCell).Bottom;

      if RecordCountIsValid and (FDataLink.RecordCount>0) and
        ((FDataLink.RecordCount-RowOffset-1+TitleOffset)<DrawInfo.Vert.LastFullVisibleCell) then
        r.top:= inherited cellrect(0,fdatalink.recordcount-rowoffset+TitleOffset).top;

      R.Bottom:= ClientHeight;
      FillWithFixedBitmap(R, -1, TitleColor);
    end
}
  end;

  if UseRightToLeftAlignment then ChangeOrientation(False);
end;

procedure TwwCustomDBGrid.ChangeOrientation(RightToLeftOrientation: Boolean);
var
  Org: TPoint;
  Ext: TPoint;
  cr: TRect;
begin
  cr:= inherited GetClientRect;

  if RightToLeftOrientation then
  begin
    Org := Point(ClientWidth,0);
    Ext := Point(-1,1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, cr.bottom, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X*ClientWidth, Ext.Y*cr.bottom, nil);
  end
  else
  begin
    Org := Point(0,0);
    Ext := Point(1,1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, ClientWidth, cr.bottom, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X*ClientWidth, Ext.Y*cr.bottom, nil);
  end;
end;

function TwwCustomDBGrid.IsCustomEditCell(
        col, row: integer;
        var customEdit: TWinControl) : boolean;
var fldName: string;
    i, apos: integer;
    controlType : TStrings;
begin
   result:= False;
   if ecoDisableCustomControls in EditControlOptions then exit;
   if not isValidCell(col, row) then exit;
   fldName:= DataLink.fields[dbCol(col)].fieldName;

   { 8/14/97 - Optimized logic to speed painting of grid }
   ControlType:= GetControlType;
   for i:= 0 to ControlType.count-1 do begin
      APos:= 1;
      if strGetToken(controlType[i], ';', APos)<>fldName then continue;
      if isWWEditControl(strGetToken(controlType[i], ';', APos)) then
      begin
         customEdit:= GetComponent(strGetToken(controlType[i], ';', APos));
         if customEdit=Nil then break;
         if GetParentForm(customEdit)<>nil then { 1/20/2000 - Check if have parent form }
            if wwisClass(GetParentForm(customEdit).classType, 'TwwRecordViewForm') then break;
	 result:= True;
	 break;
      end
   end;

   if (FDateTimePicker<>Nil) and
      (not (ecoDisableDateTimePicker in EditControlOptions)) and
      (not result) and (DataLink.Fields[dbcol(col)] is TDateTimeField) then
   begin
      customEdit:= FDateTimePicker;
      result:= True;
   end;

end;

   Function TwwCustomDBGrid.GetComponent(thisName: string): TWinControl;
   var component: TComponent;
       form: TComponent;
       frameComponent: TComponent;
   begin
      result:= Nil;
      if ecoSearchOwnerForm in EditControlOptions then form:= wwGetOwnerFrameOrForm(self)
      else form:= GetParentForm(self) as TCustomForm; { -ksw (6/22/98) }
      if form=nil then exit; { 5/2/97 }

      { 5/2/97 - Also search owner of dataset form }
      component:= nil;
      if (pos('.', thisName)>0) then begin
         if (length(StrTrailing(thisName,'.'))>0) then begin
            framecomponent:= Form.FindComponent(strPreceding(thisName, '.'));
            if wwIsClass(frameComponent.classtype, 'TCustomFrame') then
               component:= framecomponent.FindComponent(strTrailing(thisName,'.'))
            else begin
              if (DataSource=nil) or (DataSource.DataSet=Nil) or
                 (DataSource.DataSet.owner=nil) then exit;
              component:= DataSource.Dataset.owner.FindComponent(strTrailing(thisName,'.'));
            end
         end
      end
      else component:= Form.FindComponent(thisName);
      if (component<>Nil) and (component is TWinControl) then
         result:= TWinControl(component);

   end;

// Don't use default horizontal scrolling as it is flickery
procedure TwwCustomDBGrid.WMHScroll(var Msg: TWMHScroll);
//var r: TRect;
begin
  if (not PaintOptions.HaveBackgroundForDataCells) and
     (not UseRightToLeftAlignment) then begin  // 6/5/01 - old behavior if not background blend
     inherited;
     exit;
  end;

  if msg.ScrollCode = SB_ThumbTrack then begin
     inherited;
     exit;
  end;
  if (CurrentCustomEdit<>nil) then  // Hide custom edit
  begin
     CurrentCustomEdit.visible:= False;
     CurrentCustomEdit:= nil;
  end;

  // RSW - Give focus now so that child grid's hiding of inplaceeditor completes
  // Otherwise hiding it may fail and leave white cell
  if not AcquireFocus then Exit;
//  inherited;
//  exit;

  BeginUpdate;
  inherited;

  // 1/20/01 - Hides inplaceeditor in case is still shown for some reason
  if (Inplaceeditor<>nil) and
     (CellRect(Col, Row).Left<CellRect(Col-1, Row).Left) or
     (Col<LeftCol) then
  begin
     if inplaceEditor<>nil then
        inplaceeditor.left:= Width+10;
  end;

  EndUpdate;

  invalidate;


//     HideEditor;
{   with InplaceEditor do begin
    Invalidate;
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_HIDEWINDOW or SWP_NOZORDER or
      SWP_NOREDRAW);
    if Focused then Windows.SetFocus(self.Handle);
   end;
   end;
}

end;
(*
function TwwCustomDBGrid.CalcMaxTopLeft(const Coord: TGridCoord;
  const DrawInfo: TGridDrawInfo): TGridCoord;

  function CalcMaxCell(const Axis: TGridAxisDrawInfo; Start: Integer): Integer;
  var
    Line: Integer;
    I, Extent: Longint;
  begin
    Result := Start;
    with Axis do
    begin
      Line := GridExtent + EffectiveLineWidth;
      for I := Start downto FixedCellCount do
      begin
        Extent := GetExtent(I);
        if Extent > 0 then
        begin
          Dec(Line, Extent);
          Dec(Line, EffectiveLineWidth);
          if Line < FixedBoundary then
          begin
            if (Result = Start) and (GetExtent(Start) <= 0) then
              Result := I;
            Break;
          end;
          Result := I;
        end;
      end;
    end;
  end;

begin
  Result.X := CalcMaxCell(DrawInfo.Horz, Coord.X);
  Result.Y := CalcMaxCell(DrawInfo.Vert, Coord.Y);
end;

function LongMulDiv(Mult1, Mult2, Div1: Longint): Longint; stdcall;
  external 'kernel32.dll' name 'MulDiv';

procedure TwwCustomDBGrid.ModifyScrollBar(ScrollBar, ScrollCode, Pos: Cardinal;  UseRightToLeft: Boolean);
var
  NewTopLeft, MaxTopLeft: TGridCoord;
  DrawInfo: TGridDrawInfo;
  RTLFactor: Integer;
  Temp: Longint;
  FTopLeft: TGridCoord;

  function Min: Longint;
  begin
    if ScrollBar = SB_HORZ then Result := FixedCols
    else Result := FixedRows;
  end;

  function Max: Longint;
  begin
    if ScrollBar = SB_HORZ then Result := MaxTopLeft.X
    else Result := MaxTopLeft.Y;
  end;

  function PageUp: Longint;
  var
    MaxTopLeft: TGridCoord;
  begin
    MaxTopLeft := CalcMaxTopLeft(FTopLeft, DrawInfo);
    if ScrollBar = SB_HORZ then
      Result := FTopLeft.X - MaxTopLeft.X else
      Result := FTopLeft.Y - MaxTopLeft.Y;
    if Result < 1 then Result := 1;
  end;

  function PageDown: Longint;
  var
    DrawInfo: TGridDrawInfo;
  begin
    CalcDrawInfo(DrawInfo);
    with DrawInfo do
      if ScrollBar = SB_HORZ then
        Result := Horz.LastFullVisibleCell - FTopLeft.X else
        Result := Vert.LastFullVisibleCell - FTopLeft.Y;
    if Result < 1 then Result := 1;
  end;

  function CalcScrollBar(Value, ARTLFactor: Longint): Longint;
  begin
    Result := Value;
    case ScrollCode of
      SB_LINEUP:
        Dec(Result, ARTLFactor);
      SB_LINEDOWN:
        Inc(Result, ARTLFactor);
      SB_PAGEUP:
        Dec(Result, PageUp * ARTLFactor);
      SB_PAGEDOWN:
        Inc(Result, PageDown * ARTLFactor);
      SB_THUMBPOSITION, SB_THUMBTRACK:
        if (goThumbTracking in inherited Options) or (ScrollCode = SB_THUMBPOSITION) then
        begin
          if (not UseRightToLeftAlignment) or (ARTLFactor = 1) then
            Result := Min + LongMulDiv(Pos, Max - Min, MaxShortInt)
          else
            Result := Max - LongMulDiv(Pos, Max - Min, MaxShortInt);
        end;
      SB_BOTTOM:
        Result := Max;
      SB_TOP:
        Result := Min;
    end;
  end;

{  procedure ModifyPixelScrollBar(Code, Pos: Cardinal);
  var
    NewOffset: Integer;
    OldOffset: Integer;
    R: TGridRect;
    GridSpace, ColWidth: Integer;
  begin
    NewOffset := FColOffset;
    ColWidth := ColWidths[DrawInfo.Horz.FirstGridCell];
    GridSpace := ClientWidth - DrawInfo.Horz.FixedBoundary;
    case Code of
      SB_LINEUP: Dec(NewOffset, Canvas.TextWidth('0') * RTLFactor);
      SB_LINEDOWN: Inc(NewOffset, Canvas.TextWidth('0') * RTLFactor);
      SB_PAGEUP: Dec(NewOffset, GridSpace * RTLFactor);
      SB_PAGEDOWN: Inc(NewOffset, GridSpace * RTLFactor);
      SB_THUMBPOSITION,
      SB_THUMBTRACK:
        if (goThumbTracking in Options) or (Code = SB_THUMBPOSITION) then
        begin
          if not UseRightToLeftAlignment then
            NewOffset := Pos
          else
            NewOffset := Max - Integer(Pos);
        end;
      SB_BOTTOM: NewOffset := 0;
      SB_TOP: NewOffset := ColWidth - GridSpace;
    end;
    if NewOffset < 0 then
      NewOffset := 0
    else if NewOffset >= ColWidth - GridSpace then
      NewOffset := ColWidth - GridSpace;
    if NewOffset <> FColOffset then
    begin
      OldOffset := FColOffset;
      FColOffset := NewOffset;
      ScrollData(OldOffset - NewOffset, 0);
      FillChar(R, SizeOf(R), 0);
      R.Bottom := FixedRows;
      InvalidateRect(R);
      Update;
      UpdateScrollPos;
    end;
  end;
}
begin
  FTopLeft.x:= Left;
  FTopLeft.y:= Top;
  if (not UseRightToLeftAlignment) or (not UseRightToLeft) then
    RTLFactor := 1
  else
    RTLFactor := -1;
  if Visible and CanFocus and TabStop and not (csDesigning in ComponentState) then
    SetFocus;
  CalcDrawInfo(DrawInfo);
{  if (ScrollBar = SB_HORZ) and (ColCount = 1) then
  begin
    ModifyPixelScrollBar(ScrollCode, Pos);
    Exit;
  end;}
  MaxTopLeft.X := ColCount - 1;
  MaxTopLeft.Y := RowCount - 1;
  MaxTopLeft := CalcMaxTopLeft(MaxTopLeft, DrawInfo);
  NewTopLeft := FTopLeft;
  if ScrollBar = SB_HORZ then
    repeat
      Temp := NewTopLeft.X;
      NewTopLeft.X := CalcScrollBar(NewTopLeft.X, RTLFactor);
    until (NewTopLeft.X <= FixedCols) or (NewTopLeft.X >= MaxTopLeft.X)
      or (ColWidths[NewTopLeft.X] > 0) or (Temp = NewTopLeft.X)
  else
    repeat
      Temp := NewTopLeft.Y;
      NewTopLeft.Y := CalcScrollBar(NewTopLeft.Y, 1);
    until (NewTopLeft.Y <= FixedRows) or (NewTopLeft.Y >= MaxTopLeft.Y)
      or (RowHeights[NewTopLeft.Y] > 0) or (Temp = NewTopLeft.Y);
  NewTopLeft.X := Math.Max(FixedCols, Math.Min(MaxTopLeft.X, NewTopLeft.X));
  NewTopLeft.Y := Math.Max(FixedRows, Math.Min(MaxTopLeft.Y, NewTopLeft.Y));
//  if (NewTopLeft.X <> FTopLeft.X) or (NewTopLeft.Y <> FTopLeft.Y) then
//    MoveTopLeft(NewTopLeft.X, NewTopLeft.Y);
end;
*)

procedure TwwCustomDBGrid.PaintClickedTitleButton;
var ARect: TRect;
    TempY,StartCol,EndCol: integer;
begin
   if (TitleClickColumn>=0) and
      FTitleButtons and (dgTitles in Options) and (not useDragCanvas) then
   begin
       with Canvas do begin
          if TitleClickGroupTitle then
          begin
             ARect := GroupNameCellRect(TitleClickColumn,0,StartCol,EndCol);
             ARect.Bottom := ARect.Bottom-1;
          end
          else begin
             ARect:= TitleCellRect(TitleClickColumn, 0);
          end;
          TempY:= ARect.Bottom;
//          if not (dgRowLines in Options) then TempY:= TempY-2;
          if not (HaveAnyRowLines) then TempY:= TempY-2;
          if UseThemesInTitle then exit;
//          if ThemeServices.ThemesEnabled then exit;

          Pen.Color:= clBlack;
          with ARect do begin
             PolyLine([Point(Left, Top), Point(Left, TempY)]);
	     PolyLine([Point(Left, Top), Point(Right, Top)]);
          end;
	  Pen.Color:= clGray;
	  with ARect do begin
	     PolyLine([Point(Left+1, Top+1), Point(Left+1, TempY-1)]);
             if not TitleClickGroupTitle then
                PolyLine([Point(Left+1, TempY-1), Point(Right, TempY-1)])
          end;

          // Makes look more 3d buttons
{          Pen.Color:= clWhite;
          with ARect do begin
             PolyLine([Point(Right, Top), Point(Right, TempY)]);
	     PolyLine([Point(Left, TempY), Point(Right, TempY)]);
          end;
}
//	  Pen.Color:= clBtnFace;
//	  with ARect do begin
//             PolyLine([Point(Left+1, TempY-1), Point(Right, TempY-1)])
//          end;

      end
   end
end;

  procedure TwwCustomDBGrid.Draw3DLines(ARect: TRect; ACol, ARow: integer;
	    AState: TGridDrawState);
  var OrigPenColor: TColor;
      r: TRect;
  begin
     OrigPenColor := Canvas.Pen.Color;
{     if RowOffset>0 then
        ARect:= inherited CellRect(ACol, ARow)
     else begin
        ARect:= ARect;
     end;
}
     ARect.bottom:= ARect.Top + RowHeights[ARow];

     if SkipLineDrawing then exit;

     // Always paint row lines in title area
     if (gdFixed in AState) and (ARow>=FTitleOffset) and
        (dgRowLinesDisableFixed in Options) then exit;

     if not (gdFixed in AState) and not (dgRowLines in Options) then exit;
     SkipLineDrawing:= True;

     { 4/16/97 - Treat as non-3d when white background }
           { Exit if highlighted cell, and background color is same as highlight }
      if (LineStyle = glsDynamic) then
         isWhiteBackground:= ColorToRGB(Canvas.Brush.Color)=clWhite
     else isWhiteBackground:= ColorToRGB(Color)=clWhite;

     if (dbRow(ARow)=0) then // Do just for first row
       TwwCacheColInfoItem(FCacheColInfo[ACol]).IsWhiteBackground:= IsWhiteBackground;

     if PaintOptions.HaveBackgroundForDataCells then IsWhiteBackground:=True;

     // 3/4/01 - Highlighted row should not have white lines on top so treat as non-3d line
//     if (Row=Arow) and (dgRowSelect in Options) then IsWhiteBackground:= True;

     if dbRow(ARow)<0 then exit;
     if dbCol(ACol)<0 then exit;

     if (ACol>=FIndicatorOffset) and (ARow>=FTitleOffset) and (ColorToRGB(Color)=clWhite) then
     begin
        if HighlightCell(ACol, dbRow(ARow), '', AState) then
        begin
           if (ColorToRGB(Canvas.Brush.Color)=ColorToRGB(clHighLight)) or
              (PaintOptions.ActiveRecordColor<>clNone) and
               (ColorToRGB(Canvas.Brush.Color)=ColorToRGB(PaintOptions.ActiveRecordColor)) then
           begin
              IsWhiteBackground:=True;
              TwwCacheColInfoItem(FCacheColInfo[ACol]).IsWhiteBackground:= IsWhiteBackground;
           end
        end
     end;

     with Canvas do begin
        Pen.Width:= 1;
        if (dgRowLines in Options) then
        begin
           r:= ARect; //CellRect(ARow, ACol);
           if (LineStyle = glsSingle) or
              ((LineStyle = glsDynamic) and IsWhiteBackground) then
           begin
              Canvas.Pen.Color:= LineColors.DataColor;
              if DrawCellInfo.DefaultDrawHorzBottomLine then
                 Canvas.PolyLine([Point(r.left, r.Bottom),Point(r.Right, r.Bottom)]);
           end
           else begin
              Canvas.Pen.Color:= LineColors.ShadowColor;
              if DrawCellInfo.DefaultDrawHorzBottomLine then
                 Canvas.PolyLine([Point(r.left, r.bottom),Point(r.Right, r.bottom)]);

              if (ARow=Row) and (FFocused or (dgAlwaysShowEditor in Options)) and
                 ((dgRowSelect in Options) or (PaintOptions.ActiveRecordColor<>clNone)) then exit;

              Canvas.Pen.Color:= LineColors.HighlightColor;
              if DrawCellInfo.DefaultDrawHorzTopLine then
                 Canvas.PolyLine([Point(r.left, r.top), Point(r.Right, r.top)]);
           end;
        end;
        Pen.Color:= OrigPenColor;
     end;
  end;


procedure TwwCustomDBGrid.DrawLines;
var i:integer;
    right,bottom:integer;
    currowheight,titleheight:integer;
    DrawInfo: TGridDrawInfo;
    isWhiteBackground:boolean;
    TempY, TempX, TempLeft, TempLeft2, TempTop, Tempbottom: integer;
    ARect: TRect;
    r: TRect;
//    curField: TField;
    FldName, GroupName, curGroupName: string;
    GroupOffset: integer;
    bidioffset: integer;

    TempCol, StartX, EndX: integer;
    CustomLineDrawing: boolean;

    // line drawing uses inherited cell rect
    function CellRect(ACol, ARow: integer): TRect;
    begin
      result:= inherited CellRect(ACol, ARow);
    end;

 procedure DrawVertLines;
 var i: integer;
//    TempRect:TRect;
   procedure DrawVertLine(StartY, EndY: integer);
   begin
        if (FDataLink=nil) or (not FDataLink.active) then exit;

        if (LineStyle = glsSingle) or
           ((LineStyle = glsDynamic) and IsWhiteBackground) then
        begin
           Canvas.Pen.Color:= LineColors.DataColor;
           Canvas.PolyLine([Point(CellRect(i,0).Right, StartY),
                        Point(CellRect(i,0).Right, EndY)]);
        end
        else begin
//           Canvas.Pen.Color:= clBtnShadow;
           Canvas.Pen.Color:= LineColors.ShadowColor;
           Canvas.PolyLine([Point(CellRect(i,0).Right+bidioffset, StartY),
                        Point(CellRect(i,0).Right+bidioffset, EndY)]);
//           Canvas.Pen.Color:= clBtnHighlight;
           Canvas.Pen.Color:= LineColors.HighlightColor;
           Canvas.PolyLine([Point(CellRect(i,0).Right+1-bidioffset, StartY),
                        Point(CellRect(i,0).Right+1-bidioffset, EndY)]);
        end
   end;

 begin
   if (dgColLines in Options) then begin

     for i:= LeftCol to LeftCol+VisibleColCount do
     begin
        if i>=ColCount then continue; // 5/21/01 - Fixes problem with 1 column grid
        if dgTitles in Options then
        begin
           DrawVertLine(CellRect(i, 0).bottom, Bottom+1)
        end
        else DrawVertLine(0, Bottom+1);

        //  6/10/01-if Column width greater than grid width then need to skip reamainder of line drawing
        // Fixes problem with long field
        if CellRect(i, 0).Left + ColWidths[i]>ClientWidth then break;
     end;
   end;
 end;

 function IsCustomLineDrawing: boolean;
 var TempCol, TempRow: integer;
 begin
    result:= false;
    for TempRow:= 0 to VisibleRowCount-1 do
    begin
      for TempCol:= 0 to ColCount-1 do
      begin
         if (Columns[TempCol].ColumnFlags<>nil) and
            (TempRow<256) and
            (Columns[TempCol].ColumnFlags[TempRow]<>0) then
         begin
            result:=True;
            exit;
         end
      end
    end
 end;

begin
   CalcDrawInfo(DrawInfo);
   IsWhiteBackground:= (ColorToRGB(Color)=clWhite);
   if PaintOptions.HaveBackgroundForDataCells then IsWhiteBackground:=True;

   if UseRightToLeftAlignment then bidioffset:= 1
   else bidioffset:= 0;
//   bidioffset:=0;

   //Determine Height Of Titles
   titleheight := CellRect(0, 0).bottom;
   if titleheight = 0 then
      titleheight := DrawInfo.vert.FixedBoundary-1;

   //Determine the far right column.
   right := ClientWidth;
   //Set right to the last visible cell if at end of the grid.
   if PadColumnStyle <> pcsPadHeader then
      if DrawInfo.Horz.LastFullVisibleCell = ColCount-1 then
         right := CellRect(ColCount-1,0).Right;

   //Determine bottom of the grid (not including footer).
   // 7/16/02 - Previously receiving one extra set of vertical lines if
   //           only 1 row of data with dgTitles=false
   bottom :=  CellRect(0, wwMax(0, VisibleRowCount+TitleOffset-1)).Bottom;
   if bottom = 0 then
      bottom := DrawInfo.Vert.GridBoundary;

   //Draw all of the vertical Grid cell lines.
   if not HideAllLines then
      DrawVertLines;
   //Draw the bottom horizontal grid line for the active cell
   if (not HideAllLines) and (dataLink<>nil) and ( datalink.active) and
      (dgRowLines in Options) and not (dgRowSelect in Options) then begin
     ARect:= CellRect(Col, Row);
     currowheight := ARect.Bottom;
     if (LineStyle = glsSingle) or
        ((LineStyle = glsDynamic) and
          (TwwCacheColInfoItem(FCacheColInfo[Col]).IsWhiteBackground)) then
        Canvas.Pen.Color:= LineColors.DataColor
     else
        Canvas.Pen.Color:= LineColors.ShadowColor; //clBtnShadow;
     Canvas.PolyLine([Point(ARect.Left, currowheight),Point(ARect.Right, currowheight)]);
   end;

   if (not HideAllLines) and (dataLink<>nil) and ( datalink.active) and
      (fixedcols > 0) then
   begin
      CustomLineDrawing:= IsCustomLineDrawing;

      // Draw 3D - horizontal line for fixed columns
//      if (not ThemeServices.ThemesEnabled) and (not (dgRowLinesDisableFixed in Options) or (dgTitles in Options)) then
      if (not UseThemesInTitle) and (not (dgRowLinesDisableFixed in Options) or (dgTitles in Options)) then
      begin
        for i:= 0 to VisibleRowCount do begin
          if (dgRowLinesDisableFixed in Options) and
             (i<VisibleRowCount) then continue;  // Draw for only 1st row

          TempBottom:= inherited CellRect(0, i).Bottom;
          Canvas.Pen.Color:= LineColors.FixedColor;
          TempLeft:= CellRect(fixedcols-1,0).Right+1; // 3/10/01 - Tweak as not far enough to the right before
          TempLeft2:= TempLeft;
          if (dgRowLinesDisableFixed in Options) then
          begin
             TempLeft:= Right;
             TempLeft2:= TempLeft;
          end;

          if CustomLineDrawing then
          begin
            Canvas.Pen.Color:= LineColors.HighlightColor;
            if (i<VisibleRowCount) or (PadColumnStyle=pcsPadHeaderAndData) then
            begin
              for TempCol:= 0 to FixedCols-1 do
              begin
                 if (i<TitleOffset) or (TempCol<FIndicatorOffset) or
                    ((Columns[TempCol-FIndicatorOffset].ColumnFlags[i-FTitleOffset] and wwDisableDrawBottomLine)=0) then
                 begin
                    StartX:= 0;
                    if TempCol>=FIndicatorOffset then
                       StartX:= CellRect(TempCol, i).Left;
                    EndX:= CellRect(TempCol, i).Right;

                    Canvas.Pen.Color:= LineColors.FixedColor;
                    if (i>=TitleOffset) and not (dgHideBottomDataLine in Options) then
                      if (TitleOffset>0) or (i<VisibleRowCount) then
                         Canvas.PolyLine([Point(StartX, TempBottom),
                              Point(EndX, TempBottom)]);

                    Canvas.Pen.Color:= LineColors.HighlightColor;

                    if (i<VisibleRowCount) or (PadColumnStyle=pcsPadHeaderAndData) then
                       Canvas.PolyLine([Point(StartX, TempBottom+1),
                             Point(EndX, TempBottom+1)]);

                 end
              end
            end
          end
          else begin
             if (i>=TitleOffset) then // 7/16/02 - Missing 1st column fixed col horizontal line before
             begin
                if not (dgHideBottomDataLine in Options) then
                begin
                  if (TitleOffset>0) or (i<VisibleRowCount) then // 7/16/02
                    Canvas.PolyLine([Point(0, TempBottom),
                                Point(TempLeft, TempBottom)])
                end
             end;

             Canvas.Pen.Color:= LineColors.HighlightColor;
             if (i<VisibleRowCount) or (PadColumnStyle=pcsPadHeaderAndData) then
                Canvas.PolyLine([Point(0, TempBottom+1),
                           Point(TempLeft2, TempBottom+1)]);
          end
        end;
      end;

      // Draw 3D - Vertical line in fixed area
      for i:= 0 to FixedCols-1 do begin
         if (dgColLinesDisableFixed in Options) then continue;
//         if (ThemeServices.ThemesEnabled) then continue;

        Canvas.Pen.Color:= LineColors.FixedColor;
        TempX:= CellRect(i,0).Right;
        if not (dgColLines in Options) then TempX:= TempX -1;
        if dgRowLines in Options then
           TempY:= GetGridDataBottom(DrawInfo)-1
        else
           TempY:= GetGridDataBottom(DrawInfo);
        Canvas.PolyLine([Point(TempX+bidioffset, 0),
                         Point(TempX+bidioffset, TempY)]);
        Canvas.Pen.Color:= LineColors.HighlightColor;
        Canvas.PolyLine([Point(TempX+1-bidioffset, 0),
                         Point(TempX+1-bidioffset, TempY)]);
        if (i=0) and (dgIndicator in Options) then
        begin
          Canvas.Pen.Color:= LineColors.HighlightColor;
          TempLeft:= CellRect(i,0).Left;
          Canvas.PolyLine([Point(TempLeft-bidioffset, 0),
                         Point(TempLeft-bidioffset, TempY)]);
        end
      end;

   end;

   if (dgTitles in Options) and (not HideAllLines) then
   begin

       for i:= 0 to LeftCol+VisibleColCount do begin
         if i>=ColCount then continue; // 5/22/01
         if UseThemesInTitle and (i>=FIndicatorOffset) then continue;
         if (i>=FixedCols) and (i<LeftCol) then continue;

         TempLeft:= CellRect(i,0).Left;
         if (TempLeft=0) and
            (i>LeftCol) then continue; // Special border case where inherited CellRect is wrong.
         TempBottom:= TitleHeight;

         if not (HaveAnyRowLines) then TempBottom:= TempBottom - 1;

         TempX:= CellRect(i,0).Right;
         if not (dgColLines in Options) then TempX:= TempX -1;

         Canvas.Pen.Color:= LineColors.HighlightColor;
         Canvas.PolyLine([Point(TempLeft+bidioffset, 0),
                         Point(CellRect(i,0).Right, 0)]);

         TempTop:=0;
         if (dbCol(i)>=1) and
            (Columns[dbcol(i)].GroupName = Columns[dbcol(i-1)].GroupName) and
            (TitleCellRect(i, 0).Top<>0) and
            (TitleCellRect(i-1, 0).Top<>0) then
         begin
            tempTop:= TitleCellRect(i, 0).Top;
         end;

         Canvas.Pen.Color:= LineColors.HighlightColor;
         Canvas.PolyLine([Point(TempLeft-bidioffset, tempTop),
                          Point(TempLeft-bidioffset, tempbottom)]);
////***
         //Paint Title Group Headings and SubHeading Lines.
         FldName:= FieldName(i);
         GroupName:= '';
         if FldName<>'' then
            GroupName:=ColumnByName(FldName).GroupName;

         if GroupName<>'' then
         begin
            TempTop:=0;
            if (dbCol(i)>=0) and
               (TitleCellRect(i, 0).Top<>0) then
            begin
               tempTop:= TitleCellRect(i, 0).Top;
            end;
            curGroupName := GroupName;

            FldName:= FieldName(i+1);  // Next field
            GroupName:= '';
            if FldName<>'' then
               GroupName:=ColumnByName(FldName).GroupName;

            if (GroupName=curGroupName) then
               GroupOffset:=1
            else GroupOffset:=0;
            Canvas.PolyLine([Point(TempLeft, 0),
                       Point(CellRect(i,0).Right+GroupOffset, 0)]);
            Canvas.PolyLine([Point(TempLeft, TempTop), Point(CellRect(i,0).Right+GroupOffset, TempTop)]);
            Canvas.Pen.Color:= LineColors.FixedColor;
            Canvas.PolyLine([Point(TempLeft, TempTop-1), Point(CellRect(i,0).Right+GroupOffset, TempTop-1)]);
         end;
         TempTop:=0;
         if (i<ColCount-1) and (CurGroupName=GroupName) and
            (TitleCellRect(i, 0).Top<>0) and
            (TitleCellRect(i+1, 0).Top<>0) then
         begin
            tempTop:= TitleCellRect(i, 0).Top;
         end;
         Canvas.Pen.Color:= LineColors.FixedColor;
         Canvas.PolyLine([Point(TempX+bidiOffset, tempTop),
                          Point(TempX+bidiOffset, tempBottom)]);
//         Canvas.PolyLine([Point(TempX, tempTop),
//                          Point(TempX, tempBottom)]);
         if (i=ColCount-1) then
         begin
            if (PadColumnStyle in [pcsPadHeaderAndData, pcsPadHeader]) or (PaintOptions.HaveBackgroundForDataCells) then begin
              Canvas.Pen.Color:= LineColors.HighlightColor;
              Canvas.PolyLine([Point(TempX+bidioffset, 0), Point(ClientWidth, 0)]);
            end;

            Canvas.Pen.Color:= clBlack;
            Canvas.Pen.Color:= LineColors.FixedColor;
            if (PadColumnStyle in [pcsPadHeader]) then
               Canvas.PolyLine([Point(tempX, tempbottom),
                               Point(ClientWidth, tempBottom)]);
         end;


         Canvas.Pen.Color:= LineColors.FixedColor;
         Canvas.PolyLine([Point(CellRect(i,0).Left-1, tempBottom),
                         Point(CellRect(i,0).Right, tempBottom)]);
         if TitleButtons then
         begin
//            Canvas.Pen.Color:= clBtnShadow;
            Canvas.Pen.Color:= LineColors.ShadowColor;
            if i<= DrawInfo.Horz.lastfullvisiblecell then // not last visible column
            begin
               if (TitleClickColumn<0) or (SkipTitleButtonClick and (i<>TitleClickColumn)) then
               begin
                  Canvas.PolyLine([Point(TempX-1+bidioffset, tempTop),
                                   Point(TempX-1+bidioffset, tempBottom)]);
               end;
            end;
            Canvas.PolyLine([Point(CellRect(i,0).Left-1, tempBottom-1),
                         Point(CellRect(i,0).Right, tempBottom-1)]);
         end;

       end;

   end;

   if (dataLink=nil) or (not datalink.active) then exit;

   // Draw OutsideGrid edges when either dgRowLines or dgColLines is not in Options.

   if (not HideAllLines) and (DrawInfo.Horz.LastFullVisibleCell = ColCount-1) then
   begin
      Canvas.Pen.Color:= LineColors.FixedColor;
      if (not (dgRowLines in Options)) or (not (dgColLines in Options)) then
         Canvas.PolyLine([Point(Right,0), Point(Right, TitleHeight)]);
      if PadColumnStyle <> pcsPadHeaderAndData then
        if isWhiteBackground then
           Canvas.Pen.Color:= LineColors.DataColor
        else
           Canvas.Pen.Color:= LineColors.ShadowColor; //clBtnShadow;

      tempTop:= TitleHeight;
      if not (HaveAnyRowLines) then tempTop:= tempTop - 1;
      if (PadColumnStyle<>pcsPlain) and
//      if (PadColumnStyle=pcsPadHeaderAndData) and
         ((not (dgRowLines in Options)) or (not (dgColLines in Options))) then
      begin
         Canvas.PolyLine([Point(Right,TempTop+1), Point(Right, Bottom)]);
//         Canvas.pen.color:= clBtnHighlight;
         Canvas.Pen.Color:= LineColors.HighlightColor;
         Canvas.PolyLine([Point(Right+1,0), Point(Right+1, Bottom)])
      end;
   end;

   PaintClickedTitleButton;

   // Draw area below data
   if (PadColumnStyle=pcsPadHeaderAndData) or (PaintOptions.HaveBackgroundForDataCells) {or
     (dgIndicator in Options) }then begin
       r.Bottom:= ClientHeight;
       r.Left := 0;
       r.Top:= GetGridDataBottom(DrawInfo);
       if (PadColumnStyle=pcsPadHeaderAndData) or (PaintOptions.HaveBackgroundForDataCells) then
          r.Right := ClientWidth
       else
          r.Right:= CellRect(LeftCol,0).Left;

       if RecordCountIsValid and (FDataLink.RecordCount>0) and
          ((FDataLink.RecordCount-RowOffset-1+TitleOffset)<DrawInfo.Vert.LastFullVisibleCell) then
          r.top:= inherited cellrect(0,fdatalink.recordcount-rowoffset+TitleOffset).top;
       // Draw horizontal separator line above footer or empty bottom area
       Canvas.Pen.Color:= LineColors.FixedColor;
       if not HideAllLines then
         Canvas.PolyLine([Point(r.left, r.top-1),
                         Point(CellRect(LeftCol, 0).Left, r.top-1)]);
       if isWhiteBackground then
          Canvas.Pen.Color:= LineColors.DataColor
       else
          Canvas.Pen.Color:= LineColors.ShadowColor; //clBtnShadow;

       if not HideAllLines then
          Canvas.PolyLine([ Point(CellRect(LeftCol, 0).Left, r.top-1),
                         Point(Right, r.top-1)]);

       Canvas.Pen.Color:= LineColors.HighlightColor;
       //Draw Left Pad Line
       if not HideAllLines then
       begin
          Canvas.PolyLine([Point(r.left, r.top),
                        Point(r.Left, ClientHeight-1)]);
          //Draw Bottom of Grid Pad Line
          Canvas.PolyLine([Point(r.left, r.top),
                        Point(right, r.top)]);
       end;

       if not HideAllLines then r.top:= r.top + 1;
       r.left := r.left+1;
       if PadColumnStyle=pcsPadHeaderandData then
          FillWithFixedBitmap(r, -1, TitleColor)
   end;
end;

procedure TwwCustomDBGrid.WMPaint(var Message: TWMPaint);
var
    DC, MemDC: HDC;
    MemBitmap, OldBitmap: HBITMAP;
    PS: TPaintStruct;
    PaintCliprect: TRect;
    r: TRect;
    customEdit: TWinControl;
    BitmapEmpty: boolean;
begin
  windows.GetUpdateRect(Handle, UpdateRect, false);
  if not UseAlternateBuffering then
  begin
     if csPaintCopy in ControlState then
     begin
        BitmapEmpty:= FPaintBitmap.Empty;
        inherited;
        if BitmapEmpty then
        begin
          FPaintBitmap.Free;
          FPaintBitmap:=nil;
          FPaintBitmap:= TBitmap.create;
          FPaintCanvas:= FPaintBitmap.Canvas;
        end;
     end
     else inherited;
     exit;
  end;

  PaintClipRect:= (inherited Canvas).ClipRect;

  if HaveAnyRowLines then updaterect.top:= updaterect.top-1;  // 3/18/2002 - Make sure top line is drawn.

  if PaintClipRect.Right>ClientRect.Right then
     PaintClipRect.Right:= ClientRect.Right;
  if UpdateRect.Bottom>ClientRect.Bottom then
     UpdateRect.Bottom:= (inherited GetClientRect).Bottom;

  if (UpdateRect.Top=0) and (UpdateRect.Bottom=0) and
     (UpdateRect.Left=0) and (UpdateRect.Right=0) then
     UpdateRect:= PaintClipRect;
//  UpdateRect:= (inherited GetclientRect);
{  if UpdateRect.Bottom>PaintClipRect.Bottom then
     UpdateRect.Bottom:= PaintClipRect.Bottom;
  if UpdateRect.Right>PaintClipRect.Right then
     UpdateRect.Right:= PaintClipRect.Right;
}
//  UpdateRect:= PaintClipRect;

  if (Message.DC <> 0) then
  begin
    if not (csCustomPaint in ControlState) and (ControlCount = 0) then
      inherited
    else
      PaintHandler(Message);
  end
  else begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, inherited GetClientRect.Bottom);
    ReleaseDC(0, DC);

    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      Message.DC := MemDC;
      if not (csCustomPaint in ControlState) and (ControlCount = 0) then
        inherited
      else
        PaintHandler(Message);
      Message.DC := 0;

      // Remove custom control from painting
      r:= CellRect(Col,Row);
      r.Left:= r.Left + 1; { Used to be +2, but richedit gray line would show after resizing }
      if FFocused and IsCustomEditCell(Col, Row, customEdit) and
         (not IsDropDownGridFocused) and
         (ShouldShowCustomControls) then
         BitBlt(MemDC, r.Left, r.top, r.Right-r.Left, r.Bottom-r.Top,
               (inherited Canvas).handle, r.left, r.top, SRCCOPY);

      // Leave current screen intact in pop-up grid area
      if not (csDesigning in ComponentState) and IsDropDownGridShowing then
      begin
         with TwwExpandButton(CurrentCustomEdit) do
         begin
            r:= Rect(Grid.Left, Grid.Top, Grid.Left + Grid.Width, Grid.Top+Grid.Height);

//            FPaintCanvas.CopyRect(r, inherited Canvas, r);

            BitBlt(MemDC, r.Left, r.top, r.Right-r.Left, r.Bottom-r.Top,
               (inherited Canvas).handle, r.left, r.top, SRCCOPY);
         end
      end;

      BitBlt(DC, UpdateRect.Left, UpdateRect.Top, UpdateRect.Right-UpdateRect.Left,
                 UpdateRect.Bottom-UpdateRect.Top, MemDC, UpdateRect.Left, UpdateRect.top, SRCCOPY);
      EndPaint(Handle, PS);

    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;

(*
procedure TwwCustomDBGrid.WMPaint(var Message: TWMPaint);
var
    DC, MemDC: HDC;
    MemBitmap, OldBitmap: HBITMAP;
    PS: TPaintStruct;
    PaintCliprect: TRect;
begin
  windows.GetUpdateRect(Handle, UpdateRect, false);
  if not UseAlternateBuffering then
  begin
     inherited;
     exit;
  end;

  PaintClipRect:= (inherited Canvas).ClipRect;
  if PaintClipRect.Right>ClientRect.Right then
     PaintClipRect.Right:= ClientRect.Right;
  if UpdateRect.Bottom>ClientRect.Bottom then
     UpdateRect.Bottom:= (inherited GetClientRect).Bottom;

  if (UpdateRect.Top=0) and (UpdateRect.Bottom=0) and
     (UpdateRect.Left=0) and (UpdateRect.Right=0) then
     UpdateRect:= PaintClipRect;

  if (Message.DC <> 0) then
  begin
    if not (csCustomPaint in ControlState) and (ControlCount = 0) then
      inherited
    else
      PaintHandler(Message);
  end
  else begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, inherited GetClientRect.Bottom);
    ReleaseDC(0, DC);

    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      Message.DC := MemDC;
      if not (csCustomPaint in ControlState) and (ControlCount = 0) then
        inherited
      else
        PaintHandler(Message);
      Message.DC := 0;
//      BitBlt(DC, 0, 0, ClientRect.Right, ClientRect.Bottom, MemDC, 0, 0, SRCCOPY);
      BitBlt(DC, UpdateRect.Left, UpdateRect.Top, UpdateRect.Right, UpdateRect.Bottom, MemDC, UpdateRect.Left, UpdateRect.top, SRCCOPY);
      EndPaint(Handle, PS);

    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;
*)

Function TwwCustomDBGrid.XIndicatorOffset: integer;
begin
   if dgIndicator in Options then result:= 1
   else result:= 0;
end;

procedure TwwCustomDBGrid.SetIndicatorColor(Value: TIndicatorColorType);
begin
    if Value = icYellow then
       IndicatorIconColor:= clYellow
    else
       IndicatorIconColor:= clBlack
end;


function TwwCustomDBGrid.GetCalcCellRow: integer;
begin
   result:= FCalcCellRow;
end;

function TwwCustomDBGrid.TitleCellRect(ACol, ARow: Longint): TRect;
var fldName: string;
begin
    result:= CellRect(ACol, ARow);
    // Need to have rectangle be consistent, even if on right edge
    result.right:= result.left + ColWidths[ACol];

    if dbCol(ACol)<0 then exit;

    // Need to take into account no fields, so need another way to find
    // fieldname
    fldName:= FieldName(ACol);
    if (fldName<>'') and
       (ColumnByName(fldName).GroupName<>'') then
    begin
        result.top:= (result.bottom-result.top) div 2;
    end;
end;

function TwwCustomDBGrid.AdjustBoundsRect(ACurrentCustomEdit: TWinControl): boolean;
begin
//!!!!   result:= wwIsClass(ACurrentCustomEdit.classType, 'TwwDataInspector');
   result:= False;
end;

Procedure TwwCustomDBGrid.PaintActiveRowBackground(ACanvas: TCAnvas; ARect: TRect);
var SourceRect: TRect;
begin
   SourceRect:= CellRect(Col, Row);
   SourceRect.Right:= SourceRect.Left + ARect.Right-ARect.Left;
   SourceRect.Bottom:= SourceRect.Top + ARect.Bottom-ARect.Top;
   if (PaintOptions.AlternatingRowColor<>clNone) and
      (dbRow(Row)>=0) and
      (Odd(dbRow(Row)) xor AlternatingEven) and
      ((Col<FixedCols) and (arrFixedColumns in PaintOptions.AlternatingRowRegions) or
       (Col>=FixedCols) and (arrDataColumns in PaintOptions.AlternatingRowRegions)) then
   begin
      if PaintOptions.AlternatingColorBitmap<>nil then
         ACanvas.CopyRect(ARect,PaintOptions.AlternatingColorBitmap.canvas,SourceRect)
//         ACanvas.CopyRect(ARect,PaintOptions.AlternatingColorBitmap.canvas,ARect)
      else begin
         ACanvas.Brush.Color:= PaintOptions.AlternatingRowColor;
         ACanvas.FillRect(ARect);
      end
   end
   else if PaintOptions.HaveBackgroundForDataCells then
   begin
//      SourceRect.Right:= SourceRect.Left + ARect.Right-ARect.Left;
//      SourceRect.Bottom:= SourceRect.Top + ARect.Bottom-ARect.Top;
      ACanvas.CopyRect(ARect,PaintOptions.OrigBitmap.canvas,SourceRect);
//      ACanvas.CopyRect(SourceRect,PaintOptions.OrigBitmap.canvas,SourceRect);
   end
   else begin // 8/15/02 - Paint non-alternating active record
      if PaintOptions.ActiveRecordColor<>clNone then
         ACanvas.Brush.Color:= PaintOptions.ActiveRecordColor
      else
         ACanvas.Brush.Color:= Color;
      ACanvas.FillRect(ARect);
   end;
end;

procedure TwwInplaceEdit.BoundsChanged;
var
  R: TRect;
  TopOffset, LeftOffset: integer;
  EditWidth: integer;
begin
{  if dgRowLines in ParentGrid.Options then inherited
  else }begin
    { Inplaceeditor is not correct position }
     if not (dgRowLinesDisableFixed in ParentGrid.Options) then
        TopOffset:=0
     else TopOffset:=1;

     EditWidth:= Width;
     if ParentGrid.Col<ParentGrid.LeftCol then
     begin
       if (dgColLinesDisableFixed in ParentGrid.Options) then
          LeftOffset:=1
       else begin
          LeftOffset:=0;
          if dgColLines in ParentGrid.Options then
             EditWidth:= EditWidth - 1
          else
             EditWidth:= EditWidth - 2
       end
     end
     else if dgColLines in ParentGrid.Options then
     begin
        LeftOffset:= 1;
        EditWidth:= EditWidth;
     end
     else
      LeftOffset:=1;

//     if TwwCustomDBGrid(Owner).UseRightToLeftAlignment then
       SetWindowPos(Handle, HWND_TOP, Left+1-LeftOffset, Top,
            EditWidth, Height,
            SWP_SHOWWINDOW or SWP_NOREDRAW);
//     else
//       SetWindowPos(Handle, HWND_TOP, Left+1-LeftOffset, Top,
//          EditWidth, Height,
//          SWP_SHOWWINDOW or SWP_NOREDRAW);
     R := Rect(1, 2-TopOffset, Width - 2, Height);

     SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
     SendMessage(Handle, EM_SCROLLCARET, 0, 0);
  end
end;

procedure TwwCustomDBGrid.CalcSizingState(X, Y: Integer; var State: TGridState;
      var Index: Longint; var SizingPos, SizingOfs: Integer;
      var FixedInfo: TGridDrawInfo);
var gc:TGridcoord;
    startcol, endcol: integer;
//    accept:boolean;
begin
  State:= gsNormal;

  if UseRightToLeftalignment then
    gc := MouseCoord(x+5,y) // add 5 so gc.x is always previous column
  else
    gc := MouseCoord(x-5,y); // subtract 5 so gc.x is always previous column

  // Don't show sub-group sizing in group title
  if (dgTitles in Options) and (gc.y=0) then
  begin
     // Get group range, and must not be in middle columns
     GroupNameCellRect(gc.x,0,StartCol,EndCol, False);
     if (gc.x>=FIndicatorOffset) and
        (Columns[dbCol(gc.x)].GroupName<>'') then
     begin
        if useRightToLeftAlignment then
        begin
          if (gc.x<EndCol) and (gc.x>=StartCol) and
             (y < TitleCellRect(gc.x,gc.y).Top)  then exit;
        end
        else begin
          if (gc.x<EndCol) and (gc.x>=StartCol) and
             (y < TitleCellRect(gc.x,gc.y).Top)  then exit;
        end;
     end;
  end;

  // Don't show sub-group sizing in group title
  if (IsProportionalColumns) and (gc.Y<FTitleOffset) and
     ((gc.x=ColCount-1) or (gc.x<0)) then exit;

  {// !!!! - Uncomment to allow onAllowColResize event.
  if (Assigned(FOnAllowColResize)) then begin
    try
       accept := true;
       FOnAllowColResize(Self, gc.x, accept);
       if not accept then exit;
    except
       exit;
    end;
  end;
  }

  inherited;
end;

Function TwwCustomDBGrid.HaveAnyRowLines;
begin
   result:= (dgRowLines in Options) or
       not (dgRowLinesDisableFixed in Options);
end;

procedure TwwCustomDBGrid.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  if parent is TCustomGrid then
  begin
//    Params.Style := WS_POPUP or WS_BORDER;
//    Params.ExStyle := WS_EX_TOOLWINDOW;
//     Params.Style:= Params.Style + WS_POPUP;
//     Params.ExStyle := WS_EX_TOOLWINDOW;
//     Params.Style:= Params.Style + WS_EX_TOOLWINDOW
  end;

end;

procedure TwwCustomDBGrid.CMCancelMode(var Message: TCMCancelMode);
begin
   inherited;
end;

// Returns just rectangle for control.  Do not return whole rectangle, as
// we wish to leave this area unpainted when record is expanded.
Function TwwCustomDBGrid.CellRect(ACol, ARow: integer): TRect;
begin
   result:= inherited CellRect(ACol, ARow);
   // Empty rectangle so don't modify
   if result.left+result.right+result.top+result.bottom=0 then exit;

   // 4/9/01 - Need to have rectangle be consistent, even if on right edge
   result.right:= result.left + ColWidths[ACol];

   if dbRow(ARow)<0 then exit;

   result.Bottom:= result.Top + DefaultRowHeight;
end;

Function TwwCustomDBGrid.IsDropDownGridFocused: boolean;
var Control: TWinControl;
begin
   result:= IsDropDownGridShowing;
   if result then
   begin
      Control:= TwwExpandButton(CurrentCustomEdit).Grid;
      if Control is TwwDBGrid then
      begin
         if not TwwDBGrid(Control).FFocused then result:= false
      end
      else begin
         result:= (Control<>nil) and (Control.HandleAllocated) and
                  (IsChild(Control.Handle, GetFocus) or
                  // 7/25/02 - Return true if control (i.e. inspector) has focus
                  // Fixes bug where drop-down inspector would close-up in some cases
                  // when arrowing at last or first
                   (Control.Handle=GetFocus))
       end;
   end
end;

Function TwwCustomDBGrid.IsDropDownGridShowing: boolean;
begin
   result:= False;
   if (CurrentCustomEdit=nil) then exit;
   if not (CurrentCustomEdit is TwwExpandButton) then exit;
   if TwwExpandButton(CurrentCustomEdit).Grid=nil then exit;
//   if not FFocused then exit; { child grid can show even when we don't have focus }
   result:= TwwExpandButton(CurrentCustomEdit).Grid.visible;
end;

Function TwwCustomDBGrid.ActiveExpandButton: TWinControl;
begin
   result:= nil;
   if (CurrentCustomEdit=nil) then exit;
   if not (CurrentCustomEdit is TwwExpandButton) then exit;
   result:= CurrentCustomEdit;
end;

procedure TwwCustomDBGrid.CollapseChildGrid;
var i: Integer;
    expandButton: TwwExpandButton;
begin
     for i:= 0 to ControlCount-1 do begin
        if (Controls[i] is TwwExpandButton) then
        begin
            expandButton:= TwwExpandButton(Controls[i]);
            if ExpandButton.InToggle then exit;

            if (expandbutton.grid<>nil) and
               (expandButton.Grid.visible) then
            begin
               // 5/9/2002 - PYW - Need to handle exception or hook raises it and it closes form.
               try
                 if ExpandButton.Expanded then begin
                   ExpandButton.Expanded:= False;
                 end
                 else begin
                   ExpandButton.Expanded:= False;
                   ExpandButton.Click;  // Force our code to execute for expand/collapse
                 end;
                 break;
               except
               end;
            end
        end
     end;
end;


// Updates CurrentCustomEdit manually
// This prevents flicker when calling from MouseDown so that
// we don't paint expand button before moving to the child grid.
procedure TwwCustomDBGrid.UpdateCustomEdit;
var customEdit: TWinControl;
    OrigRect, TempRect: TRect;
begin
   if isCustomEditCell(Col, Row, customEdit) and
     (ShouldShowCustomControls or (customEdit is TwwExpandButton)) then
//   (not (ecoDisableCustomControls in EditControlOptions)) and
//      (canEditGrid or AlwaysShowControls) and
//      not (csDesigning in ComponentState) and
//      not (dgRowSelect in Options) then
   begin
      currentCustomEdit:= customEdit;
      with Canvas do begin
         if (not (csDesigning in ComponentState)) then
         begin
            if (currentCustomEdit<>Nil) and (currentCustomEdit.parent=self) then
            begin
               TempRect:= CellRect(Col, Row);
               OrigRect:= TempRect;
               if
                  // 5/18/01 - Top check required as we are left/right already accurate from ColEnter updating
                  (currentCustomEdit.BoundsRect.Top<>TempRect.Top) or
                  (currentCustomEdit.BoundsRect.left<>TempRect.Left) or
                  (currentCustomEdit.BoundsRect.right<>TempRect.right) then
               begin
                  if Columns[dbCol(Col)].DisableSizing then
                  begin
                     if TempRect.Right-TempRect.Left<currentCustomEdit.Width then
                       TempRect.Right:= TempRect.Left + currentCustomEdit.Width;
                     if TempRect.Bottom-TempRect.Top<currentCustomEdit.Height then
                       TempRect.Bottom:= TempRect.Top + currentCustomEdit.Height;
                     if tempRect.Top+ currentcustomEdit.height>Parent.ClientHeight then
                     begin
                        tempRect.Top:= OrigRect.Bottom-currentCustomedit.Height;
                        tempRect.Bottom:= OrigRect.Bottom;
                     end;
                  end;

                  if (Canvas.CanvasOrientation = coRightToLeft) then { 9/25/98 - Support bidi mode }
                  begin
                     TempRect.Right := ClientWidth - TempRect.Left;
                     TempRect.Left := tempRect.Right - (TempRect.Right-TempRect.Left) + 1;
                  end;

                  currentCustomEdit.BoundsRect:= TempRect;
               end
            end
         end;
      end;
   end;
end;

function TwwCustomDBGrid.IsActiveRowAlternatingColor: boolean;
begin
   if AlternatingEven then
   begin
      result:= not odd(dbRow(Row))
   end
   else begin
      result:= odd(dbRow(Row))
   end;
end;

procedure TwwCustomDBGrid.SetRowOffset(value: integer);
begin
//   FRowOffset:= Value;
//   if odd(FRowOffset) then AlternatingEven:= not AlternatingEven
   if (odd(Value) and (not odd(FRowOffset))) or
      (not odd(Value) and (odd(FRowOffset))) then
      AlternatingEven:= not AlternatingEven;
   FRowOffset:= Value;
//      Showmessage('Exception');
end;

procedure TwwCustomDBGrid.CalcDrawInfo(var DrawInfo: TGridDrawInfo);
begin
   inherited CalcDrawInfo(DrawInfo);
//   DrawInfo.Vert.FullVisBoundary:= CellRect(0, DrawInfo.Vert.LastFullVisibleCell).Bottom + 1;
   if (RowOffset>0) then
   begin
//      DrawInfo.Vert.LastFullVisibleCell:=
//         FDataLink.RecordCount-DataLink.ActiveRecord-1;
//           FDataLink.RecordCount - RowOffset -1;
//      DrawInfo.Vert.FullVisBoundary:= CellRect(0, DrawInfo.Vert.LastFullVisibleCell).Bottom + 1;
   end;


end;

function TwwCustomDBGrid.HasFocus: boolean;  // Return true if we or a child of us has the focus;
begin
    result:= FFocused;
end;

procedure TwwCustomDBGrid.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
end;

function TwwCustomDBGrid.GroupNameCellRect(ACol, ARow: Longint; var StartCol, EndCol: LongInt; VisibleOnly: boolean = True): TRect;
var
//    ACursor : TPoint;
    GroupLeft,GroupRight:Integer;
    i:integer;
    startindex, lastindex: integer;
    GroupName: string;
    LineWidth: integer;
begin
   result:= CellRect(ACol, 0);
   StartCol:=ACol;
   EndCol := ACol;
   if dbCol(ACol)<0 then exit;

   GroupName:= Columns[dbCol(ACol)].GroupName;

   if GroupName<>'' then
   begin

      //Only go as far as the Left Visible Column.
      if VisibleOnly then
      begin
         startIndex:= LeftCol;
         lastIndex:= LeftCol + VisibleColCount;
      end
      else begin
         startIndex:=FIndicatorOffset;
         lastIndex:= ColCount-1;
      end;

      StartCol:= ACol;
      for i:= ACol-1 downto startIndex do begin
         if Columns[dbCol(i)].GroupName=GroupName then
            startCol:= i
         else break;
      end;
      EndCol:= ACol;
      for i:= ACol+1 to lastIndex do begin
         if Columns[dbCol(i)].GroupName=GroupName then
            EndCol:= i
         else break;
      end;

      if dgColLines in Options then LineWidth:=1
      else LineWidth:= 0;

      if StartCol<LeftCol then
      begin
         GroupLeft:= CellRect(LeftCol, 0).Left;
         GroupRight:= GroupLeft;
         for i:= LeftCol-1 downto StartCol do
         begin
            GroupLeft:= GroupLeft - ColWidths[i] - LineWidth;
         end;
         for i:= LeftCol to EndCol do
         begin
            GroupRight:= GroupRight + ColWidths[i] + LineWidth;
         end;

{         GroupRight:= CellRect(EndCol, 0).Right;
         GroupLeft:= GroupRight+LineWidth;
         for i:= EndCol downto StartCol do begin
            GroupLeft:= GroupLeft - ColWidths[i] - LineWidth;
         end;
}
      end
      else begin
         GroupLeft:= CellRect(StartCol, 0).Left;
         GroupRight:= GroupLeft-LineWidth;
         for i:= startCol to EndCol do begin
            GroupRight:= GroupRight + ColWidths[i] + LineWidth;
         end;
      end;
      result := Rect(Groupleft,result.Top,GroupRight,result.Top+((result.bottom-result.top) div 2));
   end;
end;

function TwwCustomDBGrid.DragTitleCellRect(ACol, x, y: Longint): TRect;
var curField: TField;
//    DrawInfo: TGridDrawInfo;
//    curGroupName:String;
    StartCol,EndCol: Integer;
begin
   if not (dgTitles in Options) then begin
      result := Rect(0,0,0,0);
      exit;
   end;

   result:= CellRect(ACol, 0);   //Only concerned about the active column's title.
   if dbCol(ACol)<0 then exit;   //Exit if the current col is < 0

   //Get activefield and the associated groupname to see if the current column being dragged
   //is a subgroup or the grouptitle and returns the effective drag rectangle.
   curField:= Fields[dbCol(ACol)];
   if (curfield<>nil) and
       (ColumnByName(curField.FieldName).GroupName<>'') then
   begin
       if y < result.Top+((result.bottom-result.top) div 2) then begin
          //Clicked on GroupTitle so need to get the effective drag rectangle that contains the entire rectangle.
          result := GroupNameCellRect(ACol,0,StartCol,EndCol, False);  // RSW!
          result.Bottom := CellRect(ACol, 0).Bottom;
       end
       else
          result.top:= (result.bottom-result.top) div 2;
    end;
end;

procedure TwwCustomDBGrid.ShowEditor;
begin
//   if (TwwCacheColInfoItem(FCacheColInfo[Col]).ControlType='URL-Link') and
   if (ecoDisableEditorIfReadonly in EditControlOptions) and
      Columns[Col-FIndicatorOffset].ReadOnly then exit;
   inherited ShowEditor;
end;

(*
procedure TwwCustomDBGrid.TopLeftMoved(const OldTopLeft: TGridCoord);
var DrawInfo: TGridDrawInfo;
begin
  CalcDrawInfo(DrawInfo);
  // Fix case where inherited grid gets confused on fixed columns
  if LeftCol<DrawInfo.Horz.FixedCellCount then
  begin
     LeftCol:= DrawInfo.Horz.FixedCellCount;
     Invalidate;
     sysutils.Abort;
  end;
  inherited;
end;
*)

function TwwCustomDBGrid.CanEditGrid: Boolean;
begin
  result:= (dgEditing in Options) and (not ReadOnly)
end;

procedure TwwCustomDBGrid.ResetTitleClick;
begin
//   MouseOverGroupTitle := False;
   TitleClickGroupTitle := False;
   TitleClickColumn:= -1;
   TitleClickRow:= -1;
end;

Function TwwCustomDBGrid.FieldName(Acol: integer): string;
var APos: integer;
    Field: TField;
begin
   Result:= '';
   if (DataLink<>nil) and (DataLink.Active) then
   begin
      Field := GetColField(dbCol(Acol));
      if (Field = nil) then exit;
      result:= Field.fieldName;
   end
   else begin
      APos:=1;
      if DbCol(ACol)<0 then exit;
      if DBCol(ACol)>=Selected.count then exit;
      result:= strGetToken(Selected[dbCol(ACol)], #9, Apos);
   end;
end;

procedure TwwCustomDBGrid.CMMouseLeave(var Message: TMessage);
begin
  ClearURLPaint;
  if (TitleLastMouseX>=0) and (TitleLastMouseY=0) then
  begin
     InvalidateCell(TitleLastMouseX,TitleLastMouseY);
     if MouseOverGroupTitle then
       InvalidateTitle;
  end;
  TitlelastMouseX:= -1;
  TitlelastMouseY:= -1;

  inherited;
end;

procedure TwwCustomDBGrid.RestoreRowHeights;
begin
   FRowHeightPercent:= MinRowHeightPercent;
   LayoutChanged;
end;

Function TwwCustomDBGrid.IsProportionalColumns: boolean;
begin
   result:= (not usetfields) and (dgProportionalColResize in Options)
end;

procedure TwwCustomDBGrid.SetUseTFields(val: boolean);
begin
   if FUseTFields<>val then
   begin
     FUseTFields:= Val;
     ResetProportionalWidths;
     LayoutChanged;
   end;
end;

procedure TwwCustomDBGrid.GetURLLink(Value: string;
       var URLDisplayString: string; var URLLinkAddress: string);
var apos: integer;
begin
   APos:= 1;
   URLDisplayString:= strGetToken(Value, '#', APos);
   URLLinkAddress:= strGetToken(Value, '#', APos);
   if URLLinkAddress='' then
     URLLinkAddress:= URLDisplayString;
end;

Function TwwCustomDBGrid.ShouldShowCustomControls: boolean;
begin
   result:=
      (not (ecoDisableCustomControls in EditControlOptions)) and
      (canEditGrid or AlwaysShowControls) and
      not (csDesigning in ComponentState) and
      not (dgRowSelect in Options);
end;

procedure TwwCustomDBGrid.ResetProportionalWidths;
begin
  if OrigColWidths<>nil then FreeMem(OrigColWidths);
  OrigColWidths:= nil;
end;

Function TwwCustomDBGrid.GetHighlightColor: TColor;
begin
   if (PaintOptions.ActiveRecordColor<>clNone) then
      result:= PaintOptions.ActiveRecordColor
   else
      result:= clHighlight;
end;

procedure TwwCustomDBGrid.AddField(FieldName: string;
    Position: integer = -1; Redraw: boolean=True);
var APos: integer;
    Found: boolean;
    TempFieldName, TempStr: string;
    curField: TField;
    i: integer;
begin
   if useTfields then begin
      if (datasource<>nil) and (datasource.dataset<>nil) then
      begin
        curField:= datasource.dataset.FindField(FieldName);
        if curfield<>nil then curfield.visible:= true;
      end
   end
   else begin
      found:= false;
      for i:= 0 to selected.count-1 do begin
         APos:=1;
         TempFieldName:= strGetToken(Selected[i], #9, apos);
         if wwEqualStr(TempFieldName, FieldName) then
         begin
//            found:= true;
            exit;
         end;
      end;
      if not found then
      begin
         curField:= nil;
         if (datasource<>nil) and (datasource.dataset<>nil) then
            curField:= datasource.dataset.FindField(FieldName);
         if curField<>nil then
            TempStr:= FieldName + #9 +
                inttostr(curField.DisplayWidth) + #9 + curField.DisplayLabel
         else
            TempStr:= FieldName + #9 + '10' +
                 #9 + FieldName;

         if Position>=0 then
            Selected.Insert(wwMin(Position, Selected.Count), TempStr)
         else
            Selected.add(TempStr);
         if Redraw then ApplySelected;
      end
   end
end;

procedure TwwCustomDBGrid.RemoveField(FieldName: string; Redraw: boolean = True);
var APos: integer;
    TempFieldName: string;
    curField: TField;
    i: integer;
begin
   if useTfields then begin
      if (datasource<>nil) and (datasource.dataset<>nil) then
      begin
         curField:= Datasource.dataset.FindField(FieldName);
         if curfield<>nil then curfield.visible:= false;
      end
   end
   else begin
      for i:= 0 to selected.count-1 do begin
         APos:=1;
         TempFieldName:= strGetToken(Selected[i], #9, apos);
         if wwEqualStr(TempFieldName, FieldName) then
         begin
            Selected.Delete(i);
            if Redraw then ApplySelected;
            exit;
         end
      end;
   end
end;

procedure TwwCustomDBGrid.ApplySelected;
begin
end;

function TwwCustomDBGrid.GetGridDataBottom(DrawInfo: TGridDrawInfo): integer;
var temp: integer;
begin
//   temp := DrawInfo.Vert.FullVisBoundary;
   temp:= inherited CellRect(LeftCol, DrawInfo.Vert.LastFullVisibleCell).Bottom + 1;
   result:= temp;
end;

function TwwCustomDBGrid.CalcCoordFromPoint(X, Y: Integer;
  const DrawInfo: TGridDrawInfo): TGridCoord;

  function DoCalc(const AxisInfo: TGridAxisDrawInfo; N: Integer): Integer;
  var
    I, Start, Stop: Longint;
    Line: Integer;
  begin
    with AxisInfo do
    begin
      if N < FixedBoundary then
      begin
        Start := 0;
        Stop :=  FixedCellCount - 1;
        Line := 0;
      end
      else
      begin
        Start := FirstGridCell;
        Stop := GridCellCount - 1;
        Line := FixedBoundary;
      end;
      Result := -1;
      for I := Start to Stop do
      begin
        Inc(Line, GetExtent(I) + EffectiveLineWidth);
        if N < Line then
        begin
          Result := I;
          Exit;
        end;
      end;
    end;
  end;

  function DoCalcRightToLeft(const AxisInfo: TGridAxisDrawInfo; N: Integer): Integer;
  var
    I, Start, Stop: Longint;
    Line: Integer;
  begin
    N := ClientWidth - N;
    with AxisInfo do
    begin
      if N < FixedBoundary then
      begin
        Start := 0;
        Stop :=  FixedCellCount - 1;
        Line := 0;
//        Line := ClientWidth;
      end
      else
      begin
        Start := FirstGridCell;
        Stop := GridCellCount - 1;
        Line := FixedBoundary;
      end;
      Result := -1;
      for I := Start to Stop do
      begin
        Inc(Line, GetExtent(I) + EffectiveLineWidth);
        if N < Line then
        begin
          Result := I;
          Exit;
        end;
      end;
    end;
  end;

begin
  if not UseRightToLeftAlignment then
    Result.X := DoCalc(DrawInfo.Horz, X)
  else
    Result.X := DoCalcRightToLeft(DrawInfo.Horz, X);
  Result.Y := DoCalc(DrawInfo.Vert, Y);
end;

function TwwCustomDBGrid.MouseCoord(X, Y: Integer): TGridCoord;
var
  DrawInfo: TGridDrawInfo;
begin
  CalcDrawInfo(DrawInfo);
  Result := CalcCoordFromPoint(X, Y, DrawInfo);
  if Result.X < 0 then Result.Y := -1
  else if Result.Y < 0 then Result.X := -1;
end;


function TwwCustomDBGrid.GetPriorRecordText(AFieldname: string; var AText: string): boolean;
var TempRecord: integer;
    TempField: TField;
begin
   result:= false;
   if FDataLink.ActiveRecord<=0 then exit;
   if (DataSource=nil) or (DataSource.DataSet=nil) or
      (not DataSource.DataSet.Active) then exit;

   TempRecord:= FDataLink.ActiveRecord;
   FDataLink.ActiveRecord:= FDataLink.ActiveRecord-1;

   try
     tempField:= DataSource.DataSet.FindField(AFieldName);
     if TempField=nil then exit;

     if TempField<>nil then
     begin
        AText:= TempField.asString;
        result:= True;
     end
   finally
     FDataLink.ActiveRecord:= TempRecord;
   end
end;

function TwwCustomDBGrid.GetNextRecordText(AFieldname: string; var AText: string): boolean;
var TempRecord: integer;
    TempField: TField;
begin
   result:= false;
   if (DataSource=nil) or (DataSource.DataSet=nil) or
      (not DataSource.DataSet.Active) then exit;

   if FDataLink.ActiveRecord<0 then exit;
   if FDataLink.ActiveRecord>=FDataLink.RecordCount then exit;

   TempRecord:= FDataLink.ActiveRecord;
   FDataLink.ActiveRecord:= FDataLink.ActiveRecord+1;

   try
     tempField:= DataSource.DataSet.FindField(AFieldName);
     if TempField=nil then exit;

     if TempField<>nil then
     begin
        AText:= TempField.asString;
        result:= True;
     end
   finally
     FDataLink.ActiveRecord:= TempRecord;
   end;
end;

Procedure TwwCustomDBGrid.AutoSizeColumn(ACol: integer);
var
    i, priorrecord:integer;
    str:String;
    MaxWidth, tempMaxWidth: integer;
begin
     str:='';
     priorrecord := DataLink.ActiveRecord;

     MaxWidth:= 0;
     for i:=0 to VisibleRowCount-1 do
     begin
       DataLink.ActiveRecord := i;
       str:= Datasource.Dataset.fieldbyname(Columns[ACol-FIndicatorOffset].FieldName).DisplayText;
       TempMaxWidth:= Canvas.Textwidth(str);
       if TempMaxWidth>Maxwidth then
           MaxWidth:= TempMaxwidth;
     end;
     MaxWidth:= MaxWidth + 4;

     DataLink.ActiveRecord := priorrecord;
     if MaxWidth>ColWidthsPixels[ACol] then // Growing
     begin
        // Previously already more than max width so ignoer
        if ColWidths[ACol] > (Width div 2) then exit;
        if MaxWidth > (Width div 2) then exit;

        Columns[ACol-FIndicatorOffset].DisplayWidth:= MaxWidth div Canvas.TextWidth('0');
     end
     else begin
        Columns[ACol-FIndicatorOffset].DisplayWidth:= MaxWidth div Canvas.TextWidth('0');
     end;
end;


end.

