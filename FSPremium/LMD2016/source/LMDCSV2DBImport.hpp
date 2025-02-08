// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCSV2DBImport.pas' rev: 31.00 (Windows)

#ifndef Lmdcsv2dbimportHPP
#define Lmdcsv2dbimportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.DBCtrls.hpp>
#include <Data.DB.hpp>
#include <LMDClass.hpp>
#include <LMDCSVImport.hpp>
#include <LMDImport.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcsv2dbimport
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBFieldConnect;
class DELPHICLASS TLMDDBFieldConnections;
class DELPHICLASS TLMDDBImportLink;
class DELPHICLASS TLMDCSV2DBImport;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBFieldConnect : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	__int64 FTokenNum;
	bool FPrimary;
	void __fastcall SetDataField(const System::UnicodeString aValue);
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	void __fastcall SetPrimary(bool aValue);
	
public:
	__fastcall virtual TLMDDBFieldConnect(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDDBFieldConnect(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property Data::Db::TField* Field = {read=GetField};
	
__published:
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource};
	__property Index;
	__property bool Primary = {read=FPrimary, write=SetPrimary, default=0};
	__property __int64 TokenNum = {read=FTokenNum, write=FTokenNum};
	__property DisplayName = {default=0};
};


typedef void __fastcall (__closure *TLMDCustomSetToken)(TLMDDBFieldConnect* Sender, System::UnicodeString tokenVal);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDBFieldConnections : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TLMDDBFieldConnect* operator[](int Index) { return this->Items[Index]; }
	
private:
	HIDESBASE TLMDDBFieldConnect* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDDBFieldConnect* Value);
	
protected:
	virtual __int64 __fastcall getTokenCount(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SelectAsPrimary(TLMDDBFieldConnect* aField);
	
public:
	HIDESBASE TLMDDBFieldConnect* __fastcall Add(void);
	__property TLMDDBFieldConnect* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TLMDDBFieldConnections(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDDBFieldConnections(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDBImportLink : public Data::Db::TDataLink
{
	typedef Data::Db::TDataLink inherited;
	
protected:
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall LayoutChanged(void);
	
public:
	__fastcall TLMDDBImportLink(void);
public:
	/* TDataLink.Destroy */ inline __fastcall virtual ~TLMDDBImportLink(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDDBImportOption : unsigned char { ioAppendNew, ioUpdateExisting, ioEmptyDB };

typedef System::Set<TLMDDBImportOption, TLMDDBImportOption::ioAppendNew, TLMDDBImportOption::ioEmptyDB> TLMDDBImportOptions;

typedef void __fastcall (__closure *TLMDOnUpdateRecordField)(System::TObject* Sender, __int64 recNo, Data::Db::TField* Field, const System::UnicodeString newVal, bool &update);

class PASCALIMPLEMENTATION TLMDCSV2DBImport : public Lmdcsvimport::TLMDCSVImport
{
	typedef Lmdcsvimport::TLMDCSVImport inherited;
	
private:
	TLMDDBFieldConnections* FFieldConnections;
	TLMDDBImportOptions FImportOptions;
	TLMDDBImportLink* FDataSourceLink;
	bool FUpdatingRecord;
	TLMDOnUpdateRecordField FOnUpdateField;
	TLMDCustomSetToken FOnSetTokenValue;
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetFieldConnections(TLMDDBFieldConnections* aValue);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	virtual __int64 __fastcall getTokenCount(void);
	virtual bool __fastcall BeginImport(void);
	virtual void __fastcall ProcessToken(const System::UnicodeString aToken, __int64 aTokenNum);
	virtual bool __fastcall ProcessRecordStart(void);
	virtual void __fastcall ProcessRecordEnd(void);
	
public:
	__fastcall virtual TLMDCSV2DBImport(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCSV2DBImport(void);
	
__published:
	__property TLMDDBFieldConnections* FieldConnections = {read=FFieldConnections, write=SetFieldConnections};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property TLMDDBImportOptions Options = {read=FImportOptions, write=FImportOptions, default=1};
	__property TLMDOnUpdateRecordField OnUpdateField = {read=FOnUpdateField, write=FOnUpdateField};
	__property TLMDCustomSetToken OnSetTokenValue = {read=FOnSetTokenValue, write=FOnSetTokenValue};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcsv2dbimport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCSV2DBIMPORT)
using namespace Lmdcsv2dbimport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Lmdcsv2dbimportHPP
