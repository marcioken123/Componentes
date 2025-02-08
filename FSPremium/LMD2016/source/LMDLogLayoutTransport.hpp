// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLogLayoutTransport.pas' rev: 31.00 (Windows)

#ifndef LmdloglayouttransportHPP
#define LmdloglayouttransportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDObjectList.hpp>
#include <LMDLogMessage.hpp>
#include <LMDTypes.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdloglayouttransport
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLogCustomLayout;
class DELPHICLASS TLMDLogCustomBinaryLayout;
class DELPHICLASS TLMDLogCustomTextLayout;
class DELPHICLASS TLMDLogLayoutTransport;
class DELPHICLASS TLMDLogLayoutManager;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLogCustomLayout : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	int FHeaderSize;
	int FFooterSize;
	virtual void __fastcall SetParameters(System::Classes::TStringList* const AStr) = 0 ;
	virtual System::WideString __fastcall GetParameters(void) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall BinaryToText(const Lmdtypes::TLMDByteArray AArray);
	virtual Lmdtypes::TLMDByteArray __fastcall TextToBinary(const Lmdtypes::TLMDString AString);
	
public:
	__fastcall virtual TLMDLogCustomLayout(void);
	__classmethod virtual System::WideString __fastcall GetName();
	virtual Lmdtypes::TLMDByteArray __fastcall GetMessageAsBinary(Lmdlogmessage::TLMDLogMessage* const AMessage) = 0 ;
	virtual Lmdtypes::TLMDByteArray __fastcall GetHeaderAsBinary(void) = 0 ;
	virtual Lmdtypes::TLMDByteArray __fastcall GetFooterAsBinary(void) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall GetMessageAsText(Lmdlogmessage::TLMDLogMessage* const AMessage) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall GetHeaderAsText(void) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall GetFooterAsText(void) = 0 ;
	virtual int __fastcall GetHeaderSize(void);
	virtual int __fastcall GetFooterSize(void);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDLogCustomLayout(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLogCustomBinaryLayout : public TLMDLogCustomLayout
{
	typedef TLMDLogCustomLayout inherited;
	
public:
	virtual Lmdtypes::TLMDString __fastcall GetMessageAsText(Lmdlogmessage::TLMDLogMessage* const AMessage);
	virtual Lmdtypes::TLMDString __fastcall GetHeaderAsText(void);
	virtual Lmdtypes::TLMDString __fastcall GetFooterAsText(void);
public:
	/* TLMDLogCustomLayout.Create */ inline __fastcall virtual TLMDLogCustomBinaryLayout(void) : TLMDLogCustomLayout() { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDLogCustomBinaryLayout(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLogCustomTextLayout : public TLMDLogCustomLayout
{
	typedef TLMDLogCustomLayout inherited;
	
public:
	virtual Lmdtypes::TLMDByteArray __fastcall GetMessageAsBinary(Lmdlogmessage::TLMDLogMessage* const AMessage);
	virtual Lmdtypes::TLMDByteArray __fastcall GetHeaderAsBinary(void);
	virtual Lmdtypes::TLMDByteArray __fastcall GetFooterAsBinary(void);
public:
	/* TLMDLogCustomLayout.Create */ inline __fastcall virtual TLMDLogCustomTextLayout(void) : TLMDLogCustomLayout() { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDLogCustomTextLayout(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDLogLayoutClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLogLayoutTransport : public Lmdlogmessage::TLMDLogCustomTransport
{
	typedef Lmdlogmessage::TLMDLogCustomTransport inherited;
	
protected:
	TLMDLogCustomLayout* FLayout;
	virtual System::WideString __fastcall GetParameters(void);
	virtual void __fastcall SetParameters(const System::WideString AValue);
	
public:
	__fastcall virtual ~TLMDLogLayoutTransport(void);
	__property TLMDLogCustomLayout* Layout = {read=FLayout};
public:
	/* TLMDLogCustomTransport.Create */ inline __fastcall virtual TLMDLogLayoutTransport(void) : Lmdlogmessage::TLMDLogCustomTransport() { }
	
private:
	void *__ILMDLogTransport;	// Lmdlogmessage::ILMDLogTransport 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {D974AF86-C7E2-49B5-B88F-1D0253320DB3}
	operator Lmdlogmessage::_di_ILMDLogTransport()
	{
		Lmdlogmessage::_di_ILMDLogTransport intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdlogmessage::ILMDLogTransport*(void) { return (Lmdlogmessage::ILMDLogTransport*)&__ILMDLogTransport; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLogLayoutManager : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	Lmdobjectlist::TLMDObjectList* FLayoutClasses;
	TLMDLogLayoutClass __fastcall GetLayoutClass(const Lmdtypes::TLMDString ALayoutClassType);
	
public:
	__fastcall TLMDLogLayoutManager(void);
	__fastcall virtual ~TLMDLogLayoutManager(void);
	void __fastcall RegisterLayoutClass(const TLMDLogLayoutClass ALayoutClass);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDLogLayoutManager* LMDLogLayoutManager;
}	/* namespace Lmdloglayouttransport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLOGLAYOUTTRANSPORT)
using namespace Lmdloglayouttransport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdloglayouttransportHPP
