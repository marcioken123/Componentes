// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDOSPropForm.pas' rev: 31.00 (Windows)

#ifndef PlmdospropformHPP
#define PlmdospropformHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <LMDObjectStorage.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Buttons.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdospropform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDOSPropForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDOSPropForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TButton* OkBtn;
	Vcl::Stdctrls::TButton* CancelBtn;
	Vcl::Comctrls::TTreeView* ComponentsTree;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Buttons::TSpeedButton* ToBtn;
	Vcl::Buttons::TSpeedButton* FromBtn;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Comctrls::TListView* PropListView;
	Vcl::Comctrls::TListView* ExcludedPropertiesList;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Buttons::TSpeedButton* ExclAdd;
	Vcl::Buttons::TSpeedButton* ExclDel;
	Vcl::Buttons::TSpeedButton* AllDelBtn;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall OkBtnClick(System::TObject* Sender);
	void __fastcall ToBtnClick(System::TObject* Sender);
	void __fastcall FromBtnClick(System::TObject* Sender);
	void __fastcall ComponentsTreeChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall PropListViewSelectItem(System::TObject* Sender, Vcl::Comctrls::TListItem* Item, bool Selected);
	void __fastcall ExclAddClick(System::TObject* Sender);
	void __fastcall ExclDelClick(System::TObject* Sender);
	void __fastcall AllDelBtnClick(System::TObject* Sender);
	void __fastcall ComponentsTreeDblClick(System::TObject* Sender);
	
public:
	Lmdobjectstorage::TLMDObjectStorage* OS;
	void __fastcall UpdatePropertiesTree(void);
	bool __fastcall IsPropertyExist(System::UnicodeString szComp, System::UnicodeString szProp);
	void __fastcall Apply(void);
	void __fastcall UpdateBtn(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDOSPropForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDOSPropForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDOSPropForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDOSPropForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDOSPropForm* LMDOSPropForm;
}	/* namespace Plmdospropform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDOSPROPFORM)
using namespace Plmdospropform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdospropformHPP
