// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acntUtils.pas' rev: 27.00 (Windows)

#ifndef AcntutilsHPP
#define AcntutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acntutils
{
//-- type declarations -------------------------------------------------------
typedef System::Sysutils::TSearchRec TacSearchRec;

typedef System::Classes::TStrings TacStrings;

typedef System::Classes::TStringList TacStringList;

typedef _WIN32_FIND_DATAW TacWIN32FindData;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE int __fastcall GetCaptionFontSize(void);
extern DELPHI_PACKAGE HFONT __fastcall acGetTitleFont(void);
extern DELPHI_PACKAGE System::Byte __fastcall WordToByte_(const System::Word Value);
extern DELPHI_PACKAGE __int64 __fastcall HexToInt(System::AnsiString HexStr);
extern DELPHI_PACKAGE void __fastcall GetIniSections(System::Classes::TStringList* const IniList, System::Classes::TStringList* const SectionsList);
extern DELPHI_PACKAGE void __fastcall GetIniSection(const System::UnicodeString Section, System::Classes::TStrings* Sections, System::Classes::TStrings* Strings);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ReadIniString(System::Classes::TStringList* IniList, System::Classes::TStringList* SectionsList, const System::UnicodeString Section, const System::UnicodeString Ident, const System::UnicodeString Default);
extern DELPHI_PACKAGE int __fastcall ReadIniInteger(System::Classes::TStringList* IniList, System::Classes::TStringList* SectionsList, const System::UnicodeString Section, const System::UnicodeString Ident, int Default);
extern DELPHI_PACKAGE void __fastcall Alert(void)/* overload */;
extern DELPHI_PACKAGE void __fastcall Alert(const System::UnicodeString s)/* overload */;
extern DELPHI_PACKAGE void __fastcall Alert(const int i)/* overload */;
extern DELPHI_PACKAGE Winapi::Messages::TMessage __fastcall MakeMessage(const int Msg, const NativeUInt WParam, const NativeInt LParam, const NativeInt aResult);
extern DELPHI_PACKAGE short __fastcall GetCents(const System::Extended Value);
extern DELPHI_PACKAGE System::UnicodeString __fastcall iff(const bool L, const System::UnicodeString s1, const System::UnicodeString s2);
extern DELPHI_PACKAGE System::TObject* __fastcall iffo(const bool L, System::TObject* const o1, System::TObject* const o2);
extern DELPHI_PACKAGE int __fastcall iffi(const bool L, const int i1, const int i2);
extern DELPHI_PACKAGE bool __fastcall Between(const int Value, const int i1, const int i2);
extern DELPHI_PACKAGE int __fastcall SumTrans(const int i1, const int i2);
extern DELPHI_PACKAGE int __fastcall Maxi(const int i1, const int i2);
extern DELPHI_PACKAGE int __fastcall Mini(const int i1, const int i2);
extern DELPHI_PACKAGE int __fastcall LimitIt(const int Value, const int MinValue, const int MaxValue);
extern DELPHI_PACKAGE void __fastcall Changei(int &i1, int &i2);
extern DELPHI_PACKAGE bool __fastcall IsValidFloat(const System::AnsiString Value, System::Extended &RetValue);
extern DELPHI_PACKAGE System::UnicodeString __fastcall FormatFloatStr(const System::AnsiString S, const bool Thousands);
extern DELPHI_PACKAGE bool __fastcall acGetAnimation(void);
extern DELPHI_PACKAGE void __fastcall acSetAnimation(const bool Value);
extern DELPHI_PACKAGE bool __fastcall RectIsVisible(const System::Types::TRect &ParentRect, const System::Types::TRect &Rect);
extern DELPHI_PACKAGE bool __fastcall RectInRect(const System::Types::TRect &BigRect, const System::Types::TRect &SmallRect);
extern DELPHI_PACKAGE System::Types::TRect __fastcall RotateRect(const System::Types::TRect &R);
extern DELPHI_PACKAGE System::Types::TRect __fastcall RectsAnd(const System::Types::TRect &R1, const System::Types::TRect &R2);
extern DELPHI_PACKAGE System::Types::TPoint __fastcall OffsetPoint(const System::Types::TPoint &p, const int x, const int y);
extern DELPHI_PACKAGE int __fastcall WidthOf(const System::Types::TRect &r, const bool CheckNegative = false);
extern DELPHI_PACKAGE int __fastcall HeightOf(const System::Types::TRect &r, const bool CheckNegative = false);
extern DELPHI_PACKAGE bool __fastcall SubStrInclude(const System::UnicodeString SubString, const System::UnicodeString s, bool CaseInsensitive);
extern DELPHI_PACKAGE System::UnicodeString __fastcall CorrectString(const System::UnicodeString s);
extern DELPHI_PACKAGE bool __fastcall acCharIn(const System::WideChar C, const System::Sysutils::TSysCharSet &SysCharSet);
extern DELPHI_PACKAGE int __fastcall acWordPosition(const int N, const System::UnicodeString S, const System::Sysutils::TSysCharSet &WordDelims);
extern DELPHI_PACKAGE int __fastcall WordPosition(const int N, const System::AnsiString S, const System::Sysutils::TSysCharSet &WordDelims);
extern DELPHI_PACKAGE System::AnsiString __fastcall ExtractWord(const int N, const System::AnsiString S, const System::Sysutils::TSysCharSet &WordDelims);
extern DELPHI_PACKAGE System::UnicodeString __fastcall acExtractWord(const int N, const System::UnicodeString S, const System::Sysutils::TSysCharSet &WordDelims);
extern DELPHI_PACKAGE int __fastcall acWordCount(const System::UnicodeString S, const System::Sysutils::TSysCharSet &WordDelims);
extern DELPHI_PACKAGE int __fastcall WordCount(const System::AnsiString S, const System::Sysutils::TSysCharSet &WordDelims);
extern DELPHI_PACKAGE int __fastcall GetWordNumber(const System::UnicodeString W, const System::UnicodeString S, const System::Sysutils::TSysCharSet &WordDelims);
extern DELPHI_PACKAGE System::AnsiString __fastcall AnsiProperCase(const System::AnsiString S, const System::Sysutils::TSysCharSet &WordDelims);
extern DELPHI_PACKAGE System::AnsiString __fastcall MakeStr(char C, int N);
extern DELPHI_PACKAGE System::UnicodeString __fastcall DelRSpace(const System::UnicodeString S);
extern DELPHI_PACKAGE System::UnicodeString __fastcall DelESpace(const System::UnicodeString S);
extern DELPHI_PACKAGE System::UnicodeString __fastcall DelBSpace(const System::UnicodeString S);
extern DELPHI_PACKAGE System::UnicodeString __fastcall DelChars(const System::UnicodeString S, System::WideChar Chr);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ReplaceStr(const System::UnicodeString S, const System::UnicodeString Srch, const System::UnicodeString Replace);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ExtractSubStr(const System::AnsiString S, int &Pos, const System::Sysutils::TSysCharSet &Delims);
extern DELPHI_PACKAGE bool __fastcall IsEmptyStr(const System::AnsiString S, const System::Sysutils::TSysCharSet &EmptyChars);
extern DELPHI_PACKAGE bool __fastcall IsNTFamily(void);
extern DELPHI_PACKAGE Sconst::TCacheInfo __fastcall MakeCacheInfo(Vcl::Graphics::TBitmap* const Bmp, const int x = 0x0, const int y = 0x0);
extern DELPHI_PACKAGE System::AnsiString __fastcall AddChar(const char C, const System::AnsiString S, const int N);
extern DELPHI_PACKAGE System::AnsiString __fastcall AddCharR(const char C, const System::AnsiString S, const int N);
extern DELPHI_PACKAGE System::UnicodeString __fastcall OemToAnsiStr(const System::UnicodeString OemStr);
extern DELPHI_PACKAGE bool __fastcall IsWordPresent(const System::UnicodeString W, const System::UnicodeString S, const System::Sysutils::TSysCharSet &WordDelims);
extern DELPHI_PACKAGE double __fastcall CurRound(const double f);
extern DELPHI_PACKAGE bool __fastcall DeleteRequest(void);
extern DELPHI_PACKAGE bool __fastcall CustomRequest(const System::UnicodeString s);
extern DELPHI_PACKAGE void __fastcall ShowWarning(const System::UnicodeString S);
extern DELPHI_PACKAGE void __fastcall ShowError(const System::UnicodeString s);
extern DELPHI_PACKAGE void __fastcall Delay(const int MSecs);
extern DELPHI_PACKAGE bool __fastcall IsIDERunning(void);
extern DELPHI_PACKAGE BOOL __fastcall IsWOW64Proc(void);
extern DELPHI_PACKAGE bool __fastcall HasProperty(System::TObject* const Component, const System::UnicodeString PropName);
extern DELPHI_PACKAGE System::TObject* __fastcall GetObjProp(System::TObject* const Component, const System::UnicodeString PropName);
extern DELPHI_PACKAGE void __fastcall SetObjProp(System::TObject* const Component, const System::UnicodeString PropName, System::TObject* const Value);
extern DELPHI_PACKAGE bool __fastcall CheckSetProp(System::TObject* const Component, const System::UnicodeString PropName, const System::UnicodeString Value);
extern DELPHI_PACKAGE bool __fastcall SetSetPropValue(System::TObject* const Component, const System::UnicodeString PropName, const System::UnicodeString ValueName, const bool Value);
extern DELPHI_PACKAGE int __fastcall GetIntProp(System::TObject* const Component, const System::UnicodeString PropName);
extern DELPHI_PACKAGE void __fastcall SetIntProp(System::TObject* const Component, const System::UnicodeString PropName, const int Value);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetSystemDir(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall NormalDir(const System::UnicodeString DirName);
extern DELPHI_PACKAGE __int64 __fastcall GetFileSize(const System::UnicodeString FileName)/* overload */;
extern DELPHI_PACKAGE BOOL __fastcall acFindNextFile(NativeUInt hFindFile, _WIN32_FIND_DATAW &lpFindFileData);
extern DELPHI_PACKAGE NativeUInt __fastcall acFindFirstFile(System::WideChar * lpFileName, _WIN32_FIND_DATAW &lpFindFileData);
extern DELPHI_PACKAGE bool __fastcall ValidFileName(const System::UnicodeString FileName);
extern DELPHI_PACKAGE bool __fastcall acDirExists(const System::UnicodeString Name);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ShortToLongFileName(const System::UnicodeString ShortName);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LongToShortFileName(const System::UnicodeString LongName);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ShortToLongPath(const System::UnicodeString ShortName);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LongToShortPath(const System::UnicodeString LongName);
extern DELPHI_PACKAGE bool __fastcall CopyFiles(const System::UnicodeString SrcMask, System::UnicodeString SrcDir, System::UnicodeString DstDir);
extern DELPHI_PACKAGE bool __fastcall MoveFiles(const System::UnicodeString SrcMask, System::UnicodeString SrcDir, System::UnicodeString DstDir);
extern DELPHI_PACKAGE bool __fastcall acCreateDir(const System::UnicodeString DirName);
extern DELPHI_PACKAGE bool __fastcall acRemoveDir(const System::UnicodeString DirName);
extern DELPHI_PACKAGE bool __fastcall acSetCurrentDir(const System::UnicodeString DirName);
extern DELPHI_PACKAGE System::UnicodeString __fastcall acGetCurrentDir(void);
extern DELPHI_PACKAGE bool __fastcall acDeleteFile(const System::UnicodeString FileName);
extern DELPHI_PACKAGE bool __fastcall acCopyFile(const System::UnicodeString ExistingFileName, const System::UnicodeString NewFileName, bool bFailIfExists);
extern DELPHI_PACKAGE int __fastcall acFileSetAttr(const System::UnicodeString FileName, unsigned Attr);
extern DELPHI_PACKAGE unsigned __fastcall acFileGetAttr(const System::UnicodeString FileName);
extern DELPHI_PACKAGE int __fastcall acFindFirst(const System::UnicodeString Path, int Attr, System::Sysutils::TSearchRec &F);
extern DELPHI_PACKAGE int __fastcall acFindNext(System::Sysutils::TSearchRec &F);
extern DELPHI_PACKAGE void __fastcall acFindClose(System::Sysutils::TSearchRec &F);
extern DELPHI_PACKAGE bool __fastcall ClearDir(const System::UnicodeString Path, bool Delete);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetAppName(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetAppPath(void);
extern DELPHI_PACKAGE Vcl::Graphics::TIcon* __fastcall GetIconForFile(const System::UnicodeString FullFileName, int Flag);
extern DELPHI_PACKAGE void __fastcall GetDirs(const System::UnicodeString Path, System::Classes::TStrings* Items);
extern DELPHI_PACKAGE bool __fastcall acSameText(const System::UnicodeString S1, const System::UnicodeString S2);
extern DELPHI_PACKAGE void __fastcall acFillString(System::UnicodeString &S, const int nCount, const System::WideChar C);
extern DELPHI_PACKAGE System::UnicodeString __fastcall acMakeString(const System::WideChar C, const int nCount);
}	/* namespace Acntutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACNTUTILS)
using namespace Acntutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcntutilsHPP
