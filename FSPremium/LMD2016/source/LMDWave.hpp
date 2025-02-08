// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWave.pas' rev: 31.00 (Windows)

#ifndef LmdwaveHPP
#define LmdwaveHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.MMSystem.hpp>
#include <LMDObject.hpp>

//-- user supplied -----------------------------------------------------------
namespace Lmdwave
{
#pragma option push -b-
enum TLMDSndPlayMode { sdSync, sdAsync, sdLoop };
#pragma option pop
class DELPHICLASS TLMDCustomWave;
class PASCALIMPLEMENTATION TLMDCustomWave : public Lmdobject::TLMDObject 
{
	typedef Lmdobject::TLMDObject inherited;
protected:
	virtual bool __fastcall PlaySoundExt(TLMDSndPlayMode aValue) = 0 ;
public:
	bool __fastcall PlaySound(TLMDSndPlayMode aValue);
protected:
	#pragma option push -w-inl
	/* TLMDObject.Create */ inline __fastcall virtual TLMDCustomWave(Classes::TPersistent* Owner) : Lmdobject::TLMDObject(
		Owner) { }
	#pragma option pop
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDCustomWave(void) { }
	#pragma option pop
};
};

namespace Lmdwave
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDInvalidWave;
class DELPHICLASS ELMDErrorCheckingWave;
struct TLMDWaveInfo;
class DELPHICLASS TLMDWave;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDInvalidWave : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDInvalidWave(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDInvalidWave(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDInvalidWave(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDInvalidWave(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDInvalidWave(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDInvalidWave(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDInvalidWave(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDInvalidWave(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDInvalidWave(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDInvalidWave(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDInvalidWave(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDInvalidWave(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDInvalidWave(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDErrorCheckingWave : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDErrorCheckingWave(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDErrorCheckingWave(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDErrorCheckingWave(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDErrorCheckingWave(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDErrorCheckingWave(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDErrorCheckingWave(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDErrorCheckingWave(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDErrorCheckingWave(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDErrorCheckingWave(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDErrorCheckingWave(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDErrorCheckingWave(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDErrorCheckingWave(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDErrorCheckingWave(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDWaveFormat : unsigned char { wfUnknown, wfPCM };

enum DECLSPEC_DENUM TLMDChannelMode : unsigned char { cmUnknown, cmMono, cmStereo };

struct DECLSPEC_DRECORD TLMDWaveInfo
{
public:
	int Size;
	int SampleRate;
	TLMDChannelMode Channels;
	TLMDWaveFormat Format;
	System::Word BitsCount;
};


class PASCALIMPLEMENTATION TLMDWave : public TLMDCustomWave
{
	typedef TLMDCustomWave inherited;
	
private:
	System::Classes::TMemoryStream* FMemoryWave;
	System::Word __fastcall GetBits(void);
	bool __fastcall GetEmpty(void);
	TLMDWaveInfo __fastcall GetInfo(void);
	TLMDChannelMode __fastcall GetChannelMode(void);
	TLMDWaveFormat __fastcall GetFormat(void);
	int __fastcall GetSampleRate(void);
	int __fastcall GetSize(void);
	void __fastcall NewWave(System::Classes::TMemoryStream* Stream);
	void __fastcall ReadStream(int size, System::Classes::TStream* Stream);
	void __fastcall WriteStream(System::Classes::TStream* Stream, bool WriteSize);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall ReadData(System::Classes::TStream* Stream);
	virtual void __fastcall WriteData(System::Classes::TStream* Stream);
	
public:
	__fastcall virtual TLMDWave(System::Classes::TPersistent* Owner);
	__fastcall virtual TLMDWave(const System::UnicodeString FileName);
	__fastcall virtual ~TLMDWave(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall FreeWave(void);
	void __fastcall LoadCompressedFromStream(System::Classes::TStream* Stream);
	virtual void __fastcall LoadFromFile(const System::UnicodeString Filename);
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall LoadFromStreamEx(System::Classes::TStream* Stream);
	bool __fastcall Play(void);
	virtual bool __fastcall PlaySoundExt(TLMDSndPlayMode aValue);
	virtual void __fastcall SaveToFile(const System::UnicodeString Filename);
	void __fastcall SaveCompressedToStream(System::Classes::TStream* Stream);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall SaveToStreamEx(System::Classes::TStream* Stream);
	void __fastcall Stop(void);
	__property System::Word Bits = {read=GetBits, nodefault};
	__property TLMDChannelMode ChannelMode = {read=GetChannelMode, nodefault};
	__property bool Empty = {read=GetEmpty, nodefault};
	__property TLMDWaveFormat Format = {read=GetFormat, nodefault};
	__property TLMDWaveInfo Info = {read=GetInfo};
	__property System::Classes::TMemoryStream* MemoryWave = {read=FMemoryWave};
	__property int SampleRate = {read=GetSampleRate, nodefault};
	__property int Size = {read=GetSize, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall LMDMMWavePossible(void);
extern DELPHI_PACKAGE bool __fastcall LMDGetWaveFileInfo(const System::Sysutils::TFileName FileName, TLMDWaveInfo &info);
extern DELPHI_PACKAGE bool __fastcall LMDGetWaveStreamInfo(System::Classes::TStream* Stream, TLMDWaveInfo &info);
}	/* namespace Lmdwave */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWAVE)
using namespace Lmdwave;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwaveHPP
