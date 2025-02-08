// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctUnitOptionsForm.pas' rev: 31.00 (Windows)

#ifndef LmdsctunitoptionsformHPP
#define LmdsctunitoptionsformHPP

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
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDSctImporterTree.hpp>
#include <LMDSctImporterUnitDoc.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctunitoptionsform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDUnitOptionsFrm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDUnitOptionsFrm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Stdctrls::TCheckBox* cbIsSysLibDoc;
	Vcl::Stdctrls::TCheckBox* cbIsLocked;
	void __fastcall Button1Click(System::TObject* Sender);
	
private:
	Lmdsctimporterunitdoc::TLMDUnitDocument* FDocument;
	
protected:
	void __fastcall UpdateView(void);
	void __fastcall UpdateDoc(void);
	
public:
	__fastcall TLMDUnitOptionsFrm(System::Classes::TComponent* AOwner, Lmdsctimporterunitdoc::TLMDUnitDocument* ADocument);
	__classmethod bool __fastcall Execute(Lmdsctimporterunitdoc::TLMDUnitDocument* ADocument);
	__property Lmdsctimporterunitdoc::TLMDUnitDocument* Document = {read=FDocument};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDUnitOptionsFrm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDUnitOptionsFrm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDUnitOptionsFrm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsctunitoptionsform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTUNITOPTIONSFORM)
using namespace Lmdsctunitoptionsform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctunitoptionsformHPP
