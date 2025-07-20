// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeDoubleHorizBar.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeedoublehorizbarHPP
#define Vcltee_TeedoublehorizbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeSubChart.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teedoublehorizbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDoubleHorizBarSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDoubleHorizBarSeries : public Vcltee::Series::THorizBarSeries
{
	typedef Vcltee::Series::THorizBarSeries inherited;
	
private:
	Vcltee::Teesubchart::TSubChartTool* FChart;
	int FSplit;
	Vcltee::Series::THorizBarSeries* ILeft;
	void __fastcall AdjustAxes();
	void __fastcall Assign3D();
	void __fastcall DoReposition();
	void __fastcall GetEmptyLabel(Vcltee::Teengine::TChartAxis* Sender, Vcltee::Teengine::TChartSeries* Series, int ValueIndex, System::UnicodeString &LabelText);
	void __fastcall SetSplit(const int Value);
	void __fastcall SetInvHoriz(const bool Value);
	void __fastcall SetInvVert(const bool Value);
	bool __fastcall GetInvHoriz();
	bool __fastcall GetInvVert();
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool Sequential = false);
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall BeforeCalcAxis();
	virtual void __fastcall DoBeforeDrawChart();
	DYNAMIC void __fastcall GalleryChanged3D(bool Is3D);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall Loaded();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall SetColorEachPoint(bool Value);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TDoubleHorizBarSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TDoubleHorizBarSeries();
	HIDESBASE void __fastcall Add(const double Left, const double Right, const System::UnicodeString Text = System::UnicodeString(), const System::Uitypes::TColor Color = (System::Uitypes::TColor)(0x20000000));
	virtual void __fastcall Clear();
	virtual void __fastcall Delete(int ValueIndex)/* overload */;
	Vcltee::Chart::TCustomChart* __fastcall LeftChart();
	Vcltee::Series::THorizBarSeries* __fastcall LeftSeries();
	Vcltee::Series::THorizBarSeries* __fastcall RightSeries();
	
__published:
	__property bool InvertedHoriz = {read=GetInvHoriz, write=SetInvHoriz, default=0};
	__property bool InvertedVert = {read=GetInvVert, write=SetInvVert, default=0};
	__property int SplitSize = {read=FSplit, write=SetSplit, default=50};
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Delete(int Start, int Quantity, bool RemoveGap = false){ Vcltee::Teengine::TChartSeries::Delete(Start, Quantity, RemoveGap); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teedoublehorizbar */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEDOUBLEHORIZBAR)
using namespace Vcltee::Teedoublehorizbar;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeedoublehorizbarHPP
