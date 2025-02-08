// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPNGImage.pas' rev: 31.00 (Windows)

#ifndef LmdpngimageHPP
#define LmdpngimageHPP

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
#include <System.SysUtils.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDZLib.hpp>
#include <LMDRTLXConst.hpp>
#include <LMDProcs.hpp>
#include <LMDTypes.hpp>
#include <LMDFiles.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdpngimage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDPNGOutMemory;
class DELPHICLASS ELMDPNGError;
class DELPHICLASS ELMDPNGUnexpectedEnd;
class DELPHICLASS ELMDPNGInvalidCRC;
class DELPHICLASS ELMDPNGInvalidIHDR;
class DELPHICLASS ELMDPNGMissingMultipleIDAT;
class DELPHICLASS ELMDPNGZLIBError;
class DELPHICLASS ELMDPNGInvalidPalette;
class DELPHICLASS ELMDPNGInvalidFileHeader;
class DELPHICLASS ELMDPNGIHDRNotFirst;
class DELPHICLASS ELMDPNGNotExists;
class DELPHICLASS ELMDPNGSizeExceeds;
class DELPHICLASS ELMDPNGMissingPalette;
class DELPHICLASS ELMDPNGUnknownCriticalChunk;
class DELPHICLASS ELMDPNGUnknownCompression;
class DELPHICLASS ELMDPNGUnknownInterlace;
class DELPHICLASS ELMDPNGNoImageData;
class DELPHICLASS ELMDPNGCouldNotLoadResource;
class DELPHICLASS ELMDPNGCannotChangeTransparent;
class DELPHICLASS ELMDPNGHeaderNotPresent;
class DELPHICLASS ELMDPNGInvalidNewSize;
class DELPHICLASS ELMDPNGInvalidSpec;
class DELPHICLASS ELMDPNGInvalidSourceSize;
class DELPHICLASS ELMDPNGDifferentBitDepth;
struct TMAXBITMAPINFO;
struct TLMDPNGRGBPixel;
class DELPHICLASS TLMDPNGPointerList;
class DELPHICLASS TLMDPNGList;
class DELPHICLASS TLMDPNGObject;
class DELPHICLASS TLMDPNGChunk;
class DELPHICLASS TLMDPNGChunkIEND;
struct TLMDPNGIHDRData;
class DELPHICLASS TLMDPNGChunkIHDR;
class DELPHICLASS TLMDPNGChunkpHYs;
class DELPHICLASS TLMDPNGChunkgAMA;
class DELPHICLASS TLMDPNGChunkPLTE;
class DELPHICLASS TLMDPNGChunktRNS;
class DELPHICLASS TLMDPNGChunkIDAT;
class DELPHICLASS TLMDPNGChunktIME;
class DELPHICLASS TLMDPNGChunkTEXT;
class DELPHICLASS TLMDPNGChunkzTXT;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::UnicodeString, 9> Lmdpngimage__1;

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGOutMemory : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGOutMemory(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGOutMemory(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGOutMemory(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGOutMemory(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGOutMemory(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGOutMemory(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGOutMemory(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGOutMemory(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGOutMemory(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGOutMemory(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGOutMemory(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGOutMemory(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGOutMemory(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGError(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGUnexpectedEnd : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGUnexpectedEnd(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGUnexpectedEnd(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGUnexpectedEnd(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGUnexpectedEnd(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGUnexpectedEnd(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGUnexpectedEnd(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGUnexpectedEnd(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGUnexpectedEnd(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGUnexpectedEnd(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGUnexpectedEnd(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGUnexpectedEnd(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGUnexpectedEnd(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGUnexpectedEnd(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGInvalidCRC : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGInvalidCRC(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGInvalidCRC(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGInvalidCRC(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGInvalidCRC(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGInvalidCRC(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGInvalidCRC(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGInvalidCRC(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGInvalidCRC(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGInvalidCRC(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGInvalidCRC(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGInvalidCRC(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGInvalidCRC(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGInvalidCRC(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGInvalidIHDR : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGInvalidIHDR(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGInvalidIHDR(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGInvalidIHDR(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGInvalidIHDR(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGInvalidIHDR(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGInvalidIHDR(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGInvalidIHDR(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGInvalidIHDR(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGInvalidIHDR(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGInvalidIHDR(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGInvalidIHDR(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGInvalidIHDR(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGInvalidIHDR(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGMissingMultipleIDAT : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGMissingMultipleIDAT(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGMissingMultipleIDAT(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGMissingMultipleIDAT(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGMissingMultipleIDAT(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGMissingMultipleIDAT(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGMissingMultipleIDAT(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGMissingMultipleIDAT(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGMissingMultipleIDAT(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGMissingMultipleIDAT(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGMissingMultipleIDAT(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGMissingMultipleIDAT(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGMissingMultipleIDAT(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGMissingMultipleIDAT(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGZLIBError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGZLIBError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGZLIBError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGZLIBError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGZLIBError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGZLIBError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGZLIBError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGZLIBError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGZLIBError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGZLIBError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGZLIBError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGZLIBError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGZLIBError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGZLIBError(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGInvalidPalette : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGInvalidPalette(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGInvalidPalette(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGInvalidPalette(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGInvalidPalette(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGInvalidPalette(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGInvalidPalette(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGInvalidPalette(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGInvalidPalette(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGInvalidPalette(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGInvalidPalette(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGInvalidPalette(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGInvalidPalette(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGInvalidPalette(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGInvalidFileHeader : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGInvalidFileHeader(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGInvalidFileHeader(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGInvalidFileHeader(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGInvalidFileHeader(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGInvalidFileHeader(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGInvalidFileHeader(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGInvalidFileHeader(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGInvalidFileHeader(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGInvalidFileHeader(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGInvalidFileHeader(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGInvalidFileHeader(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGInvalidFileHeader(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGInvalidFileHeader(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGIHDRNotFirst : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGIHDRNotFirst(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGIHDRNotFirst(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGIHDRNotFirst(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGIHDRNotFirst(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGIHDRNotFirst(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGIHDRNotFirst(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGIHDRNotFirst(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGIHDRNotFirst(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGIHDRNotFirst(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGIHDRNotFirst(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGIHDRNotFirst(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGIHDRNotFirst(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGIHDRNotFirst(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGNotExists : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGNotExists(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGNotExists(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGNotExists(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGNotExists(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGNotExists(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGNotExists(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGNotExists(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGNotExists(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGNotExists(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGNotExists(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGNotExists(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGNotExists(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGNotExists(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGSizeExceeds : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGSizeExceeds(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGSizeExceeds(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGSizeExceeds(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGSizeExceeds(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGSizeExceeds(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGSizeExceeds(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGSizeExceeds(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGSizeExceeds(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGSizeExceeds(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGSizeExceeds(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGSizeExceeds(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGSizeExceeds(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGSizeExceeds(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGMissingPalette : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGMissingPalette(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGMissingPalette(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGMissingPalette(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGMissingPalette(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGMissingPalette(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGMissingPalette(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGMissingPalette(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGMissingPalette(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGMissingPalette(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGMissingPalette(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGMissingPalette(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGMissingPalette(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGMissingPalette(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGUnknownCriticalChunk : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGUnknownCriticalChunk(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGUnknownCriticalChunk(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGUnknownCriticalChunk(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGUnknownCriticalChunk(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGUnknownCriticalChunk(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGUnknownCriticalChunk(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGUnknownCriticalChunk(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGUnknownCriticalChunk(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGUnknownCriticalChunk(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGUnknownCriticalChunk(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGUnknownCriticalChunk(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGUnknownCriticalChunk(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGUnknownCriticalChunk(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGUnknownCompression : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGUnknownCompression(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGUnknownCompression(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGUnknownCompression(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGUnknownCompression(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGUnknownCompression(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGUnknownCompression(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGUnknownCompression(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGUnknownCompression(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGUnknownCompression(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGUnknownCompression(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGUnknownCompression(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGUnknownCompression(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGUnknownCompression(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGUnknownInterlace : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGUnknownInterlace(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGUnknownInterlace(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGUnknownInterlace(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGUnknownInterlace(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGUnknownInterlace(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGUnknownInterlace(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGUnknownInterlace(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGUnknownInterlace(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGUnknownInterlace(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGUnknownInterlace(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGUnknownInterlace(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGUnknownInterlace(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGUnknownInterlace(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGNoImageData : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGNoImageData(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGNoImageData(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGNoImageData(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGNoImageData(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGNoImageData(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGNoImageData(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGNoImageData(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGNoImageData(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGNoImageData(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGNoImageData(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGNoImageData(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGNoImageData(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGNoImageData(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGCouldNotLoadResource : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGCouldNotLoadResource(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGCouldNotLoadResource(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGCouldNotLoadResource(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGCouldNotLoadResource(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGCouldNotLoadResource(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGCouldNotLoadResource(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGCouldNotLoadResource(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGCouldNotLoadResource(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGCouldNotLoadResource(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGCouldNotLoadResource(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGCouldNotLoadResource(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGCouldNotLoadResource(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGCouldNotLoadResource(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGCannotChangeTransparent : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGCannotChangeTransparent(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGCannotChangeTransparent(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGCannotChangeTransparent(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGCannotChangeTransparent(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGCannotChangeTransparent(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGCannotChangeTransparent(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGCannotChangeTransparent(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGCannotChangeTransparent(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGCannotChangeTransparent(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGCannotChangeTransparent(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGCannotChangeTransparent(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGCannotChangeTransparent(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGCannotChangeTransparent(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGHeaderNotPresent : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGHeaderNotPresent(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGHeaderNotPresent(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGHeaderNotPresent(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGHeaderNotPresent(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGHeaderNotPresent(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGHeaderNotPresent(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGHeaderNotPresent(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGHeaderNotPresent(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGHeaderNotPresent(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGHeaderNotPresent(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGHeaderNotPresent(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGHeaderNotPresent(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGHeaderNotPresent(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGInvalidNewSize : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGInvalidNewSize(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGInvalidNewSize(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGInvalidNewSize(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGInvalidNewSize(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGInvalidNewSize(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGInvalidNewSize(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGInvalidNewSize(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGInvalidNewSize(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGInvalidNewSize(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGInvalidNewSize(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGInvalidNewSize(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGInvalidNewSize(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGInvalidNewSize(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGInvalidSpec : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGInvalidSpec(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGInvalidSpec(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGInvalidSpec(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGInvalidSpec(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGInvalidSpec(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGInvalidSpec(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGInvalidSpec(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGInvalidSpec(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGInvalidSpec(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGInvalidSpec(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGInvalidSpec(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGInvalidSpec(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGInvalidSpec(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGInvalidSourceSize : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGInvalidSourceSize(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGInvalidSourceSize(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGInvalidSourceSize(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGInvalidSourceSize(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGInvalidSourceSize(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGInvalidSourceSize(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGInvalidSourceSize(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGInvalidSourceSize(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGInvalidSourceSize(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGInvalidSourceSize(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGInvalidSourceSize(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGInvalidSourceSize(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGInvalidSourceSize(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPNGDifferentBitDepth : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPNGDifferentBitDepth(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPNGDifferentBitDepth(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGDifferentBitDepth(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPNGDifferentBitDepth(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGDifferentBitDepth(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPNGDifferentBitDepth(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPNGDifferentBitDepth(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPNGDifferentBitDepth(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGDifferentBitDepth(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPNGDifferentBitDepth(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGDifferentBitDepth(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPNGDifferentBitDepth(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPNGDifferentBitDepth(void) { }
	
};

#pragma pack(pop)

typedef System::StaticArray<tagRGBTRIPLE, 65536> TRGBLine;

typedef TRGBLine *pRGBLine;

typedef System::StaticArray<tagRGBQUAD, 65536> TRGBALine;

typedef TRGBALine *PRGBALine;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TMAXBITMAPINFO
{
public:
	tagBITMAPINFOHEADER bmiHeader;
	System::StaticArray<tagRGBQUAD, 256> bmiColors;
};
#pragma pack(pop)


enum DECLSPEC_DENUM TLMDPNGTransparencyMode : unsigned char { ptmNone, ptmBit, ptmPartial };

typedef unsigned *PCardinal;

typedef TLMDPNGRGBPixel *PLMDPNGRGBPixel;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDPNGRGBPixel
{
public:
	System::Byte B;
	System::Byte G;
	System::Byte R;
};
#pragma pack(pop)


typedef System::StaticArray<System::Byte, 65536> TByteArray;

typedef TByteArray *PByteArray;

typedef System::StaticArray<void *, 65536> TPointerArray;

typedef TPointerArray *PPointerArray;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPNGPointerList : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDPNGObject* fOwner;
	unsigned fCount;
	TPointerArray *fMemory;
	void * __fastcall GetItem(unsigned Index);
	void __fastcall SetItem(unsigned Index, const void * Value);
	
protected:
	virtual void * __fastcall Remove(void * Value);
	void __fastcall Insert(void * Value, unsigned Position);
	void __fastcall Add(void * Value);
	__property void * Item[unsigned Index] = {read=GetItem, write=SetItem};
	void __fastcall SetSize(const unsigned Size);
	__property TLMDPNGObject* Owner = {read=fOwner};
	
public:
	__property unsigned Count = {read=fCount, write=SetSize, nodefault};
	__fastcall TLMDPNGPointerList(TLMDPNGObject* AOwner);
	__fastcall virtual ~TLMDPNGPointerList(void);
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDPNGChunkClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPNGList : public TLMDPNGPointerList
{
	typedef TLMDPNGPointerList inherited;
	
private:
	HIDESBASE TLMDPNGChunk* __fastcall GetItem(unsigned Index);
	
public:
	TLMDPNGChunk* __fastcall FindChunk(TLMDPNGChunkClass ChunkClass);
	void __fastcall RemoveChunk(TLMDPNGChunk* Chunk)/* overload */;
	HIDESBASE TLMDPNGChunk* __fastcall Add(TLMDPNGChunkClass ChunkClass);
	TLMDPNGChunk* __fastcall ItemFromClass(TLMDPNGChunkClass ChunkClass);
	__property TLMDPNGChunk* Item[unsigned Index] = {read=GetItem};
public:
	/* TLMDPNGPointerList.Create */ inline __fastcall TLMDPNGList(TLMDPNGObject* AOwner) : TLMDPNGPointerList(AOwner) { }
	/* TLMDPNGPointerList.Destroy */ inline __fastcall virtual ~TLMDPNGList(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TInterlaceMethod : unsigned char { imNone, imAdam7 };

typedef System::Int8 TCompressionLevel;

enum DECLSPEC_DENUM TFilter : unsigned char { pfNone, pfSub, pfUp, pfAverage, pfPaeth };

typedef System::Set<TFilter, TFilter::pfNone, TFilter::pfPaeth> TFilters;

class PASCALIMPLEMENTATION TLMDPNGObject : public Vcl::Graphics::TGraphic
{
	typedef Vcl::Graphics::TGraphic inherited;
	
private:
	Vcl::Graphics::TCanvas* fCanvas;
	TFilters fFilters;
	TCompressionLevel fCompressionLevel;
	int fMaxIdatSize;
	TInterlaceMethod fInterlaceMethod;
	TLMDPNGList* fChunkList;
	void __fastcall ClearChunks(void);
	bool __fastcall HeaderPresent(void);
	void __fastcall GetPixelInfo(unsigned &LineSize, unsigned &Offset);
	void __fastcall SetMaxIdatSize(const int Value);
	PByteArray __fastcall GetAlphaScanline(const int LineIndex);
	void * __fastcall GetScanline(const int LineIndex);
	TLMDPNGChunkpHYs* __fastcall GetPixelInformation(void);
	TLMDPNGTransparencyMode __fastcall GetTransparencyMode(void);
	System::Uitypes::TColor __fastcall GetTransparentColor(void);
	void __fastcall SetTransparentColor(const System::Uitypes::TColor Value);
	
protected:
	bool BeingCreated;
	System::StaticArray<System::Byte, 256> InverseGamma;
	void __fastcall InitializeGamma(void);
	virtual HPALETTE __fastcall GetPalette(void);
	virtual void __fastcall SetPalette(HPALETTE Value);
	void __fastcall DoSetPalette(HPALETTE Value, const bool UpdateColors);
	virtual int __fastcall GetWidth(void);
	virtual int __fastcall GetHeight(void);
	virtual void __fastcall SetWidth(int Value);
	virtual void __fastcall SetHeight(int Value);
	void __fastcall AssignPNG(TLMDPNGObject* Source);
	virtual bool __fastcall GetEmpty(void);
	TLMDPNGChunkIHDR* __fastcall GetHeader(void);
	void __fastcall DrawPartialTrans(HDC DC, const System::Types::TRect &ARect);
	virtual bool __fastcall GetTransparent(void);
	virtual System::Uitypes::TColor __fastcall GetPixels(const int X, const int Y);
	virtual void __fastcall SetPixels(const int X, const int Y, const System::Uitypes::TColor Value);
	
public:
	System::StaticArray<System::Byte, 256> GammaTable;
	void __fastcall Resize(const int CX, const int CY);
	void __fastcall Rotate(double AAngle, const System::Types::TPoint &AOldCenter, System::Types::TPoint &ANewCenter);
	void __fastcall CreateAlpha(void);
	void __fastcall RemoveTransparency(void);
	__property System::Uitypes::TColor TransparentColor = {read=GetTransparentColor, write=SetTransparentColor, nodefault};
	void __fastcall AddtEXt(const System::AnsiString Keyword, const System::AnsiString Text);
	void __fastcall AddzTXt(const System::AnsiString Keyword, const System::AnsiString Text);
	virtual void __fastcall SaveToClipboardFormat(System::Word &AFormat, NativeUInt &AData, HPALETTE &APalette);
	virtual void __fastcall LoadFromClipboardFormat(System::Word AFormat, NativeUInt AData, HPALETTE APalette);
	void __fastcall RaiseError(System::Sysutils::ExceptClass ExceptionClass, System::UnicodeString Text);
	bool __fastcall HasPixelInformation(void);
	__property TLMDPNGChunkpHYs* PixelInformation = {read=GetPixelInformation};
	__property void * Scanline[const int Index] = {read=GetScanline};
	__property PByteArray AlphaScanline[const int Index] = {read=GetAlphaScanline};
	void __fastcall DrawUsingPixelInformation(Vcl::Graphics::TCanvas* Canvas, const System::Types::TPoint &Point);
	__property Vcl::Graphics::TCanvas* Canvas = {read=fCanvas};
	__property TLMDPNGChunkIHDR* Header = {read=GetHeader};
	__property TLMDPNGTransparencyMode TransparencyMode = {read=GetTransparencyMode, nodefault};
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	void __fastcall AssignHandle(HBITMAP Handle, bool Transparent, unsigned TransparentColor);
	void __fastcall AssignIcon(HICON Handle);
	void __fastcall MaskRect(const System::Types::TRect &ADest, TLMDPNGObject* APng);
	void __fastcall CopyRect(const System::Types::TRect &ADest, TLMDPNGObject* APng, const System::Types::TRect &ASource);
	void __fastcall DrawAt(Vcl::Graphics::TCanvas* ACanvas, const int X, const int Y);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &Rect);
	__property int Width = {read=GetWidth, nodefault};
	__property int Height = {read=GetHeight, nodefault};
	__property TInterlaceMethod InterlaceMethod = {read=fInterlaceMethod, write=fInterlaceMethod, nodefault};
	__property TFilters Filters = {read=fFilters, write=fFilters, nodefault};
	__property int MaxIdatSize = {read=fMaxIdatSize, write=SetMaxIdatSize, nodefault};
	__property bool Empty = {read=GetEmpty, nodefault};
	__property TCompressionLevel CompressionLevel = {read=fCompressionLevel, write=fCompressionLevel, nodefault};
	__property TLMDPNGList* Chunks = {read=fChunkList};
	__fastcall virtual TLMDPNGObject(void);
	__fastcall TLMDPNGObject(unsigned ColorType, unsigned Bitdepth, int cx, int cy);
	__fastcall virtual ~TLMDPNGObject(void);
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall LoadFromResourceName(NativeUInt Instance, const System::UnicodeString Name);
	void __fastcall LoadFromResourceID(NativeUInt Instance, int ResID);
	HIDESBASE void __fastcall LoadFromFile(const Lmdtypes::TLMDString AFilename);
	HIDESBASE void __fastcall SaveToFile(const Lmdtypes::TLMDString AFilename);
	__property System::Uitypes::TColor Pixels[const int X][const int Y] = {read=GetPixels, write=SetPixels};
	__property HPALETTE Palette = {read=GetPalette, write=SetPalette, nodefault};
};


typedef System::StaticArray<char, 4> TLMDPNGChunkName;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPNGChunk : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	void *fData;
	unsigned fDataSize;
	TLMDPNGObject* fOwner;
	TLMDPNGChunkName fName;
	TLMDPNGChunkIHDR* __fastcall GetHeader(void);
	int __fastcall GetIndex(void);
	__classmethod virtual System::AnsiString __fastcall GetName();
	System::AnsiString __fastcall GeTLMDPNGChunkName(void);
	
public:
	__property int Index = {read=GetIndex, nodefault};
	__property TLMDPNGChunkIHDR* Header = {read=GetHeader};
	void __fastcall ResizeData(const unsigned NewSize);
	__property void * Data = {read=fData};
	__property unsigned DataSize = {read=fDataSize, nodefault};
	virtual void __fastcall Assign(TLMDPNGChunk* Source);
	__property TLMDPNGObject* Owner = {read=fOwner};
	__fastcall virtual TLMDPNGChunk(TLMDPNGObject* Owner);
	__fastcall virtual ~TLMDPNGChunk(void);
	__property System::AnsiString Name = {read=GeTLMDPNGChunkName};
	virtual bool __fastcall LoadFromStream(System::Classes::TStream* Stream, const TLMDPNGChunkName ChunkName, int Size);
	bool __fastcall SaveData(System::Classes::TStream* Stream);
	virtual bool __fastcall SaveToStream(System::Classes::TStream* Stream);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPNGChunkIEND : public TLMDPNGChunk
{
	typedef TLMDPNGChunk inherited;
	
public:
	/* TLMDPNGChunk.Create */ inline __fastcall virtual TLMDPNGChunkIEND(TLMDPNGObject* Owner) : TLMDPNGChunk(Owner) { }
	/* TLMDPNGChunk.Destroy */ inline __fastcall virtual ~TLMDPNGChunkIEND(void) { }
	
};

#pragma pack(pop)

typedef TLMDPNGIHDRData *PLMDPNGIHDRData;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDPNGIHDRData
{
public:
	unsigned Width;
	unsigned Height;
	System::Byte BitDepth;
	System::Byte ColorType;
	System::Byte CompressionMethod;
	System::Byte FilterMethod;
	System::Byte InterlaceMethod;
};
#pragma pack(pop)


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPNGChunkIHDR : public TLMDPNGChunk
{
	typedef TLMDPNGChunk inherited;
	
private:
	HPALETTE ImagePalette;
	HBITMAP ImageHandle;
	HBITMAP OldImageHandle;
	HDC ImageDC;
	bool HasPalette;
	TMAXBITMAPINFO BitmapInfo;
	void *ImageData;
	void *ImageAlpha;
	TLMDPNGIHDRData IHDRData;
	
protected:
	int BytesPerRow;
	HPALETTE __fastcall CreateGrayscalePalette(int Bitdepth);
	void __fastcall PaletteToDIB(HPALETTE Palette);
	void __fastcall PrepareImageData(void);
	void __fastcall FreeImageData(void);
	
public:
	__property HBITMAP ImageHandleValue = {read=ImageHandle, nodefault};
	__property unsigned Width = {read=IHDRData.Width, write=IHDRData.Width, nodefault};
	__property unsigned Height = {read=IHDRData.Height, write=IHDRData.Height, nodefault};
	__property System::Byte BitDepth = {read=IHDRData.BitDepth, write=IHDRData.BitDepth, nodefault};
	__property System::Byte ColorType = {read=IHDRData.ColorType, write=IHDRData.ColorType, nodefault};
	__property System::Byte CompressionMethod = {read=IHDRData.CompressionMethod, write=IHDRData.CompressionMethod, nodefault};
	__property System::Byte FilterMethod = {read=IHDRData.FilterMethod, write=IHDRData.FilterMethod, nodefault};
	__property System::Byte InterlaceMethod = {read=IHDRData.InterlaceMethod, write=IHDRData.InterlaceMethod, nodefault};
	virtual bool __fastcall LoadFromStream(System::Classes::TStream* Stream, const TLMDPNGChunkName ChunkName, int Size);
	virtual bool __fastcall SaveToStream(System::Classes::TStream* Stream);
	__fastcall virtual TLMDPNGChunkIHDR(TLMDPNGObject* Owner);
	__fastcall virtual ~TLMDPNGChunkIHDR(void);
	virtual void __fastcall Assign(TLMDPNGChunk* Source);
};

#pragma pack(pop)

enum DECLSPEC_DENUM TUnitType : unsigned char { utUnknown, utMeter };

typedef TUnitType *pUnitType;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPNGChunkpHYs : public TLMDPNGChunk
{
	typedef TLMDPNGChunk inherited;
	
private:
	unsigned fPPUnitX;
	unsigned fPPUnitY;
	TUnitType fUnit;
	
public:
	__property unsigned PPUnitX = {read=fPPUnitX, write=fPPUnitX, nodefault};
	__property unsigned PPUnitY = {read=fPPUnitY, write=fPPUnitY, nodefault};
	__property TUnitType UnitType = {read=fUnit, write=fUnit, nodefault};
	virtual bool __fastcall LoadFromStream(System::Classes::TStream* Stream, const TLMDPNGChunkName ChunkName, int Size);
	virtual bool __fastcall SaveToStream(System::Classes::TStream* Stream);
	virtual void __fastcall Assign(TLMDPNGChunk* Source);
public:
	/* TLMDPNGChunk.Create */ inline __fastcall virtual TLMDPNGChunkpHYs(TLMDPNGObject* Owner) : TLMDPNGChunk(Owner) { }
	/* TLMDPNGChunk.Destroy */ inline __fastcall virtual ~TLMDPNGChunkpHYs(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPNGChunkgAMA : public TLMDPNGChunk
{
	typedef TLMDPNGChunk inherited;
	
private:
	unsigned __fastcall GetValue(void);
	void __fastcall SetValue(const unsigned Value);
	
public:
	__property unsigned Gamma = {read=GetValue, write=SetValue, nodefault};
	virtual bool __fastcall LoadFromStream(System::Classes::TStream* Stream, const TLMDPNGChunkName ChunkName, int Size);
	__fastcall virtual TLMDPNGChunkgAMA(TLMDPNGObject* Owner);
	virtual void __fastcall Assign(TLMDPNGChunk* Source);
public:
	/* TLMDPNGChunk.Destroy */ inline __fastcall virtual ~TLMDPNGChunkgAMA(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPNGChunkPLTE : public TLMDPNGChunk
{
	typedef TLMDPNGChunk inherited;
	
protected:
	int fCount;
	
private:
	tagRGBQUAD __fastcall GetPaletteItem(System::Byte Index);
	
public:
	__property tagRGBQUAD Item[System::Byte Index] = {read=GetPaletteItem};
	__property int Count = {read=fCount, nodefault};
	virtual bool __fastcall LoadFromStream(System::Classes::TStream* Stream, const TLMDPNGChunkName ChunkName, int Size);
	virtual bool __fastcall SaveToStream(System::Classes::TStream* Stream);
	virtual void __fastcall Assign(TLMDPNGChunk* Source);
public:
	/* TLMDPNGChunk.Create */ inline __fastcall virtual TLMDPNGChunkPLTE(TLMDPNGObject* Owner) : TLMDPNGChunk(Owner) { }
	/* TLMDPNGChunk.Destroy */ inline __fastcall virtual ~TLMDPNGChunkPLTE(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPNGChunktRNS : public TLMDPNGChunk
{
	typedef TLMDPNGChunk inherited;
	
private:
	bool fBitTransparency;
	unsigned __fastcall GetTransparentColor(void);
	void __fastcall SetTransparentColor(const unsigned Value);
	
public:
	System::StaticArray<System::Byte, 256> PaletteValues;
	__property bool BitTransparency = {read=fBitTransparency, nodefault};
	__property unsigned TransparentColor = {read=GetTransparentColor, write=SetTransparentColor, nodefault};
	virtual bool __fastcall LoadFromStream(System::Classes::TStream* Stream, const TLMDPNGChunkName ChunkName, int Size);
	virtual bool __fastcall SaveToStream(System::Classes::TStream* Stream);
	virtual void __fastcall Assign(TLMDPNGChunk* Source);
public:
	/* TLMDPNGChunk.Create */ inline __fastcall virtual TLMDPNGChunktRNS(TLMDPNGObject* Owner) : TLMDPNGChunk(Owner) { }
	/* TLMDPNGChunk.Destroy */ inline __fastcall virtual ~TLMDPNGChunktRNS(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPNGChunkIDAT : public TLMDPNGChunk
{
	typedef TLMDPNGChunk inherited;
	
private:
	TLMDPNGChunkIHDR* Header;
	int ImageWidth;
	int ImageHeight;
	unsigned Row_Bytes;
	unsigned Offset;
	System::StaticArray<PByteArray, 6> Encode_Buffer;
	System::StaticArray<PByteArray, 2> Row_Buffer;
	bool RowUsed;
	int EndPos;
	void __fastcall FilterRow(void);
	System::Byte __fastcall FilterToEncode(void);
	int __fastcall IDATZlibRead(void *ZLIBStream, void * Buffer, int Count, int &EndPos, unsigned &crcfile);
	void __fastcall IDATZlibWrite(void *ZLIBStream, void * Buffer, const unsigned Length);
	void __fastcall FinishIDATZlib(void *ZLIBStream);
	void __fastcall PreparePalette(void);
	
protected:
	void __fastcall DecodeInterlacedAdam7(System::Classes::TStream* Stream, void *ZLIBStream, const int Size, unsigned &crcfile);
	void __fastcall DecodeNonInterlaced(System::Classes::TStream* Stream, void *ZLIBStream, const int Size, unsigned &crcfile);
	void __fastcall EncodeNonInterlaced(System::Classes::TStream* Stream, void *ZLIBStream);
	void __fastcall EncodeInterlacedAdam7(System::Classes::TStream* Stream, void *ZLIBStream);
	void __fastcall CopyNonInterlacedRGB8(char * Src, char * Dest, char * Trans);
	void __fastcall CopyNonInterlacedRGB16(char * Src, char * Dest, char * Trans);
	void __fastcall CopyNonInterlacedPalette148(char * Src, char * Dest, char * Trans);
	void __fastcall CopyNonInterlacedPalette2(char * Src, char * Dest, char * Trans);
	void __fastcall CopyNonInterlacedGray2(char * Src, char * Dest, char * Trans);
	void __fastcall CopyNonInterlacedGrayscale16(char * Src, char * Dest, char * Trans);
	void __fastcall CopyNonInterlacedRGBAlpha8(char * Src, char * Dest, char * Trans);
	void __fastcall CopyNonInterlacedRGBAlpha16(char * Src, char * Dest, char * Trans);
	void __fastcall CopyNonInterlacedGrayscaleAlpha8(char * Src, char * Dest, char * Trans);
	void __fastcall CopyNonInterlacedGrayscaleAlpha16(char * Src, char * Dest, char * Trans);
	void __fastcall CopyInterlacedRGB8(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	void __fastcall CopyInterlacedRGB16(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	void __fastcall CopyInterlacedPalette148(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	void __fastcall CopyInterlacedPalette2(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	void __fastcall CopyInterlacedGray2(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	void __fastcall CopyInterlacedGrayscale16(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	void __fastcall CopyInterlacedRGBAlpha8(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	void __fastcall CopyInterlacedRGBAlpha16(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	void __fastcall CopyInterlacedGrayscaleAlpha8(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	void __fastcall CopyInterlacedGrayscaleAlpha16(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	void __fastcall EncodeNonInterlacedRGB8(char * Src, char * Dest, char * Trans);
	void __fastcall EncodeNonInterlacedRGB16(char * Src, char * Dest, char * Trans);
	void __fastcall EncodeNonInterlacedGrayscale16(char * Src, char * Dest, char * Trans);
	void __fastcall EncodeNonInterlacedPalette148(char * Src, char * Dest, char * Trans);
	void __fastcall EncodeNonInterlacedRGBAlpha8(char * Src, char * Dest, char * Trans);
	void __fastcall EncodeNonInterlacedRGBAlpha16(char * Src, char * Dest, char * Trans);
	void __fastcall EncodeNonInterlacedGrayscaleAlpha8(char * Src, char * Dest, char * Trans);
	void __fastcall EncodeNonInterlacedGrayscaleAlpha16(char * Src, char * Dest, char * Trans);
	void __fastcall EncodeInterlacedRGB8(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	void __fastcall EncodeInterlacedRGB16(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	void __fastcall EncodeInterlacedPalette148(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	void __fastcall EncodeInterlacedGrayscale16(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	void __fastcall EncodeInterlacedRGBAlpha8(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	void __fastcall EncodeInterlacedRGBAlpha16(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	void __fastcall EncodeInterlacedGrayscaleAlpha8(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	void __fastcall EncodeInterlacedGrayscaleAlpha16(const System::Byte Pass, char * Src, char * Dest, char * Trans);
	
public:
	virtual bool __fastcall LoadFromStream(System::Classes::TStream* Stream, const TLMDPNGChunkName ChunkName, int Size);
	virtual bool __fastcall SaveToStream(System::Classes::TStream* Stream);
public:
	/* TLMDPNGChunk.Create */ inline __fastcall virtual TLMDPNGChunkIDAT(TLMDPNGObject* Owner) : TLMDPNGChunk(Owner) { }
	/* TLMDPNGChunk.Destroy */ inline __fastcall virtual ~TLMDPNGChunkIDAT(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPNGChunktIME : public TLMDPNGChunk
{
	typedef TLMDPNGChunk inherited;
	
private:
	System::Word fYear;
	System::Byte fMonth;
	System::Byte fDay;
	System::Byte fHour;
	System::Byte fMinute;
	System::Byte fSecond;
	
public:
	__property System::Word Year = {read=fYear, write=fYear, nodefault};
	__property System::Byte Month = {read=fMonth, write=fMonth, nodefault};
	__property System::Byte Day = {read=fDay, write=fDay, nodefault};
	__property System::Byte Hour = {read=fHour, write=fHour, nodefault};
	__property System::Byte Minute = {read=fMinute, write=fMinute, nodefault};
	__property System::Byte Second = {read=fSecond, write=fSecond, nodefault};
	virtual bool __fastcall LoadFromStream(System::Classes::TStream* Stream, const TLMDPNGChunkName ChunkName, int Size);
	virtual bool __fastcall SaveToStream(System::Classes::TStream* Stream);
	virtual void __fastcall Assign(TLMDPNGChunk* Source);
public:
	/* TLMDPNGChunk.Create */ inline __fastcall virtual TLMDPNGChunktIME(TLMDPNGObject* Owner) : TLMDPNGChunk(Owner) { }
	/* TLMDPNGChunk.Destroy */ inline __fastcall virtual ~TLMDPNGChunktIME(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPNGChunkTEXT : public TLMDPNGChunk
{
	typedef TLMDPNGChunk inherited;
	
private:
	System::AnsiString fKeyword;
	System::AnsiString fText;
	
public:
	__property System::AnsiString Keyword = {read=fKeyword, write=fKeyword};
	__property System::AnsiString Text = {read=fText, write=fText};
	virtual bool __fastcall LoadFromStream(System::Classes::TStream* Stream, const TLMDPNGChunkName ChunkName, int Size);
	virtual bool __fastcall SaveToStream(System::Classes::TStream* Stream);
	virtual void __fastcall Assign(TLMDPNGChunk* Source);
public:
	/* TLMDPNGChunk.Create */ inline __fastcall virtual TLMDPNGChunkTEXT(TLMDPNGObject* Owner) : TLMDPNGChunk(Owner) { }
	/* TLMDPNGChunk.Destroy */ inline __fastcall virtual ~TLMDPNGChunkTEXT(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPNGChunkzTXT : public TLMDPNGChunkTEXT
{
	typedef TLMDPNGChunkTEXT inherited;
	
public:
	virtual bool __fastcall LoadFromStream(System::Classes::TStream* Stream, const TLMDPNGChunkName ChunkName, int Size);
	virtual bool __fastcall SaveToStream(System::Classes::TStream* Stream);
public:
	/* TLMDPNGChunk.Create */ inline __fastcall virtual TLMDPNGChunkzTXT(TLMDPNGObject* Owner) : TLMDPNGChunkTEXT(Owner) { }
	/* TLMDPNGChunk.Destroy */ inline __fastcall virtual ~TLMDPNGChunkzTXT(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Lmdpngimage__1 ZLIBErrors;
static const System::Int8 FILTER_NONE = System::Int8(0x0);
static const System::Int8 FILTER_SUB = System::Int8(0x1);
static const System::Int8 FILTER_UP = System::Int8(0x2);
static const System::Int8 FILTER_AVERAGE = System::Int8(0x3);
static const System::Int8 FILTER_PAETH = System::Int8(0x4);
static const System::Int8 COLOR_GRAYSCALE = System::Int8(0x0);
static const System::Int8 COLOR_RGB = System::Int8(0x2);
static const System::Int8 COLOR_PALETTE = System::Int8(0x3);
static const System::Int8 COLOR_GRAYSCALEALPHA = System::Int8(0x4);
static const System::Int8 COLOR_RGBALPHA = System::Int8(0x6);
extern DELPHI_PACKAGE unsigned __fastcall update_crc(unsigned crc, PByteArray buf, int len);
extern DELPHI_PACKAGE int __fastcall ByteSwap(const int a);
extern DELPHI_PACKAGE void __fastcall RegisterChunk(TLMDPNGChunkClass ChunkClass);
}	/* namespace Lmdpngimage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPNGIMAGE)
using namespace Lmdpngimage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdpngimageHPP
