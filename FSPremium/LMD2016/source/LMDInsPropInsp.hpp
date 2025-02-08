// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDInsPropInsp.pas' rev: 31.00 (Windows)

#ifndef LmdinspropinspHPP
#define LmdinspropinspHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Menus.hpp>
#include <System.Masks.hpp>
#include <System.RTLConsts.hpp>
#include <System.Variants.hpp>
#include <System.Types.hpp>
#include <intfLMDBase.hpp>
#include <LMDUnicode.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDTypes.hpp>
#include <LMDHashTable.hpp>
#include <LMDInsClass.hpp>
#include <LMDInsCst.hpp>
#include <LMDInsPropPage.hpp>
#include <LMDInsEditorUtils.hpp>
#include <LMDInsEditorWnds.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdinspropinsp
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDPropertyInspector;
class DELPHICLASS ELMDPropEditor;
class DELPHICLASS ILMDProperty;
struct TLMDPropEditorPropListItem;
struct TLMDPropertyInspectorEditorDescr;
class DELPHICLASS TLMDPropEditor;
class DELPHICLASS TLMDNestedPropEditor;
class DELPHICLASS TLMDPropertyInspectorPageItem;
class DELPHICLASS TLMDPropertyInspectorItem;
class DELPHICLASS TLMDPropertyInspectorItems;
class DELPHICLASS TLMDPropertyInspectorCategory;
class DELPHICLASS TLMDPropertyInspectorCategories;
class DELPHICLASS TLMDPropertyInspectorDefiner;
class DELPHICLASS TLMDPropertyInspectorDynValue;
class DELPHICLASS TLMDCustomPropertyInspector;
class DELPHICLASS TLMDSimplePropInspObjects;
class DELPHICLASS TLMDSimplePropInspector;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPropertyInspector : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPropertyInspector(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPropertyInspector(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPropertyInspector(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPropertyInspector(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPropertyInspector(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPropertyInspector(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPropertyInspector(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPropertyInspector(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPropertyInspector(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPropertyInspector(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPropertyInspector(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPropertyInspector(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPropertyInspector(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPropEditor : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDPropEditor(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDPropEditor(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPropEditor(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPropEditor(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPropEditor(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPropEditor(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPropEditor(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPropEditor(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPropEditor(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPropEditor(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPropEditor(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPropEditor(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPropEditor(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDPropEditorClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION ILMDProperty : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual Lmdtypes::TLMDString __fastcall Name(void) = 0 ;
	virtual System::Typinfo::PTypeInfo __fastcall PropType(void) = 0 ;
	virtual System::Typinfo::PPropInfo __fastcall RTTIPropInfo(void);
	virtual bool __fastcall IsReadable(void) = 0 ;
	virtual bool __fastcall IsWritable(void) = 0 ;
	virtual bool __fastcall IsDefaultValue(System::Classes::TPersistent* Instance) = 0 ;
	virtual System::Extended __fastcall GetFloatValue(System::Classes::TPersistent* Instance);
	virtual __int64 __fastcall GetInt64Value(System::Classes::TPersistent* Instance);
	virtual int __fastcall GetOrdValue(System::Classes::TPersistent* Instance);
	virtual System::UnicodeString __fastcall GetStrValue(System::Classes::TPersistent* Instance);
	virtual System::WideString __fastcall GetWideStrValue(System::Classes::TPersistent* Instance);
	virtual System::Variant __fastcall GetVariantValue(System::Classes::TPersistent* Instance);
	virtual System::TObject* __fastcall GetObjectValue(System::Classes::TPersistent* Instance);
	virtual void __fastcall SetFloatValue(System::Classes::TPersistent* Instance, System::Extended AValue);
	virtual void __fastcall SetInt64Value(System::Classes::TPersistent* Instance, __int64 AValue);
	virtual void __fastcall SetOrdValue(System::Classes::TPersistent* Instance, int AValue);
	virtual void __fastcall SetStrValue(System::Classes::TPersistent* Instance, const System::UnicodeString AValue);
	virtual void __fastcall SetWideStrValue(System::Classes::TPersistent* Instance, const System::WideString AValue);
	virtual void __fastcall SetVariantValue(System::Classes::TPersistent* Instance, const System::Variant &AValue);
	virtual void __fastcall SetObjectValue(System::Classes::TPersistent* Instance, System::TObject* AValue);
public:
	/* TObject.Create */ inline __fastcall ILMDProperty(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~ILMDProperty(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDPropAttr : unsigned char { praValueList, praSubProperties, praDialog, praMultiSelect, praSortList, praReadOnly, praVolatileSubProperties, praNotNestable, praAutoUpdate, praOwnerDrawValues, praComponentRef, praEditableByRef };

typedef System::Set<TLMDPropAttr, TLMDPropAttr::praValueList, TLMDPropAttr::praEditableByRef> TLMDPropAttrs;

struct DECLSPEC_DRECORD TLMDPropEditorPropListItem
{
public:
	System::Classes::TPersistent* Instance;
	ILMDProperty* PropInfo;
};


struct DECLSPEC_DRECORD TLMDPropertyInspectorEditorDescr
{
public:
	System::Typinfo::TTypeInfo *TypeInfo;
	System::TClass ObjectClass;
	Lmdtypes::TLMDString PropName;
	TLMDPropEditorClass EditorClass;
};


typedef System::StaticArray<TLMDPropEditorPropListItem, 1024> TLMDPropEditorPropList;

typedef TLMDPropEditorPropList *PLMDPropEditorPropList;

typedef void __fastcall (__closure *TLMDSetByRefProc)(System::Classes::TPersistent* AInstance, ILMDProperty* AProp, void * AData);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPropEditor : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDCustomPropertyInspector* FPropInsp;
	TLMDPropertyInspectorPageItem* FPageItem;
	TLMDPropEditorPropList *FPropList;
	bool FOwnPropList;
	int FPropCount;
	void *FTmpData;
	TLMDPropEditor* FParentObjEditor;
	Lmdtypes::TLMDString __fastcall DoGetValue(void);
	System::Typinfo::PTypeInfo __fastcall GetPropTypeInfo(void);
	
protected:
	void __fastcall Change(void);
	void __fastcall SetPropEntry(int AIndex, System::Classes::TPersistent* AInstance, ILMDProperty* APropInfo);
	virtual Lmdtypes::TLMDString __fastcall GetValue(void);
	virtual void __fastcall SetValue(const Lmdtypes::TLMDString Value);
	virtual TLMDPropAttrs __fastcall GetAttrs(void);
	virtual void __fastcall GetValues(System::Classes::TStrings* AValues);
	virtual void __fastcall GetSubProps(System::Classes::TList* AResult);
	virtual Lmdtypes::TLMDString __fastcall GetPropName(void);
	virtual bool __fastcall AllEqual(void);
	virtual void __fastcall Edit(void);
	virtual void __fastcall ValuesMeasureHeight(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, int &AHeight);
	virtual void __fastcall ValuesMeasureWidth(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, int &AWidth);
	virtual void __fastcall ValuesDrawValue(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
	System::Extended __fastcall GetFloatValue(int AIndex);
	__int64 __fastcall GetInt64Value(int AIndex);
	int __fastcall GetOrdValue(int AIndex);
	System::UnicodeString __fastcall GetStrValue(int AIndex);
	System::WideString __fastcall GetWideStrValue(int AIndex);
	System::Variant __fastcall GetVarValue(int AIndex);
	System::TObject* __fastcall GetObjectValue(int AIndex);
	Lmdtypes::TLMDString __fastcall GetEventValue(int AIndex);
	Lmdtypes::TLMDString __fastcall GetDefaultEventHandlerName(int AIndex);
	void __fastcall GetExistingEventHandlers(System::Classes::TStrings* AResult);
	System::Classes::TComponent* __fastcall GetCompRef(const Lmdtypes::TLMDString ACompName);
	Lmdtypes::TLMDString __fastcall GetCompRefName(System::Classes::TComponent* AComponent);
	void __fastcall GetCompRefList(System::Classes::TComponentClass AClass, System::Classes::TList* AResult);
	void __fastcall SetFloatValue(System::Extended Value);
	void __fastcall SetInt64Value(__int64 Value);
	void __fastcall SetOrdValue(int Value);
	void __fastcall SetStrValue(const System::UnicodeString Value);
	void __fastcall SetWideStrValue(const System::WideString Value);
	void __fastcall SetVarValue(const System::Variant &Value);
	void __fastcall SetObjectValue(System::TObject* const Value);
	void __fastcall SetEventValue(const Lmdtypes::TLMDString Value);
	void __fastcall ShowEventHandler(const Lmdtypes::TLMDString AValue);
	void __fastcall SetByRef(const TLMDSetByRefProc AProc, void * AData);
	void __fastcall GetPropEditors(TLMDPropEditor* AParentObjEditor, System::Classes::TList* AObjList, bool AOnlyNestable, bool AIsSubProp, System::Classes::TList* AResult);
	
public:
	__fastcall virtual TLMDPropEditor(TLMDCustomPropertyInspector* APropInsp, TLMDPropEditor* AParentObjEditor, int APropCount, void * APropList);
	__fastcall virtual ~TLMDPropEditor(void);
	bool __fastcall CreateEditorWndCbs(System::Classes::TPersistent* AEditedObject, /* out */ Lmdinseditorwnds::TLMDEditorWindowCallbacks* &AResult);
	ILMDProperty* __fastcall GetPropInfo(int AIndex);
	System::Classes::TPersistent* __fastcall GetInstance(int AIndex);
	bool __fastcall IsWrittenProperty(void);
	__property TLMDCustomPropertyInspector* PropInsp = {read=FPropInsp};
	__property Lmdtypes::TLMDString PropName = {read=GetPropName};
	__property System::Typinfo::PTypeInfo PropTypeInfo = {read=GetPropTypeInfo};
	__property int PropCount = {read=FPropCount, nodefault};
	__property Lmdtypes::TLMDString Value = {read=DoGetValue, write=SetValue};
	__property TLMDPropEditor* ParentObjEditor = {read=FParentObjEditor};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDNestedPropEditor : public TLMDPropEditor
{
	typedef TLMDPropEditor inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetPropName(void);
	
public:
	__fastcall TLMDNestedPropEditor(TLMDPropEditor* ANestedIn);
	__fastcall virtual ~TLMDNestedPropEditor(void);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPropertyInspectorPageItem : public Lmdinsproppage::TLMDPropsPageItem
{
	typedef Lmdinsproppage::TLMDPropsPageItem inherited;
	
private:
	TLMDPropEditor* FEditor;
	Lmdtypes::TLMDString FDisplayValue;
	Lmdtypes::TLMDString FEditValue;
	void __fastcall DeGetPickList(System::Classes::TStrings* AResult);
	void __fastcall SetEditor(TLMDPropEditor* const Value);
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetDisplayValue(void);
	virtual Lmdtypes::TLMDString __fastcall GetEditValue(void);
	virtual void __fastcall SetEditValue(const Lmdtypes::TLMDString Value, bool AForce);
	virtual void __fastcall GetEditPickList(System::Classes::TStrings* APickList);
	DYNAMIC void __fastcall EditButtonClick(void);
	DYNAMIC void __fastcall EditDblClick(void);
	virtual void __fastcall PickListMeasureHeight(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, int &AHeight);
	virtual void __fastcall PickListMeasureWidth(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, int &AWidth);
	virtual void __fastcall PickListDrawValue(const Lmdtypes::TLMDString AValue, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, bool ASelected);
	
public:
	__fastcall virtual ~TLMDPropertyInspectorPageItem(void);
	void __fastcall UpdateParams(void);
	bool __fastcall CanEdit(void);
	void __fastcall Edit(void);
	__property TLMDPropEditor* Editor = {read=FEditor, write=SetEditor};
public:
	/* TLMDPropsPageItem.Create */ inline __fastcall virtual TLMDPropertyInspectorPageItem(Lmdinsproppage::TLMDCustomPropsPage* AOwner, Lmdinsproppage::TLMDPropsPageItem* AParent) : Lmdinsproppage::TLMDPropsPageItem(AOwner, AParent) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPropertyInspectorItem : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDPropertyInspectorItem* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	System::Classes::TList* FItems;
	TLMDPropertyInspectorItems* FOwnerItems;
	TLMDPropertyInspectorItem* FParent;
	TLMDPropertyInspectorPageItem* FPageItem;
	void __fastcall InsertItem(TLMDPropertyInspectorItem* AItem);
	void __fastcall RemoveItem(TLMDPropertyInspectorItem* AItem);
	void __fastcall Clear(void);
	TLMDPropertyInspectorItem* __fastcall GetItems(int AIndex);
	bool __fastcall GetActive(void);
	bool __fastcall GetExpanded(void);
	int __fastcall GetLevel(void);
	TLMDCustomPropertyInspector* __fastcall GetOwner(void);
	ILMDProperty* __fastcall GetPropInfo(int AIndex);
	void __fastcall SetActive(const bool Value);
	int __fastcall GetCount(void);
	System::Typinfo::PTypeInfo __fastcall GetTypeInfo(void);
	Lmdtypes::TLMDString __fastcall GetPropName(void);
	Lmdtypes::TLMDString __fastcall GetValue(void);
	void __fastcall SetValue(const Lmdtypes::TLMDString Value);
	TLMDPropertyInspectorCategory* __fastcall GetParentCategory(void);
	TLMDPropEditor* __fastcall GetEditor(void);
	
public:
	__fastcall TLMDPropertyInspectorItem(TLMDPropertyInspectorItems* AOwnerItems, TLMDPropertyInspectorItem* AParent, TLMDPropertyInspectorPageItem* APageItem);
	__fastcall virtual ~TLMDPropertyInspectorItem(void);
	void __fastcall Expand(void);
	void __fastcall Collapse(void);
	bool __fastcall CanEdit(void);
	void __fastcall Edit(void);
	System::Types::TRect __fastcall DisplayRect(bool ACaption, bool AValue);
	int __fastcall IndexOf(TLMDPropertyInspectorItem* AItem);
	TLMDPropertyInspectorItem* __fastcall Find(const Lmdtypes::TLMDString APropName, System::Typinfo::PTypeInfo ATypeInfo = (System::Typinfo::PTypeInfo)(0x0));
	TLMDPropertyInspectorItem* __fastcall ItemBy(const Lmdtypes::TLMDString APropName, System::Typinfo::PTypeInfo ATypeInfo = (System::Typinfo::PTypeInfo)(0x0));
	__property Lmdtypes::TLMDString PropName = {read=GetPropName};
	__property System::Typinfo::PTypeInfo TypeInfo = {read=GetTypeInfo};
	__property ILMDProperty* PropInfo[int AIndex] = {read=GetPropInfo};
	__property TLMDPropEditor* Editor = {read=GetEditor};
	__property Lmdtypes::TLMDString Value = {read=GetValue, write=SetValue};
	__property TLMDCustomPropertyInspector* Owner = {read=GetOwner};
	__property TLMDPropertyInspectorItem* Parent = {read=FParent};
	__property TLMDPropertyInspectorCategory* ParentCategory = {read=GetParentCategory};
	__property bool Active = {read=GetActive, write=SetActive, nodefault};
	__property bool Expanded = {read=GetExpanded, nodefault};
	__property int Level = {read=GetLevel, nodefault};
	__property int Count = {read=GetCount, nodefault};
	__property TLMDPropertyInspectorItem* Items[int AIndex] = {read=GetItems/*, default*/};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPropertyInspectorItems : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDPropertyInspectorItem* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	System::Classes::TList* FItems;
	TLMDCustomPropertyInspector* FOwner;
	void __fastcall InsertItem(TLMDPropertyInspectorItem* AItem);
	void __fastcall RemoveItem(TLMDPropertyInspectorItem* AItem);
	void __fastcall Clear(void);
	int __fastcall GetCount(void);
	TLMDPropertyInspectorItem* __fastcall GetItems(int AIndex);
	
public:
	__fastcall TLMDPropertyInspectorItems(TLMDCustomPropertyInspector* AOwner);
	__fastcall virtual ~TLMDPropertyInspectorItems(void);
	int __fastcall IndexOf(TLMDPropertyInspectorItem* AItem);
	TLMDPropertyInspectorItem* __fastcall Find(const Lmdtypes::TLMDString APropName, System::Typinfo::PTypeInfo ATypeInfo = (System::Typinfo::PTypeInfo)(0x0));
	TLMDPropertyInspectorItem* __fastcall ItemBy(const Lmdtypes::TLMDString APropName, System::Typinfo::PTypeInfo ATypeInfo = (System::Typinfo::PTypeInfo)(0x0));
	__property TLMDCustomPropertyInspector* Owner = {read=FOwner};
	__property int Count = {read=GetCount, nodefault};
	__property TLMDPropertyInspectorItem* Items[int AIndex] = {read=GetItems/*, default*/};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPropertyInspectorCategory : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDPropertyInspectorItem* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	TLMDPropertyInspectorCategories* FOwnerCategories;
	TLMDPropertyInspectorPageItem* FPageItem;
	int __fastcall GetCount(void);
	TLMDPropertyInspectorItem* __fastcall GetItems(int AIndex);
	bool __fastcall GetExpanded(void);
	Lmdtypes::TLMDString __fastcall GetName(void);
	TLMDCustomPropertyInspector* __fastcall GetOwner(void);
	bool __fastcall GetActive(void);
	void __fastcall SetActive(const bool Value);
	
public:
	__fastcall TLMDPropertyInspectorCategory(TLMDPropertyInspectorCategories* AOwnerCategories, TLMDPropertyInspectorPageItem* APageItem);
	__fastcall virtual ~TLMDPropertyInspectorCategory(void);
	void __fastcall Expand(void);
	void __fastcall Collapse(void);
	System::Types::TRect __fastcall DisplayRect(void);
	int __fastcall IndexOf(TLMDPropertyInspectorItem* AItem);
	TLMDPropertyInspectorItem* __fastcall Find(const Lmdtypes::TLMDString APropName, System::Typinfo::PTypeInfo ATypeInfo = (System::Typinfo::PTypeInfo)(0x0));
	TLMDPropertyInspectorItem* __fastcall ItemBy(const Lmdtypes::TLMDString APropName, System::Typinfo::PTypeInfo ATypeInfo = (System::Typinfo::PTypeInfo)(0x0));
	__property int Count = {read=GetCount, nodefault};
	__property TLMDPropertyInspectorItem* Items[int AIndex] = {read=GetItems/*, default*/};
	__property Lmdtypes::TLMDString Name = {read=GetName};
	__property TLMDCustomPropertyInspector* Owner = {read=GetOwner};
	__property bool Expanded = {read=GetExpanded, nodefault};
	__property bool Active = {read=GetActive, write=SetActive, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPropertyInspectorCategories : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDPropertyInspectorCategory* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	System::Classes::TList* FItems;
	TLMDCustomPropertyInspector* FOwner;
	void __fastcall InsertItem(TLMDPropertyInspectorCategory* AItem);
	void __fastcall RemoveItem(TLMDPropertyInspectorCategory* AItem);
	void __fastcall Clear(void);
	int __fastcall GetCount(void);
	TLMDPropertyInspectorCategory* __fastcall GetItems(int AIndex);
	
public:
	__fastcall TLMDPropertyInspectorCategories(TLMDCustomPropertyInspector* AOwner);
	__fastcall virtual ~TLMDPropertyInspectorCategories(void);
	int __fastcall IndexOf(TLMDPropertyInspectorCategory* AItem);
	TLMDPropertyInspectorCategory* __fastcall Find(const Lmdtypes::TLMDString AName);
	TLMDPropertyInspectorCategory* __fastcall ItemBy(const Lmdtypes::TLMDString AName);
	__property TLMDCustomPropertyInspector* Owner = {read=FOwner};
	__property int Count = {read=GetCount, nodefault};
	__property TLMDPropertyInspectorCategory* Items[int AIndex] = {read=GetItems/*, default*/};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPropertyInspectorDefiner : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDCustomPropertyInspector* FOwner;
	System::Classes::TList* FResult;
	
public:
	__fastcall TLMDPropertyInspectorDefiner(TLMDCustomPropertyInspector* AOwner, System::Classes::TList* AResult);
	void __fastcall DefineProperty(const Lmdtypes::TLMDString AName, System::Typinfo::PTypeInfo AType, bool AIsReadable = true, bool AIsWritable = true, void * AUserData = (void *)(0x0));
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDPropertyInspectorDefiner(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPropertyInspectorDynValue : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Typinfo::TTypeInfo *FType;
	void *FBuffer;
	bool *FIsDefault;
	void __fastcall CheckType(System::Typinfo::TTypeKinds AKinds);
	bool __fastcall GetIsDefault(void);
	System::Extended __fastcall GetAsFloat(void);
	__int64 __fastcall GetAsInt64(void);
	System::TObject* __fastcall GetAsObject(void);
	int __fastcall GetAsOrd(void);
	System::UnicodeString __fastcall GetAsStr(void);
	System::Variant __fastcall GetAsVariant(void);
	System::WideString __fastcall GetAsWideStr(void);
	void __fastcall SetIsDefault(bool AValue);
	void __fastcall SetAsFloat(System::Extended AValue);
	void __fastcall SetAsInt64(__int64 AValue);
	void __fastcall SetAsOrd(int AValue);
	void __fastcall SetAsStr(const System::UnicodeString AValue);
	void __fastcall SetAsWideStr(const System::WideString AValue);
	void __fastcall SetAsVariant(const System::Variant &AValue);
	void __fastcall SetAsObject(System::TObject* AValue);
	
public:
	__fastcall TLMDPropertyInspectorDynValue(System::Typinfo::PTypeInfo AType, void * ABuffer, System::PBoolean AIsDefault);
	__property bool IsDefault = {read=GetIsDefault, write=SetIsDefault, nodefault};
	__property System::Extended AsFloat = {read=GetAsFloat, write=SetAsFloat};
	__property __int64 AsInt64 = {read=GetAsInt64, write=SetAsInt64};
	__property int AsOrd = {read=GetAsOrd, write=SetAsOrd, nodefault};
	__property System::UnicodeString AsStr = {read=GetAsStr, write=SetAsStr};
	__property System::WideString AsWideStr = {read=GetAsWideStr, write=SetAsWideStr};
	__property System::Variant AsVariant = {read=GetAsVariant, write=SetAsVariant};
	__property System::TObject* AsObject = {read=GetAsObject, write=SetAsObject};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDPropertyInspectorDynValue(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDPropertyInspectorOnFilterProp)(System::TObject* Sender, System::Classes::TPersistent* AInstance, ILMDProperty* APropInfo, bool AIsSubProp, bool &AIncludeProp);

typedef void __fastcall (__closure *TLMDPropertyInspectorOnGetCaptionColor)(System::TObject* Sender, TLMDPropertyInspectorItem* AItem, System::Uitypes::TColor &AColor);

typedef void __fastcall (__closure *TLMDPropertyInspectorOnGetEditorClass)(System::TObject* Sender, System::Classes::TPersistent* AInstance, ILMDProperty* APropInfo, TLMDPropEditorClass &AEditorClass);

typedef void __fastcall (__closure *TLMDPropertyInspectorOnCompare)(System::TObject* Sender, System::Classes::TPersistent* AInstance, ILMDProperty* APropInfo1, ILMDProperty* APropInfo2, int &ACompare);

typedef void __fastcall (__closure *TLMDPropertyInspectorItemEvent)(System::TObject* Sender, TLMDPropertyInspectorItem* AItem);

typedef void __fastcall (__closure *TLMDPropertyInspectorCategoryEvent)(System::TObject* Sender, TLMDPropertyInspectorCategory* ACategory);

typedef void __fastcall (__closure *TLMDPropertyInspectorOnTranslateProp)(System::TObject* Sender, const Lmdtypes::TLMDString APropName, Lmdtypes::TLMDString &ATranslatedName);

typedef void __fastcall (__closure *TLMDPropertyInspectorOnGetCompRef)(System::TObject* Sender, const Lmdtypes::TLMDString ACompName, System::Classes::TComponent* &AComponent);

typedef void __fastcall (__closure *TLMDPropertyInspectorOnGetCompRefName)(System::TObject* Sender, System::Classes::TComponent* AComponent, Lmdtypes::TLMDString &AName);

typedef void __fastcall (__closure *TLMDPropertyInspectorOnGetCompRefList)(System::TObject* Sender, System::Classes::TComponentClass AClass, System::Classes::TList* AResult);

typedef void __fastcall (__closure *TLMDPropertyInspectorOnGetUniqueCompName)(System::TObject* Sender, const Lmdtypes::TLMDString ABaseName, Lmdtypes::TLMDString &AUniqueName);

typedef void __fastcall (__closure *TLMDPropertyInspectorOnGetEventValue)(System::TObject* Sender, System::Classes::TPersistent* AInstance, ILMDProperty* APropInfo, Lmdtypes::TLMDString &AResult);

typedef void __fastcall (__closure *TLMDPropertyInspectorOnSetEventValue)(System::TObject* Sender, System::Classes::TPersistent* AInstance, ILMDProperty* APropInfo, const Lmdtypes::TLMDString AValue);

typedef void __fastcall (__closure *TLMDPropertyInspectorOnGetDefaultEventHandlerName)(System::TObject* Sender, System::Classes::TPersistent* AInstance, const Lmdtypes::TLMDString AEventName, System::Typinfo::PTypeInfo AEventTypeInfo, Lmdtypes::TLMDString &AResult);

typedef void __fastcall (__closure *TLMDPropertyInspectorOnGetExistingEventHandlers)(System::TObject* Sender, System::Typinfo::PTypeInfo AEventTypeInfo, System::Classes::TStrings* AResult);

typedef void __fastcall (__closure *TLMDPropertyInspectorOnEnsureEventHandlerSource)(System::TObject* Sender, const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AOldName, System::Typinfo::PTypeInfo AEventTypeInfo, bool AShowSource);

typedef void __fastcall (__closure *TLMDPropertyInspectorOnDynPropsDefine)(System::TObject* Sender, System::Classes::TPersistent* AInstance, TLMDPropertyInspectorDefiner* ADefiner);

typedef void __fastcall (__closure *TLMDPropertyInspectorOnDynPropGetValue)(System::TObject* Sender, System::Classes::TPersistent* AInstance, ILMDProperty* AProperty, void * AUserData, TLMDPropertyInspectorDynValue* AResult);

typedef void __fastcall (__closure *TLMDPropertyInspectorOnDynPropSetValue)(System::TObject* Sender, System::Classes::TPersistent* AInstance, ILMDProperty* AProperty, void * AUserData, TLMDPropertyInspectorDynValue* AValue);

enum DECLSPEC_DENUM Lmdinspropinsp__31 : unsigned char { pisObjectsLocked, pisVolatilingSubProperties };

typedef System::Set<Lmdinspropinsp__31, Lmdinspropinsp__31::pisObjectsLocked, Lmdinspropinsp__31::pisVolatilingSubProperties> TLMDPropertyInspectorState;

enum DECLSPEC_DENUM TLMDPropertyInspectorPropKind : unsigned char { pkProperties, pkEvents, pkReadOnly };

typedef System::Set<TLMDPropertyInspectorPropKind, TLMDPropertyInspectorPropKind::pkProperties, TLMDPropertyInspectorPropKind::pkReadOnly> TLMDPropertyInspectorPropKinds;

enum DECLSPEC_DENUM TLMDPropertyInspectorSortType : unsigned char { stCaption, stNone, stCustom };

enum DECLSPEC_DENUM TLMDPropertyInspectorArrangeKind : unsigned char { akByName, akByCategory };

enum DECLSPEC_DENUM Lmdinspropinsp__41 : unsigned char { pimoAddDefaultItems };

typedef System::Set<Lmdinspropinsp__41, Lmdinspropinsp__41::pimoAddDefaultItems, Lmdinspropinsp__41::pimoAddDefaultItems> TLMDPropertyInspectorMenuOptions;

class PASCALIMPLEMENTATION TLMDCustomPropertyInspector : public Lmdinsproppage::TLMDCustomPropsPage
{
	typedef Lmdinsproppage::TLMDCustomPropsPage inherited;
	
	
private:
	typedef System::DynamicArray<TLMDPropertyInspectorEditorDescr> _TLMDCustomPropertyInspector__1;
	
	
private:
	TLMDPropertyInspectorState FState;
	TLMDPropertyInspectorItems* FItems;
	TLMDPropertyInspectorCategories* FCategories;
	System::Classes::TStrings* FObjectsCategories;
	_TLMDCustomPropertyInspector__1 FEditors;
	bool FAutoCompRefs;
	bool FAutoEvents;
	System::Classes::TNotifyEvent FOnChange;
	TLMDPropertyInspectorPropKinds FPropKinds;
	TLMDPropertyInspectorOnFilterProp FOnFilterProp;
	System::Uitypes::TColor FComponentRefColor;
	System::Uitypes::TColor FComponentRefPropColor;
	bool FExpandComponentRefs;
	bool FReadOnly;
	void *FDesigner;
	System::TObject* FCategoryList;
	Vcl::Menus::TPopupMenu* FTempMenu;
	TLMDPropertyInspectorOnGetCaptionColor FOnGetCaptionColor;
	TLMDPropertyInspectorOnGetEditorClass FOnGetEditorClass;
	TLMDPropertyInspectorSortType FSortType;
	TLMDPropertyInspectorOnCompare FOnCompare;
	TLMDPropertyInspectorItemEvent FOnExpanded;
	TLMDPropertyInspectorItemEvent FOnCollapsed;
	TLMDPropertyInspectorCategoryEvent FOnCategoryExpanded;
	TLMDPropertyInspectorOnTranslateProp FOnTranslateProp;
	TLMDPropertyInspectorArrangeKind FArrangeKind;
	bool FHighlightNonDefaultValues;
	bool FExpandedCategories;
	TLMDPropertyInspectorMenuOptions FMenuOptions;
	TLMDPropertyInspectorOnGetCompRef FOnGetCompRef;
	TLMDPropertyInspectorOnGetCompRefList FOnGetCompRefList;
	TLMDPropertyInspectorOnGetCompRefName FOnGetCompRefName;
	TLMDPropertyInspectorOnGetEventValue FOnGetEventValue;
	TLMDPropertyInspectorOnSetEventValue FOnSetEventValue;
	TLMDPropertyInspectorOnGetExistingEventHandlers FOnGetExistingEventHandlers;
	TLMDPropertyInspectorOnEnsureEventHandlerSource FOnEnsureEventHandlerSource;
	TLMDPropertyInspectorOnGetDefaultEventHandlerName FOnGetDefaultEventHandlerName;
	TLMDPropertyInspectorOnGetUniqueCompName FOnGetUniqueCompName;
	TLMDPropertyInspectorOnDynPropsDefine FOnDynPropsDefine;
	TLMDPropertyInspectorOnDynPropGetValue FOnDynPropGetValue;
	TLMDPropertyInspectorOnDynPropSetValue FOnDynPropSetValue;
	void __fastcall AddDefaultMenuItems(Vcl::Menus::TPopupMenu* AMenu);
	void __fastcall ClearTempMenuItems(Vcl::Menus::TPopupMenu* AMenu);
	void __fastcall RecreateItems(bool ARestoreState = true);
	void __fastcall CreateItemOrCategory(TLMDPropertyInspectorPageItem* APageItem);
	Lmdinsproppage::TLMDPropsPageItems* __fastcall PageItems(void);
	Lmdinsproppage::TLMDPropsPageItem* __fastcall ActivePageItem(void);
	void __fastcall PageItemVolatileCollapses(TLMDPropertyInspectorPageItem* AItem);
	void __fastcall EditorChange(TLMDPropEditor* AEditor);
	void __fastcall RegisterStandatdEditors(void);
	void __fastcall RegisterStandardCategories(void);
	TLMDPropEditorClass __fastcall GetTypeKindEditorClass(System::Typinfo::PTypeInfo ATypeInfo);
	int __fastcall IndexOfEditor(System::Typinfo::PTypeInfo ATypeInfo, System::TClass AObjectClass, const Lmdtypes::TLMDString APropName, TLMDPropEditorClass AEditorClass);
	void __fastcall DoRegisterPropCategory(const Lmdtypes::TLMDString ACategoryName, System::Typinfo::PTypeInfo ATypeInfo, System::TClass AObjectClass, const Lmdtypes::TLMDString APropName);
	void __fastcall DoUnregisterPropCategory(const Lmdtypes::TLMDString ACategoryName, System::Typinfo::PTypeInfo ATypeInfo, System::TClass AObjectClass, const Lmdtypes::TLMDString APropName);
	void __fastcall CheckObjectsLock(void);
	HIDESBASE TLMDPropertyInspectorItem* __fastcall GetActiveItem(void);
	TLMDPropertyInspectorCategory* __fastcall GetActiveCategory(void);
	void __fastcall SetPropKinds(const TLMDPropertyInspectorPropKinds Value);
	void __fastcall SetComponentRefColor(const System::Uitypes::TColor Value);
	void __fastcall SetComponentRefPropColor(const System::Uitypes::TColor Value);
	void __fastcall SetExpandComponentRefs(const bool Value);
	void __fastcall SetReadOnly(const bool Value);
	void __fastcall SetDesigner(const void * Value);
	void __fastcall SetSortType(const TLMDPropertyInspectorSortType Value);
	void __fastcall SetArrangeKind(const TLMDPropertyInspectorArrangeKind Value);
	void __fastcall SetHighlightNonDefaultValues(const bool Value);
	void __fastcall SetExpandedCategories(const bool Value);
	
protected:
	virtual Lmdinsproppage::TLMDPropsPageItem* __fastcall CreateItem(Lmdinsproppage::TLMDPropsPageItem* AParent);
	virtual void __fastcall ItemDestroying(Lmdinsproppage::TLMDPropsPageItem* AItem);
	virtual void __fastcall ItemExpanded(Lmdinsproppage::TLMDPropsPageItem* AItem);
	virtual void __fastcall ItemCollapsed(Lmdinsproppage::TLMDPropsPageItem* AItem);
	virtual System::Uitypes::TColor __fastcall GetItemCaptionColor(Lmdinsproppage::TLMDPropsPageItem* AItem);
	DYNAMIC void __fastcall DoContextPopup(const System::Types::TPoint &MousePos, bool &Handled);
	virtual void __fastcall GetObjects(System::Classes::TList* AResult) = 0 ;
	virtual void __fastcall SetObjects(System::Classes::TList* AObjects) = 0 ;
	virtual Lmdinseditorwnds::TLMDEditorWindowManager* __fastcall DetectEditorWindowManager(System::Classes::TPersistent* AEditedObject);
	virtual void __fastcall ObjectsChanged(void);
	virtual void __fastcall DoDynPropsDefine(System::Classes::TPersistent* AInstance, TLMDPropertyInspectorDefiner* ADefiner);
	virtual void __fastcall DoDynPropGetValue(System::Classes::TPersistent* AInstance, ILMDProperty* AProperty, void * AUserData, TLMDPropertyInspectorDynValue* AResult);
	virtual void __fastcall DoDynPropSetValue(System::Classes::TPersistent* AInstance, ILMDProperty* AProperty, void * AUserData, TLMDPropertyInspectorDynValue* AValue);
	virtual void __fastcall DoGetCompRef(TLMDPropEditor* AEditor, const Lmdtypes::TLMDString ACompName, System::Classes::TComponent* &AComponent);
	virtual void __fastcall DoGetCompRefName(TLMDPropEditor* AEditor, System::Classes::TComponent* AComponent, Lmdtypes::TLMDString &AName);
	virtual void __fastcall DoGetCompRefList(TLMDPropEditor* AEditor, System::Classes::TComponentClass AClass, System::Classes::TList* AResult);
	virtual void __fastcall DoGetEventValue(TLMDPropEditor* AEditor, System::Classes::TPersistent* AInstance, ILMDProperty* APropInfo, Lmdtypes::TLMDString &AResult);
	virtual void __fastcall DoSetEventValue(TLMDPropEditor* AEditor, System::Classes::TPersistent* AInstance, ILMDProperty* APropInfo, const Lmdtypes::TLMDString AValue);
	virtual void __fastcall DoGetDefaultEventHandlerName(TLMDPropEditor* AEditor, System::Classes::TPersistent* AInstance, const Lmdtypes::TLMDString AEventName, System::Typinfo::PTypeInfo AEventTypeInfo, Lmdtypes::TLMDString &AResult);
	virtual void __fastcall DoGetExistingEventHandlers(TLMDPropEditor* AEditor, System::Typinfo::PTypeInfo AEventTypeInfo, System::Classes::TStrings* AResult);
	virtual void __fastcall DoEnsureEventHandlerSource(TLMDPropEditor* AEditor, const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AOldName, System::Typinfo::PTypeInfo AEventTypeInfo, bool AShowSource);
	virtual void __fastcall DoGetUniqueCompName(System::Classes::TComponent* AComponent, Lmdtypes::TLMDString &AUniqueName);
	virtual void __fastcall DoChange(TLMDPropEditor* AEditor);
	virtual void __fastcall GetEditorClass(bool AIsSubProp, System::Classes::TPersistent* AInstance, ILMDProperty* APropInfo, TLMDPropEditorClass &AEditorClass);
	virtual void __fastcall FilterProp(System::Classes::TPersistent* AInstance, ILMDProperty* APropInfo, bool AIsSubProp, bool &AIncludeProp);
	Lmdtypes::TLMDString __fastcall TranslateProp(const Lmdtypes::TLMDString APropName);
	virtual void __fastcall Expanded(TLMDPropertyInspectorItem* AItem);
	virtual void __fastcall Collapsed(TLMDPropertyInspectorItem* AItem);
	virtual void __fastcall CategoryExpanded(TLMDPropertyInspectorCategory* ACategory);
	virtual void __fastcall CategoryCollapsed(TLMDPropertyInspectorCategory* ACategory);
	virtual void __fastcall GetCaptionColor(TLMDPropertyInspectorItem* AItem, System::Uitypes::TColor &AColor);
	virtual void __fastcall CustomCompare(System::Classes::TPersistent* AInstance, ILMDProperty* APropInfo1, ILMDProperty* APropInfo2, int &ACompare);
	__property TLMDPropertyInspectorState State = {read=FState, nodefault};
	__property TLMDPropertyInspectorItem* ActiveItem = {read=GetActiveItem};
	__property TLMDPropertyInspectorCategory* ActiveCategory = {read=GetActiveCategory};
	__property TLMDPropertyInspectorItems* Items = {read=FItems};
	__property TLMDPropertyInspectorCategories* Categories = {read=FCategories};
	__property System::Classes::TStrings* ObjectsCategories = {read=FObjectsCategories};
	__property void * Designer = {read=FDesigner, write=SetDesigner};
	__property TLMDPropertyInspectorPropKinds PropKinds = {read=FPropKinds, write=SetPropKinds, default=1};
	__property System::Uitypes::TColor ComponentRefColor = {read=FComponentRefColor, write=SetComponentRefColor, default=128};
	__property System::Uitypes::TColor ComponentRefPropColor = {read=FComponentRefPropColor, write=SetComponentRefPropColor, default=32768};
	__property bool ExpandComponentRefs = {read=FExpandComponentRefs, write=SetExpandComponentRefs, default=1};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	__property TLMDPropertyInspectorSortType SortType = {read=FSortType, write=SetSortType, default=0};
	__property TLMDPropertyInspectorArrangeKind ArrangeKind = {read=FArrangeKind, write=SetArrangeKind, default=0};
	__property bool HighlightNonDefaultValues = {read=FHighlightNonDefaultValues, write=SetHighlightNonDefaultValues, default=1};
	__property bool ExpandedCategories = {read=FExpandedCategories, write=SetExpandedCategories, default=0};
	__property TLMDPropertyInspectorMenuOptions MenuOptions = {read=FMenuOptions, write=FMenuOptions, default=0};
	__property TLMDPropertyInspectorOnFilterProp OnFilterProp = {read=FOnFilterProp, write=FOnFilterProp};
	__property TLMDPropertyInspectorOnTranslateProp OnTranslateProp = {read=FOnTranslateProp, write=FOnTranslateProp};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TLMDPropertyInspectorOnGetCaptionColor OnGetCaptionColor = {read=FOnGetCaptionColor, write=FOnGetCaptionColor};
	__property TLMDPropertyInspectorOnGetEditorClass OnGetEditorClass = {read=FOnGetEditorClass, write=FOnGetEditorClass};
	__property TLMDPropertyInspectorOnCompare OnCompare = {read=FOnCompare, write=FOnCompare};
	__property TLMDPropertyInspectorItemEvent OnExpanded = {read=FOnExpanded, write=FOnExpanded};
	__property TLMDPropertyInspectorItemEvent OnCollapsed = {read=FOnCollapsed, write=FOnCollapsed};
	__property TLMDPropertyInspectorCategoryEvent OnCategoryExpanded = {read=FOnCategoryExpanded, write=FOnCategoryExpanded};
	__property TLMDPropertyInspectorCategoryEvent OnCategoryCollapsed = {read=FOnCategoryExpanded, write=FOnCategoryExpanded};
	__property TLMDPropertyInspectorOnGetCompRef OnGetCompRef = {read=FOnGetCompRef, write=FOnGetCompRef};
	__property TLMDPropertyInspectorOnGetCompRefName OnGetCompRefName = {read=FOnGetCompRefName, write=FOnGetCompRefName};
	__property TLMDPropertyInspectorOnGetCompRefList OnGetCompRefList = {read=FOnGetCompRefList, write=FOnGetCompRefList};
	__property TLMDPropertyInspectorOnGetEventValue OnGetEventValue = {read=FOnGetEventValue, write=FOnGetEventValue};
	__property TLMDPropertyInspectorOnSetEventValue OnSetEventValue = {read=FOnSetEventValue, write=FOnSetEventValue};
	__property TLMDPropertyInspectorOnGetDefaultEventHandlerName OnGetDefaultEventHandlerName = {read=FOnGetDefaultEventHandlerName, write=FOnGetDefaultEventHandlerName};
	__property TLMDPropertyInspectorOnGetExistingEventHandlers OnGetExistingEventHandlers = {read=FOnGetExistingEventHandlers, write=FOnGetExistingEventHandlers};
	__property TLMDPropertyInspectorOnEnsureEventHandlerSource OnEnsureEventHandlerSource = {read=FOnEnsureEventHandlerSource, write=FOnEnsureEventHandlerSource};
	__property TLMDPropertyInspectorOnGetUniqueCompName OnGetUniqueCompName = {read=FOnGetUniqueCompName, write=FOnGetUniqueCompName};
	__property TLMDPropertyInspectorOnDynPropsDefine OnDynPropsDefine = {read=FOnDynPropsDefine, write=FOnDynPropsDefine};
	__property TLMDPropertyInspectorOnDynPropGetValue OnDynPropGetValue = {read=FOnDynPropGetValue, write=FOnDynPropGetValue};
	__property TLMDPropertyInspectorOnDynPropSetValue OnDynPropSetValue = {read=FOnDynPropSetValue, write=FOnDynPropSetValue};
	
public:
	__fastcall virtual TLMDCustomPropertyInspector(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomPropertyInspector(void);
	HIDESBASE Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	void __fastcall UpdateContent(void);
	void __fastcall UpdateItems(void);
	void __fastcall RegisterPropEditor(System::Typinfo::PTypeInfo ATypeInfo, System::TClass AObjectClass, const Lmdtypes::TLMDString APropName, TLMDPropEditorClass AEditorClass);
	void __fastcall UnregisterPropEditor(System::Typinfo::PTypeInfo ATypeInfo, System::TClass AObjectClass, const Lmdtypes::TLMDString APropName, TLMDPropEditorClass AEditorClass);
	void __fastcall RegisterPropCategory(const Lmdtypes::TLMDString ACategoryName, const Lmdtypes::TLMDString APropName)/* overload */;
	void __fastcall UnregisterPropCategory(const Lmdtypes::TLMDString ACategoryName, const Lmdtypes::TLMDString APropName)/* overload */;
	void __fastcall RegisterPropCategory(const Lmdtypes::TLMDString ACategoryName, System::TClass AObjectClass, const Lmdtypes::TLMDString APropName)/* overload */;
	void __fastcall UnregisterPropCategory(const Lmdtypes::TLMDString ACategoryName, System::TClass AObjectClass, const Lmdtypes::TLMDString APropName)/* overload */;
	void __fastcall RegisterPropCategory(const Lmdtypes::TLMDString ACategoryName, System::Typinfo::PTypeInfo ATypeInfo, const Lmdtypes::TLMDString APropName)/* overload */;
	void __fastcall UnregisterPropCategory(const Lmdtypes::TLMDString ACategoryName, System::Typinfo::PTypeInfo ATypeInfo, const Lmdtypes::TLMDString APropName)/* overload */;
	void __fastcall RegisterPropCategory(const Lmdtypes::TLMDString ACategoryName, System::Typinfo::PTypeInfo ATypeInfo)/* overload */;
	void __fastcall UnregisterPropCategory(const Lmdtypes::TLMDString ACategoryName, System::Typinfo::PTypeInfo ATypeInfo)/* overload */;
	bool __fastcall HideCategory(const Lmdtypes::TLMDString ACategoryName);
	bool __fastcall ShowCategory(const Lmdtypes::TLMDString ACategoryName);
	void __fastcall ShowAllCategories(void);
	void __fastcall HideAllCategories(void);
	void __fastcall ExpandAllCategories(void);
	void __fastcall CollapseAllCategories(void);
	bool __fastcall IsRegisteredCategoryHidden(const Lmdtypes::TLMDString ACategoryName);
	HIDESBASE TLMDPropertyInspectorItem* __fastcall ItemAtPos(int AX, int AY);
	TLMDPropertyInspectorCategory* __fastcall CategoryAtPos(int AX, int AY);
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomPropertyInspector(HWND ParentWindow) : Lmdinsproppage::TLMDCustomPropsPage(ParentWindow) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSimplePropInspObjects : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Classes::TPersistent* operator[](int AIndex) { return this->Item[AIndex]; }
	
private:
	TLMDSimplePropInspector* FPropInsp;
	System::Classes::TList* FItems;
	int FUpdateCount;
	bool FChanged;
	int __fastcall GetCount(void);
	System::Classes::TPersistent* __fastcall GetItem(int AIndex);
	void __fastcall Changed(void);
	
public:
	__fastcall TLMDSimplePropInspObjects(TLMDSimplePropInspector* APropInsp);
	__fastcall virtual ~TLMDSimplePropInspObjects(void);
	void __fastcall Clear(void);
	void __fastcall Add(System::Classes::TPersistent* AItem);
	void __fastcall Delete(int AIndex);
	void __fastcall Remove(System::Classes::TPersistent* AItem);
	int __fastcall IndexOf(System::Classes::TPersistent* AItem);
	void __fastcall SetItems(System::Classes::TList* AItems);
	void __fastcall GetItems(System::Classes::TList* AResult);
	void __fastcall SetOne(System::Classes::TPersistent* AItem);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__property int Count = {read=GetCount, nodefault};
	__property System::Classes::TPersistent* Item[int AIndex] = {read=GetItem/*, default*/};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDSimplePropInspector : public TLMDCustomPropertyInspector
{
	typedef TLMDCustomPropertyInspector inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDSimplePropInspObjects* FObjects;
	Lmdinseditorutils::TLMDEditorUtils* FEditorUtils;
	Lmdinseditorwnds::TLMDEditorWindowManager* FEditorWindows;
	void __fastcall ReadDeprecatedEventProp(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual Lmdinseditorwnds::TLMDEditorWindowManager* __fastcall DetectEditorWindowManager(System::Classes::TPersistent* AEditedObject);
	virtual void __fastcall GetObjects(System::Classes::TList* AResult);
	virtual void __fastcall SetObjects(System::Classes::TList* AObjects);
	virtual void __fastcall DoChange(TLMDPropEditor* AEditor);
	
public:
	__fastcall virtual TLMDSimplePropInspector(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDSimplePropInspector(void);
	__property TLMDSimplePropInspObjects* Objects = {read=FObjects};
	__property Lmdinseditorwnds::TLMDEditorWindowManager* EditorWindows = {read=FEditorWindows};
	__property State;
	__property ActiveItem;
	__property ActiveCategory;
	__property Designer;
	__property Items;
	__property Categories;
	__property ObjectsCategories;
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property PropKinds = {default=1};
	__property ComponentRefColor = {default=128};
	__property ComponentRefPropColor = {default=32768};
	__property ExpandComponentRefs = {default=1};
	__property MenuOptions = {default=0};
	__property ReadOnly = {default=0};
	__property SortType = {default=0};
	__property ArrangeKind = {default=0};
	__property ToolTips = {default=1};
	__property GridColor = {default=-16777200};
	__property GridVisible = {default=1};
	__property GutterVisible = {default=0};
	__property GutterColor = {default=15793151};
	__property GutterLineColor = {default=-16777200};
	__property CursorVisible = {default=0};
	__property SelectionStyle = {default=0};
	__property FlatSelectionBackgroundColor = {default=-16777203};
	__property FlatSelectionColor = {default=-16777202};
	__property FlatSplitterColor = {default=8421504};
	__property CategoryBackgroundColor = {default=-16777203};
	__property CategoryFont;
	__property DefaultPropName = {default=0};
	__property Splitter;
	__property ValuesColor = {default=8388608};
	__property HighlightNonDefaultValues = {default=1};
	__property ExpandedCategories = {default=0};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777201};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property Visible = {default=1};
	__property OnExpanded;
	__property OnCollapsed;
	__property OnCategoryExpanded;
	__property OnCategoryCollapsed;
	__property OnFilterProp;
	__property OnTranslateProp;
	__property OnChange;
	__property OnGetCaptionColor;
	__property OnGetEditorClass;
	__property OnCompare;
	__property OnDynPropsDefine;
	__property OnDynPropGetValue;
	__property OnDynPropSetValue;
	__property OnGetCompRef;
	__property OnGetCompRefName;
	__property OnGetCompRefList;
	__property OnGetEventValue;
	__property OnSetEventValue;
	__property OnGetDefaultEventHandlerName;
	__property OnGetExistingEventHandlers;
	__property OnEnsureEventHandlerSource;
	__property OnGetUniqueCompName;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSimplePropInspector(HWND ParentWindow) : TLMDCustomPropertyInspector(ParentWindow) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdinspropinsp */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDINSPROPINSP)
using namespace Lmdinspropinsp;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdinspropinspHPP
