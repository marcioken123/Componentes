unit ElListBox;
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

ElListBox unit
--------------

ToDo:
-----
- TElListBox.ItemIndex in MultiSelect mode cannot be -1.

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

30 November, 2007 (RS)
 - Validation support added to TCustomElEdit;

###############################################################################}

interface

uses
  StdCtrls, Windows, SysUtils, Messages, Classes,
  Controls, Graphics, Consts, Forms, Math, Menus, ImgList, CommCtrl,
  RTLConsts, Types, Themes,Imm,

  LMDProcs, LMDClass, LMDThemes, LMDUnicodeStrings, {$IFDEF LMD_UNICODE}LMDUnicode,{$endif}
  LMDUtils, LMDGraphUtils, LMDGraph, LMDElConst, LMDTypes,  LMDVldBase,

  ElImgFrm,  ExtCtrls, ElHintWnd, ElXPThemedControl,
  ElInputProcessor, LMDStrings, ElSBCtrl, ElVCLUtils;

type
    //@+ 2/5/03
    TElCheckBoxChangeEvent = procedure(aSender: TObject; aItemIndex: Integer; aItemState: TCheckBoxState) of object;
    //@- 2/5/03

    TDrawTextEvent = procedure (Sender : TObject; ACanvas: TCanvas; Index: integer;
      var Rect: TRect; Flags: LongInt) of object;

    TElCheckStateChangeEvent = procedure (Sender : TObject; Index: integer) of object;

    TIntArray = array[0..MaxInt div sizeof(integer) -1] of integer;
    PIntArray = ^TIntArray;

    TCustomElListBox = class;

    {$IFDEF LMD_UNICODE}
    TElListBoxStrings = class(TLMDWideStringList)
    {$ELSE}
    TElListBoxStrings = class(TStringList)
    {$ENDIF}
    private
      ListBox : TCustomElListBox;
    protected
      function Get(Index: Integer): TLMDBaseString; override;
      function GetCount: Integer; override;
      function GetObject(Index: Integer): TObject; override;
      procedure Put(Index: Integer; const S: TLMDBaseString); override;
      procedure PutObject(Index: Integer; AObject: TObject); override;
      procedure SetUpdateState(Updating: Boolean); override;
      procedure ResetBox;
      {$IFNDEF LMD_UNICODE}
      procedure InsertItem(Index: Integer; const S: string; AObject: TObject); override;
      {$ENDIF}
    public
      constructor Create;

      function Add(const S: TLMDBaseString): Integer; override;
      function AddObject(const S: TLMDBaseString; AnObject : TObject): Integer; override;
      {$IFNDEF LMD_UNICODE}
      procedure InsertObject(Index: Integer; const S: string; AObject: TObject); override;
      {$ENDIF}
      procedure Clear; override;
      procedure Delete(Index: Integer); override;
      procedure Exchange(Index1, Index2: Integer); override;
      function IndexOf(const S: TLMDBaseString): Integer; override;
      procedure Insert(Index: Integer; const S: TLMDBaseString); override;
      {$IFDEF LMD_NATIVEUNICODE}
      procedure InsertObject(Index: Integer; const S: string; AObject: TObject); override;
      {$ENDIF}
      procedure Move(CurIndex, NewIndex: Integer); override;
    end;

//en
//    {$EXTERNALSYM TOwnerDrawState}
//    TOwnerDrawState = ElVCLUtils.TOwnerDrawState;

    TElListBoxMultiCheckEvent = procedure(Sender : TObject; FromItemNo, ToItemNo : integer) of object;

    TCustomElListBox = class(TElXPThemedControl, ILMDValidatingMsgControl)
    private
      {< ELSCROLLBAR}
      fUseCustomScrollBars : Boolean;
      fSBCtrl: TElSBController;
      FItemIndex : integer;
      FSavedItemIndex : integer;
      FCheckIndex : integer;
      FOnChange : TNotifyEvent;
      FSavedIndex: Integer;

      function GetHorzScrollBar:TElCtrlScrollBarStyles;
      function GetVertScrollBar:TElCtrlScrollBarStyles;
      procedure SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
      procedure SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
      procedure SetUseCustomScrollBars(const Value:Boolean);
      function GetHorzScrollHintNeeded:TElScrollHintNeededEvent;
      procedure SetHorzScrollHintNeeded(Value: TElScrollHintNeededEvent);
      function GetVertScrollHintNeeded:TElScrollHintNeededEvent;
      procedure SetVertScrollHintNeeded(Value: TElScrollHintNeededEvent);
      {> ELSCROLLBAR}
      function IsTopIndexStored: Boolean;
    protected
      FStates: array of Byte;
      FImageIndex: PIntArray;
      //FStates: PChar;
      FImagesSize : integer;
      FStatesSize : integer;
      FBorderStyle: TBorderStyle;
      FCanvas     : TCanvas;
      FColumns: Integer;
      FExtendedSelect: Boolean;
      FIntegralHeight: Boolean;
      FItemHeight: Integer;
      FMultiSelect: Boolean;
      FSorted: Boolean;
      FTabWidth: Integer;
      FCurHintItem : Integer;
      FLastTopIndex : integer;

      FImgFormChLink : TImgFormChangeLink;

      FListBoxStrings : TLMDStrings;
      FActiveBorderType: TElFlatBorderType;
      FBackground: TBitmap;
      FBorderSides: TLMDBorderSides;
      FFlat: Boolean;
      FFlatFocusedScrollBars: Boolean;
      FHorizontalScroll: Boolean;
      FInactiveBorderType: TElFlatBorderType;
      FInvertSelection: Boolean;
      {
      FSelectedColor: TColor;
      FSelectedFontColor: TColor;
      }
      FSelectedFont: TFont;
      FShowLineHint: Boolean;
      FTransparent: Boolean;
      FTransparentSelection: Boolean;
      FUseBackground: Boolean;

      FImgForm : TElImageForm;

      FMouseOver: boolean;
      FHintTimer: TTimer;
      FHintWnd     : TElHintWindow;
      FHintWndProc : TWndMethod;
      FMaxWidth    : integer;
      FInVScroll,
      FInHScroll     : boolean;
      FLineBorderActiveColor: TColor;
      FLineBorderInactiveColor: TColor;
      FMoving : boolean;
      FShowCheckBox: Boolean;
      FAllowGrayed: Boolean;
      FImages: TCustomImageList;
      FImageChangeLink : TChangeLink;
      FAlphaImages: TCustomImageList;
      FAImageChangeLink : TChangeLink;
      {$IFNDEF LMD_UNICODE}
      FSaveItems: TStringList;
      {$ENDIF}
      FSaveTopIndex: Integer;
      FSaveItemIndex: Integer;
      {$IFDEF LMD_UNICODE}
      FHint: TLMDString;
      {$ENDIF}
      FOnDrawText: TDrawTextEvent;
      FStyle: TListBoxStyle;
      FOnDrawItem: TDrawItemEvent;
      //@+ 2/5/03
      FOnCheckBoxChange: TElCheckBoxChangeEvent;
      //@- 2/5/03
      FOnMeasureItem: TMeasureItemEvent;
      FUseSelectedFont: Boolean;
      FRightAlignedView: Boolean;
      FRightAlignedText: Boolean;
      FFocusedSelectColor: TColor;
      FFocusedSelectTextColor: TColor;
      FHideSelectColor: TColor;
      FHideSelectTextColor: TColor;
      FHideSelection: Boolean;
      FHighlightAlphaLevel: Integer;
      Input : TElKeyboardInput;
      SearchTextTimeoutThread : TThread;

      FOnMultiCheck : TElListBoxMultiCheckEvent;
      FOnCheckStateChange: TElCheckStateChangeEvent;
      FIncrementalSearchTimeout: Integer;
      FBorderColorFace      : TColor;
      FBorderColorShadow    : TColor;
      FBorderColorHighlight: TColor;
      FBorderColorDkShadow  : TColor;
      FBorderColorWindow: TColor;
      FForceSetItemIndex: boolean;
      FHideFocusRect: Boolean;

      procedure SetStyle(Value: TListBoxStyle);
      procedure SetHideFocusRect(Value: Boolean);virtual;
      procedure SetActiveBorderType(const Value: TElFlatBorderType);
      procedure SetBackground(const Value: TBitmap);
      procedure SetBorderSides(Value: TLMDBorderSides);
      procedure SetFlat(const Value: boolean);
      procedure SetFlatFocusedScrollBars(const Value: boolean);
      procedure SetHorizontalScroll(Value: Boolean);

      procedure SetImageForm(newValue : TElImageForm);

      procedure SetInactiveBorderType(const Value: TElFlatBorderType);
      procedure SetInvertSelection(const Value: boolean);
      procedure SetSelectedFont(const Value: TFont);
      procedure SetTransparent(const Value: boolean);
      procedure SetTransparentSelection(Value: Boolean);
      procedure SetUseBackground(const Value: boolean);
      procedure BackgroundChanged(Sender: TObject);
      procedure CancelLineHint;
      procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
      procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
      procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
      procedure CMParentColorChanged(var Msg: TMessage); message
          CM_PARENTCOLORCHANGED;
      procedure CMParentFontChanged(var Msg: TMessage); message CM_PARENTFONTCHANGED;
      procedure DrawBackground(DC: HDC; R: TRect);
      procedure DrawBackgroundEx(DC: HDC; R, SubR: TRect);
      procedure DrawFlatBorder(DC: HDC; HDragging, VDragging : boolean);
      procedure DrawParentControl(DC: HDC);
      procedure DrawParentControlEx(DC: HDC; R: TRect);
      procedure HintWndProc(var Message: TMessage);

      procedure ImageFormChange(Sender : TObject);

      procedure IntMouseMove(XPos, YPos : SmallInt);
      procedure LBGetTopIndex(var Msg: TMessage); message LB_GETTOPINDEX;
      procedure OnLineHintTimer(Sender : TObject);
      procedure ResetHorizontalExtent; virtual;
      procedure SelectedFontChanged(Sender: TObject);
      procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
      procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
      procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
      procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
      procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
      procedure WMNCCalcSize(var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
      procedure WMNCMouseMove(var Message: TWMNCMouseMove); message WM_NCMOUSEMOVE;
      procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
      procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;

      procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
          WM_WINDOWPOSCHANGED;

      {$ifdef LMD_UNICODE}
      procedure WMDeadChar(var Message: TWMDeadChar); message WM_DEADCHAR;
      procedure WMIMEComposition(var Message: TMessage); message WM_IME_COMPOSITION;
      {$endif}
      procedure WMIMEStartComposition(var Message: TMessage); message
          WM_IME_STARTCOMPOSITION;
      procedure SetHorizontalExtent; virtual;
      procedure SetColumnWidth;
      procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
      procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
      procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
      procedure CNMeasureItem(var Message: TWMMeasureItem); message CN_MEASUREITEM;
      procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
      procedure WMLButtonUp(var Message: TWMLButtonDown); message WM_LBUTTONUP;
      procedure WMSize(var Message: TWMSize); message WM_SIZE;
      procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
      procedure WMChar(var Message: TWMChar); message WM_CHAR;
      function GetItemHeight: Integer;
      function GetItemIndex: Integer;
      function GetSelCount: Integer;
      function GetSelected(Index: Integer): Boolean;
      function GetTopIndex: Integer;
      procedure SetBorderStyle(Value: TBorderStyle);
      procedure SetColumns(Value: Integer);
      procedure SetExtendedSelect(Value: Boolean);
      procedure SetIntegralHeight(Value: Boolean);
      procedure SetItemHeight(Value: Integer);
      procedure SetItemIndex(Value: Integer);
      procedure SetItems(Value: TLMDStrings);
      procedure SetMultiSelect(Value: Boolean);
      procedure SetSelected(Index: Integer; Value: Boolean);
      procedure SetSorted(Value: Boolean);
      procedure SetTabWidth(Value: Integer);
      procedure SetTopIndex(Value: Integer);

      function GetBackground: TBitmap; virtual;
      procedure SetLineBorderActiveColor(Value: TColor);
      procedure SetLineBorderInactiveColor(Value: TColor);
      function CreateHintWindow: TElHintWindow; virtual;
      procedure CreateParams(var Params: TCreateParams); override;
      procedure CreateWnd; override;
      procedure DestroyWnd; override;
      procedure DrawItem(Index: Integer; R: TRect; State: TOwnerDrawState); virtual;
      function GetItemWidth(Index: Integer): Integer; virtual;
      function GetParentCtlHeight: Integer; virtual;
      function GetParentCtlWidth: Integer; virtual;
      function GetThemedElement: TThemedElement; override;

      procedure IFMRepaintChildren(var Message: TMessage); message
          IFM_REPAINTCHILDREN;

      procedure Loaded; override;
      procedure Notification(AComponent: TComponent; Operation: TOperation); override;
      function RealScreenToClient(APoint : TPoint): TPoint; virtual;
      procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
      procedure WndProc(var Message: TMessage); override;
      function InternalGetItemData(Index: Integer): LongInt; dynamic;
      procedure InternalSetItemData(Index: Integer; AData: Longint); dynamic;
      function GetItemData(Index: Integer): LongInt; dynamic;
      procedure SetItemData(Index: Integer; AData: LongInt); dynamic;
      procedure ResetContent; dynamic;
      procedure DeleteString(Index: Integer); dynamic;
      procedure SetShowCheckBox(Value: Boolean);
      function GetState(Index: Integer): TCheckBoxState;
      procedure SetState(Index: Integer; Value: TCheckBoxState);
      function GetCheckBoxSize: TSize;
      procedure SetAllowGrayed(Value: Boolean);
      procedure DrawFlatFrame(Canvas : TCanvas; R : TRect);
      procedure OnImageListChange(Sender : TObject);
      procedure SetImages(newValue : TCustomImageList);
      procedure SetAlphaImages(newValue : TCustomImageList);
      procedure AdjustItemHeight; virtual;
      function GetImageIndex(Index: Integer): Integer;
      procedure SetImageIndex(Index: Integer; Value: Integer);
      procedure SetStatesSize(aSize : integer);
      procedure SetImagesSize(aSize : integer);

      {$IFDEF LMD_UNICODE}
      procedure CMHintShow(var Message:TCMHintShow); message CM_HINTSHOW;
      {$ENDIF}

      {$IFDEF LMD_UNICODE}
      procedure SetHint(Value: TLMDString);
      {$ENDIF}
      procedure ItemsChange(Sender : TObject);

      procedure StartClearSearchTimeoutThread;
      procedure StopClearSearchTimeoutThread;
      function DoPerformSearch(SearchText : TLMDString; AFromIndex: Integer = 0): Boolean; virtual;
      procedure SearchTextTimeout(Sender : TObject);
      function DoCompareItems(SearchText : String; ItemIndex : integer): Boolean;
          virtual;
      procedure DoDrawText(Sender : TObject; ACanvas: TCanvas; const ACaption: TLMDString;
        var Rect: TRect; Flags: LongInt); virtual;
      procedure MeasureItem(Index: Integer; var Height: Integer); virtual;
      procedure SetUseSelectedFont(Value: Boolean);
      procedure SetRightAlignedView(Value: Boolean);
      procedure SetRightAlignedText(Value: Boolean);
      procedure SetFocusedSelectColor(newValue: TColor);
      procedure SetFocusedSelectTextColor(newValue: TColor);
      procedure SetHideSelectColor(newValue: TColor);
      procedure SetHideSelectTextColor(newValue: TColor);
      procedure SetHideSelection(Value: Boolean);
      procedure DefineProperties(Filer : TFiler); override;
      procedure ReadSelectedColor(Reader : TReader);
      procedure ReadSelectedFontColor(Reader : TReader);
      procedure SetHighlightAlphaLevel(Value: Integer);
      procedure TriggerChange;
      procedure TriggerCheckStateChange(ItemNo : integer); virtual;
      procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
      procedure WMKeyUp(var Message: TWMKeyUp); message WM_KEYUP;
      procedure TriggerCheckBoxChange(ItemNo : integer; ItemState: TCheckBoxState);
          virtual;
      procedure TriggerMultiCheckEvent(FromItemNo, ToItemNo : integer); virtual;
      procedure SetUseXPThemes(const Value : boolean); override;
      procedure SetThemeMode(const Value: TLMDThemeMode);override;
      procedure SetThemeGlobalMode(const Value: Boolean);override;

      procedure PaintWindow(DC: HDC); override;

      function GetCount:Integer;
      procedure UpdateItemHeight; virtual;
      procedure SetBorderColorFace(Value: TColor);
      procedure SetBorderColorShadow(Value: TColor);
      procedure SetBorderColorDkShadow(Value: TColor);
      procedure SetBorderColorHighlight(Value: TColor);
      procedure SetBorderColorWindow(Value: TColor);
      property Count:Integer read GetCount;
      property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle
          default bsSingle;
      property Columns: Integer read FColumns write SetColumns default 0;
      property ExtendedSelect: Boolean read FExtendedSelect write SetExtendedSelect
          default True;
      property IntegralHeight: Boolean read FIntegralHeight write SetIntegralHeight
          default False;
      property ItemHeight: Integer read GetItemHeight write SetItemHeight;
      property MultiSelect: Boolean read FMultiSelect write SetMultiSelect default
          False;
      property ParentColor default False;
      property Sorted: Boolean read FSorted write SetSorted default False;
      property TabWidth: Integer read FTabWidth write SetTabWidth default 0;
      property ItemIndex: Integer read GetItemIndex write SetItemIndex;
      {$IFDEF LMD_UNICODE}
      property Items: TLMDWideStrings read FListBoxStrings write SetItems;
      {$ELSE}
      property Items: TStrings read FListBoxStrings write SetItems;
      {$ENDIF}
      property SelCount: Integer read GetSelCount;
      property TopIndex: Integer read GetTopIndex write SetTopIndex stored IsTopIndexStored;

      property ActiveBorderType: TElFlatBorderType read FActiveBorderType write
          SetActiveBorderType default fbtSunken;
      property Background: TBitmap read GetBackground write SetBackground;
      property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides
        default [ebsLeft, ebsTop, ebsRight, ebsBottom];
      property Flat: Boolean read FFlat write SetFlat default False;
      property FlatFocusedScrollBars: Boolean read FFlatFocusedScrollBars write
          SetFlatFocusedScrollBars default False;
      property HorizontalScroll: Boolean read FHorizontalScroll write
          SetHorizontalScroll default False;

      property ImageForm: TElImageForm read FImgForm write SetImageForm;

      property InactiveBorderType: TElFlatBorderType read FInactiveBorderType write
          SetInactiveBorderType default fbtSunkenOuter;
      property InvertSelection: Boolean read FInvertSelection write
          SetInvertSelection default False;
      property LineBorderActiveColor: TColor read FLineBorderActiveColor write
          SetLineBorderActiveColor default clBlack;
      property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
          SetLineBorderInactiveColor default clBlack;
      {
      property SelectedColor: TColor read FSelectedColor write SetSelectedColor
          default clHighlight;
      property SelectedFontColor: TColor read FSelectedFontColor write
          SetSelectedFontColor default clHighlightText;
      }
      property SelectedFont: TFont read FSelectedFont write SetSelectedFont;
      property ShowLineHint: Boolean read FShowLineHint write FShowLineHint default
          false;
      property Transparent: Boolean read FTransparent write SetTransparent default
          False;
      property TransparentSelection: Boolean read FTransparentSelection write
          SetTransparentSelection default false;
      property UseBackground: Boolean read FUseBackground write SetUseBackground
          default False;
      property TabStop default True;
      property ShowCheckBox: Boolean read FShowCheckBox write SetShowCheckBox default
          false;
      property AllowGrayed: Boolean read FAllowGrayed write SetAllowGrayed default
          true;
      property Images: TCustomImageList read FImages write SetImages;
      property AlphaForImages: TCustomImageList read FAlphaImages write SetAlphaImages;
      property Style: TListBoxStyle read FStyle write SetStyle default lbStandard;
      property UseSelectedFont: Boolean read FUseSelectedFont write
          SetUseSelectedFont default false;
      property RightAlignedView: Boolean read FRightAlignedView write
          SetRightAlignedView default false;
      property RightAlignedText: Boolean read FRightAlignedText write
          SetRightAlignedText default false;
      property FocusedSelectColor: TColor read FFocusedSelectColor write
          SetFocusedSelectColor default clHighlight;
      property FocusedSelectTextColor: TColor read FFocusedSelectTextColor write
          SetFocusedSelectTextColor default clHighlightText;
      property HideSelectColor: TColor read FHideSelectColor write SetHideSelectColor
          default clBtnFace;
      property HideSelectTextColor: TColor read FHideSelectTextColor write
          SetHideSelectTextColor default LMDElHideSelectTextColor;
      property HideSelection: Boolean read FHideSelection write SetHideSelection
          default true;
      property HighlightAlphaLevel: Integer read FHighlightAlphaLevel write
          SetHighlightAlphaLevel default 255;
      property OnChange: TNotifyEvent read FOnChange write FOnChange;
      property OnCheckStateChange: TElCheckStateChangeEvent read FOnCheckStateChange
          write FOnCheckStateChange;
      property OnMultiCheck : TElListBoxMultiCheckEvent read FOnMultiCheck write FOnMultiCheck;
      property IncrementalSearchTimeout: Integer read FIncrementalSearchTimeout write
          FIncrementalSearchTimeout default 500;
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      function ItemAtPos(Pos: TPoint; Existing: Boolean): Integer;
      function ItemRect(Index: Integer): TRect;

      //Validation support, November 2007, RS
      procedure SetErrorMessage(val: TLMDString; errorLevel: integer);
      function GetLastErrorMessage: TLMDString;
      //end of Validation support

      //@+ 2/5/03
      procedure CheckAll;
      procedure CheckSelected;
      procedure GrayAll;
      procedure GraySelected;
      procedure UncheckAll;
      procedure UncheckSelected;
      property ForceSetItemIndex: boolean read FForceSetItemIndex write FForceSetItemIndex default false;
      //@- 2/5/03
      property Canvas: TCanvas read FCanvas;
      property Selected[Index: Integer]: Boolean read GetSelected write SetSelected;
      property State[Index: Integer]: TCheckBoxState read GetState write SetState;
      property ImageIndex[Index: Integer]: Integer read GetImageIndex write
          SetImageIndex;
      //@+ 2/5/03
      property OnCheckBoxChange: TElCheckBoxChangeEvent read FOnCheckBoxChange write FOnCheckBoxChange;
      //@- 2/5/03
      property OnDrawText: TDrawTextEvent read FOnDrawText write
          FOnDrawText;
      property OnDrawItem: TDrawItemEvent read FOnDrawItem write FOnDrawItem;
      property OnMeasureItem: TMeasureItemEvent read FOnMeasureItem write FOnMeasureItem;
      {< ELSCROLLBAR}
      property UseCustomScrollBars : Boolean read fUseCustomScrollBars write SetUseCustomScrollBars
        default True;
      property HorzScrollBarStyles: TElCtrlScrollBarStyles read GetHorzScrollBar
        write SetHorzScrollBar;
      property VertScrollBarStyles: TElCtrlScrollBarStyles read GetVertScrollBar
        write SetVertScrollBar;
      property OnHorzScrollHintNeeded: TElScrollHintNeededEvent read GetHorzScrollHintNeeded
        write SetHorzScrollHintNeeded;
      property OnVertScrollHintNeeded: TElScrollHintNeededEvent read GetVertScrollHintNeeded
        write SetVertScrollHintNeeded;
      {> ELSCROLLBAR}
    published
      property DoubleBuffered;
      {$IFDEF LMD_UNICODE}
      property Hint: TLMDString read FHint write SetHint;
      {$ENDIF}
      property BorderColorFace : TColor read FBorderColorFace write SetBorderColorFace default
          clBtnFace;
      property BorderColorShadow : TColor read FBorderColorShadow write SetBorderColorShadow default
          clBtnShadow;
      property BorderColorDkShadow : TColor read FBorderColorDkShadow write SetBorderColorDkShadow default
          cl3DDkShadow;
      property BorderColorHighlight: TColor read FBorderColorHighlight write
          SetBorderColorHighlight default clBtnHighlight;
      property BorderColorWindow: TColor read FBorderColorWindow write
          SetBorderColorWindow default clWindow;
      property HideFocusRect: Boolean read FHideFocusRect write SetHideFocusRect default False;
    end;

    TElListBox = class(TCustomElListBox)
    published
      property AllowGrayed;
      property BorderStyle;
      property Columns;
      property ExtendedSelect;
      property FocusedSelectColor;
      property FocusedSelectTextColor;
      property HideSelection;
      property HideSelectColor;
      property HideSelectTextColor;
      property IntegralHeight;
      property IncrementalSearchTimeout;
      property ItemHeight;
      property MultiSelect;
      property ParentColor;
      property Sorted;
      property TabWidth;
      property ItemIndex;
      property Items;
      property SelCount;
      property TopIndex;
      property ShowCheckBox;
      property ParentThemeMode default true;
      property ThemeMode;
      property ThemeGlobalMode;

      property ActiveBorderType;
      property Background;
      property BorderSides;
      property Flat;
      property Ctl3D;
      property ParentCtl3D;
      property Font;
      property FlatFocusedScrollBars;
      property HighlightAlphaLevel;
      property HorizontalScroll;
      property Images;
      property AlphaForImages;

      property ImageForm;

      property InactiveBorderType;
      property InvertSelection;
      property LineBorderActiveColor;
      property LineBorderInactiveColor;

      property SelectedFont;
      property ShowLineHint;
      property Transparent;
      property TransparentSelection;
      property UseBackground;
      property UseSelectedFont;
      property TabStop;
      property ParentFont;

      property OnChange;
      property OnClick;
      property OnCheckStateChange;
      property OnMultiCheck;
      //@+ 2/5/03
      property OnCheckBoxChange;
      //@- 2/5/03
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
      property OnResize;
      property OnStartDock;
      property OnStartDrag;

      property Align;
      property Anchors;
      property BiDiMode;
      property Color;
      property Constraints;
      property DragCursor;
      property DragKind;
      property DragMode;
      property Enabled;
      property ImeMode;
      property ImeName;
      property ParentBiDiMode;
      property ParentShowHint;
      property PopupMenu;
      property ShowHint;
      property TabOrder;
      property Visible;
      property Style;
      property OnDrawItem;
      property OnMeasureItem;
      {< ELSCROLLBAR}
      property UseCustomScrollBars;
      property HorzScrollBarStyles;
      property VertScrollBarStyles;
      {> ELSCROLLBAR}
      property RightAlignedView;
    end;

implementation

const
  CheckMargin = 5;
  CheckBoxSize = 13;

type
    THackWinControl = class(TWinControl)
    ;

type
  TElListBoxHintWindow = class(TElHintWindow)
  protected
  end;

constructor TCustomElListBox.Create(AOwner : TComponent);
begin

  BeginCreate;
  inherited;

  Width := 121;
  Height := 97;
  TabStop := True;
  ParentColor := False;
  ControlStyle := [csSetCaption, csClickEvents, csDoubleClicks];
  FListBoxStrings := TElListBoxStrings.Create;
  TElListBoxStrings(FListBoxStrings).ListBox := Self;
  TElListBoxStrings(FListBoxStrings).OnChange := ItemsChange;
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  FItemHeight := 16;
  FBorderStyle := bsSingle;
  FExtendedSelect := True;
  FBorderSides := [ebsLeft, ebsTop, ebsRight, ebsBottom];
  FActiveBorderType := fbtSunken;
  FBackground := TBitmap.Create;
  FBackground.OnChange := BackgroundChanged;
  FFlat := False;
  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;
  FForceSetItemIndex := false;
  FSavedItemIndex := -1;
  FCheckIndex := -1;

  FFlatFocusedScrollBars := False;
  FInactiveBorderType := fbtSunkenOuter;
  FInvertSelection := False;
  FLastTopIndex := 0;
  FSelectedFont := TFont.Create;
  FSelectedFont.Color := clHighlightText;
  FSelectedFont.OnChange := SelectedFontChanged;
  FTransparent := False;
  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;

  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := OnImageListChange;
  FAImageChangeLink := TChangeLink.Create;
  FAImageChangeLink.OnChange := OnImageListChange;
  FCurHintItem := -1;
  FHighlightAlphaLevel := 255;
  Input := TElKeyboardInput.Create;
  FIncrementalSearchTimeout := 500;

  FHideSelection := true;
  FFocusedSelectColor := clHighlight;
  FFocusedSelectTextColor := clHighlightText;
  FHideSelectColor := clBtnFace;
  FHideSelectTextColor := LMDElHideSelectTextColor;

  {< ELSCROLLBAR}
  fSBCtrl := TElSBController.Create(Self);
  fUseCustomScrollBars := True;
  fSBCtrl.UseXPThemes := true;
  {> ELSCROLLBAR}
  EndCreate;
end;

destructor TCustomElListBox.Destroy;
begin
  StopClearSearchTimeoutThread;
  FreeAndNil(Input);
  CancelLineHint;
  inherited;
  SetStatesSize(0);
  SetImagesSize(0);
  FImageChangeLink.Free;
  FAImageChangeLink.Free;

  FImgFormChLink.Free;
  FSelectedFont.Free;
  FCanvas.Free;
  FListBoxStrings.Free;
  FBackground.Free;
end;

function TCustomElListBox.GetBackground: TBitmap;
begin
  Result := FBackground;
end;

procedure TCustomElListBox.SetActiveBorderType(const Value: TElFlatBorderType);
begin
  if FActiveBorderType <> Value then
  begin
    FActiveBorderType := Value;
    if Focused or FMouseOver then
      DrawFlatBorder(0, false, false);
    end;
end;

procedure TCustomElListBox.SetBackground(const Value: TBitmap);
begin
  FBackground.Assign(Value);
end;

procedure TCustomElListBox.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
    end;
end;

procedure TCustomElListBox.SetFlat(const Value: boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    if HandleAllocated then
      RecreateWnd;
    end;
end;

procedure TCustomElListBox.SetFlatFocusedScrollBars(const Value: boolean);
begin
  if FFlatFocusedScrollBars <> Value then
  begin
    FFlatFocusedScrollBars := Value;
    if Focused then
      DrawFlatBorder(0, false, false);
    end;
end;

procedure TCustomElListBox.SetHorizontalScroll(Value: Boolean);
begin
  if FHorizontalScroll <> Value then
  begin
    FHorizontalScroll := Value;
    if HandleAllocated then
      RecreateWnd;
    end;
end;

procedure TCustomElListBox.SetImageForm(newValue : TElImageForm);
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
      FImgForm.RegisterChanges(FImgFormChLink);
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
    end;
end;

procedure TCustomElListBox.SetInactiveBorderType(const Value: TElFlatBorderType);
begin
  if FInactiveBorderType <> Value then
  begin
    FInactiveBorderType := Value;
    if not Focused and not FMouseOver then
      DrawFlatBorder(0, false, false);
    end;
end;

procedure TCustomElListBox.SetInvertSelection(const Value: boolean);
begin
  if FInvertSelection <> Value then
  begin
    FInvertSelection := Value;
    if (MultiSelect and (SelCount > 0)) or (ItemIndex > -1) then
      Invalidate;
  end;
end;

procedure TCustomElListBox.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then
      Invalidate;
  end;
end;

procedure TCustomElListBox.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then
      Invalidate;
  end;
end;

procedure TCustomElListBox.SetSelectedFont(const Value: TFont);
begin
  FSelectedFont.Assign(Value);
end;

procedure TCustomElListBox.SetTransparent(const Value: boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    if FTransparent then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
    end;
end;

procedure TCustomElListBox.SetTransparentSelection(Value: Boolean);
begin
  if FTransparentSelection <> Value then
  begin
    FTransparentSelection := Value;
    if ItemIndex > -1 then
      Invalidate;
  end;
end;

procedure TCustomElListBox.SetUseBackground(const Value: boolean);
begin
  if FUseBackground <> Value then
  begin
    FUseBackground := Value;
    Invalidate;
  end;
end;

procedure TCustomElListBox.BackgroundChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TCustomElListBox.CancelLineHint;
begin
  if FHintTimer <> nil then
  begin
    FHintTimer.Enabled := false;
    FHintTimer.Free;
    FHintTimer := nil;
  end;
  if FHintWnd <> nil then
  begin
    FHintWnd.Free;
    FHintWnd := nil;
  end;
end;

procedure TCustomElListBox.CMFontChanged(var Msg: TMessage);
begin
  inherited;
  Canvas.Font.Assign(Font);
  if not (csLoading in componentState) then
    UpdateItemHeight;
end;

procedure TCustomElListBox.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  FMouseOver := True;
  if IsThemed or (Flat and not Focused) then
    DrawFlatBorder(0, false, false);
  if Flat and ShowCheckBox then
    Invalidate;
end;

procedure TCustomElListBox.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
  FMouseOver := False;
  if IsThemed or (Flat and not Focused) then
    DrawFlatBorder(0, false, false);
  if Flat and ShowCheckBox then
    Invalidate;
end;

procedure TCustomElListBox.CMParentColorChanged(var Msg: TMessage);
begin
  inherited;
  if FTransparent then
    Invalidate;
end;

procedure TCustomElListBox.CMParentFontChanged(var Msg: TMessage);

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

function TCustomElListBox.CreateHintWindow: TElHintWindow;
begin
  Result := TElListBoxHintWindow.Create(nil);
end;

procedure TCustomElListBox.CreateParams(var Params: TCreateParams);
type
  PSelects = ^TSelects;
  TSelects = array[Boolean] of DWORD;

const
  MultiSelects: TSelects = (0, LBS_MULTIPLESEL);
  ExtendSelects: TSelects = (0, LBS_EXTENDEDSEL);
  IntegralHeights: TSelects = (LBS_NOINTEGRALHEIGHT, 0);
  MultiColumns: TSelects = (0, LBS_MULTICOLUMN);
  TabStops: TSelects = (0, LBS_USETABSTOPS);
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
  CSHREDRAW: TSelects = (CS_HREDRAW, 0);
  LeftSB: TSelects = (0, WS_EX_LEFTSCROLLBAR);
  RightText: TSelects = (0, WS_EX_RTLREADING or WS_EX_RIGHT);

var
  Selects: PSelects;
  begin
  inherited;
  CreateSubClass(Params, 'LISTBOX');
  with Params do
  begin
    Selects := @MultiSelects;
    if FExtendedSelect then
      Selects := @ExtendSelects;
    Style := Style or (WS_HSCROLL or WS_VSCROLL or LBS_NOTIFY) or
      {$IFNDEF LMD_UNICODE} LBS_HASSTRINGS or {$ENDIF}
      Selects^[FMultiSelect] or IntegralHeights[FIntegralHeight] or
      MultiColumns[FColumns <> 0] or BorderStyles[FBorderStyle] or TabStops[FTabWidth <> 0];
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;

    ExStyle := ExStyle or RightText[RightAlignedText];
    if NewStyleControls or UseCustomScrollBars then
      ExStyle := ExStyle or LeftSB[RightAlignedView];

    if FStyle = lbOwnerDrawVariable then
      Style := Style or LBS_OWNERDRAWVARIABLE
    else
      Style := Style or LBS_OWNERDRAWFIXED;
    WindowClass.style := WindowClass.style and not (
      CSHREDRAW[UseRightToLeftAlignment] or CS_VREDRAW);
  end;

  if not (csLoading in ComponentState) then
    if (Params.Style and LBS_OWNERDRAWFIXED = 0) and
      (Params.Style and LBS_OWNERDRAWVARIABLE = 0) then
      Params.Style := Params.Style or LBS_OWNERDRAWFIXED;

  if (BorderStyle = bsSingle) and Flat and (not IsThemed) then
  begin
    Params.Style := Params.Style and (not WS_BORDER);
    Params.ExStyle := Params.ExStyle and (not WS_EX_CLIENTEDGE);
  end;
end;

procedure TCustomElListBox.CreateWnd;
var
  W, H: Integer;
begin
  W := Width;
  H := Height;
  {< ELSCROLLBAR}
  fSBCtrl.Control := nil;
  {> ELSCROLLBAR}
  inherited;
  Perform(CM_FONTCHANGED, 0, 0);
  SetWindowPos(Handle, 0, Left, Top, W, H, SWP_NOZORDER or SWP_NOACTIVATE);
  if FTabWidth <> 0 then
  SendMessage(Handle, LB_SETTABSTOPS, 1, TLMDPtrUInt(@FTabWidth));
  SetColumnWidth;
  if not (csLoading in componentState) then
    UpdateItemHeight;
  {$IFNDEF LMD_UNICODE}
  if FSaveItems <> nil then
  begin
    FListBoxStrings.Assign(FSaveItems);
    SetTopIndex(FSaveTopIndex);
    SetItemIndex(FSaveItemIndex);
    FSaveItems.Free;
    FSaveItems := nil;
  end;
  {$ELSE}
  TElListBoxStrings(FListBoxStrings).ResetBox;
  {$ENDIF}
  {< ELSCROLLBAR}
  // reset control handler
  if fUseCustomScrollBars then
  begin
    fSBCtrl.Control := Self;
    if not fSBCtrl.Active then
    begin
      fUseCustomScrollBars := False;
      fSBCtrl.Control := nil;
    end;
  end;
  {> ELSCROLLBAR}
end;

procedure TCustomElListBox.DestroyWnd;
begin
  {$IFNDEF LMD_UNICODE}
  if FListBoxStrings.Count > 0 then
  begin
    FSaveItems := TStringList.Create;
    FSaveItems.Assign(FListBoxStrings);
    FSaveTopIndex := GetTopIndex;
    FSaveItemIndex := GetItemIndex;
  end;
  {$ENDIF}
  inherited;
  {< ELSCROLLBAR}
  fSBCtrl.Control := nil;
  {> ELSCROLLBAR}
end;

{< ELSCROLLBAR}
function TCustomElListBox.GetHorzScrollBar:TElCtrlScrollBarStyles;
begin
  Result := TElCtrlScrollBarStyles(fSBCtrl.ScrollBar[SB_HORZ]);
end;

function TCustomElListBox.GetVertScrollBar:TElCtrlScrollBarStyles;
begin
  Result := TElCtrlScrollBarStyles(fSBCtrl.ScrollBar[SB_VERT]);
end;

procedure TCustomElListBox.SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  fSBCtrl.ScrollBar[SB_HORZ].Assign(Value);
end;

procedure TCustomElListBox.SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  fSBCtrl.ScrollBar[SB_VERT].Assign(Value);
end;

procedure TCustomElListBox.SetUseCustomScrollBars(const Value:Boolean);
begin
  if fUseCustomScrollBars <> Value then
  begin
    fUseCustomScrollBars := Value;
    if not (csDesigning in ComponentState) then
    begin
      if fUseCustomScrollBars then
      begin
        fSBCtrl.Control := nil;
        fSBCtrl.Control := Self;
        if not fSBCtrl.Active then
        begin
          fUseCustomScrollBars := False;
          fSBCtrl.Control := nil;
        end;
      end
      else
        fSBCtrl.Control := nil;
    end;
  end;
end;

function TCustomElListBox.GetHorzScrollHintNeeded:TElScrollHintNeededEvent;
begin
  Result := fSBCtrl.HorzScrollBarStyles.OnScrollHintNeeded;
end;

procedure TCustomElListBox.SetHorzScrollHintNeeded(Value: TElScrollHintNeededEvent);
begin
  fSBCtrl.HorzScrollBarStyles.OnScrollHintNeeded := Value;
end;

function TCustomElListBox.GetVertScrollHintNeeded:TElScrollHintNeededEvent;
begin
  Result := fSBCtrl.VertScrollBarStyles.OnScrollHintNeeded;
end;

procedure TCustomElListBox.SetVertScrollHintNeeded(Value: TElScrollHintNeededEvent);
begin
  fSBCtrl.VertScrollBarStyles.OnScrollHintNeeded := Value;
end;

{> ELSCROLLBAR}

procedure TCustomElListBox.DrawBackground(DC: HDC; R: TRect);
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

procedure TCustomElListBox.DrawBackgroundEx(DC: HDC; R, SubR: TRect);
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

procedure TCustomElListBox.DrawFlatBorder(DC: HDC; HDragging,
  VDragging : boolean);
var
  R : TRect;
  BS: TElFlatBorderType;
  MustRelease: boolean;
  AColor : TColor;

const BordersFlat : array[boolean] of Integer = (0, WS_BORDER);
      Borders3D : array[boolean] of Integer = (0, WS_EX_CLIENTEDGE);

begin
  if (BorderStyle = bsNone) or (not HandleAllocated) then
    exit;
  if IsThemed then
  begin
    RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_UPDATENOW);
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
      DrawFlatFrameEx2(DC, R, AColor, Color, Focused or FMouseOver, Enabled,
                       FBorderSides, BS, FBorderColorFace, FBorderColorDkShadow,
                       FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
    end;
    if (not UseCustomScrollBars) and
       (FFlatFocusedScrollBars or not (Focused or FMouseOver))
    then
      DrawFlatScrollbars(Handle, DC, R,
        (Focused or FMouseOver) and not FFlatFocusedScrollBars,
        ssBoth, HDragging, VDragging, False,
        GetWindowLong(Handle, GWL_STYLE) or BordersFlat[(not Ctl3D) and (BorderStyle = bsSingle)],
        GetWindowLong(Handle, GWL_EXSTYLE) or Borders3D[Ctl3D and (BorderStyle = bsSingle)]);
  finally
    if MustRelease then
      ReleaseDC(Handle, DC);
  end;
end;

procedure TCustomElListBox.DoDrawText(Sender : TObject; ACanvas: TCanvas; const ACaption: TLMDString;
  {index: integer;} var Rect: TRect; Flags: LongInt);
begin
  SetBkMode(ACanvas.Handle, Windows.TRANSPARENT);
  LMDDrawText(ACanvas.Handle, ACaption, Length(ACaption), Rect, Flags);
end;

procedure TCustomElListBox.SetStyle(Value: TListBoxStyle);
begin
  if FStyle <> Value then
  begin
    if Value in  [lbVirtual, lbVirtualOwnerDraw] then
    begin
       if (csDesigning in ComponentState) and (not (csReading in ComponentState) ) then
        raise Exception.Create('TElListBox do not support virtual styles: lbVirtual, lbVirtualOwnerDraw');
      if Value=lbVirtual then
        Value := lbStandard
      else
        Value := lbOwnerDrawFixed;
      if FStyle = Value then
        exit;
    end;
    FStyle := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElListBox.DrawItem(Index: Integer; R: TRect;
  State: TOwnerDrawState);
var
  Flags,
  TextColor,
  BackColor : longint;
  TextRect  : TRect;
  R1,
  BgRect    : TRect;

  P         : TPoint;
  ax, ay    : integer;

  S         : TSize;
  i         : integer;
  AColor    : TColor;
  ar2       : TRect;
  BMP,
  amBMP     : TBitmap;
  LDetail   : TThemedButton;
  LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;

  if (FStyle <> lbStandard) and Assigned(FOnDrawItem) then
  begin
    FOnDrawItem(Self, Index, R, State);
    exit;
  end;

  TextColor := GetTextColor(Canvas.Handle);
  BackColor := GetBkColor(Canvas.Handle);
  AColor    := BackColor;

  if (odSelected in State) and (not FInvertSelection) and FTransparentSelection then
    Canvas.Font.Color := Font.Color;

  if (odSelected in State) and (not FInvertSelection) and (not FTransparentSelection) then
  begin
    if Focused then
      AColor := FocusedSelectColor
    else
    if not HideSelection then
      AColor := HideSelectColor
    else
      AColor := Color;

    if HighlightAlphaLevel = 255 then
    begin
      Canvas.Brush.Color := AColor;
      Canvas.FillRect(R);
    end;

    BgRect := R;
  end
  else
  begin
    if (FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and
      (not (csDesigning in Componentstate)) then
    begin
      // if (FImgForm.Control <> Self) then
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
    end
    else if FTransparent then
      DrawParentControlEx(Canvas.Handle, R)
    else if FUseBackground and not Background.Empty then
      DrawBackgroundEx(Canvas.Handle, ClientRect, R)
    else if not FTransparentSelection then
    begin
      Canvas.Brush.Color := Color;
      Canvas.FillRect(R);
    end;
  end;

  if (odSelected in State) and FInvertSelection then
    InvertRect(Canvas.Handle, R);

  if (odSelected in State) then
  begin
    if (not FTransparentSelection) and (UseSelectedFont) then
      Canvas.Font.Assign(FSelectedFont)
    else
    begin
      if Focused then
        Canvas.Font.Color := FocusedSelectTextColor
      else
      if not HideSelection then
        Canvas.Font.Color := HideSelectTextColor
      else
        Canvas.Font.Color := Font.Color;
    end;
  end;

  if Index < Items.Count then
  begin
    if Images <> nil then
    begin
      i := ImageIndex[Index];
      if i <> -1 then
      begin
        ar2.Left := R.Left + 1;
        ar2.top := R.Top + ((R.Bottom - R.Top) - Images.Height) div 2;
        if (FAlphaImages <> nil) and (FAlphaImages.Count > i) then
        begin
          BMP := TBitmap.Create;
          BMP.Width := FImages.Width;
          BMP.Height := FImages.Height;
          ImageList_DrawEx(FImages.Handle, i, BMP.Canvas.Handle, 0, 0, 0, 0,
            clNone, clNone, ILD_Normal);

          amBMP := TBitmap.Create;
          amBMP.Width := FAlphaImages.Width;
          amBMP.Height := FAlphaImages.Height;
          ImageList_DrawEx(FAlphaImages.Handle, i, amBMP.Canvas.Handle, 0, 0, 0, 0,
            clNone, clNone, ILD_Normal);

          ar2.Right := ar2.Left + BMP.Width;
          ar2.Bottom := ar2.Top + BMP.Height;

          LMDAlphaCopyRect2(Canvas.Handle, ar2, BMP.Canvas.Handle,
            Rect(0, 0, BMP.Width, BMP.Height), amBMP, 255);

          BMP.Free;
          amBMP.Free;
        end
        else
          FImages.Draw(Canvas, ar2.left, ar2.top, i);
      end;

      Inc(R.Left, Images.Width + 3);
    end;
    if ShowCheckBox then
    begin
      R1 := R;
      s := GetCheckBoxSize;

      if RightAlignedText then
      begin
        dec(R1.Right, 2);
        R1.Left := R1.Right - S.cx;
      end
      else
      begin
        inc(R1.Left, 2);
        R1.Right := R1.Left + S.cx;
      end;

      R1.Top := R1.Top + (R1.Bottom - R1.Top - S.cy) div 2;
      R1.Bottom := R1.Top + S.cy;

      if LThemeMode <> ttmNone then
      begin
        LDetail := tbCheckBoxUncheckedNormal;

        case GetState(Index) of
          cbUnchecked :
            if not Enabled then
              LDetail := tbCheckBoxUncheckedDisabled
            else
              LDetail := tbCheckBoxUncheckedNormal;
          cbChecked :
            if not Enabled then
              LDetail := tbCheckBoxCheckedDisabled
            else
              LDetail := tbCheckBoxCheckedNormal;
          cbGrayed :
            if not Enabled then
              LDetail := tbCheckBoxMixedDisabled
            else
              LDetail := tbCheckBoxMixedNormal;
        end;

        LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetail,
                                     R1, LMDRectToPtr(R));
      end
      else
      begin
        i := 0;
        case GetState(Index) of
          cbChecked : i := DFCS_BUTTONCHECK or DFCS_CHECKED;
          cbUnchecked : i := DFCS_BUTTONCHECK;
          cbGrayed : i := DFCS_BUTTON3STATE or DFCS_CHECKED;
        end; // case

        DrawFrameControl(Canvas.Handle, R1, DFC_BUTTON, i);

        if Flat then
          DrawFlatFrame(Canvas, R1);
      end;

      if RightAlignedText then
        R.Right := R1.Left - 3
      else
        R.Left := R1.Right + 3;
    end;

    TextRect := R;
    Flags := DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX;

    if RightAlignedText then
      Flags := Flags or DT_RTLREADING;
    if not RightAlignedText then
      Inc(TextRect.Left, 2)
    else
      Dec(TextRect.Right, 2);

    if Assigned(FOnDrawText) then
      FOnDrawText(Self, Canvas, Index, TextRect, Flags)
    else
      DoDrawText(Self, Canvas, Items[Index], TextRect, Flags);
  end;

  if (odSelected in State) and (not FInvertSelection) and
    (not FTransparentSelection) and (HighlightAlphaLevel < 255) then
  begin
    LMDAlphaFillRect(Canvas, BgRect, AColor, HighlightAlphaLevel);
  end;

  SetTextColor(Canvas.Handle, TextColor);
  SetBkColor(Canvas.Handle, BackColor);
end;

procedure TCustomElListBox.DrawParentControl(DC: HDC);

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

procedure TCustomElListBox.DrawParentControlEx(DC: HDC; R: TRect);
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

function TCustomElListBox.GetItemWidth(Index: Integer): Integer;
var
  ATabWidth: Longint;
  S: TLMDString;
  {$IFDEF LMD_UNICODE}
  ARect : TRect;
  i, j  : integer;
  {$ENDIF}
begin
  S := Items[Index] + 'W';
  {$IFDEF LMD_UNICODE}
  ATabWidth := 0;
  j := 0;
  if TabWidth > 0 then
  begin
    ATabWidth := Round((TabWidth * Canvas.TextWidth('0')) * 0.25);
    for i := 1 to Length(S) do
      if S[i] = TLMDChar(#9) then
        inc(j);
  end;
  SetRectEmpty(ARect);
  LMDDrawText(Canvas.Handle, S, Length(S), ARect, DT_CALCRECT);
  result := ARect.Right + j * ATabWidth;
  {$ELSE}
  if TabWidth > 0 then
  begin
    ATabWidth := Round((TabWidth * Canvas.TextWidth('0')) * 0.25);
    Result := LoWord(GetTabbedTextExtent(Canvas.Handle, @S[1], Length(S),
      1, ATabWidth));
  end
  else
  Result := Canvas.TextWidth(S);
  {$ENDIF}
end;

function TCustomElListBox.GetParentCtlHeight: Integer;
var ACtl : TWinControl;
begin

  ACtl := FImgForm.GetRealControl;

  result := ACtl.ClientHeight;
end;

function TCustomElListBox.GetParentCtlWidth: Integer;
var ACtl : TWinControl;
begin

  ACtl := FImgForm.GetRealControl;

  result := ACtl.ClientWidth;
end;

{function TCustomElListBox.GetThemedClassName: TLMDThemedItem;
begin
  Result := tiButton;
end;}

function TCustomElListBox.GetThemedElement: TThemedElement;
begin
  Result := teListView;
end;

procedure TCustomElListBox.HintWndProc(var Message: TMessage);
begin
  FHintWndProc(Message);
  if (Message.Msg = WM_SHOWWINDOW) and (Message.wParam = 0) then
  begin
    FHintWnd.WindowProc := FHintWndProc;
    CancelLineHint;
  end;
end;

procedure TCustomElListBox.IFMRepaintChildren(var Message: TMessage);
var i : integer;
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  for i := 0 to ControlCount -1 do
  begin
    if Controls[i] is TWinControl then
      PostMessage(TWinControl(Controls[i]).Handle, Message.Msg, Message.wParam, Message.lParam);
  end;
end;

procedure TCustomElListBox.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TCustomElListBox.IntMouseMove(XPos, YPos : SmallInt);
var i : integer;
begin
  if (TopIndex <> -1) and (ItemHeight > 0) then
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
  end
  else
    FCurHintItem := -1;
end;

procedure TCustomElListBox.LBGetTopIndex(var Msg: TMessage);
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

procedure TCustomElListBox.Loaded;
var
  Empty: Boolean;
begin
  inherited;

   Empty := (Items.Count = 0);
   if Empty then
     Items.Add(' ');

  if HandleAllocated then
    UpdateItemHeight;
  if HandleAllocated then
    RecreateWnd;
  ItemIndex := FItemIndex;

  if Empty then
    Items.Clear;

end;

procedure TCustomElListBox.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = Images then
      Images := nil;
    if AComponent = AlphaForImages then
      AlphaForImages := nil;

    if AComponent = FImgForm then
    begin
      FImgForm := nil;
      Invalidate;
    end;
  end;
end;

procedure TCustomElListBox.OnLineHintTimer(Sender : TObject);
var i : integer;
    P : TPoint;
    R,
    R1: TRect;
    FC: TColor;
begin
  FHintTimer.Enabled := false;
  if FHintWnd = nil then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);
    i := ItemAtPos(P, true);//SendMessage(Handle, LB_ITEMFROMPOINT, 0, MakeLParam(P.X, P.Y));
    if (i < 0) or (i >= Items.Count) then
      exit;

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
      FHintWnd.IsHTML := Boolean(Pos(('<html>'), Items[i]) = 1);
      FC := FHintWnd.Font.Color;
      FHintWnd.Font := Font;
      FHintWnd.Font.Color := FC;
      FHintWnd.Color := Color;
      {$IFDEF LMD_UNICODE}
      R := FHintWnd.CalcHintRectW(10000, Items[i], nil);
      {$ELSE}
      R := FHintWnd.CalcHintRect(10000, Items[i], nil);
      {$ENDIF}

      R1 := ItemRect(i);
      OffsetRect(R, R1.Left - 3, R1.Top - 3);
      R.TopLeft := ClientToScreen(R.TopLeft);
      R.BottomRight := ClientToScreen(R.BottomRight);

      {$IFDEF LMD_UNICODE}
      FHintWnd.ActivateHintW(R, Items[i]);
      {$ELSE}
      FHintWnd.ActivateHint(R, Items[i]);
      {$ENDIF}
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

function TCustomElListBox.RealScreenToClient(APoint : TPoint): TPoint;
var ACtl : TWinControl;
begin

  ACtl := FImgForm.GetRealControl;

  result := ACtl.ScreenToClient(APoint);
end;

procedure TCustomElListBox.ResetHorizontalExtent;
var
  I: Integer;
begin
  FMaxWidth := 0;
  for I := 0 to Items.Count - 1 do
    FMaxWidth := Max(FMaxWidth, GetItemWidth(I));
  SetHorizontalExtent;
end;

procedure TCustomElListBox.SelectedFontChanged(Sender: TObject);
begin
  ParentFont := False;
end;

procedure TCustomElListBox.WMChar(var Message: TWMChar);
begin
  if (Input.Text = '') and not (Message.CharCode in [VK_SPACE, VK_RETURN]) then
    inherited;
end;

procedure TCustomElListBox.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
var
  R1, BgRect: TRect;
begin
  if (FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and
    (not (csDesigning in Componentstate)) then
  begin
    R1 := ClientRect;
    BgRect := ClientRect;
    BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);

    BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
    BgRect.TopLeft := RealScreenToClient(BgRect.TopLeft);
    BgRect.BottomRight := RealScreenToClient(BgRect.BottomRight);

    FImgForm.PaintBkgnd(Msg.DC, R1, Point(BgRect.Left{ - ax}, BgRect.Top{ - ay}), false);
  end
  else

  if FTransparent then
    DrawParentControl(Msg.DC)
  else
    if FUseBackground and not Background.Empty then
      DrawBackground(Msg.DC, ClientRect)
    else
      begin
        inherited
      end;
end;

procedure TCustomElListBox.WMHScroll(var Message: TWMHScroll);
var
  fSavePos: Integer;
begin
  if Visible and (TWMScroll(Message).ScrollCode in [SB_LINEUP..SB_RIGHT]) then
  begin
    fSavePos := GetScrollBarPos( Handle, SB_HORZ);
    inherited;
    if fSavePos = GetScrollBarPos( Handle, SB_HORZ) then
      exit;
    if TWMScroll(Message).ScrollCode = SB_THUMBTRACK then
      FInHSCroll := true
    else
      FInHSCroll := false;

    if (Flat and (((not FMouseOver) and (not Focused)) or (FlatFocusedScrollBars))) then
      DrawFlatBorder(0, FInHScroll, FInVScroll);

    // repaint when scrolling
//    if not UseCustomScrollBars then
      Invalidate;
  end
  else
    inherited; // SB_ENDSCROLL
end;

procedure TCustomElListBox.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  if not HandleAllocated then
    exit;
  if Flat and not FMouseOver then
    DrawFlatBorder(0, false, false);
  if (Flat and ShowCheckBox) or HideSelection or (HideSelectColor <> FocusedSelectColor) or
     (HideSelectTextColor <> FocusedSelectTextColor) then
    Invalidate;
end;

procedure TCustomElListBox.WMMouseMove(var Message: TWMMouseMove);
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

procedure TCustomElListBox.WMNCCalcSize(var Message : TWMNCCalcSize);

begin
  inherited;
  if (BorderStyle = bsSingle) and (not IsThemed) then
  begin
    if Flat then
    begin
      if (ebsLeft in BorderSides) then
        inc(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smXEdge[Ctl3D]));
      if (ebsTop in BorderSides) then
        inc(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smYEdge[Ctl3D]));
      if (ebsRight in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smXEdge[Ctl3D]));
      if (ebsBottom in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smYEdge[Ctl3D]));
      end
    else
    begin
      if not (ebsLeft in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smXEdge[Ctl3D]));
      if not (ebsTop in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smYEdge[Ctl3D]));
      if not (ebsRight in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smXEdge[Ctl3D]));
      if not (ebsBottom in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smXEdge[Ctl3D]));
      end;
  end;
end;

procedure TCustomElListBox.WMNCMouseMove(var Message: TWMNCMouseMove);
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

procedure TCustomElListBox.WMNCPaint(var Msg: TWMNCPaint);
var
  DC        : HDC;
  RW, RC    : TRect;
  b         : Boolean;
  LThemeMode: TLMDThemeMode;

  procedure CallInheritedWOFrame;
  var
    WS, WES :DWORD;
  begin
    try
      WES := GetWindowLong(Handle, GWL_EXSTYLE);
      if WES and WS_EX_CLIENTEDGE <> 0 then
      begin
        WS := 0;
        FPreventStyleChange := True;
        SetWindowLong(Handle, GWL_EXSTYLE, WES and not WS_EX_CLIENTEDGE);
      end
      else
      begin
        WES := 0;
        WS  := GetWindowLong(Handle, GWL_STYLE);
        if WS and WS_BORDER <> 0 then
        begin
          FPreventStyleChange := True;
          SetWindowLong(Handle, GWL_STYLE, WS and not WS_BORDER);
        end
        else
          WS := 0;
      end;
      //inherited;
      DefWindowProc(Handle, Msg.Msg, TMessage(Msg).wParam, TMessage(Msg).lParam);
      if WES <> 0 then
        SetWindowLong(Handle, GWL_EXSTYLE, WES)
      else if WS <> 0 then
        SetWindowLong(Handle, GWL_STYLE, WS);
    finally
      if FPreventStyleChange then
        FPreventStyleChange := False;
    end;
  end;

  procedure PaintCrossSystemScrollbarsArea;
  var
    nFrameSize :Integer;
  begin
    GetWindowRect(Handle, RW);
    MapWindowPoints(0, Handle, RW, 2);
    OffsetRect(RW, -RW.Left, -RW.Top);

    if ((GetWindowLong(Handle, GWL_STYLE) and WS_BORDER) = WS_BORDER) then
      nFrameSize := GetSystemMetrics(SM_CXBORDER)
    else
      if ((GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE) = WS_EX_CLIENTEDGE) then
      nFrameSize := GetSystemMetrics(SM_CXEDGE)
    else
      nFrameSize := 0;

    with RW do
    begin
      if (not RightAlignedView) or (not NewStyleControls) then
      begin
        dec(Right, nFrameSize);
        Left:= Right - GetSystemMetrics(SM_CXVSCROLL);
        dec(Bottom, nFrameSize);
        Top   := Bottom - GetSystemMetrics(SM_CYHSCROLL);
      end
      else
      begin
        Left   := nFrameSize;
        Right := Left + GetSystemMetrics(SM_CXVSCROLL);
        dec(Bottom, nFrameSize);
        Top   := Bottom - GetSystemMetrics(SM_CYHSCROLL);
      end;
      Windows.DrawEdge(DC, RW, EDGE_SUNKEN, BF_MIDDLE);
    end;
  end;

begin
  if FPreventStyleChange then
    exit;

  b := (BorderStyle = bsSingle);
  LThemeMode := UseThemeMode;

  //DefWindowProc(Handle, Msg.Msg, Msg.wParam, Msg.lParam);
  if (LThemeMode <> ttmNone) and (BorderStyle = bsSingle) {and not Transparent} then
  begin
    //DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
    //if DC = 0 then
    begin
      DC := GetWindowDC(Handle);
    end;

    if b then
      CallInheritedWOFrame;

    Windows.GetClientRect(Handle, RC);

    {< ELSCROLLBAR}
    if UseCustomScrollBars then
    begin //???
      if VertScrollBarStyles.Visible then
      begin
        if (not RightAlignedView) then
          inc(RC.Right, VertScrollBarStyles.Depth)
        else
          dec(RC.Left, VertScrollBarStyles.Depth);
      end;
      if HorzScrollBarStyles.Visible then
        inc(RC.Bottom, HorzScrollBarStyles.Depth);
    end
    else
    {> ELSCROLLBAR}
    begin
      if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0 then
      begin
        if (not RightAlignedView) or (not NewStyleControls) then
          inc(RC.Right, GetSystemMetrics(SM_CXVSCROLL))
        else
          dec(RC.Left, GetSystemMetrics(SM_CXVSCROLL));

        // paint cross scrollbars area for system scrollbar:
        if (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0) then
          PaintCrossSystemScrollbarsArea;

      end;
      if GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0 then
        inc(RC.Bottom, GetSystemMetrics(SM_CYHSCROLL));
    end;

    GetWindowRect(Handle, RW);
    MapWindowPoints(0, Handle, RW, 2);
    OffsetRect(RC, -RW.Left, -RW.Top);
    ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
    OffsetRect(RW, -RW.Left, -RW.Top);
    // prev variant: part = 0 state = 0
    LMDThemeServices.DrawElement(LThemeMode, DC, ThemeServices.GetElementDetails(tlListviewDontCare), RW, nil);

    ReleaseDC(Handle, DC);
  end
  else
  begin
    // ??? todo: twinkle is possible
    //if b then
    inherited;

    if RightAlignedView and (not UseCustomScrollBars) and
       (GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0) and
       (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0) and
       (NewStyleControls)
    then
    begin
      DC := GetDCEx(Handle, Msg.RGN, DCX_WINDOW or DCX_INTERSECTRGN);
      if DC = 0 then
        DC := GetWindowDC(Handle);

      PaintCrossSystemScrollbarsArea;
      ReleaseDC(Handle, DC);
    end;
  end;
end;

function GetDynamicMethod(AClass: TClass; Index: Integer): Pointer; assembler;
asm
  CALL System.@FindDynaClass
end;

procedure TCustomElListBox.WMPaint(var Msg: TWMPaint);
type
  TWMPaintProc = procedure (Self : TWinControl; var Msg: TWMPaint);
var
  DC: HDC;
  R1, BgRect : TRect;
  P          : TPoint;
  ax, ay     : integer;
  bPaint     : TWMPaintProc;
  //aBrush     : HBrush;
  //PS         : TPaintStruct;
begin
  bPaint := TWMPaintProc(GetDynamicMethod(TWinControl, WM_PAINT));

  if FTransparent or (FUseBackground and not Background.Empty)
     or
     ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and
       (not (csDesigning in Componentstate)))
     then
  begin
    Perform(LB_GETTOPINDEX, 0, 0);
    bPaint(Self, msg);

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
  begin
    (*
    BeginPaint(Handle, PS);
    try
      DC := PS.hdc;
      GetClipBox(DC, R1);
      ABrush := CreateSolidBrush(ColorToRGB(Color));
      FillRect(DC, R1, ABrush);
      DeleteObject(ABrush);
      bPaint(Self, msg);
    finally
      EndPaint(Handle, PS);
    end;
    *)
    bPaint(Self, msg);
  end;

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

procedure TCustomElListBox.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if Flat and not FMouseOver then
    DrawFlatBorder(0, false, false);
  if (Flat and ShowCheckBox) or HideSelection or (HideSelectColor <> FocusedSelectColor) or
     (HideSelectTextColor <> FocusedSelectTextColor) then
    Invalidate;
end;

procedure TCustomElListBox.WMVScroll(var Message: TWMVScroll);
var
  fSavePos: Integer;
begin
  if Visible and (TWMScroll(Message).ScrollCode in [SB_LINEUP..SB_RIGHT]) then
  begin
    fSavePos := GetScrollBarPos( Handle, SB_VERT);
    inherited;
    if fSavePos = GetScrollBarPos( Handle, SB_VERT) then
      exit;
    if TWMScroll(Message).ScrollCode = SB_THUMBTRACK then
      FInVSCroll := true
    else
      FInVSCroll := false;

    if (Flat and (((not FMouseOver) and (not Focused)) or (FlatFocusedScrollBars))) then
      DrawFlatBorder(0, FInHScroll, FInVScroll);
    // repaint when scrolling
    //if not UseCustomScrollBars then
      Invalidate;
  end
  else
    inherited; // SB_ENDSCROLL
end;

procedure TCustomElListBox.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
end;

procedure TCustomElListBox.WndProc(var Message: TMessage);

begin
  if not (csDesigning in ComponentState) and ((Message.Msg = WM_LBUTTONDOWN) or
    (Message.Msg = WM_LBUTTONDBLCLK)) and not Dragging then
  begin
    if DragMode = dmAutomatic then
    begin
      if IsControlMouseMsg(TWMMouse(Message)) then
      Exit;
      ControlState := ControlState + [csLButtonDown];
      Dispatch(Message);  {overrides TControl's BeginDrag}
      Exit;
    end;
  end;
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

function TCustomElListBox.GetItemHeight: Integer;
var
  R: TRect;
  begin
  if HandleAllocated then
  begin
    if not (Style in [lbOwnerDrawFixed, lbOwnerDrawVariable]) then
    begin
      Perform(LB_GETITEMRECT, 0, TLMDPtrUInt(@R));
      Result := R.Bottom - R.Top;
    end
    else
      Result := FItemHeight;
  end
  else
    Result := FItemHeight;
end;

function TCustomElListBox.GetItemIndex: Integer;
begin
  if MultiSelect then
    Result := SendMessage(Handle, LB_GETCARETINDEX, 0, 0)
  else
    Result := SendMessage(Handle, LB_GETCURSEL, 0, 0);
end;

function TCustomElListBox.GetSelCount: Integer;
begin
  Result := SendMessage(Handle, LB_GETSELCOUNT, 0, 0);
end;

function TCustomElListBox.GetSelected(Index: Integer): Boolean;
var
  R: Longint;
begin
  R := SendMessage(Handle, LB_GETSEL, Index, 0);
  if R = LB_ERR then
    raise EListError.CreateResFmt(@SListIndexError, [Index]);
  Result := LongBool(R);
end;

function TCustomElListBox.GetTopIndex: Integer;
begin
  Result := SendMessage(Handle, LB_GETTOPINDEX, 0, 0);
end;

procedure TCustomElListBox.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElListBox.SetColumns(Value: Integer);
begin
  if FColumns <> Value then
    if (FColumns = 0) or (Value = 0) then
    begin
      FColumns := Value;
      RecreateWnd;
    end else
    begin
      FColumns := Value;
      if HandleAllocated then
        SetColumnWidth;
    end;
end;

procedure TCustomElListBox.SetExtendedSelect(Value: Boolean);
begin
  if Value <> FExtendedSelect then
  begin
    FExtendedSelect := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElListBox.SetIntegralHeight(Value: Boolean);
begin
  if Value <> FIntegralHeight then
  begin
    FIntegralHeight := Value;
    RecreateWnd;
    RequestAlign;
  end;
end;

procedure TCustomElListBox.SetItemHeight(Value: Integer);
 begin
  if (FItemHeight <> Value) and (Value > 0) then
  begin
    FItemHeight := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElListBox.SetItemIndex(Value: Integer);
var
  NewTI, OldTI : integer;
  Fla          : boolean;
begin
  if csLoading in ComponentState then
    FItemIndex := Value
  else
  begin
    Fla := GetItemIndex <> Value;
    if Fla or (FForceSetItemIndex) then
    begin
      OldTI := SendMessage(Handle, LB_GETTOPINDEX, 0, 0);
      // incremental search works only with PostMessage
      // ItemIndex := * works only with SendMessage
      // so I don't see other solution except below
      if MultiSelect then
      begin
        PostMessage(Handle, LB_SETCARETINDEX, Value, 0);
        SendMessage(Handle, LB_SETCARETINDEX, Value, 0);
      end
      else
      begin
        PostMessage(Handle, LB_SETCURSEL, Value, 0);
        SendMessage(Handle, LB_SETCURSEL, Value, 0);
      end;
      NewTI := SendMessage(Handle, LB_GETTOPINDEX, 0, 0);
      if OldTI <> NewTI then Invalidate;
    end;
    if Fla then
      TriggerChange;
  end;
end;

procedure TCustomElListBox.SetItems(Value: TLMDStrings);
begin
  Items.Assign(Value);
end;

procedure TCustomElListBox.SetMultiSelect(Value: Boolean);
begin
  if FMultiSelect <> Value then
  begin
    FMultiSelect := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElListBox.SetSelected(Index: Integer; Value: Boolean);
begin
  if SendMessage(Handle, LB_SETSEL, TLMDPtrUInt(Value), Index) = LB_ERR then
    raise EListError.CreateResFmt(@SListIndexError, [Index]);
    end;

procedure TCustomElListBox.SetSorted(Value: Boolean);
begin
  if FSorted <> Value then
  begin
    FSorted := Value;
    TLMDMemoryStrings(FListBoxStrings).Sorted := Value;
  end;
end;

procedure TCustomElListBox.SetTabWidth(Value: Integer);
begin
  if Value < 0 then
    Value := 0;
  if FTabWidth <> Value then
  begin
    FTabWidth := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElListBox.SetTopIndex(Value: Integer);
begin
  if GetTopIndex <> Value then
    SendMessage(Handle, LB_SETTOPINDEX, Value, 0);
end;

function TCustomElListBox.InternalGetItemData(Index: Integer): LongInt;
begin
  Result := GetItemData(Index);
end;

procedure TCustomElListBox.InternalSetItemData(Index: Integer; AData: LongInt);
begin
  SetItemData(Index, AData);
end;

function TCustomElListBox.ItemAtPos(Pos: TPoint; Existing: Boolean): Integer;
var
  Count: Integer;
  LItemRect: TRect;
  begin
  if PtInRect(ClientRect, Pos) then
  begin
    Result := TopIndex;
    Count := Items.Count;
    while Result < Count do
      begin
        Perform(LB_GETITEMRECT, Result, TLMDPtrUInt(@LItemRect));
        if PtInRect(LItemRect, Pos) then
          Exit;
        Inc(Result);
      end;
    if not Existing then
      Exit;
  end;
  Result := -1;
end;

function TCustomElListBox.ItemRect(Index: Integer): TRect;
var
  Count: Integer;
  begin
  Count := Items.Count;
  if (Index = 0) or (Index < Count) then
  begin
    Perform(LB_GETITEMRECT, Index, TLMDPtrUInt(@Result));
    end
  else
  if Index = Count then
  begin
    Perform(LB_GETITEMRECT, Index - 1, TLMDPtrUInt(@Result));
    OffsetRect(Result, 0, Result.Bottom - Result.Top);
  end
  else
    FillChar(Result, SizeOf(TRect), 0);
    end;

//@+ 2/5/03
procedure TCustomElListBox.CheckAll;
var
  i: Integer;
begin
  if ShowCheckBox then
    for i := 0 to pred(Items.Count) do
      State[i] := cbChecked;
end;

procedure TCustomElListBox.CheckSelected;
var
  i: Integer;
begin
  if ShowCheckBox then
    for i := 0 to pred(Items.Count) do
      if Selected[i] then
        State[i] := cbChecked;
end;

procedure TCustomElListBox.GrayAll;
var
  i: Integer;
begin
  if ShowCheckBox then
    for i := 0 to pred(Items.Count) do
      State[i] := cbGrayed;
end;

procedure TCustomElListBox.GraySelected;
var
  i: Integer;
begin
  if ShowCheckBox then
    for i := 0 to pred(Items.Count) do
      if Selected[i] then
        State[i] := cbGrayed;
end;

procedure TCustomElListBox.UncheckAll;
var
  i: Integer;
begin
  if ShowCheckBox then
    for i := 0 to pred(Items.Count) do
      State[i] := cbUnchecked;
end;

procedure TCustomElListBox.UncheckSelected;
var
  i: Integer;
begin
  if ShowCheckBox then
    for i := 0 to pred(Items.Count) do
      if Selected[i] then
        State[i] := cbUnchecked;
end;
//@- 2/5/03

(*
procedure TCustomElListBox.ResetHorizontalExtent1;
var
  I: Integer;
begin
  FMaxWidth := 0;
  for I := 0 to Items.Count - 1 do
    FMaxWidth := Max(FMaxWidth, GetItemWidth(I));
  SetHorizontalExtent;
end;
*)
procedure TCustomElListBox.SetHorizontalExtent;
begin
  SendMessage(Handle, LB_SETHORIZONTALEXTENT, FMaxWidth, 0);
end;

procedure TCustomElListBox.SetColumnWidth;
var
  ColWidth: Integer;
begin
  if (FColumns > 0) and (Width > 0) then
  begin
    ColWidth := (Width + FColumns - 3) div FColumns;
    if ColWidth < 1 then
      ColWidth := 1;
    SendMessage(Handle, LB_SETCOLUMNWIDTH, ColWidth, 0);
  end;
end;

function TCustomElListBox.GetItemData(Index: Integer): LongInt;
begin
  Result := SendMessage(Handle, LB_GETITEMDATA, Index, 0);
end;

procedure TCustomElListBox.SetItemData(Index: Integer; AData: LongInt);
begin
  SendMessage(Handle, LB_SETITEMDATA, Index, AData);
end;

procedure TCustomElListBox.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (FBorderStyle = bsSingle) and HandleAllocated then
    RecreateWnd;
  inherited;
end;

procedure TCustomElListBox.CNCommand(var Message: TWMCommand);
begin
  inherited Changed;
  exit;
  {
  case Message.NotifyCode of
    LBN_SELCHANGE:
      begin
        inherited Changed;
        Click;
      end;
    LBN_DBLCLK: DblClick;
  end;
  }
end;

procedure TCustomElListBox.CNDrawItem(var Message: TWMDrawItem);
var
  State: TOwnerDrawState;
begin
  with Message.DrawItemStruct^ do
  begin
    State := Windows.TOwnerDrawState(LongRec(itemState).Lo);

    FCanvas.Handle := hDC;
    FCanvas.Font := Font;
    FCanvas.Brush := Brush;

    if Integer(itemID) >= 0 then
      DrawItem(itemID, rcItem, State)
    else
      FCanvas.FillRect(rcItem);

    if ((odFocused in State) or (odSelected in State)) and
       not FHideFocusRect then
      DrawFocusRect(hDC, rcItem);

    FCanvas.Handle := 0;
  end;
end;

procedure TCustomElListBox.CNMeasureItem(var Message: TWMMeasureItem);
begin
  with Message.MeasureItemStruct^ do
  begin
    ItemHeight := FItemHeight;
    if FStyle = lbOwnerDrawVariable then
    begin
      MeasureItem(itemID, Integer(ItemHeight));
    end;
  end;
end;

procedure TCustomElListBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  if Assigned(FOnMeasureItem) then FOnMeasureItem(Self, Index, Height);
end;

procedure TCustomElListBox.WMLButtonDown(var Message: TWMLButtonDown);
var
  ItemNo, LTopIndex : Integer;
  ShiftState: TShiftState;
  p         : TPoint;
  R         : TRect;
  ImgOffs   : integer;
begin
  p := SmallPointToPoint(Message.Pos);
  LTopIndex := TopIndex;
  if Images <> nil then
    ImgOffs := Images.Width + 2
  else
    ImgOffs := 0;
  ItemNo := ItemAtPos(p, True);
  if ShowCheckBox then
  begin
    ItemNo := ItemAtPos(p, True);
    if ItemNo > -1 then
    begin
      R := ItemRect(ItemNo);
      if LMDInRange(P.x - R.Left, ImgOffs + 1, ImgOffs + GetCheckBoxSize.cx + 2) then
      begin
        exit;
      end;
    end;
  end;
  ShiftState := KeysToShiftState(Message.Keys);
  if (DragMode = dmAutomatic) and FMultiSelect then
  begin
    if not (ssShift in ShiftState) or (ssCtrl in ShiftState) then
    begin
      if (ItemNo >= 0) and (Selected[ItemNo]) then
      begin
        BeginDrag (False);
        Exit;
      end;
    end;
  end;
  FSavedItemIndex := ItemIndex;
  inherited;
  if (DragMode = dmAutomatic) and not (FMultiSelect and
    ((ssCtrl in ShiftState) or (ssShift in ShiftState))) then
    BeginDrag(False);
  if (Assigned(ImageForm) or Transparent) and (LTopIndex <> TopIndex) then
    Invalidate;
end;

procedure TCustomElListBox.WMLButtonUp(var Message: TWMLButtonDown);
var
  i, ItemNo  : Integer;
  ShiftState : TShiftState;
  p          : TPoint;
  R          : TRect;
  ImgOffs    : integer;
begin
  inherited;
  ShiftState := KeysToShiftState(Message.Keys);
  p := SmallPointToPoint(Message.Pos);
  if Images <> nil then
    ImgOffs := Images.Width + 2
  else
    ImgOffs := 0;
  ItemNo := ItemAtPos(p, True);
  if ShowCheckBox then
  begin
    if ItemNo > -1 then
    begin
      R := ItemRect(ItemNo);
      if LMDInRange(P.x - R.Left, ImgOffs + 1, ImgOffs + GetCheckBoxSize.cx + 2) then
      begin
        if (FCheckIndex > -1) and (ssShift in ShiftState) and
           (ItemNo <> FCheckIndex) and (AllowGrayed or
           (State[ItemNo] <> cbGrayed)) then
        begin
          TElListBoxStrings(Items).SetUpdateState(true);
          if FCheckIndex < ItemNo then
          begin
            for i := FCheckIndex + 1 to ItemNo do
            begin
              if State[i] = cbChecked then State[i] := cbUnChecked
                                      else State[i] := cbChecked;
            end;
            TElListBoxStrings(Items).SetUpdateState(false);
            TriggerMultiCheckEvent(FCheckIndex + 1, ItemNo);
          end                        else
          if ItemNo < FCheckIndex then
          begin
            for i := ItemNo to FCheckIndex - 1 do
            begin
              if State[i] = cbChecked then State[i] := cbUnChecked
                                      else State[i] := cbChecked;
            end;
            TElListBoxStrings(Items).SetUpdateState(false);
            TriggerMultiCheckEvent(ItemNo, FCheckIndex - 1);
          end;
          FCheckIndex := -1;
        end
        else
        begin
          FCheckIndex := ItemNo;
          case GetState(ItemNo) of
            cbUnchecked:
              if AllowGrayed then
                SetState(ItemNo, cbGrayed)
              else
                SetState(ItemNo, cbChecked);
            cbGrayed:
              SetState(ItemNo, cbChecked);
            cbChecked:
              SetState(ItemNo, cbUnchecked);
          end;
          TriggerCheckStateChange(ItemNo);
          TriggerCheckBoxChange(ItemNo, GetState(ItemNo));
        end;
      end;
    end;
  end;
  if FSavedItemIndex <> ItemIndex then
    TriggerChange;
end;

//<abb>
procedure TCustomElListBox.TriggerMultiCheckEvent(FromItemNo, ToItemNo : integer);
begin
  if Assigned(FOnMultiCheck) then FOnMultiCheck(Self, FromItemNo, ToItemNo);
end;
//</abb>

procedure TCustomElListBox.WMSize(var Message: TWMSize);
begin
  inherited;
  SetColumnWidth;
  Invalidate;
  if IsThemed or (Flat and (BorderStyle <> bsNone)) then
    DrawFlatBorder(0, false, false);
end;

procedure TCustomElListBox.WMMouseWheel(var Message: TWMMouseWheel);
begin
  inherited;
  Invalidate;
end;

procedure TCustomElListBox.ResetContent;
begin
  SendMessage(Handle, LB_RESETCONTENT, 0, 0);
end;

procedure TCustomElListBox.DeleteString(Index: Integer);
begin
  SendMessage(Handle, LB_DELETESTRING, Index, 0);
end;

procedure TCustomElListBox.SetShowCheckBox(Value: Boolean);
begin
  if FShowCheckBox <> Value then
  begin
    FShowCheckBox := Value;
    Invalidate;
  end;
end;

function TCustomElListBox.GetState(Index: Integer): TCheckBoxState;
begin
  if (Index>=0) and (Index<Items.Count) then
  begin
    if FStatesSize <= Index then
      SetStatesSize(Index + 1);
    result := TCheckBoxState(FStates[Index]);
  end
  else
    result := cbUnChecked;
end;

procedure TCustomElListBox.SetState(Index: Integer; Value: TCheckBoxState);
var R : TRect;
begin
  if not ( (Index>=0) and (Index<Items.Count)) then
    exit;
  if FStatesSize <= Index then
    SetStatesSize(Index + 1);
  FStates[Index] := Byte(Value);
  if HandleAllocated and (Index < Items.Count) then
  begin
    R := ItemRect(Index);
    if not IsRectEmpty(R) then
      InvalidateRect(Handle, @R, false);
  end;
end;

procedure TCustomElListBox.SetStatesSize(aSize : integer);
begin
  if aSize = 0 then
  begin
    if FStatesSize > 0 then
    begin
      FStatesSize := 0;
      SetLength(FStates, 0);
      end;
  end
  else
  begin
    SetLength(FStates, aSize);
    FStatesSize := aSize;
  end;
end;

function TCustomElListBox.GetCheckBoxSize: TSize;
begin
  Result.cx := CheckBoxSize;
  Result.cy := CheckBoxSize;
  if IsThemed then
  begin
    LMDThemeServices.GetThemePartSize(UseThemeMode, Canvas.Handle, teButton, 1, 0, Result);
  end;
end;

procedure TCustomElListBox.SetAllowGrayed(Value: Boolean);
var
  i: integer;
begin
  if FAllowGrayed <> Value then
  begin
    FAllowGrayed := Value;
    if not FAllowGrayed then
    for i := 0 to Items.Count - 1 do
    begin
      if State[i] = cbGrayed then
        FStates[i] := Byte(cbUnchecked);
    end;
  end;
end;

procedure TCustomElListBox.DrawFlatFrame(Canvas : TCanvas; R : TRect);
var AColor, Color : TColor;
begin
  if ((Focused or FMouseOver) and (ActiveBorderType = fbtColorLineBorder)) or
     ((not (Focused or FMouseOver)) and (InactiveBorderType = fbtColorLineBorder)) then
  begin
    if Enabled then
      Color := clWindow
    else
      Color := clBtnFace;
    if Focused or FMouseOver then
      AColor := LineBorderActiveColor
    else
      AColor := LineBorderInactiveColor;
    ELVCLUtils.DrawFlatFrameEx2(Canvas.Handle, R, AColor, Color, false, true, AllBorderSides, fbtColorLineBorder, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
  end
  else
    ElVCLUtils.DrawFlatFrame(Canvas.Handle, R, clBtnFace, false);
end;

procedure TCustomElListBox.OnImageListChange(Sender : TObject);
begin
  AdjustItemHeight;
  if (HandleAllocated) then
    Invalidate;//Repaint;
end; { OnImageListChange }

procedure TCustomElListBox.SetImages(newValue : TCustomImageList);
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
    end;
    AdjustItemHeight;
    if (HandleAllocated) then
      Invalidate;
  end; { if }
end; { SetImages }

procedure TCustomElListBox.SetAlphaImages(newValue : TCustomImageList);
{ Sets data member FAlphaImages to newValue. }
begin
  if (FAlphaImages <> newValue) then
  begin
    if FAlphaImages <> nil then
    begin
      if not (csDestroying in FAlphaImages.ComponentState) then
        FAlphaImages.RemoveFreeNotification(Self);
      FAlphaImages.UnRegisterChanges(FAImageChangeLink);
    end;
    FAlphaImages := newValue;
    if FAlphaImages <> nil then
    begin
      FAlphaImages.RegisterChanges(FAImageChangeLink);
      FAlphaImages.FreeNotification(Self);
    end;
//    AdjustItemHeight;
    if (HandleAllocated) then
      Invalidate;
  end; { if }
end; { SetAlphaImages }

procedure TCustomElListBox.AdjustItemHeight;
var r : integer;
    TM: TLMDTextMetric;
begin
  if not HandleAllocated then
    r := Abs(Font.Height) + 2
  else
  begin
    LMDGetTextMetrics(Canvas.Handle, TM);
    r := TM.tmHeight + 2;
  end;
  if Assigned(Images) then
    r := Max(r, Images.Height);
  ItemHeight := r;
end;

procedure TCustomElListBox.SetImagesSize(aSize : integer);
var
  P: PIntArray;
  i: integer;
begin
  if aSize = 0 then
  begin
    if FImagesSize > 0 then
    begin
      FImagesSize := 0;
      FreeMem(FImageIndex);
      end;
  end
  else
  begin
    GetMem(P, aSize * sizeof(Integer));
    if (P <> nil) then
    begin
      for i := 0 to aSize -1 do
        P[i] := -1;
      MoveMemory(P, FImageIndex, Min(aSize, FImagesSize) * sizeof(integer));
      if FImagesSize > 0 then
      begin
        FImagesSize := 0;
        FreeMem(FImageIndex);
        end;
      FImageIndex := P;
      FImagesSize := aSize;
    end;
  end;
end;

function TCustomElListBox.GetImageIndex(Index: Integer): Integer;
begin
  if (Index>=0) and (Index<Items.Count) then
  begin
    if FImagesSize <= Index then
      SetImagesSize(Index + 1);
    Result := FImageIndex[Index];
  end
  else
    result := -1;
end;

procedure TCustomElListBox.SetImageIndex(Index: Integer; Value: Integer);
var R : TRect;
begin
  if not ((Index>=0) and (Index<Items.Count)) then
    exit;
  if FImagesSize <= Index then
    SetImagesSize(Index + 1);
  FImageIndex[Index] := Value;
  if HandleAllocated and (Index < Items.Count) then
  begin
    R := ItemRect(Index);
    if not IsRectEmpty(R) then
      InvalidateRect(Handle, @R, false);
  end;
end;

{$IFDEF LMD_UNICODE}
{------------------------------------------------------------------------------}
procedure TCustomElListBox.CMHintShow(var Message:TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message); //outcommented VB Dec 2008
end;

{------------------------------------------------------------------------------}
procedure TCustomElListBox.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF}

procedure TCustomElListBox.ItemsChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TCustomElListBox.SetUseSelectedFont(Value: Boolean);
begin
  if FUseSelectedFont <> Value then
  begin
    FUseSelectedFont := Value;
    if HandleAllocated then
      Invalidate;
  end;
end;

function TCustomElListBox.IsTopIndexStored: Boolean;
begin
  Result := (TopIndex > 0);
end;

procedure TCustomElListBox.SetRightAlignedView(Value: Boolean);
begin
  if FRightAlignedView <> Value then
  begin
    FRightAlignedView := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElListBox.SetRightAlignedText(Value: Boolean);
begin
  if FRightAlignedText <> Value then
  begin
    FRightAlignedText := Value;
    RecreateWnd;
  end;
end;

procedure TCustomElListBox.SetFocusedSelectColor(newValue: TColor);
begin
  if (FFocusedSelectColor <> newValue) then
  begin
    FFocusedSelectColor := newValue;
    if (Focused or (not FHideSelection)) then
      Invalidate;
  end;  {if}
end;

procedure TCustomElListBox.SetFocusedSelectTextColor(newValue: TColor);
begin
  if (FFocusedSelectTextColor <> newValue) then
  begin
    FFocusedSelectTextColor := newValue;
    if (Focused or (not FHideSelection)) then
      Invalidate;
  end;  {if}
end;

procedure TCustomElListBox.SetHideSelectColor(newValue: TColor);
begin
  if (FHideSelectColor <> newValue) then
  begin
    FHideSelectColor := newValue;
    if not Focused and not FHideSelection then
      Invalidate;
  end;  {if}
end;

procedure TCustomElListBox.SetHideSelectTextColor(newValue: TColor);
begin
  if (FHideSelectTextColor <> newValue) then
  begin
    FHideSelectTextColor := newValue;
    if not Focused and not FHideSelection then
      Invalidate;
  end;  {if}
end;

procedure TCustomElListBox.SetHideSelection(Value: Boolean);
begin
  if FHideSelection <> Value then
  begin
    FHideSelection := Value;
    if not Focused then
      Invalidate;
  end;
end;

procedure TCustomElListBox.DefineProperties(Filer : TFiler);
begin
  inherited;
  Filer.DefineProperty('SelectedColor', ReadSelectedColor, nil, false);
  Filer.DefineProperty('SelectedFontColor', ReadSelectedFontColor, nil, false);
end;

procedure TCustomElListBox.ReadSelectedColor(Reader : TReader);
begin
  FocusedSelectColor := StringToColor(Reader.ReadIdent);
end;

procedure TCustomElListBox.ReadSelectedFontColor(Reader : TReader);
begin
  FocusedSelectTextColor := StringToColor(Reader.ReadIdent);
end;

procedure TCustomElListBox.SetHighlightAlphaLevel(Value: Integer);
begin
  if (FHighlightAlphaLevel <> Value) and (Value >= 0) and (Value <= 255) then
  begin
    FHighlightAlphaLevel := Value;
    Invalidate;
  end;
end;

procedure TCustomElListBox.TriggerChange;
begin
  if assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TCustomElListBox.TriggerCheckStateChange(ItemNo : integer);
begin
  if assigned(FOnCheckStateChange) then
    FOnCheckStateChange(Self, ItemNo);
end;

procedure TCustomElListBox.WMKeyDown(var Message: TWMKeyDown);
var
  LTopIndex: integer;
begin
  LTopIndex := TopIndex;
  if Message.CharCode in [VK_UP,VK_DOWN,VK_LEFT,VK_RIGHT,VK_SPACE,VK_RETURN] then
    FSavedIndex := ItemIndex
  else
    FSavedIndex := -1;
  if not ((Message.CharCode = VK_SPACE) and (FMultiSelect)) then
    inherited;
  if Message.CharCode in [VK_UP,VK_DOWN,VK_LEFT,VK_RIGHT] then
  begin
    if Assigned(OnClick) then
      OnClick(self);
    if ItemIndex <> FSavedIndex then
      TriggerChange;
  end;
  if Message.CharCode <> VK_SPACE then
  begin
    Input.WMKeyDown(Message);
    if (not DoPerformSearch(Input.Text)) then
      if (Length(Input.Text) = 2) and (Input.Text[1] = Input.Text[2]) then
      begin
        Input.Reset;
        Input.WMKeyDown(Message);
        DoPerformSearch(Input.Text, -1);
      end;
  end;
  if (Message.CharCode in [VK_UP,VK_DOWN]) and (Assigned(ImageForm) or Transparent) and (LTopIndex <> TopIndex) then
    Invalidate;
end;

procedure TCustomElListBox.WMKeyUp(var Message: TWMKeyUp);
var
  i: Integer;
begin
  if Message.CharCode = VK_SPACE then
  begin
    if ShowCheckBox then
    begin
      for i := 0 to pred(Items.Count) do
        if Selected[i] then
        begin
          FCheckIndex := i;
          case GetState(i) of
            cbUnchecked:
              if AllowGrayed then
                SetState(i, cbGrayed)
              else
                SetState(i, cbChecked);
            cbGrayed:
              SetState(i, cbChecked);
            cbChecked:
              SetState(i, cbUnchecked);
          end;
          TriggerCheckStateChange(i);
          TriggerCheckBoxChange(i, GetState(i));
        end;
    end;
  end;
//  inherited;
end;

{$ifdef LMD_UNICODE}
procedure TCustomElListBox.WMDeadChar(var Message: TWMDeadChar);
begin
  inherited;
  Input.WMDeadChar(Message);
end;

procedure TCustomElListBox.WMIMEComposition(var Message: TMessage);
begin
  inherited;
  Input.WMImeComposition(Message);
  if (not DoPerformSearch(Input.Text)) then
    if (Length(Input.Text) = 2) and (Input.Text[1] = Input.Text[2]) then
    begin
      Input.Reset;
      Input.WMImeComposition(Message);
      DoPerformSearch(Input.Text, -1);
    end;
end;
{$endif}

procedure TCustomElListBox.WMIMEStartComposition(var Message: TMessage);
var
  IMC: HIMC;
  LogFont: TLogFont;
  CF: TCompositionForm;
begin
  inherited;
  IMC := ImmGetContext(Handle);
  if IMC <> 0 then
  begin
    GetObject(Canvas.Font.Handle, SizeOf(TLogFont), @LogFont);
    ImmSetCompositionFont(IMC, @LogFont);
    CF.dwStyle := CFS_RECT;
    CF.rcArea  := ClientRect;
    CF.ptCurrentPos := Point(0, 0);

    ImmSetCompositionWindow(IMC, @CF);
    ImmReleaseContext(Handle, IMC);
  end;
end;

procedure TCustomElListBox.StartClearSearchTimeoutThread;
begin
  if Assigned (SearchTextTimeoutThread) then
    TSearchTextTimeoutThread(SearchTextTimeoutThread).KeepAlive := True
  else
  begin
    SearchTextTimeoutThread := TSearchTextTimeoutThread.Create ;
    SearchTextTimeoutThread.OnTerminate := SearchTextTimeout ;
    SearchTextTimeoutThread.Resume
  end;
  TSearchTextTimeoutThread(SearchTextTimeoutThread).IncrementalSearchTimeout := IncrementalSearchTimeout;
end;

procedure TCustomElListBox.StopClearSearchTimeoutThread;
begin
  if Assigned (SearchTextTimeoutThread) then
  begin
    SearchTextTimeoutThread.OnTerminate := nil ;
    SearchTextTimeoutThread.Terminate ;

    SearchTextTimeoutThread := nil
  end
end ;

function TCustomElListBox.DoPerformSearch(SearchText : TLMDString; AFromIndex: Integer = 0): Boolean;
var
  liIndex: Integer ;
  ItemText: TLMDString;
  SaveItemIndex :Integer;
  i: Integer;
begin
  Result := False;
  if (SearchText <> '') then
  begin
    SaveItemIndex := ItemIndex;

    if AFromIndex = -1 then
    begin
      AFromIndex := ItemIndex + 1;
      if AFromIndex = Items.Count then
        AFromIndex := 0;
    end;

    for i := 0 to 1 do
    begin
      for liIndex := AFromIndex to (Items.Count - 1) do
      begin
        ItemText := Items[liIndex];

        if DoCompareItems(SearchText, liIndex) then
        begin
          ItemIndex := liIndex;
          Result := True;
          Break;
        end;
      end;

      if AFromIndex = 0 then
        Break;

      if not Result then
        AFromIndex := 0;
    end;

    StartClearSearchTimeoutThread;

    if (SaveItemIndex <> ItemIndex) and Assigned(OnClick) then
      OnClick(Self);
  end;
end;

procedure TCustomElListBox.SearchTextTimeout(Sender : TObject);
begin
  SearchTextTimeoutThread := nil ;
  Input.Reset;
end;

function TCustomElListBox.DoCompareItems(SearchText : String; ItemIndex :
    integer): Boolean;
begin
  {$IFDEF LMD_UNICODE}
    Result := LMDWideSameText(SearchText, Copy(Items[ItemIndex], 1, Length(SearchText)));
  {$ELSE}
    Result := LMDSameText(SearchText, Copy (Items[ItemIndex], 1, Length(SearchText)));
  {$ENDIF}
end;

procedure TCustomElListBox.TriggerCheckBoxChange(ItemNo : integer; ItemState:
    TCheckBoxState);
begin
  if assigned(FOnCheckBoxChange) then
    FOnCheckBoxChange(Self, ItemNo, ItemState);
end;

procedure TCustomElListBox.SetUseXPThemes(const Value : boolean);
begin
  inherited;
  fSBCtrl.UseXPThemes := Value;
end;

procedure TCustomElListBox.SetThemeMode(const Value: TLMDThemeMode);
begin
  inherited;
  fSBCtrl.ThemeMode := Value;
end;

procedure TCustomElListBox.SetThemeGlobalMode(const Value: Boolean);
begin
  inherited;
  fSBCtrl.ThemeGlobalMode := Value;
end;

function TCustomElListBox.GetCount:Integer;
begin
  Result := Items.Count;
end;

procedure TCustomElListBox.UpdateItemHeight;
var
  tm: TLMDTextMetric;
begin
  if not (Style in [lbOwnerDrawFixed, lbOwnerDrawVariable]) then
  begin
    LMDGetTextMetrics(Canvas.Handle, tm);
    FItemHeight := tm.tmHeight;
    Perform(LB_SETITEMHEIGHT, 0, FItemHeight);
  end;
end;

procedure TCustomElListBox.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    if Flat then
      DrawFlatBorder(0, false, false);
    end;
end;

procedure TCustomElListBox.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    if Flat then
      DrawFlatBorder(0, false, false);
    end;
end;

procedure TCustomElListBox.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    if Flat then
      DrawFlatBorder(0, false, false);
    end;
end;

procedure TCustomElListBox.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    if Flat then
      DrawFlatBorder(0, false, false);
    end;
end;

procedure TCustomElListBox.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    if Flat then
      DrawFlatBorder(0, false, false);
    end;
end;

//Validatoin support, November 2007 (RS)
procedure TCustomElListBox.SetErrorMessage(val: TLMDString; errorLevel: integer);
begin
  if val <> '' then
    Self.Items.Add(val);
end;

function TCustomElListBox.GetLastErrorMessage: TLMDString;
begin
  if Self.Items.Count > 0 then
    Result := Self.Items[Self.Items.Count - 1];
end;
//end of Validation support, November 2007 (RS)

function TElListBoxStrings.Add(const S: TLMDBaseString): Integer;
begin
  ListBox.HandleNeeded;
{$IFDEF LMD_UNICODE}
  Result := inherited Add(S);
  {$ifndef LMD_NATIVEUNICODE}
  if Result >= 0 then
    SendMessage(ListBox.Handle, LB_INSERTSTRING, Result, TLMDPtrInt(PChar('')));
  {$endif}
  if Result = -2 then
    Result := 0;
{$ELSE}
  {$ifndef LMD_NATIVEUNICODE}
  Result := SendMessage(ListBox.Handle, LB_ADDSTRING, 0, TLMDPtrInt(PChar(S)));
  {$endif}
{$ENDIF}
  if Result < 0 then
    raise EOutOfResources.Create(SInsertLineError);
end;

function TElListBoxStrings.AddObject(const S: TLMDBaseString; AnObject : TObject): Integer;
begin
  ListBox.HandleNeeded;
{$IFDEF LMD_UNICODE}
  Result := inherited AddObject(S, AnObject);
  if Result <> -1 then
    PutObject(Result, AnObject);
  {$ifdef LMD_NATIVEUNICODE}
  //SendTextMessage(ListBox.Handle, LB_INSERTSTRING, Result, '');
  SendTextMessage(ListBox.Handle, LB_ADDSTRING, Result, '');
  {$endif}
{$ELSE}
  Result := SendMessage(ListBox.Handle, LB_ADDSTRING, 0, TLMDPtrUInt(PChar(S)));
  if Result <> -1 then
    PutObject(Result, AnObject);
{$ENDIF}
  if Result < 0 then
    raise EOutOfResources.Create(SInsertLineError);
end;

procedure TElListBoxStrings.Clear;
begin
{$IFDEF LMD_UNICODE}
  inherited;
{$ENDIF}
  ListBox.ResetContent;
end;

constructor TElListBoxStrings.Create;
begin
  inherited Create;
  Duplicates := dupAccept;
end;

procedure TElListBoxStrings.Delete(Index: Integer);
begin
  if (Index >= 0) and (Index < GetCount) then
  begin
    ListBox.DeleteString(Index);
  {$IFDEF LMD_UNICODE}
    inherited;
  {$ENDIF}
  end;
end;

procedure TElListBoxStrings.Exchange(Index1, Index2: Integer);
var
{$IFNDEF LMD_UNICODE}
  TempData: Longint;
  TempString: string;
{$ENDIF}
  tmpCheckBoxState: Byte;
  tmpImageIndex: Integer;
begin
  if Index1 = Index2 then
    exit;
  BeginUpdate;
  try
  {$IFDEF LMD_UNICODE}
    inherited;
  {$ELSE}
    TempString := Strings[Index1];

    TempData := ListBox.InternalGetItemData(Index1);
    Strings[Index1] := Strings[Index2];
    ListBox.InternalSetItemData(Index1, ListBox.InternalGetItemData(Index2));
    Strings[Index2] := TempString;
    ListBox.InternalSetItemData(Index2, TempData);
  {$ENDIF}
    if ListBox.State[Index1]<>ListBox.State[Index2] then
    begin
      tmpCheckBoxState := ListBox.FStates[Index1];
      ListBox.FStates[Index1] := ListBox.FStates[Index2];
      ListBox.FStates[Index2] := tmpCheckBoxState;
    end;
    if ListBox.ImageIndex[Index1]<>ListBox.ImageIndex[Index2] then
    begin
      tmpImageIndex := ListBox.FImageIndex[Index1];
      ListBox.FImageIndex[Index1] := ListBox.FImageIndex[Index2];
      ListBox.FImageIndex[Index2] := tmpImageIndex;
    end;
    if ListBox.ItemIndex = Index1 then
      ListBox.ItemIndex := Index2
    else
    if ListBox.ItemIndex = Index2 then
      ListBox.ItemIndex := Index1;
  finally
    EndUpdate;
  end;
end;

function TElListBoxStrings.Get(Index: Integer): TLMDBaseString;
{$IFNDEF LMD_UNICODE}
var
  Len: Integer;
  Text: array[0..4095] of Char;
{$ENDIF}
begin
{$IFDEF LMD_UNICODE}
  result := inherited Get(Index);
{$ELSE}
  Len := SendMessage(ListBox.Handle, LB_GETTEXT, Index, TLMDPtrUInt(@Text));
  if Len < 0 then
    Error(SListIndexError, Index);
  SetString(Result, Text, Len);
{$ENDIF}
end;

function TElListBoxStrings.GetCount: Integer;
begin
{$IFDEF LMD_UNICODE}
  result := inherited GetCount;
{$ELSE}
  Result := SendMessage(ListBox.Handle, LB_GETCOUNT, 0, 0);
{$ENDIF}
end;

function TElListBoxStrings.GetObject(Index: Integer): TObject;
begin
{$IFDEF LMD_UNICODE}
  Result := inherited GetObject(Index);
{$ELSE}
  Result := TObject(ListBox.GetItemData(Index));
  if (TLMDPtrUInt(Result) = LB_ERR) and ((Index < 0) or (Index >= ListBox.Count)) then
    Error(SListIndexError, Index);
{$ENDIF}
end;

function TElListBoxStrings.IndexOf(const S: TLMDBaseString): Integer;
begin
{$IFDEF LMD_UNICODE}
  Result := inherited IndexOf(S);
{$ELSE}
  Result := SendMessage(ListBox.Handle, LB_FINDSTRINGEXACT, -1, TLMDPtrUInt(PChar(S)));
{$ENDIF}
end;

procedure TElListBoxStrings.Insert(Index: Integer; const S: TLMDBaseString);
begin
  ListBox.HandleNeeded;
{$IFDEF LMD_UNICODE}
  inherited Insert(Index, S);
  {$ifndef LMD_NATIVEUNICODE}
  if SendMessage(ListBox.Handle, LB_INSERTSTRING, Index, TLMDPtrInt(PChar(''))) < 0 then
    raise EOutOfResources.Create(SInsertLineError);
  {$endif}
{$ELSE}
  if SendMessage(ListBox.Handle, LB_INSERTSTRING, Index,
    TLMDPtrUInt(PChar(S))) < 0 then
    raise EOutOfResources.Create(SInsertLineError);
{$ENDIF}
end;

procedure TElListBoxStrings.Move(CurIndex, NewIndex: Integer);
var
{$IFNDEF LMD_UNICODE}
  TempData: Longint;
  TempString: string;
{$ENDIF}
  tmpCheckBoxState: Byte;
  tmpImageIndex: Integer;
begin
  if CurIndex <> NewIndex then
  begin
    BeginUpdate;
    try
    {$IFDEF LMD_UNICODE}
      inherited;
    {$ELSE}
      ListBox.FMoving := True;
      try
        TempString := Get(CurIndex);
        TempData := ListBox.InternalGetItemData(CurIndex);
        ListBox.InternalSetItemData(CurIndex, 0);
        Delete(CurIndex);
        Insert(NewIndex, TempString);
        ListBox.InternalSetItemData(NewIndex, TempData);
      finally
        ListBox.FMoving := False;
      end;
    {$ENDIF}
      if ListBox.State[CurIndex]<>ListBox.State[NewIndex] then
      begin
        tmpCheckBoxState := ListBox.FStates[CurIndex];
        ListBox.FStates[CurIndex] := ListBox.FStates[NewIndex];
        ListBox.FStates[NewIndex] := tmpCheckBoxState;
      end;
      if ListBox.ImageIndex[CurIndex]<>ListBox.ImageIndex[NewIndex] then
      begin
        tmpImageIndex := ListBox.FImageIndex[CurIndex];
        ListBox.FImageIndex[CurIndex] := ListBox.FImageIndex[NewIndex];
        ListBox.FImageIndex[NewIndex] := tmpImageIndex;
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TElListBoxStrings.Put(Index: Integer; const S: TLMDBaseString);
{$IFNDEF LMD_UNICODE}
var
  I: Integer;
  TempData: Longint;
{$ENDIF}
begin
{$IFDEF LMD_UNICODE}
  inherited;
{$ELSE}
  I := ListBox.ItemIndex;
  TempData := ListBox.InternalGetItemData(Index);
  // Set the Item to 0 in case it is an object that gets freed during Delete
  ListBox.InternalSetItemData(Index, 0);
  Delete(Index);
  InsertObject(Index, S, nil);
  ListBox.InternalSetItemData(Index, TempData);
  ListBox.ItemIndex := I;
{$ENDIF}
end;

procedure TElListBoxStrings.PutObject(Index: Integer; AObject: TObject);
begin
{$IFDEF LMD_UNICODE}
  inherited;
{$ELSE}
  ListBox.SetItemData(Index, TLMDPtrUInt(AObject));
{$ENDIF}
end;

{$IFNDEF LMD_UNICODE}

procedure TElListBoxStrings.InsertObject(Index: Integer; const S: string;
  AObject: TObject);
begin
  if Sorted then Error(@SSortedListError, 0);
  if (Index < 0) or (Index > Count) then Error(@SListIndexError, Index);
  InsertItem(Index, S, AObject);
end;

procedure TElListBoxStrings.InsertItem(Index: Integer; const S: string; AObject: TObject);
begin
  Insert(Index, S);
  PutObject(Index, AObject);
end;

{$ENDIF}

{$IFDEF LMD_NATIVEUNICODE}
procedure TElListBoxStrings.InsertObject(Index: Integer; const S: string; AObject: TObject);
begin
  ListBox.HandleNeeded;
  inherited;
  SendTextMessage(ListBox.Handle, LB_INSERTSTRING, Index, S);
end;
{$ENDIF}

procedure TElListBoxStrings.SetUpdateState(Updating: Boolean);
begin
  SendMessage(ListBox.Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then
    ListBox.Refresh;
end;

procedure TElListBoxStrings.ResetBox;
var i : integer;
begin
  for i :=0 to Count -1 do
    SendMessage(ListBox.Handle, LB_INSERTSTRING, i, TLMDPtrInt(PChar('')));
    end;

procedure TCustomElListBox.SetHideFocusRect(Value: Boolean);
begin
  if FHideFocusRect <> Value then
  begin
    FHideFocusRect := Value;
    Invalidate;
  end;
end;

procedure TCustomElListBox.PaintWindow(DC: HDC);
const
  PaintMessage: array[Boolean] of Cardinal = (WM_PAINT, WM_PRINTCLIENT);
var
  Message: TMessage;
begin
  // EB-2016: This method is copied from TWinControl.PaintWindow and its
  // overrides back TCustomControl.PaintWindow. This is required for correct
  // drawing in DoubleBuffered mode.

  Message.Msg := {$IFDEF LMDCOMP14}PaintMessage[csPrintClient in ControlState]
                 {$ELSE}WM_PAINT{$ENDIF};
  Message.WParam := DC;
  Message.LParam := 0;
  Message.Result := 0;

  DefaultHandler(Message);
end;

end.
