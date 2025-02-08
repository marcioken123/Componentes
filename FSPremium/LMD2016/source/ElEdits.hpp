// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElEdits.pas' rev: 31.00 (Windows)

#ifndef EleditsHPP
#define EleditsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <System.Math.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Clipbrd.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Themes.hpp>
#include <System.Types.hpp>
#include <Winapi.Imm.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDUnicode.hpp>
#include <LMDStrings.hpp>
#include <LMDTypes.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDElConst.hpp>
#include <LMDSysIn.hpp>
#include <LMDProcs.hpp>
#include <LMDGraph.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDUtils.hpp>
#include <LMDObjectList.hpp>
#include <LMDClass.hpp>
#include <LMDVldBase.hpp>
#include <LMDThemes.hpp>
#include <ElImgFrm.hpp>
#include <ElStack.hpp>
#include <ElVCLUtils.hpp>
#include <ElXPThemedControl.hpp>
#include <ElSBCtrl.hpp>
#include <ElInputProcessor.hpp>
#include <ElEditCmds.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eledits
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS EElEditorError;
struct TElBookmark;
class DELPHICLASS TElAction;
class DELPHICLASS TElActionList;
class DELPHICLASS TElParagraph;
class DELPHICLASS TElParagraphList;
class DELPHICLASS TElEditStrings;
class DELPHICLASS TElTextPainter;
class DELPHICLASS TElWinTextPainter;
class DELPHICLASS TCustomElEdit;
class DELPHICLASS TCustomElMemo;
class DELPHICLASS TElMemo;
class DELPHICLASS TElEdit;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION EElEditorError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EElEditorError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EElEditorError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EElEditorError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EElEditorError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EElEditorError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EElEditorError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EElEditorError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EElEditorError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElEditorError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElEditorError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElEditorError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElEditorError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EElEditorError(void) { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TElBookmark
{
public:
	int FX;
	int FY;
};


enum DECLSPEC_DENUM TElActionType : unsigned char { atInsert, atDelete, atLineBreak, atGroupBreak, atPaste, atBackSpace, atDeleteSel, atInsertSel };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElAction : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	TElActionType FAction;
	System::Types::TPoint FStartPos;
	System::Types::TPoint FEndPos;
	Lmdtypes::TLMDString FStr;
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property TElActionType Action = {read=FAction, nodefault};
	__property Lmdtypes::TLMDString CString = {read=FStr};
	__property System::Types::TPoint EndPos = {read=FEndPos};
	__property System::Types::TPoint StartPos = {read=FStartPos};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElAction(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElAction(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElActionList : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	Elstack::TElStack* FAStack;
	int FMaxUndo;
	int FLockCount;
	virtual bool __fastcall GetCanUndo(void);
	virtual void __fastcall SetMaxUndo(const int Value);
	
public:
	__fastcall TElActionList(void);
	__fastcall virtual ~TElActionList(void);
	TElAction* __fastcall PeekItem(void);
	TElAction* __fastcall PopItem(void);
	void __fastcall Clear(void);
	void __fastcall AddAction(TElActionType AAction, const System::Types::TPoint &ASPos, const System::Types::TPoint &AEPos, Lmdtypes::TLMDString AStr);
	void __fastcall Lock(void);
	void __fastcall PushItem(TElAction* Item);
	void __fastcall UnLock(void);
	__property bool CanUndo = {read=GetCanUndo, nodefault};
	__property int MaxUndo = {read=FMaxUndo, write=SetMaxUndo, default=0};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElParagraph : public System::Classes::TStringList
{
	typedef System::Classes::TStringList inherited;
	
protected:
	int FPCount;
	virtual System::UnicodeString __fastcall Get(int Index);
	virtual System::UnicodeString __fastcall GetTextStr(void);
	virtual void __fastcall Put(int Index, const System::UnicodeString S);
	virtual void __fastcall SetTextStr(const System::UnicodeString Value);
	
public:
	__property System::UnicodeString Text = {read=GetTextStr, write=SetTextStr};
public:
	/* TStringList.Create */ inline __fastcall TElParagraph(void)/* overload */ : System::Classes::TStringList() { }
	/* TStringList.Create */ inline __fastcall TElParagraph(bool OwnsObjects)/* overload */ : System::Classes::TStringList(OwnsObjects) { }
	/* TStringList.Create */ inline __fastcall TElParagraph(System::WideChar QuoteChar, System::WideChar Delimiter)/* overload */ : System::Classes::TStringList(QuoteChar, Delimiter) { }
	/* TStringList.Create */ inline __fastcall TElParagraph(System::WideChar QuoteChar, System::WideChar Delimiter, System::Classes::TStringsOptions Options)/* overload */ : System::Classes::TStringList(QuoteChar, Delimiter, Options) { }
	/* TStringList.Create */ inline __fastcall TElParagraph(System::Types::TDuplicates Duplicates, bool Sorted, bool CaseSensitive)/* overload */ : System::Classes::TStringList(Duplicates, Sorted, CaseSensitive) { }
	/* TStringList.Destroy */ inline __fastcall virtual ~TElParagraph(void) { }
	
};


class PASCALIMPLEMENTATION TElParagraphList : public Lmdobjectlist::TLMDObjectList
{
	typedef Lmdobjectlist::TLMDObjectList inherited;
	
public:
	TElParagraph* operator[](int Index) { return this->Items[Index]; }
	
protected:
	HIDESBASE TElParagraph* __fastcall Get(int Index);
	HIDESBASE void __fastcall Put(int Index, TElParagraph* const Value);
	HIDESBASE void __fastcall Delete(int Index);
	
public:
	virtual void __fastcall Clear(void);
	__property TElParagraph* Items[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TLMDObjectList.Create */ inline __fastcall TElParagraphList(void) : Lmdobjectlist::TLMDObjectList() { }
	/* TLMDObjectList.Destroy */ inline __fastcall virtual ~TElParagraphList(void) { }
	
};


class PASCALIMPLEMENTATION TElEditStrings : public System::Classes::TStringList
{
	typedef System::Classes::TStringList inherited;
	
private:
	TCustomElEdit* FElEdit;
	System::Classes::TStringList* RealStrings;
	
protected:
	int FMaxLen;
	int FIdxMaxLen;
	Lmdtypes::TLMDString FMaxStr;
	Lmdtypes::TLMDString FSaveStr;
	System::Classes::TNotifyEvent FOnChange;
	TElParagraphList* FParagraphs;
	void __fastcall Reformat(void);
	virtual void __fastcall Changed(void);
	virtual System::UnicodeString __fastcall Get(int Index);
	virtual void __fastcall Put(int Index, const System::UnicodeString S);
	virtual void __fastcall SetTextStr(const System::UnicodeString Value);
	virtual System::UnicodeString __fastcall GetTextStr(void);
	virtual void __fastcall PutObject(int Index, System::TObject* AObject);
	virtual System::TObject* __fastcall GetObject(int Index);
	virtual int __fastcall GetCount(void);
	void __fastcall ReformatParagraph(int Index);
	void __fastcall ReCount(int Index);
	Lmdtypes::TLMDString __fastcall GetParaString(int Index);
	void __fastcall SetParaString(int Index, const Lmdtypes::TLMDString Value);
	int __fastcall GetParaCount(void);
	
public:
	__fastcall TElEditStrings(void);
	__fastcall virtual ~TElEditStrings(void);
	virtual void __fastcall AddStrings(System::Classes::TStrings* Strings)/* overload */;
	virtual int __fastcall Add(const System::UnicodeString S);
	virtual void __fastcall Insert(int Index, const System::UnicodeString S);
	void __fastcall InsertText(int &ACaretX, int &ACaretY, const System::UnicodeString S);
	virtual bool __fastcall Find(const System::UnicodeString S, int &Index);
	virtual void __fastcall Clear(void);
	virtual void __fastcall Delete(int Index);
	virtual void __fastcall Exchange(int Index1, int Index2);
	void __fastcall IndexToParagraph(int index, int &Paragraph, int &ParaIndex);
	void __fastcall CaretToParagraph(int ACaretX, int ACaretY, int &Paragraph, int &ParaOffs);
	void __fastcall CaretFromParagraph(int Paragraph, int ParaOffs, int &ACaretX, int &ACaretY);
	Lmdtypes::TLMDString __fastcall GetReText(void);
	Lmdtypes::TLMDString __fastcall CutString(Lmdtypes::TLMDString &S, int Len, bool &RealStr);
	__property Lmdtypes::TLMDString ParagraphStrings[int Index] = {read=GetParaString, write=SetParaString};
	__property int ParagraphCount = {read=GetParaCount, nodefault};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  AddStrings(const System::DynamicArray<System::UnicodeString> Strings){ System::Classes::TStrings::AddStrings(Strings); }
	inline void __fastcall  AddStrings(const System::DynamicArray<System::UnicodeString> Strings, const System::DynamicArray<System::TObject*> Objects){ System::Classes::TStrings::AddStrings(Strings, Objects); }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElTextPainter : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	System::Uitypes::TColor FBkColor;
	System::Uitypes::TColor FColor;
	Vcl::Graphics::TFont* FFont;
	TCustomElEdit* FEditor;
	virtual void __fastcall SetColor(const System::Uitypes::TColor AColor);
	virtual void __fastcall SetBkColor(const System::Uitypes::TColor ABkColor);
	virtual bool __fastcall ExtTextOut(Vcl::Graphics::TCanvas* const ACanvas, int X, int Y, int Options, System::Types::PRect Rect, Lmdtypes::TLMDString Str, int Count) = 0 ;
	virtual bool __fastcall GetTextExtentExPoint(Vcl::Graphics::TCanvas* const ACanvas, System::WideChar * lpszStr, int cchString, int nMaxExtent, int &lpnFit, System::PInteger alpDX, System::Types::TSize &lpSize) = 0 ;
	
public:
	__fastcall TElTextPainter(TCustomElEdit* AEditor);
	__fastcall virtual ~TElTextPainter(void);
	virtual int __fastcall CharsFitRight(int AWidth, Lmdtypes::TLMDString FText, int StartPos);
	virtual int __fastcall CharsFitLeft(int AWidth, Lmdtypes::TLMDString FText, int StartPos);
	virtual System::Types::TSize __fastcall TextSize(Lmdtypes::TLMDString ALine) = 0 ;
	virtual void __fastcall DrawTabbedText(Vcl::Graphics::TCanvas* const ACanvas, int X, int Y, const System::Types::TRect &ARect, Lmdtypes::TLMDString AText, System::Types::TSize &Size);
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property System::Uitypes::TColor BkColor = {read=FBkColor, write=SetBkColor, nodefault};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=FFont};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElWinTextPainter : public TElTextPainter
{
	typedef TElTextPainter inherited;
	
protected:
	virtual bool __fastcall ExtTextOut(Vcl::Graphics::TCanvas* const ACanvas, int X, int Y, int Options, System::Types::PRect Rect, Lmdtypes::TLMDString Str, int Count);
	virtual bool __fastcall GetTextExtentExPoint(Vcl::Graphics::TCanvas* const ACanvas, System::WideChar * lpszStr, int cchString, int nMaxExtent, int &lpnFit, System::PInteger alpDX, System::Types::TSize &lpSize);
	
public:
	virtual System::Types::TSize __fastcall TextSize(Lmdtypes::TLMDString ALine);
public:
	/* TElTextPainter.Create */ inline __fastcall TElWinTextPainter(TCustomElEdit* AEditor) : TElTextPainter(AEditor) { }
	/* TElTextPainter.Destroy */ inline __fastcall virtual ~TElWinTextPainter(void) { }
	
};

#pragma pack(pop)

using Elinputprocessor::TElEditCharCase;

enum DECLSPEC_DENUM TElEditScrollDir : unsigned char { esdLineUp, esdLineDown, esdPageUp, esdPageDown };

typedef void __fastcall (__closure *TElKeyPressExEvent)(System::TObject* Sender, Lmdtypes::TLMDString &Key);

typedef void __fastcall (__closure *TElPasteClipboardEvent)(System::TObject* Sender, Lmdtypes::TLMDString &AClipboardText);

typedef void __fastcall (*TElCommandEvent)(System::TObject* Sender, Eleditcmds::TElCommand &ACommand, System::WideChar &AChar, void * &AData);

class PASCALIMPLEMENTATION TCustomElEdit : public Elxpthemedcontrol::TElXPThemedControl
{
	typedef Elxpthemedcontrol::TElXPThemedControl inherited;
	
protected:
	Elsbctrl::TElSBController* fSBCtrl;
	Elsbctrl::TElCtrlScrollBarStyles* __fastcall GetHorzScrollBar(void);
	Elsbctrl::TElCtrlScrollBarStyles* __fastcall GetVertScrollBar(void);
	void __fastcall SetHorzScrollBar(Elsbctrl::TElCtrlScrollBarStyles* const Value);
	void __fastcall SetVertScrollBar(Elsbctrl::TElCtrlScrollBarStyles* const Value);
	__property Elsbctrl::TElCtrlScrollBarStyles* scbVert = {read=GetVertScrollBar};
	__property Elsbctrl::TElCtrlScrollBarStyles* scbHorz = {read=GetHorzScrollBar};
	__property Elsbctrl::TElSBController* SBCtrl = {read=fSBCtrl};
	System::Uitypes::TScrollStyle FScrollBarsAutoShowing;
	Lmdvldbase::TLMDValidationEntity* FValidator;
	System::UnicodeString FValidationMsgString;
	bool FErrorIndication;
	Lmdvldbase::TLMDValidationErrorEvent FOnValidationError;
	bool FModified;
	System::Types::TRect FEditRect;
	int FLeftMargin;
	int FTopMargin;
	int FRightMargin;
	bool FMouseClick;
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	bool FAutoSelect;
	System::Classes::TAlignment FAlignment;
	bool FReadOnly;
	bool FWantTabs;
	System::WideChar FPasswordChar;
	int FMaxLength;
	bool FSelected;
	int FSelLength;
	int FSelStartX;
	int FSelStartY;
	int FSelFirstX;
	int FSelFirstY;
	int FSelLastX;
	int FSelLastY;
	bool FMultiline;
	bool FUserChangesOnly;
	bool FTransparent;
	Lmdtypes::TLMDString FTabString;
	int FTabSpaces;
	bool FHasCaret;
	int FCaretX;
	int FCaretY;
	bool FUpdate;
	Lmdtypes::TLMDString FCueBanner;
	TElActionList* FUndo;
	TElActionList* FRedo;
	TElTextPainter* FTextPainter;
	int FModifyCount;
	int FLineHeight;
	int FLeftChar;
	int FCharsInView;
	bool FSelecting;
	System::Classes::TNotifyEvent FOnChange;
	System::Classes::TNotifyEvent FOnSelectionChange;
	bool ForceLeftAlignment;
	Vcl::Graphics::TBitmap* FBackground;
	bool FUseBackground;
	Elimgfrm::TElImageForm* FImgForm;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	Lmdgraph::TLMDBorderSides FBorderSides;
	Elvclutils::TElFlatBorderType FActiveBorderType;
	bool FFlat;
	Elvclutils::TElFlatBorderType FInactiveBorderType;
	bool FHandleDialogKeys;
	bool FMouseOver;
	System::Classes::TNotifyEvent FOnMouseEnter;
	System::Classes::TNotifyEvent FOnMouseLeave;
	int FDoubleClickCX;
	int FDoubleClickCY;
	unsigned FLastClickTime;
	unsigned FDoubleClickTimeout;
	int FFirstClickX;
	int FFirstClickY;
	System::Byte FClickCount;
	TElEditStrings* FElEditList;
	int FTopLine;
	bool FWordWrap;
	System::Uitypes::TScrollStyle FScrollBars;
	int FLinesInRect;
	int FCharset;
	bool FFlatFocusedScrollBars;
	bool FUseCustomScrollBars;
	bool FIgnoreReadOnlyState;
	bool FAlienFocus;
	bool FAlignBottom;
	Elinputprocessor::TElDeadCharList* FDeadCharList;
	System::WideString FKeys;
	System::WideChar FDeadChar;
	int FCDead;
	bool FKeyDown;
	Lmdtypes::TLMDString FHint;
	int FAscent;
	int FDescent;
	System::Types::TPoint FMouseDownPos;
	bool FWaitForDragging;
	bool FDragging;
	bool FDragAllowed;
	System::Uitypes::TCursor FSaveCursor;
	System::StaticArray<TElBookmark, 10> FBookmarks;
	bool FRightAlignedText;
	bool FRightAlignedView;
	bool FAutoSize;
	System::Uitypes::TColor FLineBorderActiveColor;
	System::Uitypes::TColor FLineBorderInactiveColor;
	bool FNotifyUserChangeOnly;
	Elinputprocessor::TElEditCharCase FCharCase;
	bool FEnd;
	bool FWantReturns;
	bool FUseSystemMenu;
	bool FLocalizedSystemMenu;
	bool FHideSelection;
	System::Uitypes::TColor FFocusedSelectColor;
	System::Uitypes::TColor FFocusedSelectTextColor;
	System::Uitypes::TColor FHideSelectColor;
	System::Uitypes::TColor FHideSelectTextColor;
	int FHighlightAlphaLevel;
	Vcl::Controls::TControl* FLinkedControl;
	Elvclutils::TElLinkCtlPos FLinkedControlPosition;
	int FLinkedControlSpacing;
	bool FUseDisabledColors;
	System::Uitypes::TColor FDisabledColor;
	System::Uitypes::TColor FDisabledFontColor;
	TElKeyPressExEvent FOnKeyPressEx;
	TElPasteClipboardEvent FOnPasteClipboardText;
	System::Classes::TNotifyEvent FOnAfterPasteClipboardText;
	System::Uitypes::TColor FBorderColorDkShadow;
	System::Uitypes::TColor FBorderColorFace;
	System::Uitypes::TColor FBorderColorShadow;
	System::Uitypes::TColor FBorderColorHighlight;
	System::Uitypes::TColor FBorderColorWindow;
	bool FForceSetCaretX;
	Elvclutils::TElDisplayOptions* FDisplayReadOnlyOptions;
	Eleditcmds::TElKeyCommandList* FCommandCenter;
	System::Word FFirstKey;
	System::Classes::TShiftState FFirstShift;
	TElCommandEvent FOnBeforeCommand;
	TElCommandEvent FOnAfterCommand;
	System::Classes::TShortCut FStressShortCut;
	virtual void __fastcall AdjustFocusedRect(System::Types::TRect &aRect);
	void __fastcall SetScrollBarsAutoShowing(const System::Uitypes::TScrollStyle Value);
	void __fastcall SetValidationMsgString(Lmdtypes::TLMDString val);
	Lmdtypes::TLMDString __fastcall GetValidationMsgString(void);
	HIDESBASE Vcl::Controls::TControl* __fastcall GetControl(void);
	Vcl::Graphics::TBrush* __fastcall GetControlBackBrush(void);
	Vcl::Graphics::TFont* __fastcall GetControlFont(void);
	Lmdtypes::TLMDString __fastcall GetValueToValidate(void);
	void __fastcall SetStressShortCut(System::Classes::TShortCut Value);
	void __fastcall TriggerTripleClick(void);
	virtual void __fastcall DrawEditText(Vcl::Graphics::TCanvas* Canvas, int fl, Lmdtypes::TLMDString FText, const System::Types::TSize &ATS, int sx, int sy);
	bool __fastcall ScrollBarStylesStored(void);
	void __fastcall SetDisplayReadOnlyOptions(Elvclutils::TElDisplayOptions* const Value);
	virtual void __fastcall DisplayOptionsChange(System::TObject* Sender);
	MESSAGE void __fastcall ELSettingChange(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall WMCaptureChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMCut(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall WMCopy(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall WMPaste(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall WMClear(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall WMGetText(Winapi::Messages::TWMGetText &Message);
	MESSAGE void __fastcall WMGetTextLength(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMSetText(Winapi::Messages::TWMSetText &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	void __fastcall PaintBackground(void);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	MESSAGE void __fastcall WMEnable(Winapi::Messages::TWMEnable &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Msg);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Winapi::Messages::TWMScroll &Msg);
	HIDESBASE MESSAGE void __fastcall WMInputLangChange(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMCommand(Winapi::Messages::TWMCommand &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Msg);
	MESSAGE void __fastcall EMSetRect(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMSetRectNP(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMImeStartComposition(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMImeComposition(Winapi::Messages::TMessage &Message);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Msg);
	void __fastcall OnHScroll(System::TObject* Sender, Elsbctrl::TElScrollCode ScrollCode, int &ScrollPos, bool &DoChange);
	void __fastcall OnVScroll(System::TObject* Sender, Elsbctrl::TElScrollCode ScrollCode, int &ScrollPos, bool &DoChange);
	void __fastcall SBChanged(System::TObject* Sender);
	virtual void __fastcall SetReadOnly(bool newValue);
	virtual bool __fastcall GetReadOnly(void);
	void __fastcall SetAlignment(System::Classes::TAlignment newValue);
	void __fastcall SetLeftMargin(int newValue);
	void __fastcall SetRightMargin(int newValue);
	void __fastcall SetBorderStyle(Vcl::Forms::TBorderStyle newValue);
	void __fastcall SetTransparent(bool newValue);
	virtual void __fastcall SetHideSelection(bool newValue);
	Lmdtypes::TLMDString __fastcall GetPasswordChar(void);
	void __fastcall SetPasswordChar(Lmdtypes::TLMDString newValue);
	void __fastcall DoSetEditRect(const System::Types::TRect &newValue);
	void __fastcall SetTabSpaces(int newValue);
	void __fastcall SetModified(bool newValue);
	Lmdtypes::TLMDString __fastcall GetSelectedText(void);
	void __fastcall SetBackground(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetUseBackground(const bool Value);
	void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	void __fastcall ImageFormChange(System::TObject* Sender);
	DYNAMIC void __fastcall DragCanceled(void);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall DrawBackground(HDC DC, const System::Types::TRect &R);
	void __fastcall DrawFlatBorder(void);
	void __fastcall DrawParentControl(HDC DC);
	void __fastcall SetScrollBars(const System::Uitypes::TScrollStyle Value);
	void __fastcall SetTopLine(const int Value);
	void __fastcall SetCueBanner(const Lmdtypes::TLMDString Value);
	void __fastcall UpdateHeight(void);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	void __fastcall BackgroundChanged(System::TObject* Sender);
	void __fastcall SetFlatFocusedScrollBars(const bool Value);
	void __fastcall SetUseCustomScrollBars(bool newValue);
	virtual void __fastcall SetMaxLength(int newValue);
	virtual int __fastcall GetSelStart(void);
	virtual void __fastcall SetSelStart(int newValue);
	virtual void __fastcall SetSelLength(int newValue);
	virtual int __fastcall GetSelLength(void);
	virtual void __fastcall SetSelText(const Lmdtypes::TLMDString newValue);
	Lmdtypes::TLMDString __fastcall StringToPassword(Lmdtypes::TLMDString AString);
	Lmdtypes::TLMDString __fastcall ExpandTabbedString(Lmdtypes::TLMDString Text);
	void __fastcall SetScrollBarsInfo(void);
	void __fastcall MoveCaret(int CharNum);
	void __fastcall MakeCaret(void);
	void __fastcall RepaintText(const System::Types::TRect &Rect);
	void __fastcall DrawTabbedText(Vcl::Graphics::TCanvas* const ACanvas, int X, int Y, Lmdtypes::TLMDString AText, System::Types::TSize &Size);
	int __fastcall CharsFitRight(int AWidth, Lmdtypes::TLMDString FText, int StartPos);
	int __fastcall CharsFitLeft(int AWidth, Lmdtypes::TLMDString FText, int StartPos);
	virtual int __fastcall GetRightOffsetForBackground(void);
	virtual void __fastcall Change(void);
	virtual void __fastcall TriggerSelectionChangeEvent(void);
	virtual void __fastcall TriggerBeforeCommand(void * AData, System::WideChar AChar, Eleditcmds::TElCommand ACommand);
	virtual void __fastcall TriggerAfterCommand(void * AData, System::WideChar AChar, Eleditcmds::TElCommand ACommand);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall Paint(void);
	virtual void __fastcall PaintText(Vcl::Graphics::TCanvas* Canvas);
	virtual void __fastcall PaintCueBanner(Vcl::Graphics::TCanvas* Canvas);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	bool __fastcall IsCursorUnderSelection(int AX, int AY);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	virtual void __fastcall SetFlat(const bool Value);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual Vcl::Themes::TThemedElement __fastcall GetThemedElement(void);
	int __fastcall GetLinesCount(void);
	void __fastcall SetWordWrap(bool Value);
	void __fastcall SetLeftChar(int Value);
	virtual void __fastcall SetAutoSize(bool Value);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	void __fastcall SetLines(System::Classes::TStrings* Value);
	System::Classes::TStrings* __fastcall GetLines(void);
	void __fastcall SetTopMargin(int Value);
	void __fastcall SetAlignBottom(bool Value);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	virtual void __fastcall DoMouseEnter(void);
	virtual void __fastcall DoMouseLeave(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetActiveBorderType(const Elvclutils::TElFlatBorderType Value);
	virtual void __fastcall SetInactiveBorderType(const Elvclutils::TElFlatBorderType Value);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	void __fastcall SetCharCase(Elinputprocessor::TElEditCharCase Value);
	void __fastcall SetSelection(int SelX, int SelY);
	void __fastcall UnSelect(void);
	void __fastcall DeleteSelection(void);
	void __fastcall InsertText(const Lmdtypes::TLMDString AText);
	MESSAGE void __fastcall WMDeadChar(Winapi::Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMUniChar(Winapi::Messages::TMessage &Msg);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	void __fastcall SetBottomAlign(void);
	HIDESBASE Lmdtypes::TLMDString __fastcall GetText(void);
	Lmdtypes::TLMDString __fastcall ConvertToCRLF(Lmdtypes::TLMDString Str);
	void __fastcall SetCaretX(const int value);
	void __fastcall SetCaretY(const int value);
	System::Types::TPoint __fastcall GetCaretXY(void);
	void __fastcall SetCaretXY(const System::Types::TPoint &value);
	void __fastcall CorrectLeftChar(void);
	void __fastcall SetCaretPosition(const int X, const int Y);
	void __fastcall SetMultiline(const bool Value);
	void __fastcall SetMaxLevel(const int Value);
	int __fastcall GetMaxLevel(void);
	virtual TElTextPainter* __fastcall CreateTextPainter(void);
	MESSAGE void __fastcall EMGetSel(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMGetLine(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMGetLineCount(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMLineIndex(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMSetSel(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMReplaceSel(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMGetFirstVisibleLine(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMScroll(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMLineScroll(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMScrollCaret(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMLineFromChar(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMPosFromChar(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMCanUndo(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall EMUndo(Winapi::Messages::TMessage &Message);
	virtual void __fastcall SetEditRect(const System::Types::TRect &Value);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadRTLContent(System::Classes::TReader* Reader);
	virtual void __fastcall SetRightAlignedView(bool Value);
	virtual void __fastcall SetRightAlignedText(bool Value);
	virtual void __fastcall SetFocusedSelectColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetFocusedSelectTextColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetHideSelectColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetHideSelectTextColor(System::Uitypes::TColor Value);
	virtual void __fastcall DoChange(void);
	virtual void __fastcall SetHighlightAlphaLevel(int Value);
	void __fastcall SetLinkedControl(Vcl::Controls::TControl* Value);
	void __fastcall UpdateLinkedControl(void);
	void __fastcall SetLinkedControlPosition(Elvclutils::TElLinkCtlPos Value);
	void __fastcall SetLinkedControlSpacing(int Value);
	System::Types::TRect __fastcall AdjustRectSB(const System::Types::TRect &ARect);
	void __fastcall SetUseDisabledColors(bool Value);
	void __fastcall SetDisabledColor(System::Uitypes::TColor Value);
	void __fastcall SetDisabledFontColor(System::Uitypes::TColor Value);
	void __fastcall ReadChangeDisabledText(System::Classes::TReader* Reader);
	bool __fastcall HasCustomBackground(void);
	void __fastcall ReadLinkCtlPos(System::Classes::TReader* Reader);
	virtual void __fastcall TriggerKeyPressEx(Lmdtypes::TLMDString &Key);
	HIDESBASE MESSAGE void __fastcall WMContextMenu(Winapi::Messages::TWMContextMenu &Message);
	void __fastcall SetBorderColorDkShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorFace(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorHighlight(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorWindow(System::Uitypes::TColor Value);
	virtual System::Uitypes::TColor __fastcall GetBkColor(void);
	virtual System::Uitypes::TColor __fastcall GetTextColor(void);
	virtual void __fastcall GetThemedElementDetails(Vcl::Themes::TThemedElementDetails &ADetails);
	__property bool RightAlignedText = {read=FRightAlignedText, write=FRightAlignedText, default=0};
	__property bool RightAlignedView = {read=FRightAlignedView, write=SetRightAlignedView, default=0};
	__property Vcl::Graphics::TBitmap* Background = {read=FBackground, write=SetBackground};
	__property bool UseBackground = {read=FUseBackground, write=SetUseBackground, default=0};
	__property Lmdtypes::TLMDString PasswordChar = {read=GetPasswordChar, write=SetPasswordChar};
	__property int MaxLength = {read=FMaxLength, write=SetMaxLength, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property bool WantTabs = {read=FWantTabs, write=FWantTabs, default=0};
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property bool AutoSelect = {read=FAutoSelect, write=FAutoSelect, default=0};
	__property bool HideSelection = {read=FHideSelection, write=SetHideSelection, default=1};
	__property System::Types::TRect EditRect = {read=FEditRect, write=DoSetEditRect};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=FInactiveBorderType, write=SetInactiveBorderType, default=3};
	__property System::Uitypes::TScrollStyle ScrollBars = {read=FScrollBars, write=SetScrollBars, default=0};
	__property System::Uitypes::TScrollStyle ScrollBarsAutoShowing = {read=FScrollBarsAutoShowing, write=SetScrollBarsAutoShowing, default=0};
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=FActiveBorderType, write=SetActiveBorderType, default=1};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=1};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property Elinputprocessor::TElEditCharCase CharCase = {read=FCharCase, write=SetCharCase, default=0};
	__property bool FlatFocusedScrollBars = {read=FFlatFocusedScrollBars, write=SetFlatFocusedScrollBars, default=0};
	__property System::Uitypes::TColor LineBorderActiveColor = {read=FLineBorderActiveColor, write=SetLineBorderActiveColor, default=-16777201};
	__property System::Uitypes::TColor LineBorderInactiveColor = {read=FLineBorderInactiveColor, write=SetLineBorderInactiveColor, default=-16777201};
	__property System::Classes::TStrings* Lines = {read=GetLines, write=SetLines};
	__property int MaxUndoLevel = {read=GetMaxLevel, write=SetMaxLevel, default=0};
	__property bool Multiline = {read=FMultiline, write=SetMultiline, default=0};
	__property int TabSpaces = {read=FTabSpaces, write=SetTabSpaces, default=4};
	__property bool UseSystemMenu = {read=FUseSystemMenu, write=FUseSystemMenu, default=1};
	__property bool LocalizedSystemMenu = {read=FLocalizedSystemMenu, write=FLocalizedSystemMenu, default=0};
	__property bool WantReturns = {read=FWantReturns, write=FWantReturns, default=0};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=0};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property System::Classes::TNotifyEvent OnSelectionChange = {read=FOnSelectionChange, write=FOnSelectionChange};
	__property System::Uitypes::TColor FocusedSelectColor = {read=FFocusedSelectColor, write=SetFocusedSelectColor, default=-16777203};
	__property System::Uitypes::TColor FocusedSelectTextColor = {read=FFocusedSelectTextColor, write=SetFocusedSelectTextColor, default=-16777202};
	__property System::Uitypes::TColor HideSelectColor = {read=FHideSelectColor, write=SetHideSelectColor, default=-16777201};
	__property System::Uitypes::TColor HideSelectTextColor = {read=FHideSelectTextColor, write=SetHideSelectTextColor, default=-16777200};
	__property int HighlightAlphaLevel = {read=FHighlightAlphaLevel, write=SetHighlightAlphaLevel, default=255};
	__property Vcl::Controls::TControl* LinkedControl = {read=FLinkedControl, write=SetLinkedControl};
	__property Elvclutils::TElLinkCtlPos LinkedControlPosition = {read=FLinkedControlPosition, write=SetLinkedControlPosition, default=3};
	__property int LinkedControlSpacing = {read=FLinkedControlSpacing, write=SetLinkedControlSpacing, default=0};
	__property bool UseDisabledColors = {read=FUseDisabledColors, write=SetUseDisabledColors, default=0};
	__property System::Uitypes::TColor DisabledColor = {read=FDisabledColor, write=SetDisabledColor, default=-16777201};
	__property System::Uitypes::TColor DisabledFontColor = {read=FDisabledFontColor, write=SetDisabledFontColor, default=-16777199};
	__property Elsbctrl::TElCtrlScrollBarStyles* HorzScrollBarStyles = {read=GetHorzScrollBar, write=SetHorzScrollBar, stored=ScrollBarStylesStored};
	__property Elsbctrl::TElCtrlScrollBarStyles* VertScrollBarStyles = {read=GetVertScrollBar, write=SetVertScrollBar, stored=ScrollBarStylesStored};
	__property bool UseCustomScrollBars = {read=FUseCustomScrollBars, write=SetUseCustomScrollBars, default=1};
	__property TElKeyPressExEvent OnKeyPressEx = {read=FOnKeyPressEx, write=FOnKeyPressEx};
	__property TElPasteClipboardEvent OnPasteClipboardText = {read=FOnPasteClipboardText, write=FOnPasteClipboardText};
	__property System::Classes::TNotifyEvent OnAfterPasteClipboardText = {read=FOnAfterPasteClipboardText, write=FOnAfterPasteClipboardText};
	
public:
	bool __fastcall SupportsDefaultIndication(void);
	__property Vcl::Graphics::TFont* ControlFont = {read=GetControlFont};
	__property Vcl::Graphics::TBrush* ControlBackBrush = {read=GetControlBackBrush};
	void __fastcall RespondToError(int ErrorLevel);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* Validator);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	__fastcall virtual TCustomElEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomElEdit(void);
	virtual void __fastcall AdjustHeight(void);
	HIDESBASE void __fastcall SetText(Lmdtypes::TLMDString newValue);
	System::Types::TPoint __fastcall GetNextWord(const System::Types::TPoint &ACaret);
	System::Types::TPoint __fastcall GetPrevWord(const System::Types::TPoint &ACaret);
	virtual void __fastcall CommandCenter(Eleditcmds::TElCommand ACommand, System::WideChar AChar, void * AData);
	virtual void __fastcall ExecuteCommand(Eleditcmds::TElCommand ACommand, System::WideChar AChar, void * AData);
	virtual void __fastcall SetStress(const int X, const int Y);
	virtual void __fastcall SetBookmark(const int Index);
	virtual void __fastcall GotoBookmark(const int Index);
	System::Types::TPoint __fastcall CaretFromChar(const int CharNum);
	int __fastcall CharFromCaret(const int X, const int Y);
	virtual System::Types::TPoint __fastcall PosFromCaret(const int X, const int Y);
	virtual void __fastcall CaretFromPos(const System::Types::TPoint &APos, int &ACaretX, int &ACaretY);
	void __fastcall SelectAll(void);
	virtual void __fastcall CutToClipboard(void);
	virtual void __fastcall CopyToClipboard(void);
	virtual void __fastcall PasteFromClipboard(void);
	void __fastcall Undo(void);
	void __fastcall ClearUndo(void);
	void __fastcall Scroll(TElEditScrollDir ScrollDir);
	void __fastcall ScrollCaret(void);
	bool __fastcall GetCanUndo(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property Elinputprocessor::TElDeadCharList* DeadCharList = {read=FDeadCharList};
	__property int SelStart = {read=GetSelStart, write=SetSelStart, nodefault};
	__property int SelLength = {read=GetSelLength, write=SetSelLength, nodefault};
	__property Lmdtypes::TLMDString SelText = {read=GetSelectedText, write=SetSelText};
	__property bool Modified = {read=FModified, write=SetModified, default=0};
	__property Lmdtypes::TLMDString SelectedText = {read=GetSelectedText};
	__property bool MouseOver = {read=FMouseOver, nodefault};
	__property int LinesCount = {read=GetLinesCount, nodefault};
	__property int TopLine = {read=FTopLine, write=SetTopLine, nodefault};
	__property int LeftChar = {read=FLeftChar, write=SetLeftChar, nodefault};
	__property int LeftMargin = {read=FLeftMargin, write=SetLeftMargin, default=1};
	__property int RightMargin = {read=FRightMargin, write=SetRightMargin, default=1};
	__property bool HandleDialogKeys = {read=FHandleDialogKeys, write=FHandleDialogKeys, default=0};
	__property Lmdtypes::TLMDString Text = {read=GetText, write=SetText};
	__property int TopMargin = {read=FTopMargin, write=SetTopMargin, default=0};
	__property bool AlignBottom = {read=FAlignBottom, write=SetAlignBottom, default=1};
	__property int CaretX = {read=FCaretX, write=SetCaretX, nodefault};
	__property int CaretY = {read=FCaretY, write=SetCaretY, nodefault};
	__property System::Types::TPoint CaretXY = {read=GetCaretXY, write=SetCaretXY};
	__property bool CanUndo = {read=GetCanUndo, nodefault};
	__property bool DragAllowed = {read=FDragAllowed, write=FDragAllowed, default=0};
	DYNAMIC void __fastcall DragDrop(System::TObject* Source, int X, int Y);
	__property UseXPThemes;
	
__published:
	__property Elvclutils::TElDisplayOptions* DisplayReadOnlyOptions = {read=FDisplayReadOnlyOptions, write=SetDisplayReadOnlyOptions};
	__property bool NotifyUserChangeOnly = {read=FNotifyUserChangeOnly, write=FNotifyUserChangeOnly, default=1};
	__property System::Uitypes::TColor BorderColorDkShadow = {read=FBorderColorDkShadow, write=SetBorderColorDkShadow, default=-16777195};
	__property System::Uitypes::TColor BorderColorFace = {read=FBorderColorFace, write=SetBorderColorFace, default=-16777201};
	__property System::Uitypes::TColor BorderColorShadow = {read=FBorderColorShadow, write=SetBorderColorShadow, default=-16777200};
	__property System::Uitypes::TColor BorderColorHighlight = {read=FBorderColorHighlight, write=SetBorderColorHighlight, default=-16777196};
	__property System::Uitypes::TColor BorderColorWindow = {read=FBorderColorWindow, write=SetBorderColorWindow, default=-16777211};
	__property System::Classes::TShortCut StressShortCut = {read=FStressShortCut, write=SetStressShortCut, default=0};
	__property Lmdtypes::TLMDString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=FOnValidationError, write=FOnValidationError};
	__property Lmdtypes::TLMDString CueBanner = {read=FCueBanner, write=SetCueBanner};
	__property DoubleBuffered;
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property TabStop = {default=1};
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElEdit(HWND ParentWindow) : Elxpthemedcontrol::TElXPThemedControl(ParentWindow) { }
	
private:
	void *__ILMDValidatedControl;	// Lmdvldbase::ILMDValidatedControl 
	
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
	
};


class PASCALIMPLEMENTATION TCustomElMemo : public TCustomElEdit
{
	typedef TCustomElEdit inherited;
	
public:
	__fastcall virtual TCustomElMemo(System::Classes::TComponent* AOwner);
public:
	/* TCustomElEdit.Destroy */ inline __fastcall virtual ~TCustomElMemo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomElMemo(HWND ParentWindow) : TCustomElEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElMemo : public TCustomElMemo
{
	typedef TCustomElMemo inherited;
	
__published:
	__property StressShortCut = {default=0};
	__property AutoSize = {default=1};
	__property Alignment = {default=0};
	__property AlignBottom = {default=0};
	__property Background;
	__property BorderSides = {default=15};
	__property Cursor = {default=-4};
	__property CharCase = {default=0};
	__property UseBackground = {default=0};
	__property RightAlignedText = {default=0};
	__property RightAlignedView = {default=0};
	__property PasswordChar = {default=0};
	__property MaxLength = {default=0};
	__property Transparent = {default=0};
	__property FlatFocusedScrollBars = {default=0};
	__property ReadOnly = {default=0};
	__property WantTabs = {default=0};
	__property LeftMargin = {default=1};
	__property RightMargin = {default=1};
	__property TopMargin = {default=0};
	__property BorderStyle = {default=1};
	__property AutoSelect = {default=0};
	__property HandleDialogKeys = {default=0};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelection = {default=1};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HighlightAlphaLevel = {default=255};
	__property TabSpaces = {default=4};
	__property Lines = {stored=false};
	__property LinkedControl;
	__property LinkedControlPosition = {default=3};
	__property LinkedControlSpacing = {default=0};
	__property UseDisabledColors = {default=0};
	__property DisabledColor = {default=-16777201};
	__property DisabledFontColor = {default=-16777199};
	__property Text;
	__property ImageForm;
	__property ActiveBorderType = {default=1};
	__property Flat = {default=0};
	__property InactiveBorderType = {default=3};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property MaxUndoLevel = {default=0};
	__property WantReturns = {default=1};
	__property WordWrap = {default=0};
	__property ScrollBars = {default=0};
	__property ScrollBarsAutoShowing = {default=0};
	__property VertScrollBarStyles;
	__property HorzScrollBarStyles;
	__property UseCustomScrollBars = {default=1};
	__property UseSystemMenu = {default=1};
	__property LocalizedSystemMenu = {default=0};
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnChange;
	__property OnSelectionChange;
	__property OnKeyPressEx;
	__property OnPasteClipboardText;
	__property OnAfterPasteClipboardText;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D = {default=1};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
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
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
public:
	/* TCustomElMemo.Create */ inline __fastcall virtual TElMemo(System::Classes::TComponent* AOwner) : TCustomElMemo(AOwner) { }
	
public:
	/* TCustomElEdit.Destroy */ inline __fastcall virtual ~TElMemo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElMemo(HWND ParentWindow) : TCustomElMemo(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElEdit : public TCustomElEdit
{
	typedef TCustomElEdit inherited;
	
__published:
	__property StressShortCut = {default=0};
	__property AutoSize = {default=1};
	__property Alignment = {default=0};
	__property AlignBottom = {default=1};
	__property Background;
	__property BorderSides = {default=15};
	__property Cursor = {default=-4};
	__property CharCase = {default=0};
	__property UseBackground = {default=0};
	__property RightAlignedText = {default=0};
	__property RightAlignedView = {default=0};
	__property PasswordChar = {default=0};
	__property MaxLength = {default=0};
	__property Transparent = {default=0};
	__property FlatFocusedScrollBars = {default=0};
	__property ReadOnly = {default=0};
	__property WantTabs = {default=0};
	__property LeftMargin = {default=1};
	__property RightMargin = {default=1};
	__property TopMargin = {default=0};
	__property BorderStyle = {default=1};
	__property AutoSelect = {default=0};
	__property HandleDialogKeys = {default=0};
	__property FocusedSelectColor = {default=-16777203};
	__property FocusedSelectTextColor = {default=-16777202};
	__property HideSelection = {default=1};
	__property HideSelectColor = {default=-16777201};
	__property HideSelectTextColor = {default=-16777200};
	__property HighlightAlphaLevel = {default=255};
	__property TabSpaces = {default=4};
	__property Lines = {stored=false};
	__property LinkedControl;
	__property LinkedControlPosition = {default=3};
	__property LinkedControlSpacing = {default=0};
	__property UseDisabledColors = {default=0};
	__property DisabledColor = {default=-16777201};
	__property DisabledFontColor = {default=-16777199};
	__property Text;
	__property ImageForm;
	__property ActiveBorderType = {default=1};
	__property Flat = {default=0};
	__property InactiveBorderType = {default=3};
	__property LineBorderActiveColor = {default=-16777201};
	__property LineBorderInactiveColor = {default=-16777201};
	__property MaxUndoLevel = {default=0};
	__property WantReturns = {default=0};
	__property WordWrap = {default=0};
	__property Multiline = {default=0};
	__property ScrollBars = {default=0};
	__property ScrollBarsAutoShowing = {default=0};
	__property VertScrollBarStyles;
	__property HorzScrollBarStyles;
	__property UseCustomScrollBars = {default=1};
	__property UseSystemMenu = {default=1};
	__property LocalizedSystemMenu = {default=0};
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnChange;
	__property OnSelectionChange;
	__property OnKeyPressEx;
	__property OnPasteClipboardText;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D = {default=1};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
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
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
public:
	/* TCustomElEdit.Create */ inline __fastcall virtual TElEdit(System::Classes::TComponent* AOwner) : TCustomElEdit(AOwner) { }
	/* TCustomElEdit.Destroy */ inline __fastcall virtual ~TElEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElEdit(HWND ParentWindow) : TCustomElEdit(ParentWindow) { }
	
};


typedef System::StaticArray<int, 536870911> TIntArray;

typedef TIntArray *PIntArray;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool RepaintAll;
extern DELPHI_PACKAGE bool FlagEdit;
static const System::WideChar ElFSpace = (System::WideChar)(0x20);
static const System::WideChar ElFTab = (System::WideChar)(0x9);
static const System::WideChar ElFCR = (System::WideChar)(0xd);
static const System::WideChar ElFLF = (System::WideChar)(0xa);
#define ElFCRLF L"\r\n"
static const System::Word ID_UNDO = System::Word(0x304);
static const System::Word ID_CUT = System::Word(0x300);
static const System::Word ID_COPY = System::Word(0x301);
static const System::Word ID_PASTE = System::Word(0x302);
static const System::Word ID_DELETE = System::Word(0x303);
}	/* namespace Eledits */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELEDITS)
using namespace Eledits;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EleditsHPP
