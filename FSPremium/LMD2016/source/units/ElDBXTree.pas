unit ElDBXTree;
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

ElDBXTree unit
--------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils,
  Classes,

  Windows,
  Messages,
  Graphics,
  Controls,
  StdCtrls,
  Forms,
  Dialogs,
  DBCtrls,
  ExtCtrls,

  TypInfo,
  DB,
  Math,
  LMDTypes,
  ElVCLUtils,
  ElComponent,
  ElXPThemedControl,
  ElXTree,
  ElXTreeCell,
  ElXHeader,
  ElHeader,
  ElMTree,
  ElSBCtrl,
  LMDObjectList,
  LMDStrings,

  Variants,
  Types,

{$IFDEF LMD_UNICODE}
  LMDUnicodeStrings,
{$ENDIF}
  LMDUnicode,
  ElTreeInplaceEditors,
  LMDDebugUnit,
  LMDProcs,
  LMDGraphUtils,
  LMDElDBConst;

type
  TCustomElDBXTree = class;
  TElDBXTreeItem = class;
  TElXStylesDefsItem = class;

  EOnErrorInMTree = class (Exception)
  end;

  EOnDeleteFromDenyDataSet = class (Exception)
  end;

  TElXOnActivateLevel = procedure (Sender: TObject; MasterValue: TLMDString; RelNo: Integer) of object;

//  TOnRelationUse = procedure (Sender: TObject; MasterValue: TLMDString) of
//          object;

  TElXOnItemChangedEvent = procedure (AItem: TElDBXTreeItem) of object;
  TElXOnItemCreated = procedure (Item: TElDBXTreeItem) of object;

  TElXOnCustomColumnDataNeed = procedure (Sender: TObject; MasterValue: TLMDString; RelNo: Integer;
          SectionNumber: Integer;var UserData: Variant;var IsPicture :
          Boolean) of object;

  TElXRelDataSource = class;
  TElXRelationsItem = class;
  TElXRelations = class;

  TElXCustomEvent = (elSetModify, elSetRelActive, elRecordChange, elUserDefined, elRelDeleted, elRelAdded, elRelSetChanged, elSetRelRefresh, elTreeNeedRefresh, elTreeNeedRepaint);
  TElXDataSetOptions = set of (elIsCaption, elDenyLookSetPosition);
  TValName = (vnCellType, vnHint, vnDataField, vnDetailField, vnMasterField, vnMasterValue, vnText, vnMarker, vnHasPicture, vnCheckBoxField, vnCheckBoxFromBase, vnImageIndex2, vnImageIndex, vnImagesFromBase, vnRelIndex, vnStateImageIndex2, vnStateImageIndex, vnCheckBoxState, vnPicture, vnOwnerHeight, vnHeight, vnImageIndexField, vnImageIndex2Field, vnStImageIndexField, vnStImageIndex2Field);

  TElDBTreeInplaceEditor = class (TElTreeInplaceEditor)
  protected
    FOnAfterCompleteOperation: TNotifyEvent;
    function GetTree: TElTreeAncestor;
    procedure SetTree(Value: TElTreeAncestor);
    procedure TriggerAfterCompleteOperation; virtual;
  public
    procedure StartOperation; override;
  published
    property Tree: TElTreeAncestor read GetTree write SetTree;
    property OnAfterCompleteOperation: TNotifyEvent read FOnAfterCompleteOperation write FOnAfterCompleteOperation;
  end;

// TElXTreeDataLink

  TElXTreeDataLink = class (TPersistent)
  private
    FDataSetName: string;
    FTreeView: TCustomElDBXTree;
  protected
    procedure NotifyControl(Event: TElXCustomEvent; UserTag: integer); virtual;
  public
    constructor Create(ATreeView: TCustomElDBXTree);
  end;

//  TElXRelationsItem
  TElXMasterField = type string;
  TElXDetailField = type string;
  TElXDetailDisplayField = type string;

  TElXSourceDataLink = class (TDataLink)
  private
    FElRelationsItem: TElXRelationsItem;
    FElRelDataSource: TElXRelDataSource;
    FCount: integer;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure EditingChanged; override;
  public
    constructor Create(AElRelDataSource: TElXRelDataSource; AElRelationsItem:
            TElXRelationsItem);
  end;

// TElXRelationsItem

  TElXRelationsItem = class(TPersistent)
  protected
    ID: Integer;
    FName : String;
    FRelations: TElXRelations;
    FCaption: TLMDString;
    FShowCaption: Boolean;
    FActive: Boolean;
    FActiveOnLevel: Integer;
    FAfterRefresh: TDataSetNotifyEvent;
    FDenyLookSetPosition: Boolean;
    FDetailDataLink: TElXSourceDataLink;
    FDetailDataSource: TDataSource;
    FDetailDisplayField: TElXDetailDisplayField;
    FDetailField: TElXDetailField;
    FMasterDataSource: TDataSource;
    FMasterField: TElXMasterField;
    FOwnFilter: string;
    FOwnFiltered: Boolean;
    function GetIndex: Integer;
    function GetDetailDataSet: TDataSet;
    function GetMasterDataSet: TDataSet;
    procedure SetCaption(const Value: TLMDString);
    procedure SetShowCaption(const Value: Boolean);
    procedure SetAfterRefresh(ADataset: TDataSet);
    procedure SetDenyLookSetPosition(Value: Boolean);
    procedure SetDetailDataSet(ADataSet: TDataSet);
    procedure SetDetailDisplayField(AField: TElXDetailDisplayField);
    procedure SetDetailField(AField: TElXDetailField);
    procedure SetMasterField(AField: TElXMasterField);
    procedure SetMasterDataSet(ADataSet: TDataSet);
    function GetDetailDataSource: TDataSource;
    function GetMasterDataSource: TDataSource;
  public
    procedure LoadFromStream(Stream : TStream);
    procedure WriteToStream(Stream : TStream);
    constructor Create(ARelations: TElXRelations; AID : Integer); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Active: Boolean read FActive write FActive default True;
    property ActiveOnLevel: Integer read FActiveOnLevel write FActiveOnLevel
            default -1;
    property DenyLookSetPosition: Boolean read FDenyLookSetPosition write
            SetDenyLookSetPosition default False;
    property DetailDataSet: TDataSet read GetDetailDataSet write
            SetDetailDataSet;
    property DetailDisplayField: TElXDetailDisplayField read FDetailDisplayField
            write SetDetailDisplayField;
    property DetailField: TElXDetailField read FDetailField write SetDetailField;
    property MasterDataSet: TDataSet read GetMasterDataSet write
            SetMasterDataSet;
    property MasterField: TElXMasterField read FMasterField write SetMasterField;
//    property OnRelationUse: TOnRelationUse read FOnRelationUse write
//            FOnRelationUse;
    property Caption: TLMDString read FCaption write SetCaption;
    property ShowCaption: Boolean read FShowCaption write SetShowCaption;
    property Index: Integer read GetIndex;
    property Name: String read FName write FName;
  end;

//  TRelations

  TElXRelations = class(TPersistent)
  private
    FElRelDataSource: TElXRelDataSource;
    FList: TList;
    function GetItem(Index: Integer): TElXRelationsItem;
    procedure SetItem(Index: Integer; Value: TElXRelationsItem);
    function GetCount : Integer;
  protected
    function GetOwner: TPersistent; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure LoadRelProperty(Stream: TStream);
    procedure WriteRelProperty(Stream: TStream);
  public
    constructor Create(AElRelDataSource: TElXRelDataSource); virtual;
    procedure Assign(Source: TPersistent); override;
    destructor Destroy; override;
    procedure Changed;
    procedure DeleteItem(Index: integer);
    procedure AddItem(Index: Integer);
    property DataSource: TElXRelDataSource read FElRelDataSource;
    property Items[Index: Integer]: TElXRelationsItem read GetItem write SetItem;default;
    property Count: Integer read GetCount;
  end;

// TElXRelDataSource
  TElXDataField = type string;

  TElXRelDataSource = class(TElComponent)
  private
    FCaption: TLMDString;
    FShowCaption: Boolean;
    FAfterRefresh: TDataSetNotifyEvent;
    FDataField: TElXDataField;
    FDenyLookSetPosition: Boolean;
    FOwnFilter: string;
    FOwnFiltered: Boolean;
    FFilter: string;
    FFiltered: Boolean;
//    FOwnFilter: Boolean;
    FRelations: TElXRelations;
    FRootDataLink: TElXSourceDataLink;
    FRootDataSource: TDataSource;
    FTreeDataLinks: TList;
    procedure SetAfterRefresh(ADataset: TDataSet); virtual;
    function GetRootDataSet: TDataSet;
    procedure SetRelations(Value: TElXRelations);
    function GetSetOnLevel(Level: Integer; var DataSetOptions :TElXDataSetOptions): TDataSet;
  protected
    procedure SetRootDataSet(ADataSet: TDataSet);
    procedure SetDataField(const Value: TElXDataField);
    procedure SetDenyLookSetPosition(Value: Boolean);
    procedure SetFilter(const Value: string);
    procedure SetCaption(const Value: TLMDString);
    procedure SetShowCaption(const Value: Boolean);
    procedure SetFiltered(const Value: Boolean);
    procedure LoadCompProperty(Stream: TStream);
    procedure StoreCompProperty(Stream: TStream);
  public
    function GetRelNoOnLevel(Level: Integer; var DataSetOptions :TElXDataSetOptions): integer;
    function RecCountOnLevel(Level: Integer;  MasterValue: TLMDString): integer; virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetRootDataSource: TDataSource;
    procedure NotifyLinks(Event: TElXCustomEvent; UserTag: integer); virtual;
    procedure RegisterLink(ALink: TElXTreeDataLink); virtual;
    procedure UnRegisterLink(ALink: TElXTreeDataLink); virtual;
    property RootDataSet:TDataSet read GetRootDataSet write SetRootDataSet;
    property DataField:TElXDataField read FDataField write SetDataField;
  published
    property DataSet: TDataSet read GetRootDataSet write SetRootDataSet;
    property DenyLookSetPosition: Boolean read FDenyLookSetPosition write
            SetDenyLookSetPosition default False;
    property Filter: string read FFilter write SetFilter;
    property Filtered: Boolean read FFiltered write SetFiltered default false;
//    property OwnFilter: Boolean read FOwnFilter write FOwnFilter;
    property Relations: TElXRelations read FRelations write SetRelations;
    property RootDataField: TElXDataField read FDataField write SetDataField;
    property Caption: TLMDString read FCaption write SetCaption;
    property ShowCaption: Boolean read FShowCaption write SetShowCaption default false;
  end;

  TElXHackTreeView = class (TElXTreeView)
  end;

  THackElXTreeInplaceManager = class (TElTreeInplaceManager)
  end;
  THackElXTreeItem = class(TElXTreeItem)
  end;

  TElMDBTree = class(TElMTree)
  private
    FTree: TCustomElDBXTree;
    function GetRowCount : Integer;
  public
    procedure RebuildTree;
    procedure RefreshData;
    procedure Clear;override;
    function DBChildrensCount(Parent: TElMTreeItem): integer;
    procedure CheckActualChildrensCount(AParent: TElMTreeItem);
    procedure GetDataForChildrens(Parent: TElMTreeItem; StartIndex,StopIndex: integer);
    property Tree: TCustomElDBXTree read FTree write FTree;
    property RowCount : integer read GetRowCount;
  end;

//TMData
//  TValName = (FCellType, FHint, FDataField, FDetailField, FMasterField, FMasterValue, FText, FMarker, FHasPicture, FCheckBoxField, FCheckBoxFromBase,
//              FImageIndex2, FImageIndex, FImagesFromBase, FRelIndex, FStateImageIndex2, FStateImageIndex, FCheckBoxState, FPicture, FOwnerHeight, FHeight);
// TElDBXTreeItem
{$HINTS OFF}
{$WARNINGS OFF}

  TElDBXTreeItem = class (TElXTreeItem)
  private
    function GetAncestor: TElDBXTreeItem;
  protected
    FMItem: TElMTreeItem;
    FBookmark: TBookmark;
    FDataField: string;
    FDetailField: string;
    FMasterField: string;
    FMasterValue: TLMDString;
    FMarker: Boolean;
    FHasPicture: Boolean;
    FChangingItem: Boolean;
    FCheckBoxField: string;
    FCheckBoxFromBase: Boolean;
//    FEditingField: string;
    FImage2Index: string;
    FImageIndex: string;
    FImagesFromBase: Boolean;
    FRelIndex: Integer;
    FStImage2Index: string;
    FStImageIndex: string;
    procedure DeleteChild;
    procedure CheckActualChildrens;
    function GetItems(Index: integer): TElDBXTreeItem;
    function GetOwner: TCustomElDBXTree;
    function GetParent: TElDBXTreeItem;
    function GetText: TLMDString;
    function GetRelIndex: integer;
    function GetCheckBoxField: string;
    function GetCheckBoxFromBase: Boolean;
    function GetDataField: string;
    function GetBookmark: TBookmark;
    function GetDetailField: string;
    function GetImage2IndexField: string;
    function GetImageIndexField: string;
    function GetImagesFromBase: Boolean;
    function GetMasterField: string;
    function GetEditingField: string;
    function GetMasterValue: TLMDString;
    function GetStateImage2IndexField: string;
    function GetStateImageIndexField: string;
//    procedure MoveTo(NewParent: TElDBXTreeItem);
    procedure SetStyle;
    procedure SetText(Value: TLMDString); override;
    procedure SetEditingField(Value: string);

    property CheckBoxFromBase: Boolean read GetCheckBoxFromBase write FCheckBoxFromBase;
    property DetailField: string read GetDetailField write FDetailField;
    property Image2IndexField: string read GetImage2IndexField write FImage2Index;
    property ImageIndexField: string read GetImageIndexField write FImageIndex;
    property ImagesFromBase: Boolean read GetImagesFromBase write FImagesFromBase;
    property StateImage2IndexField: string read GetStateImage2IndexField write
            FStImage2Index;
    property StateImageIndexField: string read GetStateImageIndexField write
            FStImageIndex;

    procedure DeleteFromDataSet; virtual;
    procedure InsertSiblingToDataSet;
    procedure InsertChildToDataSet;
  public
    constructor Create(AOwner: TCustomELXTree); override;
    destructor Destroy; override;

    procedure MoveTo(NewParent: TElXTreeItem);override;
    procedure MoveToIns(NewParent: TElXTreeItem; AnIndex: Integer);override;
    property RelIndex: Integer read GetRelIndex;
    property MasterField: string read GetMasterField;
    property MasterValue: TLMDString read GetMasterValue;
    property DataField: string read GetDataField;

    procedure EndEdit(ByCancel : boolean);virtual;
    procedure Assign(Source: TPersistent); override;
    procedure Delete; override;
    function GetChildByIndex(index: integer): TElDBXTreeItem;
    function GetFirstChild: TElDBXTreeItem;
    function GetFirstSibling: TElDBXTreeItem;
    function GetFirstVisibleChild: TElDBXTreeItem;
    function GetLastChild: TElDBXTreeItem;
    function GetLastSibling: TElDBXTreeItem;
    function GetLastSubItem: TElDBXTreeItem;
    function GetNext: TElDBXTreeItem; virtual;
    function GetNextChild(Child: TElDBXTreeItem): TElDBXTreeItem;
    function GetNextSibling: TElDBXTreeItem;
    function GetNextVisible: TElDBXTreeItem;
    function GetPrev: TElDBXTreeItem; virtual;
    function GetPrevChild(Child: TElDBXTreeItem): TElDBXTreeItem;
    function GetPrevSibling: TElDBXTreeItem;
    function GetPrevVisible: TElDBXTreeItem;
    property Ancestor: TElDBXTreeItem read GetAncestor;
    property Bookmark: TBookmark read GetBookmark;
    property Children[Index: integer]: TElDBXTreeItem read GetItems;
    property EditingField: string read GetEditingField write SetEditingField;
    property Item[Index: integer]: TElDBXTreeItem read GetItems;
//    property MasterValue: TLMDString read GetMasterValue;
    property Owner: TCustomElDBXTree read GetOwner;
    property Parent: TElDBXTreeItem read GetParent;
    property Text: TLMDString read GetText write SetText;
    property TreeView: TCustomElDBXTree read GetOwner;
    function GetDataSource : TDataSource;
    property CheckBoxField: string read GetCheckBoxField;
  end;

{$WARNINGS ON}

  TElDBXTreeItems = class (TElXTreeItems)
  private
    function GetDBItem(Index: integer): TElDBXTreeItem;
    function GetDBRootItem(Index: Integer): TElDBXTreeItem;
    function GetDBVisItem(Index: integer): TElDBXTreeItem;
  protected
  function Add(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; override;
    function AddChild(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; override;
    function AddChildFirst(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; override;
    function AddChildObject(Item: TElXTreeItem; Text: TLMDString; Ptr: Pointer): TElXTreeItem; override;
    function AddChildObjectFirst(Item: TElXTreeItem; Text: TLMDString; Ptr: Pointer): TElXTreeItem; override;
    function AddFirst(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; override;
    function AddItem(Parent: TElXTreeItem): TElXTreeItem;
    function AddLastItem(Parent: TElXTreeItem): TElXTreeItem;
    function AddObject(Item: TElXTreeItem; Text: TLMDString; Ptr: Pointer): TElXTreeItem; override;
    function AddObjectFirst(Item: TElXTreeItem; Text: TLMDString; Ptr: Pointer): TElXTreeItem; override;
    procedure Delete(Item: TElXTreeItem); override;
    procedure DeleteItem(Child: TElXTreeItem);
    function Insert(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; override;
    function InsertAfter(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem; override;
    function InsertAfterObject(Item: TElXTreeItem; Text: TLMDString; Ptr: Pointer): TElXTreeItem; override;
    function InsertItem(Index: integer; Parent: TElXTreeItem): TElXTreeItem;
    function InsertObject(Item: TElXTreeItem; Text: TLMDString; Ptr: Pointer): TElXTreeItem; override;
    procedure LoadFromFile(FileName: string);
    procedure LoadFromStream(Stream: TStream);
    procedure LoadFromStringList(Strings: TStrings);

  {$IFDEF LMD_UNICODE}
  procedure LoadFromWideStringList(Strings: TLMDWideStrings);
  {$ENDIF}
    procedure SetItem(Index: Integer; Value: TElXTreeItem);
  public
    procedure Assign(Source: TPersistent); override;
    function GetFirstNode: TElDBXTreeItem;
    property Item[Index: integer]: TElDBXTreeItem read GetDBItem; default;
    property ItemAsVis[Index: integer]: TElDBXTreeItem read GetDBVisItem;
    property RootItem[Index: Integer]: TElDBXTreeItem read GetDBRootItem;
  end;

{$HINTS ON}

// Collection for Styles

  TElXStylesDefsItem = class (TCollectionItem)
  protected
    FAllowEdit: Boolean;
    FBkColor: TColor;
    FBold: Boolean;
    FBorderStyle: TElItemBorderStyle;
    FCheckBox: string;
    FCheckBoxEnabled: Boolean;
    FColor: TColor;
    FDataField: String;
    FDataFields: TStringList;
    FHasColumn: Boolean;
    FDataLink: TDataLink;
    FDrawHLine: Boolean;
    FEnabled: Boolean;
    FForceButtons: Boolean;
    FWordWrap: Boolean;
    FHeight: Integer;
    FHidden: Boolean;
    FHint: string;
    FHintField: string;
    FHintIsHTML: Boolean;
    FImage: string;
    FImage2: string;
    FImageIndex: Integer;
    FImageIndex2: Integer;
    FImagesFromBase: Boolean;
    FIndentAdjust: Integer;
    FInDesign: Boolean;
    FIsHTML: Boolean;
    FItalic: Boolean;
    FMultiline: Boolean;
    FOwnerHeight: Boolean;
    FParentColors: Boolean;
    FParentStyle: Boolean;
    FPattern: TLMDString;
    FRowBkColor: TColor;
    FShowCheckBox: Boolean;
    FStImage: string;
    FStImage2: string;
    FStImageIndex: Integer;
    FStImageIndex2: Integer;
    FStrikedLineColor: TColor;
    FStrikedOutLine: Boolean;
    FStrikeout: Boolean;
    FStyleCaption: string;
    FSuppressButtons: Boolean;
    FSuppressLines: Boolean;
    FUnderlined: Boolean;
    FUseBkColor: Boolean;
    FUsePattern: Boolean;
    procedure DefineProperties(Filer: TFiler); override;
    function GetDataFields: TStringList;
    function GetDataSetName: string;
//    procedure ReadParentStyle(Reader: TReader);
    procedure SetAllowEdit(Value: Boolean);
    procedure SetBkColor(Value: TColor);
    procedure SetBold(Value: Boolean);
    procedure SetBorderStyle(Value: TElItemBorderStyle);
    procedure SetCheckBox(const Value: string);
    procedure SetCheckBoxEnabled(Value: Boolean);
    procedure SetColor(Value: TColor);
    procedure SetDataFields(Value: TStringList);
    procedure SetDrawHLine(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    procedure SetForceButtons(Value: Boolean);
    procedure SetHeight(Value: Integer);
    procedure SetHidden(Value: Boolean);
    procedure SetHint(const Value: string);
    procedure SetHintField(const Value: string);
    procedure SetHintIsHTML(Value: Boolean);
    procedure SetImage(const Value: string);
    procedure SetImage2(const Value: string);
    procedure SetImageIndex(Value: Integer);
    procedure SetImageIndex2(Value: Integer);
    procedure SetImagesFromBase(Value: Boolean);
    procedure SetIndentAdjust(Value: Integer);
    procedure SetIsHTML(Value: Boolean);
    procedure SetItalic(Value: Boolean);
    procedure SetMultiline(Value: Boolean);
    procedure SetOwnerHeight(Value: Boolean);
    procedure SetParentColors(Value: Boolean);
    procedure SetParentStyle(Value: Boolean);
    procedure SetPattern(Value: TLMDString);
    procedure SetRowBkColor(Value: TColor);
    procedure SetShowCheckBox(Value: Boolean);
    procedure SetStateImageIndex(Value: Integer);
    procedure SetStateImageIndex2(Value: Integer);
    procedure SetStImage(const Value: string);
    procedure SetStImage2(const Value: string);
    procedure SetStrikedLineColor(Value: TColor);
    procedure SetStrikedOutLine(Value: Boolean);
    procedure SetStrikeout(Value: Boolean);
    procedure SetStyleCaption(const Value: string);
    procedure SetSuppressButtons(Value: Boolean);
    procedure SetSuppressLines(Value: Boolean);
    procedure SetUnderlined(Value: Boolean);
    procedure SetUseBkColor(Value: Boolean);
    procedure SetUsePattern(Value: Boolean);
    procedure SetHasColumn(Value: Boolean);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property DataLink:TDataLink read FDataLink;
    property InDesign:Boolean read FInDesign;
    property DataField: String read FDataField;
    property DataSetName: string read GetDataSetName;
  published
    property AllowEdit: Boolean read FAllowEdit write SetAllowEdit;
    property BkColor: TColor read FBkColor write SetBkColor default clWindow;
    property Bold: Boolean read FBold write SetBold;
    property BorderStyle: TElItemBorderStyle read FBorderStyle write
            SetBorderStyle;
    property CheckBox: string read FCheckBox write SetCheckBox;
    property CheckBoxEnabled: Boolean read FCheckBoxEnabled write
            SetCheckBoxEnabled;
    property Color: TColor read FColor write SetColor default clWindowText;
    property DataFields: TStringList read GetDataFields write SetDataFields;
    property DrawHLine: Boolean read FDrawHLine write SetDrawHLine;
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property ForceButtons: Boolean read FForceButtons write SetForceButtons;
    property Height: Integer read FHeight write SetHeight;
    property Hidden: Boolean read FHidden write SetHidden;
    property Hint: string read FHint write SetHint;
    property HintField: string read FHintField write SetHintField;
    property HintIsHTML: Boolean read FHintIsHTML write SetHintIsHTML;
    property Image: string read FImage write SetImage;
    property Image2: string read FImage2 write SetImage2;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property ImageIndex2: Integer read FImageIndex2 write SetImageIndex2;
    property ImagesFromBase: Boolean read FImagesFromBase write
            SetImagesFromBase;
    property IndentAdjust: Integer read FIndentAdjust write SetIndentAdjust;
    property IsHTML: Boolean read FIsHTML write SetIsHTML;
    property Italic: Boolean read FItalic write SetItalic;
    property Multiline: Boolean read FMultiline write SetMultiline;
    property WordWrap: Boolean read FWordWrap write FWordWrap;
    property OwnerHeight: Boolean read FOwnerHeight write SetOwnerHeight;
    property ParentColors: Boolean read FParentColors write SetParentColors;
    property ParentFontStyle: Boolean read FParentStyle write SetParentStyle;
    property Pattern: TLMDString read FPattern write SetPattern;
    property RowBkColor: TColor read FRowBkColor write SetRowBkColor default clWindow;
    property ShowCheckBox: Boolean read FShowCheckBox write SetShowCheckBox default false;
    property StateImageIndex: Integer read FStImageIndex write
            SetStateImageIndex;
    property StateImageIndex2: Integer read FStImageIndex2 write
            SetStateImageIndex2;
    property StImage: string read FStImage write SetStImage;
    property StImage2: string read FStImage2 write SetStImage2;
    property StrikedLineColor: TColor read FStrikedLineColor write
            SetStrikedLineColor;
    property StrikedOutLine: Boolean read FStrikedOutLine write
            SetStrikedOutLine;
    property Strikeout: Boolean read FStrikeout write SetStrikeout;
    property StyleCaption: string read FStyleCaption write SetStyleCaption;
    property SuppressButtons: Boolean read FSuppressButtons write
            SetSuppressButtons;
    property SuppressLines: Boolean read FSuppressLines write SetSuppressLines;
    property Underlined: Boolean read FUnderlined write SetUnderlined;
    property UseBkColor: Boolean read FUseBkColor write SetUseBkColor;
    property UsePattern: Boolean read FUsePattern write SetUsePattern default
            False;
    property HasColumn: Boolean read FHasColumn Write SetHasColumn;
  end;

//  TElXStylesDefs

  TElXStylesDefs = class (TCollection)
  private
    FCanAppend: Boolean;
    FCustomElDBTree: TCustomElDBXTree;
    function GetItem(Index: Integer): TElXStylesDefsItem;
    procedure SetItem(Index: Integer; Value: TElXStylesDefsItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(ACustomElDBTree: TCustomElDBXTree; ItemClass:
            TCollectionItemClass);
    procedure Assign(Source: TPersistent); override;
    function Add: TElXStylesDefsItem;
    procedure Delete(Index: Integer);
    property Items[Index: Integer]: TElXStylesDefsItem read GetItem write
            SetItem; default;
    property Tree: TCustomElDBXTree read FCustomElDBTree;
  end;

// TDBTreeView
  TElDBXTreeView = class (TElXTreeView)
  public
    procedure DefineHRange; override;
  protected
  end;

//TCustomElDBXTree
  TCustomElDBXTree = class (TCustomElXTree)
  private
    FSorting: Boolean;
    FCustomDataEditing: Boolean;
    FCustomSectionNum: Integer;
    function GetDBDropTarget: TElDBXTreeItem;
    function GetDBSelected: TElDBXTreeItem;
    function GetDBTopItem: TElDBXTreeitem;
    function GetDBTrackItem: TElDBXTreeItem;
    procedure SetDBSelected(const Value: TElDBXTreeItem);
    procedure SetDBTopItem(const Value: TElDBXTreeitem);
    function ParsePattern(Pattern: TLMDString; ADataSet: TDataSet): TLMDString;
    function SizeToPixels(Value: Integer): integer;
    procedure RebuildOnDisignTime;
   {$IFDEF LMD_UNICODE}
    function GetWideStringText(Field: TField): WideString;
//   {$ELSE}
//    function GetWideStringText(Field: TField): String;
   {$ENDIF}
  protected
    FNoRebuildOnDataChange : Boolean;
    FChanging: Boolean;
    FCheckField: Boolean;
    FDataLink: TElXTreeDataLink;
    FDragItem: TElDBXTreeItem;
    FGlobalChange: Boolean;
    FInserting: Boolean;
//    FMaxLevelCount: Integer;
    FOnActivateLevel: TElXOnActivateLevel;
    FOnAfterBuildTree: TNotifyEvent;
    FOnBeforeBuildTree: TNotifyEvent;
    FOnCustomColumnDataNeed: TElXOnCustomColumnDataNeed;
    FOnItemChanged: TElXOnItemChangedEvent;
    FOnItemCreated: TElXOnItemCreated;
    FOnMyDrag: TEndDragEvent;
    FOnMyOver: TDragOverEvent;
    FOnMyStartDrag: TStartDragEvent;
    FSource: TElXRelDataSource;
    FStylesDefs: TElXStylesDefs;
    FTablRelName: TElTableName;
    FUnicodeMode: TElDBUnicodeMode;
    FDataTree: TElMDBTree;
    procedure DoItemChecked(Item: TElXTreeItem); override;
    function DataWidth: integer; virtual;
    function ColumnWidth(ASectionIndex: integer; Level: Integer): integer; virtual;
    procedure SetRightAlignedText(newValue: Boolean);override;
    function CreateView: TElXTreeView; override;
    function CreateItems: TElXTreeItems; override;
    procedure OnHeaderSectionClick(Sender: TElXCustomHeader; Section: TElXHeaderSection);override;
    procedure NewOnVirtualTextNeeded(Sender: TObject; Item: TElXTreeItem; SectionIndex: Integer; var Text: TLMDString);
    procedure NewTreeVirtualPropsNeeded(Sender: TObject;Item: TElXTreeItem; PropTypes: TElVirtPropTypes; Value: TElXTreeItemStaticDataEx);
    procedure NewVirtualStyleNeeded(Sender: TObject;Item: TElXTreeItem; SectionIndex: Integer; Style: TElXCellStyle);
    procedure NewVirtualHintNeeded(Sender: TObject; Item: TElXTreeItem; var Hint: TLMDString);
    procedure DataSetChanged;
    procedure DefineProperties(Filer: TFiler); override;
    procedure AfterEdit;
    function GetDBItems: TElDBXTreeItems;
    function GetItemFocused: TElDBXTreeItem;
    function GetSource: TElXRelDataSource;
    procedure KeyDownTransfer(Sender: TObject; var Key: Word; Shift :
            TShiftState); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
            override;
    procedure OnHeaderSectionChange(Sender: TElXCustomHeader; Section:
            TElXHeaderSection; Change: TSectionChangeMode); override;
    procedure SetItemFocused(Value: TElDBXTreeItem);
    procedure SetSource(Source: TElXRelDataSource); virtual;
    procedure SetStylesDefs(Value: TElXStylesDefs);
    procedure TriggerInplaceEditorNeeded(Item: TElXTreeItem; SectionIndex:
            Integer; SupposedFieldType: TElFieldType; var Editor:
            TElTreeInplaceEditor); override;
    procedure NavigateInDataSet(AItem: TElXTreeItem; ChangeTreeState: Boolean);
    procedure TriggerItemSelectedChangeEvent(AItem: TElXTreeItem); override;
    procedure TriggerLinkClickEvent(HRef: string; X, Y: integer); override;
    procedure CheckRootLevel;
    procedure TriggerSortBegin; override;
    procedure TriggerSortEnd; override;
    procedure InsertToRootDataSet;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function MeasureColumnWidth(ColumnNum: Integer; VisibleOnly: Boolean): Integer; override;
    procedure MeasureCell(Item: TElXTreeItem; ColumnNum: Integer; MaxWidth :
        Integer; var Size: TPoint); override;
    procedure Refresh; virtual;
    procedure Assign(Source: TPersistent); override;
    function GetItemAt(X, Y: Integer; var ItemPart: TSTXItemPart; var HitColumn:
            integer): TElDBXTreeItem;   reintroduce; virtual;
    function GetItemAtY(Y: integer): TElDBXTreeItem;   reintroduce; virtual;
    function GetNextSelected(Prev: TElXTreeItem): TElDBXTreeItem;   reintroduce;virtual;
    function GetNodeAt(X, Y: integer): TElDBXTreeItem;
//    procedure RebuildItemChilds(AElDBTreeItem: TElDBXTreeItem);
    procedure RebuildTree(KeepCurrentID: Boolean); virtual;
    property Color;
    property BackGroundColor;
    property TextColor;
    property LineHeight;
    property DataChange: Boolean read FChanging write FChanging;
    property DropTarget: TElDBXTreeItem read GetDBDropTarget;
    property ItemFocused: TElDBXTreeItem read GetItemFocused write
            SetItemFocused;
    property Items: TElDBXTreeItems read GetDBItems;
    property Selected: TElDBXTreeItem read GetDBSelected write SetDBSelected;
    property TopItem: TElDBXTreeitem read GetDBTopItem write SetDBTopItem;
    property TrackItem: TElDBXTreeItem read GetDBTrackItem;
    property UseXPThemes;
  published
    property NoRebuildOnDataChange : Boolean read FNoRebuildOnDataChange write FNoRebuildOnDataChange default false;
    property AlphaForImages;
    property DataSource: TElXRelDataSource read GetSource write SetSource;
    property Images;
//    property MaxLevelCount: Integer read FMaxLevelCount write FMaxLevelCount;

    property OnActivateLevel: TElXOnActivateLevel read FOnActivateLevel write
            FOnActivateLevel;

    property OnAfterBuildTree: TNotifyEvent read FOnAfterBuildTree write
            FOnAfterBuildTree;
    property OnBeforeBuildTree: TNotifyEvent read FOnBeforeBuildTree write
            FOnBeforeBuildTree;
    property OnCustomColumnDataNeed: TElXOnCustomColumnDataNeed read
            FOnCustomColumnDataNeed write FOnCustomColumnDataNeed;
    property OnItemChanged: TElXOnItemChangedEvent read FOnItemChanged write
            FOnItemChanged;
    property OnItemCreated: TElXOnItemCreated read FOnItemCreated write
            FOnItemCreated;
    property StylesDefs: TElXStylesDefs read FStylesDefs write SetStylesDefs;
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write FUnicodeMode
            default umFieldType;
    property ShowCheckBoxes;
  end;

  TElDBXTree = class (TCustomElDBXTree)
  published
    property UseThemeForSelection;
    property FixedTopRowNum;
    property FixedBottomRowNum;
    property FixedColNum;
    property GutterWidth;
    property ActiveBorderType;
    property AdjustMultilineHeight;
    property Align;
    property AlphaForImages;
    property AlphaForImages2;
    property AlwaysKeepFocus;
    property AlwaysKeepSelection;
    property Anchors;
    property AutoCollapse;
    property AutoExpand;
    property AutoLineHeight;
    property AutoLineVisibleOnly;
    property AutoLookup;
    property AutoResizeColumns;
    property Background;
    property BackgroundType;
    property BarStyle;
    property BarStyleVerticalLines;
    property BarStyleNotRaise;
    property BevelKind;
    property BackGroundColor;
    //    property BkColor;
    property BorderSides;
    property BorderStyle;
    property ChangeDelay;
    property ChangeStateImage;
    property CheckBoxFlat;
    property CheckBoxGlyph;
    property CheckBoxSize;
    property Color;
    property Constraints;
    property Ctl3D;
    property Cursor;
    property CustomCheckboxes;
    property CustomPlusMinus;
    property DataSource;
    property DblClickMode;
    property DefaultSectionWidth;
    property DeselectChildrenOnCollapse;
    property DockOrientation;
    property DoInplaceEdit;
    property DoubleBuffered;
    property DragAllowed;
    property DragCursor;
    property DragExpandDelay;
    property DraggableSections;
    property DragImageMode;
    property DragKind;
    property DragRectAcceptColor;
    property DragRectDenyColor;
    property DragScrollInterval;
    property DragTrgDrawMode;
    property DragType;
    property DrawFocusRect;
    property Enabled;
    property ExpandOnDragOver;
    property ExplorerEditMode;
    property FilteredVisibility;
    property Flat;
    property FlatFocusedScrollbars;
    property Floating;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property Font stored true;
    property ForcedScrollBars;
    property FullRowSelect;
    property GradientEndColor;
    property GradientStartColor;
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

    property HeaderImageForm;
    property ImageForm;
    property HideFocusRect;
    property HideHintOnMove;
    property HideHintOnTimer;
    property HideHorzScrollBar;
    property HideSelectColor;
    property HideSelection;
    property HideSelectTextColor;
    property HideVertScrollBar;
    property Hint;
    property HintType;
    property HorizontalLines;
    property HorzDivLinesColor;
    property HorzScrollBarStyles;
    property HorzScrollTracking;
    property IgnoreEnabled;
    property Images;
    property Images2;
    property InactiveBorderType;
    property IncrementalSearch;
    property IncrementalSearchScope;
    property ItemIndent;
    property KeepSelectionWithinLevel;
    property LeafPicture;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;
    property LineHeight;
    property LineHintColor;
    property LineHintMode default shmLong;
    property LineHintTimeout;
    property LineHintType;
    property LinesColor;
    property LinesStyle;

    property LinkColor;
    property LinkCursor;
    property LinkStyle;
    property LockHeaderHeight;
    property MainTreeColumn;
//    property MaxLevelCount;
    property MinusPicture;
    property MouseFrameSelect;
    property MoveColumnOnDrag;
    property MoveFocusOnCollapse;
    property MultiSelect;
    property MultiSelectLevel;
    property OnAfterBuildTree;
    property OnBeforeBuildTree;
    property OnAfterSelectionChange;
    property OnCellStyleLoad;
    property OnCellStyleSave;
    property OnCellDeletion;
    property OnChanging;
    property OnClick;

    property OnCompareItems;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDragTargetChange;

    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnHorzScrollDrawPart;
    property OnHorzScrollHintNeeded;
    property OnHotTrack;
    property OnHTMLImageNeeded;
    property OnInplaceEditorNeeded;
    property OnItemChange;
    property OnCellChange;
    property OnItemChecked;
    property OnItemCollapse;
    property OnItemCollapsing;
    property OnItemDraw;
    property OnItemExpand;
    property OnItemExpanding;
    property OnItemFocused;
    property OnItemPicDraw;
    property OnItemPicDraw2;
    property OnItemPostDraw;
    property OnItemPreDraw;
    property OnItemCreated;
    property OnItemDeletion;
    property OnItemSave;
    property OnItemSelectedChange;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnLinkClick;
    property OnMeasureItemPart;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    property OnScroll;
    property OnShowLineHint;
    property OnSortBegin;
    property OnSortEnd;
    property OnStartDock;
    property OnStartDrag;

    property OnVertScrollDrawPart;
    property OnVertScrollHintNeeded;
//    property OnVirtualHintNeeded;
//    property OnVirtualStyleNeeded;
//    property OnVirtualTextNeeded;
//    property OnVirtualValueNeeded;
    property OwnerDrawByColumn default true;
    property OwnerDrawMask;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PathSeparator;
    property PlusMinusTransparent;
    property PlusPicture;
    property PopupMenu;
    property RadioButtonGlyph;
    property RightAlignedText;
    property RightAlignedView;
    property RightClickSelect;
    property RowHotTrack;
    property RowSelect;
    property ScrollbarOpposite;
    property SelectColumn;
    property SelectionMode;
    property ShowButtons;
    property ShowCheckBoxes;
    property ShowColumns;
    property ShowEmptyImages;
    property ShowEmptyImages2;
    property ShowHint;
    property ShowImages;
    property ShowLeafButton;
    property ShowLines;
    property ShowRoot;
    property ShowRootButtons;
    property SortDir;
    property SortMode;
    property SortSection;
    property SortType;
    property SortUseCase;
    property StickyHeaderSections;
    property Storage;
    property StoragePath;
    property StripedEvenColor;
    property StripedItems;
    property StripedOddColor;
    property StylesDefs;
    property TabOrder;
    property TabStop;
    property TextColor;
    property TrackColor;
//    property Tracking;
    property UnderlineTracked;
    property UseCustomScrollBars;
    property UseSystemHintColors;
    property ThemeMode;
    property ThemeGlobalMode;
    property VertDivLinesColor;
    property VerticalLines;
    property VerticalLinesLong;
    property VertScrollBarStyles;
    property VertScrollTracking;
    property Visible;
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
  end;

implementation
uses
  ElDBTree, ElDBTreeEditors
  ;

type
  TMTreeCellData = class(TObject)
  public
    FCellText: TLMDString;
    FCellPicture : TBitmap;
    FCellType: TElFieldType;
    FHeight: Integer;
  end;

  TElMDataDataLink = class;

  TMData = class(TPersistent)
  protected
    procedure SetCellTypeOnFieldName(Value: string; MDataSet : TDataSet);
  public
    FDataLink: TElMDataDataLink;
    FCells  : TList;
    FTreeOwner: TElDBXTreeItem;
    FOwner: TElMTreeItem;
    FTree: TElMDBTree;
    FCellType: TElFieldType;
    FHint: TLMDString;
    FBookmark: TBookmark;
    FDataField: string;
    FEditingField: string;
    FDetailField: string;
    FMasterField: string;
    FMasterValue: TLMDString;
    FText: TLMDString;
    FMarker: Boolean;
    FHasPicture: Boolean;
    FCheckBoxField: string;
    FCheckBoxFromBase: Boolean;
    FImagesFromBase: Boolean;
    FImageIndexField :string;
    FImageIndex2Field :string;
    FStImageIndexField :string;
    FStImageIndex2Field :string;
    FImageIndex :integer;
    FStateImageIndex :integer;
    FImageIndex2 :integer;
    FStateImageIndex2 :integer;
    FRelIndex: Integer;
    FCheckBoxState: TCheckBoxState;
    FPicture: TBitmap;
    FOwnerHeight: boolean;
    FHeight: integer;
    constructor Create(AOwner: TElDBXTreeItem);
    destructor Destroy; override;
    procedure GetDataFromBase(MDataSet: TDataSet; RelNum: Integer);
    procedure FillColumnData(MDataSet: TDataSet; RelNum: Integer);
    function GetValue(ValName: TValName): variant;
    procedure SetEditingField(Value: string);
  end;

  TElMDataDataLink = class(TDataLink)
  private
    FMData: TMData;
  protected
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create(AMData: TMData);
  end;

var FMemoBitmap, FMemoNullBitmap : TBitmap;

{type
  TElXDBDragObject = class (TDragControlObject)
    function GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor; override;
  end;
}
{
******************************* TElXDBDragObject ********************************
}
{function TElXDBDragObject.GetDragCursor(Accepted: Boolean; X, Y: Integer):
        TCursor;
begin
  if Control is TElXTree then
  begin
    if ((Control as TElXTree).GetItemAtY(Y) <> nil) or (Accepted) then
      Result := (Control as TElXTree).DragCursor
    else
      Result := crNoDrop;
  end
  else
    Result := inherited GetDragCursor(Accepted, X, Y);
end;
}
// TElDBXTreeItem

{
******************************** TElDBXTreeItem *********************************
}
constructor TElDBXTreeItem.Create(AOwner: TCustomELXTree);
begin
  inherited Create(AOwner);
  FMItem := nil;
//  UseStyles := True;
end;

destructor TElDBXTreeItem.Destroy;
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner) and Assigned(Owner.FDataTree) then
  begin
    mitem := FMItem;
    if Assigned(mitem) then
    begin
      TMData(mitem.Data).Free;
      owner.FDataTree.DeleteItem(Mitem);
    end;
  end;
  if Assigned(FMItem) then
    FMItem := nil;
  inherited Destroy;
end;

procedure TElDBXTreeItem.MoveTo(NewParent: TElXTreeItem);
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner) and Assigned(Owner.FDataTree) then
  begin
    mitem := FMItem;
    if Assigned(mitem) then
    begin
      if (newparent <> Owner.Items.Root) then
        mitem.MoveTo(TElDBXTreeItem(newparent).FMItem)
      else
        mitem.MoveTo(Owner.FDataTree.Root);
    end;
  end;
  inherited;
end;

procedure TElDBXTreeItem.MoveToIns(NewParent: TElXTreeItem;
  AnIndex: Integer);
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner) and Assigned(Owner.FDataTree) then
  begin
    mitem := FMItem;
    if Assigned(mitem) then
    begin
      if (newparent <> Owner.Items.Root) then
        mitem.MoveToIns(TElDBXTreeItem(newparent).FMItem, AnIndex)
      else
        mitem.MoveToIns(Owner.FDataTree.Root, AnIndex);
    end;
  end;
  inherited;
end;

procedure TElDBXTreeItem.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

procedure TElDBXTreeItem.EndEdit(ByCancel: boolean);
begin
  inherited EndEdit(ByCancel);
end;

procedure TElDBXTreeItem.InsertChildToDataSet;
var
  MDataSet: TDataSet;
  DataSetOptions :TElXDataSetOptions;
  i : integer;
begin
  if (MasterField <>'') then
  begin
    i := Owner.DataSource.GetRelNoOnLevel(Level+1,DataSetOptions);
    MDataSet := Owner.DataSource.GetSetOnLevel(Level+1,DataSetOptions);
    if (elIsCaption in DataSetOptions) then
      MDataSet := Owner.DataSource.GetSetOnLevel(Level+2,DataSetOptions);
    if Assigned(MDataSet) then
    begin
      MDataSet.Insert;
      MDataSet.FieldByName(Owner.DataSource.Relations[i-1].DetailField).AsVariant := MasterValue;
      MDataSet.Post;
    end;
  end;
end;

procedure TElDBXTreeItem.InsertSiblingToDataSet;
var
  MDataSet: TDataSet;
  DataSetOptions :TElXDataSetOptions;
begin
  MDataSet := Owner.DataSource.GetSetOnLevel(Level,DataSetOptions);
  if Assigned(MDataSet) then
  begin
    MDataSet.Insert;
    if Assigned(parent) then
    begin
      MDataSet.FieldByName(Parent.MasterField).AsVariant := PArent.MasterValue;
    end;
    MDataSet.Post;
  end;
end;

procedure TElDBXTreeItem.DeleteFromDataSet;
var
  mitem: TElMTreeItem;
  MDataSet: TDataSet;
  DataSetOptions :TElXDataSetOptions;
begin
  MDataSet := Owner.DataSource.GetSetOnLevel(Level,DataSetOptions);
  if Assigned(Owner.FDataTree) then
  begin
//    mitem := Owner.FDataTree.Item[AbsoluteIndex];
    mitem := FMItem;

    if Assigned(mitem) then
    begin
      if (Assigned(MDataSet)) and (MDataSet.Active) and (Assigned(TMData(mitem.Data).FBookmark)) then
      begin
        if (not (elDenyLookSetPosition in DataSetOptions)) then
        begin
          MDataSet.GotoBookmark(TMData(mitem.Data).FBookmark);
          MDataSet.Delete;
//          Owner.Refresh;
        end
        else
          raise EOnDeleteFromDenyDataSet.Create(SDeleteFromDenyDataSet);
      end;
    end
    else
      raise EOnErrorInMTree.Create(SErrorInMTree);
  end;
end;

procedure TElDBXTreeItem.Delete;
begin
  inherited Delete;
end;

procedure TElDBXTreeItem.CheckActualChildrens;
var
  j{, k, i, l, ck}: integer;
//  c: Boolean;
//  mitem, mitem1: TElMTreeItem;
//  data: TMData;
//  it: TElDBXTreeItem;
begin
//  c := Owner.FChanging;
  j := Owner.DataSource.RecCountOnLevel(Level + 1,MasterValue);
  if (j > 0) then
  begin
    Owner.Items.AddChild(Self,'');
  end
  else
    Self.DeleteChild;

//  if Assigned(THackELXTreeItem(Self).FChildren) then
//    ck := THackELXTreeItem(Self).FChildren.Count
//  else
//    ck := 0;
//  if (j <> ck) then
//  begin
//    if ck > 0 then
//    begin
////      mitem := owner.FDataTree.Item[self.AbsoluteIndex];
//    mitem := FMItem;
//      for k := 0 to (mitem.List.Count - 1) do
//      begin
//        TMData((TElMTreeItem(mitem.List[k])).Data).FBookmark := nil;
//      end;
//    end;
//    if (j < ck) then
//    begin
//      k := ck;
//      for i := j to (k-1) do
//      begin
//        Children[j].Delete;
//      end;
//    end
//    else
//    begin
//      if (j > 0) then
//      begin
//        k := Owner.Items.Count;
//        j := j - ck;
//        Owner.Items.AllocateStorage(k + j);
//        AllocateStorage(j + k);
//        mitem := nil;
//        if Assigned(owner.fdataTree) then
////          mitem := owner.FDataTree.Item[self.AbsoluteIndex];
//          mitem := FMItem;
//        for l := 0 to j - 1 do
//        begin
//          it := Owner.Items.AddChild(Self,'') ;
//          if Assigned(owner.fdataTree) then
//          begin
//            Data := TMData.Create(TElDBXTreeItem(it));
//            mitem1 := Owner.FDataTree.AddItem(mitem, Data);
//            Data.FOwner := mitem1;
//            Data.FTree := Owner.FDataTree;
//            data.FTreeOwner := TElDBXTreeItem(it);
//            it.FMItem := Data;
//          end;
//        end;
//      end;
//    end;
//  end;
//  Owner.FChanging := c;
end;

procedure TElDBXTreeItem.DeleteChild;
var
  ritem: TElDBXTreeItem;
  c: Boolean;
begin
  c := Owner.FChanging;
  Owner.FChanging := True;
  ritem := GetFirstChild;
  while Assigned(ritem) do
  begin
    if ritem.ChildrenCount = 0 then ritem.Delete
    else begin
      ritem.DeleteChild;
      ritem.Delete;
    end;
    ritem := GetFirstChild;
  end;
  Owner.FChanging := c;
end;

function TElDBXTreeItem.GetAncestor: TElDBXTreeItem;
var
  i: TElXTreeItem;
begin
  i := inherited GetAncestor;
  if i <> nil then Result := TElDBXTreeItem(i)
  else Result := nil;
end;

function TElDBXTreeItem.GetCheckBoxField: string;
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner.FDataTree) then
  begin
//    mitem := Owner.FDataTree.Item[AbsoluteIndex];
    mitem := FMItem;
    if Assigned(mitem) then
      Result := TMData(mitem.Data).FCheckBoxField
    else
      raise EOnErrorInMTree.Create(SErrorInMTree);
  end
  else
    Result := FCheckBoxField;
end;

function TElDBXTreeItem.GetCheckBoxFromBase: Boolean;
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner.FDataTree) then
  begin
//    mitem := Owner.FDataTree.Item[AbsoluteIndex];
    mitem := FMItem;
    if Assigned(mitem) then
      Result := TMData(mitem.Data).FCheckBoxFromBase
    else
      raise EOnErrorInMTree.Create(SErrorInMTree);
  end
  else
    Result := FCheckBoxFromBase;
end;

function TElDBXTreeItem.GetDataField: string;
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner.FDataTree) then
  begin
//    mitem := Owner.FDataTree.Item[AbsoluteIndex];
    mitem := FMItem;
    if Assigned(mitem) then
      Result := TMData(mitem.Data).FDataField
    else
      raise EOnErrorInMTree.Create(SErrorInMTree);
  end
  else
    Result := FDataField;
end;

function TElDBXTreeItem.GetDetailField: string;
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner.FDataTree) then
  begin
//    mitem := Owner.FDataTree.Item[AbsoluteIndex];
    mitem := FMItem;
    if Assigned(mitem) then
      Result := TMData(mitem.Data).FDetailField
    else
      raise EOnErrorInMTree.Create(SErrorInMTree);
  end
  else
    Result := FDetailField;
end;

function TElDBXTreeItem.GetBookmark: TBookmark;
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner.FDataTree) then
  begin
//    mitem := Owner.FDataTree.Item[AbsoluteIndex];
    mitem := FMItem;
    if Assigned(mitem) then
      Result := TMData(mitem.Data).FBookmark
    else
      raise EOnErrorInMTree.Create(SErrorInMTree);
  end
  else
    Result := FBookmark;
end;

function TElDBXTreeItem.GetImage2IndexField: string;
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner.FDataTree) then
  begin
//    mitem := Owner.FDataTree.Item[AbsoluteIndex];
    mitem := FMItem;
    if Assigned(mitem) then
      Result := TMData(mitem.Data).FImageIndex2Field
    else
      raise EOnErrorInMTree.Create(SErrorInMTree);
  end
  else
    Result := FImage2Index;
end;

function TElDBXTreeItem.GetImageIndexField: string;
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner.FDataTree) then
  begin
//    mitem := Owner.FDataTree.Item[AbsoluteIndex];
    mitem := FMItem;
    if Assigned(mitem) then
      Result := TMData(mitem.Data).FImageIndexField
    else
      raise EOnErrorInMTree.Create(SErrorInMTree);
  end
  else
    Result := FImageIndex;
end;

function TElDBXTreeItem.GetImagesFromBase: Boolean;
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner.FDataTree) then
  begin
//    mitem := Owner.FDataTree.Item[AbsoluteIndex];
    mitem := FMItem;
    if Assigned(mitem) then
      Result := TMData(mitem.Data).FImagesFromBase
    else
      raise EOnErrorInMTree.Create(SErrorInMTree);
  end
  else
    Result := FImagesFromBase;
end;

function TElDBXTreeItem.GetMasterField: string;
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner.FDataTree) then
  begin
//    mitem := Owner.FDataTree.Item[AbsoluteIndex];
    mitem := FMItem;
    if Assigned(mitem) then
      Result := TMData(mitem.Data).FMasterField
    else
      raise EOnErrorInMTree.Create(SErrorInMTree);
  end
  else
    Result := FMasterField;
end;

function TElDBXTreeItem.GetEditingField: string;
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner.FDataTree) then
  begin
//    mitem := Owner.FDataTree.Item[AbsoluteIndex];
    mitem := FMItem;
    if Assigned(mitem) then
      Result := TMData(mitem.Data).FEditingField
    else
      raise EOnErrorInMTree.Create(SErrorInMTree);
  end
  else
    Result := '';
end;

procedure TElDBXTreeItem.SetEditingField(Value: string);
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner.FDataTree) then
  begin
//    mitem := Owner.FDataTree.Item[AbsoluteIndex];
    mitem := FMItem;
    if Assigned(mitem) then
      TMData(mitem.Data).SetEditingField(Value)
    else
      raise EOnErrorInMTree.Create(SErrorInMTree);
  end;
end;

function TElDBXTreeItem.GetMasterValue: TLMDString;
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner.FDataTree) then
  begin
//    mitem := Owner.FDataTree.Item[AbsoluteIndex];
    mitem := FMItem;
    if Assigned(mitem) then
      Result := TMData(mitem.Data).FMasterValue
    else
      raise EOnErrorInMTree.Create(SErrorInMTree);
  end
  else
    Result := FMasterValue;
end;

function TElDBXTreeItem.GetRelIndex: integer;
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner.FDataTree) then
  begin
//    mitem := Owner.FDataTree.Item[AbsoluteIndex];
    mitem := FMItem;
    if Assigned(mitem) then
      Result := TMData(mitem.Data).FRelIndex
    else
      raise EOnErrorInMTree.Create(SErrorInMTree);
  end
  else
    Result := FRelIndex;
end;

function TElDBXTreeItem.GetStateImage2IndexField: string;
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner.FDataTree) then
  begin
//    mitem := Owner.FDataTree.Item[AbsoluteIndex];
    mitem := FMItem;
    if Assigned(mitem) then
      Result := TMData(mitem.Data).FStImageIndex2Field
    else
      raise EOnErrorInMTree.Create(SErrorInMTree);
  end
  else
    Result := FStImage2Index;
end;

function TElDBXTreeItem.GetStateImageIndexField: string;
var
  mitem: TElMTreeItem;
begin
  if Assigned(Owner.FDataTree) then
  begin
//    mitem := Owner.FDataTree.Item[AbsoluteIndex];
    mitem := FMItem;
    if Assigned(mitem) then
      Result := TMData(mitem.Data).FStImageIndexField
    else
      raise EOnErrorInMTree.Create(SErrorInMTree);
  end
  else
    Result := FStImageIndex;
end;

function TElDBXTreeItem.GetChildByIndex(index: integer): TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetChildByIndex(index));
end;

function TElDBXTreeItem.GetFirstChild: TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetFirstChild);
end;

function TElDBXTreeItem.GetFirstSibling: TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetFirstSibling);
end;

function TElDBXTreeItem.GetFirstVisibleChild: TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetFirstVisibleChild);
end;

function TElDBXTreeItem.GetItems(Index: integer): TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetItems(Index));
end;

function TElDBXTreeItem.GetLastChild: TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetLastChild);
end;

function TElDBXTreeItem.GetLastSibling: TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetLastSibling);
end;

function TElDBXTreeItem.GetLastSubItem: TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetLastSubItem);
end;

function TElDBXTreeItem.GetNext: TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetNext);
end;

function TElDBXTreeItem.GetNextChild(Child: TElDBXTreeItem): TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetNextChild(Child));
end;

function TElDBXTreeItem.GetNextSibling: TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetNextSibling);
end;

function TElDBXTreeItem.GetNextVisible: TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetNextVisible);
end;

function TElDBXTreeItem.GetOwner: TCustomElDBXTree;
begin
  Result := TCustomElDBXTree(FOwner);
end;

function TElDBXTreeItem.GetParent: TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetParent);
end;

function TElDBXTreeItem.GetPrev: TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetPrev);
end;

function TElDBXTreeItem.GetPrevChild(Child: TElDBXTreeItem): TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetPrevChild(Child));
end;

function TElDBXTreeItem.GetPrevSibling: TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetPrevSibling);
end;

function TElDBXTreeItem.GetPrevVisible: TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetPrevVisible);
end;

function TElDBXTreeItem.GetText: TLMDString;
begin
  Result := inherited GetText;
end;

function TElDBXTreeItem.GetDataSource: TDataSource;
begin
  if Assigned(Bookmark) then
  begin
    if RelIndex > 0 then
      Result := Owner.DataSource.Relations[RelIndex - 1].GetDetailDataSource
    else
      Result := Owner.DataSource.GetRootDataSource;
  end
  else
    Result := nil;
end;

procedure TElDBXTreeItem.SetStyle;
begin
  if Owner.StylesDefs[RelIndex].FInDesign then exit;
//  ParentFontStyle := Owner.StylesDefs[RelIndex].ParentFontStyle;
  if (csDesigning in Owner.ComponentState) then
  begin
    {ParentColors := Owner.StylesDefs[RelIndex].ParentColors;
    if not Owner.StylesDefs[RelIndex].ParentColors then
    begin
      Color := Owner.StylesDefs[RelIndex].Color;
      BkColor := Owner.StylesDefs[RelIndex].BkColor;
      UseBkColor := Owner.StylesDefs[RelIndex].UseBkColor;
      RowBkColor := Owner.StylesDefs[RelIndex].RowBkColor;
    end;
    if not Owner.StylesDefs[FRelIndex].ParentFontStyle then
    begin
      Italic := Owner.StylesDefs[RelIndex].Italic;
      Underlined := Owner.StylesDefs[RelIndex].Underlined;
      Bold := Owner.StylesDefs[RelIndex].Bold;
      StrikeOut := Owner.StylesDefs[RelIndex].Strikeout;
    end;}
    FCheckBoxField := Owner.StylesDefs[RelIndex].CheckBox;
  end;
{  StrikedOutLine := Owner.StylesDefs[RelIndex].StrikedOutLine;
  if StrikedOutLine then
    StrikedLineColor := Owner.StylesDefs[RelIndex].StrikedLineColor;
}
  ForceButtons := Owner.StylesDefs[RelIndex].ForceButtons;
  if not Owner.StylesDefs[RelIndex].ImagesFromBase then
  begin
    ImagesFromBase := False;
    ImageIndex := Owner.StylesDefs[RelIndex].ImageIndex;
    StateImageIndex := Owner.StylesDefs[RelIndex].StateImageIndex;
    ImageIndex2 := Owner.StylesDefs[RelIndex].ImageIndex2;
    StateImageIndex2 := Owner.StylesDefs[RelIndex].StateImageIndex2;
  end
  else
  begin
    ImagesFromBase := True;
    ImageIndexField := Owner.StylesDefs[RelIndex].Image;
    StateImageIndexField := Owner.StylesDefs[RelIndex].StImage;
    Image2IndexField := Owner.StylesDefs[RelIndex].Image2;
    StateImage2IndexField := Owner.StylesDefs[RelIndex].StImage2;
  end;

  HintIsHTML := Owner.StylesDefs[RelIndex].HintIsHTML;

  if Owner.StylesDefs[RelIndex].CheckBox <> '' then
  begin
    CheckBoxFromBase := True;
    CheckBoxEnabled := Owner.StylesDefs[RelIndex].CheckBoxEnabled;
    ShowCheckBox := Owner.StylesDefs[RelIndex].ShowCheckBox;
  end
  else
  begin
    CheckBoxFromBase := False;
//    if CheckBoxState = cbGrayed then
//      CheckBoxEnabled := False
//    else
    CheckBoxEnabled := Owner.StylesDefs[RelIndex].CheckBoxEnabled;
    ShowCheckBox := Owner.StylesDefs[RelIndex].ShowCheckBox;
  end;

  Hidden := Owner.StylesDefs[RelIndex].Hidden;

  Enabled := Owner.StylesDefs[RelIndex].Enabled;
  IsHTML := Owner.StylesDefs[RelIndex].IsHTML;
  if not FHasPicture then
    OwnerHeight := Owner.StylesDefs[RelIndex].OwnerHeight;
  if (not OwnerHeight) and (Owner.StylesDefs[RelIndex].FHeight > 0) then
    Height := Owner.StylesDefs[RelIndex].FHeight;

  Multiline := Owner.StylesDefs[RelIndex].Multiline;
  WordWrap := Owner.StylesDefs[RelIndex].WordWrap;
  DrawHLine := Owner.StylesDefs[RelIndex].DrawHLine;
  AllowEdit := Owner.StylesDefs[RelIndex].AllowEdit;
  SuppressButtons := Owner.StylesDefs[RelIndex].SuppressButtons;
  SuppressLines := Owner.StylesDefs[RelIndex].SuppressLines;

  if Owner.StylesDefs[RelIndex].IndentAdjust <> 0 then
    IndentAdjust := Owner.StylesDefs[RelIndex].IndentAdjust
  else
    IndentAdjust := 0;
end;

procedure TElDBXTreeItem.SetText(Value: TLMDString);
begin
  inherited SetText(Value);
end;

// Collection for Styles

{
****************************** TElXStylesDefsItem *******************************
}
constructor TElXStylesDefsItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FDataLink := TDataLink.Create;
  FDataLink.DataSource := nil;
  FDataFields := TStringList.Create;
  FOwnerHeight := True;
  FParentColors := True;
//  FParentStyle := True;
  FInDesign := true;
  FEnabled := True;
  FImagesFromBase := False;
  FImageIndex := -1;
  FImageIndex2 := -1;
  FStImageIndex := -1;
  FStImageIndex2 := -1;
  FAllowEdit := True;
  FDrawHLine := True;
  SetAllowEdit(True);
  SetEnabled(True);

  FColor := (Collection as TElXStylesDefs).FCustomElDBTree.TextColor;
  FBkColor := (Collection as TElXStylesDefs).FCustomElDBTree.BackGroundColor;
  FRowBkColor := (Collection as TElXStylesDefs).FCustomElDBTree.BackGroundColor;

  FShowCheckBox := (Collection as TElXStylesDefs).FCustomElDBTree.ShowCheckboxes;
  if Assigned((Collection as TElXStylesDefs).FCustomElDBTree.DataSource) then
  begin
    if Self.Index = 0 then
    begin
      Self.FDataLink.DataSource := (Collection as TElXStylesDefs).FCustomElDBTree.DataSource.GetRootDataSource;
      Self.FDataField := (Collection as TElXStylesDefs).FCustomElDBTree.DataSource.RootDataField;
      Self.FInDesign := false;
    end
    else
    begin
      Self.FDataLink.DataSource := (Collection as TElXStylesDefs).FCustomElDBTree.DataSource.Relations[Self.Index - 1].GetDetailDataSource;
      Self.FDataField := (Collection as TElXStylesDefs).FCustomElDBTree.DataSource.Relations[Self.index - 1].DetailDisplayField;
    end;
  end;
end;

destructor TElXStylesDefsItem.Destroy;
begin
  FDataFields.Free;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TElXStylesDefsItem.Assign(Source: TPersistent);
begin
  if Source is TElXStylesDefsItem then
    with Source as TElXStylesDefsItem do
    begin
      Self.FDataField := FDataField;
      Self.FAllowEdit := FAllowEdit;
      Self.FBkColor := FBkColor;
      Self.FBold := FBold;
      Self.FCheckBox := FCheckBox;
      Self.FBorderStyle := FBorderStyle;
      Self.FCheckBoxEnabled := FCheckBoxEnabled;
      Self.FColor := FColor;
      Self.FDataField := FDataField;
      Self.FHasColumn := FHasColumn;
      Self.FDrawHLine := FDrawHLine;
      Self.FEnabled := FEnabled;
      Self.FForceButtons := FForceButtons;
      Self.FHeight := FHeight;
      Self.FHidden := FHidden;
      Self.FHint := FHint;
      Self.FHintField := FHintField;
      Self.FHintIsHTML := FHintIsHTML;
      Self.FImage := FImage;
      Self.FImage2 := FImage2;
      Self.FImageIndex := FImageIndex;
      Self.FImageIndex2 := FImageIndex2;
      Self.FImagesFromBase := FImagesFromBase;
      Self.FIndentAdjust := FIndentAdjust;
      Self.FInDesign := FInDesign;
      Self.FIsHTML := FIsHTML;
      Self.FItalic := FItalic;
      Self.FMultiline := FMultiline;
      Self.FOwnerHeight := FOwnerHeight;
      Self.FParentColors := FParentColors;
//      Self.FParentStyle := FParentStyle;
      Self.Pattern := Pattern;
      Self.FRowBkColor := FRowBkColor;
      Self.FShowCheckBox := FShowCheckBox;
      Self.FStImage := FStImage;
      Self.FStImage2 := FStImage2;
      Self.FStImageIndex := FStImageIndex;
      Self.FStImageIndex2 := FStImageIndex2;
      Self.FStrikedLineColor := FStrikedLineColor;
      Self.FStrikedOutLine := FStrikedOutLine;
      Self.FStrikeout := FStrikeout;
      Self.FStyleCaption := FStyleCaption;
      Self.FSuppressButtons := FSuppressButtons;
      Self.FSuppressLines := FSuppressLines;
      Self.FUnderlined := FUnderlined;
      Self.FUseBkColor := FUseBkColor;
      Self.UsePattern := UsePattern;
      if Assigned(FDataLink.DataSource) then
        Self.FDataLink.DataSource := FDataLink.DataSource;
      Self.FDataFields.Assign(DataFields);
    end
  else
    inherited;
end;

procedure TElXStylesDefsItem.DefineProperties(Filer: TFiler);
begin
  inherited;
//  Filer.DefineProperty('ParentStyle', ReadParentStyle, nil, false);
end;

function TElXStylesDefsItem.GetDataFields: TStringList;
begin
  Result := FDataFields;
end;

function TElXStylesDefsItem.GetDataSetName: string;
begin
  if FDataLink.DataSet <> nil then Result := FDataLink.DataSet.Name;
end;

//procedure TElXStylesDefsItem.ReadParentStyle(Reader: TReader);
//begin
//  FParentStyle := Reader.ReadBoolean;
//end;

procedure TElXStylesDefsItem.SetAllowEdit(Value: Boolean);
begin
  if Value <> FAllowEdit then
  begin
    FAllowEdit := Value;
  end;
end;

procedure TElXStylesDefsItem.SetBkColor(Value: TColor);
begin
  if Value <> FBkColor then
  begin
    FBkColor := Value;
  end;
end;

procedure TElXStylesDefsItem.SetBold(Value: Boolean);
begin
  if Value <> FBold then
  begin
    FBold := Value;
  end;
end;

procedure TElXStylesDefsItem.SetBorderStyle(Value: TElItemBorderStyle);
begin
  if Value <> FBorderStyle then
  begin
    FBorderStyle := Value;
  end;
end;

procedure TElXStylesDefsItem.SetCheckBox(const Value: string);
begin
  if Value <> FCheckBox then
  begin
    FCheckBox := Value;
  end;
end;

procedure TElXStylesDefsItem.SetCheckBoxEnabled(Value: Boolean);
begin
  if Value <> FCheckBoxEnabled then
  begin
    FCheckBoxEnabled := Value;
  end;
end;

procedure TElXStylesDefsItem.SetColor(Value: TColor);
begin
  if Value <> FColor then
  begin
    FColor := Value;
  end;
end;

procedure TElXStylesDefsItem.SetDataFields(Value: TStringList);
begin
  FDataFields := Value;
  if Assigned(Value) then
    FHasColumn := True
  else
    FHasColumn := false;
end;

procedure TElXStylesDefsItem.SetDrawHLine(Value: Boolean);
begin
  if Value <> FDrawHLine then
  begin
    FDrawHLine := Value;
  end;
end;

procedure TElXStylesDefsItem.SetEnabled(Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
  end;
end;

procedure TElXStylesDefsItem.SetForceButtons(Value: Boolean);
begin
  if Value <> FForceButtons then
  begin
    FForceButtons := Value;
  end;
end;

procedure TElXStylesDefsItem.SetHeight(Value: Integer);
begin
  if Value <> FHeight then
  begin
    FHeight := Value;
  end;
end;

procedure TElXStylesDefsItem.SetHidden(Value: Boolean);
begin
  if Value <> FHidden then
  begin
    FHidden := Value;
  end;
end;

procedure TElXStylesDefsItem.SetHint(const Value: string);
begin
  if Value <> FHint then
  begin
    FHint := Value;
  end;
end;

procedure TElXStylesDefsItem.SetHintField(const Value: string);
begin
  if Value <> FHintField then
  begin
    FHintField := Value;
  end;
end;

procedure TElXStylesDefsItem.SetHintIsHTML(Value: Boolean);
begin
  if Value <> FHintIsHTML then
  begin
    FHintIsHTML := Value;
  end;
end;

procedure TElXStylesDefsItem.SetImage(const Value: string);
begin
  if Value <> FImage then
  begin
    FImage := Value;
  end;
end;

procedure TElXStylesDefsItem.SetImage2(const Value: string);
begin
  if Value <> FImage2 then
  begin
    FImage2 := Value;
  end;
end;

procedure TElXStylesDefsItem.SetImageIndex(Value: Integer);
begin
  if Value <> FImageIndex then
  begin
    FImageIndex := Value;
  end;
end;

procedure TElXStylesDefsItem.SetImageIndex2(Value: Integer);
begin
  if Value <> FImageIndex2 then
  begin
    FImageIndex2 := Value;
  end;
end;

procedure TElXStylesDefsItem.SetImagesFromBase(Value: Boolean);
begin
  if Value <> FImagesFromBase then
  begin
    FImagesFromBase := Value;
  end;
end;

procedure TElXStylesDefsItem.SetIndentAdjust(Value: Integer);
begin
  if Value <> FIndentAdjust then
  begin
    FIndentAdjust := Value;
  end;
end;

procedure TElXStylesDefsItem.SetIsHTML(Value: Boolean);
begin
  if Value <> FIsHTML then
  begin
    FIsHTML := Value;
  end;
end;

procedure TElXStylesDefsItem.SetItalic(Value: Boolean);
begin
  if Value <> FItalic then
  begin
    FItalic := Value;
  end;
end;

procedure TElXStylesDefsItem.SetHasColumn(Value: Boolean);
begin
  if Value <> FHasColumn then
  begin
    FHascolumn := Value;
  end;
end;

procedure TElXStylesDefsItem.SetMultiline(Value: Boolean);
begin
  if Value <> FMultiline then
  begin
    FMultiline := Value;
  end;
end;

procedure TElXStylesDefsItem.SetOwnerHeight(Value: Boolean);
begin
  if Value <> FOwnerHeight then
  begin
    FOwnerHeight := Value;
  end;
end;

procedure TElXStylesDefsItem.SetParentColors(Value: Boolean);
begin
  if Value <> FParentColors then
  begin
    FParentColors := Value;
  end;
end;

procedure TElXStylesDefsItem.SetParentStyle(Value: Boolean);
begin
  if Value <> FParentStyle then
  begin
    FParentStyle := Value;
  end;
end;

procedure TElXStylesDefsItem.SetPattern(Value: TLMDString);
begin
  if Value <> FPattern then
  begin
    FPattern := Value;
  end;
end;

procedure TElXStylesDefsItem.SetRowBkColor(Value: TColor);
begin
  if Value <> FRowBkColor then
  begin
    FRowBkColor := Value;
  end;
end;

procedure TElXStylesDefsItem.SetShowCheckBox(Value: Boolean);
begin
  if Value <> FShowCheckBox then
  begin
    FShowCheckBox := Value;
  end;
end;

procedure TElXStylesDefsItem.SetStateImageIndex(Value: Integer);
begin
  if Value <> FStImageIndex then
  begin
    FStImageIndex := Value;
  end;
end;

procedure TElXStylesDefsItem.SetStateImageIndex2(Value: Integer);
begin
  if Value <> FStImageIndex2 then
  begin
    FStImageIndex2 := Value;
  end;
end;

procedure TElXStylesDefsItem.SetStImage(const Value: string);
begin
  if Value <> FStImage then
  begin
    FStImage := Value;
  end;
end;

procedure TElXStylesDefsItem.SetStImage2(const Value: string);
begin
  if Value <> FStImage2 then
  begin
    FStImage2 := Value;
  end;
end;

procedure TElXStylesDefsItem.SetStrikedLineColor(Value: TColor);
begin
  if Value <> FStrikedLineColor then
  begin
    FStrikedLineColor := Value;
  end;
end;

procedure TElXStylesDefsItem.SetStrikedOutLine(Value: Boolean);
begin
  if Value <> FStrikedOutLine then
  begin
    FStrikedOutLine := Value;
  end;
end;

procedure TElXStylesDefsItem.SetStrikeout(Value: Boolean);
begin
  if Value <> FStrikeout then
  begin
    FStrikeout := Value;
  end;
end;

procedure TElXStylesDefsItem.SetStyleCaption(const Value: string);
begin
  if (csLoading in (Collection as TElXStylesDefs).FCustomElDBTree.ComponentState) then
  begin
    FInDesign := false;
    FStyleCaption := value;
  end;
end;

procedure TElXStylesDefsItem.SetSuppressButtons(Value: Boolean);
begin
  if Value <> FSuppressButtons then
  begin
    FSuppressButtons := Value;
//    (Collection as TElXStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElXStylesDefsItem.SetSuppressLines(Value: Boolean);
begin
  if Value <> FSuppressLines then
  begin
    FSuppressLines := Value;
//    (Collection as TElXStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElXStylesDefsItem.SetUnderlined(Value: Boolean);
begin
  if Value <> FUnderlined then
  begin
    FUnderlined := Value;
//    (Collection as TElXStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElXStylesDefsItem.SetUseBkColor(Value: Boolean);
begin
  if Value <> FUseBkColor then
  begin
    FUseBkColor := Value;
//    (Collection as TElXStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElXStylesDefsItem.SetUsePattern(Value: Boolean);
begin
  if Value <> FUsePattern then
  begin
    FUsePattern := Value;
//    (Collection as TElXStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stPattern);
  end;
end;

//  TElXStylesDefs

{
******************************** TElXStylesDefs *********************************
}
constructor TElXStylesDefs.Create(ACustomElDBTree: TCustomElDBXTree; ItemClass:
        TCollectionItemClass);
begin
  inherited Create(ItemClass);
  FCustomElDBTree := ACustomElDBTree;
  FCanAppend := False;
end;

procedure TElXStylesDefs.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TElXStylesDefs then
  begin
    FCustomElDBTree := (Source as TElXStylesDefs).FCustomElDBTree;
    FCanAppend := (Source as TElXStylesDefs).FCanAppend;
  end;
end;

function TElXStylesDefs.Add: TElXStylesDefsItem;
begin
  if FCanAppend then Result := TElXStylesDefsItem(inherited Add)
  else
  begin
    ShowMessage(SNoSetInstall);
    Result := nil;
  end;
end;

procedure TElXStylesDefs.Delete(Index: Integer);
begin
  inherited;
end;

function TElXStylesDefs.GetItem(Index: Integer): TElXStylesDefsItem;
begin
  Result := TElXStylesDefsItem(inherited GetItem(Index));
end;

function TElXStylesDefs.GetOwner: TPersistent;
begin
  Result := FCustomElDBTree;
end;

procedure TElXStylesDefs.SetItem(Index: Integer; Value: TElXStylesDefsItem);
begin
  inherited SetItem(Index, Value);
end;

//TCustomElDBXTree

{
******************************* TCustomElDBXTree ********************************
}
constructor TCustomElDBXTree.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  MultiSelect := False;
//  FMaxLevelCount := 10;
  Items.ItemClass := TElDBXTreeItem;
  FDataLink := TElXTreeDataLink.Create(Self);
  FChanging := False;
  FStylesDefs := TElXStylesDefs.Create(Self, TElXStylesDefsItem);
  ShowCheckBoxes := True;
  FInserting := False;
  FGlobalChange := false;
  FCheckField := False;
  FCustomDataEditing := False;
  FShowCheckboxes := False;
  FSorting := False;
  if not (csDesigning in ComponentState) then
  begin
    FDataTree := TElMDBTree.Create;
    FDataTree.FTree := self;
    VirtualityLevel := vlAllProps;
  end;
  OnVirtualTextNeeded := NewOnVirtualTextNeeded;
  OnVirtualPropsNeeded := NewTreeVirtualPropsNeeded;
  OnVirtualStyleNeeded := NewVirtualStyleNeeded;
  OnVirtualHintNeeded := NewVirtualHintNeeded;
//  QuickEditMode := false;
end;

destructor TCustomElDBXTree.Destroy;
begin
  Items.Clear;
  if Assigned(FDataTree) then
    FDataTree.Free;
  FStylesDefs.Free;
  if Assigned(FSource) then
    FSource.UnRegisterLink(FDataLink);
  FDataLink.Free;
  FSource := nil;
  inherited Destroy;
end;

procedure TCustomElDBXTree.Refresh;
var
  c: Boolean;
begin
  if not FChanging then
  begin
    if Assigned(FDataTree) and (not IsUpdating) then
    begin
      c := FChanging;
      FChanging := True;
      CheckRootLevel;
      FDataTree.RefreshData;
      FChanging := c;
    end;
    inherited refresh;
  end;
end;

procedure TCustomElDBXTree.Assign(Source: TPersistent);
var
  T: TCustomElDBXTree;
begin
  if Source is TCustomElDBXTree then
  begin
    IsUpdating := true;
    T := TCustomElDBXTree(Source);
//    FMaxLevelCount := T.FMaxLevelCount;
    Items.ItemClass := TElDBXTreeItem;
    FInserting := T.FInserting;
    FGlobalChange := T.FGlobalChange;
    FCheckField := T.FCheckField;
    FCustomDataEditing := T.FCustomDataEditing;
    DataSource := T.DataSource;
    IsUpdating := false;
    FStylesDefs := T.FStylesDefs;
    FDataTree := T.FDataTree;
    inherited;
  end
  else
    inherited;
end;

function TCustomElDBXTree.CreateItems: TElXTreeItems;
begin
  Result := TElDBXTreeItems.CreateClass(Self, TElDBXTreeItem);
end;

function TCustomElDBXTree.CreateView: TElXTreeView;
begin
  Result := TElDBXTreeView.Create(Self);
end;

procedure TCustomElDBXTree.SetRightAlignedText(newValue: Boolean);
begin
  inherited;
  RebuildTree(true);
end;

procedure TCustomElDBXTree.OnHeaderSectionClick(Sender: TElXCustomHeader; Section: TElXHeaderSection);
begin
  inherited;
end;

procedure TCustomElDBXTree.DataSetChanged;
begin
  if not HandleAllocated then Exit;
  if not FChanging and FSource.DataSet.Active and not (csLoading in ComponentState) then
    RebuildTree(False);
end;

procedure TCustomElDBXTree.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
    Filer.DefineProperty('LookAllSetsPosition', FakeBoolean, nil, false);
end;

procedure TCustomElDBXTree.AfterEdit;
var
  mitem: TElMTreeItem;
begin
  if Assigned(Selected) then
  begin
//    mitem := FDataTree.Item[Selected.AbsoluteIndex];
    mitem := Selected.FMItem;
    if Assigned(mitem) then
    begin
      TMData(mitem.data).FDataField := '';
      TMData(mitem.data).GetValue(vnText);
    end;
  end;
  if Assigned(Selected) then
  begin
//    if Selected.FPattern <> '' then
//    begin
//      c := FChanging;
//      FChanging := True;
//      if Selected.FPattern <> '' then
//        Selected.text := ParsePattern(Selected.FPattern, Selected.FDataLink.DataSet);
//      FChanging := c;
//    end;
    if Assigned(FOnItemChanged) then FOnItemChanged(Selected);
  end;
end;

function TCustomElDBXTree.GetDBDropTarget: TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(GetDropTarget);
end;

procedure TCustomElDBXTree.NewVirtualHintNeeded(Sender: TObject; Item: TElXTreeItem; var Hint: TLMDString);
var
  mitem: TElMTreeItem;
begin
//    mitem := FDataTree.Item[Item.AbsoluteIndex];
    mitem := (Item as TElDBXTreeItem).FMItem;
  if Assigned(mitem) then
    Hint := TMData(mitem.Data).GetValue(vnHint)
  else
    Hint := 'mitem not found';
end;

procedure TCustomElDBXTree.NewVirtualStyleNeeded(Sender: TObject;Item: TElXTreeItem; SectionIndex: Integer; Style: TElXCellStyle);
  procedure SetCurStyle(FRelIndex: integer; Style: TElXCellStyle);
  begin
    if StylesDefs[FRelIndex].FInDesign then exit;
    Style.ParentColors := StylesDefs[FRelIndex].ParentColors;
    Style.TextColor := StylesDefs[FRelIndex].FColor;
    Style.UseBackGroundColor := StylesDefs[FRelIndex].FUseBkColor;
    Style.CellBackGroundColor := StylesDefs[FRelIndex].FBkColor;
    Style.TextBackGroundColor := StylesDefs[FRelIndex].FRowBkColor;
    if StylesDefs[FRelIndex].FRowBkColor = clNone then
      Style.TextBackGroundColor := Style.CellBackGroundColor;

    Style.StrikedOutLine := StylesDefs[FRelIndex].StrikedOutLine;
    if Style.StrikedOutLine then
      Style.StrikedLineColor := StylesDefs[FRelIndex].StrikedLineColor;

    if StylesDefs[FRelIndex].Italic then
      Style.FontStyles := Style.FontStyles + [fsItalic];
    if StylesDefs[FRelIndex].Underlined then
      Style.FontStyles := Style.FontStyles + [fsUnderline];
    if StylesDefs[FRelIndex].Bold then
      Style.FontStyles := Style.FontStyles + [fsBold];
    if StylesDefs[FRelIndex].Strikeout then
      Style.FontStyles := Style.FontStyles + [fsStrikeout];
    Style.BorderStyle := StylesDefs[FRelIndex].FBorderStyle;
    if Assigned(HeaderSections) and (HeaderSections.Count > (SectionIndex + 1)) then
    begin
      if HeaderSections[SectionIndex+1].Alignment = hsaLeft then
      begin
        if RightAlignedText then
          Style.TextFlags := DT_RIGHT
        else
          Style.TextFlags := DT_LEFT;
      end;
      if Self.HeaderSections[SectionIndex+1].Alignment = hsaCenter then
        Style.TextFlags := DT_CENTER;
      if Self.HeaderSections[SectionIndex+1].Alignment = hsaRight then
      begin
        if RightAlignedText then
          Style.TextFlags := DT_LEFT
        else
          Style.TextFlags := DT_RIGHT;
      end;
//      HeaderSections[FRelIndex+1].Editable := False;
    end;
  end;
var
  RelIndex, CurCellIndex: integer;
  mitem: TElMTreeItem;
begin
  if FChanging or IsUpdating then exit;
  RelIndex := (Item as TElDBXTreeItem).RelIndex;
  SetCurStyle(RelIndex, Style);
  mitem := (Item as TElDBXTreeItem).FMItem;
  if LMDInRange(SectionIndex, 0, Header.Sections.Count - 1) then
    Style.DrawStyle := Header.Sections.ItemByPos[SectionIndex].Style;
  if ((Item as TElDBXTreeItem).DataField <> '') and ((Item as TElDBXTreeItem).DataField <> 'That caption') then
  begin
    if (SectionIndex = MainTreeColumn) or (SectionIndex = -1) then
    begin
      if Assigned(mitem) then
      begin
        Style.CellType := TElFieldType(TMData(mitem.Data).GetValue(vnCellType));
        CurCellIndex := SectionIndex;
        if CurCellIndex < 0 then
          CurCellIndex := 0;
        if Assigned(TMData(mitem.Data).FPicture) {TMData(mitem.Data).FHasPicture } then
        begin
          Item.Cells[CurCellIndex].UseOwnStyle := True;
          Style.DrawStyle := ElhsPictureOnly;
          if not Assigned(Item.Cells[CurCellIndex].Picture) then
            Item.Cells[CurCellIndex].Picture := TBitmap.Create;
          Item.Cells[CurCellIndex].Picture.Assign(TMData(mitem.Data).FPicture);
          (Item as TElDBXTreeItem).FHasPicture := true;
        end
        else
        begin
          if Assigned(Item.Cells[CurCellIndex].Picture) then
          begin
            Item.Cells[CurCellIndex].Picture.Free;
            Item.Cells[CurCellIndex].Picture := nil;
          end;
        end;
      end;
    end
    else
    begin
      if Assigned(mitem) then
      begin
        if SectionIndex < MainTreeColumn then
          CurCellIndex := SectionIndex
        else
          CurCellIndex := SectionIndex - 1;
        if (TMData(mitem.Data).FCells.Count > CurCellIndex) then
        begin
          Style.CellType := TMTreeCellData(TMData(mitem.Data).FCells.Items[CurCellIndex]).FCellType;
          if Assigned(TMTreeCellData(TMData(mitem.Data).FCells.Items[CurCellIndex]).FCellPicture) then
          begin
            Item.Cells[SectionIndex].UseOwnStyle := True;
            Style.DrawStyle := ElhsPictureOnly;
            if not Assigned(Item.Cells[SectionIndex].Picture) then
              Item.Cells[SectionIndex].Picture := TBitmap.Create;
            Item.Cells[SectionIndex].Picture.Assign(TMTreeCellData(TMData(mitem.Data).FCells.Items[CurCellIndex]).FCellPicture);
          end
          else
          begin
            if Assigned(Item.Cells[SectionIndex].Picture) then
            begin
              Item.Cells[SectionIndex].Picture.Free;
              Item.Cells[SectionIndex].Picture := nil;
            end;
          end;
        end;
      end;
    end;
  end;
end;
//{$endif}

procedure TCustomElDBXTree.NewTreeVirtualPropsNeeded(Sender: TObject;Item: TElXTreeItem; PropTypes: TElVirtPropTypes; Value: TElXTreeItemStaticDataEx);
var
  mitem: TElMtreeItem;
begin
//  if FChanging or IsUpdating then exit;
//  Item.UseStyles := true;
  (Item as TElDBXTreeItem).SetStyle;
//  mitem := FDataTree.Item[Item.AbsoluteIndex];
  mitem := (Item as TElDBXTreeItem).FMItem;
  if Assigned(mitem) then
  begin
    with Item do
    begin
      if (TMData(mitem.Data).GetValue(vnImageIndexField) <> null) and (TMData(mitem.Data).GetValue(vnImageIndexField) <> '') then
        ImageIndex := TMData(mitem.Data).GetValue(vnImageIndex);
      if (TMData(mitem.Data).GetValue(vnStateImageIndex) <> null) and (TMData(mitem.Data).FStImageIndexField <> '') then
        StateImageIndex := TMData(mitem.Data).GetValue(vnStateImageIndex);
      if (TMData(mitem.Data).GetValue(vnImageIndex2) <> null) and (TMData(mitem.Data).FImageIndex2Field <> '') then
        ImageIndex2 := TMData(mitem.Data).GetValue(vnImageIndex2);
      if (TMData(mitem.Data).GetValue(vnStateImageIndex) <> null) and (TMData(mitem.Data).FStImageIndex2Field <> '') then
        StateImageIndex2 := TMData(mitem.Data).GetValue(vnStateImageIndex);
      if ShowCheckBox then
        if TMData(mitem.Data).FCheckBoxFromBase then
          CheckBoxState := TMData(mitem.Data).FCheckBoxState;
//        else
//          CheckBoxState := Item.CheckBoxState
    end;
    if not TMData(mitem.Data).FOwnerHeight and (TMData(mitem.Data).FHeight > 0) then   // picture
    begin
      Item.OwnerHeight := false;
      Item.Height := TMData(mitem.Data).FHeight;
    end;
  end;
end;

procedure TCustomElDBXTree.NewOnVirtualTextNeeded(Sender: TObject; Item: TElXTreeItem; SectionIndex: Integer; var Text: TLMDString);
var
  mitem: TElMtreeItem;
begin
  if (FChanging {or IsUpdating}) and (not FSorting) then
    exit;
//  mitem := FDataTree.Item[Item.AbsoluteIndex];
  mitem := (Item as TElDBXTreeItem).FMItem;
  if Assigned(mitem) then
    if SectionIndex <> MainTreeColumn then
    begin
      if (TMData(mitem.Data).FCells.Count > 0) and (TMData(mitem.Data).FCells.Count >= SectionIndex) then
      begin
        if (MainTreeColumn < SectionIndex) then
          Text := TMTreeCellData(TMData(mitem.Data).FCells.Items[SectionIndex-1]).FCellText
        else
        begin
          if (MainTreeColumn > SectionIndex) then
            Text := TMTreeCellData(TMData(mitem.Data).FCells.Items[SectionIndex]).FCellText
          else
            Text := TMTreeCellData(TMData(mitem.Data).FCells.Items[SectionIndex+1]).FCellText;
        end;
      end
      else
        Text := '';
    end
    else
      Text := TMData(mitem.Data).GetValue(vnText)
  else
    Text := 'mitem not found';
end;

function TCustomElDBXTree.GetDBItems: TElDBXTreeItems;
begin
  Result := TElDBXTreeItems(FItems);
end;

function TCustomElDBXTree.GetDBSelected: TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(GetSelected);
end;

function TCustomElDBXTree.GetDBTopItem: TElDBXTreeitem;
begin
  Result := TElDBXTreeItem(GetTopItem);
end;

function TCustomElDBXTree.GetDBTrackItem: TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(GetTrackItem);
end;

function TCustomElDBXTree.GetItemAt(X, Y: Integer; var ItemPart: TSTXItemPart;
        var HitColumn: integer): TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetItemAt(X, Y, ItemPart, HitColumn));
end;

function TCustomElDBXTree.GetItemAtY(Y: integer): TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetItemAtY(Y));
end;

function TCustomElDBXTree.GetItemFocused: TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(GetFocused);
end;

function TCustomElDBXTree.GetNextSelected(Prev: TElXTreeItem): TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetNextSelected(Prev));
end;

function TCustomElDBXTree.GetNodeAt(X, Y: integer): TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(inherited GetNodeAt(X, Y));
end;

function TCustomElDBXTree.GetSource: TElXRelDataSource;
begin
  Result := FSource;
end;

procedure TCustomElDBXTree.KeyDownTransfer(Sender: TObject; var Key: Word;
        Shift: TShiftState);
begin
  inherited;
  if Key = VK_DELETE then
  begin
  //// temporary remark
  //        if goEditing then
  //          Items.DeleteItem(ItemFocused);
  //        DoAfterSelectionChange;
  //        Key := 0;
  end;
end;

procedure TCustomElDBXTree.Notification(AComponent: TComponent; Operation:
        TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = DataSource) and (FSource <> nil) then DataSource := nil;
end;

procedure TCustomElDBXTree.OnHeaderSectionChange(Sender: TElXCustomHeader; Section:
            TElXHeaderSection; Change: TSectionChangeMode);

  procedure SetAlignment(Item: TElXTreeItem; i: Integer);
  var
    Child: TElXTreeItem;
  begin
    if Assigned(Item) and ((i > 0) and (i <= Item.Cells.Count)) then
    begin
      if Self.HeaderSections[i].Alignment = hsaLeft then
        Item.Cells[i - 1].Style.TextFlags := DT_LEFT;
      if Self.HeaderSections[i].Alignment = hsaCenter then
        Item.Cells[i - 1].Style.TextFlags := DT_CENTER;
      if Self.HeaderSections[i].Alignment = hsaRight then
        Item.Cells[i - 1].Style.TextFlags := DT_RIGHT;
    end;
    if Assigned(Item) then
      Child := Item.GetFirstChild
    else
      Child := Self.Items.GetFirstNode;
    while Child <> nil do
    begin
      SetAlignment(Child,i);
      if Assigned(Item) then
        Child := Item.GetNextChild(Child)
      else
        Child := Child.GetNextSibling;
    end;
  end;

begin
  inherited;
  case Change of
    scmAlign, scmStyle:
      if Section.Visible then
      begin
  //
       SetAlignment(nil,Section.Index);
      end;
  end;
end;

procedure TCustomElDBXTree.RebuildOnDisignTime;
var
  i, ItemInViewCount, j, k: integer;
  MDataSet: TDataSet;
  bk: TBookmark;
  rItem: TElDBXTreeItem;
  text: variant;
  OldFilter: string;
  OldFiltered: Boolean;
  DataSetOptions :TElXDataSetOptions;
begin
  if not (Assigned(FSource) and Assigned(FSource.DataSet) and (FSource.DataSet.Active)) then
  begin
    Items.BeginUpdate;
    Items.Clear;
    Items.EndUpdate;
    Exit;
  end;
  if (FSource.DataSet.Active) and (FSource.FShowCaption) then
  begin
    Items.BeginUpdate;
    Items.Clear;
    rItem := (Items.AddChildObject(nil, FSource.Caption, nil) as TElDBXTreeItem);
    if FSource.DataSet.RecordCount > 0 then
      items.AddChild(rItem,'');
    Items.EndUpdate;
    Exit;
  end;
  if (FSource.DataSet.Active) and (FSource.RootDataField <> '') then
  begin
    Items.BeginUpdate;
    Items.Clear;
    ItemInViewCount := Round(Self.Height/Self.LineHeight) + 1;
    MDataSet := FSource.DataSet;
    MDataSet.DisableControls;
    OldFilter := MDataSet.Filter;
    OldFiltered := MDataSet.Filtered;
    bk := MDataSet.GetBookmark;
    if DataSource.FFiltered then
    begin
      if (Trim(MDataSet.Filter)<>'') and MDataSet.Filtered then
        MDataSet.Filter := '(' + MDataSet.Filter + ')' + ' AND '+ '(' + DataSource.FFilter + ')'
      else
        MDataSet.Filter := DataSource.FFilter;
      MDataSet.Filtered := True;
    end;
    j := DataSource.GetRelNoOnLevel(1,DataSetOptions);
    MDataSet.First;
    for i := 0 to min(ItemInViewCount, MDataSet.RecordCount - 1) do
    begin
      if FStylesDefs.Items[0].UsePattern then
        text := ParsePattern(FStylesDefs.Items[0].Pattern,MDataSet)
      else
        text := MDataSet.FieldByName(FSource.RootDataField).DisplayText;
      rItem := (Items.AddChildObject(nil, text, nil) as TElDBXTreeItem);
      rItem.FBookmark := MDataSet.GetBookmark;
      rItem.FDataField := FSource.FDataField;
      rItem.FRelIndex := 0;
      if j > 0 then
      begin
        rItem.FMasterField := DataSource.Relations[j-1].FMasterField;
        if rItem.FMasterField <> '' then
          if (MDataSet.FieldByName(rItem.FMasterField).DataType in [ftString, ftDate, ftTime, ftDateTime]) then
            ritem.FMasterValue := QuotedStr(MDataSet.FieldByName(rItem.FMasterField).AsString)
          else
            ritem.FMasterValue := MDataSet.FieldByName(rItem.FMasterField).AsString;
        rItem.CheckActualChildrens;
      end
      else
        rItem.FMarker := True;
      rItem.SetStyle;
      if rItem.ImagesFromBase then
      begin
        if rItem.ImageIndexField <> '' then
          rItem.ImageIndex := MDataSet.FieldByName(rItem.ImageIndexField).asInteger;
        if rItem.StateImageIndexField <> '' then
          rItem.StateImageIndex := MDataSet.FieldByName(rItem.StateImageIndexField).asInteger;
        if rItem.Image2IndexField <> '' then
          rItem.ImageIndex2 := MDataSet.FieldByName(rItem.Image2IndexField).asInteger;
        if rItem.StateImage2IndexField <> '' then
          rItem.StateImageIndex2 := MDataSet.FieldByName(rItem.StateImage2IndexField).asInteger;
      end;
    if StylesDefs[0].FDataFields.Count > 0 then
      for k := 0 to (StylesDefs[0].FDataFields.Count - 1) do
      begin
        if StylesDefs[0].FDataFields[k] <> 'empty column or defined by user' then
        begin
          if MDataSet.FindField(StylesDefs[0].FDataFields[k]) <> nil then
          begin
//            Child.FStaticData.FColText.Add(MDataSet.FieldByName(StylesDefs[Child.FRelIndex].FDataFields[i]).DisplayText);
            {$IFDEF LMD_UNICODE}
              if MDataSet.FieldByName(StylesDefs[0].FDataFields[k]).DataType in ([ftString, ftWideString]) then
              begin
                rItem.Cells[k+1].Text := GetWideStringText(MDataSet.FieldByName(StylesDefs[0].FDataFields[k]));
//                rItem.FStaticData.FColText.Add(GetWideStringText(MDataSet.FieldByName(StylesDefs[0].FDataFields[k])))
              end
              else
                rItem.Cells[k+1].Text := MDataSet.FieldByName(StylesDefs[0].FDataFields[k]).DisplayText;
//                rItem.FStaticData.FColText.Add(MDataSet.FieldByName(StylesDefs[0].FDataFields[k]).DisplayText);
            {$ELSE}
              rItem.Cells[k+1].Text := MDataSet.FieldByName(StylesDefs[0].FDataFields[k]).DisplayText;
//              rItem.FStaticData.FColText.Add(MDataSet.FieldByName(StylesDefs[0].FDataFields[k]).DisplayText);
            {$ENDIF}
            rItem.Cells[k+1].UseOwnStyle := True;
            rItem.Cells[k+1].Style.TextBackGroundColor := clNone;
            rItem.Cells[k+1].Style.CellBackGroundColor := clNone;
            rItem.Cells[k+1].Style.DrawStyle := ElhsText;
            if Self.HeaderSections[k+1].Alignment = hsaLeft then
              rItem.Cells[k+1].Style.TextFlags := DT_LEFT;
            if Self.HeaderSections[k+1].Alignment = hsaCenter then
              rItem.Cells[k+1].Style.TextFlags := DT_CENTER;
            if Self.HeaderSections[k+1].Alignment = hsaRight then
              rItem.Cells[k+1].Style.TextFlags := DT_RIGHT;

            case MDataSet.FieldByName(StylesDefs[0].FDataFields[k]).DataType of
              ftBoolean: rItem.Cells[k+1].Style.CellType := sftBool;
                //ftString : CS.CellType := sftText;
              ftString, ftWideString:
                  rItem.Cells[k+1].Style.CellType := sftText;
               ftMemo, ftFmtMemo{$ifdef LMDCOMP10}, ftWideMemo{$endif}: rItem.Cells[k+1].Style.CellType := sftMemo;
              ftSmallint, ftInteger, ftWord, ftAutoInc, ftLargeInt: rItem.Cells[k+1].Style.CellType := sftNumber;
              ftFloat: rItem.Cells[k+1].Style.CellType := sftFloating;
              ftCurrency: rItem.Cells[k+1].Style.CellType := sftCurrency;
              ftDate: rItem.Cells[k+1].Style.CellType := sftDate;
              ftTime: rItem.Cells[k+1].Style.CellType := sftTime;
              ftDateTime: rItem.Cells[k+1].Style.CellType := sftDateTime;
              ftBlob: rItem.Cells[k+1].Style.CellType := sftBLOB;
              ftGraphic: begin
                  rItem.Cells[k+1].Style.CellType := sftPicture;
                  if MDataSet.FieldByName(StylesDefs[0].FDataFields[k]).IsBlob then
                  begin
                    rItem.Cells[k+1].Style.DrawStyle := ElhsPictureOnly;
                    rItem.Cells[k+1].Picture := TBitmap.Create;
                    rItem.Cells[k+1].Picture.Assign(MDataSet.FieldByName(StylesDefs[0].FDataFields[k]));
                    rItem.OwnerHeight := false;
                    rItem.Height := rItem.Cells[k+1].Picture.Height;
                  end;
                end;
              ftUnknown: rItem.Cells[k+1].Style.CellType := sftCustom;
            else
              rItem.Cells[k+1].Style.CellType := sftText;
            end;
            if MDataSet.FieldByName(StylesDefs[0].FDataFields[k]).FieldKind = fkLookup then
              rItem.Cells[k+1].Style.CellType := sftEnum;
          end
          else
          begin
            rItem.Cells[k+1].Text := ' field not found ';
            rItem.Cells[k+1].UseOwnStyle := True;
            rItem.Cells[k+1].Style.CellType := sftText;
            if Self.HeaderSections[k+1].Alignment = hsaLeft then
              rItem.Cells[k+1].Style.TextFlags := DT_LEFT;
            if Self.HeaderSections[k+1].Alignment = hsaCenter then
              rItem.Cells[k+1].Style.TextFlags := DT_CENTER;
            if Self.HeaderSections[k+1].Alignment = hsaRight then
              rItem.Cells[k+1].Style.TextFlags := DT_RIGHT;
            Self.HeaderSections[k+1].Editable := False;
          end;
        end;
      end;

      MDataSet.Next;
      if MDataSet.Eof then Break;
    end;
    MDataSet.Filtered := OldFiltered;
    MDataSet.Filter := OldFilter;
    MDataSet.GotoBookmark(bk);
    MDataSet.FreeBookmark(bk);
    MDataSet.EnableControls;
    Items.EndUpdate;
  end;
end;

procedure TCustomElDBXTree.InsertToRootDataSet;
var
  MDataSet: TDataSet;
begin
  MDataSet := DataSource.GetRootDataSet;
  if Assigned(MDataSet) then
  begin
    MDataSet.Insert;
    MDataSet.Post;
  end;
end;

procedure TCustomElDBXTree.TriggerSortBegin;
begin
  FSorting := True;
  inherited;
end;

procedure TCustomElDBXTree.TriggerSortEnd;
begin
  inherited;
  FSorting := False;
end;

procedure TCustomElDBXTree.CheckRootLevel;
var
  i, j, k, ck: integer;
  ritem: TElDBXTreeItem;
  data: TMData;
  mitem: TElMTreeItem;
  begin
  Items.BeginUpdate;
  j := DataSource.RecCountOnLevel(0,'');
  ck := Items.RootCount;
  if (j <> ck) then
  begin
    if ck > 0 then
    begin
      for k := 0 to (Items.Count - 1) do
      begin
        if Assigned(TMData(FDataTree.Item[Items[k].AbsoluteIndex].Data).FBookmark) then
        begin
        TMData(FDataTree.Item[Items[k].AbsoluteIndex].Data).FDataLink.DataSet.FreeBookmark(TMData(FDataTree.Item[Items[k].AbsoluteIndex].Data).FBookmark);
        end;
        TMData(FDataTree.Item[Items[k].AbsoluteIndex].Data).FBookmark := nil;
        TMData(FDataTree.Item[Items[k].AbsoluteIndex].Data).FDataLink.DataSource := nil;
      end;
    end;
    if (j < ck) then
    begin
      for i := j to (ck-1) do
      begin
        ritem := Items.GetFirstNode;
        ritem.Delete;
      end;
      ritem := Items.GetFirstNode;
      while Assigned(ritem) do
      begin
        if Assigned(TMData(ritem.FMItem.Data).FBookmark) then
        begin
        TMData(ritem.FMItem.Data).FDataLink.DataSet.FreeBookmark(TMData(ritem.FMItem.Data).FBookmark);
        end;
        TMData(ritem.FMItem.Data).FBookmark := nil;
        TMData(ritem.FMItem.Data).FDataLink.DataSource := nil;
        ritem := ritem.GetNextSibling;
      end;
    end
    else
    begin
      if (j > 0) then
      begin
        Items.AllocateStorage(j-ck);
        Items.AllocateStorageInRoot(j-ck);
        for k := 0 to j - ck - 1 do
        begin
          ritem := (Items.AddLastItem(nil) as TElDBXTreeItem);
          data := TMData.Create(ritem);
          mitem := FDataTree.AddItem(nil,Data);
          Data.FOwner := mitem;
          Data.FTree := FDataTree;
          Data.FTreeOwner := ritem;
          ritem.FMItem := mitem;
        end;
      end;
    end;
  end;
  Items.EndUpdate;
end;

procedure TCustomElDBXTree.RebuildTree(KeepCurrentID: Boolean);
  procedure SavePosition(var CurrItemIndex: String; ritem: TElDBXTreeItem);
  begin
    CurrItemIndex := IntToStr(rItem.Index)+'/'+CurrItemIndex;
    if rItem.Level = 0 then
      exit
    else
      SavePosition(CurrItemIndex,rItem.Parent);
  end;
  procedure RestorePosition(var CurItemIndex: String);
  var
    s: string;
    rItem: TElDBXTreeItem;
    i: integer;
  begin
    i := pos('/',CurItemIndex);
    s := copy(CurItemIndex,0,i-1);
    try
      rItem := Selected;
      if not Assigned(RItem) then
        Selected := Items[min(StrToInt(s), Items.RootCount - 1)]
      else
      begin
        rItem.Expand(false);
        if  Assigned(rItem.FMItem) then
        begin
          TMData(rItem.FMItem.Data).GetValue(vnMasterValue);
          FDataTree.CheckActualChildrensCount(rItem.FMItem);
          FDataTree.GetDataForChildrens(rItem.FMItem, 0, min(StrToInt(s), FDataTree.RowCount));
        end;
       selected := rItem.GetChildByIndex(min(StrToInt(s), rItem.FChildren.Count - 1))
      end;
    except
      Raise;
    end;
    System.Delete(CurItemIndex,1,i);
    if Length(CurItemIndex) = 0 then
      exit
    else
      RestorePosition(CurItemIndex);
  end;
var
  LIndex: integer;
  CurItemIndex: String;
begin
  if Assigned(FOnBeforeBuildTree) then FOnBeforeBuildTree(Self);
  if not (Assigned(FSource) and Assigned(FSource.DataSet) and (FSource.DataSet.Active)) then
    begin
      Items.BeginUpdate;
      Items.Clear;
      Items.EndUpdate;
      Exit;
    end;
  if (csDesigning in ComponentState) then
  begin
    RebuildOnDisignTime;
    Exit;
  end;
  CurItemIndex := '';
  LIndex := VScrollBar.Position;
  if FSource.DataSet.Active then
  begin
    if KeepCurrentID then
      if Selected <> nil then
        SavePosition(CurItemIndex, Selected);
    Items.BeginUpdate;
    Items.Clear;
    CheckRootLevel;
    if (KeepCurrentID) and (CurItemIndex <> '') then
      RestorePosition(CurItemIndex);
    Items.EndUpdate;
    if (KeepCurrentID) then
      VScrollBar.Position := LIndex;
  end
  else
  begin
    Items.BeginUpdate;
    Items.Clear;
    Items.EndUpdate;
  end;
  if FAutoResizeColumns then
    AutoSizeAllColumns;
  if Assigned(FOnAfterBuildTree) then FOnAfterBuildTree(Self);
end;

procedure TCustomElDBXTree.SetDBSelected(const Value: TElDBXTreeItem);
begin
  SetSelected(Value);
end;

procedure TCustomElDBXTree.SetDBTopItem(const Value: TElDBXTreeitem);
begin
  SetTopItem(Value);
end;

procedure TCustomElDBXTree.SetItemFocused(Value: TElDBXTreeItem);
begin
  if Value <> nil then
    DoSetFocused(Value, True);
  //    Value.SetSelected(true);
end;

procedure TCustomElDBXTree.SetSource(Source: TElXRelDataSource);
var
  i: Integer;
  item: TElXStylesDefsItem;
begin
  if Source = FSource then Exit;
  if FSource <> nil then FSource.UnRegisterLink(FDataLink);
  if Source <> nil then Source.RegisterLink(FDataLink);
  FSource := Source;
  if (not (csLoading in ComponentState)) and ((Source <> nil) and (not (csLoading in Source.ComponentState))) then
  begin
    FStylesDefs.FCanAppend := True;
    FStylesDefs.Clear;
    for i := 0 to Source.Relations.Count do
    begin
      item := FStylesDefs.Add;
      if i = 0 then
      begin
        item.FStyleCaption := 'Rootlevel';
        item.FDataLink.DataSource := Source.GetRootDataSource;
        item.FDataField := Source.RootDataField;
        item.FInDesign := false;
      end
      else
      begin
        if (Source.Relations[i - 1].DetailDataSet <> nil) and (Source.Relations[i - 1].MasterDataSet <> nil) then
        begin
          item.FStyleCaption := 'Relation ' + IntToStr(i - 1) + ' level: ' + Source.Relations[i - 1].MasterDataSet.Name + '-' + Source.Relations[i - 1].DetailDataSet.Name;
          item.FInDesign := false;
        end
        else
        begin
          item.FStyleCaption := 'Relation ' + IntToStr(i - 1);
          item.FInDesign := true;
        end;
        item.FDataLink.DataSource := Source.Relations[i - 1].GetDetailDataSource;
        item.FDataField := Source.Relations[i - 1].DetailDisplayField;
      end;
    end;
    FStylesDefs.FCanAppend := False;
  end
  else
  begin
    if (Source <> nil) then
    begin
      if Source.Relations.Count + 1 > FStylesDefs.Count then
      begin
        FStylesDefs.FCanAppend := True;
        for i := FStylesDefs.Count to Source.Relations.Count do FStylesDefs.Add;
        FStylesDefs.FCanAppend := False;
      end;
      for i := 0 to Source.Relations.Count do
      begin
        if i = 0 then
        begin
          FStylesDefs[i].FDataLink.DataSource := Source.GetRootDataSource;
          FStylesDefs[i].FDataField := Source.RootDataField;
          FStylesDefs[i].FInDesign := false;
        end
        else
        begin
          FStylesDefs[i].FDataLink.DataSource := Source.Relations[i - 1].GetDetailDataSource;
          FStylesDefs[i].FDataField := Source.Relations[i - 1].DetailDisplayField;
        end;
      end;
    end
    else
    begin
      FStylesDefs.Clear;
    end;
  end;
//  if FSource <> nil then FSource.UnRegisterLink(FDataLink);
//  if Source <> nil then Source.RegisterLink(FDataLink);
  If Source = nil then
    Items.Clear;
  FSource := Source;
  if Source <> nil then
  begin
    Source.GetRootDataSource.FreeNotification(Self);
    RebuildTree(false);
  end;
end;

procedure TCustomElDBXTree.SetStylesDefs(Value: TElXStylesDefs);
begin
  FStylesDefs.Assign(Value);
end;

procedure TCustomElDBXTree.TriggerInplaceEditorNeeded(Item: TElXTreeItem;
        SectionIndex: Integer; SupposedFieldType: TElFieldType; var Editor:
        TElTreeInplaceEditor);
var
  i: Integer;

begin
  if (HeaderSections.Count > 1) then
    if SectionIndex > 0 then
    begin
      if (StylesDefs.Items[(Item as TElDBXTreeItem).RelIndex].FDataFields.Count > 0) then
        if (StylesDefs.Items[(Item as TElDBXTreeItem).RelIndex].DataFields.Strings[SectionIndex - 1] <> 'empty column or defined by user') then
          (Item as TElDBXTreeItem).EditingField := StylesDefs.Items[(Item as TElDBXTreeItem).RelIndex].DataFields.Strings[SectionIndex - 1]
        else
        begin
          Editor := nil;
          with THackELXTreeInplaceManager(Self.FEditorManager) do
          begin

            for i := 0 to FEditorsList.Count - 1 do
            begin
              Editor := TElTreeInplaceEditor(FEditorsList[i]);

              if (SupposedFieldType in Editor.Types) and (not (Editor is TElDBTreeInplaceEditor)) then
                break
              else
                Editor := nil
            end;
          end;
          if Assigned(Editor) then
          begin
            FCustomDataEditing := True;
            FCustomSectionNum := SectionIndex;
          end;
          if Assigned(OnInplaceEditorNeeded) then
            OnInplaceEditorNeeded(Self, Item, SectionIndex, SupposedFieldType, Editor);
          exit;
         end
       else
       begin
         if Assigned(OnInplaceEditorNeeded) then
           OnInplaceEditorNeeded(Self, Item, SectionIndex, SupposedFieldType, Editor);
         Abort;
       end;
    end
    else (Item as TElDBXTreeItem).EditingField := (Item as TElDBXTreeItem).GetDataField;
  Editor := nil;
  with THackELXTreeInplaceManager(Self.FEditorManager) do
  begin

    for i := 0 to FEditorsList.Count - 1 do
    begin
      Editor := TElTreeInplaceEditor(FEditorsList[i]);

      if (SupposedFieldType in Editor.Types) and (Editor is TElDBTreeInplaceEditor) then
        break
      else
        Editor := nil
    end;
  end;
  if ((Editor is TElDBTreeCheckBoxEdit) or (Editor is TElDBTreeLookupComboBoxEdit)) and (SectionIndex = 0) then
  begin
    (Item as TElDBXTreeItem).EditingField := (Item as TElDBXTreeItem).CheckBoxField;
  end;
  if Assigned(OnInplaceEditorNeeded) then
    OnInplaceEditorNeeded(Self, Item, SectionIndex, SupposedFieldType, Editor);
end;

procedure TCustomElDBXTree.NavigateInDataSet(AItem: TElXTreeItem; ChangeTreeState: Boolean);
var
  MDataSet: TDataSet;
  AParent: TElXTreeItem;
  OldChanging: Boolean;

  list: TList;

  s: string;
  DataSetOptions :TElXDataSetOptions;
begin
  if (not (csDestroying in ComponentState)) and (not FChanging) then
  begin
    OldChanging := FChanging;
    FChanging := True;
    MDataSet := DataSource.GetSetOnLevel(AItem.Level,DataSetOptions);
    if (Assigned(MDataSet)) and (MDataSet.Active) and (Assigned((AItem as TElDBXTreeItem).Bookmark )) then
    begin
      if (not (elDenyLookSetPosition in DataSetOptions)) then
      begin
        try
          if ChangeTreeState then
            IsUpdating := False;
          if (Assigned((AItem as TElDBXTreeItem).Bookmark)) and (not MDataSet.ControlsDisabled) then
            MDataSet.GotoBookmark((AItem as TElDBXTreeItem).Bookmark);
          if ChangeTreeState then
            IsUpdating := True;
        except
          on E: exception do
          begin
            IsUpdating := True;
            raise EOnGoToBookmark.CreateFmt(SOnGoToBookmark, [MDataSet.name]);
          end;
        end;
      end;
    end;

   list := TList.Create;

    s := MDataSet.Name;

    List.Add(pointer(s));

    AParent := AItem.Parent;
    if (AParent <> nil) and ((AParent as TElDBXTreeItem).DataField = 'That caption') then AParent := AParent.Parent;
    while AParent <> nil do
    begin
      MDataSet := DataSource.GetSetOnLevel(AParent.Level,DataSetOptions);
      s := MDataSet.Name;

      if List.IndexOf(pointer(s)) = -1 then
      begin
        List.Add(pointer(s));

        if (not (elDenyLookSetPosition in DataSetOptions)) and ((AParent as TElDBXTreeItem).Bookmark <> nil) and (MDataSet.Active) then
        begin
          try
            if ChangeTreeState then
              IsUpdating := False;
            MDataSet.GotoBookmark((AParent as TElDBXTreeItem).Bookmark);
            if ChangeTreeState then
              IsUpdating := True;
          except
            on E: exception do
            begin
              list.free;
              FChanging := OldChanging;
              IsUpdating := True;
              raise EOnGoToBookmark.CreateFmt(SOnGoToBookmark, [Mdataset.name]);
            end;
          end;
        end;
      end;
      AParent := AParent.Parent as TElDBXTreeItem
    end;
    list.free;
    FChanging := OldChanging;
  end;
end;

procedure TCustomElDBXTree.TriggerItemSelectedChangeEvent(AItem: TElXTreeItem);
begin
  inherited TriggerItemSelectedChangeEvent(AItem);
  if (csDestroying in ComponentState) then
    exit;
  if (not AItem.Selected) or ((AItem as TElDBXTreeItem).DataField = 'That caption') then Exit;
  NavigateInDataSet(AItem, True);
end;

procedure TCustomElDBXTree.TriggerLinkClickEvent(HRef: string; X, Y: integer);
var
  MItem: TElDBXTreeItem;
  LVirtStyle: TElXCellStyle;
begin
  MItem := Self.GetItemAtY(Y);
  if Assigned(MItem) then
  begin
    MItem.EditingField := Href;
    LVirtStyle := MItem.FVirtStyle;
    if MItem.GetDataSource <> nil then
      if MItem.GetDataSource.DataSet.FindField(Href) <> nil then
      begin
        case MItem.GetDataSource.DataSet.FieldByName(Href).DataType of
          ftBoolean: LVirtStyle.CellType := sftBool;
          ftString, ftWideString: LVirtStyle.CellType := sftText;
          ftMemo, ftFmtMemo: LVirtStyle.CellType := sftMemo;
          ftSmallint, ftInteger, ftWord, ftAutoInc, ftLargeInt: LVirtStyle.CellType := sftNumber;
          ftFloat: LVirtStyle.CellType := sftFloating;
          ftCurrency: LVirtStyle.CellType := sftCurrency;
          ftDate: LVirtStyle.CellType := sftDate;
          ftTime: LVirtStyle.CellType := sftTime;
          ftDateTime: LVirtStyle.CellType := sftDateTime;
          ftBlob: LVirtStyle.CellType := sftBLOB;
          ftGraphic: begin
              LVirtStyle.CellType := sftPicture;
            end;
          ftUnknown: LVirtStyle.CellType := sftCustom;
        else
          LVirtStyle.CellType := sftText;
        end;
      end;
    if TElXHackTreeView(Self.FView).FInpEdit <> nil then
    begin
      inherited;
      MItem.EditText;
    end;
  end;
end;

function TCustomElDBXTree.SizeToPixels(Value: Integer): integer;
var
  RestoreCanvas: Boolean;
  TM: TLMDTextMetric;
begin
  RestoreCanvas := not HandleAllocated;
  if RestoreCanvas then
    Canvas.Handle := GetDC(0);
  try
    Canvas.Font := Self.Font;
    LMDGetTextMetrics(Canvas.Handle, TM);
    Result := Value * (Canvas.TextWidth('0') - TM.tmOverhang)
      + TM.tmOverhang + 4;
  finally
    if RestoreCanvas then
    begin
      ReleaseDC(0,Canvas.Handle);
      Canvas.Handle := 0;
    end;
  end;
end;

function TCustomElDBXTree.ColumnWidth(ASectionIndex: integer; Level: Integer): integer;
var
  LField: TField;
  i: integer;
  DataSetOptions :TElXDataSetOptions;
begin
  Result := 0;
  if not Assigned(DataSource) then
    exit;
  if not LMDInRange(ASectionIndex, 0, HeaderSections.Count - 1) then
    exit;
  if Assigned(DataSource) and Assigned(DataSource.DataSet) then
  begin
    if ASectionIndex = MainTreeColumn then
    begin
      if Level = 0 then
      begin
        LField := DataSource.DataSet.FindField(DataSource.DataField);
        if Assigned(LField) then
          Result := max(Result, LField.DisplayWidth);
      end
      else
      begin
        i := DataSource.GetRelNoOnLevel(Level ,DataSetOptions);
        if i > -1 then
        begin
          LField := DataSource.Relations[i-1].DetailDataSet.FindField(DataSource.Relations[i-1].DetailDisplayField);
          if Assigned(LField) then
            Result := max(Result, LField.DisplayWidth);
        end;
      end;
    end
    else
    begin
      for i := 0 to StylesDefs.Count - 1 do
      begin
        if StylesDefs[i].DataFields.Count > 0 then
        begin
          LField := StylesDefs[i].DataLink.DataSet.FindField(StylesDefs[i].DataFields[ASectionIndex - 1]);
          if Assigned(LField) then
            Result := Result + LField.DisplayWidth
          else
            Result := HeaderSections[ASectionIndex].Width;
        end;
        break;
      end;
    end;
  end;
  Result := SizeToPixels(Result);
end;

function TCustomElDBXTree.MeasureColumnWidth(ColumnNum: Integer; VisibleOnly: Boolean): Integer;
begin
 // Result := ColumnWidth(ColumnNum);
 Result := inherited MeasureColumnWidth(ColumnNum, True);
end;

procedure TCustomElDBXTree.MeasureCell(Item: TElXTreeItem; ColumnNum: Integer; MaxWidth :Integer; var Size: TPoint);
begin
  Size := Point(0, LineHeight);
  Size.X := ColumnWidth(ColumnNum, Item.Level);
  if LMDInRange(ColumnNum, 0, HeaderSections.Count - 1) then
  begin
    if Assigned(Item.Cells[ColumnNum].Picture) then
      Size.X := Item.Cells[ColumnNum].Picture.Width;
    if ColumnNum = MainTreeColumn then
    begin
      if (FShowRoot and FShowLines) or (FShowButtons and FShowRootButtons) then
        Inc(Size.X, FItemIndent  * (Item.Level + 1))
      else
        Inc(Size.X, (FItemIndent div 5) * (Item.Level + 1));
    end;
  end;
  if (Size.X > MaxWidth) and Item.Multiline and Item.WordWrap then
    inherited MeasureCell(Item, ColumnNum, MaxWidth, Size);
end;

procedure TCustomElDBXTree.DoItemChecked(Item: TElXTreeItem);
var
  mitem: TElMTreeItem;
  MDataSet: TDataSet;
  DataSetOptions :TElXDataSetOptions;
begin
  mitem := (Item as TElDBXTreeItem).FMItem;
  if Assigned(mitem) then
  begin
    MDataSet := DataSource.GetSetOnLevel(Item.Level, DataSetOptions);
    if (Assigned(MDataSet)) and (MDataSet.Active) and (Assigned(TMData(mitem.Data).FBookmark )) then
    begin
      if (not (elDenyLookSetPosition in DataSetOptions)) then
      begin
        try
          if (Assigned(TMData(mitem.Data).FBookmark)) and (not MDataSet.ControlsDisabled) then
          begin
            MDataSet.GotoBookmark(TMData(mitem.Data).FBookmark);
            if TMData(mitem.Data).FCheckBoxFromBase then
            begin
//              MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs.Items[RelNum].CheckBox).asBoolean
              MDataSet.Edit;
              MDataSet.FieldByName(TMData(mitem.Data).FCheckBoxField).asBoolean := Item.Checked;
              MDataSet.CheckBrowseMode;
            end;
          end;
        except
          on E: exception do
          begin
            IsUpdating := True;
            raise EOnGoToBookmark.CreateFmt(SOnGoToBookmark, [MDataSet.name]);
          end;
        end;
      end;
    end;
  end;
  inherited;
end;

function TCustomElDBXTree.DataWidth: integer;
var
  LField: TField;
  i, j: integer;
begin
  Result := 0;
  if Assigned(DataSource) and Assigned(DataSource.DataSet) then
  begin
    LField := DataSource.DataSet.FindField(DataSource.DataField);
    if Assigned(LField) then
      Result := max(Result, LField.DisplayWidth);
    for i := 0 to DataSource.Relations.Count - 1 do
    begin
      if Length(DataSource.Relations[i].DetailDisplayField) > 0 then
      begin
        LField := DataSource.Relations[i].DetailDataSet.FindField(DataSource.Relations[i].DetailDisplayField);
        if Assigned(LField) then
          Result := max(Result, LField.DisplayWidth);
      end;
    end;
    for i := 0 to StylesDefs.Count - 1 do
    begin
      if StylesDefs[i].DataFields.Count > 0 then
      begin
        for j := 0 to StylesDefs[i].DataFields.Count - 1 do
        begin
          LField := StylesDefs[i].DataLink.DataSet.FindField(StylesDefs[i].DataFields[j]);
          if Assigned(LField) then
            Result := Result + LField.DisplayWidth;
        end;
        Break;
      end;
    end;
  end;
  Result := SizeToPixels(Result);
end;

{ TElDBXTreeView }
{
******************************** TElDBXTreeView ********************************
}
procedure TElDBXTreeView.DefineHRange;
begin
  FHRange := Owner.GutterWidth + (Owner as  TCustomElDBXTree).DataWidth;
end;

{ TElDBXTreeItems }

{
******************************** TElDBXTreeItems ********************************
}
function TElDBXTreeItems.Add(Item: TElXTreeItem; Text: TLMDString): TElXTreeItem;
begin
  Result := inherited Add(Item, Text);
end;

function TElDBXTreeItems.AddChild(Item: TElXTreeItem; Text: TLMDString):
        TElXTreeItem;
begin
  Result := inherited AddChild(Item, Text);
end;

function TElDBXTreeItems.AddChildFirst(Item: TElXTreeItem; Text: TLMDString):
        TElXTreeItem;
begin
  Result := inherited AddChildFirst(Item, Text);
end;

function TElDBXTreeItems.AddChildObject(Item: TElXTreeItem; Text: TLMDString;
        Ptr: Pointer): TElXTreeItem;
begin
  Result := inherited AddChildObject(Item, Text, Ptr);
end;

function TElDBXTreeItems.AddChildObjectFirst(Item: TElXTreeItem; Text: TLMDString;
        Ptr: Pointer): TElXTreeItem;
begin
  Result := inherited AddChildObjectFirst(Item, Text, Ptr);
end;

function TElDBXTreeItems.AddFirst(Item: TElXTreeItem; Text: TLMDString):
        TElXTreeItem;
begin
  Result := inherited AddFirst(Item, Text);
end;

function TElDBXTreeItems.AddItem(Parent: TElXTreeItem): TElXTreeItem;
begin
  Result := inherited AddItem(Parent);
end;

function TElDBXTreeItems.AddLastItem(Parent: TElXTreeItem): TElXTreeItem;
begin
  Result := inherited AddLastItem(Parent);
end;

function TElDBXTreeItems.AddObject(Item: TElXTreeItem; Text: TLMDString; Ptr:
        Pointer): TElXTreeItem;
begin
  Result := inherited AddObject(Item, Text, Ptr);
end;

function TElDBXTreeItems.AddObjectFirst(Item: TElXTreeItem; Text: TLMDString;
        Ptr: Pointer): TElXTreeItem;
begin
  Result := inherited AddObjectFirst(Item, Text, Ptr);
end;

procedure TElDBXTreeItems.Assign(Source: TPersistent);
begin
  //  nothing to do
end;

procedure TElDBXTreeItems.Delete(Item: TElXTreeItem);
begin
  DeleteItem(Item);
end;

procedure TElDBXTreeItems.DeleteItem(Child: TElXTreeItem);
begin
  (Child as TElDBXTreeItem).DeleteChild;
  Child.Delete;
end;

function TElDBXTreeItems.GetDBItem(Index: integer): TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(GetItem(Index));
end;

function TElDBXTreeItems.GetDBRootItem(Index: Integer): TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(GetRootItem(Index));
end;

function TElDBXTreeItems.GetDBVisItem(Index: integer): TElDBXTreeItem;
begin
  Result := TElDBXTreeItem(GetVisItem(Index));
end;

function TElDBXTreeItems.GetFirstNode: TElDBXTreeItem;
begin
  Result := (inherited GetFirstNode) as TElDBXTreeItem;
end;

function TElDBXTreeItems.Insert(Item: TElXTreeItem; Text: TLMDString):
        TElXTreeItem;
begin
  Result := inherited Insert(Item, Text);
end;

function TElDBXTreeItems.InsertAfter(Item: TElXTreeItem; Text: TLMDString):
        TElXTreeItem;
begin
  Result := inherited InsertAfter(Item, Text);
end;

function TElDBXTreeItems.InsertAfterObject(Item: TElXTreeItem; Text: TLMDString;
        Ptr: Pointer): TElXTreeItem;
begin
  Result := inherited InsertAfterObject(Item, Text, Ptr);
end;

function TElDBXTreeItems.InsertItem(Index: integer; Parent: TElXTreeItem):
        TElXTreeItem;
begin
  Result := inherited InsertItem(Index, Parent);
end;

function TElDBXTreeItems.InsertObject(Item: TElXTreeItem; Text: TLMDString; Ptr:
        Pointer): TElXTreeItem;
begin
  Result := inherited InsertObject(Item, Text, Ptr);
end;

procedure TElDBXTreeItems.LoadFromFile(FileName: string);
begin
  // nothing to do
end;

procedure TElDBXTreeItems.LoadFromStream(Stream: TStream);
begin
  // nothing to do
end;

procedure TElDBXTreeItems.LoadFromStringList(Strings: TStrings);
begin
  // nothing to do
end;

{$IFDEF LMD_UNICODE}
procedure TElDBXTreeItems.LoadFromWideStringList(Strings: TLMDWideStrings);
begin
  // nothing to do
end;
{$ENDIF}

procedure TElDBXTreeItems.SetItem(Index: Integer; Value: TElXTreeItem);
begin
  inherited SetItem(Index, Value);
end;

{$IFDEF LMD_UNICODE}
function TCustomElDBXTree.GetWideStringText(Field: TField): WideString;
var
  W: WideString;
begin
  with Field do
  begin
    w := Field.asString;
    if UnicodeMode = umForceUTF8 then
    begin
      if isNull then
      begin
        W := '';
      end
      else
      if LMDConvertUTF8toUTF16({$ifdef lmdcomp12}AnsiString{$endif}(DisplayText), W, strictConversion, false)  <> sourceIllegal then
      else
      begin
        if DataType = ftWideString then
          W := Value;
      end;
    end
    else
    if UnicodeMode = umFieldType then
    begin
      if isNull then
        W := ''
      else
      if DataType = ftWideString then
        W := Value;
    end
    else
    if UnicodeMode = umForceUnicode then
    begin
      if isNull then
        W := ''
      else
        if (DataType = ftWideString) then
          W := Value
        else
          if LMDConvertUTF8toUTF16({$ifdef lmdcomp12}AnsiString{$endif}(DisplayText), W, strictConversion, false) = sourceIllegal then
            W := Field.AsString;
    end;
  end;
  Result := W;
end;
//{$ELSE}
//function TCustomElDBXTree.GetWideStringText(Field: TField): String;
//begin
//  Result := Field.AsString;
//end;
{$ENDIF}

function TCustomElDBXTree.ParsePattern(Pattern: TLMDString; ADataSet: TDataSet): TLMDString;
const
  ElFTab = {$IFDEF LMD_UNICODE}WideChar(#9){$ELSE}#9{$ENDIF};
  ElFSpace = {$IFDEF LMD_UNICODE}WideChar(#32){$ELSE}#32{$ENDIF};
var
  tmp, field: TLMDString;
  P, Start:
  {$IFDEF LMD_UNICODE}
  PWideChar;
{$ELSE}
  PChar;
{$ENDIF}
  W: {$IFDEF LMD_UNICODE}
  WideString;
{$ELSE}
  String;
{$ENDIF}
{ TElDBXTreeView }
begin
  Result := '';
{$IFDEF LMD_UNICODE}
  if LMDWidePos('<html>', Pattern) <> 1 then EErrorInPattern.Create(SErrorInPattern);
{$ELSE}
  if Pos('<html>', Pattern) <> 1 then EErrorInPattern.Create(SErrorInPattern);
{$ENDIF}

{$IFDEF LMD_UNICODE}
  P := PWideChar(Pattern);
{$ELSE}
  P := PChar(Pattern);
{$ENDIF}
  Start := P;

  while P^ <> #0 do
  begin
    if (P^ = '<') then
    begin
      inc(P);
      if ((P^ = 'a') or (P^ = 'A')) and (((P + 1)^ = ElFTab) or ((P + 1)^ = ElFSpace)) then
      begin
        inc(P);
        // Skip space symbols
        while (P^ = ElFTab) or ((P)^ = ElFSpace) do Inc(P);
        if ((P^ = 'h') or (P^ = 'H')) then
          inc(P, 4)
        else
          EErrorInPattern.Create(SErrorInPattern);
        // Skip space symbols
        while (P^ = ElFTab) or ((P)^ = ElFSpace) do Inc(P);
        if P^ = '=' then
          inc(P)
        else
          EErrorInPattern.Create(SErrorInPattern);
        // Skip space symbols
        while (P^ = ElFTab) or ((P)^ = ElFSpace) do Inc(P);
        if P^ = '"' then
          inc(P)
        else
          EErrorInPattern.Create(SErrorInPattern);
        SetString(tmp, Start, P - Start);
        Result := Result + Tmp;
        Start := P;
        while (P^ <> '"') and (P^ <> #0) and (P^ <> '>') do inc(P);
        if P^ = '>' then EErrorInPattern.Create(SErrorInPattern);
        SetString(tmp, Start, P - Start);
        field := tmp;
        Result := Result + Tmp;
        Start := P;
        while (P^ <> #0) and (P^ <> '>') do inc(P);
        inc(P);
        SetString(tmp, Start, P - Start);
        Start := P;
        Result := Result + Tmp;
        if ADataSet.FindField(field) = nil then raise EErrorInPattern.Create(SErrorInPattern);
//***
        W := ADataSet.FieldByName(field).DisplayText;
        {$IFDEF LMD_UNICODE}
        if ADataSet.FieldByName(field).DataType in [ftString, ftWideString] then
          W := GetWideStringText(ADataSet.FieldByName(field));
        {$ENDIF}
        //***
//        Result := Result + ADataSet.FieldByName(field).DisplayText;
        Result := Result + W;
      end;
    end;
    if (P^ <> #0) then
      inc(P);
  end;
  SetString(Tmp, Start, P - Start);
  Result := Result + Tmp;
  end;

{ TElDBXTreeView }

{
******************************* TElXRelationsItem *******************************
}
constructor TElXRelationsItem.Create(ARelations: TElXRelations; AID : Integer);
begin
  inherited Create;
  FRelations := ARelations;
  FActiveOnLevel := -1;
  FActive := True;
  ID := AID;
  Name := 'Relation ' + IntToStr(AID);
  FMasterDataSource := TDataSource.Create((FRelations.GetOwner as TComponent));
//  FMasterDataSource.Name := (FRelations.GetOwner as TComponent).Name + 'MasterRel' + IntToStr(Round(Now));
  FDetailDataSource := TDataSource.Create((FRelations.GetOwner as TComponent));
//  FDetailDataSource.Name := (FRelations.GetOwner as TComponent).Name + 'DetailRel' + IntToStr(Round(Now));
  FDetailDataLink := TElXSourceDataLink.Create(FRelations.FElRelDataSource as TElXRelDataSource, Self);
  FDetailDataLink.DataSource := FDetailDataSource;
  FOwnFilter := '';
  FOwnFiltered := False;
  FRelations.FList.Add(Self);
  FRelations.FElRelDataSource.NotifyLinks(elRelAdded, Index);
end;

destructor TElXRelationsItem.Destroy;
begin
  if Assigned(FRelations) then
    FRelations.FList.Delete(FRelations.FList.IndexOf(Self));
  FRelations.FElRelDataSource.NotifyLinks(elRelDeleted, Index);
  FDetailDataLink.Free;
  FDetailDataLink := nil;
  FMasterDataSource.free;
  FDetailDataSource.free;
  inherited Destroy;
end;

procedure TElXRelationsItem.Assign(Source: TPersistent);
begin
  if Source is TElXRelationsItem then
    with Source as TElXRelationsItem do
    begin
      Self.FActive := FActive;
      Self.FOwnFilter := FOwnFilter;
      SElf.FOwnFiltered := FOwnFiltered;
      Self.FActiveOnLevel := FActiveOnLevel;
      Self.FDenyLookSetPosition := FDenyLookSetPosition;
      Self.FDetailDisplayField := FDetailDisplayField;
      self.FDetailField := FDetailField;
      self.FMasterField := FMasterField;
    end
  else
    inherited;
end;

procedure TElXRelationsItem.LoadFromStream(Stream: TStream);
var
  s : AnsiString;
begin
  LMDAnsiReadStringFromStream(Stream, s);
  FCaption := TLMDString(s);
  Stream.ReadBuffer(FShowCaption, SizeOf(FShowCaption));
  LMDAnsiReadStringFromStream(Stream, s);
  FMasterField := string(s);
  LMDAnsiReadStringFromStream(Stream, s);
  FDetailField := string(s);
  LMDAnsiReadStringFromStream(Stream, s);
  FDetailDisplayField := string(s);
  LMDAnsiReadStringFromStream(Stream, s);
  FName := string(s);
  Stream.ReadBuffer(FActive, SizeOf(FActive));
  Stream.ReadBuffer(FActiveOnLevel, SizeOf(FActiveOnLevel));
  Stream.ReadBuffer(FDenyLookSetPosition, SizeOf(FDenyLookSetPosition));
  Stream.ReadBuffer(ID, SizeOf(ID));
  FMasterDataSource := TDataSource(Stream.ReadComponent(nil));
  FDetailDataSource := TDataSource(Stream.ReadComponent(nil));
  if FDetailDataLink.DataSource <> FDetailDataSource then
    FDetailDataLink.DataSource := FDetailDataSource;
  if (csLoading in (FRelations.GetOwner as TElXRelDataSource).ComponentState) then
    FRelations.FElRelDataSource.NotifyLinks(elRelSetChanged, Index);
end;

procedure TElXRelationsItem.WriteToStream(Stream: TStream);
begin
  LMDAnsiWriteStringToStream(Stream, FCaption);
  Stream.WriteBuffer(FShowCaption, SizeOf(FShowCaption));
  LMDAnsiWriteStringToStream(Stream, AnsiString(FMasterField));
  LMDAnsiWriteStringToStream(Stream, AnsiString(FDetailField));
  LMDAnsiWriteStringToStream(Stream, AnsiString(FDetailDisplayField));
  LMDAnsiWriteStringToStream(Stream, AnsiString(FName));
  Stream.WriteBuffer(FActive, SizeOf(FActive));
  Stream.WriteBuffer(FActiveOnLevel, SizeOf(FActiveOnLevel));
  Stream.WriteBuffer(FDenyLookSetPosition, SizeOf(FDenyLookSetPosition));
  Stream.WriteBuffer(ID, SizeOf(ID));
  Stream.WriteComponent(FMasterDataSource);
  Stream.WriteComponent(FDetailDataSource);
end;

function TElXRelationsItem.GetIndex: Integer;
begin
  Result := FRelations.FList.IndexOf(Self);
end;

function TElXRelationsItem.GetDetailDataSet: TDataSet;
begin
  Result := FDetailDataSource.DataSet;
end;

function TElXRelationsItem.GetDetailDataSource: TDataSource;
begin
  Result := FDetailDataSource;
end;

function TElXRelationsItem.GetMasterDataSet: TDataSet;
begin
  Result := FMasterDataSource.DataSet;
end;

function TElXRelationsItem.GetMasterDataSource: TDataSource;
begin
  Result := FMasterDataSource;
end;

procedure TElXRelationsItem.SetAfterRefresh(ADataset: TDataSet);
begin
  FRelations.FElRelDataSource.NotifyLinks(elSetRelRefresh,Index);
  if Assigned(FAfterRefresh) then FAfterRefresh(ADataSet);
end;

procedure TElXRelationsItem.SetDenyLookSetPosition(Value: Boolean);
begin
  FDenyLookSetPosition := Value;
  FRelations.FElRelDataSource.NotifyLinks(elSetModify, Index);
end;

procedure TElXRelationsItem.SetDetailDataSet(ADataSet: TDataSet);
var
  pri: Boolean;
begin
  if FDetailDataSource.DataSet <> ADataSet then
  begin
    pri := false;
    if (csDesigning in FRelations.FElRelDataSource.ComponentState) and (not (csLoading in FRelations.FElRelDataSource.ComponentState)) then
    if FDetailField <> '' then
      if Assigned(ADataSet) then
      begin
       if ADataSet.DefaultFields then
        begin
          if not Assigned(ADataSet.FieldDefList.Find(FDetailField)) then
          begin
            FDetailField := '';
            pri := true;
         end;
        end
        else
        begin
          if not Assigned(ADataSet.FindField(FDetailField)) then
          begin
            FDetailField := '';
            pri := true;
          end;
        end;
       end;
    if (csDesigning in FRelations.FElRelDataSource.ComponentState) and (not (csLoading in FRelations.FElRelDataSource.ComponentState)) then
    if FDetailDisplayField <> '' then
      if Assigned(ADataSet) then
      begin
       if ADataSet.DefaultFields then
        begin
          if not Assigned(ADataSet.FieldDefList.Find(FDetailDisplayField)) then
          begin
            FDetailDisplayField := '';
            pri := true;
         end;
        end
        else
        begin
          if not Assigned(ADataSet.FindField(FDetailDisplayField)) then
          begin
            FDetailDisplayField := '';
            pri := true;
          end;
        end;
       end;
    FDetailDataSource.DataSet := ADataSet;
  //  FDetailDataLink.BufferCount := 20;
    if ADataSet <> nil then
    begin
      FOwnFilter := ADataSet.Filter;
      FOwnFiltered := ADataSet.Filtered;
    end
    else
    begin
      FOwnFilter := '';
      FOwnFiltered := false;
    end;
    if Assigned(ADataSet) then
    begin
      FAfterRefresh := FDetailDataSource.DataSet.AfterRefresh;
      FDetailDataSource.DataSet.AfterRefresh := Self.SetAfterRefresh;
    end
    else
    begin
      FAfterRefresh := nil;
    end;
    if pri or (csLoading in (FRelations.GetOwner as TElXRelDataSource).ComponentState) then
      FRelations.FElRelDataSource.NotifyLinks(elRelSetChanged, Index);
    FRelations.Changed;
  end;
end;

procedure TElXRelationsItem.SetDetailDisplayField(AField: TElXDetailDisplayField);
begin
  if (FDetailDisplayField <> AField) and Assigned(FDetailDataSource) then
  begin
    FDetailDisplayField := AField;
    FRelations.FElRelDataSource.NotifyLinks(elSetModify, Index);
  end;
end;

procedure TElXRelationsItem.SetDetailField(AField: TElXDetailField);
begin
  if (FDetailField <> AField) and Assigned(FDetailDataSource) then
  begin
    FDetailField := AField;
    FRelations.FElRelDataSource.NotifyLinks(elSetModify, Index);
  end;
end;

procedure TElXRelationsItem.SetMasterDataSet(ADataSet: TDataSet);
begin
  FMasterDataSource.DataSet := ADataSet;
  if (csDesigning in FRelations.FElRelDataSource.ComponentState) and (not (csLoading in FRelations.FElRelDataSource.ComponentState)) then
  if FMasterField <> '' then
    if Assigned(ADataSet) then
    begin
    if ADataSet.DefaultFields then
      begin
        if not Assigned(ADataSet.FieldDefList.Find(FMasterField)) then
          FMasterField := '';
      end
      else
      begin
        if not Assigned(ADataSet.FindField(FMasterField)) then
          FMasterField := '';
      end;
    end;

//  if pri or (csLoading in (FRelations.GetOwner as TElXRelDataSource).ComponentState) then
  if (csLoading in (FRelations.GetOwner as TElXRelDataSource).ComponentState) then
    FRelations.FElRelDataSource.NotifyLinks(elRelSetChanged, Index);
  FRelations.Changed;
end;

procedure TElXRelationsItem.SetMasterField(AField: TElXMasterField);
begin
  if (FMasterField <> AField) and Assigned(FmasterDataSource) then
  begin
    FMasterField := AField;
    FRelations.FElRelDataSource.NotifyLinks(elSetModify, Index);
  end;
end;

procedure TElXRelationsItem.SetCaption(const Value: TLMDString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    FRelations.FElRelDataSource.NotifyLinks(elSetModify, Index);
  end;
end;

procedure TElXRelationsItem.SetShowCaption(const Value: Boolean);
begin
  if FShowCaption <> Value then
  begin
    FShowCaption := Value;
    FRelations.FElRelDataSource.NotifyLinks(elSetModify, Index);
  end;
end;

// ?????? ??????? ? MasterDataSource ? DetailDataSource
// ( ???????? DBGrid1.DataSource:=ElRelDataSource.Relations[0].DataSource )

// TSourceDataLink

{
******************************* TSourceDataLink ********************************
}
constructor TElXSourceDataLink.Create(AElRelDataSource: TElXRelDataSource;
        AElRelationsItem: TElXRelationsItem);
begin
  FElRelDataSource := AElRelDataSource;
  FElRelationsItem := AElRelationsItem;
end;

procedure TElXSourceDataLink.ActiveChanged;
begin
  if FElRelationsItem = nil then
  begin
    if (csLoading in FElRelDataSource.ComponentState) or (not FElRelDataSource.FDenyLookSetPosition) then
    begin
      if Assigned(DataSet) and (DataSet.Active) then
      begin
        FCount := DataSet.RecordCount;
        if FElRelDataSource.FDataField <> '' then
          if DataSet.DefaultFields then
          begin
            if not Assigned(DataSet.FieldDefList.Find(FElRelDataSource.FDataField)) then
              FElRelDataSource.FDataField := '';
          end
          else
          begin
            if not Assigned(DataSet.FindField(FElRelDataSource.FDataField)) then
              FElRelDataSource.FDataField := '';
          end;
      end
      else
        FCount := 0;
      FElRelDataSource.NotifyLinks(elSetRelActive, -1);
    end;
  end
  else
    if (csLoading in FElRelDataSource.ComponentState) or (not FElRelationsItem.FDenyLookSetPosition) then
    begin
      if Assigned(DataSet) and (DataSet.Active) then
        FCount := DataSet.RecordCount
      else
        FCount := 0;
      FElRelDataSource.NotifyLinks(elSetRelActive, FElRelationsItem.Index);
    end;
end;

procedure TElXSourceDataLink.EditingChanged;
begin
  if Assigned(DataSet) and (DataSet.Active) and (DataSet.State = dsBrowse) then
  begin
    if (Assigned(FElRelationsItem) and (not FElRelationsItem.FDenyLookSetPosition)) then
    begin
      FElRelDataSource.NotifyLinks(elTreeNeedRefresh, FElRelationsItem.Index);
    end;
    if ((not Assigned(FElRelationsItem)) and (not FElRelDataSource.FDenyLookSetPosition)) then
    begin
      FElRelDataSource.NotifyLinks(elTreeNeedRefresh, -1)
    end;
  end;
end;

procedure TElXSourceDataLink.DataSetChanged;
begin
  inherited DataSetChanged;
  if Assigned(DataSet) and (DataSet.Active) and (DataSet.RecordCount <> FCount) then
  begin
    FCount := DataSet.RecordCount;
    if (Assigned(FElRelationsItem) and (not FElRelationsItem.FDenyLookSetPosition)) then
    begin
      FElRelDataSource.NotifyLinks(ELTreeNeedRefresh, FElRelationsItem.Index);
    end;
    if ((not Assigned(FElRelationsItem)) and (not FElRelDataSource.FDenyLookSetPosition)) then
    begin
      FElRelDataSource.NotifyLinks(ELTreeNeedRefresh, -1)
    end;
  end;
end;

// TElXRelations

{
********************************* TElXRelations *********************************
}
procedure TElXRelations.Assign(Source: TPersistent);

begin
  inherited;
  if Source is TElXRelations then
  begin
    FElRelDataSource := (Source as TElXRelations).FElRelDataSource;
    FList.Assign((Source as TElXRelations).FList);
    end;
end;

constructor TElXRelations.Create(AElRelDataSource: TElXRelDataSource);
begin
  inherited Create;
  FElRelDataSource := AElRelDataSource;
  FList := TList.Create;
end;

destructor TElXRelations.Destroy;
var
  FRItem: TElXRelationsItem;
begin
  while FList.Count>0 do
  begin
    FRItem := TElXRelationsItem(FList.Items[0]);
    FRItem.Destroy;
  end;
  FList.Free;
  FList := nil;
//  NotifyDesigner(Self, Self, opRemove);
  inherited;
end;

procedure TElXRelations.DefineProperties(Filer: TFiler);

  function DoWrite : Boolean;
  begin
    result := (Count > 0);
  end;

begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Items', LoadRelProperty, WriteRelProperty, True);
end;

procedure TElXRelations.LoadRelProperty(Stream: TStream);
var
  cc, i, ID : Integer;
  FRItem: TElXRelationsItem;
begin
  Stream.ReadBuffer(cc, SizeOf(Integer));
  for i := 0 to CC - 1 do
  begin
    Stream.ReadBuffer(ID, SizeOf(ID));
    FRItem := TElXRelationsItem.Create(Self,ID);
    FRItem.LoadFromStream(Stream);
  end
end;

procedure TElXRelations.WriteRelProperty(Stream: TStream);
var
  i, id : integer;
begin
  Stream.WriteBuffer(FList.Count, SizeOf(Integer));
  for i := 0 to Count - 1 do
  begin
    id := TElXRelationsItem(Items[i]).ID;
    Stream.WriteBuffer(ID,SizeOf(ID));
    TElXRelationsItem(Items[i]).WriteToStream(Stream);
  end
end;

procedure TElXRelations.AddItem(Index: integer);
begin
  TElXRelationsItem.Create(Self, Index);
end;

procedure TElXRelations.DeleteItem(Index: integer);
begin
  if Assigned(FList.items[index]) then
    TElXRelationsItem(FList.items[index]).Destroy;
end;

procedure TElXRelations.Changed;
var
  I: Integer;
  ritem: TElXRelationsItem;
  valid: Boolean;
begin
  valid := true;
  for i := 0 to Count - 1 do
  begin
    ritem := (items[i] as TElXRelationsItem);
    if (ritem.FMasterField = '') or (ritem.FDetailField = '') or (ritem.FDetailDisplayField = '') or (ritem.FMasterDataSource = nil) or (ritem.FDetailDataSource = nil) then valid := false;
  end;
  if not valid then exit;
  FElRelDataSource.NotifyLinks(elSetModify, 0);
end;

function TElXRelations.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TElXRelations.GetItem(Index: Integer): TElXRelationsItem;
begin
  Result := TElXRelationsItem(FList.Items[Index]);
end;

function TElXRelations.GetOwner: TPersistent;
begin
  Result := FElRelDataSource;
end;

procedure TElXRelations.SetItem(Index: Integer; Value: TElXRelationsItem);
begin
  Flist.Items[Index] := Value;
end;

// TElXRelDataSource

{
******************************* TElXRelDataSource *******************************
}
constructor TElXRelDataSource.Create(AOwner: TComponent);
begin

  inherited Create(AOwner);
  Exclude(FComponentStyle, csInheritable);

  FRootDataSource := TDataSource.Create(Self);
  FRootDataLink := TElXSourceDataLink.Create(Self, nil);
  FRootDataLink.DataSource := FRootDataSource;
  FRelations := TElXRelations.Create(Self);
  FFilter := '';
  FFiltered := false;
  FOwnFilter := '';
  FOwnFiltered := false;
  FTreeDataLinks := TList.Create;
  FCaption := '';
  FShowCaption := false;
end;

destructor TElXRelDataSource.Destroy;
var
  link: TElXTreeDataLink;
begin
  while FTreeDataLinks.Count > 0 do
  begin
    link := TElXTreeDataLink(FTreeDataLinks.Last);
    link.FTreeView.SetSource(nil);
  end;
  FRootDataLink.DataSource := nil;
  FRootDataLink.Free;
  FRootDataSource.Free;
  FTreeDataLinks.Clear;
  FTreeDataLinks.Free;
  FRelations.Destroy;
  inherited Destroy;
end;

procedure TElXRelDataSource.LoadCompProperty(Stream: TStream);
begin
  if Assigned(Relations) then
    Relations.LoadRelProperty(Stream);
end;

procedure TElXRelDataSource.StoreCompProperty(Stream: TStream);
begin
  if Assigned(Relations) then
    Relations.WriteRelProperty(Stream);
end;

function TElXRelDataSource.GetRootDataSet: TDataSet;
begin
  Result := FRootDataSource.DataSet;
end;

function TElXRelDataSource.GetRootDataSource: TDataSource;
begin
  Result := FRootDataSource;
end;

procedure TElXRelDataSource.NotifyLinks(Event: TElXCustomEvent; UserTag: integer);
var
  I: Integer;
  ritem: TElXRelationsItem;
  valid: Boolean;
begin
  valid := true;
  if UserTag > -1 then
  begin
    ritem := (Relations.items[UserTag] as TElXRelationsItem);
    if (ritem.FMasterField = '') or (ritem.FDetailField = '') or (ritem.FDetailDisplayField = '') or (ritem.FMasterDataSource = nil) or (ritem.FDetailDataSource = nil) then
      valid := false;
  end;
  //  if valid then valid := Enabled;
  if (UserTag > -1) and (UserTag < Relations.Count) and (Relations.items[UserTag] as TElXRelationsItem).FDenyLookSetPosition then
    valid := false;
  if (Event in [elRelDeleted, elRelAdded, elRelSetChanged, elSetRelActive]) then
    valid := true;
  if (UserTag = -1) and (RootDataField <> '') then
    valid := True;
  if not valid then exit;

  for I := FTreeDataLinks.Count - 1 downto 0 do
    if not (csLoading in ComponentState) then TElXTreeDataLink(FTreeDataLinks[i]).NotifyControl(Event, UserTag)
    else if (Event in [elSetRelActive, elRelSetChanged, elSetRelRefresh, ELTreeNeedRefresh]) then
      TElXTreeDataLink(FTreeDataLinks[i]).NotifyControl(Event, UserTag);
end;

//function TElXRelDataSource.ItemsExist(Level: Integer ; MasterField: string; MasterValue: TLMDString): Boolean;
//var
//  MDataSet: TDataSet;
//  bk: TBookmark;
//begin
//  if (Level = 0) and (Assigned(DataSet)) and (DataSet.Active) then
//  begin
//    Result := (DataSet.RecordCount > 0);
//  end
//  else
//  begin
//    MDataSet := GetSetOnLevel(Level);
//    if Assigned(MDataSet) and (MDataSet.Active) then
//    begin
//      bk := MDataSet.GetBookmark;
//      Result := MDataSet.Locate(Masterfield,MAsterValue,[]);
//      MDataSet.GotoBookmark(bk);
//      MDataSet.FreeBookmark(bk);
//    end
//    else
//      Result := False;
//  end;
//end;

function TElXRelDataSource.RecCountOnLevel(Level: Integer; MasterValue: TLMDString): integer;
var
  MDataSet: TDataSet;
  OldFilter: string;
  OldFiltered: Boolean;
  i: integer;
  bk: TBookmark;
  DataSetOptions :TElXDataSetOptions;
begin
//  bk := nil;
  if ((Level = 0) or ((Level = 1) and (Self.FShowCaption))) and (Assigned(DataSet)) and (DataSet.Active) then
  begin
    if (Level = 0) and Self.FShowCaption then
      Result := 1
    else
    begin
      if FFiltered then
      begin
        DataSet.DisableControls;
        bk := DataSet.GetBookmark;
        OldFilter := DataSet.Filter;
        OldFiltered := DataSet.Filtered;
        if FFiltered then
        begin
          if (Trim(FOwnFilter)<>'') and FOwnFiltered then
            DataSet.Filter := '(' + FOwnFilter + ')' + ' AND '+ '(' + FFilter + ')'
          else
            DataSet.Filter := FFilter;
          DataSet.Filtered := True;
        end;
        Result := DataSet.RecordCount;

        DataSet.Filtered := OldFiltered;
        DataSet.Filter := OldFilter;
        if Assigned(bk) and DataSet.BookmarkValid(bk) then
          DataSet.GotoBookmark(bk);
        DataSet.FreeBookmark(bk);
        DataSet.EnableControls;
      end
      else
        Result := DataSet.RecordCount;
    end;
  end
  else
  begin
    i := GetRelNoOnLevel(Level,DataSetOptions);
    if i = -1 then
    begin
      Result := 0;
      Exit;
    end;
    if (Relations[i-1].FShowCaption) and (elIsCaption in DataSetOptions) then
      Result := 1
    else
    begin
      MDataSet := Relations[i-1].GetDetailDataSet;
      if Assigned(MDataSet) and (MDataSet.Active) and (MasterValue <> '') and (Relations[i-1].FDetailField <> '') then
      begin
        MDataSet.DisableControls;
//        if not Relations[i-1].FDenyLookSetPosition then
        begin
          bk := MDataSet.GetBookmark;
        end;
        OldFilter := MDataSet.Filter;
        OldFiltered := MDataSet.Filtered;
        if (Trim(Relations[i-1].FOwnFilter)<>'') and Relations[i-1].FOwnFiltered then
          MDataSet.Filter := '(' + Relations[i-1].FOwnFilter + ')' + ' AND '+ '(' + Relations[i-1].FDetailField +'='+MasterValue+ ')'
        else
          MDataSet.Filter := Relations[i-1].FDetailField + '=' + MasterValue;
        MDataSet.Filtered := true;

        Result := MDataSet.RecordCount;

        MDataSet.Filtered := OldFiltered;
        MDataSet.Filter := OldFilter;
//        if not Relations[i-1].FDenyLookSetPosition then
        begin
          if Assigned(bk) and MDataSet.BookmarkValid(bk) then
            MDataSet.GotoBookmark(bk);
          MDataSet.FreeBookmark(bk);
        end;
        MDataSet.EnableControls;
      end
      else
        Result := 0;
    end;
  end;
end;

function TElXRelDataSource.GetRelNoOnLevel(Level: Integer; var DataSetOptions :TElXDataSetOptions): integer;
var
  i, j, start, step: integer;
  MName, IName: string;
begin
  DataSetOptions := [];
  Result := -1;
  if not Assigned(dataSet) then Exit;
  if (Level = 0) or (FShowCaption and (Level = 1)) then
  begin
    Result := 0;
    if FDenyLookSetPosition then
      DataSetOptions := [elDenyLookSetPosition];
    if (FShowCaption and (Level = 0)) then
      DataSetOptions := DataSetOptions + [elIsCaption];
  end
  else
  begin
    MName := DataSet.Name;
    if FShowCaption then
      start := 2
    else
      start := 1;
    step := 0;
    for j := start to level do
    begin
      if step = 1 then
      begin
        step := 0;
      end
      else
      begin
        IName := 'not assigned';
        for i := FRelations.Count - 1 downto 0 do
        begin
          if Assigned(Relations.Items[i].MasterDataSet) and Assigned(Relations.Items[i].DetailDataSet) then
            if (MName = FRelations.Items[i].MasterDataSet.Name)
              and (FRelations.Items[i].Active)
              and ((j = FRelations[i].ActiveOnLevel) or (FRelations[i].ActiveOnLevel = -1)) then
            begin
              if (j = level) or ((FRelations[i].FShowCaption) and (j+1 = level)) then
              begin
                Result := i + 1;
                if FRelations.Items[i].FDenyLookSetPosition then
                  DataSetOptions := [elDenyLookSetPosition]
                else
                  DataSetOptions := [];
                if (j = level) and (FRelations[i].FShowCaption) then
                  DataSetOptions := DataSetOptions + [elIsCaption];
              end;
              IName := FRelations.Items[i].DetailDataSet.Name;
              if FRelations[i].FShowCaption then
                step := 1
              else
                step := 0;
              if (j = FRelations[i].ActiveOnLevel) or (FRelations[i].FShowCaption and (j+1 = FRelations[i].ActiveOnLevel)) then
                Break;
            end;
        end;
        if Iname <> 'not assigned' then
          MName := IName
        else
        begin
          Result := -1;
          Exit;
        end;
      end;
    end;
  end;
end;

function TElXRelDataSource.GetSetOnLevel(Level: integer; var DataSetOptions :TElXDataSetOptions):TDataSet;
var
  i, j, start, step: integer;
  IName: integer;
  MSet: TDataSet;
begin
  DataSetOptions := [];
  Result := nil;
  if not Assigned(dataSet) then Exit;
  if (Level = 0) or (FShowCaption and (Level = 1)) then
  begin
    Result := DataSet;
    if FDenyLookSetPosition then
      DataSetOptions := [elDenyLookSetPosition];
    if (FShowCaption and (Level = 0)) then
      DataSetOptions := DataSetOptions + [elIsCaption];
  end
  else
  begin
    MSet := DataSet;
    if FShowCaption then
      start := 2
    else
      start := 1;
    step := 0;
    for j := start to level do
    begin
      if step = 1 then
      begin
        step := 0;
      end
      else
      begin
        IName := -1;
        for i := FRelations.Count - 1 downto 0 do
        begin
          if Relations.Items[i].MasterDataSet <> nil then
            if (MSet = FRelations.Items[i].MasterDataSet)
              and (FRelations.Items[i].Active)
              and ((j = FRelations[i].ActiveOnLevel) or (FRelations[i].ActiveOnLevel = -1)) then
            begin
              if (j = level) or ((FRelations[i].FShowCaption) and (j+1 = level)) then
              begin
                Result := FRelations.Items[i].DetailDataSet;
                if FRelations.Items[i].FDenyLookSetPosition then
                  DataSetOptions := [elDenyLookSetPosition]
                else
                  DataSetOptions := [];
                if (j = level) and (FRelations[i].FShowCaption) then
                  DataSetOptions := DataSetOptions + [elIsCaption];
              end;
              if Assigned(FRelations.Items[i].DetailDataSet) then
                IName := i;
              if FRelations[i].FShowCaption then
                step := 1
              else
                step := 0;
              if (j = FRelations[i].ActiveOnLevel) or (FRelations[i].FShowCaption and (j+1 = FRelations[i].ActiveOnLevel)) then
                Break;
            end;
        end;
        if Iname >= 0 then
          MSet := FRelations.Items[iname].DetailDataSet
        else
        begin
          Result := nil;
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TElXRelDataSource.RegisterLink(ALink: TElXTreeDataLink);
begin
  FTreeDataLinks.Add(ALink);
  if DataSet <> nil then ALink.FDataSetName := DataSet.Name
  else ALink.FDataSetName := '';
end;

procedure TElXRelDataSource.SetAfterRefresh(ADataset: TDataSet);
begin
  Self.NotifyLinks(elSetRelRefresh,-1);
  if Assigned(FAfterRefresh) then FAfterRefresh(ADataSet);
end;

procedure TElXRelDataSource.SetDataField(const Value: TElXDataField);
begin
  if FDataField <> Value then
  begin
    FDataField := Value;
    NotifyLinks(elSetModify, -1);
  end;
end;

procedure TElXRelDataSource.SetDenyLookSetPosition(Value: Boolean);
begin
  FDenyLookSetPosition := Value;
  NotifyLinks(elSetModify, -1);
end;

procedure TElXRelDataSource.SetCaption(const Value: TLMDString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    NotifyLinks(elSetModify, -1);
  end;
end;

procedure TElXRelDataSource.SetShowCaption(const Value: Boolean);
begin
  if FShowCaption <> Value then
  begin
    FShowCaption := Value;
    NotifyLinks(elSetModify, -1);
  end;
end;

procedure TElXRelDataSource.SetFilter(const Value: string);
begin
  if FFilter <> Value then
  begin
    FFilter := Value;
    NotifyLinks(elSetModify, -1);
  end;
end;

procedure TElXRelDataSource.SetFiltered(const Value: Boolean);
begin
  if FFiltered <> Value then
  begin
    FFiltered := Value;
    NotifyLinks(elSetModify, -1);
  end;
end;

procedure TElXRelDataSource.SetRelations(Value: TElXRelations);
begin
  FRelations.Assign(Value);
end;

procedure TElXRelDataSource.SetRootDataSet(ADataSet: TDataSet);
var
  i: Integer;
begin
  if FRootDataSource.DataSet <> ADataSet then
  begin
    if ((csDesigning in ComponentState) and (not (csLoading in ComponentState))) then
      if FDataField <> '' then
        if Assigned(ADataSet) then
        begin
          if ADataSet.DefaultFields then
          begin
            if not Assigned(ADataSet.FieldDefList.Find(FDataField)) then
              FDataField := '';
          end
          else
          begin
            if not Assigned(ADataSet.FindField(FDataField)) then
              FDataField := '';
          end;
          end;
    if ADataSet <> nil then
    begin
      FOwnFiltered := ADataSet.Filtered;
      FOwnFilter := ADataSet.Filter;
      for I := FTreeDataLinks.Count - 1 downto 0 do
      begin
        TElXTreeDataLink(FTreeDataLinks[i]).FDataSetName := ADataSet.Name;
      end;
    end
    else
    begin
      FOwnFiltered := false;
      FOwnFilter := '';
    end;
  FRootDataSource.DataSet := ADataSet;
//  FRootDataLink.BufferCount := 20;
  if Assigned(ADataSet) then
    begin
      FAfterRefresh := FRootDataSource.DataSet.AfterRefresh;
      FRootDataSource.DataSet.AfterRefresh := Self.SetAfterRefresh;
    end
    else
    begin
      FAfterRefresh := nil;
    end;
   NotifyLinks(elRelSetChanged, -1);
  end;
end;

procedure TElXRelDataSource.UnRegisterLink(ALink: TElXTreeDataLink);
begin
  FTreeDataLinks.Remove(ALink);
end;

{ TElMultiDataSource }

// TTreeDataLink

{
******************************* TElXTreeDataLink ********************************
}
constructor TElXTreeDataLink.Create(ATreeView: TCustomElDBXTree);
begin
  inherited Create;
  FTreeView := ATreeView;
  //  VisualControl := True;
  end;

procedure TElXTreeDataLink.NotifyControl(Event: TElXCustomEvent; UserTag:
        integer);
var
  item: TElXStylesdefsItem;
  i: Integer;
begin
  if (FTreeView.FSource <> nil) then
  begin
      case Event of
        elTreeNeedRepaint:
          FTreeView.Repaint;
        ELTreeNeedRefresh:
          FTreeView.Refresh;
        elRelDeleted:
          if not (csLoading in FTreeView.ComponentState) then
          begin
            FtreeView.FStylesDefs.Delete(UserTag+1);
            FTreeView.RebuildTree(true);
          end;
        elRelAdded:
        begin
          if not (csLoading in FTreeView.ComponentState) then
          begin
            FtreeView.FStylesDefs.FCanAppend := True;
            item := FTreeView.FStylesDefs.Add;
            item.FInDesign := true;
            FtreeView.FStylesDefs.FCanAppend := False;
//            FTreeView.RebuildTree(true);
          end;
        end;
        elSetRelRefresh:
          if (not FTreeView.FChanging) then
              FTreeView.RebuildTree(true);
        elSetRelActive:
          if (not FTreeView.FChanging) then
              FTreeView.RebuildTree(False);
        elSetModify:
          if not (csLoading in FTreeView.ComponentState) then
          begin
            if (not (csLoading in FTreeView.FSource.ComponentState)) and (not FTreeView.FChanging) then
              if ((FTreeView.FSource.DataSet <> nil) and (FTreeView.FSource.DataSet.Active)) then
                FTreeView.RebuildTree(False)
              else
                FTreeView.Items.Clear;
          end;
        elRelSetChanged:
        begin
          if (UserTag > -1) then
          begin
            i := UserTag + 1;
            if (FTreeView.DataSource.Relations[i-1].MasterDataSet <> nil) and (FTreeView.FSource.Relations[i-1].DetailDataSet <> nil) then
            begin
              FTreeView.FstylesDefs[i].FStyleCaption := 'Relation '+IntToStr(i-1)+' level: '+FTreeView.DataSource.Relations[i-1].MasterDataSet.Name+'-'+FTreeView.FSource.Relations[i-1].DetailDataSet.Name;
              FTreeView.FstylesDefs[i].FInDesign := false;
            end
            else
            begin
              FTreeView.FstylesDefs[i].FDataLink.DataSource := FTreeView.DataSource.Relations[i - 1].GetDetailDataSource;
              FTreeView.FstylesDefs[i].FStyleCaption := 'Relation ' + IntToStr(i - 1);
              FTreeView.FstylesDefs[i].FInDesign := true;
            end;
            FTreeView.FstylesDefs[i].FDataField := FTreeView.FSource.Relations[i - 1].DetailDisplayField;
            if (not (csLoading in FTreeView.FSource.ComponentState)) and (not (csLoading in FTreeView.ComponentState)) then
            begin
              FTreeView.FstylesDefs[i].UsePattern := false;
              FTreeView.FstylesDefs[i].Pattern := '';
              FTreeView.FstylesDefs[i].HintField := '';
              FTreeView.FstylesDefs[i].FCheckBox := '';
              FTreeView.FstylesDefs[i].FShowCheckBox := false;
              FTreeView.FstylesDefs[i].FOwnerHeight := True;
              FTreeView.FstylesDefs[i].FParentColors := True;
//              FTreeView.FstylesDefs[i].FParentStyle := True;
              FTreeView.FstylesDefs[i].FEnabled := True;
              FTreeView.FstylesDefs[i].FImagesFromBase := False;
              FTreeView.FstylesDefs[i].FImageIndex := -1;
              FTreeView.FstylesDefs[i].FImageIndex2 := -1;
              FTreeView.FstylesDefs[i].FStImageIndex := -1;
              FTreeView.FstylesDefs[i].FStImageIndex2 := -1;
              FTreeView.FstylesDefs[i].FAllowEdit := True;
              FTreeView.FstylesDefs[i].IsHTML := false;
            end;
           end
           else
           begin
             if Assigned(FTreeView.FSource.DataSet) then
               FDataSetNAme := FTreeView.FSource.DataSet.Name
             else
               FDataSetNAme := '';
             FTreeView.FstylesDefs[0].FStyleCaption := 'RootLevel';
             FTreeView.FstylesDefs[0].FDataField := FTreeView.DataSource.RootDataField;
            if ((Assigned(FTreeView.FstylesDefs[0].FDataLink.DataSet)) and (FTreeView.FstylesDefs[0].FDataLink.DataSet.Name <> FDataSetName)) and (not (csLoading in FTreeView.FSource.ComponentState)) and (not (csLoading in FTreeView.ComponentState)) then
            begin
             FTreeView.FstylesDefs[0].UsePattern := false;
             FTreeView.FstylesDefs[0].Pattern := '';
             FTreeView.FstylesDefs[0].HintField := '';
             FTreeView.FstylesDefs[0].FCheckBox := '';
             FTreeView.FstylesDefs[0].FShowCheckBox := false;
             FTreeView.FstylesDefs[0].FOwnerHeight := True;
             FTreeView.FstylesDefs[0].FParentColors := True;
//             FTreeView.FstylesDefs[0].FParentStyle := True;
             FTreeView.FstylesDefs[0].FEnabled := True;
             FTreeView.FstylesDefs[0].FImagesFromBase := False;
             FTreeView.FstylesDefs[0].FImageIndex := -1;
             FTreeView.FstylesDefs[0].FImageIndex2 := -1;
             FTreeView.FstylesDefs[0].FStImageIndex := -1;
             FTreeView.FstylesDefs[0].FStImageIndex2 := -1;
             FTreeView.FstylesDefs[0].FAllowEdit := True;
             FTreeView.FstylesDefs[0].FIsHTML := false;
            end;
           end;
           if not (csDestroying in FTreeView.ComponentState) then
             FTreeView.RebuildTree(False);
          end;
      end;
  end;
end;

//{
//**************************** TElDBXTreeInplaceEditor ****************************
//}
//
//function TElDBXTreeInplaceEditor.GetTree: TCustomElDBXTree;
//begin
//  Result := TCustomElDBXTree(inherited Tree);
//end;
//
//procedure TElDBXTreeInplaceEditor.SetTree(Value: TCustomElDBXTree);
//begin
//  inherited Tree := Value;
//end;
//
//procedure TElDBXTreeInplaceEditor.StartOperation;
//begin
//  Tree.Selected := FItem as TElDBXTreeItem;
//  inherited;
//end;
//
//procedure TElDBXTreeInplaceEditor.TriggerAfterCompleteOperation;
//begin
//  if Assigned(Tree.selected) then
//    Tree.TriggerItemSelectedChangeEvent(Tree.Selected);
//  if Assigned(FOnAfterCompleteOperation) then
//    OnAfterCompleteOperation(Self);
//end;

{
******************************* TMData *******************************
}

constructor TMData.Create(AOwner: TElDBXTreeItem);
var
  DataSetOptions : TElXDataSetOptions;
begin
  inherited Create;
  FTreeOwner := AOwner;
  FText := '';
  FRelIndex := FTreeOwner.Owner.DataSource.GetRelNoOnLevel(FTreeOwner.Level, DataSetOptions);
  FCells := TList.Create;
  FDataLink := TElMDataDataLink.Create(Self);
  FDataLink.DataSource := nil;
end;

destructor TMData.Destroy;
var
  mcd: TMTreeCellData;
begin
  if (FDataLink.DataSet <> nil) and (FBookmark <> nil) then
    FDataLink.DataSet.FreeBookmark(FBookmark);
  FDataLink.DataSource := nil;
  FDataLink.Free;
  FDataLink := nil;
  while FCells.Count > 0 do
  begin
    if Assigned(TMTreeCellData(FCells.Items[FCells.Count-1]).FCellPicture) then
    begin
      FTreeOwner.Cells[FCells.Count].Picture.free;
      TMTreeCellData(FCells.Items[FCells.Count-1]).FCellPicture.Free;
    end;
    mcd := TMTreeCellData(FCells[FCells.Count-1]);
    FCells.Delete(FCells.Count-1);
    mcd.Free;
  end;
  Fcells.Free;
  if Assigned(FPicture) then
  begin
    FTreeOwner.Cells[0].Picture.free;
    FPicture.Free;
  end;
  inherited;
end;

procedure TMData.SetEditingField(Value: string);
var
 MDataSet: TDataSet;
begin
  if (Value <> FEditingField) then
  begin
    FEditingField := Value;
    if (FRelIndex = 0) then
      MDataSet := FTreeOwner.Owner.DataSource.DataSet
    else
      MDataSet := FTreeOwner.Owner.DataSource.Relations[FrelIndex - 1].DetailDataSet;
    SetCellTypeOnFieldName(Value, MDataSet);
  end;
end;

procedure TMData.SetCellTypeOnFieldName(Value: string; MDataSet : TDataSet);
begin
  if (value = '') then
    FCellType := sftCustom
  else
  begin
    case MDataSet.FieldByName(Value).DataType of
      ftBoolean: FCellType := sftBool;
        ftString, ftWideString :
            FCellType := sftText;
        ftMemo, ftFmtMemo{$ifdef LMDCOMP10}, ftWideMemo{$endif}: FCellType := sftMemo;
      ftSmallint, ftInteger, ftWord, ftAutoInc, ftLargeInt: FCellType := sftNumber;
      ftFloat: FCellType := sftFloating;
      ftCurrency: FCellType := sftCurrency;
      ftDate: FCellType := sftDate;
      ftTime: FCellType := sftTime;
      ftDateTime: FCellType := sftDateTime;
      ftBlob: FCellType := sftBLOB;
      ftUnknown: FCellType := sftCustom;
    else
      FCellType := sftText;
    end;
    if MDataSet.FieldByName(FDataField).FieldKind = fkLookup then
      FCellType := sftEnum;
  end;
end;

procedure TMData.GetDataFromBase(MDataSet: TDataSet; RelNum: Integer);
begin
  if (FDataField = '') then
    FText := ''
  else
  begin
    if FTreeOwner.Owner.StylesDefs.Items[RelNum].UsePattern then
      FText := FTreeOwner.Owner.ParsePattern(FTreeOwner.Owner.StylesDefs.Items[RelNum].Pattern,MDataSet)
    else
    begin
    {$IFDEF LMD_UNICODE}
      if (MDataSet.FieldByName(FDataField).DataType in ([ftString, ftWideString])) then
      begin
        FText := FTreeOwner.Owner.GetWideStringText(MDataSet.FieldByName(FDataField));
      end
      else
        FText := MDataSet.FieldByName(FDataField).DisplayText;
    {$ELSE}
      FText := MDataSet.FieldByName(FDataField).DisplayText;
    {$ENDIF}
    end;
  end;
  if FTreeOwner.Owner.StylesDefs.Items[RelNum].ImagesFromBase then
  begin
    if FTreeOwner.Owner.StylesDefs.Items[RelNum].FImage <> '' then
    begin
      FImageIndex := MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs.Items[RelNum].FImage).asInteger;
      FImageIndexField := FTreeOwner.Owner.StylesDefs.Items[RelNum].FImage;
    end;
    if FTreeOwner.Owner.StylesDefs.Items[RelNum].FStImage <> '' then
    begin
      FStateImageIndex := MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs.Items[RelNum].FStImage).asInteger;
      FStImageIndexField := FTreeOwner.Owner.StylesDefs.Items[RelNum].FStImage;
    end;
    if FTreeOwner.Owner.StylesDefs.Items[RelNum].FImage2 <> '' then
    begin
      FImageIndex2 := MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs.Items[RelNum].FImage2).asInteger;
      FImageIndex2Field := FTreeOwner.Owner.StylesDefs.Items[RelNum].FImage2;
    end;
    if FTreeOwner.Owner.StylesDefs.Items[RelNum].FStImage2 <> '' then
    begin
      FStateImageIndex2 := MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs.Items[RelNum].FStImage2).asInteger;
      FStImageIndex2Field := FTreeOwner.Owner.StylesDefs.Items[RelNum].FStImage2;
    end;
  end;
  if FTreeOwner.Owner.StylesDefs.Items[RelNum].CheckBox <> '' then
  begin
    FCheckBoxFromBase := True;
    FCheckBoxField := FTreeOwner.Owner.StylesDefs.Items[RelNum].CheckBox;
    if MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs.Items[RelNum].CheckBox).asBoolean then
      FCheckBoxState := cbChecked
    else
      FCheckBoxState := cbUnchecked;
    if MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs.Items[RelNum].CheckBox).isNull then
    begin
      FCheckBoxState := cbGrayed;
    end;
  end
  else
    FCheckBoxFromBase := False;
  if FTreeOwner.Owner.StylesDefs.Items[RelNum].FHintField <> '' then
  {$IFDEF LMD_UNICODE}
    if (MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs.Items[RelNum].FHintField).DataType in ([ftString, ftWideString])) then
    begin
      FHint := FTreeOwner.Owner.GetWideStringText(MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs.Items[RelNum].FHintField));
    end
    else
      if (MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs.Items[RelNum].FHintField).DataType in ([ftMemo, ftFmtMemo{$ifdef LMDCOMP10}, ftWideMemo{$endif}])) then
        FHint := MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs.Items[RelNum].FHintField).AsString
      else
        FHint := MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs.Items[RelNum].FHintField).DisplayText;
  {$ELSE}
    FHint := MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs.Items[RelNum].FHintField).DisplayText;
  {$ENDIF}

  SetCellTypeOnFieldName(FDataField, MDataSet);

  if (FDataField <> '') and (MDataSet.FieldByName(FDataField).DataType = ftGraphic) then
  begin
    if (MDataSet.FieldByName(FDataField).IsBlob) then
    begin
      FHasPicture := true;
      if not Assigned(FPicture) then
        FPicture := TBitmap.Create;
      FPicture.Assign(MDataSet.FieldByName(FDataField));
      FOwnerHeight := false;
      FHeight := max(FPicture.Height+2,FTreeOwner.Owner.StylesDefs.Items[RelNum].FHeight);
    end;
  end;
  if FMasterField <> '' then
    if (MDataSet.FieldByName(FMasterField).DataType in [ftString, ftDate, ftTime, ftDateTime]) then
      FMasterValue := QuotedStr(MDataSet.FieldByName(FMasterField).AsString)
    else
      FMasterValue := MDataSet.FieldByName(FMasterField).AsString;
  FillColumnData(MDataSet,RelNum);
  if not FOwnerHeight then
  begin
    if (FTreeOwner.Height < FHeight) then
    begin

      with THackElXTreeItem(FTreeOwner) do
      begin
        FComplexHeight := (Word(FHeight) shl 16) or (FComplexHeight and $0000FFFF);
        SetOwnerHeight(false);
      end;

    end;
  end;
  if Assigned(FTreeOwner.TreeView.FOnItemCreated) then
    FTreeOwner.TreeView.FOnItemCreated(FTreeOwner);
end;

procedure TMData.FillColumnData(MDataSet: TDataSet; RelNum: Integer);
var
  i : integer;
  CellData : TMTreeCellData;
  isPicture: Boolean;
  UserData: Variant;
begin
  if FTreeOwner.Owner.StylesDefs[RelNum].FDataFields.Count > 0 then
  begin
    for i := 0 to (FTreeOwner.Owner.StylesDefs[RelNum].FDataFields.Count - 1) do
    begin
      if (i >= FCells.Count) then
      begin
        CellData := TMTreeCellData.Create;
        FCells.Add(CellData);
      end
      else
        CellData := TMTreeCellData(FCells.Items[i]);
      if FTreeOwner.Owner.StylesDefs[RelNum].FDataFields[i] <> 'empty column or defined by user' then
      begin
        if MDataSet.FindField(FTreeOwner.Owner.StylesDefs[RelNum].FDataFields[i]) <> nil then
        begin
          {$IFDEF LMD_UNICODE}
            if MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs[RelNum].FDataFields[i]).DataType in ([ftString, ftWideString]) then
            begin
              CellData.FCellText := FTreeOwner.Owner.GetWideStringText(MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs[RelNum].FDataFields[i]))
            end
            else
              CellData.FCellText := MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs[RelNum].FDataFields[i]).DisplayText;
          {$ELSE}
            CellData.FCellText := MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs[RelNum].FDataFields[i]).DisplayText;
          {$ENDIF}
          case MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs[RelNum].FDataFields[i]).DataType of
            ftBoolean: CellData.FCellType := sftBool;
              //ftString : CS.CellType := sftText;
            ftString, ftWideString:
                CellData.FCellType := sftText;
             ftMemo, ftFmtMemo{$ifdef LMDCOMP10}, ftWideMemo{$endif}: begin
                 CellData.FCellType := sftMemo;
                 if not Assigned(CellData.FCellPicture) then
                   CellData.FCellPicture := TBitmap.Create;
                 if MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs[RelNum].FDataFields[i]).IsNull then
                   CellData.FCellPicture.Assign(FMemoNullBitmap)
                else
                   CellData.FCellPicture.Assign(FMemoBitmap);
                 CellData.FHeight := CellData.FCellPicture.Height;
               end;
            ftSmallint, ftInteger, ftWord, ftAutoInc, ftLargeInt: CellData.FCellType := sftNumber;
            ftFloat: CellData.FCellType := sftFloating;
            ftCurrency: CellData.FCellType := sftCurrency;
            ftDate: CellData.FCellType := sftDate;
            ftTime: CellData.FCellType := sftTime;
            ftDateTime: CellData.FCellType := sftDateTime;
            ftBlob: CellData.FCellType := sftBLOB;
            ftGraphic, ftTypedBinary: begin
                if MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs[RelNum].FDataFields[i]).IsBlob then
                begin
                  CellData.FCellType := sftPicture;
                  if not Assigned(CellData.FCellPicture) then
                    CellData.FCellPicture := TBitmap.Create;
                  CellData.FCellPicture.Assign(MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs[RelNum].FDataFields[i]));
//                  Child.OwnerHeight := false;
                  CellData.FHeight := CellData.FCellPicture.Height;
                  FHeight := max(FHeight,CellData.FHeight);
                  FOwnerHeight := false;
                end
                else
                CellData.FCellType := sftCustom;;
              end;
            ftUnknown: CellData.FCellType := sftCustom;
          else
            CellData.FCellType := sftText;
          end;
          if MDataSet.FieldByName(FTreeOwner.Owner.StylesDefs[RelNum].FDataFields[i]).FieldKind = fkLookup then
            CellData.FCellType := sftEnum;
        end
        else
        begin
          CellData.FCellText := ' field not found ';
          CellData.FCellType := sftText;
        end;
      end
      else
      begin
        // column defined by user
        if Assigned(FTreeOwner.Owner.FOnCustomColumnDataNeed) then
        begin
          IsPicture := False;
          UserData := Unassigned;
          if Assigned(FOwner.Parent) then
            FTreeOwner.Owner.FOnCustomColumnDataNeed(Self, '', RelNum, i+1, UserData, IsPicture)
          else
            FTreeOwner.Owner.FOnCustomColumnDataNeed(Self, TMData(FOwner.Parent.Data).FMasterValue , RelNum, i+1, UserData, IsPicture);
          if not ((VarIsEmpty(UserData)) or (VarIsNull(UserData))) then
          begin
            CellData.FCellText := WideString(UserData);
            case VarType(UserData) of
              varBoolean: CellData.FCellType := sftBool;
              varString, varOleStr: CellData.FCellType := sftText;
              varSmallint , varShortInt, varWord, varLongWord : CellData.FCellType := sftNumber;
              varSingle, varDouble: CellData.FCellType := sftFloating;
              varCurrency: CellData.FCellType := sftCurrency;
              varDate: CellData.FCellType := sftDate;
              varInteger: begin
                  if IsPicture then
                  begin
                    CellData.FCellType := sftPicture;
                    if not Assigned(CellData.FCellPicture) then
                      CellData.FCellPicture := TBitmap.Create;

                    CellData.FCellPicture.Assign(TBitmap(TLMDPtrInt(UserData)));

                    CellData.FHeight := CellData.FCellPicture.Height;
                    FHeight := max(FHeight,CellData.FHeight);
                    FOwnerHeight := false;
                  end
                  else
                  CellData.FCellType := sftNumber;
                end;

              varUnknown: CellData.FCellType := sftCustom;

              else
              begin
//                CellData.FCellText :=' ';
                CellData.FCellType := sftText;
                FTreeOwner.Owner.HeaderSections[i+1].Editable := False;
              end;
            end;
          end
          else
          begin
            CellData.FCellText :=' ';
            CellData.FCellType := sftText;
          end;
        end
        else
        begin
          CellData.FCellText :=' ';
          CellData.FCellType := sftText;
          FTreeOwner.Owner.HeaderSections[i+1].Editable := False;
        end;
      end;
    end;
  end;
end;

function TMData.GetValue(ValName: TValName): variant;
var
 MDataSet: TDataSet;
 bk: TBookmark;
begin
  if not (FDataField = 'That caption') then
  begin
    if Assigned(FBookmark) and (FText = '') then
    begin
      if FRelIndex = 0 then
        MDataSet := FTreeOwner.Owner.DataSource.DataSet
      else
      MDataSet := FTreeOwner.Owner.DataSource.Relations[FRelIndex - 1].DetailDataSet;
      if MDataSet.BookmarkValid(FBookmark) then
      begin
        MDataSet.DisableControls;
        bk := MDataSet.GetBookmark;
        MDataSet.GotoBookmark(FBookmark);
        GetDataFromBase(MDataSet, FRelIndex);
        MDataSet.GotoBookmark(bk);
        MDataSet.FreeBookmark(bk);
        MDataSet.EnableControls;
        Result := '1';
      end
      else
      begin
        FBookmark := nil;
        result := null;
//        exit;
      end;
    end
    else
      Result := null;
    if Result = null then
    begin
      if not Assigned(FBookmark) then
      begin
        if Assigned(FOwner.Parent.parent) then
        begin
          if (FOwner.Parent.List.IndexOf(FOwner) = 0) {or (Assigned(FTree.GetNextSibling(FOwner)) and (TMData(FTree.GetNextSibling(FOwner).Data).FText = ''))} then
            FTree.GetDataForChildrens(FOwner.Parent,0,min(FOwner.Parent.List.Count,FTree.RowCount))
          else
            FTree.GetDataForChildrens(FOwner.Parent,FOwner.Parent.List.IndexOf(FOwner),FOwner.Parent.List.IndexOf(FOwner))
        end
        else
        begin
          if (Assigned(FtreeOwner) and (FTreeOwner.VisIndex=0)) then
            FTree.RebuildTree
          else
            if (Assigned(FTree.GetNextSibling(FOwner)) and (TMData(FTree.GetNextSibling(FOwner).Data).FText = '')) then
              FTree.GetDataForChildrens(nil,FTree.Root.List.IndexOf(FOwner), min(FTree.Root.List.IndexOf(FOwner)+Ftree.RowCount,FTree.Root.List.Count))
            else
              FTree.GetDataForChildrens(nil,FTree.Root.List.IndexOf(FOwner),FTree.Root.List.IndexOf(FOwner));
        end;
      end;
    end;
  end;
  case ValName of

    vnCellType: result := FCellType;

    vnHint: result := FHint;
    vnDataField: result := FDataField;
    vnDetailField: result := FDetailField;
    vnMasterField: result := FMasterField;
    vnMasterValue: result := FMasterValue;
    vnText: result := FText;
    vnMarker: result := FMarker;
    vnHasPicture: result := FHasPicture;
    vnCheckBoxField: result := FCheckBoxField;
    vnCheckBoxFromBase: result := FCheckBoxFromBase;
    vnImageIndex2: result := FImageIndex2;
    vnImageIndex: result := FImageIndex;
    vnImagesFromBase: result := FImagesFromBase;
    vnRelIndex: result := FRelIndex;
    vnStateImageIndex2: result := FStateImageIndex2;
    vnStateImageIndex: result := FStateImageIndex;

    vnCheckBoxState: result := FCheckBoxState;

    vnOwnerHeight: result := FOwnerHeight;
    vnHeight: result := FHeight;
    vnImageIndexField: result := FImageIndexField;
    vnImageIndex2Field: result := FImageIndex2Field;
    vnStImageIndexField: result := FStImageIndexField;
    vnStImageIndex2Field: result := FStImageIndex2Field;
    else Result := null;
  end;
end;

{
******************************* TElMDBTree *******************************
}

procedure TElMDBTree.RebuildTree;
var
  it: TElDBXTreeItem;
  start, stop: integer;
begin
  it := Tree.Items.GetDBVisItem(0);
  start := 0;
  if Assigned(it) then
  begin
    while Assigned(it) do
    begin
      start := it.AbsoluteIndex;
      it := it.Parent;
    end;
  end;
  stop := start + RowCount;
  FTree.Items.BeginUpdate;
  GetDataForChildrens(nil,start,stop);
  Ftree.Items.EndUpdate;

  FTree.FView.DefineHRange;

end;

procedure TElMDBTree.RefreshData;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    TMData(Item[i].Data).FBookmark := nil;
  end;
end;

procedure TElMDBTree.Clear;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
  begin
    TMData(Item[i].Data).Free;
  end;
  inherited;
end;

function TElMDBTree.GetRowCount: Integer;
begin
  if Assigned(Tree) then
    Result := 2*(Tree.Height div Tree.LineHeight)
  else
    Result := 0;
end;

procedure TElMDBTree.GetDataForChildrens(Parent: TElMTreeItem; StartIndex, StopIndex: integer);
var
  i, j, mindex: integer;
  MDataSet: TDataSet;
  bk: TBookmark;
  OldFilter: string;
  OldState: TDataSetState;
  OldFiltered: Boolean;
  DataSetOptions :TElXDataSetOptions;
  mitem, mitem1: TElMTreeItem;
begin
  FTree.Items.BeginUpdate;
  OldFilter :='';
//  OldFiltered := false;
//  OldState := dsBrowse;
  i := Tree.DataSource.GetRelNoOnLevel(GetLevel(Parent) + 1,DataSetOptions);
//  bk := nil;
  if i = -1 then
    Exit;
  mitem := nil;
  if Assigned(Parent) then
    mitem := TElMTreeItem(Parent.list[StartIndex])
  else
    if StartIndex < Root.List.Count then
      mitem := TElMTreeItem(root.list[StartIndex]);
  if (elIsCaption in DataSetOptions) then
  begin
    if (TMData(mitem.Data).FDataField <> 'That caption') then
    begin
      TMData(mitem.Data).FDataField := 'That caption';
      TMData(mitem.Data).FRelIndex := i;
      if Assigned(Parent) and Assigned(Parent.parent) then
        TMData(mitem.Data).FMasterValue := TMData(Parent.Data).FMasterValue;
      CheckActualChildrensCount(mitem);
    end;
    case i of
    0: TMData(mitem.Data).FText := Tree.DataSource.FCaption;
    else
      TMData(mitem.Data).FText := Tree.DataSource.Relations[i-1].FCaption;
    end;
    if Tree.Items[GetAbsIndex(mitem)].Expanded and Tree.Items[GetAbsIndex(mitem)].HasChildren then
    begin
      GetDataForChildrens(mitem,0,mitem.List.Count);
    end;
  end
  else
  begin
    case i of
      0 : MDataSet := Tree.DataSource.GetRootDataSet;
      else MDataSet := Tree.DataSource.Relations[i-1].GetDetailDataSet;
    end;
//    if not (elDenyLookSetPosition in DataSetOptions) then
//    begin
    MDataSet.DisableControls;
    bk := MDataSet.GetBookmark;
    OldState := MDataSet.State;
    OldFilter := MDataSet.Filter;
    OldFiltered := MDataSet.Filtered;
    MDataSet.Filtered := False;

    if Assigned(Parent) then
      mindex := Parent.List.IndexOf(mitem)
    else
      mindex := root.List.IndexOf(mitem);
    while Assigned(mitem) and (mindex <= StopIndex) and (Assigned(TMData(mitem.Data).FBookmark)) do
    begin
      if MDataSet.BookmarkValid(TMData(mitem.Data).FBookmark) then
      begin
        MDataSet.GotoBookmark(TMData(mitem.Data).FBookmark);
        TMData(mitem.data).GetDataFromBase(MDataSet, i);
        CheckActualChildrensCount(mitem);
        if Tree.Items[GetAbsIndex(mitem)].Expanded and Tree.Items[GetAbsIndex(mitem)].HasChildren then
        begin
          GetDataForChildrens(mitem,0,mitem.List.Count - 1);
        end;
        mitem := GetNextSibling(mitem);
        mindex := mindex + 1;
      end
      else
      begin
        mitem1 := GetNextSibling(mitem);
        Tree.Items[GetAbsIndex(mitem)].Delete;
        mitem := mitem1;
      end;
    end;
//    end;
    j := Tree.DataSource.GetRelNoOnLevel(GetLevel(Parent) + 2,DataSetOptions);

    if Assigned(Parent) then
      mindex := Parent.List.IndexOf(mitem)
    else
      mindex := root.List.IndexOf(mitem);
    if Assigned(mitem) and (mindex <= StopIndex) then
    begin
      TMData(mitem.Data).FRelIndex := i;
      if (i = 0) then
      begin
        if Tree.DataSource.FFiltered then
        begin
          TMData(mitem.Data).FDataField := Tree.DataSource.FDataField;
          TMData(mitem.Data).FEditingField := Tree.DataSource.FDataField;
          if (Trim(Tree.DataSource.FOwnFilter)<>'') and Tree.DataSource.FOwnFiltered then
            MDataSet.Filter := '(' + Tree.DataSource.FOwnFilter + ')' + ' AND '+ '(' + Tree.DataSource.Filter + ')'
          else
            MDataSet.Filter := Tree.DataSource.FFilter;
          MDataSet.Filtered := True;
        end;
      end
      else
      begin
        TMData(mitem.Data).FDataField := Tree.DataSource.Relations[i-1].FDetailDisplayField;
        TMData(mitem.Data).FEditingField := Tree.DataSource.Relations[i-1].FDetailDisplayField;
        TMData(mitem.Data).FDetailField := Tree.DataSource.Relations[i-1].FDetailField;
        if Assigned(Tree.FOnActivateLevel) and (TMData(mitem.Parent.data).FMasterValue <> '') then
        begin
          if Assigned(Parent) then
            Tree.NavigateInDataSet(TMData(mitem.Parent.data).FTreeOwner, False);
          MDataSet.EnableControls;
          Tree.FOnActivateLevel(Tree, TMData(mitem.Parent.data).FMasterValue, TMData(mitem.data).FRelIndex-1);
          MDataSet.DisableControls;
        end
        else
        begin
          try
            if (Trim(Tree.DataSource.Relations[i-1].FOwnFilter)<>'') and Tree.DataSource.Relations[i-1].FOwnFiltered then
              MDataSet.Filter := '(' + Tree.DataSource.Relations[i-1].FOwnFilter + ')' + ' AND '+ '(' + TMData(mitem.Data).FDetailField+'='+TMData(mitem.Parent.data).FMasterValue+ ')'
            else
              MDataSet.Filter := TMData(mitem.Data).FDetailField+'='+TMData(mitem.Parent.data).FMasterValue;
            MDataSet.Filtered := true;
          except
            on E: EDataBaseError do
            begin
              MDataSet.Filter := OldFilter;
              MDataSet.Filtered := OldFiltered;
//              MDataSet.Active := True;
              if Assigned(Bk) then
              begin
                MDataSet.GotoBookmark(bk);
                MDataSet.FreeBookmark(bk);
              end;
              MDataSet.EnableControls;
              if OldState = dsEdit then MDataset.Edit;
              raise EOnErrorInRelation.CreateFmt(SOnErrorInRelation, [i]);
            end;
          end;
        end;
      end;
      if MDataSet.Active then
      begin
        MDataSet.First;
        MDataSet.MoveBy(mindex);
      end;
      while Assigned(mitem) and (mindex <= StopIndex) and (MDataSet.Active)
      do
      begin
        case i of
          0  :
            begin
              TMData(mitem.Data).FDataField := Tree.DataSource.FDataField;
              TMData(mitem.Data).FEditingField := Tree.DataSource.FDataField;
            end;
          else
            begin
              TMData(mitem.Data).FDataField := Tree.DataSource.Relations[i-1].FDetailDisplayField;
              TMData(mitem.Data).FEditingField := Tree.DataSource.Relations[i-1].FDetailDisplayField;
              TMData(mitem.Data).FDetailField := Tree.DataSource.Relations[i-1].FDetailField;
            end;
        end;
        if j > 0 then
        begin
          TMData(mitem.Data).FMasterField := Tree.DataSource.Relations[j-1].FMasterField;
        end
        else
          TMData(mitem.Data).FMarker := True;
        TMData(mitem.Data).FBookmark := MDataSet.GetBookmark;
        case i of
          0 : TMData(mitem.Data).FDataLink.DataSource := Tree.DataSource.FRootDataSource;
          else TMData(mitem.Data).FDataLink.DataSource := Tree.DataSource.Relations[i-1].FDetailDataSource;
        end;
        TMData(mitem.data).GetDataFromBase(MDataSet, i);
        CheckActualChildrensCount(mitem);
        if Tree.Items[GetAbsIndex(mitem)].Expanded and Tree.Items[GetAbsIndex(mitem)].HasChildren then
        begin
          GetDataForChildrens(mitem,0,mitem.List.Count - 1);
        end;
        mitem := GetNextSibling(mitem);
        mindex := mindex + 1;
        if (not MDataSet.Eof) then
          MDataSet.Next
        else mindex := StopIndex + 1;
      end;
    end;
//    if not (elDenyLookSetPosition in DataSetOptions) then
    begin
      MDataSet.Filtered := OldFiltered;
      MDataSet.Filter := OldFilter;
      if Assigned(bk) and MDataSet.BookmarkValid(bk) then
        MDataSet.GotoBookmark(bk);
      MDataSet.FreeBookmark(bk);
    end;
    MDataSet.EnableControls;
  end;
  FTree.Items.EndUpdate;
  Tree.invalidate;
end;

procedure TElMDBTree.CheckActualChildrensCount(AParent: TElMTreeItem);
var
  j, k, i, l, ck: integer;
  mitem: TElMTreeItem;
  data: TMData;
  it: TElXTreeItem;
  begin
  j := DBChildrensCount(aParent);
  ck := aparent.List.Count;
  if (j <> ck) then
  begin
    if ck > 0 then
    begin
      for k := 0 to (ck - 1) do
      begin
        if Assigned(TMData((TElMTreeItem(aparent.List[k])).Data).FBookmark) then
        begin
          TMData((TElMTreeItem(aparent.List[k])).Data).FDataLink.DataSet.FreeBookmark(TMData((TElMTreeItem(aparent.List[k])).Data).FBookmark);
          end;
        TMData((TElMTreeItem(aparent.List[k])).Data).FBookmark := nil;
        TMData((TElMTreeItem(aparent.List[k])).Data).FDataLink.DataSource := nil;
      end;
    end;
    if (j < ck) then
    begin
      for i := j to (ck-1) do
      begin
        TMData((TElMTreeItem(aparent.List[j])).Data).FTreeOwner.Delete;
      end;
    end
    else
    begin
      if (j > 0) then
      begin
        k := Tree.Items.Count;
        j := j - ck;
        Tree.Items.BeginUpdate;
        Tree.Items.AllocateStorage(k + j);
        TMData(aparent.Data).FTreeOwner.AllocateStorage(j + k);
        for l := 0 to j - 1 do
        begin
          it := Tree.Items.AddChild(TMData(aparent.Data).FTreeOwner,'') ;
          Data := TMData.Create(TElDBXTreeItem(it));
          mitem := AddItem(aparent,Data);
          Data.FOwner := mitem;
          Data.FTree := Self;
          data.FTreeOwner := TElDBXTreeItem(it);
          (it as TElDBXTreeItem).FMItem := mitem;
        end;
        Tree.Items.EndUpdate;

        if Tree.SortSection <> -1 then

          Tree.Sort(True);
      end;
    end;
    if not Tree.IsUpdating then
      Tree.Repaint;
  end;
end;

function TElMDBTree.DBChildrensCount(Parent: TElMTreeItem): integer;
var
  MDataSet: TDataSet;
  OldFilter: string;
  OldFiltered: Boolean;
  i: integer;
  bk: TBookmark;
  DataSetOptions :TElXDataSetOptions;
begin
//  bk := nil;
  if (TMData(parent.Data).FMasterValue = '') and ( not (TMData(parent.Data).FDataField ='That caption')) then
    Result := 0
  else
  begin
    if (TMData(parent.Data).FRelIndex = 0) and ((TMData(parent.Data).FDataField ='That caption')) then
    begin
      if Assigned(Tree.DataSource.DataSet) and (Tree.DataSource.DataSet.Active or Tree.DataSource.FDenyLookSetPosition) then
        if (Tree.DataSource.FFiltered) then
        begin
          Tree.DataSource.DataSet.DisableControls;
          bk := Tree.DataSource.DataSet.GetBookmark;
          OldFilter := Tree.DataSource.DataSet.Filter;
          OldFiltered := Tree.DataSource.DataSet.Filtered;
          if Tree.DataSource.FFiltered then
          begin
            if (Trim(Tree.DataSource.FOwnFilter)<>'') and Tree.DataSource.FOwnFiltered then
              Tree.DataSource.DataSet.Filter := '(' + Tree.DataSource.FOwnFilter + ')' + ' AND '+ '(' + Tree.DataSource.FFilter + ')'
            else
              Tree.DataSource.DataSet.Filter := Tree.DataSource.FFilter;
            Tree.DataSource.DataSet.Filtered := True;
          end;
          Result := Tree.DataSource.DataSet.RecordCount;

          Tree.DataSource.DataSet.Filtered := OldFiltered;
          Tree.DataSource.DataSet.Filter := OldFilter;
          Tree.DataSource.DataSet.GotoBookmark(bk);
          Tree.DataSource.DataSet.FreeBookmark(bk);
          Tree.DataSource.DataSet.EnableControls;
        end
        else
          Result := Tree.DataSource.DataSet.RecordCount
      else
        Result := 0;
    end
    else
    begin
      i := Tree.DataSource.GetRelNoOnLevel(GetLevel(parent)+1,DataSetOptions);;
      if i = -1 then
      begin
        Result := 0;
        Exit;
      end;
      if (Tree.DataSource.Relations[i-1].FShowCaption) and (elIsCaption in DataSetOptions) then
        Result := 1
      else
      begin
        MDataSet := Tree.DataSource.Relations[i-1].GetDetailDataSet;
        if Assigned(MDataSet) and (MDataSet.Active or Tree.DataSource.Relations[i-1].FDenyLookSetPosition) and (TMData(parent.Data).FMasterValue <> '') then
        begin
          MDataSet.DisableControls;
//          if not Tree.DataSource.Relations[i-1].FDenyLookSetPosition then
          begin
            bk := MDataSet.GetBookmark;
          end;
          OldFilter := MDataSet.Filter;
          OldFiltered := MDataSet.Filtered;

          if Assigned(Tree.FOnActivateLevel) and (TMData(parent.Data).FMasterValue <> '') then
          begin
            MDataSet.EnableControls;
            Tree.FOnActivateLevel(Tree, TMData(parent.Data).FMasterValue, i-1);
            MDataSet.DisableControls;
          end
          else
          begin
            if (Trim(Tree.DataSource.FOwnFilter) <> '') and (Tree.DataSource.FOwnFiltered) then
              MDataSet.Filter := '(' + Tree.DataSource.FOwnFilter + ')' + ' AND ' + Tree.DataSource.Relations[i-1].FDetailField + '=' + TMData(parent.Data).FMasterValue
            else
              MDataSet.Filter := Tree.DataSource.Relations[i-1].FDetailField + '=' + TMData(parent.Data).FMasterValue;
            MDataSet.Filtered := true;
          end;
          Result := MDataSet.RecordCount;

          MDataSet.Filtered := OldFiltered;
          MDataSet.Filter := OldFilter;
          MDataSet.EnableControls;
//          if not Tree.DataSource.Relations[i-1].FDenyLookSetPosition then
          begin
            if Assigned(bk) and MDataSet.BookmarkValid(bk) then
              MDataSet.GotoBookmark(bk);
            MDataSet.FreeBookmark(bk);
          end;
        end
        else
          Result := 0;
      end;
    end;
  end;
end;

{ TElDBTreeInplaceEditor }

{
**************************** TElDBTreeInplaceEditor ****************************
}
function TElDBTreeInplaceEditor.GetTree: TElTreeAncestor;
begin
  Result := inherited Tree as TElTreeAncestor;
end;

procedure TElDBTreeInplaceEditor.SetTree(Value: TElTreeAncestor);
begin
  inherited Tree := Value;
end;

procedure TElDBTreeInplaceEditor.StartOperation;
begin
  if (Tree is TCustomElDBTree) then
    (Tree as TCustomElDBTree).Selected := FItem as TElDBTreeItem
  else
    (Tree as TCustomElDBXTree).Selected := FItem as TElDBXTreeItem;
  inherited;
end;

type
  THackElCustomDBTree = class (TCustomElDBTree)
  end;

procedure TElDBTreeInplaceEditor.TriggerAfterCompleteOperation;
begin
  if (Tree is TCustomElDBTree) then
  begin
    if Assigned((Tree as TCustomElDBTree).selected) then
      THackElCustomDBTree(Tree as TCustomElDBTree).TriggerItemSelectedChangeEvent((Tree as TCustomElDBTree).Selected);
  end
  else
  begin
    if Assigned((Tree as TCustomElDBXTree).selected) then
      (Tree as TCustomElDBXTree).TriggerItemSelectedChangeEvent((Tree as TCustomElDBXTree).Selected);
  end;
  if Assigned(FOnAfterCompleteOperation) then
    OnAfterCompleteOperation(Self);
end;

{ TElMDataDataLink }

constructor TElMDataDataLink.Create(AMData: TMData);
begin
  inherited Create;
  FMData := AMData;
  VisualControl := false;
end;

procedure TElMDataDataLink.RecordChanged(Field: TField);
  procedure CheckNewParent(LTree: TElMDBTree; Item: TElMTreeItem; LMasterValue: TLMDString);
  var
    i: integer;
  begin
    if Assigned(Item.Parent) then
    begin
      for i := 0 to Item.Parent.List.Count - 1 do
      begin
        if TMData(TElMTreeItem(Item.Parent.List[i]).Data).FMasterValue = LMasterValue then
          LTree.CheckActualChildrensCount(TElMTreeItem(Item.Parent.List[i]));
      end;
    end
    else
    begin
      for i := 0 to LTree.Root.List.Count - 1 do
      begin
        if TMData(TElMTreeItem(LTree.Root.List[i]).Data).FMasterValue = LMasterValue then
          LTree.CheckActualChildrensCount(TElMTreeItem(LTree.Root.List[i]));
      end;
    end;
  end;
var
  book: TBookmark;
  LMasterValue: TLMDString;
//  TreeItem: TElDBXTreeItem;
begin
  if (Assigned(Field)) and (Assigned(FMData)) and (not FMData.FTreeOwner.Owner.FNoRebuildOnDataChange) then
  begin
    if  not (FMData.FTreeOwner.TreeView.IsEditing) then
    begin
      if not FMData.FTreeOwner.Owner.FChanging then
      begin
        if (Field <> nil) and (not (Field.DataType in [ftMemo, ftFmtMemo{$ifdef LMDCOMP10}, ftWideMemo{$endif}])) then
        begin
          book := field.DataSet.GetBookmark;
          if ( Field.DataSet.CompareBookmarks(book,FMData.FBookmark) = 0 ) then
          begin
  //          TreeItem := FMData.FTreeOwner;
  //          FMData.FTreeOwner.TreeView.Items.BeginUpdate;
            FMData.GetDataFromBase(Field.DataSet, FMData.FRelIndex);
            if (UpperCase(FMData.FMasterField) = UpperCase(Field.FieldName)) then
              FMData.FTree.CheckActualChildrensCount(FMData.FOwner);
            if (UpperCase(FMData.FDetailField) = UpperCase(Field.FieldName)) and Assigned(FMData.FTreeOwner.Parent) then
            begin
              Field.DataSet.DisableControls;
              if (Field.DataType in [ftString, ftDate, ftTime, ftDateTime]) then
                LMasterValue := QuotedStr(Field.AsString)
              else
                LMasterValue := Field.AsString;
              if (LMasterValue <> '') then
                CheckNewParent(FMData.FTree, FMData.FOwner.Parent, LMasterValue);
              FMData.FTree.CheckActualChildrensCount(FMData.FOwner.Parent);
              Field.DataSet.EnableControls;
            end;
  //          TreeItem.TreeView.Items.EndUpdate;
  //          if Assigned(FMData) and Assigned(FMData.FTreeOwner) and Assigned(FMData.FTreeOwner.Owner) then
  //            TreeItem.Owner.Repaint;
          end;
          Field.DataSet.FreeBookmark(book);
        end;
      end;
    end;
  end;
end;

initialization

  if GetClass('TElXRelations') = nil then
    Classes.RegisterClass(TElXRelations);
  if GetClass('TDataSource') = nil then
    Classes.RegisterClass(TDataSource);

  FMemoBitmap := TBitmap.Create;
  FMemoNullBitmap := TBitmap.Create;

  FMemoBitmap.LoadFromResourceName(HInstance, 'ELTREEMEMOPIC');
  FMemoNullBitmap.LoadFromResourceName(HInstance, 'ELTREEMEMONULLPIC');
  finalization
  try
    FMemoBitmap.Free;
    FMemoNullBitmap.Free;
  except
    on e:Exception do
    begin
      LMDDebug('ERROR finalization ElDBCtrls: ' + e.Message);
    end;
  end;

end.
