// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.Bind.DBLinks.pas' rev: 34.00 (Windows)

#ifndef Vcltee_Bind_DblinksHPP
#define Vcltee_Bind_DblinksHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Generics.Collections.hpp>
#include <Data.DB.hpp>
#include <Data.Bind.DBLinks.hpp>
#include <Data.Bind.Components.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <System.SysUtils.hpp>
#include <System.Generics.Defaults.hpp>
#include <System.Types.hpp>
#include <Data.Bind.DBScope.hpp>

//-- user supplied -----------------------------------------------------------
#pragma link "VCLTee.Bind.DBLinks"

namespace Vcltee
{
namespace Bind
{
namespace Dblinks
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDBGridLinkColumn;
class DELPHICLASS TDBGridLinkColumns;
class DELPHICLASS TCustomBindDBChartLink;
class DELPHICLASS TBindDBChartLink;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TDBGridLinkColumn : public Data::Bind::Dblinks::TBaseDBGridLinkColumn
{
	typedef Data::Bind::Dblinks::TBaseDBGridLinkColumn inherited;
	
public:
	/* TBaseDBGridLinkColumn.Create */ inline __fastcall virtual TDBGridLinkColumn(System::Classes::TCollection* Collection) : Data::Bind::Dblinks::TBaseDBGridLinkColumn(Collection) { }
	/* TBaseDBGridLinkColumn.Destroy */ inline __fastcall virtual ~TDBGridLinkColumn() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TDBGridLinkColumns : public Data::Bind::Dblinks::TBaseDBGridLinkColumns
{
	typedef Data::Bind::Dblinks::TBaseDBGridLinkColumns inherited;
	
public:
	/* TBaseDBGridLinkColumns.Create */ inline __fastcall virtual TDBGridLinkColumns(System::Classes::TComponent* Grid, Data::Bind::Dblinks::TBaseDBGridLinkColumnClass ColumnClass) : Data::Bind::Dblinks::TBaseDBGridLinkColumns(Grid, ColumnClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TDBGridLinkColumns() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TCustomBindDBChartLink : public Data::Bind::Dblinks::TBaseBindDBGridLink
{
	typedef Data::Bind::Dblinks::TBaseBindDBGridLink inherited;
	
private:
	System::Generics::Collections::TDictionary__2<System::TObject*,int>* FColumnDescriptionsLookup;
	System::Generics::Collections::TList__1<Data::Bind::Dblinks::TDBGridLinkColumnDescription>* FColumnDescriptions;
	TDBGridLinkColumns* FColumns;
	void __fastcall CreateDefaultGridColumns();
	void __fastcall CreateCollectionGridColumns();
	void __fastcall SetColumns(TDBGridLinkColumns* Value);
	bool __fastcall ColumnsHaveChanged();
	System::DynamicArray<Data::Bind::Dblinks::TDBGridLinkColumnDescription> __fastcall CreateDefaultGridColumnDescriptions();
	System::DynamicArray<Data::Bind::Dblinks::TDBGridLinkColumnDescription> __fastcall CreateCollectionGridColumnDescriptions();
	System::DynamicArray<Data::Bind::Dblinks::TDBGridLinkColumnDescription> __fastcall CreateGridColumnDescriptions();
	Vcltee::Chart::TCustomChart* __fastcall GetChart();
	void __fastcall SetChart(Vcltee::Chart::TCustomChart* const Value);
	
protected:
	virtual Data::Bind::Dblinks::TBaseDBGridLinkColumns* __fastcall GetColumns();
	virtual void __fastcall InvalidateColumn(Data::Bind::Dblinks::TBaseDBGridLinkColumn* AColumn);
	virtual void __fastcall InvalidateField(Data::Db::TField* AField);
	virtual void __fastcall ClearColumns(Data::Bind::Dblinks::_di_IBindDBGridLinkControlManager AManager);
	
public:
	__fastcall virtual TCustomBindDBChartLink(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomBindDBChartLink();
	void __fastcall AddSeries(Vcltee::Teengine::TChartSeries* ASeries, const System::UnicodeString AFieldName)/* overload */;
	void __fastcall AddSeries(Vcltee::Teengine::TChartSeries* ASeries, Data::Db::TField* AField)/* overload */;
	virtual void __fastcall ClearGeneratedExpressions(System::Classes::TComponent* Sender);
	void __fastcall CreateGridColumns();
	virtual void __fastcall GenerateExpressions(System::Classes::TComponent* Sender);
	virtual bool __fastcall RequiresControlHandler();
	virtual void __fastcall UpdateColumns();
	__property Vcltee::Chart::TCustomChart* Chart = {read=GetChart, write=SetChart};
	__property TDBGridLinkColumns* Columns = {read=FColumns, write=SetColumns};
};


class PASCALIMPLEMENTATION TBindDBChartLink : public TCustomBindDBChartLink
{
	typedef TCustomBindDBChartLink inherited;
	
__published:
	__property DataSource;
	__property Chart;
	__property AutoActivate = {default=1};
	__property BufferCount = {default=-1};
	__property Columns;
	__property OnAssignedValue;
	__property OnAssigningValue;
	__property OnEvalError;
	__property OnActivating;
	__property OnActivated;
public:
	/* TCustomBindDBChartLink.Create */ inline __fastcall virtual TBindDBChartLink(System::Classes::TComponent* AOwner) : TCustomBindDBChartLink(AOwner) { }
	/* TCustomBindDBChartLink.Destroy */ inline __fastcall virtual ~TBindDBChartLink() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Dblinks */
}	/* namespace Bind */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_BIND_DBLINKS)
using namespace Vcltee::Bind::Dblinks;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_BIND)
using namespace Vcltee::Bind;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_Bind_DblinksHPP
