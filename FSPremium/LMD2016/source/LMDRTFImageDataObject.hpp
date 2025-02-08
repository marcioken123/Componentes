// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFImageDataObject.pas' rev: 31.00 (Windows)

#ifndef LmdrtfimagedataobjectHPP
#define LmdrtfimagedataobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.ActiveX.hpp>
#include <LMDRTFInt.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfimagedataobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRTFImageDataObject;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFImageDataObject : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	Vcl::Graphics::TBitmap* FBitmap;
	
public:
	__fastcall TLMDRTFImageDataObject(void);
	__fastcall virtual ~TLMDRTFImageDataObject(void);
	HRESULT __stdcall GetData(const tagFORMATETC &formatetcIn, /* out */ tagSTGMEDIUM &medium);
	HRESULT __stdcall GetDataHere(const tagFORMATETC &formatetc, /* out */ tagSTGMEDIUM &medium);
	HRESULT __stdcall QueryGetData(const tagFORMATETC &formatetc);
	HRESULT __stdcall GetCanonicalFormatEtc(const tagFORMATETC &formatetc, /* out */ tagFORMATETC &formatetcOut);
	HRESULT __stdcall SetData(const tagFORMATETC &formatetc, tagSTGMEDIUM &medium, System::LongBool fRelease);
	HRESULT __stdcall EnumFormatEtc(int dwDirection, /* out */ _di_IEnumFORMATETC &enumFormatEtc);
	HRESULT __stdcall DAdvise(const tagFORMATETC &formatetc, int advf, const _di_IAdviseSink advSink, /* out */ int &dwConnection);
	HRESULT __stdcall DUnadvise(int dwConnection);
	HRESULT __stdcall EnumDAdvise(/* out */ _di_IEnumSTATDATA &enumAdvise);
	_di_IOleObject __fastcall GetOleObject(_di_IOleClientSite OleClientSite, _di_IStorage Storage);
	void __fastcall InsertBitmap(Lmdrtfint::_di_IRichEditOle RichEditOle, Vcl::Graphics::TBitmap* Bitmap);
	void __fastcall SetBitmap(Vcl::Graphics::TBitmap* Bitmap);
private:
	void *__IDataObject;	// IDataObject 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {0000010E-0000-0000-C000-000000000046}
	operator _di_IDataObject()
	{
		_di_IDataObject intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator IDataObject*(void) { return (IDataObject*)&__IDataObject; }
	#endif
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtfimagedataobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFIMAGEDATAOBJECT)
using namespace Lmdrtfimagedataobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfimagedataobjectHPP
