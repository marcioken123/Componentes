// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysStrsDlg.pas' rev: 31.00 (Windows)

#ifndef LmdsysstrsdlgHPP
#define LmdsysstrsdlgHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysstrsdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysStringsDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysStringsDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* btnOk;
	Vcl::Extctrls::TBevel* bvlMain;
	Vcl::Comctrls::TRichEdit* memMain;
	
private:
	System::Classes::TStrings* __fastcall GetLines(void);
	void __fastcall SetLines(System::Classes::TStrings* const Value);
	
public:
	bool __fastcall Execute(void);
	__property System::Classes::TStrings* Lines = {read=GetLines, write=SetLines};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDSysStringsDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDSysStringsDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDSysStringsDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSysStringsDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysstrsdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSSTRSDLG)
using namespace Lmdsysstrsdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysstrsdlgHPP
