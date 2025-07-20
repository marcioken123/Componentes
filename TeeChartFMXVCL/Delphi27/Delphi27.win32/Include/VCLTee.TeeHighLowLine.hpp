// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeHighLowLine.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeehighlowlineHPP
#define Vcltee_TeehighlowlineHPP

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
#include <System.Types.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.ErrorBar.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teehighlowline
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THighLowLineSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION THighLowLineSeries : public Vcltee::Errorbar::TBaseHighLowSeries
{
	typedef Vcltee::Errorbar::TBaseHighLowSeries inherited;
	
private:
	Vcltee::Teengine::TSeriesPointer* FHighPointer;
	Vcltee::Teengine::TSeriesPointer* FLowPointer;
	void __fastcall SetHighPointer(Vcltee::Teengine::TSeriesPointer* const Value);
	void __fastcall SetLowPointer(Vcltee::Teengine::TSeriesPointer* const Value);
	void __fastcall ChangePen(System::TObject* Sender);
	
protected:
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall CalcHorizMargins(int &LeftMargin, int &RightMargin);
	virtual void __fastcall CalcVerticalMargins(int &TopMargin, int &BottomMargin);
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetSeriesColor(System::Uitypes::TColor AColor);
	
public:
	__fastcall virtual THighLowLineSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~THighLowLineSeries();
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	
__published:
	__property Vcltee::Teengine::TSeriesPointer* HighPointer = {read=FHighPointer, write=SetHighPointer};
	__property Vcltee::Teengine::TSeriesPointer* LowPointer = {read=FLowPointer, write=SetLowPointer};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teehighlowline */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEHIGHLOWLINE)
using namespace Vcltee::Teehighlowline;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeehighlowlineHPP
