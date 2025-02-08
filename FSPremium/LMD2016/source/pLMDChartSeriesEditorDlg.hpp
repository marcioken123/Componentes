// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDChartSeriesEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdchartserieseditordlgHPP
#define PlmdchartserieseditordlgHPP

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
#include <Vcl.Grids.hpp>
#include <System.Variants.hpp>
#include <LMDChartSeries.hpp>
#include <LMDChartValuesCollection.hpp>
#include <LMDChartSource.hpp>
#include <LMDChartValuesBase.hpp>
#include <LMDShSpinEdit.hpp>
#include <LMDUtils.hpp>
#include <pLMDChartValuesOptionsSelDlg.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdchartserieseditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartSeriesEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDChartSeriesEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* btOK;
	Vcl::Stdctrls::TButton* btCancel;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Comctrls::TListView* lvSeriesType;
	Vcl::Grids::TStringGrid* sgData;
	Lmdshspinedit::TLMDShSpinEdit* seRowCount;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TButton* btColOptions;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TEdit* edSeriesName;
	void __fastcall seRowCountChange(System::TObject* Sender);
	void __fastcall lvSeriesTypeClick(System::TObject* Sender);
	void __fastcall btColOptionsClick(System::TObject* Sender);
	
private:
	Lmdchartseries::TLMDCustomChartSeries* FChartSeries;
	Vcl::Forms::TForm* FForm;
	void __fastcall ChartValuesToForm(void);
	void __fastcall FormToChartValues(void);
	void __fastcall SeriesToForm(void);
	void __fastcall FormToSeries(void);
	
public:
	void __fastcall Edit(Lmdchartseries::TLMDCustomChartSeries* ASeries);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDChartSeriesEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDChartSeriesEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDChartSeriesEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDChartSeriesEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdchartserieseditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCHARTSERIESEDITORDLG)
using namespace Plmdchartserieseditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdchartserieseditordlgHPP
