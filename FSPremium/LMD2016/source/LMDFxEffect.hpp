// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFxEffect.pas' rev: 31.00 (Windows)

#ifndef LmdfxeffectHPP
#define LmdfxeffectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Clipbrd.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDFxBitmap.hpp>
#include <LMDFxUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfxeffect
{
//-- forward type declarations -----------------------------------------------
struct TLMDFxPointSlide;
class DELPHICLASS TLMDFxProcItem;
class DELPHICLASS TLMDFxAnimationRec;
class DELPHICLASS TLMDFxProcList;
class DELPHICLASS ELMDProcItemError;
class DELPHICLASS TLMDFxTimer;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (*TLMDFxProc)(void);

typedef System::StaticArray<System::Byte, 1> TLMDFxMatrixFade;

typedef TLMDFxMatrixFade *PLMDFxMatrixFade;

typedef void __fastcall (*TLMDFxProcFade)(TLMDFxMatrixFade &Matrix, int Width, int Height, System::Byte Percent);

struct DECLSPEC_DRECORD TLMDFxPointSlide
{
public:
	System::Byte Alpha;
	short X;
	short Y;
};


typedef System::StaticArray<TLMDFxPointSlide, 1> TLMDFxMatrixSlide;

typedef TLMDFxMatrixSlide *PLMDFxMatrixSlide;

typedef void __fastcall (*TLMDFxProcSlide)(TLMDFxMatrixSlide &Matrix, int Width, int Height, System::Byte Percent);

typedef void __fastcall (*TLMDFxProcManual)(Lmdfxbitmap::TLMDFxBitmap* SourceImage, Lmdfxbitmap::TLMDFxBitmap* DestImage, TLMDFxAnimationRec* Animation, System::Byte Percent);

enum DECLSPEC_DENUM TLMDFxProcKind : unsigned char { pkFade, pkSlide, pkManual };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxProcItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDFxProcKind FKind;
	TLMDFxProc FProc;
	System::UnicodeString FName;
	
public:
	__property TLMDFxProcKind Kind = {read=FKind, write=FKind, nodefault};
	__property TLMDFxProc Proc = {read=FProc, write=FProc};
	__property System::UnicodeString Name = {read=FName, write=FName};
public:
	/* TObject.Create */ inline __fastcall TLMDFxProcItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFxProcItem(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDFxRotation : unsigned char { krNone, krRotate90, krRotate180, krRotate270 };

typedef System::UnicodeString TLMDFxEffectKind;

class PASCALIMPLEMENTATION TLMDFxAnimationRec : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	bool FEnabled;
	int FTime;
	int FResolution;
	TLMDFxEffectKind FEffect;
	int FTileCount;
	TLMDFxRotation FRotation;
	Vcl::Graphics::TBitmap* FBitmap;
	void __fastcall SetResolution(const int Value);
	void __fastcall SetTileCount(const int Value);
	void __fastcall SetTime(const int Value);
	void __fastcall SetBitmap(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetEffect(const TLMDFxEffectKind Value);
	
public:
	__fastcall virtual TLMDFxAnimationRec(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFxAnimationRec(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcl::Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
	__property TLMDFxEffectKind Effect = {read=FEffect, write=SetEffect};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=0};
	__property int Resolution = {read=FResolution, write=SetResolution, default=1};
	__property TLMDFxRotation Rotation = {read=FRotation, write=FRotation, default=0};
	__property int TileCount = {read=FTileCount, write=SetTileCount, default=1};
	__property int Time = {read=FTime, write=SetTime, default=400};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxProcList : public System::Classes::TList
{
	typedef System::Classes::TList inherited;
	
public:
	TLMDFxProcItem* operator[](System::UnicodeString Index) { return this->Procs[Index]; }
	
private:
	TLMDFxProcItem* __fastcall GetProcs(System::UnicodeString Index);
	
public:
	virtual void __fastcall Clear(void);
	__property TLMDFxProcItem* Procs[System::UnicodeString Index] = {read=GetProcs/*, default*/};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TLMDFxProcList(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TLMDFxProcList(void) : System::Classes::TList() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDProcItemError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDProcItemError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDProcItemError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDProcItemError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDProcItemError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDProcItemError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDProcItemError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDProcItemError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDProcItemError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDProcItemError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDProcItemError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDProcItemError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDProcItemError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDProcItemError(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDFxTimer : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	__int64 StartValue;
	__int64 StopValue;
	__int64 FFrequency;
	__int64 FCalibrate;
	System::Extended __fastcall GetElapsed(void);
	void __fastcall CalibrateWindows(void);
	
protected:
	__property __int64 Calibrate = {read=FCalibrate};
	
public:
	__fastcall TLMDFxTimer(void);
	__int64 __fastcall GetFrequency(void);
	void __fastcall Start(void);
	void __fastcall Stop(void);
	__property System::Extended Elapsed = {read=GetElapsed};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFxTimer(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define SRandomSelection L"[ RANDOM ] - Random selection"
#define SBitmap L"[ BITMAP ] - Bitmap Animation"
#define SFade L"[ FADE ] - "
#define SSlide L"[ SLIDE ] - "
#define SManual L"[ MANUAL ] - "
extern DELPHI_PACKAGE TLMDFxProcList* ProcList;
extern DELPHI_PACKAGE System::Classes::TStrings* LMDFxEffectList;
extern DELPHI_PACKAGE void __fastcall LMDFxExecuteAnimation(Vcl::Graphics::TCanvas* const ACanvas, int AX, int AY, Lmdfxbitmap::TLMDFxBitmap* ASourceImage, Lmdfxbitmap::TLMDFxBitmap* ADestImage, TLMDFxAnimationRec* AAnimation);
extern DELPHI_PACKAGE void __fastcall StretchAlphaRect(void *X, int Width, int Height, int XDst, int YDst, int WDst, int HDst, int XSrc, int YSrc, int WSrc, int HSrc, void *Alpha);
extern DELPHI_PACKAGE void __fastcall RegisterProc(System::UnicodeString AName, TLMDFxProcKind AKind, TLMDFxProc AProc);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDFxGetEffectListCommaText(void);
extern DELPHI_PACKAGE System::Classes::TStrings* __fastcall LMDFxGetEffectList(void)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDFxStartTimer(TLMDFxTimer* &Timer);
extern DELPHI_PACKAGE float __fastcall LMDFxStopTimer(TLMDFxTimer* &Timer);
}	/* namespace Lmdfxeffect */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFXEFFECT)
using namespace Lmdfxeffect;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfxeffectHPP
