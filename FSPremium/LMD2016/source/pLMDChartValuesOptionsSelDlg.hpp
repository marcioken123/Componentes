// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDChartValuesOptionsSelDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdchartvaluesoptionsseldlgHPP
#define PlmdchartvaluesoptionsseldlgHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <LMDChartValuesBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdchartvaluesoptionsseldlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartValuesOptionsSelector;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDChartValuesOptionsSelector : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* btCancel;
	Vcl::Stdctrls::TButton* btOK;
	Vcl::Extctrls::TRadioGroup* RadioGroup1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* edColCaption;
	Vcl::Stdctrls::TComboBox* cbColName;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* lbFieldName;
	Vcl::Stdctrls::TComboBox* cbFieldName;
	
public:
	bool __fastcall Edit(Lmdchartvaluesbase::TLMDChartValuesBase* AValues);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDChartValuesOptionsSelector(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDChartValuesOptionsSelector(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDChartValuesOptionsSelector(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDChartValuesOptionsSelector(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDChartValuesOptionsSelector* LMDChartValuesOptionsSelector;
}	/* namespace Plmdchartvaluesoptionsseldlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCHARTVALUESOPTIONSSELDLG)
using namespace Plmdchartvaluesoptionsseldlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdchartvaluesoptionsseldlgHPP
