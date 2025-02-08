// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBitmap.pas' rev: 34.00 (Windows)

#ifndef LmdbitmapHPP
#define LmdbitmapHPP

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
#include <Vcl.Consts.hpp>
#include <Vcl.AxCtrls.hpp>
#include <Winapi.ActiveX.hpp>
#include <System.Win.ComObj.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbitmap
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBitmap;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDBitmap : public Vcl::Graphics::TBitmap
{
	typedef Vcl::Graphics::TBitmap inherited;
	
private:
	_di_IPicture FPicture;
	int __fastcall GetMMHeight();
	int __fastcall GetMMWidth();
	
protected:
	virtual void __fastcall Changed(System::TObject* Sender);
	virtual bool __fastcall GetEmpty();
	virtual int __fastcall GetHeight();
	virtual int __fastcall GetWidth();
	virtual HPALETTE __fastcall GetPalette();
	virtual bool __fastcall GetTransparent();
	virtual void __fastcall SetPalette(HPALETTE Value);
	virtual void __fastcall SetHeight(int Value);
	virtual void __fastcall SetWidth(int Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &Rect)/* overload */;
	HIDESBASE void __fastcall Draw(Vcl::Graphics::TCanvas* ACanvas, int aX, int aY)/* overload */;
	virtual void __fastcall LoadFromFile(const System::UnicodeString FileName);
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream);
	virtual void __fastcall LoadFromClipboardFormat(System::Word AFormat, NativeUInt AData, HPALETTE APalette);
	virtual void __fastcall SaveToClipboardFormat(System::Word &AFormat, NativeUInt &AData, HPALETTE &APalette);
	HIDESBASE void __fastcall LoadFromResourceName(NativeUInt Instance, const System::UnicodeString ResName);
	HIDESBASE void __fastcall LoadFromResourceID(NativeUInt Instance, int ResID);
	__property int MMHeight = {read=GetMMHeight, nodefault};
	__property int MMWidth = {read=GetMMWidth, nodefault};
	__property _di_IPicture Picture = {read=FPicture, write=FPicture};
public:
	/* TBitmap.Create */ inline __fastcall virtual TLMDBitmap()/* overload */ : Vcl::Graphics::TBitmap() { }
	/* TBitmap.Create */ inline __fastcall TLMDBitmap(int AWidth, int AHeight)/* overload */ : Vcl::Graphics::TBitmap(AWidth, AHeight) { }
	/* TBitmap.Destroy */ inline __fastcall virtual ~TLMDBitmap() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbitmap */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBITMAP)
using namespace Lmdbitmap;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbitmapHPP
