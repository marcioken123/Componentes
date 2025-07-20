// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeLighting.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeelightingHPP
#define Vcltee_TeelightingHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeFilters.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teelighting
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLightFilter;
class DELPHICLASS TLightTool;
class DELPHICLASS TLightToolEditor;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLightStyle : unsigned char { lsLinear, lsSpotLight };

class PASCALIMPLEMENTATION TLightFilter : public Vcltee::Tecanvas::TTeeFilter
{
	typedef Vcltee::Tecanvas::TTeeFilter inherited;
	
private:
	int FFactor;
	int FLeft;
	TLightStyle FStyle;
	int FTop;
	void __fastcall SetFactor(const int Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetStyle(const TLightStyle Value);
	void __fastcall SetTop(const int Value);
	
public:
	__fastcall virtual TLightFilter(System::Classes::TCollection* Collection);
	virtual void __fastcall Apply(Vcl::Graphics::TBitmap* const Bitmap, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall CreateEditor(Vcltee::Tecanvas::_di_IFormCreator Creator, System::Classes::TNotifyEvent AChanged);
	__classmethod virtual System::UnicodeString __fastcall Description();
	
__published:
	__property int Factor = {read=FFactor, write=SetFactor, default=10};
	__property int Left = {read=FLeft, write=SetLeft, default=-1};
	__property TLightStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property int Top = {read=FTop, write=SetTop, default=-1};
public:
	/* TTeeFilter.Destroy */ inline __fastcall virtual ~TLightFilter() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Apply(Vcl::Graphics::TBitmap* const Bitmap){ Vcltee::Tecanvas::TTeeFilter::Apply(Bitmap); }
	
};


enum DECLSPEC_DENUM TLightDrawStyle : unsigned char { ldsAfterChart, ldsBeforeChart, ldsAfterSeries, ldsBeforeSeries, ldsBeforeAxes };

class PASCALIMPLEMENTATION TLightTool : public Vcltee::Teengine::TTeeCustomTool
{
	typedef Vcltee::Teengine::TTeeCustomTool inherited;
	
private:
	TLightDrawStyle FDrawStyle;
	TLightFilter* FFilter;
	bool FMouse;
	Vcl::Graphics::TBitmap* Buffer;
	bool InsideLighting;
	int __fastcall GetFactor();
	int __fastcall GetLeft();
	TLightStyle __fastcall GetStyle();
	int __fastcall GetTop();
	void __fastcall SetDrawStyle(const TLightDrawStyle Value);
	void __fastcall SetFactor(const int Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetStyle(const TLightStyle Value);
	void __fastcall SetTop(const int Value);
	
protected:
	virtual void __fastcall ChartEvent(Vcltee::Teengine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Vcltee::Teengine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton AButton, System::Classes::TShiftState AShift, int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TLightTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLightTool();
	__classmethod virtual System::UnicodeString __fastcall Description();
	void __fastcall Iluminate();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Active = {default=1};
	__property TLightDrawStyle DrawStyle = {read=FDrawStyle, write=SetDrawStyle, default=0};
	__property int Factor = {read=GetFactor, write=SetFactor, default=10};
	__property bool FollowMouse = {read=FMouse, write=FMouse, default=0};
	__property int Left = {read=GetLeft, write=SetLeft, default=-1};
	__property TLightStyle Style = {read=GetStyle, write=SetStyle, default=0};
	__property int Top = {read=GetTop, write=SetTop, default=-1};
};


class PASCALIMPLEMENTATION TLightToolEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TCheckBox* CBFollowMouse;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Comctrls::TTrackBar* TBLeft;
	Vcl::Comctrls::TTrackBar* TBTop;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcltee::Tecanvas::TComboFlat* CBStyle;
	Vcl::Comctrls::TTrackBar* TBFactor;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcltee::Tecanvas::TComboFlat* CBDrawStyle;
	void __fastcall CBFollowMouseClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall TBFactorChange(System::TObject* Sender);
	void __fastcall TBTopChange(System::TObject* Sender);
	void __fastcall TBLeftChange(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	void __fastcall CBDrawStyleChange(System::TObject* Sender);
	
private:
	bool CreatingForm;
	TLightTool* Light;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLightToolEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLightToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLightToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLightToolEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teelighting */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEELIGHTING)
using namespace Vcltee::Teelighting;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeelightingHPP
