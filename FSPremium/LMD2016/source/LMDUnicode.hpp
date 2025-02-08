// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDUnicode.pas' rev: 34.00 (Windows)

#ifndef LmdunicodeHPP
#define LmdunicodeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <LMDRTLConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdunicode
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
typedef unsigned UTF32;

typedef System::Word UTF16;

typedef System::Byte UTF8;

typedef unsigned *pUTF32;

typedef System::Word *pUTF16;

typedef System::Byte *pUTF8;

enum DECLSPEC_DENUM TLMDUnicodeCategory : unsigned char { ukLu, ukLl, ukLt, ukLm, ukLo, ukMn, ukMc, ukMe, ukNd, ukNl, ukNo, ukPc, ukPd, ukPs, ukPe, ukPi, ukPf, ukPo, ukSm, ukSc, ukSk, ukSo, ukZs, ukZl, ukZp, ukCc, ukCf, ukCs, ukCo, ukCn };

typedef System::Set<TLMDUnicodeCategory, TLMDUnicodeCategory::ukLu, TLMDUnicodeCategory::ukCn> TLMDUnicodeCategories;

enum DECLSPEC_DENUM ConversionFlags : unsigned char { strictConversion, lenientConversion };

enum DECLSPEC_DENUM ConversionResult : unsigned char { conversionOK, sourceExhausted, targetExhausted, sourceIllegal };

enum DECLSPEC_DENUM Lmdunicode__1 : unsigned char { wrfReplaceAll, wrfIgnoreCase };

typedef System::Set<Lmdunicode__1, Lmdunicode__1::wrfReplaceAll, Lmdunicode__1::wrfIgnoreCase> TWideReplaceFlags;

//-- var, const, procedure ---------------------------------------------------
#define LMDPathDelimiters L"/\\"
#define LMDWidePathDelimiters L"/\\"
extern DELPHI_PACKAGE bool __fastcall LMDIsUnicodePlatform(void);
extern DELPHI_PACKAGE ConversionResult __fastcall LMDConvertUTF16toUTF8(const System::WideString source, System::AnsiString &target, ConversionFlags flags, bool BOM);
extern DELPHI_PACKAGE ConversionResult __fastcall LMDConvertUTF8toUTF16(const System::AnsiString source, System::WideString &target, ConversionFlags flags, bool BOM);
extern DELPHI_PACKAGE System::WideString __fastcall LMDConvertUTF8String(const System::AnsiString Source);
extern DELPHI_PACKAGE int __fastcall LMDGetTrailingBytesUTF8(System::Byte AByte);
extern DELPHI_PACKAGE bool __fastcall LMDIsLegalUTF8Sequence(const System::AnsiString source, unsigned sourcelen);
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDConvertUTF16ToUTF7(System::WideString ASrc, const bool AEncodeOptionalChars = false, const bool ABOM = false);
extern DELPHI_PACKAGE bool __fastcall LMDTryConvertUTF7ToUTF16(const System::AnsiString ASrc, System::WideString &ADest, bool ARemoveBom = true);
extern DELPHI_PACKAGE System::WideString __fastcall LMDConvertUTF7ToUTF16(const System::AnsiString ASrc, bool ARemoveBom = true);
extern DELPHI_PACKAGE System::WideChar __fastcall LMDUnicodeUpperChar(System::WideChar C);
extern DELPHI_PACKAGE System::WideChar __fastcall LMDUnicodeLowerChar(System::WideChar C);
extern DELPHI_PACKAGE System::WideString __fastcall LMDUnicodeUpper(const System::WideString S);
extern DELPHI_PACKAGE System::WideString __fastcall LMDUnicodeLower(const System::WideString S);
extern DELPHI_PACKAGE TLMDUnicodeCategory __fastcall LMDWideGetCharCategory(System::WideChar AChar);
extern DELPHI_PACKAGE int __fastcall LMDWideCompareText(const System::WideString S1, const System::WideString S2);
extern DELPHI_PACKAGE bool __fastcall LMDWideSameText(const System::WideString S1, const System::WideString S2);
extern DELPHI_PACKAGE int __fastcall LMDWideCompareStr(const System::WideString S1, const System::WideString S2);
extern DELPHI_PACKAGE bool __fastcall LMDWideSameStr(const System::WideString S1, const System::WideString S2);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideMakeString(int FLen, const System::WideString Seq);
extern DELPHI_PACKAGE System::WideChar * __fastcall LMDWideStringDup(const System::WideString S);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideStringReplace(const System::WideString S, const System::WideString OldPattern, const System::WideString NewPattern, TWideReplaceFlags Flags);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideGetCharRangeString(System::WideChar FirstChar, System::WideChar LastChar);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideGetStringOf(System::WideChar Char, unsigned Len);
extern DELPHI_PACKAGE System::WideChar * __fastcall LMDWideStrScan(const System::WideChar * Str, System::WideChar AChr);
extern DELPHI_PACKAGE System::WideChar * __fastcall LMDWideStrRScan(const System::WideChar * Str, System::WideChar AChr);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideQuotedStr(const System::WideString S, System::WideChar Quote);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideExtractQuotedStr(System::WideChar * &Src, System::WideChar Quote);
extern DELPHI_PACKAGE void __fastcall LMDWideSetString(System::WideString &S, System::WideChar * Buffer, int Len);
extern DELPHI_PACKAGE System::WideChar * __fastcall LMDWideStrCopy(System::WideChar * Target, System::WideChar * Source);
extern DELPHI_PACKAGE System::WideChar * __fastcall LMDWideStrPCopy(System::WideChar * Target, const System::WideString Source);
extern DELPHI_PACKAGE int __fastcall LMDWideStrComp(const System::WideChar * S1, const System::WideChar * S2);
extern DELPHI_PACKAGE int __fastcall LMDWideStrLComp(const System::WideChar * Str1, const System::WideChar * Str2, unsigned MaxLen);
extern DELPHI_PACKAGE unsigned __fastcall LMDWideStrLen(const System::WideChar * Str);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideStrPas(const System::WideChar * Source);
extern DELPHI_PACKAGE void __fastcall LMDWideMove(const void *Source, void *Dest, int Count);
extern DELPHI_PACKAGE System::WideChar * __fastcall LMDWideStrMove(System::WideChar * Dest, const System::WideChar * Source, unsigned Count);
extern DELPHI_PACKAGE System::WideChar * __fastcall LMDWideStrECopy(System::WideChar * Dest, const System::WideChar * Source);
extern DELPHI_PACKAGE System::WideChar * __fastcall LMDWideStrLCopy(System::WideChar * Dest, const System::WideChar * Source, unsigned MaxLen);
extern DELPHI_PACKAGE System::WideChar * __fastcall LMDWideStrLCat(System::WideChar * Dest, const System::WideChar * Source, unsigned MaxLen);
extern DELPHI_PACKAGE System::WideChar * __fastcall LMDWideStrCat(System::WideChar * Dest, const System::WideChar * Source);
extern DELPHI_PACKAGE System::WideChar * __fastcall LMDWideStrAlloc(unsigned Size);
extern DELPHI_PACKAGE unsigned __fastcall LMDWideStrBufSize(const System::WideChar * Str);
extern DELPHI_PACKAGE System::WideChar * __fastcall LMDWideStrNew(const System::WideChar * Str);
extern DELPHI_PACKAGE void __fastcall LMDWideStrDispose(System::WideChar * Str);
extern DELPHI_PACKAGE System::WideChar * __fastcall LMDWideLastChar(const System::WideString S);
extern DELPHI_PACKAGE void __fastcall LMDFillWord(void *X, int Count, System::Word Value);
extern DELPHI_PACKAGE void __fastcall LMDFillWideChar(void *X, int Count, System::WideChar Value);
extern DELPHI_PACKAGE System::WideChar * __fastcall LMDWideStrPos(const System::WideChar * Str1, const System::WideChar * Str2);
extern DELPHI_PACKAGE System::WideChar * __fastcall LMDWideStrEnd(const System::WideChar * Str);
extern DELPHI_PACKAGE bool __fastcall LMDIsWideDelimiter(const System::WideString Delimiters, const System::WideString S, int Index);
extern DELPHI_PACKAGE int __fastcall LMDWidePos(const System::WideString Substr, const System::WideString S);
extern DELPHI_PACKAGE void __fastcall LMDWideInsert(System::WideString Text, System::WideString &S, int SPos);
extern DELPHI_PACKAGE void __fastcall LMDWideDelete(System::WideString &S, int SPos, int SLen);
extern DELPHI_PACKAGE bool __fastcall LMDIsWidePathDelimiter(const System::WideString S, int Index);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideGetShortHint(const System::WideString Hint);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDCreateUnicodeHintString(const System::WideString Value);
extern DELPHI_PACKAGE System::WideChar __fastcall LMDWMCharToUnicode(System::WideChar AC);
extern DELPHI_PACKAGE System::WideString __fastcall LMDKeyToUnicode(const System::UnicodeString Key);
}	/* namespace Lmdunicode */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDUNICODE)
using namespace Lmdunicode;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdunicodeHPP
