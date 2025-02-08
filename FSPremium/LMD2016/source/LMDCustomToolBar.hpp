// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomToolBar.pas' rev: 31.00 (Windows)

#ifndef LmdcustomtoolbarHPP
#define LmdcustomtoolbarHPP

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
#include <LMDClass.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDSBtn.hpp>
#include <LMDGraph.hpp>
#include <LMDButtonBase.hpp>
#include <LMDButtonPanel.hpp>
#include <LMDFill.hpp>
#include <LMDFillObject.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomtoolbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDToolButton;
class DELPHICLASS TLMDToolButtons;
class DELPHICLASS TLMDCustomToolBar;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDToolButtonKind : unsigned char { tbkButton, tbkSeparator };

class PASCALIMPLEMENTATION TLMDToolButton : public Lmdsbtn::TLMDSpecialButton
{
	typedef Lmdsbtn::TLMDSpecialButton inherited;
	
private:
	Lmdfill::TLMDFill* FSeparator;
	void __fastcall SetKind(const TLMDToolButtonKind Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetMargin(const int Value);
	System::Classes::TBasicAction* __fastcall GetAction(void);
	void __fastcall SetAction(System::Classes::TBasicAction* const Value);
	void __fastcall SetUseToolbarBtnSize(const bool Value);
	void __fastcall SetUseToolbarMargin(const bool Value);
	
protected:
	bool FUseToolbarMargin;
	bool FUseToolbarBtnSize;
	TLMDToolButtonKind FKind;
	int FWidth;
	int FHeight;
	int FMargin;
	virtual void __fastcall CreateButtonControl(void);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual TLMDToolButton(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDToolButton(void);
	__property Lmdfill::TLMDFill* Separator = {read=FSeparator};
	int __fastcall BtnWidth(void);
	int __fastcall BtnHeight(void);
	int __fastcall BtnMargin(void);
	
__published:
	__property System::Classes::TBasicAction* Action = {read=GetAction, write=SetAction};
	__property TLMDToolButtonKind Kind = {read=FKind, write=SetKind, default=0};
	__property int Width = {read=FWidth, write=SetWidth, default=30};
	__property int Height = {read=FHeight, write=SetHeight, default=30};
	__property int Margin = {read=FMargin, write=SetMargin, nodefault};
	__property bool UseToolbarMargin = {read=FUseToolbarMargin, write=SetUseToolbarMargin, default=1};
	__property bool UseToolbarBtnSize = {read=FUseToolbarBtnSize, write=SetUseToolbarBtnSize, default=1};
};


class PASCALIMPLEMENTATION TLMDToolButtons : public Lmdsbtn::TLMDSpecialButtons
{
	typedef Lmdsbtn::TLMDSpecialButtons inherited;
	
public:
	__fastcall virtual TLMDToolButtons(Vcl::Controls::TWinControl* Owner, bool inform);
	virtual System::Classes::TCollectionItemClass __fastcall GetButtonClass(void);
public:
	/* TLMDSpecialButtons.Destroy */ inline __fastcall virtual ~TLMDToolButtons(void) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomToolBar : public Lmdbuttonpanel::TLMDButtonPanel
{
	typedef Lmdbuttonpanel::TLMDButtonPanel inherited;
	
private:
	int FRowGap;
	int FButtonMargin;
	Lmdgraph::TLMDOrientation FOrientation;
	Lmdfillobject::TLMDFillObject* FSeparatorFillObject;
	int FSeparatorWidth;
	bool FInitializingBevel;
	TLMDToolButtons* __fastcall GetButtons(void);
	HIDESBASE void __fastcall SetButtons(TLMDToolButtons* const Value);
	TLMDToolButton* __fastcall GetButton(int index);
	void __fastcall SetRowGap(const int Value);
	void __fastcall SetOrientation(const Lmdgraph::TLMDOrientation Value);
	void __fastcall SetSeparatorFillObject(Lmdfillobject::TLMDFillObject* const Value);
	void __fastcall SetButtonMargin(const int Value);
	void __fastcall SetSeparatorWidth(const int Value);
	
protected:
	void __fastcall SeparatorFillObjectChanged(System::TObject* Sender);
	virtual void __fastcall GetChange(System::TObject* Sender);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual TLMDCustomToolBar(System::Classes::TComponent* aOwner);
	void __fastcall Clear(void);
	__fastcall virtual ~TLMDCustomToolBar(void);
	void __fastcall DeleteButton(int index);
	virtual void __fastcall CreateButtons(void);
	virtual void __fastcall SetBorders(void);
	TLMDToolButton* __fastcall AddToolButton(bool aSetBorders = true);
	TLMDToolButton* __fastcall AddSeparator(bool aSetBorders = true);
	__property TLMDToolButton* Button[int index] = {read=GetButton};
	
__published:
	__property TLMDToolButtons* Buttons = {read=GetButtons, write=SetButtons};
	__property int ButtonMargin = {read=FButtonMargin, write=SetButtonMargin, default=1};
	__property Lmdgraph::TLMDOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property int RowGap = {read=FRowGap, write=SetRowGap, default=4};
	__property Lmdfillobject::TLMDFillObject* SeparatorFillObject = {read=FSeparatorFillObject, write=SetSeparatorFillObject};
	__property int SeparatorWidth = {read=FSeparatorWidth, write=SetSeparatorWidth, default=4};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomToolBar(HWND ParentWindow) : Lmdbuttonpanel::TLMDButtonPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 cDefaultSeparatorWidth = System::Int8(0x4);
}	/* namespace Lmdcustomtoolbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMTOOLBAR)
using namespace Lmdcustomtoolbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomtoolbarHPP
