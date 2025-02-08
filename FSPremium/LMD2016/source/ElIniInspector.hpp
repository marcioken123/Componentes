// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElIniInspector.pas' rev: 31.00 (Windows)

#ifndef EliniinspectorHPP
#define EliniinspectorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.TypInfo.hpp>
#include <LMDTypes.hpp>
#include <LMDElConst.hpp>
#include <ElIni.hpp>
#include <ElInspector.hpp>
#include <LMDUnicodeStrings.hpp>
#include <ElStack.hpp>
#include <ElVCLUtils.hpp>
#include <LMDObjectList.hpp>
#include <LMDStrings.hpp>
#include <ElInspectorEditors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eliniinspector
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElInspectorValueType;
class DELPHICLASS TElIniData;
class DELPHICLASS TElUnknowData;
class DELPHICLASS TElBooleanData;
class DELPHICLASS TElFloatData;
class DELPHICLASS TElStringData;
class DELPHICLASS TElMultiStringData;
class DELPHICLASS TElIntegerData;
class DELPHICLASS TElIniClassesList;
class DELPHICLASS TElIniEnumerator;
class DELPHICLASS TElInspectorIniDataSource;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TElInspectorValueType : public Elinspector::TElInspectorRegister
{
	typedef Elinspector::TElInspectorRegister inherited;
	
protected:
	Elini::TElValueType FValueType;
	
public:
	__fastcall TElInspectorValueType(const Elinspector::TElClassInplaceEditor AClass, const Elinspector::TElClassInspectorData AInspData, const Elini::TElValueType AValueType);
	__property Elini::TElValueType ValueType = {read=FValueType, write=FValueType, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElInspectorValueType(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElIniData : public Elinspector::TElInspectorData
{
	typedef Elinspector::TElInspectorData inherited;
	
private:
	Elini::TElValueType __fastcall GetValueType(void);
	
protected:
	Elini::TElIniFile* FIniFile;
	Lmdtypes::TLMDString FValueName;
	Lmdtypes::TLMDString FKey;
	int FCategoryIndex;
	Elini::TElValueType FValueType;
	virtual bool __fastcall GetIsEnumerable(void);
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall GetName(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value) = 0 ;
	virtual bool __fastcall GetIsComplex(void);
	
public:
	bool __fastcall CheckNotReadOnly(void);
	virtual int __fastcall GetValuesList(System::Classes::TStrings* const AList);
	__property Elini::TElValueType ValueType = {read=GetValueType, nodefault};
	__property int Category = {read=FCategoryIndex, nodefault};
	__property Lmdtypes::TLMDString Name = {read=GetName};
	__property Lmdtypes::TLMDString Value = {read=GetAsString, write=SetAsString};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElIniData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElIniData(void) : Elinspector::TElInspectorData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElUnknowData : public TElIniData
{
	typedef TElIniData inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElUnknowData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElUnknowData(void) : TElIniData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElBooleanData : public TElIniData
{
	typedef TElIniData inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
	virtual void __fastcall SetAsBoolean(bool Value);
	virtual bool __fastcall GetAsBoolean(void);
	virtual bool __fastcall GetIsEnumerable(void);
	virtual int __fastcall GetMaxValue(void);
	virtual int __fastcall GetMinValue(void);
	
public:
	virtual int __fastcall GetValuesList(System::Classes::TStrings* const AList);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElBooleanData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElBooleanData(void) : TElIniData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElFloatData : public TElIniData
{
	typedef TElIniData inherited;
	
protected:
	virtual void __fastcall SetAsFloat(double Value);
	virtual double __fastcall GetAsFloat(void);
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElFloatData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElFloatData(void) : TElIniData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElStringData : public TElIniData
{
	typedef TElIniData inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElStringData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElStringData(void) : TElIniData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElMultiStringData : public TElIniData
{
	typedef TElIniData inherited;
	
protected:
	System::Classes::TStrings* FCache;
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
	virtual System::TObject* __fastcall GetAsObject(void);
	virtual void __fastcall SetAsObject(System::TObject* Value);
	
public:
	__fastcall virtual ~TElMultiStringData(void);
	virtual void __fastcall AfterConstruction(void);
public:
	/* TObject.Create */ inline __fastcall TElMultiStringData(void) : TElIniData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElIntegerData : public TElIniData
{
	typedef TElIniData inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
	virtual int __fastcall GetAsInteger(void);
	virtual void __fastcall SetAsInteger(int Value);
	virtual int __fastcall GetMaxValue(void);
	virtual int __fastcall GetMinValue(void);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElIntegerData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElIntegerData(void) : TElIniData() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElIniClassesList : public Elinspector::TElInspectorClassesList
{
	typedef Elinspector::TElInspectorClassesList inherited;
	
protected:
	TElInspectorValueType* __fastcall FindItemByValueType(const Elini::TElValueType AValueType);
	
public:
	HIDESBASE Elinspector::TElInspectorRegister* __fastcall GetNeededData(const Elini::TElValueType AValueType);
	virtual Elinspector::TElInspectorRegister* __fastcall GetNeededEditor(Elinspector::TElInspectorItem* const AItem);
public:
	/* TLMDObjectList.Create */ inline __fastcall TElIniClassesList(void) : Elinspector::TElInspectorClassesList() { }
	/* TLMDObjectList.Destroy */ inline __fastcall virtual ~TElIniClassesList(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElIniEnumerator : public Elinspector::TElEnumerator
{
	typedef Elinspector::TElEnumerator inherited;
	
protected:
	int FCurrentKey;
	int FCurrentValue;
	System::Classes::TStrings* FStrings;
	System::Classes::TStrings* FValues;
	
public:
	__fastcall TElIniEnumerator(Elinspector::TElInspectorDataSource* AOwner);
	__fastcall virtual ~TElIniEnumerator(void);
	virtual Elinspector::TElInspectorData* __fastcall GetFirstItem(void);
	virtual Elinspector::TElInspectorData* __fastcall GetNextItem(void);
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElInspectorIniDataSource : public Elinspector::TElInspectorDataSource
{
	typedef Elinspector::TElInspectorDataSource inherited;
	
protected:
	Elini::TElIniFile* FIniFile;
	Elinspector::TElCategories* FCategories;
	Elinspector::TElInspectorClassesList* FElRegClass;
	System::Classes::TStringList* FSubKeys;
	virtual Elinspector::TElCategories* __fastcall GetCategories(void);
	virtual Elinspector::TElInspectorClassesList* __fastcall GetRegClass(void);
	virtual void __fastcall SetCategories(Elinspector::TElCategories* const Value);
	void __fastcall SetInspector(Elinspector::TElInspector* const Value);
	void __fastcall SetIniFile(Elini::TElIniFile* const Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall NeedCategory(System::TObject* Sender, Elinspector::TElInspectorData* AItem, int &AIndex);
	
public:
	__fastcall virtual TElInspectorIniDataSource(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElInspectorIniDataSource(void);
	virtual void __fastcall ClearItemIndex(void);
	virtual Elinspector::TElEnumerator* __fastcall CreateEnumerator(Elinspector::TElInspectorData* Item);
	virtual void __fastcall DestroyEnumerator(Elinspector::TElEnumerator* AEnum);
	__property Elinspector::TElInspectorClassesList* RegisterList = {read=GetRegClass};
	__property Elinspector::TElCategories* Categories = {read=GetCategories, write=SetCategories};
	
__published:
	__property Elini::TElIniFile* IniFile = {read=FIniFile, write=SetIniFile};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eliniinspector */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELINIINSPECTOR)
using namespace Eliniinspector;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EliniinspectorHPP
