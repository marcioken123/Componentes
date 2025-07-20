// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeSelectProperty.pas' rev: 34.00 (Windows)

#ifndef TeeselectpropertyHPP
#define TeeselectpropertyHPP

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
#include <System.TypInfo.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeselectproperty
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPropertySelector;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPropertySelector : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Comctrls::TTreeView* TreeObjects;
	Vcl::Extctrls::TPanel* PanelButtons;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TButton* BOK;
	Vcl::Stdctrls::TButton* BCancel;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabProps;
	Vcl::Comctrls::TTreeView* TreeProps;
	Vcl::Comctrls::TTabSheet* TabEvents;
	Vcl::Comctrls::TTreeView* TreeEvents;
	Vcl::Stdctrls::TLabel* LabelClass;
	void __fastcall TreeObjectsChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall TreePropsChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall TreePropsDblClick(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	bool __fastcall IsInstance(System::TObject* const AObject);
	
protected:
	virtual void __fastcall AddProperties(Vcl::Comctrls::TTreeView* ATree, System::TObject* AObject, System::Classes::TList* AList, System::Typinfo::TTypeKinds AFilter);
	
public:
	System::TObject* __fastcall SelectedProperty(System::UnicodeString &AName);
	__classmethod Vcl::Comctrls::TTreeNode* __fastcall NodeWithObject(Vcl::Comctrls::TTreeNodes* Items, System::TObject* AObject);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPropertySelector(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPropertySelector(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPropertySelector() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPropertySelector(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeselectproperty */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEESELECTPROPERTY)
using namespace Teeselectproperty;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeselectpropertyHPP
