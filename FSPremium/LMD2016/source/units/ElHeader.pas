unit ElHeader;
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

ElHeader unit
-------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

[*] ver=-15 for tiburon

Januar 2008 (EK)

[*] In TElHeaderSections.WriteData ver =-14 (decremented) because header
    behaviour was changed. RightAligned mode redesigned.

December 2007 (EK):

[*] In TElHeaderSections.WriteData ver =-13 (decremented) to solve bug with Text
    and Hint propertyes read\write.
###############################################################################}

interface

uses
  Types, Windows, Messages, Graphics, Controls, CommCtrl,
  Forms, Dialogs, Menus, ExtCtrls, StdCtrls, Math, ImgList, SysUtils, Classes, TypInfo,
  Themes, UxTheme,
  ElIni, ElImgFrm, ElCombos, ElXPThemedControl, ElStyleMan, ElVCLUtils,
  LMDClass, LMDThemes, LMDSysIn, LMDDebugUnit, LMDUtils, LMDStrings, LMDBmp,
  LMDProcs, LMDObjectList, LMDUnicodeStrings, LMDHTMLUnit, LMDTypes, LMDGraphUtils, LMDFiles;

const
  DefaultHeaderSectionWidth = 120;

type
  TElSectionStyle = (elhsText, elhsOwnerDraw, elhsPictureOnly, elhsImageIndex);

  TElSSortMode = (hsmNone, hsmAscend, hsmDescend);

  TElSAlignment = (hsaLeft, hsaCenter, hsaRight);

  TElHResizingStates = (trsBegin, trsMove, trsEnd);

  TSectionChangeMode = (scmCaption, scmFieldName, scmFieldType,
    scmAlign, scmStyle, scmEditable, scmPassword);

  TElSectionPart = (espResizeArea, espText, espExpandSign, espLookupSign, espFilterSign);

  TAdjustCondition = (acAll,acAutoSizedOnly);

  TElFieldType = (
    sftCustom, // custom field
    sftText, // text field
    sftNumber, // Integer numbers
    sftFloating, // Floating numbers
    sftDateTime, // DateTime
    sftDate, // Date
    sftTime, // Time
    sftPicture, // Picture
    sftEnum,  // enumeration
    sftBLOB,  // BLOB data
    sftUndef, // undefined field
    sftBool,   // boolean field
    sftCurrency, // currency
    sftMemo   // Memo, multiline text
  );

  TElFieldTypes = set of TElFieldType;

  EElHeaderError = class(Exception);

type
  TCustomElHeader = class;
  TElHeaderSection = class;

  TElHeaderSectionEvent = procedure(Sender: TCustomElHeader; Section: TElHeaderSection) of object;

  TElHeaderLookupEvent = procedure(Sender: TObject; Section: TElHeaderSection; var Text: TElFString) of object;
  TElHeaderLookupDoneEvent = procedure(Sender: TObject;
    Section: TElHeaderSection;
    Text: TElFString;
    Accepted: boolean) of object;

  TElHeaderSection = class(TPersistent)
  private
    procedure DoSetWidth(Value: integer);
    procedure SetHint(const Value: TLMDString);
  protected
    FFilterIsActive: Boolean;
    FFilterEnabled: Boolean;
    FHint: TLMDString;

    FTextLayout: TTextLayout;
    FUseMainStyle: Boolean;
    FFontColor: TColor;
    FColor: TColor;
    FParentColor: Boolean;
    FLookupEnabled: boolean;
    FExpandable: Boolean;
    FExpanded: Boolean;
    FParentSection: TElHeaderSection;
    FParentIdx: integer;
    FPopupMenu: TPopupMenu;
    FPopupName: String;
    FResizable: Boolean;
    FClickSelect: Boolean;
    FProtected: Boolean;
    FFieldName: string;
    FFieldType: TElFieldType;
    FEditable: Boolean;
    FImageIndex: Integer;
    FPicAlign: TElSAlignment;
    FIntTag,
    FIndex: integer;
    FTag: Integer;
    FStyle: TElSectionStyle;
    FWidth: integer;
    FMinWidth,
      FMaxWidth: integer;
    FSortMode: TElSSortMode;
    FAllowClick: boolean;
    FAlignment: TElSAlignment;
    FText: TLMDString;
    FData: pointer;
    FOwner: TCustomElHeader;
    FLookupHist: TLMDMemoryStrings;
    FAutoSize: boolean;

    FStickySize: single;
    ASaveSize: integer;
    FOnResize: TNotifyEvent;
    FShowSortMark: Boolean;

    procedure SetWidth(value: integer); virtual;
    function GetWidth: integer; virtual;
    function GetTop: integer; virtual;
    function GetBottom: integer; virtual;
    function GetLeft: integer; virtual;
    function GetRight: integer; virtual;
    procedure SetMaxWidth(value: integer);
    procedure SetMinWidth(value: integer);
    function GetText: TLMDString; virtual;
    procedure SetText(value: TLMDString); virtual;
    procedure SetStyle(value: TElSectionStyle);
    procedure SetSortMode(value: TElSSortMode); virtual;
    procedure SetAlignment(value: TElSAlignment); virtual;
    procedure SetVisible(value: boolean);

    function GetIndex: integer; virtual;
    function GetPosition: Integer;virtual;
    procedure SetImageIndex(newValue: Integer);
    procedure SetProtected(newValue: Boolean);
    procedure SetExpandable(newValue: Boolean);
    procedure SetExpanded(newValue: Boolean);
    procedure SetParentSection(newValue: TElHeaderSection);
    function GetParentSection: TElHeaderSection;
    procedure SetPopupMenu(newValue: TPopupMenu);
    function GetVisible: boolean;
    procedure SetLookupEnabled(newValue: boolean);
    procedure SetParentColor(newValue: Boolean);
    procedure SetColor(newValue: TColor);
    procedure SetFontColor(newValue: TColor);
    procedure SetUseMainStyle(newValue: Boolean);
    procedure SetTextLayout(newValue: TTextLayout);
    procedure SetFilterEnabled(newValue: Boolean);
    procedure SetFilterIsActive(newValue: Boolean);
    procedure SetLookupList(newValue: TLMDMemoryStrings);
    procedure SetAutoSize(newValue: boolean);
    function GetLocked: boolean;
    procedure SetShowSortMark(Value: Boolean);
  protected
    FVisible: boolean;
    procedure SetIndex(Value: integer);virtual;
    procedure SetFieldName(newValue: string); virtual;
    procedure SetFieldType(newValue: TElFieldType); virtual;
    procedure SetEditable(newValue: boolean); virtual;
    procedure SetResizable(newValue: boolean); virtual;
    procedure SetSaveSize(newValue: integer);
    property FSaveSize: integer read ASaveSize write SetSaveSize default -1;
    function GetOwner: TPersistent; override;
    property OnResize: TNotifyEvent read FOnResize write FOnResize;
  public
    constructor Create(AOwner: TCustomElHeader);
    destructor Destroy; override;
    procedure UpdateSection; virtual;
    procedure Assign(source: TPersistent); override;
    procedure ShowLookup; virtual;
    property Index: integer read GetIndex;
    property Top: Integer read GetTop;
    property Bottom: Integer read GetBottom;
    property Left: integer read GetLeft;
    property Right: integer read GetRight;
    property Position: Integer read GetPosition; { Public }
    property Data: pointer read FData write FData;

    property Locked: boolean read GetLocked;

    property Owner: TCustomElHeader read FOwner;
  published
    property Text: TLMDString read GetText write SetText;
    property Style: TElSectionStyle read FStyle write SetStyle default ElhsText;
    property Width: integer read GetWidth write SetWidth;
    property MaxWidth: integer read FMaxWidth write SetMaxWidth default 10000;
    property MinWidth: integer read FMinWidth write SetMinWidth default 0;
    property SortMode: TElSSortMode read FSortMode write SetSortMode;
    property AllowClick: boolean read FAllowClick write FAllowClick default True;
    property Alignment: TElSAlignment read FAlignment write SetAlignment default hsaLeft;
    property PictureAlign: TElSAlignment read FPicAlign write FPicAlign;
    property Visible: boolean read GetVisible write SetVisible;
    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1; { Published }
    property FieldName: string read FFieldName write SetFieldName; { Public }
    property FieldType: TElFieldType read FFieldType write SetFieldType default sftText; { Public }
    property Editable: Boolean read FEditable write SetEditable; { Public }
    property Password: Boolean read FProtected write SetProtected default False; { Public }
    property Resizable: Boolean read FResizable write SetResizable default True; { Public }
    property ClickSelect: Boolean read FClickSelect write FClickSelect default True; { Public }
    property Expandable: Boolean read FExpandable write SetExpandable;
    property Expanded: Boolean read FExpanded write SetExpanded;
    property ParentSection: TElHeaderSection read GetParentSection write SetParentSection;
    property PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property LookupEnabled: boolean read FLookupEnabled write SetLookupEnabled;
    property LookupHistory: TLMDMemoryStrings read FLookupHist write SetLookupList;
    property ParentColor: Boolean read FParentColor write SetParentColor default True;
    property Color: TColor read FColor write SetColor;
    property FontColor: TColor read FFontColor write SetFontColor;
    property UseMainStyle: Boolean read FUseMainStyle write SetUseMainStyle;
    property TextLayout: TTextLayout read FTextLayout write SetTextLayout default tlCenter;
    property FilterEnabled: Boolean read FFilterEnabled write SetFilterEnabled; { Public }
    property FilterIsActive: Boolean read FFilterIsActive write SetFilterIsActive; { Published }
    property Hint: TLMDString read FHint write SetHint;
    property AutoSize: boolean read FAutoSize write SetAutoSize;
    property ShowSortMark: Boolean read FShowSortMark write SetShowSortMark default True;
    property Tag: Integer read FTag write FTag;
  end;

  TElHeaderSections = class(TPersistent)
  private
    FVer13: Boolean;
  protected
    FList: TLMDObjectList;
    FOwner: TCustomElHeader;
    FForceReindexInAssign: boolean;
    function GetSectionsOrder: string; virtual;
    procedure SetSectionsOrder(newValue: string); virtual;
    function GetCount: integer; virtual;
    function GetSectionByIntTag(IntTag: integer): TElHeaderSection; virtual;
    function GetSection(index: integer): TElHeaderSection; virtual;
    procedure SetSection(index: integer; Section: TElHeaderSection); virtual;
    function GetSectionByPos(index: integer): TElHeaderSection; virtual;
    procedure WriteData(Stream: TStream); virtual;
    procedure IntReadData(Stream: TStream; ClearCurrent: boolean); virtual;
    procedure ReadData(Stream: TStream); virtual;
    procedure FrameReadData(Stream: TStream); virtual;
    procedure DefineProperties(Filer: TFiler); override;
    function LastVisibleSection: TElHeaderSection;
    function GetPrevVisibleSection(Section: TElHeaderSection): TElHeaderSection;
    function FindSection(tag: integer): TElHeaderSection; virtual;
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TCustomElHeader);
    destructor Destroy; override;
    procedure Clear; virtual;

    function CreateSection: TElHeaderSection; virtual;
    procedure Assign(source: TPersistent); override;
    function AddSection: TElHeaderSection; virtual;
    function InsertSection(index: integer): TElHeaderSection; virtual;
    procedure DeleteSection(Section: TElHeaderSection); virtual;
    procedure MoveSection(Section: TElHeaderSection; NewPos: integer); virtual;
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);
    procedure SaveToFile(FileName: TLMDString);virtual;
    procedure LoadFromFile(FileName: TLMDString);virtual;
    procedure Reindex; virtual;
    procedure BeginUpdate;
    procedure EndUpdate;

    property Owner: TCustomElHeader read FOwner;
    property Count: integer read GetCount;
    property ItemByPos[Index: integer]: TElHeaderSection read GetSectionByPos;
    property ForceReindexInAssign: boolean read FForceReindexInAssign write FForceReindexInAssign default true;
    property Item[Index: integer]: TElHeaderSection read GetSection write SetSection; default;
  published
    property SectionsOrder: string read GetSectionsOrder write SetSectionsOrder stored False; { Protected }
  end;

  TMeasureSectionEvent = procedure(Sender: TObject; Section: TElHeaderSection; var Size: TPoint) of object;

  TElSectionRedrawEvent = procedure(Sender: TCustomElHeader;
    Canvas: TCanvas; Section: TElHeaderSection; R: TRect; Pressed: boolean) of object;
  TElSectionResizingEvent = procedure(Sender: TCustomElHeader;
    Section: TElHeaderSection; State: TElHResizingStates; Width: integer) of object;
  TElSectionMoveEvent = procedure(Sender: TCustomElHeader;
    Section: TElHeaderSection; OldPos, NewPos: integer) of object;
  TPictureNeededEvent = procedure(Sender: TCustomElHeader; Section: TElHeaderSection; var ImageIndex: integer) of object;
  TSectionChangeEvent = procedure(Sender: TCustomElHeader; Section: TElHeaderSection; Change: TSectionChangeMode) of object;

  TCustomElHeader = class(TElXPThemedControl)
  private
    FOnImageNeededEx: TLMDHTMLImageNeededEvent;
  protected
    FMouseInControl: Boolean;
    FWrapCaptions: Boolean;
//    FLockedSection: TElHeaderSection;
    FFixedColWidth: Integer;

    FHPos: Integer;
    FInvertSortArrows: Boolean;
    FFlat: Boolean;

    FImgFormChLink: TImgFormChangeLink;
    FImgForm: TElImageForm;

    FActiveFilterColor: TColor;
    FOnFilterCall: TElHeaderSectionEvent;
    FOnSectionAutoSize: TElHeaderSectionEvent;
    FFilterColor: TColor;
    FLockHeight: Boolean;
    FRightAlignedText: Boolean;
    FRightAlignedOrder: Boolean;
    FStickySections: Boolean;
    FMoveOnDrag: Boolean;

    FStorage: TElIniFile;
    FStoragePath: string;

    FImages: TCustomImageList;
    FAlphaImages: TCustomImageList;

    FImageChangeLink: TChangeLink;
    FAlphaImageChangeLink: TChangeLink;
    FSections: TElHeaderSections;
    FTracking: boolean;
    FAllowDrag: boolean;
    FPainting: boolean;
    DragBmp,
    SaveBmp,
    DragBmpMask: TBitmap;
    DragRect: TRect;
    FDragCoord: TPoint;
    FLookup: TElComboBox;
    FLookupStyle: TComboBoxStyle;
    FPressCoord: TPoint;
    FPressed: boolean;
    FPressedItem: TElHeaderSection;
    FHintSection,
    FLookupSection,
      FTrackSection: TElHeaderSection;
    FResizing: boolean;
    FResizeSection: TElHeaderSection;
    FDropSrc,
      FDropTrg: TElHeaderSection;
    FHeaderLine: integer;
    FLineTab: integer;
    FResizeOnDrag: boolean;
    FHeaderLineVis: boolean;
    FIgnoreLookupChange: boolean;
    FDoingLookup: boolean;
    FLineDC: HDC;
    FFocusedCtl: THandle;
    LoadingCount: integer;
    DeletionHappened,
    AdditionHappened: boolean;

    FInStick: boolean;
    FOldWidth: integer;
    FUpdateCount: integer;

    FRender: TLMDHTMLRender;

    FOnSectionClick: TElHeaderSectionEvent;
    FOnSectionResize: TElHeaderSectionEvent;
    FOnSectionDraw: TElSectionRedrawEvent;

    FOnSectionResizing: TElSectionResizingEvent;
    FOnSectionDelete: TElHeaderSectionEvent;
    FOnSectionMove: TElSectionMoveEvent;
    FOnSectionReindex: TElSectionMoveEvent;
    FOnVisibleChange: TElHeaderSectionEvent;
    FOnPictureNeeded: TPictureNeededEvent;
    FOnSectionChange: TSectionChangeEvent;
    FOnSectionCreate: TElHeaderSectionEvent;
    FOnHeaderLookup: TElHeaderLookupEvent;
    FOnHeaderLookupDone: TElHeaderLookupDoneEvent;
    FOnSectionExpand: TElHeaderSectionEvent;
    FOnSectionCollapse: TElHeaderSectionEvent;
    FOnMeasureSection: TMeasureSectionEvent;
    FDefaultWidth: Integer;

    FOnImageNeeded: TElHTMLImageNeededEvent;

    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}
    FMultiSort: Boolean;
    FFixedColNum: Integer;
    FColumnsWidth: Integer;

    procedure CancelOldRightAlignedOrder;virtual;
    function GetLockedSection: TElHeaderSection;
    procedure DrawLine(Restore: boolean);

    procedure AllocateLineDC;
    procedure ReleaseLineDC;

    function GetColumnsWidth: integer; virtual;
    procedure RecalcColumnsWidth; virtual;
    procedure InvalidateRight(value: integer); virtual;
    procedure SetTracking(newValue: boolean);

    procedure IntMouseEnter;
    procedure IntMouseLeave;
    procedure IntSize;
    procedure IntExit;

    procedure IntLButtonDown(XPos, YPos: SmallInt);virtual;
    procedure IntLButtonUp(XPos, YPos: SmallInt);virtual;
    function  IntRButtonDown(XPos, YPos: SmallInt): boolean;
    function  IntRButtonUp(XPos, YPos: SmallInt): boolean;
    procedure IntMouseMove(XPos, YPos: SmallInt); virtual;
    procedure IntLButtonDblClick(XPos, YPos: SmallInt);
    function  IntHintShow(var HintInfo: THintInfo): Boolean;
    procedure CMDrag(var Message: TCMDrag); message CM_DRAG;
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMRButtonDown(var Msg: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMRButtonUp(var Msg: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure CMHintShow(var Msg: TCMHintShow); message CM_HINTSHOW;
    procedure CMSysColorChange(var Msg: TMessage); message CM_SYSCOLORCHANGE;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMCancelMode(var Msg: TWMCancelMode); message WM_CANCELMODE;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMExit(var Msg: TCMExit); message CM_EXIT;
    procedure SetSections(value: TElHeaderSections);
    procedure SetImages(newValue: TCustomImageList);
    procedure SetAlphaImages(newValue: TCustomImageList);
    procedure OnImageListChange(Sender: TObject);
    procedure GetDragImage(XPos: Integer);virtual;

    procedure SetLookupStyle(Value: TComboBoxStyle);
    procedure SetStorage(newValue: TElIniFile);
//    function RigthAndHaveGutter: Boolean;virtual;
    procedure EditExit(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditChange(Sender: TObject);
    procedure SetStickySections(newValue: Boolean);
    procedure AdjustHeaderHeight; virtual;
    procedure AdjustStickySize(Caller: TElHeaderSection);
    function IsLoading: Boolean;
    procedure SetRightAlignedText(newValue: Boolean);
    procedure SetRightAlignedOrder(newValue: Boolean);virtual;
    procedure SetLockHeight(newValue: Boolean);
    procedure SetFilterColor(newValue: TColor);
    procedure SetActiveFilterColor(newValue: TColor);
    procedure SetFlat(newValue: Boolean);
    function GetIsDesigning: Boolean;
    procedure SetIsDesigning(newValue: Boolean);
    procedure SetInvertSortArrows(newValue: Boolean);
    procedure SetLeftPos(newValue: Integer);
    procedure ImageFormChange(Sender: TObject);
    procedure SetImageForm(newValue: TElImageForm);
    procedure SetLockedSection(newValue: TElHeaderSection);
    procedure CalcFixedColWidth; virtual;
    procedure SetWrapCaptions(newValue: Boolean); virtual;

    procedure RedrawSection(Canvas: TCanvas; Section: TElHeaderSection; R: TRect; xHOffs: integer; Dithered: Boolean); virtual;
    procedure RedrawSections; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function  CreateSections: TElHeaderSections; virtual;
    function  InResizeArea(AX: integer; var AHitSection: TElHeaderSection): boolean; virtual;

    procedure Paint; override;

    procedure Resize; override;
    function DoGetPicture(Section: TElHeaderSection): integer; virtual;
    procedure DoVisChanged(Section: TElHeaderSection); virtual;
    procedure DoSectionDelete(Section: TElHeaderSection); virtual;
    procedure DoSectionMove(Section: TElHeaderSection; OldPos, NewPos: integer); virtual;
    procedure DoSectionReindex(Section: TElHeaderSection; OldIndex, NewIndex: integer); virtual;
    procedure DoSectionResizing(Section: TElHeaderSection; State: TElHResizingStates; NewWidth: integer); virtual;
    procedure DoSectionResize(Section: TElHeaderSection); virtual;
    procedure DoSectionClick(Section: TElHeaderSection); virtual;
    procedure DoSectionDraw(Canvas: TCanvas; Section: TElHeaderSection; R: TRect; Pressed: boolean); virtual;
    procedure DoNotifySectionChange(Section: TElHeaderSection; Change: TSectionChangeMode); virtual;
    procedure DoSectionExpandEvent(Section: TElHeaderSection); virtual;
    procedure DoSectionCollapseEvent(Section: TElHeaderSection); virtual;
    procedure DoSectionCreate(Section: TElHeaderSection); virtual;
    procedure DoSectionLookupEvent(Section: TElHeaderSection; var Text: TElFString); virtual;
    procedure DoSectionLookupDoneEvent(Section: TElHeaderSection; Text: TLMDString; Accepted: boolean); virtual;
    procedure TriggerSectionAutoSizeEvent(Section: TElHeaderSection); virtual;
    procedure TriggerFilterCallEvent(Section: TElHeaderSection); virtual;
    procedure TriggerMeasureSectionEvent(Section: TElHeaderSection; var Size: TPoint); virtual;

    procedure OnFontChange(Sender: TObject);
    function GetResizableWidth: integer;virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure TriggerImageNeededEvent(Sender: TObject; Src: TLMDString; var Image :
        TBitmap); virtual;
    procedure TriggerImageNeededExEvent(Sender : TObject; Src : TLMDString; Image : TPicture); virtual;

    procedure CreateHandle; override;
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
//    function GetThemedClassName: TLMDThemedItem; override;
    function GetThemedElement: TThemedElement; override;
    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    {$endif}

    procedure SetFixedColNum(Value: Integer);virtual;
    function GetFixedColNum: Integer;virtual;
    property LookupStyle: TComboBoxStyle read FLookupStyle write SetLookupStyle default csDropDown;
    property SectionsWidth: integer read GetColumnsWidth;
    property Sections: TElHeaderSections read FSections write SetSections;
    property ResizeOnDrag: boolean read FResizeOnDrag write FResizeOnDrag default False;
    property Tracking: boolean read FTracking write SetTracking default True;
    property AllowDrag: boolean read FAllowDrag write FAllowDrag default True;

    property Images: TCustomImageList read FImages write SetImages; { Published }
    property AlphaForImages: TCustomImageList read FAlphaImages write SetAlphaImages; { Published }

    property MoveOnDrag: Boolean read FMoveOnDrag write FMoveOnDrag default False; { Published }

    property StoragePath: string read FStoragePath write FStoragePath;
    property Storage: TElIniFile read FStorage write SetStorage;

    property StickySections: Boolean read FStickySections write SetStickySections default False;
    property RightAlignedText: Boolean read FRightAlignedText write SetRightAlignedText default False;
    property RightAlignedOrder: Boolean read FRightAlignedOrder write SetRightAlignedOrder default False;
    property LockHeight: Boolean read FLockHeight write SetLockHeight default False; { Protected }
    property FilterColor: TColor read FFilterColor write SetFilterColor default clBtnText; { Protected }
    property ActiveFilterColor: TColor read FActiveFilterColor write SetActiveFilterColor default clBlack; { Published }

    property ImageForm: TElImageForm read FImgForm write SetImageForm;

    property OnSectionChange: TSectionChangeEvent read FOnSectionChange
      write FOnSectionChange;

    property OnSectionShowHide: TElHeaderSectionEvent read FOnVisibleChange
      write FOnVisibleChange;
    property OnSectionClick: TElHeaderSectionEvent read FOnSectionClick
      write FOnSectionClick;
    property OnSectionResize: TElHeaderSectionEvent read FOnSectionResize
      write FOnSectionResize;
    property OnSectionDraw: TElSectionRedrawEvent read FOnSectionDraw
      write FOnSectionDraw;
    property OnSectionDelete: TElHeaderSectionEvent read FOnSectionDelete
      write FOnSectionDelete;
    property OnSectionResizing: TElSectionResizingEvent read FOnSectionResizing
      write FOnSectionResizing;
    property OnSectionMove: TElSectionMoveEvent read FOnSectionMove
      write FOnSectionMove;
    property OnSectionReindex: TElSectionMoveEvent read FOnSectionReindex
      write FOnSectionReindex;
    property OnPictureNeeded: TPictureNeededEvent read FOnPictureNeeded
      write FOnPictureNeeded;
    property OnSectionCreate: TElHeaderSectionEvent read FOnSectionCreate
      write FOnSectionCreate;
    property OnSectionExpand: TElHeaderSectionEvent read FOnSectionExpand
      write FOnSectionExpand;
    property OnSectionCollapse: TElHeaderSectionEvent read FOnSectionCollapse
      write FOnSectionCollapse;
    property OnHeaderLookup: TElHeaderLookupEvent read FOnHeaderLookup
      write FOnHeaderLookup;
    property OnHeaderLookupDone: TElHeaderLookupDoneEvent read FOnHeaderLookupDone
      write FOnHeaderLookupDone;
    property OnMeasureSection: TMeasureSectionEvent read FOnMeasureSection write FOnMeasureSection;

    property OnSectionAutoSize: TElHeaderSectionEvent read FOnSectionAutoSize write FOnSectionAutoSize;
    property OnFilterCall: TElHeaderSectionEvent read FOnFilterCall write FOnFilterCall;
    property Flat: Boolean read FFlat write SetFlat default False; { Protected }
    property IsDesigning: Boolean read GetIsDesigning write SetIsDesigning;  { Protected }
    property InvertSortArrows: Boolean read FInvertSortArrows write SetInvertSortArrows default False;  { Protected }
    property DefaultWidth: Integer read FDefaultWidth write FDefaultWidth default
        DefaultHeaderSectionWidth;

    property MultiSort: Boolean read FMultiSort write FMultiSort default False;
    property WrapCaptions: Boolean read FWrapCaptions write SetWrapCaptions default False;  { Published }

    property OnHTMLImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnHTMLImageNeededEx: TLMDHTMLImageNeededEvent read FOnImageNeededEx write FOnImageNeededEx;
  public
      { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetSectionAt(X, Y: integer): TElHeaderSection; virtual;
    function GetSectionAtEx(X, Y: integer; var SectionPart: TElSectionPart): TElHeaderSection; virtual;
    function GetSectionRect(SectionNum: integer): TRect;virtual;
    function MeasureSectionWidth(Section: TElHeaderSection; TextWidth:PInteger;SectionHeight: PInteger): integer; virtual;
    function CalcHeaderHeight: integer; virtual;

    property Canvas;
    procedure Loaded; override;
    {$ifndef LMDDISABLE_ELHEADER_SETUP}
    function Setup: boolean;
    {$endif}
    procedure Save;
    procedure Restore;

    procedure Update; override;

    procedure BeginUpdate;
    procedure EndUpdate;
    procedure MarkStickySections;virtual;
    procedure ResetUpdateCounter;
    property LeftPos: Integer read FHPos write SetLeftPos;  { Public }

    property LockedSection: TElHeaderSection read GetLockedSection write SetLockedSection;  { Public }
    property FixedColWidth: Integer read FFixedColWidth;
    property FixedColNum: Integer read GetFixedColNum write SetFixedColNum;

  published
    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
  end;

  TElHeader = class(TCustomElHeader)
  published
    property ActiveFilterColor;
    property AllowDrag;
    property Align default alTop;
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
    //        property FixClick; // Left for future
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
    property Sections;
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
    property OnSectionReindex;
    property OnSectionShowHide;
    property OnPictureNeeded;
    property OnSectionChange;
    property OnSectionCreate;
    property OnSectionExpand;
    property OnSectionCollapse;
    property OnHeaderLookup;
    property OnHeaderLookupDone;

    property OnHTMLImageNeeded;
    property OnHTMLImageNeededEx;

    property OnSectionAutoSize;
    property OnFilterCall;

    property OnStartDock;
    property OnEndDock;
    property OnContextPopup;

  end;

const
  ResizeWidth = 5;

var ElHeaderAscBmp,
    ElHeaderDescBmp,
    ElHeaderLeftBmp,
    ElHeaderRightBmp,
    ElHeaderPointBmp: TBitmap;

implementation
{$ifndef LMDDISABLE_ELHEADER_SETUP}
  uses
    frmHdrStp;
{$else}
  {$endif}

// =============================================================================

constructor TElHeaderSection.Create;
begin
  inherited Create;
  FStyle := ElhsText;
  FVisible := True;
  FOwner := AOwner;
  FWidth := AOwner.DefaultWidth;
  FMinWidth := 0;
  FMaxWidth := 10000;
  FAlignment := hsaLeft;
  FAllowClick := True;
  FResizable := True;
  FClickSelect := True;
  FLookupHist := TLMDMemoryStrings.Create;
  FParentColor := True;
  FSaveSize := -1;
  FTextLayout := tlCenter;
  FShowSortMark := True;
  FieldType := sftText;
  FImageIndex := -1;
end;

procedure TElHeaderSection.UpdateSection;
var
  R: TRect;
begin
  if (not Visible) or (not FOwner.HandleAllocated) then Exit;
  FOwner.BeginUpdate;
  try
  R := Rect(Left, Top, Left + FWidth, Bottom + 1);
  OffsetRect(R, -FOwner.FHPos, 0);
  InvalidateRect(FOwner.Handle, @R, False);
  finally
    FOwner.EndUpdate;
  end;
  //FOwner.Refresh;
end;

procedure TElHeaderSection.SetSortMode(value: TElSSortMode);
var
  i: integer;
begin
  if FSortMode = value then Exit;

  if not FOwner.MultiSort then

    for i := 0 to FOwner.FSections.Count - 1 do
      FOwner.FSections[i].FSortMode := hsmNone;
  FSortMode := value;
  if AutoSize then
     FOwner.TriggerSectionAutoSizeEvent(Self);
  if (not FOwner.HandleAllocated) then Exit;
  if FShowSortMark then
    FOwner.Invalidate;//Repaint;
end;

procedure TElHeaderSection.SetMaxWidth(value: integer);
begin
  if value = FMaxWidth then Exit;
  FMaxWidth := value;
  if FWidth > FMaxWidth then Width := FMaxWidth;
end;

procedure TElHeaderSection.SetMinWidth(value: integer);
begin
  if value = FMinWidth then Exit;
  FMinWidth := value;
  if FWidth < FMinWidth then Width := FMinWidth;
end;

procedure TElHeaderSection.SetWidth(Value: integer);
begin
  if FWidth = Value then
    Exit;
  DoSetWidth(Value);
  FOwner.DoSectionResize(Self);
end;

procedure TElHeaderSection.SetLookupEnabled(newValue: boolean);
begin
  if FLookupEnabled <> newValue then
  begin
    FLookupEnabled := newValue;
    if newValue then
    begin
      // FFilterEnabled := False;
      with FOwner do
      begin
        if (Height > 0) and (Height < 17) then Height := 17;
      end;
    end;
    if AutoSize then
       FOwner.TriggerSectionAutoSizeEvent(Self);
    UpdateSection;
  end;
end;

function TElHeaderSection.GetVisible: boolean;
begin
  if FParentSection = nil then
    Result := FVisible
  else
    Result := FVisible and FParentSection.Visible and FParentSection.Expanded;
end;

procedure TElHeaderSection.SetVisible;
var
  ns, k, i: integer;
  HS: TElHeaderSection;
begin
  if FVisible <> Value then
  begin
    FOwner.BeginUpdate;
    try
      if (not FOwner.FStickySections) or ((Self.FParentSection <> nil) and (not FParentSection.Visible)) or (FOwner.FInStick) or (FOwner.IsLoading) then
      begin
        FVisible := value;
        FOwner.AdjustHeaderHeight;
        if (not FOwner.FInStick) and ((ParentSection = nil) or (ParentSection.Visible)) then
        begin
          FOwner.InvalidateRight(Index);
          //FOwner.Refresh;
        end;
      end
      else
      begin
        if Value then
          ns := - Width
        else
          ns := Width;
        FVisible := value;
        k := 0;
        for i := Position + 1 to FOwner.Sections.Count - 1 do
          if FOwner.FSections.ItemByPos[i].Visible and FOwner.FSections.ItemByPos[i].Resizable then
            k := k + 1;
        k := max(k, 1);
        for i := Position + 1 to FOwner.Sections.Count - 1 do // Iterate
        begin
          HS := FOwner.FSections.ItemByPos[i];
          if HS.Resizable then
          begin
            HS.FWidth := max(HS.FWidth + Round(ns/k), HS.FMinWidth);
            HS.FWidth := min(HS.FWidth, HS.FMaxWidth);
          end;
        end; // for
        FOwner.AdjustStickySize(Self);
        FOwner.MarkStickySections;
      end;
      if (FOwner.HandleAllocated) then
        FOwner.Invalidate;//Repaint;
      FOwner.DoVisChanged(self);
    finally
      FOwner.EndUpdate;
    end;
  end;
end;

function TElHeaderSection.GetWidth: integer;
begin
  Result := FWidth;
  //if FOwner.FLockedSection <> self then Result := FWidth else Result := 0;
end;

function TElHeaderSection.GetLeft: integer;
var
  ind: integer;
  LWidth: integer;
begin
  ind := FOwner.Sections.FList.IndexOf(self);
  if not Visible then
    LWidth := 0
  else
    LWidth := FWidth;
  if Owner.RightAlignedOrder then
  begin
    if ind <= 0 then
      if GetLocked then
        Result := FOwner.Width - LWidth
      else
        Result := max(FOwner.FColumnsWidth, FOwner.Width) - LWidth
    else
      if (ind = Owner.FFixedColNum) then
        Result := max(FOwner.FColumnsWidth, FOwner.Width) - LWidth - Owner.FFixedColWidth
      else
        Result := TElHeaderSection(FOwner.FSections.FList[ind - 1]).Left - LWidth;
  end
  else
  begin
    if ind <= 0 then
      Result := 0
    else
      Result := TElHeaderSection(FOwner.FSections.FList[ind - 1]).Right;
  end;
end;

function TElHeaderSection.GetRight: integer;
var
  i: integer;
  ind: integer;
begin
  ind := FOwner.FSections.FList.IndexOf(self);
  if Owner.RightAlignedOrder then
  begin
    if ind = 0 then
      if GetLocked then
        Result := FOwner.Width
      else
        Result := max(FOwner.FColumnsWidth, FOwner.Width)
    else
      if (ind = Owner.FFixedColNum) then
        Result := max(FOwner.FColumnsWidth, FOwner.Width) - Owner.FFixedColWidth
      else
      Result := TElHeaderSection(FOwner.FSections.FList[ind - 1]).Left;
  end
  else
  begin
    if ind = 0 then
      i := 0
    else
      i := TElHeaderSection(FOwner.FSections.FList[ind - 1]).Right;
    if Visible then
      Result := i + FWidth
    else
      Result := i;
  end;
end;

procedure TElHeaderSection.SetText(value: TLMDString);
begin
  if FText = value then Exit;
  FText := value;
  if AutoSize then
     FOwner.TriggerSectionAutoSizeEvent(Self);
  FOwner.AdjustHeaderHeight;
  if FStyle = ElhsText then
     UpdateSection;
  FOwner.DoNotifySectionChange(self, scmCaption);
end;

procedure TElHeaderSection.SetStyle(value: TElSectionStyle);
begin
  if FStyle = value then Exit;
  FStyle := value;
  FOwner.DoNotifySectionChange(self, scmStyle);
  UpdateSection;
end;

procedure TElHeaderSection.SetAlignment(value: TElSAlignment);
begin
  if FAlignment = value then Exit;
  FAlignment := value;
  FOwner.DoNotifySectionChange(self, scmAlign);
  UpdateSection;
end;

function TElHeaderSection.GetIndex: integer;
begin
  Result := FIndex;
end;

procedure TElHeaderSection.Assign(source: TPersistent);
var
  THS: TElHeaderSection;
begin
  if Source is TElHeaderSection then
  begin
    THS := TElHeaderSection(source);
    FFieldType := THS.FFieldType;
    FHint := THS.Hint;
    FVisible := THS.FVisible;
    FStyle := THS.FStyle;
    FText := THS.FText;
    FWidth := THS.FWidth;
    FTag := THS.FTag;
    FMinWidth := THS.FMinWidth;
    FMaxWidth := THS.FMaxWidth;
    FSortMode := THS.FSortMode;
    FAllowClick := THS.FAllowClick;
    FAlignment := THS.FAlignment;
    FExpandable := THS.FExpandable;
    FExpanded := THS.FExpanded;
    if THS.FParentSection = nil then
      FParentSection := nil
    else
      FParentSection := FOwner.Sections.Item[THS.FParentSection.Index];
    FPopupMenu := THS.PopupMenu;
    FPopupName := THS.FPopupName;
    FLookupEnabled := THS.FLookupEnabled;
    FUseMainStyle := THS.FUseMainStyle;
    FTextLayout := THS.FTextLayout;
    FFilterEnabled := THS.FFilterEnabled;
    FParentColor := THS.FParentColor;
    FFontColor := THS.FFontColor;
    FColor := THS.FColor;
    FAutoSize := THS.FAutoSize;
    FHint := THS.FHint;
    FFieldName := THS.FFieldName;
    FPicAlign := THS.FPicAlign;
    FResizable := THS.FResizable;
    FClickSelect := THS.FClickSelect;
    FProtected := THS.FProtected;
    FImageIndex := THS.FImageIndex;
    FEditable := THS.FEditable;
    FShowSortMark := THS.FShowSortMark;
    // FIndex := THS.FIndex;
  end
  else
    inherited;
end;

function TElHeaderSection.GetPosition: Integer;
{ Returns the value of data member FPosition. }
begin
  Result := -1;
  if FOwner <> nil then Result := FOwner.FSections.FList.IndexOf(self);
end; { GetPosition }

procedure TElHeaderSection.SetImageIndex(newValue: Integer);
{ Sets data member FImageIndex to newValue. }
begin
  if (FImageIndex <> newValue) then
  begin
    FImageIndex := newValue;
    if AutoSize then
       FOwner.TriggerSectionAutoSizeEvent(Self);
    UpdateSection;
  end; { if }
end; { SetImageIndex }

procedure TElHeaderSection.SetResizable(newValue: boolean);
begin
  FResizable := newValue;
  if Assigned(FOwner) then
    if FOwner.FStickySections then FOwner.SetStickySections(True);
end;

procedure TElHeaderSection.SetSaveSize(newValue: integer);
begin
  ASaveSize := newValue;
end;

procedure TElHeaderSection.SetEditable(newValue: boolean);
begin
  if FEditable <> newValue then
  begin
    FEditable := newValue;
    FOwner.DoNotifySectionChange(self, scmEditable);
  end;
end;

procedure TElHeaderSection.SetIndex(Value: integer);
begin
  FIndex := Value;
end;

procedure TElHeaderSection.SetFieldName(newValue: string);
{ Sets data member FFieldName to newValue. }
begin
  if (FFieldName <> newValue) then
  begin
    FFieldName := newValue;
    FOwner.DoNotifySectionChange(self, scmFieldName);
  end; { if }
end; { SetFieldName }

procedure TElHeaderSection.SetFieldType(newValue: TElFieldType);
{ Sets data member FFieldType to newValue. }
begin
  if (FFieldType <> newValue) then
  begin
    FFieldType := newValue;
    FOwner.DoNotifySectionChange(self, scmFieldType);
  end; { if }
end; { SetFieldType }

procedure TElHeaderSection.SetProtected(newValue: Boolean);
{ Sets data member FProtected to newValue. }
begin
  if (FProtected <> newValue) then
  begin
    FProtected := newValue;
    FOwner.DoNotifySectionChange(self, scmPassword);
  end; { if }
end; { SetProtected }

procedure TElHeaderSection.SetExpandable(newValue: Boolean);
var
  i: integer;
  b: boolean;
begin
  if (FExpandable <> newValue) then
  begin
    b := False;
    FExpandable := newValue;
    if not FExpandable then
      for i := 0 to FOwner.FSections.Count - 1 do
      begin
        if TElHeaderSection(FOwner.FSections.FList[i]).FParentSection = Self then
        begin
          TElHeaderSection(FOwner.FSections.FList[i]).FParentSection := nil;
          b := True;
        end;
      end;
      if AutoSize then
         FOwner.TriggerSectionAutoSizeEvent(Self);
    if b and (not (csDestroying in FOwner.ComponentState)) and (FOwner.HandleAllocated) then
      FOwner.Invalidate;//Repaint;
  end; {if}
end;

procedure TElHeaderSection.SetExpanded(newValue: Boolean);
begin
  if (FExpanded <> newValue) and Expandable then
  begin
    if (FExpandable and newValue) or (not newValue) then
    begin
      FExpanded := newValue;
      if (FOwner.HandleAllocated) then
        FOwner.Invalidate;//Repaint;
    end;
  end; {if}
end;

function TElHeaderSection.GetParentSection: TElHeaderSection;
begin
  Result := FParentSection;
end;

procedure TElHeaderSection.SetParentSection(newValue: TElHeaderSection);
var
  S: TElHeaderSection;
begin
  if (FParentSection <> newValue) then
  begin
    S := newValue;
    while S <> nil do
    begin
      if S = Self then Exit;
      S := S.FParentSection;
    end;
    FParentSection := newValue;
    FOwner.DoVisChanged(Self);
    FOwner.AdjustHeaderHeight;
    if (FOwner.HandleAllocated) then
      FOwner.Invalidate;//Repaint;
  end; {if}
end;

procedure TElHeaderSection.SetPopupMenu(newValue: TPopupMenu);
begin
  if (FPopupMenu <> newValue) then
  begin
    FPopupMenu := newValue;
    FPopupName := FPopupMenu.Name;
  end; {if}
end;

procedure TElHeaderSection.SetParentColor(newValue: Boolean);
begin
  if (FParentColor <> newValue) then
  begin
    FParentColor := newValue;
    UpdateSection;
  end; {if}
end;

procedure TElHeaderSection.SetColor(newValue: TColor);
begin
  if (FColor <> newValue) then
  begin
    FColor := newValue;
    ParentColor := False;
    UpdateSection;
  end; {if}
end;

procedure TElHeaderSection.SetFontColor(newValue: TColor);
begin
  if (FFontColor <> newValue) then
  begin
    FFontColor := newValue;
    ParentColor := False;
    UpdateSection;
  end; {if}
end;

procedure TElHeaderSection.SetHint(const Value: TLMDString);
begin
  FHint := Value+#0;
end;

procedure TElHeaderSection.SetUseMainStyle(newValue: Boolean);
begin
  if (FUseMainStyle <> newValue) then
  begin
    FUseMainStyle := newValue;
    if Assigned(FOwner.Parent) and (FOwner.Parent.HandleAllocated) then
      FOwner.Parent.Invalidate;//Repaint;
  end; {if}
end;

procedure TElHeaderSection.SetTextLayout(newValue: TTextLayout);
begin
  if (FTextLayout <> newValue) then
  begin
    FTextLayout := newValue;
    UpdateSection;
  end; {if}
end;

procedure TElHeaderSection.SetFilterEnabled(newValue: Boolean);
begin
  if (FFilterEnabled <> newValue) then
  begin
    FFilterEnabled := newValue;
    if newValue then
    begin
      // FLookupEnabled := False;
      with FOwner do
      begin
        if (Height > 0) and (Height < 17) then Height := 17;
      end;
    end;
    if AutoSize then
       FOwner.TriggerSectionAutoSizeEvent(Self);
    UpdateSection;
  end; { if }
end; { SetFilterEnabled }

procedure TElHeaderSection.SetAutoSize;
begin
  if FAutoSize <> newValue then
  begin
    FAutoSize := newValue;
    if newValue then
       FOwner.TriggerSectionAutoSizeEvent(Self);
  end;
end;

procedure TElHeaderSection.SetLookupList(newValue: TLMDMemoryStrings);
begin
  FLookupHist.Assign(newValue);
end;

procedure TElHeaderSection.SetFilterIsActive(newValue: Boolean);
{ Sets data member FFilterApplied to newValue. }
begin
  if (FFilterIsActive <> newValue) then
  begin
    FFilterIsActive := newValue;
    if FFilterEnabled then UpdateSection;
  end; { if }
end; { SetFilterApplied }

function TElHeaderSection.GetLocked: boolean;
begin
  Result := Index < FOwner.FixedColNum;
end;

function TElHeaderSection.GetOwner: TPersistent; { protected }
begin
  Result := FOwner.Sections;
end; { GetOwner }

destructor TElHeaderSection.Destroy;
begin
  Expandable := False;
  FLookupHist.Free;
  inherited;
end;

procedure TElHeaderSection.SetShowSortMark(Value: Boolean);
begin
  if FShowSortMark <> Value then
  begin
    FShowSortMark := Value;
    if Self.SortMode <> hsmNone then
      UpdateSection;
  end;
end;

procedure TElHeaderSection.ShowLookup;
var
  R: TRect;
begin
  with FOwner do
  begin
    if Flookup <> nil then
      FLookup.Text := ''
    else
    begin
      Flookup := TElComboBox.Create(nil);
      TElComboBox(FLookup).Flat := Flat;
      TElComboBox(FLookup).ActiveBorderType := fbtSunkenOuter;
      FLookup.Visible := False;
      FLookup.Style := FLookupStyle; //csDropDown
    end;
    FLookup.Parent := Parent;//Self;
    FLookup.OnExit := EditExit;
    FLookup.OnKeyDown := EditKeyDown;
    FLookup.OnChange := EditChange;
    FLookup.OnKeyUp := EditKeyUp;
    FLookup.Items.Assign(Self.FLookupHist);
    FLookupSection := Self;
    R := GetSectionRect(Self.Index);
    FLookup.BoundsRect := R;
    FLookup.Font.Assign(Font);
    FLookup.Font.Height := Abs(Font.Height) - 2;
    if Font.Height < 0 then
      FLookup.Font.Height := -FLookup.Font.Height;

    FLookup.Height := Max(FLookup.Height, R.Bottom - R.Top - 2);
    FDoingLookup := True;
    FLookup.Visible := True;
    FFocusedCtl := Windows.GetFocus;
    FLookup.SetFocus;
  end;
end;

procedure TElHeaderSection.DoSetWidth(Value: integer);
var
  diff, i, wo, wn: integer;
  HS, LS: TElHeaderSection;
  Form: TCustomForm;
begin
  if (value > FMaxWidth) or (value < FMinWidth) then Exit;
  if (not FOwner.FStickySections) or (not Visible) or (FOwner.FInStick) or (FOwner.IsLoading) then
  begin
    FWidth := value;
    if Visible and (not FOwner.FInStick) then
    begin
      FOwner.AdjustHeaderHeight;
      if (FOwner.HandleAllocated) then
        FOwner.Invalidate;
      //FOwner.InvalidateRight(Self.Index);
      //FOwner.Refresh;
    end;
  end
  else
  if Visible then
  begin
    if Position = FOwner.FSections.Count - 1 then
    begin
      // the last section, do nothing (we can't resize it)
    end
    else
    begin
      if Owner.RightAlignedOrder then
      begin
        wo := Left;
        if wo = 0 then wo := 1;
        wn := Left + FWidth - Value;
      end
      else
      begin
        wo := FOwner.Width - (Left + FWidth);
        if wo = 0 then wo := 1;
        wn := FOwner.Width - (Left + Value);
      end;
      Ls := nil;
      if wn > 0 then
      begin
        for i := Position + 1 to FOwner.Sections.Count - 1 do // Iterate
        begin
          HS := FOwner.FSections.ItemByPos[i];
          if HS.Resizable and HS.Visible then
          begin
            HS.FWidth := max(HS.FMinWidth, Round((HS.Width / wo) * wn));
            HS.FWidth := min(HS.FWidth, HS.FMaxWidth);
            LS := HS;
          end;
        end; // for
        FWidth := value
      end
      else
      begin
        diff := FOwner.Width - Left;
        for i := Position + 1 to FOwner.Sections.Count - 1 do // Iterate
        begin
          HS := FOwner.FSections.ItemByPos[i];
          if HS.Resizable and HS.Visible then
          begin
            HS.FWidth := HS.FMinWidth;
            diff := diff - HS.FWidth;
          end;
        end;
        FWidth := max(FMinWidth, diff);
      end;
      if (LS <> nil) then
      begin
        diff := FOwner.Width - FOwner.SectionsWidth;
        if diff > 0 then
          LS.FWidth := LS.FWidth + diff;
      end;
      FOwner.AdjustStickySize(Self);
    end;
    FOwner.MarkStickySections;
    if Visible and (not FOwner.FInStick) then
    begin
      FOwner.InvalidateRight(Index);
      //FOwner.Refresh;
    end;
  end;
  Form := GetParentForm(FOwner);
  if (Form <> nil) and (Form.Designer <> nil) and (csDesigning in Form.ComponentState) then
    Form.Designer.Modified;
end;

// =============================================================================

constructor TElHeaderSections.Create(AOwner: TCustomElHeader);
begin
  inherited Create;
  FOwner := AOwner;
  FList := TLMDObjectList.Create;
  FForceReindexInAssign := true;
end;

destructor TElHeaderSections.Destroy;
begin
  while FList.Count > 0 do
  begin
    TElHeaderSection(FList[0]).Free;
    FList.Delete(0);
  end;
  FList.Free;
  inherited destroy;
end;

procedure TElHeaderSections.Clear;
begin
  while FList.Count > 0 do
  begin
    TElHeaderSection(FList[0]).Free;
    FList.Delete(0);
  end;
end;

procedure TElHeaderSections.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('Data', FrameReadData, WriteData, True);
end;

function TElHeaderSections.CreateSection: TElHeaderSection;
begin
  Result := TElHeaderSection.Create(FOwner);
end;

function TElHeaderSections.AddSection: TElHeaderSection;
begin
  Result := InsertSection(FList.Count);
end;

function TElHeaderSections.InsertSection(index: integer): TElHeaderSection;
var
  i: integer;
begin
  FOwner.BeginUpdate;
  try
    Result := CreateSection;
    i := 0;
    while Assigned(FindSection(i)) do
      Inc(i);
    Result.FIndex := i;

    Result.FIntTag := TLMDPtrInt(Pointer(Result));

    while Self.GetSectionByIntTag(Result.FIntTag) <> nil do
      Inc(Result.FIntTag);
    Result.FOwner := FOwner;
//    if FOwner.RightAlignedOrder then
//     index := min(Count + 1 - index, FList.Count);
    FList.Insert(index, Result);
    FOwner.InvalidateRight(i);
    if FOwner.FUpdateCount = 0 then
      FOwner.DoSectionCreate(Result)
    else
      FOwner.AdditionHappened := True;
  finally
    FOwner.EndUpdate;
  end;
end;

procedure TElHeaderSections.DeleteSection(Section: TElHeaderSection);
var
  i: integer;
begin
  FOwner.BeginUpdate;
  try
    if Section = nil then raise EElHeaderError.Create('Invalid section');

//  if FOwner.FLockedSection = Section then
//    FOwner.LockedSection := nil;

    if FOwner.FTrackSection = Section then
      FOwner.FTrackSection := nil;
    FList.Remove(Section);
  //  if FOwner.FRightAlignedOrder then
  //   for i := 0 to FList.Count - 1 do
  //      TElHeaderSection(FList[i]).FIndex := FList.Count - 1 - i
  //  else
    for i := 0 to FList.Count - 1 do
      TElHeaderSection(FList[i]).FIndex := i;

    if FOwner.FUpdateCount = 0 then
      FOwner.DoSectionDelete(Section)
    else
      FOwner.DeletionHappened := True;
    Section.Free;
    if (FOwner.HandleAllocated) then
      FOwner.Invalidate;
  finally
    FOwner.EndUpdate;
  end;
end;

procedure TElHeaderSections.MoveSection(Section: TElHeaderSection; NewPos: integer);
var
  i: integer;
begin
  FOwner.BeginUpdate;
  try

  if Section.Locked and (NewPos >= FOwner.FixedColNum) then
    Exit;
  if (NewPos < FOwner.FFixedColNum) and not Section.Locked then
    NewPos := FOwner.FFixedColNum;

  i := FList.IndexOf(Section);
  FList.Move(i, NewPos);
  FOwner.DoSectionMove(TElHeaderSection(FList[i]), i, NewPos);
  if (FOwner.HandleAllocated) then
    FOwner.Invalidate;
  finally
    FOwner.EndUpdate;
  end;
end;

function TElHeaderSections.GetCount: integer;
begin
  Result := FList.Count;
end;

procedure TElHeaderSections.SetSection(index: integer; Section: TElHeaderSection);
begin

end;

function TElHeaderSections.GetSectionByIntTag(IntTag: integer): TElHeaderSection;
var
  i: integer;
begin
  for i := 0 to FList.Count - 1 do
  begin
    Result := TElHeaderSection(FList[i]);
    if Result.FIntTag = IntTag then
      Exit;
  end;
  Result := nil;
end;

function TElHeaderSections.GetSection(index: integer): TElHeaderSection;
begin
  Result := FindSection(index);
end;

function TElHeaderSections.GetSectionByPos(index: integer): TElHeaderSection;
begin
  Result := TElHeaderSection(FList[index]);
end;

type

  PSectionPersistInfo = ^TSectionPersistInfo;
  TSectionPersistInfo = record
    FFakeProperty1: Integer;
    FLookupEnabled: boolean;
    FParentIdx: integer;
    FExpandable: Boolean;
    FExpanded: Boolean;
    FVisible: boolean;
    FClickSel: boolean;
    FResizable: boolean;
    FStyle: TElSectionStyle;
    FWidth: integer;
    FMinWidth: integer;
    FMaxWidth: integer;
    FSortMode: TElSSortMode;
    FAllowClick: boolean;
    FAlignment: TElSAlignment;
    FIntTag: integer;
    FIndex: integer;
    FFieldType: TElFieldType;
    FEditable: Boolean;
    FImageIndex: Integer;
    FPicAlign: TElSAlignment;
    FPassword: boolean;
    FParentColor: boolean;
    FColor: TColor;
    FFontColor: TColor;
    FFilterEnabled: boolean;
    FTextLayout: TTextLayout;
    FUseMainStyle: boolean;
    FAutoSize: boolean;
    FTag: integer;
    FOtherData: array[0..16] of integer;
  end;

  P9SectionData = ^T9SectionData;
  T9SectionData = record
    FFakeProperty1: Integer;
    FLookupEnabled: boolean;
    FParentIdx: integer;
    FExpandable: Boolean;
    FExpanded: Boolean;
    FVisible: boolean;
    FClickSel: boolean;
    FResizable: boolean;
    FStyle: TElSectionStyle;
    FWidth: integer;
    FMinWidth,
      FMaxWidth: integer;
    FSortMode: TElSSortMode;
    FAllowClick: boolean;
    FAlignment: TElSAlignment;
    FIntTag,
    FTag: integer;
    FFieldType: TElFieldType;
    FEditable: Boolean;
    FImageIndex: Integer;
    FPicAlign: TElSAlignment;
    FPassword: boolean;
    FParentColor: boolean;
    FColor, FFontColor: TColor;
    FFilterEnabled: boolean;
    FTextLayout: TTextLayout;
    FUseMainStyle: boolean;
    FAutoSize: boolean;
  end;

  P8aSectionData = ^T8aSectionData;
  T8aSectionData = record
    FFakeProperty1: Integer;
    FLookupEnabled: boolean;
    FParentIdx: integer;
    FExpandable: Boolean;
    FExpanded: Boolean;
    FVisible: boolean;
    FClickSel: boolean;
    FResizable: boolean;
    FStyle: TElSectionStyle;
    FWidth: integer;
    FMinWidth: integer;
    FMaxWidth: integer;
    FSortMode: TElSSortMode;
    FAllowClick: boolean;
    FAlignment: TElSAlignment;
    FTag: integer;
    FFieldType: TElFieldType;
    FEditable: Boolean;
    FImageIndex: Integer;
    FPicAlign: TElSAlignment;
    FPassword: boolean;
    FParentColor: boolean;
    FColor, FFontColor: TColor;
    FFilterEnabled: boolean;
    FTextLayout: TTextLayout;
    FUseMainStyle: boolean;
    FAutoSize: boolean;
  end;

  P8SectionData = ^T8SectionData;
  T8SectionData = record
    FFakeProperty1: Integer;
    FLookupEnabled: boolean;
    FParentIdx: integer;
    FExpandable: Boolean;
    FExpanded: Boolean;
    FVisible: boolean;
    FClickSel: boolean;
    FResizable: boolean;
    FStyle: TElSectionStyle;
    FWidth: integer;
    FMinWidth,
      FMaxWidth: integer;
    FSortMode: TElSSortMode;
    FAllowClick: boolean;
    FAlignment: TElSAlignment;
    FTag: integer;
    FFieldType: TElFieldType;
    FEditable: Boolean;
    FImageIndex: Integer;
    FPicAlign: TElSAlignment;
    FPassword: boolean;
    FParentColor: boolean;
    FColor, FFontColor: TColor;
    FFilterEnabled: boolean;
    FTextLayout: TTextLayout;
    FUseMainStyle: boolean;
  end;

  P7SectionData = ^T7SectionData;
  T7SectionData = record
    FFakeProperty1: Integer;
    FLookupEnabled: boolean;
    FParentIdx: integer;
    FExpandable: Boolean;
    FExpanded: Boolean;
    FVisible: boolean;
    FClickSel: boolean;
    FResiable: boolean;
    FStyle: TElSectionStyle;
    FWidth: integer;
    FMinWidth,
      FMaxWidth: integer;
    FSortMode: TElSSortMode;
    FAllowClick: boolean;
    FAlignment: TElSAlignment;
    FTag: integer;
    FFieldType: TElFieldType;
    FEditable: Boolean;
    FImageIndex: Integer;
    FPicAlign: TElSAlignment;
    FPassword: boolean;
  end;

type
  P5SectionData = ^T5SectionData;
  T5SectionData = record
    FVisible: boolean;
    FStyle: TElSectionStyle;
    FWidth: integer;
    FMinWidth,
      FMaxWidth: integer;
    FSortMode: TElSSortMode;
    FAllowClick: boolean;
    FAlignment: TElSAlignment;
    FTag: integer;
    FFieldType: TElFieldType;
    FEditable: Boolean;
    FImageIndex: Integer;
    FPicAlign: TElSAlignment;
    FPassword: boolean;
  end;

type
  P6SectionData = ^T6SectionData;
  T6SectionData = record
    FVisible: boolean;
    FClickSel: boolean;
    FResiable: boolean;
    FStyle: TElSectionStyle;
    FWidth: integer;
    FMinWidth,
      FMaxWidth: integer;
    FSortMode: TElSSortMode;
    FAllowClick: boolean;
    FAlignment: TElSAlignment;
    FTag: integer;
    FFieldType: TElFieldType;
    FEditable: Boolean;
    FImageIndex: Integer;
    FPicAlign: TElSAlignment;
    FPassword: boolean;
  end;

procedure TElHeaderSections.WriteData(Stream: TStream);
var
  i, j: integer;
  P: PSectionPersistInfo;
  TS: TElHeaderSection;
  P1: PChar;
  S: TLMDString;
begin
  inherited;
  GetMem(P, SizeOf(TSectionPersistInfo));
  // write binary data
  FillMemory(P, sizeof(P^), 0);
  i := -15;
  Stream.WriteBuffer(i, SizeOf(integer));
  i := Count;
  Stream.WriteBuffer(i, SizeOf(integer));
  for i := 0 to FList.Count - 1 do
  begin
    TS := TElHeaderSection(FList[i]);
    P.FLookupEnabled := TS.FLookupEnabled;
    if TS.FParentSection <> nil then
      P.FParentIdx := TS.FParentSection.Index
    else
      P.FParentIdx := -1;
    P.FExpandable := TS.FExpandable;
    P.FExpanded := TS.FExpanded;
    P.FVisible := TS.FVisible;
    P.FStyle := TS.FStyle;
    P.FWidth := TS.FWidth;
    P.FResizable := TS.FResizable;
    P.FClickSel := TS.FClickSelect;
    P.FMinWidth := TS.FMinWidth;
    P.FMaxWidth := TS.FMaxWidth;
    P.FSortMode := TS.FSortMode;
    P.FAllowClick := TS.FAllowClick;
    P.FAlignment := TS.FAlignment;
    P.FIntTag := TS.FIntTag;
    P.FTag := TS.FTag;
    P.FFieldType := TS.FFieldType;
    P.FEditable := TS.FEditable;
    P.FImageIndex := TS.FImageIndex;
    P.FPicAlign := TS.FPicAlign;
    P.FPassword := TS.FProtected;
    P.FParentColor := TS.FParentColor;
    P.FColor := TS.FColor;
    P.FFontColor := TS.FFontColor;
    P.FFilterEnabled := TS.FFilterEnabled;
    P.FTextLayout := TS.FTextLayout;
    P.FUseMainStyle := TS.FUseMainStyle;
    P.FAutoSize := TS.FAutoSize;
    P.FIndex := TS.FIndex;
    Stream.WriteBuffer(p^, SizeOf(TSectionPersistInfo));
    S := TElHeaderSection(FList[i]).Text;
    j := (Length(S) + 1)*SizeOf(Char);
    GetMem(P1, j);
    StrPCopy(P1, S);
    Stream.WriteBuffer(j, SizeOf(integer));
    Stream.WriteBuffer(P1^, j);
    FreeMem(P1, j);
    S := TElHeaderSection(FList[i]).FFieldName;
    j := (Length(S) + 1)*SizeOf(Char);
    GetMem(P1, j);
    StrPCopy(P1, S);
    Stream.WriteBuffer(j, SizeOf(integer));
    Stream.WriteBuffer(P1^, j);
    FreeMem(P1, j);
    LMDAnsiWriteStringToStream(Stream, TS.FPopupName);
    {$ifdef LMD_UNICODE}
    LMDWideWriteStringToStream(Stream, TS.Hint);
    {$else}
    LMDAnsiWriteStringToStream(Stream, TS.Hint);
    {$endif}
  end;
  FreeMem(P);
  end;

procedure TElHeaderSections.ReadData(Stream: TStream);
begin
  IntReadData(Stream, True);
end;

procedure TElHeaderSections.FrameReadData(Stream: TStream);
begin
  IntReadData(Stream, False);
end;

procedure TElHeaderSections.IntReadData(Stream: TStream; ClearCurrent: boolean);
var
  i, j: integer;
  Q: P6SectionData;
  T: PSectionPersistInfo;
  T7: P7SectionData;
  T9: P9SectionData;
  T8a: P8aSectionData;
  T8: P8SectionData;
  P1: PAnsiChar;
  PN1: PChar;
  S: String;
  THS: TElHeaderSection;
  Ver: integer;
  //failed killsection: boolean;
begin
  inherited;
//  Clear;
  Stream.ReadBuffer(i, SizeOf(integer));
  ver := i;
  //failed if ClearCurrent or (ver > -10) then
  Clear;
//  AddSection; // Gutter section
  if ver <= -11 then
  begin
    Stream.ReadBuffer(i, SizeOf(integer));
    New(T);
    while i > 0 do
    begin
      Stream.ReadBuffer(T^, SizeOf(TSectionPersistInfo));
      //failed killsection := (GetSectionByIntTag(T^.FIntTag) <> nil) and (not ClearCurrent);
      THS := AddSection;
      THS.FLookupEnabled := T.FLookupEnabled;
      THS.FExpandable := T.FExpandable;
      THS.FExpanded := T.FExpanded;
      THS.FParentIdx := T.FParentIdx;
      THS.FResizable := T.FResizable;
      THS.FClickSelect := T.FClickSel;
      THS.FVisible := T.FVisible;
      THS.FStyle := T.FStyle;
      THS.FWidth := T.FWidth;
      THS.FMinWidth := T.FMinWidth;
      THS.FMaxWidth := T.FMaxWidth;
      THS.FSortMode := T.FSortMode;
      THS.FAllowClick := T.FAllowClick;
      THS.FAlignment := T.FAlignment;
      THS.FIntTag := T.FIntTag;
      THS.FIndex := T.FIndex;
      THS.FTag := T.FTag;
      THS.FFieldType := T.FFieldType;
      THS.FEditable := T.FEditable;
      THS.FImageIndex := T.FImageIndex;
      THS.FPicAlign := T.FPicAlign;
      THS.FProtected := T.FPassword;
      THS.FTextLayout := T.FTextLayout;
      THS.FUseMainStyle := T.FUseMainStyle;
      THS.FParentColor := T.FParentColor;
      THS.FColor := T.FColor;
      THS.FFontColor := T.FFontColor;
      THS.FFilterEnabled := T.FFilterEnabled;
      THS.FAutoSize := T.FAutoSize;

      // read caption
      Stream.ReadBuffer(j, SizeOf(integer));
      if ver <= -15 then
      begin
        GetMem(PN1, j);
        Stream.ReadBuffer(PN1^, j);
        S := StrPas(PN1);
        FreeMem(PN1, j);
      end
      else
      begin
        GetMem(P1, j);
        Stream.ReadBuffer(P1^, j);
        S := String(StrPas(P1));
        FreeMem(P1, j);
      end;
      THS.FText := S;

      // read field name
      Stream.ReadBuffer(J, SizeOf(integer));
      if ver <= -15 then
      begin
        GetMem(PN1, j);
        Stream.ReadBuffer(PN1^, j);
        S := StrPas(PN1);
        FreeMem(PN1, j);
      end
      else
      begin
        GetMem(P1, j);
        Stream.ReadBuffer(P1^, j);
        S := String(StrPas(P1));
        FreeMem(P1, j);
      end;
      THS.FFieldName := S;
      Dec(i);
      LMDAnsiReadStringFromStream(Stream, THS.FPopupName);
      {$ifdef LMD_UNICODE}
      if ver <= -12 then
        LMDReadStringFromStream(Stream, THS.FHint)
      else
      begin
        LMDAnsiReadStringFromStream(Stream, S);
        THS.FHint := S;
      end;
      {$else}
      LMDReadStringFromStream(Stream, THS.FHint);
      {$endif}
    end;
    Dispose(T);
    for i := 0 to FList.Count - 1 do
      if Item[i].FParentIdx <> -1 then
        Item[i].FParentSection := Item[Item[i].FParentIdx];
  end
  else
  if ver = -10 then
  begin
    Stream.ReadBuffer(i, SizeOf(integer));
    New(T9);
    while i > 0 do
    begin
      Stream.ReadBuffer(T9^, SizeOf(T9SectionData));
      //failed killsection := (GetSectionByIntTag(T^.FIntTag) <> nil) and (not ClearCurrent);
      THS := AddSection;
      THS.FLookupEnabled := T9.FLookupEnabled;
      THS.FExpandable := T9.FExpandable;
      THS.FExpanded := T9.FExpanded;
      THS.FParentIdx := T9.FParentIdx;
      THS.FResizable := T9.FResizable;
      THS.FClickSelect := T9.FClickSel;
      THS.FVisible := T9.FVisible;
      THS.FStyle := T9.FStyle;
      THS.FWidth := T9.FWidth;
      THS.FMinWidth := T9.FMinWidth;
      THS.FMaxWidth := T9.FMaxWidth;
      THS.FSortMode := T9.FSortMode;
      THS.FAllowClick := T9.FAllowClick;
      THS.FAlignment := T9.FAlignment;
      THS.FIntTag := T9.FIntTag;
      THS.FIndex := T9.FTag;
      THS.FFieldType := T9.FFieldType;
      THS.FEditable := T9.FEditable;
      THS.FImageIndex := T9.FImageIndex;
      THS.FPicAlign := T9.FPicAlign;
      THS.FProtected := T9.FPassword;
      THS.FTextLayout := T9.FTextLayout;
      THS.FUseMainStyle := T9.FUseMainStyle;
      THS.FParentColor := T9.FParentColor;
      THS.FColor := T9.FColor;
      THS.FFontColor := T9.FFontColor;
      THS.FFilterEnabled := T9.FFilterEnabled;
      THS.FAutoSize := T9.FAutoSize;

      // read caption
      Stream.ReadBuffer(J, SizeOf(integer));
      GetMem(P1, j);
      Stream.ReadBuffer(P1^, j);
      S := String(StrPas(P1));
      FreeMem(P1, j);
      THS.FText := S;
      // read field name
      Stream.ReadBuffer(J, SizeOf(integer));
      GetMem(P1, j);
      Stream.ReadBuffer(P1^, j);
      S := String(StrPas(P1));
      FreeMem(P1, j);
      THS.FFieldName := S;

      Dec(i);
      LMDAnsiReadStringFromStream(Stream, THS.FPopupName);
      {$ifdef LMD_UNICODE}
      LMDAnsiReadStringFromStream(Stream, S);
      THS.FHint := S;
      {$else}
      LMDReadStringFromStream(Stream, THS.FHint);
      {$endif}
    end;
    Dispose(T9);
    for i := 0 to FList.Count - 1 do
    begin
      if Item[i].FParentIdx <> -1 then
      begin
        Item[i].FParentSection := Item[Item[i].FParentIdx];
      end;
    end;
  end
  else
  if (ver = -9) then
  begin
    Stream.ReadBuffer(i, SizeOf(integer));
    New(T8a);
    while i > 0 do
    begin
      Stream.ReadBuffer(T8A^, SizeOf(T8ASectionData));
      THS := AddSection;
      THS.FLookupEnabled := T8A.FLookupEnabled;
      THS.FExpandable := T8A.FExpandable;
      THS.FExpanded := T8A.FExpanded;
      THS.FParentIdx := T8A.FParentIdx;
      THS.FResizable := T8A.FResizable;
      THS.FClickSelect := T8A.FClickSel;
      THS.FVisible := T8A.FVisible;
      THS.FStyle := T8A.FStyle;
      THS.FWidth := T8A.FWidth;
      THS.FMinWidth := T8A.FMinWidth;
      THS.FMaxWidth := T8A.FMaxWidth;
      THS.FSortMode := T8A.FSortMode;
      THS.FAllowClick := T8A.FAllowClick;
      THS.FAlignment := T8A.FAlignment;
      THS.FIndex := T8A.FTag;
      THS.FFieldType := T8A.FFieldType;
      THS.FEditable := T8A.FEditable;
      THS.FImageIndex := T8A.FImageIndex;
      THS.FPicAlign := T8A.FPicAlign;
      THS.FProtected := T8A.FPassword;
      THS.FTextLayout := T8A.FTextLayout;
      THS.FUseMainStyle := T8A.FUseMainStyle;
      THS.FParentColor := T8A.FParentColor;
      THS.FColor := T8A.FColor;
      THS.FFontColor := T8A.FFontColor;
      THS.FFilterEnabled := T8A.FFilterEnabled;
      THS.FAutoSize := T8A.FAutoSize;

      // read caption
      Stream.ReadBuffer(J, SizeOf(integer));
      GetMem(P1, j);
      Stream.ReadBuffer(P1^, j);
      S := String(StrPas(P1));
      FreeMem(P1, j);
      THS.FText := S;
      // read field name
      Stream.ReadBuffer(J, SizeOf(integer));
      GetMem(P1, j);
      Stream.ReadBuffer(P1^, j);
      S := String(StrPas(P1));
      FreeMem(P1, j);
      THS.FFieldName := S;
      Dec(i);
      LMDAnsiReadStringFromStream(Stream, THS.FPopupName);
      {$ifdef LMD_UNICODE}
      LMDAnsiReadStringFromStream(Stream, S);
      THS.FHint := S;
      {$else}
      LMDReadStringFromStream(Stream, THS.FHint);
      {$endif}
    end;
    Dispose(T8a);
    for i := 0 to FList.Count - 1 do
    begin
      if Item[i].FParentIdx <> -1 then
      begin
        Item[i].FParentSection := Item[Item[i].FParentIdx];
      end;
    end;
  end
  else
  if (ver = -8) then
  begin
    Stream.ReadBuffer(i, SizeOf(integer));
    New(T8);
    while i > 0 do
    begin
      Stream.ReadBuffer(T8^, SizeOf(T8SectionData));
      THS := AddSection;
      THS.FLookupEnabled := T8.FLookupEnabled;
      THS.FExpandable := T8.FExpandable;
      THS.FExpanded := T8.FExpanded;
      THS.FParentIdx := T8.FParentIdx;
      THS.FResizable := T8.FResizable;
      THS.FClickSelect := T8.FClickSel;
      THS.FVisible := T8.FVisible;
      THS.FStyle := T8.FStyle;
      THS.FWidth := T8.FWidth;
      THS.FMinWidth := T8.FMinWidth;
      THS.FMaxWidth := T8.FMaxWidth;
      THS.FSortMode := T8.FSortMode;
      THS.FAllowClick := T8.FAllowClick;
      THS.FAlignment := T8.FAlignment;
      THS.FIndex := T8.FTag;
      THS.FFieldType := T8.FFieldType;
      THS.FEditable := T8.FEditable;
      THS.FImageIndex := T8.FImageIndex;
      THS.FPicAlign := T8.FPicAlign;
      THS.FProtected := T8.FPassword;
      THS.FTextLayout := T8.FTextLayout;
      THS.FUseMainStyle := T8.FUseMainStyle;
      THS.FParentColor := T8.FParentColor;
      THS.FColor := T8.FColor;
      THS.FFontColor := T8.FFontColor;
      THS.FFilterEnabled := T8.FFilterEnabled;

      // read caption
      Stream.ReadBuffer(J, SizeOf(integer));
      GetMem(P1, j);
      Stream.ReadBuffer(P1^, j);
      S := String(StrPas(P1));
      FreeMem(P1, j);
      THS.FText := S;
      // read field name
      Stream.ReadBuffer(J, SizeOf(integer));
      GetMem(P1, j);
      Stream.ReadBuffer(P1^, j);
      S := String(StrPas(P1));
      FreeMem(P1, j);
      THS.FFieldName := S;
      Dec(i);
      LMDAnsiReadStringFromStream(Stream, THS.FPopupName);
      {$ifdef LMD_UNICODE}
      LMDAnsiReadStringFromStream(Stream, S);
      THS.FHint := S;
      {$else}
      LMDReadStringFromStream(Stream, THS.FHint);
      {$endif}
    end;
    Dispose(T8);
    for i := 0 to FList.Count - 1 do
    begin
      if Item[i].FParentIdx <> -1 then
      begin
        Item[i].FParentSection := Item[Item[i].FParentIdx];
      end;
    end;
  end
  else if (ver = -5) or (ver = -6) then
  begin
    Stream.ReadBuffer(i, SizeOf(integer));
    New(T7);
    while i > 0 do
    begin
      Stream.ReadBuffer(T7^, SizeOf(T7SectionData));
      THS := AddSection;
      THS.FLookupEnabled := T7.FLookupEnabled;
      THS.FExpandable := T7.FExpandable;
      THS.FExpanded := T7.FExpanded;
      THS.FParentIdx := T7.FParentIdx;
      THS.FResizable := T7.FResiable;
      THS.FClickSelect := T7.FClickSel;
      THS.FVisible := T7.FVisible;
      THS.FStyle := T7.FStyle;
      THS.FWidth := T7.FWidth;
      THS.FMinWidth := T7.FMinWidth;
      THS.FMaxWidth := T7.FMaxWidth;
      THS.FSortMode := T7.FSortMode;
      THS.FAllowClick := T7.FAllowClick;
      THS.FAlignment := T7.FAlignment;
      THS.FIndex := T7.FTag;
      THS.FFieldType := T7.FFieldType;
      THS.FEditable := T7.FEditable;
      THS.FImageIndex := T7.FImageIndex;
      THS.FPicAlign := T7.FPicAlign;
      THS.FProtected := T7.FPassword;
      // read caption
      Stream.ReadBuffer(J, SizeOf(integer));
      GetMem(P1, j);
      Stream.ReadBuffer(P1^, j);
      S := String(StrPas(P1));
      FreeMem(P1, j);
      THS.FText := S;
      // read field name
      Stream.ReadBuffer(J, SizeOf(integer));
      GetMem(P1, j);
      Stream.ReadBuffer(P1^, j);
      S := String(StrPas(P1));
      FreeMem(P1, j);
      THS.FFieldName := S;
      Dec(i);
      if Ver = -6 then LMDAnsiReadStringFromStream(Stream, THS.FPopupName);
    end;
    Dispose(T7);
    for i := 0 to FList.Count - 1 do
    begin
      if Item[i].FParentIdx <> -1 then
      begin
        Item[i].FParentSection := Item[Item[i].FParentIdx];
      end;
    end;
  end
  else if i = -4 then
  begin
    Stream.ReadBuffer(i, SizeOf(integer));
    GetMem(q, SizeOf(T6SectionData));
    while i > 0 do
    begin
      Stream.ReadBuffer(q^, SizeOf(T6SectionData));
      THS := AddSection;
      THS.FResizable := Q^.FResiable;
      THS.FClickSelect := Q^.FClickSel;
      THS.FVisible := q^.FVisible;
      THS.FStyle := q^.FStyle;
      THS.FWidth := q^.FWidth;
      THS.FMinWidth := q^.FMinWidth;
      THS.FMaxWidth := q^.FMaxWidth;
      THS.FSortMode := q^.FSortMode;
      THS.FAllowClick := q^.FAllowClick;
      THS.FAlignment := q^.FAlignment;
      THS.FIndex := q^.FTag;
      THS.FFieldType := q^.FFieldType;
      THS.FEditable := q^.FEditable;
      THS.FImageIndex := q^.FImageIndex;
      THS.FPicAlign := q^.FPicAlign;
      THS.FProtected := q^.FPassword;
    // read caption
      Stream.ReadBuffer(J, SizeOf(integer));
      GetMem(P1, j);
      Stream.ReadBuffer(P1^, j);
      S := String(StrPas(P1));
      FreeMem(P1, j);
      THS.FText := S;
    // read field name
      Stream.ReadBuffer(J, SizeOf(integer));
      GetMem(P1, j);
      Stream.ReadBuffer(P1^, j);
      S := String(StrPas(P1));
      FreeMem(P1, j);
      THS.FFieldName := S;
      Dec(i);
    end;
    FreeMem(q);
    end;
//  // correct old styled right aligned view
//  if (ver >= -13) and Owner.RightAlignedOrder then
//    CancelOldRightAlignedOrder;
  FVer13 := (ver >= -13);
  FOwner.AdjustHeaderHeight;
  if (FOwner.HandleAllocated) then
    FOwner.Invalidate;//Repaint;
end;

procedure TCustomElHeader.CancelOldRightAlignedOrder;
var
  i: integer;
  LList: TLMDObjectList;
begin
  LList := TLMDObjectList.Create;
  for i := 0 to Sections.FList.Count - 1 do
    LList.Add(Sections.FList[Sections.FList.Count - i - 1]);
  Sections.FList.Clear;
  for i := 0 to LList.Count - 1 do
  begin
    Sections.FList.Add(LList[i]);
  end;
  LList.Free;
end;

procedure TElHeaderSections.LoadFromStream(Stream: TStream);
begin
  FOwner.BeginUpdate;
  ReadData(Stream);
  if (FOwner <> nil) and (FOwner.HandleAllocated) then
    FOwner.Invalidate;
  FOwner.EndUpdate;
end;

procedure TElHeaderSections.SaveToStream(Stream: TStream);
begin
  WriteData(Stream);
end;

procedure TElHeaderSections.SaveToFile(FileName: TLMDString);
var
  T: TStream;
begin
  T := nil;
  try
    T := TLMDFileStream.Create(FileName, fmCreate or fmShareDenyWrite);
    SaveToStream(T);
  finally
    T.Free;
  end;
end;

procedure TElHeaderSections.LoadFromFile(FileName: TLMDString);
var
  T: TStream;
begin
  T := nil;
  try
    T := TLMDFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    LoadFromStream(T);
  finally
    T.Free;
  end;
end;

function TElHeaderSections.LastVisibleSection: TElHeaderSection;
begin
  Result := TElHeaderSection(FList[Count - 1]);
  if not Result.Visible then Result := GetPrevVisibleSection(Result);
end;

function TElHeaderSections.GetPrevVisibleSection;
var
  I: Integer;

begin
  Result := nil;
  I := FList.IndexOf(Section) - 1;
  if i < 0 then Exit;
  while i >= 0 do
  begin
    if TElHeaderSection(FList[i]).Visible then
    begin
      Result := TElHeaderSection(FList[i]);
      break;
    end;
    Dec(i);
  end; // while
end;

procedure TElHeaderSections.Assign;
var
  IT: TElHeaderSections;
  j: integer;
begin
  if source is TElHeaderSections then
  begin
    FOwner.BeginUpdate;
    try
      IT := TElHeaderSections(source);
      // delete old sections
      while Count > 0 do
      begin
        DeleteSection(Item[0]);
        if (FForceReindexInAssign) then
          Reindex;
      end;
      // add new sections
      for j := 0 to IT.Count - 1 do
        AddSection.Assign(IT.ItemByPos[j]);
      for j := 0 to IT.Count - 1 do
      begin
//        TElHeaderSection(FList[j]).FIndex := IT.ItemByPos[j].FIndex;
//        TElHeaderSection(FList[j]).FIntTag := IT.ItemByPos[j].FIntTag;
        ItemByPos[j].SetIndex(IT.ItemByPos[j].Index);
        ItemByPos[j].FIntTag := IT.ItemByPos[j].FIntTag;
      end;
      FOwner.MarkStickySections;
      FOwner.Invalidate;
    finally
      FOwner.EndUpdate;
    end;
  end
  else
    inherited;
end;

function TElHeaderSections.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TElHeaderSections.FindSection(tag: integer): TElHeaderSection; { protected }
var
  i: Integer;
//  LMax: Integer;
begin
//  LMax := FList.Count - 1;
  for i := 0 to FList.Count - 1 do
  begin
    Result := TElHeaderSection(FList[i]);
    if Result.FIndex = tag then
      Exit;
  end;
  Result := nil;
end; { FindSection }

// =============================================================================

constructor TCustomElHeader.Create(AOwner: TComponent);
begin

  BeginCreate;
  inherited;

  ControlStyle := [csClickEvents, csDisplayDragImage, csDoubleClicks, csCaptureMouse,
    {csDesignInteractive,} csReplicatable, csOpaque, csReflector];

  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;

  FLookupStyle := csDropDown;

  FSections := CreateSections;
  TabStop := False;
//  Font.OnChange := OnFontChange;
  Height := abs(Font.Height) + 6 + GetSystemMetrics(SM_CYBORDER) * 2;
  DragMode := dmManual;
  FPressed := False;
  DragCursor := Cursor;
  FPressed := False;
  FTracking := True;
  FAllowDrag := True;
  FResizeOnDrag := False;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := OnImageListChange;
  FAlphaImageChangeLink := TChangeLink.Create;
  FAlphaImageChangeLink.OnChange := OnImageListChange;
  Color := clBtnFace;
  Align := alTop;
  FFilterColor := clBtnText;
  FInvertSortArrows := False;
  FDefaultWidth := DefaultHeaderSectionWidth;

  FRender := TLMDHTMLRender.Create;
  FRender.OnImageNeeded := TriggerImageNeededEvent;
  FRender.OnImageNeededEx := TriggerImageNeededExEvent;

  EndCreate;
end;

destructor TCustomElHeader.Destroy;
begin
  Destroying;
  FSections.Free;

  ImageForm := nil;
  FImgFormChLink.Free;
  FImgFormChLink := nil;

  if FImages <> nil then
     FImages.UnregisterChanges(FImageChangeLink);
  FImageChangeLink.Free;
  if FAlphaImages <> nil then
     FAlphaImages.UnregisterChanges(FAlphaImageChangeLink);
  FAlphaImageChangeLink.Free;

  FRender.Free;

  inherited Destroy;
end;

function TCustomElHeader.CreateSections;
begin
  Result := TElHeaderSections.Create(self);
end;

function TCustomElHeader.GetSectionAtEx(X, Y: integer; var SectionPart: TElSectionPart): TElHeaderSection;
var
  THS: TElHeaderSection;
  rm: integer;
begin
  if InResizeArea(X, THS) then
  begin
    Result := THS;
    SectionPart := espResizeArea;
    Exit;
  end
  else
  begin
    THS := GetSectionAt(X, Y);
    if THS <> nil then
    begin
      rm := THS.Right - 4;
      if THS.Expandable then
      begin
        if ((rm + 13 - THS.Width) + (ResizeWidth - 4) < RM)
          and LMDInRange(X, rm - 6 - (ResizeWidth - 4), RM)
          and LMDInRange(Y, 2, 9) then
        begin
          Result := THS;
          SectionPart := espExpandSign;
          Exit;
        end;
      end;
      if THS.FLookupEnabled then
      begin
        if ((rm + 13 - THS.Width) + (ResizeWidth - 4) < RM)
          and LMDInRange(X, rm - 6 - (ResizeWidth - 4), RM)
          and LMDInRange(Y, 12, 16) then
        begin
          Result := THS;
          SectionPart := espLookupSign;
          Exit;
        end;
      end;
      if THS.FFilterEnabled then
      begin
        if THS.LookupEnabled or THS.Expandable then
          Dec(rm, 8);
        if ((THS.Width - ResizeWidth) > 4)
          and LMDInRange(X, rm - 6, RM)
          and LMDInRange(Y, 12, 16) then
        begin
          Result := THS;
          SectionPart := espFilterSign;
          Exit;
        end;
      end;
    end;
  end;
  Result := THS;
  SectionPart := espText;
end;

function TCustomElHeader.GetSectionAt(X, Y: Integer): TElHeaderSection;
  function CheckX(ALeft, ASecMin, ASecMax: Integer): TElHeaderSection;
  var
    i: integer;
    LRight: integer;
  begin
    i := ASecMin;
    while i <= ASecMax do begin
      Result := TElHeaderSection(FSections.FList[i]);
      if Result.Visible then
      begin
        if RightAlignedOrder then
        begin
          LRight := ALeft;
          if (X >= ALeft - Result.Width) and (X < LRight) then
            Exit;
          ALeft := LRight - Result.Width;
        end
        else
        begin
          LRight := ALeft + Result.Width;
          if (X >= ALeft) and (X < LRight) then
            Exit;
          ALeft := LRight;
        end;
      end;
      Inc(i);
    end;
    Result := nil;
  end;
begin
  Result := nil;
  if (Y < 0) or (Y > Height) then
    Exit;
  if RightAlignedOrder then
    Result := CheckX(TElHeaderSection(Sections.FList[0]).Right, 0, FFixedColNum - 1)
  else
    Result := CheckX(0, 0, FFixedColNum - 1);
  if Result = nil then
    if RightAlignedOrder then
      Result := CheckX(max(Width, FColumnsWidth) - FHPos - FFixedColWidth, FFixedColNum, FSections.FList.Count - 1)
    else
      Result := CheckX(FFixedColWidth - FHPos, FFixedColNum, FSections.FList.Count - 1);
end;

procedure TCustomElHeader.InvalidateRight(value: integer);
var
  R: TRect;
begin
  if not LMDInRange(Value, 0, Sections.Count - 1) then
    raise EElHeaderError.Create('Index out of bounds');
  if not HandleAllocated then
    Exit;
  R := Rect(TElHeaderSection(Sections[value]).Left, 0, ClientWidth, ClientHeight);
  if HandleAllocated then
    InvalidateRect(Handle, @R, False);
  //Update;
end;

procedure TCustomElHeader.RecalcColumnsWidth;
var
  i: integer;
begin
  FColumnsWidth := 0;
  for i := 0 to Sections.FList.Count - 1 do
  begin
    if TElHeaderSection(Sections.FList[i]).Visible then
      inc(FColumnsWidth, TElHeaderSection(Sections.FList[i]).Width)
  end;
{  for i := 0 to Sections.Count - 1 do
  begin
    if Sections[i].Visible then
      inc(FColumnsWidth, Sections[i].Width)
  end;}
end;

function TCustomElHeader.GetColumnsWidth: Integer;
begin
  if FColumnsWidth = 0 then
    RecalcColumnsWidth;
  Result := FColumnsWidth;
end;

function TCustomElHeader.InResizeArea(AX: integer; var AHitSection: TElHeaderSection): boolean;
var
  LSection: TElHeaderSection;
  LLeft: integer;
begin
  LSection := GetSectionAt(AX, 0);
  AHitSection := LSection;
  if LSection = nil then
  begin
    if Sections.Count > 0 then
      LSection := Sections.LastVisibleSection;
    if LSection <> nil then
    begin
      LLeft := LSection.Right;

      if not LSection.Locked then
        Dec(LLeft, FHPos);
      if RightAlignedOrder then
      begin
        if LLeft + LSection.Width + ResizeWidth > AX then
        begin
          Result := True;
          AHitSection := LSection;
          Exit;
        end;
      end
      else
        if LLeft + ResizeWidth > AX then
        begin
          Result := True;
          AHitSection := LSection;
          Exit;
        end;
    end;
    Result := False;
    AHitSection := nil;
    Exit;
  end
  else
  begin
    if LSection.Width < ResizeWidth * 3 then
      Result := False
    else
    begin
      if RightAlignedOrder then
      begin
        LLeft := LSection.Left;
        if not LSection.Locked then
          Dec(LLeft, FHPos);
        if LLeft + LSection.Width - ResizeWidth < AX then
        begin
          if (Sections.GetPrevVisibleSection(LSection) = nil) then
          begin
            Result := False;
            AHitSection := LSection;
            Exit;
          end;
          Result := True;
          AHitSection := Sections.GetPrevVisibleSection(LSection);
          Exit;
        end;
        Result := LLeft + ResizeWidth >= AX;
      end
      else
      begin
        LLeft := LSection.Left;
        if not LSection.Locked then
          Dec(LLeft, FHPos);
        if LLeft + ResizeWidth > AX then
        begin
          if (Sections.GetPrevVisibleSection(LSection) = nil) then
          begin
            Result := False;
            AHitSection := LSection;
            Exit;
          end;
          Result := True;
          AHitSection := Sections.GetPrevVisibleSection(LSection);
          Exit;
        end;
        Result := LLeft + LSection.FWidth - ResizeWidth <= AX;
      end;
    end;
  end;
end;

procedure TCustomElHeader.WMCancelMode(var Msg: TWMCancelMode);
var Msg2: TWMLButtonUp;
begin
  if (FAllowDrag) and (not FPressed) and (FDropSrc <> nil) then
  begin
    Msg2.Keys := 0;
    Msg2.XPos := -1;
    Msg2.YPos := -1;
    WMLButtonUp(Msg2);
  end;
  if FResizing then
  begin
    Msg2.Keys := 0;
    Msg2.XPos := -1;
    Msg2.YPos := -1;
    WMLButtonUp(Msg2);
  end;
  inherited;
  Msg.Result := 0;
end;

procedure TCustomElHeader.WMLButtonDown(var Message: TWMLButtonDown);
begin
  IntLButtonDown(Message.XPos, Message.YPos);
  inherited;
end;

procedure TCustomElHeader.WMMouseMove(var Message: TWMMouseMove);
begin
  IntMouseMove(Message.XPos, Message.YPos);
  inherited;
end;

procedure TCustomElHeader.WMLButtonUp(var Message: TWMLButtonUp);
begin
  IntLButtonUp(Message.XPos, Message.YPos);
  inherited;
end;

procedure TCustomElHeader.CMMouseLeave;
begin
  IntMouseLeave;
  inherited;
end;

procedure TCustomElHeader.CMMouseEnter;
begin
  inherited;
  IntMouseEnter;
end;

procedure TCustomElHeader.CMDrag(var Message: TCMDrag);
var
  TSI: TElHeaderSection;
begin
  inherited;
  with Message, DragRec^ do
    case DragMessage of
//      dmDragMove: with ScreenToClient(Pos) do DoDragOver(Source, X, Y, Message.Result<>0);
      dmDragLeave,
      dmDragDrop :
        begin
          TSI := FDropTrg;
          FDropTrg := nil;
          if TSI <> nil then
          begin
            TSI.UpdateSection;
            Update;
          end;
        end;
      dmDragCancel :
        begin
          TSI := FDropTrg;
          FDropTrg := nil;
          if TSI <> nil then
          begin
            TSI.UpdateSection;
            Update;
          end;
          FDropSrc := nil;
        end;
    end;
end;

function TCustomElHeader.GetSectionRect(SectionNum: integer): TRect;
var
  LSection: TElHeaderSection;
  L: integer;
begin
  LSection := Sections.FindSection(SectionNum);
  L := LSection.Left;
  Result := Rect(L, 0, L + LSection.Width, ClientHeight);

  if not LSection.Locked and (FHPos <> 0) then
    OffsetRect(Result, -FHPos, 0);
end;

function TCustomElHeader.DoGetPicture;
begin
  Result := -1;
  if Assigned(FOnPictureNeeded) then FOnPictureNeeded(self, Section, Result);
end;

function TCustomElHeader.MeasureSectionWidth(Section: TElHeaderSection;
         TextWidth:PInteger;SectionHeight: PInteger): integer;
var p: TPoint;
    StImIndex: integer;
    R: TRect;
    AL: integer;
    S: TLMDString;
begin
  Result := 13; // minimal width for resize area and borders
  if TextWidth <> nil then
     TextWidth^ := 0;
  if SectionHeight <> nil then
     SectionHeight^ := 0;
  try
    if (Section.FExpandable or
        Section.FLookupEnabled) then
        Inc(Result, 8);
    if Section.FSortMode <> hsmNone then
      Inc(Result, 12);
    // Inc(Result, ResizeWidth);
    if Section.Style = elhsOwnerdraw then
    begin
      p.x := 0;
      Self.TriggerMeasureSectionEvent(Section, P);
      Inc(Result, p.x);
      if SectionHeight <> nil then
        SectionHeight^ := p.y;
      end
    else
    begin
      S := Section.Text;
      if (FImages <> nil) then
      begin
        if Section.Style = elhsImageIndex then
          StImIndex := StrToIntDef(Section.Text, -1)
        else
          StImIndex := Section.FImageIndex;

        if StImIndex = -1 then
          StImIndex := DoGetPicture(Section);
        if LMDInRange(StImIndex, 0, FImages.Count - 1) then
          if (Section.Alignment = hsaCenter) and (not (Section.FStyle in [elhsPictureOnly, elhsImageIndex])) then
            Inc(Result, 2*FImages.Width)
          else
            Inc(Result, FImages.Width);
      end;
      if (Section.FStyle in [elhsPictureOnly, elhsImageIndex]) then Exit;

      SetRectEmpty(R);

      if Pos('<html>', S) = 1 then
      begin
        FRender.Data.DefaultBgColor := Color;
        FRender.Data.DefaultColor := Font.Color;
        FRender.Data.DefaultStyle := Font.Style;
        FRender.Data.DefaultHeight := Font.Height;
        FRender.Data.DefaultFont := Font.Name;
        FRender.Data.Charset := Font.Charset;
        FRender.PrepareText(S, 0, False);
        R.Right := FRender.Data.TextSize.cx;
        R.Bottom := FRender.Data.TextSize.cy;
      end
      else

      begin

        if WrapCaptions then
          AL := 0
        else
          AL := DT_SINGLELINE;
        LMDDrawText(Canvas.Handle, S, Length(S), R, DT_NOPREFIX or AL or DT_CALCRECT);

      end;
      Inc(Result, R.Right);
      if TextWidth <> nil then
        TextWidth^ := R.Right - R.Left;
      if SectionHeight <> nil then
      begin
      if Length(S) = 0 then
          SectionHeight^ := Abs(Canvas.Font.Height)
          else
          SectionHeight^ := R.Bottom;
          end;
      end;
  finally
    if Result < Section.MinWidth then
       Result := Section.MinWidth;
  end;
end;

{$hints off}
procedure TCustomElHeader.RedrawSection(Canvas: TCanvas; Section: TElHeaderSection; R: TRect; xHOffs: integer; Dithered: Boolean);
var
  TS: TElHeaderSection;
  R1,
  R2,
  BgRect: TRect;
  w: integer;
  DC: HDC;
  s: TLMDString;
  SaveCol,
    SaveColor: TColor;
  SaveStyle: TFontStyles;
  StImIndex: integer;
  BMP, amBMP: TBitmap;
  AL: integer;
  ACtl: TWinControl;
  imfd: boolean;
  C: TColor;
  hls2: integer;
  lum: integer;
  sid, sid1: integer;
  PS: TSize;
  LDetails: TThemedHeader;
  LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  sid := 0;
  sid1 := 0;
  PS.cx := 0;
  TS := Section;
  LDetails := thHeaderItemNormal;

  if TS.FParentColor then
    C := Color
  else
    C := TS.FColor;

  if Dithered then
  begin
    hls2 := RGBtoHLS(ColorToRGB(C));
    lum := Hi(hls2 and $FFFF);
    Dec(lum, lum shr 2);
    if lum > 252 then
      lum := 252;
    hls2 := (lum shl 8) or (hls2 and $FF00FF);
    C := TColor(HLStoRGB(hls2))
  end;

  Canvas.Brush.Color := C;

  imfd := False;
  if LThemeMode = ttmNone then
  begin
    if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
    begin
      if (FImgForm.Control <> Self) then
      begin
        ACtl := FImgForm.GetRealControl;
        OffsetRect(R, xHOffs, 0);
        BgRect := R;
        OffsetRect(BgRect, -Section.Left + xHOffs + FHPos, 0);
        BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
        BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
        BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
        BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);
        OffsetRect(R, -xHOffs, 0);
        FImgForm.PaintBkgnd(Canvas.Handle, R, BgRect.TopLeft, False);
      end;
      imfd := True;
    end
    else
    Canvas.FillRect(R);

    DC := Canvas.Handle;
    if ((TS = FPressedItem) and (FPressed = True)) or ((FDropSrc = TS) and not Dithered) then
    begin
      if Flat then
      begin
        Dec(R.Bottom); Dec(R.Right);
        DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT);
        Inc(R.Bottom); Inc(R.Right);
        InflateRect(R, -1, -1);
        OffsetRect(R, 1, 1);
      end
      else
      begin
        Dec(R.Bottom); Dec(R.Right);
        DrawEdge(DC, R, BDR_SUNKENINNER, BF_TOPLEFT);
        DrawEdge(DC, R, BDR_SUNKENOUTER, BF_BOTTOMRIGHT);
        Inc(R.Bottom); Inc(R.Right);

        InflateRect(R, -1, -1);
        OffsetRect(R, 1, 1);
      end;
    end
    else
    begin
      if Flat then
      begin
        DrawEdge(DC, R, BDR_RAISEDINNER, BF_RECT);
      end
      else
      begin
        DrawEdge(DC, R, BDR_RAISEDOUTER, BF_BOTTOMRIGHT); { black }
        Dec(R.Bottom);
        Dec(R.Right);
        DrawEdge(DC, R, BDR_RAISEDINNER, BF_TOPLEFT); { btnhilite }
        Inc(R.Top);
        Inc(R.Left);
        DrawEdge(DC, R, BDR_RAISEDINNER, BF_BOTTOMRIGHT); { btnshadow }
        Dec(R.Bottom);
        Dec(R.Right);
        end;
    end;

    Inc(R.Top);
    Inc(R.Left);
    Dec(R.Bottom);
  end
  else
  begin
    imfd := True;
    if ((TS = FPressedItem) and (FPressed = True)) or
       ((TS = FDropSrc) and not Dithered) then
       LDetails := thHeaderItemPressed
       // sid := HIS_PRESSED
    else
    if (TS = FTrackSection) or ((TS = FDropSrc) and Dithered) then
      LDetails := thHeaderItemHot
      // sid := HIS_HOT
    else
      LDetails := thHeaderItemNormal;
      // sid := HIS_NORMAL;
    LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, thHeaderDontCare, R, LMDRectToPtr(R));
    LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetails, R, LMDRectToPtr(R));
  end;

  Dec(R.Right, 4);
  if (TS.FExpandable or TS.FLookupEnabled) and (R.Right - 2 > R.Left +  ResizeWidth) then
  begin
    if TS.Expandable then
    begin
      R2 := Rect(R.Right - 5, R.Top, R.Right, R.Top + 7);
      if TS.Expanded then
        LMDDrawArrow(Canvas, eadLeft, R2, clBtnText, True)
      else
        LMDDrawArrow(Canvas, eadRight, R2, clBtnText, True);
    end;
    if TS.FLookupEnabled then
    begin
      BMP := ElHeaderPointBmp;
      R2 := Rect(R.Right - 5, R.Top + 10, R.Right, Min(R.Top + 14, R.Bottom));
      if imfd then
      DrawTransparentBitmapEx(Canvas.Handle, Bmp, R2.Left, R2.Top, Rect(0, 0, R2.Right - R2.Left, R2.Bottom - R2.Top), BMP.TransparentColor)
      else
      Canvas.BrushCopy(R2, Bmp, Rect(0, 0, R2.Right - R2.Left, R2.Bottom - R2.Top), BMP.TransparentColor)
      end;
    Dec(R.Right, 8);
  end;
  R1 := R;
  if TS.FilterEnabled and (R.Right - 4 > R.Left + ResizeWidth) then
  begin
    SaveColor := Canvas.Brush.Color;
    SaveCol := Canvas.Pen.Color;
    if TS.FFilterIsActive then
      Canvas.Brush.Color := FActiveFilterColor
    else
      Canvas.Brush.Color := FFilterColor;
    Canvas.Pen.Color := Canvas.Brush.Color;
    Canvas.Polygon([Point(R.Right - 4, R.Top + 10), Point(R.Right, R.Top + 10), Point(R.Right - 2, Min(R.Top + 14, R.Bottom))]);
    Canvas.Brush.Color := SaveColor;
    Canvas.Pen.Color := SaveCol;
    if (TS.FSortMode = hsmNone) or (not TS.FShowSortMark) then
      Dec(R1.Right, 6);
  end;
  if (TS.FSortMode <> hsmNone) and (TS.FShowSortMark) then
  begin
    //Sort mark is not drawn correcly in themed mode
    {if LThemeMode <> ttmNone then
    begin
      if (TS.FSortMode = hsmAscend) xor (InvertSortArrows) then
        LDetails := thHeaderSortArrowSortedDown
      else
        LDetails := thHeaderSortArrowSortedUp;
      LMDThemeServices.GetThemePartSize(LThemeMode, Canvas.Handle, teHeader, HP_HEADERSORTARROW, 0, PS);

      PS.CX := 9;
      PS.cy := 9;
      R2 := R1;
      if R1.Right - PS.CX < R1.Left + ResizeWidth then
      begin
        // w := 0;
        R1.Right := R1.Left + ResizeWidth;
        R2.Left := R1.Left;
      end
      else
      begin
        w := PS.CX + 1;
        Dec(R1.Right, PS.CX + 1);
        R2.Left := R1.Right - w;
      end;
      R2.Right := R1.Right;

      LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetails, R2, LMDRectToPtr(R1));
      end
    else}
    begin
      if R1.Right - 8 < R1.Left + ResizeWidth then
      begin
        w := 0;
        R1.Right := R1.Left + ResizeWidth;
      end
      else
      begin
        w := 9;
        Dec(R1.Right, 9);
      end;
      if TS.FilterEnabled or TS.LookupEnabled then
        R2 := Rect(R1.Right, (5 + R.Top) - 3, R1.Right + W, (5 + R.Top) + 3)
      else
        R2 := Rect(R1.Right, ((R1.Bottom - R.Top) div 2 + R.Top) - 3, R1.Right + W, ((R1.Bottom - R.Top) div 2 + R.Top) + 3);
      Canvas.Brush.Color := C;

      if w > 0 then
      begin
        if (TS.FSortMode = hsmAscend) xor (InvertSortArrows) then
          BMP := ElHeaderAscBmp
        else
          BMP := ElHeaderDescBmp;
        if imfd then
        DrawTransparentBitmapEx(Canvas.Handle, Bmp, R2.Left, R2.Top, Rect(0, 0, 9, 6), Bmp.Canvas.Pixels[0, 5])
        else
        Canvas.BrushCopy(R2, Bmp, Rect(0, 0, 9, 6), Bmp.Canvas.Pixels[0, 5]);
        Dec(R1.Right, 3);
      end;
    end;
  end;
  if not (TS.FStyle in [elhsPictureOnly, elhsImageIndex]) then
    Inc(R1.Left, ResizeWidth);

  if R1.Right < R1.Left then Exit;
  if TS.FStyle = elhsOwnerDraw then
  begin
    DoSectionDraw(Canvas, TS, R1, ((TS = FPressedItem) and (FPressed = True)) or ((FDropSrc = TS) and not Dithered));
  end
  else
  begin
    if (TS.FStyle in [elhsPictureOnly, elhsImageIndex]) then
    begin
      if (FImages <> nil) then
      begin
        if TS.FStyle = elhsPictureOnly then
          StImIndex := TS.FImageIndex
        else
          StImIndex := StrToIntDef(Ts.Text, -1);

        if StImIndex = -1 then
          StImIndex := DoGetPicture(TS);

        if LMDInRange(StImIndex, 0, FImages.Count - 1) then
        begin
          BMP := TBitmap.Create;
          BMP.Width := FImages.Width;
          BMP.Height := FImages.Height;

          R2 := Rect(Max(R1.Left + ((R1.Right - R1.Left + 1) div 2) - (FImages.Width div 2), R1.Left),
              R1.Top + ((R1.Bottom - R1.Top + 1) div 2) - (FImages.Height div 2),
              Min(R1.Right, R1.Left + ((R1.Right - R1.Left + 1) div 2) - (FImages.Width div 2) + FImages.Width),
              R1.Top + FImages.Height);
          Bmp.Canvas.CopyRect(Rect(0, 0, min(FImages.Width, Min(R1.Right, R1.Left + FImages.Width - 1) - R1.Left + 1), FImages.Height), Canvas, R2);

          if R.Left < R.Right then
          begin
            if (FAlphaImages <> nil) and (FAlphaImages.Count>StImIndex) then
            begin
              ImageList_DrawEx(FImages.Handle, StImIndex, BMP.Canvas.Handle,
                0, 0, 0, 0, clNone, clNone, ILD_Normal);

              amBMP := TBitmap.Create;
              amBMP.Width := FAlphaImages.Width;
              amBMP.Height := FAlphaImages.Height;
              ImageList_DrawEx(FAlphaImages.Handle, StImIndex, amBMP.Canvas.Handle,
                0, 0, 0, 0, clNone, clNone, ILD_Normal);
              AlphaCopyRect2(Canvas.Handle,
                             R2,
                             Bmp.Canvas.Handle,
                             Rect(0, 0, min(FImages.Width, Min(R1.Right, R1.Left + FImages.Width - 1) - R1.Left + 1), FImages.Height),
                             amBMP,
                             255);
              amBMP.Free;
            end
            else
            begin
              FImages.Draw(BMP.Canvas, 0, 0, StImIndex);
              Canvas.CopyRect(R2, BMP.Canvas, Rect(0, 0, min(FImages.Width, Min(R1.Right, R1.Left + FImages.Width - 1) - R1.Left + 1), FImages.Height));
            end;
          end;
          Inc(R1.Left, FImages.Width);
          BMP.Free;
        end;
      end;
      Exit;
    end;
    if (FImages <> nil) and (TS.FPicAlign = hsaLeft) then
    begin
      StImIndex := TS.FImageIndex;
      if StImIndex = -1 then StImIndex := DoGetPicture(TS);
      if LMDInRange(StImIndex, 0, FImages.Count - 1) then
      begin
        BMP := TBitmap.Create;
        BMP.Width := FImages.Width;
        BMP.Height := FImages.Height;

        R2 := Rect(R1.Left, (R1.Bottom + R1.Top + 1) div 2 - (FImages.Height div 2), Min(R1.Right, R1.Left + FImages.Width), 0);
        R2.Bottom := R2.Top + FImages.Height;

        Bmp.Canvas.CopyRect(Rect(0, 0, min(FImages.Width, Min(R1.Right, R1.Left + FImages.Width - 1) - R1.Left + 1), FImages.Height), Canvas, R2);

        if R.Left < R.Right then
        begin
          if (FAlphaImages <> nil)and (FAlphaImages.Count>StImIndex) then
          begin
            ImageList_DrawEx(FImages.Handle, StImIndex, BMP.Canvas.Handle,
              0, 0, 0, 0, clNone, clNone, ILD_Normal);

            amBMP := TBitmap.Create;
            amBMP.Width := FAlphaImages.Width;
            amBMP.Height := FAlphaImages.Height;
            ImageList_DrawEx(FAlphaImages.Handle, StImIndex, amBMP.Canvas.Handle,
              0, 0, 0, 0, clNone, clNone, ILD_Normal);
            AlphaCopyRect2(Canvas.Handle,
                           R2,
                           Bmp.Canvas.Handle,
                           Rect(0, 0, min(FImages.Width, Min(R1.Right, R1.Left + FImages.Width - 1) - R1.Left + 1), FImages.Height),
                           amBMP,
                           255);
            amBMP.Free;
          end
          else
          begin
            // BMP.Canvas.Brush.Color := Canvas.Brush.Color;
            // BMP.Canvas.FillRect(Rect(0, 0, FImages.Width, FImages.Height));
            FImages.Draw(BMP.Canvas, 0, 0, StImIndex);
            BMP.TransparentMode := tmAuto;
            Canvas.CopyRect(R2, BMP.Canvas, Rect(0, 0, min(FImages.Width, Min(R1.Right, R1.Left + FImages.Width - 1) - R1.Left + 1), FImages.Height));
          end;
        end;
        Inc(R1.Left, FImages.Width);
        BMP.Free;
      end;
    end;
    if R1.Right < R1.Left then Exit;
    if TS.FStyle = elhsText then
    begin
      S := TS.Text;

      if Pos('<html>', s) = 1 then
      begin
        FRender.Data.DefaultBgColor := C;
        FRender.Data.DefaultColor := Font.Color;
        FRender.Data.DefaultStyle := Font.Style;
        FRender.Data.DefaultHeight := Font.Height;
        FRender.Data.DefaultFont := Font.Name;
        FRender.Data.Charset := Font.Charset;
        FRender.PrepareText(S, 0, False);
        FRender.DrawText(Canvas, Point(0, 0), R1, clNone);
      end
      else

      begin
        if FRightAlignedText then
        begin
          Al := DT_RIGHT;
          case TS.FAlignment of
            hsaCenter: Al := DT_CENTER;
            hsaRight: Al := DT_LEFT;
          end; // case
          end
        else
        begin
          Al := DT_LEFT;
          case TS.FAlignment of
            hsaCenter: Al := DT_CENTER;
            hsaRight: Al := DT_RIGHT;
          end; // case
          end;
        case TS.FTextLayout of
          tlTop: Al := AL or DT_TOP;
          tlCenter: Al := Al or DT_VCENTER;
          tlBottom: Al := Al or DT_BOTTOM;
        end;
        if RightAlignedText then
           AL := AL or DT_RTLREADING;
  if WrapCaptions then
        begin
          AL := AL or DT_WORDBREAK;
          if TS.FTextLayout = tlCenter then
             AL := AL or DT_TOP;
        end
        else
        if (Pos(#13#10, TS.Text) = 0) then
  AL := AL or DT_SINGLELINE or DT_END_ELLIPSIS;
        Canvas.Brush.Style := bsClear;
        SaveCol := 0;
        if (TS = FTrackSection) and (not IsThemed) then
        begin
          SaveCol := Canvas.Font.Color;
          SaveStyle := Canvas.Font.Style;
          Canvas.Font.Color := clHighlight;
          Canvas.Font.Style := Canvas.Font.Style + [fsUnderline];
        end
        else
          if TS.ParentColor then
            Canvas.Font.Color := Font.Color
          else
           Canvas.Font.Color := TS.FontColor;
        // to fix problem with rigth-aligned italic text
        if (fsItalic in Canvas.Font.Style) and ((AL and DT_RIGHT) = DT_RIGHT) then
          AL := AL or DT_NOCLIP;
        if LThemeMode <> ttmNone then
          LMDThemeServices.DrawThemeText(LThemeMode, Canvas.Handle,
                ThemeServices.GetElementDetails(LDetails), WideString(S),
                Length(S), DT_NOPREFIX or AL, 0, R1)
        else
          LMDDrawText(Canvas.Handle, S, -1, R1, DT_NOPREFIX or AL);
        if (TS = FTrackSection) and (not IsThemed) then
        begin
          Canvas.Font.Color := SaveCol;
          Canvas.Font.Style := SaveStyle;
        end;
        Canvas.Brush.Style := bsSolid;
      end;
    end;
    Inc(R1.Left, Canvas.TextWidth(S) + 3);
    if R1.Right < R1.Left then Exit;
  end;
  if (FImages <> nil) and (TS.FPicAlign = hsaRight) then
  begin
    StImIndex := TS.FImageIndex;
    if StImIndex = -1 then StImIndex := DoGetPicture(TS);
    if LMDInRange(StImIndex, 0, FImages.Count - 1) then
    begin
      BMP := TBitmap.Create;
      BMP.Width := FImages.Width;
      BMP.Height := FImages.Height;

      R2 := Rect(R1.Left, (R1.Bottom + R1.Top + 1) div 2 - (FImages.Height div 2), Min(R1.Right, R1.Left + FImages.Width), 0);
      R2.Bottom := R2.Top + FImages.Height;

      Bmp.Canvas.CopyRect(Rect(0, 0, min(FImages.Width, Min(R1.Right, R1.Left + FImages.Width - 1) - R1.Left + 1), FImages.Height), Canvas, R2);

      if R.Left < R.Right then
      begin
        if (FAlphaImages <> nil)and (FAlphaImages.Count>StImIndex) then
        begin
          ImageList_DrawEx(FImages.Handle, StImIndex, BMP.Canvas.Handle,
            0, 0, 0, 0, clNone, clNone, ILD_Normal);

          amBMP := TBitmap.Create;
          amBMP.Width := FAlphaImages.Width;
          amBMP.Height := FAlphaImages.Height;
          ImageList_DrawEx(FAlphaImages.Handle, StImIndex, amBMP.Canvas.Handle,
            0, 0, 0, 0, clNone, clNone, ILD_Normal);
          AlphaCopyRect2(Canvas.Handle,
                         R2,
                         Bmp.Canvas.Handle,
                         Rect(0, 0, min(FImages.Width, Min(R1.Right, R1.Left + FImages.Width - 1) - R1.Left + 1), FImages.Height),
                         amBMP,
                         255);
          amBMP.Free;
        end
        else
        begin
          FImages.Draw(BMP.Canvas, 0, 0, StImIndex);
          BMP.TransparentMode := tmAuto;
          // R2 := Rect(R1.Left, R1.Top + ((R1.Bottom - R1.Top + 1) div 2) - (FImages.Height div 2), Min(R1.Right, R1.Left + FImages.Width), R1.Top + FImages.Height);
          Canvas.CopyRect(R2, BMP.Canvas, Rect(0, 0, min(FImages.Width, Min(R1.Right, R1.Left + FImages.Width - 1) - R1.Left + 1), FImages.Height));
        end;
      end;
      Inc(R1.Left, FImages.Width);
      BMP.Free;
    end;
  end;
end;
{$hints on}

procedure TCustomElHeader.RedrawSections;

  procedure DrawSectionsRange(AMin, AMax: Integer);
  var
    i: Integer;
    LSection: TElHeaderSection;
    LR, LTmpR: TRect;
  begin
    if AMax < AMin then
      Exit;
    for i := AMin to AMax do
    begin
      LSection := Sections[i];
//      LSection := TElHeaderSection(Sections.FList[i]);
      if not LSection.Visible then
        continue;
      LR := GetSectionRect(i);
      if IntersectRect(LTmpR, LR, Canvas.ClipRect) and LSection.Visible then
         RedrawSection(Canvas, LSection, LR, 0, False);
    end;
  end;

var
  R: TRect;

  BgRect: TRect;
  ACtl: TWinControl;
  LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  if IsRectEmpty(Canvas.ClipRect) then
    Exit;
  DrawSectionsRange(FFixedColNum, Sections.Count - 1);
  DrawSectionsRange(0, FFixedColNum - 1);

  R := ClientRect;
  if FRightAlignedOrder then
  begin
    if Width > FColumnsWidth then
      R.Right := Width - FColumnsWidth
    else
      R.Left := R.Right + 1;
  end
  else
    R.Left := SectionsWidth - FHPos;
  if R.Left < R.Right then
  begin
    if LThemeMode = ttmNone then
    begin
      if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
      begin
        if (FImgForm.Control <> Self) then
        begin
          ACtl := FImgForm.GetRealControl;
          BgRect := R;
          OffsetRect(BgRect, -SectionsWidth, 0);
          BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
          BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
          BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
          BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);
          FImgForm.PaintBkgnd(Canvas.Handle, R, BgRect.TopLeft, False);
        end;
      end
      else
      begin
        Canvas.Brush.Color := Color;
        Canvas.FillRect(R);
      end;
      DrawEdge(Canvas.Handle, R, BDR_RAISEDINNER, BF_RECT);
    end
    else
      LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, thHeaderItemNormal, R, nil);
  end;
end;

function TCustomElHeader.CalcHeaderHeight: integer;
var i: integer;
    R: TRect;
    ASection: TElHeaderSection;
    dw,
    cw,
    ch,
    mh: integer;
//  AL: integer;
begin
  mh := 0;
  for i := 0 to FSections.Count - 1 do
  begin
    ASection := FSections[i];
    if Assigned(ASection) then
    begin
      if ASection.Visible and (ASection.Style = ElhsText) then
      begin
        SetRectEmpty(R);

        cw := MeasureSectionWidth(ASection, @dw, @ch);
        R.Right := ASection.Width - (cw - dw);
        if ch > mh then
          mh := ch;
      end;
    end;
  end;

  if Assigned(Images) then
    Result := Max(Max(17, mh + 4), Images.Height + 4)
  else
    Result := Max(17, mh + 4);
  if not Flat then
    Inc(Result, 2);
end;

procedure TCustomElHeader.AdjustHeaderHeight;
begin
  if LockHeight then
    Exit;
  if HandleAllocated then
    ClientHeight := CalcHeaderHeight;
end;

{function TCustomElHeader.RigthAndHaveGutter: Boolean;
begin
  Result := False;
end;}

procedure TCustomElHeader.AdjustStickySize(Caller: TElHeaderSection);
var
  i, cw, sw, n: integer;
  HS: TElHeaderSection;
begin
  i := 0;
  RecalcColumnsWidth;
  while (SectionsWidth >= ClientWidth) and (ClientWidth > 0) and (i > -1) do
  begin
    i := FSections.Count - 1;
    n := 0;
    while i >= n do
    begin
      HS := FSections.ItemByPos[i];
      cw := ClientWidth;
      sw := SectionsWidth;
      if HS.Visible and (HS.Width > 0) and (HS.Resizable) and (HS <> Caller) then
      begin
        if HS.Width > (sw - cw - 1) then
          HS.FWidth := max(hs.Width - (sw - cw) - 1, HS.FMinWidth)
        else
          HS.FWidth := HS.FMinWidth;
        RecalcColumnsWidth;
        //HS.FStickySize := HS.Width / cw;
        if HS.FWidth > HS.FMinWidth then
          break;
      end;
      Dec(i);
    end; // while
  end;
  i := 0;
  while (SectionsWidth >= ClientWidth) and (ClientWidth > 0) and (i > -1) do // we probably have non-resizable sections
  begin
    i := FSections.Count - 1;
    n := 0;
    while i >= n do
    begin
      HS := FSections.ItemByPos[i];
      cw := ClientWidth;
      sw := SectionsWidth;
      if HS.Visible and (HS.Width > 0) and ((not HS.Resizable) or (HS = Caller)) then
      begin
        if HS.FSaveSize = -1 then HS.FSaveSize := HS.Width; // this is the size we have to save, cause later we'll have to restore it
        if HS.Width > (sw - cw - 1) then
          HS.FWidth := max(hs.Width - (sw - cw) - 1, HS.FMinWidth)
        else
          HS.FWidth := HS.FMinWidth;
        RecalcColumnsWidth;
        if HS.FWidth > HS.FMinWidth then
          break;
      end;
      Dec(i);
    end;
  end;

  // first restore "non-resizable" sections
  i := 0;
  while (SectionsWidth < ClientWidth - 1) and (i > -1) do
  begin
    i := FSections.Count - 1;
    n := 0;
    while i >= n do
    begin
      HS := FSections.ItemByPos[i];
      cw := ClientWidth;
      RecalcColumnsWidth;
      sw := SectionsWidth;
      if HS.Visible and (not HS.Resizable) and (HS.Width < HS.FSaveSize) and (HS.FSaveSize <> -1) then
      begin
        HS.FWidth := min(hs.Width + (cw - sw) - 1, HS.FSaveSize);
        if HS.FWidth = HS.FSaveSize then
          HS.FSaveSize := -1
        else
          break;
      end;
      Dec(i);
    end; // while
  end;

  if (ClientWidth > 0) then
  begin
    i := FSections.Count - 1;
    n := 0;
    while i >= n do
    begin
      HS := FSections.ItemByPos[i];
      cw := ClientWidth;
      RecalcColumnsWidth;
      sw := SectionsWidth;
      if HS.Visible and (HS.Resizable) and (HS <> Caller) then
      begin
        HS.FWidth := min(hs.Width + (cw - sw) - 1, hs.FMaxWidth);
        HS.FWidth := max(HS.Width, HS.FMinWidth);
        //HS.FStickySize := HS.Width / cw;
        if (HS.FWidth < HS.FMaxWidth) and (Hs.Width > HS.FMinWidth) then
          break;
      end;
      Dec(i);
    end; // while
  end;
  RecalcColumnsWidth;
end;

function TCustomElHeader.GetResizableWidth: integer;
var
  i, w: integer;
  HS: TElHeaderSection;
begin
  w := Width;
  for i := 0 to FSections.Count - 1 do // Iterate
  begin
    HS := FSections[i];
    //if HS.Visible and (HS.Resizable) then w := w + HS.Width;
    if HS.Visible and (not HS.Resizable) then w := w - HS.Width;
  end; // for
  Result := w;
end;

procedure TCustomElHeader.MarkStickySections;
var
  w, i, j, n: integer;
  HS: TElHeaderSection;
begin
  W := GetResizableWidth;
//  if RigthAndHaveGutter then
//  begin
//    j := -1;
//    n := FSections.Count - 2
//  end
//  else
  begin
    n := FSections.Count - 1;
    j := 0
  end;
  for i := j to n do
  begin
    HS := FSections.ItemByPos[i];
    if HS.Resizable and HS.Visible then
      if (W <> 0) then
        HS.FStickySize := HS.FWidth / w
      else
        HS.FStickySize := 0;
  end;
end;

procedure TCustomElHeader.Resize;
var
  i, j, oh, nh, w, n: integer;
  HS: TElHeaderSection;
begin
  IntSize;
  if not FLockHeight then
  begin
    oh := ClientHeight;
    if Images <> nil then
      nh := Max(Max(Images.Height, oh), Abs(Font.Height) + 6)
    else
      nh := Max(oh, Abs(Font.Height) + 6);
    if nh <> oh then
       AdjustHeaderHeight;
  end;
//  if RigthAndHaveGutter then
//  begin
//    n := FSections.Count - 2;
//    j := -1;
//  end
//  else
  begin
    n := FSections.Count - 1;
    j := 0;
  end;
  if StickySections and (not IsLoading) then
  begin
    FInStick := True;
    if FOldWidth < ClientWidth then
    begin
      for i := n downto j do // Iterate
      begin
        HS := FSections.ItemByPos[i];
        if (not HS.Resizable) and (HS.Visible) and (HS.FSaveSize <> -1) then
        begin
          HS.Width := min(HS.FSaveSize, ClientWidth);
          if HS.Width = HS.FSaveSize then HS.FSaveSize := -1;
        end;
      end;
    end;
    W := GetResizableWidth;
    if w > 0 then
    begin
      for i := j to n do // Iterate
      begin
        HS := FSections.ItemByPos[i];
        if HS.FStickySize <= 0 then MarkStickySections;
        if HS.Resizable and HS.Visible then HS.Width := Round(w * HS.FStickySize);
      end; // for
      AdjustStickySize(nil);
    end;
    FOldWidth := ClientWidth;
    FInStick := False;
  end;
  inherited;
end;

procedure TCustomElHeader.AllocateLineDC;
begin

  FLineDC := GetDCEx(Handle, 0, DCX_CACHE {or DCX_CLIPSIBLINGS }or DCX_PARENTCLIP
    or DCX_LOCKWINDOWUPDATE);

end;

procedure TCustomElHeader.ReleaseLineDC;
begin

  ReleaseDC(Handle, FLineDC);

end;

procedure TCustomElHeader.DrawLine(Restore: boolean);
begin
  FHeaderLineVis := not FHeaderLineVis;

  PatBlt(FLineDC, FHeaderLine, 0, 1, Parent.Height, PATINVERT);

end;

procedure TCustomElHeader.Paint;
begin
  FPainting := True;
  RedrawSections;
  FPainting := False;
end;

procedure TCustomElHeader.SetSections;
begin
  FSections.Assign(value);
end;

procedure TCustomElHeader.SetLockHeight(newValue: Boolean);
{ Sets data member FLockHeight to newValue. }
begin
  if (FLockHeight <> newValue) then
  begin
    FLockHeight := newValue;
    if (not FLockHeight) and (Parent <> nil) and (not (csLoading in Parent.ComponentState)) then
       AdjustHeaderHeight;
  end; { if }
end; { SetLockHeight }

procedure TCustomElHeader.SetFilterColor(newValue: TColor);
var
  i: integer;
  S: TElHeaderSection;
begin
  if (FFilterColor <> newValue) then
  begin
    FFilterColor := newValue;
    for i := 0 to FSections.Count - 1 do // Iterate
    begin
      S := FSections[i];
      if (S.Visible) and (S.FFilterEnabled) and (not S.FFilterIsActive) then S.UpdateSection;
    end; // for
  end; { if }
end; { SetFilterColor }

procedure TCustomElHeader.TriggerSectionAutoSizeEvent;
begin
  if (assigned(FOnSectionAutoSize)) then
    FOnSectionAutoSize(Self, Section);
end; { TriggerSectionAutoSizeEvent }

procedure TCustomElHeader.TriggerMeasureSectionEvent(Section: TElHeaderSection; var Size: TPoint);
begin
  if assigned(FOnMeasureSection) then FOnMeasureSection(Self, Section, Size);
end;

procedure TCustomElHeader.TriggerFilterCallEvent;
begin
  if (assigned(FOnFilterCall)) then FOnFilterCall(Self, Section);
end; { TriggerFilterCallEvent }

procedure TCustomElHeader.WMLButtonDblClk(var Msg: TWMLButtonDblClk); { private }
begin
  IntLButtonDblClick(Msg.XPos, Msg.YPos);
  inherited;
end; { WMLButtonDblClk }

procedure TCustomElHeader.SetActiveFilterColor(newValue: TColor);
var
  i: integer;
  S: TElHeaderSection;
begin
  if (FActiveFilterColor <> newValue) then
  begin
    FActiveFilterColor := newValue;
    for i := 0 to FSections.Count - 1 do // Iterate
    begin
      S := FSections[i];
      if (S.Visible) and (S.FFilterEnabled) and S.FFilterIsActive then S.UpdateSection;
    end; // for
  end; { if }
end; { SetFilterColor }

procedure TCustomElHeader.SetFlat(newValue: Boolean);
{ Sets data member FFlat to newValue. }
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    if (HandleAllocated) then
      AdjustHeaderHeight;
  end; { if }
end; { SetFlat }

procedure TCustomElHeader.CMHintShow(var Msg: TCMHintShow); { private }

begin
  inherited;

  IntHintShow(Msg.HintInfo^);

end;

procedure TCustomElHeader.SetImages(newValue: TCustomImageList);
{ Sets data member FImages to newValue. }
begin
  if (FImages <> newValue) then
  begin
    if FImages <> nil then
    begin
      if not (csDestroying in FImages.ComponentState) then
        FImages.RemoveFreeNotification(Self);
      FImages.UnRegisterChanges(FImageChangeLink);
    end;
    FImages := newValue;
    if FImages <> nil then
    begin
      FImages.RegisterChanges(FImageChangeLink);
      FImages.FreeNotification(Self);
      if not LockHeight then
         AdjustHeaderHeight;
    end
    else
    if not LockHeight then
      AdjustHeaderHeight;
    if FPainting then Exit;
    if (HandleAllocated) then
      Invalidate;//Repaint;
  end; { if }
end; { SetImages }

procedure TCustomElHeader.SetAlphaImages(newValue: TCustomImageList);
{ Sets data member FAlphaImages to newValue. }
begin
  if (FAlphaImages <> newValue) then
  begin
    if FAlphaImages <> nil then
    begin
      if not (csDestroying in FAlphaImages.ComponentState) then
        FAlphaImages.RemoveFreeNotification(Self);
      FAlphaImages.UnRegisterChanges(FAlphaImageChangeLink);
    end;
    FAlphaImages := newValue;
    if FAlphaImages <> nil then
    begin
      FAlphaImages.RegisterChanges(FAlphaImageChangeLink);
      FAlphaImages.FreeNotification(Self);
{      if not LockHeight then
         AdjustHeaderHeight; }
    end
    else
{    if not LockHeight then
      AdjustHeaderHeight; }
    if FPainting then Exit;
    if (HandleAllocated) then
      Invalidate;//Repaint;
  end; { if }
end; { SetAlphaImages }

procedure TCustomElHeader.OnImageListChange(Sender: TObject); { private }
begin
  if FPainting then Exit;
  if not LockHeight then
    AdjustHeaderHeight;
  if (HandleAllocated) then
    Invalidate;//Repaint;
end; { OnImageListChange }

procedure TCustomElHeader.DoVisChanged(Section: TElHeaderSection); { protected }
begin
  if Assigned(FOnVisibleChange) then FOnVisibleChange(Self, Section);
end; { DoVisChanged }

procedure TCustomElHeader.DoSectionDelete(Section: TElHeaderSection); { protected }
begin
  if assigned(FOnSectionDelete) then FOnSectionDelete(Self, Section);
end; { DoSectionDelete }

procedure TCustomElHeader.DoSectionMove(Section: TElHeaderSection; OldPos, NewPos: integer); { protected }
begin
  if assigned(FOnSectionMove) then FOnSectionMove(Self, Section, OldPos, NewPos);
end; { DoSectionMove }

procedure TCustomElHeader.DoSectionResizing(Section: TElHeaderSection; State: TElHResizingStates; NewWidth: integer); { protected }
begin
  if Assigned(FOnSectionResizing) then FOnSectionResizing(Self, Section, State, NewWidth);
end; { DoSectionResizing }

procedure TCustomElHeader.DoSectionReindex(Section: TElHeaderSection; OldIndex, NewIndex: integer);
begin
  if assigned(FOnSectionReindex) then FOnSectionReindex(Self, Section, OldIndex, NewIndex);
end;

procedure TCustomElHeader.DoSectionResize(Section: TElHeaderSection); { protected }
begin
  RecalcColumnsWidth;
  if Assigned(FOnSectionResize) then FOnSectionResize(Self, Section);
end; { DoSectionResize }

procedure TCustomElHeader.DoSectionClick(Section: TElHeaderSection); { protected }
begin
  if (Assigned(FOnSectionClick)) then FOnSectionClick(Self, Section);
end; { DoSectionClick }

procedure TCustomElHeader.DoSectionDraw(Canvas: TCanvas; Section: TElHeaderSection; R: TRect; Pressed: boolean); { protected }
begin
  if Assigned(FOnSectionDraw) then FOnSectionDraw(Self, Canvas, Section, R, Pressed);
end; { DoSectionDraw }

procedure TCustomElHeader.DoNotifySectionChange(Section: TElHeaderSection; Change: TSectionChangeMode);
begin
  if (assigned(FOnSectionChange)) then
    FOnSectionChange(Self, Section, Change);
end; { TriggerSectionChangeEvent }

procedure TCustomElHeader.CMFontChanged(var Msg: TMessage);
begin
  inherited;
  OnFontChange(Font);
end;

procedure TCustomElHeader.OnFontChange(Sender: TObject); { protected }
begin
  if not LockHeight then
     AdjustHeaderHeight;

  Canvas.Font.Assign(Font);
  if (HandleAllocated) then
    Invalidate;//Repaint;
end; { OnFontChange }

procedure TCustomElHeader.DoSectionCreate(Section: TElHeaderSection);
begin
  if (assigned(FOnSectionCreate)) then FOnSectionCreate(Self, Section);
end; { TriggerSectionCreateEvent }

procedure TCustomElHeader.GetDragImage; { private }
var
  R: TRect;
  S: TElHeaderSection;
  C: TColor;
  hls2: integer;
  lum: integer;

begin
  S := GetSectionAt(XPos, 0);
  if S = nil then Exit;
  R := GetSectionRect(S.Index);
  DragRect := R;
  DragBmp := TBitmap.Create;
  DragBmp.Height := R.Bottom - R.Top + 1;
  DragBmp.Width := R.Right - R.Left + 1;
  R := Rect(0, 0, DragBmp.Width - 1, DragBmp.Height - 1);
  DragBmp.Canvas.Brush.Color := Color;
  DragBmp.Canvas.FillRect(R);
  DragBmpMask := TBitmap.Create;
  DragBmp.Canvas.Font.Assign(Font);
  RedrawSection(DragBmp.Canvas, S, R, S.Left, True);
  DragBmpMask.Width := DragBmp.Width;
  DragBmpMask.Height := DragBmp.Height;
  DragBmpMask.Canvas.CopyRect(R, DragBmp.Canvas, R);

  if S.FParentColor then
    C := Color
  else
    C := S.FColor;

  begin
    hls2 := RGBtoHLS(ColorToRGB(C));
    lum := Hi(hls2 and $FFFF);
    Dec(lum, lum shr 2);
    if lum > 239 then
      lum := 239;
    hls2 := (lum shl 8) or (hls2 and $FF00FF);
    C := TColor(HLStoRGB(hls2))
  end;

  DragBmpMask.Mask(C);
end; { GetDragImage }

(*
procedure TCustomElHeader.GetDragImage; { private }
var //i: integer;
  R: TRect;
  S: TElHeaderSection;
  i,
  j: integer;
begin
  S := GetSectionAt(XPos, 0);
  if S = nil then Exit;
  R := GetSectionRect(S.Index);
  DragRect := R;
  DragBmp := TBitmap.Create;
  DragBmp.Height := R.Bottom - R.Top + 1;
  DragBmp.Width := R.Right - R.Left + 1;
  DragBmp.Canvas.Brush.Color := Color;
  R := Rect(0, 0, DragBmp.Width - 1, DragBmp.Height - 1);
  DragBmp.Canvas.FillRect(R);
  DragBmpMask := TBitmap.Create;
  DragBmp.Canvas.Font.Assign(Font);
  RedrawSection(DragBmp.Canvas, S, R);
  DragBmpMask.Width := DragBmp.Width;
  DragBmpMask.Height := DragBmp.Height;
  DragBmpMask.Canvas.CopyRect(R, DragBmp.Canvas, R);
  DragBmpMask.Mask(Color);
end; { GetDragImage }
*)
procedure TCustomElHeader.SetTracking(newValue: boolean);
begin
  if FTracking <> newValue then
  begin
    FTracking := newValue;
    if (not FTracking) and (not IsThemed) then
    begin
      FTrackSection := nil;
      if (HandleAllocated) then
        Invalidate;//Repaint;
    end;
  end;
end;

procedure TCustomElHeader.WMEraseBkgnd(var Msg: TWMEraseBkgnd); { private }
begin
  Msg.Result := 1;
end; { WMEraseBkgnd }

procedure TCustomElHeader.WMKeyDown(var Message: TWMKeyDown);
begin
  inherited;
  if (Message.CharCode = VK_ESCAPE) and (KeyDataToShiftState(Message.KeyData) = []) and
     (FDropSrc <> nil) then
  begin
    IntLButtonUp(FDropSrc.Left, 1);
  end;
end;

procedure TCustomElHeader.Save;
var
  SaveKey, CKey: string;
  i: integer;
begin
  if Assigned(FStorage) then
  begin
    SaveKey := FStorage.CurrentKey;
    if FStorage.OpenKey(StoragePath + FStorage.Delimiter + 'ElHeader', True) then
    begin
      FStorage.WriteInteger(CKey, 'Width', Width);
      for i := 0 to FSections.Count - 1 do // Iterate
      begin
        CKey := 'Section' + IntToStr(i);
        FStorage.WriteBool(CKey, 'Visible', FSections[i].FVisible);
        FStorage.WriteBool(CKey, 'Expanded', FSections[i].Expanded);
        FStorage.WriteInteger(CKey, 'Width', FSections[i].Width);
        FStorage.WriteInteger(CKey, 'Align', Integer(FSections[i].Alignment));
        FStorage.WriteInteger(CKey, 'SortOrder', Integer(FSections[i].SortMode));
      end; // for
      FStorage.OpenKey(SaveKey, False);
    end;
  end;
end; {Save}

procedure TCustomElHeader.Restore;
var
  SaveKey, CKey: string;
  i,
  j,
  k: integer;
  b: boolean;
  align: Integer;
  begin
  Inc(LoadingCount);
  if Assigned(FStorage) then
  begin
    SaveKey := FStorage.CurrentKey;
    if FStorage.OpenKey(StoragePath + FStorage.Delimiter + 'ElHeader', False) then
    begin
      FStorage.ReadInteger(CKey, 'Width', Width, k);
      for i := 0 to FSections.Count - 1 do // Iterate
      begin
        CKey := 'Section' + IntToStr(i);
        FStorage.ReadInteger(CKey, 'Align', Integer(hsaLeft), align);
        FSections[i].FAlignment := TElSAlignment(align);
        FStorage.ReadBool(CKey, 'Visible', FSections[i].FVisible, FSections[i].FVisible);
        if FStorage.ReadBool(CKey, 'Expanded', FSections[i].Expanded, b) then FSections[i].Expanded := b;
        if FStorage.ReadInteger(CKey, 'Width', FSections[i].Width, j) then
          if ((FSections[i].Resizable) and (StickySections)) then
            FSections[i].Width := Trunc(j * (Width / k))
          else
            FSections[i].Width := j;
        if FStorage.ReadInteger(CKey, 'SortOrder', Integer(FSections[i].SortMode), j) then FSections[i].SortMode := TElSSortMode(j);
      end; // for
      FStorage.OpenKey(SaveKey, False);
    end;
  end;
  Dec(LoadingCount);
  b := FStickySections;
  FStickySections := False;
  SetStickySections(b);
end; {Restore}

procedure TCustomElHeader.EditExit(Sender: TObject);
begin
  if FDoingLookup then
  begin
    FLookup.Visible := False;
    FDoingLookup := False;
    DoSectionLookupDoneEvent(FLookupSection, FLookup.Text, False);
    try
      Windows.SetFocus(FFocusedCtl);
      except
      on E: Exception do
      begin
      end;
    end;
  end;
end;

procedure TCustomElHeader.EditChange;
var
  S: TElFString;
  R: TRect;
begin
  if not FIgnoreLookupChange then
  begin
    S := FLookup.Text;
    DoSectionLookupEvent(FLookupSection, S);
    if S <> FLookup.Text then
    begin
      FIgnoreLookupChange := True;
      FLookup.Text := S;
      FIgnoreLookupChange := False;
    end;
    R := GetSectionRect(FLookupSection.Index);
    FLookup.BoundsRect := R;
  end;
end;

procedure TCustomElHeader.EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = []) and
  ((Key = VK_RETURN) or (Key = VK_ESCAPE))
  then Key := 0;
end;

procedure TCustomElHeader.EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i: integer;
begin
  if (Shift = []) then
  begin
  if Key = VK_RETURN then
  begin
      FDoingLookup := False;
      DoSectionLookupDoneEvent(FLookupSection, FLookup.Text, True);
      i := FLookupSection.FLookupHist.IndexOf(FLookup.Text);
      if i <> -1 then FLookupSection.FLookupHist.Delete(i);
      FLookupSection.FLookupHist.Insert(0, FLookup.Text);
      FLookup.Visible := False;
      try
        Windows.SetFocus(FFocusedCtl);
        except
        on E: Exception do
        begin
        end;
      end;
      Key := 0;
    end;
    if Key = VK_ESCAPE then
    begin
      FDoingLookup := False;
      DoSectionLookupDoneEvent(FLookupSection, FLookup.Text, False);
      FLookup.Visible := False;
      try
        Windows.SetFocus(FFocusedCtl);
        except
        on E: Exception do
        begin
        end;
      end;
      Key := 0;
    end;
  end;
end;

procedure TCustomElHeader.SetLookupStyle(Value: TComboBoxStyle);
begin
  if FLookupStyle <> Value then
  begin
    FLookupStyle := Value;
    if Assigned(Flookup) then
      FLookup.Style := FLookupStyle;
  end;
end;

procedure TCustomElHeader.SetStorage(newValue: TElIniFile);
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

procedure TCustomElHeader.Notification(AComponent: TComponent; Operation: TOperation);
var
  i: integer;
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin

    if AComponent = FStorage then FStorage := nil;

    if AComponent = Images then
       Images := nil;
    if AComponent = FImgForm then
    begin
      FImgForm := nil;
      if (HandleAllocated) then
        Invalidate;
    end;
    if AComponent is TPopupMenu then
      for i := 0 to FSections.Count - 1 do
        if TElHeaderSection(FSections.FList[i]).FPopupMenu = AComponent then TElHeaderSection(FSections.Item[i]).FPopupMenu := nil;
  end;
end;

procedure TCustomElHeader.DoSectionExpandEvent(Section: TElHeaderSection);
begin
  if (assigned(FOnSectionExpand)) then FOnSectionExpand(Self, Section);
end;

procedure TCustomElHeader.DoSectionCollapseEvent(Section :
  TElHeaderSection);
begin
  if (assigned(FOnSectionCollapse)) then FOnSectionCollapse(Self, Section);
end;

procedure TCustomElHeader.DoSectionLookupEvent;
begin
  if (assigned(FOnHeaderLookup)) then FOnHeaderLookup(Self, Section, Text);
end; {TriggerHeaderLookupEvent}

procedure TCustomElHeader.DoSectionLookupDoneEvent;
begin
  if (assigned(FOnHeaderLookupDone)) then FOnHeaderLookupDone(Self, Section, Text, Accepted);
end; {TriggerHeaderLookupDoneEvent}

procedure TCustomElHeader.WMRButtonUp(var Msg: TWMRButtonUp);
begin
  if IntRButtonUp(Msg.XPos, Msg.YPos) then
    Msg.Result := 0
  else
    inherited;
end; {WMRButtonUp}

procedure TCustomElHeader.WMRButtonDown(var Msg: TWMRButtonDown);
begin
  if IntRButtonDown(Msg.XPos, Msg.YPos) then
    Msg.Result := 0
  else
    inherited;
end;

procedure TCustomElHeader.Loaded;
var
  i: integer;
  O: TComponent;
  Form: TForm;
  b: boolean;
begin
  inherited Loaded;
  Form := LMDGetOwnerForm(Self);
  if Form = nil then Exit;
  for i := 0 to FSections.Count - 1 do
  begin
    if FSections[i].FPopupName <> '' then
    begin
      O := Form.FindComponent(FSections[i].FPopupName);
      if (O <> nil) and (O is TPopupMenu) then FSections[i].FPopupMenu := TPopupMenu(O);
    end;
  end;
  b := FStickySections;
  FStickySections := False;
  SetStickySections(b);
  if Sections.FVer13 and RightAlignedOrder then
    CancelOldRightAlignedOrder;
  AdjustHeaderHeight;
  RecalcColumnsWidth;
end;

procedure TCustomElHeader.WMSize(var Msg: TWMSize);
begin
  IntSize;
  inherited;
  AdjustHeaderHeight;
end;

procedure TCustomElHeader.SetStickySections(newValue: Boolean);
var
  i, w: integer;
  HS: TElHeaderSection;
begin
  if IsLoading then
  begin
    FStickySections := newValue;
    Exit;
  end;
//  if (FStickySections <> newValue) then
  begin
    FStickySections := newValue;
    if newValue then
    begin
      w := GetResizableWidth;
      for i := 0 to FSections.Count - 1 do // Iterate
      begin
        HS := FSections[i];
        if HS.Visible and (HS.Resizable) and (not IsLoading) and (w <> 0) then
          HS.FStickySize := HS.Width / w
        else
          HS.FStickySize := 0;
      end; // for
    end;
  end; {if}
end; {SetStickySections}

function TCustomElHeader.IsLoading: Boolean;
begin
  if Owner <> nil then
  begin
    Result := (csLoading in ComponentState) or (LoadingCount > 0);
    if not Result then Result := csLoading in Owner.ComponentState;
  end
  else
  begin
    Result := csLoading in ComponentState;
  end;
end; {IsLoading}

procedure TCustomElHeader.SetRightAlignedText(newValue: Boolean);
begin
  if (FRightAlignedText <> newValue) then
  begin
    FRightAlignedText := newValue;
    RecreateWnd;
    end; {if}
end;

procedure TCustomElHeader.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if RightAlignedText then
  begin
    Params.ExStyle := Params.ExStyle or WS_EX_RTLREADING or WS_EX_LEFTSCROLLBAR or WS_EX_RIGHT;
  end;
end;

procedure TCustomElHeader.SetRightAlignedOrder(newValue: Boolean);
{var
  FList: TLMDObjectList;
  i: integer;}
begin
  if (FRightAlignedOrder <> newValue) then
  begin
    FRightAlignedOrder := newValue;
    {if csLoading in ComponentState then Exit;
    FList := TLMDObjectList.Create;
    for i := 0 to FSections.FList.Count - 1 do
      FList.Add(FSections.FList[FSections.FList.Count - i - 1]);
    FSections.FList.Clear;
    for i := 0 to FList.Count - 1 do
      FSections.FList.Add(FList[i]);
    FList.Free;}
    Invalidate;
  end; {if}
end;

procedure TCustomElHeader.CMSysColorChange(var Msg: TMessage);
begin
  inherited;
  Invalidate;//Repaint;
end;

function TCustomElHeader.GetIsDesigning: Boolean;
{ Returns the value of data member FIsDesigning. }
begin
  Result := csDesigning in ComponentState;
end;  { GetIsDesigning }

procedure TCustomElHeader.SetIsDesigning(newValue: Boolean);
{ Sets data member FIsDesigning to newValue. }
begin
  if (IsDesigning <> newValue) then
  begin
    SetDesigning(newValue);
  end;  { if }
end;  { SetIsDesigning }

procedure TCustomElHeader.SetInvertSortArrows(newValue: Boolean);
{ Sets data member FInvertSortArrows to newValue. }
begin
  if (FInvertSortArrows <> newValue) then
  begin
    FInvertSortArrows := newValue;
    if (HandleAllocated) then
      Invalidate;//Repaint;
  end;  { if }
end;  { SetInvertSortArrows }

procedure TCustomElHeader.WMPaint(var Msg: TWMPaint);  { private }
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  R: TRect;
  ARgn: HRGN;

begin
  if (Msg.DC <> 0) then PaintHandler(Msg)
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      GetClipBox(DC, R);
      if IsRectEmpty(R) then
        R := ClientRect
      else
      begin
        InflateRect(R, 1, 1);
      end;

      with R do
        ARgn := CreateRectRgn(Left, Top, right, Bottom);
      SelectClipRgn(MemDC, ARgn);
      //InvalidateRect(MemDC, @R, False);
      Perform(WM_ERASEBKGND, MemDC, MemDC);
      Msg.DC := MemDC;
      WMPaint(Msg);
      SelectClipRgn(MemDC, 0);
      DeleteObject(ARgn);
      Msg.DC := 0;
      with R do
        BitBlt(DC, Left, Top, Right, Bottom, MemDC, Left, Top, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;  { WMPaint }

procedure TCustomElHeader.ImageFormChange(Sender: TObject);
begin
  if (HandleAllocated) then
    Invalidate;
end;

procedure TCustomElHeader.SetImageForm(newValue: TElImageForm);
begin
  if FImgForm <> newValue then
  begin
    if FImgForm <> nil then
    begin
      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);
      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    if newValue <> nil then
       newValue.FreeNotification(Self);
    FImgForm := newValue;
    if FImgForm <> nil then
    begin
      FImgForm.RegisterChanges(FImgFormChLink);
      FImgForm.FreeNotification(Self);
    end;
    if HandleAllocated and (not (csDestroying in ComponentState)) then
    begin
    RecreateWnd;
      Perform(CM_COLORCHANGED, 0, 0);
    end;
  end;
end;

procedure TCustomElHeader.SetLeftPos(newValue: Integer);
{ Sets data member FLeftPos to newValue. }
begin
  if (FHPos <> newValue) then
  begin
    FHPos := newValue;
    if (HandleAllocated) then
      Invalidate;//Repaint;
  end;  { if }
end;  { SetLeftPos }

function TCustomElHeader.GetLockedSection: TElHeaderSection;
begin
  if FFixedColNum > 0 then
    Result := Sections[0]
  else
    Result := nil;
end;

procedure TCustomElHeader.SetLockedSection(newValue: TElHeaderSection);
begin
{
  if (FLockedSection <> newValue) then
  begin
    FLockedSection := newValue;
    if newValue <> nil then
      Sections.MoveSection(FLockedSection, 0);
    if (HandleAllocated) then
      Invalidate;//Repaint;
  end;
}
end;

procedure TCustomElHeader.CMExit(var Msg: TCMExit);  { private }
begin
  inherited;
  intExit;
end;  { CMExit }

function TElHeaderSections.GetSectionsOrder: string;
var
  i: integer;
  Section: TElHeaderSection;
begin
  Result := '';
  for i := 0 to FList.Count - 1 do
  begin
    Section := TElHeaderSection(FList[i]);
    Result := Result + 'i' + IntToStr(Section.Index) + ':w' + IntToStr(Section.Width) + ':v';
    if Section.Visible then
      Result := Result + 't,'
    else
      Result := Result + 'f,';
  end;
end; { GetSectionsOrder }

procedure TElHeaderSections.SetSectionsOrder(newValue: string);
var
  i: integer;
  Section: TElHeaderSection;
  s: string;
begin
  if (csDesigning in Owner.ComponentState) or (csLoading in Owner.ComponentState) or
     ((Owner.Owner <> nil) and ((csDesigning in Owner.Owner.ComponentState) or
                               (csLoading in Owner.Owner.ComponentState))) then
    Exit;

  i := 0;
  while newValue <> '' do
  begin
    s := copy(newValue, 2, pos(':', newValue) - 2);
    delete(newValue, 1, pos(':', newValue));
    Section := Item[StrToInt(s)];
    if Section <> nil then
    begin
      MoveSection(Section, i);
      s := copy(newValue, 2, pos(':', newValue) - 2);
      delete(newValue, 1, pos(':', newValue));
      Section.Width := StrToInt(s);
      if (pos('vf,', newValue) = 1) or (pos('vf;', newValue) = 1) then
        Section.Visible := False
      else
        Section.Visible := True;
      delete(newValue, 1, 3);
      Inc(i);
    end
    else
      delete(newValue, 1, 3);
  end;
end; { SetSectionsOrder }

procedure TElHeaderSections.Reindex;
var
  i: integer;
  LSection: TElHeaderSection;
begin
  for i := 0 to FList.Count - 1 do
  begin
    LSection := TElHeaderSection(FList[i]);
    if LSection.FIndex <> i then
      FOwner.DoSectionReindex(LSection, LSection.FIndex - 1, i - 1);
    LSection.FIndex := i;
  end;
end;

procedure TElHeaderSections.BeginUpdate;
begin
  FOwner.BeginUpdate;
end;

procedure TElHeaderSections.EndUpdate;
begin
  FOwner.EndUpdate;
end;

procedure TCustomElHeader.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TCustomElHeader.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
  begin
    if DeletionHappened then
    begin
      DeletionHappened := False;
      DoSectionDelete(nil);
      Sections.Reindex;
    end;
    if AdditionHappened then
    begin
      AdditionHappened := False;
      DoSectionCreate(nil);
    end;
    RecalcColumnsWidth;
    Update;
  end;
end;

procedure TCustomElHeader.Update;
begin
  if FUpdateCount = 0 then
  begin
    Invalidate;
    inherited;
  end;
end;

{$ifndef LMDDISABLE_ELHEADER_SETUP}
function TCustomElHeader.Setup: boolean;
var
  Form: TfrmHeaderSetup;
  PropInfo: PPropInfo;
  i: integer;
begin
  Application.CreateForm(TfrmHeaderSetup, Form);
  Form.LoadHeaderSections(FSections);
  with Form do
    for i := 0 to ComponentCount - 1 do
    begin
      PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleManager');
      if PropInfo <> nil then
        SetObjectProp(Components[i], PropInfo, Self.StyleManager);
      PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleName');
      if PropInfo <> nil then
        SetStrProp(Components[i], PropInfo, Self.StyleName);
    end;

  Result := (Form.ShowModal = mrOk);
  if Result then Form.SaveHeaderSections(FSections);
  Form.Free;
end;
{$endif}
procedure TCustomElHeader.SetWrapCaptions(newValue: Boolean);
{ Sets data member FWrapCaptions to newValue. }
begin
  if (FWrapCaptions <> newValue) then
  begin
    FWrapCaptions := newValue;
    AdjustHeaderHeight;
  end;  { if }
end;  { SetWrapCaptions }

procedure TCustomElHeader.IntLButtonDown(XPos, YPos: SmallInt);
var
  THS, THS1: TElHeaderSection;
  b: boolean;
  rm: integer;
begin
  //  SendCancelMode(Self);
  if FDoingLookup then
  begin
    FDoingLookup := False;
    FLookup.Visible := False;
    DoSectionLookupDoneEvent(FLookupSection, FLookup.Text, False);
    try
      Windows.SetFocus(FFocusedCtl);
      except
      on E: Exception do
      begin
      end;
    end;
  end
  else
  if not (csNoStdEvents in ControlStyle) then
  begin
    if InResizeArea(XPos, THS) and (THS.FResizable) then
    begin
      FResizing := True;
      FResizeSection := THS;
      THS1 := FTrackSection;
      FTrackSection := nil;
      if THS1 <> nil then
        THS1.UpdateSection;
      Screen.Cursor := crHSplit;
      SetCapture(Handle);
      if RightAlignedOrder then
        FHeaderLine := FResizeSection.Left
      else
        FHeaderLine := FResizeSection.Right;

      if not FResizeSection.Locked then
         Dec(FHeaderLine, FHPos);
      if RightAlignedOrder then
        FLineTab := FHeaderLine - XPos
      else
        FLineTab := XPos - FHeaderLine;
      if (not ResizeOnDrag) then
      begin
        //        SendCancelMode(Self);
        AllocateLineDC;
        DrawLine(False);
      end;
      DoSectionResizing(THS, trsBegin, THS.Width);
    end // Resizing
    else
    begin
      FPressCoord := Point(XPos, YPos);
      FPressed := True;
      if FPressedItem <> nil then
      begin
        THS := FPressedItem;
        FPressedItem := nil;
        THS.UpdateSection;
      end;
      FPressedItem := GetSectionAt(XPos, YPos);
      THS := FPressedItem;
      if FPressedItem <> nil then
      begin
        b := True;
        rm := FPressedItem.Right - 4;

        if not FPressedItem.Locked then

        Dec(rm, FHPos);
        if FPressedItem.Expandable then
        begin
          if ((rm + 13 - FPressedItem.Width) + (ResizeWidth - 4) < RM)
            and LMDInRange(XPos, rm - 6 - (ResizeWidth - 4), RM)
            and LMDInRange(YPos, 2, 9) then
          begin
            THS := FPressedItem;
            FPressedItem := nil;
            THS.Expanded := not THS.Expanded;
            if THS.Expanded then
              DoSectionExpandEvent(THS)
            else
              DoSectionCollapseEvent(THS);
            b := False;
          end;
        end;
        if THS.FLookupEnabled then
        begin

          if not THS.Locked then

          if ((rm + 13 - THS.Width) + (ResizeWidth - 4) < RM)
            and LMDInRange(XPos, rm - 6 - (ResizeWidth - 4), RM)
            and LMDInRange(YPos, 12, 16) then
          begin
            THS.ShowLookup;
            b := False;
          end;
        end;
        if THS.FFilterEnabled then
        begin
          if THS.LookupEnabled or THS.Expandable then
            Dec(rm, 8);
          if ((THS.Width - ResizeWidth) > 4)
            and LMDInRange(Xpos, rm - 6, RM)
            and LMDInRange(YPos, 12, 16) then
          begin
            TriggerFilterCallEvent(THS);
            b := False;
          end;
        end;
        if b and (FPressedItem.FAllowClick {or FPressed}) then
          FPressedItem.UpdateSection
        else
          FPressedItem := nil;
      end;
    end; // not Resizing
  end;
end;

procedure TCustomElHeader.IntLButtonUp(XPos, YPos: SmallInt);
var
  THS: TElHeaderSection;
  NewPos: integer;
  R: TRect;
begin
  if not (csNoStdEvents in ControlStyle) then
  begin
    if FResizing then
    begin
      FResizing := False;
      Screen.Cursor := Cursor;
      ReleaseCapture;
      if (not FResizeOnDrag) then
      begin
        if (FHeaderLineVis) then
          DrawLine(True);
        ReleaseLineDC;
        if RightAlignedOrder then
        begin
//          Dec(FHeaderLine, FResizeSection.Left);
          if not FResizeSection.Locked then
            Inc(FHeaderLine, FHPos);
          FResizeSection.Width := FResizeSection.Right - FHeaderLine;
        end
        else
        begin
          Dec(FHeaderLine, FResizeSection.Left);
          if not FResizeSection.Locked then
            Inc(FHeaderLine, FHPos);
          FResizeSection.Width := FHeaderLine;
        end;
      end;
      DoSectionResizing(FResizeSection, trsEnd, FResizeSection.Width);
      DoSectionResize(FResizeSection);
      CalcFixedColWidth;
      FResizeSection := nil;
      Invalidate;
      Update;
    end
    else
    if FDropSrc <> nil then
    begin
      FDropTrg := GetSectionAt(XPos, YPos);
      if (FDropSrc <> FDropTrg) then
      begin
        if FDropTrg = nil then
        begin
          FDropTrg := GetSectionAt(XPos, 1);
        end;

        if FDropTrg = nil then
        begin
          if XPos <= 0 then
            NewPos := 0
          else
            NewPos := Sections.Count - 1
        end
        else
//          NewPos := FSections.FList.IndexOf(FDropTrg);
          NewPos := FDropTrg.Position;
        FSections.MoveSection(FDropSrc, NewPos);
      end;
      FPressedItem := nil;
      FTrackSection := nil;
      FDropSrc := nil;
      FDropTrg := nil;
      SaveBmp.Free;
      SaveBmp := nil;
      DragBmp.Free;
      DragBmp := nil;
      DragBmpMask.Free;
      ReleaseCapture;
      R := ClientRect;
      InvalidateRect(Handle, @R, True);
      Update;
    end
    else
    begin
      FPressed := False;
      THS := FPressedItem;
      FPressedItem := nil;
      if THS <> nil then
      begin
        THS.UpdateSection;
        if (GetSectionAt(FPressCoord.X, FPressCoord.Y) = GetSectionAt(XPos, YPos)) then
          DoSectionClick(THS);
        THS := GetSectionAt(XPos, YPos);
        if (THS <> FTrackSection) then
        begin
          THS := FTrackSection;
          FTrackSection := nil;
          if THS <> nil then
            THS.UpdateSection;
        end;
      end;
    end;
  end;
end;

function TCustomElHeader.IntRButtonDown(XPos, YPos: SmallInt): boolean;
var
  S: TElHeaderSection;
  P: TPoint;
begin
  if (FResizing) or (FDropSrc <> nil) then
    Result := True
  else
  begin
    Result := False;
    S := Self.GetSectionAt(XPos, YPos);
    P := ClientToScreen(Point(XPos, YPos));
    if (S = nil) or (S.PopupMenu = nil) then
    begin
      if Assigned(PopupMenu) and (PopupMenu.AutoPopup) then
        PopupMenu.Popup(P.X, P.Y);
    end
    else
    if S.FPopupMenu.AutoPopup then
      S.FPopupMenu.Popup(P.X, P.Y);
  end;
end;

function TCustomElHeader.IntRButtonUp(XPos, YPos: SmallInt): boolean;
begin
  Result := FResizing or (FDropSrc <> nil);
end;

procedure TCustomElHeader.IntLButtonDblClick(XPos, YPos: SmallInt);
var
  S: TElHeaderSection;
  SP: TElSectionPart;
begin
  S := GetSectionAtEx(XPos, YPos, SP);
  if (SP = espResizeArea) and (S <> nil) and (S.Resizable) then
    TriggerSectionAutoSizeEvent(S);
end;

procedure TCustomElHeader.IntMouseMove(XPos, YPos: SmallInt);
var
  THS: TElHeaderSection;
  AMsg: TMessage;
  NewPos,
  NewWidth,
  L: integer;
  XOffs: integer;
  TmpBmp: TBitmap;

  function FixedRighterSections(Section: TElHeaderSection): integer;
  var i: integer;
      ASect: TElHeaderSection;
  begin
    Result := 0;
    for i := Section.Position + 1 to FSections.FList.Count - 1 do
    begin
      ASect := FSections.ItemByPos[i];
      if not ASect.Resizable then Inc(Result, ASect.Width);
    end;
  end;

begin
  if FPressed and FAllowDrag and Assigned(FPressedItem) and not FPressedItem.Locked then
  begin
    if (FPressedItem <> nil) and (FDropSrc = nil)
      and (sqrt(sqr(FPressCoord.X - XPos) + sqr(FPressCoord.Y - YPos)) >= 5)
    then
    begin
      (*
      FDropSrc := FTrackSection;
      FDropSrc.UpdateSection;
      if FDropSrc <> FPressedItem then
      *)
      FTrackSection := nil;
      FDropSrc := FPressedItem;
      FPressed := False;
      FDropSrc.UpdateSection;

      GetDragImage(FPressCoord.X);
      THS := GetSectionAt(FPressCoord.X, FPressCoord.Y);

      if Assigned(THS) and not THS.Locked then
        Inc(FPressCoord.X, FHPos);

      SetCapture(Handle);
      FDropTrg := nil;
      FDragCoord := FPressCoord;
      DragRect := GetSectionRect(FDropSrc.Index);

//      if (not RightAlignedOrder) and Assigned(THS) and not THS.Locked then
//        OffsetRect(DragRect, - FHPos, 0);
    end;
  end;
  if (FAllowDrag) and (not FPressed) and (FDropSrc <> nil) then
  begin
    FDropTrg := GetSectionAt(XPos, YPos);
    if FMoveOnDrag then
    begin
      if (FDropSrc <> FDropTrg) then
      begin
        if FDropTrg = nil then
        begin
          NewPos := Sections.Count - 1;
          FSections.MoveSection(FDropSrc, NewPos);
        end
        else if ((FDropSrc.Position < FDropTrg.Position) and (FDropTrg.Right - FDropSrc.Width < XPos))
          or ((FDropSrc.Position > FDropTrg.Position) and (FDropTrg.Left + FDropSrc.Width > XPos)) then
        begin
          NewPos := FSections.FList.IndexOf(FDropTrg);
          FSections.MoveSection(FDropSrc, NewPos);
        end;
      end;
    end;

    XOffs := 0;
    if not FDropSrc.Locked then
      XOffs := FHPos;

    TmpBmp := TBitmap.Create;
    TmpBmp.Width := DragRect.Right - DragRect.Left + Abs(FDragCoord.x - (XPos + xOffs));
    TmpBmp.Height := DragRect.Bottom - DragRect.Top;
    bitblt(TmpBmp.Canvas.Handle, 0, 0, TmpBmp.Width, TmpBmp.Height, Canvas.Handle, Min(DragRect.Left, DragRect.Left - (FDragCoord.x - (XPos + xOffs))),  DragRect.Top, SRCCOPY);
    if SaveBmp <> nil then
      bitblt(TmpBmp.Canvas.Handle,
        Max(0, (FDragCoord.x - (XPos + xOffs))), 0,
        SaveBmp.Width, TmpBmp.Height,
        SaveBmp.Canvas.Handle, 0, 0, SRCCOPY);

    OffsetRect(DragRect, - (FDragCoord.x - (XPos + xOffs)), 0);

    if SaveBmp = nil then
    begin
      SaveBmp := TBitmap.Create;
      SaveBmp.Width  := DragRect.Right - DragRect.Left;
      SaveBmp.Height := DragRect.Bottom - DragRect.Top;
    end;
    bitblt(SaveBmp.Canvas.Handle, 0, 0,
      SaveBmp.Width, SaveBmp.Height, TmpBmp.Canvas.Handle,
      Max(0, -(FDragCoord.x - (XPos + xOffs))), 0, SRCCOPY);

    if LMDSIWindowsNTUp then
      MaskBlt(TmpBmp.Canvas.Handle, -(FDragCoord.x - (XPos + xOffs)), DragRect.Top, DragBmp.Width - 1, DragBmp.Height - 1, DragBmp.Canvas.Handle,
        0, 0, DragBmpMask.MaskHandle, 0, 0, ((SRCCOPY shl 8) and $FF000000) or SRCAND)
    else

    BitBlt(TmpBmp.Canvas.Handle, -(FDragCoord.x - (XPos + xOffs)), DragRect.Top, DragBmp.Width, DragBmp.Height, DragBmp.Canvas.Handle,
           0, 0, SRCCOPY);

    bitblt(Canvas.Handle,
           Min(DragRect.Left, DragRect.Left + (FDragCoord.x - (XPos + xOffs))),
           DragRect.Top,
           TmpBmp.Width, TmpBmp.Height, TmpBmp.Canvas.Handle, 0, 0, SRCCOPY);
    FDragCoord.X := XPos;

    if not FDropSrc.Locked then
      Inc(FDragCoord.X, FHPos);

    TmpBmp.Free;
  end;

  if ((FTracking) or IsThemed) and (not FResizing) and
     (FDropSrc = nil) and (not (csNoStdEvents in ControlStyle)) and
     (not (csDesigning in ComponentState)) and FMouseInControl then
  begin
    THS := FTrackSection;
    FTrackSection := GetSectionAt(XPos, YPos);
    if THS <> FTrackSection then
    begin
      if THS <> nil then THS.UpdateSection;
      if FTrackSection <> nil then FTrackSection.UpdateSection;
    end;
  end;
  if (not FPressed) and (not FResizing) and (FDropSrc = nil) and FMouseInControl then
  begin
    if InResizeArea(XPos, THS) and (not (csDesigning in ComponentState)) and (THS.FResizable) then
    begin
      if Screen.Cursor <> crHSplit then
        Screen.Cursor := crHSplit;
    end
    else if Screen.Cursor = crHSplit then
      Screen.Cursor := Cursor;

    if (FHintSection <> nil) and (FHintSection <> THS) and (THS <> nil) and ShowHint and (THS.Hint <> '') then
    begin
      // P := ClientToScreen(SmallPointToPoint(Message.Pos));
      // Application.ActivateHint(P);
      ZeroMemory(@AMsg, sizeof(AMsg));
      TWMMouse(AMsg).XPos := -10000;
      TWMMouse(AMsg).YPos := -10000;
      Application.HintMouseMessage(Self, AMsg);
      TWMMouse(AMsg).XPos := XPos;
      TWMMouse(AMsg).YPos := YPos;
      Application.HintMouseMessage(Self, AMsg);
      end;
  end;
  if FResizing then
  begin
    if RightAlignedOrder then
    begin
      L := FResizeSection.Right;
      if not FResizeSection.Locked then
        XOffs := - FHPos
      else
        XOffs := 0;
      if (XPos - xOffs - FLineTab <= L)  and (not StickySections or
         (XPos - xOffs - FLineTab < Width - FixedRighterSections(FResizeSection))) then
      begin
        NewWidth := L - XPos- FLineTab;
        if not FResizeSection.Locked then
          Inc(NewWidth, FHPos);
        with FResizeSection do
          if LMDInRange(NewWidth, MinWidth, MaxWidth) then
          begin
            if FResizeOnDrag then
            begin
              Width := NewWidth;
              InvalidateRight(FResizeSection.Index);
              Update;
              DoSectionResizing(FResizeSection, trsMove, NewWidth);
            end
            else
            begin
              DrawLine(True);
              FHeaderLine := XPos;
              DrawLine(False);
              DoSectionResizing(FResizeSection, trsMove, NewWidth);
            end;
          end;
      end;
    end
    else
    begin
      L := FResizeSection.Left;
      if not FResizeSection.Locked then
        XOffs := - FHPos
      else
        XOffs := 0;
      if (XPos - xOffs - FLineTab >= L)  and (not StickySections or
         (XPos - xOffs - FLineTab < Width - FixedRighterSections(FResizeSection))) then
      begin
        NewWidth := XPos - L - FLineTab;
        if not FResizeSection.Locked then
          Inc(NewWidth, FHPos);
        with FResizeSection do
          if LMDInRange(NewWidth, MinWidth, MaxWidth) then
          begin
            if FResizeOnDrag then
            begin
              Width := NewWidth;
              InvalidateRight(FResizeSection.Index);
              Update;
              DoSectionResizing(FResizeSection, trsMove, NewWidth);
            end
            else
            begin
              DrawLine(True);
              FHeaderLine := L + NewWidth;
              if not FResizeSection.Locked then
                Dec(FHeaderLine, FHPos);
              DrawLine(False);
              DoSectionResizing(FResizeSection, trsMove, NewWidth);
            end;
          end;
      end; // really in client width
    end;
  end;
end;

procedure TCustomElHeader.IntMouseEnter;
begin
  if (FPressedItem <> nil) and (FDropSrc = nil) then
  begin
    FPressed := True;
    FPressedItem.UpdateSection;
  end;
  FMouseInControl := True;
end;

procedure TCustomElHeader.IntMouseLeave;
var
  THS: TElHeaderSection;
begin
  FMouseInControl := False;
  FDropTrg := nil;
  FPressed := False;
  if FPressedItem <> nil then
  begin
    THS := FPressedItem;
    THS.UpdateSection;
  end;
  if FTrackSection <> nil then
  begin
    THS := FTrackSection;
    FTrackSection := nil;
    THS.UpdateSection;
  end;
  if (not FResizing) and (Screen.Cursor = crHSplit) then Screen.Cursor := Cursor;
  FHintSection := nil;
end;

procedure TCustomElHeader.IntExit;
var P: TPoint;
begin
  inherited;
  if FPressed or FResizing or (FDropSrc <> nil) then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);
    MouseUp(mbLeft, [], P.X, P.Y);
  end;
end;

procedure TCustomElHeader.IntSize;
var
  i: integer;
begin
  for i := 0 to Sections.Count - 1 do // Iterate
  begin
    if (Sections[i].LookupEnabled) or (Sections[i].FilterEnabled) then
    begin
      if (Height > 0) and (Height < 17) then Height := 17;
      break;
    end;
  end; // for
end;

function TCustomElHeader.IntHintShow(var HintInfo: THintInfo): Boolean;
var
  Section: TElHeaderSection;

  {$ifdef _LMD_UNICODEIMPL}
  T: WideChar;
  WS: WideString;
  l: integer;
  S: String;
  {$endif}
begin
  Section := GetSectionAt(HintInfo.CursorPos.X, HintInfo.CursorPos.Y);
  FHintSection := Section;
  Result := True;
  if (Section <> nil) and (Length(Section.Hint) > 0) then
    HintInfo.HintStr := Section.Hint;

  {$ifdef _LMD_UNICODEIMPL} // EB 2015: All this tricky stuff, probably,
                            // need to be done only for older non-Unicode
                            // Delphi versions.

  if (Section <> nil) and (Length(Section.Hint) > 0) then
    WS := Section.Hint
  else
    WS := FHint;

  if Length(WS) = 0 then
  begin
    HintInfo.HintStr := '';
    Exit;
  end;

  if HintInfo.HintStr = GetShortHint(inherited Hint) then
  begin
    WS := LMDWideGetShortHint(WS);
    S := WS;
  end
  else
    S := WS;

  l := Length(S) + 1 + Length(WS) * 2;
  SetLength(HintInfo.HintStr, l + 4);
  Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);

  Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
  T := #0;
  Move(T, HintInfo.HintStr[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, HintInfo.HintStr[l + 3], sizeof(T));

  {$endif}
end;

{ TriggerImageNeededEvent }
procedure TCustomElHeader.TriggerImageNeededEvent(Sender: TObject; Src :
    TLMDString; var Image: TBitmap);
begin
  if (assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src , Image );
end;

procedure TCustomElHeader.TriggerImageNeededExEvent(Sender: TObject;
  Src: TLMDString; Image: TPicture);
begin
  if (Assigned(FOnImageNeededEx)) then
    FOnImageNeededEx(Self, Src, Image);
end;

procedure TCustomElHeader.CreateHandle;

begin
  inherited;
  AdjustHeaderHeight;
end;

procedure TCustomElHeader.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;

{function TCustomElHeader.GetThemedClassName: TLMDThemedItem;
begin
  Result := tiHeader;
end;}

function TCustomElHeader.GetThemedElement: TThemedElement;
begin
  Result := teHeader;
end;

{$ifdef LMD_UNICODE}
procedure TCustomElHeader.SetHint(Value: TLMDString);
var
  S: String;
  i,
  l: integer;
  T: WideChar;
  begin
  FHint := Value;

  S := FHint;
  i := Length(S);
  l := Length(S) + 1 + Length(FHint) * 2;
  SetLength(S, l + 4);
  S[i + 1] := #0;

  Move(FHint[1], S[i + 2], Length(FHint) * 2);
  T := #0;
  Move(T, S[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, S[l + 3], sizeof(T));
  inherited Hint := S;
end;
{$endif}

procedure TCustomElHeader.ResetUpdateCounter;
begin
  if FUpdateCount > 0 then
  begin
    FUpdateCount := 1;
    EndUpdate;
  end
  else
  begin
    FUpdateCount := 0;
  end;
end;

procedure TCustomElHeader.SetFixedColNum(Value: Integer);
begin
  if Value > Sections.Count then
    Value := Sections.Count
  else if Value < 0 then
    Value := 0;
  FFixedColNum := Value;
  CalcFixedColWidth;
  if not (csLoading in Parent.ComponentState) then
    RedrawSections;
end;

procedure TCustomElHeader.CalcFixedColWidth;
var
  i: Integer;
  LSection: TElHeaderSection;
begin
  FFixedColWidth := 0;
  if FFixedColNum = 0 then
    Exit;
  for i := 0 to FFixedColNum - 1 do
  begin
    LSection := TElHeaderSection(Sections.FList[i]);
    if LSection.Visible then
      Inc(FFixedColWidth, LSection.Width);
  end;
end;

function TElHeaderSection.GetText: TLMDString;
begin
  Result := FText;
end;

function TElHeaderSection.GetBottom: integer;
begin
  Result := FOwner.Height;
end;

function TElHeaderSection.GetTop: integer;
begin
  Result := 0;
end;

function TCustomElHeader.GetFixedColNum: Integer;
begin
  Result := FFixedColNum;
end;

initialization

  ElHeaderAscBmp := TBitmap.Create;
  ElHeaderDescBmp := TBitmap.Create;
  ElHeaderLeftBmp := TBitmap.Create;
  ElHeaderRightBmp := TBitmap.Create;
  ElHeaderPointBmp := TBitmap.Create;

  ElHeaderAscBmp.LoadFromResourceName(HInstance, 'ELHEADERASCBMP');
  ElHeaderDescBmp.LoadFromResourceName(HInstance, 'ELHEADERDESCBMP');
  ElHeaderLeftBmp.LoadFromResourceName(HInstance, 'ELHEADERLEFTBMP');
  ElHeaderRightBmp.LoadFromResourceName(HInstance, 'ELHEADERRIGHTBMP');
  ElHeaderPointBmp.LoadFromResourceName(HInstance, 'ELHEADERPOINTBMP');
  finalization

  try
    ElHeaderPointBmp.Free;
    ElHeaderAscBmp.Free;
    ElHeaderDescBmp.Free;
    ElHeaderLeftBmp.Free;
    ElHeaderRightBmp.Free;
  except
    on e:Exception do
    begin
      LMDDebug('ERROR finalization ElHeader: ' + e.Message);
    end;
  end;

end.
