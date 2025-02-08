// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFormTabControl.pas' rev: 31.00 (Windows)

#ifndef LmdformtabcontrolHPP
#define LmdformtabcontrolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Themes.hpp>
#include <LMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDFormDisplay.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ImgList.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------
namespace Lmdformtabcontrol
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TLMDCustomFormTabControl;
class PASCALIMPLEMENTATION TLMDCustomFormTabControl : public Comctrls::TCustomTabControl 
{
	typedef Comctrls::TCustomTabControl inherited;	
protected:
	virtual int __fastcall AddFormExt(Forms::TCustomForm* aValue, bool Display) = 0 ;	
public:
	int __fastcall AddForm(Forms::TCustomForm* aValue, bool Display);
public:
	#pragma option push -w-inl
	/* TCustomTabControl.Create */ inline __fastcall virtual TLMDCustomFormTabControl(Classes::TComponent* 
		AOwner) : Comctrls::TCustomTabControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomTabControl.Destroy */ inline __fastcall virtual ~TLMDCustomFormTabControl(void) { }
	#pragma option pop	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomFormTabControl(HWND ParentWindow) : Comctrls::TCustomTabControl(
		ParentWindow) { }
	#pragma option pop
};
};

namespace Lmdformtabcontrol
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFormTabControl;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFormTabControl : public TLMDCustomFormTabControl
{
	typedef TLMDCustomFormTabControl inherited;
	
private:
	bool FUseRes;
	bool FSaveResources;
	Lmdtypes::TLMDAboutVar FAbout;
	System::Classes::TList* FList;
	int FActiveIndex;
	Lmdformdisplay::TLMDFormDisplayChangeEvent FOnChanging;
	void __fastcall SetActiveForm(Vcl::Forms::TCustomForm* aValue);
	void __fastcall SetActiveFormIndex(int aValue);
	int __fastcall GetCount(void);
	Vcl::Forms::TCustomForm* __fastcall GetActiveForm(void);
	Vcl::Forms::TCustomForm* __fastcall GetForms(int Index);
	int __fastcall GetFormIndex(Vcl::Forms::TCustomForm* Index);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Winapi::Messages::TWMKey &Message);
	MESSAGE void __fastcall WMThemeChanged(Winapi::Messages::TWMKey &Message);
	
protected:
	DYNAMIC bool __fastcall CanChange(void);
	DYNAMIC void __fastcall Change(void);
	void __fastcall DoThemeChanged(void);
	
public:
	__fastcall virtual TLMDFormTabControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFormTabControl(void);
	virtual int __fastcall AddFormExt(Vcl::Forms::TCustomForm* aValue, bool Display);
	int __fastcall AddFormClass(Vcl::Forms::TFormClass aValue, bool Display);
	int __fastcall AddFormClassExt(Vcl::Forms::TFormClass aValue, bool Display, System::UnicodeString Caption);
	Vcl::Forms::TCustomForm* __fastcall FindNextForm(Vcl::Forms::TCustomForm* CurForm, bool GoForward);
	void __fastcall HideForm(Vcl::Forms::TCustomForm* aValue);
	void __fastcall MoveForm(Vcl::Forms::TCustomForm* aValue, int NewIndex);
	void __fastcall RemoveForm(Vcl::Forms::TCustomForm* aValue, bool FreeForm);
	void __fastcall SelectNextForm(bool GoForward);
	bool __fastcall SetActiveFormByName(System::UnicodeString aValue);
	__property int ActiveFormIndex = {read=FActiveIndex, write=SetActiveFormIndex, nodefault};
	__property Vcl::Forms::TCustomForm* ActiveForm = {read=GetActiveForm, write=SetActiveForm};
	__property int FormCount = {read=GetCount, nodefault};
	__property Vcl::Forms::TCustomForm* Forms[int index] = {read=GetForms};
	__property int FormIndex[Vcl::Forms::TCustomForm* index] = {read=GetFormIndex};
	__property DisplayRect;
	__property Tabs;
	__property TabIndex = {default=-1};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property bool SaveResources = {read=FSaveResources, write=FSaveResources, default=0};
	__property Lmdformdisplay::TLMDFormDisplayChangeEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property bool UseResForms = {read=FUseRes, write=FUseRes, default=0};
	__property Align = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property HotTrack = {default=0};
	__property MultiLine = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ScrollOpposite = {default=0};
	__property ShowHint;
	__property TabHeight = {default=0};
	__property TabOrder = {default=-1};
	__property TabPosition = {default=0};
	__property TabStop = {default=1};
	__property TabWidth = {default=0};
	__property Visible = {default=1};
	__property OnChange;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DockSite = {default=0};
	__property DragKind = {default=0};
	__property Images;
	__property MultiSelect = {default=0};
	__property OwnerDraw = {default=0};
	__property ParentBiDiMode = {default=1};
	__property RaggedRight = {default=0};
	__property Style = {default=0};
	__property OnDockDrop;
	__property OnDockOver;
	__property OnDrawTab;
	__property OnEndDock;
	__property OnGetImageIndex;
	__property OnGetSiteInfo;
	__property OnResize;
	__property OnStartDock;
	__property OnUnDock;
	__property OnContextPopup;
	__property OnMouseActivate;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFormTabControl(HWND ParentWindow) : TLMDCustomFormTabControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdformtabcontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFORMTABCONTROL)
using namespace Lmdformtabcontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdformtabcontrolHPP
