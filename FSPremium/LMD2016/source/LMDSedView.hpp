// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSedView.pas' rev: 31.00 (Windows)

#ifndef LmdsedviewHPP
#define LmdsedviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.RichEdit.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.Contnrs.hpp>
#include <System.Types.hpp>
#include <Vcl.Forms.hpp>
#include <intfLMDBase.hpp>
#include <Winapi.ActiveX.hpp>
#include <System.Win.ComObj.hpp>
#include <LMDArrayUtils.hpp>
#include <LMDStrings.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>
#include <LMDSedDocument.hpp>
#include <LMDSedUtils.hpp>
#include <LMDHashTable.hpp>
#include <LMDPrinter.hpp>
#include <Vcl.ActnList.hpp>
#include <System.Variants.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsedview
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDEditViewError;
class DELPHICLASS TLMDEditCommandBinding;
class DELPHICLASS TLMDEditCommandBindings;
class DELPHICLASS TLMDEditCommandItem;
class DELPHICLASS TLMDEditCommandList;
class DELPHICLASS TLMDViewPartParent;
class DELPHICLASS TLMDSpecialChars;
class DELPHICLASS TLMDGutterBar;
class DELPHICLASS TLMDGutterBars;
class DELPHICLASS TLMDGutter;
struct TLMDGutterClickParams;
struct TLMDGutterPaintParams;
struct TLMDEditSearchArguments;
class DELPHICLASS TLMDEditViewPrintTask;
struct TLMDEditPaintTextArgs;
struct TOffsetPoint;
class DELPHICLASS TLMDEditCompletionSettings;
class DELPHICLASS TLMDEditHighlightSettings;
class DELPHICLASS TLMDCustomEditView;
class DELPHICLASS TLMDEditView;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDEditViewError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDEditViewError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDEditViewError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDEditViewError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDEditViewError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDEditViewError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDEditViewError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDEditViewError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDEditViewError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDEditViewError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDEditViewError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDEditViewError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDEditViewError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDEditViewError(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDEditCommandMode : unsigned char { cmForView, cmForCompletion, cmForIncSearch };

typedef System::Set<TLMDEditCommandMode, TLMDEditCommandMode::cmForView, TLMDEditCommandMode::cmForIncSearch> TLMDEditCommandModes;

enum DECLSPEC_DENUM TLMDEditCommand : unsigned char { sedLeft, sedRight, sedUp, sedDown, sedLineHome, sedLineEnd, sedNextWord, sedPrevWord, sedPageUp, sedPageDown, sedPageHome, sedPageEnd, sedTextHome, sedTextEnd, sedUndo, sedRedo, sedCut, sedCopy, sedPaste, sedDeletePrevChar, sedDeleteChar, sedDeletePrevWord, sedDeleteWord, sedDeleteLine, sedDeleteToLineEnd, sedDeleteToLineWrap, sedChar, sedStr, sedNewLine, sedTab, sedIndent, sedUnIndent, sedIndentToPrevIndent, sedUnIndentToPrevIndent, sedBackspaceOrUnindent, sedTabOrIndent, sedScrollUp, sedScrollDown, sedSelectLeft, sedSelectRight, sedSelectPrevWord, sedSelectNextWord, sedSelectUp, sedSelectDown, sedSelectPageUp, sedSelectPageDown, sedSelectPageHome, sedSelectPageEnd, sedSelectLineHome, sedSelectLineEnd, 
	sedSelectTextHome, sedSelectTextEnd, sedSelectLeftBlock, sedSelectRightBlock, sedSelectPrevWordBlock, sedSelectNextWordBlock, sedSelectUpBlock, sedSelectDownBlock, sedSelectPageUpBlock, sedSelectPageDownBlock, sedSelectPageHomeBlock, sedSelectPageEndBlock, sedSelectLineHomeBlock, sedSelectLineEndBlock, sedSelectTextHomeBlock, sedSelectTextEndBlock, sedSelectAll, sedSelectNone, sedToggleOverwrite, sedCompletionShow, sedCompletionUp, sedCompletionDown, sedCompletionCommit, sedCompletionCancel, sedCompletionBack, sedCompletionLeft, sedCompletionRight, sedCompletionPgUp, sedCompletionPgDown, sedCompletionHome, sedCompletionEnd, sedIncrementalSearchStart, sedIncrementalSearchAddChar, sedIncrementalSearchBack, sedIncrementalSearchForward, 
	sedIncrementalSearchCancel };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEditCommandBinding : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::Classes::TShortCut FShortcut;
	System::Classes::TShortCut FShortcut2;
	void __fastcall CheckShortcuts(System::Classes::TShortCut AShortcut, System::Classes::TShortCut AShortcut2, TLMDEditCommandModes AModes);
	void __fastcall SetShortcut(System::Classes::TShortCut AShortcut);
	void __fastcall SetShortcut2(System::Classes::TShortCut AShortcut);
	TLMDEditCommandItem* __fastcall GetParentItem(void);
	
public:
	__fastcall virtual TLMDEditCommandBinding(System::Classes::TCollection* Collection);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property TLMDEditCommandItem* ParentItem = {read=GetParentItem};
	
__published:
	__property System::Classes::TShortCut Shortcut = {read=FShortcut, write=SetShortcut, nodefault};
	__property System::Classes::TShortCut Shortcut2 = {read=FShortcut2, write=SetShortcut2, nodefault};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDEditCommandBinding(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEditCommandBindings : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDEditCommandBinding* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDEditCommandItem* FParentItem;
	HIDESBASE TLMDEditCommandBinding* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDEditCommandBinding* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TLMDEditCommandBindings(TLMDEditCommandItem* AParentItem);
	HIDESBASE TLMDEditCommandBinding* __fastcall Add(void);
	__property TLMDEditCommandBinding* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDEditCommandBindings(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEditCommandItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TLMDEditCommandBindings* FBindings;
	bool FEditable;
	TLMDEditCommandModes FModes;
	TLMDEditCommand FCommand;
	void __fastcall SetCommand(TLMDEditCommand ACommand);
	void __fastcall SetBindings(TLMDEditCommandBindings* ABindings);
	Lmdtypes::TLMDString __fastcall GetDescription(void);
	Lmdtypes::TLMDString __fastcall GetCategory(void);
	TLMDEditCommandList* __fastcall Parent(void);
	
public:
	__fastcall virtual TLMDEditCommandItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDEditCommandItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TLMDEditCommandBindings* Bindings = {read=FBindings, write=SetBindings};
	__property TLMDEditCommand Command = {read=FCommand, write=SetCommand, nodefault};
	__property Lmdtypes::TLMDString Description = {read=GetDescription};
	__property Lmdtypes::TLMDString Category = {read=GetCategory};
	__property bool Editable = {read=FEditable, write=FEditable, nodefault};
	__property TLMDEditCommandModes Modes = {read=FModes, write=FModes, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEditCommandList : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDEditCommandItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDCustomEditView* FParent;
	HIDESBASE TLMDEditCommandItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDEditCommandItem* Value);
	void __fastcall CheckBindingSet(TLMDEditCommandBinding* ABind, System::Classes::TShortCut AShortcut, System::Classes::TShortCut AShortcut2, TLMDEditCommandModes AModes);
	void __fastcall CheckCommandSet(TLMDEditCommandItem* AItem, TLMDEditCommand ACommand);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TLMDEditCommandList(TLMDCustomEditView* AParent);
	TLMDEditCommandBinding* __fastcall FindBinding(System::Word AKey, System::Classes::TShiftState AShiftState, System::Word AKey2, System::Classes::TShiftState AShiftState2, TLMDEditCommandModes AModes)/* overload */;
	TLMDEditCommandBinding* __fastcall FindBinding(System::Classes::TShortCut AShortcut, System::Classes::TShortCut AShortcut2, TLMDEditCommandModes AModes)/* overload */;
	TLMDEditCommandBinding* __fastcall FindBinding(System::Word AKey, System::Classes::TShiftState AShiftState, TLMDEditCommandModes AModes)/* overload */;
	TLMDEditCommandBinding* __fastcall FindBinding(System::Classes::TShortCut AShortcut, TLMDEditCommandModes AModes)/* overload */;
	TLMDEditCommandItem* __fastcall FindCommand(TLMDEditCommand ACmd);
	HIDESBASE TLMDEditCommandItem* __fastcall Add(void);
	__property TLMDEditCommandItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TLMDCustomEditView* Parent = {read=FParent};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDEditCommandList(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDViewSetting : unsigned char { vsShowWrapRuler, vsHideShowScrollbars, vsOverwrite, vsUseTabs, vsHighlightSelectedLine, vsAutoIndent, vsKeepBlanks, vsCursorBoundToChars, vsRightClickMovesCursor, vsBackspaceUnindents, vsDragDropEditing, vsPreciseScrollbars };

enum DECLSPEC_DENUM TLMDViewCompletionType : unsigned char { ctDocumentText, ctCustom, ctCustomOwnerDrawFixed, ctCustomOwnerDrawVariable, ctDisabled };

typedef System::Set<TLMDViewSetting, TLMDViewSetting::vsShowWrapRuler, TLMDViewSetting::vsPreciseScrollbars> TLMDViewSettings;

enum DECLSPEC_DENUM TLMDViewWrapMode : unsigned char { wmNoWrap, wmWrapToRuler, wmWrapToWindow };

enum DECLSPEC_DENUM TLMDViewStatusChange : unsigned char { scCursor, scSelection, scFont, scViewSettings, scGutterSettings, scHScroll, scVScroll, scScreenSize, scWrapSettings, scFolds };

typedef System::Set<TLMDViewStatusChange, TLMDViewStatusChange::scCursor, TLMDViewStatusChange::scFolds> TLMDViewStatusChanges;

typedef void __fastcall (__closure *TLMDViewStatusChangeEvent)(TLMDCustomEditView* AView, TLMDViewStatusChanges AChanges);

enum DECLSPEC_DENUM TLMDEditInternalState : unsigned char { siWaitDrag, siDoubleClicked, siScrolling, siMouseSelectByWords, siMouseSelectByLines, siScrollbarsUpdating, siComplWordTyping, siComplListShown, siComplTimer, siIncrementalSearch, siDestroing, siPainting, siScrollforceAvoidAdges };

typedef System::Set<TLMDEditInternalState, TLMDEditInternalState::siWaitDrag, TLMDEditInternalState::siScrollforceAvoidAdges> TLMDEditInternalStates;

typedef System::DynamicArray<Lmdseddocument::TLMDMarkArray> TLMDEditScreenMarks;

enum DECLSPEC_DENUM TLMDSpecialCharKind : unsigned char { skTabTail, skTabHead, skSpace, skCR, skLF, skCRLF, skLineWrap, skFoldedLineEnd, skLineNumberBullet };

typedef System::Set<TLMDSpecialCharKind, TLMDSpecialCharKind::skTabTail, TLMDSpecialCharKind::skLineNumberBullet> TLMDSpecialCharKinds;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDViewPartParent : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall BeginChange(void) = 0 ;
	virtual void __fastcall EndChange(bool AResetCache) = 0 ;
	virtual System::Classes::TComponent* __fastcall GetOwnerComponent(void) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TLMDViewPartParent(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDViewPartParent(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSpecialChars : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TLMDViewPartParent* FParent;
	System::Uitypes::TFontCharset FCharset;
	bool FUseCharset;
	System::StaticArray<System::WideChar, 9> FShowChars;
	System::StaticArray<System::WideChar, 9> FShowCharsDefault;
	TLMDSpecialCharKinds FShowCharKinds;
	void __fastcall SetChar(TLMDSpecialCharKind AKind, Lmdtypes::TLMDString AChar);
	Lmdtypes::TLMDString __fastcall GetChar(TLMDSpecialCharKind AKind);
	void __fastcall SetChar_TabTail(Lmdtypes::TLMDString AChar);
	Lmdtypes::TLMDString __fastcall GetChar_TabTail(void);
	bool __fastcall IsStored_TabTail(void);
	void __fastcall SetChar_TabHead(Lmdtypes::TLMDString AChar);
	Lmdtypes::TLMDString __fastcall GetChar_TabHead(void);
	bool __fastcall IsStored_TabHead(void);
	void __fastcall SetChar_Space(Lmdtypes::TLMDString AChar);
	Lmdtypes::TLMDString __fastcall GetChar_Space(void);
	bool __fastcall IsStored_Space(void);
	void __fastcall SetChar_CR(Lmdtypes::TLMDString AChar);
	Lmdtypes::TLMDString __fastcall GetChar_CR(void);
	bool __fastcall IsStored_CR(void);
	void __fastcall SetChar_LF(Lmdtypes::TLMDString AChar);
	Lmdtypes::TLMDString __fastcall GetChar_LF(void);
	bool __fastcall IsStored_LF(void);
	void __fastcall SetChar_CRLF(Lmdtypes::TLMDString AChar);
	Lmdtypes::TLMDString __fastcall GetChar_CRLF(void);
	bool __fastcall IsStored_CRLF(void);
	void __fastcall SetChar_LineWrap(Lmdtypes::TLMDString AChar);
	Lmdtypes::TLMDString __fastcall GetChar_LineWrap(void);
	bool __fastcall IsStored_LineWrap(void);
	void __fastcall SetChar_FoldedLineEnd(Lmdtypes::TLMDString AChar);
	Lmdtypes::TLMDString __fastcall GetChar_FoldedLineEnd(void);
	bool __fastcall IsStored_FoldedLineEnd(void);
	void __fastcall SetChar_LineNumberBullet(Lmdtypes::TLMDString AChar);
	Lmdtypes::TLMDString __fastcall GetChar_LineNumberBullet(void);
	bool __fastcall IsStored_LineNumberBullet(void);
	System::WideChar __fastcall GetDecodedChar(TLMDSpecialCharKind AKind);
	bool __fastcall IsStored(TLMDSpecialCharKind AKind);
	void __fastcall SetShowCharKinds(TLMDSpecialCharKinds AKinds);
	void __fastcall SetCharSet(System::Uitypes::TFontCharset ACharset);
	void __fastcall SetUseCharSet(bool AUse);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TLMDSpecialChars(TLMDViewPartParent* AParent);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Uitypes::TFontCharset Charset = {read=FCharset, write=SetCharSet, default=0};
	__property bool UseCharset = {read=FUseCharset, write=SetUseCharSet, default=1};
	__property Lmdtypes::TLMDString TabTailShowChar = {read=GetChar_TabTail, write=SetChar_TabTail, stored=IsStored_TabTail};
	__property Lmdtypes::TLMDString TabHeadShowChar = {read=GetChar_TabHead, write=SetChar_TabHead, stored=IsStored_TabHead};
	__property Lmdtypes::TLMDString SpaceShowChar = {read=GetChar_Space, write=SetChar_Space, stored=IsStored_Space};
	__property Lmdtypes::TLMDString CRShowChar = {read=GetChar_CR, write=SetChar_CR, stored=IsStored_CR};
	__property Lmdtypes::TLMDString LFShowChar = {read=GetChar_LF, write=SetChar_LF, stored=IsStored_LF};
	__property Lmdtypes::TLMDString CRLFShowChar = {read=GetChar_CRLF, write=SetChar_CRLF, stored=IsStored_CRLF};
	__property Lmdtypes::TLMDString LineWrapShowChar = {read=GetChar_LineWrap, write=SetChar_LineWrap, stored=IsStored_LineWrap};
	__property Lmdtypes::TLMDString FoldedLineEndShowChar = {read=GetChar_FoldedLineEnd, write=SetChar_FoldedLineEnd, stored=IsStored_FoldedLineEnd};
	__property Lmdtypes::TLMDString LineNumberBulletChar = {read=GetChar_LineNumberBullet, write=SetChar_LineNumberBullet, stored=IsStored_LineNumberBullet};
	__property TLMDSpecialCharKinds ShowCharKinds = {read=FShowCharKinds, write=SetShowCharKinds, default=128};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDSpecialChars(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDGutterBarKind : unsigned char { gbBookmarkBar, gbBreakpointBar, gbLineNumberBar, gbFoldBar, gbWrapBar, gbCustom };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGutterBar : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TLMDGutterBars* FParent;
	TLMDGutter* FGutter;
	int FWidth;
	TLMDGutterBarKind FKind;
	bool FVisible;
	int FLeftPadding;
	int FRightPadding;
	void __fastcall SetKind(TLMDGutterBarKind Value);
	void __fastcall SetWidth(int Value);
	int __fastcall GetWidth(void);
	void __fastcall SetVisible(bool Value);
	void __fastcall SetLeftPadding(int Value);
	void __fastcall SetRightPadding(const int Value);
	int __fastcall GetFullWidth(void);
	
public:
	__fastcall virtual TLMDGutterBar(System::Classes::TCollection* Collection);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property int FullWidth = {read=GetFullWidth, nodefault};
	
__published:
	__property TLMDGutterBarKind Kind = {read=FKind, write=SetKind, default=5};
	__property int Width = {read=GetWidth, write=SetWidth, default=14};
	__property int LeftPadding = {read=FLeftPadding, write=SetLeftPadding, default=2};
	__property int RightPadding = {read=FRightPadding, write=SetRightPadding, default=2};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDGutterBar(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGutterBars : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDGutterBar* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDGutter* FGutter;
	HIDESBASE TLMDGutterBar* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDGutterBar* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDGutterBars(TLMDGutter* AParent);
	HIDESBASE TLMDGutterBar* __fastcall Add(void);
	TLMDGutterBar* __fastcall AddItem(TLMDGutterBar* Item, int Index);
	HIDESBASE TLMDGutterBar* __fastcall Insert(int Index);
	__property TLMDGutterBar* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDGutterBars(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDGutterSetting : unsigned char { gsPaintWrapsOnLineNumberBar };

typedef System::Set<TLMDGutterSetting, TLMDGutterSetting::gsPaintWrapsOnLineNumberBar, TLMDGutterSetting::gsPaintWrapsOnLineNumberBar> TLMDGutterSettings;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGutter : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FInConstructor;
	TLMDCustomEditView* FParent;
	TLMDGutterBars* FBars;
	Vcl::Graphics::TBitmap* FBookmarkImg;
	Vcl::Graphics::TBitmap* FFoldPlusImg;
	Vcl::Graphics::TBitmap* FFoldMinusImg;
	Vcl::Graphics::TBitmap* FFoldEndImg;
	Vcl::Graphics::TBitmap* FBreakActiveImg;
	Vcl::Graphics::TBitmap* FBreakInactiveImg;
	Vcl::Graphics::TBitmap* FBreakDisabledImg;
	Vcl::Graphics::TBitmap* FWrapLineBarImg;
	Vcl::Graphics::TBitmap* FDebugFrameTopImg;
	Vcl::Graphics::TBitmap* FDebugFrameActiveImg;
	Vcl::Graphics::TBitmap* FDebugFrameImg;
	System::Uitypes::TColor FBookmarksBarBg;
	System::Uitypes::TColor FBookmarksBarTextColor;
	System::Uitypes::TColor FLinesBarBg;
	System::Uitypes::TColor FLinesBarTextColor;
	System::Uitypes::TColor FFoldsBarLineColor;
	System::Uitypes::TColor FFoldsBarBg;
	System::Uitypes::TColor FCustomBarBg;
	int FLineNumberingInterval;
	TLMDGutterSettings FSettings;
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall SetBars(TLMDGutterBars* ABars);
	void __fastcall SetBookmarksBarBg(System::Uitypes::TColor AColor);
	void __fastcall SetBookmarksBarTextColor(System::Uitypes::TColor AColor);
	void __fastcall SetLinesBarTextColor(System::Uitypes::TColor AColor);
	void __fastcall SetLinesBarBg(System::Uitypes::TColor AColor);
	void __fastcall SetLineNumberingInterval(int AValue);
	void __fastcall SetFoldsBarLineColor(System::Uitypes::TColor AColor);
	void __fastcall SetFoldsBarBg(System::Uitypes::TColor AColor);
	void __fastcall SetCustomBarBg(System::Uitypes::TColor AColor);
	void __fastcall SetDebugFrameTopImg(Vcl::Graphics::TBitmap* AImg);
	void __fastcall SetDebugFrameActiveImg(Vcl::Graphics::TBitmap* AImg);
	void __fastcall StackDebugFrameImg(Vcl::Graphics::TBitmap* AImg);
	void __fastcall SetBookmarkImg(Vcl::Graphics::TBitmap* AImg);
	void __fastcall SetBreakActiveImg(Vcl::Graphics::TBitmap* AImg);
	void __fastcall SetBreakInactiveImg(Vcl::Graphics::TBitmap* AImg);
	void __fastcall SetBreakDisabledImg(Vcl::Graphics::TBitmap* AImg);
	void __fastcall SetFoldPlusImg(Vcl::Graphics::TBitmap* AImg);
	void __fastcall SetFoldMinusImg(Vcl::Graphics::TBitmap* AImg);
	void __fastcall SetFoldEndImg(Vcl::Graphics::TBitmap* AImg);
	void __fastcall SetWrapLineBarImg(Vcl::Graphics::TBitmap* AImg);
	void __fastcall SetSettings(TLMDGutterSettings ASettings);
	Vcl::Graphics::TBitmap* __fastcall GetBreakImageForDrawing(const void *AProps);
	Vcl::Graphics::TBitmap* __fastcall GetBookImageForDrawing(const Lmdseddocument::_di_ILMDMark AMark);
	Vcl::Graphics::TBitmap* __fastcall GetFoldImageForDrawing(bool AExpanded);
	Vcl::Graphics::TBitmap* __fastcall GetWrapImageForDrawing(void);
	Vcl::Graphics::TBitmap* __fastcall GetDbgImageForDrawing(const void *AProps);
	bool __fastcall IsBarsStored(void);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TLMDGutter(TLMDCustomEditView* AParent);
	__fastcall virtual ~TLMDGutter(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	int __fastcall GetWidth(void);
	
__published:
	__property System::Uitypes::TColor BookmarksBarBg = {read=FBookmarksBarBg, write=SetBookmarksBarBg, default=14215660};
	__property System::Uitypes::TColor BookmarksBarTextColor = {read=FBookmarksBarTextColor, write=SetBookmarksBarTextColor, default=0};
	__property System::Uitypes::TColor LinesBarTextColor = {read=FLinesBarTextColor, write=SetLinesBarTextColor, default=13408665};
	__property System::Uitypes::TColor LinesBarBg = {read=FLinesBarBg, write=SetLinesBarBg, default=16053492};
	__property int LineNumberingInterval = {read=FLineNumberingInterval, write=SetLineNumberingInterval, default=10};
	__property System::Uitypes::TColor FoldsBarLineColor = {read=FFoldsBarLineColor, write=SetFoldsBarLineColor, default=13408665};
	__property System::Uitypes::TColor FoldsBarBg = {read=FFoldsBarBg, write=SetFoldsBarBg, default=16053492};
	__property System::Uitypes::TColor CustomBarBg = {read=FCustomBarBg, write=SetCustomBarBg, default=16053492};
	__property TLMDGutterBars* Bars = {read=FBars, write=SetBars, stored=IsBarsStored};
	__property TLMDGutterSettings Settings = {read=FSettings, write=SetSettings, default=1};
	__property Vcl::Graphics::TBitmap* BookmarkImg = {read=FBookmarkImg, write=SetBookmarkImg};
	__property Vcl::Graphics::TBitmap* BreakActiveImg = {read=FBreakActiveImg, write=SetBreakActiveImg};
	__property Vcl::Graphics::TBitmap* BreakInactiveImg = {read=FBreakInactiveImg, write=SetBreakInactiveImg};
	__property Vcl::Graphics::TBitmap* BreakDisabledImg = {read=FBreakDisabledImg, write=SetBreakDisabledImg};
	__property Vcl::Graphics::TBitmap* FoldPlusImg = {read=FFoldPlusImg, write=SetFoldPlusImg};
	__property Vcl::Graphics::TBitmap* FoldMinusImg = {read=FFoldMinusImg, write=SetFoldMinusImg};
	__property Vcl::Graphics::TBitmap* FoldEndImg = {read=FFoldEndImg, write=SetFoldEndImg};
	__property Vcl::Graphics::TBitmap* WrapLineBarImg = {read=FWrapLineBarImg, write=SetWrapLineBarImg};
	__property Vcl::Graphics::TBitmap* DebugFrameTopImg = {read=FDebugFrameTopImg, write=SetDebugFrameTopImg};
	__property Vcl::Graphics::TBitmap* DebugFrameActiveImg = {read=FDebugFrameActiveImg, write=SetDebugFrameActiveImg};
	__property Vcl::Graphics::TBitmap* DebugFrameImg = {read=FDebugFrameImg, write=StackDebugFrameImg};
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TLMDGutterClickParams
{
public:
	int ScrollLine;
	TLMDGutterBar* Bar;
	System::Classes::TShiftState Shift;
	System::Uitypes::TMouseButton Button;
};


typedef void __fastcall (__closure *TLMDGutterClickEvent)(TLMDCustomEditView* AView, const TLMDGutterClickParams &AParams, bool &Handled);

typedef void __fastcall (__closure *TLMDGutterCustomDefaultPainter)(int AScreenLine, TLMDGutterBar* ABar, TLMDGutterBarKind ABarPaintKind, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);

struct DECLSPEC_DRECORD TLMDGutterPaintParams
{
public:
	int ScreenLine;
	TLMDGutterBar* Bar;
	Vcl::Graphics::TCanvas* Canvas;
	System::Types::TRect Rect;
	TLMDGutterCustomDefaultPainter DefaultPainter;
};


typedef void __fastcall (__closure *TLMDGutterPaintEvent)(TLMDCustomEditView* AView, const TLMDGutterPaintParams &AParams, bool &PaintOk);

enum DECLSPEC_DENUM TLMDCursorMoveDirection : unsigned char { mdForward, mdBackward };

enum DECLSPEC_DENUM TLMDCursorMoveUnit : unsigned char { muLine, muChar, muWord };

typedef void __fastcall (__closure *TMouseCursorEvent)(System::TObject* Sender, const System::Types::TPoint &AScrollPos, System::Uitypes::TCursor &ACursor);

typedef void __fastcall (__closure *TKeyPressWEvent)(System::TObject* Sender, System::WideChar &Key);

enum DECLSPEC_DENUM TLMDEditViewSearchStart : unsigned char { ssCursor, ssTextStartEnd };

enum DECLSPEC_DENUM TLMDEditViewSearchState : unsigned char { stNothing, stInSearch, stInReplace };

enum DECLSPEC_DENUM TLMDEditViewReplaceAllBounds : unsigned char { rbAllText, rbSelection };

enum DECLSPEC_DENUM TLMDEditNotFoundAction : unsigned char { saCancel, saGoStartEnd };

typedef void __fastcall (__closure *TLMDEditNotFoundEvent)(System::TObject* Sender, TLMDEditNotFoundAction &Action);

struct DECLSPEC_DRECORD TLMDEditSearchArguments
{
public:
	Lmdtypes::TLMDString Search;
	Lmdtypes::TLMDString Replace;
	Lmdseddocument::TLMDEditSearchOptions Options;
	Lmdseddocument::TLMDEditSearchDirection Direction;
	TLMDEditViewSearchStart Start;
};


enum DECLSPEC_DENUM TLMDEditViewPrintOption : unsigned char { poPrintHiddenText, poPrintLineNumbers, poPrintSpecialChars };

typedef System::Set<TLMDEditViewPrintOption, TLMDEditViewPrintOption::poPrintHiddenText, TLMDEditViewPrintOption::poPrintSpecialChars> TLMDEditViewPrintOptions;

class PASCALIMPLEMENTATION TLMDEditViewPrintTask : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdprinter::TLMDPrinter* FPrinter;
	TLMDCustomEditView* FView;
	Vcl::Graphics::TFont* FFont;
	bool FUpdatetingFont;
	bool FViewFont;
	TLMDEditViewPrintOptions FPrintOptions;
	bool FPagesPrepared;
	Lmdprinter::TLMDPrintRendererBase* FRenderer;
	TLMDViewPartParent* FPartParent;
	TLMDSpecialChars* FSpecialChars;
	void __fastcall ResetSpecChars(void);
	void __fastcall SetPrintOptions(const TLMDEditViewPrintOptions Value);
	void __fastcall SetView(TLMDCustomEditView* const Value);
	bool __fastcall IsFontStored(void);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetViewFont(const bool Value);
	void __fastcall SetTaskPrinter(Lmdprinter::TLMDPrinter* const Value);
	void __fastcall InternalSetView(TLMDCustomEditView* const Value);
	void __fastcall InternalSetPrinter(Lmdprinter::TLMDPrinter* const Value);
	void __fastcall CheckPrinterAssigned(void);
	void __fastcall CheckViewAssigned(void);
	void __fastcall CheckPagesPrepared(void);
	void __fastcall CheckPagesNotPrepared(void);
	void __fastcall UpdateViewFont(void);
	void __fastcall FontChanged(System::TObject* Sender);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	Lmdprinter::TLMDPrintRendererBase* __fastcall GetRenderer(void);
	
public:
	__fastcall virtual TLMDEditViewPrintTask(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDEditViewPrintTask(void);
	void __fastcall PreparePages(void);
	int __fastcall PagesCount(void);
	void __fastcall FinalizePages(void);
	void __fastcall Print(void)/* overload */;
	void __fastcall Print(int AStart, int ACount)/* overload */;
	void __fastcall ExecPrintPreviewDlg(void);
	void __fastcall ExecPrintDlg(void);
	
__published:
	__property TLMDEditViewPrintOptions PrintOptions = {read=FPrintOptions, write=SetPrintOptions, nodefault};
	__property TLMDCustomEditView* View = {read=FView, write=SetView};
	__property Lmdprinter::TLMDPrinter* Printer = {read=FPrinter, write=SetTaskPrinter};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=IsFontStored};
	__property bool ViewFont = {read=FViewFont, write=SetViewFont, default=1};
};


struct DECLSPEC_DRECORD TLMDEditPaintTextArgs
{
public:
	int ScreenLine;
	System::Types::TRect BgRect;
	System::Types::TRect ContentRect;
	System::TObject* Cache;
	Vcl::Graphics::TCanvas* Canvas;
	Vcl::Graphics::TFont* DefaultFont;
	System::Uitypes::TColor DefaultBgColor;
	System::Uitypes::TColor DefaultColor;
	int LineHeight;
	bool PrintMode;
	TLMDEditViewPrintOptions PrintOptions;
};


typedef void __fastcall (__closure *TLMDEditBeforeCommandEvent)(System::TObject* Sender, TLMDEditCommand &ACommand, System::Variant &Arg, bool &AllowExec);

typedef void __fastcall (__closure *TLMDEditAfterCommandEvent)(System::TObject* Sender, TLMDEditCommand ACommand, const System::Variant &Arg);

typedef void __fastcall (__closure *TLMDEditGetLineAttrsEvent)(System::TObject* Sender, int AScrollLine, Lmdseddocument::TLMDEditAttributes &Attributes, bool &OverrideTokens);

struct DECLSPEC_DRECORD TOffsetPoint
{
public:
	int Offset;
	int InCharOffset;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEditCompletionSettings : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TLMDCustomEditView* FParent;
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	int __fastcall GetMinChars(void);
	int __fastcall GetShowTimeout(void);
	bool __fastcall GetDontShowComboForOnlyMatch(void);
	bool __fastcall GetCaseSensitive(void);
	TLMDViewCompletionType __fastcall GetCompletionType(void);
	int __fastcall GetItemHeight(void);
	Lmdtypes::TLMDString __fastcall GetWordSeparators(void);
	bool __fastcall GetShowCompletionOnTimeout(void);
	void __fastcall SetMinChars(int Value);
	void __fastcall SetShowTimeout(int Value);
	void __fastcall SetDontShowComboForOnlyMatch(bool Value);
	void __fastcall SetCaseSensitive(bool Value);
	void __fastcall SetCompletionType(TLMDViewCompletionType Value);
	void __fastcall SetItemHeight(int Value);
	void __fastcall SetWordSeparators(const Lmdtypes::TLMDString Value);
	void __fastcall SetShowCompletionOnTimeout(bool Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TLMDEditCompletionSettings(TLMDCustomEditView* AParent);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property int ShowTimeout = {read=GetShowTimeout, write=SetShowTimeout, default=500};
	__property bool ShowCompletionOnTimeout = {read=GetShowCompletionOnTimeout, write=SetShowCompletionOnTimeout, default=1};
	__property int MinChars = {read=GetMinChars, write=SetMinChars, default=3};
	__property bool DontShowComboForOnlyMatch = {read=GetDontShowComboForOnlyMatch, write=SetDontShowComboForOnlyMatch, default=1};
	__property bool CaseSensitive = {read=GetCaseSensitive, write=SetCaseSensitive, default=0};
	__property TLMDViewCompletionType CompletionType = {read=GetCompletionType, write=SetCompletionType, default=0};
	__property int ItemHeight = {read=GetItemHeight, write=SetItemHeight, default=16};
	__property Lmdtypes::TLMDString WordSeparators = {read=GetWordSeparators, write=SetWordSeparators};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDEditCompletionSettings(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDEditFillCompletionCause : unsigned char { fcForced, fcTimeout, fcWordEnd };

enum DECLSPEC_DENUM TLMDEditReplaceCompletionCause : unsigned char { rcCompletionList, rcWordEnd };

typedef void __fastcall (__closure *TLMDEditFillCompletionListEvent)(System::TObject* Sender, System::Classes::TStrings* Items, const System::Types::TPoint &CursorPoint, TLMDEditFillCompletionCause Cause, const Lmdtypes::TLMDString LeftPart, System::Types::TPoint &PosForCombo, bool &Handled);

typedef void __fastcall (__closure *TLMDEditReplaceForCompletionResultEvent)(System::TObject* Sender, System::Classes::TStrings* Items, int ItemIndex, const System::Types::TPoint &CursorPoint, TLMDEditReplaceCompletionCause Cause, bool &Handled);

typedef void __fastcall (__closure *TLMDEditDrawCompletionItemEvent)(System::TObject* Sender, System::Classes::TStrings* AItems, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State, Vcl::Graphics::TCanvas* Canvas);

typedef void __fastcall (__closure *TLMDEditMeasureCompletionItemEvent)(System::TObject* Sender, System::Classes::TStrings* AItems, int Index, Vcl::Graphics::TCanvas* Canvas, int &Height);

enum DECLSPEC_DENUM TLMDEditScreenPart : unsigned char { spText, spGutterText, spGutterPastText, spPastText };

enum DECLSPEC_DENUM Lmdsedview__31 : unsigned char { psTextColor, psBackgroundColor, psFontStyle };

typedef System::Set<Lmdsedview__31, Lmdsedview__31::psTextColor, Lmdsedview__31::psFontStyle> TLMDEditHighlightPropsSet;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEditHighlightSettings : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TLMDCustomEditView* FParent;
	Lmdseddocument::TLMDEditAttributes FHlSettings;
	bool FUseHl;
	TLMDEditHighlightPropsSet FPropsSet;
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	System::Uitypes::TColor __fastcall GetBgColor(void);
	System::Uitypes::TFontStyles __fastcall GetFontStyle(void);
	System::Uitypes::TColor __fastcall GetTextColor(void);
	bool __fastcall GetUseHighlight(void);
	void __fastcall SetBgColor(const System::Uitypes::TColor Value);
	void __fastcall SetFontStyle(const System::Uitypes::TFontStyles Value);
	void __fastcall SetPropsSet(const TLMDEditHighlightPropsSet Value);
	void __fastcall SetTextColor(const System::Uitypes::TColor Value);
	void __fastcall SetUseHighlight(const bool Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TLMDEditHighlightSettings(TLMDCustomEditView* AParent);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Uitypes::TColor TextColor = {read=GetTextColor, write=SetTextColor, default=0};
	__property System::Uitypes::TColor BackgroundColor = {read=GetBgColor, write=SetBgColor, default=65535};
	__property System::Uitypes::TFontStyles FontStyle = {read=GetFontStyle, write=SetFontStyle, default=0};
	__property TLMDEditHighlightPropsSet PropsSet = {read=FPropsSet, write=SetPropsSet, default=2};
	__property bool UseHighlight = {read=GetUseHighlight, write=SetUseHighlight, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDEditHighlightSettings(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDCustomEditView : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	int FAuthorID;
	System::TObject* FScreenCache;
	Lmdseddocument::TLMDDocumentListener* FDocLst;
	Lmdseddocument::TLMDDocumentInternal* FDocInternal;
	Lmdseddocument::TLMDEditDocument* FDummyDoc;
	Lmdseddocument::TLMDEditDocument* FFDoc;
	int FUpdatingCnt;
	bool FFullRepaint;
	bool FScreenMarksChanged;
	int FOldGutterWidth;
	int FChangesLock;
	int FLineHeight;
	int FGutterWidth;
	TLMDGutter* FGutter;
	bool FGutterBarsEmpty;
	TLMDSpecialChars* FSpecialChars;
	bool FInsCaret;
	TLMDViewSettings FViewSettings;
	Vcl::Graphics::TFont* FFont;
	Vcl::Graphics::TFont* FFontBold;
	tagTEXTMETRICW FFontMetrics;
	System::Uitypes::TColor FWrapRulerColor;
	System::Uitypes::TColor FReadOnlyBgColor;
	System::Uitypes::TColor FSelectedLineBg;
	System::Uitypes::TColor FBreakpointLineColor;
	System::Uitypes::TColor FBreakpointLineBg;
	System::Uitypes::TColor FSelectionBg;
	System::Uitypes::TColor FSelectionColor;
	int FTabWidth;
	int FIndentWidth;
	bool FCaretShown;
	int FLastOffsetForUndo;
	int FCursorMaxHoriz;
	int FMaxHorizScroll;
	Vcl::Stdctrls::TScrollEvent FOnScroll;
	TLMDGutterPaintEvent FOnGutterPaint;
	TLMDViewStatusChangeEvent FOnStatusChanged;
	TLMDViewStatusChanges FStatusChanges;
	TLMDEditCommandList* FDefaultCommands;
	TLMDEditCommandList* FCustomCommands;
	System::Classes::TShortCut FPressedShortcut;
	bool FPressedShortcutDefault;
	Vcl::Graphics::TBitmap* FLineBmp;
	Lmdtypes::TLMDAboutVar FAbout;
	Lmdsedutils::TLMDSedIntConversionCache* FCachedWin;
	int FMouseWheelAcc;
	bool FIgnoreKeyPress;
	int FScrollDirX;
	int FScrollDirY;
	bool FScrollBarVisibleX;
	bool FScrollBarVisibleY;
	Vcl::Extctrls::TTimer* FScrollTimer;
	int FScrollTimerBase;
	int FMouseDownX;
	int FMouseDownY;
	TOffsetPoint FCursorBeforeDrag;
	System::TDateTime FLastDoubleClickTime;
	System::TDateTime FSysDoubleClickTime;
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	System::Uitypes::TScrollStyle FScrollBars;
	System::Uitypes::TCursor FGutterCursor;
	bool FWantReturns;
	bool FWantTabs;
	TMouseCursorEvent FOnMouseCursor;
	TLMDGutterClickEvent FOnGutterClick;
	TKeyPressWEvent FOnKeyPressW;
	TLMDEditNotFoundEvent FOnNotFound;
	Lmdseddocument::TLMDEditReplaceEvent FOnReplaceFound;
	TLMDEditBeforeCommandEvent FOnBeforeCommand;
	TLMDEditAfterCommandEvent FOnAfterCommand;
	TLMDEditGetLineAttrsEvent FOnGetLineAttrs;
	System::Classes::TStrings* FAddictCheckTokens;
	Lmdtypes::TLMDIntArray FAddictCheckTokenIds;
	System::Classes::TPersistent* FOldPen;
	System::Classes::TPersistent* FOldBrush;
	bool FDoCoUninit;
	TLMDViewPartParent* FPartParent;
	Lmdseddocument::TLMDEditParsedTokenArray FTokensBuffer;
	Vcl::Extctrls::TTimer* FCompletionTimer;
	Vcl::Stdctrls::TCustomListBox* FCompletionList;
	int FCompletionTimeout;
	int FCompletionMinChars;
	TLMDViewCompletionType FCompletionType;
	bool FCompletionCaseSens;
	int FCompletionMinWidth;
	bool FCompletionNoComboForOnly;
	Lmdstrings::TLMDStringHashTable* FComplStrHash;
	Lmdtypes::TLMDString FComplWordSep;
	bool FComplUseTimeout;
	int FCmdModesLock;
	TLMDEditCompletionSettings* FComplSettings;
	TLMDEditFillCompletionListEvent FComplOnFill;
	TLMDEditReplaceForCompletionResultEvent FComplCommit;
	TLMDEditDrawCompletionItemEvent FComplOnDraw;
	TLMDEditMeasureCompletionItemEvent FComplOnMeasure;
	TLMDEditHighlightSettings* FHighlightSettings;
	bool FReadOnly;
	HICON FLineNumScreenCursor;
	System::Uitypes::TColor FDebugFrameTopLineColor;
	System::Uitypes::TColor FDebugFrameActiveLineColor;
	System::Uitypes::TColor FDebugFrameLineColor;
	System::Uitypes::TColor FDebugFrameTopLineBg;
	System::Uitypes::TColor FDebugFrameActiveLineBg;
	System::Uitypes::TColor FDebugFrameLineBg;
	System::Classes::TList* FPrintTasks;
	void __fastcall ClearPrintTasks(void);
	void __fastcall UpdatePrintTasksFont(void);
	void __fastcall BeginChangeCommon(void);
	void __fastcall EndChangeCommon(bool AFullRepaint, bool ABlockEvent);
	int __fastcall AuthorID(void);
	void __fastcall AddInternalState(TLMDEditInternalState AState);
	void __fastcall RemoveInternalState(TLMDEditInternalState AState)/* overload */;
	void __fastcall RemoveInternalState(TLMDEditInternalStates AState)/* overload */;
	void __fastcall RemoveInternalStateForPublics(TLMDEditInternalStates AState)/* overload */;
	void __fastcall BeginDocEdit(void);
	void __fastcall EndDocEdit(void);
	void __fastcall BeforeInsert(int AStart, int ACount);
	void __fastcall AfterInsert(int AStart, int ACount);
	void __fastcall BeforeDelete(int AStart, int ACount);
	void __fastcall AfterDelete(int AStart, int ACount);
	void __fastcall DocumentDestroing(void);
	void __fastcall BeforeCompoundEdit(bool AFreezeViews);
	void __fastcall AfterCompoundEdit(bool AFreezeViews);
	void __fastcall AfterMarkChange(void);
	void __fastcall BeforeMarkChange(void);
	void __fastcall MarkSettingsChanged(Lmdseddocument::_di_ILMDMarkers AMarkers, const Lmdseddocument::_di_ILMDMark AMark);
	void __fastcall DoUserEventAfterDocChange(void);
	void __fastcall DetachFromDocument(bool AStoreDoc);
	void __fastcall AttachToDocument(void);
	void __fastcall RecalkScreenVars(void);
	int __fastcall ScreenHeightFullVis(void);
	bool __fastcall IsScreenPointInSelection(const System::Types::TPoint &AScreenPoint);
	void __fastcall SetSpecialChars(TLMDSpecialChars* const Value);
	void __fastcall SetReadOnlyBgColor(System::Uitypes::TColor AColor);
	void __fastcall SetWrapRulerColor(System::Uitypes::TColor AColor);
	void __fastcall SetSelectedLineBg(System::Uitypes::TColor AColor);
	void __fastcall SetBreakpointLineColor(System::Uitypes::TColor AColor);
	void __fastcall SetBreakpointLineBg(System::Uitypes::TColor AColor);
	void __fastcall SetSelectionBg(System::Uitypes::TColor AColor);
	void __fastcall SetSelectionColor(System::Uitypes::TColor AColor);
	void __fastcall SetGutter(TLMDGutter* AGutter);
	bool __fastcall NeedInsCaret(void);
	void __fastcall CreateViewCaret(void);
	void __fastcall DestroyViewCaret(void);
	void __fastcall HideViewCaret(bool AForce);
	void __fastcall UpdateViewCaret(bool AForceUpdate = false);
	void __fastcall BeginUpdateLow(void);
	void __fastcall EndUpdateLow(void);
	void __fastcall SaveOldScreenParams(void);
	void __fastcall ResetScreenMarksChanged(void);
	bool __fastcall NoWrap(void);
	void __fastcall BeforeDocRefresh(void);
	void __fastcall AfterDocRefresh(void);
	void __fastcall BeforeDocSettingsRefresh(void);
	void __fastcall AfterDocSettingsRefresh(void);
	void __fastcall UpdateWinStyle(void);
	void __fastcall SetDocument(Lmdseddocument::TLMDEditDocument* ADoc);
	void __fastcall SetDocumentLow(Lmdseddocument::TLMDEditDocument* ADoc, bool AStoreOldDoc);
	void __fastcall SetViewSettings(TLMDViewSettings ASettings);
	void __fastcall SetWrapRulerWidth(int AWidth);
	void __fastcall SetWrapMode(TLMDViewWrapMode AMode);
	void __fastcall SetTabWidth(int AWidth);
	void __fastcall SetIndentWidth(int AWidth);
	HIDESBASE void __fastcall SetFont(Vcl::Graphics::TFont* AFont);
	void __fastcall OnFontChange(System::TObject* Sender);
	void __fastcall SetSyntaxCheckTokens(System::Classes::TStrings* ATokens);
	void __fastcall SetReadOnly(bool Value);
	int __fastcall GetScreenHeight(void);
	int __fastcall GetLinesOnScreenScroll(void);
	int __fastcall GetCursorAsOffset(void);
	void __fastcall SetCursorAsOffset(int AOffset);
	bool __fastcall GetCanCopy(void);
	bool __fastcall GetCanCut(void);
	bool __fastcall GetCanPaste(void);
	bool __fastcall GetCanUndo(void);
	bool __fastcall GetCanRedo(void);
	void __fastcall SetCustomCommands(TLMDEditCommandList* ACommands);
	Lmdtypes::TLMDString __fastcall GetSelectedText(void);
	void __fastcall SetSelectedText(const Lmdtypes::TLMDString AStr);
	int __fastcall GetWrapRulerWidth(void);
	TLMDViewWrapMode __fastcall GetWrapMode(void);
	void __fastcall SetSelStart(const System::Types::TPoint &AStart);
	void __fastcall SetSelEnd(const System::Types::TPoint &AEnd);
	System::Types::TPoint __fastcall GetSelStart(void);
	System::Types::TPoint __fastcall GetSelEnd(void);
	bool __fastcall GetSelBlockMode(void);
	void __fastcall SetSelBlockMode(bool ABlockMode);
	bool __fastcall GetSelAvail(void);
	System::Types::TPoint __fastcall GetSelStartNorm(void);
	System::Types::TPoint __fastcall GetSelEndNorm(void);
	void __fastcall SetCursorPos(const System::Types::TPoint &APoint);
	void __fastcall SetCursorPosEx(const System::Types::TPoint &APoint, int ACorrectDir, bool ABlock);
	System::Types::TPoint __fastcall GetCursorPos(void);
	int __fastcall GetCursorPosX(void);
	void __fastcall SetCursorPosX(int X);
	int __fastcall GetCursorPosY(void);
	void __fastcall SetCursorPosY(int Y);
	void __fastcall ScrollToCursorLow(bool AvoidScreenEdge);
	void __fastcall SaveCursorMaxHoriz(void);
	void __fastcall CorrectCursorToMaxHoriz(void);
	int __fastcall GetSelOffsetStart(void);
	int __fastcall GetSelOffsetEnd(void);
	void __fastcall SetSelOffsetStart(int AOffset);
	void __fastcall SetSelOffsetEnd(int AOffset);
	int __fastcall GetStoreDocSettingsLimit(void);
	void __fastcall SetStoreDocSettingsLimit(int ALimit);
	void __fastcall SetDebugFrameActiveLineBg(const System::Uitypes::TColor AColor);
	void __fastcall SetDebugFrameActiveLineColor(const System::Uitypes::TColor AColor);
	void __fastcall SetDebugFrameLineBg(const System::Uitypes::TColor AColor);
	void __fastcall SetDebugFrameLineColor(const System::Uitypes::TColor AColor);
	void __fastcall SetDebugFrameTopLineBg(const System::Uitypes::TColor AColor);
	void __fastcall SetDebugFrameTopLineColor(const System::Uitypes::TColor AColor);
	__property System::Types::TPoint SelStartN = {read=GetSelStartNorm};
	__property System::Types::TPoint SelEndN = {read=GetSelEndNorm};
	void __fastcall SetBorderStyle(Vcl::Forms::TBorderStyle AStyle);
	void __fastcall ScrollVertWithCode(int ALineOffset, System::Uitypes::TScrollCode ACode, bool AWithEvent);
	void __fastcall SetHorizScrollWithCode(int AScroll, System::Uitypes::TScrollCode ACode);
	void __fastcall SetHorizScroll(int AScroll);
	void __fastcall SetTopLineScroll(int ALine);
	void __fastcall SetTopLinePhysical(int ALine);
	int __fastcall GetHorizScroll(void);
	int __fastcall GetTopLinePhysical(void);
	int __fastcall GetTopLineScroll(void);
	void __fastcall InvalidateScreen(bool AFull);
	System::Types::TPoint __fastcall ScreenPosToScrollLow(const System::Types::TPoint &AScreen, bool DoCheck = true);
	int __fastcall ScreenToPhysical(int AScreen);
	int __fastcall ScreenToScroll(int AScreen);
	System::Types::TPoint __fastcall ScreenPosToScroll(const System::Types::TPoint &AScreen);
	System::Types::TRect __fastcall ScreenLineToClient(int AScreen);
	System::Types::TPoint __fastcall ClientToScreenPos(const System::Types::TPoint &AClient, /* out */ TLMDEditScreenPart &ScreenPart);
	bool __fastcall ClientToGutterScreen(const System::Types::TPoint &AClient, /* out */ int &AScreenLine, /* out */ TLMDGutterBar* &ABarHere);
	int __fastcall LastLineScroll(void);
	void __fastcall CorrectSelPointsBlockMode(System::Types::TPoint &AStart, System::Types::TPoint &AEnd);
	void __fastcall UpdateMouseCursor(void);
	HIDESBASE MESSAGE void __fastcall WMChar(Winapi::Messages::TWMKey &Msg);
	void __fastcall ScrollTimerHandler(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Winapi::Messages::TWMSetCursor &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall WMCaptureChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Winapi::Messages::TWMScroll &Msg);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Msg);
	MESSAGE void __fastcall WMClear(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall WMCopy(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMCut(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMPaste(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMGetText(Winapi::Messages::TWMGetText &Msg);
	MESSAGE void __fastcall WMGetTextLength(Winapi::Messages::TWMNoParams &Msg);
	void __fastcall SetScrollBars(System::Uitypes::TScrollStyle AScrollbars);
	void __fastcall SetScrollTimerBase(int ABaseInt);
	void __fastcall SetMaxHorizScroll(int AMaxHorizScroll);
	int __fastcall MaxHorizScrollActual(void);
	int __fastcall CharsOnScreen(void);
	void __fastcall UpdateScrollbars(void);
	void __fastcall FillDefaultKeybindings(void);
	void __fastcall DrawBmp(Vcl::Graphics::TCanvas* ACnv, Vcl::Graphics::TBitmap* ABmp, const System::Types::TRect &R, System::Classes::TAlignment Alignement = (System::Classes::TAlignment)(0x2));
	
protected:
	TLMDEditInternalStates FState;
	TLMDEditSearchArguments FSearchArgs;
	TLMDEditViewSearchState FSearchState;
	int FSearchNumOfReplacements;
	Lmdseddocument::TLMDEditFindReplaceState* FSearchStateBag;
	System::Contnrs::TObjectList* FSearchIncJumps;
	HRESULT __stdcall DragEnterI(const _di_IDataObject dataObj, int grfKeyState, const System::Types::TPoint pt, int &dwEffect);
	HRESULT __stdcall DragOverI(int grfKeyState, const System::Types::TPoint pt, int &dwEffect);
	HRESULT __stdcall DragLeaveI(void);
	HRESULT __stdcall DropI(const _di_IDataObject dataObj, int grfKeyState, const System::Types::TPoint pt, int &dwEffect);
	int __fastcall WinCharPosToOffset(int ACharPos);
	System::Types::TPoint __fastcall WinCharPosToScrollPos(int ACharPos);
	int __fastcall OffsetToWinCharPos(int AOffset);
	int __fastcall ScrollPosToWinCharPos(const System::Types::TPoint &APos);
	Lmdsedutils::TLMDSegment __fastcall GetScrollLineSeg_Addict(int ALine);
	void __fastcall UpdateAddictCheckTokenIds(void);
	void __fastcall ClearAddictCheckTokenIds(void);
	bool __fastcall HasAddictCheckToken(int ATokenId);
	int __fastcall AddictCheckTokenCount(void);
	MESSAGE void __fastcall EM_SetReadOnly(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_GetModify(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_SetModify(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_ReplaceSel(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_GetSel(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_SetSel(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_LineFromChar(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_LineFromCharEx(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_CharFromPos(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_EmptyUndoBuffer(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_LineIndex(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_PosFromChar(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_CanUndo(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_Undo(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_LineLength(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_GetFirstVisibleLine(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_GetLineCount(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_GetLine(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_LineScroll(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_ExGetSel(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_GetSelText(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_GetCharFormat(Winapi::Messages::TMessage &AMsg);
	MESSAGE void __fastcall EM_FormatRange(Winapi::Messages::TMessage &AMsg);
	void __fastcall FireOnScroll(int &ANewPos, System::Uitypes::TScrollCode ACode, bool AVert);
	bool __fastcall FireOnGutterPaint(const TLMDEditPaintTextArgs &Args, TLMDGutterBar* ABar);
	void __fastcall AddStatusChange(TLMDViewStatusChange AChange)/* overload */;
	void __fastcall AddStatusChange(TLMDViewStatusChanges AChanges)/* overload */;
	void __fastcall FireOnStatusChanged(void);
	virtual Vcl::Graphics::TCanvas* __fastcall GetCanvas(void);
	virtual System::Types::TRect __fastcall GetDrawRect(void);
	virtual void __fastcall Beep(void);
	void __fastcall DrawRectChanged(void);
	Lmdseddocument::TLMDEditParserBase* __fastcall Parser(void);
	Lmdseddocument::TLMDEditDocument* __fastcall MyDoc(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	void __fastcall CheckRequiredState(TLMDEditInternalState AMode, bool RequireHave);
	void __fastcall CheckChangesLock(void);
	void __fastcall CheckGutterBarVisible(TLMDGutterBar* ABar);
	void __fastcall CheckDocumentIsSet(void);
	void __fastcall CheckInSearchMode(void);
	void __fastcall CheckInReplaceMode(void);
	void __fastcall CheckNotReadOnly(void);
	bool __fastcall IsDocumentSet(void);
	bool __fastcall IsReadOnly(void);
	void __fastcall LockChangeLock(void);
	void __fastcall UnlockChangeLock(void);
	bool __fastcall IsUpdating(void);
	void __fastcall LockForViewEvent(void);
	void __fastcall UnlockForViewEvent(void);
	void __fastcall IncrementalSearchInit(void);
	void __fastcall IncrementalSearchAddChar(System::WideChar Ch);
	void __fastcall IncrementalSearchBackward(void);
	bool __fastcall IncrementalSearchForward(void);
	void __fastcall IncrementalSearchCancel(void);
	bool __fastcall GetInIncrementalSearch(void);
	void __fastcall CompletionTimerHandler(System::TObject* Sender);
	void __fastcall StopCompletionTimer(void);
	void __fastcall StartCompletionTimer(void);
	void __fastcall CheckShowCompletionList(bool AllowInsideWord, TLMDEditFillCompletionCause ACause, bool AllowNoCombo);
	void __fastcall HideCompletionList(void);
	int __fastcall FillCompletionList(System::Classes::TStrings* AItems, const System::Types::TPoint &AScrollPoint, TLMDEditFillCompletionCause ACause, System::Types::TPoint &AComboPos);
	void __fastcall CommitCompletion(const System::Types::TPoint &AScrollPoint, TLMDEditReplaceCompletionCause ACause);
	void __fastcall CompletionOnClick(System::TObject* Sender);
	void __fastcall SetComplSettings(TLMDEditCompletionSettings* ASettings);
	void __fastcall SetHighlightSettings(TLMDEditHighlightSettings* ASettings);
	Lmdtypes::TLMDString __fastcall GetComplSeparators(void);
	void __fastcall CompletionDrawHandler(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall CompletionMeasureHandler(Vcl::Controls::TWinControl* Control, int Index, int &Height);
	virtual void __fastcall Paint(void);
	HIDESBASE void __fastcall PaintTo(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall PaintGutterLine(const TLMDEditPaintTextArgs &Args);
	virtual void __fastcall PaintTextLine(const TLMDEditPaintTextArgs &Args, const System::Types::TPoint &SelScrS, const System::Types::TPoint &SelScrE);
	virtual void __fastcall PaintLineNumber(const TLMDEditPaintTextArgs &Args);
	virtual void __fastcall DefaultGutterPaint(const TLMDEditPaintTextArgs &Args, TLMDGutterBar* ABar, TLMDGutterBarKind APaintKind);
	void __fastcall DefaultGutterPaintCbk(int AScreenLine, TLMDGutterBar* ABar, TLMDGutterBarKind APaintKind, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &APaintRect);
	void __fastcall BeginSettingsChange(void);
	void __fastcall EndSettingsChange(bool ABlockEvent, bool AResetCache);
	bool __fastcall IsCursorInScreenBounds(void);
	Lmdseddocument::TLMDDocUndoInfo* __fastcall CreateCursorUndoInfo(void);
	Lmdseddocument::TLMDDocUndoInfo* __fastcall CreateUndoInfo(const TOffsetPoint &AOffPt);
	void __fastcall SetCursorAsUndoInfo(Lmdseddocument::TLMDDocUndoInfo* AInfo);
	System::Types::TPoint __fastcall UI_GetCursorMovePoint(TLMDCursorMoveDirection ADirection, TLMDCursorMoveUnit AUnit, bool AWithSel, bool ABlock)/* overload */;
	System::Types::TPoint __fastcall UI_GetCursorMovePoint(const System::Types::TPoint &APoint, TLMDCursorMoveDirection ADirection, TLMDCursorMoveUnit AUnit, bool AWithSel, bool ABlock)/* overload */;
	void __fastcall UI_MoveCursorToOffGen(const TOffsetPoint &AOffPt, bool AWithSel, bool ABlock);
	bool __fastcall UI_MoveCursorTo(TLMDCursorMoveDirection ADirection, TLMDCursorMoveUnit AUnit, bool AWithSel, bool ABlock);
	void __fastcall UI_MoveCursorByPage(bool ADown, bool AWithSelect, bool ABlock);
	void __fastcall UI_Delete(TLMDCursorMoveDirection ADirection, TLMDCursorMoveUnit AUnit);
	void __fastcall UI_UndoRedo(bool AUndo);
	bool __fastcall UI_CanUndoRedo(bool AUndo);
	void __fastcall UI_ScrollUpDown(bool AUp);
	void __fastcall UI_BackspaceOrUnindent(void);
	void __fastcall UI_IndentOrTab(void);
	void __fastcall UI_IndentSelection(bool AUnindent, bool AUsePrevIndent);
	void __fastcall MoveCursorAndSelToBounds(void);
	void __fastcall SetSelection(const TOffsetPoint &AStartOffset, const TOffsetPoint &AEndOffset, bool ABlockMode)/* overload */;
	bool __fastcall FindIndentSeg(int AFindStartLine, int AVisWidth, bool AFindGreater, /* out */ int &FoundWidth, /* out */ Lmdsedutils::TLMDSegment &FoundSeg);
	Lmdtypes::TLMDString __fastcall FindIndentStr(int AFindStartLine, int AVisWidth, bool AFindGreater);
	int __fastcall FindNoSpaceOffset(int APhysLine, bool AVisibleOnly = true);
	bool __fastcall MoveToIndentPos(const System::Types::TPoint &AMovePoint, bool ABackward);
	void __fastcall DeleteInScrollEx(const System::Types::TPoint &AScrollStart, const System::Types::TPoint &AScrollEnd, bool RememberCursor, /* out */ TOffsetPoint &AStartOffset)/* overload */;
	bool __fastcall UI_DeleteToLineEnd(bool AToScrollEnd);
	bool __fastcall UI_DeleteLine(void);
	void __fastcall FreeSearchState(void);
	void __fastcall AskForReplaceAction(bool AForReplaceAll, Lmdseddocument::TLMDEditFindReplaceState* const AState, int &ReplacedCount, Lmdseddocument::TLMDEditReplaceAction &Action);
	TLMDEditNotFoundAction __fastcall AskForNotFound(void);
	void __fastcall ReplaceNextProc(System::TObject* Sender, Lmdseddocument::TLMDEditFindReplaceState* const AState, int &ReplacedCount, Lmdseddocument::TLMDEditReplaceAction &Action);
	void __fastcall ReplaceAllProc(System::TObject* Sender, Lmdseddocument::TLMDEditFindReplaceState* const AState, int &ReplacedCount, Lmdseddocument::TLMDEditReplaceAction &Action);
	bool __fastcall SearchNextLow(bool AFirstTime);
	System::Types::TPoint __fastcall FindNextEndOrStartOfWord(const System::Types::TPoint &APt, bool AFwd);
	System::Types::TPoint __fastcall FindNextEndOrStartOfLine(const System::Types::TPoint &APt, bool AFwd);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Resize(void);
	virtual bool __fastcall CanResize(int &NewWidth, int &NewHeight);
	void __fastcall FireGutterClick(System::Uitypes::TMouseButton AButton, System::Classes::TShiftState AShift, const System::Types::TPoint &ClientPoint, bool Handled);
	void __fastcall FireGetMouseCursor(const System::Types::TPoint &AScrollPos, System::Uitypes::TCursor &ACursor);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall CheckStartScrollTimer(int X, int Y, bool AStartAtEdge);
	void __fastcall StopScrollTimer(void);
	DYNAMIC void __fastcall DragCanceled(void);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	DYNAMIC bool __fastcall DoMouseWheel(System::Classes::TShiftState Shift, int WheelDelta, const System::Types::TPoint &MousePos);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall KeyPressW(System::WideChar &Key);
	void __fastcall DoKeyPressW(Winapi::Messages::TWMKey &AMsg);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* AFiler);
	void __fastcall LoadGutterBarsEmpty(System::Classes::TReader* AReader);
	void __fastcall SaveGutterBarsEmpty(System::Classes::TWriter* AWriter);
	virtual void __fastcall ReadState(System::Classes::TReader* AReader);
	__property System::Uitypes::TScrollStyle ScrollBars = {read=FScrollBars, write=SetScrollBars, default=3};
	__property System::Uitypes::TCursor GutterCursor = {read=FGutterCursor, write=FGutterCursor, default=0};
	__property int ScrollTimeBaseInterval = {read=FScrollTimerBase, write=SetScrollTimerBase, default=100};
	__property bool WantReturns = {read=FWantReturns, write=FWantReturns, default=1};
	__property bool WantTabs = {read=FWantTabs, write=FWantTabs, default=1};
	__property TMouseCursorEvent OnGetMouseCursor = {read=FOnMouseCursor, write=FOnMouseCursor};
	__property TLMDGutterClickEvent OnGutterClick = {read=FOnGutterClick, write=FOnGutterClick};
	__property TKeyPressWEvent OnKeyPressW = {read=FOnKeyPressW, write=FOnKeyPressW};
	__property TLMDEditBeforeCommandEvent OnBeforeCommand = {read=FOnBeforeCommand, write=FOnBeforeCommand};
	__property TLMDEditAfterCommandEvent OnAfterCommand = {read=FOnAfterCommand, write=FOnAfterCommand};
	__property TLMDEditGetLineAttrsEvent OnGetLineAttributes = {read=FOnGetLineAttrs, write=FOnGetLineAttrs};
	__property int MaxHorizScroll = {read=FMaxHorizScroll, write=SetMaxHorizScroll, default=500};
	__property int HorizScroll = {read=GetHorizScroll, write=SetHorizScroll, default=0};
	__property TLMDViewSettings ViewSettings = {read=FViewSettings, write=SetViewSettings, default=1330};
	__property System::Uitypes::TColor ReadOnlyBgColor = {read=FReadOnlyBgColor, write=SetReadOnlyBgColor, default=12632256};
	__property System::Uitypes::TColor WrapRulerColor = {read=FWrapRulerColor, write=SetWrapRulerColor, default=8421504};
	__property System::Uitypes::TColor SelectedLineBg = {read=FSelectedLineBg, write=SetSelectedLineBg, default=15138810};
	__property System::Uitypes::TColor BreakpointLineColor = {read=FBreakpointLineColor, write=SetBreakpointLineColor, default=0};
	__property System::Uitypes::TColor BreakpointLineBg = {read=FBreakpointLineBg, write=SetBreakpointLineBg, default=16762823};
	__property System::Uitypes::TColor DebugFrameLineColor = {read=FDebugFrameLineColor, write=SetDebugFrameLineColor, default=0};
	__property System::Uitypes::TColor DebugFrameLineBg = {read=FDebugFrameLineBg, write=SetDebugFrameLineBg, default=15134702};
	__property System::Uitypes::TColor DebugFrameActiveLineColor = {read=FDebugFrameActiveLineColor, write=SetDebugFrameActiveLineColor, default=0};
	__property System::Uitypes::TColor DebugFrameActiveLineBg = {read=FDebugFrameActiveLineBg, write=SetDebugFrameActiveLineBg, default=10066380};
	__property System::Uitypes::TColor DebugFrameTopLineColor = {read=FDebugFrameTopLineColor, write=SetDebugFrameTopLineColor, default=0};
	__property System::Uitypes::TColor DebugFrameTopLineBg = {read=FDebugFrameTopLineBg, write=SetDebugFrameTopLineBg, default=10066380};
	__property System::Uitypes::TColor SelectionBg = {read=FSelectionBg, write=SetSelectionBg, default=10841427};
	__property System::Uitypes::TColor SelectionColor = {read=FSelectionColor, write=SetSelectionColor, default=16777215};
	__property int WrapRulerWidth = {read=GetWrapRulerWidth, write=SetWrapRulerWidth, default=80};
	__property TLMDViewWrapMode WrapMode = {read=GetWrapMode, write=SetWrapMode, default=0};
	__property int TabWidth = {read=FTabWidth, write=SetTabWidth, default=8};
	__property int IndentWidth = {read=FIndentWidth, write=SetIndentWidth, default=4};
	__property System::Types::TPoint SelectionStart = {read=GetSelStart, write=SetSelStart};
	__property System::Types::TPoint SelectionEnd = {read=GetSelEnd, write=SetSelEnd};
	__property bool SelectionBlockMode = {read=GetSelBlockMode, write=SetSelBlockMode, nodefault};
	__property System::Types::TPoint SelectionStartNorm = {read=GetSelStartNorm};
	__property System::Types::TPoint SelectionEndNorm = {read=GetSelEndNorm};
	__property int SelectionOffsetStart = {read=GetSelOffsetStart, write=SetSelOffsetStart, nodefault};
	__property int SelectionOffsetEnd = {read=GetSelOffsetEnd, write=SetSelOffsetEnd, nodefault};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property int TopLineScroll = {read=GetTopLineScroll, write=SetTopLineScroll, nodefault};
	__property int TopLinePhysical = {read=GetTopLinePhysical, write=SetTopLinePhysical, nodefault};
	__property bool SelAvail = {read=GetSelAvail, nodefault};
	__property TLMDGutter* Gutter = {read=FGutter, write=SetGutter};
	__property TLMDSpecialChars* SpecialChars = {read=FSpecialChars, write=SetSpecialChars};
	__property Vcl::Stdctrls::TScrollEvent OnScroll = {read=FOnScroll, write=FOnScroll};
	__property TLMDGutterPaintEvent OnGutterPaint = {read=FOnGutterPaint, write=FOnGutterPaint};
	__property TLMDViewStatusChangeEvent OnStatusChanged = {read=FOnStatusChanged, write=FOnStatusChanged};
	__property TLMDEditNotFoundEvent OnNotFound = {read=FOnNotFound, write=FOnNotFound};
	__property Lmdseddocument::TLMDEditReplaceEvent OnReplaceFound = {read=FOnReplaceFound, write=FOnReplaceFound};
	__property TLMDEditFillCompletionListEvent OnFillCompletionList = {read=FComplOnFill, write=FComplOnFill};
	__property TLMDEditReplaceForCompletionResultEvent OnCompletionReplace = {read=FComplCommit, write=FComplCommit};
	__property TLMDEditDrawCompletionItemEvent OnCompletionCustomDraw = {read=FComplOnDraw, write=FComplOnDraw};
	__property TLMDEditMeasureCompletionItemEvent OnCompletionMeasureItem = {read=FComplOnMeasure, write=FComplOnMeasure};
	__property int ScreenHeight = {read=GetScreenHeight, nodefault};
	__property int LinesOnScreenScroll = {read=GetLinesOnScreenScroll, nodefault};
	__property System::Types::TPoint CursorPos = {read=GetCursorPos, write=SetCursorPos};
	__property int CursorPosX = {read=GetCursorPosX, write=SetCursorPosX, nodefault};
	__property int CursorPosY = {read=GetCursorPosY, write=SetCursorPosY, nodefault};
	__property int CursorOffset = {read=GetCursorAsOffset, write=SetCursorAsOffset, nodefault};
	__property bool CanCopy = {read=GetCanCopy, nodefault};
	__property bool CanCut = {read=GetCanCut, nodefault};
	__property bool CanPaste = {read=GetCanPaste, nodefault};
	__property bool CanUndo = {read=GetCanUndo, nodefault};
	__property bool CanRedo = {read=GetCanRedo, nodefault};
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property int StoreDocSettingsLimit = {read=GetStoreDocSettingsLimit, write=SetStoreDocSettingsLimit, default=100};
	__property TLMDEditCompletionSettings* CompletionSettings = {read=FComplSettings, write=SetComplSettings};
	__property TLMDEditHighlightSettings* HighlightSettings = {read=FHighlightSettings, write=SetHighlightSettings};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	
public:
	__fastcall virtual TLMDCustomEditView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomEditView(void);
	void __fastcall InvokeCommand(TLMDEditCommand ACommand, const System::Variant &AArg, bool AllowCommandEvents)/* overload */;
	void __fastcall InvokeCommand(TLMDEditCommand ACommand, bool AllowCommandEvents)/* overload */;
	TLMDEditCommandList* __fastcall GetDefaultKeyBindings(void);
	int __fastcall GetNextVisibleLine(int ALine);
	int __fastcall GetPrevVisibleLine(int ALine);
	void __fastcall Fold(int APhysLine, bool All);
	void __fastcall Unfold(int APhysLine, bool All);
	void __fastcall FoldAllIn(int AOuterFold, bool TopOnly);
	void __fastcall UnfoldAllIn(int AOuterFold, bool TopOnly);
	void __fastcall EnsureVisible(int ALine);
	void __fastcall EnsureOffsetIsVisible(int AOffset);
	bool __fastcall IsLineStartVisible(int APhysLine);
	bool __fastcall IsOffsetVisible(int AOffset);
	bool __fastcall IsCollapsedFold(int APhysLine);
	bool __fastcall IsFoldStart(int APhysLine);
	int __fastcall GetVisibleCountScroll(void);
	System::Types::TRect __fastcall GutterLineToClient(int AScreenLine, TLMDGutterBar* ABar);
	bool __fastcall ClientToGutter(const System::Types::TPoint &AClient, /* out */ int &AScrollLine, /* out */ TLMDGutterBar* &ABarHere);
	System::Types::TPoint __fastcall ClientToScrollPos(const System::Types::TPoint &AClient, /* out */ TLMDEditScreenPart &ScreenPart)/* overload */;
	System::Types::TPoint __fastcall ClientToScrollPos(const System::Types::TPoint &AClient)/* overload */;
	System::Types::TRect __fastcall ScrollPosToClient(const System::Types::TPoint &AScrollPos, /* out */ bool &OutOfScreen);
	int __fastcall PhysicalToScroll(int ALine);
	int __fastcall ScrollToPhysical(int ALine);
	void __fastcall ScrollPosToPhysical(const System::Types::TPoint &APoint, /* out */ int &APhysLine, /* out */ int &ACol);
	System::Types::TPoint __fastcall OffsetToScrollPos(int AOffset);
	int __fastcall ScrollPosToNearestOffset(const System::Types::TPoint &AScroll);
	void __fastcall SetSelection(const System::Types::TPoint &AStart, const System::Types::TPoint &AEnd, bool ABlockMode)/* overload */;
	void __fastcall SetSelection(int AStartOffset, int AEndOffset, bool ABlockMode)/* overload */;
	void __fastcall CancelSelection(void);
	void __fastcall ScrollVertBy(int ALineOffset);
	void __fastcall ScrollToCursor(void);
	void __fastcall ScrollToPos(const System::Types::TPoint &AScrollPos)/* overload */;
	void __fastcall ScrollToPos(const System::Types::TPoint &AScrollPos, bool AvoidScreenEdge)/* overload */;
	void __fastcall DeleteInScroll(const System::Types::TPoint &AScrollStart, const System::Types::TPoint &AScrollEnd);
	void __fastcall DeleteInScrollEx(const System::Types::TPoint &AScrollStart, const System::Types::TPoint &AScrollEnd, /* out */ TOffsetPoint &AStartOffset)/* overload */;
	void __fastcall DeleteInScrollBlock(const System::Types::TPoint &AScrollStart, const System::Types::TPoint &AScrollEnd, /* out */ TOffsetPoint &AStartOffset);
	void __fastcall InsertInScroll(const System::Types::TPoint &AScroll, const Lmdtypes::TLMDString AStr);
	void __fastcall InsertInScrollBlock(const System::Types::TPoint &AScroll, const Lmdtypes::TLMDString AStr, /* out */ int &AMaxWidth, /* out */ TOffsetPoint &AStartOffset, /* out */ TOffsetPoint &AEndOffset)/* overload */;
	void __fastcall InsertInScrollBlock(const System::Types::TPoint &AScroll, const Lmdtypes::TLMDString AStr, /* out */ int &AMaxWidth, /* out */ int &AStartOffset, /* out */ int &AEndOffset)/* overload */;
	void __fastcall InsertInScrollEx(const System::Types::TPoint &AScroll, const Lmdtypes::TLMDString AStr, /* out */ int &AStartOffset, /* out */ int &AEndOffset)/* overload */;
	void __fastcall InsertInScrollEx(const System::Types::TPoint &AScroll, const Lmdtypes::TLMDString AStr, bool RememberCursor, /* out */ int &AStartOffset, /* out */ int &AEndOffset, bool AWithSpacesBefore)/* overload */;
	void __fastcall ReplaceInScroll(const System::Types::TPoint &AScrollStart, const System::Types::TPoint &AScrollEnd, const Lmdtypes::TLMDString AStr);
	void __fastcall ReplaceInScrollEx(const System::Types::TPoint &AScrollStart, const System::Types::TPoint &AScrollEnd, const Lmdtypes::TLMDString AStr, /* out */ int &AStartOffset, /* out */ int &AEndOffset)/* overload */;
	void __fastcall ReplaceInScrollEx(const System::Types::TPoint &AScrollStart, const System::Types::TPoint &AScrollEnd, const Lmdtypes::TLMDString AStr, bool RememberCursor, /* out */ int &AStartOffset, /* out */ int &AEndOffset)/* overload */;
	Lmdsedutils::TLMDCharSeq* __fastcall CreateScrollTextSeqAdapter(const System::Types::TPoint &AScrollStart, const System::Types::TPoint &AScrollEnd, bool ABlock);
	Lmdtypes::TLMDString __fastcall GetWordUnderCursor(void);
	void __fastcall GotoBookmark(const Lmdtypes::TLMDString AName);
	void __fastcall GotoBreakpoint(const Lmdtypes::TLMDString AName);
	void __fastcall GotoPhysLine(int ALine);
	void __fastcall GotoOffset(int AOffset);
	void __fastcall SelectAll(void);
	void __fastcall DeleteSelected(void);
	void __fastcall CopySelection(void);
	void __fastcall CutSelection(void);
	void __fastcall Paste(void);
	void __fastcall IndentSelection(bool AUsePrevIndent = false);
	void __fastcall UnindentSelection(bool AUsePrevIndent = false);
	void __fastcall InsertTabAtCursor(bool AOverwrite);
	void __fastcall InsertReturnAtCursor(bool AOverwrite);
	void __fastcall InsertCharAtCursor(System::WideChar AChar, int ACount, bool AOverwrite);
	void __fastcall InsertAtCursor(const Lmdtypes::TLMDString AStr, bool AOverwrite);
	void __fastcall DeleteCharLeft(void);
	void __fastcall DeleteCharRight(void);
	void __fastcall DeleteWordLeft(void);
	void __fastcall DeleteWordRight(void);
	void __fastcall Undo(void);
	void __fastcall Redo(void);
	void __fastcall MoveToNextWord(bool AWithSelect, bool ABlock);
	void __fastcall MoveToPrevWord(bool AWithSelect, bool ABlock);
	void __fastcall MoveToNextChar(bool AWithSelect, bool ABlock);
	void __fastcall MoveToPrevChar(bool AWithSelect, bool ABlock);
	void __fastcall MoveToNextLine(bool AWithSelect, bool ABlock);
	void __fastcall MoveToPrevLine(bool AWithSelect, bool ABlock);
	void __fastcall MoveToFirstScreenLine(bool AWithSelect, bool ABlock);
	void __fastcall MoveToLastScreenLine(bool AWithSelect, bool ABlock);
	void __fastcall MoveToNextPage(bool AWithSelect, bool ABlock);
	void __fastcall MoveToPrevPage(bool AWithSelect, bool ABlock);
	void __fastcall MoveToLineStart(bool AWithSelect, bool ABlock);
	void __fastcall MoveToLineEnd(bool AWithSelect, bool ABlock);
	void __fastcall MoveToTextStart(bool AWithSelect, bool ABlock);
	void __fastcall MoveToTextEnd(bool AWithSelect, bool ABlock);
	void __fastcall ScrollUp(void);
	void __fastcall ScrollDown(void);
	int __fastcall CompletionFillListDef(System::Classes::TStrings* AItems, const System::Types::TPoint &ACursorPoint, TLMDEditFillCompletionCause ACause, System::Types::TPoint &APosForCombo);
	DYNAMIC void __fastcall DragDrop(System::TObject* Source, int X, int Y);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void)/* overload */;
	void __fastcall EndUpdate(bool AFullRepaint)/* overload */;
	void __fastcall InvalidateScrollLine(int AScrollLine);
	bool __fastcall SearchFirst(const TLMDEditSearchArguments &Args);
	bool __fastcall SearchNext(void);
	bool __fastcall ReplaceFirst(const TLMDEditSearchArguments &Args);
	bool __fastcall ReplaceNext(void);
	bool __fastcall ReplaceAll(const TLMDEditSearchArguments &Args, TLMDEditViewReplaceAllBounds ABounds);
	void __fastcall AssignSearchReplaceArgs(const TLMDEditSearchArguments &Args, TLMDEditViewSearchState AState);
	void __fastcall AddHighlight(int AStart, int ACount);
	void __fastcall RemoveHighlight(int AStart, int ACount);
	void __fastcall ClearHighlight(void);
	__property TLMDEditViewSearchState SearchState = {read=FSearchState, nodefault};
	__property TLMDEditSearchArguments SearchLastArgs = {read=FSearchArgs};
	__property int SearchLastNumReplacements = {read=FSearchNumOfReplacements, nodefault};
	__property bool InIncrementalSearch = {read=GetInIncrementalSearch, nodefault};
	__property TLMDEditCommandList* CustomKeyBindings = {read=FCustomCommands, write=SetCustomCommands};
	__property System::Classes::TStrings* SyntaxCheckTokens = {read=FAddictCheckTokens, write=SetSyntaxCheckTokens};
	__property Lmdseddocument::TLMDEditDocument* Document = {read=FFDoc, write=SetDocument};
	__property Lmdtypes::TLMDString SelectedText = {read=GetSelectedText, write=SetSelectedText};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomEditView(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
private:
	void *__IDropTarget;	// IDropTarget 
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {00000122-0000-0000-C000-000000000046}
	operator _di_IDropTarget()
	{
		_di_IDropTarget intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator IDropTarget*(void) { return (IDropTarget*)&__IDropTarget; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


class PASCALIMPLEMENTATION TLMDEditView : public TLMDCustomEditView
{
	typedef TLMDCustomEditView inherited;
	
public:
	__property ScreenHeight;
	__property LinesOnScreenScroll;
	__property TopLineScroll;
	__property TopLinePhysical;
	__property HorizScroll = {default=0};
	__property SelectionStart;
	__property SelectionEnd;
	__property SelAvail;
	__property SelectionOffsetStart;
	__property SelectionOffsetEnd;
	__property SelectionBlockMode;
	__property CursorPos;
	__property CursorPosX;
	__property CursorPosY;
	__property CursorOffset;
	__property CanCopy;
	__property CanCut;
	__property CanPaste;
	__property CanUndo;
	__property CanRedo;
	__property SelectedText = {default=0};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property ShowHint;
	__property Visible = {default=1};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelOuter = {index=1, default=1};
	__property BevelKind = {default=0};
	__property BevelWidth = {default=1};
	__property BorderWidth = {default=0};
	__property BorderStyle = {default=1};
	__property Ctl3D;
	__property ParentCtl3D = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Document;
	__property ViewSettings = {default=1330};
	__property TabWidth = {default=8};
	__property IndentWidth = {default=4};
	__property WrapMode = {default=0};
	__property WrapRulerWidth = {default=80};
	__property WantReturns = {default=1};
	__property WantTabs = {default=1};
	__property Color = {default=16777215};
	__property Cursor = {default=-4};
	__property ReadOnlyBgColor = {default=12632256};
	__property WrapRulerColor = {default=8421504};
	__property SelectedLineBg = {default=15138810};
	__property BreakpointLineColor = {default=0};
	__property BreakpointLineBg = {default=16762823};
	__property DebugFrameLineColor = {default=0};
	__property DebugFrameLineBg = {default=15134702};
	__property DebugFrameActiveLineColor = {default=0};
	__property DebugFrameActiveLineBg = {default=10066380};
	__property DebugFrameTopLineColor = {default=0};
	__property DebugFrameTopLineBg = {default=10066380};
	__property SelectionBg = {default=10841427};
	__property SelectionColor = {default=16777215};
	__property Font;
	__property Gutter;
	__property SpecialChars;
	__property CustomKeyBindings;
	__property SyntaxCheckTokens;
	__property ScrollBars = {default=3};
	__property StoreDocSettingsLimit = {default=100};
	__property CompletionSettings;
	__property HighlightSettings;
	__property MaxHorizScroll = {default=500};
	__property ReadOnly = {default=0};
	__property OnScroll;
	__property OnGetMouseCursor;
	__property OnGutterClick;
	__property OnGutterPaint;
	__property OnStatusChanged;
	__property OnNotFound;
	__property OnReplaceFound;
	__property OnFillCompletionList;
	__property OnCompletionReplace;
	__property OnCompletionCustomDraw;
	__property OnCompletionMeasureItem;
	__property OnKeyPressW;
	__property OnBeforeCommand;
	__property OnAfterCommand;
	__property OnGetLineAttributes;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnClick;
	__property OnContextPopup;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnEnter;
	__property OnExit;
	__property OnResize;
public:
	/* TLMDCustomEditView.Create */ inline __fastcall virtual TLMDEditView(System::Classes::TComponent* AOwner) : TLMDCustomEditView(AOwner) { }
	/* TLMDCustomEditView.Destroy */ inline __fastcall virtual ~TLMDEditView(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDEditView(HWND ParentWindow) : TLMDCustomEditView(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define LMDSED_CLIPBOARD_FORMAT L"LMD Syntax Editor Control Block Type"
extern DELPHI_PACKAGE int MAX_SCROLL;
static const System::Word MAX_HORIZ_SCROLL = System::Word(0x1f4);
static const System::Int8 STORED_VIEW_DOC_LIMIT = System::Int8(0x64);
static const System::Int8 SCROLL_TIMER_BASE = System::Int8(0x64);
static const System::Byte MAX_TAB_WIDTH = System::Byte(0xc8);
static const System::Word COMPLETION_TIMEOUT = System::Word(0x1f4);
static const bool COMPLETION_TIMEOUT_USE = true;
static const System::Int8 COMPLETION_MINCHARS = System::Int8(0x3);
static const bool COMPLETION_CASESENS = false;
static const bool COMPLETION_NOCOMBO_ONLY = true;
static const System::Int8 COMPLETION_ITEM_HEIGHT = System::Int8(0x10);
static const int DEFAULT_HIGHLIGHT_BG = int(65535);
static const int DEFAULT_HIGHLIGHT_TEXT = int(0);
extern DELPHI_PACKAGE TLMDSpecialCharKinds SpecialCharsLineSpaces;
extern DELPHI_PACKAGE unsigned __fastcall LMDSedClipboadFormat(void);
}	/* namespace Lmdsedview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSEDVIEW)
using namespace Lmdsedview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsedviewHPP
