// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSedUtils.pas' rev: 31.00 (Windows)

#ifndef LmdsedutilsHPP
#define LmdsedutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>
#include <LMDStrings.hpp>
#include <System.SysUtils.hpp>
#include <LMDArrayUtils.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsedutils
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCharSeq;
class DELPHICLASS TLMDSeqFromString;
struct TLMDSegment;
struct TLMDSedIntConv;
class DELPHICLASS TLMDSedIntConversionCache;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCharSeq : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::WideChar operator[](int AIdx) { return this->Chars[AIdx]; }
	
private:
	int FBoundGap;
	int FBufferSize;
	System::WideChar __fastcall GetChar(int AIdx);
	
protected:
	int FCount;
	int FBufferStart;
	int FBufferEnd;
	Lmdtypes::TLMDCharArray FBuffer;
	void __fastcall ResetBuffer(void);
	virtual void __fastcall FillBuffer(int ABufferStart, int ABufferEnd) = 0 ;
	__fastcall TLMDCharSeq(int ABufSize);
	
public:
	void __fastcall AssureIdx(int AIdx);
	__property int Count = {read=FCount, nodefault};
	__property System::WideChar Chars[int AIdx] = {read=GetChar/*, default*/};
	__property int BufferStart = {read=FBufferStart, nodefault};
	__property int BufferEnd = {read=FBufferEnd, nodefault};
	__property Lmdtypes::TLMDCharArray Buffer = {read=FBuffer};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDCharSeq(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSeqFromString : public TLMDCharSeq
{
	typedef TLMDCharSeq inherited;
	
protected:
	Lmdtypes::TLMDCharArray FArr;
	virtual void __fastcall FillBuffer(int ABufferStart, int ABufferEnd);
	
public:
	__fastcall TLMDSeqFromString(const Lmdtypes::TLMDString AStr);
	void __fastcall Reset(const Lmdtypes::TLMDString AStr)/* overload */;
	void __fastcall Reset(System::WideChar AChar, int ACount)/* overload */;
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDSeqFromString(void) { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TLMDSegment
{
public:
	int Start;
	int Count;
	TLMDCharSeq* Source;
};


struct DECLSPEC_DRECORD TLMDSedIntConv
{
public:
	int Key1;
	int Key2;
	int Data;
};


typedef System::DynamicArray<TLMDSedIntConv> TLMDSedIntConvArray;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSedIntConversionCache : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDSedIntConvArray FKeys;
	int FKeyCount;
	
private:
	int FMaxCount;
	int __fastcall AddByKeyLow(int AKey1, int AKey2, int AData, bool ByKey1);
	int __fastcall FindUpperByKeyLow(int AKey, bool ByKey1, /* out */ int &AKey1Res, /* out */ int &AKey2Res);
	int __fastcall FindNearestByKeyLow(int AKey, bool ByKey1, /* out */ int &AKey1Res, /* out */ int &AKey2Res, /* out */ int &AData);
	void __fastcall InvalidateFromKeyLow(int AKey, bool ByKey1);
	
public:
	__fastcall TLMDSedIntConversionCache(int AMaxCount);
	int __fastcall AddByKey1(int AKey1, int AKey2, int Data);
	int __fastcall AddByKey2(int AKey1, int AKey2, int Data);
	int __fastcall FindNearestByKey1(int AKey1, /* out */ int &AKey1Res, /* out */ int &AKey2Res, /* out */ int &AData);
	int __fastcall FindNearestByKey2(int AKey2, /* out */ int &AKey1Res, /* out */ int &AKey2Res, /* out */ int &AData);
	void __fastcall InvalidateFromKey1(int AKey1);
	void __fastcall InvalidateFromKey2(int AKey2);
	__property int Count = {read=FKeyCount, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDSedIntConversionCache(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDCharSeq* __fastcall LMDSeqFromPtr(const System::WideChar * APtr, int ACount);
extern DELPHI_PACKAGE void __fastcall LMDSegCopyToPtr(const TLMDSegment &ASrc, System::WideChar * ADst);
extern DELPHI_PACKAGE void __fastcall LMDSegFree(TLMDSegment &ASeg);
extern DELPHI_PACKAGE TLMDSegment __fastcall LMDSegFromString(const Lmdtypes::TLMDString AStr);
extern DELPHI_PACKAGE TLMDCharSeq* __fastcall LMDSeqFromString(const Lmdtypes::TLMDString AStr);
extern DELPHI_PACKAGE bool __fastcall LMDSegIsValid(const TLMDSegment &ASeg);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDSegToString(const TLMDSegment &ASeg);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDSeqToString(TLMDCharSeq* const ASeq);
extern DELPHI_PACKAGE System::WideChar __fastcall LMDSegAt(int AIdx, const TLMDSegment &ASeg);
extern DELPHI_PACKAGE int __fastcall LMDSegEnd(const TLMDSegment &ASeg);
extern DELPHI_PACKAGE TLMDSegment __fastcall LMDSegment(int AStart, int ALength, TLMDCharSeq* const ASource)/* overload */;
extern DELPHI_PACKAGE TLMDSegment __fastcall LMDSegment(TLMDCharSeq* const ASource)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDSegCopyToArray(const TLMDSegment &ASrc, Lmdtypes::TLMDCharArray &ADst, int ADstIdx);
extern DELPHI_PACKAGE int __fastcall LMDSeqPos(const Lmdtypes::TLMDString ASubStr, TLMDCharSeq* const ASeq, int AOffset, int AMaxCount = 0xffffffff);
extern DELPHI_PACKAGE int __fastcall LMDSeqPosBack(const Lmdtypes::TLMDString ASubStr, TLMDCharSeq* const ASeq, int AOffset, int AMaxCount = 0xffffffff);
extern DELPHI_PACKAGE int __fastcall LMDSeqPosCI(const Lmdtypes::TLMDString ASubStr, TLMDCharSeq* const ASeq, int AOffset, int AMaxCount = 0xffffffff);
extern DELPHI_PACKAGE int __fastcall LMDSeqPosBackCI(const Lmdtypes::TLMDString ASubStr, TLMDCharSeq* const ASeq, int AOffset, int AMaxCount = 0xffffffff);
extern DELPHI_PACKAGE int __fastcall LMDSeqPosOneOfGen(const Lmdtypes::TLMDString ASearchSet, TLMDCharSeq* const ASeq, int AOffset, int AMaxCount, bool Back, bool NotOf);
extern DELPHI_PACKAGE int __fastcall LMDSeqPosOneOf(const Lmdtypes::TLMDString SearchSet, TLMDCharSeq* const Seq, int Offset, int MaxCount = 0xffffffff);
extern DELPHI_PACKAGE int __fastcall LMDSeqPosOneNotOf(const Lmdtypes::TLMDString SearchSet, TLMDCharSeq* const Seq, int Offset, int MaxCount = 0xffffffff);
extern DELPHI_PACKAGE int __fastcall LMDSeqPosOneOfBack(const Lmdtypes::TLMDString SearchSet, TLMDCharSeq* const Seq, int Offset, int MaxCount = 0xffffffff);
extern DELPHI_PACKAGE int __fastcall LMDSeqPosOneNotOfBack(const Lmdtypes::TLMDString SearchSet, TLMDCharSeq* const Seq, int Offset, int MaxCount = 0xffffffff);
extern DELPHI_PACKAGE TLMDSegment __fastcall LMDBadSegment(void);
extern DELPHI_PACKAGE bool __fastcall LMDSegIsBad(const TLMDSegment &ASeg);
extern DELPHI_PACKAGE void __fastcall SedInvalidateRect(NativeUInt AHandle, const System::Types::TRect &ARect);
extern DELPHI_PACKAGE void __fastcall SedGetFontSize(Vcl::Graphics::TFont* AFont, HDC ADC, /* out */ int &AverWidth, /* out */ int &MaxWidth, /* out */ int &Height)/* overload */;
extern DELPHI_PACKAGE System::Types::TSize __fastcall SedGetFontScreenSize(Vcl::Graphics::TFont* AFont);
extern DELPHI_PACKAGE System::Types::TSize __fastcall SedGetFontSize(Vcl::Graphics::TFont* AFont, Vcl::Graphics::TCanvas* ACanvas)/* overload */;
extern DELPHI_PACKAGE System::Types::TSize __fastcall LMDSedTextExtent(Vcl::Graphics::TCanvas* ACanvas, const TLMDSegment &Text)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDSedTextWidth(Vcl::Graphics::TCanvas* ACanvas, const TLMDSegment &Text)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDSedTextWidth(Vcl::Graphics::TCanvas* ACanvas, const Lmdtypes::TLMDString Text)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDSedCharWidth(Vcl::Graphics::TCanvas* ACanvas, System::WideChar AChar);
extern DELPHI_PACKAGE System::Types::TSize __fastcall LMDSedTextExtent(Vcl::Graphics::TCanvas* ACanvas, const Lmdtypes::TLMDString Text)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDSedAssignFont(Vcl::Graphics::TFont* ADest, Vcl::Graphics::TFont* ASrc, System::Uitypes::TFontCharset ACharset);
extern DELPHI_PACKAGE void __fastcall LMDGetDialogFont(Vcl::Graphics::TFont* AResult);
extern DELPHI_PACKAGE void __fastcall LMDSedTextRect(NativeUInt ACnvHandle, const System::Types::TRect &Rect, int X, int Y, System::WideChar * PText, int ACnt, bool ATransparent)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDSedTextRect(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &Rect, int X, int Y, const Lmdtypes::TLMDString AStr)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDCanGetClipboardText(void);
extern DELPHI_PACKAGE void __fastcall LMDGetClipboardText(/* out */ Lmdtypes::TLMDString &Res, /* out */ bool &IsRectBlock);
extern DELPHI_PACKAGE void __fastcall LMDSetClipboardText(const TLMDSegment &ASeg, bool ARectBlock);
extern DELPHI_PACKAGE int __fastcall MakeIntHash(int AKey);
extern DELPHI_PACKAGE int __fastcall MakeStrHash(const Lmdtypes::TLMDString AKey, int AStart, int ACount, bool AIgnoreCase = false);
extern DELPHI_PACKAGE int __fastcall MakeSeqHash(TLMDCharSeq* ASeq, int AStart, int ACount, bool AIgnoreCase = false);
extern DELPHI_PACKAGE bool __fastcall StrToColorHtml(const Lmdtypes::TLMDString AStr, System::Uitypes::TColor &Color);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall ColorToStrHtml(System::Uitypes::TColor AColor);
extern DELPHI_PACKAGE System::Types::TPoint __fastcall LMDBadPoint(void);
extern DELPHI_PACKAGE bool __fastcall LMDIsBadPoint(const System::Types::TPoint &APt);
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* __fastcall SedGetResourceImage(const System::UnicodeString AName);
extern DELPHI_PACKAGE int __fastcall GetNewArrLength(int ANewCount, int AOldLn);
extern DELPHI_PACKAGE bool __fastcall LMDPointsEqual(const System::Types::TPoint &P1, const System::Types::TPoint &P2);
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDMsecsToTime(unsigned AMs);
}	/* namespace Lmdsedutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSEDUTILS)
using namespace Lmdsedutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsedutilsHPP
