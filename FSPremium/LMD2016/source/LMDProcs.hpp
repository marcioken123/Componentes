// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDProcs.pas' rev: 34.00 (Windows)

#ifndef LmdprocsHPP
#define LmdprocsHPP

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
#include <System.Math.hpp>
#include <System.TypInfo.hpp>
#include <LMDRTLConst.hpp>
#include <LMDTypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdprocs
{
//-- forward type declarations -----------------------------------------------
struct TLMDAlignRect;
class DELPHICLASS TLMDRawMemory;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDRectAlignment : unsigned char { raLeft, raCenter, raRight };

struct DECLSPEC_DRECORD TLMDAlignRect
{
public:
	TLMDRectAlignment align;
	int index;
	System::Types::TRect rect;
};


enum DECLSPEC_DENUM TLMDPathPrefix : unsigned char { ppWindows, ppSystem, ppProgram, ppFixed };

enum DECLSPEC_DENUM TLMDCompressionType : unsigned char { ctLZRW, ctZLib };

typedef System::Word TBufferSize;

typedef System::Word TBufferIndex;

typedef System::StaticArray<System::Byte, 32782> TABuffer;

typedef TABuffer *PBuffer;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRawMemory : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Byte operator[](int Offset) { return this->Byte[Offset]; }
	
private:
	void *FMemory;
	int FOffsetSize;
	int FBaseOffset;
	void __fastcall SetBaseOffset(const int Value);
	System::Byte __fastcall GetBytes(int Offset);
	void __fastcall SetBytes(int Offset, const System::Byte Value);
	System::Word __fastcall GetWords(int Offset);
	void __fastcall SetWords(int Offset, const System::Word Value);
	unsigned __fastcall GetDWords(int Offset);
	__int64 __fastcall GetInt64(int Offset);
	void __fastcall SetDWords(int Offset, const unsigned Value);
	void __fastcall SetInt64(int Offset, const __int64 Value);
	void __fastcall SetOffsetSize(int Value);
	
public:
	__fastcall TLMDRawMemory()/* overload */;
	__fastcall TLMDRawMemory(void * AMemory)/* overload */;
	__property void * Memory = {read=FMemory, write=FMemory};
	__property int BaseOffset = {read=FBaseOffset, write=SetBaseOffset, nodefault};
	__property int OffsetSize = {read=FOffsetSize, write=SetOffsetSize, nodefault};
	__property System::Byte Byte[int Offset] = {read=GetBytes, write=SetBytes/*, default*/};
	__property System::Word Word[int Offset] = {read=GetWords, write=SetWords};
	__property unsigned DWord[int Offset] = {read=GetDWords, write=SetDWords};
	__property __int64 Int64[int Offset] = {read=GetInt64, write=SetInt64};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRawMemory() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Word MaxBufferSize = System::Word(0x7fff);
static const System::Word MaxBufferIndex = System::Word(0x800d);
extern DELPHI_PACKAGE void __fastcall LMDAlignRects(const System::Types::TRect &inRect, TLMDAlignRect *a, const int a_High);
extern DELPHI_PACKAGE void __fastcall LMDCheckRects(TLMDAlignRect *a, const int a_High);
extern DELPHI_PACKAGE System::Types::TRect __fastcall LMDExpandRect(const System::Types::TRect &aRect, int aValue);
extern DELPHI_PACKAGE void __fastcall LMDAdjustRect(System::Types::TRect &aRect, int dx, int dy);
extern DELPHI_PACKAGE void __fastcall LMDAdjustRectExt(System::Types::TRect &aRect, int dx, int dy, int dx1, int dy1)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDAdjustRectExt(System::Types::TRect &aRect, const System::Types::TRect &ASecondRect)/* overload */;
extern DELPHI_PACKAGE System::Types::TRect __fastcall LMDAffineRect(const System::Types::TRect &srcRect, const System::Types::TRect &destRect);
extern DELPHI_PACKAGE bool __fastcall LMDRectinRect(const System::Types::TRect &first, const System::Types::TRect &second);
extern DELPHI_PACKAGE void __fastcall LMDCenterRects(int WS, int WT, int HS, int HT, System::Types::TRect &R);
extern DELPHI_PACKAGE System::Types::TRect __fastcall LMDRectTopPart(const System::Types::TRect &aRect, System::Byte aPercent);
extern DELPHI_PACKAGE System::Types::TRect __fastcall LMDRectBottomPart(const System::Types::TRect &aRect, System::Byte aPercent);
extern DELPHI_PACKAGE System::Types::TRect __fastcall LMDRectLeftPart(const System::Types::TRect &aRect, System::Byte aPercent);
extern DELPHI_PACKAGE System::Types::TRect __fastcall LMDRectRightPart(const System::Types::TRect &aRect, System::Byte aPercent);
extern DELPHI_PACKAGE System::Types::TRect __fastcall LMDRelativeRect(const System::Types::TRect &aBoundsRect, const System::Types::TRect &aPercentsRect);
extern DELPHI_PACKAGE System::Types::TPoint __fastcall LMDRelativePoint(const System::Types::TRect &aBoundsRect, const System::Types::TPoint &aPercentsPoint);
extern DELPHI_PACKAGE int __fastcall LMDRectWidth(const System::Types::TRect &ARect);
extern DELPHI_PACKAGE int __fastcall LMDRectHeight(const System::Types::TRect &ARect);
extern DELPHI_PACKAGE void __fastcall LMDGetRectWH(const System::Types::TRect &srcRect, int &w, int &h);
extern DELPHI_PACKAGE bool __fastcall LMDRectEquals(const System::Types::TRect &R1, const System::Types::TRect &R2);
extern DELPHI_PACKAGE void __fastcall LMDCalcRotRect(System::Types::TRect &aRect, int anAngle);
extern DELPHI_PACKAGE int __fastcall LMDRotatedXPos(int Anangle, int AWidth, int AHeight);
extern DELPHI_PACKAGE int __fastcall LMDRotatedYPos(int Anangle, int AWidth, int AHeight);
extern DELPHI_PACKAGE void __fastcall LMDMidpoint(const System::Types::TPoint *X, const int X_High, System::Types::TPoint &Mid);
extern DELPHI_PACKAGE void __fastcall LMDOffsetPoints(System::Types::TPoint *X, const int X_High, int dx, int dy);
extern DELPHI_PACKAGE void __fastcall LMDNullPoints(System::Types::TPoint *X, const int X_High);
extern DELPHI_PACKAGE int __fastcall LMDMax(const int *X, const int X_High);
extern DELPHI_PACKAGE int __fastcall LMDMin(const int *X, const int X_High);
extern DELPHI_PACKAGE int __fastcall LMDMidI(int x, int y);
extern DELPHI_PACKAGE System::Extended __fastcall LMDMaxR(const System::Extended *X, const int X_High);
extern DELPHI_PACKAGE System::Extended __fastcall LMDMinR(const System::Extended *X, const int X_High);
extern DELPHI_PACKAGE void __fastcall LMDSwapInt(int &x, int &y);
extern DELPHI_PACKAGE void __fastcall LMDSwapString(System::UnicodeString &x, System::UnicodeString &y);
extern DELPHI_PACKAGE Lmdtypes::TLMDPercent __fastcall LMDGetPercentValue(__int64 aPosition, __int64 aMaxValue, __int64 aMinValue = 0LL);
extern DELPHI_PACKAGE bool __fastcall LMDIsHTMLText(Lmdtypes::TLMDString s);
extern DELPHI_PACKAGE System::Word __fastcall LMDSwapInt16(System::Word w);
extern DELPHI_PACKAGE int __fastcall LMDSwapInt32(int i);
extern DELPHI_PACKAGE int __fastcall LMDSign(int a);
extern DELPHI_PACKAGE void __fastcall LMDSetBit(System::Byte &holder, System::Byte bit, bool aValue);
extern DELPHI_PACKAGE void __fastcall LMDSetBitUpTo(System::Byte &Holder, System::Byte upTo);
extern DELPHI_PACKAGE bool __fastcall LMDGetBit(System::Byte holder, System::Byte bit);
extern DELPHI_PACKAGE __int64 __fastcall LMDExp(int ABase, int AExp);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDPtrToText(System::WideChar * APtr);
extern DELPHI_PACKAGE System::WideChar * __fastcall int_Ref(const System::UnicodeString Str)/* overload */;
extern DELPHI_PACKAGE char * __fastcall int_Ref(const System::AnsiString Str)/* overload */;
extern DELPHI_PACKAGE System::WideChar * __fastcall int_Ref(int V)/* overload */;
extern DELPHI_PACKAGE System::WideChar * __fastcall int_RefA(const System::UnicodeString Str, System::WideChar * &APtr)/* overload */;
extern DELPHI_PACKAGE char * __fastcall int_RefA(const System::AnsiString Str, char * &APtr)/* overload */;
extern DELPHI_PACKAGE char * __fastcall int_RefA(const System::AnsiString Str)/* overload */;
extern DELPHI_PACKAGE void __fastcall int_Free(char * const *Lst, const int Lst_High)/* overload */;
extern DELPHI_PACKAGE void __fastcall int_Free(System::WideChar * const *Lst, const int Lst_High)/* overload */;
extern DELPHI_PACKAGE System::WideChar * __fastcall int_RefW(const System::WideString Str);
extern DELPHI_PACKAGE System::WideChar * __fastcall int_RefWI(const System::WideString Str);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWebBufToStr(System::WideChar * Buf, int iLength, int iOffset = 0x0);
extern DELPHI_PACKAGE System::Types::TRect __fastcall LMDPtrToRect(System::Types::PRect APtr);
extern DELPHI_PACKAGE System::Types::PRect __fastcall LMDRectToPtr(const System::Types::TRect &ARect);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAppPath(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAppIniName(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDExtractFileName(const System::UnicodeString FileName);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDCreatePathPrefix(TLMDPathPrefix aValue, bool Slash);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSystemDirectory(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWindowsDirectory(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDShrunkFileName(const System::UnicodeString Filename, int MaxLen);
extern DELPHI_PACKAGE void __fastcall LMDDelay(unsigned ms);
extern DELPHI_PACKAGE TBufferSize __fastcall LMDLZRWCompress(PBuffer Source, PBuffer Dest, TBufferSize SourceSize);
extern DELPHI_PACKAGE TBufferSize __fastcall LMDLZRWDecompress(PBuffer Source, PBuffer Dest, TBufferSize Size);
extern DELPHI_PACKAGE unsigned __fastcall LMDZLibCompress(const PBuffer Source, PBuffer &Dest, unsigned SourceSize);
extern DELPHI_PACKAGE unsigned __fastcall LMDZLibDecompress(const PBuffer Source, PBuffer &Dest, unsigned Size);
extern DELPHI_PACKAGE void __fastcall LMDSaveCompressedStream(System::Classes::TStream* src, System::Classes::TStream* target, int size, TLMDCompressionType cType = (TLMDCompressionType)(0x0));
extern DELPHI_PACKAGE void __fastcall LMDLoadCompressedStream(System::Classes::TStream* src, System::Classes::TStream* target, TLMDCompressionType cType = (TLMDCompressionType)(0x0));
extern DELPHI_PACKAGE int __fastcall LMDInc(int &i);
extern DELPHI_PACKAGE int __fastcall LMDDec(int &i);
extern DELPHI_PACKAGE void __fastcall LMDMailTo(const System::UnicodeString aAddress, const System::UnicodeString aSubject = System::UnicodeString());
extern DELPHI_PACKAGE bool __fastcall LMDFireURL(const Lmdtypes::TLMDString URL, bool ALocal = false);
extern DELPHI_PACKAGE bool __fastcall LMDExecute(const System::UnicodeString Verb, const System::UnicodeString FileName);
extern DELPHI_PACKAGE System::Classes::TShiftState __fastcall LMDGetShiftState(void);
extern DELPHI_PACKAGE bool __fastcall LMDPointInRect(const System::Types::TPoint &APoint, const System::Types::TRect &ARect);
extern DELPHI_PACKAGE System::Types::TPoint __fastcall LMDMiddlePoint(const System::Types::TPoint &APoint1, const System::Types::TPoint &APoint2);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDShiftStateToString(System::Classes::TShiftState AState);
extern DELPHI_PACKAGE bool __fastcall LMDInRange(int AVal, int ALower, int AUpper);
extern DELPHI_PACKAGE int __fastcall LMDMinMax(int Val, int AMin, int AMax);
extern DELPHI_PACKAGE bool __fastcall LMDInRangeF(double AVal, double ALower, double AUpper);
extern DELPHI_PACKAGE System::Types::TRect __fastcall LMDGetWorkSpaceRect(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSetToString(const System::Typinfo::PTypeInfo ATypeInfo, int AValue, const bool ABrackets);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDDataToStr(void * Buffer, int BufLen);
extern DELPHI_PACKAGE bool __fastcall LMDStrToData(Lmdtypes::TLMDString S, void * &Buffer, int &BufLen);
}	/* namespace Lmdprocs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPROCS)
using namespace Lmdprocs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdprocsHPP
