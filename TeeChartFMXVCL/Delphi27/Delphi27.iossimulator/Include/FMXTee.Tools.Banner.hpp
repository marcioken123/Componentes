// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.Banner.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Tools_BannerHPP
#define Fmxtee_Tools_BannerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <System.UITypes.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Tools.hpp>
#include <FMXTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Banner
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBannerTool;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TScrollDirection : unsigned char { sdRightLeft, sdLeftRight };

class PASCALIMPLEMENTATION TBannerTool : public Fmxtee::Tools::TAnnotationTool
{
	typedef Fmxtee::Tools::TAnnotationTool inherited;
	
private:
	int FBlinkOff;
	int FBlinkOn;
	TScrollDirection FScrollDir;
	int FStep;
	Fmx::Types::TTimer* IBlink;
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
	Fmx::Types::TTimer* IScroll;
	virtual int __fastcall GetXOffset();
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
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
}	/* namespace Banner */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_BANNER)
using namespace Fmxtee::Tools::Banner;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS)
using namespace Fmxtee::Tools;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Tools_BannerHPP
