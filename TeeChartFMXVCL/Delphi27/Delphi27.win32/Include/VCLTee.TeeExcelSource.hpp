// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeExcelSource.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeexcelsourceHPP
#define Vcltee_TeeexcelsourceHPP

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
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeeURL.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeSourceEdit.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeStore.hpp>
#include <VCLTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeexcelsource
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeExcelSource;
class DELPHICLASS TSeriesDataXLSObject;
class DELPHICLASS TTeeExcelExport;
class DELPHICLASS TExcelSourceForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTeeExcelSource : public Vcltee::Teeurl::TTeeSeriesSourceFile
{
	typedef Vcltee::Teeurl::TTeeSeriesSourceFile inherited;
	
private:
	System::Variant FExcel;
	System::UnicodeString FLabelsFrom;
	System::UnicodeString FLabelsTo;
	System::UnicodeString FRangeFrom;
	System::UnicodeString FRangeTo;
	System::UnicodeString FWorkSheet;
	bool FRunning;
	System::OleVariant WorkBook;
	void __fastcall OpenWorkBook();
	void __fastcall SetLabelsFrom(const System::UnicodeString Value);
	void __fastcall SetLabelsTo(const System::UnicodeString Value);
	void __fastcall SetRangeFrom(const System::UnicodeString Value);
	void __fastcall SetRangeTo(const System::UnicodeString Value);
	void __fastcall SetWorkSheet(const System::UnicodeString Value);
	
public:
	virtual void __fastcall Close();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::Classes::TComponentClass __fastcall Editor();
	virtual void __fastcall Load();
	
__published:
	__property Active = {default=0};
	__property Chart;
	__property FileName = {default=0};
	__property System::UnicodeString LabelsFrom = {read=FLabelsFrom, write=SetLabelsFrom};
	__property System::UnicodeString LabelsTo = {read=FLabelsTo, write=SetLabelsTo};
	__property System::UnicodeString RangeFrom = {read=FRangeFrom, write=SetRangeFrom};
	__property System::UnicodeString RangeTo = {read=FRangeTo, write=SetRangeTo};
	__property Series;
	__property System::UnicodeString WorkSheet = {read=FWorkSheet, write=SetWorkSheet};
public:
	/* TTeeSeriesSource.Create */ inline __fastcall virtual TTeeExcelSource(System::Classes::TComponent* AOwner) : Vcltee::Teeurl::TTeeSeriesSourceFile(AOwner) { }
	/* TTeeSeriesSource.Destroy */ inline __fastcall virtual ~TTeeExcelSource() { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TSeriesDataXLSObject : public Vcltee::Teestore::TSeriesData
{
	typedef Vcltee::Teestore::TSeriesData inherited;
	
public:
	DYNAMIC void __fastcall SaveToFile(const System::UnicodeString FileName);
public:
	/* TSeriesData.Create */ inline __fastcall virtual TSeriesDataXLSObject(Vcltee::Chart::TCustomChart* AChart, Vcltee::Teengine::TChartSeries* ASeries) : Vcltee::Teestore::TSeriesData(AChart, ASeries) { }
	/* TSeriesData.Destroy */ inline __fastcall virtual ~TSeriesDataXLSObject() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TTeeExcelExport : public Vcltee::Teestore::TSeriesData
{
	typedef Vcltee::Teestore::TSeriesData inherited;
	
private:
	System::Variant FExcel;
	System::OleVariant FWorkSheet;
	System::UnicodeString FFileName;
	bool FRunning;
	System::OleVariant WorkBook;
	void __fastcall SetFileName(const System::UnicodeString Value);
	
protected:
	void __fastcall OpenWorkBook();
	
public:
	void __fastcall SaveChart(const Vcltee::Teengine::TeeFormatFlag Format);
	__property System::UnicodeString FileName = {read=FFileName, write=SetFileName};
public:
	/* TSeriesData.Create */ inline __fastcall virtual TTeeExcelExport(Vcltee::Chart::TCustomChart* AChart, Vcltee::Teengine::TChartSeries* ASeries) : Vcltee::Teestore::TSeriesData(AChart, ASeries) { }
	/* TSeriesData.Destroy */ inline __fastcall virtual ~TTeeExcelExport() { }
	
};


class PASCALIMPLEMENTATION TExcelSourceForm : public Vcltee::Teesourceedit::TBaseSourceEditor
{
	typedef Vcltee::Teesourceedit::TBaseSourceEditor inherited;
	
__published:
	Vcl::Stdctrls::TLabel* LabelFile;
	Vcl::Stdctrls::TEdit* EFileName;
	Vcl::Stdctrls::TLabel* LabelSheet;
	Vcltee::Tecanvas::TComboFlat* CBWorkSheet;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* EValFrom;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TEdit* EValTo;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TEdit* ELabFrom;
	Vcl::Stdctrls::TEdit* ELabTo;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Stdctrls::TButton* Button1;
	void __fastcall CBWorkSheetChange(System::TObject* Sender);
	void __fastcall EFileNameChange(System::TObject* Sender);
	void __fastcall EValFromChange(System::TObject* Sender);
	void __fastcall BApplyClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	
private:
	void __fastcall CheckControls();
	void __fastcall FillWorkSheets();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TExcelSourceForm(System::Classes::TComponent* AOwner) : Vcltee::Teesourceedit::TBaseSourceEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TExcelSourceForm(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teesourceedit::TBaseSourceEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TExcelSourceForm() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TExcelSourceForm(HWND ParentWindow) : Vcltee::Teesourceedit::TBaseSourceEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeexcelsource */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEEXCELSOURCE)
using namespace Vcltee::Teeexcelsource;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeexcelsourceHPP
