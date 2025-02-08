unit LMDButtonBar;
{$I lmdcmps.INC}

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

LMDButtonBar unit (RM)
----------------------
TLMDButtonBar control.

Changes
-------
Release 8.X
+ Themed rendering and CtlXP property added;
+ ItemFont (font for items in section) and ItemParentFont (controls whether items should have same font as parent section) properties added;
+ Items scrolling by MouseWheel and cursors added.
 

Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Types,StdCtrls, ImgList, UxTheme,
  LMDBaseController, LMDCustomPanelFill, LMDCustomImageList, LMDSpinButton,
  LMDGraph, LMDClass, LMDCont, LMDUtils, LMDProcs, LMDConst, LMDGlyphTextLayout, LMD3DCaption,
  LMDFXCaption, LMDIniCtrl, LMDBase;

const
  IDS_BUTTONBARSAVE:String='ButtonBar';

type
  TLMDButtonBarSpinButton = class (TLMDSpinButton)
  private
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
  end;

  {---------------------TLMDButtonBarItem--------------------------------------}
  TLMDButtonBarItem = class (TCollectionItem)
  private
    FHint,
    FCaption    : String;
    FLargeGlyph,
    FSmallGlyph : TBitmap;
    FCursor     : TCursor;
    FVisible,
    FEnabled    : Boolean;
    FGlyphRect,
    FTextRect,
    FRect       : TRect;
    FHeight,
    FTag,
    FImageIndex : Integer;
    FOnClick    : TNotifyEvent;
    FObject     : TObject;

    procedure SetEnabled (aValue : Boolean);
    procedure SetString (index : integer;aValue : String);
    procedure SetGlyph (index : Integer; aValue : TBitmap);
    procedure SetCursor (aValue : TCursor);
    procedure SetInteger (aValue : Integer);
    procedure SetBoolean (aValue : Boolean);
    //procedure DoOnClick (Sender : TObject);
    procedure GetChange (Sender : TObject);
    function GetItemHeight : Integer;
    procedure SetLinkObject (aValue : TObject);
    function GetLinkObject : TObject;
    function GetDisplayRect: TRect; //new June 02, JH
  protected
    function GetDisplayName: string; override;
    property Visible : Boolean read FVisible write SetBoolean default true;
    property Height : Integer read FHeight write FHeight default -1;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property TextRect : TRect read FTextRect write FTextRect;
    property GlyphRect : TRect read FGlyphRect write FGlyphRect;
    property DisplayRect : TRect read GetDisplayRect write FRect;

    property ItemHeight : Integer read GetItemHeight;
    property LinkObject : TObject read GetLinkObject write SetLinkObject;
  published
    //the text which will be be painted from the item
    property Caption : String index 0 read FCaption write SetString;
    property Cursor : TCursor read FCursor write SetCursor default crArrow;
    //the hint which will be shown if the mouse moves above the item
    property Hint : String index 1 read FHint write SetString;
    //Bitmap used if the section propery UseSmallGlyphs is set to true
    //and imageindex - section ListIndex - ButtonBar SmallImageList points to nil
    property SmallGlyph : TBitmap index 0 read FSmallGlyph write SetGlyph;
    //Bitmap used if the section propery UseSmallGlyphs is set to false
    //and imageindex - section ListIndex - ButtonBar LargeImageList points to nil
    property LargeGlyph : TBitmap index 1 read FLargeGlyph write SetGlyph;
    //send OnClick event for this item
    property Enabled : Boolean read FEnabled write SetEnabled default true;
    //specifies the ImageIndex (for small and large glyph)
    property ImageIndex : Integer read FImageIndex write SetInteger;

    property OnClick : TNotifyEvent read FOnClick write FOnClick;

    property Tag : Integer read FTag write FTag default 0;

    property Index;
  end;

  {---------------------TLMDButtonBarItems----------------------------------}
  TLMDButtonBarItems = class (TCollection)
  private
    FOwner : TCollectionItem;
    function GetItem(Index: Integer): TLMDButtonBarItem;
    procedure SetItem(Index: Integer; Value: TLMDButtonBarItem);
    function GetVisibleCount : Integer;
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Owner : TCollectionItem);
    destructor Destroy; override;
    function Add: TLMDButtonBarItem;
    property VisibleCount : Integer read GetVisibleCount;
    property Items[Index: Integer]: TLMDButtonBarItem read GetItem write SetItem; default;
  end;

  TLMDItemOrientation = (ioVertical, ioHorizontal, ioAuto);

  {---------------------TLMDButtonBarSection--------------------------------------}
  TLMDHintTimerMode = (htHide, htShow);
  TLMDButtonBarSection = class (TCollectionItem)
  private
    FHint,
    FCaption           : String;
    FGlyph             : TBitmap;
    FCursor            : TCursor;
    FItemOrientation   : TLMDItemOrientation;
    FMultiLine,
    FTransparentGlyphs,
    FParentFont,
    FItemParentFont,
    FKeepItemParentFontFlag,
    FShowHint,
    FReadOnly,
    FUseSmallImages,
    FVisible,
    FEnabled           : Boolean;
    FLayout            : TLMDGlyphTextLayout;
    FItems             : TLMDButtonBarItems;
    FFont3D            : TLMD3DCaption;
    FFont              : TFont;
    FItemFont          : TFont;

    FTimerHandle       : TLMDTimer;
    FHintPause,
    FHideHintPause,
    FListIndex,
    FScrollPos,
    FBtnMinHeight      : Integer;
    FUpBtnRect,
    FDnBtnRect,
    FRect,
    FClientRect        : TRect;
    FHintWindow        : THintWindow;
    FHintTimerMode     : TLMDHintTimerMode;

    procedure SetBoolean (index : Integer;aValue : Boolean);
    procedure SetString (index : integer;aValue : String);
    procedure SetGlyph (aValue : TBitmap);
    procedure SetCursor (aValue : TCursor);
    procedure SetLayout (aValue : TLMDGlyphTextLayout);
    procedure SetItems (aValue : TLMDButtonBarItems);
    procedure SetFont3D (aValue : TLMD3DCaption);
    procedure SetFont (aValue : TFont);
    procedure SetItemOrientation (aValue : TLMDItemOrientation);

//    procedure DoOnClick (Sender : TObject);
    procedure GetChange (Sender : TObject);
    procedure GetItemFontChange (Sender : TObject);

    function isFontStored : Boolean;
    function isItemFontStored : Boolean;
    procedure HintTimerProc(Sender : TObject);
    procedure StartHintTimer(Value: Integer; TimerMode : TLMDHintTimerMode);
    procedure StopHintTimer;
    procedure ActivateHint;
    procedure CancelHint;

    function GetSectionObject (Index : Integer) : TObject;
    procedure SetSectionObject (Index : Integer; aValue : TObject);
    procedure SetListIndex(const Value: Integer);
    procedure SetItemFont(const aValue: TFont);
  protected
    function GetDisplayName: string; override;

    property UpBtnRect : TRect read FUpBtnRect write FUpBtnRect;
    property DnBtnRect : TRect read FDnBtnRect write FDnBtnRect;

    function GetItemHeight : Integer;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    property ClientRect : TRect read FClientRect write FClientRect;
    property ScrollPos : Integer read FScrollPos;
    property DisplayRect : TRect read FRect write FRect;
    property Visible : Boolean index 7 read FVisible write SetBoolean default true;
    function GetItemSize(index : Integer) : TRect;
    property ItemHeight : Integer read GetItemHeight;
    property MultiLine : Boolean index 6 read FMultiLine write SetBoolean default false;
    property Objects[Index : Integer] : TObject read GetSectionObject write SetSectionObject;
  published
    //the text which will be displayed on the section button
    property Caption : String index 0 read FCaption write SetString;
    property Cursor : TCursor read FCursor write SetCursor default crArrow;
    //the hint which will be shown if the mouse enters the section button
    property Hint : String index 1 read FHint write SetString;
    //the glyph which will be painted on the section button
    property Glyph : TBitmap read FGlyph write SetGlyph;
    property Enabled : Boolean index 0 read FEnabled write SetBoolean default true;
    property UseSmallImages : Boolean index 1 read FUseSmallImages write SetBoolean default false;
    //if you set readonly to true a connected buttonbarmenu will not be able to make any changes, dragging will be disabled
    property ReadOnly : Boolean index 2 read FReadOnly write SetBoolean default false;
    property ShowHint : Boolean index 3 read FShowHint write SetBoolean default false;
    property ParentFont : Boolean index 4 read FParentFont write SetBoolean default true;
    property ItemParentFont: Boolean index 8 read FItemParentFont write SetBoolean default true;
    property TransparentGlyphs : Boolean index 5 read FTransparentGlyphs write SetBoolean default true;
    property ItemOrientation : TLMDItemOrientation read FItemOrientation write SetItemOrientation default ioAuto;
    property ItemFont: TFont read FItemFont write SetItemFont stored isItemFontStored;
    property Layout : TLMDGlyphTextLayout read FLayout write SetLayout;
    //the font which is used for the section button and all items in the section
    property Font : TFont read FFont write SetFont stored isFontStored;
    //the 3D font effects which are used for the section button and all items
    property Font3D : TLMD3DCaption read FFont3D write SetFont3D;
    property BtnMinHeight : Integer read FBtnMinHeight;
    //list index for small and large imagelist
    property ListIndex : Integer read FListIndex write SetListIndex;
    property Index;
    //collection of items to be displayed in this section (see TLMDButtonBarItem)
    property Items : TLMDButtonBarItems read FItems write SetItems;
  end;

  {---------------------TLMDButtonBarSections----------------------------------}
  TLMDButtonBarSections = class (TOwnedCollection)
  private
    function GetItem(Index: Integer): TLMDButtonBarSection;
    procedure SetItem(Index: Integer; Value: TLMDButtonBarSection);
    function GetVisibleCount : Integer;
  protected
    //function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    //constructor Create(Owner : TComponent);
    //destructor Destroy; override;
    function Add: TLMDButtonBarSection;
    function VisibleUpTo (index : Integer) : Integer;
    property VisibleCount : Integer read GetVisibleCount;
    property Items[Index: Integer]: TLMDButtonBarSection read GetItem write SetItem; default;
  end;

  {---------------------TLMDButtonBarStoreComp---------------------------------}
  TLMDButtonBarStoreComp = class (TComponent)
  private
    FSectionsButtons : TLMDButtonBarSections;

    procedure SetSectionBtns (aValue : TLMDButtonBarSections);
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
  published
    property Sections : TLMDButtonBarSections read FSectionsButtons write SetSectionBtns;
  end;

  TLMDButtonBarDragDropEvent = procedure(Sender, Source: TObject; X, Y, Section, Item: Integer) of object;
  TLMDButtonBarDragOverEvent = procedure(Sender, Source: TObject; X, Y : Integer; State: TDragState;var Accept: Boolean;Section, Item : Integer) of object;
  TLMDButtonBarOnBeforeItemClick = procedure (Sender : TObject; Section, Item : Integer; var allowClick : Boolean) of object;
  TLMDButtonBarOnItemClick = procedure (Sender : TObject; Section, Item : Integer) of object;
  TLMDButtonBarBeforeSectionChange = procedure (Sender : TObject; CurrentSection, NewSection : Integer; var allowExit : Boolean) of object;
  TLMDButtonBarSectionChange = procedure (Sender : TObject; CurrentSection, NewSection : Integer) of object;
  TLMDButtonBarSectionChanged = procedure (Sender : TObject; CurrentSection, OldSection : Integer) of object;

  TLMDMouseItem = procedure (Sender : TObject; Item : Integer) of object;
  TLMDButtonBarGetItemSettings = procedure (Sender : TObject; Section, Item : Integer; Font : TFont; Font3D : TLMD3DCaption; var caption : String) of object;

  TLMDButtonBarFocusStyle = (bfGlyph, bfText, bfGlyphText);
  TLMDButtonBarGetSectionFileName = procedure (Sender : TObject; var s : String) of object;
  TLMDBBIniSaveOption = (ssSectionName, ssSectionListIndex, ssIconState, ssItemNames, ssItemImageIndex,
                         ssSectionScrollPos, ssSectionHint, ssSectionOpen, ssItemHint, ssItemEnabled);
  TLMDBBIniSaveOptions = set of TLMDBBIniSaveOption;

  TLMDButtonBarOrientation = (bbHorizontal, bbVertical);

  {---------------------TLMDButtonBar------------------------------------------}
  TLMDButtonBar = class(TLMDCustomPanelFill)
  private
    FTimerId:TLMDTimer;
    FScrollDelay,
    FScrollStep,

    FDragItemSection,
    FDragItemIndex,

    FLargeItemHeight,
    FSmallItemHeight,

    FOldMouseOverSectionButton,
    FOldMouseOverItem,
    FSelectedItem,
    FSectionButtonDown,
    FOldBarPos,
    FSectionHeight,
    FSectionLeft,   //border in section (left/top)
    FSectionRight,  //border in section (right/bottom)
    FLastOpen,
    FOpen           : Integer;
    FSections       : TLMDButtonBarSections;

    FLargeImageList,
    FSmallImageList : TCustomImageList;
    FLargeChangeLink,
    FSmallChangeLink: TChangeLink;
    FSelectedColor  : TColor;

    FSaveAndRestore,
    FFillHighlightedItem,
    FUpBtnClicked,
    FDnBtnClicked,
    FUpBtnActClicked,
    FDnBtnActClicked,
    FUpRgnClicked,
    FDnRgnClicked,

    FReadOnly,
    FSingleSectionMode,
    FUseBitmap,
    FTransBtns,
    FSoftScroll,
    FMouseDown      : Boolean;

    FIniSection,
    FIniKey         : String;
    FIniLink        : TLMDIniCtrl;
    FIniSaveOptions : TLMDBBIniSaveOptions;
    FIniUse         : TLMDIniUse;

    //FBtnUp,
    //FBtnDn          : TLMDButtonBarSpinButton;

    FEdit           : TEdit;
    FEditObject     : TPersistent;

    FFont3D         : TLMD3DCaption;

    FLastMousePos   : TPoint;
    FFocusStyle     : TLMDButtonBarFocusStyle;

    FMouseClickPos  : TPoint;

    FOrientation    : TLMDButtonBarOrientation;

    FOnBeforeSectionChange : TLMDButtonBarBeforeSectionChange;
    FOnItemClick    : TLMDButtonBarOnItemClick;
    FOnBefItemClick : TLMDButtonBarOnBeforeItemClick;
    FOnIniReadData  : TLMDIniCtrlEvent;
    FOnIniWriteData : TLMDIniCtrlEvent;
    FOnGetSectionStoreFilename  : TLMDButtonBarGetSectionFileName;
    FOnSectionChanged : TLMDButtonBarSectionChanged;
    FOnSectionChange: TLMDButtonBarSectionChange;
    FOnDragOver     : TLMDButtonBarDragOverEvent;
    FOnDragDrop     : TLMDButtonBarDragDropEvent;
    FOnMouseExitItem,
    FOnMouseEnterItem: TLMDMouseItem;
    FOnGetItemSet   : TLMDButtonBarGetItemSettings;
    FUseGlobalTimer: Boolean;

    procedure SetSections (aValue : TLMDButtonBarSections);
    procedure SetInteger (index, aValue : Integer);
    procedure SetBoolean (index:Integer;aValue : Boolean);
    procedure SetFont3D (aValue : TLMD3DCaption);
    procedure SetIniLink (aValue : TLMDIniCtrl);
    procedure SetOrientation (aValue : TLMDButtonBarOrientation);

    procedure SetLargeImageList (aValue : TCustomImageList);
    procedure SetSmallImageList (aValue : TCustomImageList);

//    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;

    procedure ReadIdent1(Reader:TReader);
    procedure WriteIdent1(Writer:TWriter);
    function  CheckCont1:Boolean;
    function HasControl1:Boolean;

    procedure ReadIdent2(Reader:TReader);
    procedure WriteIdent2(Writer:TWriter);
    function  CheckCont2:Boolean;
    function HasControl2:Boolean;

    function SaveIniKey : Boolean;
    function SaveIniSection : Boolean;
    procedure SetSectionLeft(const Value: Integer);
    procedure SetSectionRight(const Value: Integer);
    procedure WMMouseWheel(var Message : TMessage); message WM_MOUSEWHEEL;
    procedure WMKeyUp(var Message : TMessage); message WM_KeyUp;
  protected
    procedure AlignControls (aControl : TControl;var Rect : TRect); override;
    procedure Notification (AComponent: TComponent; Operation: TOperation); override;

    procedure DoIniLoadSections; dynamic;
    procedure DoIniStoreSections; dynamic;
    procedure DoSectionChange(aValue: integer); virtual;

    procedure DefineProperties(Filer:TFiler); override;

    procedure LoadSections;
    procedure StoreSections;

    //paints one item of the current opened section with index; if restore is true the back will be restored first
    procedure PaintItem (ItemNr : Integer; restore : boolean; aCanvas : TCanvas; tryRestore:Boolean);
    //determines whether scroll btns have to be shown and paints them
    //if res is 0 the procedure behaves normal (restore + paint)
    //if res is 1 the procedure will only paint
    //if res is 2 the procedure will only restore
    procedure ScrollBtnsVisible(aCanvas : TCanvas; res : Byte);

    //draws the drag insert at bar
    procedure paintBar (ItemNr : Integer; aCanvas : TCanvas);
    //removes the drag insert at bar
    procedure delBar (ItemNr : Integer);

    procedure StartRepeatedClick (upClick : boolean);
    procedure EndRepeatedClick;

    procedure DoOnEditExit (Sender : TObject);
    procedure DoOnEditKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure DoOnScrollBtnUp (Sender : TObject);
    procedure DoOnScrollBtnDown (Sender : TObject);

    //checks whether we have an edit field open or not
    function isEditing : Boolean;
    //enters caption editing (for sections and items)
    procedure EnterEditMode (aValue : TPersistent);
    //cancels caption editing and destroys edit field
    procedure CancelEditMode;

    //determines above which section the mouse cursor is
    function mouseOverSection(XY : TPoint) : Integer;
    //determines above which item the mouse cursor is
    function mouseOverItem(XY : TPoint) : Integer;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure CMMouseLeave(var Message : TMessage); message CM_MOUSELEAVE;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    function GetSectionItemSpaceNeeded : Integer;
    function GetSectionItemSpaceExist : Integer;

    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;var Accept: Boolean); override;

//    function Empty : boolean; override;

  public
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    //draws section button with index
    procedure DrawButton(index : Integer; aCanvas : TCanvas);
    //paint all items of current section
    procedure PaintSectionItems(restore : boolean; aCanvas : TCanvas; aOwnBmp : Boolean);

    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure Paint; override;
    procedure Assign (Source : TPersistent); override;

    //storing and reading section information
    procedure LoadSectionsFromStream (stream : TStream);
    procedure StoreSectionsToStream (stream : TStream);
    procedure LoadSectionsFromFile (filename : String);
    procedure StoreSectionsToFile (filename : String);

    //add a section and enter caption editing
    procedure AddSection;
    //add a section, set the caption and not enter caption editing
    procedure AddNamedSection(aString : String);
    //delete section mouse is currently above
    procedure DelSection;
    //delete section with index index
    procedure RemoveSection(index : Integer);
    //rename the section the mouse is above by entering caption editing
    procedure RenSection(Index:Integer=-1);
    //rename the section the mouse is above by setting it to the given string; do not enter caption editing
    procedure RenSectionTo (aString : String);

    //add a item and enter caption editing
    function AddItem : TLMDButtonBarItem;
    //add a item, set the caption, without entering caption editing
    function AddNamedItem(aString : String) : TLMDButtonBarItem;
    //add a item to a (not neccesarily opened) section and set the caption
    function AddNamedItemToSection(SecNr : Integer; aString : String) : TLMDButtonBarItem;
    //delete the item the mouse is above
    procedure DelItem;
    //rename the item the mouse is above by entering caption editing
    procedure RenItem;
    //rename the item the mouse is above by setting caption to the string, without entering caption editing
    procedure RenItemTo (aString : String);

    function NextSection : Integer;
    function PrevSection : Integer;
    property CtlXP default false; // compatibility
    //currently opened section (index nr, starts at 0)
    property Open : Integer index 0 read FOpen write SetInteger;
    //currently selected item
    property SelectedItem : Integer index 1 read FSelectedItem write SetInteger;
    property HighlightedItem: Integer read FOldMouseOverItem; //JH March 2002
    property OldBarPos : Integer index 2 read FOldBarPos write SetInteger;
    property DockManager;
  published
    // V4 enhancements
    property Anchors;
    property AutoSize;
    property Constraints;
    property UseDockManager default True;
    property DockSite;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;

    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
    property About;
    property Align;
    property BackFX;
    property FaceController;
    property Bevel;
    property Color;
    property Cursor;
    property DragMode;
    property DragCursor;
    property FillSelectedColor: TColor read FSelectedColor write FSelectedColor default clSilver;
    property FixedSectionLeftBorder : Integer read FSectionLeft write SetSectionLeft default 20;
    property FixedSectionRightBorder : Integer read FSectionRight write SetSectionRight default 20;
    property Font;
    property Font3D : TLMD3DCaption read FFont3D write SetFont3D;
    property ImageList;
    property ImageIndex;
    property ListIndex;

    property IniKey         : String read FIniKey write FIniKey stored SaveIniKey;
    property IniSection     : String read FIniSection write FIniSection stored SaveIniSection;
    property IniLink        : TLMDIniCtrl read FIniLink write SetIniLink;
    property IniSaveOptions : TLMDBBIniSaveOptions read FIniSaveOptions write FIniSaveOptions default [ssSectionName, ssSectionListIndex, ssItemNames, ssItemImageIndex, ssIconState];
    property IniUse         : TLMDIniUse read FIniUse write FIniUse default ioNone;

    property ScrollDelay : Integer index 3 read FScrollDelay write SetInteger default 50;
    property ScrollStep : Integer index 6 read FScrollStep write SetInteger default -1;

    property SmallItemHeight : Integer index 4 read FSmallItemHeight write SetInteger default 24;
    property LargeItemHeight : Integer index 5 read FLargeItemHeight write SetInteger default 60;

    property LargeImageList : TCustomImageList read FLargeImageList write SetLargeImageList stored HasControl1;
    property SmallImageList : TCustomImageList read FSmallImageList write SetSmallImageList stored HasControl2;

    property Orientation : TLMDButtonBarOrientation read FOrientation write SetOrientation default bbHorizontal;
    property SectionBtnSize : Integer index 7 read FSectionHeight write SetInteger default 20;
    property ParentFont;
    property PopupMenu;
//    property PopupMenu : TLMDButtonBarPopupMenu read FPopupMenu write FPopupMenu;
    property Sections : TLMDButtonBarSections read FSections write SetSections;

    property FillObject;
    property ParentColor;
    property ParentShowHint;
    property ShowHint;
    property Transparent;
    property Visible;
    property TransparentButtons : Boolean index 1 read FTransBtns write SetBoolean default false;
    property SingleSectionMode : Boolean index 2 read FSingleSectionMode write SetBoolean default false;

    property FillSelectedItem : Boolean index 3 read FFillHighlightedItem write FFillHighlightedItem default true;
    property SoftScroll : Boolean read FSoftScroll write FSoftScroll default true;

    property SaveAndRestore : Boolean read FSaveAndRestore write FSaveAndRestore default false;
    property ReadOnly : Boolean read FReadOnly write FReadOnly default false;

    property FocusStyle : TLMDButtonBarFocusStyle read FFocusStyle write FFocusStyle default bfGlyphText;

    // 7.0
    property UseGlobalTimer:Boolean read FUseGlobalTimer write FUseGlobalTimer default false;
    // 9.0
    // ---
    property ThemeMode default ttmNone;
    property ThemeGlobalMode;    
    property OnBeforeSectionChange : TLMDButtonBarBeforeSectionChange read FOnBeforeSectionChange write FOnBeforeSectionChange;
    property OnBeforeItemClick : TLMDButtonBarOnBeforeItemClick read FOnBefItemClick write FOnBefItemClick;
    property OnItemClick : TLMDButtonBarOnItemClick read FOnItemClick write FOnItemClick;
    property OnGetSectionStoreFilename : TLMDButtonBarGetSectionFileName read FOnGetSectionStoreFilename write FOnGetSectionStoreFilename;
    property OnIniReadData  : TLMDIniCtrlEvent read FOnIniReadData write FOnIniReadData;
    property OnIniWriteData : TLMDIniCtrlEvent read FOnIniWriteData write FOnIniWriteData;
    property OnSectionChange: TLMDButtonBarSectionChange read FOnSectionChange write FOnSectionChange;
    property OnSectionChanged: TLMDButtonBarSectionChanged read FOnSectionChanged write FOnSectionChanged;
    property OnMouseEnterItem : TLMDMouseItem read FOnMouseEnterItem write FOnMouseEnterItem;
    property OnMouseExitItem : TLMDMouseItem read FOnMouseExitItem write FOnMouseExitItem;
    property OnGetItemSettings : TLMDButtonBarGetItemSettings read FOnGetItemSet write FOnGetItemSet;

    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseExit;
    property OnMouseEnter;
    property OnKeyDown;
    property OnKeyUp;
    property OnStartDrag;
    property OnEndDrag;
    property OnDragOver;
    property OnClick;
    property OnDblClick;
    property OnResize;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
//    property OnDragOverItem : TLMDButtonBarDragOverEvent read FOnDragOver write FOnDragOver;
//    property OnDragDropOnItem : TLMDButtonBarDragDropEvent read FOnDragDrop write FOnDragDrop;
  end;

implementation
uses
  Themes,
  LMDGraphUtils, LMDThemes;

procedure TLMDButtonBarSpinButton.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
//inherited;
//  Message.Result := 0;
  if (MK_LBUTTON and Message.Keys=MK_LBUTTON) then
    begin
//
//      Message.Result := 1;
//      if Assigned (OnClick) then OnClick(self);
//      exit;
      inherited;
    end
{  else
    }
end;

{ *************** TLMDButtonBarItem ****************************************** }
{ --------------- private ---------------------------------------------------- }
procedure TLMDButtonBarItem.SetString (index : Integer;aValue : String);
begin
  case index of
    0 : begin
          FCaption := aValue;
          GetChange (nil);
        end;
    1 : begin
          FHint := aValue;
          GetChange (nil);
        end;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TLMDButtonBarItem.SetGlyph (index:Integer;aValue : TBitmap);
begin
  case index of
    0 : begin
          FSmallGlyph.Assign (aValue);
          GetChange (nil);
        end;
    1 : begin
          FLargeGlyph.Assign (aValue);
          GetChange (nil);
        end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarItem.SetEnabled (aValue : Boolean);
begin
  FEnabled := aValue;
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarItem.SetCursor (aValue : TCursor);
begin
  FCursor := aValue;
end;

{ ----------------------------------------------------------------------------- }
procedure TLMDButtonBarItem.SetInteger (aValue : Integer);
begin
  if aValue <> FImageIndex then
    begin
      FImageIndex := aValue;
      GetChange (nil);
    end;
end;

{ ----------------------------------------------------------------------------- }
procedure TLMDButtonBarItem.SetBoolean (aValue : Boolean);
begin
  if aValue <> FVisible then
    begin
      FVisible := aValue;
      GetChange (nil);
    end;
end;

{ ----------------------------------------------------------------------------- }
{procedure TLMDButtonBarItem.DoOnClick (Sender : TObject);
begin
//  TLMDButtonBar((TLMDButtonBarSection(TLMDButtonBarItems(Collection).GetOwner)(Collection).GetOwner)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarItem.GetChange (Sender : TObject);
begin
  Changed(true);
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBarItem.GetItemHeight : Integer;
begin
  case FHeight of
    -1 : result := TLMDButtonBarSection (TLMDButtonBarItems(Collection).FOwner).ItemHeight;
{    -2 : begin //auto size
             result :=
           end;}
  else
    result := FHeight;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarItem.SetLinkObject (aValue : TObject);
begin
  FObject := aValue;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBarItem.GetLinkObject : TObject;
begin
  result := FObject;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBarItem.GetDisplayRect: TRect;
begin
  result := FRect;
{  if TLMDButtonBarSection (TLMDButtonBarItems(Collection).FOwner).UseSmallImages then
    if TLMDButtonBar(TLMDButtonBarSections(TLMDButtonBarSection (TLMDButtonBarItems(Collection).FOwner).Collection).FOwner).SmallItemHeight < FRect.Bottom - FRect.Top then
      result.Bottom := result.Top + TLMDButtonBar(TLMDButtonBarSections(TLMDButtonBarSection (TLMDButtonBarItems(Collection).FOwner).Collection).FOwner).SmallItemHeight
  else
    if TLMDButtonBar(TLMDButtonBarSections(TLMDButtonBarSection (TLMDButtonBarItems(Collection).FOwner).Collection).FOwner).LargeItemHeight < FRect.Bottom - FRect.Top then
      result.Bottom := result.Top + TLMDButtonBar(TLMDButtonBarSections(TLMDButtonBarSection (TLMDButtonBarItems(Collection).FOwner).Collection).FOwner).LargeItemHeight;}
end;

{ ---------------------- protected ------------------------------------------- }
function TLMDButtonBarItem.GetDisplayName: string;
begin
  if FCaption <> '' then
    result := FCaption
  else
    result := inherited GetDisplayName;
end;

{ ---------------------- public ---------------------------------------------- }
constructor TLMDButtonBarItem.Create(Collection: TCollection);
begin
  inherited Create (Collection);
  FSmallGlyph := TBitmap.Create;
  FSmallGlyph.OnChange := GetChange;
  FLargeGlyph := TBitmap.Create;
  FLargeGlyph.OnChange := GetChange;
  FEnabled := true;
  FVisible := true;
  FCursor := crArrow;
  FTag := 0;
  FHeight := -1;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDButtonBarItem.Destroy;
begin
  FLargeGlyph.OnChange := nil;
  FreeAndNil(FLargeGlyph);
  FSmallGlyph.OnChange := nil;
  FreeAndNil(FSmallGlyph);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarItem.Assign(Source: TPersistent);
var
  S: TLMDButtonBarItem;
begin
  if Source is TLMDButtonBarItem then
    begin
      S := TLMDButtonBarItem(Source);
      Caption := S.Caption;
      Cursor :=  S.Cursor;
      Enabled := S.Enabled;
      Hint := S.Hint;

      SmallGlyph.Assign (S.SmallGlyph);
      LargeGlyph.Assign (S.LargeGlyph);

      FRect := S.DisplayRect;
      ImageIndex := S.ImageIndex;
      Tag := S.Tag;
      OnClick := S.OnClick;
    end
  else
    inherited Assign (Source);
end;

{ ******************* TLMDButtonBarItems ************************************* }
function TLMDButtonBarItems.GetItem(Index: Integer): TLMDButtonBarItem;
begin
  result := TLMDButtonBarItem(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarItems.SetItem(Index: Integer; Value: TLMDButtonBarItem);
begin
  inherited SetItem(Index, Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBarItems.GetVisibleCount : Integer;
var
  i : Integer;
begin
  result := 0;
  for i := 0 to Count - 1 do
    inc (result, integer(Items[i].Visible=true));
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBarItems.GetOwner: TPersistent;
begin
  result := FOwner;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarItems.Update(Item: TCollectionItem);
begin

  //  inherited Update (Item);
  //inform owner about the changes beeing made
//  GetChange (nil); JH 02.12
//  if Assigned (GetOwner) then
    TLMDButtonBarSection(GetOwner).GetChange(nil);
//  TLMDButtonBar(TLMDButtonBarSection(GetOwner).GetOwner).GetChange(nil);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDButtonBarItems.Create(Owner: TCollectionItem);
begin
  inherited Create(TLMDButtonBarItem);
  FOwner := Owner;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDButtonBarItems.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBarItems.Add: TLMDButtonBarItem;
begin
  result := TLMDButtonBarItem(inherited Add);
end;

{ *************** TLMDButtonBarSection *************************************** }
{ --------------- private ---------------------------------------------------- }
procedure TLMDButtonBarSection.SetString (index : Integer;aValue : String);
begin
  case index of
    0 : begin
          FCaption := aValue;
          GetChange (nil);
        end;
    1 : begin
          FHint := aValue;
        end;
  end;
end;

{ ----------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.SetGlyph (aValue : TBitmap);
begin
  FGlyph.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.SetBoolean (index : Integer; aValue : Boolean);
begin
  case index of
    0 : FEnabled := aValue;
    1 : if aValue <> FUseSmallImages then
          begin
            FScrollPos := 0;
            FUseSmallImages := aValue;
            GetChange (nil);
          end;
    2 : FReadOnly := aValue;
    3 : if FShowHint <> aValue then
          begin
            FShowHint := aValue;
            if FShowHint then
              begin
                //FHintWindow := HintWindowClass.Create(TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner)); removed JH, Feb 2002, due to problem with different hint window classes (are not yet loaded)
//                FHintWindow.Color := FHintColor;
              end
            else
              if Assigned (FHintWindow) then
                begin
                  FHintWindow.ReleaseHandle;
                  FHintWindow.Free;
                  FHintWindow := nil;
                end;
          end;
    4 : if aValue <> FParentFont then
          begin
            if aValue then
              SetFont (TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).Font);
            FParentFont := aValue;
          end;
    5 : if aValue <> FTransparentGlyphs then
          begin
            FTransparentGlyphs := aValue;
            GetChange (nil);
          end;
    6 : if aValue <> FMultiLine then
          begin
            FMultiLine := aValue;
            GetChange (nil);
          end;
    7 : if aValue <> FVisible then
          begin
            FVisible := aValue;
            GetChange (nil);
          end;
    8: if aValue <> FItemParentFont then
          begin
            if aValue then
              SetItemFont (Font);
            FItemParentFont := aValue;
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.SetCursor (aValue : TCursor);
begin
  FCursor := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.SetLayout (aValue : TLMDGlyphTextLayout);
begin
  FLayout.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.SetItems (aValue : TLMDButtonBarItems);
begin
  FItems.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.SetFont3D (aValue : TLMD3DCaption);
begin
  FFont3D.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.SetFont (aValue : TFont);
begin
  FFont.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.SetItemOrientation (aValue : TLMdItemOrientation);
begin
  if aValue <> FItemOrientation then
    begin
      FItemOrientation := aValue;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDButtonBarSection.DoOnClick (Sender : TObject);
begin
  TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).Open := index;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.GetChange (Sender : TObject);
begin
  if (Sender is TFont) then
    begin
      FParentFont := false;
      if ItemParentFont then
        begin
          FKeepItemParentFontFlag := true;
          SetItemFont(Font);
          FKeepItemParentFontFlag := false;
        end;
    end;
  Changed(false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.GetItemFontChange (Sender : TObject);
begin
  if (Sender is TFont) and not FKeepItemParentFontFlag then
    FItemParentFont := false;
  Changed(false);
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBarSection.isFontStored : Boolean;
begin
  result := not FParentFont;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBarSection.isItemFontStored : Boolean;
begin
  result := not FItemParentFont;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.HintTimerProc(Sender : TObject);
begin
  StopHintTimer;
  case FHintTimerMode of
    htHide : FHintWindow.ReleaseHandle;
    htShow : ActivateHint;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.StartHintTimer(Value: Integer; TimerMode: TLMDHintTimerMode);
begin
  StopHintTimer;
  FTimerHandle := TLMDTimer.Create(Value, HintTimerProc, true, TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).FUseGlobalTimer);
  FHintTimerMode := TimerMode;
//  if FTimerHandle = 0 then CancelHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.StopHintTimer;
begin
  if Assigned(FTimerHandle) then
    FreeAndNil(FTimerHandle);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.ActivateHint;
var
  aHintRect : TRect;
  p : TPoint;
begin
  //FHintWindow.Caption wird in ButtonBar.MouseMove gesetzt

  if FHintWindow = nil then
    FHintWindow := HintWindowClass.Create(TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner));

  //if there is no hint exit before hint window is created ...
  if FHintWindow.Caption = '' then exit;

  aHintRect := Rect (0,0,1000,1000);
  LMDDrawTextCalcExt (FHintWindow.Canvas, FHintWindow.Caption, nil, aHintRect, FHintWindow.Canvas.Font, true, false, 0, 0);
  inc(aHintRect.Right, 4);
  GetCursorPos (p);
  OffSetRect (aHintRect, p.x, p.y + GetSystemMetrics (SM_CYCURSOR));
  FHintWindow.ActivateHint (aHintRect, FHintWindow.Caption);

  StartHintTimer (FHideHintPause, htHide);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.CancelHint;
begin
  StopHintTimer;
  if FHintWindow <> nil then
    FHintWindow.ReleaseHandle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBarSection.GetSectionObject (Index : Integer) : TObject;
begin
  result := nil;
  if Items.Count <= Index then exit;
  result := Items[Index].GetLinkObject;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.SetSectionObject (Index : Integer; aValue : TObject);
begin
  if Items.Count <= Index then exit;
  Items[Index].SetLinkObject (aValue);
end;

{ ---------------------- protected ------------------------------------------- }
function TLMDButtonBarSection.GetDisplayName: string;
begin
  if FCaption <> '' then
    result := FCaption
  else
    result := inherited GetDisplayName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBarSection.GetItemHeight : Integer;
var
  i : Integer;
begin
  if FUseSmallImages then
    if TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).FSmallItemHeight = -1 then
      begin
        i:=0;
        if Assigned(TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).SmallImageList) then
          i:=LMDIMLItemHeight(TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).SmallImageList, ListIndex);
        result :=LMDGet3DTextHeight (Font3D, Font);
        if result < i then
          result := i;
        inc(result, 10); //?
      end
    else
      result := TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).FSmallItemHeight
  else
    if TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).FLargeItemHeight = -1 then
      begin
        result:=0;
        if Assigned(TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).LargeImageList) then
          result :=LMDIMLItemHeight(TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).LargeImageList, ListIndex);
        result := result + LMDGet3DTextHeight (Font3D, Font);
        inc(result, 10); //?
      end
    else
      result := TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).FLargeItemHeight;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBarSection.GetItemSize(index : Integer) : TRect;
var
  i : Integer;
  flags : Word;
begin
  flags := 0;
  if not FMultiLine then
    begin
      flags := DT_END_ELLIPSIS;
      result := FClientRect;
    end;
  LMDDrawTextCalc (FItems[index].Caption, Font3D, result, Font, FMultiLine, false {no accel}, 0, flags);
  //result now contains size of text
  if FUseSmallImages then
    begin
      i:=0;
      if TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).FSmallItemHeight = -1 then
        begin
          if Assigned(TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).SmallImageList) then
            i:=LMDIMLItemHeight(TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).SmallImageList, ListIndex);
        end
      else
        i := TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).FSmallItemHeight;
      if i > result.Bottom - result.Top then result.Bottom := result.Top + i;
      i:=0;
      if Assigned(TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).SmallImageList) then
        i:=LMDIMLItemWidth(TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).SmallImageList, ListIndex);
      inc (result.Right, i);
    end
  else
    begin
      i:=0;
      if TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).FLargeItemHeight = -1 then
        begin
          if Assigned(TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).LargeImageList) then
            i:=LMDIMLItemHeight(TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).LargeImageList, ListIndex);
        end
      else
        i := TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).FLargeItemHeight;
      inc (result.Bottom, i);
      i:=0;
      if Assigned(TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).LargeImageList) then
        i:=LMDIMLItemWidth(TLMDButtonBar(TLMDButtonBarSections(Collection).GetOwner).LargeImageList, ListIndex);
      if i > result.Right - result.Left then
        result.Right := result.Left + i;
    end
end;

{ ---------------------- public ---------------------------------------------- }
constructor TLMDButtonBarSection.Create(Collection: TCollection);
begin
  inherited Create (Collection);

  FItems := TLMDButtonBarItems.Create(self);

  FGlyph := TBitmap.Create;
  FGlyph.OnChange := GetChange;
  FEnabled := true;
  FCursor := crArrow;
  FLayout := TLMDGlyphTextLayout.Create;
  FLayout.OnChange := GetChange;
  FBtnMinHeight := 30;

  FScrollPos := 0;
  FClientRect := Rect(0, 0, 0, 0);
  FUpBtnRect := Rect(0, 0, 0, 0);
  FDnBtnRect := Rect(0, 0, 0, 0);

  FHintPause := 50;
  FHideHintPause := 2500;

  FFont3D := TLMD3DCaption.Create;
  FFont3D.OnChange := GetChange;

  FItemOrientation := ioAuto;
  FVisible := true;

  FFont := TFont.Create;
  FFont.OnChange := GetChange;
  FItemFont := TFont.Create;
  FItemFont.OnChange := GetItemFontChange;
  FItemParentFont := true;
  FKeepItemParentFontFlag := false;
  FUseSmallImages := false;
  FReadOnly := false;
  FParentFont := true;
  FTransparentGlyphs := true;
  FMultiLine := false;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDButtonBarSection.Destroy;
begin
  ShowHint := false; // destroy hint window
  FFont.OnChange := nil;
  FreeAndNil(FFont);
  FItemFont.OnChange := nil;
  FreeAndNil(FItemFont);
  FFont3D.OnChange := nil;
  FreeAndNil(FFont3D);
  FLayout.OnChange := nil;
  FreeAndNil(FLayout);
  FGlyph.OnChange := nil;
  FreeAndNil(FGlyph);
  FreeAndNil(FItems);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.Assign(Source: TPersistent);
var
  S: TLMDButtonBarSection;
begin
  if Source is TLMDButtonBarSection then
    begin
      S := TLMDButtonBarSection(Source);
      Items.Assign (S.Items);

      Caption := S.Caption;
      Cursor :=  S.Cursor;
      Enabled := S.Enabled;
      Font3D.Assign (S.Font3D);
      Font.Assign (S.Font);
      Glyph.Assign (S.Glyph);
      Hint := S.Hint;
      Layout.Assign (S.Layout);
      ListIndex := S.ListIndex;
      ParentFont := S.ParentFont;
      ReadOnly := S.ReadOnly;
      UseSmallImages := S.UseSmallImages;
      // RM 6.1
      ShowHint:=S.ShowHint;
      TransparentGlyphs:=S.TransparentGlyphs;
      ItemOrientation:=S.ItemOrientation;
      // ---
    end
  else
    inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }

{ ******************* TLMDButtonBarSections ************************************* }
function TLMDButtonBarSections.GetItem(Index: Integer): TLMDButtonBarSection;
begin
  result := TLMDButtonBarSection(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSections.SetItem(Index: Integer; Value: TLMDButtonBarSection);
begin
  inherited SetItem(Index, Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBarSections.GetVisibleCount : Integer;
var
  i : Integer;
begin
  result := 0;
  for i := 0 to Count-1 do
    inc (result, integer(Items[i].Visible));
end;

{ ---------------------------------------------------------------------------- }
{function TLMDButtonBarSections.GetOwner: TPersistent;
begin
  result := FOwner;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSections.Update(Item: TCollectionItem);
begin
  TLMDButtonBar (Owner).Repaint;
end;

{ ---------------------------------------------------------------------------- }
{constructor TLMDButtonBarSections.Create(Owner: TComponent);
begin
  inherited Create(TLMDButtonBarSection);
end;

{ ---------------------------------------------------------------------------- }
{destructor TLMDButtonBarSections.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBarSections.Add: TLMDButtonBarSection;
begin
  result := TLMDButtonBarSection(inherited Add);
  Update (result);
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBarSections.VisibleUpTo (index : Integer) : Integer;
var
  i : Integer;
begin
  result := 0;
  for i := 0 to index do
    inc (result, integer(Items[i].Visible));
end;

{ *********************** TLMDButtonBarStoreComp ***************************** }
{ --------------------------- private ---------------------------------------- }
procedure TLMDButtonBarStoreComp.SetSectionBtns (aValue : TLMDButtonBarSections);
begin
  FSectionsbuttons.Assign (aValue);
end;

{ --------------------------- public ----------------------------------------- }
constructor TLMDButtonBarStoreComp.Create (aOwner : TComponent);
begin
  inherited Create (aOwneR);
  FSectionsButtons := TLMDButtonBarSections.Create (aOwner, TLMDButtonBarSection);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDButtonBarStoreComp.Destroy;
begin
  FSectionsButtons.Free;
  inherited Destroy;
end;

{ *********************** TLMDButtonBar ************************************** }
procedure TLMDButtonBar.SetSections (aValue : TLMDButtonBarSections);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.SetInteger (index:Integer; aValue : Integer);
var
  //r : TRect;
  i : Integer;
  allow : Boolean;
begin
  case index of
    0 : if aValue <> FOpen then
          begin
            allow := true;
            //this will only be executed here iff the Open value is about to be changed by code
            //it is executed as well in the mouse down event handler
            if Assigned (FOnBeforeSectionChange) then
              FOnBeforeSectionChange (self, FOpen, aValue, allow);
            if not allow then exit;
            if not FSections[aValue].Enabled then exit;
            DoSectionChange(aValue); //added VB Feb 2009
          end;
    1 : if aValue <> FSelectedItem then
          begin
            //save the current item information for dragging
            FDragItemIndex := aValue;
            FDragItemSection := FOpen;

            FOldBarPos := -1;

            i := FSelectedItem;
            FSelectedItem := aValue;
            if i <> -1 then
              PaintItem (i, true, Canvas, true);
            if FSelectedItem <> -1 then
              PaintItem (FSelectedItem, true, Canvas, true);
          end;
    2 : if (aValue <> FOldBarPos) and (FOpen <> -1) then
          begin
            if FOldBarPos <> -1 then
              delBar (FOldBarPos);
            //if there is no item selected for dragging get out here
            if (FDragItemIndex = -1) or (FDragItemSection = -1) then exit;
            FOldBarPos := aValue;
            if FOldBarPos <> -1 then
              PaintBar (FOldBarPos, Canvas);
          end;
    3 : if aValue <> FScrollDelay then
          FScrollDelay := aValue;
    4 : if aValue <> FSmallItemHeight then
          begin
            FSmallItemHeight := aValue;
            GetChange (nil);
          end;
    5 : if aValue <> FLargeItemHeight then
          begin
            FLargeItemHeight := aValue;
            GetChange (nil);
          end;
    6 : if aValue <> FScrollStep then
          begin
            FScrollStep := aValue;
          end;
    7 : if aValue <> FSectionHeight then
          begin
            FSectionHeight := aValue;
            GetChange (nil);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.SetBoolean (index: Integer;aValue : Boolean);
begin
  case index of
    1 : if aValue <> FTransBtns then
          begin
            FTransBtns := aValue;
            GetChange (nil);
          end;
    2 : if aValue <> FSingleSectionMode then
          begin
            FSingleSectionMode := aValue;
            if FSingleSectionMode then
              FOpen := 0;
            GetChange (nil);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.SetFont3D (aValue : TLMD3DCaption);
begin
  FFont3D.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.SetIniLink(aValue:TLMDIniCtrl);
begin
  FIniLink:=aValue;
  if FIniLink<>nil then
    FIniLink.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.SetOrientation (aValue : TLMDButtonBarOrientation);
begin
  if aValue <> FOrientation then
    begin
      FOrientation := aValue;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.SetSmallImageList (aValue : TCustomImageList);
begin
  if FSmallImageList<>nil then
    FSmallImageList.UnRegisterChanges(FSmallChangeLink);
  FSmallImageList:=aValue;
  if FSmallImageList<>nil then
    begin
      FSmallImageList.RegisterChanges(FSmallChangeLink);
      FSmallImageList.FreeNotification(Self);
    end;
  if not (csDestroying in ComponentState) then
    GetChange(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.SetLargeImageList (aValue : TCustomImageList);
begin
  if FLargeImageList<>nil then
    FLargeImageList.UnRegisterChanges(FLargeChangeLink);
  FLargeImageList:=aValue;
  if FLargeImageList<>nil then
    begin
      FLargeImageList.RegisterChanges(FLargeChangeLink);
      FLargeImageList.FreeNotification(Self);
    end;
  if not (csDestroying in ComponentState) then
    GetChange(nil);
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDButtonBar.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  if (MK_LBUTTON and Message.Keys=MK_LBUTTON) then
    Message.result := 1;
//  else
    inherited;
end;}

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.CMFontChanged(var Message: TMessage);
var
  i : Integer;
begin
  for i := 0 to FSections.Count - 1 do
    if FSections[i].ParentFont then
      begin
        FSections[i].ParentFont := false;
        FSections[i].ParentFont := true;
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.ReadIdent1(Reader:TReader);
begin
  SetLargeImageList(LMDReadGlobalIdent(Reader));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.WriteIdent1(Writer:TWriter);
begin
  LMDWriteGlobalIdent(Writer, FLargeImageList);
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBar.CheckCont1:Boolean;
begin
  result:=LMDIsGlobalIdent(FLargeImageList);
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBar.HasControl1:Boolean;
begin
  result:=(FLargeImageList<>nil) and (FLargeImageList.Owner<>LMDContainer);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.ReadIdent2(Reader:TReader);
begin
  SetLargeImageList(LMDReadGlobalIdent(Reader));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.WriteIdent2(Writer:TWriter);
begin
  LMDWriteGlobalIdent(Writer, FSmallImageList);
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBar.CheckCont2:Boolean;
begin
  result:=LMDIsGlobalIdent(FSmallImageList);
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBar.HasControl2:Boolean;
begin
  result:=(FSmallImageList<>nil) and (FSmallImageList.Owner<>LMDContainer);
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBar.SaveIniKey:Boolean;
begin
  result:=(FIniKey<>'') and (FIniKey<>IDS_BUTTONBARSAVE);
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBar.SaveIniSection:Boolean;
begin
  result:=(FIniSection<>'') and (FIniSection<>IDS_COMMON);
end;

{ ------------------------- protected ---------------------------------------- }
procedure TLMDButtonBar.AlignControls (aControl : TControl;var Rect : TRect);
begin
 // ScrollBtnsVisible;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.Notification (AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification (AComponent, Operation);
  if (Operation = opRemove) then
    begin
     if (AComponent = FLargeImageList) then
       SetLargeImageList(nil);
     if (AComponent = FSmallImageList) then
       SetSmallImageList(nil);
     if (AComponent=FIniLink) then
       IniLink:=nil;
    end;
  if (Operation=opInsert) and (aComponent is TLMDIniCtrl) then
    begin
      // attach IniCtrl automatically
      if (FIniUse=ioUseLink) and not Assigned(FIniLink) then
        FIniLink := TLMDIniCtrl(aComponent);
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonBar.DoIniLoadSections;

  procedure DoReadValues(aLink:TLMDIniCtrl);
  var
    i,
    SecCount,
    ItemCount,
    j :        Integer;
    tmp:String;
  begin
    with aLink do
      begin
        //load amount of sections
        SecCount := ReadInteger (FIniSection, FIniKey + 'SecCount', 0);

        //remove any existing sections - if there are stored ones - otherwise keep default
        if SecCount <> 0 then
          FSections.Clear;

        for i := 0 to SecCount - 1 do

          begin

            //add a section
            FSections.Add;

            if ssSectionName in FIniSaveOptions then
              FSections[i].Caption := ReadString (FIniSection, FIniKey + 'SecName'+IntToStr(i), '');

            if ssSectionListIndex in FIniSaveOptions then
              FSections[i].ListIndex := ReadInteger (FIniSection, FIniKey + 'SecListIndex'+IntToStr(i), 0);

            if ssIconState in FIniSaveOptions then
              FSections[i].UseSmallImages := ReadBool (FIniSection, FIniKey + 'IconSmall'+IntToStr(i), false);

            if ssSectionHint in FIniSaveOptions then
              FSections[i].Hint := ReadString (FIniSection, FIniKey + 'SecHint'+IntToStr(i), '');

            if ssSectionScrollPos in FIniSaveOptions then
              FSections[i].FScrollPos := ReadInteger (FIniSection, FIniKey + 'SecScrollPos'+IntToStr (i), 0);

            ItemCount := ReadInteger (FIniSection, FIniKey + 'ItemCount'+IntToStr(i), 0);

            tmp:=FIniKey+'Section'+Inttostr(i);
            for j := 0 to ItemCount - 1 do
              begin
                AddNamedItemToSection (i, '');
                if ssItemNames in FIniSaveOptions then
                  FSections[i].Items[j].Caption := ReadString (FIniSection,tmp+'ItemName' + IntToStr(j), '');
                if ssItemImageIndex in FIniSaveOptions then
                  FSections[i].Items[j].ImageIndex := ReadInteger (FIniSection,tmp+'ItemImageIndex' + IntToStr (j), 0);
                if ssItemHint in FIniSaveOptions then
                  FSections[i].Items[j].Hint := ReadString (FIniSection, tmp+'ItemHint'+IntToStr(j), '');
                if ssItemEnabled in FIniSaveOptions then
                  FSections[i].Items[j].Enabled := ReadBool (FIniSection, tmp+'ItemEnabled'+IntToStr(j), true);
              end;

          end;
        if ssSectionOpen in FIniSaveOptions then
          FOpen := ReadInteger (FIniSection, FIniKey + 'SectionOpen', 0);
      end;
    if Assigned(FOnIniReadData) then FOnIniReadData(self, aLink, FIniSection);
  end;

begin
  if (FIniUse=ioUseLink) and Assigned(FIniLink) then
    DoReadValues(FiniLink)
  else
    if FIniUse=ioUseGlobal then
      DoReadValues(LMDApplication.Ini)
    else
     if Assigned(FOnIniReadData) then FOnIniReadData(self, nil, FIniSection);
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonBar.DoIniStoreSections;

  procedure WriteValues(aLink:TLMDIniCtrl);
  var
    i,
    j       : Integer;
    tmp     :String;
  begin
    if aLink = nil then exit;

    with aLink do
      begin

        //we have to remove everything
        EraseSection (FIniSection);

        //store amount of sections
        WriteInteger (FIniSection, FIniKey + 'SecCount', FSections.Count);

        for i := 0 to FSections.Count - 1 do

          begin

            if ssSectionName in FIniSaveOptions then
              WriteString (FIniSection, FIniKey + 'SecName'+IntToStr(i), FSections[i].Caption);

            if ssSectionListIndex in FIniSaveOptions then
              WriteInteger (FIniSection, FIniKey + 'SecListIndex'+IntToStr(i), FSections[i].ListIndex);

            if ssIconState in FIniSaveOptions then
              WriteBool (FIniSection, FIniKey + 'IconSmall'+IntToStr(i), FSections[i].UseSmallImages);

            if ssSectionHint in FIniSaveOptions then
              WriteString (FIniSection, FIniKey + 'SecHint'+IntToStr(i), FSections[i].Hint);

            if ssSectionScrollPos in FIniSaveOptions then
              WriteInteger (FIniSection, FIniKey + 'SecScrollPos'+IntToStr (i), FSections[i].ScrollPos);

            WriteInteger (FIniSection, FIniKey + 'ItemCount'+IntToStr(i), FSections[i].Items.Count);

            tmp:=FIniKey+'Section'+Inttostr(i);
            for j := 0 to FSections[i].Items.Count - 1 do
              begin
                if ssItemNames in FIniSaveOptions then
                  WriteString (FIniSection, tmp+'ItemName' + IntToStr(j), FSections[i].Items[j].Caption);
                if ssItemImageIndex in FIniSaveOptions then
                  WriteInteger (FIniSection, tmp+ 'ItemImageIndex' + IntToStr (j), FSections[i].Items[j].ImageIndex);
                if ssItemHint in FIniSaveOptions then
                  WriteString (FIniSection, tmp+ 'ItemHint'+IntToStr(j), FSections[i].Items[j].Hint);
                if ssItemEnabled in FIniSaveOptions then
                  WriteBool (FIniSection, tmp+ 'ItemEnabled'+IntToStr(j), FSections[i].Items[j].Enabled);
              end;

          end;
        if ssSectionOpen in FIniSaveOptions then
          WriteInteger (FIniSection, FIniKey + 'SectionOpen', FOpen);
      end;
    if Assigned(FOnIniWriteData) then FOnIniWriteData(self, aLink, FIniSection);
  end;

begin
  if (FIniUse=ioUseLink) and Assigned(FIniLink) then
    WriteValues(FiniLink)
  else
    if FIniUse=ioUseGlobal then
      WriteValues(LMDApplication.Ini)
    else
     if Assigned(FOnIniWriteData) then FOnIniWriteData(self, nil, FIniSection);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.DoSectionChange(aValue: integer);
begin
  // otherwise the buttons would sometimes stay pressed ...
  FUpBtnClicked := false;
  FDnBtnClicked := false;
  //
  FSections[FOpen].CancelHint; //hide any visible hint
  if Assigned (FOnSectionChange) then FOnSectionChange (self, FOpen, aValue);
  FLastOpen := FOpen;
  FOpen := aValue;
  //r := ClientRect;
  FOldMouseOverItem := -1;
  FSelectedItem := -1;
  FOldBarPos := -1;
  GetChange (nil);
  if Assigned (FOnSectionChanged) then FOnSectionChanged (self, FOpen, FLastOpen);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty(IDS_INTERNAL+'LL', ReadIdent1, WriteIdent1, CheckCont1);
  Filer.DefineProperty(IDS_INTERNAL+'SL', ReadIdent2, WriteIdent2, CheckCont2);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.LoadSections;
{var
  myStream : TFileStream;
  myComp : TLMDButtonBarStoreComp;}
var
  s: String;
begin
  if FSaveAndRestore then
    begin
      if Assigned (FOnGetSectionStoreFilename) then FOnGetSectionStoreFilename (self, s);
      if s <> '' then
        LoadSectionsFromFile (s);
      Exit;
    end;
  DoIniLoadSections;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.StoreSections;
var
  s: String;
begin
  if FSaveAndRestore then
    begin
      if Assigned (FOnGetSectionStoreFilename) then FOnGetSectionStoreFilename (self, s);
      if s <> '' then
        StoreSectionsToFile (s);
      Exit;
    end;
  DoIniStoreSections;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.PaintItem (ItemNr : Integer; restore : boolean; aCanvas : TCanvas; tryRestore: Boolean);
const
  SpacePrevious = 4;
var
  s : String;
  flags  : Word;
  topbottom : boolean;
  x, y   : Integer;
  hRect,
  aRect,
  bRect  : TRect;
  rgn    : HRGN;
  myFont : TFont;
  myFont3D,
  f3D    : TLMD3DCaption;
  ffx    : TLMDFXCaption;
  FBColor : TColor;
  b      : TBitmap;
  dCanvas: TCanvas;
  button : TThemedButton;
  lTheme : TLMDThemeMode;
begin
  if tryRestore then
    ScrollBtnsVisible (aCanvas, 2);
  rgn := 0;
  myFont3D:=nil;
  myfont:=nil;
  lTheme :=UseThemeMode;
  if (FSections[FOpen].Items.Count <= ItemNr) or (ItemNr = -1) then exit;
  try
    with aCanvas, FSections[FOpen].Items[ItemNr] do
      begin
        topBottom := true; //horizontal text and glyph alignment

        if (FSections[FOpen].ItemOrientation = ioVertical) or
             ((FSections[FOpen].ItemOrientation = ioAuto) and (FOrientation = bbVertical)) then
          topBottom := false;

        aRect := DisplayRect;

        //if we need to restore it is the only item to be drawn and we need to
        //be sure to be in the visible area
        if restore then
          rgn := CreateRectRgnIndirect (FSections[FOpen].ClientRect);

        try
          if rgn <> 0 then //restore = true
            begin
              SelectClipRgn (Handle, rgn);
              aCanvas.Brush.Style := bsSolid;
              aCanvas.Brush.Color := Color;
              bRect := aRect;
              bRect.Top := bRect.Top - FSections[FOpen].ClientRect.Top;
              bRect.Left := bRect.Left - FSections[FOpen].ClientRect.Left;
              if UseThemeMode <> ttmNone then
                begin
                  aCanvas.Brush.Color := LMDThemeServices.GetThemeColor(UseThemeMode, teToolBar, 0, 0, TMT_FILLCOLOR);
                  aCanvas.FillRect (aRect);
                end
              else
                if not BackDrawArea(aCanvas, aRect, Point(0, 0), 0) then
                  aCanvas.FillRect (aRect);
            end;

          if FSections[FOpen].ParentFont then
            begin
//              aCanvas.Font.Assign (self.Font);
              f3D := Font3D;
            end
          else
            begin
              f3D := FSections[FOpen].Font3D;
            end;

          myFont := TFont.Create;
          myFont.Assign (FSections[FOpen].ItemFont);

          myfont3D := TLMD3DCaption.Create;
          myFont3D.Assign (f3D);

          s := Caption;

          If Assigned (FOnGetItemSet) then
            FOnGetItemSet (self, FOpen, ItemNr, myFont, myFont3D, s);

          aCanvas.Font.Assign (myFont);

          flags := DT_NOPREFIX;
          //draw the caption
          if FSections[FOpen].UseSmallImages then
            flags := flags or DT_LEFT
          else
            flags := flags or DT_CENTER;

          if FSections[FOpen].MultiLine then
            flags := flags or DT_WORDBREAK
          else
            flags := flags or DT_END_ELLIPSIS;

          //calculate the space needed for the caption
//          y := aRect.Bottom - aCanvas.TextHeight (s) - 4; //JH 30.03.01 -> by 2 lines below
          hRect := Rect(0,0,0,0);
          dCanvas := TCanvas.Create;
          try
            LMDDrawTextCalcExt (dCanvas, s, myFont3D, hRect, myFont, FSections[FOpen].MultiLine, false, 0, flags);
          finally
            dCanvas.Free;
          end;
          y := aRect.Bottom - hRect.Bottom;

          aRect.Top := aRect.Top + SpacePrevious + 3;

          bRect := DisplayRect;
          bRect.Top := aRect.Top;
          Inc (bRect.Left, 12);
          Dec (bRect.Right, 12);

          b := TBitmap.Create;
          // --> for next major release
          // --> full rewriting of paint routine
          //if there is a normal bitmap assigned paint it as glyph
          if (FSections[FOpen].Items[ItemNr].SmallGlyph <> nil) and (not FSections[FOpen].Items[ItemNr].SmallGlyph.Empty) and (FSections[FOpen].UseSmallImages) then
            begin
              x:=1;
              bRect:=Rect(0,0, SmallGlyph.Width, SmallGlyph.Height);
              OffsetRect (bRect, -bRect.Left + aRect.Left+x, -bRect.Top + aRect.Top);
              b.Assign(FSections[FOpen].Items[ItemNr].SmallGlyph);
              y := aRect.Top;
            end
          else //use large image
            if (FSections[FOpen].Items[ItemNr].LargeGlyph <> nil) and (not FSections[FOpen].Items[ItemNr].LargeGlyph.Empty) then
              begin
                bRect:=Rect(0,0, LargeGlyph.Width, LargeGlyph.Height);
                x := ((aRect.Right - aRect.Left) - (bRect.Right-bRect.Left)) div 2;
                OffsetRect (bRect, -bRect.Left + aRect.Left + x, -bRect.Top + aRect.Top);
                b.Assign(FSections[FOpen].Items[ItemNr].LargeGlyph);
              end
            else //otherwise try to get a glpyh from the selected imagelist
              if FSections[FOpen].UseSmallImages then
                begin
                  if (SmallImageList <> nil) and LMDIMLIsValidItem(SmallImageList, FSections[FOpen].ListIndex, FSections[FOpen].Items[ItemNr].ImageIndex) then
                    begin
                      bRect := LMDIMLItemRect(SmallImageList, FSections[FOpen].ListIndex, FSections[FOpen].Items[ItemNr].ImageIndex);
                      x := 1;//((aRect.Right - aRect.Left) - (bRect.Right-bRect.Left)) div 2;
                      OffsetRect (bRect, -bRect.Left + aRect.Left + x, -bRect.Top + aRect.Top);
                      LMDIMLItemBitmap(SmallImageList, FSections[FOpen].ListIndex, FSections[FOpen].Items[ItemNr].ImageIndex, b);
                      y := aRect.Top;
                    end
                  else
                    begin
                      bRect := DisplayRect;
                      bRect.Right := bRect.Left;
                      Inc(bRect.Top);
                    end;
                end
              else //use large imagelist image
                begin
                  if (LargeImageList <> nil) and LMDIMLIsValidItem(LargeImageList, FSections[FOpen].ListIndex, FSections[FOpen].Items[ItemNr].ImageIndex) then
                    begin
                      bRect := LMDIMLItemRect(LargeImageList, FSections[FOpen].ListIndex, FSections[FOpen].Items[ItemNr].ImageIndex);
                      x := ((aRect.Right - aRect.Left) - (bRect.Right-bRect.Left)) div 2;
                      OffsetRect (bRect, -bRect.Left + aRect.Left + x, -bRect.Top + aRect.Top);
                      LMDIMLItemBitmap(LargeImageList, FSections[FOpen].ListIndex, FSections[FOpen].Items[ItemNr].ImageIndex, b);
                    end
                end;

          if (FSections[FOpen].UseSmallImages) then
            begin
              inc(y , 4);
              aRect.Left := bRect.Right + 2;
            end;

          //get shadow color
          FBColor := clBtnShadow;
          if ((FillObject.Style = sfBrush) and (ColorToRGB(FillObject.Brush.Color) = ColorToRGB(clBtnShadow))) or
             (ColorToRGB (Color) = ColorToRGB (clBtnShadow)) then
            FBColor := clBlack;

          aRect.Top := y;

          GlyphRect := bRect;

          //textrect has been calculated => save the text rect
          TextRect := aRect;

          case FFocusStyle of
            bfText : begin
                       bRect := TextRect;
                     end;
            bfGlyphText : begin
                            if GlyphRect.Top < TextRect.Top then
                              bRect.Top := GlyphRect.Top - 1
                            else
                              bRect.Top := TextRect.Top;
                            if GlyphRect.Left < TextRect.Left then
                              bRect.Left := GlyphRect.Left - 1
                            else
                              bRect.Left := TextRect.Left;
                            if GlyphRect.Right > TextRect.Right then
                              bRect.Right := GlyphRect.Right
                            else
                              bRect.Right := TextRect.Right;
                            if GlyphRect.Bottom > TextRect.Bottom then
                              bRect.Bottom := GlyphRect.Bottom
                            else
                              bRect.Bottom := TextRect.Bottom;
                          end;
          end;

          //JH June 02
          //check whether bRect matches current display rect
          //if too large Item height is to less for items to be drawn completely!
          if (FSections[FOpen].UseSmallImages) then
            if bRect.Bottom - bRect.Top > SmallItemHeight then
              bRect.Bottom := bRect.Top + SmallItemHeight
          else
            if bRect.Bottom - bRect.Top > LargeItemHeight then
              bRect.Bottom := bRect.Top + LargeItemHeight;

          if ItemNr = FOldMouseOverItem then
            begin
              if lTheme<>ttmNone then
                begin
                  if ItemNr <> FSelectedItem then
                    button := tbPushButtonHot
                  else
                    button := tbPushButtonPressed;
                  LMDThemeServices.DrawElement(lTheme, aCanvas.Handle, button, bRect, @bRect);
                end
              else
                if (FFillHighlightedItem) then
                  begin
                    aCanvas.Brush.Style := bsSolid;
                    aCanvas.Brush.Color := FSelectedColor;
                    aCanvas.FillRect (bRect);
                  end;
            end;

          if not TopBottom then
            begin
              ffx := TLMDFXCaption.Create;
              try
                ffx.Angle := 90;
                ffx.LightDepth := myFont3D.LightDepth;
                ffx.ShadowDepth := myFont3D.ShadowDepth;
                ffx.LightColor := myFont3D.LightColor;
                ffx.ShadowColor := myFont3D.ShadowColor;
                ffx.Style := myFont3D.Style;
                ffx.Tracing := myFont3D.Tracing;
                LMDDrawTextExt (aCanvas, s, ffx, TextRect, flags, [TLMDDrawTextStyle(Enabled), dt3DDisabled], nil);
              finally
                ffx.Free;
              end;
            end
          else
            LMDDrawTextExt (aCanvas, s, myFont3D, TextRect, flags, [TLMDDrawTextStyle(Enabled), dt3DDisabled], nil);

          {
          We should add a special small item lyout object for being able to achieve the default look
          for small and large items - so far the layout object will not be used :-(
          Further on the calculation of an object containing glyph plus text has to be done ...

          LMDDrawTextAndGlyph (aCanvas, s, myFont3D, TextRect, b, nil,
                               FSections[FOpen].Layout, true, false, true,[TLMDDrawTextStyle(Enabled), dt3DDisabled],flags);}

          if FSections[FOpen].TransparentGlyphs then
            LMDBmpDrawExt(aCanvas, GlyphRect, b.Canvas, Rect (0, 0 , b.Width, b.Height), DSF_TRANSPARENCY, b.TransparentColor, 0, nil)
          else
            aCanvas.Draw (GlyphRect.Left, GlyphRect.Top, b);

          //cp look missing!!

          if lTheme = ttmNone then
            if ItemNr = FOldMouseOverItem then
              if ItemNr <> FSelectedItem then
                LMDDrawFrame3D (aCanvas, bRect, bvRaised, clWhite, FBColor, 1)
              else
                LMDDrawFrame3D (aCanvas, bRect, bvLowered, clWhite, FBColor, 1);

//          ScrollBtnsVisible (aCanvas);

          b.Free;

        finally
          if myFont <> nil then
            myFont.Free;
          if myFont3D <> nil then
            myfont3D.Free;
          if rgn <> 0 then //restore = true
            begin
              SelectClipRgn (Handle, 0);
              DeleteObject (rgn);
            end;
        end;
      end;
  finally
  end;
  if tryRestore then
    ScrollBtnsVisible (aCanvas, 1);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.ScrollBtnsVisible(aCanvas : TCanvas; res : Byte);
const
  ArrowSize = 6;

var
  itemSpace_exist,
  itemSpace_need  : Integer;
  lTheme : TLMDThemeMode;

  procedure restoreScrollBtnBack (top : boolean);
  var
    aRect : TRect;
  begin
    if res = 1 then exit;
    if top then
      begin
        aRect := FSections[FOpen].UpBtnRect;
//        FSections[FOpen].UpBtnRect := Rect(0,0,0,0)
      end
    else
      begin
        aRect := FSections[FOpen].DnBtnRect;
//        FSections[FOpen].DnBtnRect := Rect(0,0,0,0);
      end;

    aCanvas.Brush.Style := bsSolid;
    aCanvas.Brush.Color := Color;
    if UseThemeMode <> ttmNone then
      begin
        aCanvas.Brush.Color := LMDThemeServices.GetThemeColor(UseThemeMode, teToolBar, 0, 0, TMT_FILLCOLOR);
        aCanvas.FillRect (aRect);
      end
    else
      if not BackDrawArea(aCanvas, aRect, Point(0,0), 0) then
        aCanvas.FillRect (aRect);
  end;

  procedure createScrollBtn (top : Boolean);
  var
    aRect : TRect;
    cor,
    h, w,
    x     : Integer;
    button : TThemedScrollbar;
    const BtnType: array[boolean] of array[boolean] of TThemedScrollBar = ((tsArrowBtnRightNormal, tsArrowBtnLeftNormal),(tsArrowBtnDownNormal, tsArrowBtnUpNormal));
  begin
    if res = 2 then exit;
    if top then
      begin
        if FOrientation = bbHorizontal then
          aRect := Rect (ClientRect.Right - 20 - GetBevel.BevelExtend,
                         FSections[FOpen].ClientRect.Top + 4,
                         ClientRect.Right - 4 - GetBevel.BevelExtend,
                         FSections[FOpen].ClientRect.Top + 20)
        else
          aRect := Rect (FSections[FOpen].ClientRect.Left + 4,
                         ClientRect.Top + 4 + GetBevel.BevelExtend,
                         FSections[FOpen].ClientRect.Left + 20,
                         ClientRect.Top + 20 + GetBevel.BevelExtend);
        FSections[FOpen].UpBtnRect := aRect;
      end
    else
      begin
        if FOrientation = bbHorizontal then
          aRect := Rect (ClientRect.Right - 20 - GetBevel.BevelExtend,
                         FSections[FOpen].ClientRect.Bottom - 20,
                         ClientRect.Right - 4 - GetBevel.BevelExtend,
                         FSections[FOpen].ClientRect.Bottom - 4)
        else
          aRect := Rect (FSections[FOpen].ClientRect.Right - 20,
                         ClientRect.Top + 4 + GetBevel.BevelExtend,
                         FSections[FOpen].ClientRect.Right - 4,
                         ClientRect.Top + 20 + GetBevel.BevelExtend);
        FSections[FOpen].DnBtnRect := aRect;
      end;

    aCanvas.Brush.Style := bsSolid;
    aCanvas.Brush.Color := clBtnFace;
    aCanvas.FillRect (aRect);

    aCanvas.Pen.Color := clBlack;
    aCanvas.Pen.Width := 0;
    aCanvas.Brush.Color := clBlack;

    if (top and FUpBtnClicked) or (not top and FDnBtnClicked) then
      begin
        cor := 0;
        if lTheme<>ttmNone then
          begin
            button := BtnType[Orientation = bbHorizontal, top];
            LMDThemeServices.DrawElement(lTheme, aCanvas.Handle, button, aRect);
          end
        else
          LMDDrawStdFrame (aCanvas, aRect, lsSingleLowered, 0);
      end
    else
      begin
        cor := +1;
        if lTheme<>ttmNone then
          begin
            button := BtnType[Orientation = bbHorizontal, top];
            LMDThemeServices.DrawElement(lTheme, aCanvas.Handle, button, aRect);
          end
        else
          LMDDrawStdFrame (aCanvas, aRect, lsSingleRaised, 0);
      end;

    //width of btn
    w := aRect.Right - aRect.Left;
    h := aRect.Bottom - aRect.Top;

    //middle of btn
    x := aRect.Left + w div 2;

    if lTheme = ttmNone then
      begin
        if FOrientation = bbHorizontal then
          if top then
            aCanvas.Polygon ([Point(x - cor, aRect.Top + (h - ArrowSize) div 2 - cor),
                             Point(aRect.Left + (w - ArrowSize) div 2 - cor, aRect.Bottom - (h - ArrowSize) div 2 - cor),
                             Point(aRect.Right - (w - ArrowSize) div 2 - cor, aRect.Bottom - (h - ArrowSize) div 2 - cor)])
          else
            aCanvas.Polygon ([Point(x - cor, aRect.Bottom - (h - ArrowSize) div 2 - cor),
                             Point(aRect.Left + (w - ArrowSize) div 2 - cor, aRect.Top + (h - ArrowSize) div 2 - cor),
                             Point(aRect.Right - (w - ArrowSize) div 2 - cor, aRect.Top + (h - ArrowSize) div 2 - cor)])
        else
          if top then
            aCanvas.Polygon ([Point(x - (h - ArrowSize) div 2 - cor, aRect.Top + h div 2),
                             Point(aRect.Right - (w - ArrowSize) div 2 - cor, aRect.Top + (h - ArrowSize) div 2 - cor),
                             Point(aRect.Right - (w - ArrowSize) div 2 - cor, aRect.Bottom - (h - ArrowSize) div 2 + cor)])
          else
            aCanvas.Polygon ([Point(aRect.Right - (h - ArrowSize) div 2 - cor, aRect.Top + h div 2),
                             Point(aRect.Left + (w - ArrowSize) div 2 - cor, aRect.Top + (h - ArrowSize) div 2 - cor),
                             Point(aRect.Left + (w - ArrowSize) div 2 - cor, aRect.Bottom - (h - ArrowSize) div 2 + cor)]);
      end;
  end;

begin
  lTheme := UseThemeMode;
  itemSpace_exist := GetSectionItemSpaceExist;
  //+5 because of last item
  itemSpace_need  := GetSectionItemSpaceNeeded;
  if itemSpace_need < itemSpace_exist then
    begin
      if FSections[FOpen].FScrollPos <> 0 then
        begin
          FSections[FOpen].FScrollPos := 0; //there had been one item more than the visible area could contain, user scrolled to see it, moved it to another section and returns
          GetChange (nil);
//          PaintSectionItems (true, Canvas, true);
        end;
      exit;
    end;
  if abs (itemSpace_exist - itemSpace_need) > FSections[FOpen].ScrollPos then
    createScrollBtn ({FBtnDn,} false)
  else
    restoreScrollBtnBack (false);
  if FSections[FOpen].ScrollPos > 0 then
    createScrollBtn ({FBtnUp,} true)
  else
    restoreScrollBtnBack (true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.paintBar (ItemNr : Integer; aCanvas : TCanvas);
const
  AXSize = 12;
  AYSize = 8;
var
  aRect : TRect;
  y     : Integer;
  rgn   : HRGN;
begin
  if (ItemNr = -1) or (ItemNr > FSections[FOpen].Items.Count) or (not FMouseDown) then exit;
  //the bar is not paintable (the place where to paint the bar is not visible)
//  if aRect.Bottom > FSections[FOpen].ClientRect.Bottom then exit;

  rgn := CreateRectRgnIndirect (FSections[FOpen].ClientRect);
  try
    SelectClipRgn (aCanvas.Handle, rgn);
    aCanvas.Pen.Width := 1;
    aCanvas.Pen.Color := clBlack;
    aCanvas.Brush.Style := bsSolid;
    aCanvas.Brush.Color := clBlack;
    if (ItemNr = 0) or (FSections[FOpen].Items.Count = 0) then
      begin
        if FSections[FOpen].Items.Count = 0 then
          aRect := FSections[FOpen].ClientRect
        else
          aRect := FSections[FOpen].Items[ItemNr].DisplayRect;
//        if aRect.Top < FSections[FOpen].ClientRect.Top then exit;
        InflateRect (aRect, -1,-1);
        aRect.Bottom := aRect.Top + AYSize;
//        if aRect.Bottom >= FSections[FOpen].ClientRect.Bottom then exit;
        y:=aRect.Top + 2; //(aRect.Bottom - aRect.Top) div 2;
        aCanvas.MoveTo (aRect.Left, y);
        aCanvas.LineTo (aRect.Right, y);
        aCanvas.Polygon ([Point(aRect.Left, y),
                         Point(aRect.Left + AXSize, y),
                         Point(aRect.Left, aRect.Bottom)]);
        aCanvas.Polygon ([Point(aRect.Right, y),
                         Point(aRect.Right - AXSize, y),
                         Point(aRect.Right, aRect.Bottom)]);
      end
    else
      if ItemNr = FSections[FOpen].Items.Count then
        begin
          aRect := FSections[FOpen].Items[ItemNr-1].DisplayRect;
          InflateRect (aRect, -1,-1);
          aRect.Top := aRect.Bottom - AYSize;
          y:=aRect.Top + AYSize - 1; //(aRect.Bottom - aRect.Top) div 2;
          aCanvas.MoveTo (aRect.Left, y);
          aCanvas.LineTo (aRect.Right, y);
          aCanvas.Polygon ([Point(aRect.Left, y),
                           Point(aRect.Left + AXSize, y),
                           Point(aRect.Left, aRect.Top)]);
          aCanvas.Polygon ([Point(aRect.Right, y),
                           Point(aRect.Right - AXSize, y),
                           Point(aRect.Right, aRect.Top)]);
        end
      else //just normal
        begin
          aRect := FSections[FOpen].Items[ItemNr].DisplayRect;
          InflateRect (aRect, -1,-1);
//          if aRect.Top < FSections[FOpen].ClientRect.Top then exit;
          aRect.Bottom := aRect.Top + AYSize;
          y:=aRect.Top + (aRect.Bottom - aRect.Top) div 2;
          aCanvas.MoveTo (aRect.Left + AXSize + 1, y);
          aCanvas.LineTo (aRect.Right - AXSize - 1, y);
          aCanvas.Polygon ([Point(aRect.Left, aRect.Top),
                           Point(aRect.Left, aRect.Bottom),
                           Point(aRect.Left + AXSize, y)]);
          aCanvas.Polygon ([Point(aRect.Right, aRect.Top),
                           Point(aRect.Right, aRect.Bottom),
                           Point(aRect.Right - AXSize, y)]);
        end;
  finally
    SelectClipRgn (aCanvas.Handle, 0);
    DeleteObject(rgn);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.delBar (ItemNr : Integer);
var
  aRect : TRect;
begin
  if (ItemNr = -1) or (ItemNr > FSections[FOpen].Items.Count) then exit;
  if ItemNr = FSections[FOpen].Items.Count then
    dec (ItemNr);
  aRect := FSections[FOpen].Items[ItemNr].DisplayRect;
  aRect.Top := aRect.Bottom - 7;
  PaintItem (ItemNr, true, Canvas, true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.StartRepeatedClick (upClick : boolean);
begin
  if Assigned(FTimerID) then exit;
  if upClick then
    begin
      if FSections[FOpen].ScrollPos < 4 then exit;
      FTimerID := TLMDTimer.Create(FScrollDelay, DoOnScrollBtnUp, true, FUseGlobalTimer)
    end
  else
    begin
      if FSections[FOpen].FScrollPos >= GetSectionItemSpaceNeeded - GetSectionItemSpaceExist then exit;
      FTimerID:=TLMDTimer.Create(FScrollDelay, DoOnScrollBtnDown, true, FUseGlobalTimer);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.EndRepeatedClick;
begin
  if not Assigned(FTimerID) then exit;
  FTimerId.Enabled:=false;

  if FUpBtnClicked and not FUpBtnActClicked then
    DoOnScrollBtnUp(Self);
  if FDnBtnClicked and not FDnBtnActClicked then
    DoOnScrollBtnDown(Self);
  FUpBtnActClicked := false;
  FDnBtnActClicked := false;

  FUpBtnClicked := false;
  FDnBtnClicked := false;
  FUpRgnClicked := false;
  FDnRgnClicked := false;

  //restore set to true, JH April 2001
  //otherwise the item could be drawen above the section buttons in the near
  PaintItem (FOldMouseOverItem, true, Canvas, true);

  FreeAndNil(FTimerID);
end;

{ -------------------------- public ------------------------------------------ }
constructor TLMDButtonBar.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FThemeMode := ttmNone;
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption]{ + [csDesignInteractive]};
  FSections := TLMDButtonBarSections.Create (self, TLMDButtonBarSection);
  FLastOpen := -1;
  FOpen := 0;
  FSectionHeight := 20;
  FSectionLeft := 20;
  FSectionRight := 20;
  FSelectedColor := clSilver;

  FLargeChangeLink := TChangeLink.Create;
  FLargeChangeLink.OnChange:=GetIMLChange;
  FSmallChangeLink := TChangeLink.Create;
  FSmallChangeLink.OnChange:=GetIMLChange;

  FOldMouseOverSectionButton := -1;
  FSectionButtonDown := -1;
  FOldMouseOverItem := -1;
  FSelectedItem := -1;
  FTransBtns := false;
  FOldBarPos := -1;
  FDragItemIndex := -1;
  FDragItemSection := -1;

  //needed for scrolling
  FUpBtnClicked := false;
  FDnBtnClicked := false;
  FUpRgnClicked := false;
  FDnRgnClicked := false;
  FUpBtnActClicked := false;
  FDnBtnActClicked := false;

  FSaveAndRestore := false;
  FUseBitmap := true;
  FFillHighlightedItem := true;
  FReadOnly := false;
  FSoftScroll := true;

  FSingleSectionMode := false;

  FLargeItemHeight := 60;
  FSmallItemHeight := 24;

  FEditObject := nil;

  FillObject.Style := sfBrush;
  FillObject.Brush.Color := clAppWorkSpace;

  FFont3D := TLMD3DCaption.create;
  FFont3D.OnChange := GetChange;

  FOrientation := bbHorizontal;

  FFocusStyle := bfGlyphText;

  FIniSaveOptions := [ssSectionName, ssSectionListIndex, ssItemNames, ssItemImageIndex, ssIconState];
  FIniKey:=IDS_BUTTONBARSAVE;
  FIniSection:=IDS_COMMON;
  FIniUse := ioNone;

  FScrollDelay := 50;
  FScrollStep := -1;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDButtonBar.Destroy;
begin
  //is only done if SaveAndRestore or IniStore is enabled

  StoreSections;

  EndRepeatedClick;

  FIniLink := nil; //remove pointer to ini component

  FFont3D.OnChange := nil;
  FreeAndNil(FFont3D);
  FSmallChangeLink.OnChange:=nil;
  FreeAndNil(FSmallChangeLink);
  FLargeChangeLink.OnChange:=nil;
  FreeAndNil(FLargeChangeLink);
  FreeAndNil(FSections);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.Loaded;
begin
  inherited Loaded;
  // 7.0
  if not (csDesigning in ComponentState) then
  // ---
    LoadSections;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.Assign (Source : TPersistent);
var
  S: TLMDButtonBar;
begin
  if Source is TLMDButtonBar then
    begin
      BeginUpdate;
      try
        S := TLMDButtonBar(Source);
        Font.Assign (S.Font);
        Font3D.Assign (S.Font3D);
        FillObject.Assign (S.FillObject);
        BackFX.Assign (S.BackFX);
        Bevel.Assign (S.Bevel);
        FSections.Clear;
        FSections.Assign (S.Sections);
        Transparent := S.Transparent;
        Cursor := S.Cursor;
        TransparentButtons := S.TransparentButtons;
        SingleSectionMode := S.SingleSectionMode;
        FillSelectedItem := S.FillSelectedItem;
        Orientation := S.Orientation;
        ScrollDelay := S.ScrollDelay;
        ScrollStep := S.ScrollStep;
        SoftScroll := S.SoftScroll;
        SaveAndRestore := S.SaveAndRestore;
        IniKey := S.IniKey;
        IniSection := S.IniSection;
        IniLink := S.IniLink;
        IniSaveOptions := S.IniSaveOptions;
        IniUse := S.IniUse;
        FocusStyle := S.FocusStyle;
        ImageList := S.ImageList;
        ImageIndex := S.ImageIndex;
        ListIndex := S.ListIndex;
        LargeImageList := S.LargeImageList;
        SmallImageList := S.SmallImageList;
        // 7.00.60
        SmallItemHeight:=S.SmallItemHeight;
        LargeItemHeight:=S.LargeItemHeight;
        FixedSectionRightBorder:=S.FixedSectionRightBorder;
        FixedSectionLeftBorder:=S.FixedSectionLeftBorder;
      finally
        EndUpdate;
      end;
    end
  else
    inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.DrawButton(Index : Integer; aCanvas : TCanvas);
var
  aRect : TRect;
  f3d   : TLMD3DCaption;
  ffx   : TLMDFXCaption;
  aLayout: TLMDGlyphTextLayout;
  lTheme: TLMDThemeMode;
begin
  if (index = -1) or (index >= FSections.Count) then exit;
  lTheme := UseThemeMode;
  aRect := FSections[Index].DisplayRect;

  //restore back if needed :-)

  aCanvas.Brush.Style := bsSolid;
  aCanvas.Brush.Color := clBtnFace;


  if lTheme = ttmNone then
    if (not FTransBtns) or not BackDrawArea(aCanvas, aRect, Point(0,0), 0) then //vb section edges in themed mode
      aCanvas.FillRect (aRect);

  if (FSectionButtonDown <> index) or not FMouseDown then //<- added VB Feb 2009
    begin
      if FOldMouseOverSectionButton <> index then //just a normal button
        begin
          if lTheme<>ttmNone then
            LMDThemeServices.DrawElement(lTheme, aCanvas.Handle, tbPushButtonNormal, aRect, @aRect)
          else
            LMDDrawStdFrame (aCanvas, aRect, lsSingleRaised, 0)
        end
      else // mouse over section button
        begin
          if lTheme<>ttmNone then
            LMDThemeServices.DrawElement(lTheme, aCanvas.Handle, tbPushButtonHot, aRect, @aRect)
          else
            LMDDrawStdFrame (aCanvas, aRect, lsRaised, 0)
        end
    end
  else // section button pressed
    begin
      if lTheme<>ttmNone then
        LMDThemeServices.DrawElement(lTheme, aCanvas.Handle, tbPushButtonPressed, aRect, @aRect)
      else
        LMDDrawStdFrame (aCanvas, aRect, lsLowered, 0);
    end;

  aCanvas.Pen.Width := 0;
  aCanvas.Pen.Color := clBtnFace;
  if FSections[Index].ParentFont then
    begin
      aCanvas.Font.Assign (Font);
      f3D := Font3D;
    end
  else
    begin
      if FSections[Index].Font <> nil then
        aCanvas.Font.Assign (FSections[Index].Font);
      f3D := FSections[Index].Font3D;
      if f3D = nil then exit; //button is not yet created!!
    end;
  ffx := TLMDFXCaption.Create;
  try
    ffx.Tracing := f3D.Tracing;
    ffx.LightDepth := f3D.LightDepth;
    ffx.ShadowDepth := f3D.ShadowDepth;
    ffx.ShadowColor := f3D.ShadowColor;
    ffx.LightColor := f3D.LightColor;
    ffx.Style := f3D.Style;
    if (FOrientation = bbHorizontal) or not LMDIsTrueTypeFont (Font) then
      ffx.Angle := 0
    else
      begin
        ffx.Angle := 90;
        aRect:=LMDAlignTextRect(agCenter, FSections[Index].Caption, ffx, aRect, Font,
                                true, false, 0);
      end;
     //following lines added for drawing the glyph of a section button, 7 Aug 2001, JH
     aLayout:= TLMDGlyphTextLayout.Create;
     try
       aLayout.Alignment := agCenter;
       //glyph and text will currently only work, iff orientation is horizontal ...
       if (FOrientation = bbHorizontal) then
         LMDDrawTextAndGlyph (aCanvas, FSections[index].Caption, ffx, aRect,
                         FSections[index].Glyph, nil, aLayout, false, false, true, [dtEnabled, dtClip], DT_CENTER or DT_END_ELLIPSIS)
       else
         LMDDrawTextExt (aCanvas, FSections[Index].Caption, ffx, aRect, DT_CENTER or DT_END_ELLIPSIS, [dtEnabled], nil);
     finally
       aLayout.Free;
     end;
  finally
    ffx.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.PaintSectionItems(restore : boolean; aCanvas : TCanvas; aOwnBmp : Boolean);
var
  hRect,
  bRect,
  aRect : TRect;
  i     : Integer;
  rgn   : HRGN;
  bmp   : TBitmap;
  toCanvas:TCanvas;

begin
  if (FOpen >= FSections.Count) or (
     FSections[FOpen].Items = nil) { occurs if Section is added during runtime }then exit;
  bmp:= nil;
  rgn := 0;
  //if we need to use an own bmp for flicker free display create it
  if aOwnBmp then
    bmp := TBitmap.Create;
  try
    with aCanvas, FSections[FOpen] do
      begin
        //get paintable area of section [ FOpen]
        aRect := FSections[FOpen].ClientRect;
        //save the original Rect (aRect could be changed in (bmp <> nil))
        bRect := aRect;
        //if we use an own bmp set size and get a pointer to the canvas (aOwnBmp = true)

        if (bmp <> nil) then
          begin
            OffsetRect (aRect, -aRect.Left, -aRect.Top);
            //aRect.Top = 0; aRect.Left = 0;
            bmp.Width := aRect.Right - aRect.Left;
            bmp.Height := aRect.Bottom - aRect.Top;
            toCanvas := bmp.Canvas;
          end
        else //otherwise just get a pointer to the direct canvas
          toCanvas := aCanvas;

        if restore then
          begin
            toCanvas.Brush.Style := bsSolid;
            toCanvas.Brush.Color := Color;

            if UseThemeMode <> ttmNone then
              begin
                toCanvas.Brush.Color := LMDThemeServices.GetThemeColor(UseThemeMode, teToolBar, 0, 0, TMT_FILLCOLOR);
                toCanvas.FillRect (aRect);
              end
            else
              if not BackDrawArea(toCanvas, aRect, Point(bRect.Left,bRect.Top), 0) then
                toCanvas.FillRect (aRect);
          end;

        i :=0;

        //if we do not use an own bmp we need to setup a region for keeping the items in the visible area
        if not aOwnBmp then
          with aRect do
            rgn := CreateRectRgn (Left, Top, Right, Bottom);
        try
          //set the region (not aOwnBmp)
          if rgn <> 0 then
            SelectClipRgn (Handle, rgn);

          if FOrientation = bbHorizontal then
            dec (aRect.Top, FScrollPos)
          else
            dec (aRect.Left, FScrollPos);
          //(bmp <> nil) => aRect.Top := - FScrollPos | (bmp = nil) => aRect.Top = ClientRect.Top - FScrollPos

          while i < Items.Count do
            begin
              //paint Item to aRect (aRect depends on canvas)
              if FOrientation = bbHorizontal then
                Items[i].DisplayRect := Rect (aRect.Left, aRect.Top, aRect.Right, aRect.Top + ItemHeight)
              else
                Items[i].DisplayRect := Rect (aRect.Left, aRect.Top, aRect.Left  + ItemHeight, aRect.Bottom);
              paintItem  (i, false, toCanvas, false);
              //we need to correct the rect value because of the bmp we had to paint to
              if aOwnBmp then
                begin
                  if FOrientation = bbHorizontal then
                    Items[i].DisplayRect := Rect (bRect.Left, bRect.Top + aRect.Top, bRect.Right, bRect.Top + aRect.Top + ItemHeight)
                  else
                    Items[i].DisplayRect := Rect (bRect.Left + aRect.Left, bRect.Top {+ aRect.Top}, bRect.Left+ aRect.Left + ItemHeight, bRect.Bottom{bRect.Top + aRect.Top});
                  hRect := Items[i].GlyphRect;
                  OffSetRect (hRect, bRect.Left, bRect.Top);
                  Items[i].GlyphRect := hRect;
                  hRect := Items[i].TextRect;
                  OffSetRect (hRect, bRect.Left, bRect.Top);
                  Items[i].TextRect := hRect;
                end;
//                Items[i].DisplayRect := Rect (ClientRect.Left,ClientRect.Top + aRect.Top , ClientRect.Right,ClientRect.Top + aRect.Top + ItemHeight);
              if FOrientation = bbHorizontal then
                aRect.Top := aRect.Top + ItemHeight
              else
                aRect.Left := aRect.Left + ItemHeight;
              inc(i);
            end;
          //now we need to paint the bmp on the destination canvas
          if aOwnBmp then
//            aCanvas.CopyRect (
            aCanvas.Draw (ClientRect.Left, ClientRect.Top, bmp);

        finally
          //clear
          if not aOwnBmp then
            begin
              SelectClipRgn (Handle, 0);
              DeleteObject (rgn);
            end
          else
            bmp.Free;
        end;
      end;
  finally
  end;
 if FOldBarPos <> -1 then
   PaintBar (FOldBarPos, aCanvas);

  ScrollBtnsVisible (aCanvas, 1);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.Paint;
var
  aRect   : TRect;
  i, k, visCount,
  j       : Integer;
  bmp     : TBitmap;
  aCanvas : TCanvas;
begin
  if (csLoading in ComponentState) then exit;

  //there is nothing to paint - just paint the background and exit
  if (FSections.Count = 0) then
    begin
      inherited Paint;
      exit;
    end;

  //if FOpen is > maximum then set it to 0 (just for safety)
  if (FOpen >= FSections.Count) then FOpen := 0;

  visCount := 0;
  for i:=0 to FSections.Count - 1 do
    if FSections[i].visible then
      inc(visCount);

  //if there's no visible sections, just paint the background and exit
  if (visCount = 0) then
    begin
      inherited Paint;
      exit;
    end;

  //move FOpen to nearest visible section
  while not FSections[FOpen].Visible do
    begin
      inc(FOpen);
      if (FOpen > FSections.Count) then
        FOpen := 0;
    end;

  //create a bitmap
  if FUseBitmap then
    bmp := TBitmap.Create
  else
    bmp := nil;

  try
    if FUseBitmap then //buffered drawing
      begin
        bmp.Width := Width;
        bmp.Height := Height;
        aCanvas := bmp.Canvas;
      end
    else //direct drawing
      aCanvas := Canvas;
    //get the ClientRect of the control
    aRect := ClientRect;

    aCanvas.Brush.Style := bsSolid;
    aCanvas.Brush.Color := Color;

    if UseThemeMode <> ttmNone then
      begin
        aCanvas.Brush.Color := LMDThemeServices.GetThemeColor(UseThemeMode, teToolBar, 0, 0, TMT_FILLCOLOR);
        aCanvas.FillRect (aRect);
      end
    else
      if not BackDrawArea(aCanvas, aRect, Point(0,0), 0) then
        aCanvas.FillRect (aRect);

    //false = no TransparentBorder :-)
    aRect := GetBevel.PaintBevel (aCanvas, aRect, false);
    //resize the rect by the painted bevel
//    InflateRect (aRect, -Bevel.BevelExtend, -Bevel.BevelExtend);

    if not FSingleSectionMode then
      begin
        //paint all section buttons on top
        //j is for correct calculation of displayrect
        j := 0;
        for i := 0 to FOpen do
          begin
            //skip invisible sections
            if not FSections[i].Visible then
              begin
                FSections[i].DisplayRect := Rect(0,0,0,0);
                continue;
              end;
            if FOrientation = bbHorizontal then
              FSections[i].DisplayRect := Rect (aRect.Left, aRect.Top + j*FSectionHeight, aRect.Right, aRect.Top + (j+1)*FSectionHeight)
            else
              FSections[i].DisplayRect := Rect (aRect.Left+ j*FSectionHeight, aRect.Top , aRect.Left+ (j+1)*FSectionHeight, aRect.Bottom );
            DrawButton (i, aCanvas);
            inc (j);
          end;

        //paint all section buttons on bottom
        //j is for correct calculation of displayrect
        j := FSections.Count-1;
        for i := FSections.Count-1 downto FOpen+1 do
          begin
            //skip invisible sections
            if not FSections[i].Visible then
              begin
                FSections[i].DisplayRect := Rect(0,0,0,0);
                continue;
              end;
            if FOrientation = bbHorizontal then
              FSections[i].DisplayRect := Rect (aRect.Left, aRect.Bottom - (FSections.Count-j)*FSectionHeight, aRect.Right, aRect.Bottom - (FSections.Count-j-1)*FSectionHeight)
            else
              FSections[i].DisplayRect := Rect (aRect.Right- (FSections.Count-j)*FSectionHeight, aRect.Top , aRect.Right- (FSections.Count-j-1)*FSectionHeight, aRect.Bottom );
            DrawButton (i, aCanvas);
            dec(j);
          end;

        //now save the clientrect of the currently open section (area for painting items)
        if FOrientation = bbHorizontal then
          begin
            aRect.Top := aRect.Top + (FOpen+1) * FSectionHeight + 1;
            aRect.Bottom := aRect.Bottom - (FSections.Count - FOpen - 1) * FSectionHeight - 1;
          end
        else
          begin
            aRect.Left := aRect.Left + (FOpen+1) * FSectionHeight + 1;
            aRect.Right := aRect.Right - (FSections.Count - FOpen - 1) * FSectionHeight - 1;
          end;

      end
    else
      begin
        aRect.Top := aRect.Top + 1;
        aRect.Bottom := aRect.Bottom - 1;
//        FSections[0].DisplayRect := Rect (0, 0, 0, 0);
      end;

    //space for scroll btns ...
    if FOrientation = bbHorizontal then
      begin
        aRect.Left := aRect.Left + FSectionLeft + GetBevel.BevelExtend;
        aRect.Right := aRect.Right - FSectionRight - GetBevel.BevelExtend;
      end
    else
      begin
        aRect.Top := aRect.Top + FSectionLeft + GetBevel.BevelExtend;
        aRect.Bottom := aRect.Bottom - FSectionRight - GetBevel.BevelExtend;
      end;

    FSections[FOpen].ClientRect := aRect;
    //paint all items of the currently open sections; do not restore back (is already done)
    PaintSectionItems(false, aCanvas, false { we do not need an own bmp });
    if FUseBitmap then //if we have drawn into a buffer we should paint the buffer on the canvas
      begin
        if (FLastOpen <> - 1) and (FSoftScroll) then
          if FOrientation = bbHorizontal then
            if FLastOpen < FOpen then
              begin //scroll down
                //area to be repainted
                aRect := Rect (0, (FLastOpen+1) * FSectionHeight, bmp.Width, FSections[FOpen].ClientRect.Bottom);
                k:=(FOpen - FLastOpen) * FSectionHeight;
                i := 1;
                //get faster if there is a longer distance
                j := (aRect.Bottom - aRect.Top - k) div 300 + 1;
                repeat
                  Canvas.CopyRect (Rect (aRect.Left, aRect.Bottom - i - k, aRect.Right, aRect.Bottom), bmp.Canvas,
                                   Rect (aRect.Left, aRect.Top, aRect.Right, aRect.Top + i + k));
                  inc(i, j);
                until (i >= (aRect.Bottom - aRect.Top - k + 1));
              end
            else
              begin
                //area to be repainted
                aRect := Rect (0, (FOpen+1) * FSectionHeight, bmp.Width, FSections[FOpen].ClientRect.Bottom + (FLastOpen - FOpen) * FSectionHeight);
                k:=(FLastOpen - FOpen) * FSectionHeight;
                i := 1;
                //get faster if there is a longer distance
                j := (aRect.Bottom - aRect.Top - k) div 300 + 1;
                repeat
                  Canvas.CopyRect (Rect (aRect.Left, aRect.Top, aRect.Right, aRect.Top + i + k), bmp.Canvas,
                                   Rect (aRect.Left, aRect.Bottom - i - k, aRect.Right, aRect.Bottom));
                  inc(i, j);
                until (i >= (aRect.Bottom - aRect.Top - k + 1));
              end
          else
            if FLastOpen < FOpen then
              begin //scroll right
                //area to be repainted
                aRect := Rect ((FLastOpen+1) * FSectionHeight, 0, FSections[FOpen].ClientRect.Right, bmp.Height);
                k:=(FOpen - FLastOpen) * FSectionHeight;
                i := 1;
                //get faster if there is a longer distance
                j := (aRect.Right - aRect.Left - k) div 300 + 1;
                repeat
                  Canvas.CopyRect (Rect (aRect.Right - i - k, aRect.Top, aRect.Right, aRect.Bottom), bmp.Canvas,
                                   Rect (aRect.Left, aRect.Top, aRect.Left + i + k, aRect.Bottom));
                  inc(i, j);
                until (i >= (aRect.Right - aRect.Left - k + 1));
              end
            else
              begin
                //area to be repainted
                aRect := Rect ((FOpen+1) * FSectionHeight, 0, FSections[FOpen].ClientRect.Right + (FLastOpen - FOpen) * FSectionHeight, bmp.Height);
                k:=(FLastOpen - FOpen) * FSectionHeight;
                i := 1;
                //get faster if there is a longer distance
                j := (aRect.Right - aRect.Left - k) div 300 + 1;
                repeat
                  Canvas.CopyRect (Rect (aRect.Left, aRect.Top, aRect.Left + i + k, aRect.Bottom), bmp.Canvas,
                                   Rect (aRect.Right- i - k, aRect.Top, aRect.Right, aRect.Bottom));
                  inc(i, j);
                until (i >= (aRect.Right - aRect.Left - k + 1));
              end;
        Canvas.Draw (0, 0, bmp);
      end;
      //set to -1 for avoiding scroll effect through normal repaint (action to resize, ..)
      FLastOpen := -1;
  finally
    if bmp <> nil then
      bmp.Free;
  end;

  //if we are editing repaint the Edit control ...
  if isEditing then FEdit.Repaint;
end;

{ ---------------------------------------------------------------------------- }
(*procedure TLMDButtonBar.Paint;
var
  aRect   : TRect;
  i, k,
  j       : Integer;
  bmp     : TBitmap;
  aCanvas : TCanvas;
begin
  if (csLoading in ComponentState) then exit;

  //there is nothing to paint - just paint the background and exit
  if FSections.VisibleCount = 0 then
    begin
      inherited Paint;
      exit;
    end;
  //create a bitmap
  if FUseBitmap then
    bmp := TBitmap.Create
  else
    bmp := nil;
  try
    if FUseBitmap then //buffered drawing
      begin
        bmp.Width := Width;
        bmp.Height := Height;

        aCanvas := bmp.Canvas;
      end
    else //direct drawing
      aCanvas := Canvas;

    //get the ClientRect of the control
    aRect := ClientRect;

    aCanvas.Brush.Style := bsSolid;
    aCanvas.Brush.Color := Color;
    if not BackDrawArea(aCanvas, aRect, Point(0,0), 0) then
      aCanvas.FillRect (aRect);

    //false = no TransparentBorder :-)
    aRect := Bevel.PaintBevel (aCanvas, aRect, false);

    //if FOpen is > maximum then set it to 0 (just for safety)
    if (FOpen >= FSections.Count) then FOpen := 0;

    //resize the rect by the painted bevel
//    InflateRect (aRect, -Bevel.BevelExtend, -Bevel.BevelExtend);

    if not FSingleSectionMode then
      begin

        //paint all section buttons on top
        j := 0;
        for i := 0 to FOpen do
          begin
            if FOrientation = bbHorizontal then
              FSections[i].DisplayRect := Rect (aRect.Left, aRect.Top + j*FSectionHeight, aRect.Right, aRect.Top + (j+1)*FSectionHeight)
            else
              FSections[i].DisplayRect := Rect (aRect.Left+ j*FSectionHeight, aRect.Top , aRect.Left+ (j+1)*FSectionHeight, aRect.Bottom );
            DrawButton (i, aCanvas);
            inc(j);
          end;

        //paint all section buttons on bottom
        k := 1;
        for i := FSections.Count-1 downto FOpen+1 do
          if FSections[i].Visible then
            begin
              if FOrientation = bbHorizontal then
                FSections[i].DisplayRect := Rect (aRect.Left, aRect.Bottom - k*FSectionHeight, aRect.Right, aRect.Bottom - (k-1)*FSectionHeight)
              else
                FSections[i].DisplayRect := Rect (aRect.Right- (k*FSectionHeight), aRect.Top , aRect.Right- (k-1)*FSectionHeight, aRect.Bottom );
              DrawButton (i, aCanvas);
              inc(k);
            end;

        //now save the clientrect of the currently open section (area for painting items)
        if FOrientation = bbHorizontal then
          begin
            aRect.Top := aRect.Top + (j+1) * FSectionHeight + 1;
            aRect.Bottom := aRect.Bottom - (k - 1) * FSectionHeight - 1;
          end
        else
          begin
            aRect.Left := aRect.Left + (j+1) * FSectionHeight + 1;
            aRect.Right := aRect.Right - (k - 1) * FSectionHeight - 1;
          end;

      end
    else
      begin
        aRect.Top := aRect.Top + 1;
        aRect.Bottom := aRect.Bottom - 1;
//        FSections[0].DisplayRect := Rect (0, 0, 0, 0);
      end;

    //space for scroll btns ...
    if FOrientation = bbHorizontal then
      begin
        aRect.Left := aRect.Left + 20 + Bevel.BevelExtend;
        aRect.Right := aRect.Right - 20 - Bevel.BevelExtend;
      end
    else
      begin
        aRect.Top := aRect.Top + 20 + Bevel.BevelExtend;
        aRect.Bottom := aRect.Bottom - 20 - Bevel.BevelExtend;
      end;

    FSections[FOpen].ClientRect := aRect;
    //paint all items of the currently open sections; do not restore back (is already done)
    PaintSectionItems(false, aCanvas, false { we do not need an own bmp });


    //up to here vis/invis
    if FUseBitmap then //if we have drawn into a buffer we should paint the buffer on the canvas
      begin
        if (FLastOpen <> - 1) and (FSoftScroll) then
          if FOrientation = bbHorizontal then
            if FLastOpen < FOpen then
              begin //scroll down
                //area to be repainted
                aRect := Rect (0, (FSections.VisibleUpTo(FLastOpen)+1) * FSectionHeight, bmp.Width, FSections[FOpen].ClientRect.Bottom);
                k:=(FSections.VisibleUpTo(FOpen) - FSections.VisibleUpTo(FLastOpen)) * FSectionHeight;
                i := 1;
                //get faster if there is a longer distance
                j := (aRect.Bottom - aRect.Top - k) div 300 + 1;
                repeat
                  Canvas.CopyRect (Rect (aRect.Left, aRect.Bottom - i - k, aRect.Right, aRect.Bottom), bmp.Canvas,
                                   Rect (aRect.Left, aRect.Top, aRect.Right, aRect.Top + i + k));
                  inc(i, j);
                until (i >= (aRect.Bottom - aRect.Top - k + 1));
              end
            else
              begin
                //area to be repainted
                aRect := Rect (0, (FSections.VisibleUpTo(FOpen)+1) * FSectionHeight, bmp.Width, FSections[FOpen].ClientRect.Bottom + (FSections.VisibleUpTo(FLastOpen) - FSections.VisibleUpTo(FOpen)) * FSectionHeight);
                k:=(FSections.VisibleUpTo(FLastOpen) - FSections.VisibleUpTo(FOpen)) * FSectionHeight;
                i := 1;
                //get faster if there is a longer distance
                j := (aRect.Bottom - aRect.Top - k) div 300 + 1;
                repeat
                  Canvas.CopyRect (Rect (aRect.Left, aRect.Top, aRect.Right, aRect.Top + i + k), bmp.Canvas,
                                   Rect (aRect.Left, aRect.Bottom - i - k, aRect.Right, aRect.Bottom));
                  inc(i, j);
                until (i >= (aRect.Bottom - aRect.Top - k + 1));
              end
          else
            if FLastOpen < FOpen then
              begin //scroll right
                //area to be repainted
                aRect := Rect ((FSections.VisibleUpTo(FLastOpen)+1) * FSectionHeight, 0, FSections[FOpen].ClientRect.Right, bmp.Height);
                k:=(FSections.VisibleUpTo(FOpen) - FSections.VisibleUpTo(FLastOpen)) * FSectionHeight;
                i := 1;
                //get faster if there is a longer distance
                j := (aRect.Right - aRect.Left - k) div 300 + 1;
                repeat
                  Canvas.CopyRect (Rect (aRect.Right - i - k, aRect.Top, aRect.Right, aRect.Bottom), bmp.Canvas,
                                   Rect (aRect.Left, aRect.Top, aRect.Left + i + k, aRect.Bottom));
                  inc(i, j);
                until (i >= (aRect.Right - aRect.Left - k + 1));
              end
            else
              begin
                //area to be repainted
                aRect := Rect ((FSections.VisibleUpTo(FOpen)+1) * FSectionHeight, 0, FSections[FOpen].ClientRect.Right + (FSections.VisibleUpTo(FLastOpen) - FSections.VisibleUpTo(FOpen)) * FSectionHeight, bmp.Height);
                k:=(FSections.VisibleUpTo(FLastOpen) - FSections.VisibleUpTo(FOpen)) * FSectionHeight;
                i := 1;
                //get faster if there is a longer distance
                j := (aRect.Right - aRect.Left - k) div 300 + 1;
                repeat
                  Canvas.CopyRect (Rect (aRect.Left, aRect.Top, aRect.Left + i + k, aRect.Bottom), bmp.Canvas,
                                   Rect (aRect.Right- i - k, aRect.Top, aRect.Right, aRect.Bottom));
                  inc(i, j);
                until (i >= (aRect.Right - aRect.Left - k + 1));
              end;
        Canvas.Draw (0, 0, bmp);
      end;
      //set to -1 for avoiding scroll effect through normal repaint (action to resize, ..)
      FLastOpen := -1;
  finally
    if bmp <> nil then
      bmp.Free;
  end;

  //if we are editing repaint the Edit control ...
  if isEditing then FEdit.Repaint;
end;*)

//reading and storing changed sections / items
{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.LoadSectionsFromStream (stream : TStream);
var
  myComp : TLMDButtonBarStoreComp;
begin
  FSections.Clear;
  mycomp := TLMDButtonBarStoreComp.Create(self);
  try
    stream.ReadComponent (myComp);
    FSections.Assign (myComp.Sections);
  finally
    myComp.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.StoreSectionsToStream (stream : TStream);
var
  myComp : TLMDButtonBarStoreComp;
begin
  myComp := TLMDButtonBarStoreComp.Create (self);
  try
    myComp.Sections.Assign (FSections);
    stream.WriteComponent (myComp);
  finally
    myComp.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.LoadSectionsFromFile (filename : String);
var
  myStream : TFileStream;
begin
  if not FileExists (filename) then exit;
  myStream := TFileStream.Create (filename, fmOpenRead);
  try
    LoadSectionsFromStream (myStream);
  finally
    myStream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.StoreSectionsToFile (filename : String);
var
  myStream : TFileStream;
begin
  myStream := TFileStream.Create (filename, fmCreate);
  try
    StoreSectionsToStream (myStream);
  finally
    myStream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.DoOnEditExit (Sender : TObject);
begin
  CancelEditMode;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.DoOnEditKeyDown (Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_RETURN : begin
                  if FEditObject is TLMDButtonBarSection then
                    (FEditObject as TLMDButtonBarSection).Caption := FEdit.Text;
                  if FEditObject is TLMDButtonBarItem then
                    (FEditObject as TLMDButtonBarItem).Caption := FEdit.Text;
                  CancelEditMode;
                  Key := 0;
                end;
    VK_ESCAPE : begin
                  CancelEditMode;
                  Key := 0;
                end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.DoOnScrollBtnUp (Sender : TObject);
var
//  msg : TMessage;
  i : Integer;
begin
  if FScrollStep <> -1 then
    i := FScrollStep
  else
    i := FSections[FOpen].ItemHeight;

  if FSections[FOpen].ScrollPos - i < 0 then
    begin
      FSections[FOpen].FScrollPos := 0;
    end
  else
    FSections[FOpen].FScrollPos := FSections[FOpen].ScrollPos - i;
  PaintSectionItems(true, Canvas, true { use own bmp for painting });
  //inform ourself that the "mouse position" has changed
//  msg.LParamLo := FLastMousePos.X;
//  msg.LParamHi := FLastMousePos.Y;
  PostMessage (self.Handle, WM_MOUSEMOVE, MK_LBUTTON,
    MakeLong(FLastMousePos.X, FLastMousePos.Y));
//    msg.lParam);
  FUpBtnActClicked := true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.DoOnScrollBtnDown (Sender : TObject);
var
//  msg : TMessage;
  i : Integer;
begin
  if FScrollStep <> -1 then
    i := FScrollStep
  else
    i := FSections[FOpen].ItemHeight;
  if FSections[FOpen].FScrollPos + i >= GetSectionItemSpaceNeeded - GetSectionItemSpaceExist then
    FSections[FOpen].FScrollPos := GetSectionItemSpaceNeeded - GetSectionItemSpaceExist
  else
    FSections[FOpen].FScrollPos := FSections[FOpen].ScrollPos + i;
  //inform ourself that the "mouse position" has changed
  PaintSectionItems(true, Canvas, true { use own bmp for painting });
//  msg.LParamLo := FLastMousePos.X;
//  msg.LParamHi := FLastMousePos.Y;
  PostMessage (self.Handle, WM_MOUSEMOVE, MK_LBUTTON,
      MakeLong(FLastMousePos.X, FLastMousePos.Y));
//    msg.lParam);
  FDnBtnActClicked := true;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBar.isEditing : Boolean;
begin
  result := FEdit <> nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.EnterEditMode (aValue : TPersistent);
var
  aRect : TRect;
begin
  if isEditing then
    CancelEditMode;
  FEditObject := aValue;
  if FEdit = nil then
    FEdit := TEdit.Create(self);
  FEdit.Parent := self;
  FEdit.Visible := true;
  FEdit.OnExit := DoOnEditExit;
  FEdit.OnKeyDown := DoOnEditKeyDown;
  if aValue is TLMDButtonBarSection then
    begin
      with (aValue as TLMDButtonBarSection).DisplayRect do
        FEdit.SetBounds (Left,Top, Right-Left, Bottom-Top);
      FEdit.Text := (aValue as TLMDButtonBarSection).Caption;
    end;
  if aValue is TLMDButtonBarItem then
    begin
      aRect := (aValue as TLMDButtonBarItem).TextRect;
      //if the item is not (completely) visible
      if (aValue as TLMDButtonBarItem).TextRect.Bottom > FSections[FOpen].ClientRect.Bottom then
        begin
          FSections[FOpen].FScrollPos := FSections[FOpen].FScrollPos + (aValue as TLMDButtonBarItem).TextRect.Bottom - FSections[FOpen].ClientRect.Bottom;
          RePaint;
        end;
      if aRect.Bottom = aRect.Top then aRect.Bottom := aRect.Top + Canvas.TextHeight ('Q');
      if aRect.Bottom - aRect.Top < 20 then aRect.Bottom := aRect.Top + 20;
      FEdit.SetBounds ((aValue as TLMDButtonBarItem).DisplayRect.Left,
                       (aValue as TLMDButtonBarItem).TextRect.Top,
                       (aValue as TLMDButtonBarItem).DisplayRect.Right-
                       (aValue as TLMDButtonBarItem).DisplayRect.Left,
                       aRect.Bottom - aRect.Top);
      FEdit.Text := (aValue as TLMDButtonBarItem).Caption;
    end;
  FEdit.SetFocus;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.CancelEditMode;
begin
  if FEdit = nil then exit;

  FEdit.Visible := false;
  FEdit.OnExit := nil;
  FEdit.OnKeyDown := nil;
  FEdit.Visible := false;
  //FEdit.Free;
  //FEdit := nil;
  FEditObject := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBar.mouseOverSection(XY : TPoint) : Integer;
var
  i : Integer;
begin
  result := -1;
  i := 0;
  while (result = -1) and (i < FSections.Count) do
    begin
      if PtInRect (FSections[i].DisplayRect, XY) then result := i;
      inc(i);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBar.mouseOverItem(XY : TPoint) : Integer;
var
  i : Integer;
begin
  result := -1;
  if (FSections.Count = 0) or (FOpen = -1) then exit;

  i := 0;
  while (result = -1) and (i < FSections[FOpen].Items.Count) do
    begin
{      aRect := FSections[FOpen].Items[i].GlyphRect;
      bRect := FSections[FOpen].Items[i].TextRect;
      if PtInRect (aRect, XY) or
         PtInRect (bRect, XY) then result := i; }
      if PtInRect (FSections[FOpen].Items[i].DisplayRect, XY) then result := i;
      inc(i);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  hit: Integer;
  allowClick : Boolean;
begin
  if FEdit <> nil then CancelEditMode;
  if (FSections.Count = 0) or (FOpen = -1) then
    begin //otherwise we could get an error
      FOldMouseOverItem := -1;
      FOldMouseOverSectionButton := -1;
      exit;
    end;
{  if FSectionButtonDown <> -1 then
    begin
      i := FSectionButtonDown;
      FSectionButtonDown := i;
      DrawButton (i);
    end;}
  if Button = mbLeft then
    begin
      if PtInRect (FSections[FOpen].UpBtnRect, Point(X,Y)) then
        begin
          FUpBtnClicked := true;
          StartRepeatedClick (true);
          exit;
        end;
      if PtInRect (FSections[FOpen].DnBtnRect, Point(X,Y)) then
        begin
          FDnBtnClicked := true;
          StartRepeatedClick (false);
          exit;
        end;
      if FOrientation = bbHorizontal then
        begin
          if PtInRect (Rect (FSections[FOpen].ClientRect.Left, FSections[FOpen].ClientRect.Top,
                             FSections[FOpen].ClientRect.Right, FSections[FOpen].ClientRect.Top + 5), Point(X,Y)) then
            begin
              FUpRgnClicked := true;
              StartRepeatedClick (true);
              exit;
            end;
          if PtInRect (Rect (FSections[FOpen].ClientRect.Left, FSections[FOpen].ClientRect.Bottom - 5,
                             FSections[FOpen].ClientRect.Right, FSections[FOpen].ClientRect.Bottom), Point(X,Y)) then
            begin
              FDnRgnClicked := true;
              StartRepeatedClick (false);
              exit;
            end;
        end
      else //vertical orientation of buttonbar
        begin
          if PtInRect (Rect (FSections[FOpen].ClientRect.Left, FSections[FOpen].ClientRect.Top,
                             FSections[FOpen].ClientRect.Left+5, FSections[FOpen].ClientRect.Bottom), Point(X,Y)) then
            begin
              FUpRgnClicked := true;
              StartRepeatedClick (true);
              exit;
            end;
          if PtInRect (Rect (FSections[FOpen].ClientRect.Right - 5, FSections[FOpen].ClientRect.Top,
                             FSections[FOpen].ClientRect.Right, FSections[FOpen].ClientRect.Bottom), Point(X,Y)) then
            begin
              FDnRgnClicked := true;
              StartRepeatedClick (false);
              exit;
            end;
        end;
      FMouseDown := true;
      if not PtInRect (FSections[FOpen].ClientRect, Point(X,Y)) then
        begin
          hit := mouseOverSection(Point(X,Y));
          allowClick := true;
          //this event is implemented in the SetInteger method as well if the Open parameter is to be changed by direct property access (through code)
          if Assigned (FOnBeforeSectionChange) then
            FOnBeforeSectionChange (self, FOpen, hit, allowClick);
          if allowClick then
            begin
              if hit <> FSectionButtonDown then
                if FSections[hit].Enabled then
                  begin
                    FSectionButtonDown := hit;
                    DrawButton (FSectionButtonDown, Canvas);
                  end;
              if hit <> -1 then
                DoSectionChange(hit);
            end
        end
      else
        begin
          hit := mouseOverItem(Point(X,Y));

          //save current mouse pos
          FMouseClickPos := Point(X,Y);

          if hit <> -1 then
            begin
              allowClick := true;
              if FSections[FOpen].Items[hit].Enabled then
                begin
                  if Assigned (FOnBefItemClick) then FOnBefItemClick (self, FOpen, hit, allowClick);
                  if allowClick then
                    SelectedItem := hit;
                end;
            end;
        end;
    end
  else
    inherited MouseDown(button, Shift,X,Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.MouseMove(Shift: TShiftState; X, Y: Integer);
const
  insensitiveXArea = 10;
  insensitiveYArea = 8;

var
  i,
  hit : Integer;

  function IncSeconds (aValue : TDateTime) : TDateTime;
  var
    h,m,s,hs : Word;
  begin
    DecodeTime (aValue, h, m, s, hs);

    Inc (s, 1);

    m := m + s div 60;
    s := s mod 60;

    h := h + m div 60;
    m := m mod 60;

    //day := day + h div 24;
    h := h mod 24;

    result := EncodeTime (h, m, s, hs);
  end;

begin
  if FSections.Count = 0 then exit; //otherwise we would get an error

  //backup last mouse pos (for scrolling)
  FLastMousePos := Point (X, Y);

  //if there are no sections there are no items there is nothing to do
  if (FSections.Count = 0) or (FOpen = -1) then exit;
  if csDesigning in ComponentState then exit;

  //if the mouse moves out of one of the scrolling areas disable scrolling
  if not PtInRect (FSections[FOpen].UpBtnRect, Point(X,Y)) and FUpBtnClicked then
    EndRepeatedClick;
  if not PtInRect (FSections[FOpen].DnBtnRect, Point(X,Y)) and FDnBtnClicked then
    EndRepeatedClick;
  if not PtInRect (Rect (FSections[FOpen].ClientRect.Left, FSections[FOpen].ClientRect.Top,
                     FSections[FOpen].ClientRect.Right, FSections[FOpen].ClientRect.Top + 5), Point(X,Y)) and FUpRgnClicked then
    EndRepeatedClick;
  if not PtInRect (Rect (FSections[FOpen].ClientRect.Left, FSections[FOpen].ClientRect.Bottom - 5,
                     FSections[FOpen].ClientRect.Right, FSections[FOpen].ClientRect.Bottom), Point(X,Y)) and FDnRgnClicked then
    EndRepeatedClick;

  //if the mouse moves in one of the scrolling areas enable scrolling
  if PtInRect (FSections[FOpen].UpBtnRect, Point(X,Y)) and FMouseDown then
    begin
      FUpBtnClicked := true;
      StartRepeatedClick(true);
    end;
  if PtInRect (FSections[FOpen].DnBtnRect, Point(X,Y)) and FMouseDown then
    begin
      FDnBtnClicked := true;
      StartRepeatedClick(false);
    end;
  if PtInRect (Rect (FSections[FOpen].ClientRect.Left, FSections[FOpen].ClientRect.Top,
                     FSections[FOpen].ClientRect.Right, FSections[FOpen].ClientRect.Top + 5), Point(X,Y)) and FMouseDown then
    begin
      FUpRgnClicked := true;
      StartRepeatedClick(true);
    end;
  if PtInRect (Rect (FSections[FOpen].ClientRect.Left, FSections[FOpen].ClientRect.Bottom - 5,
                     FSections[FOpen].ClientRect.Right, FSections[FOpen].ClientRect.Bottom), Point(X,Y)) and FMouseDown then
    begin
      FDnRgnClicked := true;
      StartRepeatedClick(false);
    end;

  if not PtInRect (FSections[FOpen].ClientRect, Point(X,Y)) then
    begin //we have to be somewhere on the section buttons
      if FOldMouseOverItem <> -1 then
        begin
          i := FOldMouseOverItem;
          if Assigned (FOnMouseExitItem) then FOnMouseExitItem (self, FOldMouseOverItem);
          FOldMouseOverItem := -1;
          //restore last item mouse was over
          PaintItem (i, true, Canvas, true);
        end;

      //get section button nr mouse is above
      hit := mouseOverSection(Point(X,Y));
      //we are on another section btn than the last one
      if (hit <> FOldMouseOverSectionButton) and (FOldMouseOverSectionButton <> -1) then
        begin
          i := FOldMouseOverSectionButton;
          FOldMouseOverSectionButton := -1;
          DrawButton (i, Canvas);
        end;
      //if we are on another section button (or far away of any section buttons)and the left mouse btn is pressed
      if (hit <> FSectionButtonDown) and (FMouseDown) and (hit <> -1) and (FSections[hit].Enabled) then
        begin
          i := FSectionButtonDown;
          FSectionButtonDown := hit;
          if i <> -1 then //it should always be true
            DrawButton (i, Canvas);
          if FSectionButtonDown <> -1 then
            DrawButton (FSectionButtonDown, Canvas);
        end;
      //we are above a button
      if (hit <> -1) then
        begin
          if FMouseDown then //select new section
            Open := hit;
          if csDesigning in ComponentState then
            FSectionButtonDown := -1;
        end;
      if (hit <> FOldMouseOverSectionButton) then
        begin
          FOldMouseOverSectionButton := hit;
          DrawButton (hit, Canvas);
        end;
      if (hit <> -1) and (FSections[hit].ShowHint) then
        Hint := FSections[hit].Hint;
    end
  else //we should be in the items area
    begin
      if (FOldMouseOverSectionButton <> -1) then
        begin
          i := FOldMouseOverSectionButton;
          FOldMouseOverSectionButton := -1;
          DrawButton (i, Canvas);
        end;

      //if FMouseDown is true we are dragging a item
      if not FMouseDown then
        begin
          hit := mouseOverItem(Point(X,Y));
          if {(hit <> -1)and May 02 JH } (hit <> FOldMouseOverItem) then
            begin
              if Assigned (FOnMouseExitItem) then FOnMouseExitItem (self, FOldMouseOverItem);
              if hit <> -1 then //May 02, JH
                if Assigned (FOnMouseEnterItem) then FOnMouseEnterItem (self, hit);
              i := FOldMouseOverItem;
              FOldMouseOverItem := -1;
              if i <> -1 then
                //restore last item mouse was over
                PaintItem (i, true,Canvas, true);
              FOldMouseOverItem := hit;
              if hit <> -1 then //May 02, JH -> otherwise top most, bottom item will not be redrawn on mouse exist
                begin
                  PaintItem (hit, true, Canvas, true);
                  if FSections[FOpen].{Items[hit].}ShowHint then
                    begin
                      if FSections[FOpen].FHintWindow = nil then  //added 2 lines, JH, FEB 2002
                        FSections[FOpen].FHintWindow := HintWindowClass.Create(self);
                      FSections[FOpen].StopHintTimer;
                      FSections[FOpen].FHintWindow.ReleaseHandle;
                      FSections[FOpen].FHintWindow.Caption := FSections[FOpen].Items[hit].Hint;
                      FSections[FOpen].StartHintTimer(FSections[FOpen].FHintPause, htShow);
                    end;
                end;
            end;
        end
      else //dragging
        //only start dragging if mouse is outside of one of the specified parameters ...
        if (not ((FMouseClickPos.X >= x - insensitiveXArea) and (FMouseClickPos.X <= x + insensitiveXArea)) or
            not ((FMouseClickPos.Y >= y - insensitiveYArea) and (FMouseClickPos.Y <= y + insensitiveYArea))) and
            not FReadOnly then
          begin
            hit := mouseOverItem(Point(X,Y));
            if (FSections[FOpen].Items.Count = 0) or ((hit = -1) and (Y > FSections[FOpen].Items[FSections[FOpen].Items.Count-1].DisplayRect.Bottom)) then
              hit := FSections[FOpen].Items.Count;
            if FDragItemIndex <> -1 then
              if (FOpen = FDragItemSection) and ((hit = FDragItemIndex) or
                                                 (hit = FDragItemIndex+1)) then
                Screen.Cursor := crNoDrop
              else
                Screen.Cursor := crDrag;
            if not FSections[FOpen].ReadOnly then
              OldBarPos := hit
            else
              begin
                Screen.Cursor := crNoDrop;
                OldBarPos := -1;
              end;
          end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i, j: Integer;
  ins,
  di  : TLMDButtonBarItem;
begin
  FOldMouseOverItem := mouseOverItem(Point(X,Y));
  if FSections.Count = 0 then exit; //otherwise we would get an error
  EndRepeatedClick;
  if Screen.Cursor <> Cursor then
    Screen.Cursor := Cursor;
  FMouseDown := false;
  if FSectionButtonDown <> -1 then
    begin
      i := FSectionButtonDown;
      FSectionButtonDown := -1;
      DrawButton (i, Canvas);
    end;
  if (not FReadOnly) and (not FSections[FOpen].ReadOnly) and (FDragItemIndex <> -1) and ((FDragItemIndex <> mouseOverItem(Point(X,Y))) or (FOpen <> FDragItemSection)) then
    begin //dragged with success (now we have to change the indexes)
      di := FSections[FDragItemSection].Items[FDragItemIndex];
      ins := FSections[FOpen].Items.Add;
      ins.Assign (di);
      i := mouseOverItem(Point(X,Y));
      if (i <> -1) and (i < FSections[FOpen].Items.Count) then
        ins.index := i;
      di.Free;
      FDragItemIndex := -1;
      SelectedItem := -1; //added JH March 2002 (fixed small bug - dragging only once)
      GetChange(nil);
    end;

  //moved here from top of method ny JH, Dec 2001
  //everything should be handled BEFORE events are fired
  //* this ensures correct painting operations if the control's parent loosed
  //  the focus in between
  //* this ensures correct behaviour if section currently open is changed by
  //  event code
  if (SelectedItem <> -1) and (FDragItemIndex <> -1) then
    begin
      i := SelectedItem;  //backup the selected item
      SelectedItem := -1; //restore btn look
      j := FOpen;         //backup currently opened section
      // 7.01 order of calling changed
      // now first internal click method, then main click event
      if (j<FSections.Count) and (i<FSections[j].Items.Count) and Assigned(FSections[j].Items[i].OnClick) then
        FSections[j].Items[i].OnClick (self);
      if Assigned(FOnItemClick) then
        FOnItemClick (self, j, i);
    end;
end;

{ ---------------------------------------------------------------------------- }
{function TLMDButtonBar.Empty : boolean;
begin
  result := FSections.Count = 0;
end;}

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.CMMouseLeave(var Message : TMessage);
var
  i : Integer;
begin
  inherited;
  FMouseDown := false; //VB Feb 2009 BTS 682
  //if there has been a highlighted section button we should repaint this button before leaving the control
  if (FOldMouseOverSectionButton <> -1) then
    begin
      i := FOldMouseOverSectionButton;
      FOldMouseOverSectionButton := -1;
      DrawButton (i, Canvas);
    end;
  if (FOldMouseOverItem <> -1) then
    begin
      if Assigned (FOnMouseExitItem) then FOnMouseExitItem (self, FOldMouseOverItem);
      i := FOldMouseOverItem;
      FOldMouseOverItem := -1;
      PaintItem (i, true, Canvas, true);
    end;
  if FOpen < FSections.Count then
    FSections[FOpen].CancelHint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.CMExit(var Message: TCMExit);
begin
  inherited;
{  FOldMouseOverItem := -1;
  FMouseDown := false;}
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBar.GetSectionItemSpaceNeeded : Integer;
var
  i : Integer;
begin
  //return the space (in pixels) needed to draw all items of the section
//  result := FSections[FOpen].Items.Count * FSections[FOpen].ItemHeight + 5;
  result := 5;
  for i := 0 to FSections[FOpen].Items.Count - 1 do
    inc (result, FSections[FOpen].Items[i].ItemHeight);
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBar.GetSectionItemSpaceExist : Integer;
begin
  //return the space which exists to draw items of the current section
  if FOrientation = bbHorizontal then
    result := FSections[FOpen].ClientRect.Bottom - FSections[FOpen].ClientRect.Top
  else
    result := FSections[FOpen].ClientRect.Right - FSections[FOpen].ClientRect.Left;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.DragOver(Source: TObject; X, Y: Integer; State: TDragState;var Accept: Boolean);
begin
  inherited DragOver (Source, X, Y, State, Accept);
  if Assigned (FOnDragOver) then FOnDragOver (self, Source, X, Y, State, Accept, FOpen, FOldMouseOverItem);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.DragDrop(Source: TObject; X, Y: Integer);
begin
  inherited DragDrop (Source, X, Y);
  if Assigned (FOnDragDrop) then FOnDragDrop (self, Source, X, Y, FOpen, FOldMouseOverItem);
end;

{ ---------------------------------- public ---------------------------------- }
procedure TLMDButtonBar.AddSection;
var
  bbs : TLMDButtonBarSection;
begin
  bbs := FSections.Add;
  EnterEditMode (bbs);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.AddNamedSection(aString : String);
var
  bs : TLMDButtonBarSection;
begin
  bs := FSections.Add;
  bs.Caption := aString;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.DelSection;
begin
  if FSections.Count = 0 then exit;
  if FOpen = FSections.Count then
    dec (fopen);
  if FOldMouseOverSectionButton <> -1 then
    FSections[FOldMouseOverSectionButton].Free
  else
    FSections[FOpen].Free
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.RemoveSection(index : Integer);
begin
  if index >= FSections.Count then exit;
  if FOpen = FSections.Count then
    dec (fopen);
  FSections[index].Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.RenSection;
begin
  if FSections.Count = 0 then exit;
  if Index=-1 then
    begin
      if (FOldMouseOverSectionButton = -1) then
        EnterEditMode (FSections[Open])
      else
        if (FOldMouseOverSectionButton < FSections.Count) then
          EnterEditMode (FSections[FOldMouseOverSectionButton]);
    end
  else
    if Index<FSections.Count then
      EnterEditMode (FSections[Index]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.RenSectionTo (aString : String);
begin
  if FSections.Count = 0 then exit;
  FSections[FOpen].Caption := aString;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBar.AddItem : TLMDButtonBarItem;
begin

  if FSections.Count = 0 then
    begin
      result:=nil;
      exit;
    end;
  result := FSections[FOpen].Items.Add;
  FSections[FOpen].Items[FSections[FOpen].Items.Count - 1].Caption := 'noname';
  Repaint;
  EnterEditMode (FSections[FOpen].Items[FSections[FOpen].Items.Count - 1]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBar.AddNamedItem(aString : String) : TLMDButtonBarItem;
var
  bi : TLMDButtonBarItem;
begin
  if FSections.Count = 0 then
    begin
      result:=nil;
      exit;
    end;
  bi := FSections[FOpen].Items.Add;
  bi.Caption := aString;
  result := bi;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBar.AddNamedItemToSection(SecNr : Integer; aString : String) : TLMDButtonBarItem;
var
  bi : TLMDButtonBarItem;
begin
  if FSections.Count <= SecNr then
    begin
      result:=nil;
      exit;
    end;
  bi := FSections[SecNr].Items.Add;
  bi.Caption := aString;
  result := bi;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.DelItem;
begin
  if FSections.Count = 0 then exit;
  if (FOldMouseOverItem = -1) or (FSections[FOpen].Items.Count <= FOldMouseOverItem) then
    exit;
  FSections[FOpen].Items[FOldMouseOverItem].Free;
  PaintSectionItems(true, Canvas, true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.RenItem;
begin
  if FSections.Count = 0 then exit;
  if (FOldMouseOverItem = -1) or (FOldMouseOverItem >= FSections[FOpen].Items.Count) then
    exit;
  EnterEditMode (FSections[FOpen].Items[FOldMouseOverItem]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.RenItemTo (aString : String);
begin
  if FSections.Count = 0 then exit;
  if FSelectedItem <> -1 then
    FSections[Open].Items[FSelectedItem].Caption := aString;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBar.NextSection : Integer;
begin
  if FOpen < FSections.Count - 1 then
    Open := Open + 1;
  result := FOpen;
end;

{ ---------------------------------------------------------------------------- }
function TLMDButtonBar.PrevSection : Integer;
begin
  if FOpen > 0 then
    Open := Open - 1;
  result := FOpen;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.SetListIndex(const Value: Integer);
begin
  if FListIndex<>Value then
    begin
      FListIndex := Value;
      TLMDButtonBarSections(Collection).Update(self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.SetSectionLeft(const Value: Integer);
begin
  if FSectionLeft<>Value then
    begin
      FSectionLeft := Value;
      GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.SetSectionRight(const Value: Integer);
begin
  if FSectionRight<>Value then
    begin
      FSectionRight := Value;
      GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBarSection.SetItemFont(const aValue: TFont);
begin
  FItemFont.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.WMMouseWheel(var Message: TMessage);
var
  LDelta: integer;
begin
  LDelta := integer(Message.wParam);
  if LDelta > 0 then
    DoOnScrollBtnUp(self)
  else
    DoOnScrollBtnDown(self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDButtonBar.WMKeyUp(var Message: TMessage);
begin
  with Message do
    case integer(wParam) of
      VK_UP:
        DoOnScrollBtnUp(self);
      VK_DOWN:
        DoOnScrollBtnDown(self);
      VK_PRIOR:
        PrevSection;
      VK_NEXT:
        NextSection;
    end;
end;

end.
