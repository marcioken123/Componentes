// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeFrameTool.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeframetoolHPP
#define Vcltee_TeeframetoolHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeFilters.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeframetool
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFrameTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TFrameTool : public Vcltee::Teengine::TTeeCustomTool
{
	typedef Vcltee::Teengine::TTeeCustomTool inherited;
	
private:
	Vcltee::Tecanvas::TTeePicture* FFrame;
	int FPaspartou;
	bool FResize;
	int FSize;
	int FStyle;
	bool IResized;
	Vcltee::Teefilters::TRotateFilter* IRotate;
	void __fastcall DoResizeChart();
	void __fastcall DrawFrame();
	bool __fastcall IsFrameStored();
	void __fastcall PaspartouChanged(System::TObject* Sender);
	void __fastcall SetFrame(Vcltee::Tecanvas::TTeePicture* const Value);
	void __fastcall SetResize(const bool Value);
	void __fastcall SetSize(const int Value);
	void __fastcall SetStyle(const int Value);
	void __fastcall SetPaspartou(const int Value);
	
protected:
	virtual void __fastcall ChartEvent(Vcltee::Teengine::TChartToolEvent AEvent);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TFrameTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TFrameTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Active = {default=1};
	__property Brush;
	__property Vcltee::Tecanvas::TTeePicture* Frame = {read=FFrame, write=SetFrame, stored=IsFrameStored};
	__property int Paspartou = {read=FPaspartou, write=SetPaspartou, nodefault};
	__property Pen;
	__property bool ResizeChart = {read=FResize, write=SetResize, default=1};
	__property int Size = {read=FSize, write=SetSize, default=16};
	__property int Style = {read=FStyle, write=SetStyle, default=1};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeframetool */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEFRAMETOOL)
using namespace Vcltee::Teeframetool;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeframetoolHPP
