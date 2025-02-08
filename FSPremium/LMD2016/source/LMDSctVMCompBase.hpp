// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctVMCompBase.pas' rev: 31.00 (Windows)

#ifndef LmdsctvmcompbaseHPP
#define LmdsctvmcompbaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <System.Variants.hpp>
#include <System.SysUtils.hpp>
#include <System.SyncObjs.hpp>
#include <Winapi.ActiveX.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDSctClass.hpp>
#include <LMDSctVMByteCode.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctvmcompbase
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDCompileBase;
class DELPHICLASS TLMDVMBase;
class DELPHICLASS TLMDGlobalObject;
class DELPHICLASS TLMDDispIdObject;
class DELPHICLASS TLMDGlobalValuedObject;
class DELPHICLASS TLMDVarObject;
class DELPHICLASS TLMDConstObject;
class DELPHICLASS TLMDProcObject;
class DELPHICLASS TLMDExitObject;
class DELPHICLASS TLMDBreakObject;
class DELPHICLASS TLMDContinueObject;
class DELPHICLASS TIntrinsic;
class DELPHICLASS TLMDExternObject;
class DELPHICLASS TLMDNameTable;
class DELPHICLASS ILMDEmitable;
class DELPHICLASS ILMDParserCallbacks;
class DELPHICLASS ILMDParserBase;
__interface ILMDLanguage;
typedef System::DelphiInterface<ILMDLanguage> _di_ILMDLanguage;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDCompileBase : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
private:
	int FSourcePos;
	
public:
	__fastcall ELMDCompileBase(const System::WideString Msg, int ASourcePos);
	__fastcall ELMDCompileBase(const System::WideString Msg, const System::TVarRec *Args, const int Args_High, int ASourcePos);
	__property int SourcePos = {read=FSourcePos, write=FSourcePos, nodefault};
public:
	/* Exception.CreateRes */ inline __fastcall ELMDCompileBase(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDCompileBase(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDCompileBase(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDCompileBase(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDCompileBase(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDCompileBase(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDCompileBase(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDCompileBase(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDCompileBase(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDCompileBase(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDCompileBase(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVMBase : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall MakeEventHandler(const System::WideString AProcName, System::OleVariant &AResult) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TLMDVMBase(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDVMBase(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDGlobalObjType : unsigned char { gtVar, gtConst, gtProcedure, gtExit, gtBreak, gtContinue, gtIntrinsic, gtExtern };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGlobalObject : public Lmdsctclass::TLMDNamedItem
{
	typedef Lmdsctclass::TLMDNamedItem inherited;
	
private:
	TLMDGlobalObjType FGlobalObjType;
	System::WideString FStrName;
	
protected:
	virtual TLMDGlobalObjType __fastcall GetGlobalObjType(void) = 0 ;
	
public:
	__fastcall TLMDGlobalObject(const int AName, const System::WideString AStrName);
	__property TLMDGlobalObjType GlobalObjType = {read=FGlobalObjType, nodefault};
	__property System::WideString StrName = {read=FStrName};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDGlobalObject(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDispIdObject : public TLMDGlobalObject
{
	typedef TLMDGlobalObject inherited;
	
private:
	int FDispId;
	unsigned FInvokeFlags;
	unsigned FResMask;
	
public:
	__property int DispId = {read=FDispId, write=FDispId, nodefault};
	__property unsigned InvokeFlags = {read=FInvokeFlags, nodefault};
	__property unsigned ResMask = {read=FResMask, write=FResMask, nodefault};
public:
	/* TLMDGlobalObject.Create */ inline __fastcall TLMDDispIdObject(const int AName, const System::WideString AStrName) : TLMDGlobalObject(AName, AStrName) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDDispIdObject(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDGlobalValuedObject : public TLMDDispIdObject
{
	typedef TLMDDispIdObject inherited;
	
public:
	System::OleVariant Value;
public:
	/* TLMDGlobalObject.Create */ inline __fastcall TLMDGlobalValuedObject(const int AName, const System::WideString AStrName) : TLMDDispIdObject(AName, AStrName) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDGlobalValuedObject(void) { }
	
};


class PASCALIMPLEMENTATION TLMDVarObject : public TLMDGlobalValuedObject
{
	typedef TLMDGlobalValuedObject inherited;
	
public:
	__fastcall TLMDVarObject(const int AName, const System::WideString AStrName);
	virtual TLMDGlobalObjType __fastcall GetGlobalObjType(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDVarObject(void) { }
	
};


class PASCALIMPLEMENTATION TLMDConstObject : public TLMDGlobalValuedObject
{
	typedef TLMDGlobalValuedObject inherited;
	
public:
	__fastcall TLMDConstObject(const int AName, const System::WideString AStrName);
	virtual TLMDGlobalObjType __fastcall GetGlobalObjType(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDConstObject(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDProcObject : public TLMDDispIdObject
{
	typedef TLMDDispIdObject inherited;
	
private:
	Lmdsctvmbytecode::TLMDByteCode* FByteCode;
	int FParamCount;
	
protected:
	void __fastcall ParamAdded(void);
	
public:
	__fastcall TLMDProcObject(const int AName, const System::WideString AStrName);
	__fastcall virtual ~TLMDProcObject(void);
	virtual TLMDGlobalObjType __fastcall GetGlobalObjType(void);
	virtual void __fastcall EmitByteCode(Lmdsctvmbytecode::TLMDAbstractNamespace* AGlobalNamespace) = 0 ;
	__property int ParamCount = {read=FParamCount, nodefault};
	__property Lmdsctvmbytecode::TLMDByteCode* ByteCode = {read=FByteCode};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDExitObject : public TLMDGlobalObject
{
	typedef TLMDGlobalObject inherited;
	
public:
	virtual TLMDGlobalObjType __fastcall GetGlobalObjType(void);
public:
	/* TLMDGlobalObject.Create */ inline __fastcall TLMDExitObject(const int AName, const System::WideString AStrName) : TLMDGlobalObject(AName, AStrName) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDExitObject(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBreakObject : public TLMDGlobalObject
{
	typedef TLMDGlobalObject inherited;
	
public:
	virtual TLMDGlobalObjType __fastcall GetGlobalObjType(void);
public:
	/* TLMDGlobalObject.Create */ inline __fastcall TLMDBreakObject(const int AName, const System::WideString AStrName) : TLMDGlobalObject(AName, AStrName) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDBreakObject(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDContinueObject : public TLMDGlobalObject
{
	typedef TLMDGlobalObject inherited;
	
public:
	virtual TLMDGlobalObjType __fastcall GetGlobalObjType(void);
public:
	/* TLMDGlobalObject.Create */ inline __fastcall TLMDContinueObject(const int AName, const System::WideString AStrName) : TLMDGlobalObject(AName, AStrName) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDContinueObject(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TIntrinsic : public TLMDGlobalObject
{
	typedef TLMDGlobalObject inherited;
	
public:
	virtual TLMDGlobalObjType __fastcall GetGlobalObjType(void);
	virtual void __fastcall Execute(TLMDVMBase* AVM, Lmdsctvmbytecode::TLMDCall* ACall, Lmdsctclass::PLMDVarArray AArgs, System::OleVariant &AResult) = 0 ;
public:
	/* TLMDGlobalObject.Create */ inline __fastcall TIntrinsic(const int AName, const System::WideString AStrName) : TLMDGlobalObject(AName, AStrName) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TIntrinsic(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDExternObject : public TLMDGlobalObject
{
	typedef TLMDGlobalObject inherited;
	
private:
	_di_IDispatch FObj;
	System::TObject* FCodeObject;
	bool FPublishMembers;
	
public:
	__fastcall TLMDExternObject(const int AName, const System::WideString AStrName, _di_IDispatch AObj, System::TObject* ACodeObject, bool APublishMembers);
	virtual TLMDGlobalObjType __fastcall GetGlobalObjType(void);
	__property _di_IDispatch Obj = {read=FObj};
	__property System::TObject* CodeObject = {read=FCodeObject};
	__property bool PublishMembers = {read=FPublishMembers, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDExternObject(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDNameTable : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<Lmdsctclass::TLMDIdentifierItem*> _TLMDNameTable__1;
	
	
private:
	Lmdsctclass::TLMDIdentifierHashTable* FMap;
	_TLMDNameTable__1 FNameByIndex;
	int FCount;
	System::Syncobjs::TCriticalSection* FSection;
	void __fastcall AddNameIndex(const System::WideString AUpperName);
	void __fastcall Grow(int AOldLen);
	Lmdsctclass::TLMDIdentifierItem* __fastcall GetNameIndexes(int AIndex);
	
public:
	__fastcall TLMDNameTable(void);
	__fastcall virtual ~TLMDNameTable(void);
	System::WideString __fastcall GetName(int AIndex);
	int __fastcall GetNameIndex(const System::WideString AName, bool ACreateNewItem = true);
	__property Lmdsctclass::TLMDIdentifierItem* NameIndexes[int AIndex] = {read=GetNameIndexes};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ILMDEmitable : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall Emit(Lmdsctvmbytecode::TLMDAbstractNamespace* ANamespace, Lmdsctvmbytecode::TLMDByteCode* AByteCode) = 0 ;
public:
	/* TObject.Create */ inline __fastcall ILMDEmitable(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~ILMDEmitable(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ILMDParserCallbacks : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual int __fastcall GetNameId(const System::WideString AName) = 0 ;
	virtual void __fastcall GlobalStmtParsed(ILMDEmitable* AStmt) = 0 ;
	virtual void __fastcall GlobalObjParsed(TLMDGlobalObject* AObj, bool &ADuplicateName) = 0 ;
	virtual void __fastcall UsedUnitParsed(const System::WideString AName, bool &ADuplicateName) = 0 ;
public:
	/* TObject.Create */ inline __fastcall ILMDParserCallbacks(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~ILMDParserCallbacks(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ILMDParserBase : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall Parse(const System::WideString ASource) = 0 ;
	virtual ILMDEmitable* __fastcall ParseStmt(const System::WideString ASource) = 0 ;
	virtual ILMDEmitable* __fastcall ParseExpr(const System::WideString ASource) = 0 ;
public:
	/* TObject.Create */ inline __fastcall ILMDParserBase(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~ILMDParserBase(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDAddIntrinsicProc)(TLMDGlobalObject* AObject);

__interface ILMDLanguage  : public System::IInterface 
{
	virtual ILMDParserBase* __fastcall CreateParser(ILMDParserCallbacks* ACbs) = 0 ;
	virtual void __fastcall AddIntrinsics(TLMDAddIntrinsicProc AProc) = 0 ;
	virtual System::WideString __fastcall DebugEmpty(void) = 0 ;
	virtual System::WideString __fastcall DebugNothing(void) = 0 ;
	virtual System::WideString __fastcall DebugNull(void) = 0 ;
	virtual System::WideString __fastcall DebugStrLiteral(const System::WideString S) = 0 ;
};

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDNameTable* GlobNameTable;
extern DELPHI_PACKAGE System::OleVariant OleNull;
extern DELPHI_PACKAGE System::OleVariant OleUnassigned;
extern DELPHI_PACKAGE System::OleVariant OleZero;
extern DELPHI_PACKAGE System::OleVariant OleOne;
extern DELPHI_PACKAGE System::OleVariant OleMinusOne;
}	/* namespace Lmdsctvmcompbase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTVMCOMPBASE)
using namespace Lmdsctvmcompbase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctvmcompbaseHPP
