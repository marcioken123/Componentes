// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDUnicodeEncodings.pas' rev: 34.00 (Windows)

#ifndef LmdunicodeencodingsHPP
#define LmdunicodeencodingsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdunicodeencodings
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDEncodingError;
struct TLMDEncodingDescr;
struct TLMDEncodingDetect;
class DELPHICLASS TLMDEncoding;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDEncodingError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDEncodingError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDEncodingError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDEncodingError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDEncodingError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDEncodingError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDEncodingError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDEncodingError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDEncodingError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDEncodingError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDEncodingError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDEncodingError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDEncodingError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDEncodingError() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDNamedEncoding : unsigned char { neACP, neOEMCP, neASCII, neUTF7, neUTF8, neUTF16LE, neUTF16BE, neUTF32LE, neUTF32BE, neUndefined };

struct DECLSPEC_DRECORD TLMDEncodingDescr
{
	
private:
	typedef System::DynamicArray<System::UnicodeString> _TLMDEncodingDescr__1;
	
	
public:
	_TLMDEncodingDescr__1 Names;
	TLMDNamedEncoding NamedCode;
	int CodePage;
	System::UnicodeString Description;
};


typedef System::DynamicArray<TLMDEncodingDescr> TLMDEncodingDescrArray;

struct DECLSPEC_DRECORD TLMDEncodingDetect
{
public:
	bool PreambleUsed;
	int CodePage;
	bool Detected;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEncoding : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	System::UnicodeString FName;
	int FCodePage;
	TLMDNamedEncoding FNamedEncoding;
	System::UnicodeString FDescription;
	Lmdtypes::TLMDByteArray FPreamble;
	void __fastcall CheckByteRange(const Lmdtypes::TLMDByteArray Arr, int AStart, int ACount);
	void __fastcall CheckCharRange(const Lmdtypes::TLMDWideCharArray Arr, int AStart, int ACount);
	void __fastcall CheckByteIdx(const Lmdtypes::TLMDByteArray Arr, int AStart, bool AForAppend);
	void __fastcall CheckCharIdx(const Lmdtypes::TLMDWideCharArray Arr, int AStart, bool AForAppend);
	__fastcall TLMDEncoding(int ACodePage, TLMDNamedEncoding ANamed, const System::UnicodeString AName, const System::UnicodeString ADescr);
	__classmethod bool __fastcall IsUCS(int ACodePage);
	int __fastcall ReadUCS(Lmdtypes::TLMDWideCharArray ADest, int ADestStart, const Lmdtypes::TLMDByteArray ASrc, int ASrcStart, int ASrcCount);
	int __fastcall WriteUCS(Lmdtypes::TLMDByteArray ADest, int ADestStart, const Lmdtypes::TLMDWideCharArray ASrc, int ASrcStart, int ASrcCount);
	int __fastcall UCSReadCount(int ASrcCount);
	int __fastcall UCSWriteCount(int ASrcCount);
	virtual int __fastcall SkipPreamble(const Lmdtypes::TLMDByteArray Arr, int AStart, int ACount);
	virtual int __fastcall WritePreamble(Lmdtypes::TLMDByteArray Arr, int AStart, int ACount);
	virtual int __fastcall ReadBufferLow(Lmdtypes::TLMDWideCharArray &ADest, int ADestStart, const Lmdtypes::TLMDByteArray ASrc, int ASrcStart, int ASrcCount, bool ADoRealloc);
	virtual int __fastcall WriteBufferLow(const Lmdtypes::TLMDWideCharArray ASrc, int ASrcStart, int ASrcCount, Lmdtypes::TLMDByteArray &ADest, int ADestStart, bool AUsePreamble, bool ADoRealloc);
	__classmethod TLMDNamedEncoding __fastcall NamedFromCode(int ACodePage);
	__classmethod TLMDEncodingDetect __fastcall TryDetectUTFEncoding(System::Classes::TStream* AStream);
	
public:
	__classmethod TLMDEncoding* __fastcall GetEncoding(System::UnicodeString AName)/* overload */;
	__classmethod TLMDEncoding* __fastcall GetEncoding(int ACodePage)/* overload */;
	__classmethod TLMDEncoding* __fastcall GetEncoding(TLMDNamedEncoding ANamed)/* overload */;
	__classmethod TLMDEncodingDescrArray __fastcall GetDescriptions(bool AValidOnly);
	__classmethod bool __fastcall IsEncodingValid(int ACodePage);
	__classmethod bool __fastcall IsUnicodeEncoding(int ACodePage);
	__classmethod TLMDEncodingDetect __fastcall TryDetectEncoding(System::Classes::TStream* AStream)/* overload */;
	__classmethod TLMDEncodingDetect __fastcall TryDetectEncoding(Lmdtypes::TLMDByteArray ABfr, int AStart, int ACount)/* overload */;
	__classmethod TLMDEncodingDetect __fastcall TryDetectEncoding(Lmdtypes::TLMDString AFileName)/* overload */;
	virtual int __fastcall GetRequiredWideCharBufferSize(const Lmdtypes::TLMDByteArray ASrc, int ASrcStart, int ASrcCount)/* overload */;
	int __fastcall GetRequiredWideCharBufferSize(const Lmdtypes::TLMDByteArray ASrc)/* overload */;
	virtual int __fastcall GetRequiredByteBufferSize(const Lmdtypes::TLMDWideCharArray ASrc, int ASrcStart, int ASrcCount, bool AUsePreamble)/* overload */;
	int __fastcall GetRequiredByteBufferSize(const Lmdtypes::TLMDWideCharArray ASrc, bool AUsePreamble)/* overload */;
	bool __fastcall StartsFromMyPreamble(const Lmdtypes::TLMDByteArray Arr, int AStart, int ACount);
	bool __fastcall HavePreamble();
	virtual int __fastcall PreambleCount();
	virtual Lmdtypes::TLMDByteArray __fastcall GetPreamble();
	int __fastcall ReadBuffer(Lmdtypes::TLMDWideCharArray &ADest, int ADestStart, const Lmdtypes::TLMDByteArray ASrc, int ASrcStart, int ASrcCount)/* overload */;
	int __fastcall ReadBuffer(Lmdtypes::TLMDWideCharArray &ADest, const Lmdtypes::TLMDByteArray ASrc)/* overload */;
	int __fastcall ReadBufferCheck(Lmdtypes::TLMDWideCharArray ADest, int ADestStart, const Lmdtypes::TLMDByteArray ASrc, int ASrcStart, int ASrcCount)/* overload */;
	int __fastcall ReadBufferCheck(Lmdtypes::TLMDWideCharArray ADest, const Lmdtypes::TLMDByteArray ASrc)/* overload */;
	virtual int __fastcall ReadStream(Lmdtypes::TLMDWideCharArray &ADest, int ADestStart, System::Classes::TStream* ASrcStream, int ASrcCount)/* overload */;
	int __fastcall ReadStream(Lmdtypes::TLMDWideCharArray &ADest, System::Classes::TStream* ASrcStream)/* overload */;
	virtual int __fastcall WriteStream(const Lmdtypes::TLMDWideCharArray ASrc, int ASrcStart, int ASrcCount, System::Classes::TStream* ADestStream, bool AUsePreamble)/* overload */;
	int __fastcall WriteStream(const Lmdtypes::TLMDWideCharArray ASrc, System::Classes::TStream* ADestStream, bool AUsePreamble)/* overload */;
	int __fastcall WriteBuffer(const Lmdtypes::TLMDWideCharArray ASrc, int ASrcStart, int ASrcCount, Lmdtypes::TLMDByteArray &ADest, int ADestStart, bool AUsePreamble)/* overload */;
	int __fastcall WriteBuffer(const Lmdtypes::TLMDWideCharArray ASrc, Lmdtypes::TLMDByteArray &ADest, bool AUsePreamble)/* overload */;
	int __fastcall WriteBufferCheck(const Lmdtypes::TLMDWideCharArray ASrc, int ASrcStart, int ASrcCount, Lmdtypes::TLMDByteArray ADest, int ADestStart, bool AUsePreamble)/* overload */;
	int __fastcall WriteBufferCheck(const Lmdtypes::TLMDWideCharArray ASrc, Lmdtypes::TLMDByteArray ADest, bool AUsePreamble)/* overload */;
	__property int CodePage = {read=FCodePage, nodefault};
	__property System::UnicodeString Name = {read=FName};
	__property System::UnicodeString Description = {read=FDescription};
	__property TLMDNamedEncoding NamedEncoding = {read=FNamedEncoding, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDEncoding() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdunicodeencodings */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDUNICODEENCODINGS)
using namespace Lmdunicodeencodings;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdunicodeencodingsHPP
