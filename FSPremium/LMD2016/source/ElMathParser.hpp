// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElMathParser.pas' rev: 31.00 (Windows)

#ifndef ElmathparserHPP
#define ElmathparserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Math.hpp>
#include <LMDTypes.hpp>
#include <System.StrUtils.hpp>
#include <System.Variants.hpp>
#include <LMDElConst.hpp>
#include <LMDObjectList.hpp>
#include <LMDUnicodeStrings.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elmathparser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS EElMathException;
class DELPHICLASS TElArgument;
class DELPHICLASS TElIntegerArgument;
class DELPHICLASS TElFloatArgument;
class DELPHICLASS TElStringArgument;
class DELPHICLASS TElArgumentList;
class DELPHICLASS TElFunction;
class DELPHICLASS TElSinFunction;
class DELPHICLASS TElLogFunction;
class DELPHICLASS TElCosFunction;
class DELPHICLASS TElTanFunction;
class DELPHICLASS TElCotFunction;
class DELPHICLASS TElACosFunction;
class DELPHICLASS TElASinFunction;
class DELPHICLASS TElLnFunction;
class DELPHICLASS TElLog10Function;
class DELPHICLASS TElATanFunction;
class DELPHICLASS TElExpFunction;
class DELPHICLASS TElPowerFunction;
class DELPHICLASS TElSqrtFunction;
class DELPHICLASS TElFunctionList;
class DELPHICLASS TElMathFunctionList;
class DELPHICLASS TElFunctionListGroups;
class DELPHICLASS TElMathParser;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION EElMathException : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EElMathException(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EElMathException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EElMathException(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EElMathException(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EElMathException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EElMathException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EElMathException(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EElMathException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElMathException(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElMathException(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElMathException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElMathException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EElMathException(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TElMathParserErrorEvent)(System::TObject* Sender, System::UnicodeString AError);

enum DECLSPEC_DENUM TTokenType : unsigned char { DELIMITER, NUMBER, VARIABLE, COMMAND, CHARS, NONE };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElArgument : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FError;
	Lmdtypes::TLMDString FName;
	
public:
	__fastcall TElArgument(Lmdtypes::TLMDString AName);
	virtual void __fastcall AssignValue(const System::Variant &AValue) = 0 ;
	bool __fastcall IsValid(void);
	__property Lmdtypes::TLMDString Name = {read=FName};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElArgument(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElIntegerArgument : public TElArgument
{
	typedef TElArgument inherited;
	
protected:
	int FValue;
	
public:
	virtual void __fastcall AssignValue(const System::Variant &AValue);
	__property int Value = {read=FValue, nodefault};
public:
	/* TElArgument.Create */ inline __fastcall TElIntegerArgument(Lmdtypes::TLMDString AName) : TElArgument(AName) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElIntegerArgument(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElFloatArgument : public TElArgument
{
	typedef TElArgument inherited;
	
protected:
	System::Extended FValue;
	
public:
	virtual void __fastcall AssignValue(const System::Variant &AValue);
	__property System::Extended Value = {read=FValue};
public:
	/* TElArgument.Create */ inline __fastcall TElFloatArgument(Lmdtypes::TLMDString AName) : TElArgument(AName) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElFloatArgument(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElStringArgument : public TElArgument
{
	typedef TElArgument inherited;
	
protected:
	Lmdtypes::TLMDString FValue;
	
public:
	virtual void __fastcall AssignValue(const System::Variant &AValue);
	__property Lmdtypes::TLMDString Value = {read=FValue};
public:
	/* TElArgument.Create */ inline __fastcall TElStringArgument(Lmdtypes::TLMDString AName) : TElArgument(AName) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElStringArgument(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElArgumentList : public Lmdobjectlist::TLMDObjectList
{
	typedef Lmdobjectlist::TLMDObjectList inherited;
	
public:
	TElArgument* operator[](int Index) { return this->Arguments[Index]; }
	
private:
	TElArgument* __fastcall GetArg(int Index);
	void __fastcall PutArg(int Index, TElArgument* const Value);
	
public:
	__property TElArgument* Arguments[int Index] = {read=GetArg, write=PutArg/*, default*/};
public:
	/* TLMDObjectList.Create */ inline __fastcall TElArgumentList(void) : Lmdobjectlist::TLMDObjectList() { }
	/* TLMDObjectList.Destroy */ inline __fastcall virtual ~TElArgumentList(void) { }
	
};


class PASCALIMPLEMENTATION TElFunction : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
public:
	TElArgument* operator[](int Index) { return this->Arguments[Index]; }
	
protected:
	Lmdtypes::TLMDString FName;
	System::Variant FResult;
	TElArgumentList* FArgumentList;
	TElArgument* __fastcall Get(int Index);
	int __fastcall GetArgumentCount(void);
	
public:
	__fastcall TElFunction(void);
	__fastcall virtual ~TElFunction(void);
	virtual void __fastcall Execute(void) = 0 ;
	__property Lmdtypes::TLMDString Name = {read=FName};
	__property int ArgumentCount = {read=GetArgumentCount, nodefault};
	__property TElArgument* Arguments[int Index] = {read=Get/*, default*/};
	__property System::Variant Result = {read=FResult};
};


class PASCALIMPLEMENTATION TElSinFunction : public TElFunction
{
	typedef TElFunction inherited;
	
public:
	__fastcall TElSinFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TElFunction.Destroy */ inline __fastcall virtual ~TElSinFunction(void) { }
	
};


class PASCALIMPLEMENTATION TElLogFunction : public TElFunction
{
	typedef TElFunction inherited;
	
public:
	__fastcall TElLogFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TElFunction.Destroy */ inline __fastcall virtual ~TElLogFunction(void) { }
	
};


class PASCALIMPLEMENTATION TElCosFunction : public TElFunction
{
	typedef TElFunction inherited;
	
public:
	__fastcall TElCosFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TElFunction.Destroy */ inline __fastcall virtual ~TElCosFunction(void) { }
	
};


class PASCALIMPLEMENTATION TElTanFunction : public TElFunction
{
	typedef TElFunction inherited;
	
public:
	__fastcall TElTanFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TElFunction.Destroy */ inline __fastcall virtual ~TElTanFunction(void) { }
	
};


class PASCALIMPLEMENTATION TElCotFunction : public TElFunction
{
	typedef TElFunction inherited;
	
public:
	__fastcall TElCotFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TElFunction.Destroy */ inline __fastcall virtual ~TElCotFunction(void) { }
	
};


class PASCALIMPLEMENTATION TElACosFunction : public TElFunction
{
	typedef TElFunction inherited;
	
public:
	__fastcall TElACosFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TElFunction.Destroy */ inline __fastcall virtual ~TElACosFunction(void) { }
	
};


class PASCALIMPLEMENTATION TElASinFunction : public TElFunction
{
	typedef TElFunction inherited;
	
public:
	__fastcall TElASinFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TElFunction.Destroy */ inline __fastcall virtual ~TElASinFunction(void) { }
	
};


class PASCALIMPLEMENTATION TElLnFunction : public TElFunction
{
	typedef TElFunction inherited;
	
public:
	__fastcall TElLnFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TElFunction.Destroy */ inline __fastcall virtual ~TElLnFunction(void) { }
	
};


class PASCALIMPLEMENTATION TElLog10Function : public TElFunction
{
	typedef TElFunction inherited;
	
public:
	__fastcall TElLog10Function(void);
	virtual void __fastcall Execute(void);
public:
	/* TElFunction.Destroy */ inline __fastcall virtual ~TElLog10Function(void) { }
	
};


class PASCALIMPLEMENTATION TElATanFunction : public TElFunction
{
	typedef TElFunction inherited;
	
public:
	__fastcall TElATanFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TElFunction.Destroy */ inline __fastcall virtual ~TElATanFunction(void) { }
	
};


class PASCALIMPLEMENTATION TElExpFunction : public TElFunction
{
	typedef TElFunction inherited;
	
public:
	__fastcall TElExpFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TElFunction.Destroy */ inline __fastcall virtual ~TElExpFunction(void) { }
	
};


class PASCALIMPLEMENTATION TElPowerFunction : public TElFunction
{
	typedef TElFunction inherited;
	
public:
	__fastcall TElPowerFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TElFunction.Destroy */ inline __fastcall virtual ~TElPowerFunction(void) { }
	
};


class PASCALIMPLEMENTATION TElSqrtFunction : public TElFunction
{
	typedef TElFunction inherited;
	
public:
	__fastcall TElSqrtFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TElFunction.Destroy */ inline __fastcall virtual ~TElSqrtFunction(void) { }
	
};


class PASCALIMPLEMENTATION TElFunctionList : public Lmdobjectlist::TLMDObjectList
{
	typedef Lmdobjectlist::TLMDObjectList inherited;
	
public:
	TElFunction* operator[](int Index) { return this->Functions[Index]; }
	
private:
	Lmdtypes::TLMDString FCaption;
	
protected:
	TElFunction* __fastcall GetFunction(int Index);
	void __fastcall PutFunction(int Index, TElFunction* const Value);
	
public:
	TElFunction* __fastcall LookUpFunction(Lmdtypes::TLMDString AName);
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=FCaption};
	__property TElFunction* Functions[int Index] = {read=GetFunction, write=PutFunction/*, default*/};
public:
	/* TLMDObjectList.Create */ inline __fastcall TElFunctionList(void) : Lmdobjectlist::TLMDObjectList() { }
	/* TLMDObjectList.Destroy */ inline __fastcall virtual ~TElFunctionList(void) { }
	
};


class PASCALIMPLEMENTATION TElMathFunctionList : public TElFunctionList
{
	typedef TElFunctionList inherited;
	
public:
	__fastcall TElMathFunctionList(void);
public:
	/* TLMDObjectList.Destroy */ inline __fastcall virtual ~TElMathFunctionList(void) { }
	
};


class PASCALIMPLEMENTATION TElFunctionListGroups : public Lmdobjectlist::TLMDObjectList
{
	typedef Lmdobjectlist::TLMDObjectList inherited;
	
public:
	TElFunctionList* operator[](int Index) { return this->FunctionLists[Index]; }
	
private:
	TElFunctionList* __fastcall GetList(int Index);
	void __fastcall PutList(int Index, TElFunctionList* const Value);
	
public:
	TElFunction* __fastcall LookUpFunction(Lmdtypes::TLMDString AName);
	__property TElFunctionList* FunctionLists[int Index] = {read=GetList, write=PutList/*, default*/};
public:
	/* TLMDObjectList.Create */ inline __fastcall TElFunctionListGroups(void) : Lmdobjectlist::TLMDObjectList() { }
	/* TLMDObjectList.Destroy */ inline __fastcall virtual ~TElFunctionListGroups(void) { }
	
};


class PASCALIMPLEMENTATION TElMathParser : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	void __fastcall SetExpr(const Lmdtypes::TLMDString Value);
	
protected:
	TElFunction* FCommand;
	Lmdtypes::TLMDString FExpr;
	int Prog;
	Lmdtypes::TLMDString Token;
	TTokenType TokType;
	System::Classes::TStrings* FVariables;
	TElFunctionListGroups* FFunctionListGroups;
	Lmdtypes::TLMDString FArgumentDelimiters;
	TElMathParserErrorEvent FOnParseError;
	System::Extended __fastcall EvalExp(void);
	bool __fastcall IsAlpha(System::WideChar c);
	bool __fastcall IsDelimiter(System::WideChar c);
	bool __fastcall IsDigit(System::WideChar c);
	bool __fastcall IsSpace(System::WideChar c);
	bool __fastcall IsQuote(System::WideChar c);
	System::Variant __fastcall GetResult(void);
	TElFunction* __fastcall LookUp(System::UnicodeString S);
	void __fastcall Atom(System::Extended &Res);
	void __fastcall EvalExp2(System::Extended &Res);
	void __fastcall EvalExp3(System::Extended &Res);
	void __fastcall EvalExp4(System::Extended &Res);
	void __fastcall EvalExp5(System::Extended &Res);
	void __fastcall EvalExp6(System::Extended &Res);
	void __fastcall GetToken(void);
	void __fastcall PutBack(void);
	void __fastcall SError(System::Byte Num);
	void __fastcall SetVariables(System::Classes::TStrings* const Value);
	
public:
	__fastcall TElMathParser(void)/* overload */;
	__fastcall TElMathParser(const System::UnicodeString AExpr)/* overload */;
	__fastcall virtual ~TElMathParser(void);
	__property Lmdtypes::TLMDString Expression = {read=FExpr, write=SetExpr};
	__property System::Variant Result = {read=GetResult};
	__property TElFunctionListGroups* FunctionListGroups = {read=FFunctionListGroups, write=FFunctionListGroups};
	__property System::Classes::TStrings* Variables = {read=FVariables, write=SetVariables};
	__property Lmdtypes::TLMDString ArgumentDelimiters = {read=FArgumentDelimiters, write=FArgumentDelimiters};
	__property TElMathParserErrorEvent OnParseError = {read=FOnParseError, write=FOnParseError};
};


//-- var, const, procedure ---------------------------------------------------
static const System::WideChar CArgumentDelimiters = (System::WideChar)(0x3b);
}	/* namespace Elmathparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELMATHPARSER)
using namespace Elmathparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElmathparserHPP
