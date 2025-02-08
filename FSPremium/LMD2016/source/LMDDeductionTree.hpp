// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDeductionTree.pas' rev: 31.00 (Windows)

#ifndef LmddeductiontreeHPP
#define LmddeductiontreeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDListObjects.hpp>
#include <LMDText.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddeductiontree
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDeductionTree;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDeductionTree : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDDeductionTree* operator[](int index) { return this->Item[index]; }
	
private:
	int FStartPos;
	TLMDDeductionTree* FParent;
	Lmdlistobjects::TLMDListObjects* FList;
	Lmdtext::TLMDParsedTextList* FParsedText;
	void *FEntry;
	TLMDDeductionTree* __fastcall GetItem(int index);
	
public:
	__fastcall TLMDDeductionTree(TLMDDeductionTree* aParent);
	__fastcall virtual ~TLMDDeductionTree(void);
	TLMDDeductionTree* __fastcall AddSubItem(void);
	int __fastcall Count(void);
	void __fastcall ClearParsedText(void);
	void __fastcall Clear(void);
	void __fastcall Chop(void);
	void __fastcall RollBack(void);
	__property int StartPos = {read=FStartPos, write=FStartPos, nodefault};
	__property Lmdtext::TLMDParsedTextList* ParsedText = {read=FParsedText, write=FParsedText};
	__property void * EntryPoint = {read=FEntry, write=FEntry};
	__property TLMDDeductionTree* Item[int index] = {read=GetItem/*, default*/};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddeductiontree */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDEDUCTIONTREE)
using namespace Lmddeductiontree;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddeductiontreeHPP
