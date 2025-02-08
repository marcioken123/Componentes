// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDParserStack.pas' rev: 31.00 (Windows)

#ifndef LmdparserstackHPP
#define LmdparserstackHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdparserstack
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStringStack;
class DELPHICLASS TLMDIntegerStack;
class DELPHICLASS TLMDFontStyleStack;
class DELPHICLASS TLMDPointerStack;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStringStack : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStringList* FList;
	
public:
	__fastcall TLMDStringStack(void);
	__fastcall virtual ~TLMDStringStack(void);
	void __fastcall Clear(void);
	void __fastcall Push(const System::UnicodeString aValue);
	void __fastcall Pop(void);
	System::UnicodeString __fastcall Top(void);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIntegerStack : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TList* FList;
	
public:
	__fastcall TLMDIntegerStack(void);
	__fastcall virtual ~TLMDIntegerStack(void);
	void __fastcall Clear(void);
	void __fastcall Push(int aValue);
	void __fastcall Pop(void);
	int __fastcall Top(void);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFontStyleStack : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TList* FList;
	
public:
	__fastcall TLMDFontStyleStack(void);
	__fastcall virtual ~TLMDFontStyleStack(void);
	void __fastcall Clear(void);
	void __fastcall Push(System::Uitypes::TFontStyles aValue);
	void __fastcall Pop(void);
	System::Uitypes::TFontStyles __fastcall Top(void);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPointerStack : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TList* FList;
	
public:
	__fastcall TLMDPointerStack(void);
	__fastcall virtual ~TLMDPointerStack(void);
	void __fastcall Clear(void);
	void * __fastcall Top(void);
	void __fastcall Push(void * aValue);
	void __fastcall Pop(void);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdparserstack */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPARSERSTACK)
using namespace Lmdparserstack;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdparserstackHPP
