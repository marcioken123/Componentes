// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctImporterCompiler.pas' rev: 31.00 (Windows)

#ifndef LmdsctimportercompilerHPP
#define LmdsctimportercompilerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDTypes.hpp>
#include <LMDSctImporterUnitDoc.hpp>
#include <LMDSctImporterTree.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctimportercompiler
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDUsedUnitItem;
class DELPHICLASS TLMDUsedUnitData;
class DELPHICLASS TLMDPasAnalizer;
class DELPHICLASS TLMDUsedUnitWriter;
class DELPHICLASS ELMDInvalidFileFormat;
class DELPHICLASS TLMDUsedUnitReader;
struct TLMDPasCall;
class DELPHICLASS TLMDPasWrapperGenerator;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUsedUnitItem : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::UnicodeString FullName;
	bool Checked;
	Lmdsctimportertree::TLMDSupportKind SupportKind;
public:
	/* TObject.Create */ inline __fastcall TLMDUsedUnitItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDUsedUnitItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUsedUnitData : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDUsedUnitItem* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	TLMDPasAnalizer* FAnalizer;
	Lmdsctimportertree::TLMDPasUsedUnit* FPasUnit;
	System::Classes::TList* FItems;
	int __fastcall GetCount(void);
	TLMDUsedUnitItem* __fastcall GetItems(int AIndex);
	
public:
	__fastcall TLMDUsedUnitData(TLMDPasAnalizer* AAnalizer);
	__fastcall virtual ~TLMDUsedUnitData(void);
	void __fastcall Clear(void);
	void __fastcall Add(const System::UnicodeString AFullName, bool AChecked, Lmdsctimportertree::TLMDSupportKind ASupportKind);
	TLMDUsedUnitItem* __fastcall Find(const System::UnicodeString AFullName);
	__property Lmdsctimportertree::TLMDPasUsedUnit* PasUnit = {read=FPasUnit, write=FPasUnit};
	__property TLMDUsedUnitItem* Items[int AIndex] = {read=GetItems/*, default*/};
	__property int Count = {read=GetCount, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasAnalizer : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdsctimporterunitdoc::TLMDUnitDocument* FDocument;
	Lmdsctimportertree::TLMDPasUnit* FUnit;
	int FUnitErrorCount;
	System::Classes::TList* FUsedUnits;
	void __fastcall ClearUsedUnits(void);
	void __fastcall ClearProc(Lmdsctimporterunitdoc::TLMDUnitDocIterateContext* C, Lmdsctimportertree::TLMDPasNamedNode* ANode, void * AData);
	
protected:
	void __fastcall AddError(const System::UnicodeString AMsg, Lmdsctimportertree::TLMDPasNamedNode* AObject);
	void __fastcall AddWarning(const System::UnicodeString AMsg, Lmdsctimportertree::TLMDPasNamedNode* AObject);
	void __fastcall AddInfo(const System::UnicodeString AMsg, Lmdsctimportertree::TLMDPasNamedNode* AObject);
	void __fastcall AddUncheckedInfo(Lmdsctimportertree::TLMDPasNamedNode* ANode, const System::UnicodeString ATypeName = System::UnicodeString())/* overload */;
	void __fastcall AddUncheckedInfo(Lmdsctimportertree::TLMDPasNamedNodes* ANodes, const System::UnicodeString ATypeName = System::UnicodeString())/* overload */;
	void __fastcall AnalizeUnit(void);
	void __fastcall AnalizeUsedUnit(Lmdsctimportertree::TLMDPasUsedUnit* AUUnit);
	void __fastcall AnalizeRecordMembers(const System::UnicodeString ATypeName, Lmdsctimportertree::TLMDPasRecordType* AType);
	void __fastcall AnalizeClassMembers(const System::UnicodeString ATypeName, Lmdsctimportertree::TLMDPasClassType* AType);
	void __fastcall AnalizeTypeDecl(Lmdsctimportertree::TLMDPasTypeDecl* ADecl);
	void __fastcall AnalizeConst(Lmdsctimportertree::TLMDPasConstDecl* AConst);
	void __fastcall AnalizeVar(Lmdsctimportertree::TLMDPasVarDecl* AVar);
	void __fastcall AnalizeProc(Lmdsctimportertree::TLMDPasProcHeading* AProc);
	void __fastcall AnalizeOverloadGroup(Lmdsctimportertree::TLMDPasOverloadGroup* AGroup);
	bool __fastcall IsOverloadPairSupported(Lmdsctimportertree::TLMDPasProcHeading* AProcA, Lmdsctimportertree::TLMDPasProcHeading* AProcB);
	void __fastcall AnalizeProperty(Lmdsctimportertree::TLMDPasProperty* AProp);
	void __fastcall AnalizePropRedecl(Lmdsctimportertree::TLMDPasPropertyRedecl* ARedecl);
	Lmdsctimportertree::TLMDSupportKind __fastcall GetParamsSupportKind(Lmdsctimportertree::TLMDPasParameters* AParams, Lmdsctimportertree::TLMDPasNamedNode* AMessageObject);
	Lmdsctimportertree::TLMDSupportKind __fastcall GetParamSupportKind(Lmdsctimportertree::TLMDPasParameter* AParam, Lmdsctimportertree::TLMDPasNamedNode* AMessageObject);
	Lmdsctimportertree::TLMDSupportKind __fastcall GetTypeDeclSupportKind(Lmdsctimportertree::TLMDPasType* AType, const System::UnicodeString AMessagePrefix, Lmdsctimportertree::TLMDPasNamedNode* AMessageObject);
	Lmdsctimportertree::TLMDSupportKind __fastcall GetTypeRefSupportKind(Lmdsctimportertree::TLMDPasType* AType, const System::UnicodeString AMessagePrefix, Lmdsctimportertree::TLMDPasNamedNode* AMessageObject);
	Lmdsctimportertree::TLMDSupportKind __fastcall GetTypeIdSupportKind(const System::UnicodeString AQualName, const System::UnicodeString AMessagePrefix, Lmdsctimportertree::TLMDPasNamedNode* AMessageObject);
	TLMDUsedUnitItem* __fastcall FindIdInUsedUnits(const System::UnicodeString AFullName);
	TLMDUsedUnitData* __fastcall FindUsedUnit(const System::UnicodeString AUnitName);
	
public:
	__fastcall TLMDPasAnalizer(Lmdsctimporterunitdoc::TLMDUnitDocument* ADocument);
	__fastcall virtual ~TLMDPasAnalizer(void);
	bool __fastcall Analize(void);
	__property Lmdsctimporterunitdoc::TLMDUnitDocument* Document = {read=FDocument};
	__property Lmdsctimportertree::TLMDPasUnit* Unit_ = {read=FUnit};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUsedUnitWriter : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdsctimporterunitdoc::TLMDUnitDocument* FDocument;
	Lmdsctimportertree::TLMDPasUnit* FUnit;
	System::Classes::TStrings* FLines;
	
protected:
	void __fastcall WriteUnit(void);
	void __fastcall WriteUnitDeclaration(Lmdsctimportertree::TLMDPasNamedNode* ADecl);
	void __fastcall WriteTypeDecl(Lmdsctimportertree::TLMDPasTypeDecl* ADecl);
	void __fastcall WriteProperty(Lmdsctimportertree::TLMDPasProperty* AProp);
	void __fastcall WritePropRedecl(Lmdsctimportertree::TLMDPasPropertyRedecl* ARedecl);
	void __fastcall AddLine(int AIdent, const System::WideChar AElemKind, const System::UnicodeString AName, bool AChecked, Lmdsctimportertree::TLMDSupportKind ASupportKind);
	
public:
	__fastcall TLMDUsedUnitWriter(Lmdsctimporterunitdoc::TLMDUnitDocument* ADocument);
	__fastcall virtual ~TLMDUsedUnitWriter(void);
	void __fastcall SaveToStream(System::Classes::TStream* AStream);
	void __fastcall SaveToFile(const System::UnicodeString AFileName);
	__property Lmdsctimporterunitdoc::TLMDUnitDocument* Document = {read=FDocument};
	__property Lmdsctimportertree::TLMDPasUnit* Unit_ = {read=FUnit};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDUsedUnitReaderLineKind : unsigned char { lkType, lkProperty, lkUnknown };

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDInvalidFileFormat : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDInvalidFileFormat(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDInvalidFileFormat(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDInvalidFileFormat(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDInvalidFileFormat(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDInvalidFileFormat(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDInvalidFileFormat(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDInvalidFileFormat(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDInvalidFileFormat(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDInvalidFileFormat(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDInvalidFileFormat(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDInvalidFileFormat(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDInvalidFileFormat(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDInvalidFileFormat(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUsedUnitReader : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDPasAnalizer* FAnalizer;
	System::Classes::TStrings* FLines;
	TLMDUsedUnitData* FData;
	int FIndex;
	
protected:
	System::UnicodeString __fastcall CurLine(void);
	void __fastcall SkipLine(void);
	bool __fastcall Eof(void);
	void __fastcall InvalidFormatError(void);
	void __fastcall ReadUnit(void);
	void __fastcall ReadType(void);
	void __fastcall ReadProperty(const System::UnicodeString AParentName);
	void __fastcall SkipBlanks(const System::UnicodeString s, int &i);
	TLMDUsedUnitReaderLineKind __fastcall LineKind(const System::UnicodeString ALine);
	void __fastcall GetParams(const System::UnicodeString ALine, /* out */ bool &AChecked, /* out */ Lmdsctimportertree::TLMDSupportKind &ASupportKind, /* out */ System::UnicodeString &AName);
	
public:
	__fastcall TLMDUsedUnitReader(TLMDPasAnalizer* AAnalizer);
	__fastcall virtual ~TLMDUsedUnitReader(void);
	TLMDUsedUnitData* __fastcall LoadFromStream(System::Classes::TStream* AStream);
	TLMDUsedUnitData* __fastcall LoadFromFile(const System::UnicodeString AFileName);
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDPasSplitKind : unsigned char { skNone, skUses, skDecl, skBody };

struct DECLSPEC_DRECORD TLMDPasCall
{
public:
	Lmdsctimportertree::TLMDPasProcHeading* Proc;
	int ArgCount;
};


typedef System::DynamicArray<TLMDPasCall> TLMDPasCalls;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasWrapperGenerator : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdsctimportertree::TLMDPasUnit* FUnit;
	Lmdsctimporterunitdoc::TLMDUnitDocument* FDocument;
	System::Classes::TStrings* FLines;
	int FCurIdent;
	int FCurEmptyLine;
	System::UnicodeString FResultUnitName;
	
protected:
	void __fastcall AddLine(const System::UnicodeString S, TLMDPasSplitKind APasSplitKind = (TLMDPasSplitKind)(0x0));
	void __fastcall EmptyLine(void);
	void __fastcall BeginIdent(void);
	void __fastcall EndIdent(void);
	int __fastcall GetSplitPos(const System::UnicodeString S, int AMaxLength, TLMDPasSplitKind APasSplitKind);
	void __fastcall GenUnit(void);
	void __fastcall GenInterfaceSection(void);
	void __fastcall GenImplementationSection(void);
	void __fastcall GenUsesClause(void);
	void __fastcall AddUsesUnit(const System::UnicodeString AUnitName, System::UnicodeString &AUses);
	bool __fastcall HasTypeWrappers(void);
	bool __fastcall HasUnitLevelDecl(void);
	System::UnicodeString __fastcall GetUnitUnprefixedName(void);
	void __fastcall GenIntfUnitWrapper(void);
	void __fastcall GenImplUnitWrapper(void);
	void __fastcall GenUnitWrapperReg(void);
	void __fastcall GenUnitDoInitBody(void);
	bool __fastcall IsProtectedProp(Lmdsctimportertree::TLMDPasNamedNode* AMember);
	bool __fastcall HasProtectedProps(void);
	bool __fastcall GetProtectedProps(Lmdsctimportertree::TLMDPasClassType* AType, System::Classes::TList* AResult);
	void __fastcall GenProtectedPropHandlers(void);
	void __fastcall GenProtectedAccessorType(Lmdsctimportertree::TLMDPasTypeDecl* AType);
	bool __fastcall HasClassWrapperRegs(void);
	void __fastcall GenClassWrapperRegs(void);
	bool __fastcall HasEventWrapperRegs(void);
	void __fastcall GenEventWrapperRegs(void);
	void __fastcall GenIntfTypeWrappers(void);
	void __fastcall GenImplTypeWrappers(void);
	void __fastcall GenIntfSubrangeTypeDecl(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasSubrangeType* AType);
	void __fastcall GenIntfTypeIdDecl(const System::UnicodeString AName, bool ATypeKwd, Lmdsctimportertree::TLMDPasTypeId* AType);
	void __fastcall GenIntfEnumTypeDecl(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasEnumType* AType);
	void __fastcall GenIntfClassRefTypeDecl(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasClassRefType* AType);
	void __fastcall GenIntfSetTypeDecl(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasSetType* AType);
	void __fastcall GenIntfRecordTypeDecl(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasRecordType* AType);
	void __fastcall GenIntfClassTypeDecl(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasClassType* AType);
	void __fastcall GenIntfProcTypeDecl(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasProcType* AType);
	void __fastcall GenImplSubrangeTypeDecl(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasSubrangeType* AType);
	void __fastcall GenImplTypeIdDecl(const System::UnicodeString AName, bool ATypeKwd, Lmdsctimportertree::TLMDPasTypeId* AType);
	void __fastcall GenImplEnumTypeDecl(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasEnumType* AType);
	void __fastcall GenImplClassRefTypeDecl(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasClassRefType* AType);
	void __fastcall GenImplSetTypeDecl(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasSetType* AType);
	void __fastcall GenImplRecordTypeDecl(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasRecordType* AType);
	void __fastcall GenImplClassTypeDecl(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasClassType* AType);
	void __fastcall GenImplProcTypeDecl(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasProcType* AType);
	void __fastcall GenTypeImplComment(const System::UnicodeString AClassName);
	void __fastcall GenRecordDoInitBody(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasRecordType* AType);
	bool __fastcall IsInstanceMember(Lmdsctimportertree::TLMDPasNamedNode* AMember);
	bool __fastcall IsClassHasInstanceMembers(Lmdsctimportertree::TLMDPasClassType* AType, bool AIncludePropRedecls);
	bool __fastcall IsClassHasClassMembers(Lmdsctimportertree::TLMDPasClassType* AType);
	void __fastcall GenClassDoInitBody(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasClassType* AType);
	void __fastcall GenIntfScriptHandler(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasProcType* AType);
	void __fastcall GenImplScriptHandler(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasProcType* AType);
	System::UnicodeString __fastcall GenScriptHandlerProcHeading(Lmdsctimportertree::TLMDPasProcType* AType, const System::UnicodeString AProcName);
	void __fastcall GenScriptHandlerProcImpl(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasProcType* AType);
	void __fastcall GenScriptHandlerProcVarSection(const System::UnicodeString AName, Lmdsctimportertree::TLMDPasProcType* AType);
	void __fastcall GenUnitMemberDoInit(Lmdsctimportertree::TLMDPasNamedNode* AMember);
	void __fastcall GenTypeMemberDoInit(const System::UnicodeString ATypeName, Lmdsctimportertree::TLMDPasNamedNode* AMember);
	System::UnicodeString __fastcall GenProcDoInit(const System::UnicodeString AProcName, const System::UnicodeString AInvoker, Lmdsctimportertree::TLMDPasProcKind AKind, int AParamCount, int AOptionalParams, Lmdsctimportertree::TLMDPasType* AReturnType);
	void __fastcall GenImplMembersInvokers(const System::UnicodeString AParentName, const System::UnicodeString AInstanceInvokePrefix, const System::UnicodeString AMetaInvokePrefix, Lmdsctimportertree::TLMDPasNamedNodes* AMembers);
	void __fastcall GenInvokerVarSection(Lmdsctimportertree::TLMDPasNamedNode* AMember);
	void __fastcall GenMemberInvoker(const System::UnicodeString AParentName, const System::UnicodeString AInvokePrefix, Lmdsctimportertree::TLMDPasNamedNode* AMember);
	void __fastcall GenTypeDeclInvoker(const System::UnicodeString AParentName, const System::UnicodeString AInvokePrefix, Lmdsctimportertree::TLMDPasTypeDecl* ADecl);
	void __fastcall GenConstInvoker(const System::UnicodeString AParentName, const System::UnicodeString AInvokePrefix, Lmdsctimportertree::TLMDPasConstDecl* ADecl);
	void __fastcall GenVarInvoker(const System::UnicodeString AParentName, const System::UnicodeString AInvokePrefix, Lmdsctimportertree::TLMDPasVarDecl* ADecl);
	void __fastcall GenProcInvoker(const System::UnicodeString AParentName, const System::UnicodeString AInvokePrefix, Lmdsctimportertree::TLMDPasProcHeading* AProc)/* overload */;
	void __fastcall GenProcInvoker(const System::UnicodeString AParentName, const System::UnicodeString AName, const System::UnicodeString AInvokePrefix, const TLMDPasCalls ACalls)/* overload */;
	void __fastcall GenOvarlodGroupInvoker(const System::UnicodeString AParentName, const System::UnicodeString AInvokePrefix, Lmdsctimportertree::TLMDPasOverloadGroup* AGroup);
	void __fastcall GenPropInvoker(const System::UnicodeString AParentName, const System::UnicodeString AInvokePrefix, Lmdsctimportertree::TLMDPasProperty* AProp);
	void __fastcall GetAllVarOutParams(Lmdsctimportertree::TLMDPasProcType* AType, System::Classes::TList* Result)/* overload */;
	void __fastcall GetAllVarOutParams(Lmdsctimportertree::TLMDPasNamedNode* AMember, System::Classes::TList* Result)/* overload */;
	void __fastcall GenParamsPreExecute(Lmdsctimportertree::TLMDPasParameters* AParams, int AIncludeOnly = 0xffffffff);
	void __fastcall GenParamsPostExecute(Lmdsctimportertree::TLMDPasParameters* AParams, int AIncludeOnly = 0xffffffff);
	System::UnicodeString __fastcall GenParamsStr(Lmdsctimportertree::TLMDPasParameters* AParams, int AIncludeOnly = 0xffffffff);
	void __fastcall ScriptHandlerGenParamsPreExecute(Lmdsctimportertree::TLMDPasParameters* AParams);
	void __fastcall ScriptHandlerGenParamsPostExecute(Lmdsctimportertree::TLMDPasParameters* AParams);
	System::UnicodeString __fastcall GenTypeWrapperRef(Lmdsctimportertree::TLMDPasType* const AType);
	System::UnicodeString __fastcall GenTypeIdWrapperRef(const System::UnicodeString AQualName);
	System::UnicodeString __fastcall GenTypeToVarStr(Lmdsctimportertree::TLMDPasType* const AType, const System::UnicodeString AArg);
	System::UnicodeString __fastcall GenTypeFromVarStr(Lmdsctimportertree::TLMDPasType* const AType, const System::UnicodeString AArg);
	System::UnicodeString __fastcall GenTypeIdToVarStr(const System::UnicodeString AQualName, const System::UnicodeString AArg);
	System::UnicodeString __fastcall GenTypeIdFromVarStr(const System::UnicodeString AQualName, const System::UnicodeString AArg);
	System::UnicodeString __fastcall GenTypeReuseStr(Lmdsctimportertree::TLMDPasType* const AType);
	System::UnicodeString __fastcall ConstraintString(const System::UnicodeString S, int AMaxSize);
	System::UnicodeString __fastcall GetWrapperUnitName(const System::UnicodeString AUnitName);
	System::UnicodeString __fastcall GetWrapperTypeName(const System::UnicodeString ATypeName);
	System::UnicodeString __fastcall GetMetaclassTypeName(const System::UnicodeString ATypeName);
	System::UnicodeString __fastcall GetProtectedAccessorName(const System::UnicodeString ATypeName);
	System::UnicodeString __fastcall GetEventHandlerClassName(const System::UnicodeString ATypeName);
	System::UnicodeString __fastcall GetTypeWrapperFromQualTypeId(const System::UnicodeString AQualName);
	void __fastcall AddCaseEntryBegin(int Idx);
	void __fastcall AddCaseEntryEnd(void);
	System::UnicodeString __fastcall GetIntfToVarHeader(const System::UnicodeString ATypeName);
	System::UnicodeString __fastcall GetIntfFromVarHeader(const System::UnicodeString ATypeName);
	System::UnicodeString __fastcall GetImplToVarHeader(const System::UnicodeString AClassName, const System::UnicodeString ATypeName);
	System::UnicodeString __fastcall GetImplFromVarHeader(const System::UnicodeString AClassName, const System::UnicodeString ATypeName);
	
public:
	__fastcall TLMDPasWrapperGenerator(Lmdsctimporterunitdoc::TLMDUnitDocument* ADocument);
	__fastcall virtual ~TLMDPasWrapperGenerator(void);
	void __fastcall Generate(void);
	void __fastcall SaveToStream(System::Classes::TStream* AStream);
	void __fastcall SaveToFile(const System::UnicodeString AFileName);
	__property Lmdsctimporterunitdoc::TLMDUnitDocument* Document = {read=FDocument};
	__property Lmdsctimportertree::TLMDPasUnit* Unit_ = {read=FUnit};
	__property System::UnicodeString ResultUnitName = {read=FResultUnitName};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall ParseQualName(const System::UnicodeString AQualName, /* out */ System::UnicodeString &AUnitName, /* out */ System::UnicodeString &AName);
}	/* namespace Lmdsctimportercompiler */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTIMPORTERCOMPILER)
using namespace Lmdsctimportercompiler;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctimportercompilerHPP
