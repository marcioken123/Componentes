// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElRTTIInspector.pas' rev: 31.00 (Windows)

#ifndef ElrttiinspectorHPP
#define ElrttiinspectorHPP

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
#include <System.TypInfo.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDTypes.hpp>
#include <LMDElConst.hpp>
#include <ElInspector.hpp>
#include <LMDUnicodeStrings.hpp>
#include <ElStack.hpp>
#include <ElVCLUtils.hpp>
#include <LMDObjectList.hpp>
#include <ElPropTools.hpp>
#include <ElInspectorEditors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elrttiinspector
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElInspectorProp;
class DELPHICLASS TElInspectorInherits;
class DELPHICLASS TElInspectorTypeKind;
class DELPHICLASS TElInspectorTypeInfo;
class DELPHICLASS TElRTTIClassList;
class DELPHICLASS TElRTTIClassEnumerator;
class DELPHICLASS TElRTTISetEnumerator;
class DELPHICLASS TElInspectorRTTIDataSource;
class DELPHICLASS TElPropertyData;
class DELPHICLASS TElUnknowProperty;
class DELPHICLASS TElOrdProperty;
class DELPHICLASS TElEnumProperty;
class DELPHICLASS TElBooleanProperty;
class DELPHICLASS TElCharProperty;
class DELPHICLASS TElClassProperty;
class DELPHICLASS TElComponentProperty;
class DELPHICLASS TElFontProperty;
class DELPHICLASS TElInt64Property;
class DELPHICLASS TElStringProperty;
class DELPHICLASS TElWideStringProperty;
class DELPHICLASS TElCaptionProperty;
class DELPHICLASS TElIntegerProperty;
class DELPHICLASS TElColorProperty;
class DELPHICLASS TElFloatProperty;
class DELPHICLASS TElCharsetProperty;
class DELPHICLASS TElCursorProperty;
class DELPHICLASS TElSetProperty;
class DELPHICLASS TElSetElementProperty;
class DELPHICLASS TElMethodProperty;
class DELPHICLASS TElIdentProperty;
class DELPHICLASS TSetElement;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElTypeKinds : unsigned char { etkProperties, etkMethods, etkAny };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElInspectorProp : public Elinspector::TElInspectorRegister
{
	typedef Elinspector::TElInspectorRegister inherited;
	
protected:
	System::UnicodeString FName;
	System::TClass FParentClass;
	System::Typinfo::TTypeInfo *FTypeInfo;
	
public:
	__fastcall TElInspectorProp(const Elinspector::TElClassInplaceEditor AClass, const Elinspector::TElClassInspectorData AInspData, const System::TClass AParentClass, const System::UnicodeString AName, const System::Typinfo::PTypeInfo ATypeInfo);
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property System::TClass ParentClass = {read=FParentClass, write=FParentClass};
	__property System::Typinfo::PTypeInfo TypeInfo = {read=FTypeInfo, write=FTypeInfo};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElInspectorProp(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElInspectorInherits : public Elinspector::TElInspectorRegister
{
	typedef Elinspector::TElInspectorRegister inherited;
	
protected:
	System::TClass FParentClass;
	
public:
	__fastcall TElInspectorInherits(const Elinspector::TElClassInplaceEditor AClass, const Elinspector::TElClassInspectorData AInspData, const System::TClass AParent);
	__property System::TClass ParentClass = {read=FParentClass, write=FParentClass};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElInspectorInherits(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElInspectorTypeKind : public Elinspector::TElInspectorRegister
{
	typedef Elinspector::TElInspectorRegister inherited;
	
protected:
	System::TTypeKind FTypeKind;
	
public:
	__fastcall TElInspectorTypeKind(const Elinspector::TElClassInplaceEditor AClass, const Elinspector::TElClassInspectorData AInspData, const System::TTypeKind ATypeKind);
	__property System::TTypeKind TypeKind = {read=FTypeKind, write=FTypeKind, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElInspectorTypeKind(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElInspectorTypeInfo : public Elinspector::TElInspectorRegister
{
	typedef Elinspector::TElInspectorRegister inherited;
	
protected:
	System::Typinfo::TTypeInfo *FTypeInfo;
	
public:
	__fastcall TElInspectorTypeInfo(const Elinspector::TElClassInplaceEditor AClass, const Elinspector::TElClassInspectorData AInspData, const System::Typinfo::PTypeInfo ATypeinfo);
	__property System::Typinfo::PTypeInfo TypeInfo = {read=FTypeInfo, write=FTypeInfo};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElInspectorTypeInfo(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElRTTIClassList : public Elinspector::TElInspectorClassesList
{
	typedef Elinspector::TElInspectorClassesList inherited;
	
public:
	HIDESBASE Elinspector::TElInspectorRegister* __fastcall GetNeededData(const System::Typinfo::PPropInfo PropInfo);
	virtual Elinspector::TElInspectorRegister* __fastcall GetNeededEditor(Elinspector::TElInspectorItem* const AItem);
public:
	/* TLMDObjectList.Create */ inline __fastcall TElRTTIClassList(void) : Elinspector::TElInspectorClassesList() { }
	/* TLMDObjectList.Destroy */ inline __fastcall virtual ~TElRTTIClassList(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElRTTIClassEnumerator : public Elinspector::TElEnumerator
{
	typedef Elinspector::TElEnumerator inherited;
	
protected:
	int FCurrent;
	System::TObject* FInstance;
	int FPropCount;
	System::Typinfo::TPropList *FPropList;
	System::Typinfo::TTypeKinds FTypeKinds;
	
public:
	__fastcall TElRTTIClassEnumerator(void);
	virtual Elinspector::TElInspectorData* __fastcall GetFirstItem(void);
	virtual Elinspector::TElInspectorData* __fastcall GetNextItem(void);
	__property System::TObject* Instance = {read=FInstance, write=FInstance};
	__property System::Typinfo::TTypeKinds TypeKinds = {read=FTypeKinds, write=FTypeKinds, default=4194046};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElRTTIClassEnumerator(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElRTTISetEnumerator : public Elinspector::TElEnumerator
{
	typedef Elinspector::TElEnumerator inherited;
	
protected:
	int FCurrent;
	System::TObject* FInstance;
	TElSetProperty* FParentSet;
	
public:
	virtual Elinspector::TElInspectorData* __fastcall GetFirstItem(void);
	virtual Elinspector::TElInspectorData* __fastcall GetNextItem(void);
	__property System::TObject* Instance = {read=FInstance, write=FInstance};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElRTTISetEnumerator(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElRTTISetEnumerator(void) : Elinspector::TElEnumerator() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElInspectorRTTIDataSource : public Elinspector::TElInspectorDataSource
{
	typedef Elinspector::TElInspectorDataSource inherited;
	
protected:
	Elinspector::TElCategories* FCategories;
	Elinspector::TElInspectorClassesList* FElRegClass;
	System::Classes::TComponent* FInstance;
	System::TObject* FObjectInstance;
	Elstack::TElStack* FStack;
	System::Typinfo::TTypeKinds FTypeKinds;
	Lmdobjectlist::TLMDObjectList* FTreeList;
	TElTypeKinds FElTypeKinds;
	virtual Elinspector::TElCategories* __fastcall GetCategories(void);
	virtual Elinspector::TElInspectorClassesList* __fastcall GetRegClass(void);
	bool __fastcall IsInStack(System::TObject* AInstance);
	System::TObject* __fastcall PopInstance(void);
	void __fastcall SetElTypeKind(const TElTypeKinds Value);
	void __fastcall PushInstance(System::TObject* AInstance);
	virtual void __fastcall SetCategories(Elinspector::TElCategories* const Value);
	void __fastcall SetInspector(Elinspector::TElInspector* const Value);
	void __fastcall SetInstance(System::Classes::TComponent* const Value);
	void __fastcall SetObjectInstance(System::TObject* const Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TElInspectorRTTIDataSource(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElInspectorRTTIDataSource(void);
	virtual void __fastcall ClearItemIndex(void);
	virtual Elinspector::TElEnumerator* __fastcall CreateEnumerator(Elinspector::TElInspectorData* Item);
	virtual void __fastcall DestroyEnumerator(Elinspector::TElEnumerator* AEnum);
	__property Elinspector::TElInspectorClassesList* RegisterList = {read=GetRegClass};
	__property System::Typinfo::TTypeKinds TypeKinds = {read=FTypeKinds, write=FTypeKinds, nodefault};
	__property System::TObject* ObjectInstance = {read=FObjectInstance, write=SetObjectInstance};
	
__published:
	__property Categories;
	__property System::Classes::TComponent* Instance = {read=FInstance, write=SetInstance};
	__property TElTypeKinds ElTypeKinds = {read=FElTypeKinds, write=SetElTypeKind, nodefault};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElPropertyData : public Elinspector::TElInspectorData
{
	typedef Elinspector::TElInspectorData inherited;
	
protected:
	Lmdtypes::TLMDString FDisplayName;
	System::TObject* FInstance;
	Lmdtypes::TLMDString FName;
	System::Typinfo::TPropInfo *FPropertyInfo;
	Lmdtypes::TLMDString FValue;
	virtual int __fastcall GetAsOrd(void);
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void) = 0 ;
	virtual bool __fastcall GetIsDefault(void);
	virtual bool __fastcall GetIsReadOnly(void);
	virtual Lmdtypes::TLMDString __fastcall GetName(void);
	System::Typinfo::PTypeInfo __fastcall GetPropertyType(void);
	System::TTypeKind __fastcall GetTypeKind(void);
	virtual void __fastcall SetAsOrd(int Value);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value) = 0 ;
	
public:
	bool __fastcall CheckNotReadOnly(void);
	virtual int __fastcall GetValuesList(System::Classes::TStrings* const AList);
	__property bool AsBoolean = {read=GetAsBoolean, write=SetAsBoolean, nodefault};
	__property System::TDateTime AsDateTime = {read=GetAsDateTime, write=SetAsDateTime};
	__property double AsFloat = {read=GetAsFloat, write=SetAsFloat};
	__property __int64 AsInt64 = {read=GetAsInt64, write=SetAsInt64};
	__property int AsInteger = {read=GetAsInteger, write=SetAsInteger, nodefault};
	__property System::TMethod AsMethod = {read=GetAsMethod, write=SetAsMethod};
	__property System::TObject* AsObject = {read=GetAsObject, write=SetAsObject};
	__property Lmdtypes::TLMDString AsString = {read=GetAsString, write=SetAsString};
	__property System::Variant AsVariant = {read=GetAsVariant, write=SetAsVariant};
	__property Lmdtypes::TLMDString DisplayName = {read=GetDisplayName, write=SetDisplayName};
	__property System::TObject* Instance = {read=FInstance, write=FInstance};
	__property bool IsComplex = {read=GetIsComplex, nodefault};
	__property bool IsDefault = {read=GetIsDefault, nodefault};
	__property bool IsEnumerable = {read=GetIsEnumerable, nodefault};
	__property bool IsReadOnly = {read=GetIsReadOnly, nodefault};
	__property int MaxValue = {read=GetMaxValue, nodefault};
	__property int MinValue = {read=GetMinValue, nodefault};
	__property Lmdtypes::TLMDString Name = {read=GetName};
	__property System::Typinfo::PPropInfo PropertyInfo = {read=FPropertyInfo, write=FPropertyInfo};
	__property System::Typinfo::PTypeInfo PropertyType = {read=GetPropertyType};
	__property Lmdtypes::TLMDString Value = {read=GetAsString, write=SetAsString};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElPropertyData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElPropertyData(void) : Elinspector::TElInspectorData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElUnknowProperty : public TElPropertyData
{
	typedef TElPropertyData inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElUnknowProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElUnknowProperty(void) : TElPropertyData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElOrdProperty : public TElPropertyData
{
	typedef TElPropertyData inherited;
	
protected:
	virtual int __fastcall GetAsOrd(void);
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual int __fastcall GetMaxValue(void);
	virtual int __fastcall GetMinValue(void);
	virtual void __fastcall SetAsOrd(int Value);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElOrdProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElOrdProperty(void) : TElPropertyData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElEnumProperty : public TElOrdProperty
{
	typedef TElOrdProperty inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual bool __fastcall GetIsEnumerable(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
	
public:
	virtual int __fastcall GetValuesList(System::Classes::TStrings* const AList);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElEnumProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElEnumProperty(void) : TElOrdProperty() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElBooleanProperty : public TElEnumProperty
{
	typedef TElEnumProperty inherited;
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElBooleanProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElBooleanProperty(void) : TElEnumProperty() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElCharProperty : public TElOrdProperty
{
	typedef TElOrdProperty inherited;
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElCharProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElCharProperty(void) : TElOrdProperty() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElClassProperty : public TElPropertyData
{
	typedef TElPropertyData inherited;
	
protected:
	virtual System::TObject* __fastcall GetAsObject(void);
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual bool __fastcall GetIsComplex(void);
	virtual void __fastcall SetAsObject(System::TObject* Value);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElClassProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElClassProperty(void) : TElPropertyData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElComponentProperty : public TElClassProperty
{
	typedef TElClassProperty inherited;
	
protected:
	virtual bool __fastcall GetIsComplex(void);
	virtual bool __fastcall GetIsEnumerable(void);
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual bool __fastcall GetIsReference(void);
	virtual void __fastcall SetAsObject(System::TObject* Value);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
	
public:
	virtual int __fastcall GetValuesList(System::Classes::TStrings* const AList);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElComponentProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElComponentProperty(void) : TElClassProperty() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElFontProperty : public TElClassProperty
{
	typedef TElClassProperty inherited;
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElFontProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElFontProperty(void) : TElClassProperty() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElInt64Property : public TElPropertyData
{
	typedef TElPropertyData inherited;
	
protected:
	virtual __int64 __fastcall GetAsInt64(void);
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsInt64(__int64 Value);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElInt64Property(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElInt64Property(void) : TElPropertyData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElStringProperty : public TElPropertyData
{
	typedef TElPropertyData inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElStringProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElStringProperty(void) : TElPropertyData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElWideStringProperty : public TElPropertyData
{
	typedef TElPropertyData inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElWideStringProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElWideStringProperty(void) : TElPropertyData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElCaptionProperty : public TElStringProperty
{
	typedef TElStringProperty inherited;
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElCaptionProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElCaptionProperty(void) : TElStringProperty() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElIntegerProperty : public TElOrdProperty
{
	typedef TElOrdProperty inherited;
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElIntegerProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElIntegerProperty(void) : TElOrdProperty() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElColorProperty : public TElIntegerProperty
{
	typedef TElIntegerProperty inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual bool __fastcall GetIsEnumerable(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
	
public:
	virtual int __fastcall GetValuesList(System::Classes::TStrings* const AList);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElColorProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElColorProperty(void) : TElIntegerProperty() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElFloatProperty : public TElPropertyData
{
	typedef TElPropertyData inherited;
	
protected:
	virtual double __fastcall GetAsFloat(void);
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsFloat(double Value);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElFloatProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElFloatProperty(void) : TElPropertyData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElCharsetProperty : public TElIntegerProperty
{
	typedef TElIntegerProperty inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual bool __fastcall GetIsEnumerable(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
	
public:
	virtual int __fastcall GetValuesList(System::Classes::TStrings* const AList);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElCharsetProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElCharsetProperty(void) : TElIntegerProperty() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElCursorProperty : public TElIntegerProperty
{
	typedef TElIntegerProperty inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual bool __fastcall GetIsEnumerable(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
	
public:
	virtual int __fastcall GetValuesList(System::Classes::TStrings* const AList);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElCursorProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElCursorProperty(void) : TElIntegerProperty() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElSetProperty : public TElOrdProperty
{
	typedef TElOrdProperty inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual bool __fastcall GetIsComplex(void);
	virtual int __fastcall GetMaxValue(void);
	virtual int __fastcall GetMinValue(void);
	System::Typinfo::PTypeInfo __fastcall GetTypeInfo(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElSetProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElSetProperty(void) : TElOrdProperty() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElSetElementProperty : public TElBooleanProperty
{
	typedef TElBooleanProperty inherited;
	
protected:
	TElSetProperty* FParentSet;
	int FSetIndex;
	virtual bool __fastcall GetAsBoolean(void);
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual Lmdtypes::TLMDString __fastcall GetName(void);
	System::Typinfo::PTypeInfo __fastcall GetTypeInfo(void);
	virtual void __fastcall SetAsBoolean(bool Value);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
	
public:
	virtual int __fastcall GetValuesList(System::Classes::TStrings* const AList);
	__property TElSetProperty* ParentSet = {read=FParentSet, write=FParentSet};
	__property int SetIndex = {read=FSetIndex, write=FSetIndex, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElSetElementProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElSetElementProperty(void) : TElBooleanProperty() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElMethodProperty : public TElPropertyData
{
	typedef TElPropertyData inherited;
	
protected:
	virtual System::TMethod __fastcall GetAsMethod(void);
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual bool __fastcall GetIsEnumerable(void);
	virtual void __fastcall SetAsMethod(const System::TMethod &Value);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
	
public:
	virtual int __fastcall GetValuesList(System::Classes::TStrings* const AList);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElMethodProperty(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElMethodProperty(void) : TElPropertyData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElIdentProperty : public TElIntegerProperty
{
	typedef TElIntegerProperty inherited;
	
protected:
	System::Classes::TIdentToInt FIdentToInt;
	System::Classes::TIntToIdent FIntToIdent;
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual bool __fastcall GetIsEnumerable(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
	
public:
	__fastcall TElIdentProperty(void);
	virtual int __fastcall GetValuesList(System::Classes::TStrings* const AList);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElIdentProperty(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TSetElement : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
public:
	System::Typinfo::TPropInfo *PropInfo;
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSetElement(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TSetElement(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elrttiinspector */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELRTTIINSPECTOR)
using namespace Elrttiinspector;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElrttiinspectorHPP
