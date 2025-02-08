// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctWrappers.pas' rev: 31.00 (Windows)

#ifndef LmdsctwrappersHPP
#define LmdsctwrappersHPP

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
#include <System.TypInfo.hpp>
#include <Winapi.ActiveX.hpp>
#include <LMDStrings.hpp>
#include <LMDUnicode.hpp>
#include <LMDHashTable.hpp>
#include <LMDTypes.hpp>
#include <LMDSctClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctwrappers
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWrapperData;
class DELPHICLASS TLMDWrapper;
class DELPHICLASS TLMDInvokeItem;
class DELPHICLASS TLMDAbstractDispInfo;
class DELPHICLASS TLMDDispInfo;
class DELPHICLASS TLMDDispWrapperData;
__interface ILMDDispWrapper;
typedef System::DelphiInterface<ILMDDispWrapper> _di_ILMDDispWrapper;
class DELPHICLASS TLMDDispWrapper;
class DELPHICLASS TLMDTypeWrapperData;
class DELPHICLASS TLMDTypeWrapper;
class DELPHICLASS TLMDMetatypeDispInfo;
class DELPHICLASS TLMDMetatypeWrapper;
class DELPHICLASS TLMDPredTypeWrapper;
class DELPHICLASS TLMDClassWrapperData;
class DELPHICLASS TLMDClassWrapper;
class DELPHICLASS TLMDMetaclassWrapper;
class DELPHICLASS TLMDRecordWrapperData;
class DELPHICLASS TLMDRecordWrapper;
struct TLMDEnumerator;
class DELPHICLASS TLMDEnumWrapper;
class DELPHICLASS TLMDSetWrapper;
class DELPHICLASS TLMDSubrangeWrapper;
class DELPHICLASS TLMDScriptHandlerWrapper;
class DELPHICLASS TLMDEventWrapper;
class DELPHICLASS TLMDUnitEnumerators;
class DELPHICLASS TLMDUnitWrapperData;
class DELPHICLASS TLMDUnitWrapper;
//-- type declarations -------------------------------------------------------
typedef System::TMetaClass* TLMDWrapperClass;

typedef System::TMetaClass* TLMDWrapperDataClass;

typedef System::TMetaClass* TLMDTypeWrapperClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWrapperData : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	TLMDWrapperClass FWrapperClass;
	
public:
	__fastcall virtual TLMDWrapperData(TLMDWrapperClass AWrapperClass);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDWrapperData(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWrapper : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	__classmethod TLMDWrapperData* __fastcall GetData();
	__classmethod virtual TLMDWrapperDataClass __fastcall GetDataClass();
	__classmethod virtual void __fastcall InitData(TLMDWrapperData* AData);
public:
	/* TObject.Create */ inline __fastcall TLMDWrapper(void) : System::TInterfacedObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDWrapper(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM Lmdsctwrappers__3 : unsigned char { iiaHidden, iiaOptParams, iiaNoResult, iiaMetaMember, iiaConstructor, iiaDefaultProp };

typedef System::Set<Lmdsctwrappers__3, Lmdsctwrappers__3::iiaHidden, Lmdsctwrappers__3::iiaDefaultProp> TLMDInvokeItemAttrs;

typedef System::StaticArray<System::OleVariant, 1025> TLMDDispArgs;

typedef System::OleVariant __fastcall (*TLMDInvokeProc)(void *AObj, const TLMDDispArgs &AArgs, int AArgsSize, bool IsGet);

typedef System::Word __fastcall (__closure *TLMDDebugTypeFunc)(void);

class PASCALIMPLEMENTATION TLMDInvokeItem : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int Index;
	System::WideString UppName;
	System::WideString Name;
	TLMDInvokeProc InvokeProc;
	TLMDDebugTypeFunc DebugType;
	TLMDInvokeItemAttrs Attrs;
	int ParamCount;
	int MinParamCount;
	unsigned InvokeFlags;
	unsigned ResMask;
	void __fastcall Assign(TLMDInvokeItem* AItem);
public:
	/* TObject.Create */ inline __fastcall TLMDInvokeItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDInvokeItem(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDAbstractDispInfo : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	_di_ITypeInfo FTypeInfo;
	virtual int __fastcall IndexOfInvokeItem(const System::WideString AName, bool AAllowHidden = false) = 0 ;
	virtual TLMDInvokeItem* __fastcall GetInvokeItem(int AIndex) = 0 ;
	virtual int __fastcall GetInvokeItemCount(void) = 0 ;
	
public:
	__fastcall TLMDAbstractDispInfo(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDAbstractDispInfo(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDispInfo : public TLMDAbstractDispInfo
{
	typedef TLMDAbstractDispInfo inherited;
	
	
private:
	typedef System::DynamicArray<TLMDInvokeItem*> _TLMDDispInfo__1;
	
	
private:
	_TLMDDispInfo__1 FItems;
	int FCount;
	Lmdhashtable::TLMDHashTable* FNameIndex;
	void __fastcall Clear(void);
	void __fastcall AddItem(TLMDInvokeItem* AItem);
	void __fastcall InitDispidValueItem(void);
	virtual int __fastcall IndexOfInvokeItem(const System::WideString AName, bool AAllowHidden = false);
	virtual TLMDInvokeItem* __fastcall GetInvokeItem(int AIndex);
	virtual int __fastcall GetInvokeItemCount(void);
	void __fastcall AddInvokeItem(const System::WideString AName, TLMDDebugTypeFunc AType, TLMDInvokeItemAttrs AAttrs, int AParamCount, System::Word AInvokeFlags, TLMDInvokeProc AInvokeProc)/* overload */;
	void __fastcall AddInvokeItem(TLMDInvokeItem* AItem, bool AUnhide = false, bool AIsDefaultProp = false)/* overload */;
	
public:
	__fastcall TLMDDispInfo(void);
	__fastcall virtual ~TLMDDispInfo(void);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDispWrapperData : public TLMDWrapperData
{
	typedef TLMDWrapperData inherited;
	
private:
	TLMDDispInfo* FDispInfo;
	void __fastcall AddDispMethod(const System::WideString AName, TLMDInvokeProc AInvokeProc, int AParamCount, TLMDDebugTypeFunc AResultType, bool AHasOptParams, bool AIsMetaMember, bool AIsHidden = false);
	void __fastcall AddDispConstructor(const System::WideString AName, TLMDInvokeProc AInvokeProc, int AParamCount, TLMDDebugTypeFunc AResultType, bool AHasOptParams, bool AIsHidden = false);
	void __fastcall AddDispProp(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDDebugTypeFunc AType, bool AIsReadable, bool AIsWritable, int AParamCount, bool AIsMetaMember, bool AIsHidden = false, bool AIsDefault = false);
	
public:
	__fastcall virtual TLMDDispWrapperData(TLMDWrapperClass AWrapperClass);
	__fastcall virtual ~TLMDDispWrapperData(void);
};

#pragma pack(pop)

__interface  INTERFACE_UUID("{1ADE176B-20A5-4B78-8247-2FCDDCBAA38A}") ILMDDispWrapper  : public System::IInterface 
{
	virtual TLMDDispWrapper* __fastcall GetSelf(void) = 0 ;
};

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDispWrapper : public TLMDWrapper
{
	typedef TLMDWrapper inherited;
	
private:
	HRESULT __fastcall EncodeInvokeError(System::Sysutils::Exception* E, Winapi::Activex::PExcepInfo AEInfo);
	__classmethod virtual TLMDWrapperDataClass __fastcall GetDataClass();
	virtual TLMDAbstractDispInfo* __fastcall GetDispInfo(void);
	virtual System::OleVariant __fastcall LowInvoke(TLMDInvokeItem* AItem, const TLMDDispArgs &AArgs, int AArgsSize, bool AIsGet);
	HRESULT __stdcall GetTypeInfoCount(/* out */ int &Count);
	HRESULT __stdcall GetTypeInfo(int Index, int LocaleID, /* out */ void *TypeInfo);
	HRESULT __stdcall GetIDsOfNames(const GUID &IID, void * Names, int NameCount, int LocaleID, void * DispIDs);
	HRESULT __stdcall Invoke(int DispID, const GUID &IID, int LocaleID, System::Word Flags, void *Params, void * VarResult, void * ExcepInfo, void * ArgErr);
	TLMDDispWrapper* __fastcall GetSelf(void);
public:
	/* TObject.Create */ inline __fastcall TLMDDispWrapper(void) : TLMDWrapper() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDDispWrapper(void) { }
	
private:
	void *__IDispatch;	// IDispatch 
	void *__ILMDDispWrapper;	// ILMDDispWrapper 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {00020400-0000-0000-C000-000000000046}
	operator _di_IDispatch()
	{
		_di_IDispatch intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator IDispatch*(void) { return (IDispatch*)&__IDispatch; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {1ADE176B-20A5-4B78-8247-2FCDDCBAA38A}
	operator _di_ILMDDispWrapper()
	{
		_di_ILMDDispWrapper intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator ILMDDispWrapper*(void) { return (ILMDDispWrapper*)&__ILMDDispWrapper; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTypeWrapperData : public TLMDDispWrapperData
{
	typedef TLMDDispWrapperData inherited;
	
private:
	_di_IDispatch FMetatypeWrapper;
public:
	/* TLMDDispWrapperData.Create */ inline __fastcall virtual TLMDTypeWrapperData(TLMDWrapperClass AWrapperClass) : TLMDDispWrapperData(AWrapperClass) { }
	/* TLMDDispWrapperData.Destroy */ inline __fastcall virtual ~TLMDTypeWrapperData(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTypeWrapper : public TLMDDispWrapper
{
	typedef TLMDDispWrapper inherited;
	
private:
	__classmethod virtual TLMDWrapperDataClass __fastcall GetDataClass();
	__classmethod virtual System::OleVariant __fastcall TypeToVariant();
	__classmethod virtual System::OleVariant __fastcall LowMetaInvoke(TLMDInvokeItem* AItem, const TLMDDispArgs &AArgs, int AArgsSize, bool AIsGet);
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__fastcall virtual TLMDTypeWrapper(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDTypeWrapper(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMetatypeDispInfo : public TLMDAbstractDispInfo
{
	typedef TLMDAbstractDispInfo inherited;
	
private:
	TLMDAbstractDispInfo* FOriginalInfo;
	virtual int __fastcall IndexOfInvokeItem(const System::WideString AName, bool AAllowHidden = false);
	virtual TLMDInvokeItem* __fastcall GetInvokeItem(int AIndex);
	virtual int __fastcall GetInvokeItemCount(void);
	
public:
	__fastcall TLMDMetatypeDispInfo(TLMDAbstractDispInfo* AOriginalInfo);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDMetatypeDispInfo(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMetatypeWrapper : public TLMDDispWrapper
{
	typedef TLMDDispWrapper inherited;
	
private:
	TLMDTypeWrapperClass FType;
	TLMDMetatypeDispInfo* FDispInfo;
	__classmethod virtual TLMDWrapperDataClass __fastcall GetDataClass();
	virtual TLMDAbstractDispInfo* __fastcall GetDispInfo(void);
	virtual System::OleVariant __fastcall LowInvoke(TLMDInvokeItem* AItem, const TLMDDispArgs &AArgs, int AArgsSize, bool AIsGet);
	
public:
	__fastcall TLMDMetatypeWrapper(TLMDTypeWrapperClass AType);
	__fastcall virtual ~TLMDMetatypeWrapper(void);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPredTypeWrapper : public TLMDTypeWrapper
{
	typedef TLMDTypeWrapper inherited;
	
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual TLMDPredTypeWrapper(void) : TLMDTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDPredTypeWrapper(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDPredTypeWrapperClass;

typedef System::TMetaClass* TLMDClassWrapperClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDClassWrapperData : public TLMDTypeWrapperData
{
	typedef TLMDTypeWrapperData inherited;
	
private:
	System::Classes::TStrings* FRedecls;
	bool __fastcall HasRedecls(void);
	System::Classes::TStrings* __fastcall GetRedecls(void);
	
public:
	__fastcall virtual TLMDClassWrapperData(TLMDWrapperClass AWrapperClass);
	__fastcall virtual ~TLMDClassWrapperData(void);
	void __fastcall AddConstant(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDTypeWrapperClass AType, System::Word AVarType = (System::Word)(0x0));
	void __fastcall AddField(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDTypeWrapperClass AType);
	void __fastcall AddClassField(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDTypeWrapperClass AType);
	void __fastcall AddConstructor(const System::WideString AName, TLMDInvokeProc AInvokeProc, int AParamsCount, bool AHasOptionalParams = false);
	void __fastcall AddProcedure(const System::WideString AName, TLMDInvokeProc AInvokeProc, int AParamsCount, bool AHasOptionalParams = false);
	void __fastcall AddFunction(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDTypeWrapperClass AResultType, int AParamsCount, bool AHasOptionalParams = false);
	void __fastcall AddClassProcedure(const System::WideString AName, TLMDInvokeProc AInvokeProc, int AParamsCount, bool AHasOptionalParams = false);
	void __fastcall AddClassFunction(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDTypeWrapperClass AResultType, int AParamsCount, bool AHasOptionalParams = false);
	void __fastcall AddProperty(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDTypeWrapperClass AType, bool AIsReadable, bool AIsWritable, int AParamsCount, bool AIsProtected = false, bool AIsDefault = false);
	void __fastcall AddClassProperty(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDTypeWrapperClass AType, bool AIsReadable, bool AIsWritable, int AParamsCount, bool AIsProtected = false);
	void __fastcall AddPropertyRedecl(const System::WideString AName, bool AIsDefault = false);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDClassWrapper : public TLMDTypeWrapper
{
	typedef TLMDTypeWrapper inherited;
	
private:
	System::TObject* FValue;
	__classmethod virtual TLMDWrapperDataClass __fastcall GetDataClass();
	__classmethod virtual void __fastcall InitData(TLMDWrapperData* AData);
	virtual System::OleVariant __fastcall LowInvoke(TLMDInvokeItem* AItem, const TLMDDispArgs &AArgs, int AArgsSize, bool AIsGet);
	__classmethod virtual System::OleVariant __fastcall LowMetaInvoke(TLMDInvokeItem* AItem, const TLMDDispArgs &AArgs, int AArgsSize, bool AIsGet);
	
protected:
	__classmethod System::OleVariant __fastcall ConvToVar(System::TObject* AObject);
	__classmethod System::TObject* __fastcall ConvFromVar(const System::OleVariant &AObject, System::TClass AReqClass = 0x0);
	__classmethod System::OleVariant __fastcall ConvClsToVar(System::TClass AClass);
	__classmethod System::TClass __fastcall ConvClsFromVar(const System::OleVariant &AClass, System::TClass AReqMetaclass = 0x0);
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	__classmethod virtual System::TClass __fastcall GetWrappedClass();
	__classmethod virtual void __fastcall DoInit(TLMDClassWrapperData* AData);
	
public:
	__fastcall virtual TLMDClassWrapper(System::TObject* AValue);
	__fastcall virtual ~TLMDClassWrapper(void);
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDMetaclassWrapperClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMetaclassWrapper : public TLMDTypeWrapper
{
	typedef TLMDTypeWrapper inherited;
	
private:
	__classmethod virtual System::OleVariant __fastcall TypeToVariant();
	
protected:
	__classmethod System::OleVariant __fastcall ConvToVar(System::TClass AClass);
	__classmethod System::TClass __fastcall ConvFromVar(const System::OleVariant &AClass, System::TClass AReqMetaclass = 0x0);
	__classmethod virtual System::Word __fastcall GetVarType();
	__classmethod virtual System::TClass __fastcall GetWrappedBaseClass();
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual TLMDMetaclassWrapper(void) : TLMDTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDMetaclassWrapper(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDRecordWrapperClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRecordWrapperData : public TLMDTypeWrapperData
{
	typedef TLMDTypeWrapperData inherited;
	
public:
	void __fastcall AddConstant(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDTypeWrapperClass AType, System::Word AVarType = (System::Word)(0x0));
	void __fastcall AddField(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDTypeWrapperClass AType);
	void __fastcall AddClassField(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDTypeWrapperClass AType);
	void __fastcall AddConstructor(const System::WideString AName, TLMDInvokeProc AInvokeProc, int AParamsCount, bool AHasOptionalParams = false);
	void __fastcall AddProcedure(const System::WideString AName, TLMDInvokeProc AInvokeProc, int AParamsCount, bool AHasOptionalParams = false);
	void __fastcall AddFunction(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDTypeWrapperClass AResultType, int AParamsCount, bool AHasOptionalParams = false);
	void __fastcall AddClassProcedure(const System::WideString AName, TLMDInvokeProc AInvokeProc, int AParamsCount, bool AHasOptionalParams = false);
	void __fastcall AddClassFunction(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDTypeWrapperClass AResultType, int AParamsCount, bool AHasOptionalParams = false);
	void __fastcall AddProperty(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDTypeWrapperClass AType, bool AIsReadable, bool AIsWritable, int AParamsCount, bool AIsProtected = false, bool AIsDefault = false);
	void __fastcall AddClassProperty(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDTypeWrapperClass AType, bool AIsReadable, bool AIsWritable, int AParamsCount, bool AIsProtected = false);
public:
	/* TLMDDispWrapperData.Create */ inline __fastcall virtual TLMDRecordWrapperData(TLMDWrapperClass AWrapperClass) : TLMDTypeWrapperData(AWrapperClass) { }
	/* TLMDDispWrapperData.Destroy */ inline __fastcall virtual ~TLMDRecordWrapperData(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRecordWrapper : public TLMDTypeWrapper
{
	typedef TLMDTypeWrapper inherited;
	
private:
	__classmethod virtual TLMDWrapperDataClass __fastcall GetDataClass();
	__classmethod virtual void __fastcall InitData(TLMDWrapperData* AData);
	virtual System::OleVariant __fastcall LowInvoke(TLMDInvokeItem* AItem, const TLMDDispArgs &AArgs, int AArgsSize, bool AIsGet);
	__classmethod virtual System::OleVariant __fastcall LowMetaInvoke(TLMDInvokeItem* AItem, const TLMDDispArgs &AArgs, int AArgsSize, bool AIsGet);
	
protected:
	__classmethod System::OleVariant __fastcall ConvToVar(TLMDRecordWrapper* wrpr);
	__classmethod TLMDRecordWrapper* __fastcall ConvFromVar(const System::OleVariant &ARecord);
	__classmethod virtual System::Word __fastcall GetVarType();
	virtual TLMDRecordWrapper* __fastcall CloneVal(void);
	__classmethod virtual void __fastcall DoInit(TLMDRecordWrapperData* AData);
	
public:
	__fastcall virtual TLMDRecordWrapper(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRecordWrapper(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDEnumWrapperClass;

typedef TLMDEnumerator *PLMDEnumerator;

struct DECLSPEC_DRECORD TLMDEnumerator
{
public:
	System::UnicodeString Name;
	int Value;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEnumWrapper : public TLMDTypeWrapper
{
	typedef TLMDTypeWrapper inherited;
	
private:
	__classmethod void __fastcall RegisterEnumerators(TLMDWrapperData* AUnitData);
	
protected:
	__classmethod virtual System::Typinfo::PTypeInfo __fastcall GetEnumTypeInfo();
	__classmethod virtual void __fastcall GetEnumerators(/* out */ PLMDEnumerator &AEnums, /* out */ int &ACount);
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual TLMDEnumWrapper(void) : TLMDTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDEnumWrapper(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDSetWrapperClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSetWrapper : public TLMDTypeWrapper
{
	typedef TLMDTypeWrapper inherited;
	
protected:
	__classmethod System::OleVariant __fastcall ConvToVar(void * ASetPtr);
	__classmethod void __fastcall ConvFromVar(const System::OleVariant &ASet, void * AResPtr);
	__classmethod virtual System::Word __fastcall GetVarType();
	__classmethod virtual int __fastcall GetSetSizeOf();
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual TLMDSetWrapper(void) : TLMDTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDSetWrapper(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDSubrangeWrapperClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSubrangeWrapper : public TLMDTypeWrapper
{
	typedef TLMDTypeWrapper inherited;
	
protected:
	__classmethod virtual System::Word __fastcall GetVarType();
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual TLMDSubrangeWrapper(void) : TLMDTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDSubrangeWrapper(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDEventWrapperClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDScriptHandlerWrapper : public TLMDDispWrapper
{
	typedef TLMDDispWrapper inherited;
	
private:
	System::TObject* FScriptControl;
	System::WideString FProcName;
	
public:
	__fastcall TLMDScriptHandlerWrapper(System::TObject* AScriptControl, const System::WideString AProcName);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDScriptHandlerWrapper(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEventWrapper : public TLMDTypeWrapper
{
	typedef TLMDTypeWrapper inherited;
	
private:
	System::TMethod FValue;
	
protected:
	__classmethod System::OleVariant __fastcall ConvToVar(const System::TMethod &AEvent);
	__classmethod System::OleVariant __fastcall ConvToVarS(System::TObject* AScriptControl, const System::WideString AProcName);
	__classmethod System::TMethod __fastcall ConvFromVar(const System::OleVariant &AEvent);
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__fastcall virtual TLMDEventWrapper(const System::TMethod &AValue);
	__classmethod virtual System::TClass __fastcall GetScriptHandlerClass();
	__classmethod System::OleVariant __fastcall ToVar(System::TObject* AScriptControl, const System::WideString AProcName);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDEventWrapper(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDUnitWrapperClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUnitEnumerators : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int operator[](int AIndex) { return this->Values[AIndex]; }
	
private:
	int FCount;
	Lmdtypes::TLMDIntArray FValues;
	int __fastcall GetValues(int AIndex);
	
public:
	__fastcall TLMDUnitEnumerators(void);
	__fastcall virtual ~TLMDUnitEnumerators(void);
	void __fastcall Clear(void);
	void __fastcall Add(int AValue);
	__property int Count = {read=FCount, nodefault};
	__property int Values[int AIndex] = {read=GetValues/*, default*/};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUnitWrapperData : public TLMDDispWrapperData
{
	typedef TLMDDispWrapperData inherited;
	
private:
	System::Classes::TList* FFoundEnums;
	TLMDUnitEnumerators* FEnumerators;
	int FNonEnumCount;
	void __fastcall RegisterEnumerator(const System::WideString AName, TLMDTypeWrapperClass AType, int AValue);
	void __fastcall EnumFound(TLMDEnumWrapperClass AWrapperClass);
	void __fastcall PostprocessEnums(void);
	
public:
	__fastcall virtual TLMDUnitWrapperData(TLMDWrapperClass AWrapperClass);
	__fastcall virtual ~TLMDUnitWrapperData(void);
	void __fastcall AddConstant(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDTypeWrapperClass AType, System::Word AVarType = (System::Word)(0x0));
	void __fastcall AddVariable(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDTypeWrapperClass AType);
	void __fastcall AddProcedure(const System::WideString AName, TLMDInvokeProc AInvokeProc, int AParamsCount, bool AHasOptionalParams = false);
	void __fastcall AddFunction(const System::WideString AName, TLMDInvokeProc AInvokeProc, TLMDTypeWrapperClass AResultType, int AParamsCount, bool AHasOptionalParams = false);
	void __fastcall AddType(TLMDTypeWrapperClass AWrapperClass, TLMDInvokeProc AInvokeProc);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUnitWrapper : public TLMDDispWrapper
{
	typedef TLMDDispWrapper inherited;
	
private:
	System::TObject* FScriptControl;
	__classmethod virtual TLMDWrapperDataClass __fastcall GetDataClass();
	__classmethod virtual void __fastcall InitData(TLMDWrapperData* AData);
	virtual System::OleVariant __fastcall LowInvoke(TLMDInvokeItem* AItem, const TLMDDispArgs &AArgs, int AArgsSize, bool AIsGet);
	
protected:
	__classmethod System::OleVariant __fastcall ConvToVar(TLMDTypeWrapperClass AWrapperClass);
	__classmethod TLMDTypeWrapperClass __fastcall ConvFromVar(const System::OleVariant &AType, bool AAllowNil);
	__classmethod virtual void __fastcall DoInit(TLMDUnitWrapperData* AData);
	
public:
	__fastcall virtual TLMDUnitWrapper(System::TObject* AScriptControl);
	__classmethod virtual System::WideString __fastcall GetUnitName();
	__classmethod System::OleVariant __fastcall TypeToVar(TLMDTypeWrapperClass AWrapperClass);
	__property System::TObject* ScriptControl = {read=FScriptControl};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDUnitWrapper(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall RegisterUnitWrapper(TLMDUnitWrapperClass AWrapperClass);
extern DELPHI_PACKAGE System::Classes::TList* __fastcall GetUnitWrapperClassList(void);
extern DELPHI_PACKAGE void __fastcall RegisterClassWrapper(TLMDClassWrapperClass AWrapperClass);
extern DELPHI_PACKAGE void __fastcall RegisterEventWrapper(System::Typinfo::PTypeInfo AEventType, TLMDEventWrapperClass AWrapperClass);
extern DELPHI_PACKAGE TLMDEventWrapperClass __fastcall GetEventWrapperClass(System::Typinfo::PTypeInfo AEventType);
extern DELPHI_PACKAGE System::OleVariant __fastcall MakeVarRef(System::OleVariant &RefToVar);
extern DELPHI_PACKAGE void __fastcall AssignRefParam(const System::OleVariant &ARefParam, const System::OleVariant &AValue);
extern DELPHI_PACKAGE void __fastcall WrongArgCountError(Lmdtypes::TLMDString AMethodName)/* overload */;
extern DELPHI_PACKAGE void __fastcall WrongArgCountError(int AIdx, TLMDDispWrapper* AWrap)/* overload */;
extern DELPHI_PACKAGE System::OleVariant __fastcall VarObjectIs(const System::OleVariant &AObject, const System::OleVariant &AClass)/* overload */;
extern DELPHI_PACKAGE System::OleVariant __fastcall VarObjectIs(System::TObject* AObject, const System::OleVariant &AClass)/* overload */;
extern DELPHI_PACKAGE System::OleVariant __fastcall LMDVarNil(void);
extern DELPHI_PACKAGE System::OleVariant __fastcall VarRecIs(const System::OleVariant &ARecord, const System::OleVariant &ARecType);
extern DELPHI_PACKAGE System::OleVariant __fastcall VarRecNew(const System::OleVariant &ARecType)/* overload */;
extern DELPHI_PACKAGE System::OleVariant __fastcall VarRecNew(const TLMDRecordWrapperClass ARecType)/* overload */;
extern DELPHI_PACKAGE System::OleVariant __fastcall VarRecCopy(const System::OleVariant &ARecord)/* overload */;
extern DELPHI_PACKAGE System::OleVariant __fastcall VarRecCopy(TLMDRecordWrapper* const ARecord)/* overload */;
extern DELPHI_PACKAGE System::OleVariant __fastcall VarObjOrRecIs(const System::OleVariant &AVal, const System::OleVariant &AType);
extern DELPHI_PACKAGE System::OleVariant __fastcall VarObjOrRecNew(const System::OleVariant &AType, Lmdsctclass::PLMDVarArray AArgs, int AArgCount);
extern DELPHI_PACKAGE System::OleVariant __fastcall VarSetEmpty(void);
extern DELPHI_PACKAGE System::OleVariant __fastcall VarSetInclude(const System::OleVariant &ASet, const System::OleVariant &AElem);
extern DELPHI_PACKAGE System::OleVariant __fastcall VarSetExclude(const System::OleVariant &ASet, const System::OleVariant &AElem);
extern DELPHI_PACKAGE System::OleVariant __fastcall VarSetIn(const System::OleVariant &AElem, const System::OleVariant &ASet);
extern DELPHI_PACKAGE System::OleVariant __fastcall VarSetMake(const TLMDDispArgs &AElems, int AElemsSize);
extern DELPHI_PACKAGE System::OleVariant __fastcall LMDSetToVar(int ASizeOf, const void *ASet);
}	/* namespace Lmdsctwrappers */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTWRAPPERS)
using namespace Lmdsctwrappers;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctwrappersHPP
