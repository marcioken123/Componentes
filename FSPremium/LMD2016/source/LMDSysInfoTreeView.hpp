// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysInfoTreeView.pas' rev: 31.00 (Windows)

#ifndef LmdsysinfotreeviewHPP
#define LmdsysinfotreeviewHPP

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
#include <Vcl.ComCtrls.hpp>
#include <LMDSysTreeView.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysBaseComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysinfotreeview
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysInfoTreeView;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDSysInfoItemSelectedEvent)(System::TObject* Sender, System::TObject* aSysInfoObject, Lmdsysbase::TLMDSysInfoType aSysInfoType);

typedef void __fastcall (__closure *TLMDSysInfoTreeViewGetImageIdxEvent)(System::TObject* Sender, System::TObject* aSysInfoObject, Lmdsysbase::TLMDSysInfoType aSysInfoType, int &aImageIndex);

class PASCALIMPLEMENTATION TLMDSysInfoTreeView : public Lmdsystreeview::TLMDSysTreeView
{
	typedef Lmdsystreeview::TLMDSysTreeView inherited;
	
private:
	Lmdsysbasecomponent::TLMDSysBaseComponent* FSysInfo;
	TLMDSysInfoItemSelectedEvent FOnItemSelected;
	TLMDSysInfoTreeViewGetImageIdxEvent FOnGetImageIdx;
	System::Classes::TList* FListViews;
	Vcl::Controls::TImageList* FImageList;
	Vcl::Comctrls::TTreeNode* __fastcall AddItem(Vcl::Comctrls::TTreeNode* aParent, System::UnicodeString aCaption, int aImageIndex, void * aData, bool aChildren = false);
	void __fastcall SetSysInfo(Lmdsysbasecomponent::TLMDSysBaseComponent* value);
	void __fastcall AddSubNodes(Vcl::Comctrls::TTreeNode* aParentNode, System::TObject* aParentGroup);
	void __fastcall LoadImageList(void);
	
protected:
	virtual int __fastcall GetImageIdx(System::TObject* aSysInfoObject);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall Change(Vcl::Comctrls::TTreeNode* Node);
	DYNAMIC bool __fastcall CanExpand(Vcl::Comctrls::TTreeNode* Node);
	
public:
	__fastcall virtual TLMDSysInfoTreeView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDSysInfoTreeView(void);
	virtual void __fastcall Loaded(void);
	void __fastcall Populate(void);
	void __fastcall RegisterListView(Vcl::Comctrls::TCustomListView* aList);
	void __fastcall UnRegisterListView(Vcl::Comctrls::TCustomListView* aList);
	
__published:
	__property ShowRoot = {default=1};
	__property Lmdsysbasecomponent::TLMDSysBaseComponent* SystemInfo = {read=FSysInfo, write=SetSysInfo};
	__property TLMDSysInfoItemSelectedEvent OnItemSelected = {read=FOnItemSelected, write=FOnItemSelected};
	__property TLMDSysInfoTreeViewGetImageIdxEvent OnGetImageIdx = {read=FOnGetImageIdx, write=FOnGetImageIdx};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSysInfoTreeView(HWND ParentWindow) : Lmdsystreeview::TLMDSysTreeView(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysinfotreeview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSINFOTREEVIEW)
using namespace Lmdsysinfotreeview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysinfotreeviewHPP
