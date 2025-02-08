// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDAddSeriesDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdaddseriesdlgHPP
#define PlmdaddseriesdlgHPP

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
#include <LMDUtils.hpp>
#include <LMDChart.hpp>
#include <LMDChartSeries.hpp>
#include <LMDChartSeriesCollection.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdaddseriesdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDAddSeriesDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDAddSeriesDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* btCancel;
	Vcl::Stdctrls::TButton* btOK;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TComboBox* ComboBox1;
	
public:
	bool __fastcall AddSeries(Lmdchart::TLMDChart* AChart);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDAddSeriesDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDAddSeriesDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDAddSeriesDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDAddSeriesDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDAddSeriesDlg* LMDAddSeriesDlg;
}	/* namespace Plmdaddseriesdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDADDSERIESDLG)
using namespace Plmdaddseriesdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdaddseriesdlgHPP
