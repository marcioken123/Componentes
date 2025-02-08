// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElExpressionEval.pas' rev: 31.00 (Windows)

#ifndef ElexpressionevalHPP
#define ElexpressionevalHPP

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
#include <LMDTypes.hpp>
#include <LMDUnicodeStrings.hpp>
#include <ElComponent.hpp>
#include <ElMathParser.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elexpressioneval
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElExpressionEval;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElExpressionEval : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	Elmathparser::TElMathParser* FMathParser;
	Lmdtypes::TLMDString __fastcall GetExpr(void);
	Lmdtypes::TLMDString __fastcall GetArgumentDelimiters(void);
	Elmathparser::TElFunctionListGroups* __fastcall GetFunctionListGroups(void);
	Elmathparser::TElMathParserErrorEvent __fastcall GetOnParseError(void);
	System::Variant __fastcall GetResult(void);
	System::Classes::TStrings* __fastcall GetVars(void);
	void __fastcall SetExpr(const Lmdtypes::TLMDString Value);
	void __fastcall SetArgumentDelimiters(const Lmdtypes::TLMDString Value);
	void __fastcall SetFunctionListGroups(Elmathparser::TElFunctionListGroups* const Value);
	void __fastcall SetOnParseError(const Elmathparser::TElMathParserErrorEvent Value);
	void __fastcall SetVars(System::Classes::TStrings* const Value);
	
public:
	__fastcall virtual TElExpressionEval(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElExpressionEval(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property Elmathparser::TElFunctionListGroups* FunctionListGroups = {read=GetFunctionListGroups, write=SetFunctionListGroups};
	__property System::Variant Result = {read=GetResult};
	
__published:
	__property Lmdtypes::TLMDString Expression = {read=GetExpr, write=SetExpr};
	__property System::Classes::TStrings* Variables = {read=GetVars, write=SetVars};
	__property Lmdtypes::TLMDString ArgumentDelimiters = {read=GetArgumentDelimiters, write=SetArgumentDelimiters};
	__property Elmathparser::TElMathParserErrorEvent OnParseError = {read=GetOnParseError, write=SetOnParseError};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elexpressioneval */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELEXPRESSIONEVAL)
using namespace Elexpressioneval;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElexpressionevalHPP
