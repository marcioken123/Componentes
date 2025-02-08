// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDExpressionEval.pas' rev: 31.00 (Windows)

#ifndef LmdexpressionevalHPP
#define LmdexpressionevalHPP

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
#include <System.Variants.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDUnicode.hpp>
#include <LMDMathParser.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdexpressioneval
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDExpressionEval;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDExpressionEval : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	Lmdmathparser::TLMDMathParser* FMathParser;
	Lmdtypes::TLMDString __fastcall GetExpr(void);
	Lmdtypes::TLMDString __fastcall GetArgumentDelimiters(void);
	Lmdmathparser::TLMDFunctionListGroups* __fastcall GetFunctionListGroups(void);
	Lmdmathparser::TLMDMathErrorEvent __fastcall GetOnParseError(void);
	System::Variant __fastcall GetResult(void);
	System::Classes::TStrings* __fastcall GetVars(void);
	void __fastcall SetExpr(const Lmdtypes::TLMDString Value);
	void __fastcall SetArgumentDelimiters(const Lmdtypes::TLMDString Value);
	void __fastcall SetFunctionListGroups(Lmdmathparser::TLMDFunctionListGroups* const Value);
	void __fastcall SetOnParseError(const Lmdmathparser::TLMDMathErrorEvent Value);
	void __fastcall SetVars(System::Classes::TStrings* const Value);
	
public:
	__fastcall virtual TLMDExpressionEval(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDExpressionEval(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property Lmdmathparser::TLMDFunctionListGroups* FunctionListGroups = {read=GetFunctionListGroups, write=SetFunctionListGroups};
	__property System::Variant Result = {read=GetResult};
	
__published:
	__property About = {default=0};
	__property Lmdtypes::TLMDString Expression = {read=GetExpr, write=SetExpr};
	__property System::Classes::TStrings* Variables = {read=GetVars, write=SetVars};
	__property Lmdtypes::TLMDString ArgumentDelimiters = {read=GetArgumentDelimiters, write=SetArgumentDelimiters};
	__property Lmdmathparser::TLMDMathErrorEvent OnParseError = {read=GetOnParseError, write=SetOnParseError};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdexpressioneval */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDEXPRESSIONEVAL)
using namespace Lmdexpressioneval;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdexpressionevalHPP
