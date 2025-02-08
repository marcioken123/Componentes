// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIdeCreationOrderDlg.pas' rev: 31.00 (Windows)

#ifndef LmdidecreationorderdlgHPP
#define LmdidecreationorderdlgHPP

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
#include <Vcl.Buttons.hpp>
#include <LMDTypes.hpp>
#include <LMDSvcPvdr.hpp>
#include <LMDArrayUtils.hpp>
#include <LMDDsgModule.hpp>
#include <LMDDsgDesigner.hpp>
#include <LMDIdeCst.hpp>
#include <LMDDsgClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdidecreationorderdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCreationOrderForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCreationOrderForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* ListCaption;
	Vcl::Stdctrls::TListBox* ListBox;
	Vcl::Buttons::TSpeedButton* UpButton;
	Vcl::Buttons::TSpeedButton* DownButton;
	Vcl::Stdctrls::TButton* OkButton;
	Vcl::Stdctrls::TButton* CancelButton;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall OkButtonClick(System::TObject* Sender);
	void __fastcall UpButtonClick(System::TObject* Sender);
	void __fastcall DownButtonClick(System::TObject* Sender);
	
private:
	Lmddsgdesigner::TLMDDesigner* FDesigner;
	bool FHasComps;
	void __fastcall Init(void);
	void __fastcall AddItem(System::Classes::TComponent* Child);
	
public:
	__fastcall TLMDCreationOrderForm(Lmddsgdesigner::TLMDDesigner* ADesigner);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDCreationOrderForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDCreationOrderForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCreationOrderForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdidecreationorderdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIDECREATIONORDERDLG)
using namespace Lmdidecreationorderdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdidecreationorderdlgHPP
