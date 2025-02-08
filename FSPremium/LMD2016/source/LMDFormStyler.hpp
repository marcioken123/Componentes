// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFormStyler.pas' rev: 31.00 (Windows)

#ifndef LmdformstylerHPP
#define LmdformstylerHPP

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
#include <Winapi.Messages.hpp>
#include <LMDGraph.hpp>
#include <LMDDwmApi.hpp>
#include <LMD3DCaption.hpp>
#include <LMDCustomFormFill.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdformstyler
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFormStyler;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDFormStyleOption : unsigned char { fsAdjustRect, fsUseDefaultFont, fsUseFontColor, fsInactiveGradient, fsDrawCaptionEvent, fsUseFormCaption, fsCheckSystemGradient };

typedef System::Set<TLMDFormStyleOption, TLMDFormStyleOption::fsAdjustRect, TLMDFormStyleOption::fsCheckSystemGradient> TLMDFormStyleOptions;

class PASCALIMPLEMENTATION TLMDFormStyler : public Lmdwndproccomponent::TLMDWndProcComponent
{
	typedef Lmdwndproccomponent::TLMDWndProcComponent inherited;
	
private:
	bool FHideGradient;
	System::Classes::TAlignment FAlignment;
	Lmdgraph::TLMDColorCount FColors;
	Vcl::Graphics::TCanvas* FCanvas;
	Vcl::Graphics::TFont* FFont;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	bool FWNDActive;
	Lmdcustomformfill::TLMDPaintMode FPaintMode;
	TLMDFormStyleOptions FOptions;
	bool FSmallCaption;
	Lmdcustomformfill::TLMDPaintEvent FOnPaint;
	Lmdcustomformfill::TLMDPaintEvent FOnCaptionPaint;
	System::UnicodeString FCaption;
	Vcl::Graphics::TBitmap* FIconBitmap;
	bool Painting;
	void __fastcall PaintTitleBar(bool CreateIcon);
	void __fastcall SetAlignment(System::Classes::TAlignment aValue);
	void __fastcall SetCaption(const System::UnicodeString aValue);
	void __fastcall SetColors(Lmdgraph::TLMDColorCount aValue);
	void __fastcall SetFont(Vcl::Graphics::TFont* aValue);
	void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetOptions(TLMDFormStyleOptions aValue);
	void __fastcall SetPaintMode(Lmdcustomformfill::TLMDPaintMode aValue);
	
protected:
	virtual void __fastcall EnabledChanged(void);
	virtual void __fastcall Init(void);
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall RestoreState(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDFormStyler(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFormStyler(void);
	void __fastcall ForceNCPaint(void);
	void __fastcall NCPaint(void);
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property bool CaptionActive = {read=FWNDActive, nodefault};
	__property bool SmallCaption = {read=FSmallCaption, nodefault};
	
__published:
	__property About = {default=0};
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Lmdgraph::TLMDColorCount Colors = {read=FColors, write=SetColors, default=32};
	__property Enabled = {default=1};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3D};
	__property Lmdcustomformfill::TLMDPaintMode PaintMode = {read=FPaintMode, write=SetPaintMode, default=1};
	__property TLMDFormStyleOptions Options = {read=FOptions, write=SetOptions, default=99};
	__property Lmdcustomformfill::TLMDPaintEvent OnPaint = {read=FOnPaint, write=FOnPaint};
	__property Lmdcustomformfill::TLMDPaintEvent OnCaptionPaint = {read=FOnCaptionPaint, write=FOnCaptionPaint};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdformstyler */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFORMSTYLER)
using namespace Lmdformstyler;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdformstylerHPP
