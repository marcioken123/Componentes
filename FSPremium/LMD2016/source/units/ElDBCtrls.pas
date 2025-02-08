unit ElDBCtrls;
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

ElDBCtrls unit
--------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
   Classes, Forms, Windows, Controls, StdCtrls, Graphics, Messages, Dialogs,
   Menus, DB, DBCtrls, ImgList, Types, SysUtils,
   LMDThemes, UxTheme, Themes,
   LMDDebugUnit, LMDTypes, LMDUnicode, LMDUnicodeStrings, LMDUtils,
   LMDGlyphs, LMDProcs, LMDGraph, LMDElDBConst,
   ElPanel, ElToolbar, ElPopBtn, ElACtrls, ElMaskEdit, ElVCLUtils,
   ElCheckCtl, ElCheckItemGrp, ElPromptDlg, ElEdits;

type
  TElDBEdit = class(TCustomElMaskEdit)
  private
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    FNullValueKey: TShortCut;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure ResetMaxLength;
    procedure DataChange(Sender: TObject);
    procedure ActiveChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
 procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

    procedure SetFocused(Value: Boolean);
    function GetReadOnly: Boolean;
    procedure SetReadOnly(Value: Boolean);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMUndo(var Message: TMessage); message WM_UNDO;
  protected

    procedure Change; override;
    function EditCanModify: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Reset; override;
  public
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
  published
    property NullValueKey:TShortCut read FNullValueKey write FNullValueKey default 0;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ValidationMsgString;
    property Validator;
    property OnValidationError;

    property ActiveBorderType;
    property Alignment;
    property Background;
    property Flat;
    property InactiveBorderType;
    property OnMouseEnter;
    property OnMouseLeave;
    property Transparent;
    property UseBackground;
    property BorderSides;
    property HandleDialogKeys;
    property ImageForm;
    property ThemeMode;
    property ThemeGlobalMode;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property Align;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Cursor;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ShowHint;
    property TabOrder;

    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
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
    property OnStartDock;
    property OnStartDrag;
  end;

  TElDBMemo = class(TElAdvancedMemo)
  private
    FAutoDisplay: Boolean;
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    FMemoLoaded: Boolean;
    FNullValueKey: TShortCut;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetAutoDisplay(Value: Boolean);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetReadOnly: Boolean;
    procedure SetFocused(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message
        WM_LBUTTONDBLCLK;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMUndo(var Message: TMessage); message WM_UNDO;
  protected

    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    procedure LoadMemo; virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property NullValueKey:TShortCut read FNullValueKey write FNullValueKey default 0;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property AutoDisplay: Boolean read FAutoDisplay write SetAutoDisplay default
        True;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
  end;

  TElDBCheckBox = class(TElCheckBox)
  private
    FDataLink: TFieldDataLink;
    FValueCheck: TLMDString;
    FValueUncheck: TLMDString;
    FNullValueKey: TShortCut;
    function IsValueCheckedStored: Boolean;
    function IsValueUnCheckedStored: Boolean;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure CMExit(var Message: TCMExit); message CM_EXIT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

    procedure DataChange(Sender: TObject);
    function GetFieldState: TCheckBoxState;
    procedure SetValueCheck(const Value: TLMDString);
    procedure SetValueUncheck(const Value: TLMDString);
    procedure UpdateData(Sender: TObject);
    function ValueMatch(const ValueList, Value: string): Boolean;
  protected
  {$ifdef LMD_UNICODE}
    FUnicodeMode: TElDBUnicodeMode;
  {$endif}

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Toggle; override;
    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    procedure Click; override;
    property Field: TField read GetField;
  published
    property NullValueKey:TShortCut read FNullValueKey write FNullValueKey default 0;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ValueChecked: TLMDString read FValueCheck write SetValueCheck stored IsValueCheckedStored;
    property ValueUnchecked: TLMDString read FValueUncheck write SetValueUncheck stored IsValueUnCheckedStored;
  {$ifdef LMD_UNICODE}
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write FUnicodeMode
        default umFieldType;
  {$endif}
  end;

  TElDBRadioGroup = class(TCustomElRadioGroup)

  private
    FDataLink: TFieldDataLink;
    FOnChange: TNotifyEvent;
    FValue: TLMDString;
    FValues: TLMDStrings;
    FInSetValue: Boolean;
    FNullValueKey: TShortCut;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure DataChange(Sender: TObject);
    function GetButtonValue(Index: Integer): TLMDString;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetItems(Value: TLMDStrings);
    procedure SetReadOnly(Value: Boolean);
    procedure SetValue(Value: TLMDString);
    procedure SetValues(Value: TLMDStrings);
    procedure UpdateData(Sender: TObject);
  protected
  {$ifdef LMD_UNICODE}
    FUnicodeMode: TElDBUnicodeMode;
  {$endif}

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function CanModify: Boolean; override;
    procedure Change; dynamic;
    procedure Click; override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property DataLink: TFieldDataLink read FDataLink;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
    property Value: TLMDString read FValue write SetValue;
  published
    property NullValueKey:TShortCut read FNullValueKey write FNullValueKey default 0;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Values: TLMDStrings read FValues write SetValues;
    property Items write SetItems;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
  {$ifdef LMD_UNICODE}
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write FUnicodeMode
        default umFieldType;
  {$endif}
    property Align;
    property Alignment;

    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    property BorderSides;
    property Caption;
    property CaptionColor;
    property CheckBoxChecked;
    property Color;
    property Columns;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Flat;
    property FlatAlways;
    property Font;
    property Hints;
    property ImageForm;
    property IsHTML;
    property MoneyFlat;
    property MoneyFlatInactiveColor;
    property MoneyFlatActiveColor;
    property MoneyFlatDownColor;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowCheckBox;
    property ShowFocus;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;
    property Visible;
    property ThemeMode;
    property ThemeGlobalMode;

    property CheckSound;
    property SoundMap;
    property Glyph;
    property Images;
    property AlphaForImages;
    property UseCustomGlyphs;
    property UseImageList;

    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;

    property OnContextPopup;

  end;

  TElNavButtonRole = (nbrFirst, nbrPrior, nbrNext, nbrLast,
                      nbrInsert, nbrDelete, nbrEdit, nbrPost,
                      nbrCancel, nbrRefresh,
                      // nbrSetBookmark, nbrGotoBookmark, nbrDeleteBookmark,
                      nbrSearch, nbrSetFilter, nbrRemoveFilter,
                      nbrClear, nbrOpen, nbrClose,
                      nbrFindFirst, nbrFindPrior, nbrFindNext, nbrFindLast, nbrCustom);

  TElDBNavButton = class(TCustomElToolButton)
  protected
    FRole: TElNavButtonRole;

    FCustomAction: Boolean;

    FUseCustomImages: Boolean;
    procedure SetRole(Value: TElNavButtonRole);

    function GetDetails: TThemedElementDetails; override;
    procedure FillStateForDetails(var ADetails: TThemedElementDetails);
    function GetArrowDetails: TThemedElementDetails; override;

    procedure SetUseImageList(newValue : Boolean); override;
    procedure Loaded; override;
    procedure SetImageList(newValue : TCustomImageList); override;
    procedure SetImageIndex(newValue : Integer); override;
    procedure SetUseCustomImage(Value : Boolean);

    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
  public
    procedure AClick(Arrow : boolean); override;
    constructor Create(AOwner : TComponent); override;
  published
    property Role: TElNavButtonRole read FRole write SetRole default nbrCustom;
    property UseCustomImage:Boolean read FUseCustomImages write SetUseCustomImage default False;
    property UseImageList;

    property Wrap;
    property LargeGlyph;
    property NumLargeGlyphs;
    property Glyph;
    property NumGlyphs;
    property OwnerSettings;

    property PullDownMenu;
    property PopupPlace;
    property DisableAutoPopup;
    property Flat;
    property Layout;
    property Margin;
    property Spacing;
    property UseArrow;
    property ShadowFollowsColor;
    property ShowGlyph;
    property ShowText;
    property OnArrowClick;
    property Icon;
    property TextDrawType;
    property ThinFrame;

    property DownSound;
    property UpSound;
    property ClickSound;
    property ArrowClickSound;
    property SoundMap;

    property UseIcon;
    property ImageIndex;
    property OldStyled;
    property Background;
    property DownBackground;
    property BackgroundDrawBorder;
    property ThemeMode;
    property ThemeGlobalMode;
    // VCL properties
    property Caption;
    property Enabled;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;

    property Action;
    property Constraints;

    property OnContextPopup;
    property CustomAction: Boolean read FCustomAction write FCustomAction default false;
  end;

  {$warnings off}
  TElNavDataLink = class;

  TElDBNavigator = class(TElToolbar)

  private
    FDeleteRecordQuestion : string;
    FDataLink : TElNavDataLink;
    function GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    protected
    FConfirmDelete: Boolean;
    FOnSearch: TNotifyEvent;
    FIsToolbar: Boolean;
    FIntImageList: TCustomImageList;
    procedure ActiveChanged;
    procedure DataChanged;
    procedure EditingChanged;
    procedure DoSearch; virtual;
    function GetButtonClass: TElToolButtonClass; override;
    procedure SetIsToolbar(Value: Boolean);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;

    procedure CMControlChange(var Msg : TCMControlChange); message CM_CONTROLCHANGE;

  protected

  public
    constructor Create(AOwner : TComponent); override;
    function FindButtonByRole(Role : TElNavButtonRole): TElDBNavButton;
    function AddButton(Role : TElNavButtonRole): TElDBNavButton;
    procedure AddButtons(const Roles : array of TElNavButtonRole);
    destructor Destroy; override;
    published
    property DeleteRecordQuestion : string read FDeleteRecordQuestion write FDeleteRecordQuestion;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ConfirmDelete: Boolean read FConfirmDelete write FConfirmDelete
        default true;
    property OnSearch: TNotifyEvent read FOnSearch write FOnSearch;
    property IsToolbar: Boolean read FIsToolbar write SetIsToolbar default False;
    property BtnOffsHorz default 0;
    property BtnOffsVert default 0;
    property BevelOuter default bvNone;
    property UseImageList default True;
  end;
  {$warnings on}

  TElNavDataLink = class(TDataLink)
  private
    FNavigator: TElDBNavigator;
  protected
    procedure EditingChanged; override;
    procedure DataSetChanged; override;
    procedure ActiveChanged; override;
  public
    constructor Create(ANav: TElDBNavigator);
    destructor Destroy; override;
  end;

  {$ifdef LMD_UNICODE}
  TElWideDBEdit = class(TCustomElEdit)
  private
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    FNullValueKey: TShortCut;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure ResetMaxLength;
    procedure ActiveChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

    procedure SetFocused(Value: Boolean);
    function GetCReadOnly: Boolean;
    procedure SetCReadOnly(Value: Boolean);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMUndo(var Message: TMessage); message WM_UNDO;
    procedure WMImeStartComposition(var Message : TMessage); message WM_IME_STARTCOMPOSITION;
    function GetDBReadOnlyState: Boolean;
  protected
    FUnicodeMode: TElDBUnicodeMode;
    procedure DataChange(Sender: TObject); virtual;
    procedure DataChangeText;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure Change; override;
    function EditCanModify: Boolean;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Reset;
    procedure WMCommand(var Msg: TWMCommand); message WM_COMMAND;
  public
    procedure CutToClipboard; override;
    procedure PasteFromClipboard; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
  published
    property NullValueKey:TShortCut read FNullValueKey write FNullValueKey default 0;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetCReadOnly write SetCReadOnly default False;
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write FUnicodeMode
        default umFieldType;

    property DisplayReadOnlyOptions;
    property AlignBottom;
    property Multiline;
    property AutoSize;
    property Alignment;
    property Background;
    property BorderSides;
    property CharCase;
    property UseBackground;
    property RightAlignedView;
    property PasswordChar;
    property MaxLength;
    property Transparent;
    property FlatFocusedScrollBars;
    property WantTabs;
    property LeftMargin;
    property RightMargin;
    property TopMargin;
    property BorderStyle;
    property AutoSelect;
    property HandleDialogKeys;
    property HideSelection;
    property TabSpaces;
    property Lines stored false;

    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;

    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;

    property StressShortCut;
    property Text stored false;

    property ImageForm;
    property ActiveBorderType;
    property Flat;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property WordWrap;
    property ScrollBars;

    property VertScrollBarStyles;
    property HorzScrollBarStyles;
    property UseCustomScrollBars;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;

    property Align;

    property Anchors;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
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
    property ThemeMode;
    property ThemeGlobalMode;
    property BiDiMode;
    property Cursor;
    property ImeMode;
    property ImeName;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

  property OnStartDock;
    property OnEndDock;
  property OnContextPopup;
  end;

  TElWideDBMemo = class(TCustomElEdit)

  private
    FNullValueKey: TShortCut;
    FAutoDisplay: Boolean;
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    FMemoLoaded: Boolean;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetAutoDisplay(Value: Boolean);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

    procedure ActiveChange(Sender: TObject);
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetCReadOnly: Boolean;
    procedure SetFocused(Value: Boolean);
    procedure SetCReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message
        WM_LBUTTONDBLCLK;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMUndo(var Message: TMessage); message WM_UNDO;
    procedure WMImeStartComposition(var Message : TMessage); message WM_IME_STARTCOMPOSITION;
    function GetDBReadOnlyState: Boolean;
  protected
    FUnicodeMode: TElDBUnicodeMode;

    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure WMCommand(var Msg: TWMCommand); message WM_COMMAND;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
  public
    procedure CutToClipboard; override;
    procedure PasteFromClipboard; override;
    procedure LoadMemo; virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property NullValueKey:TShortCut read FNullValueKey write FNullValueKey default 0;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property AutoDisplay: Boolean read FAutoDisplay write SetAutoDisplay default
        True;
    property ReadOnly: Boolean read GetCReadOnly write SetCReadOnly default False;
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write FUnicodeMode
        default umFieldType;

    property DisplayReadOnlyOptions;
    property AutoSize;
    property Alignment;
    property Background;
    property BorderSides;
    property CharCase;
    property UseBackground;
    property RightAlignedView;
    property PasswordChar;
    property MaxLength;
    property Transparent;
    property FlatFocusedScrollBars;
    property WantTabs;
    property LeftMargin;
    property RightMargin;
    property TopMargin;
    property BorderStyle;
    property AutoSelect;
    property HandleDialogKeys;
    property HideSelection;
    property TabSpaces;
    property Lines stored false;

    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;

    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;

    property StressShortCut;
    property Text stored false;

    property ImageForm;
    property ActiveBorderType;
    property Flat;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property WordWrap;
    property ScrollBars;

    property VertScrollBarStyles;
    property HorzScrollBarStyles;
    property UseCustomScrollBars;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;

    property Align;

    property Anchors;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
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
    property ThemeMode;
    property ThemeGlobalMode;
    property BiDiMode;
    property Cursor;
    property ImeMode;
    property ImeName;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

  property OnStartDock;
    property OnEndDock;
  property OnContextPopup;
  end;
  {$endif}

function DBCheckReadOnlyState(FDataLink: TFieldDataLink): Boolean;
function ChangeBiDiModeAlignment(Alignment: TAlignment): TAlignment;

var
  ElDBNavButtonsHint :array[Low(TElNavButtonRole)..Pred(nbrCustom)] of PResStringRec =
  (
//  nbrFirst, nbrPrior, nbrNext, nbrLast,
    @SLMDNbrFirst, @SLMDNbrPrior, @SLMDNbrNext, @SLMDNbrLast,
//  nbrInsert, nbrDelete, nbrEdit, nbrPost,
    @SLMDNbrInsert, @SLMDNbrDelete, @SLMDNbrEdit, @SLMDNbrPost,
//  nbrCancel, nbrRefresh,
    @SLMDNbrCancel, @SLMDNbrRefresh,
//  nbrSearch, nbrSetFilter, nbrRemoveFilter
    @SLMDNbrSearch, @SLMDNbrSetFilter, @SLMDNbrRemoveFilter,
//  nbrClear, nbrOpen, nbrClose,
    @SLMDNbrClear, @SLMDNbrOpen, @SLMDNbrClose,
//  nbrFindFirst, nbrFindPrior, nbrFindNext, nbrFindLast,
    @SLMDNbrFindFirst, @SLMDNbrFindPrior, @SLMDNbrFindNext, @SLMDNbrFindLast
  );

implementation

var FGlyphBitmap : TBitmap;

function ChangeBiDiModeAlignment(Alignment: TAlignment): TAlignment;
begin
  case Alignment of
    taLeftJustify:  Result := taRightJustify;
    taRightJustify: Result := taLeftJustify;
  else
    Result := Alignment;
  end;
end;

function TElDBEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TElDBEdit.SetDataField(const Value: string);
begin
  if not (csDesigning in ComponentState) then
    ResetMaxLength;
  FDataLink.FieldName := Value;
end;

procedure TElDBEdit.SetDataSource(Value: TDataSource);
begin
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TElDBEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TElDBEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

function TElDBEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TElDBEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

function TElDBEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TElDBEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (not ReadOnly) and (FNullValueKey <> 0) and Assigned(FDataLink.DataSet) and Assigned(FDataLink.Field)
     and ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert]))
     and (FDataLink.DataSet.Active)
     and (FNullValueKey = ShortCut(Key,Shift)) then
  begin
    if Assigned(FDataLink.Field) then
    begin
      FDataLink.DataSet.Edit;
      FDataLink.Field.Clear;
    end;
    Key := 0;
  end;
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
end;

procedure TElDBEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (AnsiChar(Key) in [#32..#255]) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
  end;
end;

procedure TElDBEdit.Loaded;
begin
  inherited Loaded;
  ResetMaxLength;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TElDBEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBEdit.ResetMaxLength;
var
  F: TField;
begin
  if (MaxLength > 0) and Assigned(DataSource) and Assigned(DataSource.DataSet) then
  begin
    F := DataSource.DataSet.FindField(DataField);
    if Assigned(F) and (F.DataType in [ftString, ftWideString]) and (F.Size = MaxLength) then
      MaxLength := 0;
  end;
end;

procedure TElDBEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if Alignment <> FDataLink.Field.Alignment then
    begin
      Text := '';  {forces update}
      Alignment := FDataLink.Field.Alignment;
    end;
    EditMask := FDataLink.Field.EditMask;
    if not (csDesigning in ComponentState) then
    begin
      if (FDataLink.Field.DataType in [ftString, ftWideString]) and (MaxLength = 0) then
        MaxLength := FDataLink.Field.Size;
    end;
    if Focused and FDataLink.CanModify then
    begin
      Text := FDataLink.Field.Text
    end
    else
    begin
      EditText := FDataLink.Field.DisplayText;
      if FDataLink.Editing then
        Modified := True;
    end;
  end else
  begin
    Alignment := taLeftJustify;
    EditMask := '';
    if csDesigning in ComponentState then
      EditText := Name
    else
      EditText := '';
  end;
end;

procedure TElDBEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

constructor TElDBEdit.Create(AOwner : TComponent);
begin
  inherited;
  inherited ReadOnly := true;
  ControlStyle := ControlStyle - [csSetCaption];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnActiveChange := ActiveChange;
end;

destructor TElDBEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited;
end;

procedure TElDBEdit.ActiveChange(Sender: TObject);
begin
  ResetMaxLength;
end;

procedure TElDBEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
  Refresh;
end;

procedure TElDBEdit.UpdateData(Sender: TObject);
begin
  ValidateEdit;
  FDataLink.Field.Text := Text;
end;

procedure TElDBEdit.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
end;

procedure TElDBEdit.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  SetFocused(False);
  CheckCursor;
  DoExit;
end;

procedure TElDBEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := TLMDPtrInt(FDataLink);
end;

procedure TElDBEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (Alignment <> taLeftJustify) and not IsMasked then Invalidate;
    FDataLink.Reset;
  end;
end;

function TElDBEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

procedure TElDBEdit.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElDBEdit.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElDBEdit.WMUndo(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

function TElDBMemo.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBMemo.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBMemo.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TElDBMemo.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TElDBMemo.SetDataSource(Value: TDataSource);
begin
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TElDBMemo.SetAutoDisplay(Value: Boolean);
begin
  if FAutoDisplay <> Value then
  begin
    FAutoDisplay := Value;
    if Value then LoadMemo;
  end;
end;

procedure TElDBMemo.LoadMemo;
begin
  if (not FMemoLoaded) and Assigned(FDataLink.Field) then
  begin
    if FDataLink.Field.IsBlob or (FDataLink.Field.DataType = ftWideString) or
       (FDataLink.Field.DataType = ftString)
    then
    begin
      try
        Lines.Text := FDataLink.Field.AsString;
        FMemoLoaded := True;
      except
        { Memo too large }
        on E:EInvalidOperation do
          Lines.Text := Format('(%s)', [E.Message]);
      end;
      EditingChange(Self);
    end
    else
    begin
      if FFocused and FDataLink.CanModify then
        Text := FDataLink.Field.Text
      else
        Text := FDataLink.Field.DisplayText;
      FMemoLoaded := True;
      //???:
      //EditingChange(Self);
    end;
  end;
end;

constructor TElDBMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  FAutoDisplay := True;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
end;

destructor TElDBMemo.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TElDBMemo.Change;
begin
  if FMemoLoaded then FDataLink.Modified;
  FMemoLoaded := True;
  inherited Change;
end;

procedure TElDBMemo.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
  if SysLocale.FarEast and FDataLink.CanModify then
    inherited ReadOnly := False;
end;

procedure TElDBMemo.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  SetFocused(False);
  inherited;
end;

procedure TElDBMemo.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(FDataLink);
end;

procedure TElDBMemo.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if FAutoDisplay or (FDataLink.Editing and FMemoLoaded) then
    begin
      FMemoLoaded := False;
      LoadMemo;
    end
    else
    begin
      Text := Format('(%s)', [FDataLink.Field.DisplayLabel]);
      FMemoLoaded := False;
    end;
  end
  else
  begin
    if csDesigning in ComponentState then
      Text := Name
    else
      Text := '';
    FMemoLoaded := False;
  end;
  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME);
end;

procedure TElDBMemo.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not (FDataLink.Editing and FMemoLoaded);
  Refresh;
end;

function TElDBMemo.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TElDBMemo.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBMemo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (not ReadOnly) and (FNullValueKey <> 0) and Assigned(FDataLink.DataSet) and Assigned(FDataLink.Field)
     and ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert]))
     and (FDataLink.DataSet.Active)
     and (FNullValueKey = ShortCut(Key,Shift)) then
  begin
    if Assigned(FDataLink.Field) then
    begin
      FDataLink.DataSet.Edit;
      FDataLink.Field.Clear;
    end;
    Key := 0;
  end;
  if FMemoLoaded then
  begin
    if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
      FDataLink.Edit;
  end;
end;

procedure TElDBMemo.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if FMemoLoaded then
  begin
    if (AnsiChar(Key) in [#32..#255]) and (FDataLink.Field <> nil) and
      not FDataLink.Field.IsValidChar(Key) then
    begin
      MessageBeep(0);
      Key := #0;
    end;
    case Key of
      ^H, ^I, ^J, ^M, ^V, ^X, #32..#255:
        FDataLink.Edit;
      #27:
        FDataLink.Reset;
    end;
  end else
  begin
    if Key = #13 then LoadMemo;
    Key := #0;
  end;
end;

procedure TElDBMemo.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TElDBMemo.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBMemo.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if not Assigned(FDataLink.Field) or not FDataLink.Field.IsBlob then
      FDataLink.Reset;
  end;
end;

procedure TElDBMemo.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TElDBMemo.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TElDBMemo.UpdateData(Sender: TObject);
begin
  FDataLink.Field.AsString := Text;
end;

function TElDBMemo.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TElDBMemo.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElDBMemo.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if not FMemoLoaded then LoadMemo else inherited;
end;

procedure TElDBMemo.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElDBMemo.WMUndo(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

function TElDBCheckBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBCheckBox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBCheckBox.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TElDBCheckBox.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBCheckBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TElDBCheckBox.SetDataSource(Value: TDataSource);
begin
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TElDBCheckBox.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

constructor TElDBCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  State := cbUnchecked;
  FValueCheck := 'True';
  FValueUncheck := 'False';
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

destructor TElDBCheckBox.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TElDBCheckBox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TElDBCheckBox.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(FDataLink);
end;

procedure TElDBCheckBox.DataChange(Sender: TObject);
begin
  State := GetFieldState;
end;

function TElDBCheckBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TElDBCheckBox.GetFieldState: TCheckBoxState;
var
  Text: TLMDString;
begin
  if FDatalink.Field <> nil then
    if FDataLink.Field.IsNull then
//      Result := cbGrayed
      Result := cbUnchecked
    else
    if FDataLink.Field.DataType = ftBoolean then
      if FDataLink.Field.AsBoolean then
        Result := cbChecked
      else
        Result := cbUnchecked
    else
    begin
      Result := cbGrayed;
      Text := FDataLink.Field.Text;
      if ValueMatch(FValueCheck, Text) then
        Result := cbChecked
      else
      if ValueMatch(FValueUncheck, Text) then
        Result := cbUnchecked;
    end
  else
    Result := cbUnchecked;
end;

procedure TElDBCheckBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #8, ' ':
      FDataLink.Edit;
    #27:
      FDataLink.Reset;
  end;
end;

procedure TElDBCheckBox.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBCheckBox.SetValueCheck(const Value: TLMDString);
begin
  FValueCheck := Value;
  DataChange(Self);
end;

procedure TElDBCheckBox.SetValueUncheck(const Value: TLMDString);
begin
  FValueUncheck := Value;
  DataChange(Self);
end;

procedure TElDBCheckBox.Toggle;
begin
  if FDataLink.Edit then
  begin
    inherited Toggle;
    FDataLink.Modified;
  end;
end;

function TElDBCheckBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TElDBCheckBox.UpdateData(Sender: TObject);
var
  S: TLMDString;
{$ifdef LMD_UNICODE}
  st : AnsiString;
{$endif}
begin
  if State = cbGrayed then
    FDataLink.Field.Clear
  else
  if FDataLink.Field.DataType = ftBoolean then
    FDataLink.Field.AsBoolean := Checked
  else
  begin
    if Checked then
      S := FValueCheck
    else
      S := FValueUncheck;
    {$ifdef LMD_UNICODE}
    if (UnicodeMode = umForceUTF8) or ((FDataLink.Field.DataType <> ftWideString) and (UnicodeMode = umForceUnicode)) and
       (LMDConvertUTF16toUTF8(S, st, strictConversion, false) <> sourceIllegal)
    then
      FDataLink.Field.Text := String(st)
    else
    begin
      if (FDataLink.Field.DataType = ftWideString) and (not FDataLink.Field.IsNull) then
        FDataLink.Field.Value := S
      else
      FDataLink.Field.Text := S;
    end;
    {$else}
        FDataLink.Field.Value := S;
    {$endif}
  end;
end;

function TElDBCheckBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

function TElDBCheckBox.ValueMatch(const ValueList, Value: string): Boolean;
var
  Pos: Integer;
begin
  Result := False;
  Pos := 1;
  while Pos <= Length(ValueList) do
    if AnsiCompareText(ExtractFieldName(ValueList, Pos), Value) = 0 then
    begin
      Result := True;
      Break;
    end;
end;

procedure TElDBCheckBox.Click;
begin
  if FDataLink.CanModify then
  begin
    FDataLink.Edit;
    inherited Click;
    FDataLink.Modified;
  end;
end;

constructor TElDBRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FValues := TLMDMemoryStrings.Create;
end;

destructor TElDBRadioGroup.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FValues.Free;
  inherited Destroy;
end;

function TElDBRadioGroup.CanModify: Boolean;
begin
  //if not FInSetValue then
    Result := FDataLink.Edit;
end;

procedure TElDBRadioGroup.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TElDBRadioGroup.Click;
begin
  if not FInSetValue then
  begin
    inherited Click;
    if ItemIndex >= 0 then Value := GetButtonValue(ItemIndex);
    if FDataLink.Editing then FDataLink.Modified;
  end;
end;

procedure TElDBRadioGroup.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    if ItemIndex >= 0 then
      TRadioButton(Controls[ItemIndex]).SetFocus
    else
      TRadioButton(Controls[0]).SetFocus;
    raise;
  end;
  inherited;
end;

procedure TElDBRadioGroup.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin

    {$ifdef LMD_UNICODE}
    if (FDataLink.Field.DataType = ftWideString) and (not FDataLink.Field.IsNull) then
      Value := FDataLink.Field.Value
    else
    {$endif}
      Value := FDataLink.Field.DisplayText;
  end
  else
    Value := '';
end;

function TElDBRadioGroup.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (DataLink <> nil) and
    DataLink.ExecuteAction(Action);
end;

function TElDBRadioGroup.GetButtonValue(Index: Integer): TLMDString;
begin
  if (Index < FValues.Count) and (FValues[Index] <> '') then
    Result := FValues[Index]
  else
  if Index < Items.Count then
    Result := Items[Index]
  else
    Result := '';
end;

function TElDBRadioGroup.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBRadioGroup.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBRadioGroup.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TElDBRadioGroup.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBRadioGroup.KeyPress(var Key: Char);
begin
  case Key of
    #8, ' ': FDataLink.Edit;
    #27: FDataLink.Reset;
  end;
  inherited KeyPress(Key);
end;

procedure TElDBRadioGroup.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBRadioGroup.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TElDBRadioGroup.SetDataSource(Value: TDataSource);
begin
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TElDBRadioGroup.SetItems(Value: TLMDStrings);
begin
  Items.Assign(Value);
  DataChange(Self);
end;

procedure TElDBRadioGroup.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

procedure TElDBRadioGroup.SetValue(Value: TLMDString);
var
  I, Index: Integer;
begin
  if FValue <> Value then
  begin
    FInSetValue := True;
    try
      Index := -1;
      for I := 0 to Items.Count - 1 do
        if Value = GetButtonValue(I) then
        begin
          Index := I;
          Break;
        end;
      ItemIndex := Index;
    finally
      FInSetValue := False;
    end;
    FValue := Value;
    Change;
  end;
end;

procedure TElDBRadioGroup.SetValues(Value: TLMDStrings);
begin
  FValues.Assign(Value);
  DataChange(Self);
end;

function TElDBRadioGroup.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (DataLink <> nil) and
    DataLink.UpdateAction(Action);
end;

procedure TElDBRadioGroup.UpdateData(Sender: TObject);
{$ifdef LMD_UNICODE}
var st : AnsiString;
{$endif}
begin
  if FDataLink.Field <> nil then
  begin
    {$ifdef LMD_UNICODE}
    if ((UnicodeMode = umForceUTF8) or ((FDataLink.Field.DataType <> ftWideString) and (UnicodeMode = umForceUnicode))) and
       (LMDConvertUTF16toUTF8(Value, st, strictConversion, false) <> sourceIllegal)
    then
      FDataLink.Field.Text := String(st)
    else
    begin
      if (FDataLink.Field.DataType = ftWideString) {?}and (not FDataLink.Field.IsNull) then
        FDataLink.Field.Value := Value
      else
      FDataLink.Field.Text := Value;
    end;
    {$else}
    FDataLink.Field.Value := Value;
    {$endif}
  end;
end;

function TElDBRadioGroup.UseRightToLeftAlignment: Boolean;
begin
  Result := inherited UseRightToLeftAlignment;
end;

procedure TElDBNavButton.SetRole(Value: TElNavButtonRole);
begin
  // if FRole <> Value then
  begin
    FRole := Value;
    if (FRole = nbrCustom) or (FUseCustomImages) then
      Images := TElDBNavigator(Parent).Images
    else
    begin
      inherited SetImageIndex(integer(FRole));
      inherited SetImageList(TElDBNavigator(Parent).FIntImageList);
      inherited SetUseImageList(true);
    end;
  end;
end;

procedure TElDBNavButton.AClick(Arrow : boolean);
begin
  if (not Arrow) and (TElDBNavigator(Parent).FDataLink.DataSet <> nil) and (not CustomAction)  then
  with TElDBNavigator(Parent).FDataLink.DataSet do
  begin
    case Role of
      nbrPrior: Prior;
      nbrNext: Next;
      nbrFirst: First;
      nbrLast: Last;
      nbrInsert: Insert;
      nbrEdit: Edit;
      nbrCancel: Cancel;
      nbrPost: Post;
      nbrRefresh: Refresh;
      nbrSetFilter: Filtered := true;
      nbrRemoveFilter: Filtered := false;
      nbrClear: ClearFields;
      nbrOpen: Active := true;
      nbrClose: Active := false;
      nbrFindFirst: FindFirst;
      nbrFindNext: FindNext;
      nbrFindPrior: FindPrior;
      nbrFindLast: FindLast;
      //FIX ME!!!
      nbrDelete: if (not TElDBNavigator(Parent).ConfirmDelete) or (ElMessageDlg(TElDBNavigator(Parent).DeleteRecordQuestion, mtConfirmation, mbOKCancel, 0) <> idCancel) then
        begin
          Delete;
          Invalidate;
        end;
      nbrSearch: TElDBNavigator(Parent).DoSearch;
    end;
  end;
  inherited;
end;

function TElDBNavButton.GetArrowDetails: TThemedElementDetails;
begin
  if Assigned(Parent) and TElDBNavigator(Parent).FIsToolbar then
  begin
    // tiToolBar TP_SPLITBUTTONDROPDOWN
    if not Enabled then
      result := ThemeServices.GetElementDetails(ttbSplitButtonDropDownDisabled)
    else
    if FState in [ebsArrDown, ebsExclusive] then
      result := ThemeServices.GetElementDetails(ttbSplitButtonDropDownPressed)
    else
    if FMouseInArrow or FMouseInControl then
      result := ThemeServices.GetElementDetails(ttbSplitButtonDropDownHot)
    else
      result := ThemeServices.GetElementDetails(ttbSplitButtonDropDownNormal);
  end
  else
  begin
    // tiButton CP_DROPDOWNBUTTON
    if not Enabled then
      result := ThemeServices.GetElementDetails(tcDropDownButtonDisabled)
    else
    if FState in [ebsArrDown, ebsExclusive] then
      result := ThemeServices.GetElementDetails(tcDropDownButtonPressed)
    else
    if FMouseInControl or FMouseInArrow then
      result := ThemeServices.GetElementDetails(tcDropDownButtonHot)
    else
      result := ThemeServices.GetElementDetails(tcDropDownButtonNormal);
  end;
end;

function TElDBNavButton.GetDetails: TThemedElementDetails;
begin
  if Assigned(Parent) and TElDBNavigator(Parent).FIsToolbar then
  begin
    Result.Element := teToolBar;
    case ButtonType of
      ebtSeparator:
        begin
          Result.Part := TP_SPLITBUTTON;
        end;
      ebtDivider:
        begin
          if (Parent as TElToolbar).Orientation = eboVert then
            Result.Part := TP_SEPARATORVERT
          else
            Result.Part := TP_SEPARATOR;
        end;
      else
        begin
          if (not UseArrow) and (PulldownMenu <> nil) then
            Result.Part := TP_DROPDOWNBUTTON
          else
          if UseArrow then
            Result.Part := TP_SPLITBUTTON
          else
            Result.Part := TP_BUTTON;
        end;
    end;
  end
  else
  begin
    Result.Element := teButton;
    Result.Part := BP_PUSHBUTTON;
  end;
  FillStateForDetails(Result);
end;

procedure TElDBNavButton.FillStateForDetails(var ADetails: TThemedElementDetails);
begin
  if Assigned(Parent) and TElDBNavigator(Parent).FIsToolbar then
  begin
    if not Enabled then
      ADetails.State := TS_DISABLED
    else
    if FState in [ebsDown, ebsExclusive] then
      ADetails.State := TS_PRESSED
    else
    if (Down and IsSwitch) then
    begin
      if FMouseInControl or FMouseInArrow then
        ADetails.State := TS_HOTCHECKED
      else
        ADetails.State := TS_CHECKED;
    end
    else
    if FMouseInControl or FMouseInArrow then
      ADetails.State := TS_HOT
    else
      ADetails.State := TS_NORMAL;
  end
  else
  begin
    if not Enabled then
      ADetails.State := PBS_DISABLED
    else
    if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
      ADetails.State := PBS_PRESSED
    else
    if FMouseInControl or FMouseInArrow then
      ADetails.State := PBS_HOT
    else
      ADetails.State := PBS_NORMAL;
  end;
end;

procedure TElDBNavButton.SetUseImageList(newValue : Boolean);
begin
  if (UseImageList <> newValue) then
  begin
    if (FRole = nbrCustom) or (ComponentState * [csLoading, csReading] <> []) then
      inherited SetUseImageList(newValue);
  end; { if }
end; { SetUseImageList }

procedure TElDBNavButton.Loaded;
begin
  inherited;
  if (FRole <> nbrCustom) and (not FUseCustomImages) then
  begin
    inherited SetImageList(TElDBNavigator(Parent).FIntImageList);
    inherited SetUseImageList(true);
    inherited SetImageIndex(integer(FRole));
  end;
end;

procedure TElDBNavButton.SetImageList(newValue : TCustomImageList);
begin
  if (FRole = nbrCustom) or (FUseCustomImages) or (ComponentState * [csLoading, csReading] <> []) then
    inherited SetImageList(newValue);
end;

constructor TElDBNavButton.Create(AOwner : TComponent);
begin
  inherited;
  FRole := nbrCustom;
end;

procedure TElDBNavButton.SetImageIndex(newValue : Integer);
begin
  if (FRole = nbrCustom) or (FUseCustomImages) or (ComponentState * [csLoading, csReading] <> []) then
    inherited SetImageIndex(newValue);
end;

// Set Default Hint Strings

procedure TElDBNavButton.CMHintShow(var Message: TCMHintShow);

var
   HintInfo : PHintInfo;

  procedure GetHintButtonByRole;
   var {$ifdef LMD_UNICODE}
       T        : WideChar;
       WS       : WideString;
       {$endif}
       l        : integer;
       S        : String;
  begin
      if not Assigned(ElDBNavButtonsHint[Role]) then
        exit;

      S := LoadResString(ElDBNavButtonsHint[Role]);

      if Length(S)=0 then
        exit;

      {$ifdef LMD_UNICODE}
        S := LMDWideGetShortHint(S);
        WS:= S;

        l := Length(S) + 1 + Length(WS) * 2;
        SetLength(HintInfo.HintStr, l + 4);
        Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);
        Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
        T := #0;
        Move(T, HintInfo.HintStr[l + 1], sizeof(T));
        T := #$FFFE;
        Move(T, HintInfo.HintStr[l + 3], sizeof(T));
      {$else}
        l := Length(S);
        SetLength(HintInfo.HintStr, l + 1);
        Move(S[1], HintInfo.HintStr[1], l);
        HintInfo.HintStr[l+1] := #0;
      {$endif}
  end;
begin

  inherited;
  if (Role = nbrCustom)or(Length(Hint)>0) then exit;
  HintInfo := Message.HintInfo;
  GetHintButtonByRole;

end;

function TElDBNavigator.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TElDBNavigator.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if not (csLoading in ComponentState) then
    ActiveChanged;
  if Value <> nil then Value.FreeNotification(Self);
end;

constructor TElDBNavigator.Create(AOwner : TComponent);
begin
  inherited;
  FDataLink := TElNavDataLink.Create(Self);
  FConfirmDelete := true;
  FIntImageList := TCustomImageList.Create(Self);
  FIntImageList.Width := 14;
  FIntImageList.Height := 13;
  //FIX ME!!!
  FIntImageList.AddMasked(FGlyphBitmap, FGlyphBitmap.Canvas.Pixels[0, FGlyphBitmap.Height - 1]);
  UseImageList := true;
  ShowCaption := false;
  ShowGlyph := true;
  BtnOffsHorz := 0;
  BtnOffsVert := 0;
  BevelOuter := bvNone;
end;

procedure TElDBNavigator.ActiveChanged;
 var
   I: integer;
   AButton   : TElDBNavButton;
begin
  if ButtonCount=0 then
    exit;
  if (not (Enabled and FDataLink.Active)) or (FDataLink.DataSource = nil) then
    for i := FButtons.Count - 1 DownTo 0 do
      begin
        if (CustomToolButton[i] is TElDBNavButton) then
        begin
          AButton := CustomToolButton[i] as TElDBNavButton;
          if AButton.Role = nbrOpen then
              AButton.Enabled := True
            else
              TControl(FButtons[I]).Enabled := False;
        end;
      end
  else
  begin
    for i := FButtons.Count - 1 DownTo 0 do
      begin
        if (CustomToolButton[i] is TElDBNavButton) then
        begin
          AButton := CustomToolButton[i] as TElDBNavButton;
          case AButton.Role of

              nbrOpen  : AButton.Enabled := False;

              nbrClose : AButton.Enabled := True;

              nbrFindFirst,
              nbrFindPrior,
              nbrFindNext,
              nbrFindLast
                       : AButton.Enabled := True;
          end;
        end;
      end;
    DataChanged;
    EditingChanged;
  end;
end;

procedure TElDBNavigator.DataChanged;
var
  UpEnable,
  DownEnable: Boolean;
  AButton   : TElDBNavButton;
  i         : integer;
begin
  if ButtonCount=0 then
    exit;
  UpEnable := Enabled and FDataLink.Active and not FDataLink.DataSet.BOF;
  DownEnable := Enabled and FDataLink.Active and not FDataLink.DataSet.EOF;
  for i:=ButtonCount-1 DownTo 0 do begin
      if (CustomToolButton[i] is TElDBNavButton) then
      begin
        AButton := CustomToolButton[i] as TElDBNavButton;
        case AButton.Role of
          nbrFirst,
          nbrPrior   :   AButton.Enabled := UpEnable;
          nbrNext,
          nbrLast    :   AButton.Enabled := DownEnable;
          nbrDelete  :   AButton.Enabled :=
                            Enabled and FDataLink.Active and
                            FDataLink.DataSet.CanModify and
                            not (FDataLink.DataSet.BOF and
                            FDataLink.DataSet.EOF);
          // nbrSetBookmark, nbrGotoBookmark, nbrDeleteBookmark,
          nbrSetFilter : AButton.Enabled := (not FDataLink.DataSource.DataSet.Filtered);
          nbrRemoveFilter
                     :   AButton.Enabled := FDataLink.DataSource.DataSet.Filtered;
        end;//of case
      end;//of if (CustomToolButton[i] is TElDBNavButton)
  end;//of for i
end;

procedure TElDBNavigator.EditingChanged;
var
  CanModify: Boolean;
  AButton  : TElDBNavButton;
  i         : integer;
begin
  if ButtonCount=0 then
    exit;
  CanModify := Enabled and FDataLink.Active and (FDataLink.DataSet <> nil) and FDataLink.DataSet.CanModify;

  for i:=ButtonCount-1 DownTo 0 do begin
      if (CustomToolButton[i] is TElDBNavButton) then
      begin
        AButton := CustomToolButton[i] as TElDBNavButton;
        case AButton.Role of
          nbrInsert  :  AButton.Enabled := CanModify;
          nbrEdit    :  AButton.Enabled := CanModify and not FDataLink.Editing;
          nbrPost,
          nbrCancel  :  AButton.Enabled := CanModify and FDataLink.Editing;
          nbrRefresh :  AButton.Enabled := CanModify;
          // nbrSetBookmark, nbrGotoBookmark, nbrDeleteBookmark,
          nbrSearch  :  AButton.Enabled := CanModify and not FDataLink.Editing;
          nbrClear   :  AButton.Enabled := CanModify and FDataLink.Editing;
        end;//of case
      end;//of if (CustomToolButton[i] is TElDBNavButton)
  end;//of for i
end;

function TElDBNavigator.FindButtonByRole(Role : TElNavButtonRole):
    TElDBNavButton;
var i : integer;
begin
  result := nil;
  for i := 0 to FButtons.Count -1 do
  begin
    if TElDBNavButton(FButtons[i]).Role = Role then
    begin
      result := TElDBNavButton(FButtons[i]);
      Break;
    end;
  end;
end;

function TElDBNavigator.AddButton(Role : TElNavButtonRole): TElDBNavButton;
begin
  if Role <> nbrCustom then
    Result := FindButtonByRole(Role)
  else
    Result := nil;

  if Result = nil then
  begin
    Result := TElDBNavButton(inherited AddButton(ebtButton));
    Result.Role := Role;
  end;
  ActiveChanged;
end;

procedure TElDBNavigator.AddButtons(const Roles : array of TElNavButtonRole);
 var i:integer;
begin
    for i:=0 to High(Roles) do
      AddButton(Roles[i]);
    ActiveChanged;
end;

procedure TElDBNavigator.DoSearch;
begin
  if Assigned(FOnSearch) then FOnSearch(Self);
end;

function TElDBNavigator.GetButtonClass: TElToolButtonClass;
begin
  Result := TElDBNavButton;
end;

procedure TElDBNavigator.SetIsToolbar(Value: Boolean);
var i : integer;
begin
  if FIsToolbar <> Value then
  begin
    FIsToolbar := Value;
    if (ComponentState * [csLoading, csReading, csDestroying] = []) then
    for i := 0 to FButtons.Count - 1 do
    begin
      TElToolButton(FButtons[i]).Invalidate;
    end;
  end;
end;

destructor TElDBNavigator.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FIntImageList.Free;
  FIntImageList := nil;
  inherited;
end;

procedure TElDBNavigator.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBNavigator.Loaded;
begin
  inherited;
  ActiveChanged;
end;

procedure TElDBNavigator.CMControlChange(var Msg : TCMControlChange);

begin
  inherited;
  ActiveChanged;
end;

procedure TElDBNavigator.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    ActiveChanged;
end;

constructor TElNavDataLink.Create(ANav: TElDBNavigator);
begin
  inherited Create;
  FNavigator := ANav;
  VisualControl := True;
  end;

destructor TElNavDataLink.Destroy;
begin
  FNavigator := nil;
  inherited Destroy;
end;

procedure TElNavDataLink.ActiveChanged;
begin
  if FNavigator <> nil then FNavigator.ActiveChanged;
end;

procedure TElNavDataLink.DataSetChanged;
begin
  if FNavigator <> nil then FNavigator.DataChanged;
end;

procedure TElNavDataLink.EditingChanged;
begin
  if FNavigator <> nil then FNavigator.EditingChanged;
end;

{$ifdef LMD_UNICODE}
constructor TElWideDBEdit.Create(AOwner : TComponent);
begin
  inherited;
  inherited ReadOnly := true;
  FIgnoreReadOnlyState := not DisplayReadOnlyOptions.Enabled;
  ControlStyle := ControlStyle - [csSetCaption];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnActiveChange := ActiveChange;
end;

destructor TElWideDBEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited;
end;

procedure TElWideDBEdit.ActiveChange(Sender: TObject);
begin
  ResetMaxLength;
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElWideDBEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

procedure TElWideDBEdit.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
end;

procedure TElWideDBEdit.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  SetFocused(False);
  DoExit;
end;

procedure TElWideDBEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(FDataLink);
end;

procedure TElWideDBEdit.DataChangeText;
var
  W : WideString;
begin
  if FDataLink.Field <> nil then
  begin
    if not (csDesigning in ComponentState) then
    begin
      if (FDataLink.Field.DataType in [ftString, ftWideString]) and (MaxLength = 0) then
        MaxLength := FDataLink.Field.Size;
    end;
    //if Focused and FDataLink.CanModify then
    begin
      if FDataLink.Field.isNull then
        W := ''
      else
      if ((UnicodeMode = umForceUTF8) or ((FDataLink.Field.DataType <> ftWideString) and (UnicodeMode = umForceUnicode))) and
         (LMDConvertUTF8toUTF16({$ifdef lmdcomp12}AnsiString{$endif}(FDataLink.Field.Value), W, strictConversion, false)<> sourceIllegal)
      then
      else
      begin
        if (FDataLink.Field.DataType = ftWideString) then
          W := FDataLink.Field.Value
        else
        W := FDataLink.Field.Text;
      end;
      Text := W;
    end;
  end
  else
  begin
//    Alignment := taLeftJustify;
    if csDesigning in ComponentState then
      Text := Name
    else
      Text := '';
  end;
end;

procedure TElWideDBEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if (Alignment <> FDataLink.Field.Alignment) or (BiDiMode = bdRightToLeft) then
    begin
      Text := '';  {forces update}
      if BiDiMode = bdRightToLeft then
        Alignment := ChangeBiDiModeAlignment(FDataLink.Field.Alignment)
      else
        Alignment := FDataLink.Field.Alignment;
    end;
  end
  else
    if BiDiMode = bdRightToLeft then
      Alignment := taRightJustify
    else
      Alignment := taLeftJustify;
  DataChangeText;
  inherited ReadOnly := GetDBReadOnlyState;
end;

function TElWideDBEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TElWideDBEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := GetDBReadOnlyState;
  Refresh;
end;

function TElWideDBEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TElWideDBEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElWideDBEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElWideDBEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TElWideDBEdit.GetCReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElWideDBEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (not ReadOnly) and (FNullValueKey <> 0) and Assigned(FDataLink.DataSet) and Assigned(FDataLink.Field)
     and ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert]))
     and (FDataLink.DataSet.Active)
     and (FNullValueKey = ShortCut(Key,Shift)) then
  begin
    if Assigned(FDataLink.Field) then
    begin
      FDataLink.DataSet.Edit;
      FDataLink.Field.Clear;
    end;
    Key := 0;
  end;
  if (Key = VK_DELETE) or (Multiline and (Key = VK_RETURN)) or
     (Key = VK_BACK) or
     ((Key = VK_INSERT) and (ssShift in Shift))
  then
    FDataLink.Edit;
  if (Shift = [ssCtrl]) and (Char(Key) = 'V') and (not GetDBReadOnlyState) then
  begin
    FDataLink.Edit;
    inherited ReadOnly := false;
    Refresh;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TElWideDBEdit.WMImeStartComposition(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElWideDBEdit.KeyPress(var Key: Char);
{$ifdef LMD_UNICODE}
var
  LCategory: TLMDUnicodeCategory;
{$endif}
begin
  {$ifdef LMD_UNICODE}
  LCategory := LMDWideGetCharCategory(TLMDChar(Key));
  {$endif}
  if (AnsiChar(Key) in [#32..#255]) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
  end;
  {$ifdef LMD_UNICODE}
  if not (LCategory in [ukCc, ukCf, ukCs, ukCo, ukCn]) then
    FDataLink.Edit;
  {$ENDIF}
  inherited KeyPress(Key);
end;

procedure TElWideDBEdit.Loaded;
begin
  inherited Loaded;
  ResetMaxLength;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TElWideDBEdit.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElWideDBEdit.Reset;
begin
  FDataLink.Reset;
  if HandleAllocated then
    SelectAll;
end;

procedure TElWideDBEdit.ResetMaxLength;
var
  F: TField;
begin
  if (MaxLength > 0) and Assigned(DataSource) and Assigned(DataSource.DataSet) then
  begin
    F := DataSource.DataSet.FindField(DataField);
    if Assigned(F) and (F.DataType in [ftString, ftWideString]) and (F.Size = MaxLength) then
      MaxLength := 0;
  end;
end;

procedure TElWideDBEdit.SetDataField(const Value: string);
begin
  if not (csDesigning in ComponentState) then
    ResetMaxLength;
  FDataLink.FieldName := Value;
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElWideDBEdit.SetDataSource(Value: TDataSource);
begin
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElWideDBEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (Alignment <> taLeftJustify) then Invalidate;
    FDataLink.Reset;
  end;
end;

procedure TElWideDBEdit.SetCReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
  inherited ReadOnly := GetDBReadOnlyState;
  Invalidate;
end;

function TElWideDBEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TElWideDBEdit.UpdateData(Sender: TObject);
var W : WideString;
    st: AnsiString;
begin
  if ((UnicodeMode = umForceUTF8) or ((FDataLink.Field.DataType <> ftWideString) and (UnicodeMode = umForceUnicode))) and
     (LMDConvertUTF16toUTF8(Text, st, strictConversion, false) <> sourceIllegal)
  then
    FDataLink.Field.Value := st
  else
  begin
    if (FDataLink.Field.DataType = ftWideString) (*{?} and (not FDataLink.Field.IsNull) *) then
    begin
      W := Text;
      FDataLink.Field.Value := W;
    end
    else
    FDataLink.Field.Text := Text;
  end;
end;

function TElWideDBEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TElWideDBEdit.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElWideDBEdit.CutToClipboard;
begin
  FDataLink.Edit;
  inherited;
  FDataLink.Modified;
end;

procedure TElWideDBEdit.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
  FDataLink.Modified;
end;

procedure TElWideDBEdit.PasteFromClipboard;
begin
  FDataLink.Edit;
  inherited;
  FDataLink.Modified;
end;

procedure TElWideDBEdit.WMUndo(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElWideDBEdit.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
//  if Assigned(FDataLink.DataSet) and (FDataLink.DataSet.Active) then
//    inherited ReadOnly := FDataLink.ReadOnly;
  inherited;
end;

procedure TElWideDBEdit.WMCommand(var Msg: TWMCommand);
begin
  case Msg.ItemID of
  ID_PASTE, ID_DELETE, ID_CUT, ID_UNDO:
    begin
      FDataLink.Edit;
    end;
  end;
  inherited;
end;

constructor TElWideDBMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  FIgnoreReadOnlyState := not DisplayReadOnlyOptions.Enabled;
  Multiline := true;
  FAutoDisplay := True;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnActiveChange := ActiveChange;
end;

destructor TElWideDBMemo.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TElWideDBMemo.Change;
begin
  if FMemoLoaded then FDataLink.Modified;
  FMemoLoaded := True;
  inherited Change;
end;

procedure TElWideDBMemo.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
  if SysLocale.FarEast and {FDataLink.CanModify} (not GetDBReadOnlyState) then
    inherited ReadOnly := False;
end;

procedure TElWideDBMemo.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  SetFocused(False);
  inherited;
end;

procedure TElWideDBMemo.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(FDataLink);
end;

procedure TElWideDBMemo.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if FAutoDisplay or (FDataLink.Editing and FMemoLoaded) then
    begin
      FMemoLoaded := False;
      LoadMemo;
    end
    else
    begin
      Text := Format('(%s)', [FDataLink.Field.DisplayLabel]);
      FMemoLoaded := False;
    end;
  end
  else
  begin
    if csDesigning in ComponentState then
      Text := Name
    else
      Text := '';
    FMemoLoaded := False;
  end;
  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME);
end;

procedure TElWideDBMemo.EditingChange(Sender: TObject);
begin
//  inherited ReadOnly := not (FDataLink.Editing and FMemoLoaded);
  inherited ReadOnly := GetDBReadOnlyState or (not FMemoLoaded);
  Refresh;
end;

function TElWideDBMemo.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TElWideDBMemo.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElWideDBMemo.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElWideDBMemo.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TElWideDBMemo.GetCReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElWideDBMemo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if FMemoLoaded then
  begin
    if (not ReadOnly) and (FNullValueKey <> 0) and Assigned(FDataLink.DataSet) and Assigned(FDataLink.Field)
       and ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert]))
       and (FDataLink.DataSet.Active)
       and (FNullValueKey = ShortCut(Key,Shift)) then
    begin
      if Assigned(FDataLink.Field) then
      begin
        FDataLink.DataSet.Edit;
        FDataLink.Field.Clear;
      end;
      Key := 0;
    end;
    if (Key = VK_DELETE) or (Key = VK_RETURN) or
       (Key = VK_BACK) or
       ((Key = VK_INSERT) and (ssShift in Shift)) or
       (Shift = [ssCtrl]) and (Char(Key) = 'V')
    then
      FDataLink.Edit;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TElWideDBMemo.KeyPress(var Key: Char);
{$ifdef LMD_UNICODE}
var
  LCategory: TLMDUnicodeCategory;
{$endif}
begin
  if FMemoLoaded then
  begin
    {$ifdef LMD_UNICODE}
    LCategory := LMDWideGetCharCategory(TLMDChar(Key));
    {$endif}
    if (AnsiChar(Key) in [#32..#255]) and (FDataLink.Field <> nil) and
      not FDataLink.Field.IsValidChar(Key) then
    begin
      MessageBeep(0);
      Key := #0;
    end;
    case Key of
      ^H, ^I, ^J, ^M, ^V, ^X, #32..#255:
        FDataLink.Edit;
      #27:
        FDataLink.Reset;
    end;
    {$ifdef LMD_UNICODE}
    if not (LCategory in [ukCc, ukCf, ukCs, ukCo, ukCn]) then
      FDataLink.Edit;
    {$ENDIF}
  end
  else
  begin
    if Key = #13 then
      LoadMemo;
    Key := #0;
  end;
  inherited KeyPress(Key);
end;

procedure TElWideDBMemo.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TElWideDBMemo.LoadMemo;
var
  W : WideString;
//  BS: TStream;
begin
  if (not FMemoLoaded) and Assigned(FDataLink.Field) then
  begin
    if FDataLink.Field.IsBlob or
       (FDataLink.Field.DataType = ftWideString) or
       (FDataLink.Field.DataType = ftString)
    then
    begin
      try
        if FDataLink.Field.isNull then
          W :=''
        else
        if ((UnicodeMode = umForceUTF8) or ((FDataLink.Field.DataType <> ftWideString) and (UnicodeMode = umForceUnicode))) and
           (LMDConvertUTF8toUTF16({$ifdef lmdcomp12}AnsiString{$endif}(FDataLink.Field.Value), W, strictConversion, false) <> sourceIllegal)
        then
        else
        begin
          {$ifdef LMDCOMP10}
          if (FDataLink.Field.DataType in [ftWideMemo, ftWideString]) then
          {$else}
          if (FDataLink.Field.DataType = ftWideString) then
          {$endif}
            W := FDataLink.Field.Value
          else
            W := FDataLink.Field.AsString;
        end;
// fix related with reading blob data from stream
//        if (FDataLink.Field.IsBlob) and (UnicodeMode = umFieldType) then
//        begin
//          BS := FDataLink.DataSet.CreateBlobStream(Field, bmRead);
//          if (UnicodeMode = umForceUnicode) then
//              SetLength(W, BS.Size div 2)
//            else
//              SetLength(W, BS.Size)
//          BS.Read(PWideChar(W)^, BS.Size);
//          BS.Free;
//        end;
        Text := W;
        FMemoLoaded := True;
      except
        { Memo too large }
        on E:EInvalidOperation do
          Text := Format('(%s)', [E.Message]);
      end;
      EditingChange(Self);
    end
    else
    begin
      if FFocused and FDataLink.CanModify then
        Text := FDataLink.Field.Text
      else
        Text := FDataLink.Field.DisplayText;
      FMemoLoaded := True;
      //???:
      //EditingChange(Self);
    end;
  end;
end;

procedure TElWideDBMemo.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElWideDBMemo.SetAutoDisplay(Value: Boolean);
begin
  if FAutoDisplay <> Value then
  begin
    FAutoDisplay := Value;
    if Value then LoadMemo;
  end;
end;

procedure TElWideDBMemo.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElWideDBMemo.SetDataSource(Value: TDataSource);
begin
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElWideDBMemo.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if not Assigned(FDataLink.Field) or not FDataLink.Field.IsBlob then
      FDataLink.Reset;
  end;
end;

procedure TElWideDBMemo.SetCReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
  inherited ReadOnly := GetDBReadOnlyState;
  Invalidate;
end;

function TElWideDBMemo.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TElWideDBMemo.UpdateData(Sender: TObject);
var
  st : AnsiString;
//  BS: TStream;
begin
//  if (FDataLink.Field.IsBlob) and (UnicodeMode = umFieldType) then
//  begin
//    BS := FDataLink.DataSet.CreateBlobStream(Field, bmWrite);
//    if (UnicodeMode = umForceUnicode) then
//      BS.Write(PWideChar(Text)^, Length(Text)*2)
//    else
//      BS.Write(PWideChar(Text)^, Length(Text));
//    BS.Free;
//  end
//  else
  begin
    if ((UnicodeMode = umForceUTF8) or ((FDataLink.Field.DataType <> ftWideString) and (UnicodeMode = umForceUnicode))) and
       (LMDConvertUTF16toUTF8(Text, st, strictConversion, false) <> sourceIllegal)
    then
      FDataLink.Field.Value := st
    else
    begin
      if ((FDataLink.Field.DataType = ftWideString) {$IFDEF LMDCOMP11}or (FDataLink.Field.DataType = ftWideMemo){$ENDIF}){?} and (not FDataLink.Field.IsNull) then
        {$IFDEF LMDCOMP11}
        FDataLink.Field.AsWideString := Text
        {$ELSE}
        FDataLink.Field.Value := Text
        {$ENDIF}
      else
      FDataLink.Field.AsString := Text;
    end;
  end;
end;

function TElWideDBMemo.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TElWideDBMemo.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElWideDBMemo.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if not FMemoLoaded then LoadMemo else inherited;
end;

procedure TElWideDBMemo.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElWideDBMemo.CutToClipboard;
begin
  FDataLink.Edit;
  inherited;
  FDataLink.Modified;
end;

procedure TElWideDBMemo.PasteFromClipboard;
begin
  FDataLink.Edit;
  inherited;
  FDataLink.Modified;
end;

procedure TElWideDBMemo.WMUndo(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElWideDBMemo.WMImeStartComposition(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TElWideDBMemo.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
//  if Assigned(FDataLink.DataSet) and (FDataLink.DataSet.Active) then
//    inherited ReadOnly := FDataLink.ReadOnly;
end;

procedure TElWideDBMemo.WMCommand(var Msg: TWMCommand);
begin
  case Msg.ItemID of
  ID_PASTE, ID_DELETE, ID_CUT, ID_UNDO:
    begin
      FDataLink.Edit;
    end;
  end;
  inherited;
end;
{$endif}

procedure TElDBNavButton.SetUseCustomImage(Value: Boolean);
begin
  FUseCustomImages := Value;
  if Value then
  begin
    Images := TElDBNavigator(Parent).Images;
  end
  else
  begin
    inherited SetImageIndex(integer(FRole));
    inherited SetImageList(TElDBNavigator(Parent).FIntImageList);
    inherited SetUseImageList(true);
  end;
end;

function TElDBCheckBox.IsValueCheckedStored: Boolean;
begin
  Result := not (FValueCheck = 'True');
end;

function TElDBCheckBox.IsValueUnCheckedStored: Boolean;
begin
  Result := not (FValueUnCheck = 'False');
end;

procedure TElDBCheckBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (FNullValueKey <> 0) and Assigned(FDataLink.DataSet) and Assigned(FDataLink.Field)
     and ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert]))
     and (FDataLink.DataSet.Active)
     and (FNullValueKey = ShortCut(Key,Shift)) then
  begin
    if Assigned(FDataLink.Field) then
    begin
      FDataLink.DataSet.Edit;
      FDataLink.Field.Clear;
    end;
    Key := 0;
    Checked := false;
  end;
  inherited;
end;

procedure TElDBRadioGroup.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (not ReadOnly) and (FNullValueKey <> 0) and Assigned(FDataLink.DataSet) and Assigned(FDataLink.Field)
     and ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert]))
     and (FDataLink.DataSet.Active)
     and (FNullValueKey = ShortCut(Key,Shift)) then
  begin
    if Assigned(FDataLink.Field) then
    begin
      FDataLink.DataSet.Edit;
      FDataLink.Field.Clear;
    end;
    Key := 0;
    ItemIndex := -1;
  end
  else
    inherited;
end;

function DBCheckReadOnlyState(FDataLink: TFieldDataLink): Boolean;
begin
  Result := Assigned(FDataLink.DataSet) and (not FDataLink.ReadOnly);
  if Result then
  begin
    if FDataLink.DataSet.Active then
      Result := Result and (FDataLink.DataSet.CanModify)
    else
      Result := false;
  end;
  Result := Result and (Assigned(FDataLink.Field) and (not FDataLink.Field.ReadOnly));
  Result := not Result;
end;

{$ifdef LMD_UNICODE}
function TElWideDBEdit.GetDBReadOnlyState: Boolean;
begin
  Result := DBCheckReadOnlyState(FDataLink);
end;

procedure TElWideDBMemo.ActiveChange(Sender: TObject);
begin
  inherited ReadOnly := GetDBReadOnlyState;
end;

function TElWideDBMemo.GetDBReadOnlyState: Boolean;
begin
  Result := DBCheckReadOnlyState(FDataLink);
end;
{$endif}

initialization

  FGlyphBitmap := TBitmap.Create;

  FGlyphBitmap.LoadFromResourceName(HInstance, 'ELDBNAVBUTTONS');
  finalization
  try
    FGlyphBitmap.Free;
  except
    on e:Exception do
    begin
      LMDDebug('ERROR finalization ElDBCtrls: ' + e.Message);
    end;
  end;

end.
