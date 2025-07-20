// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeBannerTool.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeebannertoolHPP
#define Vcltee_TeebannertoolHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teebannertool
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBannerTool;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TScrollDirection : unsigned char { sdRightLeft, sdLeftRight };

class PASCALIMPLEMENTATION TBannerTool : public Vcltee::Teetools::TAnnotationTool
{
	typedef Vcltee::Teetools::TAnnotationTool inherited;
	
private:
	int FBlinkOff;
	int FBlinkOn;
	TScrollDirection FScrollDir;
	int FStep;
	Vcl::Extctrls::TTimer* IBlink;
	bool IDraw;
	int IXPos;
	void __fastcall DoBlink(System::TObject* Sender);
	void __fastcall DoScroll(System::TObject* Sender);
	bool __fastcall GetBlink();
	bool __fastcall GetScroll();
	int __fastcall GetScrollDelay();
	void __fastcall SetBlink(const bool Value);
	void __fastcall SetBlinkOff(const int Value);
	void __fastcall SetBlinkOn(const int Value);
	void __fastcall SetScroll(const bool Value);
	void __fastcall SetScrollDelay(const int Value);
	void __fastcall SetScrollDir(const TScrollDirection Value);
	void __fastcall SetScrollStep(const int Value);
	
protected:
	Vcl::Extctrls::TTimer* IScroll;
	virtual int __fastcall GetXOffset();
	virtual void __fastcall ChartEvent(Vcltee::Teengine::TChartToolEvent AEvent);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TBannerTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TBannerTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property bool Blink = {read=GetBlink, write=SetBlink, default=0};
	__property int BlinkDelayOff = {read=FBlinkOff, write=SetBlinkOff, default=1000};
	__property int BlinkDelayOn = {read=FBlinkOn, write=SetBlinkOn, default=1000};
	__property bool Scroll = {read=GetScroll, write=SetScroll, default=1};
	__property int ScrollDelay = {read=GetScrollDelay, write=SetScrollDelay, default=50};
	__property TScrollDirection ScrollDirection = {read=FScrollDir, write=SetScrollDir, default=0};
	__property int ScrollStep = {read=FStep, write=SetScrollStep, default=5};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teebannertool */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEBANNERTOOL)
using namespace Vcltee::Teebannertool;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeebannertoolHPP
