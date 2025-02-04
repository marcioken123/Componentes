
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressEditors                                               }
{                                                                    }
{       Copyright (c) 1998-2007 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSEDITORS AND ALL                }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxRichEdit;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  Windows, Classes, ClipBrd, ComCtrls, Controls, Dialogs, Forms, Graphics,
  Menus, Messages, RichEdit, StdCtrls, SysUtils, cxClasses, cxContainer,
  cxControls, cxEdit, cxDrawTextUtils, cxGraphics, cxLookAndFeels, cxMemo,
  cxScrollbar, cxTextEdit;

type
  TcxCustomRichEditViewInfo = class(TcxCustomMemoViewInfo)
  public
    DrawBitmap: HBITMAP;
    IsDrawBitmapDirty: Boolean;
    PrevDrawBitmapSize: TSize;
    constructor Create; override;
    destructor Destroy; override;
    procedure DrawText(ACanvas: TcxCanvas); override;
    function GetUpdateRegion(AViewInfo: TcxContainerViewInfo): TcxRegion; override;
    function NeedShowHint(ACanvas: TcxCanvas; const P: TPoint;
      const AVisibleBounds: TRect; out AText: TCaption;
      out AIsMultiLine: Boolean; out ATextRect: TRect): Boolean; override;
    procedure Paint(ACanvas: TcxCanvas); override;
  end;

  TcxCustomRichEditProperties = class;

  TcxCustomRichEditViewData = class(TcxCustomMemoViewData)
  private
    function GetProperties: TcxCustomRichEditProperties;
  protected
    function InternalGetEditContentSize(ACanvas: TcxCanvas;
      const AEditValue: TcxEditValue;
      const AEditSizeProperties: TcxEditSizeProperties): TSize; override;
  public
    procedure Calculate(ACanvas: TcxCanvas; const ABounds: TRect; const P: TPoint;
      Button: TcxMouseButton; Shift: TShiftState; AViewInfo: TcxCustomEditViewInfo;
      AIsMouseEvent: Boolean); override;
    property Properties: TcxCustomRichEditProperties read GetProperties;
  end;

  { TcxCustomRichEditProperties }

  TcxCustomRichEditProperties = class(TcxCustomMemoProperties)
  private
    FHideScrollBars: Boolean;
    FMemoMode: Boolean;
    FPlainText: Boolean;
    FPlainTextChanged: Boolean;
    FSelectionBar: Boolean;
    FOnProtectChange: TRichEditProtectChange;
    FOnResizeRequest: TRichEditResizeEvent;
    FOnSaveClipboard: TRichEditSaveClipboard;
    FOnSelectionChange: TNotifyEvent;
    procedure SetHideScrollBars(Value: Boolean);
    procedure SetMemoMode(Value: Boolean);
    procedure SetPlainText(Value: Boolean);
    procedure SetSelectionBar(Value: Boolean);
  protected
    function CanValidate: Boolean; override;
    class function GetViewDataClass: TcxCustomEditViewDataClass; override;
    property PlainTextChanged: Boolean read FPlainTextChanged;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    class function GetContainerClass: TcxContainerClass; override;
    function GetDisplayText(const AEditValue: TcxEditValue;
      AFullText: Boolean = False; AIsInplace: Boolean = True): WideString; override;
    function GetSupportedOperations: TcxEditSupportedOperations; override;
    class function GetViewInfoClass: TcxContainerViewInfoClass; override;
    function IsResetEditClass: Boolean; override;
    property PlainText: Boolean read FPlainText write SetPlainText default False;
    // !!!
    property HideScrollBars: Boolean read FHideScrollBars
      write SetHideScrollBars default True;
    property MemoMode: Boolean read FMemoMode write SetMemoMode default False;
    property SelectionBar: Boolean read FSelectionBar write SetSelectionBar
      default False;
    property OnProtectChange: TRichEditProtectChange read FOnProtectChange
      write FOnProtectChange;
    property OnResizeRequest: TRichEditResizeEvent read FOnResizeRequest
      write FOnResizeRequest;
    property OnSaveClipboard: TRichEditSaveClipboard read FOnSaveClipboard
      write FOnSaveClipboard;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange
      write FOnSelectionChange;
  end;

  { TcxRichEditProperties }

  TcxRichEditProperties = class(TcxCustomRichEditProperties)
  published
    property Alignment;
    property AssignedValues;
    property AutoSelect;
    property ClearKey;
    property HideScrollBars;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property MemoMode;
    property OEMConvert;
    property PlainText;
    property ReadOnly;
    property ScrollBars;
    property SelectionBar;
    property VisibleLineCount;
    property WantReturns;
    property WantTabs;
    property WordWrap;
    property OnChange;
    property OnEditValueChanged;
    property OnProtectChange;
    property OnResizeRequest;
    property OnSaveClipboard;
    property OnSelectionChange;
  end;

  TcxRichInnerEdit = class;
  TcxCustomRichEdit = class;
  TOnChange = procedure (Sender: TObject) of Object;

  { TcxCustomRichEdit }


  TcxCustomRichEdit = class(TcxCustomMemo)
  private
    FEditPopupMenu: TComponent;
    FIsNullEditValue: Boolean;
    FPropertiesChange: Boolean;
    procedure DoProtectChange(Sender: TObject; AStartPos, AEndPos: Integer;
      var AAllowChange: Boolean);
    procedure DoSaveClipboard(Sender: TObject; ANumObjects, ANumChars: Integer;
      var ASaveClipboard: Boolean);
    procedure EditPopupMenuClick(Sender: TObject);
    function GetLines: TStrings;
    function GetInnerRich: TcxRichInnerEdit;
    procedure SetLines(Value: TStrings);
    function GetActiveProperties: TcxCustomRichEditProperties;
    function GetProperties: TcxCustomRichEditProperties;
    procedure SetProperties(Value: TcxCustomRichEditProperties);
    function GetCanUndo: Boolean;
    function GetDefAttributes: TTextAttributes;
    function GetDefaultConverter: TConversionClass;
    function GetPageRect: TRect;
    function GetParagraph: TParaAttributes;
    function GetSelAttributes: TTextAttributes;
    procedure RefreshScrollBars;
    procedure SetDefAttributes(const Value: TTextAttributes);
    procedure SetDefaultConverter(Value: TConversionClass);
    procedure SetPageRect(const Value: TRect);
    procedure SetSelAttributes(const Value: TTextAttributes);
    procedure EMCanPaste(var Message: TMessage); message EM_CANPASTE;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
  protected
    procedure AdjustInnerEdit; override;
    function CanFocusOnClick: Boolean; override;
    function CanKeyDownModifyEdit(Key: Word; Shift: TShiftState): Boolean; override;
    procedure ContainerStyleChanged(Sender: TObject); override;
    function DoShowPopupMenu(AMenu: TComponent; X, Y: Integer): Boolean; override;
    function GetEditValue: TcxEditValue; override;
    function GetInnerEditClass: TControlClass; override;
    procedure ChangeHandler(Sender: TObject); override;
    procedure Scroll(AScrollBarKind: TScrollBarKind; AScrollCode: TScrollCode;
      var AScrollPos: Integer); override;
    procedure Initialize; override;
    procedure InternalSetEditValue(const Value: TcxEditValue;
      AValidateEditValue: Boolean); override;
    procedure InternalValidateDisplayValue(const ADisplayValue: TcxEditValue); override;
    procedure PropertiesChanged(Sender: TObject); override;
    procedure ResetEditValue; override;
    procedure SetParent(AParent: TWinControl); override;
    procedure SynchronizeDisplayValue; override;
    procedure SynchronizeEditValue; override;
    function UpdateContentOnFocusChanging: Boolean; override;
    procedure UpdateScrollBars; override;
    function CanDeleteSelection: Boolean;
    procedure Changed(Sender: TObject);
    procedure DoOnResizeRequest(const R: TRect);
    procedure DoOnSelectionChange;
    function GetEditPopupMenuInstance: TComponent; virtual;
    function IsNavigationKey(Key: Word; Shift: TShiftState): Boolean; virtual;
    procedure UpdateEditPopupMenuItems(APopupMenu: TComponent); virtual;
    property EditPopupMenu: TComponent read FEditPopupMenu write FEditPopupMenu;
    property InnerRich: TcxRichInnerEdit read GetInnerRich;
    property PropertiesChange: Boolean read FPropertiesChange;
  public
    destructor Destroy; override;
    procedure ClearSelection; override;
    procedure CutToClipboard; override;
    function FindTexT(const ASearchStr: string; AStartPos, ALength: Integer;
      AOptions: TSearchTypes): Integer;
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    procedure PasteFromClipboard; override;
    procedure PrepareEditValue(const ADisplayValue: TcxEditValue;
      out EditValue: TcxEditValue; AEditFocused: Boolean); override;
    procedure Print(const Caption: string); virtual;
    procedure Undo; override;
    class procedure RegisterConversionFormat(const AExtension: string;
      AConversionClass: TConversionClass);
    property ActiveProperties: TcxCustomRichEditProperties
      read GetActiveProperties;
    property CanUndo: Boolean read GetCanUndo;
    property DefAttributes: TTextAttributes read GetDefAttributes write SetDefAttributes;
    property DefaultConverter: TConversionClass
      read GetDefaultConverter write SetDefaultConverter;
    property Lines: TStrings read GetLines write SetLines;
    property PageRect: TRect read GetPageRect write SetPageRect;
    property Paragraph: TParaAttributes read GetParagraph;
    property Properties: TcxCustomRichEditProperties read GetProperties
      write SetProperties;
    property SelAttributes: TTextAttributes read GetSelAttributes write SetSelAttributes;
  end;

  { TcxRichEdit }

  TcxRichEdit = class(TcxCustomRichEdit)
  private
    function GetActiveProperties: TcxRichEditProperties;
    function GetProperties: TcxRichEditProperties;
    procedure SetProperties(Value: TcxRichEditProperties);
  public
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    property ActiveProperties: TcxRichEditProperties read GetActiveProperties;
  published
    property Align;
    property Anchors;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property Properties: TcxRichEditProperties read GetProperties
      write SetProperties;
    property Lines; // must be after Properties because of Properties.Alignment
    property ShowHint;
    property Style;
    property StyleDisabled;
    property StyleFocused;
    property StyleHot;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  TcxRichInnerEditHelper = class(TcxInterfacedPersistent,
    IcxContainerInnerControl, IcxCustomInnerEdit, IcxInnerTextEdit,
    IcxInnerMemo)
  private
    FEdit: TcxRichInnerEdit;
  protected
    property Edit: TcxRichInnerEdit read FEdit;
  public
    constructor Create(AEdit: TcxRichInnerEdit); reintroduce; virtual;

    // IcxContainerInnerControl
    function GetControlContainer: TcxContainer;
    function GetControl: TWinControl;

    // IcxCustomInnerEdit
    function CallDefWndProc(AMsg: UINT; WParam: WPARAM;
      LParam: LPARAM): LRESULT;
    function GetEditValue: TcxEditValue;
    function GetOnChange: TNotifyEvent;
    procedure LockBounds(ALock: Boolean);
    procedure SafelySetFocus;
    procedure SetEditValue(const Value: TcxEditValue);
    procedure SetParent(Value: TWinControl);
    procedure SetOnChange(Value: TNotifyEvent);

    // IcxInnerTextEdit
    procedure ClearSelection;
    procedure CopyToClipboard;
    function GetAlignment: TAlignment;
    function GetAutoSelect: Boolean;
    function GetCharCase: TEditCharCase;
    function GetEchoMode: TcxEditEchoMode;
    function GetHideSelection: Boolean;
    function GetImeLastChar: Char;
    function GetImeMode: TImeMode;
    function GetImeName: TImeName;
    function GetInternalUpdating: Boolean;
    function GetMaxLength: Integer;
    function GetMultiLine: Boolean;
    function GetOEMConvert: Boolean;
    function GetOnSelChange: TNotifyEvent;
    function GetPasswordChar: TCaptionChar;
    function GetReadOnly: Boolean;
    function GetSelLength: Integer;
    function GetSelStart: Integer;
    function GetSelText: string;
    procedure SelectAll;
    procedure SetAlignment(Value: TAlignment);
    procedure SetAutoSelect(Value: Boolean);
    procedure SetCharCase(Value: TEditCharCase);
    procedure SetEchoMode(Value: TcxEditEchoMode);
    procedure SetHideSelection(Value: Boolean);
    procedure SetInternalUpdating(Value: Boolean);
    procedure SetImeMode(Value: TImeMode);
    procedure SetImeName(const Value: TImeName);
    procedure SetMaxLength(Value: Integer);
    procedure SetOEMConvert(Value: Boolean);
    procedure SetOnSelChange(Value: TNotifyEvent);
    procedure SetPasswordChar(Value: TCaptionChar);
    procedure SetReadOnly(Value: Boolean);
    procedure SetSelLength(Value: Integer);
    procedure SetSelStart(Value: Integer);
    procedure SetSelText(Value: string);

    // IcxInnerMemo
    function GetCaretPos: TPoint;
    function GetLines: TStrings;
    function GetScrollBars: TScrollStyle;
    function GetWantReturns: Boolean;
    function GetWantTabs: Boolean;
    function GetWordWrap: Boolean;
    procedure SetCaretPos(const Value: TPoint);
    procedure SetScrollBars(Value: TScrollStyle);
    procedure SetWantReturns(Value: Boolean);
    procedure SetWantTabs(Value: Boolean);
    procedure SetWordWrap(Value: Boolean);
  end;

  { TcxRichEditStrings }

  TcxRichEditStreamOperation = (esoLoadFrom, esoSaveTo);

  TcxRichEditStreamOperationInfo = record
    EditStream: TEditStream;
    StreamInfo: TRichEditStreamInfo;
    TextType: Longint;
  end;

  TcxRichEditStrings = class(TStrings)
  private
    FConverter: TConversion;
    FRichEdit: TcxRichInnerEdit;
    FTextType: Longint;
  protected
    function Get(Index: Integer): string; override;
    procedure InitConverter(const AFileName: string); virtual;
    procedure InitStreamOperation(AStream: TStream;
      var AStreamOperationInfo: TcxRichEditStreamOperationInfo;
      AStreamOperation: TcxRichEditStreamOperation);
    function GetCount: Integer; override;
    procedure Put(Index: Integer; const S: string); override;
    procedure SetUpdateState(Updating: Boolean); override;
    procedure SetTextStr(const Value: string); override;
    function GetLineBreakString: string; virtual;
    property RichEdit: TcxRichInnerEdit read FRichEdit;
  public
    constructor Create(ARichEdit: TcxRichInnerEdit); virtual;
    destructor Destroy; override;
    procedure Clear; override;
    procedure AddStrings(Strings: TStrings); override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure LoadFromFile(const FileName: string); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToFile(const FileName: string); override;
    procedure SaveToStream(Stream: TStream); override;
  end;

  { TcxRichInnerEdit }

  TcxRichInnerEdit = class(TRichEdit, IUnknown,
    IcxContainerInnerControl, IcxInnerEditHelper)
  private
    FAutoSelect: Boolean;
    FEchoMode: TcxEditEchoMode;
    FEscapePressed: Boolean;
    FHelper: TcxRichInnerEditHelper;
    FInternalUpdating: Boolean;
    FIsEraseBackgroundLocked: Boolean;
    FKeyPressProcessed: Boolean;
    FLockBoundsCount: Integer;
    FMemoMode: Boolean;
    FRichVersion: Integer;
    FSelectionBar: Boolean;
    FSavedPlainText: Boolean;
    FRichLines: TcxRichEditStrings;
    FUseCRLF: Boolean;

    // IcxContainerInnerControl
    function GetControl: TWinControl;
    function GetControlContainer: TcxContainer;

    // IcxInnerEditHelper
    function GetHelper: IcxCustomInnerEdit;

    function GetContainer: TcxCustomRichEdit;

    function GetLineCount: Integer;
    function GetLineIndex(AIndex: Integer): Integer;
    function GetLineLength(AIndex: Integer): Integer;

    function GetRichLines: TcxRichEditStrings;
    procedure InternalSetMemoMode;
    procedure SetMemoMode(Value: Boolean);
    procedure SetRichLines(
      Value: TcxRichEditStrings);
    procedure SetSelectionBar(Value: Boolean);
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMClear(var Message: TMessage); message WM_CLEAR;
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMMButtonDown(var Message: TWMMButtonDown); message WM_MBUTTONDOWN;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSetFont(var Message: TWMSetFont); message WM_SETFONT;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure WMWindowPosChanging(var Message: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
    procedure EMReplaceSel(var Message: TMessage); message EM_REPLACESEL;
    procedure EMSetCharFormat(var Message: TMessage); message EM_SETCHARFORMAT;
    procedure EMSetParaFormat(var Message: TMessage); message EM_SETPARAFORMAT;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure WMGetText(var Message: TMessage); message WM_GETTEXT;
    procedure WMGetTextLength(var Message: TWMGetTextLength); message WM_GETTEXTLENGTH;
    procedure WMSetText(var Message: TWMSetText); message WM_SETTEXT;
    procedure WMIMEComposition(var Message: TMessage); message WM_IME_COMPOSITION;
    procedure EMExLineFromChar(var Message: TMessage); message EM_EXLINEFROMCHAR;
    procedure EMLineLength(var Message: TMessage); message EM_LINELENGTH;
  protected
    procedure Click; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DblClick; override;
    procedure DestroyWnd; override;
    procedure DoEnter; override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseLeave(AControl: TControl); dynamic;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure RequestAlign; override;
    procedure RequestSize(const Rect: TRect); override;
    procedure RichCreateParams(var Params: TCreateParams;
      out ARichVersion: Integer); virtual;
    procedure SelectionChange; override;
    procedure WndProc(var Message: TMessage); override;
    function CanPaste: Boolean;
    function GetSelection: TCharRange; virtual;
    property AutoSelect: Boolean read FAutoSelect write FAutoSelect default False;
    property Container: TcxCustomRichEdit read GetContainer;
    property Helper: TcxRichInnerEditHelper read FHelper;
    property MemoMode: Boolean read FMemoMode write SetMemoMode default False;
    property RichVersion: Integer read FRichVersion write FRichVersion;
    property SelectionBar: Boolean read FSelectionBar write SetSelectionBar
      default False;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DefaultHandler(var Message); override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function FindTexT(const ASearchStr: string;
      AStartPos, ALength: Longint; AOptions: TSearchTypes): Integer;
    procedure Print(const Caption: string); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function CanFocus: Boolean; override;
    function CanRedo: Boolean; virtual;
    procedure Redo; virtual;
    procedure Undo; virtual;
    property RichLines: TcxRichEditStrings
      read GetRichLines write SetRichLines;
  end;

function AdjustRichLineBreaks(ADest, ASource: PChar; AShortBreak: Boolean = False): Integer;
procedure SetRichEditText(ARichEdit: TRichEdit;
  const AEditValue: TcxEditValue);

implementation

uses
  CommDlg, Printers, cxEditPaintUtils, cxEditUtils, cxExtEditConsts, cxVariants;

type
  TcxRichEditNames = array of string;
  TStringsAccess = class(TStrings);

const
  RTFConversionFormat: TConversionFormat = (
    ConversionClass: TConversion;
    Extension: 'rtf';
    Next: nil
  );
  TextConversionFormat: TConversionFormat = (
    ConversionClass: TConversion;
    Extension: 'txt';
    Next: @RTFConversionFormat
  );
  cxRichReadError = $0001;
  cxRichWriteError = $0002;
  cxRichNoError = $0000;

const
  cxRichEditVersions: array[0..4] of Integer =
    (100, 200, 300, 410, 500);

var
  FRichEditLibrary: HMODULE = 0;
  FRichRenderer, FRichConverter: TcxRichInnerEdit;
  FConversionFormatList: PConversionFormat = @TextConversionFormat;

  FRichEditDLLNames: TcxRichEditNames;
  FRichEditClassNames: TcxRichEditNames;

function cxSendStructMessageEx(AHandle: THandle; AMsg: UINT; const AStructure; AParam: Integer; AStructureIsLParam: Boolean): LRESULT; overload;
begin
  if AStructureIsLParam then
    Result := SendMessage(AHandle, AMsg, AParam, Integer(@AStructure))
  else
    Result := SendMessage(AHandle, AMsg, Integer(@AStructure), AParam);
end;

function cxSendStructMessage(AHandle: THandle; AMsg: UINT; WParam: WPARAM; const LParam): LRESULT; overload;
begin
  Result := cxSendStructMessageEx(AHandle, AMsg, LParam, WParam, True);
end;

function cxSendStructMessage(AHandle: THandle; AMsg: UINT; const WParam; LParam: LParam): LRESULT; overload;
begin
  Result := cxSendStructMessageEx(AHandle, AMsg, WParam, LParam, False);
end;

function cxRichEditDLLNames: TcxRichEditNames;

  procedure InitRichEditDLLNames;
  const
    cxRichEditDLLNamesCount = 3;
  begin
    SetLength(FRichEditDLLNames, cxRichEditDLLNamesCount);
    FRichEditDLLNames[0] :=  'Riched32.dll';
    FRichEditDLLNames[1] :=  'Riched20.dll';
    FRichEditDLLNames[2] :=  'Msftedit.dll';
  end;

begin
  if Length(FRichEditDLLNames) = 0 then
    InitRichEditDLLNames;
  Result := FRichEditDLLNames;
end;

function cxRichEditClassNames: TcxRichEditNames;

  procedure InitRichEditClassNames;
  const
    cxRichEditClassNamesCount = 5;
  begin
    SetLength(FRichEditClassNames, cxRichEditClassNamesCount);
    FRichEditClassNames[0] := 'RICHEDIT';
    FRichEditClassNames[1] := 'RICHEDIT20';
    FRichEditClassNames[2] := 'RICHEDIT30';
    FRichEditClassNames[3] := 'RICHEDIT41';
    FRichEditClassNames[4] := 'RICHEDIT50';
  end;

begin
  if Length(FRichEditClassNames) = 0 then
    InitRichEditClassNames;
  Result := FRichEditClassNames;
end;

function AdjustRichLineBreaks(ADest, ASource: PChar; AShortBreak: Boolean = False): Integer;
var
  APrevDest: PChar;
begin
  APrevDest := ADest;
  repeat
    if ASource^ in [#13, #10] then
    begin
      if AShortBreak then
        ADest^ := #13
      else
      begin
        PWord(ADest)^ := $0A0D;
        Inc(ADest);
      end;
      if PWord(ASource)^ = $0A0D then
        Inc(ASource);
    end
    else
      ADest^ := ASource^;
    Inc(ASource);
    Inc(ADest);
  until ASource^ = Char(0);
  ADest^ := #0;
  Result := ADest - APrevDest;
end;

function cxRichEditStreamLoad(dwCookie: Longint; pbBuff: PByte;
  cb: Longint; var pcb: Longint): Longint; stdcall;
var
  ABuffer, P: PChar;
  AStreamInfo: PRichEditStreamInfo;
begin
  Result := cxRichNoError;
  AStreamInfo := PRichEditStreamInfo(Pointer(dwCookie));
  ABuffer := StrAlloc(cb + 1);
  try
    cb := cb div 2;
    pcb := 0;
    P := ABuffer + cb;
    try
      if AStreamInfo^.Converter <> nil then
        pcb := AStreamInfo^.Converter.ConvertReadStream(AStreamInfo^.Stream, P,
          cb);
      if pcb > 0 then
      begin
        P[pcb] := #0;
        if P[pcb - 1] = #13 then
          P[pcb - 1] := #0;
        pcb := AdjustRichLineBreaks(ABuffer, P);
        Move(ABuffer^, pbBuff^, pcb);
      end;
    except
      Result := cxRichReadError;
    end;
  finally
    StrDispose(ABuffer);
  end;
end;

function cxRichEditStreamSave(dwCookie: Longint; pbBuff: PByte; cb: Longint;
  var pcb: Longint): Longint; stdcall;
var
  AStreamInfo: PRichEditStreamInfo;
begin
  Result := cxRichNoError;
  AStreamInfo := PRichEditStreamInfo(Pointer(dwCookie));
  try
    pcb := 0;
    if AStreamInfo^.Converter <> nil then
      pcb := AStreamInfo^.Converter.ConvertWriteStream(AStreamInfo^.Stream,
        PChar(pbBuff), cb);
  except
    Result := cxRichWriteError;
  end;
end;

function IsRichText(const AText: string): Boolean;
const
  ARichPrefix = '{\rtf';
begin
  Result := Copy(AText, 1, Length(ARichPrefix)) = ARichPrefix;
end;

procedure LoadRichFromString(ALines: TStrings; const S: string);

  procedure PrepareStream(
    AStream: TStringStream);
  begin
  end;

var
  AStream: TStringStream;
begin

  AStream := TStringStream.Create(S);
  try
    PrepareStream(AStream);
    ALines.LoadFromStream(AStream
);
  finally
    AStream.Free;
  end;
end;

procedure ReleaseConversionFormatList;
var
  AConversionFormatList: PConversionFormat;
begin
  while FConversionFormatList <> @TextConversionFormat do
  begin
    AConversionFormatList := FConversionFormatList^.Next;
    Dispose(FConversionFormatList);
    FConversionFormatList := AConversionFormatList;
  end;
end;

function CreateInnerRich: TcxRichInnerEdit;
begin
  Result := nil;
  if Application.Handle <> 0 then
  begin
    Result := TcxRichInnerEdit.Create(nil);
    Result.ParentWindow := Application.Handle;
    SendMessage(Result.Handle, EM_SETEVENTMASK, 0, 0);
  end;
end;

function RichRenderer: TcxRichInnerEdit;
begin
  if FRichRenderer = nil then
    FRichRenderer := CreateInnerRich;
  Result := FRichRenderer;
end;

function RichConverter: TcxRichInnerEdit;
begin
  if FRichConverter = nil then
    FRichConverter := CreateInnerRich;
  Result := FRichConverter;
end;

procedure InternalSetRichEditText(ARichEdit: TRichEdit; const AText: string);
begin
  if not ARichEdit.PlainText then
    LoadRichFromString(ARichEdit.Lines, AText)
  else
    ARichEdit.Perform(WM_SETTEXT, 0, Longint(PChar(AText)));
end;

function ConvertRichText(const AText: string): string;
begin
  InternalSetRichEditText(RichConverter, AText);
  Result := RichConverter.Text;
end;

procedure SetRichDefAttributes(AEdit: TRichEdit; AFont: TFont; ATextColor: TColor);
begin
  if not AEdit.HandleAllocated then
    Exit;

  AEdit.DefAttributes.Assign(AFont);
  AEdit.DefAttributes.Color := ATextColor;
end;

procedure InitRichRenderer(AProperties: TcxCustomRichEditProperties;
  AFont: TFont; AColor, ATextColor: TColor; const AText: string);
begin
  RichRenderer.MemoMode := TcxCustomRichEditProperties(AProperties).MemoMode;
  RichRenderer.PlainText := TcxCustomRichEditProperties(AProperties).PlainText;
  RichRenderer.Alignment := TcxCustomRichEditProperties(AProperties).Alignment;
  RichRenderer.HandleNeeded;

  if not RichRenderer.MemoMode then
    LoadRichFromString(RichRenderer.RichLines, AText)
  else
    RichRenderer.Text := AText;

  if not IsRichText(AText) or RichRenderer.MemoMode or RichRenderer.PlainText then
    SetRichDefAttributes(RichRenderer, AFont, ATextColor);
  SendMessage(RichRenderer.Handle, EM_SETBKGNDCOLOR, 0, ColorToRGB(AColor));
end;

procedure DrawRichEdit(ADC: HDC; const ARect: TRect; const AText: string;
  AProperties: TcxCustomRichEditProperties; AFont: TFont;
  AColor, ATextColor: TColor; ACalculateHeight: Boolean; out AHeight: Integer);
const
  TwipsPerInch = 1440;
var
  AFormatRange: TFormatRange;
  AStartIndex: Integer;
begin
  if not ACalculateHeight then
    FillRect(ADC, Rect(0, 0, ARect.Right - ARect.Left,
      ARect.Bottom - ARect.Top), GetSolidBrush(AColor));
  InitRichRenderer(AProperties, AFont, AColor, ATextColor, AText);
  SendMessage(RichRenderer.Handle, EM_FORMATRANGE, 0, 0);

  if ACalculateHeight then
    AHeight := 0;
  AFormatRange.hdc := ADC;
  AFormatRange.hdcTarget := ADC;
  AFormatRange.chrg.cpMin := 0;
  AFormatRange.chrg.cpMax := -1;
  repeat
    AFormatRange.rc := cxEmptyRect;
    AFormatRange.rc.Right := (ARect.Right - ARect.Left) * TwipsPerInch div GetDeviceCaps(ADC, LOGPIXELSX);
    if ACalculateHeight then
      AFormatRange.rc.Bottom := TwipsPerInch
    else
      AFormatRange.rc.Bottom := (ARect.Bottom - ARect.Top)(*65535*) * TwipsPerInch div GetDeviceCaps(ADC, LOGPIXELSY);
    AFormatRange.rcPage := AFormatRange.rc;
    AStartIndex := AFormatRange.chrg.cpMin;
    AFormatRange.chrg.cpMin := cxSendStructMessage(RichRenderer.Handle, EM_FORMATRANGE,
      WPARAM(not ACalculateHeight), AFormatRange);
    if AFormatRange.chrg.cpMin <= AStartIndex then
      Break;
    if ACalculateHeight then
      Inc(AHeight, AFormatRange.rc.Bottom - AFormatRange.rc.Top);
  until not ACalculateHeight;
  if ACalculateHeight then
    AHeight := AHeight * GetDeviceCaps(ADC, LOGPIXELSY) div TwipsPerInch;

  SendMessage(RichRenderer.Handle, EM_FORMATRANGE, 0, 0);
end;

procedure SetRichEditText(ARichEdit: TRichEdit; const AEditValue: TcxEditValue);
begin
  InternalSetRichEditText(ARichEdit, VarToStr(AEditValue));
end;

{ TcxRichEdit }

class function TcxRichEdit.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxRichEditProperties;
end;

function TcxRichEdit.GetActiveProperties: TcxRichEditProperties;
begin
  Result := TcxRichEditProperties(InternalGetActiveProperties);
end;

function TcxRichEdit.GetProperties: TcxRichEditProperties;
begin
  Result := TcxRichEditProperties(FProperties);
end;

procedure TcxRichEdit.SetProperties(Value: TcxRichEditProperties);
begin
  FProperties.Assign(Value);
end;

{ TcxRichInnerEditHelper }

constructor TcxRichInnerEditHelper.Create(AEdit: TcxRichInnerEdit);
begin
  inherited Create(nil);
  FEdit := AEdit;
  FEdit.PlainText := False;
  FEdit.WordWrap := False;
end;

function TcxRichInnerEditHelper.GetControl: TWinControl;
begin
  Result := Edit;
end;

procedure TcxRichInnerEditHelper.LockBounds(ALock: Boolean);
begin
  with Edit do
    if ALock then
      Inc(FLockBoundsCount)
    else
      if FLockBoundsCount > 0 then
        Dec(FLockBoundsCount);
end;

function TcxRichInnerEditHelper.GetOnChange: TNotifyEvent;
begin
  Result := Edit.OnChange;
end;

procedure TcxRichInnerEditHelper.SafelySetFocus;
var
  APrevAutoSelect: Boolean;
begin
  with Edit do
  begin
    APrevAutoSelect := AutoSelect;
    AutoSelect := False;
    SetFocus;
    AutoSelect := APrevAutoSelect;
  end;
end;

function TcxRichInnerEditHelper.CallDefWndProc(AMsg: UINT; WParam: WPARAM;
  LParam: LPARAM): LRESULT;
begin
  Result := CallWindowProc(Edit.DefWndProc, Edit.Handle, AMsg, WParam, LParam);
end;

function TcxRichInnerEditHelper.GetEditValue: TcxEditValue;
begin
  with Edit do
    Result := Text;
end;

procedure TcxRichInnerEditHelper.SetEditValue(const Value: TcxEditValue);
var
  AContainer: TcxCustomRichEdit;
begin
  AContainer := Edit.Container;
  if AContainer.PropertiesChange then
    Exit;

  if AContainer.ActiveProperties.MemoMode or not CanAllocateHandle(Edit) then
    Edit.Text := VarToStr(Value)
  else
  begin
    Edit.Container.LockChangeEvents(True);
    try
      Edit.HandleNeeded;
      LoadRichFromString(Edit.RichLines, VarToStr(Value));
    finally
      Edit.Container.LockChangeEvents(False);
    end;
  end;
end;

procedure TcxRichInnerEditHelper.SetParent(Value: TWinControl);
begin
  Edit.Parent := Value;
end;

procedure TcxRichInnerEditHelper.SetOnChange(Value: TNotifyEvent);
begin
  Edit.OnChange := Value;
end;

// IcxInnerTextEdit 
procedure TcxRichInnerEditHelper.ClearSelection;
begin
  Edit.ClearSelection;
end;

procedure TcxRichInnerEditHelper.CopyToClipboard;
begin
  Edit.CopyToClipboard;
end;

function TcxRichInnerEditHelper.GetAlignment: TAlignment;
begin
  Result := Edit.Alignment;
end;

function TcxRichInnerEditHelper.GetAutoSelect: Boolean;
begin
  Result := Edit.AutoSelect;
end;

function TcxRichInnerEditHelper.GetCharCase: TEditCharCase;
begin
  Result := Edit.CharCase;
end;

function TcxRichInnerEditHelper.GetEchoMode: TcxEditEchoMode;
begin
  Result := eemNormal;
end;

function TcxRichInnerEditHelper.GetHideSelection: Boolean;
begin
  Result := Edit.HideSelection;
end;

function TcxRichInnerEditHelper.GetInternalUpdating: Boolean;
begin
  Result := Edit.FInternalUpdating;
end;

function TcxRichInnerEditHelper.GetMaxLength: Integer;
begin
  Result := Edit.MaxLength;
end;

function TcxRichInnerEditHelper.GetMultiLine: Boolean;
begin
  Result := True;
end;

function TcxRichInnerEditHelper.GetOEMConvert: Boolean;
begin
  Result := Edit.OEMConvert;
end;

function TcxRichInnerEditHelper.GetOnSelChange: TNotifyEvent;
begin
  Result := Edit.OnSelectionChange;
end;

function TcxRichInnerEditHelper.GetPasswordChar: TCaptionChar;
begin
  Result := #0;
end;

function TcxRichInnerEditHelper.GetReadOnly: Boolean;
begin
  Result := Edit.ReadOnly;
end;

function TcxRichInnerEditHelper.GetSelLength: Integer;
begin
  Result := Edit.SelLength;
end;

function TcxRichInnerEditHelper.GetSelStart: Integer;
begin
  Result := Edit.SelStart;
end;

function TcxRichInnerEditHelper.GetSelText: string;
begin
  Result := Edit.SelText;
end;

procedure TcxRichInnerEditHelper.SelectAll;
begin
  if not Edit.Container.IsInplace then
    Edit.SelectAll;
end;

procedure TcxRichInnerEditHelper.SetAlignment(Value: TAlignment);
begin
  Edit.Alignment := Value;
end;

procedure TcxRichInnerEditHelper.SetAutoSelect(Value: Boolean);
begin
  Edit.AutoSelect := Value;
end;

procedure TcxRichInnerEditHelper.SetCharCase(Value: TEditCharCase);
begin
  Edit.CharCase := Value;
end;

procedure TcxRichInnerEditHelper.SetEchoMode(Value: TcxEditEchoMode);
begin
end;

procedure TcxRichInnerEditHelper.SetHideSelection(Value: Boolean);
begin
  if not Edit.Container.IsInplace then
    Edit.HideSelection := Value;
end;

procedure TcxRichInnerEditHelper.SetInternalUpdating(Value: Boolean);
begin
  Edit.FInternalUpdating := Value;
end;

procedure TcxRichInnerEditHelper.SetImeMode(Value: TImeMode);
begin
  Edit.ImeMode := Value;
end;

procedure TcxRichInnerEditHelper.SetImeName(const Value: TImeName);
begin
  Edit.ImeName := Value;
end;

procedure TcxRichInnerEditHelper.SetMaxLength(Value: Integer);
begin
  Edit.MaxLength := Value;
end;

procedure TcxRichInnerEditHelper.SetOEMConvert(Value: Boolean);
begin
  Edit.OEMConvert := Value;
end;

procedure TcxRichInnerEditHelper.SetOnSelChange(Value: TNotifyEvent);
begin
  Edit.OnSelectionChange := Value;
end;

procedure TcxRichInnerEditHelper.SetPasswordChar(Value: TCaptionChar);
begin
end;

procedure TcxRichInnerEditHelper.SetReadOnly(Value: Boolean);
begin
  Edit.ReadOnly := Value;
end;

procedure TcxRichInnerEditHelper.SetSelLength(Value: Integer);
begin
  Edit.SelLength := Value;
end;

procedure TcxRichInnerEditHelper.SetSelStart(Value: Integer);
begin
  with Edit do
    SelStart := Value;
end;

procedure TcxRichInnerEditHelper.SetSelText(Value: string);
begin
  Edit.SelText := Value;
end;

function TcxRichInnerEditHelper.GetImeLastChar: Char;
begin
  Result := #0;
end;

function TcxRichInnerEditHelper.GetImeMode: TImeMode;
begin
  Result := Edit.ImeMode;
end;

function TcxRichInnerEditHelper.GetImeName: TImeName;
begin
  Result := Edit.ImeName;
end;

function TcxRichInnerEditHelper.GetControlContainer: TcxContainer;
begin
  Result := Edit.Container;
end;

// IcxInnerMemo
function TcxRichInnerEditHelper.GetCaretPos: TPoint;
begin
  Result := Edit.CaretPos;
end;

function TcxRichInnerEditHelper.GetLines: TStrings;
begin
  Result := Edit.Lines;
end;

function TcxRichInnerEditHelper.GetScrollBars: TScrollStyle;
begin
  Result := Edit.ScrollBars;
end;

function TcxRichInnerEditHelper.GetWantReturns: Boolean;
begin
  Result := Edit.WantReturns;
end;

function TcxRichInnerEditHelper.GetWantTabs: Boolean;
begin
  Result := Edit.WantTabs;
end;

function TcxRichInnerEditHelper.GetWordWrap: Boolean;
begin
  Result := Edit.WordWrap;
end;

procedure TcxRichInnerEditHelper.SetCaretPos(const Value: TPoint);
begin
  SetMemoCaretPos(Edit, Value);
end;

procedure TcxRichInnerEditHelper.SetScrollBars(Value: TScrollStyle);
begin
  Edit.ScrollBars := Value;
end;

procedure TcxRichInnerEditHelper.SetWantReturns(Value: Boolean);
begin
  Edit.WantReturns := Value;
end;

procedure TcxRichInnerEditHelper.SetWantTabs(Value: Boolean);
begin
  Edit.WantTabs := Value;
end;

procedure TcxRichInnerEditHelper.SetWordWrap(Value: Boolean);
begin
  Edit.WordWrap := Value;
end;

{ TcxRichEditStrings }

constructor TcxRichEditStrings.Create(ARichEdit: TcxRichInnerEdit);
begin
  inherited Create;
  FRichEdit := ARichEdit;
  FTextType := SF_TEXT;
end;

destructor TcxRichEditStrings.Destroy;
begin
  FreeAndNil(FConverter);
  inherited Destroy;
end;

procedure TcxRichEditStrings.Clear;
begin
  if Count > 0 then
    RichEdit.Lines.Clear;
end;

procedure TcxRichEditStrings.AddStrings(Strings: TStrings);
var
  APrevSelectionChange: TNotifyEvent;
begin
  APrevSelectionChange := RichEdit.OnSelectionChange;
  RichEdit.OnSelectionChange := nil;
  try
    inherited AddStrings(Strings);
  finally
    RichEdit.OnSelectionChange := APrevSelectionChange;
  end;
end;

procedure TcxRichEditStrings.Delete(Index: Integer);
begin
  FRichEdit.Lines.Delete(Index);
end;

procedure TcxRichEditStrings.Insert(Index: Integer; const S: string);
var
  AFormat: string;
  AStr: PChar;
  ASelection: TCharRange;
begin
  if (Index < 0) or (Index > Count) then
    Exit;

  ASelection.cpMin := FRichEdit.GetLineIndex(Index);
  if ASelection.cpMin < 0 then
  begin
    ASelection.cpMin := FRichEdit.GetLineIndex(Index - 1);
    if ASelection.cpMin < 0 then
      ASelection.cpMin := 0
    else
      ASelection.cpMin := ASelection.cpMin + FRichEdit.GetLineLength(Index - 1);
    AFormat := GetLineBreakString + '%s';
  end
  else
    AFormat := '%s'+ GetLineBreakString;

  ASelection.cpMax := ASelection.cpMin;
  AStr := PChar(Format(AFormat, [S]));
  cxSendStructMessage(FRichEdit.Handle, EM_EXSETSEL, 0, ASelection);
  AdjustRichLineBreaks(AStr, PChar(Format(AFormat, [S])), Length(GetLineBreakString) = 1);
  SendMessage(FRichEdit.Handle, EM_REPLACESEL, 0, LongInt(AStr));

  if FRichEdit.SelStart <> (ASelection.cpMax + Length(AStr)) then
    raise EOutOfResources.Create(
      cxGetResourceString(@cxSEditRichEditLineInsertionError));
end;

procedure TcxRichEditStrings.LoadFromFile(const FileName: string);
begin
  InitConverter(FileName);
  inherited LoadFromFile(FileName);
  FRichEdit.Container.EditModified := False
end;

procedure TcxRichEditStrings.LoadFromStream(Stream: TStream);
var
  APos: Longint;
  AStreamOperationInfo: TcxRichEditStreamOperationInfo;
begin
  APos := Stream.Position;
  try
    InitStreamOperation(Stream, AStreamOperationInfo, esoLoadFrom);
    with AStreamOperationInfo do
    begin
      SendMessage(RichEdit.Handle, EM_STREAMIN, TextType, Longint(@EditStream));
      if (TextType = SF_RTF) and (EditStream.dwError <> 0) then
      begin
        Stream.Position := APos;
        TextType := SF_TEXT;
        cxSendStructMessage(RichEdit.Handle, EM_STREAMIN, TextType, EditStream);
      end;
      if EditStream.dwError <> 0 then
        raise EOutOfResources.Create(cxGetResourceString(@cxSEditRichEditLoadFail));
      FTextType := TextType;
    end;
  finally
    if FConverter = nil then
      FreeAndNil(AStreamOperationInfo.StreamInfo.Converter);
  end;

  with FRichEdit do
    if Container <> nil then
      Container.EditModified := False
end;

procedure TcxRichEditStrings.SaveToFile(const FileName: string);
begin
  InitConverter(FileName);
  inherited SaveToFile(FileName);
end;

procedure TcxRichEditStrings.SaveToStream(Stream: TStream);
var
  AStreamOperationInfo: TcxRichEditStreamOperationInfo;
begin
  try
    InitStreamOperation(Stream, AStreamOperationInfo, esoSaveTo);
    with AStreamOperationInfo do
    begin
      cxSendStructMessage(RichEdit.Handle, EM_STREAMOUT, TextType, EditStream);
      if EditStream.dwError <> 0 then
        raise EOutOfResources.Create(cxGetResourceString(@cxSEditRichEditSaveFail));
    end;
  finally
    if FConverter = nil then
      FreeAndNil(AStreamOperationInfo.StreamInfo.Converter);
  end;
end;

function TcxRichEditStrings.Get(Index: Integer): string;
begin
  Result := FRichEdit.Lines[Index];
  while (Length(Result) > 0) and (Result[Length(Result)] in [#10, #13]) do
    System.Delete(Result, Length(Result), 1);
end;

procedure TcxRichEditStrings.InitConverter(const AFileName: string);
var
  AExtension: string;
  AConversionFormat: PConversionFormat;
begin
  AExtension := AnsiLowerCaseFileName(ExtractFileExt(AFilename));
  System.Delete(AExtension, 1, 1);
  AConversionFormat := FConversionFormatList;
  while AConversionFormat <> nil do
    with AConversionFormat^ do
      if Extension <> AExtension then AConversionFormat := Next
      else Break;
  if AConversionFormat = nil then
    AConversionFormat := @TextConversionFormat;
  if (FConverter = nil) or
    (FConverter.ClassType <> AConversionFormat^.ConversionClass) then
  begin
    FreeAndNil(FConverter);
    FConverter := AConversionFormat^.ConversionClass.Create;
  end;
end;

procedure TcxRichEditStrings.InitStreamOperation(AStream: TStream;
  var AStreamOperationInfo: TcxRichEditStreamOperationInfo;
  AStreamOperation: TcxRichEditStreamOperation);
var
  AConverter: TConversion;
begin
  if FConverter <> nil then
    AConverter := FConverter
  else
    AConverter := RichEdit.DefaultConverter.Create;
  with AStreamOperationInfo do
  begin
    StreamInfo.Converter := AConverter;
    StreamInfo.Stream := AStream;
    EditStream.dwCookie := Longint(Pointer(@StreamInfo));
    if AStreamOperation = esoLoadFrom then
      EditStream.pfnCallBack := @cxRichEditStreamLoad
    else
      EditStream.pfnCallBack := @cxRichEditStreamSave;
    EditStream.dwError := 0;
    if RichEdit.MemoMode or RichEdit.PlainText then
      TextType := SF_TEXT
    else
      TextType := SF_RTF;
  end;
end;

function TcxRichEditStrings.GetCount: Integer;
begin
  Result := RichEdit.GetLineCount;
  if (Result > 0) and (RichEdit.GetLineLength(Result - 1) = 0) then
    Dec(Result);
end;

procedure TcxRichEditStrings.Put(Index: Integer; const S: string);
begin
  TStringsAccess(FRichEdit.Lines).Put(Index, S);
end;

procedure TcxRichEditStrings.SetUpdateState(Updating: Boolean);
begin
  TStringsAccess(FRichEdit.Lines).SetUpdateState(Updating);
end;

procedure TcxRichEditStrings.SetTextStr(const Value: string);
begin
  FRichEdit.Container.Text := Value;
end;

function TcxRichEditStrings.GetLineBreakString: string;
begin
  if FRichEdit.RichVersion >= 200 then
    Result := #13
  else
    Result := #13#10
end;

{ TcxRichInnerEdit }

constructor TcxRichInnerEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ParentColor := True;
  ParentFont := True;
  FEchoMode := eemNormal;
  FHelper := TcxRichInnerEditHelper.Create(Self);
  FInternalUpdating := False;
  FRichLines := TcxRichEditStrings.Create(Self);
  FUseCRLF := True;
end;

destructor TcxRichInnerEdit.Destroy;
begin
  FreeAndNil(FRichLines);
  FreeAndNil(FHelper);
  inherited Destroy;
end;

procedure TcxRichInnerEdit.DefaultHandler(var Message);
begin
  if (Container = nil) or
    not Container.InnerControlDefaultHandler(TMessage(Message)) then
      inherited DefaultHandler(Message);
end;

procedure TcxRichInnerEdit.DragDrop(Source: TObject; X, Y: Integer);
begin
  Container.DragDrop(Source, Left + X, Top + Y);
end;

function TcxRichInnerEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (Container <> nil) and
    Container.DataBinding.ExecuteAction(Action);
end;

function TcxRichInnerEdit.FindText(const ASearchStr: string;
  AStartPos, ALength: Longint; AOptions: TSearchTypes): Integer;
var
  AFindText: TFindText;
  AFlags: Integer;
begin
  with AFindText.chrg do
  begin
    cpMin := AStartPos;
    cpMax := cpMin + ALength;
  end;
  AFlags := FR_DOWN;
  if stWholeWord in AOptions then AFlags := AFlags or FT_WHOLEWORD;
  if stMatchCase in AOptions then AFlags := AFlags or FT_MATCHCASE;
  AFindText.lpstrText := PChar(ASearchStr);
  Result := cxSendStructMessage(Handle, EM_FINDTEXT, AFlags, AFindText);
end;

procedure TcxRichInnerEdit.Print(const Caption: string);
var
  AIsCRLFUsed: Boolean;
begin
  AIsCRLFUsed := FUseCRLF;
  FUseCRLF := False;
  try
    inherited;
  finally
    FUseCRLF := AIsCRLFUsed;
  end;
end;

procedure TcxRichInnerEdit.Click;
begin
  inherited Click;
  _TcxContainerAccess.Click(Container);
end;

procedure TcxRichInnerEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  RichCreateParams(Params, FRichVersion);
  with Params.WindowClass do
    style := style or CS_VREDRAW or CS_HREDRAW;
  if SelectionBar then
    Params.Style := Params.Style or ES_SELECTIONBAR;
end;

procedure TcxRichInnerEdit.CreateWnd;
begin
  if Container <> nil then
  begin
    Alignment := Container.ActiveProperties.Alignment;
    Container.ClearSavedChildControlRegions;
    PlainText := FSavedPlainText;
  end;
  inherited CreateWnd;
  if Container <> nil then
    PlainText := Container.ActiveProperties.PlainText or Container.ActiveProperties.MemoMode;
  SendMessage(Handle, EM_SETEVENTMASK, 0, ENM_CHANGE or ENM_SELCHANGE or
    ENM_REQUESTRESIZE or ENM_PROTECTED or ENM_KEYEVENTS);
  if MaxLength = 0 then
    SendMessage(Handle, EM_EXLIMITTEXT, 0, MaxLongint);
  InternalSetMemoMode;
end;

procedure TcxRichInnerEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if FLockBoundsCount = 0 then
    inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

function TcxRichInnerEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (Container <> nil) and
    Container.DataBinding.UpdateAction(Action);
end;

function TcxRichInnerEdit.CanFocus: Boolean;
begin
  if Container = nil then
    Result := inherited CanFocus
  else
    Result := Container.CanFocusEx;
end;

function TcxRichInnerEdit.CanRedo: Boolean;
begin
  Result := False;
  if HandleAllocated then
    Result := SendMessage(Handle, EM_CANREDO, 0, 0) <> 0;
end;

procedure TcxRichInnerEdit.Redo;
begin
  if HandleAllocated then
    SendMessage(Handle, EM_REDO, 0, 0);
end;

procedure TcxRichInnerEdit.Undo;
begin
  if HandleAllocated then
    SendMessage(Handle, EM_UNDO, 0, 0);
end;

procedure TcxRichInnerEdit.DblClick;
begin
  inherited DblClick;
  _TcxContainerAccess.DblClick(Container);
end;

procedure TcxRichInnerEdit.DestroyWnd;
begin
  FSavedPlainText := PlainText;
  inherited DestroyWnd;
end;

procedure TcxRichInnerEdit.DoEnter;
begin
  inherited DoEnter;
  if FAutoSelect then
    SelectAll;
end;

procedure TcxRichInnerEdit.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  _TcxContainerAccess.DragOver(Container, Source, Left + X, Top + Y, State, Accept);
end;

procedure TcxRichInnerEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FInternalUpdating := False;
  _TcxContainerAccess.KeyDown(Container, Key, Shift);
  if Key = 0 then
    FInternalUpdating := True
  else
    inherited KeyDown(Key, Shift);
  if (RichVersion >= 200) and (Key = VK_RETURN) and not WantReturns and
    not(ssCtrl in InternalGetShiftState) then
  begin
    Key := 0;
    Exit;
  end;
end;

procedure TcxRichInnerEdit.KeyPress(var Key: Char);
begin
  FInternalUpdating := False;
// Ctrl+I calls KeyPress with Key = Char(VK_TAB). A tab must be inserted even when WantTabs = False
//  if not WantTabs and (Key = Char(VK_TAB)) then
//    Key := #0;
  _TcxContainerAccess.KeyPress(Container, Key);
  if Key = #0 then
    FInternalUpdating := True
  else
    inherited KeyPress(Key);
end;

procedure TcxRichInnerEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  FInternalUpdating := False;
  if not WantTabs and ((Key = VK_TAB)) then
    Key := 0;
  _TcxContainerAccess.KeyUp(Container, Key, Shift);
  if Key = 0 then
    FInternalUpdating := True
  else
    inherited KeyUp(Key, Shift);
end;

procedure TcxRichInnerEdit.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  _TcxContainerAccess.MouseDown(Container, Button, Shift, X + Left, Y + Top);
end;

procedure TcxRichInnerEdit.MouseLeave(AControl: TControl);
begin
  Container.ShortRefreshContainer(True);
end;

procedure TcxRichInnerEdit.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  _TcxContainerAccess.MouseMove(Container, Shift, X + Left, Y + Top);
end;

procedure TcxRichInnerEdit.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  _TcxContainerAccess.MouseUp(Container, Button, Shift, X + Left, Y + Top);
end;

procedure TcxRichInnerEdit.RequestAlign;
begin
end;

procedure TcxRichInnerEdit.RequestSize(const Rect: TRect);
var
  R: TRect;
begin
  if Container <> nil then
  begin
    R := Rect;
    Dec(R.Left, Left);
    Dec(R.Top, Top);
    Inc(R.Right, Container.Width - Width - Left);
    Inc(R.Bottom, Container.Height - Height - Top);
    OffsetRect(R, Container.Left, Container.Top);
    Container.DoOnResizeRequest(R);
  end;
end;

procedure TcxRichInnerEdit.RichCreateParams(var Params: TCreateParams;
  out ARichVersion: Integer);
var
  ARichClassName: string;
  AWndClass: TWndClass;
  I: Integer;
begin
  if FRichEditLibrary = 0 then
    for I := High(cxRichEditDLLNames) downto Low(cxRichEditDLLNames) do
    begin
      FRichEditLibrary := LoadLibrary(PChar(cxRichEditDLLNames[I]));
      if FRichEditLibrary <> 0 then
        Break;
    end;
  if FRichEditLibrary = 0 then
    raise EcxEditError.Create(cxGetResourceString(@cxSEditRichEditLibraryError));

  for I := High(cxRichEditClassNames) downto Low(cxRichEditClassNames) do
  begin
//    ARichClassName := cxRichEditClassNames[I] + 'W';
//    if GetClassInfo(HInstance, PChar(ARichClassName), AWndClass) then
//      Break;
    ARichClassName := cxRichEditClassNames[I] + 'A';
    if GetClassInfo(HInstance, PChar(ARichClassName), AWndClass) then
      Break;
    ARichClassName := cxRichEditClassNames[I];
    if GetClassInfo(HInstance, PChar(ARichClassName), AWndClass) then
      Break;
  end;

  if GetClassInfo(HInstance, PChar(ARichClassName), AWndClass) then
    ARichVersion := cxRichEditVersions[I]
  else
    raise EcxEditError.Create(cxGetResourceString(@cxSEditRichEditLibraryError));

  CreateSubClass(Params, PChar(ARichClassName));
end;

procedure TcxRichInnerEdit.SelectionChange;
begin
  inherited SelectionChange;
  if Container <> nil then
    Container.DoOnSelectionChange;
end;

procedure TcxRichInnerEdit.WndProc(var Message: TMessage);
begin
  if (Container <> nil) and Container.InnerControlMenuHandler(Message) then
    Exit;
  if ((Message.Msg = WM_LBUTTONDOWN) or (Message.Msg = WM_LBUTTONDBLCLK)) and
    (Container.DragMode = dmAutomatic) and not Container.IsDesigning then
  begin
    _TcxContainerAccess.BeginAutoDrag(Container);
    Exit;
  end;
  inherited WndProc(Message);
end;

function TcxRichInnerEdit.CanPaste: Boolean;
begin
  Result := False;
  if HandleAllocated then
    Result := SendMessage(Handle, EM_CANPASTE, 0, 0) <> 0;
end;

function TcxRichInnerEdit.GetSelection: TCharRange;
begin
  cxSendStructMessage(Handle, EM_EXGETSEL, 0, Result);
end;

//IcxContainerInnerControl
function TcxRichInnerEdit.GetControl: TWinControl;
begin
  Result := Self;
end;

function TcxRichInnerEdit.GetControlContainer: TcxContainer;
begin
  Result := Container;
end;

// IcxInnerEditHelper
function TcxRichInnerEdit.GetHelper: IcxCustomInnerEdit;
begin
  Result := Helper;
end;

function TcxRichInnerEdit.GetContainer: TcxCustomRichEdit;
begin
  if Parent is TcxCustomRichEdit then
    Result := TcxCustomRichEdit(Parent)
  else
    Result := nil;
end;

function TcxRichInnerEdit.GetLineCount: Integer;
begin
  Result := SendMessage(Handle, EM_GETLINECOUNT, 0, 0);
end;

function TcxRichInnerEdit.GetLineIndex(AIndex: Integer): Integer;
begin
  Result := SendMessage(Handle, EM_LINEINDEX , AIndex, 0);
end;

function TcxRichInnerEdit.GetLineLength(AIndex: Integer): Integer;
begin
  if GetLineIndex(AIndex) <> -1 then
    Result := SendMessage(Handle, EM_LINELENGTH, GetLineIndex(AIndex), 0)
  else
    Result := 0;
end;

function TcxRichInnerEdit.GetRichLines: TcxRichEditStrings;
begin
  Result := FRichLines;
end;

procedure TcxRichInnerEdit.InternalSetMemoMode;
var
  AText: string;
  ATextMode: LRESULT;
begin
  if not HandleAllocated then
    Exit;
  ATextMode := SendMessage(Handle, EM_GETTEXTMODE, 0, 0);
  if MemoMode and (ATextMode and TM_PLAINTEXT <> 0) or
    not MemoMode and (ATextMode and TM_RICHTEXT <> 0) then
      Exit;
  AText := Text;
  SendMessage(Handle, WM_SETTEXT, 0, 0);
  if MemoMode then
    ATextMode := ATextMode and not TM_RICHTEXT or TM_PLAINTEXT
  else
    ATextMode := ATextMode and not TM_PLAINTEXT or TM_RICHTEXT;
  SendMessage(Handle, EM_SETTEXTMODE, ATextMode, 0);
  Text := AText;
end;

procedure TcxRichInnerEdit.SetMemoMode(Value: Boolean);
begin
  if Value <> FMemoMode then
  begin
    FMemoMode := Value;
    RecreateWnd;
  end;
end;

procedure TcxRichInnerEdit.SetRichLines(Value: TcxRichEditStrings);
begin
  FRichLines.Assign(Value);
end;

procedure TcxRichInnerEdit.SetSelectionBar(Value: Boolean);
begin
  if Value <> FSelectionBar then
  begin
    FSelectionBar := Value;
    RecreateWnd;
  end;
end;

procedure TcxRichInnerEdit.WMClear(var Message: TMessage);
begin
  if (Self.SelLength > 0) and Container.DoEditing then
    inherited;
end;

procedure TcxRichInnerEdit.WMCut(var Message: TMessage);
begin
  if SelLength > 0 then
    if Container.DoEditing then
      inherited
    else
      Container.CopyToClipboard;
end;

procedure TcxRichInnerEdit.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if FIsEraseBackgroundLocked or (Container <> nil) and Container.IsInplace then
    Message.Result := 1
  else
    CallWindowProc(DefWndProc, Handle, Message.Msg, Message.DC, 0);
end;

procedure TcxRichInnerEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if Container.TabsNeeded and (GetKeyState(VK_CONTROL) >= 0) then
    Message.Result := Message.Result or DLGC_WANTTAB;
  if FEscapePressed then
    Message.Result := Message.Result and not DLGC_WANTALLKEYS;
end;

procedure TcxRichInnerEdit.WMKeyDown(var Message: TWMKeyDown);
var
  AKey: Word;
  APrevState: TcxCustomInnerTextEditPrevState;
  AShiftState: TShiftState;
begin
  if Message.CharCode <> VK_ESCAPE then
    FKeyPressProcessed := True;
  try
    SaveTextEditState(Helper, False, APrevState);
    FInternalUpdating := False;
    inherited;
    Container.SetScrollBarsParameters;
    if FInternalUpdating then
      Exit;
  finally
    FKeyPressProcessed := False;
  end;
  AShiftState := KeyDataToShiftState(Message.KeyData);
  AKey := Message.CharCode;
  if (AKey <> 0) and not Container.CanKeyDownModifyEdit(AKey, AShiftState) and
    not CheckTextEditState(Helper, APrevState) and
    not Container.IsNavigationKey(AKey, AShiftState) then
      Container.DoAfterKeyDown(AKey, AShiftState);
  Message.CharCode := AKey;
end;

procedure TcxRichInnerEdit.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if not(csDestroying in ComponentState) then
    Container.FocusChanged;
end;

procedure TcxRichInnerEdit.WMMButtonDown(var Message: TWMMButtonDown);
begin
  Message.Result := 1;
  SendMessage(Container.Handle, WM_MBUTTONDOWN, 0,
    MakeLParam(Message.XPos + Left, Message.YPos + Top));
end;

procedure TcxRichInnerEdit.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  if (Container <> nil) and not Container.ScrollBarsCalculating then
    Container.SetScrollBarsParameters;
end;

procedure TcxRichInnerEdit.WMNCPaint(var Message: TWMNCPaint);

  procedure FillSizeGrip;
  var
    DC: HDC;
    ABrush: HBRUSH;
  begin
    if Container.NeedsScrollBars and Container.HScrollBar.Visible and
      Container.VScrollBar.Visible then
    begin
      DC := GetWindowDC(Handle);
      ABrush := 0;
      try
        ABrush := CreateSolidBrush(ColorToRGB(clBtnFace));
        FillRect(DC, GetSizeGripRect(Self), ABrush);
      finally
        if ABrush <> 0 then
          Windows.DeleteObject(ABrush);
        ReleaseDC(Handle, DC);
      end;
    end;
  end;

begin
  inherited;
  if (Container = nil) or not UsecxScrollBars then
    Exit;
  FillSizeGrip;
end;

procedure TcxRichInnerEdit.WMPaint(var Message: TWMPaint);
begin
  if RichVersion >= 200 then
    FIsEraseBackgroundLocked := True;
  try
    inherited;
  finally
    FIsEraseBackgroundLocked := False;
  end;
end;

procedure TcxRichInnerEdit.WMPaste(var Message: TMessage);
begin
  if (Clipboard.FormatCount > 0) and Container.DoEditing then
    inherited;
end;

procedure TcxRichInnerEdit.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if not(csDestroying in ComponentState) and (Message.FocusedWnd <> Container.Handle) then
    Container.FocusChanged;
end;

procedure TcxRichInnerEdit.WMSetFont(var Message: TWMSetFont);
begin
  if HandleAllocated and MemoMode then
  begin
    with TMessage(Message) do
      Result := CallWindowProc(DefWndProc, Handle, Msg, WParam, LParam);
    DefAttributes.Color := Font.Color;
  end
  else
    inherited;
end;

procedure TcxRichInnerEdit.WMHScroll(var Message: TWMHScroll);
begin
  inherited;
  if not Focused then
    Container.SetScrollBarsParameters;
end;

procedure TcxRichInnerEdit.WMVScroll(var Message: TWMVScroll);
begin
  inherited;
  if not Focused then
    Container.SetScrollBarsParameters;
end;

procedure TcxRichInnerEdit.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  if Container <> nil then
    Container.SetScrollBarsParameters;
  inherited;
end;

procedure TcxRichInnerEdit.WMWindowPosChanging(var Message: TWMWindowPosChanging);
var
  ARgn: HRGN;
begin
  inherited;
  if (Container <> nil) and not(csDestroying in ComponentState) and
    Container.NeedsScrollBars and Container.HScrollBar.Visible and Container.VScrollBar.Visible then
  begin
    ARgn := CreateRectRgnIndirect(GetSizeGripRect(Self));
    SendMessage(Handle, WM_NCPAINT, ARgn, 0);
    Windows.DeleteObject(ARgn);
  end;
end;

procedure TcxRichInnerEdit.EMReplaceSel(var Message: TMessage);
begin
  if (Container <> nil) and Container.Focused then
    Container.DoEditing;
  inherited;
end;

procedure TcxRichInnerEdit.EMSetCharFormat(var Message: TMessage);
begin
  if Focused and (Message.WParam = SCF_SELECTION) and (SelLength > 0) then
    Container.DoEditing;
  inherited;
end;

procedure TcxRichInnerEdit.EMSetParaFormat(var Message: TMessage);
begin
  if (Container <> nil) and not Container.IsDestroying and
    (Container.ComponentState * [csLoading, csReading] = []) and Focused then
      Container.DoEditing;
  inherited;
end;

procedure TcxRichInnerEdit.CMColorChanged(var Message: TMessage);
begin
  if (Container <> nil) and not Container.IsInplace then
    inherited;
end;

procedure TcxRichInnerEdit.CMFontChanged(var Message: TMessage);
begin
  if HandleAllocated and MemoMode then
    Perform(WM_SETFONT, Font.Handle, 0)
  else
    if (Container <> nil) and not Container.IsInplace then
      SetRichDefAttributes(Self, Font,
        Container.ActiveStyle.GetVisibleFont.Color);
end;

procedure TcxRichInnerEdit.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if Message.lParam = 0 then
    MouseLeave(Self)
  else
    MouseLeave(TControl(Message.lParam));
end;

procedure TcxRichInnerEdit.WMChar(var Message: TWMChar);
begin
  if Message.CharCode <> VK_ESCAPE then
    FKeyPressProcessed := True;
  try
    inherited;
  finally
    FKeyPressProcessed := False;
  end;
end;

procedure TcxRichInnerEdit.CNCommand(var Message: TWMCommand);


begin
  if Message.NotifyCode <> EN_CHANGE then
  begin
    inherited;
    Exit;
  end;

  if (Container <> nil) and not Container.IsDestroying and
    (Container.ComponentState * [csLoading, csReading] = []) and
    Focused and FKeyPressProcessed then
      Container.DoEditing;
  inherited;
end;

procedure TcxRichInnerEdit.CNKeyDown(var Message: TWMKeyDown);
begin
  if Message.CharCode = VK_ESCAPE then
    FEscapePressed := True;
  try
    inherited;
  finally
    FEscapePressed := False;
  end;
end;

const
  AUseCRLFFlag: array[Boolean] of DWORD = (0, 1);

procedure TcxRichInnerEdit.WMGetText(var Message: TMessage);
var
  ATextInfo: TGetTextEx;
begin
  if (RichVersion >= 200) and HandleAllocated then
  begin
    ZeroMemory(@ATextInfo, SizeOf(ATextInfo));
    ATextInfo.cb := Message.WParam;
    ATextInfo.flags := AUseCRLFFlag[FUseCRLF];
    Message.Result := cxSendStructMessage(Handle, EM_GETTEXTEX, ATextInfo, Message.LParam);
  end
  else
    inherited;
end;

procedure TcxRichInnerEdit.WMGetTextLength(var Message: TWMGetTextLength);
var
  ATextInfo: TGetTextLengthEx;
begin
  if (RichVersion >= 200) and HandleAllocated then
  begin
    ZeroMemory(@ATextInfo, SizeOf(ATextInfo));
    ATextInfo.flags := GTL_PRECISE or GTL_NUMCHARS or AUseCRLFFlag[FUseCRLF];
    Message.Result := cxSendStructMessage(Handle, EM_GETTEXTLENGTHEX, ATextInfo, 0);
  end
  else
    inherited;
end;

procedure TcxRichInnerEdit.WMSetText(var Message: TWMSetText);
begin
  if MemoMode and IsRichText(Message.Text) then
    Message.Text := PChar(ConvertRichText(Message.Text));
  inherited;
end;


procedure TcxRichInnerEdit.WMIMEComposition(var Message: TMessage);
begin
  if Container.DoEditing then
    inherited;
end;

procedure TcxRichInnerEdit.EMExLineFromChar(var Message: TMessage);
begin
  inherited;
  if MemoMode then
  begin
    if GetLineIndex(Message.Result + 1) = Message.LParam then
      Message.Result := Message.Result + 1;
  end;
end;

procedure TcxRichInnerEdit.EMLineLength(var Message: TMessage);
var
  ALineIndex: Integer;
begin
  inherited;
  if MemoMode then
  begin
    ALineIndex := SendMessage(Handle, EM_EXLINEFROMCHAR, 0, Message.WParam);
    if (ALineIndex = GetLineCount - 1) and (Lines[ALineIndex] = '') then
      Message.Result := 0;
  end;
end;

{ TcxRichEdit }

destructor TcxCustomRichEdit.Destroy;
begin
  FreeAndNil(FEditPopupMenu);
  inherited Destroy;
end;

function TcxCustomRichEdit.GetInnerEditClass: TControlClass;
begin
  Result := TcxRichInnerEdit;
end;

procedure TcxCustomRichEdit.DoProtectChange(Sender: TObject;
  AStartPos, AEndPos: Integer; var AAllowChange: Boolean);
begin
  with Properties do
    if Assigned(OnProtectChange) then
      OnProtectChange(Self, AStartPos, AEndPos, AAllowChange);
  if RepositoryItem <> nil then
    with ActiveProperties do
      if Assigned(OnProtectChange) then
        OnProtectChange(Self, AStartPos, AEndPos, AAllowChange);
end;

procedure TcxCustomRichEdit.DoSaveClipboard(Sender: TObject;
  ANumObjects, ANumChars: Integer; var ASaveClipboard: Boolean);
begin
  if IsDestroying then
    Exit;
  with Properties do
    if Assigned(OnSaveClipboard) then
      OnSaveClipboard(Self, ANumObjects, ANumChars, ASaveClipboard);
  if RepositoryItem <> nil then
    with ActiveProperties do
      if Assigned(OnSaveClipboard) then
        OnSaveClipboard(Self, ANumObjects, ANumChars, ASaveClipboard);
end;

procedure TcxCustomRichEdit.EditPopupMenuClick(Sender: TObject);
begin
  case Integer(TMenuItem(Sender).Tag) of
    -1: Undo;
    -2: InnerRich.Redo;
    -3: CutToClipboard;
    -4: CopyToClipboard;
    -5: PasteFromClipboard;
    -6: ClearSelection;
    -7: InnerRich.SelectAll;
  end;
end;

function TcxCustomRichEdit.GetLines: TStrings;
begin
  Result := InnerRich.RichLines;
end;

function TcxCustomRichEdit.GetInnerRich: TcxRichInnerEdit;
begin
  Result := TcxRichInnerEdit(InnerControl);
end;

procedure TcxCustomRichEdit.SetLines(Value: TStrings);
begin
  InnerRich.RichLines.Assign(Value);
end;

procedure TcxCustomRichEdit.ChangeHandler(Sender: TObject);
begin
  FIsNullEditValue := False;
  inherited ChangeHandler(Sender);
  DoEditValueChanged;
end;

procedure TcxCustomRichEdit.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);
begin
  with InnerRich do
    if AScrollBarKind = sbHorizontal then
    begin
      CallWindowProc(DefWndProc, Handle, WM_HSCROLL, Word(AScrollCode) +
        Word(AScrollPos) shl 16, HScrollBar.Handle);
      if not (AScrollCode = scTrack) then
        AScrollPos := GetScrollPos(Handle, SB_HORZ);
    end else
    begin
      CallWindowProc(DefWndProc, Handle, WM_VSCROLL, Word(AScrollCode) +
        Word(AScrollPos) shl 16, VScrollBar.Handle);
      if not (AScrollCode = scTrack) then
        AScrollPos := GetScrollPos(Handle, SB_VERT);
    end;
  if AScrollCode = scTrack then Exit;

  SetScrollBarsParameters;
end;

procedure TcxCustomRichEdit.AdjustInnerEdit;
begin
  if ActiveProperties.MemoMode then
    inherited AdjustInnerEdit
  else
  begin
    InnerRich.Color := ViewInfo.BackgroundColor;
    InnerRich.Font := Style.GetVisibleFont;
  end;
end;

function TcxCustomRichEdit.CanFocusOnClick: Boolean;
begin
  Result := inherited CanFocusOnClick and
    not(csLButtonDown in InnerRich.ControlState);
end;

function TcxCustomRichEdit.CanKeyDownModifyEdit(Key: Word; Shift: TShiftState): Boolean;
begin
  Result := inherited CanKeyDownModifyEdit(Key, Shift) or
   (((Key = VK_DELETE) or (Key = VK_INSERT)) and (ssShift in Shift)) or
   (((Key = Ord('V')) or (Key = Ord('X')) and (ssCtrl in Shift))) and
   (Clipboard.FormatCount > 0);
  Result := Result or (Key = VK_BACK); // !!!
end;

procedure TcxCustomRichEdit.ContainerStyleChanged(Sender: TObject);
begin
  inherited ContainerStyleChanged(Sender);
  if not IsInplace and DataBinding.IDefaultValuesProvider.IsDataStorage and
    not ActiveProperties.MemoMode and not ModifiedAfterEnter then
      Reset;
end;

function TcxCustomRichEdit.DoShowPopupMenu(AMenu: TComponent; X, Y: Integer): Boolean;
begin
  if Assigned(AMenu) then
    Result := inherited DoShowPopupMenu(AMenu, X, Y)
  else
  begin
    UpdateEditPopupMenuItems(GetEditPopupMenuInstance);
    Result := inherited DoShowPopupMenu(GetEditPopupMenuInstance, X, Y);
    EditingChanged;
  end;
end;

function TcxCustomRichEdit.GetEditValue: TcxEditValue;
begin
  if FIsNullEditValue then
    Result := Null
  else
    PrepareEditValue('', Result, False);
end;

{ TcxCustomRichEditViewData }

procedure TcxCustomRichEditViewData.Calculate(ACanvas: TcxCanvas;
  const ABounds: TRect; const P: TPoint; Button: TcxMouseButton;
  Shift: TShiftState; AViewInfo: TcxCustomEditViewInfo;
  AIsMouseEvent: Boolean);
begin
  inherited Calculate(ACanvas, ABounds, P, Button, Shift, AViewInfo, AIsMouseEvent);
  TcxCustomRichEditViewInfo(AViewInfo).IsDrawBitmapDirty := True;
end;

function TcxCustomRichEditViewData.InternalGetEditContentSize(
  ACanvas: TcxCanvas; const AEditValue: TcxEditValue;
  const AEditSizeProperties: TcxEditSizeProperties): TSize;
var
  ADC: HDC;
  AHeight: Integer;
begin
  if (AEditSizeProperties.Width = -1) or (Properties.VisibleLineCount > 0) then
    Result := inherited InternalGetEditContentSize(ACanvas, AEditValue,
      AEditSizeProperties)
  else
  begin
    ADC := CreateCompatibleDC(ACanvas.Handle);
    try
      Result.cx := AEditSizeProperties.Width;
      DrawRichEdit(ADC, Rect(0, 0, AEditSizeProperties.Width, 0), VarToStr(AEditValue),
        Properties, Style.Font, clWhite, clBlack, True, AHeight);
      if AHeight > 0 then
        Inc(AHeight, GetEditContentSizeCorrection.cy);
      Result.cy := AHeight;
    finally
      DeleteDC(ADC);
    end;
  end;
end;

function TcxCustomRichEditViewData.GetProperties: TcxCustomRichEditProperties;
begin
  Result := TcxCustomRichEditProperties(FProperties);
end;

{ TcxCustomRichEditProperties }

constructor TcxCustomRichEditProperties.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FHideScrollBars := True;
end;

procedure TcxCustomRichEditProperties.Assign(Source: TPersistent);
begin
  if Source is TcxCustomRichEditProperties then
  begin
    BeginUpdate;
    try
      inherited Assign(Source);
      with Source as TcxCustomRichEditProperties do
      begin
        Self.HideScrollBars := HideScrollBars;
        Self.MemoMode := MemoMode;
        Self.PlainText := PlainText;
        Self.SelectionBar := SelectionBar;
        Self.OnProtectChange := OnProtectChange;
        Self.OnResizeRequest := OnResizeRequest;
        Self.OnSaveClipboard := OnSaveClipboard;
        Self.OnSelectionChange := OnSelectionChange;
      end;
    finally
      EndUpdate;
    end
  end
  else
    inherited Assign(Source);
end;

class function TcxCustomRichEditProperties.GetContainerClass: TcxContainerClass;
begin
  Result := TcxRichEdit;
end;

function TcxCustomRichEditProperties.GetDisplayText(
  const AEditValue: TcxEditValue; AFullText: Boolean = False;
  AIsInplace: Boolean = True): WideString;
begin
  if (MemoMode or not PlainText) and IsRichText(VarToStr(AEditValue)) then
    Result := inherited GetDisplayText(ConvertRichText(VarToStr(AEditValue)), AFullText)
  else
    Result := inherited GetDisplayText(AEditValue, AFullText);
end;

function TcxCustomRichEditProperties.GetSupportedOperations: TcxEditSupportedOperations;
begin
  Result := [esoAutoHeight, esoEditing, esoHorzAlignment];
end;

function TcxCustomRichEditProperties.CanValidate: Boolean;
begin
  Result := False;
end;

class function TcxCustomRichEditProperties.GetViewDataClass: TcxCustomEditViewDataClass;
begin
  Result := TcxCustomRichEditViewData;
end;

class function TcxCustomRichEditProperties.GetViewInfoClass: TcxContainerViewInfoClass;
begin
  Result := TcxCustomRichEditViewInfo;
end;

function TcxCustomRichEditProperties.IsResetEditClass: Boolean;
begin
  Result := False;
end;

procedure TcxCustomRichEditProperties.SetHideScrollBars(Value: Boolean);
begin
  if Value <> FHideScrollBars then
  begin
    FHideScrollBars := Value;
    Changed;
  end;
end;

procedure TcxCustomRichEditProperties.SetMemoMode(Value: Boolean);
begin
  if Value <> FMemoMode then
  begin
    FMemoMode := Value;
    Changed;
  end;
end;

procedure TcxCustomRichEditProperties.SetPlainText(Value: Boolean);
begin
  if FPlainText <> Value then
  begin
    FPlainText := Value;
    FPlainTextChanged := True;
    try
      Changed;
    finally
      FPlainTextChanged := False;
    end;
  end;
end;

procedure TcxCustomRichEditProperties.SetSelectionBar(Value: Boolean);
begin
  if Value <> FSelectionBar then
  begin
    FSelectionBar := Value;
    Changed;
  end;
end;

{ TcxCustomRichEditViewInfo }

constructor TcxCustomRichEditViewInfo.Create;
begin
  inherited Create;
  PrevDrawBitmapSize.cx := -1;
  PrevDrawBitmapSize.cy := -1;
end;

destructor TcxCustomRichEditViewInfo.Destroy;
begin
  if DrawBitmap <> 0 then
    DeleteObject(DrawBitmap);
  inherited Destroy;
end;

procedure TcxCustomRichEditViewInfo.DrawText(ACanvas: TcxCanvas);

  procedure PrepareDrawBitmap;
  var
    ADC: HDC;
    APrevBitmap: HBITMAP;
    ATempVar: Integer;
  begin
    if IsDrawBitmapDirty then
    begin
      if (DrawBitmap = 0) or (PrevDrawBitmapSize.cx <> TextRect.Right - TextRect.Left) or
        (PrevDrawBitmapSize.cy <> TextRect.Bottom - TextRect.Top) then
      begin
        if DrawBitmap <> 0 then
          DeleteObject(DrawBitmap);
        DrawBitmap := CreateCompatibleBitmap(ACanvas.Handle,
          TextRect.Right - TextRect.Left, TextRect.Bottom - TextRect.Top);
      end;
      ADC := CreateCompatibleDC(ACanvas.Handle);
      APrevBitmap := 0;
      try
        APrevBitmap := SelectObject(ADC, DrawBitmap);
        DrawRichEdit(ADC, TextRect, Text, TcxCustomRichEditProperties(EditProperties),
          Font, BackgroundColor, TextColor, False, ATempVar);
      finally
        if APrevBitmap <> 0 then
          SelectObject(ADC, APrevBitmap);
        DeleteDC(ADC);
      end;
      IsDrawBitmapDirty := False;
    end;
  end;

var
  ADC: HDC;
  APrevBitmap: HBITMAP;
begin
  PrepareDrawBitmap;
  ADC := CreateCompatibleDC(ACanvas.Handle);
  APrevBitmap := 0;
  try
    APrevBitmap := SelectObject(ADC, DrawBitmap);
    with TextRect do
      BitBlt(ACanvas.Handle, Left, Top, Right - Left, Bottom - Top, ADC, 0, 0, SRCCOPY);
  finally
    if APrevBitmap <> 0 then
      SelectObject(ADC, APrevBitmap);
    DeleteDC(ADC);
  end;
end;

function TcxCustomRichEditViewInfo.GetUpdateRegion(AViewInfo: TcxContainerViewInfo): TcxRegion;
begin
  Result := TcxRegion.Create(Self.Bounds);
end;

function TcxCustomRichEditViewInfo.NeedShowHint(ACanvas: TcxCanvas;
  const P: TPoint; const AVisibleBounds: TRect; out AText: TCaption;
  out AIsMultiLine: Boolean; out ATextRect: TRect): Boolean;
begin
  Result := False;
end;

procedure TcxCustomRichEditViewInfo.Paint(ACanvas: TcxCanvas);
begin
  ACanvas.Canvas.Lock;
  try
    if IsInplace and not Focused or IsDBEditPaintCopyDrawing then
    begin
      DrawText(ACanvas);
      ACanvas.ExcludeClipRect(TextRect);
    end;
    DrawCustomEdit(ACanvas, Self, True, bpsComboListEdit);
  finally
    ACanvas.Canvas.Unlock;
  end;
end;

function TcxCustomRichEdit.GetActiveProperties: TcxCustomRichEditProperties;
begin
  Result := TcxCustomRichEditProperties(InternalGetActiveProperties);
end;

function TcxCustomRichEdit.GetProperties: TcxCustomRichEditProperties;
begin
  Result := TcxCustomRichEditProperties(FProperties);
end;

procedure TcxCustomRichEdit.SetProperties(Value: TcxCustomRichEditProperties);
begin
  FProperties.Assign(Value);
end;

function TcxCustomRichEdit.GetCanUndo: Boolean;
begin
  Result := InnerRich.CanUndo;
end;

procedure TcxCustomRichEdit.Initialize;
begin
  inherited Initialize;
  InnerRich.OnProtectChange := DoProtectChange;
  InnerRich.OnSaveClipboard := DoSaveClipboard;
  Width := 185;
  Height := 89;
  FIsNullEditValue := True;
end;

procedure TcxCustomRichEdit.InternalSetEditValue(const Value: TcxEditValue;
  AValidateEditValue: Boolean);
begin
  LockChangeEvents(True);
  try
    SendMessage(InnerRich.Handle, WM_SETREDRAW, 0, 0);
    try
      SendMessage(InnerRich.Handle, WM_SETTEXT, 0, Integer(PChar('')));
      InnerEdit.EditValue := Value;
      EditModified := False;
      FIsNullEditValue := VarIsNull(Value);
    finally
      SendMessage(InnerRich.Handle, WM_SETREDRAW, 1, 0);
      InnerRich.Invalidate;
    end;
  finally
    LockChangeEvents(False);
  end;
end;

procedure TcxCustomRichEdit.InternalValidateDisplayValue(const ADisplayValue: TcxEditValue);
begin
end;

procedure TcxCustomRichEdit.PropertiesChanged(Sender: TObject);
begin
  with InnerRich do
  begin
    HideScrollBars := ActiveProperties.HideScrollBars;
    MemoMode := ActiveProperties.MemoMode;
    PlainText := ActiveProperties.PlainText or MemoMode;
    SelectionBar := ActiveProperties.SelectionBar;
  end;
  if not(IsInplace or IsDBEdit) then
    FPropertiesChange := True;
  try
    inherited PropertiesChanged(Sender);
  finally
    FPropertiesChange := False;
  end;
end;

procedure TcxCustomRichEdit.ResetEditValue;
begin
  if not IsInplace and IsDBEdit then
    Reset;
end;

procedure TcxCustomRichEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  RefreshScrollBars;
end;

procedure TcxCustomRichEdit.SynchronizeDisplayValue;
begin
end;

procedure TcxCustomRichEdit.SynchronizeEditValue;
begin
end;

function TcxCustomRichEdit.GetDefAttributes: TTextAttributes;
begin
  Result := InnerRich.DefAttributes;
end;

function TcxCustomRichEdit.GetDefaultConverter: TConversionClass;
begin
  Result := InnerRich.DefaultConverter;
end;

function TcxCustomRichEdit.GetPageRect: TRect;
begin
  Result := InnerRich.PageRect;
end;

function TcxCustomRichEdit.GetParagraph: TParaAttributes;
begin
  Result := InnerRich.Paragraph;
end;

function TcxCustomRichEdit.GetSelAttributes: TTextAttributes;
begin
  if ActiveProperties.MemoMode then
    Result := InnerRich.DefAttributes
  else
    Result := InnerRich.SelAttributes;
end;

procedure TcxCustomRichEdit.RefreshScrollBars;
var
  ARgn: HRGN;
begin
  if HandleAllocated and NeedsScrollBars then
  begin
    ARgn := CreateRectRgnIndirect(GetControlRect(InnerRich));
    SendMessage(InnerRich.Handle, WM_NCPAINT, ARgn, 0);
    SetScrollBarsParameters;
    VScrollBar.Invalidate;
    HScrollBar.Invalidate;
    DeleteObject(ARgn);
  end;
end;

procedure TcxCustomRichEdit.SetDefAttributes(const Value: TTextAttributes);
begin
  InnerRich.DefAttributes := Value;
end;

procedure TcxCustomRichEdit.SetDefaultConverter(Value: TConversionClass);
begin
  InnerRich.DefaultConverter := Value;
end;

procedure TcxCustomRichEdit.SetPageRect(const Value: TRect);
begin
  InnerRich.PageRect := Value;
end;

procedure TcxCustomRichEdit.SetSelAttributes(const Value: TTextAttributes);
begin
  InnerRich.SelAttributes := Value;
end;

procedure TcxCustomRichEdit.EMCanPaste(var Message: TMessage);
begin
  InnerRich.Dispatch(Message);
end;

procedure TcxCustomRichEdit.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
  RefreshScrollBars;
end;

function TcxCustomRichEdit.UpdateContentOnFocusChanging: Boolean;
begin
  Result := False;
end;

procedure TcxCustomRichEdit.UpdateScrollBars;
begin
end;


function TcxCustomRichEdit.CanDeleteSelection: Boolean;
begin
  Result := (SelLength > 0) and CanModify;
end;

procedure TcxCustomRichEdit.Changed(Sender: TObject);
begin
  DoEditing;
end;

procedure TcxCustomRichEdit.DoOnResizeRequest(const R: TRect);
begin
  with Properties do
    if Assigned(OnResizeRequest) then
      OnResizeRequest(Self, R);
  if RepositoryItem <> nil then
    with ActiveProperties do
      if Assigned(OnResizeRequest) then
        OnResizeRequest(Self, R);
end;

procedure TcxCustomRichEdit.DoOnSelectionChange;
begin
  with Properties do
    if Assigned(OnSelectionChange) then
      OnSelectionChange(Self);
  if RepositoryItem <> nil then
    with ActiveProperties do
      if Assigned(OnSelectionChange) then
        OnSelectionChange(Self);
end;

function TcxCustomRichEdit.GetEditPopupMenuInstance: TComponent;

  function NewItem(const ACaption: string; ATag: Integer): TMenuItem;
  begin
    Result := TMenuItem.Create(Self);
    with Result do
    begin
      Caption := ACaption;
      Tag := ATag;
      OnClick := EditPopupMenuClick;
    end;
  end;

var
  APopupMenu: TPopupMenu;
begin
  if Assigned(FEditPopupMenu) then
  begin
    Result := FEditPopupMenu;
    Exit;
  end;
  APopupMenu := TPopupMenu.Create(Self);
  FEditPopupMenu := APopupMenu;
  APopupMenu.Items.Add(
    NewItem(cxGetResourceString(@cxSEditRichEditUndoCaption), -1));
  APopupMenu.Items.Add(
    NewItem(cxGetResourceString(@cxSEditRichEditRedoCaption), -2));
  APopupMenu.Items.Add(NewItem('-', MaxInt));
  APopupMenu.Items.Add(
    NewItem(cxGetResourceString(@cxSEditRichEditCutCaption), -3));
  APopupMenu.Items.Add(
    NewItem(cxGetResourceString(@cxSEditRichEditCopyCaption), -4));
  APopupMenu.Items.Add(
    NewItem(cxGetResourceString(@cxSEditRichEditPasteCaption), -5));
  APopupMenu.Items.Add(
    NewItem(cxGetResourceString(@cxSEditRichEditDeleteCaption), -6));
  APopupMenu.Items.Add(NewItem('-', MaxInt));
  APopupMenu.Items.Add(
    NewItem(cxGetResourceString(@cxSEditRichEditSelectAllCaption), -7));
  Result := APopupMenu;
end;

function TcxCustomRichEdit.IsNavigationKey(Key: Word;
  Shift: TShiftState): Boolean;
begin
  Result := (((Key = VK_UP) or (Key = VK_DOWN) or
    (Key = VK_LEFT) or (Key = VK_RIGHT)) and (Shift = [])) or
    (Key = VK_NEXT) or (Key = VK_PRIOR) or (Key = VK_HOME) or (Key = VK_END);
end;

procedure TcxCustomRichEdit.UpdateEditPopupMenuItems(APopupMenu: TComponent);

  procedure UpdateItems(APopupMenu: TPopupMenu);
  begin
    APopupMenu.Items[0].Enabled := InnerRich.CanUndo;
    APopupMenu.Items[1].Enabled := InnerRich.CanRedo;
    APopupMenu.Items[3].Enabled := CanDeleteSelection;
    APopupMenu.Items[4].Enabled := InnerRich.SelLength > 0;
    APopupMenu.Items[5].Enabled := InnerRich.CanPaste;
    APopupMenu.Items[6].Enabled := CanDeleteSelection;
    APopupMenu.Items[8].Enabled := True;
  end;

begin
  if not (APopupMenu is TPopupMenu) then
    Exit;
  InnerRich.ReadOnly := inherited RealReadOnly;
  UpdateItems(TPopupMenu(APopupMenu));
  InnerRich.ReadOnly := RealReadOnly; // !!! ReadOnly must be True in DBRichEdit while DataSet is not in EditMode (for AddictSpellChecker)
end;


procedure TcxCustomRichEdit.ClearSelection;
begin
  InnerRich.ClearSelection;
end;

procedure TcxCustomRichEdit.CutToClipboard;
begin
  InnerRich.CutToClipboard;
end;

function TcxCustomRichEdit.FindText(const ASearchStr: string;
  AStartPos, ALength: Integer; AOptions: TSearchTypes): Integer;
begin
  Result := InnerRich.FindText(ASearchStr, AStartPos, ALength, AOptions);
end;

class function TcxCustomRichEdit.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomRichEditProperties;
end;

procedure TcxCustomRichEdit.PasteFromClipboard;
begin
  InnerRich.PasteFromClipboard;
end;

procedure TcxCustomRichEdit.PrepareEditValue(const ADisplayValue: TcxEditValue;
  out EditValue: TcxEditValue; AEditFocused: Boolean);
var
  AStream: TStringStream;
begin
  if ActiveProperties.MemoMode or ActiveProperties.PlainText or
    (Parent = nil) or not Parent.HandleAllocated then
      EditValue := InnerRich.Text
  else
  begin
    AStream := TStringStream.Create('');
    try
      Lines.SaveToStream(AStream);
      EditValue := AStream.DataString;
    finally
      AStream.Free;
    end;
  end;
end;

procedure TcxCustomRichEdit.Print(const Caption: string);
begin
  InnerRich.Print(Caption);
end;

procedure TcxCustomRichEdit.Undo;
begin
  InnerRich.Undo;
end;

class procedure TcxCustomRichEdit.RegisterConversionFormat(
  const AExtension: string; AConversionClass: TConversionClass);
var
  AConversionFormat: PConversionFormat;
begin
  New(AConversionFormat);
  with AConversionFormat^ do
  begin
    Extension := AnsiLowerCaseFileName(AExtension);
    ConversionClass := AConversionClass;
    Next := FConversionFormatList;
  end;
  FConversionFormatList := AConversionFormat;
  TCustomRichEdit.RegisterConversionFormat(AExtension, AConversionClass);
end;

initialization
  GetRegisteredEditProperties.Register(TcxRichEditProperties,
    cxGetResourceString(@scxSEditRepositoryRichEditItem));

finalization
  FreeAndNil(FRichRenderer);
  FreeAndNil(FRichConverter);  
  GetRegisteredEditProperties.Unregister(TcxRichEditProperties);
  if FRichEditLibrary <> 0 then
    FreeLibrary(FRichEditLibrary);
  ReleaseConversionFormatList;

end.
