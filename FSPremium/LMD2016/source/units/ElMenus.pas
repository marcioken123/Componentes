unit ElMenus;
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

ElMenus unit
------------
TElMainMenu & TElPopupMenu component.
Specifies routines for debug output

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics,
  TypInfo, Controls, Forms, Dialogs, Menus, StdCtrls, Clipbrd, ActnList, ImgList,
  CommCtrl, Types, Themes, UxTheme, ExtCtrls,

  LMDDebugUnit,  ElShadowWindow, ElImgFrm, LMDGraphUtils,
  LMDThemes, LMDClass,
  {$IFDEF LMD_UNICODE} LMDUnicodeStrings,{$ELSE}LMDStrings,{$ENDIF}
  LMDHTMLUnit, LMDTypes, intfLMDBase, LMDElConst, LMDProcs, LMDFiles, LMDUnicode,
  LMDPngImageList, LMDPNGImageFilters, LMDGraph, LMDSysIn,

  {$IFDEF LMD_DEBUGMESSAGES}ElSBHook, {$ENDIF IFDEF LMD_DEBUGMESSAGES}
  ElHook, ElTimers;

{$WARNINGS off}

const
  EL_NAVIGATEKEY = WM_USER + 327;
  EL_MENUSELECT  = WM_USER + 328;
  EL_MENUCLICK   = WM_USER + 329;

type
  TElMenuItem = class;

  EMenuError = class(Exception);
  TMenuBreak = (mbNone, mbBreak, mbBarBreak);
  TElEndPopupEvent = procedure(Sender: TObject; ManualCancel: boolean) of
    object;
  TElNavigateKeyEvent = procedure(Sender: TObject; Button : Word) of
    object;
  TMenuChangeEvent = procedure(Sender: TObject; Source: TElMenuItem; Rebuild:
    Boolean) of object;

  THackClass = class(TComponent)
  private
    FBiDiMode: TBiDiMode;
    FItems: TMenuItem;
  end;
  { TMenuActionLink }

  TMenuActionLink = class(TActionLink)
  protected
    FClient: TElMenuItem;
    procedure AssignClient(AClient: TObject); override;
    function IsAutoCheckLinked: Boolean; virtual;
    function IsCaptionLinked: Boolean; override;
    function IsCheckedLinked: Boolean; override;
    function IsEnabledLinked: Boolean; override;
    // function IsHelpContextLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;
    function IsShortCutLinked: Boolean; override;
    function IsVisibleLinked: Boolean; override;
    function IsOnExecuteLinked: Boolean; override;
    procedure SetCaption(const Value: string); override;
    procedure SetChecked(Value: Boolean); override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetHelpContext(Value: THelpContext); override;
    procedure SetHint(const Value: string); override;
    procedure SetImageIndex(Value: Integer); override;
    procedure SetShortCut(Value: TShortCut); override;
    procedure SetVisible(Value: Boolean); override;
    procedure SetOnExecute(Value: TNotifyEvent); override;
  end;

  TElMenuTheme = class(TPersistent)
  public
    procedure DrawItemText(ACanvas: TCanvas; const AText: TLMDString; const ARect: TRect; const AFlags: Integer); virtual; abstract;
    procedure DrawItemBackground(ACanvas: TCanvas; const ARect: TRect); virtual; abstract;
//    property GutterWidth: Integer;
//    property CheckMargin: Integer;
//    property CheckSize: TSize;
//    property SeparatorSize: TSize;
  end;

  TMenuActionLinkClass = class of TMenuActionLink;

  TDrawStyle = (tdsNormal, tdsOfficeXP, tdsWindowsXP, tdsOffice2003);

  { TElMenuItem }

  TElMenuItem = class(TMenuItem)
  private
    FOnSubMenuPopup: TNotifyEvent;
//    function InternalRethinkHotkeys(ForceRethink: Boolean): Boolean;
    function InternalRethinkLines(ForceRethink: Boolean): Boolean;
    procedure DrawAlphaMaskedImage(Canvas:TCanvas; X, Y, W, H: integer; Images, AlphaImages: TCustomImageList);
  protected
    FState: TOwnerDrawState;
    FImageChangeLink: TChangeLink;
    FAImageChangeLink: TChangeLink;
    FSubMenuImages: TCustomImageList;
    FAlphaSubMenuImages: TCustomImageList;
    FCaption: TLMDString;
    FHandle: HMENU;
    FChecked: Boolean;
    FEnabled: Boolean;
    FDefault: Boolean;
    FRadioItem: Boolean;
    FVisible: Boolean;
    FGroupIndex: Byte;
    FImageIndex: Integer;

    FCurrentForm: TCustomForm;

    FActionLink: TMenuActionLink;

    FProcessShortCut: boolean;
    FBreak: TMenuBreak;
    FBitmap: TBitmap;
    FDisBitmap: TBitmap;
    FCommand: Word;
    // FHelpContext: THelpContext;
    FHint: TLMDString;
    FItems: TList;
    FShortCut: TShortCut;
    FParent: TElMenuItem;
    FMerged: TElMenuItem;
    FMergedWith: TElMenuItem;

    FMenu: TMenu;

    FStreamedRebuild: Boolean;
    FOnChange: TMenuChangeEvent;
    FOnIntChange: TMenuChangeEvent;
    FOnClick: TNotifyEvent;
    FVertical: Boolean;

    function IsVistaSelNeed(Selected: Boolean): Boolean;
    function ChildsHasImage: Boolean;
    procedure AppendTo(Menu: HMENU; ARightToLeft: Boolean);

    procedure DoActionChange(Sender: TObject);

    procedure ReadShortCutText(Reader: TReader);
    procedure MergeWith(Menu: TElMenuItem);
    procedure RebuildHandle;
    procedure PopulateMenu;
    procedure SubItemChanged(Sender: TObject; Source: TElMenuItem; Rebuild:
      Boolean);
    procedure TurnSiblingsOff;
    procedure WriteShortCutText(Writer: TWriter);
    procedure VerifyGroupIndex(Position: Integer; Value: Byte);

    function GetAction: TBasicAction;virtual;
    procedure SetAction(Value: TBasicAction);virtual;

    procedure SetSubMenuImages(Value: TCustomImageList);
    procedure SetAlphaSubMenuImages(Value: TCustomImageList);

    function GetBitmap: TBitmap;
    procedure SetBitmap(Value: TBitmap);

    procedure InitiateActions;
    function IsCaptionStored: Boolean;
    function IsCheckedStored: Boolean;
    function IsEnabledStored: Boolean;
    function IsHintStored: Boolean;
    // function IsHelpContextStored: Boolean;
    function IsImageIndexStored: Boolean;
    function IsOnClickStored: Boolean;
    function IsShortCutStored: Boolean;
    function IsVisibleStored: Boolean;

    // helper methods
    function GetDrawStyle: TDrawStyle;
    function GetImages(Enabled, Selected : boolean): TCustomImageList;
    function GetAlphaImages(Enabled, Selected : boolean): TCustomImageList;
    function IsRightToLeft: boolean;
    function IsTopLevel: boolean;
    function IsLine: Boolean;
    function UseThemeMode: TLMDThemeMode;

    // measuring item methods
    procedure MeasureItem(ACanvas: TCanvas; var Width, Height: Integer); override;
    procedure DoMeasureItem(Canvas: TCanvas; var Width, Height: integer); dynamic;
    procedure MeasureNormalItem(Canvas: TCanvas; var Width, Height: integer);
    procedure MeasureOfficeXPItem(Canvas: TCanvas; var Width, Height: integer);
    procedure MeasureWindowsXPItem(Canvas: TCanvas; var Width, Height: integer);
    procedure MeasureMenuItem(Canvas: TCanvas; var Width, Height: integer); virtual;

    // drawing item methods
    procedure DrawOfficeXPSeparator(ACanvas: TCanvas; ImgW: Integer; TR: TRect; var R: TRect);

    procedure DoDrawText(ACanvas: TCanvas; const ACaption: TLMDString; var Rect: TRect; Selected: Boolean; Flags: Longint);
    procedure DrawNormalLeftToRight(Canvas: TCanvas; R: TRect; Selected: boolean);
    procedure DrawOfficeXPLeftToRight(Canvas: TCanvas; R: TRect; Selected, Dropped: boolean);
    procedure DrawWindowsXPLeftToRight(Canvas: TCanvas; R: TRect; Selected: boolean);
    procedure DrawNormalRightToLeft(Canvas: TCanvas; R: TRect; Selected: boolean);
    procedure DrawOfficeXPRightToLeft(Canvas: TCanvas; R: TRect; Selected, Dropped: boolean);
    procedure DrawWindowsXPRightToLeft(Canvas: TCanvas; R: TRect; Selected: boolean);
    procedure DrawMenuItem(Canvas: TCanvas; R: TRect; Selected, Dropped : boolean); virtual;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;

    procedure ImageListChange(Sender: TObject);

    procedure AssignTo(Dest: TPersistent); override;

    function GetActionLinkClass: TMenuActionLinkClass;

    procedure TriggerSubMenuPopup;
    function GetHandle: HMENU;
    function GetCount: Integer;
    function GetFontColor(aThemeMode:TLMDThemeMode; Selected: boolean): TColor; virtual;
    {$ifndef lmdcomp12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure SetParentComponent(Value: TComponent); override;
    {$endif}
    function GetItem(Index: Integer): TElMenuItem;
    function GetMenuIndex: Integer;
    procedure MenuChanged(Rebuild: Boolean); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetBreak(Value: TMenuBreak);
    procedure SetCaption(const Value: TLMDString);
    procedure SetChecked(Value: Boolean);
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure SetDefault(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    procedure SetGroupIndex(Value: Byte);
    procedure SetImageIndex(Value: Integer);
    procedure SetMenuIndex(Value: Integer);
    procedure SetRadioItem(Value: Boolean);
    procedure ReadCaption(Reader : TReader);
    procedure ReadHint(Reader : TReader);
    {$IFNDEF LMDCOMP7}
    procedure WriteCaption(Writer : TWriter);
    procedure WriteHint(Writer : TWriter);
    {$ENDIF}

    procedure DefineProperties(Filer: TFiler); override;

    procedure SetShortCut(Value: TShortCut);
    procedure SetVisible(Value: Boolean);

    property ActionLink: TMenuActionLink read FActionLink write FActionLink;

    procedure UpdateItems;
    function GetImageWidth: Integer;
    procedure SetHint(Value: TLMDString);
    procedure UpdateCommand;
    function DisabledImagePresent: Boolean;
    procedure IntMenuChanged(Rebuild: Boolean); virtual;

    property OnIntChange: TMenuChangeEvent read FOnIntChange write FOnIntChange;
    property Vertical: Boolean read FVertical write FVertical default false;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsThemed: boolean;
    {$ifdef lmdcomp12}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure SetParentComponent(Value: TComponent); override;
    {$else}
    {$endif}

    procedure InitiateAction; override;

    procedure DesignRebuild;
    procedure Insert(Index: Integer; Item: TElMenuItem);
    procedure Delete(Index: Integer);
    //procedure Click; override;
    function Find(ACaption: TLMDString): TElMenuItem;
    function IndexOf(Item: TElMenuItem): Integer;
    function GetParentComponent: TComponent; override;
    function GetParentMenu: TMenu;
    function HasParent: Boolean; override;
    procedure Add(Item: TElMenuItem);
    procedure Remove(Item: TElMenuItem);
    procedure Clear;
    procedure CopyItemsFrom(AItem: TElMenuItem);
    //property Command: Word read FCommand;

    property Handle: HMENU read GetHandle;
    property Merged: TElMenuItem read FMerged;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TElMenuItem read GetItem; default;
    property MenuIndex: Integer read GetMenuIndex write SetMenuIndex;
    property Parent: TElMenuItem read FParent;
    procedure Click; override;
  published
    property Action: TBasicAction read GetAction write SetAction;
    property ProcessShortCut: boolean read FProcessShortCut write
      FProcessShortCut default True;
    property SubMenuImages: TCustomImageList read FSubMenuImages write
      SetSubMenuImages;
    property AlphaForSubMenuImages: TCustomImageList read FAlphaSubMenuImages
      write SetAlphaSubMenuImages;
    property Bitmap: TBitmap read GetBitmap write SetBitmap;
    property Break: TMenuBreak read FBreak write SetBreak default mbNone;
    property Caption: TLMDString read FCaption write SetCaption stored IsCaptionStored;
    property Checked: Boolean read FChecked write SetChecked
      stored IsCheckedStored default False;
    property Default: Boolean read FDefault write SetDefault default False;
    property Enabled: Boolean read FEnabled write SetEnabled
      stored IsEnabledStored default True;
    property GroupIndex: Byte read FGroupIndex write SetGroupIndex default 0;
//    property HelpContext: THelpContext read FHelpContext write FHelpContext {$ifdef VCL_4_USED}stored IsHelpContextStored{$endif} default 0;
    property Hint: TLMDString read FHint write SetHint stored IsHintStored;
    property ImageIndex: Integer read FImageIndex write
      SetImageIndex stored IsImageIndexStored default  -1;
    property RadioItem: Boolean read FRadioItem write SetRadioItem default
      False;
    property ShortCut: TShortCut read FShortCut write
      SetShortCut stored IsShortCutStored default 0;
    property Visible: Boolean read FVisible write SetVisible
      stored IsVisibleStored default True;
    property OnClick: TNotifyEvent read FOnClick write  FOnClick stored IsOnClickStored;
    property OnChange: TMenuChangeEvent read FOnChange write FOnChange;
    property OnSubMenuPopup: TNotifyEvent read FOnSubMenuPopup write FOnSubMenuPopup;
  end;

  TElMenuItemClass = class of TElMenuItem;

  TElMainMenu = class(TMainMenu, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    FOle2Menu: HMENU;
    FMenuImage: TLMDString;
    FUnicodeItems: TElMenuItem;
    FDrawStyle: TDrawStyle;
    FFont: TFont;
    FSelectedItemFont: TFont;
    FForm: TForm;
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FAImageChangeLink: TChangeLink;
    FAlphaImages: TCustomImageList;

    FDisabledImageChangeLink: TChangeLink;
    FDisabledImages: TCustomImageList;
    FHotImageChangeLink: TChangeLink;
    FHotImages: TCustomImageList;
    FAHotImageChangeLink: TChangeLink;
    FAlphaHotImages: TCustomImageList;
    FADisabledImageChangeLink: TChangeLink;
    FAlphaDisabledImages: TCustomImageList;

    FItemSpace: integer;
    FImageMargin: integer;

    FOwnerDraw: boolean;
    FRightToLeft: boolean; //GTP

    WindowActive: boolean;

    FIsHTML: Boolean;
    FOnImageNeeded: TElHTMLImageNeededEvent;
    FRender: TLMDHTMLRender;
    procedure SetIsHTML(Value: Boolean);
    function GetIsHTML: Boolean;

    procedure SetOwnerDraw(Value: Boolean);
    procedure ImageListChange(Sender: TObject);
    procedure SetImages(Value: TCustomImageList);
    procedure SetAlphaImages(Value: TCustomImageList);

    procedure ItemChanged;
    procedure OnBeforeHook(Sender: TObject; var Message: TMessage; var Handled:
                           boolean);
    procedure OnAfterHook(Sender: TObject; var Message: TMessage; var Handled: boolean);
    procedure SetDrawStyle(Value: TDrawStyle);
    function  GetDrawStyle: TDrawStyle;

    procedure SetFont(const Value: TFont);
    function  UpdateImage: Boolean;
    procedure SetDisabledImages(Value: TCustomImageList);
    procedure SetHotImages(Value: TCustomImageList);
    procedure SetAlphaDisabledImages(Value: TCustomImageList);
    procedure SetAlphaHotImages(Value: TCustomImageList);
    procedure SetItemSpace(Value: integer);
    procedure SetImageMargin(Value: integer);
    procedure SetUseFontColor(const Value: boolean);
    procedure SetSelectedItemFont(const Value: TFont);
  protected
    FThemeGlobalMode: Boolean;
    FThemeMode : TLMDThemeMode;
    FHook: TElHook;
    //vAd:
    FUpdateCount: Integer;
    FSystemFont: Boolean;
    FUseFontColor: boolean;
    procedure SetThemeGlobalMode(const Value: Boolean);virtual;
    procedure SetThemeMode(const Value: TLMDThemeMode);virtual;
    procedure DoThemeChanged; virtual;
    function UseThemeMode: TLMDThemeMode;
    function IsOwnerDraw: Boolean;
    procedure ProcessMenuChar(var Message: TWMMenuChar);
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
{$IFDEF LMD_UNICODE}
    function DoGetMenuString(Menu: HMENU; ItemID: UINT; Str: PWideChar;
      MaxCount: Integer; Flag: UINT): Integer;
    {$ELSE}
    function DoGetMenuString(Menu: HMENU; ItemID: UINT; Str: PChar;
      MaxCount: Integer; Flag: UINT): Integer;
{$ENDIF}
    procedure MenuChanged(Sender: TObject; Source: TMenuItem; Rebuild: Boolean);override;
    procedure IntMenuChanged(Sender: TObject; Source: TElMenuItem; Rebuild: Boolean);

    function GetHandle: HMENU; override;
    function DispatchCommand(ACommand: Word): Boolean;
    procedure Loaded; override;
    procedure SetRightToLeft(Value: Boolean); //GTP
    procedure SetSystemFont(Value: Boolean);
    procedure GetFont;
    procedure FontChange(Sender: TObject);

    procedure TriggerImageNeededEvent(Sender: TObject; Src: TLMDString;
      var Image: TBitmap);

    procedure UpdateCommands;
    procedure AssignTo(Dest : TPersistent); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsThemed: Boolean;
    function FindItem(Value: TLMDPtrUInt; Kind: TFindItemKind): TElMenuItem;
    function IsShortCut(var Message: TWMKey): Boolean; override;
    procedure UpdateItems;
    function DispatchPopup(AHandle: HMENU): Boolean;
    procedure Merge(Menu: TElMainMenu);
    procedure Unmerge(Menu: TElMainMenu);

    //vAd:
    procedure BeginUpdate;
    procedure EndUpdate;
    function isUpdated: Boolean;

    procedure LoadItemsFromFiles(const ItemsFileName: array of TLMDString);
    function getLMDPackage:TLMDPackageID;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property Items: TElMenuItem read FUniCodeItems;
    property Font: TFont read FFont write SetFont;
    property SelectedItemFont: TFont read FSelectedItemFont write SetSelectedItemFont;
    property DrawStyle: TDrawStyle read GetDrawStyle write SetDrawStyle default tdsNormal;
    property Images: TCustomImageList read FImages write SetImages;
    property AlphaForImages: TCustomImageList read FAlphaImages write SetAlphaImages;

    property DisabledImages: TCustomImageList read FDisabledImages write SetDisabledImages;
    property AlphaForDisabledImages: TCustomImageList read FAlphaDisabledImages write SetAlphaDisabledImages;

    property HotImages: TCustomImageList read FHotImages write SetHotImages;
    property AlphaForHotImages: TCustomImageList read FAlphaHotImages write SetAlphaHotImages;

    property OwnerDraw: Boolean read FOwnerDraw write SetOwnerDraw default
      False;
    property ItemSpace: integer read FItemSpace write SetItemSpace default 4;
    property ImageMargin: integer read FImageMargin write SetImageMargin default 6;
    property RightToLeft: Boolean read FRightToLeft write SetRightToLeft default
      false; //GTP
    property SystemFont: Boolean read FSystemFont write SetSystemFont default
      true;

    property IsHTML: Boolean read GetIsHTML write SetIsHTML default false;
    property OnImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
    property UseFontColor: boolean read FUseFontColor write SetUseFontColor default false;
  end;

  TElPopupMenu = class(TPopupMenu, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    FIsHTML: Boolean;
    FRender: TLMDHTMLRender;
    FOnImageNeeded: TElHTMLImageNeededEvent;

    FHook: TElHook;
    FDrawStyle: TDrawStyle;
    FUnicodeItems: TElMenuItem;
    FPopupPoint: TPoint;
    FForm: TWinControl;
    FFont: TFont;
    FSelectedItemFont: TFont;

    FSystemFont: Boolean;

    FHookWindowProc: TWndMethod;
    FOnEndPopup: TElEndPopupEvent;
    FOnNavigateKey: TElNavigateKeyEvent;
    FInitialSelect: Boolean;

    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FAImageChangeLink: TChangeLink;
    FAlphaImages: TCustomImageList;

    FDisabledImageChangeLink: TChangeLink;
    FDisabledImages: TCustomImageList;
    FHotImageChangeLink: TChangeLink;
    FHotImages: TCustomImageList;
    FAHotImageChangeLink: TChangeLink;
    FAlphaHotImages: TCustomImageList;
    FADisabledImageChangeLink: TChangeLink;
    FAlphaDisabledImages: TCustomImageList;

    FItemSpace: integer;
    FImageMargin: integer;
    FThemeGlobalMode: Boolean;
    FThemeMode : TLMDThemeMode;

    FIsPopuped: Boolean;

    function GetUseXPThemes: Boolean;
    procedure ReadUseXPThemes(Reader: TReader);
    procedure SetThemeGlobalMode(const Value: Boolean);virtual;
    procedure SetThemeMode(const Value: TLMDThemeMode);virtual;
    procedure SetUseXPThemes(const Value: Boolean);virtual;

//    FAImageChangeLink: TChangeLink;
    procedure ImageListChange(Sender: TObject);
    procedure SetImages(Value: TCustomImageList);

    procedure SetAlphaImages(Value: TCustomImageList);
    procedure SetDrawStyle(Value: TDrawStyle);

    procedure OnBeforeHook(Sender: TObject; var Message: TMessage; var Handled:
      boolean);
    procedure SetFont(const Value: TFont);

    procedure SetIsHTML(Value: Boolean);
    function GetIsHTML: Boolean;

    procedure SetItemSpace(Value: integer);
    procedure SetImageMargin(Value: integer);
    procedure SetDisabledImages(Value: TCustomImageList);
    procedure SetHotImages(Value: TCustomImageList);
    procedure SetAlphaDisabledImages(Value: TCustomImageList);
    procedure SetAlphaHotImages(Value: TCustomImageList);
    procedure SetUseFontColor(const Value: boolean);
    procedure SetSelectedItemFont(const Value: TFont);
  protected
    FPopupRightToLeft: boolean; //GTP1
    FMustBeInScreen: Boolean;
    ExcludeRect: TRect;
    FUseFontColor: boolean;
    procedure DoPopup(Sender: TObject); override;
    procedure DefineProperties(Filer:TFiler);override;
    procedure DoThemeChanged; virtual;
    function UseThemeMode: TLMDThemeMode;
    function IsOwnerDraw: Boolean;
    function DispatchCommand(ACommand: Word): Boolean;
    function GetHandle: HMENU; override;
    procedure GetFont;
    procedure SetPopupRightToLeft(Value: Boolean); //GTP1
    procedure SetSystemFont(Value: Boolean);
    procedure FontChange(Sender: TObject);
    procedure Loaded; override;

    procedure TriggerImageNeededEvent(Sender: TObject; Src: TLMDString;
      var Image: TBitmap);

    procedure UpdateCommands;
    procedure TriggerEndPopup(ManualCancel: boolean);
    procedure TriggerNavigateKey(Button : Word); virtual;
    procedure AssignTo(Dest : TPersistent); override;
    function GetDrawStyle: TDrawStyle;

    property OnNavigateKey: TElNavigateKeyEvent read FOnNavigateKey write FOnNavigateKey;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsThemed: Boolean;
    procedure Popup(X, Y: Integer); override;
    function FindItem(Value: TLMDPtrUInt; Kind: TFindItemKind): TElMenuItem; virtual;
    function IsShortCut(var Message: TWMKey): Boolean; override;

    property HookWindowProc: TWndMethod read FHookWindowProc write FHookWindowProc;
    procedure ProcessMenuChar(var Message: TWMMenuChar);
    procedure UpdateItems;
    function DispatchPopup(AHandle: HMENU): Boolean;
    property PopupPoint: TPoint read FPopupPoint;
    property Handle read GetHandle;
    //vAd:

    procedure LoadItemsFromFiles(const ItemsFileName: array of TLMDString);
    function getLMDPackage:TLMDPackageID;
    property IsPopuped: Boolean read FIsPopuped;
    property InitialSelect: Boolean read FInitialSelect write FInitialSelect;
    property UseXPThemes: boolean read GetUseXPThemes write SetUseXPThemes;
  published
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property Items: TElMenuItem read FUniCodeItems;
    property Font: TFont read FFont write SetFont;
    property SelectedItemFont: TFont read FSelectedItemFont write SetSelectedItemFont;
    property DrawStyle: TDrawStyle read GetDrawStyle write SetDrawStyle default
        tdsNormal;

    property RightToLeft: Boolean read FPopupRightToLeft write
      SetPopupRightToLeft default false; //GTP1
    property SystemFont: Boolean read FSystemFont write SetSystemFont default
      true;

    property IsHTML: Boolean read GetIsHTML write SetIsHTML default false;
    property OnImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;

    property ItemSpace: integer read FItemSpace write SetItemSpace default 4;
    property ImageMargin: integer read FImageMargin write SetImageMargin default 6;

    property Images: TCustomImageList read FImages write SetImages;
    property AlphaForImages: TCustomImageList read FAlphaImages write SetAlphaImages;

    property DisabledImages: TCustomImageList read FDisabledImages write SetDisabledImages;
    property AlphaForDisabledImages: TCustomImageList read FAlphaDisabledImages write SetAlphaDisabledImages;

    property HotImages: TCustomImageList read FHotImages write SetHotImages;
    property AlphaForHotImages: TCustomImageList read FAlphaHotImages write SetAlphaHotImages;

    property OnEndPopup: TElEndPopupEvent read FOnEndPopup write FOnEndPopup;
    property UseFontColor: boolean read FUseFontColor write SetUseFontColor default false;
  end;
{$WARNINGS on}

{$IFDEF LMDX64}
 {$DEFINE LMD_ITERATOR_OBJECTS}
{$ENDIF}

type
  TLMDIterator = {$IFDEF LMD_ITERATOR_OBJECTS}function (MenuItem: TElMenuItem): Boolean of object{$ELSE}Pointer{$ENDIF};

procedure InsertItems(var AMenu: TMenu; MainItem: TElMenuItem; Index: Integer;
  Items: array of TElMenuItem);
procedure InsertMenuItems(var AMenu: TMenu; Index: Integer; Items: array of
  TElMenuItem);

//vAd:

procedure ElLoadItemsFromFiles(Menu: TMenu; const ItemsFileName: array of TLMDString);

function ElNewMenu(Owner: TComponent; const AName: TLMDString;
  Items: array of TElMenuItem): TElMainMenu;

function ElNewSubMenu(const ACaption: TLMDString; hCtx: Word;
  const AName: TLMDString; Items: array of TElMenuItem;
  AEnabled: Boolean): TElMenuItem;

function ElNewItem(const ACaption: TLMDString; AShortCut: TShortCut;
  AChecked, AEnabled: Boolean; AOnClick: TNotifyEvent;
  hCtx: Word; const AName: TLMDString;
  MenuItemClass: TElMenuItemClass; const AImageIndex: Integer = -1): TElMenuItem;

function ElNewLine: TElMenuItem;

function ElStripHotKey(const Text: TLMDString): TLMDString;
function ElGetHotkey(const Text: TLMDString): TLMDString;
procedure ElInitMenuItems(AMenu: TMenu; Items: array of TElMenuItem);

function GetMenuFont: HFont;

procedure IterateMenus(Func: TLMDIterator; Menu1, Menu2: TElMenuItem);

procedure TrackElPopupMenu(Menu: TElMenuItem; Flags: integer; X, Y: integer; Target: THandle);
procedure CancelElMenu(ManualCancel : boolean);

//var
//  FTheme: HTheme;

{$IFDEF LMD_DEBUGMESSAGES}
var
  bMonitorMessage: Boolean;
{$ENDIF IFDEF LMD_DEBUGMESSAGES}

type
  TPassthroughMouse = (pmNone, pmDblClk, pmMove);
  TMenuScrollArrow = (msNone, msTop, msBottom);
  TMenuSelectedWith = (swNone, swMouse, swKeyboard);
  TMenuPopupAction = (paShow, paClose);

  TElPopupTracker = class;

  {$warnings off}
  TElPopupWindow = class(TCustomForm)
  private
    FAlphaImages: TCustomImageList;
    FDrawStyle: TDrawStyle;
    FImages: TCustomImageList;
    FMenuItem: TElMenuItem;
    FPopupTimer: TElTimerPoolItem;
    FRightToLeft: boolean;
    FScrollTimer: TElTimerPoolItem;
    FTracker: TElPopupTracker;

    FColumnItems: array of integer; // indexes of first items for each column
    FColumnWidths: array of integer; // widths of columns
    FItemHeights: array of integer; // heights of items
    FItemRects: array of TRect; // rectangles where the items are drawn
    FTopItem: integer; // index of top item to be drawn in scrollable menu
    FLastItem: integer; // index of last item drawn in scrollable menu
    FScrollable: boolean; // True if the menu is scrollable;
                                      // False if the menu is columned
    FScrollActive: boolean; // True if scroll arrows are to be drawn
    FScrollableTopToBottom: boolean; // True if the items are to be drawn
                                      // using top to bottom direction (OfficeXP style only)
    FBottomArrowRect: TRect;
      // rectangle where the bottom scrolling arrow is drawn
    FTopArrowRect: TRect; // rectangle where the top scrolling arrow is drawn
    FActiveScrollArrow: TMenuScrollArrow;
    FSelectedWithMouse: integer; // index of the item selected with mouse;
                                      // -1 if no item selected
    FSelectedWithKeyboard: integer; // index of the item selected with keyboard;
                                      // -1 if no item selected
    FLastSelectedWith: TMenuSelectedWith;
    FScrolling: boolean;

    FPaintBuffer: TBitmap;
    FPainting: boolean;

    FPopupAction: TMenuPopupAction;
    FPopupItem: integer;
    FSubmenuItem: integer;

    FPrevPopupWindow: TElPopupWindow;
    ExcludeRect: TRect;

    procedure PopupTimerTick(Sender: TObject);
    procedure ScrollTimerTick(Sender: TObject);
    procedure StartClosePopup;
    procedure StartShowPopup(Item: integer);
    procedure StopPopup;
    procedure WMChar(var Msg: TWMChar); message WM_CHAR;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMKeyDown(var Msg: TWMKeyDown); message WM_KEYDOWN;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseActivate(var Msg: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMMouseMove(var Msg: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMRButtonDown(var Msg: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMRButtonUp(var Msg: TWMRButtonUp); message WM_RBUTTONUP;
    procedure SetSubmenuItem(const Value: integer);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CloseSubmenus;
    function FindFirstVisibleItem: integer;
    function FindLastVisibleItem: integer;
    function FindNextItem(Index: integer): integer;
    function FindPrevItem(Index: integer): integer;
    function GetDrawStyle: TDrawStyle; virtual;
    function GetItemColumnIndex(Item: integer): integer;
    function GetSelectedItem: integer; virtual;
    function InBottomArrowArea(X, Y: integer): boolean;
    function InTopArrowArea(X, Y: integer): boolean;
    function IsRightToLeft: boolean;
    function ItemFromPoint(X, Y: integer): integer;
    procedure DrawColumnedWndLeftToRight(Canvas: TCanvas); virtual;
    procedure DrawScrollableWndLeftToRight(Canvas: TCanvas); virtual;
    procedure DrawColumnedWndRightToLeft(Canvas: TCanvas); virtual;
    procedure DrawScrollableWndRightToLeft(Canvas: TCanvas); virtual;
    procedure DrawOfficeXPBorder(Canvas : TCanvas; var R : TRect);

    procedure MeasureBounds; virtual;
    procedure Paint; override;
    procedure RedrawItem(Index: integer); dynamic;
    procedure ScrollDown;
    procedure ScrollUp;
    procedure SelectFirstItem;
    procedure SelectLastItem;
    procedure SelectLeftItem(Column: integer);
    procedure SelectNextItem;
    procedure SelectPrevItem;
    procedure SelectRightItem(Column: integer);
    procedure ShowSubmenu(Item: integer);
    function TrackRightButton: boolean; dynamic;
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure NotifyMenuSelect(ItemIndex : integer; Item : TElMenuItem);
    procedure NotifyHelpRequest;
  public
    constructor Create(Tracker: TElPopupTracker; Menu: TElMenuItem;
      DrawStyle: TDrawStyle; Font: TFont; RightToLeft: boolean;
      Images, AlphaImages: TCustomImageList; SelectFirst: boolean); reintroduce;
        virtual;
    destructor Destroy; override;
    function IsThemed: boolean;
    procedure EndMenu;

    property SelectedItem: integer read GetSelectedItem;
    property SubmenuItem: integer read FSubmenuItem write SetSubmenuItem;

    property MenuItem: TElMenuItem read FMenuItem;
    property SelectedWidthMouse: integer read FSelectedWithMouse;
    property SelectedWidthKeyboard: integer read FSelectedWithKeyboard;
    property LastSelectedWith: TMenuSelectedWith read FLastSelectedWith;
    //FPopupAction: TMenuPopupAction;
    //FPopupItem: integer;
    //property SubmenuItem: integer read FSubmenuItem;

  end;
  {$warnings on}

  TElPopupTracker = class
  private
    FAlphaImages: TCustomImageList;
    FDrawStyle: TDrawStyle;
    FFlags: integer;
    FFont: TFont;
    FImages: TCustomImageList;
    FMessageWnd: THandle;
    FRightToLeft: boolean;
    FPassthroughMouse: TPassthroughMouse;
    FTarget: THandle;
    FTerminated: boolean;
    FTermCancel: boolean;
    FTimers: TElTimerPool;
    FTrackerWnd: THandle;
    FWindows: TList;
    FSystemShadows: Boolean;
    FShadows: TList;
    procedure WMCancelMode(var Msg: TWMCancelMode); message WM_CANCELMODE;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKeyDown(var Msg: TWMKeyDown); message WM_KEYDOWN;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseMove(var Msg: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMRButtonDown(var Msg: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMRButtonUp(var Msg: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMSysKeyDown(var Msg: TWMSysKeyDown); message WM_SYSKEYDOWN;
    procedure ELMenuSelect(var Message: TMessage); message EL_MENUSELECT;
  protected
    FOnMouseMove: TMouseMoveEvent;
    function AddPopupTimer: TElTimerPoolItem;
    function AddScrollTimer: TElTimerPoolItem;
    procedure CloseLastPopupWindow; virtual;
    procedure CloseWindows; virtual;
    procedure DeletePopupTimer(Timer: TElTimerPoolItem);
    procedure DeleteScrollTimer(Timer: TElTimerPoolItem);
    function FindPopupWindow(X, Y: integer): integer;
    procedure InternalTrack(Menu : TElPopupMenu; MenuItem : TElMenuItem; X, Y1, Y2:
        integer; Flags: integer; ExcludeRect: TRect; SelectFirstItem: boolean);
        virtual;
    function MouseInOtherWindow(Window: TElPopupWindow; X, Y: integer): boolean;
    function SubmenuShown(Window: TElPopupWindow): boolean;
    procedure TrackerWndProc(var Msg: TMessage); virtual;
    procedure NotifyButton(Key : Word);
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure EndMenu(ManualCancel: boolean); virtual;
    procedure Track(Menu: TElMenuItem; X, Y: integer; Flags: integer;
      Target: THandle; PassthroughMouse: TPassthroughMouse); virtual;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
  end;

  TElBarPopupMenu = class(TElPopupMenu) end;

var
  ActivePopupWindow: TElPopupWindow;

implementation

uses
  ElMenuBar, LMDUtils;

//const
//  Alignments: array[TPopupAlignment] of word = (DT_LEFT, DT_RIGHT, DT_CENTER);

{
function TrackPopupMenu(hMenu: HMENU; uFlags: UINT; x, y, nReserved: Integer;
  hWnd: HWND; prcRect: PRect): BOOL; stdcall;
{}

procedure TrackElPopupMenu(Menu: TElMenuItem; Flags: integer; X, Y: integer;
  Target: THandle);
var
  Tracker: TElPopupTracker;
begin
  Tracker := TElPopupTracker.Create;
  try
    Tracker.Track(Menu, X, Y, Flags, Target, pmNone);
  finally
    Tracker.Free;
  end;
end;

var
  ElPopupTracker: TElPopupTracker;
  MenuClicker   : HWND;

procedure CancelElMenu(ManualCancel : boolean);
begin
  if ElPopupTracker <> nil then
  begin
    //SendMessage( ElPopupTracker.FTrackerWnd, WM_CLOSE, 0, 0);
    //SendMessage( ElPopupTracker.FTrackerWnd, WM_QUIT, 0, 0);
    ElPopupTracker.EndMenu(ManualCancel); //CloseWindows;
  end;
end;

{function QueryThemeData : boolean;
var hTestTheme : HTheme;
begin
  result := false;
  hTestTheme := Open.ThemeData(0, 'WINDOW');
  if hTestTheme <> 0 then
  begin
    result := true;
    Close.ThemeData(hTestTheme);
  end;
  if result = false then
  begin
    hTestTheme := Open.ThemeData(0, 'MENU');
    if hTestTheme <> 0 then
    begin
      result := true;
      Close.ThemeData(hTestTheme);
    end;
  end;
end;}

{$IFDEF LMD_UNICODE}

type
  GetMenuStringWProc = function(hMenu: HMENU; uIDItem: UINT; lpString:
    PWideChar;
    nMaxCount: Integer; uFlag: UINT): Integer; stdcall;
var
  GetMenuStringW: GetMenuStringWProc;

{$ENDIF}

const

  RightToLeftMenuFlag = MFT_RIGHTORDER or MFT_RIGHTJUSTIFY;
  (*
  cMenuAutoFlagToItem: array [TMenuAutoFlag] of TMenuItemAutoFlag = (maAutomatic, maManual);
  cItemAutoFlagToMenu: array [TMenuItemAutoFlag] of TMenuAutoFlag = (maAutomatic, maManual, maAutomatic);
  cBooleanToItemAutoFlag: array [Boolean] of TMenuItemAutoFlag = (maManual, maAutomatic);
  cItemAutoFlagToBoolean: array [TMenuItemAutoFlag] of Boolean = (True, False, True);
  //*)

//var
//  CommandPool: TBits;

(*
function PatternBitmap(FgColor, BkColor: TColor): TBitmap;
var
  X, Y: Integer;
begin
  Result := TBitmap.Create;
  try
    with Result do
    begin
      Width := 8;
      Height := 8;
      with Canvas do
      begin
        Brush.Style := bsSolid;
        Brush.Color := BkColor;
        FillRect(Rect(0, 0, Width, Height));
        for Y := 0 to 8 do
          for X := 0 to 8 do
            if (Y mod 2) = (X mod 2) then
              Pixels[X, Y] := FgColor;
      end;
    end;
  except
    Result.Free;
  end;
end;
 *)

function ElShortCutToText(Value: TShortCut): String;
begin
  if (Value and scWin) = scWin then
  begin
    Value := Value and not scWin;
    Result := ShortCutToText(Value);
    Result := SLMDLWinP + Result;
  end
  else
    Result := ShortCutToText(Value);
end;

{procedure DrawGrayBitmap(Canvas: TCanvas; X, Y: integer; ABitmap: TBitmap);
var
  R: TRect;
  DestDC, SrcDC: HDC;
const
  ROP_DSPDxax = $00E20746;

begin
  R := Rect(X, Y, X + ABitmap.Width, Y + ABitmap.Height);
  SrcDC := ABitmap.Canvas.Handle;
//  Convert Black to clBtnHighlight
  //Canvas.Brush.Color := clBtnHighlight;
  Canvas.Brush.Color := clBtnShadow;
  DestDC := Canvas.Handle;
  Windows.SetTextColor(DestDC, clWhite);
  Windows.SetBkColor(DestDC, clBlack);
  BitBlt(DestDC, X + 1, Y + 1, ABitmap.Width, ABitmap.Height, SrcDC, 0, 0,
    ROP_DSPDxax);
// Convert Black to clBtnShadow
  //Canvas.Brush.Color := clBtnShadow;
  Canvas.Brush.Color := clBtnHighlight;
  DestDC := Canvas.Handle;
  Windows.SetTextColor(DestDC, clWhite);
  Windows.SetBkColor(DestDC, clBlack);
  BitBlt(DestDC, X, Y, ABitmap.Width, ABitmap.Height, SrcDC, 0, 0, ROP_DSPDxax);
end;
}
procedure GrayBitmap(ImageList: TCustomImageList; ImageIndex: integer; var
  DisBitmap: TBitmap);
begin
  if DisBitmap = nil then
  begin
    DisBitmap := TBitmap.Create;
    with DisBitmap do
    begin
      Monochrome := True;
      Width := TCustomImageList(ImageList).Width;
      Height := TCustomImageList(ImageList).Height;
    end;
    { Store masked version of image temporarily in FBitmap }
    DisBitmap.Canvas.Brush.Color := clWhite;
    DisBitmap.Canvas.FillRect(Rect(0, 0, TCustomImageList(ImageList).Width,
      TCustomImageList(ImageList).Height));
    ImageList_DrawEx(ImageList.Handle, ImageIndex, DisBitmap.Canvas.Handle, 0,
      0, 0, 0,
      CLR_DEFAULT, 0, ILD_NORMAL);
  end;
  (*
  lc := 0;
  nc := 0;
  for i := 0 to ABitmap.Height do
    for j := 0 to ABitmap.Width do
    begin
      if nc <> ABitmap.TransparentColor then
      begin
        if nc <> ABitmap.Canvas.Pixels[j, i] then
        begin
          lc := ColorToGray(ABitmap.Canvas.Pixels[j, i]);
          ABitmap.Canvas.Pixels[j, i] := lc;
        end
        else
          ABitmap.Canvas.Pixels[j, i] := lc;
      end
    end;
  //*)
end;

{procedure ShadowBitmap(ABitmap: TBitmap);
var
  i, j: integer;
begin
  for i := 0 to ABitmap.Height - 1 do
    for j := 0 to ABitmap.Width - 1 do
    begin
      if ABitmap.Canvas.Pixels[j, i] <> Integer(RGB(255, 255, 255)) then
        ABitmap.Canvas.Pixels[j, i] := clBtnShadow
      else
        ABitmap.Canvas.Pixels[j, i] := RGB(254, 254, 254);
    end;
end;
}
procedure DrawGrayedImage(Images: TCustomImageList; Index: integer;
  Canvas: TCanvas; X, Y: integer; Color: TColor = clBtnShadow);
var
  Bmp: TBitmap;
//  I, J: integer;
  tc: TColor;
begin
  if Images is TLMDPNGImageList then
  begin
//    with TLMDPNGGrayscaleFilter.Create do
//    begin
//      SourceImage := TLMDPNGImageList(Images).PNG[Index];
//      ResultImage.Draw(Canvas, Rect(X, Y, X + Images.Width, Y + Images.Height));
//    end;
    with TLMDPNGAlphaBlendFilter.Create do
    begin
      SourceImage := TLMDPNGImageList(Images).PNG[Index];
      AlphaPercent := 40;
      ResultImage.Draw(Canvas, Rect(X, Y, X + Images.Width, Y + Images.Height));
      Free;
    end;
  end
  else
  begin
    Bmp := TBitmap.Create;
    try
      Bmp.PixelFormat := pf24bit;
      Bmp.Width := TCustomImageList(Images).Width;
      Bmp.Height := TCustomImageList(Images).Height;
      ImageList_DrawEx(Images.Handle, Index, Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height,
        CLR_NONE, clNone, ILD_Normal);
      LMDSetDisabled(Bmp);
      tc := Bmp.Canvas.Pixels[0, BMP.Height - 1];
      Canvas.Brush.Color := tc;
      Canvas.Brush.Style := bsClear;
      LMDDrawTransparentBitmapEx(Canvas.Handle, Bmp, X, Y, Rect(0, 0, BMP.Width, BMP.Height), TC);
    finally
      Bmp.Free;
    end;
  end;
end;

procedure MaskImage(Image: TBitmap; BackColor: TColor; MaskColor: TColor);
var
  I, J: integer;
  Invert: boolean;
  Color: TColor;
begin
  BackColor := ColorToRGB(BackColor);
  MaskColor := ColorToRGB(MaskColor);
  Invert := (BackColor = MaskColor);
  for I := 0 to Image.Width - 1 do
    for J := 0 to Image.Height - 1 do
    begin
      Color := Image.Canvas.Pixels[I, J];
      if Color <> BackColor then
        Image.Canvas.Pixels[I, J] := MaskColor
      else
        if Invert then
        Image.Canvas.Pixels[I, J] := not Color;
    end;
end;

(*
function UniqueCommand: Word;
begin
  Result := CommandPool.OpenBit;
  CommandPool[Result] := True;
end;
*)

function GetMenuFont: HFont;
var
  NCM: TNonClientMetrics;
begin
  {$IFDEF LMDCOMP14}
  NCM.cbSize := TNonClientMetrics.SizeOf;
  {$ELSE}
  NCM.cbSize := SizeOf(TNonClientMetrics);
  {$ENDIF}
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, NCM.cbSize, @NCM, 0) then
    Result := CreateFontIndirect(NCM.lfMenuFont)
  else
    Result := GetStockObject(SYSTEM_FONT);
end;

{ Used to populate or merge menus }
procedure IterateMenus(Func: TLMDIterator; Menu1, Menu2: TElMenuItem);
var
  I, J: Integer;
  IIndex, JIndex: Byte;
  Menu1Size, Menu2Size: Integer;
  Done: Boolean;

  function Iterate(var I: Integer; MenuItem: TElMenuItem; AFunc: TLMDIterator):
    Boolean;
  var
    Item: TElMenuItem;
  begin
    Result := False;
    if MenuItem = nil then
      Exit;
    while not Result and (I < MenuItem.Count) do
    begin
      Item := MenuItem[I];
      if Item.GroupIndex > IIndex then
        Break;
      {$IFDEF LMD_ITERATOR_OBJECTS}
      Result := AFunc(Item);
      {$ELSE}
       asm
        MOV     EAX,Item
        MOV     EDX,[EBP+8]
        PUSH    DWORD PTR [EDX]
        CALL    DWORD PTR AFunc
        ADD     ESP,4
        MOV     Result,AL
      end;
      {$ENDIF}
      Inc(I);
    end;
  end;

begin
  I := 0;
  J := 0;
  Menu1Size := 0;
  Menu2Size := 0;
  if Menu1 <> nil then
    Menu1Size := Menu1.Count;
  if Menu2 <> nil then
    Menu2Size := Menu2.Count;
  Done := False;
  while not Done and ((I < Menu1Size) or (J < Menu2Size)) do
  begin
    IIndex := High(Byte);
    JIndex := High(Byte);
    if (I < Menu1Size) then
      IIndex := Menu1[I].GroupIndex;
    if (J < Menu2Size) then
      JIndex := Menu2[J].GroupIndex;
    if IIndex <= JIndex then
      Done := Iterate(I, Menu1, Func)
    else
    begin
      IIndex := JIndex;
      Done := Iterate(J, Menu2, Func);
    end;
    while (I < Menu1Size) and (Menu1[I].GroupIndex <= IIndex) do
      Inc(I);
    while (J < Menu2Size) and (Menu2[J].GroupIndex <= IIndex) do
      Inc(J);
  end;
end;

procedure TMenuActionLink.AssignClient(AClient: TObject);
begin
  FClient := AClient as TElMenuItem;
end;

function TMenuActionLink.IsCaptionLinked: Boolean;
{$ifdef LMD_UNICODE}
var
  PropInfo: PPropInfo;
{$endif}
begin
{$ifdef LMD_UNICODE}
  PropInfo := TypInfo.GetPropInfo(Action.ClassInfo, 'Caption');
  if (PropInfo <> nil) then
    Result := (Action is TCustomAction) and (FClient.Caption = GetWideStrProp(Action, 'Caption'))
  else
    Result := inherited IsCaptionLinked;
{$else}
  Result := inherited IsCaptionLinked and
    (FClient.Caption = (Action as TCustomAction).Caption);
{$endif}
end;

function TMenuActionLink.IsCheckedLinked: Boolean;
begin
  Result := inherited IsCheckedLinked and
    (FClient.Checked = (Action as TCustomAction).Checked);
end;

function TMenuActionLink.IsEnabledLinked: Boolean;
begin
  Result := inherited IsEnabledLinked and
    (FClient.Enabled = (Action as TCustomAction).Enabled);
end;

{
function TMenuActionLink.IsHelpContextLinked: Boolean;
begin
  Result := inherited IsHelpContextLinked and
    (FClient.HelpContext = (Action as TCustomAction).HelpContext);
end;{}

function TMenuActionLink.IsHintLinked: Boolean;
{$ifdef LMD_UNICODE}
var
  PropInfo: PPropInfo;
{$endif}
begin
{$ifdef LMD_UNICODE}
  PropInfo := TypInfo.GetPropInfo(Action.ClassInfo, 'Hint');
  if (PropInfo <> nil) then
    Result := (Action is TCustomAction) and (FClient.Hint = GetWideStrProp(Action, 'Hint'))
  else
    Result := inherited IsHintLinked;
{$else}
  Result := inherited IsHintLinked and
    (FClient.Hint = (Action as TCustomAction).Hint);
{$endif}
end;

function TMenuActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
    (FClient.ImageIndex = (Action as TCustomAction).ImageIndex);
end;

function TMenuActionLink.IsShortCutLinked: Boolean;
begin
  Result := inherited IsShortCutLinked and
    (FClient.ShortCut = (Action as TCustomAction).ShortCut);
end;

function TMenuActionLink.IsVisibleLinked: Boolean;
begin
  Result := inherited IsVisibleLinked and
    (FClient.Visible = (Action as TCustomAction).Visible);
end;

function TMenuActionLink.IsOnExecuteLinked: Boolean;
begin
  Result := inherited IsOnExecuteLinked and
    (@FClient.OnClick = @Action.OnExecute);
end;

procedure TMenuActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then FClient.Caption := Value;
end;

procedure TMenuActionLink.SetChecked(Value: Boolean);
begin
  if IsCheckedLinked then FClient.Checked := Value;
end;

procedure TMenuActionLink.SetEnabled(Value: Boolean);
begin
  if IsEnabledLinked then FClient.Enabled := Value;
end;

procedure TMenuActionLink.SetHelpContext(Value: THelpContext);
begin
  if IsHelpContextLinked then FClient.HelpContext := Value;
end;

procedure TMenuActionLink.SetHint(const Value: string);
begin
  if IsHintLinked then FClient.Hint := Value;
end;

procedure TMenuActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then FClient.ImageIndex := Value;
end;

procedure TMenuActionLink.SetShortCut(Value: TShortCut);
begin
  if IsShortCutLinked then FClient.ShortCut := Value;
end;

procedure TMenuActionLink.SetVisible(Value: Boolean);
begin
  if IsVisibleLinked then FClient.Visible := Value;
end;

procedure TMenuActionLink.SetOnExecute(Value: TNotifyEvent);
begin
  if IsOnExecuteLinked then FClient.OnClick := Value;
end;

{ TElMenuItem }
constructor TElMenuItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FState := [odDefault];
  FVisible := True;
  FEnabled := True;
  // FCommand := UniqueCommand;
  FCommand := inherited Command;
  FImageIndex := -1;
  FProcessShortCut := True;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FAImageChangeLink := TChangeLink.Create;
  FAImageChangeLink.OnChange := ImageListChange;
end;

destructor TElMenuItem.Destroy;
begin
  if FParent <> nil then
  begin
    FParent.Remove(Self);
    FParent := nil;
  end;

  while Count > 0 do
    Items[0].Free;

  if FHandle <> 0 then
  begin
    MergeWith(nil);
    DestroyMenu(FHandle);
  end;
  FItems.Free;

  FreeAndNil(FActionLink);

  FreeAndNil(FImageChangeLink);
  FreeAndNil(FAImageChangeLink);
  if Assigned(FBitmap) then FBitmap.Free;
  if Assigned(FDisBitMap) then FDisBitMap.Free;
  inherited Destroy;
end;

function TElMenuItem.InternalRethinkLines(ForceRethink: Boolean): Boolean;
var
  I, LLastAt: Integer;
  LLastBar: TElMenuItem;
begin
  Result := False;
  if ForceRethink or
     (not (csDesigning in ComponentState) and GetAutoLineReduction) then
  begin
    LLastAt := 0;
    LLastBar := nil;
    for I := LLastAt to Count - 1 do
      if Items[I].FVisible then
        if Items[I].IsLine then
        begin
          Items[I].Visible := False;
          Result := True;
        end
        else
        begin
          LLastAt := I;
          System.Break;
        end;
    for I := LLastAt to Count - 1 do
      if Items[I].IsLine then
      begin
        if (LLastBar <> nil) and (LLastBar.FVisible) then
        begin
          LLastBar.Visible := False;
          Result := True;
        end;
        LLastBar := Items[I];
      end
      else if Items[I].FVisible then
      begin
        if (LLastBar <> nil) and (not LLastBar.FVisible) then
        begin
          LLastBar.Visible := True;
          Result := True;
        end;
        LLastBar := nil;
        LLastAt := I;
      end;
    for I := Count - 1 downto LLastAt do
      if Items[I].FVisible then
        if Items[I].IsLine then
        begin
          Items[I].Visible := False;
          Result := True;
        end
        else
          System.Break;
  end;
end;

procedure TElMenuItem.SetSubMenuImages(Value: TCustomImageList);
begin
  if FSubMenuImages <> nil then
    FSubMenuImages.UnRegisterChanges(FImageChangeLink);
  FSubMenuImages := Value;
  if FSubMenuImages <> nil then
  begin
    FSubMenuImages.RegisterChanges(FImageChangeLink);
    FSubMenuImages.FreeNotification(Self);
  end;
  UpdateItems;
end;

procedure TElMenuItem.SetAlphaSubMenuImages(Value: TCustomImageList);
begin
  if FAlphaSubMenuImages <> nil then
    FAlphaSubMenuImages.UnRegisterChanges(FAImageChangeLink);
  FAlphaSubMenuImages := Value;
  if FAlphaSubMenuImages <> nil then
  begin
    FAlphaSubMenuImages.RegisterChanges(FAImageChangeLink);
    FAlphaSubMenuImages.FreeNotification(Self);
  end;
  MenuChanged(False);
  IntMenuChanged(False);
  UpdateItems;
end;

procedure TElMenuItem.ImageListChange(Sender: TObject);
begin
  if Sender = SubMenuImages then
    UpdateItems;
end;

{$ifdef LMDX64}
type
  TElMenuUpdater = class
    function UpdateItem(AMenuItem: TElMenuItem): Boolean;
    class procedure DoIterateMenus(AMenu1, AMenu2: TElMenuItem);
  end;

function TElMenuUpdater.UpdateItem(AMenuItem: TElMenuItem): Boolean;
begin
  Result := False;
  IterateMenus(Self.UpdateItem, AMenuItem.FMerged, AMenuItem);
  AMenuItem.SubItemChanged(AMenuItem, AMenuItem, True);
end;

class procedure TElMenuUpdater.DoIterateMenus(AMenu1, AMenu2: TElMenuItem);
var
  LMenuUpdater: TElMenuUpdater;
begin
  LMenuUpdater := TElMenuUpdater.Create;
  try
    IterateMenus(LMenuUpdater.UpdateItem, AMenu1, AMenu2);
  finally
    LMenuUpdater.Free;
  end;
end;

procedure TElMenuItem.UpdateItems;
begin
  TElMenuUpdater.DoIterateMenus(FMerged, Self);
end;

{$else}
procedure TElMenuItem.UpdateItems;
  function UpdateItem(MenuItem: TElMenuItem): Boolean;
  begin
    Result := False;
    IterateMenus(@UpdateItem, MenuItem.FMerged, MenuItem);
    MenuItem.SubItemChanged(MenuItem, MenuItem, True);
  end;
begin
  IterateMenus(@UpdateItem, FMerged, Self);
end;
{$endif}

const
  SPI_GETDROPSHADOW = $1024;
  CS_DROPSHADOW = $20000;

  Checks: array[Boolean] of DWORD = (MF_UNCHECKED, MF_CHECKED);
  Enables: array[Boolean] of DWORD = (MF_DISABLED or MF_GRAYED, MF_ENABLED);
  (*
  Breaks: array[TMenuBreak] of DWORD = (0, MF_MENUBREAK, MF_MENUBARBREAK);
  Separators: array[Boolean] of DWORD = (MF_STRING, MF_SEPARATOR);
  //*)

procedure TElMenuItem.AppendTo(Menu: HMENU; ARightToLeft: Boolean);
const
  IBreaks: array[TMenuBreak] of DWORD = (MFT_STRING, MFT_MENUBREAK,
    MFT_MENUBARBREAK);
  IChecks: array[Boolean] of DWORD = (MFS_UNCHECKED, MFS_CHECKED);
  IDefaults: array[Boolean] of DWORD = (0, MFS_DEFAULT);
  IEnables: array[Boolean] of DWORD = (MFS_DISABLED or MFS_GRAYED, MFS_ENABLED);
  IRadios: array[Boolean] of DWORD = (MFT_STRING, MFT_RADIOCHECK);
  ISeparators: array[Boolean] of DWORD = (MFT_STRING, MFT_SEPARATOR);
  IRTL: array[Boolean] of DWORD = (0, RightToLeftMenuFlag);
  IOwnerDraw: array[Boolean] of DWORD = (MFT_STRING, MFT_OWNERDRAW);

var
  {$ifdef LMDCOMP12}
  MenuItemInfo : TMenuItemInfoW;
  {$else}
  MenuItemInfo: TMenuItemInfoA;
  {$endif}
  Caption: TLMDString;
  //NewFlags: Integer;
  IsOwnerDraw: Boolean;
  ParentMenu: TMenu;
begin
  if FVisible then
  begin
    Caption := FCaption;
    if GetCount > 0 then
      MenuItemInfo.hSubMenu := GetHandle
    else
      if (FShortCut <> scNone) and ((Parent = nil) or
      (Parent.Parent <> nil) or not (Parent.Owner is TElMainMenu)) and
      (Caption <> cLineCaption) then
      Caption := Caption + #9 + ElShortCutToText(FShortCut);
    //if Lo(GetVersion) >= 4 then
    begin
      FillChar(MenuItemInfo, SizeOf(MenuItemInfo), 0);
      with MenuItemInfo do
      begin
        cbSize := {$IFDEF LMDX64}SizeOf(MenuItemInfo);{$ELSE}44{$ENDIF}; // Required for Windows 95
        fMask := MIIM_CHECKMARKS or MIIM_DATA or MIIM_ID or
          MIIM_STATE or MIIM_SUBMENU or MIIM_TYPE;
        ParentMenu := GetParentMenu;
        if ParentMenu <> nil then
        begin
          if ParentMenu is TElPopupMenu then
            IsOwnerDraw := TElPopupMenu(ParentMenu).IsOwnerDraw
          else
            if ParentMenu is TElMainMenu then
            IsOwnerDraw := TElMainMenu(ParentMenu).IsOwnerDraw
          else
            IsOwnerDraw := false;
        end
        else
          exit;

        // IsOwnerDraw := Assigned(ParentMenu) and IsOwnerDraw or
        //  Assigned(FBitmap) and not FBitmap.Empty;
        fType := IRadios[FRadioItem] or IBreaks[FBreak] or
          ISeparators[Caption = cLineCaption] or IRTL[ARightToLeft] or
          IOwnerDraw[IsOwnerDraw];
        fState := IChecks[FChecked] or IEnables[FEnabled]
          or IDefaults[FDefault];
        wID := Command;
        {
        if Caption <> cLineCaption then
          wID := Command
        else
          wID := 0;
        }
        hSubMenu := 0;
        hbmpChecked := 0;
        hbmpUnchecked := 0;
        {$ifdef LMDCOMP12}
        dwTypeData := PWideChar(WideString(Caption));
        {$else}
        dwTypeData := PAnsiChar(AnsiString(Caption));
        {$endif}
        if GetCount > 0 then
          hSubMenu := GetHandle;
        dwItemData := TLMDPtrUInt(Self);
        //{$ifdef LMD_UNICODE}
        //InsertMenuItemW(Menu, DWORD(-1), True, MenuItemInfo);
        //{$else}
        //InsertMenuItemA(Menu, DWORD(-1), True, MenuItemInfo);
        //{$endif}
        InsertMenuItem(Menu, DWORD(-1), True, MenuItemInfo);
        end;
    (*end
    else
    begin
      NewFlags := Breaks[FBreak] or Checks[FChecked] or Enables[FEnabled] or
        Separators[FCaption = '-'] or MF_BYPOSITION;
      if GetCount > 0 then
        {$ifdef LMD_UNICODE}
        InsertMenuW(Menu, DWORD(-1), MF_POPUP or NewFlags, GetHandle, PWideChar(FCaption))
        {$else}
        InsertMenuA(Menu, DWORD(-1), MF_POPUP or NewFlags, GetHandle, PChar(FCaption))
        {$endif}
      else
        {$ifdef LMD_UNICODE}
        InsertMenuW(Menu, DWORD(-1), NewFlags, Command, PWideChar(Caption));
        {$else}
        InsertMenuA(Menu, DWORD(-1), NewFlags, Command, PChar(Caption));
        {$endif}
    //*)
    end;
  end;
end;


{$ifdef LMDX64}
type
  TElMenuPopulator = class
    FHandle: HMENU;
    MenuRightToLeft: Boolean;
    function AddIn(AMenuItem: TElMenuItem): Boolean;
  end;

function TElMenuPopulator.AddIn(AMenuItem: TElMenuItem): Boolean;
begin
  AMenuItem.AppendTo(FHandle, MenuRightToLeft);
  Result := False;
end;

procedure TElMenuItem.PopulateMenu;
var
  LMenuPopulator: TElMenuPopulator;
begin
  if (FMenu <> nil) and ((FMenu is TElMainMenu) or (FMenu is TElPopupMenu)) then
  begin
    InternalRethinkLines(False);
  end;

  // all menu items use BiDiMode of their root menu
  LMenuPopulator := TElMenuPopulator.Create;
  try
    LMenuPopulator.FHandle := Handle;
    LMenuPopulator.MenuRightToLeft := (FMenu <> nil) and FMenu.IsRightToLeft;
    IterateMenus(LMenuPopulator.AddIn, FMerged, Self);
  finally
    LMenuPopulator.Free;
  end;
end;
{$else}
procedure TElMenuItem.PopulateMenu;
var
  MenuRightToLeft: Boolean;

  function AddIn(MenuItem: TElMenuItem): Boolean;
  begin
    MenuItem.AppendTo(FHandle, MenuRightToLeft);
    Result := False;
  end;

begin // all menu items use BiDiMode of their root menu
  if (FMenu <> nil) and ((FMenu is TElMainMenu) or (FMenu is TElPopupMenu)) then
  begin
    InternalRethinkLines(False);
  end;
  MenuRightToLeft := (FMenu <> nil) and FMenu.IsRightToLeft;
  IterateMenus(@AddIn, FMerged, Self);
end;
{$endif}

procedure TElMenuItem.ReadShortCutText(Reader: TReader);
begin
  ShortCut := TextToShortCut(Reader.ReadString);
end;

procedure TElMenuItem.MergeWith(Menu: TElMenuItem);
begin
  if FMerged <> Menu then
  begin
    if FMerged <> nil then
      FMerged.FMergedWith := nil;
    FMerged := Menu;
    if FMerged <> nil then
      FMerged.FMergedWith := Self;
    RebuildHandle;
  end;
end;

procedure TElMenuItem.Loaded;
begin
  inherited Loaded;

  if Action <> nil then ActionChange(Action, True);

  if FStreamedRebuild then RebuildHandle;
end;

procedure TElMenuItem.RebuildHandle;
begin
  if csDestroying in ComponentState then
    Exit;
  if csReading in ComponentState then
    FStreamedRebuild := True
  else
  begin
    if FMergedWith <> nil then
      FMergedWith.RebuildHandle
    else
    begin
      while GetMenuItemCount(Handle) > 0 do
        RemoveMenu(Handle, 0, MF_BYPOSITION);
      PopulateMenu;
      MenuChanged(False);
    end;
  end;
end;

procedure TElMenuItem.VerifyGroupIndex(Position: Integer; Value: Byte);
var
  I: Integer;
begin
  for I := 0 to GetCount - 1 do
    if I < Position then
    begin
      if Items[I].GroupIndex > Value then
        EMenuError.CreateFmt('Group Index Too Low', [Name]);
    end
    else
      { Ripple change to menu items at Position and after }
      if Items[I].GroupIndex < Value then
      Items[I].FGroupIndex := Value;
end;

procedure TElMenuItem.WriteShortCutText(Writer: TWriter);
begin
  Writer.WriteString(ElShortCutToText(ShortCut));
end;

function TElMenuItem.GetHandle: HMENU;
begin
  if FHandle = 0 then
  begin
    if Owner is TPopupMenu then
      FHandle := CreatePopupMenu
    else
      FHandle := CreateMenu;
    if FHandle = 0 then
      raise EMenuError.CreateFmt('Out Of Resources', [Name]);
    PopulateMenu;
  end;
  Result := FHandle;
end;

procedure TElMenuItem.DoDrawText(ACanvas: TCanvas; const ACaption: TLMDString;
  var Rect: TRect; Selected: Boolean; Flags: Longint);
var
  Text: TLMDString;
  R: TRect;
  ParentMenu: TMenu;
  DrawStyle: TDrawStyle;
  SaveColor : TColor;

  IsHTML: boolean;
  Render: TLMDHTMLRender;
  APos: integer;
  LForm: TForm;
  b: boolean;
  LThemeMode: TLMDThemeMode;
begin
  ParentMenu := GetParentMenu;
  if ((ParentMenu is TElPopupMenu) and TElPopupMenu(ParentMenu).RightToLeft) or
    ((ParentMenu is TElMainMenu) and TElMainMenu(ParentMenu).RightToLeft) then
  begin
//    if Flags and DT_LEFT = DT_LEFT then
//      Flags := Flags and (not DT_LEFT) or DT_RIGHT
//    else
//      if Flags and DT_RIGHT = DT_RIGHT then
//      Flags := Flags and (not DT_RIGHT) or DT_LEFT;
    Flags := Flags or DT_RTLREADING;
  end;
  LThemeMode := ttmPlatform;
  if TMenu(ParentMenu) is TElPopupMenu then
  begin
    DrawStyle := TElPopupMenu(ParentMenu).DrawStyle;

    IsHTML := TElPopupMenu(ParentMenu).IsHTML;
    Render := TElPopupMenu(ParentMenu).FRender;

    SaveColor := ACanvas.Font.Color;

    if Selected then
      ACanvas.Font.Assign(TElPopupMenu(ParentMenu).SelectedItemFont)
    else
      ACanvas.Font.Assign(TElPopupMenu(ParentMenu).Font);
    if not TElPopupMenu(ParentMenu).UseFontColor then
    begin
      if Selected then
        ACanvas.Font.Color := clHighlightText
      else
        ACanvas.Font.Color := SaveColor;
    end;
    LThemeMode := TElPopupMenu(ParentMenu).ThemeMode;
  end
  else
  if TMenu(ParentMenu) is TElMainMenu then
  begin
    DrawStyle := TElMainMenu(ParentMenu).DrawStyle;

    IsHTML := TElMainMenu(ParentMenu).IsHTML;
    Render := TElMainMenu(ParentMenu).FRender;

    SaveColor := ACanvas.Font.Color;
    if Selected then
      ACanvas.Font.Assign(TElMainMenu(ParentMenu).SelectedItemFont)
    else
      ACanvas.Font.Assign(TElMainMenu(ParentMenu).Font);
    if not TElMainMenu(ParentMenu).UseFontColor then
    begin
      if Selected then
        ACanvas.Font.Color := clHighlightText
      else
        ACanvas.Font.Color := SaveColor;
    end;
    LThemeMode := TElMainMenu(ParentMenu).ThemeMode;
  end
  else
  begin
    DrawStyle := tdsNormal;

    IsHTML := false;
    Render := nil;

  end;

  Text := ACaption;
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or
    (Text[1] = '&') and (Text[2] = #0)) then
    Text := Text + ' ';
  with ACanvas do
  begin
    Brush.Style := bsClear;

    if Text = cLineCaption then
    begin
      if Flags and DT_CALCRECT = 0 then
      begin
        R := Rect;
        if DrawStyle <> tdsNormal then
          Inc(R.Top, 2)
        else
          Inc(R.Top, 4);
        DrawEdge(Handle, R, EDGE_ETCHED, BF_TOP);
      end;
    end
    else
    begin
      if Default then
        Font.Style := Font.Style + [fsBold];

      APos := pos('&', Text);
      if (IsHTML) and (APos <> 0) and (APos < Length(Text)) then
      begin
        System.Delete(Text, APos, 1);
        if not (LMDSIWindows2000Up and (odNoAccel in FState)) then
        begin
          System.Insert('</u>', Text, APos + 1);
          System.Insert('<u>', Text, APos);
        end;
      end;

      b := true;
      if Assigned(FCurrentForm) then
        LForm := TForm(FCurrentForm)
      else
        LForm := LMDGetOwnerForm(Self);
      if not (TMenu(ParentMenu) is TElPopupMenu) then
        if Assigned(LForm) then
        begin
          b := LForm.Active or (LForm.FormStyle = fsMDIForm);// or (LForm.FormStyle = fsMDIChild);
        end;
      if not Enabled or not ((csDesigning in ComponentState) or b or Selected) then
      begin
        if ((not Selected) or (GetParentComponent is TElMainMenu)) and (DrawStyle = tdsNormal) then
        begin
          OffsetRect(Rect, 1, 1);
          Font.Color := clBtnHighlight;
          if LMDSIWindows2000Up and (odNoAccel in FState) then
            Flags := Flags or DT_HIDEPREFIX;
          if IsHTML then
          begin
            Render.Data.DefaultStyle := Font.Style;
            Render.Data.DefaultHeight := Font.Height;
            Render.Data.DefaultFont := Font.Name;
            Render.Data.Charset := Font.Charset;

            Render.Data.DefaultColor := Font.Color;
            Render.PrepareText(Text, 0, false);
            R := Rect;
            if (TMenu(ParentMenu) is TElMainMenu) and ((Parent = nil) or (Parent.Parent <> nil)) then
              inc(R.Left, (R.Right - R.Left - Render.Data.TextSize.cx) div 2);
            inc(R.Top, (R.Bottom - R.Top - Render.Data.TextSize.cy) div 2);
            if Flags and DT_RIGHT <> 0 then
              R.Left := R.Right - Render.Data.TextSize.cx
            else
              R.Right := R.Left + Render.Data.TextSize.cx;
            R.Bottom := R.Top + Render.Data.TextSize.cy;
            if (Flags and DT_CALCRECT = 0) then
              Render.DrawText(ACanvas, Point(0, 0), R, clNone)
            else
              Rect := R;
          end
          else
          begin
            if LMDSIWindows2000Up and (odNoAccel in FState) then
              Flags := Flags or DT_HIDEPREFIX;
            LMDDrawText(Handle, Text, Length(Text), Rect,
              Flags);
          end;
          OffsetRect(Rect, -1, -1);
        end;

        if Selected and (ColorToRGB(clHighlight) = ColorToRGB(clBtnShadow)) then
          Font.Color := clBtnHighlight
        else
          if not Enabled and (DrawStyle in [tdsOfficeXP, tdsOffice2003]) then
        begin
          if UseThemeMode <> ttmNone then
            Font.Color :=  LMDThemeServices.GetThemeSysColor(LThemeMode, teMenu, COLOR_BTNFACE)
          else
            Font.Color := clBtnFace;
          Font.Color := LMDColorDarker(Font.Color, 150);
        end
        else
          Font.Color := clBtnShadow;
      end;

      if IsHTML then
      begin
        Render.Data.DefaultColor := Font.Color;
        Render.Data.DefaultStyle := Font.Style;
        Render.Data.DefaultHeight := Font.Height;
        Render.Data.DefaultFont := Font.Name;
        Render.Data.Charset := Font.Charset;
        Render.PrepareText(Text, 0, false);
        R := Rect;
        if (TMenu(ParentMenu) is TElMainMenu) and ((Parent = nil) or (Parent.Parent <> nil)) then
          inc(R.Left, (R.Right - R.Left - Render.Data.TextSize.cx) div 2);
        inc(R.Top, (R.Bottom - R.Top - Render.Data.TextSize.cy) div 2);
        if Flags and DT_RIGHT <> 0 then
          R.Left := R.Right - Render.Data.TextSize.cx
        else
          R.Right := R.Left + Render.Data.TextSize.cx;
        R.Bottom := R.Top + Render.Data.TextSize.cy;
        if (Flags and DT_CALCRECT = 0) then
          Render.DrawText(ACanvas, Point(0, 0), R, clNone)
        else
          Rect := R;
      end
      else
      begin
        if LMDSIWindows2000Up and (odNoAccel in FState) then
          Flags := Flags or DT_HIDEPREFIX;
        LMDDrawText(Handle, Text, Length(Text), Rect, Flags);
      end;
    end;
  end;
end;

function TElMenuItem.HasParent: Boolean;
begin
  Result := True;
end;

procedure TElMenuItem.SetBreak(Value: TMenuBreak);
begin
  if FBreak <> Value then
  begin
    FBreak := Value;
    MenuChanged(true);
    IntMenuChanged(true);
  end;
end;

procedure TElMenuItem.SetCaption(const Value: TLMDString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
{$IFNDEF LMD_UNICODE}
    inherited Caption := Value;
{$ENDIF}
    MenuChanged(True);
    IntMenuChanged(true);
  end;
end;

procedure TElMenuItem.TriggerSubMenuPopup;
begin
  if Assigned(FOnSubMenuPopup) then
    FOnSubMenuPopup(Self);
end;

procedure TElMenuItem.TurnSiblingsOff;
var
  I: Integer;
  Item: TElMenuItem;
begin
  if FParent <> nil then
    for I := 0 to FParent.Count - 1 do
    begin
      Item := FParent[I];
      if (Item <> Self) and Item.FRadioItem and (Item.GroupIndex = GroupIndex)
        then
        Item.SetChecked(False);
    end;
end;

procedure TElMenuItem.SetChecked(Value: Boolean);
begin
  if FChecked <> Value then
  begin
    FChecked := Value;
    if (FParent <> nil) and not (csReading in ComponentState) then
      CheckMenuItem(FParent.Handle, FCommand, MF_BYCOMMAND or Checks[Value]);
    if Value and FRadioItem then
      TurnSiblingsOff;
    MenuChanged(False);
    IntMenuChanged(False);
  end;
end;

procedure TElMenuItem.SetEnabled(Value: Boolean);
var
  ImageList: TCustomImageList;
  ParentMenu: TMenu;
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    if ((Win32Platform = VER_PLATFORM_WIN32_NT) and (Count <> 0)) or
      ((Parent <> nil) and Assigned(Parent.FMergedWith)) then
      MenuChanged(True)
    else
    begin
      if (FParent <> nil) and not (csReading in ComponentState) then
        EnableMenuItem(FParent.Handle, FCommand, MF_BYCOMMAND or
          Enables[Value]);
      MenuChanged(False);
    end;

    ParentMenu := GetParentMenu;
    if ParentMenu is TElPopupMenu then
      ImageList := TElPopupMenu(ParentMenu).Images
    else
      if ParentMenu is TElMainMenu then
      ImageList := TElMainMenu(ParentMenu).Images
    else
      ImageList := nil;

    if (FParent <> nil) and (FParent.SubMenuImages <> nil) then
      ImageList := FParent.SubMenuImages;

    if (FEnabled) or not ((ImageList <> nil) and (ImageIndex > 0)
      and (ImageIndex < ImageList.Count)) then
    begin
      if not Assigned(FDisBitmap) then
      begin
        FDisBitmap.Free;
        FDisBitmap := nil;
      end;
    end
    else
    begin
      if not Assigned(FDisBitmap) then
        GrayBitmap(ImageList, ImageIndex, FDisBitmap);
    end;
    IntMenuChanged(true);
  end;
end;

procedure TElMenuItem.SetGroupIndex(Value: Byte);
begin
  if FGroupIndex <> Value then
  begin
    if Parent <> nil then Parent.VerifyGroupIndex(Parent.IndexOf(Self), Value);
    FGroupIndex := Value;
    if FChecked and FRadioItem then
      TurnSiblingsOff;
    IntMenuChanged(False);
  end;
end;

function TElMenuItem.GetAction: TBasicAction;
begin
  if FActionLink <> nil then
    Result := FActionLink.Action
  else
    Result := nil;
end;

function TElMenuItem.GetActionLinkClass: TMenuActionLinkClass;
begin
  Result := ElMenus.TMenuActionLink;
end;

function TElMenuItem.GetCount: Integer;
begin
  if FItems = nil then
    Result := 0
  else
    Result := FItems.Count;
end;

function TElMenuItem.GetItem(Index: Integer): TElMenuItem;
begin
  if FItems = nil then
    EMenuError.CreateFmt('Index Error', [Name]);
  Result := TElMenuItem(FItems[Index]);
end;

procedure TElMenuItem.SetShortCut(Value: TShortCut);
begin
  if FShortCut <> Value then
  begin
    FShortCut := Value;
    MenuChanged(true);
    IntMenuChanged(true);
  end;
end;

procedure TElMenuItem.SetVisible(Value: Boolean);
begin
  if Value <> FVisible then
  begin
    FVisible := Value;
    MenuChanged(true);
    IntMenuChanged(true);
  end;
end;

procedure TElMenuItem.SetImageIndex(Value: Integer);
begin
  if Value <> FImageIndex then
  begin
    FImageIndex := Value;
    MenuChanged(true);
    IntMenuChanged(true);
  end;
end;

function TElMenuItem.GetMenuIndex: Integer;
begin
  Result := -1;
  if FParent <> nil then Result := FParent.IndexOf(Self);
end;

procedure TElMenuItem.SetMenuIndex(Value: Integer);
var
  Parent: TElMenuItem;
  Count: Integer;
begin
  if FParent <> nil then
  begin
    Count := FParent.Count;
    if Value < 0 then
      Value := 0;
    if Value >= Count then
      Value := Count - 1;
    if Value <> MenuIndex then
    begin
      Parent := FParent;
      Parent.Remove(Self);
      Parent.Insert(Value, Self);
    end;
  end;
end;

procedure TElMenuItem.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Proc(Items[I]);
end;

procedure TElMenuItem.SetChildOrder(Child: TComponent; Order: Integer);
begin
  (Child as TElMenuItem).MenuIndex := Order;
end;

procedure TElMenuItem.SetDefault(Value: Boolean);
var
  I: Integer;
begin
  if FDefault <> Value then
  begin
    if Value and (FParent <> nil) then
      for I := 0 to FParent.Count - 1 do
        if FParent[I].Default then FParent[I].FDefault := False;
    FDefault := Value;
    MenuChanged(True);
    IntMenuChanged(True);
  end;
end;

procedure TElMenuItem.InitiateAction;
begin
  if FActionLink <> nil then
    FActionLink.Update;
end;

procedure TElMenuItem.DesignRebuild;
begin
  if (csDesigning in ComponentState) then
    RebuildHandle;
end;

procedure TElMenuItem.Insert(Index: Integer; Item: TElMenuItem);
begin
  if Item.FParent <> nil then
    raise EMenuError.CreateFmt('Menu Reinserted', [Name]);
  if FItems = nil then FItems := TList.Create;
  if (Index - 1 >= 0) and (Index - 1 < FItems.Count) then
    if Item.GroupIndex < TElMenuItem(FItems[Index - 1]).GroupIndex then
      Item.GroupIndex := TElMenuItem(FItems[Index - 1]).GroupIndex;
  VerifyGroupIndex(Index, Item.GroupIndex);
  FItems.Insert(Index, Item);
  Item.FParent := Self;
  Item.OnChange := SubItemChanged;
  if FHandle <> 0 then
    RebuildHandle;
  IntMenuChanged(true);
  MenuChanged(Count = 1);
end;

procedure TElMenuItem.Delete(Index: Integer);
var
  Cur: TElMenuItem;
begin
  if (Index < 0) or (FItems = nil) or (Index >= GetCount) then
    EMenuError.CreateFmt('Index Error', [Name]);
  //inherited;
  Cur := TElMenuItem(FItems[Index]);
  FItems.Delete(Index);
  Cur.FOnChange := nil;
  Cur.FParent := nil;
  if FHandle <> 0 then
    RebuildHandle;
  MenuChanged(Count = 0);
  IntMenuChanged(true);
end;

(*
procedure TElMenuItem.Click;
begin
  if Enabled then
  begin
{$IFDEF VCL_4_USED}
    if Assigned(OnClick) and (Action <> nil) and (@OnClick <>
      @Action.OnExecute) then
      FOnClick(Self)
    else
      if (not (csDesigning in ComponentState)) and (ActionLink <> nil) then
      FActionLink.Execute
    else
{$ENDIF}
      if Assigned(FOnClick) then
      FOnClick(Self);
  end;
end;
//*)

function TElMenuItem.Find(ACaption: TLMDString): TElMenuItem;
var
  I: Integer;
begin
  Result := nil;
  ACaption := ElStripHotkey(ACaption);
  for I := 0 to Count - 1 do
{$IFDEF LMD_UNICODE}
    if LMDWideSameText(ACaption, ElStripHotkey(Items[I].Caption)) then
{$ELSE}
    if LMDAnsiSameText(ACaption, ElStripHotkey(Items[I].Caption)) then
{$ENDIF}
    begin
      Result := Items[I];
      system.Break;
    end;
end;

function TElMenuItem.IndexOf(Item: TElMenuItem): Integer;
begin
  Result := -1;
  if FItems <> nil then Result := FItems.IndexOf(Item);
end;

procedure TElMenuItem.Add(Item: TElMenuItem);
begin
  Insert(GetCount, Item);
end;

procedure TElMenuItem.Remove(Item: TElMenuItem);
var
  I: Integer;
begin
  I := IndexOf(Item);
  if I = -1 then raise EMenuError.CreateFmt('Menu Not Found', [Name]);
  Delete(I);
end;

procedure TElMenuItem.MenuChanged(Rebuild: Boolean);
var
  Source: TElMenuItem;
begin
  if (Parent = nil) and ((Owner is TElMainMenu) or (Owner is TElPopupMenu)) then
    Source := nil
  else
    Source := Self;
  if Assigned(FOnChange) then FOnChange(Self, Source, Rebuild);
end;

procedure TElMenuItem.SubItemChanged(Sender: TObject; Source: TElMenuItem;
  Rebuild: Boolean);
begin
  if Rebuild and ((FHandle <> 0) or Assigned(FMergedWith)) then
    RebuildHandle;
  if Parent <> nil then
    Parent.SubItemChanged(Self, Source, False)
  else
    if Owner is TElMainMenu then
  begin
    TElMainMenu(Owner).ItemChanged;
  end;
end;

function TElMenuItem.GetBitmap: TBitmap;
begin
  if FBitmap = nil then FBitmap := TBitmap.Create;
  FBitmap.Transparent := True;
  Result := FBitmap;
end;

procedure TElMenuItem.SetAction(Value: TBasicAction);
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
    Value.FreeNotification(Self);
  end;
  MenuChanged(False);
  IntMenuChanged(False);
end;

procedure TElMenuItem.SetBitmap(Value: TBitmap);
begin
  if FBitmap = nil then FBitmap := TBitmap.Create;
  FBitmap.Assign(Value);
  MenuChanged(False);
  IntMenuChanged(False);
end;

procedure TElMenuItem.InitiateActions;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].InitiateAction;
end;

function TElMenuItem.GetParentComponent: TComponent;
begin
  if (FParent <> nil) and (FParent.FMenu <> nil) then
    Result := FParent.FMenu
  else
    Result := FParent;
end;

procedure TElMenuItem.SetParentComponent(Value: TComponent);
begin
  if FParent <> nil then FParent.Remove(Self);
  if Value <> nil then
    if Value is TElMainMenu then
      TElMainMenu(Value).Items.Add(Self)
    else
      if Value is TElPopupMenu then
      TElPopupMenu(Value).Items.Add(Self)
    else
      if Value is TElMenuItem then
      TElMenuItem(Value).Add(Self);
end;

function TElMenuItem.GetParentMenu: TMenu;
var
  MenuItem: TElMenuItem;
begin
  MenuItem := Self;
  while Assigned(MenuItem.FParent) do
    MenuItem := MenuItem.FParent;
  Result := MenuItem.FMenu;
end;

procedure TElMenuItem.SetRadioItem(Value: Boolean);
begin
  if FRadioItem <> Value then
  begin
    FRadioItem := Value;
    if FChecked and FRadioItem then
      TurnSiblingsOff;
    MenuChanged(true);
    IntMenuChanged(true);
  end;
end;

procedure TElMenuItem.ReadCaption(Reader : TReader);
{$ifdef LMD_UNICODE}
var
  S: WideString;
  l: integer;
  uS: AnsiString;
  {$endif}
begin
{$ifdef LMD_UNICODE}
  if (Reader.NextValue = vaBinary) then
  begin
    with Reader do
    begin
      ReadValue;
      l := 0;
      Read(L, SizeOf(Integer));
      SetLength(uS, L);
      Read(Pointer(uS)^, L);
      end;

    LMDConvertUTF8toUTF16(uS, S, strictConversion, false);
  end
  else
    LMDConvertUTF8toUTF16(AnsiString(Reader.ReadString), S, strictConversion, false);
  Caption := S;
{$else}
  if (Reader.NextValue =  vaBinary) then
  begin
    Reader.SkipValue;
    end
  else
    Caption := Reader.ReadString;
{$endif}
end;

procedure TElMenuItem.ReadHint(Reader: TReader);
{$ifdef LMD_UNICODE}
var
  S: WideString;
  l: integer;
  uS: AnsiString;
  {$endif}
begin
  {$ifdef LMD_UNICODE}
  if (Reader.NextValue = vaBinary) then
  begin
    with Reader do
    begin
      ReadValue;
      l := 0;
      Read(L, SizeOf(Integer));
      SetLength(uS, L);
      Read(Pointer(uS)^, L);
      end;
    LMDConvertUTF8toUTF16(uS, S, strictConversion, false);
  end
  else
    LMDConvertUTF8toUTF16(AnsiString(Reader.ReadString), S, strictConversion, false);
  Hint := S;
  {$else}
  if (Reader.NextValue = vaBinary) then
  begin
    Reader.SkipValue;
    end
  else
    Hint := Reader.ReadString;
  {$endif}
end;


{$IFNDEF LMDCOMP7}
type
   THWriter = class(TWriter);

procedure TElMenuItem.WriteCaption(Writer : TWriter);
{$ifdef LMD_UNICODE}
var
  S: String;
  l: Integer;
{$endif}
begin
  {$ifdef LMD_UNICODE}
  LMDConvertUTF16toUTF8(Caption, S, strictConversion, false);
  with Writer do
  begin
    L := Length(S);
    THWriter(Writer).WriteValue(vaBinary);
    Write(L, SizeOf(Integer));
    Write(Pointer(S)^, L);
  end;
  {$else}
  Writer.WriteString(Caption);
  {$endif}
end;

procedure TElMenuItem.WriteHint(Writer : TWriter);
{$ifdef LMD_UNICODE}
var
  S: String;
  l: Integer;
{$endif}
begin
  {$ifdef LMD_UNICODE}
  LMDConvertUTF16toUTF8(Hint, S, strictConversion, false);
  with Writer do
  begin
    L := Length(S);
    THWriter(Writer).WriteValue(vaBinary);
    Write(L, SizeOf(Integer));
    Write(Pointer(S)^, L);
  end;
  {$else}
  Writer.WriteString(Hint);
  {$endif}
end;
{$ENDIF}

procedure TElMenuItem.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('ShortCutText', ReadShortCutText, WriteShortCutText, False);

  //Filer.DefineProperty('CaptionUTF8', ReadCaption, nil, false);
  //Filer.DefineProperty('HintUTF8', ReadHint, nil, false);

  Filer.DefineProperty('CaptionUTF8', ReadCaption, {$IFNDEF LMDCOMP7}WriteCaption, (Caption <> ''){$ELSE}nil, false{$ENDIF});
  Filer.DefineProperty('HintUTF8', ReadHint, {$IFNDEF LMDCOMP7}WriteHint, (Hint <> ''){$ELSE}nil, false{$ENDIF});
end;

procedure TElMenuItem.ActionChange(Sender: TObject; CheckDefaults: Boolean);
{$ifdef LMD_UNICODE}
var
  PropInfo: PPropInfo;
{$endif}
begin
  if Action is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.Caption = '') then
      begin
{$ifdef LMD_UNICODE}
        PropInfo := TypInfo.GetPropInfo(Sender.ClassInfo, 'Caption');
        if (PropInfo <> nil) then
          Self.Caption := GetWideStrProp(Sender, 'Caption')
        else
{$endif}
          Self.Caption := TAction(Sender).Caption;
      end;
      if not CheckDefaults or (Self.Checked = False) then
        Self.Checked := Checked;
      if not CheckDefaults or (Self.Enabled = True) then
        Self.Enabled := Enabled;
      if not CheckDefaults or (Self.HelpContext = 0) then
        Self.HelpContext := HelpContext;
      if not CheckDefaults or (Self.Hint = '') then
      begin
{$ifdef LMD_UNICODE}
        PropInfo := TypInfo.GetPropInfo(Sender.ClassInfo, 'Hint');
        if (PropInfo <> nil) then
          Hint := GetWideStrProp(Sender, 'Hint')
        else
{$endif}
          Hint := TAction(Sender).Hint;
      end;
      if not CheckDefaults or (Self.ImageIndex = -1) then
        Self.ImageIndex := ImageIndex;
      if not CheckDefaults or (Self.ShortCut = scNone) then
        Self.ShortCut := ShortCut;
      if not CheckDefaults or (Self.Visible = True) then
        Self.Visible := Visible;
      if not CheckDefaults or not Assigned(Self.OnClick) then
        Self.OnClick := OnExecute;
    end;
end;

procedure TElMenuItem.DoActionChange(Sender: TObject);
begin
  if Sender = Action then ActionChange(Sender, False);
end;

function TElMenuItem.IsCaptionStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsCaptionLinked;
end;

function TElMenuItem.IsCheckedStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsCheckedLinked;
end;

function TElMenuItem.IsEnabledStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsEnabledLinked;
end;

function TElMenuItem.IsHintStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsHintLinked;
end;

{
function TElMenuItem.IsHelpContextStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsHelpContextLinked;
end;{}

function TElMenuItem.IsImageIndexStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsImageIndexLinked;
end;

function TElMenuItem.IsShortCutStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsShortCutLinked;
end;

function TElMenuItem.IsVisibleStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsVisibleLinked;
end;

function TElMenuItem.IsOnClickStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsOnExecuteLinked;
end;

procedure TElMenuItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TCustomAction then
    with TCustomAction(Dest) do
    begin
      Enabled := Self.Enabled;
      HelpContext := Self.HelpContext;
      Hint := Self.Hint;
      ImageIndex := Self.ImageIndex;
      Caption := Self.Caption;
      Visible := Self.Visible;
      OnExecute := Self.OnClick;
    end
  else

  if Dest is TElMenuItem then
  begin
    TElMenuItem(Dest).Updating;
    TElMenuItem(Dest).Action := Action;
    TElMenuItem(Dest).ProcessShortCut := ProcessShortcut;
    TElMenuItem(Dest).SubMenuImages := SubMenuImages;
    TElMenuItem(Dest).AlphaForSubMenuImages := AlphaForSubMenuImages;
    TElMenuItem(Dest).Bitmap := Bitmap;
    TElMenuItem(Dest).Break := Break;
    TElMenuItem(Dest).Caption := Caption;
    TElMenuItem(Dest).Checked := Checked;
    TElMenuItem(Dest).Default := Default;
    TElMenuItem(Dest).Enabled := Enabled;
    TElMenuItem(Dest).GroupIndex := GroupIndex;
    TElMenuItem(Dest).Hint := Hint;
    TElMenuItem(Dest).Tag := Tag;
    TElMenuItem(Dest).ImageIndex := ImageIndex;
    TElMenuItem(Dest).RadioItem := RadioItem;
    TElMenuItem(Dest).ShortCut := Shortcut;
    TElMenuItem(Dest).Visible := Visible;
    TElMenuItem(Dest).OnClick := OnClick;
    TElMenuItem(Dest).OnDrawItem := OnDrawItem;
    TElMenuItem(Dest).OnAdvancedDrawItem := OnAdvancedDrawItem;
    TElMenuItem(Dest).OnMeasureItem := OnMeasureItem;
    TElMenuItem(Dest).OnSubMenuPopup := OnSubMenuPopup;
    TElMenuItem(Dest).OnChange := OnChange;
    TElMenuItem(Dest).HelpContext := HelpContext;
    TElMenuItem(Dest).AutoLineReduction := AutoLineReduction;
    TElMenuItem(Dest).AutoCheck := AutoCheck;
    TElMenuItem(Dest).AutoHotkeys := AutoHotkeys;
    TElMenuItem(Dest).Updated;
  end
  else
    inherited AssignTo(Dest);
end;

procedure TElMenuItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (AComponent = Action) then Action := nil;

  if Operation = opRemove then
  begin
    if TMethod(FOnIntChange).Data = AComponent then
    FOnIntChange := nil;
    if AComponent = SubMenuImages then
      SubMenuImages := nil;
    if AComponent = AlphaForSubMenuImages then
      AlphaForSubMenuImages := nil;
  end;
end;

function TElMenuItem.GetImageWidth: Integer;
var
  ImageList: TCustomImageList;
  ParentMenu: TMenu;
  IsOfficeXP: boolean;
begin
  ParentMenu := GetParentMenu;
  if ParentMenu is TElPopupMenu then
  begin
    ImageList := TElPopupMenu(ParentMenu).Images;
    IsOfficeXP := TElPopupMenu(ParentMenu).DrawStyle in [tdsOfficeXP, tdsOffice2003];
  end
  else
    if ParentMenu is TElMainMenu then
  begin
    ImageList := TElMainMenu(ParentMenu).Images;
    IsOfficeXP := TElMainMenu(ParentMenu).DrawStyle in [tdsOfficeXP, tdsOffice2003];
  end
  else
  begin
    ImageList := nil;
    IsOfficeXP := false;
  end;

  if FParent.SubMenuImages <> nil then
    ImageList := FParent.SubMenuImages;

  if ImageList <> nil then
    result := TCustomImageList(ImageList).Width
  else
    if FBitmap <> nil then
    result := FBitmap.Width
  else
    if not (GetParentComponent is TElMainMenu) then
    result := GetSystemMetrics(SM_CXMENUCHECK)
  else
    result := 0;
  inc(result, 3);
  if IsOfficeXP then
    result := -1;
end;

procedure TElMenuItem.SetHint(Value: TLMDString);
var
  S: string;
{$IFDEF LMD_UNICODE}
  i, l: integer;

  T: WideChar;

{$ENDIF}
begin
  FHint := Value;

  S := FHint;
{$IFDEF LMD_UNICODE}
  i := Length(S);
  l := Length(S) + 1 + Length(FHint) * 2;
  SetLength(S, l + 4);
  S[i + 1] := #0;
  if Length(FHint) > 0 then
    Move(FHint[1], S[i + 2], Length(FHint) * 2);
  T := #0;
  Move(T, S[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, S[l + 3], sizeof(T));
  {$ENDIF}
  //inherited Hint := S;
  MenuChanged(False);
  IntMenuChanged(False);
end;

procedure TElMenuItem.Clear;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    Items[I].Free;
end;

procedure TElMenuItem.UpdateCommand;
begin
  FCommand := inherited Command;
end;

procedure TElMenuItem.MeasureWindowsXPItem(Canvas: TCanvas; var Width, Height:
  integer);
var
  ImgW, ImgH: integer;
  TxtW, TxtH: integer;
  CutW, CutH: integer;
  DrawStyle: integer;
  R: TRect;
  Text: WideString;
  Images: TCustomImageList;
  LItemSpace: integer;
begin
  if FCaption = cLineCaption then
  begin
    Width := 5;
    Height := 5;
  end
  else
  (*
  if IsTopLevel then
  begin
  end
  else
  *)
  begin
    // get item space
    if (GetParentMenu is TElMainMenu) then
      LItemSpace := TElMainMenu(GetParentMenu).FItemSpace
    else
      if (GetParentMenu is TElPopupMenu) then
        LItemSpace := TElPopupMenu(GetParentMenu).FItemSpace
      else
        LItemSpace := 4;

    // calculating image sizes
    Images := GetImages(true, false);
    if (Images <> nil) and (ImageIndex <> -1) then
    begin
      ImgW := TCustomImageList(Images).Width;
      ImgH := TCustomImageList(Images).Height + LItemSpace;
    end
    else
    if IsTopLevel then
    begin
      ImgW := 0;
      ImgH := Abs(Canvas.Font.Height) + LItemSpace + 5;
    end
    else
    begin
      ImgW := 22;
      ImgH := Abs(Canvas.Font.Height) + LItemSpace + 5;
    end;

    // calculation caption sizes
    if FCaption <> '' then
    begin
      DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or DT_NOCLIP or DT_CALCRECT;
      SetRectEmpty(R);
      DoDrawText(Canvas, FCaption, R, True, DrawStyle);
      TxtW := R.Right - R.Left;
      TxtH := R.Bottom - R.Top + LItemSpace;
    end
    else
    begin
      TxtW := 0;
      DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or DT_NOCLIP or DT_CALCRECT;
      SetRectEmpty(R);
      DoDrawText(Canvas, 'W', R, True, DrawStyle);
      TxtH := R.Bottom - R.Top + LItemSpace;
    end;
    // calculating shortcut sizes
    CutW := 0;
    CutH := 0;
    if (FShortCut <> 0) and (Self.Count = 0) then
    begin
      Text := ElShortCutToText(FShortCut);
      DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or DT_NOCLIP or DT_CALCRECT;
      SetRectEmpty(R);
      DoDrawText(Canvas, Text, R, True, DrawStyle);
      CutW := R.Right - R.Left;
      CutH := R.Bottom - R.Top + LItemSpace;
    end;
    // calculating whole item sizes
    Width := (4 + ImgW + TxtW + 4);

    if ImgW > 0 then
      Inc(Width, 6);
    if IsTopLevel then
      inc(Width, 8);

    if (Self.Count = 0) and (CutW > 0) then
      Inc(Width, (20 + CutW));

    if not IsTopLevel then
      Inc(Width, 20);

    Height := TxtH;
    if ImgH > Height then
      Height := ImgH;
    if (Self.Count = 0) and (CutH > Height) then
      Height := CutH;

    if (GetParentMenu is TElMainMenu) {and IsTopLevel }then
      Dec(Width, 14);
  end;
end;

procedure TElMenuItem.MeasureItem(ACanvas: TCanvas; var Width, Height: Integer);
begin
  MeasureMenuItem(ACanvas, Width, Height);
  DoMeasureItem(ACanvas, Width, Height);
end;

procedure TElMenuItem.DoMeasureItem(Canvas: TCanvas; var Width,
  Height: integer);
begin
  if Assigned(OnMeasureItem) then
    OnMeasureItem(Self, Canvas, Width, Height);
end;

procedure TElMenuItem.DrawMenuItem(Canvas: TCanvas; R: TRect; Selected, Dropped
    : boolean);
var
  LDrawStyle: TDrawStyle;
  ParentMenu : TMenu;
begin
  ParentMenu := GetParentMenu;
  if (ParentMenu <> nil) and
     (((ParentMenu is TElPopupMenu) and TElPopupMenu(ParentMenu).OwnerDraw) or
      ((ParentMenu is TElMainMenu) and TElMainMenu(ParentMenu).OwnerDraw)) and
     (Assigned(OnAdvancedDrawItem) or Assigned(OnDrawItem)) then
  begin
   DrawItem(Canvas, R, Selected);
   if Assigned(OnAdvancedDrawItem) then
     OnAdvancedDrawItem(Self, Canvas, R, FState);
  end
  else
  begin
    LDrawStyle := GetDrawStyle;
    if IsRightToLeft then
      case LDrawStyle of
        tdsNormal: DrawNormalRightToLeft(Canvas, R, Selected);
        tdsOfficeXP: DrawOfficeXPRightToLeft(Canvas, R, Selected, Dropped);
        tdsOffice2003: DrawOfficeXPRightToLeft(Canvas, R, Selected, Dropped);
        tdsWindowsXP: DrawWindowsXPRightToLeft(Canvas, R, Selected)
      end
    else
      case LDrawStyle of
        tdsNormal: DrawNormalLeftToRight(Canvas, R, Selected);
        tdsOfficeXP: DrawOfficeXPLeftToRight(Canvas, R, Selected, Dropped);
        tdsOffice2003: DrawOfficeXPLeftToRight(Canvas, R, Selected, Dropped);
        tdsWindowsXP: DrawWindowsXPLeftToRight(Canvas, R, Selected);
      end;
  end;
end;

function TElMenuItem.GetDrawStyle: TDrawStyle;
var
  Menu: TMenu;
begin
  Menu := GetParentMenu;
  if Menu is TElPopupMenu then
  begin
    Result := TElPopupMenu(Menu).DrawStyle;
    if TElPopupMenu(Menu).IsThemed and (Result = tdsNormal) then
      Result := tdsWindowsXP;
  end
  else
  if Menu is TElMainMenu then
  begin
    Result := TElMainMenu(Menu).DrawStyle;
    {if TElMainMenu(Menu).IsThemed and (Result = tdsNormal) then
      Result := tdsWindowsXP;
      }
  end
  else
    Result := tdsNormal;
end;

function TElMenuItem.GetFontColor(aThemeMode:TLMDThemeMode; Selected: boolean): TColor;
begin
  if UseThemeMode <> ttmNone {IsThemed} then
  begin
    {$IFDEF LMDCOMP16}
    if not (csDesigning in ComponentState) and StyleServices.Enabled and  not StyleServices.IsSystemStyle then
      result := StyleServices.GetStyleFontColor(sfMenuItemTextNormal)
    else
      if IsVistaSelNeed(Selected) then
        result := LMDThemeServices.GetThemeSysColor(aThemeMode, teMenu, COLOR_HIGHLIGHTTEXT)
      else
        result := LMDThemeServices.GetThemeSysColor(aThemeMode, teMenu, COLOR_MENUTEXT)
    {$ELSE}
    if IsVistaSelNeed(Selected) then
      result := LMDThemeServices.GetThemeSysColor(aThemeMode, teMenu, COLOR_HIGHLIGHTTEXT)
    else
      result := LMDThemeServices.GetThemeSysColor(aThemeMode, teMenu, COLOR_MENUTEXT)
    {$ENDIF}
  end
  else
  begin
    if IsVistaSelNeed(Selected) then
      result := clHighlightText
    else
      result := clMenuText;
  end;
end;

function TElMenuItem.IsRightToLeft: boolean;
var
  Menu: TMenu;
begin
  Menu := GetParentMenu;
  if Menu is TElPopupMenu then
    Result := TElPopupMenu(Menu).RightToLeft
  else
    Result := TElMainMenu(Menu).RightToLeft;
end;

function TElMenuItem.IsLine: Boolean;
begin
  Result := Caption = cLineCaption;
end;

function TElMenuItem.IsTopLevel: boolean;
var
  Menu: TMenu;
begin
  Menu := GetParentMenu;
  if Menu is TElMainMenu then
    Result :=  (Parent = nil) or (Parent = TElMainMenu(Menu).FUnicodeItems)
  else
    Result := (Menu is TElBarPopupMenu);
end;

procedure TElMenuItem.DrawNormalLeftToRight(Canvas: TCanvas; R: TRect; Selected:
  boolean);
var
  Images: TCustomImageList;
  AlphaImages : TCustomImageList;
  ImgW, ImgH: integer;
  X, Y: integer;
  Flags: integer;
  TR: TRect;
  Text: TLMDString;
  FontStyle: TFontStyles;
  DrawImage: boolean;
  Image, TempImage: TBitmap;
  OrigImage: TBitmap;
  LImageMargin: integer;
begin
  if FCaption = cLineCaption then
  begin
    if Selected then
      Canvas.Brush.Color := clHighlight
    else
      Canvas.Brush.Color := clBtnFace;
    Canvas.FillRect(R);
    if IsTopLevel then
    begin
      TR := R;
      TR.Left := TR.Left + (TR.Right - TR.Left - 2) div 2;
      TR.Right := TR.Left + 2;
      DrawEdge(Canvas.Handle, TR, BDR_SUNKENOUTER, BF_RECT);
    end
    else
    begin
      TR := R;
      TR.Top := R.Top + (R.Bottom - R.Top - 2) div 2;
      TR.Bottom := TR.Top + 2;
      DrawEdge(Canvas.Handle, TR, BDR_SUNKENOUTER, BF_RECT);
    end;
  end
  else
  begin
    if (GetParentMenu is TElMainMenu) then
    //if IsTopLevel then
    begin
      if Selected then
        Canvas.Brush.Color := clHighlight
      else
        Canvas.Brush.Color := clBtnFace;
      Canvas.FillRect(R);
    end
    else
    if Selected then
    begin
     Canvas.Brush.Color := clHighlight;
     Canvas.FillRect(R);
    end;
    Images := GetImages(Enabled, Selected);
    if (Images <> nil) and (Parent.ChildsHasImage) then
    begin
      ImgW := TCustomImageList(Images).Width;
      ImgH := TCustomImageList(Images).Height;
    end
    else
    if IsTopLevel then
    begin
      ImgW := 0;
      ImgH := 0;
    end
    else
    begin
      ImgW := 16;
      ImgH := 16;
    end;
//    if (Images = nil) and (not IsTopLevel) then
//    begin
//      ImgW := 16;
//      ImgH := Canvas.TextHeight('Wp');
//    end
//    else
//    if IsTopLevel and ((Images = nil) or (ImageIndex = -1)) then
//    begin
//      ImgW := 0;
//      if Images <> nil then
//        ImgH := TCustomImageList(Images).Height
//      else
//        ImgH := 0;
//    end
//    else
//    begin
//      ImgW := TCustomImageList(Images).Width;
//      ImgH := TCustomImageList(Images).Height;
//    end;
    DrawImage := ((Images <> nil) and (ImageIndex >= 0) and (ImageIndex <
      Images.Count)) or
      ((FBitmap <> nil) and not FBitmap.Empty) or Checked;
    X := R.Left + 2;
    Y := R.Top + (R.Bottom - R.Top - ImgH) div 2;
    if DrawImage then
    begin
      if (Selected or Checked) and
        ((Images <> nil) or ((FBitmap <> nil) and not FBitmap.Empty)) then
      begin
        Canvas.Brush.Color := clBtnFace;
        TR := Rect(X - 2, Y - 2, X + ImgW + 2, Y + ImgH + 2);
        if Checked and not Selected then
        begin
          Image := TBitmap.Create;
          try
            Image.Width := 2;
            Image.Height := 2;
            Image.Canvas.Pixels[0, 0] := clWindow;
            Image.Canvas.Pixels[1, 0] := clBtnFace;
            Image.Canvas.Pixels[0, 1] := clBtnFace;
            Image.Canvas.Pixels[1, 1] := clWindow;
            Canvas.Brush.Bitmap := Image;
            Canvas.FillRect(TR);
          finally
            Canvas.Brush.Bitmap := nil;
            Image.Free;
          end;
        end
        else
          Canvas.FillRect(TR);
        if Checked then
          DrawEdge(Canvas.Handle, TR, BDR_SUNKENOUTER, BF_RECT or BF_ADJUST)
        else
          DrawEdge(Canvas.Handle, TR, BDR_RAISEDINNER, BF_RECT or BF_ADJUST);
        Canvas.Pen.Color := clBtnFace;
        Canvas.MoveTo(X + ImgW + 2, Y - 2);
        Canvas.LineTo(X + ImgW + 2, Y + ImgH + 2);
      end;
      if (Images <> nil) and (ImageIndex >= 0) and (ImageIndex < Images.Count) then
      begin
        AlphaImages := GetAlphaImages(Enabled, Selected);
        if (AlphaImages <> nil) and (ImageIndex < AlphaImages.Count) then
          //-- use alpha [VB]
          DrawAlphaMaskedImage(Canvas, X, Y, ImgW, ImgH, Images, AlphaImages)
        else
          // -- no alpha
          Images.Draw(Canvas, X, Y, ImageIndex, Enabled or DisabledImagePresent)
      end
      else
        if ((FBitmap <> nil) and not FBitmap.Empty) or Checked then
      begin
        if (FBitmap = nil) or FBitmap.Empty then
        begin
          OrigImage := TBitmap.Create;
          OrigImage.Width := 16;
          OrigImage.Height := 16;
          if RadioItem then
            DrawFrameControl(OrigImage.Canvas.Handle, Rect(2, 0, 16, 16),
              DFC_MENU, DFCS_MENUBULLET)
          else
            DrawFrameControl(OrigImage.Canvas.Handle, Rect(3, 0, 16, 16),
              DFC_MENU, DFCS_MENUCHECK);
        end
        else
          OrigImage := FBitmap;
        Image := TBitmap.Create;
        try
          Image.PixelFormat := pf24bit;
          Image.Width := ImgW;
          Image.Height := ImgH;
          Image.Canvas.Brush.Color := OrigImage.Canvas.Pixels[0, OrigImage.Height
            - 1];
          Image.Canvas.FillRect(Rect(0, 0, ImgW, ImgH));
          if (OrigImage.Width <= ImgW) and (OrigImage.Height <= ImgH) then
          begin
            BitBlt(Image.Canvas.Handle, (ImgW - OrigImage.Width) div 2,
              (ImgH - OrigImage.Height) div 2, OrigImage.Width,
                OrigImage.Height,
              OrigImage.Canvas.Handle, 0, 0, SRCCOPY);
          end
          else
          begin
            BitBlt(Image.Canvas.Handle, 0, 0, ImgW, ImgH,
              OrigImage.Canvas.Handle,
              0, 0, SRCCOPY);
          end;
          if not Enabled then
          begin
            TempImage := TBitmap.Create;
            TempImage.Assign(Image);
            MaskImage(TempImage, TempImage.Canvas.Pixels[0, ImgH - 1],
              clBtnHighlight);
            LMDDrawTransparentBitmapEx(Canvas.Handle, TempImage, X + 1, Y + 1,
              Rect(0, 0, ImgW, ImgH), TempImage.Canvas.Pixels[0, ImgH - 1]);
            TempImage.Free;
            MaskImage(Image, Image.Canvas.Pixels[0, ImgH - 1], clBtnShadow);
          end;
          LMDDrawTransparentBitmapEx(Canvas.Handle, Image, X, Y,
            Rect(0, 0, ImgW, ImgH), Image.Canvas.Pixels[0, ImgH - 1]);
        finally
          Image.Free;
        end;
        if (FBitmap = nil) or FBitmap.Empty then
          OrigImage.Free;
      end;
    end;
    // get item space
    if (GetParentMenu is TElMainMenu) then
      LImageMargin := TElMainMenu(GetParentMenu).FImageMargin
    else
      if (GetParentMenu is TElPopupMenu) then
        LImageMargin := TElPopupMenu(GetParentMenu).FImageMargin
      else
        LImageMargin := 6;

    Inc(X, ImgW + LImageMargin);
    if Selected then
      Canvas.Font.Color := clHighlightText
    else
      Canvas.Font.Color := clBtnText;
    FontStyle := Canvas.Font.Style;
    if Default and not (fsBold in FontStyle) then
      Canvas.Font.Style := Canvas.Font.Style + [fsBold];
    Canvas.Brush.Color := clNone;
    if FCaption <> '' then
    begin
      Flags := DT_LEFT or DT_SINGLELINE or DT_NOCLIP or DT_VCENTER or
        DT_EXPANDTABS;
      TR := R;
      TR.Left := X;

      DoDrawText(Canvas, FCaption, TR, Selected, Flags);
    end;
    if not (GetParentMenu is TElMainMenu) then
    begin
      if (Self.Count > 0) then
      begin
        TR := R;
        TR.Left := TR.Right - 20;
        if Enabled then
          LMDDrawArrow(Canvas, eadRight, TR, Canvas.Font.Color, True)
        else
          LMDDrawArrow(Canvas, eadRight, TR, clBtnShadow, True);
      end;
    end;
    if (FShortCut <> 0) and (Self.Count = 0) then
    begin
      Text := ElShortCutToText(FShortCut);
      if Text <> '' then
      begin
        Flags := DT_RIGHT or DT_SINGLELINE or DT_NOCLIP or DT_VCENTER or
          DT_NOPREFIX;
        TR := R;
        Dec(TR.Right, 20);
        DoDrawText(Canvas, Text, TR, Selected, Flags);
      end;
    end;
    Canvas.Font.Style := FontStyle;
  end;
end;

procedure TElMenuItem.DrawOfficeXPLeftToRight(Canvas: TCanvas; R: TRect; Selected, Dropped : boolean);
var
  Images, AlphaImages: TCustomImageList;
  ImgW, ImgH: integer;
  X, Y: integer;
  DrawImage: boolean;
  FontStyle: TFontStyles;
  Flags: cardinal;
  TR: TRect;
  Text: TLMDString;
  OrigImage, Image, Shadow: TBitmap;
  LRect: TRect;
begin
  Images := GetImages(Enabled, Selected);

  if (Images <> nil) and (Parent.ChildsHasImage) then
  begin
    ImgW := TCustomImageList(Images).Width;
    ImgH := TCustomImageList(Images).Height;
  end
  else
  if IsTopLevel then
  begin
    ImgW := 0;
    ImgH := 0;
  end
  else
  begin
    ImgW := 16;
    ImgH := 16;
  end;
  TR := R;
  if (GetParentMenu is TElMainMenu) and (not IsTopLevel) then
  begin
    // draw column background
    TR := R;
    TR.Right := TR.Left + ImgW + 8;
    Canvas.Brush.Color := LMDColorLighter(clBtnFace, 10);
    case (GetParentMenu as TElMainMenu).DrawStyle of
      tdsOffice2003: LMDGradientPaint(Canvas.Handle, TR, LMDColorDarker(clWindow, 2),
                       LMDColorLighter(clBtnFace, 2), 16, gstHorizontal, 0, 0);
      tdsOfficeXP: Canvas.FillRect(TR);
    end;
  end;

  if FCaption = cLineCaption then
    DrawOfficeXPSeparator(Canvas, ImgW, TR, R)
  else
  begin
    if Selected then
    begin
      if Enabled then
      begin
        if Dropped then
        begin
          if GetDrawStyle = tdsOffice2003 then
            Canvas.Brush.Color := LMDColorLighter(clBtnFace, 50)
          else
            Canvas.Brush.Color := clBtnFace;
          Canvas.Pen.Color := LMDColorDarker(clBtnShadow, 80);
        end
        else
        begin
          Canvas.Brush.Color := LMDColorLighter(clHighlight, 70);
          Canvas.Pen.Color := clHighlight;
        end;
      end
      else
      begin
        Canvas.Brush.Color := LMDColorDarker(clWindow, 2);
        Canvas.Pen.Color := clHighlight;
      end;
      if Enabled then
      begin
        Canvas.FillRect(R);
        if (not (Selected and Dropped)) then
          Canvas.Rectangle(R)
        else
        if Vertical then
          Canvas.Polyline([Point(R.Right, R.Bottom - 1), Point(R.Left, R.Bottom - 1), Point(R.Left, R.Top), Point(R.Right, R.Top)])
        else
          Canvas.Polyline([Point(R.Left, R.Bottom), Point(R.Left, R.Top), Point(R.Right - 1, R.Top), Point(R.Right - 1, R.Bottom)])
      end
      else if (not IsTopLevel) then
      begin
        LRect := R;
        LRect.Left := LRect.Left + ImgW + 8;
        Canvas.FillRect(LRect);
      end;
    end
    else
    begin
      if (GetParentMenu is TElMainMenu) then
      begin
        if IsTopLevel then
         Canvas.Brush.Color := clBtnFace
        else
          Canvas.Brush.Color := LMDColorDarker(clWindow, 2);
        if not IsTopLevel then
        begin
          TR.Right := R.Left; // just save the value to restore it later
          R.Left := TR.Left + ImgW + 8;
          Canvas.FillRect(R);
          R.Left := TR.Right;
        end
        else
          Canvas.FillRect(R);
      end
      else
      begin
        if not IsTopLevel then
        begin
          Canvas.Brush.Color := LMDColorDarker(clWindow, 2);
          TR.Right := R.Left; // just save the value to restore it later
          R.Left := TR.Left + ImgW + 8;
          Canvas.FillRect(R);
          R.Left := TR.Right;
        end;
      end;
    end;

    DrawImage := ((Images <> nil) and (ImageIndex >= 0) and (ImageIndex < Images.Count)) or
      ((FBitmap <> nil) and not FBitmap.Empty) or Checked;
    X := R.Left + 3;
    Y := R.Top + (R.Bottom - R.Top - ImgH) div 2;
    if DrawImage then
    begin
      if Checked then
      begin
        if Enabled then
        begin
          if Selected then
          begin
            Canvas.Brush.Color := LMDColorLighter(clHighlight, 50);
            Canvas.Pen.Color := clHighlight;
          end
          else
          begin
            Canvas.Brush.Color := LMDColorLighter(clHighlight, 85);
            Canvas.Pen.Color := clHighlight;
          end;
        end
        else
        begin
          Canvas.Brush.Color := LMDColorDarker(clWindow, 2);
          Canvas.Pen.Color := clHighlight;
        end;
        Canvas.Rectangle(X - 2, Y - 2, X + ImgW + 2, Y + ImgH + 2);
      end;
      if (Images <> nil) and (ImageIndex >= 0) and (ImageIndex < Images.Count) then
      begin
        if Enabled or DisabledImagePresent then
        begin
          if Selected and not Checked then
          begin
            Images.Draw(Canvas, X, Y, ImageIndex);
          end
          else
          begin
            AlphaImages := GetAlphaImages(Enabled, Selected);
            if (AlphaImages <> nil) and (ImageIndex < AlphaImages.Count) then
              DrawAlphaMaskedImage(Canvas, X, Y, ImgW, ImgH, Images, AlphaImages)
            else
              Images.Draw(Canvas, X, Y, ImageIndex);
          end;
        end
        else
          DrawGrayedImage(Images, ImageIndex, Canvas, X, Y,
            LMDColorLighter(clBtnShadow, 10));
      end
      else
      if ((FBitmap <> nil) and not FBitmap.Empty) or Checked then
      begin
        if (FBitmap = nil) or FBitmap.Empty then
        begin
          OrigImage := TBitmap.Create;
          OrigImage.Width := 16;
          OrigImage.Height := 16;
          if RadioItem then
            DrawFrameControl(OrigImage.Canvas.Handle, Rect(2, 0, 16, 16),
              DFC_MENU, DFCS_MENUBULLET)
          else
            DrawFrameControl(OrigImage.Canvas.Handle, Rect(3, 0, 16, 16),
              DFC_MENU, DFCS_MENUCHECK);
        end
        else
          OrigImage := FBitmap;
        Image := TBitmap.Create;
        try
          Image.PixelFormat := pf24bit;
          Image.Width := ImgW;
          Image.Height := ImgH;
          Image.Canvas.Brush.Color := OrigImage.Canvas.Pixels[0, OrigImage.Height - 1];
          Image.Canvas.FillRect(Rect(0, 0, ImgW, ImgH));
          if (OrigImage.Width < ImgW) or (OrigImage.Height < ImgH) then
          begin
            BitBlt(Image.Canvas.Handle, (ImgW - OrigImage.Width) div 2,
              (ImgH - OrigImage.Height) div 2, OrigImage.Width,
                OrigImage.Height,
              OrigImage.Canvas.Handle, 0, 0, SRCCOPY);
          end
          else
          begin
            BitBlt(Image.Canvas.Handle, 0, 0, ImgW, ImgH,
              OrigImage.Canvas.Handle,
              0, 0, SRCCOPY);
          end;
          if Enabled then
          begin
            if Selected and not Checked then
            begin
              Shadow := TBitmap.Create;
              Shadow.Assign(Image);
              MaskImage(Shadow, Shadow.Canvas.Pixels[0, ImgH - 1],
                LMDColorLighter(clBtnShadow, 10));
              LMDDrawTransparentBitmapEx(Canvas.Handle, Shadow, X + 1, Y + 1,
                Rect(0, 0, ImgW, ImgH), Shadow.Canvas.Pixels[0, ImgH - 1]);
              Shadow.Free;
              LMDDrawTransparentBitmapEx(Canvas.Handle, Image, X - 1, Y - 1,
                Rect(0, 0, ImgW, ImgH), Image.Canvas.Pixels[0, ImgH - 1]);
            end
            else
            begin
              LMDDrawTransparentBitmapEx(Canvas.Handle, Image, X, Y,
                Rect(0, 0, ImgW, ImgH), Image.Canvas.Pixels[0, ImgH - 1]);
            end;
          end
          else
          begin
            MaskImage(Image, Image.Canvas.Pixels[0, ImgH - 1],
              LMDColorLighter(clBtnShadow, 10));
            LMDDrawTransparentBitmapEx(Canvas.Handle, Image, X, Y,
              Rect(0, 0, ImgW, ImgH), Image.Canvas.Pixels[0, ImgH - 1]);
          end;
        finally
          Image.Free;
        end;
        if (FBitmap = nil) or FBitmap.Empty then
          OrigImage.Free;
      end;
    end;
    if ImgW > 0 then
    begin
      if not IsTopLevel then
        Inc(X, ImgW + 11)
      else
        Inc(X, ImgW + 5);
    end;
    if IsTopLevel then
      Inc(X, 4);
    if Enabled then
      Canvas.Font.Color := clMenuText
    else
      Canvas.Font.Color := clBtnShadow;
    FontStyle := Canvas.Font.Style;
    if Default and not (fsBold in FontStyle) then
      Canvas.Font.Style := Canvas.Font.Style + [fsBold];
    Canvas.Brush.Color := clNone;
    if FCaption <> '' then
    begin
      Flags := DT_LEFT or DT_SINGLELINE or DT_NOCLIP or DT_VCENTER or DT_EXPANDTABS;
      TR := R;
      TR.Left := X;
      DoDrawText(Canvas, FCaption, TR, Selected, Flags);
    end;
    if not (GetParentMenu is TElMainMenu) then
    begin
      if (Self.Count > 0) then
      begin
        TR := R;
        TR.Left := TR.Right - 20;
        if Enabled then
          LMDDrawArrow(Canvas, eadRight, TR, Canvas.Font.Color, True)
        else
          LMDDrawArrow(Canvas, eadRight, TR, clBtnShadow, True);
      end
    end;
    if (FShortCut <> 0) and (Self.Count = 0) then
    begin
      Text := ElShortCutToText(FShortCut);
      if Text <> '' then
      begin
        Flags := DT_RIGHT or DT_SINGLELINE or DT_NOCLIP or DT_VCENTER or
          DT_NOPREFIX;
        TR := R;
        Dec(TR.Right, 20);
        DoDrawText(Canvas, Text, TR, Selected, Flags);
      end;
    end;
    Canvas.Font.Style := FontStyle;
  end;
end;

procedure TElMenuItem.DrawWindowsXPLeftToRight(Canvas: TCanvas; R: TRect; Selected: boolean);
var
  Images, AlphaImages: TCustomImageList;
  ImgW, ImgH: integer;
  X, Y: integer;
  Flags: integer;
  TR: TRect;
  Text: TLMDString;
  FontStyle: TFontStyles;
  DrawImage: boolean;
  Image: TBitmap;
  OrigImage: TBitmap;
  RasterOp : integer;
  LImageMargin: integer;
  LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  if FCaption = cLineCaption then
  begin
    if IsTopLevel then
    begin
      if (GetParentMenu is TElMainMenu) then
      begin
        if LMDSIWindowsVistaUp and (LThemeMode <> ttmNone) then
          Canvas.Brush.Color := LMDThemeServices.GetThemeSysColor(LThemeMode, teMenu, COLOR_MENU)
        else
          Canvas.Brush.Color := clMenu;
        Canvas.FillRect(Rect(R.Left, R.Top, R.Right, R.Bottom + 1));
        Canvas.Pen.Color := clBtnShadow;
        Canvas.Pen.Color := LMDColorLighter(Canvas.Pen.Color, 25);
        Canvas.MoveTo(R.Left + (R.Right - R.Left) div 2, R.Top);
        Canvas.LineTo(R.Left + (R.Right - R.Left) div 2, R.Bottom);
      end;
    end
    else
    begin
      if LThemeMode <> ttmNone then
        if LMDSIWindowsVistaUp then
          Canvas.Brush.Color := LMDThemeServices.GetThemeSysColor(LThemeMode, teMenu, COLOR_MENU)
        else
          Canvas.Brush.Color := clMenu
      else
        if LMDSIWindowsVistaUp and LMDThemeServices.ThemesEnabled(ttmPlatform) then
          Canvas.Brush.Color := LMDThemeServices.GetThemeSysColor(ttmPlatform, teMenu, COLOR_MENU)
        else
          Canvas.Brush.Color := clWindow;

      Canvas.FillRect(R);
      Canvas.Pen.Color := clBtnShadow;

      Canvas.MoveTo(R.Left, R.Top + (R.Bottom - R.Top) div 2);
      Canvas.LineTo(R.Right, R.Top + (R.Bottom - R.Top) div 2);
    end;
  end
  else
  begin
    if Selected then
    begin
      if IsVistaSelNeed(Selected) then
      begin
        {$IFDEF LMDCOMP16}
        if not (csDesigning in ComponentState) and StyleServices.Enabled and  not StyleServices.IsSystemStyle then
           StyleServices.DrawElement(Canvas.Handle, StyleServices.GetElementDetails(tmMenuBarItemHot),R)
        else
        begin
          Canvas.Brush.Color := LMDColorLighter(clHighlight, 5);
          Canvas.Pen.Color := LMDColorDarker(clHighlight, 5);
          Canvas.Rectangle(R);
        end;
        {$ELSE}
        Canvas.Brush.Color := LMDColorLighter(clHighlight, 5);
        Canvas.Pen.Color := LMDColorDarker(clHighlight, 5);
        Canvas.Rectangle(R);
        {$ENDIF}
      end;
    end
    else
    begin
      if IsTopLevel then
      begin
        if (GetParentMenu is TElMainMenu) then
        begin
          Canvas.Brush.Color := clBtnFace;
          Canvas.FillRect(R);
        end;
      end
      else
      begin
        if LThemeMode <> ttmNone then
          if LMDSIWindowsVistaUp then
            Canvas.Brush.Color := LMDThemeServices.GetThemeSysColor(LThemeMode, teMenu, COLOR_MENU)
          else
            Canvas.Brush.Color := clMenu
        else
          if LMDSIWindowsVistaUp and LMDThemeServices.ThemesEnabled(ttmPlatform) then
            Canvas.Brush.Color := LMDThemeServices.GetThemeSysColor(ttmPlatform, teMenu, COLOR_MENU)
          else
            Canvas.Brush.Color := clWindow;
        Canvas.FillRect(R);
      end;
    end;

    Images := GetImages(Enabled, Selected);
    if (Images <> nil) and (Parent.ChildsHasImage) then
    begin
      ImgW := TCustomImageList(Images).Width;
      ImgH := TCustomImageList(Images).Height;
    end
    else
    if IsTopLevel then
    begin
      ImgW := 0;
      ImgH := 0;
    end
    else
    begin
      ImgW := 16;
      ImgH := 16;
    end;
    DrawImage := ((Images <> nil) and (ImageIndex >= 0) and (ImageIndex <
      Images.Count)) or
      ((FBitmap <> nil) and not FBitmap.Empty) or Checked;
    X := R.Left + 4;
    Y := R.Top + (R.Bottom - R.Top - ImgH) div 2;
    if DrawImage then
    begin
      if Checked and ((Images <> nil) or ((FBitmap <> nil) and not
        FBitmap.Empty)) then
      begin
        if IsVistaSelNeed(Selected) then
          Canvas.Brush.Color := LMDColorLighter(clHighlight, 5)
        else
        if IsTopLevel then
          Canvas.Brush.Color := clBtnFace
        else
        if IsThemed then
          Canvas.Brush.Color := clMenu
        else
          Canvas.Brush.Color := clWindow;
        Canvas.Pen.Color := Canvas.Brush.Color;//LMDColorLighter(clHighlight, 5);
        if not (Selected and LMDSIWindowsVistaUp and IsThemed and LMDThemeServices.ThemesEnabled(LThemeMode)) then
          Canvas.Rectangle(X - 2, Y - 2, X + ImgW + 2, Y + ImgH + 2);
      end;

      RasterOp := SRCCOPY;
      if (Images <> nil) and (ImageIndex >= 0) and (ImageIndex < Images.Count) then
      begin
        if Enabled or DisabledImagePresent then
        begin
          AlphaImages := GetAlphaImages(Enabled, Selected);
          if (AlphaImages <> nil) and (ImageIndex < AlphaImages.Count) then
            DrawAlphaMaskedImage(Canvas, X, Y, ImgW, ImgH, Images, AlphaImages)
          else
            Images.Draw(Canvas, X, Y, ImageIndex);
        end
        else
          DrawGrayedImage(Images, ImageIndex, Canvas, X, Y);
      end
      else
        if ((FBitmap <> nil) and not FBitmap.Empty) or Checked then
      begin
        if (FBitmap = nil) or FBitmap.Empty then
        begin
          OrigImage := TBitmap.Create;
          OrigImage.Width := 16;
          OrigImage.Height := 16;
          if RadioItem then
            DrawFrameControl(OrigImage.Canvas.Handle, Rect(2, 0, 16, 16), DFC_MENU, DFCS_MENUBULLET)
          else
            DrawFrameControl(OrigImage.Canvas.Handle, Rect(3, 0, 16, 16), DFC_MENU, DFCS_MENUCHECK);

          if IsVistaSelNeed(Selected) then
            RasterOp := SRCINVERT
          else
            RasterOp := SRCCOPY;
        end
        else
          OrigImage := FBitmap;
        Image := TBitmap.Create;
        try
          Image.PixelFormat := pf24bit;
          Image.Width := ImgW;
          Image.Height := ImgH;
          Image.Canvas.Brush.Color := OrigImage.Canvas.Pixels[0, OrigImage.Height
            - 1];
          Image.Canvas.FillRect(Rect(0, 0, ImgW, ImgH));

          if (OrigImage.Width < ImgW) and (OrigImage.Height < ImgH) then
          begin
            BitBlt(Image.Canvas.Handle, (ImgW - OrigImage.Width) div 2,
              (ImgH - OrigImage.Height) div 2, OrigImage.Width,
                OrigImage.Height,
              OrigImage.Canvas.Handle, 0, 0, RasterOp);
          end
          else
          begin
            BitBlt(Image.Canvas.Handle, 0, 0, ImgW, ImgH,
              OrigImage.Canvas.Handle,
              0, 0, RasterOp);
          end;
          if not Enabled then
            MaskImage(Image, Image.Canvas.Pixels[0, ImgH - 1], clBtnShadow);
          LMDDrawTransparentBitmapEx(Canvas.Handle, Image, X, Y,
            Rect(0, 0, ImgW, ImgH), Image.Canvas.Pixels[0, ImgH - 1]);
        finally
          Image.Free;
        end;
        if (FBitmap = nil) or FBitmap.Empty then
          OrigImage.Free;
      end;
    end;
    // get item space
    if (GetParentMenu is TElMainMenu) then
      LImageMargin := TElMainMenu(GetParentMenu).FImageMargin
    else
      if (GetParentMenu is TElPopupMenu) then
        LImageMargin := TElPopupMenu(GetParentMenu).FImageMargin
      else
        LImageMargin := 6;

    if ImgW > 0 then
      Inc(X, ImgW + LImageMargin);
    if IsTopLevel then
      Inc(X, LImageMargin - 2);

    Canvas.Font.Color := GetFontColor(LThemeMode, Selected);

    FontStyle := Canvas.Font.Style;
    if Default and not (fsBold in FontStyle) then
      Canvas.Font.Style := Canvas.Font.Style + [fsBold];
    Canvas.Brush.Color := clNone;
    if FCaption <> '' then
    begin
      Flags := DT_LEFT or DT_SINGLELINE or DT_NOCLIP or DT_VCENTER or
        DT_EXPANDTABS;
      TR := R;
      TR.Left := X;
      DoDrawText(Canvas, FCaption, TR, Selected, Flags);
    end;
    if not (GetParentMenu is TElMainMenu) then
    begin
      if Self.Count > 0 then
      begin
        TR := R;
        TR.Left := TR.Right - 20;
        if Enabled then
          LMDDrawArrow(Canvas, eadRight, TR, Canvas.Font.Color, True)
        else
          LMDDrawArrow(Canvas, eadRight, TR, clBtnShadow, True);
      end
    end;
    if (FShortCut <> 0) and (Self.Count = 0) then
    begin
      Text := ElShortCutToText(FShortCut);
      if Text <> '' then
      begin
        Flags := DT_RIGHT or DT_SINGLELINE or DT_NOCLIP or DT_VCENTER or
          DT_NOPREFIX;
        TR := R;
        Dec(TR.Right, 20);
        DoDrawText(Canvas, Text, TR, Selected, Flags);
      end;
    end;
    Canvas.Font.Style := FontStyle;
  end;
end;

function TElMenuItem.IsThemed: boolean;
var
  Menu: TMenu;
begin
  Menu := GetParentMenu;
  if Menu is TElPopupMenu then
    Result := TElPopupMenu(Menu).IsThemed
  else
    if Menu is TElMainMenu then
      Result := TElMainMenu(Menu).IsThemed
    else
      Result := False;
end;

function TElMenuItem.UseThemeMode: TLMDThemeMode;
var
  Menu: TMenu;
begin
  Menu := GetParentMenu;
  if Menu is TElPopupMenu then
    Result := TElPopupMenu(Menu).UseThemeMode
  else
    if Menu is TElMainMenu then
      Result := TElMainMenu(Menu).UseThemeMode
    else
      Result := ttmPlatform;
end;

function TElMenuItem.GetImages(Enabled, Selected : boolean): TCustomImageList;
var
  Menu: TMenu;
begin
  Result := nil;
  if (FParent <> nil) and (FParent.SubMenuImages <> nil) then
    Result := FParent.SubMenuImages
  else
  begin
    Menu := GetParentMenu;
    if Menu is TElPopupMenu then
    begin
      if (Selected and Enabled) then
        Result := TElPopupMenu(Menu).HotImages;
      if not Enabled then
        Result := TElPopupMenu(Menu).DisabledImages;
      if Result = nil then
        Result := TElPopupMenu(Menu).Images
    end
    else
    begin
      if (Selected and Enabled) then
        Result := TElMainMenu(Menu).HotImages;
      if not Enabled then
        Result := TElMainMenu(Menu).DisabledImages;
      if Result = nil then
        Result := TElMainMenu(Menu).Images
    end;
  end;
end;

function TElMenuItem.GetAlphaImages(Enabled, Selected : boolean): TCustomImageList;
var
  Menu: TMenu;
begin
  Result := nil;
  if (FParent <> nil) and (FParent.AlphaForSubMenuImages <> nil) then
    Result := FParent.AlphaForSubMenuImages
  else
  begin
    Menu := GetParentMenu;
    if Menu is TElPopupMenu then
    begin
      if (Selected and Enabled) then
        Result := TElPopupMenu(Menu).AlphaForHotImages;
      if not Enabled then
        Result := TElPopupMenu(Menu).AlphaForDisabledImages;
      if Result = nil then
        Result := TElPopupMenu(Menu).AlphaForImages
    end
    else
    begin
      if (Selected and Enabled) then
        Result := TElMainMenu(Menu).AlphaForHotImages;
      if not Enabled then
        Result := TElMainMenu(Menu).AlphaForDisabledImages;
      if Result = nil then
        Result := TElMainMenu(Menu).AlphaForImages
    end;
  end;
end;

procedure TElMenuItem.MeasureMenuItem(Canvas: TCanvas; var Width,
  Height: integer);
begin
  case GetDrawStyle of
    tdsNormal: MeasureNormalItem(Canvas, Width, Height);
    tdsOfficeXP: MeasureOfficeXPItem(Canvas, Width, Height);
    tdsOffice2003: MeasureOfficeXPItem(Canvas, Width, Height);
    tdsWindowsXP: MeasureWindowsXPItem(Canvas, Width, Height);
  end;
end;

procedure TElMenuItem.MeasureNormalItem(Canvas: TCanvas; var Width,
  Height: integer);
var
  ImgW, ImgH: integer;
  TxtW, TxtH: integer;
  CutW, CutH: integer;
  DrawStyle: integer;
  R: TRect;
  Text: WideString;
  Images: TCustomImageList;
  LItemSpace: integer;
begin
  if FCaption = cLineCaption then
  begin
    Width := 6;
    Height := 6;
  end
  else
  begin
    // get item space
    if (GetParentMenu is TElMainMenu) then
      LItemSpace := TElMainMenu(GetParentMenu).FItemSpace
    else
      if (GetParentMenu is TElPopupMenu) then
        LItemSpace := TElPopupMenu(GetParentMenu).FItemSpace
      else
        LItemSpace := 4;
    // calculating image sizes
    Images := GetImages(true, false);
    if (Images <> nil) and (ImageIndex <> -1) then
    begin
      ImgW := TCustomImageList(Images).Width;
      ImgH := TCustomImageList(Images).Height + LItemSpace;
    end
    else
    if not IsTopLevel then
    begin
      ImgW := 20;
      ImgH := Abs(Canvas.Font.Height) + LItemSpace + 5;
    end
    else
    begin
      ImgW := 0;
      ImgH := Abs(Canvas.Font.Height) + LItemSpace + 5;
    end;
    // calculation caption sizes
    if FCaption <> '' then
    begin
      DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or DT_NOCLIP or DT_CALCRECT;
      SetRectEmpty(R);
      DoDrawText(Canvas, FCaption, R, True, DrawStyle);
      TxtW := R.Right - R.Left;
      TxtH := R.Bottom - R.Top + LItemSpace;
    end
    else
    begin
      TxtW := 0;
      DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or DT_NOCLIP or DT_CALCRECT;
      SetRectEmpty(R);
      DoDrawText(Canvas, 'W', R, True, DrawStyle);
      TxtH := R.Bottom - R.Top + LItemSpace;
    end;
    // calculating shortcut sizes
    CutW := 0;
    CutH := 0;
    if (FShortCut <> 0) and (Self.Count = 0) then
    begin
      Text := ElShortCutToText(FShortCut);
      DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or DT_NOCLIP or DT_CALCRECT;
      SetRectEmpty(R);
      DoDrawText(Canvas, Text, R, True, DrawStyle);
      CutW := R.Right - R.Left;
      CutH := R.Bottom - R.Top + LItemSpace;
    end;
    // calculating whole item sizes
    Width := (2 + ImgW) + TxtW;
    if (Self.Count = 0) and (CutW > 0) then
      Inc(Width, (20 + CutW));

    if not IsTopLevel then
      Inc(Width, 20);
    Height := TxtH;
    if ImgH > Height then
      Height := ImgH;
    if (Self.Count = 0) and (CutH > Height) then
      Height := CutH;
  end;
end;

procedure TElMenuItem.MeasureOfficeXPItem(Canvas: TCanvas; var Width,
  Height: integer);
var
  ImgW, ImgH: integer;
  TxtW, TxtH: integer;
  CutW, CutH: integer;
  DrawStyle: integer;
  R: TRect;
  Text: WideString;
  Images: TCustomImageList;
  LItemSpace: Integer;
begin
  if FCaption = cLineCaption then
  begin
    Width := 1;
    Height := 3;
  end
  else
  begin
    // get item space
    if (GetParentMenu is TElMainMenu) then
      LItemSpace := TElMainMenu(GetParentMenu).FItemSpace
    else
      if (GetParentMenu is TElPopupMenu) then
        LItemSpace := TElPopupMenu(GetParentMenu).FItemSpace
      else
        LItemSpace := 6;
    // calculating image sizes
    Images := GetImages(true, false);
    if (Images <> nil) and (ImageIndex <> -1) then
    begin
      ImgW := TCustomImageList(Images).Width;
      ImgH := TCustomImageList(Images).Height + LItemSpace;
    end
    else
    if IsTopLevel then
    begin
      ImgW := 0;
      ImgH := Abs(Canvas.Font.Height) + LItemSpace + 3;
    end
    else
    begin
      ImgW := 22;
      ImgH := Abs(Canvas.Font.Height) + LItemSpace + 5;
    end;
    // calculation caption sizes
    if FCaption <> '' then
    begin
      DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or DT_NOCLIP or DT_CALCRECT;
      SetRectEmpty(R);
      DoDrawText(Canvas, FCaption, R, True, DrawStyle);
      TxtW := R.Right - R.Left;
      TxtH := R.Bottom - R.Top + LItemSpace;
    end
    else
    begin
      TxtW := 0;
      DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or DT_NOCLIP or DT_CALCRECT;
      SetRectEmpty(R);
      DoDrawText(Canvas, 'W', R, True, DrawStyle);
      TxtH := R.Bottom - R.Top + LItemSpace;
    end;
    // calculating shortcut sizes
    CutW := 0;
    CutH := 0;
    if (FShortCut <> 0) and (Self.Count = 0) then
    begin
      Text := ElShortCutToText(FShortCut);
      DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or DT_NOCLIP or DT_CALCRECT;
      SetRectEmpty(R);
      DoDrawText(Canvas, Text, R, True, DrawStyle);
      CutW := R.Right - R.Left;
      CutH := R.Bottom - R.Top + LItemSpace;
    end;
    // calculating whole item sizes
    Width := (3 + ImgW + TxtW + 3);

    if ImgW > 0 then
    begin
      if not IsTopLevel then
        Inc(Width, 11)
      else
        Inc(Width, 5);
    end;
    if IsTopLevel then
      Inc(Width, 8);

    if (Self.Count = 0) and (CutW > 0) then
      Inc(Width, (20 + CutW));

    if not IsTopLevel then
      Inc(Width, 20);

    Height := TxtH;
    if ImgH > Height then
      Height := ImgH;
    if (Self.Count = 0) and (CutH > Height) then
      Height := CutH;

    if (GetParentMenu is TElMainMenu) {and IsTopLevel }then
      Dec(Width, 14);

  end;
end;

procedure TElMenuItem.DrawWindowsXPRightToLeft(Canvas: TCanvas; R: TRect;
  Selected: boolean);
var
  AlphaImages, Images: TCustomImageList;
  ImgW, ImgH: integer;
  X, Y: integer;
  Flags: integer;
  TR: TRect;
  Text: TLMDString;
  FontStyle: TFontStyles;
  DrawImage: boolean;
  Image: TBitmap;
  OrigImage: TBitmap;
  RasterOp : integer;
  LImageMargin: integer;
  LThemeMode: TLMDThemeMode;
begin

  LThemeMode := UseThemeMode;
  if FCaption = cLineCaption then
  begin
    if IsTopLevel then
    begin
      if (GetParentMenu is TElMainMenu) then
      begin
        if LMDSIWindowsVistaUp and (LThemeMode <> ttmNone) then
          Canvas.Brush.Color := LMDThemeServices.GetThemeSysColor(LThemeMode, teMenu, COLOR_MENU)
        else
          Canvas.Brush.Color := clMenu;
        Canvas.FillRect(Rect(R.Left, R.Top, R.Right, R.Bottom + 1));
        Canvas.Pen.Color := clBtnShadow;
        Canvas.Pen.Color := LMDColorLighter(Canvas.Pen.Color, 25);
        Canvas.MoveTo(R.Left + (R.Right - R.Left) div 2, R.Top);
        Canvas.LineTo(R.Left + (R.Right - R.Left) div 2, R.Bottom);
      end;
    end
    else
    begin
      if LThemeMode <> ttmNone {IsThemed} then //GTP4
        if LMDSIWindowsVistaUp then
          Canvas.Brush.Color := LMDThemeServices.GetThemeSysColor(LThemeMode, teMenu, COLOR_MENU)
        else
          Canvas.Brush.Color := clMenu
      else
        if LMDSIWindowsVistaUp and LMDThemeServices.ThemesEnabled(ttmPlatform) then
          Canvas.Brush.Color := LMDThemeServices.GetThemeSysColor(ttmPlatform, teMenu, COLOR_MENU)
        else
          Canvas.Brush.Color := clWindow;

      Canvas.FillRect(R);
      Canvas.Pen.Color := clBtnShadow;

      Canvas.MoveTo(R.Left, R.Top + (R.Bottom - R.Top) div 2);
      Canvas.LineTo(R.Right, R.Top + (R.Bottom - R.Top) div 2);
    end;
  end
  else
  begin
    if Selected then
    begin
      {$IFDEF LMDCOMP16}
      if not (csDesigning in ComponentState) and StyleServices.Enabled and  not StyleServices.IsSystemStyle then
         StyleServices.DrawElement(Canvas.Handle, StyleServices.GetElementDetails(tmMenuBarItemHot),R)
      else
      begin
        Canvas.Brush.Color := LMDColorLighter(clHighlight, 5);
        Canvas.Pen.Color := LMDColorDarker(clHighlight, 5);
        Canvas.Rectangle(R);
      end;
      {$ELSE}
      Canvas.Brush.Color := LMDColorLighter(clHighlight, 5);
      Canvas.Pen.Color := LMDColorDarker(clHighlight, 5);
      Canvas.Rectangle(R);
      {$ENDIF}
    end
    else
    begin
      if IsTopLevel then
      begin
        if (GetParentMenu is TElMainMenu) then
        begin
          Canvas.Brush.Color := clBtnFace;
          Canvas.FillRect(R);
        end;
      end
      else
      begin
        if LThemeMode <> ttmNone {IsThemed} then
          if LMDSIWindowsVistaUp then
            Canvas.Brush.Color := LMDThemeServices.GetThemeSysColor(ttmPlatform, teMenu, COLOR_MENU)
          else
            Canvas.Brush.Color := clMenu
        else
          if LMDSIWindowsVistaUp and LMDThemeServices.ThemesEnabled(ttmPlatform) then
            Canvas.Brush.Color := LMDThemeServices.GetThemeSysColor(LThemeMode, teMenu, COLOR_MENU)
          else
            Canvas.Brush.Color := clWindow;
        Canvas.FillRect(R);
      end;
    end;

    Images := GetImages(Enabled, Selected);
    if (Images <> nil) and (Parent.ChildsHasImage) then
    begin
      ImgW := TCustomImageList(Images).Width;
      ImgH := TCustomImageList(Images).Height;
    end
    else
    if IsTopLevel then
    begin
      ImgW := 0;
      ImgH := 0;
    end
    else
    begin
      ImgW := 16;
      ImgH := 16;
    end;
    DrawImage := ((Images <> nil) and
                  (ImageIndex >= 0) and
                  (ImageIndex < Images.Count)) or
                 ((FBitmap <> nil) and not FBitmap.Empty) or Checked;
    X := R.Right - ImgW - 4;
    Y := R.Top + (R.Bottom - R.Top - ImgH) div 2;
    if DrawImage then
    begin
      if Checked and ((Images <> nil) or ((FBitmap <> nil) and not
        FBitmap.Empty)) then
      begin
        if IsVistaSelNeed(Selected) then
          Canvas.Brush.Color := LMDColorLighter(clHighlight, 5)
        else
        if IsTopLevel then
          Canvas.Brush.Color := clBtnFace
        else
        if IsThemed then
          Canvas.Brush.Color := clMenu
        else
          Canvas.Brush.Color := clWindow;
        Canvas.Pen.Color := Canvas.Brush.Color;//LMDColorLighter(clHighlight, 5);
        if not (Selected and LMDSIWindowsVistaUp and IsThemed and LMDThemeServices.ThemesEnabled(LThemeMode)) then
          Canvas.Rectangle(X - 2, Y - 2, X + ImgW + 2, Y + ImgH + 2);
      end;
      RasterOp := SRCCOPY;

      if (Images <> nil) and (ImageIndex >= 0) and (ImageIndex < Images.Count) then
      begin
        if Enabled or DisabledImagePresent then
        begin
          AlphaImages := GetAlphaImages(Enabled, Selected);
          if (AlphaImages <> nil) and (ImageIndex < AlphaImages.Count) then
            DrawAlphaMaskedImage(Canvas, X, Y, ImgW, ImgH, Images, AlphaImages)
          else
            Images.Draw(Canvas, X, Y, ImageIndex);
        end
        else
          DrawGrayedImage(Images, ImageIndex, Canvas, X, Y);
      end
      else
      if ((FBitmap <> nil) and not FBitmap.Empty) or Checked then
      begin
        if (FBitmap = nil) or FBitmap.Empty then
        begin
          OrigImage := TBitmap.Create;
          OrigImage.Width := 16;
          OrigImage.Height := 16;
          if RadioItem then
            DrawFrameControl(OrigImage.Canvas.Handle, Rect(2, 0, 16, 16),
              DFC_MENU, DFCS_MENUBULLET)
          else
            DrawFrameControl(OrigImage.Canvas.Handle, Rect(3, 0, 16, 16),
              DFC_MENU, DFCS_MENUCHECK);

          if IsVistaSelNeed(Selected) then
            RasterOp := SRCINVERT
          else
            RasterOp := SRCCOPY;
        end
        else
          OrigImage := FBitmap;
        Image := TBitmap.Create;
        try
          Image.PixelFormat := pf24bit;
          Image.Width := ImgW;
          Image.Height := ImgH;
          Image.Canvas.Brush.Color := OrigImage.Canvas.Pixels[0, OrigImage.Height
            - 1];
          Image.Canvas.FillRect(Rect(0, 0, ImgW, ImgH));
          if (OrigImage.Width <= ImgW) and (OrigImage.Height <= ImgH) then
          begin
            BitBlt(Image.Canvas.Handle, (ImgW - OrigImage.Width) div 2,
              (ImgH - OrigImage.Height) div 2, OrigImage.Width,
                OrigImage.Height,
              OrigImage.Canvas.Handle, 0, 0, RasterOp);
          end
          else
          begin
            BitBlt(Image.Canvas.Handle, 0, 0, ImgW, ImgH,
              OrigImage.Canvas.Handle,
              0, 0, RasterOp);
          end;
          if not Enabled then
            MaskImage(Image, Image.Canvas.Pixels[0, ImgH - 1], clBtnShadow);
          LMDDrawTransparentBitmapEx(Canvas.Handle, Image, X, Y,
            Rect(0, 0, ImgW, ImgH), Image.Canvas.Pixels[0, ImgH - 1]);
        finally
          Image.Free;
        end;
        if (FBitmap = nil) or FBitmap.Empty then
          OrigImage.Free;
      end;
    end;
    // get item space
    if (GetParentMenu is TElMainMenu) then
      LImageMargin := TElMainMenu(GetParentMenu).FImageMargin
    else
      if (GetParentMenu is TElPopupMenu) then
        LImageMargin := TElPopupMenu(GetParentMenu).FImageMargin
      else
        LImageMargin := 6;

    if ImgW > 0 then
      Dec(X, LImageMargin);
    if IsTopLevel then
      Dec(X, LImageMargin - 2);

    Canvas.Font.Color := GetFontColor(LThemeMode, Selected);

    FontStyle := Canvas.Font.Style;
    if Default and not (fsBold in FontStyle) then
      Canvas.Font.Style := Canvas.Font.Style + [fsBold];
    Canvas.Brush.Color := clNone;
    if FCaption <> '' then
    begin
//      Flags := DT_LEFT or DT_SINGLELINE or DT_NOCLIP or DT_VCENTER or DT_EXPANDTABS;
      Flags := DT_RIGHT or DT_SINGLELINE or DT_NOCLIP or DT_VCENTER or DT_EXPANDTABS;
      TR := R;
      TR.Right := X;
      DoDrawText(Canvas, FCaption, TR, Selected, Flags);
    end;
    if not (GetParentMenu is TElMainMenu) then
    begin
      if Self.Count > 0 then
      begin
        TR := R;
        TR.Right := TR.Left + 20;
        if Enabled then
          LMDDrawArrow(Canvas, eadLeft, TR, Canvas.Font.Color, True)
        else
          LMDDrawArrow(Canvas, eadLeft, TR, clBtnShadow, True);
      end
    end;
    if (FShortCut <> 0) and (Self.Count = 0) then
    begin
      Text := ElShortCutToText(FShortCut);
      if Text <> '' then
      begin
        Flags := DT_LEFT or DT_SINGLELINE or DT_NOCLIP or DT_VCENTER or
          DT_NOPREFIX;
        TR := R;
        Inc(TR.Left, 20);
        DoDrawText(Canvas, Text, TR, Selected, Flags);
      end;
    end;
    Canvas.Font.Style := FontStyle;
  end;
end;

procedure TElMenuItem.DrawNormalRightToLeft(Canvas: TCanvas; R: TRect;
  Selected: boolean);
var
  AlphaImages, Images: TCustomImageList;
  ImgW, ImgH: integer;
  X, Y: integer;
  Flags: integer;
  TR: TRect;
  Text: TLMDString;
  FontStyle: TFontStyles;
  DrawImage: boolean;
  Image, TempImage: TBitmap;
  OrigImage: TBitmap;
  LImageMargin: integer;
begin
  if FCaption = cLineCaption then
  begin
    if Selected then
      Canvas.Brush.Color := clHighlight
    else

    Canvas.Brush.Color := clBtnFace;
    Canvas.FillRect(R);
    if IsTopLevel then
    begin
      TR := R;
      TR.Left := TR.Left + (TR.Right - TR.Left - 2) div 2;
      TR.Right := TR.Left + 2;
      DrawEdge(Canvas.Handle, TR, BDR_SUNKENOUTER, BF_RECT);
    end
    else
    begin
      TR := R;
      TR.Top := R.Top + (R.Bottom - R.Top - 2) div 2;
      TR.Bottom := TR.Top + 2;
      DrawEdge(Canvas.Handle, TR, BDR_SUNKENOUTER, BF_RECT);
    end;
  end
  else
  begin
    if (GetParentMenu is TElMainMenu) then
    begin
      if Selected then
        Canvas.Brush.Color := clHighlight
      else
        Canvas.Brush.Color := clBtnFace;
      Canvas.FillRect(R);
    end
    else
    if Selected then
    begin
     Canvas.Brush.Color := clHighlight;
     Canvas.FillRect(R);
    end;

    Images := GetImages(Enabled, Selected);
    if (Images <> nil) and (Parent.ChildsHasImage) then
    begin
      ImgW := TCustomImageList(Images).Width;
      ImgH := TCustomImageList(Images).Height;
    end
    else
    if IsTopLevel then
    begin
      ImgW := 0;
      ImgH := 0;
    end
    else
    begin
      ImgW := 16;
      ImgH := 16;
    end;

    DrawImage := ((Images <> nil) and (ImageIndex >= 0) and (ImageIndex <
      Images.Count)) or
      ((FBitmap <> nil) and not FBitmap.Empty) or Checked;
    X := R.Right - ImgW - 4;
    Y := R.Top + (R.Bottom - R.Top - ImgH) div 2;
    if DrawImage then
    begin
      if (Selected or Checked) and
        ((Images <> nil) or ((FBitmap <> nil) and not FBitmap.Empty)) then
      begin
        Canvas.Brush.Color := clBtnFace;
        TR := Rect(X - 2, Y - 2, R.Right, Y + ImgH + 2);
        if Checked and not Selected then
        begin
          Image := TBitmap.Create;
          try
            Image.Width := 2;
            Image.Height := 2;
            Image.Canvas.Pixels[0, 0] := clWindow;
            Image.Canvas.Pixels[1, 0] := clBtnFace;
            Image.Canvas.Pixels[0, 1] := clBtnFace;
            Image.Canvas.Pixels[1, 1] := clWindow;
            Canvas.Brush.Bitmap := Image;
            Canvas.FillRect(TR);
          finally
            Canvas.Brush.Bitmap := nil;
            Image.Free;
          end;
        end
        else
          Canvas.FillRect(TR);
        if Checked then
          DrawEdge(Canvas.Handle, TR, BDR_SUNKENOUTER, BF_RECT or BF_ADJUST)
        else
          DrawEdge(Canvas.Handle, TR, BDR_RAISEDINNER, BF_RECT or BF_ADJUST);
        Canvas.Pen.Color := clBtnFace;
        Canvas.MoveTo(X , Y - 2);
        Canvas.LineTo(X , Y + ImgH + 2);
      end;
      if (Images <> nil) and (ImageIndex >= 0) and (ImageIndex < Images.Count) then
      begin
        AlphaImages := GetAlphaImages(Enabled, Selected);
        if (AlphaImages <> nil) and (ImageIndex < AlphaImages.Count) then
          DrawAlphaMaskedImage(Canvas, X , Y, ImgW, ImgH, Images, AlphaImages)
        else
          Images.Draw(Canvas, X , Y, ImageIndex);
      end
      else
      if ((FBitmap <> nil) and not FBitmap.Empty) or Checked then
      begin
        if (FBitmap = nil) or FBitmap.Empty then
        begin
          OrigImage := TBitmap.Create;
          OrigImage.Width := 16;
          OrigImage.Height := 16;
          if RadioItem then
            DrawFrameControl(OrigImage.Canvas.Handle, Rect(2, 0, 16, 16),
              DFC_MENU, DFCS_MENUBULLET)
          else
            DrawFrameControl(OrigImage.Canvas.Handle, Rect(3, 0, 16, 16),
              DFC_MENU, DFCS_MENUCHECK);
        end
        else
          OrigImage := FBitmap;
        Image := TBitmap.Create;
        try
          Image.PixelFormat := pf24bit;
          Image.Width := ImgW;
          Image.Height := ImgH;
          Image.Canvas.Brush.Color := OrigImage.Canvas.Pixels[0, OrigImage.Height
            - 1];
          Image.Canvas.FillRect(Rect(0, 0, ImgW, ImgH));
          if (OrigImage.Width <= ImgW) and (OrigImage.Height <= ImgH) then
          begin
            BitBlt(Image.Canvas.Handle, (ImgW - OrigImage.Width) div 2,
              (ImgH - OrigImage.Height) div 2, OrigImage.Width,
                OrigImage.Height,
              OrigImage.Canvas.Handle, 0, 0, SRCCOPY);
          end
          else
          begin
            BitBlt(Image.Canvas.Handle, 0, 0, ImgW, ImgH,
              OrigImage.Canvas.Handle,
              0, 0, SRCCOPY);
          end;
          if not Enabled then
          begin
            TempImage := TBitmap.Create;
            TempImage.Assign(Image);
            MaskImage(TempImage, TempImage.Canvas.Pixels[0, ImgH - 1],
              clBtnHighlight);
            LMDDrawTransparentBitmapEx(Canvas.Handle, TempImage, X + 1, Y + 1,
              Rect(0, 0, ImgW, ImgH), TempImage.Canvas.Pixels[0, ImgH - 1]);
            TempImage.Free;
            MaskImage(Image, Image.Canvas.Pixels[0, ImgH - 1], clBtnShadow);
          end;
          LMDDrawTransparentBitmapEx(Canvas.Handle, Image, X, Y,
            Rect(0, 0, ImgW, ImgH), Image.Canvas.Pixels[0, ImgH - 1]);
        finally
          Image.Free;
        end;
        if (FBitmap = nil) or FBitmap.Empty then
          OrigImage.Free;
      end;
    end;
    if (GetParentMenu is TElMainMenu) then
      LImageMargin := TElMainMenu(GetParentMenu).FImageMargin
    else
      if (GetParentMenu is TElPopupMenu) then
        LImageMargin := TElPopupMenu(GetParentMenu).FImageMargin
      else
        LImageMargin := 6;

    Dec(X, LImageMargin);
    if Selected then
      Canvas.Font.Color := clHighlightText
    else
      Canvas.Font.Color := clBtnText;
    FontStyle := Canvas.Font.Style;
    if Default and not (fsBold in FontStyle) then
      Canvas.Font.Style := Canvas.Font.Style + [fsBold];
    Canvas.Brush.Color := clNone;
    if FCaption <> '' then
    begin
//      Flags := DT_LEFT or DT_SINGLELINE or DT_NOCLIP or DT_VCENTER or DT_EXPANDTABS;
      Flags := DT_RIGHT or DT_SINGLELINE or DT_NOCLIP or DT_VCENTER or DT_EXPANDTABS;
      TR := R;
      TR.Right := X;
      DoDrawText(Canvas, FCaption, TR, Selected, Flags);
    end;
    if not (GetParentMenu is TElMainMenu) then
    begin
      if Self.Count > 0 then
      begin
        TR := R;
        TR.Right := TR.Left + 20;
        if Enabled then
          LMDDrawArrow(Canvas, eadLeft, TR, Canvas.Font.Color, True)
        else
          LMDDrawArrow(Canvas, eadLeft, TR, clBtnShadow, True);
      end
    end;
    if (FShortCut <> 0) and (Self.Count = 0) then
    begin
      Text := ElShortCutToText(FShortCut);
      if Text <> '' then
      begin
        Flags := DT_LEFT or DT_SINGLELINE or DT_NOCLIP or DT_VCENTER or DT_NOPREFIX;
        TR := R;
        TR.Left := 20;
        DoDrawText(Canvas, Text, TR, Selected, Flags);
      end;
    end;
    Canvas.Font.Style := FontStyle;
  end;
end;

procedure TElMenuItem.DrawOfficeXPRightToLeft(Canvas: TCanvas; R: TRect;
    Selected, Dropped : boolean);
var
  AlphaImages, Images: TCustomImageList;
  ImgW, ImgH: integer;
  X, Y: integer;
  DrawImage: boolean;
  FontStyle: TFontStyles;
  Flags: cardinal;
  TR: TRect;
  Text: TLMDString;
  OrigImage, Image, Shadow: TBitmap;
  LRect : TRect;

begin
  Images := GetImages(Enabled, Selected);
  if (Images <> nil) and (Parent.ChildsHasImage) then
  begin
    ImgW := TCustomImageList(Images).Width;
    ImgH := TCustomImageList(Images).Height;
  end
  else
  if IsTopLevel then
  begin
    ImgW := 0;
    ImgH := 0;
  end
  else
  begin
    ImgW := 16;
    ImgH := 16;
  end;

  TR := R;
  if (GetParentMenu is TElMainMenu) and (not IsTopLevel) then
  begin
    // draw column background
    TR := R;

    if IsRightToLeft then
      TR.Left := TR.Right - ImgW - 8
    else
      TR.Right := TR.Left + ImgW + 8;

    Canvas.Brush.Color := LMDColorLighter(clBtnFace, 10);
    case (GetParentMenu as TElMainMenu).DrawStyle of
      tdsOffice2003: LMDGradientPaint(Canvas.Handle, TR, LMDColorLighter(clBtnFace, 2),
                       LMDColorDarker(clWindow, 2), 16, gstHorizontal, 0, 0);
      tdsOfficeXP: Canvas.FillRect(TR);
    end;
  end;

  if FCaption = cLineCaption then
  begin
    DrawOfficeXPSeparator(Canvas, ImgW, TR, R)
  end
  else
  begin
    if Selected then
    begin
      if Enabled then
      begin
        if Dropped then
        begin
          if GetDrawStyle = tdsOffice2003 then
            Canvas.Brush.Color := LMDColorLighter(clBtnFace, 50)
          else
            Canvas.Brush.Color := clBtnFace;
          Canvas.Pen.Color := LMDColorDarker(clBtnShadow, 80);
        end
        else
        begin
          Canvas.Brush.Color := LMDColorLighter(clHighlight, 70);
          Canvas.Pen.Color := clHighlight;
        end;
      end
      else
      begin
        Canvas.Brush.Color := LMDColorDarker(clWindow, 2);
        Canvas.Pen.Color := clHighlight;
      end;

      if Enabled then
      begin
        Canvas.FillRect(R);
      if not (Selected and Dropped) then
        Canvas.Rectangle(R)
      else
      if Vertical then
        Canvas.Polyline([Point(R.Right, R.Bottom - 1), Point(R.Left, R.Bottom - 1), Point(R.Left, R.Top), Point(R.Right, R.Top)])
      else
        Canvas.Polyline([Point(R.Left, R.Bottom), Point(R.Left, R.Top), Point(R.Right - 1, R.Top), Point(R.Right - 1, R.Bottom)])
      end
      else
      begin
        if (not IsTopLevel) then
        begin
          LRect := R;
          LRect.Left := LRect.Left + ImgW + 8;
          Canvas.FillRect(LRect);
        end;
      end;
    end
    else
      if (GetParentMenu is TElMainMenu) then
      begin
        if IsTopLevel then
          Canvas.Brush.Color := clBtnFace
        else
          Canvas.Brush.Color := LMDColorDarker(clWindow, 2);
        Canvas.FillRect(R);
        if (not IsTopLevel) then
        begin
          // draw column background
          TR := R;
          TR.Left := TR.Right - ImgW - 8;
          Canvas.Brush.Color := LMDColorLighter(clBtnFace, 10);
          case (GetParentMenu as TElMainMenu).DrawStyle of
            tdsOffice2003: LMDGradientPaint(Canvas.Handle, TR, LMDColorLighter(clBtnFace, 2),
                             LMDColorDarker(clWindow, 2), 16, gstHorizontal, 0, 0);
            tdsOfficeXP: Canvas.FillRect(TR);
          end;
        end;
      end;
    DrawImage := ((Images <> nil) and
                  (ImageIndex >= 0) and
                  (ImageIndex < Images.Count)) or
                 ((FBitmap <> nil) and not FBitmap.Empty) or Checked;
    X := R.Right - 3 - ImgW;
    Y := R.Top + (R.Bottom - R.Top - ImgH) div 2;
    if DrawImage then
    begin
      if Checked then
      begin
        if Enabled then
        begin
          if Selected then
          begin
            Canvas.Brush.Color := LMDColorLighter(clHighlight, 50);
            Canvas.Pen.Color := clHighlight;
          end
          else
          begin
            Canvas.Brush.Color := LMDColorLighter(clHighlight, 85);
            Canvas.Pen.Color := clHighlight;
          end;
        end
        else
        begin
          Canvas.Brush.Color := LMDColorDarker(clWindow, 2);
          Canvas.Pen.Color := clHighlight;
        end;
        Canvas.Rectangle(X - 2, Y - 2, X + ImgW + 2, Y + ImgH + 2);
      end;
      if (Images <> nil) and (ImageIndex >= 0) and (ImageIndex < Images.Count) then
      begin
        if Enabled or DisabledImagePresent then
        begin
          if Selected and not Checked then
          begin
            DrawGrayedImage(Images, ImageIndex, Canvas, X + 1, Y + 1);
            Images.Draw(Canvas, X - 1, Y - 1, ImageIndex);
          end
          else
          begin
            AlphaImages := GetAlphaImages(Enabled, Selected);
            if (AlphaImages <> nil) and (ImageIndex < AlphaImages.Count) then
              DrawAlphaMaskedImage(Canvas, X, Y, ImgW, ImgH, Images, AlphaImages)
            else
              Images.Draw(Canvas, X, Y, ImageIndex);
          end
        end
        else
          DrawGrayedImage(Images, ImageIndex, Canvas, X, Y,
            LMDColorLighter(clBtnShadow, 10));
      end
      else
      if ((FBitmap <> nil) and not FBitmap.Empty) or Checked then
      begin
        if (FBitmap = nil) or FBitmap.Empty then
        begin
          OrigImage := TBitmap.Create;
          OrigImage.Width := 16;
          OrigImage.Height := 16;
          if RadioItem then
            DrawFrameControl(OrigImage.Canvas.Handle, Rect(2, 0, 16, 16),
              DFC_MENU, DFCS_MENUBULLET)
          else
            DrawFrameControl(OrigImage.Canvas.Handle, Rect(3, 0, 16, 16),
              DFC_MENU, DFCS_MENUCHECK);
        end
        else
          OrigImage := FBitmap;
        Image := TBitmap.Create;
        try
          Image.PixelFormat := pf24bit;
          Image.Width := ImgW;
          Image.Height := ImgH;
          Image.Canvas.Brush.Color := OrigImage.Canvas.Pixels[0, OrigImage.Height
            - 1];
          Image.Canvas.FillRect(Rect(0, 0, ImgW, ImgH));
          if (OrigImage.Width <= ImgW) and (OrigImage.Height <= ImgH) then
          begin
            BitBlt(Image.Canvas.Handle, (ImgW - OrigImage.Width) div 2,
              (ImgH - OrigImage.Height) div 2, OrigImage.Width,
                OrigImage.Height,
              OrigImage.Canvas.Handle, 0, 0, SRCCOPY);
          end
          else
          begin
            BitBlt(Image.Canvas.Handle, 0, 0, ImgW, ImgH,
              OrigImage.Canvas.Handle,
              0, 0, SRCCOPY);
          end;
          if Enabled then
          begin
            if Selected and not Checked then
            begin
              Shadow := TBitmap.Create;
              Shadow.Assign(Image);
              MaskImage(Shadow, Shadow.Canvas.Pixels[0, ImgH - 1],
                LMDColorLighter(clBtnShadow, 10));
              LMDDrawTransparentBitmapEx(Canvas.Handle, Shadow, X + 1, Y + 1,
                Rect(0, 0, ImgW, ImgH), Shadow.Canvas.Pixels[0, ImgH - 1]);
              Shadow.Free;
              LMDDrawTransparentBitmapEx(Canvas.Handle, Image, X - 1, Y - 1,
                Rect(0, 0, ImgW, ImgH), Image.Canvas.Pixels[0, ImgH - 1]);
            end
            else
            begin
              LMDDrawTransparentBitmapEx(Canvas.Handle, Image, X, Y,
                Rect(0, 0, ImgW, ImgH), Image.Canvas.Pixels[0, ImgH - 1]);
            end;
          end
          else
          begin
            MaskImage(Image, Image.Canvas.Pixels[0, ImgH - 1],
              LMDColorLighter(clBtnShadow, 10));
            LMDDrawTransparentBitmapEx(Canvas.Handle, Image, X, Y,
              Rect(0, 0, ImgW, ImgH), Image.Canvas.Pixels[0, ImgH - 1]);
          end;
        finally
          Image.Free;
        end;
        if (FBitmap = nil) or FBitmap.Empty then
          OrigImage.Free;
      end;
    end;
    if ImgW > 0 then
    begin
      if not IsTopLevel then
        Dec(X, 11)
      else
        dec(X, 5);
    end;
    if IsTopLevel then
      Dec(X, 4);

    if Enabled then
      Canvas.Font.Color := clMenuText
    else
      Canvas.Font.Color := clBtnShadow;
    FontStyle := Canvas.Font.Style;
    if Default and not (fsBold in FontStyle) then
      Canvas.Font.Style := Canvas.Font.Style + [fsBold];
    Canvas.Brush.Color := clNone;
    if FCaption <> '' then
    begin
//      Flags := DT_LEFT or DT_SINGLELINE or DT_NOCLIP or DT_VCENTER or DT_EXPANDTABS;
      Flags := DT_RIGHT or DT_SINGLELINE or DT_NOCLIP or DT_VCENTER or DT_EXPANDTABS;
      TR := R;
      TR.Right := X;
      DoDrawText(Canvas, FCaption, TR, Selected, Flags);
    end;
    if not (GetParentMenu is TElMainMenu) then
    begin
      if Self.Count > 0 then
      begin
        TR := R;
        TR.Right := TR.Left + 20;
        if Enabled then
          LMDDrawArrow(Canvas, eadLeft, TR, Canvas.Font.Color, True)
        else
          LMDDrawArrow(Canvas, eadLeft, TR, clBtnShadow, True);
      end
    end;
    if (FShortCut <> 0) and (Self.Count = 0) then
    begin
      Text := ElShortCutToText(FShortCut);
      if Text <> '' then
      begin
        Flags := DT_LEFT or DT_SINGLELINE or DT_NOCLIP or DT_VCENTER or
          DT_NOPREFIX;
        TR := R;
        Inc(TR.Left, 20);
        DoDrawText(Canvas, Text, TR, Selected, Flags);
      end;
    end;
    Canvas.Font.Style := FontStyle;
  end;
end;

function TElMenuItem.DisabledImagePresent: Boolean;
var
  Menu: TMenu;
begin
  Result := false;
  if (FParent <> nil) and (FParent.SubMenuImages <> nil) then
  else
  begin
    Menu := GetParentMenu;
    if Menu is TElPopupMenu then
      result := TElPopupMenu(Menu).DisabledImages <> nil
    else
      result := TElMainMenu(Menu).DisabledImages <> nil;
  end;
end;

procedure TElMenuItem.IntMenuChanged(Rebuild: Boolean);
var
  Source: TElMenuItem;
begin
  if (Parent = nil) and ((Owner is TElMainMenu) or (Owner is TElPopupMenu)) then
    Source := nil
  else
    Source := Self;
  if Assigned(FOnIntChange) then FOnIntChange(Self, Source, Rebuild);
end;

procedure TElMenuItem.Click;
begin
  if Enabled then
  begin
    if  (
        not Assigned(ActionLink) and AutoCheck) or (Assigned(ActionLink) and
          not (ActionLink.IsAutoCheckLinked) and
        AutoCheck)
        then
      Checked := not Checked;
    { Call OnClick if assigned and not equal to associated action's OnExecute.
      If associated action's OnExecute assigned then call it, otherwise, call
      OnClick. }
    if Assigned(FOnClick) and (Action <> nil) and (@FOnClick <> @Action.OnExecute) then
      FOnClick(Self)
    else if not (csDesigning in ComponentState) and (ActionLink <> nil) then
      FActionLink.Execute(Self)
      else
    if Assigned(FOnClick) then
      FOnClick(Self);
  end;
end;

procedure TElMenuItem.CopyItemsFrom(AItem: TElMenuItem);
var
  LItem: TElMenuItem;
  i: Integer;
begin
  for i := 0 to AItem.GetCount - 1 do
  begin
    LItem := TElMenuItem.Create(AItem.Owner);
    LItem.Assign(AItem.Items[i]);
    if AItem.Items[i].GetCount > 0 then
      LItem.CopyItemsFrom(AItem.Items[i]);
    Add(LItem);
  end;
end;

procedure TElMenuItem.DrawOfficeXPSeparator(ACanvas: TCanvas; ImgW: Integer; TR: TRect; var R: TRect);
begin
  if IsTopLevel then
  begin
    ACanvas.Brush.Color := clMenu;
    ACanvas.FillRect(Rect(R.Left, R.Top, R.Right, R.Bottom + 1));
    ACanvas.Pen.Color := clBtnShadow;
    ACanvas.Pen.Color := LMDColorLighter(ACanvas.Pen.Color, 25);
    ACanvas.MoveTo(R.Left + (R.Right - R.Left) div 2, R.Top);
    ACanvas.LineTo(R.Left + (R.Right - R.Left) div 2, R.Bottom);
  end
  else
  begin
    if GetParentMenu is TElMainMenu then
    begin
      ACanvas.Brush.Color := LMDColorDarker(clWindow, 2);

      if IsRightToLeft then
      begin
        TR.Left := R.Right;
        // just save the value to restore it later
        R.Right := TR.Right - ImgW - 8;
        ACanvas.FillRect(R);
        R.Right := R.Right - 5;
      end
      else
      begin
        TR.Right := R.Left;
        // just save the value to restore it later
        R.Left := TR.Left + ImgW + 8;
        ACanvas.FillRect(R);
        R.Left := R.Left + 5;
      end;

      Inc(R.Top);
    end;
    ACanvas.Pen.Color := clBtnShadow;
    ACanvas.Pen.Color := LMDColorLighter(ACanvas.Pen.Color, 25);
    ACanvas.MoveTo(R.Left, R.Top);
    ACanvas.LineTo(R.Right, R.Top);
    if GetParentMenu is TElMainMenu then
    begin
      Dec(R.Top);
      if IsRightToLeft then
        R.Right := TR.Left
      else
        R.Left := TR.Right;
    end;
  end;
end;

procedure TElMenuItem.DrawAlphaMaskedImage(Canvas:TCanvas; X, Y, W, H: integer; Images, AlphaImages: TCustomImageList);
var
  BMP, BmpAm: TBitmap;
begin
  BMP := TBitmap.Create;
  BMP.Width := Images.Width;
  Bmp.Height := Images.Height;
  ImageList_DrawEx(Images.Handle, ImageIndex, BMP.Canvas.Handle, 0, 0, 0, 0, clNone, clNone, ILD_Normal);
  BmpAm := TBitmap.Create;
  BmpAm.Width := AlphaImages.Width;
  BmpAm.Height := AlphaImages.Height;
  BmpAm.PixelFormat := pf32bit;
  ImageList_DrawEx(AlphaImages.Handle, ImageIndex, BmpAm.Canvas.Handle, 0, 0, 0, 0, clNone, clNone, ILD_Normal);
  LMDAlphaCopyRect2(Canvas.Handle, Rect(X, Y, W + X, H + Y), BMP.Canvas.Handle, Rect(0, 0, BMP.Width, BMP.Height), BmpAm, 255);
  BmpAm.Free;
  BMP.Free;
end;

function TElMenuItem.ChildsHasImage: Boolean;
var
  i: integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
    Result := Result or (Items[I].FImageIndex > -1);
end;

function TElMenuItem.IsVistaSelNeed(Selected: Boolean): Boolean;
begin
  Result := Selected and
    (
      (IsTopLevel and not (GetParentMenu is TElMainMenu))
       or
       not (LMDSIWindowsVistaUp and LMDThemeServices.ThemesEnabled(UseThemeMode))
    ) or
    (
      (GetParentMenu is TElMainMenu) and
      (TElMainMenu(GetParentMenu).DrawStyle = tdsWindowsXP) and
      Selected
    );
end;

{ TElMainMenu }
constructor TElMainMenu.Create(AOwner: TComponent);
begin
  FUnicodeItems := TElMenuItem.Create(Self);

  FUnicodeItems.FMenu := Self;
  inherited Create(AOwner);
  FThemeMode := ttmPlatform;
  FUnicodeItems.FOnChange := IntMenuChanged;
  FHook := TElHook.Create(nil);
  FForm := LMDGetOwnerForm(Self);
  FFont := TFont.Create;
  FFont.OnChange := FontChange;
  FSelectedItemFont := TFont.Create;
  FSelectedItemFont.OnChange := FontChange;
  GetFont;
  FSystemFont := true;

  FItemSpace := 4;
  FImageMargin := 6;
  THackClass(Self).FItems.Free;
  THackClass(Self).FItems := FUnicodeItems;
  THackClass(Self).FBiDiMode := BiDiMode;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FAImageChangeLink := TChangeLink.Create;
  FAImageChangeLink.OnChange := ImageListChange;

  FHotImageChangeLink := TChangeLink.Create;
  FHotImageChangeLink.OnChange := ImageListChange;
  FAHotImageChangeLink := TChangeLink.Create;
  FAHotImageChangeLink.OnChange := ImageListChange;

  FDisabledImageChangeLink := TChangeLink.Create;
  FDisabledImageChangeLink.OnChange := ImageListChange;
  FADisabledImageChangeLink := TChangeLink.Create;
  FADisabledImageChangeLink.OnChange := ImageListChange;

  with FHook do
  begin
    Control := FForm;
    Active := true;
    DesignActive := true;
    OnBeforeProcess := OnBeforeHook;
    OnAfterProcess := OnAfterHook;
  end;
end;

destructor TElMainMenu.Destroy;
begin
  FHook.Control := nil;
//  FUnicodeItems.Free;
  FImageChangeLink.Free;
  FAImageChangeLink.Free;
  FHotImageChangeLink.Free;
  FAHotImageChangeLink.Free;
  FDisabledImageChangeLink.Free;
  FADisabledImageChangeLink.Free;
  FFont.Free;
  FSelectedItemFont.Free;
  FHook.Free;
  if IsHTML then
    FRender.Free;
  FRender := nil;
  inherited;
end;

function TElMainMenu.getLMDPackage:TLMDPackageID;
begin
  result:=pi_LMD_ELCORE;
end;

procedure TElMainMenu.UpdateItems;
{$ifdef lmdx86}
  function UpdateItem(MenuItem: TElMenuItem): Boolean;
  begin
    Result := False;
    IterateMenus(@UpdateItem, MenuItem.FMerged, MenuItem);
    MenuItem.SubItemChanged(MenuItem, MenuItem, True);
  end;
begin
  IterateMenus(@UpdateItem, Items.FMerged, Items);
{$else}
begin
  TElMenuUpdater.DoIterateMenus(Items.Merged, Items);
{$endif}
end;

procedure TElMainMenu.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  UpdateItems;
  if WindowHandle <> 0 then
  begin
    Windows.SetMenu(WindowHandle, 0);
    Windows.SetMenu(WindowHandle, Handle);
  end;
end;

procedure TElMainMenu.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = Images) and (Operation = opRemove) then Images := nil;
  if (AComponent = AlphaForImages) and (Operation = opRemove) then
    AlphaForImages := nil;
  if (AComponent = DisabledImages) and (Operation = opRemove) then
    DisabledImages := nil;
  if (AComponent = AlphaForDisabledImages) and (Operation = opRemove) then
    AlphaForDisabledImages := nil;
  if (AComponent = HotImages) and (Operation = opRemove) then HotImages := nil;
  if (AComponent = AlphaForHotImages) and (Operation = opRemove) then
    AlphaForHotImages := nil;
end;

procedure TElMainMenu.ImageListChange(Sender: TObject);
begin
  if Sender = Images then
  begin
    // UpdateItems;
    FUnicodeItems.RebuildHandle;
    (*
    if WindowHandle <> 0 then
    begin
      Windows.SetMenu(WindowHandle, 0);
      Windows.SetMenu(WindowHandle, Handle);
    end;
    //*)
  end;
end;

procedure TElMainMenu.SetOwnerDraw(Value: Boolean);
begin
  if FOwnerDraw <> Value then
  begin
    FOwnerDraw := Value;
    UpdateItems;
    if (Owner <> nil) and (Owner is TWinControl) and (not (csDestroying in ComponentState)) then
    begin
      Items.IntMenuChanged(True);
      DrawMenuBar(TWinControl(Owner).Handle);
    end;
  end;
end;

procedure TElMainMenu.SetImages(Value: TCustomImageList);
begin
  if FImages <> nil then FImages.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if FImages <> nil then
  begin
    FImages.RegisterChanges(FImageChangeLink);
    FImages.FreeNotification(Self);
  end;
  if Images <> nil then
    ImageListChange(Images)
  else
    UpdateItems;
  Items.MenuChanged(False);
  Items.IntMenuChanged(False);
  if (Owner <> nil) and (Owner is TWinControl) and (not (csDestroying in ComponentState)) then
    DrawMenuBar(TWinControl(Owner).Handle);
end;

procedure TElMainMenu.SetAlphaImages(Value: TCustomImageList);
begin
  if FAlphaImages <> nil then
  begin
    FAlphaImages.UnRegisterChanges(FAImageChangeLink);
    //FImages.RemoveFreeNotification(Self);
  end;
  FAlphaImages := Value;
  if FAlphaImages <> nil then
  begin
    FAlphaImages.RegisterChanges(FAImageChangeLink);
    FAlphaImages.FreeNotification(Self);
  end;
  if AlphaForImages <> nil then
    ImageListChange(AlphaForImages)
  else
    UpdateItems;
  Items.MenuChanged(False);
  Items.IntMenuChanged(False);
  if (Owner <> nil) and (Owner is TWinControl) and (not (csDestroying in ComponentState)) then
    DrawMenuBar(TWinControl(Owner).Handle);
end;

procedure TElMainMenu.SetDrawStyle(Value: TDrawStyle);
begin
  if FDrawStyle <> Value then
  begin
    FDrawStyle := Value;
    OwnerDraw := true;
    Items.MenuChanged(False);
    Items.IntMenuChanged(False);
    Items.DesignRebuild;
    if (Owner <> nil) and (Owner is TWinControl) and (not (csDestroying in ComponentState)) then
      DrawMenuBar(TWinControl(Owner).Handle);
  end;
end;

function TElMainMenu.GetHandle: HMENU;
begin
  if FOle2Menu <> 0 then
    Result := FOle2Menu
  else
  begin
    Result := Items.GetHandle;
  end;
end;

function TElMainMenu.IsThemed: boolean;
begin
  Result := (FThemeMode <> ttmNone); // and LMDThemeServices.ThemesEnabled(FThemeMode);
end;

procedure TElMainMenu.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
  begin
    FThemeGlobalMode := Value;
    DoThemeChanged;
  end;
end;

procedure TElMainMenu.SetThemeMode(const Value: TLMDThemeMode);
begin
  if Value <> FThemeMode then
  begin
    FThemeMode:= Value;
    DoThemeChanged;
  end;
end;

procedure TElMainMenu.SetUseFontColor(const Value: boolean);
begin
  if FUseFontColor <> Value then
  begin
    FUseFontColor := Value;
    UpdateItems;
  end;
end;

procedure TElMainMenu.DoThemeChanged;
begin
// nothing to do
end;

function TElMainMenu.UseThemeMode: TLMDThemeMode;
begin
  if FThemeGlobalMode then
    result := LMDApplication.ThemeGlobalMode
  else
    result := FThemeMode;
  result := LMDThemeServices.UseTheme(result);
end;

function TElMainMenu.IsOwnerDraw: Boolean;
begin
  Result := true; //OwnerDraw or (Images <> nil) or (DrawStyle <> tdsNormal);
end;

procedure TElMainMenu.ProcessMenuChar(var Message: TWMMenuChar);
var
  C, I, First, Hilite, Next: Integer;
  State: Word;

  function IsAccelChar(Menu: HMENU; State: Word; I: Integer; C: Char): Boolean;
  var
    Item: TElMenuItem;
    Id: UINT;
  begin
    Item := nil;
    if State and MF_POPUP <> 0 then
    begin
      Menu := GetSubMenu(Menu, I);
      Item := FindItem(Menu, fkHandle);
    end
    else
    begin
      Id := GetMenuItemID(Menu, I);
      if Id <> $FFFFFFFF then
        Item := FindItem(Id, fkCommand);
    end;
    if Item <> nil then
      Result := IsAccel(Ord(C), Item.Caption)
    else
      Result := False;
  end;

  function IsInitialChar(Menu: HMENU; State: Word; I: Integer; C: Char):
    Boolean;
  var
    Item: TElMenuItem;
  begin
    if State and MF_POPUP <> 0 then
    begin
      Menu := GetSubMenu(Menu, I);
      Item := FindItem(Menu, fkHandle);
    end
    else
    begin
      Item := FindItem(Menu, fkHandle);
      if (Item <> nil) and (I < Item.Count) then
        Item := Item.Items[I];
    end;
    // First char is a valid accelerator only if the caption does not
    // contain an explicit accelerator
    if (Item <> nil) and (Item.Caption <> '') then
      Result := (AnsiCompareText(Item.Caption[1], C) = 0) and
        (ElGetHotkey(Item.Caption) = '')
    else
      Result := False;
  end;

begin
  with Message do
  begin
    Result := MNC_IGNORE; { No item found: beep }
    First := -1;
    Hilite := -1;
    Next := -1;
    C := GetMenuItemCount(Menu);
    for I := 0 to C - 1 do
    begin
      State := GetMenuState(Menu, I, MF_BYPOSITION);
      if IsAccelChar(Menu, State, I, User) then
      begin
        if State and MF_DISABLED <> 0 then
        begin
          { Close the menu if this is the only disabled item to choose from.
            Otherwise, ignore the item. }
          if First < 0 then First := -2;
          Continue;
        end;
        if First < 0 then
        begin
          First := I;
          Result := MNC_EXECUTE;
        end
        else
          Result := MNC_SELECT;
        if State and MF_HILITE <> 0 then
          Hilite := I
        else
          if Hilite >= 0 then
          Next := I;
      end;
    end;
    { We found a single disabled item. End the selection. }
    if First < -1 then
    begin
      Result := MNC_CLOSE shl 16;
      Exit;
    end;

    { If we can't find accelerators, then look for initial letters }
    if First < 0 then
      for I := 0 to C - 1 do
      begin
        State := GetMenuState(Menu, I, MF_BYPOSITION);
        if IsInitialChar(Menu, State, I, User) then
        begin
          if State and MF_DISABLED <> 0 then
          begin
            Result := MNC_CLOSE shl 16;
            Exit;
          end;
          if First < 0 then
          begin
            First := I;
            Result := MNC_EXECUTE;
          end
          else
            Result := MNC_SELECT;
          if State and MF_HILITE <> 0 then
            Hilite := I
          else
            if Hilite >= 0 then
            Next := I;
        end;
      end;

    if (Result = MNC_EXECUTE) then
      Result := Result shl 16 or First
    else
      if Result = MNC_SELECT then
    begin
      if Next < 0 then
        Next := First;
      Result := Result shl 16 or Next;
    end;
  end;
end;

{$ifdef LMDX64}
type
  TElMenuFinder = class
    Value: TLMDPtrUInt;
    Kind: TFindItemKind;
    FoundItem: TElMenuItem;
    function Find(Item: TElMenuItem): Boolean;
  end;

function TElMenuFinder.Find(Item: TElMenuItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  if ((Kind = fkCommand) and (Value = Item.Command)) or
    ((Kind = fkHandle) and (Value = Item.Handle)) or
    ((Kind = fkShortCut) and (Value = Item.ShortCut)) then
  begin
    FoundItem := Item;
    Result := True;
    Exit;
  end
  else
    for I := 0 to Item.Count - 1 do
      if Find(Item[I]) then
      begin
        Result := True;
        Exit;
      end;
end;

function TElMainMenu.FindItem(Value: TLMDPtrUInt; Kind: TFindItemKind): TElMenuItem;
var
  LFinder: TElMenuFinder;
begin
  LFinder := TElMenuFinder.Create;
  try
    LFinder.Value := Value;
    LFinder.Kind := Kind;
    IterateMenus(LFinder.Find, Items.Merged, Items);
    Result := LFinder.FoundItem;
  finally
    LFinder.Free;
  end;
end;
{$else}
function TElMainMenu.FindItem(Value: TLMDPtrUInt; Kind: TFindItemKind): TElMenuItem;
var
  FoundItem: TElMenuItem;

  function Find(Item: TElMenuItem): Boolean;
  var
    I: Integer;
    Shift: TShiftState;
    Key: word;
  begin
    Result := False;
    if Kind = fkShortcut then
      ShortcutToKey(Value, Key, Shift);
    if ((Kind = fkCommand) and (Value = Item.Command)) or
      ((Kind = fkHandle) and (Value = Item.FHandle)) or
      ((Kind = fkShortCut) and (Value = Item.ShortCut) and Item.ProcessShortCut) then
    begin
      FoundItem := Item;
      Result := True;
      Exit;
    end
    else
      for I := 0 to Item.GetCount - 1 do
        if Find(Item[I]) then
        begin
          Result := True;
          Exit;
        end;
  end;

begin
  FoundItem := nil;
  IterateMenus(@Find, Items.FMerged, Items);
  Result := FoundItem;
end;
{$endif}

function TElMainMenu.IsShortCut(var Message: TWMKey): Boolean;
type
  TClickResult = (crDisabled, crClicked, crShortCutMoved);
const
  AltMask = $20000000;
var
  ShortCut: TShortCut;
  ShortCutItem: TElMenuItem;
  ClickResult: TClickResult;

  function DoClick(Item: TElMenuItem): TClickResult;
  begin
    Result := crClicked;
    if Item.Parent <> nil then
      Result := DoClick(Item.Parent);
    if Result = crClicked then
      if Item.Enabled then
      try

        if not (csDesigning in ComponentState) then Item.InitiateActions;

        Item.Click;
        //PostMessage(Tracker.FTrackerWnd, EL_MENUCLICK, TLMDPtrInt(Item), 0);

        if (Item <> ShortCutItem) and (ShortCutItem.ShortCut <> ShortCut) then
          Result := crShortCutMoved;
      except
        Application.HandleException(Self);
      end
      else
        Result := crDisabled;
  end;

begin
  ShortCut := Byte(Message.CharCode);
  if GetKeyState(VK_SHIFT) < 0 then Inc(ShortCut, scShift);
  if GetKeyState(VK_CONTROL) < 0 then Inc(ShortCut, scCtrl);
  if GetKeyState(VK_MENU) < 0 then
//  if Message.KeyData and AltMask <> 0 then
    Inc(ShortCut, scAlt);
  repeat
    ClickResult := crDisabled;
    ShortCutItem := FindItem(ShortCut, fkShortCut);
    if ShortCutItem <> nil then
      if ShortCutItem.ProcessShortCut then
        ClickResult := DoClick(ShortCutItem)
      else
      begin
        ShortCutItem := nil;
        break;
      end;
  until ClickResult <> crShortCutMoved;
  Result := ShortCutItem <> nil;
end;

{$IFDEF LMD_UNICODE}
function TElMainMenu.DoGetMenuString(Menu: HMENU; ItemID: UINT; Str: PWideChar;
  MaxCount: Integer; Flag: UINT): Integer;
{$ELSE}
function TElMainMenu.DoGetMenuString(Menu: HMENU; ItemID: UINT; Str: PChar;
  MaxCount: Integer; Flag: UINT): Integer;
{$ENDIF}

var
  Item: TElMenuItem;
  State: Word;
  begin
  if IsOwnerDraw then
  begin
    Item := nil;
    State := GetMenuState(Menu, ItemID, Flag);
    if State and MF_POPUP <> 0 then
    begin
      Menu := GetSubMenu(Menu, ItemID);
      Item := TElMenuItem(FindItem(Menu, fkHandle));
    end
    else
    begin
      ItemID := GetMenuItemID(Menu, ItemID);
      if ItemID <> $FFFFFFFF then
        Item := TElMenuItem(FindItem(ItemID, fkCommand));
    end;
    if Item <> nil then
    begin
      Str[0] := #0;
      {$IFDEF LMD_UNICODE}
      LMDWideStrPCopy(Str, Copy(Item.Caption, 1, MaxCount));
      {$ELSE}
      StrPLCopy(Str, Item.Caption, MaxCount);
{$ENDIF}
      Result := Length(Str);
    end
    else
      Result := 0;
  end
  else
{$IFDEF LMD_UNICODE}
    Result := GetMenuStringW(Menu, ItemID, Str, MaxCount, Flag);
{$ELSE}
    Result := GetMenuStringA(Menu, ItemID, Str, MaxCount, Flag);
{$ENDIF}
end;

function TElMainMenu.UpdateImage: Boolean;
var
{$IFDEF LMD_UNICODE}
  Image: array[0..511] of WideChar;
{$ELSE}
  Image: array[0..511] of Char;
{$ENDIF}

  procedure BuildImage(Menu: HMENU);
  var
  {$IFDEF LMD_UNICODE}
    P: PWideChar;
    ImageEnd: PWideChar;
    {$ELSE}
    P: PChar;
    ImageEnd: PChar;
    {$ENDIF}
    I, C: Integer;
    State: Word;
  begin
    C := GetMenuItemCount(Menu);
    P := Image;

    ImageEnd := @Image[(SizeOf(Image) div 2) - 5];
    I := 0;
    while (I < C) and (P < ImageEnd) do
    begin
      DoGetMenuString(Menu, I, P, ImageEnd - P, MF_BYPOSITION);
      {$IFDEF LMD_UNICODE}
      P := LMDWideStrEnd(P);
      {$ELSE}
      P := StrEnd(P);
{$ENDIF}
      State := GetMenuState(Menu, I, MF_BYPOSITION);
{$IFDEF LMD_UNICODE}
      if State and MF_DISABLED <> 0 then P := LMDWideStrECopy(P, '$');
      if State and MF_MENUBREAK <> 0 then P := LMDWideStrECopy(P, '@');
      if State and MF_GRAYED <> 0 then P := LMDWideStrECopy(P, '#');
      P := LMDWideStrECopy(P, ';');
      {$ELSE}
      if State and MF_DISABLED <> 0 then P := StrECopy(P, '$');
      if State and MF_MENUBREAK <> 0 then P := StrECopy(P, '@');
      if State and MF_GRAYED <> 0 then P := StrECopy(P, '#');
      P := StrECopy(P, ';');
{$ENDIF}
      Inc(I);
    end;
  end;

begin
  Result := False;
  Image[0] := #0;
  if WindowHandle <> 0 then BuildImage(Handle);
{$IFDEF LMD_UNICODE}
  if (FMenuImage = '') or (LMDWideStrComp(PWideChar(FMenuImage), Image) <> 0) then
  {$ELSE}
  if (FMenuImage = '') or (StrComp(PChar(FMenuImage), Image) <> 0) then
{$ENDIF}
  begin
    Result := True;
    FMenuImage := Image;
  end;
end;

//vAd:

procedure TElMainMenu.BeginUpdate;
begin
  inc(FUpdateCount);
end;

procedure TElMainMenu.EndUpdate;
begin
  if FUpdateCount > 0 then
    dec(FUpdateCount);

  if (WindowHandle <> 0) then
  begin
    SendMessage(WindowHandle, CM_MENUCHANGED, 0, 0);
    DrawMenuBar(WindowHandle);
  end;
end;

function TElMainMenu.isUpdated: Boolean;
begin
  Result := (FUpdateCount > 0) or
//              (csLoading in ComponentState) or // почему то не происходит очистка этого флага
  (csReading in ComponentState) or // зато этот флаг очищается
    (csDestroying in ComponentState);
end;

procedure TElMainMenu.LoadItemsFromFiles(const ItemsFileName: array of TLMDString);
begin
  ElLoadItemsFromFiles(Self, ItemsFileName);
end;

procedure ElLoadItemsFromFiles(Menu: TMenu; const ItemsFileName: array of TLMDString);
var
  S: TStream;
  Temp: TElMenuItem;
  i: Integer;
  Form: TCustomForm;

  procedure AddMenuItem(Parent: TElMenuItem; Item: TElMenuItem);
  var
    i: integer;
    Temp, FElMenuItem: TElMenuItem;
    FElName: string;
  begin
    FElMenuItem := TElMenuItem.Create(Menu); //ADesigner.GetRoot);
    with FElMenuItem do
    begin
      Caption := Item.Caption;
      Name := FElName;
      ShortCut := Item.ShortCut;
      Hint := Item.Hint;
      Enabled := Item.Enabled;
      Default := Item.Default;
      Checked := Item.Checked;
      RadioItem := Item.RadioItem;
      ImageIndex := Item.ImageIndex;
      Break := Item.Break;
      FElMenuItem.Visible := Item.Visible;
      //vAd: ???: OnChange := MenuChanged;
    end;

    if ((Parent = nil) or (Parent.Parent <> nil)) then
    begin
      InsertMenuItems(Menu, Item.MenuIndex, FElMenuItem);
      Temp := FElMenuItem;
    end
    else
    begin
      InsertItems(Menu, Parent, Item.MenuIndex, FElMenuItem);
      Temp := TElMenuItem(Parent);
    end;

    while Temp.Parent <> nil do
      Temp := TElMenuItem(Temp.Parent);
    Temp.DesignRebuild;

    if Item.Count > 0 then
      for i := 0 to Item.Count - 1 do
        AddMenuItem(FElMenuItem, TElMenuItem(TElMenuItem(Item).Items[i]));
  end;

begin
  if not
    (
    Assigned(Menu) and (Length(ItemsFileName) > 0)
    and
    ((Menu is TElMainMenu) or (Menu is TElPopupMenu))
    ) then exit;

  if (Menu is TElMainMenu) then
    TElMainMenu(Menu).BeginUpdate;

  try

    for i := 0 to Length(ItemsFileName) - 1 do
    begin
      S := TLMDFileStream.Create(ItemsFileName[i], fmOpenRead);
      try
        Temp := TElMenuITem(S.ReadComponent(nil));
        if (Menu is TElPopupMenu) then
          AddMenuItem(TElPopupMenu(Menu).Items, Temp)
        else
          AddMenuItem(TElMainMenu(Menu).Items, Temp);
      finally
        S.Free;
      end;
    end;

  finally
    if (Menu is TElMainMenu) then
      TElMainMenu(Menu).EndUpdate
    else
    begin
      Form := LMDGetOwnerForm(Menu);
      if (Form <> nil) and not (csDestroying in Form.ComponentState) then
        DrawMenuBar(Form.Handle);
    end;
  end;
end;

procedure TElMainMenu.ItemChanged;
begin
  //vAd:
  if isUpdated then
    exit;

  MenuChanged(nil, nil, false);
  if WindowHandle <> 0 then
  begin
    SendMessage(WindowHandle, CM_MENUCHANGED, 0, 0);
    //DrawMenuBar(WindowHandle);
    //MessageBeep(0);
  end;
end;

function TElMainMenu.DispatchCommand(ACommand: Word): Boolean;
var
  Item: TElMenuItem;
begin
  Result := False;
  Item := FindItem(ACommand, fkCommand);
  if Item <> nil then
  begin
    //PostMessage(FTracker.FTrackerWnd, EL_MENUCLICK, TLMDPtrInt(Item), 0);
    Item.Click;
    Result := True;
  end;
end;

procedure TElMainMenu.OnAfterHook(Sender: TObject; var Message: TMessage;
  var Handled: boolean);
begin
  Handled := false;
  if Message.Msg in [WM_KILLFOCUS, WM_SETFOCUS, WM_ACTIVATE] then
  begin
    DrawMenuBar(WindowHandle);
  end;
end;

procedure TElMainMenu.OnBeforeHook(Sender: TObject; var Message: TMessage;
  var Handled: boolean);
var
  MenuItem: TElMenuItem; //GTP2
  Canvas: TCanvas;
  DC: HDC;
  TopLevel: boolean;
  Selected: boolean;
  Bmp: TBitmap;
  R: TRect;
  SaveIndex: integer;
  ID: Integer;
  FindKind: TFindItemKind;
  Details: TThemedElementDetails;
{$IFDEF LMD_UNICODE}
  WS: WideString;
  S: string;
  i: integer;
  l: integer;
  T: WideChar;
  {$ENDIF}
{$IFDEF LMD_DEBUGMESSAGES}
const
  c_array_filter: array[0..15] of integer =
  (WM_NCHITTEST, WM_SETCURSOR, WM_MOUSEMOVE, LB_GETTOPINDEX, CM_MOUSEENTER,
    WM_NCMOUSEMOVE, CM_MOUSELEAVE, WM_NCMOUSELEAVE, CM_DIALOGKEY, CM_DIALOGCHAR,
    WM_ERASEBKGND, WM_PAINT, WM_CAPTURECHANGED, WM_MOUSEACTIVATE,
      CM_INVALIDATE);

  function not_in_filter(msg: integer): boolean;
  var
    i: integer;
  begin
    for i := 0 to High(c_array_filter) do
      if c_array_filter[i] = msg then
      begin
        Result := False;
        exit;
      end;
    Result := True;
  end;

{$ENDIF IFDEF LMD_DEBUGMESSAGES}

begin
  Handled := false;
  Details.Element := teMenu;
  Details.Part := MENU_POPUPITEM;
  Details.State := MPI_HOT;
  if (FForm = nil) or (FForm.Menu <> Self) then
    exit;

{$IFDEF LMD_DEBUGMESSAGES}
  if (bMonitorMessage) then
  // and not_in_filter(Message.Msg)
  begin
    if TLMDPtrUInt(Message.Msg) <> WM_ELSCROLLBAR then
      LMDDebug(
        LMDMessageToStr(Message.Msg) +
        ', wParam=' + IntToStr(Message.wParam) +
        ', lParam=' + IntToStr(Message.lParam)
        )
    else
      if Message.WParam = ELSB_PAINT then
    begin
      {case Message.LParam of
        SB_HORZ : LMDDebug( 'WM_ELSCROLLBAR [ ELSB_PAINT, SB_HORZ ]' );
        SB_VERT : LMDDebug( 'WM_ELSCROLLBAR [ ELSB_PAINT, SB_VERT ]' );
        else      LMDDebug( 'WM_ELSCROLLBAR [ ELSB_PAINT, SB_BOTH ]' );
      end;{}
    end;
  end;
{$ENDIF IFDEF LMD_DEBUGMESSAGES}

  with Message do
  begin
    case Msg of
      WM_HELP: //GTP2
        begin
          with PHelpInfo(Message.LParam)^ do
          begin
            MenuItem := FindItem(iCtrlID, fkCommand);

            if MenuItem <> nil then
            begin
              if MenuItem.HelpContext <> 0 then
              begin
                Application.HelpContext(MenuItem.HelpContext);
                Handled := true;
              end;
            end;
          end;
        end; //GTP2
      WM_SETTINGCHANGE:
        begin
          if SystemFont then
          begin
            GetFont;
            SendMessage(WindowHandle, CM_MENUCHANGED, 0, 0);
          end;
          DrawMenuBar(WindowHandle);
          UpdateItems;
        end;
      WM_MENUCHAR:
        begin
          ProcessMenuChar(TWMMenuChar(Message));
          if TWMMenuChar(Message).Result <> MNC_IGNORE then
          Handled := true;
        end;

      WM_MENUSELECT:
        begin
          MenuItem := nil;
          if (TWMMenuSelect(Message).MenuFlag <> $FFFF) or
            (TWMMenuSelect(Message).IDItem <> 0) then
          begin
            FindKind := fkCommand;
            ID := TWMMenuSelect(Message).IDItem;
            if TWMMenuSelect(Message).MenuFlag and MF_POPUP <> 0 then
            begin
              FindKind := fkHandle;
              ID := GetSubMenu(TWMMenuSelect(Message).Menu, ID);
            end;
            MenuItem := FindItem(ID, FindKind);
          end;
{$IFDEF LMD_UNICODE}
          if MenuItem <> nil then
          begin
            S := MenuItem.Hint;
            WS := MenuItem.Hint;
            i := Length(S);
            l := Length(S) + 1 + Length(WS) * 2;
            SetLength(S, l + 4);
            S[i + 1] := #0;
            Move(WS[1], S[i + 2], Length(WS) * 2);
            T := #0;
            Move(T, S[l + 1], sizeof(T));
            T := #$FFFE;
            Move(T, S[l + 3], sizeof(T));
            Application.Hint := S;
            Handled := true;
          end
          else
            Application.Hint := '';
{$ELSE}
          if MenuItem <> nil then
            Application.Hint := GetLongHint(MenuItem.Hint)
          else
            Application.Hint := '';
{$ENDIF}
        end;

      WM_COMMAND:
        DispatchCommand(WParam);
      WM_KEYDOWN:
        IsShortCut(TWMKey(Message));
        WM_ENTERMENULOOP:
        Handled := false;
      WM_INITMENUPOPUP:
        DispatchPopup(WParam);
      WM_DRAWITEM:
        with PDrawItemStruct(LParam)^ do
        if (CtlType = ODT_MENU) then
          begin
            MenuItem := FindItem(itemID, fkCommand);
            MenuItem.FCurrentForm := LMDGetOwnerForm(Self);
            if MenuItem <> nil then
            begin
              //vAd:
              MenuItem.FState := TOwnerDrawState(LongRec(itemState).Lo);
              if isUpdated then
              begin
                Handled := true;
                Exit;
              end;
              Bmp := TBitmap.Create;
              try
                Bmp.Handle := CreateCompatibleBitmap(hDC, rcItem.Right -
                  rcItem.Left, rcItem.Bottom - rcItem.Top);
                R := rcItem;
                OffsetRect(R, -R.Left, -R.Top);

                Canvas := Bmp.Canvas; //TControlCanvas.Create;
                TopLevel := MenuItem.GetParentComponent is TElMainMenu;

                with Canvas do
                begin
                    // Handle := hDC;
                  if Assigned(Self.Font) then
                    Canvas.Font.Assign(Self.Font)
                  else
                    Canvas.Font.Handle := GetMenuFont;
                  case DrawStyle of
                    tdsNormal:
                      begin
                        Brush.Style := bsSolid;
                        if itemState and ODS_SELECTED <> 0 then
                        begin
                          if (LMDSIWindows98 or LMDSIWindows2000Up) and TopLevel and ((not
                            LMDSIWindowsXPUp) or (not IsAppThemed)) then
                          begin
                            Brush.Color := clBtnFace;
                            Canvas.FillRect(R);
                            Brush.Style := bsClear;
                            if WindowActive or ((not LMDSIWindowsXPUp) or (not UseThemes)) then
                              Font.Color := clBtnText
                            else
                              Font.Color := clBtnShadow;
                          end
                          else
                          begin
                            Brush.Color := clHighlight;
                            Font.Color := clHighlightText;
                          end;
                        end
                        else
                        begin
                          if ((LMDSIWindowsXPUp) and (TopLevel)) then
                            Brush.Color := clBtnFace
                          else
                            Brush.Color := clMenu;
                          if ((itemState and ODS_INACTIVE) = ODS_INACTIVE) or
                            ((not LMDSIWindowsXPUp) or (not UseThemes)) then
                            Font.Color := clMenuText
                          else
                            Font.Color := clBtnShadow;
                        end;
                        if itemState and ODS_HOTLIGHT <> 0 then
                        begin
                          if (LMDSIWindows98 or LMDSIWindows2000Up) and TopLevel and ((not
                            LMDSIWindowsXPUp) or (not UseThemes)) then
                          begin
                            Brush.Color := clBtnFace;
                            Canvas.FillRect(R);
                            //if MenuItem.Enabled then
                            //  DrawButtonFrameEx(Canvas.Handle, R{rcItem}, false, false, clBtnFace, true); //GTP3c
                            Brush.Style := bsClear;
                          end
                          else
                          begin
                            Brush.Color := clHighlight;
                            Font.Color := clHighlightText
                          end;
                        end;
                      end;
                    tdsOfficeXP, tdsOffice2003:
                      begin
                        if (itemState and ODS_SELECTED <> 0) and
                          (MenuItem.Enabled) then
                        begin
                          if TopLevel then
                          begin
                            Brush.Color := LMDColorLighter(clBtnFace, 10);
                            Font.Color := clMenuText;
                            Pen.Color := LMDColorDarker(clBtnFace, 200);
                          end
                          else
                          begin
                            Brush.Color := LMDColorLighter(clHighlight, 70);
                            Font.Color := clMenuText;
                            Pen.Color := clHighlight;
                          end
                        end
                        else
                        begin
                          if (TopLevel) then
                          begin
                            Brush.Color := clBtnFace;
                            Pen.Color := clBtnFace;
                          end
                          else
                          begin
                            Brush.Color := LMDColorLighter(clBtnFace, 80);
                            Pen.Color := LMDColorLighter(clBtnFace, 80);
                          end;
                          Font.Color := clMenuText;
                        end;
                        if itemState and ODS_HOTLIGHT <> 0 then
                        begin
                          Brush.Color := LMDColorLighter(clHighlight, 70);
                          Font.Color := clMenuText;
                          Pen.Color := clhighLight;
                        end;
                      end;
                    tdsWindowsXP:
                      begin
                        if itemState and ODS_SELECTED <> 0 then
                        begin
                          Brush.Color := clHighlight;
                          Font.Color := clHighlightText
                        end
                        else
                        begin
                          if (TopLevel) then
                            Brush.Color := clBtnFace //clMenu //GTP3d
                          else
                            Brush.Color := clWindow;

                          if ((itemState and ODS_INACTIVE) = ODS_INACTIVE) or
                            ((not LMDSIWindowsXPUp) or (not UseThemes)) then
                            Font.Color := clMenuText
                          else
                            Font.Color := clBtnShadow;
                        end;
                        if itemState and ODS_HOTLIGHT <> 0 then
                        begin
                          Brush.Color := clHighlight;
                          Font.Color := clHighlightText
                        end;
                      end;
                  end;
                  Selected := (itemState and ODS_SELECTED <> 0) or (itemstate and ODS_HOTLIGHT <> 0);
                  if Selected and (DrawStyle in [tdsWindowsXP, tdsNormal]) and LMDThemeServices.ThemesEnabled(UseThemeMode) and IsThemed and LMDSIWindowsVistaUp then
                  begin
                    LMDThemeServices.DrawElement(UseThemeMode, hDC, Details, rcItem,  LMDRectToPtr(rcItem));
                    bitblt(Bmp.Canvas.Handle, 0, 0, rcItem.Right - rcItem.left,
                      rcItem.Bottom - rcItem.Top, hDC, rcItem.Left, rcItem.Top, SRCCOPY);
                  end;
                  TElMenuItem(MenuItem).DrawMenuItem(Canvas, R, Selected, false);
                end;
                bitblt(hDC, rcItem.Left, rcItem.Top, rcItem.Right - rcItem.left,
                  rcItem.Bottom - rcItem.Top, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
              finally
                Bmp.Free;
              end;
              Handled := true;
              Message.Result := 1; //???
              Exit;
            end;
            Handled := false;
            // MenuItem := FindItem(itemID, fkCommand); //???: debug
          end;
      WM_MEASUREITEM:
        begin
          with PMeasureItemStruct(LParam)^ do
          if (CtlType = ODT_MENU) then
            begin
              MenuItem := FindItem(itemID, fkCommand);
              if MenuItem <> nil then
              begin
                DC := GetWindowDC(TWinControl(Owner).Handle);
                try
                  Canvas := TControlCanvas.Create;
                  with Canvas do
                  try
                    SaveIndex := SaveDC(DC);
                    try
                      Handle := DC;
                      if Assigned(Self.Font) then
                        Canvas.Font.Assign(Self.Font)
                      else
                        Canvas.Font.Handle := GetMenuFont;
                        TElMenuItem(MenuItem).MeasureItem(Canvas,
                        Integer(itemWidth),
                        Integer(itemHeight));
                        finally
                      Handle := 0;
                      RestoreDC(DC, SaveIndex);
                    end;
                  finally
                    Canvas.Free;
                  end;
                finally
                  ReleaseDC(TWinControl(Owner).Handle, DC);
                end;
                Handled := true;
                Message.Result := 1; //???
                Exit;
              end;
            end;
          Handled := false;
          //MenuItem := FindItem(itemID, fkCommand); //???: debug
        end;
//      else
//        begin
//          exit;
//        end;
    end; //of case Msg
  end; //of with Message

  if Handled then
  begin
    exit;
  end;

end;

procedure TElMainMenu.IntMenuChanged(Sender: TObject; Source: TElMenuItem; Rebuild: Boolean);
begin
  MenuChanged(Sender, (Source as TMenuItem), Rebuild);
end;

procedure TElMainMenu.MenuChanged(Sender: TObject; Source: TMenuItem; Rebuild: Boolean);
var
  NeedUpdate: Boolean;
begin
  if (WindowHandle <> 0) then
  begin
    NeedUpdate := UpdateImage; // check for changes before CM_MENUCHANGED does
    if Source = nil then
      SendMessage(WindowHandle, CM_MENUCHANGED, 0, 0);
    if NeedUpdate then
      DrawMenuBar(WindowHandle);
  end;

  if ComponentState * [csLoading, csDestroying] = [] then
    DoChange(Source, Rebuild);

end;

procedure TElMainMenu.Loaded;
var
  u: boolean;
  MenuItemInfo: TMenuItemInfo;
begin
  inherited;
  UpdateCommands;
  u := false;
  if Images <> nil then
  begin
    u := true;
  end;
  if SystemFont then
  begin
    GetFont;
    u := true;
  end;
  if u then
  begin
    //if Items.FHandle <> 0 then
    //  DestroyMenu(Items.FHandle);
    //Items.FHandle := 0;
    UpdateItems;
    if WindowHandle <> 0 then
    begin
      Windows.SetMenu(WindowHandle, 0);
      Windows.SetMenu(WindowHandle, Handle);
    end;
  end;
  if FRightToLeft then
  begin
    MenuItemInfo.cbSize := SizeOf(MenuItemInfo);
    MenuItemInfo.fMask := MIIM_TYPE;
    GetMenuItemInfo(Handle, 0, true, MenuItemInfo);
    MenuItemInfo.fType := MenuItemInfo.fType or MFT_RIGHTORDER or MFT_RIGHTJUSTIFY;
    SetMenuItemInfo(Handle, 0, true, MenuItemInfo);
  end;
end;

//GTP Procedure

procedure TElMainMenu.SetRightToLeft(Value: Boolean);
var
  MenuItemInfo: TMenuItemInfo;

begin
  if FRightToLeft <> Value then
  begin
    FRightToLeft := Value;
    MenuItemInfo.cbSize := SizeOf(MenuItemInfo);
    MenuItemInfo.fMask := MIIM_TYPE;
    GetMenuItemInfo(Handle, 0, true, MenuItemInfo);

    if FRightToLeft then
      MenuItemInfo.fType := MenuItemInfo.fType or MFT_RIGHTORDER or
        MFT_RIGHTJUSTIFY
    else
      MenuItemInfo.fType := MenuItemInfo.fType and (not MFT_RIGHTORDER) and (not
        MFT_RIGHTJUSTIFY);

    SetMenuItemInfo(Handle, 0, true, MenuItemInfo);
    DrawMenuBar(WindowHandle);
  end;
end;

procedure TElMainMenu.SetSelectedItemFont(const Value: TFont);
begin
  FSelectedItemFont.Assign(Value);
  UpdateItems;
end;

procedure TElMainMenu.SetSystemFont(Value: Boolean);
begin
  if FSystemFont <> Value then
  begin
    FSystemFont := Value;
    if FSystemFont then
      GetFont;
    DrawMenuBar(WindowHandle);
  end;
end;

procedure TElMainMenu.GetFont;
var
  AFont: HFont;
  LFont: TLogFont;
begin
  AFont := GetMenuFont;
  GetObject(AFont, sizeof(LFont), @LFont);
  Font.Name := LFont.lfFaceName;
  Font.Height := LFont.lfHeight;
  Font.Charset := LFont.lfCharSet;
  Font.Style := [];
  if LFont.lfHeight > 400 then
    Font.Style := Font.Style + [fsBold];
  if LFont.lfItalic <> 0 then
    Font.Style := Font.Style + [fsItalic];
  if LFont.lfUnderline <> 0 then
    Font.Style := Font.Style + [fsUnderline];
  if LFont.lfStrikeOut <> 0 then
    Font.Style := Font.Style + [fsStrikeOut];
  DeleteObject(AFont);
end;

procedure TElMainMenu.FontChange(Sender: TObject);
begin
  if not FSystemFont then
  begin
    if WindowHandle <> 0 then
    begin
      Windows.SetMenu(WindowHandle, 0);
      Windows.SetMenu(WindowHandle, Handle);
    end;
  end;
end;

procedure TElMainMenu.SetIsHTML(Value: Boolean);
begin
  if FIsHTML <> Value then
  begin
    FIsHTML := Value;
    if FIsHTML then
    begin
      FRender := TLMDHTMLRender.Create;
      FRender.OnImageNeeded := TriggerImageNeededEvent;
    end
    else
    begin
      FRender.Free;
      FRender := nil;
    end;
  end;
end;

procedure TElMainMenu.TriggerImageNeededEvent(Sender: TObject; Src: TLMDString;
  var Image: TBitmap);
begin
  Image := nil;
  if (assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src, Image);
end;

function TElMainMenu.DispatchPopup(AHandle: HMENU): Boolean;
var
  Item: TElMenuItem;
begin
  Result := False;
  Item := FindItem(AHandle, fkHandle);
  if Item <> nil then
  begin

    if not (csDesigning in Item.ComponentState) then
      Item.InitiateActions;

    Item.Click;
    Item.InternalRethinkLines(False);
    Result := True;
  end

  else
    if not (csDesigning in ComponentState) and (Self is TMainMenu) then
    Items.InitiateActions;

end;

procedure TElMainMenu.UpdateCommands;
var
  i: integer;
begin
  for i := 0 to Items.Count - 1 do
    with Items[i] do
      UpdateCommand;
end;

procedure TElMainMenu.Merge(Menu: TElMainMenu);
begin
  if Menu <> nil then
    FUnicodeItems.MergeWith(Menu.FUnicodeItems)
  else
    FUnicodeItems.MergeWith(nil);
end;

procedure TElMainMenu.Unmerge(Menu: TElMainMenu);
begin
  if (Menu <> nil) and (FUnicodeItems.FMerged = Menu.FUnicodeItems) then
    FUnicodeItems.MergeWith(nil);
end;

function TElMainMenu.GetDrawStyle: TDrawStyle;
begin
  Result := FDrawStyle;
end;

function TElMainMenu.GetIsHTML: Boolean;
begin
  Result := FIsHTML;
end;

procedure TElMainMenu.AssignTo(Dest : TPersistent);
begin
  if Dest is TElPopupMenu then
  begin
    TElPopupMenu(Dest).IsHTML := IsHTML;
    TElPopupMenu(Dest).Font := Font;
    TElPopupMenu(Dest).DrawStyle := DrawStyle;
    TElPopupMenu(Dest).RightToLeft := RightToLeft;
    TElPopupMenu(Dest).SystemFont := SystemFont;
    TElPopupMenu(Dest).OnImageNeeded := OnImageNeeded;
    TElPopupMenu(Dest).AlphaForImages := AlphaForImages;
    TElPopupMenu(Dest).Images := Images;
    TElPopupMenu(Dest).ItemSpace := ItemSpace;
    TElPopupMenu(Dest).ImageMargin := ImageMargin;
    TElPopupMenu(Dest).BiDiMode := BiDiMode;
    TElPopupMenu(Dest).OwnerDraw := Ownerdraw;
    TElPopupMenu(Dest).ParentBiDiMode := ParentBiDiMode;
    TElPopupMenu(Dest).OnChange := OnChange;
    end
  else
  if Dest is TElMainMenu then
  begin
    TElMainMenu(Dest).IsHTML := IsHTML;
    TElMainMenu(Dest).Font := Font;
    TElMainMenu(Dest).DrawStyle := DrawStyle;
    TElMainMenu(Dest).RightToLeft := RightToLeft;
    TElMainMenu(Dest).SystemFont := SystemFont;
    TElMainMenu(Dest).OnImageNeeded := OnImageNeeded;
    TElMainMenu(Dest).AlphaForImages := AlphaForImages;
    TElMainMenu(Dest).Images := Images;
    TElMainMenu(Dest).ItemSpace := ItemSpace;
    TElMainMenu(Dest).ImageMargin := ImageMargin;
    TElMainMenu(Dest).BiDiMode := BiDiMode;
    TElMainMenu(Dest).OwnerDraw := Ownerdraw;
    TElMainMenu(Dest).ParentBiDiMode := ParentBiDiMode;
    TElMainMenu(Dest).OnChange := OnChange;
    end
  else
    inherited AssignTo(Dest);
end;

procedure TElMainMenu.SetDisabledImages(Value: TCustomImageList);
begin
  if FDisabledImages <> nil then FDisabledImages.UnRegisterChanges(FDisabledImageChangeLink);
  FDisabledImages := Value;
  if FDisabledImages <> nil then
  begin
    FDisabledImages.RegisterChanges(FDisabledImageChangeLink);
    FDisabledImages.FreeNotification(Self);
  end;
  if Images <> nil then
    ImageListChange(Images)
  else
    UpdateItems;
  Items.MenuChanged(False);
  Items.IntMenuChanged(False);
  if (Owner <> nil) and (Owner is TWinControl) and (not (csDestroying in ComponentState)) then
    DrawMenuBar(TWinControl(Owner).Handle);
end;

procedure TElMainMenu.SetHotImages(Value: TCustomImageList);
begin
  if FHotImages <> nil then FHotImages.UnRegisterChanges(FHotImageChangeLink);
  FHotImages := Value;
  if FHotImages <> nil then
  begin
    FHotImages.RegisterChanges(FHotImageChangeLink);
    FHotImages.FreeNotification(Self);
  end;
  if Images <> nil then
    ImageListChange(Images)
  else
    UpdateItems;
  Items.MenuChanged(False);
  Items.IntMenuChanged(False);
  if (Owner <> nil) and (Owner is TWinControl) and (not (csDestroying in ComponentState)) then
    DrawMenuBar(TWinControl(Owner).Handle);
end;

procedure TElMainMenu.SetAlphaDisabledImages(Value: TCustomImageList);
begin
  if FAlphaDisabledImages <> nil then
  begin
    FAlphaDisabledImages.UnRegisterChanges(FADisabledImageChangeLink);
    //FImages.RemoveFreeNotification(Self);
  end;
  FAlphaDisabledImages := Value;
  if FAlphaDisabledImages <> nil then
  begin
    FAlphaDisabledImages.RegisterChanges(FADisabledImageChangeLink);
    FAlphaDisabledImages.FreeNotification(Self);
  end;
  if FAlphaDisabledImages <> nil then
    ImageListChange(FAlphaDisabledImages)
  else
    UpdateItems;
  Items.MenuChanged(False);
  Items.IntMenuChanged(False);
  if (Owner <> nil) and (Owner is TWinControl) and (not (csDestroying in ComponentState)) then
    DrawMenuBar(TWinControl(Owner).Handle);
end;

procedure TElMainMenu.SetImageMargin(Value: integer);
begin
  if (FImageMargin <> Value) then
  begin
    FImageMargin := Value;
    OwnerDraw := true;
    Items.MenuChanged(False);
    Items.IntMenuChanged(True);
    Items.DesignRebuild;
    UpdateItems;
  end;
end;

procedure TElMainMenu.SetItemSpace(Value: integer);
begin
  if (FitemSpace <> Value) then
  begin
    FItemSpace := Value;
    OwnerDraw := true;
    Items.MenuChanged(False);
    Items.IntMenuChanged(True);
    Items.DesignRebuild;
    UpdateItems;
  end;
end;

procedure TElMainMenu.SetAlphaHotImages(Value: TCustomImageList);
begin
  if FAlphaHotImages <> nil then
  begin
    FAlphaHotImages.UnRegisterChanges(FAHotImageChangeLink);
    //FImages.RemoveFreeNotification(Self);
  end;
  FAlphaHotImages := Value;
  if FAlphaHotImages <> nil then
  begin
    FAlphaHotImages.RegisterChanges(FAHotImageChangeLink);
    FAlphaHotImages.FreeNotification(Self);
  end;
  if FAlphaHotImages <> nil then
    ImageListChange(FAlphaHotImages)
  else
    UpdateItems;
  Items.MenuChanged(False);
  Items.IntMenuChanged(False);
  if (Owner <> nil) and (Owner is TWinControl) and (not (csDestroying in ComponentState)) then
    DrawMenuBar(TWinControl(Owner).Handle);
end;

{ Menu building functions }

procedure InsertItems(var AMenu: TMenu; MainItem: TElMenuItem; Index: Integer;
  Items: array of TElMenuItem);
var
  I: Integer;

  procedure SetOwner(Item: TElMenuItem);
  var
    I: Integer;
  begin
    if Item <> nil then
    begin
      if Item.Owner = nil then
      begin
        if AMenu is TElPopupMenu then
          TElPopupMenu(AMenu).FForm.InsertComponent(Item)
        else
          TElMainMenu(AMenu).FForm.InsertComponent(Item);
      end;
      for I := 0 to Item.Count - 1 do
        SetOwner(Item[I]);
    end;
  end;

begin
  for I := Low(Items) to High(Items) do
  begin
    SetOwner(Items[I]);
    MainItem.Insert(Index, Items[I]);
  end;
end;

procedure InsertMenuItems(var AMenu: TMenu; Index: Integer; Items: array of
  TElMenuItem);
var
  I: Integer;

  procedure SetOwner(Item: TElMenuItem);
  var
    I: Integer;
  begin
    if Item <> nil then
    begin
      if Item.Owner = nil then
      begin
        if AMenu is TElPopupMenu then
          TElPopupMenu(AMenu).Owner.InsertComponent(Item)
        else
          TElMainMenu(AMenu).Owner.InsertComponent(Item);
      end;
      for I := 0 to Item.Count - 1 do
        SetOwner(Item[I]);
    end;
  end;

begin
  for I := Low(Items) to High(Items) do
  begin
    SetOwner(Items[I]);
    if (Index = -1) then
    begin
      if AMenu is TElPopupMenu then
        TElPopupMenu(AMenu).Items.Add(Items[I])
      else
        TElMainMenu(AMenu).Items.Add(Items[I]);
    end
    else
    begin
      if AMenu is TElPopupMenu then
        TElPopupMenu(AMenu).FUniCodeItems.Insert(Index, Items[I])
      else
        TElMainMenu(AMenu).FUniCodeItems.Insert(Index, Items[I]);
    end;
  end;
end;

procedure ElInitMenuItems(AMenu: TMenu; Items: array of TElMenuItem);
var
  I: Integer;

  procedure SetOwner(Item: TElMenuItem);
  var
    I: Integer;
  begin
    if Item.Owner = nil then
      if AMenu is TElPopupMenu then
        TElPopupMenu(AMenu).Owner.InsertComponent(Item)
      else
        TElMainMenu(AMenu).Owner.InsertComponent(Item);
    for I := 0 to Item.Count - 1 do
      SetOwner(Item[I]);
  end;

begin
  for I := Low(Items) to High(Items) do
  begin
    SetOwner(Items[I]);
    if (AMenu is TElPopupMenu) then
      TElPopupMenu(AMenu).Items.Add(Items[I])
    else
      if (AMenu is TElMainMenu) then
      TElMainMenu(AMenu).Items.Add(Items[I]);
  end;
end;

function ElNewMenu(Owner: TComponent; const AName: TLMDString; Items:
  array of TElMenuItem): TElMainMenu;
begin
  Result := TElMainMenu.Create(Owner);
  Result.Name := AName;
  ElInitMenuItems(Result, Items);
end;

function ElNewSubMenu(const ACaption: TLMDString; hCtx: Word;
  const AName: TLMDString; Items: array of TElMenuItem;
  AEnabled: Boolean): TElMenuItem;
var
  I: Integer;
begin
  Result := TElMenuItem.Create(nil);
  for I := Low(Items) to High(Items) do
    Result.Add(Items[I]);
  Result.Caption := ACaption;
  Result.HelpContext := hCtx;
  Result.Name := AName;
  Result.Enabled := AEnabled;
end;

function ElNewItem(const ACaption: TLMDString; AShortCut: TShortCut;
  AChecked, AEnabled: Boolean; AOnClick: TNotifyEvent;
  hCtx: Word; const AName: TLMDString;
  MenuItemClass: TElMenuItemClass; const AImageIndex: Integer = -1): TElMenuItem;
begin
  if MenuItemClass = nil then
    Result := TElMenuItem.Create(nil)
  else
    Result := MenuItemClass.Create(nil);
  with Result do
  begin
    Caption := ACaption;
    ShortCut := AShortCut;
    OnClick := AOnClick;
    HelpContext := hCtx;
    Checked := AChecked;
    Enabled := AEnabled;
    ImageIndex := AImageIndex;
    Name := AName;
  end;
end;

function ElNewLine: TElMenuItem;
begin
  Result := TElMenuItem.Create(nil);
  Result.Caption := cLineCaption;
end;

function ElGetHotkey(const Text: TLMDString): TLMDString;
var
  i: Integer;
  Len: Integer;
begin
  Result := '';
  Len := Length(Text);
  for i := 1 to Len do
  begin
{$IFDEF LMD_UNICODE}
    if ((Text[i] = cHotKeyPrefix) and (Len - i >= 1)) then
      Result := Text[i + 1];
{$ELSE}
    if not (Text[i] in LeadBytes) then
      if ((Text[i] = cHotKeyPrefix) and (Len - i >= 1)) then
        Result := Text[i + 1];
{$ENDIF}
  end;
end;

function ElStripHotKey(const Text: TLMDString): TLMDString;
var
  i: Integer;
  Len: Integer;
{$IFDEF LMD_UNICODE}
  s1: WideString;
{$ENDIF}
begin
  Result := Text;
  Len := Length(Result);
  for i := 1 to Len do
  begin
{$IFDEF LMD_UNICODE}
    if Result[i] = cHotKeyPrefix then
    begin
      s1 := Result;
      LMDWideDelete(s1, i, 1);
      Result := s1;
    end;
{$ELSE}
    if not (Result[i] in LeadBytes) then
    begin
      if Result[i] = cHotKeyPrefix then
        if ((i > 1) and (Len - i >= 2) and (Result[i - 1] = '(') and
          (Result[i + 2] = ')') and Syslocale.FarEast) then
          Delete(Result, i - 1, 4)
        else
          Delete(Result, i, 1);
    end;
{$ENDIF}
  end;
end;

{ TElPopupMenu }

constructor TElPopupMenu.Create(AOwner: TComponent);
begin
  FUnicodeItems := TElMenuItem.Create(Self);
  FUnicodeItems.FMenu := Self;
  FThemeMode := ttmPlatform;
  inherited Create(AOwner);
  FHook := TElHook.Create(nil);
  FForm := LMDGetOwnerFrameForm(Self);
  FFont := TFont.Create;
  FFont.OnChange := FontChange;
  FSelectedItemFont := TFont.Create;
  FSelectedItemFont.OnChange := FontChange;

  GetFont;
  FSystemFont := true;

  FItemSpace := 4;
  FImageMargin := 6;
  THackClass(Self).FItems.Free;
  THackClass(Self).FItems := FUnicodeItems;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;

  FAImageChangeLink := TChangeLink.Create;
  FAImageChangeLink.OnChange := ImageListChange;

  FHotImageChangeLink := TChangeLink.Create;
  FHotImageChangeLink.OnChange := ImageListChange;
  FAHotImageChangeLink := TChangeLink.Create;
  FAHotImageChangeLink.OnChange := ImageListChange;

  FDisabledImageChangeLink := TChangeLink.Create;
  FDisabledImageChangeLink.OnChange := ImageListChange;
  FADisabledImageChangeLink := TChangeLink.Create;
  FADisabledImageChangeLink.OnChange := ImageListChange;
  THackClass(Self).FBiDiMode := BiDiMode;
  //  FAImageChangeLink := TChangeLink.Create;
//  FAImageChangeLink.OnChange := ImageListChange;

  with FHook do
  begin
    Control := FForm;
    Active := true;
    DesignActive := true;
    OnBeforeProcess := OnBeforeHook;
    OnAfterProcess := nil;
  end;
end;

destructor TElPopupMenu.Destroy;
begin
  FHook.Control := nil;
  FImageChangeLink.Free;
  FAImageChangeLink.Free;
  FHotImageChangeLink.Free;
  FAHotImageChangeLink.Free;
  FDisabledImageChangeLink.Free;
  FADisabledImageChangeLink.Free;
  //FAImageChangeLink.Free;
  FFont.Free;
  FSelectedItemFont.Free;
  FHook.Free;
  if IsHTML then
    FRender.Free;
  FRender := nil;
  inherited;
end;

procedure TElPopupMenu.UpdateItems;
{$ifdef lmdx86}
  function UpdateItem(MenuItem: TElMenuItem): Boolean;
  begin
    Result := False;
    IterateMenus(@UpdateItem, MenuItem.FMerged, MenuItem);
    MenuItem.SubItemChanged(MenuItem, MenuItem, True);
  end;

begin
  IterateMenus(@UpdateItem, Items.FMerged, Items);
{$else}
begin
  TElMenuUpdater.DoIterateMenus(Items.Merged, Items);
{$endif}
end;

procedure TElPopupMenu.DoPopup(Sender: TObject);
begin
  inherited;
end;

{$ifdef LMDX64}
function TElPopupMenu.FindItem(Value: TLMDPtrUInt; Kind: TFindItemKind): TElMenuItem;
var
  LFinder: TElMenuFinder;
begin
  LFinder := TElMenuFinder.Create;
  try
    LFinder.Value := Value;
    LFinder.Kind := Kind;
    IterateMenus(LFinder.Find, Items.Merged, Items);
    Result := LFinder.FoundItem;
  finally
    LFinder.Free;
  end;
end;
{$else}
function TElPopupMenu.FindItem(Value: TLMDPtrUInt; Kind: TFindItemKind): TElMenuItem;
var
  FoundItem: TElMenuItem;

  function Find(Item: TElMenuItem): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if ((Kind = fkCommand) and (Value = Item.Command)) or
      ((Kind = fkHandle) and (Value = Item.FHandle)) or
      ((Kind = fkShortCut) and (Value = Item.ShortCut) and Item.ProcessShortCut) then
    begin
      FoundItem := Item;
      Result := True;
      Exit;
    end
    else
      for I := 0 to Item.GetCount - 1 do
        if Find(Item[I]) then
        begin
          Result := True;
          Exit;
        end;
  end;

begin
  FoundItem := nil;
  if Items <> nil then
    IterateMenus(@Find, Items.FMerged, Items);
  Result := FoundItem;
end;
{$endif}

procedure TElPopupMenu.ImageListChange(Sender: TObject);
begin
  if Sender = Images then UpdateItems;
end;

procedure TElPopupMenu.SetImages(Value: TCustomImageList);
begin
  if FImages <> nil then FImages.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if FImages <> nil then
  begin
    FImages.RegisterChanges(FImageChangeLink);
    FImages.FreeNotification(Self);
  end;
  Items.MenuChanged(False);
  Items.IntMenuChanged(False);

  UpdateItems;
end;

procedure TElPopupMenu.SetAlphaImages(Value: TCustomImageList);
begin
  if FAlphaImages <> nil then FAlphaImages.UnRegisterChanges(FAImageChangeLink);
  FAlphaImages := Value;
  if FAlphaImages <> nil then
  begin
    FAlphaImages.RegisterChanges(FAImageChangeLink);
    FAlphaImages.FreeNotification(Self);
  end;
  UpdateItems;
end;

//vAd:

procedure TElPopupMenu.LoadItemsFromFiles(const ItemsFileName: array of TLMDString);
begin
  ElLoadItemsFromFiles(Self, ItemsFileName);
end;

function TElPopupMenu.getLMDPackage:TLMDPackageID;
begin
  result:=pi_LMD_ELCORE;
end;

function TElPopupMenu.IsShortCut(var Message: TWMKey): Boolean;
type
  TClickResult = (crDisabled, crClicked, crShortCutMoved);
const
  AltMask = $20000000;
var
  ShortCut: TShortCut;
  ShortCutItem: TElMenuItem;
  ClickResult: TClickResult;

  function DoClick(Item: TElMenuItem): TClickResult;
  begin
    Result := crClicked;
    if Item.Parent <> nil then
      Result := DoClick(Item.Parent);
    if Result = crClicked then
      if Item.Enabled then
      try

        if not (csDesigning in ComponentState) then
          Item.InitiateActions;

        Item.Click;
        //PostMessage(FTracker.FTrackerWnd, EL_MENUCLICK, TLMDPtrInt(Item), 0);
        if (Item <> ShortCutItem) and (ShortCutItem.ShortCut <> ShortCut) then
          Result := crShortCutMoved;
      except
        Application.HandleException(Self);
      end
      else
        Result := crDisabled;
  end;

begin
  ShortCut := Byte(Message.CharCode);
  if GetKeyState(VK_SHIFT) < 0 then
    Inc(ShortCut, scShift);
  if GetKeyState(VK_CONTROL) < 0 then
    Inc(ShortCut, scCtrl);
  if Message.KeyData and AltMask <> 0 then
    Inc(ShortCut, scAlt);
  repeat
    ClickResult := crDisabled;
    ShortCutItem := FindItem(ShortCut, fkShortCut);
    if ShortCutItem <> nil then
      if ShortCutItem.ProcessShortCut then
        ClickResult := DoClick(ShortCutItem)
      else
      begin
        ShortCutItem := nil;
        break;
      end;
  until ClickResult <> crShortCutMoved;
  Result := ShortCutItem <> nil;
end;

function TElPopupMenu.IsOwnerDraw: Boolean;
begin
  Result := true; //OwnerDraw or (Images <> nil) or (DrawStyle <> tdsNormal);
end;

procedure TElPopupMenu.ProcessMenuChar(var Message: TWMMenuChar);
var
  C, I, First, Hilite, Next: Integer;
  State: Word;

  function IsAccelChar(Menu: HMENU; State: Word; I: Integer; C: Char): Boolean;
  var
    Item: TElMenuItem;
    Id: UINT;
  begin
    Item := nil;
    if State and MF_POPUP <> 0 then
    begin
      Menu := GetSubMenu(Menu, I);
      Item := FindItem(Menu, fkHandle);
    end
    else
    begin
      Id := GetMenuItemID(Menu, I);
      if Id <> $FFFFFFFF then
        Item := FindItem(Id, fkCommand);
    end;
    if Item <> nil then
      Result := IsAccel(Ord(C), Item.Caption)
    else
      Result := False;
  end;

  function IsInitialChar(Menu: HMENU; State: Word; I: Integer; C: Char):
    Boolean;
  var
    Item: TElMenuItem;
  begin
    if State and MF_POPUP <> 0 then
    begin
      Menu := GetSubMenu(Menu, I);
      Item := FindItem(Menu, fkHandle);
    end
    else
    begin
      Item := FindItem(Menu, fkHandle);
      if (Item <> nil) and (I < Item.Count) then
        Item := Item.Items[I];
    end;
    // First char is a valid accelerator only if the caption does not
    // contain an explicit accelerator
    if (Item <> nil) and (Item.Caption <> '') then
      Result := (AnsiCompareText(Item.Caption[1], C) = 0) and
        (ElGetHotkey(Item.Caption) = '')
    else
      Result := False;
  end;

begin
  with Message do
  begin
    Result := MNC_IGNORE; { No item found: beep }
    First := -1;
    Hilite := -1;
    Next := -1;
    C := GetMenuItemCount(Menu);
    for I := 0 to C - 1 do
    begin
      State := GetMenuState(Menu, I, MF_BYPOSITION);
      if IsAccelChar(Menu, State, I, User) then
      begin
        if State and MF_DISABLED <> 0 then
        begin
          { Close the menu if this is the only disabled item to choose from.
            Otherwise, ignore the item. }
          if First < 0 then First := -2;
          Continue;
        end;
        if First < 0 then
        begin
          First := I;
          Result := MNC_EXECUTE;
        end
        else
          Result := MNC_SELECT;
        if State and MF_HILITE <> 0 then
          Hilite := I
        else
          if Hilite >= 0 then
          Next := I;
      end;
    end;
    { We found a single disabled item. End the selection. }
    if First < -1 then
    begin
      Result := MNC_CLOSE shl 16;
      Exit;
    end;

    { If we can't find accelerators, then look for initial letters }
    if First < 0 then
      for I := 0 to C - 1 do
      begin
        State := GetMenuState(Menu, I, MF_BYPOSITION);
        if IsInitialChar(Menu, State, I, User) then
        begin
          if State and MF_DISABLED <> 0 then
          begin
            Result := MNC_CLOSE shl 16;
            Exit;
          end;
          if First < 0 then
          begin
            First := I;
            Result := MNC_EXECUTE;
          end
          else
            Result := MNC_SELECT;
          if State and MF_HILITE <> 0 then
            Hilite := I
          else
            if Hilite >= 0 then
            Next := I;
        end;
      end;

    if (Result = MNC_EXECUTE) then
      Result := Result shl 16 or First
    else
      if Result = MNC_SELECT then
    begin
      if Next < 0 then
        Next := First;
      Result := Result shl 16 or Next;
    end;
  end;
end;

procedure TElPopupMenu.SetDrawStyle(Value: TDrawStyle);
begin
  if FDrawStyle <> Value then
  begin
    FDrawStyle := Value;
    OwnerDraw := true;
    Items.MenuChanged(False);
    Items.IntMenuChanged(False);
    UpdateItems;
  end;
end;

function TElPopupMenu.DispatchCommand(ACommand: Word): Boolean;
var
  Item: TElMenuItem;
begin
  Result := False;
  Item := FindItem(ACommand, fkCommand);
  if Item <> nil then
  begin
    Item.Click;
    if Item.Caption <> cLineCaption then
      Result := True;
  end;
end;

procedure TElPopupMenu.OnBeforeHook(Sender: TObject; var Message: TMessage;
  var Handled: boolean);
var
  MenuItem: TMenuItem;
  //FindKind: TFindItemKind;
begin
  Handled := false;
  with Message do
    case Msg of
      WM_HELP: //GTP2
        begin
          with PHelpInfo(Message.LParam)^ do
          begin
            MenuItem := FindItem(iCtrlID, fkCommand);

            if MenuItem <> nil then
            begin
              if MenuItem.HelpContext <> 0 then
              begin
                Application.HelpContext(MenuItem.HelpContext);
                Handled := true;
              end;
            end;
          end;
        end; //GTP2
      WM_SETTINGCHANGE:
        begin
          if SystemFont then
            GetFont;
          UpdateItems;
        end;
      WM_INITMENUPOPUP:
        with TWMInitMenuPopup(Message) do
        if DispatchPopup(MenuPopup) then Exit;
    end; //end of case
end;

procedure TElPopupMenu.Popup(X, Y: Integer);
const
  Flags: array[Boolean, TPopupAlignment] of Word =
((TPM_LEFTALIGN, TPM_RIGHTALIGN, TPM_CENTERALIGN),
    (TPM_RIGHTALIGN, TPM_LEFTALIGN,
      TPM_CENTERALIGN));
  Buttons: array[TTrackButton] of Word = (TPM_RIGHTBUTTON, TPM_LEFTBUTTON);
var
  AFlags: Integer;
begin
  // inherited
  FPopupPoint := Point(X, Y);
  DoPopup(Self);
  FUnicodeItems.RebuildHandle;

  AdjustBiDiBehavior;

  FUnicodeItems.InternalRethinkLines(False);
  FUnicodeItems.RebuildHandle;

  AFlags := Flags[UseRightToLeftAlignment, Alignment]
    or
  Buttons[TrackButton];
  //TrackPopupMenu(FUnicodeItems.Handle, AFlags, X, Y, 0 { reserved }, FForm.Handle, nil);
  FIsPopuped := True;
  try
    if Assigned(FForm) then
      TrackElPopupMenu(FUnicodeItems, AFlags, X, Y, FForm.Handle)
    else
      TrackElPopupMenu(FUnicodeItems, AFlags, X, Y, 0);
  finally
    FIsPopuped := False;
  end;
end;

procedure TElPopupMenu.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  UpdateItems;
end;

function TElPopupMenu.GetHandle: HMENU;
begin
  FUnicodeItems.RebuildHandle;
  Result := FUnicodeItems.Handle;
end;

procedure TElPopupMenu.GetFont;
var
  AFont: HFont;
  LFont: TLogFont;
begin
  AFont := GetMenuFont;
  GetObject(AFont, sizeof(LFont), @LFont);
  Font.Name := LFont.lfFaceName;
  Font.Height := LFont.lfHeight;
  Font.Charset := LFont.lfCharSet;
  Font.Style := [];
  if LFont.lfHeight > 400 then
    Font.Style := Font.Style + [fsBold];
  if LFont.lfItalic <> 0 then
    Font.Style := Font.Style + [fsItalic];
  if LFont.lfUnderline <> 0 then
    Font.Style := Font.Style + [fsUnderline];
  if LFont.lfStrikeOut <> 0 then
    Font.Style := Font.Style + [fsStrikeOut];
  DeleteObject(AFont);
end;

procedure TElPopupMenu.SetPopupRightToLeft(Value: Boolean); //GTP1
begin
  FPopupRightToLeft := Value;
end;

procedure TElPopupMenu.SetSelectedItemFont(const Value: TFont);
begin
  FSelectedItemFont.Assign(Value);
  UpdateItems;
end;

procedure TElPopupMenu.SetSystemFont(Value: Boolean);
begin
  if FSystemFont <> Value then
  begin
    FSystemFont := Value;
    if FSystemFont then
      GetFont;
  end;
end;

procedure TElPopupMenu.FontChange(Sender: TObject);
begin
  if not FSystemFont then
    DrawMenuBar(WindowHandle);
end;

procedure TElPopupMenu.Loaded;
begin
  inherited;
  UpdateCommands;
  if SystemFont then
  begin
    GetFont;
    if Items.FHandle <> 0 then
      DestroyMenu(Items.FHandle);
    Items.FHandle := 0;
    UpdateItems;
  end;
end;

procedure TElPopupMenu.SetIsHTML(Value: Boolean);
begin
  if FIsHTML <> Value then
  begin
    FIsHTML := Value;
    if FIsHTML then
    begin
      FRender := TLMDHTMLRender.Create;
      FRender.OnImageNeeded := TriggerImageNeededEvent;
    end
    else
    begin
      FRender.Free;
      FRender := nil;
    end;
  end;
end;

procedure TElPopupMenu.TriggerImageNeededEvent(Sender: TObject; Src: TLMDString;
  var Image: TBitmap);
begin
  Image := nil;
  if (assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src, Image);
end;

function TElPopupMenu.DispatchPopup(AHandle: HMENU): Boolean;
var
  Item: TElMenuItem;
begin
  Result := False;
  Item := FindItem(AHandle, fkHandle);
  if Item <> nil then
  begin

    if not (csDesigning in Item.ComponentState) then
      Item.InitiateActions;

    Item.Click;
    Item.InternalRethinkLines(False);
    Result := True;
  end

  else
    if not (csDesigning in ComponentState) and (Self is TPopupMenu) then
    Items.InitiateActions;

end;

procedure TElPopupMenu.UpdateCommands;
var
  i: integer;
begin
  for i := 0 to Items.Count - 1 do
    with Items[i] do
      UpdateCommand;
end;

function TElPopupMenu.IsThemed: boolean;
begin
  Result := (FThemeMode <> ttmNone); // and LMDThemeServices.ThemesEnabled(FThemeMode);
end;

function TElPopupMenu.GetUseXPThemes: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

procedure TElPopupMenu.SetUseFontColor(const Value: boolean);
begin
  if FUseFontColor <> Value then
  begin
    FUseFontColor := Value;
  end;
end;

procedure TElPopupMenu.SetUseXPThemes(const Value: Boolean);
begin
  if UseXPThemes <> Value then
  begin
    ThemeMode := LMDCtlXP[Value];
  end;
end;

procedure TElPopupMenu.ReadUseXPThemes(Reader: TReader);
begin
  SetUseXPThemes(Reader.ReadBoolean);
end;

procedure TElPopupMenu.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
  begin
    FThemeGlobalMode := Value;
    DoThemeChanged;
  end;
end;

procedure TElPopupMenu.SetThemeMode(const Value: TLMDThemeMode);
begin
  if Value <> FThemeMode then
  begin
    FThemeMode:= Value;
    DoThemeChanged;
  end;
end;

procedure TElPopupMenu.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('UseXPThemes', ReadUseXPThemes, nil, false);
end;

procedure TElPopupMenu.DoThemeChanged;
begin
end;

function TElPopupMenu.UseThemeMode: TLMDThemeMode;
begin
  if FThemeGlobalMode then
    result := LMDApplication.ThemeGlobalMode
  else
    result := FThemeMode;
  result := LMDThemeServices.UseTheme(result);
end;

procedure TElPopupMenu.TriggerEndPopup(ManualCancel: boolean);
begin
  if assigned(FOnEndPopup) then
    FOnEndPopup(Self, ManualCancel);
end;

procedure TElPopupMenu.TriggerNavigateKey(Button : Word);
begin
  if assigned(FOnNavigateKey) then
    FOnNavigateKey(Self, Button);
end;

procedure TElPopupMenu.AssignTo(Dest : TPersistent);
begin
  if Dest is TElPopupMenu then
  begin
    TElPopupMenu(Dest).IsHTML := IsHTML;
    TElPopupMenu(Dest).Font := Font;
    TElPopupMenu(Dest).DrawStyle := DrawStyle;
    TElPopupMenu(Dest).RightToLeft := RightToLeft;
    TElPopupMenu(Dest).SystemFont := SystemFont;
    TElPopupMenu(Dest).OnImageNeeded := OnImageNeeded;
    TElPopupMenu(Dest).AlphaForImages := AlphaForImages;
    TElPopupMenu(Dest).Images := Images;
    TElPopupMenu(Dest).ItemSpace := ItemSpace;
    TElPopupMenu(Dest).ImageMargin := ImageMargin;
    TElPopupMenu(Dest).UseXPThemes := UseXPThemes;
    TElPopupMenu(Dest).Alignment := alignment;
    TElPopupMenu(Dest).HelpContext := HelpContext;
    TElPopupMenu(Dest).OwnerDraw := Ownerdraw;
    TElPopupMenu(Dest).BiDiMode := BiDiMode;
    TElPopupMenu(Dest).MenuAnimation := MenuAnimation;
    TElPopupMenu(Dest).ParentBiDiMode := ParentBiDiMode;
    TElPopupMenu(Dest).TrackButton := TrackButton;
    TElPopupMenu(Dest).OnChange := OnChange;
    TElPopupMenu(Dest).OnPopup := OnPopup;
  end
  else
  if Dest is TElMainMenu then
  begin
    TElMainMenu(Dest).IsHTML := IsHTML;
    TElMainMenu(Dest).Font := Font;
    TElMainMenu(Dest).DrawStyle := DrawStyle;
    TElMainMenu(Dest).RightToLeft := RightToLeft;
    TElMainMenu(Dest).SystemFont := SystemFont;
    TElMainMenu(Dest).OnImageNeeded := OnImageNeeded;
    TElMainMenu(Dest).AlphaForImages := AlphaForImages;
    TElMainMenu(Dest).ItemSpace := ItemSpace;
    TElMainMenu(Dest).ImageMargin := ImageMargin;
    TElMainMenu(Dest).BiDiMode := BiDiMode;
    TElMainMenu(Dest).OwnerDraw := Ownerdraw;
    TElMainMenu(Dest).ParentBiDiMode := ParentBiDiMode;
    TElMainMenu(Dest).OnChange := OnChange;
    end
  else
    inherited AssignTo(Dest);
end;

function TElPopupMenu.GetDrawStyle: TDrawStyle;
begin
  Result := FDrawStyle;
end;

function TElPopupMenu.GetIsHTML: Boolean;
begin
  Result := FIsHTML;
end;

procedure TElPopupMenu.SetImageMargin(Value: integer);
begin
  if (FImageMargin <> Value) then
  begin
    FImageMargin := Value;
    OwnerDraw := true;
    Items.MenuChanged(False);
    Items.IntMenuChanged(False);
    UpdateItems;
  end;
end;

procedure TElPopupMenu.SetItemSpace(Value: integer);
begin
  if (FItemSpace <> Value) then
  begin
    FItemSpace := Value;
    OwnerDraw := true;
    Items.MenuChanged(False);
    Items.IntMenuChanged(False);
    UpdateItems;
  end;
end;

procedure TElPopupMenu.SetDisabledImages(Value: TCustomImageList);
begin
  if FDisabledImages <> nil then FDisabledImages.UnRegisterChanges(FDisabledImageChangeLink);
  FDisabledImages := Value;
  if FDisabledImages <> nil then
  begin
    FDisabledImages.RegisterChanges(FDisabledImageChangeLink);
    FDisabledImages.FreeNotification(Self);
  end;
  Items.MenuChanged(False);
  Items.IntMenuChanged(False);

  UpdateItems;
end;

procedure TElPopupMenu.SetHotImages(Value: TCustomImageList);
begin
  if FHotImages <> nil then FHotImages.UnRegisterChanges(FHotImageChangeLink);
  FHotImages := Value;
  if FHotImages <> nil then
  begin
    FHotImages.RegisterChanges(FHotImageChangeLink);
    FHotImages.FreeNotification(Self);
  end;
  Items.MenuChanged(False);
  Items.IntMenuChanged(False);

  UpdateItems;
end;

procedure TElPopupMenu.SetAlphaDisabledImages(Value: TCustomImageList);
begin
  if FAlphaDisabledImages <> nil then FAlphaDisabledImages.UnRegisterChanges(FADisabledImageChangeLink);
  FAlphaDisabledImages := Value;
  if FAlphaDisabledImages <> nil then
  begin
    FAlphaDisabledImages.RegisterChanges(FADisabledImageChangeLink);
    FAlphaDisabledImages.FreeNotification(Self);
  end;
  Items.MenuChanged(False);
  Items.IntMenuChanged(False);

  UpdateItems;
end;

procedure TElPopupMenu.SetAlphaHotImages(Value: TCustomImageList);
begin
  if FAlphaHotImages <> nil then FAlphaHotImages.UnRegisterChanges(FAHotImageChangeLink);
  FAlphaHotImages := Value;
  if FAlphaHotImages <> nil then
  begin
    FAlphaHotImages.RegisterChanges(FAHotImageChangeLink);
    FAlphaHotImages.FreeNotification(Self);
  end;
  Items.MenuChanged(False);
  Items.IntMenuChanged(False);

  UpdateItems;
end;

{ TElPopupWindow }

procedure TElPopupWindow.CloseSubmenus;
begin
  while FTracker.SubmenuShown(Self) do
    FTracker.CloseLastPopupWindow;
  SubmenuItem := -1;
end;

constructor TElPopupWindow.Create(Tracker: TElPopupTracker; Menu: TElMenuItem;
  DrawStyle: TDrawStyle; Font: TFont; RightToLeft: boolean;
  Images, AlphaImages: TCustomImageList; SelectFirst: boolean);
begin
  inherited CreateNew(nil);
  FActiveScrollArrow := msNone;
  FAlphaImages := AlphaImages;
  FDrawStyle := DrawStyle;
  FImages := Images;
  FMenuItem := Menu;
  FRightToLeft := RightToLeft;
  FSubmenuItem := -1;
  FSelectedWithMouse := -1;
  FSelectedWithKeyboard := -1;
  FLastSelectedWith := swNone;
  FScrollTimer := Tracker.AddScrollTimer;
  if FScrollTimer <> nil then
    FScrollTimer.OnTimer := ScrollTimerTick;
  FPopupTimer := Tracker.AddPopupTimer;
  if FPopupTimer <> nil then
    FPopupTimer.OnTimer := PopupTimerTick;
  FTracker := Tracker;
  Self.Font := Font;
  BorderStyle := bsNone;
  TabStop := False;
  MeasureBounds;
  FPaintBuffer := TBitmap.Create;
  FPainting := False;
  SetLength(FItemRects, 0);
  SetRectEmpty(FBottomArrowRect);
  SetRectEmpty(FTopArrowRect);
  if SelectFirst then
    SelectFirstItem;

  Self.FPrevPopupWindow := ActivePopupWindow;
  ActivePopupWindow := Self;
end;

procedure TElPopupWindow.CreateParams(var Params: TCreateParams);
var
  LShadow: BOOL;
begin
  inherited;
  Params.Style := WS_CLIPSIBLINGS or WS_POPUP;
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
  Params.WindowClass.style := Params.WindowClass.style and
    not CS_HREDRAW and not CS_VREDRAW;
  if LMDSIWindowsXPUp then
  begin
    LShadow := False;
    SystemParametersInfo(SPI_GETDROPSHADOW, 0, @LShadow, 0);
    if LShadow then
      Params.WindowClass.style := Params.WindowClass.style or CS_DROPSHADOW;
  end;{}
end;

destructor TElPopupWindow.Destroy;
begin
  ActivePopupWindow := Self.FPrevPopupWindow;

  FTracker.DeleteScrollTimer(FScrollTimer);
  FTracker.DeletePopupTimer(FPopupTimer);
  SetLength(FColumnItems, 0);
  SetLength(FColumnWidths, 0);
  SetLength(FItemHeights, 0);
  SetLength(FItemRects, 0);
  FreeAndNil(FPaintBuffer);
  inherited;
end;

procedure TElPopupWindow.DrawColumnedWndLeftToRight(Canvas: TCanvas);
var
  DrawStyle: TDrawStyle;
  R, TR: TRect;
  X, Y: integer;
  I, J: integer;
  ColLastItem: integer;
  ImgW: integer;
  Images: TCustomImageList;
begin
  DrawStyle := GetDrawStyle;
  R := GetClientRect;
  Images := FMenuItem.GetImages(true, false);
  if Images = nil then
    ImgW := 16
  else
    ImgW := TCustomImageList(Images).Width;
  // fill background
  case DrawStyle of
    tdsNormal:
      if FMenuItem.IsThemed and LMDThemeServices.ThemesEnabled(FMenuItem.UseThemeMode) then
        Canvas.Brush.Color := clBtnFace
      else
        Canvas.Brush.Color := clMenu;
    tdsOfficeXP, tdsOffice2003: Canvas.Brush.Color := LMDColorDarker(clWindow, 2);
    tdsWindowsXP:
      if IsThemed then
        Canvas.Brush.Color := clMenu
      else
        Canvas.Brush.Color := clWindow;
  end;
  Canvas.FillRect(R);
  // draw border
  case DrawStyle of
    tdsNormal:
      begin
        DrawEdge(Canvas.Handle, R, EDGE_RAISED, BF_RECT or BF_ADJUST);
        InflateRect(R, -1, -1);
      end;
    tdsOfficeXP, tdsOffice2003:
      begin
        DrawOfficeXPBorder(Canvas, R);
      end;
    tdsWindowsXP:
      begin
        Canvas.Brush.Color := clBtnShadow;
        Canvas.FrameRect(R);
        InflateRect(R, -3, -3);
      end;
  end;
  // draw columns
  SetLength(FItemRects, FMenuItem.Count);
  FillChar(FItemRects[0], SizeOf(TRect) * FMenuItem.Count, 0);
  X := R.Left;
  for I := 0 to Length(FColumnItems) - 1 do
  begin
    Y := R.Top;
    // draw column separator
    if I > 0 then
    begin
      if FMenuItem.Items[FColumnItems[I]].Break = mbBarBreak then
        case DrawStyle of
          tdsNormal:
            begin
              TR := R;
              TR.Left := X;
              TR.Right := TR.Left + 2;
              DrawEdge(Canvas.Handle, TR, BDR_SUNKENOUTER, BF_RECT);
              Inc(X, 2);
            end;
          tdsOfficeXP, tdsOffice2003:
            begin
              Canvas.Pen.Color := LMDColorDarker(clBtnShadow, 20);
              Canvas.MoveTo(X, R.Top);
              Canvas.LineTo(X, R.Bottom);
              Inc(X);
            end;
          tdsWindowsXP:
            begin
              Canvas.Pen.Color := clBtnShadow;
              Canvas.MoveTo(X, R.Top);
              Canvas.LineTo(X, R.Bottom);
              Inc(X);
            end;
        end;
      // move X-coord to the left side of column items
      if DrawStyle in [tdsOfficeXP, tdsOffice2003] then
        Inc(X, 1)
      else
        Inc(X, 2);
    end;
    // draw column background
    if DrawStyle = tdsOfficeXP then
    begin
      TR := R;
      TR.Left := X - 1;
      TR.Right := TR.Left + ImgW + 8;
      Canvas.Brush.Color := LMDColorLighter(clBtnFace, 10);
      Canvas.FillRect(TR);
    end;
    if DrawStyle = tdsOfficeXP then
    begin
      TR := R;
      TR.Left := X - 1;
      TR.Right := TR.Left + ImgW + 8;
      Canvas.Brush.Color := LMDColorLighter(clBtnFace, 10);
      Canvas.FillRect(TR);
    end;
    if DrawStyle = tdsOffice2003 then
    begin
      TR := R;
      TR.Left := X - 1;
      TR.Right := TR.Left + ImgW + 8;
      LMDGradientPaint(Canvas.Handle, TR, LMDColorDarker(clWindow, 2),
                       LMDColorLighter(clBtnFace, 2), 16, gstHorizontal, 0, 0);
    end;

    // calc last menu item for current column
    if I = Length(FColumnItems) - 1 then
      ColLastItem := FMenuItem.Count - 1
    else
      ColLastItem := FColumnItems[I + 1] - 1;
    // draw items in the current column
    for J := FColumnItems[I] to ColLastItem do
    begin
      if not FMenuItem.Items[J].Visible then
        continue;
      TR.Left := X;
      TR.Right := TR.Left + FColumnWidths[I];
      TR.Top := Y;
      TR.Bottom := TR.Top + FItemHeights[J];
      if (DrawStyle in [tdsOfficeXP, tdsOffice2003]) and (FMenuItem.Items[J].Caption = cLineCaption) then
      begin
        Inc(TR.Left, ImgW + 14);
        Inc(TR.Right);
      end;
      FItemRects[J] := TR;
      FMenuItem.Items[J].DrawMenuItem(Canvas, TR, SelectedItem = J, false);
      // move Y-coord to the top side of the next item
      Inc(Y, FItemHeights[J]);
      if DrawStyle in [tdsOfficeXP, tdsOffice2003] then
        Inc(Y);
      if Y + Top > Screen.Height then
        break;
    end;
    // move X-coord to the right side of current column
    Inc(X, FColumnWidths[I]);
    if DrawStyle in [tdsOfficeXP, tdsOffice2003] then
      Inc(X, 1)
    else
      Inc(X, 2);
    if X + Left > Screen.Width then
      break;
  end;
end;

procedure TElPopupWindow.DrawColumnedWndRightToLeft(Canvas: TCanvas);
begin
  {empty}
end;

procedure TElPopupWindow.DrawScrollableWndLeftToRight(Canvas: TCanvas);
var
  DrawStyle: TDrawStyle;
  R, TR: TRect;
  Y, TY: integer;
  I: integer;
  ImgW: integer;
  Images: TCustomImageList;
begin
  DrawStyle := GetDrawStyle;
  R := GetClientRect;
  Images := FMenuItem.GetImages(true, false);
  if (Images = nil) or (not FMenuItem.ChildsHasImage) then
    ImgW := 16
  else
    ImgW := TCustomImageList(Images).Width;
  // fill background
  case DrawStyle of
    tdsNormal:
      if FMenuItem.IsThemed and LMDThemeServices.ThemesEnabled(FMenuItem.UseThemeMode) then
        Canvas.Brush.Color := clBtnFace
      else
        Canvas.Brush.Color := clMenu;
    tdsOfficeXP, tdsOffice2003:
      Canvas.Brush.Color := LMDColorDarker(clWindow, 2);
    tdsWindowsXP:
      if IsThemed then
        Canvas.Brush.Color := clMenu
      else
        Canvas.Brush.Color := clWindow;
  end;
  Canvas.FillRect(R);
  // draw border
  case DrawStyle of
    tdsNormal:
      begin
        DrawEdge(Canvas.Handle, R, EDGE_RAISED, BF_RECT or BF_ADJUST);
        InflateRect(R, -1, -1);
      end;
    tdsOfficeXP, tdsOffice2003:
      begin
        DrawOfficeXPBorder(Canvas, R);
      end;
    tdsWindowsXP:
      begin
        Canvas.Brush.Color := clBtnShadow;
        Canvas.FrameRect(R);
        InflateRect(R, -3, -3);
      end;
  end;
  // draw column background
  if DrawStyle = tdsOfficeXP then
  begin
    TR := R;
    if FRightToLeft then
      TR.Left := TR.Right - ImgW - 8
    else
      TR.Right := TR.Left + ImgW + 8;
    Canvas.Brush.Color := LMDColorLighter(clBtnFace, 10);
    Canvas.FillRect(TR);
  end;
  if DrawStyle = tdsOffice2003 then
  begin
    TR := R;
    if FRightToLeft then
    begin
      TR.Left := TR.Right - ImgW - 8;
      LMDGradientPaint(Canvas.Handle, TR, LMDColorLighter(clBtnFace, 2),
                       LMDColorDarker(clWindow, 2), 16, gstHorizontal, 0, 0);
    end
    else
    begin
      TR.Right := TR.Left + ImgW + 8;
      LMDGradientPaint(Canvas.Handle, TR, LMDColorDarker(clWindow, 2),
                       LMDColorLighter(clBtnFace, 2), 16, gstHorizontal, 0, 0);
    end;
  end;
  // draw items
  SetRectEmpty(FBottomArrowRect);
  SetRectEmpty(FTopArrowRect);
  if FScrollActive then
  begin
    // draw items with scroll arrows
    if FScrollableTopToBottom then
    begin
      Y := R.Top;
      // draw top arrow if needed
      if (not (DrawStyle in [tdsOfficeXP, tdsOffice2003])) or (FTopItem > FindFirstVisibleItem) then
      begin
        TR := R;
        TR.Top := Y;
        TR.Bottom := TR.Top + 16;
        FTopArrowRect := TR;
        case DrawStyle of
          tdsNormal:
            LMDDrawArrow(Canvas, eadUp, TR, clMenuText, FTopItem > 0);
          tdsOfficeXP, tdsOffice2003:
            LMDDrawArrow(Canvas, eadUp, TR, clMenuText, True);
          tdsWindowsXP:
            if FTopItem > FindFirstVisibleItem then
              LMDDrawArrow(Canvas, eadUp, TR, clMenuText, True)
            else
              LMDDrawArrow(Canvas, eadUp, TR, clBtnShadow, True);
        end;
        Inc(Y, 16);
      end;
      // find the last item which can be drawn within the client rect
      TY := Y;
      FLastItem := FindLastVisibleItem;
      for I := FTopItem to FMenuItem.Count - 1 do
      begin
        if (not FMenuItem.Items[I].Visible) then
          continue;
        if TY + FItemHeights[I] > R.Bottom then
        begin
          FLastItem := I - 1;
          break;
        end
        else
        begin
          Inc(TY, FItemHeights[I]);
          if DrawStyle in [tdsOfficeXP, tdsOffice2003] then
            Inc(TY);
        end;
      end;
      // if the found item is not the last item in the menu
      if (not (DrawStyle in [tdsOfficeXP, tdsOffice2003])) or (FLastItem < FindLastVisibleItem) then
      begin
        // find the last item which can be drawn to bottom scroll arrow
        while TY > R.Bottom - 16 do
        begin
          if FMenuItem.Items[FLastItem].Visible then
          begin
            Dec(TY, FItemHeights[FLastItem]);
            if DrawStyle = tdsOfficeXP then
              Dec(TY);
          end;
          Dec(FLastItem);
        end;
      end;
      // draw items
      SetLength(FItemRects, FLastItem - FTopItem + 1);
      FillChar(FItemRects[0], SizeOf(TRect) * Length(FItemRects), 0);
      for I := FTopItem to FLastItem do
      begin
        if not FMenuItem.Items[I].Visible then
          continue;
        TR := R;
        TR.Top := Y;
        TR.Bottom := TR.Top + FItemHeights[I];
        if (DrawStyle in [tdsOfficeXP, tdsOffice2003]) and (FMenuItem.Items[I].Caption = cLineCaption) then
        begin
          Inc(TR.Left, ImgW + 14);
          Inc(TR.Right);
        end;
        FItemRects[I - FTopItem] := TR;
        FMenuItem.Items[I].DrawMenuItem(Canvas, TR, SelectedItem = I, false);
        Inc(Y, FItemHeights[I]);
        if DrawStyle in [tdsOfficeXP, tdsOffice2003] then
          Inc(Y);
      end;
      // draw bottom arrow if needed
      if (not (DrawStyle in [tdsOfficeXP, tdsOffice2003])) or (FLastItem < FindLastVisibleItem) then
      begin
        TR := R;
        TR.Top := TR.Bottom - 16;
        FBottomArrowRect := TR;
        case DrawStyle of
          tdsNormal:
            LMDDrawArrow(Canvas, eadDown, TR, clMenuText, FLastItem < FMenuItem.Count -
              1);
          tdsOfficeXP, tdsOffice2003:
            LMDDrawArrow(Canvas, eadDown, TR, clMenuText, True);
          tdsWindowsXP:
            if FLastItem < FindLastVisibleItem then
              LMDDrawArrow(Canvas, eadDown, TR, clMenuText, True)
            else
              LMDDrawArrow(Canvas, eadDown, TR, clBtnShadow, True);
        end;
      end;
    end
    else
    begin
      if FLastItem >= 0 then
      begin
        Y := R.Bottom;
        // find the top item which can be drawn within the client rect
        TY := Y;
        if (not (DrawStyle in [tdsOfficeXP, tdsOffice2003])) or (FLastItem < FindLastVisibleItem) then
          Dec(TY, 16);
        FTopItem := FindFirstVisibleItem;
        for I := FLastItem downto 0 do
        begin
          if not FMenuItem.Items[I].Visible then
            continue;
          if TY - FItemHeights[I] < R.Top then
          begin
            FTopItem := I + 1;
            break;
          end
          else
          begin
            Dec(TY, FItemHeights[I]);
            if DrawStyle in [tdsOfficeXP, tdsOffice2003] then
              Dec(TY);
          end;
        end;
        // if the found item is not the first item in the menu
        if (not (DrawStyle in [tdsOfficeXP, tdsOffice2003])) or (FTopItem > FindFirstVisibleItem) then
        begin
          // find the top item which can be drawn to top scroll arrow
          while TY < R.Top + 16 do
          begin
            if FMenuItem.Items[FTopItem].Visible then
            begin
              if DrawStyle = tdsOfficeXP then
                Inc(TY);
              Inc(TY, FItemHeights[FTopItem]);
            end;
            Inc(FTopItem);
          end;
        end;
      end
      else
      begin
        // find the last item which can be drawn within the client rect
        Y := R.Top;
        TY := Y;
        if FTopItem > 0 then
          Inc(TY, 16);
        FLastItem := FindLastVisibleItem;
        for I := FTopItem to FMenuItem.Count - 1 do
        begin
          if not FMenuItem.Items[I].Visible then
            continue;
          if TY + FItemHeights[I] > R.Bottom then
          begin
            FLastItem := I - 1;
            break;
          end
          else
          begin
            Inc(TY, FItemHeights[I]);
            if DrawStyle in [tdsOfficeXP, tdsOffice2003] then
              Inc(TY);
          end;
        end;
        // if the found item is not the last item in the menu
        if (not (DrawStyle in [tdsOfficeXP, tdsOffice2003])) or (FLastItem < FindLastVisibleItem) then
        begin
          // find the last item which can be drawn to bottom scroll arrow
          while TY > R.Bottom - 16 do
          begin
            if FMenuItem.Items[FLastItem].Visible then
            begin
              if DrawStyle = tdsOfficeXP then
                Dec(TY);
              Dec(TY, FItemHeights[FLastItem]);
            end;
            Dec(FLastItem);
          end;
        end;
      end;
      Y := R.Bottom;
      // draw bottom arrow if needed
      if (DrawStyle <> tdsOfficeXP) or (FLastItem < FindLastVisibleItem) then
      begin
        TR := R;
        TR.Bottom := Y;
        TR.Top := TR.Bottom - 16;
        FBottomArrowRect := TR;
        case DrawStyle of
          tdsNormal:
            LMDDrawArrow(Canvas, eadDown, TR, clMenuText, FLastItem < FMenuItem.Count -
              1);
          tdsOfficeXP, tdsOffice2003:
            LMDDrawArrow(Canvas, eadDown, TR, clMenuText, True);
          tdsWindowsXP:
            if FLastItem < FindLastVisibleItem then
              LMDDrawArrow(Canvas, eadDown, TR, clMenuText, True)
            else
              LMDDrawArrow(Canvas, eadDown, TR, clBtnShadow, True);
        end;
        Dec(Y, 16);
      end;
      // draw items
      SetLength(FItemRects, FLastItem - FTopItem + 1);
      FillChar(FItemRects[0], SizeOf(TRect) * Length(FItemRects), 0);
      for I := FLastItem downto FTopItem do
      begin
        if not FMenuItem.Items[I].Visible then
          continue;
        TR := R;
        TR.Bottom := Y;
        TR.Top := TR.Bottom - FItemHeights[I];
        if (DrawStyle in [tdsOfficeXP, tdsOffice2003]) and (FMenuItem.Items[I].Caption = cLineCaption)
          then
        begin
          Inc(TR.Left, ImgW + 14);
          Inc(TR.Right);
        end;
        FItemRects[I - FTopItem] := TR;
        FMenuItem.Items[I].DrawMenuItem(Canvas, TR, SelectedItem = I, false);
        Dec(Y, FItemHeights[I]);
        if DrawStyle in [tdsOfficeXP, tdsOffice2003] then
          Dec(Y);
      end;
      // draw top arrow if needed
      if (not (DrawStyle in [tdsOfficeXP, tdsOffice2003])) or (FTopItem > FindFirstVisibleItem) then
      begin
        TR := R;
        TR.Bottom := TR.Top + 16;
        FTopArrowRect := TR;
        case DrawStyle of
          tdsNormal:
            LMDDrawArrow(Canvas, eadUp, TR, clMenuText, FTopItem > 0);
          tdsOfficeXP, tdsOffice2003:
            LMDDrawArrow(Canvas, eadUp, TR, clMenuText, True);
          tdsWindowsXP:
            if FTopItem > FindFirstVisibleItem then
              LMDDrawArrow(Canvas, eadUp, TR, clMenuText, True)
            else
              LMDDrawArrow(Canvas, eadUp, TR, clBtnShadow, True);
        end;
      end;
    end;
  end
  else
  begin
    // draw items without scroll arrows
    FTopItem := FindFirstVisibleItem;
    FLastItem := FindLastVisibleItem;
    Y := R.Top;

    SetLength(FItemRects, FLastItem - FTopItem + 1);
    FillChar(FItemRects[0], SizeOf(TRect) * Length(FItemRects), 0);
    for I := FTopItem to FLastItem do
    begin
      if not FMenuItem.Items[I].Visible then
        continue;
      TR.Left := R.Left;
      TR.Right := TR.Left + FColumnWidths[0];
      TR.Top := Y;
      TR.Bottom := TR.Top + FItemHeights[I];
      if (DrawStyle in [tdsOfficeXP, tdsOffice2003]) and (FMenuItem.Items[I].Caption = cLineCaption)
        then
      begin
        Inc(TR.Left, ImgW + 14);
        Inc(TR.Right);
      end;
      FItemRects[I - FTopItem] := TR;
      FMenuItem.Items[I].DrawMenuItem(Canvas, TR, SelectedItem = I, false);
      // move Y-coord to the top side of the next item
      Inc(Y, FItemHeights[I]);
      if DrawStyle in [tdsOfficeXP, tdsOffice2003] then
        Inc(Y);
    end;
  end;
end;

procedure TElPopupWindow.DrawScrollableWndRightToLeft(Canvas: TCanvas);
begin

end;

procedure TElPopupWindow.EndMenu;
begin
  FTracker.EndMenu(True);
end;

function TElPopupWindow.FindFirstVisibleItem: integer;
var
  I: integer;
begin
  Result := -1;
  for I := 0 to FMenuItem.Count - 1 do
    if FMenuItem.Items[I].Visible then
    begin
      Result := I;
      break;
    end;
end;

function TElPopupWindow.FindLastVisibleItem: integer;
var
  I: integer;
begin
  Result := -2;
  for I := FMenuItem.Count - 1 downto 0 do
    if FMenuItem.Items[I].Visible then
    begin
      Result := I;
      break;
    end;
end;

function TElPopupWindow.FindNextItem(Index: integer): integer;
var
  I: integer;
begin
  Result := -1;
  for I := Index + 1 to FMenuItem.Count - 1 do
    if FMenuItem.Items[I].Visible and FMenuItem.Items[I].Enabled and
      (FMenuItem.Items[I].Caption <> cLineCaption) then
    begin
      Result := I;
      break;
    end;
end;

function TElPopupWindow.FindPrevItem(Index: integer): integer;
var
  I: integer;
begin
  Result := -1;
  for I := Index - 1 downto 0 do
    if FMenuItem.Items[I].Visible and FMenuItem.Items[I].Enabled and
      (FMenuItem.Items[I].Caption <> cLineCaption) then
    begin
      Result := I;
      break;
    end;
end;

function TElPopupWindow.GetDrawStyle: TDrawStyle;
var
  Menu: TMenu;
begin
  Menu := FMenuItem.GetParentMenu;
  if TMenu(Menu) is TElPopupMenu then
  begin
    Result := TElPopupMenu(Menu).DrawStyle;
    if TElPopupMenu(Menu).IsThemed and (Result = tdsNormal) then
      Result := tdsWindowsXP;
  end
  else
    Result := TElMainMenu(Menu).DrawStyle;
end;

function TElPopupWindow.GetItemColumnIndex(Item: integer): integer;
var
  I: integer;
begin
  Result := 0;
  if not FScrollable then
  begin
    for I := 1 to Length(FColumnItems) - 1 do
      if FColumnItems[I] > Item then
        break
      else
        Result := I;
  end;
end;

function TElPopupWindow.GetSelectedItem: integer;
begin
  case FLastSelectedWith of
    swMouse:
      begin
        Result := FSelectedWithMouse;
        if (Result >= 0) and (FDrawStyle in [tdsOfficeXP, tdsOffice2003]) and
          not FMenuItem.Items[Result].Enabled then
          Result := -1;
        if (Result < 0) and FTracker.SubmenuShown(Self) then
          Result := SubmenuItem;
      end;
    swKeyboard: Result := FSelectedWithKeyboard;
  else
    Result := -1;
  end;
end;

function TElPopupWindow.InBottomArrowArea(X, Y: integer): boolean;
begin
  if not FScrollable or not FScrollActive then
    Result := False
  else
    if FLastItem < FindLastVisibleItem then
    Result := PtInRect(FBottomArrowRect, Point(X, Y))
  else
    Result := False;
end;

function TElPopupWindow.InTopArrowArea(X, Y: integer): boolean;
begin
  if not FScrollable or not FScrollActive then
    Result := False
  else
    if FTopItem > FindFirstVisibleItem then
    Result := PtInRect(FTopArrowRect, Point(X, Y))
  else
    Result := False;
end;

function TElPopupWindow.IsRightToLeft: boolean;
var
  Menu: TMenu;
begin
  Menu := FMenuItem.GetParentMenu;
  if TMenu(Menu) is TElPopupMenu then
    Result := TElPopupMenu(Menu).RightToLeft
  else
    Result := TElMainMenu(Menu).RightToLeft;
end;

function TElPopupWindow.IsThemed: boolean;
var
  Menu: TMenu;
begin
  Menu := FMenuItem.GetParentMenu;
  if TMenu(Menu) is TElPopupMenu then
    Result := TElPopupMenu(Menu).IsThemed
  else
    Result := False;
end;

function TElPopupWindow.ItemFromPoint(X, Y: integer): integer;
var
  I: integer;
  First, Last: integer;
begin
  Result := -1;
  if Length(FItemRects) = 0 then
    exit;
  if FScrollable then
  begin
    First := FTopItem;
    Last := FLastItem;
  end
  else
  begin
    First := 0;
    Last := FMenuItem.Count - 1;
  end;
  for I := First to Last do
    if not IsRectEmpty(FItemRects[I - First]) and
      PtInRect(FItemRects[I - First], Point(X, Y)) then
    begin
      if FMenuItem.Items[I].Visible and (FMenuItem.Items[I].Caption <> cLineCaption) then
        Result := I;
      break;
    end;
end;

procedure TElPopupWindow.MeasureBounds;
var
  I, J: integer;
  Column, ColumnCount: integer;
  ItemW, ItemH: integer;
  DrawStyle: TDrawStyle;
  W, H: integer;
  ColH, ColLastItem: integer;
  WR: TRect;
  VisibleFound: boolean;
begin
  // calculating columns count
  ColumnCount := 1;
  for I := 0 to FMenuItem.Count - 1 do
    if (I > 0) and FMenuItem.Items[I].Visible and (FMenuItem.Items[I].Break <> mbNone) then
      Inc(ColumnCount);
  // initializing private fields
  SetLength(FColumnItems, ColumnCount);
  FillChar(FColumnItems[0], ColumnCount * SizeOf(Integer), 0);
  FColumnItems[0] := FindFirstVisibleItem;
  SetLength(FColumnWidths, ColumnCount);
  FillChar(FColumnWidths[0], ColumnCount * SizeOf(Integer), 0);
  SetLength(FItemHeights, FMenuItem.Count);
  FillChar(FItemHeights[0], FMenuItem.Count * SizeOf(Integer), 0);
  FTopItem := 0;
  FScrollable := (ColumnCount = 1);
  FScrollActive := False;
  FScrollableTopToBottom := True;
  // measuring columns and items
  Column := 0;
  for I := 0 to FMenuItem.Count - 1 do
  begin
    if (I > 0) and FMenuItem.Items[I].Visible and (FMenuItem.Items[I].Break <> mbNone)
      then
    begin
      Inc(Column);
      FColumnItems[Column] := I;
    end;
    ItemW := 0;
    ItemH := 0;
    if FMenuItem.Items[I].Visible then
      FMenuItem.Items[I].MeasureItem(Canvas, ItemW, ItemH);
    FItemHeights[I] := ItemH;
    if ItemW > FColumnWidths[Column] then
      FColumnWidths[Column] := ItemW;
  end;
  // adjusting window size
  DrawStyle := GetDrawStyle;
  W := 0;
  H := 0;
  if FScrollable then // scrollable menu
  begin
    // width
    W := FColumnWidths[0];
    // height
    VisibleFound := False;
    for I := 0 to FMenuItem.Count - 1 do
    begin
      if FMenuItem.Items[I].Visible then
      begin
        if (DrawStyle in [tdsOfficeXP, tdsOffice2003]) and VisibleFound then
          Inc(H);
        Inc(H, FItemHeights[I]);
        VisibleFound := True;
        if H >= Screen.Height then
          break;
      end;
    end;
  end
  else
  begin // columned menu
    for I := 0 to ColumnCount - 1 do
    begin
      // calc last item index for current column
      if I = ColumnCount - 1 then
        ColLastItem := FMenuItem.Count - 1
      else
        ColLastItem := FColumnItems[I + 1] - 1;
      // width
      if I > 0 then
      begin
        if DrawStyle in [tdsOfficeXP, tdsOffice2003] then
          Inc(W, 2)
        else
          Inc(W, 4);
        if FMenuItem.Items[FColumnItems[I]].Break = mbBarBreak then
          if DrawStyle = tdsNormal then
            Inc(W, 2)
          else
            Inc(W);
      end;
      Inc(W, FColumnWidths[I]);
      // height
      ColH := 0;
      VisibleFound := False;
      for J := FColumnItems[I] to ColLastItem do
      begin
        if FMenuItem.Items[J].Visible then
        begin
          if (DrawStyle in [tdsOfficeXP, tdsOffice2003]) and VisibleFound then
            Inc(ColH);
          Inc(ColH, FItemHeights[J]);
          VisibleFound := True;
        end;
      end;
      if ColH > H then
        H := ColH;
    end;
  end;
  // add borders
  if DrawStyle in [tdsOfficeXP, tdsOffice2003] then
  begin
    Inc(W, 4);
    Inc(H, 4);
  end
  else
  begin
    Inc(W, 6);
    Inc(H, 6);
  end;
  // apply window size
  if FScrollable then
  begin
    WR := LMDGetWorkSpaceRect;
    if H > (WR.Bottom - WR.Top) then
    begin
      FScrollActive := True;
      H := WR.Bottom - WR.Top;
    end;
  end;
  SetBounds(0, 0, W, H);
end;

procedure TElPopupWindow.Paint;
begin
  if not FPainting then
  begin
    FPainting := True;
    try
      if FPaintBuffer.Width <> Width then
        FPaintBuffer.Width := Width + 5;
      if FPaintBuffer.Height <> Height then
        FPaintBuffer.Height := Height + 5;
      SetLength(FItemRects, 0);
      if IsRightToLeft then
      begin
        if FScrollable then
          DrawScrollableWndLeftToRight(FPaintBuffer.Canvas)
        else
          DrawColumnedWndLeftToRight(FPaintBuffer.Canvas);
      end
      else
      begin
        if FScrollable then
          DrawScrollableWndLeftToRight(FPaintBuffer.Canvas)
        else
          DrawColumnedWndLeftToRight(FPaintBuffer.Canvas);
      end;
      BitBlt(Canvas.Handle, 0, 0, Width + 5, Height + 5, FPaintBuffer.Canvas.Handle, 0, 0, SRCCOPY);
    finally
      FPainting := False;
    end;
  end;
end;

procedure TElPopupWindow.PopupTimerTick(Sender: TObject);
var
  Item: integer;
begin
  Item := FPopupItem;
  StopPopup;
  if FPopupAction = paClose then
    CloseSubmenus
  else
  if SubmenuItem <> Item then
  begin
    CloseSubmenus;
    FMenuItem.Items[Item].Click;
    ShowSubmenu(Item);
  end;
end;

procedure TElPopupWindow.RedrawItem(Index: integer);
var
  Buffer: TBitmap;
  R, BR, TR: TRect;
  ImgW: integer;
  Images: TCustomImageList;
  Details: TThemedElementDetails;
begin
  if Length(FItemRects) = 0 then
    exit;
  Details.Element := teMenu;
  Details.Part := MENU_POPUPITEM;
  Details.State := MPI_HOT;
  R := FItemRects[Index - FTopItem];
  Images := FMenuItem.GetImages(true, false);
  if Images = nil then
    ImgW := 16
  else
    ImgW := TCustomImageList(Images).Width;
  Buffer := TBitmap.Create;
  try
    Buffer.Height := R.Bottom - R.Top;
    Buffer.Width := R.Right - R.Left;
    BR := R;
    OffsetRect(BR, -BR.Left, -BR.Top);
    // draw item background
    case FDrawStyle of
      tdsNormal:
        begin
          if FMenuItem.IsThemed and LMDThemeServices.ThemesEnabled(FMenuItem.UseThemeMode) then
            Buffer.Canvas.Brush.Color := clBtnFace
          else
            Buffer.Canvas.Brush.Color := clMenu;
          Buffer.Canvas.FillRect(BR);
        end;
      tdsOfficeXP:
        begin
          Buffer.Canvas.Brush.Color := LMDColorDarker(clWindow, 2);
          Buffer.Canvas.FillRect(BR);
          TR := BR;
          if FRightToLeft then
            TR.Left := TR.Right - ImgW - 8
          else
            TR.Right := TR.Left + ImgW + 8;
          Buffer.Canvas.Brush.Color := LMDColorLighter(clBtnFace, 10);
          Buffer.Canvas.FillRect(TR);
        end;
      tdsOffice2003:
        begin
          Buffer.Canvas.Brush.Color := LMDColorDarker(clWindow, 2);
          Buffer.Canvas.FillRect(BR);
          TR := BR;
          if FRightToLeft then
          begin
            TR.Left := TR.Right - ImgW - 8;
            LMDGradientPaint(Buffer.Canvas.Handle, TR, LMDColorLighter(clBtnFace, 2),
                           LMDColorDarker(clWindow, 2), 16, gstHorizontal, 0, 0);
          end
          else
          begin
            TR.Right := TR.Left + ImgW + 8;
            LMDGradientPaint(Buffer.Canvas.Handle, TR, LMDColorDarker(clWindow, 2),
                           LMDColorLighter(clBtnFace, 2), 16, gstHorizontal, 0, 0);
          end;
        end;
      tdsWindowsXP:
        begin
          if IsThemed then
            Buffer.Canvas.Brush.Color := clMenu
          else
            Buffer.Canvas.Brush.Color := clWindow;
          Buffer.Canvas.FillRect(BR);
        end;
    end;
    // draw the item
    if (SelectedItem = Index) and (FDrawStyle in [tdsWindowsXP, tdsNormal]) and LMDThemeServices.ThemesEnabled(FMenuItem.UseThemeMode) and IsThemed and LMDSIWindowsVistaUp then
    begin
      BitBlt(Self.Canvas.Handle, R.Left, R.Top, Buffer.Width, Buffer.Height, Buffer.Canvas.Handle, 0, 0, SRCCOPY);
      LMDThemeServices.DrawElement(FMenuItem.UseThemeMode, Canvas.Handle, Details, R,  LMDRectToPtr(R));
      bitblt(Buffer.Canvas.Handle, 0, 0, Buffer.Width, Buffer.Height, Self.Canvas.Handle, R.Left, R.Top, SRCCOPY);
    end;
    FMenuItem.Items[Index].DrawMenuItem(Buffer.Canvas, BR, SelectedItem = Index, false);
    // copy to the real DC
    BitBlt(Canvas.Handle, R.Left, R.Top, Buffer.Width, Buffer.Height,
      Buffer.Canvas.Handle, 0, 0, SRCCOPY);
  finally
    Buffer.Free;
  end;
end;

procedure TElPopupWindow.ScrollDown;
var
  I, NextVisibleItem, NextSelectableItem: integer;
begin
  NextVisibleItem := -1;
  for I := FLastItem + 1 to FMenuItem.Count - 1 do
    if FMenuItem.Items[I].Visible then
    begin
      NextVisibleItem := I;
      break;
    end;
  if NextVisibleItem > FLastItem then
  begin
    NextSelectableItem := FindNextItem(FLastItem);
    if NextSelectableItem > NextVisibleItem then
      FLastItem := NextSelectableItem
    else
      FLastItem := NextVisibleItem;
    FScrollableTopToBottom := False;
    Repaint;
  end;
end;

procedure TElPopupWindow.ScrollTimerTick(Sender: TObject);
begin
  if FActiveScrollArrow = msNone then
    FScrollTimer.Enabled := False
  else
    if (FDrawStyle in [tdsOfficeXP, tdsOffice2003]) or (not (FDrawStyle in [tdsOfficeXP, tdsOffice2003]) and FScrolling)
      then
  begin
    if FActiveScrollArrow = msTop then
    begin
      //Windows.Beep(700, 20);
      ScrollUp;
      if FTopItem <= FindFirstVisibleItem then
      begin
        FScrollTimer.Enabled := False;
        FActiveScrollArrow := msNone;
      end;
    end
    else
    begin
      //Windows.Beep(700, 20);
      ScrollDown;
      if FLastItem >= FindLastVisibleItem then
      begin
        FScrollTimer.Enabled := False;
        FActiveScrollArrow := msNone;
      end;
    end;
  end
  else
    if (not (FDrawStyle in [tdsOfficeXP, tdsOffice2003])) and not FScrolling then
  begin
    FScrollTimer.Enabled := False;
    FActiveScrollArrow := msNone;
  end;
end;

procedure TElPopupWindow.ScrollUp;
var
  I, PrevVisibleItem, PrevSelectableItem: integer;
begin
  PrevVisibleItem := -1;
  for I := FTopItem - 1 downto 0 do
    if FMenuItem.Items[I].Visible then
    begin
      PrevVisibleItem := I;
      break;
    end;
  if (PrevVisibleItem >= 0) and (PrevVisibleItem < FTopItem) then
  begin
    PrevSelectableItem := FindPrevItem(FTopItem);
    if (PrevSelectableItem > 0) and (PrevSelectableItem < PrevVisibleItem) then
      FTopItem := PrevSelectableItem
    else
      FTopItem := PrevVisibleItem;
    FScrollableTopToBottom := True;
    Repaint;
  end;
end;

procedure TElPopupWindow.SelectFirstItem;
var
  NewItem: integer;
begin
  NewItem := FindFirstVisibleItem;
  if NewItem < 0 then
    exit;
  while NewItem < FMenuItem.Count do
    if FMenuItem.Items[NewItem].Visible and (FMenuItem.Items[NewItem].Caption <>
      cLineCaption) then
      break
    else
      Inc(NewItem);
  if NewItem = FMenuItem.Count then
    exit;
  FSelectedWithKeyboard := NewItem;
  FLastSelectedWith := swKeyboard;
  if FScrollable and FScrollActive and ((NewItem < FTopItem) or (NewItem >
    FLastItem)) then
  begin
    FScrollableTopToBottom := True;
    FTopItem := NewItem;
  end;
  if NewItem <> -1 then
    NotifyMenuSelect(NewItem, FMenuItem.Items[NewItem]);
  Repaint;
end;

procedure TElPopupWindow.SelectLastItem;
var
  NewItem: integer;
begin
  NewItem := FindLastVisibleItem;
  if NewItem < 0 then
    exit;
  while NewItem >= 0 do
    if FMenuItem.Items[NewItem].Visible and (FMenuItem.Items[NewItem].Caption <>
      cLineCaption) then
      break
    else
      Dec(NewItem);
  if NewItem < 0 then
    exit;
  FSelectedWithKeyboard := NewItem;
  FLastSelectedWith := swKeyboard;
  if FScrollable and FScrollActive and ((NewItem < FTopItem) or (NewItem >
    FLastItem)) then
  begin
    FScrollableTopToBottom := False;
    FLastItem := NewItem;
  end;
  if NewItem <> -1 then
    NotifyMenuSelect(NewItem, FMenuItem.Items[NewItem]);
  Repaint;
end;

procedure TElPopupWindow.SelectLeftItem(Column: integer);
var
  R: TRect;
  Y, TY: integer;
  StartItem, LastItem: integer;
  Item, DeltaY: integer;
  I: integer;
begin
  if (Column = 0) or IsRectEmpty(FItemRects[SelectedItem - FTopItem]) then
    exit;
  R := FItemRects[SelectedItem];
  Y := R.Top + (R.Bottom - R.Top) div 2;
  StartItem := FColumnItems[Column - 1];
  LastItem := FColumnItems[Column] - 1;
  Item := LastItem;
  DeltaY := MaxInt;
  for I := StartItem to LastItem do
  begin
    if FMenuItem.Items[I].Visible and (FMenuItem.Items[I].Caption <> cLineCaption) then
    begin
      R := FItemRects[I];
      if not IsRectEmpty(R) then
      begin
        TY := R.Top + (R.Bottom - R.Top) div 2;
        if Abs(TY - Y) < DeltaY then
        begin
          DeltaY := Abs(TY - Y);
          Item := I;
        end;
      end;
    end;
  end;
  FSelectedWithKeyboard := Item;
  FLastSelectedWith := swKeyboard;
  if Item <> -1 then
    NotifyMenuSelect(Item, FMenuItem.Items[Item]);
  Repaint;
end;

procedure TElPopupWindow.SelectNextItem;
var
  CurrentItem, NewItem: integer;
begin
  case FLastSelectedWith of
    swMouse: CurrentItem := FSelectedWithMouse;
    swKeyboard: CurrentItem := FSelectedWithKeyboard;
  else
    CurrentItem := -1;
  end;
  if (CurrentItem < 0) or (CurrentItem = FMenuItem.Count - 1) then
    NewItem := FindNextItem(-1)
  else
  begin
    NewItem := FindNextItem(CurrentItem);
    if NewItem < 0 then
      NewItem := FindNextItem(-1);
  end;
  if NewItem < 0 then
    exit;

  if FScrollable and FScrollActive and
    ((NewItem > FLastItem) or (NewItem < CurrentItem)) then
  begin
    if NewItem < CurrentItem then
    begin
      FTopItem := 0;
      FScrollableTopToBottom := True;
    end
    else
    begin
      FScrollableTopToBottom := False;
      FLastItem := NewItem;
    end
  end;
  FSelectedWithKeyboard := NewItem;
  FLastSelectedWith := swKeyboard;
  if NewItem <> -1 then
    NotifyMenuSelect(NewItem, FMenuItem.Items[NewItem]);
  Repaint;
end;

procedure TElPopupWindow.SelectPrevItem;
var
  CurrentItem, NewItem: integer;
begin
  case FLastSelectedWith of
    swMouse: CurrentItem := FSelectedWithMouse;
    swKeyboard: CurrentItem := FSelectedWithKeyboard;
  else
    CurrentItem := -1;
  end;
  if CurrentItem <= 0 then
    NewItem := FindPrevItem(FMenuItem.Count)
  else
  begin
    NewItem := FindPrevItem(CurrentItem);
    if NewItem < 0 then
      NewItem := FindPrevItem(FMenuItem.Count);
  end;
  if NewItem < 0 then
    exit;

  if FScrollable and FScrollActive and
    ((NewItem < FTopItem) or (NewItem > CurrentItem)) then
  begin
    if NewItem > CurrentItem then
    begin
      FScrollableTopToBottom := False;
      FLastItem := FMenuItem.Count - 1;
    end
    else
    begin
      FScrollableTopToBottom := True;
      FTopItem := NewItem;
    end
  end;
  FSelectedWithKeyboard := NewItem;
  FLastSelectedWith := swKeyboard;
  if NewItem <> -1 then
    NotifyMenuSelect(NewItem, FMenuItem.Items[NewItem]);
  Repaint;
end;

procedure TElPopupWindow.SelectRightItem(Column: integer);
var
  R: TRect;
  Y, TY: integer;
  StartItem, LastItem: integer;
  Item, DeltaY: integer;
  I: integer;
begin
  if (Column = Length(FColumnItems) - 1) or
      IsRectEmpty(FItemRects[SelectedItem - FTopItem]) then
    exit;
  R := FItemRects[SelectedItem];
  Y := R.Top + (R.Bottom - R.Top) div 2;
  StartItem := FColumnItems[Column + 1];
  if (Column + 1) < (Length(FColumnItems) - 1) then
    LastItem := FColumnItems[Column + 2] - 1
  else
    LastItem := FindLastVisibleItem;
  Item := LastItem;
  DeltaY := MaxInt;
  for I := StartItem to LastItem do
  begin
    if FMenuItem.Items[I].Visible and (FMenuItem.Items[I].Caption <> cLineCaption) then
    begin
      R := FItemRects[I];
      if not IsRectEmpty(R) then
      begin
        TY := R.Top + (R.Bottom - R.Top) div 2;
        if Abs(TY - Y) < DeltaY then
        begin
          DeltaY := Abs(TY - Y);
          Item := I;
        end;
      end;
    end;
  end;
  FSelectedWithKeyboard := Item;
  FLastSelectedWith := swKeyboard;
  if Item <> -1 then
    NotifyMenuSelect(Item, FMenuItem.Items[Item]);
  Repaint;
end;

procedure TElPopupWindow.SetSubmenuItem(const Value: integer);
var
  OldItem: integer;
begin
  if FSubmenuItem <> Value then
  begin
    OldItem := FSubmenuItem;
    FSubmenuItem := Value;
    if OldItem >= 0 then
      RedrawItem(OldItem);
    if Value >= 0 then
      RedrawItem(Value);
  end;
end;

function IsVisibleItems(Item: TElMenuItem): Boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to Item.Count - 1 do
    if Item.Items[i].Visible then
    begin
      Result := True;
      break;
    end;
end;

procedure TElPopupWindow.ShowSubmenu(Item: integer);
var
  ItemRect, R: TRect;
  X, Y, Y2: integer;
  FSomeMenu : TMenu;
begin
  if not IsVisibleItems(FMenuItem.Items[Item]) then
    exit;
  ItemRect := FItemRects[Item - FTopItem];
  if FRightToLeft or IsRightToLeft then
    X := ItemRect.Left + Left
  else
    X := ItemRect.Right + Left;
  Y := ItemRect.Top + Top;
  Y2 := ItemRect.Bottom + Top;
  R := BoundsRect;
  case FDrawStyle of
    tdsNormal:
      begin
        Dec(Y, 3);
        Inc(Y2, 3);
        Inc(R.Left, 3);
      end;
    tdsOfficeXP, tdsOffice2003:
      begin
        Inc(X);
        if FRightToLeft then
          Dec(R.Left)
        else
          Inc(R.Left);
      end;
    tdsWindowsXP:
      begin
        Inc(X, 2);
        Dec(Y, 3);
        Inc(Y2, 3);
        Inc(R.Left);
      end;
  end;
  SubmenuItem := Item;
  FSelectedWithKeyboard := Item;

  FSomeMenu := FMenuItem.GetParentMenu;
  if not (FSomeMenu is TElPopupMenu) then
    FSomeMenu := nil;

  FMenuItem.Items[Item].TriggerSubMenuPopup;

  FTracker.InternalTrack(TElPopupMenu(FSomeMenu), FMenuItem.Items[Item],
    X, Y, Y2, FTracker.FFlags, R, FLastSelectedWith = swKeyboard);
end;

procedure TElPopupWindow.StartClosePopup;
begin
  FPopupTimer.Enabled := False;
  FPopupItem := -1;
  if FTracker.SubmenuShown(Self) then
  begin
    FPopupAction := paClose;
    FPopupTimer.Enabled := True;
  end;
end;

procedure TElPopupWindow.StartShowPopup(Item: integer);
begin
  if FPopupAction = paClose then
    StopPopup;
  if Item <> SubmenuItem then
  begin
    FPopupTimer.Enabled := False;
    FPopupItem := Item;
    FPopupAction := paShow;
    FPopupTimer.Enabled := True;
  end;
end;

procedure TElPopupWindow.StopPopup;
begin
  FPopupTimer.Enabled := False;
  FPopupItem := -1;
end;

function TElPopupWindow.TrackRightButton: boolean;
var
  Menu: TMenu;
begin
  Menu := FMenuItem.GetParentMenu;
  if Menu is TElPopupMenu then
    Result := TElPopupMenu(Menu).TrackButton = tbRightButton
  else
    Result := False;
end;

procedure TElPopupWindow.WMChar(var Msg: TWMChar);
begin

end;

procedure TElPopupWindow.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
begin
  Msg.Result := 1;
end;

procedure TElPopupWindow.WMKeyDown(var Msg: TWMKeyDown);
var
  i: integer;
  Index: integer;
  Item : TElMenuItem;
begin
  case Msg.CharCode of
    VK_F1,
    VK_HELP:
      NotifyHelpRequest;
    VK_RETURN:
      if (SelectedItem >= 0) and (SelectedItem < FMenuItem.Count) then
      begin
        if FMenuItem.Items[SelectedItem].Count > 0 then
        begin
          FMenuItem.Items[SelectedItem].Click;
          ShowSubMenu(SelectedItem);
        end
        else
        begin
          Item := FMenuItem.Items[SelectedItem];
          FTracker.EndMenu(false);
          //Item.Click;
          PostMessage(MenuClicker, EL_MENUCLICK, TLMDPtrInt(Item), 0);
          end;
      end;
    VK_END: SelectLastItem;
    VK_HOME: SelectFirstItem;
    VK_LEFT:
      if FMenuItem.IsRightToLeft then
      begin
                  // to-do: add processing for right-to-left locales
      end
      else
      begin
        // if the menu is columned
        if not FScrollable and (SelectedItem >= 0) then
        begin
          Index := GetItemColumnIndex(SelectedItem);
          if Index > 0 then
          begin
            SelectLeftItem(Index);
            exit;
          end;
        end;

        // if the menu is a submenu
        if FTracker.FWindows.IndexOf(Self) > 0 then
          FTracker.CloseLastPopupWindow
        else
        begin
          FTracker.NotifyButton(VK_LEFT);
        end;
      end;
    VK_UP: SelectPrevItem;
    VK_RIGHT:
      if FMenuItem.IsRightToLeft then
      begin
        // to-do: add processing for right-to-left locales
      end
      else
      begin
        // if the selected item has a submenu
        if SelectedItem >= 0 then
        begin

          if FMenuItem.Items[SelectedItem].Count > 0 then
          begin
            FMenuItem.Items[SelectedItem].Click;
            ShowSubmenu(SelectedItem);
          end
          else
          // if the menu is columned
          if not FScrollable then
          begin
            Index := GetItemColumnIndex(SelectedItem);
            if Index < Length(FColumnItems) - 1 then
              SelectRightItem(Index)
            else
            if Length(FColumnItems) = 1 then
              FTracker.NotifyButton(VK_RIGHT);
          end
          else
            FTracker.NotifyButton(VK_RIGHT);
        end
        else
          FTracker.NotifyButton(VK_RIGHT);
      end;
    VK_DOWN: SelectNextItem;
    else
      for i := 0 to FMenuItem.Count - 1 do
      begin
        if IsAccel(Msg.CharCode, FMenuItem.Items[i].Caption) then
        begin
          FSelectedWithKeyboard := I;
          FLastSelectedWith := swKeyboard;

          if FMenuItem.Items[i].Count > 0 then
          begin
            FMenuItem.Items[i].Click;
            NotifyMenuSelect(i, FMenuItem.Items[i]);
            Repaint;
            ShowSubMenu(i);
          end
          else
          begin
            Item := FMenuItem.Items[i];
            FTracker.EndMenu(false);
            //Item.Click;
            PostMessage(MenuClicker, EL_MENUCLICK, TLMDPtrInt(Item), 0);
            end;
        end;
      end;
  end;
end;

procedure TElPopupWindow.WMLButtonDown(var Msg: TWMLButtonDown);
begin
  if not (FDrawStyle in [tdsOfficeXP, tdsOffice2003]) then
  begin
    FScrolling := True;
    if InBottomArrowArea(Msg.XPos, Msg.YPos) then
    begin
      StopPopup;
      CloseSubmenus;
      FScrollTimer.Enabled := False;
      FActiveScrollArrow := msBottom;
      FScrollTimer.Enabled := True;
    end
    else
      if InTopArrowArea(Msg.XPos, Msg.YPos) then
    begin
      StopPopup;
      CloseSubmenus;
      FScrollTimer.Enabled := False;
      FActiveScrollArrow := msTop;
      FScrollTimer.Enabled := True;
    end;
  end;
end;

procedure TElPopupWindow.WMLButtonUp(var Msg: TWMLButtonUp);
var
  Item: integer;
  MenuItem : TElMenuItem;
begin
  FScrollTimer.Enabled := False;
  FActiveScrollArrow := msNone;
  FScrolling := False;
  Item := ItemFromPoint(Msg.XPos, Msg.YPos);
  if (Item >= 0) and FMenuItem.Items[Item].Enabled and
    (FMenuItem.Items[Item].Caption <> cLineCaption) and
    (FMenuItem.Items[Item].Count = 0) then
  begin
    MenuItem := FMenuItem.Items[Item];
    FTracker.EndMenu(false);
    PostMessage(MenuClicker, EL_MENUCLICK, TLMDPtrInt(MenuItem), 0);
    // MenuItem.Click;
  end;
end;

procedure TElPopupWindow.WMMouseActivate(var Msg: TWMMouseActivate);
begin
  Msg.Result := MA_NOACTIVATE;
end;

procedure TElPopupWindow.WMMouseMove(var Msg: TWMMouseMove);
var
  InWindow: boolean;
  OldItem, NewItem: integer;
begin
  InWindow := not FTracker.MouseInOtherWindow(Self, Msg.XPos, Msg.YPos) and
    PtInRect(ClientRect, SmallPointToPoint(Msg.Pos));
  if InWindow then
    NewItem := ItemFromPoint(Msg.XPos, Msg.YPos)
  else
    NewItem := -1;
  if FSelectedWithMouse <> NewItem then
  begin
    case FLastSelectedWith of
      swMouse:
        begin
          OldItem := FSelectedWithMouse;
          if OldItem < 0 then
            OldItem := SubmenuItem;
        end;
      swKeyboard: OldItem := FSelectedWithKeyboard;
    else
      OldItem := -1;
    end;
    FSelectedWithMouse := NewItem;
    FLastSelectedWith := swMouse;
    if NewItem <> -1 then
      NotifyMenuSelect(NewItem, FMenuItem.Items[NewItem]);
    if OldItem >= 0 then
      RedrawItem(OldItem);
    if NewItem >= 0 then
    begin
      RedrawItem(NewItem);
      if FMenuItem.Items[NewItem].Enabled and (FMenuItem.Items[NewItem].Count > 0) then
        StartShowPopup(NewItem)
      else
        StartClosePopup;
    end;
  end;
  if InWindow and (NewItem < 0) then
  begin
    if InTopArrowArea(Msg.XPos, Msg.YPos) and (FActiveScrollArrow <> msTop) then
    begin
      StopPopup;
      CloseSubmenus;
      FScrollTimer.Enabled := False;
      FActiveScrollArrow := msTop;
      FScrollTimer.Enabled := True;
    end
    else
      if InBottomArrowArea(Msg.XPos, Msg.YPos) and (FActiveScrollArrow <>
        msBottom) then
    begin
      StopPopup;
      CloseSubmenus;
      FScrollTimer.Enabled := False;
      FActiveScrollArrow := msBottom;
      FScrollTimer.Enabled := True;
    end
    else
    begin
      StartClosePopup;
      FScrollTimer.Enabled := False;
      FActiveScrollArrow := msNone;
    end;
  end
  else
  begin
    if not InWindow then
    begin
      StopPopup;
      if (FSubmenuItem >= 0) and FTracker.SubmenuShown(Self) then
        RedrawItem(FSubmenuItem);
    end;
    FScrollTimer.Enabled := False;
    FActiveScrollArrow := msNone;
  end;
end;

procedure TElPopupWindow.WMRButtonDown(var Msg: TWMRButtonDown);
begin
  if TrackRightButton and (not (FDrawStyle in [tdsOfficeXP, tdsOffice2003])) then
  begin
    FScrolling := True;
    if InBottomArrowArea(Msg.XPos, Msg.YPos) then
    begin
      StopPopup;
      CloseSubmenus;
      FScrollTimer.Enabled := False;
      FActiveScrollArrow := msBottom;
      FScrollTimer.Enabled := True;
    end
    else
      if InTopArrowArea(Msg.XPos, Msg.YPos) then
    begin
      StopPopup;
      CloseSubmenus;
      FScrollTimer.Enabled := False;
      FActiveScrollArrow := msTop;
      FScrollTimer.Enabled := True;
    end;
  end;
end;

procedure TElPopupWindow.WMRButtonUp(var Msg: TWMRButtonUp);
var
  Item: integer;
  LMenuItem : TElMenuItem;
begin
  if TrackRightButton then
  begin
    FScrollTimer.Enabled := False;
    FActiveScrollArrow := msNone;
    FScrolling := False;
    Item := ItemFromPoint(Msg.XPos, Msg.YPos);
    if (Item >= 0) and FMenuItem.Items[Item].Enabled and
      (FMenuItem.Items[Item].Caption <> cLineCaption) and
      (FMenuItem.Items[Item].Count = 0) then
    begin
      LMenuItem := FMenuItem.Items[Item];
      FTracker.EndMenu(false);
      //FMenuItem.Items[Item].Click;
      PostMessage(MenuClicker, EL_MENUCLICK, TLMDPtrInt(LMenuItem), 0);
      end;
  end;
end;

procedure TElPopupWindow.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  //EndMenu;
end;

procedure TElPopupWindow.DrawOfficeXPBorder(Canvas : TCanvas; var R : TRect);
var
  R1 : TRect;
//  B: TBrush;
begin
  Canvas.Pen.Color := LMDColorDarker(clBtnShadow, 100);
  Canvas.Brush.Color := LMDColorDarker(clBtnShadow, 20);

  if (ExcludeRect.Left = 0) and
     (ExcludeRect.Top = 0) and
     (ExcludeRect.Right = 0) and
     (ExcludeRect.Bottom = 0) then
  begin
    Canvas.FrameRect(R);
  end
  else
  begin
    R1 := ExcludeRect;
    R1.TopLeft := ScreenToClient(R1.TopLeft);
    R1.BottomRight := ScreenToClient(R1.BottomRight);
    if R1.Top = R1.Bottom then
    begin
      if (Abs(R1.Top - R.Top) < 2) and (R1.Top <> R.Top) then
      begin
        R1.Top := R.Top;
        R1.Bottom := R.Bottom;
      end;
      Canvas.Polyline([Point(R1.Right - 1, R1.Top), Point(R.Right - 1, R.Top), Point(R.Right - 1, R.Bottom - 1), Point(R.Left, R.Bottom - 1), Point(R.Left, R.Top), Point(R1.Left, R1.Top - 1)]);
      Canvas.Pen.Color := clBtnFace;
      Canvas.Polyline([Point(R1.Left + 1, R1.Top), Point(R1.Right - 1, R.Top)]);
    end
    else
    begin
      if (Abs(R1.Left - R.Left) < 2) and (R1.Left <> R.Left) then
      begin
        R1.Left := R.Left;
        R1.Right := R.Left;
      end;
      Canvas.Polyline([Point(R1.Left, R1.Top), Point(R1.Left, R.Top), Point(R.Right - 1, R.Top), Point(R.Right - 1, R.Bottom - 1), Point(R.Left, R.Bottom - 1), Point(R.Left, R.Top - 1)]);
      Canvas.Pen.Color := clBtnFace;
      Canvas.Polyline([Point(R1.Left, R1.Top + 1), Point(R1.Left, R1.Bottom - 1)]);
    end;
  end;
  InflateRect(R, -2, -2);
end;

procedure TElPopupWindow.NotifyMenuSelect(ItemIndex : integer; Item :
    TElMenuItem);
var Flags : Word;
begin
  Flags := MF_HILITE;
  if Item.Checked then
    Flags := Flags or MF_CHECKED;
  if not Item.Enabled then
    Flags := Flags or (MF_DISABLED or MF_GRAYED);
  if Self.FSelectedWithMouse = ItemIndex then
    Flags := Flags or MF_MOUSESELECT;
  if Item.Count > 0 then
    Flags := Flags or MF_POPUP;
  if Item.GetParentMenu.OwnerDraw then
    Flags := Flags or MF_OWNERDRAW;
  if Item.Count > 0 then
  PostMessage(GetCapture, EL_MENUSELECT, (flags shl 16) or Item.Command, TLMDPtrInt(Item))
  else
    PostMessage(GetCapture, EL_MENUSELECT, (flags shl 16) or Item.Handle, TLMDPtrInt(Item));
  end;

procedure TElPopupWindow.NotifyHelpRequest;
var Info : THelpInfo;
    Item : TElMenuItem;
    begin
  if (SelectedItem >= 0) and (SelectedItem < FMenuItem.Count) then
  begin
    Item := FMenuItem.Items[SelectedItem];
  end
  else
    Item := FMenuItem;

  Info.cbSize := sizeof(THelpInfo);
  Info.iContextType := HELPINFO_MENUITEM;
  Info.iCtrlId := Item.Command;

  if Item.Parent <> nil then
    Info.hItemHandle := Item.Parent.Handle
  else
    Info.hItemHandle := Item.Handle;

  Info.dwContextId := Item.HelpContext;
  GetCursorPos(Info.MousePos);
  if LMDGetOwnerForm(FMenuItem.GetParentMenu) <> nil then
  begin
    PostMessage(LMDGetOwnerFrameForm(FMenuItem.GetParentMenu).Handle, WM_HELP, 0, TLMDPtrInt(@Info));
  end;
  FTracker.EndMenu(false);
end;

{ TElPopupTracker }

function TElPopupTracker.AddPopupTimer: TElTimerPoolItem;
begin
  Result := FTimers.Items.Add;
  Result.Enabled := False;
  Result.Interval := 300;
end;

function TElPopupTracker.AddScrollTimer: TElTimerPoolItem;
begin
  Result := FTimers.Items.Add;
  Result.Enabled := False;
  Result.Interval := 100;
end;

procedure TElPopupTracker.CloseLastPopupWindow;
begin
  if FWindows <> nil then
  begin
    TElPopupWindow(FWindows.Last).Close;
    TElPopupWindow(FWindows.Last).Free;
    FWindows.Delete(FWindows.Count - 1);
    TElPopupWindow(FWindows.Last).SubmenuItem := -1;
  end;
  if Assigned(FShadows) and (not FSystemShadows) then
  begin
    TElShadow(FShadows.Last).Free;
    FShadows.Delete(FShadows.Count - 1);
  end;
end;

procedure TElPopupTracker.CloseWindows;
var
 AWindow: TElPopupWindow;
 AShadow: TElShadow;
begin
  if FWindows <> nil then
    while FWindows.Count > 0 do
    begin
      AWindow := TElPopupWindow(FWindows.Last);
      AWindow.Close;
      AWindow.Free;
      FWindows.Delete(FWindows.Count - 1);
    end;
  if Assigned(FShadows) and (not FSystemShadows) then
  begin
    while FShadows.Count > 0 do
    begin
      AShadow := TElShadow(FShadows.Last);
      FreeAndNil(AShadow);
      FShadows.Delete(FShadows.Count - 1);
    end;
  end;
end;

constructor TElPopupTracker.Create;
begin

  FAlphaImages := nil;
  FDrawStyle := tdsNormal;
  FFont := nil;
  FImages := nil;
  FRightToLeft := False;
  FPassthroughMouse := pmNone;
  FSystemShadows := LMDSIWindowsXPUp;
  FTarget := 0;
  FTerminated := False;
  FTimers := TElTimerPool.Create(nil);
  FTimers.TimerMode := eltWindows;
{$WARNINGS off}
  FTrackerWnd := AllocateHWnd(TrackerWndProc);
{$WARNINGS on}
  FWindows := TList.Create;
  FShadows := TList.Create;
  if ElPopupTracker = nil then
    ElPopupTracker := Self;
end;

procedure TElPopupTracker.DeletePopupTimer(Timer: TElTimerPoolItem);
begin
  if FTimers <> nil then
    FTimers.Items[Timer.Index].Free;
end;

procedure TElPopupTracker.DeleteScrollTimer(Timer: TElTimerPoolItem);
begin
  if FTimers <> nil then
    FTimers.Items[Timer.Index].Free;
end;

destructor TElPopupTracker.Destroy;
begin
  if ElPopupTracker = Self then
    ElPopupTracker := nil;
  FreeAndNil(FTimers);
  CloseWindows;
  FWindows.Free;
  FShadows.Free;
{$WARNINGS off}
  DeallocateHWnd(FTrackerWnd);
{$WARNINGS on}
  inherited;
end;

procedure TElPopupTracker.EndMenu(ManualCancel: boolean);
begin
  CloseWindows;
  FTerminated := True;
  FTermCancel := ManualCancel;
  ReleaseCapture;
  PostMessage(FTrackerWnd, WM_CLOSE, 0, 0);
end;

function TElPopupTracker.FindPopupWindow(X, Y: integer): integer;
var
  I: integer;
begin
  Result := -1;
  for I := FWindows.Count - 1 downto 0 do
    if PtInRect(TElPopupWindow(FWindows[I]).BoundsRect, Point(X, Y)) then
    begin
      Result := I;
      break;
    end;
end;

procedure TElPopupTracker.InternalTrack(Menu: TElPopupMenu; MenuItem:
  TElMenuItem; X, Y1, Y2: integer; Flags: integer; ExcludeRect: TRect;
  SelectFirstItem: boolean);
var
  Window: TElPopupWindow;
  WR: TRect;
  NX,
  NY: Integer;
  MenuItemHeight: Integer;

  // Returns the menu item height of the first menu
  // item which's height is greater than zero.

  function GetMenuItemHeight: Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := Low(Window.FItemHeights) to High(Window.FItemHeights) do
    begin
      if( Window.FItemHeights[i] > 0) then
      begin
        Result := Window.FItemHeights[i];
        Break;
      end;
    end;
  end;

begin
  // Create popup window

  Window := TElPopupWindow.Create(Self, MenuItem, FDrawStyle, FFont,
                                  FRightToLeft, FImages, FAlphaImages,
                                  SelectFirstItem);
  FWindows.Add(Window);

  if Menu.FForm <> nil then
    SendMessage(Menu.FForm.Handle, WM_INITMENUPOPUP,
                MenuItem.Handle, MenuItem.MenuIndex);

  Window.MeasureBounds;

  // -------------------------------------------- //
  // Basics: X = left to right, Y = top to bottom //
  // -------------------------------------------- //

  // Adjust window position vertically

  if Menu.FMustBeInScreen then
    WR := Rect(0, 0, GetSystemMetrics(SM_CXSCREEN),
               GetSystemMetrics(SM_CYSCREEN))
  else
    WR := LMDGetWorkSpaceRect;

  NX := X;
  NY := Y1;

  if FRightToLeft then
    NX := NX - Window.Width;

  MenuItemHeight := GetMenuItemHeight;

  // If the windows' lower end would be out of the visible screen area the
  // menu needs to be unfolded vertically up. It's neccessary to not appear
  // on position of the "Parent"-menu item and so to overlay it. In this case
  // the mouse click always was forwarded to the appearing menu item
  // (unfortunally).

  if NY + Window.Height > WR.Bottom then
  begin
    if( ( Y2 - (Window.Height + MenuItemHeight) ) > WR.Top ) then
      NY := Y2 - (Window.Height + MenuItemHeight)
    else
      NY := WR.Bottom - (Window.Height + MenuItemHeight);
  end;

  if NY < WR.Top then
    NY := WR.Top;

  if FRightToLeft then
  begin
    if NX < WR.Left then
    begin
      if IsRectEmpty(ExcludeRect) then
      begin
        if NX + Window.Width > WR.Right then
          NX := WR.Left + Window.Width
        else
          NX := NX + Window.Width
      end
      else
      begin
        if ExcludeRect.Left - Window.Width > WR.Left then
          NX := WR.Left + Window.Width
        else
          NX := ExcludeRect.Left + Window.Width;
      end;
    end;
  end
  else
  begin
    if NX + Window.Width > WR.Right then
    begin
      if IsRectEmpty(ExcludeRect) then
      begin
        NX := WR.Right - Window.Width;
      end
      else
      begin
        if ExcludeRect.Left - Window.Width < WR.Left then
          NX := WR.Right - Window.Width
        else
          NX := ExcludeRect.Left - Window.Width;
      end;
    end;
  end;

  if (NX = x) and (NY = y1) and (Menu <> nil) and
     (Menu.Items = MenuItem) then
    Window.ExcludeRect := Menu.ExcludeRect;

  SetWindowPos(Window.Handle, HWND_TOPMOST, NX, NY, 0, 0,
               SWP_NOACTIVATE or SWP_NOSIZE {or SWP_NOMOVE} or
               SWP_SHOWWINDOW or SWP_NOREPOSITION);

  // Track mouse messages

  SetCapture(FTrackerWnd);

  Window.Left := NX;
  Window.Top  := NY;

  if Assigned(FShadows) and (not FSystemShadows) then
  begin
    FShadows.Add(TElShadow.Create(Menu.FForm));
    TElShadow(FShadows.Last).Control := Window;
    TElShadow(FShadows.Last).Show;
  end;
end;

function TElPopupTracker.MouseInOtherWindow(Window: TElPopupWindow;
  X, Y: integer): boolean;
var
  I: integer;
  P: TPoint;
begin
  Result := False;
  I := FWindows.Count - 1;
  P := Window.ClientToScreen(Point(X, Y));
  while (FWindows[I] <> Window) and (I >= 0) do
  begin
    if PtInRect(TElPopupWindow(FWindows[I]).BoundsRect, P) then
    begin
      Result := True;
      break;
    end;
    Dec(I);
  end;
end;

function TElPopupTracker.SubmenuShown(Window: TElPopupWindow): boolean;
var
  Index: integer;
begin
  Index := FWindows.IndexOf(Window);
  Result := ((FWindows.Count - 1) > Index);
end;

procedure TElPopupTracker.Track(Menu: TElMenuItem; X, Y, Flags: integer;
  Target: THandle; PassthroughMouse: TPassthroughMouse);
var
  ParentMenu: TElPopupMenu;
  Msg: TMsg;
  NewMsg: TMessage;
  P: TPoint;
  SaveCursor : TCursor;
begin
  if not IsVisibleItems(Menu) then
    exit;

  SaveCursor := Screen.Cursor;
  Screen.Cursor := crArrow;
  try
    SendMessage(Target, WM_ENTERMENULOOP, WPARAM(LONGBOOL(TRUE)), 0);
    ParentMenu := TElPopupMenu(Menu.GetParentMenu);

    FTermCancel := false;
    FFlags := Flags;
    FTarget := Target;
    FPassthroughMouse := PassthroughMouse;

    FAlphaImages := ParentMenu.AlphaForImages;
    FDrawStyle := ParentMenu.DrawStyle;
    FFont := ParentMenu.Font;
    FImages := ParentMenu.Images;
    FRightToLeft := ParentMenu.RightToLeft;

    // PostMessage(FTrackerWnd, WM_NULL, 0, 0);

    FTerminated := False;
    HideCaret(0);

    InternalTrack(ParentMenu, Menu, X, Y, Y, Flags, Rect(0, 0, 0, 0), False);

    if ParentMenu.InitialSelect then
      PostMessage(FTrackerWnd, WM_KEYDOWN, VK_DOWN, 0);

    while not FTerminated do
    begin
      if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
      begin
        FMessageWnd := Msg.hwnd;
        //TranslateMessage(Msg);

        if (Msg.Message = EL_NAVIGATEKEY) then
          ParentMenu.TriggerNavigateKey(Msg.LParam)
        else
        if (Msg.Message >= WM_KEYFIRST) and (Msg.Message <= WM_KEYLAST) then
        begin
          NewMsg.Msg := Msg.Message;
          NewMsg.WParam := Msg.wParam;
          NewMsg.LParam := Msg.lParam;
          NewMsg.Result := 0;

          if Assigned(ParentMenu.FHookWindowProc) then
            ParentMenu.FHookWindowProc(NewMsg);

          TrackerWndProc(NewMsg);
          end
        else
        if (Msg.Message >= WM_MOUSEFIRST) and (Msg.Message <= WM_MOUSELAST) then
        begin
          P.x := LoWord(Msg.lParam);
          P.y := HiWord(Msg.lParam);
          ClientToScreen(Msg.hwnd, P);
          NewMsg.Msg := Msg.Message;
          NewMsg.WParam := Msg.wParam;
          NewMsg.LParam := MakeLParam(P.x, P.y);
          NewMsg.Result := 0;

          if Assigned(ParentMenu.FHookWindowProc) then
            ParentMenu.FHookWindowProc(NewMsg);

          TrackerWndProc(NewMsg);
          end
        else
        begin
          if Msg.hwnd = Target then
          SendMessage(Target, Msg.Message, Msg.wParam, Msg.lParam)
          else
            DispatchMessage(Msg);
        end;
      end
      else
        //WaitMessage;
        Sleep(1);
    end;
    ReleaseCapture;
    CloseWindows;
  finally
    Screen.Cursor := SaveCursor;
  end;
  ShowCaret(0);
  ParentMenu.TriggerEndPopup(FTermCancel);
  FTerminated := false;
  //LMDDebug(PChar('Tracker.Track ending at ' + IntToStr(GetTickCount)));
  SendMessage(Target, WM_EXITMENULOOP, WPARAM(LONGBOOL(true)), 0);
end;

procedure TElPopupTracker.TrackerWndProc(var Msg: TMessage);
begin
  if Msg.Msg = WM_QUERYENDSESSION then
  begin
    Msg.Result := 1;
  end
  else
    Dispatch(Msg);
end;

procedure TElPopupTracker.WMCancelMode(var Msg: TWMCancelMode);
begin
  EndMenu(false);
end;

procedure TElPopupTracker.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  Msg.Result := DLGC_WANTALLKEYS or DLGC_WANTMESSAGE or DLGC_WANTARROWS or
    DLGC_WANTCHARS or DLGC_WANTTAB;
end;

procedure TElPopupTracker.WMKeyDown(var Msg: TWMKeyDown);
begin
  if FWindows.Count > 0 then
  begin
    if Msg.CharCode = VK_ESCAPE then
      if FWindows.Count = 1 then
        EndMenu(false)
      else
        CloseLastPopupWindow
    else
      TElPopupWindow(FWindows.Last).Perform(Msg.Msg, Msg.CharCode, Msg.KeyData);
    Msg.Result := 0;
  end;
end;

procedure TElPopupTracker.WMLButtonDown(var Msg: TWMLButtonDown);
var
  Index: integer;
  Wnd: HWnd;
  Window: TElPopupWindow;
  P: TPoint;
begin
  Index := FindPopupWindow(Msg.XPos, Msg.YPos);
  if Index < 0 then
  begin
    EndMenu(false);
    Wnd := WindowFromPoint(SmallPointToPoint(Msg.Pos));
    if Wnd <> 0 then
    begin
      ShowCaret(0);
      P := Point(Msg.XPos, Msg.YPos);
      Index := SendMessage(Wnd, WM_NCHITTEST, 0, (P.y shl 16) or P.x);
      if Index in [HTCLIENT, HTSIZE, HTGROWBOX] then
      begin
        P := Point(Msg.XPos, Msg.YPos);
        if LMDSIWindowsVistaUp then
          ScreenToClient(Wnd, P);
        PostMessage(Wnd, WM_LBUTTONDOWN, TMessage(Msg).WParam, MakeLParam(P.x, P.y))
        end
      else
        PostMessage(Wnd, WM_NCLBUTTONDOWN, Index, (P.y shl 16) or P.x);
    end;
  end
  else
  begin
    Window := TElPopupWindow(FWindows[Index]);
    P := Window.ScreenToClient(Point(Msg.XPos, Msg.YPos));
    Window.Perform(WM_LBUTTONDOWN, TMessage(Msg).WParam, MakeLParam(P.x, P.y));
    end;
end;

procedure TElPopupTracker.WMLButtonUp(var Msg: TWMLButtonUp);
var
  Index: integer;
  Window: TElPopupWindow;
  P: TPoint;
begin
  Index := FindPopupWindow(Msg.XPos, Msg.YPos);
  if Index >= 0 then
  begin
    Window := TElPopupWindow(FWindows[Index]);
    P := Window.ScreenToClient(Point(Msg.XPos, Msg.YPos));
    Window.Perform(WM_LBUTTONUP, TMessage(Msg).WParam, MakeLParam(P.x, P.y));
    end;
end;

procedure TElPopupTracker.WMMouseMove(var Msg: TWMMouseMove);
var
  I: integer;
  Window: TElPopupWindow;
  P: TPoint;
begin
  I := 0;
  while I < FWindows.Count do
  begin
    Window := TElPopupWindow(FWindows[I]);
    P := Window.ScreenToClient(Point(Msg.XPos, Msg.YPos));
    Window.Perform(WM_MOUSEMOVE, TMessage(Msg).WParam, MakeLParam(P.x, P.y));
    Inc(I);
  end;
end;

procedure TElPopupTracker.WMRButtonDown(var Msg: TWMRButtonDown);
var
  Index: integer;
  Wnd: HWnd;
  Window: TElPopupWindow;
  P: TPoint;
begin
  Index := FindPopupWindow(Msg.XPos, Msg.YPos);
  if Index < 0 then
  begin
    EndMenu(false);
    Wnd := WindowFromPoint(SmallPointToPoint(Msg.Pos));
    if Wnd <> 0 then
    begin
      ShowCaret(0);
      P := Point(Msg.XPos, Msg.YPos);
      Index := SendMessage(Wnd, WM_NCHITTEST, 0, (P.y shl 16) or P.x);
      if Index in [HTCLIENT, HTSIZE, HTGROWBOX] then
      begin
        P := Point(Msg.XPos, Msg.YPos);
        ScreenToClient(Wnd, P);
        PostMessage(Wnd, WM_RBUTTONDOWN, TMessage(Msg).WParam, MakeLParam(P.x, P.y))
        end
      else
        PostMessage(Wnd, WM_NCRBUTTONDOWN, Index, (P.y shl 16) or P.x);
    end;
  end
  else
  begin
    Window := TElPopupWindow(FWindows[Index]);
    P := Window.ScreenToClient(Point(Msg.XPos, Msg.YPos));
    Window.Perform(WM_RBUTTONDOWN, TMessage(Msg).WParam, MakeLParam(P.x, P.y));
    end;
end;

procedure TElPopupTracker.WMRButtonUp(var Msg: TWMRButtonUp);
var
  Index: integer;
  Window: TElPopupWindow;
  P: TPoint;
begin
  Index := FindPopupWindow(Msg.XPos, Msg.YPos);
  if Index >= 0 then
  begin
    Window := TElPopupWindow(FWindows[Index]);
    P := Window.ScreenToClient(Point(Msg.XPos, Msg.YPos));
    Window.Perform(WM_RBUTTONUP, TMessage(Msg).WParam, MakeLParam(P.x, P.y));
  end;
end;

procedure TElPopupTracker.WMSysKeyDown(var Msg: TWMSysKeyDown);
//var Key : integer;
begin
  (*Key := Msg.WParam;
  if (Key <> VK_DOWN) and (Key <> VK_UP) and (Key <> VK_LEFT) and (Key <> VK_RIGHT) then
    EndMenu(false)
  else
  begin
    ;
  end;
  *)
  Msg.Msg := WM_KEYDOWN;
  WMKeyDown(Msg);
end;

procedure TElPopupTracker.NotifyButton(Key : Word);
begin
  PostMessage(FTrackerWnd, EL_NavigateKey, 0, Key);
end;

procedure TElPopupTracker.ELMenuSelect(var Message: TMessage);
var MenuItem : TElMenuItem;
  {$IFDEF LMD_UNICODE}
    WS: WideString;
    S: string;
    l: integer;
    T: WideChar;
    i: integer;
  {$ENDIF}
  begin
  MenuItem := TElMenuItem(Message.lParam);
  {$IFDEF LMD_UNICODE}
  if MenuItem <> nil then
  begin
    S := MenuItem.Hint;
    WS := MenuItem.Hint;
    i := Length(S);
    l := Length(S) + 1 + Length(WS) * 2;
    SetLength(S, l + 4);
    S[i + 1] := #0;
    Move(WS[1], S[i + 2], Length(WS) * 2);
    T := #0;
    Move(T, S[l + 1], sizeof(T));
    T := #$FFFE;
    Move(T, S[l + 3], sizeof(T));
    Application.Hint := S;
  end
  else
    Application.Hint := '';
{$ELSE}
  if MenuItem <> nil then
    Application.Hint := GetLongHint(MenuItem.Hint)
  else
    Application.Hint := '';
{$ENDIF}
end;

procedure TElPopupTracker.WMPaint(var Message: TWMPaint);
begin
  inherited;
end;

procedure ClickerHandler(This : TObject; var Message : TMessage);

begin
  if Message.Msg = EL_MENUCLICK then
  begin
    if Message.wParam <> 0 then
    begin
      try
        TElMenuItem(Message.wParam).Click
        except
        if ExceptObject is Exception then
        begin
          if not (ExceptObject is EAbort) then
            if Assigned(Application.OnException) then
              Application.OnException(nil, Exception(ExceptObject))
            else
              Application.ShowException(Exception(ExceptObject));
        end
        else
          SysUtils.ShowException(ExceptObject, ExceptAddr);
      end;
    end;
  end
  else
  if Message.Msg = WM_QUERYENDSESSION then
  begin
    Message.Result := 1;
  end
  else
    Message.Result := DefWindowProc(MenuClicker, Message.Msg, Message.wParam, Message.lParam);
end;

var ClickMethod : TMethod;

function TMenuActionLink.IsAutoCheckLinked: Boolean;
begin
  Result := FClient.AutoCheck = (Action as TCustomAction).AutoCheck;
end;

initialization
  //CommandPool := TBits.Create;
{$IFDEF LMD_UNICODE}

  GetMenuStringW := GetProcAddress(GetModuleHandle('USER32'), 'GetMenuStringW');

{$ENDIF}
  //vAd:
  if (GetClass('TElMenuItem') = nil) then
    Classes.RegisterClass(TElMenuItem);
  if (GetClass('TElMainMenu') = nil) then
    Classes.RegisterClass(TElMainMenu);
  if (GetClass('TElPopupMenu') = nil) then
    Classes.RegisterClass(TElPopupMenu);

{$WARNINGS off}
  ClickMethod.Code := @ClickerHandler;
  ClickMethod.Data := nil;
  MenuClicker := AllocateHWnd(TWndMethod(ClickMethod));
  {$WARNINGS on}

finalization
  try
    //vAd:
    Classes.UnRegisterClasses([TElMenuItem, TElMainMenu, TElPopupMenu]);
    {$WARNINGS off}
    DeallocateHWnd(MenuClicker);
    {$WARNINGS on}
  except
    on e:Exception do
    begin
      LMDDebug('ERROR finalization ElMenus: ' + e.Message);
    end;
  end;
end.
