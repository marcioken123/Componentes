// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShExceptions.pas' rev: 31.00 (Windows)

#ifndef LmdshexceptionsHPP
#define LmdshexceptionsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshexceptions
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDException;
class DELPHICLASS ELMDInvalidFolder;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDException : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
protected:
	int FErrorCode;
	
public:
	__fastcall virtual ELMDException(int aIdent, System::Word aDummy)/* overload */;
	__fastcall virtual ELMDException(const System::UnicodeString Str)/* overload */;
	__fastcall virtual ELMDException(int aIdent, const System::TVarRec *aArgs, const int aArgs_High, System::Word aDummy)/* overload */;
	__property int ErrorCode = {read=FErrorCode, write=FErrorCode, nodefault};
public:
	/* Exception.CreateFmt */ inline __fastcall ELMDException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDException(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDException(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDException(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDException(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDException(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDException(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* ELMDExceptionClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDInvalidFolder : public ELMDException
{
	typedef ELMDException inherited;
	
public:
	/* ELMDException.CreateRes */ inline __fastcall virtual ELMDInvalidFolder(int aIdent, System::Word aDummy)/* overload */ : ELMDException(aIdent, aDummy) { }
	/* ELMDException.Create */ inline __fastcall virtual ELMDInvalidFolder(const System::UnicodeString Str)/* overload */ : ELMDException(Str) { }
	/* ELMDException.CreateResFmt */ inline __fastcall virtual ELMDInvalidFolder(int aIdent, const System::TVarRec *aArgs, const int aArgs_High, System::Word aDummy)/* overload */ : ELMDException(aIdent, aArgs, aArgs_High, aDummy) { }
	
public:
	/* Exception.CreateFmt */ inline __fastcall ELMDInvalidFolder(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : ELMDException(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDInvalidFolder(NativeUInt Ident)/* overload */ : ELMDException(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDInvalidFolder(System::PResStringRec ResStringRec)/* overload */ : ELMDException(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDInvalidFolder(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : ELMDException(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDInvalidFolder(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : ELMDException(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDInvalidFolder(const System::UnicodeString Msg, int AHelpContext) : ELMDException(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDInvalidFolder(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : ELMDException(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDInvalidFolder(NativeUInt Ident, int AHelpContext)/* overload */ : ELMDException(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDInvalidFolder(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : ELMDException(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDInvalidFolder(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : ELMDException(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDInvalidFolder(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : ELMDException(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDInvalidFolder(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDRaiseError(ELMDExceptionClass aExceptionClass, int aCode);
extern DELPHI_PACKAGE void __fastcall LMDRaiseWin32Error(ELMDExceptionClass aExceptionClass, int aCode);
extern DELPHI_PACKAGE void __fastcall LMDRaiseWin32ErrorEx(ELMDExceptionClass aExceptionClass, int aCode, const System::UnicodeString aInfo);
}	/* namespace Lmdshexceptions */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHEXCEPTIONS)
using namespace Lmdshexceptions;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshexceptionsHPP
