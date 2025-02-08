// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStrings.pas' rev: 34.00 (Windows)

#ifndef LmdstringsHPP
#define LmdstringsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <System.SysUtils.hpp>
#include <LMDRTLConst.hpp>
#include <LMDTypes.hpp>
#include <LMDUnicode.hpp>
#include <LMDUnicodeStrings.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstrings
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStringsProxy;
class DELPHICLASS TLMDAnsiStringsProxy;
class DELPHICLASS TLMDStringHashNode;
struct TLMDStringHashIterator;
class DELPHICLASS TLMDStringHashTable;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStringsProxy : public System::Classes::TStrings
{
	typedef System::Classes::TStrings inherited;
	
private:
	System::Classes::TStrings* FOrigin;
	
protected:
	virtual System::UnicodeString __fastcall Get(int Index);
	virtual void __fastcall Put(int Index, const System::UnicodeString S);
	virtual int __fastcall GetCount();
	virtual System::TObject* __fastcall GetObject(int Index);
	virtual void __fastcall PutObject(int Index, System::TObject* AObject);
	virtual void __fastcall SetUpdateState(bool Updating);
	
public:
	__fastcall TLMDStringsProxy(System::Classes::TStrings* AOrigin);
	virtual void __fastcall Clear();
	virtual void __fastcall Delete(int Index);
	virtual void __fastcall Insert(int Index, const System::UnicodeString S);
	__property System::Classes::TStrings* Origin = {read=FOrigin};
public:
	/* TStrings.Destroy */ inline __fastcall virtual ~TLMDStringsProxy() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDAnsiStringsProxy : public System::Classes::TStrings
{
	typedef System::Classes::TStrings inherited;
	
private:
	System::Classes::TStrings* FOrigin;
	
protected:
	virtual System::UnicodeString __fastcall Get(int Index);
	virtual void __fastcall Put(int Index, const System::UnicodeString S);
	virtual int __fastcall GetCount();
	virtual System::TObject* __fastcall GetObject(int Index);
	virtual void __fastcall PutObject(int Index, System::TObject* AObject);
	virtual void __fastcall SetUpdateState(bool Updating);
	
public:
	__fastcall TLMDAnsiStringsProxy(System::Classes::TStrings* AOrigin);
	virtual void __fastcall Clear();
	virtual void __fastcall Delete(int Index);
	virtual void __fastcall Insert(int Index, const System::UnicodeString S);
	__property System::Classes::TStrings* Origin = {read=FOrigin};
public:
	/* TStrings.Destroy */ inline __fastcall virtual ~TLMDAnsiStringsProxy() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStringHashNode : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdtypes::TLMDString FKey;
	Lmdtypes::TLMDString FValue;
	System::TObject* FData;
	TLMDStringHashNode* FNext;
	
public:
	__property Lmdtypes::TLMDString Key = {read=FKey};
	__property Lmdtypes::TLMDString Value = {read=FValue};
	__property System::TObject* Data = {read=FData};
public:
	/* TObject.Create */ inline __fastcall TLMDStringHashNode() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDStringHashNode() { }
	
};

#pragma pack(pop)

typedef System::DynamicArray<TLMDStringHashNode*> TLMDStringHashNodeArray;

struct DECLSPEC_DRECORD TLMDStringHashIterator
{
public:
	TLMDStringHashNode* CurrentNode;
	int InternalIndex;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStringHashTable : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDStringHashNodeArray FItems;
	int FIndexMask;
	int FCount;
	bool FOwnItems;
	void __fastcall Grow(int AOldLength);
	void __fastcall Rehash(int AOldLength);
	void __fastcall InsertItem(TLMDStringHashNode* AItem);
	void __fastcall CheckNotOwnItems();
	
public:
	__fastcall TLMDStringHashTable(bool AOwnItems);
	__fastcall virtual ~TLMDStringHashTable();
	void __fastcall Clear();
	void __fastcall Add(const Lmdtypes::TLMDString AKey, const Lmdtypes::TLMDString AValue, System::TObject* AObj)/* overload */;
	void __fastcall Add(const Lmdtypes::TLMDString AKey, const Lmdtypes::TLMDString AValue)/* overload */;
	void __fastcall SetOrAdd(const Lmdtypes::TLMDString AKey, const Lmdtypes::TLMDString AValue, System::TObject* AObj)/* overload */;
	void __fastcall SetOrAdd(const Lmdtypes::TLMDString AKey, const Lmdtypes::TLMDString AValue)/* overload */;
	bool __fastcall Remove(const Lmdtypes::TLMDString AKey);
	Lmdtypes::TLMDString __fastcall Find(const Lmdtypes::TLMDString AKey)/* overload */;
	Lmdtypes::TLMDString __fastcall Find(const Lmdtypes::TLMDString AKey, System::TObject* &Obj)/* overload */;
	TLMDStringHashNode* __fastcall FindNode(const Lmdtypes::TLMDString AKey)/* overload */;
	bool __fastcall HasKey(const Lmdtypes::TLMDString AKey);
	bool __fastcall IteratorMoveFirst(TLMDStringHashIterator &Iter);
	bool __fastcall IteratorMoveNext(TLMDStringHashIterator &Iter);
	void __fastcall Assign(TLMDStringHashTable* AValue);
	void __fastcall Merge(TLMDStringHashTable* AValue);
	TLMDStringHashTable* __fastcall Clone();
	__property int Count = {read=FCount, nodefault};
	__property bool OwnItems = {read=FOwnItems, nodefault};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::WideChar LMDAnsiSpace = (System::WideChar)(0x20);
static const System::WideChar LMDWideSpace = (System::WideChar)(0x20);
static const System::WideChar LMDSpace = (System::WideChar)(0x20);
static const System::WideChar LMDAnsiTab = (System::WideChar)(0x9);
static const System::WideChar LMDWideTab = (System::WideChar)(0x9);
static const System::WideChar LMDTab = (System::WideChar)(0x9);
static const System::WideChar LMDAnsiCR = (System::WideChar)(0xd);
static const System::WideChar LMDWideCR = (System::WideChar)(0xd);
static const System::WideChar LMDCR = (System::WideChar)(0xd);
static const System::WideChar LMDAnsiLF = (System::WideChar)(0xa);
static const System::WideChar LMDWideLF = (System::WideChar)(0xa);
static const System::WideChar LMDLF = (System::WideChar)(0xa);
static const System::WideChar LMDAnsiFF = (System::WideChar)(0xc);
static const System::WideChar LMDWideFF = (System::WideChar)(0xc);
static const System::WideChar LMDFF = (System::WideChar)(0xc);
static const System::WideChar LMDAnsiBEL = (System::WideChar)(0x7);
static const System::WideChar LMDWideBEL = (System::WideChar)(0x7);
static const System::WideChar LMDBEL = (System::WideChar)(0x7);
static const System::WideChar LMDAnsiBS = (System::WideChar)(0x8);
static const System::WideChar LMDWideBS = (System::WideChar)(0x8);
static const System::WideChar LMDBS = (System::WideChar)(0x8);
static const System::WideChar LMDAnsiESCAPE = (System::WideChar)(0x1b);
static const System::WideChar LMDWideESCAPE = (System::WideChar)(0x1b);
static const System::WideChar LMDESCAPE = (System::WideChar)(0x1b);
#define LMDAnsiCRLF L"\r\n"
#define LMDWideCRLF L"\r\n"
#define LMDCRLF L"\r\n"
extern DELPHI_PACKAGE System::WideChar __fastcall LMDAnsiUpperChar(System::WideChar c)/* overload */;
extern DELPHI_PACKAGE char __fastcall LMDAnsiUpperChar(char c)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiIsSpace(System::WideChar c)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiIsSpace(char c)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiIsAlphaNumeric(System::WideChar c)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiIsAlphaNumeric(char c)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiIsAlpha(System::WideChar c)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiIsAlpha(char c)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiIsNumeric(System::WideChar c)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiIsNumeric(char c)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiIsNumericStr(System::UnicodeString s)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiIsNumericStr(System::AnsiString s)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDIsCharAlpha(System::WideChar c);
extern DELPHI_PACKAGE bool __fastcall LMDIsCharAlphaNumeric(System::WideChar c);
extern DELPHI_PACKAGE bool __fastcall LMDIsCharUpper(System::WideChar c);
extern DELPHI_PACKAGE bool __fastcall LMDIsCharLower(System::WideChar c);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiAddCharL(const System::UnicodeString aValue, int i, System::WideChar c)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiAddCharL(const System::AnsiString aValue, int i, char c)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiAddCharR(const System::UnicodeString aValue, int i, System::WideChar c)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiAddCharR(const System::AnsiString aValue, int i, char c)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiAddSpaceL(const System::UnicodeString aValue, int i)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiAddSpaceL(const System::AnsiString aValue, int i)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiAddSpaceR(const System::UnicodeString aValue, int i)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiAddSpaceR(const System::AnsiString aValue, int i)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiAddZeroL(const System::UnicodeString aValue, int i)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiAddZeroL(const System::AnsiString aValue, int i)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiAddZeroR(const System::UnicodeString aValue, int i)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiAddZeroR(const System::AnsiString aValue, int i)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiCodeString(const System::UnicodeString *X, const int X_High, System::WideChar delimiter)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiCodeString(const System::AnsiString *X, const int X_High, char delimiter)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiCodeInt(const int *X, const int X_High, System::WideChar delimiter)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiCodeInt(const int *X, const int X_High, char delimiter)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiGetCodedCount(const System::UnicodeString aValue, System::WideChar delimiter)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiGetCodedCount(const System::AnsiString aValue, char delimiter)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiGetCodedInt(const System::UnicodeString aValue, System::WideChar delimiter, int index)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiGetCodedInt(const System::AnsiString aValue, char delimiter, int index)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiGetCodedString(const System::UnicodeString aValue, System::WideChar delimiter, int index)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiGetCodedString(const System::AnsiString aValue, char delimiter, int index)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiIfThen(const bool AExpression, const System::UnicodeString ATrue, const System::UnicodeString AFalse)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiIfThen(const bool AExpression, const System::AnsiString ATrue, const System::AnsiString AFalse)/* overload */;
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideIfThen(const bool AExpression, const System::WideString ATrue, const System::WideString AFalse);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDIfThen(const bool AExpression, const Lmdtypes::TLMDString ATrue, const Lmdtypes::TLMDString AFalse);
extern DELPHI_PACKAGE void __fastcall LMDAnsiSetCodedString(System::UnicodeString &aValue, const System::UnicodeString partStr, System::WideChar delimiter, int index);
extern DELPHI_PACKAGE int __fastcall LMDAnsiCount(const System::UnicodeString aValue, const System::WideChar search)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiCount(const System::AnsiString aValue, const char search)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiBackPos(System::WideChar c, const System::UnicodeString s)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiBackPos(char c, const System::AnsiString s)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiEmpty(const System::UnicodeString aValue)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiEmpty(const System::AnsiString aValue)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiFillString(int i, System::WideChar w)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiFillString(int i, char w)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiCenterString(const System::UnicodeString S, int Len)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiCenterString(const System::AnsiString S, int Len)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiTrimL(const System::UnicodeString aValue)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiTrimL(const System::AnsiString aValue)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiTrimR(const System::UnicodeString aValue)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiTrimR(const System::AnsiString aValue)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiTrim(const System::UnicodeString aValue)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiTrim(const System::AnsiString aValue)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiGetFirstString(const System::UnicodeString aValue, System::WideChar delimiter)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiGetFirstString(const System::AnsiString aValue, char delimiter)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiGetLastString(const System::UnicodeString aValue, System::WideChar delimiter)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiGetLastString(const System::AnsiString aValue, char delimiter)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiGetRightTrimmedString(const System::UnicodeString aValue, System::WideChar delimiter)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiGetRightTrimmedString(const System::AnsiString aValue, char delimiter)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiAddDelimiter(System::UnicodeString s, System::WideChar delimiter)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiAddDelimiter(System::AnsiString s, char delimiter)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiGetSecondString(const System::UnicodeString aValue, System::WideChar delimiter)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiReplaceChar(const System::UnicodeString aValue, System::WideChar toReplace, System::WideChar Replace)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiReplaceChar(const System::AnsiString aValue, char toReplace, char Replace)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiMakeSpace(unsigned i)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiMakeSpace(int i)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiSlashAdd(const System::UnicodeString aValue)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiSlashAdd(const System::AnsiString aValue)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiSlashRemove(const System::UnicodeString aValue)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiSlashRemove(const System::AnsiString aValue)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiScanToNumber(const System::UnicodeString aValue)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiScanToNumber(const System::AnsiString aValue)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiEncode(const System::UnicodeString aValue, unsigned Key)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiEncode(const System::AnsiString aValue, unsigned Key)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiDecode(const System::UnicodeString aValue, unsigned Key)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiDecode(const System::AnsiString aValue, unsigned Key)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiEncode64(const System::UnicodeString aValue)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiEncode64(const System::AnsiString aValue)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiDecode64(const System::UnicodeString aValue)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiDecode64(const System::AnsiString aValue)/* overload */;
extern DELPHI_PACKAGE System::Types::TRect __fastcall LMDAnsiStringToRect(const System::UnicodeString aValue);
extern DELPHI_PACKAGE System::Types::TPoint __fastcall LMDAnsiStringToPoint(const System::UnicodeString aValue);
extern DELPHI_PACKAGE void __fastcall LMDAnsiStringToFont(const System::UnicodeString aValue, Vcl::Graphics::TFont* aFont);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiFontToString(Vcl::Graphics::TFont* aFont);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiPointToString(const System::Types::TPoint &aValue);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiRectToString(const System::Types::TRect &aValue);
extern DELPHI_PACKAGE bool __fastcall LMDAnsiRemoveEmptyLines(System::Classes::TStrings* list);
extern DELPHI_PACKAGE void __fastcall LMDAnsiParseToStrList(const System::UnicodeString w, const System::WideChar delimiter, System::Classes::TStrings* list)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDAnsiGetDivider(System::Classes::TStrings* dest, const int aValue);
extern DELPHI_PACKAGE int __fastcall LMDAnsiPosEx(const System::UnicodeString substr, const System::UnicodeString s, int Index)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiPosEx(const System::AnsiString substr, const System::AnsiString s, int Index)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiReplaceStr(const System::UnicodeString S, const System::UnicodeString Srch, const System::UnicodeString Replace)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiReplaceStr(const System::AnsiString S, const System::AnsiString Srch, const System::AnsiString Replace)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiStringToStream(const System::UnicodeString Str, System::Classes::TStream* Stream)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiStringToStream(const System::AnsiString Str, System::Classes::TStream* Stream)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiStreamToString(System::Classes::TStream* Stream, __int64 Size)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiStreamToString(System::Classes::TStream* Stream, int Size)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiWriteStringToStream(System::Classes::TStream* S, const System::UnicodeString Str)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiWriteStringToStream(System::Classes::TStream* S, const System::AnsiString Str)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiReadStringFromStream(System::Classes::TStream* S, System::UnicodeString &Str)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiReadStringFromStream(System::Classes::TStream* S, System::AnsiString &Str)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiH2D(const System::UnicodeString S)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiH2D(const System::AnsiString S)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiH2DDef(const System::UnicodeString S, int Def)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiH2DDef(const System::AnsiString S, int Def)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiStrStartsWith(System::WideChar * Source, System::WideChar * Seq)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiStrStartsWith(char * Source, char * Seq)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiContainsAt(const System::UnicodeString Source, int Index, const System::UnicodeString Seq)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiContainsAt(const System::AnsiString Source, int Index, const System::AnsiString Seq)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiLastPos(const System::UnicodeString SubStr, const System::UnicodeString Strn)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiLastPos(const System::AnsiString SubStr, const System::AnsiString Strn)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiExtractStr(System::UnicodeString &S, int SPos, int SLen)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiExtractStr(System::AnsiString &S, int SPos, int SLen)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiUpperCase(const System::UnicodeString Str)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiUpperCase(const System::AnsiString Str)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiLowerCase(const System::UnicodeString Str)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiLowerCase(const System::AnsiString Str)/* overload */;
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideAddCharL(const System::WideString aValue, int i, System::WideChar c);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideAddCharR(const System::WideString aValue, int i, System::WideChar c);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideAddSpaceL(const System::WideString aValue, int i);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideAddSpaceR(const System::WideString aValue, int i);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideAddZeroL(const System::WideString aValue, int i);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideAddZeroR(const System::WideString aValue, int i);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideCodeInt(const int *X, const int X_High, System::WideChar delimiter);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideCodeString(const System::WideString *X, const int X_High, System::WideChar delimiter);
extern DELPHI_PACKAGE int __fastcall LMDWideGetCodedCount(const System::WideString aValue, System::WideChar delimiter);
extern DELPHI_PACKAGE void __fastcall LMDWideSetCodedString(System::WideString &aValue, const System::WideString partStr, System::WideChar delimiter, int index);
extern DELPHI_PACKAGE int __fastcall LMDWideGetCodedInt(const System::WideString aValue, System::WideChar delimiter, int index);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideGetCodedString(const System::WideString aValue, System::WideChar delimiter, int index);
extern DELPHI_PACKAGE int __fastcall LMDWideCount(const System::WideString aValue, const System::WideChar search);
extern DELPHI_PACKAGE int __fastcall LMDWideBackPos(System::WideChar c, const System::WideString s);
extern DELPHI_PACKAGE bool __fastcall LMDWideEmpty(const System::WideString aValue);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideFillString(int i, System::WideChar w);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideCenterString(const System::WideString S, int Len);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideMakeSpace(int i);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideSlashRemove(const System::WideString aValue);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideSlashAdd(const System::WideString aValue);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideReplaceChar(const System::WideString aValue, System::WideChar toReplace, System::WideChar Replace);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideTrimL(const System::WideString aValue);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideTrimR(const System::WideString aValue);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideTrim(const System::WideString aValue);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideGetFirstString(const System::WideString aValue, System::WideChar delimiter);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideGetLastString(const System::WideString aValue, System::WideChar delimiter);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideGetSecondString(const System::WideString aValue, System::WideChar delimiter);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideGetRightTrimmedString(const System::WideString aValue, System::WideChar delimiter);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideAddDelimiter(System::WideString s, System::WideChar delimiter);
extern DELPHI_PACKAGE int __fastcall LMDWideScanToNumber(const System::WideString aValue);
extern DELPHI_PACKAGE bool __fastcall LMDWideRemoveEmptyLines(System::Classes::TStrings* list);
extern DELPHI_PACKAGE void __fastcall LMDWideParseToStrList(const System::WideString w, const System::WideChar delimiter, System::Classes::TStrings* list);
extern DELPHI_PACKAGE void __fastcall LMDWideGetDivider(System::Classes::TStrings* dest, const int aValue);
extern DELPHI_PACKAGE int __fastcall LMDWidePosEx(const System::WideString substr, const System::WideString s, int Index);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideReplaceStr(const System::WideString S, const System::WideString Srch, const System::WideString Replace);
extern DELPHI_PACKAGE bool __fastcall LMDWideWriteStringToStream(System::Classes::TStream* S, const System::WideString Str);
extern DELPHI_PACKAGE bool __fastcall LMDWideReadStringFromStream(System::Classes::TStream* S, System::WideString &Str);
extern DELPHI_PACKAGE int __fastcall LMDWideH2D(const System::WideString S);
extern DELPHI_PACKAGE int __fastcall LMDWideH2DDef(const System::WideString S, int Def);
extern DELPHI_PACKAGE bool __fastcall LMDWideStrStartsWith(System::WideChar * Source, System::WideChar * Seq);
extern DELPHI_PACKAGE bool __fastcall LMDWideContainsAt(const System::WideString Source, int Index, const System::WideString Seq);
extern DELPHI_PACKAGE int __fastcall LMDWideLastPos(const System::WideString SubStr, const System::WideString Strn);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideExtractStr(System::WideString &S, int SPos, int SLen);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideUpperCase(const System::WideString Str);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideLowerCase(const System::WideString Str);
extern DELPHI_PACKAGE int __fastcall LMDWideStringToStream(const System::WideString Str, System::Classes::TStream* Stream);
extern DELPHI_PACKAGE System::WideString __fastcall LMDWideStreamToString(System::Classes::TStream* Stream, int Size);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDAddCharL(const Lmdtypes::TLMDString aValue, int i, System::WideChar c);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDAddCharR(const Lmdtypes::TLMDString aValue, int i, System::WideChar c);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDAddSpaceL(const Lmdtypes::TLMDString aValue, int i);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDAddSpaceR(const Lmdtypes::TLMDString aValue, int i);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDAddZeroL(const Lmdtypes::TLMDString aValue, int i);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDAddZeroR(const Lmdtypes::TLMDString aValue, int i);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDCodeInt(const int *X, const int X_High, System::WideChar delimiter);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDCodeString(const Lmdtypes::TLMDString *X, const int X_High, System::WideChar delimiter);
extern DELPHI_PACKAGE int __fastcall LMDGetCodedCount(const Lmdtypes::TLMDString aValue, System::WideChar delimiter);
extern DELPHI_PACKAGE void __fastcall LMDSetCodedString(Lmdtypes::TLMDString &aValue, const Lmdtypes::TLMDString partStr, System::WideChar delimiter, int index);
extern DELPHI_PACKAGE int __fastcall LMDGetCodedInt(const Lmdtypes::TLMDString aValue, System::WideChar delimiter, int index);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDGetCodedString(const Lmdtypes::TLMDString aValue, System::WideChar delimiter, int index);
extern DELPHI_PACKAGE int __fastcall LMDCount(const Lmdtypes::TLMDString aValue, const System::WideChar search);
extern DELPHI_PACKAGE int __fastcall LMDBackPos(System::WideChar c, const Lmdtypes::TLMDString s);
extern DELPHI_PACKAGE bool __fastcall LMDEmpty(const Lmdtypes::TLMDString aValue);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDFillString(int i, System::WideChar w);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDCenterString(const Lmdtypes::TLMDString S, int Len);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDMakeSpace(int i);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDSlashRemove(const Lmdtypes::TLMDString aValue);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDSlashAdd(const Lmdtypes::TLMDString aValue);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDReplaceChar(const Lmdtypes::TLMDString aValue, System::WideChar toReplace, System::WideChar Replace);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDTrimL(const Lmdtypes::TLMDString aValue);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDTrimR(const Lmdtypes::TLMDString aValue);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDTrim(const Lmdtypes::TLMDString aValue);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDGetFirstString(const Lmdtypes::TLMDString aValue, System::WideChar delimiter);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDGetLastString(const Lmdtypes::TLMDString aValue, System::WideChar delimiter);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDGetSecondString(const Lmdtypes::TLMDString aValue, System::WideChar delimiter);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDGetRightTrimmedString(const Lmdtypes::TLMDString aValue, System::WideChar delimiter);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDAddDelimiter(Lmdtypes::TLMDString s, System::WideChar delimiter);
extern DELPHI_PACKAGE int __fastcall LMDScanToNumber(const Lmdtypes::TLMDString aValue);
extern DELPHI_PACKAGE void __fastcall LMDSetString(Lmdtypes::TLMDString &aValue, System::WideChar * buff, int len);
extern DELPHI_PACKAGE int __fastcall LMDStrLen(System::WideChar * AStr);
extern DELPHI_PACKAGE bool __fastcall LMDCheckWildCardMask(Lmdtypes::TLMDString aMask, Lmdtypes::TLMDString aStr);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDCharArrayToString(const Lmdtypes::TLMDCharArray Arr, int AStart, int ACount);
extern DELPHI_PACKAGE bool __fastcall LMDRemoveEmptyLines(System::Classes::TStrings* list);
extern DELPHI_PACKAGE void __fastcall LMDParseToStrList(const Lmdtypes::TLMDString w, const System::WideChar delimiter, System::Classes::TStrings* list);
extern DELPHI_PACKAGE void __fastcall LMDGetDivider(System::Classes::TStrings* dest, const int aValue);
extern DELPHI_PACKAGE int __fastcall LMDPosEx(const Lmdtypes::TLMDString substr, const Lmdtypes::TLMDString s, int Index);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDReplaceStr(const Lmdtypes::TLMDString S, const Lmdtypes::TLMDString Srch, const Lmdtypes::TLMDString Replace);
extern DELPHI_PACKAGE bool __fastcall LMDWriteStringToStream(System::Classes::TStream* S, const Lmdtypes::TLMDString Str);
extern DELPHI_PACKAGE bool __fastcall LMDReadStringFromStream(System::Classes::TStream* S, Lmdtypes::TLMDString &Str);
extern DELPHI_PACKAGE int __fastcall LMDH2D(const Lmdtypes::TLMDString S);
extern DELPHI_PACKAGE int __fastcall LMDH2DDef(const Lmdtypes::TLMDString S, int Def);
extern DELPHI_PACKAGE bool __fastcall LMDStrStartsWith(System::WideChar * Source, System::WideChar * Seq);
extern DELPHI_PACKAGE bool __fastcall LMDContainsAt(const Lmdtypes::TLMDString Source, int Index, const Lmdtypes::TLMDString Seq);
extern DELPHI_PACKAGE int __fastcall LMDLastPos(const Lmdtypes::TLMDString SubStr, const Lmdtypes::TLMDString Strn);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDExtractStr(Lmdtypes::TLMDString &S, int SPos, int SLen);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDUpperCase(const Lmdtypes::TLMDString Str);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDLowerCase(const Lmdtypes::TLMDString Str);
extern DELPHI_PACKAGE System::WideChar __fastcall LMDAnsiUpperCaseChar(System::WideChar C)/* overload */;
extern DELPHI_PACKAGE char __fastcall LMDAnsiUpperCaseChar(char C)/* overload */;
extern DELPHI_PACKAGE System::WideChar __fastcall LMDAnsiLowerCaseChar(System::WideChar C)/* overload */;
extern DELPHI_PACKAGE char __fastcall LMDAnsiLowerCaseChar(char C)/* overload */;
extern DELPHI_PACKAGE System::WideChar __fastcall LMDWideUpperCaseChar(System::WideChar C);
extern DELPHI_PACKAGE System::WideChar __fastcall LMDWideLowerCaseChar(System::WideChar C);
extern DELPHI_PACKAGE System::WideChar __fastcall LMDUpperCaseChar(System::WideChar C);
extern DELPHI_PACKAGE System::WideChar __fastcall LMDLowerCaseChar(System::WideChar C);
extern DELPHI_PACKAGE int __fastcall LMDStringToStream(const Lmdtypes::TLMDString Str, System::Classes::TStream* Stream);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDStreamToString(System::Classes::TStream* Stream, int Size);
extern DELPHI_PACKAGE bool __fastcall LMDSameText(const Lmdtypes::TLMDString S1, const Lmdtypes::TLMDString S2);
extern DELPHI_PACKAGE bool __fastcall LMDAnsiSameText(const System::UnicodeString Str1, const System::UnicodeString Str2)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiSameText(const System::AnsiString Str1, const System::AnsiString Str2)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDCompareStr(const Lmdtypes::TLMDString S1, const Lmdtypes::TLMDString S2);
extern DELPHI_PACKAGE int __fastcall LMDAnsiCompareStr(const System::UnicodeString S1, const System::UnicodeString S2)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDAnsiCompareStr(const System::AnsiString S1, const System::AnsiString S2)/* overload */;
extern DELPHI_PACKAGE int __fastcall LMDWideCompareStr(const System::WideString S1, const System::WideString S2);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDAnsiMakeString(int FLen, System::UnicodeString Seq)/* overload */;
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDAnsiMakeString(int FLen, System::AnsiString Seq)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiCharInSet(const System::WideChar AChar, const System::Sysutils::TSysCharSet &ASet)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDAnsiCharInSet(const char AChar, const System::Sysutils::TSysCharSet &ASet)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDWideCharInSet(const System::WideChar AChar, const System::Sysutils::TSysCharSet &ASet);
extern DELPHI_PACKAGE bool __fastcall LMDCharInSet(const System::WideChar AChar, const System::Sysutils::TSysCharSet &ASet);
extern DELPHI_PACKAGE System::Currency __fastcall LMDPrettyStrToCurr(const System::UnicodeString Value);
extern DELPHI_PACKAGE bool __fastcall LMDAnsiReplace(System::UnicodeString &Str, System::UnicodeString SourceString, System::UnicodeString DestString);
extern DELPHI_PACKAGE bool __fastcall LMDWideReplace(System::WideString &Str, const System::WideString SourceString, const System::WideString DestString);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDIntToStrFmt(int value);
}	/* namespace Lmdstrings */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTRINGS)
using namespace Lmdstrings;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstringsHPP
