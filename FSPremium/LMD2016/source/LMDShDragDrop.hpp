// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShDragDrop.pas' rev: 31.00 (Windows)

#ifndef LmdshdragdropHPP
#define LmdshdragdropHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.ShlObj.hpp>
#include <Winapi.ActiveX.hpp>
#include <System.Classes.hpp>
#include <LMDShBase.hpp>
#include <LMDShPIDL.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshdragdrop
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellDropSource;
class DELPHICLASS TLMDShellDataObject;
class DELPHICLASS TLMDShellEnumFormatEtc;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<tagFORMATETC, 256> TLMDShellFormatArray;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDShellDropSource : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
public:
	HRESULT __stdcall GiveFeedback(int dwEffect);
	HRESULT __stdcall QueryContinueDrag(System::LongBool fEscapePressed, int grfKeyState);
public:
	/* TObject.Create */ inline __fastcall TLMDShellDropSource(void) : System::TInterfacedObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDShellDropSource(void) { }
	
private:
	void *__IDropSource;	// IDropSource 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {00000121-0000-0000-C000-000000000046}
	operator _di_IDropSource()
	{
		_di_IDropSource intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator IDropSource*(void) { return (IDropSource*)&__IDropSource; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDShellDataObject : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
	
private:
	typedef System::DynamicArray<tagFORMATETC> _TLMDShellDataObject__1;
	
	
private:
	Lmdshpidl::TLMDShellPIDLS* FPIDLS;
	_TLMDShellDataObject__1 FFormats;
	System::Classes::TMemoryStream* FPIDLS_Buffer;
	System::Classes::TMemoryStream* FPaths_Buffer;
	
public:
	__fastcall TLMDShellDataObject(Lmdshpidl::TLMDShellPIDLS* aPIDLS);
	__fastcall virtual ~TLMDShellDataObject(void);
	HRESULT __stdcall DAdvise(const tagFORMATETC &formatetc, int advf, const _di_IAdviseSink advSink, /* out */ int &dwConnection);
	HRESULT __stdcall DUnadvise(int dwConnection);
	HRESULT __stdcall EnumDAdvise(/* out */ _di_IEnumSTATDATA &enumAdvise);
	HRESULT __stdcall EnumFormatEtc(int dwDirection, /* out */ _di_IEnumFORMATETC &enumFormatEtc);
	HRESULT __stdcall GetCanonicalFormatEtc(const tagFORMATETC &formatetc, /* out */ tagFORMATETC &formatetcOut);
	HRESULT __stdcall GetData(const tagFORMATETC &formatetcIn, /* out */ tagSTGMEDIUM &medium);
	HRESULT __stdcall GetDataHere(const tagFORMATETC &formatetc, /* out */ tagSTGMEDIUM &medium);
	HRESULT __stdcall QueryGetData(const tagFORMATETC &formatetc);
	HRESULT __stdcall SetData(const tagFORMATETC &formatetc, tagSTGMEDIUM &medium, System::LongBool fRelease);
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

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDShellEnumFormatEtc : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
	
private:
	typedef System::DynamicArray<tagFORMATETC> _TLMDShellEnumFormatEtc__1;
	
	
private:
	int FCurrentIndex;
	_TLMDShellEnumFormatEtc__1 FFormats;
	
public:
	__fastcall TLMDShellEnumFormatEtc(const tagFORMATETC *AFormats, const int AFormats_High);
	HRESULT __stdcall Clone(/* out */ _di_IEnumFORMATETC &Enum);
	HRESULT __stdcall Next(int celt, /* out */ void *elt, System::PLongInt pceltFetched);
	HRESULT __stdcall Reset(void);
	HRESULT __stdcall Skip(int celt);
	__property int CurrentIndex = {read=FCurrentIndex, write=FCurrentIndex, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDShellEnumFormatEtc(void) { }
	
private:
	void *__IEnumFORMATETC;	// IEnumFORMATETC 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {00000103-0000-0000-C000-000000000046}
	operator _di_IEnumFORMATETC()
	{
		_di_IEnumFORMATETC intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator IEnumFORMATETC*(void) { return (IEnumFORMATETC*)&__IEnumFORMATETC; }
	#endif
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Word LMDShPIDLCFormat;
}	/* namespace Lmdshdragdrop */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHDRAGDROP)
using namespace Lmdshdragdrop;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshdragdropHPP
