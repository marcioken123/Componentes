unit LMDRTFRichEdit;
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

LMDRTFRichEdit unit (DS, VO, RM)
-----------------------


Changes
-------
Release 4.04 ( April 2008)

 - Setting horizontal margin properties via code had no
   immediate effect on ruler - fixed [VB April 2008]


Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, RichEdit, Graphics, StdCtrls, Messages,
  Controls, Menus, Dialogs, ComCtrls, Forms, Themes, LMDUnicode,
  LMDRTFBase, LMDRTFRuler, LMDRTFStorage, intfLMDBase, LMDTypes;

{$HPPEMIT '#define CHARFORMAT2A Richedit::CHARFORMAT2A'}

type
  { **************************  TLMDTextAttributes  ************************** }

  TLMDCustomRichEdit = class;
  TLMDRichCustomComboBox = class;

  TLMDAttributeType = (atDefaultText, atSelected, atWord);
  TLMDConsistentAttribute = (caBold, caColor, caFace, caItalic,
    caSize, caStrikeOut, caUnderline, caProtected, caOffset, caHidden, caLink,
    caBackColor, caDisabled, caWeight, caSubscript, caRevAuthor, caRevised);
  TLMDRichSubscriptStyle = (ssNone, ssSubscript, ssSuperscript);
  TLMDConsistentAttributes = set of TLMDConsistentAttribute;
  TLMDUnderlineType = (utNone, utSolid, utWord, utDouble, utDotted, utDash,
                       utDashDot, utDashDotDot, urWave, utThick);

  TLMDTextAttributes = class(TPersistent)
  private
    RichEdit: TLMDCustomRichEdit;
    FType: TLMDAttributeType;
    procedure AssignFont(Font: TFont);
    procedure GetAttributes(var Format: TCharFormat2);
    function GetBackColor: TColor;
    function GetCharset: TFontCharset;
    function GetColor: TColor;
    function GetConsistentAttributes: TLMDConsistentAttributes;
    function GetHeight: Integer;
    function GetHidden: Boolean;
    function GetDisabled: Boolean;
    function GetLink: Boolean;
    function GetName: TFontName;
    function GetOffset: Integer;
    function GetPitch: TFontPitch;
    function GetProtected: Boolean;
    function GetRevised: Boolean;
    function GetRevAuthorIndex: Byte;
    function GetSize: Integer;
    function GetStyle: TFontStyles;
    function GetSubscriptStyle: TLMDRichSubscriptStyle;
    function GetUnderlineType: TLMDUnderlineType;
    procedure SetAttributes(var Format: TCharFormat2);
    procedure SetBackColor(Value: TColor);
    procedure SetCharset(Value: TFontCharset);
    procedure SetColor(Value: TColor);
    procedure SetDisabled(Value: Boolean);
    procedure SetHeight(Value: Integer);
    procedure SetHidden(Value: Boolean);
    procedure SetLink(Value: Boolean);
    procedure SetName(Value: TFontName);
    procedure SetOffset(Value: Integer);
    procedure SetPitch(Value: TFontPitch);
    procedure SetProtected(Value: Boolean);
    procedure SetRevised(Value: Boolean);
    procedure SetRevAuthorIndex(Value: Byte);
    procedure SetSize(Value: Integer);
    procedure SetStyle(Value: TFontStyles);
    procedure SetSubscriptStyle(Value: TLMDRichSubscriptStyle);
    procedure SetUnderlineType(Value: TLMDUnderlineType);
  protected
    procedure InitFormat(var Format: TCharFormat2);
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(AOwner: TLMDCustomRichEdit; AttributeType: TLMDAttributeType);
    procedure Assign(Source: TPersistent); override;
    function TextAttributesDialog: Boolean;
    property BackColor: TColor read GetBackColor write SetBackColor;
    property Charset: TFontCharset read GetCharset write SetCharset;
    property Color: TColor read GetColor write SetColor;
    property ConsistentAttributes: TLMDConsistentAttributes read
    GetConsistentAttributes;
    property Disabled: Boolean read GetDisabled write SetDisabled;
    property Hidden: Boolean read GetHidden write SetHidden;
    property Link: Boolean read GetLink write SetLink;
    property Name: TFontName read GetName write SetName;
    property Offset: Integer read GetOffset write SetOffset;
    property Pitch: TFontPitch read GetPitch write SetPitch;
    property Protected: Boolean read GetProtected write SetProtected;
    property Revised: Boolean read GetRevised write SetRevised;
    property RevAuthorIndex: Byte read GetRevAuthorIndex write SetRevAuthorIndex;
    property SubscriptStyle: TLMDRichSubscriptStyle read GetSubscriptStyle write SetSubscriptStyle;
    property Size: Integer read GetSize write SetSize;
    property Style: TFontStyles read GetStyle write SetStyle;
    property Height: Integer read GetHeight write SetHeight;
    property UnderlineType: TLMDUnderlineType read GetUnderlineType write SetUnderlineType;
  end;

  {  ************************** TLMDParaAttributes  ************************** }
  TLMDNumbering = (nsNone, nsBullet, nsArabicNumbers, nsLoCaseLetter,
    nsUpCaseLetter, nsLoCaseRoman, nsUpCaseRoman);
  TLMDNumberingStyle = (nsParenthesis, nsPeriod, nsEnclosed, nsSimple);
  TLMDParaAlignment = (paLeftJustify, paRightJustify, paCenter{, paJustify});
  TLMDLineSpacingRule = (lsSingle, lsOneAndHalf, lsDouble, lsSpecifiedOrMore,
    lsSpecified, lsMultiple);
  TLMDHeadingStyle = 0..9;
  TLMDParaTableStyle = (tsNone, tsTable, tsTableRow, tsTableCellEnd, tsTableCell);

  TLMDParaAttributes = class(TPersistent)
  private
    RichEdit: TLMDCustomRichEdit;
    procedure GetAttributes(var Paragraph: TParaFormat2);
    function GetAlignment: TLMDParaAlignment;
    function GetFirstIndent: Longint;
    function GetHeadingStyle: TLMDHeadingStyle;
    function GetLeftIndent: Longint;
    function GetRightIndent: Longint;
    function GetSpaceAfter: Longint;
    function GetSpaceBefore: Longint;
    function GetLineSpacing: Longint;
    function GetLineSpacingRule: TLMDLineSpacingRule;
    function GetNumbering: TLMDNumbering;
    function GetNumberingStyle: TLMDNumberingStyle;
    function GetNumberingTab: Word;
    function GetTab(Index: Byte): Longint;
    function GetTabCount: Integer;
    function GetTableStyle: TLMDParaTableStyle;
    procedure SetAlignment(Value: TLMDParaAlignment);
    procedure SetAttributes(var Paragraph: TParaFormat2);
    procedure SetFirstIndent(Value: Longint);
    procedure SetHeadingStyle(Value: TLMDHeadingStyle);
    procedure SetLeftIndent(Value: Longint);
    procedure SetRightIndent(Value: Longint);
    procedure SetSpaceAfter(Value: Longint);
    procedure SetSpaceBefore(Value: Longint);
    procedure SetLineSpacing(Value: Longint);
    procedure SetLineSpacingRule(Value: TLMDLineSpacingRule);
    procedure SetNumbering(Value: TLMDNumbering);
    procedure SetNumberingStyle(Value: TLMDNumberingStyle);
    procedure SetNumberingTab(Value: Word);
    procedure SetTab(Index: Byte; Value: Longint);
    procedure SetTabCount(Value: Integer);
    procedure SetTableStyle(Value: TLMDParaTableStyle);
    function GetNumberingStart: LongInt;
    procedure SetNumberingStart(const Value: LongInt);
  protected
    procedure InitPara(var Paragraph: TParaFormat2);
    procedure GetIndents(var Left, First, Right: integer);
  public
    constructor Create(AOwner: TLMDCustomRichEdit);
    procedure Assign(Source: TPersistent); override;
    procedure ClearToDefaults;
    procedure SetTabs(const Tabs: array of integer);
    function ParagraphDialog: Boolean;
    function TabsDialog: Boolean;
    procedure SetParagraphIndent(Left, First: integer);
    property Alignment: TLMDParaAlignment read GetAlignment write SetAlignment;
    property FirstIndent: Longint read GetFirstIndent write SetFirstIndent;
    property HeadingStyle: TLMDHeadingStyle read GetHeadingStyle write SetHeadingStyle;
    property LeftIndent: Longint read GetLeftIndent write SetLeftIndent;
    property LineSpacing: Longint read GetLineSpacing write SetLineSpacing;
    property LineSpacingRule: TLMDLineSpacingRule read GetLineSpacingRule write SetLineSpacingRule;
    property Numbering: TLMDNumbering read GetNumbering write SetNumbering;
    property NumberingStart: LongInt read GetNumberingStart write SetNumberingStart;
    property NumberingStyle: TLMDNumberingStyle read GetNumberingStyle write SetNumberingStyle;
    property NumberingTab: Word read GetNumberingTab write SetNumberingTab;
    property RightIndent: Longint read GetRightIndent write SetRightIndent;
    property SpaceAfter: Longint read GetSpaceAfter write SetSpaceAfter;
    property SpaceBefore: Longint read GetSpaceBefore write SetSpaceBefore;
    property Tab[Index: Byte]: Longint read GetTab write SetTab;
    property TabCount: Integer read GetTabCount write SetTabCount;
    property TableStyle: TLMDParaTableStyle read GetTableStyle write SetTableStyle;
  end;

{  ************************** TLMDCustomRichEdit  ************************** }

  TLMDRichLangOption = (rlAutoKeyboard, rlAutoFont, rlImeCancelComplete, rlImeAlwaysSendNotify);
  TLMDRichLangOptions = set of TLMDRichLangOption;
  //TLMDRichEditResizeEvent = procedure(Sender: TObject; Rect: TRect) of object;
  //TLMDRichEditProtectChange = procedure(Sender: TObject;
  //  StartPos, EndPos: Integer; var AllowChange: Boolean) of object;
  //TLMDRichEditSaveClipboard = procedure(Sender: TObject;
  //  NumObjects, NumChars: Integer; var SaveClipboard: Boolean) of object;
  TLMDRichSelection = (stText, stObject, stMultiChar, stMultiObject);
  TLMDRichSelectionType = set of TLMDRichSelection;
  TLMDRedoUndoType = (uidUnknown, uidTyping, uidDelete, uidDragDrop, uidCut, uidPaste);
  {$NODEFINE TLMDSearchType}
  TLMDSearchType = (stWholeWord, stMatchCase, stSearchDown);
  {$NODEFINE TLMDSearchTypes}
  TLMDSearchTypes = set of TLMDSearchType;

  TLMDConversion = class(TObject)
  public
  constructor Create; virtual;
    function ConvertReadStream(Stream: TStream; Buffer: PAnsiChar; BufSize:
      Integer): Integer; virtual;
    function ConvertWriteStream(Stream: TStream; Buffer: PAnsiChar; BufSize:
      Integer): Integer; virtual;
  end;

  TLMDConversionClass = class of TLMDConversion;

  PLMDConversionFormat = ^TLMDConversionFormat;

  TLMDConversionFormat = record
    ConversionClass : TLMDConversionClass;
    Extension       : string;
  Next            : PLMDConversionFormat;
  end;

  PLMDRichEditStreamInfo = ^TLMDRichEditStreamInfo;

  TLMDRichEditStreamInfo = record
    Converter : TLMDConversion;
    Stream    : TStream;
  end;

  TLMDZoom = -64..64;

  TLMDRichEditMode = (edModeAppOnly, edModePrinterSupport);
  TLMDSmoothingType = (stSystem, stActive, stInactive);

  TLMDRichTypographyOptions = (toAdvanced, toSimple);
  TLMDRichDropFileEvent = procedure(Sender: TObject; const FileName: string;
    var Accept: Boolean) of object;

  TLMDRichHandleEvent=procedure(Sender : TObject; var skipDefaultBehaviour:Boolean) of object;

  {$EXTERNALSYM TLMDBaseCustomRichEdit}
  TLMDBaseCustomRichEdit = class(TCustomMemo)
  protected
    function DoFindText(const SearchStr: string; StartPos, Length: Integer; Options: TLMDSearchTypes): Integer;virtual;abstract;
    function DoReplaceText(const SearchStr: string; const ReplaceStr:string; StartPos, Len: Integer; Options: TLMDSearchTypes): Integer;virtual;abstract;
  public
    function FindText(const SearchStr: string; StartPos, Length: Integer; Options: TLMDSearchTypes=[stSearchDown]): Integer;
    function ReplaceText(const SearchStr: string; const ReplaceStr:string; StartPos, Len: Integer; Options: TLMDSearchTypes=[stSearchDown]): Integer;
  end;

  (*$HPPEMIT 'namespace Lmdrtfrichedit' *)
  (*$HPPEMIT '{' *)
  (*$HPPEMIT '#pragma option push -b-' *)
  (*$HPPEMIT 'enum TLMDSearchType { stWholeWord, stMatchCase, stSearchDown };' *)
  (*$HPPEMIT '#pragma option pop' *)
  (*$HPPEMIT '' *)
  (*$HPPEMIT 'typedef Set<TLMDSearchType, stWholeWord, stSearchDown>  TLMDSearchTypes;' *)
  (*$HPPEMIT 'class DELPHICLASS TLMDBaseCustomRichEdit;' *)
  (*$HPPEMIT 'class PASCALIMPLEMENTATION TLMDBaseCustomRichEdit : public Stdctrls::TCustomMemo' *)
  (*$HPPEMIT '{' *)
  (*$HPPEMIT '  typedef Stdctrls::TCustomMemo inherited;' *)
  (*$HPPEMIT 'protected:' *)
  (*$HPPEMIT '  virtual int __fastcall DoFindText(const String SearchStr, int StartPos, int Length, TLMDSearchTypes Options ) = 0 ;' *)
  (*$HPPEMIT '  virtual int __fastcall DoReplaceText(const String SearchStr, const String ReplaceStr, int StartPos, int Len, TLMDSearchTypes Options) = 0 ;' *)
  (*$HPPEMIT 'public:' *)
  (*$HPPEMIT '  #pragma option push -w-inl' *)
  (*$HPPEMIT '  /* TCustomMemo.Create */ inline __fastcall virtual TLMDBaseCustomRichEdit(Classes::TComponent* AOwner) : Stdctrls::TCustomMemo(AOwner) { }' *)
  (*$HPPEMIT '  #pragma option pop' *)
  (*$HPPEMIT '  #pragma option push -w-inl' *)
  (*$HPPEMIT '  /* TCustomMemo.Destroy */ inline __fastcall virtual ~TLMDBaseCustomRichEdit(void) { }' *)
  (*$HPPEMIT '  #pragma option pop' *)
  (*$HPPEMIT '' *)
  (*$HPPEMIT 'public:' *)
  (*$HPPEMIT '  #pragma option push -w-inl' *)
  (*$HPPEMIT '  /* TWinControl.CreateParented */ inline __fastcall TLMDBaseCustomRichEdit(HWND ParentWindow) : Stdctrls::TCustomMemo(ParentWindow) { }' *)
  (*$HPPEMIT '  #pragma option pop' *)
  (*$HPPEMIT '};' *)
  (*$HPPEMIT '}' *)


  TLMDCustomRichEdit = class(TLMDBaseCustomRichEdit, ILMDComponent)
  private
    FAbout            : TLMDAboutVar;
    FCombos           : TList;
    FAllowObjects     : Boolean;
    FAllowInPlace     : Boolean;
    FAutoURLDetect    : Boolean;
    FAutoVerbMenu     : Boolean;
    FCallback         : TInterfacedObject;
    FCallbackIntf     : IUnknown;
    FDefaultConverter : TLMDConversionClass;
    FHideSelection    : Boolean;
    FHideScrollBars   : Boolean;
    FLangOptions      : TLMDRichLangOptions;
    FMemStream        : TMemoryStream;
    FModified         : Boolean;
    FOldParaAlignment : TAlignment;
    FParagraph        : TLMDParaAttributes;
    FPopupVerbMenu    : TPopupMenu;
    FPageRect         : TLMDRichPageMargins;
    FPageMargins      : TLMDRichPageMargins;
    FTempMargins      : TLMDRichPageMargins;
    FPrinterPageWidth : LongInt;
    FRichEditStrings  : TStrings;
    FRichEditOle      : IUnknown;
    FRuler            : TLMDRTFRuler;
    FShowRuler        : Boolean;
    FScreenLogPixels  : Integer;
    FTitle            : string;
    FUndoLimit        : Integer;
    FZoom             : TLMDZoom;
    FOnCustomize      : TNotifyEvent;
    FSelAttributes    : TLMDTextAttributes;
    FWordAttributes   : TLMDTextAttributes;
    FDefAttributes    : TLMDTextAttributes;
    FOnSelChange      : TNotifyEvent;
    FOnResizeRequest  : TRichEditResizeEvent;
    FOnProtectChange  : TRichEditProtectChange;
    FOnSaveClipboard  : TRichEditSaveClipboard;
    FOnURLClick       : TLMDRichURLClickEvent;
    FOnLinkClick      : TLMDRichURLClickEvent;
    FRichStorage      : TLMDRichStorage;
    FRichStorageItem  : LongInt;
    FStorageLink      : TLMDRTFChangeLink;
    FAcceptDropFiles  : Boolean;
    FDefaultPopup     : TPopupMenu;
    FDefaultPopupURL  : TPopupMenu;
    FDefaultProtect   : Boolean;
    FShowDefaultPopup : Boolean;
    FMeasurement      : TLMDMeasurement;
    FRichEditMode     : TLMDRichEditMode;
    { used for markup capts }
    FRecreateInProcess: boolean;
    FOldSel           : TCharRange;
    FForcedChange     : Boolean;
    FHeaderSize       : integer;
    FTextEmpty        : boolean;
    FOnVScroll        : TNotifyEvent;
    FOnHScroll        : TNotifyEvent;
    FLockLinkClick    : boolean;
    FDlgPosition      : TLMDRichDialogPosition;
    FOnDlgAfterShow,
    FOnDlgInit        : TNotifyEvent;
    FOnDropFile       : TLMDRichDropFileEvent;
    FOnLinkMouseMove  : TLMDLinkMouseMoveEvent;
    FInMousePosURL    : string;
    FInMousePosURLc   : integer;
    FInRulerPosition  : Boolean;
    // 7.02
    FOnAfterSave      : TLMDRichHandleEvent;
    FOnBeforeSave     : TNotifyEvent;
    // ---
    FProtectLinks     : boolean;
    procedure CMBiDiModeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMDocWindowActivate(var Message: TMessage); message CM_DOCWINDOWACTIVATE;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CNNotify(var Message:TWMNotify); message CN_NOTIFY;
    procedure CMUIDeactivate(var Message: TMessage); message CM_UIDEACTIVATE;
    procedure WMDestroy(var Msg: TWMDestroy); message WM_DESTROY;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSetFont(var Message: TWMSetFont); message WM_SETFONT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    // This simple handlers raise exception under the .NET
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure WMVScroll(var Message: TMessage); message WM_VSCROLL;
    procedure WMHScroll(var Message: TMessage); message WM_HSCROLL;
    procedure WMKeyDown(var Message: TWMKey); message WM_KEYDOWN;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    function GetAutoURLDetect: Boolean;
    function GetCanRedo: Boolean;
    function GetLangOptions: TLMDRichLangOptions;
    function GetPlainText: Boolean;
    function GetRedoName: TLMDRedoUndoType;
    function GetSelectionType: TLMDRichSelectionType;
    function GetUndoName: TLMDRedoUndoType;
    function GetVersion: LongInt;
    function GetZoom: TLMDZoom;
    function GetOnRulerTabCreate: TLMDRTFRulerEvent;
    function GetOnRulerTabChange: TLMDRTFRulerEvent;
    function GetOnRulerTabDestroy: TLMDRTFRulerEvent;
    function GetOnRulerFirstIdentChange: TLMDRTFRulerEvent;
    function GetOnRulerLeftIdentChange: TLMDRTFRulerEvent;
    function GetOnRulerRightIdentChange: TLMDRTFRulerEvent;
    procedure SetRichEditMode(value: TLMDRichEditMode);
    procedure SetAllowObjects(const Value: Boolean);
    procedure SetAutoURLDetect(Value: Boolean);
    procedure SetHideSelection(Value: Boolean);
    procedure SetHideScrollBars(Value: Boolean);
    procedure SetLangOptions(Value: TLMDRichLangOptions);
    procedure SetRichEditStrings(Value: TStrings);
    procedure SetPlainText(Value: Boolean);
    procedure SetRuler(aValue: Boolean);
    procedure SetTitle(const Value: string);
    procedure SetUndoLimit(Value: Integer);
    procedure SetVersion(aValue: LongInt);
    procedure SetZoom(const Value: TLMDZoom);
    procedure SetDefAttributes(Value: TLMDTextAttributes);
    procedure SetSelAttributes(Value: TLMDTextAttributes);
    procedure SetWordAttributes(Value: TLMDTextAttributes);
    procedure SetOnRulerTabCreate(Value: TLMDRTFRulerEvent);
    procedure SetOnRulerTabChange(Value: TLMDRTFRulerEvent);
    procedure SetOnRulerTabDestroy(Value: TLMDRTFRulerEvent);
    procedure SetOnRulerFirstIdentChange(Value: TLMDRTFRulerEvent);
    procedure SetOnRulerLeftIdentChange(Value: TLMDRTFRulerEvent);
    procedure SetOnRulerRightIdentChange(Value: TLMDRTFRulerEvent);
    procedure CloseObjects;
    procedure ObjectPropsClick(Sender: TObject);
    function ProtectChange(StartPos, EndPos: Integer): Boolean;
    procedure PopupVerbClick(Sender: TObject);
    function SaveClipboard(NumObj, NumChars: Integer): Boolean;
    procedure UpdateHostNames;
    procedure SetPageMargins(const Value: TLMDRichPageMargins);
    procedure SetStorage(const Value: TLMDRichStorage);
    procedure SetStorageItem(const Value: LongInt);
    function IsStringsStored: Boolean;
    procedure UpdateFromStorage;
    procedure StorageDataChanged(Sender: TObject);
    function GetCurPos: TPoint;
    procedure SetCurPos(const Value: TPoint);
    procedure SetMeasurement(const Value: TLMDMeasurement);
    procedure ChangeMargins(Sender: TObject);
    procedure SetRulerMeasurement;
    procedure UpdateRuler;
//    procedure SetRulerPosition;
    procedure SetTypographyOptions(const Value : TLMDRichTypographyOptions);
    function GetTypographyOptions : TLMDRichTypographyOptions;
    procedure SetAcceptDropFiles(Value: Boolean);
    function  IsValidRichStorageItem: Boolean;
    function GetTopLineIndex: Integer;
    procedure SetTopLineIndex(Value: Integer);
    procedure SetRTFText(const aValue: string);
    function  GetRTFText: string;
    function  GetReadOnly: Boolean;
    procedure SetReadOnly(aValue: Boolean);
    procedure SetAllowInPlace(aValue: Boolean);
    function GetTextLengthHelper(Struct: TGetTextLengthEx): Integer;
    procedure SetProtectLinks(const Value: boolean);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    function DoFindText(const SearchStr: string; StartPos, Length: Integer; Options: TLMDSearchTypes): Integer;override;
    function DoReplaceText(const SearchStr: string; const ReplaceStr:string; StartPos, Len: Integer; Options: TLMDSearchTypes): Integer;override;
    //    procedure AdjustSize; override;
    // --> used for DlgPosition property in system dialogs
    function  GetDlgParentHandle:HWnd;
    // ---
    function GetCaretPos: TPoint; override;
    procedure SetCaretPos(const Value: TPoint); override;
    function GetSelLength: Integer; override;
    function GetSelStart: Integer; override;
    function GetSelText: string; override;
    procedure InformCombos;
    procedure SetSelLength(Value: Integer); override;
    procedure SetSelStart(Value: Integer); override;
    procedure DoSetMaxLength(Value: Integer); override;
    procedure Notification(aComponent: TComponent; Operation: TOperation); override;
    procedure RequestSize(const Rect: TRect); virtual;
    function GetCanPaste: Boolean; virtual;
    procedure SelectionChange; dynamic;
    procedure URLClick(const URLText: string; Button: TMouseButton); dynamic;
    procedure LinkClick(const LinkText: string; Button: TMouseButton); dynamic;
    procedure CreateHandle; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure LoadStorageIndexProperty(Reader: TReader);
    procedure SetParent(AParent: TWinControl); override;
    procedure DoContextPopup(MousePos: TPoint; var Handled: Boolean); override;
    function  GetThemedBkColor: TColor; virtual;

    { used for markup capts }
    procedure MarkUpParse(aStart, aEnd: LongInt); virtual;
    procedure Change; override;
    procedure Loaded; override;
    procedure BeforeSave(aStream : TStream); virtual;
    procedure AfterSave; virtual;
    procedure BeforeLoad(aStream : TStream); virtual;
    procedure AfterLoad; virtual;
    function  DoDropFile(const FileName: string): Boolean;
    property  OnDropFile: TLMDRichDropFileEvent read FOnDropFile write FOnDropFile;
    property  OnLinkMouseMove: TLMDLinkMouseMoveEvent read FOnLinkMouseMove write FOnLinkMouseMove;
    // 7.02
    property OnAfterSave: TLMDRichHandleEvent read FOnAfterSave write FOnAfterSave;
    property OnBeforeSave: TNotifyEvent read FOnBeforeSave write FOnBeforeSave;
    //
    procedure GetPrinterPageParams(var aPrinterPageWidth: LongInt; var aPageMargins: TLMDRichPageMargins);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; override;
  // moved to the protected section (.NET)
    function GetPopupMenu: TPopupMenu; override;
    procedure Render(BMP: TBitmap; var LastChar: Integer); overload;
    procedure Render(BMP: TBitmap; Wd, Hg, MaxWidth, MaxHeight: integer;
              VSB_Width, HSB_Height: integer; var LastChar: Integer;
              Smoothing: TLMDSmoothingType = stSystem); overload;

//    function Render(Cnv: TCanvas; const Rect: TRect; var LastChar: Integer): TRect;
    function Preview(PrintTo: TCanvas; Render: Boolean; var LastChar: Integer): TRect; virtual;
//    function Render(Cnv: TCanvas; IsRender: Boolean; var LastChar: Integer): TRect;
    procedure Print(const Caption: string); virtual;
    procedure SetRulerPosition;
    procedure GetRulerPosition(var Rect: TRect);
    procedure SetEditRect;
    procedure PrepareDialog(dlg:TCustomForm);overload;
    procedure PrepareDialog(dlg:TLMDRichBaseDialog);overload;
    function GetTextRange(StartPos, EndPos: Longint): String;
    function GetSelTextBuf(Buffer: PChar; BufSize: Integer): Integer; override;
    procedure SetUIActive(Active: Boolean);
    function FindTextExt(const SearchStr: string; StartPos, Length: Integer; Options: TLMDSearchTypes): Integer;
    function ReplaceTextExt(const SearchStr: string; const ReplaceStr:string; StartPos, Len: Integer; Options: TLMDSearchTypes): Integer;
    function InsertObjectDialog: Boolean;
    function ObjectPropertiesDialog: Boolean;
    function PasteSpecialDialog: Boolean;
    function PagePropertiesDialog: Boolean;
    function PreviewDialog: Boolean;
    function InsertDateTimeDialog: Boolean;
    function InsertCharDialog:Boolean;
    procedure StatisticsDialog;

    procedure Redo;
    {$ifdef LMDCOMP9}
    procedure InsertBitmap(aBitmap : TBitmap);
    {$else}
    procedure InsertBitmap(aBitmap : Graphics.TBitmap);
    {$endif}
    procedure InsertGraphic(aGraphic: TGraphic);
    procedure SaveToStreamAsHTML(aStream : TStream);
    procedure CopyToStream(aStream : TStream; aSelection : boolean = True; aPlainText : boolean = False;
                           aObjects : boolean = False; aPlainRtf : boolean = False);
    procedure PastePlainText;
    procedure PasteFromStream(aStream : TStream; aSelection : boolean = True; aPlainText : boolean = False; aPlainRtf : boolean = False);
    class procedure RegisterConversionFormat(const AExtension: string; AConversionClass: TLMDConversionClass);
    function  GetEditRect: TRect;
   // scrolls delta lines
    procedure ScrollByLines(delta:Integer);
    // synchronizes TopLineIndex value in current control with the one in aControl.
    procedure SynchronizeLines(aControl:TLMDCustomRichEdit);

    // not for public use
    procedure RegisterCombo(aCombo : TLMDRichCustomComboBox);
    procedure UnRegisterCombo(aCombo : TLMDRichCustomComboBox);
    // -------------------
    procedure SetSelRange(SelStart, SelLength: integer);

    // -------------------
    function getLMDPackage:TLMDPackageID;virtual;

    property DlgPosition:TLMDRichDialogPosition read FDlgPosition write FDlgPosition default rdpOwner;
    property OnDlgCustomize: TNotifyEvent read FOnCustomize write FOnCustomize;
    property OnDlgInit: TNotifyEvent read FOnDlgInit write FOnDlgInit;
    property OnDlgAfterShow: TNotifyEvent read FOnDlgAfterShow write FOnDlgAfterShow;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property AcceptDropFiles: Boolean read FAcceptDropFiles write SetAcceptDropFiles default true;
    property AllowInPlace: Boolean read FAllowInPlace write SetAllowInPlace default True;
    property AllowObjects: Boolean read FAllowObjects write SetAllowObjects default True;
    property AutoURLDetect: Boolean read GetAutoURLDetect write SetAutoURLDetect default false;
    property AutoVerbMenu: Boolean read FAutoVerbMenu write FAutoVerbMenu default True;
    property CanPaste: Boolean read GetCanPaste;
    property CanRedo: Boolean read GetCanRedo;
    property DefaultConverter: TLMDConversionClass read FDefaultConverter write FDefaultConverter;
    property HideSelection: Boolean read FHideSelection write SetHideSelection default True;
    property HideScrollBars: Boolean read FHideScrollBars write SetHideScrollBars default True;
    property Ruler: TLMDRTFRuler read FRuler write FRuler;
    property LanguageOptions: TLMDRichLangOptions read GetLangOptions write SetLangOptions default [rlAutoFont];
    property Lines: TStrings read FRichEditStrings write SetRichEditStrings stored IsStringsStored;
    property PageRect: TLMDRichPageMargins read FPageRect write FPageRect;
    property PrinterPageWidth: LongInt read FPrinterPageWidth;
    property Paragraph: TLMDParaAttributes read FParagraph;
    property PlainText: Boolean read GetPlainText write SetPlainText default False;
    property NextRedoAction: TLMDRedoUndoType read GetRedoName;
    property RichEditOle: IUnknown read FRichEditOle;
    property RichStorage: TLMDRichStorage read FRichStorage write SetStorage;
    property RichStorageItem: LongInt read FRichStorageItem write SetStorageItem default -1;
    property ShowRuler: Boolean read FShowRuler write SetRuler default False;
    property SelectionType: TLMDRichSelectionType read GetSelectionType;
    property Title: string read FTitle write SetTitle;
    property UndoLimit: Integer read FUndoLimit write SetUndoLimit default 100;
    property NextUndoAction: TLMDRedoUndoType read GetUndoName;
    property Version: LongInt read GetVersion write SetVersion stored False;
    property Zoom: TLMDZoom read GetZoom write SetZoom default 0;

    property DefAttributes: TLMDTextAttributes read FDefAttributes write SetDefAttributes;
    property SelAttributes: TLMDTextAttributes read FSelAttributes write SetSelAttributes;
    property WordAttributes: TLMDTextAttributes read FWordAttributes write SetWordAttributes;

    property Mode: TLMDRichEditMode read FRichEditMode write SetRichEditMode default edModeAppOnly;
    property PageMargins: TLMDRichPageMargins read FPageMargins write SetPageMargins;
    property RTFText: string read GetRTFText write SetRTFText;

    property OnProtectChange: TRichEditProtectChange read FOnProtectChange write FOnProtectChange;
    property OnResizeRequest: TRichEditResizeEvent read FOnResizeRequest write FOnResizeRequest;
    property OnSaveClipboard: TRichEditSaveClipboard read FOnSaveClipboard write FOnSaveClipboard;
    property OnSelectionChange: TNotifyEvent read FOnSelChange write FOnSelChange;
    property OnURLClick: TLMDRichURLClickEvent read FOnURLClick write FOnURLClick;
    property OnLinkClick: TLMDRichURLClickEvent read FOnLinkClick write FOnLinkClick;
    property OnRulerTabCreate: TLMDRTFRulerEvent read GetOnRulerTabCreate write SetOnRulerTabCreate;
    property OnRulerTabChange: TLMDRTFRulerEvent read GetOnRulerTabChange write SetOnRulerTabChange;
    property OnRulerTabDestroy: TLMDRTFRulerEvent read GetOnRulerTabDestroy write SetOnRulerTabDestroy;
    property OnRulerFirstIdentChange: TLMDRTFRulerEvent read GetOnRulerFirstIdentChange write SetOnRulerFirstIdentChange;
    property OnRulerLeftIdentChange: TLMDRTFRulerEvent read GetOnRulerLeftIdentChange write SetOnRulerLeftIdentChange;
    property OnRulerRightIdentChange: TLMDRTFRulerEvent read GetOnRulerRightIdentChange write SetOnRulerRightIdentChange;
    property CursorPos: TPoint read GetCurPos write SetCurPos;
    property MaxLength;
    property Font;
    property Alignment;
    property Measurement: TLMDMeasurement read FMeasurement write SetMeasurement default unPoints;
    property WordWrap default true;
    property ShowDefaultPopup: Boolean read FShowDefaultPopup write FShowDefaultPopup default true;
    property TypographyOptions : TLMDRichTypographyOptions read GetTypographyOptions write SetTypographyOptions default toSimple;
    property TopLineIndex:Integer read GetTopLineIndex write SetTopLineIndex;
    property OnVScroll : TNotifyEvent read FOnVScroll write FOnVScroll;
    property OnHScroll : TNotifyEvent read FOnHScroll write FOnHScroll;

    property ProtectLinks: boolean read FProtectLinks write SetProtectLinks;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored false;
    property OnChange;
  end;

  TLMDRichEdit = class(TLMDCustomRichEdit)
  published
    property AcceptDropFiles;
    property AllowObjects;
    property AllowInPlace;
    property Align;
    property Alignment;
    property Anchors;
    property AutoURLDetect;
    property AutoVerbMenu;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property Ctl3D;
    property DlgPosition;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Mode;
    property Font;
    property HideSelection;
    property HideScrollBars;
    property ImeMode;
    property ImeName;
    property Constraints;
    property LanguageOptions;
    property Lines;
    property MaxLength;
    property Measurement;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PageMargins;
    property PlainText;
    property PopupMenu;
    property ProtectLinks default true;
    property ReadOnly;
    property RichStorage;
    property RichStorageItem;
    property ShowRuler;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Title;
    property TypographyOptions;
    property UndoLimit;
    property Visible;
    property Version;
    property WantTabs default True;
    property WantReturns default True;
    property WordWrap;
    property Zoom;
    // 7.02
    property ShowDefaultPopup;
    property OnAfterSave;
    property OnBeforeSave;
    // ---
    property OnContextPopup;
    // -----
    property OnDlgCustomize;
    property OnDlgInit;
    property OnDlgAfterShow;
    // -----
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnProtectChange;
    property OnResizeRequest;
    property OnSaveClipboard;
    property OnSelectionChange;
    property OnStartDock;
    property OnStartDrag;
    property OnURLClick;
    property OnLinkClick;
    property OnRulerTabCreate;
    property OnRulerTabChange;
    property OnRulerTabDestroy;
    property OnRulerFirstIdentChange;
    property OnRulerLeftIdentChange;
    property OnRulerRightIdentChange;
    property OnVScroll;
    property OnHScroll;
    property OnDropFile;
    property OnLinkMouseMove;
  end;

  {-------------------- TLMDRichCustomComboBox --------------------------------}
  TLMDRichCustomComboBox = class(TLMDRichBaseComboBox)
  private
    FControl: TLMDCustomRichEdit;
    procedure SetControl(const Value: TLMDCustomRichEdit);
  protected
    procedure ChangeSettings; virtual; abstract;
    procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer); override;
    procedure KeyDown (var Key: Word; Shift: TShiftState); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure UpdateInfo;virtual;
    procedure WndProc(var Message: TMessage);override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property RichEditControl:TLMDCustomRichEdit read FControl write SetControl;

    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;

    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  end;

const
  AlignConverter : array [PFA_LEFT..PFA_CENTER] of TLMDParaAlignment =
                   (paLeftJustify, paRightJustify, paCenter);

function SafeStrToInt(const Value : string) : LongInt;

implementation

uses
  SysUtils, Printers, Comstrs, Math, ClipBrd, ComObj,
  ActiveX, OleDlg, OleCtnrs, OleConst,
  Commctrl, StdActns, ShellApi, LMDRTFInt, LMDRTFFontDialog,
  LMDRTFPageDialog, LMDRTFParagraphProp, LMDRTFTabsProp, LMDRTFPrintPreview,
  LMDRTFStatisticsDialog, LMDRTFCharmapDialog, LMDRTFActions, LMDUtils, LMDProcs,
  LMDRTFHyperTextStorage, LMDRTFHyperText, LMDRTFImageDataObject,
  LMDRTFInsertDateTimeDlg, LMDConversion;

const
  WM_USER = $400;
  EM_SETTYPOGRAPHYOPTIONS = (WM_USER + 202);
  EM_GETTYPOGRAPHYOPTIONS = (WM_USER + 203);
  TO_ADVANCEDTYPOGRAPHY = $1;
  TO_SIMPLELINEBREAK = $2;
  PFE_TABLE = $4000;

{------------------------------------------------------------------------------}
function SafeStrToInt(const value : string) : LongInt;
var
  code : integer;
begin
  result := 0;
  try val(value, result, code) except end;
  if code <> 0 then result := 0;
end;

  // We must be safe!
type
  PENLink = ^TENLink;

var
  RTFConversionFormat: TLMDConversionFormat = (
    ConversionClass: TLMDConversion;
    Extension: 'rtf';
  Next: nil;
  );

  TextConversionFormat: TLMDConversionFormat = (
    ConversionClass: TLMDConversion;
    Extension: 'txt';
  Next: @RTFConversionFormat;
  );

  ConversionFormatList: PLMDConversionFormat = @TextConversionFormat;

var
  FRichEditModule: THandle;
  RichEditVer: LongInt;

{ Clipboard formats }

var
  CFEmbeddedObject: Integer;
  CFLinkSource: Integer;
  CFRtf: Integer;
  CFRtfNoObjs: Integer;

const
  CF_EMBEDDEDOBJECT = 'Embedded Object';
  CF_LINKSOURCE = 'Link Source';
  ShellDllName = 'shell32.dll';
  RichEditModuleName = 'RICHED20.DLL';

procedure DeleteStr(var S: string; Index, Count: Integer);
begin
  Delete(S, Index, Count);
end;

{ Get RichEdit OLE interface }

function GetRichEditOle(Wnd: HWnd; var RichEditOle): Boolean;
begin
  Result := SendMessage(Wnd, EM_GETOLEINTERFACE, 0,
    TLMDPtrInt(@RichEditOle)) <> 0;
end;

{ ************************** TLMDTextAttributes  ************************** }
const
  AttrFlags: array[TLMDAttributeType] of Word = (SCF_DEFAULT, SCF_SELECTION,
    SCF_WORD or SCF_SELECTION);

{  ****************************** public  ********************************* }
{ ------------------------------------------------------------------------- }

constructor TLMDTextAttributes.Create(AOwner: TLMDCustomRichEdit; AttributeType: TLMDAttributeType);
begin
  inherited Create;
  RichEdit:= AOwner;
  FType:= AttributeType;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.Assign(Source: TPersistent);
var
  Format: TCharFormat2;
begin
  if Source is TFont then
    AssignFont(TFont(Source))
  else
    if Source is TLMDTextAttributes then
      begin
        TLMDTextAttributes(Source).GetAttributes(Format);
        SetAttributes(Format);
      end
    else
      inherited Assign(Source);
end;

{ ------------------------------------------------------------------------- }

function TLMDTextAttributes.TextAttributesDialog: Boolean;
begin
  with TLMDRTFFontDialog.Create(Self.RichEdit) do
    begin
      try
        RichEdit := Self.RichEdit;
        AttributeType := FType;
        Result := Execute;
      finally
        Free;
      end;
    end;
end;

{ ******************************* protected  ****************************** }
{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.InitFormat(var Format: TCharFormat2);
begin

  FillChar(Format, SizeOf(Format), 0);
  if RichEdit.Version >= 2 then
    Format.cbSize:= SizeOf(TCharFormat2)
  else
    Format.cbSize:= SizeOf(TCharFormat);

end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.AssignTo(Dest: TPersistent);
begin
  if Dest is TFont then
  begin
    TFont(Dest).Color:= Color;
    TFont(Dest).Name:= Name;
    TFont(Dest).Charset:= Charset;
    TFont(Dest).Style:= Style;
    TFont(Dest).Size:= Size;
    TFont(Dest).Pitch:= Pitch;
  end
{  else if Dest is TTextAttributes then begin
    TTextAttributes(Dest).Color:= Color;
    TTextAttributes(Dest).Name:= Name;
    TTextAttributes(Dest).Charset:= Charset;
    TTextAttributes(Dest).Style:= Style;
    TTextAttributes(Dest).Pitch:= Pitch;
  end}
  else
    inherited AssignTo(Dest);
end;

{ ****************************** private  ********************************* }
{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.AssignFont(Font: TFont);
var
  LogFont: TLogFont;
  Format: TCharFormat2;
begin
  InitFormat(Format);
  with Format do
  begin
    case Font.Pitch of
      fpVariable: bPitchAndFamily:= VARIABLE_PITCH;
      fpFixed: bPitchAndFamily:= FIXED_PITCH;
    else
      bPitchAndFamily:= DEFAULT_PITCH;
    end;
    dwMask:= dwMask or CFM_SIZE or CFM_BOLD or CFM_ITALIC or
      CFM_UNDERLINE or CFM_STRIKEOUT or CFM_FACE or CFM_COLOR;
    yHeight:= Font.Size * 20;
    if fsBold in Font.Style then dwEffects:= dwEffects or CFE_BOLD;
    if fsItalic in Font.Style then dwEffects:= dwEffects or CFE_ITALIC;
    if fsUnderline in Font.Style then dwEffects:= dwEffects or CFE_UNDERLINE;
    if fsStrikeOut in Font.Style then dwEffects:= dwEffects or CFE_STRIKEOUT;
    StrPLCopy(szFaceName, Font.Name, SizeOf(szFaceName));
    {    if (Font.Color = clWindowText) or (Font.Color = clDefault) then
      dwEffects:= CFE_AUTOCOLOR}
    {else}
    crTextColor := ColorToRGB(Font.Color);
    dwMask:= dwMask or CFM_CHARSET;
    bCharSet:= Font.Charset;
    if GetObject(Font.Handle, SizeOf(LogFont), @LogFont) <> 0 then
    begin
      dwMask:= dwMask or DWORD(CFM_WEIGHT);
      wWeight:= Word(LogFont.lfWeight);
    end;
  end;
  SetAttributes(Format);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.GetAttributes(var Format: TCharFormat2);
begin
  InitFormat(Format);
  if RichEdit.HandleAllocated then
  SendMessage(RichEdit.Handle, EM_GETCHARFORMAT, AttrFlags[FType], LPARAM(@Format));
  end;

{ ------------------------------------------------------------------------- }

function TLMDTextAttributes.GetBackColor: TColor;
var
  Format: TCharFormat2;
begin
  if RichEdit.Version < 2 then
  begin
    Result := clWindow;
    Exit;
  end;
  GetAttributes(Format);
  with Format do
  if (dwEffects and CFE_AUTOBACKCOLOR) <> 0 then
    Result := clWindow
  else
    Result := crBackColor;
end;

{ ------------------------------------------------------------------------- }

function TLMDTextAttributes.GetCharset: TFontCharset;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
  Result:= Format.bCharset;
end;

{ ------------------------------------------------------------------------- }

function TLMDTextAttributes.GetColor: TColor;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
  with Format do
    if (dwEffects and CFE_AUTOCOLOR) <> 0 then
      Result:= clWindowText
    else
      Result:= crTextColor;
end;

{ ------------------------------------------------------------------------- }

function TLMDTextAttributes.GetConsistentAttributes: TLMDConsistentAttributes;
var
  Format: TCharFormat2;
  dwMask: dword;
begin
  Result:= [];
  if RichEdit.HandleAllocated and (FType <> atDefaultText) then
    begin
      InitFormat(Format);
    dwMask := SendMessage(RichEdit.Handle, EM_GETCHARFORMAT,
        AttrFlags[FType], LPARAM(@Format));
    //      with Format do
        begin
          if (dwMask and CFM_BOLD) <> 0 then Include(Result, caBold);
          if (dwMask and CFM_COLOR) <> 0 then Include(Result, caColor);
          if (dwMask and CFM_FACE) <> 0 then Include(Result, caFace);
          if (dwMask and CFM_ITALIC) <> 0 then Include(Result, caItalic);
          if (dwMask and CFM_SIZE) <> 0 then Include(Result, caSize);
          if (dwMask and CFM_STRIKEOUT) <> 0 then Include(Result, caStrikeOut);
          if (dwMask and CFM_UNDERLINE) <> 0 then Include(Result, caUnderline);
          if (dwMask and CFM_PROTECTED) <> 0 then Include(Result, caProtected);
          if (dwMask and CFM_OFFSET) <> 0 then Include(Result, caOffset);
          if (dwMask and CFM_HIDDEN) <> 0 then Include(result, caHidden);
          if RichEdit.Version >= 2 then
            begin
              if (dwMask and CFM_REVISED) <> 0 then Include(Result, caRevised);

              if (dwMask and CFM_BACKCOLOR) <> 0 then
                Include(Result, caBackColor);
              if (dwMask and CFM_LINK) <> 0 then Include(Result, caLink);
              if (dwMask and CFM_DISABLED) <> 0 then
                Include(Result, caDisabled);
              if (dwMask and CFM_WEIGHT) <> 0 then Include(Result, caWeight);
              if (dwMask and CFM_SUBSCRIPT) <> 0 then
                Include(Result, caSubscript);
              if (dwMask and CFM_REVAUTHOR) <> 0 then
                Include(Result, caRevAuthor);
            end;
        end;
    end;
end;

{ ------------------------------------------------------------------------- }

function TLMDTextAttributes.GetDisabled: Boolean;
var
  Format: TCharFormat2;
begin
  Result:= False;
  if RichEdit.Version < 2 then Exit;
  GetAttributes(Format);
  Result:= Format.dwEffects and CFE_DISABLED <> 0;
end;

{ ------------------------------------------------------------------------- }

function TLMDTextAttributes.GetHidden: Boolean;
var
  Format: TCharFormat2;
begin
  Result:= False;
  if RichEdit.Version < 2 then Exit;
  GetAttributes(Format);
  Result:= Format.dwEffects and CFE_HIDDEN <> 0;
end;

{ ------------------------------------------------------------------------- }

function TLMDTextAttributes.GetLink: Boolean;
var
  Format: TCharFormat2;
begin
  Result:= False;
  if RichEdit.Version < 2 then Exit;

  InitFormat(Format);
  Format.dwMask := CFM_LINK;
  if RichEdit.HandleAllocated then
  Format.dwMask := SendMessage(RichEdit.Handle, EM_GETCHARFORMAT, AttrFlags[FType],
      LPARAM(@Format));
  Result:= (Format.dwEffects and CFE_LINK) <> 0;

{
  GetAttributes(Format);
  with Format do
    Result:= (dwEffects and CFE_LINK) <> 0;
}
end;

{ ------------------------------------------------------------------------- }

function TLMDTextAttributes.GetName: TFontName;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
  Result:= Format.szFaceName;
end;

{ ------------------------------------------------------------------------- }
function TLMDTextAttributes.GetOffset: Integer;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
  Result := Round(LMDTwipsTo(Format.yOffset, RichEdit.Measurement));
end;

{ ------------------------------------------------------------------------- }

function TLMDTextAttributes.GetPitch: TFontPitch;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
  case (Format.bPitchAndFamily and $03) of
    DEFAULT_PITCH: Result:= fpDefault;
    VARIABLE_PITCH: Result:= fpVariable;
    FIXED_PITCH: Result:= fpFixed;
  else
    Result:= fpDefault;
  end;
end;

{ ------------------------------------------------------------------------- }

function TLMDTextAttributes.GetProtected: Boolean;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
  with Format do
    Result:= (dwEffects and CFE_PROTECTED) <> 0;
end;

{ ------------------------------------------------------------------------- }

function TLMDTextAttributes.GetRevised: Boolean;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
  with Format do
    Result:= (dwEffects and CFE_REVISED) <> 0;
end;

{ ------------------------------------------------------------------------- }

function TLMDTextAttributes.GetRevAuthorIndex: Byte;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
  Result:= Format.bRevAuthor;
end;

{ ------------------------------------------------------------------------- }
function TLMDTextAttributes.GetSubscriptStyle: TLMDRichSubscriptStyle;
var
  Format: TCharFormat2;
begin
  Result:= ssNone;
  if RichEdit.Version < 2 then Exit;
  GetAttributes(Format);
  with Format do
    begin
      if (dwEffects and CFE_SUBSCRIPT) <> 0 then
        Result:= ssSubscript
      else if (dwEffects and CFE_SUPERSCRIPT) <> 0 then
        Result:= ssSuperscript;
    end;
end;

{ ------------------------------------------------------------------------- }

function TLMDTextAttributes.GetSize: Integer;
var
  Format: TCharFormat2;
begin
  GetAttributes(Format);
{  case RichEdit.Measurement of
    unInches: Result:= LMDRichPointsToInches(Format.yHeight) div 20;
    unMillimeters: Result:= LMDRichPointsToMillimeters(Format.yHeight) div 20;
  else}
  Result:= Format.yHeight div 20;
{  end;}
end;

{ ------------------------------------------------------------------------- }

function TLMDTextAttributes.GetStyle: TFontStyles;
var
  Format: TCharFormat2;
begin
  Result:= [];
  GetAttributes(Format);
  with Format do
    begin
      if (dwEffects and CFE_BOLD) <> 0 then Include(Result, fsBold);
      if (dwEffects and CFE_ITALIC) <> 0 then Include(Result, fsItalic);
      if (dwEffects and CFE_UNDERLINE) <> 0 then Include(Result, fsUnderline);
      if (dwEffects and CFE_STRIKEOUT) <> 0 then Include(Result, fsStrikeOut);
    end;
end;

{ ------------------------------------------------------------------------- }

function TLMDTextAttributes.GetHeight: Integer;
var
  DC: HDC;
begin
  DC:= GetDC(0);
  try
    Result := -MulDiv(Size, GetDeviceCaps(DC, LOGPIXELSY), 72);
  finally
    ReleaseDC(0, DC);
  end;

//  Result:= MulDiv(Size, RichEdit.FScreenLogPixels, 72)
end;

{ ------------------------------------------------------------------------- }

function TLMDTextAttributes.GetUnderlineType: TLMDUnderlineType;
var
  Format: TCharFormat2;
begin
  Result:= utNone;
  if RichEdit.Version < 2 then Exit;
  GetAttributes(Format);
  with Format do
    begin
      if (dwEffects and CFE_UNDERLINE <> 0) and
        (dwMask and CFM_UNDERLINETYPE = CFM_UNDERLINETYPE) then
        Result:= TLMDUnderlineType(bUnderlineType);
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetAttributes(var Format: TCharFormat2);
begin
  if RichEdit.HandleAllocated then
    SendMessage(RichEdit.Handle, EM_SETCHARFORMAT, AttrFlags[FType],
                LPARAM(@Format));
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetBackColor(Value: TColor);
var
  Format: TCharFormat2;
begin
  if RichEdit.Version < 2 then Exit;
  InitFormat(Format);
  with Format do
    begin
      dwMask:= CFM_BACKCOLOR;
      if (Value = clWindow) or (Value = clDefault) then
        dwEffects:= CFE_AUTOBACKCOLOR
      else
        crBackColor:= ColorToRGB(Value);
    end;
  SetAttributes(Format);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetCharset(Value: TFontCharset);
var
  Format: TCharFormat2;
begin
  InitFormat(Format);
  with Format do
    begin
      dwMask:= CFM_CHARSET;
      bCharSet:= Value;
    end;
  SetAttributes(Format);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetColor(Value: TColor);
var
  Format: TCharFormat2;
begin
  InitFormat(Format);
  with Format do
    begin
      dwMask:= CFM_COLOR;
      if (Value = clWindowText) or (Value = clDefault) then
        dwEffects:= CFE_AUTOCOLOR
      else
        crTextColor:= ColorToRGB(Value);
    end;
  SetAttributes(Format);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetDisabled(Value: Boolean);
var
  Format: TCharFormat2;
begin
  if RichEdit.Version < 2 then Exit;
  InitFormat(Format);
  with Format do
    begin
      dwMask:= CFM_DISABLED;
      if Value then dwEffects:= CFE_DISABLED;
    end;
  SetAttributes(Format);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetHidden(Value: Boolean);
var
  Format: TCharFormat2;
begin
  if RichEdit.Version < 2 then Exit;
  InitFormat(Format);
  with Format do
    begin
      dwMask:= CFM_HIDDEN;
      if Value then dwEffects:= CFE_HIDDEN;
    end;
  SetAttributes(Format);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetLink(Value: Boolean);
var
  Format: TCharFormat2;
begin
  if RichEdit.Version < 2 then Exit;
  InitFormat(Format);
  with Format do
    begin
      dwMask:= CFM_LINK;
      if Value then dwEffects:= CFE_LINK;
    end;
  SetAttributes(Format);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetName(Value: TFontName);
var
  Format: TCharFormat2;
begin
  InitFormat(Format);
  with Format do
    begin
      dwMask:= CFM_FACE;
    StrPLCopy(szFaceName, Value, SizeOf(szFaceName));
    end;
  SetAttributes(Format);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetOffset(Value: Integer);
var
  Format: TCharFormat2;
begin
  InitFormat(Format);
  Value:= LMDToTwips(Value, RichEdit.Measurement);
  with Format do
    begin
      dwMask:= DWORD(CFM_OFFSET);
      yOffset:= Value;
    end;
  SetAttributes(Format);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetPitch(Value: TFontPitch);
var
  Format: TCharFormat2;
begin
  InitFormat(Format);
  with Format do
    begin
      case Value of
        fpVariable: bPitchAndFamily:= VARIABLE_PITCH;
        fpFixed: bPitchAndFamily:= FIXED_PITCH;
      else
        bPitchAndFamily:= DEFAULT_PITCH;
      end;
    end;
  SetAttributes(Format);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetProtected(Value: Boolean);
var
  Format: TCharFormat2;
begin
  RichEdit.FDefaultProtect:= true;
  InitFormat(Format);
  with Format do
    begin
      if Value then
      begin
      dwMask:= CFM_PROTECTED;
        dwEffects:= CFE_PROTECTED;
      end;
    end;
  SetAttributes(Format);
  RichEdit.FDefaultProtect:= false;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetRevised(Value: Boolean);
var
  Format: TCharFormat2;
begin
  InitFormat(Format);
  with Format do
    begin
      dwMask:= CFM_REVISED;
      if Value then dwEffects:= CFE_REVISED;
    end;
  SetAttributes(Format);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetRevAuthorIndex(Value: Byte);
var
  Format: TCharFormat2;
begin
  if RichEdit.Version < 2 then Exit;
  InitFormat(Format);
  with Format do
    begin
      dwMask:= CFM_REVAUTHOR;
      bRevAuthor:= Value;
    end;
  SetAttributes(Format);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetSubscriptStyle(Value: TLMDRichSubscriptStyle);
var
  Format: TCharFormat2;
begin
  if RichEdit.Version < 2 then Exit;
  InitFormat(Format);
  with Format do
    begin
      dwMask:= DWORD(CFM_SUBSCRIPT);
      case Value of
        ssSubscript: dwEffects:= CFE_SUBSCRIPT;
        ssSuperscript: dwEffects:= CFE_SUPERSCRIPT;
      end;
    end;
  SetAttributes(Format);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetSize(Value: Integer);
var
  Format: TCharFormat2;
begin
  InitFormat(Format);
{  case RichEdit.Measurement of
    unPoints: Value:= Value * 20;
    unInches: Value:= LMDRichInchesToPoints(Value  * 20);
    unMillimeters: Value:= LMDRichMillimetersToPoints(Value  * 20);
  end;}
  with Format do
    begin
      dwMask:= DWORD(CFM_SIZE);
      yHeight:= Value * 20;
    end;
  SetAttributes(Format);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetStyle(Value: TFontStyles);
var
  Format: TCharFormat2;
begin
  InitFormat(Format);
  with Format do
    begin
      dwMask:= CFM_BOLD or CFM_ITALIC or CFM_UNDERLINE or CFM_STRIKEOUT;
      if fsBold in Value then dwEffects:= dwEffects or CFE_BOLD;
      if fsItalic in Value then dwEffects:= dwEffects or CFE_ITALIC;
      if fsUnderline in Value then dwEffects:= dwEffects or CFE_UNDERLINE;
      if fsStrikeOut in Value then dwEffects:= dwEffects or CFE_STRIKEOUT;
    end;
  SetAttributes(Format);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetHeight(Value: Integer);
begin
  Size:= MulDiv(Value, 72, RichEdit.FScreenLogPixels);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDTextAttributes.SetUnderlineType(Value: TLMDUnderlineType);
var
  Format: TCharFormat2;
begin
  if RichEdit.Version < 2 then Exit;
  InitFormat(Format);
  with Format do
    begin
      dwMask:= CFM_UNDERLINETYPE or CFM_UNDERLINE;
      bUnderlineType:= Ord(Value);
      if Value <> utNone then dwEffects:= dwEffects or CFE_UNDERLINE;
    end;
  SetAttributes(Format);
end;

{ *************************** TLMDParaAttributes  ************************** }
{ *******************************   public    ****************************** }
constructor TLMDParaAttributes.Create(AOwner: TLMDCustomRichEdit);
begin
  inherited Create;
  RichEdit:= AOwner;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDParaAttributes.Assign(Source: TPersistent);
var
  Paragraph: TParaFormat2;
begin
  if Source is TLMDParaAttributes then
    begin
      TLMDParaAttributes(Source).GetAttributes(Paragraph);
      SetAttributes(Paragraph);
      exit;
    end;
  inherited Assign(Source);
end;

{ ------------------------------------------------------------------------- }
function TLMDParaAttributes.ParagraphDialog: Boolean;
begin
  Result := TLMDRichfrmParagraph.Execute(Self, RichEdit)
end;

{ ------------------------------------------------------------------------- }
function TLMDParaAttributes.TabsDialog: Boolean;
begin
  Result := TLMDRichfrmTabs.Execute(Self, RichEdit)
end;

{ ------------------------------------------------------------------------- }
procedure TLMDParaAttributes.ClearToDefaults;
var
  Paragraph: TParaFormat2;
begin
  InitPara(Paragraph);
  with Paragraph do
    begin
      dwMask := PFM_ALIGNMENT or PFM_STARTINDENT or PFM_OFFSET or
        PFM_RIGHTINDENT or PFM_SPACEAFTER or PFM_SPACEBEFORE or
        PFM_LINESPACING or PFM_NUMBERING or PFM_NUMBERINGSTART
        or PFM_NUMBERINGSTART or PFM_NUMBERINGSTYLE or
        PFM_NUMBERINGTAB or PFM_TABSTOPS;
//      wAlignment:= Ord(paLeftJustify) + 1;
    end;
  SetAttributes(Paragraph);
  RichEdit.SelectionChange;
end;

{ ******************************* protected  ****************************** }
{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.InitPara(var Paragraph: TParaFormat2);
begin

  FillChar(Paragraph, SizeOf(Paragraph), 0);

  if RichEdit.Version >= 2 then
  Paragraph.cbSize:= SizeOf(Paragraph)
  else
    Paragraph.cbSize:= SizeOf(TParaFormat);
end;

{ *******************************  private   ****************************** }
{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.GetAttributes(var Paragraph: TParaFormat2);
begin
  InitPara(Paragraph);
  if RichEdit.HandleAllocated then
  SendMessage(RichEdit.Handle, EM_GETPARAFORMAT, 0, LPARAM(@Paragraph));
  end;

{ ------------------------------------------------------------------------- }

function TLMDParaAttributes.GetAlignment: TLMDParaAlignment;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result:= AlignConverter[Paragraph.wAlignment];
end;

{ ------------------------------------------------------------------------- }
function TLMDParaAttributes.GetFirstIndent: Longint;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result:= Round(LMDTwipsTo(-Paragraph.dxOffset, RichEdit.Measurement));
end;

{ ------------------------------------------------------------------------- }

function TLMDParaAttributes.GetHeadingStyle: TLMDHeadingStyle;
var
  Paragraph: TParaFormat2;
begin
  if RichEdit.Version < 3 then
    Result:= 0
  else
    begin
      GetAttributes(Paragraph);
      Result:= Paragraph.sStyle;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.GetIndents(var Left, First, Right: integer);
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Left := Round(LMDTwipsTo(Paragraph.dxStartIndent + Paragraph.dxOffset,
    RichEdit.Measurement));
  First := Round(LMDTwipsTo(-Paragraph.dxOffset, RichEdit.Measurement));
  Right := Round(LMDTwipsTo(Paragraph.dxRightIndent, RichEdit.Measurement));
end;

{ ------------------------------------------------------------------------- }

function TLMDParaAttributes.GetLeftIndent: Longint;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result:= Round(LMDTwipsTo(Paragraph.dxStartIndent + Paragraph.dxOffset,
    RichEdit.Measurement));
end;

{ ------------------------------------------------------------------------- }
function TLMDParaAttributes.GetRightIndent: Longint;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result:= Round(LMDTwipsTo(Paragraph.dxRightIndent, RichEdit.Measurement));
end;

{ ------------------------------------------------------------------------- }
function TLMDParaAttributes.GetSpaceAfter: Longint;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result:= Round(LMDTwipsTo(Paragraph.dySpaceAfter, RichEdit.Measurement));
end;

{ ------------------------------------------------------------------------- }
function TLMDParaAttributes.GetSpaceBefore: Longint;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result:= Round(LMDTwipsTo(Paragraph.dySpaceBefore, RichEdit.Measurement));
end;

{ ------------------------------------------------------------------------- }
function TLMDParaAttributes.GetLineSpacing: Longint;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result:= Round(LMDTwipsTo(Paragraph.dyLineSpacing, RichEdit.Measurement));
end;

{ ------------------------------------------------------------------------- }
function TLMDParaAttributes.GetLineSpacingRule: TLMDLineSpacingRule;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result:= TLMDLineSpacingRule(Paragraph.bLineSpacingRule);
end;

{ ------------------------------------------------------------------------- }
function TLMDParaAttributes.GetNumbering: TLMDNumbering;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result:= TLMDNumbering(Paragraph.wNumbering);
  if RichEdit.Version = 1 then
    if Result <> nsNone then Result:= nsBullet;
end;

{ ------------------------------------------------------------------------- }

function TLMDParaAttributes.GetNumberingStart: LongInt;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result:= Paragraph.wNumberingStart;
end;

{ ------------------------------------------------------------------------- }

function TLMDParaAttributes.GetNumberingStyle: TLMDNumberingStyle;
var
  Paragraph: TParaFormat2;
begin
  if RichEdit.Version < 2 then
    Result:= nsSimple
  else
    begin
      GetAttributes(Paragraph);
      case  Paragraph.wNumberingStyle of
        $100: Result := nsEnclosed;
        $200: Result := nsPeriod;
        $300: Result := nsSimple;
        else  Result := nsParenthesis;
      end;
    end;
end;

{ ------------------------------------------------------------------------- }

function TLMDParaAttributes.GetNumberingTab: Word;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result:= Round(LMDTwipsTo(Paragraph.wNumberingTab, RichEdit.Measurement));
end;

{ ------------------------------------------------------------------------- }

function TLMDParaAttributes.GetTab(Index: Byte): Longint;
var
  Paragraph: TParaFormat2;
begin
  if  Index <= MAX_TAB_STOPS  then
    begin
      GetAttributes(Paragraph);
      Result:= Round(LMDTwipsTo(Paragraph.rgxTabs[Index], RichEdit.Measurement));
    end
  else
    Result := -999;
end;

{ ------------------------------------------------------------------------- }

function TLMDParaAttributes.GetTabCount: Integer;
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  Result:= Paragraph.cTabCount;
end;

{ ------------------------------------------------------------------------- }

function TLMDParaAttributes.GetTableStyle: TLMDParaTableStyle;
var
  Paragraph: TParaFormat2;
begin
  Result:= tsNone;
  if RichEdit.Version < 2 then Exit;
  GetAttributes(Paragraph);
  with Paragraph do
    begin
      if (wReserved and PFE_TABLE) <> 0 then
        Result:= tsTable
      else if (wReserved and PFE_TABLEROW) <> 0 then
        Result:= tsTableRow
      else if (wReserved and PFE_TABLECELLEND) <> 0 then
        Result:= tsTableCellEnd
      else if (wReserved and PFE_TABLECELL) <> 0 then
        Result:= tsTableCell;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.SetAlignment(Value: TLMDParaAlignment);
var
  Paragraph: TParaFormat2;
begin
  InitPara(Paragraph);
  with Paragraph do
    begin
      dwMask:= PFM_ALIGNMENT;
      wAlignment:= Ord(Value) + 1;
    end;
  SetAttributes(Paragraph);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.SetAttributes(var Paragraph: TParaFormat2);
begin
  RichEdit.HandleNeeded; { we REALLY need the handle for BiDi }
  if RichEdit.HandleAllocated then
    begin
      if RichEdit.UseRightToLeftAlignment then
        if Paragraph.wAlignment = PFA_LEFT then
          Paragraph.wAlignment:= PFA_RIGHT
        else if Paragraph.wAlignment = PFA_RIGHT then
          Paragraph.wAlignment:= PFA_LEFT;
    SendMessage(RichEdit.Handle, EM_SETPARAFORMAT, 0, LPARAM(@Paragraph));
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.SetHeadingStyle(Value: TLMDHeadingStyle);
var
  Paragraph: TParaFormat2;
begin
  if RichEdit.Version < 3 then Exit;
  InitPara(Paragraph);
  with Paragraph do
    begin
      dwMask:= PFM_STYLE;
      sStyle:= Value;
    end;
  SetAttributes(Paragraph);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.SetLeftIndent(Value: Longint);
var
  Paragraph: TParaFormat2;
  SI, Offset: integer;
begin
  GetAttributes(Paragraph);
  Offset := Paragraph.dxOffset;
  SI := LMDToTwips(Value, RichEdit.Measurement);

  if  SI < 0  then
    SI := 0;

  SI := SI - Offset;

  if  (SI <> Paragraph.dxStartIndent) or (Offset <> Paragraph.dxOffset) then
    begin
      InitPara(Paragraph);
      with Paragraph do
        begin
          dwMask:= PFM_STARTINDENT or PFM_OFFSET;
          dxStartIndent:= SI;
          dxOffset:= Offset;
        end;
      SetAttributes(Paragraph);
      RichEdit.SelectionChange;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.SetParagraphIndent(Left, First: integer);
var
  Paragraph: TParaFormat2;
  SI, Offset: integer;
begin
  GetAttributes(Paragraph);
  SI := LMDToTwips(Left + First, RichEdit.Measurement);

  if  SI < 0  then  SI := 0;

  Offset := LMDToTwips(Left, RichEdit.Measurement) - SI;

  if  (SI <> Paragraph.dxStartIndent) or (Offset <> Paragraph.dxOffset) then
    begin
      InitPara(Paragraph);

      with Paragraph do
        begin
          dwMask:= PFM_STARTINDENT or PFM_OFFSET;
          dxStartIndent:= SI;
          dxOffset:= Offset;
        end;
      SetAttributes(Paragraph);
      RichEdit.SelectionChange;
    end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDParaAttributes.SetFirstIndent(Value: Longint);
var
  Paragraph: TParaFormat2;
  SI, Offs: integer;
begin
  GetAttributes(Paragraph);
  Offs := Paragraph.dxOffset;
  SI := Paragraph.dxStartIndent;
  Value:= LMDToTwips(Value, RichEdit.Measurement);

  if  Value < -(SI + Offs)  then
    Value := -(SI + Offs);

  if  Value <> -Offs then
    begin
      InitPara(Paragraph);

      with Paragraph do
        begin
          dwMask:= PFM_STARTINDENT or PFM_OFFSET;
          dxStartIndent:= SI + Offs + Value;
          dxOffset:= -Value;
        end;
      SetAttributes(Paragraph);
      RichEdit.SelectionChange;
    end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDParaAttributes.SetRightIndent(Value: Longint);
var
  Paragraph: TParaFormat2;
begin
  InitPara(Paragraph);
  Value:= LMDToTwips(Value, RichEdit.Measurement);
  with Paragraph do
    begin
      dwMask:= PFM_RIGHTINDENT;
      dxRightIndent:= Value;
    end;
  SetAttributes(Paragraph);
  RichEdit.SelectionChange;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDParaAttributes.SetSpaceAfter(Value: Longint);
var
  Paragraph: TParaFormat2;
begin
  if RichEdit.Version < 2 then Exit;
  InitPara(Paragraph);
  Value:= LMDToTwips(Value, RichEdit.Measurement);
  with Paragraph do
    begin
      dwMask:= PFM_SPACEAFTER;
      dySpaceAfter:= Value;
    end;
  SetAttributes(Paragraph);
end;

{ ------------------------------------------------------------------------- }
procedure TLMDParaAttributes.SetSpaceBefore(Value: Longint);
var
  Paragraph: TParaFormat2;
begin
  if RichEdit.Version < 2 then Exit;
  InitPara(Paragraph);
  Value:= LMDToTwips(Value, RichEdit.Measurement);
  with Paragraph do
    begin
      dwMask:= PFM_SPACEBEFORE;
      dySpaceBefore:= Value;
    end;
  SetAttributes(Paragraph);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.SetLineSpacing(Value: Longint);
var
  Paragraph: TParaFormat2;
begin
  if RichEdit.Version < 2 then Exit;
  GetAttributes(Paragraph);
  Value:= LMDToTwips(Value, RichEdit.Measurement);
  with Paragraph do
    begin
      dwMask:= PFM_LINESPACING;
      dyLineSpacing:= Value;
    end;
  SetAttributes(Paragraph);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.SetLineSpacingRule(Value: TLMDLineSpacingRule);
var
  Paragraph: TParaFormat2;
begin
  if RichEdit.Version < 2 then Exit;
  GetAttributes(Paragraph);
  with Paragraph do
    begin
      dwMask:= PFM_LINESPACING;
      bLineSpacingRule:= Ord(Value);
    end;
  SetAttributes(Paragraph);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.SetNumbering(Value: TLMDNumbering);
var
  Paragraph: TParaFormat2;
begin
  if RichEdit.Version = 1 then
    if Value <> nsNone then Value:= TLMDNumbering(PFN_BULLET);
  case Value of
    nsNone: LeftIndent:= 0;
  else if LeftIndent < 10 then
    LeftIndent:= 10;
  end;
  InitPara(Paragraph);
  with Paragraph do
    begin
      dwMask:= PFM_NUMBERING;
      wNumbering:= Ord(Value);
    end;
  SetAttributes(Paragraph);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.SetNumberingStart(const Value: LongInt);
var
  Paragraph: TParaFormat2;
begin
  if RichEdit.Version < 3 then Exit;
  InitPara(Paragraph);
  with Paragraph do
    begin
      dwMask:= PFM_NUMBERINGSTART;
      wNumberingStart:= Value;
    end;
  SetAttributes(Paragraph);
end;
{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.SetNumberingStyle(Value: TLMDNumberingStyle);
var
  Paragraph: TParaFormat2;
begin
  if RichEdit.Version < 2 then Exit;
  InitPara(Paragraph);
  with Paragraph do
    begin
      dwMask:= PFM_NUMBERINGSTYLE;

      case  Value of
        nsParenthesis:  wNumberingStyle:= 0;
        nsEnclosed:     wNumberingStyle:= $100;
        nsPeriod:       wNumberingStyle:= $200;
        nsSimple:       wNumberingStyle:= $300;
      end;
    end;
  SetAttributes(Paragraph);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.SetNumberingTab(Value: Word);
var
  Paragraph: TParaFormat2;
begin
  if RichEdit.Version < 2 then Exit;
  InitPara(Paragraph);
  Value:= LMDToTwips(Value, RichEdit.Measurement);
  with Paragraph do
    begin
      dwMask:= PFM_NUMBERINGTAB;
      wNumberingTab:= Value;
    end;
  SetAttributes(Paragraph);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.SetTab(Index: Byte; Value: Longint);
var
  Paragraph: TParaFormat2;
begin
  if  (Index > MAX_TAB_STOPS) then Exit;
  GetAttributes(Paragraph);
  Value:= LMDToTwips(Value, RichEdit.Measurement);
  with Paragraph do
    begin
      rgxTabs[Index]:= Value;
      dwMask:= PFM_TABSTOPS;
      if cTabCount < Index + 1 then cTabCount:= Index + 1;
      SetAttributes(Paragraph);
    end;
  RichEdit.SelectionChange;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.SetTabs(const Tabs: array of integer);
var
  Paragraph: TParaFormat2;
  i, N: integer;
begin
  N := High(Tabs);
  if  (N > MAX_TAB_STOPS)  then  N := MAX_TAB_STOPS;
  GetAttributes(Paragraph);
  Paragraph.dwMask:= PFM_TABSTOPS;
  Paragraph.cTabCount := N + 1;

  for i := 0 to N do
    Paragraph.rgxTabs[i]:= LMDToTwips(Tabs[i], RichEdit.Measurement);

  SetAttributes(Paragraph);
  RichEdit.SelectionChange;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.SetTabCount(Value: Integer);
var
  Paragraph: TParaFormat2;
begin
  GetAttributes(Paragraph);
  with Paragraph do
    begin
      dwMask:= PFM_TABSTOPS;
      cTabCount:= Value;
      SetAttributes(Paragraph);
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDParaAttributes.SetTableStyle(Value: TLMDParaTableStyle);
var
  Paragraph: TParaFormat2;
begin
  if RichEdit.Version < 2 then Exit;
  InitPara(Paragraph);
  with Paragraph do
    begin
      dwMask:= PFM_TABLE;
      case Value of
        tsTable: wReserved:= PFE_TABLE;
        tsTableRow: wReserved:= PFE_TABLEROW;
        tsTableCellEnd: wReserved:= PFE_TABLECELLEND;
        tsTableCell: wReserved:= PFE_TABLECELL;
      end;
    end;
  SetAttributes(Paragraph);
end;

{ ***************************** TConversion  ****************************** }
{ ------------------------------------------------------------------------- }

constructor TLMDConversion.Create;
begin
  inherited;
end;

{ ------------------------------------------------------------------------- }

function TLMDConversion.ConvertReadStream(Stream: TStream; Buffer: PAnsiChar;
  BufSize: Integer): Integer;
begin
  Result:= Stream.Read(Buffer^, BufSize);
end;

{ ------------------------------------------------------------------------- }

function TLMDConversion.ConvertWriteStream(Stream: TStream; Buffer: PAnsiChar;
  BufSize: Integer): Integer;
begin
  Result:= Stream.Write(Buffer^, BufSize);
end;

{  ************************** TRichEditStrings  ************************** }
const
  ReadError  = $0001;
  WriteError = $0002;
  NoError    = $0000;
  REStrMaxLineBytes = 4096 * 2;

type
  TSelection = record
    StartPos, EndPos: Integer;
  end;

  TRichEditStrings = class(TStrings)
  private
    RichEdit: TLMDCustomRichEdit;
    FPlainText: Boolean;
    FConverter: TLMDConversion;
    procedure EnableChange(const Value: Boolean);
    procedure WriteData(Writer: TWriter);
    procedure ReadData(Reader: TReader);
  protected
    function Get(Index: Integer): string; override;
    function GetCount: Integer; override;
    procedure Put(Index: Integer; const S: string); override;
    procedure SetUpdateState(Updating: Boolean); override;
    procedure SetTextStr(const Value: string); override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; override;
    procedure AddStrings(Strings: TStrings); override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
 procedure LoadFromFile(const FileName: string); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToFile(const FileName: string); override;
    procedure SaveToStream(Stream: TStream); override;
 property PlainText: Boolean read FPlainText write FPlainText;
  end;

{ ********************************* public  ******************************* }
{ ------------------------------------------------------------------------- }

constructor TRichEditStrings.Create;
begin
  inherited Create;
  FPlainText := False;
end;

{ ------------------------------------------------------------------------- }

destructor TRichEditStrings.Destroy;
begin
  FConverter.Free;
  inherited Destroy;
end;

{ ------------------------------------------------------------------------- }

procedure TRichEditStrings.Clear;
begin
  RichEdit.Clear;
end;

{ ------------------------------------------------------------------------- }

procedure TRichEditStrings.AddStrings(Strings: TStrings);
var
  SelChange: TNotifyEvent;
  Stream: TMemoryStream;
begin
  SelChange:= RichEdit.OnSelectionChange;
  RichEdit.OnSelectionChange:= nil;
  Stream := nil;
  try
//    inherited AddStrings(Strings);
    if Assigned(Strings) then
      begin
        Stream := TMemoryStream.Create;
        Strings.SaveToStream(Stream);
        Stream.Position := 0;
        LoadFromStream(Stream);
      end
    else
      Clear;
  finally
    Stream.Free;
    RichEdit.OnSelectionChange:= SelChange;
  end;
end;

{ ------------------------------------------------------------------------- }

procedure TRichEditStrings.Delete(Index: Integer);
const
  Empty: PChar = '';
var
  Selection: TCharRange;
begin
  if Index < 0 then Exit;
  Selection.cpMin:= SendMessage(RichEdit.Handle, EM_LINEINDEX, Index, 0);
  if Selection.cpMin <> -1 then
    begin
      Selection.cpMax:= SendMessage(RichEdit.Handle, EM_LINEINDEX, Index + 1,
        0);
      if Selection.cpMax = -1 then
        Selection.cpMax:= Selection.cpMin +
          SendMessage(RichEdit.Handle, EM_LINELENGTH, Selection.cpMin, 0);
    SendMessage(RichEdit.Handle, EM_EXSETSEL, 0, TLMDPtrInt(@Selection));
      SendMessage(RichEdit.Handle, EM_REPLACESEL, 0, TLMDPtrInt(Empty));
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TRichEditStrings.Insert(Index: Integer; const S: string);
var
  L: Integer;
  Selection: TCharRange;
  Fmt: PChar;
  Str: string;
begin
  if Index >= 0 then
    begin
      Selection.cpMin:= SendMessage(RichEdit.Handle, EM_LINEINDEX, Index, 0);
      if Selection.cpMin >= 0 then
        Fmt:= '%s'#13#10
      else
        begin
          Selection.cpMin:=
            SendMessage(RichEdit.Handle, EM_LINEINDEX, Index - 1, 0);
          if Selection.cpMin < 0 then Exit;
          L:= SendMessage(RichEdit.Handle, EM_LINELENGTH, Selection.cpMin, 0);
          if L = 0 then Exit;
          Inc(Selection.cpMin, L);
          Fmt:= #13#10'%s';
        end;
      Selection.cpMax:= Selection.cpMin;
      Str:= Format(Fmt, [S]);
    SendMessage(RichEdit.Handle, EM_EXSETSEL, 0, TLMDPtrInt(@Selection));
      SendMessage(RichEdit.Handle, EM_REPLACESEL, 0, TLMDPtrInt(PChar(Str)));
    {    if RichEdit.SelStart <> (Selection.cpMax + Length(Str)) then
      raise EOutOfResources.Create(sRichEditInsertError);}
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TRichEditStrings.LoadFromFile(const FileName: string);
var
  Ext: string;
  Convert: PLMDConversionFormat;

  {$IFDEF LMDCOMP12}
  Stream: TStream;
  {$ENDIF}

begin
  RichEdit.DoSetMaxLength($7FFFFFF0);
  Ext := AnsiLowerCaseFileName(ExtractFileExt(Filename));
  DeleteStr(Ext, 1, 1);

  Convert := ConversionFormatList;
  while Convert <> nil do
    if Convert.Extension <> Ext then
      Convert:= Convert.Next
    else
      Break;

  Convert:= @TextConversionFormat;
  if FConverter = nil then FConverter:= Convert.ConversionClass.Create;
  try
  {$IFDEF LMDCOMP12} //ToDo: VB
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
    {$ELSE}
    inherited LoadFromFile(FileName);
    {$ENDIF}
  except
    FConverter.Free;
    FConverter:= nil;
    raise;
  end;
end;

{ ------------------------------------------------------------------------- }
{$ifdef LMDX64}
function AdjustLineBreaks(Dest, Source: PAnsiChar): Integer; assembler;
asm
        .NOFRAME
        PUSH    RSI
        PUSH    RDI
        MOV     RDI,RCX
        MOV     RSI,RDX
        MOV     RDX,RCX
        CLD
@@1:    LODSB
@@2:    OR      AL,AL
        JE      @@4
        CMP     AL,0AH
        JE      @@3
        STOSB
        CMP     AL,0DH
        JNE     @@1
        MOV     AL,0AH
        STOSB
        LODSB
        CMP     AL,0AH
        JE      @@1
        JMP     @@2
@@3:    MOV     EAX,0A0DH
        STOSW
        JMP     @@1
@@4:    STOSB
        LEA     RAX,[RDI-1]
        SUB     RAX,RDX
        POP     RDI
        POP     RSI
end;
{$else}
function AdjustLineBreaks(Dest, Source: PAnsiChar): Integer; assembler;
asm
        PUSH    ESI
        PUSH    EDI
        MOV     EDI,EAX
        MOV     ESI,EDX
        MOV     EDX,EAX
        CLD
@@1:    LODSB
@@2:    OR      AL,AL
        JE      @@4
        CMP     AL,0AH
        JE      @@3
        STOSB
        CMP     AL,0DH
        JNE     @@1
        MOV     AL,0AH
        STOSB
        LODSB
        CMP     AL,0AH
        JE      @@1
        JMP     @@2
@@3:    MOV     EAX,0A0DH
        STOSW
        JMP     @@1
@@4:    STOSB
        LEA     EAX,[EDI-1]
        SUB     EAX,EDX
        POP     EDI
        POP     ESI
end;
{$endif}

{ ------------------------------------------------------------------------- }

function StreamLoad(dwCookie: Longint; pbBuff: PByte; cb: Longint;
  var pcb: Longint): Longint; stdcall;
var
  Buffer, pBuff: PAnsiChar;
  StreamInfo: PLMDRichEditStreamInfo;
begin
  Result:= NoError;
  StreamInfo:= PLMDRichEditStreamInfo(Pointer(dwCookie));
  {$ifdef LMDCOMP12}
  Buffer:= AnsiStrAlloc(cb + 1);
  {$else}
  Buffer:= StrAlloc(cb + 1);
  {$endif}
  try
    cb:= cb div 2;
    pcb:= 0;
    pBuff := Buffer + cb;
    try
      if StreamInfo.Converter <> nil then
        pcb:= StreamInfo.Converter.ConvertReadStream(StreamInfo.Stream, pBuff, cb);
      if pcb > 0 then
        begin
          pBuff[pcb]:= #0;
          if pBuff[pcb - 1] = #13 then pBuff[pcb - 1]:= #0;
          pcb := AdjustLineBreaks(Buffer, pBuff);
          Move(Buffer^, pbBuff^, pcb);
        end;
    except
      Result:= ReadError;
    end;
  finally
    StrDispose(Buffer);
  end;
end;

function StreamInCallback(dwCookie: {$IFDEF LMDCOMP19}DWORD_PTR{$ELSE}Longint{$ENDIF};
           pbBuff: PByte; cb: Longint; var pcb: Longint): Longint; stdcall;
var
  Stream : TStream;
begin
  Result := NoError;

  Stream := TStream(Pointer(dwCookie));
  if Assigned(Stream) then begin
    pcb := 0;
    try
      pcb := Stream.Read(pbBuff^, cb);
    except
      result := 1;
    end;
  end;
end;

function StreamOutCallback(dwCookie: {$IFDEF LMDCOMP19}DWORD_PTR{$ELSE}Longint{$ENDIF};
           pbBuff: PByte; cb: Longint; var pcb: Longint): Longint; stdcall;
var
  Stream : TStream;
begin
  result := 0;
  Stream := TStream(Pointer(dwCookie));
  pcb := 0;
  try
    pcb := Stream.Write(pbBuff^, cb);
  except
    result := 1;
  end;
end;

{ ------------------------------------------------------------------------- }

procedure TRichEditStrings.LoadFromStream(Stream: TStream);
var
  EditStream: TEditStream;
  Position: Longint;
  TextType: Longint;
  StreamInfo: TLMDRichEditStreamInfo;
  Converter: TLMDConversion;

begin
  RichEdit.BeforeLoad(Stream);

  StreamInfo.Stream:= Stream;
  if FConverter <> nil then
    Converter := FConverter
  else
    Converter := RichEdit.DefaultConverter.Create;
  StreamInfo.Converter:= Converter;

  try
    with EditStream do
      begin
        dwCookie:= TLMDPtrInt(Pointer(@StreamInfo));
        pfnCallBack:= @StreamLoad;
        dwError:= 0;
      end;
    Position:= Stream.Position;
    if PlainText then
      TextType:= SF_TEXT
    else
      TextType:= SF_RTF;
    SendMessage(RichEdit.Handle, EM_STREAMIN, TextType, TLMDPtrInt(@EditStream));
//    if (TextType = SF_RTF) and (EditStream.dwError <> 0) then
    if EditStream.dwError <> 0 then
      begin
        Stream.Position:= Position;
        if PlainText then
          TextType:= SF_RTF
        else
          TextType:= SF_TEXT;
        SendMessage(RichEdit.Handle, EM_STREAMIN, TextType, TLMDPtrInt(@EditStream));
      end;
  finally
    if FConverter = nil then Converter.Free;
  end;

end;

{ ------------------------------------------------------------------------- }
procedure TRichEditStrings.SaveToFile(const FileName: string);
var
  Ext: string;
  Convert: PLMDConversionFormat;

  {$IFDEF LMDCOMP12}
  Stream: TStream;
  {$ENDIF}

begin

  Ext := AnsiLowerCaseFileName(ExtractFileExt(Filename));

  DeleteStr(Ext, 1, 1);

  Convert := ConversionFormatList;
  while Convert <> nil do
    if Convert.Extension <> Ext then
      Convert := Convert.Next
    else
      Break;

  if Convert = nil then
    Convert:= @TextConversionFormat;

  if FConverter = nil then FConverter:= Convert.ConversionClass.Create;
  try
  {$IFDEF LMDCOMP12} //ToDo: VB
    Stream := TFileStream.Create(FileName, fmCreate);
    try
      SaveToStream(Stream);
    finally
      Stream.Free;
    end;
    {$ELSE}
    inherited SaveToFile(FileName);
    {$ENDIF}
  except
    FConverter.Free;
    FConverter:= nil;
    raise;
  end;
  RichEdit.AfterSave;
  //RichEdit.Modified:=False;
end;

{ ------------------------------------------------------------------------- }

function StreamSave(dwCookie: Longint; pbBuff: PByte; cb: Longint; var pcb: Longint): Longint; stdcall;
var
  StreamInfo: PLMDRichEditStreamInfo;
begin
  Result:= NoError;
  StreamInfo:= PLMDRichEditStreamInfo(Pointer(dwCookie));
  try
    pcb:= 0;
    if StreamInfo^.Converter <> nil then
      pcb:= StreamInfo^.Converter.ConvertWriteStream(StreamInfo^.Stream,
        PAnsiChar(pbBuff), cb);
  except
    Result:= WriteError;
  end;
end;

{ ------------------------------------------------------------------------- }

procedure TRichEditStrings.SaveToStream(Stream: TStream);
var
  EditStream: TEditStream;
  TextType: Longint;
  StreamInfo: TLMDRichEditStreamInfo;
  Converter: TLMDConversion;

begin
  RichEdit.BeforeSave(Stream);

  if FConverter <> nil then
    Converter:= FConverter
  else
    Converter:= RichEdit.DefaultConverter.Create;
  StreamInfo.Stream:= Stream;
  StreamInfo.Converter:= Converter;

  try
    with EditStream do
      begin
        dwCookie:= TLMDPtrInt(Pointer(@StreamInfo));
        pfnCallBack:= @StreamSave;
        dwError:= 0;
      end;
    if PlainText then
      TextType:= SF_TEXT
    else
      TextType:= SF_RTF;
    SendMessage(RichEdit.Handle, EM_STREAMOUT, TextType, TLMDPtrInt(@EditStream));
    if EditStream.dwError <> 0 then
      raise EOutOfResources.Create(sRichEditSaveFail);
  finally
    if FConverter = nil then Converter.Free;
  end;

  RichEdit.AfterSave;
end;

{ ******************************* protected  ****************************** }
{ ------------------------------------------------------------------------- }

function TRichEditStrings.Get(Index: Integer): string;
var

  Text: array[0..4095] of Char;

  L: Integer;
begin

  Word((@Text)^):= Length(Text);
  L:= SendMessage(RichEdit.Handle, EM_GETLINE, Index, TLMDPtrInt(@Text));
  if (L >= 2) and (Text[L - 2] = #13) and (Text[L - 1] = #10) then
    Dec(L, 2)
  else
  if (L >= 1) and (Text[L - 1] = #13) then
    Dec(L, 1);
  SetString(Result, Text, L);

end;

{ ------------------------------------------------------------------------- }

function TRichEditStrings.GetCount: Integer;
begin
  Result:= SendMessage(RichEdit.Handle, EM_GETLINECOUNT, 0, 0);
  if SendMessage(RichEdit.Handle, EM_LINELENGTH, SendMessage(RichEdit.Handle,
    EM_LINEINDEX, Result - 1, 0), 0) = 0 then Dec(Result);
end;

{ ------------------------------------------------------------------------- }

procedure TRichEditStrings.Put(Index: Integer; const S: string);
var
  Selection: TCharRange;
begin
  if Index >= 0 then
    begin
      Selection.cpMin:= SendMessage(RichEdit.Handle, EM_LINEINDEX, Index, 0);
      if Selection.cpMin <> -1 then
        begin
          Selection.cpMax:= Selection.cpMin +
            SendMessage(RichEdit.Handle, EM_LINELENGTH, Selection.cpMin, 0);
        SendMessage(RichEdit.Handle, EM_EXSETSEL, 0, TLMDPtrInt(@Selection));
          SendMessage(RichEdit.Handle, EM_REPLACESEL, 0, TLMDPtrInt(PChar(S)));
        end;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TRichEditStrings.SetUpdateState(Updating: Boolean);
begin
  if RichEdit.Showing then
    SendMessage(RichEdit.Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then
    begin
      RichEdit.Refresh;
      RichEdit.Perform(CM_TEXTCHANGED, 0, 0);
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TRichEditStrings.SetTextStr(const Value: string);
begin
  EnableChange(False);
  try
    inherited SetTextStr(Value);
  finally
    EnableChange(True);
  end;
end;

{ ********************************* private  ****************************** }
{ ------------------------------------------------------------------------- }
procedure TRichEditStrings.EnableChange(const Value: Boolean);
var
  EventMask: Longint;
begin
  with RichEdit do
    begin
      if Value then
        EventMask:= SendMessage(Handle, EM_GETEVENTMASK, 0, 0) or ENM_CHANGE
      else
        EventMask:= SendMessage(Handle, EM_GETEVENTMASK, 0, 0) and not
          ENM_CHANGE;
      SendMessage(Handle, EM_SETEVENTMASK, 0, EventMask);
    end;
end;

{ ********************** TLMDBaseCustomRichEdit ****************************** }
{ ---------------------------------------------------------------------------- }
function TLMDBaseCustomRichEdit.FindText(const SearchStr: string; StartPos, Length: Integer; Options: TLMDSearchTypes=[stSearchDown]): Integer;
begin
  result:=DoFindText(SearchStr, StartPos, Length, Options);
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseCustomRichEdit.ReplaceText(const SearchStr: string; const ReplaceStr:string; StartPos, Len: Integer; Options: TLMDSearchTypes=[stSearchDown]): Integer;
begin
  result:=DoReplaceText(SearchStr, ReplaceStr,StartPos, Len, Options);
end;

{ **************************** TLMDRichEdit ********************************** }
{ ---------------------------------------------------------------------------- }
constructor TLMDCustomRichEdit.Create(AOwner: TComponent);
{
  procedure MakeMenuItem(ActCls: TBasicActionClass);
  var
    mi: TMenuItem;
  begin
    mi:= TMenuItem.Create(FDefaultPopup);
    mi.Action:= ActCls.Create(FDefaultPopup);
    FDefaultPopup.Items.Add(mi);
  end;
}
//var
//  DC: HDC;
//  mi: TMenuItem;

begin
  inherited Create(AOwner);
  inherited WantTabs:=True;
  inherited WantReturns:=True;
  FProtectLinks := true;
  FCombos := nil;//TList.Create;
  FMeasurement := unPoints;
  FSelAttributes := TLMDTextAttributes.Create(Self, atSelected);
  FDefAttributes := TLMDTextAttributes.Create(Self, atDefaultText);
  FWordAttributes := TLMDTextAttributes.Create(Self, atWord);
  FParagraph := TLMDParaAttributes.Create(Self);
  FRichEditStrings := TRichEditStrings.Create;
  TRichEditStrings(FRichEditStrings).RichEdit:= Self;
  FLangOptions := [rlAutoFont];
  FUndoLimit := 100;
  FZoom := 0;
  TabStop := True;
  Width := 185;
  Height := 89;
  AutoSize := False;
  DoubleBuffered := False;
  {$IFDEF LMDCOMP12}
  ParentDoubleBuffered := False;
  {$ENDIF}
  FHideSelection := True;
  HideScrollBars := True;
  FOldParaAlignment := Alignment;
  Perform(CM_PARENTBIDIMODECHANGED, 0, 0);
  FRichEditMode := edModeAppOnly;
  FPrinterPageWidth := 672;
  FRuler := nil;
  DefaultConverter := TLMDConversion;
  FPageMargins := TLMDRichPageMargins.Create;
  FTempMargins := TLMDRichPageMargins.Create;
  FPageMargins.OnChange := ChangeMargins;
  FPageMargins.Units := Measurement;
  FPageRect := TLMDRichPageMargins.Create;
  FPageRect.Units := Measurement;

  FShowRuler:= false;

  FAutoURLDetect:= false;
  FCallback := TLMDRichEditOleCallback.Create(Self);
  FCallbackIntf := FCallback as IRichEditOleCallback;
  FRichStorage := nil;
  FRichStorageItem := -1;
  FStorageLink := TLMDRTFChangeLink.Create;
  FStorageLink.OnChange := StorageDataChanged;

  FAllowObjects := True;
  FAllowInplace := true;
  FAutoVerbMenu := True;
  FAcceptDropFiles := true;
  FDefaultPopupURL := nil;
  FDefaultPopup := nil;
  FDefaultProtect := False;

  FShowDefaultPopup := true;
  FPopupVerbMenu := nil;

  inherited WordWrap := True; //false;

  FForcedChange := False;
  FOldSel.cpMin := 0;
  FOldSel.cpMax := 0;
  FRecreateInProcess := False;
  FOnVScroll := nil;

  {$IFDEF LMDCOMP7} //compilability only vb apr 2009
  if NewStyleControls then
    ControlStyle := ControlStyle + [csNeedsBorderPaint]
  else
    ControlStyle := ControlStyle + [csFramed];
  {$ENDIF}
end;

{ ------------------------------------------------------------------------- }

destructor TLMDCustomRichEdit.Destroy;
begin
  FPopupVerbMenu.Free;
  FCallbackIntf := nil;
  FCallback := nil; // freed, when FCallbackIntf:= nil called!
//  FCombos.Clear;
  FreeAndNil(FCombos);
  FreeAndNil(FDefaultPopupURL);
  FreeAndNil(FDefaultPopup);
  FreeAndNil(FStorageLink);
  FreeAndNil(FSelAttributes);
  FreeAndNil(FDefAttributes);
  FreeAndNil(FWordAttributes);
  FreeAndNil(FParagraph);
  FreeAndNil(FRichEditStrings);
  FreeAndNil(FMemStream);
  FreeAndNil(FPageMargins);
  FreeAndNil(FTempMargins);
  FreeAndNil(FPageRect);
  FreeAndNil(FRuler);

  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDCustomRichEdit.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_RTF;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.Clear;
var
  V: Boolean;
begin
  V := FDefaultProtect;
  try
    FDefaultProtect := True;
    CloseObjects;
    inherited Clear;
    Modified := False;
  finally
    FDefaultProtect := V;
  end;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.GetTextLengthHelper(Struct: TGetTextLengthEx): Integer;

begin

  Result := Perform(EM_GETTEXTLENGTHEX, WParam(@Struct), 0)

end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.Print(const Caption: string);
var
  Range: TFormatRange;
  LastChar, MaxLen, LogX, LogY, OldMap: Integer;
  SaveRect: TRect;
  TextLenEx: TGetTextLengthEx;
  U: TLMDMeasurement;
begin
  U:= Measurement;
  Measurement:= unPoints;

  FillChar(Range, SizeOf(Range), 0);

  with Printer, Range do
    begin
      if  Caption = ''  then
        Title:= ExtractFileName(self.Title)
      else
        Title:= Caption;
      BeginDoc;
      hdc:= Handle;
      hdcTarget:= hdc;
      LogX:= GetDeviceCaps(Handle, LOGPIXELSX);
      LogY:= GetDeviceCaps(Handle, LOGPIXELSY);

      if (PageRect.Bottom <= PageRect.Top) and
         (PageRect.Right <= PageRect.Left) and
         (PageMargins.Top = 0) and (PageMargins.Bottom = 0) and
         (PageMargins.Left = 0) and (PageMargins.Right = 0) then
      begin
        rc.right:= MulDiv(Printer.PageWidth, LMDTwipsPerInch, LogX);
        rc.bottom:= MulDiv(Printer.PageHeight, LMDTwipsPerInch, LogY);
      end
      else
      begin
        rc.left:= Round(PageRect.Left * LMDTwipsPerInch / LogX) +
                  Round(PageMargins.Left * TwipsPerPoints);
        rc.top:= Round(PageRect.Top * LMDTwipsPerInch / LogY) +
                 Round(PageMargins.Top * TwipsPerPoints);
        if PageRect.Right = 0 then
          rc.right:= Round(Printer.PageWidth * LMDTwipsPerInch / LogX) -
                     Round(PageMargins.Right * TwipsPerPoints)
        else
          rc.right:= Round(PageRect.Right * LMDTwipsPerInch / LogX) -
                     Round(PageMargins.Right * TwipsPerPoints);
        if PageRect.Bottom = 0 then
          rc.bottom:= Round(Printer.PageHeight * LMDTwipsPerInch / LogY) -
                      Round(PageMargins.Bottom * TwipsPerPoints)
        else
          rc.bottom:= Round(PageRect.Bottom * LMDTwipsPerInch / LogY) -
                      Round(PageMargins.Bottom * TwipsPerPoints);
      end;

      rcPage:= rc;
      SaveRect:= rc;
      LastChar:= 0;
      if Version >= 2 then
      begin
        with TextLenEx do
          begin
            flags:= GTL_DEFAULT;
            codepage:= CP_ACP;
          end;
        MaxLen := GetTextLengthHelper(TextLenEx);
      end
      else
        MaxLen:= GetTextLen;
      chrg.cpMax:= -1;
    { ensure printer DC is in text map mode }
      OldMap:= SetMapMode(hdc, MM_TEXT);
      SendMessage(Self.Handle, EM_FORMATRANGE, 0, 0); { flush buffer }
      try
        repeat
          rc:= SaveRect;
          chrg.cpMin:= LastChar;
        LastChar:= SendMessage(Self.Handle, EM_FORMATRANGE, 1,
            TLMDPtrInt(@Range));
        if (LastChar < MaxLen) and (LastChar <> -1) then NewPage;
        until (LastChar >= MaxLen) or (LastChar = -1);
        EndDoc;
      finally
        SendMessage(Self.Handle, EM_FORMATRANGE, 0, 0); { flush buffer }
        SetMapMode(hdc, OldMap); { restore previous map mode }
        Measurement:= U;
      end;
    end;
end;

{ ------------------------------------------------------------------------- }

function  PixelsToTwips(Val, LogZ: integer): integer;
begin
  if  Val = 0   then
    Result := 0
  else
    Result := MulDiv(Val, LMDTwipsPerInch, LogZ);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.Render(BMP: TBitmap; var LastChar: Integer);
var
  Range: TFormatRange;
  LogX, LogY: Integer;
  TextLenEx: TGetTextLengthEx;
  MaxLen: LongInt;
begin
  SendMessage(Handle, EM_FORMATRANGE, 0, 0); { flush buffer }
  LogX := GetDeviceCaps(BMP.Canvas.Handle, LOGPIXELSX);
  LogY := GetDeviceCaps(BMP.Canvas.Handle, LOGPIXELSY);

  FillChar(Range, SizeOf(Range), 0);

  // Set up the page (convert Pixels to twips)
  Range.rcPage.Top    := 0;//PixelsToTwips(Rect.Top, LogY);
  Range.rcPage.Left   := 0;//PixelsToTwips(Rect.Left, LogX);
  Range.rcPage.Right  := PixelsToTwips(BMP.Width, LogX);
  Range.rcPage.Bottom := PixelsToTwips(BMP.Height, LogY);

  // Set up no margins all around.
  Range.rc := Range.rcPage;
  // Set up the range of text to print as nStart to end of document
  Range.chrg.cpMin := LastChar;
  Range.chrg.cpMax := -1;
  Range.hdc := BMP.Canvas.Handle;
  Range.hdcTarget := Range.hdc;

  try
    LastChar := SendMessage(Handle, EM_FORMATRANGE, Ord(TRUE), TLMDPtrInt(@Range));
    SendMessage(Handle, EM_DISPLAYBAND, 0, TLMDPtrInt(@Range.rc));
    if Version >= 2 then
      begin
        with TextLenEx do
          begin
            flags:= GTL_DEFAULT;
            codepage:= CP_ACP;
          end;
        MaxLen := GetTextLengthHelper(TextLenEx);
      end
    else
      MaxLen:= GetTextLen;

    if LastChar >= MaxLen then
      LastChar:= -1;
  finally
    Range.hdc := BMP.Canvas.Handle;
    Range.hdcTarget := Range.hdc;
    SendMessage(Handle, EM_FORMATRANGE, 0, 0); { flush buffer }
  end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.Render(BMP: TBitmap; Wd, Hg, MaxWidth, MaxHeight: integer;
  VSB_Width, HSB_Height: integer; var LastChar: Integer; Smoothing: TLMDSmoothingType);
var
  Range: TFormatRange;
  LogX, LogY: Integer;
  PH, PW, L: LongInt;
//  DC: HDC;
  TextLenEx: TGetTextLengthEx;
  MaxLen: LongInt;
  PF: TPixelFormat;
  isFONTSMOOTHING, FS_Changed: LongBool;
begin
  if  (Wd < 5) or (Hg < 5)  then
  begin
    LastChar := -1;
    BMP.Assign(nil);
    Exit;
  end;

  SendMessage(Handle, EM_FORMATRANGE, 0, 0); { flush buffer }
//  DC := GetDC(0);
  LogX := GetDeviceCaps(BMP.Canvas.Handle, LOGPIXELSX);
  LogY := GetDeviceCaps(BMP.Canvas.Handle, LOGPIXELSY);
//  ReleaseDC(0, DC);

  FillChar(Range, SizeOf(Range), 0);

  // Set up the page (convert Pixels to twips)
  Range.rcPage.Top    := 0;//PixelsToTwips(Rect.Top, LogY);
  Range.rcPage.Left   := 0;//PixelsToTwips(Rect.Left, LogX);
  if  WordWrap  then
    Range.rcPage.Right  := PixelsToTwips(Wd, LogX)
  else
    Range.rcPage.Right  := 100000000;

  Range.rcPage.Bottom := PixelsToTwips(MaxHeight, LogY);

 // Set up no margins all around.
  Range.rc := Range.rcPage;
  // Set up the range of text to print as nStart to end of document
  Range.chrg.cpMin := LastChar;
  Range.chrg.cpMax := -1;
  Range.hdc := BMP.Canvas.Handle;
  Range.hdcTarget := Range.hdc;
  // Estimate bounds

  L := SendMessage(Handle, EM_FORMATRANGE, 0, TLMDPtrInt(@Range));

  FS_Changed := False;

  if  L = 0  then
  begin
    LastChar := -1;
    BMP.Assign(nil);
    Exit;
  end;

  try
    PW := LMDTwipsToPixels(Range.rc.Right, LogX);
    PH := LMDTwipsToPixels(Range.rc.Bottom, LogY);

    if  PW > MaxWidth then
      PW := maxWidth;

    if  PH > MaxHeight  then
      PH := MaxHeight;

    if  (VSB_Width > 0) or (HSB_Height > 0) then
    begin
      if  (PW > Wd) and (HSB_Height > 0)  then
        Hg := Hg - HSB_Height;

      if  (PW <= Wd) and (PH > Hg) and (VSB_Width > 0)  then
      begin
        PW := Wd - VSB_Width;
        Range.rcPage.Right := PixelsToTwips(PW, LogX);
        Range.rc := Range.rcPage;
        Range.hdc := BMP.Canvas.Handle;
        Range.hdcTarget := Range.hdc;
        SendMessage(Handle, EM_FORMATRANGE, 0, TLMDPtrInt(@Range));
        PH := LMDTwipsToPixels(Range.rc.Bottom, LogY);
      end;
    end;

    PF := BMP.PixelFormat;
    BMP.Assign(nil);
    BMP.PixelFormat := PF;
    BMP.Width := PW;
    BMP.Height := PH;
    Range.hdc := BMP.Canvas.Handle;
    Range.hdcTarget := Range.hdc;
    Range.rcPage.Right  := PixelsToTwips(PW, LogX);
    Range.rcPage.Bottom := PixelsToTwips(PH, LogY);
    Range.rc := Range.rcPage;

    if  Smoothing <> stSystem then
    begin
      SystemParametersInfo(SPI_GETFONTSMOOTHING, 0, @isFONTSMOOTHING, 0);
      FS_Changed := ((Smoothing = stActive) and not isFONTSMOOTHING)
            or ((Smoothing = stInactive) and isFONTSMOOTHING);

      if  FS_Changed  then
        if  Smoothing = stActive then
          SystemParametersInfo(SPI_SETFONTSMOOTHING, 1, nil, 0)
        else
          SystemParametersInfo(SPI_SETFONTSMOOTHING, 0, nil, 0);
    end;

    LastChar := SendMessage(Handle, EM_FORMATRANGE, Ord(TRUE), TLMDPtrInt(@Range));
      SendMessage(Handle, EM_DISPLAYBAND, 0, TLMDPtrInt(@Range.rc));
    if Version >= 2 then
    begin
      with TextLenEx do
      begin
        flags:= GTL_DEFAULT;
        codepage:= CP_ACP;
      end;
      MaxLen := GetTextLengthHelper(TextLenEx);
    end
    else
      MaxLen:= GetTextLen;

    if LastChar >= MaxLen then
      LastChar:= -1;

  finally
    Range.hdc := BMP.Canvas.Handle;
    Range.hdcTarget := Range.hdc;
    SendMessage(Handle, EM_FORMATRANGE, 0, 0); { flush buffer }

    if  FS_Changed  then
      SystemParametersInfo(SPI_SETFONTSMOOTHING, integer(isFONTSMOOTHING), nil, 0);
  end;
end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.Preview(PrintTo: TCanvas; Render: Boolean; var LastChar: Integer): TRect;
var
  Range: TFormatRange;
  R: TRect;
  LogX, LogY: Integer;
  MaxLen: LongInt;
  TextLenEx: TGetTextLengthEx;
  U: TLMDMeasurement;
  PH, PW: LongInt;
begin
//Result := Render(PrintTo, Render, LastChar); exit;
  U:= Measurement;
  Measurement:= unPoints;
  SendMessage(Handle, EM_FORMATRANGE, 0, 0); { flush buffer }

  FillChar(Range, SizeOf(TFormatRange), 0);

  Range.hdc:= PrintTo.Handle;
  if (Printer.Printers.Count <= 0) or (Printer.PrinterIndex = -1) or not LMDRichIsPrinterValid then
    begin
      PW:= 4676;
      PH:= 6744;
      Range.hdcTarget:= PrintTo.Handle;
    end
  else
    begin
      PH:= Printer.PageHeight;
      PW:= Printer.PageWidth;
      Range.hdcTarget:= Printer.Handle;
    end;

  LogX:= GetDeviceCaps(Range.hdcTarget, LOGPIXELSX);
  LogY:= GetDeviceCaps(Range.hdcTarget, LOGPIXELSY);

  if (PageRect.Top = 0) and (PageRect.Bottom = 0) and
     (PageRect.Left = 0) and (PageRect.Right = 0) and
     (PageMargins.Top = 0) and (PageMargins.Bottom = 0) and
     (PageMargins.Left = 0) and (PageMargins.Right = 0) then
    begin
      Range.rcPage.right:= MulDiv(PW, LMDTwipsPerInch, LogX);
      Range.rcPage.bottom:= MulDiv(PH, LMDTwipsPerInch, LogY);
    end
  else
    begin
      Range.rcPage.left:= Round((PageRect.Left + PageMargins.Left) * TwipsPerPoints)
        { * 1440 div LogX};
      Range.rcPage.top:= Round((PageRect.Top + PageMargins.Top) * TwipsPerPoints)
        {* 1440 div LogY};
      if PageRect.Right = 0 then
        Range.rcPage.right:= Round((PW * LMDTwipsPerInch/ LogX -
          PageMargins.Right * TwipsPerPoints)) {* 1440 div LogX}
      else
        Range.rcPage.right:= Round((PageRect.Right - PageMargins.Right) * TwipsPerPoints)
          {* 1440 div LogX};
      if PageRect.Bottom = 0 then
        Range.rcPage.bottom:= Round((PH * LMDTwipsPerInch / LogY -
          PageMargins.Bottom * TwipsPerPoints)) {* 1440 div LogY}
      else
        Range.rcPage.bottom:= Round((PageRect.Bottom - PageMargins.Bottom) * TwipsPerPoints)
          {* 1440 div LogY}
    end;
//  Range.rcPage:= Range.rc;

  Range.rc:= Range.rcPage;
  Range.chrg.cpMax:= -1;

  try
    if Version >= 2 then
      begin
        with TextLenEx do
          begin
            flags:= GTL_DEFAULT;
            codepage:= CP_ACP;
          end;
      MaxLen:= Perform(EM_GETTEXTLENGTHEX, WParam(@TextLenEx), 0);
      end
    else
      MaxLen:= GetTextLen;
    Range.chrg.cpMin:= LastChar;
    R:= Range.rcPage;
  LastChar:= SendMessage(Self.Handle, EM_FORMATRANGE, Ord(Render),
      TLMDPtrInt(@Range));
  if LastChar >= MaxLen then LastChar:= -1;
  SendMessage(Handle, EM_DISPLAYBAND, 0, TLMDPtrInt(@R));
  //    LogX:= GetDeviceCaps(PrintTo.Handle, LOGPIXELSX);
//    LogY:= GetDeviceCaps(PrintTo.Handle, LOGPIXELSY);
  Result:= Classes.Rect(Range.rc.Left div TwipsPerPoints,
                          Range.rc.Top div TwipsPerPoints,
                          Range.rc.right div TwipsPerPoints,
                          Range.rc.Bottom div TwipsPerPoints);
  {Classes.Rect(
      MulDiv( Range.rc.Left, LogX, 1440 72),
      MulDiv( Range.rc.Top, LogY, 1440 72),
      MulDiv( Range.rc.Right, LogX, 1440 72),
      MulDiv( Range.rc.Bottom, LogY, 1440 72));}
  finally
    SendMessage(Handle, EM_FORMATRANGE, 0, 0); { flush buffer }
    Measurement:= U;
  end;
//  end;
end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.GetTextRange(StartPos, EndPos: Longint): String;
var
  TextRange: {$ifdef LMDCOMP12}TTextRangeW{$else}TTextRangeA{$ENDIF};
  begin
  Result := '';
  if  (EndPos = -1) and (StartPos = 0)  then
    Result := String(Text)
  else
  if (StartPos >= 0) and (StartPos < EndPos) then
    begin
      TextRange.chrg.cpMin:= StartPos;
      TextRange.chrg.cpMax:= EndPos;
    SetLength(Result, EndPos - StartPos);
      TextRange.lpstrText:= PChar(Result);
      SetLength(Result, SendMessage(Handle, EM_GETTEXTRANGE, 0, TLMDPtrInt(@TextRange)));
    end
  else
    Result := '';
end;

function TLMDCustomRichEdit.GetThemedBkColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleColor(scEdit)
  else
  {$ENDIF}
    Result := Self.Color;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.GetSelTextBuf(Buffer: PChar; BufSize: Integer):Integer;
var
  S: string;
begin
  S:= GetSelText;
  Result:= Length(S);
  if BufSize < Length(S) then Result:= BufSize;
  StrPLCopy(Buffer, S, Result);
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.InformCombos;
var
  i:Integer;
begin
  if (csLoading in ComponentState) or (csDesigning in ComponentState) then exit;
  if  Assigned(FCombos) then
    for i:=0 to FCombos.Count-1 do
      if TLMDRichCustomComboBox(FCombos[i]).HandleAllocated then
        TLMDRichCustomComboBox(FCombos[i]).UpdateInfo;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.SetUIActive(Active: Boolean);
var
  Form: TCustomForm;
begin
  try
    Form:= GetParentForm(Self);
    if Form <> nil then
      if Active then
        begin
          if (Form.ActiveOleControl <> nil) and
            (Form.ActiveOleControl <> Self) then
            Form.ActiveOleControl.Perform(CM_UIDEACTIVATE, 0, 0);
          Form.ActiveOleControl:= Self;
          if AllowInPlace and CanFocus then SetFocus;
        end
      else
        begin
          if Form.ActiveOleControl = Self then Form.ActiveOleControl:= nil;
          if (Form.ActiveControl = Self) and AllowInPlace then
            begin
              Windows.SetFocus(Handle);
              SelectionChange;
            end;
        end;
  except
    Application.HandleException(Self);
  end;
end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.FindTextExt(const SearchStr: string; StartPos, Length: Integer; Options: TLMDSearchTypes): Integer;
begin
  result:=DoFindText(SearchStr, StartPos, Length, Options);
end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.DoFindText(const SearchStr: string; StartPos, Length: Integer; Options: TLMDSearchTypes): Integer;
var
  Find: TFindText;
  Flags: Integer;
const
  FR_DOWN = $00000001;
begin
  with Find.chrg do
    begin
      cpMin:= StartPos;
      if RichEditVer=1 then
        cpMax:= cpMin + Length
      else
        if stSearchDown in Options then
          cpMax:= cpMin + Length
        else
          begin
            cpMax:= cpMin - Length;
            if cpMax<0 then cpMax:=0;
          end;
    end;
  Flags:= 0;
  if stWholeWord in Options then Flags:= Flags or FT_WHOLEWORD;
  if stMatchCase in Options then Flags:= Flags or FT_MATCHCASE;
  if stSearchDown in Options then Flags:= Flags or FR_DOWN;

  Find.lpstrText:= PChar(SearchStr);
  Result:= SendMessage(Handle, EM_FINDTEXT, Flags, TLMDPtrInt(@Find));

end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomRichEdit.DoReplaceText(const SearchStr: string; const ReplaceStr:string; StartPos, Len: Integer; Options: TLMDSearchTypes): Integer;
begin
  Result := DoFindText(SearchStr, StartPos, Len, Options);
  if result < 0 then exit;
  // perform replace
  SelStart := result;
  SelLength := Length(SearchStr);
  SelText := ReplaceStr;
  SelStart := Result + Length(ReplaceStr);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomRichEdit.ReplaceTextExt(const SearchStr, ReplaceStr: string; StartPos, Len: Integer; Options: TLMDSearchTypes): Integer;
begin
  result:=DoReplaceText(SearchStr, ReplaceStr, StartPos, Len, Options);
end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.InsertObjectDialog: Boolean;

var
  {$IFDEF LMDCOMP12} //ToDo: VB
  Data: TOleUIInsertObjectA;
  NameBuffer: array[0..255] of AnsiChar;
  {$ELSE}
  Data: TOleUIInsertObject;
  NameBuffer: array[0..255] of Char;
  {$ENDIF}
  OleClientSite: IOleClientSite;
  Storage: IStorage;
  OleObject: IOleObject;
  ReObject: TReObject;
  IsNewObject: Boolean;
  Selection: TCharRange;

begin
  Result := False;

  if ReadOnly then Exit;

  FillChar(Data, SizeOf(Data), 0);
  FillChar(NameBuffer, SizeOf(NameBuffer), 0);
  FillChar(ReObject, SizeOf(TReObject), 0);
  if Assigned(FRichEditOle) then
    begin
      IRichEditOle(FRichEditOle).GetClientSite(OleClientSite);
      Storage:= nil;
      try
        CreateStorage(Storage);
        with Data do
          begin
            cbStruct:= SizeOf(Data);
            dwFlags:= IOF_SELECTCREATENEW or IOF_VERIFYSERVERSEXIST or
              IOF_CREATENEWOBJECT or IOF_CREATEFILEOBJECT or
              IOF_CREATELINKOBJECT;
            hWndOwner:= GetDlgParentHandle;
            lpszFile:= NameBuffer;
            cchFile:= SizeOf(NameBuffer);
            iid:= IOleObject;
            oleRender:= OLERENDER_DRAW;
            lpIOleClientSite:= OleClientSite;
            lpIStorage:= Storage;
            ppvObj:= @OleObject;
          end;
        try
          Result := {$IFDEF LMDCOMP12}OleUIInsertObjectA{$ELSE}OleUIInsertObject{$ENDIF}(Data) = OLEUI_OK;
          if Result then
          try
            IsNewObject:= Data.dwFlags and IOF_SELECTCREATENEW =
              IOF_SELECTCREATENEW;
            with ReObject do
              begin
                cbStruct:= SizeOf(TReObject);
                cp:= REO_CP_SELECTION;
                clsid:= Data.clsid;
                poleobj:= OleObject;
                pstg:= Storage;
                polesite:= OleClientSite;
                dvAspect:= DVASPECT_CONTENT;
                dwFlags:= REO_RESIZABLE;
                if IsNewObject then dwFlags:= dwFlags or REO_BLANK;
                OleCheck(OleSetDrawAspect(OleObject,
                  Data.dwFlags and IOF_CHECKDISPLAYASICON <> 0,
                  Data.hMetaPict, dvAspect));
              end;
            SendMessage(Handle, EM_EXGETSEL, 0, TLMDPtrInt(@Selection));
            Selection.cpMax:= Selection.cpMin + 1;
            OleCheck(IRichEditOle(FRichEditOle).InsertObject(ReObject));
            SendMessage(Handle, EM_EXSETSEL, 0, TLMDPtrInt(@Selection));
            SendMessage(Handle, EM_SCROLLCARET, 0, 0);
            IRichEditOle(FRichEditOle).SetDvaspect(
              Longint(REO_IOB_SELECTION), ReObject.dvAspect);
            if IsNewObject then
              OleObject.DoVerb(OLEIVERB_SHOW, nil,
                OleClientSite, 0, Handle, ClientRect);
          finally
            OleObject:= nil;
          end;
        finally
          DestroyMetaPict(Data.hMetaPict);
        end;
      finally
        OleClientSite:= nil;
        Storage:= nil;
      end;
    end;
 // ToDo
end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.ObjectPropertiesDialog: Boolean;

var
  ObjectProps: TOleUIObjectProps;
  PropSheet: TPropSheetHeader;
  GeneralProps: TOleUIGnrlProps;
  ViewProps: TOleUIViewProps;
  LinkProps: TOleUILinkProps;
  DialogCaption: string;
  ReObject: TReObject;
 // ToDo
begin
  Result:= False;

  if not Assigned(FRichEditOle) or (SelectionType <> [stObject]) then Exit;
  FillChar(ObjectProps, SizeOf(ObjectProps), 0);
  FillChar(PropSheet, SizeOf(PropSheet), 0);
  FillChar(GeneralProps, SizeOf(GeneralProps), 0);
  FillChar(ViewProps, SizeOf(ViewProps), 0);
  FillChar(LinkProps, SizeOf(LinkProps), 0);
  FillChar(ReObject, SizeOf(ReObject), 0);
  ReObject.cbStruct:= SizeOf(ReObject);
  if Succeeded(IRichEditOle(FRichEditOle).GetObject(Longint(REO_IOB_SELECTION),
    ReObject, REO_GETOBJ_POLEOBJ or REO_GETOBJ_POLESITE)) then
    if ReObject.dwFlags and REO_INPLACEACTIVE = 0 then
      begin
        ObjectProps.cbStruct:= SizeOf(ObjectProps);
        ObjectProps.dwFlags:= OPF_DISABLECONVERT;
        ObjectProps.lpPS:= @PropSheet;
        ObjectProps.lpObjInfo:= TOleUIObjInfo.Create(Self, ReObject);
        if (ReObject.dwFlags and REO_LINK) <> 0 then
          begin
            ObjectProps.dwFlags:= ObjectProps.dwFlags or OPF_OBJECTISLINK;
          { ToDo
            ObjectProps.lpLinkInfo:= TOleUILinkInfo.Create(Self, ReObject);
          }
          end;
        ObjectProps.lpGP:= @GeneralProps;
        ObjectProps.lpVP:= @ViewProps;
        ObjectProps.lpLP:= @LinkProps;
        PropSheet.dwSize:= SizeOf(PropSheet);
        PropSheet.hWndParent:= GetDlgParentHandle;
        PropSheet.hInstance:= MainInstance;
        DialogCaption:= Format(SPropDlgCaption,
          [GetFullNameStr(ReObject.poleobj)]);
        PropSheet.pszCaption:= PChar(DialogCaption);
        GeneralProps.cbStruct:= SizeOf(GeneralProps);
        ViewProps.cbStruct:= SizeOf(ViewProps);
        ViewProps.dwFlags:= VPF_DISABLESCALE;
        LinkProps.cbStruct:= SizeOf(LinkProps);
        LinkProps.dwFlags:= ELF_DISABLECANCELLINK;
        Result:= OleUIObjectProperties(ObjectProps) = OLEUI_OK;
      end;
 // ToDo
end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.PasteSpecialDialog: Boolean;

  procedure SetPasteEntry(var Entry: TOleUIPasteEntry; Format: TClipFormat;
    tymed: DWORD; const FormatName, ResultText: String; Flags: DWORD);
  begin
    with Entry do
      begin
        fmtetc.cfFormat:= Format;
        fmtetc.dwAspect:= DVASPECT_CONTENT;
        fmtetc.lIndex:= -1;
        fmtetc.tymed:= tymed;
        if FormatName <> '' then
          lpstrFormatName:= PChar(FormatName)
        else
          lpstrFormatName:= '%s';
        if ResultText <> '' then
          lpstrResultText:= PChar(ResultText)
        else
          lpstrResultText:= '%s';
        dwFlags:= Flags;
      end;
  end;

const
  PasteFormatCount = 6;

var
  Data: TOleUIPasteSpecial;
  PasteFormats: array[0..PasteFormatCount - 1] of TOleUIPasteEntry;
  Format: Integer;
  OleClientSite: IOleClientSite;
  Storage: IStorage;
  OleObject: IOleObject;
  ReObject: TReObject;
  Selection: TCharRange;
 // ToDo
begin
  Result:= False;

  if not CanPaste or not Assigned(FRichEditOle) then Exit;
  FillChar(Data, SizeOf(Data), 0);
  FillChar(PasteFormats, SizeOf(PasteFormats), 0);
  with Data do
    begin
      cbStruct:= SizeOf(Data);
      hWndOwner:= GetDlgParentHandle;
      arrPasteEntries:= @PasteFormats;
      cPasteEntries:= PasteFormatCount;
      arrLinkTypes:= @CFLinkSource;
      cLinkTypes:= 1;
      dwFlags:= PSF_SELECTPASTE;
    end;
  SetPasteEntry(PasteFormats[0], CFEmbeddedObject, TYMED_ISTORAGE, '', '',
    OLEUIPASTE_PASTE or OLEUIPASTE_ENABLEICON);
  SetPasteEntry(PasteFormats[1], CFLinkSource, TYMED_ISTREAM, '', '',
    OLEUIPASTE_LINKTYPE1 or OLEUIPASTE_ENABLEICON);
  SetPasteEntry(PasteFormats[2], CFRtf, TYMED_ISTORAGE,
    CF_RTF, CF_RTF, OLEUIPASTE_PASTE);
  SetPasteEntry(PasteFormats[3], CFRtfNoObjs, TYMED_ISTORAGE,
    CF_RTFNOOBJS, CF_RTFNOOBJS, OLEUIPASTE_PASTE);
  SetPasteEntry(PasteFormats[4], CF_TEXT, TYMED_HGLOBAL,
    'Unformatted text', 'text without any formatting', OLEUIPASTE_PASTE);
  SetPasteEntry(PasteFormats[5], CF_BITMAP, TYMED_GDI,
    'Windows Bitmap', 'bitmap image', OLEUIPASTE_PASTE);
  try
    if OleUIPasteSpecial(Data) = OLEUI_OK then
      begin
        Result:= True;
        if Data.nSelectedIndex in [0, 1] then
          begin
        { CFEmbeddedObject, CFLinkSource }
            FillChar(ReObject, SizeOf(TReObject), 0);
            IRichEditOle(FRichEditOle).GetClientSite(OleClientSite);
            Storage:= nil;
            try
              CreateStorage(Storage);
              case Data.nSelectedIndex of
                0:
                  OleCheck(OleCreateFromData(Data.lpSrcDataObj,
                    IOleObject,
                    OLERENDER_DRAW, nil, OleClientSite, Storage, OleObject));
                1:
                  OleCheck(OleCreateLinkFromData(Data.lpSrcDataObj,
                    IOleObject,
                    OLERENDER_DRAW, nil, OleClientSite, Storage, OleObject));
              end;
              try
                with ReObject do
                  begin
                    cbStruct:= SizeOf(TReObject);
                    cp:= REO_CP_SELECTION;
                    poleobj:= OleObject;
                    OleObject.GetUserClassID(clsid);
                    pstg:= Storage;
                    polesite:= OleClientSite;
                    dvAspect:= DVASPECT_CONTENT;
                    dwFlags:= REO_RESIZABLE;
                    OleCheck(OleSetDrawAspect(OleObject,
                      Data.dwFlags and PSF_CHECKDISPLAYASICON <> 0,
                      Data.hMetaPict, dvAspect));
                  end;
                SendMessage(Handle, EM_EXGETSEL, 0, TLMDPtrInt(@Selection));
                Selection.cpMax:= Selection.cpMin + 1;
                OleCheck(IRichEditOle(FRichEditOle).InsertObject(ReObject));
                SendMessage(Handle, EM_EXSETSEL, 0, TLMDPtrInt(@Selection));
                IRichEditOle(FRichEditOle).SetDvaspect(
                  Longint(REO_IOB_SELECTION), ReObject.dvAspect);
              finally
                OleObject:= nil;
              end;
            finally
              OleClientSite:= nil;
              Storage:= nil;
            end;
          end
        else
          begin
            Format:= PasteFormats[Data.nSelectedIndex].fmtetc.cfFormat;
            OleCheck(IRichEditOle(FRichEditOle).ImportDataObject(
              Data.lpSrcDataObj, Format, Data.hMetaPict));
          end;
        SendMessage(Handle, EM_SCROLLCARET, 0, 0);
      end;
  finally
    DestroyMetaPict(Data.hMetaPict);
    Data.lpSrcDataObj:= nil;
  end;

end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.PagePropertiesDialog: Boolean;
begin
  result:=false;
  with TLMDRichPageSetupDialog.Create(self) do
    begin
      try
        DlgPosition:=self.FDlgPosition;
        Units:=Measurement;
        Options:= [psoDefaultMinMargins];
        Margin.Assign(PageMargins);
        //PageWidth:=FPrinterPageWidth;
        if Execute then
          begin
            Result:=True;
            //FPrinterPageWidth := LMDToPixelsX(                         // vb April 2008
            //    PageWidth - Margin.Left - Margin.Right, Measurement);  // Moved to ChangeMargins
            PageMargins.Assign(Margin);
          end;
      finally
        Free;
      end;
    end;
end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.PreviewDialog: Boolean;
begin
  Result:= TLMDRichfrmPrintPreview.Execute(Self)
end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.InsertCharDialog:Boolean;
var
  dlg : TLMDRichCharmapDialog;
begin
  result:=false;
  dlg := TLMDRichCharmapDialog.Create(self);
  with dlg do
    try
      RichEditControl:=self;
      PrepareDialog(dlg);
      if Execute then
        begin
          result:=True;
          if Assigned(FOnDlgAfterShow) then
            FOnDlgAfterShow(dlg);
        end;
    finally
      dlg.Free;
    end;
end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.InsertDateTimeDialog: Boolean;
var
  InsertDateTimeDlg: TLMDRichInsertDateTimeDialog;
begin
  result:=false;
  InsertDateTimeDlg := TLMDRichInsertDateTimeDialog.Create(Owner);
  try
    InsertDateTimeDlg.RichEditControl:=self;
    PrepareDialog(InsertDateTimeDlg);
    if InsertDateTimeDlg.Execute then
      begin
        result:=True;
        if Assigned(FOnDlgAfterShow) then
          FOnDlgAfterShow(InsertDateTimeDlg);
      end;
  finally
    InsertDateTimeDlg.Free;
  end;
end;
{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.StatisticsDialog;
var
  dlg : TLMDRTFStatisticsDlg;
begin
  dlg := TLMDRTFStatisticsDlg.Create(GetParentForm(self));
//  Application);
  try
    PrepareDialog(dlg);
    dlg.ProcessEditor(Self);
    dlg.ShowModal;
  finally
    dlg.Free;
  end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.Redo;
begin
  SendMessage(Handle, EM_REDO, 0, 0);
end;

{ ------------------------------------------------------------------------- }
procedure AppendConversionFormat(const Ext: string; AClass: TLMDConversionClass);
var

  NewRec : PLMDConversionFormat;

begin

  New(NewRec);
  with NewRec^ do
    begin
      Extension:= AnsiLowerCaseFileName(Ext);
      ConversionClass:= AClass;
      Next := ConversionFormatList;
    end;
  ConversionFormatList := NewRec;

end;

{ ------------------------------------------------------------------------- }
class procedure TLMDCustomRichEdit.RegisterConversionFormat(const AExtension: string;
  AConversionClass: TLMDConversionClass);
begin
  AppendConversionFormat(AExtension, AConversionClass)
end;

{ ------------------------------------------------------------------------- }
{$ifdef LMDCOMP9}
procedure TLMDCustomRichEdit.InsertBitmap(aBitmap : TBitmap);
{$else}
procedure TLMDCustomRichEdit.InsertBitmap(aBitmap : Graphics.TBitmap);
{$endif}
begin
  if aBitmap = nil then Exit;
  if aBitmap.Empty or (aBitmap.Handle = 0) then Exit;
  with TLMDRTFImageDataObject.Create do
    InsertBitmap(IRichEditOle(FRichEditOle), aBitmap);
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.InsertGraphic(aGraphic: TGraphic);
var
  BMP: TBitmap;
begin
  if  Assigned(aGraphic) and not aGraphic.Empty then
    begin
      if  aGraphic is TBitmap then
        InsertBitmap(TBitmap(aGraphic))
      else
        begin
          BMP := TBitmap.Create;
          try
            BMP.Assign(aGraphic);
            InsertBitmap(BMP);
          finally
            BMP.Free;
          end;
        end;
    end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.RegisterCombo(aCombo: TLMDRichCustomComboBox);
begin
  if  not Assigned(FCombos) then
    FCombos := TList.Create;

  if FCombos.IndexOf(aCombo) < 0 then
    FCombos.Add(aCombo);
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.UnRegisterCombo(aCombo: TLMDRichCustomComboBox);
//var
//  tmp:integer;
begin
  if Assigned(FCombos)  then
    begin
      FCombos.Remove(aCombo);
      if  FCombos.Count = 0 then
        FreeAndNil(FCombos);
{
      tmp:=FCombos.IndexOf(aCombo);
      if tmp<>-1 then
        FCombos.Delete(tmp);
}
    end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.SaveToStreamAsHTML(aStream : TStream);
const
  BaseFontSize = 7;
var
  OldCurs       : TCursor;
  RichText      : TLMDRichEdit;
  tmpStream     : TStream;
  iDocument     : ITextDocument;
  iRange        : ITextRange;
  iSelection    : ITextSelection;
//  iPara         : ITextPara;
  iSubSelection : ITextSelection;
  iSubRange     : ITextRange;

  WasFont       : Boolean;
  IsBullet      : Boolean;
  IsNumber      : Boolean;

  FontName      : string;
  FontSize      : integer;
  FontColor     : TColor;
  FontStyle     : TFontStyles;

  procedure WriteChar(const aText : string);
  var
    LText: AnsiString;
  begin
    LMDConvertUTF16ToUTF8(aText, LText, strictConversion, False);
    aStream.WriteBuffer(PAnsiChar(LText)^, length(aText));
  end;

  procedure WriteOpenParagraph;
  begin
    WriteChar('<P>');
  end;

  procedure WriteCloseParagraph;
  begin
    WriteChar('</P>' + #13#10);
  end;

  function ColorToStr(aColor : TColor) : string;
  begin
    result := 'Black';
    case aColor of
      clAqua: result := 'Aqua';
      clBlack: result := 'Black';
      clBlue: result := 'Blue';
      clDkGray: result := 'Gray';
      clFuchsia: result := 'Fuchsia';
      clGreen: result := 'Green';
      clLime: result := 'Lime';
      clLtGray: result := 'Gray';
      clMaroon: result := 'Maroon';
      clNavy: result := 'Navy';
      clOlive: result := 'Olive';
      clPurple: result := 'Purple';
      clRed: result := 'Red';
      clTeal: result := 'Teal';
      clWhite: result := 'White';
      clYellow: result := 'Yellow';
    end;
  end;

  procedure SaveFontAttr(aFont : ITextFont);
  begin
    FontName := RichText.SelAttributes.Name;
    FontSize := RichText.SelAttributes.Size;
    FontColor := RichText.SelAttributes.Color;
    FontStyle := RichText.SelAttributes.Style;
  end;

  function FontAttrChanged(aFont : ITextFont) : boolean;
  begin
    result := (FontName <> RichText.SelAttributes.Name)
      or (FontSize <> RichText.SelAttributes.Size)
      or (FontColor <> RichText.SelAttributes.Color)
      or (FontStyle <> RichText.SelAttributes.Style);
  end;

  procedure WriteOpenFont;
  var
    tmpStr : string;
  begin
    tmpStr := Format('<FONT face=''%s'' size=%d color=%s>',
      [FontName, Round((FontSize - BaseFontSize) / 2.0), ColorToStr(FontColor)]);

    if fsBold in FontStyle then
      tmpStr := tmpStr + '<B>';

    if fsItalic in FontStyle then
      tmpStr := tmpStr + '<I>';

    WriteChar(tmpStr);
  end;

  procedure WriteCloseFont;
  var
    tmpStr : string;
  begin
    tmpStr := '';

    if fsItalic in FontStyle then
      tmpStr := tmpStr + '</I>';

    if fsBold in FontStyle then
      tmpStr := tmpStr + '</B>';

    tmpStr := tmpStr + '</FONT>';
    WriteChar(tmpStr);
  end;

  procedure CheckFont(aFont : ITextFont; var Txt: string);
  begin
    if  FontAttrChanged(aFont) and WasFont  then
    begin
      if  Txt <> '' then
        WriteChar(Txt);

      WriteCloseFont;
      Txt := '';
      SaveFontAttr(aFont);
      WriteOpenFont;
    end;

    WasFont := True;
  end;

  procedure ProcessParagraph;
  var
    Bul, Num, Indent: Boolean;
    Txt, C: string;
    ListType: integer;
  begin
    if iDocument = nil then Exit;

    Txt := '';
    iSubSelection := iDocument.Selection;
    iSubRange := iSubSelection as ITextRange;

    iSubRange.Move(tomCharacter, 1);
    CheckFont(iSubRange.Font, Txt);
//    WriteOpenParagraph;
//    SaveFontAttr(iRange.Font);
//    WriteOpenFont;

    ListType := iSubRange.Para.ListType;
    Indent := (ListType = 0) and (iSubRange.Para.LeftIndent > 0);
    iSubRange.Move(tomCharacter, -1);

    Bul := (ListType = tomListBullet);
    Num := (ListType = tomListNumberAsArabic);

    if  not Bul and IsBullet  then
      begin
        Txt := Txt + '</UL>';
        IsBullet := False;
      end;

    if  not Num and IsNumber  then
      begin
        Txt := Txt + '</OL>';
        IsNumber := False;
      end;

    if  Bul and not IsBullet  then
      begin
        Txt := Txt + '<UL>';
        IsBullet := True;
      end;

    if  Num and not IsNumber  then
      begin
        Txt := Txt + '<OL>';
        IsNumber := True;
      end;

    if  Indent  then
      Txt := Txt + '<DIR>';

    if  Bul or Num  then
      Txt := Txt + '<LI>'
    else
      begin
//        ParaOpen := True;
        Txt := Txt + '<P>';
      end;

    if iSubRange <> nil then
      while iSubRange.Move(tomCharacter, 1) = 1 do
        begin
          iSubRange.Expand(tomCharacter);
          iSubRange.Select;

          if (iSubRange.Text = #10) or (iSubRange.Text = #13) then
            begin
              iSubRange.Move(tomCharacter, -1);
              Break;
            end;

          CheckFont(iSubRange.Font, Txt);
          C := iSubRange.Text;

          if  C = #9 then
            C := '&#9;'
          else
          if  C = #11 then
            C := '<br>'
          else
          if  C = '&' then
            C := '&amp;'
          else
          if  C = '"' then
            C := '&quot;'
          else
          if  C = '>' then
            C := '&gt;'
          else
          if  C = '<' then
            C := '&lt;'
          else
          if  C = 'À' then
            C := '&euro;'
          else
          if  C = #$A7 then
            C := '&sect;'
          else
          if  C = #$AE then
            C := '&reg;'
          else
          if  C = #$A9 then
            C := '&copy;'
          else
          if  C = #$B6 then
            C := '&para;'
          else
          if  C = #$99 then
            C := '&trade;';

          Txt := Txt + C;
        end;

    if  Bul or Num  then
//      Txt := Txt + '</LI>'#13#10
    else
      Txt := Txt + '</P>'#13#10;

    if  Indent  then
      Txt := Txt + '</DIR>';

    WriteChar(Txt);

//    WriteCloseFont;
//    WriteCloseParagraph;
  end;

begin
  RichText := TLMDRichEdit.Create(nil);
  RichText.Visible := False;
  RichText.Parent := Parent;
  OldCurs := Screen.Cursor;

  try
    Screen.Cursor := crHourGlass;
    tmpStream := TMemoryStream.Create;
    try
      Lines.SaveToStream(tmpStream);
      tmpStream.Position := 0;
      RichText.Lines.LoadFromStream(tmpStream);
    finally
      tmpStream.Free;
    end;

    RichText.SelStart := 0;
    RichText.SelLength := 0;
    RichText.SelText := ' ';

    iDocument := RichText.RichEditOle as ITextDocument;
    RichText.SelStart := 0;
    RichText.SelLength := 0;

    if iDocument <> nil then
      iSelection := iDocument.Selection as ITextSelection;

    if iSelection <> nil then
      iSelection.MoveUp(tomParagraph, 1, 0);

    iRange := iSelection as ITextRange;

    WriteChar('<HTML><HEAD>'#13#10);
    WriteChar('<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">'#13#10);
    WriteChar('<META NAME="Generator" CONTENT="LMD RichPack 3.0">'#13#10);
    WriteChar('</HEAD><BODY>'#13#10);
    WasFont := False;
    FontName := '';
    FontSize := 0;
    FontColor := 0;
    FontStyle := [];
    IsBullet := False;
    IsNumber := False;
    ProcessParagraph;

    if iRange <> nil then
//      while iRange.Move(tomParagraph, 1) <> 0 do
      while iRange.Move(tomParagraph, 1) <> 0 do
        begin
          iRange.Move(tomParagraph, -1);
          iRange.Expand(tomParagraph);
          iRange.Select;
          ProcessParagraph;
          iRange.Collapse(tomStart);
        end;

    if  IsNumber  then
      WriteChar('</OL>');

    if  IsBullet  then
      WriteChar('</UL>');

    WriteCloseFont;
    WriteChar('</BODY></HTML>'#13#10);
  finally
    RichText.Free;
    Screen.Cursor := OldCurs;
  end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.CopyToStream(aStream : TStream; aSelection : boolean = True;
      aPlainText : boolean = False; aObjects : boolean = False; aPlainRtf : boolean = False);
var
  EditStream : TEditStream;
  Format     : WPARAM;

begin
  Format := 0;

  FillChar(EditStream, sizeof(EditStream), 0);

  if aSelection then Format := Format or SFF_SELECTION;
  if aPlainRtf then Format := Format or SFF_PLAINRTF;
  if aPlainText then
    begin
      if not aObjects then Format := Format or SF_TEXT
      else Format := Format or SF_TEXTIZED;
    end
  else
    begin
      if not aObjects then Format := Format or SF_RTFNOOBJS
      else Format := Format or SF_RTF;
    end;

  EditStream.dwCookie := DWORD(aStream);
  EditStream.pfnCallback := StreamOutCallback;

    EditStream.dwError := 0;

    SendMessage(Handle, EM_STREAMOUT, format, LPARAM(@editStream));

end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.WMPaste(var Message: TMessage);
begin
  if PlainText then
    begin
      Message.Result := 1;
      PastePlainText;
    end
  else
    inherited;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.PastePlainText;
var
  Stream : TStringStream;
  S : string;
begin
  S := Clipboard.AsText;

  if S <> '' then
    begin
      Stream := TStringStream.Create(S);
      try
        Stream.Position := 0;
        PasteFromStream(Stream, True, True, True);
      finally
        Stream.Free;
      end;
    end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.PasteFromStream(aStream : TStream;
  aSelection : boolean = True; aPlainText : boolean = False;
  aPlainRtf : boolean = False);
var
  EditStream : TEditStream;
  Format     : WPARAM;

begin

  Format := 0;
  FillChar(EditStream, sizeof(EditStream), 0);

  if aSelection then
    Format := Format or SFF_SELECTION;
  if aPlainRtf then
    Format := Format or SFF_PLAINRTF;
  if aPlainText then
    Format := Format or SF_TEXT
  else
    Format := Format or SF_RTF;

  EditStream.dwCookie := DWORD(aStream);
  EditStream.dwError := 0;
  EditStream.pfnCallback := StreamInCallback;

  SendMessage(Handle, EM_STREAMIN, Format, LPARAM(@EditStream));

end;
{ ******************************* protected  ****************************** }
{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.CreateParams(var Params: TCreateParams);
const
  HideScrollBars: array[Boolean] of DWORD = (ES_DISABLENOSCROLL, 0);
  HideSelections: array[Boolean] of DWORD = (ES_NOHIDESEL, 0);
  WordWraps: array[Boolean] of DWORD = (0, ES_AUTOHSCROLL);
  SelectionBars: array[Boolean] of DWORD = (0, ES_SELECTIONBAR);

begin

  inherited CreateParams(Params);
  case Version of
    1: CreateSubClass(Params, RICHEDIT_CLASS10A);
  else
    CreateSubClass(Params, RICHEDIT_CLASS);
  end;

  with Params do
    begin
      Style:= (Style and not (WS_HSCROLL or WS_VSCROLL)) or ES_SAVESEL or
        (WS_CLIPSIBLINGS or WS_CLIPCHILDREN);
      Style:= Style and not (WS_HSCROLL or WS_VSCROLL);
      if ScrollBars in [ssVertical, ssBoth] then
        Style:= Style or WS_VSCROLL;
      if (ScrollBars in [ssHorizontal, ssBoth]) and not WordWrap then
        Style:= Style or WS_HSCROLL;
      Style:= Style or ES_MULTILINE or HideScrollBars[FHideScrollBars] or
        HideSelections[FHideSelection] and not WordWraps[WordWrap];

//Style:= Style or WS_HSCROLL;
      WindowClass.style:= WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
    end;
end;
{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.CreateWnd;
var
  plain, WasModified: Boolean;

  procedure SetCallBack(Obj: IUnknown);
  //var
  //  LObjIUnknown: IntPtr;
  begin
    SendMessage(Handle, EM_SETOLECALLBACK, 0, LPARAM(Obj));
    GetRichEditOle(Handle, FRichEditOle);
    UpdateHostNames;
  end;

begin
  WasModified:= inherited Modified;
  inherited CreateWnd;

  // Delphi 8 sets FarEast wrong way
  if (SysLocale.FarEast) and not (SysLocale.PriLangID = LANG_JAPANESE) then
    Font.Charset:= GetDefFontCharSet;

  SendMessage(Handle, EM_SETEVENTMASK, 0,
    ENM_CHANGE or ENM_SELCHANGE or ENM_REQUESTRESIZE or ENM_OBJECTPOSITIONS or
    ENM_PROTECTED or ENM_LINK or ENM_CORRECTTEXT or ENM_SCROLL or ENM_MOUSEEVENTS);

  SendMessage(Handle, EM_SETBKGNDCOLOR, 0, ColorToRGB(GetThemedBkColor));

  if Version >= 2 then
  begin
    SendMessage(Handle, EM_AUTOURLDETECT, Ord(FAutoURLDetect), 0);
    FUndoLimit:= SendMessage(Handle, EM_SETUNDOLIMIT, FUndoLimit, 0);
    SetLangOptions(FLangOptions);
  end;

  if FAllowObjects then
    SetCallBack(FCallbackIntf);

  if PlainText then
    SendMessage(Handle, EM_SETTEXTMODE, TM_PLAINTEXT or TM_SINGLECODEPAGE, 0)
  else
    SendMessage(Handle, EM_SETTEXTMODE, TM_RICHTEXT or TM_MULTICODEPAGE, 0);

  if FMemStream <> nil then
    begin
       Plain := TRichEditStrings(Lines).PlainText;
       TRichEditStrings(Lines).PlainText := false;
      try
        Lines.LoadFromStream(FMemStream);
        FMemStream.Free;
        FMemStream := nil;
      finally
        TRichEditStrings(Lines).PlainText := Plain;
      end;
    end;
  Modified := WasModified;

  SetEditRect;
  FRecreateInProcess := False;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.DestroyWnd;
var
  plain: boolean;
begin
  FRecreateInProcess := True;
  FModified := Modified;
  FMemStream := TMemoryStream.Create;
  Plain := TRichEditStrings(Lines).PlainText;
  TRichEditStrings(Lines).PlainText := false;
  try
    Lines.SaveToStream(FMemStream);
    FMemStream.Position:= 0;
  finally
    TRichEditStrings(Lines).PlainText := Plain;
  end;
  inherited DestroyWnd;
end;

{ ------------------------------------------------------------------------- }
function  TLMDCustomRichEdit.GetDlgParentHandle:HWnd;
begin
  result:=0;  // Desktop
  case FDlgPosition of
    rdpOwner:
      result:=Handle;
    rdpMainForm:
      result:=Application.Mainform.Handle;
  end;
end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.GetCaretPos;
var
  CharRange: TCharRange;
begin

  SendMessage(Handle, EM_EXGETSEL, 0, TLMDPtrInt(@CharRange));

  Result.X:= CharRange.cpMax;
  Result.Y:= SendMessage(Handle, EM_EXLINEFROMCHAR, 0, Result.X);
  Result.X:= Result.X - SendMessage(Handle, EM_LINEINDEX, -1, 0);
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.SetCaretPos(const Value: TPoint);
var
  CharRange: TCharRange;
begin
  CharRange.cpMin := SendMessage(Handle, EM_LINEINDEX, Value.y, 0) + Value.x;
  CharRange.cpMax := CharRange.cpMin;

  SendMessage(Handle, EM_EXSETSEL, 0, TLMDPtrInt(@CharRange));

end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.GetSelLength: Integer;
var
  CharRange: TCharRange;
begin

  SendMessage(Handle, EM_EXGETSEL, 0, TLMDPtrInt(@CharRange));

  Result := CharRange.cpMax - CharRange.cpMin;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.GetSelStart: Integer;
var
  CharRange: TCharRange;
begin

  SendMessage(Handle, EM_EXGETSEL, 0, TLMDPtrInt(@CharRange));

  Result:= CharRange.cpMin;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.GetSelText: string;
begin

  SetLength(Result, GetSelLength + 1);
  SetLength(Result, SendMessage(Handle, EM_GETSELTEXT, 0, TLMDPtrInt(PChar(Result))));

end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.GetPrinterPageParams(var aPrinterPageWidth: LongInt; var aPageMargins: TLMDRichPageMargins);
var
  DC: HDC;
  dX, pX: integer;
begin
      if (FRichEditMode = edModePrinterSupport)  then
        begin
          if  not (csDesigning in ComponentState)
              and (Printer.Printers.Count > 0)
              and (Printer.PrinterIndex <> -1)
              and LMDRichIsPrinterValid then
            begin
              DC:= GetDC(0);
              try
                pX := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
                dX := GetDeviceCaps(Printer.Handle, PHYSICALOFFSETX);
                aPageMargins.OnChange:= nil;
                aPageMargins.Units := unInches;
                aPageMargins.Left := Max(dX / pX * InchFactor, aPageMargins.Left);
                aPageMargins.Right := Max((GetDeviceCaps(Printer.Handle, PHYSICALWIDTH) -
                    Printer.PageWidth - dX) / pX * InchFactor, aPageMargins.Right);
                dX := GetDeviceCaps(Printer.Handle, PHYSICALOFFSETY);
                aPageMargins.Top := Max(dX / pX * InchFactor, aPageMargins.Top);
                aPageMargins.Bottom := Max((GetDeviceCaps(Printer.Handle, PHYSICALHEIGHT) -
                    Printer.PageHeight - dX) / pX * InchFactor, aPageMargins.Bottom);
                aPageMargins.Units := Measurement;
                aPageMargins.OnChange:= ChangeMargins;

                dX := GetDeviceCaps(DC, LOGPIXELSX);
                aPrinterPageWidth:= MulDiv(Printer.PageWidth, dX, pX);
                //Perform(EM_SETTARGETDEVICE, Printer.Handle, Printer.PageWidth);
              finally
                ReleaseDC(0, DC);
              end;
            end
            else
              aPrinterPageWidth:= 672;
        end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.DoContextPopup(MousePos: TPoint; var Handled: Boolean);
var
  PopupMenu: TPopupMenu;
  Pt: TPoint;
  PL: TPointL;
  V: integer;
  tmpStr: string;
  IsBookmark: Boolean;

begin
  inherited DoContextPopup(MousePos, Handled);

  if  not Handled then
    begin
      PopupMenu := GetPopupMenu;
      if (PopupMenu <> nil) and PopupMenu.AutoPopup then
        begin
          SendCancelMode(nil);

          if MousePos.X < 0 then
            begin
              V := SelStart;

              if  Version = 2 then
                begin
                  V := SendMessage(Handle, EM_POSFROMCHAR, V, 0);
                  Pt.x := LoWord(V);
                  Pt.y := HiWord(V);
                end
              else
                begin
                SendMessage(Handle, EM_POSFROMCHAR, TLMDPtrInt(@PL), V);
                Pt.X := PL.x;
                  Pt.y := PL.y;
                end;
            end
          else
            Pt := MousePos;

          PL.x := Pt.x;
          PL.y := Pt.y;
        V := SendMessage(Handle, EM_CHARFROMPOS, 0, TLMDPtrInt(@PL));
        if PopupMenu = FDefaultPopup then
            begin
              if  (FRichStorage is TLMDRichHyperTextStorage) and
                TLMDRichHyperTextStorage(FRichStorage).HyperText.GetLinkParams(V, IsBookmark, tmpStr)  then
                begin
                  FLockLinkClick := true;

                  if not Assigned(FDefaultPopupURL) then
                    begin
                      FDefaultPopupURL := TPopupMenu.Create(nil);
                      //PopupMenu := FDefaultPopupURL;
                    end;

                  PopupMenu := FDefaultPopupURL;
                end;
            end;
          {$IFNDEF LMDCOMP12}
          Pt := ClientToScreen(Pt);
          {$ELSE}
            {$IFDEF LMDCOMP14}Pt := ClientToScreen(Pt);{$ENDIF}
          {$ENDIF}

          PopupMenu.PopupComponent := Self;
          PopupMenu.Popup(Pt.X, Pt.Y);
          Handled := True;
        end;
    end;
end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.GetPopupMenu: TPopupMenu;

  function  MakeMenuItem(ActCls: TBasicActionClass): TMenuItem;
  begin
    Result := TMenuItem.Create(FDefaultPopup);
    Result.Action:= ActCls.Create(FDefaultPopup);
    FDefaultPopup.Items.Add(Result);
  end;

var
  EnumOleVerb: IEnumOleVerb;
  OleVerb :  TOleVerb;
  Item: TMenuItem;
  ReObject: TReObject;

begin
  if Assigned(FPopupVerbMenu) then
    FreeAndNil(FPopupVerbMenu);

  Result:= inherited GetPopupMenu;

  if (Result = nil) and FShowDefaultPopup then
    begin
      if  FDefaultPopup = nil then
        begin
          FDefaultPopup:= TPopupMenu.Create(nil);
          MakeMenuItem(TLMDRichEditCut);
          MakeMenuItem(TLMDRichEditCopy);
          MakeMenuItem(TLMDRichEditPaste);
          FDefaultPopup.Items.Add(NewLine);
          MakeMenuItem(TLMDRichEditTextAttributes);
          Item:= TMenuItem.Create(FDefaultPopup);
          FDefaultPopup.Items.Add(Item);
          Item.Action:= TLMDRichEditNumbering.Create(FDefaultPopup);
          TLMDRichEditNumbering(Item.Action).Numbering:= nsBullet;
          MakeMenuItem(TLMDRichEditParagraph);
        end;

      Result:= FDefaultPopup;
    end;

  if FAutoVerbMenu and (SelectionType = [stObject]) and Assigned(FRichEditOle) then
    begin
    FillChar(ReObject, SizeOf(ReObject), 0);
    ReObject.cbStruct:= SizeOf(ReObject);
      if Succeeded(IRichEditOle(FRichEditOle).GetObject(
        Longint(REO_IOB_SELECTION), ReObject, REO_GETOBJ_POLEOBJ)) then
      try
        if Assigned(ReObject.poleobj) and
          (ReObject.dwFlags and REO_INPLACEACTIVE = 0) then
          begin
            FPopupVerbMenu:= TPopupMenu.Create(nil {Self});
            if ReObject.poleobj.EnumVerbs(EnumOleVerb) = 0 then
            try
            while (EnumOleVerb.Next(1, OleVerb, nil) = 0) and
                (OleVerb.lVerb >= 0) and
                (OleVerb.grfAttribs and OLEVERBATTRIB_ONCONTAINERMENU <> 0) do
                begin
            Item:= TMenuItem.Create(FPopupVerbMenu);
                Item.Caption:= WideCharToString(OleVerb.lpszVerbName);
                Item.Tag:= OleVerb.lVerb;
                  Item.Default:= (OleVerb.lVerb = OLEIVERB_PRIMARY);
                  Item.OnClick:= PopupVerbClick;
                  FPopupVerbMenu.Items.Add(Item);
                end;
            finally
              EnumOleVerb:= nil;
            end;

            if (Result <> nil) and (Result.Items.Count > 0) then
              begin
                Item:= TMenuItem.Create(FPopupVerbMenu);
                Item.Caption:= '-';
                Result.Items.Add(Item);
                Item:= TMenuItem.Create(FPopupVerbMenu);
                Item.Caption:= Format(SPropDlgCaption,
                  [GetFullNameStr(ReObject.poleobj)]);
                Item.OnClick:= ObjectPropsClick;
                Result.Items.Add(Item);
                if FPopupVerbMenu.Items.Count > 0 then
                  begin
                    FPopupVerbMenu.Items.Caption:=
                      GetFullNameStr(ReObject.poleobj);
                    Result.Items.Add(FPopupVerbMenu.Items);
                  end;
              end
            else
              if FPopupVerbMenu.Items.Count > 0 then
                begin
                  Item:= TMenuItem.Create(FPopupVerbMenu);
                  Item.Caption:= Format(SPropDlgCaption,
                    [GetFullNameStr(ReObject.poleobj)]);
                  Item.OnClick:= ObjectPropsClick;
                  FPopupVerbMenu.Items.Insert(0, Item);
                  Result:= FPopupVerbMenu;
                end;
          end;
      finally
        ReObject.poleobj:= nil;
      end;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetSelLength(Value: Integer);
var
  CharRange: TCharRange;
begin

  SendMessage(Handle, EM_EXGETSEL, 0, TLMDPtrInt(@CharRange));
  CharRange.cpMax:= CharRange.cpMin + Value;
  SendMessage(Handle, EM_EXSETSEL, 0, TLMDPtrInt(@CharRange));
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);

end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetSelStart(Value: Integer);
var
  CharRange: TCharRange;
begin
  CharRange.cpMin:= Value;
  CharRange.cpMax:= Value;

  SendMessage(Handle, EM_EXSETSEL, 0, TLMDPtrInt(@CharRange));

end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.DoSetMaxLength(Value: Integer);
begin
  SendMessage(Handle, EM_EXLIMITTEXT, 0, Value);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.RequestSize(const Rect: TRect);
begin
  if Assigned(OnResizeRequest) then OnResizeRequest(Self, Rect);
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.SelectionChange;
begin
  if Assigned(OnSelectionChange) then OnSelectionChange(Self);

  InformCombos;
  UpdateRuler;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.URLClick(const URLText: string; Button:
  TMouseButton);
begin
  if IsValidRichStorageItem and Assigned(FRichStorage.Items[FRichStorageItem].OnURLClick) then
    FRichStorage.Items[FRichStorageItem].OnURLClick(Self, URLText, Button);
  if Assigned(OnURLClick) then
    OnURLClick(Self, URLText, Button)
  else
    if  Button = mbLeft then
      LMDFireURL(URLText);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.LinkClick(const LinkText: string;
  Button: TMouseButton);
begin
  //[VB] Oct 2008
  //Must call OnLinkClick BEFORE DoLinkClick, because
  //otherwise selection changes and new SelStart breaks
  //correct work of ValidLinkSelection and GetLinkParams
  //inside OnLinkClick
  if Assigned(OnLinkClick) then OnLinkClick(Self, LinkText, Button);
  if IsValidRichStorageItem then
    FRichStorage.Items[FRichStorageItem].DoLinkClick(Self, LinkText, Button);
  //if Assigned(OnLinkClick) then OnLinkClick(Self, LinkText, Button); //see note above
end;

{ ******************************* private  ******************************** }
{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.CMBiDiModeChanged(var Message: TMessage);
var
  AParagraph: TParaFormat2;
begin
  HandleNeeded; { we REALLY need the handle for BiDi }
  inherited;
  Paragraph.GetAttributes(AParagraph);
  AParagraph.dwMask:= PFM_ALIGNMENT;
  AParagraph.wAlignment:= Ord(Alignment) + 1;
  Paragraph.SetAttributes(AParagraph);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.CMColorChanged(var Message: TMessage);
begin
  inherited;
  SendMessage(Handle, EM_SETBKGNDCOLOR, 0, ColorToRGB(GetThemedBkColor));
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.CMDocWindowActivate(var Message: TMessage);
begin
  if Assigned(FCallback) then
  // ToDo
    with TLMDRichEditOleCallback(FCallback) do
      if Assigned(DocForm) and IsFormMDIChild(DocForm.Form) then
        begin
          if Message.WParam = 0 then
            begin
              FrameForm.SetMenu(0, 0, 0);
              FrameForm.ClearBorderSpace;
            end;
        end;
  end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.CMFontChanged(var Message: TMessage);
begin
  FDefAttributes.Assign(Font);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.CNNotify(var Message: TWMNotify);
var
  ClickButton : TMouseButton;
  IsBookmark  : boolean;
  tmpStr      : string;
  Link        : PENLink;
  begin
  with Message do
    case NMHdr.code of
      EN_OBJECTPOSITIONS:
        begin
          if  ReadOnly  then
            Result := 1
          else
            Result := 0;
        end;
      EN_MSGFILTER:
        begin
          Result := 0;
          dec(FInMousePosURLc);

          if  Assigned(FOnLinkMouseMove) and (FInMousePosURLc < 0)
              and (FInMousePosURL <> '')  then
            begin
              FInMousePosURL := '';
              FOnLinkMouseMove(self, '', False);
            end;

        end;
      EN_HSCROLL, EN_VSCROLL:
        Result := 1;
      EN_SELCHANGE: SelectionChange;
      EN_LINK:
        if not FLockLinkClick then
        begin
        Link := PENLink(NMHdr);
        FInMousePosURLc := 1;

          if (Link.msg = WM_RBUTTONUP) or (Link.msg = WM_LBUTTONUP) or Assigned(FOnLinkMouseMove) then
          begin
            tmpStr := '';
            IsBookmark := False;

            if Link.msg = WM_RBUTTONUP then
              ClickButton := mbRight
            else
              ClickButton := mbLeft;

            if (FRichStorage is TLMDRichHyperTextStorage) then
              begin
                if NOT TLMDRichHyperTextStorage(FRichStorage).
                        HyperText.GetLinkParams(Link.chrg.cpMin, IsBookmark, tmpStr)  then
                  begin
                    tmpStr := '';
                    IsBookmark := False;
                  end;
              end;

            if (tmpStr = '') and
                not GetLinkParams(self, Link.chrg.cpMin, IsBookmark, tmpStr)  then
              tmpStr := '';

            if tmpStr = '' then
              begin
                tmpStr := Trim(String(GetTextRange(Link.chrg.cpMin, Link.chrg.cpMax)));
                IsBookmark := False;
              end;

            if tmpStr <> ''  then
              if (Link.msg = WM_RBUTTONUP) or (Link.msg = WM_LBUTTONUP) then
                begin
                  if (FRichStorage is TLMDRichHyperTextStorage) and
                    (GetKeyState(VK_CONTROL) < 0) then
                    TLMDRichHyperTextStorage(FRichStorage).HyperText.ShowLinkDialog
                  else
                    if IsBookmark then
                      LinkClick(tmpStr, ClickButton)
                    else
                      URLClick(tmpStr, ClickButton);
                end
              else
              if Assigned(FOnLinkMouseMove) and (tmpStr <> FInMousePosURL) then
                begin
                  FInMousePosURL := tmpStr;
                  FOnLinkMouseMove(self, tmpStr, IsBookmark);
                end;

//            LinkClick('', ClickButton);
          end;
        end
        else
          FLockLinkClick := false;

      EN_REQUESTRESIZE:
      RequestSize(PReqSize(NMHdr)^.rc);
      EN_SAVECLIPBOARD:
      with PENSaveClipboard(NMHdr)^ do
          if not SaveClipboard(cObjectCount, cch) then Result:= 1;
      EN_PROTECTED:
      if PENProtected(NMHdr).msg = WM_COPY then
          Result:= 0
        else
        with PENProtected(NMHdr)^.chrg do
          if not ProtectChange(cpMin, cpMax) then Result:= 1;
      end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.CMUIDeactivate(var Message: TMessage);
begin
  if (GetParentForm(Self) <> nil) and Assigned(FRichEditOle) and
    (GetParentForm(Self).ActiveOleControl = Self) then
    IRichEditOle(FRichEditOle).InPlaceDeactivate;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.WMDropFiles(var Msg: TWMDropFiles);
var
//  aFileName: array[0..MAX_PATH] of Char;
//  Num: Cardinal;
  FileName: string;
  Accept: Boolean;
begin
  if  AcceptDropFiles then
    begin
    SetLength(FileName, MAX_PATH);
    try
      SetLength(FileName, DragQueryFile(Msg.Drop, 0, PChar(FileName), MAX_PATH));
        Accept := DoDropFile(FileName);
      if  Accept  then
          Msg.Result:= 0;
      finally
        DragFinish(Msg.Drop);
      end;
{
      try
        Num:= DragQueryFile(Msg.Drop, $FFFFFFFF, nil, 0);
        if Num > 0 then
          begin
            DragQueryFile(Msg.Drop, 0, PChar(@aFileName), Pred(SizeOf(aFileName)));
            FileName
              Application.BringToFront;
              Lines.LoadFromFile(StrPas(AFileName));
            end;
        finally
          DragFinish(Msg.Drop);
        end;
}
      if  Accept  then
        begin
          Application.BringToFront;
//          Lines.LoadFromFile(StrPas(AFileName));
        end;
    end;
end;

{ ------------------------------------------------------------------------- }

function  TLMDCustomRichEdit.DoDropFile(const FileName: string): Boolean;
begin
  Result := True;
  if  Assigned(FOnDropFile) then
    FOnDropFile(self, FileName, Result);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.WMDestroy(var Msg: TWMDestroy);
begin
  CloseObjects;
  FRichEditOle:= nil;
  if  AcceptDropFiles then
    DragAcceptFiles(Handle, false);
  inherited;
end;

{ ------------------------------------------------------------------------- }
var
  Painting: Boolean = False;

procedure TLMDCustomRichEdit.WMPaint(var Message: TWMPaint);
var
  R, R1: TRect;
begin
  if Version >= 2 then
    inherited
  else
  begin
    if GetUpdateRect(Handle, R, True) then
    begin
      with ClientRect do
        R1 := Rect(Right - 3, Top, Right, Bottom);
      if IntersectRect(R, R, R1) then
        InvalidateRect(Handle, @R1, True);
    end;
    if Painting then
      Invalidate
    else
    begin
      Painting := True;
      try
        inherited;
      finally
        Painting := False;
      end;
    end;
  end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.WMRButtonUp(var Message: TWMRButtonUp);

begin
  // RichEd20 does not pass the WM_RBUTTONUP message to defwndproc,
  // so we get no WM_CONTEXTMENU message.  Simulate message here.
  //  if Version < 2 then
  if FAllowObjects then
    {$ifdef LMDX64}
    Perform(WM_CONTEXTMENU, Handle, LParam(ClientToScreen(Message.Pos)));
    {$else}
    Perform(WM_CONTEXTMENU, Handle, LParam(PointToSmallPoint(ClientToScreen(SmallPointToPoint(Message.Pos)))));
    {$endif}
  inherited;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  inherited;
  if Message.Result = 0 then
    begin
      Message.Result:= 1;
      GetCursorPos(P);
      with PointToSmallPoint(P) do
        case Perform(WM_NCHITTEST, 0, MakeLong(X, Y)) of
        HTVSCROLL,
            HTHSCROLL:
            Windows.SetCursor(Screen.Cursors[crArrow]);
          HTCLIENT:
            Windows.SetCursor(Screen.Cursors[crIBeam]);
        end;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.WMSetFont(var Message: TWMSetFont);
begin
  inherited;
  FDefAttributes.Assign(Font);
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.GetAutoURLDetect: Boolean;
begin
  Result:= FAutoURLDetect;
  if HandleAllocated and not (csDesigning in ComponentState) then
    begin
      if Version >= 2 then
        Result:= Boolean(SendMessage(Handle, EM_GETAUTOURLDETECT, 0, 0));
    end;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.GetCanPaste: Boolean;
begin
  Result:= False;
  if HandleAllocated then
    Result:= SendMessage(Handle, EM_CANPASTE, 0, 0) <> 0;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.GetCanRedo: Boolean;
begin
  Result:= False;
  if HandleAllocated and (Version >= 2) then
    Result:= SendMessage(Handle, EM_CANREDO, 0, 0) <> 0;
end;

{ ------------------------------------------------------------------------- }
const
  RichLangOptions: array[TLMDRichLangOption] of DWORD = (IMF_AUTOKEYBOARD,
    IMF_AUTOFONT, IMF_IMECANCELCOMPLETE, IMF_IMEALWAYSSENDNOTIFY);

function TLMDCustomRichEdit.GetLangOptions: TLMDRichLangOptions;
var
  Flags: Longint;
  I: TLMDRichLangOption;
begin
  Result:= FLangOptions;
  if HandleAllocated and not (csDesigning in ComponentState) and
    (Version >= 2) then
    begin
      Result:= [];
      Flags:= SendMessage(Handle, EM_GETLANGOPTIONS, 0, 0);
      for I:= Low(TLMDRichLangOption) to High(TLMDRichLangOption) do
        if Flags and RichLangOptions[I] <> 0 then Include(Result, I);
    end;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.GetPlainText: Boolean;
begin
  Result := TRichEditStrings(Lines).PlainText;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.GetRedoName: TLMDRedoUndoType;
begin
  Result:= uidUnknown;
  if HandleAllocated then
    begin
      if Version >= 2 then
        begin
          Result:= TLMDRedoUndoType(SendMessage(Handle, EM_GETREDONAME, 0, 0));
          end;
    end;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.GetSelectionType: TLMDRichSelectionType;
const
  SelTypes: array[TLMDRichSelection] of Integer = (
    SEL_TEXT, SEL_OBJECT, SEL_MULTICHAR, SEL_MULTIOBJECT);
var
  Selection: Integer;
  I: TLMDRichSelection;
begin
  Result:= [];
  if HandleAllocated then
    begin
      Selection:= SendMessage(Handle, EM_SELECTIONTYPE, 0, 0);
      for I:= Low(TLMDRichSelection) to High(TLMDRichSelection) do
        if SelTypes[I] and Selection <> 0 then Include(Result, I);
    end;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.GetUndoName: TLMDRedoUndoType;
begin
  Result:= uidUnknown;
  if HandleAllocated then
    begin
      if Version >= 2 then
        begin
          Result:= TLMDRedoUndoType(SendMessage(Handle, EM_GETUNDONAME, 0, 0));
          end;
    end;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.GetVersion: LongInt;
begin
  Result:= RichEditVer
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.GetZoom: TLMDZoom;
var
  Numerator : Word;
  Denominator : LongInt;
begin
  Result:= FZoom;
  Numerator:=0;
  Denominator:=0;
  if HandleAllocated then
    begin
      if Version >= 3 then
        begin
        SendMessage(Handle, EM_GETZOOM, TLMDPtrInt(@Numerator),
            TLMDPtrInt(@Denominator));
        if (Numerator = Denominator) then
            Result:= 0
          else if Numerator > Denominator then
            Result := Round(Numerator / Denominator)
          else
            Result := -Round(Denominator / Numerator);
        end;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetAllowObjects(const Value: Boolean);
begin
  if FAllowObjects <> Value then
    begin
      FAllowObjects:= Value;
      RecreateWnd;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetAutoURLDetect(Value: Boolean);
begin
  if FAutoURLDetect <> Value then
    begin
      FAutoURLDetect:= Value;
      if HandleAllocated and (Version >= 2) then
      begin
        SendMessage(Handle, EM_AUTOURLDETECT, Ord(FAutoURLDetect), 0);
        RecreateWnd;
//        Refresh;
      end;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetHideSelection(Value: Boolean);
begin
  if HideSelection <> Value then
    begin
      FHideSelection:= Value;
      SendMessage(Handle, EM_HIDESELECTION, Ord(HideSelection), LPARAM(True));
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetHideScrollBars(Value: Boolean);
begin
  if HideScrollBars <> Value then
    begin
      FHideScrollBars:= value;
      RecreateWnd;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetLangOptions(Value: TLMDRichLangOptions);
var
  Flags: DWORD;
  I: TLMDRichLangOption;
begin
  FLangOptions:= Value;
  if HandleAllocated and (Version >= 2) then
    begin
      Flags:= 0;
      for I:= Low(TLMDRichLangOption) to High(TLMDRichLangOption) do
        if I in Value then Flags:= Flags or RichLangOptions[I];
      SendMessage(Handle, EM_SETLANGOPTIONS, 0, LPARAM(Flags));
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetRichEditStrings(Value: TStrings);
begin
  FRichEditStrings.Assign(Value);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetPlainText(Value: Boolean);
begin
  if TRichEditStrings(Lines).PlainText <> Value  then
  begin
    TRichEditStrings(Lines).PlainText := Value;
    RecreateWnd;
  end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.SetProtectLinks(const Value: boolean);
begin
  if FProtectLinks <> Value then
  begin
    FProtectLinks := Value;
    if (FRichStorage <> nil) and (FRichStorage is TLMDRichHyperTextStorage) then
    begin
      TLMDRichHyperTextStorage(FRichStorage).HyperText.Editor:= TLMDRichEdit(Self);
      TLMDRichHyperTextStorage(FRichStorage).HyperText.MarkAllLink(Value);
    end;
  end;
end;
{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetRuler(aValue: Boolean);
begin
  if FShowRuler <> aValue then
    begin
      FShowRuler:= aValue;

      if  FShowRuler  then
        begin
          FRuler:= TLMDRTFRuler.Create(self);
//          self.InsertComponent(FRuler);

          if FRichEditMode = edModeAppOnly then
            FRuler.Mode:= rmWithoutMargins
          else
            FRuler.Mode:= rmWithMargins;

          FRuler.Anchors:= [akLeft, akRight, akTop];
          FRuler.RichEdit:= Self;
          FRuler.Measurement := Measurement;
          FRuler.Visible:= true;
          SetRulerPosition;
          FRuler.Parent:= self.Parent;
          SetRulerMeasurement;
//          FRuler.Parent:= self;
          if FRuler.Parent <> nil then FPageMargins.DoChange;
        end
      else
        FreeAndNil(FRuler);

      RecreateWnd;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetTitle(const Value: string);
begin
  if FTitle <> Value then
    begin
      FTitle:= Value;
      UpdateHostNames;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetUndoLimit(Value: Integer);
begin
  if (Value <> FUndoLimit) then
    begin
      FUndoLimit:= Value;
      if (Version >= 2) and HandleAllocated then
        FUndoLimit:= SendMessage(Handle, EM_SETUNDOLIMIT, Value, 0);
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetVersion(aValue: LongInt);
begin { NOTHING TO DO }
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetZoom(const Value: TLMDZoom);
begin
  if FZoom <> Value then
    begin
      FZoom:= Value;
      if HandleAllocated and (Version >= 3) then
        begin
          if Value = 0 then
            SendMessage(Handle, EM_SETZOOM, 1, 1)
          else if Value > 0 then
            SendMessage(Handle, EM_SETZOOM, Value, 1)
          else
            SendMessage(Handle, EM_SETZOOM, 1, -Value)
        end;
    end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.SetRichEditMode(Value: TLMDRichEditMode);
begin
  if  FRichEditMode <> Value  then
    begin
      FRichEditMode := Value;

      GetPrinterPageParams(FPrinterPageWidth, FPageMargins);

      if  Assigned(FRuler)  then
        if FRichEditMode = edModeAppOnly then
          FRuler.Mode:= rmWithoutMargins
        else
          FRuler.Mode:= rmWithMargins;

      SetEditRect;
      SetRulerMeasurement;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetDefAttributes(Value: TLMDTextAttributes);
begin
  DefAttributes.Assign(Value);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetSelAttributes(Value: TLMDTextAttributes);
begin
  SelAttributes.Assign(Value);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetWordAttributes(Value: TLMDTextAttributes);
begin
  WordAttributes.Assign(Value);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.CloseObjects;
var
  I: Integer;
  ReObject: TReObject;
begin
  if Assigned(FRichEditOle) then
    begin
    FillChar(ReObject, SizeOf(ReObject), 0);
    ReObject.cbStruct:= SizeOf(ReObject);
      with IRichEditOle(FRichEditOle) do
        begin
          for I:= GetObjectCount - 1 downto 0 do
            if Succeeded(GetObject(I, ReObject, REO_GETOBJ_POLEOBJ)) then
              begin
                if ReObject.dwFlags and REO_INPLACEACTIVE <> 0 then
                  IRichEditOle(FRichEditOle).InPlaceDeactivate;
                ReObject.poleobj.Close(OLECLOSE_NOSAVE);
                ReObject.poleobj:= nil;
              end;
        end;
    end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.ObjectPropsClick(Sender: TObject);
begin
  ObjectPropertiesDialog;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.ProtectChange(StartPos, EndPos: Integer): Boolean;
begin
  Result:= FDefaultProtect;
  if Assigned(OnProtectChange) then
    OnProtectChange(Self, StartPos, EndPos, Result);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.PopupVerbClick(Sender: TObject);
var
  ReObject: TReObject;

begin
  if Assigned(FRichEditOle) then
    begin
    FillChar(ReObject, SizeOf(ReObject), 0);
    ReObject.cbStruct:= SizeOf(ReObject);
      if Succeeded(IRichEditOle(FRichEditOle).GetObject(
        Longint(REO_IOB_SELECTION), ReObject, REO_GETOBJ_POLEOBJ or
        REO_GETOBJ_POLESITE)) then
      try
        if ReObject.dwFlags and REO_INPLACEACTIVE = 0 then
        OleCheck(ReObject.poleobj.DoVerb((Sender as TMenuItem).Tag, nil,
            ReObject.polesite, 0, Handle, ClientRect));
        finally
        ReObject.polesite:= nil;
        ReObject.poleobj:= nil;
      end;
    end;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.SaveClipboard(NumObj, NumChars: Integer): Boolean;
begin
  Result:= True;
  if Assigned(OnSaveClipboard) then
    OnSaveClipboard(Self, NumObj, NumChars, Result);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.UpdateHostNames;
var
  AppName: String;
begin
  if HandleAllocated and Assigned(FRichEditOle) then
    begin
      AppName:= Application.Title;
      if Trim(AppName) = '' then
        AppName:= ExtractFileName(Application.ExeName);
    if Trim(Title) = '' then
        IRichEditOle(FRichEditOle).SetHostNames(PAnsiChar(AnsiString(AppName)), PAnsiChar(AnsiString(AppName)))
      else
        IRichEditOle(FRichEditOle).SetHostNames(PAnsiChar(AnsiString(AppName)), PAnsiChar(AnsiString(Title)));
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetRulerPosition;
var
  Rect: TRect;
begin
  if not FInRulerPosition then begin
    FInRulerPosition := True;
    try
      if Assigned(FRuler) then
        begin
          GetRulerPosition(Rect);
          FRuler.SetBounds(Rect.Left, Rect.Top, Rect.Right - Rect.Left, FRuler.Height);
        end;
    finally
      FInRulerPosition := False;
    end;
  end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.GetRulerPosition(var Rect: TRect);
var
  I: integer;
  R: TRect;
begin
  if  Assigned(FRuler)  then
    begin
      i := BorderWidth;
      if  BorderStyle = bsSingle  then  inc(i, 2);
      R := ClientRect;
      Rect.Left:= Left + R.Left + i;
      Rect.Top:= Top + R.Top + i;
      Rect.Right := Rect.Left + (R.Right - R.Left) - i;
    end;
end;
{

procedure TLMDCustomRichEdit.AdjustSize;
begin
  inherited ;
  SetRulerPosition;
end;
}
{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.WMSize(var Message: TWMSize);
begin
  inherited;
  SetEditRect;
  SetRulerPosition;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.WMMove(var Message: TWMMove);
begin
  inherited;
{
  if  Assigned(FRuler)  then
    begin
      FRuler.Left:= Left;
      FRuler.Top:= Top;
      FRuler.Width:= Width;
    end;
}
  SetEditRect;
  SetRulerPosition;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.WMSetFocus(var Message: TMessage);

begin
  if (FRichStorage <> nil) and (FRichStorage is TLMDRichHyperTextStorage) then
    begin
      TLMDRichHyperTextStorage(FRichStorage).HyperText.Editor:= TLMDRichEdit(Self);
      TLMDRichHyperTextStorage(FRichStorage).HyperText.MarkAllLink(ProtectLinks);
    end;
  inherited;
end;

{ ------------------------------------------------------------------------- }

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.WMVScroll(var Message: TMessage);

begin
  inherited;
  if Assigned(FOnVScroll) then FOnVScroll(Self);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.WMHScroll(var Message: TMessage);

begin
  inherited;
  if Assigned(FOnHScroll) then
    FOnHScroll(Self);
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.PrepareDialog(dlg:TCustomForm);
begin
  case DlgPosition of
    rdpScreen: LMDCenterForm(dlg);
    rdpMainform: LMDCenterChild(Application.MainForm, dlg, false);
    rdpOwner:
      if Owner is TCustomForm then
        LMDCenterChild(TCustomForm(Owner), dlg, false)
      else
       LMDCenterForm(dlg);
  end;
  if Assigned(FOnCustomize) then
     FOnCustomize(dlg);
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.PrepareDialog(dlg:TLMDRichBaseDialog);
begin
  case FDlgPosition of
    rdpScreen: Dlg.Options:=[rdoCenterDialog];
    rdpOwner, rdpMainform: Dlg.Options:=[rdoCenterDialog, rdoCenterOwnerForm];
  end;
  dlg.OnCustomize:=FOnCustomize;
  if Assigned(FOnDlgInit) then
    FOnDlgInit(dlg);
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.SetEditRect;
var
  Loc, L1: TRect;
//  CnvFunc: function(aValue:Double):Double;
begin
//  if csLoading in ComponentState then Exit;
//  SendMessage(Handle, EM_GETRECT, 0, TLMDPtrInt(@Loc));
  Loc := GetEditRect;
  L1 := Loc;
  Loc.Bottom:= ClientHeight + 1; {+1 is workaround for windows paint bug}
  if ShowRuler then
    begin
      Loc.Top:= FRuler.Height;
      Loc.Left := LMDRTFRuler .FBorderLeft;
    end
  else
    begin
      Loc.Top:= 0;
      Loc.Left := 1;
    end;
  // RM
  Inc(Loc.Top, 2);
  // ---
  if FRichEditMode = edModeAppOnly then
    begin
      inc(Loc.Left, LMDToPixelsX(PageMargins.Left, Measurement));
      Loc.Right:= ClientWidth - LMDToPixelsX(PageMargins.Right, Measurement);
    end
  else
    begin
      inc(Loc.Left, LMDToPixelsX(PageMargins.Left, Measurement));
      Loc.Right:= Loc.Left + Round(PrinterPageWidth);
    end;

  SendMessage(Handle, EM_SETRECT, 0, TLMDPtrInt(@Loc));

  if  Assigned(FRuler)  then
    begin
      FRuler.HostRect := GetEditRect;//Loc;
      UpdateRuler;
    end;
end;

{ ------------------------------------------------------------------------- }

function  TLMDCustomRichEdit.GetEditRect: TRect;
begin
  if HandleAllocated then
  SendMessage(Handle, EM_GETRECT, 0, TLMDPtrInt(@Result))
  else
  FillChar(Result, SizeOf(Result), 0);
  end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetPageMargins(const Value: TLMDRichPageMargins);
begin
  FPageMargins.Assign(Value);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetStorage(const Value: TLMDRichStorage);
begin
  if FRichStorage <> nil then FRichStorage.UnRegisterChanges(FStorageLink);
  FRichStorage:= Value;
  if FRichStorage <> nil then FRichStorage.RegisterChanges(FStorageLink);
  UpdateFromStorage;
end;

{ ------------------------------------------------------------------------- }

function  TLMDCustomRichEdit.IsValidRichStorageItem: Boolean;
begin
  Result := Assigned(FRichStorage) and (FRichStorageItem >= 0)
    and (FRichStorage.Count > FRichStorageItem);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetStorageItem(const Value: LongInt);
begin
  FRichStorageItem:= Value;
  UpdateFromStorage;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.IsStringsStored: Boolean;
begin
  Result:= not IsValidRichStorageItem;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.Notification(aComponent: TComponent;
  Operation: TOperation);
var
  NeedClear: Boolean;
begin
  inherited;
  if (Operation = opRemove) and (aComponent = FRichStorage) then
    begin
      NeedClear := IsValidRichStorageItem;
      FRichStorage:= nil;

      if  NeedClear then
        Lines.Clear;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.UpdateFromStorage;
var
  S : TStringStream;
begin
  if IsValidRichStorageItem then
    begin
      S := TStringStream.Create(FRichStorage.Items[FRichStorageItem].Lines.Text);
      S.Position := 0;
      try
        SelectAll;
        SelAttributes.Protected:= false;
        Lines.LoadFromStream(S);
        if (TObject(FRichStorage) is TLMDRichHyperTextStorage) then
          begin
            TLMDRichHyperTextStorage(FRichStorage).HyperText.Editor:=TLMDRichEdit(Self);
            TLMDRichHyperTextStorage(FRichStorage).HyperText.MarkAllLink;
          end;
      finally
        S.Free;
      end;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.StorageDataChanged(Sender: TObject);
begin
  UpdateFromStorage
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.CreateHandle;
begin
  inherited CreateHandle;

  if  AcceptDropFiles then
    DragAcceptFiles(Handle, True);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetAcceptDropFiles(Value: Boolean);
begin
  if  AcceptDropFiles <> Value  then
    begin
      FAcceptDropFiles := Value;

      if  HandleAllocated then
        DragAcceptFiles(Handle, FAcceptDropFiles);
    end;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.GetCurPos: TPoint;
var
  SS: integer;
begin
  SS := SelStart;
  Result.Y:= SendMessage(Handle, EM_EXLINEFROMCHAR, 0, SS);
  Result.X:= (SS - SendMessage(Handle, EM_LINEINDEX, Result.Y, 0));
  Inc(Result.Y);
  Inc(Result.X);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetCurPos(const Value: TPoint);
begin
//
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.DefineProperties(Filer: TFiler);
begin
  inherited; { allow base classes to define properties }
  Filer.DefineProperty('RichStorageIndex', LoadStorageIndexProperty, nil, false);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.LoadStorageIndexProperty(Reader: TReader);
begin
  RichStorageItem:= Reader.ReadInteger;
end;

{-----------------------------------------------------------------------------}
procedure TLMDCustomRichEdit.MarkUpParse(aStart, aEnd: Integer);
begin
  FForcedChange:= false;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.Change;
begin
  inherited;
  UpdateRuler;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.Loaded;
begin
  inherited;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.BeforeSave(aStream : TStream);
var
  tmpStr        : string;
//  OldSelStart   : LongInt;
//  OldSelLength  : LongInt;
begin
  if FRecreateInProcess then Exit;

//  if Assigned(FOnBeforeSave) then
//    FOnBeforeSave(self);

  FTextEmpty := (Text = '');
  //FRangeManager.Save(tmpStr);

  aStream.WriteBuffer(PChar(tmpStr)^, Length(tmpStr));

end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.BeforeLoad(aStream : TStream);
//var
//  PosFrom       : Longint;
//  PosTo         : Longint;
//  OldPos        : LongInt;
//  tmpStr        : TStringStream;
//  OpenTag       : boolean;
//  CloseTag      : boolean;

(*  function FindTag(aTag : string) : boolean;
  var
    Buf         : string;
    tmpPos      : LongInt;
  begin
    result := False;
    tmpPos := aStream.Position;
    while aStream.Position < aStream.Size do
      begin
        tmpPos := aStream.Position;
        SetString(Buf, nil, Length(aTag));
        aStream.Read(PChar(Buf)^, Length(aTag));
        Result := AnsiSameText(aTag, Buf);
        if result then
          Break
        else
          aStream.Position := tmpPos + 1;
      end;
    if not result then
      aStream.Position := tmpPos + 1
    else
      aStream.Position := tmpPos;
  end;*)

begin
(*  tmpStr := TStringStream.Create('');
  PosFrom := aStream.Position;
  if FindTag('<ranges>') then
    begin
      PosTo := aStream.Position;
      aStream.Position := PosTo + 8;
      PosFrom := aStream.Position;
      if FindTag('<\ranges>') then
        begin
          PosTo := aStream.Position;
          tmpStr.Position := 0; tmpStr.Size := 0;
          aStream.Position := PosFrom;
          if PosTo > PosFrom then
            begin
              tmpStr.CopyFrom(aStream, PosTo - PosFrom);
              //FRangeManager.Load(pchar(tmpStr.DataString));
            end;
          PosFrom := PosTo + 9;
        end;
    end;
  aStream.Position := PosFrom;
  tmpStr.Free;*)
  ;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.AfterLoad;
//var
//  tmpStr        : string;
//  OldSelStart   : LongInt;
//  OldSelLength  : LongInt;
//  hPos          : integer;
//  hLength       : integer;
  //bCancel        : Boolean;
begin
  if FRecreateInProcess then Exit;
  {bCancel:=False;
  if assigned(FOnAfterLoad) then
    FOnAfterLoad(self, bCancel);
  if bCancel then exit;}
  //OldSelStart := SelStart;
  //OldSelLength := SelLength;

  //FRangeManager.ForceChanges := True;
  (*tmpStr := lines.Text;
  hPos := pos('<ranges>', tmpStr);
  if hPos <> 0 then
  begin
    hLength := pos('<\ranges>', tmpStr);
    if hLength <> 0 then
    begin
      hLength := hLength - hPos + 9;
      SelStart := hPos-1;
      SelLength := hLength;
      ClearSelection;

      tmpStr := copy(tmpStr, hPos, hLength);
      //FRangeManager.Load(pchar(tmpStr));
    end;
  end;*)
  //FRangeManager.ForceChanges := False;

  //SelStart := OldSelStart - FHeaderSize;
  //SelLength := OldSelLength;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.AfterSave;
var
  //OldSelStart   : LongInt;
  //OldSelLength  : LongInt;
  bCancel        : Boolean;
begin
  if FRecreateInProcess then Exit;

  bCancel:=False;
  if assigned(FOnAfterSave) then
    FOnAfterSave(self, bCancel);
  if bCancel then exit;

  if FTextEmpty then
    begin
      SelectAll;
      ClearSelection;
    end;
end;

procedure TLMDCustomRichEdit.SetMeasurement(const Value: TLMDMeasurement);
begin
  if Measurement <> Value then
    begin
      FMeasurement:= Value;
      PageMargins.Units:= Value;
      PageRect.Units:= Value;

      if Assigned(FRuler) then
        FRuler.Measurement := Measurement;
    end;
end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.GetOnRulerTabCreate: TLMDRTFRulerEvent;
begin
  if Assigned(FRuler) then
    result:= FRuler.OnRulerTabCreate
  else
    result:= nil;
end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.GetOnRulerTabChange: TLMDRTFRulerEvent;
begin
  if Assigned(FRuler) then
    result:= FRuler.OnRulerTabChange
  else
    result:= nil;
end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.GetOnRulerTabDestroy: TLMDRTFRulerEvent;
begin
  if Assigned(FRuler) then
    result:= FRuler.OnRulerTabDestroy
  else
    result:= nil;
end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.GetOnRulerFirstIdentChange: TLMDRTFRulerEvent;
begin
  if Assigned(FRuler) then
    result:= FRuler.OnRulerFirstIdentChange
  else
    result:= nil;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.GetOnRulerLeftIdentChange: TLMDRTFRulerEvent;
begin
  if Assigned(FRuler) then
    result:= FRuler.OnRulerLeftIdentChange
  else
    result:= nil;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.GetOnRulerRightIdentChange: TLMDRTFRulerEvent;
begin
  if Assigned(FRuler) then
    result:= FRuler.OnRulerRightIdentChange
  else
    result:= nil;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetOnRulerTabCreate(Value: TLMDRTFRulerEvent);
begin
  if Assigned(FRuler) then
    FRuler.OnRulerTabCreate:= Value;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetOnRulerTabChange(Value: TLMDRTFRulerEvent);
begin
  if Assigned(FRuler) then
    FRuler.OnRulerTabChange:= Value;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetOnRulerTabDestroy(Value: TLMDRTFRulerEvent);
begin
  if Assigned(FRuler) then
    FRuler.OnRulerTabDestroy:= Value;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetOnRulerFirstIdentChange(Value:
  TLMDRTFRulerEvent);
begin
  if Assigned(FRuler) then
    FRuler.OnRulerFirstIdentChange:= Value;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetOnRulerLeftIdentChange(Value:
  TLMDRTFRulerEvent);
begin
  if Assigned(FRuler) then
    FRuler.OnRulerLeftIdentChange:= Value;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetOnRulerRightIdentChange(Value:
  TLMDRTFRulerEvent);
begin
  if Assigned(FRuler) then
    FRuler.OnRulerRightIdentChange:= Value;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if Assigned(FRuler) then
    begin
      FRuler.Parent:= AParent;
      if Assigned(FRuler.Parent)  then FPageMargins.DoChange;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.ChangeMargins(Sender: TObject);
begin
  //<-- VB Apr 2008
  //HandleAllocated check removed because:
  //1) Setting margins in FormCreate doesn't work with this check;
  //2) Handle is allocated in SetEditRect
  //-->
  if {HandleAllocated and} Assigned(Parent) then
    begin
      GetPrinterPageParams(FPrinterPageWidth, FTempMargins);
      FTempMargins.OnChange := nil;
      with FTempMargins do
        inc(FPrinterPageWidth, LMDToPixelsX(Left + Right, Units));
      with FPageMargins do
        dec(FPrinterPageWidth, LMDToPixelsX(Left + Right, Units));
      SetEditRect;
      SetRulerMeasurement;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.UpdateRuler;
var
  Left, First, Right: integer;
begin
  if not Assigned(FRuler) then Exit;

  Paragraph.GetIndents(Left, First, Right);
  FRuler.SetIndents(Left, First, Right);
{
  FRuler.IndentLeft:= Left;
  FRuler.IndentFirst:= First;
  FRuler.IndentRight:= Right;
}
  FRuler.CreateTabs;
  exit;

//  SetRulerMeasurement;

  if FRichEditMode = edModeAppOnly then
    begin
      FRuler.IndentFirst:= Paragraph.FirstIndent;
      FRuler.IndentLeft:= Paragraph.FirstIndent + Paragraph.LeftIndent;
      FRuler.IndentRight:= Paragraph.RightIndent;
    end
  else
    begin
      FRuler.IndentFirst:= Round(Paragraph.FirstIndent + PageMargins.Left);
      FRuler.IndentLeft:= Round(Paragraph.FirstIndent + Paragraph.LeftIndent +
          PageMargins.Left);
      FRuler.IndentRight:= Round(PageMargins.Right + Paragraph.RightIndent);
    end;

end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetRulerMeasurement;
begin
  if not Assigned(FRuler) then Exit;

  if FRichEditMode = edModeAppOnly then
    begin
      FRuler.MarginLeft:= 0;
      FRuler.MarginRight:= 0;
    end
  else
    case Measurement of
      unPoints:
        begin
          FRuler.MarginLeft:= Round(PageMargins.Left);
          FRuler.MarginRight:= Round(PageMargins.Right);
        end;
      unInches:
        begin
          FRuler.MarginLeft:= Round(LMDInchesToPoints(PageMargins.Left));
          FRuler.MarginRight:= Round(LMDInchesToPoints(PageMargins.Right));
        end;
      unMillimeters:
        begin
          FRuler.MarginLeft:= Round(LMDMillimetersToPoints(PageMargins.Left));
          FRuler.MarginRight:= Round(LMDMillimetersToPoints(PageMargins.Right));
        end;
    end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.SetTypographyOptions(const Value : TLMDRichTypographyOptions);
begin
  SendMessage(Handle, EM_SETTYPOGRAPHYOPTIONS, TO_ADVANCEDTYPOGRAPHY, not TO_ADVANCEDTYPOGRAPHY);
  SendMessage(Handle, EM_SETTYPOGRAPHYOPTIONS, TO_SIMPLELINEBREAK, not TO_SIMPLELINEBREAK);

  if Value = toAdvanced then
    SendMessage(Handle, EM_SETTYPOGRAPHYOPTIONS, TO_ADVANCEDTYPOGRAPHY, TO_ADVANCEDTYPOGRAPHY)
  else
    SendMessage(Handle, EM_SETTYPOGRAPHYOPTIONS, TO_SIMPLELINEBREAK, TO_SIMPLELINEBREAK);
end;

{ ------------------------------------------------------------------------- }
function TLMDCustomRichEdit.GetTypographyOptions : TLMDRichTypographyOptions;
begin
  result := toSimple;
  case SendMessage(Handle, EM_GETTYPOGRAPHYOPTIONS, 0, 0) of
  TO_ADVANCEDTYPOGRAPHY : result := toAdvanced;
    TO_SIMPLELINEBREAK : result := toSimple;
  end;
end;

{ ------------------------------------------------------------------------- }

function TLMDCustomRichEdit.GetTopLineIndex: Integer;
begin
  Result := Perform(EM_GETFIRSTVISIBLELINE, 0, 0);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetTopLineIndex(Value: Integer);
var
  CurLine: integer;
begin
  CurLine := Perform(EM_GETFIRSTVISIBLELINE, 0, 0);
  if  CurLine <> Value  then
    begin
      ScrollByLines(Value - CurLine);
      SelStart := Perform(EM_LINEINDEX, Value, 0);
      SelLength := 0;
    end;
end;

{ ------------------------------------------------------------------------- }

// scrolls delta lines
procedure TLMDCustomRichEdit.ScrollByLines(Delta:Integer);
begin
  Perform(EM_LINESCROLL, 0, Delta);
end;

{ ------------------------------------------------------------------------- }

// synchronizes TopLineIndex value in current control with the one in aControl.
procedure TLMDCustomRichEdit.SynchronizeLines(aControl:TLMDCustomRichEdit);
begin
  ScrollByLines(aControl.TopLineIndex - TopLineIndex);
end;

{ ------------------------------------------------------------------------- }
procedure TLMDCustomRichEdit.WMKeyDown(var Message: TWMKey);
var
  Frm: TCustomForm;
begin
  with Message do
    if (CharCode = VK_ESCAPE) and (KeyDataToShiftState(KeyData) = []) then
      begin
        Frm := GetParentForm(Self);

        if  Assigned(Frm) then
          Frm.Perform(CM_DIALOGKEY, CharCode, KeyData)
        else
          inherited ;
      end
    else
    if PlainText then
      begin
        if (CharCode = VK_INSERT) and (KeyDataToShiftState(KeyData) = [ssShift])
            or (CharCode = ord('V')) and (KeyDataToShiftState(KeyData) = [ssCtrl])  then
          begin
            Result := 1;
            PastePlainText;
          end
        else
          inherited
      end
    else
      inherited;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetSelRange(SelStart, SelLength: integer);
var
  CharRange: TCharRange;
begin
  if HandleAllocated then
    begin
      CharRange.cpMin := SelStart;
      CharRange.cpMax := SelStart + SelLength;
    Perform(EM_EXSETSEL, 0, TLMDPtrInt(@CharRange));
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetRTFText(const aValue: string);
var
  Stream: TStringStream;
begin
  Stream := TStringStream.Create(aValue);
  Lines.BeginUpdate;
  try
    Stream.Position := 0;
    Lines.Clear;
    Lines.LoadFromStream(Stream);
  finally
    Stream.Free;
    Lines.EndUpdate;
  end;
end;

{ ------------------------------------------------------------------------- }

function  TLMDCustomRichEdit.GetRTFText: string;
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;

  try
    Lines.SaveToStream(Stream);
    SetString(Result, PAnsiChar(Stream.Memory), Stream.Size);
  finally
    Stream.Free;
  end;
end;

function  TLMDCustomRichEdit.GetReadOnly: Boolean;
begin
  Result := inherited ReadOnly;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetReadOnly(aValue: Boolean);
begin
  inherited ReadOnly := aValue;

  if aValue then
    begin
//      AllowInplace := False;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDCustomRichEdit.SetAllowInPlace(aValue: Boolean);
begin
  if  aValue <> FAllowInPlace  then
    begin
      FAllowInPlace := aValue;
    end;
end;

{ ********************* TLMDRichCustomComboBox ********************************}
{ ----------------------------- private -------------------------------------- }
procedure TLMDRichCustomComboBox.SetControl(const Value: TLMDCustomRichEdit);
begin
  if FControl <> nil then
    FControl.UnRegisterCombo(self);
  if Value <> FControl then
    begin
      FControl:= Value;
      if Value <> nil then
        begin
          Value.RegisterCombo(self);
          Value.FreeNotification(Self);
          UpdateInfo;
        end;
    end;
end;

{ --------------------------- protected -------------------------------------- }

procedure TLMDRichCustomComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer);

begin
  with Message do
    case Msg of
      WM_CHAR:
        with TWMKey(Message) do
        begin
            case CharCode of
              VK_RETURN: Exit;
              VK_ESCAPE:UpdateInfo;
            end;
          end;
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichCustomComboBox.KeyDown (var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) then ChangeSettings;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichCustomComboBox.WndProc(var Message: TMessage);
begin
  with Message do
    case Msg of
      WM_CHAR:
        if TWMKey(Message).CharCode = VK_ESCAPE then UpdateInfo;
        end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichCustomComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FControl) then RichEditControl:= nil;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDRichCustomComboBox.Create(AOwner: TComponent);
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichCustomComboBox.UpdateInfo;
begin
end;

{ ************************ TRichEditStrings ***********************************}
procedure TRichEditStrings.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
    if Filer.Ancestor <> nil then
    begin
      Result := True;
      if Filer.Ancestor is TStrings then
        Result := not Equals(TStrings(Filer.Ancestor))
    end
    else Result := Count > 0;
  end;

begin
  Filer.DefineProperty('Strings', ReadData, WriteData, DoWrite);
end;

procedure TRichEditStrings.ReadData(Reader: TReader);
var
  M: TStringStream;
  S: TStrings;
  LS: string;
begin
  M:= TStringStream.Create('');
  S:= TStringList.Create;
  try
    Reader.ReadListBegin;
//    while not Reader.EndOfList do M.WriteString(Reader.ReadString);
    while not Reader.EndOfList do
    begin
      LS := Reader.ReadString;
      S.Add(LS);
    end;
    Reader.ReadListEnd;
    S.SaveToStream(M);
    M.Position:= 0;
    LoadFromStream(M);
  finally
    M.Free;
    S.Free;
  end;
end;

procedure TRichEditStrings.WriteData(Writer: TWriter);
var
  I: Integer;
  M: TStringStream;
  S: TStrings;
begin
  M:= TStringStream.Create('');
  S:= TStringList.Create;
  try
    SaveToStream(M);

    M.Position:= 0;
    S.LoadFromStream(M);
    Writer.WriteListBegin;
    for I := 0 to S.Count - 1 do Writer.WriteString(S[I]);
    Writer.WriteListEnd;
  finally
    M.Free;
    S.Free;
  end;
end;

var
  VerEditor     : TRichEdit;
  VerForm       : TForm;

initialization

  if FRichEditModule = 0 then
    begin
      RichEditVer:= -1;
      FRichEditModule := LoadLibrary(RichEditModuleName);

      if FRichEditModule = 0 then
        begin
          FRichEditModule := LoadLibrary('RICHED32.DLL');
          if FRichEditModule <> 0 then
            RichEditVer:= 1;
        end
      else
        begin
          VerForm := TForm.Create(nil);
          VerEditor := TRichEdit.Create(nil);
          VerEditor.Parent := VerForm;
          try
            if SendMessage(VerEditor.Handle, EM_SETTYPOGRAPHYOPTIONS, TO_SIMPLELINEBREAK, TO_SIMPLELINEBREAK ) = 0
            then
              RichEditVer:= 2
            else
              RichEditVer:= 3;
          finally
            VerEditor.Free;
            VerForm.Free;
          end;
        end
    end;
  {$HINTS OFF}
  CFEmbeddedObject:= RegisterClipboardFormat(CF_EMBEDDEDOBJECT);
  CFLinkSource:= RegisterClipboardFormat(CF_LINKSOURCE);
  CFRTF:= RegisterClipboardFormat(CF_RTF);
  CFRTFNoObjs:= RegisterClipboardFormat(CF_RTFNOOBJS);

finalization

  if FRichEditModule <> 0 then FreeLibrary(FRichEditModule);
end.
