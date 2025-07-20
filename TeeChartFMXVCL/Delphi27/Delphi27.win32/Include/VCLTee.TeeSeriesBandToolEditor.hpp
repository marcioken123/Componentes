// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSeriesBandToolEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeseriesbandtooleditorHPP
#define Vcltee_TeeseriesbandtooleditorHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeeToolSeriesEdit.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeConst.hpp>
#include <VCLTee.TeeProCo.hpp>
#include <VCLTee.TeeEdiGrad.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeSeriesBandTool.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeseriesbandtooleditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSeriesBandToolEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSeriesBandToolEdit : public Vcltee::Teetoolseriesedit::TSeriesToolEditor
{
	typedef Vcltee::Teetoolseriesedit::TSeriesToolEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label2;
	Vcltee::Tecanvas::TComboFlat* CBSeries2;
	Vcl::Stdctrls::TCheckBox* CBDrawBehindSeries;
	Vcl::Extctrls::TRadioGroup* RGCondition;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabPattern;
	Vcl::Comctrls::TTrackBar* TBTransp;
	Vcl::Stdctrls::TLabel* LTransp;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* EBound;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBDrawBehindSeriesClick(System::TObject* Sender);
	void __fastcall CBSeries2Change(System::TObject* Sender);
	void __fastcall RGConditionClick(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall EBoundChange(System::TObject* Sender);
	
private:
	Vcltee::Teeseriesbandtool::TSeriesBandTool* SeriesBand;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSeriesBandToolEdit(System::Classes::TComponent* AOwner) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSeriesBandToolEdit(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSeriesBandToolEdit() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSeriesBandToolEdit(HWND ParentWindow) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeseriesbandtooleditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESERIESBANDTOOLEDITOR)
using namespace Vcltee::Teeseriesbandtooleditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeseriesbandtooleditorHPP
