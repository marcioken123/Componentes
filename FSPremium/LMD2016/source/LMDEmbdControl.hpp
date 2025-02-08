// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDEmbdControl.pas' rev: 31.00 (Windows)

#ifndef LmdembdcontrolHPP
#define LmdembdcontrolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <LMDText.hpp>
#include <LMDWriter.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdembdcontrol
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDEmbdControl;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDEmbdControl : public Lmdtext::TLMDPieceOfText
{
	typedef Lmdtext::TLMDPieceOfText inherited;
	
private:
	System::UnicodeString FHeight;
	System::UnicodeString FWidth;
	System::UnicodeString FControlClass;
	System::UnicodeString FControlName;
	System::UnicodeString FControlText;
	System::UnicodeString FControlCaption;
	Vcl::Controls::TControl* FControl;
	Vcl::Controls::TControl* FOwner;
	Lmdtext::TLMDEmbdControlEvent FEventHandler;
	int __fastcall GetHeight(void);
	int __fastcall GetWidth(void);
	Vcl::Controls::TWinControl* __fastcall GetParentControl(void);
	void __fastcall GetOwnerControl(void);
	void __fastcall SetControlPos(int AX, int AY);
	void __fastcall SetControlSize(void);
	void __fastcall CreateControl(void);
	
protected:
	virtual bool __fastcall NeedReCalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	virtual void __fastcall CalcClientRect(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aDisplayRect, Vcl::Graphics::TFont* aDefFont, bool aAutoSize, bool aWordWrap);
	
public:
	__fastcall TLMDEmbdControl(Lmdtext::TLMDParsedTextList* aParent, System::UnicodeString aClass, System::UnicodeString aName, System::UnicodeString aWidth, System::UnicodeString aHeight, Lmdtext::TLMDEmbdControlEvent aEventHandler);
	__fastcall virtual ~TLMDEmbdControl(void);
	virtual void __fastcall Render(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, const System::Types::TPoint &aOffset, Vcl::Graphics::TFont* aDefFont, System::Uitypes::TColor aBkColor, bool aAutoSize, bool aWordWrap, bool aMask)/* overload */;
	virtual void __fastcall Store(Lmdwriter::TLMDWriter* AWriter);
	__property int Width = {read=GetWidth, nodefault};
	__property int Height = {read=GetHeight, nodefault};
	__property System::UnicodeString ControlClass = {read=FControlClass};
	__property System::UnicodeString ControlName = {read=FControlName, write=FControlName};
	__property System::UnicodeString ControlText = {read=FControlText, write=FControlText};
	__property System::UnicodeString ControlCaption = {read=FControlCaption, write=FControlCaption};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdembdcontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDEMBDCONTROL)
using namespace Lmdembdcontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdembdcontrolHPP
