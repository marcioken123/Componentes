// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDBInspector.pas' rev: 31.00 (Windows)

#ifndef EldbinspectorHPP
#define EldbinspectorHPP

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
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.TypInfo.hpp>
#include <System.Variants.hpp>
#include <Data.DB.hpp>
#include <Data.DBConsts.hpp>
#include <LMDTypes.hpp>
#include <LMDUnicodeStrings.hpp>
#include <ElInspector.hpp>
#include <ElStack.hpp>
#include <ElVCLUtils.hpp>
#include <LMDObjectList.hpp>
#include <ElTree.hpp>
#include <ElEdits.hpp>
#include <ElHeader.hpp>
#include <ElTreeMemoEdit.hpp>
#include <ElTreeDTPickEdit.hpp>
#include <Vcl.StdCtrls.hpp>
#include <ElTreeCurrEdit.hpp>
#include <ElDBTreeEditors.hpp>
#include <ElInspectorEditors.hpp>
#include <ElTreeInplaceEditors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldbinspector
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElInspectorFieldType;
class DELPHICLASS TElDBData;
class DELPHICLASS TElDBUnknowData;
class DELPHICLASS TElDBDateTimeData;
class DELPHICLASS TElDBCurrData;
class DELPHICLASS TElDBBooleanData;
class DELPHICLASS TElDBLookupData;
class DELPHICLASS TElDBFloatData;
class DELPHICLASS TElDBStringData;
class DELPHICLASS TElDBGraphicData;
class DELPHICLASS TElDBMemoData;
class DELPHICLASS TElDBIntegerData;
class DELPHICLASS TElDBClassesList;
class DELPHICLASS TElDBEnumerator;
class DELPHICLASS TElInspectorDBDataSource;
class DELPHICLASS TIDBDataSourceDataLink;
class DELPHICLASS TElDBInspectorInplaceMemoEdit;
class DELPHICLASS TElDBInspectorInplaceDateTimeEdit;
class DELPHICLASS TElDBInspectorInplaceCurrEdit;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TElInspectorFieldType : public Elinspector::TElInspectorRegister
{
	typedef Elinspector::TElInspectorRegister inherited;
	
protected:
	Data::Db::TFieldType FFieldType;
	
public:
	__fastcall TElInspectorFieldType(const Elinspector::TElClassInplaceEditor AClass, const Elinspector::TElClassInspectorData AInspData, const Data::Db::TFieldType AFieldType);
	__property Data::Db::TFieldType FieldType = {read=FFieldType, write=FFieldType, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElInspectorFieldType(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElDBData : public Elinspector::TElInspectorData
{
	typedef Elinspector::TElInspectorData inherited;
	
private:
	Data::Db::TFieldType __fastcall GetFieldType(void);
	
protected:
	Data::Db::TDataSource* FDataSource;
	Lmdtypes::TLMDString FFieldName;
	Lmdtypes::TLMDString FFieldDisplName;
	Data::Db::TFieldType FFieldType;
	bool FReadOnly;
	Data::Db::TFieldKind FFieldKind;
	virtual bool __fastcall GetIsEnumerable(void);
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall GetName(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value) = 0 ;
	virtual bool __fastcall GetIsComplex(void);
	virtual bool __fastcall GetIsReadOnly(void);
	
public:
	bool __fastcall CheckNotReadOnly(void);
	virtual int __fastcall GetValuesList(System::Classes::TStrings* const AList);
	__property Data::Db::TFieldType FieldType = {read=GetFieldType, nodefault};
	__property Lmdtypes::TLMDString Name = {read=GetName};
	__property Lmdtypes::TLMDString Value = {read=GetAsString, write=SetAsString};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElDBData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElDBData(void) : Elinspector::TElInspectorData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElDBUnknowData : public TElDBData
{
	typedef TElDBData inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElDBUnknowData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElDBUnknowData(void) : TElDBData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElDBDateTimeData : public TElDBData
{
	typedef TElDBData inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
	virtual System::TDateTime __fastcall GetAsDateTime(void);
	virtual void __fastcall SetAsDateTime(System::TDateTime Value);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElDBDateTimeData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElDBDateTimeData(void) : TElDBData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElDBCurrData : public TElDBData
{
	typedef TElDBData inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
	void __fastcall SetAsCurrency(System::Currency Value);
	System::Currency __fastcall GetAsCurrency(void);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElDBCurrData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElDBCurrData(void) : TElDBData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElDBBooleanData : public TElDBData
{
	typedef TElDBData inherited;
	
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
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElDBBooleanData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElDBBooleanData(void) : TElDBData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElDBLookupData : public TElDBData
{
	typedef TElDBData inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
	virtual bool __fastcall GetIsEnumerable(void);
	virtual int __fastcall GetMaxValue(void);
	virtual int __fastcall GetMinValue(void);
	
public:
	virtual int __fastcall GetValuesList(System::Classes::TStrings* const AList);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElDBLookupData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElDBLookupData(void) : TElDBData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElDBFloatData : public TElDBData
{
	typedef TElDBData inherited;
	
protected:
	virtual int __fastcall GetMaxValue(void);
	virtual int __fastcall GetMinValue(void);
	virtual void __fastcall SetAsFloat(double Value);
	virtual double __fastcall GetAsFloat(void);
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElDBFloatData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElDBFloatData(void) : TElDBData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElDBStringData : public TElDBData
{
	typedef TElDBData inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElDBStringData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElDBStringData(void) : TElDBData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElDBGraphicData : public TElDBData
{
	typedef TElDBData inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElDBGraphicData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElDBGraphicData(void) : TElDBData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElDBMemoData : public TElDBData
{
	typedef TElDBData inherited;
	
protected:
	Lmdtypes::TLMDString __fastcall GetText(void);
	void __fastcall SetText(Lmdtypes::TLMDString Value);
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElDBMemoData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElDBMemoData(void) : TElDBData() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElDBIntegerData : public TElDBData
{
	typedef TElDBData inherited;
	
protected:
	virtual Lmdtypes::TLMDString __fastcall GetAsString(void);
	virtual void __fastcall SetAsString(Lmdtypes::TLMDString Value);
	virtual int __fastcall GetAsInteger(void);
	virtual void __fastcall SetAsInteger(int Value);
	virtual int __fastcall GetMaxValue(void);
	virtual int __fastcall GetMinValue(void);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElDBIntegerData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TElDBIntegerData(void) : TElDBData() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElDBClassesList : public Elinspector::TElInspectorClassesList
{
	typedef Elinspector::TElInspectorClassesList inherited;
	
protected:
	TElInspectorFieldType* __fastcall FindItemByFieldType(const Data::Db::TFieldType AFieldType);
	
public:
	HIDESBASE Elinspector::TElInspectorRegister* __fastcall GetNeededData(const Data::Db::TFieldType AFieldType);
	virtual Elinspector::TElInspectorRegister* __fastcall GetNeededEditor(Elinspector::TElInspectorItem* const AItem);
public:
	/* TLMDObjectList.Create */ inline __fastcall TElDBClassesList(void) : Elinspector::TElInspectorClassesList() { }
	/* TLMDObjectList.Destroy */ inline __fastcall virtual ~TElDBClassesList(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElDBEnumerator : public Elinspector::TElEnumerator
{
	typedef Elinspector::TElEnumerator inherited;
	
protected:
	int FCurrentField;
	
public:
	__fastcall TElDBEnumerator(Elinspector::TElInspectorDataSource* AOwner);
	virtual Elinspector::TElInspectorData* __fastcall GetFirstItem(void);
	virtual Elinspector::TElInspectorData* __fastcall GetNextItem(void);
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElDBEnumerator(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElInspectorDBDataSource : public Elinspector::TElInspectorDataSource
{
	typedef Elinspector::TElInspectorDataSource inherited;
	
protected:
	Elinspector::TElCategories* FCategories;
	bool FDataSetIsUpdate;
	TIDBDataSourceDataLink* FIDBDataSourceDataLink;
	Elinspector::TElInspectorClassesList* FElRegClass;
	virtual Elinspector::TElCategories* __fastcall GetCategories(void);
	virtual Elinspector::TElInspectorClassesList* __fastcall GetRegClass(void);
	virtual void __fastcall SetCategories(Elinspector::TElCategories* const Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* const Value);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall NeedCategory(System::TObject* Sender, Elinspector::TElInspectorData* AItem, int &AIndex);
	void __fastcall DBItemDeletion(System::TObject* Sender, Eltree::TElTreeItem* Item);
	
public:
	__fastcall virtual TElInspectorDBDataSource(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElInspectorDBDataSource(void);
	virtual Elinspector::TElEnumerator* __fastcall CreateEnumerator(Elinspector::TElInspectorData* Item);
	virtual void __fastcall DestroyEnumerator(Elinspector::TElEnumerator* AEnum);
	__property Elinspector::TElInspectorClassesList* RegisterList = {read=GetRegClass};
	virtual void __fastcall ClearItemIndex(void);
	virtual void __fastcall RegisterDataLink(Elinspector::TElInspectorDataLink* Value);
	virtual void __fastcall UnregisterDataLink(Elinspector::TElInspectorDataLink* Value);
	
__published:
	__property Categories;
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TIDBDataSourceDataLink : public Data::Db::TDataLink
{
	typedef Data::Db::TDataLink inherited;
	
private:
	TElInspectorDBDataSource* FInspectorDataSource;
	
protected:
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall DataSetScrolled(int Distance);
	
public:
	__fastcall TIDBDataSourceDataLink(TElInspectorDBDataSource* AInspectorDataSource);
public:
	/* TDataLink.Destroy */ inline __fastcall virtual ~TIDBDataSourceDataLink(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElDBInspectorInplaceMemoEdit : public Eltreememoedit::TElTreeInplaceMemoEdit
{
	typedef Eltreememoedit::TElTreeInplaceMemoEdit inherited;
	
protected:
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
public:
	/* TElTreeInplaceMemoEdit.Create */ inline __fastcall virtual TElDBInspectorInplaceMemoEdit(System::Classes::TComponent* AOwner) : Eltreememoedit::TElTreeInplaceMemoEdit(AOwner) { }
	/* TElTreeInplaceMemoEdit.Destroy */ inline __fastcall virtual ~TElDBInspectorInplaceMemoEdit(void) { }
	
};


class PASCALIMPLEMENTATION TElDBInspectorInplaceDateTimeEdit : public Eltreedtpickedit::TElTreeInplaceDateTimePicker
{
	typedef Eltreedtpickedit::TElTreeInplaceDateTimePicker inherited;
	
protected:
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
public:
	/* TElTreeInplaceDateTimePicker.Create */ inline __fastcall virtual TElDBInspectorInplaceDateTimeEdit(System::Classes::TComponent* AOwner) : Eltreedtpickedit::TElTreeInplaceDateTimePicker(AOwner) { }
	/* TElTreeInplaceDateTimePicker.Destroy */ inline __fastcall virtual ~TElDBInspectorInplaceDateTimeEdit(void) { }
	
};


class PASCALIMPLEMENTATION TElDBInspectorInplaceCurrEdit : public Eltreecurredit::TElTreeInplaceCurrencyEdit
{
	typedef Eltreecurredit::TElTreeInplaceCurrencyEdit inherited;
	
protected:
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	
public:
	__fastcall virtual TElDBInspectorInplaceCurrEdit(System::Classes::TComponent* AOwner);
public:
	/* TElTreeInplaceCurrencyEdit.Destroy */ inline __fastcall virtual ~TElDBInspectorInplaceCurrEdit(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eldbinspector */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDBINSPECTOR)
using namespace Eldbinspector;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldbinspectorHPP
