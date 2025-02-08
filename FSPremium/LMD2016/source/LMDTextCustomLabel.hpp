// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextCustomLabel.pas' rev: 31.00 (Windows)

#ifndef LmdtextcustomlabelHPP
#define LmdtextcustomlabelHPP

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
#include <Vcl.Themes.hpp>
#include <LMDClass.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDProcs.hpp>
#include <LMDTextObject.hpp>
#include <LMDGraph.hpp>
#include <LMDText.hpp>
#include <LMDTextContainer.hpp>
#include <LMDBaseControl.hpp>
#include <LMDTypes.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextcustomlabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextCustomLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextCustomLabel : public Lmdbasegraphiccontrol::TLMDBaseGraphicControl
{
	typedef Lmdbasegraphiccontrol::TLMDBaseGraphicControl inherited;
	
private:
	Lmdtextcontainer::TLMDTextContainer* FContainer;
	int FIndex;
	Lmdtextcontainer::TLMDTextChangeLink* FChangeLink;
	bool FCheck;
	Lmdgraph::TLMDAlignment FAlignment;
	Lmdtextobject::TLMDTextObject* FText;
	Lmdtextobject::TLMDStrings* FLines;
	bool FDBControl;
	bool FWordWrap;
	Lmdtextobject::TLMDLinkClickEvent FOnLinkClick;
	Lmdtext::TLMDGetVariableEvent FOnGetVariable;
	Lmdtext::TLMDRepeatEvent FOnRepeat;
	void __fastcall SetAlignment(Lmdgraph::TLMDAlignment aValue);
	void __fastcall SetWordWrap(bool aValue);
	void __fastcall SetTextObject(Lmdtextobject::TLMDTextObject* aValue);
	void __fastcall SetLines(Lmdtextobject::TLMDStrings* aValue);
	void __fastcall SetContainer(Lmdtextcontainer::TLMDTextContainer* aValue);
	HIDESBASE void __fastcall SetIndex(int aValue);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	
protected:
	DYNAMIC void __fastcall AdjustSize(void);
	virtual System::UnicodeString __fastcall GetLabelText(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall DoLinkClick(System::Uitypes::TMouseButton aButton, System::Classes::TShiftState aShift, const System::UnicodeString aLinkText);
	virtual void __fastcall DoGraphicError(System::TObject* Sender, Vcl::Graphics::TPicture* aPicture, const System::UnicodeString aFileName, int aImageIndex);
	virtual System::UnicodeString __fastcall DoGetVariable(System::TObject* Sender, const System::UnicodeString aVarName);
	virtual void __fastcall DoRepeat(System::TObject* Sender, int aNumber);
	void __fastcall DoTxtChange(System::TObject* Sender);
	virtual bool __fastcall GetEmpty(void);
	bool __fastcall LinkEmpty(void);
	__property Lmdtextobject::TLMDStrings* Lines = {read=FLines, write=SetLines};
	void __fastcall OnlyReParse(void);
	virtual void __fastcall Paint(void);
	System::Uitypes::TColor __fastcall GetThemedTextColor(void);
	
public:
	void __fastcall ReParse(void);
	__fastcall virtual TLMDTextCustomLabel(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDTextCustomLabel(void);
	__property bool DBControl = {read=FDBControl, write=FDBControl, nodefault};
	
__published:
	__property About = {default=0};
	__property Lmdgraph::TLMDAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Font;
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property ImageIndex = {index=0, default=0};
	__property PopupMenu;
	__property ParentFont = {default=1};
	__property Hint = {default=0};
	__property ShowHint;
	__property Transparent = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentColor = {default=1};
	__property Visible = {default=1};
	__property Align = {default=0};
	__property AutoSize = {default=0};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=1};
	__property Lmdtextobject::TLMDTextObject* TextSettings = {read=FText, write=SetTextObject};
	__property Lmdtextobject::TLMDLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property Lmdtext::TLMDGetVariableEvent OnGetVariable = {read=FOnGetVariable, write=FOnGetVariable};
	__property Lmdtext::TLMDRepeatEvent OnRepeat = {read=FOnRepeat, write=FOnRepeat};
	__property Lmdtextcontainer::TLMDTextContainer* TextContainer = {read=FContainer, write=SetContainer};
	__property int TextIndex = {read=FIndex, write=SetIndex, default=0};
	__property bool CheckContainerLinks = {read=FCheck, write=FCheck, default=0};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextcustomlabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTCUSTOMLABEL)
using namespace Lmdtextcustomlabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextcustomlabelHPP
