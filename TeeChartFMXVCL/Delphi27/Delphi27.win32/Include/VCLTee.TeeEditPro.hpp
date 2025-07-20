// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeEditPro.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeeditproHPP
#define Vcltee_TeeeditproHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeeditpro
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TChartImage;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TChartImage : public Vcl::Graphics::TGraphic
{
	typedef Vcl::Graphics::TGraphic inherited;
	
private:
	Vcltee::Chart::TChart* FChart;
	bool FCustom;
	Vcltee::Chart::TChart* __fastcall GetChart();
	void __fastcall SetChart(Vcltee::Chart::TChart* const Value);
	
protected:
	virtual bool __fastcall GetEmpty();
	virtual int __fastcall GetHeight();
	virtual HPALETTE __fastcall GetPalette();
	virtual int __fastcall GetWidth();
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &Rect);
	virtual void __fastcall ReadData(System::Classes::TStream* Stream);
	virtual void __fastcall SetHeight(int Value);
	virtual void __fastcall SetTransparent(bool Value);
	virtual void __fastcall SetWidth(int Value);
	virtual void __fastcall WriteData(System::Classes::TStream* Stream);
	
public:
	__fastcall virtual TChartImage()/* overload */;
	__fastcall virtual ~TChartImage();
	void __fastcall Clear();
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	virtual void __fastcall SaveToFile(const System::UnicodeString Filename);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream);
	virtual void __fastcall LoadFromClipboardFormat(System::Word AFormat, NativeUInt AData, HPALETTE APalette);
	virtual void __fastcall SaveToClipboardFormat(System::Word &AFormat, NativeUInt &AData, HPALETTE &APalette);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcltee::Chart::TChart* Chart = {read=GetChart, write=SetChart};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall SaveChartDialog(Vcltee::Chart::TCustomChart* AChart);
extern DELPHI_PACKAGE void __fastcall EditOneSeries(Vcl::Controls::TControl* AOwner, Vcltee::Teengine::TChartSeries* ASeries);
}	/* namespace Teeeditpro */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEEDITPRO)
using namespace Vcltee::Teeeditpro;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeeditproHPP
