// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShCombo.pas' rev: 31.00 (Windows)

#ifndef LmdshcomboHPP
#define LmdshcomboHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.ShlObj.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <LMDShFolder.hpp>
#include <LMDShView.hpp>
#include <LMDShBase.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <Vcl.ListActns.hpp>
#include <Vcl.Controls.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshcombo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellComboItem;
class DELPHICLASS TLMDShellComboStrings;
class DELPHICLASS TLMDShellComboBox;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDShellComboItem : public Vcl::Comctrls::TComboExItem
{
	typedef Vcl::Comctrls::TComboExItem inherited;
	
private:
	Lmdshbase::TLMDCustomShellItem* FShellItem;
	void __fastcall SetShellItem(Lmdshbase::TLMDCustomShellItem* const aValue);
	
public:
	__fastcall virtual TLMDShellComboItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDShellComboItem(void);
	__property Lmdshbase::TLMDCustomShellItem* ShellItem = {read=FShellItem, write=SetShellItem};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDShellComboStrings : public Vcl::Comctrls::TComboBoxExStrings
{
	typedef Vcl::Comctrls::TComboBoxExStrings inherited;
	
protected:
	virtual Vcl::Comctrls::TComboExItemClass __fastcall GetItemClass(void);
public:
	/* TComboBoxExStrings.Create */ inline __fastcall TLMDShellComboStrings(Vcl::Comctrls::TCustomComboBoxEx* Owner) : Vcl::Comctrls::TComboBoxExStrings(Owner) { }
	/* TComboBoxExStrings.Destroy */ inline __fastcall virtual ~TLMDShellComboStrings(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDShellComboBox : public Vcl::Comctrls::TCustomComboBoxEx
{
	typedef Vcl::Comctrls::TCustomComboBoxEx inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Lmdshfolder::TLMDShellFolder* FShellFolder;
	int FDroppedWidth;
	Lmdshview::TLMDShellItemEvent FOnItemSelected;
	int FLoadItem;
	Lmdshbase::TLMDShellItemsList* FShellItems;
	Lmdshbase::TLMDShellItemsList* FItemsCache;
	bool FActiveLocked;
	bool FChangeLocked;
	void __fastcall SetShellFolder(Lmdshfolder::TLMDShellFolder* const aValue);
	int __fastcall GetDroppedWidth(void);
	void __fastcall SetDroppedWidth(int Value);
	void __fastcall RepaintEx(void);
	void __fastcall ClearItems(void);
	void __fastcall LoadRootItems(void);
	void __fastcall EnumItems(int aIndex);
	void __fastcall DoFileChange(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFileCreate(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFileDelete(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	void __fastcall DoFileRename(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	void __fastcall DoFolderChange(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFolderCreate(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFolderDelete(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFolderRename(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall BeginEnumeration(void);
	void __fastcall EndEnumeration(void);
	bool __fastcall TerminateEnumeration(void);
	void __fastcall EnumAddItem(Lmdshbase::TLMDCustomShellItem* aItem);
	void __fastcall ActiveFolderChanged(void);
	Lmdshbase::TLMDCustomShellController* __fastcall Controller(void);
	
protected:
	virtual Vcl::Stdctrls::TCustomComboBoxStringsClass __fastcall GetItemsClass(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall Select(void);
	
public:
	__fastcall virtual TLMDShellComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDShellComboBox(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Lmdshfolder::TLMDShellFolder* Folder = {read=FShellFolder, write=SetShellFolder};
	__property int DroppedWidth = {read=GetDroppedWidth, write=SetDroppedWidth, default=0};
	__property Style = {default=0};
	__property StyleEx = {default=0};
	__property Action;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property ItemHeight;
	__property MaxLength = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Text = {default=0};
	__property Visible = {default=1};
	__property OnBeginEdit;
	__property OnChange;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDropDown;
	__property OnEndEdit;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnSelect;
	__property OnStartDock;
	__property OnStartDrag;
	__property DropDownCount = {default=8};
	__property Lmdshview::TLMDShellItemEvent OnItemSelected = {read=FOnItemSelected, write=FOnItemSelected};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDShellComboBox(HWND ParentWindow) : Vcl::Comctrls::TCustomComboBoxEx(ParentWindow) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	void *__ILMDShellView;	// Lmdshview::ILMDShellView 
	
public:
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
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {3E2D823C-8076-4FB1-8676-CE94E56ED34F}
	operator Lmdshview::_di_ILMDShellView()
	{
		Lmdshview::_di_ILMDShellView intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdshview::ILMDShellView*(void) { return (Lmdshview::ILMDShellView*)&__ILMDShellView; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {00000000-0000-0000-C000-000000000046}
	operator System::_di_IInterface()
	{
		System::_di_IInterface intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator System::IInterface*(void) { return (System::IInterface*)&__ILMDComponent; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshcombo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHCOMBO)
using namespace Lmdshcombo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshcomboHPP
