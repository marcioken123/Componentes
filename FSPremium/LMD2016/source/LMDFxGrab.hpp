// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFxGrab.pas' rev: 31.00 (Windows)

#ifndef LmdfxgrabHPP
#define LmdfxgrabHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDFxUtils.hpp>
#include <LMDFxBitmap.hpp>
#include <LMDFxEffect.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfxgrab
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFxGrabber;
//-- type declarations -------------------------------------------------------
typedef System::TMetaClass* TLMDFxGrabberControlClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxGrabber : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall GrabToBitmap(Vcl::Graphics::TBitmap* ABitmap, int X, int Y, Vcl::Controls::TControl* AControl, const System::Types::TRect &ARect);
	__classmethod virtual TLMDFxGrabberControlClass __fastcall GetGrabberClassType();
	__classmethod virtual System::UnicodeString __fastcall GetGrabberClassName();
public:
	/* TObject.Create */ inline __fastcall TLMDFxGrabber(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFxGrabber(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDFxGrabberClass;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDFxRegisterGrabber(TLMDFxGrabberClass AGrabber);
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* __fastcall LMDFxGrabToBitmap(Vcl::Controls::TControl* AControl, const System::Types::TRect &ARect, Vcl::Graphics::TBitmap* ABitmap = (Vcl::Graphics::TBitmap*)(0x0));
extern DELPHI_PACKAGE Lmdfxbitmap::TLMDFxBitmap* __fastcall LMDFxGrabToKeBitmap(Vcl::Controls::TControl* AControl, const System::Types::TRect &ARect, Lmdfxbitmap::TLMDFxBitmap* ABitmap = (Lmdfxbitmap::TLMDFxBitmap*)(0x0));
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* __fastcall LMDFxGrabDesktopToBitmap(const System::Types::TRect &ARect, Vcl::Graphics::TBitmap* ABitmap = (Vcl::Graphics::TBitmap*)(0x0));
extern DELPHI_PACKAGE Lmdfxbitmap::TLMDFxBitmap* __fastcall LMDFxGrabDesktopToKeBitmap(const System::Types::TRect &ARect, Lmdfxbitmap::TLMDFxBitmap* ABitmap = (Lmdfxbitmap::TLMDFxBitmap*)(0x0));
}	/* namespace Lmdfxgrab */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFXGRAB)
using namespace Lmdfxgrab;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfxgrabHPP
