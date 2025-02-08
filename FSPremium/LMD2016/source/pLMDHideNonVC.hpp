// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDHideNonVC.pas' rev: 31.00 (Windows)

#ifndef PlmdhidenonvcHPP
#define PlmdhidenonvcHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <System.Variants.hpp>
#include <DesignIntf.hpp>
#include <DesignWindows.hpp>
#include <DesignEditors.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDClass.hpp>
#include <LMDFormA.hpp>
#include <LMDStrings.hpp>
#include <LMDHideNonVC.hpp>
#include <LMDThemes.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDSimplePanel.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDCustomControl.hpp>
#include <LMDButton.hpp>
#include <LMDCustomButton.hpp>
#include <LMDControl.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdhidenonvc
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHideNonVCfrm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDHideNonVCfrm : public Designwindows::TDesignWindow
{
	typedef Designwindows::TDesignWindow inherited;
	
__published:
	Vcl::Stdctrls::TListBox* cbList;
	Vcl::Menus::TPopupMenu* popMenu;
	Lmdsimplepanel::TLMDSimplePanel* LMDSimplePanel1;
	Lmdsimplepanel::TLMDSimplePanel* LMDSimplePanel2;
	Vcl::Stdctrls::TLabel* lbl;
	Vcl::Stdctrls::TLabel* d;
	Lmdbutton::TLMDButton* CloseButton;
	Lmdbutton::TLMDButton* btHide;
	Lmdbutton::TLMDButton* btShow;
	Lmdbutton::TLMDButton* btshowall;
	Lmdbutton::TLMDButton* btHideAll;
	Lmdbutton::TLMDButton* btDelete;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CloseButtonClick(System::TObject* Sender);
	void __fastcall btHideClick(System::TObject* Sender);
	void __fastcall btshowClick(System::TObject* Sender);
	void __fastcall btDeleteClick(System::TObject* Sender);
	void __fastcall HandleClick(System::TObject* Sender);
	void __fastcall popMenuPopup(System::TObject* Sender);
	void __fastcall cbListMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall cbListKeyUp(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
private:
	Lmdhidenonvc::TLMDHideNonVC* FComponent;
	bool FDummy;
	Designintf::_di_IDesignerSelections FSelectList;
	bool fOwnSelection;
	System::UnicodeString FName;
	void __fastcall SetComponent(Lmdhidenonvc::TLMDHideNonVC* aValue);
	void __fastcall HandleNewComponent(System::TObject* Sender, System::Classes::TComponent* aComponent);
	System::Classes::TPersistent* __fastcall GetSelected(void);
	System::UnicodeString __fastcall BuildAddString(System::Classes::TComponent* aValue);
	System::UnicodeString __fastcall GetAddStringName(const System::UnicodeString aValue);
	void __fastcall CheckButtonStates(void);
	void __fastcall CheckInfo(void);
	
protected:
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall HideSelection(void);
	void __fastcall ShowSelection(void);
	void __fastcall DeleteSelection(void);
	__property Designintf::_di_IDesignerSelections SelectList = {read=FSelectList};
	void __fastcall SelectAdd(System::Classes::TComponent* Comp);
	void __fastcall SelectAll(void);
	void __fastcall SelectNone(void);
	void __fastcall SelectOne(System::Classes::TComponent* Comp);
	void __fastcall DoSelectAll(void);
	virtual System::UnicodeString __fastcall UniqueName(System::Classes::TComponent* Component);
	
public:
	__fastcall virtual ~TLMDHideNonVCfrm(void);
	DYNAMIC void __fastcall Activated(void);
	virtual bool __fastcall EditAction(Designintf::TEditAction Action);
	virtual void __fastcall ItemInserted(const Designintf::_di_IDesigner ADesigner, System::Classes::TPersistent* Item);
	virtual void __fastcall ItemDeleted(const Designintf::_di_IDesigner ADesigner, System::Classes::TPersistent* Item);
	virtual void __fastcall ItemsModified(const Designintf::_di_IDesigner Designer);
	virtual void __fastcall DesignerOpened(const Designintf::_di_IDesigner Designer, bool AResurrecting);
	virtual void __fastcall DesignerClosed(const Designintf::_di_IDesigner Designer, bool AGoingDormant);
	virtual void __fastcall SelectionChanged(const Designintf::_di_IDesigner ADesigner, const Designintf::_di_IDesignerSelections ASelection);
	void __fastcall Initialize(void);
	virtual Designintf::TEditState __fastcall GetEditState(void);
	void __fastcall UpdateSelection(void);
	__property Lmdhidenonvc::TLMDHideNonVC* DComponent = {read=FComponent, write=SetComponent};
	__property bool OwnSelection = {read=fOwnSelection, write=fOwnSelection, nodefault};
public:
	/* TDesignWindow.Create */ inline __fastcall virtual TLMDHideNonVCfrm(System::Classes::TComponent* AOwner) : Designwindows::TDesignWindow(AOwner) { }
	
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDHideNonVCfrm(System::Classes::TComponent* AOwner, int Dummy) : Designwindows::TDesignWindow(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDHideNonVCfrm(HWND ParentWindow) : Designwindows::TDesignWindow(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDHideNonVCfrm* LMDHideNonVCfrm;
}	/* namespace Plmdhidenonvc */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDHIDENONVC)
using namespace Plmdhidenonvc;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdhidenonvcHPP
