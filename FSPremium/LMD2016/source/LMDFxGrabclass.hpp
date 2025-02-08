// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFxGrabClass.pas' rev: 31.00 (Windows)

#ifndef LmdfxgrabclassHPP
#define LmdfxgrabclassHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Winapi.FlatSB.hpp>
#include <Winapi.RichEdit.hpp>
#include <System.SysUtils.hpp>
#include <LMDFxEffect.hpp>
#include <LMDFxUtils.hpp>
#include <LMDClass.hpp>
#include <LMDFxGrab.hpp>
#include <LMDFxBitmap.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfxgrabclass
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFxWControlGrabber;
class DELPHICLASS TLMDFxFormGrabber;
class DELPHICLASS TLMDFxButtonGrabber;
class DELPHICLASS TLMDFxBitBtnGrabber;
class DELPHICLASS TLMDFxCheckBoxGrabber;
class DELPHICLASS TLMDFxScrollBoxGrabber;
class DELPHICLASS TLMDFxMemoGrabber;
class DELPHICLASS TLMDFxListBoxGrabber;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxWControlGrabber : public Lmdfxgrab::TLMDFxGrabber
{
	typedef Lmdfxgrab::TLMDFxGrabber inherited;
	
private:
	void __fastcall GrabWinToBitmap(Vcl::Graphics::TBitmap* ABitmap, int X, int Y, Vcl::Controls::TWinControl* AControl, const System::Types::TRect &ARect);
	
public:
	virtual void __fastcall GrabToBitmap(Vcl::Graphics::TBitmap* ABitmap, int X, int Y, Vcl::Controls::TControl* AControl, const System::Types::TRect &ARect);
	__classmethod virtual Lmdfxgrab::TLMDFxGrabberControlClass __fastcall GetGrabberClassType();
	__classmethod virtual System::UnicodeString __fastcall GetGrabberClassName();
public:
	/* TObject.Create */ inline __fastcall TLMDFxWControlGrabber(void) : Lmdfxgrab::TLMDFxGrabber() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFxWControlGrabber(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxFormGrabber : public TLMDFxWControlGrabber
{
	typedef TLMDFxWControlGrabber inherited;
	
private:
	void __fastcall GrabFormToDC(HDC DC, int X, int Y, Vcl::Forms::TCustomForm* AControl, const System::Types::TRect &ARect);
	void __fastcall GrabThemedFormToDC(HDC DC, int X, int Y, Vcl::Forms::TCustomForm* AControl, const System::Types::TRect &ARect);
	void __fastcall GrabFormToWinBitmap(Vcl::Graphics::TBitmap* ABitmap, Vcl::Forms::TCustomForm* AControl, int X, int Y, const System::Types::TRect &ARect);
	
public:
	virtual void __fastcall GrabToBitmap(Vcl::Graphics::TBitmap* ABitmap, int X, int Y, Vcl::Controls::TControl* AControl, const System::Types::TRect &ARect);
	__classmethod virtual Lmdfxgrab::TLMDFxGrabberControlClass __fastcall GetGrabberClassType();
	__classmethod virtual System::UnicodeString __fastcall GetGrabberClassName();
public:
	/* TObject.Create */ inline __fastcall TLMDFxFormGrabber(void) : TLMDFxWControlGrabber() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFxFormGrabber(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxButtonGrabber : public TLMDFxWControlGrabber
{
	typedef TLMDFxWControlGrabber inherited;
	
public:
	virtual void __fastcall GrabToBitmap(Vcl::Graphics::TBitmap* ABitmap, int X, int Y, Vcl::Controls::TControl* AControl, const System::Types::TRect &ARect);
	__classmethod virtual Lmdfxgrab::TLMDFxGrabberControlClass __fastcall GetGrabberClassType();
	__classmethod virtual System::UnicodeString __fastcall GetGrabberClassName();
public:
	/* TObject.Create */ inline __fastcall TLMDFxButtonGrabber(void) : TLMDFxWControlGrabber() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFxButtonGrabber(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxBitBtnGrabber : public TLMDFxWControlGrabber
{
	typedef TLMDFxWControlGrabber inherited;
	
public:
	virtual void __fastcall GrabToBitmap(Vcl::Graphics::TBitmap* ABitmap, int X, int Y, Vcl::Controls::TControl* AControl, const System::Types::TRect &ARect);
	__classmethod virtual Lmdfxgrab::TLMDFxGrabberControlClass __fastcall GetGrabberClassType();
	__classmethod virtual System::UnicodeString __fastcall GetGrabberClassName();
public:
	/* TObject.Create */ inline __fastcall TLMDFxBitBtnGrabber(void) : TLMDFxWControlGrabber() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFxBitBtnGrabber(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxCheckBoxGrabber : public TLMDFxWControlGrabber
{
	typedef TLMDFxWControlGrabber inherited;
	
public:
	virtual void __fastcall GrabToBitmap(Vcl::Graphics::TBitmap* ABitmap, int X, int Y, Vcl::Controls::TControl* AControl, const System::Types::TRect &ARect);
	__classmethod virtual Lmdfxgrab::TLMDFxGrabberControlClass __fastcall GetGrabberClassType();
	__classmethod virtual System::UnicodeString __fastcall GetGrabberClassName();
public:
	/* TObject.Create */ inline __fastcall TLMDFxCheckBoxGrabber(void) : TLMDFxWControlGrabber() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFxCheckBoxGrabber(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxScrollBoxGrabber : public TLMDFxWControlGrabber
{
	typedef TLMDFxWControlGrabber inherited;
	
private:
	void __fastcall GrabScrollBarsToBitmap(Vcl::Graphics::TBitmap* ABitmap, int X, int Y, Vcl::Controls::TControl* AControl, const System::Types::TRect &ARect);
	
public:
	virtual void __fastcall GrabToBitmap(Vcl::Graphics::TBitmap* ABitmap, int X, int Y, Vcl::Controls::TControl* AControl, const System::Types::TRect &ARect);
	__classmethod virtual Lmdfxgrab::TLMDFxGrabberControlClass __fastcall GetGrabberClassType();
	__classmethod virtual System::UnicodeString __fastcall GetGrabberClassName();
public:
	/* TObject.Create */ inline __fastcall TLMDFxScrollBoxGrabber(void) : TLMDFxWControlGrabber() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFxScrollBoxGrabber(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxMemoGrabber : public TLMDFxScrollBoxGrabber
{
	typedef TLMDFxScrollBoxGrabber inherited;
	
public:
	virtual void __fastcall GrabToBitmap(Vcl::Graphics::TBitmap* ABitmap, int X, int Y, Vcl::Controls::TControl* AControl, const System::Types::TRect &ARect);
	__classmethod virtual Lmdfxgrab::TLMDFxGrabberControlClass __fastcall GetGrabberClassType();
	__classmethod virtual System::UnicodeString __fastcall GetGrabberClassName();
public:
	/* TObject.Create */ inline __fastcall TLMDFxMemoGrabber(void) : TLMDFxScrollBoxGrabber() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFxMemoGrabber(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxListBoxGrabber : public TLMDFxScrollBoxGrabber
{
	typedef TLMDFxScrollBoxGrabber inherited;
	
public:
	virtual void __fastcall GrabToBitmap(Vcl::Graphics::TBitmap* ABitmap, int X, int Y, Vcl::Controls::TControl* AControl, const System::Types::TRect &ARect);
	__classmethod virtual Lmdfxgrab::TLMDFxGrabberControlClass __fastcall GetGrabberClassType();
	__classmethod virtual System::UnicodeString __fastcall GetGrabberClassName();
public:
	/* TObject.Create */ inline __fastcall TLMDFxListBoxGrabber(void) : TLMDFxScrollBoxGrabber() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFxListBoxGrabber(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfxgrabclass */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFXGRABCLASS)
using namespace Lmdfxgrabclass;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfxgrabclassHPP
