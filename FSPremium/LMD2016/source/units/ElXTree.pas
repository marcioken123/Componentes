unit ElXTree;
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

ElXTree unit
------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

12.12.2007 (EK)
[+]  write version Ver := -17 to solve problem with picture load\save

06.10.2007 (EK)
[+]  AutoLineVisibleOnly property added (default = false). If this property is set
     to true, TElXTree defines item's height for visible sections only
     (ignores invisible header sections).

29.06.2007 (EK)
[+]  OnCellPicDraw event added. This event is like OnItemPicDraw but fired when
     ImageIndex for not main column is needed. The main difference that it contain
     SectionIndex to indicate column needs image.
###############################################################################}
{$ALIGN ON}
interface

uses
  SysUtils, Classes, Controls, Messages, Windows, Graphics, Forms, Math, StdCtrls,
  ExtCtrls, CommCtrl, Types, ImgList, Buttons, Menus, Variants, ActiveX, Themes,

  LMDTypes, LMDElConst, LMDBmp, LMDUtils, LMDProcs, LMDStrings,
  {$ifdef LMD_UNICODE} LMDUnicodeStrings, LMDUnicode, {$endif}  LMDClass, LMDThemes,
  LMDObjectList, LMDGlyphs, LMDSysIn, LMDArray, LMDHTMLUnit, LMDGraph, LMDFiles,

  ElXTreeCell, ElTreeInplaceEditors, ElVCLUtils, ElIni, ElDragDrop, ElImgFrm, Imm,
  ElInputProcessor, ElXHeader,
  ElStyleMan, ElHook, ElXPThemedControl, ElHeader, ElSBCtrl, ElScrollBar, ElHintWnd;

type
  {$EXTERNALSYM TDragType}
  TDragType = ElDragDrop.TDragType;
  {$EXTERNALSYM IDataObject}
  IDataObject = ActiveX.IDataObject;
  {$EXTERNALSYM IDropSource}
  IDropSource = ActiveX.IDropSource;
  {$EXTERNALSYM TDragTypes}
  TDragTypes = ElDragDrop.TDragTypes;
  {$EXTERNALSYM TOleDragObject}
  TOleDragObject = ElDragDrop.TOleDragObject;

const
  //DefaultTreeOwnerDrawMask = '~~@~~';

  //tisFocused    = 1;
  //tisSelected   = 2;
  tisExpanded   = 8;
  tisCut        = 4;
  tisBold       = 16;
  tisItalic     = 32;
  tisUnderlined = 64;
  tisStrikeout  = 128;

  ibfParentColors   = $0000001;
  ibfParentStyle    = $0000002;
  ibfSuppressLines  = $0000004;
  ibfForceButtons   = $0000020;
  ibfStrikedOutLine = $0000040;
  ibfDrawHLine      = $0000080;
  ibfWholeLine      = $0000100;
  ibfAllowEdit      = $0000200;
  ibfUseBackGroundColor = $0000400;
  ibfUseOwnerStyle      = $0001000;  //deprecated //vb
  ibfSuppressButtons= $0010000;
  ibfCheckBoxEnabled= $0020000;
  ibfShowCheckBox   = $0040000;
  ibfHintIsHTML     = $0400000;
  ibfWordWrap       = $4000000;

  ibfImageDrawn     = $0000008;
  ibfImageDrawn2    = $0000010;
  ibfDeleting       = $0000800;
  ibfMultiline      = $0002000;
  ibfHidden         = $0004000;
  ibfEnabled        = $0008000;
  ibfIsHTML         = $0080000;
  ibfOwnerHeight    = $0100000;
  ibfRec            = $0200000;
//  ibfSelected       = $0800000;
  ibfFocused        = $1000000;
  ibfExpanded       = $2000000;

  TM_CLOSEINPLACEEDITOR = WM_USER + 2835;

type
  TCustomElXTree = class;
  TElXTreeItem = class;
  TElXTreeItems = class;
  TElXTreeView = class;
  {$EXTERNALSYM TElXCellStyle}
  TElXCellStyle = ElXTreeCell.TElXCellStyle;
  {$EXTERNALSYM TElXHeader}
  TElXHeader = ElXHeader.TElXHeader;

  TInplaceEditorNeededXEvent   = procedure (Sender: TObject; Item: TElXTreeItem; SectionIndex: Integer; SupposedFieldType: TElFieldType; var Editor: TElTreeInplaceEditor) of object;

  TElXTreeItemStaticData = record
    FText: TLMDString;
    FHint: TLMDString;
    FCellStyle: TElXCellStyle;
  end;
  PElXTreeItemStaticData = ^TElXTreeItemStaticData;
  TElXTreeCell = class(TElXCustomTreeCell)
  private
    function GetJointCellMaster: TElXTreeCell;
  protected
    function GetElHeaderSection: TElXHeaderSection;
//    procedure SetHeaderSection(const Value: TElHeaderSection);
    function GetOwner: TElXTreeItem; reintroduce;
    procedure SetOwner(const Value: TElXTreeItem);
    procedure SetWidth(const AValue: Integer); override;
  public
    property Owner: TElXTreeItem read GetOwner write SetOwner;
    property HeaderSection: TElXHeaderSection read GetElHeaderSection; // write SetHeaderSection;
    property Data;
    property Selected;
    property Index;
    property UserText;
    property Text;
    property Control;
    property CurrentStyle;
    property Style;
    property Width;
    property Height;
    property HTMLControlsVisible;
    property JointCellRole;
    property JointRowCount;
    property JointColumnCount;
    property JointCellMaster:TElXTreeCell read GetJointCellMaster;
    property UseOwnStyle; //VB
    property Tag;
  end;

  TElXTreeCellRow = class(TElXTreeCustomCellRow)
  protected
    FOwner: TElXTreeItem;
    FCol: Integer;
    function GetCell(AIndex: Integer): TElXTreeCell;
    function GetCol: Integer;
    procedure SetCol(const Value: Integer);
    procedure CreateCells(AOwner: TElXTreeItem); virtual;
  public
    constructor Create(AOwner: TElXTreeItem);
    function Add: TElXTreeCell; virtual;
    function Insert(AIndex: Integer): TElXTreeCell; overload; virtual;
    function Insert(AIndex: Integer; ACell: TElXTreeCell): TElXTreeCell; overload;
//    function IndexOf(ACell: TElXCustomTreeCell): Integer; override;

    property Cell[AIndex: Integer]: TElXTreeCell read GetCell; default;
    property Owner: TElXTreeItem read FOwner;
    // selected column
    property Col: Integer read GetCol; // write SetCol;
    property Count;
  end;

  TElXTreeItemStaticDataEx = class
  private
    // FStaticData: PElXTreeItemStaticData;
    ItemRef: TElXTreeItem;
    FState: TElSTIStates;
//    function GetFontStyles: TFontStyles;
  protected
    FBoolData1: Integer;
//    FBackGroundColor: TColor;
//    FStrikedLineColor: TColor;
//    FBorderSpaceColor: TColor;
    FIndentAdjust: Integer;
//    FBorderStyle: TElItemBorderStyle;
//    FTextColor: TColor;
    FCheckBoxType: TElCheckBoxType;
    FCheckBoxState: TCheckBoxState;
//    FCellBackGroundColor: TColor;
    FImageIndex: Integer;
    FStImageIndex: Integer;
    FImageIndex2: Integer;
    FStImageIndex2: Integer;
    FOverlayIndex: Integer;
    FOverlayIndex2: Integer;

    function GetImage(Index: Integer): Integer;
    procedure SetImage(Index: Integer; Value: Integer);
    function GetBoolFlag(Index: Integer): Boolean;
//    function GetState(Index: TSTIState): Boolean;
    procedure SetBoolFlag(Index: Integer; Value: Boolean);
//    procedure SetState(Index: TSTIState; Value: Boolean);
    procedure Assign(Source: TElXTreeItemStaticDataEx);
  public
//    property StrikedLineColor: TColor read FStrikedLineColor write
//        FStrikedLineColor;
//    property BackGroundColor: TColor read FBackGroundColor write FBackGroundColor;
//    property BorderSpaceColor: TColor read FBorderSpaceColor write
//        FBorderSpaceColor;
    property CheckBoxState: TCheckBoxState read FCheckBoxState write FCheckBoxState;
    property CheckBoxType: TElCheckBoxType read FCheckBoxType write FCheckBoxType;
//    property Color: TColor read FTextColor write FTextColor; // deprecated;
//    property TextColor: TColor read FTextColor write FTextColor;
//    property BorderStyle: TElItemBorderStyle read FBorderStyle write FBorderStyle;
    property ImageIndex: Integer index 0 read GetImage write SetImage;
    property ImageIndex2: Integer index 1 read GetImage write SetImage;
    property StImageIndex: Integer index 2 read GetImage write SetImage;
    property StImageIndex2: Integer index 3 read GetImage write SetImage;
    property OverlayIndex: Integer index 4 read GetImage write SetImage;
    property OverlayIndex2: Integer index 5 read GetImage write SetImage;
    property IndentAdjust: Integer read FIndentAdjust write FIndentAdjust;
//    property CellBackGroundColor: TColor read FCellBackGroundColor write FCellBackGroundColor;
//    property RowBackGroundColor: TColor read FCellBackGroundColor write FCellBackGroundColor; // obsoleted, use CellBackGroundColor instead
//    property Cut: Boolean index stsCut read GetState write SetState;
//    property Bold: Boolean index stsBold read GetState write SetState;
//    property Underlined: Boolean index stsUnderlined read GetState write SetState;
//    property Italic: Boolean index stsItalic read GetState write SetState;
//    property Strikeout: Boolean index stsStrikeOut read GetState write SetState;
//    property FontStyles: TFontStyles read GetFontStyles {write SetFontStyles};
//    property ParentColors: Boolean index ibfParentColors{1} read GetBoolFlag write SetBoolFlag;
//    property ParentFontStyle: Boolean index ibfParentStyle{2} read GetBoolFlag write SetBoolFlag;
    property SuppressLines: Boolean index ibfSuppressLines{3} read GetBoolFlag write SetBoolFlag;
    property ForceButtons: Boolean index ibfForceButtons{6} read GetBoolFlag write SetBoolFlag;
    property StrikedOutLine: Boolean index ibfStrikedOutLine{7} read GetBoolFlag write SetBoolFlag;
    property DrawHLine: Boolean index ibfDrawHLine{8} read GetBoolFlag write SetBoolFlag;
    // property AllowSelection: Boolean index ibfAllowSelection{9} read GetBoolFlag write SetBoolFlag;
    property AllowEdit: Boolean index ibfAllowEdit{10} read GetBoolFlag write SetBoolFlag;
    property UseBackGroundColor: Boolean index ibfUseBackGroundColor{11} read GetBoolFlag write SetBoolFlag;
    //property UseOwnerStyle: Boolean index ibfUseOwnerStyle{13} read GetBoolFlag write SetBoolFlag;
    property Enabled: Boolean index ibfEnabled{16} read GetBoolFlag write SetBoolFlag;
    property SuppressButtons: Boolean index ibfSuppressButtons{17} read GetBoolFlag write SetBoolFlag;
    property CheckBoxEnabled: Boolean index ibfCheckBoxEnabled{18} read GetBoolFlag write SetBoolFlag;
    property ShowCheckBox: Boolean index ibfShowCheckBox{19} read GetBoolFlag write SetBoolFlag;
    property HintIsHTML: Boolean index ibfHintIsHTML{23} read GetBoolFlag write SetBoolFlag;
  end;
  // PElXTreeItemStaticDataEx = ^TElXTreeItemStaticDataEx;

  TElXTreeItem = class(TPersistent)
  private
    procedure IterateProc(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean; IterateData: TLMDDataTag; Tree: TCustomElXTree);
    procedure InvalidateItemPart(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean; IterateData: TLMDDataTag; Tree: TCustomElXTree);
  protected
    FVirtStyle: TElXCellStyle;
    FHTMLData: TLMDHTMLData;
    FHTMLDataArray: TLMDArray;
    FData: TLMDDataTag; // generic data
    FTag: Integer;
    FObject: TObject;
    FDataInterface: IUnknown;
{$ifdef USE_VARIANT}
    FSortData: Variant;
{$else}
    FSortData: TLMDDataTag;
    FSortType: Integer;
{$endif}
    FSortRef: Integer;
    FStaticData: PElXTreeItemStaticData;
    FStaticDataEx: TElXTreeItemStaticDataEx;
    FComplexHeight: Cardinal;
    FTextRect: TRect;
    FChildren: TLMDObjectList;
    FOwner: TCustomElXTree;
    FList: TElXTreeItems;
    FBoolData: Integer;
    FParent: TElXTreeItem;
    FRoot: TElXTreeItem;
    FCells: TElXTreeCellRow;

    FUseOwnStyle: boolean;
    function CreateCell: TElXTreeCell; virtual;
//    procedure BindCells;
//    procedure CreateCells;
//    procedure BindCell(const AHeaderSection: TElHeaderSection);
    function CreateIntermediateCells(AIndex: Integer): TElXTreeCell;
    function GetHeaderSections: TElXHeaderSections;

    function GetText: TLMDString;
    function GetHint: TLMDString; virtual;
    procedure SetHint(Value: TLMDString);
//    procedure SetBorderStyle(Value: TElItemBorderStyle);
    function GetParent: TElXTreeItem;
    function GetLevel: Integer;
    //procedure SetUseBackGroundColor(newValue: Boolean);
    function GetHasChildren: Boolean;
    function GetHasVisibleChildren: Boolean;
    procedure SetExpanded(value: Boolean);
    //procedure SetParentColors(value: Boolean);
    //ocedure SetParentStyle(value: Boolean);
    function GetIndex: Integer; virtual;
    function GetAbsIndex: Integer; virtual;
    function GetVisIndex: Integer;
    function GetChildIndex(Child: TElXTreeItem): Integer;
    function IsExpanded: Boolean;
    function GetFullExpand: Boolean;
    procedure MakeFullyExpanded(value: Boolean);
    //procedure OnColTextChange(Sender: TObject);
    procedure SetImageIndex(Index: Integer; value: Integer);
    procedure SetForceButtons(newValue: Boolean);
    function GetChildrenCount: Integer;
    function GetCount: Integer;
    function GetItems(Index: Integer): TElXTreeItem;
    //function GetFontStyles: TFontStyles;
    //procedure SetFontStyles(const Value: TFontStyles);
    procedure OnStyleDelete(Sender: TObject; var Item: TLMDDataTag);
    procedure SetUseOwnStyle(AValue: Boolean);
    function GetUseOwnStyle: Boolean;

    procedure SetCheckBoxState(newValue: TCheckBoxState);
    procedure SetChecked(newValue: Boolean);
    function GetChecked: Boolean;
    procedure SetShowCheckBox(newValue: Boolean);
    procedure SetCheckBoxType(newValue: TElCheckBoxType);
    procedure SetCheckBoxEnabled(newValue: Boolean);
    procedure SetSuppressButtons(newValue: Boolean);
    procedure SetEnabled(newValue: Boolean);
    procedure SetHidden(newValue: Boolean);
    function GetFullyVisible: Boolean;
    procedure SetFullyVisible(newValue: Boolean);
    function GetSelected: Boolean;
    procedure DoSetSelected(newValue: Boolean); // internal set, without redraw
    procedure SetSelected(newValue: Boolean); // "real" set

    procedure SetOwnerHeight(newValue: Boolean); virtual;
    procedure SetHeight(newValue: Integer); virtual;

    function  GetHeight: Integer; virtual;
    procedure SetSuppressLines(newValue: Boolean);
    procedure SetText(Value: TLMDString); virtual;
    procedure RemoveChild(Child: TElXTreeItem);
    procedure RemoveSubChild(Child: TElXTreeItem);
    procedure DeleteChild(Child: TElXTreeItem);
    function  AddChild(Child: TElXTreeItem): Integer;

    procedure  AddExistingChild(Child: TElXTreeItem);

    function  AddLastChild(Child: TElXTreeItem): Integer;
    function InsertChild(index: Integer; Child: TElXTreeItem): Integer;
    procedure ExchangeItems(I, J: Integer);

    // Sorting-related methods
    procedure QuickSort(recursive: Boolean;
                        L, R: Integer;
                        SM: TElSSortMode;
                        SortType: TSortTypes;
                        FSortSection: Integer);
    procedure AddSortData(SortType: TSortTypes;
                          FSortSection: Integer);
    procedure ReleaseSortData;
    procedure NormalizeSorts(StartIdx: Integer);

    function  GetOwnerHeight: Boolean;
    procedure SetMultiline(newValue: Boolean); virtual;
    procedure SetIsHTML(newValue: Boolean);
    procedure OnHTMLDataDestroy(Sender :TObject; Item: TLMDDataTag);
    function GetAncestor: TElXTreeItem;

    //procedure SetStrikedOutLine(const Value: Boolean);
    //function GetStrikedOutLine: Boolean;
    procedure SetDrawHLine(const Value: Boolean);

    procedure SetAllowEdit(const Value: Boolean);
    function CalcSubItemsHeight: Integer;
    procedure NewStaticData;
    procedure DisposeStaticData;
    procedure FillStaticData;

    procedure CreateStyle;
    //function GetColumnText: TLMDStrings;
    //nction GetParentStyle: Boolean;  //deprecated //vb

    function GetCurrentStyle: TElXCellStyleRead;
    function GetStyle: TElXCellStyle;

    function GetUseBackGroundColor: Boolean;
//    function GetParentColors: Boolean;
    function GetDrawHLine: Boolean;
    {
    function GetAllowSelection: Boolean;
    procedure SetAllowSelection(Value: Boolean);
    }
    function GetAllowEdit: Boolean;
    function GetForceButtons: Boolean;
    function GetSuppressButtons: Boolean;
    function GetSuppressLines: Boolean;
    function GetIsHTML: Boolean;
    function GetMultiline: Boolean;
    function GetShowCheckBox: Boolean;
    function GetCheckBoxEnabled: Boolean;
    function GetEnabled: Boolean;
    function GetHidden: Boolean;
    procedure CheckHidden;
    procedure SetIndentAdjust(Value: Integer);
    function GetDropTarget: Boolean;
    function GetHintIsHTML: Boolean;
    procedure SetHintIsHTML(Value: Boolean);
    procedure ClearSubChild;
    function GetTextDim(Index: Integer): Integer;
    procedure SetIndex(Value: Integer);
    procedure NewStaticDataEx;
    procedure DisposeStaticDataEx;
    //function GetColor(Index: TElXTreeCellColorType): TColor;
    //procedure SetColor(Index: TElXTreeCellColorType; value: TColor);
    function GetImageIndex(Index: Integer): Integer;
    function GetCheckBoxState: TCheckBoxState;
    function GetCheckBoxType: TElCheckBoxType;
    function GetIndentAdjust: Integer;
//    function GetBorderStyle: TElItemBorderStyle;
    function GetFocused: Boolean;
    procedure SetFocused(Value: Boolean);
    procedure UpdateChangedMainText;
    procedure UpdateChangedCellText(CellIndex: integer);
    procedure NewVirtualSort;
    procedure SetWordWrap(AWrap: Boolean);
    function GetWordWrap: Boolean;
    function GetWholeLine: Boolean;
    procedure SetWholeLine(Value: Boolean);
    function GetBoolStaticDataEx(const Index: Integer): Boolean;
    procedure SetBoolStaticDataEx(const Index: Integer; const Value: Boolean);
    //function GetBoolData(const Index: Integer): Boolean;
    //procedure SetBoolData(const Index: Integer; const Value: Boolean);
    function GetClipRect: TRect;
    function CreateCellRow(AOwner: TElXTreeItem): TElXTreeCellRow; virtual;
  public
    constructor Create(AOwner: TCustomElXTree); virtual;
    destructor Destroy; override;
    procedure ReRenderMainText;virtual;
    procedure ReRenderAllTexts;virtual;
    procedure ReRenderCellText(ColNum: Integer);virtual;
    function GetWidth: Integer; virtual;
    function BackGroundColor: TColor;
    procedure ReadData(Stream: TStream); virtual;
    procedure ImportFromOldTree(Stream: TStream; Ver: Integer); virtual;
    procedure WriteData(Stream: TStream); virtual;
    procedure Assign(Source: TPersistent); override;

    procedure InsertNewCell(AIndex: Integer); //AHeaderSection: TElHeaderSection);
    procedure DeleteCell(AIndex: Integer); //AHeaderSection: TElHeaderSection);
    function IsUnder(Item: TElXTreeItem): Boolean;
    function GetFullName(separator: TLMDString): TLMDString;
    function GetFullNameEx(separator: TLMDString; AddRoot: Boolean): TLMDString;
    procedure Expand(recursive: Boolean);
    procedure Collapse(recursive: Boolean);
    procedure Sort(recursive: Boolean);
    procedure MoveTo(NewParent: TElXTreeItem);virtual;
       // Moves the item to the new parent, adding it to the NewParent's
       // children list.
    procedure MoveToIns(NewParent: TElXTreeItem; AnIndex: Integer);virtual;
       // Moves the item to the new parent, inserting it to the NewParent's
       // children list at Index position

    procedure CopyTo(NewParent: TElXTreeItem);virtual;
    procedure UpdateItem;
    procedure Clear;
    function GetFirstVisibleChild: TElXTreeItem;
    function GetFirstChild: TElXTreeItem;
    function GetLastChild: TElXTreeItem;
    function GetNextChild(Child: TElXTreeItem): TElXTreeItem;
    function GetPrevChild(Child: TElXTreeItem): TElXTreeItem;
    function GetFirstSibling: TElXTreeItem;
    function GetLastSibling: TElXTreeItem;
    function GetNextSibling: TElXTreeItem;
    function GetPrevSibling: TElXTreeItem;
    function GetLastSubItem: TElXTreeItem;
      // Get the last item, that has current item as one of its "parents"
    function GetChildByIndex(index: Integer): TElXTreeItem;
       // Get child item, which is on "index" position in the children list
    procedure EditText;
    procedure Delete; virtual;
    property TreeView: TCustomElXTree read FOwner;

    function IsVisible: Boolean;
    function GetNextVisible: TElXTreeItem;
    function GetPrevVisible: TElXTreeItem;
    function GetPrev: TElXTreeItem; virtual;
    function GetNext: TElXTreeItem; virtual;
    procedure MoveToItem(Item: TElXTreeItem; Mode: TNodeAttachMode); virtual;

    procedure RedrawItem(ADoCheck: Boolean);
    procedure RedrawItemPart(DoCheck: Boolean; Left, Right: Integer);
    function DisplayRect(TextOnly: Boolean): TRect;
    procedure EndEdit(ByCancel: Boolean);
    procedure RecalcHeight;
    function HasAsParent(Item: TElXTreeItem): Boolean;
    function IndexOf(Item: TElXTreeItem): Integer;
    procedure MakeVisible;
//    procedure UpdateInfo(PropTypes: TElVirtPropTypes);
    procedure AllocateStorage(MaxItems: Integer); virtual;
    function IsFirstChild: Boolean;
    function IsLastChild: Boolean;

    function GetHTMLControlByName(aControlName: TLMDString): TControl;
    procedure HideHTMLControls;
    //procedure SetHTMLControlProperty

//    function GetState(index: TSTIState): Boolean;
//    procedure SetState(index: TSTIState; value: Boolean);

//    FHTMLData: TLMDHTMLData;
    property HTMLDataArray: TLMDArray read FHTMLDataArray;

    //property TextLeft: Integer index 0 read GetTextDim;
    //property TextRight: Integer index 2 read GetTextDim;
    property Data:TLMDDataTag  read FData write FData;
       // User defined data. The ElXTree doesn't free this memory when
       // the item is deleted
    property AnObject: TObject read FObject write FObject;
       // User defined data. The ElXTree doesn't free this memory when
       // the item is deleted
    property DataInterface: IUnknown read FDataInterface write FDataInterface;
    // User defined interface. Will be set to NIL before destruction to
    // decrease the reference counter.
    property Owner: TCustomElXTree read FOwner;
       // Points to the item's owner ElXTree component
    property Parent: TElXTreeItem read GetParent write MoveTo;
       // Points to the item's parent item
    property HasVisibleChildren: Boolean read GetHasVisibleChildren;
       // Shows, if the item has child items, that are not hidden
    property HasChildren: Boolean read GetHasChildren;
       // Shows, if the item has child items
    property Index: Integer read GetIndex write SetIndex;
       // This is the index of the item in the parent's children list
    property AbsoluteIndex: Integer read GetAbsIndex;
       // This is the index of the item among all items in the tree
    property VisIndex: Integer read GetVisIndex;
       // This is the index of the item among all expanded items in the tree
    property Count: Integer read GetCount;
    // This is the number of elements in Children array. Direct children only!!!
    property ChildrenCount: Integer read GetChildrenCount;
    // This is the number of children on all levels below this item.
    property Children[Index: Integer]: TElXTreeItem read GetItems; { Public }
    // The array of children elements. Direct children only!!!
    // To find out all subitems, use Iterate* methods
    property Item[Index: Integer]: TElXTreeItem read GetItems; { Public }
    // the same but for TTreeView compatibility
    property Level: Integer read GetLevel;
       // Tells, on which level the item is
       // Root items have Level 0 (zero)
    property Ancestor: TElXTreeItem read GetAncestor;
    property DrawHLine: Boolean read GetDrawHLine write SetDrawHLine;
    // property AllowSelection: Boolean read GetAllowSelection write SetAllowSelection;
       // The item currently has focus
    property Selected: Boolean read GetSelected write SetSelected;
       // The item is marked as selected
    property FullyVisible: Boolean read GetFullyVisible write SetFullyVisible;
    property DropTarget: Boolean read GetDropTarget;
    property TextRect: TRect read FTextRect write FTextRect;
    property CurrentStyle: TElXCellStyleRead read GetCurrentStyle;
    property Style: TElXCellStyle read GetStyle;
    property Cells: TElXTreeCellRow read FCells;
    property Focused: Boolean read GetFocused write SetFocused;
  published
    property FullyExpanded: Boolean read GetFullExpand write MakeFullyExpanded;
    property Expanded: Boolean read IsExpanded write SetExpanded;
    property UseOwnStyle: Boolean read GetUseOwnStyle write SetUseOwnStyle;
    property WholeLine: Boolean read GetWholeLine write SetWholeLine default False;
    property Text: TLMDString read GetText write SetText;
    property Tag: Integer read FTag write FTag;
    property AllowEdit: Boolean read GetAllowEdit write SetAllowEdit;
    property IndentAdjust: Integer read GetIndentAdjust write SetIndentAdjust;
    property HintIsHTML: Boolean read GetHintIsHTML write SetHintIsHTML;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap default False;
    property IsHTML: Boolean read GetIsHTML write SetIsHTML;
    property CheckBoxState: TCheckBoxState read GetCheckBoxState write
        SetCheckBoxState default cbUnchecked;
    property Checked: Boolean read GetChecked write SetChecked default False;
    property ShowCheckBox: Boolean read GetShowCheckBox write SetShowCheckBox
        default False;
    property CheckBoxType: TElCheckBoxType read GetCheckBoxType write
        SetCheckBoxType default ectCheckBox;
    property CheckBoxEnabled: Boolean read GetCheckBoxEnabled write
        SetCheckBoxEnabled;
    property Enabled: Boolean read GetEnabled write SetEnabled default True;
    property Hidden: Boolean read GetHidden write SetHidden;
    property Height: Integer read GetHeight write SetHeight;  { Public }
    property OwnerHeight: Boolean read GetOwnerHeight write SetOwnerHeight;  { Public }
    property Multiline: Boolean read GetMultiline write SetMultiline;
    property ImageIndex: Integer index 0 read GetImageIndex write SetImageIndex
        default -1;
    property StateImageIndex: Integer index 2 read GetImageIndex write
        SetImageIndex default -1;
    property ImageIndex2: Integer index 1 read GetImageIndex write SetImageIndex
        default -1;
    property StateImageIndex2: Integer index 3 read GetImageIndex write
        SetImageIndex default -1;
    property OverlayIndex: Integer index 4 read GetImageIndex write SetImageIndex
        default -1;
    property OverlayIndex2: Integer index 5 read GetImageIndex write SetImageIndex
        default -1;
    property ForceButtons: Boolean read GetForceButtons write SetForceButtons
        default False;
    property SuppressButtons: Boolean read GetSuppressButtons write
        SetSuppressButtons default False;
    property SuppressLines: Boolean read GetSuppressLines write SetSuppressLines;
    property Hint: TLMDString read GetHint write SetHint;
  end;

// *****************************************************************************

// *****************************************************************************

  TElXTreeItemClass = class of TElXTreeItem;

  TElXLookupCompareProc = function(Item: TElXTreeItem; SearchDetails: TLMDDataTag): Boolean;
  TElXLookupCompareMethod = function(Item: TElXTreeItem; SearchDetails: TLMDDataTag): Boolean of object;

  TElXIterateProc = procedure(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean;
                              IterateData: TLMDDataTag; Tree: TCustomElXTree);
  TElXIterateMethod = procedure(Item: TElXTreeItem; Index: integer; var ContinueIterate: boolean;
    IterateData: TLMDDataTag; Tree: TCustomElXTree) of object;

  TElXTreeItems = class(TPersistent)
  private
    procedure IntFind(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean; IterateData: TLMDDataTag; Tree: TCustomElXTree);
    procedure IntFind1(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean; IterateData: TLMDDataTag; Tree: TCustomElXTree);
    procedure IntFind2(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean; IterateData: TLMDDataTag; Tree: TCustomElXTree);
    procedure IntFind3(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean; IterateData: TLMDDataTag; Tree: TCustomElXTree);
  protected
    FOwner: TCustomElXTree;
    //FCount: Integer;

    FRoot: TElXTreeItem;
    FItemClass: TElXTreeItemClass;
    procedure RecheckMasterCells; virtual;
    function GetVisCount: Integer;
    procedure ReadData(Stream: TStream); virtual;
    procedure WriteData(Stream: TStream); virtual;
    procedure DefineProperties(Filer: TFiler); override;
    function CreateItem(FOwner: TCustomElXTree): TElXTreeItem; virtual;
    function GetCount: Integer;
    function GetRootCount: Integer;
    function GetRootItem(Index: Integer): TElXTreeItem;
    function GetItem(index: Integer): TElXTreeItem;
    function GetVisItem(index: Integer): TElXTreeItem;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TCustomElXTree); virtual;
    constructor CreateClass(AOwner: TCustomElXTree; ItemClass: TElXTreeItemClass);
    procedure DoInCreate(AOwner: TCustomElXTree);
    destructor Destroy; override;

//    procedure BindCellColumn(const AHeaderSection: TElHeaderSection);
    procedure AddExistingItem(Item, Parent: TElXTreeItem);
    procedure InsertExistingItem(Item, Parent: TElXTreeItem; Index: Integer);
    procedure RemoveItem(Child: TElXTreeItem);

    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);
    procedure SaveToFile(FileName: TLMDString);
    procedure LoadFromFile(FileName: TLMDString);

    procedure SaveToStringList(AStrings: TStrings);
    procedure LoadFromStringList(Strings: TStrings);
{$ifdef LMD_UNICODE}
    procedure LoadFromWideStringList(Strings: TLMDWideStrings);
    procedure SaveToWideStringList(AStrings: TLMDWideStrings);
{$endif}

    procedure DeleteItem(Child: TElXTreeItem);
    function GetAbsIndex(Child: TElXTreeItem): Integer;
    function GetVisIndex(Child: TElXTreeItem): Integer;
    function AddItem(Parent: TElXTreeItem): TElXTreeItem;
    function AddLastItem(Parent: TElXTreeItem): TElXTreeItem;
    procedure SetItem(Index: Integer; Value: TElXTreeItem);
    function SetItemsByString(
      AItemPath: TLMDString;
      AStartItem: TElXTreeItem = nil;
      AReturnLastInserted: Boolean = true;
      APathSeparator: TLMDChar = '\';
      ACellSeparator: TLMDChar = #9;
      AJustInsert: Boolean = false): TElXTreeItem;
    function InsertItem(Index: Integer; Parent: TElXTreeItem): TElXTreeItem;

    // AllocateStorage increases the size of the list, thus speeding up items adding
    procedure AllocateStorage(MaxItems: Integer);
    procedure AllocateStorageInRoot(MaxItems: Integer);
    function Add(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; virtual;
    function AddChild(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; virtual;
    function AddChildFirst(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; virtual;
    function AddChildObject(Item: TElXTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElXTreeItem; virtual;
    function AddChildObjectFirst(Item: TElXTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElXTreeItem; virtual;
    function AddFirst(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; virtual;
    function AddObject(Item: TElXTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElXTreeItem; virtual;
    function AddObjectFirst(Item: TElXTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElXTreeItem; virtual;
    function Insert(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; virtual;
    function InsertObject(Item: TElXTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElXTreeItem; virtual;
    function InsertAfter(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; virtual;
    function InsertAfterObject(Item: TElXTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElXTreeItem; virtual;
    function InsertItemFromString(Index: Integer; AString: TLMDString; ASeparator: TLMDChar = #9): TElXTreeItem;

    procedure Delete(Item: TElXTreeItem); virtual;
    function GetFirstNode: TElXTreeItem;

    procedure Clear;
    procedure IterateBranch(VisibleOnly: boolean; IterateProc: TElXIterateProc; IterateData: TLMDDataTag; BranchParent: TElXTreeItem); overload;
    procedure IterateFrom(VisibleOnly, CheckCollapsed: boolean; IterateProc: TElXIterateProc; IterateData: TLMDDataTag; StartFrom: TElXTreeItem); overload;
    procedure IterateBackFrom(VisibleOnly, CheckCollapsed: boolean; IterateProc: TElXIterateProc; IterateData: TLMDDataTag; StartFrom: TElXTreeItem); overload;
    procedure Iterate(VisibleOnly, CheckCollapsed: boolean; IterateProc: TElXIterateProc; IterateData: TLMDDataTag); overload;
    procedure IterateBack(VisibleOnly, CheckCollapsed: boolean; IterateProc: TElXIterateProc; IterateData: TLMDDataTag); overload;

    procedure Iterate(VisibleOnly, CheckCollapsed: boolean; IterateMethod: TElXIterateMethod; IterateData: TLMDDataTag); overload;
    procedure IterateBack(VisibleOnly, CheckCollapsed: boolean; IterateMethod: TElXIterateMethod; IterateData: TLMDDataTag); overload;
    procedure IterateFrom(VisibleOnly, CheckCollapsed: boolean; IterateMethod: TElXIterateMethod; IterateData: TLMDDataTag; StartFrom: TElXTreeItem); overload;
    procedure IterateBackFrom(VisibleOnly, CheckCollapsed: boolean; IterateMethod: TElXIterateMethod; IterateData: TLMDDataTag; StartFrom: TElXTreeItem); overload;
    procedure IterateBranch(VisibleOnly: boolean; IterateMethod: TElXIterateMethod; IterateData: TLMDDataTag; BranchParent: TElXTreeItem); overload;
    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;

    function LookForItem(StartItem: TElXTreeItem;
      TextToFind: TLMDString;
      DataToFind: TLMDDataTag;
      ColumnNum: Integer;
      LookForData,
      CheckStartItem,
      SubItemsOnly,
      VisibleOnly,
      NoCase: Boolean): TElXTreeItem;
        {<+>}
    function LookForItem2(StartItem: TElXTreeItem;
      TextToFind: TLMDString;
      WholeTextOnly: Boolean;
      DataToFind: TLMDDataTag;
      ColumnNum: Integer;
      LookForData,
      CheckStartItem,
      SubItemsOnly,
      VisibleOnly,
      CheckCollapsed,
      NoCase: Boolean): TElXTreeItem;

    function LookForItemEx(StartItem: TElXTreeItem; ColumnNum: Integer;
      CheckStartItem, SubItemsOnly, VisibleOnly: Boolean;
      SearchDetails: TLMDDataTag;
      CompareProc: TElXLookupCompareProc): TElXTreeItem;

    function LookBackForItemEx2(StartItem: TElXTreeItem; ColumnNum: Integer;
      CheckStartItem, SubItemsOnly, VisibleOnly, CheckCollapsed: Boolean;
      SearchDetails: TLMDDataTag;
      CompareProc: TElXLookupCompareProc): TElXTreeItem;

    {<+>}
    function LookForItemEx2(StartItem: TElXTreeItem; ColumnNum: Integer;
      CheckStartItem, SubItemsOnly, VisibleOnly, CheckCollapsed: Boolean;
      SearchDetails: TLMDDataTag;
      CompareProc: TElXLookupCompareProc): TElXTreeItem; overload;

    function LookForItemEx2(StartItem: TElXTreeItem; ColumnNum: Integer;
      CheckStartItem, SubItemsOnly, VisibleOnly, CheckCollapsed: Boolean;
      SearchDetails: TLMDDataTag;
      CompareMethod: TElXLookupCompareMethod): TElXTreeItem; overload;
    property ItemClass: TElXTreeItemClass read FItemClass write FItemClass;
    property Owner: TCustomElXTree read FOwner;
    property Item[Index: Integer]: TElXTreeItem read GetItem; default;
    property ItemAsVis[Index: Integer]: TElXTreeItem read GetVisItem;
    property Count: Integer read GetCount;
    property VisCount: Integer read GetVisCount;
    property RootCount: Integer read GetRootCount;
    property RootItem[Index: Integer]: TElXTreeItem read GetRootItem;
    property Root: TElXTreeItem read FRoot;
  end;

// *****************************************************************************

  TElXOleDragStartEvent = procedure(Sender: TObject; var dataObj: IDataObject;
    var dropSource: IDropSource; var dwOKEffects: TDragTypes) of object;
  TElXOleDragFinishEvent = procedure(Sender: TObject; dwEffect: TDragType; Result: HResult) of object;

  TElXMeasureItemPartEvent = procedure(Sender: TObject; Item: TElXTreeItem; PartIndex: Integer; var Size: TPoint) of object;

  TElXOnItemDrawEvent = procedure(Sender: TObject; Item: TElXTreeItem; Surface: TCanvas;
    R: TRect; SectionIndex: Integer) of object;
  TElXOnCellDrawEvent = procedure(ASender: TObject; ACell: TElXTreeCell; ACanvas: TCanvas; R: TRect) of object;
  TElXOnShowHintEvent = procedure(Sender: TObject;
    Item: TElXTreeItem;
    Section: TElHeaderSection;
    var Text: TLMDString;
    HintWindow: THintWindow;
    MousePos: TPoint;
    var DoShowHint: Boolean) of object;
  TElXApplyVisFilterEvent = procedure(Sender: TObject; Item: TElXTreeItem; var Hidden: Boolean) of object;

  TElXTuneUpInplaceEditEvent = procedure(Sender: TObject; Item: TElXTreeItem; SectionIndex: Integer; Editor: TCustomEdit) of object;
  TElXOnItemExpandEvent = procedure(Sender: TObject; Item: TElXTreeItem) of object;
  TElXOnItemCheckedEvent = Procedure (Sender: TObject; Item: TElXTreeItem) of Object;
  TElXOnItemCheckStateChangingEvent = Procedure (Sender: TObject; Item: TElXTreeItem; OldValue: integer; var NewValue: integer; var AllowChange: boolean) of Object;

  TElXItemSelChangeEvent = procedure(Sender: TObject; Item: TElXTreeItem) of object;
  TElXOnItemChangeEvent = procedure(Sender: TObject; Item: TElXTreeItem;
    ItemChangeMode: TItemChangeMode) of object;
  TElXOnCellChangeEvent = procedure(Sender: TObject; Item: TElXTreeItem; Cell: TElXTreeCell;
    ItemChangeMode: TItemChangeMode) of object;

  TElXOnCompareItems = procedure(Sender: TObject; Item1, Item2: TElXTreeItem;
    var res: Integer) of object;

  TElXOnItemExpanding = procedure(Sender: TObject; Item: TElXTreeItem;
    var CanProcess: Boolean) of object;

  TElXOnPicDrawEvent = procedure(Sender: TObject; Item: TElXTreeItem;
    var ImageIndex: Integer) of object;

  TElXOnCellPicDrawEvent = procedure(Sender: TObject; Item: TElXTreeItem; SectionIndex: Integer;
    var ImageIndex: Integer) of object;

  TElXHotTrackEvent = procedure(Sender: TObject; OldItem, NewItem: TElXTreeItem) of object;

  TElXOnValidateEvent = procedure(Sender: TObject; Item: TElXTreeItem;
    Section: TElHeaderSection;
    var Text: string; var Accept: Boolean) of object;

  TElXOnEndEditEvent = procedure(Sender: TObject; Item: TElXTreeItem;
    Section: TElHeaderSection; Canceled: Boolean) of object;  (*<+>*)

  TElXTryEditEvent = procedure(Sender: TObject; Item: TElXTreeItem;
    SectionIndex: Integer; var CellType: TElFieldType; var CanEdit: Boolean) of object;

  TElXEditRequestEvent = procedure(Sender: TObject; Item: TElXTreeItem;
    Section: TElHeaderSection) of object;

  TElXComboEditShowEvent = procedure(Sender: TObject; Item: TElXTreeItem;
    Section: TElHeaderSection;
    Combobox: TCombobox) of object;

  TElXValidateComboEvent = procedure(Sender: TObject; Item: TElXTreeItem;
    Section: TElHeaderSection;
    Combo: TComboBox;
    var Accept: Boolean) of object;

  TElXScrollEvent = procedure(Sender: TObject;
    ScrollBarKind: TScrollBarKind;
    ScrollCode: Integer) of object;

  TElXColumnMoveEvent = procedure(Sender: TCustomElXTree;
    Section: TElHeaderSection;
    OldPos, NewPos: Integer) of object;

  TElXItemSaveEvent = procedure(Sender: TObject; Stream: TStream;
    Item: TElXTreeItem) of object;

  TElXCellStyleSaveEvent = procedure(Sender: TObject; Stream: TStream;
    Style: TElXCellStyleAncestor) of object;

  TElXTreeChangingEvent = procedure (Sender: TObject; Item: TElXTreeItem;
    var AllowChange: Boolean) of object;

  TElXTreeItemPostDrawEvent = procedure(Sender: TObject; Canvas: TCanvas; Item: TElXTreeItem;
    ItemRect: TRect; var DrawFocusRect: Boolean) of object;

  TElXTreeItemDragTargetEvent = procedure (Sender: TObject; Item: TElXTreeItem;
    ItemRect: TRect; X, Y: Integer) of object;

  TElXCanDragEvent = procedure(Sender: TObject; const Item: TElXTreeItem; var CanDrag: Boolean) of object;

  TElXVirtualTextNeededEvent = procedure (Sender: TObject; Item: TElXTreeItem; SectionIndex: Integer; var Text: TLMDString) of object;
  TElXVirtualHintNeededEvent = procedure (Sender: TObject; Item: TElXTreeItem; var Hint: TLMDString) of object;
  TElXVirtualValueNeededEvent= procedure (Sender: TObject; Item: TElXTreeItem; SectionIndex: Integer; VarType: Integer; var Value: Variant) of object;
  TElXVirtualPropsNeededEvent= procedure (Sender: TObject; Item: TElXTreeItem; PropTypes: TElVirtPropTypes; Value: TElXTreeItemStaticDataEx) of object;
  TElXVirtualStyleNeededEvent= procedure (Sender: TObject; Item: TElXTreeItem; SectionIndex: Integer; Style: TElXCellStyle) of object;

  TElXCellEvent = procedure(Sender: TObject; Cell: TElXTreeCell) of object;

  // Mouse selection frame data
  TMouseFrameRec = record
    StartItem: TElXTreeItem;
    StartColumn: Integer;
    StartCoord: TPoint;
    EndItem: TElXTreeItem;
    EndColumn: Integer;
    EndCoord: TPoint;
//    CellList: TLMDObjectList;
  end;

  TElXTreeHeader = class;
  TElXTree = class;

  TElXHackHeaderCellRow = class(TElXHeaderCellRow);
  TElXHackHeaderSection = class(TElXHeaderSection);

  TElXTreeHeader = class(TElXCustomHeader)
  private
  protected
    function CreateHeaderCellRow: TElXHeaderCellRow;override;
    function GetTree: TCustomElXTree;
    function GetGutterSection: TElXHeaderSection;
//    procedure InvalidateGutterSection;
    procedure SetRowCount(const AValue: Integer);override;
    public
    constructor Create(AOwner: TComponent); override;
    procedure Loaded; override;
    property Owner: TCustomElXTree read GetTree;
  published
    property GutterSection: TElXHeaderSection read GetGutterSection;
    property ActiveFilterColor;
    property AllowDrag;
    property Align;
    property Color;
    property DefaultWidth;
    property Enabled;
    property Flat;

    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property BevelKind;
    property DoubleBuffered;
    property DragKind;
    property MoveOnDrag;
    property Font;
    property FilterColor;
    property Images;
    property AlphaForImages;

    property LookupStyle;
    property ImageForm;

    property InvertSortArrows;

    property LockHeight;

    property MultiSort;

    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ResizeOnDrag;
    property RightAlignedText;
    property RightAlignedOrder;
    property SectionsWidth;
    property ShowHint;
    property StickySections;
    property Tracking;

    property Storage;
    property StoragePath;

    property Visible;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;

    property WrapCaptions;

    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnSectionClick;
    property OnSectionResize;
    property OnSectionDraw;
    property OnSectionResizing;
    property OnSectionDelete;
    property OnSectionMove;
    property OnSectionShowHide;
    property OnPictureNeeded;
    property OnSectionChange;
    property OnSectionCreate;
    property OnSectionExpand;
    property OnSectionCollapse;
    property OnMeasureSection;
    property OnHeaderLookup;
    property OnHeaderLookupDone;

    property OnHTMLImageNeeded;

    property OnSectionAutoSize;
    property OnFilterCall;

    property OnStartDock;
    property OnEndDock;
    property OnContextPopup;
  end;

  TElXTreeView = class(TElTreeViewAncestor)
  private
    FPlusPosition: TLMDVerticalAlign;
    FLastMouseXPos: Integer;
    FLastMouseYPos: Integer;
    procedure IntPrevVis(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean; IterateData: TLMDDataTag; Tree: TCustomElXTree);
    procedure IntVis0(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean; IterateData: TLMDDataTag; Tree: TCustomElXTree);
    procedure IntNextVis(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean; IterateData: TLMDDataTag; Tree: TCustomElXTree);
    procedure IntPgVis(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean; IterateData: TLMDDataTag; Tree: TCustomElXTree);
    procedure SetPlusPosition(const Value: TLMDVerticalAlign);
  protected
    FHeader: TElXTreeHeader;
    FBottomHeight: Integer;
    FHitColumn: Integer;
    FOwner: TCustomElXTree;
    FItems: TElXTreeItems;
    FVirtStyle: TElXCellStyle;
    // Hint fields
    FHintTimer: TTimer;
    FHintWnd: TElHintWindow;
    FHintCoord: TPoint;
    FHintItem: TElXTreeItem;
    FHintItemEx: TElXTreeItem;
    FHintCol: Integer;
    FOnCanDrag: TElXCanDragEvent;
    // Update fields
    FPainting: Boolean; // already in Paint
    FClearVis: Boolean; // do update visibles list
    FClearAll: Boolean; // clear the whole ClientRect
    FVisUpdated: Boolean; // visibles list updated
    FRangeUpdate: Boolean; // all items should be updated

    // Positioning fields
    FHRange: Integer;

    // Mouse action fields
    FPressCoord: TPoint;
    FPressed: Boolean;
    FMouseSel: Boolean;
    FClickCoord: TPoint;
    FClicked: Boolean;
    FClickControl: TElXCellControl;
    FIgnoreClick,
    FIgnoreClick2: Boolean;
    FClickPassed: Boolean;
    FPassedItem: TElXTreeItem;
    FPassedShift: TShiftState;

    FClickSection: Integer;

    // Current items
    FClickItem,
    FTrackItem,

    FEditingItem,

    FFocused,
    FSelected,
    FDropTrg: TElXTreeItem;

    // mouse frame selection
    FMouseFrameRec: TMouseFrameRec;

    // Drag'n'drop fields
    FDragScrollTimer,
    FDragExpandTimer: TTimer;
    FDropAcc: Boolean;
    FInDragging: Boolean;
    FDDY: Integer;

    FDragImages: TImageList;

    // Edit fields

    FInpEdit: TElTreeInplaceEditor;
      //FEditing: Boolean;
      FEditType: TElFieldType;
      FEditSect: Integer;
      FEditTimer: TTimer;
      FItemToEdit: TElXTreeItem;
      FEndEditWhenDestroy: Boolean;
    FOldHide: Boolean;
    FFakePopup: TPopupMenu;

    FRender: TLMDHTMLRender;

    FTmpBmp: TBitmap;
    Input: TElKeyboardInput;
    SearchTextTimeoutThread: TThread;
    FScrollFirstClick: Boolean;
    FHasFocus: Boolean;
    FColorHelper: TElXTreeViewColorHelper;

    procedure StartClearSearchTimeoutThread;
    procedure StopClearSearchTimeoutThread;
    procedure SearchTextTimeout(Sender: TObject);
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    // Custom background routines
    procedure RedoTmpBmp;

    // Painting routines
    procedure RedrawTree(ACanvas: TCanvas; ARealLeftPos: Integer; AItemsList: TLMDObjectList); virtual;

    //AUsePartialCheck must be false when called from within ElXTreePrinter,
    //everywhere else it must be true
    procedure DoRedrawItem(ACanvas: TCanvas; AItem: TElXTreeItem; AItemRect, ASurfRect: TRect; AUsePartialCheck: boolean = true; AAbsIndex: integer = -1; AVisIndex: integer = -1);virtual;

    procedure Paint; override;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure DoPaintBkgnd(DC: HDC; ClipRect: TRect);
    procedure UpdateView;

    // Hint routines
    procedure TryStartHint(XPos, YPos: Integer);
    procedure OnHintTimer(Sender: TObject);
    procedure DoHideLineHint;
    procedure DoShowLineHint(Item: TElXTreeItem; Section: TElHeaderSection);
    function GetHintText(Item: TElXTreeItem; var Section: TElHeaderSection): TLMDString;

    // Dynamic height helper routines
    function CalcPageUpPos(CurIdx: Integer): Integer;
    function CalcPageDownPos(CurIdx: Integer): Integer;

    // Windows Message handling
    procedure WndProc(var Message: TMessage); override;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMMouseWheel(var Msg: TMessage); message WM_MOUSEWHEEL;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LButtonDblClk;
    procedure WMRButtonDblClk(var Msg: TWMRButtonDblClk); message WM_RBUTTONDBLCLK;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMRButtonUp(var Msg: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMIMEComposition(var Message: TMessage); message WM_IME_COMPOSITION;
    procedure WMIMEStartComposition(var Message: TMessage); message WM_IME_STARTCOMPOSITION;
    {$ifdef LMD_UNICODE}
    procedure WMDeadChar(var Message: TWMDeadChar); message WM_DEADCHAR;
    {$endif}
    function IntLButtonDown(X, Y: Integer; Shift: TShiftState): Boolean;
    function IntLButtonUp(X, Y: Integer; Shift: TShiftState): Boolean;
    procedure IntRButtonDown(X, Y: Integer; Shift: TShiftState);
    function IntRButtonUp(X, Y: Integer; Shift: TShiftState): Boolean;
    function IntLButtonDblClick(X, Y: Integer; Shift: TShiftState): Boolean;
    function IntRButtonDblClick(X, Y: Integer; Shift: TShiftState): Boolean;
    procedure IntMouseMove(X, Y: Integer; Shift: TShiftState);

    // VCL notification handlers
    procedure CMMouseWheel(var Msg: TMessage); message CM_MOUSEWHEEL;
    procedure CMSysColorChange(var Msg: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMHintShow(var Msg: TCMHintShow); message CM_HINTSHOW;
    // Scrolling routines
    procedure SetLeftPosition(value: Integer);
    procedure SetTopIndex(value: Integer);
    procedure DoSetTopIndex(Value: Integer);

    procedure OnHScroll(Sender: TObject; ScrollCode: TElScrollCode; var ScrollPos: Integer; var DoChange: Boolean);
    procedure OnVScroll(ASender: TObject; AScrollCode: TElScrollCode; var AScrollPos: Integer; var ADoChange: Boolean);

    // Painting helper routines

    // The first non-fixed visible item index is not a kind of obvious
    function GetFirstOffsetItemIndex(AOffset: Integer): Integer;
    function FillVisFwd(AOffset: Integer): Integer;
    function GetVisCount: Integer; virtual;
    function GetVisiblesHeight: Integer;

    // editing routines
    procedure OnEditTimer(Sender: TObject);
    procedure DoEditItem(Item: TElXTreeItem; SectionNum: Integer); virtual;
    procedure DoEndEdit(ByCancel: Boolean); virtual;
    procedure EditOperationCancelled; override;
    procedure EditOperationAccepted; override;
    // drag'n'drop routines
    procedure FillDragImage;
    procedure DoCanDrag(const Item: TElXTreeItem; var CanDrag: Boolean); virtual;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DoDragOver(Source: TDragObject; X, Y: Integer; CanDrop: Boolean); virtual;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure CMDrag(var Message: TCMDrag); message CM_DRAG;
    function DragScroll(Source: TDragObject; X, Y: Integer): Boolean; virtual;

    procedure OnScrollTimer(Sender: TObject);
    procedure OnDragExpandTimer(Sender: TObject);

    procedure OnDropTargetDrag(Sender: TObject; State: TDragState; Source: TOleDragObject; Shift: TShiftState; X: Integer; Y: Integer; var DragType: TDragType);
    procedure OnDropTargetDrop(Sender: TObject; Source: TOleDragObject; Shift: TShiftState; X: Integer; Y: Integer; var DragType: TDragType);

    // coords routines
    function GetItemRect(AItemIndex: Integer): TRect; virtual;
    function GetItemAtY(Y: Integer): TElXTreeItem; virtual;
    function GetItemAt(X, Y: Integer; var ItemPart: TSTXItemPart; var HitColumn: Integer): TElXTreeItem; virtual;

    // user input routines
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MouseLeave;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;

    procedure ProcessPassedClick;
    procedure FitMostChildren(Item: TElXTreeItem);

    procedure DestroyWnd; override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DestroyWindowHandle; override;
    // selection routines
    procedure DoSetSelected(AItem: TElXTreeItem);
    function GetVisCount2: Integer; virtual;
    function FindNewFocused(AKey: word; var AIndex: Integer; var ASelected: Boolean): TElXTreeItem; virtual;
    procedure DrawMouseSelectFrame(AHide: boolean = false);
    procedure AllocateMouseSelectFrame;
    procedure DeallocateMouseSelectFrame;
    procedure SelectMouseSelectItems;
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure CancelMouseSel;
    procedure CMDeactivate(var Message: TCMDeactivate); message CM_DEACTIVATE;

    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;

    procedure InitiateEditOp(Item: TElXTreeItem; HCol: Integer; Immediate :
        Boolean); virtual;

    function IsControlCell(Item: TElXTreeItem; SectionIndex: Integer): Boolean;
    procedure DoPerformSearch(SearchText: TLMDString); virtual;
    procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure OnConstrainedResizeHandler(Sender: TObject;
      var MinWidth, MinHeight, MaxWidth, MaxHeight: Integer);
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure SetFocus; override;
    procedure DefineHRange; virtual;
    function GetDragImages: TDragImageList; override;
    procedure DrawCellImage(ACanvas: TCanvas; Item: TElXTreeItem; ImageIndex :
        Integer; SectionIndex: Integer; HelperBitmap: TBitmap; var R: TRect);
    procedure DrawItemLines(ACanvas: TCanvas; Item: TElXTreeItem;
      var R: TRect; var ItemRect: TRect);
    procedure DrawGutter(ACanvas: TCanvas; Item: TElXTreeItem; const R: TRect); virtual;
    procedure DrawButtons(ACanvas: TCanvas; Item: TElXTreeItem;
      IsNode: Boolean; var R: TRect);
    procedure DrawCheckBox(ACanvas: TCanvas; Item: TElXTreeItem; HelperBitmap: TBitmap; var R: TRect);
    procedure DrawImages(ACanvas: TCanvas; Item: TElXTreeItem; HelperBitmap: TBitmap; var R: TRect);
    procedure DrawHorzLine(const ACanvas: TCanvas; const Item: TElXTreeItem; const R: TRect); virtual;
    procedure DrawVertLine(const ACanvas: TCanvas; const Item: TElXTreeItem; const R: TRect; OnRight: Boolean = True); virtual;

    property HitColumn: integer read FHitCOlumn;
    property ColorHelper: TElXTreeViewColorHelper read FColorHelper;
    property VirtStyle: TElXCellStyle read FVirtStyle;
    property Owner: TCustomElXTree read FOwner;
    property HasFocus: Boolean read FHasFocus;
    property DropTrg: TElXTreeItem read FDropTrg;
    property DropAcc: Boolean read FDropAcc;
    property DragCursor;
    property Render: TLMDHTMLRender read FRender;
    property PlusPosition: TLMDVerticalAlign read FPlusPosition write SetPlusPosition default vaTop;

    property MouseSelectionFrame: TMouseFrameRec read FMouseFrameRec;
  end;

  TMultiCellSelectStyles = (mcsControlSelect, mcsShiftSelect, mcsVisibleOnly, mcsSiblingOnly);
  TMultiCellSelectStyle = set of TMultiCellSelectStyles;

  TElXDataCache = class(TLMDObjectList)
  public
//    function Add(const Item: Pointer): Integer;
    procedure Move(CurIndex, NewIndex: Integer);
//    function Remove(const Item: Pointer): Integer;
  end;

  TElXTreeScrollBar = class(TElScrollBar)
  protected
    FTree : TCustomElXTree;
  public
    destructor Destroy; override;
  end;

  TCustomElXTree = class(TElTreeAncestor)
  private
    FIncrementalSearchSelectItem: Boolean;
    FOnCtlDblClick: TNotifyEvent;
    FOnCtlClick: TNotifyEvent;
    FOnCtlMouseDown: TMouseEvent;
    FOnCtlMouseMove: TMouseMoveEvent;
    FOnCtlMouseUp: TMouseEvent;
    function IntCompare(Item: TElXTreeItem; SearchDetails: TLMDDataTag): Boolean;
    function GetPlusPosition: TLMDVerticalAlign;
    procedure SetPlusPosition(const Value: TLMDVerticalAlign);
    procedure SetForeceAlign(const Value: boolean);
    procedure SetRowCheck(const Value: boolean);
  protected
    FUseThemeForSelection: Boolean;
    FAutoLineVisibleOnly: Boolean;
    FCellStyle: TElXCellStyle;
    FGutterWidth: Integer;
    FGutterText: TLMDString;
    FForceAlign: boolean;
    FRowCheck: boolean;
    FStripedOddColor: TColor;
    FStripedEvenColor: TColor;
    FTrackColor: TColor;
    FGradientStartColor: TColor;
    FGradientEndColor: TColor;
    FFocusedSelectColor: TColor;
    FFocusedSelectTextColor: TColor;
    FHideSelectColor: TColor;
    FHideSelectTextColor: TColor;
    FLinesColor: TColor;
    FBackGroundColor: TColor;
    FTextColor: TColor;
    FLineHintColor: TColor;
    FCurBackGroundColor: TColor;
    FCurTextColor: TColor;
    FDragRectAcceptColor: TColor;
    FDragRectDenyColor: TColor;
    FLinkColor: TColor;
    FVertDivLinesColor: TColor;
    FHorzDivLinesColor: TColor;
    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;
    FBorderColorDkShadow: TColor;
    FBorderColorFace: TColor;
    FBorderColorHighlight: TColor;
    FBorderColorShadow: TColor;
    FBorderColorWindow: TColor;
    FSortColumnColor: TColor;

    FStripedItems: Boolean;
    FOnVirtualStyleNeeded: TElXVirtualStyleNeededEvent;
    FSortSections: TLMDObjectList;
    FOnVirtualTextNeeded: TElXVirtualTextNeededEvent;
    FOnUserCellTextNeeded: TElXVirtualTextNeededEvent;
    FVirtualityLevel: TVirtualityLevel;
    FOnVirtualHintNeeded: TElXVirtualHintNeededEvent;
    FOnVirtualValueNeeded: TElXVirtualValueNeededEvent;
    FOnVirtualPropsNeeded: TElXVirtualPropsNeededEvent;
    FLineHintType: TLineHintType;
    FLineHintTimeout: Integer;
    FFireFocusEvents: Integer;
    FPlusMinusTransparent: Boolean;
    FTransCheckBoxes: Boolean;
    FExpandOnDragOver: Boolean;
    FForcedScrollBars: TScrollStyle;
    FMoveFocusOnCollapse: Boolean;
    FHeaderHeight: Integer;
    FHeaderRowCount: Integer;
    FOnVertScrollHintNeeded: TElScrollHintNeededEvent;
    FOnHorzScrollDrawPart: TElScrollDrawPartEvent;
    FOnHorzScrollHintNeeded: TElScrollHintNeededEvent;
    FOnVertScrollDrawPart: TElScrollDrawPartEvent;
    FOnVertScrollHitTest: TElScrollHitTestEvent;
    FOnChanging: TElXTreeChangingEvent;

    FBevelKindDummy: TBevelKind;

    FHintType: TElHintType;
    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    //FOnEndDrag: TDragDropEvent;
    FOnDrop: TDragDropEvent;
    FOnOver: TDragOverEvent;
    FOnDrag: TEndDragEvent;
    FOnEnter: TNotifyEvent;
    FOnExit: TNotifyEvent;
    FOnKeyDown: TKeyEvent;
    FOnKeyPress: TKeyPressEvent;
    FOnKeyUp: TKeyEvent;
    FOnMouseDown: TMouseEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseEvent;
    FOnStartDrag: TStartDragEvent;
    FOnItemPreDraw: TElXOnItemExpandEvent;
    FOnDragTargetChange: TElXTreeItemDragTargetEvent;
    FGradientSteps: Integer;
    FActiveBorderType: TElFlatBorderType;
    FInactiveBorderType: TElFlatBorderType;
    FRowHotTrack: Boolean;

    FBackground: TBitmap;
    FBackgroundType: TLMDBackgroundType;
    FAdjustMultilineHeight: Boolean;

    FFlatFocusedScrollbars: Boolean;
    FAutoResizeColumns: Boolean;
    FHideFocusRect: Boolean;
    FShowEmptyImages: Boolean;
    FShowEmptyImages2: Boolean;
    FShowRootButtons: Boolean;
    FUnderlineTracked: Boolean;
    FCustomCheckboxes: Boolean;
    FCheckBoxGlyph: TBitmap;
    FRadioButtonGlyph: TBitmap;

    FFilteredVisibility: Boolean;
    FOnApplyVisFilter: TElXApplyVisFilterEvent;
    FRightAlignedText: Boolean;
    FFlat: Boolean;
    FRightAlignedView: Boolean;
    FPathSeparator: Char;
    FLinesStyle: TPenStyle;
    FDeselectChildrenOnCollapse: Boolean;
    FDrawFocusRect: Boolean;
    FBarStyle: Boolean;
    FNotRaiseForBarStyle: Boolean;
    FAlwaysKeepFocus: Boolean;
    FAlwaysKeepSelection: Boolean;
    FFullRowSelect: Boolean;
    FDragType: TElDragType;
    FMouseOver: Boolean;

    FDropTarget: TElDropTarget;

    FDragObject: TDragObject;
    FAutoLookup: Boolean;
    FSelectColumn: Integer;
    FAutoExpand: Boolean;
    FLeafPicture,
    FPlusPicture,
    FMinusPicture: TBitmap;
    FCustomPlusMinus: Boolean;
    FShowColumns,
    FShowCheckBoxes: Boolean;

    FImageForm: TElImageForm;
    FImgFormChLink: TImgFormChangeLink;

    FStorage: TElIniFile;
    FStoragePath: string;
    FDragImageMode: TDragImgMode;
    FHideHorzScrollBar: Boolean;
    FHideVertScrollBar: Boolean;
    FHideHintOnMove: Boolean;
    FSortSection: Integer;
    FSortMode: TSortModes;
    FSortType: TSortTypes;
    FDragAllowed: Boolean;
    FShowButtons: Boolean;
    FShowLines: Boolean;
    FShowImages: Boolean;
    FShowRoot: Boolean;
    FLineHintMode: THintModes;
    // BMP: TBitmap;
    FBorderStyle: TBorderStyle;

    FDoInplaceEdit: Boolean;

    FIgnoreSBChange: Boolean;
    FScrollbarsInitialized: Boolean;

    FSortRequired,
    FProcUpdate, // already in SetIsUpdating
    FUpdated: Boolean;
    FInSorting: Integer;
    FBarStyleVerticalLines: Boolean;

    FAllList: TLMDObjectList;
    FSelectedList: TLMDObjectList;

    FVertScrollTracking,
    FHorzScrollTracking,
      FHotTrack: Boolean;
    FHeaderHotTrack: Boolean;
    FOwnerDrawByColumn: Boolean;
    FOwnerDrawMask: TLMDString;

    FImages: TCustomImageList;
    FImages2: TCustomImageList;
    FAlphaForImages: TCustomImageList;
    FAlphaForImages2: TCustomImageList;

    FImageChangeLink: TChangeLink;
    FAImageChangeLink: TChangeLink;

    FTopIndex: Integer;
    FBottomIndex: Integer; // visible items

    FFixedTopRowNum: Integer; // number of fixed rows
    FFixedBottomRowNum: Integer;

    FChangeStateImage: Boolean;
    FRealHint,
    FHint: TLMDString;
    FMainTreeColumn: Integer;
//    FMultiCellSelect: Boolean;
//    FMultiCellSelectStyle: TMultiCellSelectStyle;
//    FSelectedCells: array of array of Boolean;
    FMultiSelect: Boolean;
    FMultiSelectLevel: Integer; // CNS: -1 any, 0,1,2... limit multiseletion to this level
    FRowSelect: Boolean;
    FHideSelection: Boolean;
    FLineHeight: Integer;
    FAutoLineHeight: Boolean;
    FItemIndent: Integer;
    FUseCustomScrollBars: Boolean;

    // FTreeIsFocused: Boolean;

    FLeftPosition: Integer;
    FVertScrollBarVisible,
    FHorzScrollBarVisible: Boolean;
    FSelectionMode: TSTSelModes;
    FSortDir: TSortDirs;

    FSelChange: Boolean;
    FColumnSizeUpdate: Boolean;
    FUpdateCount: Integer;

    FHideHintOnTimer: Boolean;
    FUseSystemHintColors: Boolean;
    IgnoreResize: Boolean;

    FDelOnEdit: Boolean;

    FAutoSizingColumns: Boolean;
    FAdjustInplaceEditorPosition: boolean;

    FItems: TElXTreeItems;

    FOnColumnResize: TColumnNotifyEvent;
    FOnColumnClick: TColumnNotifyEvent;
    FOnColumnDraw: TElXSectionRedrawEvent;

    FOnItemChange: TElXOnItemChangeEvent;
    FOnCellChange: TElXOnCellChangeEvent;
    FOnItemDraw: TElXOnItemDrawEvent;
    FOnCellDraw: TElXOnCellDrawEvent;
    FOnItemChecked: TElXOnItemCheckedEvent;
    FOnItemCheckStateChanging: TElXOnItemCheckStateChangingEvent;
    FOnItemExpand: TElXOnItemExpandEvent;
    FOnItemCollapse: TElXOnItemExpandEvent;
    FOnItemExpanding: TElXOnItemExpanding;
    FOnItemCollapsing: TElXOnItemExpanding;
    FOnItemDelete: TElXOnItemExpandEvent;
    FOnItemCreated: TElXOnItemExpandEvent;
    FOnCellDeletion: TElXCellEvent;
    FOnItemFocused: TNotifyEvent;
    FOnItemPostDraw: TElXTreeItemPostDrawEvent;
    FOnShowHint: TElXOnShowHintEvent;
    FOnCompareItems: TElXOnCompareItems;
    FOnItemPicDraw: TElXOnPicDrawEvent;
    FOnItemPicDraw2: TElXOnPicDrawEvent;
    FOnCellPicDraw: TElXOnCellPicDrawEvent;
    FOnHotTrack: TElXHotTrackEvent;

    FOnScroll: TElXScrollEvent;
    FOnItemSave: TElXItemSaveEvent;
    FOnItemLoad: TElXItemSaveEvent;

    FOnTryEdit: TElXTryEditEvent;
    FOnEndEdit: TElXOnEndEditEvent;

    FOnHeaderColumnMove: TElXColumnMoveEvent;
    FOnSave: TElXCellStyleSaveEvent;
    FOnLoad: TElXCellStyleSaveEvent;
    FOnItemSelectedChange: TElXItemSelChangeEvent;
    FOnHeaderLookup: TElHeaderLookupEvent;
    FOnHeaderLookupDone: TElHeaderLookupDoneEvent;
    FOnHeaderResize: TNotifyEvent;
    FOnHeaderSectionExpand: TElXHeaderSectionEvent;
    FOnHeaderSectionCollapse: TElXHeaderSectionEvent;
    FOnHeaderSectionMeasure: TMeasureSectionEvent;
    FOnHeaderSectionCellClick : TElXHeaderSectionCellEvent;
    FOnSectionAutoSize: TColumnNotifyEvent;
    FOnSectionFilterCall: TColumnNotifyEvent;
    FOnMeasureItemPart: TElXMeasureItemPartEvent;
    FOnSortBegin,
    FOnSortEnd: TNotifyEvent;

    FOnOleDragFinish: TElXOleDragFinishEvent;
    FOnOleDragStart: TElXOleDragStartEvent;
    FOnOleTargetDrag: TTargetDragEvent;
    FOnOleTargetDrop: TTargetDropEvent;

    TotalHiddenCount,
    TotalVisCount: Integer;
    TotalVarHeightCount: Integer;

    FView: TElXTreeView;
    FHeader: TElXTreeHeader;
    FHScrollBar: TElScrollBar;
    FVScrollBar: TElScrollBar;
    FHorzScrollBarStyle,
    FVertScrollBarStyle: TElScrollBarStyles;
    FSavedHeaderHeight: Integer;
    FDelayTimer: TTimer;

    FDelayedItem: TElXTreeItem;
    FDragExpandDelay,
    FChangeDelay: Integer;
    FDragTrgDrawMode: TDragTargetDraw;

    FOnHeaderMouseDown: TMouseEvent;
    FOnAfterSelectionChange: TNotifyEvent;
    FIncrementalSearchTimeout: Integer;
    FIncrementalSearch: Boolean;
    FRightClickSelect: Boolean;
    FScrollbarOpposite: Boolean;
    FVerticalLinesLong: Boolean;
    FBorderSides: TLMDBorderSides;

    FOnInplaceEditorNeeded: TInplaceEditorNeededXEvent;

    FCursor: TCursor;

    FOnImageNeeded: TElHTMLImageNeededEvent;
    FOnImageNeededEx: TLMDHTMLImageNeededEvent;
    FOnLinkClick: TElHTMLLinkClickEvent;
    FOnLinkOver: TElHTMLLinkOverEvent;
    FOnControlCreated: TLMDHTMLControlCreatedEvent;
    FOnAdjustControlPosition: TLMDHTMLControlPositionNeededEvent;
    FOnTagFound: TLMDHTMLTagFoundEvent;

    FLinkCursor: TCursor;
    FLinkStyle: TFontStyles;

    FQuickEditMode: Boolean;
    FMainTextType: TElFieldType;
    FOnHorzScrollHitTest: TElScrollHitTestEvent;
    FMouseFrameVisible,
    FMouseFrameSelect: Boolean;
    FDragScrollInterval: Integer;
    FShowLeafButton: Boolean;
    FCheckBoxSize: Integer;
    FIgnoreEnabled: Boolean;
    FInplaceEditorDelay: Integer;
    FHeaderFont: TFont;
    FHeaderUseTreeFont: Boolean;
    FKeepSelectionWithinLevel: Boolean;
    FAutoCollapse: Boolean;
    FIgnoreResizes: Boolean;
    FSortUseCase: Boolean;
    FDblClickMode: TElDblClickMode;
    FDoubleBuffered: Boolean;
    FDoubleBufferedOnResize: Boolean;
    FInSizeMove: Boolean;
    FHook: TElHook;
    FHighlightAlphaLevel: Integer;

    FDataCache: TElXDataCache;
    FDataCacheSize: Integer;
    FLastWasDown: Boolean;
{$ifdef HOTTRACK_CURSOR}
    FTrackingCursor: TCursor;
{$endif}

    FSortSectionToCompare: Integer;
    FIncrementalSearchScope: TElIncSearchScope;
    FIncrementalSearchColumn: TElIncSearchColumn;
    FCheckBoxFlat: Boolean;
    FHorzArrowsScroll: Boolean;

    FCollapsing: Boolean;

    procedure DoOnCtlClick(Sender: TObject); virtual;
    procedure DoOnCtlDblClick(Sender: TObject); virtual;
    procedure DoOnCtlMouseDown(Sender: TObject; Button: TMouseButton;
                               Shift: TShiftState; X, Y: Integer); virtual;
    procedure DoOnCtlMouseMove(Sender: TObject; Shift: TShiftState;
                               X, Y: Integer); virtual;
    procedure DoOnCtlMouseUp(Sender: TObject; Button: TMouseButton;
                             Shift: TShiftState; X, Y: Integer); virtual;

    procedure SetUseThemeForSelection(const Value: Boolean);
    procedure ReadState(Reader: TReader); override;
    function GetAlignmentOnSection(SectionIndex: integer): string; override;
    procedure StyleChanged(Sender: TObject);
    function GetTreeViewAncestor: TElTreeViewAncestor; override;
    procedure InsertColumn(AIndex: Integer); //AHeaderSection: TElHeaderSection);
    procedure DeleteColumn(AIndex: Integer); //AHeaderSection: TElHeaderSection);
    procedure CheckHeaderCount;
    procedure SetStripedOddColor(Value: TColor);
    procedure SetStripedEvenColor(Value: TColor);
    procedure SetStripedItems(Value: Boolean);

    procedure TriggerImageNeededEvent(Sender: TObject; Src: TLMDString; var Image: TBitmap); virtual;
    procedure TriggerImageNeededExEvent(Sender : TObject; Src : TLMDString; Image : TPicture); virtual;
    procedure TriggerAdjustControlPositionEvent(Sender : TObject; aControl: TControl; aData: Pointer; var X: integer; var Y: integer);
    procedure TriggerControlCreatedEvent(Sender : TObject; aControl: TControl);
    procedure TriggerTagFoundEvent(Sender : TObject; var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing:boolean; aSupported: boolean);

    procedure UpdateHTMLControlsVisibility(Sender : TObject; aControl: TControl; aData: Pointer; var aVisible: boolean);

    procedure TriggerLinkClickEvent(HRef: string; X, Y: Integer); virtual;
    procedure SetLinkColor(newValue: TColor); virtual;
    procedure SetLinkStyle(newValue: TFontStyles); virtual;

    procedure OnBeforeHook(Sender: TObject; var Message: TMessage; var Handled: Boolean);
    procedure SetParent(AParent: TWinControl); override;
    procedure SetVirtualityLevel(Value: TVirtualityLevel);
    procedure SetBorderSides(Value: TLMDBorderSides);
    function GetDefaultSectionWidth: Integer;
    procedure SetDefaultSectionWidth(Value: Integer);
    procedure OnHeaderSectionResize(AHeader: TElXCustomHeader; Section: TElXHeaderSection);
    procedure OnHeaderSectionClick(Sender: TElXCustomHeader; Section: TElXHeaderSection);virtual;
    procedure OnHeaderSectionDelete(AHeader: TElXCustomHeader; Section: TElXHeaderSection);
    procedure DoHeaderMouseDown(Sender: TObject; Button: TMouseButton; Shift:
        TShiftState; X, Y: Integer);
    procedure OnHeaderSectionLookup(Sender: TObject; Section: TElXHeaderSection; var Text: TLMDString);
    procedure OnHeaderSectionLookupDone(Sender: TObject; Section: TElXHeaderSection; Text: TLMDString; Accepted: Boolean);
    procedure OnHeaderExpand(Sender: TElXCustomHeader; Section: TElXHeaderSection);
    procedure OnHeaderCollapse(Sender: TElXCustomHeader; Section: TElXHeaderSection);
    procedure OnHeaderSectionVisChange(Sender: TElXCustomHeader; Section: TElXHeaderSection);
    procedure HeaderSectionAutoSizeHandler(Sender: TElXCustomHeader; Section: TElXHeaderSection);  { TElXTreeHeaderSectionEvent }
    procedure HeaderSectionAutoSizeTransfer(Sender: TCustomElHeader; Section: TElHeaderSection);  { TElHeaderSectionEvent }
    procedure HeaderSectionFilterCallTransfer(Sender: TElXCustomHeader; Section: TElXHeaderSection);  { TElHeaderSectionEvent }
    procedure HeaderSectionCellClickTransfer(Sender: TElXCustomHeader; Section: TElXHeaderSection; Cell: TElXHeaderCell);virtual;

    procedure DoHeaderResize(Sender: TObject);
    procedure OnFontChange(Sender: TObject); virtual;
    function IsHeaderFontStored: Boolean;
    function IsFontStored: Boolean;
    procedure OnSignChange(Sender: TObject);
    procedure ImageListChange(Sender: TObject);

    function GetCanDrag: TElXCanDragEvent;
    procedure SetCanDrag(const Value: TElXCanDragEvent);
    function GetDropTarget: TElXTreeItem;

    procedure SetTextColor(value: TColor);
    procedure SetBackGroundColor(value: TColor);

    function  GetHeaderWrapCaptions: Boolean;
    procedure SetHeaderWrapCaptions(Value: Boolean);

    procedure SetHeaderHotTrack(value: Boolean);
    procedure SetHeaderHeight(value: Integer);
    procedure SetShowEmptyImages(newValue: Boolean);
    procedure SetShowEmptyImages2(newValue: Boolean);
    procedure SetImages(Value: TCustomImageList);
    procedure SetImages2(newValue: TCustomImageList);
    procedure SetAlphaForImages(Value: TCustomImageList);
    procedure SetAlphaForImages2(newValue: TCustomImageList);
    procedure SetLineHintTimeout(Value: Integer);

    procedure SetShowLines(Value: Boolean);
    procedure SetShowRoot(Value: Boolean);
    procedure SetShowImages(Value: Boolean);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetShowButtons(Value: Boolean);
    procedure SetUpdating(value: Boolean);
    function  GetUpdating: Boolean;
    procedure SetHorizontalLines(value: Boolean);
    procedure SetVerticalLines(value: Boolean);
    procedure SetBarStyleVerticalLines(value: Boolean);
    procedure SetRowSelect(value: Boolean);
    procedure SetMultiSelectLevel(Value: Integer);
    procedure SetMultiSelect(value: Boolean);

//    procedure SetMultiCellSelect(value: Boolean);
//    procedure SetMultiCellSelectStyle(value: TMultiCellSelectStyle);
//    procedure InsertRowIntoSelectedCellArray(ARowNum: Integer);
//    procedure InsertColumnIntoSelectedCellArray(AColNum: Integer);
//    procedure DeleteRowFromSelectedCellArray(ARowNum: Integer);
//    procedure DeleteColumnFromSelectedCellArray(AColNum: Integer);
//    procedure SetCellSelected(AItemIndex, AColumn: Integer; ASelected: Boolean);

    procedure SetFocused(value: TElXTreeItem);
    procedure SetHideSelection(value: Boolean);
    procedure SetAutoExpand(value: Boolean);
    procedure SetMoveFocusOnCollapse(value: Boolean);
    function GetHeaderSections: TElXHeaderSections;
    procedure SetHeaderSections(value: TElXHeaderSections);
    procedure SetChangeStateImage(value: Boolean);
    procedure SetUseCustomScrollBars(value: Boolean);

    procedure SetItemIndent(value: Integer);
    procedure SetLineHeight(value: Integer);
    procedure SetAutoLineHeight(value: Boolean);
    procedure SetAutoLineVisibleOnly(value: Boolean);

    function GetHeaderHeight: Integer;

    procedure SetHeaderRowCount(value: Integer);
    function GetHeaderRowCount: Integer;

    procedure SetMainTreeColumn(value: Integer);
    procedure SetItems(value: TElXTreeItems);
    function GetTotalVisCount: Integer;
    function GetDraggableSections: Boolean;
    procedure SetDraggableSections(newValue: Boolean);
    procedure SetSortMode(newValue: TSortModes);
    procedure SetSortSection(newValue: Integer);

    function GetMoveColumnOnDrag: Boolean;
    procedure SetMoveColumnOnDrag(newValue: Boolean);
    procedure SetHideHorzScrollBar(newValue: Boolean);
    procedure SetHideVertScrollBar(newValue: Boolean);
    function GetHeaderImages: TCustomImageList;
    procedure SetHeaderImages(newValue: TCustomImageList);
    function GetAlphaHeaderImages: TCustomImageList;
    procedure SetAlphaHeaderImages(newValue: TCustomImageList);

    function GetFireFocusEvents: Boolean;
    procedure SetFireFocusEvents(Value: Boolean);

    procedure SetScrollbarOpposite(Value: Boolean);
    procedure SetVerticalLinesLong(Value: Boolean);

    function GetSelCount: Integer;
    function GetSelected: TElXTreeItem;
    function GetHitColumn: integer;
    function GetFocused: TElXTreeItem;
    procedure SetSelected(newValue: TElXTreeItem);

    procedure SetStorage(newValue: TElIniFile);

    procedure SetImageForm(newValue: TElImageForm);
    procedure ImageFormChange(Sender: TObject);
    procedure SetHeaderImageForm(newValue: TElImageForm);
    function GetHeaderImageForm: TElImageForm;

    procedure SetShowCheckBoxes(newValue: Boolean);
    procedure SetPlusPicture(newValue: TBitmap);
    procedure SetMinusPicture(newValue: TBitmap);
    procedure SetCustomPlusMinus(newValue: Boolean);
    procedure SetSelectColumn(newValue: Integer);
    procedure SetDragType(newValue: TElDragType);

    procedure HeaderResizeTransfer(Sender: TObject);
    procedure HeaderResizeHandler(Sender: TObject);

    function GetStickyHeaderSections: Boolean;
    procedure SetStickyHeaderSections(newValue: Boolean);
    procedure SetBarStyle(newValue: Boolean);
    procedure SetDrawFocusRect(newValue: Boolean);
    procedure SetLinesColor(newValue: TColor);
    procedure SetHorzDivLinesColor(newValue: TColor);
    procedure SetLinesStyle(newValue: TPenStyle);
    procedure SetRightAlignedView(newValue: Boolean);
    procedure SetFlat(newValue: Boolean);
    procedure SetRightAlignedText(newValue: Boolean);virtual;
    procedure SetFilteredVisibility(newValue: Boolean);
    procedure SetUnderlineTracked(newValue: Boolean);
    procedure SetCustomCheckboxes(newValue: Boolean);
    procedure SetCheckBoxGlyph(newValue: TBitmap);
    procedure SetRadioButtonGlyph(newValue: TBitmap);
    procedure SetShowRootButtons(newValue: Boolean);
    procedure SetHideFocusRect(newValue: Boolean);
    function GetLockHeaderHeight: Boolean;
    procedure SetLockHeaderHeight(newValue: Boolean);
    procedure SetPlusMinusTransparent(newValue: Boolean);

    procedure UpdateFrame;

    procedure SetHeaderActiveFilterColor(newValue: TColor);
    function GetHeaderActiveFilterColor: TColor;
    procedure SetHeaderFilterColor(newValue: TColor);
    function GetHeaderFilterColor: TColor;
    procedure SetHeaderFlat(newValue: Boolean);
    function GetHeaderFlat: Boolean;

    procedure DrawFlatBorder(HorzTracking, VertTracking: Boolean);
    procedure DrawFlatBorderEx(DC: Windows.HDC; HorzTracking, VertTracking: Boolean);

    procedure ReRenderAllHTMLItems;

    procedure SetFlatFocusedScrollbars(newValue: Boolean);

    procedure SetBackground(newValue: TBitmap);
    procedure SetBackgroundType(newValue: TLMDBackgroundType);
    procedure BackgroundChange(Sender: TObject);

    procedure WMNCHITTEST(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
    procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
    procedure WMEnable(var Msg: TWMEnable); message WM_ENABLE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MouseEnter;
    procedure CMMouseLeave(var Message: TMessage); message CM_MouseLeave;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure WMSysColorChange(var Msg: TWMSysColorChange); message WM_SYSCOLORCHANGE;

    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;

    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
        WM_WINDOWPOSCHANGED;

    procedure IFMCanPaintBkgnd(var Message: TMessage); message IFM_CANPAINTBKGND;

    procedure SetHideSelectColor(newValue: TColor);
    procedure SetFocusedSelectColor(newValue: TColor);

    procedure SetHideSelectTextColor(newValue: TColor);
    procedure SetFocusedSelectTextColor(newValue: TColor);

    procedure SetRowHotTrack(newValue: Boolean);
    procedure SetActiveBorderType(newValue: TElFlatBorderType);
    procedure SetInactiveBorderType(newValue: TElFlatBorderType);

    procedure SetGradientStartColor(newValue: TColor);
    procedure SetGradientEndColor(newValue: TColor);
    procedure SetGradientSteps(newValue: Integer);

    procedure SetLeftPosition(value: Integer);
    procedure SetTopIndex(value: Integer);

    procedure ClickTransfer(Sender: TObject);  virtual;
    procedure DblClickTransfer(Sender: TObject); virtual;
    procedure DropTransfer(Sender: TObject; Source: TObject; X: Integer; Y: Integer);  virtual;
    //procedure EndDragTransfer(Sender: TObject; Source: TObject; X: Integer; Y: Integer);
    procedure OverTransfer(Sender: TObject; Source: TObject; X: Integer; Y: Integer; State: TDragState; var Accept: Boolean); virtual;
    procedure DragTransfer(Sender: TObject; Target: TObject; X: Integer; Y: Integer); virtual;
    procedure EnterTransfer(Sender: TObject); virtual;
    procedure ExitTransfer(Sender: TObject); virtual;
    procedure KeyDownTransfer(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure KeyPressTransfer(Sender: TObject; var Key: Char); virtual;
    procedure KeyUpTransfer(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure MouseDownTransfer(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); virtual;
    procedure MouseMoveTransfer(Sender: TObject; Shift: TShiftState; X: Integer; Y: Integer); virtual;
    procedure MouseUpTransfer(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); virtual;
    procedure StartDragTransfer(Sender: TObject; var DragObject: TDragObject); virtual;
    procedure MeasureSectionTransfer(Sender: TObject; Section: TElHeaderSection; var Size: TPoint); virtual;
    procedure SetCursor(newValue: TCursor);
    function  GetCursor: TCursor;
    function  SetScrollInfo(hWnd: HWND; BarFlag: Integer; const ScrollInfo: TScrollInfo; Redraw: BOOL): Integer;
    function  GetScrollInfo(hWnd: HWND; BarFlag: Integer; var ScrollInfo: TScrollInfo): BOOL;
    procedure SetHorzScrollBarStyle(newValue: TElScrollBarStyles);
    procedure SetVertScrollBarStyle(newValue: TElScrollBarStyles);
    procedure HorzScrollDrawPartTransfer(Sender: TObject; Canvas: TCanvas; R: TRect; Part: TElScrollBarPart; Enabled: Boolean; Focused: Boolean; Pressed: Boolean; var DefaultDraw: Boolean);  { TElScrollDrawPartEvent }
    procedure HorzScrollHintNeededTransfer(Sender: TObject; TrackPosition: Integer; var Hint: TLMDString);  { TElScrollHintNeededEvent }
    procedure VertScrollDrawPartTransfer(Sender: TObject; Canvas: TCanvas; R: TRect; Part: TElScrollBarPart; Enabled: Boolean; Focused: Boolean; Pressed: Boolean; var DefaultDraw: Boolean);  { TElScrollDrawPartEvent }
    procedure VertScrollHintNeededHandler(Sender: TObject; TrackPosition: Integer; var Hint: TLMDString);  { TElScrollHintNeededEvent }
    procedure VertScrollHintNeededTransfer(Sender: TObject; TrackPosition: Integer; var Hint: TLMDString);  { TElScrollHintNeededEvent }
    function GetHeaderInvertSortArrows: Boolean;
    procedure SetHeaderInvertSortArrows(newValue: Boolean);
    // procedure OnFontChanged(Sender: TObject); virtual;
    procedure SBChanged(Sender: TObject);
    procedure ScrollBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SetForcedScrollBars(newValue: TScrollStyle);
    function GetDragCursor: TCursor;
    procedure SetDragCursor(Value: TCursor);
    procedure SetTrackColor(value: TColor);

    function GetFixedColNum: Integer;
    function GetGutterWidth: Integer;
    function GetGutterText: TLMDString;
    function GetFixedBottomRowsHeight: Integer;
    procedure SetFixedColNum(Value: Integer);
    procedure SetGutterWidth(AValue: Integer);
    procedure SetGutterText(AValue: TLMDString);
    procedure SetFixedTopRowNum(Value: Integer);
    procedure SetFixedBottomRowNum(Value: Integer);
    procedure SetAdjustMultilineHeight(newValue: Boolean); virtual;

    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;

    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure AlignPieces; virtual;
    function GetRoot: TElXTreeItem; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function  CompareItems(Item1, Item2: TElXTreeItem; SM: TElSSortMode; ST: TSortTypes; FSortSection: Integer): Integer; virtual;

    procedure SetDoInplaceEdit(value: Boolean); virtual;

    procedure SetShowColumns(value: Boolean); virtual;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure Resize; override;

    function  DoGetPicture(Item: TElXTreeItem; SectionIndex: Integer): Integer; virtual;
    function  DoGetPicture2(Item: TElXTreeItem): Integer; virtual;
    function  DefineLineHeight: Integer; virtual;
    procedure UpdateScrollBars; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    function CreateItems: TElXTreeItems; virtual;
    function CreateItemsExt(ItemClass: TElXTreeItemClass): TElXTreeItems; virtual;
    function CreateHeader: TElXTreeHeader; virtual;
    function DoSetFocused(value: TElXTreeItem; Forced: Boolean): Boolean;
    function DoSetFocusedEx(value: TElXTreeItem; Forced, Delayed: Boolean): Boolean;
    procedure SetHeaderColor(newValue: TColor); virtual;
    function GetHeaderColor: TColor; virtual;
    function GetHint: TLMDString;
    procedure SetHint(newValue: TLMDString);

    procedure DoChanging(Item: TElXTreeItem; var AllowChange: Boolean); virtual;
    procedure DoOnColumnResize(SectionIndex: Integer); virtual;
    procedure DoColumnClick(SectionIndex: Integer); virtual;
    procedure DoItemFocused; virtual;
    procedure DoItemDraw(Item: TElXTreeItem; Surface: TCanvas; R: TRect; SectionIndex: Integer); virtual;

    procedure DoItemChange(Item: TElXTreeItem; ItemChangeMode: TItemChangeMode); virtual;
    procedure DoCellChange(Item: TElXTreeItem; Cell: TElXCustomTreeCell; ItemChangeMode: TItemChangeMode); virtual;
    procedure DoItemExpanding(Item: TElXTreeItem; var CanProcess: Boolean); virtual;
    procedure DoItemCollapsing(Item: TElXTreeItem; var CanProcess: Boolean); virtual;
    procedure DoItemChecked(Item: TElXTreeItem); virtual;
    procedure DoItemCheckStateChanging(Item: TElXTreeItem; OldValue: integer; var NewValue: integer; var AllowChange: boolean); virtual;
    procedure DoItemExpand(Item: TElXTreeItem); virtual;
    procedure DoItemCollapse(Item: TElXTreeItem); virtual;
    procedure DoItemDelete(Item: TElXTreeItem); virtual;
    procedure DoItemCreated(Item: TElXTreeItem); virtual;
    procedure DoCellDeletion(Cell: TElXCustomTreeCell); virtual;
    procedure DoCompareItems(Item1, Item2: TElXTreeItem; var res: Integer); virtual;
    procedure DoHeaderDraw(Sender: TElXCustomHeader;
    Canvas: TCanvas; Section: TElXHeaderSection; R: TRect; Pressed: boolean); virtual;
    procedure OnHeaderSectionChange(Sender: TElXCustomHeader; Section: TElXHeaderSection; Change: TSectionChangeMode); virtual;
    procedure OnHeaderSectionMove(Sender: TElXCustomHeader; Section: TElXHeaderSection; OldPos, NewPos: Integer); virtual;
    procedure TriggerHotTrackEvent(OldItem, NewItem: TElXTreeItem); virtual;
    procedure TriggerScrollEvent(ScrollBarKind: TScrollBarKind; ScrollCode: Integer); virtual;
    procedure TriggerHeaderColumnMoveEvent(Section: TElHeaderSection; OldPos, NewPos: Integer); virtual;
    procedure TriggerItemSaveEvent(Stream: TStream; Item: TElXTreeItem); virtual;
    procedure TriggerItemLoadEvent(Stream: TStream; Item: TElXTreeItem); virtual;
    procedure TriggerItemSelectedChangeEvent(Item: TElXTreeItem); virtual;
    procedure DoShowHint(Item: TElXTreeItem; Section: TElHeaderSection; var Text: TLMDString; HintWindow: THintWindow; MousePos: TPoint; var DoShowHint: Boolean); virtual;

    procedure Paint; override;
    procedure OnHeaderSectionCreate(AHeader: TElXCustomHeader; Section: TElXHeaderSection); virtual;

    procedure TriggerHeaderLookupEvent(Section: TElHeaderSection; var Text: TElFString); virtual;
    procedure TriggerHeaderLookupDoneEvent(Section: TElHeaderSection; Text: TLMDString;
        Accepted: Boolean); virtual;
    procedure TriggerHeaderSectionExpandEvent(Section: TElXHeaderSection); virtual;
    procedure TriggerHeaderSectionCollapseEvent(Section: TElXHeaderSection); virtual;

    procedure TriggerMeasureItemPartEvent(Item: TElXTreeItem; PartIndex: Integer; var Size: TPoint); virtual;
    procedure TriggerApplyVisFilterEvent(Item: TElXTreeItem; var Hidden: Boolean); virtual;
    procedure TriggerItemPostDrawEvent(Canvas: TCanvas; Item: TElXTreeItem; ItemRect: TRect; var DrawFocusRect: Boolean); virtual;
    procedure TriggerItemPreDrawEvent(Item: TElXTreeItem); virtual;

    procedure TriggerOleTargetDragEvent(State: TDragState; Source: TOleDragObject;
      Shift: TShiftState; X, Y: Integer; var DragType: TDragType); virtual;
    procedure TriggerOleTargetDropEvent(Source: TOleDragObject; Shift: TShiftState;
      X, Y: Integer; var DragType: TDragType); virtual;
    procedure TriggerOleDragStartEvent(var dataObj: IDataObject; var dropSource: IDropSource;
      var dwOKEffects: TDragTypes); virtual;
    procedure TriggerOleDragFinishEvent(dwEffect: TDragType; Result: HResult); virtual;
    function GetTopItem: TElXTreeItem; virtual;
    procedure SetTopItem(Item: TElXTreeItem); virtual;
    procedure Loaded; override;
    function SectionTypeToSortType(SectionType: TElFieldType): TSortTypes;
    procedure TriggerSortBegin; virtual;
    procedure TriggerSortEnd; virtual;
    function CreateView: TElXTreeView; virtual;
    procedure CreateWnd; override;
    procedure StartDelayedFocus(FocusItemToReport: TElXTreeItem);
    procedure StopDelayedFocus;
    procedure OnDelayTimer(Sender: TObject);
    procedure DoAfterSelectionChange; virtual;
    procedure SetDragRectAcceptColor(const Value: TColor);
    procedure SetDragRectDenyColor(Value: TColor);
    procedure SetDragTrgDrawMode(Value: TDragTargetDraw);
    procedure SetAdjustInplaceEditorPosition(aValue: boolean);

    function GetVisibleRowCount: Integer;
    procedure DoSetDragTrgDrawMode(Value: TDragTargetDraw; RedrawItem: Boolean);
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure UpdateDiffItems;
    procedure UpdateAllItems;
    procedure SlowCompareItems(Item1, Item2: TElXTreeItem; Section :
        TElHeaderSection; var Result: Integer);
    procedure TriggerVirtualPropsNeeded(Item: TElXTreeItem;
        PropTypes: TElVirtPropTypes; Value: TElXTreeItemStaticDataEx);
    procedure TriggerVirtualHintNeeded(Item: TElXTreeItem; var Hint: TLMDString);
        virtual;
    procedure TriggerVirtualValueNeeded(Item: TElXTreeItem; SectionIndex: Integer;
        VarType: Integer; var Value: Variant); virtual;

    procedure TriggerTryEditEvent(Item: TElXTreeItem; SectionIndex: Integer;
      var CellType: TElFieldType; var CanEdit: Boolean); virtual;
    procedure TriggerInplaceEditorNeeded(Item: TElXTreeItem; SectionIndex: Integer;
        SupposedFieldType: TElFieldType; var Editor: TElTreeInplaceEditor);
        virtual;
    function CreateInplaceManager: TElTreeInplaceManager; virtual;

    procedure DoEndEditItem(Item: TElXTreeItem; Section: TElHeaderSection; Canceled: Boolean); virtual;

    procedure VertScrollHitTestTransfer(Sender: TObject; X, Y: Integer;
      var Part: TElScrollBarPart; var DefaultTest: Boolean); virtual;
    procedure HorzScrollHitTestTransfer(Sender: TObject; X, Y: Integer;
      var Part: TElScrollBarPart; var DefaultTest: Boolean); virtual;
    procedure SetVertDivLinesColor(Value: TColor);
    procedure SetCheckBoxSize(Value: Integer);
    function GetTrackItem: TElXTreeItem;
    function GetDragging: Boolean;
    procedure SetShowLeafButton(Value: Boolean);
    procedure SetLeafPicture(Value: TBitmap);
    procedure MouseWheelTransfer(Sender: TObject; Shift: TShiftState; WheelDelta:
        Integer; MousePos: TPoint; var Handled: Boolean);
    procedure MouseWheelDownTransfer(Sender: TObject; Shift: TShiftState;
        MousePos: TPoint; var Handled: Boolean);
    procedure MouseWheelUpTransfer(Sender: TObject; Shift: TShiftState; MousePos:
        TPoint; var Handled: Boolean);
    procedure FitMostChildren(Item: TElXTreeItem);
    // function GetThemedClassName: TLMDThemedItem; override;
    procedure SetUseXPThemes(const Value: Boolean); override;
    procedure SetThemeGlobalMode(const Value: Boolean);override;
    procedure SetThemeMode(const Value: TLMDThemeMode);override;
    function GetCheckBoxSize: Integer;
    function GetHeaderPopupMenu: TPopupMenu;
    procedure SetHeaderPopupMenu(Value: TPopupMenu);
    procedure SetHeaderFont(Value: TFont);
    procedure SetHeaderUseTreeFont(Value: Boolean);
    procedure HeaderFontChanged(Sender: TObject);
    function IsStripedColorStored: Boolean;
    function IsOwnerDrawMaskStored: Boolean;
    procedure ELThemeChanged(var Message: TMessage); message WM_THEMECHANGED;
    procedure ELSettingChange(var Message: TMessage); message EL_SETTINGCHANGE;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure SetSortUseCase(Value: Boolean);
    procedure SetLineBorderActiveColor(Value: TColor);
    procedure SetLineBorderInactiveColor(Value: TColor);
    procedure SetDblClickMode(Value: TElDblClickMode);
    function GetPlusPicture: TBitmap;
    function GetLeafPicture: TBitmap;
    function GetMinusPicture: TBitmap;
    function GetCheckBoxGlyph: TBitmap;
    function GetRadioButtonGlyph: TBitmap;
    procedure OnCheckSignChange(Sender: TObject);
    procedure WMUpdateSBFrame(var Message: TMessage); message WM_UPDATESBFRAME;
    procedure SetDoubleBuffered(Value: Boolean);
    procedure SetHighlightAlphaLevel(Value: Integer);
    procedure ReadRightAlignedTree(Reader: TReader);
    procedure DefineProperties(Filer: TFiler); override;
    procedure DataCacheAllocate;
    procedure DataCacheDeallocate;
    procedure DataCacheClear;
    procedure SetDataCacheSize(Value: Integer);
    function CreateDataCacheItem: TElXTreeItemStaticDataEx;
    procedure CacheItem(Item: TElXTreeItem; MinInCache: Integer);
    function GetIncSearchColumnText(Item: TElXTreeItem): TLMDString; virtual;
//    function GetEditorManager: TElTreeInplaceManager; override;
    procedure ResetAllItemsHeight;
    procedure ResetVisItemsHeight;
    procedure ReadScrollTracking(Reader: TReader);
    procedure ReadExpandOnDblClick(Reader: TReader);
    procedure SetBorderColorDkShadow(Value: TColor);
    procedure SetBorderColorFace(Value: TColor);
    procedure SetBorderColorHighlight(Value: TColor);
    procedure SetBorderColorShadow(Value: TColor);
    procedure SetBorderColorWindow(Value: TColor);
    procedure SetCheckBoxFlat(Value: Boolean);
    procedure SetSortColumnColor(Value: TColor);

    procedure SetCellStyle(Value:TElXCellStyle);
    function GetCellStyle:TElXCellStyle;

    property ForceAlign: boolean read FForceAlign write SetForeceAlign default false;
    property RowCheck: boolean read FRowCheck write SetRowCheck default false;
    property Style:TElXCellStyle read GetCellStyle write SetCellStyle;

//    property InSizeMove: Boolean read FInSizeMove;
    property TextColor: TColor read FTextColor write SetTextColor default clWindowText;
    property BackGroundColor: TColor read FBackGroundColor write SetBackGroundColor default clWindow;
    {+-+-+-}
    property CurTextColor: TColor read FCurTextColor write FCurTextColor;

    property ShowButtons: Boolean read FShowButtons write SetShowButtons default True;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property ShowLines: Boolean read FShowLines write SetShowLines default True;
    property ShowImages: Boolean read FShowImages write SetShowImages default True;
    property ShowRoot: Boolean read FShowRoot write SetShowRoot default False;
    property LineHintMode: THintModes read FLineHintMode write FLineHintMode default shmLong;
    property LineHintColor: TColor read FLineHintColor write FLineHintColor default clWindow;
    property HideSelection: Boolean read FHideSelection write SetHideSelection default False;
    property HideHintOnTimer: Boolean read FHideHintOnTimer write FHideHintOnTimer default False;
    property Images: TCustomImageList read FImages write SetImages;
    property Images2: TCustomImageList read FImages2 write SetImages2;
    property AlphaForImages: TCustomImageList read FAlphaForImages write SetAlphaForImages;
    property AlphaForImages2: TCustomImageList read FAlphaForImages2 write SetAlphaForImages2;

    property ChangeStateImage: Boolean read FChangeStateImage write SetChangeStateImage default False;
    property ShowColumns: Boolean read FShowColumns write SetShowColumns default False;
    property DragTrgDrawMode: TDragTargetDraw read FDragTrgDrawMode write
        SetDragTrgDrawMode default SelColorRect;
    property DraggableSections: Boolean read GetDraggableSections write SetDraggableSections default False; { Published }
    property SelectionMode: TSTSelModes read FSelectionMode write FSelectionMode default smUsual;

    property DoInplaceEdit: Boolean read FDoInplaceEdit write SetDoInplaceEdit default True;

    property VerticalLines: Boolean read FVerticalLines write SetVerticalLines default False;
    property BarStyleVerticalLines: Boolean read FBarStyleVerticalLines write SetBarStyleVerticalLines default False;
    property HorizontalLines: Boolean read FHorizontalLines write SetHorizontalLines default False;
    property HorzScrollTracking: Boolean read FHorzScrollTracking write FHorzScrollTracking default False;
    property VertScrollTracking: Boolean read FVertScrollTracking write FVertScrollTracking default False;
    property HotTrack: Boolean read FHotTrack write FHotTrack default True;
    property RowSelect: Boolean read FRowSelect write SetRowSelect default True;
//    property MultiCellSelect: Boolean read FMultiCellSelect write SetMultiCellSelect default True;
//    property MultiCellSelectStyle: TMultiCellSelectStyle read FMultiCellSelectStyle write SetMultiCellSelectStyle default [mcsControlSelect];
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelect default True;
    property MultiSelectLevel: Integer read FMultiSelectLevel write SetMultiSelectLevel default -1; // CNS
    property LineHeight: Integer read FLineHeight write SetLineHeight nodefault;
    property AutoLineHeight: Boolean read FAutoLineHeight write SetAutoLineHeight default True;
    property AutoLineVisibleOnly: Boolean read FAutoLineVisibleOnly write SetAutoLineVisibleOnly default False;
    property HeaderHotTrack: Boolean read FHeaderHotTrack write SetHeaderHotTrack default True;
    property HeaderRowCount: Integer read GetHeaderRowCount write SetHeaderRowCount default 1;
    property HeaderHeight: Integer read GetHeaderHeight write SetHeaderHeight nodefault;
    property MainTreeColumn: Integer read FMainTreeColumn write SetMainTreeColumn default 0;
    property OwnerDrawByColumn: Boolean read FOwnerDrawByColumn write FOwnerDrawByColumn default True;
    property OwnerDrawMask: TLMDString read FOwnerDrawMask write FOwnerDrawMask stored IsOwnerDrawMaskStored;
    property DragAllowed: Boolean read FDragAllowed write FDragAllowed default False;
    property SortDir: TSortDirs read FSortDir write FSortDir default sdAscend;
    property SortMode: TSortModes read FSortMode write SetSortMode default smNone; { Published }
    property SortSection: Integer read FSortSection write SetSortSection default 0; { Published }
    property SortType: TSortTypes read FSortType write FSortType default stText;
    property HideHintOnMove: Boolean read FHideHintOnMove write FHideHintOnMove default True; { Protected }
    property MoveColumnOnDrag: Boolean read GetMoveColumnOnDrag write SetMoveColumnOnDrag default False; { Published }
    property HideHorzScrollBar: Boolean read FHideHorzScrollBar write SetHideHorzScrollBar default False; { Published }
    property HideVertScrollBar: Boolean read FHideVertScrollBar write SetHideVertScrollBar default False; { Published }
    property HorzScrollBarStyles: TElScrollBarStyles read FHorzScrollBarStyle write SetHorzScrollBarStyle stored True;
    property VertScrollBarStyles: TElScrollBarStyles read FVertScrollBarStyle write SetVertScrollBarStyle stored True;

    property Background: TBitmap read FBackground write SetBackground;  { Protected }
    property BackgroundType: TLMDBackgroundType read FBackgroundType write SetBackgroundType default bgtColorFill;  { Protected }
    property HeaderImages: TCustomImageList read GetHeaderImages write SetHeaderImages; { Protected }
    property AlphaForHeaderImages: TCustomImageList read GetAlphaHeaderImages write SetAlphaHeaderImages; { Protected }
    property DragImageMode: TDragImgMode read FDragImageMode write FDragImageMode default dimNever; { Protected }
    property StoragePath: string read FStoragePath write FStoragePath;

    property Storage: TElIniFile read FStorage write SetStorage;

    property ImageForm: TElImageForm read FImageForm write SetImageForm;
    property HeaderImageForm: TElImageForm read GetHeaderImageForm write SetHeaderImageForm;

    property ShowCheckBoxes: Boolean read FShowCheckboxes write SetShowCheckboxes default False;
    property PlusPicture: TBitmap read GetPlusPicture write SetPlusPicture;
    property MinusPicture: TBitmap read GetMinusPicture write SetMinusPicture;
    property CustomPlusMinus: Boolean read FCustomPlusMinus write SetCustomPlusMinus default False;
    property SelectColumn: Integer read FSelectColumn write SetSelectColumn default -1;
    property AutoExpand: Boolean read FAutoExpand write SetAutoExpand default False;
    property AutoLookup: Boolean read FAutoLookup write FAutoLookup default False;
    property DragType: TElDragType read FDragType write SetDragType default dtDelphi;
    property FullRowSelect: Boolean read FFullRowSelect write FFullRowSelect default True;
    property AlwaysKeepSelection: Boolean read FAlwaysKeepSelection write FAlwaysKeepSelection default True;
    property AlwaysKeepFocus: Boolean read FAlwaysKeepFocus write FAlwaysKeepFocus default False;
    property StickyHeaderSections: Boolean read GetStickyHeaderSections write SetStickyHeaderSections default False;
    property BarStyle: Boolean read FBarStyle write SetBarStyle default False;
    property DrawFocusRect: Boolean read FDrawFocusRect write SetDrawFocusRect default True;
    property DeselectChildrenOnCollapse: Boolean read FDeselectChildrenOnCollapse write FDeselectChildrenOnCollapse default False;
    property HorzDivLinesColor: TColor read FHorzDivLinesColor write
        SetHorzDivLinesColor default clBtnFace;
    property LinesColor: TColor read FLinesColor write SetLinesColor default clBtnFace;
    property LinesStyle: TPenStyle read FLinesStyle write SetLinesStyle default psDot;
    property PathSeparator: Char read FPathSeparator write FPathSeparator default '\'; { Protected }
    property RightAlignedView: Boolean read FRightAlignedView write SetRightAlignedView default False;
    property Flat: Boolean read FFlat write SetFlat default False; { Protected }
    property RightAlignedText: Boolean read FRightAlignedText write SetRightAlignedText default False;
    property FilteredVisibility: Boolean read FFilteredVisibility write SetFilteredVisibility default False;
    property UnderlineTracked: Boolean read FUnderlineTracked write SetUnderlineTracked default True; { Published }
    property CustomCheckboxes: Boolean read FCustomCheckboxes write SetCustomCheckboxes default False; { Published }
    property CheckBoxGlyph: TBitmap read GetCheckBoxGlyph write SetCheckBoxGlyph;
    property RadioButtonGlyph: TBitmap read GetRadioButtonGlyph write
        SetRadioButtonGlyph;
    property ScrollbarOpposite: Boolean read FScrollbarOpposite write SetScrollbarOpposite default False;
    property ShowRootButtons: Boolean read FShowRootButtons write SetShowRootButtons default True;
    property ShowEmptyImages: Boolean read FShowEmptyImages write SetShowEmptyImages default False;
    property ShowEmptyImages2: Boolean read FShowEmptyImages2 write SetShowEmptyImages2 default False;

    property LockHeaderHeight: Boolean read GetLockHeaderHeight write SetLockHeaderHeight default False; { Protected }
    property AutoResizeColumns: Boolean read FAutoResizeColumns write FAutoResizeColumns default True;  { Protected }
    property HeaderActiveFilterColor: TColor read GetHeaderActiveFilterColor write SetHeaderActiveFilterColor default clBlack;
    property HeaderFilterColor: TColor read GetHeaderFilterColor write SetHeaderFilterColor default clBtnText;
    property HeaderFlat: Boolean read GetHeaderFlat write SetHeaderFlat default False;

    property HeaderWrapCaptions: Boolean read GetHeaderWrapCaptions write SetHeaderWrapCaptions default False;

    property FlatFocusedScrollbars: Boolean read FFlatFocusedScrollbars write SetFlatFocusedScrollbars default True;  { Protected }
    property HideSelectColor: TColor read FHideSelectColor write SetHideSelectColor default clBtnFace;
    property FocusedSelectColor: TColor read FFocusedSelectColor write SetFocusedSelectColor default clHighlight;
    property FocusedSelectTextColor: TColor read FFocusedSelectTextColor write SetFocusedSelectTextColor default clHighlightText;
    property HideSelectTextColor: TColor read FHideSelectTextColor write SetHideSelectTextColor default clBtnShadow;

    property UseCustomScrollBars: Boolean read FUseCustomScrollBars write SetUseCustomScrollBars default True;

    property RowHotTrack: Boolean read FRowHotTrack write SetRowHotTrack default False;  { Protected }
    property ActiveBorderType: TElFlatBorderType read FActiveBorderType write SetActiveBorderType default fbtSunken;  { Protected }
    property InactiveBorderType: TElFlatBorderType read FInactiveBorderType write SetInactiveBorderType default fbtSunkenOuter;  { Protected }
    property ItemIndent: Integer read FItemIndent write SetItemIndent default 17;

    property GradientStartColor: TColor read FGradientStartColor write SetGradientStartColor default clBlack;  { Protected }
    property GradientEndColor: TColor read FGradientEndColor write SetGradientEndColor  default clBlack;  { Protected }
    property GradientSteps: Integer read FGradientSteps write SetGradientSteps default 64;  { Protected }

    property Cursor: TCursor read GetCursor write SetCursor default crDefault;
    property HeaderInvertSortArrows: Boolean read GetHeaderInvertSortArrows write SetHeaderInvertSortArrows default False;  { Protected }
    property MoveFocusOnCollapse: Boolean read FMoveFocusOnCollapse write SetMoveFocusOnCollapse default False;  { Protected }
    property ForcedScrollBars: TScrollStyle read FForcedScrollBars write SetForcedScrollBars default ssNone;  { Protected }
    property PlusMinusTransparent: Boolean read FPlusMinusTransparent write SetPlusMinusTransparent default False;
    property Hint: TLMDString read GetHint write SetHint;
    property DragRectAcceptColor: TColor read FDragRectAcceptColor write
        SetDragRectAcceptColor default clGreen;
    property DragRectDenyColor: TColor read FDragRectDenyColor write
        SetDragRectDenyColor default clRed;
    property DragExpandDelay: Integer read FDragExpandDelay write FDragExpandDelay
        default 500;
    property IncrementalSearchTimeout: Integer read FIncrementalSearchTimeout write FIncrementalSearchTimeout default 500;
    property IncrementalSearch: Boolean read FIncrementalSearch write
        FIncrementalSearch default False;
    property IncrementalSearchSelectItem: Boolean read FIncrementalSearchSelectItem write FIncrementalSearchSelectItem default false;
    property AdjustMultilineHeight: Boolean read FAdjustMultilineHeight write SetAdjustMultilineHeight default True;  { Protected }
    property ExpandOnDragOver: Boolean read FExpandOnDragOver write FExpandOnDragOver default False;  { Protected }
    property DragCursor: TCursor read GetDragCursor write SetDragCursor default crDrag;

    property UseSystemHintColors: Boolean read FUseSystemHintColors write FUseSystemHintColors default False;  { Protected }
    property HeaderColor: TColor read GetHeaderColor write SetHeaderColor default clBtnFace;
    property ChangeDelay: Integer read FChangeDelay write FChangeDelay default 500;
    property RightClickSelect: Boolean read FRightClickSelect write
        FRightClickSelect default True;
    property StripedOddColor: TColor read FStripedOddColor write SetStripedOddColor stored IsStripedColorStored;
    property StripedEvenColor: TColor read FStripedEvenColor write SetStripedEvenColor stored IsStripedColorStored;
    property StripedItems: Boolean read FStripedItems write SetStripedItems default False;

    property OnInplaceEditorNeeded: TInplaceEditorNeededXEvent read
        FOnInplaceEditorNeeded write FOnInplaceEditorNeeded;

    property QuickEditMode: Boolean read FQuickEditMode write FQuickEditMode
        default False;
    property MainTextType: TElFieldType read FMainTextType write FMainTextType
        default sftText;
    property HintType: TElHintType read FHintType write FHintType
        default shtHintOrText;
    property OnVertScrollHitTest: TElScrollHitTestEvent read FOnVertScrollHitTest
        write FOnVertScrollHitTest;
    property OnHorzScrollHitTest: TElScrollHitTestEvent read FOnHorzScrollHitTest
        write FOnHorzScrollHitTest;
    property MouseFrameVisible: Boolean read FMouseFrameVisible write
        FMouseFrameVisible default True;
    property MouseFrameSelect: Boolean read FMouseFrameSelect write
        FMouseFrameSelect default True;
    property VertDivLinesColor: TColor read FVertDivLinesColor write
        SetVertDivLinesColor default clBtnFace;

    property AdjustInplaceEditorPosition: boolean read FAdjustInplaceEditorPosition write SetAdjustInplaceEditorPosition;

    property OnItemChange: TElXOnItemChangeEvent read FOnItemChange write FOnItemChange;
    property OnCellChange: TElXOnCellChangeEvent read FOnCellChange write FOnCellChange;
    property OnItemDraw: TElXOnItemDrawEvent read FOnItemDraw write FOnItemDraw;
    property OnCellDraw: TElXOnCellDrawEvent read FOnCellDraw write FOnCellDraw;
    property OnItemChecked: TElXOnItemCheckedEvent read FOnItemChecked write FOnItemChecked;
    property OnItemCheckStateChanging: TElXOnItemCheckStateChangingEvent read FOnItemCheckStateChanging write FOnItemCheckStateChanging;
    property OnItemExpand: TElXOnItemExpandEvent read FOnItemExpand write FOnItemExpand;
    property OnItemCollapse: TElXOnItemExpandEvent read FOnItemCollapse write FOnItemCollapse;
    property OnItemExpanding: TElXOnItemExpanding read FOnItemExpanding write FOnItemExpanding;
    property OnItemCollapsing: TElXOnItemExpanding read FOnItemCollapsing write FOnItemCollapsing;
    property OnScroll: TElXScrollEvent read FOnScroll write FOnScroll;
    property OnItemDeletion: TElXOnItemExpandEvent read FOnItemDelete write FOnItemDelete;
    property OnItemCreated: TElXOnItemExpandEvent read FOnItemCreated write FOnItemCreated;
    property OnCellDeletion: TElXCellEvent read FOnCellDeletion write FOnCellDeletion;
    property OnChanging: TElXTreeChangingEvent read FOnChanging write FOnChanging;
    property OnItemFocused: TNotifyEvent read FOnItemFocused write FOnItemFocused;
    property OnShowLineHint: TElXOnShowHintEvent read FOnShowHint write FOnShowHint;
    property OnCompareItems: TElXOnCompareItems read FOnCompareItems write FOnCompareItems;
    property OnItemPicDraw: TElXOnPicDrawEvent read FOnItemPicDraw write FOnItemPicDraw;
    property OnItemPicDraw2: TElXOnPicDrawEvent read FOnItemPicDraw2 write FOnItemPicDraw2;
    property OnCellPicDraw: TElXOnCellPicDrawEvent read FOnCellPicDraw write FOnCellPicDraw;
    property OnHotTrack: TElXHotTrackEvent read FOnHotTrack write FOnHotTrack;

    property OnCanDrag: TElXCanDragEvent read GetCanDrag write SetCanDrag;

    property OnTryEdit: TElXTryEditEvent read FOnTryEdit write FOnTryEdit;

    property OnEndEditItem: TElXOnEndEditEvent read FOnEndEdit write FOnEndEdit;

    property OnItemSave: TElXItemSaveEvent read FOnItemSave write FOnItemSave;
    property OnItemLoad: TElXItemSaveEvent read FOnItemLoad write FOnItemLoad;
    property OnItemSelectedChange: TElXItemSelChangeEvent read FOnItemSelectedChange write FOnItemSelectedChange;
    property OnCellStyleSave: TElXCellStyleSaveEvent read FOnSave write FOnSave;
    property OnCellStyleLoad: TElXCellStyleSaveEvent read FOnLoad write FOnLoad;
    property OnSortBegin: TNotifyEvent read FOnSortBegin write FOnSortBegin;
    property OnSortEnd: TNotifyEvent read FOnSortEnd write FOnSortEnd;

    property OnHeaderResize: TNotifyEvent read FOnHeaderResize write FOnHeaderResize;
    property OnHeaderLookup: TElHeaderLookupEvent read FOnHeaderLookup write FOnHeaderLookup;
    property OnHeaderLookupDone: TElHeaderLookupDoneEvent read FOnHeaderLookupDone write FOnHeaderLookupDone;
    property OnHeaderSectionExpand: TElXHeaderSectionEvent read FOnHeaderSectionExpand write FOnHeaderSectionExpand;
    property OnHeaderSectionCollapse: TElXHeaderSectionEvent read FOnHeaderSectionCollapse write FOnHeaderSectionCollapse;
    property OnHeaderSectionAutoSize: TColumnNotifyEvent read FOnSectionAutoSize write FOnSectionAutoSize;
    property OnHeaderColumnResize: TColumnNotifyEvent read FOnColumnResize write FOnColumnResize;
    property OnHeaderColumnClick: TColumnNotifyEvent read FOnColumnClick write FOnColumnClick;
    property OnHeaderColumnMove: TElXColumnMoveEvent read FOnHeaderColumnMove write FOnHeaderColumnMove;
    property OnHeaderColumnDraw: TElXSectionRedrawEvent read FOnColumnDraw write FOnColumnDraw;
    property OnHeaderSectionFilterCall: TColumnNotifyEvent read FOnSectionFilterCall write FOnSectionFilterCall;
    property OnHeaderSectionMeasure: TMeasureSectionEvent read FOnHeaderSectionMeasure write FOnHeaderSectionMeasure;
    property OnHeaderSectionCellClick: TElXHeaderSectionCellEvent read FOnHeaderSectionCellClick write FOnHeaderSectionCellClick;
    property OnApplyVisFilter: TElXApplyVisFilterEvent read FOnApplyVisFilter write FOnApplyVisFilter;
    property OnItemPostDraw: TElXTreeItemPostDrawEvent read FOnItemPostDraw write FOnItemPostDraw;
    property OnMeasureItemPart: TElXMeasureItemPartEvent read FOnMeasureItemPart write FOnMeasureItemPart;

    property OnHTMLImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnHTMLImageNeededEx: TLMDHTMLImageNeededEvent read FOnImageNeededEx write FOnImageNeededEx;
    property OnAdjustControlPosition: TLMDHTMLControlPositionNeededEvent read FOnAdjustControlPosition write FOnAdjustControlPosition;
    property OnControlCreated: TLMDHTMLControlCreatedEvent read FOnControlCreated write FOnControlCreated;
    property OnTagFound: TLMDHTMLTagFoundEvent read FOnTagFound write FOnTagFound;


    property OnLinkClick: TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnLinkOver : TElHTMLLinkOverEvent read FOnLinkOver write FOnLinkOver;
    property LinkCursor: TCursor read FLinkCursor write FLinkCursor default crHandPoint;

    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnDragDrop: TDragDropEvent read FOnDrop write FOnDrop;
    property OnDragOver: TDragOverEvent read FOnOver write FOnOver;
    //property OnEndDrag: TEndDragEvent read FOnDrag write FOnDrag;
    property OnEnter: TNotifyEvent read FOnEnter write FOnEnter;
    property OnExit: TNotifyEvent read FOnExit write FOnExit;
    property OnKeyDown: TKeyEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyPress: Tkeypressevent read FOnKeyPress write FOnKeyPress;
    property OnKeyUp: TKeyEvent read FOnKeyUp write FOnKeyUp;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnStartDrag: TStartDragEvent read FOnStartDrag write FOnStartDrag;

    property OnOleTargetDrag: TTargetDragEvent read FOnOleTargetDrag write FOnOleTargetDrag;
    property OnOleTargetDrop: TTargetDropEvent read FOnOleTargetDrop write FOnOleTargetDrop;
    property OnOleDragStart: TElXOleDragStartEvent read FOnOleDragStart write FOnOleDragStart;
    property OnOleDragFinish: TElXOleDragFinishEvent read FOnOleDragFinish write FOnOleDragFinish;

    property OnHorzScrollDrawPart: TElScrollDrawPartEvent read FOnHorzScrollDrawPart write FOnHorzScrollDrawPart;
    property OnHorzScrollHintNeeded: TElScrollHintNeededEvent read FOnHorzScrollHintNeeded write FOnHorzScrollHintNeeded;
    property OnVertScrollDrawPart: TElScrollDrawPartEvent read FOnVertScrollDrawPart write FOnVertScrollDrawPart;
    property OnVertScrollHintNeeded: TElScrollHintNeededEvent read FOnVertScrollHintNeeded write FOnVertScrollHintNeeded;

    property OnHeaderMouseDown: TMouseEvent read FOnHeaderMouseDown write
        FOnHeaderMouseDown;
    property OnAfterSelectionChange: TNotifyEvent read FOnAfterSelectionChange
        write FOnAfterSelectionChange;
    property OnItemPreDraw: TElXOnItemExpandEvent read FOnItemPreDraw write
        FOnItemPreDraw;
    property OnDragTargetChange: TElXTreeItemDragTargetEvent read
        FOnDragTargetChange write FOnDragTargetChange;
    property LineHintTimeout: Integer read FLineHintTimeout write
        SetLineHintTimeout default 3000;
    property VerticalLinesLong: Boolean read FVerticalLinesLong write
        SetVerticalLinesLong default True;
    property DefaultSectionWidth: Integer read GetDefaultSectionWidth write
        SetDefaultSectionWidth default DefaultHeaderSectionWidth;
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides default [ebsLeft, ebsRight, ebsTop, ebsBottom];
    property LineHintType: TLineHintType read FLineHintType write FLineHintType
        default lhtSmart;
    property OnVirtualPropsNeeded: TElXVirtualPropsNeededEvent read FOnVirtualPropsNeeded write FOnVirtualPropsNeeded;
    property OnVirtualTextNeeded: TElXVirtualTextNeededEvent read FOnVirtualTextNeeded
        write FOnVirtualTextNeeded;
    property OnUserCellTextNeeded: TElXVirtualTextNeededEvent read FOnUserCellTextNeeded
        write FOnUserCellTextNeeded;
    property VirtualityLevel: TVirtualityLevel read FVirtualityLevel write
        SetVirtualityLevel default vlNone;
    property OnVirtualHintNeeded: TElXVirtualHintNeededEvent read FOnVirtualHintNeeded
        write FOnVirtualHintNeeded;
    property OnVirtualValueNeeded: TElXVirtualValueNeededEvent read
        FOnVirtualValueNeeded write FOnVirtualValueNeeded;
    property OnVirtualStyleNeeded: TElXVirtualStyleNeededEvent read
        FOnVirtualStyleNeeded write FOnVirtualStyleNeeded;
    property CheckBoxSize: Integer read GetCheckBoxSize write SetCheckBoxSize
        default 15;
    property DragScrollInterval: Integer read FDragScrollInterval write
        FDragScrollInterval default 100;
    property ShowLeafButton: Boolean read FShowLeafButton write SetShowLeafButton;
    property LeafPicture: TBitmap read GetLeafPicture write SetLeafPicture;
    property ExplorerEditMode: Boolean read FExplorerEditMode write
        FExplorerEditMode default False;
    property IgnoreEnabled: Boolean read FIgnoreEnabled write FIgnoreEnabled default False;

    property InplaceEditorDelay: Integer read FInplaceEditorDelay write
        FInplaceEditorDelay default 500;
    property HeaderFont: TFont read FHeaderFont write SetHeaderFont stored IsHeaderFontStored;
    property HeaderUseTreeFont: Boolean read FHeaderUseTreeFont write
        SetHeaderUseTreeFont default True;
    property KeepSelectionWithinLevel: Boolean read FKeepSelectionWithinLevel write
        FKeepSelectionWithinLevel default False;
    property AutoCollapse: Boolean read FAutoCollapse write FAutoCollapse default
        False;
    property SortUseCase: Boolean read FSortUseCase write SetSortUseCase default
        True;
    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor default clBlack;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor default clBlack;
    property DblClickMode: TElDblClickMode read FDblClickMode write SetDblClickMode
        default dcmExpand;
{$ifdef HOTTRACK_CURSOR}
    property TrackingCursor: TCursor read FTrackingCursor write FTrackingCursor default crDefault;
{$endif}

    property HighlightAlphaLevel: Integer read FHighlightAlphaLevel write
        SetHighlightAlphaLevel default 255;

    property DataCacheSize: Integer read FDataCacheSize write SetDataCacheSize
        default 200;
    property IncrementalSearchScope: TElIncSearchScope read FIncrementalSearchScope
        write FIncrementalSearchScope default issWholeTree;
    property IncrementalSearchColumn: TElIncSearchColumn read
        FIncrementalSearchColumn write FIncrementalSearchColumn default iscMainText;
    property CheckBoxFlat: Boolean read FCheckBoxFlat write SetCheckBoxFlat default
        False;
    property HorzArrowsScroll: Boolean read FHorzArrowsScroll write
        FHorzArrowsScroll default False;
    property SortColumnColor: TColor read FSortColumnColor write SetSortColumnColor default clNone;
    property FixedTopRowNum: Integer read FFixedTopRowNum write SetFixedTopRowNum;
    property FixedBottomRowNum: Integer read FFixedBottomRowNum write SetFixedBottomRowNum;
    property FixedBottomRowsHeight: Integer read GetFixedBottomRowsHeight;
    property FixedColNum: Integer read GetFixedColNum write SetFixedColNum;
    procedure CascadAutoSizeColumn(SectionIndex: Integer; NotAutoSizeOnly, VisOnly: Boolean);
    property Header: TElXTreeHeader read FHeader;
    procedure SetNotRaiseForBarStyle(value: boolean);

    property OnCtlClick: TNotifyEvent read FOnCtlClick write FOnCtlClick;
    property OnCtlDblClick: TNotifyEvent read FOnCtlDblClick write FOnCtlDblClick;
    property OnCtlMouseDown: TMouseEvent read FOnCtlMouseDown write FOnCtlMouseDown;
    property OnCtlMouseMove: TMouseMoveEvent read FOnCtlMouseMove write FOnCtlMouseMove;
    property OnCtlMouseUp: TMouseEvent read FOnCtlMouseUp write FOnCtlMouseUp;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    constructor CreateClass(AOwner: TComponent; ItemClass: TElXTreeItemClass);
    procedure DoInCreate(AOwner: TComponent);
    destructor Destroy; override;
    property Font stored IsFontStored;
    procedure Update; override;
    function SetByFullName(FullName: TLMDString; Separator: TLMDChar; StartItem: TElXTreeItem = nil): Boolean;
    procedure Assign(Source: TPersistent); override;
    procedure FullCollapse; virtual;
    procedure FullExpand; virtual;
    function CanFocus: Boolean; override;
    function GetDragImages: TDragImageList; override;
    function Focused: Boolean;  override;
    function GetItemRect(ItemIndex: Integer): TRect; virtual;
    function GetItemAtY(Y: Integer): TElXTreeItem; virtual;
    function GetItemAt(X, Y: Integer; var ItemPart: TSTXItemPart;
      var HitColumn: Integer): TElXTreeItem; virtual;
    procedure MeasureCell(Item: TElXTreeItem; ColumnNum: Integer; MaxWidth :
        Integer; var Size: TPoint); virtual;
    function GetNextSelected(Prev: TElXTreeItem): TElXTreeItem; virtual;
    function GetNextChecked(aStartItem: TElXTreeItem = nil; aIterateBackward: boolean = false; aCheckStartItem: boolean = true;
               aSubItemsOnly: boolean = false; aVisibleOnly: boolean = false; aCountCollapsed: boolean = false; aMakeFoundVisible : boolean = true; aMakeFoundSelected: boolean = true; aMakeFoundFocused: boolean = true): TElXTreeItem;
    function GetCheckedCount(aStartItem: TElXTreeItem = nil; aCheckStartItem: boolean = true;
               aSubItemsOnly: boolean = false; aVisibleOnly: boolean = false; aCountCollapsed: boolean = false): integer;
    procedure MakeColVisible(aColIndex: integer); virtual;

    property TrackColor: TColor read FTrackColor write SetTrackColor default clHighlight;
    property LinkColor: TColor read FLinkColor write SetLinkColor default clBlue;  { Published }
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle default [fsUnderline];  { Published }
    procedure AllSelected(SelectedItems: TLMDObjectList); virtual;
    procedure SelectAll(ASelectWithCells: boolean = false); virtual;
    procedure InvertSelection; virtual;
    procedure SelectAllEx(IncludeHidden: Boolean); virtual;
    procedure InvertSelectionEx(IncludeHidden: Boolean); virtual;
    procedure DeselectAll(Notification: Boolean = true); virtual;
    procedure DeselectAllEx(IncludeHidden: Boolean); virtual;
    procedure SelectRange(FromItem, ToItem: TElXTreeItem); virtual;
    procedure SelectRange2(FromItem, ToItem: TElXTreeItem; SelectDisabled: Boolean; SelectCollapsedChildren: Boolean); virtual;
    procedure SelectRange3(FromItem, ToItem: TElXTreeItem; StartCol, EndCol: Integer; SelectDisabled: Boolean; SelectCollapsedChildren, Selected: Boolean); virtual;
    procedure SelectRangeEx(FromItem, ToItem: TElXTreeItem; IncludeHidden: Boolean); virtual;
    procedure SelectRangeEx2(FromItem, ToItem: TElXTreeItem; IncludeHidden, SelectDisabled, SelectCollapsedChildren: Boolean); virtual;
    procedure SelectRangeEx3(FromItem, ToItem: TElXTreeItem; StartCol, EndCol: Integer; IncludeHidden, SelectDisabled, SelectCollapsedChildren, Selected: Boolean); virtual;
    procedure Sort(recursive: Boolean); virtual;

    procedure Save; virtual;
    procedure Restore; virtual;

    procedure EnsureVisible(Item: TElXTreeItem);
    procedure EnsureVisibleBottom(Item: TElXTreeItem);
    procedure EnsureVisibleEx(Item: TElXTreeItem; Expande: Boolean);
    procedure EnsureVisibleBottomEx(Item: TElXTreeItem; Expande: Boolean);

    function IsEditing: Boolean;
    procedure EditItem(Item: TElXTreeItem; SectionNum: Integer); virtual;
    procedure EndEdit(ByCancel: Boolean);

    procedure SaveStringsToStream(Stream: TStream); virtual;
    function GetNodeAt(X, Y: Integer): TElXTreeItem;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    function IsInView(Item: TElXTreeItem): Boolean; virtual;
    function MeasureColumnWidth(ColumnNum: Integer; VisibleOnly: Boolean): Integer;virtual;
    function IndexInView(Item: TElXTreeItem): Integer;
    procedure AllSelectedEx(SelectedItems: TLMDObjectList; Order: Boolean);
    procedure AddSortSection(Index: Integer; ReSort: Boolean);
    procedure RemoveSortSection(Index: Integer; ReSort: Boolean);
    procedure ClearSortList(ReSort: Boolean);
    procedure AutoSizeAllColumns;
    procedure AutoSizeColumn(SectionIndex: Integer);

    procedure AutoSizeAllColumnsEx(VisibleOnly: Boolean);
    procedure AutoSizeColumnEx(SectionIndex: Integer; VisibleOnly: Boolean);

    // procedure SetColumnBestWidth(ColumnNum: Integer; VisibleOnly: Boolean)

    function MeasureCellText(Item: TElXTreeItem; ColumnNum: Integer; MaxWidth :
        Integer; var Size: TPoint): Boolean; virtual;
    procedure ResetUpdateCounter;
    procedure TriggerVirtualStyleNeeded(Item: TElXTreeItem; SectionIndex: Integer;
        Style: TElXCellStyle); virtual;
    procedure TriggerVirtualTextNeeded(Item: TElXTreeItem; SectionIndex: Integer;
        var Text: TLMDString); virtual;

    procedure TriggerUserCellTextNeeded(Item: TElXTreeItem; SectionIndex: Integer;
        var Text: TLMDString); virtual;

    function GetHTMLControlByName(aControlName: TLMDString): TControl;

    property SortSections: TLMDObjectList read FSortSections;
    property HideFocusRect: Boolean read FHideFocusRect write SetHideFocusRect default False;
    property GutterWidth: Integer read GetGutterWidth write SetGutterWidth;
    property GutterText: TLMDString read GetGutterText write SetGutterText;
    property ColumnSizeUpdate: Boolean read FColumnSizeUpdate write FColumnSizeUpdate;
    property TopIndex: Integer read FTopIndex write SetTopIndex;
    property UpdateCount: Integer read FUpdateCount;
    property MouseOver: Boolean read FMouseOver;

    property BottomIndex: Integer read FBottomIndex;
    property IsUpdating: Boolean read GetUpdating write SetUpdating;
    property Items: TElXTreeItems read FItems write SetItems;
    property ItemFocused: TElXTreeItem read GetFocused write SetFocused;
    property SelectedCount: Integer read GetSelCount;
    property FireFocusEvents: Boolean read GetFireFocusEvents write SetFireFocusEvents default True;

    property Selected: TElXTreeItem read GetSelected write SetSelected;
    property HitColumn: integer read GetHitColumn;
    property TopItem: TElXTreeitem read GetTopItem write SetTopItem;
    property DragObject: TDragObject read FDragObject;
    property View: TElXTreeView read FView;
    property HorzScrollBarVisible: Boolean read FHorzScrollBarVisible;
    property VertScrollBarVisible: Boolean read FVertScrollBarVisible;

    property VisibleRowCount: Integer read GetVisibleRowCount;

    property DropTarget: TElXTreeItem read GetDropTarget;
    property HScrollBar: TElScrollBar read FHScrollBar;  (*<+>*)
    property VScrollBar: TElScrollBar read FVScrollBar;  (*<+>*)
    property TrackItem: TElXTreeItem read GetTrackItem;

    property SortSectionToCompare: Integer read FSortSectionToCompare;
    property CurBackGroundColor: TColor read FCurBackGroundColor {+-+-+-} write FCurBackGroundColor;
    property HeaderSections: TElXHeaderSections read GetHeaderSections write SetHeaderSections;
    property BarStyleNotRaise: Boolean read FNotRaiseForBarStyle write SetNotRaiseForBarStyle default false;
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes;
    property UseThemeForSelection: Boolean read FUseThemeForSelection write SetUseThemeForSelection default false;
  published
    property LeftPosition: Integer read FLeftPosition write SetLeftPosition default 0;
    property PlusPosition: TLMDVerticalAlign read GetPlusPosition write SetPlusPosition default vaTop;
    property BevelKind: TBevelKind read FBevelKindDummy write FBevelKindDummy stored False default bkNone;

    property HeaderPopupMenu: TPopupMenu read GetHeaderPopupMenu write
        SetHeaderPopupMenu;
    property DoubleBuffered: Boolean read FDoubleBuffered write SetDoubleBuffered
        default True;
    property DoubleBufferedOnResize: Boolean read FDoubleBufferedOnResize write
        FDoubleBufferedOnResize default True;
    property BorderColorDkShadow: TColor read FBorderColorDkShadow write
        SetBorderColorDkShadow default cl3DDkShadow;
    property BorderColorFace: TColor read FBorderColorFace write SetBorderColorFace
        default clBtnFace;
    property BorderColorHighlight: TColor read FBorderColorHighlight write
        SetBorderColorHighlight default clBtnHighlight;
    property BorderColorShadow: TColor read FBorderColorShadow write
        SetBorderColorShadow default clBtnShadow;
    property BorderColorWindow: TColor read FBorderColorWindow write
        SetBorderColorWindow default clBtnFace;
  end;

  TElXTree = class(TCustomElXTree)
  public
    property UpdateCount;
    property UseXPThemes;
  published
    property ForceAlign;
    property UseThemeForSelection;
    property OnCanDrag;
    property Header;
    property ActiveBorderType;
    property DragCursor;
    property Align;
    property AlwaysKeepFocus;
    property AlwaysKeepSelection;
    property AutoCollapse;
    property AutoExpand;
    property AutoLineHeight;
    property AutoLineVisibleOnly;
    property AutoLookup;
    property AutoResizeColumns;

    property Anchors;
    property Constraints;
    property Style; //vb
    property DockOrientation default doNoOrient;
    property Floating;
    property BevelKind;
    property DoubleBuffered;
    property DragKind;
    property DefaultSectionWidth;

    property AdjustMultilineHeight;
    property Background;
    property BackgroundType;

    property BarStyle;
    property BarStyleNotRaise;
    property BarStyleVerticalLines;
    property BorderStyle;
    property BorderSides;
    property ChangeDelay;
    property ChangeStateImage;
    property CheckBoxFlat;
    property CheckBoxGlyph;
    property CheckBoxSize;
    property Ctl3D;
    // here is fine
    property Color;
    property Cursor;
    property CustomCheckboxes;
    property CustomPlusMinus;
    property DeselectChildrenOnCollapse;
    property DblClickMode;
    property DoInplaceEdit;
    property DragAllowed;

    property DragExpandDelay;
    property DraggableSections;
    property DrawFocusRect;
    property DragImageMode;
    property DragRectAcceptColor;
    property DragRectDenyColor;
    property DragScrollInterval;
    property DragTrgDrawMode;
    property DragType;

    property Enabled;
    property ExpandOnDragOver;
    property ExplorerEditMode;
    property FilteredVisibility;
    property Flat;
    property FlatFocusedScrollbars;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property ForcedScrollBars;
    property Font stored IsFontStored;
    property FullRowSelect;

    property GradientStartColor;
    property GradientEndColor;
    property GradientSteps;

    property HeaderActiveFilterColor;
    property HeaderColor;
    property HeaderHeight;
    property HeaderRowCount;
    property HeaderHotTrack;
    property HeaderInvertSortArrows;
    property HeaderSections;
    property HeaderFilterColor;
    property HeaderFlat;
    property HeaderFont;
    property HeaderUseTreeFont;
    property HeaderImages;
    property AlphaForHeaderImages;

    property HeaderWrapCaptions;

    property HideFocusRect;
    property HideHintOnTimer;
    property HideHintOnMove;
    property HideSelectColor;
    property HideSelectTextColor;
    property HideSelection;

    property HighlightAlphaLevel;

    property HorizontalLines;
    property HideHorzScrollBar;
    property HideVertScrollBar;
    property Hint;
    property HintType;
    property HorzArrowsScroll;
    property HorzDivLinesColor;
    property HorzScrollBarStyles;
    property IgnoreEnabled;

    property HeaderImageForm;
    property ImageForm;

    property Images;
    property Images2;
    property AlphaForImages;
    property AlphaForImages2;
    property InactiveBorderType;
    property IncrementalSearch;
    property IncrementalSearchScope;
    property IncrementalSearchColumn;
    property IncrementalSearchTimeout;
    property IncrementalSearchSelectItem;
    property InplaceEditorDelay;
    property ItemIndent;
    property Items;
    property KeepSelectionWithinLevel;
    property LeafPicture;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property LineHeight;
    property LinesColor;
    property LinesStyle;
    property LineHintColor;
    property LineHintMode default shmLong;
    property LineHintTimeout;
    property LineHintType;
    property LockHeaderHeight;
    property MainTextType;
    property MainTreeColumn;
    property MinusPicture;
    property MoveColumnOnDrag;
    property MoveFocusOnCollapse;
    property MouseFrameSelect;
    property MouseFrameVisible;
//    property MultiCellSelect;
//    property MultiCellSelectStyle;
    property MultiSelect;
    property MultiSelectLevel;
    property OwnerDrawByColumn default True;
    property OwnerDrawMask;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PathSeparator;
    property PlusMinusTransparent;
    property PlusPicture;
    property PopupMenu;
    property QuickEditMode;

    property RadioButtonGlyph;
    property RightAlignedText;
    property RightAlignedView;
    property RightClickSelect;
    property RowCheck;
    property RowHotTrack;
    property RowSelect;
    property ScrollbarOpposite;
    property HorzScrollTracking;
    property VertScrollTracking;
    property SelectColumn;
    property ShowButtons;
    property ShowColumns;
    property ShowCheckBoxes;
    property ShowEmptyImages;
    property ShowEmptyImages2;
    property ShowHint;
    property ShowImages;
    property ShowLeafButton;
    property ShowLines;
    property ShowRoot;
    property ShowRootButtons;
    property SelectionMode;
    property SortColumnColor;
    property SortDir;
    property SortMode;
    property SortSection;
    property SortType;

    property Storage;
    property StoragePath;

    property SortUseCase;
    property StickyHeaderSections;
    property StripedOddColor;
    property StripedEvenColor;
    property StripedItems;

    property TabOrder;
    property TabStop;
    property HotTrack;
    property TrackColor;
    property UnderlineTracked;
    property UseCustomScrollBars;

    property VertDivLinesColor;
    property VerticalLines;
    property VerticalLinesLong;
    property VertScrollBarStyles;
    property VirtualityLevel;
    property Visible;
    property UseSystemHintColors;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;

//    property InSizeMove;
    property TextColor;
    property BackGroundColor;

    property OnScroll;
    property OnHeaderColumnClick;
    property OnHeaderColumnDraw;
    property OnHeaderColumnResize;
    property OnHeaderColumnMove;
    property OnHeaderLookup;
    property OnHeaderLookupDone;
    property OnHeaderResize;
    property OnHeaderSectionExpand;
    property OnHeaderSectionCollapse;
    property OnHeaderSectionFilterCall;
    property OnHeaderSectionAutoSize;
    property OnHeaderSectionMeasure;
    property OnHeaderSectionCellClick;

    property OnHorzScrollDrawPart;
    property OnHorzScrollHintNeeded;

    property OnEditKeyDown;
    property OnAfterSelectionChange;
    property OnApplyVisFilter;
    property OnChanging;
    property OnDragTargetChange;
    property OnItemChange;
    property OnCellChange;
    property OnItemPreDraw;
    property OnItemDraw;
    property OnCellDraw;
    property OnResize;

    property OnTryEdit;
    property OnInplaceEditorNeeded;
    property OnEndEditItem;

    property OnItemChecked;
    property OnItemCheckStateChanging;
    property OnItemExpand;
    property OnItemCollapse;
    property OnItemExpanding;
    property OnItemCollapsing;
    property OnItemDeletion;
    property OnItemCreated;
    property OnItemFocused;
    property OnShowLineHint;
    property OnCompareItems;
    property OnItemPicDraw;
    property OnItemPicDraw2;
    property OnCellPicDraw;
    property OnItemPostDraw;
    property OnHotTrack;
    property OnMeasureItemPart;
    property OnSortBegin;
    property OnSortEnd;
    property OnItemSave;
    property OnItemLoad;
    property OnItemSelectedChange;
    property OnCellStyleSave;
    property OnCellStyleLoad;
    property OnCellDeletion;
    property OnVertScrollDrawPart;
    property OnVertScrollHintNeeded;

    property OnHTMLImageNeeded;
    property OnHTMLImageNeededEx;
    property OnLinkClick;
    property OnLinkOver;
    property LinkCursor;
    property LinkColor;
    property LinkStyle;

    property OnUserCellTextNeeded;
    property OnVirtualPropsNeeded;
    property OnVirtualTextNeeded;
    property OnVirtualHintNeeded;
    property OnVirtualValueNeeded;
    property OnVirtualStyleNeeded;

    property OnHeaderMouseDown;
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;

    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;

    property OnStartDock;
    property OnEndDock;
    property OnContextPopup;

    property OnOleTargetDrag;
    property OnOleTargetDrop;
    property OnOleDragStart;
    property OnOleDragFinish;

    property OnAdjustControlPosition;
    property OnControlCreated;
    property OnTagFound;

    property OnCtlClick;
    property OnCtlDblClick;
    property OnCtlMouseDown;
    property OnCtlMouseMove;
    property OnCtlMouseUp;

{$ifdef HOTTRACK_CURSOR}
    property TrackingCursor;
{$endif}
    property FixedTopRowNum;
    property FixedBottomRowNum;
    property FixedColNum;
    property GutterWidth;
    property GutterText;
  end;

type
  TElXTreeDragObject = class(TDragControlObject)
  public
  procedure Finished(Target: TObject; X, Y: Integer; Accepted: Boolean); override;
    function GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor; override;
  public
    destructor Destroy; override;
  end;

const
  FDivLineWidth = 1;
  CheckMargin   = 2;
  CheckBoxSize  = 15;

  // CNS
  crDragSingleNo    = 20001;
  crDragSingleMove  = 20002;
  crDragSingleCopy  = 20003;
  {
  crDragMultiNo     = 20004;
  crDragMultiMove   = 20005;
  crDragMultiCopy   = 20006;
  }

function CheckIfItemIsChecked(Item: TElXTreeItem; SearchDetails: TLMDDataTag): Boolean;

const MultiLineFlags: array[Boolean] of Integer = (DT_SINGLELINE, 0);
      WordWrapFlags: array[Boolean, Boolean] of Integer = ((0, 0), (0, DT_WORDBREAK));
      MultiLineEllipseFlags: array[Boolean] of Integer = (DT_END_ELLIPSIS, 0);

var
  LeafBmp: TBitmap;
  PlusBmp: TBitmap;
  MinusBmp: TBitmap;
//  GutterArrowBmp: TBitmap;

implementation
uses
  ElStack, LMDGraphUtils, UxTheme;

type
  PBoolean = ^Boolean;

  TElHeaderHack = class(TCustomElHeader)
  public
    property IsDesigning;
  end;

  TElScrollBarHack = class(TElScrollBar)
  public
    property IsDesigning;
  end;

function CheckIfItemIsChecked(Item: TElXTreeItem; SearchDetails: TLMDDataTag): Boolean;
begin
  result := false;
  if Item <> nil then
    result := Item.Checked;
end;

// TElXTreeScrollBar

destructor TElXTreeScrollBar.Destroy;
begin
  Self.UseXPThemes := false;
  if Assigned(FTree) then
    if Self.Kind = sbHorizontal then
      FTree.FHScrollBar := nil
    else
      FTree.FVScrollBar := nil;
  inherited;
end;

{
function GetErrorMsg(ID: Integer): string;
var
  p: pchar;
begin
  GetMem(p, 260);
  LoadString(HInstance, ID, p, 260);
  Result := StrPas(p);
  FreeMem(p, 260);
end;
}

procedure ChangeButtonColors(AButton: TBitmap);
var i, j: Integer;
begin
  for i := 0 to AButton.Width -1 do
  begin
    for j := 0 to AButton.Height -1 do
    begin
      case AButton.Canvas.Pixels[i, j] of
        clDkGray: AButton.Canvas.Pixels[i, j]:= GetSysColor(COLOR_3DSHADOW);//GetSysColor(COLOR_BTNSHADOW);
        clBlack: AButton.Canvas.Pixels[i, j] := GetSysColor(COLOR_WINDOWTEXT);
        clWhite: AButton.Canvas.Pixels[i, j] := GetSysColor(COLOR_WINDOW);
      end;
    end;
  end;
end;

procedure HideHTMLControlsInBranch(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean;
                              IterateData: TLMDDataTag; Tree: TCustomElXTree);
begin
  Item.HideHTMLControls;
end;

function TElXTreeDragObject.GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor;
var {
     FTree: TCustomElXTree;
     IsDragMulti,
    }
    IsDragCopy: Boolean;
begin
  if (Control is TCustomElXTree) then
  begin
    IsDragCopy := ((GetKeyState(VK_CONTROL) and $8000) = $8000);
    {
    FTree := TCustomElXTree(Control);
    IsDragMulti := (FTree.SelectedCount > 1);
    if IsDragMulti then
    begin
      if not Accepted then
        Result := crDragMultiNo
      else
      if IsDragCopy then
        Result := crDragMultiCopy // Ctrl key down
      else
        Result := crDragMultiMove;
    end
    else
    }
    begin
      if not Accepted then
        Result := crDragSingleNo
      else
      if IsDragCopy then
        Result := crDragSingleCopy // Ctrl key down
      else
        Result := crDragSingleMove;
    end;
  end
  else
    Result := inherited GetDragCursor(Accepted, X, Y);
end;

procedure TElXTreeDragObject.Finished(Target: TObject; X, Y: Integer; Accepted: Boolean);
begin
  inherited;
  Free;
end;

destructor TElXTreeDragObject.Destroy;
begin
  inherited;
end;

// ****************************************************************************
//                                TElXTreeView
// ****************************************************************************

constructor TElXTreeView.Create(Owner: TComponent);
begin
  FOwner := Owner as TCustomElXTree;
  inherited;
  ControlStyle := ControlStyle + [csOpaque, csDisplayDragImage] - [csCaptureMouse];

  FLastMouseXPos := -1;
  FLastMouseYPos := -1;

  FPlusPosition := vaMiddle;
  FEndEditWhenDestroy := True;
  Input := TElKeyboardInput.Create;
  FTmpBmp := TBitmap.Create;
  FHRange := -1;
  FColorHelper := TElXTreeViewColorHelper.Create;
  OnConstrainedResize := OnConstrainedResizeHandler;
  FBottomHeight := 0;
  FHintCol := -1;
//  FOwner.FGutterWidth := 15;
end;

destructor TElXTreeView.Destroy;
begin
  StopClearSearchTimeoutThread;
  FreeAndNil(Input);
  if FDragExpandTimer <> nil then
    FreeAndNil(FDragExpandTimer);
  if FHintItem <> nil then
     DoHideLineHint;
  FHintItemEx := nil;

  FreeAndNil(FHintTimer);
  FreeAndNil(FHintWnd);
  FreeAndNil(FDragScrollTimer);

  if FInpEdit <> nil then
    DoEndEdit(True);
  FreeAndNil(FEditTimer);

  FreeAndNil(FColorHelper);

  FreeAndNil(FTmpBmp);

  if VirtStyle <> nil then
    VirtStyle.Free;
  inherited;
end;

procedure TElXTreeView.DestroyWnd;  { protected }
begin
  if FEndEditWhenDestroy then
    DoEndEdit(True);
  inherited;
end;  { DestroyWnd }

procedure TElXTreeView.RedoTmpBmp;
var BgRect,
    BgRect1,
    BgRect2,
    BgRect4: TRect;
begin
  if FOwner.BackgroundType in [bgtColorFill, bgtCenterBitmap] then
  begin
    FTmpBmp.FreeImage;
    {FTmpBmp.Height := 0;
    FTmpBmp.Width := 0;}
  end
  else
  if FOwner.BackgroundType in [bgtHorzGradient, bgtVertGradient] then
  begin
    if (ClientWidth <> 0) and (ClientHeight <> 0) then
    begin
      FTmpBmp.Height := ClientHeight + 1;
      FTmpBmp.Width := ClientWidth + 1;
      BgRect := ClientRect;
      with FOwner do
        LMDGradientPaint(FTmpBmp.Canvas.Handle, BgRect, GradientStartColor, GradientEndColor, GradientSteps, LMDBackgroundType2GradientStyle[BackgroundType], 0, 0);
      end;
  end
  else
  begin
    if (ClientWidth <> 0) and (ClientHeight <> 0) then
    begin
      FTmpBmp.Height := ClientHeight + 1;
      FTmpBmp.Width := ClientWidth + 1;
      FTmpBmp.Handle := CreateCompatibleBitmap(FOwner.Background.Canvas.Handle, FTmpBmp.Width + 1, FTmpBmp.Height + 1);
      BgRect := ClientRect;
      BgRect4 := BgRect;
      BgRect1 := ClientRect;
      BgRect2 := BgRect;
      OffsetRect(BgRect2, BgRect2.Left, BgRect2.Top);
      with FOwner do
        LMDExtDrawBkgnd(FTmpBmp.Canvas.Handle, BgRect1, BgRect, BgRect, BgRect2, False, BackGroundColor, BackGroundColor, Background, backgroUndtype);
      end;
  end;
end;

procedure TElXTreeView.DoHideLineHint;
begin
  FHintItem := nil;
  if FHintTimer <> nil then
    FreeAndNil(FHintTimer);
  if FHintWnd <> nil then
  begin
    FHintWnd.ReleaseHandle;
    FHintWnd.Hide;
    //FreeAndNil(FHintWnd);
  end;
end;

procedure TElXTreeView.TryStartHint(XPos, YPos: Integer);
var
  Item: TElXTreeItem;
  LSection: TElHeaderSection;
  LHitColumn, xOffs: Integer;
  ip: TSTXItemPart;
  IT: TLMDString;
  Show1: Boolean;
begin
  Item := GetItemAt(XPos, YPos, ip, LHitColumn);
  if ip <> ipOutside then
  begin
    if LHitColumn = -1 then
      LSection := nil
    else
      LSection := FOwner.FHeader.Sections[LHitColumn];
  end
  else
    Exit;

  if Item = nil then
    Exit;
  if FOwner.FHintType = shtHintOnly then
  begin
    IT := Item.Hint;
    Show1 := True;
  end
  else
  begin
    IT := GetHintText(Item, LSection);
    if FOwner.FLineHintMode = shmAll then
      Show1 := True
    else
    if (FOwner.FLineHintMode = shmLong) and (Item.Hint = '') then
    begin
      with FOwner do
        if FHeader.Visible and (FMainTreeColumn <> - 1) and
         (FHeader.Sections.Count > FMainTreeColumn)
        and FHeader.Sections[FMainTreeColumn].Locked
        then
          xOffs := - FLeftPosition
        else
          xOffs := 0;
      if (not FOwner.ShowColumns) or (Item.WholeLine) then
        Show1 := Item.Cells[FOwner.FMainTreeColumn].FTextTooLarge
      else
        Show1 := Item.Cells[LSection.Index].FTextTooLarge or ((LSection.Right - (FOwner.FItemIndent * 3 div 5) > ClientWidth + FOwner.FLeftPosition + xOffs) or
                   (LSection.Left + (FOwner.FItemIndent * 3 div 5) < FOwner.FLeftPosition + xOffs));
    end
    else
      Show1 := True;
  end;

  if (FHintItem = nil) and Show1 then
    DoShowLineHint(Item, LSection);
end;

function TElXTreeView.GetHintText(Item: TElXTreeItem; var Section: TElHeaderSection): TLMDString;
var
  si: Integer;
  AStyle: TElXCellStyle;
  b: Boolean;

  function GetShortHint(AHint: TLMDString): TLMDString;
  begin
    {$ifdef LMD_UNICODE}
    if LMDWidePos('|', AHint) > 0 then
    {$else}
    if Pos('|', AHint) > 0 then
    {$endif}
      Result := Copy(AHint, 1, Pos('|', AHint) - 1)
    else
      Result := AHint;
  end;

begin
  b := True;
  AStyle := nil;
  if FOwner.FHintType = shtHintOnly then
  begin
    Result := GetShortHint(Item.Hint);
  end
  else
  begin
    if FOwner.FHintType = shtHintOrText then
    begin
      Result := GetShortHint(Item.Hint);
      if Length(Result) <> 0 then
        Exit;
    end;
    if (FOwner.LineHintType <> lhtMainTextOnly) and
      FOwner.ShowColumns then
    begin
      si := Section.Index;
//      if FOwner.VirtualityLevel = vlNone then
//      begin
//        if si > FOwner.MainTreeColumn then
//          Dec(si);
//      end;

      if FOwner.VirtualityLevel = vlNone then
      begin
//        AStyle := nil;
        //if Item.UseStyles then
        //begin
          AStyle := Item.CurrentStyle as TElXCellStyle;
          if (Section.Index <> FOwner.MainTreeColumn) and
             (Item.Cells.Count > si) then
            AStyle := Item.Cells[si].CurrentStyle as TElXCellStyle;
        //end;
      end
      else
      begin
//        AStyle := nil;
        if (not (csDesigning in FOwner.ComponentState)) then
        begin
          if LMDInRange(si, 0, Item.Cells.Count - 1) then
            AStyle := Item.Cells[si].Style
          else
            AStyle := VirtStyle;
//          if Assigned(AStyle) then
//            FOwner.TriggerVirtualStyleNeeded(Item, si, AStyle);
        end;
      end;

      if (AStyle = nil) or (AStyle.DrawStyle = ElhsText) then
      begin
        if Item.FStaticData <> nil then
        begin
          if Section.Index = FOwner.MainTreeColumn then
            b := True
          else
          if Item.Cells.Count > si then
          begin
            Result := Item.Cells[si].Text;
            if (Length(Result) <> 0) or
               (FOwner.LineHintType <> lhtSmart) then
              b := False
            else
            if (FOwner.LineHintType = lhtSmart) then
              Section := FOwner.FHeader.Sections[FOwner.MainTreeColumn];
          end
          else
          if FOwner.LineHintType = lhtCellTextOnly then
            b := False;
        end
        else
        begin
          if Section.Index = FOwner.MainTreeColumn then
            b := True
          else
            if (not (csDesigning in FOwner.ComponentState)) then
              FOwner.TriggerVirtualTextNeeded(Item, Section.Index, Result);
          if (Length(Result) <> 0) or
             (FOwner.LineHintType <> lhtSmart) then
            b := False
          else
          if (FOwner.LineHintType = lhtSmart) then
            Section := FOwner.FHeader.Sections[FOwner.MainTreeColumn]
          else
          if FOwner.LineHintType = lhtCellTextOnly then
            b := False;
        end;
      end
      else
      if FOwner.LineHintType = lhtCellTextOnly then
        b := False;
    end;
    if b = True then // we are showing long text
      Result := Item.Text;
  end;
end;

procedure TElXTreeView.DoShowLineHint(Item: TElXTreeItem; Section: TElHeaderSection);
var
  S, S1: TLMDString;
  R, R1, R2: TRect;
  dx, dy: Integer;
  b: Boolean;
  P: TPoint;
  xOffs: Integer;
begin
  if FOwner.IsEditing or  FMouseSel then
    Exit;
  R1 := GetItemRect(ColorHelper.Visible.IndexOf(Item));
  if IsRectEmpty(R1) then
    Exit;
  if FHintWnd = nil then
     FHintWnd := TElHintWindow.Create(self);
  b := True;
  S := GetHintText(Item, Section);
  if S = '' then
    Exit;

  FHintWnd.Font := Font;
  if not FOwner.UseSystemHintColors then
  begin
    FHintWnd.Color := FOwner.FLineHintColor;
    FHintWnd.Font.Color := FOwner.FTextColor;
  end
  else
  begin
    FHintWnd.Color := clInfoBk;
    FHintWnd.Font.Color := clInfoText;
  end;
  FHintWnd.Font.Charset := Font.Charset;

  FHintWnd.IsHTML := Item.HintIsHTML;
  FHintWnd.OnImageNeeded := FOwner.TriggerImageNeededEvent;

  with FOwner do
    if FHeader.Visible and (FMainTreeColumn <> - 1) and
         (FHeader.Sections.Count > FMainTreeColumn)

         and FHeader.Sections[FMainTreeColumn].Locked

         then
      xOffs := - FLeftPosition
    else
      xOffs := 0;

  if not FOwner.ShowColumns then
    R1.Left := Max(0, Item.FTextRect.Left - FOwner.FLeftPosition - xOffs)
  else
  begin
    if Section.Index = FOwner.FMainTreeColumn then
      R1.Left := Max(0, Item.FTextRect.Left + FOwner.FLeftPosition - xOffs)
    else
      R1.Left := Max(0, Section.Left + FOwner.FItemIndent div 5 - FOwner.FLeftPosition - xOffs);
  end;
  {$ifdef LMD_UNICODE}
  R := FHintWnd.CalcHintRectW(10000, S, nil);
  {$else}
  R := FHintWnd.CalcHintRect(10000, S, nil);
  {$endif}

  Dec(R.Bottom, 2);
  dx := R.Right - R.Left + 1;
  dy := R.Bottom - R.Top + 1;
  R.Left := R1.Left;
  R.Top := R1.Top;
  R.Right := R.Left + dx;
  R.Bottom := R.Top + dy;
  R.TopLeft := ClientToScreen(R.TopLeft);
  R.BottomRight := ClientToScreen(R.BottomRight);
  FHintWnd.BoundsRect := R;
  b := True;
  P := FHintCoord;
  if FOwner.ShowColumns then
    Inc(P.Y, FOwner.HeaderHeight);
  S1 := S;
  FOwner.DoShowHint(Item, Section, S, FHintWnd, P, b);
  if (b and (S <> S1)) then
  begin
    R := FHintWnd.BoundsRect;
    {$ifdef LMD_UNICODE}
    R2 := FHintWnd.CalcHintRectW(10000, S, nil);
    {$else}
    R2 := FHintWnd.CalcHintRect(10000, S, nil);
    {$endif}
    Dec(R2.Bottom, 2);
    dx := R2.Right - R2.Left + 1;
    dy := R2.Bottom - R2.Top + 1;
    R.Right := R.Left + dx;
    R.Bottom := R.Top + dy;
  end;
  if b then
  begin
    FHintItem := Item;
    {$ifdef LMD_UNICODE}
    FHintWnd.ActivateHintW(R, S);
    {$else}
    FHintWnd.ActivateHint(R, S);
    {$endif}
  end;
end;

procedure TElXTreeView.WndProc(var Message: TMessage);
var P1: TPoint;
    Item: TElXTreeItem;
    HCol: Integer;
    IP: TSTXItemPart;
begin
  if HandleAllocated and FOwner.UseCustomScrollBars then
    ShowScrollBar(Handle, SB_BOTH, false);
  if (FHintItem <> nil) and (FOwner.FHideHintOnMove) then
  begin
    if ((Message.Msg >= WM_MOUSEMOVE) and (Message.Msg <= WM_MOUSELAST)) or (Message.Msg = WM_NCMOUSEMOVE) then
    begin
      GetCursorPos(P1);
      P1 := ScreenToClient(P1);
      Item := GetItemAt(P1.X, P1.Y, IP, HCol);
      if Item <> FHintItem then
         DoHideLineHint;
      inherited;
      Exit;
    end
    else
    if
      ((Message.Msg >= WM_KEYFIRST) and (Message.Msg <= WM_KEYLAST)) or
      ((Message.Msg = CM_ACTIVATE) or (Message.Msg = CM_DEACTIVATE)) or
      (Message.Msg = CM_APPKEYDOWN) or (Message.Msg = CM_APPSYSCOMMAND) or
      (Message.Msg = WM_COMMAND) or
      ((Message.Msg > WM_MOUSEMOVE) and (Message.Msg <= WM_MOUSELAST))
      or (Message.Msg = WM_NCMOUSEMOVE) then
      DoHideLineHint;
  end;
  if (FHintItem <> nil) and ((Message.Msg = CM_ACTIVATE) or (Message.Msg = CM_DEACTIVATE))
    or (Message.Msg = WM_NCMOUSEMOVE) then
    DoHideLineHint;
  inherited;
end;

procedure TElXTreeView.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTCHARS;
end;

procedure TElXTreeView.CMMouseWheel(var Msg: TMessage);  { private }
var
  Dy: Integer;
  sl: Integer;
  TSI: TElXTreeItem;
  R: TRect;
  Pos: TPoint;
  Message: TWMMouseMove;
begin

  if FOwner.IsEditing then
    Exit;

  if LMDSIWindowsNTUp or LMDSIWindows98 then
    SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE)
  else
    sl := 3;
  if sl = 0 then
    sl := 1;
  Dy := TWMMouseWheel(Msg).WheelDelta div (MOUSE_WHEEL_DELTA div sl);
  if Dy <> 0 then
  begin
    if FMouseSel then
    begin
//      DrawMouseSelectFrame;
      SetTopIndex(FOwner.FTopIndex - Dy);
      Invalidate; //Update;
      Pos := ScreenToClient(SmallPointToPoint(TWMMouseWheel(Msg).Pos));
      if PtInRect(ClientRect, Pos) then
      begin
        TSI := GetItemAtY(Pos.y);
        if TSI = nil then
          TSI := TElXTreeItem(ColorHelper.Visible.Last);
        begin
          R := GetItemRect(ColorHelper.Visible.IndexOf(TSI));
          FMouseFrameRec.EndItem := TSI;
          FMouseFrameRec.EndCoord.x := Pos.x + FOwner.FLeftPosition;
          FMouseFrameRec.EndCoord.y := Pos.y - R.Top;
        end;
        SelectMouseSelectItems;
        FOwner.DoAfterSelectionChange;
      end;
//      DrawMouseSelectFrame;
    end
    else
      SetTopIndex(FOwner.FTopIndex - Dy);
    Message.Msg := WM_MOUSEMOVE;
    Message.Keys := 0;
    Message.Pos := TWMMousewheel(Msg).Pos;
    Message.Result := 0;
    WMMouseMove(Message);
    end;
  inherited;
end;  { CMMouseWheel }

procedure TElXTreeView.WMMouseWheel(var Msg: TMessage); { private }
begin
  inherited;
  CMMouseWheel(Msg);
end; { WMMouseWheel }

procedure TElXTreeView.OnHintTimer(Sender: TObject);
begin
  if FHintItem <> nil then
  begin
    DoHideLineHint;
    Exit;
  end;

  if FInpEdit <> nil then
    Exit;

  if FHintTimer = nil then
    Exit;
  FHintTimer.Enabled := False;
  if not FOwner.HandleAllocated then
    Exit;

  if (not (csDesigning in ComponentState)) then
  begin
    TryStartHint(FHintCoord.X, FHintCoord.Y);

    if FOwner.FHideHintOnTimer then
    begin
      if FOwner.FLineHintTimeout <= 0 then
      begin
        FHintTimer.Interval := Application.HintHidePause;
        if FHintTimer.Interval = 0 then
          FHintTimer.Interval := 1000;
      end
      else
        FHintTimer.Interval := FOwner.FLineHintTimeout;
      FHintTimer.Enabled := True;
    end;
  end;
end;

procedure TElXTreeView.SetLeftPosition(value: Integer);
var
  Code: Word;
  Form: TCustomForm;
begin
  FOwner.IsUpdating := True;
  try
    if csReading in ComponentState then
      FOwner.FLeftPosition := Value
    else
    begin
      if Value > FHRange - ClientWidth then
        Value := FHRange - ClientWidth;
      //if Value > FHRange then Value := FHRange;
      if Value < 0 then
        Value := 0;
      if Value <> FOwner.FLeftPosition then
      begin
        FOwner.FLeftPosition := Value;
        with FOwner do
        begin
          FHeader.LeftPos := FLeftPosition;
          {//LockedColumn, update
           FHeader.Left := -FLeftPosition;
          FHeader.Width := FLeftPosition + FView.Width;}
        end;
        FClearAll := True;
        if csDesigning in ComponentState then
        begin
          Form := GetParentForm(self);
          if (Form <> nil) and (Form.Designer <> nil) then
            Form.Designer.Modified;
          end;
        FOwner.FUpdated := True;
        FRangeUpdate := True;
      end;
      Code := SB_CTL;
      with FOwner do
        if Windows.GetScrollPos(FHScrollBar.Handle, Code) <> FLeftPosition then
          SetScrollPos(FHScrollBar.Handle, Code, FLeftPosition, True);
      FOwner.TriggerScrollEvent(sbHorizontal, 0{ScrollCodesToInt[ScrollCode]});
    end;
  finally
    FOwner.IsUpdating := False;
  end;
end;

procedure TElXTreeView.SetPlusPosition(const Value: TLMDVerticalAlign);
begin
  if Value <> FPlusPosition then
  begin
    FPlusPosition := Value;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TElXTreeView.SetTopIndex(value: Integer);
var
  MaxV: Integer;
  Form: TCustomForm;
begin
  FOwner.IsUpdating := True;
  if Value < FOwner.FixedTopRowNum then
    Value := FOwner.FixedTopRowNum;
  try
    FTrackItem := nil;
    if csReading in ComponentState then
      FOwner.FTopIndex := Value
    else
    begin
      if FOwner.TotalVarHeightCount > 0 then
      begin
        if FOwner.TotalVisCount = 0 then
          FOwner.GetTotalVisCount;
        maxV := CalcPageUpPos(FOwner.TotalVisCount - 1);//TotalVisCount - CalcPageUpPos(TotalVisCount - 1);
      end
      else
      begin
        if FOwner.TotalVisCount = 0 then
          FOwner.GetTotalVisCount;
        maxV := FOwner.TotalVisCount - (GetVisCount - FOwner.FFixedTopRowNum) + 1;
      end;
      if Value > maxV then
        Value := maxV;
      if Value < 0 then
        Value := 0;
      if Value <> FOwner.FTopIndex then
      begin
        FOwner.FUpdated := True;
        FClearVis := True;
        FClearAll := True;
        DoSetTopIndex(Value);
//        FOwner.DeselectAll;
//        FOwner.Items[Value].Focused := True;
      end;
      if csDesigning in ComponentState then
      begin
        Form := GetParentForm(self);
        if Assigned(Form) and Assigned(Form.Designer) then
          Form.Designer.Modified;
      end;
      SetScrollPos(FOwner.FVScrollBar.Handle, SB_CTL,
        FOwner.FTopIndex{ - FOwner.FFixedTopRowNum}, True);
      FOwner.TriggerScrollEvent(sbVertical, 0{ScrollCodesToInt[ScrollCode]});
    end;
  finally
    FOwner.IsUpdating := False;
  end;
end;

procedure TElXTreeView.DoSetTopIndex(Value: Integer);
var
  MaxV: Integer;
  LNewBottomIndex: integer;
  i: integer;
begin
  if FOwner.TotalVisCount = 0 then
    FOwner.GetTotalVisCount;
  if FOwner.TotalVarHeightCount > 0 then
    maxV := CalcPageUpPos(FOwner.TotalVisCount - 1)//TotalVisCount - //1// CalcPageUpPos(TotalVisCount - 1) + 1
  else
    maxV := FOwner.TotalVisCount - (FOwner.View.GetVisCount - FOwner.FFixedTopRowNum) + 1;
  if (Value < 0) or (MaxV < 0) then
    Value := 0
  else
  if Value > MaxV then
    Value := MaxV;
  if Value < FOwner.FFixedTopRowNum then
    Value := FOwner.FFixedTopRowNum;
//  if Value <= GetFirstOffsetItem(Value) then

  if (FOwner.FTopIndex < Value) and Assigned(FOwner.TopItem) then
  begin
    i := FOwner.FTopIndex;
    repeat
      FOwner.Items[i].HideHTMLControls;
      inc(i);
    until i = Value;
  end;

  FOwner.FTopIndex := Value;
  if (FOwner.FTopIndex = 0) and (FItems.Count = 0) then
    FOwner.FBottomIndex := 0
  else
  begin
    FillVisFwd(FOwner.FTopIndex);
    LNewBottomIndex := FOwner.FTopIndex
      + ColorHelper.Visible.Count - FOwner.FFixedBottomRowNum - 1;
    if (FOwner.FBottomIndex > LNewBottomIndex) and (Assigned(FOwner.Items[FOwner.FBottomIndex])) then
       FOwner.Items[FOwner.FBottomIndex].HideHTMLControls;
    FOwner.FBottomIndex := LNewBottomIndex;
  end;
end;

function TElXTreeView.GetFirstOffsetItemIndex(AOffset: Integer): Integer;
var
  LItem: TElXTreeItem;
  LLastSubItemIndex: Integer;
  LTotalItemCount: Integer;
begin
  Result := 0;
  LTotalItemCount := FOwner.FAllList.Count;
  while (AOffset > 0) and (Result < LTotalItemCount) do
  begin
    LItem := TElXTreeItem(FOwner.FAllList[Result]);
    LLastSubItemIndex := FOwner.FAllList.IndexOfFrom(Result, LItem.GetLastSubItem);
    if FOwner.FilteredVisibility and LItem.Hidden then
      Result := LLastSubItemIndex
    else
    begin
      if Assigned(LItem.FChildren) and (LItem.FChildren.Count > 0) and not LItem.Expanded then
        Result := LLastSubItemIndex;
      Dec(AOffset);
    end;
    Inc(Result);
  end;
end;

function TElXTreeView.FillVisFwd(AOffset: Integer): Integer;
var
  LTotalItemCount: Integer;
  LCurHeight, LCHeight: Integer;
  LSelfHeight: Integer;
{
  function GetNthVisibleItemIndex(N: Integer): Integer;
  var
    LItem: TElXTreeItem;
    LLastSubItemIndex: Integer;
  begin
    Result := 0;
    while (N > 0) and (Result < LTotalItemCount) do
    begin
      LItem := TElXTreeItem(FOwner.FAllList[Result]);
      LLastSubItemIndex := FOwner.FAllList.IndexOfFrom(Result, LItem.GetLastSubItem);
      if FOwner.FilteredVisibility and LItem.Hidden then
        Result := LLastSubItemIndex
      else
      begin
        if Assigned(LItem.FChildren) and (LItem.FChildren.Count > 0) and not LItem.Expanded then
          Result := LLastSubItemIndex;
        Dec(N);
      end;
      Inc(Result);
    end;
  end;
}
  function AddVisibleItems(var AItemListPosition: Integer;
    AFirstItemIndex, AItemsToAdd: Integer): Integer;
  var
    LItem: TElXTreeItem;
  begin
    Result := 0;
    LCHeight := 0;
    while (AItemsToAdd > 0) and (AFirstItemIndex < LTotalItemCount) do
    begin
      LItem := TElXTreeItem(FOwner.FAllList[AFirstItemIndex]);
      if FOwner.FilteredVisibility and LItem.Hidden then
        AFirstItemIndex := FOwner.FAllList.IndexOfFrom(AFirstItemIndex, LItem.GetLastSubItem)
      else
      begin
        if LCurHeight + 2*FDivLineWidth > LSelfHeight then
          break;
        if FOwner.TotalVarHeightCount > 0 then
          Inc(LCurHeight, LItem.GetHeight)
        else
          Inc(LCurHeight, FOwner.LineHeight);
        if FOwner.TotalVarHeightCount > 0 then
          Inc(LCHeight, LItem.GetHeight)
        else
          Inc(LCHeight, FOwner.LineHeight);
        ColorHelper.Visible.Insert(AItemListPosition, LItem);
        if Assigned(LItem.FChildren) and (LItem.FChildren.Count > 0) and not LItem.Expanded then
          AFirstItemIndex := FOwner.FAllList.IndexOfFrom(AFirstItemIndex, LItem.GetLastSubItem);
{
        // refresh virtuality cache
        if (FOwner.VirtualityLevel >= vlAllProps) and not (csDesigning in ComponentState) then
        begin
          Inc(LItemsAdded);
          FOwner.CacheItem(LItem, LItemsAdded);
        end;
}
        Inc(Result);
        Inc(AItemListPosition);
        Dec(AItemsToAdd);
      end;
      Inc(AFirstItemIndex);
    end;
  end;

  function GetFirstBottomItemIndex(ABottomLineCount: Integer): Integer;
  begin
    Result := FOwner.Items.Count - ABottomLineCount;
    if Result < 0 then
      Result := 0;
  end;

var
  LItemListPosition: Integer;
  LBottomItemListPosition: Integer;
  LFirstVisibleItemIndex: Integer;
  LFirstBottomItemIndex: Integer;
  LAdded: Integer;
begin
  ColorHelper.Visible.Clear;
  LItemListPosition := 0;
  Result := 0;
  LCurHeight := 0;
//  LSelfHeight := Height - FHeader.Height + max((FHeader.RowCount - 1),0)*FHeader.RowHeight;
  LSelfHeight := Height;
  LTotalItemCount := FOwner.FAllList.Count;
  if FOwner.FFixedTopRowNum > 0 then
  begin
    LAdded := AddVisibleItems(LItemListPosition, 0, FOwner.FFixedTopRowNum);
    Inc(Result, LAdded);
  end;
  if FOwner.FFixedBottomRowNum > 0 then
  begin
    LBottomItemListPosition := LItemListPosition;
    LFirstBottomItemIndex := GetFirstBottomItemIndex(FOwner.FFixedBottomRowNum);
    LAdded := AddVisibleItems(LBottomItemListPosition,
      LFirstBottomItemIndex,
      FOwner.FFixedBottomRowNum);
    Inc(Result, LAdded);
    FBottomHeight := LCHeight ;
  end
  else
    FBottomHeight := 0;
  LFirstVisibleItemIndex := GetFirstOffsetItemIndex(AOffset);
  LAdded := AddVisibleItems(LItemListPosition, LFirstVisibleItemIndex,
    LTotalItemCount - LFirstVisibleItemIndex - FOwner.FFixedBottomRowNum);
  Inc(Result, LAdded);
end;

procedure TElXTreeView.WMSize(var Msg: TWMSize);  { private }
begin
  inherited;

  if (csDesigning in ComponentState) and not Canvas.HandleAllocated then exit;

  FOwner.IsUpdating := True;
  FOwner.FUpdated := True;
  FClearVis := True;
  FClearAll := True;
  FVisUpdated := True;
  DoSetTopIndex(FOwner.FTopIndex);
  FOwner.IsUpdating := False;

  if not (FOwner.BackgroundType in [bgtColorFill, bgtCenterBitmap]) then
    RedoTmpBmp;

  //Invalidate;
end;  { WMSize }

const ScrollCodesToInt: array [TElScrollCode] of Integer = (SB_LINEUP, SB_LINEDOWN, SB_PAGEUP, SB_PAGEDOWN, SB_THUMBPOSITION, SB_THUMBTRACK, SB_TOP, SB_BOTTOM, SB_ENDSCROLL, SB_ENDSCROLL + 1, SB_ENDSCROLL + 2);

procedure TElXTreeView.OnHScroll(Sender: TObject; ScrollCode: TElScrollCode; var ScrollPos: Integer; var DoChange: Boolean);
var
  AScrollCode: TElScrollCode;
begin
  AScrollCode := ScrollCode;
  if AScrollCode = escSndLineDown then
  begin
    if FOwner.FVScrollBar.SecondBtnKind = sbkOpposite then
      AscrollCode := escLineUp
    else if FOwner.FVscrollBar.SecondBtnKind = sbkPage then
      AScrollCode := escPageDown;
  end
  else
  if AScrollCode = escSndLineUp then
  begin
    if FOwner.FVscrollBar.SecondBtnKind = sbkOpposite then
      AscrollCode := escLineDown
    else if FOwner.FVscrollBar.SecondBtnKind = sbkPage then
      AScrollCode := escPageUp;
  end;

  if FInpEdit <> nil then
    DoEndEdit(False);

  with FOwner do
  case AScrollCode of
    escLineUp: SetLeftPosition(FLeftPosition - 4);
    escLineDown: SetLeftPosition(FLeftPosition + 4);
    escPageUp: SetLeftPosition(FLeftPosition - Self.Width shr 1);
    escPageDown: SetLeftPosition(FLeftPosition + Self.Width shr 1);
    escPosition: SetLeftPosition(ScrollPos);
    escTrack: if FHorzScrollTracking then
      SetLeftPosition(ScrollPos);
    escTop: SetLeftPosition(0);
    escBottom: SetLeftPosition(FHRange);
  end; // case
  FOwner.TriggerScrollEvent(sbHorizontal, ScrollCodesToInt[ScrollCode]);
  {with FOwner do
    if Flat or FUseCustomScrollBars then
      DrawFlatBorder(False, False);
  }
  DoChange := False;
end;

procedure TElXTreeView.OnVScroll(ASender: TObject; AScrollCode: TElScrollCode;
  var AScrollPos: Integer; var ADoChange: Boolean);
var
  LScrollCode: TElScrollCode;
  LNewPos: Integer;
  LMessage: TWMMouseMove;
  LPoint: TPoint;
begin
  if Assigned(FInpEdit) then
  begin
    ADoChange := False;
    FScrollFirstClick := not FScrollFirstClick;
    if FScrollFirstClick then
    begin
      FOwner.FVScrollbar.EndScroll;
      Exit;
    end
    else
      if AScrollCode <> escEndScroll then
        DoEndEdit(False);
  end
  else
    FScrollFirstClick := False;

  LScrollCode := AScrollCode;
  if LScrollCode = escSndLineDown then
  begin
    if FOwner.FVscrollBar.SecondBtnKind = sbkOpposite then
      LScrollCode := escLineUp
    else
    if FOwner.FVscrollBar.SecondBtnKind = sbkPage then
      LScrollCode := escPageDown;
  end
  else
  if LScrollCode = escSndLineUp then
  begin
    if FOwner.FVscrollBar.SecondBtnKind = sbkOpposite then
      LScrollCode := escLineDown
    else
    if FOwner.FVscrollBar.SecondBtnKind = sbkPage then
      LScrollCode := escPageUp;
  end;

  if Assigned(FInpEdit) then
    DoEndEdit(False);

  case LScrollCode of
    escLineUp:   SetTopIndex(FOwner.FTopIndex - 1);
    escLineDown: SetTopIndex(FOwner.FTopIndex + 1);
    escPageUp  :
      begin
        {aNewPos := CalcPageUpPos(FTopIndex);
        if (aNewPos = FTopIndex) and (ColorHelper.Visible.Count = 1) and (TotalVisCount <> 1) then
          Dec(aNewPos);}
        if FOwner.TotalVarHeightCount > 0 then
           LNewPos := CalcPageUpPos(FOwner.FTopIndex)
        else
           LNewPos := FOwner.FTopIndex - GetVisCount + 1;
        if LNewPos < 0 then
          LNewPos := 0;
        SetTopIndex(LNewPos);
      end;
    escPageDown:
      begin
        if FOwner.TotalVarHeightCount > 0 then
           LNewPos := CalcPageDownPos(FOwner.FTopIndex)
        else
           LNewPos := FOwner.FTopIndex + GetVisCount - 1;
        if (LNewPos = FOwner.FTopIndex)
          and (ColorHelper.Visible.Count = 1)
          and (FOwner.TotalVisCount <> 1)
        then
          Inc(LNewPos);
        SetTopIndex(LNewPos);
      end;
    escPosition: SetTopIndex(AScrollPos);
    escTop:      SetTopIndex(0);
    escBottom:   SetTopIndex(FOwner.TotalVisCount);
    escTrack:    if FOwner.FVertScrollTracking then
      SetTopIndex(AScrollPos);
  end; // case
  FOwner.TriggerScrollEvent(sbVertical, ScrollCodesToInt[AScrollCode]);
  {with FOwner do
    if Flat or FUseCustomScrollBars then
      DrawFlatBorder(False, False);
  }
  if FMouseSel then
  begin
    GetCursorPos(LPoint);
    LPoint := ScreenToClient(LPoint);
    LMessage.Msg := WM_MOUSEMOVE;
    LMessage.Keys := 0;
    LMessage.XPos := LPoint.X;
    LMessage.YPos := LPoint.Y;
    LMessage.Result := 0;
    WMMouseMove(LMessage);
  end;
  ADoChange := False;
end;

type
  TXSRec = record
    MaxHeight: Integer;
    CurHeight: Integer;
    LastItem: TElXTreeItem;
  end;

PXSRec = ^TXSRec;

procedure TElXTreeView.IntPrevVis(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean;
         IterateData: TLMDDataTag; Tree: TCustomElXTree);

begin
 with PXSRec(IterateData)^ do
 begin
   Inc(CurHeight, Item.GetHeight);
   if CurHeight > MaxHeight then
     ContinueIterate := false
   else
     if Index  > FOwner.FFixedTopRowNum then
       LastItem := Item;
 end;
 end;

function TElXTreeView.CalcPageUpPos(CurIdx: Integer): Integer;
var
  i: Integer;
  XSRec: TXSRec;
begin
  i := CurIdx;
  if (i <= 0) or (ColorHelper.Visible.Count = 0) then
  begin
    Result := 0;
    Exit;
  end;
  XSRec.MaxHeight := ClientHeight;
  XSRec.CurHeight := 0;
  XSRec.LastItem := FOwner.FItems.GetVisItem(i);
  FOwner.FItems.IterateBackFrom(True, False, IntPrevVis, @XSRec, XSRec.LastItem); {<+>}
  if Assigned(XSRec.LastItem) then
    result := XSRec.LastItem.VisIndex
  else
    result := 0;
  end;

function TElXTreeView.CalcPageDownPos(CurIdx: Integer): Integer;
var
  i: Integer;
  XSRec: TXSRec;
begin
  i := CurIdx;
  if (i < 0) or (ColorHelper.Visible.Count = 0) then
  begin
    Result := 0;
    Exit;
  end;
  XSRec.MaxHeight := ClientHeight;
  XSRec.CurHeight := 0;
  XSRec.LastItem := FOwner.FItems.GetVisItem(i);
  FOwner.FItems.IterateFrom(True, False, IntPrevVis, @XSRec, XSRec.LastItem); {<+>}
  if Assigned(XSRec.LastItem) then
    result := XSRec.LastItem.VisIndex
  else
    result := 0;
  end;

procedure TElXTreeView.DefineHRange;

  procedure CalcWidth(Item: TElXTreeItem; {Index: Integer; var ContinueIterate: Boolean;
    IterateData: pointer; }Tree: TCustomElXTree);
  var
    w: Integer;
  begin
    w := Item.GetWidth;
//    if Owner.RightAlignedView then
    inc(w, Owner.GutterWidth);
    if w > FHRange then
      FHRange := w;
  end;

var
  i, LTotalItemsCount: Integer;
  Item: TElXTreeItem;
begin
  FHRange := -1;
  LTotalItemsCount := FOwner.FAllList.Count;
  i := 0;
  while i < LTotalItemsCount do
  begin
    Item := TElXTreeItem(FOwner.FAllList[i]);
    if (FOwner.FilteredVisibility and Item.Hidden) then
    begin
      i := FOwner.FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end
    else
    begin
      CalcWidth(Item, FOwner);
      if not Item.Expanded then
         i := FOwner.FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    Inc(i);
  end;
  Exit;
  //FItems.Iterate(True, @CalcWidth, nil);
end;

procedure TElXTreeView.Paint;
begin
  FPainting := True;
  RedrawTree(Canvas, FOwner.FLeftPosition, ColorHelper.Visible);
  FPainting := False;
end;

procedure TElXTreeView.FillDragImage;
var
  ABmp: TBitmap;
  TIL: TImageList;
  i, j: Integer;
  b, LWholeLineVisible: Boolean;
  LRTop, LRBottom: Integer;
  R: TRect;

  procedure IntRedrawItemTree(Index: Integer; Surface: TBitmap);
  var
    R: TRect;
    SText: TLMDString;
    Item: TElXTreeItem;
    R1, R3: TRect;
    //SaveStyle: TFontStyles;
    ImDrawStyle: TDrawingStyle;
    StImIndex: Integer;
    BMP, amBMP: TBitmap;
    ar2: TRect;
//    FakeStaticDataEx: TElXTreeItemStaticDataEx;
//    CurStaticDataEx: TElXTreeItemStaticDataEx;
  begin
    Item := TElXTreeItem(ColorHelper.Visible[index]);
    SText := Item.Text;

    with FOwner do
    begin
      R := Self.GetItemRect(index);
      Dec(R.Top, FDDY);
      Dec(R.Bottom, FDDY);
      if RightAlignedView then
      begin
        if (FShowRoot and FShowLines) or (FShowButtons and FShowRootButtons) then
          Dec(R.Right, FItemIndent);
      end
      else
      begin
        if (FShowRoot and FShowLines) or (FShowButtons and FShowRootButtons) then
          Inc(R.Left, FItemIndent);
      end;

      if RightAlignedView then
        Dec(R.Right, Item.Level * FItemIndent)
      else
        Inc(R.Left, Item.Level * FItemIndent);

      if FShowImages then
      begin
        if (FImages <> nil) then
        begin
          ImDrawStyle := FImages.DrawingStyle;
          FImages.DrawingStyle := dsFocus;
          if (Item.FBoolData and (ibfFocused or ibfExpanded)) = 0 then
            StImIndex := Item.ImageIndex
          else
            StImIndex := Item.StateImageIndex;
          if StImIndex = -1 then
            StImIndex := DoGetPicture(Item, -1);
          if LMDInRange(StImIndex, 0, FImages.Count - 1) then
          begin
            if RightAlignedView then
            begin
              ar2.Left := R.Right - FImages.Width;
              ar2.Top := (R.Top + (R.Bottom - R.Top + 1) shr 1) - (FImages.Height shr 1);
              Dec(R.Right, FImages.Width);
            end
            else
            begin
              ar2.Left := R.Left;
              ar2.Top := (R.Top + (R.Bottom - R.Top + 1) shr 1) - (FImages.Height shr 1);
              Inc(R.Left, FImages.Width);
            end;

            if (FAlphaForImages<>nil) and LMDInRange(StImIndex, 0, FAlphaForImages.Count-1) then
            begin
              BMP := TBitmap.Create;
              BMP.Width := FImages.Width;
              BMP.Height := FImages.Height;
              ImageList_DrawEx(FImages.Handle, StImIndex, BMP.Canvas.Handle, 0, 0, 0, 0,
                clNone, clNone, ILD_Normal);

              ar2.Right := ar2.Left + BMP.Width;
              ar2.Bottom := ar2.Top + BMP.Height;

              amBMP := TBitmap.Create;
              amBMP.Width := FAlphaForImages.Width;
              amBMP.Height := FAlphaForImages.Height;
              ImageList_DrawEx(FAlphaForImages.Handle, StImIndex, amBMP.Canvas.Handle, 0, 0, 0, 0,
                clNone, clNone, ILD_Normal);

              AlphaCopyRect2(Surface.Canvas.Handle, ar2, BMP.Canvas.Handle,
                rect(0, 0, BMP.Width, BMP.Height), amBMP, 255);

              FreeAndNil(BMP);
              FreeAndNil(amBMP);
            end
            else
              FImages.Draw(Surface.Canvas, ar2.Left, ar2.Top, StImIndex);
          end;
          FImages.DrawingStyle := ImDrawStyle;
        end;
      end; // Show images
      if RightAlignedView then
      begin
        Dec(R.Right, (FItemIndent div 3));
      end
      else
      begin
        Inc(R.Left, (FItemIndent div 3));
      end;

      if (FOwnerDrawByColumn and (FHeader.Sections.Count > 0) and (FHeader.Sections[FMainTreeColumn].Style = ElhsOwnerDraw))
        or ((not (FOwnerDrawByColumn)) and (SText = FOwnerDrawMask)) then
      begin
         if Item.Cells.Count > FMainTreeColumn then
           FOnCellDraw(self, Item.Cells[FMainTreeColumn], Canvas, R)
         else
           DoItemDraw(Item, Canvas, R, FMainTreeColumn);
      end
      else
      begin
        if not Item.UseOwnStyle and FOwner.ShowColumns and
          (FHeader.Sections[FMainTreeColumn].Style = elhsImageIndex) then
        begin
          BMP := TBitmap.Create;
          DrawCellImage(Surface.Canvas, Item, StrToIntDef(SText, -1), FMainTreeColumn, Bmp, R);
          FreeAndNil(Bmp);
        end
        else
        begin
          with Surface.Canvas do
            //if not Item.ParentFontStyle then     //vb
              Font.Style := Item.CurrentStyle.FontStyles;
          R1 := R;
          SetRectEmpty(R3);
          if Item.IsHTML and LMDIsHTMLText(SText) then
          begin
            R3.Left := 0;
            R3.Top := 0;
            with FRender do
            begin
              Data.Charset := Surface.Canvas.Font.Charset;
              PrepareText(SText, 0, False);
              R3.Right := Data.TextSize.cx;
              R3.Bottom := Data.TextSize.cy;
            end;
          end
          else
          begin
            if Item.Multiline and Item.WordWrap then
              R3.Right := R3.Left + R1.Right - R1.Left;
            LMDDrawText(Surface.Canvas.Handle, SText, Length(SText), R3, DT_NOPREFIX or MultiLineFlags[Item.Multiline] or WordWrapFlags[Item.Multiline, Item.WordWrap] or DT_CALCRECT or DT_EXTERNALLEADING);
          end;
          if RightAlignedView then
            R1.Left := R1.Right - (R3.Right - R3.Left)
          else
            R1.Right := R1.Left + (R3.Right - R3.Left);
          if Item.IsHTML and LMDIsHTMLText(SText) then
          begin
            with FRender do
            begin
              //Charset := Surface.Canvas.Font.Charset;
              //PrepareText(SText, 0, False);
              Data.DefaultStyle := Surface.Canvas.Font.Style;
              Data.LinkColor := FOwner.LinkColor;
              Data.LinkStyle := FOwner.LinkStyle;
              DrawText(Surface.Canvas, Point(0, 0), R1, clNone);
            end;
          end
          else
  //SaveStyle := Surface.Canvas.Font.Style;
          begin
            if RightAlignedText then
            begin
              LMDDrawText(Surface.Canvas.Handle, SText, Length(SText), R1, DT_NOPREFIX or MultiLineFlags[Item.Multiline] or WordWrapFlags[Item.Multiline, Item.WordWrap] or DT_VCENTER or DT_RIGHT or DT_RTLREADING);
            end
            else
            begin
              LMDDrawText(Surface.Canvas.Handle, SText, Length(SText), R1, DT_NOPREFIX or MultiLineFlags[Item.Multiline] or WordWrapFlags[Item.Multiline, Item.WordWrap] or DT_VCENTER);
            end;
          end;
        end;
//        FreeAndNil(FakeStaticDataEx);
        //Surface.Canvas.Font.Style := SaveStyle;
      end; // if ... else
    end;
  end;

  procedure DrawDragImages;
  var
    i: Integer;
    R: TRect;
    R1: TRect;
    Right: Integer;
  begin
    with FOwner do
    begin
      j := ColorHelper.Visible.Count;
      Right := 0;
      if ShowColumns then
      begin
        i := FHeader.Sections.Count - 1;
        while i > FHeader.Sections[FMainTreeColumn].Position do
        begin
          if FHeader.Sections.ItemByPos[i].Visible then
            break;
          Dec(i);
        end;
        Right := FHeader.Sections[i].Right;
      end;

      for i := 0 to j - 1 do
        if (TElXTreeItem(ColorHelper.Visible[i]).Selected) then
        begin
          R := Self.GetItemRect(i);
          Dec(R.Top, FDDY);
          Dec(R.Bottom, FDDY);
          if FHorizontalLines then
            Dec(R.Bottom, FDivLineWidth);
          R.Left := 0;
          R1 := R;
          if ShowColumns then
          begin
            if TElXTreeItem(ColorHelper.Visible[i]).WholeLine then
              R1.right := Right
            else
              R1.right := FHeader.Sections[FMainTreeColumn].Width
          end
          else
            R1.right := Max(FHRange, FLeftPosition + ClientWidth);
          ABmp.Canvas.Font := Canvas.Font;
          ABmp.Canvas.Font.Color := FTextColor;
          ABmp.Canvas.Pen.Color := FTextColor;
          IntRedrawItemTree(i, ABmp);
        end;
    end;
  end;

begin
  FDragImages := nil;
  if FOwner.DragImageMode = dimNever then
    Exit;
  b := False;
  LWholeLineVisible := False;
  LRTop := -1;
  LRBottom := -1;

  with FOwner do
    if DragImageMode = dimOne then
      for i := 0 to ColorHelper.Visible.Count - 1 do
      begin
        if (TElXTreeItem(ColorHelper.Visible[i]).Selected) then
        begin
          if b then
          begin
            FDragImages := nil;
            Exit;
          end
          else
          begin
            LWholeLineVisible := LWholeLineVisible
              or TElXTreeItem(ColorHelper.Visible[i]).WholeLine;
            b := True;
            R := Self.GetItemRect(i);
            LRTop := R.Top;//i * LineHeight;
            LRBottom := R.Bottom;
          end;
        end;
      end
    else
    begin
      for i := 0 to ColorHelper.Visible.Count - 1 do
      begin
        if (TElXTreeItem(ColorHelper.Visible[i]).Selected) then
        begin
          LWholeLineVisible := LWholeLineVisible
            or TElXTreeItem(ColorHelper.Visible[i]).WholeLine;
          R := Self.GetItemRect(i);
          LRBottom := R.Bottom;
          if not b then
          begin
            LRTop := R.Top;
            b := True;
          end;
        end;
      end;
    end;
  TIL := TImageList.Create(self);
  TIL.Height := LRBottom - LRTop + 1;
  FDDY := LRTop;

  with FOwner do
    if FMainTreeColumn >= FHeader.Sections.Count then
      FMainTreeColumn := 0;
  if FOwner.ShowColumns then
  begin
    if LWholeLineVisible then
    begin
      i := FHeader.Sections.Count - 1;
      while i > FHeader.Sections[FOwner.FMainTreeColumn].Position do
      begin
        if FHeader.Sections.ItemByPos[i].Visible then
          break;
        Dec(i);
      end;
      TIL.Width := FHeader.Sections[i].Right - FHeader.Sections[FOwner.FMainTreeColumn].Left;
    end
    else
      TIL.Width := FHeader.Sections[FOwner.FMainTreeColumn].Width;
  end
  else
    TIL.Width := Max(FHRange, FOwner.FLeftPosition + Width);

  ABmp := TBitmap.Create;
  try
    ABmp.Width := TIL.Width;
    ABmp.Height := TIL.Height;
    ABmp.Handle := CreateCompatibleBitmap(Canvas.Handle, TIL.Width, TIL.Height);
    ABmp.TransparentMode := tmFixed;
    ABmp.TransparentColor := FOwner.FBackGroundColor;
    ABmp.Canvas.FillRect(Rect(0, 0, ABMP.Width, ABMP.Height));
    ABmp.Canvas.Lock;
    try
      DrawDragImages;
    finally
      ABmp.Canvas.UnLock;
    end;
    TIL.AddMasked(ABmp, clDefault);
  finally
    FreeAndNil(ABmp);
  end;
  FDragImages := TIL;
end;

procedure TElXTreeView.DrawImages(ACanvas: TCanvas; Item: TElXTreeItem; HelperBitmap: TBitmap; var R: TRect);
var
  FTImages: TCustomImageList;
  FATImages: TCustomImageList;
  ImDrawStyle: TDrawingStyle;
  OvIndex: Integer;
  StImIndex: Integer;
  h, w: Integer;
  R2: TRect;

  procedure DoDrawImage;
  var
    xp: Integer;
  amBmp: TBitmap;
  begin
    h := FTImages.Height;
    w := FTImages.Width;

    if FOwner.RightAlignedView then
      R2 := Rect(Max(R.Left, R.Right - w), R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1), R.Right, R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1) + h)
    else
      R2 := Rect(R.Left, R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1), Min(R.Right, R.Left + w), R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1) + h);

    if R2.Right >= R2.Left then
    begin
      HelperBitmap.PixelFormat := pfDevice;
      HelperBitmap.Height := R2.Bottom - R2.Top;
      HelperBitmap.Width := R2.Right - R2.Left;

      bitblt(HelperBitmap.Canvas.Handle, 0, 0, HelperBitmap.Width, HelperBitmap.Height, ACanvas.Handle, R2.Left, R2.Top, srccopy);
      if FOwner.RightAlignedView then
        xp := HelperBitmap.Width - w
      else
        xp := 0;
      if OvIndex <> -1 then
      begin
        FTImages.DrawOverlay(HelperBitmap.Canvas, xp, 0, StImIndex, OvIndex);
      end
      else
        FTImages.Draw(HelperBitmap.Canvas, xp, 0, StImIndex);

      if (FATImages <> nil) and LMDInRange(StImIndex, 0, FATImages.Count - 1) then
      begin
        amBMP := TBitmap.Create;
        amBMP.Width := FATImages.Width;
        amBMP.Height := FATImages.Height;
        ImageList_DrawEx(FATImages.Handle, StImIndex, amBMP.Canvas.Handle, 0, 0, 0, 0,
          clNone, clNone, ILD_Normal);

        AlphaCopyRect2(ACanvas.Handle, r2, HelperBitmap.Canvas.Handle,
          rect(0, 0, HelperBitmap.Width, HelperBitmap.Height), amBMP, 255);

        FreeAndNil(amBMP);
      end
      else
        bitblt(ACanvas.Handle, r2.Left, R2.Top, HelperBitmap.Width, HelperBitmap.Height, HelperBitmap.Canvas.Handle, 0, 0, srccopy);
    end;

    if FOwner.RightAlignedView then
      Dec(R.Right, w)
    else
      Inc(R.Left, w);
  end;

begin
  if R.Left >= R.Right then
    Exit;

  FTImages := nil;

  with FOwner do
  begin
    if FImages2 <> nil then
    begin
      FTImages := FImages2;
      FATImages := FAlphaForImages2;
    end ;
    //else  //vb: do we really need to display two FImages?
    //begin
    //  FTImages := FImages;
    //  FATImages := FAlphaForImages;
    //end;

    if FTImages <> nil then
    begin
      ImDrawStyle := FTImages.DrawingStyle;
      if FChangeStateImage and RowSelect then
      begin
        if Item.Selected {or Item.CurrentStyle.Cut} then
          FTImages.DrawingStyle := dsSelected
        else
        if Item.Focused then
          FTImages.DrawingStyle := dsFocus
        else
          FTImages.DrawingStyle := dsNormal;
      end
      else
      if FChangeStateImage {and Item.CurrentStyle.Cut} then
        FTImages.DrawingStyle := dsSelected;
      // draw 2nd image
      if (Item.Focused or Item.Selected or (Item.Expanded {and Item.HasVisibleChildren})) then
        StImIndex := Item.StateImageIndex2
      else
        StImIndex := Item.ImageIndex2;
      if StImIndex = -1 then
         StImIndex := DoGetPicture2(Item);
      OvIndex := Item.OverlayIndex2;
      if LMDInRange(StImIndex, 0, FTImages.Count - 1) then
      begin
        if Item.ShowCheckBox and FOwner.ShowCheckboxes then
          if RightAlignedView then
            Dec(R.Right, FItemIndent div 3)
          else
            Inc(R.Left, FItemIndent div 3);

        DoDrawImage;
        Item.FBoolData := Item.FBoolData or ibfImageDrawn2;
      end
      else
      begin
        if FShowEmptyImages2 and Assigned(FImages2) then
        begin
          if FOwner.RightAlignedView then
            Dec(R.Right, FTImages.Width)
          else
            Inc(R.Left, FTImages.Width);
          Item.FBoolData := Item.FBoolData or ibfImageDrawn2;
        end
        else
          Item.FBoolData := Item.FBoolData and not ibfImageDrawn2;
      end;
      FTImages.DrawingStyle := ImDrawStyle;
    end;

    if (FImages <> nil) then
    begin
      FTImages := FImages;
      FATImages := FAlphaForImages;
      ImDrawStyle := FImages.DrawingStyle;
      if FChangeStateImage and RowSelect then
      begin
        if Item.Selected {or Item.Cut} then
           FTImages.DrawingStyle := dsSelected
        else
           if Item.Focused then
              FTImages.DrawingStyle := dsFocus
           else
              FTImages.DrawingStyle := dsNormal;
      end
      else
        if FChangeStateImage {and Item.Cut} then
          FTImages.DrawingStyle := dsSelected;
      if (Item.Focused or Item.Selected or (Item.Expanded {and Item.HasVisibleChildren})) then
        StImIndex := Item.StateImageIndex
      else
        StImIndex := Item.ImageIndex;
      if StImIndex = -1 then
        StImIndex := DoGetPicture(Item, -1);

      OvIndex := Item.OverlayIndex;
      if LMDInRange(StImIndex, 0, FTImages.Count - 1) then
      begin
        if RightAlignedView then
        begin
          if ((Item.FBoolData and ibfImageDrawn2) = ibfImageDrawn2) or
             (Item.ShowCheckBox and FOwner.ShowCheckboxes) then
            Dec(R.Right, FItemIndent div 3); // make the space between images
        end
        else
        begin
          if ((Item.FBoolData and ibfImageDrawn2) = ibfImageDrawn2) or
             (Item.ShowCheckBox and FOwner.ShowCheckboxes) then
            Inc(R.Left, FItemIndent div 3); // make the space between images
        end;
        DoDrawImage;
        Item.FBoolData := Item.FBoolData or ibfImageDrawn;
      end
      else
        if FShowEmptyImages then
        begin
          if RightAlignedView then
          begin
            if (Item.FBoolData and ibfImageDrawn2) = ibfImageDrawn2 then
              Dec(R.Right, FItemIndent div 3); // make the space between images
          end
          else
          begin
            if (Item.FBoolData and ibfImageDrawn2) = ibfImageDrawn2 then
              Inc(R.Left, FItemIndent div 3); // make the space between images
          end;

          if FOwner.RightAlignedView then
            Dec(R.Right, FTImages.Width)
          else
            Inc(R.Left, FTImages.Width);

          Item.FBoolData := Item.FBoolData or ibfImageDrawn;
        end
        else
          Item.FBoolData := Item.FBoolData and not ibfImageDrawn;
        FTImages.DrawingStyle := ImDrawStyle;
      end;
  end;
end;

procedure TElXTreeView.DrawButtons(ACanvas: TCanvas; Item: TElXTreeItem; IsNode: Boolean; var R: TRect);
var
  FCCanvas: TCanvas;
  //FCBitmap: HBitmap;
  FCBitmap: TBitmap;
  R1: TRect;
  w,
  h: Integer;
  TC: TColor;
//  sid: Integer;
  PX: TSize;
  //HR: HRESULT;
  LUseThemeMode: TLMDThemeMode;
  LDetail: TThemedTreeview;
begin
  LUseThemeMode := FOwner.UseThemeMode;
  FCCanvas := nil;
  FCBitmap := nil;
  TC := 0;
  if R.Left >= R.Right then
    Exit;
  LDetail := ttGlyphClosed;
  with FOwner do
  begin
    // sid := 0;
    h := 0;
    if (LUseThemeMode <> ttmNone) and not FCustomPlusMinus then
    begin
      if Item.Expanded then
        // sid := GLPS_OPENED
        LDetail := ttGlyphOpened
      else
        // sid := GLPS_CLOSED;
        LDetail := ttGlyphClosed;
      SetRectEmpty(R1);
      Px.cx := 9;
      Px.cy := 9;
      LMDThemeServices.GetThemePartSize(LUseThemeMode, ACanvas.Handle, ThemeServices.GetElementDetails(LDetail), PX);
//      GetThemePartSize(Theme, ACanvas.Handle, TVP_GLYPH, sid, nil, TS_TRUE, PX);
      w := min(Px.cx, (R.Bottom - R.Top) div 2);
      h := min(2*Px.cy, (R.Bottom - R.Top) div 2);
      case FPlusPosition of
      vaTop:
        LMDCenterRects(w+1, FItemIndent, h+1, h+1, R1);
      vaMiddle:
        LMDCenterRects(w+1, FItemIndent, h+1, R.Bottom - R.Top + 1, R1);
      vaBottom:
        begin
          LMDCenterRects(w+1, FItemIndent, R.Bottom - h+1, R.Bottom + h+1, R1);
          R1.Top := R.Bottom - h+1;
          R1.Bottom := R.Bottom;
        end;
      end;
    end
    else
    begin
      if FCustomPlusMinus then
      begin
        w := PlusPicture.Width;
        h := PlusPicture.Height;
        case FPlusPosition of
        vaTop:
          LMDCenterRects(w, FItemIndent, h, h, R1);
        vaMiddle:
          LMDCenterRects(w, FItemIndent, h, R.Bottom - R.Top + 1, R1);
        vaBottom:
          begin
            LMDCenterRects(w, FItemIndent, h, R.Bottom - R.Top + 1, R1);
            R1.Top := R.Bottom - h;
            R1.Bottom := R.Bottom;
          end;
        end;
        if not IsNode then
        begin
          FCCanvas := FLeafPicture.Canvas;
          TC := FLeafPicture.Canvas.Pixels[0, h-1];
          FCBitmap := FLeafPicture;
        end
        else
        if not Item.Expanded then
        begin
          FCCanvas := FPlusPicture.Canvas;
          TC := FPlusPicture.Canvas.Pixels[0, h-1];
          FCBitmap := FPlusPicture;
        end
        else
        begin
          FCCanvas := FMinusPicture.Canvas;
          TC := FMinusPicture.Canvas.Pixels[0, h-1];
          FCBitmap := FMinusPicture;
        end;
      end
      else
      begin
        w := 10;
        case FPlusPosition of
        vaTop:
          LMDCenterRects(w, FItemIndent, w, w, R1);
        vaMiddle:
          LMDCenterRects(w, FItemIndent, w, R.Bottom - R.Top + 1, R1);
        vaBottom:
          begin
            LMDCenterRects(w, FItemIndent, w, R.Bottom - R.Top + 1, R1);
            R1.Top := R.Bottom - w;
            R1.Bottom := R.Bottom;
          end;
        end;
        if not IsNode then
        begin
          FCCanvas := LeafBmp.Canvas;
          TC := LeafBmp.Canvas.Pixels[1, LeafBmp.Height-2];
          FCBitmap := LeafBmp;
        end
        else
        if not Item.Expanded then
        begin
          FCCanvas := PlusBmp.Canvas;
          TC := PlusBmp.Canvas.Pixels[1, PlusBmp.Height-2];
          FCBitmap := PlusBmp;
        end
        else
        begin
          FCCanvas := MinusBmp.Canvas;
          TC := MinusBmp.Canvas.Pixels[1, MinusBmp.Height - 2];
          FCBitmap := MinusBmp;
        end;
      end;
    end;

    if RightAlignedView then
    begin
      R1 := Rect(max(R.Right - R1.Right, R.Left), R1.Top + R.Top, R.Right - R1.Right + w, R1.Bottom + R.Top);
      if (LUseThemeMode <> ttmNone) and not FCustomPlusMinus then
        LMDThemeServices.DrawElement(LUseThemeMode, ACanvas.Handle, LDetail, R1, LMDRectToPtr(R1))
      else
      begin
        if FOwner.FPlusMinusTransparent then
          DrawTransparentBitmapEx(ACanvas.Handle, FCBitmap, R1.Left, R1.Top, Rect(w - (R1.Right - R1.Left), 0, w, R1.Bottom - R1.Top), TC)
        else
          BitBlt(ACanvas.Handle, R1.Left, R1.Top, R1.Right - R1.Left + 1, R1.Bottom - R1.Top + 1, FCCanvas.Handle, w - (R1.Right - R1.Left), 0, SRCCOPY);
        end;
    end
    else
    begin
      OffsetRect(R1, R.Left, R.Top);
      if (LUseThemeMode <> ttmNone) and not FCustomPlusMinus then
        LMDThemeServices.DrawElement(LUseThemeMode, ACanvas.Handle, LDetail, Rect(R1.Left, R1.top, R1.Left + w, R1.Top + h), LMDRectToPtr(R1))
      else
      begin
        if FOwner.FPlusMinusTransparent then
          DrawTransparentBitmapEx(ACanvas.Handle, FCBitmap, R1.Left, R1.Top,
            Rect(0, 0, min(R1.Right - R1.Left, R.Right - R1.Left), R1.Bottom - R1.Top), TC)
        else
          BitBlt(ACanvas.Handle, R1.Left, R1.Top, min(R1.Right - R1.Left + 1, R.Right - R.Left), R1.Bottom - R1.Top + 1, FCCanvas.Handle, 0, 0, SRCCOPY);
        end;
    end;
  end;
  with FOwner do
    if RightAlignedView then
      Dec(R.Right, FItemIndent)
    else
      Inc(R.Left, FItemIndent);
end;

procedure TElXTreeView.DrawCheckBox(ACanvas: TCanvas; Item: TElXTreeItem; HelperBitmap: TBitmap; var R: TRect);
var
  cbh,
  cbw,
  i: Integer;
  R1,
  R2,
  R3: TRect;
  ADC: HDC;
  HObj: HGDIObj;
  PX: TSize;
  sid: Integer;
//  ATheme: HTheme;
  LUseThemeMode: TLMDThemeMode;
  CurStaticDataEx: TElXTreeItemStaticDataEx;
  dtl: TThemedElementDetails;
begin
  LUseThemeMode := FOwner.UseThemeMode;
  CurStaticDataEx := Item.FStaticDataEx;
  with FOwner do
  begin
    if (CurStaticDataEx.FBoolData1 and ibfShowCheckBox) = ibfShowCheckBox then
    begin
      cbw := 0;
      sid := 0;
      try
        {
        if RightAlignedView then
          Dec(R.Right, 2)
        else
          Inc(R.Left, 2);
        }
        if (LUseThemeMode <> ttmNone) and (not FCustomCheckBoxes) then
        begin
          SetRectEmpty(R1);
          // ATheme := LMDThemeService.Theme[tiButton];
          if LUseThemeMode <> ttmNone then
          begin
            SetRectEmpty(R1);
            px.cx := 13;
            px.cy := 13;

            if CurStaticDataEx.CheckBoxType = ectRadioButton then
              sid := Ord(tbCheckBoxUncheckedNormal) //!!!
            else
              sid := Ord(tbCheckBoxUncheckedNormal);

            dtl := LMDThemeServices.GetDetails(teButton, sid);
            if not LMDThemeServices.GetThemePartSizeNew(LUseThemeMode,
              Canvas.Handle, dtl, PX) then
            begin
              Px.cx := 16;
              Px.cy := 16;
            end;

            cbw := Px.cx;
            cbh := Px.cy;
          end
          else
          begin
            cbw := FCheckBoxSize;
            cbh := FCheckBoxSize;
          end;

          if CurStaticDataEx.CheckBoxType = ectRadioButton then
          begin
            if not Item.Checked then
            begin
              if not Item.CheckBoxEnabled then
                sid := Ord(tbRadioButtonUncheckedDisabled)
              else
                sid := Ord(tbRadioButtonUncheckedNormal);
            end
            else
            begin
              if not Item.CheckBoxEnabled then
                sid := Ord(tbRadioButtonCheckedDisabled)
              else
                sid := Ord(tbRadioButtonCheckedNormal);
            end;
          end
          else
          begin
            case CurStaticDataEx.CheckBoxState of
              cbUnchecked :
                if (not Item.CheckboxEnabled) or (not FOwner.Enabled) then
                  sid := Ord(tbCheckBoxUncheckedDisabled)
                else
                  sid := Ord(tbCheckBoxUncheckedNormal);

              cbChecked :
                if (not Item.CheckboxEnabled) or (not FOwner.Enabled) then
                  sid := Ord(tbCheckBoxCheckedDisabled)
                else
                  sid := Ord(tbCheckBoxCheckedNormal);

              cbGrayed :
                if (not Item.CheckboxEnabled) or (not FOwner.Enabled) then
                  sid := Ord(tbCheckBoxMixedDisabled)
                else
                  sid := Ord(tbCheckBoxMixedNormal);
            end;
          end;
          if RightAlignedView then
          begin
            R2 := Rect(Max(R.Left, R.Right - cbw), R.Top + ((R.Bottom - R.Top + 1) shr 1) - (cbh shr 1), R.Right, R.Top + ((R.Bottom - R.Top + 1) shr 1) + cbh shr 1 + 1);
            R3 := Rect(R2.Right - cbw, r2.top, R2.Right, r2.Top + cbh);
          end
          else
          begin
            R2 := Rect(R.Left, R.Top + ((R.Bottom - R.Top + 1) shr 1) - (cbh shr 1), Min(R.Right, R.Left + cbw), R.Top + ((R.Bottom - R.Top + 1) shr 1) + cbh shr 1 + 1);
            R3 := Rect(R2.Left, R2.Top, R2.Left + cbw, R2.Top + cbh);
          end;
          if R.Left >= R2.Right then
            Exit;

          dtl := LMDThemeServices.GetDetails(teButton, sid);
          LMDThemeServices.DrawElement(LUseThemeMode, ACanvas.Handle, dtl, R3, @R2);
        end
        else if FCustomCheckboxes then
        begin
          if CurStaticDataEx.CheckBoxType = ectRadioButton then
          begin
            cbh := FRadioButtonGlyph.Height;
            cbw := FRadioButtonGlyph.Width div 6;

            if not Item.Checked then
            begin
              if Item.CheckBoxEnabled then
                R3 := Rect(0, 0, cbw, cbh)
              else
                R3 := Rect(cbw, 0, cbw * 2, cbh);
            end
            else
            begin
              if Item.CheckBoxEnabled then
                R3 := Rect(cbw * 2, 0, cbw * 3, cbh)
              else
                R3 := Rect(cbw * 3, 0, cbw * 6, cbh);
            end;
          end
          else
          if CurStaticDataEx.CheckBoxType = ectCheckBox then
          begin
            cbh := FCheckBoxGlyph.Height;
            cbw := FCheckBoxGlyph.Width div 6;

            if not Item.Checked then
            begin
              if Item.CheckBoxEnabled then
                R3 := Rect(0, 0, cbw, cbh)
              else
                R3 := Rect(cbw, 0, cbw * 2, cbh);
            end
            else
            begin
              if Item.CheckBoxEnabled then
                R3 := Rect(cbw * 2, 0, cbw * 3, cbh)
              else
                R3 := Rect(cbw * 3, 0, cbw * 4, cbh);
            end;
          end
          else
          begin
            cbh := FCheckBoxGlyph.Height;
            cbw := FCheckBoxGlyph.Width div 6;

            case Item.CheckBoxState of
              cbUnchecked:
                if Item.CheckBoxEnabled then
                  R3 := Rect(0, 0, cbw, cbh)
                else
                  R3 := Rect(cbw, 0, cbw * 2, cbh);
              cbChecked:
                if Item.CheckBoxEnabled then
                  R3 := Rect(cbw * 2, 0, cbw * 3, cbh)
                else
                  R3 := Rect(cbw * 3, 0, cbw * 4, cbh);
              cbGrayed:
                if Item.CheckBoxEnabled then
                  R3 := Rect(cbw * 4, 0, cbw * 5, cbh)
                else
                  R3 := Rect(cbw * 5, 0, cbw * 6, cbh);
            end;
          end;

          if RightAlignedView then
          begin
            R2 := Rect(R.Right - cbw + 1, R.Top + ((R.Bottom - R.Top + 1) shr 1) - cbh shr 1, R.Right, R.Top + ((R.Bottom - R.Top + 1) shr 1) + cbw shr 1);

            if R.Left >= R2.Right then
              Exit;
            if R.Left >= R.Right - cbw then
            begin
              R2.Left := R.Left;
              R3.Left := r3.Right - (R.Right - R.Left + 1);
              HelperBitmap.Width := R.Right - R2.Left;
            end
            else
              HelperBitmap.Width := cbw;
          end
          else
          begin
            R2 := Rect(R.Left, R.Top + ((R.Bottom - R.Top + 1) shr 1) - cbh shr 1, R.Left + cbw, R.Top + ((R.Bottom - R.Top + 1) shr 1) + cbw shr 1);

            if R2.Left >= R.Right then
              Exit;
            if R2.Left + cbw >= R.Right then
            begin
              R2.Right := R.Right;
              R3.Right := R3.Left + (R.Right - R.Left + 1);
              HelperBitmap.Width := R.Right - R.Left + 1;
            end
            else
              HelperBitmap.Width := cbw;
          end;
          HelperBitmap.Height := R2.Bottom - R2.Top + 1;

          bitblt(HelperBitmap.Canvas.Handle, 0, 0, HelperBitmap.Width, HelperBitmap.Height, ACanvas.Handle, r2.Left, R2.Top, srccopy);
          if CurStaticDataEx.CheckBoxType = ectRadioButton then
          begin
            FRadioButtonGlyph.Pixelformat := pfDevice;
            DrawTransparentBitmapEx(HelperBitmap.Canvas.Handle, FRadioButtonGlyph, 0, 0, R3, FRadioButtonGlyph.traNsparentcolor);
          end
          else
          begin
            FCheckBoxGlyph.Pixelformat := pfDevice;
            DrawTransparentBitmapEx(HelperBitmap.Canvas.Handle, FCheckBoxGlyph, 0, 0, R3, FCheckBoxGlyph.TransparentColor);
          end;
          bitblt(ACanvas.Handle, r2.Left, R2.Top, HelperBitmap.Width, HelperBitmap.Height, HelperBitmap.Canvas.Handle, 0, 0, srccopy);
        end
        else
        begin
          //cbw := FItemIndent - 2;
          cbw := FOwner.CheckBoxSize;
          cbh := cbw;
          //cbh := FItemIndent - 2;

          i := DFCS_BUTTONCHECK or DFCS_CHECKED;
          if CurStaticDataEx.CheckBoxType = ectRadioButton then
          begin
            if Item.Checked then
              i := DFCS_BUTTONRADIO or DFCS_CHECKED
            else
              i := DFCS_BUTTONRADIO;
          end
          else
            if CurStaticDataEx.CheckBoxType = ectCheckBox then
            begin
              if Item.Checked then
                i := DFCS_BUTTONCHECK or DFCS_CHECKED
              else
                i := DFCS_BUTTONCHECK;
            end
            else
            begin
              case CurStaticDataEx.CheckBoxState of //
                cbChecked: i := DFCS_BUTTONCHECK or DFCS_CHECKED;
                cbUnchecked: i := DFCS_BUTTONCHECK;
                cbGrayed: i := DFCS_BUTTON3STATE or DFCS_CHECKED;
              end; // case
            end;
          if ((CurStaticDataEx.FBoolData1 and ibfCheckBoxEnabled) <> ibfCheckBoxEnabled) or (not FOwner.Enabled) then
            i := i or DFCS_INACTIVE;

          if RightAlignedView then
          begin
            R2 := Rect(Max(R.Left, R.Right - (cbw - 2)), R.Top + ((R.Bottom - R.Top + 1) shr 1) - cbh shr 1, R.Right, R.Top + ((R.Bottom - R.Top + 1) shr 1) + cbh shr 1);

            R3 := Rect(0, 0, cbw - 1, cbw - 1);
            if R.Left >= R2.Right then
              Exit;
            if R.Left >= R.Right - cbw then
            begin
              R2.Left := R.Left;
              OffsetRect(R3, -(R.Left - (R.Right - cbw)), 0);
              HelperBitmap.Width := R.Right - R2.Left;
            end
            else
              HelperBitmap.Width := cbw;
          end
          else
          begin
            R2 := Rect(R.Left, R.Top + ((R.Bottom - R.Top + 1) shr 1) - cbh shr 1, Min(R.Right, R.Left + cbw), R.Top + ((R.Bottom - R.Top + 1) shr 1) + cbh shr 1);

            R3 := Rect(0, 0, cbw -1, cbw -1);
            if R2.Left >= R.Right then
              Exit;
            if R2.Left + cbw >= R.Right then
            begin
              R2.Right := R.Right;
              HelperBitmap.Width := R.Right - R2.Left;
            end
            else
              HelperBitmap.Width := cbw;
          end;
          HelperBitmap.Height := cbw - 1;

          ADC := CreateCompatibleDC(ACanvas.Handle);
          HObj := SelectObject(ADC, HelperBitmap.Handle);
          bitblt(ADC, 0, 0, HelperBitmap.Width, HelperBitmap.Height, ACanvas.Handle, r2.Left, R2.Top, srccopy);

          //SetBkMode(ADC, OPAQUE);
//          DrawFrameControl(ADC, R3, DFC_BUTTON, i);
          DrawFrameControl(ACanvas.Handle, R2, DFC_BUTTON, i);

          if FOwner.CheckBoxFlat then
          begin
            if CurStaticDataEx.CheckBoxType = ectRadioButton then
              DrawFlatRadioButtonFrame(FOwner, ACanvas.Handle, R2, Enabled)
            else
              DrawFlatCheckboxFrame(FOwner, ACanvas.Handle, R2, Enabled);
          end;
//          bitblt(ACanvas.Handle, r2.Left, R2.Top, HelperBitmap.Width, HelperBitmap.Height, ADC, 0, 0, srccopy);
          SelectObject(ADC, HObj);
          DeleteDC(ADC);
        end;
      finally
        if RightAlignedView then
          Dec(R.Right, cbw)
        else
          Inc(R.Left, cbw);
      end;
    end;
  end;
end;

procedure TElXTreeView.DrawItemLines(ACanvas: TCanvas; Item: TElXTreeItem; var R: TRect; var ItemRect: TRect);
var
  Stack: TElStack;
  //ItemRoot,
  TSI,
    TSI1: TElXTreeItem;
  SavePen: TPenStyle;
  SavePenCol: TColor;

  function GetPrevVisChild(Parent, Item: TElXTreeItem; NoRoot: Boolean): TElXTreeItem;
  begin
    if NoRoot and (Item.FParent = FItems.FRoot) then
    begin
      Result := nil;
      Exit;
    end;
    Result := Parent.GetPrevChild(Item);
    if FOwner.FilteredVisibility then
      while Assigned(Result) and (Result.Hidden) do Result := Parent.GetPrevChild(Result);
  end;

  function GetNextVisChild(Parent, Item: TElXTreeItem; NoRoot: Boolean): TElXTreeItem;
  begin
    if NoRoot and (Item.FParent = FItems.FRoot) then
    begin
      Result := nil;
      Exit;
    end;
    Result := Parent.GetNextChild(Item);
    if FOwner.FilteredVisibility then
      while Assigned(Result) and (Result.Hidden) do Result := Parent.GetNextChild(Result);
  end;

  procedure DrawLine(Canvas: TCanvas; StartX, StartY, EndX, EndY: Integer);
  var
    Coord: Integer;
    // CRef: COLORREF;
    // DC: HDC;
  begin
    Canvas.Pen.Style := psSolid;
    if (StartX > EndX) then
    begin
      Coord := StartX;
      StartX := EndX;
      EndX := Coord;
    end;
    if FOwner.LinesStyle = psDot then
    begin
      // CRef := ColorToRGB(Canvas.Pen.Color);
      // skip a pixel if not in grid
      Coord := (StartX and 1) xor (StartY and 1);
      if StartX = EndX then
      begin
        // draw vertical line
        Inc(Coord, StartY);
        while Coord < EndY do
        begin
          Canvas.MoveTo(StartX, Coord);
          Inc(Coord, 1);
          Canvas.LineTo(StartX, Coord);
          Inc(Coord, 1);
        end;
      end
      else
      begin
        // draw horizontal line
        Inc(Coord, StartX);
        while Coord < EndX do
        begin
          Canvas.MoveTo(Coord, StartY);
          Inc(Coord, 1);
          Canvas.LineTo(Coord, StartY);
          Inc(Coord, 1);
        end;
      end;
    end
    else
    begin
      Canvas.MoveTo(StartX, StartY);
      Canvas.LineTo(EndX, EndY);
    end;
  end;

  function GetNextNotLineSuppressedSibling(Item: TElXTreeItem): TElXTreeItem;
  var
    NextSibling: TElXTreeItem;
  begin
    Result := nil;
    NextSibling := Item.GetNextSibling;
    while (NextSibling <> nil) and (Result = nil) do
    begin
      if not NextSibling.SuppressLines then
        Result := NextSibling;
      NextSibling := NextSibling.GetNextSibling;
    end;
  end;

begin
  Inc(R.Bottom);
  try
    with FOwner do
    begin
      Stack := TElStack.Create;
      TSI := Item.Parent;
      SavePen := ACanvas.Pen.Style;
      SavePenCol := ACanvas.Pen.Color;
      ACanvas.Pen.Style := LinesStyle;
      ACanvas.Pen.Color := LinesColor;
      while TSI <> nil do
      begin
        Stack.Push(TSI);
        TSI := TSI.Parent;
      end;
      if Assigned(Item.FParent) and (Item.FParent <> FItems.FRoot) then
      begin
        TSI := Item;
        while TSI.FParent <> FItems.FRoot do
          TSI := TSI.FParent;
        if ShowRoot and (GetNextVisChild(TSI.FParent, TSI, False) <> nil) then
        begin
          if RightAlignedView then
          begin
            Inc(R.Right, FItemIndent);
            if (R.Right - (FItemIndent shr 1 {+ 4}) > R.Left) then
              DrawLine(ACanvas, R.Right - (FItemIndent shr 1 {+ 4}), R.Top{ + ((R.Bottom - R.Top + 1) shr 1)}, R.Right - (FItemIndent shr 1 {+ 4}), R.Top + (R.Bottom - R.Top + 1));
            Dec(R.Right, FItemIndent);
          end
          else
          begin
            Dec(R.Left, FItemIndent);
            if (ShowLines) and (R.Left + (FItemIndent shr 1 {- 4}) < R.Right) then
              DrawLine(ACanvas, R.Left + (FItemIndent shr 1 {- 4}), R.Top, R.Left + (FItemIndent shr 1 {- 4}), R.Top + (R.Bottom - R.Top + 1));
            Inc(R.Left, FItemIndent);
          end;
        end;
      end;

      if Stack.Count > 0 then
      begin
        TSI := TElXTreeItem(Stack.Pop);
        while Stack.Count > 0 do
        begin
          TSI1 := TSI;
          if Stack.Count > 0 then
          begin
            TSI := TElXTreeItem(Stack.Pop);
            if (ShowLines) and (GetNextVisChild(TSI1, TSI, True) <> nil) and ((R.Left + FItemIndent shr 1) < R.Right) and
               (GetNextNotLineSuppressedSibling(TSI) <> nil) then
              if RightAlignedView then
              begin
                if (GetNextVisChild(TSI1, TSI, True) <> nil) and ((R.Right - FItemIndent shr 1) > R.Left) then
                  DrawLine(ACanvas, R.Right - FItemIndent shr 1, R.Top, R.Right - FItemIndent shr 1, ItemRect.Bottom + 1);
              end
              else
              begin
                if (GetNextVisChild(TSI1, TSI, True) <> nil) and ((R.Left + FItemIndent shr 1) < R.Right) then
                  DrawLine(ACanvas, R.Left + FItemIndent shr 1, R.Top,  R.Left + FItemIndent shr 1, ItemRect.Bottom + 1);
              end;
          end;
          if RightAlignedView then
            Dec(R.Right, FItemIndent)
          else
            Inc(R.Left, FItemIndent);
        end;
        if RightAlignedView then
          Dec(R.Right, FItemIndent)
        else
          Inc(R.Left, FItemIndent);
      end;
      FreeAndNil(Stack);
      if (Item.FParent <> Item.FRoot) then
      begin
        if RightAlignedView then
        begin
          Inc(R.Right, FItemIndent);
          if (ShowLines) and ((R.Right - FItemIndent shr 1) > R.Left) then
          begin
            DrawLine(ACanvas, R.Right - FItemIndent shr 1, R.Top, R.Right - FItemIndent shr 1, R.Top + ((R.Bottom - R.Top + 1) shr 1));
            if not Item.SuppressLines then
              DrawLine(ACanvas, R.Right - FItemIndent shr 1, R.Top + ((R.Bottom - R.Top + 1) shr 1), Max(R.Right - FItemIndent, R.Left), R.Top + ((R.Bottom - R.Top + 1) shr 1));
          end;
        end
        else
        begin
          Dec(R.Left, FItemIndent);
          if (ShowLines) and ((R.Left + FItemIndent shr 1) < R.Right) then
          begin
            if not Item.SuppressLines or (GetNextNotLineSuppressedSibling(Item) <> nil) then
              DrawLine(ACanvas, R.Left + FItemIndent shr 1, R.Top, R.Left + FItemIndent shr 1, R.Top + ((R.Bottom - R.Top + 1) shr 1));
            if not Item.SuppressLines then
              DrawLine(ACanvas, R.Left + FItemIndent shr 1, R.Top + ((R.Bottom - R.Top + 1) shr 1), Min(R.Left + FItemIndent, R.Right), R.Top + ((R.Bottom - R.Top + 1) shr 1));
          end;
        end;
        if (ShowLines) and (GetNextVisChild(Item.Parent, Item, True) <> nil) and
           (GetNextNotLineSuppressedSibling(Item) <> nil) then
        begin
          if RightAlignedView then
          begin
            if ((R.Right - FItemIndent shr 1) > R.Left) then
              DrawLine(ACanvas, R.Right - FItemIndent shr 1, R.Top + ((R.Bottom - R.Top + 1) shr 1), R.Right - FItemIndent shr 1, R.Bottom + 1);
          end
          else
          begin
            if ((R.Left + FItemIndent shr 1) < R.Right) then
              DrawLine(ACanvas, R.Left + FItemIndent shr 1, R.Top + ((R.Bottom - R.Top + 1) shr 1), R.Left + FItemIndent shr 1, R.Bottom + 1);
          end;
        end; //if
      end // if
      else
      begin
        if RightAlignedView then
          Inc(R.Right, FItemIndent)
        else
          Dec(R.Left, FItemIndent);
        if (ShowLines) and FShowRoot then
        begin
          if RightAlignedView then
          begin
            if (R.Right - (FItemIndent shr 1{ + 4}) > R.Left) then
            begin
              if not Item.SuppressLines then
                DrawLine(ACanvas, Max(R.Right - FItemIndent, R.Left), R.Top + ((R.Bottom - R.Top + 1) shr 1), R.Right - (FItemIndent shr 1), R.Top + ((R.Bottom - R.Top + 1) shr 1));
              if GetPrevVisChild(Item.FParent, Item, False) <> nil then
                DrawLine(ACanvas, R.Right - (FItemIndent shr 1), R.Top, R.Right - (FItemIndent shr 1), R.Top + ((R.Bottom - R.Top + 1) shr 1));
              if not Item.SuppressLines then
                if GetNextVisChild(Item.FParent, Item, False) <> nil then
                   DrawLine(ACanvas, R.Right - (FItemIndent shr 1), R.Top + ((R.Bottom - R.Top + 1) shr 1), R.Right - (FItemIndent shr 1 {+ 4}), R.Top + (R.Bottom - R.Top + 1));
            end;
          end
          else
          begin
            if (R.Left + (FItemIndent shr 1 {- 4}) < R.Right) then
            begin
              if not Item.SuppressLines then
                DrawLine(ACanvas, R.Left + (FItemIndent shr 1 {- 4}), R.Top + ((R.Bottom - R.Top + 1) shr 1), Min(R.Left + FItemIndent, R.Right), R.Top + ((R.Bottom - R.Top + 1) shr 1));
              if GetPrevVisChild(Item.FParent, Item, False) <> nil then
                DrawLine(ACanvas, R.Left + (FItemIndent shr 1 {- 4}), R.Top, R.Left + (FItemIndent shr 1 {- 4}), R.Top + ((R.Bottom - R.Top + 1) shr 1));
              if (GetNextVisChild(Item.FParent, Item, False) <> nil) then
                if not Item.SuppressLines then
                  DrawLine(ACanvas, R.Left + (FItemIndent shr 1 {- 4}), R.Top + ((R.Bottom - R.Top + 1) shr 1), R.Left + (FItemIndent shr 1 {- 4}), R.Top + (R.Bottom - R.Top + 1));
            end;
          end;
        end;
      end;
      ACanvas.Pen.Style := SavePen;
      ACanvas.Pen.Color := SavePenCol;
    end;
  finally
    Dec(R.Bottom);
//    if (Item.ChildrenCount = 0) and (not Item.ForceButtons) then
    if (Item.GetFirstVisibleChild = nil) and (not Item.ForceButtons) and (not Owner.ShowLeafButton) then
    with FOwner do
      if RightAlignedView then
        Dec(R.Right, FItemIndent)
      else
        Inc(R.Left, FItemIndent);
  end;

end;

{DoRedrawItem}
procedure TElXTreeView.DoRedrawItem(ACanvas: TCanvas; AItem: TElXTreeItem;
  AItemRect, ASurfRect: TRect; AUsePartialCheck: boolean = true; AAbsIndex: integer = -1; AVisIndex: integer = -1);
var
  LUseThemeMode: TLMDThemeMode;
// =============================================
  procedure DrawDropTarget(var ADropTrgRect: TRect);
  begin
    case FOwner.FDragTrgDrawMode of
    ColorFrame:
      begin
        if FDropAcc then
          ACanvas.Brush.Color := FOwner.FDragRectAcceptColor
        else
          ACanvas.Brush.Color := FOwner.FDragRectDenyColor;
        ACanvas.TextOut(ADropTrgRect.Left, ADropTrgRect.Top, '');
        ACanvas.FrameRect(ADropTrgRect);
      end;
    dtdUpColorLine:
      begin
        if FDropAcc then
          ACanvas.Pen.Color := FOwner.FDragRectAcceptColor
        else
          ACanvas.Pen.Color := FOwner.FDragRectDenyColor;
        ACanvas.MoveTo(ADropTrgRect.Left, ADropTrgRect.Top);
        ACanvas.LineTo(ADropTrgRect.Right, ADropTrgRect.Top);

        ACanvas.MoveTo(ADropTrgRect.Left, ADropTrgRect.Top + 3);
        ACanvas.LineTo(ADropTrgRect.Left, ADropTrgRect.Top);
        ACanvas.MoveTo(ADropTrgRect.Left + 1, ADropTrgRect.Top + 1);
        ACanvas.LineTo(ADropTrgRect.Left + 1, ADropTrgRect.Top);

        ACanvas.MoveTo(ADropTrgRect.Right - 1, ADropTrgRect.Top + 3);
        ACanvas.LineTo(ADropTrgRect.Right - 1, ADropTrgRect.Top);
        ACanvas.MoveTo(ADropTrgRect.Right - 2, ADropTrgRect.Top + 1);
        ACanvas.LineTo(ADropTrgRect.Right - 2, ADropTrgRect.Top);
      end;
    dtdDownColorLine:
      begin
        Dec(ADropTrgRect.Bottom);
        if FDropAcc then
          ACanvas.Pen.Color := FOwner.FDragRectAcceptColor
        else
          ACanvas.Pen.Color := FOwner.FDragRectDenyColor;
        ACanvas.MoveTo(ADropTrgRect.Left, ADropTrgRect.Bottom);
        ACanvas.LineTo(ADropTrgRect.Right, ADropTrgRect.Bottom);

        ACanvas.MoveTo(ADropTrgRect.Left, ADropTrgRect.Bottom - 3);
        ACanvas.LineTo(ADropTrgRect.Left, ADropTrgRect.Bottom);
        ACanvas.MoveTo(ADropTrgRect.Left + 1, ADropTrgRect.Bottom - 1);
        ACanvas.LineTo(ADropTrgRect.Left + 1, ADropTrgRect.Bottom);

        ACanvas.MoveTo(ADropTrgRect.Right - 1, ADropTrgRect.Bottom - 3);
        ACanvas.LineTo(ADropTrgRect.Right - 1, ADropTrgRect.Bottom);
        ACanvas.MoveTo(ADropTrgRect.Right - 2, ADropTrgRect.Bottom - 1);
        ACanvas.LineTo(ADropTrgRect.Right - 2, ADropTrgRect.Bottom);
      end;
    dtdUpSelColorLine:
      begin
        ACanvas.Pen.Color := clHighlight;
        ACanvas.MoveTo(ADropTrgRect.Left, ADropTrgRect.Top);
        ACanvas.LineTo(ADropTrgRect.Right, ADropTrgRect.Top);

        ACanvas.MoveTo(ADropTrgRect.Left, ADropTrgRect.Top + 3);
        ACanvas.LineTo(ADropTrgRect.Left, ADropTrgRect.Top);
        ACanvas.MoveTo(ADropTrgRect.Left + 1, ADropTrgRect.Top + 1);
        ACanvas.LineTo(ADropTrgRect.Left + 1, ADropTrgRect.Top);

        ACanvas.MoveTo(ADropTrgRect.Right - 1, ADropTrgRect.Top + 3);
        ACanvas.LineTo(ADropTrgRect.Right - 1, ADropTrgRect.Top);
        ACanvas.MoveTo(ADropTrgRect.Right - 2, ADropTrgRect.Top + 1);
        ACanvas.LineTo(ADropTrgRect.Right - 2, ADropTrgRect.Top);
      end;
    dtdDownSelColorLine:
      begin
        Dec(ADropTrgRect.Bottom);
        ACanvas.Pen.Color := clHighlight;
        ACanvas.MoveTo(ADropTrgRect.Left, ADropTrgRect.Bottom);
        ACanvas.LineTo(ADropTrgRect.Right, ADropTrgRect.Bottom);

        ACanvas.MoveTo(ADropTrgRect.Left, ADropTrgRect.Bottom - 3);
        ACanvas.LineTo(ADropTrgRect.Left, ADropTrgRect.Bottom);
        ACanvas.MoveTo(ADropTrgRect.Left + 1, ADropTrgRect.Bottom - 1);
        ACanvas.LineTo(ADropTrgRect.Left + 1, ADropTrgRect.Bottom);

        ACanvas.MoveTo(ADropTrgRect.Right - 1, ADropTrgRect.Bottom - 3);
        ACanvas.LineTo(ADropTrgRect.Right - 1, ADropTrgRect.Bottom);
        ACanvas.MoveTo(ADropTrgRect.Right - 2, ADropTrgRect.Bottom - 1);
        ACanvas.LineTo(ADropTrgRect.Right - 2, ADropTrgRect.Bottom);
      end;
    end;
  end;

// =============================================
  procedure AlphaFillDropTrgRect(const AItemWholeRect: TRect);
  begin
    case FOwner.FDragTrgDrawMode of
      ColorRect:
        begin
          if FDropAcc then
            ACanvas.Brush.Color := FOwner.FDragRectAcceptColor
          else
            ACanvas.Brush.Color := FOwner.FDragRectDenyColor;
          LMDAlphaFillRect(ACanvas, AItemWholeRect, ACanvas.Brush.color, FOwner.FHighlightAlphaLevel shr 1);
        end;
      SelColorRect:
        begin
          ACanvas.Brush.Color := clHighlight;
          LMDAlphaFillRect(ACanvas, AItemWholeRect, ACanvas.Brush.Color, FOwner.FHighlightAlphaLevel shr 1);
        end;
    end; // case
  end;

// =============================================
  procedure DrawItemRect(const AItemWholeRect: TRect; var ADropTrgRect: TRect;
    const AItem: TElXTreeItem; const AIsDrawFocusRect: Boolean);
  begin
    if (AItem = FDropTrg)
      and (FOwner.FDragTrgDrawMode in [ColorRect, SelColorRect])
      {and (FOwner.FHighlightAlphaLevel < 255)}
    then
      AlphaFillDropTrgRect(AItemWholeRect);

    if AItem = FDropTrg then
      DrawDropTarget(ADropTrgRect);
  end;

// =============================================
  procedure CalcItemBounds(AColumnXOffset: Integer;
    var AItemWholeRect, ADropTrgRect: TRect);
  var
    LHeaderSection: TElHeaderSection;
  begin
    ADropTrgRect := AItemWholeRect;

    if not FOwner.FRowSelect then
    begin
      if (FOwner.FSelectColumn = -1)
        or not FOwner.ShowColumns
        or (FHeader.Sections.Count <= FOwner.FSelectColumn)
      then
      begin
        // R1.left := TSI.FTextRect.Left - FLeftPosition - xOffs + 1;
        // R1.Right := TSI.FTextRect.Right - FLeftPosition - xOffs - 1;
        AItemWholeRect := AItem.FTextRect;
        if Owner.MainTreeColumn > Owner.FixedColNum then
          OffsetRect(AItemWholeRect, - FOwner.FLeftPosition + AColumnXOffset, 0);
      end
      else
      begin
        LHeaderSection := FHeader.Sections[FOwner.FSelectColumn];
        AItemWholeRect.Left := LHeaderSection.Left - FOwner.FLeftPosition + AColumnXOffset;
        AItemWholeRect.Right := AItemWholeRect.Left + LHeaderSection.Width + AColumnXOffset;
        if FOwner.FVerticalLines then
          Dec(AItemWholeRect.Right, FDivLineWidth);
      end;
    end
    else
    begin
      ADropTrgRect.Left := AItemRect.Left - FOwner.FLeftPosition;
      if FOwner.ShowColumns then
      begin
        ADropTrgRect.Left := FOwner.GutterWidth;
//        if FOwner.FixedColNum <> 0 then
//          ADropTrgRect.Left := FOwner.GutterWidth;
        if FOwner.FullRowSelect then
          AItemWholeRect.Right := ClientWidth;
        ADropTrgRect.Right := ClientWidth;
        if (FOwner.FBarStyle or (AItem.CurrentStyle.BorderStyle <> ibsNone)) then
        begin
          Dec(ADropTrgRect.Right);
          if FOwner.FixedColNum <> 0 then
            Inc(ADropTrgRect.Left);
        end;
      end
      else
        ADropTrgRect.Right := AItemRect.Right + 1;
    end;
 //   Inc(ADropTrgRect.Bottom);
  end;

// =============================================
  procedure CalcCellRect(AColumnNumber, AColumnXOffset, ADivLineWidth: Integer;
    var ARect:TRect);
  var
    LCell: TElXTreeCell;
    LHeaderSection: TElHeaderSection;
    LItem: TElXTreeItem;
    i: integer;
    LIndex: integer;
  begin
    LCell := AItem.FCells[AColumnNumber];
    if LCell.JointCellRole = jcrSlave then
      LCell := LCell.JointCellMaster;
    LHeaderSection := LCell.HeaderSection;
    LItem := LCell.Owner;
    if AAbsIndex > -1 then
      LIndex := AAbsIndex
    else
      LIndex := AItem.AbsoluteIndex;
    if (not Assigned(LCell)) or ((not Assigned(LHeaderSection)) and (AColumnNumber > 0)) then
      Exit;
    if FOwner.ShowColumns and Assigned(LHeaderSection) then
      ARect.Left := LHeaderSection.Left - FOwner.FLeftPosition + AColumnXOffset
    else
      if FOwner.RightAlignedView then
        ARect.Left := AColumnXOffset - FOwner.FLeftPosition
      else
        ARect.Left := FOwner.GutterWidth - FOwner.FLeftPosition + AColumnXOffset;
    ARect.Top := AItemRect.Top;
    if LIndex > LItem.AbsoluteIndex then
    begin
      for i := LItem.AbsoluteIndex - 1 to LIndex do
      begin
        ARect.Top := ARect.Top - FOwner.Items[i].Height;
      end;
    end;
    if not FOwner.ShowColumns then
      if FOwner.RightAlignedView then
        ARect.Right := ASurfRect.Right - 1 - FOwner.FLeftPosition - FOwner.GutterWidth
      else
        ARect.Right := ASurfRect.Right - 1 - FOwner.FLeftPosition
    else
      ARect.Right := ARect.Left + LCell.Width;
    ARect.Bottom := ARect.Top + LCell.Height;
    if FOwner.VerticalLines and (not FOwner.BarStyle) then
      if FOwner.RightAlignedView then
      begin
        inc(ARect.Left, FDivLineWidth);
        inc(ARect.Right, FDivLineWidth);
      end
      else
      begin
        dec(ARect.Right, FDivLineWidth);
        dec(ARect.Left, FDivLineWidth);
      end;
    if FOwner.RightAlignedView then
      OffsetRect(ARect,-1,0);
    if LMDSIWindowsVista then
    begin
      if FOwner.RightAlignedView then
        OffsetRect(ARect,-1,0)
      else
        OffsetRect(ARect,1,0);
    end;
  end;

// =============================================
  procedure DrawItemBk(const LItemWholeRect: TRect; AItem: TElXTreeItem; LCanvas: TCanvas);
  begin
    LCanvas.Brush.Color := AItem.BackGroundColor;
    if LCanvas.Brush.Color <> clNone then
      LCanvas.FillRect(LItemWholeRect);
  end;
// =============================================
  procedure DrawCellBody(AColumnNumber, AColumnXOffset, ADivLineWidth, FixedWidth: Integer);
  var
    LCell: TElXTreeCell;
    R, R1: TRect;
    LHeaderSection: TElHeaderSection;
    TmpBmp : TBitmap;
    l, i: integer;
    HTMLData: TLMDHTMLData;
    LAbsIndex, LVisIndex: integer;
  begin
    LHeaderSection := FHeader.Sections[AColumnNumber];
    LCell := AItem.FCells[AColumnNumber];
    TmpBmp := nil;
    if (not Assigned(LCell)) or ((not Assigned(LHeaderSection)) and (AColumnNumber > 0)) then
      Exit;
    if LCell.JointCellRole = jcrSlave then
    begin
// ToDo: redraw visible part. EK
//      if ColorHelper.Visible.IndexOf(LCell.JointCellMaster.Owner) = -1 then
//      begin
//        if (AColumnNumber - LCell.GetJointCellMaster.Index + 1 = LCell.JointCellMaster.JointColumnCount) and
//           (AItem.AbsoluteIndex - LCell.GetJointCellMaster.Owner.AbsoluteIndex + 1 = LCell.JointCellMaster.JointRowCount) then
//        begin
//          LCell := LCell.JointCellMaster;
//          R.Left := LCell.Left;
//          R.Right := R.Left + LCell.Width;
//          R.Top := LCell.Top;
//          R.Bottom := R.Top + LCell.Height;
//          // to do: redraw visible part
//        end;
//      end;
    end
    else
    begin
      if (not AItem.WholeLine) or (AColumnNumber <= FOwner.FMainTreeColumn) then
      begin
        CalcCellRect(AColumnNumber, AColumnXOffset, ADivLineWidth, R);
        if IsRectEmpty(R) then
          exit;
        LCell.CellRect := R;
//        if R.Right >= FixedWidth then
        begin
          if AUsePartialCheck then
          begin
            if (R.Right < R.Left) or (R.Bottom < R.Top) then
              exit;
            TmpBmp := TBitmap.Create;
            TmpBmp.Width := R.Right - R.Left;
            TmpBmp.Height := R.Bottom - R.Top;
//            TmpBmp.Handle := CreateCompatibleBitmap(ACanvas.Handle,R.Right - R.Left,R.Bottom - R.Top);
            bitblt(TmpBmp.Canvas.Handle, 0, 0, TmpBmp.Width, TmpBmp.Height, ACanvas.Handle, R.Left, R.Top, SRCCOPY);
          end;
          if (FOwner.BackgroundType = bgtColorFill) or (AItem.BackGroundColor <> clNone) then
          begin
            if AItem.WholeLine and (AColumnNumber = FOwner.FMainTreeColumn) then
            begin
              if AUsePartialCheck then
              begin
                TmpBmp.Width := FOwner.FHeader.GetColumnsWidth - LHeaderSection.Left;
                bitblt(TmpBmp.Canvas.Handle, 0, 0, TmpBmp.Width, TmpBmp.Height, ACanvas.Handle, R.Left, R.Top, SRCCOPY);
              end
              else
                R.Right := R.Left + FOwner.FHeader.GetColumnsWidth - LHeaderSection.Left;
            end;
            if (not (LCell.Selected or (AItem.Selected and (FOwner.RowSelect or FOwner.FullRowSelect)))) or (FOwner.HighlightAlphaLevel < 255) then
              if AUsePartialCheck then
                DrawItemBk(Rect(0,0,TmpBmp.Width,TmpBmp.Height),AItem,TmpBmp.Canvas)
              else
                DrawItemBk(R, AItem, ACanvas)
          end;
          if ((LCell.CurrentStyle.DrawStyle = elhsOwnerDraw) or (FOwner.FOwnerDrawByColumn and Assigned(LHeaderSection) and (LHeaderSection.Style = elhsOwnerDraw)))
            or (not FOwner.FOwnerDrawByColumn and (LCell.Text = FOwner.OwnerDrawMask)) then
          begin
            if Assigned(FOwner.FOnCellDraw) then
              FOwner.FOnCellDraw(FOwner, LCell, ACanvas, R);
          end
          else
          begin
            if AUsePartialCheck then
            begin
              if AAbsIndex > -1 then
                LAbsIndex := AAbsIndex
              else
                LAbsIndex := AItem.AbsoluteIndex;
              if AVisIndex > -1 then
                LVisIndex := AVisIndex
              else
                LVisIndex := AItem.VisIndex;
              LCell.Paint(TmpBmp.Canvas, Rect(0, 0, TmpBmp.Width, TmpBmp.Height),True, LAbsIndex, LVisIndex)
            end
            else
              LCell.Paint(ACanvas, R, AUsePartialCheck);
            if AUsePartialCheck then
            begin
              if not FOwner.RightAlignedView then
              begin
                if R.Left < FixedWidth then
                  l := FixedWidth - R.Left
                else
                  l := 0;
                if (R.Bottom > Height - FBottomHeight) and (R.Top - FDivLineWidth < Height - FBottomHeight) and (AItem.Index < FOwner.Items.GetRootCount - FOwner.FFixedBottomRowNum) and AUsePartialCheck then
                  bitblt(ACanvas.Handle, max(R.left,FixedWidth), R.Top, TmpBmp.Width , TmpBmp.Height - (R.Bottom - Height + FBottomHeight), TmpBmp.Canvas.Handle, l, 0, SRCCOPY)
                else
                  bitblt(ACanvas.Handle, max(R.left,FixedWidth), R.Top, TmpBmp.Width, TmpBmp.Height, TmpBmp.Canvas.Handle, l, 0, SRCCOPY);
                if AColumnNumber = FOwner.MainTreeColumn then
                  OffsetRect(AItem.FTextRect, max(R.left,FixedWidth), 0);
              end
              else
              begin
                if AColumnNumber < FOwner.FixedColNum then
                begin
                  l := 0;
                  for i := 0 to FOwner.FixedColNum - 1 do
                  begin
                    l := l + FHeader.Sections[i].Width;
                    if AColumnNumber = i then
                      Break;
                  end;
                  l := min(R.Left, width - FOwner.FGutterWidth - l);
                  i := 0;
                end
                else
                begin
                  l := R.Left;
                  i := max(0, R.Right - (Width - FHeader.FixedColWidth));
                end;
                if (R.Bottom > Height - FBottomHeight) and (R.Top - FDivLineWidth < Height - FBottomHeight) and (AItem.Index < FOwner.Items.GetRootCount - FOwner.FFixedBottomRowNum) and AUsePartialCheck then
                  bitblt(ACanvas.Handle, l, R.Top, TmpBmp.Width - i, TmpBmp.Height - (R.Bottom - Height + FBottomHeight), TmpBmp.Canvas.Handle, 0, 0, SRCCOPY)
                else
                  bitblt(ACanvas.Handle, l, R.Top, TmpBmp.Width - i, TmpBmp.Height, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);
                if AColumnNumber = FOwner.MainTreeColumn then
                  OffsetRect(AItem.FTextRect, l + Owner.FLeftPosition, 0);
              end;
            end;
          end;
          if AUsePartialCheck then
            TmpBmp.Free;
        end;
        if AColumnNumber = FOwner.FMainTreeColumn then
        begin
          AItem.FTextRect.Top := R.Top;
          AItem.FTextRect.Bottom := R.Bottom;
        end;
        if AItem.IsHTML then
        begin
          if (AColumnNumber = Owner.FMainTreeColumn) and (Owner.FMainTreeColumn >= AItem.Cells.Count) then
            HTMLData := AItem.FHTMLData
          else
          begin
            if Assigned(AItem.FHTMLDataArray) then
              HTMLData := TLMDHTMLData(AItem.FHTMLDataArray[AColumnNumber])
            else
              HTMLData := nil;
          end;
          if Assigned(HTMLData) then
          begin
            R1 := HTMLData.Rect;
            OffsetRect(R1, 0, R.Top);
            HTMLData.Rect := R1;
          end;
        end;
      end;
    end;
  end;

// =============================================
  procedure DrawColumn(AColumnNumber, AColumnXOffset, ADivLineWidth, FixedWidth: Integer);
//  var
//    LHeaderSection: TElHeaderSection;
  begin
//    LHeaderSection := FHeader.Sections[AColumnNumber];
//    if (not FOwner.RightAlignedView and (LHeaderSection.Position < FHeader.Sections[FOwner.FMainTreeColumn].Position))
//      or (FOwner.RightAlignedView and (LHeaderSection.Position > FHeader.Sections[FOwner.FMainTreeColumn].Position))
//    then
      DrawCellBody(AColumnNumber, AColumnXOffset, ADivLineWidth, FixedWidth);
  end;
// =============================================
  procedure DrawColumns(ADivLineWidth: Integer);
  var
    i, FixedWidth: Integer;
  begin
    if not Owner.RightAlignedView then
    begin
      FixedWidth := FOwner.FGutterWidth;
      for i := 0 to FHeader.FixedColNum - 1 do
        if FHeader.Sections[i].Visible then
        begin
          DrawColumn(i, FOwner.FLeftPosition, ADivLineWidth, 0);
          FixedWidth := FixedWidth + FHeader.Sections[i].Width;
        end;
      for i := FHeader.FixedColNum to FHeader.Sections.Count - 1 do
        if FHeader.Sections[i].Visible and (FHeader.Sections[i].Right{ - FOwner.FLeftPosition} > FixedWidth) then
          DrawColumn(FHeader.Sections[i].Index, 0, ADivLineWidth, FixedWidth);
    end
    else
    begin
//      FixedWidth := 0;
      for i := FHeader.FixedColNum to FHeader.Sections.Count - 1 do
      begin
        if FHeader.Sections[i].Visible then
        begin
          DrawColumn(i, 0, ADivLineWidth, FHeader.FixedColWidth);
        end;
      end;
      for i := FHeader.FixedColNum - 1 downto 0 do
        if FHeader.Sections[i].Visible then
        begin
          DrawColumn(i, FOwner.FLeftPosition, ADivLineWidth, 0);
        end;
    end;
  end;
// =============================================
  procedure DrawItemWithoutColumns(AItem: TElXTreeItem; AItemRect: TRect);
  begin
    if (not (FOwner.FOwnerDrawByColumn)) and (AItem.Text = FOwner.FOwnerDrawMask) then
      FOwner.DoItemDraw(AItem, ACanvas, AItemRect, FOwner.FMainTreeColumn)
    else
      DrawCellBody(0, 0, 0, 0);
  end;
// =============================================
  procedure  DrawFramedBk(AItem: TElXTreeItem; LItemWholeRect: TRect);
    procedure DrawLine(Canvas: TCanvas; StartX, StartY, EndX, EndY: integer);
    var
      Coord: Integer;
    begin
      Coord := (StartX and 1) xor (StartY and 1);
      if StartX = EndX then
      begin
        // draw vertical Line
        Inc(Coord, StartY);
        while Coord < EndY do
        begin
          Canvas.MoveTo(StartX, Coord);
          Inc(Coord, 1);
          Canvas.LineTo(StartX, Coord);
          Inc(Coord, 1);
        end;
      end
      else
      begin
        // draw horizontal Line
        Inc(Coord, StartX);
        while Coord < EndX do
        begin
          Canvas.MoveTo(Coord, StartY);
          Inc(Coord, 1);
          Canvas.LineTo(Coord, StartY);
          Inc(Coord, 1);
        end;
      end;
    end;
  var
    LRect: TRect;
    i: integer;
  begin
    Canvas.Brush.Style := bsSolid;
    if HasFocus then
      Canvas.Pen.Color := FOwner.FocusedSelectTextColor
    else
      if FOwner.HideFocusRect then
        exit
      else
        Canvas.Pen.Color := FOwner.FocusedSelectColor;
    if FOwner.ShowColumns then
    begin
      LRect := LItemWholeRect;
      for i := 0 to AItem.Cells.Count - 1 do
      begin
        LRect.Left := AItem.Cells[i].Left - FOwner.LeftPosition - FDivLineWidth;
        if (AItem.Cells[i].JointCellRole = jcrSingle) and (LRect.Left + AItem.Cells[i].Width > 0) then
        begin
          if LRect.Left < 0 then
            LRect.Left := 0;
          DrawLine(Canvas, LRect.Left, LRect.Top, LRect.Left + AItem.Cells[i].Width, LRect.Top);
          DrawLine(Canvas, LRect.Left, LRect.Bottom - 1, LRect.Left + AItem.Cells[i].Width, LRect.Bottom - 1);
        end;
        LRect.Left := AItem.Cells[i].JointCellMaster.Left + AItem.Cells[i].Width - FDivLineWidth;
      end;
      if LRect.Left <= LItemWholeRect.Right then
      begin
        DrawLine(Canvas, LRect.Left, LRect.Top, LItemWholeRect.Right, LRect.Top);
        DrawLine(Canvas, LItemWholeRect.Right - 1, LItemWholeRect.Top, LItemWholeRect.Right - 1, LItemWholeRect.Bottom - 1);
        DrawLine(Canvas, LRect.Left, LItemWholeRect.Bottom - 1, LRect.Right - 1, LItemWholeRect.Bottom - 1);
      end;
    end
    else
    begin
      DrawLine(Canvas, LItemWholeRect.Left, LItemWholeRect.Top, LItemWholeRect.Right, LItemWholeRect.Top);
      DrawLine(Canvas, LItemWholeRect.Right - 1, LItemWholeRect.Top, LItemWholeRect.Right - 1, LItemWholeRect.Bottom - 1);
      DrawLine(Canvas, LItemWholeRect.Left, LItemWholeRect.Bottom - 1, LItemWholeRect.Right - 1, LItemWholeRect.Bottom - 1);
    end;
  end;
// =============================================
  procedure  DrawSelectedBk(AItem: TElXTreeItem; LItemWholeRect: TRect);
  var
    R, C: HRGN;
    i: integer;
    LCellRect, LClipRect: TRect;
    b: boolean;
    LDetails: TThemedElementDetails;
    LBmp: TBitmap;
  begin
    b := false;
    R := 0;
    if FOwner.ShowColumns then
    begin
      R := CreateRectRgnIndirect(LItemWholeRect);
      LCellRect := LItemWholeRect;
      LClipRect := ACanvas.ClipRect;
      for i := 0 to AItem.Cells.Count - 1 do
      begin
        if (AItem.Cells[i].JointCellRole = jcrSlave) and (AItem.Cells[i].JointCellMaster.Owner <> AItem) then
        begin
          LCellRect.Left := AItem.Cells[i].JointCellMaster.Left - FOwner.LeftPosition - FDivLineWidth;
          LCellRect.Right := LCellRect.Left + AItem.Cells[i].JointCellMaster.Width;
          C := CreateRectRgnIndirect(LCellRect);
          CombineRgn(R, R, C, RGN_DIFF);
          DeleteObject(C);
          b := True;
        end;
      end;
      if b then
        SelectClipRgn(ACanvas.Handle, R);
    end;
    if FOwner.FUseThemeForSelection and FOwner.UseXPThemes and (LUseThemeMode <> ttmNone) and LMDSIWindowsVistaUp and (HasFocus or (not FOwner.HideSelection)) then
    begin
      lDetails.Element := teListView;
      lDetails.Part := 6;
      lDetails.State := 11;

      if (FOwner.HighlightAlphaLevel < 255) then
      begin
        LBmp := TBitmap.Create;
        try
          LBmp.Width := LMDRectWidth(LItemWholeRect);
          LBmp.Height := LMDRectHeight(LItemWholeRect);
          LMDThemeServices.DrawElement(LUseThemeMode, LBmp.Canvas.Handle, lDetails, Rect(0, 0, LBmp.Width, LBmp.Height), LMDRectToPtr(Rect(0, 0, LBmp.Width, LBmp.Height)));
          LMDAlphaCopyRect(ACanvas.Handle, LItemWholeRect, LBmp.Canvas.Handle, Rect(0, 0, LBmp.Width, LBmp.Height), FOwner.HighlightAlphaLevel, true);
        finally
          LBmp.Free;
        end;
      end
      else
        LMDThemeServices.DrawElement(LUseThemeMode, ACanvas.Handle, lDetails, LItemWholeRect, LMDRectToPtr(LItemWholeRect));
    end
    else
    begin
      ACanvas.Brush.Style := bsSolid;
      if HasFocus then
      begin
        ACanvas.Brush.Color := FOwner.FocusedSelectColor;
        LMDAlphaFillRect(ACanvas, LItemWholeRect, ACanvas.Brush.Color, FOwner.HighlightAlphaLevel);
      end
      else
      if (not FOwner.HideSelection) then
      begin
        ACanvas.Brush.Color := FOwner.HideSelectColor;
        LMDAlphaFillRect(ACanvas, LItemWholeRect, ACanvas.Brush.Color, FOwner.HighlightAlphaLevel);
      end;
    end;
    if FOwner.ShowColumns then
    begin
      SetRectRgn(R, LClipRect.Left, LClipRect.Top, LClipRect.Right, LClipRect.Bottom);
      if b then
        SelectClipRgn(ACanvas.Handle, R);
      DeleteObject(R);
    end;
  end;
{!!!!!!!!!!!!!!!!!!! DoRedrawItem - begin}
// =============================================
var
  LIsDrawFocusRect: Boolean;
  LDropTrgRect: TRect;
  LItemWholeRect: TRect;
  LDivLineWidth: Integer;
//  FakeStaticDataEx: TElXTreeItemStaticDataEx;
//  CurStaticDataEx: TElXTreeItemStaticDataEx;
begin
  LUseThemeMode := FOwner.UseThemeMode;
  LItemWholeRect := Rect(ASurfRect.Left - FOwner.FLeftPosition, AItemRect.Top,
    ASurfRect.Right - 1 - FOwner.FLeftPosition, AItemRect.Bottom);
  LDivLineWidth := FDivLineWidth;
  if (FOwner.FVirtualityLevel > vlNone) and (not (csDesigning in FOwner.ComponentState)) then
  begin
    if not Assigned(AItem.FVirtStyle) then
      AItem.FVirtStyle := TElXCellStyle.Create(AItem,nil);
    FOwner.TriggerVirtualStyleNeeded(AItem,-1,AItem.FVirtStyle);
  end;

  if (FOwner.FVirtualityLevel = vlAllProps) and (not (csDesigning in FOwner.ComponentState)) then
  begin
    if not Assigned(AItem.FStaticDataEx) then
      AItem.NewStaticDataEx;
    FOwner.TriggerVirtualPropsNeeded(AItem, AllVirtPropTypes, AItem.FStaticDataEx);
  end;

  FOwner.TriggerItemPreDrawEvent(AItem);

  if AItem.Selected and (FOwner.FullRowSelect or FOwner.RowSelect) and (not FOwner.BarStyle) and (FOwner.HighlightAlphaLevel = 255) then
    DrawSelectedBk(AItem, LItemWholeRect);

  if (FHeader.Sections.Count > 0) and (FOwner.FShowColumns) and (not AItem.WholeLine) then
    DrawColumns(LDivLineWidth)
  else
    DrawItemWithoutColumns(AItem, AItemRect);

  if AItem.Selected and FOwner.FullRowSelect and (not FOwner.BarStyle) and
    (AItem = FFocused) and FOwner.DrawFocusRect then
    DrawFramedBk(AItem, LItemWholeRect);

  if AItem.Selected and (FOwner.FullRowSelect or FOwner.RowSelect) and (not FOwner.BarStyle) and (FOwner.HighlightAlphaLevel < 255) then
    DrawSelectedBk(AItem, LItemWholeRect);

  CalcItemBounds(0, LItemWholeRect, LDropTrgRect);

  LIsDrawFocusRect := FHasFocus and (not FOwner.FHideFocusRect);
  FOwner.TriggerItemPostDrawEvent(ACanvas, AItem, LItemWholeRect, LIsDrawFocusRect);
  DrawItemRect(LItemWholeRect, LDropTrgRect, AItem, LIsDrawFocusRect);
end;

function TElXTreeView.GetVisiblesHeight: Integer;
var i: Integer;
begin
  Result := 0;
  for i := 0 to ColorHelper.Visible.Count - 1 do
    Inc(Result, TElXTreeItem(ColorHelper.Visible[i]).GetHeight);
end;

procedure TElXTreeView.DrawHorzLine(const ACanvas: TCanvas; const Item: TElXTreeItem; const R: TRect);
begin
  ACanvas.MoveTo(R.Left, R.Top - 1);
  ACanvas.LineTo(R.Right, R.Top - 1);
end;

procedure TElXTreeView.DrawVertLine(const ACanvas: TCanvas; const Item: TElXTreeItem; const R: TRect; OnRight: Boolean = True);
begin
  if OnRight then
  begin
    ACanvas.MoveTo(R.Right - 1, R.Top);
    ACanvas.LineTo(R.Right - 1, R.Bottom);
  end
  else
  begin
    if FOwner.RightAlignedView then
    begin
      ACanvas.MoveTo(R.Left + 1, R.Top);
      ACanvas.LineTo(R.Left + 1, R.Bottom);
    end
    else
    begin
      ACanvas.MoveTo(R.Left - 1, R.Top);
      ACanvas.LineTo(R.Left - 1, R.Bottom);
    end;
  end;
end;

procedure TElXTreeView.DrawGutter(ACanvas: TCanvas; Item: TElXTreeItem; const R: TRect);
const
  CArrowOffset = 5;
var
//  LItem: TElXTreeItem;
//  LIsLast: Boolean;
  LR: TRect;
  LClipRect, BgRect: TRect;
  LCenter, LHeight: Integer;
  LSaveColor: TColor;
  // LTheme: HTheme;
  Tmp1: TBitmap;
  LUseThemeMode: TLMDThemeMode;
begin
  LUseThemeMode := FOwner.UseThemeMode;
  if FOwner.FGutterWidth = 0 then
    Exit;

  LSaveColor := ACanvas.Brush.Color;

  LR := R;
  if Owner.RightAlignedView then
  begin
    LR.Right := Width;
    LR.Left := (LR.Right - FOwner.FGutterWidth)// + 1
  end
  else
    LR.Right := (LR.Left + FOwner.FGutterWidth);// - 1;
  if LUseThemeMode <> ttmNone then
  begin
    LClipRect := ACanvas.ClipRect;
    if LMDSIWindowsVistaUp and (LUseThemeMode <> ttmNative) then
      inc(LR.Bottom);
    if Owner.FRightAlignedView and not (SysLocale.MiddleEast) then
    begin
      Tmp1 := TBitmap.Create;
      Tmp1.Width := LR.Right - LR.Left + 4;
      Tmp1.Height := LR.Bottom - LR.Top;
      Tmp1.PixelFormat := pf24bit;
      BgRect := Rect(2, 0, Tmp1.Width - 2, Tmp1.Height);
      if Item.Focused then
        LMDThemeServices.DrawElement(LUseThemeMode, Tmp1.Canvas.Handle, thHeaderItemPressed,
          BgRect, LMDRectToPtr(BgRect))
      else
        LMDThemeServices.DrawElement(LUseThemeMode, Tmp1.Canvas.Handle, thHeaderItemNormal,
          BgRect, LMDRectToPtr(BgRect));
      LMDBmpFlipHorizontal(Tmp1, Rect (0, 0, Tmp1.Width - 1, Tmp1.Height - 1), Tmp1, Point (0,0));
      BitBlt(ACanvas.Handle, LR.Left, LR.Top, Tmp1.Width - 2, Tmp1.Height, Tmp1.Canvas.Handle, 0, 0, SRCCOPY);
      Tmp1.Free;
    end
    else
    begin
      if Item.Focused then
        LMDThemeServices.DrawElement(LUseThemeMode, ACanvas.Handle, thHeaderItemPressed,
          LR, LMDRectToPtr(LClipRect))
      else
        LMDThemeServices.DrawElement(LUseThemeMode, ACanvas.Handle, thHeaderItemNormal,
          LR, LMDRectToPtr(LClipRect));
    end;
  end
  else
  begin
    ACanvas.Brush.Color := FOwner.Color;
//    ACanvas.FillRect(Rect(
//      LR.Left,
//      LR.Top - 1,
//      LR.Left + (FOwner.FGutterWidth + 1),
//      LR.Bottom + 1
//      ));
    ACanvas.FillRect(LR);
    if FOwner.Flat then
      DrawEdge(ACanvas.Handle, LR, BDR_RAISEDINNER, BF_RECT)
    else
      Frame3D(ACanvas, LR, clBtnHighlight, cl3DDkShadow, 2); // TopColor, BottomColor, BevelWidth);
  end;

  if Item.Focused then
  begin
    ACanvas.Pen.Color := clBlack;
    ACanvas.Pen.Style := psSolid;
    ACanvas.Pen.Width := 1;
    ACanvas.Brush.Color := clBlack;
    ACanvas.Brush.Style := bsSolid;
    LHeight := Min(R.Bottom - R.Top - 4,FOwner.FGutterWidth);
    LCenter := (R.Top + R.Bottom) div 2;
    if (LHeight mod 2) = 1 then
      Dec(LHeight);
    if not Owner.RightAlignedView then
      ACanvas.Polygon([
        Point(LR.Left + CArrowOffset, LCenter - LHeight div 2 + 2),
        Point(LR.Left + CArrowOffset + LHeight div 2 - 2, LCenter),
        Point(LR.Left + CArrowOffset, LCenter + LHeight div 2 - 2)
      ])
    else
      ACanvas.Polygon([
        Point(LR.Right - 1 - CArrowOffset, LCenter - LHeight div 2 + 2),
        Point(LR.Right - 1 - CArrowOffset - LHeight div 2 + 2, LCenter),
        Point(LR.Right - 1 - CArrowOffset, LCenter + LHeight div 2 - 2)
      ]);
  end;
{  if Owner.VerticalLines and Owner.VerticalLinesLong and not LMDSIWindowsVistaUp then
  begin
    ACanvas.Pen.Color := Owner.VertDivLinesColor;
    ACanvas.MoveTo(LR.Right - 1, lR.Top);
    ACanvas.LineTo(LR.Right - 1, LR.Bottom);
  end; }
  ACanvas.Brush.Color := LSaveColor;
end;

procedure TElXTreeView.RedrawTree(ACanvas: TCanvas; ARealLeftPos: Integer; AItemsList: TLMDObjectList);
var
  LItemIndex, i, LeftWidth: Integer;
  LItemRect: TRect;
  LClipRect: TRect;
  LItemInternalsRect, LNextItemRect: TRect;
  //LTreeViewRect: TRect;
  LItem: TElXTreeItem;
  //LBrushStyleOrig: TBrushStyle;
  //LLeftPosOrig: Integer;
begin
  if FOwner.BackgroundType in [bgtColorFill] then
  begin
    ACanvas.Brush.Color := FOwner.FBackGroundColor;
    ACanvas.Brush.Style := bsSolid;
    ACanvas.FillRect(ACanvas.ClipRect);
  end;
  if FOwner.ShowColumns then
  begin
    if (FHeader.Left <> FOwner.FLeftPosition) {or (Width <> FLeftPosition + FView.Width) }then
    begin
      FHeader.LeftPos := FOwner.FLeftPosition;
      //Width := FLeftPosition + FView.Width;
    end;
  end;
  //LLeftPosOrig := FOwner.FLeftPosition;
  FOwner.FLeftPosition := ARealLeftPos;
  FHeader.LeftPos := ARealLeftPos;

  if FHeader.Sections.Count <= FOwner.MainTreeColumn then
     FOwner.MainTreeColumn := 0;

  //LBrushStyleOrig := ACanvas.Brush.Style;
  // redraw items
  LItemIndex := 0;
  LItem := nil;
  while LItemIndex < AItemsList.Count do
  begin
    LItemRect := GetItemRect(LItemIndex);
    LItem := TElXTreeItem(AItemsList[LItemIndex]);
    if IntersectRect(LClipRect, LItemRect, ACanvas.ClipRect) then
    begin
      LItemInternalsRect := LClipRect;
      LItemInternalsRect.Bottom := LItemInternalsRect.Top + LItem.Height;
      if (FOwner.FixedBottomRowNum > 0) and  (LItemIndex = AItemsList.Count - FOwner.FixedBottomRowNum - 1) then
      begin
        LNextItemRect := GetItemRect(LItemIndex + 1);
        LItemInternalsRect.Bottom := min(LItemInternalsRect.Bottom, LNextItemRect.Top);
      end;
      if FOwner.ShowColumns then
        if FOwner.FullRowSelect then
          LItemInternalsRect.Right := Max(FHRange, FOwner.FLeftPosition + Self.Width)
        else
          LItemInternalsRect.Right := FHeader.SectionsWidth
      else
      begin
        LItemRect.Right := Max(FHRange, FOwner.FLeftPosition + Self.Width);
        LItemInternalsRect.Right := LItemRect.Right;
      end;
      if LItemInternalsRect.Left < LItemInternalsRect.Right then
        DoRedrawItem(ACanvas, LItem, LItemRect, LItemInternalsRect, True, LItem.AbsoluteIndex, FOwner.FTopIndex + LItemIndex);
      if (FOwner.FixedBottomRowNum > 0) and (LItemIndex = AItemsList.Count - FOwner.FixedBottomRowNum - 1) then
        LItemRect.Bottom := LItemInternalsRect.Bottom;

      FOwner.View.DrawGutter(ACanvas, LItem, LItemRect);

    end;
    Inc(LItemIndex);
  end;
  if FMouseSel then
    DrawMouseSelectFrame;
  if FOwner.VerticalLines and FOwner.ShowColumns and (FOwner.FVerticalLinesLong or ((Assigned(LItem)) and (LItem.GetNextSibling <> nil) and (not LItem.GetNextSibling.Hidden))) then
  begin
    LClipRect := ACanvas.ClipRect;
    LClipRect.Top := min(LClipRect.Bottom, LItemRect.Bottom);
    if (LClipRect.Bottom - LClipRect.Top) > 1 then
    begin
      ACanvas.Pen.Color := FOwner.FVertDivLinesColor;
 //     if not FOwner.RightAlignedView then
      begin
        if Owner.RightAlignedView then
        begin
          if FOwner.FGutterWidth > 0 then
          begin
            LClipRect.Right := max(Width - FOwner.FGutterWidth + 1, 0);
            DrawVertLine(ACanvas,nil,LClipRect, True);
          end;
          LeftWidth := LClipRect.Right;
          FHeader.CalcFixedColWidth;
          for i := 0 to FHeader.FixedColNum - 1 do
            if FHeader.Sections[i].Visible then
            begin
              LClipRect.Left := FHeader.Sections[i].Left;
              if LClipRect.Left < LeftWidth then
                DrawVertLine(ACanvas, nil, LClipRect, False);
            end;
           LeftWidth := max(Width - FHeader.FixedColWidth, 0);
   //       DrawVertLine(ACanvas, nil, LClipRect, False);
          for i := FHeader.FixedColNum to FHeader.Sections.Count - 1 do
            if FHeader.Sections[i].Visible then
            begin
              LClipRect.Left := FHeader.Sections[i].Left - FOwner.FLeftPosition;
              if LClipRect.Left < LeftWidth then
                DrawVertLine(ACanvas,nil, LClipRect, False);
            end;
//          LClipRect.Left := FHeader.SectionsWidth + FOwner.FGutterWidth - FHeader.FHPos;
//          DrawVertLine(ACanvas,nil, LClipRect, false);
        end
        else
        begin
          if FOwner.FGutterWidth > 0 then
          begin
            LClipRect.Left := max(FOwner.FGutterWidth - 1, 0);
            DrawVertLine(ACanvas,nil,LClipRect, False);
          end;
          LeftWidth := FOwner.FGutterWidth;
          FHeader.CalcFixedColWidth;
          for i := 0 to FHeader.FixedColNum - 1 do
            if FHeader.Sections[i].Visible then
            begin
              LClipRect.Left := FHeader.Sections[i].Right - 1;
              if LClipRect.Left >= LeftWidth then
                DrawVertLine(ACanvas, nil, LClipRect, False);
            end;
          LeftWidth := FHeader.FixedColWidth;
          LClipRect.Left := LeftWidth;
          for i := FHeader.FixedColNum to FHeader.Sections.Count - 1 do
            if FHeader.Sections[i].Visible then
            begin
              LClipRect.Left := FHeader.Sections[i].Right - FOwner.FLeftPosition - 1;
              if LClipRect.Left >= LeftWidth then
                DrawVertLine(ACanvas,nil, LClipRect, False);
            end;
//          LClipRect.Left := FHeader.SectionsWidth + FOwner.FGutterWidth - FHeader.FHPos;
//          DrawVertLine(ACanvas,nil, LClipRect, false);
        end;
      end;
    end;
  end;
end;

procedure TElXTreeView.IntMouseMove(X, Y: Integer; Shift: TShiftState);
var
  LSelectedItem: TElXTreeItem;
  R: Trect;
  LItemPart: TSTXItemPart;
  HCol: Integer;
  P: TPoint;
  LCanDrag: Boolean;
  dataObj: IDataObject;
  dropSource: IDropSource;
  OKEffects: TDragTypes;
  Effect: TDragType;
  dwOKEffects, dwEffect: Integer;
  HRes: HResult;
  href: TLMDString;
  OldHTMLData, HTMLData: TLMDHTMLData;
  vHint:String;
  vText: TLMDString;
begin
  if Sqrt(Sqr(Abs(FLastMouseXPos - X)) + Sqr(Abs(FLastMouseYPos - Y))) < 2  then
    exit;

  FLastMouseXPos := X;
  FLastMouseYPos := Y;

  HCol := 0;
  LSelectedItem := GetItemAt(X, Y, LItemPart, HCol);

  if (LItemPart = ipGutter) then
    Invalidate;

  if Assigned(LSelectedItem) and ((LItemPart = ipColumn) or (LItemPart = ipMainText)) then
  begin
    if (HCol = FOwner.FMainTreeColumn) and (FOwner.MainTreeColumn >= LSelectedItem.Cells.Count) then
    begin
      HTMLData := LSelectedItem.FHTMLData;
      vText := LSelectedItem.Text;
    end
    else
    begin
      if Assigned(LSelectedItem.FHTMLDataArray) then
        HTMLData := TLMDHTMLData(LSelectedItem.FHTMLDataArray[HCol])
      else
        HTMLData := nil;
      vText := LSelectedItem.Cells[Hcol].Text;
    end;

    if Assigned(HTMLData) then
    begin
      OldHTMLData := FRender.Data;
      FRender.SetData(HTMLData);
      p := Point(x-HTMLData.Rect.Left, y-HTMLData.Rect.Top {- LSelectedItem.FTextRect.Top});
      if Owner.ShowColumns then
        p.X := p.X - FHeader.Sections[HCol].Left + FOwner.FLeftPosition
      else
        p.X := p.X - FOwner.GutterWidth;
      if FRender.IsCursorOverLink(P, Point(0,0), HTMLData.Rect, href) then
      begin
        Cursor := FOwner.FLinkCursor;
        if Assigned(FOwner.FOnLinkOver) then
          FOwner.FOnLinkOver(Self, HRef, X, Y);
      end
      else
        Cursor := FOwner.FCursor;
      FRender.SetData(OldHTMLData);
    end
    else
    begin
      p := Point(x, y);
      if Owner.ShowColumns then
        p.X := p.X - FHeader.Sections[HCol].Left + FOwner.FLeftPosition;
      p.Y := p.Y - LSelectedItem.FTextRect.Top;
      if (LItemPart = ipMainText) or (HCol = Owner.MainTreeColumn) then
      begin
        Frender.PrepareText(vText, LSelectedItem.FTextRect.Right - LSelectedItem.FTextRect.Left, (LSelectedItem.WordWrap and LSelectedItem.Multiline));
        p.X := X - LSelectedItem.FTextRect.Left;
      end
      else
        Frender.PrepareText(vText, LSelectedItem.Cells[HCol].Width, (LSelectedItem.WordWrap and LSelectedItem.Multiline));
      if FRender.IsCursorOverLink(P, Point(0,0), Frender.Data.Rect, href) then
        Cursor := FOwner.FLinkCursor
      else
        Cursor := FOwner.FCursor;
    end;
  end
  else
    Cursor := FOwner.FCursor;

  if Dragging then
    Exit;

  if FPressed then
  begin
    if Assigned(LSelectedItem) and (LItemPart = ipOutside) and FOwner.RowSelect then
      LItemPart := ipMainText;

    p := Mouse.CursorPos;
    LCanDrag := (LItemPart <> ipOutside)
      and not FMouseSel
      and FOwner.DragAllowed
      and (
        (FOwner.MultiSelect and Assigned(FOwner.FSelectedList) and (FOwner.FSelectedList.Count > 0))
        or
        (not FOwner.MultiSelect and Assigned(FSelected))
      )
      and (Sqrt(Sqr(FPressCoord.X - p.X) + Sqr(FPressCoord.Y - p.Y)) >= 5);
    if LCanDrag then
      DoCanDrag(LSelectedItem, LCanDrag);
    if LCanDrag then
    begin
      if FEditTimer <> nil then
         FEditTimer.Enabled := False;

      FClickPassed := False;
      FPassedItem := nil;
      FIgnoreClick2 := True;

      if FOwner.DragType <> dtOLE then
        BeginDrag(True)
      else
      begin
        FClickPassed := False;
        FPassedItem := nil;
        dataObj := nil;
        dropSource := nil;
        OKEffects := [];
        FOwner.TriggerOleDragStartEvent(dataObj, dropSource, OKEffects);
        dwOkEffects := 0;
        if dtCopy in OKEffects then
          dwOkEffects := dwOkEffects or DROPEFFECT_COPY;
        if dtMove in OKEffects then
          dwOkEffects := dwOkEffects or DROPEFFECT_MOVE;
        if dtLink in OKEffects then
          dwOkEffects := dwOkEffects or DROPEFFECT_LINK;
        FPressed := False;

        if Assigned(DataObj) and Assigned(dropSource) then
        begin
          dwEffect := DROPEFFECT_NONE;
          Effect := dtNone;
          HRes := DoDragDrop(dataObj, dropSource, dwOKEffects, dwEffect);
          if (dwEffect and DROPEFFECT_COPY) <> 0 then
            Effect := dtCopy;
          if (dwEffect and DROPEFFECT_LINK) <> 0 then
            Effect := dtLink;
          if (dwEffect and DROPEFFECT_Move) <> 0 then
            Effect := dtMove;
          FOwner.TriggerOleDragFinishEvent(Effect, HRes);
        end;
      end;
    end
    else
    if {(not FOwner.RowSelect) and} FOwner.FMouseFrameSelect and (ColorHelper.Visible.Count > 0) and (FOwner.MultiSelect) then
    begin
      FClickPassed := False;
      FPassedItem := nil;

      if not FMouseSel then
      begin
        p := Mouse.CursorPos;
        if (Sqrt(Sqr(FPressCoord.X - p.X) + Sqr(FPressCoord.Y - p.Y)) >= 5) then
        begin
          if Assigned(LSelectedItem) then
            R := GetItemRect(ColorHelper.Visible.IndexOf(LSelectedItem))
          else
            R := Rect(0, 0, 0, 0);
          p := FOwner.ScreenToClient(FPressCoord);
          FMouseFrameRec.StartItem := LSelectedItem;
          FMouseFrameRec.StartCoord.x := P.X + FOwner.FLeftPosition;
          FMouseFrameRec.StartCoord.y := Y - R.Top;
          FMouseFrameRec.EndItem := LSelectedItem;
          if FOwner.RowSelect then
          begin
            FMouseFrameRec.StartColumn := 0;
            FMouseFrameRec.EndColumn := FOwner.HeaderSections.Count - 1;
          end
          else
          begin
            FMouseFrameRec.StartColumn := HCol;
            FMouseFrameRec.EndColumn := HCol;
          end;
          FMouseFrameRec.EndCoord := FMouseFrameRec.StartCoord;
          if not (ssCtrl in LMDGetShiftState) then
          begin
            //FOwner.DeselectAll;
            FOwner.DoAfterSelectionChange;
          end;
          SetCapture(Handle);
//          if FOwner.FMouseFrameVisible then
//            AllocateMouseSelectFrame;
          FMouseSel := True;
//              FMouseFrameRec.CellList := TLMDObjectList.Create;
        end;
      end
      else
      begin
//        if FOwner.MouseFrameVisible then
//          DrawMouseSelectFrame;
        if PtInRect(ClientRect, Point(X, Y)) then
        begin
          if Assigned(LSelectedItem) then
            R := GetItemRect(ColorHelper.Visible.IndexOf(LSelectedItem))
          else
            R := Rect(0, 0, 0, 0);
          FMouseFrameRec.EndItem := LSelectedItem;
          if FOwner.RowSelect then
            FMouseFrameRec.EndColumn := FOwner.HeaderSections.Count - 1
          else
            FMouseFrameRec.EndColumn := HCol;
          FMouseFrameRec.EndCoord.X := X + FOwner.FLeftPosition;
          FMouseFrameRec.EndCoord.Y := Y - R.Top;
          SelectMouseSelectItems;
          FOwner.DoAfterSelectionChange;
        end
        else
        begin
          if Y >= ClientHeight then
            SetTopIndex(FOwner.FTopIndex + 1)
          else
          if Y < 0 then
            SetTopIndex(FOwner.FTopIndex - 1);
          if X >= ClientWidth then
            SetLeftPosition(FOwner.FLeftPosition + 4)
          else
          if X < 0 then
            SetLeftPosition(FOwner.FLeftPosition - 4);
          Invalidate; //Update;
        end;
//        if FOwner.MouseFrameVisible then
//          DrawMouseSelectFrame;
      end;
    end;
  end; // if Pressed

  if not FMouseSel and (Assigned(FHintItemEx) or not ShowHint) then
  begin
    if Assigned(LSelectedItem) then
    begin
      if (FHintItemEx <> LSelectedItem) or (HCol <> FHintCol) then
      begin
        vHint := LSelectedItem.Hint;
        if vHint <> '' then
        begin
           Application.Hint := vHint;
           Hint := vHint;
        end;
        P := ClientToScreen(Point(X, Y));
        if ShowHint and (not FInDragging) and (abs(P.X - FHintCoord.X)+ abs(P.Y - FHintCoord.Y) > 10) then
        begin
          FHintCoord := P;
          Application.ActivateHint(P);
        end;
      end;
    end
    else
    begin
      Application.Hint := FOwner.FRealHint;
      Hint := FOwner.FRealHint;
    end;
  end;

  if not FMouseSel and (FOwner.FLineHintMode <> shmNone) then
  begin
    if (FHintCoord.X <> X) or (FHintCoord.Y <> Y) then
    begin
      LSelectedItem := GetItemAtY(Y);
      if (FOwner.FHideHintOnMove or (LSelectedItem <> nil)) and ((FHintItem <> LSelectedItem) or (HCol <> FHintCol)) then
      begin
        DoHideLineHint;
        FHintItem := nil;
        FHintCoord := Point(X, Y);
        FHintCol := HCol;
        FHintTimer := TTimer.Create(self);
        FHintTimer.Enabled := False;
        FHintTimer.OnTimer := OnHintTimer;
        FHintTimer.Interval := Application.HintPause; // old value HintShortPause was changed to show hint like in explorer.
        if FHintTimer.Interval = 0 then
           FHintTimer.Interval := 1000;
        FHintTimer.Enabled := True;
      end;
    end;
  end;
  if FOwner.FHotTrack {and Focused }and not FMouseSel then
  begin
    LSelectedItem := FTrackItem;
    if FOwner.IsEditing then
      FTrackItem := nil
    else
    FTrackItem := GetItemAtY(Y);
{$ifdef HOTTRACK_CURSOR}
    if (FTrackItem = nil) and (Cursor <> crDefault) then
      Cursor := crDefault;
{$endif}
    if LSelectedItem = FTrackItem then
      Exit;
    if not FOwner.IgnoreEnabled and (FTrackItem <> nil) and not FTrackItem.Enabled then
      FTrackItem := nil;

    if LSelectedItem <> nil then
    begin
      if not FOwner.ShowColumns or FOwner.FRowHotTrack or FOwner.FHotTrack or LSelectedItem.WholeLine then
        LSelectedItem.RedrawItem(False)
      else
      begin
        R := GetItemRect(ColorHelper.Visible.IndexOf(LSelectedItem));
        with FOwner do
        begin
          R.Left := FHeader.Sections[FMainTreeColumn].Left - FLeftPosition;
          R.Right := FHeader.Sections[FMainTreeColumn].Right - FLeftPosition;
        end;
//        InvalidateRect(Handle, @R, True);
      end;
    end;
    if FTrackItem <> nil then
    begin
      if (not FOwner.ShowColumns) or FOwner.FRowHotTrack or FOwner.FHotTrack or FTrackItem.WholeLine then
        FTrackItem.RedrawItem(False)
      else
      begin
        R := GetItemRect(ColorHelper.Visible.IndexOf(FTrackItem));
        with FOwner do
        begin
          R.Left := FHeader.Sections[FMainTreeColumn].Left - FLeftPosition;
          R.Right := FHeader.Sections[FMainTreeColumn].Right - FLeftPosition;
        end;
//        InvalidateRect(Handle, @R, True);
      end;
    end;
    FOwner.TriggerHotTrackEvent(LSelectedItem, FTrackItem);
{$ifdef HOTTRACK_CURSOR}
    if not (Owner = nil) and (Cursor <> Owner.TrackingCursor) then
      Cursor := Owner.TrackingCursor;
{$endif}
    //Update;
  end; // if (FHotTrack and Focused)
end;

function TElXTreeView.IntLButtonDown(X, Y: Integer; Shift: TShiftState): Boolean;
begin
  if FEditTimer <> nil then
     FEditTimer.Enabled := False;
  DoHideLineHint;
  FIgnoreClick2 := False;
  // this has been moved to MouseDown
  if FOwner.IsEditing and Assigned(FInpEdit) then
  begin
    Result := True;
    FInpEdit.TriggerValidateResult(Result);
  end
  else
    Result := True;
  if Result then
  begin
    if not (csDesigning in ComponentState) and not Focused and CanFocus then
      SetFocus;
    FPressCoord := Mouse.CursorPos;
    FPressed := True;
  end;
end;

function TElXTreeView.IntLButtonUp(X, Y: Integer; Shift: TShiftState): Boolean;
var
  LItem, Item1: TElXTreeItem;
  ItemPart: TSTXItemPart;
//  HCol: Integer;
  i: Integer;
  Ctrl: TElXCellControl;
  b: Boolean;
  AStyle: TElXCellStyle;
  href: TLMDString;
  p: tpoint;
  od,htmldata: TLMDHTMLData;
  vText: TLMDString;
  LHitColumn: integer;
begin
  Result := False;
  if FOwner.IsEditing then
    exit;
  if FEditTimer <> nil then
     FEditTimer.Enabled := False;
  DoHideLineHint;
  FPressed := False;

  if FOwner.FCollapsing then
  begin
    FOwner.FCollapsing := False;
    exit;
  end;

  if FMouseSel then
  begin
    CancelMouseSel;
    FIgnoreClick2 := False;
    Exit;
  end;

  LItem := GetItemAt(X, Y, ItemPart, LHitColumn);

  if (LItem <> nil) and (ItemPart in [ipMainText, ipColumn]) and
      LMDInRange(LHitColumn, 0, FHeader.Sections.Count - 1) and
      not FHeader.Sections[LHitColumn].ClickSelect then
  begin
    LItem := nil;
    ItemPart := ipOutside;
    LHitColumn := -1;
  end;
  if (LItem = nil) or (LItem.Enabled) or (FOwner.IgnoreEnabled) then
  begin
    p := Mouse.CursorPos;
    if (FPressCoord.Y = p.Y) and (FPressCoord.X = p.X)
    // if the mouse was moved when the button was pressed, we don't check for editing
    and {(ItemPart <> ipInside) and }(ItemPart <> ipOutside) and (ItemPart <> ipButton) then
    begin
      if not FIgnoreClick2 then
      begin
        if (ItemPart in [ipMainText, ipColumn, ipInside]) and
           (LItem <> nil) and ((LItem = FClickItem) or FOwner.QuickEditMode) and LItem.AllowEdit
            and FOwner.FDoInplaceEdit and ((FClicked or FOwner.QuickEditMode) and (FOwner.FDblClickMode <> dcmEdit)) then
          InitiateEditOp(LItem, LHitColumn, False);
        FClicked := True;
        FClickCoord := Point(X, Y);
        FClickItem := LItem;
        FClickSection := LHitColumn;
      end;
    end;
    if LItem = nil then
      FClickItem := nil;
    FIgnoreClick2 := False;

    Result := True;

    if (LItem<>nil) and ((ItemPart=ipColumn) or (ItemPart=ipMainText)) then
    begin
      if (LHitColumn = FOwner.FMainTreeColumn) and (FOwner.MainTreeColumn >= LItem.Cells.Count) then
      begin
        htmldata := LItem.FHTMLData;
        vText := LItem.Text;
      end
      else
      begin
        vText := LItem.Cells[LHitColumn].Text;
        if LItem.FHTMLDataArray <> nil then
          htmldata := TLMDHTMLData(LItem.FHTMLDataArray[LHitColumn])
        else
          htmldata := nil;
      end;
      if htmldata <> nil then
      begin
        od := FRender.Data;
        FRender.SetData(htmldata);

        p := point(x-htmldata.Rect.Left, y-htmldata.Rect.Top {- Item.FTextRect.Top});
        if Owner.ShowColumns then
          p.X := p.X - FHeader.Sections[LHitColumn].Left + FOwner.FLeftPosition;
        if FRender.IsCursorOverLink(P, Point(0,0), htmldata.Rect, href) then
          FOwner.TriggerLinkClickEvent(href, X - Left, Y - Top);
        FRender.SetData(od);
      end
      else
      begin
        p := Point(x, y);
        if Owner.ShowColumns then
          p.X := p.X - FHeader.Sections[LHitColumn].Left + FOwner.FLeftPosition;
        p.Y := p.Y - LItem.FTextRect.Top;
        if (ItemPart = ipMainText) or (LHitColumn = Owner.MainTreeColumn) then
        begin
          Frender.PrepareText(vText, LItem.FTextRect.Right - LItem.FTextRect.Left, (LItem.WordWrap and LItem.Multiline));
          p.X := X - LItem.FTextRect.Left;
        end
        else
          Frender.PrepareText(vText, LItem.Cells[LHitColumn].Width, (LItem.WordWrap and LItem.Multiline));
        if FRender.IsCursorOverLink(P, Point(0,0), Frender.Data.Rect, href) then
          FOwner.TriggerLinkClickEvent(href, X - Left, Y - Top);
      end;
    end;

    // now check the CellControl
    b := (FClickControl <> nil);

    Item1 := GetItemAt(X, Y, ItemPart, LHitColumn);
    if Item1 <> LItem then
      exit;

    if ItemPart = ipColumn then
    begin
        if FOwner.VirtualityLevel = vlNone then
        begin
          i := LHitColumn;
          begin
            if LItem.Cells.Count > i then
              AStyle := LItem.Cells[i].CurrentStyle as TElXCellStyle
            else
              AStyle := LItem.CurrentStyle as TElXCellStyle;
          end;
        end
        else
        begin
          if LMDInRange(LHitColumn, 0, LItem.Cells.Count - 1) then
            AStyle := LItem.Cells[LHitColumn].Style
          else
            AStyle := VirtStyle;
        end;
        if (AStyle <> nil)
          //and (not AStyle.OwnerProps)
          and (AStyle.Control <> nil)
          and (TElXCellControl(AStyle.Control).Visible)
          and (TElXCellControl(AStyle.Control).Enabled) then
        begin
          with FOwner do
          begin
            Ctrl := TElXCellControl(AStyle.Control);
            if Ctrl <> nil then
            begin
              Ctrl.TriggerMouseUpEvent(mbLeft, Shift, X , Y);
              if Ctrl = FClickControl then
                Ctrl.TriggerClickEvent;
              b := False;
            end;
          end;
        end;
      //end;
    end;
    if b then
      FClickControl.TriggerMouseUpEvent(mbRight, LMDGetShiftState, -1, -1);
    FClickControl := nil;
  end;
end;

procedure TCustomElXTree.TriggerLinkClickEvent(HRef: string; X, Y: Integer);
begin
  if Assigned(FOnLinkClick) then
    FOnLinkClick(Self, HRef);
end;

procedure TElXTreeView.IntRButtonDown(X, Y: Integer; Shift: TShiftState);
begin
  if not (csDesigning in ComponentState) and
    (CanFocus or (GetParentForm(Self) = nil)) then
  SetFocus;
end;

function TElXTreeView.IntRButtonUp(X, Y: Integer; Shift: TShiftState): Boolean;
var
  ItemPart: TSTXItemPart;
  HCol: Integer;
  Item: TElXTreeItem;
  Ctrl: TElXCellControl;
  AStyle: TElXCellStyle;
  b: Boolean;
  APopupMenu: TPopupMenu;
  i: Integer;
begin
  Result := False;
  if FEditTimer <> nil then
     FEditTimer.Enabled := False;
  DoHideLineHint;

  b := (FClickControl <> nil);
  Item := GetItemAt(X, Y, ItemPart, HCol);
  if (Item = nil) or (Item.Enabled) or (FOwner.IgnoreEnabled) then
  begin
    if ItemPart = ipColumn then
    begin
      //if Item.UseStyles then
      //begin
        if FOwner.VirtualityLevel = vlNone then
        begin
          i := HCol;
          if i = FOwner.FMainTreeColumn then
            AStyle := Item.CurrentStyle as TElXCellStyle
          else
          begin
//            if i > FOwner.FMainTreeColumn then
//              Dec(i);
            if Item.Cells.Count > i then
              AStyle := Item.Cells[i].CurrentStyle as TElXCellStyle
            else
              AStyle := Item.CurrentStyle as TElXCellStyle;
          end;
        end
        else
        begin
          if LMDInRange(HCol, 0, Item.Cells.Count - 1) then
            AStyle := Item.Cells[HCol].Style
          else
            AStyle := VirtStyle;
//          FOwner.TriggerVirtualStyleNeeded(Item, HCol, AStyle);
        end;
        if (AStyle <> nil)
          //and (not AStyle.OwnerProps)
          and (AStyle.Control <> nil)
          and (TElXCellControl(AStyle.Control).Visible)
          and (TElXCellControl(AStyle.Control).Enabled) then
        begin
          with FOwner do
          begin
            Ctrl := TElXCellControl(AStyle.Control);
            // if Ctrl <> nil then
            begin
              Ctrl.TriggerMouseUpEvent(mbRight, Shift, X , Y);
              if Ctrl = FClickControl then
                Ctrl.TriggerClickEvent;
              APopupMenu := Ctrl.PopupMenu;
              if (APopupMenu <> nil) and APopupMenu.AutoPopup then
              begin
                SendCancelMode(nil);
                APopupMenu.PopupComponent := Ctrl;
                with ClientToScreen(Point(X, Y)) do
                  APopupMenu.Popup(X, Y);
                Exit;
              end
              else
                Result := True;
            end;
          end;
        end;
      //end;
    end;
    if b and (FClickControl <> nil) then
       FClickControl.TriggerMouseUpEvent(mbRight, LMDGetShiftState, -1, -1);
    FClickControl := nil;
    if (not b) then
      Result := True;
  end;
end;

function TElXTreeView.IntLButtonDblClick(X, Y: Integer; Shift: TShiftState):
    Boolean;
var
  ItemPart: TSTXItemPart;
  HCol: Integer;
  Item,
  FOldSelected: TElXTreeItem;
  Ctrl: TElXCellControl;
  i: Integer;
begin
  Result := False;
  if FEditTimer <> nil then
     FEditTimer.Enabled := False;
  HCol := 0;
  Item := GetItemAt(X, Y, ItemPart, HCol);
  if (Item = nil) or (Item.Enabled) or (FOwner.IgnoreEnabled) then
  begin
    if (FOwner.FDblClickMode = dcmEdit) and FOwner.FDoInplaceEdit and (Item <> nil) and Item.AllowEdit and
       (ItemPart in [ipMainText, ipColumn, ipInside]) and
       ((Item = FClickItem) or FOwner.QuickEditMode) then
      begin
        InitiateEditOp(Item, HCol, True);
      end
    else
    if ((ItemPart = ipMainText) or ((Item <> nil) and (FOwner.FRowSelect) and (ItemPart <> ipCheckBox))) and (FOwner.FDblClickMode = dcmExpand) then
    begin
      if Item.Expanded then
      begin
        FOldSelected := FFocused;
        Item.Expanded := False;
        if FOwner.MoveFocusOnCollapse and (FOldSelected <> FFocused) then
        begin
          FOwner.DoAfterSelectionChange;
          FOwner.DoItemFocused;
        end;
      end
      else
      begin
        Item.Expanded := True;
        FitMostChildren(Item);
      end;
    end;
    if (ItemPart = ipColumn) then
    begin
      i := HCol;
//      if i > FOwner.FMainTreeColumn then
//        Dec(i);
      if {Item.UseStyles and} (Item.Cells.Count > HCol) then
      begin
        //if not Item.Cells[i].Style.OwnerProps then
        //begin
          if Assigned(Item.Cells[i].Style) then
            Ctrl := TElXCellControl(Item.Cells[i].Style.Control)
          else
            Ctrl := nil;
          if Ctrl <> nil then
          begin
            Ctrl.TriggerDblClickEvent;
            Exit;
          end;
        //end;
      end;
    end;
    FClicked := False;
    FClickItem := nil;
    FClickSection := -2;
    FIgnoreClick2 := True;
    if (ItemPart <> ipButton) and (ItemPart <> ipCheckBox) then
      Result := True;
    FIgnoreClick := False;
  end;
end;

function TElXTreeView.IntRButtonDblClick(X, Y: Integer; Shift: TShiftState):
    Boolean;
var
  ItemPart: TSTXItemPart;
  HCol: Integer;
  Item: TElXTreeItem;
  Ctrl: TElXCellControl;
  i: Integer;
begin
  Result := False;
  if FEditTimer <> nil then
     FEditTimer.Enabled := False;
  HCol := 0;
  Item := GetItemAt(X, Y, ItemPart, HCol);
  if (Item = nil) or (Item.Enabled) or (FOwner.IgnoreEnabled) then
  begin
    if (ItemPart = ipColumn) then
    begin
      i := HCol;
//      if i > FOwner.FMainTreeColumn then
//        Dec(i);
      if {Item.UseStyles and} (Item.Cells.Count > HCol) then
      begin
        //if not Item.Cells[i].Style.OwnerProps then
        //begin
          if Assigned(Item.Cells[i].Style) then
            Ctrl := TElXCellControl(Item.Cells[i].Style.Control)
          else
            Ctrl := nil;
          if Ctrl <> nil then
          begin
            Ctrl.TriggerDblClickEvent;
            Exit;
          end;
        //end;
      end;
    end;
    Result := True;
  end;
end;

procedure TElXTreeView.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TElXTreeView.OnEditTimer(Sender: TObject);
begin
  FEditTimer.Enabled := False;
  if FMouseSel or (FItemToEdit = nil) then
    Exit;
  DoEditItem(FItemToEdit, FEditSect);
end;

procedure TElXTreeView.DoEditItem(Item: TElXTreeItem; SectionNum: Integer);
var
  Section: TElHeaderSection;
  R1, R2, R3, R: TRect;
  Left, Right: Integer;
  TextWidth: Integer;
  LStyle: TElXCellStyleRead;
  FT: TElFieldType;
  Editor: TElTreeInplaceEditor;
  s: TLMDString;
  sn, FSectionNum, i, f1, f2: Integer;
  b, b1: Boolean;
  Cell: TElXTreeCell;
begin
  sn := 0;
  if Item = nil then
    raise EElTreeError.Create(STexInvItem);
  if ColorHelper.Visible.IndexOf(Item) = -1 then
    FOwner.EnsureVisible(Item);
  if (SectionNum = -1) then
     SectionNum := FOwner.MainTreeColumn;

  if Assigned(Item.Cells[SectionNum].Control) then
  begin
     Item.Cells[SectionNum].Control.SetControlActive;
     exit;
  end;
  if FInpEdit <> nil then
    DoEndEdit(True);

  if (FHeader.Sections.Count > SectionNum) and (SectionNum >= 0) then
  begin
    Section := FHeader.Sections[SectionNum];
    Cell := Item.Cells[Section.Index];
    if Cell.JointCellRole = jcrSlave then
      Cell := Cell.GetJointCellMaster;
    FSectionNum := FHeader.Sections[Cell.Index].Index;
    Section := FHeader.Sections[FSectionNum];
    FEditingItem := Cell.Owner;
  end
  else
  begin
    FSectionNum := -1;
    Section := nil;
    Cell := nil;
    FEditingItem := Item;
  end;

  if not FOwner.FDoInplaceEdit
    or not Item.Enabled
    or not Item.AllowEdit
    or ((FHeader.Sections.Count > 0) and (FSectionNum >= 0) and not Section.Editable)
  then
    Exit;

  FT := FOwner.MainTextType;
  if (FSectionNum <> -1) then
  begin
    if (not Section.Visible) then
    begin
      FEditingItem := nil;
      Exit;
    end;
    FT := Section.FieldType;
  end
  else
    Section := nil;
  if FOwner.VirtualityLevel = vlNone then
  begin
    if (FSectionNum = FOwner.MainTreeColumn) or (FSectionNum = -1) then
    begin
      if FEditingItem.UseOwnStyle then
        FT :=  FEditingItem.Style.CellType;
    end
    else
    begin
      if Cell.UseOwnStyle then
        FT := Cell.Style.CellType;
    end;
  end
  else
  begin
    if LMDInRange(FSectionNum, 0, FEditingItem.Cells.Count - 1) then
      LStyle := FEditingItem.Cells[FSectionNum].Style
    else
      LStyle := FEditingItem.Style;
//    FOwner.TriggerVirtualStyleNeeded(FEditingItem, FSectionNum, VirtStyle);
//    Style := VirtStyle;
    FT := LStyle.CellType;
  end;

  b := True;
  FOwner.TriggerTryEditEvent(FEditingItem, FSectionNum, FT, b);
  if not b then
    Exit;
  FOwner.TriggerInplaceEditorNeeded(FEditingItem, FSectionNum, FT, Editor);
  if (Editor = nil) and Assigned(Section) and (FHeader.Sections.Count > FSectionNum) then
  begin
    FT := Section.FieldType;
    b := True;
    FOwner.TriggerTryEditEvent(FEditingItem, FSectionNum, FT, b);
    if not b then
      Exit;
    FOwner.TriggerInplaceEditorNeeded(FEditingItem, FSectionNum, FT, Editor);
  end;
  if Editor = nil then
    Exit
  else
  begin
    if (Section = nil) or (Section.Index = FOwner.FMainTreeColumn) then
    begin
      s := FEditingItem.Text;
    end
    else
    begin
      if FEditingItem.FStaticData <> nil then
      begin
        sn := Section.Index;
        if Item.Cells.Count <= sn then
           s := ''
        else
           s := Item.Cells[sn].Text;
      end
      else
        FOwner.TriggerVirtualTextNeeded(FEditingItem, Section.Index, s);
    end;
    R := GetItemRect(ColorHelper.Visible.IndexOf(FEditingItem));
    if (Section = nil) or (not FOwner.ShowColumns) then
    begin
      if (FEditingItem.FTextRect.Left < FOwner.FLeftPosition) or (FEditingItem.FTextRect.Left > FOwner.FLeftPosition + Self.Width) then
         SetLeftPosition(FEditingItem.FTextRect.Left);
      if FOwner.RightAlignedView then
      begin
        R.Right := FEditingItem.FTextRect.Right - FOwner.FLeftPosition;
        R.Left := 0;
      end
      else
      begin
        R.Left := FEditingItem.FTextRect.Left - FOwner.FLeftPosition;
        R.Right := ClientWidth - 1;
      end;
    end
    else
    begin
      b1 := (Cell.Index >= FOwner.FixedColNum) and ((Cell.Left - FOwner.LeftPosition) < FHeader.FixedColWidth);
      if (FOwner.LeftPosition > Cell.Left) or ((Fowner.FixedColNum > 0) and b1) then
         if ((FOwner.FixedColNum > 0) and b1) then
           SetLeftPosition(Cell.Left - Item.Cells[FOwner.FixedColNum].Left)
         else
           SetLeftPosition(Cell.Left - FOwner.GutterWidth)
      else
        if (Cell.Left + Cell.Width) > (FOwner.LeftPosition + Width) then
          SetLeftPosition((Cell.Left + Cell.Width) - Width);

      //<-- VB June 2009: an adjustment for editors in cells so that text is not
      //shifted horizontally when inplace editor is activated
      R2 :=Cell.CellRect;
      R3 := R2;
      R1 := R2;
      if FOwner.FAdjustInplaceEditorPosition then
      begin
        f1 := DT_LEFT;
        if Cell.Style <> nil then
          f1 := Cell.Style.TextFlags;
        Cell.AdjustTextRect(FOwner.Canvas, R1, r2, R3, f1, f2);
      end;
      //-->

      if FOwner.RightAlignedView then
      begin
        if FSectionNum = FOwner.FMainTreeColumn then
        begin
          if FOwner.ShowColumns then
            Left := Cell.Left
          else
            Left := FEditingItem.FTextRect.Left;
          Right := FEditingItem.FTextRect.Right;
          TextWidth := Right - Left;
        end
        else
        begin
          Left := Cell.Left + R2.Left - R3.Left + 1; //VB June 2009: adjustment added
          Right := Cell.Left + Cell.Width;
          TextWidth := Cell.Width;
        end;

        //remark: the following change makes a fine tuning for tree editing behavior
        // in case the right of the section is hidden to the right or the section edit width is bigger than
        // the tree client width the section will be aligned to the right so we can see the maximum of the editing area,
        // otherwise, if the section is fully or partially hidden to the left and the width of the section edit is
        // smaller than the tree client width, the section will be aligned to the left.
        if (Right > FOwner.FLeftPosition + ClientWidth) or (TextWidth >= ClientWidth) then
           FOwner.SetLeftPosition(Right - ClientWidth)
        else
          if (Left < FOwner.FLeftPosition) then
           FOwner.SetLeftPosition(Left - FOwner.GutterWidth);

        R.Left := Left;
        R.Right := Right;
        if FSectionNum > FHeader.FixedColNum - 1 then
        begin
          R.Right := Right - FOwner.FLeftPosition;
          R.Left := Left - FOwner.FLeftPosition;
        end;
        if (FHeader.FixedColNum > 0) and (FSectionNum = FHeader.FixedColNum) then
          R.Right := min(R.Right, Width - FHeader.FixedColWidth - FOwner.GutterWidth);
        if R.Left < 0 then
          R.Left := 0;
      end
      else
      begin
        if FSectionNum = FOwner.FMainTreeColumn then
        begin
          Left := FEditingItem.FTextRect.Left;
          if FOwner.ShowColumns then
            Right := Cell.Left + Cell.Width
          else
            Right := FEditingItem.FTextRect.Right;
          TextWidth := Right - Left;
        end
        else
        begin
          Left := Cell.Left + R2.Left - R3.Left + 1; //VB June 2009: adjustment added
          Right := Cell.Left + Cell.Width;
          TextWidth := Cell.Width;
        end;

        //remark: the following change makes a fine tuning for tree editing behavior
        // in case the left of the section is hidden to the left or the section edit width is bigger than
        // the tree client width the section will be aligned to the left so we can see the maximum of the editing area,
        // otherwise, if the section is fully or partially hidden to the right and the width of the section edit is
        // smaller than the tree client width, the section will be aligned to the right.
        if (Left < FOwner.FLeftPosition) or (TextWidth >= ClientWidth) then
           FOwner.SetLeftPosition(Left - FOwner.GutterWidth)
        else
          if (Right > FOwner.FLeftPosition + ClientWidth) then
           FOwner.SetLeftPosition(Right - ClientWidth);

        R.Left := Left;
        R.Right := Right;
        if FSectionNum > FHeader.FixedColNum - 1 then
        begin
          R.Left := R.Left - FOwner.FLeftPosition;
          R.Right := R.Right - FOwner.FLeftPosition;
        end;
        if (FHeader.FixedColNum > 0) and (FSectionNum = FHeader.FixedColNum) then
          R.Left := max(R.Left, FHeader.FixedColWidth);
        if R.Right >= ClientWidth then
           R.Right := ClientWidth - 1;
      end;
    end;
    if FOwner.ShowColumns then
    begin
      R.Right := R.Right - FDivLineWidth;
//      R.Bottom := R.Bottom - FDivLineWidth;
    end;
    if Item.Cells.Count <= sn then
      R.Bottom := R.Bottom - FDivLineWidth
    else
      R.Bottom := R.Top + FEditingItem.Cells[sn].Height;
    if FOwner.HorizontalLines then
    begin
      R.Bottom := R.Bottom - 2 * FDivLineWidth;
      R.Top := R.Top + FDivLineWidth;
    end;
    if FOwner.VerticalLines then
    begin
      if FSectionNum = FOwner.FMainTreeColumn then
        i := 0
      else
        i := 1;
      if FOwner.RightAlignedView then
      begin
        R.Right := R.Right - i * FDivLineWidth;
        R.Left := R.Left + FDivLineWidth;
      end
      else
      begin
        R.Right := R.Right - FDivLineWidth;
        R.Left := R.Left + i * FDivLineWidth;
      end;
    end;
    FInpEdit := Editor;
    Editor.Tree := FOwner;
    Editor.ValueAsText := S;
    Editor.Item := Item;
    Editor.SectionIndex := SectionNum;
    Editor.Datatype := FT;
    Editor.CellRect := R;
    Editor.StartOperation;
  end;
end;

procedure TElXTreeView.DoEndEdit(ByCancel: Boolean);
begin
  if FInpEdit <> nil then
  begin
    FInpEdit.CompleteOperation(not ByCancel);
  end;
end;

procedure TElXTreeView.EditOperationCancelled;
var HeaderSection: TElHeaderSection;
begin
  if FInpEdit = nil then
    HeaderSection := nil
  else
    HeaderSection := FOwner.HeaderSections[FInpEdit.SectionIndex];
  FInpEdit := nil;
  FOwner.DoEndEditItem(FEditingItem, HeaderSection, True);
end;

procedure TElXTreeView.EditOperationAccepted;
var
  si: Integer;
begin
  if Assigned(FInpEdit) then
  begin
    si := FInpEdit.SectionIndex;
    if FOwner.VirtualityLevel = vlNone then
    begin
      if (si = FOwner.MainTreeColumn) or (si = -1) then
        FEditingItem.Text := FInpEdit.ValueAsText
      else
      begin
//        if si > FOwner.MainTreeColumn then
//          dec(si);
        while FEditingItem.Cells.Count <= si do
          FEditingItem.Cells.Add;
        FEditingItem.Cells[si].Text := FInpEdit.ValueAsText;
        Refresh;
      end;
    end;
    FInpEdit := nil;
    FOwner.DoEndEditItem(FEditingItem, FOwner.HeaderSections[si], False);
  end;
end;

procedure TCustomElXTree.EditItem(Item: TElXTreeItem; SectionNum: Integer);
begin
  if not FDoInplaceEdit then
    Exit;
  try
    with FView do
      if FInpEdit <> nil then
        EndEdit(True);
  except
  end;
  FView.DoEditItem(Item, SectionNum);
end;

procedure TCustomElXTree.EndEdit(ByCancel: Boolean);
begin
  FView.DoEndEdit(ByCancel);
end;

procedure TElXTreeView.DoEndDrag(Target: TObject; X, Y: Integer);
var
  TSI: TElXTreeItem;
begin
  inherited DoEndDrag(Target, X, Y);
  FreeAndNil(FDragImages);
  TSI := FDropTrg;
  FDropTrg := nil;
  if TSI <> nil then
    TSI.RedrawItem(True);
end;

procedure TElXTreeView.WMRButtonUp(var Msg: TWMRButtonUp);
begin
  if IntRButtonUp(Msg.XPos, Msg.YPos, KeyDataToShiftState(Msg.Keys)) then
    inherited;
end;

procedure TElXTreeView.WMLButtonUp(var Message: TWMLButtonUp);
begin
  if IntLButtonUp(Message.XPos, Message.YPos, KeyDataToShiftState(Message.Keys)) then
    inherited;
end;

procedure TElXTreeView.MouseMove(Shift: TShiftState; X, Y: Integer); { protected }
var
  ItemPart: TSTXItemPart;
  HCol: Integer;
  Item: TElXTreeItem;
  Ctrl: TElXCellControl;
  i: Integer;
begin
  HCol := 0;
  Item := GetItemAt(X, Y, ItemPart, HCol);
  if ItemPart = ipColumn then
  begin
    i := HCol;
    if (Item.Cells.Count > HCol) then
    begin
      with FOwner do
        if Assigned(Item.Cells[i].Style) then
          Ctrl := TElXCellControl(Item.Cells[i].Style.Control)
        else
          Ctrl :=nil;
        if Ctrl <> nil then
        begin
          Ctrl.TriggerMouseMoveEvent(LMDGetShiftState, X, Y);
          Exit;
        end;
    end;
  end;
  inherited;
end; { MouseMove }

procedure TElXTreeView.WMRButtonDblClk(var Msg: TWMRButtonDblClk); { private }
begin
  if IntRButtonDblClick(Msg.XPos, Msg.YPos, KeyDataToShiftState(Msg.Keys)) then
    inherited;
end; { WMRButtonDblClk }

procedure TElXTreeView.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if IntLButtonDblClick(Message.XPos, Message.YPos, KeyDataToShiftState(Message.Keys)) then
    inherited;
end;

procedure TElXTreeView.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if IntLButtonDown(Message.XPos, Message.YPos, KeyDataToShiftState(Message.Keys)) then
    inherited;
end;

procedure TElXTreeView.WMRButtonDown(var Message: TWMRButtonDown);
begin
  // this is also in EventFilter
  if FEditTimer <> nil then
     FEditTimer.Enabled := False;
  DoHideLineHint;
  if FMouseSel then
    CancelMouseSel;

  IntRButtonDown(Message.XPos, Message.YPos, KeyDataToShiftState(Message.Keys));
  inherited;
end;

procedure TElXTreeView.DoCanDrag(const Item: TElXTreeItem; var CanDrag: Boolean);
begin
  if Assigned(FOnCanDrag) then
    FOnCanDrag(Self, Item, CanDrag);
end;

procedure TElXTreeView.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
  IntMouseMove(Message.XPos, Message.YPos, KeyDataToShiftState(Message.Keys));
end;

procedure TElXTreeView.DoStartDrag(var DragObject: TDragObject);
var
  p: TPoint;
begin
  DragCursor := FOwner.DragCursor;
  FDropTrg := nil;
  if Assigned(FSelected) or ((FOwner.FSelectedList <> nil) and (FOwner.FSelectedList.Count > 0)) then
     FillDragImage;
  if (FDragImages <> nil) then
  begin
    p := FOwner.ScreenToClient(FPressCoord);
    with FOwner do
    if ShowColumns then
      FDragImages.SetDragImage(0, P.X + FLeftPosition - FHeader.Sections[FMainTreeColumn].Left, P.y - fddy)
    else
      FDragImages.SetDragImage(0, P.X + FLeftPosition, P.y - fddy);
  end;
  inherited DoStartDrag(DragObject);
end;

procedure TElXTreeView.OnScrollTimer(Sender: TObject);
var P: TPoint;
    Y: Integer;
begin
  FDragScrollTimer.Enabled := False;
  FDragScrollTimer.Interval := FOwner.DragScrollInterval;
  if ColorHelper.Visible.Count > 0 then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);
    y := P.Y;
    if ((FOwner.TopIndex > 0) and (Y <= TElXTreeItem(ColorHelper.Visible[0]).GetHeight)) then // CNS div by 2 removed
    // if ((FOwner.TopIndex > 0) and (Y <= TElXTreeItem(ColorHelper.Visible[0]).GetHeight shr 1)) then
    begin
      if FOwner.FDragObject <> nil then
        FOwner.FDragObject.HideDragImage;
      SetTopIndex(FOwner.TopIndex - 1);
      if FOwner.FDragObject <> nil then
        FOwner.FDragObject.ShowDragImage;
      FDragScrollTimer.Enabled := True;
    end
    else
    if ((FOwner.BottomIndex <= FOwner.TotalVisCount) and (Y >= Height - TElXTreeItem(ColorHelper.Visible.Last).GetHeight)) then // CNS div by 2 removed
    // if ((FOwner.BottomIndex <= FOwner.TotalVisCount) and (Y >= Height - TElXTreeItem(ColorHelper.Visible.Last).GetHeight shr 1)) then
    begin
      if FOwner.FDragObject <> nil then
        FOwner.FDragObject.HideDragImage;
      SetTopIndex(FOwner.TopIndex + 1);
      if FOwner.FDragObject <> nil then
        FOwner.FDragObject.ShowDragImage;
      FDragScrollTimer.Enabled := True;
    end;
  end;
end;

function TElXTreeView.DragScroll(Source: TDragObject; X, Y: Integer): Boolean; { protected }
var
  NewY: Integer;
begin
  Result := False;
  NewY := 0;
  if (Y < NewY + (FOwner.FLineHeight shr 1)) and (FOwner.TopIndex > 0) then
  begin
    Source.HideDragImage;
    Result := True;
    SetTopIndex(FOwner.TopIndex - 1);
  end
  else
    if (Y > Height - (FOwner.FLineHeight shr 1)) and (FOwner.BottomIndex <= FOwner.TotalVisCount) then
    begin
      Source.HideDragImage;
      Result := True;
      SetTopIndex(FOwner.TopIndex + 1);
    end;
end; { DragScroll }

procedure TElXTreeView.DoDragOver(Source: TDragObject; X, Y: Integer; CanDrop: Boolean);
var
  TSI: TElXTreeItem;
  R: TRect;
begin
  //TDragObject(Source).HideDragImage;
  if (FHintTimer <> nil) or (FHintItem <> nil) then
    DoHideLineHint;

  if ColorHelper.Visible.Count > 0 then
    if ((FOwner.TopIndex > 0) and
        (Y <= TElXTreeItem(ColorHelper.Visible[0]).GetHeight)) or
        // (Y <= TElXTreeItem(ColorHelper.Visible[0]).GetHeight shr 1)) or
       ((FOwner.BottomIndex <= FOwner.TotalVisCount) and
        (Y >= Height - TElXTreeItem(ColorHelper.Visible.Last).GetHeight)) then
        // (Y >= Height - TElXTreeItem(ColorHelper.Visible.Last).GetHeight shr 1)) then
    begin
      if FDragScrollTimer = nil then
      begin
        FDragScrollTimer := TTimer.Create(self);
        FDragScrollTimer.Enabled := False;
      end;
      if not FDragScrollTimer.Enabled then
      begin
        FDragScrollTimer.OnTimer := OnScrollTimer;
        FDragScrollTimer.Interval := 1000;//FOwner.DragScrollInterval * 2;
        FDragScrollTimer.Enabled := True;
      end;
    end;
  //fh := DragScroll(Source, X, Y);

  FDropAcc := CanDrop;
  TSI := FDropTrg;

  FDropTrg := GetItemAtY(Y);
  if Assigned(FDropTrg) and not (FOwner.IgnoreEnabled or FDropTrg.Enabled) then
    FDropTrg := nil;
  if TSI = FDropTrg then
  begin
    // if there is no code that might change DragImgDrawMode,
    // we have nothing more to do so we can leave the method
//    if not Assigned(FOwner.OnDragTargetChange) then
      Exit;
  end;
  Source.HideDragImage;
  try
  if TSI <> nil then
      TSI.RedrawItem(False);

    if Assigned(FOwner.OnDragTargetChange) then
    begin
      R := FOwner.GetItemRect(ColorHelper.Visible.IndexOf(FDropTrg));
      FOwner.OnDragTargetChange(FOwner, FDropTrg, R, X, Y + Top);
    end;

    if FDropTrg <> nil then
    begin
      if FOwner.FExpandOnDragOver then
      begin
        if FOwner.FDragExpandDelay = 0 then
        begin
          if FOwner.FDragObject <> nil then
            FOwner.FDragObject.HideDragImage;
          FDropTrg.Expand(False);
          Invalidate; //Update;
          if FOwner.FDragObject <> nil then
            FOwner.FDragObject.ShowDragImage;
        end
        else
        begin
          if FDragExpandTimer = nil then
            FDragExpandTimer := TTimer.Create(self);
          with FDragExpandTimer do
          begin
            Enabled := False;
            OnTimer := OnDragExpandTimer;
            Interval:= FOwner.FDragExpandDelay;
            Enabled := True;
          end;
        end;
      end;
      FDropTrg.RedrawItem(False);
    end;
    Invalidate; //Update;
    finally
    Source.ShowDragImage;
  end;
end;

function TElXTreeView.GetItemAt(X, Y: Integer;
  var ItemPart: TSTXItemPart; var HitColumn: Integer): TElXTreeItem;

  var
    lForceAlign: boolean;


// =================================================
  procedure GetIfRightAligned;
  var
    i: Integer;
    DX: Integer;
    odx: Integer;
    LTempX: Integer;
    R : TRect;
    LCell: TElXTreeCell;
  begin
    if (Width - X < FOwner.FGutterWidth) then
    begin
      ItemPart := ipGutter;
      HitColumn := 0;
      Exit;
    end;

    DX := X + FOwner.FLeftPosition;
    odx := X;
    HitColumn := -1;
    if FOwner.ShowColumns then
    begin
      for i := 0 to FHeader.Sections.Count - 1 do
      begin
{        if FHeader.Sections[i].Locked then
        begin
          odx := DX;
          DX := DX - FOwner.FLeftPosition;
        end
        else  }
        DX := odx;
        R := FHeader.GetDragSectionRect(FHeader.Sections[i].Position);
        if LMDInRange(DX, R.Left, R.Right) then
        begin
          HitColumn := i;
          if (not Assigned(Result)) or (HitColumn >= Result.Cells.Count) then
            ItemPart := ipOutside
          else
          if not Result.WholeLine and ((HitColumn <> FOwner.FMainTreeColumn) or Assigned(Result.Cells[FOwner.FMainTreeColumn].Control)) then
          begin
            LCell := Result.Cells[HitColumn].JointCellMaster;
            if Assigned(LCell) then
            begin
              Result := LCell.Owner;
              HitColumn := LCell.Index;
            end;
            ItemPart := ipColumn;
            Exit;
          end
          else
          begin
            ItemPart := ipInside;
            if Result.WholeLine then
              HitColumn := FOwner.MainTreeColumn;
            break;
          end;
        end; // if
      end; // for
    end; // if

    if not Assigned(Result) then
      exit;
    if LMDInRange(DX+ FOwner.FLeftPosition, Result.FTextRect.Left, Result.FTextRect.Right + FOwner.FItemIndent div 3 - 1) then
    begin
      ItemPart := ipMainText;
      HitColumn := FOwner.MainTreeColumn;
      Exit;
    end;

    if (Result.FBoolData and ibfImageDrawn) <> 0 then
    begin
      LTempX := Result.FTextRect.Right + FOwner.FImages.Width + FOwner.FItemIndent div 3 - 1;
      if (DX >= LTempX - FOwner.FImages.Width) and (DX < LTempX) then
      begin
        ItemPart := ipPicture;
        HitColumn := FOwner.MainTreeColumn;
        Exit;
      end;
      if ((Result.FBoolData and ibfImageDrawn2) <> 0) or
         (Result.ShowCheckBox and FOwner.ShowCheckboxes) then
        Inc(LTempX, FOwner.FItemIndent div 3);
    end
    else
    begin
      LTempX := Result.FTextRect.Right;
      if Result.IndentAdjust <> 0 then
        inc(LTempX, Result.IndentAdjust);
      inc(LTempX, FOwner.ItemIndent div 5 - 1);
    end;

    if (Result.FBoolData and ibfImageDrawn2) <> 0 then
    begin
      if FOwner.FImages2 <> nil then
      begin
        Inc(LTempX, FOwner.FImages2.Width);
        if (DX >= LTempX - FOwner.FImages2.Width) and (DX < LTempX) then
        begin
          ItemPart := ipPicture2;
          HitColumn := FOwner.MainTreeColumn;
          Exit;
        end;
      end
      else
      begin
        Inc(LTempX, FOwner.FImages.Width);
        if (DX >= LTempX - FOwner.FImages.Width) and (DX < LTempX) then
        begin
          ItemPart := ipPicture2;
          HitColumn := FOwner.MainTreeColumn;
          Exit;
        end;
      end;
    end;

    if FOwner.FShowCheckBoxes then
    begin
      if Result.ShowCheckBox then
    begin
      if FOwner.FCustomCheckboxes then
      begin
        if Result.FStaticDataEx.CheckBoxType = ectRadioButton then
        begin
          if (DX - FOwner.FLeftPosition >= LTempX) and (DX - FOwner.FLeftPosition < LTempX + FOwner.FRadioButtonGlyph.Width div 6) then
          begin
            ItemPart := ipCheckBox;
            HitColumn := FOwner.MainTreeColumn;
            Exit;
          end;
          Inc(LTempX, FOwner.FRadioButtonGlyph.Width div 6);
        end
        else
        begin
          if (DX {- FOwner.FLeftPosition} >= LTempX) and (DX {- FOwner.FLeftPosition} < LTempX + FOwner.FCheckBoxGlyph.Width div 6) then
          begin
            ItemPart := ipCheckBox;
            HitColumn := FOwner.MainTreeColumn;
            Exit;
          end;
          Inc(LTempX, FOwner.FCheckBoxGlyph.Width div 6);
        end;
      end
      else
      begin
        if (DX {- FOwner.FLeftPosition} >= LTempX) and (DX {- FOwner.FLeftPosition} < LTempX + CheckBoxSize) then
        begin
          ItemPart := ipCheckBox;
          HitColumn := FOwner.MainTreeColumn;
          Exit;
        end;
        Inc(LTempX, CheckBoxSize);
      end;
      end
      else
      if lForceAlign then
        Inc(LTempX, CheckBoxSize);
    end;

    if not FOwner.ShowButtons
      or not (Result.HasVisibleChildren or Result.ForceButtons or FOwner.ShowLeafButton)
    then
      Exit;

    DX := X + FOwner.LeftPosition;
    if (DX >= LTempX) and (DX < LTempX + FOwner.FItemIndent) then
    begin
      if Result.SuppressButtons then
        ItemPart := ipInside
      else
        ItemPart := ipButton;
      HitColumn := FOwner.MainTreeColumn;
      Exit;
    end;
  end;

// =================================================
  procedure GetIfNotRightAligned;
  var
    i: Integer;
    DX: Integer;
    LTempX: Integer;
    LCell: TElXTreeCell;
  begin
    if X < FOwner.FGutterWidth then
    begin
      ItemPart := ipGutter;
      HitColumn := 0;
      Exit;
    end;

    HitColumn := -1;
//    DX := X + FOwner.LeftPosition - FOwner.GutterWidth;
    if FOwner.ShowColumns then
    begin
      for i := 0 to FHeader.Sections.Count - 1 do
      begin
        if FHeader.Sections[i].Locked then
          DX := X
        else
          DX := X + FHeader.LeftPos;

        if LMDInRange(DX, FHeader.Sections[i].Left, FHeader.Sections[i].Right) then
        begin
          HitColumn := i;
          if (not Assigned(Result)) or (HitColumn >= Result.Cells.Count) then
            ItemPart := ipOutside
          else
          begin
            if not Result.WholeLine and ((HitColumn <> FOwner.FMainTreeColumn) or Assigned(Result.Cells[FOwner.FMainTreeColumn].Control)) then
            begin
              LCell := Result.Cells[HitColumn].JointCellMaster;
              if Assigned(LCell) then
              begin
                Result := LCell.Owner;
                HitColumn := LCell.Index;
              end;
              if HitColumn = FOwner.FMainTreeColumn then
                ItemPart := ipMainText
              else
                ItemPart := ipColumn;
              Exit;
            end
            else
            begin
              ItemPart := ipInside;
              if Result.WholeLine then
                HitColumn := FOwner.MainTreeColumn;
              break;
            end;
          end;
        end; // if
      end; // for
    end; // if

    if not Assigned(Result) then
      exit;

    if FOwner.ShowColumns and (HitColumn < FOwner.FixedColNum) then
      DX := X
    else
      DX := X + FOwner.LeftPosition {- FOwner.GutterWidth};
    LTempX := Result.FTextRect.Left - 1;
    if Result.IndentAdjust <> 0 then
      dec(LTempX, Result.IndentAdjust);
    dec(LTempX, FOwner.ItemIndent div 5);
//    if (FOwner.ShowRoot and FOwner.ShowLines) or (FOwner.ShowButtons and FOwner.ShowRootButtons) then
//      dec(LTempX, FOwner.ItemIndent)
//    else
//      dec(LTempX, FOwner.ItemIndent div 5);

    if LMDInRange(DX, LTempX, Result.FTextRect.Right) then
    begin
      ItemPart := ipMainText;
      HitColumn := FOwner.MainTreeColumn;
      Exit;
    end; // else ItemPart := ipInside;

    if (Result.FBoolData and ibfImageDrawn) <> 0 then
    begin
      LTempX := Result.FTextRect.Left - FOwner.FImages.Width - (FOwner.FItemIndent div 3) + 1;
      if (DX < LTempX + FOwner.FImages.Width) and (DX >= LTempX) then
      begin
        ItemPart := ipPicture;
        HitColumn := FOwner.MainTreeColumn;
        Exit;
      end;
      if ((Result.FBoolData and ibfImageDrawn2) <> 0) or
         (Result.ShowCheckBox and FOwner.ShowCheckboxes) then
        Dec(LTempX, FOwner.FItemIndent div 3);
    end;

    if (Result.FBoolData and ibfImageDrawn2) <> 0 then
    begin
      if FOwner.FImages2 <> nil then
      begin
        Dec(LTempX, FOwner.FImages2.Width);
        if (DX < LTempX + FOwner.FImages2.Width) and (DX >= LTempX) then
        begin
          ItemPart := ipPicture2;
          HitColumn := FOwner.MainTreeColumn;
          Exit;
        end;
      end
      else
      begin
        if Assigned(FOwner.FImages) then
        begin
          Dec(LTempX, FOwner.FImages.Width);
          if (DX < LTempX + FOwner.FImages.Width) and (DX >= LTempX) then
          begin
            ItemPart := ipPicture2;
            HitColumn := FOwner.MainTreeColumn;
            Exit;
          end;
        end;
      end;
    end;

    if FOwner.FShowCheckBoxes then
    begin
      if Result.ShowCheckBox then
    begin
      if FOwner.FCustomCheckboxes then
      begin
        if Result.FStaticDataEx.CheckBoxType = ectRadioButton then
        begin
          if (DX < LTempX) and (DX >= LTempX - FOwner.FRadioButtonGlyph.Width div 6) then
          begin
            ItemPart := ipCheckBox;
            HitColumn := FOwner.MainTreeColumn;
            Exit;
          end;
          Dec(LTempX, FOwner.FRadioButtonGlyph.Width div 6);
        end
        else
        begin
          if (DX < LTempX) and (DX >= LTempX - FOwner.FCheckBoxGlyph.Width div 6) then
          begin
            ItemPart := ipCheckBox;
            HitColumn := FOwner.MainTreeColumn;
            Exit;
          end;
          Dec(LTempX, FOwner.FCheckBoxGlyph.Width div 6);
        end;
      end
      else
      begin
        if (DX < LTempX) and (DX >= LTempX - CheckBoxSize) then
        begin
          ItemPart := ipCheckBox;
          HitColumn := FOwner.MainTreeColumn;
          Exit;
        end;
        Dec(LTempX, CheckBoxSize);
      end;
      end
      else
      if lForceAlign then
        Dec(LTempX, CheckBoxSize);
    end;

    if not FOwner.ShowButtons
      or not (Result.HasVisibleChildren or Result.ForceButtons or FOwner.ShowLeafButton)
    then
      Exit;
    if (DX < LTempX) and (DX >= LTempX - FOwner.FItemIndent) then
    begin
      if Result.SuppressButtons then
        ItemPart := ipInside
      else
        ItemPart := ipButton;
      HitColumn := FOwner.MainTreeColumn;
      Exit;
    end;
  end;

// =================================================
begin
  Result := GetItemAtY(Y);
  ItemPart := ipOutside;
//  if Result = nil then
//    Exit;

  lForceAlign := FOwner.ForceAlign;

  if FOwner.RightAlignedView then
    GetIfRightAligned
  else
    GetIfNotRightAligned;
end;

function TElXTreeView.GetItemAtY(Y: Integer): TElXTreeItem;
var
  i: Integer;
  LItemY: Integer;
  LVisible: TLMDObjectList;
  DY: Integer;
begin
  Result := nil;
  if Y < 0 then
    Exit;
  LVisible := ColorHelper.Visible;
  LItemY := ClientRect.Bottom - FOwner.GetFixedBottomRowsHeight + 2 * FDivLineWidth;
  if y >= LItemY then
  begin
    for i := LVisible.Count - FOwner.FFixedBottomRowNum to LVisible.Count - 1 do
    begin
      Inc(LItemY, TElXTreeItem(LVisible[i]).GetHeight {+ FDivLineWidth});
      if Y < LItemY then
      begin
        Result := TElXTreeItem(LVisible[i]);
        Exit;
      end;
    end;
  end
  else
  begin
    LItemY := 0;
    for i := 0 to LVisible.Count - 1 - FOwner.FFixedBottomRowNum do
    begin
      Inc(LItemY, TElXTreeItem(LVisible[i]).GetHeight {+ FDivLineWidth});
      {if i >= FOwner.FFixedTopRowNum then
        DY := FDivLineWidth * 2
      else}
        DY := 0;
      if Y < LItemY + DY then
      begin
        Result := TElXTreeItem(LVisible[i]);
        Exit;
      end;
    end;
  end;
end;

function TElXTreeView.GetItemRect(AItemIndex: Integer): TRect;
var
  LItemIndex: Integer;
  y: Integer;
  LVisible: TLMDObjectList;
begin
  LVisible := ColorHelper.Visible;
  if not LMDInRange(AItemIndex, 0, LVisible.Count - 1)
    or (csDestroying in ComponentState)
  then
  begin
    SetRectEmpty(Result);
    Exit;
  end;
  if (LVisible.Count - FOwner.FFixedBottomRowNum > 0) and (AItemIndex >= LVisible.Count - FOwner.FFixedBottomRowNum) then
  begin
    y := ClientRect.Bottom - FOwner.GetFixedBottomRowsHeight + 2 * FDivLineWidth;
    for LItemIndex := LVisible.Count - FOwner.FFixedBottomRowNum to AItemIndex - 1 do
      Inc(y, TElXTreeItem(LVisible[LItemIndex]).GetHeight);
  end
  else
  begin
    y := 0;
    for LItemIndex := 0 to AItemIndex - 1 do
      Inc(y, TElXTreeItem(LVisible[LItemIndex]).GetHeight);
    if (FOwner.FFixedTopRowNum > 0) and (AItemIndex >= FOwner.FFixedTopRowNum) then
      Inc(y, 2 * FDivLineWidth);
  end;
  Result := Rect(0, y, Self.Width, y + TElXTreeItem(LVisible[AItemIndex]).GetHeight);
end;

procedure TElXTreeView.ProcessPassedClick;
{var
  Item: TElXTreeItem;
  FS: TElXTreeItem;
  FFS: Boolean;}
begin
//  Item := FPassedItem;
//  FClickPassed := False;
//
//  if FOwner.IsEditing then
//    Exit;
//
//  with FOwner do
//    if FMultiSelect then
//      IsUpdating := True;
//  FFS := False;
//  if (FOwner.FSelectionMode = smUsual) and (FOwner.FMultiSelect) then
//  begin
//    if (not (ssCtrl in FPassedShift)) and (not (ssShift in FPassedShift)) then
//    begin
//      with FOwner do
//      begin
//        if ItemFocused <> nil then
//          FFS := ItemFocused.Selected;
//          if not ((FPassedItem = ItemFocused) and (FOwner.FAlwaysKeepSelection)) then
//           DeselectAll;
////        if ItemFocused <> Item then
//      end;
//    end;
//    if ssShift in FPassedShift then
//    begin
//      with FOwner do
//      begin
//        FS := FSelected;
//        DeselectAll;
//        if FS <> nil then
//        begin
//          FSelected := FS;
//          FSelected.Selected := True;
//        end;
//        SelectRangeEx2(Item, FSelected, False, False, True);
//      end;
//    end;
//  end;
//  with FOwner do
//  begin
//    if ItemFocused = Item then
//    begin
//      if (((not FFS) or (FOwner.FAlwaysKeepSelection)) and
//         (FOwner.FSelectionMode = smUsual)) and (not Item.Selected) then
//         DoSetSelected(Item)
//    end
//    else
//      ItemFocused := Item;
//    if (((FMultiSelect) and (not (ssCtrl in FPassedShift)) and (not (ssShift in FPassedShift))) or
//       (not FMultiSelect)) and Item.Selected then
//        FSelected := Item;
//  end;
//  with FOwner do
//    if FMultiSelect then
//       IsUpdating := False;
//  FOwner.DoAfterSelectionChange;
end;

procedure TElXTreeView.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  LOldSelected: TElXTreeItem;
  LItem: TElXTreeItem;
//  HCol: Integer;
  LStyle: TElXCellStyle;
  LControl: TElXCellControl;
  LNotSelected: Boolean;

  procedure ClickButton;
  begin
    if LItem.Expanded then
    begin
      LOldSelected := FFocused;
      LItem.Expanded := False;
      if FOwner.MoveFocusOnCollapse and (LOldSelected <> FFocused) then
      begin
        FOwner.DoAfterSelectionChange;
        FOwner.DoItemFocused;
      end;
    end
    else
    begin
      LItem.Expanded := True;
      FitMostChildren(LItem);
    end;
  end;

  procedure ClickColumn;
  begin
    //if LItem.UseStyles then
    //begin
      if FOwner.VirtualityLevel = vlNone then
      begin
        LStyle := LItem.Cells[FHitColumn].CurrentStyle as TElXCellStyle;
      end
      else
      begin
//        LStyle := VirtStyle;
        if LMDInRange(FHitColumn, 0, LItem.Cells.Count - 1) then
          LStyle := LItem.Cells[FHitColumn].Style
        else
          LStyle := VirtStyle;
//        FOwner.TriggerVirtualStyleNeeded(LItem, FHitColumn, LStyle);
      end;
      if Assigned(LStyle)
        //and not LStyle.OwnerProps
        and Assigned(LStyle.Control)
        and TElXCellControl(LStyle.Control).Visible
        and TElXCellControl(LStyle.Control).Enabled
      then
      begin
//            LItemTop := (y div FOwner.LineHeight) * FOwner.LineHeight;
//            LItemTop := FOwner.FView.GetItemRect(FOwner.FView.F_ColorHelper.Visible.IndexOf(LItem)).Top;
        LControl := TElXCellControl(LStyle.Control);
        if Assigned(LControl) then
        begin
          LControl.TriggerMouseDownEvent(Button, Shift, X - FOwner.FLeftPosition - FHeader.Sections[FHitColumn].Left, {LItemTop} y);
          FClickControl := LControl;
          if not LControl.PassClicks then
          begin
            inherited;
            Exit;
          end;
        end;
      end;
    //end;
  end;

var
  ItemPart: TSTXItemPart;
  SelList: TLMDObjectList;
  LSelected: Boolean;
  LOldHitColumn: integer;
begin
  if FIgnoreClick or (ssDouble in Shift) then
  begin
    inherited;
    Exit;
  end;

  FOwner.FSelChange := False;

  LOldHitColumn := FHitColumn;
  LItem := GetItemAt(X, Y, ItemPart, FHitColumn);

  if (LItem <> nil) and (ItemPart in [ipMainText, ipColumn]) and
      LMDInRange(FHitColumn, 0, FHeader.Sections.Count - 1) and
      not FHeader.Sections[FHitColumn].ClickSelect then
  begin
    LItem := nil;
    ItemPart := ipOutside;
    FHitColumn := LOldHitColumn;
  end;
  if (ItemPart = ipOutside) and (FOwner.ShowColumns or not FOwner.RowSelect) then
    LItem := nil;
  if (not Assigned(LItem)) or LItem.Enabled or FOwner.IgnoreEnabled then
  begin
    if (ItemPart = ipButton) and ((ssRight in Shift) or (button = mbRight)) then
      ItemPart := ipMainText;
    if ItemPart = ipButton then
      ClickButton
    else
    // checkboxes are processed in MouseUp now
    if ItemPart = ipColumn then
    begin
      if (LItem.Cells[FHitColumn].JointCellRole = jcrSlave) then
        FHitColumn := LItem.Cells[FHitColumn].JointCellMaster.Index;
      ClickColumn;
      if FHeader.Sections[FHitColumn].ClickSelect then
      begin
        if (LItem = FSelected) and (LItem.FCells.Count > FHitColumn) and (LItem.FCells[FHitColumn].Selected = False) then
        begin
          if not (FOwner.FMultiSelect and ((ssCtrl in shift) or (ssShift in shift))) then
            LItem.DoSetSelected(false);
          LItem.DoSetSelected(True);
        end;
      end
      else
      begin
        inherited;
        exit;
      end;
    end;
    if (FOwner.RightClickSelect and ((ssRight in Shift) or (button = mbRight)) or ((ssLeft in Shift) or (button = mbLeft))) and not (ItemPart in [ipButton, ipCheckbox]) then
    begin
      if FOwner.FMultiSelect then
        FOwner.IsUpdating := True;
      if Assigned(LItem) and ((ItemPart <> ipOutside) or FOwner.FRowSelect) then
      begin
        begin
          //FFS := False;
          if (FOwner.FSelectionMode = smUsual) then // and FOwner.FMultiSelect then
          begin
            if Assigned(FOwner.FSelectedList) then
              LNotSelected := FOwner.FSelectedList.IndexOf(LItem) < 0
            else
              LNotSelected := LItem <> FSelected;
            if (LNotSelected or (FHitColumn <> LOldHitColumn)) and not (ssCtrl in shift) and not (ssShift in shift) then
              FOwner.DeselectAll(not (FSelected = LItem));
            if (Shift * [ssCtrl, ssShift] = []) then
              if (not LItem.Selected) or (FOwner.AlwaysKeepSelection) then
              begin
                if FOwner.MultiSelect then
                begin
                  if not (FOwner.ItemFocused = LItem) then
                  begin
                    FOwner.ItemFocused := LItem;
                    if (FOwner.ItemFocused <> LItem) then //not AllowChange
                    begin
                      FHitColumn := LOldHitColumn;
                      if Assigned(FOwner.ItemFocused) then
                      begin
                        FOwner.ItemFocused.DoSetSelected(False);
                        FOwner.ItemFocused.DoSetSelected(True);
                      end;
                      FOwner.IsUpdating := False;
                      inherited;
                      exit;
                    end;
                  end;
                  LItem.Selected := True;
                  if (LItem = FSelected) and LItem.Selected and not FOwner.FRowSelect then
                  begin
                    LItem.DoSetSelected(False);
                    LItem.DoSetSelected(True);
                    Invalidate;
                  end;
                  if LItem.Selected then
                  begin
                    FSelected := LItem;
                    if FOwner.FShowColumns then
                      LItem.Cells.FCol := FHitColumn;
                  end;
                 end
                 else
                 begin
                   LSelected := LItem.Focused;
                   LItem.Focused := (FOwner.FSelectionMode = smUsual);
                   if LItem.Selected then
                     LItem.DoSetSelected(false);
                   if LItem.Focused then
                     LItem.DoSetSelected(True);
                   if LSelected and (FSelected <> LItem) then
                   begin
                     FSelected := LItem;
                     FOwner.TriggerItemSelectedChangeEvent(LItem);
                   end;
                 end;
              end
              else
              begin
                if FOwner.AlwaysKeepSelection then
                  if FOwner.MultiSelect then
                    LItem.SetSelected(False)
                  else
                  begin
                    LItem.DoSetSelected(false);
                    FSelected := nil;
                    FOwner.TriggerItemSelectedChangeEvent(LItem);
                  end;
              end;
            if ssShift in shift then
            begin
//              LOldSelected := FSelected;
//              FSelected := LOldSelected;
              if FSelected <> nil then
                 FSelected.Selected := True;
              FOwner.SelectRangeEx2(LItem, FSelected, False, False, True);
              if FOwner.ItemFocused <> LItem then
                FOwner.ItemFocused := LItem;
              if FOwner.Selected <> LItem then
                FSelected := LItem;
            end
            else
            if ssCtrl in Shift then
            begin
              LSelected := LItem.Selected or (FOwner.ItemFocused = LItem);
              if FOwner.ItemFocused <> LItem then
                FOwner.ItemFocused := LItem;
              if FOwner.MultiSelect and LSelected then
              begin
                if (not FOwner.FAlwaysKeepSelection) or (FOwner.FSelectedList.Count > 1) then
                  FOwner.SelectRangeEx3(FFocused,FFocused,FHitColumn,FHitColumn,False,False,True,not FFocused.Selected);
//                FFocused.Selected := not FFocused.Selected;
              end;
              if FFocused.Selected then
                FSelected := FFocused;
              if FOwner.FAlwaysKeepSelection and not Assigned(FSelected) then
                FSelected := TElXTreeItem(FOwner.FSelectedList[0]);
            end;
          end;
          if (FOwner.MultiSelect) and not (FOwner.ItemFocused = LItem) then
          begin
            FOwner.ItemFocused := LItem;
          end;
        end;
      end
      else // Eyal: (?) if FOwner.FMultiSelect or not FOwner.FAlwaysKeepSelection then {Eyal}
      begin
        if LItem = nil then
        begin
          if not FOwner.FAlwaysKeepFocus then
            FOwner.ItemFocused := nil;
          if not FOwner.AlwaysKeepSelection then
          begin
            if FOwner.MultiSelect then
              FOwner.DeselectAll
            else
              DoSetSelected(nil);
            //FOwner.FSelChange := True;
          end;
        end;
      end;
      if FOwner.FMultiSelect then
        FOwner.IsUpdating := False;
      if {FOwner.FMultiSelect and} FOwner.FSelChange then
      begin
        FOwner.DoAfterSelectionChange;
        FOwner.FSelChange := False;
      end;
    end
    else
    if ((ssRight in Shift) or (button = mbRight)) and FOwner.RightClickSelect then
    begin
      if FOwner.FMultiSelect then
      begin
        FOwner.IsUpdating := True;
        SelList := TLMDObjectList.Create;
        FOwner.AllSelected(SelList);
      end;

      if FOwner.MultiSelect and Assigned(LItem) and LItem.Selected then
      begin
        LSelected := LItem.Selected;
        FOwner.ItemFocused := LItem;
        if LSelected or FOwner.AlwaysKeepSelection then
          LItem.Selected := True;
      end
      else
      if not FOwner.FMultiSelect or (FOwner.FMultiSelect and ((SelList.Count < 2) and (FOwner.FSelectionMode = smUsual)) or (FOwner.FSelectionMode = smSimple)) then
      begin
        if (LItem <> nil) and (((ItemPart <> ipInside) and (ItemPart <> ipOutside)) or FOwner.FRowSelect) then
        begin
          begin
            if (FOwner.FSelectionMode = smUsual) and FOwner.FMultiSelect then
            begin
              if not (ssCtrl in shift) and not (ssShift in shift) then
              begin
            //if ItemFocused <> nil then FFS := ItemFocused.Selected;
                FOwner.DeselectAll;
              end;
              if ssShift in shift then
              begin
                FOwner.DeselectAll;
                if FSelected <> nil then
                  FSelected.Selected := True;
                FOwner.SelectRangeEx2(LItem, FSelected, False, False, True);
              end;
            end;
            if (FOwner.ItemFocused = LItem) and (not LItem.Selected) then
               DoSetSelected(LItem)
            else
            if {LItem.AllowSelection and }(FOwner.ItemFocused <> LItem) then
              FOwner.ItemFocused := LItem;
            if not FOwner.FMultiSelect
              or not (ssCtrl in shift) and not (ssShift in shift)
            then
             FSelected := LItem;
          end;
        end
        else // Eyal: (?) if FOwner.FMultiSelect or not FOwner.FAlwaysKeepSelection then {Eyal}
          if (LItem = nil) and not FOwner.FAlwaysKeepFocus then
            FOwner.ItemFocused := nil;
      end;
      if FOwner.FMultiSelect then
      begin
        FreeAndNil(SelList);
        FOwner.IsUpdating := False;
      end;
      if FOwner.FSelChange then
      begin
        FOwner.DoAfterSelectionChange;
        FOwner.FSelChange := False;
      end;
    end;
  end;
  inherited;
end;

procedure TElXTreeView.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ItemPart: TSTXItemPart;
  HCol: Integer;
  Item: TElXTreeItem;
  lOldState, lNewState: integer;
  lAllowChange: boolean;
begin
  inherited;
  HCol := 0;
  Item := GetItemAt(X, Y, ItemPart, HCol);
  if (Item = nil) or (Item.Enabled) or (FOwner.IgnoreEnabled) then
  begin
    if (ItemPart = ipCheckBox) or (TElXTree(Owner).RowSelect and TElXTree(Owner).RowCheck) then
    begin
      if not (Item.Enabled or (FOwner.IgnoreEnabled)) then
        Exit;
      if Item.CheckBoxEnabled then
      begin
        if Item.CheckBoxType = ect3SCheckBox then
        begin
          lOldState := ord(Item.CheckBoxState);
          lNewState := lOldState - 1;
          if lNewState < 0 then
            lNewState := 2;
        end
        else
        begin
          lOldState := ord(Item.Checked);
        if Item.CheckBoxType = ectCheckBox then
            lNewState := ord(not Item.Checked)
          else
            lNewState := ord(true);
        end;
        lAllowChange := true;
        FOwner.DoItemCheckStateChanging(Item, lOldState, lNewState, lAllowChange);
        if lAllowChange then
        begin
          if Item.CheckBoxType = ect3SCheckBox then
            Item.CheckBoxState := TCheckBoxState(lNewState)
        else
            Item.Checked := boolean(lNewState);
        FOwner.DoItemChecked(Item);
        FOwner.DoItemChange(Item, icmCheckState);
      end;
    end;
    end;
    if FClickPassed then
      ProcessPassedClick;
  end;
end;

procedure TElXTreeView.KeyDown(var Key: Word; Shift: TShiftState);
var
  PrevSel,
  LFocusedItem: TElXTreeItem;
  LSelectedItem: TElXTreeItem;
  LNewFocusedItem: TElXTreeItem;
  OldSel, OldSel1: Boolean;
  LNewRowIndex: Integer;
  LSelected: Boolean;

  procedure DoVkBack;
  begin
    if Assigned(FFocused)
      and Assigned(FFocused.Parent)
      and (FFocused.Parent.Enabled or FOwner.IgnoreEnabled)
    then
    begin
      FOwner.DoSetFocusedEx(FFocused.Parent, False, True);
      FOwner.EnsureVisible(FOwner.ItemFocused);
    end;
  end;

  procedure DoVkAdd;
  begin
    if ssCtrl in Shift then
      FOwner.AutoSizeAllColumns
    else
    if Assigned(FFocused) and (FFocused.HasVisibleChildren or FFocused.ForceButtons or Owner.ShowLeafButton) and
       (not (FFocused.Expanded)) and ((FFocused.Enabled) or (FOwner.IgnoreEnabled)) then
    begin
      FFocused.Expanded := True;
      FitMostChildren(FFocused);
    end;
  end;

  procedure DoVkSubtract;
  begin
    if Assigned(FFocused) and ((FFocused.Enabled) or (FOwner.IgnoreEnabled)) and (FFocused.Expanded) then
       FFocused.Expanded := False;
  end;

  procedure DoVkMultiply;
  begin
    if Assigned(FFocused) and ((FFocused.Enabled) or (FOwner.IgnoreEnabled)) and
       (FFocused.HasVisibleChildren or FFocused.ForceButtons or Owner.ShowLeafButton) then
       begin
         FFocused.Expand(True);
         FitMostChildren(FFocused);
       end;
  end;

  procedure DoVkDivide;
  begin
    if Assigned(FFocused) and ((FFocused.Enabled) or (FOwner.IgnoreEnabled)) then
       FFocused.Collapse(True);
  end;

  procedure DoVkSpace;
  begin
    if Assigned(FFocused) and (FFocused.Enabled or FOwner.IgnoreEnabled) and (FOwner.FMultiSelect) then
    begin
      if (not (ssCtrl in shift)) and (not (ssShift in shift)) and (FOwner.FSelectionMode = smUsual) then
      begin
        FOwner.DeselectAll;
        FSelected := FFocused;
      end;
      if FOwner.FSelectionMode = smSimple then
        FSelected := FFocused;
      FFocused.Selected := not (FFocused.Selected);
      FOwner.DoAfterSelectionChange;
    end;
  end;

  procedure DoMovement;

    procedure DoVkLeft;
    var
      LHitColumn: integer;
    begin
      if (FOwner.FRowSelect or (FHitColumn <= 0)) and (FFocused <> nil) and FFocused.Expanded and ((FFocused.Enabled) or (FOwner.IgnoreEnabled))  then
        FFocused.Expanded := false
      else
      begin
        if (FOwner.FRowSelect or (FHitColumn <= 0)) and  Assigned(FFocused) and Assigned(FFocused.Parent) then
          LNewFocusedItem := FFocused.Parent
        else
        begin
          if not (Assigned(FFocused) and FOwner.FShowColumns) then
            exit;
          LNewFocusedItem := FFocused;
          if FFocused.Selected then
          begin
            LHitColumn := max(0, FHitColumn - 1);
            while not (FHeader.Sections[LHitColumn].Visible and FHeader.Sections[LHitColumn].ClickSelect) do
            begin
              if (LHitColumn = 0) then
                Break;
              dec(LHitColumn);
            end;
            if (FHeader.Sections[LHitColumn].Visible and FHeader.Sections[LHitColumn].ClickSelect) then
            begin
              FHitColumn := LHitColumn;
              FClickSection := FHitColumn;
            end;
            if (Shift * [ssCtrl, ssShift] = []) then
              FFocused.DoSetSelected(false);
            if not Assigned(FOwner.Selected) then
              FFocused.Selected := True
            else
              FFocused.DoSetSelected(True);
            Invalidate;
          end;
        end;
        LNewRowIndex := LNewFocusedItem.AbsoluteIndex
      end;
    end;

    procedure GoRightChild;
    begin
      if Assigned(FFocused) and ((FFocused.GetFirstVisibleChild <> nil)) then
      begin
        FOwner.IsUpdating := True;
        LNewFocusedItem := FFocused.GetFirstVisibleChild;
        LNewRowIndex := LNewFocusedItem.AbsoluteIndex;
        FHitColumn := 0;
        FOwner.FUpdated := True;
        FRangeUpdate := True;
        FOwner.IsUpdating := False;
      end
      else
      begin
        if FOwner.ItemFocused <> nil then
          LNewRowIndex := FOwner.ItemFocused.AbsoluteIndex
        else
          LNewRowIndex := -1;
      end;
    end;

    procedure GoRightCell;
    var
      LHitColumn: integer;
    begin
      if not Assigned(FFocused) then exit;
      LHitColumn := min(FHeader.Sections.Count - 1, FHitColumn + 1);
      //<abb2014>
	  while not (FHeader.Sections[LHitColumn].Visible and FHeader.Sections[LHitColumn].ClickSelect) do
      begin
        if (LHitColumn = (FHeader.Sections.Count - 1)) then
          Break;
        inc(LHitColumn);
      end;
      if (FHeader.Sections[LHitColumn].Visible and FHeader.Sections[LHitColumn].ClickSelect) then
      begin
        FHitColumn := LHitColumn;
        FClickSection := FHitColumn;
      end;
      LNewFocusedItem := FFocused;
      LNewRowIndex := LNewFocusedItem.AbsoluteIndex;
      if (Shift * [ssCtrl, ssShift] = []) then
      begin
        FFocused.DoSetSelected(false);
        if not Assigned(FOwner.Selected) then
          FFocused.Selected := True
        else
          FFocused.DoSetSelected(True);
      end
      else
        FFocused.Cells[FHitColumn].Selected := True;
      Invalidate;
    end;

    procedure DoVkRight;
    begin
      if FOwner.RowSelect or (FHitColumn >= (FHeader.Sections.Count - 1)) then
        if (FFocused <> nil) and (not (FFocused.Expanded)) and ((FFocused.Enabled) or (FOwner.IgnoreEnabled)) and (FFocused.HasVisibleChildren or FFocused.ForceButtons or Owner.ShowLeafButton) then
        begin
          FFocused.Expanded := true;
          FitMostChildren(FFocused);
        end
        else
          GoRightChild
      else
        GoRightCell;
    end;

    function CheckRange(Key: Word): Boolean;
    begin
      if not FOwner.FRowSelect and Assigned(FMouseFrameRec.StartItem) then
        case Key of
          VK_Left, VK_RIGHT : Result := FMouseFrameRec.StartItem = FMouseFrameRec.EndItem;
          VK_UP, VK_DOWN :  Result := FMouseFrameRec.StartColumn = FMouseFrameRec.EndColumn;
          else Result := False;
        end
      else
        Result := True;
    end;
  var
    LDummyIndex: Integer;
    i: integer;
    b: Boolean;
    SelectedCell: TElXTreeCell;
  begin
    if FOwner.RightAlignedView then
    begin
      case Key of
        VK_LEFT:  Key := VK_RIGHT;
        VK_RIGHT: Key := VK_LEFT;
      end;
    end;

    if FOwner.HorzArrowsScroll then
    begin
      case Key of
        VK_LEFT: begin
          PostMessage(FOwner.Handle, WM_HSCROLL, SB_LINELEFT, 0);
          Exit;
        end;
        VK_RIGHT: begin
          PostMessage(FOwner.Handle, WM_HSCROLL, SB_LINERIGHT, 0);
          Exit;
        end;
      end;
    end;
{
    case Key of
      VK_LEFT: begin
        if Assigned(FFocused)
          and FFocused.Expanded  and FFocused.HasChildren
          and (FFocused.Enabled or FOwner.IgnoreEnabled)
        then
        begin
          FFocused.Expanded := False;
          if FOwner.FMultiSelect then
            FOwner.IsUpdating := False;
          Exit;
        end;
      end;
      VK_RIGHT: begin
        if Assigned(FFocused)
          and not FFocused.Expanded
          and (FFocused.Enabled or FOwner.IgnoreEnabled)
          and (FFocused.HasVisibleChildren or FFocused.ForceButtons)
        then
        begin
          FFocused.Expanded := True;
          FitMostChildren(FFocused);
          with FOwner do
            if FMultiSelect then
              IsUpdating := False;
          Exit;
        end;
      end;
    end;
}
    with FOwner do
    if FMultiSelect then
    begin
      if ((ssCtrl in Shift) and (FSelectionMode = smUsual)) or (FSelectionMode = smSimple) then
      begin
        LFocusedItem := FFocused;
        if LFocusedItem <> nil then
           OldSel := LFocusedItem.Selected
        else
           OldSel := False;
      end;
      if ssShift in Shift then
      begin
        LSelectedItem := FSelected;
        if LSelectedItem <> nil then
           OldSel1 := LSelectedItem.Selected
        else
           OldSel1 := False;
      end;
      PrevSel := FSelected;
      if (FSelectionMode = smUsual) then
      begin
       if (ssCtrl in shift) or (ssShift in shift) then
       begin
         if (ssShift in shift) and not CheckRange(Key) then
           DeselectAll;
       end
       else
        if not (Key in [VK_LEFT,VK_RIGHT]) then
          DeselectAll;
      end;
    end
    else
      DeselectAll;

    case Key of
      VK_UP: begin
        LNewFocusedItem := FindNewFocused(VK_UP, LNewRowIndex, LSelected);
        if not Assigned(FFocused) and not Assigned(LNewFocusedItem) then
        begin
          if FOwner.FMultiSelect then
            FOwner.IsUpdating := False;
          Exit;
        end
      end;
      VK_DOWN: begin
        LNewFocusedItem := FindNewFocused(VK_DOWN, LNewRowIndex, LSelected);
        if not Assigned(FFocused) and not Assigned(LNewFocusedItem) then
        begin
          if FOwner.FMultiSelect then
            FOwner.IsUpdating := False;
          Exit;
        end
      end;
      VK_LEFT:  DoVkLeft;
      VK_RIGHT: DoVkRight;
      VK_NEXT:  LNewFocusedItem := FindNewFocused(VK_NEXT, LDummyIndex, LSelected);
      VK_PRIOR: LNewFocusedItem := FindNewFocused(VK_PRIOR, LDummyIndex, LSelected);
      VK_HOME:  LNewFocusedItem := FindNewFocused(VK_HOME, LDummyIndex, LSelected);
      VK_END:   LNewFocusedItem := FindNewFocused(VK_END, LDummyIndex, LSelected);
    end;

    if FOwner.FMultiSelect then
    begin
      if ((ssCtrl in Shift) and (FOwner.FSelectionMode = smUsual)) or (FOwner.FSelectionMode = smSimple) then
      begin
        if Assigned(LFocusedItem) then
          LFocusedItem.Selected := OldSel;
      end
      else
      if (ssShift in shift) and Assigned(LNewFocusedItem) then
      begin
        FOwner.SelectRangeEx2(LSelectedItem, LNewFocusedItem, False, False, True);
        if LSelectedItem <> nil then
          LSelectedItem.Selected := OldSel1;
      end
      else
        if Assigned(FFocused) and (FFocused <> LNewFocusedItem) then
          FFocused.Selected := False;
    end;
    if Assigned(LNewFocusedItem) then
    begin
//      if FOwner.FMultiSelect then
//      begin
//        if ((ssCtrl in Shift) and (FOwner.FSelectionMode = smUsual)) or (FOwner.FSelectionMode = smSimple) then
//        begin
//          if LNewFocusedItem <> LFocusedItem then
//             LNewFocusedItem.Selected := not LSelected;
//        end;
//        if ssShift in shift then
//        begin
//          if FFocused <> LNewFocusedItem then
//             LNewFocusedItem.Selected := False;
//        end;
//      end;
      if FFocused <> LNewFocusedItem then
      begin
        FOwner.DoSetFocusedEx(LNewFocusedItem, False, False);
//        if FOwner.FMultiSelect then
        FSelected := LNewFocusedItem;
      end
      else
      begin
        if FOwner.FMultiSelect and (FSelected = nil) then
          FSelected := PrevSel;
        LNewFocusedItem.Selected := True;
      end;
    end;
    if (Shift * [ssCtrl, ssShift] = []) or not FOwner.FMultiSelect then
    begin
      if FFocused <> nil then
        FSelected := FFocused;
      if Assigned(FFocused) {and (not (FOwner.FMultiSelect and (FOwner.FSelectionMode = smSimple))) and FOwner.FMultiSelect} then
      begin
        FFocused.Selected := True;
      end;
    end;
    if Assigned(FFocused) and ((ColorHelper.Visible.IndexOf(FFocused) = -1) {or xx}) then
    begin
      case Key of
      VK_UP:
        SetTopIndex(LNewRowIndex);
      VK_DOWN: begin
        //FOwner.EnsureVisibleBottom(FItems.GetVisItem(GIRec.i));
        if FOwner.TotalVarHeightCount > 0 then
          SetTopIndex(CalcPageUpPos(LNewRowIndex))
        else
//           if LNewRowIndex > FOwner.FFixedTopRowNum then
          SetTopIndex(LNewRowIndex - GetVisCount
            + FOwner.FFixedTopRowNum + FOwner.FFixedBottomRowNum + 2);
      end;
      VK_LEFT:
        SetTopIndex(FFocused.VisIndex);
      VK_RIGHT: begin
        //FOwner.EnsureVisibleBottom({FItems.GetVisItem(gr)});
        if FOwner.TotalVarHeightCount > 0 then
           SetTopIndex(CalcPageUpPos(LNewRowIndex))
        else
          SetTopIndex(LNewRowIndex - GetVisCount + 2)
      end;
      VK_PRIOR: begin
        if FOwner.TotalVarHeightCount > 0 then
             SetTopIndex(CalcPageUpPos(FOwner.FTopIndex))
          else
             SetTopIndex(FOwner.FTopIndex - GetVisCount + 1);
      end;
      VK_NEXT: begin
        if FOwner.TotalVarHeightCount > 0 then
           SetTopIndex(CalcPageDownPos(FOwner.FTopIndex))
        else
           SetTopIndex(FOwner.FTopIndex + GetVisCount - 1);
      end;
      else
        begin
          case Key of
          VK_HOME:
            SetTopIndex(0);
          VK_END:
            SetTopIndex(FOwner.TotalVisCount - 1);
          end;
        end;
      end;
      FClearVis := True;
      FClearAll := True;
    end;

    with FOwner do
    if not RowSelect then
      begin
      SelectedCell := nil;
      if Assigned(Selected) then
        for i:=0 to Selected.Cells.Count-1 do
          if Selected.Cells[i].Selected then
            SelectedCell := Selected.Cells[i];
      if Assigned(SelectedCell) and (not RowSelect) then
      begin
        b := (SelectedCell.Index >= FixedColNum) and ((SelectedCell.Left - FLeftPosition) < FHeader.FixedColWidth);
        if (FLeftPosition > SelectedCell.Left) or ((FixedColNum > 0) and b) then
           if ((FixedColNum > 0) and b) then
             FLeftPosition := SelectedCell.Left - Selected.Cells[FixedColNum].Left
           else
             FLeftPosition := SelectedCell.Left - FGutterWidth
        else
          if (FView.Width - SelectedCell.Width - FGutterWidth > 0) and
            ((SelectedCell.Left + SelectedCell.Width) > (FLeftPosition + FView.Width)) then
            FLeftPosition := (SelectedCell.Left + SelectedCell.Width)- FView.Width;
      end;
      UpdateScrollBars;
      end;

  end;

begin
  inherited;
  if not (csNoStdEvents in ControlStyle) then
  begin
    {
    if FOwner.FIncrementalSearch and (Shift = []) then
    begin
      if ProcessSearch(Char(Key)) then Exit;
    end;
    }

    if FMouseSel then
      Exit;

    FOwner.FSelChange := False;

    with FOwner do
      if FMultiSelect then
        IsUpdating := True;

    try
      LFocusedItem := nil;
      LSelectedItem := nil;
      LNewFocusedItem := nil;
      OldSel := False;
      OldSel1 := False;

      if (ssCtrl in shift) and (ssShift in shift) then
        Shift := Shift - [ssCtrl];
      if (ssShift in shift) and (Key = Ord('8')) then
      begin
        if Assigned(FFocused)
          and (FFocused.Enabled or FOwner.IgnoreEnabled)
          and (FFocused.HasVisibleChildren or FFocused.ForceButtons or Owner.ShowLeafButton)
        then
          FFocused.Expand(True);
      end
      else
      if (ssAlt in shift) and (Key in [VK_LEFT, VK_RIGHT]) then
      begin
        if Assigned(FFocused) then
          if Key = VK_Left then
            FFocused.Expanded := False
          else
            FFocused.Expanded := True;
      end
      else
      case Key of
        VK_BACK:     DoVkBack;
        VK_ADD:      DoVkAdd;
        VK_SUBTRACT: DoVkSubtract;
        VK_MULTIPLY: DoVkMultiply;
        VK_DIVIDE:   DoVkDivide;
        VK_SPACE:    DoVkSpace;
        VK_HOME,
        VK_END,
        VK_PRIOR,
        VK_NEXT,
        VK_LEFT,
        VK_RIGHT,
        VK_UP,
        VK_DOWN:
          begin
            DoMovement;
            if (FOwner.QuickEditMode) and (Shift = []) and (not FOwner.FRowSelect) then
            begin
              if (not FOwner.IsEditing) and Assigned(FFocused) then
                InitiateEditOp(FFocused, FHitColumn, False);
            end;
          end;
        VK_RETURN:
          if {(FOwner.QuickEditMode) and} (Shift = []) and (not FOwner.FRowSelect) then
          begin
            if (not FOwner.IsEditing) and Assigned(FFocused) then
              InitiateEditOp(FFocused, FHitColumn, False);
          end;
      end;
    finally
      if FOwner.FMultiSelect then
        FOwner.IsUpdating := False;
    end;
    if FOwner.FSelChange then
    begin
      FOwner.DoAfterSelectionChange;
      FOwner.FSelChange := False;
    end;
  end;
end;

procedure TElXTreeView.KeyPress(var Key: Char);
begin
  inherited;
end;

procedure TElXTreeView.SetFocus;
begin
  if CanFocus then
  try
    inherited SetFocus;
 except
 end;
end;

procedure TElXTreeView.DoSetSelected(AItem: TElXTreeItem);
var
  PreLevel: Integer; // CNS
begin
  // if (value <> nil) and (not value.AllowSelection) then Exit;
  if FOwner.FMultiSelect then
  begin
    if Assigned(AItem) then
    begin
      if FOwner.FSelectedList.Count > 0 then // CNS if existing selection(s), then get previous level started
        PreLevel := TElXTreeItem(FOwner.FSelectedList.First).Level
      else
        PreLevel:=FOwner.FMultiSelectLevel;

      if FOwner.FMultiSelectLevel >= 0 then // CNS if either existing or new select has wrong level, deselect all
        if (AItem.Level<>FOwner.FMultiSelectLevel) or (PreLevel<>FOwner.FMultiSelectLevel) then
          Owner.DeselectAll;

      if AItem.Selected then
      begin
        FOwner.FSelChange := True;
        //Exclude(FState, stsSelected);
//        FBoolData := FBoolData and not ibfSelected;
        AItem.DoSetSelected(False);
        FOwner.FSelectedList.Remove(AItem);
        if FSelected = AItem then
          FSelected := nil;
      end
      else
      begin
        if FOwner.FKeepSelectionWithinLevel and (FOwner.FSelectedList.Count > 0) and
          (FOwner.FSelectedList[0] <> AItem) then
        begin
          if AItem.Level <> TElXTreeItem(FOwner.FSelectedList[0]).Level then
            Exit;
        end;
        FOwner.FSelChange := True;
        AItem.DoSetSelected(True);
        FOwner.FSelectedList.AddAndCheckDuplicates(AItem);
        if FSelected = nil then
          FSelected := AItem;
      end;
      FOwner.TriggerItemSelectedChangeEvent(AItem);
      AItem.UpdateItem;
      FOwner.DoAfterSelectionChange;
    end
  end
  else
  begin
    if Assigned(FSelected) then
    begin
      FOwner.FSelChange := True;
      //Exclude(FState, stsSelected);
      if Assigned(FSelected) then
        FSelected.DoSetSelected(False);
      FSelected.UpdateItem;
      FOwner.TriggerItemSelectedChangeEvent(FSelected);
      FSelected := FFocused;
    end;
    if Assigned(AItem) then
    begin
      FOwner.FSelChange := True;
      //Include(FState, stsSelected);
      AItem.DoSetSelected(True);
      FSelected := AItem;
      FOwner.TriggerItemSelectedChangeEvent(AItem);
      AItem.UpdateItem;
//      FOwner.DoAfterSelectionChange;
    end
    else
    begin
      FSelected := nil;
      FFocused := nil;
    end;
  end;
end;

function TElXTreeView.GetVisCount: Integer;
var
  LLineHeight: Integer;
  LHeight: Integer;
begin
  LHeight := ClientHeight;
  LLineHeight := FOwner.FLineHeight;
  Result := LHeight div LLineHeight;
  if (LHeight mod LLineHeight) > 0 then
    Inc(Result);
end;

procedure TElXTreeView.CMMouseLeave(var Message: TMessage);
var
  TSI: TElXTreeItem;
begin
  if (Message.LParam = 0) or (Message.LParam = TLMDPtrInt(Self)) then
    begin
      if assigned(FInpEdit) and FInpEdit.Visible then
          Exit;
      TSI := FTrackItem;
      FTrackItem := nil;
      if TSI <> nil then
        begin
          TSI.RedrawItem(True);
          Invalidate; //Update;
        end;
      FHintItemEx := nil;
      // Destroy Hint timer
      DoHideLineHint;
      if FClickControl <> nil then
        begin
          FClickControl.TriggerMouseUpEvent(mbLeft, LMDGetShiftState, -1, -1);
          FClickControl := nil;
        end;
    end;
  inherited;
end;

procedure TElXTreeView.CMHintShow(var Msg: TCMHintShow);
var
  HintInfo: PHintInfo;
  Item: TElXTreeItem;
  IP: TSTXItemPart;
  HCol: Integer;
  LItemHint: TLMDString;
  {$ifdef LMD_UNICODE}
  S: String;
  WS: WideString;
  {$endif}

begin
  HintInfo := Msg.HintInfo;
  Item := GetItemAt(HintInfo.CursorPos.X, HintInfo.CursorPos.Y, IP, HCol);
  if Assigned(Item) then
    LItemHint := Item.Hint;
  if (Item <> nil) and (LItemHint <> '') then
     HintInfo.HintStr := LItemHint;
  FHintItemEx := Item;
  {$ifdef LMD_UNICODE}
  if (Item <> nil) and (LItemHint <> '') then
  begin
    if (FOwner.HintType in [shtHintOrText, shtMainText]) then
    begin
      Application.CancelHint;
      Exit
    end
    else
      WS := LItemHint
  end
  else
    WS := Owner.FHint;
  if Length(WS) = 0 then
  begin
    HintInfo.HintStr := '';
    Exit;
  end;

  if HintInfo.HintStr = GetShortHint(Owner.Hint) then
  begin
    WS := LMDWideGetShortHint(WS);
    S := WS;
  end
  else
    S := WS;

  HintInfo.HintStr := LMDConvertVCLHint(S);

  {$endif}
end;

procedure TElXTreeView.CMSysColorChange(var Msg: TMessage);
begin
  inherited;
  Invalidate;
  if PlusBmp <> nil then
    ChangeButtonColors(PlusBmp);
  if MinusBmp <> nil then
    ChangeButtonColors(MinusBmp);
  if LeafBmp <> nil then
    ChangeButtonColors(LeafBmp);
  end;

procedure TElXTreeView.OnDropTargetDrag(Sender: TObject; State: TDragState; Source: TOleDragObject; Shift: TShiftState; X: Integer; Y: Integer; var DragType: TDragType);
var
  Item: TElXTreeItem;

begin
  FOwner.TriggerOleTargetDragEvent(State, Source, Shift, X, Y, DragType);
  DoDragOver(Source, X, Y, DragType in [dtCopy, dtMove, dtLink]);
  if State = dsDragLeave then
  begin
    if Self.FDropTrg <> nil then
    begin
      Item := FDropTrg;
      FDropTrg := nil;
      Item.RedrawItem(True);
    end;
  end;
end;

procedure TElXTreeView.OnDropTargetDrop(Sender: TObject; Source: TOleDragObject; Shift: TShiftState; X: Integer; Y: Integer; var DragType: TDragType);
var
  TSI: TElXTreeItem;
begin
  TSI := FDropTrg;
  FDropTrg := nil;
  if TSI <> nil then
    TSI.RedrawItem(True);
  FOwner.TriggerOleTargetDropEvent(Source, Shift, X, Y, DragType);
end;

procedure TElXTreeView.WMSetFocus(var Msg: TWMSetFocus);  { private }
begin
  inherited;
  FHasFocus := True;
  if (FOwner.HideSelection or (FOwner.HideSelectColor <> FOwner.FocusedSelectColor) or (FOwner.HideSelectTextColor <> FOwner.FocusedSelectTextColor)) and
     (FOwner.Items.Count > 0) then
    Invalidate;
  with FOwner do
    if Flat or FUseCustomScrollBars or IsThemed then
      UpdateFrame;
end;  { WMSetFocus }

procedure TElXTreeView.WMKillFocus(var Msg: TWMKillFocus);  { private }

begin
  FMouseSel := False;
  FPressed := False;
  FHasFocus := False;
  inherited;
  FHintItemEx := nil;
  DoHideLineHint;

  if HandleAllocated then
  begin
    with FOwner do
      if Flat or FUseCustomScrollBars or IsThemed then
      begin
        UpdateFrame;
        DrawFlatBorder(False, False);
        if FUseCustomScrollBars then
        begin
          HScrollBar.HideHint;
          VScrollBar.HideHint;
        end;
      end;
    if (FOwner.HideSelection or (FOwner.HideSelectColor <> FOwner.FocusedSelectColor) or (FOwner.HideSelectTextColor <> FOwner.FocusedSelectTextColor)) and
       (FOwner.Items.Count > 0) then
      Invalidate;
  end;
end;  { WMKillFocus }

function TElXTreeView.GetDragImages: TDragImageList;

begin
  if (FDragImages <> nil) and (FDragImages.Count > 0) then
     Result := FDragImages
  else
     Result := nil;
end;

procedure TElXTreeView.UpdateView;
var
  R: TRect;
begin
  if (not HandleAllocated) then
  begin
    FOwner.FUpdated := True;
    Exit;
  end;
  if FOwner.FUpdateCount > 0 then
    FOwner.FUpdated := True
  else
  begin
    if FRangeUpdate or (FClearAll) then
    begin
      if (FOwner.FVerticalLines and FOwner.ShowColumns) or (FClearAll) then
      begin
        R := ClientRect;
        FClearAll := False;
      end
      else
        R := Rect(0, 0, ClientWidth, GetVisiblesHeight);
      InvalidateRect(Handle, @R, True);
      FRangeUpdate := False;
    end;
    Invalidate; //Update;
  end;
end;

procedure TElXTreeView.DoPaintBkgnd(DC: HDC; ClipRect: TRect);
var
  AClipRect: TRect;
  ACtl: TWinControl;
  R1: TRect;
  BgRect: TRect;
  BgRect1: TRect;
begin
  Canvas.Brush.Color := FOwner.BackGroundColor;
  BgRect := ClientRect;
  Inc(BgRect.Bottom);
  Inc(BgRect.Right);
  AClipRect := ClipRect;
  if (FOwner.FImageForm <> nil) and not (csDesigning in FOwner.FImageForm.ComponentState) then
  begin
    //if (FOwner.FImageForm.Control <> Parent) then
    begin
      ACtl := FOwner.FImageForm.GetRealControl;
      R1 := BgRect;
      BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
      BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
      //BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
      //BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);

      FOwner.FImageForm.PaintBkgnd(DC, R1, BgRect.TopLeft, False);
    end;
  end
  else
  if (FOwner.BackgroundType <> bgtColorFill) then
  begin
    BgRect1 := BgRect;
    if FOwner.BackgroundType <> bgtCenterBitmap then
    begin
      LMDExtDrawBkgnd(DC,  BgRect1, BgRect, BgRect, AClipRect, False, Canvas.Brush.Color, Canvas.Brush.Color, FTmpBmp, bgtCenterBitmap);
    end
    else
    begin
      LMDExtDrawBkgnd(DC, BgRect1, BgRect, BgRect, AClipRect, False, Canvas.Brush.Color, Canvas.Brush.Color, FOwner.Background, FOwner.BackgroundType);
    end;
    end
  else
  begin
    if not FOwner.FInSizeMove then
      FillRect(DC, AClipRect, Canvas.Brush.Handle);
  end;
end;

{$warnings off}
procedure TElXTreeView.WMPaint(var Msg: TWMPaint);  { private }
var
  ADC,
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  R: TRect;
  ARgn: HRGN;
  DoDoubleBuffer: Boolean;
begin
  MemDC := 0;
  MemBitmap := 0;
  ARgn := 0;
  OldBitmap := 0;
  DoDoubleBuffer := (FOwner.DoubleBuffered and not Fowner.FInSizeMove) or (FOwner.FInSizeMove and FOwner.DoubleBufferedOnResize);
  if not FOwner.IsUpdating then
  begin
    if (Msg.DC <> 0) then
      PaintHandler(Msg)
    else
    begin
      DC := BeginPaint(Handle, PS);
      try
        if DoDoubleBuffer then
        begin
          //DC := GetDC(0);
          MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
          //ReleaseDC(0, DC);
          MemDC := CreateCompatibleDC(0);
          OldBitmap := SelectObject(MemDC, MemBitmap);
          ADC := MemDC;
        end
        else
          ADC := 0;

        try
          if not DoDoubleBuffer then
            ADC := DC;
          GetClipBox(DC, R);
          if IsRectEmpty(R) then
            R := ClientRect
          else
          begin
            Inc(R.Right);
            Inc(R.Bottom);
          end;
          //with R do
          //  BitBlt(MemDC, Left, Top, Right - Left, Bottom - Top, DC, Left, Top, SRCCOPY);

          if DoDoubleBuffer then
          begin
            with R do
              ARgn := CreateRectRgn(Left, Top, Right, Bottom);
            {$ifdef DEBUG_TREE_DRAW}
              SelectClipRgn({A$$}DC, ARgn);
            {$else}
              SelectClipRgn(ADC, ARgn);
            {$endif}
          end;

          {$ifdef DEBUG_TREE_DRAW}
            DoPaintBkgnd({A$$}DC, R);
            Msg.DC := {A$$}DC;
          {$else}
            DoPaintBkgnd(ADC, R);
            Msg.DC := ADC;
          {$endif}

          PaintHandler(Msg);

          if DoDoubleBuffer then
          begin
          {$ifdef DEBUG_TREE_DRAW}
            SelectClipRgn({Mem$$}DC, 0);
          {$else}
            SelectClipRgn(MemDC, 0);
          {$endif}
            DeleteObject(ARgn);
          end;
          Msg.DC := 0;
          if DoDoubleBuffer then
            with R do
              {$ifdef DEBUG_TREE_DRAW}
                BitBlt(DC, Left, Top, Right - Left, Bottom - Top, {Mem$$}DC, Left, Top, SRCCOPY);
              {$else}
                BitBlt(DC, Left, Top, Right - Left, Bottom - Top, MemDC, Left, Top, SRCCOPY);
              {$endif}
        finally
          if DoDoubleBuffer then
          begin
            SelectObject(MemDC, OldBitmap);
            DeleteDC(MemDC);
            DeleteObject(MemBitmap);
          end;
        end;
      finally
        EndPaint(Handle, PS);
      end;
    end;
  end
  else
  begin
    DefWindowProc(Handle, WM_PAINT, TMessage(Msg).wParam, TMessage(Msg).lParam);
    FClearAll := True;
  end;
end;
{$warnings on}

function TElXTreeView.GetVisCount2: Integer;
var
  j: Integer;
  CliHeight: Integer;
begin
  CliHeight := Height;
  j := FOwner.FLineHeight;
  Result := CliHeight div j;
end;

procedure TElXTreeView.OnDragExpandTimer(Sender: TObject);
begin
  FDragExpandTimer.Enabled := False;
  if (FDropTrg <> nil) and (not FDropTrg.Expanded) {and (FDropTrg.HasVisibleChildren) }then
  begin
    if FOwner.FDragObject <> nil then
      FOwner.FDragObject.HideDragImage;
    FDropTrg.Expand(False);
    Invalidate; //Update;
    if FOwner.FDragObject <> nil then
      FOwner.FDragObject.ShowDragImage;
  end;
end;

procedure TElXTreeView.StartClearSearchTimeoutThread ;
begin
  if Assigned (SearchTextTimeoutThread) then
    TSearchTextTimeoutThread(SearchTextTimeoutThread).KeepAlive := True
  else
  begin
    SearchTextTimeoutThread := TSearchTextTimeoutThread.Create ;
    SearchTextTimeoutThread.OnTerminate := SearchTextTimeout ;
    SearchTextTimeoutThread.Resume
  end;
  TSearchTextTimeoutThread(SearchTextTimeoutThread).IncrementalSearchTimeout := FOwner.IncrementalSearchTimeout;
end;

procedure TElXTreeView.StopClearSearchTimeoutThread ;
begin
  if Assigned (SearchTextTimeoutThread) then
  begin
    SearchTextTimeoutThread.OnTerminate := nil ;
    SearchTextTimeoutThread.Terminate ;

    SearchTextTimeoutThread := nil
  end
end ;

procedure TElXTreeView.SearchTextTimeout (Sender: TObject) ;
begin
  SearchTextTimeoutThread := nil ;
  Input.Reset;
end;

procedure TElXTreeView.FitMostChildren(Item: TElXTreeItem);
var
  R: TRect;
  i,
  k,
  ch,
  cti: Integer;
  oi: Integer;
  TopItem: TElXTreeItem;

begin
  if Item.FullyExpanded and Item.FullyVisible and (FOwner.IsInView(Item)) then
  begin
    k := Item.CalcSubItemsHeight;
    TopItem := FOwner.GetTopItem();
    if TopItem <> nil then
    begin
      cti := TopItem.VisIndex;
      oi := Item.VisIndex;
      R := GetItemRect(ColorHelper.Visible.IndexOf(Item));
      i := 0;
      ch := ClientHeight;
      if cti < oi then
      begin
        while (cti < oi) do
        begin
          if ColorHelper.Visible.Count <= i then
            break;

          TopItem := TElXTreeItem(ColorHelper.Visible[i]);

          if R.Bottom + k >= ch then
          begin

            Dec(R.Bottom, TopItem.Height);

            Inc(i);
            Inc(cti);
          end
          else
          begin
            break;
          end;
        end;
        FOwner.GetTotalVisCount;
        FOwner.TopIndex := FOwner.TopIndex + i;
      end;
    end;
  end;
end;

type

  PGetItemRec = ^TGetItemRec;

  TGetItemRec = record
    ItemIndex: Integer;
    oi: Integer;
    PageCount: Integer;
    {TSI,} FocusedItemCurrent: TElXTreeItem;
    FocusedItemNew: TElXTreeItem;
    Selected: Boolean;
  end;

procedure TElXTreeView.IntVis0(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean;
  IterateData: TLMDDataTag; Tree: TCustomElXTree);
var

  LPGetItemRec: PGetItemRec;

begin

  LPGetItemRec := PGetItemRec(IterateData);

  if Item.Enabled or Tree.IgnoreEnabled then
  begin

    LPGetItemRec^.Selected := Item.Selected;
    LPGetItemRec^.FocusedItemNew := Item;
    LPGetItemRec^.ItemIndex := 0;

    ContinueIterate := False;
  end;
 end;

procedure TElXTreeView.IntNextVis(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean;
  IterateData: TLMDDataTag; Tree: TCustomElXTree);
var

  LPGetItemRec: PGetItemRec;

begin

  LPGetItemRec := PGetItemRec(IterateData);
  if (LPGetItemRec^.FocusedItemCurrent = Tree.FView.FFocused)
    and (Tree.IgnoreEnabled or Item.Enabled)
  then
  begin
    LPGetItemRec^.Selected := Item.Selected;
    LPGetItemRec^.FocusedItemNew := Item;
    LPGetItemRec^.ItemIndex := Index;
    ContinueIterate := False;
  end;
  if Item = Tree.FView.FFocused then
     LPGetItemRec^.FocusedItemCurrent := Item;

end;

procedure TElXTreeView.IntPgVis(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean;
  IterateData: TLMDDataTag; Tree: TCustomElXTree);
var

  LPGetItemRec: PGetItemRec;

begin

  LPGetItemRec := PGetItemRec(IterateData);
  if Item = Tree.FView.FFocused then
  begin
    LPGetItemRec^.oi := 1;
  end;
  if LPGetItemRec^.oi = 1 then
  begin
    if Tree.IgnoreEnabled or Item.Enabled then
    begin
      Dec(LPGetItemRec^.PageCount);
      LPGetItemRec^.FocusedItemNew := Item;
    end;
//      LPGetItemRec^.TSI := Item;
    LPGetItemRec^.Selected := Item.Selected;
    LPGetItemRec^.ItemIndex := Index;
  end;
  if LPGetItemRec^.PageCount < 0 then
    ContinueIterate := False;

end;

function TElXTreeView.FindNewFocused(AKey: word; var AIndex: Integer; var ASelected: Boolean): TElXTreeItem;
  procedure ProcessUpKey(var AGetItemRec:TGetItemRec);
  begin
    if FFocused = nil then
    begin
      if FOwner.TotalVisCount > 0 then
      begin
        FItems.Iterate(True, False, IntVis0, @AGetItemRec);
        Result := AGetItemRec.FocusedItemNew;
      end;
    end
    else
    begin
      FItems.IterateBack(True, False, IntNextVis, @AGetItemRec);
      if AGetItemRec.FocusedItemNew <> nil then
        Result := AGetItemRec.FocusedItemNew
      else
        Result := FFocused;
    end;
    AIndex := AGetItemRec.ItemIndex;
  end;

  procedure ProcessDownKey(var AGetItemRec: TGetItemRec);
  begin
    if not Assigned(FFocused) then
    begin
      if FOwner.TotalVisCount > 0 then
      begin
        FItems.Iterate(True, False, IntVis0, @AGetItemRec);
        Result := AGetItemRec.FocusedItemNew;
      end;
    end
    else
    begin
      FItems.Iterate(True, False, IntNextVis, @AGetItemRec);
      if AGetItemRec.FocusedItemNew <> nil then
        Result := AGetItemRec.FocusedItemNew
      else
        Result := FFocused;
    end;
    AIndex := AGetItemRec.ItemIndex;
  end;

  procedure ProcessNextKey(var AGetItemRec:TGetItemRec);
  begin
    if FOwner.TotalVarHeightCount > 0 then
       AGetItemRec.PageCount := CalcPageDownPos(FOwner.FTopIndex) - FOwner.FTopIndex
    else
       AGetItemRec.PageCount := GetVisCount - 1;

    AGetItemRec.oi := 0;
    AGetItemRec.FocusedItemNew := nil;
    if FFocused <> nil then
       FItems.IterateFrom(True, False, IntPgVis, @AGetItemRec, FOwner.ItemFocused);
    if AGetItemRec.FocusedItemNew <> nil then
      Result := AGetItemRec.FocusedItemNew
    else
      Result := FFocused;
  end;

  procedure ProcessPriorKey(var AGetItemRec:TGetItemRec);
  begin
    if FFocused = nil then
    begin
      if FOwner.TotalVarHeightCount > 0 then
         AGetItemRec.PageCount := FOwner.FTopIndex - CalcPageUpPos(FOwner.FTopIndex)
      else
         AGetItemRec.PageCount := GetVisCount - 1;
    end
    else
    begin
      AGetItemRec.oi := FFocused.VisIndex;
      if FOwner.TotalVarHeightCount > 0 then
         AGetItemRec.PageCount := AGetItemRec.oi - CalcPageUpPos(AGetItemRec.oi)
      else
         AGetItemRec.PageCount := GetVisCount - 1;
    end;
    AGetItemRec.oi := 0;
    AGetItemRec.FocusedItemNew := nil;

    if FFocused <> nil then
       FItems.IterateBackFrom(True, False, IntPgVis, @AGetItemRec, FOwner.ItemFocused);
    if AGetItemRec.FocusedItemNew <> nil then
      Result := AGetItemRec.FocusedItemNew
    else
      Result := FFocused;
  end;

  procedure ProcessHomeKey(var AGetItemRec: TGetItemRec);
  begin
    if FFocused <> nil then
    begin
      FItems.Iterate(True, False, IntVis0, @AGetItemRec);
      Result := AGetItemRec.FocusedItemNew;
      AGetItemRec.ItemIndex := 0;
      if Result = nil then
      begin
        Result := FOwner.ItemFocused;
        AGetItemRec.ItemIndex := FOwner.FTopIndex;
      end;
    end;
  end;

  procedure ProcessEndKey(var AGetItemRec:TGetItemRec);
  begin
    if FFocused <> nil then
    with FOwner do
    begin
      AGetItemRec.ItemIndex := TotalVisCount - 1;
      Result := FItems.GetVisItem(AGetItemRec.ItemIndex);
      while Assigned(Result) and not (FOwner.IgnoreEnabled or Result.Enabled) do
      begin
        Dec(AGetItemRec.ItemIndex);
        if AGetItemRec.ItemIndex >= 0 then
           Result := FItems.GetVisItem(AGetItemRec.ItemIndex);
      end;
      if Result = nil then
      begin
        Result := ItemFocused;
        AGetItemRec.ItemIndex := FTopIndex;
      end;
    end;
  end;

var
  LGetItemRec: TGetItemRec;
begin
  Result := nil;
  FillChar(LGetItemRec, sizeof(LGetItemRec), 0);
  case AKey of
    VK_UP:    ProcessUpKey(LGetItemRec);
    VK_DOWN:  ProcessDownKey(LGetItemRec);
    VK_NEXT:  ProcessNextKey(LGetItemRec);
    VK_PRIOR: ProcessPriorKey(LGetItemRec);
    VK_HOME:  ProcessHomeKey(LGetItemRec);
    VK_END:   ProcessEndKey(LGetItemRec);
    else      Exit;
  end;
  ASelected := LGetItemRec.Selected;
  end;

procedure TElXTreeView.DrawMouseSelectFrame(AHide: boolean = false);
var
  R: TRect;
  R1: TRect;
  si: Integer;
  ei: Integer;
//  LStartItem, LEndItem: TElXTreeItem;
  LOldColor: TColor;
begin
  R := Rect(Min(FMouseFrameRec.StartCoord.X, FMouseFrameRec.EndCoord.X),
    0,
    Max(FMouseFrameRec.StartCoord.X, FMouseFrameRec.EndCoord.X),
    0);
  OffsetRect(R, -FOwner.FLeftPosition, 0);
  si := ColorHelper.Visible.IndexOf(FMouseFrameRec.StartItem);
  if si <> -1 then
  begin
    R1 := GetItemRect(si);
    si := R1.Top + FMouseFrameRec.StartCoord.Y;
  end
  else
  begin
    si := 0;
    if Assigned(FMouseFrameRec.StartItem) then
    begin
      if Assigned(FMouseFrameRec.EndItem) and (FMouseFrameRec.StartItem.AbsoluteIndex > FMouseFrameRec.EndItem.AbsoluteIndex) then
        si := Height + FMouseFrameRec.StartCoord.Y;
    end
    else
      si := FMouseFrameRec.StartCoord.Y;
  end;
 { if FMouseFrameRec.StartItem = nil then
    LStartItem := TElXTreeItem(ColorHelper.Visible.Last)
  else
    LStartItem := FMouseFrameRec.StartItem;
  if FMouseFrameRec.EndItem = nil then
    LEndItem := TElXTreeItem(ColorHelper.Visible.Last)
  else
    LEndItem := FMouseFrameRec.EndItem;  }

  ei := ColorHelper.Visible.IndexOf(FMouseFrameRec.EndItem);
  if ei <> -1 then
  begin
    R1 := GetItemRect(ei);
    ei := R1.Top + FMouseFrameRec.EndCoord.Y;
  end
  else
    ei := FMouseFrameRec.EndCoord.Y;
  if (ei <> -1) and (si <> -1) then
  begin
    R.Top := Min(si, ei);
    R.Bottom := Max(si, ei);
  end
  else
  if (si = -1) and (ei = -1) then
  begin
    R.Top := -1;
    R.Bottom := ClientHeight + 1;
  end
  else
  if ei = -1 then
  begin
    R.Top := si;
    R.Bottom := ClientHeight + 1;
  end;
  // {AH} Replace DrawFocusRect by AlphaFillRect
  LOldColor := Canvas.Brush.Color;
  Canvas.Brush.Color := clHighlight;
  if AHide then
  invalidate;
  AlphaFillRect(Canvas, R, clHighlight, 150);
  Canvas.FrameRect(R);
  Canvas.Brush.Color := LOldColor;
// {AH} Old code
{  Canvas.Brush.Color := FOwner.FBackGroundColor;
  Canvas.Pen.Color := FOwner.FTextColor;
  Canvas.Font.Color := FOwner.FTextColor;
  // this one is made to fix the colors
  Canvas.TextOut(R.Left, R.Top, '');
  // otherwise FocusRect won't draw right
  Canvas.DrawFocusRect(R);}
end;

procedure TElXTreeView.AllocateMouseSelectFrame;
begin
  DrawMouseSelectFrame;
end;

procedure TElXTreeView.DeallocateMouseSelectFrame;
begin
  DrawMouseSelectFrame(True);
end;

procedure TElXTreeView.SelectMouseSelectItems;
var
  i, j: Integer;
  LStartItem, LEndItem: integer;
  LStartCol, LEndCol: integer;
begin
  FOwner.SetUpdating(True);
  i := 0;
  if FMouseFrameRec.StartItem = nil then
    LStartItem := FOwner.FAllList.IndexOf(TElXTreeItem(ColorHelper.Visible.Last)) + 1
  else
    LStartItem := FOwner.FAllList.IndexOf(FMouseFrameRec.StartItem);
  if FMouseFrameRec.EndItem = nil then
    LEndItem := FOwner.FAllList.IndexOf(TElXTreeItem(ColorHelper.Visible.Last)) + 1
  else
    LEndItem := FOwner.FAllList.IndexOf(FMouseFrameRec.EndItem);
  if FMouseFrameRec.StartColumn = -1 then
    LStartCol := FOwner.HeaderSections.Count
  else
    LStartCol := FMouseFrameRec.StartColumn;
  if FMouseFrameRec.EndColumn = -1 then
    LEndCol := FOwner.HeaderSections.Count
  else
    LEndCol := FMouseFrameRec.EndColumn;
  if LStartCol > LEndCol then
    LMDSwapInt(LStartCol, LEndCol);
  if LStartItem > LEndItem then
    LMDSwapInt(LStartItem, LEndItem);
  while i < FOwner.FSelectedList.Count do
  begin
    if not LMDInRange(FOwner.FAllList.IndexOf(TElXtreeItem(FOwner.FSelectedList[i])), LStartItem, LEndItem) then
      TElXtreeItem(FOwner.FSelectedList[i]).Selected := False
    else
    begin
      for j := 0 to TElXtreeItem(FOwner.FSelectedList[i]).Cells.Count - 1 do
      begin
        if not LMDInRange(j, LStartCol, LEndCol) then
          TElXtreeItem(FOwner.FSelectedList[i]).Cells[j].Selected := False;
      end;
    end;
    inc(i);
  end;
  FOwner.SelectRangeEx3(FMouseFrameRec.StartItem, FMouseFrameRec.EndItem, FMouseFrameRec.StartColumn, FMouseFrameRec.EndColumn, False, False, True, True);
  FOwner.SetUpdating(False);
  Invalidate;
end;

procedure TElXTreeView.WMCancelMode(var Message: TWMCancelMode);
begin
  if FMouseSel then
    CancelMouseSel;
  inherited;
end;

procedure TElXTreeView.CancelMouseSel;
begin
//  FMouseFrameRec.FreeAndNil(CellList);
  FMouseSel := False;
  if FOwner.FMouseFrameVisible then
    DeallocateMouseSelectFrame;
  ReleaseCapture;
//  Refresh;
end;

procedure TElXTreeView.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited CreateWindowHandle(Params);

  if Assigned(FOwner.FDropTarget) then
    FOwner.FDropTarget.Target := Self;
end; {CreateWindowHandle}

procedure TElXTreeView.DestroyWindowHandle;
begin
  if Assigned(FOwner.FDropTarget) and (FOwner.FDropTarget.Target = Self) then
    FOwner.FDropTarget.Target := nil;
  inherited;
end;

procedure TElXTreeView.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
  end;

procedure TElXTreeView.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (FOwner.ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;

procedure TElXTreeView.CMDeactivate(var Message: TCMDeactivate);
begin
  inherited;
  if FOwner.FHideSelection then
    Invalidate;
end;

procedure TElXTreeView.CMDrag(var Message: TCMDrag);
var
  TSI: TElXTreeItem;
begin
  FOwner.FDragObject := Message.DragRec^.Source;
  inherited;
  with Message, DragRec^ do
  begin
    case DragMessage of
      dmDragEnter:
        FInDragging := True;
      dmDragMove:
        begin
          if FOwner.DragAllowed then
            with ScreenToClient(Pos) do
              DoDragOver(Source, X, Y, Message.Result <> 0);
        end;
      {
      dmFindTarget:
        begin
          if FOwner.DragAllowed then
            with ScreenToClient(Pos) do
              DoDragOver(Source, X, Y, Message.Result <> 0);
        end;
      }
      dmDragLeave:
        begin
          FInDragging := False;
          FOwner.FDragObject := nil;
          if FDragExpandTimer <> nil then
          begin
            FDragExpandTimer.Enabled := False;
          end;

          if FOwner.DragAllowed then
          begin
            if FDragScrollTimer <> nil then
              FreeAndNil(FDragScrollTimer);
            TDragObject(Source).HideDragImage;
            TSI := FDropTrg;
            FDropTrg := nil;
            if TSI <> nil then
            begin
              TSI.RedrawItem(False);
              Invalidate; //Update;
            end;
            TDragObject(Source).ShowDragImage;
          end;
        end;
      dmDragDrop,
      dmDragCancel:
        begin
          FInDragging := False;
          FOwner.FDragObject := nil;
          if FDragExpandTimer <> nil then
          begin
            FDragExpandTimer.Enabled := False;
            FreeAndNil(FDragExpandTimer);
          end;

          if FOwner.DragAllowed then
          begin
            if FDragScrollTimer <> nil then
              FreeAndNil(FDragScrollTimer);
            TSI := FDropTrg;
            FDropTrg := nil;
            if TSI <> nil then
            begin
              TSI.RedrawItem(False);
              Invalidate; //Update;
            end;
          end;
        end;
    end;
  end;
end;

procedure TElXTreeView.InitiateEditOp(Item: TElXTreeItem; HCol: Integer;
    Immediate: Boolean);
begin
  with FOwner do
    if (ShowColumns) then
    begin
      if ((FClickSection = HCol) or (FOwner.QuickEditMode)) and (HCol >= 0) and
         Assigned(Item.Cells[HCol].Control) then
      begin
        Item.Cells[HCol].Control.SetControlActive;
      end
      else
        if ((FClickSection = HCol) or (FOwner.QuickEditMode)) and (HCol >= 0) and
           FHeader.Sections[HCol].Editable and
           not (csDesigning in FOwner.ComponentState) then
        begin
          if FEditTimer = nil then
            FEditTimer := TTimer.Create(self);
          FEditTimer.Enabled := False;
          // FEditTimer.Interval := 500;
          if not Immediate then
            FEditTimer.Interval := FOwner.InplaceEditorDelay
          else
            FEditTimer.Interval := 1;
          FEditTimer.OnTimer := OnEditTimer;
          FItemToEdit := Item;
          FEditSect := HCol;
          FEditTimer.Enabled := True;
        end;
    end
    else if not (csDesigning in FOwner.ComponentState) then
    begin
      if FEditTimer = nil then
        FEditTimer := TTimer.Create(self);
      FEditTimer.Enabled := False;
      if not Immediate then
        FEditTimer.Interval := FOwner.InplaceEditorDelay
      else
        FEditTimer.Interval := 1;
      FEditTimer.OnTimer := OnEditTimer;
      FItemToEdit := Item;
      FEditSect := -1;
      FEditTimer.Enabled := True
    end;
end;

function TElXTreeView.IsControlCell(Item: TElXTreeItem; SectionIndex: Integer):
    Boolean;
var
  AStyle: TElXCellStyle;
  i: Integer;
begin
  Result := False;
  //if Item.UseStyles then
  //begin
    if FOwner.VirtualityLevel = vlNone then
    begin
      i := SectionIndex;
      if i = FOwner.FMainTreeColumn then
        AStyle := Item.CurrentStyle as TElXCellStyle
      else
      begin
//        if i > FOwner.FMainTreeColumn then
//          Dec(i);
        if Item.Cells.Count > i then
          AStyle := Item.Cells[i].CurrentStyle as TElXCellStyle
        else
          AStyle := Item.CurrentStyle as TElXCellStyle;
      end;
    end
    else
    begin
      if LMDInRange(SectionIndex, 0, Item.Cells.Count - 1) then
        AStyle := Item.Cells[SectionIndex].Style
      else
        AStyle := VirtStyle;
//      if (not (csDesigning in FOwner.ComponentState)) then
//        FOwner.TriggerVirtualStyleNeeded(Item, SectionIndex, AStyle);
    end;
    if (AStyle <> nil)
      //and not AStyle.OwnerProps
      and (AStyle.Control <> nil)
      and TElXCellControl(AStyle.Control).Visible
    then
      Result := True;
  //end;
end;

procedure TElXTreeView.DrawCellImage(ACanvas: TCanvas; Item: TElXTreeItem;
    ImageIndex: Integer; SectionIndex: Integer; HelperBitmap: TBitmap; var R
: TRect);
var
  FTImages: TCustomImageList;
  FATImages: TCustomImageList;
  ImDrawStyle: TDrawingStyle;
  StImIndex: Integer;
  h, w: Integer;
  R2: TRect;
  xp: Integer;
  amBmp: TBitmap;
  begin
  if R.Left >= R.Right then
    Exit;

  FTImages := FOwner.FImages;
  if FTImages = nil then
    Exit;

  with FOwner do
  begin
    FATImages := FAlphaForImages;
    ImDrawStyle := FTImages.DrawingStyle;
    FTImages.DrawingStyle := dsNormal;
    StImIndex := ImageIndex;
    if StImIndex = -1 then
      if (not ShowColumns) or (SectionIndex = FMainTreeColumn) then
        StImIndex := DoGetPicture(Item, -1)
      else
        StImIndex := DoGetPicture(Item, SectionIndex);

    if LMDInRange(StImIndex, 0, FTImages.Count - 1) then
    begin
      h := FTImages.Height;
      w := FTImages.Width;

      if FOwner.RightAlignedView then
        R2 := Rect(Max(R.Left, R.Right - w), R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1), R.Right, R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1) + h)
      else
        R2 := Rect(R.Left, R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1), Min(R.Right, R.Left + w), R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1) + h);

      if R2.Right - R2.Left = w then
      begin
        OffsetRect(R2, ((R.right - R.Left) - w) div 2, 0);
      end;
      if R2.Right >= R2.Left then
      begin
        HelperBitmap.PixelFormat := pfDevice;
        HelperBitmap.Height := R2.Bottom - R2.Top;
        HelperBitmap.Width := R2.Right - R2.Left;

        bitblt(HelperBitmap.Canvas.Handle, 0, 0, HelperBitmap.Width, HelperBitmap.Height, ACanvas.Handle, R2.Left, R2.Top, srccopy);
        if FOwner.RightAlignedView then
          xp := HelperBitmap.Width - w
        else
          xp := 0;
        FTImages.Draw(HelperBitmap.Canvas, xp, 0, StImIndex);

        if (FATImages <> nil) and LMDInRange(StImIndex, 0, FATImages.Count - 1) then
        begin
          amBMP := TBitmap.Create;
          amBMP.Width := FATImages.Width;
          amBMP.Height := FATImages.Height;
          ImageList_DrawEx(FATImages.Handle, StImIndex, amBMP.Canvas.Handle, 0, 0, 0, 0,
            clNone, clNone, ILD_Normal);

          AlphaCopyRect2(ACanvas.Handle, r2, HelperBitmap.Canvas.Handle,
            rect(0, 0, HelperBitmap.Width, HelperBitmap.Height), amBMP, 255);

          FreeAndNil(amBMP);
        end
        else
          bitblt(ACanvas.Handle, r2.Left, R2.Top, HelperBitmap.Width, HelperBitmap.Height, HelperBitmap.Canvas.Handle, 0, 0, srccopy);
        end;

      if FOwner.RightAlignedView then
        Dec(R.Right, w)
      else
        Inc(R.Left, w);
    end;

    FTImages.DrawingStyle := ImDrawStyle;
    end;
end;

procedure TElXTreeView.DoPerformSearch(SearchText: TLMDString);
var
  liSearchTextLength,
  liIndex,
  siIndex: Integer ;
  AnItem: TElXTreeItem;
  ItemText: TLMDString;
begin
  if (SearchText > '') then
  begin
    liSearchTextLength := Length (SearchText) ;
    //ItemsCount := FOwner.Items.Count;
    if (FOwner.FIncrementalSearchScope = issWholeTree) or (FOwner.ItemFocused = nil) then
    begin
      if FOwner.ItemFocused = nil then
      begin
        liIndex := 0;
        siIndex := - 1;
      end
      else
      begin
        liIndex := FOwner.ItemFocused.AbsoluteIndex;
        siIndex := liIndex - 1;
        //if siIndex = -1 then
        //  siIndex := FOwner.Items.Count - 1;
      end;
    end
    else
    begin
      liIndex := FOwner.ItemFocused.FParent.GetFirstChild.Index;
      siIndex := FOwner.ItemFocused.FParent.GetLastSubItem.Index;
    end;
    while (liIndex <> siIndex) do
    begin
      AnItem := FOwner.Items [liIndex];
      if AnItem <> nil then
      begin
        ItemText := FOwner.GetIncSearchColumnText(AnItem);

        if ((not FOwner.FilteredVisibility) or (not AnItem.Hidden)) and AnItem.Enabled then
        begin
          {$ifdef LMD_UNICODE}
          if LMDWideSameText(SearchText, Copy(ItemText, 1, liSearchTextLength)) then
          {$else}
          if AnsiSameText(SearchText, Copy (ItemText, 1, liSearchTextLength)) then
          {$endif}
          begin
            FOwner.EnsureVisible(AnItem) ;
            AnItem.Focused := True ;
            AnItem.Selected := FOwner.IncrementalSearchSelectItem;
            FOwner.DoAfterSelectionChange;
            break;
          end ;
        end;
        Inc(liIndex);
        if liIndex >= FOwner.Items.Count then
        begin
          if siIndex = -1 then
            break
          else
            liIndex := 0;
        end;
      end
      else
        Exit;
    end;
    StartClearSearchTimeoutThread;
  end;
end;

procedure TElXTreeView.WMKeyDown(var Message: TWMKeyDown);
begin
  inherited;
  if FOwner.IncrementalSearch then
  begin
    Input.WMKeyDown(Message);
    DoPerformSearch(Input.Text);
  end;
end;

procedure TElXTreeView.WMIMEStartComposition(var Message: TMessage);
var
  IMC: HIMC;
  LogFont: TLogFont;
  CF: TCompositionForm;
  FCRect: TRect;
begin
  inherited;
  if FOwner.IncrementalSearch then
  begin
    IMC := ImmGetContext(Handle);
    if IMC <> 0 then
    begin
      GetObject(Canvas.Font.Handle, SizeOf(TLogFont), @LogFont);
      ImmSetCompositionFont(IMC, @LogFont);
      CF.dwStyle := CFS_RECT;
      CF.rcArea := ClientRect;
      if FOwner.ItemFocused <> nil then
      begin
        FCRect := GetItemRect(FOwner.IndexInView(FOwner.ItemFocused));
        CF.ptCurrentPos := FCRect.TopLeft;
      end
      else
        CF.ptCurrentPos := Point(0, 0);

      ImmSetCompositionWindow(IMC, @CF);
      ImmReleaseContext(Handle, IMC);
    end;
  end;
end;

procedure TElXTreeView.WMIMEComposition(var Message: TMessage);
begin
  inherited;
  if FOwner.IncrementalSearch then
  begin
    {$ifdef LMD_UNICODE}
    Input.WMImeComposition(Message);
    {$endif}
    DoPerformSearch(Input.Text);
  end;
end;

{$ifdef LMD_UNICODE}
procedure TElXTreeView.WMDeadChar(var Message: TWMDeadChar);
begin
  inherited;
  if FOwner.IncrementalSearch then
    Input.WMDeadChar(Message);
end;
{$endif}
procedure TElXTreeView.WMHScroll(var Msg: TWMHScroll);
var
  b: Boolean;
  sc: TElscrollCode;
  sp: Integer;
begin
  b := False;
  sc := escPosition;
  case Msg.ScrollCode of
    SB_TOP:       sc := escTop;
    SB_BOTTOM:    sc := escBottom;
    SB_ENDSCROLL: sc := escEndScroll;
    SB_LINEDOWN:  sc := escLineDown;
    SB_LINEUP:    sc := escLineUp;
    SB_PAGEDOWN:  sc := escPageDown;
    SB_PAGEUP:    sc := escPageUp;
    SB_THUMBPOSITION: sc := escPosition;
    SB_THUMBTRACK: sc := escTrack;
  end;
  sp := Msg.Pos;
  OnHScroll(FOwner.FHScrollBar, SC, sp, b);
end;  { WMHScroll }

procedure TElXTreeView.WMVScroll(var Msg: TWMVScroll);
var
  b: Boolean;
  sc: TElscrollCode;
  sp: Integer;
  ScrollInfo: TScrollInfo;
begin
  b := False;
  sc := escPosition;
  case Msg.ScrollCode of
    SB_TOP:       sc := escTop;
    SB_BOTTOM:    sc := escBottom;
    SB_ENDSCROLL: sc := escEndScroll;
    SB_LINEDOWN:  sc := escLineDown;
    SB_LINEUP:    sc := escLineUp;
    SB_PAGEDOWN:  sc := escPageDown;
    SB_PAGEUP:    sc := escPageUp;
    SB_THUMBPOSITION: sc := escPosition;
    SB_THUMBTRACK: sc := escTrack;
  end;
  ScrollInfo.cbSize := Sizeof(ScrollInfo);
  ScrollInfo.fMask := SIF_POS or SIF_TRACKPOS or SIF_RANGE;
  if FOwner.FUseCustomScrollBars then
    GetScrollInfo(FOwner.FVScrollBar.Handle, SB_CTL, ScrollInfo)
  else
    Windows.GetScrollInfo(Handle, SB_VERT, ScrollInfo);
  if (Msg.ScrollCode <> SB_THUMBTRACK) and (Msg.ScrollCode <> SB_THUMBPOSITION) then
    sp := ScrollInfo.nPos
  else
    sp := ScrollInfo.nTrackPos;
  OnVScroll(FOwner.FVScrollBar, SC, sp, b);
end;  { WMVScroll }

procedure TElXTreeView.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  if not FOwner.UseCustomScrollBars then
    inherited;
  Message.Result := WVR_VREDRAW;
end;

// ****************************************************************************
//                                   TElXTreeItem
// ****************************************************************************

{ TElXTreeItem }

constructor TElXTreeItem.Create(AOwner: TCustomElXTree);
begin
  inherited Create;
  FOwner := AOwner;
  FBoolData := ibfOwnerHeight or ibfEnabled;
  FComplexHeight := WORD(-1);
  //FRealHeight := -1;

  FCells := CreateCellRow(Self);
  FUseOwnStyle := false;
  NewStaticDataEx;
//  NewStaticData;
end;

destructor TElXTreeItem.Destroy;
begin
  if (FOwner <> nil) and Selected then
  begin
    with FOwner do
    begin
      if FMultiSelect then
        FSelectedList.Remove(Self);
    end;
    if FOwner.FView.FSelected = Self then
      FOwner.FView.FSelected := nil;
  end;
  FreeAndNil(FCells);
  if FChildren <> nil then
    FreeAndNil(FChildren);
  if Assigned(FVirtStyle) then
    FreeAndNil(FVirtStyle);
  DisposeStaticData;
  DisposeStaticDataEx;
  FDataInterface := nil;

  if IsHTML then
    Inc(FOwner.TotalVarHeightCount);
  IsHTML := False;

  inherited Destroy;
end;

{
function TElXTreeItem.GetFontStyles: TFontStyles;
begin
  if Assigned(FStaticDataEx) then
    Result := FStaticDataEx.FontStyles
  else
    Result := [];
end;

procedure TElXTreeItem.SetFontStyles(const Value: TFontStyles);
var
  LState: TElSTIStates;
  i: Integer;
begin
  if Style = nil then
    raise EStyleNotAssigned.Create(Format(SLMDStyleInstanceNotAssigned,[self.ClassName]));

  LState := FStaticDataEx.FState - [stsBold, stsItalic, stsStrikeOut, stsUnderlined];

  if fsBold in Value then
    Include(LState, stsBold);
  if fsItalic in Value then
    Include(LState, stsItalic);
  if fsStrikeOut in Value then
    Include(LState, stsStrikeOut);
  if fsUnderline in Value then
    Include(LState, stsUnderlined);

  if LState <> FStaticDataEx.FState then
  begin
    FStaticDataEx.FState := LState;
    if Assigned(Owner.FOnItemChange) then
      Owner.FOnItemChange(Owner, Self, icmState);
  end;
  Style.FontStyles := Value;
  for i := 0 to Cells.Count - 1 do
    Cells[i].CurrentStyle.FontStyles := Value;
end;
}

procedure TElXTreeItem.OnStyleDelete(Sender: TObject; var Item: TLMDDataTag);
var
  cs: TElXCellStyle;
begin
  cs := TElXCellStyle(Item);
  Item := nil;
  FreeAndNil(cs);
end;

type

  TItemPersistInfo = record
    FState: TElSTIStates;
    FImageIndex: Integer;
    FStImageIndex: Integer;
    FImageIndex2: Integer;
    FStImageIndex2: Integer;
    FBoolData1,
    FBoolData2: Integer;
    FColor: TColor;
    FCellBackGroundColor: TColor;
    FBackGroundColor: TColor;
    FCheckBoxState: TCheckBoxState;
    FCheckBoxType: TElCheckBoxType;
    FHeight: Cardinal;
    FBorderStyle: TElItemBorderStyle;
    FIndentAdjust: Integer;
    FStrikedLineColor: TColor;
    FTag: Integer;
    FOverlayImage: Integer;
    FOtherData: array[0..14] of Integer;
  end;

  TOldStyleInfo = record
    FCellBkColor: TColor;
    FTextBkColor: TColor;
    FTextColor: TColor;
    FTextFlags: DWORD;
    FPicture: TBitmap;
    FCellType: TElFieldType;
    FStyle: TElSectionStyle;
    FOwnerProps: Boolean;
    FUseBkColor: boolean;
    FFontSize: integer;
    FFontStyles: TFontStyles;
    FTag: integer;
  end;

  TS28aItemInfo = record
    FState       : TElSTIStates;
    FImageIndex  : integer;
    FStImageIndex: integer;
    ForceButtons : LongBool;
    FColor,
    FRowBkColor,
      FBkColor   : TColor;
    FParentColors: boolean;
    FParentStyle : boolean;
    FCheckBoxEnabled: Boolean;
    FCheckBoxState: TCheckBoxState;
    FShowCheckBox: Boolean;
    FCheckBoxType: TElCheckBoxType;
    FImageIndex2: integer;
    FStImageIndex2: integer;
    FEnabled: boolean;
    FHidden: boolean;
    FUseBkColor : boolean;

    FMultiline    : boolean;
    FOwnerHeight  : boolean;
    FHeight       : Cardinal;
    FSuppressLines: boolean;

    FIsHTML   : boolean;

  end;

  TS28ItemInfo = record
    FState: TElSTIStates;
    FImageIndex: integer;
    FStImageIndex: integer;
    ForceButtons: LongBool;
    FColor,
      FBkColor: TColor;
    FParentColors: boolean;
    FParentStyle: boolean;
    FCheckBoxEnabled: Boolean;
    FCheckBoxState: TCheckBoxState;
    FShowCheckBox: Boolean;
    FCheckBoxType: TElCheckBoxType;
    FImageIndex2: integer;
    FStImageIndex2: integer;
    FEnabled: boolean;
    FHidden: boolean;

    FMultiline    : boolean;
    FOwnerHeight  : boolean;
    FHeight       : Cardinal;
    FSuppressLines: boolean;

    FIsHTML   : boolean;
  end;

  TOldItemPersistInfo = record
    FState        : TElSTIStates;
    FImageIndex   : integer;
    FStImageIndex : integer;
    FImageIndex2  : integer;
    FStImageIndex2: integer;
    FBoolData1,
    FBoolData2    : integer;
    FColor,
    FRowBkColor,
    FBkColor      : TColor;
    FCheckBoxState: TCheckBoxState;
    FCheckBoxType : TElCheckBoxType;
    FHeight       : Cardinal;
    FBorderStyle  : TElItemBorderStyle;
    FIndentAdjust : integer;
    FStrikedLineColor: TColor;
    FTag          : Integer;
    FOverlayImage : integer;
    FOtherData    : array[0..14] of integer;
  end;

  {
      FState: TElSTIStates;
    FTag: Integer;
    FItem: TPersistent;
    FCell: TElXCustomTreeCell;
    FControl: TElXCellControl;
  }

{
procedure StateSetToStateInt(FState: TElSTIStates; var FIState: Integer);
begin
  FIState := 0;

  if stsCut in FState then
    FIState := FIState or tisCut
  else
    FIState := FIState and (not tisCut);

  if stsBold in FState then
    FIState := FIState or tisBold
  else
    FIState := FIState and (not tisBold);

  if stsItalic in FState then
    FIState := FIState or tisItalic
  else
    FIState := FIState and (not tisItalic);

  if stsUnderlined in FState then
    FIState := FIState or tisUnderlined
  else
    FIState := FIState and (not tisUnderlined);

  if stsStrikeOut in FState then
    FIState := FIState or tisStrikeOut
  else
    FIState := FIState and (not tisStrikeOut);
end;
}

procedure TElXTreeItem.ReadData(Stream: TStream);

  procedure SetBit(var BoolVar: Integer; Check: Boolean; BitSet: Integer);
  begin
    if Check then
      BoolVar := BoolVar or BitSet
    else
      BoolVar := BoolVar and not BitSet;
  end;

  procedure Read_data;
  const
    ibfSelected       = $0800000;
  var
    PInfo: TItemPersistInfo;
  begin
    Stream.ReadBuffer(PInfo, SizeOf(TItemPersistInfo));
    if FStaticDataEx <> nil then
    with FStaticDataEx do
    begin
      FState := PInfo.FState;
      FImageIndex := PInfo.FImageIndex;
      FStImageIndex := PInfo.FStImageIndex;
      FImageIndex2 := PInfo.FImageIndex2;
      FStImageIndex2:= PInfo.FStImageIndex2;
      FCheckBoxState:= PInfo.FCheckBoxState;
      FCheckBoxType := PInfo.FCheckBoxType;
      FIndentAdjust := PInfo.FIndentAdjust;
      FBoolData1 := PInfo.FBoolData1 and not (ibfMultiline or ibfHidden or ibfOwnerHeight or ibfSelected or ibfFocused or ibfEnabled or ibfIsHTML or ibfWordWrap or ibfWholeLine);
    end;

    FTag := PInfo.FTag;
    FBoolData := PInfo.FBoolData1 and (ibfMultiline or ibfHidden or ibfOwnerHeight or ibfEnabled or ibfIsHTML or ibfWordWrap or ibfWholeLine);
    if stsExpanded in PInfo.FState then
      FBoolData := FBoolData or ibfExpanded
    else
      FBoolData := FBoolData and not ibfExpanded;

    if FParent = nil then
      FBoolData := FBoolData or ibfExpanded or ibfEnabled;

    FComplexHeight:= PInfo.FHeight shl 16 or (FComplexHeight and $0000FFFF);

    if IsHTML then
    begin
      FBoolData := FBoolData and not ibfIsHTML;
      IsHTML := True;
    end;

    if FStaticDataEx <> nil then
    with FStaticDataEx do
    begin
      FOverlayIndex := PInfo.FOverlayImage and $0000FFFF;
      FOVerlayIndex2 := (PInfo.FOverlayImage and $FFFF0000) shr 16;
    end;
  end;

var
  i, j: Integer;
  s: AnsiString;
  Ver: Integer;
{$ifdef LMD_UNICODE}
  WS: WideString;
{$else}
{$endif}
  b1: Boolean;
  Child: TElXTreeItem;
begin
  if not Assigned(FStaticData) then
    NewStaticData;
  if not Assigned(FStaticDataEx) then
    NewStaticDataEx;
  Stream.ReadBuffer(Ver, SizeOf(Ver));
  if ver >= - 14 then
  begin
    ImportFromOldTree(Stream, ver);
    exit;
  end;
{$ifdef LMD_UNICODE}
  LMDWideReadStringFromStream(Stream, WS);
//  S := WS; EK
{$else}
  LMDAnsiReadStringFromStream(Stream, S);
{$endif}
  if FStaticData <> nil then
{$ifdef LMD_UNICODE}
    FStaticData.FText := WS;
{$else}
    FStaticData.FText := s;
{$endif}
  Read_data;

  if not OwnerHeight or IsHTML then
    Inc(Owner.TotalVarHeightCount);

  Stream.ReadBuffer(i, SizeOf(i));
  if i = -1 then
  begin
    {$ifdef LMD_UNICODE}
    if Ver <= -12 then
    begin
      LMDWideReadStringFromStream(Stream, WS);
      if FStaticData <> nil then
        FStaticData.FHint := WS;
    end
    else
    {$endif}
    begin
      LMDAnsiReadStringFromStream(Stream, s);
      if FStaticData <> nil then
        FStaticData.FHint := TLMDString(s);
    end;
  end;
  Stream.ReadBuffer(i, SizeOf(i));
  for j := 0 to i - 1 do
  begin
    while not Assigned(Cells[j]) do
      Cells.Add;
    Cells[j].LoadFromStream(Stream, ver);
    if (j = FOwner.MainTreeColumn) and (Length(FStaticData.FText) > 0) and (Length(Cells[j].FText) = 0) then
      cells[j].FText := FStaticData.FText;
  end;

  Stream.ReadBuffer(b1, sizeof(b1));
  SetUseOwnStyle(b1);

  if b1 then
  begin
      Style.LoadFromStream(Stream);
  end;
  FOwner.TriggerItemLoadEvent(Stream, Self);
  Stream.ReadBuffer(i, SizeOf(i));
  for j := 0 to i - 1 do
  begin
    Child := FList.AddItem(self);
    Child.ReadData(Stream);
  end;
end;

procedure TElXTreeItem.ImportFromOldTree(Stream: TStream; Ver: Integer);
var
  i, j, k: integer;
  s : AnsiString;
  t28  : TS28ItemInfo;
  t28a : TS28aItemInfo;
  PInfo: TOldItemPersistInfo;
  SI   : TOldStyleInfo;
  {$ifdef LMD_UNICODE}
  WS   : WideString;
  {$endif}
  b, b1: boolean;
  Child: TElXTreeItem;
  begin
  k := ver;
  if k < 0 then
  begin
    if ver < -13 then
    begin
    {$ifdef LMD_UNICODE}
    LMDWideReadStringFromStream(Stream, WS);
//    S := WS; EK
    {$else}
    LMDAnsiReadStringFromStream(Stream, S);
    {$endif}
    end
    else
    begin
      Stream.ReadBuffer(k, SizeOf(k));
      SetLength(s, k);
      {$IFNDEF LMDCOMP12}
      Stream.ReadBuffer(pchar(s)^, k);
      {$ELSE}
      Stream.ReadBuffer(PAnsiChar(s)^, k);
      {$ENDIF}
      {$ifdef LMD_UNICODE}
      WS := WideString(S);
      {$endif}
    end;
  end
  else
  begin
    SetLength(s, k);

    {$IFNDEF LMDCOMP12}
    Stream.ReadBuffer(pchar(s)^, k);
    {$ELSE}
    Stream.ReadBuffer(PAnsiChar(s)^, k);
    {$ENDIF}
    end;
  if FStaticData <> nil then
  {$ifdef LMD_UNICODE}
    FStaticData.FText := WS;
  {$else}
    FStaticData.FText := s;
  {$endif}
  if

    (Ver = -7) or

    (Ver = -8) or
    (Ver = -9) then
  begin
    Stream.ReadBuffer(T28, SizeOf(T28));
    Stream.ReadBuffer(b, SizeOf(b));

    if FStaticDataEx <> nil then
    with FStaticDataEx do
    begin

      FState := T28.FState;

      UseBackGroundColor := b;
      if not T28.FParentColors then
      begin
        UseOwnStyle := True;
        Style.ParentColors := T28.FParentColors;
        Style.TextColor := T28.FColor;
        Style.CellBackGroundColor := T28.FBkColor;
// ?        Style.UseBackGroundColor := b;
      end;
      if T28.ForceButtons then
        FBoolData1 := FBoolData1 or ibfForceButtons
      else
        FBoolData1 := FBoolData1 and not ibfForceButtons;
      if T28.FCheckBoxEnabled then
        FBoolData1 := FBoolData1 or ibfCheckBoxEnabled
      else
        FBoolData1 := FBoolData1 and not ibfCheckBoxEnabled;
      if T28.FShowCheckBox then
        FBoolData1 := FBoolData1 or ibfShowCheckBox
      else
        FBoolData1 := FBoolData1 and not ibfShowCheckBox;
      CheckBoxState := T28.FCheckBoxState;
      CheckBoxType := T28.FCheckBoxType;
      ImageIndex := T28.FImageIndex;
      StImageIndex := T28.FStImageIndex;
      ImageIndex2 := T28.FImageIndex2;
      StImageIndex2 := T28.FStImageIndex2;
      if T28.FSuppressLines then
        FBoolData1 := FBoolData1 or ibfSuppressLines
      else
        FBoolData1 := FBoolData1 and not ibfSuppressLines;
      IsHTML       := T28.FIsHTML;
  end;

    FBoolData := PInfo.FBoolData1 and (ibfMultiline or ibfHidden or ibfOwnerHeight or ibfIsHTML);
    if T28.FEnabled then
      FBoolData := FBoolData or ibfEnabled
    else
      FBoolData := FBoolData and not ibfEnabled;

    if stsExpanded in T28.FState then
      FBoolData := FBoolData or ibfExpanded
    else
      FBoolData := FBoolData and not ibfExpanded;

    if T28.FHidden then
      Self.FBoolData := FBoolData or ibfHidden
    else
      Self.FBoolData := FBoolData and not ibfHidden;

    if T28.FMultiline then
      Self.FBoolData := FBoolData or ibfMultiline
    else
      FBoolData := FBoolData and not ibfMultiline;
    if T28.FOwnerHeight then
      FBoolData := FBoolData or ibfOwnerHeight
    else
      FBoolData := FBoolData and not ibfOwnerHeight;

    FComplexHeight:= T28.FHeight shl 16 or (FComplexHeight and $0000FFFF);

  end
  else
  if Ver = -10 then
  begin
    Stream.ReadBuffer(T28a, SizeOf(T28a));
    Stream.ReadBuffer(b, SizeOf(b));

    if FStaticDataEx <> nil then
    with FStaticDataEx do
    begin
      UseBackGroundColor := b;

      if not T28.FParentColors then
      begin
        UseOwnStyle := True;
        Style.ParentColors := T28a.FParentColors;
        Style.TextColor := T28a.FColor;
        Style.TextBackGroundColor := T28a.FBkColor;
        Style.CellBackGroundColor := T28a.FRowBkColor;
// ?        Style.UseBackGroundColor := b;
      end;

      FState := T28a.FState;
      // StateSetToStateInt(FState, FIState);

      FImageIndex := T28a.FImageIndex;
      FStImageIndex := T28a.FStImageIndex;

      FCheckBoxState := T28a.FCheckBoxState;
      FCheckBoxType := T28a.FCheckBoxType;

      if T28a.FParentColors then
        FBoolData1 := FBoolData1 or ibfParentColors
      else
        FBoolData1 := FBoolData1 and not ibfParentColors;
      if T28a.FParentStyle then
        FBoolData1 := FBoolData1 or ibfParentStyle
      else
        FBoolData1 := FBoolData1 and not ibfParentStyle;
      if T28a.ForceButtons then
        FBoolData1 := FBoolData1 or ibfForceButtons
      else
        FBoolData1 := FBoolData1 and not ibfForceButtons;
      if T28a.FCheckBoxEnabled then
        FBoolData1 := FBoolData1 or ibfCheckBoxEnabled
      else
        FBoolData1 := FBoolData1 and not ibfCheckBoxEnabled;
      if T28a.FShowCheckBox then
        FBoolData1 := FBoolData1 or ibfShowCheckBox
      else
        FBoolData1 := FBoolData1 and not ibfShowCheckBox;
      if T28a.FSuppressLines then
        FBoolData1 := FBoolData1 or ibfSuppressLines
      else
        FBoolData1 := FBoolData1 and not ibfSuppressLines;
      IsHTML       := T28a.FIsHTML;
  end;

    FBoolData := PInfo.FBoolData1 and (ibfMultiline or ibfHidden or ibfOwnerHeight or ibfIsHTML);
    if T28a.FEnabled then
      FBoolData := FBoolData or ibfEnabled
    else
      FBoolData := FBoolData and not ibfEnabled;

    if stsExpanded in T28a.FState then
      FBoolData := FBoolData or ibfExpanded
    else
      FBoolData := FBoolData and not ibfExpanded;

    if T28a.FHidden then
      FBoolData := FBoolData or ibfHidden
    else
      FBoolData := FBoolData and not ibfHidden;
  if T28a.FMultiline then
      FBoolData := FBoolData or ibfMultiline
    else
      FBoolData := FBoolData and not ibfMultiline;

    if T28a.FOwnerHeight then
      FBoolData := FBoolData or ibfOwnerHeight
    else
      FBoolData := FBoolData and not ibfOwnerHeight;

    FComplexHeight:= T28a.FHeight shl 16 or (FComplexHeight and $0000FFFF);
  end
  else
  if Ver <= -11 then
  begin
    Stream.ReadBuffer(PInfo, SizeOf(TItemPersistInfo));
    if FStaticDataEx <> nil then
      with FStaticDataEx do
      begin

      FState := PInfo.FState;

      FImageIndex   := PInfo.FImageIndex;
      FStImageIndex := PInfo.FStImageIndex;
      FImageIndex2  := PInfo.FImageIndex2;
      FStImageIndex2:= PInfo.FStImageIndex2;
      FCheckBoxState:= PInfo.FCheckBoxState;
      FCheckBoxType := PInfo.FCheckBoxType;
      UseOwnStyle := True;
      if PInfo.FColor > 0 then
        Style.TextColor := PInfo.FColor;
      if PInfo.FRowBkColor > 0 then
        Style.CellBackGroundColor := PInfo.FRowBkColor;
      if PInfo.FBkColor > 0 then
        Style.TextBackGroundColor := PInfo.FBkColor;
      Style.BorderStyle  := PInfo.FBorderStyle;
      if PInfo.FStrikedLineColor > 0 then
        Style.StrikedLineColor := PInfo.FStrikedLineColor;
      FIndentAdjust := PInfo.FIndentAdjust;
      FBoolData1    := PInfo.FBoolData1 and not (ibfMultiline or ibfHidden or ibfOwnerHeight or ibfFocused or ibfEnabled or ibfIsHTML or ibfWordWrap or ibfWholeLine);
    end;

    FTag      := PInfo.FTag;
    FBoolData := PInfo.FBoolData1 and (ibfMultiline or ibfHidden or ibfOwnerHeight or ibfEnabled or ibfIsHTML or ibfWordWrap or ibfWholeLine);
    if stsExpanded in PInfo.FState then
      FBoolData := FBoolData or ibfExpanded
    else
      FBoolData := FBoolData and not ibfExpanded;

    if FParent = nil then
      FBoolData := FBoolData or ibfExpanded or ibfEnabled;

    FComplexHeight:= PInfo.FHeight shl 16 or (FComplexHeight and $0000FFFF);

  if IsHTML then
    begin
      FBoolData := FBoolData and not ibfIsHTML;
      IsHTML := true;
    end;
  if Ver <= -13 then
    begin
      FBoolData := FBoolData and not ibfWholeLine;
      if FStaticDataEx <> nil then
      with FStaticDataEx do
      begin
        FOverlayIndex := PInfo.FOverlayImage and $0000FFFF;
        FOVerlayIndex2 := (PInfo.FOverlayImage and $FFFF0000) shr 16;
      end;
    end;
  end;

  if (not OwnerHeight)
  or IsHTML
  then
    inc(Owner.TotalVarHeightCount);

  Stream.ReadBuffer(i, SizeOf(i));
  if i = -1 then
  begin
    {$ifdef LMD_UNICODE}
    if Ver <= -12 then
    begin
      LMDWideReadStringFromStream(Stream, WS);
      if FStaticData <> nil then
        FStaticData.FHint := WS;
    end
    else
    {$endif}
    begin
      LMDAnsiReadStringFromStream(Stream, s);
      if FStaticData <> nil then
        FStaticData.FHint := TLMDString(s);
    end;
    Stream.ReadBuffer(i, SizeOf(i));
  end;
// read cells
  if i > 0 then
    while i > Fowner.HeaderSections.Count - 1 do
    begin
      FOwner.HeaderSections.AddSection;
      Cells.Add;
    end;
  for j := 0 to i - 1 do
  begin
    {$ifdef LMD_UNICODE}
    if Ver < -13 then
    begin
      LMDWideReadStringFromStream(Stream, WS);
      if j >= FOwner.FMainTreeColumn then
        Cells[j + 1].FText := WS
      else
        Cells[j].FText := WS
    end
    else
    {$endif}
    begin
      Stream.ReadBuffer(k, SizeOf(k));
      SetLength(s, k);

      {$IFNDEF LMDCOMP12}
      Stream.ReadBuffer(pchar(s)^, k);
      {$ELSE}
      Stream.ReadBuffer(PAnsiChar(s)^, k);
      {$ENDIF}

      if j >= FOwner.FMainTreeColumn then
        Cells[j+1].FText := TLMDString(s)
      else
        Cells[j].FText := TLMDString(s);
    end;
  end;
  if (Cells.Count > FOwner.FMainTreeColumn) then
    Cells[FOwner.FMainTreeColumn].FText := FStaticData.FText;
  if Ver < 0 then
  begin
    Stream.ReadBuffer(b1, sizeof(b1));
    if b1 then
    begin
      if Ver < -1 then
        Stream.ReadBuffer(b, sizeof(boolean))
      else
        b := false;

      if b then
      begin
//        if Assigned(FOwner.FOnLoad) then FOwner.FOnLoad(Self, Stream, MainStyle);
      end
      else
      begin
        Stream.ReadBuffer(SI, sizeof(TStyleInfo));
        UseOwnStyle := True;
        with Style do
        begin
          CellBackGroundColor := SI.FCellBkColor;
          TextBackGroundColor := SI.FTextBkColor;
          TextColor := SI.FTextColor;
          TextFlags := SI.FTextFlags;
          CellType := SI.FCellType;
          DrawStyle := SI.FStyle;
          FontSize := SI.FFontSize;
          FontStyles := SI.FFontStyles;
          FTag := SI.FTag;
          UseBackGroundColor := SI.FUseBkColor;
        end;
        LMDAnsiReadStringFromStream(Stream, s);
        Style.FontName := String(s);
      end;
      Stream.ReadBuffer(i, SizeOf(i));
      for j := 1 to i do
      begin
        if Assigned(Cells[j]) then
          Cells[j].UseOwnStyle := True
        else
          Break;
        if b then
        begin
//          if Assigned(FOwner.FOnLoad) then FOwner.FOnLoad(Self, Stream, Style);
        end else
        begin
          Stream.ReadBuffer(SI, sizeof(TStyleInfo));
          with Cells[j].Style do
          begin
            CellBackGroundColor := SI.FCellBkColor;
            TextBackGroundColor := SI.FTextBkColor;
            TextColor := SI.FTextColor;
            TextFlags := SI.FTextFlags;
//            FPicture := SI.FPicture;
            CellType := SI.FCellType;
            DrawStyle := SI.FStyle;
//            FOwnerProps := SI.FOwnerProps;
            FontSize := SI.FFontSize;
            FontStyles := SI.FFontStyles;
            Tag := SI.FTag;
            UseBackGroundColor := SI.FUseBkColor;
          end;
          LMDAnsiReadStringFromStream(Stream, s);
          Cells[j].Style.FontName := String(s);
        end;
      end; // for
    end;
  end;
//  FOwner.TriggerItemLoadEvent(Stream, Self);

  Stream.ReadBuffer(i, SizeOf(i));
  for j := 0 to i - 1 do
  begin
    Child := FList.AddItem(self);
    Child.ReadData(Stream);
  end;
end;

procedure TElXTreeItem.WriteData(Stream: TStream);
var
  i, j, Ver: Integer;
  s: TLMDString;
  PInfo: TItemPersistInfo;
  // p: pchar;
//  SI: TStyleInfo;
  LStyle: TElXCellStyleRead;
  b: Boolean;
begin
  // write version
  Ver := -17;
  Stream.WriteBuffer(Ver, SizeOf(Ver));
  // write text data
  if Assigned(FStaticData) then
    s := FStaticData.FText
  else
    s := '';
{$ifdef LMD_UNICODE}
  LMDWideWriteStringToStream(Stream, S);
{$else}
  LMDAnsiWriteStringtoStream(Stream, S);
{$endif}
  // write binary data
  FillMemory(@PInfo, sizeof(PInfo), 0);
  PInfo.FBoolData1 := FBoolData;
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    PInfo.FState := FState;
    if FBoolData and ibfExpanded = ibfExpanded then
      PInfo.FState := PInfo.FState + [stsExpanded]
    else
      PInfo.FState := PInfo.FState - [stsExpanded];
    PInfo.FBoolData1 := PInfo.FBoolData1 or FBoolData1;
    PInfo.FImageIndex := FImageIndex;
    PInfo.FImageIndex2 := FImageIndex2;
    PInfo.FStImageIndex := FStImageIndex;
    PInfo.FStImageIndex2 := FStImageIndex2;
//    PInfo.FColor := FTextColor;
//    PInfo.FBackGroundColor := FBackGroundColor;
//    PInfo.FCellBackGroundColor := FCellBackGroundColor;

    PInfo.FCheckBoxState := FCheckBoxState;
    PInfo.FCheckBoxType := FCheckBoxType;
//    PInfo.FBorderStyle := FBorderStyle;
    PInfo.FIndentAdjust := FIndentAdjust;
//    PInfo.FStrikedLineColor := FStrikedLineColor;
    PInfo.FOverlayImage := FOverlayIndex or (FOverlayIndex2 shl 16);
  end;
  PInfo.FTag := FTag;

  PInfo.FHeight := FComplexHeight shr 16;

  Stream.WriteBuffer(PInfo, SizeOf(PInfo));
  // write SubStrings
  i := -1;
  Stream.WriteBuffer(i, SizeOf(i));

  if FStaticData <> nil then
    s := FStaticData.FHint
  else
    S := '';
{$ifdef LMD_UNICODE}
  LMDWideWriteStringtoStream(Stream, S);
{$else}
  LMDAnsiWriteStringToStream(Stream, S);
{$endif}

  if Assigned(FCells) then
    i := FCells.Count
  else
    i := 0;
  Stream.WriteBuffer(i, SizeOf(i));
  for j := 0 to i - 1 do
  begin
    Cells[j].WriteToStream(Stream);
  end;

  if  FStaticDataEx <> nil then
    b := FUseOwnStyle
  else
    b := False;
  Stream.WriteBuffer(b, sizeof(b));
  if b then
  begin
    if FStaticData <> nil then
    begin
      LStyle := Style;
      LStyle.WriteToStream(Stream);
    end;
  end;
  FOwner.TriggerItemSaveEvent(Stream, Self);
  // write subitems
  if FChildren = nil then
    i := 0
  else
    i := FChildren.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  for j := 0 to i - 1 do
    TElXTreeItem(FChildren.List[j]).WriteData(Stream);
end;

procedure TElXTreeItem.Assign(Source: TPersistent);
var
  AItem, AChild: TElXTreeItem;
  i, j: Integer;
//  Style: TElXCellStyleRead;
begin
  if Source is TElXTreeItem then
  begin
    if FOwner <> nil then
      FOwner.IsUpdating := True;
    AItem := TElXTreeItem(Source);
    if (FStaticData <> nil) then
    begin
      FStaticData.FText := AItem.Text;
      FStaticData.FHint := AItem.Hint;
    end;
    Data := AItem.Data;
    if (FStaticDataEx <> nil) and (AItem.FStaticDataEx <> nil) then
    with FStaticDataEx do
    begin
      FBoolData1 := AItem.FStaticDataEx.FBoolData1;
//      FTextColor := AItem.FStaticDataEx.FTextColor;
//      FBackGroundColor := AItem.FStaticDataEx.FBackGroundColor;
//      FCellBackGroundColor := AItem.FStaticDataEx.FCellBackGroundColor;
      FImageIndex := AItem.FStaticDataEx.FImageIndex;
      FStImageIndex := AItem.FStaticDataEx.FStImageIndex;
      FImageIndex2 := AItem.FStaticDataEx.FImageIndex2;
      FStImageIndex2 := AItem.FStaticDataEx.FStImageIndex2;
      FCheckBoxState := AItem.FStaticDataEx.FCheckBoxState;
      FCheckBoxType := AItem.FStaticDataEx.FCheckBoxType;
//      FBorderStyle := AItem.FStaticDataEx.FBorderStyle;
      FIndentAdjust := AItem.FStaticDataEx.FIndentAdjust;
//      FStrikedLineColor := AItem.FStaticDataEx.FStrikedLineColor;
      FOverlayIndex := AItem.FStaticDataEx.FOverlayIndex;
      FOverlayIndex2 := AItem.FStaticDataEx.FOverlayIndex2;
      FState := AItem.FStaticDataEx.FState;
    end;
    FBoolData := AItem.FBoolData and not (ibfFocused {or ibfSelected} or ibfIsHTML or ibfImageDrawn or ibfImageDrawn2);

    if ((FBoolData and ibfOwnerHeight) <> ibfOwnerHeight) then
      Inc(FOwner.TotalVarHeightCount);

    IsHTML := AItem.IsHTML;
    FComplexHeight := AItem.FComplexHeight;
    FObject := AItem.FObject;
    FDataInterface := AItem.FDataInterface;
    FTag := AItem.FTag;
    SetUseOwnStyle(AItem.FUseOwnStyle);
    if FUseOwnStyle then
      FStaticData.FCellStyle.Assign(AItem.FStaticData.FCellStyle);
//      Style := Cells[i].CurrentStyle;
//      Style.Assign(AItem.Cells[i].CurrentStyle);
    for i := 0 to AItem.Cells.Count - 1 do
    begin
      if not Assigned(FCells[i]) then
        Cells.Add;
      FCells[i].Assign(TElXTreeItem(Source).FCells[i]);
    end;
    Clear;
    if AItem.FChildren <> nil then
    begin
      if FChildren = nil then
        FChildren := TLMDObjectList.Create;
      j := 0;
      for i := 0 to AItem.FChildren.Count - 1 do
      begin
        AChild := FList.CreateItem(FOwner);
        if FOwner.VirtualityLevel = vlNone then
          AChild.NewStaticData;
        if (FOwner.VirtualityLevel < vlAllProps) or (csDesigning in FOwner.ComponentState) then
          AChild.NewStaticDataEx;

        if FOwner.FAllList.Count > 0 then
           j := FOwner.FAllList.IndexOfFrom(j, GetLastSubItem) + 1
        else
           j := 0;
        FChildren.Add(AChild);
        FOwner.FAllList.Insert(j, AChild);
        AChild.FRoot := FRoot;
        AChild.FList := FList;
        AChild.FParent := self;
        AChild.FOwner := FOwner;
        AChild.Assign(TElXTreeItem(AItem.FChildren.List[i]));
      end;
    end
    else
      FreeAndNil(FChildren);

    if (FOwner <> nil) then
    with FOwner.FView do
    begin
      FOwner.FUpdated := True;
      FVisUpdated := True;
      FClearVis := True;
      FClearAll := True;
      FOwner.IsUpdating := False;
    end;
  end
  else
    inherited Assign(Source);
end;

{
procedure TElXTreeItem.SetUseBackGroundColor(newValue: Boolean);
var
  i: Integer;
begin
  if Assigned(FStaticDataEx) then with FStaticDataEx do
  begin
    if ((FBoolData1 and ibfUseBackGroundColor) <> 0) <> newValue then
    begin
      if newValue then
        FBoolData1 := FBoolData1 or ibfUseBackGroundColor
      else
        FBoolData1 := FBoolData1 and not ibfUseBackGroundColor;
    end;
  end;
  for i := 0 to Cells.Count - 1 do
    if Cells[i].UseOwnStyle then
      Cells[i].Style.UseBackGroundColor := newValue;
  UpdateItem;
end;
}

{
procedure TElXTreeItem.SetColor(Index: TElXTreeCellColorType; value: TColor);
var
  i: Integer;
  LStaticDataEx: TElXTreeItemStaticDataEx;
begin
  if not Assigned(FStaticDataEx) then
    Exit;
  LStaticDataEx := FStaticDataEx;
  case TElXTreeCellColorType(Index) of
    cctTextColor:
      begin
        LStaticDataEx.FTextColor := value;
        for i := 0 to Cells.Count - 1 do
          if Cells[i].UseOwnStyle then
            Cells[i].Style.TextColor := value;
        if LStaticDataEx.FTextColor = value then
          Exit;
        if not ParentColors then
          UpdateItem;
      end;
    cctTextBackGroundColor:
      begin
        LStaticDataEx.FBackGroundColor := value;
        for i := 0 to Cells.Count - 1 do
          if Cells[i].UseOWnStyle then
            Cells[i].Style.TextBackGroundColor := value;
//        if LStaticDataEx.FBackGroundColor = value then
//          Exit;
        if not ParentColors and UseBackGroundColor then
          UpdateItem;
      end;
    cctCellBackGroundColor:
      begin
        LStaticDataEx.FCellBackGroundColor := value;
        for i := 0 to Cells.Count - 1 do
          if Cells[i].UseOwnStyle then
            Cells[i].Style.CellBackGroundColor := value;
//        if LStaticDataEx.FBackGroundColor = value then
//          Exit;
        if not ParentColors and UseBackGroundColor then
          UpdateItem;
     end;

    cctRowBackGroundColor:
      begin
        LStaticDataEx.FRowBackGroundColor := value;
        for i := 0 to Cells.Count - 1 do
          Cells[i].RowBackGroundColor := value;
        if LStaticDataEx.FRowBackGroundColor = value then
          Exit;
        if not ParentColors and UseBackGroundColor then
          UpdateItem;
      end;

    cctBorderSpaceColor:
      begin
        LStaticDataEx.FBorderSpaceColor := Value;
        for i := 0 to Cells.Count - 1 do
          if Cells[i].UseOwnStyle then
            Cells[i].Style.BorderSpaceColor := value;
        if BorderStyle = ibsSpace then
          UpdateItem;
      end;
    cctStrikedLineColor:
      begin
        LStaticDataEx.FStrikedLineColor := Value;
        for i := 0 to Cells.Count - 1 do
          if Cells[i].UseOwnStyle then
            Cells[i].Style.StrikedLineColor := value;
        if StrikedOutline then
          UpdateItem;
      end;
  end;
end;
}

function TElXTreeItem.GetParent: TElXTreeItem;
begin
  if FParent = FRoot then
    Result := nil
  else
    Result := FParent;
end;

procedure TElXTreeItem.EditText;
begin
  FOwner.FView.DoEditItem(self, -1);
end;

function TElXTreeItem.GetFullNameEx(separator: TLMDString;
  AddRoot: Boolean): TLMDString;
begin
  if (FParent <> FRoot) or (AddRoot) then
    if Separator <> #0 then
      Result := separator + Text
    else
      Result := Text
  else
    Result := Text;
  if FParent <> FRoot then
    Result := FParent.GetFullNameEx(separator, AddRoot) + Result;
end;

function TElXTreeItem.GetFullName(separator: TLMDString): TLMDString;
begin
  if Separator <> #0 then
    Result := separator + Text
  else
    Result := Text;
  if FParent <> FRoot then
    Result := FParent.GetFullName(separator) + Result;
end;

function TElXTreeItem.GetChildByIndex(index: Integer): TElXTreeItem;
begin
  if (index < 0) or (FChildren = nil) or (index >= FChildren.Count) then
    raise EElTreeError.Create(STExOutOfBounds);
  Result := TElXTreeItem(FChildren.List[index]);
end;

function TElXTreeItem.GetChildrenCount: Integer;
var
  i, j: Integer;
begin
  if FChildren = nil then
     Result := 0
  else
     Result := FChildren.Count;
  j := Result;
  for i := 0 to j - 1 do
    Result := Result + TElXTreeItem(FChildren.List[i]).ChildrenCount;
end;

function TElXTreeItem.GetNextChild(Child: TElXTreeItem): TElXTreeItem;
var
  i: Integer;
begin
  if FChildren = nil then
     Result := nil
  else
  begin
    i := Child.Index;
    if (i = (FChildren.Count - 1)) then
       Result := nil
    else
       Result := TElXTreeItem(FChildren.List[i + 1]);
  end;
end;

function TElXTreeItem.GetPrevChild(Child: TElXTreeItem): TElXTreeItem;
var
  i: Integer;
begin
  if FChildren = nil then
     Result := nil
  else
  begin
    i := Child.Index;
    if i = 0 then
       Result := nil
    else
      Result := TElXTreeItem(FChildren.List[i - 1]);
  end;
end;

function TElXTreeItem.GetFirstVisibleChild: TElXTreeItem;
var
  i: Integer;
  ChC: Integer;
  Item: TElXTreeItem;
begin
  Result := nil;
  if (not FOwner.FilteredVisibility) then
  begin
    Result := GetFirstChild;
    Exit;
  end;
  if (FChildren <> nil) then
  begin
    Chc := FChildren.Count;
    if (Chc > 0) then
    for i := 0 to ChC - 1 do
    begin
      Item := TElXTreeItem(FChildren.List[i]);
      if not Item.Hidden then
      begin
        Result := Item;
        Exit;
      end;
    end;
  end;
end;

function TElXTreeItem.GetFirstChild: TElXTreeItem;
begin
  if (FChildren = nil) or (FChildren.Count = 0) then
     Result := nil
  else
     Result := TElXTreeItem(FChildren.List[0]);
end;

function TElXTreeItem.GetLastChild: TElXTreeItem;
begin
  if (FChildren = nil) or (FChildren.Count = 0) then
     Result := nil
  else
     Result := TElXTreeItem(FChildren.Last);
end;

function TElXTreeItem.GetFirstSibling: TElXTreeItem;
begin
  if FParent = nil then
     Result := nil
  else
     Result := FParent.GetFirstChild;
end;

function TElXTreeItem.GetLastSibling: TElXTreeItem;
begin
  if FParent = nil then
     Result := nil
  else
     Result := FParent.GetLastChild;
end;

function TElXTreeItem.GetNextSibling: TElXTreeItem;
begin
  if FParent = nil then
     Result := nil
  else
     Result := FParent.GetNextChild(self);
end;

function TElXTreeItem.GetPrevSibling: TElXTreeItem;
begin
  if FParent = nil then
     Result := nil
  else
    Result := FParent.GetPrevChild(self);
end;

function TElXTreeItem.GetFullExpand: Boolean;
begin
  if Parent = nil then
     result := Expanded or not HasChildren
  else
     result := Parent.FullyExpanded and (Expanded or not HasChildren);
end;

function TElXTreeItem.GetSelected: Boolean;
var
  i: Integer;
begin
// Item selected if selecteg at least one of its cell
  Result := False;
  for i := 0 to FCells.Count - 1 do
    if {(FCells[i].JointCellRole <> jcrSlave) and} (FCells[i].Selected) then
    begin
      Result := True;
      Exit;
    end;
end;

procedure TElXTreeItem.DoSetSelected(newValue: Boolean);
var
  i: Integer;
  begin
  if Owner.RowSelect or (not newValue) then
  begin
    for i := 0 to FCells.Count - 1 do
    begin
      FCells[i].FSelected := newValue;
      if Assigned(FCells[i].FVirtStyle) then
      begin
        FreeAndNil(FCells[i].FVirtStyle);
        end;
    end;
    if newValue then
      FCells.FCol := Owner.FView.FHitColumn
    else
      FCells.FCol := -1;
  end
  else
    if LMDInRange(Owner.FView.FHitColumn, 0, Fcells.Count - 1) then
    begin
      FCells[Owner.FView.FHitColumn].FSelected := newValue;
      FCells.FCol := Owner.FView.FHitColumn;
      if Assigned(FCells[Owner.FView.FHitColumn].FVirtStyle) then
      begin
        FreeAndNil(FCells[Owner.FView.FHitColumn].FVirtStyle);
        end;
    end;
  if not Owner.IsUpdating then
    Owner.Invalidate;
end;

procedure TElXTreeItem.SetSelected(newValue: Boolean);
begin
  if FOwner.FMultiSelect then
  begin
    if (Selected <> newValue) then
    begin
      if newValue = False then
      begin
        FOwner.FSelChange := True;
        //Exclude(FState, stsSelected);
        DoSetSelected(newValue);
        FOwner.FSelectedList.Remove(Self);
        with FOwner.FView do
        if FSelected = Self then
          FSelected := nil;
      end
      else
      begin
        if FOwner.FKeepSelectionWithinLevel and (FOwner.FSelectedList.Count > 0) and
           (FOwner.FSelectedList[0] <> Self) then
        begin
          if Level <> TElXTreeItem(FOwner.FSelectedList[0]).Level then
            Exit;
        end;
        FOwner.FSelChange := True;
        // Include(FState, stsSelected);
        DoSetSelected(newValue);
        FOwner.FSelectedList.AddAndCheckDuplicates(Self);
        if not Assigned(FOwner.Selected) then
          FOwner.FView.FSelected := Self;
      end;
      FOwner.TriggerItemSelectedChangeEvent(Self);
      UpdateItem;
    end;
  end
  else
    if Focused <> newValue then
      Focused := newValue;
end;

//procedure TElXTreeItem.SetState(index: TSTIState; value: Boolean);
//var
//  FOldState: TElSTIStates;
//  reqitemch: Boolean;
//  i: Integer;
//begin
//  reqitemch := True;
//  if FStaticDataEx <> nil then
//  with FStaticDataEx do
//  begin
//    FOldState := FState;
//    case TSTIState(Index) of
//      stsCut:
//        begin
//          if value = False then
//            Exclude(FState, stsCut)
//          else
//            Include(FState, stsCut);
//        end;
//      stsUnderlined:
//        begin
//          if value = False then
//            Exclude(FState, stsUnderlined)
//          else
//            Include(FState, stsUnderlined);
//          for i := 0 to Cells.Count - 1 do
//            if Cells[i].UseOwnStyle then
//              Cells[i].Style.Underlined := Value;
//        end;
//      stsBold:
//        begin
//          if value = False then
//            Exclude(FState, stsBold)
//          else
//            Include(FState, stsBold);
//          for i := 0 to Cells.Count - 1 do
//            if Cells[i].UseOwnStyle then
//              Cells[i].Style.Bold := Value;
//        end;
//      stsItalic:
//        begin
//          if value = False then
//            Exclude(FState, stsItalic)
//          else
//            Include(FState, stsItalic);
//          for i := 0 to Cells.Count - 1 do
//            if Cells[i].UseOwnStyle then
//              Cells[i].Style.Italic := Value;
//        end;
//      stsStrikeOut:
//        begin
//          if value = False then
//            Exclude(FState, stsStrikeOut)
//          else
//            Include(FState, stsStrikeOut);
//          for i := 0 to Cells.Count - 1 do
//            if Cells[i].UseOwnStyle then
//              Cells[i].Style.StrikeOut := Value;
//        end;
//    end; // case
//    if FOldState <> FState then
//    begin
//      if (TSTIState(Index) in [stsBold, stsItalic]) and (not FOwner.ShowColumns) and FullyExpanded then
//      begin
//        if FOwner.FUpdateCount > 0 then
//          FOwner.FView.FHRange := -1
//        else
//          FOwner.FView.DefineHRange;
//      end;
//      if reqitemch then
//        FOwner.DoItemChange(self, icmState);
//      UpdateItem;
//    end;
//  end;
//end;
//
//function TElXTreeItem.GetState(Index: TSTIState): Boolean;
//begin
//  if FStaticDataEx <> nil then
//    Result := TSTIState(Index) in FStaticDataEx.FState
//  else
//    Result := False;
//end;

function TElXTreeItem.IsExpanded: Boolean;
begin
  Result := (FBoolData and ibfExpanded) <> 0;
end;

procedure TElXTreeItem.Expand(recursive: Boolean);
var
  i,
  j: Integer;
  b: Boolean;
begin
  b := True;
  if Self <> FRoot then
    FOwner.DoItemExpanding(self, b);
  if not (b) then
    Exit;
  FOwner.IsUpdating := True;
  with FOwner.FView do
  begin
    FVisUpdated := True;
    FRangeUpdate := True;
  end;
  FBoolData := FBoolData or ibfExpanded;
  if recursive then
  begin
    if (FChildren = nil) then
       j := 0
    else
       j := FChildren.Count;
    for i := 0 to j - 1 do
        TElXTreeItem(FChildren.List[i]).expand(True);
  end;
  if (not FOwner.ShowColumns) and FullyExpanded then
    FOwner.FView.FHRange := -1;
  with FOwner.FView do
  begin
    FClearVis := True;
    FOwner.FUpdated := True;
  end;
  FOwner.IsUpdating := False;
  //Adjusting the width of the tree column to the width of the tree
  if FOwner.FHeader.Sections[FOwner.FMainTreeColumn] <> nil then
    Fowner.AutoSizeColumn(FOwner.FMainTreeColumn);

  if Self <> FRoot then
    FOwner.DoItemExpand(self);
end;

procedure TElXTreeItem.IterateProc(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean;
  IterateData: TLMDDataTag; Tree: TCustomElXTree);
begin
  if not Item.IsUnder(TElXTreeItem(IterateData)) then
  begin
    ContinueIterate := False;
    Exit;
  end;
  ContinueIterate := True;
  if Item <> IterateData then
    Item.Selected := False;
end;

procedure TElXTreeItem.Collapse(recursive: Boolean);
var
  i: Integer;
  b: Boolean;
  AnItem: TElXTreeItem;
begin
  FOwner.FCollapsing := True;
  b := True;
  if Self <> FRoot then
    FOwner.DoItemCollapsing(self, b);
  if not (b) then
    Exit;
  FOwner.IsUpdating := True;
  with FOwner.FView do
  begin
    FRangeUpdate := True;
    FVisUpdated := True;
  end;
  FBoolData := FBoolData and not ibfExpanded;
  with FOwner do
    if (ItemFocused <> nil) and (ItemFocused <> Self) and (ItemFocused.IsUnder(Self)) and (FMoveFocusOnCollapse) then
    begin
      if SelectedCount = 1 then
      begin
        AnItem := ItemFocused;
        b := FAutoExpand;
        FAutoExpand := False;
        ItemFocused := Self;
        FAutoExpand := b;
        AnItem.Selected := False;
      end
      else
        ItemFocused := Self;
    end;
  if Recursive then
  begin
    if Assigned(FChildren) then
      for i := 0 to Pred(FChildren.Count) do
        TElXTreeItem(FChildren.List[i]).Collapse(True);
  end;

  if FOwner.FDeselectChildrenOnCollapse then
    FOwner.Items.IterateFrom(False, True, IterateProc, Self, Self); {<+>}

  if (not FOwner.ShowColumns) and FullyExpanded then
     FOwner.FView.FHRange := -1;
  with FOwner.FView do
  begin
    FClearVis := True;
    FClearAll := True;
  end;
  FOwner.FUpdated := True;
  FOwner.IsUpdating := False;
  //Adjusting the width of the tree column to the width of the tree
  if FOwner.FHeader.Sections[FOwner.FMainTreeColumn] <> nil then
    Fowner.AutoSizeColumn(FOwner.FMainTreeColumn);

  if Self <> FRoot then
    FOwner.DoItemCollapse(self);
end;

function TElXTreeItem.GetChildIndex(Child: TElXTreeItem): Integer;
begin
  if FChildren = nil then
     Result := -1
  else
     Result := FChildren.IndexOf(Child);
end;

function TElXTreeItem.GetIndex: Integer;
begin
  if FParent = nil then
     Result := -1
  else
     Result := FParent.GetChildIndex(self);
end;

function TElXTreeItem.GetVisIndex: Integer;
begin
  // no check for root - should never be called for root
  Result := FList.GetVisIndex(self);
end;

function TElXTreeItem.GetAbsIndex: Integer;
begin
  // no check for root - should never be called for root
  Result := FList.GetAbsIndex(self);
end;

procedure TElXTreeItem.RemoveChild(Child: TElXTreeItem);
var
  i: Integer;
begin
  with FOwner.FView do
  begin
    i := ColorHelper.Visible.IndexOf(Child);
    if i >= 0 then
       ColorHelper.Visible.Delete(i);
  end;

  {with FOwner.FView do
    if FSelected = Child then
      FSelected := nil;
  }

  if FChildren <> nil then
  begin
    i := FChildren.IndexOf(Child);
    if i <> -1 then
       FChildren.Delete(i);
    if FChildren.Count = 0 then
      FreeAndNil(FChildren);
    //Dec(FList.FCount);
  end;
end;

procedure TElXTreeItem.RemoveSubChild(Child: TElXTreeItem);
var
  i: Integer;
  DataEx: TElXTreeItemStaticDataEx;
begin
//  Child.FBoolData1 := Child.FBoolData1 or ibfDeleting;
  FOwner.IsUpdating := True;
  Child.ClearSubChild;
  if Child.Hidden then
  begin
    Dec(FOwner.TotalHiddenCount);
    Child.FBoolData := Child.FBoolData and not ibfHidden;
  end;
  if Child = FOwner.FView.FSelected then
  begin
    if csDestroying in FOwner.ComponentState then
      FOwner.SetSelected(nil)
    else
    begin
      FOwner.SetSelected(GetNextChild(Child));
      if FOwner.FView.FSelected = nil then
        FOwner.SetSelected(GetPrevChild(Child));
      if FOwner.FView.FSelected = nil then
        if Self <> FRoot then
          FOwner.SetSelected(Self);
    end;
  end;
  Child.Selected := False;
  // Move focus, if needed
  if Child = FOwner.FView.FFocused then
  begin
    if csDestroying in FOwner.ComponentState then
      FOwner.DoSetFocused(nil, True)
    else
    begin
      FOwner.DoSetFocused(GetNextChild(Child), True);
      if FOwner.ItemFocused = nil then
        FOwner.DoSetFocused(GetPrevChild(Child), True);
      if FOwner.ItemFocused = nil then
        if Self <> FRoot then
          FOwner.DoSetFocused(Self, True);
    end;
  end;
  with FOwner do
    if (FUpdateCount = 0) and (FilteredVisibility) then
       UpdateDiffItems;
  with FOwner.FView do
  begin

    if FItemToEdit = Child then
       FItemToEdit := nil;

    if FPassedItem = Child then
       FPassedItem := nil;
    if FTrackItem = Child then
       FTrackItem := nil;

    if FOwner.IsEditing then
    begin
      FEditingItem := nil;
      DoEndEdit(True);
    end;

  end;
  if (FOwner.FView.ColorHelper.Visible.Count > 0) and not (csDestroying in FOwner.ComponentState) then
  with FOwner.FView do
  begin
    i := ColorHelper.Visible.IndexOfBack(ColorHelper.Visible.Count - 1, Child);
    if (i >= 0) then
       ColorHelper.Visible.Delete(i);
  end;
  FOwner.DoItemDelete(Child);

  if (not Child.OwnerHeight) or (Child.Multiline and FOwner.FAdjustMultilineHeight) then
    Dec(FOwner.TotalVarHeightCount);

  if (Child.FBoolData and ibfIsHTML) = ibfIsHTML then
     Dec(FOwner.TotalVarHeightCount);

  Child.ClearSubChild;
  i := FOwner.FAllList.IndexOfBack(FOwner.FAllList.Count - 1, Child);
  if (i >= 0) then
    FOwner.FAllList.Delete(i);

  if (FOwner.VirtualityLevel >= vlAllProps) and not (csDesigning in FOwner.ComponentState) then
  begin
    if Child.FStaticDataEx <> nil then
    begin
      // move static data item in caches
      Child.FStaticDataEx.ItemRef := nil;

      DataEx := TElXTreeItemStaticDataEx.Create;
      DataEx.Assign(Child.FStaticDataEx);

      if FOwner.FDataCache.Count <= FOwner.FDataCacheSize then
        FOwner.FDataCache.Move(FOwner.FDataCache.IndexOf(Child.FStaticDataEx), 0)
      else
      begin
        FOwner.FDataCache.Remove(Child.FStaticDataEx);
        Child.FStaticDataEx.Free;
      end;
      Child.FStaticDataEx := DataEx;
    end
    else
    begin
      Child.FStaticDataEx := TElXTreeItemStaticDataEx.Create;
      FOwner.TriggerVirtualPropsNeeded(Child, AllVirtPropTypes, Child.FStaticDataEx);
    end;
  end;
  with FOwner do
  begin
    FUpdated := True;
    FView.FRangeUpdate := True;
    IsUpdating := False;
  end;
end;

procedure TElXTreeItem.DeleteChild(Child: TElXTreeItem);
var
  i: Integer;
  LCache: TElXDataCache;
  LCacheIndex: Integer;
  LView: TElXTreeView;
begin
  Child.FBoolData := Child.FBoolData or ibfDeleting;
  FOwner.IsUpdating := True;
  LView := FOwner.FView;
  try
    Child.Clear;
    if Child.Hidden then
    begin
      Dec(FOwner.TotalHiddenCount);
      Child.FBoolData := Child.FBoolData and not ibfHidden;
    end;
    if Child = LView.FSelected then
    begin
      if csDestroying in FOwner.ComponentState then
        FOwner.SetSelected(nil)
      else
      begin
        FOwner.SetSelected(GetNextChild(Child));
        if LView.FSelected = nil then
          FOwner.SetSelected(GetPrevChild(Child));
        if LView.FSelected = nil then
          if Self <> FRoot then
            FOwner.SetSelected(Self);
      end;
    end;
    Child.Selected := False;
    // Move focus, if needed
    if Child = LView.FFocused then
    begin
      if csDestroying in FOwner.ComponentState then
        FOwner.DoSetFocused(nil, True)
      else
      begin
        FOwner.DoSetFocused(GetNextChild(Child), True);
        if FOwner.ItemFocused = nil then
          FOwner.DoSetFocused(GetPrevChild(Child), True);
        if FOwner.ItemFocused = nil then
          if Self <> FRoot then
            FOwner.DoSetFocused(Self, True);
      end;
    end;
    with FOwner do
      if (FUpdateCount = 0) and (FilteredVisibility) then
         UpdateDiffItems;
    if LView.FItemToEdit = Child then
      LView.FItemToEdit := nil;
    if LView.FPassedItem = Child then
       LView.FPassedItem := nil;
    if LView.FTrackItem = Child then
       LView.FTrackItem := nil;
    if FOwner.IsEditing then
    begin
      LView.FEditingItem := nil;
      LView.DoEndEdit(True);
    end;
    if (LView.ColorHelper.Visible.Count > 0) and not (csDestroying in FOwner.ComponentState) then
    with LView do
    begin
      i := ColorHelper.Visible.IndexOfBack(ColorHelper.Visible.Count - 1, Child);
      if (i >= 0) then
         ColorHelper.Visible.Delete(i);
    end;
    FOwner.DoItemDelete(Child);
    if FChildren.Count > 0 then
    begin
      i := FChildren.IndexOfBack(FChildren.Count - 1, Child);
      if i <> -1 then
         FChildren.Delete(i);
      if FChildren.Count = 0 then
        FreeAndNil(FChildren);
    end;
  if (not Child.OwnerHeight) or (Child.Multiline and FOwner.FAdjustMultilineHeight) then
       Dec(FOwner.TotalVarHeightCount);
  if (Child.FBoolData and ibfIsHTML) = ibfIsHTML then
       Dec(FOwner.TotalVarHeightCount);
  //Child.Clear;
    i := FOwner.FAllList.IndexOfBack(FOwner.FAllList.Count - 1, Child);
    if (i >= 0) then
      FOwner.FAllList.Delete(i);

    if Assigned(Child.FStaticDataEx) then
    begin
      // move static data item in caches
      Child.FStaticDataEx.ItemRef := nil;
      LCache := FOwner.FDataCache;
      if Assigned(LCache) then
      begin
        if LCache.Count <= FOwner.FDataCacheSize then
        begin
          LCacheIndex := LCache.IndexOf(Child.FStaticDataEx);
          if LCacheIndex > 0 then
            LCache.Move(LCacheIndex, 0)
        end
        else
          FOwner.FDataCache.Remove(Child.FStaticDataEx);
      end;
      Child.DisposeStaticDataEx;
    end;

    if Assigned(Child.FStaticData) then
      Child.DisposeStaticData;
    FreeAndNil(Child);
//  except
  finally
    FOwner.FUpdated := True;
    LView.FRangeUpdate := True;
    FOwner.IsUpdating := False;
  end;
end;

function TElXTreeItem.GetLastSubItem: TElXTreeItem;
var Item: TElXTreeItem;
begin
  Result := Self;
  Item := Result.GetLastChild;
  While Item <> nil do
  begin
    Result := Item;
    Item := Result.GetLastChild;
  end;
end;

function TElXTreeItem.AddChild(Child: TElXTreeItem): Integer;
var i: Integer;
begin
  if FChildren = nil then
     FChildren := TLMDObjectList.Create;
  with FOwner do
  begin
    if (FAllList.Count = 0) or (GetLastSubItem = FAllList.Last) then
        FAllList.Add(Child)
    else
    begin
      i := FAllList.IndexOf(GetLastSubItem);
      FAllList.Insert(i + 1, Child);
    end;
  end;
  Result := FChildren.Add(Child);
  Child.FRoot := FRoot;

  Child.FParent := Self;
  Child.FList := Self.FList;

  if FOwner.VirtualityLevel = vlNone then
    Child.NewStaticData;
  if (FOwner.VirtualityLevel < vlAllProps) or (csDesigning in FOwner.ComponentState) then
    Child.NewStaticDataEx;

  FOwner.FUpdated := True;

  if FOwner.VirtualityLevel > vlNone then
    NewVirtualSort;
end;

procedure TElXTreeItem.AddExistingChild(Child: TElXTreeItem);
var
  i: Integer;
  DataEx: TElXTreeItemStaticDataEx;
begin
  with FOwner do
  begin
    i := FAllList.IndexOf(self);
    FAllList.Insert(i + 1, Child);
  end;
  Child.FRoot := FRoot;
  Child.FOwner := FOwner;
  Child.FList := FList;
  if Child.FChildren <> nil then
    for i := Child.FChildren.Count - 1 downto 0 do
      Child.AddExistingChild(TElXTreeItem(Child.FChildren.Items[i]));
  if (FOwner.VirtualityLevel >= vlAllProps) and not (csDesigning in FOwner.ComponentState) then
  begin
    with FOwner do
    begin
      if FDataCache.Count > FOwner.FView.ColorHelper.Visible.Count then
      begin
        DataEx := TElXTreeItemStaticDataEx(FDataCache[0]);
        DataEx.ItemRef.FStaticDataEx := nil;
        DataEx.ItemRef := Child;
        DataEx.Assign(Child.FStaticDataEx);
        Child.FStaticDataEx.Free;
        Child.FStaticDataEx := DataEx;
        FDataCache.Move(0, FDataCache.Count - 1);
      end
      else
      begin
        DataEx := TElXTreeItemStaticDataEx.Create;
        DataEx.Assign(Child.FStaticDataEx);
        DataEx.ItemRef := Child;
        Child.FStaticDataEx.Free;
        Child.FStaticDataEx := DataEx;
        FDataCache.Add(DataEx);
      end;
    end;
  end;
  FOwner.FUpdated := True;

  if FOwner.VirtualityLevel > vlNone then
    NewVirtualSort;
end;

function TElXTreeItem.AddLastChild(Child: TElXTreeItem): Integer;
begin
  if FChildren = nil then
    FChildren := TLMDObjectList.Create;
  FOwner.FAllList.Add(Child);
  Result := FChildren.Add(Child);
  Child.FRoot := FRoot;
  if FOwner.VirtualityLevel = vlNone then
    Child.NewStaticData;
  if (FOwner.VirtualityLevel < vlAllProps) or (csDesigning in FOwner.ComponentState) then
    Child.NewStaticDataEx;
  FOwner.FUpdated := True;

  if FOwner.VirtualityLevel > vlNone then
    NewVirtualSort;
end;

function TElXTreeItem.InsertChild(index: Integer; Child: TElXTreeItem): Integer;
var i: Integer;
    SI: TElXTreeItem;

begin
  if FChildren = nil then
    FChildren := TLMDObjectList.Create;
  if Index > FChildren.Count then
    raise EElTreeError.Create(STExOutOfBounds);

  with FOwner do
  begin
    if Count = 0 then
      i := FAllList.IndexOf(Self) + 1
    else
    begin
      if FChildren.Count = Index then
      begin
        SI := TElXTreeItem(FChildren.List[Index - 1]).GetLastSubItem;
        if SI = FAllList.Last then
           i := FAllList.Count
        else
           i := FAllList.IndexOf(SI) + 1;
      end
      else
        i := FAllList.IndexOf(FChildren.List[Index]);
    end;
    if i = FAllList.Count then
       FAllList.Add(Child)
    else
       FAllList.Insert(i, Child);
  end;

  FChildren.Insert(Index, Child);
  Result := index;
  Child.FParent := self;
  Child.FRoot := FRoot;
  if FOwner.VirtualityLevel = vlNone then
    Child.NewStaticData;
  if (FOwner.VirtualityLevel < vlAllProps) or (csDesigning in FOwner.ComponentState) then
    Child.NewStaticDataEx;
  FOwner.FUpdated := True;

  if FOwner.VirtualityLevel > vlNone then
    NewVirtualSort;
end;

procedure TElXTreeItem.MoveTo(NewParent: TElXTreeItem);
var TSI: TElXTreeItem;
begin
  if NewParent = self then
    Exit;
  if NewParent = nil then
     TSI := FRoot
  else
     TSI := NewParent;
  if TSI.FChildren = nil then
     MoveToIns(NewParent, 0)
  else
     MoveToIns(NewParent, TSI.FChildren.Count);
end;

procedure TElXTreeItem.CopyTo(NewParent: TElXTreeItem);
var
  TSI: TElXTreeItem;
begin
  if NewParent = self then
    Exit;
  if NewParent = nil then
    NewParent := FRoot;
  if NewParent.IsUnder(self) then
    raise EElTreeError.Create(STexRecursiveMove);
  FOwner.IsUpdating := True;
  TSI := Owner.Items.AddItem(NewParent);
  TSI.Assign(Self);
  FOwner.IsUpdating := False;
end;

procedure TElXTreeItem.MoveToIns(NewParent: TElXTreeItem; AnIndex: Integer);
var i: Integer;
    OldStart,
    OldEnd,
    NewStart: Integer;
    aresize: Boolean;
    //OldSel: Boolean;
begin
  if NewParent = self then
    Exit;
  if NewParent = nil then
    NewParent := FRoot;
  if NewParent.IsUnder(self) then
    raise EElTreeError.Create(STexRecursiveMove);
  FOwner.IsUpdating := True;
  {if FParent.FChildren = nil then
  begin
    i := -1;
    FParent.FChildren := TLMDObjectList.Create;
  end
  else }
  i := FParent.FChildren.IndexOf(self);

  with FOwner.FAllList do
  begin
    OldStart := IndexOf(Self);
    OldEnd := IndexOfFrom(OldStart, GetLastSubItem);
  end;
  aresize := False;
  {if FParent <> nil then }
  //OldSel := FOwner.FView.FSelected = Self;
  FParent.RemoveChild(self);
  if (FParent = NewParent) and (AnIndex > i) and (AnIndex >= FParent.Count) then
  begin
    NewStart := FOwner.FAllList.IndexOf(FParent.GetLastSubItem);
    with FOwner.FAllList do
    if NewStart = Count - 1 then
    begin
      aresize := True;
      Count := Count + 1;
    end;
    Inc(NewStart);
    with FParent do
    begin
      if FChildren = nil then
         FChildren := TLMDObjectList.Create;
      FChildren.Add(self);
    end;
  end
  else
  begin
    with NewParent do
    begin
      if FChildren = nil then
         FChildren := TLMDObjectList.Create;
      FChildren.Insert(AnIndex, self);
      if AnIndex = 0 then
         NewStart := FOwner.FAllList.IndexOf(NewParent)
      else
         NewStart := FOwner.FAllList.IndexOf(TElXTreeItem(FChildren.List[AnIndex - 1]).GetLastSubItem);
    end;
    with FOwner.FAllList do
      if NewStart = Count - 1 then
      begin
        aresize := True;
        Count := Count + 1;
      end;
    Inc(NewStart);
  end;
  FOwner.FAllList.MoveRange(OldStart, OldEnd, NewStart);

  //if OldSel then FOwner.FView.FSelected := Self;

  if aresize then
  with FOwner.FAllList do
     Count := Count - 1;
  FParent := NewParent;
  with FOwner do
  begin
    //Inc(FItems.FCount);
    if ((FSortMode = smAdd) or (FSortMode = smAddClick)) and (FInSorting = 0) then
    begin
      if (FMainTreeColumn = FSortSection) or (FSortSection = -1) then
        FSortRequired := True;
    end;
    with FOwner.FView do
    begin
      FVisUpdated := True;
      FClearVis := True;
      FUpdated := True;
      FClearAll := True;
    end;
    IsUpdating := False;
  end;
end;

procedure TElXTreeItem.RedrawItemPart(DoCheck: Boolean; Left, Right: Integer);
var
  R: TRect;
begin
  if (FOwner = nil) or ((FBoolData and ibfDeleting) = ibfDeleting) then
    Exit;
  with FOwner do
    R := FView.GetItemRect(FView.ColorHelper.Visible.IndexOf(self));
  Inc(R.Bottom);
  if DoCheck and IsRectEmpty(R) then
    Exit;
  R.Left := Left - FOwner.FLeftPosition;
  R.Right := Right - FOwner.FLeftPosition;
  if not (csDestroying in FOwner.ComponentState) or (FOwner.FView.HandleAllocated) then
    InvalidateRect(FOwner.FView.Handle,@R, True);
end;

procedure TElXTreeItem.RedrawItem(ADoCheck: Boolean);
var
  R: TRect;
//  R1: TRect;
begin
  if not Assigned(FOwner) or ((FBoolData and ibfDeleting) <> 0) then
    Exit;
  if ADoCheck and (FOwner.FView.ColorHelper.Visible.IndexOf(Self) = -1) then
    Exit;
  R := GetClipRect;
//  R := FOwner.GetItemRect(Self.Index);
{  R1 := FOwner.View.GetItemRect(FOwner.View.ColorHelper.Visible.IndexOf(Self));
  if (R.Top <> R1.Top)
    or (R.Left <> R1.Left)
    or (R.Bottom <> R1.Bottom)
    or (R.Right <> R1.Right)
  then
    R1 := R1;}
  Inc(R.Bottom);
  if ADoCheck and IsRectEmpty(R) then
    Exit;
  if not (csDestroying in FOwner.ComponentState) or (FOwner.FView.HandleAllocated) then
    InvalidateRect(FOwner.FView.Handle,@R, True);
end;

procedure TElXTreeItem.SetText(Value: TLMDString);
begin
  if Value <> Text then
  begin
    if Assigned(Cells) and (Cells.Count > Owner.FMainTreeColumn) then
      Cells[Owner.FMainTreeColumn].Text := Value;
    if FStaticData <> nil then
    begin
      FStaticData.FText := Value;
      FOwner.DoItemChange(Self, icmText);
      FOwner.IsUpdating := True;
      UpdateChangedMainText;
      FOwner.IsUpdating := False;
    end;
    UpdateItem;
  end;
end;

function TElXTreeItem.GetLevel: Integer;
begin
  if Self = FRoot then
    Result := -1
  else
    Result := FParent.Level + 1;
end;

procedure TElXTreeItem.InsertNewCell(AIndex: Integer);
var
  LCell: TElXTreeCell;
begin
  if (AIndex >= 0) and (AIndex <= FCells.Count) then
    LCell := FCells.Insert(AIndex)
  else
    LCell := FCells.Add;
  if Assigned(LCell) then
  begin
    if Owner.RowSelect and Selected then
      LCell.Selected := True;
  end;
end;

{Returns True if the item is under then given item in the tree}

function TElXTreeItem.IsUnder(Item: TElXTreeItem): Boolean;
begin
  if Item = nil then
  begin
    Result := False;
    Exit;
  end;
  if Self = Item then
     Result := True
  else
  if (FParent <> FRoot) and (FParent <> nil) then
     Result := FParent.IsUnder(Item)
  else
     Result := False;
end;

procedure TElXTreeItem.SetExpanded(value: Boolean);
begin
  if value = Expanded then
    Exit;
  FOwner.IsUpdating := True;
  try
    if value = True then
      Expand(False)
    else
      Collapse(False);
  finally
    FOwner.IsUpdating := False;
  end;
end;

procedure TElXTreeItem.MakeFullyExpanded(value: Boolean);
var
  TSI: TElXTreeItem;
begin
  if not value then
    Exit;
  FOwner.IsUpdating := True;
  try
    TSI := Self;
    TSI.Expand(False);
    while TSI.FParent <> nil do
    begin
      TSI.FParent.Expand(False);
      TSI := TSI.FParent;
    end; // while
    with FOwner.FView do
    begin
      FClearVis := True;
      FVisUpdated := True;
      FRangeUpdate := True;
    end;
    FOwner.FUpdated := True;
  finally
    FOwner.IsUpdating := False;
  end;
end;

function TElXTreeItem.GetHasChildren: Boolean;
begin
  Result := (FChildren <> nil) and (FChildren.Count > 0);
end;

procedure TElXTreeItem.Clear;
var
  OldFocused: TElXTreeItem;
  i: integer;
begin
  OldFocused := nil;
  if Assigned(FOwner) then
  begin
  OldFocused := FOwner.FView.FFocused;
  Inc(FOwner.FFireFocusEvents);
  end;
//  while Assigned(FChildren) and (FChildren.Count > 0) do
  if Assigned(FChildren) and (FChildren.Count > 0) then
    for i := FChildren.Count - 1 downto 0 do
      DeleteChild(TElXTreeItem(FChildren.Last));
  if Assigned(FChildren) then
    FreeAndNil(FChildren);
  if Assigned(FOwner) then
  begin
  if FullyExpanded then
    FOwner.FView.FVisUpdated := True;
  Dec(FOwner.FFireFocusEvents);
  if (OldFocused <> FOwner.FView.FFocused) and (FOwner.FFireFocusEvents = 0) then
    FOwner.DoItemFocused;
  end;
end;

procedure TElXTreeItem.ClearSubChild;
var i: Integer;
    OldFocused: TElXTreeItem;
begin
  if FChildren = nil then
    Exit;
  OldFocused := FOwner.FView.FFocused;
  Inc(FOwner.FFireFocusEvents);
  try
    for i := FChildren.Count-1 downto 0 do
      RemoveSubChild(TElXTreeItem(FChildren.Items[i]));
    if FullyExpanded then
      FOwner.FView.FVisUpdated := True;
  finally
    Dec(FOwner.FFireFocusEvents);
  end;
  if (OldFocused <> FOwner.FView.FFocused) and (FOwner.FFireFocusEvents = 0) then
    FOwner.DoItemFocused;
end;

procedure TElXTreeItem.ExchangeItems(I, J: Integer);
var
  P: TLMDDataTag;
begin
  // No check for FChildren and indexes validity. The routine should be called from QuickSort only!
  P := FChildren.List[i];
  FChildren.List[i] := FChildren.List[j];
  FChildren.List[j] := P;
end;

procedure TElXTreeItem.NormalizeSorts(StartIdx: Integer);

  procedure IntNormalize(List: TLMDObjectList; Item: TElXTreeItem; var CurIdx: Integer);
  var i: Integer;
      AChild: TElXTreeItem;
      ChC: Integer;
  begin
    if (Item.FChildren <> nil) then
    begin
      ChC := Item.FChildren.Count;
      if (ChC > 0) then
      begin
        for i := 0 to ChC - 1 do
        begin
          AChild := TElXTreeItem(Item.FChildren.List[i]);
          if CurIdx > List.Count - 1 then
            List.Count := CurIdx + 1;

          List[CurIdx] := AChild;
          Inc(CurIdx);
          if (AChild.FChildren <> nil) and (AChild.FChildren.Count > 0) then
             IntNormalize(List, AChild, CurIdx);
        end;
      end;
    end;
  end;

begin
  IntNormalize(FOwner.FAllList, Self, StartIdx);
end;

procedure TElXTreeItem.Sort(recursive: Boolean);
var
  ST: TSortTypes;
  AHeaderSection: TElHeaderSection;
  SM: TElSSortMode;
  FCol: Integer;
  StartItem: TElXTreeItem;
  StartIdx: Integer;
begin
  Inc(FOwner.FInSorting);
  if (FChildren <> nil) and (Recursive or (FChildren.Count > 1)) then
  begin
    FOwner.IsUpdating := True;

    with FOwner do
    begin
      if (not ShowColumns) or (FHeader.Sections.Count <= FSortSection) then
      begin
        FCol := -1;
      end
      else
      begin
        FCol := FSortSection;
      end;
      SM := hsmNone;
      ST := FSortType;

      if ShowColumns and (FCol >= 0) and (FHeader.Sections.Count > FSortSection) then
      begin
        AHeaderSection := FHeader.Sections[FCol];
        if AHeaderSection <> nil then
        begin
          SM := AHeaderSection.SortMode;
          ST := SectionTypeToSortType(AHeaderSection.FieldType);
        end
        else
          FCol := -1;
      end
      else
        FCol := -1;
    end;

    StartItem := TElXTreeItem(FChildren.FastGet(0));
    StartIdx := StartItem.AbsoluteIndex;

    FBoolData := FBoolData and not ibfRec;

    QuickSort(recursive, 0, FChildren.Count - 1, SM, ST, FCol);

    NormalizeSorts(StartIdx);

    with FOwner.FView do
    begin
      FClearAll := True;
      FClearVis := True;
    end;
    with FOwner do
    begin
      FUpdated := True;
      IsUpdating := False;
    end;
  end;
  Dec(FOwner.FInSorting);
end;

procedure TElXTreeItem.AddSortData(SortType: TSortTypes;
                                  FSortSection: Integer);
var S: TLMDString;
    N, I, FCol: Integer;
    CC: Currency;
    bb: Boolean;
    T: TDateTime;
    F : Extended;
    MTC: Integer;
    VA: Variant;
    IntConv: Boolean;

begin
  MTC := FOwner.FMainTreeColumn;
  if FSortRef = 0 then
  begin
    {$ifdef USE_VARIANT}
    VarClear(FSortData);
    {$else}
    FSortType := -1;
    {$endif}
    IntConv := True;
    if (FOwner.VirtualityLevel <> vlNone) and (not (csDesigning in FOwner.ComponentState)) then
    begin
      //if Assigned(FOwner.FOnVirtualValueNeeded) then
      begin
        IntConv := False;
        try
          if SortType = stText then
          begin
            FOwner.TriggerVirtualTextNeeded(Self, FSortSection, S);
            {$ifdef USE_VARIANT}
            FSortData := S;
            {$else}
            FSortType := vtString;
            {$ifdef LMD_UNICODE}
            GetMem(FSortData, (Length(S) + 1) * sizeof(WideChar));
            if FOwner.SortUseCase then
              LMDWideStrPCopy(PWideChar(FSortData), S)
            else
              LMDWideStrPCopy(PWideChar(FSortData), LMDWideUpperCase(S));
            {$else}
            GetMem(FSortData, (Length(S) + 1) * SizeOf(Char));
            if FOwner.SortUseCase then
              StrPLCopy(PChar(FSortData), S, Length(S))
            else
              StrPLCopy(PChar(FSortData), Uppercase(S), Length(S));
            {$endif}
            {$endif}
          end
          else
          begin
            case SortType of
              stNumber:
                begin
                  {$ifdef USE_VARIANT}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtInteger, VA);
                  FSortData := VA;
                  {$else}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtInteger, VA);
                  N := VA;
                  FSortType := vtInteger;
                  TLMDPtrInt(FSortData) := N;
                  {$endif}
                end;
              stCurrency:
                begin
                  {$ifdef USE_VARIANT}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtCurrency, VA);
                  FSortData := VA;
                  {$else}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtCurrency, VA);
                  CC := VA;
                  FSortType := vtCurrency;
                  GetMem(FSortData, sizeof(Currency));
                  PCurrency(FSortData)^ := CC;
                  {$endif}
                end;
              stFloating:
                begin
                  {$ifdef USE_VARIANT}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtExtended, VA);
                  FSortData := VA;
                  {$else}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtExtended, VA);
                  F := VA;
                  FSortType := vtExtended;
                  GetMem(FSortData, sizeof(Double));
                  PDouble(FSortData)^ := F;
                  {$endif}
                end;
              stDateTime,
              stDate,
              stTime:
                begin
                  {$ifdef USE_VARIANT}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtExtended, VA);
                  FSortData := VA;
                  {$else}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtExtended, VA);
                  T := VA;
                  FSortType := vtExtended;
                  GetMem(FSortData, sizeof(Double));
                  PDouble(FSortData)^ := T;
                  {$endif}
                end;
              stBoolean:
                begin
                  {$ifdef USE_VARIANT}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtBoolean, VA);
                  FSortData := VA;
                  {$else}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtBoolean, VA);
                  BB := VA;
                  FSortType := vtBoolean;
                  FSortData := TObject(BB);
                  {$endif}
                end;
              else
                begin
                  {$ifdef USE_VARIANT}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtString, VA);
                  FSortData := VA;
                  {$else}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtString, VA);
                  S := VA;
                  FSortType := vtString;
                  GetMem(FSortData, (Length(S) + 1) * SizeOf(Char));
                  StrPLCopy(PChar(FSortData), S, Length(S))
                  {$endif}
                end;
            end;
          end;
        except
          on E: EVariantError do
            IntConv := True;
        end;
      end;
    end;

    if IntConv then
    begin
      if (FSortSection = MTC) or (FSortSection = -1) then
      begin
        S := Text; // NOTE:
      end
      else
      begin
        FCol := FSortSection;
        if FCol >= Cells.Count then
           S := ''
        else
           S := Cells[FCol].Text;
      end;

      if SortType = stText then
      begin
        {$ifdef USE_VARIANT}
        FSortData := S;
        {$else}
        FSortType := vtString;
        {$ifdef LMD_UNICODE}

        GetMem(FSortData, (Length(S) + 1) * sizeof(WideChar));
        if FOwner.SortUseCase then
          LMDWideStrPCopy(PWideChar(FSortData), S)
        else
          LMDWideStrPCopy(PWideChar(FSortData), LMDWideUpperCase(S));

        {$else}
        GetMem(FSortData, (Length(S) + 1) * SizeOf(Char));
        if FOwner.SortUseCase then
          StrPLCopy(PChar(FSortData), S, Length(S))
        else
          StrPLCopy(PChar(FSortData), Uppercase(S), Length(S));
        {$endif}
        {$endif}
      end
      else
      if SortType = stNumber then
      begin
        {$ifdef USE_VARIANT}
        TVarData(FSortData).VType := vtInteger;
        Val(S, N, I);
        if I <> 0 then
          FSortData := NULL
        else
          FSortData := N;
        {$else}
        FSortType := vtInteger;
        Val(S, N, I);
        if I <> 0 then
          FSortType := -1
        else
          TLMDPtrInt(FSortData) := N;
          {$endif}
      end
      else
      case SortType of
        stCurrency:
          begin
            {$ifdef USE_VARIANT}
            FSortData := LMDPrettyStrToCurr(S);
            {$else}
            FSortType := vtCurrency;
            GetMem(FSortData, sizeof(Currency));
            PCurrency(FSortData)^ := LMDPrettyStrToCurr(S);
            {$endif}
          end;
        stFloating:
          begin
            {$ifdef USE_VARIANT}
            TVarData(FSortData).VType := vtExtended;
            if (not TextToFloat(Pchar(S), F, fvExtended)) then
               FSortData := NULL
            else
               FSortData := F;
            {$else}
            FSortType := vtExtended;
            if (not TextToFloat(PChar(String(S)), F, fvExtended)) then
               FSortType := -1
            else
            begin
              GetMem(FSortData, sizeof(Double));
              PDouble(FSortData)^ := F;
            end;
            {$endif}
          end;
        stDateTime:
          begin
            {$ifdef USE_VARIANT}
            TVarData(FSortData).VType := vtExtended;
            if Length(s) > 0 then
            begin
              try
                T := StrToDateTime(S);
                FSortData := T;
              except
                FSortData := NULL
              end;
            end
            else
              FSortType := NULL;
            {$else}
            FSortType := vtExtended;
              if system.Length(s) > 0 then
              begin
              try
                T := StrToDateTime(S);
                GetMem(FSortData, sizeof(Double));
                PDouble(FSortData)^ := T;
                except
                FSortType := -1;
              end;
            end
            else
              FSortType := -1;
            {$endif}
          end;
        stDate:
          begin
            {$ifdef USE_VARIANT}
            TVarData(FSortData).VType := vtExtended;
            if Length(s) > 0 then
            begin
              try
                T := StrToDate(S);
                FSortData := T;
              except
                FSortData := NULL
              end;
            end
            else
              FSortType := NULL;
            {$else}
            FSortType := vtExtended;
              if system.Length(s) > 0 then
            begin
              try
                T := StrToDate(S);
                GetMem(FSortData, sizeof(Double));
                PDouble(FSortData)^ := T;
                except
                FSortType := -1;
              end;
            end
            else
              FSortType := -1;
            {$endif}
          end;
        stTime:
          begin
            {$ifdef USE_VARIANT}
            TVarData(FSortData).VType := vtExtended;
            if Length(s) > 0 then
            begin
              try
                T := StrToTime(S);
                FSortData := T;
              except
                FSortData := NULL
              end;
            else
              FSortData := NULL;
            {$else}
            FSortType := vtExtended;
            if system.Length(s) > 0 then
            begin
              try
                T := StrToTime(S);
                GetMem(FSortData, sizeof(Double));
                PDouble(FSortData)^ := T;
                except
                FSortType := -1;
              end;
            end
            else
              FSortType := -1;
            {$endif}
          end;
        stBoolean:
          begin
            {$ifdef USE_VARIANT}
            TVarData(FSortData).VType := vtBoolean;
            FSortData := Boolean(S <> '');
            {$else}
            FSortType := vtBoolean;
            TLMDPtrInt(FSortData) := Length(S);
            {$endif}
          end;
        else
          begin
            {$ifdef USE_VARIANT}
            FSortData := S;
            {$else}
            FSortType := vtString;
            GetMem(FSortData, (Length(S) + 1) * SizeOf(Char));
            StrPLCopy(PChar(FSortData), S, Length(S));
            {$endif}
          end;
      end;
    end;
  end;
  Inc(FSortRef);
end;

procedure TElXTreeItem.ReleaseSortData;
begin
  Dec(FSortRef);
  if (FSortRef = 0) then
  {$ifdef USE_VARIANT}
     VarClear(FSortData);
  {$else}
  begin
   if ((FSortType = vtExtended) or (FSortType = vtString)) and (FSortData <> nil) then
       FreeMem(FSortData);
  FSortData := nil;
    FSortType := -1;
  end;
  {$endif}
end;

procedure TElXTreeItem.QuickSort(recursive: Boolean;
                                L, R: Integer;
                                SM: TElSSortMode;
                                SortType: TSortTypes;
                                FSortSection: Integer);
var
  I, J: Integer;
  P: TElXTreeItem;
  EL, ER: Integer;
  ChildCount: Integer;
  LocalFRec: Boolean;
  Item1,
  Item2: TElXTreeItem;

begin
  Childcount := FChildren.Count;
  Inc(FOwner.FInSorting);
  if ChildCount > 1 then
  begin
    if (FBoolData and ibfRec) <> ibfRec then
    begin
      for i := 0 to ChildCount - 1 do
      begin
        p := TElXTreeItem(FChildren.List[i]);
        if P.FSortRef = 0 then
           P.AddSortData(SortType, FSortSection)
        else
           Inc(P.FSortRef);
      end;
    end;
    El := L;
    Er := R;
    repeat
      I := L;
      J := R;
      P := TElXTreeItem(FChildren.List[(L + R) shr 1]);
      repeat
        while (I < ChildCount) do
        begin
          Item1 := TElXTreeItem(FChildren.List[I]);
          Item2 := P;
          if Item1 = Item2 then
            break;
          if (FOwner.CompareItems(Item1, Item2, SM, SortType, FSortSection) >= 0) then
            break;
          Inc(I);
        end;
        while (J >= 0) do
        begin
          Item1 := TElXTreeItem(FChildren.List[J]);
          Item2 := P;
          if Item1 = Item2 then
            break;
          if (FOwner.CompareItems(Item1, P, SM, SortType, FSortSection) < 0) then
            break;
          Dec(J);
        end;
        if I <= J then
        begin
          if i <> j then
             ExchangeItems(I, J);
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if (L < J) and ((EL <> L) or (ER <> J)) then
      begin
        LocalFRec:= (FBoolData and ibfRec) = ibfRec;
        FBoolData := FBoolData or ibfRec;
        QuickSort(recursive, L, J, SM, SortType, FSortSection);
        if LocalFRec then
          FBoolData := FBoolData or ibfRec
        else
          FBoolData := FBoolData and not ibfRec;
      end;
      L := I;
    until I >= R;
    if (FBoolData and ibfRec) <> ibfRec then
      for i := 0 to ChildCount - 1 do
      begin
        P := TElXTreeItem(FChildren.List[i]);
        if P.FSortRef = 1 then
           P.ReleaseSortData
        else
           Dec(P.FSortRef);
      end;
  end;

  if Recursive then
  begin
    if (FBoolData and ibfRec) <> ibfRec then
    begin
      for i := 0 to ChildCount - 1 do
      begin
        P := TElXTreeItem(FChildren.List[i]);
        if (P.FChildren <> nil) and (P.FChildren.Count > 0) then
            P.QuickSort(recursive, 0, P.FChildren.Count - 1, SM, SortType, FSortSection);
      end; // for
    end;
  end;
  Dec(FOwner.FInSorting);
end;

{procedure TElXTreeItem.OnColTextChange(Sender: TObject);
begin
  if FOwner <> nil then
  begin
    FOwner.DoItemChange(Self, icmColumnText);
    UpdateChangedCellText;
    UpdateItem;
  end;
end;}

procedure TElXTreeItem.SetImageIndex(Index: Integer; value: Integer);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    case Index of
      0:
        begin
          if FImageIndex = value then
            Exit;
          FImageIndex := value;
        end;
      1:
        begin
          if FImageIndex2 = value then
            Exit;
          FImageIndex2 := value;
        end;
      2:
        begin
          if FStImageIndex = value then
            Exit;
          FStImageIndex := value;
        end;
      3:
        begin
          if FStImageIndex2 = value then
            Exit;
          FStImageIndex2 := value;
        end;
      4:
        begin
          if (FOverlayIndex = value) or (Value < -1) or (Value > 3) then
            Exit;
          FOverlayIndex := value;
        end;
      5:
        begin
          if (FOverlayIndex2 = value) or (Value < -1) or (Value > 3) then
            Exit;
          FOverlayIndex2 := value;
        end;
    end;

    // We do not do update if we are drawing
    if FOwner.FView.FPainting then
      Exit;

    FOwner.IsUpdating := True;
    try
      if FOwner.FShowImages then
      begin
        with FOwner do
        begin
          if Index in [0, 1] then
          begin
            if (not FShowEmptyImages) and ShowColumns then
               AutoSizeColumn(FMainTreeColumn)
            else
               FColumnSizeUpdate := True;
          end
          else
          if Index in [2, 3] then
          begin
            if (not FShowEmptyImages2) and ShowColumns then
               AutoSizeColumn(FMainTreeColumn)
            else
               FColumnSizeUpdate := True;
          end;
          if (not ShowColumns) and FullyExpanded then
            FView.FHRange := -1;
        end;
        UpdateItem;
      end;
    finally
      FOwner.IsUpdating := False;
    end;
  end;
end; { SetImageIndex }

procedure TElXTreeItem.SetForceButtons(newValue: Boolean);
{ Sets data member FForceButtons to newValue. }
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if ((FBoolData1 and ibfForceButtons) <> 0) <> newValue then
    begin
      if newValue then
        FBoolData1 := FBoolData1 or ibfForceButtons
      else
        FBoolData1 := FBoolData1 and not ibfForceButtons;

      if FOwner.FShowButtons then
      begin
        with FOwner do
          if ShowColumns and (FOwner.FUpdateCount = 0) then
            AutoSizeColumn(FMainTreeColumn)
          else
            FOwner.FColumnSizeUpdate := True;
        UpdateItem;
      end;
    end;
  end;
end; { SetForceButtons }

function TElXTreeItem.GetCount: Integer;
begin
  if FChildren = nil then
    Result := 0
  else
    Result := FChildren.Count;
end; { GetCount }

function TElXTreeItem.GetItems(Index: Integer): TElXTreeItem;
{ Returns the value of data member FItems[Index ]. }
begin
  if FChildren = nil then
     Result := nil
  else
     Result := TElXTreeItem(FChildren[Index]);
end; { GetItems }

procedure TElXTreeItem.Delete; { public }
begin
  FList.DeleteItem(Self);
end; { Delete }

function TElXTreeItem.IsVisible: Boolean; { public }
begin
  if (Self = FList.FRoot) or (Parent = nil) then
    Result := not (Hidden and FOwner.FFilteredVisibility)
  else
     Result := not (Hidden and FOwner.FFilteredVisibility) and Parent.IsVisible
       and Parent.Expanded;
end; { IsVisible }

function TElXTreeItem.GetNextVisible: TElXTreeItem; { public }
begin
  Result := GetNext;
  while Assigned(Result) and (not Result.IsVisible) do Result := Result.GetNext;
end;

function TElXTreeItem.GetPrevVisible: TElXTreeItem; { public }
begin
  Result := GetPrev;
  while Assigned(Result) and (not Result.IsVisible) do Result := Result.GetPrev;
end;

function TElXTreeItem.GetPrev: TElXTreeItem; { public }
var i: Integer;

begin
  i := FOwner.FAllList.IndexOf(Self);
  if i = 0 then
     Result := nil
  else
     Result := TElXTreeItem(FOwner.FAllList[Pred(i)]);
end; { GetPrev }

function TElXTreeItem.GetNext: TElXTreeItem; { public }
var i: Integer;

begin
  i := FOwner.FAllList.IndexOf(Self);
  if i = Pred(FOwner.FAllList.Count) then
     Result := nil
  else
     Result := TElXTreeItem(FOwner.FAllList[Succ(i)]);
end; { GetNext }

procedure TElXTreeItem.MoveToItem(Item: TElXTreeItem; Mode: TNodeAttachMode); { public }
begin
  case Mode of
    naAdd:
      begin
        if not Assigned(item) then
           raise EElTreeError.Create(STexInvItem);
        if not Assigned(item) then
           MoveTo(nil)
        else
           MoveToIns(item.FParent, item.FParent.Count);
      end;
    naAddFirst:
      begin
        if not Assigned(item) then
           MoveToIns(nil, 0)
        else
           MoveToIns(item.FParent, 0);
      end;
    naAddChild: MoveTo(item);
    naAddChildFirst: MoveToIns(item, 0);
    naInsert:
      begin
        if not Assigned(item) then
          MoveToIns(nil, 0)
        else
          if (FParent = item.FParent) and (Index < Item.Index) then
            MoveToIns(item.FParent, item.Index-1)
          else
            MoveToIns(item.FParent, item.Index);
      end;
  end;
end; { MoveToItem }

procedure TElXTreeItem.SetUseOwnStyle(AValue: Boolean);
begin
  if FUseOwnStyle <> AValue then
    begin
      FUseOwnStyle := AValue;
      if (FOwner.FVirtualityLevel = vlNone) then
      begin
        if not Assigned(FStaticData) then
          NewStaticData;
        if (FUseOwnStyle) and (not Assigned(FStaticData.FCellStyle)) then
          CreateStyle;
      end;
      if not FOwner.IsUpdating then
        UpdateItem;
    end;
end;

procedure TElXTreeItem.UpdateItem;
var
  i, j: Integer;
  LTopItemIndex, LBottomItemIndex: Integer;
  LCell: TElXTreeCell;
  LItem: TElXTreeItem;
  LHidden: Boolean;
begin
  if csReading in FOwner.ComponentState then
    Exit;
    LCell := nil;
  for i := 0 to FCells.Count - 1 do
  begin
    LCell := FCells[i];
    if LCell.FJointCellRole = jcrSingle then
      continue;
    LCell := LCell.JointCellMaster;
    break;
  end;
  if not Assigned(LCell) then
    Exit;

  LItem := LCell.Owner;
  LTopItemIndex := LItem.Index;
  LBottomItemIndex := LTopItemIndex + LCell.JointRowCount - 1;

  if csDestroying in FOwner.ComponentState then
    Exit;

  if not FOwner.FFilteredVisibility then
  begin
    for i := LTopItemIndex to LBottomItemIndex do
    begin
      LItem := FOwner.FItems[i];
      if not LItem.Hidden then
      begin
        if not (FOwner.VirtualityLevel = vlNone) then
          for j := 0 to LItem.FCells.Count - 1 do
          begin
            if Assigned(LItem.FCells[j].FVirtStyle) then
            FreeAndNil(LItem.FCells[j].FVirtStyle);
            end;
        LItem.RedrawItem(True);
      end;
    end;
  end
  else
  begin
    LHidden := LItem.Hidden;
    FOwner.TriggerApplyVisFilterEvent(Self, LHidden);
    LItem.Hidden := LHidden;
  end;
  if FOwner.FUpdateCount > 0 then
    FOwner.FUpdated := True
  else
    FOwner.FView.Invalidate; //Update;
end;

procedure TElXTreeItem.SetCheckBoxState(newValue: TCheckBoxState);
var
  Section: TElHeaderSection;
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (FCheckBoxState <> newValue) then
    begin
      FCheckBoxState := newValue;
      if ((FBoolData1 and ibfShowCheckBox) <> 0) and (FOwner.FShowCheckboxes) then
      begin
        if FOwner.ShowColumns then
        begin
          Section := FOwner.FHeader.Sections[FOwner.FMainTreeColumn];
          RedrawItemPart(True, Section.Left, Section.Right);
        end
        else
          RedrawItem(True);
        with FOwner do
          if IsUpdating then
            FUpdated := True
          else
            FView.Invalidate; //Update;
      end;
    end; {if}
  end;
end; {SetCheckBoxState}

function TElXTreeItem.GetChecked: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := FStaticDataEx.FCheckBoxState = cbChecked
  else
    Result := False;
end;

procedure TElXTreeItem.SetChecked(newValue: Boolean);
var
  Section: TElHeaderSection;
  i: Integer;
  Item: TElXTreeItem;
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if ((FStaticDataEx.FCheckBoxState = cbChecked) <> newValue) then
    begin
      if newValue then
        FCheckBoxState := cbChecked
      else
        FCheckBoxState := cbUnchecked;
      if (FCheckBoxType = ectRadioButton) and (newValue) then
      begin
        if Assigned(FParent.FChildren) then
        begin
          for i := 0 to Pred(FParent.FChildren.Count) do
          begin
            Item := FParent.Children[i];
            if Item.FStaticDataEx <> nil then
              if (Item.CheckBoxType = ectRadioButton) and (Item <> Self) then
              begin
                Item.Checked := False;
              end;
          end; // for
        end; // if
      end;
      if ((FBoolData1 and ibfShowCheckBox) <> 0) and (FOwner.FShowCheckboxes) then
      begin
        if FOwner.ShowColumns then
        begin
          Section := FOwner.FHeader.Sections[FOwner.FMainTreeColumn];
          RedrawItemPart(True, Section.Left, Section.Right);
        end
        else
          RedrawItem(True);
        with FOwner do
          if IsUpdating then
            FUpdated := True
          else
            FView.Invalidate; //Update;
      end;
    end;
  end;
end; {SetChecked}

procedure TElXTreeItem.SetShowCheckBox(newValue: Boolean);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (((FBoolData1 and ibfShowCheckBox) <> 0) <> newValue) then
    begin
      if newValue then
        FBoolData1 := FBoolData1 or ibfShowCheckbox
      else
        FBoolData1 := FBoolData1 and not ibfShowCheckbox;

      with FOwner do
      begin
        if (FShowCheckboxes) then
        begin
          if ShowColumns and (FOwner.FUpdateCount = 0) then
            AutoSizeColumn(FMainTreeColumn)
          else
            FOwner.FColumnSizeUpdate := True;
          if (not ShowColumns) and FullyExpanded then
            if FUpdateCount > 0 then
              FView.FHRange := -1
            else
              FView.DefineHRange;
          UpdateItem;
        end;
      end;
    end; {if}
  end;
end; {SetShowCheckBox}

procedure TElXTreeItem.SetCheckBoxType(newValue: TElCheckBoxType);
var
  Section: TElHeaderSection;
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (FCheckBoxType <> newValue) then
    begin
      FCheckBoxType := newValue;
      if ((FBoolData1 and ibfShowCheckBox) <> 0) and (FOwner.FShowCheckboxes) then
      begin
        if FOwner.ShowColumns then
        begin
          Section := FOwner.FHeader.Sections[FOwner.FMainTreeColumn];
          RedrawItemPart(True, Section.Left, Section.Right);
        end
        else
          RedrawItem(True);
        with FOwner do
          if IsUpdating then
            FUpdated := True
          else
            FView.Invalidate; //Update;
      end;
    end; {if}
  end;
end; {SetCheckBoxType}

procedure TElXTreeItem.SetCheckBoxEnabled(newValue: Boolean);
var
  Section: TElHeaderSection;
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (((FBoolData1 and ibfCheckBoxEnabled) <> 0) <> newValue) then
    begin
      if newValue then
        FBoolData1 := FBoolData1 or ibfCheckBoxEnabled
      else
        FBoolData1 := FBoolData1 and not ibfCheckBoxEnabled;

      if ((FBoolData1 and ibfShowCheckBox) <> 0) and FOwner.FShowCheckboxes then
      begin
        if FOwner.ShowColumns then
        begin
          Section := FOwner.FHeader.Sections[FOwner.FMainTreeColumn];
          RedrawItemPart(True, Section.Left, Section.Right);
        end
        else
          RedrawItem(True);
        with FOwner do
          if IsUpdating then
            FUpdated := True
          else
            FView.Invalidate; //Update;
      end;
    end; {if}
  end;
end; {SetCheckBoxEnabled}

procedure TElXTreeItem.SetSuppressButtons(newValue: Boolean);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (((FBoolData1 and ibfSuppressButtons) <> 0) <> newValue) then
    begin
      if newValue then
        FBoolData1 := FBoolData1 or ibfSuppressButtons
      else
        FBoolData1 := FBoolData1 and not ibfSuppressButtons;
      with FOwner do
      begin
        if FShowButtons and ShowColumns and (FOwner.FUpdateCount = 0) then
          AutoSizeColumn(FMainTreeColumn)
        else
          FOwner.FColumnSizeUpdate := True;
        if (not ShowColumns) and FullyExpanded then
          if FUpdateCount > 0 then
            FView.FHRange := -1
          else
            FView.DefineHRange;
      end;
      UpdateItem;
    end; {if}
  end;
end;

procedure TElXTreeItem.SetEnabled(newValue: Boolean);
begin
  if (((FBoolData and ibfEnabled) = ibfEnabled) <> newValue) then
  begin
    if newValue then
      FBoolData := FBoolData or ibfEnabled
    else
      FBoolData := FBoolData and not ibfEnabled;
    // UpdateItem;
  end; {if}
end; {SetEnabled}

procedure TElXTreeItem.SetHidden(newValue: Boolean);
begin
  if (((FBoolData and ibfHidden) = ibfHidden) <> newValue) then
  begin
    if newValue then
      FBoolData := FBoolData or ibfHidden
    else
      FBoolData := FBoolData and not ibfHidden;
    if FOwner <> nil then
    begin
      FOwner.IsUpdating := True;
      if newValue = True then
      begin
        Inc(FOwner.TotalHiddenCount);
      end
      else
      begin
        Dec(FOwner.TotalHiddenCount);
      end;
      if FOwner.FilteredVisibility then
      with FOwner.FView do
      begin
        FVisUpdated := True;
        FClearVis := True;
        FClearAll := True;
        FRangeUpdate := True;
        FOwner.FUpdated := True;
      end;
      FOwner.IsUpdating := False;
    end;
    with FOwner do
      if ShowColumns and (FOwner.FUpdateCount = 0) then
        AutoSizeColumn(FMainTreeColumn)
      else
        FOwner.FColumnSizeUpdate := True;
  end; {if}
end;

function TElXTreeItem.GetFullyVisible: Boolean;
begin
  if Parent <> nil then
    Result := (not hidden) and Parent.FullyVisible
  else
    Result := not hidden;
end;

procedure TElXTreeItem.SetFullyVisible(newValue: Boolean);
begin
  if (FullyVisible <> newValue) then
  begin
    if newValue and (Parent <> nil) then
    begin
      Parent.FullyVisible := True;
      Hidden := False;
    end;
  end; {if}
end;

function TElXTreeItem.GetHasVisibleChildren: Boolean;
var
  i: Integer;
begin
  Result := False;
  if FChildren = nil then
    Result := False
  else
  begin
    if not FOwner.FilteredVisibility then
      Result := FChildren.Count > 0
    else
    begin
      if FChildren.Count <> 0 then
        for i := 0 to FChildren.Count - 1 do
        begin
          if not TElXTreeItem(FChildren.List[i]).Hidden then
          begin
            Result := True;
            Exit;
          end;
        end;
    end;
  end;
end;

procedure TElXTreeItem.SetOwnerHeight(newValue: Boolean);
{ Sets data member FOwnerHeight to newValue. }
begin
  if (((FBoolData and ibfOwnerHeight) = ibfOwnerHeight) <> newValue) then
  begin
    if newValue then
      FBoolData := FBoolData or ibfOwnerHeight
    else
      FBoolData := FBoolData and not ibfOwnerHeight;

//    FOwner.IsUpdating := True;
    Inc(FOwner.FUpdateCount);
    FComplexHeight := (FComplexHeight and $FFFF0000) or word(-1);
    if newValue then
      Dec(FOwner.TotalVarHeightCount)
    else
      Inc(FOwner.TotalVarHeightCount);
    with FOwner.FView do
    begin
      FVisUpdated := True;
      FClearVis := True;
      FClearAll := True;
      FRangeUpdate := True;
      FOwner.FUpdated := True;
    end;
//    FOwner.IsUpdating := False;
    Dec(FOwner.FUpdateCount);
  end;  { if }
end;  { SetOwnerHeight }

function TElXTreeItem.GetHeight: Integer;

var Size: TPoint;
    i: Integer;
    Section: TElHeaderSection;
    w: Integer;

    function TextLinesCount: Integer;
    var i, j: Integer;
        AText: TLMDString;
    begin
      i := 1;
      Result := 0;
      AText := Text;
      j := Length(AText);
      while i <= j do
      begin
        if (AText[i] = #13) and (i < j) and (AText[i + 1] = #10) then
        begin
          Inc(Result);
          Inc(i);
        end;
        Inc(i);
      end;
      if i > 1 then
        Inc(Result);
    end;

begin

  if ((FBoolData and ibfOwnerHeight) <> ibfOwnerHeight) or IsHTML or  (Multiline and FOwner.AdjustMultilineHeight) then
  begin
    if (((FComplexHeight shr 16) > 0) and ((FBoolData and ibfOwnerHeight) <> ibfOwnerHeight){(not Multiline) and not IsHTML}) then
      Result := FComplexHeight shr 16
    else
    begin
      if SmallInt(FComplexHeight and $0000FFFF) <> -1 then
         Result := SmallInt(FComplexHeight and $0000FFFF)
      else
      begin
        if FOwner.ShowColumns then
        begin
          if WholeLine then
          begin
            Result := 0;
            w := 0;
            for i := 0 to Pred(FOwner.FHeader.Sections.Count) do
            begin
              Section := FOwner.FHeader.Sections[i];
              if Section.Visible then
                Inc(w, Section.Width);
            end;
            FOwner.MeasureCell(Self, FOwner.MainTreeColumn, w, Size);
            Result := Max(Result, Size.Y);
          end
          else
          begin
            Result := 0;
            for i := 0 to Pred(FOwner.FHeader.Sections.Count) do
            begin
              if FOwner.FHeader.Sections[i].Visible or (not FOwner.FAutoLineVisibleOnly) then
              begin
                if (Cells[i].JointCellRole <> jcrSingle) then
                  FOwner.MeasureCell(Self, i, Cells[i].GetJointCellMaster.Width, Size)
                else
                  FOwner.MeasureCell(Self, i, FOwner.FHeader.Sections[i].Width, Size);
                Result := Max(Result, Size.Y);
              end;
            end;
          end;
        end
        else
        begin
          FOwner.MeasureCell(Self, -1, FOwner.FView.ClientWidth, Size);
          Result := Size.Y;
        end;
        FComplexHeight := (FComplexHeight and $FFFF0000) or Word(Result);
      end;
    end;
  end
  else
    Result := FOwner.LineHeight;

end;  { GetHeight }

procedure TElXTreeItem.SetHeight(newValue: Integer);
{ Sets data member FHeight to newValue. }
begin
  if (SmallInt((FComplexHeight shr 16)) <> newValue) then
  begin
    FComplexHeight := (Word(newValue) shl 16) or (FComplexHeight and $0000FFFF);

    if ((FBoolData and ibfOwnerHeight) <> ibfOwnerHeight) then
    begin
      FOwner.IsUpdating := True;
      with FOwner.FView do
      begin
        FVisUpdated := True;
        FClearVis := True;
        FClearAll := True;
        FRangeUpdate := True;
        FOwner.FUpdated := True;
      end;
      FOwner.IsUpdating := False;
    end;
  end;  { if }
end;  { SetHeight }

procedure TElXTreeItem.RecalcHeight;
begin
  if (FComplexHeight and $0000FFFF) <> word(-1) then
  begin
    FComplexHeight := (FComplexHeight and $FFFF0000) or word(-1);
    FOwner.IsUpdating := True;
    with FOwner.FView do
    begin
      FVisUpdated := True;
      FClearVis := True;
      FClearAll := True;
      FRangeUpdate := True;
      FOwner.FUpdated := True;
    end;
    FOwner.IsUpdating := False;
  end;
end;

procedure TElXTreeItem.InvalidateItemPart(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean;
  IterateData: TLMDDataTag; Tree: TCustomElXTree);
var
  R: TRect;
begin
  with Item.TreeView do
    R := GetItemRect(Item.AbsoluteIndex);
  Item.RedrawItemPart(True,R.Left, R.Right);

  ContinueIterate := True;
end;

procedure TElXTreeItem.SetSuppressLines(newValue: Boolean);
{ Sets data member FSuppressLines to newValue. }
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (((FBoolData1 and ibfSuppressLines) <> 0) <> newValue) then
    begin
      if newValue then
        FBoolData1 := FBoolData1 or ibfSuppressLines
      else
        FBoolData1 := FBoolData1 and not ibfSuppressLines;

      if FOwner.FShowLines then
      begin
        FList.IterateFrom(True, False, InvalidateItemPart, nil, FParent); {<+>}
        with FOwner do
        begin
          if ShowColumns and (FOwner.FUpdateCount = 0) then
            AutoSizeColumn(FMainTreeColumn)
          else
            FColumnSizeUpdate := True;
          if (not ShowColumns) and FullyExpanded then
            if FUpdateCount > 0 then
              FView.FHRange := -1
            else
              FView.DefineHRange;
        end;
        RedrawItem(True);
      end;
    end;  { if }
  end;
end;  { SetSuppressLines }

function TElXTreeItem.GetOwnerHeight: Boolean;
begin
  Result := not (((FBoolData and ibfOwnerHeight) <> ibfOwnerHeight));
end;

procedure TElXTreeItem.SetMultiline(newValue: Boolean);
{ Sets data member FMultiline to newValue. }
begin
  if (((FBoolData and ibfMultiline) = ibfMultiline) <> newValue) then
  begin
    if newValue then
      FBoolData := FBoolData or ibfMultiline
    else
      FBoolData := FBoolData and not ibfMultiline;

    FComplexHeight := (FComplexHeight and $FFFF0000) or WORD(-1);

    FOwner.IsUpdating := True;
    if FOwner.FAdjustMultilineHeight then
    begin
      if newValue then
        Inc(FOwner.TotalVarHeightCount)
      else
        Dec(FOwner.TotalVarHeightCount);
    end;
    with FOwner do
      if (not ShowColumns) and FullyExpanded then
        FView.FHRange := -1;

    with FOwner.FView do
    begin
      FVisUpdated := True;
      FClearVis := True;
      FClearAll := True;
      FRangeUpdate := True;
      FOwner.FUpdated := True;
    end;
    FOwner.IsUpdating := False;
  end;  { if }
end;  { SetMultiline }

procedure TElXTreeItem.ReRenderMainText;
var
  AText: TLMDString;
  MaxWidth: integer;
begin
  if csLoading in FOwner.ComponentState then
    Exit;
  if ((FBoolData and ibfIsHTML) <> ibfIsHTML) then
    Exit;
  if Assigned(Cells[FOwner.FMainTreeColumn]) then
  begin
    ReRenderCellText(FOwner.FMainTreeColumn);
  end
  else
  begin
    AText := Text;
    MaxWidth := 0;
    if WordWrap then
    begin
      if FOwner.ShowColumns and (FOwner.HeaderSections.Count > FOwner.FMainTreeColumn) then
        MaxWidth := FOwner.HeaderSections[FOwner.FMainTreeColumn].Width
      else
        MaxWidth := FOwner.Width;
    end;
    if IndentAdjust <> 0 then
      Dec(MaxWidth, IndentAdjust);
    if (FOwner.ShowRoot and FOwner.ShowLines) or (FOwner.ShowButtons and FOwner.ShowRootButtons) then
      Dec(MaxWidth, FOwner.ItemIndent)
    else
      Dec(MaxWidth, FOwner.ItemIndent div 5);
    if FHTMLData <> nil then
       FOwner.FView.FRender.DestroyData(FHTMLData);
    if (AText = '') or not LMDIsHTMLText(AText) then
       FHTMLData := nil
    else
    begin
      FHTMLData := FOwner.FView.FRender.CreateData;

      FHTMLData.DefaultColor := FOwner.TextColor;
      if UseOwnStyle then
      begin
        FHTMLData.DefaultStyle := Style.FontStyles;
        FHTMLData.DefaultFont := Style.FontName;
//        FHTMLData.DefaultHeight:= Style.FontSize;
        FHTMLData.DefaultHeight := -MulDiv(Style.FontSize, Screen.PixelsPerInch, 72);
        if not Style.ParentColors then
          FHTMLData.DefaultColor := Style.TextColor;
      end
      else
      begin
        FHTMLData.DefaultStyle := FOwner.Font.Style;
        FHTMLData.DefaultFont  := FOwner.Font.Name;
        FHTMLData.DefaultHeight:= FOwner.Font.Height;
      end;
      FHTMLData.Charset := FOwner.Font.Charset;
      FHTMLData.LinkStyle := FOwner.LinkStyle;
      FHTMLData.LinkColor := FOwner.LinkColor;
      FOwner.FView.FRender.PrepareToData(AText, MaxWidth, WordWrap and Multiline, FHTMLData);
    end;
  end;
end;

procedure TElXTreeItem.ReRenderCellText(ColNum: Integer);
var i: Integer;
    FData: TLMDHTMLData;
    MaxWidth: integer;
begin
  if csLoading in FOwner.ComponentState then
    Exit;
  if ((FBoolData and ibfIsHTML) <> ibfIsHTML) then
    Exit;
  if not Assigned(FHTMLDataArray) then
  begin
    FHTMLData := nil;
    FHTMLDataArray := TLMDArray.Create;
    FHTMLDataArray.OnDelete := OnHTMLDataDestroy;
  end;
  if FOwner.VirtualityLevel = vlNone then
  begin
    if LMDIsHTMLText(Cells[ColNum].Text) then
    begin
      if FHTMLDataArray.Count <= ColNum then
      for i := FHTMLDataArray.Count to ColNum do
        FHTMLDataArray[i] := FOwner.FView.FRender.CreateData;
      FData := TLMDHTMLData(FHTMLDataArray[ColNum]);
      MaxWidth := 0;
      if WordWrap then
      begin
        if FOwner.ShowColumns and (FOwner.HeaderSections.Count > ColNum) then
          MaxWidth := FOwner.HeaderSections[ColNum].Width
        else
          MaxWidth := FOwner.Width;
      end;
      if (ColNum = FOwner.MainTreeColumn) then
      begin
        if WholeLine then
          MaxWidth := FOwner.Header.SectionsWidth - FOwner.HeaderSections[ColNum].Left;
        if (FOwner.ShowRoot and FOwner.ShowLines) or (FOwner.ShowButtons and FOwner.ShowRootButtons) then
          Dec(MaxWidth, (FOwner.ItemIndent) * (Level + 1) + FOwner.ItemIndent div 5 + 1)
        else
          Dec(MaxWidth, ((FOwner.ItemIndent div 5) + 2) * (Level + 1) + 1);
      end;
      if IndentAdjust <> 0 then
        Dec(MaxWidth, IndentAdjust);
      if FOwner.FHorizontalLines then
        dec(MaxWidth, FDivLineWidth*2);

      FData.DefaultColor := FOwner.TextColor;
      if Cells[ColNum].UseOwnStyle and Assigned(Cells[ColNum].Style) then
      begin
        FData.DefaultStyle := Cells[ColNum].Style.FontStyles;
        FData.DefaultFont := Cells[ColNum].Style.FontName;
//        FData.DefaultHeight:= Cells[ColNum].Style.FontSize;
        FData.DefaultHeight:= -MulDiv(Cells[ColNum].Style.FontSize, Screen.PixelsPerInch, 72);
        if not Cells[ColNum].Style.ParentColors then
          FData.DefaultColor := Cells[ColNum].Style.TextColor;
      end
      else
      begin
        FData.DefaultStyle := FOwner.Font.Style;
        FData.DefaultFont  := FOwner.Font.Name;
        FData.DefaultHeight:= FOwner.Font.Height;
      end;

      FData.Charset := FOwner.Font.Charset;
      FData.LinkStyle := FOwner.LinkStyle;
      FData.LinkColor := FOwner.LinkColor;
      FOwner.FView.FRender.PrepareToData(Cells[ColNum].Text, MaxWidth, WordWrap and Multiline, FData);
    end;
  end;
end;

procedure TElXTreeItem.ReRenderAllTexts;
var i: Integer;
begin
  if csLoading in FOwner.ComponentState then
    Exit;
  if ((FBoolData and ibfIsHTML) <> ibfIsHTML) then
    Exit;
  if Assigned(FHTMLDataArray) then
    FHTMLDataArray.Clear
  else
  begin
    FHTMLData := nil;
    FHTMLDataArray := TLMDArray.Create;
    FHTMLDataArray.OnDelete := OnHTMLDataDestroy;
  end;
  if FOwner.VirtualityLevel = vlNone then
  begin
    for i := 0 to Cells.Count - 1 do
    begin
      ReRenderCellText(i);
    end;
  end;
end;

procedure TElXTreeItem.OnHTMLDataDestroy(Sender :TObject; Item: TLMDDataTag);
var FData: TLMDHTMLData;
begin
  FData := TLMDHTMLData(Item);
  if FOwner <> nil then
     FOwner.FView.FRender.DestroyData(FData)
  else
     FreeAndNil(FData);
end;

procedure TElXTreeItem.SetIsHTML(newValue: Boolean);
begin
  if (((FBoolData and ibfIsHTML) = ibfIsHTML) <> newValue) then
  begin
    if newValue then
      FBoolData := FBoolData or ibfIsHTML
    else
      FBoolData := FBoolData and not ibfIsHTML;

    FComplexHeight := (FComplexHeight and $FFFF0000) or WORD(-1);
    if NewValue then
    begin
      if FStaticDataEx <> nil then
        with FStaticDataEx do
        FBoolData1 := FBoolData1 or ibfHintIsHTML;
//      if FOwner.FUpdateCount = 0 then
      begin
        if not Assigned(FHTMLDataArray) then
        begin
          FHTMLData := nil;
          FHTMLDataArray := TLMDArray.Create;
          FHTMLDataArray.OnDelete := OnHTMLDataDestroy;
        end;
        if not FOwner.FShowColumns then
          ReRenderMainText
        else
          ReRenderAllTexts;
      end;
    end
    else
    begin
      if FHTMLData <> nil then
      begin
        if FOwner <> nil then
           FOwner.FView.FRender.DestroyData(FHTMLData)
        else
           FHTMLData.Free;
      end;
      FHTMLData := nil;
      FreeAndNil(FHTMLDataArray);
    end;

    if newValue then
      Inc(FOwner.TotalVarHeightCount)
    else
      Dec(FOwner.TotalVarHeightCount);

    if not (csDestroying in FOwner.ComponentState) then
    begin
      FOwner.IsUpdating := True;
      with FOwner do
        if (not ShowColumns) and FullyExpanded then
          FView.FHRange := -1;
      with FOwner.FView do
      begin
        FVisUpdated := True;
        FClearVis := True;
        FClearAll := True;
        FRangeUpdate := True;
        FOwner.FUpdated := True;
      end;
      FOwner.IsUpdating := False;
    end;
  end;  { if }
end;

function TElXTreeItem.GetAncestor: TElXTreeItem;
begin
  Result := Self;
  while Result.Parent <> nil do
    Result := Result.Parent;
end;

function TElXTreeItem.CalcSubItemsHeight: Integer;
var
  Item: TElXTreeItem;
  i: Integer;
begin
  Result := 0;
  if Expanded and (FChildren <> nil) then
  begin
    for i := 0 to FChildren.Count - 1 do
    begin
      Item := TElXTreeItem(FChildren[i]);
      if Item.Hidden then
        Continue;
      Inc(Result, Item.Height);
      if Item.Expanded then
        Inc(Result, Item.CalcSubItemsHeight);
    end;
  end;
end;

{
procedure TElXTreeItem.SetStrikedOutLine(const Value: Boolean);
var
  i: Integer;
begin
  for i := 0 to Cells.Count - 1 do
    if Cells[i].UseOwnStyle then
      Cells[i].Style.StrikedOutLine := Value;
  if FStaticDataEx <> nil then with FStaticDataEx do
  begin
    if (((FBoolData1 and ibfStrikedOutLine) <> 0) <> Value) then
    begin
      if Value then
        FBoolData1 := FBoolData1 or ibfStrikedOutLine
      else
        FBoolData1 := FBoolData1 and not ibfStrikedOutLine;
      UpdateItem;
    end;
  end;
end;

function TElXTreeItem.GetStrikedOutLine: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := ((FStaticDataEx.FBoolData1 and ibfStrikedOutLine) = ibfStrikedOutLine)
  else
    Result := False;
end;
}

procedure TElXTreeItem.SetDrawHLine(const Value: Boolean);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (((FBoolData1 and ibfDrawHLine) <> 0) <> Value) then
    begin
      if Value then
        FBoolData1 := FBoolData1 or ibfDrawHLine
      else
        FBoolData1 := FBoolData1 and not ibfDrawHLine;

      UpdateItem;
    end;
  end;
end;

procedure TElXTreeItem.SetAllowEdit(const Value: Boolean);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (((FBoolData1 and ibfAllowEdit) <> 0) <> Value) then
    begin
      if Value then
        FBoolData1 := FBoolData1 or ibfAllowEdit
      else
        FBoolData1 := FBoolData1 and not ibfAllowEdit;
    end;
  end;
end;

procedure TElXTreeItem.NewStaticData;
begin
  if Assigned(FStaticData) then
    Exit;

  New(FStaticData);
  FillChar(FStaticData^, sizeof(TElXTreeItemStaticData), 0);

  if UseOwnStyle then
    CreateStyle;
end;

procedure TElXTreeItem.CreateStyle;
begin

  with FStaticData^ do

  begin
    FCellStyle := TElXCellStyle.Create(Self, nil);
    FCellStyle.IsUpdating := True;
    FCellStyle.Assign(FOwner.Style);
    FCellStyle.IsUpdating := False;
  end;
end;

procedure TElXTreeItem.DisposeStaticData;
begin
  if not Assigned(FStaticData) then
    Exit;

    if Assigned(FStaticData^.FCellStyle) then
      FreeAndNil(FStaticData^.FCellStyle);

  Dispose(FStaticData);
  FStaticData := nil;
  end;

procedure TElXTreeItem.FillStaticData;
begin
//
end;

procedure TElXTreeItem.NewStaticDataEx;
begin
  if Assigned(FStaticDataEx) then
    Exit;

  FStaticDataEx :=  TElXTreeItemStaticDataEx.Create;
  with FStaticDataEx do
  begin
    FBoolData1 := {ibfParentColors or} ibfParentStyle {or ibfCheckBoxEnabled or ibfShowCheckbox} or
      ibfEnabled or ibfUseBackGroundColor or ibfDrawHLine {or ibfAllowSelection }or ibfAllowEdit;
    FImageIndex := -1;
    FStImageIndex := -1;
    FImageIndex2 := -1;
    FStImageIndex2 := -1;
    FOverlayIndex := -1;
    FOverlayIndex2 := -1;
    FCheckBoxState := cbUnchecked;
    FCheckBoxType := ectCheckBox;
  end;
end;

procedure TElXTreeItem.DisposeStaticDataEx;
begin
  if Assigned(FStaticDataEx) then
    FreeAndNil(FStaticDataEx);
end;

function TElXTreeItem.GetText: TLMDString;
begin
  Result := '';
  if (FOwner.FVirtualityLevel > vlNone) and (not (csDesigning in FOwner.ComponentState)) then
      FOwner.TriggerVirtualTextNeeded(Self, FOwner.FMainTreeColumn, Result)
  else
  begin
    if Assigned(Cells) and (Cells.Count > Owner.FMainTreeColumn) then
      Result := Cells[Owner.FMainTreeColumn].FText
    else
      if FStaticData <> nil then
        Result := FStaticData.FText;
  end;
end;

function TElXTreeItem.GetHint: TLMDString;
begin
  if (FOwner.FVirtualityLevel = vlNone) and (FStaticData <> nil) then
    Result := FStaticData.FHint
  else
    if (not (csDesigning in FOwner.ComponentState)) then
      FOwner.TriggerVirtualHintNeeded(Self, Result)
    else
      Result := '';
end;

procedure TElXTreeItem.SetHint(Value: TLMDString);
begin
  if FStaticData <> nil then
    FStaticData.FHint := Value;
end;

function TElXTreeItem.GetStyle: TElXCellStyle;
begin
  if (FOwner.FVirtualityLevel > vlNone) and (not (csDesigning in FOwner.ComponentState)) then
  begin
    if not Assigned(FVirtStyle) then
    begin
      FVirtStyle := TElXCellStyle.Create(Self,nil);
      FOwner.TriggerVirtualStyleNeeded(Self,-1,FVirtStyle);
    end;
    Result := FVirtStyle;
  end
  else
  begin
    if FStaticData <> nil then
      Result := FStaticData.FCellStyle
    else
      Result := nil;
  end;
end;

function TElXTreeItem.GetCurrentStyle: TElXCellStyleRead;
begin
  if (FOwner.FVirtualityLevel > vlNone) and (not (csDesigning in FOwner.ComponentState)) then
  begin
    if not UseOwnStyle then
    begin
      if Parent <> nil then
        Result := Parent.CurrentStyle
      else
        Result := (Owner as TCustomElXTree).Style
    end
    else
    begin
      if not Assigned(FVirtStyle) then
      begin
        FVirtStyle := TElXCellStyle.Create(Self,nil);
        FOwner.TriggerVirtualStyleNeeded(Self,-1,FVirtStyle);
      end;
      Result := FVirtStyle;
    end;
  end
  else
  begin
    if not UseOwnStyle then
    begin
      if Parent <> nil then
        Result := Parent.CurrentStyle
      else
        Result := (Owner as TCustomElXTree).Style
    end
    else
      Result := Style;
  end;
end;

//procedure TElXTreeItem.SetBorderStyle(Value: TElItemBorderStyle);
//begin
//  if FStaticDataEx <> nil then
//  with FStaticDataEx do
//  begin
//    if FBorderStyle <> Value then
//    begin
//      FBorderStyle := Value;
//      UpdateItem;
//    end;
//  end;
//end;

function TElXTreeItem.GetWidth: Integer;
var
  Size: TPoint;
begin
  FOwner.MeasureCell(Self, -1, FOwner.FView.ClientWidth, Size);
  Result := Size.x;
end;

function TElXTreeItem.GetDrawHLine: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := (FStaticDataEx.FBoolData1 and ibfDrawHLine) = ibfDrawHLine
  else
    result := False;
end;

{
function TElXTreeItem.GetAllowSelection: Boolean;
begin
  Result := (FBoolData1 and ibfAllowSelection) = ibfAllowSelection;
end;

procedure TElXTreeItem.SetAllowSelection(Value: Boolean);
begin
  if Value then
    FBoolData1 := FBoolData1 or ibfAllowSelection
  else
    FBoolData1 := FBoolData1 and not ibfAllowSelection;
end;
}

function TElXTreeItem.GetAllowEdit: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := (FStaticDataEx.FBoolData1 and ibfAllowEdit) = ibfAllowEdit
  else
    Result := True;
end;
{
function TElXTreeItem.GetParentStyle: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := (FStaticDataEx.FBoolData1 and ibfParentStyle) = ibfParentStyle
  else
    Result := False;
end;
}

function TElXTreeItem.GetUseBackGroundColor: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := (FStaticDataEx.FBoolData1 and ibfUseBackGroundColor) = ibfUseBackGroundColor
  else
    Result := False;
end;

//function TElXTreeItem.GetParentColors: Boolean;
//begin
//  if FStaticDataEx <> nil then
//    Result := (FStaticDataEx.FBoolData1 and ibfParentColors) = ibfParentColors
//  else
//    Result := False;
//end;

function TElXTreeItem.GetForceButtons: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := (FStaticDataEx.FBoolData1 and ibfForceButtons) = ibfForceButtons
  else
    Result := False;
end;

function TElXTreeItem.GetSuppressButtons: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := ((FStaticDataEx.FBoolData1 and ibfSuppressButtons) = ibfSuppressButtons) and
            ((Level > 0) or (FOwner.ShowRootButtons))
  else
    Result := False;
end;

function TElXTreeItem.GetSuppressLines: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := ((FStaticDataEx.FBoolData1 and ibfSuppressLines) = ibfSuppressLines) and
            ((Level > 0) or (FOwner.ShowRoot))
  else
    Result := False;
end;

function TElXTreeItem.GetIsHTML: Boolean;
begin
  Result := (FBoolData and ibfIsHTML) = ibfIsHTML;
end;

function TElXTreeItem.GetMultiline: Boolean;
begin
  Result := (FBoolData and ibfMultiline) = ibfMultiline;
end;

function TElXTreeItem.GetShowCheckBox: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := (FStaticDataEx.FBoolData1 and ibfShowCheckbox) = ibfShowCheckbox
  else
    Result := False;
end;

function TElXTreeItem.GetCheckBoxEnabled: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := (FStaticDataEx.FBoolData1 and ibfCheckboxEnabled) = ibfCheckboxEnabled
  else
    Result := False;
end;

function TElXTreeItem.GetEnabled: Boolean;
begin
  Result := (FBoolData and ibfEnabled) = ibfEnabled;
end;

function TElXTreeItem.GetHidden: Boolean;
begin
  Result := (FBoolData and ibfHidden) = ibfHidden;
end;

procedure TElXTreeItem.CheckHidden;
var
  LHidden: Boolean;
begin
  LHidden := Hidden;
  FOwner.TriggerApplyVisFilterEvent(Self, LHidden);
  Hidden := LHidden;
end;

procedure TElXTreeItem.SetIndentAdjust(Value: Integer);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if IndentAdjust <> Value then
    begin
      FIndentAdjust := Value;
      with FOwner do
      begin
        if ShowColumns then
           AutoSizeColumn(FMainTreeColumn)
        else
           FColumnSizeUpdate := True;
        if (not ShowColumns) and FullyExpanded then
          if FUpdateCount > 0 then
            FView.FHRange := -1
          else
            FView.DefineHRange;
      end;
      UpdateItem;
    end;
  end;
end;

function TElXTreeItem.DisplayRect(TextOnly: Boolean): TRect;
begin
  if not FOwner.IsInView(Self) then
  begin
    SetRectEmpty(Result);
    Exit;
  end;
  Result := FOwner.GetItemRect(FOwner.IndexInView(Self));
  if TextOnly then
  begin
    Result.Left := FTextRect.Left;
    Result.Right := FTextRect.Right;
  end;
end;

procedure TElXTreeItem.EndEdit(ByCancel: Boolean);
begin
  FOwner.EndEdit(ByCancel);
end;

function TElXTreeItem.HasAsParent(Item: TElXTreeItem): Boolean;
begin
  Result := IsUnder(Item);
end;

function TElXTreeItem.IndexOf(Item: TElXTreeItem): Integer;
begin
  if Item.IsUnder(Self) then
    Result := Item.Index
  else
    Result := -1;
end;

procedure TElXTreeItem.MakeVisible;
begin
  FOwner.EnsureVisible(Self);
end;

function TElXTreeItem.GetDropTarget: Boolean;
begin
  Result := FOwner.DropTarget = Self;
end;

function TElXTreeItem.GetHintIsHTML: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := (FStaticDataEx.FBoolData1 and ibfHintIsHTML) = ibfHintIsHTML
  else
    Result := (FBoolData and ibfIsHTML) = ibfIsHTML;
end;

procedure TElXTreeItem.SetHintIsHTML(Value: Boolean);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (((FBoolData1 and ibfHintIsHTML) <> 0) <> Value) then
    begin
      if Value then
        FBoolData1 := FBoolData1 or ibfHintIsHTML
      else
        FBoolData1 := FBoolData1 and not ibfHintIsHTML;
    end;
  end;
end;

function TElXTreeItem.GetTextDim(Index: Integer): Integer;
begin
  case Index of
    1: Result := FTextRect.Top;
    2: Result := FTextRect.Right;
    3: Result := FTextRect.Bottom;
    else Result := FTextRect.Left;
  end;
end;

procedure TElXTreeItem.SetIndex(Value: Integer);
begin
  if Value <> index then
  begin
    if (Value < 0) or (Value > FParent.Count - 1) then
      raise EElTreeError.Create(STExOutOfBounds);
    MoveToIns(Parent, Value);
  end;
end;

{
function TElXTreeItem.GetColor(Index: TElXTreeCellColorType): TColor;
begin
// raise Exception.Create('Obsoleted');
  if FStaticDataEx <> nil then
    with FStaticDataEx do
  begin
    case TElXTreeCellColorType(Index) of
      cctTextColor: Result := FTextColor;
      cctTextBackGroundColor: Result := FBackGroundColor;
      cctCellBackGroundColor: Result := FBackGroundColor;
//      cctRowBackGroundColor: Result := FRowBackGroundColor;
      cctBorderSpaceColor: Result := FBorderSpaceColor;
      cctStrikedLineColor: Result := FStrikedLineColor;
      else
        Result := clBlack;
    end;
  end
  else
    Result := clBlack;
end;
}

function TElXTreeItem.GetImageIndex(Index: Integer): Integer;
begin
  if FStaticDataEx <> nil then
    case Index of
      0: Result := FStaticDataEx.FImageIndex;
      1: Result := FStaticDataEx.FImageIndex2;
      2: Result := FStaticDataEx.FStImageIndex;
      3: Result := FStaticDataEx.FStImageIndex2;
      4: begin
           Result := FStaticDataEx.FOverlayIndex;
           if (Result < 0) or (Result > 3) then
             Result := -1;
         end;
      5: begin
           Result := FStaticDataEx.FOverlayIndex2;
           if (Result<0)or(Result>3) then
             Result := -1;
         end;
      else
        Result := -1;
    end
  else
    Result := -1;
end;

function TElXTreeItem.GetCheckBoxState: TCheckBoxState;
begin
  if FStaticDataEx <> nil then
    Result := FStaticDataEx.FCheckBoxState
  else
    Result := cbUnchecked;
end;

function TElXTreeItem.GetCheckBoxType: TElCheckBoxType;
begin
  if FStaticDataEx <> nil then
    Result := FStaticDataEx.FCheckBoxType
  else
    Result := ectCheckbox;
end;

function TElXTreeItem.GetIndentAdjust: Integer;
begin
  if FStaticDataEx <> nil then
    Result := FStaticDataEx.FIndentAdjust
  else
    Result := 0;
end;

//function TElXTreeItem.GetBorderStyle: TElItemBorderStyle;
//begin
//  if FStaticDataEx <> nil then
//    Result := FStaticDataEx.FBorderStyle
//  else
//    Result := ibsNone;
//end;

function TElXTreeItem.GetFocused: Boolean;
begin
  Result := (FBoolData and ibfFocused) <> 0;
end;

procedure TElXTreeItem.SetFocused(Value: Boolean);
begin
  if (value = False) then
  begin
    if FOwner.ItemFocused = Self then
       FOwner.ItemFocused := nil;
  end
  else
     FOwner.ItemFocused := self;
end;

{procedure TElXTreeItem.UpdateInfo(PropTypes: TElVirtPropTypes);
var UpdItem: Boolean;
    UpdCache: Boolean;
begin
  if (FOwner <> nil) and (FOwner.FVirtualityLevel > vlNone) then
  begin
    UpdItem := False;
    UpdCache:= False;
    FOwner.IsUpdating := True;

    try
      if vptMainText in PropTypes then
        UpdateChangedMainText;

      if vptCellText in PropTypes then
      begin
        UpdateChangedCellText(-2);
        UpdItem := True;
      end;

      if vptStyles in PropTypes then
      begin
        if (FOwner.FVirtualityLevel >= vlAllProps) and (not (csDesigning in FOwner.ComponentState)) then
          UpdCache := True
        else
        //if FStaticDataEx.UseStyles then
          UpdItem := True;
      end;

      if (FOwner.FVirtualityLevel >= vlAllProps) and (not (csDesigning in FOwner.ComponentState)) then
        if (PropTypes * [vptFontStyle, vptVisual, vptSelection, vptCheck, vptButtons, vptImages, vptColors, vptIndent]) <> [] then
          UpdCache := True;

      if vptFontStyle in PropTypes then
      begin
        if (not FOwner.ShowColumns) and FullyExpanded then
          FOwner.FView.FHRange := -1;
      end;

      if vptVisual in PropTypes then
        UpdItem := True;

      if vptSelection in PropTypes then
        UpdItem := True;

      if vptCheck in PropTypes then
      begin
        FOwner.FColumnSizeUpdate := True;
        if (not FOwner.ShowColumns) and FullyExpanded then
          FOwner.FView.FHRange := -1;
        UpdItem := True;
      end;

      if vptButtons in PropTypes then
      begin
        with FOwner do
        begin
          FColumnSizeUpdate := True;
          if (not ShowColumns) and FullyExpanded then
            FView.FHRange := -1
        end;
        UpdItem := True;
      end;

      if vptImages in PropTypes then
      begin
        with FOwner do
          if FShowImages then
          begin
            FColumnSizeUpdate := True;
            if (not ShowColumns) and FullyExpanded then
              FView.FHRange := -1;
          end;
        UpdItem := True;
      end;

      if vptColors in PropTypes then
        UpdItem := True;

      if vptIndent in PropTypes then
      begin
        with FOwner do
        begin
          FColumnSizeUpdate := True;
          if (not ShowColumns) and FullyExpanded then
            FView.FHRange := -1;
        end;
        UpdItem := True;
      end;

      if (FOwner.FVirtualityLevel >= vlAllProps) and (not (csDesigning in FOwner.ComponentState)) and UpdCache then
      begin
        if FStaticDataEx <> nil then
          FOwner.TriggerVirtualPropsNeeded(Self, PropTypes, FStaticDataEx);
      end;

      if UpdItem then
        UpdateItem;
    finally
      FOwner.IsUpdating := False;
    end;
  end;
end; }

procedure TElXTreeItem.UpdateChangedMainText;
begin
  with FOwner do
  begin
    if (not ShowColumns) and FullyExpanded then
    begin
      if FUpdateCount > 0 then
        FView.FHRange := -1
      else
        FView.DefineHRange;
      FView.FRangeUpdate := True;
      FOwner.FUpdated := True;
    end;
    if (FSortMode = smAdd) or (FSortMode = smAddClick) then
    begin
      if (FMainTreeColumn = FSortSection) or (FSortSection = -1) then
      begin
        if FUpdateCount > 0 then
           FSortRequired := True
        else
        begin
          FOwner.TriggerSortBegin;
          FParent.Sort(False);
          FOwner.TriggerSortBegin;
        end;
      end;
    end;
    if ShowColumns and (FUpdateCount = 0) then
       AutoSizeColumn(FMainTreeColumn)
    // bug fix
    else
    if ShowColumns then
    begin
      FOwner.FUpdated := True;
      FOwner.FColumnSizeUpdate := True;
    end;
  end;

  if (FOwner.FUpdateCount = 0) and ((Multiline and FOwner.AdjustMultilineHeight) or IsHTML)
  then
  begin
    if IsHTML then
      ReRenderMainText;
    FComplexHeight := (FComplexHeight and $FFFF0000) or WORD(-1);
    //FRealHeight := -1;

    with FOwner.FView do
    begin
      FVisUpdated := True;
      FClearVis := True;
      FClearAll := True;
      FRangeUpdate := True;
    end;
  end;
end;

procedure TElXTreeItem.UpdateChangedCellText(CellIndex: integer);
begin
  with FOwner do
  if ((FSortMode = smAdd) or (FSortMode = smAddClick)) and (CellIndex = FSortSection) then
  begin
    if LMDInRange(FSortSection, -1, FHeader.Sections.Count - 1) then
    begin
      if FParent <> nil then
      begin
        if FUpdateCount > 0 then
           FSortRequired := True
        else
        begin
          FOwner.TriggerSortBegin;
          FParent.Sort(False);
          FOwner.TriggerSortBegin;
        end;
      end;
    end;
  end;
end;

procedure TElXTreeItem.AllocateStorage(MaxItems: Integer);
begin
  if FChildren = nil then
    FChildren := TLMDObjectList.Create;
  FChildren.Capacity := max(FChildren.Capacity, MaxItems);
end;

procedure TElXTreeItem.NewVirtualSort;
begin
  with FOwner do
  begin
    if (FSortMode = smAdd) or (FSortMode = smAddClick) then
    begin
      if (FMainTreeColumn = FSortSection) or (FSortSection = -1) then
      begin
        if FUpdateCount > 0 then
           FSortRequired := True
        else
        begin
          TriggerSortBegin;
          Self.FParent.Sort(False);
          TriggerSortBegin;
        end;
      end;
    end;
  end;
end;

function TElXTreeItem.IsFirstChild: Boolean;
begin
  Result := Self = FParent.FChildren.First;
end;

function TElXTreeItem.GetHTMLControlByName(aControlName: TLMDString): TControl;
var
  i: integer;
  LControl: TControl;
  lData: TLMDHTMLData;
  lFound: boolean;
begin
  result := nil;
  lFound := false;
  if IsHTML then
  begin
    LControl := nil;
    if FHTMLData <> nil then
    begin
      LData := FHTMLData;
      if not LData.ControlsArray.IsEmpty then
      begin
        LData.ControlsArray.First;
        repeat
          LControl := TLMDHTMLControlItem(LData.ControlsArray.Item).Control;
          LData.ControlsArray.Next;
          lFound := (LControl.Name = aControlName);
        until (LData.ControlsArray.IsLast) or lFound;
      end;
    end
    else
    for i := 0 to FHTMLDataArray.Count - 1 do
    begin
      LData := TLMDHTMLData(FHTMLDataArray[i]);
      if LData <> nil then
        if not LData.ControlsArray.IsEmpty then
        begin
          LData.ControlsArray.First;
          if not LData.ControlsArray.IsEmpty then
          repeat
            LControl := TLMDHTMLControlItem(LData.ControlsArray.Item).Control;
            LData.ControlsArray.Next;
            lFound := (LControl.Name = aControlName);
          until (LData.ControlsArray.IsLast) or lFound;
          if lFound then
            break;
        end;
    end;
    if lFound then
      result := LControl;
  end;
end;

procedure TElXTreeItem.HideHTMLControls;
var
  i: integer;
  LControl: TControl;
  lData: TLMDHTMLData;
begin
  if IsHTML then
  begin
    if FHTMLData <> nil then
    begin
      LData := FHTMLData;
      if not LData.ControlsArray.IsEmpty then
      begin
        LData.ControlsArray.First;
        repeat
          if LData.ControlsArray.Item is TLMDHTMLControlItem then
          begin
            LControl := TLMDHTMLControlItem(LData.ControlsArray.Item).Control;
            if Assigned(LControl) then
              LControl.Visible := false;
          end;
          LData.ControlsArray.Next;
        until (LData.ControlsArray.IsLast);
      end;
    end
    else
    for i := 0 to FHTMLDataArray.Count - 1 do
    begin
      LData := TLMDHTMLData(FHTMLDataArray[i]);
      if LData <> nil then
        if not LData.ControlsArray.IsEmpty then
        begin
          LData.ControlsArray.First;
          if not LData.ControlsArray.IsEmpty then
          repeat
            if LData.ControlsArray.Item is TLMDHTMLControlItem then
            begin
              LControl := TLMDHTMLControlItem(LData.ControlsArray.Item).Control;
              if Assigned(LControl) then
                LControl.Visible := false;
            end;
            LData.ControlsArray.Next;
          until (LData.ControlsArray.IsLast);
        end;
    end;
  end;
end;

function TElXTreeItem.IsLastChild: Boolean;
begin
  Result := Self = FParent.FChildren.Last;
end;

procedure TElXTreeItem.SetWordWrap(AWrap: Boolean);
var
  LTree: TCustomElXTree;
  LView: TElXTreeView;
begin
  if (((FBoolData and ibfWordWrap) = ibfWordWrap) <> AWrap) then
  begin
    if AWrap then
      FBoolData := FBoolData or ibfWordWrap
    else
      FBoolData := FBoolData and not ibfWordWrap;

    LTree := FOwner;
    LView := LTree.View;

    if Multiline then
    begin
      LTree.IsUpdating := True;
      if not LTree.ShowColumns and FullyExpanded then
      begin
        if LTree.FUpdateCount > 0 then
          LView.FHRange := -1
        else
          LView.DefineHRange;
        LView.FRangeUpdate := True;
        LTree.FUpdated := True;
      end;
      if LTree.ShowColumns then
      begin
        LTree.FUpdated := True;
        LTree.FColumnSizeUpdate := True;
      end;

      if Multiline and LTree.AdjustMultilineHeight or IsHTML then
      begin
        FComplexHeight := (FComplexHeight and $FFFF0000) or Word(-1);
        if ((FBoolData and ibfIsHTML) = ibfIsHTML) and (FOwner.FUpdateCount = 0) then
          ReRenderAllTexts;
          LView.FVisUpdated := True;
          LView.FClearVis := True;
          LView.FClearAll := True;
          LView.FRangeUpdate := True;
      end;
      LTree.IsUpdating := False;
    end;
  end;
end;

function TElXTreeItem.GetWordWrap: Boolean;
begin
  Result := (FBoolData and ibfWordWrap) = ibfWordWrap;
end;

function TElXTreeItem.GetWholeLine: Boolean;
begin
  Result := (FBoolData and ibfWholeLine) = ibfWholeLine;
end;

procedure TElXTreeItem.SetWholeLine(Value: Boolean);
begin
  if (((FBoolData and ibfWholeLine) = ibfWholeLine) <> Value) then
  begin
    if Value then
      FBoolData := FBoolData or ibfWholeLine
    else
      FBoolData := FBoolData and not ibfWholeLine;

    if FOWner.ShowColumns then
    with FOwner do
    begin
      IsUpdating := True;

      if (FUpdateCount = 0) then
         AutoSizeColumn(FMainTreeColumn)
      else
      if ShowColumns then
      begin
        FOwner.FUpdated := True;
        FOwner.FColumnSizeUpdate := True;
      end;

      if Multiline then
        FComplexHeight := (FComplexHeight and $FFFF0000) or WORD(-1);

      if (Multiline and FOwner.AdjustMultilineHeight)
          or IsHTML
          then
      begin
        if IsHTML then
          ReRenderMainText;
        FComplexHeight := (FComplexHeight and $FFFF0000) or WORD(-1);
        //FRealHeight := -1;

        with FOwner.FView do
        begin
          FVisUpdated := True;
          FClearVis := True;
          FClearAll := True;
          FRangeUpdate := True;
        end;
      end;
      IsUpdating := False;
    end;
  end;
end;

function TElXTreeItem.GetBoolStaticDataEx(const Index: Integer): Boolean;
begin
  Result := Assigned(FStaticDataEx) and ((FStaticDataEx.FBoolData1 and Index) = Index);
end;

procedure TElXTreeItem.SetBoolStaticDataEx(const Index: Integer;
  const Value: Boolean);
begin
  if Assigned(FStaticDataEx) then
    if Value then
      FStaticDataEx.FBoolData1 := FStaticDataEx.FBoolData1 or Index
    else
      FStaticDataEx.FBoolData1 := FStaticDataEx.FBoolData1 and not Index;
end;

{
function TElXTreeItem.GetBoolData(const Index: Integer): Boolean;
begin
  Result := (FBoolData and Index) = Index;
end;
}

{
procedure TElXTreeItem.SetBoolData(const Index: Integer;
  const Value: Boolean);
begin
    if Value then
      FBoolData := FBoolData or Index
    else
      FBoolData := FBoolData and not Index;
end;
}

{procedure TElXTreeItem.CreateCells;
var
  i: Integer;
  LHeaderSections: TElXHeaderSections;
//  LCell: TElXTreeCell;
begin
  LHeaderSections := GetHeaderSections;
  if Assigned(LHeaderSections) then
    for i := 0 to LHeaderSections.Count - 1 do
    begin
//      LCell := FCells[i];
      if not Assigned(FCells[i]) then
        FCells.Add;
    end;
end;}

{procedure TElXTreeItem.BindCells;
var
  i: Integer;
//  LIndex: Integer;
//  LMainTreeColumn: Integer;
  LHeaderSections: TElHeaderSections;
begin
  LHeaderSections := GetHeaderSections;
//  LMainTreeColumn := FOwner.FMainTreeColumn;
  if Assigned(LHeaderSections) then
    for i := 0 to LHeaderSections.Count  do
    begin
//      if i < LMainTreeColumn then
//        LIndex := i
//      else
//        LIndex := i + 1;
      BindCell(LHeaderSections[i]);
    end;
end;}

function TElXTreeItem.CreateIntermediateCells(AIndex: Integer): TElXTreeCell;
var
  i: Integer;
//  LHeaderSections: TElHeaderSections;
//  LHeaderSection: TElHeaderSection;
begin
  Result := nil;
//  LHeaderSections := GetHeaderSections;
  for i := FCells.Count to AIndex do
  begin
    Result := FCells.Add;
{    if not Assigned(LHeaderSections) then
      Continue;
    LHeaderSection := LHeaderSections[i];
    if Assigned(LHeaderSection) then
      BindCell(LHeaderSection);}
  end;
end;

{procedure TElXTreeItem.BindCell(const AHeaderSection: TElHeaderSection);
var
  LCell: TElXTreeCell;
  LIndex: Integer;
begin
  if not Assigned(AHeaderSection) then
    Exit; // raise Exception.Create('Null AHeaderSection variable passed');
  LIndex := AHeaderSection.Index;
  LCell := FCells[LIndex];
  if not Assigned(LCell) then
    LCell := CreateIntermediateCells(LIndex);
  if Assigned(LCell) then
    LCell.HeaderSection := AHeaderSection;
end;}

// ****************************************************************************
//                               TElXTreeItems
// ****************************************************************************

constructor TElXTreeItems.CreateClass(AOwner: TCustomElXTree; ItemClass: TElXTreeItemClass);
begin
  FItemClass := ItemClass;
  Create(AOwner);
end;

constructor TElXTreeItems.Create(AOwner: TCustomElXTree);
begin
  inherited Create;
  DoInCreate(AOwner);
end;

procedure TElXTreeItems.DoInCreate(AOwner: TCustomElXTree);
begin
  FOwner := AOwner;
  if FItemClass = nil then
    FItemClass := TElXTreeItem;
  FRoot := FItemClass.Create(FOwner);
  FRoot.FList := self;
  FRoot.FParent := nil;
  FRoot.FRoot := FRoot;
  FRoot.NewStaticData;
  FRoot.FBoolData := FRoot.FBoolData or ibfExpanded or ibfEnabled;
end;

destructor TElXTreeItems.Destroy;
begin
  FOwner.IsUpdating := True;
  FRoot.Clear;
  FRoot.DisposeStaticData;
  FreeAndNil(FRoot);
  inherited Destroy;
end;

function TElXTreeItems.GetVisCount: Integer;
begin
  Result := FOwner.TotalVisCount;
end;

procedure TElXTreeItems.DefineProperties(Filer: TFiler);

  function WriteNodes: Boolean;
  begin
    Result := Count > 0;
  end;

begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, WriteNodes);
end;

procedure TElXTreeItems.SetItem(Index: Integer; Value: TElXTreeItem);
begin
  GetItem(Index).Assign(Value);
end;

procedure TElXTreeItems.Iterate(VisibleOnly, CheckCollapsed: Boolean;
  IterateProc: TElXIterateProc; IterateData: TLMDDataTag);
var
  j: Integer;
  DoContinue: Boolean;

  procedure IntIterate(VisibleOnly, CheckCollapsed: Boolean; Item: TElXTreeItem); {<+>}
  var
    i, LChildrenCount: Integer;
  begin
    Inc(j);
    if (j >= 0) and (not VisibleOnly or not Item.Hidden or not FOwner.FilteredVisibility) then
      IterateProc(Item, j, DoContinue, IterateData, FOwner);
    if not DoContinue then
      Exit;
    // check for (not VisibleOnly) removed - it was a error, think of it and you will see :)
    // besides it checked in the condition for the call to IntInterate, that's the right place.
    if CheckCollapsed or Item.Expanded then {<+>}
    begin
      if Item.FChildren = nil then
         LChildrenCount := 0
      else
         LChildrenCount := Item.FChildren.Count;
      for i := 0 to LChildrenCount - 1 do
      begin
        if not VisibleOnly
          or not TElXTreeItem(Item.FChildren.List[i]).Hidden
          or not FOwner.FilteredVisibility
        then
          IntIterate(VisibleOnly, CheckCollapsed, TElXTreeItem(Item.FChildren.List[i])); {<+>}
        if not DoContinue then
          Exit;
      end;
    end;
  end;

begin
  j := -2;
  DoContinue := True;
  IntIterate(VisibleOnly, CheckCollapsed, FRoot);
end;

procedure TElXTreeItems.IterateBranch(VisibleOnly: Boolean;
  IterateProc: TElXIterateProc; IterateData: TLMDDataTag; BranchParent: TElXTreeItem);
var
  j: Integer;
  DoContinue: Boolean;
  Stack: TElStack;
  TSI: TElXTreeItem;

  procedure IntIterate(VisibleOnly: Boolean; Item: TElXTreeItem; StartFrom: TElXTreeItem; var Stack: TElStack);
  var
    i, k, l: Integer;
  begin
    Inc(j);
    if (Stack <> nil) and (Stack.Count > 0) then
    begin
      if Item.FChildren = nil then
         k := -1
      else
         k := Item.FChildren.IndexOf(Stack.Pop);
      if Stack.Count = 0 then
        FreeAndNil(Stack);
    end
    else
    begin
      if not Item.IsUnder(StartFrom) then
         DoContinue := False
      else
        if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or (not FOwner.FilteredVisibility))) then
           IterateProc(Item, j, DoContinue, IterateData, FOwner);
      if not (DoContinue) then
         Exit;
      k := 0;
    end;
    if (not (VisibleOnly)) or (Item.Expanded) then
    begin
      if Item.FChildren = nil then
         l := 0
      else
         l := Item.FChildren.Count;
      if k <> - 1 then
        for i := k to l - 1 do
        begin
          if (not VisibleOnly) or ((not TElXTreeItem(Item.FChildren.List[i]).Hidden) or (not FOwner.FilteredVisibility)) then
              IntIterate(VisibleOnly, TElXTreeItem(Item.FChildren.List[i]), StartFrom, Stack);
          if not DoContinue then
             Exit;
        end;
    end;
  end;

begin
  j := -2;
  if BranchParent <> nil then
  begin
    Stack := TElStack.Create;
    TSI := BranchParent;
    Stack.Push(TSI);
    while TSI.Parent <> nil do
    begin
      Stack.Push(TSI.Parent);
      TSI := TSI.Parent;
    end; // while
    DoContinue := True;
    IntIterate(VisibleOnly, FRoot, BranchParent, Stack);
    FreeAndNil(Stack);
  end
  else
    Iterate(VisibleOnly, not VisibleOnly, IterateProc, IterateData); {<+>}
end;

procedure TElXTreeItems.IterateFrom(VisibleOnly, CheckCollapsed: Boolean;
  IterateProc: TElXIterateProc; IterateData: TLMDDataTag; StartFrom: TElXTreeItem);
var
  j: Integer;
  DoContinue: Boolean;
  Stack: TElStack;
  TSI: TElXTreeItem;

  procedure IntIterate(VisibleOnly, CheckCollapsed: Boolean; Item: TElXTreeItem; StartFrom: TElXTreeItem; var Stack: TElStack); {<+>}
  var
    i, k, l: Integer;
  begin
    Inc(j);
    if (Stack <> nil) and (Stack.Count > 0) then
    begin
      if Item.FChildren = nil then
        k := -1
      else
        k := Item.FChildren.IndexOf(Stack.Pop);
      if Stack.Count = 0 then
        FreeAndNil(Stack);
    end
    else
    begin
      if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or (not FOwner.FilteredVisibility))) then
        IterateProc(Item, j, DoContinue, IterateData, FOwner);
      if not (DoContinue) then
        Exit;
      k := 0;
    end;
    // check for (not VisibleOnly) removed - it was a error, think of it and you will see :)
    // besides it checked in the condition for the call to IntInterate, that's the right place.
    if CheckCollapsed or (Item.Expanded) then
    begin
      if Item.FChildren = nil then
        l := 0
      else
         l := Item.FChildren.Count;
      if k <> - 1 then
        for i := k to l - 1 do
        begin
          if (not VisibleOnly) or ((not TElXTreeItem(Item.FChildren.List[i]).Hidden) or (not FOwner.FilteredVisibility)) then
            IntIterate(VisibleOnly, CheckCollapsed, TElXTreeItem(Item.FChildren.List[i]), StartFrom, Stack);
          if not (DoContinue) then
            Exit;
        end;
    end;
  end;

begin
  j := -2;
  if StartFrom <> nil then
  begin
    Stack := TElStack.Create;
    TSI := StartFrom;
    Stack.Push(TSI);
    while TSI.Parent <> nil do
    begin
      Stack.Push(TSI.Parent);
      TSI := TSI.Parent;
    end; // while
  end
  else
    Stack := nil;
  DoContinue := True;
  IntIterate(VisibleOnly, CheckCollapsed, FRoot, StartFrom, Stack); {<+>}
  if Stack <> nil then
    FreeAndNil(Stack);
end;

procedure TElXTreeItems.IterateBack(VisibleOnly, CheckCollapsed: Boolean;
  IterateProc: TElXIterateProc; IterateData: TLMDDataTag);
var
  j: Integer;
  DoContinue: Boolean;

  procedure IntIterate(VisibleOnly, CheckCollapsed: Boolean; Item: TElXTreeItem);  {<+>}
  var
    i, k: Integer;
  begin
    // check for (not VisibleOnly) removed - it was a error, think of it and you will see :)
    // besides it checked in the condition for the call to IntInterate, that's the right place.
    if CheckCollapsed or (Item.Expanded) then {<+>}
    begin
      if Item.FChildren = nil then
        k := 0
      else
        k := Item.FChildren.Count;
      for i := k - 1 downto 0 do
      begin
        if (not VisibleOnly) or ((not TElXTreeItem(Item.FChildren.List[i]).Hidden) or (not FOwner.FilteredVisibility)) then
           IntIterate(VisibleOnly, CheckCollapsed, TElXTreeItem(Item.FChildren.List[i])); {<+>}
        if not (DoContinue) then
          Exit;
      end;
    end;
    Dec(j);
    if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or (not FOwner.FilteredVisibility))) then
       IterateProc(Item, j, DoContinue, IterateData, FOwner);
    if not (DoContinue) then
      Exit;
  end;

begin
  if VisibleOnly then
     j := FOwner.TotalVisCount
  else
     j := FOwner.FAllList.Count;
  DoContinue := True;
  IntIterate(VisibleOnly, CheckCollapsed, FRoot); {<+>}
end;

// Changed 10/28/98 by EM

procedure TElXTreeItems.IterateBackFrom(VisibleOnly, CheckCollapsed: Boolean;
  IterateProc: TElXIterateProc; IterateData: TLMDDataTag; StartFrom: TElXTreeItem);
var
  j: Integer;
  DoContinue: Boolean;
  Stack: TElStack;
  TSI: TElXTreeItem;

  procedure IntIterate(VisibleOnly, CheckCollapsed: Boolean; Item: TElXTreeItem; StartFrom: TElXTreeItem; var Stack: TElStack); {<+>}
  var
    i, k: Integer;
  begin
    if (Stack <> nil) and (Stack.Count > 0) then
    begin
      if Item.FChildren = nil then
        k := -1
      else
        k := Item.FChildren.IndexOf(Stack.Pop);
      if Stack.Count = 0 then
        FreeAndNil(Stack);
    end
    else
    begin
      if Item.FChildren = nil then
        k := -1
      else
        k := Item.FChildren.Count - 1;
    end;
    // check for (not VisibleOnly) removed - it was a error, think of it and you will see :)
    // besides it checked in the condition for the call to IntInterate, that's the right place.
    if (CheckCollapsed or Item.Expanded) and (Item <> StartFrom) then {<+>}
      for i := k downto 0 do
      begin
        if (not VisibleOnly) or
           ((not TElXTreeItem(Item.FChildren.List[i]).Hidden) or
           (not FOwner.FilteredVisibility)) then
          IntIterate(VisibleOnly, CheckCollapsed, TElXTreeItem(Item.FChildren.List[i]), StartFrom, Stack);
        if not (DoContinue) then
          Exit;
      end;
    Dec(j);
    if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or
       (not FOwner.FilteredVisibility))) and (Item <> FRoot) then
      IterateProc(Item, j, DoContinue, IterateData, FOwner);
    if (not DoContinue) then
      Exit;
  end;

begin
  if VisibleOnly then
     j := FOwner.TotalVisCount
  else
     j := FOwner.FAllList.Count;
  if StartFrom <> nil then
  begin
    Stack := TElStack.Create;
    TSI := StartFrom;
    Stack.Push(TSI);
    while TSI.Parent <> nil do
    begin
      Stack.Push(TSI.Parent);
      TSI := TSI.Parent;
    end; // while
  end
  else
    Stack := nil;
  DoContinue := True;
  IntIterate(VisibleOnly, CheckCollapsed, FRoot, StartFrom, Stack);
  if Stack <> nil then
    FreeAndNil(Stack);
end;

procedure TElXTreeItems.Iterate(VisibleOnly, CheckCollapsed: boolean; IterateMethod: TElXIterateMethod; IterateData: TLMDDataTag);
var
  j: Integer;
  DoContinue: Boolean;

  procedure IntIterate(VisibleOnly, CheckCollapsed: Boolean; Item: TElXTreeItem); {<+>}
  var
    i, LChildrenCount: Integer;
  begin
    Inc(j);
    if (j >= 0) and (not VisibleOnly or not Item.Hidden or not FOwner.FilteredVisibility) then
      IterateMethod(Item, j, DoContinue, IterateData, FOwner);
    if not DoContinue then
      Exit;
    // check for (not VisibleOnly) removed - it was a error, think of it and you will see :)
    // besides it checked in the condition for the call to IntInterate, that's the right place.
    if CheckCollapsed or Item.Expanded then {<+>}
    begin
      if Item.FChildren = nil then
         LChildrenCount := 0
      else
         LChildrenCount := Item.FChildren.Count;
      for i := 0 to LChildrenCount - 1 do
      begin
        if not VisibleOnly
          or not TElXTreeItem(Item.FChildren.List[i]).Hidden
          or not FOwner.FilteredVisibility
        then
          IntIterate(VisibleOnly, CheckCollapsed, TElXTreeItem(Item.FChildren.List[i])); {<+>}
        if not DoContinue then
          Exit;
      end;
    end;
  end;

begin
  j := -2;
  DoContinue := True;
  IntIterate(VisibleOnly, CheckCollapsed, FRoot);
end;

procedure TElXTreeItems.IterateBranch(VisibleOnly: boolean; IterateMethod: TElXIterateMethod; IterateData: TLMDDataTag; BranchParent: TElXTreeItem);
var
  j: Integer;
  DoContinue: Boolean;
  Stack: TElStack;
  TSI: TElXTreeItem;

  procedure IntIterate(VisibleOnly: Boolean; Item: TElXTreeItem; StartFrom: TElXTreeItem; var Stack: TElStack);
  var
    i, k, l: Integer;
  begin
    Inc(j);
    if (Stack <> nil) and (Stack.Count > 0) then
    begin
      if Item.FChildren = nil then
         k := -1
      else
         k := Item.FChildren.IndexOf(Stack.Pop);
      if Stack.Count = 0 then
        FreeAndNil(Stack);
    end
    else
    begin
      if not Item.IsUnder(StartFrom) then
         DoContinue := False
      else
        if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or (not FOwner.FilteredVisibility))) then
           IterateMethod(Item, j, DoContinue, IterateData, FOwner);
      if not (DoContinue) then
         Exit;
      k := 0;
    end;
    if (not (VisibleOnly)) or (Item.Expanded) then
    begin
      if Item.FChildren = nil then
         l := 0
      else
         l := Item.FChildren.Count;
      if k <> - 1 then
        for i := k to l - 1 do
        begin
          if (not VisibleOnly) or ((not TElXTreeItem(Item.FChildren.List[i]).Hidden) or (not FOwner.FilteredVisibility)) then
              IntIterate(VisibleOnly, TElXTreeItem(Item.FChildren.List[i]), StartFrom, Stack);
          if not DoContinue then
             Exit;
        end;
    end;
  end;

begin
  j := -2;
  if BranchParent <> nil then
  begin
    Stack := TElStack.Create;
    TSI := BranchParent;
    Stack.Push(TSI);
    while TSI.Parent <> nil do
    begin
      Stack.Push(TSI.Parent);
      TSI := TSI.Parent;
    end; // while
    DoContinue := True;
    IntIterate(VisibleOnly, FRoot, BranchParent, Stack);
    FreeAndNil(Stack);
  end
  else
    Iterate(VisibleOnly, not VisibleOnly, IterateMethod, IterateData); {<+>}
end;

procedure TElXTreeItems.IterateFrom(VisibleOnly, CheckCollapsed: boolean; IterateMethod: TElXIterateMethod; IterateData: TLMDDataTag; StartFrom: TElXTreeItem);
var
  j: Integer;
  DoContinue: Boolean;
  Stack: TElStack;
  TSI: TElXTreeItem;

  procedure IntIterate(VisibleOnly, CheckCollapsed: Boolean; Item: TElXTreeItem; StartFrom: TElXTreeItem; var Stack: TElStack); {<+>}
  var
    i, k, l: Integer;
  begin
    Inc(j);
    if (Stack <> nil) and (Stack.Count > 0) then
    begin
      if Item.FChildren = nil then
        k := -1
      else
        k := Item.FChildren.IndexOf(Stack.Pop);
      if Stack.Count = 0 then
        FreeAndNil(Stack);
    end
    else
    begin
      if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or (not FOwner.FilteredVisibility))) then
        IterateMethod(Item, j, DoContinue, IterateData, FOwner);
      if not (DoContinue) then
        Exit;
      k := 0;
    end;
    // check for (not VisibleOnly) removed - it was a error, think of it and you will see :)
    // besides it checked in the condition for the call to IntInterate, that's the right place.
    if CheckCollapsed or (Item.Expanded) then
    begin
      if Item.FChildren = nil then
        l := 0
      else
         l := Item.FChildren.Count;
      if k <> - 1 then
        for i := k to l - 1 do
        begin
          if (not VisibleOnly) or ((not TElXTreeItem(Item.FChildren.List[i]).Hidden) or (not FOwner.FilteredVisibility)) then
            IntIterate(VisibleOnly, CheckCollapsed, TElXTreeItem(Item.FChildren.List[i]), StartFrom, Stack);
          if not (DoContinue) then
            Exit;
        end;
    end;
  end;

begin
  j := -2;
  if StartFrom <> nil then
  begin
    Stack := TElStack.Create;
    TSI := StartFrom;
    Stack.Push(TSI);
    while TSI.Parent <> nil do
    begin
      Stack.Push(TSI.Parent);
      TSI := TSI.Parent;
    end; // while
  end
  else
    Stack := nil;
  DoContinue := True;
  IntIterate(VisibleOnly, CheckCollapsed, FRoot, StartFrom, Stack); {<+>}
  if Stack <> nil then
    FreeAndNil(Stack);
end;

procedure TElXTreeItems.IterateBack(VisibleOnly, CheckCollapsed: boolean; IterateMethod: TElXIterateMethod; IterateData: TLMDDataTag);
var
  j: Integer;
  DoContinue: Boolean;

  procedure IntIterate(VisibleOnly, CheckCollapsed: Boolean; Item: TElXTreeItem);  {<+>}
  var
    i, k: Integer;
  begin
    // check for (not VisibleOnly) removed - it was a error, think of it and you will see :)
    // besides it checked in the condition for the call to IntInterate, that's the right place.
    if CheckCollapsed or (Item.Expanded) then {<+>}
    begin
      if Item.FChildren = nil then
        k := 0
      else
        k := Item.FChildren.Count;
      for i := k - 1 downto 0 do
      begin
        if (not VisibleOnly) or ((not TElXTreeItem(Item.FChildren.List[i]).Hidden) or (not FOwner.FilteredVisibility)) then
           IntIterate(VisibleOnly, CheckCollapsed, TElXTreeItem(Item.FChildren.List[i])); {<+>}
        if not (DoContinue) then
          Exit;
      end;
    end;
    Dec(j);
    if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or (not FOwner.FilteredVisibility))) then
       IterateMethod(Item, j, DoContinue, IterateData, FOwner);
    if not (DoContinue) then
      Exit;
  end;

begin
  if VisibleOnly then
     j := FOwner.TotalVisCount
  else
     j := FOwner.FAllList.Count;
  DoContinue := True;
  IntIterate(VisibleOnly, CheckCollapsed, FRoot); {<+>}
end;

// Changed 10/28/98 by EM

procedure TElXTreeItems.IterateBackFrom(VisibleOnly, CheckCollapsed: boolean; IterateMethod: TElXIterateMethod; IterateData: TLMDDataTag; StartFrom: TElXTreeItem);
var
  j: Integer;
  DoContinue: Boolean;
  Stack: TElStack;
  TSI: TElXTreeItem;

  procedure IntIterate(VisibleOnly, CheckCollapsed: Boolean; Item: TElXTreeItem; StartFrom: TElXTreeItem; var Stack: TElStack); {<+>}
  var
    i, k: Integer;
  begin
    if (Stack <> nil) and (Stack.Count > 0) then
    begin
      if Item.FChildren = nil then
        k := -1
      else
        k := Item.FChildren.IndexOf(Stack.Pop);
      if Stack.Count = 0 then
        FreeAndNil(Stack);
    end
    else
    begin
      if Item.FChildren = nil then
        k := -1
      else
        k := Item.FChildren.Count - 1;
    end;
    // check for (not VisibleOnly) removed - it was a error, think of it and you will see :)
    // besides it checked in the condition for the call to IntInterate, that's the right place.
    if (CheckCollapsed or Item.Expanded) and (Item <> StartFrom) then {<+>}
      for i := k downto 0 do
      begin
        if (not VisibleOnly) or
           ((not TElXTreeItem(Item.FChildren.List[i]).Hidden) or
           (not FOwner.FilteredVisibility)) then
          IntIterate(VisibleOnly, CheckCollapsed, TElXTreeItem(Item.FChildren.List[i]), StartFrom, Stack);
        if not (DoContinue) then
          Exit;
      end;
    Dec(j);
    if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or
       (not FOwner.FilteredVisibility))) and (Item <> FRoot) then
      IterateMethod(Item, j, DoContinue, IterateData, FOwner);
    if (not DoContinue) then
      Exit;
  end;

begin
  if VisibleOnly then
     j := FOwner.TotalVisCount
  else
     j := FOwner.FAllList.Count;
  if StartFrom <> nil then
  begin
    Stack := TElStack.Create;
    TSI := StartFrom;
    Stack.Push(TSI);
    while TSI.Parent <> nil do
    begin
      Stack.Push(TSI.Parent);
      TSI := TSI.Parent;
    end; // while
  end
  else
    Stack := nil;
  DoContinue := True;
  IntIterate(VisibleOnly, CheckCollapsed, FRoot, StartFrom, Stack);
  if Stack <> nil then
    FreeAndNil(Stack);
end;

function TElXTreeItems.GetVisItem(index: Integer): TElXTreeItem;
var i, j, idx: Integer;
    Item: TElXTreeItem;
begin
  if (index < 0) or (index >= FOwner.TotalVisCount) then
  begin
    Result := nil;
    Exit;
  end;

  i := 0;
  idx := 0;
  j := FOwner.FAllList.Count;
  while i < j do
  begin
    Item := TElXTreeItem(FOwner.FAllList[i]);
    if (FOwner.FilteredVisibility and Item.Hidden) then
    begin
      i := FOwner.FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end
    else
    begin
      if idx = index then
      begin
        Result := Item;
        Exit;
      end;
      Inc(idx);
      if not Item.Expanded then
         i := FOwner.FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    Inc(i);
  end;
  Result := nil;
end;

function TElXTreeItems.GetItem(index: Integer): TElXTreeItem;
begin
  if (index < 0) or (index >= Count) then
    Result := nil
  else
    Result := TElXTreeItem(FOwner.FAllList.List[index]);
end;

function TElXTreeItems.GetVisIndex(Child: TElXTreeItem): Integer;
var i, j, idx: Integer;
    Item: TElXTreeItem;
begin
  if Child = nil then
  begin
    Result := -1;
    Exit;
  end;

  i := 0;
  idx := 0;
  j := FOwner.FAllList.Count;
  while i < j do
  begin
    Item := TElXTreeItem(FOwner.FAllList[i]);
    if (FOwner.FilteredVisibility and Item.Hidden) then
    begin
      i := FOwner.FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end
    else
    begin
      if Child = Item then
      begin
        Result := idx;
        Exit;
      end;
      Inc(idx);
      if not Item.Expanded then
         i := FOwner.FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    Inc(i);
  end;
  Result := -1;
end;

function TElXTreeItems.GetAbsIndex(Child: TElXTreeItem): Integer;
begin
  if Child = nil then
    Result := -1
  else
    Result := FOwner.FAllList.IndexOf(Child);
end;

procedure TElXTreeItems.DeleteItem(Child: TElXTreeItem);
var
  TSI: TElXTreeItem;
begin
  if (Child = nil) or (child = FRoot) then
    Exit;
  FOwner.IsUpdating := True;
  try
    if Child.Selected then
    begin
      if not FOwner.FMultiSelect then
        FOwner.FView.DoSetSelected(nil)
       else
        Child.Selected := False;
    end;
    TSI := Child.FParent;
    TSI.DeleteChild(Child);
    if TSI.FullyExpanded and TSI.Expanded then
    begin
      with FOwner.FView do
      begin
        FClearVis := True;
        FClearAll := True;
        FVisUpdated := True;
      end;
      FOwner.FUpdated := True;
    end;
  finally
    FOwner.IsUpdating := False;
    if (FOwner.View.FFocused = nil) then
      FOwner.DoAfterSelectionChange;
  end;
end;

procedure TElXTreeItems.AllocateStorage(MaxItems: Integer);
var NewCapacity: longint;
begin
  NewCapacity := (MaxItems + (AlignMem - 1)) and not (AlignMem - 1);
  with FOwner do
    if FAllList.Capacity < NewCapacity then
      FAllList.Capacity := NewCapacity;
end;

procedure TElXTreeItems.AllocateStorageInRoot(MaxItems: Integer);
begin
  FRoot.AllocateStorage(MaxItems);
end;

procedure TElXTreeItems.RemoveItem(Child: TElXTreeItem);
var
  TSI: TElXTreeItem;
begin
  if (Child = nil) or (child = FRoot) then
    Exit;
  FOwner.IsUpdating := True;
  try
    TSI := Child.FParent;
    TSI.RemoveSubChild(Child);
    TSI.RemoveChild(Child);
{
    Child.FParent := nil;
    Child.FRoot := nil;
    Child.FOwner := nil;
}
    if TSI.FullyExpanded and TSI.Expanded then
    begin
      with FOwner.FView do
      begin
        FClearVis := True;
        FClearAll := True;
        FVisUpdated := True;
      end;
      FOwner.FUpdated := True;
    end;
  finally
    FOwner.IsUpdating := False;
  end;
end;

procedure TElXTreeItems.AddExistingItem(Item, Parent: TElXTreeItem); { public }
var
  Child, AParent: TElXTreeItem;
  i: Integer;
begin
  FOwner.IsUpdating := True;
  Child := Item;
  if Parent = nil then
  begin
    Child.FParent := FRoot;
    Child.FList := self;
    Child.FRoot := FRoot;
  end
  else
  begin
    Child.FParent := Parent;
    Child.FList := Parent.FList; { := self}
    Child.FRoot := Parent.FRoot; { := FRoot}
  end;
  AParent := Child.FParent;
  Child.FOwner := AParent.FOwner;
  AParent.AddChild(Child);
  //Inc(FCount);
  if Child.FChildren <> nil then
    for i := Child.FChildren.Count-1 downto 0 do
      Child.AddExistingChild(TElXTreeItem(Child.FChildren.Items[i]));
  with
   FOwner do
  begin
    if AParent.FullyExpanded and AParent.Expanded then
    begin
      with FOwner.FView do
      begin
        FClearVis := True;
        FVisUpdated := True;
      end;
    end;

    if not Child.OwnerHeight then
       Inc(TotalVarHeightCount);
    if Child.Multiline and FAdjustMultilineHeight then
       Inc(TotalVarHeightCount);

    if (Child.FBoolData and ibfIsHTML) = ibfIsHTML then
       Inc(TotalVarHeightCount);

    FUpdated := True;
    FView.FRangeUpdate := True;
    IsUpdating := False;
  end;
end;

procedure TElXTreeItems.InsertExistingItem(Item, Parent: TElXTreeItem; Index: Integer); { public }
var
  Child, AParent: TElXTreeItem;
begin
  if parent = nil then
    AParent := FRoot
  else
    AParent := parent;

  if (index > AParent.Count) or (index < 0) then
    raise EElTreeError.Create(STExOutOfBounds);
  Child := Item;
  AddExistingItem(Child, AParent);
  Child.MoveToItem(AParent.Children[Index], naInsert);
end;

function TElXTreeItems.InsertItem(Index: Integer; Parent: TElXTreeItem): TElXTreeItem;
var
  Child, AParent: TElXTreeItem;
begin
  FOwner.IsUpdating := True;
  Child := CreateItem(FOwner);
  Child.FList := self;
  Child.FParent := Parent;
  if Child.FParent = nil then
    Child.FParent := FRoot;
  AParent := Child.FParent;
  if (AParent.FChildren = nil) then
    AParent.FChildren := TLMDObjectList.Create;
  if (index > AParent.FChildren.Count) or (index < 0) then
    raise EElTreeError.Create(STExOutOfBounds);
  AParent.InsertChild(Index, Child);
  //Inc(FCount);

  Result := Child;
  with FOwner do
  begin
    if AParent.FullyExpanded and AParent.Expanded then
    begin
      with FOwner.FView do
      begin
        FClearVis := True;
        FClearAll := True;
        FVisUpdated := True;
      end;
    end;
    with FOwner.FView do
    begin
      FUpdated := True;
      FRangeUpdate := True;
    end;
    IsUpdating := False;
  end;
  FOwner.DoItemCreated(Child);
end;

function TElXTreeItems.AddLastItem(Parent: TElXTreeItem): TElXTreeItem;
var
  Child, AParent: TElXTreeItem;
begin
  FOwner.IsUpdating := True;
  Child := CreateItem(FOwner);
  Child.FList := self;
  Child.FParent := Parent;
  if Child.FParent = nil then
    Child.FParent := FRoot;
  AParent := Child.FParent;
  AParent.AddLastChild(Child);
  //Inc(FCount);
  Result := Child;
  with FOwner do
  begin
    if AParent.Expanded and AParent.FullyExpanded then
    begin
      with FOwner.FView do
      begin
        FClearVis := True;
        FVisUpdated := True;
      end;
    end;
    with FOwner.FView do
    begin
      FUpdated := True;
      FRangeUpdate := True;
    end;
    IsUpdating := False;
  end;
  FOwner.DoItemCreated(Child);
end;

function TElXTreeItems.AddItem(Parent: TElXTreeItem): TElXTreeItem;
var
  Child, AParent: TElXTreeItem;
begin
  FOwner.IsUpdating := True;
  Child := CreateItem(FOwner);
  Child.FList := self;
  Child.FParent := Parent;
  if Child.FParent = nil then
    Child.FParent := FRoot;
  AParent := Child.FParent;
  AParent.AddChild(Child);
  //Inc(FCount);
  Result := Child;
  with FOwner do
  begin
    if AParent.Expanded and AParent.FullyExpanded then
    begin
      with FOwner.FView do
      begin
        FClearVis := True;
        FVisUpdated := True;
      end;
    end;
    with FOwner.FView do
    begin
      FUpdated := True;
      FRangeUpdate := True;
    end;
    IsUpdating := False;
  end;
  FOwner.DoItemCreated(Child);
end;

function TElXTreeItems.SetItemsByString(
  AItemPath: TLMDString;
  AStartItem: TElXTreeItem = nil;
  AReturnLastInserted: Boolean = true;
  APathSeparator: TLMDChar = '\';
  ACellSeparator: TLMDChar = #9;
  AJustInsert: Boolean = false): TElXTreeItem;
var
  LPathItems: TLMDMemoryStrings;
  LCells: TLMDMemoryStrings;
  i: Integer;
  LItem: TElXTreeItem;
  LStartItem: TElXTreeItem;
  k: Integer;
  LCurrentItem: TLMDString;
  j: Integer;
begin
  Result := nil;
  LPathItems := TLMDMemoryStrings.Create;
  LCells := TLMDMemoryStrings.Create;
  try
    k := 1;
    while (k <= Length(AItemPath)) and (AItemPath[k] = APathSeparator) do
      inc(k);

    LMDParseToStrList(Copy(AItemPath, k, Maxint), APathSeparator, LPathItems);

    LStartItem := AStartItem;
    for i := 0 to LPathItems.Count - 1 do
    begin
      LCurrentItem := LPathItems.Strings[i];
      LMDParseToStrList(LCurrentItem, ACellSeparator, LCells);
      if AJustInsert then
        LItem := nil
      else
        LItem := LookForItem(LStartItem, LCells[0], nil, -1, false, true, false, false, false);
      if (LItem = nil) then
      begin
        LItem := AddChild(LStartItem, LCells[0]);
        if (Result = nil) or AReturnLastInserted then
          Result := LItem;
      end;

      for j := 0 to LCells.Count - 1 do
      begin
        if (i = FOwner.FMainTreeColumn) then
          LItem.Text := LCells.Strings[j]
        else
        begin
          if (Assigned(LItem.Cells[j])) then
            LItem.Cells[j].Text := LCells.Strings[j]
          else
            LItem.Cells.Add.Text := LCells.Strings[j];
        end;
      end;
      LStartItem := LItem;
    end;
  finally
    LPathItems.Free;
    LCells.Free;
  end;
end;

procedure TElXTreeItems.Assign(Source: TPersistent);
begin
  if Source is TElXTreeItems then
  begin
    if FOwner <> nil then
      FOwner.IsUpdating := True;
    FRoot.Assign(TElXTreeItems(Source).FRoot);
    //FCount := TElXTreeItems(Source).FCount;
    FOwner.ReRenderAllHTMLItems;
    if FOwner <> nil then
      with FOwner.FView do
      begin
        FHRange := -1;
        FOwner.FUpdated := True;
        FVisUpdated := True;
        FClearVis := True;
        FClearAll := True;
        FOwner.IsUpdating := False;
      end;
  end
  else
  if (Source is TStrings) then
    LoadFromStringList(TStrings(Source))
  {$ifdef LMD_UNICODE}
  else
  if (Source is TLMDWideStrings) then
    LoadFromWideStringList(TLMDWideStrings(Source))
  {$endif}
  else
    inherited;
end;

procedure TElXTreeItems.Clear;
var i: Integer;
    FMSel: Boolean;
begin
  i := Count;
  if FOwner <> nil then
  begin
    FOwner.IsUpdating := True;
    FOwner.ItemFocused := nil;
    FOwner.FView.FSelected:=nil;
    // clear data cache for virtual mode
    FOwner.DataCacheClear;

    // clear visibles list
    FOwner.FView.ColorHelper.Visible.Clear;
{ EK: seems that this is redundant
    if FOwner.FSortSections <> nil then
      FOwner.FSortSections.Clear;
    FOwner.FSortSection := -1;
    if Assigned(FOwner.header) then
      FOwner.Header.Sections.ClearSorting;
}
  end;

  // clear items list
  FMSel := FOwner.FMultiSelect;
  FOwner.FMultiSelect := False;
  FRoot.Clear;
  if FOwner.FSelectedList <> nil then
    FOwner.FSelectedList.Count := 0;
  FOwner.FMultiSelect := FMSel;
  if FOwner <> nil then
  with FOwner.FView do
  begin
    FHRange := -1;
    if i > 0 then
    begin
      FVisUpdated := True;
      FClearVis := True;
      FClearAll := True;
    end;
    FOwner.FUpdated := True;
    FOwner.IsUpdating := False;
  end;
end;

function TElXTreeItems.GetCount: Integer;
begin
  if Self.FOwner <> nil then
    Result := FOwner.FAllList.Count
  else
    Result := 0;
end;

function TElXTreeItems.CreateItem(FOwner: TCustomElXTree): TElXTreeItem;
begin
  Result := FItemClass.Create(FOwner);
end;

procedure TElXTreeItems.ReadData(Stream: TStream);
var
  b: boolean;
begin
  b := false;
  if FOwner <> nil then
  begin
    FOwner.IsUpdating := True;
    b := FOwner.RightAlignedView;
    FOwner.RightAlignedView := False;
  end;
  FRoot.Clear;
  FRoot.ReadData(Stream);
  RecheckMasterCells;
  Owner.ReRenderAllHTMLItems;
  if FOwner <> nil then
  with FOwner.FView do
    begin
      FOwner.RightAlignedView := b;
      FHRange := -1;
      FVisUpdated := True;
      FClearVis := True;
      FClearAll := True;
      FOwner.FUpdated := True;
      FOwner.IsUpdating := False;
    end;
end;

procedure TElXTreeItems.WriteData(Stream: TStream);
var
  TSI: TElXTreeItem;
//  b: boolean;
begin
  FOwner.IsUpdating := True;
//  b := FOwner.RightAlignedView;
//  FOwner.RightAlignedView := False;
  TSI := nil;
  if FOwner <> nil then
  begin
    TSI := FOwner.ItemFocused;
    FOwner.ItemFocused := nil;
  end;
  FRoot.WriteData(Stream);
  if FOwner <> nil then
  begin
    FOwner.ItemFocused := TSI;
  end;
//  FOwner.RightAlignedView := b;
  FOwner.IsUpdating := false;
end;

procedure TElXTreeItems.SaveToStream(Stream: TStream);
begin
  WriteData(Stream);
end;

procedure TElXTreeItems.LoadFromStream(Stream: TStream);
begin
  ReadData(Stream);
end;

procedure TElXTreeItems.SaveToFile(FileName: TLMDString);
var
  T: TStream;
begin
  T := nil;
  try
    T := TLMDFileStream.Create(FileName, fmCreate or fmShareDenyWrite);
    SaveToStream(T);
  finally
    FreeAndNil(T);
  end;
end;

procedure TElXTreeItems.LoadFromFile(FileName: TLMDString);
var
  T: TStream;
begin
  T := nil;
  try
    T := TLMDFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    LoadFromStream(T);
  finally
    FreeAndNil(T);
  end;
end;

function TElXTreeItems.Add(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; { public }
begin
  if Item = nil then
    Result := AddItem(nil)
  else
    Result := AddItem(Item.FParent);
  Result.Text := Text;
end; { Add }

function TElXTreeItems.AddChild(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; { public }
begin
  Result := AddItem(Item);
  Result.Text := Text;
end; { AddChild }

function TElXTreeItems.AddChildFirst(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; { public }
begin
  Result := InsertItem(0, Item);
  Result.Text := Text;
end; { AddChildFirst }

function TElXTreeItems.AddChildObject(Item: TElXTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElXTreeItem; { public }
begin
  Result := AddItem(Item);
  Result.Text := Text;
  Result.Data := Ptr;
end; { AddChildObject }

function TElXTreeItems.AddChildObjectFirst(Item: TElXTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElXTreeItem; { public }
begin
 Result := InsertItem(0, Item);
  Result.Text := Text;
  Result.Data := Ptr;
end; { AddChildObjectFirst }

function TElXTreeItems.AddFirst(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; { public }
begin
  if Item = nil then
    Result := InsertItem(0, nil)
  else
    Result := InsertItem(0, Item.FParent);
  Result.Text := Text;
end; { AddFirst }

function TElXTreeItems.AddObject(Item: TElXTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElXTreeItem; { public }
begin
  if Item = nil then
    Result := AddItem(nil)
  else
    Result := AddItem(Item.FParent);
  Result.Text := Text;
  Result.Data := Ptr;
end; { AddObject }

function TElXTreeItems.AddObjectFirst(Item: TElXTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElXTreeItem; { public }
begin
  if Item = nil then
    Result := InsertItem(0, nil)
  else
    Result := InsertItem(0, Item.FParent);
  Result.Text := Text;
  Result.Data := Ptr;
end; { AddObjectFirst }

function TElXTreeItems.Insert(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; { public }
var
  i: Integer;
  FParent: TElXTreeItem;
begin
  if Item = nil then
  begin
    i := 0;
    FParent := nil;
  end
  else
  begin
    i := Item.Index;
    FParent := Item.FParent;
  end;
  Result := InsertItem(i, FParent);
  Result.Text := Text;
end; { Insert }

// Changed 10/28/98 by EM

function TElXTreeItems.InsertObject(Item: TElXTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElXTreeItem; { public }
var
  i: Integer;
  FParent: TElXTreeItem;
begin
  if Item = nil then
  begin
    i := 0;
    FParent := nil;
  end
  else
  begin
    i := Item.Index;
    FParent := Item.FParent;
  end;
  Result := InsertItem(i, FParent);
  Result.Text := Text;
  Result.Data := Ptr;
end; { InsertObject }

procedure TElXTreeItems.Delete(Item: TElXTreeItem); { public }
begin
  DeleteItem(Item);
end; { Delete }

function TElXTreeItems.GetFirstNode: TElXTreeItem; { public }
begin
  Result := Item[0];
end; { GetFirstNode }

// Changed 10/27/98 by EM

procedure TElXTreeItems.BeginUpdate; { public }
begin
  FOwner.IsUpdating := True;
end; { BeginUpdate }

// Changed 10/27/98 by EM

procedure TElXTreeItems.EndUpdate; { public }
begin
  FOwner.IsUpdating := False;
end; { EndUpdate }

// Changed 10/28/98 by EM

function TElXTreeItems.InsertAfterObject(Item: TElXTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElXTreeItem; { public }
var
  i: Integer;
  FParent: TElXTreeItem;
begin
  if Item = nil then
  begin
    i := 0;
    FParent := nil;
  end
  else
  begin
    i := Succ(Item.Index);
    FParent := Item.FParent;
  end;
  Result := InsertItem(i, FParent);
  Result.Text := Text;
  Result.Data := Ptr;
end; { InsertAfterObject }

function TElXTreeItems.InsertAfter(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; { public }
var
  i: Integer;
  FParent: TElXTreeItem;
begin
  if Item = nil then
  begin
    i := 0;
    FParent := nil;
  end
  else
  begin
    i := Succ(Item.Index);
    FParent := Item.FParent;
  end;
  Result := InsertItem(i, FParent);
  Result.Text := Text;
end; { InsertAfter }

type
  TXSRecEx0 = record
    TextToFind: TLMDString;
    WholeTextOnly: Boolean;
    ColumnNum: Integer;
    StartItem: TElXTreeItem;
    DataToFind: TLMDDataTag;
    CheckStartItem,
      LookForData,
      SubItemsOnly: Boolean;
    NoCase: Boolean;
    Result: TElXTreeItem;
  end;
  PXSRecEx0 = ^TXSRecEx0;

  TXSRecEx = record
    ColumnNum: Integer;
    StartItem: TElXTreeItem;
    CheckStartItem,
      SubItemsOnly: Boolean;
    Result: TElXTreeItem;
    CompProc: TElXLookupCompareProc;
    CompMethod: TElXLookupCompareMethod;
    SearchDetails: TLMDDataTag;
  end;
  PXSRecEx = ^TXSRecEx;
  procedure TElXTreeItems.IntFind(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean;
  IterateData: TLMDDataTag; Tree: TCustomElXTree);
var
  b: boolean;
  begin
  with PXSRecEx(IterateData)^ do
  begin
    if (Item = StartItem) and (not CheckStartItem) then exit;
    if ((not CheckStartItem) or (Item <> StartItem)) and
    (SubItemsOnly) and (not Item.IsUnder(StartItem)) then
    begin
      ContinueIterate := false;
      exit;
    end;
    if Assigned(CompProc) then
      b := CompProc(Item, SearchDetails)
    else
      b := CompMethod(Item, SearchDetails);
    if b then
    begin
      result := Item;
      ContinueIterate := false;
      exit;
    end;
  end;
  end;

function TElXTreeItems.LookBackForItemEx2(StartItem: TElXTreeItem; ColumnNum: Integer;
        CheckStartItem, SubItemsOnly, VisibleOnly, CheckCollapsed: Boolean;
        SearchDetails: TLMDDataTag;
        CompareProc: TElXLookupCompareProc): TElXTreeItem;
var
  XSRec: TXSRecEx;
begin
  XSRec.ColumnNum := ColumnNum;
  XSRec.StartItem := StartItem;
  XSRec.CheckStartItem := CheckStartItem;
  XSRec.SubItemsOnly := SubItemsOnly;
  XSRec.CompProc := CompareProc;
  XSRec.SearchDetails := SearchDetails;
  XSRec.Result := nil;
  try
    IterateBackFrom(VisibleOnly, CheckCollapsed, IntFind, @XSRec, StartItem); {<+>}
  finally
    Result := XSRec.Result;
    end;
end;

type
  TXSRecEx2 = record
    TextToFind: TLMDString;
    ColumnNum: integer;
    StartItem: TElXTreeItem;
    DataToFind: TLMDDataTag;
    CheckStartItem,
      LookForData,
      SubItemsOnly: boolean;
    NoCase: boolean;
    Result: TElXTreeItem;
  end;
  PXSRecEx2 = ^TXSRecEx2;
  procedure TElXTreeItems.IntFind1(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean;
  IterateData: TLMDDataTag; Tree: TCustomElXTree);
var
  i: integer;
  s: TLMDString;
  L: PXSRecEx2;
begin
  L := PXSRecEx2(IterateData);
  if (Item = PXSRecEx2(IterateData).StartItem) and (not PXSRecEx2(IterateData).CheckStartItem) then exit;
  if (PXSRecEx2(IterateData).SubItemsOnly) and (not Item.IsUnder(PXSRecEx2(IterateData).StartItem)) then
  begin
    ContinueIterate := false;
    exit;
  end;
  if L.LookForData then
  begin
    if Item.FData = L.DataToFind then
    begin
      L.Result := Item;
      ContinueIterate := false;
      exit;
    end;
  end else
  begin
    if (L.ColumnNum = -1) or (L.ColumnNum = Tree.MainTreeColumn) then
      s := Item.Text
    else
    begin
      i := L.ColumnNum;
      if Item.FStaticData <> nil then
      begin
        if Item.Cells.Count <= i then
          s := ''
        else
          s := Item.Cells[i].Text;
      end
      else
        Tree.TriggerVirtualTextNeeded(Item, i, s);
    end;
    if L.NoCase then
    begin
      {$ifdef LMD_UNICODE}
      if LMDWideSameText(S, L.TextToFind) then
      {$else}
      if LMDAnsiSameText(S, L.TextToFind) then
      {$endif}
      begin
        L.Result := Item;
        ContinueIterate := false;
        exit;
      end;
    end else
    begin
      if S = L.TextToFind then
      begin
        L.Result := Item;
        ContinueIterate := false;
        exit;
      end;
    end;
  end;
  end;

function TElXTreeItems.LookForItem(StartItem: TElXTreeItem;
  TextToFind: TLMDString;
  DataToFind: TLMDDataTag;
  ColumnNum: Integer;
  LookForData,
  CheckStartItem,
  SubItemsOnly,
  VisibleOnly,
  NoCase: Boolean): TElXTreeItem;
var
  XSRec: TXSRecEx2;
begin
  Result := nil;
  XSRec.TextToFind := TextToFind;
  XSRec.ColumnNum := ColumnNum;
  if StartItem = nil then
  begin
    if Count = 0 then
      Exit
    else
      XSRec.StartItem := Item[0];
  end
  else
    XSRec.StartItem := StartItem;
  XSRec.LookForData := LookForData;
  XSRec.DataToFind := DataToFind;
  XSRec.NoCase := NoCase;
  XSRec.CheckStartItem := CheckStartItem;
  XSRec.SubItemsOnly := SubItemsOnly;
  XSRec.Result := nil;
  try
    IterateFrom(VisibleOnly, not VisibleOnly, IntFind1, @XSRec, StartItem); {<+>}
  finally
    Result := XSRec.Result;
  end;
end;

{<+>}
function TElXTreeItems.LookForItemEx2(StartItem: TElXTreeItem; ColumnNum: Integer;
      CheckStartItem, SubItemsOnly, VisibleOnly, CheckCollapsed: Boolean;
      SearchDetails: TLMDDataTag;
      CompareProc: TElXLookupCompareProc): TElXTreeItem;
var
  XSRec: TXSRecEx;
begin
  Result := nil;
  XSRec.ColumnNum := ColumnNum;
  if StartItem = nil then
  begin
    if Count = 0 then
      Exit
    else
      XSRec.StartItem := Item[0];
  end
  else
    XSRec.StartItem := StartItem;

  XSRec.CheckStartItem := CheckStartItem;
  XSRec.SubItemsOnly := SubItemsOnly;
  XSRec.CompMethod := nil;
  XSRec.CompProc := CompareProc;
  XSRec.SearchDetails := SearchDetails;
  XSRec.Result := nil;
  try
    IterateFrom(VisibleOnly, CheckCollapsed, IntFind, @XSRec, StartItem); {<+>}
  finally
    Result := XSRec.Result;
  end;
end;

function TElXTreeItems.LookForItemEx2(StartItem: TElXTreeItem; ColumnNum: Integer;
      CheckStartItem, SubItemsOnly, VisibleOnly, CheckCollapsed: Boolean;
      SearchDetails: TLMDDataTag;
      CompareMethod: TElXLookupCompareMethod): TElXTreeItem;
var
  XSRec: TXSRecEx;
begin
  Result := nil;
  XSRec.ColumnNum := ColumnNum;
  if StartItem = nil then
  begin
    if Count = 0 then
      Exit
    else
      XSRec.StartItem := Item[0];
  end
  else
    XSRec.StartItem := StartItem;

  XSRec.CheckStartItem := CheckStartItem;
  XSRec.SubItemsOnly := SubItemsOnly;
  XSRec.CompProc := nil;
  XSRec.CompMethod := CompareMethod;
  XSRec.SearchDetails := SearchDetails;
  XSRec.Result := nil;
  try
    IterateFrom(VisibleOnly, CheckCollapsed, IntFind, @XSRec, StartItem); {<+>}
  finally
    Result := XSRec.Result;
    end;
end;

procedure TElXTreeItems.IntFind2(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean;
  IterateData: TLMDDataTag; Tree: TCustomElXTree);
var
  SubStrPos, i: Integer;
  s, CopiedSubStr: TLMDString;
  begin
  with PXSRecEx0(IterateData)^ do
  begin
    if (Item = StartItem) and (not CheckStartItem) then
      Exit;
    if (SubItemsOnly) and not (Item = StartItem) and (not Item.IsUnder(StartItem)) then
    begin
      ContinueIterate := False;
      Exit;
    end;
    if LookForData then
    begin
      if Item.FData = DataToFind then
      begin
        Result := Item;
        ContinueIterate := False;
        Exit;
      end;
    end
    else
    begin
      if (ColumnNum = -1) or (ColumnNum = Tree.MainTreeColumn) then
        s := Item.Text
      else
      begin
        i := ColumnNum;
        if Item.Cells.Count <= i then
          s := ''
        else
          s := Item.Cells[i].Text;
      end;
      if NoCase then
      begin
        if (WholeTextOnly and
           {$ifdef LMD_UNICODE}
           (LMDWideSameText(S, TextToFind))) or
           {$else}
           (LMDAnsiSameText(S, TextToFind))) or
           {$endif}
           (not WholeTextOnly and
           {$ifdef LMD_UNICODE}
           (LMDWidePos(LMDWideUpperCase(TextToFind), LMDWideUpperCase(S)) > 0))
           {$else}
           (Pos(UpperCase(TextToFind),UpperCase(S)) > 0))
           {$endif}
           then
        begin
          Result := Item;
          ContinueIterate := False;
          Exit;
        end;
      end
      else
      begin
        {$ifdef LMD_UNICODE}
        SubStrPos := LMDWidePos(TextToFind, S);
        {$else}
        SubStrPos := Pos(TextToFind,S);
        {$endif}
        CopiedSubStr := '';
        if SubStrPos > 0 then
          CopiedSubStr := Copy(S, SubStrPos, Length(TextToFind));
        if (WholeTextOnly and (S = TextToFind)) or
           (not WholeTextOnly and
           {$ifdef LMD_UNICODE}
           (LMDWidePos(TextToFind,S) > 0))
           {$else}
           (Pos(TextToFind,S) > 0))
           {$endif}
           then
        begin
          Result := Item;
          ContinueIterate := False;
          Exit;
        end;
      end;
    end;
  end;
  end;

{<+>}
function TElXTreeItems.LookForItem2(StartItem: TElXTreeItem;
  TextToFind: TLMDString;
  WholeTextOnly: Boolean;
  DataToFind: TLMDDataTag;
  ColumnNum: Integer;
  LookForData,
  CheckStartItem,
  SubItemsOnly,
  VisibleOnly,
  CheckCollapsed,
  NoCase: Boolean): TElXTreeItem;

var
  XSRec: TXSRecEx0;
begin
  Result := nil;
  XSRec.TextToFind := TextToFind;
  XSRec.WholeTextOnly := WholeTextOnly;
  XSRec.ColumnNum := ColumnNum;
  if StartItem = nil then
  begin
    if Count = 0 then
      Exit
    else
      XSRec.StartItem := Item[0];
  end
  else
    XSRec.StartItem := StartItem;

  XSRec.LookForData := LookForData;
  XSRec.DataToFind := DataToFind;
  XSRec.NoCase := NoCase;
  XSRec.CheckStartItem := CheckStartItem;
  XSRec.SubItemsOnly := SubItemsOnly;
  XSRec.Result := nil;
  try
    IterateFrom(VisibleOnly, CheckCollapsed, IntFind2, @XSRec, StartItem); {<+>}
  finally
    Result := XSRec.Result;
    end;
end;

procedure TElXTreeItems.IntFind3(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean;
  IterateData: TLMDDataTag; Tree: TCustomElXTree);
var
  b: Boolean;
  begin
  with PXSRecEx(IterateData)^ do
  begin
    if (Item = StartItem) and (not CheckStartItem) then
      Exit;
    if (SubItemsOnly) and (not Item.IsUnder(StartItem)) then
    begin
      ContinueIterate := False;
      Exit;
    end;
    b := CompProc(Item, SearchDetails);
    if b then
    begin
      Result := Item;
      ContinueIterate := False;
      Exit;
    end;
  end;
  end;

function TElXTreeItems.LookForItemEx(StartItem: TElXTreeItem; ColumnNum: Integer; CheckStartItem, SubItemsOnly,
  VisibleOnly: Boolean; SearchDetails: TLMDDataTag; CompareProc: TElXLookupCompareProc): TElXTreeItem;
var
  XSRec: TXSRecEx;
begin
  Result := nil;
  XSRec.ColumnNum := ColumnNum;
  if StartItem = nil then
  begin
    if Count = 0 then
      Exit
    else
      XSRec.StartItem := Item[0];
  end
  else
    XSRec.StartItem := StartItem;
  XSRec.CheckStartItem := CheckStartItem;
  XSRec.SubItemsOnly := SubItemsOnly;
  XSRec.CompProc := CompareProc;
  XSRec.SearchDetails := SearchDetails;
  XSRec.Result := nil;
  try
    IterateFrom(VisibleOnly, not VisibleOnly, IntFind3, @XSRec, StartItem); {<+>}
  finally
    Result := XSRec.Result;
    end;
end;

function TElXTreeItems.GetRootCount: Integer;
begin
  Result := FRoot.Count;
end;

function TElXTreeItems.GetRootItem(Index: Integer): TElXTreeItem;
begin
  Result := FRoot.Item[Index];
end;

procedure TElXTreeItems.LoadFromStringList(Strings: TStrings);
var i: Integer;
begin
  BeginUpdate;
  try
    Clear;
    for i := 0 to Strings.Count - 1 do
      InsertItemFromString(i, Strings[i]);
  finally
    EndUpdate;
  end;
end;

{$ifdef LMD_UNICODE}
procedure TElXTreeItems.LoadFromWideStringList(Strings: TLMDWideStrings);
var i: Integer;
begin
  BeginUpdate;
  try
    Clear;
    for i := 0 to Strings.Count - 1 do
      InsertItemFromString(i, Strings[i]);
  finally
    EndUpdate;
  end;
end;
{$endif}

function TElXTreeItems.InsertItemFromString(Index: Integer; AString: TLMDString; ASeparator: TLMDChar = #9): TElXTreeItem;
var
  l,
  cl    : integer;
  p,
  op    : PLMDChar;
  CItem,
  NItem : TElXTreeItem;
  S     : TLMDString;
  i     : integer;
begin
  if Index > 0 then
    CItem := GetItem(Index - 1)
  else
    CItem := nil;
  l := 0;
  p := PLMDChar(AString);
  while (p^ = ASeparator) do
  begin
    inc(p);
  inc(l);
  end;
  if CItem <> nil then
    cl := CItem.Level
  else
    cl := 0;
  if l > cl + 1 then
    l := cl + 1;
  while cl > l do
  begin
    CItem := CItem.Parent;
    dec(cl);
  end;
  if (cl = l) and (CItem <> nil) then
    CItem := CItem.Parent;
  NItem := AddItem(CItem);
  Result := NItem;
  i := 0;
  while true do
  begin
    op := p;
    while (p^ <> ASeparator) and (p^ <> #0) do
    begin
      inc(p);
    end;
    SetLength(S, p - op);
    if p - op > 0 then
      Move(op^, S[1], Length(S) * sizeof(TLMDChar));
    if {((i = 0) and (not FOwner.FShowHeader)) or }(i = FOwner.FMainTreeColumn) then
      NItem.Text := S
    else
    begin
      if (Assigned(NItem.Cells[i])) then
        NItem.Cells[i].Text := S
      else
      NItem.Cells.Add.Text := S;
    end;
    inc(i);
    if (p^ = #0) then
      break
    else
      inc(p);
    end;
end;

procedure TElXTreeItems.SaveToStringList(AStrings: TStrings);
var i, j: Integer;
    S: String;
    AnItem: TElXTreeItem;
begin
  AStrings.Clear;
  for i := 0 to Count - 1 do
  begin
    AnItem := GetItem(i);
    {$ifdef LMD_UNICODE}
    S := LMDWideMakeString(AnItem.Level, #9);
    {$else}
    S := LMDAnsiMakeString(AnItem.Level, #9);
    {$endif}
    {
    if FOwner.ShowColumns then
      k := Owner.HeaderSections.Count - 1
    else
      k := 0;
    }
    j := 0;
    while True do
    begin
      if j > 0 then
        S := S + #9;
      if {(not FOwner.ShowColumns) or }(j = FOwner.FMainTreeColumn) then
        S := S + AnItem.Text
      else
      if j < FOwner.FMainTreeColumn then
      begin
        if AnItem.Cells.Count > j then
          S := S + AnItem.Cells[j].Text
        else
          break;
      end
      else
      begin
        if AnItem.Cells.Count > j - 1 then
          S := S + AnItem.Cells[j - 1].Text
        else
          break;
      end;
      Inc(j);
    end;
    AStrings.Add(S);
  end;
end;

{$ifdef LMD_UNICODE}
procedure TElXTreeItems.SaveToWideStringList(AStrings: TLMDWideStrings);
var i, j: Integer;
    S: WideString;
    AnItem: TElXTreeItem;
begin
  AStrings.Clear;
  for i := 0 to Count - 1 do
  begin
    AnItem := GetItem(i);
    S := LMDWideMakeString(AnItem.Level, #9);
    {
    if FOwner.ShowColumns then
      k := Owner.HeaderSections.Count - 1
    else
      k := 0;
    }
    j := 0;
    while True do
    begin
      if j > 0 then
        S := S + #9;
      if {(not FOwner.ShowColumns) or }(j = FOwner.FMainTreeColumn) then
        S := S + AnItem.Text
      else
      if j < FOwner.FMainTreeColumn then
      begin
        if AnItem.Cells.Count > j then
          S := S + AnItem.Cells[j].Text
        else
          break;
      end
      else
      begin
        if AnItem.Cells.Count > j - 1 then
          S := S + AnItem.Cells[j - 1].Text
        else
          break;
      end;
      Inc(j);
    end;
    AStrings.Add(S);
  end;
end;
{$endif}

// ****************************************************************************
//                                 TCustomElXTree
// ****************************************************************************

procedure TCustomElXTree.SetBarStyleVerticalLines(value: Boolean);
begin
  if (FBarStyleVerticalLines = value) then
    Exit;
  IsUpdating := True;
  with FView do
  begin
    FBarStyleVerticalLines := value;
    if BarStyle then
    begin
      FClearAll := True;
      FUpdated := True;
    end;
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.AlignPieces;
var
  LTreeRect: TRect;
  LHeaderRect: TRect;
  LHScrollRect: TRect;
  LVScrollRect: TRect;
  LSavedHeaderHeight: Integer;
  LHScrollBarHeight: Integer;
  LVScrollBarWidth: Integer;
begin
  if not HandleAllocated  then
    Exit;
  FIgnoreSBChange := True;
  LSavedHeaderHeight := 0;
  if (FUseCustomScrollBars) then
    LVScrollBarWidth := FVScrollBar.Width
  else
    LVScrollBarWidth := GetSystemMetrics(SM_CXVSCROLL);
  try
    if ShowColumns then
    begin
      TElHeaderHack(FHeader).AdjustHeaderHeight;
      FSavedHeaderHeight := GetHeaderHeight;
      LSavedHeaderHeight := FSavedHeaderHeight;
      LHeaderRect := Rect(0, 0, ClientRect.Right, LSavedHeaderHeight);
//      if StickyHeaderSections then
//        inc(LHeaderRect.Right);
    end;
    if FVertScrollBarVisible then
    begin
      if RightAlignedText xor ScrollBarOpposite then
        Inc(LHeaderRect.Left, LVScrollBarWidth)
      else
        Dec(LHeaderRect.Right, LVScrollBarWidth);
    end;
    with LHeaderRect do
      if ShowColumns then
        SetWindowPos(FHeader.Handle, HWND_TOP, Left, Top, Right - Left, Bottom - Top, SWP_NOACTIVATE or SWP_NOZORDER or SWP_NOOWNERZORDER or SWP_SHOWWINDOW or SWP_NOSENDCHANGING)
      else
        SetWindowPos(FHeader.Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or SWP_HIDEWINDOW);
      PBoolean(@FHeader.Visible)^ := ShowColumns;
      LTreeRect := ClientRect;
    if ShowColumns then
    begin
      LTreeRect.Top := LSavedHeaderHeight;
    end;
    if FHorzScrollBarVisible and FUseCustomScrollBars then
    begin
      Dec(LTreeRect.Bottom, FHScrollBar.Height);
    end;
    if FVertScrollBarVisible and FUseCustomScrollBars then
    begin
      if RightAlignedText xor ScrollBarOpposite then
        Inc(LTreeRect.Left, LVScrollBarWidth)
      else
        Dec(LTreeRect.Right, LVScrollBarWidth);
    end;
    ResetVisItemsHeight;
    with LTreeRect do
        SetWindowPos(FView.Handle, HWND_TOP, Left, Top, Right - Left, Bottom - Top, SWP_NOACTIVATE or SWP_NOOWNERZORDER or SWP_NOZORDER or SWP_SHOWWINDOW or SWP_NOSENDCHANGING);

    if FHorzScrollBarVisible and FUseCustomScrollBars then
    begin
      LHScrollBarHeight := FHScrollBar.Height;
      LHScrollRect := Rect(0, ClientRect.Bottom - LHScrollBarHeight, ClientRect.Right, ClientRect.Bottom);
    end;
    if FVertScrollBarVisible then
    begin
      if RightAlignedText xor ScrollBarOpposite then
      begin
        LVScrollRect := Rect(ClientRect.Left, 0, ClientRect.Left + LVScrollBarWidth, ClientRect.Bottom);
        Inc(LHScrollRect.Left, LVScrollBarWidth);
      end
      else
      begin
        LVScrollRect := Rect(ClientRect.Right - LVScrollBarWidth, 0, ClientRect.Right, ClientRect.Bottom);
        Dec(LHScrollRect.Right, LVScrollBarWidth);
      end;
    end;
    with LHScrollRect do
      if FHorzScrollBarVisible and FUseCustomScrollBars then
        SetWindowPos(FHScrollBar.Handle, HWND_TOP, Left, Top, Right - Left, Bottom - Top, SWP_NOACTIVATE or SWP_NOOWNERZORDER or SWP_NOZORDER or SWP_SHOWWINDOW or SWP_NOSENDCHANGING)
      else
        SetWindowPos(FHScrollBar.Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or SWP_HIDEWINDOW);
      PBoolean(@FHScrollBar.Visible)^ := FHorzScrollBarVisible and FUseCustomScrollBars;
      with LVScrollRect do
      if FVertScrollBarVisible and FUseCustomScrollBars then
        SetWindowPos(FVScrollBar.Handle, HWND_TOP, LVScrollRect.Left, LVScrollRect.Top, LVScrollRect.Right - LVScrollRect.Left, LVScrollRect.Bottom - LVScrollRect.Top, SWP_NOACTIVATE or SWP_NOOWNERZORDER {or SWP_NOZORDER }or SWP_SHOWWINDOW or SWP_NOSENDCHANGING)
      else
        SetWindowPos(FVScrollBar.Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or SWP_HIDEWINDOW);
      PBoolean(@FVScrollBar.Visible)^ := FVertScrollBarVisible and FUseCustomScrollBars;
      InvalidateRect(FView.Handle, @LTreeRect, True);
    if ShowColumns and StickyHeaderSections then
    begin
      FHeader.AdjustStickySize(nil);
      FHeader.Invalidate;
    end;
  finally
    FIgnoreSBChange := False;
  end;
end;

function TCustomElXTree.GetRoot: TElXTreeItem;
begin
  Result := FItems.FRoot;
end;

type THackScrollBar = class(TElScrollBar)
       property Font;
       property NoScrollMessages;
     end;

constructor TCustomElXTree.CreateClass;
begin

  CreateItemsExt(ItemClass);
  Create(AOwner);

end;

constructor TCustomElXTree.Create;
begin
  BeginCreate;
  inherited;
  DoInCreate(AOwner);
  EndCreate;
end;

procedure TCustomElXTree.DoInCreate(AOwner: TComponent);
begin
  FForceAlign := false;
  FEditorManager := CreateInplaceManager;
  FUseCustomScrollBars := True;
  ControlStyle :=
  [csClickEvents, csOpaque, csDoubleClicks,// csCaptureMouse,
    csDisplayDragImage, csReplicatable, csReflector ];

  FNotRaiseForBarStyle := False;

  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;
  FAutoLineVisibleOnly := False;
  FTextColor := clWindowText;
  FBackGroundColor := clWindow;

  FCellStyle := TElXCellStyle.Create(nil,nil);
  FCellStyle.OnChange := StyleChanged;
  FLineHeight := DefineLineHeight;

  FShowColumns := False;

  FAdjustMultilineHeight := True;
  FHighlightAlphaLevel := 255;
  FBorderStyle := bsSingle;

  FDoInplaceEdit := True;
  FHorizontalLines := False;
  FVerticalLines := False;
  FVerticalLinesLong := True;
  FFullRowSelect := True;
  FSelectionMode := smUsual;
  FLineHintMode := shmLong;
  FMultiSelect := True;
  FMultiSelectLevel := -1;  // CNS
  FDragScrollInterval := 100;
  FMouseFrameVisible := True;
  FMouseFrameSelect := True;
  FDblClickMode := dcmExpand;
  FHideSelection := False;
  FOwnerDrawByColumn := True;
  FOwnerDrawMask := DefaultTreeOwnerDrawMask;
  FRowSelect := True;
  FHotTrack := True;
{$ifdef HOTTRACK_CURSOR}
  FTrackingCursor := crDefault;
{$endif}
  FShowButtons := True;
  FShowImages := True;
  FShowLines := True;
  FDrawFocusRect := True;

  FLinkColor := clBlue;
  FLinkStyle := [fsUnderline];

  FItemIndent := 18;
  FCheckBoxSize := 15;
  FHeaderHotTrack := True;

  FAllList := TLMDObjectList.Create;
  FSelectedList := TLMDObjectList.Create;
  if FItems = nil then
    FItems := CreateItems;

  Height := 100;
  Width := 200;
  FView := CreateView;
  FMainTextType := sftText;
  FHintType := shtHintOrText;
  FQuickEditMode := False;

  FView.FRender := TLMDHTMLRender.Create;
  FView.FRender.Control := FView;
  FView.FRender.OnImageNeeded := TriggerImageNeededEvent;
  FView.FRender.OnImageNeededEx := TriggerImageNeededExEvent;
  FView.FRender.OnAdjustControlPosition := TriggerAdjustControlPositionEvent;
  FView.FRender.OnSetControlVisibility := UpdateHTMLControlsVisibility;
  FView.FRender.OnControlCreated := TriggerControlCreatedEvent;
  FView.FRender.OnTagFound := TriggerTagFoundEvent;

  FView.TabStop := False;
  FView.OnClick := ClickTransfer;
  FView.OnDblClick := DblClickTransfer;
  FView.OnDragDrop := DropTransfer;
  FView.OnDragOver := OverTransfer;
  FView.OnEndDrag := DragTransfer;
  FView.OnEnter := EnterTransfer;
  FView.OnExit := ExitTransfer;
  FView.OnKeyDown := KeyDownTransfer;
  FView.OnKeyPress := KeyPressTransfer;
  FView.OnKeyUp := KeyUpTransfer;
  FView.OnMouseDown := MouseDownTransfer;
  FView.OnMouseMove := MouseMoveTransfer;
  FView.OnMouseUp := MouseUpTransfer;
  FView.OnStartDrag := StartDragTransfer;
  FView.OnMouseWheel := MouseWheelTransfer;
  FView.OnMouseWheelDown := MouseWheelDownTransfer;
  FView.OnMouseWheelUp := MouseWheelUpTransfer;
  FView.Ctl3D := False;
  FView.ParentShowHint := True;
  FView.TabStop := True;
  FView.TabOrder := 0;
  FView.ParentFont := True;

  //<abb>
  FHScrollBar := TElXTreeScrollBar.Create(Self);
  TElXTreeScrollBar(FHScrollBar).FTree := Self;
  //</abb>

  FHScrollBar.StyleManager := nil;
  THackScrollBar(FHScrollBar).ControlStyle := FHScrollBar.ControlStyle + [csNoDesignVisible];
  THackScrollBar(FHScrollBar).NoScrollMessages := True;
  FHorzScrollBarStyle := TElScrollBarStyles.Create(FHScrollBar, Self);
  FHorzScrollBarStyle.OnChange := SBChanged;
  FHScrollBar.OnDrawPart := HorzScrollDrawPartTransfer;
  FHScrollBar.OnScrollHintNeeded := HorzScrollHintNeededTransfer;

  FHScrollBar.ParentFont := True;
  FHScrollBar.TabStop := False;
  FHScrollBar.OnScroll := FView.OnHScroll;
  FHScrollBar.Ctl3D := False;
  FHScrollBar.Height := GetSystemMetrics(SM_CYVTHUMB);
  FHScrollBar.Visible := False;
  FHScrollBar.OnMouseDown := ScrollBarMouseDown;
  FHScrollBar.AltDisablingArrows := True;

  FHScrollBar.IsHTML := True;

  //<abb>
  FVScrollBar := TElXTreeScrollBar.Create(Self);
  TElXTreeScrollBar(FVScrollBar).FTree := Self;
  //</abb>

  FVScrollBar.StyleManager := nil;
  THackScrollBar(FVScrollBar).ControlStyle := FHScrollBar.ControlStyle + [csNoDesignVisible];
  THackScrollBar(FVScrollBar).NoScrollMessages := True;
  FVertScrollBarStyle := TElScrollBarStyles.Create(FVScrollBar, Self);
  FVertScrollBarStyle.OnChange := SBChanged;
  FVScrollBar.OnDrawPart := VertScrollDrawPartTransfer;
  FVScrollBar.OnScrollHintNeeded := VertScrollHintNeededHandler;
  FVScrollBar.ShowTrackHint := True;

  FVScrollBar.ParentFont := True;
  FVScrollBar.Kind := sbVertical;
  FVScrollBar.TabStop := False;
  FVScrollBar.OnScroll := FView.OnVScroll;
  FVScrollBar.Ctl3D := False;
  FVScrollBar.Width := GetSystemMetrics(SM_CXHTHUMB);
  FVScrollBar.Visible := False;
  FVScrollBar.OnMouseDown := ScrollBarMouseDown;
  FVScrollBar.AltDisablingArrows := True;

  FVScrollBar.IsHTML := True;
  FLinkCursor := crHandPoint;

  FHeader := CreateHeader;
  FView.FHeader := FHeader;
  FView.FItems := FItems;
  FGutterWidth := 15;
  with FHeader do
  begin
    StyleManager := nil;
    TabStop := False;
    FHeaderRowCount := RowCount;
    SetDesigning(csDesigning in ComponentState);
    OnSectionDraw := DoHeaderDraw;
    OnResize := HeaderResizeHandler;
    OnSectionResize := OnHeaderSectionResize;
    OnSectionClick := OnHeaderSectionClick;
    OnSectionDelete := OnHeaderSectionDelete;
    OnMouseDown := DoHeaderMouseDown;
    OnSectionMove := OnHeaderSectionMove;
    OnSectionShowHide := OnHeaderSectionVisChange;
    OnSectionChange := OnHeaderSectionChange;
    OnSectionCreate := OnHeaderSectionCreate;
    OnHeaderLookup := OnHeaderSectionLookup;
    OnHeaderLookupDone := OnHeaderSectionLookupDone;
    OnSectionExpand := Self.OnHeaderExpand;
    OnSectionCollapse := Self.OnHeaderCollapse;
    OnSectionAutoSize := HeaderSectionAutoSizeHandler;
    OnFilterCall := HeaderSectionFilterCallTransfer;
    OnSectionCellClick := HeaderSectionCellClickTransfer;
    Tracking := FHeaderHotTrack;
    Align := alNone;
    Visible := False;
    AllowDrag := False;
    MultiSort := True;
    GutterWidth := 15;
  end; //with
  FHeader.Font.Assign(Font);

  TabStop := True;
  FAutoLineHeight := True;
  FLineHintType := lhtSmart;
  FDragTrgDrawMode := SelColorRect;
  FPathSeparator := '\';
  FSortMode := smNone;
  FSortColumnColor := clNone;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FAImageChangeLink := TChangeLink.Create;
  FAImageChangeLink.OnChange := ImageListChange;
  DragMode := dmManual;
  FHideHintOnMove := True;
  FAlwaysKeepSelection := True;
  FIncrementalSearchScope := issWholeTree;

  FSelectColumn := -1;
  FDragType := dtDelphi;
  FLinesColor := clBtnFace;
  FLineHintColor := FBackGroundColor;
  FLinesStyle := psDot;
  FActiveBorderType := fbtSunken;
  FInactiveBorderType := fbtSunkenOuter;

  FStoragePath := '\Tree';
  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  FUnderlineTracked := True;
  FShowRootButtons := True;
  FAutoResizeColumns := True;
  FFlatFocusedScrollbars := True;
  FHorzDivLinesColor := clBtnFace;
  FVertDivLinesColor := clBtnFace;

  FBackground := TBitmap.Create;
  FBackground.OnChange := BackgroundChange;
  FBackgroundType := bgtColorFill;

  FFocusedSelectColor := clHighlight;
  FFocusedSelectTextColor := clHighlightText;
  FHideSelectColor := clBtnFace;
  FHideSelectTextColor := LMDElHideSelectTextColor;
  FTrackColor := clHighlight;
  FDragRectAcceptColor := clGreen;
  FDragRectDenyColor := clRed;
  FRightClickSelect := True;
  FSortType := stText;
  FSortUseCase := True;

  FBorderSides := [ebsLeft, ebsTop, ebsRight, ebsBottom];
  FStripedEvenColor := clBtnHighlight;
  FStripedOddColor := clBtnShadow;

  FHeaderUseTreeFont := True;
  FHeaderFont := TFont.Create;
  FHeaderFont.OnChange := HeaderFontChanged;

  FLineHintTimeout := 3000;
  FChangeDelay := 500;
  FDragExpandDelay := 500;

  FGradientSteps := 64;

  FDelayTimer := TTimer.Create(self);

  FDelayTimer.Enabled := False;
  FDelayTimer.OnTimer := OnDelayTimer;
  FInplaceEditorDelay := 500;
  FIncrementalSearchTimeout := 500;
  FIncrementalSearchSelectItem := False;

  FHook := TElHook.Create(nil);
  FHook.OnBeforeProcess := OnBeforeHook;
  DragCursor := crDrag; // to preserve right behavior in future versions of VCL
  FDoubleBuffered := True;
  FDoubleBufferedOnResize := True;

  // for CLX to work, these must be the last
  FView.Parent := Self;
  FHScrollBar.Parent := Self;
  FVScrollBar.Parent := Self;
  FHeader.Parent := Self;
  FCursor := crArrow;
  DataCacheSize := 200;
//  if FHeader.Sections.Count = 0 then
//    FHeader.Sections.AddSection;

end;

destructor TCustomElXTree.Destroy;
begin
  inherited Destroying;
  if IsEditing then
    EndEdit(True);

  FreeAndNil(FCellStyle);

  FreeAndNil(FBackground);

  ImageForm := nil;
  FreeAndNil(FImgFormChLink);

  UseXPThemes := False;
  FreeAndNil(FCheckBoxGlyph);
  FreeAndNil(FRadioButtonGlyph);

  FreeAndNil(FPlusPicture);
  FreeAndNil(FMinusPicture);
  FreeAndNil(FLeafPicture);

  FreeAndNil(FItems);
  DataCacheDeallocate;

  FreeAndNil(FView.FRender);

  if FDropTarget <> nil then
     FreeAndNil(FDropTarget);

  FreeAndNil(FView);
  FreeAndNil(FVertScrollBarStyle);
  FreeAndNil(FHorzScrollBarStyle);
  if Assigned(FHScrollBar) then //EK: by request from customer
    FHScrollBar.Free;
  if Assigned(FVScrollBar) then //EK: by request from customer
    FVScrollBar.Free;
  FreeAndNil(FHeader);
  FreeAndNil(FHeaderFont);
  FDelayedItem := nil;
  FreeAndNil(FDelayTimer);
  if FSelectedList <> nil then
    FreeAndNil(FSelectedList);
  FreeAndNil(FAllList);
  if Font <> nil then
    Font.OnChange := nil;
  if FImages <> nil then
    FImages.UnregisterChanges(FImageChangeLink);
  if FImages2 <> nil then
    FImages2.UnregisterChanges(FImageChangeLink);
  if FAlphaForImages <> nil then
    FAlphaForImages.UnregisterChanges(FAImageChangeLink);
  if FAlphaForImages2 <> nil then
    FAlphaForImages2.UnregisterChanges(FAImageChangeLink);
  FreeAndNil(FImageChangeLink);
  FreeAndNil(FAImageChangeLink);
  //BMP.Free;
  FEditorManager.Free;
  FEditorManager := nil;
//  FreeAndNil(FEditorManager);
  FreeAndNil(FSortSections);
  FreeAndNil(FHook);
  inherited Destroy;
end;

procedure TCustomElXTree.SetLinkColor(newValue: TColor);
begin
  if (FLinkColor <> newValue) then
  begin
    FLinkColor := newValue;
    ReRenderAllHTMLItems;
    Invalidate; //Repaint;
  end;
end;

procedure TCustomElXTree.SetUseThemeForSelection(const Value: Boolean);
begin
  if FUseThemeForSelection <> Value then
  begin
    FUseThemeForSelection := Value;
    Invalidate;
  end;
end;

procedure TCustomElXTree.SetLinkStyle(newValue: TFontStyles);
begin
  if (FLinkStyle <> newValue) then
  begin
    FLinkStyle := newValue;
    ReRenderAllHTMLItems;
    Invalidate; //Repaint;
  end;
end;

procedure TCustomElXTree.SetAdjustInplaceEditorPosition(aValue: boolean);
begin
  FAdjustInplaceEditorPosition := aValue;
end;

procedure TCustomElXTree.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited CreateWindowHandle(Params);
  AlignPieces;
end; {CreateWindowHandle}

function TCustomElXTree.GetSelCount: Integer;
begin
  if MultiSelect then
  begin
    Result := FSelectedList.Count;
  end
  else
  begin
    if ItemFocused = nil then
      Result := 0
    else
      Result := 1;
  end;
end;

procedure TCustomElXTree.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWord = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or BorderStyles[FBorderStyle] or (WS_HSCROLL or WS_VSCROLL);

    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;

    //with Params.WindowClass do
      style := style and not (CS_HREDRAW or CS_VREDRAW);
    Params.WindowClass.style := Params.WindowClass.style or CS_HREDRAW or CS_VREDRAW;
    if RightAlignedText then
      ExStyle := ExStyle or WS_EX_RTLREADING or WS_EX_RIGHT and (not WS_EX_RIGHTSCROLLBAR);
  end;
end;

procedure TCustomElXTree.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (FBorderStyle = bsSingle) then
    RecreateWnd;
  inherited;
end;

procedure TCustomElXTree.SetHorzScrollBarStyle(newValue: TElScrollBarStyles);
begin
  FHorzScrollBarStyle.Assign(newValue);
end;

procedure TCustomElXTree.SetVertScrollBarStyle(newValue: TElScrollBarStyles);
begin
  FVertScrollBarStyle.Assign(newValue);
end;

function TCustomElXTree.GetItemAt(X, Y: Integer; var ItemPart: TSTXItemPart;
      var HitColumn: Integer): TElXTreeItem;
begin
  y := Y - FView.Top;
  X := X - FView.Left;
  Result := FView.GetItemAt(X, Y, ItemPart, HitColumn);
end;

procedure TCustomElXTree.SetImages(Value: TCustomImageList);
var
  i: Integer;
begin
  if FImages = value then
    Exit;
  IsUpdating := True;
  if FImages <> nil then
    begin
      FImages.RemoveFreeNotification(Self);
      FImages.UnRegisterChanges(FImageChangeLink);
    end;
  FImages := Value;
  if FImages <> nil then
  begin
    FImages.RegisterChanges(FImageChangeLink);
    FImages.FreeNotification(Self);
  end;
  if csDestroying in ComponentState then
    Exit;
  i := DefineLineHeight;
  if FAutoLineHeight and (i <> FLineHeight) then
  begin
    FLineHeight := i;
    with FView do
    begin
      FClearVis := True;
      FClearAll := True;
    end;
  end;
  if not ShowColumns then
  begin
    with FView do
    begin
      FHRange := -1;
      DefineHRange;
    end;
    if RightAlignedView then
    begin
      FRightAlignedView := False;
      RightAlignedView := True;
    end;
  end
  else
  begin
    if ShowColumns and FHeader.Sections[FMainTreeColumn].AutoSize then
      if (FUpdateCount = 0) then
        AutoSizeColumn(FMainTreeColumn)
      else
        FColumnSizeUpdate := True;
  end;
  with FView do
  begin
    FRangeUpdate := True;
    FUpdated := True;
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.SetAlphaForImages(Value: TCustomImageList);
{var
  i: Integer;}
begin
  if FAlphaForImages = value then
    Exit;
  IsUpdating := True;
  if FAlphaForImages <> nil then
  begin
    if not (csDestroying in FAlphaForImages.ComponentState) then
      FAlphaForImages.RemoveFreeNotification(Self);
    FAlphaForImages.UnRegisterChanges(FAImageChangeLink);
  end;
  FAlphaForImages := Value;
  if FAlphaForImages <> nil then
  begin
    FAlphaForImages.RegisterChanges(FAImageChangeLink);
    FAlphaForImages.FreeNotification(Self);
  end;
  if csDestroying in ComponentState then
    Exit;
{
  i := DefineLineHeight;
  if FAutoLineHeight and (i <> FLineHeight) then
  begin
    FLineHeight := i;
    with FView do
    begin
      FClearVis := True;
      FClearAll := True;
    end;
  end;
  if not ShowColumns then
  begin
    with FView do
    begin
      FHRange := -1;
      DefineHRange;
    end;
    if RightAlignedView then
    begin
      FRightAlignedView := False;
      RightAlignedView := True;
    end;
  end
  else
  begin
    if ShowColumns and FHeader.Sections[FMainTreeColumn].AutoSize then
      if (FUpdateCount = 0) then
        AutoSizeColumn(FMainTreeColumn)
      else
        FColumnSizeUpdate := True;
  end;
}
  with FView do
  begin
    FRangeUpdate := True;
    FUpdated := True;
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.SetShowLines(Value: Boolean);
begin
  if FShowLines = value then
    Exit;
  IsUpdating := True;
  FShowLines := value;
  with FView do
  begin
    if not ShowColumns then
      FHRange := -1;
    FRangeUpdate := True;
    FUpdated := True;
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.SetShowEmptyImages(newValue: Boolean);
begin
  if FShowEmptyImages <> newValue then
  begin
    FShowEmptyImages := newValue;
    if (not ShowImages) or (FImages = nil) then
      Exit;
    IsUpdating := True;
    with FView do
    begin
      if not ShowColumns then
        FHRange := -1;
      FUpdated := True;
      FRangeUpdate := True;
    end;
    IsUpdating := False;
  end;
end;

procedure TCustomElXTree.SetShowEmptyImages2(newValue: Boolean);
begin
  if FShowEmptyImages2 <> newValue then
  begin
    FShowEmptyImages2 := newValue;
    if (not ShowImages) or (FImages = nil) then
      Exit;
    IsUpdating := True;
    with FView do
    begin
      if not ShowColumns then
        FHRange := -1;
      FUpdated := True;
      FRangeUpdate := True;
    end;
    IsUpdating := False;
  end;
end;

procedure TCustomElXTree.SetShowRoot(Value: Boolean);
begin
  if FShowRoot = value then
    Exit;
  IsUpdating := True;
  FShowRoot := value;
  with FView do
  begin
    if not ShowColumns then
      FHRange := -1;
    FUpdated := True;
    FRangeUpdate := True;
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.SetShowImages(Value: Boolean);
var
  i: Integer;
begin
  if FShowImages = value then
    Exit;
  IsUpdating := True;
  FShowImages := value;
  if not ShowColumns then
    FView.FHRange := -1;
  i := DefineLineHeight;
  if FAutoLineHeight and (i <> FLineHeight) then
  begin
    FLineHeight := i;
    with FView do
    begin
      FClearVis := True;
      FClearAll := True;
    end;
  end;
  with FView do
  begin
    FRangeUpdate := True;
    FUpdated := True;
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.ImageListChange(Sender: TObject);
var
  i: Integer;
begin
  if FView.FPainting then
    Exit;
  IsUpdating := True;
  if AutoLineHeight then
  begin
    i := DefineLineHeight;
    if i <> FLineHeight then
    begin
      with FView do
      begin
        FClearVis := True;
        if i < FLineHeight then
          FClearAll := True;
      end;
      FLineHeight := i;
    end;
  end;
  with FView do
  begin
    FUpdated := True;
    FRangeUpdate := True;
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle = value then
    Exit;
  FBorderStyle := value;
  RecreateWnd;
end;

procedure TCustomElXTree.SetShowButtons(Value: Boolean);
begin
  if FShowButtons = value then
    Exit;
  IsUpdating := True;
  FShowButtons := value;
  with FView do
  begin
    if not ShowColumns then
      FHRange := -1;
    FUpdated := True;
    FRangeUpdate := True;
  end;
  IsUpdating := False;
end;

function TCustomElXTree.GetUpdating: Boolean;
begin
  Result := (FUpdateCount > 0) or FProcUpdate;
end;

procedure TCustomElXTree.SetUpdating(value: Boolean);
var
  i: Integer;
begin
  if FProcUpdate then
    Exit;

  if Value then
  begin
    FHeader.BeginUpdate;
    Inc(FUpdateCount)
  end
  else
  begin
    Dec(FUpdateCount);
    FHeader.EndUpdate;
  end;

  if FUpdateCount > 0 then
    Exit;
  if (csDestroying in ComponentState) or (csLoading in ComponentState) then
    Exit;
  FProcUpdate := True;
//  if FilteredVisibility then
//    UpdateDiffItems;
  with FView do
  begin
    if FAutoLineHeight then
    begin
      i := DefineLineHeight;
      if i <> FLineHeight then
      begin
        FClearVis := True;
        FLineHeight := i;
      end;
    end;
    if (FHRange = -1) and (Assigned(FOwner.Owner)) {and (not ShowColumns)} then
      FView.DefineHRange;
    if FSortRequired then
    begin
      TriggerSortBegin;
      Sort(True);
      TriggerSortEnd;
      FSortRequired := False;
    end;
    if FUpdated then
    begin
      if FVisUpdated then // recount visibles
      begin
        TotalVisCount := GetTotalVisCount;
        FVisUpdated := False;
      end;
      IgnoreResize := True;
      if (not (csLoading in ComponentState)) and (HandleAllocated) then
      begin
        UpdateScrollBars;
      end;
      IgnoreResize := False;
      if FClearVis and HandleAllocated then // refresh ColorHelper.Visible
      begin
        DoSetTopIndex(FTopIndex);
        FClearVis := False;
      end;
      IgnoreResize := True;
      if ShowColumns and {(VirtualityLevel = vlNone)} AutoResizeColumns and (FColumnSizeUpdate) then
      begin
        FColumnSizeUpdate := False;
        AutoSizeAllColumns;
      end;
      if (not (csLoading in ComponentState)) and (HandleAllocated) then
        UpdateScrollBars;
      IgnoreResize := False;
      UpdateView;
      FUpdated := False;
    end;
  end;
  FProcUpdate := False;
end;

function TCustomElXTree.GetTotalVisCount: Integer;
var i, j, idx: Integer;
    Item: TElXTreeItem;
begin
  i := 0;
  idx := 0;
  j := FAllList.Count;
  while i < j do
  begin
    Item := TElXTreeItem(FAllList[i]);
    if (FilteredVisibility and Item.Hidden) then
    begin
      i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end
    else
    begin
      Inc(idx);
      if not Item.Expanded then
         i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    Inc(i);
  end;
  Result := idx;
  TotalVisCount := Result;
end;

{
function TCustomElXTree.VisToIndex;
type PGetItemRec = ^TGetItemRec;
     TGetItemRec = record
       VisIndex,
       Visibles:Integer;
       j:Integer;
     end;
var GetItemRec: TGetItemRec;

    procedure IntVisToIndex(Item:TElXTreeItem; Index: Integer; var ContinueIterate:Boolean;
                                              IterateData:pointer; Tree:TCustomElXTree);
    var i: Integer;
    begin
      if Item.FullyExpanded then Inc(PGetItemRec(IterateData)^.Visibles);
      if PGetItemRec(IterateData)^.Visibles=PGetItemRec(IterateData)^.VisIndex then
      begin
        PGetItemRec(IterateData)^.j:=Index;
        ContinueIterate:=False;
      end;
    end;

begin
  GetItemRec.VisIndex:=Index;
  GetItemRec.Visibles:=-1;
  GetItemRec.j:=-1;
  FItems.Iterate(False,True,@IntVisToIndex,@GetItemRec);
  Result:=GetItemRec.j;
end;
}
{function TCustomElXTree.IndexToVis;

type PGetItemRec = ^TGetItemRec;
     TGetItemRec = record
       VisIndex,
       Visibles:Integer;
       j:Integer;
     end;
var GetItemRec: TGetItemRec;

    procedure IntIndexToVis(Item:TElXTreeItem; Index: Integer; var ContinueIterate:Boolean;
                                              IterateData:pointer; Tree:TCustomElXTree);
    var i: Integer;
    begin
      if Item.FullyExpanded then Inc(PGetItemRec(IterateData)^.Visibles);
      if Index=PGetItemRec(IterateData)^.VisIndex then
      begin
        PGetItemRec(IterateData)^.j:=PGetItemRec(IterateData)^.Visibles;
        ContinueIterate:=False;
      end;
    end;

begin
  GetItemRec.VisIndex:=Index;
  GetItemRec.Visibles:=-1;
  GetItemRec.j:=-1;
  FItems.Iterate(False,True,@IntIndexToVis,@GetItemRec);
  Result:=GetItemRec.j;
end;
}

procedure TCustomElXTree.UpdateScrollBars;

  function UpdHBar: Boolean;
  var
    b1: Boolean;
    ScrollInfo: TScrollInfo;
    CurPos: Integer;
    hsw: Integer;
  begin
    b1 := FHorzScrollBarVisible;
    ScrollInfo.cbSize := Sizeof(ScrollInfo);
    ScrollInfo.fMask := SIF_POS or SIF_RANGE;
    GetScrollInfo(FHScrollBar.Handle, SB_CTL, ScrollInfo);
    if ShowColumns then
    begin
      FView.FHRange := 0;
      if FHeader.Sections.Count > 0 then
      begin
        hsw := FHeader.SectionsWidth;
        ScrollInfo.nMax := hsw;
        FView.FHRange := hsw;
      end
      else
        ScrollInfo.nMax := 0;
    end
    else
      ScrollInfo.nMax := FView.FHRange;
    if ScrollInfo.nMax < 0 then
      ScrollInfo.nMax := 0;
    ScrollInfo.nPage := FView.ClientWidth + 1;

    FHorzScrollBarVisible := (ScrollInfo.nMax - Integer(ScrollInfo.nPage) > 0) and (not FHideHorzScrollBar);
    if (not FHorzScrollBarVisible) then
    begin
      ScrollInfo.nMax := 0;
      FLeftPosition := 0;
      FHeader.LeftPos := 0
      //LockedColumn, update
      //if FHeader.Left < 0 then FHeader.Left := 0;
    end;
    FHorzScrollBarVisible := FHorzScrollBarVisible or (ForcedScrollBars in [ssHorizontal, ssBoth]);
    Result := (FHorzScrollBarVisible <> b1);// and (not (ForcedScrollBars in [ssHorizontal, ssBoth]));

    FLeftPosition := Min(FLeftPosition, Max(0, ScrollInfo.nMax));
    CurPos := FLeftPosition;

    ScrollInfo.fMask := SIF_ALL;

    ScrollInfo.nMin := 0;
    ScrollInfo.cbSize := SizeOf(ScrollInfo);
    ScrollInfo.nPos := CurPos;
    ScrollInfo.nTrackPos := CurPos;

    SetScrollInfo(FHScrollBar.Handle, SB_CTL, ScrollInfo, True);
    CurPos := THackScrollBar(FHScrollBar).UpdateThumbPos;
    if not IsEditing and LMDInRange(CurPos, FHScrollBar.Min, FHScrollBar.Max) then
      FHScrollBar.Position := CurPos;
    if not B1 and (FLeftPosition = 0) and FRightAlignedView then
      SetLeftPosition(Max(0, ScrollInfo.nMax));
    // Set info for hidden standard scrollbar
    if FUseCustomScrollBars or (ForcedScrollBars in [ssHorizontal, ssBoth]) then
       ScrollInfo.fMask := ScrollInfo.fMask or SIF_DISABLENOSCROLL;
    Windows.SetScrollInfo(Handle, SB_HORZ, ScrollInfo, not FUseCustomScrollBars);
    Windows.SetScrollInfo(FView.Handle, SB_HORZ, ScrollInfo, not FUseCustomScrollBars);
    if (FHeader.LeftPos <> FLeftPosition) then
      FHeader.LeftPos := FLeftPosition;
    FHorzScrollBarVisible := FHorzScrollBarVisible or (ForcedScrollBars in [ssHorizontal, ssBoth])
  end;

  function UpdVBar: Boolean;
  var
    LScrollBarVisible: Boolean;
    ScrollInfo: TScrollInfo;
  begin
    if TotalVisCount = 0 then
      GetTotalVisCount;

    ScrollInfo.nMax := TotalVisCount - 1;

    if TotalVarHeightCount > 0 then
      ScrollInfo.nMax := FView.CalcPageUpPos(ScrollInfo.nMax);

    ScrollInfo.fMask := SIF_ALL;
    ScrollInfo.nMin := FFixedTopRowNum;
    ScrollInfo.cbSize := SizeOf(ScrollInfo);
    ScrollInfo.nPos := FTopIndex;
    ScrollInfo.nTrackPos := FTopIndex;

    LScrollBarVisible := FVertScrollBarVisible;
    FVertScrollBarVisible := not FHideVertScrollBar
      and (
        (FTopIndex > FFixedTopRowNum)
        or (FView.GetVisiblesHeight >= FView.ClientHeight)
        or ((ScrollInfo.nMax > FView.ColorHelper.Visible.Count - 1) and (FView.ColorHelper.Visible.Count > 0))
      );
    //if (FTopIndex > 0) and (not FHideVertScrollBar) then FVertScrollBarVisible := True;

    if TotalVarHeightCount > 0 then
      ScrollInfo.nPage := 1// min((FView.CalcPageDownPos(TopIndex) - FView.CalcPageUpPos(TopIndex)) shr 1{TopIndex}, View.GetVisCount - 1)
    else
      if FFixedTopRowNum > 0 then
        ScrollInfo.nPage := View.GetVisCount - FixedTopRowNum - 1
      else
        ScrollInfo.nPage := View.GetVisCount - 1;

    if not FVertScrollBarVisible then
    begin
      ScrollInfo.nMax := 0;
      ScrollInfo.nPage := 1;
    end;
    FVertScrollBarVisible := FVertScrollBarVisible or (ForcedScrollBars in [ssVertical, ssBoth]);

    SetScrollInfo(FVScrollBar.Handle, SB_CTL, ScrollInfo, True);
    // Set info for hidden standard scrollbar

    //ScrollInfo.fMask := SIF_POS or SIF_RANGE or SIF_PAGE;
    if FUseCustomScrollBars or (ForcedScrollBars in [ssVertical, ssBoth]) then
       ScrollInfo.fMask := ScrollInfo.fMask or SIF_DISABLENOSCROLL;

    Windows.SetScrollInfo(Handle, SB_VERT, ScrollInfo, not FUseCustomScrollBars);
    Windows.SetScrollInfo(FView.Handle, SB_VERT, ScrollInfo, not FUseCustomScrollBars);
    Result := FVertScrollBarVisible <> LScrollBarVisible;// and (not (ForcedScrollBars in [ssVertical, ssBoth]));
    FVertScrollBarVisible := FVertScrollBarVisible or (ForcedScrollBars in [ssVertical, ssBoth]);
  end;

// var FHVis, FVVis: Boolean;
var i: Integer;
begin
  // FHVis := FHorzScrollBarVisible;
  // FVVis := FVertScrollBarVisible;
  i := 0;
  while UpdVBar or UpdHBar do
  begin
    AlignPieces;
    Inc(i);
    if i > 3 then
      break;
  end;
  {
  if (FHVis <> FHorzScrollBarVisible) or (FVVis <> FVertScrollBarVisible) then
  begin
    AlignPieces;
  end;
  }
  if not FScrollbarsInitialized then
  begin
    FScrollbarsInitialized := True;
    if UseCustomScrollbars then
      PostMessage(Handle, WM_UPDATESBFRAME, 0, 0);
    end;
  if FUseCustomScrollBars and (BorderStyle = bsSingle) then
    DrawFlatBorder(False, False);
end;

procedure TCustomElXTree.SetHorizontalLines(value: Boolean);
var
  i: Integer;
begin
  if FHorizontalLines = value then
    Exit;
  IsUpdating := True;
  FHorizontalLines := value;
  if FAutoLineHeight then
  begin
    i := DefineLineHeight;
    if i <> FLineHeight then
    begin
      FLineHeight := i;
      with FView do
      begin
        FClearVis := True;
        FClearAll := True;
      end;
    end;
  end;
  with FView do
  begin
    FRangeUpdate := True;
    FUpdated := True;
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.SetVerticalLines(value: Boolean);
begin
  if FVerticalLines = value then
    Exit;
  IsUpdating := True;
  with FView do
  begin
    FVerticalLines := value;
    FClearAll := True;
    FUpdated := True;
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.OnHeaderSectionResize(AHeader: TElXCustomHeader;
  Section: TElXHeaderSection);
begin
//  if IsUpdating then
//    Exit;
  IsUpdating := True;
  ResetAllItemsHeight;
  ReRenderAllHTMLItems;
  DoOnColumnResize(Section.Index);
  with FView do
  begin
    FUpdated := True;
    FRangeUpdate := True;
    FClearVis := True;
    if FVerticalLines then
      FClearAll := True
    else
      FRangeUpdate := True;
  end;
  IsUpdating := False;
  {if FHeader.SectionsWidth < FView.Width then AlignPieces;}
end;

type
  TXSRecInt = record
    Text: PLMDChar;
    ColNum: Integer;
  end;
  PXSRecInt = ^TXSRecInt;
  function TCustomElXTree.IntCompare(Item: TElXTreeItem; SearchDetails: TLMDDataTag): Boolean;
var
  i: Integer;
  AT: TLMDString;
begin
  i := PXSRecInt(SearchDetails).ColNum;
  if Item.FOwner.MainTreeColumn = i then
    AT := AnsiUpperCase(Item.Text)
  else
  begin
    if Item.FStaticData <> nil then
    begin
      if Item.Cells.Count <= i then
        AT := ''
      else
        AT := AnsiUpperCase(Item.Cells[i].Text);
    end
    else
    begin
      Item.FOwner.TriggerVirtualTextNeeded(Item, i, AT);
      AT := AnsiUpperCase(AT);
    end;
  end;
  {$ifndef LMD_UNICODE}
  Result := Pos(AnsiUpperCase(StrPas(PChar(PXSRecInt(SearchDetails).Text))), AT) = 1;
  {$else}
  Result := LMDWidePos(LMDWideUpperCase(LMDWideStrPas(PWideChar(PXSRecInt(SearchDetails).Text))), AT) = 1;
  {$endif}
  end;

procedure TCustomElXTree.OnHeaderSectionLookup(Sender: TObject; Section: TElXHeaderSection; var Text: TLMDString);
var
  XSRec: TXSRecInt;
  TI: TElXTreeItem;

begin
  TriggerHeaderLookupEvent(Section, Text);
  if AutoLookup then
  begin
    XSRec.Text := PLMDChar(Text);
    XSRec.ColNum := Section.Index;
    TI := Items.LookForItemEx2(nil, Section.Index, true, False, False, True, @XSRec, IntCompare);  {<+>}
    if TI <> nil then
    begin
      if Assigned(FView.FFocused) and (FView.FFocused <> TI) then
        FView.FFocused.Selected := false;
      EnsureVisible(TI);
      ItemFocused := TI;
    end;
  end;
  end;

procedure TCustomElXTree.OnHeaderSectionLookupDone(Sender: TObject; Section: TElXHeaderSection; Text: TLMDString; Accepted: Boolean);
begin
  TriggerHeaderLookupDoneEvent(Section, Text, Accepted);
end;

procedure TCustomElXTree.OnHeaderSectionClick(Sender: TElXCustomHeader; Section: TElXHeaderSection);
var
  i, j: integer;
  ASection: TElXHeaderSection;
  LCell: TElXHeaderCell;
begin
  DoColumnClick(Section.Index);
  if TElXHackHeaderSection(Section).FClickedCellIndx = -1 then
    exit;
  LCell := Section.Cell[TElXHackHeaderSection(Section).FClickedCellIndx].JointCellMaster;
  ASection := LCell.HeaderSection;
  TElXHackHeaderSection(Section).FSortedCellIndx := TElXHackHeaderSection(Section).FClickedCellIndx;
  if ASection <> Section then
  begin
    if (LCell.JointColumnCount > 1) then
    begin
      for j := 1 to LCell.JointColumnCount - 1 do
      begin
        TElXHackHeaderSection(Header.Rows[LCell.RowIndex].Cell[LCell.Index+j].HeaderSection).FSortedCellIndx := TElXHackHeaderSection(Section).FClickedCellIndx;
      end;
    end;
  end;
//    (ASection as TElXTreeHeaderSection).FClickedCellIndx := (Section as TElXTreeHeaderSection).FClickedCellIndx;
  if (FSortMode = smClick) or (FSortMode = smAddClick) then
  begin
    IsUpdating := true;
    if (not (ssCtrl in LMDGetShiftState)) and (LCell.JointColumnCount < 2) then
    begin
      FHeader.MultiSort := false;
      if FSortSections <> nil then
        FSortSections.Clear;
      if (Section.SortMode = hsmNone) then
      begin
      end;
      if Section.SortMode = hsmAscend then
      begin
        Section.SortMode := hsmDescend;
      end
      else
      begin
        Section.SortMode := hsmAscend;
        //SortDir := sdAscend;
      end;
      if Section.SortMode <> hsmNone then
      begin
        if FSortSections = nil then
          FSortSections := TLMDObjectList.Create;
        AddSortSection(Section.Index, false);
      end;
      SortSection := Section.Index;
      FHeader.MultiSort := true;
    end
    else
    begin
      if FSortSections = nil then
        FSortSections := TLMDObjectList.Create;
      if (not (ssCtrl in LMDGetShiftState)) then
      begin
        FHeader.MultiSort := false;
        if FSortSections <> nil then
          FSortSections.Clear;
      end;
      if ASection.SortMode = hsmNone then
      begin
        ASection.SortMode := hsmAscend;
        AddSortSection(ASection.Index, false);
        if not FHeader.MultiSort then
        begin
          FHeader.MultiSort := true;
          SortSection := ASection.Index;
        end;
        for i := 1 to LCell.JointColumnCount - 1 do
        begin
          LCell.Owner.Cell[LCell.index + i].HeaderSection.SortMode := hsmAscend;
          AddSortSection(LCell.Owner.Cell[LCell.index + i].HeaderSection.Index, false);
        end;
      end
      else
      if ASection.SortMode = hsmAscend then
      begin
        ASection.SortMode := hsmDescend;
        if FSortSections.IndexOf(ASection) = -1 then
          FSortSections.Add(ASection);
        if not FHeader.MultiSort then
        begin
          FHeader.MultiSort := true;
          SortSection := ASection.Index;
        end;
        for i := 1 to LCell.JointColumnCount - 1 do
        begin
          LCell.Owner.Cell[LCell.index + i].HeaderSection.SortMode := hsmDescend;
          if FSortSections.IndexOf(LCell.Owner.Cell[LCell.index + i].HeaderSection) = -1 then
            FSortSections.Add(LCell.Owner.Cell[LCell.index + i].HeaderSection);
        end;
      end
      else
      begin
        ASection.SortMode := hsmNone;
        RemoveSortSection(ASection.Index, false);
        if not FHeader.MultiSort then
        begin
          FHeader.MultiSort := true;
          SortSection := -1;
        end;
        for i := 1 to LCell.JointColumnCount - 1 do
        begin
          LCell.Owner.Cell[LCell.index + i].HeaderSection.SortMode := hsmNone;
          RemoveSortSection(LCell.Owner.Cell[LCell.index + i].HeaderSection.Index, false);
        end;
      end;
    end;
    TriggerSortBegin;
    FItems.FRoot.Sort(true);
    with FView do
    begin
      FUpdated := true;
      FRangeUpdate := true;
      FVisUpdated := true;
    end;
    IsUpdating := false;
    TriggerSortEnd;
    Header.Refresh;
  end;
end;

procedure TCustomElXTree.OnHeaderExpand(Sender: TElXCustomHeader; Section: TElXHeaderSection);
begin
  TriggerHeaderSectionExpandEvent(Section);
  try
    IsUpdating := True;
    with FView do
    begin
      FUpdated := True;
      FClearAll := True;
    end;
    //if ShowColumns then FHeader.Repaint;
  finally
    IsUpdating := False;
  end;
end;

procedure TCustomElXTree.OnHeaderCollapse(Sender: TElXCustomHeader; Section: TElXHeaderSection);
begin
  TriggerHeaderSectionCollapseEvent(Section);
  try
    IsUpdating := True;
    with FView do
    begin
      FUpdated := True;
      FClearAll := True;
    end;
    //if ShowColumns then FHeader.Repaint;
  finally
    IsUpdating := False;
  end;
end;

procedure TCustomElXTree.DoHeaderMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
begin

  if FView.FInpEdit <> nil then
    FView.DoEndEdit(not ExplorerEditMode);

  if Assigned(FOnHeaderMouseDown) then
    FOnHeaderMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TCustomElXTree.OnSignChange(Sender: TObject);
var
  i: Integer;
begin
  if not FCustomPlusMinus then
    Exit;
  IsUpdating := True;
  if AutoLineHeight then
  begin
    i := DefineLineHeight;
    if i <> FLineHeight then
    begin
      with FView do
      begin
        FClearVis := True;
        if i < FLineHeight then
          FClearAll := True;
      end;
      FLineHeight := i;
    end;
    FView.FVisUpdated := True;
  end;
  with FView do
  begin
    FRangeUpdate := True;
    FUpdated := True;
  end;
  IsUpdating := False;
end;

function TCustomElXTree.IsHeaderFontStored: Boolean;
begin
  Result := not FHeaderUseTreeFont;
end;

function TCustomElXTree.IsFontStored: Boolean;
begin
  Result := not ParentFont;
end;

procedure TCustomElXTree.OnFontChange(Sender: TObject);
begin
  Style.FontSize := Font.Size;
  Style.FontStyles := Font.Style;
  Style.FontName := Font.Name;
  Style.TextColor := Font.Color;
  FTextColor := Font.Color;
  if not (csLoading in ComponentState) then
    ParentFont := false;
end;

function TCustomElXTree.GetHeaderWrapCaptions: Boolean;
begin
  Result := TElXTreeHeader(FHeader).WrapCaptions;
end;

procedure TCustomElXTree.SetHeaderWrapCaptions(Value: Boolean);
begin
  TElXTreeHeader(FHeader).WrapCaptions := value;
end;

procedure TCustomElXTree.SetHeaderHotTrack(value: Boolean);
begin
  FHeaderHotTrack := value;
  FHeader.Tracking := value;
end;

procedure TCustomElXTree.SetRowSelect(value: Boolean);
begin
  IsUpdating := True;
  FRowSelect := value;
  if FRowSelect = False then
    FullRowSelect := False;
  with FView do
  begin
    FClearAll := True;
    FClearVis := True;
    FUpdated := True;
  end;
  IsUpdating := False;
end;

{procedure TCustomElXTree.SetMultiCellSelect;
var
  i: Integer;
begin
  FMultiCellSelect := True;
  for i := 0 to FAllList.Count - 1 do
  begin
  end;
  for i := 0 to FView.ColorHelper.Visible.Count - 1 do
  begin
  end;
end;

procedure TCustomElXTree.SetMultiCellSelectStyle(value: TMultiCellSelectStyle);
begin
  FMultiCellSelectStyle := value;
end;

procedure TCustomElXTree.InsertRowIntoSelectedCellArray(ARowNum: Integer);
begin
end;

procedure TCustomElXTree.InsertColumnIntoSelectedCellArray(AColNum: Integer);
var
  LRow, LCol, LRowNum, LColNum: Integer;
begin
Exit;
  if csReading in ComponentState then
    Exit;
  LRowNum := FItems.Count;
  if LRowNum = 0 then
    Exit;
  LColNum := FHeader.Sections.Count;
  if LColNum = 0 then
    Exit;
  if Length(FSelectedCells) < LRowNum then
    SetLength(FSelectedCells, LRowNum);
  for LRow := 0 to LRowNum - 1 do
  begin
    SetLength(FSelectedCells[LRow], LColNum);
    for LCol := LColNum downto AColNum do
      FSelectedCells[LRow][LCol] := FSelectedCells[LRow][LCol-1];
    FSelectedCells[LRow][AColNum] := False;
  end;
end;

procedure TCustomElXTree.DeleteRowFromSelectedCellArray(ARowNum: Integer);
begin
end;

procedure TCustomElXTree.DeleteColumnFromSelectedCellArray(AColNum: Integer);
begin
end;

procedure TCustomElXTree.SetCellSelected(AItemIndex, AColumn: Integer; ASelected: Boolean);
var
  LRowNum, LColNum: Integer;
begin
  LColNum := FHeader.Sections.Count;
  if (AColumn < 0) or (AColumn > LColNum - 1) then
    Exit;
  LRowNum := FItems.Count;
  if Length(FSelectedCells) < LRowNum then
    SetLength(FSelectedCells, LRowNum);
  if Length(FSelectedCells[AItemIndex]) < LColNum then
    SetLength(FSelectedCells[AItemIndex], LColNum);
  FSelectedCells[AItemIndex][AColumn] := ASelected;
end;}

procedure TCustomElXTree.SetMultiSelect(value: Boolean);
var
  TSI: TElXTreeItem;
begin
  if Value <> FMultiSelect then
  begin
    IsUpdating := True;
    FUpdated := True;
    TSI := ItemFocused;
    if Value = True then
    begin
      FMultiSelect := True;
      FSelectedList := TLMDObjectList.Create;
      with FView do
        if FSelected <> nil then
          FSelectedList.AddAndCheckDuplicates(FSelected);
    end
    else
    begin
      DeselectAllEx(True);
      FMultiSelect := False;
      if TSI <> nil then
      begin
        TSI.Focused := True;
        TSI.Selected := True;
      end;
      FreeAndNil(FSelectedList);
    end;
    IsUpdating := False;
  end;
end;

procedure TCustomElXTree.SetMultiSelectLevel(Value: Integer);    // CNS
var TSI: TElXTreeItem;
begin
  if Value<>FMultiSelectLevel then
  begin
    IsUpdating := True;
    FUpdated := True;
    FMultiSelectLevel := value;
    TSI := ItemFocused;
    DeselectAllEx(True);  // just deselect everything on change
    if TSI <> nil then    // and reselected the focused item
    begin
      TSI.Focused := True;
      TSI.Selected := True;
    end;
    IsUpdating := False;
  end;
end;

function TCustomElXTree.DoSetFocused(value: TElXTreeItem; Forced: Boolean): Boolean;
begin
   Result := DoSetFocusedEx(value, Forced, False);
end;

function TCustomElXTree.DoSetFocusedEx(value: TElXTreeItem;
  Forced, Delayed: Boolean): Boolean;
var
  LItem: TElXTreeItem;
  FOld: TElXTreeItem;
  DoChange: Boolean;
begin
  Result := False;
  {if (value <> nil) and
     (not value.AllowSelection) then Exit;
  }
  if FView.FFocused <> Value then
  begin
    DoChange := Forced;
    DoChanging(Value, DoChange);

    if not Forced and not DoChange then
    begin
      if MultiSelect then
        FView.DoSetSelected(FView.FFocused);
      Exit;
    end;

    IsUpdating := True;
    try
      LItem := FView.FFocused;
      if Assigned(LItem) then
      begin
        LItem.FBoolData := LItem.FBoolData and not ibfFocused;
        if not MultiSelect then
          LItem.DoSetSelected(false);
        FView.FFocused := nil;
        LItem.RedrawItem(True);
        if FAutoExpand and Assigned(Value) then
        begin
          FOld := LItem;
          if AutoCollapse then
          while (FOld <> nil) and (not Value.IsUnder(FOld)) do
          begin
            FOld.Collapse(False);
            FOld := FOld.Parent;
          end; // while
          FUpdated := True;
        end;
      end;
      Result := True;
      {
      if FItemToEdit = FFocused then
        FItemToEdit := value
      else
        FView.FItemToEdit := nil;
      }
      if Assigned(FView.FEditTimer) then
        FView.FEditTimer.Enabled := False;
      FView.FFocused := value;
      if (Assigned(Value) and (not Value.Selected)) or not FAlwaysKeepSelection then
        FView.DoSetSelected(value)
      else
        if not (Assigned(Value) or MultiSelect) then
          FView.DoSetSelected(nil);
      if Assigned(FView.FFocused) then
      begin
        if (FVirtualityLevel >= vlAllProps) and not (csDesigning in ComponentState) then
          CacheItem(Value, FView.ColorHelper.Visible.Count);

        with FView do
        begin
          FFocused.FBoolData := FFocused.FBoolData or ibfFocused;
          FFocused.RedrawItem(True);
          if FAutoExpand then
            FFocused.Expand(False);
        end;
        if not (csDestroying in ComponentState) then
        begin
          with FView do
            if (ColorHelper.Visible.IndexOf(FFocused) = ColorHelper.Visible.Count - 1) and
               (GetVisiblesHeight > Height + LineHeight div 4) and (ColorHelper.Visible.Count > 1) then
              TopIndex := TopIndex + 1;
        end;
      end;
      if (FChangeDelay = 0) or (not Delayed) then
        DoItemFocused
      else
      begin
        StopDelayedFocus;
        StartDelayedFocus(FView.FFocused);
      end;
      FUpdated := True;
    finally
      IsUpdating := False;
    end;
  end;
end;

procedure TCustomElXTree.DoChanging(Item: TElXTreeItem; var AllowChange: Boolean);
begin
  if Assigned(FOnChanging) and (FFireFocusEvents = 0) then
     FOnChanging(Self, Item, AllowChange)
  else
    AllowChange := True;
end;

procedure TCustomElXTree.SetFocused(value: TElXTreeItem);
begin
  DoSetFocused(Value, false);
end;

function TCustomElXTree.GetNextSelected(Prev: TElXTreeItem): TElXTreeItem;
var i: Integer;
begin
  if not (FMultiSelect) then
  begin
    if Prev = nil then
       Result := ItemFocused
    else
       Result := nil;
    Exit;
  end;

  if (Prev = nil) and (FSelectedList.Count > 0) then
     Result := TElXTreeItem(FSelectedList[0])
  else
  begin
    i := FSelectedList.IndexOf(Prev);
    if (i <> -1) and (i < FSelectedList.Count - 1) then
       Result := TElXTreeItem(FSelectedList[i+1])
    else
       Result := nil;
  end;
end;

function TCustomElXTree.GetNextChecked(aStartItem: TElXTreeItem = nil; aIterateBackward: boolean = false; aCheckStartItem: boolean = true;
               aSubItemsOnly: boolean = false; aVisibleOnly: boolean = false; aCountCollapsed: boolean = false; aMakeFoundVisible : boolean = true; aMakeFoundSelected: boolean = true; aMakeFoundFocused: boolean = true): TElXTreeItem;
begin
  if not aIterateBackward then
    Result := Items.LookForItemEx2(aStartItem, 0, aCheckStartItem, aSubItemsOnly, aVisibleOnly, aCountCollapsed, nil, CheckIfItemIsChecked)
  else
    Result := Items.LookBackForItemEx2(aStartItem, 0, aCheckStartItem, aSubItemsOnly, aVisibleOnly, aCountCollapsed, nil, CheckIfItemIsChecked);
  if (Result <> nil) then
    begin
      if aMakeFoundVisible then
        Result.MakeVisible;
      if aMakeFoundSelected then
        Result.Selected := true;
      if aMakeFoundFocused then
        Result.Focused := true;
    end;
end;

function TCustomElXTree.GetCheckedCount(aStartItem: TElXTreeItem = nil; aCheckStartItem: boolean = true;
               aSubItemsOnly: boolean = false; aVisibleOnly: boolean = false; aCountCollapsed: boolean = false): integer;
var
  lItem: TElXTreeItem;
begin
  result := 0;
  lItem := GetNextChecked(aStartItem, false, aCheckStartItem, aSubItemsOnly, aVisibleOnly, aCountCollapsed, false, false, false);
  while lItem <> nil do
    begin
      lItem := GetNextChecked(lItem, false, false, aSubItemsOnly, aVisibleOnly, aCountCollapsed, false, false, false);
      inc(result);
    end;
end;

procedure TCustomElXTree.MakeColVisible(aColIndex: integer);
var
  w, i: integer;
begin
  if ShowColumns and (0 <= aColIndex) and (aColIndex < Header.Sections.Count) then
    begin
      w := 0;
      for i := 1 to aColIndex do
        w := w + Header.Sections[i].Width;
      SetLeftPosition(w);
    end;
end;

procedure TCustomElXTree.AllSelected(SelectedItems: TLMDObjectList);
begin
  if FMultiSelect then
    SelectedItems.Assign(FSelectedList)
  else
  begin
    SelectedItems.Clear;
    if (ItemFocused <> nil) then
      SelectedItems.Add(ItemFocused);
  end;
end;

procedure TCustomElXTree.EnsureVisibleEx(Item: TElXTreeItem; Expande: Boolean);
begin
  if IsUpdating then
    Exit;
  FView.FillVisFwd(TopIndex);

  if Item = nil then
     Exit;
  if FView.ColorHelper.Visible.IndexOf(Item) <> -1 then
    Exit;
  if (Expande) and (not Item.FullyExpanded) then
     Item.MakeFullyExpanded(True);

  if FView.ColorHelper.Visible.IndexOf(Item) <> -1 then
    Exit;

  IsUpdating := True;
  SetTopIndex(Item.VisIndex);
  FUpdated := True;
  with FView do
  begin
    FRangeUpdate := True;
    FClearAll := True;
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.EnsureVisibleBottomEx(Item: TElXTreeItem; Expande: Boolean);
begin
  if IsUpdating then
    Exit;
  if not Assigned(Item) then
    Exit;
  if FView.ColorHelper.Visible.IndexOf(Item) <> -1 then
    Exit;
  if (Expande) and (not Item.FullyExpanded) then
     Item.MakeFullyExpanded(True);
  IsUpdating := True;
  SetTopIndex(FView.CalcPageUpPos(Item.VisIndex){ + 1});
  FUpdated := True;
  FView.FRangeUpdate := True;
  FView.FClearAll := True;
  IsUpdating := False;
end;

procedure TCustomElXTree.EnsureVisible(Item: TElXTreeItem);
begin
  EnsureVisibleEx(Item, True);
end;

procedure TCustomElXTree.EnsureVisibleBottom(Item: TElXTreeItem);
begin
  EnsureVisibleBottomEx(Item, True);
end;

procedure TCustomElXTree.SetAutoLineVisibleOnly(value: Boolean);
begin
  if FAutoLineVisibleOnly <> value then
  begin
    IsUpdating := True;
    FAutoLineVisibleOnly := value;
    if value = True then
       FLineHeight := DefineLineHeight;
    FUpdated := True;
    with FView do
    begin
      FClearAll := True;
      FClearVis := True;
    end;
    FUpdated := True;
    IsUpdating := False;
  end;
end;

procedure TCustomElXTree.SetAutoLineHeight(value: Boolean);
begin
  if FAutoLineHeight = value then
     Exit;
  IsUpdating := True;
  FAutoLineHeight := value;
  if value = True then
     FLineHeight := DefineLineHeight;
  FUpdated := True;
  with FView do
  begin
    FClearAll := True;
    FClearVis := True;
  end;
  FUpdated := True;
  IsUpdating := False;
end;

procedure TCustomElXTree.SetItemIndent(value: Integer);
begin
  if FItemIndent <> Value then
  begin
    IsUpdating := True;
    FItemIndent := Value;
    FUpdated := True;
    FView.FClearAll := True;
    IsUpdating := False;
  end;
end;

procedure TCustomElXTree.SetLineHeight(value: Integer);
begin
  if (FLineHeight = value) or FAutoLineHeight then
     Exit;
  IsUpdating := True;
  FUpdated := True;
  FLineHeight := value;
  with FView do
  begin
    FClearVis := True;
    FClearAll := True;
  end;
  if value = 0 then
    FLineHeight := DefineLineHeight;
  IsUpdating := False;
end;

function TCustomElXTree.DefineLineHeight: Integer;
var
  m: Integer;
  DC: HDC;
  Metrics: TLMDTextMetric;
begin
  m := 0;
  if FShowImages then
  begin
    if (Images <> nil) then
      m := Images.Height;
    if (Images2 <> nil) then
      m := Max(m, Images2.Height);
  end;
  if FItemIndent > m then
    m := FItemIndent;
//  if Font.Height < 0 then
//     m := max(m, Abs(Font.Height) + 4)
//  else
//     m := max(m, Abs(Font.Height) + 2);
  DC := GetDC(0);
  SelectObject(DC, Font.Handle);
  LMDGetTextMetrics(DC, Metrics);
  ReleaseDC(0, DC);
  m := max(m, Metrics.tmHeight + GetSystemMetrics(SM_CYBORDER) * 4);

  if ShowCheckboxes then
  begin
    if CustomCheckboxes then
    begin
      m := Max(m, Max(FRadioButtonGlyph.Height, FCheckBoxGlyph.Height));
    end
    else
    begin
      m := max(m, FItemIndent - 2);
    end;
  end;
  Result := m;
  if FBarStyle then
    Inc(Result, 2);
  if FHorizontalLines and not (FBarStyle) then
    Inc(Result, FDivLineWidth);
end;

procedure TCustomElXTree.WMSize(var Message: TWMSize);
begin
  inherited;

  if Flat or FUseCustomScrollBars or IsThemed then
    UpdateFrame;
end;

procedure TCustomElXTree.Resize;
begin
  inherited;

  IsUpdating := True;
  AlignPieces;
  {
  with FView do
  begin
    FVisUpdated := True;
    FClearAll := True;
    FClearVis := True;
  end;
  FUpdated := True;
  }

  if RightAlignedView and HScrollBar.Visible and (HScrollBar.Position > 0) then
    SetLeftPosition(FView.FHRange);

  if IsThemed or (Flat and (BorderStyle <> bsNone)) then
    DrawFlatBorder(False, False);

  IsUpdating := False;
end;

function TCustomElXTree.GetItemRect(ItemIndex: Integer): TRect;
begin
  Result := FView.GetItemRect(ItemIndex);
  OffsetRect(Result, 0, FView.Top);
end;

procedure TCustomElXTree.OnHeaderSectionVisChange(Sender: TElXCustomHeader; Section: TElXHeaderSection); { private }
begin
  IsUpdating := True;
  with FView do
  begin
    FClearAll := True;
    FHRange := -1;
  end;
  if FAutoLineVisibleOnly then
    ResetVisItemsHeight;
  if FHeader.SectionsWidth < FView.Width then
  begin
    FHeader.Invalidate;
    SetLeftPosition(0);
  end;
  FUpdated := True;
  IsUpdating := False;
end; { OnHeaderSectionVisChange }

procedure TCustomElXTree.DoOnColumnResize(SectionIndex: Integer); { protected }
begin
  if Assigned(FOnColumnResize) then
    FOnColumnResize(self, SectionIndex);
end;

procedure TCustomElXTree.DoOnCtlClick(Sender: TObject);
begin
  if Assigned(FOnCtlClick) then
    FOnCtlClick(Self);
end;

procedure TCustomElXTree.DoOnCtlDblClick(Sender: TObject);
begin
  if Assigned(FOnCtlDblClick) then
    FOnCtlDblClick(Self);
end;

procedure TCustomElXTree.DoOnCtlMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnCtlMouseDown) then
    FOnCtlMouseDown(Self, Button, Shift, X, Y);
end;

procedure TCustomElXTree.DoOnCtlMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Assigned(FOnCtlMouseMove) then
    FOnCtlMouseMove(Self, Shift, X, Y);
end;

procedure TCustomElXTree.DoOnCtlMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnCtlMouseUp) then
    FOnCtlMouseUp(Self, Button, Shift, X, Y);
end;

{ DoOnColumnResize }

procedure TCustomElXTree.DoColumnClick(SectionIndex: Integer); { protected }
begin
  if Assigned(FOnColumnClick) then
    FOnColumnClick(self, SectionIndex);
end; { DoColumnClick }

procedure TCustomElXTree.DoItemFocused; { protected }
begin
  if Assigned(FOnItemFocused) and
     (not (csDestroying in ComponentState)) and
     (FFireFocusEvents = 0) then
    FOnItemFocused(self);
end; { DoItemFocused }

procedure TCustomElXTree.DoItemDraw(Item: TElXTreeItem; Surface: TCanvas; R: TRect; SectionIndex: Integer); { protected }
begin
  if Assigned(FOnItemDraw) then
    FOnItemDraw(Self, Item, Surface, R, SectionIndex);
end; { DoItemDraw }

procedure TCustomElXTree.DoEndEditItem(Item: TElXTreeItem; Section: TElHeaderSection; Canceled: Boolean);
begin
  if Assigned(FOnEndEdit) then
    FOnEndEdit(Self, Item, Section, Canceled);
end;

procedure TCustomElXTree.DoShowHint(Item: TElXTreeItem; Section: TElHeaderSection; var Text: TLMDString; HintWindow: THintWindow; MousePos: TPoint; var DoShowHint: Boolean); { protected }
begin
  if assigned(FOnShowHint) then
    FOnShowHint(Self, Item, Section, Text, HintWindow, MousePos, DoShowHint);
end; { DoShowHint }

procedure TCustomElXTree.DoItemChange(Item: TElXTreeItem; ItemChangeMode: TItemChangeMode); { protected }
begin
  if Assigned(FOnItemChange) then
    FOnItemChange(Self, Item, ItemChangeMode);
end; { DoOnItemChange }

procedure TCustomElXTree.DoCellChange(Item: TElXTreeItem; Cell: TElXCustomTreeCell; ItemChangeMode: TItemChangeMode);
begin
  if Assigned(FOnCellChange) then
    FOnCellChange(Self, Item, (Cell as TElXTreeCell), ItemChangeMode);
end;

procedure TCustomElXTree.DoItemExpanding(Item: TElXTreeItem; var CanProcess: Boolean); { protected }
begin
  if assigned(FOnItemExpanding) then
    FOnItemExpanding(Self, Item, CanProcess);
end; { DoItemExpanding }

procedure TCustomElXTree.DoItemCollapsing(Item: TElXTreeItem; var CanProcess: Boolean); { protected }
begin
  if assigned(FOnItemCollapsing) then
    FOnItemCollapsing(Self, Item, CanProcess);
end; { DoItemCollapsing }

procedure TCustomElXTree.DoItemChecked(Item: TElXTreeItem);  { protected }
begin
  if assigned(FOnItemChecked) then
    FOnItemChecked(Self, Item);
end;  

procedure TCustomElXTree.DoItemCheckStateChanging(Item: TElXTreeItem;
  OldValue: integer; var NewValue: integer; var AllowChange: boolean);
begin
  if assigned(FOnItemCheckStateChanging) then
    FOnItemCheckStateChanging(Self, Item, OldValue, NewValue, AllowChange);
end;

{ DoItemChecked }

procedure TCustomElXTree.DoItemExpand(Item: TElXTreeItem); { protected }
begin
  if assigned(FOnItemExpand) then
    FOnItemExpand(Self, Item);
end; { DoItemExpand }

procedure TCustomElXTree.DoItemCollapse(Item: TElXTreeItem); { protected }
begin
  if assigned(FOnItemCollapse) then
    FOnItemCollapse(Self, Item);
  Items.IterateBranch(false, HideHTMLControlsInBranch, nil, item);
end; { DoItemCollapse }

procedure TCustomElXTree.DoItemDelete(Item: TElXTreeItem); { protected }
begin
  if assigned(FOnItemDelete) then
    FOnItemDelete(Self, Item);
end; { DoItemDelete }

procedure TCustomElXTree.DoItemCreated(Item: TElXTreeItem); { protected }
begin
  if assigned(FOnItemCreated) then
    FOnItemCreated(Self, Item);
end;

procedure TCustomElXTree.DoCellDeletion(Cell: TElXCustomTreeCell); { protected }
begin
  if assigned(FOnCellDeletion) then
    FOnCellDeletion(Self, TElXTreeCell(Cell));
end; { DoCellDeletion }

procedure TCustomElXTree.DoCompareItems(Item1, Item2: TElXTreeItem; var res: Integer); { protected }
begin
  if assigned(FOnCompareItems) then
    FOnCompareItems(Self, Item1, Item2, res)
  else
    res := 0;
end; { DoCompareItems }

procedure TCustomElXTree.OnHeaderSectionChange(Sender: TElXCustomHeader; Section: TElXHeaderSection; Change: TSectionChangeMode); { protected }
begin
  case Change of
    scmAlign:
      if Section.Visible then
      begin
        IsUpdating := True;
        FView.FClearAll := True;
        IsUpdating := False;
      end;
    scmStyle:
      if FOwnerDrawByColumn and Section.Visible then
      begin
        IsUpdating := True;
        FView.FClearAll := True;
        IsUpdating := False;
      end;
    scmPassword:
      if Section.Visible then
        FView.Invalidate;//Repaint;
    scmFieldType:
      ;
//      Items.BindCellColumn(Section);
  end;
end; { OnHeaderSectionChange }

function TCustomElXTree.CreateHeader: TElXTreeHeader; { protected }
begin
  Result := TElXTreeHeader.Create(self);
end; { CreateHeader }

procedure TCustomElXTree.SetDoInplaceEdit(value: Boolean);
begin
  FDoInplaceEdit := value;
end;

procedure TCustomElXTree.InsertColumn(AIndex: Integer); //AHeaderSection: TElHeaderSection);
var
  i: Integer;
  LItem: TElXTreeItem;
begin
  for i := 0 to Items.Count - 1 do
  begin
    LItem := Items[i];
    if Assigned(LItem) then
      LItem.InsertNewCell(AIndex);
  end;
end;

procedure TCustomElXTree.CheckHeaderCount;
var
  i, n: integer;
begin
  n := max(FHeader.Sections.Count, 1);
  FHeader.FDelSectionNum := -1;
  Fheader.FAddedSectionNum := -1;
  for i := 0 to Items.Count - 1 do
  begin
    while Items[i].Cells.Count < n do
      Items[i].cells.Add;
    while Items[i].Cells.Count > n do
      Items[i].Cells.Delete(n);
  end;
end;

procedure TCustomElXTree.DeleteColumn(AIndex: Integer);
//AHeaderSection: TElHeaderSection);
var
  i: Integer;
  j: Integer;
  LCellForDelete: TElXTreeCell;
begin
  if FHeader.Sections.Count > 0 then
  begin
    LCellForDelete := nil;
    for i := 0 to Items.Count - 1 do
    begin
      if (FHeader.Sections.Count < Items[i].Cells.Count) then
        LCellForDelete := Items[i].Cells[AIndex];//DeleteCell(AIndex);

      begin
        j := 0;
        while (j <= FHeader.Sections.Count) do
        begin
          if (j <> AIndex) and (Assigned(FHeader.Sections[j])) then
            Items[i].Cells.Move(j, FHeader.Sections[j].Position);
          inc(j);
        end;
        Items[i].DeleteCell(Items[i].Cells.IndexOf(LCellForDelete));
      end;
    end;
  end;
end;

procedure TCustomElXTree.OnHeaderSectionCreate(AHeader: TElXCustomHeader; Section: TElXHeaderSection); { protected }
var
  LIndex: Integer;
begin
  if Assigned(Items[0]) and (abs(Items[0].Cells.count - FHeader.Sections.Count) > 1) then
    CheckHeaderCount
  else
    if Assigned(Section) or (FHeader.FAddedSectionNum >= 0) then
    begin
      IsUpdating := True;
      try
        FUpdated := True;
        if Assigned(Section) then
          LIndex := Section.Index
        else
          LIndex := FHeader.FAddedSectionNum;
        FHeader.FAddedSectionNum := -1;
        if LIndex <> 0 then
          InsertColumn(LIndex);
        AlignPieces;
      finally
        IsUpdating := False;
      end;
    end;
end; { OnHeaderSectionCreate }

procedure TCustomElXTree.OnHeaderSectionDelete(AHeader: TElXCustomHeader; Section: TElXHeaderSection);
begin
  if (FHeader.Sections.Count = 0) and not (csReading in ComponentState) then
    FShowColumns := False;
  IsUpdating := True;

  if not ShowColumns then
    FView.FHRange := -1
  else
    FView.FClearVis := True;

  if (Assigned(Items[0]) and (abs(Items[0].Cells.count - FHeader.Sections.Count) > 1)) or (csDesigning in ComponentState) then
    CheckHeaderCount
  else
    if (FHeader.FDelSectionNum >= 0) then
      DeleteColumn(FHeader.FDelSectionNum);

  FHeader.FDelSectionNum := -1;
  AlignPieces;
  if FSortSection >= FHeader.Sections.Count then
    FSortSection := -1;
  if (FSortSections <> nil) then
  begin
    if (Section = nil) or (FSortSections.IndexOf(Section) >= 0) then
    begin
      if (Section <> nil) then
        FSortSections.Remove(Section);
      if SortMode in [smClick, smAddClick] then
        FSortRequired := True;
    end;
  end;
  HeaderSections.Reindex;
  FUpdated := True;
  IsUpdating := False;
end;

procedure TCustomElXTree.Paint; { protected }

  procedure DrawImgForm(const R:TRect);
  var
    ACtl: TWinControl;
    ax, ay: Integer;
    P: TPoint;
    BgRect: TRect;
  begin
    ACtl := FImageForm.GetRealControl;
    BgRect := R;
    BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
    P := Parent.ClientToScreen(Point(Left, Top));
    ax := BgRect.Left - P.x;
    ay := BgRect.Top - P.y;

    BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
    BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
    BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);
    FImageForm.PaintBkgnd(Canvas.Handle, R, Point(BgRect.Left - ax, BgRect.Top - ay), False);
  end;
  procedure DrawThemeBg(var R:TRect);
  var
    LDetails: TThemedElementDetails;
  begin
    InflateRect(R, 1, 1);
    LDetails.Element := teTreeview;
    LDetails.Part := 0;
    LDetails.State := 0;
    LMDThemeServices.DrawElement(UseThemeMode, Canvas.Handle, LDetails, R, nil);
//     DrawThemeBackground(ThemeServices.Theme[teTreeView], Canvas.Handle, 0, 0, R, nil);
  end;

var
  R: TRect;
  LUseThemeMode: TLMDThemeMode;
begin
  LUseThemeMode := UseThemeMode;
  if ((Flat or FUseCustomScrollBars) and (BorderStyle = bsSingle)) or (LUseThemeMode <> ttmNone) then
    DrawFlatBorder(False, False);
  if not (FVertScrollBarVisible and FHorzScrollBarVisible) or not FUseCustomScrollBars then
    Exit;
  R := Rect(FVScrollbar.Left, FHScrollBar.Top, FVScrollBar.Left + FVScrollBar.Width, FHScrollBar.Top + FHScrollBar.Height);
  if (LUseThemeMode <> ttmNone) then
    DrawThemeBg(R)
  else
  if Assigned(FImageForm) and not (csDesigning in FImageForm.GetRealControl.ComponentState) then
    DrawImgForm(R)
  else
  with Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := Color;
    FillRect(R);
  end;
end; { Paint }

function TCustomElXTree.GetMoveColumnOnDrag: Boolean;
begin
  Result := FHeader.MoveOnDrag;
end; { GetMoveColumnOnDrag }

procedure TCustomElXTree.SetMoveColumnOnDrag(newValue: Boolean);
begin
  if (FHeader.MoveOnDrag <> newValue) then
    FHeader.MoveOnDrag := newValue;
end; { SetMoveColumnOnDrag }

procedure TCustomElXTree.SetHideHorzScrollBar(newValue: Boolean);
begin
  if (FHideHorzScrollBar <> newValue) then
  begin
    FHideHorzScrollBar := newValue;
    IsUpdating := True;
    with FView do
    begin
      FVisUpdated := True;
      FClearAll := True;
      FClearVis := True;
    end;
    FUpdated := True;
    AlignPieces;
    IsUpdating := False;
  end; { if }
end; { SetHideHorzScrollBar }

procedure TCustomElXTree.SetHideVertScrollBar(newValue: Boolean);
begin
  if (FHideVertScrollBar <> newValue) then
  begin
    FHideVertScrollBar := newValue;
    IsUpdating := True;
    with FView do
    begin
      FVisUpdated := True;
      FClearAll := True;
      FClearVis := True;
    end;
    FUpdated := True;
    AlignPieces;
    IsUpdating := False;
  end; { if }
end; { SetHideVertScrollBar }

procedure TCustomElXTree.SetUnderlineTracked(newValue: Boolean);
begin
  if (FUnderlineTracked <> newValue) then
  begin
    FUnderlineTracked := newValue;
    with FView do
      if (HotTrack or RowHotTrack) and (FTrackItem <> nil) then
        FTrackItem.RedrawItem(True);
  end; { if }
end; { SetUnderlineTracked }

procedure TCustomElXTree.SetCustomCheckboxes(newValue: Boolean);
begin
  if (FCustomCheckboxes <> newValue) then
  begin
    FCustomCheckboxes := newValue;
    if FCustomCheckboxes then
    begin
      GetCheckBoxGlyph;
      GetRadioButtonGlyph;
    end;
    if ShowCheckBoxes then
    begin
      IsUpdating := True;
      FUpdated := True;
      FView.FClearAll := True;
      IsUpdating := False;
    end;
  end; { if }
end; { SetCustomCheckboxes }

procedure TCustomElXTree.SetCheckBoxGlyph(newValue: TBitmap);
begin
  CheckBoxGlyph.Assign(newValue);

  if newValue = nil then
    CustomCheckboxes := False;
  if ShowCheckBoxes then
  begin
    IsUpdating := True;
    FUpdated := True;
    FView.FClearAll := True;
    IsUpdating := False;
  end;
end; { SetCheckBoxGlyph }

procedure TCustomElXTree.SetRadioButtonGlyph(newValue: TBitmap);
{ Sets data member FRadioButtonGlyph to newValue. }
begin
  RadioButtonGlyph.Assign(newValue);

  if newValue = nil then
    CustomCheckboxes := False;
  if ShowCheckBoxes then
  begin
    IsUpdating := True;
    FUpdated := True;
    FView.FClearAll := True;
    IsUpdating := False;
  end;
end; { SetRadioButtonGlyph }

procedure TCustomElXTree.SetShowRootButtons(newValue: Boolean);
begin
  if FShowRootButtons = newValue then
    Exit;
  IsUpdating := True;
  FShowRootButtons := newValue;
  if not ShowColumns then
    FView.FHRange := -1;
  FUpdated := True;
  FView.FRangeUpdate := True;
  IsUpdating := False;
end;

procedure TCustomElXTree.SetHideFocusRect(newValue: Boolean);
begin
  if (FHideFocusRect <> newValue) then
  begin
    FHideFocusRect := newValue;
    if (not Focused) and (HandleAllocated) then
    begin
      IsUpdating := True;
      FView.FRangeUpdate := True;
      FUpdated := True;
      IsUpdating := False;
    end;
  end; {if}
end;

function TCustomElXTree.GetLockHeaderHeight: Boolean;
begin
  Result := FHeader.LockHeight;
end; { GetLockHeaderHeight }

procedure TCustomElXTree.SetLockHeaderHeight(newValue: Boolean);
begin
  if (LockHeaderHeight <> newValue) then
    FHeader.LockHeight := newValue;
end; { SetLockHeaderHeight }

procedure TCustomElXTree.UpdateFrame;
var R: TRect;
begin
  if not HandleAllocated then
    Exit;
  R := Rect( 0, 0, Width, Height);
  if (BorderStyle = bsSingle) then
     RedrawWindow(Handle, @R, 0, rdw_Invalidate or rdw_UpdateNow or rdw_Frame );
end;

type
  TSelHackWinControl = class (TWinControl);

procedure TCustomElXTree.WMSetFocus(var Msg: TWMSetFocus);
var
  LParent: TCustomForm;  { private }
begin
  inherited;
  if Msg.FocusedWnd <> FView.Handle then
    FView.SetFocus
  else
  begin
    LParent := GetParentForm(Self);
    if Assigned(LParent) then
      TSelHackWinControl({!!!Parent}LParent).SelectNext(Self, False, True);
  end;
  if (Flat and (FInactiveBorderType <> FActiveBorderType)) or FUseCustomScrollBars then
    UpdateFrame;
end;  { WMSetFocus }

procedure TCustomElXTree.WMKillFocus(var Msg: TWMKillFocus);  { private }
begin
  inherited;
  if not HandleAllocated then
    Exit;
  if (Flat and (FInactiveBorderType <> FActiveBorderType)) or FUseCustomScrollBars then
    UpdateFrame;
end;  { WMKillFocus }

procedure TCustomElXTree.AutoSizeAllColumnsEx(VisibleOnly: Boolean);
var i: Integer;
begin
  if FAutosizingColumns then
    Exit;
  FAutosizingColumns := True;
  for i := 0 to Pred(FHeader.Sections.Count) do
    AutoSizeColumnEx(i, VisibleOnly);

  if AdjustMultilineHeight then
    ResetAllItemsHeight;
  FAutosizingColumns := False;
end;

procedure TCustomElXTree.AutoSizeColumnEx(SectionIndex: Integer; VisibleOnly: Boolean);
//var Section: TElHeaderSection;
begin
  CascadAutoSizeColumn(SectionIndex, True, VisibleOnly);
end;

procedure TCustomElXTree.CascadAutoSizeColumn(SectionIndex: Integer; NotAutoSizeOnly, VisOnly: Boolean);
var
  Section, LSection, MSection: TElXHeaderSection;
  i, j, RowIndex: integer;
  MWidth, LWidth: Integer;
begin
  if FUpdateCount > 0 then
  begin
    FColumnSizeUpdate := True;
    FUpdated := True;
    Exit;
  end;
  RowIndex := 0;
  Section := FHeader.Sections[SectionIndex];
  if Assigned(Section) and (Section.AutoSize or NotAutoSizeOnly) then
  begin
    MWidth := Max(FHeader.MeasureSectionWidth(Section, nil,nil), MeasureColumnWidth(SectionIndex, VisOnly));
    Section.Width := MWidth;
    for i := RowIndex to FHeader.RowCount - 1 do
    begin
      if (Assigned(Section.Cell[i])) and (Section.Cell[i].JointCellRole <> jcrSingle) and (Section.Cell[i].JointCellMaster.JointColumnCount > 1) then
      begin
        MSection := Section.Cell[i].JointCellMaster.HeaderSection;
      end
      else
        MSection := nil;
      if Assigned(MSection) then
      begin
        for j := MSection.Index to MSection.Index + MSection.Cell[i].JointColumnCount - 1 do
        begin
          if Assigned(FHeader.Rows[i].Cell[j]) then
          begin
            LSection := FHeader.Rows[i].Cell[j].HeaderSection;
            if Assigned(LSection) and  (LSection.AutoSize or NotAutoSizeOnly) then
            begin
              LWidth := Max(FHeader.MeasureSectionWidth(LSection, nil,nil), MeasureColumnWidth(j, VisOnly));
              if LSection.Width <> LWidth then
              begin
                LSection.Width := LWidth;
                OnHeaderSectionResize(FHeader, LSection);
              end;
            end;
          end;
        end;
      end;
    end;
    Section.Width := MWidth;
    if AdjustMultilineHeight and (not FAutosizingColumns) then
      ResetAllItemsHeight;
    OnHeaderSectionResize(FHeader, Section);
  end;
end;

procedure TCustomElXTree.AutoSizeColumn(SectionIndex: Integer);
begin
  CascadAutoSizeColumn(SectionIndex, False, True);
end;

procedure TCustomElXTree.AutoSizeAllColumns;
var
  i, j, n: Integer;
begin
  if FAutosizingColumns then
    Exit;
  if FUpdateCount > 0 then
  begin
    FUpdated := True;
    FColumnSizeUpdate := True;
    Exit;
  end;
  FAutosizingColumns := True;
//  if FHeader.RigthAndHaveGutter then
//  begin
//    j := -1;
//    n := FHeader.Sections.Count - 2;
//  end
//  else
  begin
    j := 0;
    n := FHeader.Sections.Count - 1;
  end;
  for i := j to n do
  begin
    AutoSizeColumn(i);
  end;
  if AdjustMultilineHeight then
    ResetAllItemsHeight;
  FAutosizingColumns := False;
end;

function TCustomElXTree.CanFocus: Boolean;
begin
  Result := inherited CanFocus;
end;

function TCustomElXTree.MeasureCellText(Item: TElXTreeItem; ColumnNum: Integer;
    MaxWidth: Integer; var Size: TPoint): Boolean;
var HS: TElHeaderSection;
    CurStyle: TElXCellStyle;
    FakeStaticDataEx: TElXTreeItemStaticDataEx;
    CurStaticDataEx: TElXTreeItemStaticDataEx;
    OwnFontSet: Boolean;
    xxx,
    SaveFontStyle: TFontStyles;
    SaveFontSize: Integer;
    SaveFontName: TFontName;
    cNum, AL: Integer;
    R3: TRect;
    ASize: TPoint;
    SText: TLMDString;
    LData : TLMDHTMLData;
begin
  Result := False;
  if (ColumnNum = -1)and ShowColumns then
    ColumnNum := FMainTreeColumn;
  if (ColumnNum = -1) or (ColumnNum = FMainTreeColumn) then
  begin
    FakeStaticDataEx := nil;
    CurStaticDataEx := Item.FStaticDataEx;
    if (FVirtualityLevel >= vlAllProps) and (not (csDesigning in ComponentState)) then
    begin
      if Item.FStaticDataEx <> nil then
        CurStaticDataEx := Item.FStaticDataEx
      else
      begin
        FakeStaticDataEx := TElXTreeItemStaticDataEx.Create;
        CurStaticDataEx := FakeStaticDataEx;
        TriggerVirtualPropsNeeded(Item, [vptMainText, vptStyles, vptFontStyle{, vptCheck, vptButtons, vptImages}], FakeStaticDataEx);
      end;
    end;
    if VirtualityLevel = vlNone then
    begin
      //if Item.UseStyles then
        CurStyle := Item.CurrentStyle as TElXCellStyle
      {else
        CurStyle := nil;}
    end
    else
    begin
      //if Item.UseStyles then
      //begin
        CurStyle := FView.VirtStyle;
        if (not (csDesigning in ComponentState)) then
          TriggerVirtualStyleNeeded(Item, ColumnNum, CurStyle);
      //end
      //else
      //  CurStyle := nil;
    end;
    Size.Y := FLineHeight;
    Size.X := 0;

    if (FOwnerDrawByColumn and (ShowColumns and (FHeader.Sections.Count > 0) and (FHeader.Sections.ItemByPos[ColumnNum].Style = ElhsOwnerDraw)))
      or ((Item.Text = FOwnerDrawMask) and (not (FOwnerDrawByColumn)))
      or ({Item.UseStyles and} (CurStyle.DrawStyle = elhsOwnerDraw))
    then
    begin
      ASize := Size;
      TriggerMeasureItemPartEvent(Item, ColumnNum, ASize);
      Inc(Size.X, ASize.X);
      if ((Item.FBoolData and ibfOwnerHeight) <> ibfOwnerHeight) or  (Item.Multiline and FAdjustMultilineHeight) then
        Size.Y := max(Size.Y, ASize.Y);
      Result := True;
    end
    else
    begin
      if ({CurStaticDataEx.UseStyles and} ({CurStyle.OwnerProps or} (CurStyle.DrawStyle = elhsText)))
        {or
         (not CurStaticDataEx.UseStyles)}
      then
      begin
        if {((not CurStaticDataEx.UseStyles)
        or CurStaticDataEx.UseStyles {and (CurStyle.OwnerProps))
        and }
           ShowColumns and (FHeader.Sections.ItemByPos[ColumnNum].Style = elhsImageIndex) then
        begin
          if FImages <> nil then
            Inc(Size.x, FImages.Width);
          Result := False;
        end
        else
        begin
          xxx := [];
          SaveFontStyle := Canvas.Font.Style;
          SaveFontSize := Canvas.Font.Height;
          SaveFontName := Canvas.Font.Name;
          OwnFontSet := False;
          //if CurStaticDataEx.UseStyles then
          //begin
            //if not CurStyle.OwnerProps then
            with CurStyle do
            begin
              if Canvas.Font.Name <> FontName then
              begin
                Canvas.Font.Name := FontName;
                OwnFontSet := True;
              end;
              xxx := FontStyles;
              if Canvas.Font.Size <> FontSize then
              begin
                Canvas.Font.Size := FontSize;
                OwnFontSet := True;
              end;
            end;
          if Canvas.Font.Style <> xxx then
          begin
            Canvas.Font.Style := xxx;
            OwnFontSet := True;
          end;

          AL := DT_NOPREFIX or MultiLineFlags[Item.Multiline] or
                WordWrapFlags[Item.Multiline, Item.WordWrap] or DT_VCENTER or
                DT_LEFT or DT_CALCRECT;

          if RightAlignedText then
            AL := AL or DT_RTLREADING;

          SetRectEmpty(R3);
          SText := Item.Text;

          if Item.IsHTML and LMDIsHTMLText(SText) then
          begin
            R3.Left := 0;
            R3.Top := 0;
            with FView.FRender do
            begin
              if Assigned(Item.HTMLDataArray) and Assigned(Item.HTMLDataArray[FMainTreeColumn]) then
              begin
                LData := TLMDHTMLData(Item.HTMLDataArray[FMainTreeColumn]);
                R3.Right := LData.TextSize.cx;
                R3.Bottom := LData.TextSize.cy + 2;
              end
              else
              begin
                Data.DefaultStyle := Canvas.Font.Style;
                Data.DefaultFont := Canvas.Font.Name;
                Data.DefaultHeight:= Canvas.Font.Height;
                Data.Charset := Canvas.Font.Charset;
                PrepareText(Item.Text, MaxWidth, Item.WordWrap and Item.Multiline);
                R3.Right := Data.TextSize.cx;
                R3.Bottom := Data.TextSize.cy + 2;
              end;
            end;
          end
          else
          begin
            if Item.Multiline and Item.WordWrap then
              R3.Right := R3.Left + MaxWidth;
            LMDDrawText(Canvas.Handle, SText, Length(SText), R3,  DT_NOPREFIX or AL);
          end;
          Size.Y := Max(Size.Y, R3.Bottom - R3.Top + 1);

          Inc(Size.X, R3.Right - R3.Left);
          if OwnFontSet then
          begin
            Canvas.Font.Style := SaveFontStyle;
            Canvas.Font.Height := SaveFontSize;
            Canvas.Font.Name := SaveFontName;
          end;
          Result := True;
        end;
      end
      else
      if {Item.UseStyles and} (CurStyle.DrawStyle = elhsPictureOnly) and Assigned(Item.Cells[ColumnNum].Picture) then
      begin
        Inc(Size.X, Item.Cells[ColumnNum].Picture.Width + 3);
        Result := False;
      end;
    end;
    if CurStaticDataEx = FakeStaticDataEx then
      FreeAndNil(FakeStaticDataEx);
  end
  else
  begin
    FakeStaticDataEx := nil;
    CurStaticDataEx := Item.FStaticDataEx;
    if VerticalLines and ((not BarStyle) {or BarStyleVerticalLines} or BarStyleNotRaise) then
      dec(MaxWidth);
    if (FVirtualityLevel >= vlAllProps) and (not (csDesigning in ComponentState)) then
    begin
      if Item.FStaticDataEx <> nil then
        CurStaticDataEx := Item.FStaticDataEx
      else
      begin
        FakeStaticDataEx := TElXTreeItemStaticDataEx.Create;
        CurStaticDataEx := FakeStaticDataEx;
        TriggerVirtualPropsNeeded(Item, [vptCellText, vptStyles, vptFontStyle], FakeStaticDataEx);
      end;
    end;

    HS := FHeader.Sections.ItemByPos[ColumnNum];

    OwnFontSet := False;
    CurStyle := nil;
    //if Item.UseStyles then
    //begin
      if Item.FStaticData <> nil then
      begin
        cNum := ColumnNum;
//        if cNum > FMainTreeColumn then
//          Dec(cNum);

        if (Item.Cells.Count > cNum) and (not HS.UseMainStyle) then
          CurStyle := Item.Cells[cNum].Style;
        if CurStyle = nil then
          CurStyle := Item.CurrentStyle as TElXCellStyle;
      end
      else
      begin
        CurStyle := FView.VirtStyle;
        if (not (csDesigning in ComponentState)) then
        TriggerVirtualStyleNeeded(Item, ColumnNum, CurStyle);
      end;
    //end;
    cNum := ColumnNum;

    if HS.Password then
      SText := '******'
    else
      if Item.FStaticData <> nil then
      begin
        if Item.Cells.Count <= cNum then
          SText := ''
        else
          SText := Item.Cells[cNum].Text;
      end
      else
        TriggerVirtualTextNeeded(Item, ColumnNum, SText);

    if (FOwnerDrawByColumn and (HS.Style = ElhsOwnerDraw)) or ((not (FOwnerDrawByColumn)) and (SText = FOwnerDrawMask))
      or ({CurStaticDataEx.UseStyles and} (CurStyle.DrawStyle = elhsOwnerDraw))
    then
    begin
      Size.Y := FLineHeight;
      Size.X := 0;
      TriggerMeasureItemPartEvent(Item, ColumnNum, Size);
      Result := False;
    end
    else
    if {CurStaticDataEx.UseStyles and} (CurStyle.Control <> nil) then
    begin
      Size.X := HS.Width;
      Size.Y := FLineHeight;
    end
    else
    if {Item.UseStyles and} (CurStyle.DrawStyle = elhsPictureOnly) and (Item.Cells.Count <= cNum) and Assigned(Item.Cells[CNum].Picture) then
    begin
      Size.Y := Item.Cells[cNum].Picture.Height;
      Size.X := Item.Cells[cNum].Width;
      Result := False;
    end
    else
    if ({CurStaticDataEx.UseStyles and }(CurStyle.DrawStyle = elhsText)) {or (not CurStaticDataEx.UseStyles)} then
    begin
      SaveFontStyle := Canvas.Font.Style;
      SaveFontSize := Canvas.Font.Height;
      SaveFontName := Canvas.Font.Name;
      //if CurStaticDataEx.UseStyles {and (not CurStyle.OwnerProps)} then
      with CurStyle do
      begin
        Canvas.Font.Name := FontName;
        Canvas.Font.Size := FontSize;
        Canvas.Font.Style := FontStyles;
      end;

      if MaxWidth > 0 then
        AL := DT_NOPREFIX or MultiLineFlags[Item.Multiline] or
              WordWrapFlags[Item.Multiline, Item.WordWrap] or DT_VCENTER
              or DT_LEFT or DT_CALCRECT
      else
        AL := DT_NOPREFIX or MultiLineFlags[Item.Multiline] or DT_VCENTER or
              DT_LEFT or DT_CALCRECT;

      if RightAlignedText then
        AL := AL or DT_RTLREADING;

      SetRectEmpty(R3);
      if Item.IsHTML and LMDIsHTMLText(SText) then
      begin
        if Assigned(Item.HTMLDataArray) and Assigned(Item.HTMLDataArray[ColumnNum]) then
        begin
          LData := TLMDHTMLData(Item.HTMLDataArray[ColumnNum]);
          R3.Right := LData.TextSize.cx;
          R3.Bottom := LData.TextSize.cy;
        end
        else
        begin
          with FView.FRender do
          begin
            Data.DefaultStyle := Canvas.Font.Style;
            Data.DefaultFont := Canvas.Font.Name;
            Data.DefaultHeight := Canvas.Font.Height;
            Data.Charset := Canvas.Font.Charset;

            PrepareText(SText, MaxWidth, Item.WordWrap and Item.Multiline);
            R3.Right := Data.TextSize.cx;
            R3.Bottom := Data.TextSize.cy;
          end;
        end;
      end
      else
      begin
        dec(MaxWidth, ItemIndent div 5);
        if Item.Multiline and Item.WordWrap then
          R3.Right := max(0, R3.Left + MaxWidth);
        LMDDrawText(Canvas.Handle, SText, Length(SText), R3, DT_NOPREFIX or AL);
      end;
//      InflateRect(R3, -1, -1);

      Size.X := R3.Right - R3.Left + FDivLineWidth * 2;
      Size.Y := Max(FLineHeight, R3.Bottom - R3.Top + 2);

      if OwnFontSet then
      begin
        Canvas.Font.Style := SaveFontStyle;
        Canvas.Font.Height := SaveFontSize;
        Canvas.Font.Name := SaveFontName;
      end;
      Result := True;
    end
    else
    begin
      Size.X := 0;
      Size.Y := FLineHeight;
      Result := False;
    end;
    if CurStaticDataEx = FakeStaticDataEx then
      FreeAndNil(FakeStaticDataEx);
  end;
end;

procedure TCustomElXTree.MeasureCell(Item: TElXTreeItem; ColumnNum: Integer;
    MaxWidth: Integer; var Size: TPoint);
var
    FTImages: TCustomImageList;
    StImIndex: Integer;
    FID: Boolean;
    ASize: TPoint;
    FakeStaticDataEx: TElXTreeItemStaticDataEx;
    CurStaticDataEx: TElXTreeItemStaticDataEx;
begin
  Size.Y := FLineHeight;
  Size.X := 0;

  if (ColumnNum = -1) or (ColumnNum = FMainTreeColumn) then
  begin
    FakeStaticDataEx := nil;
    CurStaticDataEx := Item.FStaticDataEx;
    if (FVirtualityLevel >= vlAllProps) and (not (csDesigning in ComponentState)) then
    begin
      if Item.FStaticDataEx <> nil then
        CurStaticDataEx := Item.FStaticDataEx
      else
      begin
        FakeStaticDataEx := TElXTreeItemStaticDataEx.Create;
        CurStaticDataEx := FakeStaticDataEx;
        TriggerVirtualPropsNeeded(Item, [vptCheck, vptButtons, vptImages, vptIndent], FakeStaticDataEx);
      end;
    end;

    if (FShowRoot and FShowLines) or (FShowButtons and FShowRootButtons) then
      Inc(Size.X, FItemIndent  * (Item.Level + 1))
    else
      Inc(Size.X, (FItemIndent div 5) * (Item.Level + 1));

//    Inc(Size.X, Item.Level * FItemIndent);

    if FShowCheckBoxes then
    begin
      if (CurStaticDataEx.FBoolData1 and ibfShowCheckBox) = ibfShowCheckBox then
      begin
        if FCustomCheckboxes then
          Inc(Size.X, FRadioButtonGlyph.Width div 6)
        else
          Inc(Size.X, CheckBoxSize);
      end;
    end;

    if (FShowImages) then
    begin

      Fid := False;
      if FImages2 <> nil then
        FTImages := FImages2
      else
        FTImages := FImages;
      if FTImages <> nil then
      begin
        if FShowEmptyImages2 then
        begin
          Inc(Size.X, FTImages.Width);
          if ShowCheckBoxes and Item.ShowCheckBox then
            Inc(Size.X, FItemIndent div 3);
          FID := True;
        end
        else
        begin
          if (Item.Focused or Item.Selected {or Item.Cut} or (Item.Expanded and Item.HasVisibleChildren)) then
            StImIndex := CurStaticDataEx.FStImageIndex2
          else
            StImIndex := CurStaticDataEx.FImageIndex2;
          if StImIndex = -1 then
            StImIndex := DoGetPicture2(Item);
          if LMDInRange(StImIndex, 0, FTImages.Count - 1) then
          begin
            Inc(Size.X, FTImages.Width);
            if ShowCheckBoxes and Item.ShowCheckBox then
              Inc(Size.X, FItemIndent div 3);
            FID := True;
          end;
        end;
      end;
      if (FImages <> nil) then
      begin
        if FShowEmptyImages then
        begin
          Inc(Size.X, FImages.Width);
          if FID or (ShowCheckBoxes and Item.ShowCheckBox) then
            Inc(Size.X, FItemIndent div 3); // make the space between images
        end
        else
        begin
          if (Item.Focused or Item.Selected {or Item.Cut} or (Item.Expanded and Item.HasVisibleChildren)) then
            StImIndex := CurStaticDataEx.FStImageIndex
          else
            StImIndex := CurStaticDataEx.FImageIndex;
          if StImIndex = -1 then
            StImIndex := DoGetPicture(Item, -1);
          //StImIndex := 2;
          if LMDInRange(StImIndex, 0, FImages.Count - 1) or FShowEmptyImages then
          begin
            Inc(Size.X, FImages.Width);
            if FID or (ShowCheckBoxes and Item.ShowCheckBox) then
              Inc(Size.X, FItemIndent div 3); // make the space between images
          end;
        end;
      end;
    end; // Show images
    if CurStaticDataEx = FakeStaticDataEx then
      FreeAndNil(FakeStaticDataEx);
    if MaxWidth <> 0 then
      Dec(MaxWidth, Size.x + FItemIndent * 3 div 5);
  end;

  if MeasureCellText(Item, ColumnNum, MaxWidth, ASize) then
    Inc(Size.x, FItemIndent * 3 div 5);
  Inc(Size.x, ASize.x);
  Size.y := ASize.y;
  if (ColumnNum = FMainTreeColumn) and (Item.IndentAdjust > 0) then
    Inc(Size.X, Item.IndentAdjust);
end;

function TCustomElXTree.MeasureColumnWidth(ColumnNum: Integer; VisibleOnly: Boolean): Integer;

{type TMeasureProc = procedure(Item: TElXTreeItem; ColumnNum: Integer; var Size: TPoint) of object;

type TXSRec = record
       MeasureProc: TMeasureProc;
       CurWidth,
       ColumnNum: Integer;
     end;
     PXSRec = ^TXSRec;

         procedure IntMeasure(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean; IterateData: pointer; Tree: TCustomElXTree);
         var P: TPoint;
         begin
           PXSRec(IterateData).MeasureProc(Item, PXSRec(IterateData).ColumnNum, P);
           if P.X > PXSRec(IterateData).CurWidth then PXSRec(IterateData).CurWidth := P.x;
         end;

var XSRec: TXSRec;
}
var i, j: Integer;
    Item: TElXTreeItem;
    CurWidth: Integer;
    P: TPoint;

begin
  if (ColumnNum >= FHeader.Sections.Count) then
  begin
    Result := 0;
    Exit;
  end;

  CurWidth := 0;
  i := 0;
  j := FAllList.Count;
  while i < j do
  begin
    Item := TElXTreeItem(FAllList[i]);

    if (FilteredVisibility and Item.Hidden and VisibleOnly) then
    begin
      i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end
    else
    begin
      MeasureCell(Item, ColumnNum, 0{FHeader.Sections[ColumnNum].Width}, P);
      if P.X > CurWidth then
        CurWidth := P.x;
      if (not Item.Expanded) and VisibleOnly then
         i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    Inc(i);
  end;
  Result := CurWidth;
  {XSRec.MeasureProc := MeasureCell;
  XSRec.ColumnNum := ColumnNum;
  Canvas.Font.Assign(Font);
  Items.Iterate(VisibleOnly, @IntMeasure, @XSRec);
  Result := XSRec.CurWidth;}
end;

procedure TCustomElXTree.HeaderSectionAutoSizeHandler(Sender: TElXCustomHeader; Section: TElXHeaderSection);
begin
  if FAutoResizeColumns then
  begin
    if Section.AutoSize then
       AutoSizeColumn(Section.Index)
    else
      CascadAutoSizeColumn(Section.Index, True, True);
  end
  else
  begin
    if Section.AutoSize then
       AutoSizeColumn(Section.Index)
    else
      HeaderSectionAutoSizeTransfer(Sender, Section);
  end;
end;  { HeaderSectionAutoSizeHandler }

procedure TCustomElXTree.HeaderSectionAutoSizeTransfer(Sender: TCustomElHeader; Section: TElHeaderSection);
{ Transfers FHeader OnSectionAutoSize event to the outside world. }
begin
  if (assigned(FOnSectionAutoSize)) then
    FOnSectionAutoSize(Self, Section.Index);  { Substitute Self for subcomponent's Sender. }
end;  { SectionAutoSizeTransfer }

procedure TCustomElXTree.HeaderSectionFilterCallTransfer(Sender: TElXCustomHeader; Section: TElXHeaderSection);
{ Transfers FHeader OnFilterCall event to the outside world. }
begin
  if (assigned(FOnSectionFilterCall)) then
    FOnSectionFilterCall(Self, Section.Index);  { Substitute Self for subcomponent's Sender. }
end;  { SectionFilterCallTransfer }

{ Exposed properties' Read/Write methods: }
procedure TCustomElXTree.SetHeaderActiveFilterColor(newValue: TColor);
{ Sets the FHeader subcomponent's ActiveFilterColor property to newValue. }
begin
  FHeader.ActiveFilterColor := newValue;
end;  { SetHeaderActiveFilterColor }

function TCustomElXTree.GetHeaderActiveFilterColor: TColor;
{ Returns the ActiveFilterColor property from the FHeader subcomponent. }
begin
  GetHeaderActiveFilterColor := FHeader.ActiveFilterColor;
end;  { GetHeaderActiveFilterColor }

procedure TCustomElXTree.SetHeaderFilterColor(newValue: TColor);
{ Sets the FHeader subcomponent's FilterColor property to newValue. }
begin
  FHeader.FilterColor := newValue;
end;  { SetHeaderFilterColor }

function TCustomElXTree.GetHeaderFilterColor: TColor;
{ Returns the FilterColor property from the FHeader subcomponent. }
begin
  GetHeaderFilterColor := FHeader.FilterColor;
end;  { GetHeaderFilterColor }

procedure TCustomElXTree.SetHeaderFlat(newValue: Boolean);
{ Sets the FHeader subcomponent's Flat property to newValue. }
begin
  FHeader.Flat := newValue;
  FHeader.Repaint;
end;  { SetHeaderFlat }

function TCustomElXTree.GetHeaderFlat: Boolean;
{ Returns the Flat property from the FHeader subcomponent. }
begin
  GetHeaderFlat := FHeader.Flat;
  FHeader.Repaint;
end;  { GetHeaderFlat }

procedure TCustomElXTree.WMEnable(var Msg: TWMEnable);  { private }
begin
  inherited;
  if (Flat or FUseCustomScrollBars) and (not IsThemed) then
    DrawFlatBorder(False, False);
end;  { WMEnable }

procedure TCustomElXTree.SetFlatFocusedScrollbars(newValue: Boolean);
{ Sets data member FFlatFocusedScrollbars to newValue. }
begin
  if (FFlatFocusedScrollbars <> newValue) then
  begin
    FFlatFocusedScrollbars := newValue;
    if Focused and (not FUseCustomScrollBars) and (not IsThemed) then
      DrawFlatBorder(False, False);
    end;  { if }
end;  { SetFlatFocusedScrollbars }

procedure TCustomElXTree.BackgroundChange(Sender: TObject);
begin
  if (Background.Empty) then
    FBackgroundType := bgtColorFill
  else
  begin
    with FView do
    begin
      RedoTmpBmp;
      if BackgroundType <> bgtColorFill then
        if not (csLoading in ComponentState) then
          Invalidate;//Repaint;
    end;
  end;
end;

procedure TCustomElXTree.SetBackground(newValue: TBitmap);
{ Sets data member FBackground to newValue. }
begin
  FBackground.Assign(newValue);
end;  { SetBackground }

procedure TCustomElXTree.SetBackgroundType(newValue: TLMDBackgroundType);
{ Sets data member FBackgroundType to newValue. }
begin
  if (FBackgroundType <> newValue) then
  begin
    if (Background.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap])
       then
         FBackgroundType := bgtColorFill
       else
         FBackgroundType := newValue;
    with FView do
    begin
      RedoTmpBmp;
      if not (csLoading in Self.ComponentState) then
        Invalidate;//Repaint;
    end;
  end;  { if }
end;  { SetBackgroundType }

procedure TCustomElXTree.SetHideSelectTextColor(newValue: TColor);
begin
  if (FHideSelectTextColor <> newValue) then
  begin
    FHideSelectTextColor := newValue;
    if (not FView.FHasFocus) and not FHideSelection then
      FView.Invalidate;
  end;  {if}
end;

procedure TCustomElXTree.SetFocusedSelectTextColor(newValue: TColor);
begin
  if FFocusedSelectTextColor <> newValue then
  begin
    FFocusedSelectTextColor := newValue;
    if FView.FHasFocus then
      FView.Invalidate;
  end;
end;

procedure TCustomElXTree.SetHideSelectColor(newValue: TColor);
begin
  if FHideSelectColor <> newValue then
  begin
    FHideSelectColor := newValue;
    if (not FView.FHasFocus) and not FHideSelection then
      FView.Invalidate;
  end;  {if}
end;

procedure TCustomElXTree.SetFocusedSelectColor(newValue: TColor);
begin
  if FFocusedSelectColor <> newValue then
  begin
    FFocusedSelectColor := newValue;
    if FView.FHasFocus then
      FView.Invalidate;
  end;
end;

procedure TCustomElXTree.SetRowCheck(const Value: boolean);
begin
  if FRowCheck <> Value then
    FRowCheck := Value;
end;

procedure TCustomElXTree.SetRowHotTrack(newValue: Boolean);
{ Sets data member FRowHotTrack to newValue. }
begin
  if (FRowHotTrack <> newValue) then
  begin
    FRowHotTrack := newValue;
    with FView do
      if (HotTrack or RowHotTrack) and (FTrackItem <> nil) then
        FTrackItem.RedrawItem(True);
  end;  { if }
end;  { SetRowHotTrack }

procedure TCustomElXTree.SetActiveBorderType(newValue: TElFlatBorderType);
{ Sets data member FActiveBorderStyle to newValue. }
begin
  if (FActiveBorderType <> newValue) then
  begin
    FActiveBorderType := newValue;
    if (FView.FHasFocus or FMouseOver) or FUseCustomScrollBars then
      UpdateFrame;
    end;  { if }
end;  { SetActiveBorderStyle }

procedure TCustomElXTree.SetInactiveBorderType(newValue: TElFlatBorderType);
{ Sets data member FInactiveBorderStyle to newValue. }
begin
  if (FInactiveBorderType <> newValue) then
  begin
    FInactiveBorderType := newValue;
    if not (FView.FHasFocus or FMouseOver) or FUseCustomScrollBars then
      UpdateFrame;
    end;  { if }
end;  { SetInactiveBorderStyle }

procedure TCustomElXTree.SetGradientStartColor(newValue: TColor);
{ Sets data member FGradientStartColor to newValue. }
begin
  if (FGradientStartColor <> newValue) then
  begin
    FGradientStartColor := newValue;
    if LMDBackgroundIsGradient(BackgroundType) and (FUpdateCount = 0) then
    with FView do
    begin
      RedoTmpBmp;
      Invalidate;//Repaint;
    end;
  end;  { if }
end;  { SetGradientStartColor }

procedure TCustomElXTree.SetGradientEndColor(newValue: TColor);
{ Sets data member FGradientEndColor to newValue. }
begin
  if (FGradientEndColor <> newValue) then
  begin
    FGradientEndColor := newValue;
    if LMDBackgroundIsGradient(BackgroundType) and (FUpdateCount = 0) then
    with FView do
    begin
      RedoTmpBmp;
      Invalidate;//Repaint;
    end;
  end;  { if }
end;  { SetGradientEndColor }

procedure TCustomElXTree.SetGradientSteps(newValue: Integer);
{ Sets data member FGradientSteps to newValue. }
begin
  if (FGradientSteps <> newValue) and (newValue > 0) then
  begin
    FGradientSteps := newValue;
    if LMDBackgroundIsGradient(BackgroundType) and (FUpdateCount = 0) then
    with FView do
    begin
      RedoTmpBmp;
      Invalidate;//Repaint;
    end;
  end;  { if }
end;  { SetGradientSteps }

function TCustomElXTree.GetHeaderImages: TCustomImageList;
{ Returns the value of data member FHeaderImages. }
begin
  Result := FHeader.Images;
end; { GetHeaderImages }

function TCustomElXTree.GetAlphaHeaderImages: TCustomImageList;
{ Returns the value of data member FHeaderImages. }
begin
  Result := FHeader.AlphaForImages;
end; { GetAlphaHeaderImages }

procedure TCustomElXTree.SetHeaderImages(newValue: TCustomImageList);
{ Sets data member FHeaderImages to newValue. }
begin
  if (FHeader.Images <> newValue) then
    FHeader.Images := newValue;
end; { SetHeaderImages }

procedure TCustomElXTree.SetAlphaHeaderImages(newValue: TCustomImageList);
{ Sets data member FHeaderImages to newValue. }
begin
  if (FHeader.AlphaForImages <> newValue) then
    FHeader.AlphaForImages := newValue;
end; { SetHeaderImages }

procedure TCustomElXTree.TriggerScrollEvent(ScrollBarKind: TScrollBarKind; ScrollCode: Integer);
begin
  if (assigned(FOnScroll)) then
    FOnScroll(Self, ScrollBarKind, ScrollCode);
end; { TriggerScrollEvent }

procedure TCustomElXTree.DeSelectAllEx(IncludeHidden: Boolean);
var
  i,
  si: Integer;
  TI: TElXTreeItem;
begin
  if FMultiSelect = False then
    Exit;
  if not IncludeHidden then
    DeselectAll
  else
  begin
    IsUpdating := True;
    i := 0;
    while i < FSelectedList.Count do
    begin
      TI := TElXTreeItem(FSelectedList[i]);
      FSelChange := True;
      TI.DoSetSelected(False);
      if FView.FSelected = TI then
        FView.FSelected := nil;
      si := FSelectedList.Count;
      TriggerItemSelectedChangeEvent(TI);
      TI.UpdateItem;
      if FSelectedList.Count < SI then
      begin
        i := 0;
        Continue;
      end;
      Inc(i);
    end;
    FSelectedList.Count := 0;
    IsUpdating := False;
  end;
end;

procedure TCustomElXTree.DeSelectAll(Notification: Boolean);
var
  i, n: Integer;
  LItem: TElXTreeItem;
  OldSelected: boolean;
begin
  FView.FMouseSel := False;
  if FMultiSelect = False then
    Exit;
  IsUpdating := True;
  n := FSelectedList.Count - 1;
  for i := 0 to n do
  begin
    LItem := TElXTreeItem(FSelectedList[0]);
//    if not (FilteredVisibility and LItem.Hidden) then
//    begin
    FSelChange := True;
    OldSelected := LItem.Selected;
    LItem.DoSetSelected(False);
// Delete the obsolete class fields
    FSelectedList.Delete(0);
    if FView.FSelected = LItem then
      FView.FSelected := nil;
//      si := FSelectedList.Count;
    if Notification and OldSelected then
      TriggerItemSelectedChangeEvent(LItem);
//    LItem.UpdateItem;
//    end;
  end;
  FView.Invalidate;
  IsUpdating := False;
end;

procedure TCustomElXTree.SelectAllEx(IncludeHidden: Boolean);
var
  i, j: Integer;
  Item: TElXTreeItem;
begin
  if FMultiSelect = False then
    Exit;
  i := 0;
  j := FAllList.Count;
  IsUpdating := True;
  while i < j do
  begin
    Item := TElXTreeItem(FAllList[i]);

    if (FilteredVisibility and (not IncludeHidden) and Item.Hidden) then
    begin
      i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end
    else
    begin
      if not Item.Selected then
        Item.DoSetSelected(True);
      if (not Item.Expanded) and (not IncludeHidden) then
         i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    Inc(i);
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.SelectAll(ASelectWithCells: boolean = false);
var
  i, j, k: Integer;
  Item: TElXTreeItem;
begin
  if FMultiSelect = False then
    Exit;
  i := 0;
  j := FAllList.Count;
  IsUpdating := True;
  while i < j do
  begin
    Item := TElXTreeItem(FAllList[i]);

    if (FilteredVisibility and Item.Hidden) then
    begin
      i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end
    else
    begin
      if not Item.Selected then
        Item.SetSelected(True);

      if (ASelectWithCells) then
      begin
        for k := 0 to Item.Cells.Count - 1 do
          Item.Cells[k].Selected := True;
      end;

      if (not Item.Expanded) and (FilteredVisibility) then
         i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    Inc(i);
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.InvertSelectionEx(IncludeHidden: Boolean);
var
  i, j: Integer;
  Item: TElXTreeItem;
begin
  if FMultiSelect = False then
    Exit;
  i := 0;
  j := FAllList.Count;
  IsUpdating := True;
  while i < j do
  begin
    Item := TElXTreeItem(FAllList[i]);

    if (FilteredVisibility and (not IncludeHidden) and Item.Hidden) then
    begin
      i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end
    else
    begin
      Item.Selected := not Item.Selected;
      if (not Item.Expanded) and (not IncludeHidden) then
         i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    Inc(i);
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.InvertSelection;
var
  i, j: Integer;
  Item: TElXTreeItem;
begin
  if FMultiSelect = False then
    Exit;
  i := 0;
  j := FAllList.Count;
  IsUpdating := True;
  while i < j do
  begin
    Item := TElXTreeItem(FAllList[i]);

    if (FilteredVisibility and Item.Hidden) then
    begin
      i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end
    else
    begin
      Item.Selected := not Item.Selected;
      if (not Item.Expanded) and (FilteredVisibility) then
         i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    Inc(i);
  end;
  IsUpdating := False;
end;

function TCustomElXTree.GetFocused: TElXTreeItem;
begin
  Result := FView.FFocused;
end;

function TCustomElXTree.GetSelected: TElXTreeItem;
begin
  Result := FView.FSelected;
end; { GetSelected }

function TCustomElXTree.GetHitColumn: integer;
begin
  Result := View.HitColumn;
end;

procedure TCustomElXTree.SetSelected(newValue: TElXTreeItem);
begin
  if not FMultiSelect then
  begin
     if Assigned(newValue) or not FAlwaysKeepSelection then
       SetFocused(newValue);
  end
  else
    if FView <> nil then
    begin
      if Assigned(newValue) or (not FAlwaysKeepSelection) or (FSelectedList.Count > 1) then
      begin
        if Assigned(FView.FSelected) then
          FView.FSelected.Selected := false;
        FView.FSelected := newValue;
        if Assigned(NewValue) and not newValue.Selected then
          newValue.Selected := True;
        SetFocused(newValue)
      end;
    end;
end; { SetSelected }

function TCustomElXTree.GetTopItem: TElXTreeItem; { public }
begin
  with FView do
    if ColorHelper.Visible.Count = 0 then
      Result := nil
    else
      Result := TElXTreeItem(ColorHelper.Visible[0]);
end; { GetTopItem }

procedure TCustomElXTree.SetTopItem(Item: TElXTreeItem); { public }
begin
  if Item = nil then
    raise EElTreeError.Create(STexInvItem);
  TopIndex := Item.VisIndex;
end; { SetTopItem }

procedure TCustomElXTree.TriggerHeaderColumnMoveEvent(Section: TElHeaderSection; OldPos, NewPos: Integer);
begin
  if (assigned(FOnHeaderColumnMove)) then
    FOnHeaderColumnMove(Self, Section, OldPos - 1, NewPos - 1);
end; { TriggerHeaderColumnMoveEvent }

procedure TCustomElXTree.TriggerTryEditEvent(Item: TElXTreeItem; SectionIndex: Integer;
  var CellType: TElFieldType; var CanEdit: Boolean);
begin
  if (assigned(FOnTryEdit)) and (not (csDestroying in ComponentState)) then
    FOnTryEdit(Self, Item, SectionIndex, CellType, CanEdit);
end;

procedure TCustomElXTree.TriggerItemSaveEvent(Stream: TStream; Item: TElXTreeItem);
begin
  if (assigned(FOnItemSave)) then
    FOnItemSave(Self, Stream, Item);
end;

procedure TCustomElXTree.TriggerItemLoadEvent(Stream: TStream; Item:
  TElXTreeItem);
begin
  if (assigned(FOnItemLoad)) then
    FOnItemLoad(Self, Stream, Item);
end;

procedure TCustomElXTree.Save;
var
  FSaveKey: string;
  F: TForm;
  S: string;
  AKey: string;
begin
  if Assigned(FStorage) then
  begin
    FSaveKey := FStorage.CurrentKey;
    F := LMDGetOwnerForm(Self);
    if (F <> nil) and (F.Name <> '') then
      S := F.Name + FStorage.Delimiter
    else
      S := '';
    AKey := FStorage.Delimiter + S + FStoragePath;
    FHeader.Storage := FStorage;
    FHeader.StoragePath := AKey;
    FHeader.Save;
    if FStorage.OpenKey(AKey, True) then
    begin
      FStorage.WriteInteger('', 'FontSize', Font.Size);
      FStorage.WriteInteger('', 'FontColor', Font.Color);
      FStorage.WriteString('', 'FontName', Font.Name);
      FStorage.WriteBool('', 'FontBold', fsBold in Font.Style);
      FStorage.WriteBool('', 'FontItalic', fsItalic in Font.Style);
      FStorage.WriteBool('', 'FontUnderline', fsUnderline in Font.Style);
      FStorage.WriteBool('', 'FontStrikeout', fsStrikeout in Font.Style);
      FStorage.WriteInteger('', 'SortType', Integer(FSortType));
      FStorage.WriteInteger('', 'SortMode', Integer(FSortMode));
      FStorage.WriteInteger('', 'SortDir', Integer(FSortDir));
      FStorage.WriteInteger('', 'SortSection', Integer(FSortSection));
    end;
    FStorage.OpenKey(FSaveKey, False);
  end;
end; {Save}

procedure TCustomElXTree.Restore;
var
  FSaveKey: string;
  i: Integer;
  b: Boolean;
  s: string;
  F: TForm;
  AKey: string;
begin
  IsUpdating := True;
  if Assigned(FStorage) then
  begin
    F := LMDGetOwnerForm(Self);
    if (F <> nil) and (F.Name <> '') then
      S := F.Name + FStorage.Delimiter
    else
      S := '';
    AKey := FStorage.Delimiter + S + FStoragePath;
    FHeader.Storage := FStorage;
    FHeader.StoragePath := AKey;
    FHeader.Restore;
    FSaveKey := FStorage.CurrentKey;
    if FStorage.OpenKey(AKey, False) then
    begin
      FStorage.ReadInteger('', 'FontSize', Font.Size, i);
      Font.Size := i;
      FStorage.ReadInteger('', 'FontColor', Font.Color, i);
      Font.Color := i;
      FStorage.ReadString('', 'FontName', Font.Name, s);
      Font.Name := s;
      FStorage.ReadBool('', 'FontBold', fsBold in Font.Style, b);
      if b then
        Font.Style := Font.Style + [fsBold]
      else
        Font.Style := Font.Style - [fsBold];
      FStorage.ReadBool('', 'FontItalic', fsItalic in Font.Style, b);
      if b then
        Font.Style := Font.Style + [fsItalic]
      else
        Font.Style := Font.Style - [fsItalic];
      FStorage.ReadBool('', 'FontUnderline', fsUnderline in Font.Style, b);
      if b then
        Font.Style := Font.Style + [fsUnderline]
      else
        Font.Style := Font.Style - [fsUnderline];
      FStorage.ReadBool('', 'FontStrikeout', fsStrikeout in Font.Style, b);
      if b then
        Font.Style := Font.Style + [fsStrikeout]
      else
        Font.Style := Font.Style - [fsStrikeout];
      FStorage.ReadInteger('', 'SortType', Integer(FSortType), i);
      FSortType := TSortTypes(i);
      FStorage.ReadInteger('', 'SortMode', Integer(FSortMode), i);
      FSortMode := TSortModes(i);
      FStorage.ReadInteger('', 'SortDir', Integer(FSortDir), i);
      FSortDir := TSortDirs(i);
      FStorage.ReadInteger('', 'SortSection', FSortSection, i);
      FSortSection := i;
    end;
    FStorage.OpenKey(FSaveKey, False);
  end;
  IsUpdating := False;
end; {Restore}

procedure TCustomElXTree.TriggerItemSelectedChangeEvent(Item: TElXTreeItem);
begin
  if (assigned(FOnItemSelectedChange)) and (not (csDestroying in ComponentState)) then
    FOnItemSelectedChange(Self, Item);
end;

{TriggerItemSelectedChangeEvent}

procedure TCustomElXTree.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if Assigned(Parent) and Parent.DoubleBuffered then
    inherited;
  Message.Result := 1;
end;

procedure TCustomElXTree.SetShowColumns(value: Boolean);
begin
  if not (csReading in ComponentState) and (Value) and (FHeader.Sections.Count = 0) then
    Exit;
  FShowColumns := value;
  if value = False then
    FView.FHRange := -1;
  //if csReading in ComponentState then Exit;
  if (FHeader = nil) then
    Exit;
  IsUpdating := True;
  FUpdated := True;

  with FView do
  begin
    FVisUpdated := True;
    FClearAll := True;
    FClearVis := True;
  end;

  if not (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then
    FView.RedoTmpBmp;

  AlignPieces;
  IsUpdating := False;
end;

procedure TCustomElXTree.SetMainTreeColumn(value: Integer);
begin
  if value = FMainTreeColumn then
    Exit;
  if value >= FHeader.Sections.Count then
    FMainTreeColumn := 0
  else
  if value >= 0 then
    FMainTreeColumn := value
  else
    Exit;
  IsUpdating := True;
  FView.FRangeUpdate := True;
  FUpdated := True;
  IsUpdating := False;
end;

procedure TCustomElXTree.DoHeaderResize(Sender: TObject);
begin
  if FView.FPainting or FIgnoreResizes then
    Exit;
  IsUpdating := True;
  FUpdated := True;
  with FView do
  begin
    FRangeUpdate := True;
    FClearVis := True;
  end;
  if FSavedHeaderHeight <> FHeader.Height then
  begin
    with FView do
    begin
      FClearAll := True;
      FVisUpdated:= True;
    end;
    AlignPieces;
  end;
  if (FHeader.LeftPos <> FLeftPosition) {or (FHeader.Width <> FLeftPosition + FView.Width)} then
  begin
    FHeader.LeftPos := FLeftPosition;
    {//LockedColumn, update
    FHeader.Left := -FLeftPosition;
    FHeader.Width := FLeftPosition + FView.Width;}
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.DoHeaderDraw(Sender: TElXCustomHeader;
    Canvas: TCanvas; Section: TElXHeaderSection; R: TRect; Pressed: boolean);
begin
  if assigned(FOnColumnDraw) then
    FOnColumnDraw(Header, Canvas, Section , R, Pressed);
end;

procedure TCustomElXTree.CMFontChanged(var Message: TMessage);
var
  i: Integer;
begin
  inherited;
  if Canvas <> nil then
  begin
    Canvas.Font.Assign(Font);
    OnFontChange(Self);
  end;
  if (FHeader <> nil) and (FHeaderUseTreeFont) then
  begin
    FHeaderFont.Assign(Font);
    FHeader.Font.Assign(Font);
    TElHeaderHack(FHeader).OnFontChange(FHeader.Font);
    end;

  ReRenderAllHTMLItems;

  if AutoLineHeight then
  begin
    i := DefineLineHeight;
    if i <> FLineHeight then
    begin
      with FView do
      begin
        FClearVis := True;
        if i < FLineHeight then
          FClearAll := True;
      end;
      FLineHeight := i;
    end;
  end;

  IsUpdating := True;
  FView.FRangeUpdate := True;
  FUpdated := True;
  IsUpdating := False;
end;

procedure TCustomElXTree.CMColorChanged(var Message: TMessage);

begin
  inherited;
  if Canvas <> nil then
    Canvas.Brush.Color := Color;
end;

function TCustomElXTree.GetHeaderRowCount: Integer;
begin
  Result := FHeader.RowCount;
end;

procedure TCustomElXTree.SetHeaderRowCount(value: Integer);
begin
//  IsUpdating := True;
  if csLoading in ComponentState then
    FHeaderRowCount := value
  else
  begin
    FHeader.RowCount := value;
//    if not (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then
//      FView.RedoTmpBmp;
  end;
//  with FView do
//  begin
//    FClearAll := True;
//    FClearVis := True;
//  end;
//  FUpdated := True;
//  IsUpdating := False;
end;

procedure TCustomElXTree.SetHeaderHeight(value: Integer);
var
  avalue: Integer;
begin
  IsUpdating := True;
  if csLoading in ComponentState then
    FHeaderHeight := value
  else
  begin
    avalue := Round(value/FHeader.RowCount);
//    FHeader.Height := avalue*FHeader.RowCount;
    FHeader.RowHeight := avalue;

    if not (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then
      FView.RedoTmpBmp;
    end;
  with FView do
  begin
    FClearAll := True;
    FClearVis := True;
  end;
  FUpdated := True;
  IsUpdating := False;
end;

function TCustomElXTree.GetHeaderHeight: Integer;
begin
  Result := FHeader.Height;
end;

procedure TCustomElXTree.SetHeaderSections(value: TElXHeaderSections);
begin
  IsUpdating := True;
  FHeader.Sections := value;
  if Assigned(FHeader.GutterSection) then
    FHeader.GutterSection.Width := FGutterWidth;
  FUpdated := True;
  FView.FRangeUpdate := True;
  IsUpdating := False;
end;

function TCustomElXTree.GetHeaderSections: TElXHeaderSections;
begin
  if Assigned(FHeader) then
    Result := FHeader.Sections
  else
    Result := nil;
end;

procedure TCustomElXTree.SaveStringsToStream(Stream: TStream);

  procedure IntSaveString(Item: TElXTreeItem);
  var
    NodeStr: string;
    begin
    NodeStr := StringOfChar(' ', Pred(Item.Level)) + Item.Text + #13#10;
    Stream.Write(Pointer(NodeStr)^, Length(NodeStr));
    end;

var
  i: Integer;
  Item: TElXTreeItem;

begin
  for i := 0 to Pred(FAllList.Count) do
  begin
    Item := TElXTreeItem(FAllList[i]);
    IntSaveString(Item);
  end;
end;

function TCustomElXTree.GetItemAtY(y: Integer): TElXTreeItem;
begin
  Result := FView.GetItemAtY(y - FView.Top);
end;

function TCustomElXTree.Focused: Boolean;
begin
  Result := FView.FHasFocus;
  Exit;
end;

procedure TCustomElXTree.FullCollapse;
var
  i: Integer;
begin
  if FItems.FRoot.FChildren = nil then
    Exit;
  IsUpdating := True;
  try
    for i := 0 to FItems.FRoot.FChildren.Count - 1 do
      TElXTreeItem(FItems.FRoot.FChildren.List[i]).Collapse(True);
  finally
    IsUpdating := False;
  end;
end;

procedure TCustomElXTree.FullExpand;
var
  i: Integer;
begin
  if FItems.FRoot.FChildren = nil then
    Exit;
  IsUpdating := True;
  try
    for i := 0 to FItems.FRoot.FChildren.Count - 1 do
      TElXTreeItem(FItems.FRoot.FChildren.List[i]).Expand(True);
  finally
    IsUpdating := False;
  end;
end;

procedure TCustomElXTree.ImageFormChange(Sender: TObject);
begin
  if not (csDesigning in ComponentState) then
    Invalidate;
end;

procedure TCustomElXTree.SetImageForm(newValue: TElImageForm);
begin
  if FImageForm <> newValue then
  begin
    if FImageForm <> nil then
      begin
        if not (csDestroying in FImageForm.ComponentState) then
          FImageForm.RemoveFreeNotification(Self);
        FImageForm.UnregisterChanges(FImgFormChLink);
      end;
    FImageForm := newValue;
    if FImageForm <> nil then
    begin
      FImageForm.RegisterChanges(FImgFormChLink);
      FImageForm.FreeNotification(Self);
    end;
    if not (csDesigning in ComponentState) then
      Invalidate;
  end;
end;

procedure TCustomElXTree.SetTextColor(value: TColor);
begin
  if FTextColor = value then
    Exit;
  FTextColor := value;
  Style.TextColor := value;
  IsUpdating := True;
  FUpdated := True;
  Font.Color := Value;
  with FView do
  begin
    FVisUpdated := True;
    FClearVis := True;
    FClearAll := True;
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.SetBackGroundColor(value: TColor);
begin
  if FBackGroundColor = value then
    Exit;
  FBackGroundColor := value;
  IsUpdating := True;
  FUpdated := True;
  with FView do
  begin
    FVisUpdated := True;
    FClearVis := True;
    FClearAll := True;
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.SetItems(value: TElXTreeItems);
begin
  FItems.Assign(value);
end;

function TCustomElXTree.CreateItemsExt(ItemClass: TElXTreeItemClass): TElXTreeItems;
begin
  Result := TElXTreeItems.CreateClass(Self, ItemClass);
end;

function TCustomElXTree.CreateItems: TElXTreeItems;
begin
  Result := TElXTreeItems.Create(Self);
end;

procedure TCustomElXTree.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin

    if AComponent = FStorage then
      Storage := nil;

    if AComponent = FImageForm then
    begin
      ImageForm := nil;
      Invalidate;
    end;
    if AComponent = Images then
    begin
      Images.UnRegisterChanges(FImageChangeLink);
      Images := nil;
    end;
    if AComponent = Images2 then
    begin
      Images2.UnRegisterChanges(FImageChangeLink);
      Images2 := nil;
    end;
    if AComponent = AlphaForImages then
    begin
      AlphaForImages.UnRegisterChanges(FAImageChangeLink);
      AlphaForImages := nil;
    end;
    if AComponent = AlphaForImages2 then
    begin
      AlphaForImages2.UnRegisterChanges(FAImageChangeLink);
      AlphaForImages2 := nil;
    end;
  end;
end;

procedure TCustomElXTree.SelectRangeEx3(FromItem, ToItem: TElXTreeItem; StartCol, EndCol: Integer; IncludeHidden, SelectDisabled, SelectCollapsedChildren, Selected: Boolean);
var i, j,
    EndIdx,
    StartIdx: Integer;
    Item,
    LItem: TElXTreeItem;
begin
  if FMultiSelect = False then
    Exit;
  if (FromItem = nil) and (ToItem = nil) then
    DeselectAll;
  if (not FilteredVisibility) or IncludeHidden then
     SelectRange3(FromItem, ToItem, StartCol, EndCol, SelectDisabled, SelectCollapsedChildren, Selected)
  else
  begin
    IsUpdating := True;
    try
      if ShowColumns then
        begin
          if StartCol = -1 then
            StartCol := max(0, HeaderSections.Count - 1);
          if EndCol = -1 then
            EndCol := max(0, HeaderSections.Count - 1);
        end;
      if FromItem = nil then
        StartIdx := FAllList.IndexOf(TElXTreeItem(View.ColorHelper.Visible.Last))
      else
        StartIdx := FromItem.AbsoluteIndex;
      if ToItem = nil then
        EndIdx := FAllList.IndexOf(TElXTreeItem(View.ColorHelper.Visible.Last))
      else
        EndIdx := ToItem.AbsoluteIndex;

      if StartIdx > EndIdx then
      begin
        i := EndIdx;
        EndIdx := StartIdx;
        StartIdx := i;
      end;
      if StartCol > EndCol then
      begin
        i := StartCol;
        StartCol := EndCol;
        EndCol := i;
      end;
      i := StartIdx;
      while i <= EndIdx do
      begin
        Item := TElXTreeItem(FAllList[i]);
        if Item.Hidden then
        begin
          LItem := Item.GetLastSubItem;
          if LItem <> nil then
             i := FAllList.IndexOfFrom(i, LItem);
        end
        else
        begin
          if SelectDisabled or (IgnoreEnabled or Item.Enabled) then
          begin
            if Selected then
            begin
              for j := StartCol to EndCol do
              begin
                if  InRange(j, 0, Item.Cells.Count - 1)  then
                  Item.Cells[j].Selected := True;
              end;
            end
            else
              Item.Selected := False;
          end;
          if StartIdx = EndIdx then
          begin
            if (not Item.Expanded) and (Item.ChildrenCount > 0) and SelectCollapsedChildren then
              SelectRangeEx3(Item.GetFirstChild, Item.GetLastChild, StartCol, EndCol, IncludeHidden, SelectDisabled, SelectCollapsedChildren, Selected );
          end
          else
            if (not Item.Expanded) and (not SelectCollapsedChildren) then
            begin
              LItem := Item.GetLastSubItem;
              if LItem <> nil then
                i := FAllList.IndexOfFrom(i, LItem);
            end;
        end;
        Inc(i);
      end;
    finally
      IsUpdating := False;
    end;
  end;
end;

procedure TCustomElXTree.SelectRangeEx2(FromItem, ToItem: TElXTreeItem; IncludeHidden, SelectDisabled, SelectCollapsedChildren: Boolean);
var i,
    EndIdx,
    StartIdx: Integer;
    Item,
    LItem: TElXTreeItem;
begin
  if FMultiSelect = False then
    Exit;
  if (FromItem = ToItem) and (FromItem <> nil) then
     Exit;
  if (not FilteredVisibility) or IncludeHidden then
     SelectRange2(FromItem, ToItem, SelectDisabled, SelectCollapsedChildren)
  else
  begin
    IsUpdating := True;
    try
      if FromItem = nil then
         StartIdx := 0
      else
         StartIdx := FromItem.AbsoluteIndex;

      if ToItem = nil then
         EndIdx := 0
      else
         EndIdx := ToItem.AbsoluteIndex;

      if StartIdx > EndIdx then
      begin
        i := EndIdx;
        EndIdx := StartIdx;
        StartIdx := i;
      end;
      i := StartIdx;
      while i < EndIdx do
      begin
        Item := TElXTreeItem(FAllList[i]);
        if Item.Hidden then
        begin
          LItem := Item.GetLastSubItem;
          if LItem <> nil then
             i := FAllList.IndexOfFrom(i, LItem);
        end
        else
        begin
          if SelectDisabled or (IgnoreEnabled or Item.Enabled) then
             Item.Selected := True;
          if (not Item.Expanded) and (not SelectCollapsedChildren) then
          begin
            LItem := Item.GetLastSubItem;
            if LItem <> nil then
              i := FAllList.IndexOfFrom(i, LItem);
          end;
        end;
        Inc(i);
      end;
    finally
      IsUpdating := False;
    end;
  end;
end;

procedure TCustomElXTree.SelectRangeEx(FromItem, ToItem: TElXTreeItem; IncludeHidden: Boolean);
begin
  SelectRangeEx2(FromItem, ToItem, IncludeHidden, True, True);
end;

procedure TCustomElXTree.SelectRange3(FromItem, ToItem: TElXTreeItem; StartCol, EndCol: Integer; SelectDisabled: Boolean; SelectCollapsedChildren, Selected: Boolean);
var
  i, j, EndIdx,
  StartIdx: Integer;
  Item, LItem: TElXTreeItem;
  FNeedNotify: Boolean;
  LCellCount: Integer;
begin
  if FMultiSelect = False then
    Exit;
//  if (FromItem = ToItem) and (FromItem <> nil) then
//    Exit;
  if ((FromItem = nil) and (ToItem = nil)) or ((StartCol = -1) and (EndCol = -1)) then
    Exit;

  IsUpdating := True;
  try
    if StartCol = -1 then
      StartCol := max(0, HeaderSections.Count - 1);
      if EndCol = -1 then
      EndCol := max(0, HeaderSections.Count - 1);

    if FromItem = nil then
       StartIdx := TElXTreeItem(View.ColorHelper.Visible.Last).AbsoluteIndex
    else
       StartIdx := FromItem.AbsoluteIndex;

    if ToItem = nil then
       EndIdx := TElXTreeItem(View.ColorHelper.Visible.Last).AbsoluteIndex
    else
       EndIdx := ToItem.AbsoluteIndex;

    if StartIdx > EndIdx then
    begin
      i := EndIdx;
      EndIdx := StartIdx;
      StartIdx := i;
    end;

    if StartCol > EndCol then
    begin
      i := StartCol;
      StartCol := EndCol;
      EndCol := i;
    end;
    i := StartIdx;
    while i <= EndIdx do
    begin
      Item := TElXTreeItem(FAllList[i]);

      if SelectDisabled or (IgnoreEnabled or Item.Enabled) then
      begin
        if Selected then
        begin
          FNeedNotify := not Item.Selected;
          LCellCount := Item.Cells.Count;
          for j := StartCol to EndCol do
          begin
            if j < LCellCount then
              Item.Cells[j].Selected := True;
          end;
          if FNeedNotify then
          begin
            if FSelectedList.IndexOf(Item) = -1 then
            begin
              FSelectedList.AddAndCheckDuplicates(Item);
              TriggerItemSelectedChangeEvent(Item);
            end;
          end;
        end
        else
          Item.Selected := False;
      end;
      if StartIdx = EndIdx then
      begin
        if (not Item.Expanded) and (Item.ChildrenCount > 0) and SelectCollapsedChildren then
          SelectRange3(Item.GetFirstChild, Item.GetLastChild,StartCol, EndCol, SelectDisabled, SelectCollapsedChildren, Selected );
      end
      else
        if (not Item.Expanded) and (not SelectCollapsedChildren) then
        begin
          LItem := Item.GetLastSubItem;
          if LItem <> nil then
            i := FAllList.IndexOfFrom(i, LItem);
        end;
      Inc(i);
    end;
  finally
    IsUpdating := False;
  end;
end;

procedure TCustomElXTree.SelectRange2(FromItem, ToItem: TElXTreeItem; SelectDisabled: Boolean; SelectCollapsedChildren: Boolean);
var i, EndIdx,
    StartIdx: Integer;
    Item, LItem: TElXTreeItem;
begin
  if FMultiSelect = False then
    Exit;
//  if (FromItem = ToItem) and (FromItem <> nil) then
//    Exit;

  IsUpdating := True;
  try
    if FromItem = nil then
       StartIdx := 0
    else
       StartIdx := FromItem.AbsoluteIndex;

    if ToItem = nil then
       EndIdx := 0
    else
       EndIdx := ToItem.AbsoluteIndex;

    if StartIdx > EndIdx then
    begin
      i := EndIdx;
      EndIdx := StartIdx;
      StartIdx := i;
    end;
    i := StartIdx;
    while i <= EndIdx do
    begin
      Item := TElXTreeItem(FAllList[i]);

      if SelectDisabled or (IgnoreEnabled or Item.Enabled) then
         Item.Selected := True;
      if (not Item.Expanded) and (not SelectCollapsedChildren) then
      begin
        LItem := Item.GetLastSubItem;
        if LItem <> nil then
          i := FAllList.IndexOfFrom(i, LItem);
      end;
      Inc(i);
    end;
  finally
    IsUpdating := False;
  end;
end;

procedure TCustomElXTree.SelectRange(FromItem, ToItem: TElXTreeItem);
begin
  SelectRange2(FromItem, ToItem, True, True);
end;

procedure TCustomElXTree.SetUseCustomScrollBars(value: Boolean);
begin
  if Value <> FUseCustomScrollBars then
  begin
    FUseCustomScrollBars := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElXTree.SetChangeStateImage(value: Boolean);
begin
  if value = FChangeStateImage then
    Exit;
  IsUpdating := True;
  FChangeStateImage := value;
  FView.FRangeUpdate := True;
  FUpdated := True;
  IsUpdating := False;
end;

procedure TCustomElXTree.SetHideSelection(value: Boolean);
begin
  if value = FHideSelection then
    Exit;
  FHideSelection := value;
  if (not Focused) and (HandleAllocated) then
  begin
    IsUpdating := True;
    FView.FRangeUpdate := True;
    FUpdated := True;
    IsUpdating := False;
  end;
end;

procedure TCustomElXTree.Assign(Source: TPersistent);
var
  T: TCustomElXTree;
  Form: TCustomForm;

begin
  if Source is TCustomElXTree then
  begin
    //inherited;
    IsUpdating := True;

    T := TCustomElXTree(Source);

    FForceALign := T.ForceAlign;
    FItems.Assign(T.FItems);
    FLinesStyle := T.FLinesStyle;
    FLinesColor := T.LinesColor;
    FDeselectChildrenOnCollapse := T.FDeselectChildrenOnCollapse;
    FDrawFocusRect := T.FDrawFocusRect;
    FBarStyle := T.FBarStyle;
    FAlwaysKeepSelection := T.FAlwaysKeepSelection;
    FFullRowSelect := T.FFullRowSelect;
    FDragType := T.FDragType;
    FAutoLookup := T.FAutoLookup;
    FSelectColumn := T.FSelectColumn;
    FAutoExpand := AutoExpand;
    PlusPicture.Assign(T.PlusPicture);
    MinusPicture.Assign(T.FMinusPicture);
    LeafPicture.Assign(T.FLeafPicture);
    FCustomPlusMinus := T.FCustomPlusMinus;
    FShowCheckboxes := T.FShowCheckboxes;
    FShowLeafButton := T.FShowLeafButton;
    FHideHorzScrollBar := T.FHideHorzScrollBar;
    FHideVertScrollBar := T.FHideVertScrollBar;

    FBackGroundColor := T.FBackGroundColor;
    FTextColor := T.FTextColor;
    FShowButtons := T.FShowButtons;
    FShowLines := T.FShowLines;
    FShowImages := T.FShowImages;

    if Assigned(T.FImages) then
      SetImages(T.FImages);
    if Assigned(T.FImages2) then
      SetImages2(T.FImages2);

    FShowRoot := T.FShowRoot;
    FLineHintMode := T.FLineHintMode;
    FShowColumns := T.ShowColumns;
    FBorderStyle := T.FBorderStyle;
    FDoInplaceEdit := T.FDoInplaceEdit;
    FHorizontalLines := T.FHorizontalLines;
    FVerticalLines := T.FVerticalLines;
    FVertScrollTracking := T.FVertScrollTracking;
    FHorzScrollTracking := T.FHorzScrollTracking;
    FHotTrack := T.FHotTrack;
    HeaderHotTrack := T.HeaderHotTrack;
    FOwnerDrawByColumn := T.FOwnerDrawByColumn;
    FOwnerDrawMask := T.FOwnerDrawMask;
    FDragTrgDrawMode := T.FDragTrgDrawMode;
    TopIndex := T.TopIndex;
    FAutoLineHeight := T.FAutoLineHeight;
    FAutoLineVisibleOnly := T.AutoLineVisibleOnly;
    FLineHeight := T.FLineHeight;

    FStripedOddColor := T.StripedOddColor;
    FStripedEvenColor := T.StripedEvenColor;
    FStripedItems := T.StripedItems;
    FStorage := T.FStorage;
    FStoragePath := T.FStoragePath;

    FUpdated := True;
    with FView do
    begin
      FHRange := -1;
      FVisUpdated := True;
      FClearVis := True;
      FClearAll := True;
    end;
    IsUpdating := False;
    if csDesigning in ComponentState then
    begin
      Form := GetParentForm(self);
      if (Form <> nil) and (Form.Designer <> nil) then
        Form.Designer.Modified;
    end;
    end
  else
    inherited;
end;

procedure TCustomElXTree.Sort(recursive: Boolean);
begin
  TriggerSortBegin;
  Inc(FInSorting);
  FItems.FRoot.Sort(recursive);
  Dec(FInSorting);
  TriggerSortEnd;
end;

procedure TCustomElXTree.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  FMouseOver := True;
  if Flat and (not FView.FHasFocus) and
     (FInactiveBorderType <> FActiveBorderType) and (not IsThemed) then
       DrawFlatBorder(False, False);
end;

procedure TCustomElXTree.CMMouseLeave(var Message: TMessage);
begin
  FMouseOver := False;
  if Flat and (not FView.FHasFocus) and
     (FInactiveBorderType <> FActiveBorderType)  and (not IsThemed) then
       DrawFlatBorder(False, False);
  inherited;
end;

function TCustomElXTree.DoGetPicture(Item: TElXTreeItem; SectionIndex: Integer): Integer;
begin
  Result := Item.ImageIndex;
  if Assigned(FOnCellPicDraw) and (SectionIndex > -1) then
    FOnCellPicDraw(Self, Item, SectionIndex, Result)
  else
    if Assigned(FOnItemPicDraw) then
      FOnItemPicDraw(self, Item, Result)
end;

function TCustomElXTree.DoGetPicture2(Item: TElXTreeItem): Integer;
begin
  Result := Item.ImageIndex2;
  if Assigned(FOnItemPicDraw2) then
    FOnItemPicDraw2(self, Item, Result);
end;

function TCustomElXTree.GetDraggableSections: Boolean;
{ Returns the value of data member FDraggableSections. }
begin
  Result := FHeader.AllowDrag;
end; { GetDraggableSections }

procedure TCustomElXTree.SetDraggableSections(newValue: Boolean);
begin
  if FHeader.AllowDrag <> newValue then
  begin
    FHeader.AllowDrag := newValue;
  end; { if }
end; { SetDraggableSections }

function TCustomElXTree.GetTreeViewAncestor: TElTreeViewAncestor;
begin
  Result := FView;
end;

procedure TCustomElXTree.OnHeaderSectionMove(Sender: TElXCustomHeader; Section: TElXHeaderSection; OldPos, NewPos: Integer); { protected }
begin
  IsUpdating := True;
  FView.FClearAll := True;
  FUpdated := True;
  IsUpdating := False;
  TriggerHeaderColumnMoveEvent(Section, OldPos, NewPos);
end; { OnHeaderSectionMove }

procedure TCustomElXTree.TriggerHotTrackEvent(OldItem, NewItem: TElXTreeItem);
begin
  if assigned(FOnHotTrack) then
    FOnHotTrack(Self, OldItem, NewItem);
end; { TriggerHotTrackEvent }

procedure TCustomElXTree.SetSortMode(newValue: TSortModes);
begin
  if FSortMode <> newValue then
    FSortMode := newValue;
end; { SetSortMode }

procedure TCustomElXTree.SetSortSection(newValue: Integer);
begin
  if FSortSection <> newValue then
  begin
    FSortSection := newValue;
//    if FSortSections <> nil then
//      FSortSections.Clear;
  end;
end; { SetSortSection }

function TCustomElXTree.GetCellStyle:TElXCellStyle;
begin
  result := FCellStyle;
end;

procedure TCustomElXTree.SetCellStyle(Value: TElXCellStyle);
begin
  if FCellStyle<>Value then
    FCellStyle.Assign(Value);
end;

procedure TCustomElXTree.SetNotRaiseForBarStyle(value: boolean);
begin
  if FNotRaiseForBarStyle<>Value then
  begin
    FNotRaiseForBarStyle := value;
    if not IsUpdating then
      Invalidate;
  end;
end;

procedure TCustomElXTree.StyleChanged(Sender: TObject);
begin
  if HandleAllocated and (not IsUpdating) then
    Invalidate;
end;

function TCustomElXTree.GetAlignmentOnSection(SectionIndex: integer): string;
begin
  Result := 'none';
  if ShowColumns then
  begin
    if RightAlignedText then
      case HeaderSections[SectionIndex].Alignment of
        hsaRight: Result := 'taLeftJustify';
        hsaLeft: Result := 'taRightJustify';
      else
        Result := 'taCenter';
      end
    else
      case HeaderSections[SectionIndex].Alignment of
        hsaRight: Result := 'taRightJustify';
        hsaLeft: Result := 'taLeftJustify';
      else
        Result := 'taCenter';
      end;
  end
  else
    if RightAlignedText then
      Result := 'taRightJustify';
end;

function TCustomElXTree.CompareItems(Item1, Item2: TElXTreeItem; SM: TElSSortMode; ST: TSortTypes; FSortSection: Integer): Integer;
var
  T1, T2: TDateTime;
  N1, N2: TLMDPtrInt;
  F1, F2: extended;
  B1, B2: Boolean;
  C1, C2: Currency;
  CurIdx: Integer;
begin
  begin
    if ST = stCustom then
    begin
      FSortSectionToCompare := FSortSection;
      DoCompareItems(Item1, Item2, result);
      if (SM = hsmDescend) or ((SM = hsmNone) and (FSortDir = sdDescend)) then
         result := -result;
    end
    else
    begin
      {$IFDEF USE_VARIANT}
      if (not VarIsEmpty(Item1.FSortData)) and (not VarIsEmpty(Item2.FSortData)) then
      {$ELSE}
      if (Item1.FSortType <> -1) and (Item2.FSortType <> -1) then
      {$ENDIF}
      begin
        {$IFDEF USE_VARIANT}
        if TVarData(Item1.FSortData).VType = TVarData(Item2.FSortData).VType then
        {$ELSE}
        if Item1.FSortType = Item2.FSortType then
        {$ENDIF}
        begin
          if ST = stText then
          begin
{$ifdef LMD_UNICODE}
            {$IFDEF USE_VARIANT}
            result := LMDSign(WideCompareText(Item1.FSortData, Item2.FSortData));
            {$ELSE}
            //if SortUseCase then
            result := LMDSign(LMDWideStrComp(PWideChar(Item1.FSortData), PWideChar(Item2.FSortData)))
            ;
            //else
            //  result := LMDSign(WideCompareText(PWideChar(WideUppercase(WideStrPas(PWidechar(Item1.FSortData)))), PWideChar(WideUppercase(WideStrPas(PWidechar(Item2.FSortData))))));
            {$ENDIF}
{$else}
            {$IFDEF USE_VARIANT}
            result := LMDSign(AnsiCompareText(Item1.FSortData, Item2.FSortData));
            {$ELSE}
            //if SortUseCase then
            result := LMDSign(AnsiStrComp(PChar(Item1.FSortData), PChar(Item2.FSortData)))
            ;
            //else
            //  result := LMDSign(AnsiStrIComp(PChar(Item1.FSortData), PChar(Item2.FSortData)));
            {$ENDIF}
{$endif}
          end
          else
          if ST = stNumber then
          begin
            {$IFDEF USE_VARIANT}
            N1 := Item1.FSortData;
            N2 := Item2.FSortData;
            {$ELSE}
            N1 := TLMDPtrInt(Item1.FSortData);
            N2 := TLMDPtrInt(Item2.FSortData);
            {$ENDIF}
            if N1 > N2 then
               result := 1
            else
            if N1 < N2 then
               result := -1
            else
               result := 0;
          end
          else
          case ST of
            stFloating:
              begin
                {$IFDEF USE_VARIANT}
                F1 := Item1.FSortData;
                F2 := Item2.FSortData;
                {$ELSE}
                F1 := PDouble(Item1.FSortData)^;
                F2 := PDouble(Item2.FSortData)^;
                {$ENDIF}
                if F1 > F2 then
                   result := 1
                else
                if F1 < F2 then
                   result := -1
                else
                   result := 0;
              end;
            stCurrency:
              begin
                {$IFDEF USE_VARIANT}
                C1 := Item1.FSortData;
                C2 := Item2.FSortData;
                {$ELSE}
                C1 := PCurrency(Item1.FSortData)^;
                C2 := PCurrency(Item2.FSortData)^;
                {$ENDIF}
                if C1 > C2 then
                   result := 1
                else
                if C1 < C2 then
                   result := -1
                else
                   result := 0;
              end;
            stDateTime:
              begin
                {$IFDEF USE_VARIANT}
                T1 := Item1.FSortData;
                T2 := Item2.FSortData;
                {$ELSE}

                T1 := PDouble(Item1.FSortData)^;
                T2 := PDouble(Item2.FSortData)^;
                {$ENDIF}
                if T1 > T2 then
                   result := 1
                else
                if T1 < T2 then
                   result := -1
                else
                   result := 0;
              end;
            stDate:
              begin
                {$IFDEF USE_VARIANT}
                T1 := Item1.FSortData;
                T2 := Item2.FSortData;
                T1 := Trunc(T1);
                T2 := Trunc(T2);
                {$ELSE}
                T1 := PDouble(Item1.FSortData)^;
                T2 := PDouble(Item2.FSortData)^;
                T1 := Trunc(T1);
                T2 := Trunc(T2);
                {$ENDIF}

                if T1 > T2 then
                   result := 1
                else
                if T1 < T2 then
                   result := -1
                else
                   result := 0;
              end;
            stTime:
              begin
                {$IFDEF USE_VARIANT}
                T1 := Item1.FSortData;
                T2 := Item2.FSortData;
                T1 := Frac(T1);
                T2 := Frac(T2);
                {$ELSE}
                T1 := PDouble(Item1.FSortData)^;
                T2 := PDouble(Item2.FSortData)^;
                T1 := Frac(T1);
                T2 := Frac(T2);
                {$ENDIF}
                if T1 > T2 then
                   result := 1
                else
                if T1 < T2 then
                   result := -1
                else
                   result := 0;
              end;
            stBoolean:
              begin
               {$IFDEF USE_VARIANT}
                B1 := Item1.FSortData;
                B2 := Item2.FSortData;
                {$ELSE}
                B1 := TLMDPtrInt(Item1.FSortData) > 0;
                B2 := TLMDPtrInt(Item2.FSortData) > 0;
                {$ENDIF}
                if B1 = B2 then
                   result := 0
                else
                if B1 then
                   result := 1
                else
                   result := -1;
              end;
          end;
        end
        else
          // if items can't be compared, they are treated as equal
          result := 0;
      end
      else
      {$IFDEF USE_VARIANT}
      if (VarIsEmpty(Item1.FSortData)) then
      begin
        if (VarIsEmpty(Item2.FSortData)) then
      {$ELSE}
      if Item1.FSortType = -1 then
      begin
        if Item2.FSortType = -1 then
      {$ENDIF}
        begin
          result := 0;
        end
        else
        begin
          result := -1;
        end;
      end
      else
      {$IFDEF USE_VARIANT}
      if (VarIsEmpty(Item2.FSortData)) then
      {$ELSE}
      if Item2.FSortType = -1 then
      {$ENDIF}
        result := 1
      ;
      if (not (SM = hsmAscend)) then
          if (SM = hsmDescend) or ((SM = hsmNone) and (FSortDir = sdDescend)) then
              result := -result;
    end;
  end;
  // he-he, multisort.
  if (result = 0) and (FSortSections <> nil) and (FSortSections.Count > 1) then
  begin
    CurIdx := 0;
    while (CurIdx < FSortSections.Count) do
    begin
      SlowCompareItems(Item1, Item2, FSortSections[CurIdx], Result);
      if (Result <> 0) then
        break;
      Inc(CurIdx);
    end;
  end;
  if (Result = 0) and (Item1 <> Item2) then
  begin
      if (TLMDPtrInt(Pointer(Item1)) > TLMDPtrInt(Pointer(Item2))) then
      Result := 1
      else
        Result := -1;
    if (not (SM = hsmAscend)) then
      if (SM = hsmDescend) or ((SM = hsmNone) and (FSortDir = sdDescend)) then
        result := -result;
  end;
end;

procedure TCustomElXTree.SlowCompareItems(Item1, Item2: TElXTreeItem; Section :
    TElHeaderSection; var Result: Integer);
var
  SectIdx: Integer;
  Text1,
  Text2: TLMDString;

  T1, T2: TDateTime;
  N1, N2: Integer;
  F1, F2: extended;
  B1, B2: Boolean;
  C1, C2: Currency;
  V: Variant;
  IntConv: Boolean;

begin
  SectIdx := Section.Index;
  IntConv := True;
  if (VirtualityLevel <> vlNone) then
  begin
    if Assigned(FOnVirtualValueNeeded) then
    begin
      IntConv := False;
      try
        case SectionTypeToSortType(Section.FieldType) of
          stCustom:
            begin
              FSortSectionToCompare := SectIdx;
              DoCompareItems(Item1, Item2, Result);
            end;
          stText :
            begin
              TriggerVirtualTextNeeded(Item1, SectIdx, Text1);
              TriggerVirtualTextNeeded(Item2, SectIdx, Text2);

              {$ifdef LMD_UNICODE}
              if SortUseCase then
                result := LMDSign(LMDWideStrComp(PWideChar(WideString(Text1)), PWideChar(WideString(Text2))))
              else
                result := LMDSign(LMDWideCompareText(PWideChar(LMDWideUppercase(Text1)), PWideChar(LMDWideUppercase(Text2))));
                {$else}

              if SortUseCase then
                result := LMDSign(AnsiStrComp(PChar(Text1), PChar(Text2)))
              else
                result := LMDSign(AnsiStrIComp(PChar(Text1), PChar(Text2)));
              {$endif}
            end;
          stNumber:
            begin
              TriggerVirtualValueNeeded(Item1, SectIdx, vtInteger, V);
              N1 := V;
              TriggerVirtualValueNeeded(Item2, SectIdx, vtInteger, V);
              N2 := V;

              if N1 < N2 then
                Result := -1
              else
              if N1 > N2 then
                Result := 1
              else
                Result := 0;
            end;
          stFloating:
            begin
              TriggerVirtualValueNeeded(Item1, SectIdx, vtExtended, V);
              F1 := V;
              TriggerVirtualValueNeeded(Item2, SectIdx, vtExtended, V);
              F2 := V;
              if F1 < F2 then
                Result := -1
              else
              if F1 > F2 then
                Result := 1
              else
                Result := 0;
            end;
          stDate,
          stTime,
          stDateTime:
            begin
              TriggerVirtualValueNeeded(Item1, SectIdx, vtExtended, V);
              T1 := V;
              TriggerVirtualValueNeeded(Item2, SectIdx, vtExtended, V);
              T2 := V;
              if T1 < T2 then
                Result := -1
              else
              if T1 > T2 then
                Result := 1
              else
                Result := 0;
            end;
          stBoolean:
            begin
              TriggerVirtualValueNeeded(Item1, SectIdx, vtBoolean, V);
              B1 := V;
              TriggerVirtualValueNeeded(Item2, SectIdx, vtBoolean, V);
              B2 := V;

              if B1 = B2 then
                 Result := 0
              else
              if B1 then
                 Result := 1
              else
                 Result := -1;
            end;
          stCurrency:
            begin
              TriggerVirtualValueNeeded(Item1, SectIdx, vtCurrency, V);
              C1 := V;
              TriggerVirtualValueNeeded(Item2, SectIdx, vtCurrency, V);
              C2 := V;

              if C1 > C2 then
                 Result := 1
              else
              if C1 < C2 then
                 Result := -1
              else
                 Result := 0;
            end;
        end;
      except
        on E: EVariantError do
          IntConv := True;
      end;
    end;
  end;

  T1 := 0;
  T2 := 0;
  if IntConv then
  begin
    FSortSectionToCompare := SectIdx;

    if SectIdx = MainTreeColumn then
    begin
      Text1 := Item1.Text;
      Text2 := Item2.Text;
    end
    else
    begin
//      if SectIdx > MainTreeColumn then
//        Dec(SectIdx);

      if SectIdx < Item1.Cells.Count then
        Text1 := Item1.Cells[SectIdx].Text
      else
        Text1 := '';
      if SectIdx < Item2.Cells.Count then
        Text2 := Item2.Cells[SectIdx].Text
      else
        Text2 := '';
    end;
    case SectionTypeToSortType(Section.FieldType) of
      stCustom:
        DoCompareItems(Item1, Item2, Result);
      stText:
        {$ifdef LMD_UNICODE}
        if SortUseCase then
          result := LMDSign(LMDWideStrComp(PWideChar(WideString(Text1)), PWideChar(WideString(Text2))))
        else
          result := LMDSign(LMDWideCompareText(PWideChar(LMDWideUppercase(Text1)), PWideChar(LMDWideUppercase(Text2))));
        {$else}

        if SortUseCase then
          result := LMDSign(AnsiStrComp(PChar(Text1), PChar(Text2)))
        else
          result := LMDSign(AnsiStrIComp(PChar(Text1), PChar(Text2)));
        {$endif}
      stNumber:
        begin
          N1 := StrToIntDef(Text1, 0);
          N2 := StrToIntDef(Text2, 0);
          if N1 < N2 then
            Result := -1
          else
          if N1 > N2 then
            Result := 1
          else
            Result := 0;
        end;
      stFloating:
        begin
          TextToFloat(PChar(String(Text1)), F1, fvExtended);
          TextToFloat(PChar(String(Text2)), F2, fvExtended);
          if F1 < F2 then
            Result := -1
          else
          if F1 > F2 then
            Result := 1
          else
            Result := 0;
        end;
      stDateTime:
        begin
          if Length(Text1) > 0 then
            T1 := StrToDateTime(Text1);
          if Length(Text2) > 0 then
            T2 := StrToDateTime(Text2);
          if T1 < T2 then
            Result := -1
          else
          if T1 > T2 then
            Result := 1
          else
            Result := 0;
        end;
      stDate:
        begin
          if Length(Text1) > 0 then
            T1 := StrToDate(Text1);
          if Length(Text2) > 0 then
            T2 := StrToDate(Text2);
          if T1 < T2 then
            Result := -1
          else
          if T1 > T2 then
            Result := 1
          else
            Result := 0;
        end;
      stTime:
        begin
          if Length(Text1) > 0 then
            T1 := StrToTime(Text1);
          if Length(Text2) > 0 then
            T2 := StrToTime(Text2);
          if T1 < T2 then
            Result := -1
          else
          if T1 > T2 then
            Result := 1
          else
            Result := 0;
        end;
      stBoolean:
        begin
          B1 := Text1 <> '';
          B2 := Text2 <> '';
          if B1 = B2 then
             Result := 0
          else
          if B1 then
             Result := 1
          else
             Result := -1;
        end;
      stCurrency:
        begin
          C1 := LMDPrettyStrToCurr(Text1);
          C2 := LMDPrettyStrToCurr(Text2);
          if C1 > C2 then
             Result := 1
          else
          if C1 < C2 then
             Result := -1
          else
             Result := 0;
        end;
    end;
  end;
  {
  if (Result = 0) and (Item1 <> Item2) then
    if (Integer(Pointer(Item1)) > Integer(Pointer(Item2))) then
      Result := 1
    else
      Result := -1;
  }
  if Section.SortMode = hsmDescend then
    Result := -Result;
end;

procedure TCustomElXTree.Update;
begin
  inherited;
end;

function TCustomElXTree.SetByFullName(FullName: TLMDString; Separator: TLMDChar; StartItem: TElXTreeItem = nil): Boolean;
var
  LItemName: TLMDString;
  i: integer;
  Start, LFullName: PLMDChar;
begin
  Result := False;
  LFullName := PLMDChar(FullName);
  if (LFullName^ = Separator) then
  inc(LFullName);
  Start := LFullName;
  while (LFullName^ <> #0) and (LFullName^ <> Separator) do
  begin
    inc(LFullName);
  end;

  SetString(LItemName, Start, LFullName - Start);
  if Length(LItemName) > 0 then
  begin
    if StartItem = nil then
    begin
      for i := 0 to Items.FRoot.Count - 1 do
      begin
        if Items.RootItem[i].Text = LItemName then
        begin
          if Length(LFullName) < 2 then
          begin
            Result := True;
            DeselectAll;
            Items.RootItem[i].Selected := True;
            Items.RootItem[i].Focused := True;
            Items.RootItem[i].FullyExpanded := True;
          end
          else
            Result := SetByFullName(LFullName, Separator, Items.RootItem[i]) ;
            if Result then
            Break;
        end;
      end;
    end
    else
    begin
      for i := 0 to StartItem.Count - 1 do
      begin
        if StartItem.Children[i].Text = LItemName then
        begin
          if Length(LFullName) < 2 then
          begin
            Result := True;
            DeselectAll;
            StartItem.Children[i].Selected := True;
            StartItem.Children[i].Focused := True;
            StartItem.Children[i].FullyExpanded := True
          end
          else
            Result := SetByFullName(LFullName, Separator, StartItem.Children[i]) ;
            if Result then Break;
        end;
      end;
    end;
  end;
end;

function TCustomElXTree.IsEditing: Boolean;
begin
  Result := (FView.FInpEdit <> nil) and FView.FInpEdit.Visible and FView.FInpEdit.Editing;
  // Result := FView.FEditing;
end;

procedure TCustomElXTree.SetStorage(newValue: TElIniFile);
begin
  if newValue <> FStorage then
  begin
    if FStorage <> nil then
      if not (csDestroying in FStorage.ComponentState) then
        FStorage.RemoveFreeNotification(Self);
    FStorage := newValue;
    if FStorage <> nil then
      FStorage.FreeNotification(Self);
  end;
end;

function TCustomElXTree.GetNodeAt(X, Y: Integer): TElXTreeItem; { public }
begin
  Result := GetItemAtY(Y);
end; { GetNodeAt }

procedure TCustomElXTree.SetShowCheckboxes(newValue: Boolean);
begin
  if (FShowCheckboxes <> newValue) then
  begin
    IsUpdating := True;
    FShowCheckboxes := newValue;
    with FView do
    begin
      if not ShowColumns then
        FView.FHRange := -1;
      FClearAll := True;
    end;
    FUpdated := True;
    IsUpdating := False;
  end; {if}
end; {SetShowCheckboxes}

procedure TCustomElXTree.SetPlusPicture(newValue: TBitmap);
begin
  PlusPicture.Assign(newValue);
end;

procedure TCustomElXTree.SetPlusPosition(const Value: TLMDVerticalAlign);
begin
  if Assigned(FView) then
    FView.PlusPosition := Value;
end;

{SetPlusPicture}

procedure TCustomElXTree.SetMinusPicture(newValue: TBitmap);
begin
  MinusPicture.Assign(newValue);
end; {SetMinusPicture}

procedure TCustomElXTree.SetCustomPlusMinus(newValue: Boolean);
begin
  if (FCustomPlusMinus <> newValue) then
  begin
    IsUpdating := True;
    FCustomPlusMinus := newValue;
    if FCustomPlusMinus then
    begin
      GetPlusPicture;
      GetMinusPicture;
      GetLeafPicture;
    end;
    with FView do
    begin
      if not ShowColumns then
        FView.FHRange := -1;
      FClearAll := True;
    end;
    FUpdated := True;
    IsUpdating := False;
  end; {if}
end; {SetCustomPlusMinus}

procedure TCustomElXTree.SetSelectColumn(newValue: Integer);
begin
  if (FSelectColumn <> newValue) then
  begin
    if (newValue > -2) and ((newValue < FHeader.Sections.Count) or
       (csLoading in ComponentState)) then
    begin
      FSelectColumn := newValue;
      if Assigned(Selected) and LMDInRange(newValue, 0, HeaderSections.Count - 1) then
      begin
        Selected.DoSetSelected(false);
        Selected.Cells[newValue].Selected := True;
      end;
      if FView.FEditTimer <> nil then
        FView.FEditTimer.Enabled := False;
      if not FRowSelect then
      begin
        if not FMultiSelect then
        begin
          with FView do
            if Assigned(FFocused) then
              FFocused.UpdateItem;
        end
        else
        begin
          IsUpdating := True;
          FView.FClearAll := True;
          FUpdated := True;
          IsUpdating := False;
        end; // if/else
      end; //if
    end; // if
  end;
end; {SetSelectColumn}

procedure TCustomElXTree.TriggerHeaderLookupEvent(Section: TElHeaderSection; var Text: TElFString);
begin
  if (assigned(FOnHeaderLookup)) then
    FOnHeaderLookup(Self, Section, Text);
end; {TriggerHeaderLookupEvent}

procedure TCustomElXTree.TriggerHeaderLookupDoneEvent(Section: TElHeaderSection; Text: TLMDString;
  Accepted: Boolean);
begin
  if (assigned(FOnHeaderLookupDone)) then
    FOnHeaderLookupDone(Self, Section, Text, Accepted);
end; {TriggerHeaderLookupDoneEvent}

procedure TCustomElXTree.TriggerHeaderSectionExpandEvent(Section: TElXHeaderSection);
begin
  if (assigned(FOnHeaderSectionExpand)) then
    FOnHeaderSectionExpand(FHeader, Section);
end;

procedure TCustomElXTree.HeaderSectionCellClickTransfer(Sender: TElXCustomHeader; Section: TElXHeaderSection; Cell: TElXHeaderCell);
begin
  if (assigned(FOnHeaderSectionCellClick)) then
    FOnHeaderSectionCellClick(FHeader, Section, Cell);
end;

procedure TCustomElXTree.TriggerHeaderSectionCollapseEvent(Section: TElXHeaderSection);
begin
  if (assigned(FOnHeaderSectionCollapse)) then
    FOnHeaderSectionCollapse(FHeader, Section);
end;

procedure TCustomElXTree.ScrollBarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (not FView.Focused) and FView.CanFocus and CanFocus {and
     (not (csDesigning in ComponentState))} then
      FView.SetFocus;
end;

procedure TCustomElXTree.SBChanged(Sender: TObject);
begin
  if (not FIgnoreSBChange) and (not (csLoading in ComponentState)) and ((Owner = nil) or (not (csLoading in Owner.ComponentState))) then
  begin
    AlignPieces;
    UpdateScrollBars;
  end;
end;

procedure TCustomElXTree.ReadState(Reader: TReader);
begin
// restore default values
  FHScrollBar.AltDisablingArrows := false;
  FHScrollBar.IsHTML := false;
  FVScrollBar.ShowTrackHint := false;
  FVScrollBar.AltDisablingArrows := false;
  FVScrollBar.IsHTML := false;
  inherited;
end;

procedure TCustomElXTree.Loaded;
var
  DT: TElDragType;
  SS: TScrollStyle;
  AValue: Integer;
  i: integer;
begin
  inherited;
  IsUpdating := True;
  FHeader.RightAlignedOrder := FRightAlignedView;
  FHeader.Loaded;
  for i := 0 to HeaderSections.Count - 1 do
  begin
    if (FHeader.Sections[i].SortMode <> hsmNone) then
    begin
      if (FSortSection = -1) then
        FSortSection := i;
      if FHeader.MultiSort then
      begin
        if FSortSections = nil then
          FSortSections := TLMDObjectList.Create;
        FSortSections.Add(FHeader.Sections[i]);
      end;
    end;
  end;
  if (FSortMode = smAdd) or (FSortMode = smAddClick) then
  begin
    TriggerSortBegin;
    FItems.FRoot.Sort(True);
    TriggerSortEnd;
  end;
  FUpdated := True;
  FView.FClearAll := True;

  if HandleAllocated then
  begin
    DT := FDragType;
    FDragType := dtDelphi;
    DragType := DT;
    OnFontChange(Font);
  end;

  ReRenderAllHTMLItems;
  if SelectColumn >= FHeader.Sections.Count then
    SelectColumn := -1;
  FHScrollBar.Loaded;
  FVScrollBar.Loaded;
  if FHeader.Height <> FHeaderHeight then
  begin
    AValue := Round(FHeaderHeight/FHeaderRowCount);
    FHeader.RowHeight := avalue;
    Resize;
    if not (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then
      FView.RedoTmpBmp;
    end
  else
    Resize;
  if FHeader.RowCount <> FHeaderRowCount then
  begin
    FHeader.RowCount := FHeaderRowCount;
    Resize;
    if not (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then
      FView.RedoTmpBmp;
    end
  else
    Resize;
  if FForcedScrollBars <> ssNone then
  begin
    SS := FForcedScrollBars;
    FForcedScrollBars := ssNone;
    ForcedScrollBars := SS;
  end;
  if FHeaderUseTreeFont then
    FHeader.Font := Font
  else
    FHeader.Font := FHeaderFont;
//  if FHeader.Sections.Count = 0 then
//    FHeader.Sections.AddSection;
  //<-- init Style font settings vb
  if FTextColor <> Font.Color then
    Font.Color := FTextColor;
  FCellStyle.FontSize := Font.Size;
  FCellStyle.FontStyles := Font.Style;
  FCellStyle.FontName := Font.Name;
  //-->

  AutoSizeAllColumns;
  IsUpdating := False;
end;

procedure TCustomElXTree.SetDragType(newValue: TElDragType);
begin
  if (FDragType <> newValue) then
  begin
    if newValue = dtDelphi then
      FreeAndNil(FDropTarget)
    else
    begin
      if (FDragType = dtDelphi) and FView.HandleAllocated and (not (csLoading in ComponentState))
        and (FDropTarget = nil)
        then // when switching from one to another OLE mode we don't create a drop target

      begin

        FDropTarget := TElDropTarget.Create(nil);
        FDropTarget.Target := FView;
        FDropTarget.OnTargetDrag := FView.OnDropTargetDrag;
        FDropTarget.OnTargetDrop := FView.OnDropTargetDrop;

      end;
    end;
    FDragType := newValue;
  end; {if}
end; {SetDragType}

procedure TCustomElXTree.TriggerOleTargetDragEvent(State: TDragState;
  Source: TOleDragObject; Shift: TShiftState; X, Y: Integer;
  var DragType: TDragType);
begin
  Y := Y + FView.Top;
  X := X + FView.Left;
  if (assigned(FOnOleTargetDrag)) then
    FOnOleTargetDrag(Self, State, Source, Shift, X, Y, DragType);
end; {TriggerOleTargetDragEvent}

procedure TCustomElXTree.TriggerOleTargetDropEvent(Source: TOleDragObject;
  Shift: TShiftState; X, Y: Integer; var DragType: TDragType);
begin
  Y := Y + FView.Top;
  X := X + FView.Left;
  if (assigned(FOnOleTargetDrop)) then
    FOnOleTargetDrop(Self, Source, Shift, X, Y, DragType);
end; {TriggerOleTargetDropEvent}

procedure TCustomElXTree.TriggerOleDragStartEvent(var dataObj: IDataObject;
  var dropSource: IDropSource; var dwOKEffects: TDragTypes);
begin
  if (assigned(FOnOleDragStart)) then
    FOnOleDragStart(Self, dataObj, dropSource, dwOKEffects);
end; {TriggerOleDragStartEvent}

procedure TCustomElXTree.TriggerOleDragFinishEvent(dwEffect: TDragType; Result: HResult);
begin
  if (assigned(FOnOleDragFinish)) then
    FOnOleDragFinish(Self, dwEffect, Result);
end; {TriggerOleDragFinishEvent}

procedure TCustomElXTree.HeaderResizeTransfer(Sender: TObject);
begin
  if (assigned(FOnHeaderResize)) then
    FOnHeaderResize(Self);
end;

procedure TCustomElXTree.HeaderResizeHandler(Sender: TObject);
begin
  DoHeaderResize(Sender);
  HeaderResizeTransfer(Self);
end;

function TCustomElXTree.IsInView(Item: TElXTreeItem): Boolean;
begin
  Result := FView.ColorHelper.Visible.IndexOf(Item) <> -1;
end;

function TCustomElXTree.SectionTypeToSortType(SectionType: TElFieldType):
  TSortTypes;
begin
  case SectionType of
    sftText: Result := stText;
    sftNumber: Result := stNumber;
    sftFloating: Result := stFloating;
    sftDateTime: Result := stDateTime;
    sftDate: Result := stDate;
    sftTime: Result := stTime;
    sftBool: Result := stBoolean;
    sftCurrency: Result := stCurrency;
  else
    Result := stCustom;
  end;
end;

function TCustomElXTree.GetStickyHeaderSections: Boolean;
begin
  Result := FHeader.StickySections;
end; {GetStickyHeaderSections}

procedure TCustomElXTree.SetStickyHeaderSections(newValue: Boolean);
begin
  FHeader.StickySections := newValue;
  AlignPieces;
end; {SetStickyHeaderSections}

procedure TCustomElXTree.SetBarStyle(newValue: Boolean);
begin
  if (FBarStyle <> newValue) then
  begin
    IsUpdating := True;
    FBarStyle := newValue;
    if FBarStyle then
    begin
      BackGroundColor := clBtnFace;
      TextColor := clBtnText;
      LinesColor := clBtnShadow;
    end;
    if FAutoLineHeight then
      FLineHeight := DefineLineHeight;
    with FView do
    begin
      if not ShowColumns then
        FHRange := -1;
      FClearAll := True;
    end;
    FUpdated := True;
    IsUpdating := False;
  end; {if}
end;

{SetBarStyle}

procedure TCustomElXTree.SetDrawFocusRect(newValue: Boolean);
begin
  if (FDrawFocusRect <> newValue) then
  begin
    FDrawFocusRect := newValue;
    if ItemFocused <> nil then
      ItemFocused.RedrawItem(True);
  end; {if}
end; {SetDrawFocusRect}

procedure TCustomElXTree.TriggerMeasureItemPartEvent(Item: TElXTreeItem; PartIndex: Integer; var Size: TPoint);
begin
  if (assigned(FOnMeasureItemPart)) then
    FOnMeasureItemPart(Self, Item, PartIndex, Size);
end; {TriggerMeasureItemPartEvent}

procedure TCustomElXTree.SetHorzDivLinesColor(newValue: TColor);
begin
  if (FHorzDivLinesColor <> newValue) then
  begin
    IsUpdating := True;
    FHorzDivLinesColor := newValue;
    if FHorizontalLines then
    begin
      FView.FClearAll := True;
      FUpdated := True;
    end;
    IsUpdating := False;
  end; {if}
end; {SetLinesColor}

procedure TCustomElXTree.SetLinesColor(newValue: TColor);
begin
  if (FLinesColor <> newValue) then
  begin
    IsUpdating := True;
    FLinesColor := newValue;
    if FShowLines then
    begin
      FView.FClearAll := True;
      FUpdated := True;
    end;
    IsUpdating := False;
  end; {if}
end; {SetLinesColor}

procedure TCustomElXTree.SetLinesStyle(newValue: TPenStyle);
begin
  if (FLinesStyle <> newValue) then
  begin
    IsUpdating := True;
    FLinesStyle := newValue;
    if FShowLines then
    begin
      FView.FClearAll := True;
      FUpdated := True;
    end;
    IsUpdating := False;
  end; {if}
end; {SetLinesStyle}

procedure TCustomElXTree.SetImages2(newValue: TCustomImageList);
var
  i: Integer;
begin
  if FImages2 = newValue then
    Exit;
  IsUpdating := True;
  if FImages2 <> nil then
    begin
      if not (csDestroying in FImages2.ComponentState) then
        FImages2.RemoveFreeNotification(Self);
      FImages2.UnRegisterChanges(FImageChangeLink);
    end;
  FImages2 := newValue;
  if FImages2 <> nil then
  begin
    FImages2.RegisterChanges(FImageChangeLink);
    FImages2.FreeNotification(Self);
  end;
  if csDestroying in ComponentState then
    Exit;
  i := DefineLineHeight;
  if FAutoLineHeight and (i <> FLineHeight) then
  begin
    FLineHeight := i;
    with FView do
    begin
      FClearVis := True;
      FClearAll := True;
    end;
  end;
  if not ShowColumns then
  begin
    with FView do
    begin
      FHRange := -1;
      DefineHRange;
    end;
    if RightAlignedView then
    begin
      FRightAlignedView := False;
      RightAlignedView := True;
    end;
  end;
  FView.FRangeUpdate := True;
  FUpdated := True;
  IsUpdating := False;
end;

procedure TCustomElXTree.SetAlphaForImages2(newValue: TCustomImageList);
{var
  i: Integer;}
begin
  if FAlphaForImages2 = newValue then
    Exit;
  IsUpdating := True;
  if FAlphaForImages2 <> nil then
    begin
      if not (csDestroying in FAlphaForImages2.ComponentState) then
        FAlphaForImages2.RemoveFreeNotification(Self);
      FAlphaForImages2.UnRegisterChanges(FAImageChangeLink);
    end;
  FAlphaForImages2 := newValue;
  if FAlphaForImages2 <> nil then
  begin
    FAlphaForImages2.RegisterChanges(FAImageChangeLink);
    FAlphaForImages2.FreeNotification(Self);
  end;
  if csDestroying in ComponentState then
    Exit;
{
  i := DefineLineHeight;
  if FAutoLineHeight and (i <> FLineHeight) then
  begin
    FLineHeight := i;
    with FView do
    begin
      FClearVis := True;
      FClearAll := True;
    end;
  end;
  if not ShowColumns then
  begin
    with FView do
    begin
      FHRange := -1;
      DefineHRange;
    end;
    if RightAlignedView then
    begin
      FRightAlignedView := False;
      RightAlignedView := True;
    end;
  end;
}
  FView.FRangeUpdate := True;
  FUpdated := True;
  IsUpdating := False;
end;

procedure TCustomElXTree.SetRightAlignedView(newValue: Boolean);
begin
  if (FRightAlignedView <> newValue) then
  begin
    FRightAlignedView := newValue;
    if csLoading in ComponentState then Exit;
    FHeader.RightAlignedOrder := newValue;
    FView.Invalidate;//Repaint;
  end; {if}
end;

procedure TCustomElXTree.SetFlat(newValue: Boolean);
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    if Flat then
      Ctl3D := True;
    if HandleAllocated then
      RecreateWnd;
    //SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
    // UpdateFrame;
    end; { if }
end; { SetFlat }

procedure TCustomElXTree.DrawFlatBorder(HorzTracking, VertTracking: Boolean);
var
  DC: Windows.HDC;
  SavedDC: Windows.HDC;
  b: Boolean;
  BS: TElFlatBorderType;
  RW,
  RC: TRect;
  AColor: TColor;
  LUseThemeMode: TLMDThemeMode;
  LDetails: TThemedElementDetails;
  const ScrollBars: array [Boolean, Boolean] of TScrollStyle = ((ssNone, ssVertical), (ssHorizontal, ssBoth));

begin
  LUseThemeMode := UseThemeMode;
  {$IFDEF LMDCOMP10}
  //this line is to prevent AV when destroying ElXTree in Dexter - to check for 5.1
  if  csDestroying in ComponentState then
    exit;
  {$ENDIF}
  Windows.GetClientRect(Handle, RC);
  if not UseCustomScrollBars then
  begin
    if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0 then
      Inc(RC.Right, GetSystemMetrics(SM_CXVSCROLL));
    if GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0 then
      Inc(RC.Bottom, GetSystemMetrics(SM_CYHSCROLL));
  end;
  GetWindowRect(Handle, RW);
  MapWindowPoints(0, Handle, RW, 2);
  OffsetRect(RC, -RW.Left, -RW.Top);
  OffsetRect(RW, -RW.Left, -RW.Top);

  DC := GetWindowDC(Handle);
  try
    if (LUseThemeMode <> ttmNone) and (BorderStyle = bsSingle) then
    begin
      SavedDC := SaveDC(DC);
      ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
      LDetails.Element := teTreeview;
      LDetails.Part := 0;
      LDetails.State := 0;
      LMDThemeServices.DrawElement(LUseThemeMode, DC, LDetails, RW, nil);
      // DrawThemeBackground(Theme, DC, 0, 0, RW, nil);

      RestoreDC(DC, SavedDC);
    end;
    begin
      if (BorderStyle = bsSingle) and (LUseThemeMode = ttmNone) then
      begin
        b := FView.FHasFocus or FMouseOver;
        if b then
          BS := FActiveBorderType
        else
          BS := FInactiveBorderType;
        if ((not FFlat) and FUseCustomScrollBars) then
           BS := fbtSunken;
        if bs = fbtRaised then
          bs := fbtRaisedOuter;
        if Focused or FMouseOver then
          AColor := LineBorderActiveColor
        else
          AColor := LineBorderInactiveColor;

        DrawFlatFrameEx2(DC, RW, AColor, BackGroundColor, b, Enabled, BorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
      end;
      if (not FUseCustomScrollBars) and (LUseThemeMode = ttmNone) then
         DrawFlatScrollBars(Handle, DC, RW, (Focused or FMouseOver) and (not FlatFocusedScrollBars),
                            ScrollBars[FHorzScrollBarVisible, FVertScrollBarVisible], HorzTracking, VertTracking, False, GetWindowLong(Handle, GWL_STYLE), GetWindowLong(Handle, GWL_EXSTYLE));
      end;
    finally
      ReleaseDC(Handle, DC);
    end;
end;

procedure TCustomElXTree.DrawFlatBorderEx(DC: Windows.HDC; HorzTracking,
  VertTracking: Boolean);
var
  b: Boolean;
  BS: TElFlatBorderType;
  SavedDC: Windows.HDC;
  RW,
  RC: TRect;
  AColor: TColor;
  LUseThemeMode: TLMDThemeMode;
  LDetails: TThemedElementDetails;
const
  ScrollBars: array [Boolean, Boolean] of TScrollStyle = ((ssNone, ssVertical), (ssHorizontal, ssBoth));
begin
  LUseThemeMode := UseThemeMode;
  {$IFDEF LMDCOMP10}
  //this line is to prevent AV when destroying ElXTree in Dexter - to check for 5.1
  if  csDestroying in ComponentState then
    exit;
  {$ENDIF}
  Windows.GetClientRect(Handle, RC);
  if not UseCustomScrollBars then
  begin
    if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0 then
      Inc(RC.Right, GetSystemMetrics(SM_CXVSCROLL));
    if GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0 then
      Inc(RC.Bottom, GetSystemMetrics(SM_CYHSCROLL));
  end;
  GetWindowRect(Handle, RW);
  MapWindowPoints(0, Handle, RW, 2);
  OffsetRect(RC, -RW.Left, -RW.Top);
  OffsetRect(RW, -RW.Left, -RW.Top);

  if (LUseThemeMode <> ttmNone) and (BorderStyle = bsSingle) then
  begin
    SavedDC := SaveDC(DC);
    ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
    LDetails.Element := teTreeview;
    LDetails.Part := 0;
    LDetails.State := 0;
    LMDThemeServices.DrawElement(LUseThemeMode, DC, LDetails, RW, nil);
    // DrawThemeBackground(Theme, DC, 0, 0, RW, nil);

    RestoreDC(DC, SavedDC);
  end;

  begin
    if (BorderStyle = bsSingle) and (LUseThemeMode = ttmNone) then
    begin
      b := FView.FHasFocus or FMouseOver;
      if b then
        BS := FActiveBorderType
      else
        BS := FInactiveBorderType;
      if ((not FFlat) and FUseCustomScrollBars) then
         BS := fbtSunken;
      if bs = fbtRaised then
        bs := fbtRaisedOuter;
      if Focused or FMouseOver then
        AColor := LineBorderActiveColor
      else
        AColor := LineBorderInactiveColor;

      DrawFlatFrameEx2(DC, RW, AColor, BackGroundColor, b, Enabled, FBorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
    end;

    if (not FUseCustomScrollBars) and (LUseThemeMode = ttmNone) then
       DrawFlatScrollBars(Handle, DC, RW,
         (Focused or FMouseOver) and (not FlatFocusedScrollBars),
         ScrollBars[FHorzScrollBarVisible, FVertScrollBarVisible],
         HorzTracking, VertTracking, False, GetWindowLong(Handle, GWL_STYLE),
         GetWindowLong(Handle, GWL_EXSTYLE));
  end;
end;

procedure TCustomElXTree.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
   if BorderStyle = bsSingle then
   begin
      inc(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smYEdge[Ctl3D]));
      inc(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smXEdge[Ctl3D]));
      dec(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smYEdge[Ctl3D]));
      dec(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smXEdge[Ctl3D]));
      if Message.CalcSize_Params.rgrc[0].Right < Message.CalcSize_Params.rgrc[0].Left then
        Message.CalcSize_Params.rgrc[0].Right := Message.CalcSize_Params.rgrc[0].Left;
      if Message.CalcSize_Params.rgrc[0].Bottom < Message.CalcSize_Params.rgrc[0].Top then
        Message.CalcSize_Params.rgrc[0].Bottom := Message.CalcSize_Params.rgrc[0].Top;

      if not (ebsLeft in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smYEdge[Ctl3D]));
      if not (ebsTop in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smXEdge[Ctl3D]));
      if not (ebsRight in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smYEdge[Ctl3D]));
      if not (ebsBottom in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smXEdge[Ctl3D]));

      if Message.CalcSize_Params.rgrc[0].Right < Message.CalcSize_Params.rgrc[0].Left then
        Message.CalcSize_Params.rgrc[0].Right := Message.CalcSize_Params.rgrc[0].Left;
      if Message.CalcSize_Params.rgrc[0].Bottom < Message.CalcSize_Params.rgrc[0].Top then
        Message.CalcSize_Params.rgrc[0].Bottom := Message.CalcSize_Params.rgrc[0].Top;
  end;
  Message.Result := 0;
end;

procedure TCustomElXTree.CMEnabledChanged(var Message: TMessage);

begin
  inherited;
  FVScrollBar.Enabled := Enabled;
  FHScrollBar.Enabled := Enabled;
end;

procedure TCustomElXTree.WMNCHITTEST(var Msg: TWMNCHitTest);  { private }
begin
  inherited;
  if FUseCustomScrollBars then
  begin
    if (Msg.Result = HTHSCROLL) or (Msg.Result = HTVSCROLL) then
        Msg.Result := HTBORDER;
  end;
end;  { WMNCHITTEST }

procedure TCustomElXTree.WMNCPaint(var Msg: TWMNCPaint); { private }
var
  DC: HDC;
  // RW, RC: TRect;
begin
  if FHook <> nil then
  begin
    if FHook.Control = nil then
    begin
      FHook.Control := GetParentForm(Self);
      FHook.Active := DoubleBuffered and (not (csDesigning in componentState));
    end;
  end;

  if not FUseCustomScrollBars then
    inherited;
  if (Flat or FUseCustomScrollBars or IsThemed or
      (not FUseCustomScrollBars and not IsThemed)) and (BorderStyle = bsSingle) then
  begin
    DC := GetWindowDC(Handle);
    DrawFlatBorderEx(DC, False, False);

    ReleaseDC(Handle, DC);
    Msg.Result := 0;
  end;
end; { WMNCPaint }

procedure TCustomElXTree.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
  FView.MouseMove(KeysToShiftState(Message.Keys),Message.XPos - FView.Left, Message.YPos - FView.Top);
end;

procedure TCustomElXTree.SetRightAlignedText(newValue: Boolean);
begin
  if (FRightAlignedText <> newValue) then
  begin
    FRightAlignedText := newValue;
    FHeader.RightAlignedText := newValue;
    RecreateWnd;
  end; {if}
end;

procedure TCustomElXTree.SetForcedScrollBars(newValue: TScrollStyle);
begin
  if (FForcedScrollBars <> newValue) then
  begin
    FForcedScrollBars := newValue;
    if HandleAllocated then
    begin
      if (not FUseCustomScrollBars) then
         RecreateWnd;
      IsUpdating := True;
      UpdateScrollBars;

      FUpdated := True;
      IsUpdating := False;
    end;
  end;  { if }
end;  procedure TCustomElXTree.SetForeceAlign(const Value: boolean);
begin
  if FForceAlign <> Value then
  begin
    FForceAlign := Value;
    Repaint;
  end;
end;

{ SetForcedScrollBars }

procedure TCustomElXTree.SetFilteredVisibility(newValue: Boolean);
begin
  if (FFilteredVisibility <> newValue) then
  begin
    IsUpdating := True;
    FFilteredVisibility := newValue;
    if newValue then
    begin
      UpdateDiffItems;
      UpdateAllItems;
    end;
    with FView do
    begin
      FVisUpdated := True;
      FClearVis := True;
      FClearAll := True;
      if not ShowColumns then
        FHRange := -1;
      FRangeUpdate := True;
    end;
    FUpdated := True;
    IsUpdating := False;
  end; {if}
end;

procedure TCustomElXTree.TriggerApplyVisFilterEvent(Item: TElXTreeItem; var
  Hidden: Boolean);
begin
  if (assigned(FOnApplyVisFilter)) then
    FOnApplyVisFilter(Self, Item, Hidden);
  if Item.IsHTML then
    Item.ReRenderAllTexts;
end;

procedure TCustomElXTree.SetLeftPosition(value: Integer);
begin
  FView.SetLeftPosition(value);
end;

procedure TCustomElXTree.SetTopIndex(value: Integer);
begin
  FView.SetTopIndex(value);
end;

procedure TCustomElXTree.ClickTransfer(Sender: TObject);
{ Transfers FView OnClick event to the outside world. }
begin
  if (assigned(FOnClick)) then
    FOnClick(Self);  { Substitute Self for subcomponent's Sender. }
end;  { ClickTransfer }

procedure TCustomElXTree.DblClickTransfer(Sender: TObject);
{ Transfers FView OnDblClick event to the outside world. }
begin
  if (assigned(FOnDblClick)) then
    FOnDblClick(Self);
end;  { DblClickTransfer }
{
procedure TCustomElXTree.EndDragTransfer(Sender: TObject; Source: TObject; X: Integer; Y: Integer);
begin
  y := Y + FView.Top;
  X := X + FView.Left;
  if Source = FView then Source := Self
  else
  if Source is TElXTreeDragObject then Source := TElXTreeDragObject(Source).Control;
  if (assigned(FOnDrop)) then
    FOnDrop(Self, Source , X , Y );  // Substitute Self for subcomponent's Sender.
end;
}
procedure TCustomElXTree.DropTransfer(Sender: TObject; Source: TObject; X: Integer; Y: Integer);
{ Transfers FView OnDragDrop event to the outside world. }
begin
  y := Y + FView.Top;
  X := X + FView.Left;
  {if Source is TElXTreeDragObject then
     Sender := Source
  else
     }Sender := Self;
  if Source = FView then
     Source := Self
  else
  if Source is TElXTreeDragObject then
     Source := TElXTreeDragObject(Source).Control;
  if (assigned(FOnDrop)) then
     FOnDrop(Sender, Source , X , Y );  { Substitute Self for subcomponent's Sender. }
end;  { DropTransfer }

procedure TCustomElXTree.OverTransfer(Sender: TObject; Source: TObject; X: Integer; Y: Integer; State: TDragState; var Accept: Boolean);
{ Transfers FView OnDragOver event to the outside world. }
begin
  Accept := False;
  y := Y + FView.Top;
  X := X + FView.Left;
  {if Source is TElXTreeDragObject then
     Sender := Source
  else}
     Sender := Self;
  if Source = FView then
     Source := Self
  else
  if Source is TElXTreeDragObject then
     Source := TElXTreeDragObject(Source).Control;
  if (assigned(FOnOver)) then
     FOnOver(Sender, Source , X , Y , State , Accept );  { Substitute Self for subcomponent's Sender. }
end;  { OverTransfer }

procedure TCustomElXTree.DragTransfer(Sender: TObject; Target: TObject; X: Integer; Y: Integer);
{ Transfers FView OnEndDrag event to the outside world. }
begin
  y := Y + FView.Top;
  X := X + FView.Left;
  {if Target is TElXTreeDragObject then
     Sender := Target
  else
     }Sender := Self;
  if Target = FView then
    Target := Self;
  if (assigned(FOnDrag)) then
    FOnDrag(Sender, Target , X , Y );  { Substitute Self for subcomponent's Sender. }
end;  { DragTransfer }

procedure TCustomElXTree.EnterTransfer(Sender: TObject);
{ Transfers FView OnEnter event to the outside world. }
begin
  if (assigned(FOnEnter)) then
    FOnEnter(Self);  { Substitute Self for subcomponent's Sender. }
end;  { EnterTransfer }

procedure TCustomElXTree.ExitTransfer(Sender: TObject);
{ Transfers FView OnExit event to the outside world. }
begin
  if (assigned(FOnExit)) then
    FOnExit(Self);  { Substitute Self for subcomponent's Sender. }
end;  { ExitTransfer }

procedure TCustomElXTree.KeyDownTransfer(Sender: TObject; var Key: Word; Shift: TShiftState);
{ Transfers FView OnKeyDown event to the outside world. }
begin
  if (assigned(FOnKeyDown)) then
    FOnKeyDown(Self, Key , Shift );  { Substitute Self for subcomponent's Sender. }
end;  { KeyDownTransfer }

procedure TCustomElXTree.KeyPressTransfer(Sender: TObject; var Key: Char);
{ Transfers FView OnKeyPress event to the outside world. }
begin
  if (assigned(FOnKeyPress)) then
    FOnKeyPress(Self, Key );  { Substitute Self for subcomponent's Sender. }
end;  { KeyPressTransfer }

procedure TCustomElXTree.KeyUpTransfer(Sender: TObject; var Key: Word; Shift: TShiftState);
{ Transfers FView OnKeyUp event to the outside world. }
begin
  if (assigned(FOnKeyUp)) then
    FOnKeyUp(Self, Key , Shift );  { Substitute Self for subcomponent's Sender. }
end;  { KeyUpTransfer }

procedure TCustomElXTree.MouseDownTransfer(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);
{ Transfers FView OnMouseDown event to the outside world. }
begin
  y := Y + FView.Top;
  X := X + FView.Left;
  if (assigned(FOnMouseDown)) then
    FOnMouseDown(Self, Button , Shift , X , Y );  { Substitute Self for subcomponent's Sender. }
end;  { MouseDownTransfer }

procedure TCustomElXTree.MouseMoveTransfer(Sender: TObject; Shift: TShiftState; X: Integer; Y: Integer);
{ Transfers FView OnMouseMove event to the outside world. }
begin
  Y := Y + FView.Top;
  X := X + FView.Left;
  if (assigned(FOnMouseMove)) then
    FOnMouseMove(Self, Shift , X , Y );  { Substitute Self for subcomponent's Sender. }
end;  { MouseMoveTransfer }

procedure TCustomElXTree.MouseUpTransfer(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);
{ Transfers FView OnMouseUp event to the outside world. }
begin
  Y := Y + FView.Top;
  X := X + FView.Left;
  if (assigned(FOnMouseUp)) then
    FOnMouseUp(Self, Button , Shift , X , Y );  { Substitute Self for subcomponent's Sender. }
end;  { MouseUpTransfer }

procedure TCustomElXTree.StartDragTransfer(Sender: TObject; var DragObject: TDragObject);
{ Transfers FView OnStartDrag event to the outside world. }
begin
  if DragObject <> nil then
  begin
    with DragObject.DragPos do
      DragObject.DragPos := Point(X + FView.Left, Y + FView.Top);
  end;

  if (assigned(FOnStartDrag)) then
    FOnStartDrag(Self, DragObject);  { Substitute Self for subcomponent's Sender. }

  if DragObject <> nil then
  begin
    with DragObject.DragPos do
      DragObject.DragPos := Point(X - FView.Left, Y - FView.Top);
  end;

  if DragObject = nil then
  begin
    DragObject := TElXTreeDragObject.Create(Self);
  end;
end;  { StartDragTransfer }

procedure TCustomElXTree.MeasureSectionTransfer(Sender: TObject; Section: TElHeaderSection; var Size: TPoint);
begin
  if Assigned(FOnHeaderSectionMeasure) then
    FOnHeaderSectionMeasure(Self, Section, Size);
end;

function TCustomElXTree.CreateView: TElXTreeView;  { protected }
begin
  Result := TElXTreeView.Create(Self);
end;  { CreateView }

function TCustomElXTree.CreateInplaceManager: TElTreeInplaceManager;
begin
  Result := TElTreeInplaceManager.Create(Self);
end;

{ Exposed properties' Read/Write methods: }
procedure TCustomElXTree.SetCursor(newValue: TCursor);
begin
  FView.Cursor := newValue;
  if newValue <> FCursor then
    FCursor := newValue;
end;  { SetCursor }

function TCustomElXTree.GetCursor: TCursor;
{ Returns the Cursor property from the FView subcomponent. }
begin
  GetCursor := FView.Cursor;
end;  { GetCursor }

function TCustomElXTree.SetScrollInfo(hWnd: HWND; BarFlag: Integer; const ScrollInfo: TScrollInfo; Redraw: BOOL): Integer;

begin
  if (hWnd = FHScrollBar.Handle) or (hWnd = FVScrollBar.Handle) then
  begin
    Result := SendMessage(hWnd, SBM_SetScrollInfo, Integer(Redraw), TLMDPtrInt(@ScrollInfo));
    end
  else
    Result := -1;
end;

function TCustomElXTree.GetScrollInfo(hWnd: HWND; BarFlag: Integer; var ScrollInfo: TScrollInfo): BOOL;
begin
  if (hWnd = FHScrollBar.Handle) or (hWnd = FVScrollBar.Handle) then
  begin
    SendMessage(hWnd, SBM_GetScrollInfo, 0, TLMDPtrInt(@ScrollInfo));
    Result := BOOL(True);
  end
  else
    Result := BOOL(False);
end;

procedure TCustomElXTree.HorzScrollDrawPartTransfer(Sender: TObject;
                                                   Canvas: TCanvas;
                                                   R: TRect;
                                                   Part: TElScrollBarPart;
                                                   Enabled: Boolean;
                                                   Focused: Boolean;
                                                   Pressed: Boolean;
                                                   var DefaultDraw: Boolean);
{ Transfers FHScrollBar OnDrawPart event to the outside world. }
begin
  if (assigned(FOnHorzScrollDrawPart)) then
    FOnHorzScrollDrawPart(Self, Canvas , R , Part , Enabled , Focused , Pressed , DefaultDraw );  { Substitute Self for subcomponent's Sender. }
end;  { HorzScrollDrawPartTransfer }

procedure TCustomElXTree.HorzScrollHintNeededTransfer(Sender: TObject; TrackPosition: Integer; var Hint: TLMDString);
{ Transfers FHScrollBar OnScrollHintNeeded event to the outside world. }
begin
  if (assigned(FOnHorzScrollHintNeeded)) then
    FOnHorzScrollHintNeeded(Self, TrackPosition , Hint );  { Substitute Self for subcomponent's Sender. }
end;  { HorzScrollHintNeededTransfer }

procedure TCustomElXTree.VertScrollDrawPartTransfer(Sender: TObject; Canvas: TCanvas;
                                                   R: TRect;
                                                   Part: TElScrollBarPart;
                                                   Enabled: Boolean;
                                                   Focused: Boolean;
                                                   Pressed: Boolean;
                                                   var DefaultDraw: Boolean);
{ Transfers FVScrollBar OnDrawPart event to the outside world. }
begin
  if (assigned(FOnVertScrollDrawPart)) then
    FOnVertScrollDrawPart(Self, Canvas , R , Part , Enabled , Focused , Pressed , DefaultDraw );  { Substitute Self for subcomponent's Sender. }
end;  { VertScrollDrawPartTransfer }

procedure TCustomElXTree.VertScrollHintNeededHandler(Sender: TObject; TrackPosition: Integer; var Hint: TLMDString);
var Item: TElXTreeItem;
    FCol: Integer;
begin
  VertScrollHintNeededTransfer(Self, TrackPosition, Hint);
  if Hint = '' then
  begin
    Item := Items.ItemAsVis[TrackPosition];
    if Item = nil then
      Exit;

    if FSortSection = -1 then
    begin
//      if Item.FStaticData <> nil then
      if VirtualityLevel = vlNone then
        Hint := Item.Text
      else
      begin
        if FSortSection > -1 then
          TriggerVirtualTextNeeded(Item, FSortSection, Hint)
        else
          TriggerVirtualTextNeeded(Item, FMainTreeColumn, Hint);
      end;
    end
    else
    begin
      if VirtualityLevel = vlNone then
      begin
        if FSortSection = FMainTreeColumn then
          Hint := Item.Text
        else
        begin
          FCol := FSortSection;
          try
            if FCol < Item.Cells.Count then
              Hint := Item.Cells[FCol].Text;
          except
          end;
        end;
      end
      else
        TriggerVirtualTextNeeded(Item, FSortSection, Hint);
    end;
  end;
end;  { VertScrollHintNeededHandler }

procedure TCustomElXTree.VertScrollHintNeededTransfer(Sender: TObject; TrackPosition: Integer; var Hint: TLMDString);
{ Transfers FHScrollBar OnScrollHintNeeded event to the outside world. }
begin
  if (assigned(FOnVertScrollHintNeeded)) then
    FOnVertScrollHintNeeded(Self, TrackPosition , Hint );  { Substitute Self for subcomponent's Sender. }
end;  { HorzScrollHintNeededTransfer }

procedure TCustomElXTree.CreateWnd;  { protected }
var
  SaveDragType: TElDragType;
begin
  FScrollbarsInitialized := False;
  inherited;
  TElScrollBarHack(FHScrollBar).SetDesigning(False);
  TElScrollBarHack(FVScrollBar).SetDesigning(False);
  TElHeaderHack(FHeader).IsDesigning := False;
  FView.SetDesigning(csDesigning in ComponentState);
  AlignPieces;

  if ((ComponentState * [csLoading, csReading]) = []) and (FDragType <> dtDelphi) then
  begin
    SaveDragType := FDragType;
    DragType := dtDelphi;
    DragType := SaveDragType;
  end;

end;  { CreateWnd }

procedure TCustomElXTree.AlignControls(AControl: TControl; var Rect: TRect);
begin
  if not (csDesigning in ComponentState) then
     inherited;
end;

function TCustomElXTree.GetHeaderInvertSortArrows: Boolean;
{ Returns the value of data member FHeaderInvertSortArrows. }
begin
  Result := FHeader.InvertSortArrows;
end;  { GetHeaderInvertSortArrows }

procedure TCustomElXTree.SetHeaderInvertSortArrows(newValue: Boolean);
{ Sets data member FHeaderInvertSortArrows to newValue. }
begin
  FHeader.InvertSortArrows := newValue;
end;  { SetHeaderInvertSortArrows }

function TCustomElXTree.GetDragImages: TDragImageList;

begin
  Result := FView.GetDragImages;
end;

procedure TCustomElXTree.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited;
end;

procedure TCustomElXTree.SetAutoExpand(value: Boolean);
begin
  if AutoExpand <> value then
  begin
    FAutoExpand := value;
    //if value then FMoveFocusOnCollapse := False;
  end;
end;

procedure TCustomElXTree.SetMoveFocusOnCollapse(value: Boolean);
begin
  if FMoveFocusOnCollapse <> value then
  begin
    FMoveFocusOnCollapse := value;
    //if value then AutoExpand := False;
  end;
end;

function TCustomElXTree.GetDragCursor: TCursor;
begin
  Result := FView.DragCursor;
end;

procedure TCustomElXTree.SetDragCursor(Value: TCursor);
begin
  FView.DragCursor := Value;
end;

procedure TCustomElXTree.SetTrackColor(value: TColor);
begin
  if FTrackColor <> Value then
  begin
    FTrackColor := Value;
    if Assigned(FView.FTrackItem) then
       FView.FTrackItem.RedrawItem(True);
  end;
end;

procedure TCustomElXTree.SetPlusMinusTransparent(newValue: Boolean);
begin
  if newValue <> FPlusMinusTransparent then
  begin
    FPlusMinusTransparent := newValue;
    if FShowButtons then
    begin
      IsUpdating := True;
      FUpdated := True;
      FView.FRangeUpdate := True;
      IsUpdating := False;
    end;
  end;
end;

procedure TCustomElXTree.SetHeaderColor(newValue: TColor);
{ Sets the FHeader subcomponent's Color property to newValue. }
begin
  FHeader.Color := newValue;
end;  { SetColor }

function TCustomElXTree.GetHeaderColor: TColor;
{ Returns the Color property from the FHeader subcomponent. }
begin
  Result := FHeader.Color;
end;  { GetColor }

procedure TCustomElXTree.SetAdjustMultilineHeight(newValue: Boolean);
var i, j: Integer;
begin
  if (FAdjustMultilineHeight <> newValue) then
  begin
    FAdjustMultilineHeight := newValue;
    j := FAllList.Count - 1;
    for i := 0 to j do
    begin
      if TElXTreeItem(FAllList[i]).Multiline then
      begin
        if newValue then
           Inc(TotalVarHeightCount)
        else
           Dec(TotalVarHeightCount);
      end;
    end;
    IsUpdating := True;
    with FView do
    begin
      FVisUpdated := True;
      FClearVis := True;
      FClearAll := True;
      FRangeUpdate := True;
    end;
    FUpdated := True;
    IsUpdating := False;
  end;  { if }
end;  { SetAdjustMultilineHeight }

procedure TCustomElXTree.TriggerImageNeededEvent(Sender: TObject; Src: TLMDString; var Image: TBitmap);
begin
  if (assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src, Image );
end;

procedure TCustomElXTree.TriggerImageNeededExEvent(Sender: TObject;
  Src: TLMDString; Image: TPicture);
begin
  if (Assigned(FOnImageNeededEx)) then
    FOnImageNeededEx(Self, Src, Image);
end;

procedure TCustomElXTree.TriggerAdjustControlPositionEvent(Sender: TObject; aControl: TControl; aData: Pointer; var X: integer; var Y: integer);
begin
  if Assigned(FOnAdjustControlPosition) then
    FOnAdjustControlPosition(Self, aControl, aData, X, Y);
end;

procedure TCustomElXTree.TriggerControlCreatedEvent(Sender : TObject; aControl: TControl);
begin
  if Assigned(FOnControlCreated) then
    FOnControlCreated(Self, aControl);
end;

procedure TCustomElXTree.TriggerTagFoundEvent(Sender : TObject; var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing:boolean; aSupported: boolean);
begin
  if Assigned(FOnTagFound) then
    FOnTagFound(Self, Tag, Item, Params, aClosing, aSupported);
end;

procedure TCustomElXTree.UpdateHTMLControlsVisibility(Sender : TObject; aControl: TControl; aData:Pointer; var aVisible: boolean);
var
  lItem: TElXTreeItem;
begin
  if aData <> nil then
  begin
    lItem := TElXTreeCell(aData).Owner;
    if lItem <> nil then
      aVisible := (lItem.Owner.FilteredVisibility and lItem.FullyVisible or not lItem.Owner.FilteredVisibility) and IsInView(lItem) and TElXTreeCell(aData).HTMLControlsVisible;
  end;
end;

procedure TCustomElXTree.WMVScroll(var Msg: TWMVScroll);  { private }
var b: Boolean;
    sc: TElscrollCode;
    sp: Integer;
    ScrollInfo: TScrollInfo;
begin
  sc := escTop;
  b := False;
  case Msg.ScrollCode of
    SB_TOP:       sc := escTop;
    SB_BOTTOM:    sc := escBottom;
    SB_ENDSCROLL: sc := escEndScroll;
    SB_LINEDOWN:  sc := escLineDown;
    SB_LINEUP:    sc := escLineUp;
    SB_PAGEDOWN:  sc := escPageDown;
    SB_PAGEUP:    sc := escPageUp;
    SB_THUMBPOSITION: sc := escPosition;
    SB_THUMBTRACK: sc := escTrack;
  end;
  ScrollInfo.cbSize := Sizeof(ScrollInfo);
  ScrollInfo.fMask := SIF_POS or SIF_TRACKPOS or SIF_RANGE;
  if FUseCustomScrollBars then
    GetScrollInfo(FVScrollBar.Handle, SB_CTL, ScrollInfo)
  else
    Windows.GetScrollInfo(Handle, SB_VERT, ScrollInfo);
  if (Msg.ScrollCode <> SB_THUMBTRACK) and (Msg.ScrollCode <> SB_THUMBPOSITION) then
    sp := ScrollInfo.nPos
  else
    sp := ScrollInfo.nTrackPos;
  FView.OnVScroll(FVScrollBar, SC, sp, b);
end;  { WMVScroll }

procedure TCustomElXTree.WMHScroll(var Msg: TWMHScroll);  { private }
var b: Boolean;
    sc: TElscrollCode;
    sp: Integer;
begin
  sc := escTop;
  b := False;
  case Msg.ScrollCode of
    SB_TOP:       sc := escTop;
    SB_BOTTOM:    sc := escBottom;
    SB_ENDSCROLL: sc := escEndScroll;
    SB_LINEDOWN:  sc := escLineDown;
    SB_LINEUP:    sc := escLineUp;
    SB_PAGEDOWN:  sc := escPageDown;
    SB_PAGEUP:    sc := escPageUp;
    SB_THUMBPOSITION: sc := escPosition;
    SB_THUMBTRACK: sc := escTrack;
  end;
  sp := Msg.Pos;
  FView.OnHScroll(FHScrollBar, SC, sp, b);
end;  { WMHScroll }

procedure TCustomElXTree.TriggerSortBegin;
begin
  if Assigned(FOnSortBegin) then
    FOnSortBegin(Self);
end;

procedure TCustomElXTree.TriggerSortEnd;
begin
  if Assigned(FOnSortEnd) then
    FOnSortEnd(Self);
end;

procedure TCustomElXTree.TriggerItemPreDrawEvent(Item: TElXTreeItem);
begin
  if assigned(FOnItemPredraw) then
    FOnItemPredraw(Self, Item);
end;

procedure TCustomElXTree.TriggerItemPostDrawEvent(Canvas: TCanvas; Item: TElXTreeItem; ItemRect: TRect; var DrawFocusRect: Boolean);
begin
  if (assigned(FOnItemPostDraw)) then
    FOnItemPostDraw(Self, Canvas , Item, ItemRect , DrawFocusRect );
end;  { TriggerItemPostDrawEvent }

procedure TCustomElXTree.SetHeaderImageForm(newValue: TElImageForm);
begin
  FHeader.ImageForm := newValue;
end;  { SetImageForm }

function TCustomElXTree.GetHeaderImageForm: TElImageForm;
begin
  Result := FHeader.ImageForm;
end;  { GetImageForm }

function TCustomElXTree.GetHint: TLMDString;
begin
  Result := FHint;
end;

procedure TCustomElXTree.SetHint(newValue: TLMDString);
begin
  FHint := newValue;
  FRealHint := newValue;
end;

procedure TCustomElXTree.StartDelayedFocus(FocusItemToReport: TElXTreeItem);
begin
  FDelayTimer.Enabled := False;
  FDelayedItem := FocusItemToReport;
  FDelayTimer.Interval := FChangeDelay;
  FDelayTimer.Enabled := True;
end;

procedure TCustomElXTree.StopDelayedFocus;
begin
  FDelayTimer.Enabled := False;
  FDelayedItem := nil;
end;

procedure TCustomElXTree.OnDelayTimer(Sender: TObject);
begin
  FDelayTimer.Enabled := False;
  if FDelayedItem = FView.FFocused then
    DoItemFocused;
end;

procedure TCustomElXTree.DoAfterSelectionChange;
begin
  if Assigned(FOnAfterSelectionChange) then
    FOnAfterSelectionChange(Self);
end;

procedure TCustomElXTree.SetDragRectAcceptColor(const Value: TColor);
begin
  if FDragRectAcceptColor <> Value then
  begin
    FDragRectAcceptColor := Value;
    if (FDragTrgDrawMode in [ColorFrame, ColorRect, dtdUpColorLine, dtdDownColorLine]) and (FView.FDropTrg <> nil) then
    begin
      if FDragObject <> nil then
        FDragObject.HideDragImage;
      FView.FDropTrg.RedrawItem(False);
      Invalidate; //Update;
      if FDragObject <> nil then
        FDragObject.ShowDragImage;
    end;
  end;
end;

procedure TCustomElXTree.SetDragRectDenyColor(Value: TColor);
begin
  if FDragRectDenyColor <> Value then
  begin
    FDragRectDenyColor := Value;
    if (FDragTrgDrawMode in [ColorFrame, ColorRect, dtdUpColorLine, dtdDownColorLine]) and (FView.FDropTrg <> nil) then
    begin
      if FDragObject <> nil then
        FDragObject.HideDragImage;
      FView.FDropTrg.RedrawItem(False);
      Invalidate; //Update;
      if FDragObject <> nil then
        FDragObject.ShowDragImage;
    end;
  end;
end;

procedure TCustomElXTree.SetDragTrgDrawMode(Value: TDragTargetDraw);
begin
  if FDragTrgDrawMode <> Value then
  begin
    DoSetDragTrgDrawMode(Value, True);
  end;
end;

function TCustomElXTree.GetVisibleRowCount: Integer;
begin
  Result := FView.GetVisCount2;
end;

function TCustomElXTree.IndexInView(Item: TElXTreeItem): Integer;
begin
  Result := FView.ColorHelper.Visible.IndexOf(Item);
end;

function TCustomElXTree.GetCanDrag: TElXCanDragEvent;
begin
  Result := FView.FOnCanDrag;
end;

procedure TCustomElXTree.SetCanDrag(const Value: TElXCanDragEvent);
begin
  FView.FOnCanDrag := Value;
end;

function TCustomElXTree.GetDropTarget: TElXTreeItem;
begin
  Result := FView.FDropTrg;
end;

procedure TCustomElXTree.DoSetDragTrgDrawMode(Value: TDragTargetDraw; RedrawItem
: Boolean);
begin
  if FDragTrgDrawMode <> Value then
  begin
    FDragTrgDrawMode := Value;
    if (FView.FDropTrg <> nil) and (RedrawItem) then
    begin
      if FDragObject <> nil then
        FDragObject.HideDragImage;
      FView.FDropTrg.RedrawItem(False);
      Invalidate; //Update;
      if FDragObject <> nil then
        FDragObject.ShowDragImage;
    end;
  end;
end;

procedure TCustomElXTree.AllSelectedEx(SelectedItems: TLMDObjectList; Order: Boolean);
var i: Integer;
    Item: TElXTreeItem;
begin
  if FSelectedList = nil then
    Exit;

  if not Order then
  begin
    SelectedItems.Assign(FSelectedList);
  end
  else
  begin
    SelectedItems.Capacity := FSelectedList.Capacity;
    for i := 0 to FAllList.Count - 1 do
    begin
      Item := TElXTreeItem(FAllList.FastGet(i));
      if Item.Selected then
        SelectedItems.Add(Item);
    end;
  end;
end;

function TCustomElXTree.GetFireFocusEvents: Boolean;
begin
  Result := (FFireFocusEvents = 0) and not (csDestroying in ComponentState);
end;

procedure TCustomElXTree.SetFireFocusEvents(Value: Boolean);
begin
  if Value then
    Dec(FFireFocusEvents)
  else
    Inc(FFireFocusEvents);
end;

procedure TCustomElXTree.SetScrollbarOpposite(Value: Boolean);
begin
  if FScrollbarOpposite <> Value then
  begin
    FScrollbarOpposite := Value;
    if FUseCustomScrollBars then
    AlignPieces;
  end;
end;

procedure TCustomElXTree.SetLineHintTimeout(Value: Integer);
begin
  if FLineHintTimeout <> Value then
  begin
    FLineHintTimeout := Value;
  end;
end;

procedure TCustomElXTree.SetVerticalLinesLong(Value: Boolean);
begin
  if FVerticalLinesLong <> Value then
  begin
    FVerticalLinesLong := Value;
    if FVerticalLines then
      Invalidate;
  end;
end;

procedure TCustomElXTree.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited;
  FView.DoEndDrag(Target, X, Y);
end;

function TCustomElXTree.GetDefaultSectionWidth: Integer;
begin
  Result := FHeader.DefaultWidth;
end;

procedure TCustomElXTree.SetDefaultSectionWidth(Value: Integer);
begin
  FHeader.DefaultWidth := Value;
end;

procedure IntCheckHidden(Item: TElXTreeItem; Index: Integer; var ContinueIterate: Boolean;
                            IterateData: TLMDDataTag; Tree: TCustomElXTree);
begin
  Item.CheckHidden;
end;

procedure TCustomElXTree.UpdateAllItems;
begin
  Items.Iterate(False, True, IntCheckHidden, nil);
end;

procedure TCustomElXTree.UpdateDiffItems;
var AnItem: TElXTreeItem;
    i, j: Integer;
begin
  if (FView.FTrackItem <> nil) then
  begin
    FView.FTrackItem.CheckHidden;
    if FView.FTrackItem.Hidden then
      FView.FTrackItem := nil;
  end;
  if (FView.FDropTrg <> nil) then
  begin
    FView.FDropTrg.CheckHidden;
    if FView.FDropTrg.Hidden then
      FView.FDropTrg := nil;
  end;
  while True do
  begin
    AnItem := FView.FSelected;
    if (AnItem <> nil) then
    begin
      AnItem.CheckHidden;
      if AnItem.Hidden then
      begin
        if AnItem.FParent = FItems.FRoot then
        begin
          i := AnItem.AbsoluteIndex;
          // j := i;
          while (AnItem <> nil) and AnItem.Hidden do
          begin
            if i >= 0 then  // RAH changed from i > 0
              AnItem := Items[i]
            else
              AnItem := nil;
            Dec(i);
          end;
          if AnItem <> nil then
          begin
            SetSelected(AnItem);
            break;
          end
          else
          begin
            AnItem := FView.FSelected;  // RAH need to restore AnItem
            i := AnItem.AbsoluteIndex; // RAH should be the same as j
            while (AnItem <> nil) and AnItem.Hidden do
            begin
              if i < Integer(Items.Count) then // RAH make sure we stay in bounds
                AnItem := Items[i]
              else
                AnItem := nil;
              Inc(i);  // RAH work forward
            end;
            if AnItem <> nil then
               SetSelected(AnItem);
            break;
         end;
       end
       else
         if (AnItem <> nil) and (AnItem.FParent <> FItems.FRoot) then
            SetSelected(AnItem.FParent);
       if AnItem <> nil then
         AnItem.Selected := False;
      end
      else
        Break;
    end
    else
      break;
  end;

  // Move focus, if needed
  while True do
  begin
    AnItem := FView.FFocused;
    if (AnItem <> nil) then
    begin
      AnItem.CheckHidden;
      if AnItem.Hidden then
      begin
        if AnItem.FParent = FItems.FRoot then
        begin
          i := AnItem.AbsoluteIndex;
          j := i;
          while (AnItem <> nil) and AnItem.Hidden do
          begin
            if i > 0 then
              AnItem := Items[i]
            else
              AnItem := nil;
            Dec(i);
          end;
          if AnItem = nil then
          begin
            i := j;
            while (AnItem <> nil) and AnItem.Hidden do
            begin
              if i > 0 then
                AnItem := Items[i]
              else
                AnItem := nil;
              Dec(i);
            end;
          end;
          DoSetFocused(AnItem, True);
          break;
        end
        else
          if (AnItem <> nil) and (AnItem.FParent <> FItems.FRoot) then
            DoSetFocused(AnItem.FParent, True);
      end
      else
        Break;
    end
    else
      break;
  end;
end;

procedure TCustomElXTree.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
    end;
end;

procedure TCustomElXTree.ClearSortList(ReSort: Boolean);
begin
  if FSortSections <> nil then
  begin
    FSortSections.Clear;
    if Resort then
    begin
      if FUpdateCount > 0 then
        FSortRequired := True
      else
        Sort(True);
    end;
  end;
end;

procedure TCustomElXTree.AddSortSection(Index: Integer; ReSort: Boolean);
var AHeaderSection: TElHeaderSection;
begin
  if FSortSections = nil then
    FSortSections := TLMDObjectList.Create;
  if FHeader.Sections.Count > Index then
  begin
    AHeaderSection := FHeader.Sections[Index];
    FSortSections.Remove(AHeaderSection);
    FSortSections.Add(AHeaderSection);
    if Resort then
    begin
      if FUpdateCount > 0 then
        FSortRequired := True
      else
        Sort(True);
    end;
  end;
end;

procedure TCustomElXTree.RemoveSortSection(Index: Integer; ReSort: Boolean);
var i: Integer;
begin
  if FSortSections <> nil then
  begin
    if FHeader.Sections.Count > Index then
    begin
      i := FSortSections.IndexOf(FHeader.Sections[Index]);
      if i >= 0 then
      begin
        FSortSections.Delete(i);
        if Resort then
        begin
          if FUpdateCount > 0 then
            FSortRequired := True
          else
            Sort(True);
        end;
      end;
    end;
  end;
end;

procedure TCustomElXTree.TriggerVirtualTextNeeded(Item: TElXTreeItem;
    SectionIndex: Integer; var Text: TLMDString);
begin
  Text := '';
  if Assigned(FOnVirtualTextNeeded) then
    OnVirtualTextNeeded(Self, Item, SectionIndex, Text);
end;

procedure TCustomElXTree.TriggerUserCellTextNeeded(Item: TElXTreeItem;
    SectionIndex: Integer; var Text: TLMDString);
begin
  Text := '';
  if Assigned(FOnUserCellTextNeeded) then
    OnUserCellTextNeeded(Self, Item, SectionIndex, Text);
end;

procedure TCustomElXTree.SetVirtualityLevel(Value: TVirtualityLevel);
var
  i: Integer;
//  LOldVirtualityLevel: TVirtualityLevel;
  LItem: TElXTreeItem;
begin
  if FVirtualityLevel <> Value then
  begin
    if (FAllList.Count > 0) and (Value <> vlNone) and (csDesigning in ComponentState) and (ComponentState * [csLoading, csReading] = []) then
      if MessageBox(0, 'Changing Virtuality Level will clear all data of the items. Continue?', 'Warning', MB_ICONWARNING or MB_OKCANCEL) = IDCANCEL then
        Exit;
//    LOldVirtualityLevel := FVirtualityLevel;
    FVirtualityLevel := Value;
    IsUpdating := True;
    try
      if Value <> vlNone then
        FView.FVirtStyle := TElXCellStyle.Create(nil, nil)
      else
        FreeAndNil(FView.FVirtStyle);

      if (Value <> vlAllProps) or (csDesigning in ComponentState) then
        DataCacheDeallocate;

      for i := 0 to FAllList.Count - 1 do
      begin
        LItem := TElXTreeItem(FAllList[i]);
{
        if (Value in [vlTextAndStyles, vlAllProps]) and (LOldVirtualityLevel = vlNone) then
          LItem.DisposeStaticData
        else
          LItem.NewStaticData;
{}
        if (Value = vlAllProps) and not (csDesigning in ComponentState) then
//          LItem.DisposeStaticDataEx
        else
        begin
//          LItem.NewStaticDataEx;
          TriggerVirtualPropsNeeded(LItem, AllVirtPropTypes, LItem.FStaticDataEx);
        end;
      end;
      if (Value = vlAllProps) and not (csDesigning in ComponentState) then
        DataCacheAllocate;

      FView.FClearVis := True;
      FView.FVisUpdated:= True;
    finally
      IsUpdating := False;
    end;
  end;
end;

procedure TCustomElXTree.TriggerVirtualHintNeeded(Item: TElXTreeItem; var Hint :
    TLMDString);
begin
  Hint := '';
  if Assigned(FOnVirtualHintNeeded) then
    OnVirtualHintNeeded(Self, Item, Hint);
end;

procedure TCustomElXTree.TriggerVirtualValueNeeded(Item: TElXTreeItem;
    SectionIndex: Integer; VarType: Integer; var Value: Variant);
begin
  Value := Unassigned;
  if Assigned(FOnVirtualValueNeeded) then
    FOnVirtualValueNeeded(Self, Item, SectionIndex, VarType, Value);
end;

procedure TCustomElXTree.TriggerVirtualStyleNeeded(Item: TElXTreeItem;
    SectionIndex: Integer; Style: TElXCellStyle);
begin
  if Assigned(FOnVirtualStyleNeeded) then
    OnVirtualStyleNeeded(Self, Item, SectionIndex, Style);
end;

procedure TCustomElXTree.TriggerVirtualPropsNeeded(Item: TElXTreeItem;
        PropTypes: TElVirtPropTypes; Value: TElXTreeItemStaticDataEx);
begin
  if Assigned(FOnVirtualPropsNeeded) then
    FOnVirtualPropsNeeded(Self, Item, PropTypes, Value);
end;

procedure TCustomElXTree.SetStripedOddColor(Value: TColor);
begin
  if FStripedOddColor <> Value then
  begin
    FStripedOddColor := Value;
    if FStripedItems then
      Invalidate;
  end;
end;

procedure TCustomElXTree.SetStripedEvenColor(Value: TColor);
begin
  if FStripedEvenColor <> Value then
  begin
    FStripedEvenColor := Value;
    if FStripedItems then
      Invalidate;
  end;
end;

procedure TCustomElXTree.SetStripedItems(Value: Boolean);
begin
  if FStripedItems <> Value then
  begin
    FStripedItems := Value;
    Invalidate;
  end;
end;

procedure TCustomElXTree.TriggerInplaceEditorNeeded(Item: TElXTreeItem;
    SectionIndex: Integer; SupposedFieldType: TElFieldType; var Editor :
    TElTreeInplaceEditor);
begin
   Editor := FEditorManager.GetSuitableEditor(SupposedFieldType);
   if Assigned(FOnInplaceEditorNeeded) then
     FOnInplaceEditorNeeded(Self, Item, SectionIndex, SupposedFieldType, Editor);
end;

procedure TCustomElXTree.VertScrollHitTestTransfer(Sender: TObject; X, Y :
    Integer; var Part: TElScrollBarPart; var DefaultTest: Boolean);
begin
  if assigned(FOnVertScrollHitTest) then
    FOnVertScrollHitTest(Self, X, Y, Part, DefaultTest);
end;

procedure TCustomElXTree.HorzScrollHitTestTransfer(Sender: TObject; X, Y :
    Integer; var Part: TElScrollBarPart; var DefaultTest: Boolean);
begin
  if assigned(FOnHorzScrollHitTest) then
    FOnHorzScrollHitTest(Self, X, Y, Part, DefaultTest);
end;

function TCustomElXTree.GetHTMLControlByName(aControlName: TLMDString): TControl;
var
  i: integer;
begin
  result := nil;
  for i := 0 to FView.ControlCount - 1 do
    if FView.Controls[i].Name = aControlName then
    begin
      result := FView.Controls[i];
      break;
    end;
end;

procedure TCustomElXTree.SetVertDivLinesColor(Value: TColor);
begin
  if (FVertDivLinesColor <> Value) then
  begin
    IsUpdating := True;
    FVertDivLinesColor := Value;
    if FVerticalLines then
    begin
      FView.FClearAll := True;
      FUpdated := True;
    end;
    IsUpdating := False;
  end; {if}
end;

procedure TCustomElXTree.SetCheckBoxSize(Value: Integer);
begin
  if FCheckBoxSize <> Value then
  begin
    IsUpdating := True;
    FCheckBoxSize := Value;
    if FShowCheckboxes then
    with FView do
    begin
      if not ShowColumns then
        FView.FHRange := -1;
      FClearAll := True;
    end;
    FUpdated := True;
    IsUpdating := False;
  end;
end;

function TCustomElXTree.GetTrackItem: TElXTreeItem;
begin
  Result := FView.FTrackItem;
end;

function TCustomElXTree.GetDragging: Boolean;
begin
  Result := FView.FInDragging;
end;

procedure TCustomElXTree.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;

procedure TCustomElXTree.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
  end;

procedure TCustomElXTree.IFMCanPaintBkgnd(var Message: TMessage);
begin
  Message.Result := 1;
end;

procedure TCustomElXTree.SetShowLeafButton(Value: Boolean);
begin
  if FShowLeafButton <> Value then
  begin
    FShowLeafButton := Value;
    IsUpdating := True;
    with FView do
    begin
      if not ShowColumns then
        FHRange := -1;
      FUpdated := True;
      FRangeUpdate := True;
    end;
    IsUpdating := False;
  end;
end;

procedure TCustomElXTree.SetLeafPicture(Value: TBitmap);
begin
  LeafPicture.Assign(Value);
end;

procedure TCustomElXTree.MouseWheelTransfer(Sender: TObject; Shift: TShiftState;
    WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := DoMouseWheel(Shift, WheelDelta, MousePos);
end;

procedure TCustomElXTree.MouseWheelDownTransfer(Sender: TObject; Shift:
    TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := DoMouseWheelDown(Shift, MousePos);
end;

procedure TCustomElXTree.MouseWheelUpTransfer(Sender: TObject; Shift:
    TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := DoMouseWheelUp(Shift, MousePos);
end;

procedure TCustomElXTree.FitMostChildren(Item: TElXTreeItem);
begin
  FView.FitMostChildren(Item);
end;

{
function TCustomElXTree.GetThemedClassName: TLMDThemedItem;
begin
  Result := tiTreeView;
end;
}

procedure TCustomElXTree.SetUseXPThemes(const Value: Boolean);
begin
  inherited;
  if Assigned(Self.FHScrollBar) then
    Self.FHScrollBar.UseXPThemes := Value;
  if Assigned(Self.FVScrollBar) then
    Self.FVScrollBar.UseXPThemes := Value;
  TElHEaderHack(FHeader).UseXPThemes := Value;
  end;

procedure TCustomElXTree.SetThemeGlobalMode(const Value: Boolean);
begin
  inherited;
  if Assigned(Self.FHScrollBar) then
    Self.FHScrollBar.ThemeGlobalMode := Value;
  if Assigned(Self.FVScrollBar) then
    Self.FVScrollBar.ThemeGlobalMode := Value;
  FHeader.ThemeGlobalMode := Value;
end;

procedure TCustomElXTree.SetThemeMode(const Value: TLMDThemeMode);
begin
  inherited;
  if Assigned(Self.FHScrollBar) then
    Self.FHScrollBar.ThemeMode := Value;
  if Assigned(Self.FVScrollBar) then
    Self.FVScrollBar.ThemeMode := Value;
  FHeader.ThemeMode := Value;
end;

function TCustomElXTree.GetCheckBoxSize: Integer;
var
    PX: TSize;
    LUseThemeMode: TLMDThemeMode;
begin
  LUseThemeMode := UseThemeMode;
  if FCustomCheckboxes and Assigned(FCheckBoxGlyph) then
    Result := FCheckBoxGlyph.Width div 6
  else
  if (LUseThemeMode <> ttmNone) and (not (csDesigning in ComponentState)) then
  begin
      if not LMDThemeServices.GetThemePartSizeNew(LUseThemeMode,
        Canvas.Handle, teButton, BP_CHECKBOX, 0, PX) then
      begin
        Px.cx := 16;
        Px.cy := 16;
      end;
      Result := max(PX.cx, PX.cy);
  end
  else
    Result := FCheckBoxSize;
end;

function TCustomElXTree.GetHeaderPopupMenu: TPopupMenu;
begin
  Result := FHeader.PopupMenu;
end;

procedure TCustomElXTree.SetHeaderPopupMenu(Value: TPopupMenu);
begin
  FHeader.PopupMenu := Value;
end;

procedure TCustomElXTree.ReRenderAllHTMLItems;
var i: Integer;
    Item: TElXTreeItem;
begin
  for i := 0 to FAllList.Count - 1 do
  begin
    Item := TElXTreeItem(FAllList[i]);
    if Item.IsHTML then
    begin
      if not FShowColumns then
        Item.ReRenderMainText
      else
        Item.ReRenderAllTexts;
    end;
  end;
end;

procedure TCustomElXTree.SetHeaderFont(Value: TFont);
begin
  FHeaderFont.Assign(Value);
  if HeaderUseTreeFont then
    Header.Font.Assign(Value);
end;

procedure TCustomElXTree.SetHeaderUseTreeFont(Value: Boolean);
begin
  if FHeaderUseTreeFont <> Value then
  begin
    FHeaderUseTreeFont := Value;
    if FHeaderUseTreeFont then
      FHeader.Font := Font
    else
      FHeader.Font := FHeaderFont;
  end;
end;

procedure TCustomElXTree.HeaderFontChanged(Sender: TObject);
begin
  if not HeaderUseTreeFont then
    FHeader.Font := FHeaderFont;
end;

function TCustomElXTree.IsStripedColorStored: Boolean;
begin
  Result := StripedItems;
end;

function TCustomElXTree.IsOwnerDrawMaskStored: Boolean;
begin
  Result := (FOwnerDrawMask <> DefaultTreeOwnerDrawMask);
end;

procedure TCustomElXTree.ELThemeChanged(var Message: TMessage);
begin
  inherited;
  AlignPieces;
end;

procedure TCustomElXTree.ELSettingChange(var Message: TMessage);
begin
  if UseCustomScrollBars then
  begin
    SendMessage(FHScrollBar.Handle, Message.Msg, Message.wParam, Message.lParam);
    SendMessage(FVScrollBar.Handle, Message.Msg, Message.wParam, Message.lParam);
    AlignPieces;
  end;
end;

procedure TCustomElXTree.SetSortUseCase(Value: Boolean);
begin
  if FSortUseCase <> Value then
  begin
    FSortUseCase := Value;
  end;
end;

procedure TCustomElXTree.DoEnter;
begin
  inherited;
  FView.FHasFocus := True;
end;

procedure TCustomElXTree.DoExit;
begin
  FView.FHasFocus := False;
  inherited;
end;

procedure TCustomElXTree.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TCustomElXTree.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TCustomElXTree.SetDblClickMode(Value: TElDblClickMode);
begin
  if FDblClickMode <> Value then
  begin
    FDblClickMode := Value;
  end;
end;

procedure TCustomElXTree.OnBeforeHook(Sender: TObject; var Message: TMessage;
    var Handled: Boolean);
begin
  Handled := False;
  if Message.Msg = WM_ENTERSIZEMOVE then
    FInSizeMove := True
  else
  if Message.Msg = WM_EXITSIZEMOVE then
  begin
    FInSizeMove := False;
    Invalidate;
  end;
end;

procedure TCustomElXTree.SetParent(AParent: TWinControl);
begin
  inherited;
  if (AParent <> nil) and (FHook <> nil) then
  begin
    FHook.Control := GetParentForm(AParent);
    FHook.Active := DoubleBuffered and (not (csDesigning in componentState));
  end
  else
    if FHook <> nil then
      FHook.Control := nil;
  FInSizeMove := False;
end;

function TCustomElXTree.GetPlusPicture: TBitmap;
begin
  if FPlusPicture = nil then
  begin
    FPlusPicture := TBitmap.Create;
    FPlusPicture.OnChange := OnSignChange;
  end;
  Result := FPlusPicture;
end;

function TCustomElXTree.GetPlusPosition: TLMDVerticalAlign;
begin
  Result := vaTop;
  if Assigned(FView) then
    Result := FView.PlusPosition;
end;

function TCustomElXTree.GetLeafPicture: TBitmap;
begin
  if FLeafPicture = nil then
  begin
    FLeafPicture := TBitmap.Create;
    FLeafPicture.OnChange := OnSignChange;
  end;
  Result := FLeafPicture;
end;

function TCustomElXTree.GetMinusPicture: TBitmap;
begin
  if FMinusPicture = nil then
  begin
    FMinusPicture := TBitmap.Create;
    FMinusPicture.OnChange := OnSignChange;
  end;
  Result := FMinusPicture;
end;

function TCustomElXTree.GetCheckBoxGlyph: TBitmap;
begin
  if FCheckBoxGlyph = nil then
  begin
    FCheckBoxGlyph := TBitmap.Create;
    FCheckBoxGlyph.OnChange := OnCheckSignChange;
  end;
  Result := FCheckBoxGlyph;
end;

function TCustomElXTree.GetRadioButtonGlyph: TBitmap;
begin
  if FRadioButtonGlyph = nil then
  begin
    FRadioButtonGlyph := TBitmap.Create;
    FRadioButtonGlyph.OnChange := OnCheckSignChange;
  end;
  Result := FRadioButtonGlyph;
end;

procedure TCustomElXTree.OnCheckSignChange(Sender: TObject);
var
  i: Integer;
begin
  if not FCustomCheckboxes then
    Exit;
  if FView.FPainting then
    Exit;
  IsUpdating := True;
  if AutoLineHeight then
  begin
    i := DefineLineHeight;
    if i <> FLineHeight then
    begin
      with FView do
      begin
        FClearVis := True;
        if i < FLineHeight then
          FClearAll := True;
      end;
      FLineHeight := i;
    end;
    FView.FVisUpdated := True;
  end;
  with FView do
  begin
    FRangeUpdate := True;
    FUpdated := True;
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.WMUpdateSBFrame(var Message: TMessage);
begin
  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
end;

procedure TCustomElXTree.SetDoubleBuffered(Value: Boolean);
begin
  if FDoubleBuffered <> Value then
  begin
    FDoubleBuffered := Value;
    if FHook <> nil then
      FHook.Active := DoubleBuffered and (not (csDesigning in componentState));
    end;
end;

procedure TCustomElXTree.WMSysColorChange(var Msg: TWMSysColorChange);
begin
  inherited;
  PostMessage(FVScrollBar.Handle, Msg.Msg,  TMessage(Msg).WParam,  TMessage(Msg).LParam);
  PostMessage(FHScrollBar.Handle, Msg.Msg,  TMessage(Msg).WParam,  TMessage(Msg).LParam);
  PostMessage(FHeader.Handle, Msg.Msg,  TMessage(Msg).WParam,  TMessage(Msg).LParam);
  end; { WMSysColorChange }

procedure TCustomElXTree.SetHighlightAlphaLevel(Value: Integer);
begin
  if (FHighlightAlphaLevel <> Value) and (Value >= 0) and (Value <= 255) then
  begin
    FHighlightAlphaLevel := Value;
    Invalidate;
  end;
end;

procedure TCustomElXTree.ReadRightAlignedTree(Reader: TReader);
begin
  RightAlignedView := Reader.ReadBoolean;
end;

procedure TCustomElXTree.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
  begin
    Filer.DefineProperty('Action', FakeValue, nil, False);
    Filer.DefineProperty('NoBlendSelected', FakeBoolean, nil, False);
    Filer.DefineProperty('ScrollBackground', FakeBoolean, nil, False);
    {$ifndef HOTTRACK_CURSOR}
    Filer.DefineProperty('TrackingCursor', FakeValue, nil, False);
    {$endif}
  end;
  Filer.DefineProperty('RightAlignedTree', ReadRightAlignedTree, nil, False);
  Filer.DefineProperty('ExpandOnDblClick', ReadExpandOnDblClick, nil, False);
  Filer.DefineProperty('ScrollTracking', ReadScrollTracking, nil, False);
end;

procedure TCustomElXTree.DataCacheAllocate;
var i: Integer;
begin
  FDataCache := TElXDataCache.Create;
  for i := 0 to DataCacheSize -1 do
    FDataCache.Add(CreateDataCacheItem);
end;

procedure TCustomElXTree.DataCacheDeallocate;
begin
  if FDataCache <> nil then
  begin
    DataCacheClear;
    FreeAndNil(FDataCache);
  end;
end;

procedure TCustomElXTree.DataCacheClear;
var Item: TElXTreeItemStaticDataEx;
begin
  if (FDataCache <> nil) then
  begin
    while FDataCache.Count > 0 do
    begin
      Item := TElXTreeItemStaticDataEx(FDataCache.Last);
      if Item.ItemRef <> nil then
        Item.ItemRef.FStaticDataEx := nil;
      FreeAndNil(Item);
      FDataCache.Count := FDataCache.Count - 1;
    end;
  end;
end;

procedure TCustomElXTree.SetDataCacheSize(Value: Integer);
var i, j: Integer;
    Item: TElXTreeItemStaticDataEx;
begin
  if FDataCacheSize <> Value then
  begin
    FDataCacheSize := Value;
    if (FDataCache <> nil) then
    begin
      if FDataCache.Count > Value then
      begin
        i := Max(Value, FView.ColorHelper.Visible.Count);
        for j := 0 to FDataCache.Count - i - 1 do
        begin
          Item := TElXTreeItemStaticDataEx(FDataCache[j]);
          if Item.ItemRef <> nil then
            Item.ItemRef.FStaticDataEx := nil;
          FreeAndNil(Item);
          FDataCache[j] := nil;
        end;
        FDataCache.MoveRange(FDataCache.Count - i, FDataCache.Count - 1, 0);
        FDataCache.Count := i;
      end
      else
      begin
        i := Value - FDataCache.Count;
        while i > 0 do
        begin
          FDataCache.Add(CreateDataCacheItem);
          Dec(i);
        end;
      end;
    end;
  end;
end;

function TCustomElXTree.CreateDataCacheItem: TElXTreeItemStaticDataEx;
begin
  Result := TElXTreeItemStaticDataEx.Create;
  with Result do
  begin
    FBoolData1 := {ibfParentColors or} ibfParentStyle or ibfCheckBoxEnabled or ibfShowCheckbox or
      ibfEnabled or ibfUseBackGroundColor or ibfDrawHLine {or ibfAllowSelection }or ibfAllowEdit;
    FImageIndex := -1;
    FStImageIndex := -1;
    FImageIndex2 := -1;
    FStImageIndex2 := -1;
    FOverlayIndex := -1;
    FOverlayIndex2 := -1;
    FCheckBoxState := cbUnchecked;
    FCheckBoxType := ectCheckBox;
//    FBorderSpaceColor := clWindow;
  end;
end;

procedure TCustomElXTree.CacheItem(Item: TElXTreeItem; MinInCache: Integer);
var
  LIndex: Integer;
begin
Exit;
  if Item.FStaticDataEx <> nil then
  begin
    LIndex := FDataCache.IndexOf(Item.FStaticDataEx);
    if LIndex > 0 then
      FDataCache.Move(LIndex, FDataCache.Count - 1);
  end
  else
  begin
    if FDataCache.Count > MinInCache then
    begin
      Item.FStaticDataEx := TElXTreeItemStaticDataEx(FDataCache[0]);
      if Item.FStaticDataEx.ItemRef <> nil then
        Item.FStaticDataEx.ItemRef.FStaticDataEx := nil;
      Item.FStaticDataEx.ItemRef := Item;
      TriggerVirtualPropsNeeded(Item, AllVirtPropTypes, Item.FStaticDataEx);
      FDataCache.Move(0, FDataCache.Count - 1);
    end
    else
    begin
      Item.FStaticDataEx := CreateDataCacheItem;
      Item.FStaticDataEx.ItemRef := Item;
      TriggerVirtualPropsNeeded(Item, AllVirtPropTypes, Item.FStaticDataEx);
      FDataCache.Add(Item.FStaticDataEx);
    end;
  end;
end;

{function TCustomElXTree.GetEditorManager: TElTreeInplaceManager;
begin
  Result := FEditorManager;
end;}

function TCustomElXTree.GetIncSearchColumnText(Item: TElXTreeItem): TLMDString;
var cc: Integer;

    FData: TLMDHTMLData;

begin
  if Item = nil then
  begin
    Result := '';
    Exit;
  end;
  if ShowColumns and (SelectColumn <> -1) and (SelectColumn <> MainTreeColumn) then
  begin
    cc := SelectColumn;
//    if SelectColumn > MainTreeColumn then
//      Dec(cc);
    if Item.Cells.Count <= cc then
      Result := ''
    else
    begin
      Result := Item.Cells[cc].Text;
    end;
  end
  else
  if ShowColumns and (IncrementalSearchColumn = iscSortColumn) then
  begin
    cc := SortSection;
//    if SortSection > MainTreeColumn then
//      Dec(cc);
    if Item.Cells.Count <= cc then
      Result := ''
    else
      Result := Item.Cells[cc].Text;
  end
  else
  begin
    cc := -1;
    Result := Item.Text;
  end;
  if Item.IsHTML then
  begin
    if LMDIsHTMLText(Result) then
    begin
      with FView do
      begin
        if VirtualityLevel = vlNone then
        begin
          if cc <> -1 then
            FData := TLMDHTMLData(Item.FHTMLDataArray[cc])
          else
            FData := Item.FHTMLData;
        end
        else
        begin
          FRender.PrepareText(Result, 0, False);
          FData := FRender.Data;
        end;
        if FData <> nil then
        begin
          with FRender do
          begin
            SetData(FData);
            Result := FRender.AsText;
            if VirtualityLevel = vlNone then
              SetData(nil);
          end;
        end;
      end;
    end;
  end;
  end;

procedure TCustomElXTree.ResetVisItemsHeight;
var i: Integer;
begin
  IsUpdating := True;
  for i := 0 to FView.ColorHelper.Visible.Count - 1 do
  begin
    if (TElXTreeItem(FView.ColorHelper.Visible[i]).FBoolData and (ibfWordWrap or ibfMultiline)) = (ibfWordWrap or ibfMultiline) then
      TElXTreeItem(FView.ColorHelper.Visible[i]).FComplexHeight := (TElXTreeItem(FView.ColorHelper.Visible[i]).FComplexHeight and $FFFF0000) or word(-1);
  end;
  with FView do
  begin
    FVisUpdated := True;
    FClearVis := True;
    FClearAll := True;
    FRangeUpdate := True;
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.ResetAllItemsHeight;
var i: Integer;
begin
  IsUpdating := True;
  for i := 0 to Items.Count - 1 do
  begin
    if (Items[i].FBoolData and (ibfWordWrap or ibfMultiline)) = (ibfWordWrap or ibfMultiline) then
      Items[i].FComplexHeight := (Items[i].FComplexHeight and $FFFF0000) or word(-1);
  end;
  with FView do
  begin
    FVisUpdated := True;
    FClearVis := True;
    FClearAll := True;
    FRangeUpdate := True;
  end;
  IsUpdating := False;
end;

procedure TCustomElXTree.ReadScrollTracking(Reader: TReader);
begin
  FVertScrollTracking := Reader.ReadBoolean;
  FHorzScrollTracking := FVertScrollTracking;
end;

procedure TCustomElXTree.ReadExpandOnDblClick(Reader: TReader);
begin
  if Reader.ReadBoolean then
    DblClickMode := dcmExpand;
end;

procedure TCustomElXTree.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    if Flat then
      DrawFlatBorder(False, False);
    end;
end;

procedure TCustomElXTree.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    if Flat then
      DrawFlatBorder(False, False);
    end;
end;

procedure TCustomElXTree.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    if Flat then
      DrawFlatBorder(False, False);
    end;
end;

procedure TCustomElXTree.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    if Flat then
      DrawFlatBorder(False, False);
    end;
end;

procedure TCustomElXTree.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    if Flat then
      DrawFlatBorder(False, False);
    end;
end;

procedure TCustomElXTree.ResetUpdateCounter;
begin
  if FUpdateCount > 0 then
  begin
    FUpdateCount := 1;
    SetUpdating(False);
  end
  else
  begin
    FUpdateCount := 0;
  end;
  FHeader.ResetUpdateCounter;
end;

procedure TCustomElXTree.SetCheckBoxFlat(Value: Boolean);
begin
  if FCheckBoxFlat <> Value then
  begin
    IsUpdating := True;
    FCheckBoxFlat := Value;
    if FShowCheckboxes then
    with FView do
    begin
      FClearAll := True;
    end;
    FUpdated := True;
    IsUpdating := False;
  end;
end;

procedure TCustomElXTree.SetSortColumnColor(Value: TColor);
begin
  if FSortColumnColor <> Value then
  begin
    IsUpdating := True;
    FSortColumnColor := Value;
    FView.FClearAll := True;
    FUpdated := True;
    IsUpdating := False;
  end;
end;

function TCustomElXTree.GetFixedColNum: Integer;
begin
  Result := FHeader.FixedColNum;
end;

function TCustomElXTree.GetGutterWidth: Integer;
begin
    Result := FGutterWidth;
end;

procedure TCustomElXTree.SetFixedColNum(Value: Integer);
begin
  FHeader.FixedColNum := Value;
  if not IsUpdating then
    Invalidate;
end;

procedure TCustomElXTree.SetGutterWidth(AValue: Integer);
begin
  FGutterWidth := max(0, AValue);
  if Assigned(FHeader) and (FHeader.Sections.Count > -1) and Assigned(FHeader.GutterSection) then
  begin
    FHeader.GutterSection.Width := AValue;
    FHeader.RecalcColumnsWidth;
    FHeader.CalcFixedColWidth;
  end;
//  Invalidate;
end;

function TCustomElXTree.GetGutterText: TLMDString;
begin
  Result := FGutterText;
end;

procedure TCustomElXTree.SetGutterText(AValue: TLMDString);
begin
  FGutterText := AValue;
  if Assigned(FHeader) and (FHeader.Sections.Count > -1) and Assigned(FHeader.GutterSection) then
    FHeader.GutterSection.Text := AValue;
end;

function TCustomElXTree.GetFixedBottomRowsHeight: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := max(0, Items.Count - FFixedBottomRowNum) to Items.Count - 1 do
  begin
    Inc(Result, Items[i].Height);
    if FHorizontalLines then
      Inc(Result, FDivLineWidth);
  end;
end;

procedure TCustomElXTree.SetFixedTopRowNum(Value: Integer);
begin
  if FFixedTopRowNum = Value then
    Exit;
  if not (csLoading in ComponentState) then
  begin
    FFixedTopRowNum := min(Value, VisibleRowCount - FFixedBottomRowNum);
    FTopIndex := Value;
    UpdateScrollBars;
    SetTopIndex(Value);
    Invalidate;
  end
  else
    FFixedTopRowNum := Value;
end;

procedure TCustomElXTree.SetFixedBottomRowNum(Value: Integer);
begin
  if FFixedBottomRowNum = Value then
    Exit;
  if not (csLoading in ComponentState) then
  begin
    FFixedBottomRowNum := min(Value, VisibleRowCount - FFixedTopRowNum);
    FView.FillVisFwd(FTopIndex);
    UpdateScrollBars;
    Invalidate;
  end
  else
    FFixedBottomRowNum := Value;
end;

function TElXTreeItemStaticDataEx.GetImage(Index: Integer): Integer;
begin
  case Index of
    1: Result := FImageIndex2;
    2: Result := FStImageIndex;
    3: Result := FStImageIndex2;
    4: Result := FOverlayIndex;
    5: Result := FOverlayIndex2;
    else
      Result := FImageIndex;
  end;
end;

procedure TElXTreeItemStaticDataEx.SetImage(Index: Integer; Value: Integer);
begin
  case Index of
    1: FImageIndex2 := Value;
    2: FStImageIndex := Value;
    3: FStImageIndex2 := Value;
    4: FOverlayIndex := value;
    5: FOverlayIndex2 := value;
    else
      FImageIndex := value;
  end;
end;

function TElXTreeItemStaticDataEx.GetBoolFlag(Index: Integer): Boolean;
begin
  Result := (FBoolData1 and Index) <> 0;
end;

procedure TElXTreeItemStaticDataEx.SetBoolFlag(Index: Integer; Value: Boolean);
begin
  if Value then
    FBoolData1 := FBoolData1 or Index
  else
    FBoolData1 := FBoolData1 and not Index;
end;

//function TElXTreeItemStaticDataEx.GetState(Index: TSTIState): Boolean;
//begin
//  Result := TSTIState(Index) in FState;
//end;
//
//procedure TElXTreeItemStaticDataEx.SetState(Index: TSTIState; Value: Boolean);
//begin
//  case TSTIState(Index) of
//    stsCut:
//      begin
//        if value = False then
//          Exclude(FState, stsCut)
//        else
//          Include(FState, stsCut);
//      end;
//    stsUnderlined:
//      begin
//        if value = False then
//          Exclude(FState, stsUnderlined)
//        else
//          Include(FState, stsUnderlined);
//      end;
//    stsBold:
//      begin
//        if value = False then
//          Exclude(FState, stsBold)
//        else
//          Include(FState, stsBold);
//      end;
//    stsItalic:
//      begin
//        if value = False then
//          Exclude(FState, stsItalic)
//        else
//          Include(FState, stsItalic);
//      end;
//    stsStrikeOut:
//      begin
//        if value = False then
//          Exclude(FState, stsStrikeOut)
//        else
//          Include(FState, stsStrikeOut);
//      end;
//  end; // case
//end;
//
//function TElXTreeItemStaticDataEx.GetFontStyles: TFontStyles;
//var
//  LState: TElSTIStates;
//begin
//  Result := [];
//  LState := FState;
//  if stsBold in LState then
//    Include(Result, fsBold);
//  if stsItalic in LState then
//    Include(Result, fsItalic);
//  if stsStrikeOut in LState then
//    Include(Result, fsStrikeOut);
//  if stsUnderlined in LState then
//    Include(Result, fsUnderline);
//end;

procedure TElXTreeItemStaticDataEx.Assign(Source: TElXTreeItemStaticDataEx);
begin
  FBoolData1 := Source.FBoolData1;
  FState := Source.FState;
//  FBackGroundColor := Source.FBackGroundColor;
//  FStrikedLineColor:= Source.FStrikedLineColor;
//  FBorderSpaceColor:= Source.FBorderSpaceColor;
  FIndentAdjust:= Source.FIndentAdjust;
//  FBorderStyle:= Source.FBorderStyle;
//  FTextColor := Source.FTextColor;
  FCheckBoxType:= Source.FCheckBoxType;
  FCheckBoxState:= Source.FCheckBoxState;
//  FCellBackGroundColor:= Source.CellBackGroundColor;
  FImageIndex := Source.FImageIndex;
  FStImageIndex := Source.FStImageIndex;
  FImageIndex2 := Source.FImageIndex2;
  FStImageIndex2:= Source.FStImageIndex2;
  FOverlayIndex := Source.FOverlayIndex;
  FOverlayIndex2:= SOurce.FOverlayIndex2;
end;

function TElXTreeItem.GetClipRect: TRect;
var
  i: Integer;
  LTopItemIndex, LBottomItemIndex: Integer;
  LCell: TElXTreeCell;
  LItem: TElXTreeItem;
  LView: TElXTreeView;
  LVisible: TLMDObjectList;
begin
  LCell := nil;
  for i := 0 to FCells.Count - 1 do
  begin
    LCell := FCells[i];
    if LCell.FJointCellRole = jcrSingle then
      continue;
    LCell := LCell.JointCellMaster;
    break;
  end;
  if not Assigned(LCell) then
    Exit;
  LItem := LCell.Owner;
  LView := FOwner.FView;
  LTopItemIndex := LView.ColorHelper.Visible.IndexOf(LItem);
  LBottomItemIndex := LTopItemIndex + LCell.JointRowCount - 1;
  LVisible := LView.ColorHelper.Visible;
  SetRectEmpty(Result);
  if not LMDInRange(LTopItemIndex, 0, LVisible.Count - 1)
    and not LMDInRange(LBottomItemIndex, 0, LVisible.Count - 1)
    or (csDestroying in LView.ComponentState)
  then
    Exit;

  Result := FOwner.FView.GetItemRect(LTopItemIndex);

  Result.Right := LView.Width;
  Result.Bottom := Result.Top + LCell.Height;
//  Result := LView.GetItemRect(LView.ColorHelper.Visible.IndexOf(Self));
end;

function TElXTreeItem.CreateCell: TElXTreeCell;
begin
  Result := TElXTreeCell.Create(Self);
end;

function TElXTreeItem.CreateCellRow(AOwner: TElXTreeItem): TElXTreeCellRow;
begin
  Result := TElXTreeCellRow.Create(Self);
end;

function TElXTreeItem.GetHeaderSections: TElXHeaderSections;
begin
  if Assigned(FOwner) and Assigned(FOwner.FHeader) then
    Result := FOwner.FHeader.Sections
  else
    Result := nil;
end;

procedure TElXTreeItem.DeleteCell(AIndex: Integer);
var
  LCell: TElXTreeCell;
begin
  if LMDInRange(AIndex, 0, Cells.Count) then
  begin
    LCell := Cells[AIndex];
    Cells.Remove(Cells[AIndex]);
    LCell.Free;
  end;
end;

function TElXTreeItem.BackGroundColor: TColor;
begin
  Result := clNone;
  if (UseOwnStyle) then
  begin
    if (not Style.ParentColors) and (Style.CellBackGroundColor <> clNone) then
      Result := Style.CellBackGroundColor
    else
    begin
     if Assigned(Parent) then
       Result := Parent.BackGroundColor
     else
       if FOwner.BackgroundType = bgtColorFill then
         Result := FOwner.BackGroundColor;
    end;
  end
  else
    if FOwner.Style.UseBackGroundColor then
     Result := FOwner.Style.CellBackGroundColor;
end;

function TElXTreeItem.GetUseOwnStyle: Boolean;
begin
  Result := FUseOwnStyle or ((Owner.VirtualityLevel > vlNone) and (not (csDesigning in Owner.ComponentState)))
end;

{ TElXTreeCell }

function TElXTreeCell.GetElHeaderSection: TElXHeaderSection;
begin
  Result := TElXHeaderSection(inherited HeaderSection);
end;

function TElXTreeCell.GetJointCellMaster: TElXTreeCell;
begin
  Result := TElXTreeCell(inherited JointCellMaster);
end;

function TElXTreeCell.GetOwner: TElXTreeItem;
begin
  Result := FOwner as TElXTreeItem;
end;

{procedure TElXTreeCell.SetHeaderSection(const Value: TElHeaderSection);
begin
  inherited HeaderSection := Value;
end;}

procedure TElXTreeCell.SetOwner(const Value: TElXTreeItem);
begin
  inherited Owner := Value;
end;

{procedure TElXTreeItems.BindCellColumn(const AHeaderSection: TElHeaderSection);
var
  i: Integer;
  LItem: TElXTreeItem;
begin
  for i := 0 to FOwner.FItems.Count - 1 do
  begin
    LItem := FOwner.Items[i];
    LItem.BindCell(AHeaderSection);
  end;
end;}

procedure TElXTreeCell.SetWidth(const AValue: Integer);
begin
  FWidth := AValue;
end;

{ TElXTreeCellRow }

constructor TElXTreeCellRow.Create(AOwner: TElXTreeItem);
begin
  inherited Create;
  FOwner := AOwner;
  FCol := -1;
  CreateCells(AOwner);
end;

function TElXTreeCellRow.GetCell(AIndex: Integer): TElXTreeCell;
begin
  if (AIndex >= 0) and (AIndex < FCount) then
    Result := TElXTreeCell(FastGet(AIndex))
  else
    Result := nil;
end;

function TElXTreeCellRow.Add: TElXTreeCell;
begin
  Result := FOwner.CreateCell; //   Result := TElXTreeCell.Create(FOwner);
  inherited Add(Result);
//  if FCol < 0 then
//    FCol := 0;
end;

function TElXTreeCellRow.Insert(AIndex: Integer): TElXTreeCell;
begin
  Result := Insert(AIndex, TElXTreeCell.Create(FOwner));
end;

function TElXTreeCellRow.Insert(AIndex: Integer; ACell: TElXTreeCell): TElXTreeCell;
begin
  Result := ACell;
  inherited Insert(AIndex, ACell);
//  if FCol < 0 then
//    FCol := 0;
end;

function TElXTreeCellRow.GetCol: Integer;
begin
//  if TElXTreeItem(Owner).Owner.RowSelect then
//    Result := -1
//  else
    Result := FCol;
end;

procedure TElXTreeCellRow.SetCol(const Value: Integer);
begin
{.$message 'TElXTreeCellRow.SetCol is not realized yet'}
end;

procedure TElXTreeCellRow.CreateCells(AOwner: TElXTreeItem);
var
  i: Integer;
begin
  if Assigned(AOwner)
    and Assigned(AOwner.Owner)
    and Assigned(AOwner.Owner.HeaderSections)
  then
  begin
    if (csReading in FOwner.Owner.ComponentState) or (csWriting in FOwner.Owner.ComponentState) then
    begin
      for i := Count to AOwner.Owner.HeaderSections.Count - 2 do // ignore gutter
        Add;
    end
    else
    begin
      for i := Count to AOwner.Owner.HeaderSections.Count - 1 do
        Add;
    end;
    if AOwner.Owner.HeaderSections.Count = 0 then
      Add;
  end;
end;

{ TElXTree }

procedure TElXTreeView.OnConstrainedResizeHandler(Sender: TObject;
  var MinWidth, MinHeight, MaxWidth, MaxHeight: Integer);
begin
  MinHeight := FOwner.GetFixedBottomRowsHeight;
end;

{ TElXTreeHeader }

constructor TElXTreeHeader.Create(AOwner: TComponent);
var
  LSection: TElXHeaderSection;
begin
  inherited;
  FSectionOffset := 1;
  FFixedColNum := 1;
  LSection := Sections.AddSection as TElXHeaderSection; // Gutter
  LSection.Width := (Owner as TCustomElXTree).GutterWidth;
  LSection.AllowClick := False;
end;

function TElXTreeHeader.CreateHeaderCellRow: TElXHeaderCellRow;
begin
  result := TElXHeaderCellRow.Create(Self);
end;

function TElXTreeHeader.GetGutterSection: TElXHeaderSection;
begin
  Result := Sections[-1] as TElXHeaderSection
end;

function TElXTreeHeader.GetTree: TCustomElXTree;
begin
  Result := inherited Owner as TCustomElXTree;
end;

procedure TElXTreeHeader.SetRowCount(const AValue: Integer);
begin
  inherited;
  if not ((csReading in Owner.ComponentState) or (csWriting in Owner.ComponentState)) then
    if RowCount > 1 then
      (GutterSection as TElXHeaderSection).Cell[0].Join(RowCount, 1);
end;

procedure TElXTreeHeader.Loaded;
begin
  inherited Loaded;
  if FFixedColNum = 0 then
    FFixedColNum := 1;
end;

{ TElXDataCache }

{function TElXDataCache.Add(const Item: Pointer): Integer;
begin
  Result := inherited Add(Item);
end;
}
procedure TElXDataCache.Move(CurIndex, NewIndex: Integer);
begin
  inherited;
end;

{function TElXDataCache.Remove(const Item: Pointer): Integer;
begin
  Result := inherited Remove(Item);
end;}

var
  OleDLL: HModule;

procedure TElXTreeItems.RecheckMasterCells;
var
  i, j: integer;
begin
  for i := 0 to Count - 1 do
  begin
    for j := 0 to Item[i].Cells.Count - 1 do
    begin
      if (Item[i].Cells[j].JointCellRole = jcrMaster)
          and (Item[i].Cells[j].JointRowCount + i <= Count)
          and (Item[i].Cells[j].JointColumnCount + j <= Item[i].Cells.Count) then
      begin
        Item[i].Cells[j].Join(Item[i].Cells[j].JointRowCount,Item[i].Cells[j].JointColumnCount)
      end
    end;
  end;
end;


initialization
  OleDLL := LoadLibrary('OLE32.DLL');
  Screen.Cursors[crDragSingleNo] := LoadCursor(OleDLL, PChar(1));
  Screen.Cursors[crDragSingleMove] := LoadCursor(OleDLL, PChar(2));
  Screen.Cursors[crDragSingleCopy] := LoadCursor(OleDLL, PChar(3));

  PlusBmp := TBitmap.Create;
  MinusBmp := TBitmap.Create;
  LeafBmp := TBitmap.Create;

  PlusBmp.LoadFromResourceName(HInstance, 'PlusBmp');
  MinusBmp.LoadFromResourceName(HInstance, 'MinusBmp');
  LeafBmp.LoadFromResourceName(HInstance, 'LeafBmp');
  PlusBmp.PixelFormat := pf32bit;
  MinusBmp.PixelFormat := pf32bit;
  LeafBmp.PixelFormat := pf32bit;

  ChangeButtonColors(PlusBmp);
  ChangeButtonColors(MinusBmp);
  ChangeButtonColors(LeafBmp);

  PlusBmp.PixelFormat := pfDevice;
  MinusBmp.PixelFormat := pfDevice;
  LeafBmp.PixelFormat := pfDevice;

finalization
  try
    FreeAndNil(PlusBmp);
    FreeAndNil(MinusBmp);
    FreeAndNil(LeafBmp);
//    FreeAndNil(GutterArrowBmp);
    FreeLibrary(OleDLL);
  except
    on e:Exception do
      OutputDebugString(PChar('ERROR finalization ElXTree: ' + e.Message));
  end;
end.
