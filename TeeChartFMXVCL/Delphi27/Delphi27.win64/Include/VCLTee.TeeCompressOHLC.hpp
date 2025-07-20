// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeCompressOHLC.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecompressohlcHPP
#define Vcltee_TeecompressohlcHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.OHLChart.hpp>
#include <VCLTee.TeeBaseFuncEdit.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <Vcl.ExtCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecompressohlc
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCompressFuncEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCompressFuncEditor : public Vcltee::Teebasefuncedit::TBaseFunctionEditor
{
	typedef Vcltee::Teebasefuncedit::TBaseFunctionEditor inherited;
	
__published:
	Vcltee::Tecanvas::TComboFlat* CBDatePeriod;
	Vcl::Stdctrls::TRadioButton* RadioDate;
	Vcl::Stdctrls::TEdit* ENum;
	Vcl::Stdctrls::TRadioButton* RadioPoints;
	Vcl::Comctrls::TUpDown* UpDown1;
	Vcl::Stdctrls::TRadioButton* RadioTime;
	Vcltee::Tecanvas::TComboFlat* CBTimePeriod;
	void __fastcall CBDatePeriodChange(System::TObject* Sender);
	void __fastcall RadioDateClick(System::TObject* Sender);
	void __fastcall RadioPointsClick(System::TObject* Sender);
	void __fastcall ENumChange(System::TObject* Sender);
	void __fastcall ENumClick(System::TObject* Sender);
	void __fastcall CBDatePeriodClick(System::TObject* Sender);
	void __fastcall RadioTimeClick(System::TObject* Sender);
	void __fastcall CBTimePeriodChange(System::TObject* Sender);
	
protected:
	virtual void __fastcall ApplyFormChanges();
	virtual void __fastcall SetFunction();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TCompressFuncEditor(System::Classes::TComponent* AOwner) : Vcltee::Teebasefuncedit::TBaseFunctionEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCompressFuncEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teebasefuncedit::TBaseFunctionEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCompressFuncEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCompressFuncEditor(HWND ParentWindow) : Vcltee::Teebasefuncedit::TBaseFunctionEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecompressohlc */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECOMPRESSOHLC)
using namespace Vcltee::Teecompressohlc;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecompressohlcHPP
