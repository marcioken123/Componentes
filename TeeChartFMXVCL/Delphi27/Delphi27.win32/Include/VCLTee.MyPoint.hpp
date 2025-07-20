// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.MyPoint.pas' rev: 34.00 (Windows)

#ifndef Vcltee_MypointHPP
#define Vcltee_MypointHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.UITypes.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Mypoint
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TMyPointSeries;
class DELPHICLASS TBarJoinSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TMyPointSeries : public Vcltee::Series::TPointSeries
{
	typedef Vcltee::Series::TPointSeries inherited;
	
private:
	Vcltee::Tecanvas::TTeePen* FLinesPen;
	void __fastcall SetLinesPen(Vcltee::Tecanvas::TTeePen* Value);
	
protected:
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TMyPointSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TMyPointSeries();
	
__published:
	__property Vcltee::Tecanvas::TTeePen* LinesPen = {read=FLinesPen, write=SetLinesPen};
};


class PASCALIMPLEMENTATION TBarJoinSeries : public Vcltee::Series::TBarSeries
{
	typedef Vcltee::Series::TBarSeries inherited;
	
private:
	Vcltee::Tecanvas::TTeePen* FJoinPen;
	System::Types::TRect OldBarBounds;
	bool IFirstPoint;
	void __fastcall SetJoinPen(Vcltee::Tecanvas::TTeePen* const Value);
	
protected:
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall DoBeforeDrawChart();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	__fastcall virtual TBarJoinSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TBarJoinSeries();
	virtual void __fastcall DrawBar(int BarIndex, int StartPos, int EndPos);
	DYNAMIC int __fastcall NumSampleValues();
	
__published:
	__property Vcltee::Tecanvas::TTeePen* JoinPen = {read=FJoinPen, write=SetJoinPen};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Mypoint */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_MYPOINT)
using namespace Vcltee::Mypoint;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_MypointHPP
