// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBaseEdit.pas' rev: 31.00 (Windows)

#ifndef LmdbaseeditHPP
#define LmdbaseeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Clipbrd.hpp>
#include <Vcl.Menus.hpp>
#include <LMDTypes.hpp>
#include <LMDCaret.hpp>
#include <LMDConst.hpp>
#include <LMDUtils.hpp>
#include <LMDProcs.hpp>
#include <LMDGraph.hpp>
#include <LMDClass.hpp>
#include <intfLMDFaceControllerEditable.hpp>
#include <LMDBase.hpp>
#include <LMDBoundLabel.hpp>
#include <LMD3DCaption.hpp>
#include <LMDDynLIFOBuffer.hpp>
#include <LMDVldBase.hpp>
#include <Winapi.Imm.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <System.UITypes.hpp>
#include <LMDCustomPanel.hpp>
#include <System.Types.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDFaceController.hpp>
#include <LMDBevel.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbaseedit
{
//-- forward type declarations -----------------------------------------------
struct TLMDUndoRecord;
class DELPHICLASS TLMDBaseEdit;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TLMDUndoRecord
{
public:
	Lmdtypes::TLMDString newText;
	Lmdtypes::TLMDString oldText;
	int selstart;
	int sellength;
	int newlength;
	int current;
};


typedef TLMDUndoRecord *PLMDUndoRecord;

enum DECLSPEC_DENUM TLMDSearchStart : unsigned char { stTop, stBottom, stCursor };

enum DECLSPEC_DENUM TLMDSearchDirection : unsigned char { sdUp, sdDown };

enum DECLSPEC_DENUM TLMDEditOption : unsigned char { eoNarrowHeight, eoSuppressDefaultMenu, eoUserLocale, eoAllowCopy, eoAllowCut, eoAllowPaste };

typedef System::Set<TLMDEditOption, TLMDEditOption::eoNarrowHeight, TLMDEditOption::eoAllowPaste> TLMDEditOptions;

typedef System::Set<char, _DELPHI_SET_CHAR(0), _DELPHI_SET_CHAR(255)> TLMDDelimiters;

typedef void __fastcall (__closure *TLMDTextChangeEvent)(System::TObject* sender, int At);

typedef int __stdcall (*TIMECompStringProc)(int hImc, unsigned dWord1, void * lpBuf, unsigned dwBufLen);

class PASCALIMPLEMENTATION TLMDBaseEdit : public Lmdcustombevelpanel::TLMDCustomBevelPanel
{
	typedef Lmdcustombevelpanel::TLMDCustomBevelPanel inherited;
	
private:
	System::Types::TSmallPoint FMousePos;
	Lmdcaret::TLMDCaret* FCaret;
	bool FTabEnter;
	bool FEnableKeyInput;
	bool FHasBoundLabel;
	bool FSaveRes;
	bool FDraggingAllowed;
	bool FAskForLoop;
	bool FRedoing;
	bool FUndoing;
	bool FCanUndo;
	bool FCanRedo;
	TLMDEditOptions FOptions;
	System::Classes::TAlignment FAlignment;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	System::Uitypes::TCursor FCursor;
	Lmdclass::TLMDTimer* FTimerID;
	int FTextRectBorderY;
	int FPrevCharPos;
	int FFirstLine;
	int FMaxLength;
	int FSelLength;
	Lmddynlifobuffer::TLMDDynLIFOBuffer* FUndoBuffer;
	Lmddynlifobuffer::TLMDDynLIFOBuffer* FRedoBuffer;
	System::Uitypes::TColor FHighTextColor;
	System::Uitypes::TColor FHighBackColor;
	bool FDragging;
	bool FLeftButtonPressed;
	bool FGetFocusOnMouseAbove;
	bool FOEMConvert;
	bool FAutoSelect;
	bool FModified;
	bool FReadOnly;
	bool FInsert;
	bool FHideSelection;
	TLMDDelimiters FDelimiters;
	TLMDTextChangeEvent FOnTextChange;
	System::Classes::TNotifyEvent FOnCursorPosChanged;
	System::Classes::TNotifyEvent FOnModified;
	System::Classes::TNotifyEvent FOnChange;
	System::Uitypes::TEditCharCase FCharCase;
	Lmdboundlabel::TLMDBoundLabel* FEditLabel;
	Vcl::Extctrls::TLabelPosition FLabelPosition;
	int FLabelSpacing;
	bool FLabelSync;
	bool FUseGlobalTimer;
	void __fastcall SetLabelPosition(const Vcl::Extctrls::TLabelPosition Value);
	void __fastcall SetLabelSpacing(const int Value);
	void __fastcall SetHasLabel(bool aValue);
	void __fastcall SetLabelSync(const bool Value);
	void __fastcall ReadEditLabel(System::Classes::TStream* Stream);
	MESSAGE void __fastcall CMLMDBOUNDLABELCHANGE(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMBiDiModeChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Msg);
	void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetInteger(int Index, int aValue);
	void __fastcall SetAlignment(System::Classes::TAlignment aValue);
	HIDESBASE void __fastcall SetBoolean(int Index, bool aValue);
	bool __fastcall GetBoolean(int Index);
	void __fastcall SetCaretVal(Lmdcaret::TLMDCaret* aValue);
	void __fastcall SetCharCase(System::Uitypes::TEditCharCase aValue);
	void __fastcall pSetText(const Lmdtypes::TLMDString aValue);
	HIDESBASE Lmdtypes::TLMDString __fastcall GetText(void);
	void __fastcall SetSelText(Lmdtypes::TLMDString aValue);
	Lmdtypes::TLMDString __fastcall GetSelText(void);
	void __fastcall DoUndo(System::TObject* Sender);
	void __fastcall DoCopy(System::TObject* Sender);
	void __fastcall DoCut(System::TObject* Sender);
	void __fastcall DoPaste(System::TObject* Sender);
	void __fastcall DoClear(System::TObject* Sender);
	void __fastcall DoOnTimer(System::TObject* Sender);
	void __fastcall DoSelectAll(System::TObject* Sender);
	void __fastcall DoLeftMouseBtn(void);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	void __fastcall UpdateCaret(void);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Winapi::Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMImeStartComposition(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMImeComposition(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMClear(Winapi::Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall WMCopy(Winapi::Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall WMCut(Winapi::Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall WMPaste(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Winapi::Messages::TWMMouseActivate &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	MESSAGE void __fastcall WMSetText(Winapi::Messages::TWMSetText &Msg);
	MESSAGE void __fastcall WMGetText(Winapi::Messages::TWMGetText &Msg);
	MESSAGE void __fastcall WMGetTextLength(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMQuit(Winapi::Messages::TWMQuit &Msg);
	MESSAGE void __fastcall EMCANUNDO(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMCHARFROMPOS(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMEMPTYUNDOBUFFER(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMFMTLINES(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMGETFIRSTVISIBLELINE(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMGETHANDLE(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMGETLIMITTEXT(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMGETLINE(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMGETLINECOUNT(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMGETMARGINS(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMGETMODIFY(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMGETPASSWORDCHAR(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMGETRECT(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMGETSEL(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMGETTHUMB(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMGETWORDBREAKPROC(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMLIMITTEXT(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMLINEFROMCHAR(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMLINEINDEX(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMLINELENGTH(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMLINESCROLL(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMPOSFROMCHAR(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMREPLACESEL(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMSCROLL(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMSCROLLCARET(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMSETHANDLE(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMSETMARGINS(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMSETMODIFY(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMSETPASSWORDCHAR(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMSETREADONLY(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMSETRECT(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMSETRECTNP(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMSETSEL(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMSETTABSTOPS(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMSETWORDBREAKPROC(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMUNDO(Winapi::Messages::TMessage &Message);
	void __fastcall SetOptions(const TLMDEditOptions Value);
	
protected:
	bool FForceOverwriteMode;
	int FDoubleClickCX;
	int FDoubleClickCY;
	unsigned FLastClickTime;
	unsigned FDoubleClickTimeout;
	int FFirstClickX;
	int FFirstClickY;
	System::Byte FClickCount;
	Lmdvldbase::TLMDValidationEntity* FValidator;
	Lmdtypes::TLMDString FValidationMsgString;
	bool FErrorIndication;
	Lmdvldbase::TLMDValidationErrorEvent FOnValidationError;
	Vcl::Graphics::TBitmap* FBack;
	Lmdtypes::TLMDString FText;
	bool FCursor2EndOnSelectAll;
	bool FUserSelect;
	bool FOutBuffered;
	bool FSelMode;
	bool FSettingText;
	bool FNoSelection;
	System::Types::TRect FInnerRect;
	System::Types::TRect FPaintRect;
	System::Types::TRect FTextRect;
	int FCurrentChar;
	int FLineStart;
	int FLineEnd;
	int FSelStart;
	int FHiddenLeft;
	bool FIsDeleting;
	int FFoundAtPos;
	bool FSearching;
	bool FIsPasting;
	virtual Lmdtypes::TLMDString __fastcall GetEmptyText(void);
	void __fastcall SetValidationMsgString(Lmdtypes::TLMDString val);
	Lmdtypes::TLMDString __fastcall GetValidationMsgString(void);
	HIDESBASE Vcl::Controls::TControl* __fastcall GetControl(void);
	Vcl::Graphics::TBrush* __fastcall GetControlBackBrush(void);
	Vcl::Graphics::TFont* __fastcall GetControlFont(void);
	virtual Lmdtypes::TLMDString __fastcall GetValueToValidate(void);
	virtual void __fastcall SetupRects(void);
	virtual void __fastcall CreateBack(void);
	virtual void __fastcall FillControl(void);
	DYNAMIC void __fastcall GetCommandKey(System::Word &KeyCode, System::Classes::TShiftState Shift);
	virtual int __fastcall CalcMouseCol(int XPos) = 0 ;
	virtual int __fastcall CalcMouseRow(int YPos) = 0 ;
	virtual void __fastcall DoAlignmentChange(void);
	virtual void __fastcall SetCaret(void) = 0 ;
	virtual bool __fastcall BackOneMore(void);
	virtual void __fastcall Change(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual bool __fastcall GetReadOnly(void);
	virtual void __fastcall SetNewText(void) = 0 ;
	virtual void __fastcall GetNewText(void) = 0 ;
	virtual void __fastcall DrawEditText(int from) = 0 ;
	virtual int __fastcall CalcMousePos(System::Types::TSmallPoint Pos) = 0 ;
	virtual int __fastcall RowHeight(Lmdtypes::TLMDString s);
	int __fastcall RowWidth(Lmdtypes::TLMDString s);
	virtual void __fastcall CursorPosChanged(void);
	virtual void __fastcall ChangedText(int At);
	virtual void __fastcall BeforeChangeText(void);
	virtual void __fastcall FinishedSetSelText(void);
	virtual void __fastcall HandleInsertText(int at, Lmdtypes::TLMDString &aValue);
	virtual void __fastcall HandleReplaceText(int at, Lmdtypes::TLMDString aValue);
	virtual void __fastcall RepaintBack(const System::Types::TRect &aRect);
	virtual bool __fastcall AllowedOperation(Lmdtypes::TLMDString textToInsert);
	void __fastcall DoDestroyBufferEntry(System::TObject* Sender, void * item);
	virtual bool __fastcall AllowCopyPaste(void);
	virtual bool __fastcall RedrawOnExit(void);
	virtual bool __fastcall RedrawOnEnter(void);
	virtual void __fastcall DoThemeChanged(void);
	void __fastcall SetLMDCaretPos(int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall RestoreBorderFront(void);
	DYNAMIC void __fastcall RestoreBorderBack(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetName(const System::Classes::TComponentName Value);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DestroyWindowHandle(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	virtual bool __fastcall fcGetModified(void);
	virtual bool __fastcall fcGetReadOnly(void);
	virtual bool __fastcall fcGetInvalidData(void);
	__property Lmdboundlabel::TLMDBoundLabel* EditLabel = {read=FEditLabel};
	__property int LabelSpacing = {read=FLabelSpacing, write=SetLabelSpacing, default=3};
	__property bool HasBoundLabel = {read=FHasBoundLabel, write=SetHasLabel, nodefault};
	virtual bool __fastcall GetListMode(void);
	void __fastcall FreeTimer(void);
	virtual void __fastcall ModifyTextRect(void);
	virtual void __fastcall ModifyPaintRect(void);
	virtual void __fastcall ModifyInnerRect(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Msg);
	void __fastcall TriggerTripleClick(void);
	__property bool Undoing = {read=FUndoing, nodefault};
	__property bool TabOnEnter = {read=FTabEnter, write=FTabEnter, default=0};
	__property Vcl::Extctrls::TLabelPosition LabelPosition = {read=FLabelPosition, write=SetLabelPosition, default=0};
	__property bool LabelSync = {read=FLabelSync, write=SetLabelSync, default=0};
	__property bool DraggingAllowed = {read=FDraggingAllowed, write=FDraggingAllowed, default=1};
	__property bool EnableKeyInput = {read=FEnableKeyInput, write=FEnableKeyInput, nodefault};
	__property TLMDEditOptions Options = {read=FOptions, write=SetOptions, default=56};
	System::UnicodeString __fastcall ToUpperCase(const System::UnicodeString S);
	System::UnicodeString __fastcall ToLowerCase(const System::UnicodeString S);
	
public:
	__fastcall virtual TLMDBaseEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDBaseEdit(void);
	bool __fastcall SupportsDefaultIndication(void);
	__property Vcl::Graphics::TFont* ControlFont = {read=GetControlFont};
	__property Vcl::Graphics::TBrush* ControlBackBrush = {read=GetControlBackBrush};
	void __fastcall RespondToError(int ErrorLevel);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* Validator);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	virtual void __fastcall EndUpdate(bool repaint = false);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall SetupEditLabel(void);
	void __fastcall SetSelection(void);
	virtual void __fastcall SelectCurrentWord(void);
	void __fastcall SelectRightWord(void);
	void __fastcall SelectLeftWord(void);
	void __fastcall SetSelTextBuf(System::WideChar * Buffer);
	virtual int __fastcall GetSelTextBuf(System::WideChar * Buffer, int BufSize);
	bool __fastcall Search(Lmdtypes::TLMDString s, TLMDSearchStart from, bool caseSensitive, bool wholeWords, TLMDSearchDirection direction);
	bool __fastcall SearchAndReplace(Lmdtypes::TLMDString s, Lmdtypes::TLMDString r, TLMDSearchStart from, bool caseSensitive, bool wholeWords, TLMDSearchDirection direction, bool ask, bool all);
	int __fastcall FoundAtPos(void);
	void __fastcall GotoParaStart(void);
	void __fastcall GotoParaEnd(void);
	void __fastcall GotoNextWord(void);
	void __fastcall GotoPrevWord(void);
	Lmdtypes::TLMDString __fastcall GetCurrentWord(void);
	int __fastcall GetLength(void);
	int __fastcall CountWords(void);
	void __fastcall Replace(int start, int count, Lmdtypes::TLMDString s);
	void __fastcall Upper(int start, int count);
	void __fastcall Lower(int start, int count);
	Lmdtypes::TLMDString __fastcall Cut(int start, int count);
	void __fastcall Add(const Lmdtypes::TLMDString S);
	HIDESBASE void __fastcall Insert(int at, const Lmdtypes::TLMDString S);
	Lmdtypes::TLMDString __fastcall Copy(int start, int count);
	void __fastcall SelectAll(void);
	virtual void __fastcall Clear(void);
	void __fastcall ClearSelection(void);
	void __fastcall CopyToClipboard(void);
	virtual void __fastcall CutToClipboard(void);
	virtual void __fastcall PasteFromClipboard(void);
	void __fastcall Undo(void);
	void __fastcall ClearUndo(void);
	void __fastcall Redo(void);
	__property Lmdtypes::TLMDString Text = {read=GetText, write=pSetText, stored=true};
	__property int CurrentChar = {read=FCurrentChar, write=SetInteger, index=5, nodefault};
	__property TLMDDelimiters Delimiters = {read=FDelimiters, write=FDelimiters};
	__property Font;
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3D};
	__property int MaxLength = {read=FMaxLength, write=SetInteger, index=0, default=0};
	__property int SelStart = {read=FSelStart, write=SetInteger, index=1, default=0};
	__property int SelLength = {read=FSelLength, write=SetInteger, index=2, default=0};
	__property int FirstLine = {read=FFirstLine, nodefault};
	__property Lmdtypes::TLMDString SelText = {read=GetSelText, write=SetSelText};
	__property bool HideSelection = {read=GetBoolean, write=SetBoolean, index=0, default=1};
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property bool ReadOnly = {read=GetBoolean, write=SetBoolean, index=1, default=0};
	__property bool Modified = {read=GetBoolean, write=SetBoolean, index=2, default=0};
	__property bool AutoSelect = {read=GetBoolean, write=SetBoolean, index=4, default=0};
	__property bool OEMConvert = {read=GetBoolean, write=SetBoolean, index=5, default=0};
	__property System::Uitypes::TEditCharCase CharCase = {read=FCharCase, write=SetCharCase, default=0};
	__property bool AskForLoop = {read=FAskForLoop, write=FAskForLoop, default=1};
	__property CtlXP = {default=1};
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property BackFX;
	__property FaceController;
	__property System::Uitypes::TColor HighlightBack = {read=FHighBackColor, write=FHighBackColor, default=-16777203};
	__property System::Uitypes::TColor HighlightText = {read=FHighTextColor, write=FHighTextColor, default=-16777202};
	__property Bevel;
	__property bool FocusOnMouseAbove = {read=GetBoolean, write=SetBoolean, index=6, default=0};
	__property Lmdcaret::TLMDCaret* Caret = {read=FCaret, write=SetCaretVal};
	__property Color = {default=-16777211};
	__property Cursor = {default=-4};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Flat = {default=0};
	__property Hint;
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property ListIndex = {index=1, default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentThemeMode = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Tag = {default=0};
	__property Transparent = {default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property bool UseGlobalTimer = {read=FUseGlobalTimer, write=FUseGlobalTimer, default=0};
	__property Visible = {default=1};
	__property System::Classes::TNotifyEvent OnCursorPosChanged = {read=FOnCursorPosChanged, write=FOnCursorPosChanged};
	__property TLMDTextChangeEvent OnTextChangedAt = {read=FOnTextChange, write=FOnTextChange};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property System::Classes::TNotifyEvent OnModified = {read=FOnModified, write=FOnModified};
	__property OnContextPopup;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnAfterEnter;
	__property OnAfterExit;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseWheel;
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property Lmdtypes::TLMDString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=FOnValidationError, write=FOnValidationError};
	__property OnGesture;
	__property Touch;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDBaseEdit(HWND ParentWindow) : Lmdcustombevelpanel::TLMDCustomBevelPanel(ParentWindow) { }
	
private:
	void *__ILMDValidatedControl;	// Lmdvldbase::ILMDValidatedControl 
	void *__ILMDFaceControllerEditable;	// Intflmdfacecontrollereditable::ILMDFaceControllerEditable 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {ED0CAB4C-DBF2-4078-8C06-000841566690}
	operator Lmdvldbase::_di_ILMDValidatedControl()
	{
		Lmdvldbase::_di_ILMDValidatedControl intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdvldbase::ILMDValidatedControl*(void) { return (Lmdvldbase::ILMDValidatedControl*)&__ILMDValidatedControl; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {4CF92C4B-8694-477D-8E1E-2F6A2EAAE960}
	operator Intflmdfacecontrollereditable::_di_ILMDFaceControllerEditable()
	{
		Intflmdfacecontrollereditable::_di_ILMDFaceControllerEditable intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdfacecontrollereditable::ILMDFaceControllerEditable*(void) { return (Intflmdfacecontrollereditable::ILMDFaceControllerEditable*)&__ILMDFaceControllerEditable; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbaseedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBASEEDIT)
using namespace Lmdbaseedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbaseeditHPP
