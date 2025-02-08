unit LMDExplorerBar;
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

LMDExplorerBar unit (DD, RM, AH)
-------------------------------
Implements TLMDExplorerBar and all helper classes.

Changes
-------
Release X.XX.XX
- WordWrap fixed for TLMDExplorerBarLabel

Release 2.01.50 (February 2008)
+ ScrollBar optimizations (--> ArrangeSections)

Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows,Messages,Classes, Controls, Graphics, ImgList, Types,
  ActnList, ExtCtrls, StdCtrls, Forms, SysUtils,
  LMDBarConsts, LMDBarBase, LMDClass, LMDControl, LMDBarHTMLLabel, LMDTypes, LMDSysIn;

type
  TLMDExplorerBarSection=class;
  TLMDExplorerBarSections=class;
  TLMDExplorerBarItem=class;
  TLMDExplorerBarItems=class;
  TLMDExplorerBar=class;
  TLMDExplorerBarStorage=class;
  TLMDExplorerBarPanel=class;

  TLMDExplorerBarLabel=class(TLMDBarHTMLLabel)
  private
    FSection : TLMDExplorerBarSection;
  protected
    procedure   MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure   MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure Paint;override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TLMDExplorerBarStyle=(ebsItemList,ebsInformation,ebsContainer,ebsOwnerDraw);

  TLMDBarPaintInfo=packed record
    ExplorerBar  : TLMDExplorerBar;
    Handle : THandle;
    Canvas : TCanvas;
    Rect   : TRect;
    UseXP  : Boolean;
  end;

  TLMDBarDrawInfo=packed record
    PaintInfo : TLMDBarPaintInfo;
  end;

  TLMDBarHeaderState = (bhsNormal,bhsHighlight,bhsPressed);
  TLMDBarHeaderStyle = (bhsRounded, bhsRect);

  TLMDBarMeasureHeightEvent = procedure (Sender:TLMDExplorerBarSection;var Height:Integer) of object;
  TLMDBarDrawInfoEvent = procedure (Sender:TLMDExplorerBarSection;DrawInfo:TLMDBarDrawInfo) of object;
  TLMDBarSortEvent = function (Sender:TLMDExplorerBarSection;First,Second:TLMDExplorerBarItem):Integer of object;

  { ************************** TLMDExplorerBarController **********************}
  TLMDExplorerBarController=class(TLMDBarController)
  private
    FCtlXP: Boolean;
    FSectionsSpace: Integer;
    FVSpace: Integer;
    FHSpace: Integer;
    FExpandGlyph: TBitmap;
    FCollapseGlyph: TBitmap;
    FItemsHightlightColor: TColor;
    FHeaderStartColor: TColor;
    FColor: TColor;
    FItemsColor: TColor;
    FSectionBackColor: TColor;
    FItemsDisableColor: TColor;
    FHeaderEndColor: TColor;
    FHightlightColor: TColor;
    FHeaderFont: TFont;
    FHeaderStyle: TLMDBarHeaderStyle;
    procedure SetCollapseGlyph(const Value: TBitmap);
    procedure SetColor(const Value: TColor);
    procedure SetCtlXP(const Value: Boolean);
    procedure SetExpandGlyph(const Value: TBitmap);
    procedure SetHeaderEndColor(const Value: TColor);
    procedure SetHeaderFont(const Value: TFont);
    procedure SetHeaderStartColor(const Value: TColor);
    procedure SetHeaderStyle(const Value: TLMDBarHeaderStyle);
    procedure SetHightlightColor(const Value: TColor);
    procedure SetHSpace(const Value: Integer);
    procedure SetItemsColor(const Value: TColor);
    procedure SetItemsDisableColor(const Value: TColor);
    procedure SetItemsHightlightColor(const Value: TColor);
    procedure SetSectionBackColor(const Value: TColor);
    procedure SetSectionsSpace(const Value: Integer);
    procedure SetVSpace(const Value: Integer);
  protected
    procedure   AssignTo(Dest: TPersistent); override;
    procedure GetChange(Sender:TObject);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;override;
    procedure   UpdateParent;
  published
    property    HeaderStyle:TLMDBarHeaderStyle read FHeaderStyle write SetHeaderStyle default bhsRounded;
    property    Color:TColor read FColor write SetColor default LEB_BACK_COLOR;
    property    HeaderStartColor:TColor read FHeaderStartColor write SetHeaderStartColor default LEB_HEADER_START;
    property    HeaderEndColor:TColor read FHeaderEndColor write SetHeaderEndColor default LEB_HEADER_END;
    property    ItemsColor:TColor read FItemsColor write SetItemsColor default LEB_HEADER_COLOR;
    property    ItemsHightlightColor:TColor read FItemsHightlightColor write SetItemsHightlightColor default LEB_HEADER_HIGHLIGHT;
    property    ItemsDisableColor:TColor read FItemsDisableColor write SetItemsDisableColor default LEB_ITEM_DISABLE;
    property    SectionBackColor:TColor read FSectionBackColor write SetSectionBackColor default LEB_SECTION_BACK;
    property    HightlightColor:TColor read FHightlightColor write SetHightlightColor default LEB_HEADER_HIGHLIGHT;
    property    HeaderFont:TFont read FHeaderFont write SetHeaderFont;
    property    CollapseGlyph:TBitmap read FCollapseGlyph write SetCollapseGlyph;
    property    ExpandGlyph:TBitmap read FExpandGlyph write SetExpandGlyph;
    property    CtlXP:Boolean read FCtlXP write SetCtlXP default True;
    property    VSpace:Integer read FVSpace write SetVSpace default LEB_VSPACE;
    property    HSpace:Integer read FHSpace write SetHSpace default LEB_HSPACE;
    property    SectionsSpace:Integer read FSectionsSpace write SetSectionsSpace default LEB_VSECTIONS_SPACE;
  end;

  { ********************** TLMDExplorerBarBasePanel  ************************* }
  // introduces advanced double buffer technique
  TLMDExplorerBarBasePanel=class(TLMDBaseCustomControl)
  private
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  end;

  { ********************** TLMDExplorerBarPanel  ***************************** }
  TLMDExplorerBarPanel=class(TLMDExplorerBarBasePanel)
  protected
    Section : TLMDExplorerBarSection;
    procedure CreateParams(var Params: TCreateParams);override;
    procedure   Paint;override;
    procedure   Loaded;override;
    procedure   MouseMove(Shift: TShiftState; X, Y: Integer);override;
    procedure   MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure   MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure   Notification(AComponent: TComponent; Operation: TOperation);override;
    procedure   CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;override;
    end;

  { ********************** TLMDExplorerBarActionLink ************************* }
  TLMDExplorerBarActionLink = class(TActionLink)
  protected
    FClient: TLMDExplorerBarItem;
    procedure AssignClient(AClient: TObject); override;
    function IsCaptionLinked: Boolean; override;
    function IsEnabledLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;
    function IsVisibleLinked: Boolean; override;
    function IsOnExecuteLinked: Boolean; override;
    procedure SetCaption(const Value: string); override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetHint(const Value: string); override;
    procedure SetImageIndex(Value: Integer); override;
    procedure SetVisible(Value: Boolean); override;
    procedure SetOnExecute(Value: TNotifyEvent); override;
  end;

  TLMDExplorerBarActionLinkClass = class of TLMDExplorerBarActionLink;

  TLMDExplorerBarOnGetItemSettings=procedure(Sender:TObject; Section:TLMDExplorerBarSection; Item:TLMDExplorerBarItem; Font:TFont; var Caption:String) of object;

  { ********************** TLMDExplorerBarItem  ****************************** }
  TLMDExplorerBarItem=class(TCollectionItem)
  private
    FActionLink :TLMDExplorerBarActionLink;
    FCaptionLong:Boolean;
    FVisible: Boolean;
    FEnabled: Boolean;
    FTag: Integer;
    FImageIndex: Integer;
    FData: Pointer;
    FCaption: String;
    FHint: String;
    FOnMouseExit: TNotifyEvent;
    FOnGetItemSettings: TLMDExplorerBarOnGetItemSettings;
    FOnMouseEnter: TNotifyEvent;
    FOnClick: TNotifyEvent;
    procedure DoActionChange(Sender:TObject);
    function GetAction: TBasicAction;
    function IsCaptionStored: Boolean;
    function IsEnabledStored: Boolean;
    function IsHintStored: Boolean;
    function IsImageIndexStored: Boolean;
    function IsOnClickStored: Boolean;
    function IsVisibleStored: Boolean;
    procedure SetAction(const Value: TBasicAction);
    procedure SetCaption(const Value: String);
    procedure SetEnabled(const Value: Boolean);
    procedure SetImageIndex(const Value: Integer);
    procedure SetVisible(const Value: Boolean);
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); dynamic;
    procedure Changed;virtual;
    procedure DoMouseEnter;dynamic;
    procedure DoMouseExit;dynamic;
    function  GetDisplayName:String;override;
    //function  GetHeight(Canvas : TCanvas):Integer;
    function  GetActionLinkClass: TLMDExplorerBarActionLinkClass; dynamic;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
  public
    constructor Create(Collection: TCollection);override;
    destructor  Destroy;override;
    procedure   Assign(Source: TPersistent); override;
    procedure   Click; dynamic;
    procedure   InitiateAction;dynamic;
    property  Data:Pointer read FData write FData;
    property  IsLongCaption:Boolean read FCaptionLong;
    property  ActionLink: TLMDExplorerBarActionLink read FActionLink write FActionLink;
  published
    property Action: TBasicAction read GetAction write SetAction;
    property Caption:String read FCaption write SetCaption stored IsCaptionStored;
    property Enabled:Boolean read FEnabled write SetEnabled stored IsEnabledStored;
    property Visible:Boolean read FVisible write SetVisible stored IsVisibleStored;
    property Hint:String read FHint write FHint stored IsHintStored;
    property ImageIndex:Integer read FImageIndex write SetImageIndex stored IsImageIndexStored;
    property Index;
    property Tag:Integer read FTag write FTag default 0;

    property OnClick:TNotifyEvent read FOnClick write FOnClick stored IsOnClickStored;
    property OnGetItemSettings:TLMDExplorerBarOnGetItemSettings read FOnGetItemSettings write FOnGetItemSettings;
    property OnMouseEnter:TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseExit:TNotifyEvent read FOnMouseExit write FOnMouseExit;
  end;

  { ********************** TLMDExplorerBarItems ********************************* }
  TLMDExplorerBarItems=class(TOwnedCollection)
  private
    FSorting    : Boolean;
    function GetItems(Index: Integer): TLMDExplorerBarItem;
  protected
    procedure   Update(Item: TCollectionItem);override;
  public
    constructor Create(Owner : TLMDExplorerBarSection);
    function    Add:TLMDExplorerBarItem;
    procedure   InitiateActions;
    property    Items[Index:Integer]:TLMDExplorerBarItem read GetItems;default;

  end;

  TLMDExplorerBarBeforeSectionChange=procedure(Sender : TObject; var allowChange:Boolean) of object;

  { ********************** TLMDExplorerBarSection  ********************************* }
  TLMDExplorerBarSection=class(TCollectionItem)
  private
    FChangeLink:TChangeLink;
    FItems: TLMDExplorerBarItems;
    FVisible: Boolean;
    FExpanded: Boolean;
    FCaption: String;
    FStyle: TLMDExplorerBarStyle;
    FParentFont: Boolean;
    FVertScrollBar: Boolean;
    FSorted: Boolean;
    FHeight: Integer;
    FHint: String;
    FFont: TFont;
    FImageList: TImageList;
    FParentShowHint: Boolean;
    FShowHint: Boolean;
    FOnMeasureHeight: TLMDBarMeasureHeightEvent;
    FOnDrawInfo: TLMDBarDrawInfoEvent;
    FOnSort: TLMDBarSortEvent;
    FOnExpand: TNotifyEvent;
    FHeaderSize: Integer;
    FItemsVSpace,
    FItemsHSpace: Integer;
    FOnCollapse: TNotifyEvent;
    FPanel: TLMDExplorerBarPanel;
    FScrollBar: TScrollBar;
    FOnScrollChange: TNotifyEvent;
    FOnScroll: TScrollEvent;
    FLinkedControlAlign: TAlign;
    FLinkedControl: TControl;
    FLinkedControlLeft: Integer;
    FLinkedControlTop: Integer;
    FInformation: String;
    FName: String;
    // 1.02
    FMargin,
    FLineGap: Integer;
    // -----
    FHotItem     : TLMDExplorerBarItem;
    FCurrentItemFont : TFont;
    FOnBeforeCollapse: TLMDExplorerBarBeforeSectionChange;
    FOnBeforeExpand: TLMDExplorerBarBeforeSectionChange;

    procedure SetItems(const Value: TLMDExplorerBarItems);
    procedure SetCaption(const Value: String);
    procedure SetExpanded(const Value: Boolean);
    procedure SetStyle(const Value: TLMDExplorerBarStyle);
    procedure SetVisible(const Value: Boolean);
    procedure SetFont(const Value: TFont);
    procedure SetHeight(const Value: Integer);
    procedure SetImageList(const Value: TImageList);
    procedure SetParentFont(const Value: Boolean);
    procedure SetSorted(const Value: Boolean);
    procedure SetVertScrollBar(const Value: Boolean);
    procedure ChangeBitmap(Sender:TObject);
    procedure SetHeaderSize(const Value: Integer);
    procedure SetItemsHSpace(const Value: Integer);
    procedure SetItemsVSpace(const Value: Integer);
    procedure SetPanel(const Value: TLMDExplorerBarPanel);
    procedure SetScrollBar(const Value: TScrollBar);
    procedure SetLinkedControl(const Value: TControl);
    procedure SetLinkedControlAlign(const Value: TAlign);
    procedure SetLinkedControlLeft(const Value: Integer);
    procedure SetLinkedControlTop(const Value: Integer);
    function  CheckDesignTime:Boolean;
    procedure SetInformation(const Value: String);
    procedure SetName(const Value: String);
    function IsCustomFont:Boolean;
  protected
    iLeft,iTop,iWidth,iHeight : Integer;
    FUseScroll  : Boolean;
    FScrollPos  : Integer;
    FExplorerBar:TLMDExplorerBar;
    FHeaderState : TLMDBarHeaderState;
    FHeaderRect  : TRect;
    FPressedItem : TLMDExplorerBarItem;

    FAnimating   : Boolean;
    FAnimateStage: Integer;
    FAnimateStep : Integer;
    FAnimateMax  : Integer;
    FAnimateBmp  : TBitmap;
    FLMDTextLabel : TLMDExplorerBarLabel;

    procedure SetHotItem(Item:TLMDExplorerBarItem);
    procedure SetMargin(const value:integer);
    procedure SetInfoLineGap(const value:integer);

    procedure StartAnimate;virtual;
    procedure StopAnimate;virtual;

    function   GetSectionHeight(Canvas : TCanvas):Integer;
    function   GetItemHeight(Canvas:TCanvas): Integer;
    function   GetDefSectionItemsHeight(Canvas : TCanvas):Integer;
    function   GetHeaderHeight(Canvas : TCanvas):Integer;
    function   GetDisplayName: string; override;
    procedure  MouseMove(Shift: TShiftState; X, Y: Integer);dynamic;
    procedure  MouseEnter(AControl: TControl);dynamic;
    procedure  MouseLeave(AControl: TControl);dynamic;
    procedure  MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);dynamic;
    procedure  MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);dynamic;

    procedure   Activate(ExplorerBar:TLMDExplorerBar);virtual;
    procedure   Deactivate(ExplorerBar:TLMDExplorerBar);virtual;
    function    CheckPointInHeader(X,Y:Integer):Boolean;
    procedure   SetMainCursor(Cursor:TCursor);
    procedure   CaptureMouse;
    procedure   ReleaseMouse;
    procedure   SectionChanged(Sender:TObject=nil);virtual;
    function    GetControlOwner:TComponent;
    function    GetItemAt(Canvas:TCanvas;X,Y:Integer):TLMDExplorerBarItem;
    function    ItemsCompare(First,Second:TLMDExplorerBarItem):Integer;virtual;
    procedure   QuickSort(L, R: Integer);
    procedure   ReSort;virtual;

    procedure   FireClick;virtual;

    procedure   Paint(var PaintInfo : TLMDBarPaintInfo);virtual;
    procedure   PaintHeader(var PaintInfo : TLMDBarPaintInfo;State:TLMDBarHeaderState);virtual;
    procedure   PaintBackground(var PaintInfo : TLMDBarPaintInfo);virtual;
    procedure   PaintItems(var PaintInfo : TLMDBarPaintInfo;bPaintPanel:Boolean);virtual;
    procedure   PaintInside(var PaintInfo : TLMDBarPaintInfo);virtual;
    procedure   Repaint;

    procedure   ScrollChangeEvent(Sender:TObject);
    procedure   ScrollEvent(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);

    procedure   UpdateHint(szHint:String);
    procedure   CancelHint;
    procedure   UpdateScroll(Height:Integer=-1);
    procedure   Notification(AComponent: TComponent; Operation: TOperation);
    procedure   Loaded;
    procedure   UpdateLinkedControl;

    function    GetFont:TFont;
    function    GetShowHintState:Boolean;
  public
    constructor Create(Collection: TCollection);override;
    destructor  Destroy;override;
    procedure   Assign(Source: TPersistent); override;

    procedure   SetSize(Left,Top,Width,Height:Integer);

    property HotItem:TLMDExplorerBarItem read FHotItem;
    property Panel:TLMDExplorerBarPanel read FPanel write SetPanel;
    property ScrollBar:TScrollBar read FScrollBar write SetScrollBar;
  published
    property Name:String read FName write SetName;
    property Caption:String read FCaption write SetCaption;
    property Style:TLMDExplorerBarStyle read FStyle write SetStyle default ebsItemList;
    property Items:TLMDExplorerBarItems read FItems write SetItems;
    property Expanded:Boolean read FExpanded write SetExpanded default true;
    property Visible:Boolean read FVisible write SetVisible default true;
    property Height:Integer read FHeight write SetHeight default 0;
    property Sorted:Boolean read FSorted write SetSorted default False;
    property VertScrollBar:Boolean read FVertScrollBar write SetVertScrollBar default false;
    property Font:TFont read FFont write SetFont stored IsCustomFont;
    property ParentFont:Boolean read FParentFont write SetParentFont default true;
    property Hint:String read FHint write FHint;
    property ShowHint:Boolean read FShowHint write FShowHint default false;
    property ParentShowHint:Boolean read FParentShowHint write FParentShowHint default True;
    property ImageList:TImageList read FImageList write SetImageList;
    property HeaderSize:Integer read FHeaderSize write SetHeaderSize default 0;
    property ItemsHSpace:Integer read FItemsHSpace write SetItemsHSpace default LEB_VSECTIONS_SPACE;
    property ItemsVSpace:Integer read FItemsVSpace write SetItemsVSpace default LEB_VSECTIONS_SPACE;
    // 1.02
    property Margin: Integer read FMargin write SetMargin default 1;
    property InfoLineGap:Integer read FLineGap write SetInfoLineGap default 0;
    // ---
    property LinkedControl:TControl read FLinkedControl write SetLinkedControl;
    property LinkedControlAlign:TAlign read FLinkedControlAlign write SetLinkedControlAlign default alClient;
    property LinkedControlLeft:Integer read FLinkedControlLeft write SetLinkedControlLeft;
    property LinkedControlTop:Integer read FLinkedControlTop write SetLinkedControlTop;
    property Information:String read FInformation write SetInformation;

    // 1.00.60
    property OnBeforeCollapse: TLMDExplorerBarBeforeSectionChange read FOnBeforeCollapse write FOnBeforeCollapse;
    property OnBeforeExpand: TLMDExplorerBarBeforeSectionChange read FOnBeforeExpand write FOnBeforeExpand;
    // ------
    property OnMeasureHeight:TLMDBarMeasureHeightEvent read FOnMeasureHeight write FOnMeasureHeight;
    property OnExpand:TNotifyEvent read FOnExpand write FOnExpand;
    property OnCollapse:TNotifyEvent read FOnCollapse write FOnCollapse;
    property OnSort:TLMDBarSortEvent read FOnSort write FOnSort;
    property OnDrawInfo:TLMDBarDrawInfoEvent read FOnDrawInfo write FOnDrawInfo;
    property OnScrollChange:TNotifyEvent read FOnScrollChange write FOnScrollChange;
    property OnScroll:TScrollEvent read FOnScroll write FOnScroll;
  end;

  { ********************** TLMDExplorerBarSections ********************************* }
  TLMDExplorerBarSections=class(TOwnedCollection)
  private
    function GetItems(Index: Integer): TLMDExplorerBarSection;
    function GetItemByName(Value: String): TLMDExplorerBarSection;
  protected
    FExplorerBar:TLMDExplorerBar;
    procedure   Activate(ExplorerBar:TLMDExplorerBar);virtual;
    procedure   Deactivate(ExplorerBar:TLMDExplorerBar);virtual;
    function    ValidateName(NewName:String):String;
    function    GetSectionName:String;
  protected
    procedure   Update(Item: TCollectionItem);override;
  public
    constructor Create(Owner : TPersistent);
    function    Add:TLMDExplorerBarSection;
    property    Section[Index:Integer]:TLMDExplorerBarSection read GetItems;default;
    property    SectionByName[Value:String]:TLMDExplorerBarSection read GetItemByName;
  end;

  { ********************** TLMDExplorerBarStorage **************************** }
  TLMDExplorerBarStorage=class(TLMDBarController)
  private
    FSections: TLMDExplorerBarSections;
    procedure SetSections(const Value: TLMDExplorerBarSections);
  protected
    procedure   Notification(AComponent: TComponent; Operation: TOperation);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;override;
  published
    property  Sections:TLMDExplorerBarSections read FSections write SetSections;
  end;

  { ********************** TLMDExplorerBar *********************************** }
  TLMDExplorerBar=class(TLMDExplorerBarBasePanel)
  private
    FSections: TLMDExplorerBarSections;
    FSectionStorage: TLMDExplorerBarStorage;
    FColor: TColor;
    FCtlXP: Boolean;
    FSectionsSpace: Integer;
    FHSpace: Integer;
    FVSpace: Integer;
    FHeaderEndColor: TColor;
    FSectionBackColor: TColor;
    FHeaderStartColor: TColor;
    FCollapseGlyphUp: TBitmap;
    FCollapseGlyphDown: TBitmap;
    FHeaderFont: TFont;
    FHightlightColor: TColor;
    FCollapseGlyphHot: TBitmap;
    FExpandGlyphHot: TBitmap;
    FExpandGlyphDown: TBitmap;
    FExpandGlyphUp: TBitmap;
    FSmoothEffect: Boolean;
    FCollapseGlyph: TBitmap;
    FExpandGlyph: TBitmap;
    FHintPause: Word;
    FItemsColor: TColor;
    FItemsHightlightColor: TColor;
    FHeaderStyle: TLMDBarHeaderStyle;
    FItemsDisableColor: TColor;
    FThemeController: TLMDExplorerBarController;
    FOnChange:TNotifyEvent;
    FBorderStyle:TBorderStyle;
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetSections(const Value: TLMDExplorerBarSections);
    procedure SetSectionStorage(const Value: TLMDExplorerBarStorage);
    procedure SetColor(const Value: TColor);
    procedure SetCtlXP(const Value: Boolean);
    procedure SetHSpace(const Value: Integer);
    procedure SetSectionsSpace(const Value: Integer);
    procedure SetVSpace(const Value: Integer);
    procedure SetHeaderEndColor(const Value: TColor);
    procedure SetHeaderStartColor(const Value: TColor);
    procedure SetSectionBackColor(const Value: TColor);
    procedure SetCollapseGlyphDown(const Value: TBitmap);
    procedure SetCollapseGlyphUp(const Value: TBitmap);
    procedure SetHeaderFont(const Value: TFont);
    procedure SetHightlightColor(const Value: TColor);
    procedure SetCollapseGlyphHot(const Value: TBitmap);
    procedure SetExpandGlyphHot(const Value: TBitmap);
    procedure SetExpandGlyphDown(const Value: TBitmap);
    procedure SetExpandGlyphUp(const Value: TBitmap);
    procedure SetCollapseGlyph(const Value: TBitmap);
    procedure SetExpandGlyph(const Value: TBitmap);
    procedure SetItemsColor(const Value: TColor);
    procedure SetItemsHightlightColor(const Value: TColor);
    procedure SetHeaderStyle(const Value: TLMDBarHeaderStyle);
    procedure SetItemsDisableColor(const Value: TColor);
    procedure SetThemeController(const Value: TLMDExplorerBarController);
    function  GetActiveSections:TLMDExplorerBarSections;
    function  GetScrollBarVisible: Boolean;
    function  IsNoController:Boolean;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMUpdateLinkMessage(var Message:TMessage);message CM_UPDATELINKCONTROLMSG;
    procedure WMNCHitTest(var Message:TMessage); message WM_NCHITTEST;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    function IsCustomColor: Boolean;
    function IsCustomCtlXP: Boolean;
    function IsCustomHeaderEndColor: Boolean;
    function IsCustomHeaderStartColor: Boolean;
    function IsCustomHighlightColor: Boolean;
    function IsCustomHSpace: Boolean;
    function IsCustomItemsColor: Boolean;
    function IsCustomItemsDisableColor: Boolean;
    function IsCustomItemsHighlightColor: Boolean;
    function IsCustomSectionBackColor: Boolean;
    function IsCustomSectionSpace: Boolean;
    function IsCustomVSpace: Boolean;
    function IsCustomHeaderStyle: Boolean;
  protected
    FLastMouseMoveSection : TLMDExplorerBarSection;
    FCaptureSection : TLMDExplorerBarSection;
    FHintWnd        : THintWindow;
    FHintTimer      : TTimer;
    FScrollPosition : Integer;
    FScrollSize     : Integer;

    procedure   CreateParams(var Params: TCreateParams);override;
    procedure   OnHintTimer(Sender:TObject);
    procedure   GetChange(Sender:TObject);override;
    procedure   UpdateHint(szHint:String);
    procedure   CancelHint;
    procedure   StartHintTimer(Value: Integer);
    procedure   StopHintTimer;
    procedure   ChangeSections(OldS,NewS : TLMDExplorerBarSections);
    procedure   ClearLastMouseMoveSection;
    procedure   Loaded;override;
    procedure   DoMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);virtual;
    procedure   DoMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);virtual;
    procedure   MouseMove(Shift: TShiftState; X, Y: Integer);override;
    procedure   MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure   MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure   Notification(AComponent: TComponent; Operation: TOperation);override;
    procedure   Paint;override;
    procedure   PaintBackground(var PaintInfo : TLMDBarPaintInfo);virtual;
    procedure   PaintSections(var PaintInfo : TLMDBarPaintInfo);virtual;
    procedure   CreateSectionBitmap(Bmp:TBitmap;Section:TLMDExplorerBarSection);virtual;
    procedure   Resize;override;
    procedure   SetImageProperties(dstBmp,srcBmp:TBitmap;Index:Integer);virtual;
    procedure   GlyphsChanged;virtual;
    procedure   UpdateSectionStorage;
    procedure   UpdateTheme;

    property    CollapseGlyphUp:TBitmap read FCollapseGlyphUp write SetCollapseGlyphUp;
    property    CollapseGlyphHot:TBitmap read FCollapseGlyphHot write SetCollapseGlyphHot;
    property    CollapseGlyphDown:TBitmap read FCollapseGlyphDown write SetCollapseGlyphDown;
    property    ExpandGlyphUp:TBitmap read FExpandGlyphUp write SetExpandGlyphUp;
    property    ExpandGlyphHot:TBitmap read FExpandGlyphHot write SetExpandGlyphHot;
    property    ExpandGlyphDown:TBitmap read FExpandGlyphDown write SetExpandGlyphDown;

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;override;

    procedure   InvalidateEx;
    procedure   InvalidateSections;
    procedure   ArrangeSections(ShowBar:Boolean=true);virtual;
    function    GetSectionByPoint(X,Y:Integer):TLMDExplorerBarSection;

    procedure   CollapseSection(Section:TLMDExplorerBarSection);virtual;
    procedure   ExpandSection(Section:TLMDExplorerBarSection);virtual;
    procedure   ExpandAll;
    procedure   CollapseAll;

    function    getLMDPackage:TLMDPackageID;override;

    property    ActiveSections:TLMDExplorerBarSections read GetActiveSections;
    property    IsScrollBarVisible:Boolean read GetScrollBarVisible;
    property    DockManager;

    published
    property    About;
    property    Align;
    property    PopupMenu;
    property    ShowHint;
    property    ParentShowHint;

    property    BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsNone;
    property    Cursor;
    property    DragMode;
    property    DragCursor;
    property    Visible;

    property    HeaderStyle:TLMDBarHeaderStyle read FHeaderStyle write SetHeaderStyle stored IsCustomHeaderStyle;
    property    SmoothEffect:Boolean read FSmoothEffect write FSmoothEffect default True;

    property    Color:TColor read FColor write SetColor stored IsCustomColor;
    property    HeaderStartColor:TColor read FHeaderStartColor write SetHeaderStartColor stored IsCustomHeaderStartColor;
    property    HeaderEndColor:TColor read FHeaderEndColor write SetHeaderEndColor stored IsCustomHeaderEndColor;
    property    ItemsColor:TColor read FItemsColor write SetItemsColor stored IsCustomItemsColor;
    property    ItemsHightlightColor:TColor read FItemsHightlightColor write SetItemsHightlightColor stored IsCustomItemsHighlightColor;
    property    ItemsDisableColor:TColor read FItemsDisableColor write SetItemsDisableColor stored IsCustomItemsDisableColor;
    property    SectionBackColor:TColor read FSectionBackColor write SetSectionBackColor stored IsCustomSectionBackColor;
    property    HightlightColor:TColor read FHightlightColor write SetHightlightColor stored IsCustomHighlightColor;
    property    HeaderFont:TFont read FHeaderFont write SetHeaderFont stored IsNoController;
    property    HintPause:Word read FHintPause write FHintPause default LEB_HINTPAUSE;
    property    Font;
    property    CollapseGlyph:TBitmap read FCollapseGlyph write SetCollapseGlyph stored IsNoController;
    property    ExpandGlyph:TBitmap read FExpandGlyph write SetExpandGlyph stored IsNoController;

    property    Sections:TLMDExplorerBarSections read FSections write SetSections;
    property    SectionStorage:TLMDExplorerBarStorage read FSectionStorage write SetSectionStorage;
    property    ThemeController:TLMDExplorerBarController read FThemeController write SetThemeController;
    property    CtlXP:Boolean read FCtlXP write SetCtlXP stored IsCustomCtlXP;

    property    VSpace:Integer read FVSpace write SetVSpace stored IsCustomVSpace;
    property    HSpace:Integer read FHSpace write SetHSpace stored IsCustomHSpace;
    property    SectionsSpace:Integer read FSectionsSpace write SetSectionsSpace stored IsCustomSectionSpace;

    property    OnSectionsChange:TNotifyEvent read FOnChange write FOnChange;

    // V4 enhancements
    property Anchors;
    //property AutoSize;
    property Constraints;
    property UseDockManager default True;
    property DockSite;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;

    // events
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

    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;

  end;

implementation
uses
  Menus,
  UxTheme, Themes, LMDProcs,
  LMDHTMLUnit,  LMDThemes,LMDGraph, LMDGraphUtils
  {$IFDEF LMD_DEBUGTRACE}, dialogs;{$I C2.INC}{$ELSE};{$ENDIF}

//const
//  LMDBASE_PART=1;

type
  TPersistentCracker = class(TPersistent);

function  LMDMakeHC(Color:TColor;Value:Byte=$20):TColor;
  function HC(B:Byte):Byte;
  var
    W : WORD;
  begin
    W := B+Value;
    if W>255 then
      Result := 255
    else
      Result := W;
  end;
begin
  Result := (HC((Color shr 16) and $FF) shl 16)+(HC((Color shr 8) and $FF) shl 8)+HC(Color and $FF);
end;

function ShiftStateToKeys(SS:TShiftState): Word;
begin
  Result := 0;
  if ssShift in SS then Result := Result or MK_SHIFT;
  if ssCtrl in SS then Result := Result or MK_CONTROL;
  if ssLeft in SS then Result := Result or MK_LBUTTON;
  if ssRight in SS then Result := Result or MK_RBUTTON;
end;

{ ************************ TLMDExplorerBarItem ******************************* }
{ ----------------------------- private -------------------------------------- }
procedure TLMDExplorerBarItem.SetAction(const Value: TBasicAction);
begin
  if Value = nil then
    begin
      FActionLink.Free;
      FActionLink := nil;
    end
  else
    begin
      if FActionLink = nil then
        FActionLink := GetActionLinkClass.Create(Self);
      FActionLink.Action := Value;
      FActionLink.OnChange := DoActionChange;
      ActionChange(Value, csLoading in Value.ComponentState);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarItem.SetCaption(const Value: String);
begin
  if FCaption<>Value then
    begin
      FCaption := Value;
      Changed;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarItem.SetEnabled(const Value: Boolean);
begin
  if FEnabled<>Value then
    begin
      FEnabled := Value;
      Changed;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarItem.SetImageIndex(const Value: Integer);
begin
  if FImageIndex<>Value then
    begin
      FImageIndex := Value;
      Changed;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarItem.SetVisible(const Value: Boolean);
begin
  if FVisible<>Value then
    begin
      FVisible := Value;
      Changed;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarItem.GetAction: TBasicAction;
begin
  if FActionLink <> nil then
    Result := FActionLink.Action
  else
    Result := nil;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarItem.GetActionLinkClass: TLMDExplorerBarActionLinkClass;
begin
  Result:=TLMDExplorerBarActionLink;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarItem.GetDisplayName: string;
begin
  if FCaption='' then
    result:=IDS_BARNOCAPTION+inttostr(Index)
  else
    result:=FCaption;
  result:=result+' ('+self.ClassName+')';
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarItem.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation=opRemove) and (AComponent=Action) then
    Action:=nil;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarItem.IsCaptionStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsCaptionLinked;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarItem.IsEnabledStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsEnabledLinked;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarItem.IsHintStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsHintLinked;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarItem.IsImageIndexStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsImageIndexLinked;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarItem.IsOnClickStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsOnExecuteLinked;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarItem.IsVisibleStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsVisibleLinked;
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDExplorerBarItem.ActionChange(Sender: TObject;CheckDefaults: Boolean);
begin
  if Action is TCustomAction then
    with TCustomAction(Sender) do
      begin
        if not CheckDefaults or (Self.Caption = '') then
          Self.Caption := Caption;
        if not CheckDefaults or (Self.Enabled = True) then
          Self.Enabled := Enabled;
        if not CheckDefaults or (Self.Hint = '') then
          Self.Hint := Hint;
        if not CheckDefaults or (Self.ImageIndex = -1) then
          Self.ImageIndex := ImageIndex;
        if not CheckDefaults or (Self.Visible = True) then
          Self.Visible := Visible;
        if not CheckDefaults or not Assigned(Self.OnClick) then
          Self.OnClick := OnExecute;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarItem.Assign(Source: TPersistent);
begin
  if Source is TLMDExplorerBarItem then
    with TLMDExplorerBarItem(Source) do
      begin
        Self.Action := Action;

        Self.Caption := Caption;
        Self.Enabled := Enabled;
        Self.Visible := Visible;
        Self.Hint := Hint;
        Self.ImageIndex := ImageIndex;
        Self.Tag := Tag;

        Self.OnClick := OnClick;
        Self.OnGetItemSettings := OnGetItemSettings;
        Self.OnMouseEnter := OnMouseEnter;
        Self.OnMouseExit := OnMouseExit;
        exit;
      end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarItem.DoActionChange(Sender: TObject);
begin
  if Sender = Action then ActionChange(Sender, False);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarItem.Changed;
begin
  inherited Changed(True);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarItem.DoMouseEnter;
begin
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarItem.DoMouseExit;
begin
  if Assigned(FOnMouseExit) then
    FOnMouseExit(self);
end;

{------------------------------------------------------------------------------}
{function TLMDExplorerBarItem.GetHeight(Canvas: TCanvas): Integer;
begin
  Result := Trunc(Canvas.TextHeight('Wq')*1.2);
end;

{----------------------------- public -----------------------------------------}
constructor TLMDExplorerBarItem.Create(Collection: TCollection);
begin
  FEnabled := True;
  FVisible := True;
  FTag := 0;
  FImageIndex := -1;
  inherited;
end;

{------------------------------------------------------------------------------}
destructor TLMDExplorerBarItem.Destroy;
begin
  Action := nil;
  FreeAndNil(FActionLink);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarItem.Click;
begin
  if Enabled then
    begin
      if Assigned(FOnClick) and (Action<>nil) and (@FOnClick<>@Action.OnExecute) then
        FOnClick(Self)
      else
        if (ActionLink<>nil) then
          FActionLink.Execute
        else
          if Assigned(FOnClick) then FOnClick(Self);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarItem.InitiateAction;
begin
  if FActionLink <> nil then FActionLink.Update;
end;

{***************************** TLMDExplorerBarItems ***************************}
{------------------------------------------------------------------------------}
function TLMDExplorerBarItems.Add: TLMDExplorerBarItem;
begin
  Result := TLMDExplorerBarItem(inherited Add);
end;

{------------------------------------------------------------------------------}
constructor TLMDExplorerBarItems.Create(Owner: TLMDExplorerBarSection);
begin
  FSorting := false;
  inherited Create(Owner,TLMDExplorerBarItem);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarItems.GetItems(Index: Integer): TLMDExplorerBarItem;
begin
  Result := TLMDExplorerBarItem(inherited Items[Index]);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarItems.InitiateActions;
var
  i:Integer;
begin
  for i:=0 to Count-1 do
    Items[i].InitiateAction;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarItems.Update(Item: TCollectionItem);
begin
  inherited;
  if not FSorting then
    if (GetOwner<>nil) and (GetOwner is TLMDExplorerBarSection) then
      TLMDExplorerBarSection(GetOwner).SectionChanged;
end;

{ *********************** TLMDExplorerBarStorage ******************************}
{ ----------------------------- private -------------------------------------- }
{--------------------------- private ------------------------------------------}
procedure TLMDExplorerBarStorage.SetSections(const Value: TLMDExplorerBarSections);
begin
  FSections.Assign(Value);
end;

{-------------------------- protected -----------------------------------------}
procedure TLMDExplorerBarStorage.Notification(AComponent: TComponent; Operation: TOperation);
var
  i:Integer;
begin
  if (Operation = opRemove) and (AComponent <> nil) then
    begin
      if (AComponent is TImageList) or (AComponent is TBasicAction) then
        for i:=0 to FSections.Count-1 do
          FSections[i].Notification(AComponent,Operation);
    end;
  inherited;
end;

{--------------------------- public -------------------------------------------}
constructor TLMDExplorerBarStorage.Create(AOwner: TComponent);
begin
  inherited;
  FSections := TLMDExplorerBarSections.Create(Self);
end;

{------------------------------------------------------------------------------}
destructor TLMDExplorerBarStorage.Destroy;
begin
  FreeAndNil(FSections);
  inherited;
end;

{ ************************* TLMDExplorerBarBasePanel **************************}
{------------------------------------------------------------------------------}
procedure TLMDExplorerBarBasePanel.WMPaint(var Message: TWMPaint);
var
  DC, MemDC, DoubleDC: HDC;
  MemBitmap, OldBitmap, DoubleBitmap: HBITMAP;
  PS: TPaintStruct;
begin
  if not FDoubleBuffered or (Message. DC <> 0) then
    begin
      if not (csCustomPaint in ControlState) and (ControlCount = 0) then
        inherited
      else
        PaintHandler(Message);
    end
  else
    begin
      DC := GetDC(0);
      DoubleDC := 0;
      DoubleBitmap := 0;
      MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
      ReleaseDC(0, DC);
      MemDC := CreateCompatibleDC(0);
      OldBitmap := SelectObject(MemDC, MemBitmap);
      try
        DC := BeginPaint(Handle, PS);
        Message.DC := MemDC;
        WMPaint(Message);
        Message.DC := 0;

        DoubleDC := CreateCompatibleDC(DC);
        DoubleBitmap := CreateCompatibleBitmap(DC, PS.rcPaint.Right - PS.rcPaint.Left, PS.rcPaint.Bottom - PS.rcPaint.Top);
        SelectObject(DoubleDC, DoubleBitmap);
        LMDTransparentBlt(DoubleDC, 0, 0, PS.rcPaint.Right - PS.rcPaint.Left, PS.rcPaint.Bottom - PS.rcPaint.Top, MemDC, PS.rcPaint.Left, PS.rcPaint.Top, PS.rcPaint.Right - PS.rcPaint.Left, PS.rcPaint.Bottom - PS.rcPaint.Top, LEB_TRANS_COLOR);
        // NEW version with double buffering and only needed rect will be repaint.
        BitBlt(DC, PS.rcPaint.Left, PS.rcPaint.Top, PS.rcPaint.Right, PS.rcPaint.Bottom, DoubleDC, 0, 0, SRCCOPY);
        EndPaint(Handle, PS);
      finally
        SelectObject(MemDC, OldBitmap);
        DeleteDC(MemDC);
        SelectObject(DoubleDC, 0);
        DeleteDC(DoubleDC);
        DeleteObject(DoubleBitmap);
        DeleteObject(MemBitmap);
        DeleteObject(OldBitmap);
      end;
    end;
end;

{ ************************* TLMDExplorerBarPanel ******************************}
{ --------------------------- protected -------------------------------------- }
procedure TLMDExplorerBarPanel.CreateParams(var Params: TCreateParams);
begin
  inherited;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDExplorerBarPanel.Create(AOwner: TComponent);
begin
  inherited;
  DoubleBuffered := True;
  ControlStyle := ControlStyle-[csCaptureMouse,csOpaque{$IFDEF LMDCOMP7},csParentBackground{$ENDIF}];
end;

{------------------------------------------------------------------------------}
destructor TLMDExplorerBarPanel.Destroy;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarPanel.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  Section.MouseLeave(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarPanel.Loaded;
begin
  inherited;
  Section.Loaded;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarPanel.MouseDown(Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  Section.MouseDown(Button,Shift,Left+X,Top+Y);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarPanel.MouseMove(Shift: TShiftState; X,Y: Integer);
begin
  inherited;
  Section.MouseMove(Shift,Left+X,Top+Y);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarPanel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  Section.MouseUp(Button,Shift,Left+X,Top+Y);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarPanel.Notification(AComponent: TComponent;Operation: TOperation);
begin
  inherited;
  Section.Notification(AComponent,Operation);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarPanel.Paint;
var
  PaintInfo : TLMDBarPaintInfo;
begin
  Canvas.Brush.Color := LEB_TRANS_COLOR;
  Canvas.FillRect(Canvas.ClipRect);

  with PaintInfo do
    begin
      ExplorerBar := Section.FExplorerBar;
      Canvas := Self.Canvas;
      Rect := GetClientRect;
      UseXP := LMDApplication.XPThemesSupported and Section.FExplorerBar.CtlXP;
      Handle := Section.FExplorerBar.Handle;
    end;
  Section.PaintInside(PaintInfo);
end;

{ ************************** TLMDHTMLLabel ************************************}
{ --------------------------- protected -------------------------------------- }
procedure TLMDExplorerBarLabel.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  FSection.MouseDown(Button,Shift,Parent.Left+Left+X,Parent.Top+Top+Y);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarLabel.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  FSection.MouseUp(Button,Shift,Parent.Left+Left+X,Parent.Top+Top+Y);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarLabel.Paint;
begin
  with Canvas do
    begin
      Brush.Style := bsClear;
      Font := FSection.GetFont;
      //LMDHTMLDrawText(Canvas,Caption,ClientRect,[], LineGap); //VB March 2008
    end;
  inherited;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDExplorerBarLabel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csReplicatable]- [csOpaque];
end;

{ ******************* TLMDExplorerBarController *******************************}
{ ----------------------------- private -------------------------------------- }
procedure TLMDExplorerBarController.SetCollapseGlyph(const Value: TBitmap);
begin
  FCollapseGlyph.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarController.SetColor(const Value: TColor);
begin
  if Value<>FColor then
    begin
      FColor := Value;
      UpdateParent;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarController.SetCtlXP(const Value: Boolean);
begin
  if Value<>FCtlXP then
    begin
      FCtlXP := Value;
      if LMDApplication.XPThemesSupported then
        UpdateParent;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarController.SetExpandGlyph(const Value: TBitmap);
begin
  FExpandGlyph.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarController.SetHeaderEndColor(const Value: TColor);
begin
  if Value<>FHeaderEndColor then
    begin
      FHeaderEndColor := Value;
      UpdateParent;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarController.SetHeaderFont(const Value: TFont);
begin
  FHeaderFont.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarController.SetHeaderStartColor(const Value: TColor);
begin
  if FHeaderStartColor<>Value then
    begin
      FHeaderStartColor := Value;
      UpdateParent;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarController.SetHeaderStyle(const Value: TLMDBarHeaderStyle);
begin
  if FHeaderStyle<>Value then
    begin
      FHeaderStyle := Value;
      UpdateParent;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarController.SetHightlightColor(const Value: TColor);
begin
  if FHightlightColor<>Value then
    begin
      FHightlightColor := Value;
      UpdateParent;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarController.SetHSpace(const Value: Integer);
begin
  if FHSpace<>Value then
    begin
      FHSpace := Value;
      UpdateParent;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarController.SetItemsColor(const Value: TColor);
begin
  if FItemsColor<>Value then
    begin
      FItemsColor := Value;
      UpdateParent;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarController.SetItemsDisableColor(
  const Value: TColor);
begin
  if FItemsDisableColor<>Value then
    begin
      FItemsDisableColor := Value;
      UpdateParent;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarController.SetItemsHightlightColor(
  const Value: TColor);
begin
   if FItemsHightlightColor<>Value then
    begin
      FItemsHightlightColor := Value;
      UpdateParent;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarController.SetSectionBackColor(const Value: TColor);
begin
   if FSectionBackColor<>Value then
     begin
       FSectionBackColor := Value;
       UpdateParent;
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarController.SetSectionsSpace(const Value: Integer);
begin
  if FSectionsSpace<>Value then
    begin
      FSectionsSpace := Value;
      UpdateParent;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarController.SetVSpace(const Value: Integer);
begin
  if FVSpace<>Value then
    begin
      FVSpace := Value;
      UpdateParent;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarController.GetChange(Sender:TObject);
begin
  UpdateParent;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarController.UpdateParent;
begin
  if not (csLoading in ComponentState) then
    UpdateParentControls;
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDExplorerBarController.AssignTo(Dest: TPersistent);
begin
  if Dest is TLMDExplorerBar then
    with TLMDExplorerBar(Dest) do
      begin
        FHeaderStyle := Self.FHeaderStyle;
        FColor := Self.FColor;
        FCtlXP := Self.FCtlXP;
        FVSpace := Self.FVSpace;
        FHSpace := Self.FHSpace;
        FSectionsSpace := Self.FSectionsSpace;
        FHeaderStartColor := Self.FHeaderStartColor;
        FHeaderEndColor := Self.FHeaderEndColor;
        FSectionBackColor := Self.FSectionBackColor;
        FHeaderFont.Assign(Self.FHeaderFont);
        FItemsColor :=  Self.FItemsColor;
        FItemsDisableColor := Self.FItemsDisableColor;
        FCollapseGlyph.Assign(Self.FCollapseGlyph);
        FExpandGlyph.Assign(Self.FExpandGlyph);
        FHightlightColor := Self.FHightlightColor;
        FItemsHightlightColor := Self.FItemsHightlightColor;
        exit;
      end;
  inherited;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDExplorerBarController.Create(AOwner: TComponent);
begin
  FHeaderStyle := bhsRounded;
  FColor := LEB_BACK_COLOR;
  FCtlXP := True;
  FVSpace := LEB_VSPACE;
  FHSpace := LEB_HSPACE;
  FSectionsSpace := LEB_VSECTIONS_SPACE;
  FHeaderStartColor := LEB_HEADER_START;
  FHeaderEndColor := LEB_HEADER_END;
  FSectionBackColor := LEB_SECTION_BACK;
  FHeaderFont := TFont.Create;
  FHeaderFont.Color := LEB_HEADER_COLOR;
  FHeaderFont.Style := FHeaderFont.Style + [fsBold];
  FHeaderFont.Name  := LEB_HEADER_FONT_NAME;
  FHeaderFont.OnChange:=GetChange;
  FItemsColor :=  LEB_HEADER_COLOR;
  FItemsDisableColor := LEB_ITEM_DISABLE;
  FCollapseGlyph := TBitmap.Create;
  FCollapseGlyph.OnChange:=GetChange;
  FExpandGlyph := TBitmap.Create;
  FExpandGlyph.OnChange:=GetChange;
  FHightlightColor := LEB_HEADER_HIGHLIGHT;
  FItemsHightlightColor := LEB_HEADER_HIGHLIGHT;
  inherited;
  end;

{------------------------------------------------------------------------------}
destructor TLMDExplorerBarController.Destroy;
begin
  FHeaderFont.OnChange:=nil;
  FCollapseGlyph.OnChange:=nil;
  FExpandGlyph.OnChange:=nil;
  FHeaderFont.Free;
  FCollapseGlyph.Free;
  FExpandGlyph.Free;
  inherited;
end;

{ ********************* TLMDExplorerBarActionLink **************************** }
{ --------------------------- protected -------------------------------------- }
procedure TLMDExplorerBarActionLink.AssignClient(AClient: TObject);
begin
  FClient := AClient as TLMDExplorerBarItem;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarActionLink.IsCaptionLinked: Boolean;
begin
 Result:= inherited IsCaptionLinked and
          AnsiSameCaption(FClient.Caption, (Action as TCustomAction).Caption);
          end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarActionLink.IsEnabledLinked: Boolean;
begin
  Result := inherited IsEnabledLinked and
           (FClient.Enabled = (Action as TCustomAction).Enabled);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarActionLink.IsHintLinked: Boolean;
begin
  Result := inherited IsHintLinked and
            (FClient.Hint = (Action as TCustomAction).Hint);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
      (FClient.ImageIndex = (Action as TCustomAction).ImageIndex);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarActionLink.IsOnExecuteLinked: Boolean;
begin
    Result := inherited IsOnExecuteLinked and
    (@FClient.OnClick = @Action.OnExecute);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarActionLink.IsVisibleLinked: Boolean;
begin
  Result := inherited IsVisibleLinked and
    (FClient.Visible = (Action as TCustomAction).Visible);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then FClient.Caption := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarActionLink.SetEnabled(Value: Boolean);
begin
  if IsEnabledLinked then FClient.Enabled := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarActionLink.SetHint(const Value: string);
begin
  if IsHintLinked then FClient.Hint := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarActionLink.SetImageIndex(Value: Integer);
begin
   if IsImageIndexLinked then FClient.ImageIndex := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarActionLink.SetOnExecute(Value: TNotifyEvent);
begin
  if IsOnExecuteLinked then FClient.OnClick := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarActionLink.SetVisible(Value: Boolean);
begin
  if IsVisibleLinked then FClient.Visible := Value;
end;

{ *********************** TLMDExplorerBarSection ******************************}
{----------------------------- private ----------------------------------------}
procedure TLMDExplorerBarSection.ChangeBitmap(Sender: TObject);
begin
  Repaint;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarSection.CheckDesignTime: Boolean;

  function IsOwnerDesigned(Owner: TPersistent): Boolean;
  begin
    Result := False;
    if Owner = nil then Exit;
    while (Owner <> nil) and not (Owner is TComponent) do
      Owner := TPersistentCracker(Owner).GetOwner;
    Result := csDesigning in TComponent(Owner).ComponentState;
  end;

begin
  if FPanel.Parent<>nil then
    Result := csDesigning in FPanel.Parent.ComponentState
  else
    Result := IsOwnerDesigned(TLMDExplorerBarSections(Collection).GetOwner)
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarSection.IsCustomFont: Boolean;
begin
  result:=(FParentFont=false);
end;

{------------------------------------------------------------------------------}
{function TLMDExplorerBarSection.GetInfoMargin: integer;
begin
  result := FPanel.BorderWidth;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetCaption(const Value: String);
begin
  if FCaption<>Value then
    begin
      FCaption := Value;
      SectionChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetMargin(const Value: integer);
begin
  if FMargin<>Value then
    begin
      FMargin := Value;
      SectionChanged;
    end;
end;
{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetInfoLineGap(const Value: integer);
begin
  if FLineGap<>Value then
    begin
      FLineGap := Value;
      if FStyle=ebsInformation then
        begin
          if Assigned(FLMDTextLabel) then
            FLMDTextLabel.LineGap:=FLineGap;
          SectionChanged;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetExpanded(const Value: Boolean);
begin
  if FExpanded<>Value then
    begin
      FExpanded := Value;
      SectionChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetHeaderSize(const Value: Integer);
begin
  if FHeaderSize<>Value then
    begin
      FHeaderSize := Value;
      SectionChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetHeight(const Value: Integer);
begin
  if FHeight<>Value then
    begin
      FHeight := Value;
      SectionChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetImageList(const Value: TImageList);
begin
  if FImageList=Value then
    exit;
  if FImageList<>nil then
    begin
      FImageList.UnRegisterChanges(FChangeLink);
      FImageList.RemoveFreeNotification(FPanel);
      FChangeLink.Free;
      FChangeLink:=nil;
    end;
  FImageList:=Value;
  if FImageList<>nil then
    begin
      FChangeLink:=TChangeLink.Create;
      FChangeLink.OnChange:=ChangeBitmap;
      FImageList.RegisterChanges(FChangeLink);
      FImageList.FreeNotification(FPanel);
    end;
  SectionChanged;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetInformation(const Value: String);
begin
  if FInformation<>Value then
    begin
      FInformation := Value;
      if FLMDTextLabel<>nil then
        begin
          FLMDTextLabel.Caption := Value;
          SectionChanged;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetItems(const Value: TLMDExplorerBarItems);
begin
  FItems.Assign(Value);
  SectionChanged;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetItemsHSpace(const Value: Integer);
begin
  if FItemsHSpace<>Value then
    begin
      FItemsHSpace := Value;
      SectionChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetItemsVSpace(const Value: Integer);
begin
  if FItemsVSpace<>Value then
    begin
      FItemsVSpace := Value;
      SectionChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetMainCursor(Cursor: TCursor);
begin
  if FExplorerBar<>nil then
    FExplorerBar.Cursor := Cursor;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetName(const Value: String);
begin
  if (FName<>Value) then
    FName := TLMDExplorerBarSections(GetOwner).ValidateName(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetPanel(const Value: TLMDExplorerBarPanel);
begin
  FPanel.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetParentFont(const Value: Boolean);
begin
  if FParentFont<>Value then
    begin
      FParentFont := Value;
      SectionChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetScrollBar(const Value: TScrollBar);
begin
  FScrollBar.Assign(Value);
  SectionChanged;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetSorted(const Value: Boolean);
begin
  if FSorted<>Value then
    begin
      FSorted := Value;
      SectionChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetStyle(const Value: TLMDExplorerBarStyle);
begin
  FStyle := Value;
  if FStyle<>ebsContainer then
    SetLinkedControl(nil);
  if FStyle=ebsInformation then
    begin
      if FLMDTextLabel=nil then
        begin
          FLMDTextLabel := TLMDExplorerBarLabel.Create(FPanel);
          FLMDTextLabel.FSection := Self;
          FLMDTextLabel.Parent := FPanel;
          FLMDTextLabel.Align := alClient;
          FLMDTextLabel.Caption := FInformation;
          FLMDTextLabel.LineGap:=FLineGap;
        end
    end
  else
    if FLMDTextLabel<>nil then
      begin
        FLMDTextLabel.Free;
        FLMDTextLabel := nil;
      end;

  SectionChanged;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetVertScrollBar(const Value: Boolean);
begin
  FVertScrollBar := Value;
  FScrollBar.Visible := Value;
  SectionChanged;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetVisible(const Value: Boolean);
begin
  if FVisible<>Value then
    begin
      FVisible := Value;
      SectionChanged;
    end;
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDExplorerBarSection.Activate(ExplorerBar: TLMDExplorerBar);
begin
  FExplorerBar := ExplorerBar;
  ReSort;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.CancelHint;
begin
  if FExplorerBar<>nil then
    FExplorerBar.CancelHint;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.CaptureMouse;
begin
  if FExplorerBar<>nil then
    begin
      FExplorerBar.FCaptureSection := Self;
      FExplorerBar.MouseCapture := True;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarSection.CheckPointInHeader(X, Y: Integer): Boolean;
begin
  Result := PtInRect(FHeaderRect,Point(X,Y));
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.Deactivate(ExplorerBar: TLMDExplorerBar);
begin
  FExplorerBar := nil;
  if Assigned(FPanel) then
    begin
      FPanel.Visible := False;
      FPanel.Parent := nil;
    end;
  SetHotItem(nil);
  FUseScroll := False;
  FScrollPos := 0;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.FireClick;
var
  tmp:Boolean;
begin
  FExpanded := not FExpanded;
  tmp:=True;
  if FExpanded then
    begin
      if Assigned(FOnBeforeExpand) then FOnBeforeExpand(Self, tmp);
      if not tmp then exit;
      if FExplorerBar<>nil then
        FExplorerBar.ExpandSection(Self);
      if Assigned(FOnExpand) then FOnExpand(Self);
    end
  else
    begin
      if Assigned(FOnBeforeCollapse) then FOnBeforeCollapse(Self, tmp);
      if not tmp then exit;
      if FExplorerBar<>nil then
        FExplorerBar.CollapseSection(Self);
      if Assigned(FOnCollapse) then FOnCollapse(Self);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarSection.GetControlOwner: TComponent;
begin
  result:=nil;
  if Collection=nil then exit;
  result:=TComponent(TOwnedCollection(Collection).Owner);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarSection.GetDisplayName: string;
begin
  result:=FName +' ('+self.ClassName+')';
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarSection.GetDefSectionItemsHeight(Canvas: TCanvas): Integer;
var
  i, th : Integer;
begin
  Result := (FItemsVSpace div 2);
  if FExpanded then
    begin
      th:=GetItemHeight(Canvas);
      for i:=0 to FItems.Count-1 do
        if FItems[i].Visible then
          Result := Result+th+(FItemsVSpace div 2);
      result:=result+(FItemsVSpace div 2);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarSection.GetHeaderHeight(Canvas: TCanvas): Integer;
var
  TF: LogFontW;
begin
  Result := FHeaderSize;
  if(Result<=0) then
    begin
      if FExplorerBar<>nil then
        Canvas.Font:=FExplorerBar.HeaderFont;
      Result := Trunc(Canvas.TextHeight('Wq')*2);
    end;
  // calculate also FCurrentItemFont;
  if FExplorerBar<>nil then
     if FExplorerBar.CtlXP and LMDApplication.XPThemesSupported then
       begin
         LMDThemeServices.GetThemeFont(ttmPlatform, Canvas.Handle, teExplorerBar, EBP_NORMALGROUPBACKGROUND,0, TMT_FONT, TF);
         FCurrentItemFont.Handle := CreateFontIndirectW(TF);
       end
     else
      FCurrentItemFont.Assign(GetFont)
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarSection.GetFont: TFont;
begin
  result:=FFont;
  if FParentFont then
    if TLMDExplorerBarSections(Collection).FExplorerBar<>nil then
      result:=TLMDExplorerBarSections(Collection).FExplorerBar.Font;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarSection.GetItemHeight(Canvas:TCanvas): Integer;
var
  Extent:TSize;
begin
  result:=10;
  Canvas.Font:=FCurrentItemFont;
  if GetTextExtentPoint(Canvas.Handle, 'Wq', 2, Extent) then result:=Extent.cY;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarSection.GetItemAt(Canvas:TCanvas;X, Y: Integer): TLMDExplorerBarItem;
var
  i, th : Integer;
  YY,OldYY : Integer;
begin
  if FPressedItem<>nil then
    begin
      Result := FPressedItem;
      exit;
    end;
  Result := nil;
  if FExpanded then
    begin
      with FPanel do
        begin
          if not((X>=Left) and (X<=(Left+Width)) and
             (Y>=Top) and (Y<=(Top+Height))) then
            exit;
        end;

      YY := iTop+GetHeaderHeight(Canvas)+(FItemsVSpace div 2);
      if FUseScroll then
         YY:=YY-FScrollPos;

      Canvas.Font:=FCurrentItemFont;
      th:=GetItemHeight(Canvas);
      for i:=0 to FItems.Count-1 do
        begin
          OldYY := YY;
          if FItems[i].Visible then
            YY := YY+th
          else
            continue;
          if (OldYY<=Y) and (YY>Y) then
            begin
              Result := FItems[i];
              break;
            end;
          YY := YY+(FItemsVSpace div 2);

          if YY>=(iTop+iHeight) then
            break;
        end;
      if Result<>nil then
        if not Result.Enabled then
          Result := nil;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarSection.GetSectionHeight(Canvas : TCanvas): Integer;
var
  iH, itmp : Integer;

begin
  Result := GetHeaderHeight(Canvas);
  iH := Result;
  if not Expanded then exit;

  if (Style=ebsItemList) and (FHeight<=0) then
    begin
      Result := Result+GetDefSectionItemsHeight(Canvas)
    end
  else
    if FExpanded then
      Result := Result+FHeight;

  if FExpanded then
    if Assigned(FOnMeasureHeight) then
      FOnMeasureHeight(Self,Result);

  if Canvas=nil then exit;

  if FAnimating then
    begin
      iTmp := Result-iH;
      if iTmp>0 then
        begin
          iTmp := iTmp-FAnimateStage*FAnimateStep;
          if iTmp<0 then
            iTmp := 0;
          Result := iH+iTmp;
        end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarSection.GetShowHintState: Boolean;
begin
  result:=FShowHint;
  if FParentShowHint then
     if TLMDExplorerBarSections(Collection).FExplorerBar<>nil then
      result:=TLMDExplorerBarSections(Collection).FExplorerBar.ShowHint;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarSection.ItemsCompare(First, Second: TLMDExplorerBarItem): Integer;
begin
  if Assigned(FOnSort) then
    Result := FOnSort(Self,First,Second)
  else
    if First.Caption>Second.Caption then
      Result := 1
    else
    if First.Caption<Second.Caption then
      Result := -1
    else
      Result := 0;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if CheckDesignTime then
    begin
      if FExplorerBar<>nil then
        case Button of
          mbLeft: FExplorerBar.Perform(WM_LBUTTONDOWN,ShiftStateToKeys(Shift),X or (Y shl 16));
          mbRight: FExplorerBar.Perform(WM_RBUTTONDOWN,ShiftStateToKeys(Shift),X or (Y shl 16));
        end;
      exit;
    end;
  if (Shift=[ssLeft]) then
    if CheckPointInHeader(X,Y) then
      begin
        FHeaderState := bhsPressed;
        Repaint;
        CaptureMouse;
      end
    else
     if GetItemAt(FExplorerBar.Canvas,X,Y)<>nil then
       begin
         FPressedItem := GetItemAt(FExplorerBar.Canvas,X,Y);
         FPanel.MouseCapture := True;
         Repaint;
       end
     else
       if FExplorerBar <> nil then
         FExplorerBar.DoMouseDown(Button, Shift, X, Y);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.MouseEnter(AControl: TControl);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.MouseLeave(AControl: TControl);
begin
  CancelHint;
  if (FHeaderState<>bhsPressed) and (AControl=FExplorerBar) then
    begin;
      UpdateHint('');
      FHeaderState := bhsNormal;
      SetMainCursor(crDefault);
    end;
  if AControl=FPanel then
    SetHotItem(nil);
  // If Explorer Bar destroyed, we don't need to repaint sections
  if Assigned(FExplorerBar) and  //RM: 11.01.2012 - Reported by EM
     not (csDestroying in FExplorerBar.ComponentState) then
    Repaint;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  HI : TLMDExplorerBarItem;
begin
  if CheckDesignTime then exit;
  if FExplorerBar<>nil then
    begin
      HI := GetItemAt(FExplorerBar.Canvas,X,Y);
      if HI<>FHotItem then
        begin
          FPanel.Invalidate;
          if HI=nil then
            FPanel.Cursor := crDefault;
        end;
      if HI<>nil then
        begin
          FPanel.Cursor := crHandPoint;
          if not GetShowHintState then
            UpdateHint('')
          else
            if HI.Hint<>'' then
              UpdateHint(HI.Hint)
            else if HI.FCaptionLong then
              UpdateHint(HI.Caption)
            else
              UpdateHint('')
        end;
      SetHotItem(HI);
    end;
  if CheckPointInHeader(X,Y) then
    begin
      if FHeaderState=bhsNormal then
        begin
          FHeaderState := bhsHighlight;
          if GetShowHintState then
            UpdateHint(FHint)
          else
            UpdateHint('');
          SetMainCursor(crHandPoint);
          Repaint;
        end
    end
  else
    begin
      if FHotItem=nil then
        UpdateHint('');
      if FHeaderState=bhsHighlight then
        begin
          if GetShowHintState then
            UpdateHint('');
          FHeaderState := bhsNormal;
          SetMainCursor(crDefault);
          Repaint;
        end
    end
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Item, OldPressed : TLMDExplorerBarItem;
begin
  if CheckDesignTime then
    begin
      if FExplorerBar<>nil then
        case Button of
          mbLeft: FExplorerBar.Perform(WM_LBUTTONUP,ShiftStateToKeys(Shift),X or (Y shl 16));
          mbRight: FExplorerBar.Perform(WM_RBUTTONUP,ShiftStateToKeys(Shift),X or (Y shl 16));
        end;
      exit;
    end;
  if (FHeaderState=bhsPressed)  then
    begin
      ReleaseMouse;
      FHeaderState:=bhsNormal;
      MouseMove(Shift,X,Y);
      Repaint;
      if CheckPointInHeader(X,Y) then
        FireClick;
    end
  else
    if FPanel.MouseCapture then
      begin
        FPanel.MouseCapture := False;
        OldPressed := FPressedItem;
        FPressedItem := nil;
        Item := GetItemAt(FExplorerBar.Canvas,X,Y);
        if Item=OldPressed then
          begin
            CancelHint;
            Item.Click;
          end;
        //MouseMove(Shift,X,Y);
        Repaint;
      end
    else
      if FExplorerBar <> nil then
        FExplorerBar.DoMouseUp(Button, Shift, X, Y);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.Paint(var PaintInfo: TLMDBarPaintInfo);
var
  OLDPaintInfo : TLMDBarPaintInfo;
  ORGRect : TRect;
  iH,iSize,iTmp : Integer;
  bf : TBlendFunction;
begin
  UpdateScroll;
  if Assigned(FExplorerBar) then
  begin
    PaintInfo.Canvas.Font:= FExplorerBar.HeaderFont;
    iH := GetHeaderHeight(PaintInfo.Canvas);
    OLDPaintInfo := PaintInfo;
    ORGRect := PaintInfo.Rect;
    PaintInfo.Rect.Bottom := PaintInfo.Rect.Top+iH;
    FHeaderRect := PaintInfo.Rect;
    PaintHeader(PaintInfo,FHeaderState);
    if FAnimating then
      begin
        if FAnimateBmp.Empty then
          begin
            FAnimating := False;
            try
              iSize := GetSectionHeight(PaintInfo.Canvas);
              FAnimateBmp.PixelFormat := pf24bit;
              FAnimateBmp.Width := ORGRect.Right-ORGRect.Left;
              if (iSize-iH)>=0 then
                FAnimateBmp.Height := iSize-iH
              else
                FAnimateBmp.Height := 1;
              OLDPaintInfo.Rect := Rect(0,0,FAnimateBmp.Width,FAnimateBmp.Height);
              OLDPaintInfo.Canvas := FAnimateBmp.Canvas;
              PaintBackground(OLDPaintInfo);

              UpdateScroll(OLDPaintInfo.Rect.Bottom-OLDPaintInfo.Rect.Top);
              InflateRect(OLDPaintInfo.Rect,-(1+FMargin),-(1+FMargin));
              FPanel.Visible := False;
              with OLDPaintInfo.Rect do
                FPanel.SetBounds(Left,Top,Right-Left,Bottom-Top);
              FPanel.Parent := FExplorerBar;
              // TODO: if comment this string exception don't appears
              PaintItems(OLDPaintInfo,True);
            finally
              FAnimating := True;
            end;
          end;
        FPanel.Visible := False;
        iTmp := FAnimateBmp.Height-FAnimateStage*FAnimateStep;
        if iTmp<0 then
          iTmp := 0;
        with bf do
          begin
            BlendOp := AC_SRC_OVER;
            BlendFlags := 0;
            SourceConstantAlpha := Trunc(abs(FAnimateMax-FAnimateStage)*200/FAnimateMax)+55;
            AlphaFormat := 0;
          end;
        LMDAlphaBlend(PaintInfo.Canvas.Handle,ORGRect.Left,ORGRect.Top+iH,ORGRect.Right-ORGRect.Left,ORGRect.Bottom-ORGRect.Top-iH,
                      FAnimateBmp.Canvas.Handle,0,FAnimateBmp.Height-iTmp,FAnimateBmp.Width,iTmp,bf);
      end
    else
      begin
        PaintInfo.Rect := ORGRect;
        PaintInfo.Rect.Top := PaintInfo.Rect.Top+iH;
        PaintBackground(PaintInfo);

        InflateRect(PaintInfo.Rect,-(1+FMargin),-(1+FMargin));
        with PaintInfo.Rect do
          FPanel.SetBounds(Left,Top,Right-Left,Bottom-Top);
        FPanel.Parent := FExplorerBar;
        if (FPanel.Parent<>nil) and (not FPanel.Visible) then
          FPanel.Visible := True;
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.PaintBackground(var PaintInfo: TLMDBarPaintInfo);
begin

  if PaintInfo.UseXP then
    LMDThemeServices.DrawElement(ttmPlatform, PaintInfo.Canvas.Handle,  tebNormalGroupBackground, PaintInfo.Rect)
  else
    with PaintInfo.Canvas do
      begin
        Brush.Color := PaintInfo.ExplorerBar.FSectionBackColor;
        FillRect(PaintInfo.Rect);

        Pen.Color := PaintInfo.ExplorerBar.FHeaderStartColor;
        with PaintInfo.Rect do
          begin
            MoveTo(Left,Top);
            LineTo(Left,Bottom-1);
            LineTo(Right-1,Bottom-1);
            LineTo(Right-1,Top);
            Pen.Color := PaintInfo.ExplorerBar.FHeaderEndColor;
            LineTo(Left,Top);
          end;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.PaintInside(var PaintInfo: TLMDBarPaintInfo);
begin
  InflateRect(PaintInfo.Rect,2,2);
  PaintBackground(PaintInfo);

  InflateRect(PaintInfo.Rect,-2,-2);
  PaintItems(PaintInfo,False);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.PaintHeader(var PaintInfo: TLMDBarPaintInfo;State:TLMDBarHeaderState);
var
  aRgn,tmpRgn  : HRGN;
  btn   : TThemedExplorerBar;
  capRect,btnRect:TRect;
  aBmp    : TBitmap;
  TF: LogFontW;
  TC     : COLORREF;
begin
  capRect := PaintInfo.Rect;
  btnRect := PaintInfo.Rect;

  with btnRect do
    Left := Right-LEB_HEADER_VSPACE-LEB_HEADER_BTN_SIZE;

  with capRect do
    begin
      Left := Left+LEB_HEADER_VSPACE;
      Right := btnRect.Left;
    end;

  if PaintInfo.UseXP then
    begin
      LMDThemeServices.DrawElement(ttmPlatform, PaintInfo.Canvas.Handle, tebHeaderBackgroundNormal, PaintInfo.Rect);
      if FExpanded then
        begin
          case FHeaderState of
            bhsPressed : btn := tebNormalGroupExpandPressed;
            bhsHighlight : btn := tebNormalGroupExpandHot;
          else
            btn := tebNormalGroupExpandNormal;
          end;
        end
      else
        case FHeaderState of
          bhsPressed : btn := tebNormalGroupCollapsePressed;
          bhsHighlight : btn := tebNormalGroupCollapseHot;
        else
          btn := tebNormalGroupCollapseNormal;
        end;

      LMDThemeServices.GetThemeFont(ttmPlatform, PaintInfo.Canvas.Handle, teExplorerBar, EBP_NORMALGROUPHEAD,0, TMT_FONT, TF);
      PaintInfo.Canvas.Font.Handle := CreateFontIndirectW(TF);
      //PaintInfo.Canvas.Font.Assign(PaintInfo.ExplorerBar.FHeaderFont);

      PaintInfo.Canvas.Brush.Style := bsClear;
      TC := LMDThemeServices.GetThemeColor(ttmPlatform, teExplorerBar, EBP_NORMALGROUPHEAD, EBP_HEADERBACKGROUND, TMT_TEXTCOLOR);

      if FHeaderState <> bhsNormal then
        PaintInfo.Canvas.Font.Color := LMDMakeHC(TC)
      else
        PaintInfo.Canvas.Font.Color := TC;

      LMDThemeServices.DrawElement(ttmPlatform, PaintInfo.Canvas.Handle, btn, btnRect);
      DrawText(PaintInfo.Canvas.Handle,PChar(FCaption),-1,capRect,DT_SINGLELINE or DT_END_ELLIPSIS or DT_LEFT or DT_VCENTER);
      end
  else
    with PaintInfo.Canvas do
      begin
        with PaintInfo.Rect do
          if PaintInfo.ExplorerBar.FHeaderStyle=bhsRounded then
            aRgn := CreateRoundRectRgn(Left,Top,Right+1,Bottom,4,4)
          else
            aRgn := CreateRectRgn(Left,Top,Right+1,Bottom);
        with PaintInfo.Rect do
          tmpRgn := CreateRectRgn(Left,Top+(Bottom-Top) div 2,Right,Bottom);
        CombineRgn(aRgn,aRgn,tmpRgn,RGN_OR);
        DeleteObject(tmpRgn);
        //RM iState := SaveDC(PaintInfo.Canvas.Handle);
        SelectClipRgn(PaintInfo.Canvas.Handle,aRgn);
        DeleteObject(aRgn);

        try
          Brush.Color := PaintInfo.ExplorerBar.FHeaderStartColor;
          FillRect(PaintInfo.Rect);
          with PaintInfo.Rect do
            Left := Right-(Right-Left) div 3;
          LMDGradientPaint(PaintInfo.Canvas,PaintInfo.Rect,PaintInfo.ExplorerBar.FHeaderStartColor,PaintInfo.ExplorerBar.FHeaderEndColor,20,gstHorizontal,0,0);
        finally
          SelectClipRgn(PaintInfo.Canvas.Handle,0);
          //RM RestoreDC(PaintInfo.Canvas.Handle,iState);
        end;

        if FExpanded then
          case FHeaderState of
            bhsPressed : aBmp := PaintInfo.ExplorerBar.FCollapseGlyphDown;
            bhsHighlight : aBmp := PaintInfo.ExplorerBar.FCollapseGlyphHot;
          else
            aBmp := PaintInfo.ExplorerBar.FCollapseGlyphUp;
          end
        else
          case FHeaderState of
            bhsPressed : aBmp := PaintInfo.ExplorerBar.FExpandGlyphDown;
            bhsHighlight : aBmp := PaintInfo.ExplorerBar.FExpandGlyphHot;
          else
            aBmp := PaintInfo.ExplorerBar.FExpandGlyphUp;
          end;
        btnRect.Left := btnRect.Left+(btnRect.Right-btnRect.Left-aBmp.Width) div 2;
        btnRect.Top := btnRect.Top+(btnRect.Bottom-btnRect.Top-aBmp.Height) div 2;
        PaintInfo.Canvas.Draw(btnRect.Left,btnRect.Top,aBmp);
        PaintInfo.Canvas.Font := PaintInfo.ExplorerBar.FHeaderFont;
        if FHeaderState<>bhsNormal then
          PaintInfo.Canvas.Font.Color := PaintInfo.ExplorerBar.FHightlightColor;
        PaintInfo.Canvas.Brush.Style := bsClear;
        DrawText(PaintInfo.Canvas.Handle,PChar(FCaption),-1,capRect,DT_SINGLELINE or DT_END_ELLIPSIS or DT_LEFT or DT_VCENTER);
        end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.PaintItems(var PaintInfo: TLMDBarPaintInfo;bPaintPanel:Boolean);
var
  DI : TLMDBarDrawInfo;
  i, tmph  : Integer;     // tmph: Temporary Height for an item...
  X,TX,Y : Integer;
  OldRect ,capRect, calcRect: TRect;
  Bmp    : TBitmap;
  TC     : COLORREF;
  ClipRgn,OldRgn:THANDLE;
  tmp:String;
begin
  if not FExpanded then exit;

  OldRect := PaintInfo.Rect;
  if FScrollBar.Visible then
    PaintInfo.Rect.Right := FScrollBar.Left;

  OldRgn := CreateRectRgn(0,0,0,0);
  if GetClipRgn(PaintInfo.Canvas.Handle,OldRgn)<>1 then
    begin
      DeleteObject(OldRgn);
      OldRgn := 0;
    end;
  with PaintInfo.Rect do
    ClipRgn := CreateRectRgn(Left,Top,Right,Bottom);
  if OldRgn<>0 then
    CombineRgn(ClipRgn,ClipRgn,OldRgn,RGN_AND);
  SelectClipRgn(PaintInfo.Canvas.Handle,ClipRgn);
  try
    case FStyle of
     ebsItemList:
       if FItems.Count>0 then
         begin
           if PaintInfo.UseXP then
             TC := LMDThemeServices.GetThemeColor(ttmPlatform, teExplorerBar, EBP_NORMALGROUPBACKGROUND, EBP_HEADERBACKGROUND, TMT_TEXTCOLOR)
           else
             TC := clNone;

           Y := PaintInfo.Rect.Top+(FItemsVSpace div 2);
           if FUseScroll then
             Y:=Y-FScrollPos;
           X := PaintInfo.Rect.Left+FItemsHSpace;
           TX := X;
           if FImageList<>nil then
             Inc(TX, FItemsHSpace div 2 + FImageList.Width);

           PaintInfo.Canvas.Font := FCurrentItemFont;
           tmph:=GetItemHeight(PaintInfo.Canvas);
           for i:=0 to FItems.Count-1 do
             begin
               if FItems[i].Visible then
                 begin
                   if FImageList<>nil then
                     begin
                       FImageList.Draw(PaintInfo.Canvas,X,Y,FItems[i].ImageIndex,FItems[i].Enabled);
                     end;
                   FItems[i].FCaptionLong:=False;
                   capRect := Rect(TX,Y,PaintInfo.Rect.Right-FItemsHSpace div 4,Y+tmph);

                   if capRect.Top>=PaintInfo.Rect.Bottom then
                     break;

                   PaintInfo.Canvas.Brush.Style := bsClear;
                   PaintInfo.Canvas.Font:=FCurrentItemFont;

                   if PaintInfo.UseXP then
                     begin
                       TC := LMDThemeServices.GetThemeColor(ttmPlatform, teExplorerBar, EBP_NORMALGROUPBACKGROUND, EBP_HEADERBACKGROUND, TMT_TEXTCOLOR);
                       if FItems[i].Enabled then
                         PaintInfo.Canvas.Font.Color := TC
                       else
                         PaintInfo.Canvas.Font.Color := LMDMakeHC(TC,$40);
                     end
                   else
                     begin
                       //PaintInfo.Canvas.Font := FCurrentItemFont; //FItems[i].FFont;
                       if FItems[i].Enabled then
                         PaintInfo.Canvas.Font.Color := PaintInfo.ExplorerBar.FItemsColor
                       else
                         PaintInfo.Canvas.Font.Color := PaintInfo.ExplorerBar.FItemsDisableColor;
                     end;

                   // Current item in Hotstate?
                   if FHotItem=FItems[i] then
                     begin
                       PaintInfo.Canvas.Font.Style := PaintInfo.Canvas.Font.Style+[fsUnderline];
                       if not PaintInfo.UseXP then
                         PaintInfo.Canvas.Font.Color := PaintInfo.ExplorerBar.ItemsHightlightColor
                       else
                         PaintInfo.Canvas.Font.Color := LMDMakeHC(TC);
                     end;

                   tmp:=FItems[i].FCaption;

                   if Assigned(FItems[i].FOnGetItemSettings) then
                     FItems[i].FOnGetItemSettings(FExplorerBar,self, FItems[i], PaintInfo.Canvas.Font, tmp);

                   if GetShowHintState then
                     begin
                       calCrect:=capRect;
                       DrawText(PaintInfo.Canvas.Handle,PChar(tmp),-1,calcRect,DT_SINGLELINE or DT_LEFT or DT_VCENTER or DT_CALCRECT);
                       FItems[i].FCaptionLong:=calcrect.Right>capRect.Right;
                     end;

                   DrawText(PaintInfo.Canvas.Handle,PChar(tmp),-1,capRect,DT_SINGLELINE or DT_END_ELLIPSIS or DT_LEFT or DT_VCENTER);
                   Inc(Y,(FItemsVSpace div 2) +tmph {FItems[i].GetHeight(PaintInfo.Canvas)});
                 end;
             end;
        end;
      ebsOwnerDraw:
        begin
          if Assigned(FOnDrawInfo) then
            begin
              DI.PaintInfo := PaintInfo;
              FOnDrawInfo(Self,DI);
            end;
        end;
    end;
  finally
    SelectClipRgn(PaintInfo.Canvas.Handle,OldRgn);
    DeleteObject(ClipRgn);
    if OldRgn<>0 then
      DeleteObject(OldRgn);
  end;

  PaintInfo.Rect := OldRect;
  if bPaintPanel then
    begin
      Bmp := TBitmap.Create;
      try
        Bmp.PixelFormat := pf24bit;
        with PaintInfo.Rect do
          begin
            Bmp.Width := Right-Left;
            Bmp.Height := Bottom-Top;
          end;
        Bmp.TransparentMode := tmFixed;
        Bmp.TransparentColor := LEB_TRANS_COLOR;
        Bmp.Canvas.Brush.Color := Bmp.TransparentColor;
        Bmp.Canvas.FillRect(Bmp.Canvas.ClipRect);
        Bmp.Transparent := True;
        Bmp.Canvas.Lock;
        try
          FPanel.PaintTo(Bmp.Canvas.Handle,0,0);
        finally
          Bmp.Canvas.Unlock;
        end;
        with PaintInfo.Rect do
          PaintInfo.Canvas.Draw(Left,Top,Bmp);
      finally
        Bmp.Free;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.QuickSort(L, R: Integer);
var
  I, J, P,K: Integer;
  I1,I2 : TLMDExplorerBarItem;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while ItemsCompare(FItems[I], FItems[P]) < 0 do Inc(I);
      while ItemsCompare(FItems[J],FItems[P]) > 0 do Dec(J);
      if I <= J then
        begin
          I1 := FItems[I];
          I2 := FItems[J];
          if I>J then
            begin
              I2 := I1;
              I1 := FItems[J];
            end;
          K := I2.Index;
          I2.Index := I1.Index;
          I1.Index := K;
          if P = I then
            P := J
          else if P = J then
            P := I;
          Inc(I);
          Dec(J);
        end;
    until I > J;
    if L < J then QuickSort(L, J);
    L := I;
  until I >= R;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.ReleaseMouse;
begin
  if FExplorerBar<>nil then
    begin
      FExplorerBar.MouseCapture := False;
      FExplorerBar.FCaptureSection := nil;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.Repaint;
var
  tmpRect : TRect;
begin
  if FExplorerBar<>nil then
    begin
      tmpRect := Rect(iLeft,iTop,iLeft+iWidth,iTop+iHeight);
      InvalidateRect(FExplorerBar.Handle,@tmpRect,True);
      if FStyle<>ebsContainer then
        FPanel.Invalidate;
      if FScrollBar.Visible then
        begin
          with FScrollBar do
            tmpRect := Rect(Left,Top,Left+Width,Top+Height);
          ValidateRect(FPanel.Handle,@tmpRect);
          end;
      UpdateWindow(FExplorerBar.Handle);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.ReSort;
begin
  if FSorted and (FItems.Count>0) then
    begin
      FItems.FSorting := True;
      try
        QuickSort(0, FItems.Count - 1);
      finally
        FItems.FSorting := False;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.ScrollChangeEvent(Sender: TObject);
begin
  if Assigned(FOnScrollChange) then
    FOnScrollChange(Sender);
  if (FScrollBar.Position+FScrollBar.PageSize)>FScrollBar.Max then
    FScrollBar.Position := FScrollBar.Max-FScrollBar.PageSize;
  FScrollPos := FScrollBar.Position;
  if FPanel.Visible then
    Repaint;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.ScrollEvent(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  if Assigned(FOnScroll) then
    FOnScroll(Sender,ScrollCode,ScrollPos);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SectionChanged;
begin
  ReSort;
  SetHotItem(nil);
  Changed(True);
  UpdateScroll;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetHotItem(Item: TLMDExplorerBarItem);
begin
  if FHotItem=Item then exit;

  if Assigned(FHotItem) then
    FHotItem.DoMouseExit;

  FHotItem:=Item;

  if Assigned(FHotItem) then
    FHotItem.DoMouseEnter;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.StartAnimate;
begin
  FAnimateBmp := TBitmap.Create;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.StopAnimate;
begin
  FAnimateBmp.Free;
  FAnimateBmp := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.UpdateHint(szHint: String);
begin
  if FExplorerBar<>nil then
    FExplorerBar.UpdateHint(szHint);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.UpdateScroll(Height:Integer);
var
  iH,iActual,iDef : Integer;
begin
  if FAnimating or (FExplorerBar=nil) or (csDestroying in FExplorerBar.ComponentState) then
    exit;

  if (FStyle=ebsItemList) then
    begin
      if (FExplorerBar<>nil) and FExpanded then
        begin
          iH := GetHeaderHeight(FExplorerBar.Canvas);
          if Height=-1 then
            iActual := iHeight-iH
          else
            iActual := Height;
          iDef := GetDefSectionItemsHeight(FExplorerBar.Canvas);
          FUseScroll := iActual<iDef;
          if FUseScroll then
            begin
              FScrollBar.Min := 0;
              FScrollBar.Max := iDef;
              FScrollBar.PageSize := iActual;
              if FScrollPos>iDef then
                FScrollPos := 0;
              FScrollBar.Position := FScrollPos;
              FScrollBar.SmallChange := 5;
              FScrollBar.LargeChange := iDef div 10;
            end;
        end
      else
        FUseScroll := False;
      FScrollBar.Visible := FUseScroll;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetLinkedControl(const Value: TControl);
begin
  if FLinkedControl <> nil then
    begin
      FLinkedControl.RemoveFreeNotification(FPanel);
      if FLinkedControl.Parent = FPanel then
        begin
          FLinkedControl.Visible := False;
          FLinkedControl.Parent := nil;
        end;
    end;
  FLinkedControl := Value;
  if FLinkedControl <> nil then
    FLinkedControl.FreeNotification(FPanel);
  UpdateLinkedControl;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetLinkedControlAlign(const Value: TAlign);
begin
  FLinkedControlAlign := Value;
  UpdateLinkedControl;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetLinkedControlLeft(const Value: Integer);
begin
  FLinkedControlLeft := Value;
  UpdateLinkedControl;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetLinkedControlTop(const Value: Integer);
begin
  FLinkedControlTop := Value;
  UpdateLinkedControl;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.Notification(AComponent: TComponent; Operation: TOperation);
var
  i:Integer;
begin
  if (Operation=opRemove) then
    begin
      if (AComponent=LinkedControl) then LinkedControl:=nil;
      if (AComponent=FImageList) then ImageList := nil;
      if (AComponent is TBasicAction) then
        for i:=0 to Items.Count-1 do
          Items[i].Notification(AComponent, Operation);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.Loaded;
begin
  inherited;
  UpdateLinkedControl;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.UpdateLinkedControl;
begin
  if CheckDesignTime then exit;
  if Assigned(FLinkedControl) and (FStyle=ebsContainer) then
    begin
      {$IFDEF LMDCOMP9}
      // This is necessary for Delphi 8 and higher. If Control hasn't parent control
      // then it can't be parent for another control. VCL throw an exception
      if FPanel.Parent = nil then
        FPanel.Parent := FExplorerBar;
      if FPanel.Parent <> nil then
      begin
      {$ENDIF}
        FLinkedControl.Parent := FPanel;
        FLinkedControl.Align := FLinkedControlAlign;
        FLinkedControl.Left := FLinkedControlLeft;
        FLinkedControl.Top := FLinkedControlTop;
        FLinkedControl.Visible := true;
      {$IFDEF LMDCOMP9}
      end;
      {$ENDIF}
    end;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDExplorerBarSection.Create(Collection: TCollection);
begin
  FItems := TLMDExplorerBarItems.Create(Self);
  FVisible := True;
  FMargin:=1;
  FExpanded := True;
  FFont := TFont.Create;
  FFont.OnChange:=SectionChanged;
  FHeaderSize := 0;
  FItemsHSpace := LEB_VSECTIONS_SPACE;
  FItemsVSpace := LEB_VSECTIONS_SPACE;
  FHeaderState := bhsNormal;
  FPanel := TLMDExplorerBarPanel.Create(GetControlOwner);
  FPanel.Section := Self;
  FPanel.Visible := False;
  FScrollBar := TScrollBar.Create(nil);
  FScrollBar.Parent := FPanel;
  FScrollBar.Kind := sbVertical;
  FScrollBar.Align := alRight;
  FScrollBar.ParentCtl3D := False;
  FScrollBar.Visible := False;
  FScrollBar.OnScroll := ScrollEvent;
  FScrollBar.OnChange := ScrollChangeEvent;
  FUseScroll := False;
  FScrollPos := 0;
  FSorted := False;
  FParentShowHint := True;
  FParentFont:=True;
  FShowHint := False;
  FVertScrollBar := False;
  FLinkedControlAlign := alClient;
  FLMDTextLabel :=nil;
  FName := TLMDExplorerBarSections(Collection).GetSectionName;
  FCurrentItemFont:=TFont.Create;
  inherited;
  end;

{------------------------------------------------------------------------------}
destructor TLMDExplorerBarSection.Destroy;
begin
  while FAnimating do ;

  // 1.00.54 - fixes error #
  LinkedControl:=nil;
  ImageList := nil;

  if FLMDTextLabel<>nil then
    FreeAndNil(FLMDTextLabel);

  FreeAndNil(FItems);
  FreeAndNil(FFont);
  FreeAndNil(FScrollBar);
  FreeAndNil(FPanel);
  FreeAndNil(FCurrentItemFont);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.Assign(Source: TPersistent);
begin
  if Source is TLMDExplorerBarSection then
    with TLMDExplorerBarSection(Source) do
      begin
        Self.Caption := Caption;
        Self.Style := Style;
        Self.Items := Items;
        Self.Expanded := Expanded;
        Self.Visible := Visible;
        Self.Height := Height;
        Self.Sorted := Sorted;
        Self.VertScrollBar := VertScrollBar;
        Self.Font := Font;
        Self.ParentFont := ParentFont;
        Self.Hint := Hint;
        Self.ShowHint := ShowHint;
        Self.ParentShowHint := ParentShowHint;
        Self.ImageList := ImageList;
        Self.HeaderSize := HeaderSize;
        Self.ItemsVSpace := ItemsVSpace;
        Self.ItemsHSpace := ItemsHSpace;
        Self.OnMeasureHeight := OnMeasureHeight;
        Self.OnExpand := OnExpand;
        Self.OnCollapse := OnCollapse;
        Self.OnSort := OnSort;
        Self.OnDrawInfo := OnDrawInfo;
        Self.OnScrollChange := OnScrollChange;
        Self.OnScroll := OnScroll;
        exit;
      end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSection.SetSize(Left, Top, Width, Height : Integer);
begin
  iLeft := Left;
  iTop := Top;
  iWidth := Width;
  iHeight := Height;
  FPanel.Parent := FExplorerBar;
end;

{ ********************** TLMDExplorerBarSections ******************************}
{ --------------------------- protected -------------------------------------- }
function TLMDExplorerBarSections.GetItemByName(Value: String): TLMDExplorerBarSection;
var
  i : Integer;
begin
  Result := nil;
  for i:=0 to Count-1 do
    if Section[i].FName=Value then
    begin
      Result := Section[i];
      break;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarSections.GetItems(Index: Integer): TLMDExplorerBarSection;
begin
  Result := TLMDExplorerBarSection(inherited Items[Index]);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarSections.GetSectionName: String;
var
  i : Integer;
begin
  i := 1;
  repeat
    Result := 'Section'+IntToStr(i);
    inc(i);
  until SectionByName[Result]=nil;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDExplorerBarSections.Create(Owner: TPersistent);
begin
  inherited Create(Owner, TLMDExplorerBarSection);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSections.Activate;
var
  i : Integer;
begin
  if(FExplorerBar<>nil) and (FExplorerBar<>ExplorerBar) then
    begin
      if FExplorerBar.GetActiveSections=Self then
        FExplorerBar.SectionStorage:=nil;
    end;
  FExplorerBar := ExplorerBar;
  for i:=0 to Count-1 do
    Section[i].Activate(ExplorerBar);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarSections.Add: TLMDExplorerBarSection;
begin
  Result := TLMDExplorerBarSection(inherited Add);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSections.Deactivate;
var
  i : Integer;
begin
  for i:=0 to Count-1 do
    Section[i].Deactivate(ExplorerBar);
  FExplorerBar := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBarSections.Update(Item: TCollectionItem);
begin
  inherited;
  if FExplorerBar<>nil then
    begin
      FExplorerBar.ChangeSections(Self,Self);
      if Item<>nil then
         TLMDExplorerBarSection(Item).FPanel.Invalidate;
      if Assigned(FExplorerBar.FOnChange) and not (csLoading in FExplorerBar.ComponentState) then
        FExplorerBar.FOnChange(self);
      FExplorerBar.InvalidateEx;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBarSections.ValidateName(NewName: String): String;
begin
  Result := NewName;
  if SectionByName[NewName]<>nil then
    Result := GetSectionName;
end;

{ ************************ TLMDExplorerBar ************************************}
{ ----------------------------- private -------------------------------------- }
function TLMDExplorerBar.GetActiveSections: TLMDExplorerBarSections;
begin
  if (FSectionStorage<>nil) then
    Result := FSectionStorage.Sections
  else
    Result := FSections;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBar.GetScrollBarVisible: Boolean;
begin
  result:=false;
  if HandleAllocated then
    result:=GetWindowLong(handle, GWL_STYLE) and WS_VSCROLL <> 0
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBar.IsCustomColor: Boolean;
begin
  result:=IsNoController and (FColor<>LEB_BACK_COLOR);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBar.IsCustomCtlXP: Boolean;
begin
  result:=IsNoController and (FCtlXP<>True);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBar.IsCustomHeaderEndColor: Boolean;
begin
  result:=IsNoController and (FHeaderEndColor <>LEB_HEADER_END);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBar.IsCustomHeaderStartColor: Boolean;
begin
  result:=IsNoController and (FHeaderStartColor <>LEB_HEADER_START);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBar.IsCustomHighlightColor: Boolean;
begin
  result:=IsNoController and (FHightlightColor<>LEB_HEADER_HIGHLIGHT);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBar.IsCustomHSpace: Boolean;
begin
  result:=IsNoController and (FHSpace<>LEB_HSPACE);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBar.IsCustomItemsColor: Boolean;
begin
  result:=IsNoController and (FItemsColor<>LEB_HEADER_COLOR);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBar.IsCustomItemsDisableColor: Boolean;
begin
  result:=IsNoController and (FItemsDisableColor<>LEB_ITEM_DISABLE);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBar.IsCustomItemsHighlightColor: Boolean;
begin
  result:=IsNoController and (FItemsHightlightColor<>LEB_HEADER_HIGHLIGHT);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBar.IsCustomSectionBackColor: Boolean;
begin
  result:=IsNoController and (FSectionBackColor<>LEB_SECTION_BACK);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBar.IsCustomSectionSpace: Boolean;
begin
  result:=IsNoController and (FSectionsSpace<>LEB_VSECTIONS_SPACE);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBar.IsCustomVSpace: Boolean;
begin
  result:=IsNoController and (FVSpace<>LEB_VSPACE);
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBar.IsCustomHeaderStyle: Boolean;
begin
  result:=IsNoController and (FHeaderStyle <>bhsRounded);
end;
{------------------------------------------------------------------------------}
function TLMDExplorerBar.IsNoController: Boolean;
begin
  result:=FThemeController=nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
    begin
      FBorderStyle := Value;
      RecreateWnd;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetColor(const Value: TColor);
begin
  if Value<>FColor then
    begin
      FColor := Value;
      InvalidateEx;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetCtlXP(const Value: Boolean);
begin
  if Value<>FCtlXP then
    begin
      FCtlXP := Value;
      InvalidateEx;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetCollapseGlyphDown(const Value: TBitmap);
begin
  FCollapseGlyphDown.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetCollapseGlyphUp(const Value: TBitmap);
begin
  FCollapseGlyphUp.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetCollapseGlyphHot(const Value: TBitmap);
begin
  FCollapseGlyphHot.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetExpandGlyphHot(const Value: TBitmap);
begin
  FExpandGlyphHot.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetExpandGlyphDown(const Value: TBitmap);
begin
  FExpandGlyphDown.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetExpandGlyphUp(const Value: TBitmap);
begin
  FExpandGlyphUp.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetCollapseGlyph(const Value: TBitmap);
begin
  FCollapseGlyph.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetExpandGlyph(const Value: TBitmap);
begin
 FExpandGlyph.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetHeaderEndColor(const Value: TColor);
begin
  if HeaderEndColor<>Value then
    begin
      FHeaderEndColor := Value;
      InvalidateEx;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetHeaderFont(const Value: TFont);
begin
  FHeaderFont.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetHeaderStartColor(const Value: TColor);
begin
  if FHeaderStartColor<>Value then
    begin
      FHeaderStartColor := Value;
      InvalidateEx;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetHightlightColor(const Value: TColor);
begin
  if FHightlightColor<>Value then
    begin
      FHightlightColor := Value;
      InvalidateEx;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetHSpace(const Value: Integer);
begin
  if FHSpace<>Value then
    begin
      FHSpace := Value;
      InvalidateEx;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetSectionBackColor(const Value: TColor);
begin
  if FSectionBackColor<>Value then
    begin
      FSectionBackColor := Value;
      InvalidateSections;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetSections(const Value: TLMDExplorerBarSections);
var
  b : Boolean;
begin
  b := GetActiveSections=FSections;
  if b then
    FSections.Deactivate(Self);
  FSections.Assign(Value);
  if b then
    FSections.Activate(Self);
  InvalidateEx;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetSectionsSpace(const Value: Integer);
begin
  if FSectionsSpace<>Value then
    begin
      FSectionsSpace := Value;
      InvalidateEx;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetSectionStorage(const Value: TLMDExplorerBarStorage);
var
  S : TLMDExplorerBarSections;
begin
  S := GetActiveSections;
  if FSectionStorage <> Value then
    begin
      if FSectionStorage <> nil then
        begin
          FSectionStorage.RemoveFreeNotification(Self);
          FSectionStorage.RemoveUpdateObject(Self);
        end;
      FSectionStorage:= Value;
      if FSectionStorage <> nil then
        begin
          FSectionStorage.FreeNotification(Self);
          FSectionStorage.AddUpdateObject(Self);
        end;
      UpdateSectionStorage;
    end;
  if(S<>GetActiveSections) then
    begin
      ChangeSections(S,GetActiveSections);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetVSpace(const Value: Integer);
begin
  if FVSpace<>Value then
    begin
      FVSpace := Value;
      InvalidateEx;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetItemsColor(const Value: TColor);
begin
  if Value<>FItemsColor then
    begin
      FItemsColor := Value;
      InvalidateSections;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetItemsHightlightColor(const Value: TColor);
begin
  if FItemsHightlightColor<>Value then
    begin
      FItemsHightlightColor := Value;
      InvalidateSections;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetHeaderStyle(const Value: TLMDBarHeaderStyle);
begin
  if FHeaderStyle<>Value then
    begin
      FHeaderStyle := Value;
      InvalidateEx;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetImageProperties(dstBmp,srcBmp:TBitmap;Index:Integer);
begin
  dstBmp.Width := srcBmp.Width div 3;
  dstBmp.Height:= srcBmp.Height;
  dstBmp.PixelFormat := srcBmp.PixelFormat;
  dstBmp.TransparentColor := srcBmp.TransparentColor;
  dstBmp.TransparentMode := srcBmp.TransparentMode;
  dstBmp.Transparent := srcBmp.Transparent;
  dstBmp.Canvas.CopyRect(Rect(0,0,dstBmp.Width,dstBmp.Height),srcBmp.Canvas,Rect(dstBmp.Width*Index,0,dstBmp.Width*(Index+1),dstBmp.Height));
  dstBmp.Transparent := true;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetItemsDisableColor(const Value: TColor);
begin
  if Value<>FItemsDisableColor then
    begin
      FItemsDisableColor := Value;
      InvalidateSections;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.SetThemeController(const Value: TLMDExplorerBarController);
begin
  if FThemeController <> Value then
    begin
      if FThemeController <> nil then
        begin
          FThemeController.RemoveFreeNotification(Self);
          FThemeController.RemoveUpdateObject(Self);
        end;
      FThemeController:= Value;
      if FThemeController <> nil then
        begin
          FThemeController.FreeNotification(Self);
          FThemeController.AddUpdateObject(Self);
        end;
      UpdateTheme;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDExplorerBar.CMFontChanged(var Message: TMessage);
begin
  inherited;
  InvalidateEx;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.CMMouseEnter(var Message: TMessage);
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if not MouseCapture then
    ClearLastMouseMoveSection;
  CancelHint;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.CMUpdateLinkMessage(var Message: TMessage);
var
  aObject  : TObject;
  begin
  aObject := Pointer(Message.LParam);
  if aObject<>nil then
  begin
      if Assigned(FSectionStorage) and (aObject = FSectionStorage) then
      begin
          GetActiveSections.Deactivate(Self);
          UpdateSectionStorage;
          GetActiveSections.Activate(Self);
        end
      else
      if(aObject = FThemeController) then
      begin
          UpdateTheme;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.WMNCHitTest(var Message:TMessage);
begin
  if (csDesigning in ComponentState) then
    DefaultHandler(Message)
  else
    inherited;
  end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.WMVScroll(var Message: TWMVScroll);
begin
  case Message.ScrollCode of
    SB_LINEUP:
        Dec(FScrollPosition,FScrollSize);

    SB_LINEDOWN:
        Inc(FScrollPosition,FScrollSize);

    SB_PAGEUP:
        Dec(FScrollPosition,ClientHeight);

    SB_PAGEDOWN:
        Inc(FScrollPosition,ClientHeight);

    SB_THUMBTRACK,
    SB_THUMBPOSITION:
        FScrollPosition := Message.Pos;

    SB_TOP:
        FScrollPosition := 0;

    SB_BOTTOM:
        FScrollPosition := $FFFFFF;
  end;
  ArrangeSections;
  Repaint;
  Message.Result := 0;
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDExplorerBar.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    begin
      Style := Style or WS_CLIPCHILDREN or WS_VSCROLL or WS_CLIPSIBLINGS;
      ExStyle := ExStyle or WS_EX_CONTROLPARENT;
      if (FBorderStyle = bsSingle) then
         ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.CancelHint;
begin
  if Assigned(FHintWnd) then
    ShowWindow(FHintWnd.Handle, SW_HIDE);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.ChangeSections(OldS, NewS: TLMDExplorerBarSections);
begin
  if OldS<>nil then
    OldS.Deactivate(Self);
  if not (csDestroying in ComponentState) then
    InvalidateEx;
  if NewS<>nil then
    NewS.Activate(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.ClearLastMouseMoveSection;
begin
  if FLastMouseMoveSection<>nil then
    FLastMouseMoveSection.MouseLeave(Self);
  FLastMouseMoveSection := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.CreateSectionBitmap(Bmp: TBitmap; Section: TLMDExplorerBarSection);
var
  PaintInfo: TLMDBarPaintInfo;
begin
  Bmp.Width := Section.iWidth;
  Bmp.Height := Section.iHeight;
  with PaintInfo do
    begin
      ExplorerBar := Self;
      Canvas := Bmp.Canvas;
      UseXP := LMDApplication.XPThemesSupported and CtlXP;
      Handle := Self.Handle;
    end;
  PaintInfo.Rect := Rect(0,0,Bmp.Width,Bmp.Height);
  Section.Paint(PaintInfo);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.GlyphsChanged;
var
  tmpBmp : TBitmap;
begin
  tmpBmp := TBitmap.Create;
  try
    if FCollapseGlyph.Empty then
      tmpBmp.LoadFromResourceName(HInstance, 'LMDEXPLORERBAR_UP')
      else
      tmpBmp.Assign(FCollapseGlyph);
    SetImageProperties(FCollapseGlyphUp,tmpBmp,0);
    SetImageProperties(FCollapseGlyphHot,tmpBmp,1);
    SetImageProperties(FCollapseGlyphDown,tmpBmp,2);
  finally
    tmpBmp.Free;
  end;
  tmpBmp := TBitmap.Create;
  try
    if FExpandGlyph.Empty then
      tmpBmp.LoadFromResourceName(HInstance,'LMDEXPLORERBAR_DOWN')
      else
      tmpBmp.Assign(FExpandGlyph);
    SetImageProperties(FExpandGlyphUp,tmpBmp,0);
    SetImageProperties(FExpandGlyphHot,tmpBmp,1);
    SetImageProperties(FExpandGlyphDown,tmpBmp,2);
  finally
    tmpBmp.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.InvalidateEx;
begin
  if [csLoading, csReading, csDestroying]*ComponentState=[] then
    begin
      ArrangeSections;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.Loaded;
begin
  inherited;
  if not FCtlXP and not (FCollapseGlyph.Empty and FExpandGlyph.Empty) then GlyphsChanged;
  ArrangeSections;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Section : TLMDExplorerBarSection;
begin
  inherited;
  if (csDesigning in ComponentState) then exit;
  Section := GetSectionByPoint(X,Y);
  if Section<>nil then
    Section.MouseDown(Button,Shift,X,Y)
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Section : TLMDExplorerBarSection;
begin
  inherited;
  if (csDesigning in ComponentState) then exit;
  Section := GetSectionByPoint(X,Y);
  if FLastMouseMoveSection<>Section then
    begin
      if FLastMouseMoveSection<>nil then
        FLastMouseMoveSection.MouseLeave(Self);
      if Section<>nil then
        Section.MouseEnter(Self);
      FLastMouseMoveSection := Section;
    end;
  if Section<>nil then
    begin
      Section.MouseMove(Shift,X,Y);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Section : TLMDExplorerBarSection;
begin
  inherited;
  if (csDesigning in ComponentState) then exit;
  Section := GetSectionByPoint(X,Y);
  if Section<>nil then
    Section.MouseUp(Button,Shift,X,Y)
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.Notification(AComponent: TComponent; Operation: TOperation);
var
  i:Integer;
begin
  if (Operation = opRemove) and (AComponent <> nil)  then
    begin
      if (AComponent = FSectionStorage)  then
        begin
          FSectionStorage:= nil;
          UpdateSectionStorage;
          ChangeSections(nil,GetActiveSections);
        end;
      if (AComponent = FThemeController)  then
        begin
          FThemeController:= nil;
          UpdateTheme;
        end;
      if (AComponent is TBasicAction) then
        for i:=0 to FSections.Count-1 do
          FSections[i].Notification(AComponent,Operation);
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.UpdateHint(szHint:String);
begin
  if Assigned(FHintWnd) then
    if FHintWnd.Caption<>szHint then
      begin
        StopHintTimer;
        if FHintWnd.HandleAllocated and IsWindowVisible(FHintWnd.Handle) then
          ShowWindow(FHintWnd.Handle, SW_HIDE);
        FHintWnd.Caption := szHint;
        if szHint<>'' then
          begin
            StartHintTimer(FHintPause);
          end;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.OnHintTimer(Sender: TObject);
var
  R, tmpRect : TRect;
  pTopLeft, pBottomRight, P : TPoint;
  szHint : String;
begin
  FHintTimer.Enabled := False;
  GetCursorPos(P);
  R := ClientRect;
  pTopLeft := ClientToScreen(Point(0,0));
  pBottomRight := ClientToScreen(Point(R.Right,R.Bottom));
  R := Rect(pTopLeft.X, pTopLeft.Y, pBottomRight.X, pBottomRight.Y);
  if LMDPointInRect(P, R) then
  begin
  szHint := FHintWnd.Caption;
  FHintWnd.Color := Application.HintColor;
  tmpRect := FHintWnd.CalcHintRect(1024,szHint,nil);
  P.Y := P.Y-(tmpRect.Bottom-tmpRect.Top);
  Inc(tmpRect.Left,P.X);
  Inc(tmpRect.Right,P.X);
  Inc(tmpRect.Top,P.Y);
  Inc(tmpRect.Bottom,P.Y);
  FHintWnd.ActivateHint(tmpRect,szHint);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.GetChange(Sender:TObject);
begin
  if not (csLoading in ComponentState) then
    if Sender is TBitmap then
      GlyphsChanged;
  InvalidateEx;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.Resize;
begin
  if not (csLoading in ComponentState) then
    ArrangeSections;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.StartHintTimer(Value: Integer);
begin
  FHintTimer.Enabled := False;
  FHintTimer.Interval := Value;
  FHintTimer.Enabled := True;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.StopHintTimer;
begin
  FHintTimer.Enabled := False;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.UpdateSectionStorage;
begin
  ClearLastMouseMoveSection;
  FCaptureSection := nil;
  InvalidateEx;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.UpdateTheme;
begin
//  if not (csLoading in ComponentState) then
  begin
    if FThemeController<>nil then
      FThemeController.AssignTo(Self);
    GlyphsChanged;
    InvalidateEx;
    InvalidateSections;
  end;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDExplorerBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle-[csCaptureMouse,csDoubleClicks];
  UseDockManager:=True;
  Width := 100;
  Height := 200;
  FHeaderStyle := bhsRounded;
  FSections:=TLMDExplorerBarSections.Create(Self);
  FSections.Activate(Self);
  FColor := LEB_BACK_COLOR;
  FSmoothEffect := True;
  FCtlXP := True;
  FVSpace := LEB_VSPACE;
  FHSpace := LEB_HSPACE;
  FSectionsSpace := LEB_VSECTIONS_SPACE;
  DoubleBuffered := true;
  FHeaderStartColor := LEB_HEADER_START;
  FHeaderEndColor := LEB_HEADER_END;
  FSectionBackColor := LEB_SECTION_BACK;
  FHeaderFont := TFont.Create;
  FHeaderFont.Color := LEB_HEADER_COLOR;
  FHeaderFont.Style := FHeaderFont.Style + [fsBold];
  FHeaderFont.Name  := LEB_HEADER_FONT_NAME;
  FHeaderFont.OnChange:=GetChange;
  FItemsColor :=  LEB_HEADER_COLOR;
  FItemsDisableColor := LEB_ITEM_DISABLE;
  FCollapseGlyph := TBitmap.Create;
  FCollapseGlyph.OnChange:=GetChange;
  FExpandGlyph := TBitmap.Create;
  FExpandGlyph.OnChange:=GetChange;
  FHintPause := LEB_HINTPAUSE;

  FCollapseGlyphUp := TBitmap.Create;
  FCollapseGlyphDown := TBitmap.Create;
  FCollapseGlyphHot := TBitmap.Create;
  FExpandGlyphUp := TBitmap.Create;
  FExpandGlyphDown := TBitmap.Create;
  FExpandGlyphHot := TBitmap.Create;

  GlyphsChanged;

  FHightlightColor := LEB_HEADER_HIGHLIGHT;
  FItemsHightlightColor := LEB_HEADER_HIGHLIGHT;
  FHintWnd := THintWindow.Create(nil);
  FHintTimer := TTimer.Create(nil);
  FHintTimer.Interval := 0;
  FHintTimer.Enabled := False;
  FHintTimer.OnTimer := OnHintTimer;
end;

{------------------------------------------------------------------------------}
destructor TLMDExplorerBar.Destroy;
begin
  FHintTimer.OnTimer:=nil;
  FHeaderFont.OnChange:=nil;
  FCollapseGlyph.OnChange:=nil;
  FExpandGlyph.OnChange:=nil;

  FreeAndNil(FHintTimer);
  FreeAndNil(FHintWnd);

  SectionStorage := nil;

  FreeAndNil(FExpandGlyph);
  FreeAndNil(FCollapseGlyph);
  FreeAndNil(FExpandGlyphHot);
  FreeAndNil(FExpandGlyphDown);
  FreeAndNil(FExpandGlyphUp);
  FreeAndNil(FCollapseGlyphHot);
  FreeAndNil(FCollapseGlyphUp);
  FreeAndNil(FCollapseGlyphDown);
  FreeAndNil(FHeaderFont);
  FreeAndNil(FSections);
  inherited;
end;

{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP11}
{$O-} //Workaround for Vista slowdown issue
{$ENDIF}
procedure TLMDExplorerBar.ArrangeSections(ShowBar:Boolean=true);
var
  ASections : TLMDExplorerBarSections;
  i  : Integer;
  Y,Height  : Integer;
  CRect : TRect;
  CH, CW : Integer;
  SI : TSCROLLINFO;
begin
  if HandleAllocated then
    CRect := ClientRect
  else
    CRect := Rect(0,0,Width,self.Height);

  ASections := GetActiveSections;
  Y := FVSpace+CRect.Top;

  CH := CRect.Bottom-CRect.Top;
  CW := CRect.Right-CRect.Left;

  Canvas.Font:=HeaderFont;
  for i:=0 to ASections.Count-1 do
    begin
      if not ASections[i].Visible then
        Continue;
      Height := ASections[i].GetSectionHeight(Canvas);
      ASections[i].SetSize(FHSpace,Y,CW-2*FHSpace,Height);
      Inc(Y,Height+FSectionsSpace);
    end;

  if HandleAllocated and ShowBar then
    if (Y>CH) then
      begin
        SI.cbSize := sizeof(SI);
        SI.fMask := SIF_PAGE or SIF_POS or SIF_RANGE or SIF_TRACKPOS;
        SI.nMin := 0;
        SI.nMax := Y;
        if FScrollPosition<0 then
          FScrollPosition := 0;
        if FScrollPosition>(Y-CH) then
          FScrollPosition := (Y-CH);
        SI.nPos := FScrollPosition;
        SI.nPage := CH;
        FScrollSize := CH div 10;
        if FScrollSize<1 then
          FScrollSize := 1;
        SI.nTrackPos := FScrollPosition;
        SetScrollInfo(Handle,SB_VERT,SI,true);
        ShowScrollBar(Handle,SB_VERT,true);
        for i:=0 to ASections.Count-1 do
          begin
            if not ASections[i].Visible then
              Continue;
            Dec(ASections[i].iTop, FScrollPosition);
          end;
      end
    else
      begin
        // this is a workaround for a bug in Windows Vista (RM)
        if LMDSIWindowsVistaUp and not FSmoothEffect then
          begin
            SI.cbSize := sizeof(SI);
            SetScrollInfo(Handle,SB_VERT,SI,true);
            SetScrollInfo(Handle,SB_VERT,SI,false);
          end;
        // ---------------------------------------------------
        ShowScrollBar(Handle, SB_VERT, false);
      end;
end;
{$IFDEF LMDCOMP11}
{$O+}
{$ENDIF}

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.CollapseAll;
var
  i:Integer;
begin
  for i:=0 to GetActiveSections.Count-1 do
    GetActiveSections[i].FExpanded:=False;
  InvalidateEx;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.CollapseSection(Section: TLMDExplorerBarSection);
var
  iStages : Integer;
  iStage  : Integer;
begin
  if FSmoothEffect then
    begin
      iStages := (Section.iHeight-Section.GetHeaderHeight(Canvas)) div LEB_SMOOTH_STEP;
      if iStages > 0 then
        begin
          Section.FAnimating := True;
          Section.FAnimateStep := LEB_SMOOTH_STEP;
          Section.FExpanded := True;
          Section.FAnimateMax := iStages;
          Section.StartAnimate;
          try
            for iStage := 0 to iStages do
              begin
                Section.FAnimateStage := iStage;
                ArrangeSections;
                RePaint;
                Sleep(10);
                Application.ProcessMessages;
              end;
          finally
            Section.FAnimating := False;
            Section.FExpanded := False;
            Section.StopAnimate;
          end;
        end;
    end;
  InvalidateEx;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.ExpandAll;
var
  i:Integer;
begin
  for i:=0 to GetActiveSections.Count-1 do
    GetActiveSections[i].FExpanded:=True;
  InvalidateEx;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.ExpandSection(Section: TLMDExplorerBarSection);
var
  iStages : Integer;
  iStage  : Integer;
begin
  if FSmoothEffect then
    begin
      ArrangeSections;
      iStages := (Section.iHeight-Section.GetHeaderHeight(Canvas)) div LEB_SMOOTH_STEP;
      if iStages>0 then
        begin
          Section.FAnimating := True;
          Section.FAnimateStep := LEB_SMOOTH_STEP;
          Section.FAnimateMax := iStages;
          Section.StartAnimate;
          try
            for iStage:=iStages downto 0 do
              begin
                Section.FAnimateStage := iStage;
                ArrangeSections(false);
                RePaint;
                Sleep(10);
                Application.ProcessMessages;
              end;
          finally
            Section.FAnimating := False;
            Section.StopAnimate;
          end;
        end;
      end;
  InvalidateEx;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBar.GetSectionByPoint(X, Y: Integer): TLMDExplorerBarSection;
var
  S : TLMDExplorerBarSections;
  i : Integer;
begin
  Result := nil;
  if MouseCapture and (FCaptureSection<>nil) then
    begin
      Result := FCaptureSection;
      exit;
    end;

  S := GetActiveSections;
  for i:=0 to S.Count-1 do
    if S[i].Visible then          // RM 28-June-04
      with S[i] do
        begin
          if (X>=iLeft) and (X<=(iLeft+iWidth)) and
             (Y>=iTop) and (Y<=(iTop+iHeight)) then
            begin
              Result := S[i];
              break;
            end;
        end;
end;

{------------------------------------------------------------------------------}
function TLMDExplorerBar.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_BAR;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.InvalidateSections;
var
  i : Integer;
  ASections : TLMDExplorerBarSections;
begin
  ASections := GetActiveSections;
  if not (csLoading in ComponentState) then
    for i:=0 to ASections.Count-1 do
      begin
        if ASections[i].Visible then
          ASections[i].FPanel.Invalidate;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.Paint;
var
  PaintInfo: TLMDBarPaintInfo;
begin
  with PaintInfo do
    begin
      ExplorerBar := Self;
      Canvas := Self.Canvas;
      Rect := GetClientRect;
      UseXP := LMDApplication.XPThemesSupported and CtlXP;
      Handle := Self.Handle;
    end;
  Canvas.Font := Font;
  PaintBackground(PaintInfo);
  PaintSections(PaintInfo);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.PaintBackground(var PaintInfo: TLMDBarPaintInfo);
begin
  if PaintInfo.UseXP then
    LMDThemeServices.DrawElement(ttmPlatForm, PaintInfo.Canvas.Handle, tebExplorerBarDontCare, PaintInfo.Rect)
  else
    with PaintInfo.Canvas do
      begin
        Brush.Color := FColor;
        FillRect(PaintInfo.Rect);
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.PaintSections(var PaintInfo: TLMDBarPaintInfo);
var
  SectionPaintInfo : TLMDBarPaintInfo;
  ASections : TLMDExplorerBarSections;
  i  : Integer;
  ClipRgn,OldRgn: HRGN;
begin
  ASections := GetActiveSections;
  with PaintInfo.Rect do
    OldRgn := CreateRectRgn(Left,Top,Right,Bottom);
  if GetClipRgn(PaintInfo.Canvas.Handle,OldRgn)<>1 then
    begin
      DeleteObject(OldRgn);
      OldRgn := 0;
    end;
  try
    for i:=0 to ASections.Count-1 do
      begin
        if not ASections[i].Visible then
          Continue;
        SectionPaintInfo.ExplorerBar := PaintInfo.ExplorerBar;
        SectionPaintInfo.Canvas := PaintInfo.Canvas;
        SectionPaintInfo.UseXP := PaintInfo.UseXP;
        SectionPaintInfo.Handle := PaintInfo.Handle;
        SectionPaintInfo.Rect :=
           Rect(ASections[i].iLeft,ASections[i].iTop,ASections[i].iLeft+ASections[i].iWidth,ASections[i].iTop+ASections[i].iHeight);

        with SectionPaintInfo.Rect do
          ClipRgn := CreateRectRgn(Left,Top,Right,Bottom);
        if OldRgn<>0 then
          CombineRgn(ClipRgn,ClipRgn,OldRgn,RGN_AND);
        SelectClipRgn(PaintInfo.Canvas.Handle,ClipRgn);
        DeleteObject(ClipRgn);
        try
          ASections[i].Paint(SectionPaintInfo);
        finally
          SelectClipRgn(PaintInfo.Canvas.Handle,OldRgn);
        end;
      end;
  finally
    if OldRgn <> 0 then
      DeleteObject(OldRgn);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.DoMouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(OnMouseDown) then
    OnMouseDown(Self, Button, Shift, X, Y);
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerBar.DoMouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(OnMouseUp) then
    OnMouseUp(Self, Button, Shift, X, Y);
end;

{$IFDEF LMD_DEBUGTRACE}

initialization
  {$I C1.INC}
{$ENDIF}

end.
