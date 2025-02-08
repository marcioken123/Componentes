unit LMDSectionBar;
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

LMDSectionBar unit (DD, RM, AH)
-------------------------------
Implements TLMDSectionBar and all helper classes.

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Messages, Windows, Controls, SysUtils, Classes, Graphics, ExtCtrls,
  StdCtrls, ImgList, Buttons, ActnList, Forms, Menus,
  LMDClass, LMDObject, LMDBarConsts, LMDBarBase, LMDControl, LMDTypes;

const
  defLMD_SECTIONSPACE =1;
  defLMD_ITEMSGAP  = 4;
  defLMD_IMAGEGAP  = 2;
  defLMD_CAPTIONGAP= 2;
  defLMD_SCROLLSIZE = 3;
  defLMD_DRAGSPACE  = 4;
  defLMD_CXDRAG     = 5;
  defLMD_CYDRAG     = 5;

type
  TLMDSectionBarItem=class;
  TLMDBarSectionCaptionEdit=class;
  TLMDBarClearButton=class;
  TLMDSectionBarSection=class;
  TLMDSectionBarSections=class;

  TLMDSectionBarItemEventType=(istGeneral, istItemSelect, istItemUnSelect, istItemClick, istClick);
  TLMDSectionBarItemSelectEvent=procedure(Sender:TObject; Reason:TLMDSectionBarItemEventType; Item:TObject) of object;

  TLMDSectionBarSelectionStyle=(lssFull, lssIcon, lssCaption);

  { ********************** TLMDSectionScrollButton *************************** }
  TLMDSectionScrollButton=class
  public
     Visible : Boolean;
     OnClick : TNotifyEvent;
  end;

  { ********************** TLMDSectionBarActionLink ************************** }
  TLMDSectionBarActionLink = class(TActionLink)
  protected
    FClient: TLMDSectionBarItem;
    procedure AssignClient(AClient: TObject); override;
    function IsCaptionLinked: Boolean; override;
    function IsEnabledLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;
    //function IsVisibleLinked: Boolean; override;
    function IsOnExecuteLinked: Boolean; override;
    procedure SetCaption(const Value: string); override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetHint(const Value: string); override;
    procedure SetImageIndex(Value: Integer); override;
    //procedure SetVisible(Value: Boolean); override;
    procedure SetOnExecute(Value: TNotifyEvent); override;
  end;

  TLMDSectionBarActionLinkClass = class of TLMDSectionBarActionLink;

  { ********************** TLMDSectionBarItem ******************************** }
  TLMDSectionBarUpdateKind=(lukAll,lukState,lukParams);
  TLMDSectionBarViewStyle=(lvsLargeImages,lvsSmallImages);

  TLMDSectionBarItems=class;
  TLMDSectionBarView=class;

  TLMDSectionBarItem=class(TCollectionItem)
  private
    FActionLink :TLMDSectionBarActionLink;
    FCaption: String;
    FImageIndex: Integer;
    FTag: Integer;
    FData: Pointer;
    FTop: Integer;
    FIsDown: Boolean;
    FEnabled: Boolean;
    FCustomData:String;
    FHint: String;
    FCaptionLong:Boolean;
    FOnClick,
    FOnChange,
    FOnMouseEnter,
    FOnMouseExit:TNotifyEvent;

    procedure DoActionChange(Sender:TObject);
    function GetAction: TBasicAction;
    function IsCaptionStored: Boolean;
    function IsEnabledStored: Boolean;
    function IsHintStored: Boolean;
    function IsImageIndexStored: Boolean;
    function IsOnClickStored: Boolean;
    //function IsVisibleStored: Boolean;
    procedure SetAction(const Value: TBasicAction);
    procedure SetCaption(const Value: String);
    procedure SetImageIndex(const Value: Integer);
    function  GetParent: TLMDSectionBarItems;
    procedure SetIsDown(const Value: Boolean);
    procedure SetEnabled(const Value: Boolean);

    procedure   UpdateParentList(Kind:TLMDSectionBarUpdateKind);
  protected
    procedure   ActionChange(Sender: TObject; CheckDefaults: Boolean); dynamic;
    function    GetDisplayName: string; override;
    function    GetActionLinkClass: TLMDSectionBarActionLinkClass; dynamic;
    procedure   Notification(AComponent: TComponent; Operation: TOperation);
  public
    constructor Create(Collection: TCollection);override;
    destructor  Destroy;override;
    procedure   Assign(Source: TPersistent);override;
    procedure   Click; dynamic;
    procedure   MakeVisible;
    procedure   InitiateAction;dynamic;

    property    IsLongCaption:Boolean read FCaptionLong;
    property    Parent:TLMDSectionBarItems read GetParent;
    property    Top:Integer read FTop;
    property    Data:Pointer read FData write FData;
    property    ActionLink: TLMDSectionBarActionLink read FActionLink write FActionLink;
  published
    property Action: TBasicAction read GetAction write SetAction;

    property Caption:String read FCaption write SetCaption stored IsCaptionStored;
    property CustomData:String read FCustomData write FCustomData;
    property Down:Boolean read FIsDown write SetIsDown default false;
    property Enabled:Boolean read FEnabled write SetEnabled stored IsEnabledStored;
    property Hint:String read FHint write FHint stored IsHintStored;
    property ImageIndex:Integer read FImageIndex write SetImageIndex stored IsImageIndexStored;
    property Index;
    property Tag:Integer read FTag write FTag default 0;
    //property Visible:Boolean read FVisible write SetVisible stored IsVisibleStored;

    // events
    property OnClick:TNotifyEvent read FOnClick write FOnClick stored IsOnClickStored;
    property OnMouseEnter:TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseExit:TNotifyEvent read FOnMouseExit write FOnMouseExit;
    property OnItemUp:TNotifyEvent read FOnChange write FOnChange;
    //property OnGetItem:TNotifyEvent read FOnGetItem write FOnGetItem;
  end;

  { ********************** TLMDSectionBarItems ********************************** }
  TLMDSectionBarItems=class(TOwnedCollection)
  private
    FList : TLMDSectionBarView;
    function    GetItems(Index: Integer): TLMDSectionBarItem;
  protected
    procedure   Update(Item:TCollectionItem);override;
  public
    constructor Create(aOwner:TPersistent; aList:TLMDSectionBarView);
    function    Add:TLMDSectionBarItem;
    procedure   UpdateParentList(Item:TLMDSectionBarItem;Kind:TLMDSectionBarUpdateKind);
    procedure   InitiateActions;
    property    Items[Index:Integer]:TLMDSectionBarItem read GetItems;default;

  end;

  TLMDWinControl=class(TWinControl)
  protected
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
                       var Accept: Boolean); override;
  end;

  TLMDOnDragOver = procedure(Source:TObject;X,Y:Integer; State:TDragState;var Accept:Boolean; var Complete : Boolean) of object;
  TLMDDrawListViewItem=procedure (Sender:TObject;Canvas:TCanvas;Rect:TRect;Item:TLMDSectionBarItem;var Done:Boolean) of object;
  TLMDDrawListViewBackground=procedure (Sender:TObject;Canvas:TCanvas;Rect:TRect;var Done:Boolean) of object;

  { ********************** TLMDSectionBarView ******************************** }
  TLMDSectionBarView=class(TCustomControl)
  private
    FScrolling : Boolean;
    FTimer : TTimer;
    FX, FY    : Integer;
    FDragPlace: Integer;
    FDownItem : TLMDSectionBarItem;
    FDragTargetControl : TWinControl;
    FDownPoint: TPoint;
    IsDown    : Boolean;
    IsDraging : Boolean;
    FRectPos  : Integer;
    FListRect : TRect;
    FItems: TLMDSectionBarItems;
    FLargeChangeLink: TChangeLink;
    FSmallChangeLink: TChangeLink;
    FSmallImages: TCustomImageList;
    FReadOnly:Boolean;
    FLargeImages: TCustomImageList;
    FViewStyle: TLMDSectionBarViewStyle;
    FSelected: TLMDSectionBarItem;

    //FMultiselect: Boolean;
    FAllowDown: Boolean;
    FAllowAllUp: Boolean;

    FOnDragOver: TLMDOnDragOver;
    FParentInterface:TLMDBarParentControlInterface;
    FOnDrawBackground: TLMDDrawListViewBackground;
    FOnDrawItem: TLMDDrawListViewItem;

    FOnItemSelect:TLMDSectionBarItemSelectEvent;

    function  CheckDesignTime: Boolean;
    function  CheckMousePos(X,Y:Integer; FullRepaint:Boolean=False):Boolean;
    procedure CheckScrollVisible;
    // getters
    function  GetCaptionRect(Item: TLMDSectionBarItem): TRect;
    //function  GetCtlXP: Boolean;
    function  GetRawItemRect(Item: TLMDSectionBarItem): TRect;
    function  GetImageRect(Item: TLMDSectionBarItem): TRect;
    function  GetItemAtPos(X, Y: Integer): TLMDSectionBarItem;
    function  GetItemAtPosInternal(X, Y: Integer; bRaw:Boolean=False): TLMDSectionBarItem;
    function  GetParentInterface:TLMDBarParentControlInterface;
    function  GetPressed: TLMDSectionBarItem;
    function  ValidBarParent:TWinControl;

    procedure ImageListChange(Sender: TObject);
    procedure OnDownScrollButton(Sender:TObject);
    procedure OnUpScrollButton(Sender:TObject);
    procedure OnTimer (Sender : TObject);
    procedure ProcessPaintMessages;

    procedure Scroll(iScroll:Integer; bAnimate:Boolean=True);
    // setters
    procedure SetAllowAllUp(const Value: Boolean);

    procedure SetAllowDown(const Value: Boolean);
    procedure SetItems(const Value: TLMDSectionBarItems);

    procedure SetLargeImages(const Value: TCustomImageList);
    //procedure SetMultiselect(const Value: Boolean);
    procedure SetSmallImages(const Value: TCustomImageList);
    procedure SetViewStyle(const Value: TLMDSectionBarViewStyle);

    procedure UpdateItems(Item:TLMDSectionBarItem;Kind:TLMDSectionBarUpdateKind);
    // Messages
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMFontChanged (var Msg : TMessage); message CM_FONTCHANGED;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure SetPressed(const Value: TLMDSectionBarItem);
  protected
    //procedure AdjustClientRect(var Rect: TRect);override;
    function  CanDropItem(X, Y:Integer):Boolean;virtual;
    procedure CheckDownItem(Item:TLMDSectionBarItem);
//    procedure Changed;dynamic;
    procedure Click;override;
    procedure DoItemClick;virtual;
    procedure DoEndDrag(Target:TObject; X, Y:Integer);override;
    procedure DoSelect;virtual;
    procedure DoSelectItem(Item:TLMDSectionBarItem);
    procedure DoUnSelectItem(Item:TLMDSectionBarItem);
    procedure DoUnPressItem(Item: TLMDSectionBarItem);
    function  DragNotifyControl(Control:TWinControl;X,Y:Integer):Boolean;
    procedure DragMove(X, Y:Integer);
    procedure DragOver(Source:TObject;X,Y:Integer;State:TDragState;var Accept:Boolean);override;
    procedure DrawBackground;virtual;

    procedure DrawItem(Item:TLMDSectionBarItem);virtual;
    procedure DrawSelectedFrame(Item:TLMDSectionBarItem;Color1,Color2:TColor);
    function  GetDropPosition(X, Y:Integer;var iPos:Integer; var Rect:TRect):Boolean;
    function  GetImageList:TCustomImageList;virtual;
    function  GetItemRect(Item:TLMDSectionBarItem):TRect;virtual;
    function  GetItemsHeight:Integer;virtual;
    function  GetScrollChange(bUp:Boolean):Integer;
    function  GrowItemRect(Item:TLMDSectionBarItem):TRect;

    procedure InvalidateDragPlace;
    procedure MinimumUpdate;virtual;
    procedure Paint;override;
    procedure Resize;override;
    function  SetClip:HRGN;virtual;
    procedure SelectItemImmediatly(Item:TLMDSectionBarItem;IsDown:Boolean);
    procedure SendMessageToParent(Msg: Cardinal; WParam, LParam: Longint);

    property  AllowAllUp:Boolean read FAllowAllUp write SetAllowAllUp;
    //property  Multiselect:Boolean read FMultiselect write SetMultiselect;
  public
    FScrollUpBtn,
    FScrollDownBtn : TLMDSectionScrollButton;
    constructor Create(AOwner: TPersistent); reintroduce;
    destructor  Destroy;override;
    procedure   SetParentInterface(Intf: TLMDBarParentControlInterface);
    function    CheckUpdate:Boolean;

    function  IsItemVisible(Item:TLMDSectionBarItem):Boolean;
    procedure DrawItems;virtual;
    procedure RealignItems;virtual;
    procedure ScrollInView(Item:TLMDSectionBarItem);

    property  AllowDown:Boolean read FAllowDown write SetAllowDown;
    property  ImageList:TCustomImageList read GetImageList;
    property  ImageRect[Item:TLMDSectionBarItem]:TRect read GetImageRect;
    property  ItemAtPos[X,Y:Integer]:TLMDSectionBarItem read GetItemAtPos;
    property  ItemHeight:Integer read GetItemsHeight;
    property  ItemRect[Item:TLMDSectionBarItem]:TRect read GetItemRect;
    property  Items:TLMDSectionBarItems read FItems write SetItems;
    property  Font;
    property  CaptionRect[Item:TLMDSectionBarItem]:TRect read GetCaptionRect;
    property  RawItemRect[Item:TLMDSectionBarItem]:TRect read GetRawItemRect;

    property  OnItemSelect:TLMDSectionBarItemSelectEvent read FOnItemSelect write FOnItemSelect;
    property  OnDragOver : TLMDOnDragOver read FOnDragOver write FOnDragOver;
    property  OnDragDrop;

    property  OnDrawBackground:TLMDDrawListViewBackground read FOnDrawBackground write FOnDrawBackground;
    property  OnDrawItem:TLMDDrawListViewItem read FOnDrawItem write FOnDrawItem;

    property  Pressed:TLMDSectionBarItem read GetPressed write SetPressed;
    property  Selected:TLMDSectionBarItem read FSelected;
    property  SmallImages: TCustomImageList read FSmallImages write SetSmallImages;
    property  ViewStyle:TLMDSectionBarViewStyle read FViewStyle write SetViewStyle;
    property  LargeImages: TCustomImageList read FLargeImages write SetLargeImages;
    property  ReadOnly:Boolean read FReadOnly write FReadOnly;

  end;

  //  TLMDSectionBarItem
  TLMDSectionBarChangeEvent=procedure(Sender:TObject; Index: Integer) of object;
  TLMDSectionBarEditChangingEvent=procedure(Sender:TObject; Index: Integer; const NewCaption:TCaption;var Cancel:Boolean) of object;

  TLMDSectionBarAllowChangeEvent=procedure(Sender: TObject; Index: Integer; var Cancel: Boolean) of object;
  TLMDSectionBarItemEvent=procedure(Sender:TObject;Section:TLMDSectionBarSection;Item:TLMDSectionBarItem) of object;

  TLMDSectionBarDrawSection=procedure (Sender:TObject;Canvas:TCanvas;Rect:TRect; Index:Integer;var Done:Boolean) of object;
  TLMDSectionBarDrawItem=procedure (Sender:TObject;Canvas:TCanvas;Rect:TRect;SectionIndex, ItemIndex:Integer;var Done:Boolean) of object;

  { ********************** TLMDSectionBarTheme ******************************* }
  TLMDSectionBarTheme=class(TLMDObject)
  private
    FButtonBackground: TColor;
    FButtonHighlightTextColor: TColor;
    FButtonTextColor: TColor;
    FDisableTextColor: TColor;
    FHighlightTextColor: TColor;
    FItemDownBackGround: TColor;
    FItemBorderBlack: TColor;
    FItemBorderLight: TColor;
    FItemDragBackground: TColor;
    FItemDragBorder: TColor;
    FItemSelectedBackground: TColor;
    FListViewBackground: TColor;
    FSectionSpaceColor: TColor;
    FTextColor: TColor;
    FScrollBmp: TBitmap;
    FSelectionStyle:TLMDSectionBarSelectionStyle;

    FImageSpace: Integer;
    FCaptionSpace: Integer;
    FItemsSpace: Integer;
    FScrollStep: Integer;
    FDragSpace: Integer;
    FSectionSpace:Integer;
    FSectionHeight: Integer;
    function GetColor(const Index:Integer):TColor;
    function GetBitmap:TBitmap;
    function GetInteger(Index:Integer): Integer;
    procedure SetColor(const Index:Integer; const Value: TColor);
    procedure SetInteger(Index:Integer; const Value: Integer);
    procedure SetScrollBmp(const Value: TBitmap);
    procedure SetSelectionStyle(const Value: TLMDSectionBarSelectionStyle);
    procedure SetSectionSpace(const Value: Integer);
    procedure SetSectionMinHeight(const Value: Integer);

  public
    constructor Create(Owner:TPersistent);override;
    destructor  Destroy;override;
    procedure   Assign(Src: TPersistent); override;
    property    ScrollBmp:TBitmap read GetBitmap;
  published
    property ButtonBackground:TColor index 0 read GetColor write SetColor default LSB_BUTTON_BACK;
    property ButtonHighlightTextColor:TColor index 1 read GetColor write SetColor default clBlue;
    property ButtonTextColor:TColor index 2 read GetColor write SetColor default clBlack;
    property DisableTextColor:TColor index 3 read GetColor write SetColor default LSB_DISABLETEXT;
    property HighlightTextColor:TColor index 4  read GetColor write SetColor default LSB_HIGHLIGHTEXT;
    property ItemDownBackGround:TColor index 5 read GetColor write SetColor default LSB_ITEMDOWNBACKGROUND;
    property ItemBorderBlack:TColor index 6 read GetColor write SetColor default LSB_IBORDERBLACK;
    property ItemBorderLight:TColor index 7 read GetColor write SetColor default LSB_IBORDERLIGHT;
    property ItemDragBackground:TColor index 8 read GetColor write SetColor default LSB_ITEMDRAGBACKGROUND;
    property ItemDragBorder:TColor index 9 read GetColor write SetColor default LSB_ITEMDRAGBORDER;
    property ItemSelectedBackground:TColor index 10 read GetColor write SetColor default LSB_ITEMSELECTEDBACKGROUND;
    property ViewBackground:TColor index 11 read GetColor write SetColor default LSB_LISTVIEW_BACK;
    property ButtonSpaceColor:TColor index 12  read GetColor write SetColor default clSilver;
    property TextColor:TColor index 13 read GetColor write SetColor default LSB_TEXTCOLOR;
    property CustomScrollBmp:TBitmap read FScrollBmp write SetScrollBmp;

    property CaptionSpace:Integer index 0 read GetInteger write SetInteger default defLMD_CAPTIONGAP;
    property DragSpace:Integer index 1 read GetInteger write SetInteger default defLMD_DRAGSPACE;
    property ImageSpace:Integer index 2 read GetInteger write SetInteger default defLMD_IMAGEGAP;
    property ItemsSpace:Integer index 3 read GetInteger write SetInteger default  defLMD_ITEMSGAP;
    property ScrollStep:Integer index 4 read GetInteger write SetInteger default defLMD_SCROLLSIZE;
    property ButtonSpace:Integer read FSectionSpace write SetSectionSpace default 1;
    property ButtonMinHeight:Integer read FSectionHeight write SetSectionMinHeight default 0;
    property SelectionStyle:TLMDSectionBarSelectionStyle read FSelectionStyle write SetSelectionStyle default lssFull;

   end;

  { ********************** TLMDSectionBarThemeItem *************************** }
  TLMDSectionBarThemeItem=class(TCollectionItem)
  private
    FTheme: TLMDSectionBarTheme;
    FName: String;
    procedure SetName(const Value: String);
    procedure SetTheme(const Value: TLMDSectionBarTheme);
    procedure GetChange(Sender:TObject);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection);override;
    destructor  Destroy;override;
  published
    property  Name:String read FName write SetName;
    property  Theme:TLMDSectionBarTheme read FTheme write SetTheme;
    property Index;
  end;

  TLMDSectionBarController=class;

  { ********************** TLMDSectionBarThemeItems *************************** }
  TLMDSectionBarThemeItems=class(TOwnedCollection)
  private
    function GetController:TLMDSectionBarController;
    function GetItems(Index: Integer): TLMDSectionBarThemeItem;
    function GetItemByName(Value: String): TLMDSectionBarThemeItem;
  protected
    function GetThemeItemName:String;
    function ValidateName(const NewName:String; const oldName:String=''):String;
    property Controller:TLMDSectionBarController read GetController;
  public
    constructor Create(Owner:TComponent);
    function    Add:TLMDSectionBarThemeItem;
    property    Items[Index:Integer]:TLMDSectionBarThemeItem read GetItems;default;
    property    ItemByName[Value:String]:TLMDSectionBarThemeItem read GetItemByName;
  end;

  { ********************** TLMDSectionBarController ************************** }
  TLMDSectionBarController=class(TLMDBarController)
  private
    FThemes: TLMDSectionBarThemeItems;
    FIndex:  Integer;
    procedure SetThemes(const Value: TLMDSectionBarThemeItems);
    procedure SetIndex(const Value: Integer);
    function GetTheme: TLMDSectionBarTheme;

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;override;
    procedure   UpdateParent(UpdateIndex:Integer=0);
    property    ActiveTheme:TLMDSectionBarTheme read GetTheme;
  published
    property About;
    property ActiveThemeIndex:Integer read FIndex write SetIndex default 0;
    property Themes:TLMDSectionBarThemeItems read FThemes write SetThemes;
  end;

  { ****************** TLMDSectionBarSectionPanel **************************** }
  TLMDSectionBarSectionPanel=class(TCustomPanel)
  private
    FSection :  TLMDSectionBarSection;
    FIndex :  Integer;
    FAutoCreated : Boolean;
    function GetIndex: Integer;
  protected
    procedure DefineProperties(Filer: TFiler);override;
    procedure CreateParams(var Params: TCreateParams);override;
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;override;
    property    Index:Integer read GetIndex;
    property    Section:TLMDSectionBarSection read FSection;
    end;

  { ******************** TLMDSectionBarSection *************************** }
  TLMDSectionBarSection=class(TCollectionItem)
  private
    FCaption: String;
    FPanel: TLMDSectionBarSectionPanel;
    FHint: String;
    FTag: Integer;
    FView : TLMDSectionBarView;
    FName: String;
    function  GetSections: TLMDSectionBarSections;
    function  GetListView: TLMDSectionBarView;
    function GetItems: TLMDSectionBarItems;
    function GetImageList(Index:Integer): TCustomImageList;
    function GetDownState: Boolean;
    function GetIndex(Index:Integer): Integer;
    function GetItem(Index:Integer): TLMDSectionBarItem;
    function GetReadOnly: Boolean;
    function GetFont: TFont;
    function GetCaptionRect(Item: TLMDSectionBarItem): TRect;
    function GetImageRect(Item: TLMDSectionBarItem): TRect;
    function GetItemAtPos(X, Y: Integer): TLMDSectionBarItem;
    function GetItemRect(Item: TLMDSectionBarItem): TRect;
    function GetItemsHeight: Integer;
    function GetViewStyle: TLMDSectionBarViewStyle;
    function IsCustomCaption:Boolean;
    procedure SetCaption(const Value: String);
    procedure SetDownState(const Value: Boolean);
    procedure SetItemIndex(const Index, Value:Integer);
    procedure SetHint(const Value: String);
    procedure SetImageList(Index:Integer; const Value: TCustomImageList);
    procedure SetItems(const Value: TLMDSectionBarItems);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetViewStyle(const Value: TLMDSectionBarViewStyle);
    procedure SetFont(const Value: TFont);
    procedure SetName(const Value: String);
    procedure SetItem(const Index: Integer; const Value: TLMDSectionBarItem);
  protected
    procedure CreateListView;
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection);override;
    destructor  Destroy;override;
    procedure   Assign(Source: TPersistent);override;

    // call directly when events should be generated
    procedure   SetCaptionEx(const Value: String; bEvents:Boolean=True);

    // ToDo - Methods to enable/disable internal controls in SectionBar
    procedure   Activate(SectionBar:TLMDBaseCustomControl);virtual;
    procedure   Deactivate(SectionBar:TLMDBaseCustomControl);virtual;

    function    IsItemVisible(Item:TLMDSectionBarItem):Boolean;
    procedure   ScrollInView(Item:TLMDSectionBarItem);

    // Methods which are called by Parent components only
    procedure   Initialize;
    procedure   Notification(AComponent: TComponent; Operation: TOperation);

    // Owner of this class
    property    Sections:TLMDSectionBarSections read GetSections;

    //  direct access to internal controls
    property    Panel:TLMDSectionBarSectionPanel read FPanel;
    property    View:TLMDSectionBarView read GetListView;

    property    SelectedItemIndex:Integer index 0 read GetIndex;
    property    SelectedItem:TLMDSectionBarItem index 0 read GetItem;
    property    DownItem:TLMDSectionBarItem index 1 read GetItem write SetItem;

    // information properties
    property    ImageRect[Item:TLMDSectionBarItem]:TRect read GetImageRect;
    property    ItemAtPos[X,Y:Integer]:TLMDSectionBarItem read GetItemAtPos;
    property    ItemHeight:Integer read GetItemsHeight;
    property    ItemRect[Item:TLMDSectionBarItem]:TRect read GetItemRect;
    property    CaptionRect[Item:TLMDSectionBarItem]:TRect read GetCaptionRect;
  published
    property    Caption:String read FCaption write SetCaption stored IsCustomCaption;
    property    DownItemIndex:Integer index 1 read GetIndex write SetItemIndex default -1;
    property    Hint:String read FHint write SetHint;
    property    Font:TFont read GetFont write SetFont;
    property    Tag:Integer read FTag write FTag default 0;
    property    Items:TLMDSectionBarItems read GetItems write SetItems;
    property    Index;
    property    Name:String read FName write SetName;
    property    SmallImages:TCustomImageList index 0 read GetImageList write SetImageList;
    property    LargeImages:TCustomImageList index 1 read GetImageList write SetImageList;
    property    ReadOnly:Boolean read GetReadOnly write SetReadOnly default false;
    property    ViewStyle:TLMDSectionBarViewStyle read GetViewStyle write SetViewStyle default lvsSmallImages;

    // -> Theme??
    property    AllowDown:Boolean read GetDownState write SetDownState default true;
  end;

  { ********************** TLMDSectionBarSections **************************** }
  TLMDSectionBarSections=class(TOwnedCollection)
  private
    FSectionBar:TLMDBaseCustomControl;
    FUpdating:Boolean;
    function GetSection(Index: Integer): TLMDSectionBarSection;
    function GetSectionByName(Value: String): TLMDSectionBarSection;
    function GetSectionName: String;
    // event handlers
    procedure DoItemEvent(Sender:TObject; Reason:TLMDSectionBarItemEventType; Item:TObject);
    procedure OnDragOver(Source:TObject;X,Y:Integer; State:TDragState;var Accept:Boolean; var Complete : Boolean);
    procedure OnLVDrawItem(Sender:TObject;Canvas:TCanvas;Rect:TRect;Item:TLMDSectionBarItem;var Done:Boolean);
    procedure OnLVDrawBackground(Sender:TObject;Canvas:TCanvas;Rect:TRect;var Done:Boolean);
    procedure OnDragDrop(Sender, Target: TObject; X, Y: Integer);
  protected
    procedure   Update(Item: TCollectionItem); override;
    procedure   Initialize;
  public
    constructor Create(Owner:TPersistent);
    destructor  Destroy;override;
    procedure   Assign(Source: TPersistent);override;
    function    Add:TLMDSectionBarSection;
    procedure   BeginUpdate; override;
    function    CheckCaption(szName:String):Boolean;
    procedure   EndUpdate; override;
    function    ValidateName(NewName:String):String;

    // ToDo
    procedure   Activate(SectionBar:TLMDBaseCustomControl);virtual;
    procedure   Deactivate;virtual;

    property    Section[Index:Integer]:TLMDSectionBarSection read GetSection;default;
    property    SectionByName[Value:String]:TLMDSectionBarSection read GetSectionByName;
  end;

  { ********************** TLMDSectionBarSectionsStorage ********************* }
  TLMDSectionBarStorage=class(TLMDBarController)
  private
    FSections: TLMDSectionBarSections;
    procedure SetSections(const Value: TLMDSectionBarSections);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;override;
  published
    property  Sections:TLMDSectionBarSections read FSections write SetSections;
  end;

  { ********************** TLMDCustomSectionBar ****************************** }
  TLMDCustomSectionBar=class(TLMDBaseCustomControl,TLMDBarParentControlInterface)
  private
    FInternalFontHeight:Integer;
    FSectionDrag:Boolean;
    FActiveSectionIndex: Integer;
    FCaptionAlignment: TAlignment;
    FDragSection : Integer;
    FDragTimer : TTimer;
    FHotTrack: Boolean;

    // Edit events
    FOnItemDelete,
    FOnSectionDelete,
    FOnSectionChange,
    FOnEditHide:TNotifyEvent;
    FOnItemDraw: TLMDSectionBarDrawItem;
    FOnBeforeItemDelete,
    FOnBeforeSectionDelete,
    FOnSectionBeforeChange,
    FOnItemEditShow,
    FOnSectionEditShow:TLMDSectionBarAllowChangeEvent;
    FOnSectionCaptionChanging,
    FOnItemCaptionChanging: TLMDSectionBarEditChangingEvent;
    FOnItemAdd,
    FOnSectionAdd,
    FOnItemCaptionChange,
    FOnSectionCaptionChange:TLMDSectionBarChangeEvent;
    FOnSectionDrawButton: TLMDSectionBarDrawSection;
    FOnSectionDrawBackground: TLMDSectionBarDrawSection;

    FOnItemClick,
    FOnSelect,
    FOnItemSelect,
    FOnItemUnSelect: TLMDSectionBarItemEvent;
    FScrollFrequency: Integer;

    FSections: TLMDSectionBarSections;
    FSectionStorage: TLMDSectionBarStorage;
    FSingleSection: Boolean;
    FTheme: TLMDSectionbarTheme;
    FThemeController: TLMDSectionBarController;

    // returns true when no Storage control is connected
    function IsNoStorage:Boolean;
    function IsNoCustomTheme:Boolean;

    // property getters
    // ----------------
    function  GetActiveSection: TLMDSectionBarSection;
    function  GetActiveSections:TLMDSectionBarSections;
    function  GetActiveSectionIndex:Integer;
    function  GetTheme:TLMDObject;

    // helper routines
    // ---------------
    // used in Section[..] / Item [..] methods to get real SectionIndex
    function    GetInternalSectionIndex(const Value:Integer):Integer;

    // property setters
    // ----------------
    procedure SetActiveSectionIndex(const Value: Integer);
    procedure SetCaptionAlignment(const Value: TAlignment);
    //procedure SetCtlXP(const Value: Boolean);
    procedure SetHotTrack(const Value: Boolean);
    procedure SetScrollFrequency(const Value: Integer);
    //procedure SetSectionIndex(const Value: Integer);
    procedure SetSections(const Value: TLMDSectionBarSections);
    procedure SetSectionStorage(const Value: TLMDSectionBarStorage);
    procedure SetSingleSection(const Value: Boolean);
    procedure SetTheme(const Value: TLMDSectionbarTheme);
    procedure SetThemeController(const Value: TLMDSectionBarController);

    procedure CMUpdateLinkMessage(var Message:TMessage);message CM_UPDATELINKCONTROLMSG;
    procedure CMFontChanged (var Msg : TMessage); message CM_FONTCHANGED;
    procedure CMColorChanged(var Message:TMessage);message CM_COLORCHANGED;

    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSize(var Message:TWMSize);message WM_SIZE;
    procedure WMTimer(var Msg:TWMTimer);message WM_TIMER;
    procedure WMUpdateScroll(var Msg:TMessage);message WM_UPDATESCROLL;
  protected
    FButtonDown     : Boolean;
    FCaptionEdit    : TLMDBarSectionCaptionEdit;
    FDownSectionIndex : Integer;
    FHotSectionIndex  : Integer;
    FUpScroll,FDownScroll : TLMDBarClearButton;
    FTimerEnable    : Boolean;

    // New  RM
    function    CheckSectionIndex(SectionIndex:Integer; Activate:Boolean=true; effect:Boolean=false):Boolean;
    procedure   ChangeSections(OldS,NewS:TLMDSectionBarSections);
    // -------

    procedure   ArrangeSections;
    procedure   Click;override;
    procedure   DragOver(Source:TObject;X,Y:Integer; State:TDragState;var Accept:Boolean);override;
    function    FindSectionByView(aView:TLMDSectionBarView):TLMDSectionBarSection;
    function    GetSectionButtonRect(Index:Integer):TRect;
    function    GetSectionButtonHeight:Integer;
    function    GetSectionRect(bCorrectLast:Boolean=true):TRect;
    function    GetSectionAt(X,Y:Integer):Integer;
    function    GetUseXP:boolean;
    procedure   GetThemeChange(Sender:TObject);

    procedure   Loaded;override;
    procedure   MouseMove(Shift : TShiftState ; X, Y : Integer);override;
    Procedure   MouseDown(Button : TMouseButton ; Shift : TShiftState ; X, Y : Integer);override;
    Procedure   MouseUp(Button : TMouseButton ; Shift : TShiftState ; X, Y: Integer);override;
    procedure   Notification(AComponent: TComponent; Operation: TOperation);override;
    procedure   OnDragTimer (Sender : TObject);
    procedure   OnScrollClick (Sender : TObject);

    procedure   PaintSectionButton(Index:Integer);virtual;
    procedure   PaintBackground;virtual;
    procedure   Paint;override;

    procedure   UpdateSectionStorage;
    procedure   UpdateSectionSize;

    // possible Sections container
    property    Sections:TLMDSectionBarSections read FSections write SetSections stored IsNoStorage;
    property    SectionStorage:TLMDSectionBarStorage read FSectionStorage write SetSectionStorage;

    // current Active Section(s)
    property    ActiveSection:TLMDSectionBarSection read GetActiveSection;
    property    ActiveSections:TLMDSectionBarSections read GetActiveSections;
    property    ActiveSectionIndex:Integer read GetActiveSectionIndex write SetActiveSectionIndex default 0;

    //---
    property    CaptionAlignment:TAlignment read FCaptionAlignment write SetCaptionAlignment default taLeftJustify;
    property    HotTrack:Boolean read FHotTrack write SetHotTrack default true;
    property    ScrollFrequency:Integer read FScrollFrequency write SetScrollFrequency default 20;

    // Enables/Disables single section view. The ActiveSectionIndex section is shown
    property    SingleSection:Boolean read FSingleSection write SetSingleSection default false;
    // Allows drag&drop between Sections. Limitation: No automatic scrolling
    property    SectionDrag:Boolean read FSectionDrag write FSectionDrag default false;
    property    Theme:TLMDSectionbarTheme read FTheme write SetTheme stored IsNoCustomTheme;
    property    ThemeController:TLMDSectionBarController read FThemeController write SetThemeController;

    property    OnItemClick:TLMDSectionBarItemEvent read FOnItemClick write FOnItemClick;
    property    OnItemSelectionChange:TLMDSectionBarItemEvent read FOnSelect write FOnSelect;
    property    OnItemSelect:TLMDSectionBarItemEvent read FOnItemSelect write FOnItemSelect;
    property    OnItemUnSelect:TLMDSectionBarItemEvent read FOnItemUnSelect write FOnItemUnSelect;
    property    OnItemCaptionChange:TLMDSectionBarChangeEvent read FOnItemCaptionChange write FOnItemCaptionChange;
    property    OnItemCaptionChanging:TLMDSectionBarEditChangingEvent read FOnItemCaptionChanging write FOnItemCaptionChanging;

    property    OnItemDraw:TLMDSectionBarDrawItem read FOnItemDraw write FOnItemDraw;
    property    OnSectionDrawBackground:TLMDSectionBarDrawSection read FOnSectionDrawBackground write FOnSectionDrawBackground;
    property    OnSectionDrawButton:TLMDSectionBarDrawSection read FOnSectionDrawButton write FOnSectionDrawButton;

    property    OnEditHide:TNotifyEvent read FOnEditHide write FOnEditHide;
    property    OnSectionEditShow:TLMDSectionBarAllowChangeEvent read FOnSectionEditShow write FOnSectionEditShow;
    property    OnItemEditShow:TLMDSectionBarAllowChangeEvent read FOnItemEditShow write FOnItemEditShow;

    property    OnSectionCaptionChanging:TLMDSectionBarEditChangingEvent read FOnSectionCaptionChanging write FOnSectionCaptionChanging;
    property    OnSectionCaptionChange:TLMDSectionBarChangeEvent read FOnSectionCaptionChange write FOnSectionCaptionChange;
    property    OnSectionChange:TNotifyEvent read FOnSectionChange write FOnSectionChange;
    property    OnSectionBeforeChange:TLMDSectionBarAllowChangeEvent read FOnSectionBeforeChange write FOnSectionBeforeChange;

    property    OnSectionAdd:TLMDSectionBarChangeEvent read FOnSectionAdd write FOnSectionAdd;
    property    OnBeforeSectionDelete:TLMDSectionBarAllowChangeEvent read FOnBeforeSectionDelete write FOnBeforeSectionDelete;
    property    OnSectionDelete:TNotifyEvent read FOnSectionDelete write FOnSectionDelete;

    property    OnItemAdd:TLMDSectionBarChangeEvent read FOnItemAdd write FOnItemAdd;
    property    OnBeforeItemDelete:TLMDSectionBarAllowChangeEvent read FOnBeforeItemDelete write FOnBeforeItemDelete;
    property    OnItemDelete:TNotifyEvent read FOnItemDelete write FOnItemDelete;

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;override;

    // Item methods
    // Add item to section SectionIndex
    // ShowEditor: Only possible when current SectionIndex is the active one
    function ItemAdd(IsDown:Boolean=True; ShowEditor:Boolean=False; SectionIndex:Integer=-1; Activate:Boolean=true; effect:Boolean=false):Integer;
    // Insert item to section SectionIndex at position Index
    function ItemInsert(aIndex:Integer; IsDown:Boolean=True; SectionIndex:Integer=-1; Activate:Boolean=true; effect:Boolean=false):Boolean;
    // Delete Item aIndex in section SectionIndex
    function ItemDelete(aIndex:Integer=-1; IsDown:Boolean=True; SectionIndex:Integer=-1; Activate:Boolean=true; effect:Boolean=false):Boolean;
    // Edit Item aIndex in active section
    procedure ItemEdit(aIndex:Integer=-1);
    // Move Item at Oldindex (=-1 -> DownItem) to NewIndex (in Section SectionIndex)
    function ItemMove(NewIndex:Integer; OldIndex:Integer=-1; SectionIndex:Integer=-1; Activate:Boolean=true; effect:Boolean=false):Boolean;
    // Make section with Index NewIndex the active section
    procedure   SectionActivate(NewIndex:Integer; effect:Boolean=false);
    // return Section at Position X, Y
    function    SectionAtPos(X,Y:Integer):Integer;
    // add new section and return index of it. Set Activate to true to make it active section
    // ShowEditor: Only possible when Activate=true
    function    SectionAdd(Activate:Boolean=true; ShowEditor:Boolean=False; effect:Boolean=false):Integer;

    // copy ImageList settings from Section FromIndex to Section ToIndex
    function    SectionCopyImageSettings(ToIndex:Integer; FromIndex:Integer=-1):Boolean;
    // copy imagelist settings from selected section to all other sections
    function    SectionsCopyImageSettings(FromIndex:Integer=-1):Boolean;

    // set options for all sections
    procedure   SetReadOnly(const Value:Boolean);
    procedure   SetAllowDownState(const Value:Boolean);
    procedure   SetViewStyle(const Value:TLMDSectionBarViewStyle);
    procedure   SetFont(Value:TFont);

    // add new section at index atIndex. Set Activate to true to make it active section´. Return true if successfull
    function    SectionInsert(AtIndex:Integer;Activate:Boolean=true; effect:Boolean=false):Boolean;
    // Delete section at Index. If no Index is mentioned, ActiveSection is deleted.
    function    SectionDelete(Index:Integer=-1):Boolean;
    // Edit caption of section with Index. If no Index is mentioned, caption of ActiveSection is edited.
    procedure   SectionEdit(Index:Integer=-1);
    // Move the Section mentioned in Index to position NewIndex. If no Index is mentioned, ActiveSection is used
    function    SectionMove(NewIndex:Integer; Index:Integer=-1; effect:Boolean=false):Boolean;
    // Move to next Section and activate it. Set effect to false to disable scroll effect
    function    SectionNext(effect:Boolean=true):Integer;
    // Move to previous Section and activate it. Set effect to false to disable scroll effect
    function    SectionPrev(effect:Boolean=true):Integer;
    // Use this method to retrieve the current rect of the Section with Index.
    function    SectionRect(Index:Integer):TRect;
    // Hide an active edit for changing section captions
    function   CancelEditMode:Boolean;

    procedure   InvalidateSectionButton(Index:Integer);virtual;
    procedure   UpdateSection(Index:Integer);virtual;

    // event handlers
    procedure DoItemEvents(Sender: TObject; Reason:TLMDSectionBarItemEventType; Item:TObject);

    procedure DoDrawBackground(Sender:TObject;Canvas:TCanvas;Rect:TRect;var Done:Boolean);
    procedure DoDrawItem(Sender:TObject;Canvas:TCanvas;Rect:TRect;Item:TLMDSectionBarItem;var Done:Boolean);

    function getLMDPackage:TLMDPackageID;override;
    end;

  TLMDSectionBar=class(TLMDCustomSectionBar)
  public
    property ActiveSection;
    property ActiveSections;
  published
    property About;
    property BevelEdges;
    property BevelInner default bvNone;
    property BevelOuter;
    property BevelKind default bkTile;
    property BevelWidth;
    property BorderWidth;
    property Color;
    property Font;

    //property  CtlXP;
    property  Sections;
    property  ActiveSectionIndex;
    property  CaptionAlignment;
    property  HotTrack;
    property  ScrollFrequency;
    property  SingleSection;
    property  SectionStorage;
    property  SectionDrag;

    property  Theme;
    property  ThemeController;

    property  OnItemClick;
    property  OnItemSelectionChange;
    property  OnItemSelect;
    property  OnItemUnSelect;
    property  OnItemDraw;
    property  OnItemAdd;
    property  OnBeforeItemDelete;
    property  OnItemDelete;

    property  OnSectionDrawBackground;
    property  OnSectionDrawButton;
    property  OnSectionChange;
    property  OnSectionBeforeChange;
    property  OnSectionAdd;
    property  OnSectionDelete;
    property  OnBeforeSectionDelete;

    property  OnEditHide;
    property  OnSectionEditShow;
    property  OnItemEditShow;

    property  OnSectionCaptionChange;
    property  OnSectionCaptionChanging;
    property  OnItemCaptionChanging;
    property  OnItemCaptionChange;

    property Align;
    property PopupMenu;
    property ShowHint;
    property ParentShowHint;
    property Cursor;
    property DragMode;
    property DragCursor;
    property Visible;

    // V4 enhancements
    property Anchors;
    property AutoSize;
    property Constraints;
    property UseDockManager default True;
    property DockSite;
    property DragKind;

    // events
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;

    property OnMouseExit;
    property OnMouseEnter;

    property OnKeyDown;
    property OnKeyUp;
    //property OnStartDrag;
    //property OnEndDrag;
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

  { ********************** TLMDBarClearButton ******************************** }
  TLMDBarClearButton=class(TSpeedButton)
  protected
    FBar : TLMDCustomSectionBar;
    FSectionIndex : Integer;
    FTimer : TTimer;
    procedure Paint;override;
    procedure OnTimer(Sender: TObject);
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;override;
    function IsDown:Boolean;
  end;

  { ********************** TLMDBarSectionCaptionEdit************************** }
  TLMDBarSectionCaptionEdit = class (TCustomEdit)
  private
    procedure   WMKillFocus(var Message : TWMSetFocus);message WM_KILLFOCUS;
  protected
    ItemIndex   : Integer;
    FClient     : TComponent;
    CancelEdit  : Boolean;
    procedure   CreateParams(var Params : TCreateParams);override;
    procedure   KeyPress(var Key : Char);override;
    function    IsSection:Boolean;
    procedure   UpdateCaption;
    procedure VisibleChanging; override;
  public
    constructor Create(AOwner : TComponent);override;
    procedure   Show(Value:TComponent);
  end;

implementation

var
  LMDBarCommmonScrollBmp:TBitmap;

function LMDGetFontHeight(aFont:TFont):Integer;
var
  Extent:TSize;
  old:HFont;
  DC:HDC;
begin
  result:=0;
  DC:=GetDC(0);
  try
    old:=SelectObject(DC, aFont.Handle);
    if GetTextExtentPoint(DC, 'Wq', 2, Extent) then result:=Extent.cY;
    SelectObject(DC, old);
  finally
    ReleaseDC(0, DC);
  end;
end;

{ ********************* TLMDSectionBarActionLink ******************************}
{ --------------------------- protected -------------------------------------- }
procedure TLMDSectionBarActionLink.AssignClient(AClient: TObject);
begin
  FClient := AClient as TLMDSectionBarItem;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarActionLink.IsCaptionLinked: Boolean;
begin
 Result:= inherited IsCaptionLinked and
          AnsiSameCaption(FClient.Caption, (Action as TCustomAction).Caption);
          end;

{------------------------------------------------------------------------------}
function TLMDSectionBarActionLink.IsEnabledLinked: Boolean;
begin
  Result := inherited IsEnabledLinked and
           (FClient.Enabled = (Action as TCustomAction).Enabled);
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarActionLink.IsHintLinked: Boolean;
begin
  Result := inherited IsHintLinked and
            (FClient.Hint = (Action as TCustomAction).Hint);
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
      (FClient.ImageIndex = (Action as TCustomAction).ImageIndex);
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarActionLink.IsOnExecuteLinked: Boolean;
begin
    Result := inherited IsOnExecuteLinked and
    (@FClient.OnClick = @Action.OnExecute);
end;

{------------------------------------------------------------------------------}
{function TLMDSectionBarActionLink.IsVisibleLinked: Boolean;
begin
  Result := inherited IsVisibleLinked and
    (FClient.Visible = (Action as TCustomAction).Visible);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then FClient.Caption := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarActionLink.SetEnabled(Value: Boolean);
begin
  if IsEnabledLinked then FClient.Enabled := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarActionLink.SetHint(const Value: string);
begin
  if IsHintLinked then FClient.Hint := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarActionLink.SetImageIndex(Value: Integer);
begin
   if IsImageIndexLinked then FClient.ImageIndex := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarActionLink.SetOnExecute(Value: TNotifyEvent);
begin
  if IsOnExecuteLinked then FClient.OnClick := Value;
end;

{------------------------------------------------------------------------------}
{procedure TLMDSectionBarActionLink.SetVisible(Value: Boolean);
begin
  if IsVisibleLinked then FClient.Visible := Value;
end;

{******************** TLMDSectionBarItem **************************************}
{--------------------------- private ------------------------------------------}
procedure TLMDSectionBarItem.SetAction(const Value: TBasicAction);
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
      // -> ToDO
      //Value.FreeNotification(Self);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarItem.SetCaption(const Value: String);
begin
  if FCaption<>Value then
    begin
      FCaption := Value;
      UpdateParentList(lukParams);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarItem.SetEnabled(const Value: Boolean);
begin
  if Value<>FEnabled then
    begin
      FEnabled := Value;
      if Parent.FList.CheckUpdate then
        Parent.FList.DrawItem(Self);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarItem.SetImageIndex(const Value: Integer);
begin
  if Value<>FImageIndex then
    begin
      FImageIndex := Value;
      if Parent.FList.CheckUpdate then
        UpdateParentList(lukParams);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarItem.SetIsDown(const Value: Boolean);
begin
  if FIsDown<>Value then
    begin
      FIsDown := Value;
      if Parent.FList.CheckUpdate then
        begin
          Parent.FList.SelectItemImmediatly(self, FEnabled);
          Parent.FList.CheckDownItem(Self);
        end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarItem.GetAction: TBasicAction;
begin
  if FActionLink <> nil then
    Result := FActionLink.Action
  else
    Result := nil;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarItem.GetActionLinkClass: TLMDSectionBarActionLinkClass;
begin
  Result:=TLMDSectionBarActionLink;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarItem.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation=opRemove) and (AComponent=Action) then
    Action:=nil;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarItem.GetParent: TLMDSectionBarItems;
begin
  Result := TLMDSectionBarItems(Collection);
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarItem.IsCaptionStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsCaptionLinked;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarItem.IsEnabledStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsEnabledLinked;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarItem.IsHintStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsHintLinked;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarItem.IsImageIndexStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsImageIndexLinked;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarItem.IsOnClickStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsOnExecuteLinked;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarItem.UpdateParentList(Kind:TLMDSectionBarUpdateKind);
begin
  if Parent<>nil then
    Parent.UpdateParentList(Self, Kind);
end;

{-------------------------- protected -----------------------------------------}
procedure TLMDSectionBarItem.ActionChange(Sender: TObject;CheckDefaults: Boolean);
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
        //if not CheckDefaults or (Self.Visible = True) then
          //Self.Visible := Visible;
        if not CheckDefaults or not Assigned(Self.OnClick) then
          Self.OnClick := OnExecute;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarItem.DoActionChange(Sender: TObject);
begin
  if Sender = Action then ActionChange(Sender, False);
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarItem.GetDisplayName:String;
begin
    result := inherited GetDisplayName;
  if FCaption='' then
    result:=IDS_BARNOCAPTION+inttostr(Index)
  else
    result:=FCaption;
  result:=result+' ('+self.ClassName+')';
end;

{--------------------------- public -------------------------------------------}
constructor TLMDSectionBarItem.Create(Collection: TCollection);
begin
  //FCaption := ;
  FData    := nil;
  FTag     := 0;
  FIsDown  := False;
  FEnabled := True;
  FImageIndex:=-1;
  inherited;
end;

{------------------------------------------------------------------------------}
destructor TLMDSectionBarItem.Destroy;
begin
  Action := nil;
  FreeAndNil(FActionLink);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarItem.Assign(Source: TPersistent);
begin
  if Source=self then exit;
  if Source is TLMDSectionBarItem then
    with TLMDSectionBarItem(Source) do
      begin
        self.Action     := Action;
        self.FCaption    := Caption;
        self.FImageIndex := ImageIndex;
        self.FTag        := Tag;
        self.FData       := Data;
        self.FEnabled    := Enabled;
        self.FHint       := Hint;
        self.FIsDown     := Down;
        self.OnClick    := OnClick;
        exit;
      end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarItem.Click;
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
procedure TLMDSectionBarItem.InitiateAction;
begin
  if Action <> nil then ActionChange(Action, True);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarItem.MakeVisible;
var
  Rect : TRect;
begin
  Parent.FList.RealignItems;
  Rect := Parent.FList.GetRawItemRect(Self);
  if (Rect.Top<0) then
    Dec(Parent.FList.FRectPos,Rect.Top)
  else
    if (Rect.Bottom>Parent.FList.ClientRect.Bottom) then
      Dec(Parent.FList.FRectPos,Parent.FList.ClientRect.Bottom-Rect.Bottom);
end;

{ TLMDSectionBarItems }
{******************** TLMDSectionBarItems ********************************}
{--------------------------- private ------------------------------------------}
function TLMDSectionBarItems.GetItems(Index: Integer): TLMDSectionBarItem;
begin
  Result := TLMDSectionBarItem(inherited Items[Index]);
end;

{--------------------------- public -------------------------------------------}
constructor TLMDSectionBarItems.Create(aOwner:TPersistent; aList:TLMDSectionBarView);
begin
  inherited Create(aOwner, TLMDSectionBarItem);
  FList := aList;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarItems.Add: TLMDSectionBarItem;
begin
  Result := TLMDSectionBarItem(inherited Add);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarItems.InitiateActions;
var
  i:Integer;
begin
  for i:=0 to Count-1 do
    Items[i].InitiateAction;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarItems.Update(Item: TCollectionItem);
begin
  inherited;
  UpdateParentList(TLMDSectionBarItem(Item),lukAll);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarItems.UpdateParentList(Item: TLMDSectionBarItem;Kind:TLMDSectionBarUpdateKind);
begin
  if FList<>nil then
    FList.UpdateItems(Item, Kind);
end;

{******************** TLMDSectionBarView **************************************}
{--------------------------- private ------------------------------------------}
function TLMDSectionBarView.CheckDesignTime: Boolean;

  function IsParentDesigned(Parent: TWinControl): Boolean;
  begin
    Result := False;
    if Parent = nil then Exit;
    while (Parent <> nil) and (not Result) do
      begin
        Result := csDesigning in Parent.ComponentState;
        Parent := Parent.Parent;
      end;
  end;

begin
  Result := IsParentDesigned(Self);
end;

{------------------------------------------------------------------------------}
function  TLMDSectionBarView.CheckMousePos(X,Y:Integer; FullRepaint:Boolean=False):Boolean;
var
  Item : TLMDSectionBarItem;

  procedure HideHint;
  begin
    Hint := '';
    Application.HideHint;
  end;

begin
  Result := False;
  if CheckDesignTime then exit;
  Item := ItemAtPos[X,Y];
  if (Item<>nil) and (not Item.Enabled) then
    Item := nil;
  if FSelected<>Item then
    begin
      Result := Item<>nil;
      if (FullRepaint) then
        begin
          DoSelectItem(Item);
          Repaint;
        end
      else
        begin
           if (FSelected<>nil) {and (not FSelected.FIsDown)} then
             DoUnSelectItem(FSelected);
           DoSelectItem(Item);
           if Result then
             SelectItemImmediatly(Item, (FDownItem=Item) or (Item.FIsDown));
        end;
      if not IsDown then
        begin
          if (FSelected=nil) or not ShowHint then
            HideHint
          else
            if FSelected.Hint<>'' then
              begin
                Hint:=FSelected.Hint;
                Application.ActivateHint(Point(0,0));
              end
            else if FSelected.IsLongCaption then
              begin
                Hint:=FSelected.Caption;
                Application.ActivateHint(Point(0,0));
              end
            else
              HideHint;
          DoSelect;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.CheckScrollVisible;
var
  CRect : TRect;
begin
  if not HandleAllocated then
    exit;

  CRect := ClientRect;
  if FScrollUpBtn.Visible<>(FRectPos>0) then
    begin
      FScrollUpBtn.Visible := FRectPos>0;
      SendMessageToParent(WM_UPDATESCROLL,0,0);
    end;
  if (FScrollDownBtn.Visible<>((FListRect.Bottom-FListRect.Top-FRectPos)>(CRect.Bottom-CRect.Top))) then
    begin
      FScrollDownBtn.Visible:=(FListRect.Bottom-FListRect.Top-FRectPos)>(CRect.Bottom-CRect.Top);
      SendMessageToParent(WM_UPDATESCROLL,0,1);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.CMMouseLeave(var Message: TMessage);
begin
  if not (csDesigning in ComponentState) then
    begin
      if Message.LParam<>0 then exit;
      if (not IsDown) and (FSelected<>nil) then
        begin
          if ((not FAllowDown) or (not IsDown) or (FSelected.FIsDown)) and (FSelected.Enabled) then
            DoUnSelectItem(FSelected);
          FSelected := nil;
          DoSelect;
        end;
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.CMVisibleChanged(var Message: TMessage);
begin
  if Message.WParam=1 then
    RealignItems;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.CMFontChanged (var Msg : TMessage);
begin
  inherited;
  RealignItems;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarView.GetCaptionRect(Item: TLMDSectionBarItem): TRect;
var
  IRect : TRect;
  theme: TLMDSectionBarTheme;
  PI:TLMDBarParentControlInterface;
begin
  Result := ItemRect[Item];

  PI:=GetParentInterface;
  if PI=nil then exit;
  Theme :=PI.GetTheme as TLMDSectionBarTheme;

  if ImageList=nil then
    begin
      Inc(Result.Left,Theme.ImageSpace{ div 2});
      Dec(Result.Right,Theme.ImageSpace{ div 2});
      Inc(Result.Top,Theme.ImageSpace{ div 2});
      Dec(Result.Bottom,Theme.ImageSpace{ div 2});
    end
  else
    begin
      IRect  := ImageRect[Item];
      Result.Right:= Result.Right-Theme.CaptionSpace{ div 2};
      Result.Bottom := Result.Bottom-Theme.CaptionSpace{ div 2};
      if FViewStyle=lvsSmallImages then
        begin
          Result.Left := IRect.Right+Theme.ImageSpace{ div 2}+Theme.CaptionSpace{ div 2};
          Result.Top  := Result.Top+Theme.CaptionSpace{ div 2};
        end
      else
        begin
          Result.Left := Result.Left+Theme.CaptionSpace{ div 2};
          Result.Top  := IRect.Bottom+Theme.ImageSpace{ div 2}+Theme.CaptionSpace{ div 2};
        end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarView.GetImageRect(Item: TLMDSectionBarItem): TRect;
var
  theme: TLMDSectionBarTheme;
  PI:TLMDBarParentControlInterface;
begin
  Result := ItemRect[Item];

  PI:=GetParentInterface;
  if PI=nil then exit;
  Theme :=PI.GetTheme as TLMDSectionBarTheme;

  if ImageList=nil then
    begin
      Inc(Result.Left,Theme.ImageSpace{ div 2});
      Dec(Result.Right,Theme.ImageSpace{ div 2});
      Inc(Result.Top,Theme.ImageSpace{ div 2});
      Dec(Result.Bottom,Theme.ImageSpace{ div 2});
    end
  else
    begin
      if FViewStyle=lvsSmallImages then
        begin
          Result.Left := Result.Left+Theme.ImageSpace{ div 2};
          Result.Right:= Result.Left+ImageList.Width;
          Result.Top  := Result.Top+(Result.Bottom-Result.Top-ImageList.Height-(2*Theme.ImageSpace)) div 2 + Theme.ImageSpace{ div 2};
          Result.Bottom := Result.Top+ImageList.Height;
        end
      else
        begin
          Result.Left := Result.Left+(Result.Right-Result.Left-ImageList.Width) div 2;
          Result.Right:= Result.Left+ImageList.Width;
          Result.Top  := Result.Top+Theme.ImageSpace{ div 2};
          Result.Bottom := Result.Top+ImageList.Height;
        end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarView.GetItemAtPos(X, Y: Integer): TLMDSectionBarItem;
begin
  Result := GetItemAtPosInternal(X, Y);
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarView.GetItemAtPosInternal(X, Y: Integer;bRaw: Boolean): TLMDSectionBarItem;
var
  IRect : TRect;
  i     : Integer;
begin
  Result := nil;
  for i:=0 to Items.Count-1 do
    begin
      if bRaw then
        IRect := GetRawItemRect(Items[i])
      else
        IRect := GetItemRect(Items[i]);
      if (IRect.Top<=Y) and (IRect.Bottom>=Y) and (IRect.Left<=X) and (IRect.Right>=X) then
        begin
          Result := Items[i];
          break;
        end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarView.GetParentInterface: TLMDBarParentControlInterface;
begin
  Result := nil;
  if ValidBarParent <> nil then
    Parent.Parent.GetInterface(IID_ILMDBarParentControlInterface, Result);
  end;

{------------------------------------------------------------------------------}
function TLMDSectionBarView.GetPressed: TLMDSectionBarItem;
var
  i : Integer;
begin
  Result := nil;
  for i:=0 to FItems.Count-1 do
    if FItems[i].Down then
      begin
        Result := FItems[i];
        break;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.SetPressed(const Value: TLMDSectionBarItem);
var
  i : Integer;
begin
  FDownItem:=nil;
  for i:=0 to FItems.Count-1 do
    if AllowDown and (Value=FItems[i]) and FItems[i].Enabled then
      begin
        Fitems[i].FIsDown:=True;
        FDownItem:=FItems[i];
      end
    else
      Fitems[i].FIsDown:=false;
  MinimumUpdate;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarView.GetRawItemRect(Item: TLMDSectionBarItem): TRect;
var
  CRect : TRect;
begin
  CRect  := GetClientRect;
  AdjustClientRect(CRect);
  Result := CRect;
  with Result do
    begin
      Top := Item.FTop+FListRect.Top-FRectPos+CRect.Top;
      Bottom := Top+ItemHeight;
      Dec(Right);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.ImageListChange(Sender: TObject);
begin
  MinimumUpdate;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarView.ValidBarParent: TWinControl;
begin
  result:=nil;
  if (Parent<>nil) and (Parent.Parent<>nil) then
    result:=TCustomControl(Parent.Parent);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.OnDownScrollButton(Sender: TObject);
begin
  Scroll(ItemHeight);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.OnTimer(Sender: TObject);
var
  iScroll : Integer;
  Message : TWMMouseMove;
begin
  if IsDraging and PtInRect(ClientRect, Point(FX, FY)) then
    begin
      iScroll := 0;
      if FScrollUpBtn.Visible then
        if FY<(ClientRect.Top+ItemHeight div 2) then
          iScroll := GetScrollChange(True);
      if FScrollDownBtn.Visible then
        if FY>(ClientRect.Bottom-ItemHeight div 2) then
          iScroll := GetScrollChange(False);
      if iScroll<>0 then
        begin
          if FDragPlace<>-1 then
            InvalidateDragPlace;
          Scroll(iScroll, False);
          FDragPlace := -1;
          Message.XPos := FX;
          Message.YPos := FY;
          WMMouseMove(Message);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.OnUpScrollButton(Sender: TObject);
begin
  Scroll(-ItemHeight);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.ProcessPaintMessages;
var
  Msg   : TMsg;
begin
  while PeekMessage(Msg, Handle, WM_PAINT, WM_PAINT, PM_REMOVE) do
    DispatchMessage(Msg);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.Scroll(iScroll: Integer; bAnimate:Boolean=True);
var
  CRect : TRect;
  iSign : Integer;
  Msg   : TMsg;
  theme: TLMDSectionBarTheme;
  PI:TLMDBarParentControlInterface;

begin
  PI:=GetParentInterface;
  if PI=nil then exit;
  Theme :=PI.GetTheme as TLMDSectionBarTheme;

  CRect := ClientRect;
  AdjustClientRect(CRect);
  if (iScroll+FRectPos)<0 then
    iScroll := -FRectPos;
  if iScroll=0 then exit;
  iSign := -iScroll div abs(iScroll);
  FScrolling := True;
  ProcessPaintMessages;

  while bAnimate and (abs(iScroll)>Theme.ScrollStep) do
    begin
      Dec(FRectPos,iSign*Theme.ScrollStep);
      ScrollWindow(Handle,0,iSign*Theme.ScrollStep,@CRect, @CRect);
      Inc(iScroll,iSign*Theme.ScrollStep);
      if PeekMessage(Msg, Handle, WM_PAINT, WM_PAINT, PM_REMOVE) then
        DispatchMessage(Msg);
      Sleep(1);
    end;
  Inc(FRectPos,iScroll);
  ScrollWindow(Handle,0,-iScroll,@CRect, @CRect);
  CheckScrollVisible;
  FScrolling := False;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.SetAllowAllUp(const Value: Boolean);
begin
  FAllowAllUp := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.SetAllowDown(const Value: Boolean);
begin
  if FAllowDown<>Value then
    begin
      FAllowDown := Value;
      if not FAllowDown then
        CheckDownItem(nil);
      MinimumUpdate;
    end;
end;

{------------------------------------------------------------------------------}
{procedure TLMDSectionBarView.SetMultiselect(const Value: Boolean);
begin
  FMultiselect := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.SetItems(const Value: TLMDSectionBarItems);
begin
  FItems.Assign(Value);
  RealignItems;
  MinimumUpdate;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.SetLargeImages(const Value: TCustomImageList);
begin
  if LargeImages <> Value then
    begin
      if LargeImages <> nil then
        LargeImages.UnRegisterChanges(FLargeChangeLink);
      FLargeImages := Value;
      if LargeImages <> nil then
        LargeImages.RegisterChanges(FLargeChangeLink);
      RealignItems;
      MinimumUpdate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.SetSmallImages(const Value: TCustomImageList);
begin
  if Value <> SmallImages then
    begin
      if SmallImages <> nil then
        SmallImages.UnRegisterChanges(FSmallChangeLink);
      FSmallImages := Value;
      if SmallImages <> nil then
        SmallImages.RegisterChanges(FSmallChangeLink);
      RealignItems;
      MinimumUpdate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.SetViewStyle(const Value: TLMDSectionBarViewStyle);
var
  i : Integer;
begin
  if FViewStyle<>Value then
    begin
       i := FRectPos div ItemHeight;
       FViewStyle := Value;
       FRectPos := ItemHeight*i;
       RealignItems;
       CheckScrollVisible;
       MinimumUpdate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.UpdateItems(Item: TLMDSectionBarItem;Kind:TLMDSectionBarUpdateKind);
begin
  case Kind of
    lukAll :
      begin
        RealignItems;
        if (Item=nil) or (FSelected=Item) then
          FSelected := nil;
      end;
  end;
  MinimumUpdate;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.WMLButtonDown(var Message: TWMLButtonDown);
var
  pt : TPoint;
  Msg: TMessage;
begin
  if CheckDesignTime then
    begin
      pt.X := Message.XPos;
      pt.Y := Message.YPos;
      Pt := ClientToScreen(Pt);
      Pt := Parent.Parent.ScreenToClient(Pt);
      Message.XPos := Pt.X;
      Message.YPos := Pt.Y;
      Msg := TMessage(Message);
      Parent.Parent.WindowProc(Msg);
      exit;
    end;
  if (FSelected<>nil) and (FSelected.Enabled) then
    begin
      FDragPlace := -1;
      FDownItem := FSelected;
      FSelected.FIsDown := True;
      CheckDownItem(FSelected);
      SelectItemImmediatly(FSelected, True);
      IsDown := True;
      if not FReadOnly then
        begin
          SetCapture(Handle);
          FTimer.Interval:=200;
          FTimer.Enabled:=True;
          FDownPoint.x := Message.XPos;
          FDownPoint.y := Message.YPos;
        end
      else
        FDownPoint:=Point(-99,-99);
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.WMLButtonUp(var Message: TWMLButtonUp);
var
  pt : TPoint;
  Msg: TMessage;
begin
  if CheckDesignTime then
    begin
      pt.X := Message.XPos;
      pt.Y := Message.YPos;
      Pt := ClientToScreen(Pt);
      Pt := Parent.Parent.ScreenToClient(Pt);
      Message.XPos := Pt.X;
      Message.YPos := Pt.Y;
      Msg := TMessage(Message);
      Parent.Parent.WindowProc(Msg);
      exit;
    end;
  FTimer.Enabled := False;
  if GetCapture=Handle then
    ReleaseCapture;
  if IsDown then
    begin
      Screen.Cursor := crDefault;
      if not IsDraging then
        begin
          if FSelected=FDownItem then
            begin
              if FAllowDown then
                begin
                  {if FAllowAllUp then
                    FSelected.FIsDown := not FSelected.FIsDown
                  else}
                    FSelected.FIsDown := True;
                  CheckDownItem(FSelected);
                end;
              DoItemClick;
              // --> Check MousePos here. MousePos still correct?
              GetCursorPos(pt);

              if FindVCLWindow(pt)<>self then
                begin
                  Message.XPos:=pt.X;
                  Message.YPos:=pt.Y;
                end;
            end;
        end
      else
        begin
          DoEndDrag(FDragTargetControl, Message.XPos,Message.YPos);
        end;
      IsDown   := False;
      IsDraging:= False;
      if (not FAllowDown) then
        begin
          if Assigned(FSelected) then FSelected.FIsDown:=false;
          DoUnSelectItem(FSelected);
        end;
      FSelected := nil;
      FDownItem := nil;
      //ToDo?
      //CheckMousePos(Message.XPos,Message.YPos);
    end
  else
    inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.WMMouseMove( var Message: TWMMouseMove);
begin
  if not (csDesigning in ComponentState) then
    begin
      FX := Message.XPos;
      FY := Message.YPos;
      if IsDown and (not IsDraging) and not FReadOnly { and (not FAllowDown) }then
        begin
          IsDraging := (abs(FDownPoint.x-Message.XPos)>defLMD_CXDRAG) or (abs(FDownPoint.y-Message.YPos)>defLMD_CYDRAG);
          MouseCapture := True;
        end;
      if IsDraging then
        begin
          DragMove(Message.XPos,Message.YPos);
        end
      else
        CheckMousePos(Message.XPos,Message.YPos);
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.WMRButtonDown(var Message: TWMRButtonDown);
var
  pt : TPoint;
  Msg: TMessage;
begin
  if CheckDesignTime then
    begin
      pt.X := Message.XPos;
      pt.Y := Message.YPos;
      Pt := ClientToScreen(Pt);
      Pt := Parent.Parent.ScreenToClient(Pt);
      Message.XPos := Pt.X;
      Message.YPos := Pt.Y;
      Msg := TMessage(Message);
      Parent.Parent.WindowProc(Msg);
      exit;
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.WMRButtonUp(var Message: TWMRButtonUp);
var
  pt : TPoint;
  Msg: TMessage;
begin
  if CheckDesignTime then
    begin
      pt.X := Message.XPos;
      pt.Y := Message.YPos;
      Pt := ClientToScreen(Pt);
      Pt := Parent.Parent.ScreenToClient(Pt);
      Message.XPos := Pt.X;
      Message.YPos := Pt.Y;
      Msg := TMessage(Message);
      Parent.Parent.WindowProc(Msg);
      exit;
    end;
  inherited;
end;

{-------------------------- protected -----------------------------------------}
function TLMDSectionBarView.CanDropItem(X,Y:Integer): Boolean;
var
  iPos: Integer;
  Rect: TRect;
begin
  Result := GetDropPosition(X, Y, iPos,Rect);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.CheckDownItem(Item: TLMDSectionBarItem);
var
  i : Integer;
begin
  if Item=nil then
    begin
      for i:=0 to Items.Count-1 do
        FItems[i].FIsDown := False;
      FDownItem:=nil;
      exit;
    end;
  if AllowDown then
    begin
      if {(not Multiselect) and} Item.FIsDown then
        begin
          for i:=0 to Items.Count-1 do
            if (Items[i]<>Item) and (Items[i].FIsDown) then
              begin
                FItems[i].FIsDown := False;
                DoUnPressItem(FItems[i]);
              end;
        end
      else
        DoUnSelectItem(Item);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.Click;
begin
  inherited Click;
  if Assigned(FOnItemSelect) then
    FOnItemSelect(self, istClick, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.DoItemClick;
begin
  if Assigned(FOnItemSelect) then
    FOnItemSelect(self, istItemClick, FSelected);
  FSelected.Click;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.DoSelectItem(Item:TLMDSectionBarItem);
begin
  FSelected:=Item;
  if FSelected=nil then exit;

  If Assigned(FOnItemSelect) then
    FOnItemSelect(self, istItemSelect, Item);
  if Assigned(FSelected.OnMouseEnter) then
    FSelected.OnMouseEnter(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.DoUnPressItem(Item: TLMDSectionBarItem);
var
  Rect:TRect;
begin
  if Item=nil then exit;

  if Assigned(Item.OnItemUp) then
    Item.OnItemUp(self);

  if Assigned(FOnItemSelect) then
    FOnItemSelect(self, istItemUnSelect, Item);

  Rect:=GrowItemRect(Item);
  Inc(Rect.Right);
  Inc(Rect.Bottom);
  InvalidateRect(Handle,@Rect,False);
  end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.DoUnSelectItem(Item: TLMDSectionBarItem);
var
  Rect:TRect;
begin
  if Item=nil then exit;

  if Assigned(FOnItemSelect) then
    FOnItemSelect(self, istItemUnSelect, Item);

  if Assigned(Item.OnMouseExit) then
    Item.OnMouseExit(self);

  Rect:=GrowItemRect(Item);
  Inc(Rect.Right);
  Inc(Rect.Bottom);
  InvalidateRect(Handle,@Rect,False);
  end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.DoEndDrag(Target: TObject; X, Y: Integer);
var
  iPos : Integer;
  Rect : TRect;
  pt   : TPoint;
  tmp  : TLMDSectionBarView;
begin
  if FDragPlace<>-1 then
   InvalidateDragPlace;
  FDragPlace := -1;
  if Target is TLMDSectionBarView then
    begin
      tmp:=TLMDSectionBarView(Target);
      if Target<>Self then
        begin
          pt.X := X;
          pt.Y := Y;
          pt := ClientToScreen(pt);
          pt := tmp.ScreenToClient(pt);
          X := pt.X;
          Y := pt.Y;
        end;
      if tmp.GetDropPosition(X,Y, iPos, Rect) then
        begin
          if Assigned(OnDragDrop) then
            OnDragDrop(Target, self, x,y);

          if FDownItem<>nil then
            begin
              if Target<>Self then
                begin
                  if iPos<0 then
                    iPos := 0;
                  // move item...
                  ipos:=tmp.Items.Insert(iPos).Index;
                  // changes in target view
                  if ipos<>-1 then
                    begin

                      tmp.Items[ipos].Assign(FDownItem);
                      if tmp.AllowDown and (tmp.FDownItem<>nil) then
                        tmp.CheckDownItem(tmp.Items[ipos])
                      else
                        begin
                          tmp.Items[ipos].FIsDown:=False;
                          tmp.FDownItem:=nil;
                        end;
                      tmp.FSelected:=nil;
                      tmp.FDragPlace:=-1;
                      tmp.RealignItems;
                      tmp.CheckScrollVisible;
                    end;
                  // changes in current view
                  Items.Delete(FDownItem.Index);
                  RealignItems;
                  CheckScrollVisible;
                end
              else
                FDownItem.Index := iPos;
            end;
        end;
    end
  else
   if Assigned(OnDragDrop) then
     OnDragDrop(Target, self, x,y);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.DoSelect;
begin
  if Assigned(OnItemSelect) then
    OnItemSelect(self, istGeneral, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.DragMove(X, Y: Integer);
var
  SourcePos:TPoint;
  TargetScreenPos:TPoint;
  b : Boolean;
begin
  DragNotifyControl(FDragTargetControl,X,Y);
  SourcePos:=Point(X,Y);
  TargetScreenPos:=ClientToScreen(SourcePos);
  FDragTargetControl:=FindVCLWindow(TargetScreenPos);
  if FDragTargetControl<>nil then
    b:=DragNotifyControl(FDragTargetControl,X,Y)
  else
    b := False;
  if b then
    Screen.Cursor := crDrag//Move
  else
    Screen.Cursor := crNoDrop;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarView.DragNotifyControl(Control: TWinControl; X, Y: Integer): Boolean;
var
  SourcePos:TPoint;
  ControlScreenPos:TPoint;
  ControlPos:TPoint;
begin
  Result:=False;
  SourcePos:=Point(X,Y);
  ControlScreenPos:=ClientToScreen(SourcePos);
  if (Control<>nil) then
    begin
      ControlPos:=Control.ScreenToClient(ControlScreenPos);
      Result:=True;
      TLMDWinControl(Control).DragOver(self, ControlPos.X, ControlPos.Y, dsDragMove, Result);

      if Control is TLMDSectionBarView then
         begin
           TLMDSectionBarView(Control).FX:=ControlPos.X;
           TLMDSectionBarView(Control).FY:=ControlPos.Y;
         end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  iPos : Integer;
  Rect : TRect;
  Complete : Boolean;
begin
  Complete := False;
  if Assigned(FOnDragOver) then
    OnDragOver(Source, X, Y, State, Accept, Complete);
  if Complete or not (Source is TLMDSectionBarView) then exit;
  if ValidBarParent<>nil then
    Accept:=TLMDSectionBar(ValidBarParent).SectionDrag;
  Accept:=(Source=self) or (Accept and (not ReadOnly and (Source is TLMDSectionBarView)));
  if Accept then
    begin
      if not IsDown then
        begin
          FDownItem := TLMDSectionBarView(Source).FSelected;
        end;

      if not GetDropPosition(X,Y, iPos, Rect)  then
        begin
          if FDragPlace<>-1 then
            InvalidateDragPlace;
          FDragPlace := -1;
          Accept := False;
        end
      else
        if iPos<>FDragPlace then
          begin
            if FDragPlace<>-1 then
              InvalidateDragPlace;
            FDragPlace    := iPos;
            if FDragPlace<>-1 then
              InvalidateDragPlace;
          end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.DrawBackground;
var
  Rect : TRect;
  Theme  : TLMDSectionBarTheme;
  PI : TLMDBarParentControlInterface;
  b  : Boolean;
begin
  b := false;
  if Assigned(FOnDrawBackground) then
    FOnDrawBackground(Self,Canvas,GetClientRect,b);
  if b then exit;

  PI := GetParentInterface;
  if PI=nil then exit;
  Theme :=PI.GetTheme as TLMDSectionBarTheme;

  with Canvas do
    begin
      Brush.Color := Theme.ViewBackground;
      Rect := GetClientRect;
      AdjustClientRect(Rect);
      FillRect(Rect);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.DrawItem(Item: TLMDSectionBarItem);
var
  tmpRect, calcrect : TRect;
  IL : TCustomImageList;
  Format : UINT;
  Theme  : TLMDSectionBarTheme;
  PI : TLMDBarParentControlInterface;
  b : Boolean;

begin
  IL := ImageList;

  b := False;
  tmpRect := ItemRect[Item];
  Item.FCaptionLong:=false;
  if Assigned(FOnDrawItem) then
    FOnDrawItem(Self,Canvas,tmpRect,Item,b);
  if b then exit;

  PI := GetParentInterface;
  if PI=nil then exit;
  Theme :=PI.GetTheme as TLMDSectionBarTheme;

  if IL<>nil then
    begin
      if (Item.ImageIndex>=0) and (Item.ImageIndex<IL.Count) then
        begin
          tmpRect := ImageRect[Item];
          IL.Draw(Canvas,tmpRect.Left,tmpRect.Top, Item.ImageIndex,Item.Enabled);
        end;
    end;

  Canvas.Font := Font;
  Canvas.Brush.Style := bsClear;
  tmpRect := CaptionRect[Item];

  if FViewStyle=lvsSmallImages then
    Format := DT_LEFT
  else
    Format := DT_CENTER;

  // Fix March 2007
  if not Item.Enabled then
    SetTextColor(Canvas.Handle,Theme.DisableTextColor)
  else
    if Item=Selected then
      SetTextColor(Canvas.Handle,Theme.HighlightTextColor)
    else
      SetTextColor(Canvas.Handle,Theme.TextColor);
  // ------------

  if ShowHint then
    begin
      calCrect:=tmpRect;
      DrawText(Canvas.Handle,PChar(Item.Caption),Length(Item.Caption),calcRect,DT_CALCRECT or DT_VCENTER or DT_SINGLELINE or Format);
      Item.FCaptionLong:=calcrect.Right>tmpRect.Right;
    end;

  DrawText(Canvas.Handle,PChar(Item.Caption),Length(Item.Caption),tmpRect,DT_END_ELLIPSIS or DT_VCENTER or DT_SINGLELINE or Format);
  end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.DrawItems;
var
  i : Integer;
begin
  for i:=0 to Items.Count-1 do
    begin
      if IsItemVisible(Items[i]) then
        if FAllowDown then
          begin
            if Items[i].FIsDown then
              SelectItemImmediatly(Items[i], True)
            else
              if (FSelected=Items[i]) or (i=FDragPlace) then
                SelectItemImmediatly(Items[i], IsDown and (FDownItem=Items[i]))
              else
                DrawItem(Items[i]);
          end
        else
          if (FSelected=Items[i]) or (i=FDragPlace) then
            SelectItemImmediatly(Items[i], IsDown and (FDownItem=Items[i]))
          else
            DrawItem(Items[i]);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.DrawSelectedFrame(Item: TLMDSectionBarItem;
  Color1, Color2: TColor);
var
  Rect:TRect;
begin
  Rect:=GrowItemRect(Item);
  Canvas.MoveTo(Rect.Left,Rect.Bottom);
  Canvas.Pen.Color:=Color1;
  Canvas.LineTo(Rect.Left,Rect.Top);
  Canvas.LineTo(Rect.Right,Rect.Top);
  Canvas.Pen.Color:=Color2;
  Canvas.LineTo(Rect.Right,Rect.Bottom);
  Canvas.LineTo(Rect.Left-1,Rect.Bottom);
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarView.GetDropPosition(X, Y:Integer;var iPos: Integer; var Rect: TRect): Boolean;
var
  Item : TLMDSectionBarItem;
  CRect: TRect;
begin
  Result := False;
  CRect := ClientRect;
  AdjustClientRect(CRect);
  Item := GetItemAtPosInternal(X, Y, True);
  if{ (Item=nil) and }(not PtInRect(CRect, POINT(X, Y))) then exit;
  if Item=nil then
    iPos := FItems.Count-1
  else
    begin
      iPos := Item.Index;
      Rect := GetRawItemRect(Item);
    end;
  Result := (FDownItem<>nil) and ((FDownItem.GetParent.FList<>Self) or ((FDownItem.Index<>iPos) {and ((FDownItem.Index+1)<>iPos)}));
  if Result then
    begin
      Rect := CRect;
      Rect.Top := iPos*ItemHeight-FRectPos+Rect.Top;
      Rect.Bottom := Rect.Top+ItemHeight;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarView.GetImageList: TCustomImageList;
begin
  Result := nil;
  case FViewStyle of
    lvsLargeImages:  Result := FLargeImages;
    lvsSmallImages:  Result := FSmallImages;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarView.GetItemRect(Item: TLMDSectionBarItem): TRect;
var
  CRect : TRect;
  theme: TLMDSectionBarTheme;
  PI:TLMDBarParentControlInterface;
begin
  CRect  := GetClientRect;
  AdjustClientRect(CRect);
  Result := CRect;

  PI:=GetParentInterface;
  if PI=nil then exit;
  Theme :=PI.GetTheme as TLMDSectionBarTheme;

  with Result do
    begin
      Top := Item.FTop+FListRect.Top-FRectPos+CRect.Top+Theme.ItemsSpace div 2;
      Bottom := Top+ItemHeight-Theme.ItemsSpace{+Theme.ItemsSpace};
      Dec(Right);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarView.GetItemsHeight: Integer;
var
  iTmp : Integer;
  theme: TLMDSectionBarTheme;
  PI:TLMDBarParentControlInterface;

begin
  result:=1;

  PI:=GetParentInterface;
  if PI=nil then exit;
  Theme :=PI.GetTheme as TLMDSectionBarTheme;

  Result := Theme.ItemsSpace;

  if ImageList<>nil then
    Inc(Result,ImageList.Height+(2*Theme.ImageSpace));

  itmp:=LMDGetFontHeight(Font)+(2*Theme.CaptionSpace);

  if FViewStyle=lvsSmallImages then
    begin
      if (iTmp+(2*Theme.ItemsSpace))>Result then
        Result := iTmp+(2*Theme.ItemsSpace);
    end
  else
    Inc(Result,iTmp);
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarView.GetScrollChange(bUp: Boolean): Integer;
var
  Rect : TRect;
  theme: TLMDSectionBarTheme;
  PI:TLMDBarParentControlInterface;
begin
  result:=0;
  PI:=GetParentInterface;
  if PI=nil then exit;
  Theme :=PI.GetTheme as TLMDSectionBarTheme;

  if bUp then
    begin
      Result := -(FRectPos+Theme.DragSpace*2+1) mod ItemHeight;
      if Result=0 then
        Result := -ItemHeight;
    end
  else
    begin
      Rect := ClientRect;
      AdjustClientRect(Rect);
      Result := ItemHeight-(FRectPos+Rect.Bottom-Rect.Top-Theme.DragSpace*2-1) mod ItemHeight;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarView.GrowItemRect(Item: TLMDSectionBarItem): TRect;
var
  theme: TLMDSectionBarTheme;
  PI:TLMDBarParentControlInterface;

  function AdaptRect(r:TRect; Value:Integer):TRect;
  begin
    result:=r;
    Inc(Result.Right,Value);
    Dec(Result.Left,Value);
    Dec(Result.Top,Value);
    Inc(Result.Bottom,Value);
  end;
begin
  PI:=GetParentInterface;
  if PI=nil then exit;
  Theme :=PI.GetTheme as TLMDSectionBarTheme;
  case Theme.SelectionStyle of
    lssFull: Result := AdaptRect(ItemRect[Item],-1);
    lssIcon: Result := AdaptRect(ImageRect[Item], Theme.ImageSpace);
    lssCaption: Result := AdaptRect(CaptionRect[Item], Theme.CaptionSpace);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.InvalidateDragPlace;
var
  Rect : TRect;
begin
  if(FDragPlace>=0) and (FDragPlace<FItems.Count) then
    begin
      Rect := GetRawItemRect(Items[FDragPlace]);
      InvalidateRect(Handle,@Rect,true);
      end;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarView.IsItemVisible(Item: TLMDSectionBarItem): Boolean;
var
  CRect : TRect;
  IRect : TRect;
begin
  CRect := GetClientRect;
  AdjustClientRect(CRect);
  IRect := GetItemRect(Item);
  Result := ((CRect.Top<=IRect.Top) and (CRect.Bottom>=IRect.Top)) or
            ((CRect.Top<=IRect.Bottom) and (CRect.Bottom>=IRect.Bottom));
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.MinimumUpdate;
var
  Rect : TRect;
begin
  if not HandleAllocated then
    exit;
  Rect := ClientRect;
  AdjustClientRect(Rect);
  InvalidateRect(Handle, @Rect, False);
  end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.Paint;
var
  Rect: TRect;
  TopColor, BottomColor: TColor;
  Rgn   : HRGN;

  procedure AdjustColors(Bevel: TPanelBevel);
  begin
    TopColor := clBtnHighlight;
    if Bevel = bvLowered then TopColor := clBtnShadow;
    BottomColor := clBtnShadow;
    if Bevel = bvLowered then BottomColor := clBtnHighlight;
  end;

begin
  Rect := GetClientRect;

  {if (BorderStyle = bsSingle) then
    begin
      Canvas.Pen.Color := clWindowFrame;
      Canvas.Rectangle(ClientRect);
      InflateRect(Rect,-BorderWidth,-BorderWidth);
    end;

  if BevelOuter <> bvNone then
    begin
      AdjustColors(BevelOuter);
      Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
    end;
  Frame3D(Canvas, Rect, Color, Color, BorderWidth);

  if BevelInner <> bvNone then
    begin
      AdjustColors(BevelInner);
      Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
    end;}

  try
    Rgn := SetClip;
    DrawBackground;
    DrawItems;
    SelectClipRgn(Canvas.Handle, Rgn);
  except
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.RealignItems;
var
  CRect   : TRect;
  iItemHeight : Integer;
  i       : Integer;
  iCur    : Integer;
begin
  if not HandleAllocated then
    exit;
  CRect := ClientRect;
  AdjustClientRect(CRect);
  with FListRect do
    begin
      iItemHeight := ItemHeight;
      Left := 0;
      Right:= Left+CRect.Right-CRect.Left;
      Top  := 0;
      Bottom := Top+Items.Count*iItemHeight;
      if (FRectPos<0) then
        FRectPos := 0;
      if FRectPos>Bottom then
        FRectPos := Bottom;
      iCur := 0;
      for i:=0 to Items.Count-1 do
        begin
          Items[i].FTop := iCur;
          iCur := Items[i].FTop+iItemHeight;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.Resize;
var
  CRect : TRect;
begin
  CRect := ClientRect;
  RealignItems;
  CheckScrollVisible;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.SelectItemImmediatly(Item: TLMDSectionBarItem; IsDown: Boolean);
var
  Rgn : HRGN;
  Theme  : TLMDSectionBarTheme;
  PI : TLMDBarParentControlInterface;
  Rect : TRect;
begin

  PI := GetParentInterface;
  if PI=nil then exit;

  Theme :=PI.GetTheme as TLMDSectionBarTheme;
  if Theme=nil then exit;
  If Item=nil Then exit;

  Rgn := SetClip;
  if Item=FSelected then
    Canvas.Brush.Color := Theme.ItemSelectedBackground;
  If IsDown Then
    If (Item=FSelected) and (Item<>FDownItem) Then
      begin
        Canvas.FillRect(GrowItemRect(Item));
        DrawSelectedFrame(Item,Theme.ItemBorderBlack,Theme.ItemBorderLight);
      end
    else
      begin
        Canvas.Brush.Color := Theme.ItemDownBackground;
        Canvas.FillRect(GrowItemRect(Item));
        DrawSelectedFrame(Item,Theme.ItemBorderBlack,Theme.ItemBorderLight);
      end
  else
    If Item.Index=FDragPlace Then
      begin
        if not FScrolling then
          with Canvas do
            begin
              FillRect(Rect);
              Brush.Color := Theme.ItemDragBackground;
              Rect := GrowItemRect(Item);
              InflateRect(Rect,-1,-1);
              FillRect(Rect);
              Pen.Color := Theme.ItemDragBorder;
              MoveTo(Rect.Left,Rect.Top);
              LineTo(Rect.Right,Rect.Top);
              LineTo(Rect.Right,Rect.Bottom);
              LineTo(Rect.Left,Rect.Bottom);
              LineTo(Rect.Left,Rect.Top);
            end;
      end
    else
      begin
        Canvas.FillRect(GrowItemRect(Item));
        DrawSelectedFrame(Item,Theme.ItemBorderLight,Theme.ItemBorderBlack);
      end;
  DrawItem(Item);
  SelectClipRgn(Canvas.Handle, Rgn);
End;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.SendMessageToParent(Msg: Cardinal; WParam, LParam: Longint);
var
  b : Boolean;
begin
  b := (Parent<>nil) and (Parent.Parent<>nil);
  if b then
    Parent.Perform(Msg,WParam,LParam);
end;

{------------------------------------------------------------------------------}
function  TLMDSectionBarView.SetClip:HRGN;
var
  CRect: TRect;
  Rgn   : HRGN;
  oldRgn : HRGN;
  Point  : TPoint;
begin
  Result := 0;
  CRect := GetClientRect;
  AdjustClientRect(CRect);
  GetWindowOrgEx(Canvas.Handle,Point);
  OffsetRect(CRect,-Point.x,-Point.y);
  oldRgn := 0;
  if (GetClipRgn(Canvas.Handle, oldRgn)<=0) then
    Rgn := CreateRectRgnIndirect(CRect)
  else
    begin
      Result := oldRgn;
      Rgn := CreateRectRgnIndirect(CRect);
      CombineRgn(Rgn, Rgn, oldRgn,RGN_AND);
    end;
  SelectClipRgn(Canvas.Handle, Rgn);
  DeleteObject(Rgn);
end;

{--------------------------- public -------------------------------------------}
constructor TLMDSectionBarView.Create(AOwner: TPersistent);
begin

  inherited Create(nil);

  ControlStyle := ControlStyle+[csAcceptsControls];

  FScrolling := False;
  FTimer := TTimer.Create(nil);
  FTimer.Enabled := False;
  FTimer.OnTimer := OnTimer;

  FItems := TLMDSectionBarItems.Create(AOwner, self);

  FScrollUpBtn   := TLMDSectionScrollButton.Create;
  FScrollUpBtn.OnClick := OnUpScrollButton;
  FScrollDownBtn := TLMDSectionScrollButton.Create;
  FScrollDownBtn.OnClick := OnDownScrollButton;

  Color  := clBtnFace;

  FLargeChangeLink := TChangeLink.Create;
  FLargeChangeLink.OnChange := ImageListChange;
  FSmallChangeLink := TChangeLink.Create;
  FSmallChangeLink.OnChange := ImageListChange;

  FViewStyle := lvsLargeImages;
  FSelected    := nil;
  FRectPos := 0;
  IsDown   := False;
  IsDraging:= False;
  FDragPlace := -1;
  FDownItem:= nil;
  DoubleBuffered := True;
  Font.Color := clWhite;
  Width := 50;
  Height:= 100;
  FAllowDown := False;
  //FMultiselect := false;
  FAllowAllUp  := false;
end;

{------------------------------------------------------------------------------}
destructor TLMDSectionBarView.Destroy;
begin
  FTimer.Free;
  FScrollUpBtn.Free;
  FScrollDownBtn.Free;
  FItems.Free;
  LargeImages := nil;
  SmallImages := nil;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarView.CheckUpdate: Boolean;
begin
  Result := (Parent<>nil) and (Parent.Parent<>nil);
  if Result then
    Result := not (csLoading in Parent.Parent.ComponentState);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.ScrollInView(Item: TLMDSectionBarItem);
var
  aRect, CRect:TRect;
begin
  if (not Visible) or IsItemVisible(Item) then exit;
  aRect:=GetItemRect(Item);
  if (FRectPos>aRect.Bottom) then
    Scroll(aRect.Top, false)
  else
    begin
      cRect:=GetClientRect;
      AdjustClientRect(CRect);
      Scroll(aRect.Top-cRect.Bottom+ItemHeight, false)
    end;
  CheckScrollVisible;

end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarView.SetParentInterface(Intf: TLMDBarParentControlInterface);
begin
  FParentInterface := Intf;
end;

{******************** TLMDSectionBarTheme *************************************}
{--------------------------- private ------------------------------------------}
function TLMDSectionBarTheme.GetBitmap:TBitmap;
begin
  if FScrollBmp.Empty then
    result:=LMDBarCommmonScrollBmp
  else
    result:=FScrollBmp;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarTheme.GetColor(const Index:Integer):TColor;
begin
  case index of
    0: result:=FButtonBackground;
    1: result:=FButtonHighlightTextColor;
    2: result:=FButtonTextColor;
    3: result:=FDisableTextColor;
    4: result:=FHighlightTextColor;
    5: result:=FItemDownBackGround;
    6: result:=FItemBorderBlack;
    7: result:=FItemBorderLight;
    8: result:=FItemDragBackground;
    9: result:=FItemDragBorder;
   10: result:=FItemSelectedBackground;
   11: result:=FListViewBackground;
   12: result:=FSectionSpaceColor;
   13: result:=FTextColor;
  else
    result:=clNone;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarTheme.GetInteger(Index:Integer): Integer;
begin
  case Index of
    0: result:=FCaptionSpace;
    1: result:=FDragSpace;
    2: result:=FImageSpace;
    3: result:=FItemsSpace;
    4: result:=FScrollStep;
  else
    result:=0;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarTheme.SetColor(const Index:Integer; const Value: TColor);
begin
  case Index of
    0: if FButtonBackground<>Value then FButtonBackground:=Value else exit;
    1: if FButtonHighlightTextColor<>Value then FButtonHighlightTextColor:=Value else exit;
    2: if FButtonTextColor<>Value then FButtonTextColor:=Value else exit;
    3: if FDisableTextColor<>Value then FDisableTextColor:=Value else exit;
    4: if FHighlightTextColor<>Value then FHighlightTextColor:=Value else exit;
    5: if FItemDownBackGround<>Value then FItemDownBackGround:=Value else exit;
    6: if FItemBorderBlack<>Value then FItemBorderBlack:=Value else exit;
    7: if FItemBorderLight<>Value then FItemBorderLight:=Value else exit;
    8: if FItemDragBackground<>Value then FItemDragBackground:=Value else exit;
    9: if FItemDragBorder<>Value then FItemDragBorder:=Value else exit;
   10: if FItemSelectedBackground<>Value then FItemSelectedBackground:=Value else exit;
   11: if FListViewBackground<>Value then FListViewBackground:=Value else exit;
   12: if FSectionSpaceColor<>Value then FSectionSpaceColor:=Value else exit;
   13: if FTextColor<>Value then FTextColor:=Value else exit;
  else
    ;
  end;
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarTheme.SetScrollBmp(const Value: TBitmap);
begin
  FScrollBmp.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarTheme.SetInteger(Index:Integer; const Value: Integer);
begin
  case Index of
    0: if Value<>FCaptionSpace then FCaptionSpace:=Value else exit;
    1: if Value<>FDragSpace then FDragSpace:=Value else exit;
    2: if Value<>FImageSpace then FImageSpace:=Value else exit;
    3: if Value<>FItemsSpace then FItemsSpace:=Value else exit;
    4: if Value<>FScrollStep then FScrollStep:=Value else exit;
  end;
  Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarTheme.SetSelectionStyle(const Value: TLMDSectionBarSelectionStyle);
begin
  if FSelectionStyle<>Value then
    begin
      FSelectionStyle:=Value;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarTheme.SetSectionSpace(const Value: Integer);
begin
  if FSectionSpace<>Value then
    begin
      FSectionSpace := Value;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarTheme.SetSectionMinHeight(const Value: Integer);
begin
  if FSectionHeight<>Value then
    begin
      FSectionHeight := Value;
      Change;
    end;
end;

{--------------------------- public -------------------------------------------}
constructor TLMDSectionBarTheme.Create(Owner: TPersistent);
begin
  inherited;
  FCaptionSpace:=defLMD_CAPTIONGAP;
  FDragSpace:=defLMD_DRAGSPACE;
  FImageSpace:=defLMD_IMAGEGAP;
  FItemsSpace:=defLMD_ITEMSGAP;
  FSectionSpace:=defLMD_SECTIONSPACE;
  FScrollStep:=defLMD_SCROLLSIZE;
  FTextColor := LSB_TEXTCOLOR;

  FButtonBackground := LSB_BUTTON_BACK;
  FButtonHighlightTextColor := clBlue;
  FButtonTextColor := clBlack;
  FDisableTextColor := LSB_DISABLETEXT;
  FHighlightTextColor := LSB_HIGHLIGHTEXT;
  FItemDownBackGround := LSB_ITEMDOWNBACKGROUND;
  FItemBorderBlack := LSB_IBORDERBLACK;
  FItemBorderLight := LSB_IBORDERLIGHT;
  FItemDragBackground := LSB_ITEMDRAGBACKGROUND;
  FItemDragBorder := LSB_ITEMDRAGBORDER;
  FItemSelectedBackground := LSB_ITEMSELECTEDBACKGROUND;
  FListViewBackground := LSB_LISTVIEW_BACK;
  FSectionSpaceColor := clSilver;

  FScrollBmp := TBitmap.Create;
  FScrollBmp.OnChange:=GetChange;
  FScrollBmp.TransparentMode := tmAuto;
  FScrollBmp.Transparent := True;
  FSelectionStyle := lssFull;
end;

{------------------------------------------------------------------------------}
destructor TLMDSectionBarTheme.Destroy;
begin
  FScrollBmp.OnChange:=nil;
  FScrollBmp.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarTheme.Assign(Src: TPersistent);
begin
  if (Src is TLMDSectionBarTheme) then
    begin
      if Src=self then exit;
      with TLMDSectionBarTheme(Src) do
        begin
          FScrollBmp.Assign(ScrollBmp);
          FTextColor := TextColor;
          FHighlightTextColor := HighlightTextColor;
          FDisableTextColor := DisableTextColor;
          FItemBorderLight := ItemBorderLight;
          FItemBorderBlack := ItemBorderBlack;
          FItemSelectedBackground := ItemSelectedBackground;
          FItemDownBackGround := ItemDownBackGround;
          FItemDragBackground := ItemDragBackground;
          FItemDragBorder := ItemDragBorder;
          FListViewBackground := ViewBackground;
          FButtonBackground := ButtonBackground;
          FButtonHighlightTextColor := ButtonHighlightTextColor;
          FSectionSpaceColor := ButtonSpaceColor;
          FSectionHeight  := ButtonMinHeight;
          FSectionSpace:=ButtonSpace;
          FButtonTextColor := ButtonTextColor;
          FCaptionSpace:=CaptionSpace;
          FDragSpace:=DragSpace;
          FImageSpace:=ImageSpace;
          FItemsSpace:=ItemsSpace;
          FScrollStep:=ScrollStep;
          FSelectionStyle:=SelectionStyle;
        end;
    end
  else
    inherited;
end;

{******************** TLMDSectionBarThemeItem **********************************}
{--------------------------- private ------------------------------------------}
procedure TLMDSectionBarThemeItem.SetName(const Value: String);
begin
  if (FName<>Value) then
    FName := TLMDSectionBarThemeItems(GetOwner).ValidateName(Value, FName);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarThemeItem.SetTheme(const Value: TLMDSectionBarTheme);
begin
  FTheme.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarThemeItem.GetChange(Sender:TObject);
begin
  if Assigned(Collection) and Assigned(TLMDSectionBarThemeItems(Collection).Controller) then
    TLMDSectionBarThemeItems(Collection).Controller.UpdateParent(Index);
end;

{-------------------------- protected -----------------------------------------}
function TLMDSectionBarThemeItem.GetDisplayName: string;
begin
  result:=FName +' ('+self.ClassName+')';
end;

{--------------------------- public -------------------------------------------}
constructor TLMDSectionBarThemeItem.Create(Collection: TCollection);
begin
  inherited;
  FTheme:=TLMDSectionBarTheme.Create(Self);
  FTheme.OnChange:=GetChange;
  FName := TLMDSectionBarThemeItems(Collection).GetThemeItemName;
end;

{------------------------------------------------------------------------------}
destructor TLMDSectionBarThemeItem.Destroy;
begin
  FTheme.OnChange:=nil;
  FreeAndNil(FTheme);
  inherited;
end;

{******************** TLMDSectionBarThemeItems ********************************}
{--------------------------- private ------------------------------------------}
function TLMDSectionBarThemeItems.GetController:TLMDSectionBarController;
begin
  result:=TLMDSectionBarController(Owner);
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarThemeItems.GetItemByName(Value: String): TLMDSectionBarThemeItem;
var
  i : Integer;
begin
  Result := nil;
  for i:=0 to Count-1 do
    if Items[i].Name=Value then
      begin
        Result := Items[i];
        break;
      end;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarThemeItems.GetItems(Index: Integer): TLMDSectionBarThemeItem;
begin
  Result:=TLMDSectionBarThemeItem(inherited Items[Index]);
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarThemeItems.Add: TLMDSectionBarThemeItem;
begin
  Result := TLMDSectionBarThemeItem(inherited Add);
end;

{-------------------------- protected -----------------------------------------}
function TLMDSectionBarThemeItems.GetThemeItemName: String;
var
  i : Integer;
begin
  i := 1;
  repeat
    Result := 'Theme'+IntToStr(i);
    inc(i);
  until ItemByName[Result]=nil;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarThemeItems.ValidateName(const NewName: String; const oldName:String=''): String;
begin
  Result := NewName;
  if ItemByName[NewName]<>nil then
    if oldName<>'' then
      Result:=oldname
    else
      Result:=GetThemeItemName;
end;

{--------------------------- public -------------------------------------------}
constructor TLMDSectionBarThemeItems.Create(Owner: TComponent);
begin
  inherited Create(Owner,TLMDSectionBarThemeItem);
end;

{******************** TLMDSectionBarController ********************************}
{--------------------------- private ------------------------------------------}
procedure TLMDSectionBarController.SetThemes(const Value: TLMDSectionBarThemeItems);
begin
  FThemes.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarController.SetIndex(const Value: Integer);
begin
  if (Value<>FIndex) and (Value>-1) and (Value<FThemes.Count) then
    begin
      FIndex := Value;
      UpdateParent(FIndex);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarController.GetTheme: TLMDSectionBarTheme;
begin
  result:=nil;
  if FIndex<FThemes.Count then
    result:=FThemes[Findex].Theme;
end;

{--------------------------- public -------------------------------------------}
constructor TLMDSectionBarController.Create(AOwner: TComponent);
begin
  inherited;
  FThemes := TLMDSectionBarThemeItems.Create(Self);
end;

{------------------------------------------------------------------------------}
destructor TLMDSectionBarController.Destroy;
begin
  FThemes.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarController.UpdateParent(UpdateIndex:Integer=0);
begin
  if not ((csLoading in ComponentState) or (csDestroying in ComponentState)) then
    if UpdateIndex=FIndex then
      UpdateParentControls;
end;

{******************** TLMDSectionBarSectionPanel ******************************}
{--------------------------- private ------------------------------------------}
function TLMDSectionBarSectionPanel.GetIndex: Integer;
begin
  FIndex := FSection.Index;
  Result := FIndex;
end;

{-------------------------- protected -----------------------------------------}
procedure TLMDSectionBarSectionPanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSectionPanel.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('Data',ReadData,WriteData, True);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSectionPanel.ReadData(Stream: TStream);
begin
  Stream.ReadBuffer(FIndex, SizeOf(FIndex));
  end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSectionPanel.WriteData(Stream: TStream);
begin
  Index;
  Stream.WriteBuffer(FIndex, SizeOf(FIndex));
  end;

{--------------------------- public -------------------------------------------}
constructor TLMDSectionBarSectionPanel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption];
  inherited Caption:='';
  FAutoCreated := False;
  FDoubleBuffered := True;
end;

{------------------------------------------------------------------------------}
destructor TLMDSectionBarSectionPanel.Destroy;
begin
  if FSection<>nil then
    begin
      FSection.FPanel:=nil;
      FSection.Free;
    end;
  inherited;
end;

{*********************** TLMDBarSectionItem ***********************************}
{---------------------------- protected ---------------------------------------}

{------------------------------------------------------------------------------}
function TLMDSectionBarSection.GetIndex(Index:Integer): Integer;
var
  tmp:TLMDSectionBarItem;
begin
 result:=-1;
 case Index of
   0: begin
        tmp:=FView.Selected;
        if tmp<>nil then result:=tmp.Index;
      end;
   1: begin
        tmp:=FView.Pressed;
        if tmp<>nil then result:=tmp.Index;
      end;
 end;

end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSection.GetSections: TLMDSectionBarSections;
begin
  Result := TLMDSectionBarSections(Collection);
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSection.GetItem(Index:Integer): TLMDSectionBarItem;
begin
  case Index of
    0: result:=FView.Selected;
    1: result:=FView.Pressed;
  else
    result:=nil;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSection.GetFont: TFont;
begin
  result:=FView.Font;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSection.GetItems: TLMDSectionBarItems;
begin
  Result := FView.Items;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSection.GetReadOnly: Boolean;
begin
 result:=FView.ReadOnly;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSection.GetImageList(Index:Integer): TCustomImageList;
begin
  case index of
    0: Result := FView.SmallImages;
    1: Result := FView.LargeImages;
  else
    result:=nil;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSection.GetListView: TLMDSectionBarView;
begin
  Result := FView;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSection.GetViewStyle: TLMDSectionBarViewStyle;
begin
  result:=FView.ViewStyle;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSection.GetDownState: Boolean;
begin
  result:=FView.AllowDown;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSection.GetCaptionRect(Item: TLMDSectionBarItem): TRect;
begin
  result:=FView.CaptionRect[Item];
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSection.GetImageRect(Item: TLMDSectionBarItem): TRect;
begin
  result:=FView.ImageRect[Item];
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSection.GetItemAtPos(X, Y: Integer): TLMDSectionBarItem;
begin
  result:=FView.ItemAtPos[x,y];
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSection.GetItemRect(Item: TLMDSectionBarItem): TRect;
begin
  result:=FView.ItemRect[item];
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSection.GetItemsHeight: Integer;
begin
  result:=FView.ItemHeight;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSection.IsCustomCaption:Boolean;
begin
  result:=FCaption<>IDS_BAR_NEWSECTION;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.SetCaption(const Value: String);
begin
  SetCaptionEx(Value, False);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.SetItemIndex(const Index, Value: Integer);
begin
  if (Value<0) or (Value>=FView.Items.Count) then
    FView.Pressed:=nil
  else
    FView.Pressed:=FView.Items[Value];
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.SetItem(const Index: Integer; const Value: TLMDSectionBarItem);
begin
  FView.Pressed:=Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.SetDownState(const Value: Boolean);
begin
  FView.AllowDown:=Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.SetHint(const Value: String);
begin
  FHint := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.SetViewStyle(const Value: TLMDSectionBarViewStyle);
begin
  if Value<>FView.ViewStyle then
    begin
      FView.ViewStyle:=Value;
      if Sections.FSectionBar<>nil then
       TLMDCustomSectionBar(Sections.FSectionBar).CancelEditMode;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.SetImageList(Index:Integer; const Value: TCustomImageList);
begin
  case index of
    0: begin
         if FView.SmallImages<>nil then
           FView.SmallImages.RemoveFreeNotification(TComponent(TLMDSectionBarSections(Collection).Owner));
         FView.SmallImages := Value;
         if Value<>nil then
           Value.FreeNotification(TComponent(TLMDSectionBarSections(Collection).Owner));
       end;
    1: begin
         if FView.LargeImages<>nil then
           FView.LargeImages.RemoveFreeNotification(TComponent(TLMDSectionBarSections(Collection).Owner));
         FView.LargeImages := Value;
         if Value<>nil then
           Value.FreeNotification(TComponent(TLMDSectionBarSections(Collection).Owner));
       end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.SetItems(const Value: TLMDSectionBarItems);
begin
  FView.Items := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.SetFont(const Value: TFont);
begin
  FView.Font:=Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.SetName(const Value: String);
begin
  if (FName<>Value) then
    FName := TLMDSectionBarSections(GetOwner).ValidateName(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.SetReadOnly(const Value: Boolean);
begin
  FView.ReadOnly:=Value;
end;

{-------------------------- protected -----------------------------------------}
function TLMDSectionBarSection.GetDisplayName: string;
begin
  result:=FName+' ('+ClassName+')';
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.CreateListView;
begin
  FView := TLMDSectionBarView.Create(self);

  FView.Align := alClient;
  FView.ViewStyle := lvsSmallImages;
  FView.AllowDown := True;

  FView.OnItemSelect := Sections.DoItemEvent;
  FView.OnDrawItem := Sections.OnLVDrawItem;
  FView.OnDrawBackground := Sections.OnLVDrawBackground;
  FView.OnDragOver:=Sections.OnDragOver;
  FView.OnDragDrop:=Sections.OnDragDrop;

  if Sections.FSectionBar<>nil then
    FView.SetParentInterface(TLMDCustomSectionBar(Sections.FSectionBar));
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.Initialize;
begin
  Items.InitiateActions;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.Notification(AComponent: TComponent; Operation: TOperation);
var
  i:Integer;
begin
  if (Operation = opRemove) then
   begin
     if (AComponent is TImageList) then
       begin
         if AComponent=SmallImages then SmallImages:=nil;
         if AComponent=LargeImages then LargeImages:=nil;
       end;
     if (AComponent is TBasicAction) then
       for i:=0 to Items.Count-1 do
        Items[i].Notification(AComponent, Operation);
   end;
end;

{--------------------------- public -------------------------------------------}
constructor TLMDSectionBarSection.Create(Collection: TCollection);
begin
  if Assigned(Collection) then
    begin
      Collection.BeginUpdate;
      FName := TLMDSectionBarSections(Collection).GetSectionName;
    end;

  inherited;
  FPanel := TLMDSectionBarSectionPanel.Create(nil);
  with FPanel do
    begin
      FAutoCreated := True;
      FSection     := Self;
      BevelInner := bvNone;
      BevelOuter := bvNone;
      Visible := False;
      Parent := nil;
      Width  := 0;
      Height := 0;
    end;
  Caption := IDS_BAR_NEWSECTION;
  CreateListView;
  if Assigned(Collection) then
    Collection.EndUpdate;
  Changed(False);
end;

{------------------------------------------------------------------------------}
destructor TLMDSectionBarSection.Destroy;
begin
  if FView<>nil then
    begin
      FView.Free;
      FView := nil;
    end;
  if FPanel<>nil then
    begin
      FPanel.FSection := nil;
      FPanel.Free;
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.Activate(SectionBar: TLMDBaseCustomControl);
begin
  if Assigned(FPanel) then
    begin
      FPanel.Parent := SectionBar;
      FView.Parent:=FPanel;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.Assign(Source: TPersistent);
begin
  if Source=self then exit;
  if Source is TLMDSectionBarSection then
    with TLMDSectionBarSection(Source) do
      begin
        self.FCaption := Caption;
        self.FHint    := Hint;
        self.FTag     := Tag;
        self.Items    := Items;
        self.Font     := Font;
        self.FView.AllowDown:=AllowDown;
        self.FView.ViewStyle:=ViewStyle;
        self.SetImageList(0, SmallImages);
        self.SetImageList(1, LargeImages);
        exit;
      end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.Deactivate(SectionBar: TLMDBaseCustomControl);
begin
  if Assigned(FPanel) then
    begin
      FPanel.Visible := False;
      FPanel.Parent := nil;
      FView.Parent:=nil;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.SetCaptionEx(const Value: String; bEvents:Boolean);
var
  i : Integer;
  szTmp : String;
  b     : Boolean;
begin
  if FCaption=Value then
    exit;
  szTmp := Value;
  // happens only when at designtime
  if not bEvents then
    begin
      i := 0;
      while(Sections.CheckCaption(szTmp)) do
        begin
          Inc(i);
          szTmp := Value+IntToStr(i);
        end;
    end;
  if (Sections.FSectionBar<>nil) then
    if bEvents and Assigned(TLMDSectionBar(Sections.FSectionBar).OnSectionCaptionChanging) then
      begin
        TLMDSectionBar(Sections.FSectionBar).OnSectionCaptionChanging(Sections.FSectionBar, Index, szTmp,b);
        if b then exit;
      end;
  FCaption := szTmp;
  if (Sections.FSectionBar<>nil) then
    begin
      if bEvents and Assigned(TLMDSectionBar(Sections.FSectionBar).OnSectionCaptionChange) then
        TLMDSectionBar(Sections.FSectionBar).OnSectionCaptionChange(Sections.FSectionBar, Index);
      TLMDSectionBar(Sections.FSectionBar).InvalidateSectionButton(Index);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSection.IsItemVisible(Item: TLMDSectionBarItem): Boolean;
begin
  result:=FView.IsItemVisible(Item);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSection.ScrollInView(Item: TLMDSectionBarItem);
begin
  FView.ScrollInView(Item);
end;

{************************** TLMDBarSections ***********************************}
{----------------------------- private ----------------------------------------}
function TLMDSectionBarSections.GetSection(Index: Integer): TLMDSectionBarSection;
begin
  Result:=nil;
  if Index>Count-1 then exit;
  Result := TLMDSectionBarSection(inherited Items[Index]);
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSections.GetSectionByName(Value: String): TLMDSectionBarSection;
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
procedure TLMDSectionBarSections.DoItemEvent(Sender: TObject; Reason:TLMDSectionBarItemEventType; Item:TObject);
begin
  if FSectionBar<>nil then
    TLMDCustomSectionBar(FSectionBar).DoItemEvents(Sender, Reason, Item);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSections.OnLVDrawBackground(Sender: TObject; Canvas: TCanvas; Rect: TRect; var Done: Boolean);
begin
  if FSectionBar<>nil then
    TLMDCustomSectionBar(FSectionBar).DoDrawBackground(Sender,Canvas,Rect,Done);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSections.OnLVDrawItem(Sender: TObject; Canvas: TCanvas; Rect: TRect; Item: TLMDSectionBarItem; var Done: Boolean);
begin
  if FSectionBar<>nil then
    TLMDCustomSectionBar(FSectionBar).DoDrawItem(Sender,Canvas,Rect,Item,Done);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSections.OnDragOver(Source:TObject;X,Y:Integer; State:TDragState;var Accept:Boolean; var Complete : Boolean);
begin
  if FSectionBar<>nil then
    TLMDCustomSectionBar(FSectionBar).DragOver(Source, x, y, State, Accept);
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSections.OnDragDrop(Sender, Target: TObject; X, Y: Integer);
begin
  if (FSectionBar<>nil) and Assigned(TLMDCustomSectionBar(FSectionBar).OnDragDrop) then
    if Target is TLMDSectionBarView then
      TLMDCustomSectionBar(FSectionBar).OnDragDrop(TLMDCustomSectionBar(FSectionBar).FindSectionByView(TLMDSectionBarView(Sender)),
                                                   TLMDCustomSectionBar(FSectionBar).FindSectionByView(TLMDSectionBarView(Target)), x, y)
  else
    TLMDCustomSectionBar(FSectionBar).OnDragDrop(Sender, Target, X,Y)
end;

{-------------------------- protected -----------------------------------------}
procedure TLMDSectionBarSections.BeginUpdate;
begin
  inherited;
  FUpdating:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSections.EndUpdate;
begin
  FUpdating:=False;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSections.Update(Item: TCollectionItem);
begin
  inherited;
  if (FSectionBar<>nil) and (not FUpdating) then
    begin
      if Item<>nil then
        TLMDCustomSectionBar(FSectionBar).UpdateSection(Item.Index)
      else
        TLMDCustomSectionBar(FSectionBar).UpdateSection(-1);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSections.Initialize;
var
  i:Integer;
begin
  for i:=0 to Count-1 do
    Section[i].Initialize;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSections.ValidateName(NewName: String): String;
begin
  Result := NewName;
  if SectionByName[NewName]<>nil then
    Result := GetSectionName;
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSections.GetSectionName: String;
var
  i : Integer;
begin
  i := 1;
  repeat
    Result := 'Section'+IntToStr(i);
    inc(i);
  until SectionByName[Result]=nil;
end;

{--------------------------- public -------------------------------------------}
constructor TLMDSectionBarSections.Create;
begin
  inherited Create(Owner, TLMDSectionBarSection);
  if Owner is TLMDCustomSectionBar then
    FSectionBar:=Owner as TLMDCustomSectionBar
  else
    FSectionBar:=nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDSectionBarSections.Destroy;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSections.Assign(Source: TPersistent);
begin
  if Source=self then exit;
  try
    BeginUpdate;
    inherited;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSections.Activate(SectionBar: TLMDBaseCustomControl);
var
  i : Integer;
begin
  if(FSectionBar<>nil) and (FSectionBar<>SectionBar) then
    begin
      if TLMDSectionBar(FSectionBar).ActiveSections=Self then
        TLMDSectionBar(FSectionBar).SectionStorage:=nil;
    end;
  FSectionBar := SectionBar;
  for i:=0 to Count-1 do
    Section[i].Activate(FSectionBar);
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSections.Add: TLMDSectionBarSection;
begin
  Result := TLMDSectionBarSection(inherited Add);
end;

{------------------------------------------------------------------------------}
function TLMDSectionBarSections.CheckCaption(szName: String): Boolean;
var
  i : Integer;
begin
  Result := False;
  for i:=0 to Count-1 do
    begin
      Result := Section[i].Caption=szName;
      if Result then
        break;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSectionBarSections.Deactivate;
var
  i : Integer;
begin
  for i:=0 to Count-1 do
    Section[i].Deactivate(FSectionBar);
  FSectionBar := nil;
end;

{******************** TLMDBarSectionStorage ***********************************}
{--------------------------- private ------------------------------------------}
procedure TLMDSectionBarStorage.SetSections(const Value: TLMDSectionBarSections);
begin
  FSections.Assign(Value);
end;

{-------------------------- protected -----------------------------------------}
procedure TLMDSectionBarStorage.Notification(AComponent: TComponent; Operation: TOperation);
var
  i:Integer;
begin
  if (Operation = opRemove) and (AComponent <> nil)  then
    begin
      if (AComponent is TImageList) or (AComponent is TBasicAction) then
        for i:=0 to FSections.Count-1 do
          FSections[i].Notification(AComponent,Operation);
    end;
  inherited;
end;

{--------------------------- public -------------------------------------------}
constructor TLMDSectionBarStorage.Create(AOwner: TComponent);
begin
  inherited;
  FSections:=TLMDSectionBarSections.Create(Self);
end;

{------------------------------------------------------------------------------}
destructor TLMDSectionBarStorage.Destroy;
begin
  FSections.Free;
  inherited;
end;

{******************** TLMDCustomSectionBar ************************************}
{--------------------------- private ------------------------------------------}
function TLMDCustomSectionBar.GetActiveSection: TLMDSectionBarSection;
begin
  Result := nil;
  if not Assigned(ActiveSections) then exit;
  if FActiveSectionIndex<>-1 then
    Result := ActiveSections[ActiveSectionIndex];
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.GetTheme: TLMDObject;
begin
  if FThemeController<>nil then
    begin
      Result := FThemeController.ActiveTheme;
      If Assigned(result) then exit;
    end;
  Result := FTheme;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.GetInternalSectionIndex(const Value:Integer):Integer;
begin
  if Value=-1 then result:=ActiveSectionIndex else result:=Value;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.IsNoStorage:Boolean;
begin
  result:=FSectionStorage=nil;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.IsNoCustomTheme:Boolean;
begin
  result:=not (Assigned(FThemeController) and (FThemeController.Themes.Count>0));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.DoItemEvents(Sender: TObject; Reason:TLMDSectionBarItemEventType; Item:TObject);
begin
  if Reason in [istClick, istItemClick] then
    CancelEditMode;

  case Reason of
    istGeneral:
      if Assigned(FOnSelect) then
        FOnSelect(Self, FindSectionByView(TLMDSectionBarView(Sender)), TLMDSectionBarItem(Item));
    istItemSelect:
       if Item=nil then
         Click
       else
         if Assigned(FOnItemSelect) then
          FOnItemSelect(Self, FindSectionByView(TLMDSectionBarView(Sender)),TLMDSectionBarItem(Item));
    istItemUnSelect:
      if Assigned(FOnItemUnSelect) then
        FOnItemUnSelect(Self, FindSectionByView(TLMDSectionBarView(Sender)),TLMDSectionBarItem(Item));
    istItemClick:
      if Assigned(FOnItemClick) then
        FOnItemClick(Self, FindSectionByView(TLMDSectionBarView(Sender)),TLMDSectionBarItem(Item));
    istClick:
      Click;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.DoDrawBackground(Sender: TObject; Canvas: TCanvas; Rect: TRect; var Done: Boolean);
var
  tmp:Integer;
  tmps:TLMDSectionBarSection;
begin
  if Assigned(FOnSectionDrawBackground) then
    begin
      tmps:=FindSectionByView(TLMDSectionBarView(Sender));
      if Assigned(tmps) then tmp:=tmps.Index else tmp:=-1;
      FOnSectionDrawBackground(Self,Canvas,Rect,tmp,Done);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.DoDrawItem(Sender: TObject; Canvas: TCanvas; Rect: TRect; Item: TLMDSectionBarItem; var Done: Boolean);
var
  tmp, tmpi:Integer;
  tmps:TLMDSectionBarSection;
begin
  tmp:=-1;
  tmpi:=-1;
  if Assigned(FOnItemDraw) then
    begin
      tmps:=FindSectionByView(TLMDSectionBarView(Sender));
      if Assigned(tmps) then tmp:=tmps.Index;
      if Assigned(Item) then tmpi:=Item.Index;
      FOnItemDraw(Self,Canvas,Rect,tmp,tmpi,Done);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.SetActiveSectionIndex(const Value: Integer);
var
  NewRect:TRect;
  NewRect1:TRect;
  OldRect:TRect;
  ScrollRect:TRect;
  Section:TLMDSectionBarSection;
  Height:Integer;
  Width:Integer;
  Height1:Integer;
  Width1:Integer;
  Step:Double;
  NewSectionPos:Integer;
  OldActiveSection:TLMDSectionBarSection;
  tmp,
  IsForward:Boolean;
  I:Integer;

  procedure Init;
  begin
    if OldRect.Top<NewRect.Top then
      begin
        ScrollRect:=OldRect;
        ScrollRect.Top:=OldRect.Top;
        ScrollRect.Bottom:=NewRect.Bottom;
        if IsForward then
          NewSectionPos:=NewRect.Bottom-1
        else
          NewSectionPos:=NewRect.Top;
      end
    else
      begin
        ScrollRect:=NewRect;
        ScrollRect.Top:=NewRect.Top;
        ScrollRect.Bottom:=OldRect.Bottom;
        if IsForward then
          NewSectionPos:=OldRect.Bottom-1
        else
          NewSectionPos:=OldRect.Top;
      end;

    if ScrollFrequency<>0 Then
      Step:=Height/FScrollFrequency;
  end;

var
  ScreenDC,
  MemDC:THandle;
  hBitmap:THandle;
  ScrollWidth:Integer;
  ScrollHeight:Integer;
  iStep:Integer;
begin
  tmp:=false;

  if FActiveSectionIndex=Value then exit;

  if not (csLoading in ComponentState) then
    if Assigned(FOnSectionBeforeChange) then
      begin
        FOnSectionBeforeChange(self, Value, tmp);
        if tmp then exit;
      end;

  if (Value=-1) then
    begin
      if ActiveSections.Count=0 then
        begin
          FActiveSectionIndex := -1;
          Invalidate;
        end;
      exit;
    end;

  if (Value<-1) or (Value>=ActiveSections.Count) then exit;

  if FActiveSectionIndex=-1 then
    OldActiveSection:=nil
  else
    if FActiveSectionIndex<ActiveSections.Count then
      OldActiveSection:=ActiveSections[FActiveSectionIndex]
    else
      OldActiveSection:=nil;
  IsForward:=FActiveSectionIndex<Value;
  OldRect:=GetSectionRect;
  if Value<ActiveSections.Count then
    begin
      if Value>=-1 then
        FActiveSectionIndex := Value
      else
        if ActiveSections.Count>0 then
          FActiveSectionIndex := 0
        else
          FActiveSectionIndex := -1;
    end
  else
    FActiveSectionIndex := ActiveSections.Count-1;

  if not HandleAllocated or (csLoading in ComponentState) then
    exit;

  if CancelEditMode then exit;

  Section:=ActiveSections[Value];
  if Section.Panel=nil then exit;
  NewRect:=GetSectionRect(false);
  Height:=NewRect.Bottom-NewRect.Top;
  Width:=NewRect.Right-NewRect.Left;

  NewRect1:=GetSectionRect;
  Height1:=NewRect1.Bottom-NewRect1.Top;
  Width1:=NewRect1.Right-NewRect1.Left;
  try
    if FSingleSection or isUpdating or (csDesigning in ComponentState) or
       (FScrollFrequency<2) or (OldActiveSection=nil) or not Showing then
      begin
        SetWindowPos(Section.Panel.Handle,0,NewRect.Left,NewRect.Top,Width,Height,SWP_NOACTIVATE);
        Section.Panel.Show;
        Paint;
        exit;
      end;
    Init;
    ScreenDC:=GetDC(0);
    MemDC:=CreateCompatibleDC(ScreenDC);
    ScrollWidth:=ScrollRect.Right-ScrollRect.Left;
    ScrollHeight:=ScrollRect.Bottom-ScrollRect.Top;
    hBitmap:=CreateCompatibleBitmap(ScreenDC,ScrollWidth,
                                    ScrollHeight+Height1);
    SelectObject(MemDC,hBitmap);

    try
      SetWindowPos(Section.Panel.Handle,0,NewRect1.Left+GetSystemMetrics(SM_CXSCREEN),NewRect1.Top,Width1,Height1,SWP_NOACTIVATE);
      Section.Panel.Show;
      if IsForward then
      begin
        BitBlt(MemDC,0,0,ScrollWidth,ScrollHeight,
               Canvas.Handle,ScrollRect.Left,ScrollRect.Top,SRCCOPY);
        Section.Panel.PaintTo(MemDC,0,ScrollHeight)
      end
      else
      begin
        BitBlt(MemDC,0,NewRect.Bottom-NewRect.Top,ScrollWidth,ScrollHeight,
               Canvas.Handle,ScrollRect.Left,ScrollRect.Top,SRCCOPY);
        Section.Panel.PaintTo(MemDC,0,0);
      end;
//      SetWindowPos(Section.Panel.Handle,0,NewRect.Left,NewRect.Top,Width,Height,SWP_NOACTIVATE);
//      Section.Panel.Show;
      //PaintBorder(ScrollRect);
      for i:=0 to FScrollFrequency-1 do
        begin
          iStep:=Trunc(Step*I);
          Sleep(1);
          if IsForward then
              begin
                BitBlt(Canvas.Handle,ScrollRect.Left,OldRect.Bottom-iStep,ScrollWidth,NewRect.Bottom-OldRect.Bottom+iStep,
                       MemDC,0,Height,SRCCOPY);
              end
            else
              begin
                BitBlt(Canvas.Handle,ScrollRect.Left,ScrollRect.Top+iStep,ScrollWidth,ScrollHeight-iStep,
                       MemDC,0,Height,SRCCOPY);
                BitBlt(Canvas.Handle,ScrollRect.Left,ScrollRect.Top,ScrollWidth,iStep,
                       MemDC,0,0,SRCCOPY);
              end;
        end;
    finally
      DeleteObject(hBitmap);
      DeleteDC(MemDC);
      ReleaseDC(0,ScreenDC);
      Paint;
    end;
  finally
    if OldActiveSection<>nil then
      begin
        SetWindowPos(OldActiveSection.Panel.Handle,0,NewRect.Left,NewRect.Top,0,0,SWP_NOACTIVATE or SWP_FRAMECHANGED);
        OldActiveSection.Panel.Hide;
      end;
    SetWindowPos(Section.Panel.Handle,0,NewRect1.Left,NewRect1.Top,Width1,Height1,SWP_NOACTIVATE or SWP_FRAMECHANGED);
    Update;
    //PaintBorder(NewRect);
    if Assigned(FOnSectionChange) then
      FOnSectionChange(Self);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.SetCaptionAlignment(const Value: TAlignment);
begin
  FCaptionAlignment := Value;
  Invalidate;
end;

{------------------------------------------------------------------------------}
{procedure TLMDCustomSectionBar.SetCtlXP(const Value: Boolean);
begin
  FCtlXP := Value;
end;}

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.SetHotTrack(const Value: Boolean);
begin
  if FHotTrack<>Value then
    begin
      FHotTrack := Value;
      if not (csLoading in ComponentState) then
        Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.SetSections(const Value: TLMDSectionBarSections);
begin
  FSections.Assign(Value);
  GetThemeChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.SetSingleSection(const Value: Boolean);
begin
  FSingleSection := Value;
  if not (csLoading in ComponentState) then
    UpdateSection(-1);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.SetScrollFrequency(const Value: Integer);
begin
  FScrollFrequency := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.SetSectionStorage(const Value: TLMDSectionBarStorage);
var
  S : TLMDSectionBarSections;
begin
  S := GetActiveSections;
  if FSectionStorage <> Value then
    begin
      FActiveSectionIndex := 0;
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
procedure TLMDCustomSectionBar.SetTheme(const Value: TLMDSectionbarTheme);
begin
  FTheme.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.SetThemeController(const Value: TLMDSectionBarController);
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
      GetThemeChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.CMFontChanged (var Msg : TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    ArrangeSections;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomSectionBar.CMColorChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) and (BorderWidth>0) then
    RecreateWnd;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.CMUpdateLinkMessage(var Message: TMessage);
var
  aObject  : TObject;
  begin
  aObject := Pointer(Message.LParam);
  if aObject<>nil then
  begin
      if(aObject = FSectionStorage) then
      begin
          GetActiveSections.Deactivate;
          UpdateSectionStorage;
          GetActiveSections.Activate(Self);
        end
      else
      if(aObject = FThemeController) then
      GetThemeChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
   Message.Result := 1;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.WMSize(var Message: TWMSize);
begin
 inherited;
 CancelEditMode;
 UpdateSectionSize;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.WMTimer(var Msg: TWMTimer);
var
  Point : TPoint;
  Tmp   : Integer;
Begin
  GetCursorPos(Point);
  Point := ScreenToClient(Point);
  if GetSectionAt(Point.X, Point.Y)=-1 then
    begin
      Tmp := FHotSectionIndex;
      FHotSectionIndex := -1;
      PaintSectionButton(Tmp);
      KillTimer(Handle, Msg.TimerID);
      FTimerEnable := False;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.WMUpdateScroll(var Msg: TMessage);
begin
  if Msg.LParam=1 then
    begin
      PaintSectionButton(FActiveSectionIndex+1);
    end
  else
    begin
      PaintSectionButton(FActiveSectionIndex);
    end;
end;

{-------------------------- protected -----------------------------------------}
procedure TLMDCustomSectionBar.ArrangeSections;
begin
  UpdateSectionSize;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.Click;
begin
  inherited Click;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.ChangeSections(OldS, NewS: TLMDSectionBarSections);
begin
  if not HandleAllocated then
    exit;
  if OldS<>nil then
    OldS.Deactivate;
  if NewS<>nil then
    NewS.Activate(Self);
  ArrangeSections;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.CheckSectionIndex(SectionIndex:Integer; Activate:Boolean=true; effect:Boolean=false):Boolean;
begin
  if Assigned(ActiveSection) and (SectionIndex=-1) or (SectionIndex=ActiveSectionIndex) then
    begin
      result:=true;
      exit;
    end;
   if Activate then
     begin
       SectionActivate(SectionIndex, effect);
       result:=(SectionIndex=ActiveSectionIndex)
     end
   else
     // at least SectionIndex is a valid one
     result:=(SectionIndex>0) and (SectionIndex<ActiveSections.Count);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  SSection : Integer;
  tmp: TLMDSectionBarSection;
begin
  Accept := True;
  Accept:=Y<ClientHeight-1;

  // 7.01
  if Assigned(OnDragOver) then
    begin
      tmp:=FindSectionByView(TLMDSectionBarView(Source));
      if tmp=nil then
        OnDragOver(ActiveSection, Source, X,Y, State, Accept)
      else
        OnDragOver(ActiveSection, tmp, X,Y, State, Accept);
    end;
  if not Accept then
    exit;
  SSection := GetSectionAt(X, Y);
  if FDragTimer.Enabled then
    begin
      if FDragSection<>SSection then
        begin
          FDragTimer.Enabled := False;
          FDragSection := SSection;
          if FDragSection<>-1 then
            FDragTimer.Enabled := True;
        end;
    end
  else
    if SSection <> -1 then
      begin
        FDragSection := SSection;
        FDragTimer.Enabled := True;
      end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.FindSectionByView(aView: TLMDSectionBarView): TLMDSectionBarSection;
var
  i : Integer;
begin
  Result := nil;
  if ActiveSections=nil then exit;
  for i:=0 to ActiveSections.Count-1 do
    begin
      if ActiveSections[i].View=aView then
        begin
          Result := ActiveSections[i];
          break;
        end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.GetActiveSectionIndex: Integer;
begin
  result:=-1;
  if not Assigned(ActiveSections) then exit;
  if FActiveSectionIndex>ActiveSections.Count-1 then
    FActiveSectionIndex:=ActiveSections.Count-1;
  result:=FActiveSectionIndex;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.GetActiveSections: TLMDSectionBarSections;
begin
  if (FSectionStorage<>nil) then
    Result := FSectionStorage.Sections
  else
    Result := FSections;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.GetSectionAt(X, Y: Integer): Integer;
var
  Rect : TRect;
  SectionRect : TRect;
Begin
  Result := -1 ;
  Rect := GetClientRect;

  SectionRect := GetSectionRect;
  if (X < Rect.Left) or (X > Rect.Right) then
    exit;
  if (Y < SectionRect.Top) and (Y > Rect.Top) then
    Result := (Y - Rect.Top) div GetSectionButtonHeight
  else
    if (Y > SectionRect.Bottom) and (Y < Rect.Bottom - 1) then
      begin
        Result := (Y - SectionRect.Bottom) div GetSectionButtonHeight;
        Inc (Result, FActiveSectionIndex + 1);
      end;
   if (Result=FActiveSectionIndex) or (Result=FActiveSectionIndex+1) then
     begin
       if (X > (Rect.Right-GetSectionButtonHeight-4)) then
         Result := -1;
     end;
   if Result>=GetActiveSections.Count then
     Result := -1;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.GetSectionButtonHeight: Integer;
begin
  with TLMDSectionBarTheme(GetTheme) do
    if ButtonMinHeight>FInternalFontHeight then
      Result:=ButtonMinHeight+ButtonSpace
    else
      Result :=FInternalFontHeight+ButtonSpace
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.GetSectionButtonRect(Index: Integer): TRect;
var
  GH : Integer;
  tmp:Integer;
begin
  if ActiveSections=nil then exit;

  if (Index>=0) and (Index<=ActiveSections.Count) then
    begin
      Result := GetClientRect;
      tmp:=TLMDSectionBarTheme(GetTheme).ButtonSpace;

      GH := GetSectionButtonHeight;
      if Index=ActiveSections.Count then
        begin
          if ActiveSectionIndex=ActiveSections.Count-1 then
            begin
              Result.Top := Result.Bottom-GH+tmp;
              Result.Bottom := Result.Top+GH-tmp;
            end
        end
      else
        if (FActiveSectionIndex=-1) or (Index<=FActiveSectionIndex) then
          begin
            Inc (Result.Top, Index * GH);
            Result.Bottom := Result.Top + GH-tmp;
          end
        else
          begin
            Result.Top := Result.Bottom - (ActiveSections.Count-Index)*GH+tmp;
            Result.Bottom := Result.Top+GH-tmp;
          end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.GetSectionRect(bCorrectLast:Boolean): TRect;
begin
  if ActiveSections=nil then exit;

  Result := GetClientRect;

  if (ActiveSections.Count>0) and (not FSingleSection) then
    begin
      if FActiveSectionIndex=-1 then
        Inc(Result.Top, (ActiveSections.Count)*GetSectionButtonHeight)
      else
        begin
          Inc (Result.Top, (FActiveSectionIndex+1)*GetSectionButtonHeight);
          Dec (Result.Bottom, (ActiveSections.Count-FActiveSectionIndex-1)*GetSectionButtonHeight);
          if FActiveSectionIndex<ActiveSections.Count-1 then
            Inc(Result.Bottom, TLMDSectionBarTheme(GetTheme).ButtonSpace);
          Dec(Result.Top, TLMDSectionBarTheme(GetTheme).ButtonSpace);
          if (FActiveSectionIndex=ActiveSections.Count-1) and bCorrectLast then
            begin
              Dec (Result.Bottom,GetSectionButtonHeight);
            end
        end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.GetUseXP: boolean;
begin
  Result := False;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.GetThemeChange(Sender:TObject);
begin
  if not (csLoading in ComponentState) then
    UpdateSectionSize;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_BAR;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.InvalidateSectionButton(Index: Integer);
var
  Rect : TRect;
begin
  Rect := GetSectionButtonRect(Index);
  Windows.InvalidateRect(Handle,@Rect, True);
  end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.Loaded;
begin
  inherited;
  if Sections.Count>0 then
    Sections.Initialize;
  GetActiveSections.Activate(Self);
  UpdateSectionSize;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  SSection : Integer;
begin
  inherited;
  if Button = mbLeft then
    begin
      SSection := GetSectionAt(X, Y);
      if SSection<>-1 then
        begin
          FDownSectionIndex := SSection;
          FButtonDown := not (csDesigning in ComponentState);
          PaintSectionButton(SSection);
        end
      else
        FButtonDown := False;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  SSection : Integer;
  Tmp : Integer;
begin

  inherited;

  SSection := GetSectionAt(X, Y);
  if (FCaptionEdit.ItemIndex=SSection) and FCaptionEdit.Visible then
    exit;
  if MouseCapture then
    begin
      If (FButtonDown and (SSection <> FDownSectionIndex)) or
         ((not FButtonDown) and (SSection = FDownSectionIndex)) and
         not (csDesigning in ComponentState) then
        begin
          FButtonDown := not FButtonDown;
          FHotSectionIndex := SSection;
          PaintSectionButton(FDownSectionIndex);
        end;
    end
  else
    begin
      if SSection<>-1 then
        if SSection<>FHotSectionIndex then
          begin
            if ShowHint then
              Application.CancelHint;
            Tmp := FHotSectionIndex;
            FHotSectionIndex := SSection;
            if FHotTrack then
              begin
                if not FTimerEnable then
                  begin
                    SetTimer(Handle, TLMDPtrInt(Self), 100, nil);
                    FTimerEnable:=True;
                  end;
                if Tmp<>-1 then
                  if not (FCaptionEdit.Visible and (FCaptionEdit.ItemIndex = Tmp)) then
                    PaintSectionButton (Tmp);
                if not (FCaptionEdit.Visible and (FCaptionEdit.ItemIndex = FHotSectionIndex)) then
                  PaintSectionButton(FHotSectionIndex);
              end;
            Hint := ActiveSections[FHotSectionIndex].Hint;
          end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  SSection : Integer;
  Tmp : Integer;
begin
  inherited;
  if Button = mbLeft then
    begin
      Tmp := FDownSectionIndex;
      FButtonDown := False;
      FDownSectionIndex := -1;
      SSection := GetSectionAt(X, Y);
      if SSection = Tmp then
        begin
          FHotSectionIndex:=-1;
          PaintSectionButton(Tmp);
          ActiveSectionIndex := Tmp;
          MouseMove([],X,Y);
        end
      else
        PaintSectionButton(Tmp);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.Notification(AComponent: TComponent; Operation: TOperation);
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
      if (AComponent = FThemeController) then
        SetThemeController(nil);
      if (AComponent is TImageList) or (AComponent is TBasicAction) then
        for i:=0 to FSections.Count-1 do
          FSections[i].Notification(AComponent,Operation);
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.OnDragTimer(Sender: TObject);
var
  Point : TPoint;
begin
  FDragTimer.Enabled := False;
  GetCursorPos(Point);
  Point := ScreenToClient(Point);
  if GetSectionAt(Point.X, Point.Y)=FDragSection then
    ActiveSectionIndex := FDragSection;
  FDragSection := -1;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.OnScrollClick(Sender: TObject);
begin
  if ActiveSection=nil then exit;
  if Sender=FUpScroll then
    ActiveSection.View.FScrollUpBtn.OnClick(Self)
  else
    ActiveSection.View.FScrollDownBtn.OnClick(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.Paint;
var
  I:Integer;
begin
  if (csLoading in ComponentState) or not Assigned(ActiveSections) then exit;
  PaintBackground;
  //PaintBorder(GetSectionRect);
  if (not FSingleSection) and (ActiveSections.Count>0) then
    for i:=0 to ActiveSections.Count do
      PaintSectionButton(i);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.PaintBackground;
begin
  Canvas.Brush.Color := TLMDSectionBarTheme(GetTheme).ViewBackground;
  Canvas.FillRect(ClientRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.PaintSectionButton(Index:Integer);
var
   Rect,ScrollRect : TRect;
   TextRect : TRect;
   ACaption :String;
   GH : Integer;
   iScrollIdx : Integer;
   Bmp : TBitmap;
   bScrollDown,
   drawButton : Boolean;

var
  DrawFlags:Integer;
  TH : TLMDSectionBarTheme;
  b : Boolean;
  Section : TLMDSectionBarSection;

begin
  GH:=0;
  TH := TLMDSectionBarTheme(GetTheme);

  if not (((Index>=0)and(Index<ActiveSections.Count))
     or ((Index=ActiveSections.Count) and (FActiveSectionIndex=ActiveSections.Count-1))) then
    Exit;

  Rect := GetSectionButtonRect(Index);
  Canvas.Brush.Color := TH.ButtonBackground;
  Canvas.FillRect(Rect);

  InflateRect(Rect,-1,-1);

  drawButton:=(Index=FActiveSectionIndex) or (Index=FActiveSectionIndex+1);
  if drawButton then
    begin
      GH := Rect.Bottom-Rect.Top;
      ScrollRect := Rect;
      ScrollRect.Left := ScrollRect.Right-GH-1;
      if (Index=FActiveSectionIndex) then
        begin
          with ScrollRect do
            FUpScroll.SetBounds(Left,Top,Right,Bottom);
          FUpScroll.FSectionIndex := Index;
          FUpScroll.Visible := ActiveSections[FActiveSectionIndex].View.FScrollUpBtn.Visible;
          bScrollDown := FUpScroll.IsDown;
          if ActiveSections[FActiveSectionIndex].View.FScrollUpBtn.Visible then
            iScrollIdx := 2
          else
            iScrollIdx := 3;
        end
     else
       begin
         with ScrollRect do
           FDownScroll.SetBounds(Left,Top,Right,Bottom);
         FDownScroll.FSectionIndex := Index;
         FDownScroll.Visible := ActiveSections[FActiveSectionIndex].View.FScrollDownBtn.Visible;
         bScrollDown := FDownScroll.IsDown;
         if ActiveSections[FActiveSectionIndex].View.FScrollDownBtn.Visible then
           iScrollIdx := 0
         else
           iScrollIdx := 1;
       end;
     if bScrollDown then
       DrawEdge (Canvas.Handle, ScrollRect, BDR_SUNKENOUTER, BF_RECT)
     else
       DrawEdge (Canvas.Handle, ScrollRect, BDR_RAISEDINNER, BF_RECT);
     Bmp := TBitmap.Create;
     try
       Bmp.Width :=  TH.ScrollBmp.Width div 4;
       Bmp.Height := TH.ScrollBmp.Height;
       Bmp.Canvas.CopyRect(Classes.Rect(0,0,Bmp.Width,Bmp.Height), TH.ScrollBmp.Canvas,
                           Classes.Rect(Bmp.Width*iScrollIdx,0,Bmp.Width*(iScrollIdx+1),TH.ScrollBmp.Height));
       Bmp.TransparentMode := tmAuto;
       Bmp.Transparent := True;
       with ScrollRect do
         Canvas.Draw(Left+(Right-Left-Bmp.Width)div 2,Top+(Bottom-Top-Bmp.Height)div 2,Bmp);
     finally
       Bmp.Free;
     end;
     Dec(Rect.Right,GH+3);
  end;

  if (Index=ActiveSections.Count) then
    exit;

  if (Index>=0)and(Index<ActiveSections.Count)then
    Section := ActiveSections[Index]
  else
    Section := nil;

  b := false;
  if Assigned(FOnSectionDrawButton) then
    if Section<>nil then
      FOnSectionDrawButton(Self, Canvas, Rect,Section.Index,b)
    else
      FOnSectionDrawButton(Self, Canvas, Rect,-1,b);
  if b then exit;

  if FButtonDown and (FDownSectionIndex = Index) then
    DrawEdge (Canvas.Handle, Rect, BDR_SUNKENOUTER, BF_RECT)
  else
    DrawEdge (Canvas.Handle, Rect, BDR_RAISEDINNER, BF_RECT);

  if (Index=FActiveSectionIndex) then
    ActiveSections[Index].View.Invalidate;

  // Drawing of TextPart -  may be improved in future versions
  // ------------------------------------------------------------
  CopyRect (TextRect, Rect) ;
  InflateRect(TextRect, -1, -1) ;
  Inc(TextRect.Left);
  if FButtonDown and (FDownSectionIndex = Index) then
    begin
      Inc(TextRect.Top);
      Inc(TextRect.Left);
    end;
  ACaption:=ActiveSections[Index].Caption;
  Canvas.Font:=self.Font;
  if HotTrack and (Index = FHotSectionIndex) then
    Canvas.Font.Color := TH.ButtonHighlightTextColor
  else
    Canvas.Font.Color := TH.ButtonTextColor;
  DrawFlags:=DT_SINGLELINE or DT_END_ELLIPSIS Or DT_VCENTER;
  case FCaptionAlignment of
    taLeftJustify:DrawFlags:=DrawFlags or DT_LEFT;
    taRightJustify:DrawFlags:=DrawFlags or DT_RIGHT;
    taCenter:DrawFlags:=DrawFlags or DT_CENTER;
  end;
  DrawText(Canvas.Handle,PChar(ACaption),Length(ACaption),TextRect,DrawFlags);
  // Area below button
  // ------------------------------------------------------------
  InflateRect (TextRect, 1, 1) ;
  Dec(TextRect.Left,2);Inc(TextRect.Right);
  if drawButton then
    Inc(TextRect.Right, GH+3)
  else
    Inc(TextRect.Right);
  Canvas.Brush.Color := TH.ButtonSpaceColor;
  TextRect.Top:=Rect.Bottom+1;
  TextRect.Bottom:=TextRect.Top+Th.ButtonSpace;

  if (Index=ActiveSections.Count-1) and (Index>FActiveSectionIndex) then
    Dec(TextRect.Bottom,Th.ButtonSpace);
  if Index<>FActiveSectionIndex then
    Canvas.FillRect(TextRect);

  // code for possible painting of last empty button area in ButtonSpace color
  {  end
  else
    begin
     CopyRect (TextRect, Rect) ;
     InflateRect (TextRect, 1, 1) ;
     Dec(TextRect.Left,2);Inc(TextRect.Right);
     Canvas.Brush.Color := TH.SectionSpaceColor;
    end;}

end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.UpdateSection(Index: Integer);
begin
  CancelEditMode;
  if Index=-1 then
    begin
//      CheckSectionIndex;
      ChangeSections(GetActiveSections,GetActiveSections);
    end;
  if (FActiveSectionIndex=-1) and (ActiveSections.Count>0) then
    ActiveSectionIndex := 0
  else
    if (FActiveSectionIndex>=0) and (ActiveSections.Count=0) then
      ActiveSectionIndex := -1
    else
      if (FActiveSectionIndex>=0) and (FActiveSectionIndex<ActiveSections.Count) then
        UpdateSectionSize
      else
        ActiveSectionIndex := ActiveSections.Count-1;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.UpdateSectionSize;
var
 Rect : TRect ;
begin
  if not HandleAllocated then
    exit;

  if (ActiveSectionIndex<>-1) and not (csLoading in ComponentState) then
    begin
      FInternalFontHeight:=LMDGetFontHeight(self.Font)+8;
      Rect := GetSectionRect;
      SetWindowPos (ActiveSections[FActiveSectionIndex].Panel.Handle, 0, Rect.Left, Rect.Top, Rect.Right - Rect.left,
                    Rect.Bottom - Rect.top, SWP_NOACTIVATE OR SWP_SHOWWINDOW);
      ActiveSections[FActiveSectionIndex].Panel.Visible := True;
    end;
  if Showing then Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.UpdateSectionStorage;
begin
  ActiveSectionIndex := -1;
end;

{--------------------------- public -------------------------------------------}
constructor TLMDCustomSectionBar.Create(AOwner: TComponent);
begin
  inherited;

  inherited Width := 50;
  inherited Height := 100;
  inherited BevelKind:=bkTile;
  inherited BevelInner:=bvNone;

  ControlStyle:=ControlStyle+[csCaptureMouse];

  FTheme := TLMDSectionBarTheme.Create(Self);
  FTheme.OnChange:=GetThemeChange;

  FSections := TLMDSectionBarSections.Create(Self);
  FUpScroll := TLMDBarClearButton.Create(nil);
  FUpScroll.FBar := Self;
  FUpScroll.Parent := Self;
//  FUpScroll.OnClick := OnScrollClick;

  FDownScroll := TLMDBarClearButton.Create(nil);
  FDownScroll.FBar := Self;
  FDownScroll.Parent := Self;
//  FDownScroll.OnClick := OnScrollClick;

  FHotTrack    := True;
  FActiveSectionIndex := -1;
  FCaptionAlignment := taLeftJustify;
  FButtonDown := False;
  FDownSectionIndex := -1;
  FHotSectionIndex  := -1;
  FScrollFrequency      := 20;
  FTimerEnable    := False;
  FCaptionEdit := TLMDBarSectionCaptionEdit.Create(Self);
  FDragTimer := TTimer.Create (Self);
  FDragTimer.Enabled := False;
  FDragTimer.Interval := 400;
  FDragTimer.OnTimer := OnDragTimer;
  FDragSection := -1;
  FSingleSection := False;
  FDoubleBuffered := True;

  //FCtlXP := True;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomSectionBar.Destroy;
begin
  FThemeController := nil;
  SectionStorage := nil;
  FDragTimer.Free;
  FCaptionEdit.Free;
  FSections.Free;
  FUpScroll.Free;
  FDownScroll.Free;
  FTheme.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.CancelEditMode:Boolean;
begin
  result:=False;
  if not Assigned(FCaptionEdit) then exit;
  if FCaptionEdit.Visible then
    begin
      FCaptionEdit.Hide;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.ItemAdd(IsDown:Boolean;ShowEditor:Boolean; SectionIndex: Integer; Activate, effect: Boolean):Integer;
begin
  result:=-1;
  if not CheckSectionIndex(SectionIndex, Activate, effect) then exit;
  result:=ActiveSections[GetInternalSectionIndex(SectionIndex)].Items.Add.Index;

  if IsDown then
    ActiveSections[GetInternalSectionIndex(SectionIndex)].Items[result].Down:=True;
  if ShowEditor then
    if ActiveSectionIndex=GetInternalSectionIndex(SectionIndex) then
      ItemEdit(result);
  if Assigned(FOnItemAdd) then
    FOnItemAdd(self, result);
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.ItemInsert(aIndex:Integer; IsDown:Boolean=True; SectionIndex:Integer=-1; Activate:Boolean=true; effect:Boolean=false):Boolean;
begin
  result:=false;
  if not CheckSectionIndex(SectionIndex, Activate, effect) then exit;
  with ActiveSections[GetInternalSectionIndex(SectionIndex)] do
    begin
      BeginUpdate;
      try
        with Items.Add do
          begin
            if (aIndex>-1) and (aIndex<Items.Count-1) then Index:=aIndex;
            If IsDown then Down:=True;
            if Assigned(FOnItemAdd) then
              FOnItemAdd(self, aIndex);
          end;
        result:=true;
      finally
        EndUpdate(True);
      end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.ItemDelete(aIndex:Integer=-1; IsDown:Boolean=True; SectionIndex:Integer=-1; Activate:Boolean=true; effect:Boolean=false): Boolean;
var
  tmp:Integer;
  Cancel:Boolean;
begin
  result:=false;
  Cancel:=False;
  if not CheckSectionIndex(SectionIndex, Activate, effect) then exit;
  with ActiveSections[GetInternalSectionIndex(SectionIndex)] do
    begin
      if AIndex=-1 then tmp:=DownItemIndex else tmp:=aIndex;
      if (tmp<0) or (tmp>Items.Count-1) then exit;
      if Assigned(FOnBeforeItemDelete) then
        FOnBeforeItemDelete(self, tmp, Cancel);
      if Cancel then exit;
      Items.Delete(tmp);
      If IsDown and (Items.Count>0) then
        if (tmp<Items.Count) then
          Items[tmp].Down:=True
        else
          Items[Items.Count-1].Down:=true;
      if Assigned(FOnItemDelete) then
        FOnItemDelete(self);

    end;
  result:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.ItemEdit(aIndex: Integer);
var
  tmp:Integer;
  tmpb:Boolean;
  Rect : TRect;
begin
  tmpb:=false;
  CancelEditMode;
  if not Assigned(ActiveSection) then exit;
  if aIndex=-1 then tmp:=ActiveSection.DownItemIndex else tmp:=aIndex;
  // no valid Index specified or no item in down state
  if (tmp<0) or (tmp>ActiveSection.Items.Count-1) then exit;

  // Is Item which should be edited visible?
  if  not ActiveSection.IsItemVisible(ActiveSection.Items[tmp]) then
    ActiveSection.ScrollInView(ActiveSection.Items[tmp]);

  // Event
  if Assigned(FOnItemEditShow) then FOnItemEditShow(self, tmp, tmpb);
  if tmpb then exit;

  with ActiveSection do
    begin
      FCaptionEdit.Parent:=View;
      Rect :=ActiveSection.View.CaptionRect[Items[tmp]];
      Inc(Rect.Bottom);Dec(Rect.Top);
      FCaptionEdit.SetBounds(Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top);
      FCaptionEdit.ItemIndex := tmp;
      FCaptionEdit.Text := Items[tmp].Caption;
      FCaptionEdit.Font.Color:=clWindowText;
      FCaptionEdit.Show(self);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.ItemMove(NewIndex, OldIndex, SectionIndex: Integer; Activate, effect: Boolean): Boolean;
var
  tmp:Integer;
begin
  result:=false;
  if not CheckSectionIndex(SectionIndex, Activate, effect) then exit;
  with ActiveSections[GetInternalSectionIndex(SectionIndex)] do
    begin
      if (NewIndex<0) or (NewIndex>Items.Count-1) then Exit;
      if OldIndex=-1 then tmp:=DownItemIndex else tmp:=OldIndex;
      if (tmp<0) or (tmp>Items.Count-1) then exit;
      Items[tmp].Index:=NewIndex;
      result:=true;
    end;
end;

{------------------------------------------------------------------------------}
procedure  TLMDCustomSectionBar.SectionActivate(NewIndex:Integer; effect:Boolean=false);
begin
  if effect=false then
    BeginUpdate;
  try
    ActiveSectionIndex:=NewIndex;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.SectionAdd(Activate:Boolean=true; ShowEditor:Boolean=false;effect:Boolean=false): Integer;
begin
  result:=-1;
  CancelEditMode;
  if not Assigned(ActiveSections) then exit;
  result:=ActiveSections.Add.Index;
  if Activate then
    begin
      SectionActivate(result, effect);
      if result=ActiveSectionIndex then
        if ShowEditor then
          SectionEdit(result);
    end;
  if Assigned(FOnSectionAdd) then
    FOnSectionAdd(self, result);
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.SectionCopyImageSettings(ToIndex, FromIndex: Integer): Boolean;
var
  tmp:TLMDSectionBarSection;
begin
  result:=false;
  if not Assigned(ActiveSections) or (ActiveSections.Count=0) then exit;

  if (ToIndex>-1) and (ToIndex<ActiveSections.Count) then
    begin
      if FromIndex=-1 then
        tmp:=ActiveSection
      else
        tmp:=ActiveSections[FromIndex];
      if Assigned(tmp) then
        begin
          ActiveSections[toIndex].SmallImages:=tmp.SmallImages;
          ActiveSections[toIndex].LargeImages:=tmp.LargeImages;
          result:=true;
        end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.SectionsCopyImageSettings(FromIndex: Integer): Boolean;
var
  i, tmp:Integer;
begin
  result:=false;
  if not Assigned(ActiveSections) or (ActiveSections.Count<2) then exit;
    if FromIndex=-1 then
      tmp:=ActiveSection.Index
    else
      tmp:=FromIndex;
  for i:=0 to ActiveSections.Count-1 do
    if i<>tmp then
      SectionCopyImageSettings(i, tmp);
  result:=true;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.SetAllowDownState(const Value: Boolean);
var
  i:Integer;
begin
  if not Assigned(ActiveSections) then exit;
  for i:=0 to ActiveSections.Count-1 do
    ActiveSections[i].AllowDown:=Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.SetReadOnly(const Value: Boolean);
var
  i:Integer;
begin
  if not Assigned(ActiveSections) then exit;
  for i:=0 to ActiveSections.Count-1 do
    ActiveSections[i].ReadOnly:=Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.SetViewStyle(const Value: TLMDSectionBarViewStyle);
var
  i:Integer;
begin
  if not Assigned(ActiveSections) then exit;
  for i:=0 to ActiveSections.Count-1 do
    ActiveSections[i].ViewStyle:=Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.SetFont(Value:TFont);
var
  i:Integer;
begin
  if not Assigned(ActiveSections) then exit;
  for i:=0 to ActiveSections.Count-1 do
    ActiveSections[i].Font:=Value;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.SectionInsert(AtIndex:Integer;Activate:Boolean=true; effect:Boolean=false):Boolean;
begin
  result:=false;
  if not Assigned(ActiveSections) then exit;
  if AtIndex=-1 then
    begin
      result:=SectionAdd(Activate, effect)<>-1;
      exit;
    end;
  BeginUpdate;
  try
    with ActiveSections.Add do
      Index:=AtIndex;
    if Activate then
      SectionActivate(AtIndex, effect);
    result:=true;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.SectionRect(Index: Integer): TRect;
begin
  result:=GetSectionRect;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.SectionDelete(Index: Integer=-1): Boolean;
var
  Cancel:Boolean;
begin
  result:=false;
  Cancel:=false;
  if not Assigned(ActiveSections) or (ActiveSections.Count=0) then exit;
  if Index=-1 then
    Index:=FActiveSectionIndex;
  if (Index<0) or (Index>ActiveSections.Count-1) then exit;

  if Assigned(FOnBeforeSectionDelete) then
    FOnBeforeSectionDelete(self, index, Cancel);
  if Cancel then exit;

  ActiveSections.Delete(Index);

  if Assigned(FOnSectionDelete) then
    FOnSectionDelete(self);

  result:=true;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSectionBar.SectionEdit(Index: Integer=-1);
var
  Rect : TRect;
  tmp:Boolean;

begin
  if Index=-1 then
    Index:=ActiveSectionIndex;
  CancelEditMode;

  if not Assigned(ActiveSections) or (Index<0) or (Index>=ActiveSections.Count) then exit;

  if Assigned(FOnSectionEditShow) then FOnSectionEditShow(self, Index, tmp);

  Rect := GetSectionButtonRect(Index);
  FCaptionEdit.Parent:=self;
  FCaptionEdit.SetBounds(Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top);
  FCaptionEdit.ItemIndex := Index;
  FCaptionEdit.Text := ActiveSections[Index].Caption;
  FCaptionEdit.Show(self);
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.SectionAtPos(X, Y: Integer): Integer;
begin
  result:=GetSectionAt(X,Y);
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.SectionMove(NewIndex:Integer; Index:Integer=-1; effect:Boolean=false):Boolean;
begin
  result:=false;
  if NewIndex=Index then exit;
  // check for plausibility
  if Index=-1 then
    Index:=FActiveSectionIndex;
  if (Index<0) or (Index>=ActiveSections.Count) or (NewIndex<0) or (NewIndex>=ActiveSections.Count) then
    exit;
  ActiveSections.Items[Index].Index:=NewIndex;
  SectionActivate(NewIndex, effect);
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.SectionNext(effect:Boolean=true): Integer;
begin
  result:=-1;
  if not Assigned(ActiveSections) or (ActiveSections.Count=0) then exit;
  SectionActivate(FActiveSectionIndex+1, effect);
  result:=ActiveSectionIndex;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSectionBar.SectionPrev(effect:Boolean=true): Integer;
begin
  result:=1;
  if not Assigned(ActiveSections) or (ActiveSections.Count=0) then exit;
  SectionActivate(FActiveSectionIndex-1, effect);
  result:=ActiveSectionIndex;
end;

{ TLMDBarSectionCaptionEdit }
{******************** TLMDBarSectionCaptionEdit *******************************}
{-------------------------- protected -----------------------------------------}
procedure TLMDBarSectionCaptionEdit.CreateParams(var Params: TCreateParams);
begin
  inherited;
  //Params.Style := Params.Style or WS_BORDER;
end;

{------------------------------------------------------------------------------}
function TLMDBarSectionCaptionEdit.IsSection: Boolean;
begin
  result:=Parent is TLMDCustomSectionBar;
end;

{------------------------------------------------------------------------------}
procedure TLMDBarSectionCaptionEdit.KeyPress(var Key: Char);
begin
  case Key of
    #27:
      begin
        CancelEdit := True;
        Key := #0;
        Hide;
      end;
    #13:
      begin
        UpdateCaption;
        CancelEdit:=True;
        Hide;
        Key := #0;
      end;
    #9: Key:=#0;
  end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDBarSectionCaptionEdit.UpdateCaption;
var
  tmp:Boolean;
begin
  tmp:=false;
  if Parent is TLMDCustomSectionBar then
    begin
      with TLMDCustomSectionBar(Parent) do
        if (ItemIndex>=0) and (ItemIndex<FSections.Count) and (not CancelEdit) then
          Sections[ItemIndex].SetCaptionEx(Self.Text, true);
    end
  else
    with TLMDSectionBarView(Parent) do
      if (ItemIndex>=0) and (ItemIndex<Items.Count) and (not CancelEdit) then
        begin
          if Assigned(TLMDCustomSectionBar(FClient).FOnItemCaptionChanging) then
              TLMDCustomSectionBar(FClient).FOnSectionCaptionChanging(TLMDCustomSectionBar(FClient), ItemIndex, Self.Text, tmp);
            if tmp then exit;
          Items[ItemIndex].Caption:=self.Text;
          if Assigned(TLMDCustomSectionBar(FClient).FOnItemCaptionChange) then
              TLMDCustomSectionBar(FClient).FOnSectionCaptionChange(TLMDCustomSectionBar(FClient), ItemIndex);
        end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBarSectionCaptionEdit.WMKillFocus(var Message: TWMSetFocus);
begin
  inherited;
  UpdateCaption;
  Hide;
end;

{--------------------------- public -------------------------------------------}
constructor TLMDBarSectionCaptionEdit.Create(AOwner: TComponent);
begin
  inherited;
  Visible := False;
  ControlStyle := ControlStyle + [csNoDesignVisible];
  BorderStyle := bsSingle;
end;

{------------------------------------------------------------------------------}
procedure TLMDBarSectionCaptionEdit.Show;
begin
  inherited Show;
  FClient:=Value;
  CancelEdit:=False;
  SetFocus;
end;

{------------------------------------------------------------------------------}
procedure TLMDBarSectionCaptionEdit.VisibleChanging;
begin
  inherited;
  if not Assigned(FClient) then exit;
  if Visible then
    with TLMDCustomSectionBar(FClient) do
      if Assigned(FOnEditHide) then FOnEditHide(self)
end;

{******************** TLMDBarClearButton***************************************}
{-------------------------- protected -----------------------------------------}
procedure TLMDBarClearButton.OnTimer(Sender: TObject);
begin
  FBar.OnScrollClick(Self);
  FBar.PaintSectionButton(FSectionIndex);
  if Visible then
    FTimer.Interval := 200
  else
    FTimer.Enabled := False;
end;

{------------------------------------------------------------------------------}
procedure TLMDBarClearButton.Paint;
begin
end;

{--------------------------- public -------------------------------------------}
constructor TLMDBarClearButton.Create(AOwner: TComponent);
begin
  inherited;
  FTimer := TTimer.Create(nil);
  FTimer.Interval := 200;
  FTimer.Enabled := False;
  FTimer.OnTimer := OnTimer;
end;

{------------------------------------------------------------------------------}
destructor TLMDBarClearButton.Destroy;
begin
  FTimer.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDBarClearButton.IsDown: Boolean;
begin
  Result := FState=bsDown;
end;

{------------------------------------------------------------------------------}
procedure TLMDBarClearButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FBar.OnScrollClick(Self);
  FBar.PaintSectionButton(FSectionIndex);
  FTimer.Interval := 500;
  FTimer.Enabled := True;
end;

{------------------------------------------------------------------------------}
procedure TLMDBarClearButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FTimer.Enabled := False;
  FBar.PaintSectionButton(FSectionIndex);
end;

{ TLMDWinControl }
{------------------------------------------------------------------------------}
procedure TLMDWinControl.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  inherited;
end;

initialization
  LMDBarCommmonScrollBmp:=TBitmap.Create;
  LMDBarCommmonScrollBmp.TransparentMode := tmAuto;
  LMDBarCommmonScrollBmp.Transparent := True;
  LMDBarCommmonScrollBmp.LoadFromResourceName(hInstance,'LMDSECTIONBAR_SCROLL');
  RegisterClass(TLMDSectionBarSectionPanel);
  RegisterClass(TLMDSectionBarView);

finalization
  FreeAndNil(LMDBarCommmonScrollBmp);

end.
