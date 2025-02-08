// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRefineUnit.pas' rev: 31.00 (Windows)

#ifndef LmdrefineunitHPP
#define LmdrefineunitHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <LMDYParser.hpp>
#include <LMDBaseRefine.hpp>
#include <LMDSearchBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrefineunit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRefine;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRefine : public Lmdsearchbase::TLMDSearchBaseDlgComponent
{
	typedef Lmdsearchbase::TLMDSearchBaseDlgComponent inherited;
	
private:
	Lmdyparser::TSegment* FCode;
	System::Classes::TStringList* FErrors;
	int FNearestLength;
	int FLastParseTime;
	int FLastSearchTime;
	bool FMatchCase;
	bool FWholeWordsOnly;
	Lmdsearchbase::TLMDSearchTemplate FTemplate;
	void __fastcall SetNearestLength(const int Value);
	void __fastcall SetMatchCase(const bool Value);
	void __fastcall SetWholeWordsOnly(const bool Value);
	HIDESBASE void __fastcall SetTemplate(const Lmdsearchbase::TLMDSearchTemplate Value);
	
public:
	__fastcall virtual TLMDRefine(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDRefine(void);
	bool __fastcall ShowDialog(Vcl::Forms::TCustomForm* AOwner = (Vcl::Forms::TCustomForm*)(0x0), int X = 0xffffffff, int Y = 0xffffffff);
	bool __fastcall ParseTemplate(System::UnicodeString szTemplate);
	bool __fastcall SearchTemplate(System::UnicodeString szText);
	bool __fastcall SearchTemplateEx(System::UnicodeString szText, Lmdbaserefine::TLMDRefineDetail &Detail);
	bool __fastcall SearchTemplateInStream(System::Classes::TStream* Stream, Lmdbaserefine::TLMDRefineDetail &Detail);
	__property System::Classes::TStringList* Errors = {read=FErrors};
	__property Lmdyparser::TSegment* Code = {read=FCode};
	__property int LastParseTime = {read=FLastParseTime, nodefault};
	__property int LastSearchTime = {read=FLastSearchTime, nodefault};
	
__published:
	__property int NearestLength = {read=FNearestLength, write=SetNearestLength, default=50};
	__property bool MatchCase = {read=FMatchCase, write=SetMatchCase, default=0};
	__property bool WholeWordsOnly = {read=FWholeWordsOnly, write=SetWholeWordsOnly, default=0};
	__property Lmdsearchbase::TLMDSearchTemplate Template = {read=FTemplate, write=SetTemplate};
	__property DlgBuilderOptions = {default=339};
	__property OnDlgCustomize;
	__property OnDlgHelpClick;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrefineunit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDREFINEUNIT)
using namespace Lmdrefineunit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrefineunitHPP
