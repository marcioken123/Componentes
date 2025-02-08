// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctImporterTree.pas' rev: 31.00 (Windows)

#ifndef LmdsctimportertreeHPP
#define LmdsctimportertreeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <LMDHashTable.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctimportertree
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPasTreeNode;
class DELPHICLASS TLMDPasTreeNodes;
class DELPHICLASS TLMDPasNamedNode;
class DELPHICLASS TLMDPasNamedNodes;
class DELPHICLASS TLMDPasTypeMember;
class DELPHICLASS TLMDPasType;
class DELPHICLASS TLMDPasTypes;
class DELPHICLASS TLMDPasUsedUnit;
class DELPHICLASS TLMDPasUsedUnits;
class DELPHICLASS TLMDPasUnit;
class DELPHICLASS TLMDPasConstDecl;
class DELPHICLASS TLMDPasTypeDecl;
class DELPHICLASS TLMDPasVarDecl;
class DELPHICLASS TLMDPasVarDecls;
class DELPHICLASS TLMDPasProcHeading;
class DELPHICLASS TLMDPasProcHeadings;
class DELPHICLASS TLMDPasOverloadGroup;
class DELPHICLASS TLMDPasParameters;
class DELPHICLASS TLMDPasParameter;
class DELPHICLASS TLMDPasPropertyBase;
class DELPHICLASS TLMDPasProperty;
class DELPHICLASS TLMDPasPropertyRedecl;
class DELPHICLASS TLMDPasSubrangeType;
class DELPHICLASS TLMDPasTypeId;
class DELPHICLASS TLMDPasEnumType;
class DELPHICLASS TLMDPasPointerType;
class DELPHICLASS TLMDPasProcType;
class DELPHICLASS TLMDPasClassRefType;
class DELPHICLASS TLMDPasArrayTypeBase;
class DELPHICLASS TLMDPasStaticArrayType;
class DELPHICLASS TLMDPasDynamicArrayType;
class DELPHICLASS TLMDPasSetType;
class DELPHICLASS TLMDPasFileType;
class DELPHICLASS TLMDPasRecordType;
class DELPHICLASS TLMDPasClassType;
class DELPHICLASS TLMDPasInterfaceType;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDPasTreeNodeKind : unsigned char { tnkUsedUnit, tnkUnit, tnkConstDecl, tnkTypeDecl, tnkVarDecl, tnkProcHeading, tnkOverloadGroup, tnkParameter, tnkProperty, tnkPropertyRedecl, tnkSubrangeType, tnkTypeId, tnkEnumType, tnkPointerType, tnkProcType, tnkClassRefType, tnkStaticArrayType, tnkDynamicArrayType, tnkSetType, tnkFileType, tnkRecordType, tnkClassType, tnkInterfaceType };

enum DECLSPEC_DENUM TLMDSupportKind : unsigned char { skYes, skNo, skUnknown };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasTreeNode : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStrings* FC_Messages;
	TLMDSupportKind FC_SupportKind;
	System::TObject* FV_Data;
	System::TObject* FD_Data;
	System::Classes::TStrings* __fastcall GetC_Messages(void);
	
public:
	__fastcall TLMDPasTreeNode(void);
	__fastcall virtual ~TLMDPasTreeNode(void);
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void) = 0 ;
	virtual System::UnicodeString __fastcall ToStr(void) = 0 ;
	__property System::TObject* D_Data = {read=FD_Data, write=FD_Data};
	__property System::TObject* V_Data = {read=FV_Data, write=FV_Data};
	void __fastcall C_Clear(void);
	__property TLMDSupportKind C_SupportKind = {read=FC_SupportKind, write=FC_SupportKind, nodefault};
	__property System::Classes::TStrings* C_Messages = {read=GetC_Messages};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasTreeNodes : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDPasTreeNode* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	System::Classes::TList* FItems;
	bool FFreeItems;
	int __fastcall GetCount(void);
	TLMDPasTreeNode* __fastcall GetItems(int AIndex);
	
protected:
	virtual void __fastcall DoAdd(TLMDPasTreeNode* AItem);
	virtual void __fastcall DoClear(void);
	
public:
	__fastcall TLMDPasTreeNodes(bool AFreeItems);
	__fastcall virtual ~TLMDPasTreeNodes(void);
	void __fastcall Add(TLMDPasTreeNode* AItem);
	void __fastcall Clear(void);
	int __fastcall IndexOf(TLMDPasTreeNode* AItem);
	__property int Count = {read=GetCount, nodefault};
	__property TLMDPasTreeNode* Items[int AIndex] = {read=GetItems/*, default*/};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasNamedNode : public TLMDPasTreeNode
{
	typedef TLMDPasTreeNode inherited;
	
private:
	System::UnicodeString FName;
	bool FNameLocked;
	void __fastcall SetName(const System::UnicodeString Value);
	
public:
	__fastcall TLMDPasNamedNode(void);
	__property System::UnicodeString Name = {read=FName, write=SetName};
public:
	/* TLMDPasTreeNode.Destroy */ inline __fastcall virtual ~TLMDPasNamedNode(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasNamedNodes : public TLMDPasTreeNodes
{
	typedef TLMDPasTreeNodes inherited;
	
public:
	TLMDPasNamedNode* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	Lmdhashtable::TLMDHashTable* FNameIndex;
	HIDESBASE TLMDPasNamedNode* __fastcall GetItems(int AIndex);
	
protected:
	virtual void __fastcall DoAdd(TLMDPasTreeNode* AItem);
	virtual void __fastcall DoClear(void);
	
public:
	HIDESBASE void __fastcall Add(TLMDPasNamedNode* AItem);
	TLMDPasNamedNode* __fastcall Find(const System::UnicodeString AName);
	__property TLMDPasNamedNode* Items[int AIndex] = {read=GetItems/*, default*/};
public:
	/* TLMDPasTreeNodes.Create */ inline __fastcall TLMDPasNamedNodes(bool AFreeItems) : TLMDPasTreeNodes(AFreeItems) { }
	/* TLMDPasTreeNodes.Destroy */ inline __fastcall virtual ~TLMDPasNamedNodes(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasTypeMember : public TLMDPasNamedNode
{
	typedef TLMDPasNamedNode inherited;
	
public:
	virtual System::UnicodeString __fastcall MemberToStr(const System::UnicodeString ATypeName) = 0 ;
public:
	/* TLMDPasNamedNode.Create */ inline __fastcall TLMDPasTypeMember(void) : TLMDPasNamedNode() { }
	
public:
	/* TLMDPasTreeNode.Destroy */ inline __fastcall virtual ~TLMDPasTypeMember(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasType : public TLMDPasTreeNode
{
	typedef TLMDPasTreeNode inherited;
	
private:
	TLMDPasUnit* FOwner;
	TLMDPasTypeDecl* FParentDecl;
	
public:
	__fastcall virtual TLMDPasType(TLMDPasUnit* AOwner);
	__fastcall virtual ~TLMDPasType(void);
	virtual System::UnicodeString __fastcall Signature(void) = 0 ;
	__property TLMDPasUnit* Owner = {read=FOwner};
	__property TLMDPasTypeDecl* ParentDecl = {read=FParentDecl, write=FParentDecl};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasTypes : public TLMDPasTreeNodes
{
	typedef TLMDPasTreeNodes inherited;
	
public:
	TLMDPasType* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	HIDESBASE TLMDPasType* __fastcall GetItems(int AIndex);
	
public:
	HIDESBASE void __fastcall Add(TLMDPasType* AItem);
	__property TLMDPasType* Items[int AIndex] = {read=GetItems/*, default*/};
public:
	/* TLMDPasTreeNodes.Create */ inline __fastcall TLMDPasTypes(bool AFreeItems) : TLMDPasTreeNodes(AFreeItems) { }
	/* TLMDPasTreeNodes.Destroy */ inline __fastcall virtual ~TLMDPasTypes(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasUsedUnit : public TLMDPasNamedNode
{
	typedef TLMDPasNamedNode inherited;
	
public:
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	System::UnicodeString C_FullName;
public:
	/* TLMDPasNamedNode.Create */ inline __fastcall TLMDPasUsedUnit(void) : TLMDPasNamedNode() { }
	
public:
	/* TLMDPasTreeNode.Destroy */ inline __fastcall virtual ~TLMDPasUsedUnit(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasUsedUnits : public TLMDPasNamedNodes
{
	typedef TLMDPasNamedNodes inherited;
	
public:
	TLMDPasUsedUnit* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	HIDESBASE TLMDPasUsedUnit* __fastcall GetItems(int AIndex);
	
public:
	HIDESBASE void __fastcall Add(TLMDPasUsedUnit* AItem);
	__property TLMDPasUsedUnit* Items[int AIndex] = {read=GetItems/*, default*/};
public:
	/* TLMDPasTreeNodes.Create */ inline __fastcall TLMDPasUsedUnits(bool AFreeItems) : TLMDPasNamedNodes(AFreeItems) { }
	/* TLMDPasTreeNodes.Destroy */ inline __fastcall virtual ~TLMDPasUsedUnits(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasUnit : public TLMDPasNamedNode
{
	typedef TLMDPasNamedNode inherited;
	
private:
	TLMDPasNamedNodes* FDeclarations;
	TLMDPasUsedUnits* FUses;
	System::Classes::TList* FCreatedTypes;
	void __fastcall FreeCreatedTypes(void);
	
public:
	__fastcall TLMDPasUnit(void);
	__fastcall virtual ~TLMDPasUnit(void);
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	__property TLMDPasUsedUnits* Uses_ = {read=FUses};
	__property TLMDPasNamedNodes* Declarations = {read=FDeclarations};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDPasConstKind : unsigned char { ckUnknown, ckTyped, ckSimple, ckNil, ckSet };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasConstDecl : public TLMDPasTypeMember
{
	typedef TLMDPasTypeMember inherited;
	
private:
	TLMDPasConstKind FKind;
	TLMDPasType* FType;
	
public:
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall MemberToStr(const System::UnicodeString ATypeName);
	__property TLMDPasConstKind Kind = {read=FKind, write=FKind, nodefault};
	__property TLMDPasType* Type_ = {read=FType, write=FType};
public:
	/* TLMDPasNamedNode.Create */ inline __fastcall TLMDPasConstDecl(void) : TLMDPasTypeMember() { }
	
public:
	/* TLMDPasTreeNode.Destroy */ inline __fastcall virtual ~TLMDPasConstDecl(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasTypeDecl : public TLMDPasTypeMember
{
	typedef TLMDPasTypeMember inherited;
	
private:
	bool FTypeKwd;
	TLMDPasType* FType;
	bool FIsTemplate;
	
public:
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall MemberToStr(const System::UnicodeString ATypeName);
	__property bool TypeKwd = {read=FTypeKwd, write=FTypeKwd, nodefault};
	__property TLMDPasType* Type_ = {read=FType, write=FType};
	__property bool IsTemplate = {read=FIsTemplate, write=FIsTemplate, nodefault};
public:
	/* TLMDPasNamedNode.Create */ inline __fastcall TLMDPasTypeDecl(void) : TLMDPasTypeMember() { }
	
public:
	/* TLMDPasTreeNode.Destroy */ inline __fastcall virtual ~TLMDPasTypeDecl(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasVarDecl : public TLMDPasTypeMember
{
	typedef TLMDPasTypeMember inherited;
	
private:
	TLMDPasType* FType;
	bool FIsclassField;
	
public:
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall MemberToStr(const System::UnicodeString ATypeName);
	__property TLMDPasType* Type_ = {read=FType, write=FType};
	__property bool IsClassField = {read=FIsclassField, write=FIsclassField, nodefault};
public:
	/* TLMDPasNamedNode.Create */ inline __fastcall TLMDPasVarDecl(void) : TLMDPasTypeMember() { }
	
public:
	/* TLMDPasTreeNode.Destroy */ inline __fastcall virtual ~TLMDPasVarDecl(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasVarDecls : public TLMDPasNamedNodes
{
	typedef TLMDPasNamedNodes inherited;
	
public:
	TLMDPasVarDecl* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	HIDESBASE TLMDPasVarDecl* __fastcall GetItems(int AIndex);
	
public:
	HIDESBASE void __fastcall Add(TLMDPasVarDecl* AItem);
	__property TLMDPasVarDecl* Items[int AIndex] = {read=GetItems/*, default*/};
public:
	/* TLMDPasTreeNodes.Create */ inline __fastcall TLMDPasVarDecls(bool AFreeItems) : TLMDPasNamedNodes(AFreeItems) { }
	/* TLMDPasTreeNodes.Destroy */ inline __fastcall virtual ~TLMDPasVarDecls(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDPasProcKind : unsigned char { ppkProcedure, ppkFunction, ppkClassProcedure, ppkClassFunction, ppkConstructor, ppkDestructor };

enum DECLSPEC_DENUM TLMDPasProcBody : unsigned char { ppbNormal, ppbRecCreate, ppbRecCopy };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasProcHeading : public TLMDPasTypeMember
{
	typedef TLMDPasTypeMember inherited;
	
private:
	TLMDPasParameters* FParameters;
	TLMDPasType* FReturnType;
	TLMDPasProcKind FFuncKind;
	TLMDPasProcBody FBody;
	bool FIsTemplate;
	bool FIsOverload;
	bool FIsVirtual;
	
public:
	__fastcall TLMDPasProcHeading(void);
	__fastcall virtual ~TLMDPasProcHeading(void);
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall MemberToStr(const System::UnicodeString ATypeName);
	__property TLMDPasProcKind FuncKind = {read=FFuncKind, write=FFuncKind, nodefault};
	__property TLMDPasProcBody Body = {read=FBody, write=FBody, nodefault};
	__property TLMDPasParameters* Parameters = {read=FParameters};
	__property TLMDPasType* ReturnType = {read=FReturnType, write=FReturnType};
	__property bool IsTemplate = {read=FIsTemplate, write=FIsTemplate, nodefault};
	__property bool IsOverload = {read=FIsOverload, write=FIsOverload, nodefault};
	__property bool IsVirtual = {read=FIsVirtual, write=FIsVirtual, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasProcHeadings : public TLMDPasNamedNodes
{
	typedef TLMDPasNamedNodes inherited;
	
public:
	TLMDPasProcHeading* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	HIDESBASE TLMDPasProcHeading* __fastcall GetItems(int AIndex);
	
public:
	HIDESBASE void __fastcall Add(TLMDPasProcHeading* AItem);
	__property TLMDPasProcHeading* Items[int AIndex] = {read=GetItems/*, default*/};
public:
	/* TLMDPasTreeNodes.Create */ inline __fastcall TLMDPasProcHeadings(bool AFreeItems) : TLMDPasNamedNodes(AFreeItems) { }
	/* TLMDPasTreeNodes.Destroy */ inline __fastcall virtual ~TLMDPasProcHeadings(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasOverloadGroup : public TLMDPasTypeMember
{
	typedef TLMDPasTypeMember inherited;
	
private:
	TLMDPasProcHeadings* FProcs;
	
public:
	__fastcall TLMDPasOverloadGroup(const System::UnicodeString AName);
	__fastcall virtual ~TLMDPasOverloadGroup(void);
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall MemberToStr(const System::UnicodeString ATypeName);
	__property TLMDPasProcHeadings* Procs = {read=FProcs};
	TLMDPasProcKind C_FuncKind;
	int C_ParamCount;
	int C_OptionalCount;
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasParameters : public TLMDPasNamedNodes
{
	typedef TLMDPasNamedNodes inherited;
	
public:
	TLMDPasParameter* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	HIDESBASE TLMDPasParameter* __fastcall GetItems(int AIndex);
	int __fastcall GetOptionalCount(void);
	
public:
	System::UnicodeString __fastcall ToStr(void);
	System::UnicodeString __fastcall Signature(void);
	HIDESBASE void __fastcall Add(TLMDPasParameter* AItem);
	__property TLMDPasParameter* Items[int AIndex] = {read=GetItems/*, default*/};
	__property int OptionalCount = {read=GetOptionalCount, nodefault};
public:
	/* TLMDPasTreeNodes.Create */ inline __fastcall TLMDPasParameters(bool AFreeItems) : TLMDPasNamedNodes(AFreeItems) { }
	/* TLMDPasTreeNodes.Destroy */ inline __fastcall virtual ~TLMDPasParameters(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDPasParameterModifier : unsigned char { ppmNone, ppmConst, ppmVar, ppmOut };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasParameter : public TLMDPasNamedNode
{
	typedef TLMDPasNamedNode inherited;
	
private:
	bool FIsArrayOfConst;
	bool FIsOptional;
	TLMDPasParameterModifier FModifier;
	TLMDPasType* FType;
	
public:
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	System::UnicodeString __fastcall Signature(void);
	__property TLMDPasParameterModifier Modifier = {read=FModifier, write=FModifier, nodefault};
	__property TLMDPasType* Type_ = {read=FType, write=FType};
	__property bool IsArrayOfConst = {read=FIsArrayOfConst, write=FIsArrayOfConst, nodefault};
	__property bool IsOptional = {read=FIsOptional, write=FIsOptional, nodefault};
	System::UnicodeString C_VarName;
public:
	/* TLMDPasNamedNode.Create */ inline __fastcall TLMDPasParameter(void) : TLMDPasNamedNode() { }
	
public:
	/* TLMDPasTreeNode.Destroy */ inline __fastcall virtual ~TLMDPasParameter(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasPropertyBase : public TLMDPasTypeMember
{
	typedef TLMDPasTypeMember inherited;
	
private:
	bool FIsDefault;
	bool FIsProtected;
	
public:
	__property bool IsProtected = {read=FIsProtected, write=FIsProtected, nodefault};
	__property bool IsDefault = {read=FIsDefault, write=FIsDefault, nodefault};
public:
	/* TLMDPasNamedNode.Create */ inline __fastcall TLMDPasPropertyBase(void) : TLMDPasTypeMember() { }
	
public:
	/* TLMDPasTreeNode.Destroy */ inline __fastcall virtual ~TLMDPasPropertyBase(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasProperty : public TLMDPasPropertyBase
{
	typedef TLMDPasPropertyBase inherited;
	
private:
	bool FIsReadable;
	bool FIsWritable;
	TLMDPasParameters* FParameters;
	TLMDPasType* FType;
	bool FIsClassProp;
	
public:
	__fastcall TLMDPasProperty(void);
	__fastcall virtual ~TLMDPasProperty(void);
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall MemberToStr(const System::UnicodeString ATypeName);
	__property TLMDPasParameters* Parameters = {read=FParameters};
	__property TLMDPasType* Type_ = {read=FType, write=FType};
	__property bool IsClassProp = {read=FIsClassProp, write=FIsClassProp, nodefault};
	__property bool IsReadable = {read=FIsReadable, write=FIsReadable, nodefault};
	__property bool IsWritable = {read=FIsWritable, write=FIsWritable, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasPropertyRedecl : public TLMDPasPropertyBase
{
	typedef TLMDPasPropertyBase inherited;
	
public:
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall MemberToStr(const System::UnicodeString ATypeName);
public:
	/* TLMDPasNamedNode.Create */ inline __fastcall TLMDPasPropertyRedecl(void) : TLMDPasPropertyBase() { }
	
public:
	/* TLMDPasTreeNode.Destroy */ inline __fastcall virtual ~TLMDPasPropertyRedecl(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasSubrangeType : public TLMDPasType
{
	typedef TLMDPasType inherited;
	
public:
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall Signature(void);
public:
	/* TLMDPasType.Create */ inline __fastcall virtual TLMDPasSubrangeType(TLMDPasUnit* AOwner) : TLMDPasType(AOwner) { }
	/* TLMDPasType.Destroy */ inline __fastcall virtual ~TLMDPasSubrangeType(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasTypeId : public TLMDPasType
{
	typedef TLMDPasType inherited;
	
private:
	System::UnicodeString FQualName;
	bool FIsTemplate;
	
public:
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall Signature(void);
	__property System::UnicodeString QualName = {read=FQualName, write=FQualName};
	__property bool IsTemplate = {read=FIsTemplate, write=FIsTemplate, nodefault};
public:
	/* TLMDPasType.Create */ inline __fastcall virtual TLMDPasTypeId(TLMDPasUnit* AOwner) : TLMDPasType(AOwner) { }
	/* TLMDPasType.Destroy */ inline __fastcall virtual ~TLMDPasTypeId(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasEnumType : public TLMDPasType
{
	typedef TLMDPasType inherited;
	
private:
	System::Classes::TStrings* FEnumerators;
	
public:
	__fastcall virtual TLMDPasEnumType(TLMDPasUnit* AOwner);
	__fastcall virtual ~TLMDPasEnumType(void);
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall Signature(void);
	__property System::Classes::TStrings* Enumerators = {read=FEnumerators};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasPointerType : public TLMDPasType
{
	typedef TLMDPasType inherited;
	
private:
	TLMDPasType* FBaseType;
	
public:
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall Signature(void);
	__property TLMDPasType* BaseType = {read=FBaseType, write=FBaseType};
public:
	/* TLMDPasType.Create */ inline __fastcall virtual TLMDPasPointerType(TLMDPasUnit* AOwner) : TLMDPasType(AOwner) { }
	/* TLMDPasType.Destroy */ inline __fastcall virtual ~TLMDPasPointerType(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDPasProcTypeKind : unsigned char { ptkProcedure, ptkFunction };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasProcType : public TLMDPasType
{
	typedef TLMDPasType inherited;
	
private:
	bool FOfObject;
	TLMDPasParameters* FParameters;
	TLMDPasProcTypeKind FProcTypeKind;
	TLMDPasType* FReturnType;
	bool FIsRefTo;
	
public:
	__fastcall virtual TLMDPasProcType(TLMDPasUnit* AOwner);
	__fastcall virtual ~TLMDPasProcType(void);
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall Signature(void);
	__property TLMDPasProcTypeKind ProcTypeKind = {read=FProcTypeKind, write=FProcTypeKind, nodefault};
	__property TLMDPasParameters* Parameters = {read=FParameters};
	__property TLMDPasType* ReturnType = {read=FReturnType, write=FReturnType};
	__property bool OfObject = {read=FOfObject, write=FOfObject, nodefault};
	__property bool IsRefTo = {read=FIsRefTo, write=FIsRefTo, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasClassRefType : public TLMDPasType
{
	typedef TLMDPasType inherited;
	
private:
	TLMDPasType* FBaseType;
	
public:
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall Signature(void);
	__property TLMDPasType* BaseType = {read=FBaseType, write=FBaseType};
public:
	/* TLMDPasType.Create */ inline __fastcall virtual TLMDPasClassRefType(TLMDPasUnit* AOwner) : TLMDPasType(AOwner) { }
	/* TLMDPasType.Destroy */ inline __fastcall virtual ~TLMDPasClassRefType(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasArrayTypeBase : public TLMDPasType
{
	typedef TLMDPasType inherited;
	
private:
	TLMDPasType* FElemType;
	
public:
	__property TLMDPasType* ElemType = {read=FElemType, write=FElemType};
public:
	/* TLMDPasType.Create */ inline __fastcall virtual TLMDPasArrayTypeBase(TLMDPasUnit* AOwner) : TLMDPasType(AOwner) { }
	/* TLMDPasType.Destroy */ inline __fastcall virtual ~TLMDPasArrayTypeBase(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasStaticArrayType : public TLMDPasArrayTypeBase
{
	typedef TLMDPasArrayTypeBase inherited;
	
private:
	TLMDPasTypes* FBounds;
	
public:
	__fastcall virtual TLMDPasStaticArrayType(TLMDPasUnit* AOwner);
	__fastcall virtual ~TLMDPasStaticArrayType(void);
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall Signature(void);
	__property TLMDPasTypes* Bounds = {read=FBounds};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasDynamicArrayType : public TLMDPasArrayTypeBase
{
	typedef TLMDPasArrayTypeBase inherited;
	
public:
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall Signature(void);
public:
	/* TLMDPasType.Create */ inline __fastcall virtual TLMDPasDynamicArrayType(TLMDPasUnit* AOwner) : TLMDPasArrayTypeBase(AOwner) { }
	/* TLMDPasType.Destroy */ inline __fastcall virtual ~TLMDPasDynamicArrayType(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasSetType : public TLMDPasType
{
	typedef TLMDPasType inherited;
	
private:
	TLMDPasType* FBaseType;
	
public:
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall Signature(void);
	__property TLMDPasType* BaseType = {read=FBaseType, write=FBaseType};
public:
	/* TLMDPasType.Create */ inline __fastcall virtual TLMDPasSetType(TLMDPasUnit* AOwner) : TLMDPasType(AOwner) { }
	/* TLMDPasType.Destroy */ inline __fastcall virtual ~TLMDPasSetType(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasFileType : public TLMDPasType
{
	typedef TLMDPasType inherited;
	
private:
	TLMDPasType* FBaseType;
	
public:
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall Signature(void);
	__property TLMDPasType* BaseType = {read=FBaseType, write=FBaseType};
public:
	/* TLMDPasType.Create */ inline __fastcall virtual TLMDPasFileType(TLMDPasUnit* AOwner) : TLMDPasType(AOwner) { }
	/* TLMDPasType.Destroy */ inline __fastcall virtual ~TLMDPasFileType(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasRecordType : public TLMDPasType
{
	typedef TLMDPasType inherited;
	
private:
	TLMDPasNamedNodes* FMembers;
	TLMDPasTypeId* FHelperFor;
	
public:
	__fastcall virtual TLMDPasRecordType(TLMDPasUnit* AOwner);
	__fastcall virtual ~TLMDPasRecordType(void);
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall Signature(void);
	__property TLMDPasNamedNodes* Members = {read=FMembers};
	__property TLMDPasTypeId* HelperFor = {read=FHelperFor, write=FHelperFor};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasClassType : public TLMDPasType
{
	typedef TLMDPasType inherited;
	
private:
	TLMDPasTypeId* FAncestor;
	TLMDPasNamedNodes* FMembers;
	TLMDPasTypeId* FHelperFor;
	
public:
	__fastcall virtual TLMDPasClassType(TLMDPasUnit* AOwner);
	__fastcall virtual ~TLMDPasClassType(void);
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall Signature(void);
	__property TLMDPasTypeId* Ancestor = {read=FAncestor, write=FAncestor};
	__property TLMDPasNamedNodes* Members = {read=FMembers};
	__property TLMDPasTypeId* HelperFor = {read=FHelperFor, write=FHelperFor};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasInterfaceType : public TLMDPasType
{
	typedef TLMDPasType inherited;
	
private:
	System::Classes::TStrings* FInterfaces;
	TLMDPasNamedNodes* FMembers;
	
public:
	__fastcall virtual TLMDPasInterfaceType(TLMDPasUnit* AOwner);
	__fastcall virtual ~TLMDPasInterfaceType(void);
	virtual TLMDPasTreeNodeKind __fastcall GetNodeKind(void);
	virtual System::UnicodeString __fastcall ToStr(void);
	virtual System::UnicodeString __fastcall Signature(void);
	__property System::Classes::TStrings* Interfaces = {read=FInterfaces};
	__property TLMDPasNamedNodes* Members = {read=FMembers};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsctimportertree */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTIMPORTERTREE)
using namespace Lmdsctimportertree;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctimportertreeHPP
