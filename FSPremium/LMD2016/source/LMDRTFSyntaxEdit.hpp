// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFSyntaxEdit.pas' rev: 31.00 (Windows)

#ifndef LmdrtfsyntaxeditHPP
#define LmdrtfsyntaxeditHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Winapi.RichEdit.hpp>
#include <LMDRTFRichEdit.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>
#include <LMDRTFStorage.hpp>
#include <Vcl.ComCtrls.hpp>
#include <LMDRTFBase.hpp>
#include <LMDRTFRuler.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfsyntaxedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomRichSyntaxEdit;
class DELPHICLASS TLMDRichSyntaxEdit;
class DELPHICLASS TLMDRichSyntaxDefinition;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDRichChangeType : unsigned char { ctUndo, ctUnknown, ctReplSel, ctDelete, ctBack, ctCut, ctPaste, ctMove, ctNone };

class PASCALIMPLEMENTATION TLMDCustomRichSyntaxEdit : public Lmdrtfrichedit::TLMDCustomRichEdit
{
	typedef Lmdrtfrichedit::TLMDCustomRichEdit inherited;
	
private:
	TLMDRichSyntaxDefinition* FSyntaxDefinition;
	TLMDRichChangeType FChangeType;
	CHARRANGE FOldSel;
	bool FForcedChange;
	void __fastcall SetSyntaxDefinition(TLMDRichSyntaxDefinition* const Value);
	
protected:
	virtual void __fastcall Parse(int aStart, int aEnd);
	void __fastcall ParseLines(int aStart, int aEnd);
	HIDESBASE MESSAGE void __fastcall CNNotify(Winapi::Messages::TWMNotify &Message);
	DYNAMIC void __fastcall Change(void);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDCustomRichSyntaxEdit(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomRichSyntaxEdit(void);
	void __fastcall ParseAll(void);
	__property TLMDRichSyntaxDefinition* SyntaxDefinition = {read=FSyntaxDefinition, write=SetSyntaxDefinition};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomRichSyntaxEdit(HWND ParentWindow) : Lmdrtfrichedit::TLMDCustomRichEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDRichSyntaxEdit : public TLMDCustomRichSyntaxEdit
{
	typedef TLMDCustomRichSyntaxEdit inherited;
	
__published:
	__property SyntaxDefinition;
	__property AcceptDropFiles = {default=1};
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property Anchors = {default=3};
	__property AutoURLDetect = {default=0};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property BorderWidth = {default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property HideSelection = {default=1};
	__property HideScrollBars = {default=1};
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property Constraints;
	__property Lines;
	__property LanguageOptions = {default=2};
	__property MaxLength = {default=0};
	__property Mode = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PlainText = {default=0};
	__property PopupMenu;
	__property ReadOnly = {default=0};
	__property RichStorage;
	__property RichStorageItem = {default=-1};
	__property ScrollBars = {default=0};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Title = {default=0};
	__property UndoLimit = {default=100};
	__property Visible = {default=1};
	__property WantTabs = {default=0};
	__property WantReturns = {default=1};
	__property WordWrap = {default=1};
	__property Zoom = {default=0};
	__property OnChange;
	__property OnContextPopup;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnResizeRequest;
	__property OnSaveClipboard;
	__property OnSelectionChange;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnURLClick;
	__property OnRulerTabCreate;
	__property OnRulerTabChange;
	__property OnRulerTabDestroy;
	__property OnRulerFirstIdentChange;
	__property OnRulerLeftIdentChange;
	__property OnRulerRightIdentChange;
public:
	/* TLMDCustomRichSyntaxEdit.Create */ inline __fastcall virtual TLMDRichSyntaxEdit(System::Classes::TComponent* aOwner) : TLMDCustomRichSyntaxEdit(aOwner) { }
	/* TLMDCustomRichSyntaxEdit.Destroy */ inline __fastcall virtual ~TLMDRichSyntaxEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRichSyntaxEdit(HWND ParentWindow) : TLMDCustomRichSyntaxEdit(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRichSyntaxDefinition : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Classes::TStrings* FKeywords;
	TLMDCustomRichSyntaxEdit* FSyntaxEdit;
	Vcl::Graphics::TFont* FKeywordFont;
	Vcl::Graphics::TFont* FStringFont;
	System::WideChar FStringDelim;
	System::Classes::TStrings* FSingleLineComments;
	Vcl::Graphics::TFont* FCommentsFont;
	Vcl::Graphics::TFont* FNumbersFont;
	System::Sysutils::TSysCharSet FSpaces;
	System::Sysutils::TSysCharSet FDelimiters;
	void __fastcall SetKeywords(System::Classes::TStrings* const Value);
	void __fastcall SetKeywordFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetStringFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetStringDelim(const System::WideChar Value);
	void __fastcall SetSingleLineComments(System::Classes::TStrings* const Value);
	void __fastcall SetCommentsFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetNumbersFont(Vcl::Graphics::TFont* const Value);
	
public:
	__fastcall TLMDRichSyntaxDefinition(TLMDCustomRichSyntaxEdit* aSyntaxEdit);
	__fastcall virtual ~TLMDRichSyntaxDefinition(void);
	void __fastcall LoadFromFile(const System::UnicodeString aFileName);
	void __fastcall LoadFromStream(System::Classes::TStream* aStream);
	void __fastcall SaveToFile(const System::UnicodeString aFileName);
	void __fastcall SaveToStream(System::Classes::TStream* aStream);
	__property System::Sysutils::TSysCharSet Spaces = {read=FSpaces, write=FSpaces};
	__property System::Sysutils::TSysCharSet Delimiters = {read=FDelimiters, write=FDelimiters};
	
__published:
	__property System::Classes::TStrings* Keywords = {read=FKeywords, write=SetKeywords};
	__property System::Classes::TStrings* SingleLineComments = {read=FSingleLineComments, write=SetSingleLineComments};
	__property Vcl::Graphics::TFont* KeywordFont = {read=FKeywordFont, write=SetKeywordFont};
	__property Vcl::Graphics::TFont* StringFont = {read=FStringFont, write=SetStringFont};
	__property Vcl::Graphics::TFont* CommentsFont = {read=FCommentsFont, write=SetCommentsFont};
	__property Vcl::Graphics::TFont* NumbersFont = {read=FNumbersFont, write=SetNumbersFont};
	__property System::WideChar StringDelim = {read=FStringDelim, write=SetStringDelim, nodefault};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtfsyntaxedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFSYNTAXEDIT)
using namespace Lmdrtfsyntaxedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfsyntaxeditHPP
