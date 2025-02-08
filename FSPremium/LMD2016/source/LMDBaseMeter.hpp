// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBaseMeter.pas' rev: 31.00 (Windows)

#ifndef LmdbasemeterHPP
#define LmdbasemeterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDGraphicControl.hpp>
#include <LMD3DCaption.hpp>
#include <LMDGraph.hpp>
#include <LMDTypes.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDBevel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbasemeter
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBaseMeter;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDBaseMeter : public Lmdgraphiccontrol::TLMDGraphicControl
{
	typedef Lmdgraphiccontrol::TLMDGraphicControl inherited;
	
private:
	Lmd3dcaption::TLMD3DCaption* F3DCaption;
	System::Classes::TAlignment FAlignment;
	Lmdgraph::TLMDMeterDirection FDirection;
	int FMaxValue;
	int FMinValue;
	Lmdtypes::TLMDPercent FPercentValue;
	Lmdtypes::TLMDPercent FOldValue;
	Lmdtypes::TLMDPercent FStep;
	Lmdgraph::TLMDMeterTextOptions FTextOptions;
	bool FUseFontColor;
	int FUserValue;
	System::Byte FDelta;
	void __fastcall Set3DCaption(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetAlignment(System::Classes::TAlignment aValue);
	void __fastcall SetDirection(Lmdgraph::TLMDMeterDirection aValue);
	void __fastcall SetMinValue(int aValue);
	void __fastcall SetMaxValue(int aValue);
	void __fastcall SetPercentValue(Lmdtypes::TLMDPercent aValue);
	void __fastcall SetTextOptions(Lmdgraph::TLMDMeterTextOptions aValue);
	void __fastcall SetUserValue(int aValue);
	void __fastcall SetUseFontColor(bool aValue);
	void __fastcall Synchronize(bool aFlag);
	MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	
protected:
	bool FUpdate;
	virtual void __fastcall DoThemeChanged(void);
	virtual bool __fastcall CorrectBounds(void);
	void __fastcall SetDelta(System::Byte aValue);
	virtual void __fastcall DrawBar(Vcl::Graphics::TCanvas* aCancas, const System::Types::TRect &dest, const System::Types::TRect &notDest, const System::Types::TRect &aRect);
	void __fastcall DrawCaption(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &dest, const System::Types::TRect &notdest, const System::Types::TRect &aRect, bool flag, System::Uitypes::TColor second);
	void __fastcall Draw(void);
	virtual Lmdtypes::TLMDPercent __fastcall GetDrawValue(void);
	Lmdtypes::TLMDPercent __fastcall GetPercentValue(int aValue);
	virtual bool __fastcall CheckOptimized(void);
	virtual void __fastcall Paint(void);
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=2};
	__property Lmdgraph::TLMDMeterDirection Direction = {read=FDirection, write=SetDirection, default=0};
	__property System::Byte Delta = {read=FDelta, write=SetDelta, default=1};
	__property int MaxValue = {read=FMaxValue, write=SetMaxValue, default=100};
	__property int MinValue = {read=FMinValue, write=SetMinValue, default=0};
	__property Lmdgraph::TLMDMeterTextOptions OptionsText = {read=FTextOptions, write=SetTextOptions, default=0};
	__property Lmdtypes::TLMDPercent PercentValue = {read=FPercentValue, write=SetPercentValue, default=0};
	__property Lmdtypes::TLMDPercent Position = {read=FPercentValue, write=SetPercentValue, default=0};
	__property Lmdtypes::TLMDPercent Step = {read=FStep, write=FStep, default=10};
	__property int UserValue = {read=FUserValue, write=SetUserValue, default=0};
	
public:
	__fastcall virtual TLMDBaseMeter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDBaseMeter(void);
	void __fastcall Add(Lmdtypes::TLMDPercent aValue);
	void __fastcall StepAdd(void);
	void __fastcall Sub(Lmdtypes::TLMDPercent aValue);
	void __fastcall StepSub(void);
	int __fastcall GetExtend(System::Byte aPercent, int aExtend);
	__property Bevel;
	__property Caption = {default=0};
	__property Font;
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=F3DCaption, write=Set3DCaption};
	__property bool UseFontColor = {read=FUseFontColor, write=SetUseFontColor, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbasemeter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBASEMETER)
using namespace Lmdbasemeter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbasemeterHPP
