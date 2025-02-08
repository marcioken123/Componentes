// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFStatisticsDialog.pas' rev: 31.00 (Windows)

#ifndef LmdrtfstatisticsdialogHPP
#define LmdrtfstatisticsdialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Classes.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDRTFRichEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfstatisticsdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRTFStatisticsDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRTFStatisticsDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TButton* btnClose;
	Vcl::Stdctrls::TLabel* lbPages;
	Vcl::Stdctrls::TLabel* lbWords;
	Vcl::Stdctrls::TLabel* lbChars1;
	Vcl::Stdctrls::TLabel* lbChars2;
	Vcl::Stdctrls::TLabel* lbPara;
	Vcl::Stdctrls::TLabel* lbLines;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Extctrls::TBevel* Bevel2;
	void __fastcall btnCloseClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
public:
	void __fastcall ProcessEditor(Lmdrtfrichedit::TLMDCustomRichEdit* aValue);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDRTFStatisticsDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDRTFStatisticsDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDRTFStatisticsDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRTFStatisticsDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtfstatisticsdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFSTATISTICSDIALOG)
using namespace Lmdrtfstatisticsdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfstatisticsdialogHPP
