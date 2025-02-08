// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextCustomPanel.pas' rev: 31.00 (Windows)

#ifndef LmdtextcustompanelHPP
#define LmdtextcustompanelHPP

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
#include <Vcl.Themes.hpp>
#include <LMDClass.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDProcs.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDTextObject.hpp>
#include <LMDGraph.hpp>
#include <LMDText.hpp>
#include <LMDTextContainer.hpp>
#include <LMDControl.hpp>
#include <LMDTypes.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDBevel.hpp>
#include <System.UITypes.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDFillObject.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextcustompanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextCustomPanel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextCustomPanel : public Lmdcustompanelfill::TLMDCustomPanelFill
{
	typedef Lmdcustompanelfill::TLMDCustomPanelFill inherited;
	
private:
	Lmdtextcontainer::TLMDTextContainer* FContainer;
	int FIndex;
	Lmdtextcontainer::TLMDTextChangeLink* FChangeLink;
	bool FCheck;
	System::UnicodeString FBaseURL;
	Lmdtextobject::TLMDTextObject* FText;
	Lmdtextobject::TLMDStrings* FLines;
	bool FWordWrap;
	Vcl::Graphics::TFont* FDrawFont;
	Lmdtextobject::TLMDLinkClickEvent FOnLinkClick;
	Lmdtext::TLMDGetVariableEvent FOnGetVariable;
	Lmdtext::TLMDRepeatEvent FOnRepeat;
	Lmdtext::TLMDEmbdControlEvent FOnControlCreated;
	void __fastcall SetTextObject(Lmdtextobject::TLMDTextObject* aValue);
	void __fastcall SetLines(Lmdtextobject::TLMDStrings* aValue);
	void __fastcall SetContainer(Lmdtextcontainer::TLMDTextContainer* aValue);
	HIDESBASE void __fastcall SetIndex(int aValue);
	
protected:
	void __fastcall DoLinkClick(System::Uitypes::TMouseButton aButton, System::Classes::TShiftState aShift, const System::UnicodeString aLinkText);
	void __fastcall DoGraphicError(System::TObject* Sender, Vcl::Graphics::TPicture* aPicture, const System::UnicodeString aFileName, int aImageIndex);
	virtual System::UnicodeString __fastcall DoGetVariable(System::TObject* Sender, const System::UnicodeString aVarName);
	void __fastcall DoRepeat(System::TObject* Sender, int aNumber);
	virtual void __fastcall DoControlCreated(System::TObject* Sender, Vcl::Controls::TControl* AControl, const System::UnicodeString AName);
	virtual void __fastcall DrawCaption(const System::Types::TRect &aRect, Lmdgraph::TLMDAlignment aAlignment);
	System::Uitypes::TColor __fastcall GetThemedTextColor(void);
	virtual void __fastcall DoTxtChange(System::TObject* Sender);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	virtual bool __fastcall GetEmpty(void);
	Lmdtextobject::TLMDStrings* __fastcall GetTextLines(void);
	bool __fastcall LinkEmpty(void);
	__property bool WordWrap = {read=FWordWrap, write=FWordWrap, default=1};
	__property AutoSize = {default=0};
	__property Lmdtextobject::TLMDStrings* Lines = {read=FLines, write=SetLines};
	__property Lmdtextobject::TLMDLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	
public:
	void __fastcall ReParse(void);
	__fastcall virtual TLMDTextCustomPanel(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDTextCustomPanel(void);
	virtual void __fastcall Loaded(void);
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	__property Lmdtextcontainer::TLMDTextContainer* TextContainer = {read=FContainer, write=SetContainer};
	__property int TextIndex = {read=FIndex, write=SetIndex, default=0};
	__property bool CheckContainerLinks = {read=FCheck, write=FCheck, default=0};
	
__published:
	__property About = {default=0};
	__property BackFX;
	__property Bevel;
	__property Color = {default=-16777201};
	__property Font;
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property ImageIndex = {index=0, default=0};
	__property FillObject;
	__property PopupMenu;
	__property ParentFont = {default=1};
	__property Hint;
	__property ShowHint;
	__property Transparent = {default=0};
	__property ParentShowHint = {default=1};
	__property ParentColor = {default=0};
	__property Visible = {default=1};
	__property Align = {default=0};
	__property Lmdtextobject::TLMDTextObject* TextSettings = {read=FText, write=SetTextObject};
	__property Lmdtext::TLMDGetVariableEvent OnGetVariable = {read=FOnGetVariable, write=FOnGetVariable};
	__property Lmdtext::TLMDEmbdControlEvent OnControlCreated = {read=FOnControlCreated, write=FOnControlCreated};
	__property Lmdtext::TLMDRepeatEvent OnRepeat = {read=FOnRepeat, write=FOnRepeat};
	__property Anchors = {default=3};
	__property Constraints;
	__property UseDockManager = {default=1};
	__property DockSite = {default=0};
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnCanResize;
	__property OnConstrainedResize;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
	__property OnGetSiteInfo;
	__property OnStartDock;
	__property OnUnDock;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDrag;
	__property OnContextPopup;
	__property OnMouseActivate;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTextCustomPanel(HWND ParentWindow) : Lmdcustompanelfill::TLMDCustomPanelFill(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextcustompanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTCUSTOMPANEL)
using namespace Lmdtextcustompanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextcustompanelHPP
