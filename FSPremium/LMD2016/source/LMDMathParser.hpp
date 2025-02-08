// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDMathParser.pas' rev: 31.00 (Windows)

#ifndef LmdmathparserHPP
#define LmdmathparserHPP

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
#include <System.Variants.hpp>
#include <LMDList.hpp>
#include <LMDUnicode.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdmathparser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDMathException;
class DELPHICLASS TLMDArgument;
class DELPHICLASS TLMDIntegerArgument;
class DELPHICLASS TLMDFloatArgument;
class DELPHICLASS TLMDStringArgument;
class DELPHICLASS TLMDArgumentList;
class DELPHICLASS TLMDFunction;
class DELPHICLASS TLMDSinFunction;
class DELPHICLASS TLMDLogFunction;
class DELPHICLASS TLMDCosFunction;
class DELPHICLASS TLMDTanFunction;
class DELPHICLASS TLMDCotFunction;
class DELPHICLASS TLMDACosFunction;
class DELPHICLASS TLMDASinFunction;
class DELPHICLASS TLMDLnFunction;
class DELPHICLASS TLMDLog10Function;
class DELPHICLASS TLMDATanFunction;
class DELPHICLASS TLMDExpFunction;
class DELPHICLASS TLMDPowerFunction;
class DELPHICLASS TLMDSqrtFunction;
class DELPHICLASS TLMDFunctionList;
class DELPHICLASS TLMDMathFunctionList;
class DELPHICLASS TLMDFunctionListGroups;
class DELPHICLASS TLMDMathParser;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDMathException : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDMathException(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDMathException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDMathException(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDMathException(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDMathException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDMathException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDMathException(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDMathException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDMathException(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDMathException(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDMathException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDMathException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDMathException(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDMathErrorEvent)(System::TObject* Sender, System::UnicodeString AError);

enum DECLSPEC_DENUM TTokenType : unsigned char { DELIMITER, NUMBER, VARIABLE, COMMAND, CHARS, NONE };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDArgument : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FError;
	Lmdtypes::TLMDString FName;
	
public:
	__fastcall TLMDArgument(Lmdtypes::TLMDString AName);
	virtual void __fastcall AssignValue(const System::Variant &AValue) = 0 ;
	bool __fastcall IsValid(void);
	__property Lmdtypes::TLMDString Name = {read=FName};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDArgument(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIntegerArgument : public TLMDArgument
{
	typedef TLMDArgument inherited;
	
protected:
	int FValue;
	
public:
	virtual void __fastcall AssignValue(const System::Variant &AValue);
	__property int Value = {read=FValue, nodefault};
public:
	/* TLMDArgument.Create */ inline __fastcall TLMDIntegerArgument(Lmdtypes::TLMDString AName) : TLMDArgument(AName) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDIntegerArgument(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDFloatArgument : public TLMDArgument
{
	typedef TLMDArgument inherited;
	
protected:
	System::Extended FValue;
	
public:
	virtual void __fastcall AssignValue(const System::Variant &AValue);
	__property System::Extended Value = {read=FValue};
public:
	/* TLMDArgument.Create */ inline __fastcall TLMDFloatArgument(Lmdtypes::TLMDString AName) : TLMDArgument(AName) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDFloatArgument(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStringArgument : public TLMDArgument
{
	typedef TLMDArgument inherited;
	
protected:
	Lmdtypes::TLMDString FValue;
	
public:
	virtual void __fastcall AssignValue(const System::Variant &AValue);
	__property Lmdtypes::TLMDString Value = {read=FValue};
public:
	/* TLMDArgument.Create */ inline __fastcall TLMDStringArgument(Lmdtypes::TLMDString AName) : TLMDArgument(AName) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDStringArgument(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDArgumentList : public System::Classes::TList
{
	typedef System::Classes::TList inherited;
	
public:
	TLMDArgument* operator[](int Index) { return this->Arguments[Index]; }
	
private:
	TLMDArgument* __fastcall GetArg(int Index);
	void __fastcall PutArg(int Index, TLMDArgument* const Value);
	
protected:
	virtual void __fastcall Notify(void * Ptr, System::Classes::TListNotification Action);
	
public:
	__property TLMDArgument* Arguments[int Index] = {read=GetArg, write=PutArg/*, default*/};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TLMDArgumentList(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TLMDArgumentList(void) : System::Classes::TList() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDFunction : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
public:
	TLMDArgument* operator[](int Index) { return this->Arguments[Index]; }
	
protected:
	Lmdtypes::TLMDString FName;
	System::Variant FResult;
	TLMDArgumentList* FArgumentList;
	TLMDArgument* __fastcall Get(int Index);
	int __fastcall GetArgumentCount(void);
	
public:
	__fastcall TLMDFunction(void);
	__fastcall virtual ~TLMDFunction(void);
	virtual void __fastcall Execute(void) = 0 ;
	__property Lmdtypes::TLMDString Name = {read=FName};
	__property int ArgumentCount = {read=GetArgumentCount, nodefault};
	__property TLMDArgument* Arguments[int Index] = {read=Get/*, default*/};
	__property System::Variant Result = {read=FResult};
};


class PASCALIMPLEMENTATION TLMDSinFunction : public TLMDFunction
{
	typedef TLMDFunction inherited;
	
public:
	__fastcall TLMDSinFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TLMDFunction.Destroy */ inline __fastcall virtual ~TLMDSinFunction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDLogFunction : public TLMDFunction
{
	typedef TLMDFunction inherited;
	
public:
	__fastcall TLMDLogFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TLMDFunction.Destroy */ inline __fastcall virtual ~TLMDLogFunction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDCosFunction : public TLMDFunction
{
	typedef TLMDFunction inherited;
	
public:
	__fastcall TLMDCosFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TLMDFunction.Destroy */ inline __fastcall virtual ~TLMDCosFunction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDTanFunction : public TLMDFunction
{
	typedef TLMDFunction inherited;
	
public:
	__fastcall TLMDTanFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TLMDFunction.Destroy */ inline __fastcall virtual ~TLMDTanFunction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDCotFunction : public TLMDFunction
{
	typedef TLMDFunction inherited;
	
public:
	__fastcall TLMDCotFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TLMDFunction.Destroy */ inline __fastcall virtual ~TLMDCotFunction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDACosFunction : public TLMDFunction
{
	typedef TLMDFunction inherited;
	
public:
	__fastcall TLMDACosFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TLMDFunction.Destroy */ inline __fastcall virtual ~TLMDACosFunction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDASinFunction : public TLMDFunction
{
	typedef TLMDFunction inherited;
	
public:
	__fastcall TLMDASinFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TLMDFunction.Destroy */ inline __fastcall virtual ~TLMDASinFunction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDLnFunction : public TLMDFunction
{
	typedef TLMDFunction inherited;
	
public:
	__fastcall TLMDLnFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TLMDFunction.Destroy */ inline __fastcall virtual ~TLMDLnFunction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDLog10Function : public TLMDFunction
{
	typedef TLMDFunction inherited;
	
public:
	__fastcall TLMDLog10Function(void);
	virtual void __fastcall Execute(void);
public:
	/* TLMDFunction.Destroy */ inline __fastcall virtual ~TLMDLog10Function(void) { }
	
};


class PASCALIMPLEMENTATION TLMDATanFunction : public TLMDFunction
{
	typedef TLMDFunction inherited;
	
public:
	__fastcall TLMDATanFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TLMDFunction.Destroy */ inline __fastcall virtual ~TLMDATanFunction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDExpFunction : public TLMDFunction
{
	typedef TLMDFunction inherited;
	
public:
	__fastcall TLMDExpFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TLMDFunction.Destroy */ inline __fastcall virtual ~TLMDExpFunction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDPowerFunction : public TLMDFunction
{
	typedef TLMDFunction inherited;
	
public:
	__fastcall TLMDPowerFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TLMDFunction.Destroy */ inline __fastcall virtual ~TLMDPowerFunction(void) { }
	
};


class PASCALIMPLEMENTATION TLMDSqrtFunction : public TLMDFunction
{
	typedef TLMDFunction inherited;
	
public:
	__fastcall TLMDSqrtFunction(void);
	virtual void __fastcall Execute(void);
public:
	/* TLMDFunction.Destroy */ inline __fastcall virtual ~TLMDSqrtFunction(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFunctionList : public System::Classes::TList
{
	typedef System::Classes::TList inherited;
	
public:
	TLMDFunction* operator[](int Index) { return this->Functions[Index]; }
	
private:
	Lmdtypes::TLMDString FCaption;
	
protected:
	TLMDFunction* __fastcall GetFunction(int Index);
	void __fastcall PutFunction(int Index, TLMDFunction* const Value);
	virtual void __fastcall Notify(void * Ptr, System::Classes::TListNotification Action);
	
public:
	TLMDFunction* __fastcall LookUpFunction(Lmdtypes::TLMDString AName);
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=FCaption};
	__property TLMDFunction* Functions[int Index] = {read=GetFunction, write=PutFunction/*, default*/};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TLMDFunctionList(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TLMDFunctionList(void) : System::Classes::TList() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMathFunctionList : public TLMDFunctionList
{
	typedef TLMDFunctionList inherited;
	
public:
	__fastcall TLMDMathFunctionList(void);
public:
	/* TList.Destroy */ inline __fastcall virtual ~TLMDMathFunctionList(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFunctionListGroups : public System::Classes::TList
{
	typedef System::Classes::TList inherited;
	
public:
	TLMDFunctionList* operator[](int Index) { return this->FunctionLists[Index]; }
	
private:
	TLMDFunctionList* __fastcall GetList(int Index);
	void __fastcall PutList(int Index, TLMDFunctionList* const Value);
	
protected:
	virtual void __fastcall Notify(void * Ptr, System::Classes::TListNotification Action);
	
public:
	TLMDFunction* __fastcall LookUpFunction(Lmdtypes::TLMDString AName);
	__property TLMDFunctionList* FunctionLists[int Index] = {read=GetList, write=PutList/*, default*/};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TLMDFunctionListGroups(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TLMDFunctionListGroups(void) : System::Classes::TList() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDMathParser : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	void __fastcall SetExpr(const Lmdtypes::TLMDString Value);
	
protected:
	TLMDFunction* FCommand;
	Lmdtypes::TLMDString FExpr;
	int Prog;
	Lmdtypes::TLMDString Token;
	TTokenType TokType;
	System::Classes::TStrings* FVariables;
	TLMDFunctionListGroups* FFunctionListGroups;
	Lmdtypes::TLMDString FArgumentDelimiters;
	TLMDMathErrorEvent FOnParseError;
	System::Extended __fastcall EvalExp(void);
	bool __fastcall IsAlpha(System::WideChar c);
	bool __fastcall IsDelimiter(System::WideChar c);
	bool __fastcall IsDigit(System::WideChar c);
	bool __fastcall IsSpace(System::WideChar c);
	bool __fastcall IsQuote(System::WideChar c);
	System::Variant __fastcall GetResult(void);
	TLMDFunction* __fastcall LookUp(System::UnicodeString S);
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
	__fastcall TLMDMathParser(void)/* overload */;
	__fastcall TLMDMathParser(const System::UnicodeString AExpr)/* overload */;
	__fastcall virtual ~TLMDMathParser(void);
	__property Lmdtypes::TLMDString Expression = {read=FExpr, write=SetExpr};
	__property System::Variant Result = {read=GetResult};
	__property TLMDFunctionListGroups* FunctionListGroups = {read=FFunctionListGroups, write=FFunctionListGroups};
	__property System::Classes::TStrings* Variables = {read=FVariables, write=SetVariables};
	__property Lmdtypes::TLMDString ArgumentDelimiters = {read=FArgumentDelimiters, write=FArgumentDelimiters};
	__property TLMDMathErrorEvent OnParseError = {read=FOnParseError, write=FOnParseError};
};


//-- var, const, procedure ---------------------------------------------------
#define CArgumentDelimiters L",;"
}	/* namespace Lmdmathparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDMATHPARSER)
using namespace Lmdmathparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdmathparserHPP
