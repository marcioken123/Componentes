unit ElACtrls;
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

ElACtrls unit
-------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

12 February, 2008 (EK)
 - Validation support added;

###############################################################################}

interface

uses
  Windows, StdCtrls, Messages, Controls,
  ExtCtrls, Forms, Graphics, Math, Types, SysUtils, Classes,
  ElImgFrm, ElVCLUtils,
  intfLMDBase, LMDProcs, LMDClass, Themes, LMDThemes,
  LMDVldBase, LMDTypes, LMDUtils, LMDGraphUtils, LMDGraph;

type
  TElAdvancedMemo = class(TMemo, ILMDValidatedControl)
  private
    FAbout: TLMDAboutVar;
    FActiveBorderType: TElFlatBorderType;
    FBackground: TBitmap;
    FFlat: boolean;
    FFlatFocusedScrollBars: boolean;
    FInactiveBorderType: TElFlatBorderType;
    FMouseOver: boolean;
    FPainting: boolean;
    FPaintingTo: boolean;
    FTransparent: boolean;
    FUseBackground: boolean;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FImgForm   : TElImageForm;
    FImgFormChLink : TImgFormChangeLink;
    FBorderSides: TLMDBorderSides;
    FHandleDialogKeys: Boolean;

    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}
    procedure ImageFormChange(Sender : TObject);
    procedure SetImageForm(newValue : TElImageForm);
    procedure BackgroundChanged(Sender: TObject);
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMParentColorChanged(var Msg: TMessage); message CM_PARENTCOLORCHANGED;
    procedure CNCtlColorEdit(var Msg: TWMCtlColorEdit); message CN_CTLCOLOREDIT;
    procedure CNCtlColorStatic(var Msg: TWMCtlColorStatic); message CN_CTLCOLORSTATIC;
    procedure WMGetDlgCode(var Msg : TMessage); message WM_GETDLGCODE;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMMove(var Msg: TWMMove); message WM_MOVE;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMNCCalcSize(var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMKeyDown(var Message: TWMKey); message WM_KEYDOWN;

    procedure DrawBackground(DC: HDC; R: TRect);
    procedure DrawFlatBorder(DC: HDC);
    procedure DrawParentControl(DC: HDC);
    procedure SetActiveBorderType(const Value: TElFlatBorderType);
    procedure SetBackground(const Value: TBitmap);
    procedure SetFlat(const Value: boolean);
    procedure SetFlatFocusedScrollBars(const Value: boolean);
    procedure SetInactiveBorderType(const Value: TElFlatBorderType);
    procedure SetTransparent(const Value: boolean);
    procedure SetUseBackground(const Value: boolean);
    procedure SetBorderSides(Value: TLMDBorderSides);
    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message:TCMHintShow); message CM_HINTSHOW;
    {$endif}
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;

    function GetUseXPThemes: Boolean;
    procedure ReadUseXPThemes(Reader: TReader);
    procedure SetThemeGlobalMode(const Value: Boolean);virtual;
    procedure SetThemeMode(const Value: TLMDThemeMode);virtual;
    procedure SetUseXPThemes(const Value: Boolean);virtual;
    procedure SetParentThemeMode(const Value: boolean);

  protected
    FParentThemeMode: boolean;
    FThemeGlobalMode: Boolean;
    FThemeMode : TLMDThemeMode;
    FPreventStyleChange :Boolean;

    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;
    FValidator: TLMDValidationEntity;
    FValidationMsgString: string;
    FErrorIndication: Boolean;
    FOnValidationError: TLMDValidationErrorEvent;
    procedure DefineProperties(Filer : TFiler); override;
    procedure SetValidationMsgString(val : TLMDString);
    function GetValidationMsgString : TLMDString;
    function GetControl : TControl;
    function GetControlBackBrush : TBrush;
    function GetControlFont : TFont;
    function GetValueToValidate: TLMDString;
    procedure Change; override;
    procedure DoMouseEnter; {$ifdef LMDCOMP10}dynamic;{$else}dynamic;{$endif}
    procedure DoMouseLeave; {$ifdef LMDCOMP10}dynamic;{$else}dynamic;{$endif}
    procedure DoPaint; dynamic;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure IFMRepaintChildren(var Message: TMessage); message IFM_REPAINTCHILDREN;
    procedure WMNCPaint(var Msg : TMessage); message WM_NCPAINT;

    procedure ELThemeChanged(var Message: TMessage); message WM_THEMECHANGED;

    procedure SetLineBorderActiveColor(Value: TColor);
    procedure SetLineBorderInactiveColor(Value: TColor);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;

    procedure DoThemeChanged; virtual;
    function UseThemeMode: TLMDThemeMode;
    procedure UpdateStyle;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsThemed: Boolean; // any other than ttmNone  -> Use LMDThemeServices
    // 6.0, ILMDComponent interface
    function getLMDPackage:TLMDPackageID;
    // ----
    function SupportsDefaultIndication: boolean;
    property ControlFont : TFont read GetControlFont;
    property ControlBackBrush : TBrush read GetControlBackBrush;
    procedure RespondToError(ErrorLevel: TLMDErrorLevel);
    procedure SetValidator(Validator:TLMDValidationEntity);
    function GetValidator: TLMDValidationEntity;

    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes;
  published
    property ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode;
    //new V9
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;

    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property ActiveBorderType: TElFlatBorderType read FActiveBorderType write SetActiveBorderType default fbtSunken;
    property Align;
    property Background: TBitmap read FBackground write SetBackground;
    property DoubleBuffered;
    property Flat: boolean read FFlat write SetFlat default False;
    property FlatFocusedScrollBars: boolean read FFlatFocusedScrollBars write SetFlatFocusedScrollBars default False;
    property InactiveBorderType: TElFlatBorderType read FInactiveBorderType write SetInactiveBorderType default fbtSunkenOuter;
    property Transparent: boolean read FTransparent write SetTransparent default False;
    property UseBackground: boolean read FUseBackground write SetUseBackground default False;
    property ImageForm   : TElImageForm read FImgForm write SetImageForm;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides default [ebsLeft, ebsTop, ebsRight, ebsBottom];
    property HandleDialogKeys: Boolean read FHandleDialogKeys write
        FHandleDialogKeys default false;
    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor default clBlack;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor default clBlack;
    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
    property ValidationMsgString : TLMDString read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read FOnValidationError write FOnValidationError;
    {$IFDEF LMCCOMP14}
    property OnGesture;
    property Touch;
    {$ENDIF}
  end;

  TCustomElAdvancedEdit = class(TCustomEdit, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    FActiveBorderType: TElFlatBorderType;
    FAlignment: TAlignment;
    FBackground: TBitmap;
    FFlat: boolean;
    FInactiveBorderType: TElFlatBorderType;
    FMouseOver: boolean;
    FPainting: boolean;
    FPaintingTo: boolean;
    FReturnPressed: boolean;
    FTransparent: boolean;
    FUseBackground: boolean;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FImgForm   : TElImageForm;
    FImgFormChLink : TImgFormChangeLink;
    FHandleDialogKeys : boolean;
    FBorderSides: TLMDBorderSides;

    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}

    FParentThemeMode: boolean;
    FThemeGlobalMode: Boolean;
    FThemeMode : TLMDThemeMode;

    function GetUseXPThemes: Boolean;
    procedure ReadUseXPThemes(Reader: TReader);

    procedure ImageFormChange(Sender : TObject);
    procedure BackgroundChanged(Sender: TObject);
    procedure WMGetDlgCode(var Msg : TMessage); message WM_GETDLGCODE;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMParentColorChanged(var Msg: TMessage); message CM_PARENTCOLORCHANGED;
    procedure CNCtlColorEdit(var Msg: TWMCtlColorEdit); message CN_CTLCOLOREDIT;
    procedure CNCtlColorStatic(var Msg: TWMCtlColorStatic); message CN_CTLCOLORSTATIC;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMMove(var Msg: TWMMove); message WM_MOVE;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMNCCalcSize(var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure DrawBackground(DC: HDC; R: TRect);
    procedure DrawFlatBorder(DC: HDC);
    procedure DrawParentControl(DC: HDC);
    procedure SetActiveBorderType(const Value: TElFlatBorderType);
    procedure SetAlignment(const Value: TAlignment);
    procedure SetBackground(const Value: TBitmap);
    procedure SetInactiveBorderType(const Value: TElFlatBorderType);
    procedure SetTransparent(const Value: boolean);
    procedure SetUseBackground(const Value: boolean);
    procedure SetBorderSides(Value: TLMDBorderSides);
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
        WM_WINDOWPOSCHANGED;

    procedure DoThemeChanged; virtual;
    function UseThemeMode: TLMDThemeMode;
    procedure SetThemeGlobalMode(const Value: Boolean);virtual;
    procedure SetThemeMode(const Value: TLMDThemeMode);virtual;
    procedure SetUseXPThemes(const Value: Boolean);virtual;
    procedure SetParentThemeMode(const Value: boolean);
  protected

    FNoHandleEnter : boolean;
    FPasswordChar: Char;

    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;
    procedure DefineProperties(Filer : TFiler); override;
    procedure SetImageForm(newValue : TElImageForm); virtual;
    procedure SetLineBorderActiveColor(Value: TColor);
    procedure SetLineBorderInactiveColor(Value: TColor);
    procedure SetFlat(const Value: boolean); virtual;

    procedure Change; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoMouseEnter; {$ifdef LMDCOMP10}dynamic;{$else}dynamic;{$endif}
    procedure DoMouseLeave; {$ifdef LMDCOMP10}dynamic;{$else}dynamic;{$endif}
    procedure DoPaint; dynamic;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    property ActiveBorderType: TElFlatBorderType read FActiveBorderType write SetActiveBorderType default fbtSunken;
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property Background: TBitmap read FBackground write SetBackground;
    property Flat: boolean read FFlat write SetFlat default False;
    property InactiveBorderType: TElFlatBorderType read FInactiveBorderType write SetInactiveBorderType default fbtSunkenOuter;
    property Transparent: boolean read FTransparent write SetTransparent default False;
    property UseBackground: boolean read FUseBackground write SetUseBackground default False;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor default clBlack;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor default clBlack;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetPasswordChar(Value: Char);
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
    procedure WMNCPaint(var Msg : TMessage); message WM_NCPAINT;

    procedure ELThemeChanged(var Message: TMessage); message WM_THEMECHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure WMPaste(var Message: TWMPaste); message WM_PASTE;
    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message:TCMHintShow); message CM_HINTSHOW;
    {$endif}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getLMDPackage:TLMDPackageID;
    property MouseOver : boolean read FMouseOver;
    function IsThemed: Boolean; // any other than ttmNone  -> Use LMDThemeServices

    //new V9
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes;

  published
    property DoubleBuffered;
    property ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode;
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
  property About: TLMDAboutVar read FAbout write FAbout stored False;
    property ImageForm : TElImageForm read FImgForm write SetImageForm;
    property HandleDialogKeys : boolean read FHandleDialogKeys write FHandleDialogKeys default false;
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides default [ebsLeft, ebsTop, ebsRight, ebsBottom];
    property PasswordChar: Char read FPasswordChar write SetPasswordChar stored
        False default #0;

    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
  end;

  TElAdvancedEdit = class(TCustomElAdvancedEdit)
  published
    property ActiveBorderType;
    property Align;
    property Alignment;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property Background;
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
    property Flat;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;
    property MaxLength;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property Text;
    property Transparent;
    property UseBackground;
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
    property OnMouseEnter;
    property OnMouseMove;
    property OnMouseLeave;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  TElAdvancedListBox = class(TListBox, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    FActiveBorderType: TElFlatBorderType;
    FBackground: TBitmap;
    FFlat: boolean;
    FFlatFocusedScrollBars: boolean;
    FInactiveBorderType: TElFlatBorderType;
    FInvertSelection: boolean;
    FLastTopIndex: integer;
    FMouseOver: boolean;
    FSelectedColor: TColor;
    FSelectedFont: TFont;
    FTransparent: boolean;
    FUseBackground: boolean;
    FImgForm   : TElImageForm;
    FImgFormChLink : TImgFormChangeLink;
    FInVScroll,
    FInHScroll     : boolean;
    FTransparentSelection: Boolean;
    FBorderSides : TLMDBorderSides;
    FShowLineHint: Boolean;
    FCurHintItem : Integer;
    FStyle       : TListBoxStyle;
    FMaxWidth    : integer;
    FHorizontalScroll: Boolean;
    FHintTimer   : TTimer;
    FHintWnd     : THintWindow;
    FHintWndProc : TWndMethod;

    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}
    FThemeGlobalMode: Boolean;
    function GetUseXPThemes: Boolean;
    procedure ReadUseXPThemes(Reader: TReader);

    procedure ImageFormChange(Sender : TObject);
    procedure SetImageForm(newValue : TElImageForm);
    procedure BackgroundChanged(Sender: TObject);
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMParentColorChanged(var Msg: TMessage); message CM_PARENTCOLORCHANGED;
    procedure CMParentFontChanged(var Msg: TMessage); message CM_PARENTFONTCHANGED;
    procedure LBGetTopIndex(var Msg: TMessage); message LB_GETTOPINDEX;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMHScroll(var Message: TWMVScroll); message WM_HSCROLL;
    procedure WMNCMouseMove(var Message: TMessage); message WM_NCMOUSEMOVE;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMNCCalcSize(var Message : TWMNCCalcSize); message WM_NCCALCSIZE;

    procedure DrawBackground(DC: HDC; R: TRect);
    procedure DrawBackgroundEx(DC: HDC; R, SubR: TRect);
    procedure DrawParentControlEx(DC: HDC; R: TRect);
    procedure DrawFlatBorder(DC: HDC; HDragging, VDragging : boolean);
    procedure DrawParentControl(DC: HDC);
    procedure IntMouseMove(XPos, YPos : SmallInt);
    procedure SelectedFontChanged(Sender: TObject);
    procedure SetActiveBorderType(const Value: TElFlatBorderType);
    procedure SetBackground(const Value: TBitmap);
    procedure SetFlat(const Value: boolean);
    procedure SetFlatFocusedScrollBars(const Value: boolean);
    procedure SetInactiveBorderType(const Value: TElFlatBorderType);
    procedure SetInvertSelection(const Value: boolean);
    procedure SetSelectedColor(const Value: TColor);
    procedure SetSelectedFont(const Value: TFont);
    procedure SetTransparent(const Value: boolean);
    procedure SetUseBackground(const Value: boolean);
    procedure SetTransparentSelection(Value: Boolean);
    procedure SetBorderSides(Value: TLMDBorderSides);
    procedure SetStyle(Value: TListBoxStyle);
    procedure SetHorizontalScroll(Value: Boolean);
    procedure ResetHorizontalExtent;
    procedure SetHorizontalExtent;
    procedure CancelLineHint;
    procedure OnLineHintTimer(Sender : TObject);
    procedure HintWndProc(var Message: TMessage);
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
        WM_WINDOWPOSCHANGED;
    procedure SetParentThemeMode(const Value: boolean);
  protected
    FParentThemeMode : boolean;
    FThemeMode : TLMDThemeMode;

    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;

    procedure SetThemeGlobalMode(const Value: Boolean);virtual;
    procedure SetThemeMode(const Value: TLMDThemeMode);virtual;
    procedure SetUseXPThemes(const Value: Boolean);virtual;

    procedure DoThemeChanged; virtual;
    function UseThemeMode: TLMDThemeMode;
    procedure UpdateStyle;
    function GetItemWidth(Index: Integer): Integer; virtual;
    function GetParentCtlWidth: Integer; virtual;
    function GetParentCtlHeight: Integer; virtual;
    function  RealScreenToClient(APoint : TPoint) : TPoint; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; R: TRect; State: TOwnerDrawState); override;
    function  GetBackground: TBitmap; virtual;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function CreateHintWindow: THintWindow; virtual;
    procedure WndProc(var Message: TMessage); override;
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
    procedure WMNCPaint(var Msg : TMessage); message WM_NCPAINT;

    procedure ELThemeChanged(var Message: TMessage); message WM_THEMECHANGED;
    procedure SetLineBorderActiveColor(Value: TColor);
    procedure SetLineBorderInactiveColor(Value: TColor);
    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message:TCMHintShow); message CM_HINTSHOW;
    {$endif}
    procedure DefineProperties(Filer : TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getLMDPackage:TLMDPackageID;
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes;
    function IsThemed: Boolean; // any other than ttmNone  -> Use LMDThemeServices
  published
    property ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode;
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;

    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property ActiveBorderType: TElFlatBorderType read FActiveBorderType write SetActiveBorderType default fbtSunken;
    property Background: TBitmap read GetBackground write SetBackground;
    property Flat: boolean read FFlat write SetFlat default False;
    property FlatFocusedScrollBars: boolean read FFlatFocusedScrollBars write SetFlatFocusedScrollBars default False;
    property InactiveBorderType: TElFlatBorderType read FInactiveBorderType write SetInactiveBorderType default fbtSunkenOuter;
    property InvertSelection: boolean read FInvertSelection write SetInvertSelection default False;
    property SelectedColor: TColor read FSelectedColor write SetSelectedColor default clHighlight;
    property SelectedFont: TFont read FSelectedFont write SetSelectedFont;
    property Transparent: boolean read FTransparent write SetTransparent default False;
    property UseBackground: boolean read FUseBackground write SetUseBackground default False;
    property ImageForm   : TElImageForm read FImgForm write SetImageForm;
    property TransparentSelection: Boolean read FTransparentSelection write
        SetTransparentSelection default false;
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides default [ebsLeft, ebsTop, ebsRight, ebsBottom];
    property ShowLineHint: Boolean read FShowLineHint write FShowLineHint default
        false;
    property Style: TListBoxStyle read FStyle write SetStyle default lbStandard;
    property HorizontalScroll: Boolean read FHorizontalScroll write
        SetHorizontalScroll;

    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor default clBlack;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor default clBlack;
    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
  end;

  TCustomElAdvancedComboBox = class(TCustomComboBox, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    FActiveBorderType : TElFlatBorderType;
    FInactiveBorderType : TElFlatBorderType;
    FFlat : boolean;
    BtnCanvas : TCanvas;
    FDropDownWidth: integer;
    FImgForm   : TElImageForm;
    FImgFormChLink : TImgFormChangeLink;
    FAutoCompletion: Boolean;
    FListInstance : Pointer;
    FEditInstance : Pointer;
    FSaveEditWndProc : Integer;
    FSaveListWndProc : Integer;
    FListWindowProc: TWndMethod;
    FEditWindowProc: TWndMethod;
    FHorizontalScroll: Boolean;
    //FFakeListBox     : TElAdvancedListBox;
//    FInHScroll,
//    FInVScroll       : boolean;

    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}
    FThemeGlobalMode: Boolean;
    procedure ImageFormChange(Sender : TObject);
    //procedure SetImageForm(newValue : TElImageForm);
    procedure SetFlat(newValue : Boolean);
    procedure CMMouseEnter(var Msg : TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure WMNCPaint(var Msg : TMessage); message WM_NCPAINT;
    procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
    procedure WMPaint(var Msg : TWMPaint); message WM_PAINT;
    procedure WMSize(var Msg : TWMSize); message WM_SIZE;
    procedure CMEnter(var Msg : TCMEnter); message CM_ENTER;
    procedure CMExit(var Msg : TCMExit); message CM_EXIT;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    function IsFocused : boolean;
    procedure SetActiveBorderType(newValue : TElFlatBorderType);
    procedure SetInactiveBorderType(newValue : TElFlatBorderType);
    procedure SetHorizontalScroll(Value: Boolean);
    procedure SetHorizontalExtent;
    procedure ResetHorizontalExtent;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
        WM_WINDOWPOSCHANGED;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
    //    function GetDropDownWidth: integer;

    function GetUseXPThemes: Boolean;
    procedure ReadUseXPThemes(Reader: TReader);
    procedure SetParentThemeMode(const Value: boolean);
  protected
    FListHandle,
    FEditHandle : HWND;
    FMouseOver : boolean;

    FHorzPos    : integer;
    FMaxWidth: integer;
    FButtonFlat: Boolean;
    FButtonTransparent: Boolean;

    FButtonThinFrame: Boolean;
    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;
    FHandleDialogKeys: Boolean;
    FParentThemeMode: boolean;
    FThemeMode : TLMDThemeMode;
    procedure DefineProperties(Filer : TFiler); override;
    procedure DrawFlatBorder(CanvasDC:HDC; DrawButton : boolean);
    procedure UpdateFrame;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WndProc(var Message : TMessage); override;
    procedure ListWndProc(var Message : TMessage); virtual;
    procedure EditWndProc(var Message : TMessage); {$ifndef LMDCOMP10}virtual{$else}override{$endif};
    procedure ELThemeChanged(var Message: TMessage); message WM_THEMECHANGED;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetButtonFlat(Value: Boolean);
    procedure SetButtonTransparent(Value: Boolean);
    function GetItemWidth(Index: Integer): Integer; virtual;
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;

    procedure CreateWnd; override;

    procedure SetButtonThinFrame(Value: Boolean);
    procedure SetLineBorderActiveColor(Value: TColor);
    procedure SetLineBorderInactiveColor(Value: TColor);
    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message:TCMHintShow); message CM_HINTSHOW;
    {$endif}
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DoAutoComplete;
    function GetTextFromItem(Index : integer): string; virtual;
    procedure ReadBtnFlat(Reader : TReader);
    procedure ReadBtnTransparent(Reader : TReader);
    procedure ReadBtnThinFrame(Reader : TReader);
    procedure Loaded; override;

    procedure SetThemeGlobalMode(const Value: Boolean);virtual;
    procedure SetThemeMode(const Value: TLMDThemeMode);virtual;
    procedure SetUseXPThemes(const Value: Boolean);virtual;

    procedure DoThemeChanged; virtual;
    function UseThemeMode: TLMDThemeMode;
    procedure UpdateStyle;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function IsThemed: Boolean; // any other than ttmNone  -> Use LMDThemeServices
    function getLMDPackage:TLMDPackageID;
    property ListHandle : HWND read FListHandle;
    property EditHandle : HWND read FEditHandle;
    property ListWindowProc: TWndMethod read FListWindowProc write FListWindowProc;
    property EditWindowProc: TWndMethod read FEditWindowProc write FEditWindowProc;

    property Flat : Boolean read FFlat write SetFlat; { Published }

    property ActiveBorderType : TElFlatBorderType read FActiveBorderType write SetActiveBorderType default fbtSunken;  { Published }
    property InactiveBorderType : TElFlatBorderType read FInactiveBorderType write SetInactiveBorderType default fbtSunkenOuter;  { Published }
    property ButtonFlat: Boolean read FButtonFlat write SetButtonFlat default false;
    property ButtonTransparent: Boolean read FButtonTransparent write
        SetButtonTransparent default false;
    property HorizontalScroll: Boolean read FHorizontalScroll write SetHorizontalScroll;

    property ButtonThinFrame: Boolean read FButtonThinFrame write
        SetButtonThinFrame default true;
    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor default clBlack;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor default clBlack;
    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
    property DropDownWidth: integer read FDropDownWidth write FDropDownWidth default 0;
    property AutoCompletion: Boolean read FAutoCompletion write FAutoCompletion;
    property HandleDialogKeys: Boolean read FHandleDialogKeys write FHandleDialogKeys;
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes;

  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property DoubleBuffered;
    property ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode;
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;

  end;

  TElAdvancedComboBox = class(TCustomElAdvancedComboBox)
  published
    property ActiveBorderType;
    property Align;
    property Anchors;
    property AutoCompletion;
    property BiDiMode;
    property ButtonFlat;
    property ButtonThinFrame;
    property ButtonTransparent;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property DropDownWidth;
    property Enabled;
    property Font;
    property Flat;
    property HandleDialogKeys;
    property Hint;
    property HorizontalScroll;
    property ImeMode;
    property ImeName;
    property InactiveBorderType;
    property ItemIndex;
    property ItemHeight;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property Style;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;

    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnStartDock;
    property OnStartDrag;

    {$ifdef LMDCOMP7}
    property AutoCloseUp default False;
    {$endif}

    property AutoDropDown default False;

    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;

    property CharCase;

    property OnCloseUp;
    property OnSelect;
    property Items;
  end;

  TCustomElFlatEdit = TCustomElAdvancedEdit;
  TElFlatEdit = TElAdvancedEdit;
  TElFlatMemo = TElAdvancedMemo;
  TElFlatListBox = TElAdvancedListBox;
  TElFlatComboBox= TElAdvancedComboBox;

implementation

uses
  TypInfo, UxTheme, Clipbrd, LMDSysIn;

type
   THackWinControl = class(TWinControl)
   ;
type
  TListBoxHintWindow = class(THintWindow)
  protected
  end;

{ TCustomElFlatEdit }
procedure TCustomElAdvancedEdit.BackgroundChanged(Sender: TObject);
begin
  Invalidate;
  Perform(CM_COLORCHANGED, 0, 0);
end;

procedure TCustomElAdvancedEdit.Change;
begin
  DoPaint;
  inherited;
end;

procedure TCustomElAdvancedEdit.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  FMouseOver := True;
  if LMDSIWindowsVistaUp then
    SendMessage(Handle, WM_NCPAINT, 0, 0);

    if IsThemed or
     (Flat and (not Focused) and
      ((InactiveBorderType <> ActiveBorderType)) or ((InactiveBorderType = fbtColorLineBorder) and (LineBorderActiveColor <> LineBorderInactiveColor))) then DrawFlatBorder(0);
  DoMouseEnter;
end;

procedure TCustomElAdvancedEdit.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
  FMouseOver := False;
  if LMDSIWindowsVistaUp then
    SendMessage(Handle, WM_NCPAINT, 0, 0);
    if IsThemed or
     (Flat and (not Focused) and
      ((InactiveBorderType <> ActiveBorderType)) or ((InactiveBorderType = fbtColorLineBorder) and (LineBorderActiveColor <> LineBorderInactiveColor))) then DrawFlatBorder(0);
  DoMouseLeave;
end;

procedure TCustomElAdvancedEdit.CMParentColorChanged(var Msg: TMessage);
begin
  inherited;
  if FTransparent or (FUseBackground and not FBackground.Empty)
  or ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in Componentstate)))
  then
    Invalidate;
end;

procedure TCustomElAdvancedEdit.CNCtlColorEdit(var Msg: TWMCtlColorEdit);
begin
  inherited;
  if FTransparent or (FUseBackground and not FBackground.Empty)
  or ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in Componentstate)))
  then
    SetBkMode(Msg.ChildDC, Windows.TRANSPARENT);
end;

procedure TCustomElAdvancedEdit.CNCtlColorStatic(var Msg: TWMCtlColorStatic);
begin
  inherited;
  if FTransparent or (FUseBackground and not FBackground.Empty)
  or ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in Componentstate)))
  then
    SetBkMode(Msg.ChildDC, Windows.TRANSPARENT);
end;

constructor TCustomElAdvancedEdit.Create(AOwner: TComponent);
begin
  inherited;
  FActiveBorderType := fbtSunken;
  FInactiveBorderType := fbtSunkenOuter;
  FAlignment := taLeftJustify;
  FHandleDialogKeys := false;
  FBackground := TBitmap.Create;
  FBackground.OnChange := BackgroundChanged;
  FFlat := False;
  FMouseOver := False;
  FPainting := False;
  FPaintingTo := False;
  FTransparent := False;
  FUseBackground := False;

  FParentThemeMode := true;
  FThemeMode := ttmPlatform;

  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  FBorderSides := [ebsLeft, ebsTop, ebsRight, ebsBottom];
end;

procedure TCustomElAdvancedEdit.CreateParams(var Params: TCreateParams);
const
   Alignments: array [TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited;
  Params.Style := Params.Style or ES_MULTILINE or Alignments[FAlignment];
end;

destructor TCustomElAdvancedEdit.Destroy;
begin
  ImageForm := nil;
  FImgFormChLink.Free;
  FBackground.Free;
  inherited;
end;

procedure TCustomElAdvancedEdit.DoMouseEnter;
begin
  if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;

procedure TCustomElAdvancedEdit.DoMouseLeave;
begin
  if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TCustomElAdvancedEdit.WMGetDlgCode(var Msg : TMessage);
begin
  Msg.Result := DefWindowProc(Handle, Msg.Msg, Msg.wParam, Msg.lParam);
  Msg.Result := (Msg.Result and (not DLGC_WANTALLKEYS)) or DLGC_WANTARROWS or DLGC_WANTCHARS;
  if HandleDialogKeys then Msg.Result := Msg.Result or DLGC_WANTALLKEYS;
end;

procedure TCustomElAdvancedEdit.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FImgForm then
    begin
      FImgForm := nil;
      Invalidate;
    end;
    end;
end;

procedure TCustomElAdvancedEdit.DoPaint;
const
  BorderOffsets: array [TBorderStyle] of integer = (1, -1);
var
  CtlDC, TempDC: HDC;
  OldBmp, TempBmp: HBITMAP;
begin
  FPainting := True;
  try
    if FTransparent or (FUseBackground and not FBackground.Empty)
    or ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in Componentstate)))
    then
    begin
      HideCaret(Handle);
      CtlDC := GetDC(Handle);
      try
        TempDC := CreateCompatibleDC(CtlDC);
        try
          TempBmp := CreateCompatibleBitmap(CtlDC, ClientWidth +1, ClientHeight +1);
          try
            OldBmp := SelectObject(TempDC, TempBmp);
            FPaintingTo := True;
            try
              PaintTo(TempDC, 0, 0);
            finally
              FPainting := False;
            end;
            if FFlat and (not IsThemed) then
               DrawFlatBorder(TempDC);
            BitBlt(CtlDC, BorderOffsets[BorderStyle], BorderOffsets[BorderStyle], ClientWidth, ClientHeight, TempDC, 1, 1, SRCCOPY);
            SelectObject(TempDC, OldBmp);
          finally
            DeleteObject(TempBmp);
          end;
        finally
          DeleteDC(TempDC);
        end;
      finally
        ReleaseDC(Handle, CtlDC);
      end;
      ShowCaret(Handle);
    end;
  finally
    FPainting := False;
  end;
end;

procedure TCustomElAdvancedEdit.DrawBackground(DC: HDC; R: TRect);
var
  X, Y: integer;
begin
  if FUseBackground and not FBackground.Empty then
  begin
    X := R.Left; Y := R.Top;
    while Y < R.Bottom do
    begin
      while X < R.Right do
      begin
        BitBlt(DC, X, Y, R.Right - X, R.Bottom - Y,
          FBackground.Canvas.Handle, 0, 0, SRCCOPY);
        Inc(X, FBackground.Width);
      end;
      X := R.Left;
      Inc(Y, FBackground.Height);
    end;
  end;
end;

procedure TCustomElAdvancedEdit.DrawFlatBorder(DC: HDC);
var
  BorderType: TElFlatBorderType;
  MustRelease: boolean;
  AColor     : TColor;
  R: TRect;
begin
  if (not FFlat) or (BorderStyle = bsNone) or (not HandleAllocated) then exit;
  if IsThemed then
  begin
    RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_UPDATENOW);
    exit;
  end;
  MustRelease := (DC = 0);
  if MustRelease then DC := GetWindowDC(Handle);
  try
    GetWindowRect(Handle, R);
    OffsetRect(R, -R.Left, -R.Top);

    if Focused or FMouseOver then
    begin
      BorderType := FActiveBorderType;
      AColor := LineBorderActiveColor;
    end
    else
    begin
      BorderType := FInactiveBorderType;
      AColor := LineBorderInactiveColor;
    end;
    DrawFlatFrameEx2(DC, R, AColor, Color,  Focused or FMouseOver, Enabled, FBorderSides, BorderType, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow);
  finally
    if MustRelease then ReleaseDC(Handle, DC);
  end;
end;

procedure TCustomElAdvancedEdit.DrawParentControl(DC: HDC);
var
  SavedDC: integer;
  P: TPoint;
begin
  if Assigned(Parent) then
  begin
    SavedDC := SaveDC(DC);
    try
      P := Parent.ScreenToClient(ClientOrigin);
      MoveWindowOrg(DC, -P.X, -P.Y);
      Parent.Perform(WM_ERASEBKGND, DC, 0);
      Parent.Perform(WM_PAINT, DC, 0);
      THackWinControl(Parent).PaintControls(DC, nil);
    finally
      RestoreDC(DC, SavedDC);
    end;
  end;
end;

procedure TCustomElAdvancedEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  FReturnPressed := ((Key = VK_RETURN) and (Shift = [ssCtrl])) or (Key = VK_UP)
                    or (Key = VK_DOWN) or (Key = VK_PRIOR) or (Key = VK_NEXT);
  end;

procedure TCustomElAdvancedEdit.KeyPress(var Key: Char);
begin
  inherited;
  if ((Key = Char(VK_RETURN)) or FReturnPressed) and (not FNoHandleEnter) then
  begin
    Key := #0;
    MessageBeep(0);
    end;
end;

procedure TCustomElAdvancedEdit.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TCustomElAdvancedEdit.SetImageForm(newValue : TElImageForm);
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
    if FImgForm <> nil then FImgForm.RegisterChanges(FImgFormChLink);
    if HandleAllocated then
      begin
        RecreateWnd;
        Perform(CM_COLORCHANGED, 0, 0);
      end;
  end;
end;

procedure TCustomElAdvancedEdit.SetActiveBorderType(const Value:
    TElFlatBorderType);
begin
  if FActiveBorderType <> Value then
  begin
    FActiveBorderType := Value;
    if (Focused or FMouseOver) and (not IsThemed)then DrawFlatBorder(0);
    end;
end;

procedure TCustomElAdvancedEdit.SetAlignment(const Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElAdvancedEdit.SetBackground(const Value: TBitmap);
begin
  FBackground.Assign(Value);
end;

procedure TCustomElAdvancedEdit.SetFlat(const Value: boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    if Flat then
      Invalidate
    else
      RecreateWnd;
    end;
end;

procedure TCustomElAdvancedEdit.SetInactiveBorderType(const Value:
    TElFlatBorderType);
begin
  if FInactiveBorderType <> Value then
  begin
    FInactiveBorderType := Value;
    if not Focused and not FMouseOver and (not IsThemed) then DrawFlatBorder(0);
    end;
end;

procedure TCustomElAdvancedEdit.SetTransparent(const Value: boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
    end;
end;

procedure TCustomElAdvancedEdit.SetUseBackground(const Value: boolean);
begin
  if FUseBackground <> Value then
  begin
    FUseBackground := Value;
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
    end;
end;

procedure TCustomElAdvancedEdit.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
var
  R1: TRect;
  BgRect: TRect;
  ACtl: TWinControl;
  {RW: TRect;
  sid: Integer;}
begin
  if (FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and
     (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
  begin
    if (FImgForm.Control <> Self) then
    begin
      ACtl := FImgForm.GetRealControl;
      R1 := ClientRect;
      BgRect := ClientRect;
      BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);

      BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
      BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
      BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);

      FImgForm.PaintBkgnd(Msg.DC, R1, Point(BgRect.Left, BgRect.Top), false);
    end;
  end else
  if FTransparent then
    DrawParentControl(Msg.DC)
  else
  if FUseBackground and not FBackground.Empty then
    DrawBackground(Msg.DC, ClientRect)
  else

  {if IsThemeApplied then
  begin
    RW := BoundsRect;
    MapWindowPoints(Parent.Handle, Handle, RW, 2);
    if not Enabled then
      sid := ETS_DISABLED
    else
    if Focused then
      sid := ETS_FOCUSED
    else
    if ReadOnly then
      sid := ETS_READONLY
    else
      sid := ETS_NORMAL;
    DrawThemeBackground(Theme, Msg.DC, EP_EDITTEXT, sid, RW, nil);
  end
  else{}
    inherited;
end;

procedure TCustomElAdvancedEdit.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  if not HandleAllocated then exit;

  if LMDSIWindowsVistaUp then
    SendMessage(Handle, WM_NCPAINT, 0, 0);

  if Flat and not FMouseOver and (not IsThemed) then DrawFlatBorder(0);
end;

procedure TCustomElAdvancedEdit.WMMove(var Msg: TWMMove);
begin
  inherited;
  if HandleAllocated then
    Invalidate;
end;

procedure TCustomElAdvancedEdit.WMPaint(var Msg: TWMPaint);
begin
  inherited;
  if FTransparent or (FUseBackground and not FBackground.Empty)
  or ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in Componentstate)))
  then
    if not FPainting and not FPaintingTo then DoPaint;
  if Flat and (not IsThemed) then
    DrawFlatBorder(0);
end;

procedure TCustomElAdvancedEdit.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if AutoSelect and not (csLButtonDown in ControlState) then SelectAll;
  if Flat and not FMouseOver and (not IsThemed) then DrawFlatBorder(0);
end;

procedure TCustomElAdvancedEdit.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TCustomElAdvancedEdit.WMNCCalcSize(var Message : TWMNCCalcSize);

begin
  inherited;
  if (BorderStyle = bsSingle) then
    begin
      if not (ebsLeft in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(SM_CYEDGE));
      if not (ebsTop in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(SM_CXEDGE));
      if not (ebsRight in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(SM_CYEDGE));
      if not (ebsBottom in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(SM_CXEDGE));
    end;
end;

procedure TCustomElAdvancedEdit.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

procedure TCustomElAdvancedEdit.SetPasswordChar(Value: Char);
begin
  if FPasswordChar <> #0 then
  begin
    MessageBox(0, 'PasswordChar is not supported in ElAdvancedEdit', nil, 0);
  end;
end;

procedure TCustomElAdvancedEdit.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  Invalidate;
  Broadcast(Message);
end;

procedure TCustomElAdvancedEdit.WMWindowPosChanged(var Message:
    TWMWindowPosChanged);
begin
  inherited;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
end;

procedure TCustomElAdvancedEdit.WMNCPaint(var Msg : TMessage);
var DC : HDC;
    RW,
    RC : TRect;
    LDetails: TThemedElementDetails;
begin
  if IsThemed and (BorderStyle = bsSingle) then
  begin
    DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
    if DC = 0 then
    begin
      DC := GetWindowDC(Handle);
    end;
    Windows.GetClientRect(Handle, RC);
    GetWindowRect(Handle, RW);
    MapWindowPoints(0, Handle, RW, 2);
    OffsetRect(RC, -RW.Left, -RW.Top);
    ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
    OffsetRect(RW, -RW.Left, -RW.Top);
    if LMDSIWindowsVistaUp then
    begin
      LDetails.Element := teEdit;
      LDetails.Part := EP_EDITBORDER_NOSCROLL;

      if Focused or MouseOver then
        LDetails.State := Ord(teEditTextHot)
      else
        LDetails.State := 1;

      LMDThemeServices.DrawElement(UseThemeMode, DC, LDetails, RW, nil);
    end
    else
      LMDThemeServices.DrawElement(UseThemeMode, DC, teEditDontCare, RW, nil);
    ReleaseDC(Handle, DC);
  end
  else
  if not Flat and (BorderStyle = bsSingle) then
    inherited;
end;

procedure TCustomElAdvancedEdit.SetUseXPThemes(const Value: Boolean);
begin
  if UseXPThemes <> Value then
  begin
    ThemeMode := LMDCtlXP[Value];
    if HandleAllocated then
      RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW);
  end;
end;

procedure TCustomElAdvancedEdit.DefineProperties(Filer : TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('UseXPThemes', ReadUseXPThemes, nil, false);
end;

function TCustomElAdvancedEdit.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_ELCORE;
end;

procedure TCustomElAdvancedEdit.ELThemeChanged(var Message: TMessage);
begin
  if IsThemed and UseXPThemes then
  begin
    SetWindowPos( Handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
    RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE);
  end;
  Message.Result := 1;
end;

procedure TCustomElAdvancedEdit.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then Invalidate;
  end;
end;

procedure TCustomElAdvancedEdit.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then Invalidate;
  end;
end;

procedure TCustomElAdvancedEdit.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if IsThemed then
    Invalidate;
end;

procedure TCustomElAdvancedEdit.WMPaste(var Message: TWMPaste);
var Clip  : TClipboard;
    Piece : String;
begin
  if ReadOnly then exit;
  Clip := Clipboard;
  Clip.Open;
  Piece := Clip.AsText;
  while (Pos(#10, Piece) > 0) do
    Delete(Piece, Pos(#10, Piece), 1);
  while (Pos(#13, Piece) > 0) do
    Delete(Piece, Pos(#13, Piece), 1);
  Clip.AsText := Piece;
  Clip.Close;
  inherited;
end;

{$ifdef LMD_UNICODE}
procedure TCustomElAdvancedEdit.CMHintShow(var Message: TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message); //outcommented VB Dec 2008
end;

procedure TCustomElAdvancedEdit.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF}

{------------------------------------------------------------------------------}
function TCustomElAdvancedEdit.GetUseXPThemes: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

{------------------------------------------------------------------------------}
procedure TCustomElAdvancedEdit.ReadUseXPThemes(Reader: TReader);
begin
  SetUseXPThemes(Reader.ReadBoolean);
end;

{------------------------------------------------------------------------------}
procedure TCustomElAdvancedEdit.DoThemeChanged;
begin
  // Delphi 2k7 fix
  if (UseThemeMode <> ttmNone) and HandleAllocated and not (csDestroying in ComponentState) then
  begin
    if Showing and (ComponentState * [csLoading, csReading] = []) then
      begin
        // Recalculate frame size
        SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
        // Repaint frame
        RedrawWindow(Handle, nil, 0, {RDW_FRAME or }RDW_INVALIDATE or RDW_ERASE);
      end;
  end
  else
    Invalidate;
end;

{------------------------------------------------------------------------------}
function TCustomElAdvancedEdit.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

{------------------------------------------------------------------------------}
function TCustomElAdvancedEdit.UseThemeMode: TLMDThemeMode;
begin
  result := FThemeMode;
  if ParentThemeMode and Assigned(Parent) and IsPublishedProp(Parent, 'ThemeMode') then
    result := TLMDThemeMode(GetOrdProp(Parent, 'ThemeMode'))
  else
    if FThemeGlobalMode then
      result := LMDApplication.ThemeGlobalMode;
  result := LMDThemeServices.UseTheme(result);
end;

{------------------------------------------------------------------------------}
procedure TCustomElAdvancedEdit.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
  begin
    FThemeGlobalMode := Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TCustomElAdvancedEdit.SetThemeMode(const Value: TLMDThemeMode);
begin
  if Value <> FThemeMode then
  begin
    FThemeMode:= Value;
    DoThemeChanged;
  end;
end;

{ TElFlatListBox }
procedure TElAdvancedListBox.BackgroundChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TElAdvancedListBox.CMFontChanged(var Msg: TMessage);
begin
  inherited;
  if Style = lbStandard then
  begin
    Canvas.Font.Assign(Font);
    Perform(LB_SETITEMHEIGHT, 0, Canvas.TextHeight('0'));
  end;
end;

procedure TElAdvancedListBox.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  FMouseOver := True;
  if IsThemed or
    (Flat and (not Focused) and
    (not FlatFocusedScrollbars) and
    ((InactiveBorderType <> ActiveBorderType)) or ((InactiveBorderType = fbtColorLineBorder) and (LineBorderActiveColor <> LineBorderInactiveColor))) then DrawFlatBorder(0, false, false);
end;

procedure TElAdvancedListBox.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
  FMouseOver := False;
  if IsThemed or
   (Flat and (not Focused) and
    (not FlatFocusedScrollbars) and
    ((InactiveBorderType <> ActiveBorderType)) or ((InactiveBorderType = fbtColorLineBorder) and (LineBorderActiveColor <> LineBorderInactiveColor))) then
  DrawFlatBorder(0, false, false);
end;

procedure TElAdvancedListBox.CMParentColorChanged(var Msg: TMessage);
begin
  inherited;
  if FTransparent then Invalidate;
end;

procedure TElAdvancedListBox.CMParentFontChanged(var Msg: TMessage);
begin
  inherited;
  if ParentFont then
  begin
    FSelectedFont.OnChange := nil;
    try
      if Msg.WParam <> 0 then
        FSelectedFont.Assign(TFont(Msg.LParam))
      else
        FSelectedFont.Assign(Font);
      FSelectedFont.Color := clHighlightText;
    finally
      FSelectedFont.OnChange := SelectedFontChanged;
    end;
  end;
end;

constructor TElAdvancedListBox.Create(AOwner: TComponent);
begin
  inherited;
  FBorderSides := [ebsLeft, ebsTop, ebsRight, ebsBottom];
  FActiveBorderType := fbtSunken;
  FBackground := TBitmap.Create;
  FBackground.OnChange := BackgroundChanged;
  FFlat := False;
  FFlatFocusedScrollBars := False;
  FInactiveBorderType := fbtSunkenOuter;
  FInvertSelection := False;
  FLastTopIndex := 0;
  FSelectedColor := clHighlight;
  FSelectedFont := TFont.Create;
  FSelectedFont.Color := clHighlightText;
  FSelectedFont.OnChange := SelectedFontChanged;
  FTransparent := False;
  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  FCurHintItem := -1;
  FParentThemeMode := true;
  FThemeMode := ttmPlatform;
end;

procedure TElAdvancedListBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if not (csLoading in ComponentState) then
    if (Params.Style and LBS_OWNERDRAWFIXED = 0) and
      (Params.Style and LBS_OWNERDRAWVARIABLE = 0) then
      Params.Style := Params.Style or LBS_OWNERDRAWFIXED;
  if (BorderStyle = bsSingle) and Flat and (not (IsThemed and UseXPThemes)) then
  begin
    Params.Style := Params.Style and (not WS_BORDER);
    Params.ExStyle := Params.ExStyle and (not WS_EX_CLIENTEDGE);
  end;
end;

procedure TElAdvancedListBox.CreateWnd;
begin
  inherited;
  if Style = lbStandard then Perform(CM_FONTCHANGED, 0, 0);
end;

destructor TElAdvancedListBox.Destroy;
begin
  ImageForm := nil;
  FImgFormChLink.Free;

  FBackground.Free;
  FSelectedFont.Free;
  inherited;
end;

procedure TElAdvancedListBox.DrawBackground(DC: HDC; R: TRect);
var
  X, Y: integer;
begin
  if FUseBackground and not Background.Empty then
  begin
    X := R.Left; Y := R.Top;
    while Y < R.Bottom do
    begin
      while X < R.Right do
      begin
        BitBlt(DC, X, Y, R.Right - X, R.Bottom - Y,
          Background.Canvas.Handle, 0, 0, SRCCOPY);
        Inc(X, Background.Width);
      end;
      X := R.Left;
      Inc(Y, Background.Height);
    end;
  end;
end;

procedure TElAdvancedListBox.DrawBackgroundEx(DC: HDC; R, SubR: TRect);
var
  Rgn: HRGN;
  SavedDC: integer;
begin
  SavedDC := SaveDC(DC);
  try
    Rgn := CreateRectRgnIndirect(SubR);
    try
      SelectClipRgn(DC, Rgn);
      DrawBackground(DC, R);
    finally
      DeleteObject(Rgn);
    end;
  finally
    RestoreDC(DC, SavedDC);
  end;
end;

procedure TElAdvancedListBox.DrawFlatBorder(DC: HDC; HDragging, VDragging :
    boolean);
var
  R : TRect;
  BS: TElFlatBorderType;
  MustRelease: boolean;
  AColor : TColor;
  ARgn,
  Crgn   : HRgn;

const BordersFlat : array[boolean] of Integer = (0, WS_BORDER);
      Borders3D : array[boolean] of Integer = (0, WS_EX_CLIENTEDGE);

begin
  if not HandleAllocated then exit;
  if IsThemed then
  begin
    if (BorderStyle = bsNone) then exit;

    ARgn := CreateRectRgnIndirect(R);
    R := ClientRect;
    CRgn := CreateRectRgnIndirect(R);
    CombineRgn(ARgn, ARgn, CRgn, RGN_DIFF);
    RedrawWindow(Handle, nil, ARgn, RDW_INVALIDATE or RDW_FRAME or RDW_UPDATENOW);
    DeleteObject(ARgn);
    DeleteObject(CRgn);
    exit;
  end;

  MustRelease := (DC = 0);
  if MustRelease then DC := GetWindowDC(Handle);
  R := Rect(0, 0, Width, Height);
  try
    if (BorderStyle = bsSingle) then
    begin
      if Focused or FMouseOver then
        BS := FActiveBorderType
      else
        BS := FInactiveBorderType;
      if Focused or FMouseOver then
        AColor := LineBorderActiveColor
      else
        AColor := LineBorderInactiveColor;
      DrawFlatFrameEx2(DC, R, AColor, Color, Focused or FMouseOver, Enabled, FBorderSides, BS, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow);
    end;
    if FFlatFocusedScrollBars or not (Focused or FMouseOver) then
      DrawFlatScrollbars(Handle, DC, R,
        (Focused or FMouseOver) and not FFlatFocusedScrollBars,
        ssBoth, HDragging, VDragging, False,
        GetWindowLong(Handle, GWL_STYLE) or BordersFlat[(not Ctl3D) and (BorderStyle = bsSingle)],
        GetWindowLong(Handle, GWL_EXSTYLE) or Borders3D[Ctl3D and (BorderStyle = bsSingle)]);
  finally
    if MustRelease then ReleaseDC(Handle, DC);
  end;
end;

function TElAdvancedListBox.GetParentCtlWidth: Integer;
var ACtl : TWinControl;
begin

  ACtl := FImgForm.GetRealControl;

  result := ACtl.ClientWidth;
end;

function TElAdvancedListBox.GetParentCtlHeight: Integer;
var ACtl : TWinControl;
begin
  ACtl := FImgForm.GetRealControl;
  result := ACtl.ClientHeight;
end;

function TElAdvancedListBox.RealScreenToClient(APoint : TPoint): TPoint;
var ACtl : TWinControl;
begin
  ACtl := FImgForm.GetRealControl;
  result := ACtl.ScreenToClient(APoint);
end;

procedure TElAdvancedListBox.DrawItem(Index: Integer; R: TRect; State: TOwnerDrawState);
var
  Flags, TextColor, BackColor: longint;
  TextRect: TRect;
  R1,
  BgRect  : TRect;
  P       : TPoint;
  ax, ay  : integer;
  begin
  if (Style <> lbStandard) and Assigned(OnDrawItem) then
    OnDrawItem(Self, Index, R, State )
  else
  begin
    TextColor := GetTextColor(Canvas.Handle);
    BackColor := GetBkColor(Canvas.Handle);
    if (odSelected in State) and (not FInvertSelection) and FTransparentSelection then
    Canvas.Font.Color := Font.Color;

    if (odSelected in State) and (not FInvertSelection) and (not FTransparentSelection) then
    begin
      Canvas.Brush.Color := FSelectedColor;
      Canvas.FillRect(R);
    end
    else
    if (FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in Componentstate)) then
    begin
      if (FImgForm.Control <> Self) then
      begin
        R1 := R;
        BgRect := R;
        BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
        P := ClientToScreen(ClientRect.TopLeft);
        ax := BgRect.Left - P.x;
        ay := BgRect.Top - P.y;

        BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);

        BgRect.TopLeft := RealScreenToClient(BgRect.TopLeft);
        BgRect.BottomRight := RealScreenToClient(BgRect.BottomRight);
        FImgForm.PaintBkgnd(Canvas.Handle, R1, Point(BgRect.Left - ax, BgRect.Top - ay), false);
      end;
      if (BgRect.Bottom > GetParentCtlHeight) or
         (BgRect.Right  > GetParentCtlWidth) or
         (BgRect.Left < 0) or (BgRect.Top < 0) then
        Canvas.FillRect(R);
    end else
    if FTransparent then
      DrawParentControlEx(Canvas.Handle, R)
    else
    if FUseBackground and not Background.Empty then
      DrawBackgroundEx(Canvas.Handle, ClientRect, R)
    else
    if not FTransparentSelection then
        Canvas.FillRect(R);
    if (odSelected in State) and FInvertSelection then
      InvertRect(Canvas.Handle, R);
    if (odSelected in State) and (not FTransparentSelection)then
      Canvas.Font.Assign(FSelectedFont);
    if Index < Items.Count then
    begin
      TextRect := R;
      Flags := DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX;
      Flags := DrawTextBiDiModeFlags(Flags);
      if not UseRightToLeftAlignment then
        Inc(TextRect.Left, 2)
      else
        Dec(TextRect.Right, 2);
      SetBkMode(Canvas.Handle, Windows.TRANSPARENT);
      DrawText(Canvas.Handle, PChar(Items[Index]), Length(Items[Index]), TextRect, Flags);
      end;
    SetTextColor(Canvas.Handle, TextColor);
    SetBkColor(Canvas.Handle, BackColor);
    end;
end;

procedure TElAdvancedListBox.DrawParentControl(DC: HDC);
var
  SavedDC: integer;
  P: TPoint;
begin
  if Assigned(Parent) then
  begin
    SavedDC := SaveDC(DC);
    try
      P := Parent.ScreenToClient(ClientOrigin);
      MoveWindowOrg(DC, -P.X, -P.Y);
      Parent.Perform(WM_ERASEBKGND, DC, 0);
      Parent.Perform(WM_PAINT, DC, 0);
      THackWinControl(Parent).PaintControls(DC, nil);
    finally
      RestoreDC(DC, SavedDC);
    end;
  end;
end;

procedure TElAdvancedListBox.DrawParentControlEx(DC: HDC; R: TRect);
var
  Rgn: HRGN;
  SavedDC: integer;
begin
  SavedDC := SaveDC(DC);
  try
    Rgn := CreateRectRgnIndirect(R);
    try
      SelectClipRgn(DC, Rgn);
      DrawParentControl(DC);
    finally
      DeleteObject(Rgn);
    end;
  finally
    RestoreDC(DC, SavedDC);
  end;
end;

function TElAdvancedListBox.GetBackground: TBitmap;
begin
  Result := FBackground;
end;

procedure TElAdvancedListBox.LBGetTopIndex(var Msg: TMessage);
var
  R: TRect;
begin
  inherited;
  if (FLastTopIndex <> Msg.Result) and (FUseBackground and not Background.Empty) then
  begin
    R := ClientRect;
    InvalidateRect(Handle, @R, False);
    FLastTopIndex := Msg.Result;
  end;
end;

procedure TElAdvancedListBox.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FImgForm then
    begin
      FImgForm := nil;
      Invalidate;
    end;
    end;
end;

procedure TElAdvancedListBox.Loaded;
begin
  inherited;
  RecreateWnd;
end;

{------------------------------------------------------------------------------}
function TElAdvancedListBox.GetUseXPThemes: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

{------------------------------------------------------------------------------}
procedure TElAdvancedListBox.ReadUseXPThemes(Reader: TReader);
begin
  SetUseXPThemes(Reader.ReadBoolean);
end;

{------------------------------------------------------------------------------}
procedure TElAdvancedListBox.DoThemeChanged;
begin
  // Delphi 2k7 fix
  if (UseThemeMode <> ttmNone) and HandleAllocated and not (csDestroying in ComponentState) then
  begin
    if Showing and (ComponentState * [csLoading, csReading] = []) then
      begin
        // Recalculate frame size
        SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
        // Repaint frame
        RedrawWindow(Handle, nil, 0, {RDW_FRAME or }RDW_INVALIDATE or RDW_ERASE);
      end;
  end
  else
    Invalidate;
end;

{------------------------------------------------------------------------------}
function TElAdvancedListBox.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

{------------------------------------------------------------------------------}
procedure TElAdvancedListBox.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
  begin
    FThemeGlobalMode := Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TElAdvancedListBox.SetThemeMode(const Value: TLMDThemeMode);
begin
  if Value <> FThemeMode then
  begin
    FThemeMode:= Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TElAdvancedListBox.SetUseXPThemes(const Value: Boolean);
begin
  if UseXPThemes <> Value then
  begin
    ThemeMode := LMDCtlXP[Value];
  end;
end;

{------------------------------------------------------------------------------}
function TElAdvancedListBox.UseThemeMode: TLMDThemeMode;
begin
  result := FThemeMode;
  if ParentThemeMode and Assigned(Parent) and IsPublishedProp(Parent, 'ThemeMode') then
    result := TLMDThemeMode(GetOrdProp(Parent, 'ThemeMode'))
  else
    if FThemeGlobalMode then
      result := LMDApplication.ThemeGlobalMode;
  result := LMDThemeServices.UseTheme(result);
end;

{------------------------------------------------------------------------------}
procedure TElAdvancedListBox.UpdateStyle;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TElAdvancedListBox.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('UseXPThemes', ReadUseXPThemes, nil, false);
end;

procedure TElAdvancedListBox.SelectedFontChanged(Sender: TObject);
begin
  ParentFont := False;
end;

procedure TElAdvancedListBox.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TElAdvancedListBox.SetImageForm(newValue : TElImageForm);
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
    if FImgForm <> nil then FImgForm.RegisterChanges(FImgFormChLink);
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
  end;
end;

procedure TElAdvancedListBox.SetActiveBorderType(const Value:
    TElFlatBorderType);
begin
  if FActiveBorderType <> Value then
  begin
    FActiveBorderType := Value;
    if Focused or FMouseOver then DrawFlatBorder(0, false, false);
    end;
end;

procedure TElAdvancedListBox.SetBackground(const Value: TBitmap);
begin
  FBackground.Assign(Value);
end;

procedure TElAdvancedListBox.SetFlat(const Value: boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    RecreateWnd;
    end;
end;

procedure TElAdvancedListBox.SetFlatFocusedScrollBars(const Value: boolean);
begin
  if FFlatFocusedScrollBars <> Value then
  begin
    FFlatFocusedScrollBars := Value;
    if Focused then DrawFlatBorder(0, false, false);
  end;
end;

procedure TElAdvancedListBox.SetInactiveBorderType(const Value:
    TElFlatBorderType);
begin
  if FInactiveBorderType <> Value then
  begin
    FInactiveBorderType := Value;
    if not Focused and not FMouseOver then DrawFlatBorder(0, false, false);
    end;
end;

procedure TElAdvancedListBox.SetInvertSelection(const Value: boolean);
begin
  if FInvertSelection <> Value then
  begin
    FInvertSelection := Value;
    if (MultiSelect and (SelCount > 0)) or (ItemIndex > -1) then Invalidate;
  end;
end;

procedure TElAdvancedListBox.SetSelectedColor(const Value: TColor);
begin
  if FSelectedColor <> Value then
  begin
    FSelectedColor := Value;
    if (MultiSelect and (SelCount > 0)) or (ItemIndex > -1) then Invalidate;
  end;
end;

procedure TElAdvancedListBox.SetSelectedFont(const Value: TFont);
begin
  FSelectedFont.Assign(Value);
end;

procedure TElAdvancedListBox.SetTransparent(const Value: boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
  end;
end;

procedure TElAdvancedListBox.SetUseBackground(const Value: boolean);
begin
  if FUseBackground <> Value then
  begin
    FUseBackground := Value;
    Invalidate;
  end;
end;

procedure TElAdvancedListBox.WMEraseBkgnd(var Msg: TWMEraseBkgnd);

var
  R1, BgRect : TRect;
  begin
  if (FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in Componentstate)) then
  begin
    R1 := ClientRect;
    BgRect := ClientRect;
    BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);

    BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
    BgRect.TopLeft := RealScreenToClient(BgRect.TopLeft);
    BgRect.BottomRight := RealScreenToClient(BgRect.BottomRight);

    FImgForm.PaintBkgnd(Msg.DC, R1, Point(BgRect.Left{ - ax}, BgRect.Top{ - ay}), false);
  end else
  if FTransparent then
    DrawParentControl(Msg.DC)
  else
  if FUseBackground and not Background.Empty then
    DrawBackground(Msg.DC, ClientRect)
  else inherited;
end;

procedure TElAdvancedListBox.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  if not HandleAllocated then exit;
  if Flat and not FMouseOver then DrawFlatBorder(0, false, false);
end;

procedure TElAdvancedListBox.WMPaint(var Msg: TWMPaint);
var
  DC: HDC;
  R1, BgRect : TRect;
  P          : TPoint;
  ax, ay     : integer;
  begin
  if FTransparent or (FUseBackground and not Background.Empty)
  or ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in Componentstate)))
  then
  begin
    Perform(LB_GETTOPINDEX, 0, 0);
    inherited;
    if Items.Count = 0 then
    begin
      DC := GetDC(Handle);
      try
        if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.Componentstate)) then
        begin
          if (FImgForm.Control <> Self) then
          begin
            R1 := ClientRect;
            BgRect := ClientRect;
            BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
            P := ClientToScreen(ClientRect.TopLeft);
            ax := BgRect.Left - P.x;
            ay := BgRect.Top - P.y;

            BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
            BgRect.TopLeft := RealScreenToClient(BgRect.TopLeft);
            BgRect.BottomRight := RealScreenToClient(BgRect.BottomRight);

            FImgForm.PaintBkgnd(DC, R1, Point(BgRect.Left - ax, BgRect.Top - ay), false);
          end
        end
        else
        if FTransparent then
          DrawParentControl(DC)
        else
          DrawBackground(DC, ClientRect);
      finally
        ReleaseDC(Handle, DC);
      end;
    end;
  end
  else
    inherited;
  if FFlat and (not IsThemed) then
  begin
    DC := GetWindowDC(Handle);
    try
      DrawFlatBorder(DC, FInHScroll, FInVScroll);
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;

procedure TElAdvancedListBox.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if Flat and not FMouseOver then DrawFlatBorder(0, false, false);
end;

procedure TElAdvancedListBox.WMVScroll(var Message: TWMVScroll);
begin
  inherited;
  if Message.ScrollCode = SB_THUMBTRACK then
    FInVSCroll := true
  else
  if Message.ScrollCode = SB_THUMBPOSITION then
    FInVSCroll := false;

  if Visible and (Flat and (((not FMouseOver) and (not Focused)) or (FlatFocusedScrollBars))) then
    DrawFlatBorder(0, FInHScroll, FInVScroll);
end;

procedure TElAdvancedListBox.WMHScroll(var Message: TWMVScroll);
begin
  inherited;
  if Message.ScrollCode = SB_THUMBTRACK then
    FInHSCroll := true
  else
  if Message.ScrollCode = SB_THUMBPOSITION then
    FInHSCroll := false;

  if Visible and (Flat and (((not FMouseOver) and (not Focused)) or (FlatFocusedScrollBars))) then
    DrawFlatBorder(0, FInHScroll, FInVScroll);
end;

procedure TElAdvancedListBox.WMNCMouseMove(var Message: TMessage);
begin
  inherited;
  if FInVScroll or FInHScroll then
  begin
    if (Flat and
       (((not FMouseOver) and
         (not Focused)) or
       (FlatFocusedScrollBars)))
     then DrawFlatBorder(0, FInHScroll, FInVScroll);
  end;
end;

procedure TElAdvancedListBox.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
  if FInVScroll or FInHScroll then
  begin
    if (Flat and
       (((not FMouseOver) and
         (not Focused)) or
       (FlatFocusedScrollBars))) then
      DrawFlatBorder(0, FInHScroll, FInVScroll);
  end;
  IntMouseMove(Message.XPos, Message.YPos);
end;

{$ifdef LMD_UNICODE}
procedure TElAdvancedListBox.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;

procedure TElAdvancedListBox.CMHintShow(var Message:TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message); //outcommented VB Dec 2008
end;
{$ENDIF}

procedure TElAdvancedListBox.HintWndProc(var Message: TMessage);
begin
  FHintWndProc(Message);
  if (Message.Msg = WM_SHOWWINDOW) and (Message.wParam = 0) then
  begin
    FHintWnd.WindowProc := FHintWndProc;
    CancelLineHint;
  end;
end;

procedure TElAdvancedListBox.OnLineHintTimer(Sender : TObject);
var i : integer;
    P : TPoint;
    R,
    R1: TRect;
begin
  FHintTimer.Enabled := false;
  if FHintWnd = nil then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);
    i := ItemAtPos(P, true);//SendMessage(Handle, LB_ITEMFROMPOINT, 0, MakeLParam(P.X, P.Y));
    if (i < 0) or (i >= Items.Count) then exit;

    if GetItemWidth(i) < ClientWidth then
      FCurHintItem := -1
    else
    if (i <> FCurHintItem) or (i < 0) or (i >= Items.Count) then
    begin
      if LMDInRange(i, 0, Items.Count - 1) then
      begin
        FCurHintItem := i;
        FHintTimer.Enabled := true;
      end
      else
        FCurHintItem := -1;
    end
    else
    begin
      FHintWnd := CreateHintWindow;
      R := FHintWnd.CalcHintRect(10000, Items[i], nil);
      R1 := ItemRect(i);
      // SendMessage(Handle, LB_GETITEMRECT, i, LPARAM(@R1));
      OffsetRect(R, R1.Left - 3, R1.Top - 3);
      R.TopLeft := ClientToScreen(R.TopLeft);
      R.BottomRight := ClientToScreen(R.BottomRight);
      FHintWnd.ActivateHint(R, Items[i]);
      FHintWndProc := FHintWnd.WindowProc;
      FHintWnd.WindowProc := HintWndProc;
      FHintTimer.Interval := Application.HintHidePause;
      FHintTimer.Enabled := true;
    end;
  end
  else
  begin
    FHintWnd.Free;
    FHintWnd := nil;
  end;
end;

procedure TElAdvancedListBox.CancelLineHint;
begin
  if FHintTimer <> nil then
    FHintTimer.Enabled := false;
  if FHintWnd <> nil then
  begin
    FHintWnd.Free;
    FHintWnd := nil;
  end;
end;

procedure TElAdvancedListBox.IntMouseMove(XPos, YPos : SmallInt);
var i : integer;
begin
  if (TopIndex <> -1) then
  begin
    i := TopIndex + (YPos div ItemHeight - 1);
    if YPos mod ItemHeight > 0 then
      inc(i);
    if i <> FCurHintItem then
    begin
      if FHintTimer <> nil then
        CancelLineHint;
      if ShowLineHint and (i < Items.Count) then
      begin
        FCurHintItem := i;
        if FHintTimer = nil then
          FHintTimer := TTimer.Create(nil);
        FHintTimer.Enabled := false;
        FHintTimer.OnTimer := OnLineHintTimer;
        FHintTimer.Interval:= Application.HintPause;
        FHintTimer.Enabled := True;
      end
      else
        FCurHintItem := -1;
    end;
  end;
end;

procedure TElAdvancedListBox.SetTransparentSelection(Value: Boolean);
begin
  if FTransparentSelection <> Value then
  begin
    FTransparentSelection := Value;
    if ItemIndex > -1 then Invalidate;
  end;
end;

procedure TElAdvancedListBox.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TElAdvancedListBox.WMNCCalcSize(var Message : TWMNCCalcSize);

begin
  inherited;
  if (BorderStyle = bsSingle) and Flat and (not (IsThemed and UseXPThemes)) then
    begin
      if (ebsLeft in BorderSides) then
        inc(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(SM_CYEDGE));
      if (ebsTop in BorderSides) then
        inc(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(SM_CXEDGE));
      if (ebsRight in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(SM_CYEDGE));
      if (ebsBottom in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(SM_CXEDGE));
      end
  else
    if (BorderStyle = bsSingle) then
      begin
        if not (ebsLeft in BorderSides) then
          dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(SM_CYEDGE));
        if not (ebsTop in BorderSides) then
          dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(SM_CXEDGE));
        if not (ebsRight in BorderSides) then
          Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(SM_CYEDGE));
        if not (ebsBottom in BorderSides) then
          Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(SM_CXEDGE));
      end;
end;

procedure TElAdvancedListBox.SetStyle(Value: TListBoxStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    FCurHintItem := -1;
    inherited Style := Value;
  end;
end;

procedure TElAdvancedListBox.WndProc(var Message: TMessage);
begin
  if not HorizontalScroll then
    inherited WndProc(Message)
  else
  case Message.Msg of
    LB_ADDSTRING, LB_INSERTSTRING:
      begin
        inherited WndProc(Message);
        FMaxWidth := Max(FMaxWidth, GetItemWidth(Message.Result));
        SetHorizontalExtent;
      end;
    LB_DELETESTRING:
      begin
        if GetItemWidth(Message.wParam) >= FMaxWidth then
        begin
          Perform(WM_HSCROLL, SB_TOP, 0);
          inherited WndProc(Message);
          ResetHorizontalExtent;
        end
        else
          inherited WndProc(Message);
      end;
    LB_RESETCONTENT:
      begin
        FMaxWidth := 0;
        SetHorizontalExtent;
        Perform(WM_HSCROLL, SB_TOP, 0);
        inherited WndProc(Message);
      end;
    WM_SETFONT:
      begin
        inherited WndProc(Message);
        Canvas.Font.Assign(Self.Font);
        ResetHorizontalExtent;
        Exit;
      end;
    else
      inherited WndProc(Message);
  end;
end;

procedure TElAdvancedListBox.SetHorizontalScroll(Value: Boolean);
begin
  if FHorizontalScroll <> Value then
  begin
    FHorizontalScroll := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

function TElAdvancedListBox.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_ELCORE;
end;

function TElAdvancedListBox.GetItemWidth(Index: Integer): Integer;
var
  ATabWidth: Longint;
  S: string;
  begin
  S := Items[Index] + 'W';
  if TabWidth > 0 then
  begin
    ATabWidth := Round((TabWidth * Canvas.TextWidth('0')) * 0.25);
    Result := LoWord(GetTabbedTextExtent(Canvas.Handle, @S[1], Length(S), 1, ATabWidth));
  end
  else
  Result := Canvas.TextWidth(S);
end;

procedure TElAdvancedListBox.ResetHorizontalExtent;
var
  I: Integer;
begin
  FMaxWidth := 0;
  for I := 0 to Items.Count - 1 do
    FMaxWidth := Max(FMaxWidth, GetItemWidth(I));
  SetHorizontalExtent;
end;

procedure TElAdvancedListBox.SetHorizontalExtent;
begin
  SendMessage(Handle, LB_SETHORIZONTALEXTENT, FMaxWidth, 0);
end;

function TElAdvancedListBox.CreateHintWindow: THintWindow;
begin
  Result := TListBoxHintWindow.Create(nil);
end;

procedure TElAdvancedListBox.IFMRepaintChildren(var Message: TMessage);
var i : integer;
begin
  inherited;
  Invalidate;
  for i := 0 to ControlCount -1 do
  begin
    if Controls[i] is TWinControl then
      PostMessage(TWinControl(Controls[i]).Handle, Message.Msg, Message.wParam, Message.lParam);
  end;
end;

procedure TElAdvancedListBox.WMWindowPosChanged(var Message:
    TWMWindowPosChanged);
begin
  inherited;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
end;

{
procedure TElAdvancedListBox.WMNCPaint(var Msg : TMessage);
var DC : HDC;
    R,
    R1,
    R2 : TRect;
begin
  inherited;
  if XPThemesAvailable and (BorderStyle = bsSingle) then
  begin
    R1 := BoundsRect;
    OffsetRect(R1, -R1.Left, - R1.Top);
    R.TopLeft := Parent.ClientToScreen(BoundsRect.TopLeft);
    R.BottomRight := Parent.ClientToScreen(BoundsRect.BottomRight);
    R2 := ClientRect;
    OffsetRect(R2, ClientOrigin.X - R.Left, ClientOrigin.Y - R.Top);

    DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
    if DC <> 0 then
    begin
      with R2 do
        ExcludeClipRect(DC, Left, Top, Right, Bottom);
      DrawThemeBackgroundTo('EDIT', DC, 0, 0, R1, nil)
    end
    else
    begin
      DC := GetWindowDC(Handle);
      with R2 do
        ExcludeClipRect(DC, Left, Top, Right, Bottom);
      DrawThemeBackgroundTo('EDIT', DC, 0, 0, R1, nil)
    end;
    ReleaseDC(Handle, DC);
  end
end;
}

procedure TElAdvancedListBox.WMNCPaint(var Msg : TMessage);
var DC : HDC;
    RW,
    RC : TRect;
begin

  inherited;
  if IsThemed and (BorderStyle = bsSingle) then
  begin
    DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
    if DC = 0 then
    begin
      DC := GetWindowDC(Handle);
    end;

    Windows.GetClientRect(Handle, RC);
    if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0 then
      inc(RC.Right, GetSystemMetrics(SM_CXVSCROLL));
    if GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0 then
      inc(RC.Bottom, GetSystemMetrics(SM_CYHSCROLL));
    GetWindowRect(Handle, RW);
    MapWindowPoints(0, Handle, RW, 2);
    OffsetRect(RC, -RW.Left, -RW.Top);
    ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
    OffsetRect(RW, -RW.Left, -RW.Top);

    LMDThemeServices.DrawElement(UseThemeMode, DC, tlListviewDontCare, RW, nil);
    ReleaseDC(Handle, DC);
  end;
end;

procedure TElAdvancedListBox.ELThemeChanged(var Message: TMessage);
begin
  if IsThemed and UseXPThemes then
  begin
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
    RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE);
  end;
  Message.Result := 1;
end;

procedure TElAdvancedListBox.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then Invalidate;
  end;
end;

procedure TElAdvancedListBox.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then Invalidate;
  end;
end;

procedure TElAdvancedListBox.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

{$ifdef LMD_UNICODE}
procedure TElAdvancedMemo.CMHintShow(var Message:TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message); //outcommented VB Dec 2008
end;

procedure TElAdvancedMemo.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF}

{ TElFlatMemo }

procedure TElAdvancedMemo.BackgroundChanged(Sender: TObject);
begin
  Invalidate;
  Perform(CM_COLORCHANGED, 0, 0);
  end;

procedure TElAdvancedMemo.Change;
begin
  DoPaint;
  inherited;
  if Assigned(Self.FValidator) then
    Self.FValidator.Validate(Self);
end;

procedure TElAdvancedMemo.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  FMouseOver := True;
  if LMDSIWindowsVistaUp then
    SendMessage(Handle, WM_NCPAINT, 0, 0);
  if IsThemed or
     (Flat and (not Focused) and
      //((ScrollBars <> ssNone) and (not FlatFocusedScrollbars)) and
      ((InactiveBorderType <> ActiveBorderType)) or ((InactiveBorderType = fbtColorLineBorder) and (LineBorderActiveColor <> LineBorderInactiveColor))) then DrawFlatBorder(0);
  DoMouseEnter;
end;

procedure TElAdvancedMemo.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
  FMouseOver := False;
  if LMDSIWindowsVistaUp then
    SendMessage(Handle, WM_NCPAINT, 0, 0);
  if IsThemed or
     (Flat and (not Focused) and
      //((ScrollBars <> ssNone) and (not FlatFocusedScrollbars)) and
      ((InactiveBorderType <> ActiveBorderType)) or ((InactiveBorderType = fbtColorLineBorder) and (LineBorderActiveColor <> LineBorderInactiveColor))) then DrawFlatBorder(0);
  DoMouseLeave;
end;

procedure TElAdvancedMemo.CMParentColorChanged(var Msg: TMessage);
begin
  inherited;
  if FTransparent or (FUseBackground and not FBackground.Empty)
  or ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in Componentstate)))
  then
    Invalidate;
end;

procedure TElAdvancedMemo.CNCtlColorEdit(var Msg: TWMCtlColorEdit);
begin
  inherited;
  if FTransparent or (FUseBackground and not FBackground.Empty)
  or ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in Componentstate)))
  then
    SetBkMode(Msg.ChildDC, Windows.TRANSPARENT);
end;

procedure TElAdvancedMemo.CNCtlColorStatic(var Msg: TWMCtlColorStatic);
begin
  inherited;
  if FTransparent or (FUseBackground and not FBackground.Empty)
  or ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in Componentstate)))
  then
  SetBkMode(Msg.ChildDC, Windows.TRANSPARENT);
end;

constructor TElAdvancedMemo.Create(AOwner: TComponent);
begin
  inherited;
  FActiveBorderType := fbtSunken;
  FBackground := TBitmap.Create;
  FBackground.OnChange := BackgroundChanged;
  FBorderSides := [ebsLeft, ebsTop, ebsRight, ebsBottom];
  FFlat := False;
  FFlatFocusedScrollBars := False;
  FInactiveBorderType := fbtSunkenOuter;
  FMouseOver := False;
  FPainting := False;
  FPaintingTo := False;
  FTransparent := False;
  FUseBackground := False;
  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  FParentThemeMode := true;
  FThemeMode := ttmPlatform;
end;

destructor TElAdvancedMemo.Destroy;
begin
  ImageForm := nil;
  FImgFormChLink.Free;
  FBackground.Free;
  inherited;
end;

procedure TElAdvancedMemo.DoMouseEnter;
begin
  if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;

procedure TElAdvancedMemo.DoMouseLeave;
begin
  if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TElAdvancedMemo.DoPaint;
const
  BorderOffsets: array [TBorderStyle] of integer = (1, -1);
var
  CtlDC, TempDC: HDC;
  OldBmp, TempBmp: HBITMAP;
begin
  FPainting := True;
  if FTransparent or (FUseBackground and not FBackground.Empty)
  or ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in Componentstate)))
  then
  begin
    HideCaret(Handle);
    CtlDC := GetDC(Handle);
    try
      TempDC := CreateCompatibleDC(CtlDC);
      try
        TempBmp := CreateCompatibleBitmap(CtlDC, ClientWidth + 1, ClientHeight + 1);
        try
          OldBmp := SelectObject(TempDC, TempBmp);
          FPaintingTo := True;
          try
            PaintTo(TempDC, 0, 0);
          finally
            FPaintingTo := False;
          end;
          if IsThemed or FFlat then DrawFlatBorder(TempDC);
          BitBlt(CtlDC, BorderOffsets[BorderStyle], BorderOffsets[BorderStyle], ClientWidth, ClientHeight, TempDC, 1, 1, SRCCOPY);
          SelectObject(TempDC, OldBmp);
        finally
          DeleteObject(TempBmp);
        end;
      finally
        DeleteDC(TempDC);
      end;
    finally
      ReleaseDC(Handle, CtlDC);
    end;
    ShowCaret(Handle);
  end;
  FPainting := False;
end;

procedure TElAdvancedMemo.DrawBackground(DC: HDC; R: TRect);
var
  X, Y: integer;
begin
  if FUseBackground and not FBackground.Empty then
  begin
    X := R.Left; Y := R.Top;
    while Y < R.Bottom do
    begin
      while X < R.Right do
      begin
        BitBlt(DC, X, Y, R.Right - X, R.Bottom - Y,
          FBackground.Canvas.Handle, 0, 0, SRCCOPY);
        Inc(X, FBackground.Width);
      end;
      X := R.Left;
      Inc(Y, FBackground.Height);
    end;
  end;
end;

procedure TElAdvancedMemo.DrawFlatBorder(DC: HDC);
var
  R : TRect;
  BS: TElFlatBorderType;
  MustRelease: boolean;
  AColor : TColor;
  ARgn,
  CRgn   : HRgn;
const BordersFlat : array[boolean] of Integer = (0, WS_BORDER);
      Borders3D : array[boolean] of Integer = (0, WS_EX_CLIENTEDGE);

begin
  //if (BorderStyle = bsNone) and (not IsThemeApplied) then exit;
  if not HandleAllocated then exit;
  if IsThemed then
  begin
    if (BorderStyle = bsNone) then exit;
    ARgn := CreateRectRgnIndirect(R);
    R := ClientRect;
    CRgn := CreateRectRgnIndirect(R);
    CombineRgn(ARgn, ARgn, CRgn, RGN_DIFF);
    RedrawWindow(Handle, nil, ARgn, RDW_INVALIDATE or RDW_FRAME or RDW_UPDATENOW);
    DeleteObject(ARgn);
    DeleteObject(CRgn);
    exit;
  end;
  MustRelease := (DC = 0);
  if MustRelease then
    DC := GetWindowDC(Handle);
  R := Rect(0, 0, Width, Height);
  try
    if (BorderStyle = bsSingle) then
    begin
      if Focused or FMouseOver then
        BS := FActiveBorderType
      else
        BS := FInactiveBorderType;
      if Focused or FMouseOver then
        AColor := LineBorderActiveColor
      else
        AColor := LineBorderInactiveColor;
      DrawFlatFrameEx2(DC, R, AColor, Color, Focused or FMouseOver, Enabled, FBorderSides, BS, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow);
    end;
    if FFlatFocusedScrollBars or not (Focused or FMouseOver) then
      DrawFlatScrollbars(Handle, DC, R,
        (Focused or FMouseOver) and not FFlatFocusedScrollBars,
        ScrollBars, False, False, False,
        GetWindowLong(Handle, GWL_STYLE) or BordersFlat[(not Ctl3D) and (BorderStyle = bsSingle)],
        GetWindowLong(Handle, GWL_EXSTYLE) or Borders3D[Ctl3D and (BorderStyle = bsSingle)]);
  finally
    if MustRelease then ReleaseDC(Handle, DC);
  end;
end;

procedure TElAdvancedMemo.DrawParentControl(DC: HDC);
var
  SavedDC: integer;
  P: TPoint;
begin
  if Assigned(Parent) then
  begin
    SavedDC := SaveDC(DC);
    try
      P := Parent.ScreenToClient(ClientOrigin);
      MoveWindowOrg(DC, -P.X, -P.Y);
      Parent.Perform(WM_ERASEBKGND, DC, 0);
      Parent.Perform(WM_PAINT, DC, 0);
      THackWinControl(Parent).PaintControls(DC, nil);
    finally
      RestoreDC(DC, SavedDC);
    end;
  end;
end;

procedure TElAdvancedMemo.WMGetDlgCode(var Msg : TMessage);
begin
  Msg.Result := DefWindowProc(Handle, Msg.Msg, Msg.wParam, Msg.lParam);
  Msg.Result := (Msg.Result and (not DLGC_WANTALLKEYS)) or DLGC_WANTARROWS or DLGC_WANTCHARS;
  if WantReturns then Msg.Result := Msg.Result or DLGC_WANTALLKEYS;
  if WantTabs then Msg.Result := Msg.Result or DLGC_WANTTAB;
  if HandleDialogKeys then
    Msg.Result := Msg.Result or DLGC_WANTALLKEYS;
end;

procedure TElAdvancedMemo.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FImgForm then
    begin
      FImgForm := nil;
      Invalidate;
    end;
    if  Assigned(Self.FValidator) and (AComponent = Self.FValidator) then
      Self.SetValidator(nil);
  end;
end;

procedure TElAdvancedMemo.SetActiveBorderType(const Value: TElFlatBorderType);
begin
  if FActiveBorderType <> Value then
  begin
    FActiveBorderType := Value;
    if Focused or FMouseOver then DrawFlatBorder(0);
    end;
end;

procedure TElAdvancedMemo.ImageFormChange(Sender : TObject);
begin
  if HandleAllocated then
    Invalidate;
end;

procedure TElAdvancedMemo.SetImageForm(newValue : TElImageForm);
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
    if FImgForm <> nil then FImgForm.RegisterChanges(FImgFormChLink);
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
  end;
end;

procedure TElAdvancedMemo.SetBackground(const Value: TBitmap);
begin
  FBackground.Assign(Value);
end;

procedure TElAdvancedMemo.SetFlat(const Value: boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    RecreateWnd;
  end;
end;

procedure TElAdvancedMemo.SetFlatFocusedScrollBars(const Value: boolean);
begin
  if FFlatFocusedScrollBars <> Value then
  begin
    FFlatFocusedScrollBars := Value;
    if Focused then DrawFlatBorder(0);
    end;
end;

procedure TElAdvancedMemo.SetInactiveBorderType(const Value: TElFlatBorderType);
begin
  if FInactiveBorderType <> Value then
  begin
    FInactiveBorderType := Value;
    if not Focused and not FMouseOver then DrawFlatBorder(0);
    end;
end;

procedure TElAdvancedMemo.SetTransparent(const Value: boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
  end;
end;

procedure TElAdvancedMemo.SetUseBackground(const Value: boolean);
begin
  if FUseBackground <> Value then
  begin
    FUseBackground := Value;
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
  end;
end;

procedure TElAdvancedMemo.WMEraseBkgnd(var Msg: TWMEraseBkgnd);

var
  R1,
  BgRect : TRect;
  ACtl   : TWinControl;

begin
  if (FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in FImgForm.GetRealControl.Componentstate)) then
  begin
    if (FImgForm.Control <> Self) then
    begin
      ACtl := FImgForm.GetRealControl;
      R1 := ClientRect;
      BgRect := ClientRect;
      BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
      BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
      BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
      BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);

      FImgForm.PaintBkgnd(Msg.DC, R1, Point(BgRect.Left, BgRect.Top), false);
    end;
  end
  else
  if FTransparent then
    DrawParentControl(Msg.DC)
  else
  if FUseBackground and not FBackground.Empty then
    DrawBackground(Msg.DC, ClientRect)
  else
  (*
  if IsThemeApplied then
  begin
    RW := BoundsRect;
    MapWindowPoints(Parent.Handle, Handle, RW, 2);
    if not Enabled then
      sid := ETS_DISABLED
    else
    if Focused then
      sid := ETS_FOCUSED
    else
    if ReadOnly then
      sid := ETS_READONLY
    else
      sid := ETS_NORMAL;
    DrawThemeBackground(Theme, Msg.DC, EP_EDITTEXT, sid, RW, nil);
  end
  else
  *)
    inherited;
end;

procedure TElAdvancedMemo.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  if not HandleAllocated then exit;
  if LMDSIWindowsVistaUp then
    SendMessage(Handle, WM_NCPAINT, 0, 0);
  if Flat and not FMouseOver then DrawFlatBorder(0);
end;

procedure TElAdvancedMemo.WMMove(var Msg: TWMMove);
begin
  inherited;
  Invalidate;
end;

procedure TElAdvancedMemo.WMPaint(var Msg: TWMPaint);
begin
  inherited;
  if FTransparent or (FUseBackground and not FBackground.Empty)
  or ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in Componentstate)))
  then
    if not FPainting and not FPaintingTo then DoPaint;
  if FFlat and (not IsThemed) then
    DrawFlatBorder(0);
end;

procedure TElAdvancedMemo.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if Flat and (not FMouseOver) and (not IsThemed) then DrawFlatBorder(0);
end;

procedure TElAdvancedMemo.WMKeyDown(var Message: TWMKey);
begin
  with Message do
    if (CharCode = VK_ESCAPE) and (KeyDataToShiftState(KeyData) = []) then
      GetParentForm(Self).Perform(CM_DIALOGKEY, CharCode, KeyData)
    else
      inherited;
end;

procedure TElAdvancedMemo.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TElAdvancedMemo.WMNCCalcSize(var Message : TWMNCCalcSize);

begin
  inherited;
  if (BorderStyle = bsSingle) and Flat and (not (IsThemed and UseXPThemes)) then
    begin
      if (ebsLeft in BorderSides) then
        inc(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(SM_CYEDGE));
      if (ebsTop in BorderSides) then
        inc(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(SM_CXEDGE));
      if (ebsRight in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(SM_CYEDGE));
      if (ebsBottom in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(SM_CXEDGE));
      end
  else
    if (BorderStyle = bsSingle) then
      begin
        if not (ebsLeft in BorderSides) then
          dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(SM_CYEDGE));
        if not (ebsTop in BorderSides) then
          dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(SM_CXEDGE));
        if not (ebsRight in BorderSides) then
          Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(SM_CYEDGE));
        if not (ebsBottom in BorderSides) then
          Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(SM_CXEDGE));
        end;
end;

procedure TElAdvancedMemo.IFMRepaintChildren(var Message: TMessage);
var i : integer;
begin
  inherited;
  Invalidate;
  for i := 0 to ControlCount -1 do
  begin
    if Controls[i] is TWinControl then
      PostMessage(TWinControl(Controls[i]).Handle, Message.Msg, Message.wParam, Message.lParam);
  end;
end;

procedure TElAdvancedMemo.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
end;

procedure TElAdvancedMemo.WMNCPaint(var Msg : TMessage);
var DC : HDC;
    RW,
    RC : TRect;
    LDetails: TThemedElementDetails;
begin
  inherited;
  if IsThemed and (BorderStyle = bsSingle) then
  begin
    DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
    if DC = 0 then
    begin
      DC := GetWindowDC(Handle);
    end;

    Windows.GetClientRect(Handle, RC);
    if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0 then
      inc(RC.Right, GetSystemMetrics(SM_CXVSCROLL));
    if GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0 then
      inc(RC.Bottom, GetSystemMetrics(SM_CYHSCROLL));
    GetWindowRect(Handle, RW);
    MapWindowPoints(0, Handle, RW, 2);
    OffsetRect(RC, -RW.Left, -RW.Top);
    ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
    OffsetRect(RW, -RW.Left, -RW.Top);
    if LMDSIWindowsVistaUp then
    begin
      LDetails.Element := teEdit;
      LDetails.Part := EP_EDITBORDER_VSCROLL;

      if Focused or FMouseOver then
        LDetails.State := Ord(teEditTextHot)
      else
        LDetails.State := 1;

      LMDThemeServices.DrawElement(UseThemeMode, DC, LDetails, RW);
    end
    else
      LMDThemeServices.DrawElement(UseThemeMode, Dc, teEditDontCare, RW, nil);
    ReleaseDC(Handle, DC);
  end;
end;

procedure TElAdvancedMemo.SetUseXPThemes(const Value: Boolean);
begin
  if UseXPThemes <> Value then
  begin
    ThemeMode := LMDCtlXP[Value];
    if IsThemed and HandleAllocated and not (csDestroying in ComponentState) then
    begin
      RecreateWnd;
      //RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW);
    end;
  end;
end;

{------------------------------------------------------------------------------}
function TElAdvancedMemo.GetUseXPThemes: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

{------------------------------------------------------------------------------}
procedure TElAdvancedMemo.ReadUseXPThemes(Reader: TReader);
begin
  SetUseXPThemes(Reader.ReadBoolean);
end;

{------------------------------------------------------------------------------}
procedure TElAdvancedMemo.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
  begin
    FThemeGlobalMode := Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TElAdvancedMemo.SetThemeMode(const Value: TLMDThemeMode);
begin
  if Value <> FThemeMode then
  begin
    FThemeMode:= Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TElAdvancedMemo.DoThemeChanged;
begin
  // Delphi 2k7 fix
  if (UseThemeMode <> ttmNone) and HandleAllocated and not (csDestroying in ComponentState) then
  begin
    if Showing and (ComponentState * [csLoading, csReading] = []) then
      begin
        // Recalculate frame size
        SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
        // Repaint frame
        RedrawWindow(Handle, nil, 0, {RDW_FRAME or }RDW_INVALIDATE or RDW_ERASE);
      end;
  end
  else
    Invalidate;
end;

{------------------------------------------------------------------------------}
function TElAdvancedMemo.UseThemeMode: TLMDThemeMode;
begin
  result := FThemeMode;
  if ParentThemeMode and Assigned(Parent) and IsPublishedProp(Parent, 'ThemeMode') then
    result := TLMDThemeMode(GetOrdProp(Parent, 'ThemeMode'))
  else
    if FThemeGlobalMode then
      result := LMDApplication.ThemeGlobalMode;
  result := LMDThemeServices.UseTheme(result);
end;

{------------------------------------------------------------------------------}
procedure TElAdvancedMemo.UpdateStyle;
begin
  inherited;
end;

procedure TElAdvancedMemo.DefineProperties(Filer : TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('UseXPThemes', ReadUseXPThemes, nil, false);
end;
{------------------------------------------------------------------------------}
function TElAdvancedMemo.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

procedure TElAdvancedMemo.ELThemeChanged(var Message: TMessage);
begin
  if IsThemed and UseXPThemes then
  begin
    SetWindowPos(
      Handle,
      0,
      0, 0, 0, 0,
      SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER
      );
    RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE);
  end;
  Message.Result := 1;
end;

procedure TElAdvancedMemo.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then Invalidate;
  end;
end;

procedure TElAdvancedMemo.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then Invalidate;
  end;
end;

procedure TElAdvancedMemo.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

procedure TCustomElAdvancedComboBox.CMEnter(var Msg: TCMEnter);
begin
  inherited;
  Invalidate;
end;

procedure TCustomElAdvancedComboBox.CMExit(var Msg: TCMExit);
begin
  inherited;
  Invalidate;
end;

procedure TCustomElAdvancedComboBox.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  FMouseOver := true;
  if IsThemed or
    (Flat and (not IsFocused) and
    // (not BtnThinFrame) and
    ((InactiveBorderType <> ActiveBorderType)) or ((InactiveBorderType = fbtColorLineBorder) and (LineBorderActiveColor <> LineBorderInactiveColor))) then UpdateFrame;
end;

procedure TCustomElAdvancedComboBox.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
  FMouseOver := false;

  if IsThemed or
    (Flat and (not IsFocused) and
    // (not BtnThinFrame) and
    ((InactiveBorderType <> ActiveBorderType)) or ((InactiveBorderType = fbtColorLineBorder) and (LineBorderActiveColor <> LineBorderInactiveColor))) then UpdateFrame;
end;

procedure TCustomElAdvancedComboBox.CNCommand(var Message: TWMCommand);
begin
  inherited;
  if Message.NotifyCode = CBN_DROPDOWN then
  begin
    if FDropDownWidth >= Width then
      Perform( CB_SETDROPPEDWIDTH, FDropDownWidth, 0);
  end;
  if Message.NotifyCode = CBN_CLOSEUP then Invalidate;
end;

constructor TCustomElAdvancedComboBox.Create(AOwner: TComponent);
begin
  inherited;
  TControlCanvas(Canvas).Control := Self;
  BtnCanvas := TCanvas.Create;
  FActiveBorderType := fbtSunken;
  FInactiveBorderType := fbtSunkenOuter;

  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  FListInstance := MakeObjectInstance(ListWndProc);
  FEditInstance := MakeObjectInstance(EditWndProc);
  FButtonThinFrame := true;

  FThemeMode := ttmPlatform;
  FDropDownWidth := 0;
end;

procedure TCustomElAdvancedComboBox.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FImgForm then
    begin
      FImgForm := nil;
      Invalidate;
    end;
    end;
end;

procedure TCustomElAdvancedComboBox.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TCustomElAdvancedComboBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style and not WS_BORDER;
  Params.ExStyle := (Params.ExStyle and not WS_EX_CLIENTEDGE);
  if HorizontalScroll then
    Params.Style := Params.Style or WS_HSCROLL;
end;

destructor TCustomElAdvancedComboBox.Destroy;
begin
  FImgForm := nil;
  FImgFormChLink.Free;
  BtnCanvas.Free;
  inherited;
  FreeObjectInstance(FListInstance);
  FreeObjectInstance(FEditInstance);
end;

procedure TCustomElAdvancedComboBox.DrawFlatBorder(CanvasDC: HDC; DrawButton: boolean);
var
  DC : HDC;
  R,
  rc : TRect;
  BS : TElFlatBorderType;
  AColor: TColor;
  LDetails: TThemedComboBox;
  LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  R := Rect(0, 0, Width, Height);
  if CanvasDC<>0 then
    DC := CanvasDC
  else
    DC := GetWindowDC(Handle);
  try
    if Enabled then
    begin
      if DroppedDown then
      begin
        LDetails := tcDropDownButtonPressed;
        // iStateId := CBXS_PRESSED;
      end
      else
      begin
        if FMouseOver then
        begin
          LDetails := tcDropDownButtonHot;
          // iStateId := CBXS_HOT;
        end
        else
        begin
          LDetails := tcDropDownButtonNormal;
          // iStateId := CBXS_NORMAL;
        end;
      end;
    end
    else
    begin
      LDetails := tcDropDownButtonDisabled;
//      iStateId := CBXS_DISABLED;
    end;
    if IsThemed then
    begin
      rc := ClientRect;
      rc.Right := rc.right - GetSystemMetrics(SM_CXVSCROLL);
      InflateRect(rc, -2, -2);
      with RC do
        ExcludeClipRect(DC, Left, Top, Right, Bottom);
    end;

    rc := R;

    InflateRect(rc, -1, -1);
    rc.left := rc.right - GetSystemMetrics(SM_CXVSCROLL);
    if not IsThemed then
    begin
      LMDThemeServices.DrawElement(LThemeMode, DC, teEditDontCare, R, nil);
      LMDThemeServices.DrawElement(LThemeMode, DC, LDetails, rc, nil);
      if Flat then
      begin
        if (IsFocused or FMouseOver) then
           BS := FActiveBorderType
        else
           BS := FInactiveBorderType;
      end
        else BS := fbtSunken;

      BtnCanvas.Handle := DC;
      BtnCanvas.Brush.Color := Color;
      rc := ClientRect;
      if IsFocused or FMouseOver then
        AColor := LineBorderActiveColor
      else
        AColor := LineBorderInactiveColor;
      DrawFlatFrameEx2(DC, R, AColor, Color, (IsFocused or FMouseOver), Enabled, AllBorderSides, BS, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow);
      if Color = clWindow then
        AColor := clBtnFace
      else
        AColor := Color;

      rc := ClientRect;
      //with RC do
      //  ExcludeClipRect(DC, Left, Top, Right, Bottom);

      //if XPThemesAvailable then
       //DrawThemeBackgroundTo('EDIT', DC, 0, 0, R, nil);

      rc := R;
      InflateRect(rc, -2, -2);
      rc.left := rc.right - GetSystemMetrics(SM_CXVSCROLL);
      if DrawButton then
      begin
        if ButtonTransparent then
          BtnCanvas.Brush.Color := Color
        else
          BtnCanvas.Brush.Color := AColor;
        BtnCanvas.FillRect(rc);
        BtnCanvas.Brush.Color := AColor;
        if not ButtonTransparent then
        begin
          if ButtonFlat and not DroppedDown then
          begin
            BtnCanvas.FrameRect(rc);
          end  //DrawButtonFrameEx(DC, rc, (IsFocused and Flat), DroppedDown, AColor, true)
          else
          if not ButtonTransparent then
          begin
            if Flat and (BS = fbtColorLineBorder) then
            begin
              if Focused or FMouseOver then
                AColor := LineBorderActiveColor
              else
                AColor := LineBorderInactiveColor;
              DrawFlatFrameEx2(DC, rc, AColor, BtnCanvas.Brush.Color, (not Flat) or (IsFocused or FMouseOver), Enabled, AllBorderSides, BS, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow);
            end
            else
              DrawButtonFrameEx3(DC, rc, (not Flat) or ((IsFocused or FMouseOver) and (not ButtonThinFrame)), DroppedDown, AColor, ButtonThinFrame, AllBorderSides);
          end;
        end;
        LMDDrawArrow(BtnCanvas, eadDown, rc, Font.Color, Enabled);
      end;
      BtnCanvas.Handle := 0;
    end;
  finally
    if CanvasDC=0 then
      ReleaseDC(Handle, DC);
  end;
end;

function TCustomElAdvancedComboBox.IsFocused: Boolean;
var
  WND : HWND;
begin
  if ((GetWindowLong(Handle, GWL_STYLE) and 03) = CBS_DROPDOWN) then
  begin
    Wnd := GetTopWindow(Handle);
    if (Wnd <> 0) and (Wnd = GetFocus) then
    begin
      result := true;
      exit;
    end;
  end;
  result := GetFocus = Handle;//Focused;
end;

procedure TCustomElAdvancedComboBox.SetActiveBorderType(newValue: TElFlatBorderType);
begin
  if (FActiveBorderType <> newValue) then
  begin
    FActiveBorderType := newValue;
    if Flat and (Focused or FMouseOver) then UpdateFrame;
    end;
end;

procedure TCustomElAdvancedComboBox.SetFlat(newValue: Boolean);
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    UpdateFrame;
    end;
end;

procedure TCustomElAdvancedComboBox.SetInactiveBorderType(newValue:
    TElFlatBorderType);
begin
  if (FInactiveBorderType <> newValue) then
  begin
    FInactiveBorderType := newValue;
    if Flat and not (Focused or FMouseOver) then UpdateFrame;
    end;
end;

procedure TCustomElAdvancedComboBox.UpdateFrame;
var
  R : TRect;
begin
  R := Rect(0, 0, Width, Height);
  if HandleAllocated then
     RedrawWindow(Handle, @R, 0, rdw_Invalidate or rdw_UpdateNow or rdw_Frame);
end;

procedure TCustomElAdvancedComboBox.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TCustomElAdvancedComboBox.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  if not HandleAllocated then exit;
  if Flat then UpdateFrame;
end;

procedure TCustomElAdvancedComboBox.WMNCPaint(var Msg: TMessage);
begin
  inherited;
  if Flat then
  begin
    DrawFlatBorder(0, False);
    Msg.Result := 0;
  end;
end;

procedure TCustomElAdvancedComboBox.WMPaint(var Msg: TWMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  R: TRect;
begin
  if (Msg.DC <> 0) then
    PaintHandler(Msg)
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
        R := ClientRect;

      Msg.DC := MemDC;

      InvalidateRect(MemDC, @R, false);
      Perform(WM_ERASEBKGND, MemDC, MemDC);
      WMPaint(Msg);
      DrawFlatBorder(MemDC, True);

      Msg.DC := 0;

      GetClipBox(DC, R);
      if IsRectEmpty(R) then
        R := ClientRect;
      with R do
        BitBlt(DC, Left, Top, Right, Bottom, MemDC, Left, Top, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;

procedure TCustomElAdvancedComboBox.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  Invalidate;
end;

procedure TCustomElAdvancedComboBox.WMSize(var Msg: TWMSize);
begin
  inherited;
  if Flat then UpdateFrame;
end;

procedure TCustomElAdvancedComboBox.ListWndProc(var Message : TMessage);
    procedure DrawFlatBorder(Handle : HWND; DC: HDC; InHScroll, InVScroll : boolean);
    var
      R : TRect;
      MustRelease: boolean;
    begin
      if IsThemed then
        exit;
      MustRelease := (DC = 0);
      if MustRelease then DC := GetWindowDC(Handle);
      GetWindowRect(Handle, R);
      OffsetRect(R, -R.Left, -R.Top);
      try
        if Flat then
          DrawFlatScrollbars(Handle, DC, R, false, ssBoth, InHScroll, InVScroll, False, GetWindowLong(Handle, GWL_STYLE), GetWindowLong(Handle, GWL_EXSTYLE));
      finally
        if MustRelease then ReleaseDC(Handle, DC);
      end;
    end;

begin
  if Message.Msg = WM_DESTROY then
  begin
    if (FSaveListWndProc <> 0) then
    begin
      Message.Result := CallWindowProc(Pointer(FSaveListWndProc), FListHandle, Message.Msg, Message.wParam, Message.lParam);
      SetWindowLong(FListHandle, GWL_WNDPROC, TLMDPtrInt(FSaveListWndProc));
    end;
    if assigned(ListWindowProc) then
       ListWindowProc(Message);
    //FSaveListWndProc := 0;
    //FListHandle := 0;
    exit;
  end;
  if assigned(ListWindowProc) then
    ListWindowProc(Message);
  if Message.Msg = WM_NCPAINT then
  begin
    Message.Result := CallWindowProc(Pointer(FSaveListWndProc), FListHandle, Message.Msg, Message.wParam, Message.lParam);
    DrawFlatBorder(FListHandle, 0, false, false);
  end
  else
  {
  if Message.Msg = WM_HSCROLL then
  begin
    Message.Result := CallWindowProc(Pointer(FSaveListWndProc), FListHandle, Message.Msg, Message.wParam, Message.lParam);
    if TWMScroll(Message).ScrollCode = SB_THUMBTRACK then
      FInHSCroll := true
    else
    if TWMScroll(Message).ScrollCode = SB_THUMBPOSITION then
      FInHSCroll := false;
    if Flat then
      DrawFlatBorder(FListHandle, 0, FInHScroll, FInVScroll);
  end
  else

  if Message.Msg = WM_VSCROLL then
  begin
    Message.Result := CallWindowProc(Pointer(FSaveListWndProc), FListHandle, Message.Msg, Message.wParam, Message.lParam);
    if TWMScroll(Message).ScrollCode = SB_THUMBTRACK then
      FInVSCroll := true
    else
    if TWMScroll(Message).ScrollCode = SB_THUMBPOSITION then
      FInVSCroll := false;

    if Flat then
      DrawFlatBorder(FListHandle, 0, FInHScroll, FInVScroll);
  end
  else}
  if HorizontalScroll then
  begin
    case Message.Msg of
      LB_ADDSTRING, LB_INSERTSTRING:
        begin
          Message.Result := CallWindowProc(Pointer(FSaveListWndProc), FListHandle, Message.Msg, Message.wParam, Message.lParam);
          FMaxWidth := Max(FMaxWidth, GetItemWidth(Message.Result));
          SetHorizontalExtent;
        end;
      LB_DELETESTRING:
        begin
          if GetItemWidth(Message.wParam) >= FMaxWidth then
          begin
            Message.Result := CallWindowProc(Pointer(FSaveListWndProc), FListHandle, Message.Msg, Message.wParam, Message.lParam);
            ResetHorizontalExtent;
          end
          else
            Message.Result := CallWindowProc(Pointer(FSaveListWndProc), FListHandle, Message.Msg, Message.wParam, Message.lParam);
        end;
      LB_RESETCONTENT:
        begin
          FMaxWidth := 0;
          SetHorizontalExtent;
          Message.Result := CallWindowProc(Pointer(FSaveListWndProc), FListHandle, Message.Msg, Message.wParam, Message.lParam);
        end;
      WM_SETFONT:
        begin
          Message.Result := CallWindowProc(Pointer(FSaveListWndProc), FListHandle, Message.Msg, Message.wParam, Message.lParam);
          Canvas.Font.Assign(Self.Font);
          ResetHorizontalExtent;
        end;
      else
        Message.Result := CallWindowProc(Pointer(FSaveListWndProc), FListHandle, Message.Msg, Message.wParam, Message.lParam);
    end;
  end
  else
    Message.Result := CallWindowProc(Pointer(FSaveListWndProc), FListHandle, Message.Msg, Message.wParam, Message.lParam);
end;

procedure TCustomElAdvancedComboBox.EditWndProc(var Message : TMessage);
begin
  if Message.Msg = WM_DESTROY then
  begin
    if FSaveEditWndProc <> 0 then
    begin
      SetWindowLong(FEditHandle, GWL_WNDPROC, TLMDPtrInt(FSaveEditWndProc));
      Message.Result := CallWindowProc(Pointer(FSaveEditWndProc), FEditHandle, Message.Msg, Message.wParam, Message.lParam);
    end;
    if assigned(EditWindowProc) then
      EditWindowProc(Message);
    FSaveEditWndProc := 0;
    FEditHandle := 0;
    exit;
  end
  else
  if Message.Msg = WM_CHAR then
  begin
    Message.Result := CallWindowProc(Pointer(FSaveEditWndProc), FEditHandle, Message.Msg, Message.wParam, Message.lParam);
    if AutoCompletion and (Style = csDropDown) and ( TWMChar(Message).CharCode <> VK_BACK) then
     DoAutoComplete;
    exit;
  end
  else
  if HandleDialogKeys and (Message.Msg = WM_GETDLGCODE) then
  begin
    Message.Result := CallWindowProc(Pointer(FSaveEditWndProc), FEditHandle, Message.Msg, Message.wParam, Message.lParam);
    Message.Result := Message.Result or DLGC_WANTALLKEYS;
  end
  else
  if assigned(EditWindowProc) then
    EditWindowProc(Message);
  Message.Result := CallWindowProc(Pointer(FSaveEditWndProc), FEditHandle, Message.Msg, Message.wParam, Message.lParam);
end;

procedure TCustomElAdvancedComboBox.WndProc(var Message : TMessage);
var FChildHandle : HWND;

    buf : array[0..50] of Char;

begin
  if (Message.Msg = WM_PARENTNOTIFY) then
  begin
    if LoWord(Message.wParam) = WM_DESTROY then
    begin
      if HWND(Message.lParam) = FEditHandle then
      begin
        if FSaveEditWndProc <> 0 then
        SetWindowLong(FEditHandle, GWL_WNDPROC, TLMDPtrInt(FSaveEditWndProc));
        FEditHandle := 0;
      end
      else
      if HWND(Message.lParam) = FListHandle then
      begin
        if FSaveListWndProc <> 0 then
        SetWindowLong(FListHandle, GWL_WNDPROC, TLMDPtrInt(FSaveListWndProc));
        FListHandle := 0;
      end;
    end;
  end;
  inherited;
  if (Message.Msg = WM_PARENTNOTIFY) then
  begin
    if LoWord(Message.wParam) = WM_CREATE then
    begin
      FChildHandle := Message.lParam;
      GetClassName(FChildHandle, @Buf, 50);
      if (StrPas({$ifdef lmdcomp12}PWideChar(@Buf){$else}@Buf{$endif}) = 'Edit') and
         ((GetWindowLong(Handle, GWL_STYLE) and CBS_DROPDOWN) = CBS_DROPDOWN) then
      begin
        FEditHandle := FChildHandle;
        FSaveEditWndProc := (GetWindowLong(FEditHandle, GWL_WNDPROC));
        SetWindowLong(FEditHandle, GWL_WNDPROC, TLMDPtrInt(FEditInstance));
      end
      else
      if (StrPas({$ifdef lmdcomp12}PWideChar(@Buf){$else}@Buf{$endif}) = 'ComboLBox') then
      begin
        FListHandle := FChildHandle;
        if (FSaveListWndProc = 0) then
        begin
          if FSaveListWndProc <> (GetWindowLong(FListHandle, GWL_WNDPROC)) then
          begin
            FSaveListWndProc := (GetWindowLong(FListHandle, GWL_WNDPROC));
            SetWindowLong(FListHandle, GWL_WNDPROC, TLMDPtrInt(FListInstance));
          end;
        end;
        //if HorizontalScroll then
        //  SetWindowLong(FListHandle, GWL_STYLE, GetWindowLong(FListHandle, GWL_STYLE) or WS_HSCROLL);
      end;
    end;
  end;
end;

procedure TCustomElAdvancedComboBox.ELThemeChanged(var Message: TMessage);
begin
  // Delphi 2k7 fix
  {$IFDEF LMDCOMP11}if (csDesigning in ComponentState) then exit;{$ENDIF}
  if Showing and (ComponentState * [csLoading, csReading] = []) then
    RecreateWnd;
  Message.Result := 1;
end;

procedure TCustomElAdvancedComboBox.SetHorizontalScroll(Value: Boolean);
begin
  if FHorizontalScroll <> Value then
  begin
    FHorizontalScroll := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

function TCustomElAdvancedComboBox.GetItemWidth(Index: Integer): Integer;
var
  S: string;
begin
  S := Items[Index] + 'W';
  Result := Canvas.TextWidth(S);
end;

function TCustomElAdvancedComboBox.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_ELCORE;
end;

procedure TCustomElAdvancedComboBox.SetHorizontalExtent;
begin
  //SendMessage(FListHandle, LB_SETHORIZONTALEXTENT, FMaxWidth, 0);
  SendMessage(Handle, CB_SETHORIZONTALEXTENT, FMaxWidth, 0);
end;

procedure TCustomElAdvancedComboBox.ResetHorizontalExtent;
var
  I: Integer;
begin
  FMaxWidth := 0;
  for I := 0 to Items.Count - 1 do
    FMaxWidth := Max(FMaxWidth, GetItemWidth(I));
  SetHorizontalExtent;
end;

procedure TCustomElAdvancedComboBox.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  Invalidate;
  Broadcast(Message);
end;

procedure TCustomElAdvancedComboBox.WMWindowPosChanged(var Message:
    TWMWindowPosChanged);
begin
  inherited;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
end;

procedure TCustomElAdvancedComboBox.SetUseXPThemes(const Value: Boolean);
begin
  if UseXPThemes <> Value then
  begin
    ThemeMode := LMDCtlXP[Value];
    if HandleAllocated then
      RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW);
  end;
end;

procedure TCustomElAdvancedComboBox.CreateWnd;
begin
  inherited;
  if HorizontalScroll and (ComponentState * [csLoading, csReading] = []) then
    ResetHorizontalExtent;
end;

procedure TCustomElAdvancedComboBox.SetButtonThinFrame(Value: Boolean);
begin
  if FButtonThinFrame <> Value then
  begin
    FButtonThinFrame := Value;
    Invalidate;
  end;
end;

procedure TCustomElAdvancedComboBox.SetButtonFlat(Value: Boolean);
begin
  if FButtonFlat <> Value then
  begin
    FButtonFlat := Value;
    Invalidate;
  end;
end;

procedure TCustomElAdvancedComboBox.SetButtonTransparent(Value: Boolean);
begin
  if FButtonTransparent <> Value then
  begin
    FButtonTransparent := Value;
    Invalidate;
  end;
end;

procedure TCustomElAdvancedComboBox.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then Invalidate;
  end;
end;

procedure TCustomElAdvancedComboBox.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then Invalidate;
  end;
end;

procedure TCustomElAdvancedComboBox.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

{$ifdef LMD_UNICODE}
procedure TCustomElAdvancedComboBox.CMHintShow(var Message:TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message); //outcommented VB Dec 2008
end;

procedure TCustomElAdvancedComboBox.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF}

procedure TCustomElAdvancedComboBox.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TCustomElAdvancedComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if AutoCompletion and not DroppedDown and (Shift = []) and (Style = csDropDown) then
  begin
    if (Key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT, VK_HOME, VK_END]) then
      DoAutoComplete;
  end;
  if (DroppedDown) and (Key = VK_RETURN) and (AutoCompletion) then
    DroppedDown := false;
  inherited;
end;

procedure TCustomElAdvancedComboBox.DoAutoComplete;
var i : integer;
    S : String;
    ssl: Integer;
begin
  ssl := SelStart;
  S := Copy(Text, 1, ssl);
  if Length(S) > 0 then
  begin
    for i := 0 to Pred(Items.Count) do
    begin
      if Pos(S, GetTextFromItem(i)) = 1 then
      begin
        if AutoDropDown then
          SendMessage(Handle, CB_SHOWDROPDOWN, WPARAM(i), 0);
        Text := Items[i];
        SendMessage(EditHandle, EM_SETSEL, Length(Text), ssl);
        Break;
      end;
    end;
  end;
end;

procedure TCustomElAdvancedComboBox.WMGetDlgCode(var Msg : TWMGetDlgCode);
begin
  Msg.Result := DLGC_WANTCHARS or DLGC_WANTARROWS;
  if HandleDialogKeys then Msg.Result := Msg.Result or DLGC_WANTALLKEYS;
end;

function TCustomElAdvancedComboBox.GetTextFromItem(Index : integer): string;
begin
  Result := Items[Index];
end;

procedure TCustomElAdvancedComboBox.DefineProperties(Filer : TFiler);
begin
  inherited;
  Filer.DefineProperty('BtnFlat', ReadBtnFlat, nil, false);
  Filer.DefineProperty('BtnTransparent', ReadBtnTransparent, nil, false);
  Filer.DefineProperty('BtnThinFrame', ReadBtnThinFrame, nil, false);
  Filer.DefineProperty('UseXPThemes', ReadUseXPThemes, nil, false);
end;

procedure TCustomElAdvancedComboBox.ReadBtnFlat(Reader : TReader);
begin
  ButtonFlat := Reader.ReadBoolean;
end;

procedure TCustomElAdvancedComboBox.ReadBtnTransparent(Reader : TReader);
begin
  ButtonTransparent := Reader.ReadBoolean;
end;

procedure TCustomElAdvancedComboBox.ReadBtnThinFrame(Reader : TReader);
begin
  ButtonThinFrame := Reader.ReadBoolean;
end;

procedure TCustomElAdvancedComboBox.Loaded;
begin
  inherited;
  if HorizontalScroll and HandleAllocated then
    ResetHorizontalExtent;
end;

{------------------------------------------------------------------------------}
function TCustomElAdvancedComboBox.GetUseXPThemes: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

{------------------------------------------------------------------------------}
procedure TCustomElAdvancedComboBox.ReadUseXPThemes(Reader: TReader);
begin
  SetUseXPThemes(Reader.ReadBoolean);
end;

{------------------------------------------------------------------------------}
procedure TCustomElAdvancedComboBox.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
  begin
    FThemeGlobalMode := Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TCustomElAdvancedComboBox.SetThemeMode(const Value: TLMDThemeMode);
begin
  if Value <> FThemeMode then
  begin
    FThemeMode:= Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TCustomElAdvancedComboBox.DoThemeChanged;
begin
  // Delphi 2k7 fix
  if (UseThemeMode <> ttmNone) and HandleAllocated and not (csDestroying in ComponentState) then
  begin
    if Showing and (ComponentState * [csLoading, csReading] = []) then
      begin
        // Recalculate frame size
        SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
        // Repaint frame
        RedrawWindow(Handle, nil, 0, {RDW_FRAME or }RDW_INVALIDATE or RDW_ERASE);
      end;
  end
  else
    Invalidate;
end;

{------------------------------------------------------------------------------}
function TCustomElAdvancedComboBox.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

{------------------------------------------------------------------------------}
function TCustomElAdvancedComboBox.UseThemeMode: TLMDThemeMode;
begin
  result := FThemeMode;
  if ParentThemeMode and Assigned(Parent) and IsPublishedProp(Parent, 'ThemeMode') then
    result := TLMDThemeMode(GetOrdProp(Parent, 'ThemeMode'))
  else
    if FThemeGlobalMode then
      result := LMDApplication.ThemeGlobalMode;
  result := LMDThemeServices.UseTheme(result);
end;

{------------------------------------------------------------------------------}
procedure TCustomElAdvancedComboBox.UpdateStyle;
begin
  inherited;
end;

procedure TElAdvancedMemo.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if (BorderStyle = bsSingle) and Flat and (not (IsThemed and UseXPThemes)) then
  begin
    Params.Style := Params.Style and (not WS_BORDER);
    Params.ExStyle := Params.ExStyle and (not WS_EX_CLIENTEDGE);
  end;
end;

procedure TElAdvancedMemo.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if IsThemed then
    Invalidate;
end;

function TElAdvancedMemo.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_ELCORE;
end;

function TElAdvancedMemo.GetControlBackBrush: TBrush;
begin
  Result := Self.Brush;
end;

function TElAdvancedMemo.GetControl: TControl;
begin
  Result := Self;
end;

function TElAdvancedMemo.GetControlFont: TFont;
begin
  Result := Self.Font;
end;

function TElAdvancedMemo.GetValidationMsgString: TLMDString;
begin
  Result := Self.FValidationMsgString;
end;

function TElAdvancedMemo.GetValueToValidate: TLMDString;
begin
  Result := Self.Text;
end;

procedure TElAdvancedMemo.RespondToError(ErrorLevel: TLMDErrorLevel);
begin
  FErrorIndication := ErrorLevel > 0;
  if Assigned(FOnValidationError) and FErrorIndication then
    FOnValidationError(self, ErrorLevel);
end;

procedure TElAdvancedMemo.SetValidationMsgString(val: TLMDString);
begin
  Self.FValidationMsgString := val;
end;

procedure TElAdvancedMemo.SetValidator(Validator: TLMDValidationEntity);
begin
  if Self.FValidator = Validator then Exit;
//  if Assigned(Self.FValidator) then
//    Self.FValidator.ReleaseControl(Self);
  Self.FValidator := Validator;
  if Assigned(Self.FValidator) then
    begin
      Validator.FreeNotification(Self);
  //    Self.FValidator.AcceptControl(Self);
    end;
end;

function TElAdvancedMemo.SupportsDefaultIndication: boolean;
begin
  Result := false;
end;

function TElAdvancedMemo.GetValidator: TLMDValidationEntity;
begin
  Result := Self.FValidator;
end;

end.
