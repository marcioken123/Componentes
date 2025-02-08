// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Wwtable.pas' rev: 6.00

#ifndef WwtableHPP
#define WwtableHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <BDE.hpp>	// Pascal unit
#include <Wwtypes.hpp>	// Pascal unit
#include <Wwlocate.hpp>	// Pascal unit
#include <wwSystem.hpp>	// Pascal unit
#include <Wwstr.hpp>	// Pascal unit
#include <wwfilter.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwtable
{
//-- type declarations -------------------------------------------------------
typedef bool *PtrBoolean;

typedef TStrings TwwTableDisplayType;
;

class DELPHICLASS TwwTable;
typedef void __fastcall (__closure *TwwTableFilterEvent)(TwwTable* table, bool &accept);

class PASCALIMPLEMENTATION TwwTable : public Dbtables::TTable 
{
	typedef Dbtables::TTable inherited;
	
private:
	Classes::TStrings* FFilter;
	Classes::TStrings* FQuery;
	Classes::TStrings* FPictureMasks;
	Classes::TStrings* FLookupFields;
	Classes::TStrings* FLookupLinks;
	Classes::TStrings* FControlType;
	bool FUsePictureMask;
	bool FSyncSQLByRange;
	bool FNarrowSearch;
	Wwtypes::TwwInvalidValueEvent FOnInvalidValue;
	Wwtypes::TwwOnFilterOptions FOnFilterOptions;
	Db::TDataSetNotifyEvent FOnFilterEscape;
	TwwTableFilterEvent FOnFilter;
	void *FFilterBuffer;
	char *FFilterFieldBuffer;
	Bde::_hDBIObj *hFilter;
	Bde::_hDBIObj *hFilterFunction;
	Db::TParam* FFilterParam;
	bool FIsSequencable;
	Word FNarrowSearchUpperChar;
	AnsiString QueryType;
	Classes::TNotifyEvent FOnDestroy;
	Classes::TList* dependentPtrs;
	Bde::_hDBIObj *rangeFilter;
	bool isOpen;
	Classes::TStrings* PdxMasks;
	bool InitPdxMasks;
	int CallCount;
	Classes::TStrings* __fastcall getLookupFields(void);
	void __fastcall setLookupFields(Classes::TStrings* sel);
	Classes::TStrings* __fastcall getPictureMasks(void);
	void __fastcall setPictureMasks(Classes::TStrings* sel);
	Classes::TStrings* __fastcall getLookupLinks(void);
	void __fastcall setLookupLinks(Classes::TStrings* sel);
	Classes::TStrings* __fastcall getControlType(void);
	void __fastcall setControlType(Classes::TStrings* sel);
	void __fastcall setFilterArray(Classes::TStrings* sel);
	Classes::TStrings* __fastcall getFilter(void);
	void __fastcall SetOnFilter(TwwTableFilterEvent val);
	int __fastcall GetFilterCount(void);
	void __fastcall SetQuery(Classes::TStrings* sel);
	bool __fastcall isSequencableTable(void);
	HIDESBASE void __fastcall SetTableName(const AnsiString Value);
	AnsiString __fastcall GetTableName();
	void __fastcall DoInitPdxMasks(void);
	bool __fastcall FindFieldsToIndex(AnsiString AIndexFields, bool CaseSensitive, bool exactFieldMatch, AnsiString &newIndexName);
	void __fastcall SetOnFilterOptions(Wwtypes::TwwOnFilterOptions val);
	
protected:
	virtual void __fastcall PrepareCursor(void);
	virtual void __fastcall OpenCursor(bool InfoQuery);
	virtual void __fastcall CloseCursor(void);
	virtual Bde::hDBICur __fastcall CreateHandle(void);
	Word __fastcall PerformQuery(Bde::hDBICur &AdbiHandle);
	virtual void __fastcall DoBeforePost(void);
	virtual void __fastcall InitFieldDefs(void);
	virtual void __fastcall DoOnCalcFields(void);
	AnsiString __fastcall GetIndexFieldName();
	void __fastcall SetIndexFieldName(AnsiString val);
	virtual void __fastcall DataEvent(Db::TDataEvent Event, int Info);
	virtual int __fastcall GetNextRecords(void);
	void __fastcall ResetMouseCursor(void);
	
public:
	bool UpToDate;
	bool UpToDateRes;
	AnsiString CalcLookupLinks;
	void *wwInternalPtr;
	bool inFilterEvent;
	bool InLookupLink;
	int InFindRecordCount;
	bool IgnoreMasterLink;
	Classes::TList* lookupTables;
	bool ProcessingOnFilter;
	virtual bool __fastcall IsSequenced(void);
	__property bool IsSequencable = {read=FIsSequencable, nodefault};
	__property int FilterCount = {read=GetFilterCount, nodefault};
	__fastcall virtual TwwTable(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwTable(void);
	void __fastcall RefreshLinks(void);
	bool __fastcall IsValidField(AnsiString fieldName);
	void __fastcall RemoveObsoleteLinks(void);
	bool __fastcall SetToIndexContainingFields(Classes::TStrings* selected);
	bool __fastcall SetToIndexContainingField(AnsiString selected);
	void __fastcall SyncSQLTable(Dbtables::TTable* lookupTable);
	void __fastcall FreeLookupTables(void);
	bool __fastcall wwFindNearest(AnsiString key, int FieldNo);
	bool __fastcall wwFindKey(const System::TVarRec * KeyValues, const int KeyValues_Size);
	bool __fastcall wwFindRecord(AnsiString KeyValue, AnsiString LookupField, Wwlocate::TwwLocateMatchType MatchType, bool CaseSensitive);
	void __fastcall wwChangeIndex(Db::TIndexDef* a_indexItem);
	void __fastcall wwChangeIndexName(AnsiString a_indexName);
	void __fastcall AddDependentTablePtr(PtrBoolean a_value);
	void __fastcall RemoveDependentTablePtr(PtrBoolean a_value);
	void __fastcall wwSetRangeStart(const System::TVarRec * startValues, const int startValues_Size);
	bool __fastcall Pack(AnsiString &statusMsg);
	bool __fastcall setFilter(AnsiString sel);
	AnsiString __fastcall FilterString();
	bool __fastcall IsParadoxTable(void);
	bool __fastcall IsDBaseTable(void);
	bool __fastcall FilterActivate(void);
	Db::TParam* __fastcall wwFilterField(AnsiString AFieldName);
	AnsiString __fastcall IndexToFields(AnsiString aIndexName);
	AnsiString __fastcall FieldsToIndex(AnsiString aIndexFields);
	AnsiString __fastcall FieldstoIndexWithCase(AnsiString aIndexFields, bool caseSensitive);
	AnsiString __fastcall GetDBPicture(AnsiString curFieldName);
	void __fastcall UpdateIndexes(void);
	void __fastcall FastCancelRange(void);
	void __fastcall ClearCurrentRangeBuffers(void);
	bool __fastcall SetLookupField(Db::TField* Field);
	bool __fastcall isCaseInsensitiveIndex(void);
	void __fastcall LoadPdxMasks(void);
	__property Classes::TNotifyEvent OnDestroy = {read=FOnDestroy, write=FOnDestroy};
	__property AnsiString IndexFieldName = {read=GetIndexFieldName, write=SetIndexFieldName};
	
__published:
	__property Classes::TStrings* LookupFields = {read=getLookupFields, write=setLookupFields, stored=true};
	__property Classes::TStrings* LookupLinks = {read=getLookupLinks, write=setLookupLinks, stored=true};
	__property Classes::TStrings* ControlType = {read=getControlType, write=setControlType, stored=true};
	__property Classes::TStrings* PictureMasks = {read=getPictureMasks, write=setPictureMasks};
	__property Classes::TStrings* wwFilter = {read=getFilter, write=setFilterArray};
	__property bool SyncSQLByRange = {read=FSyncSQLByRange, write=FSyncSQLByRange, nodefault};
	__property bool NarrowSearch = {read=FNarrowSearch, write=FNarrowSearch, nodefault};
	__property Word NarrowSearchUpperChar = {read=FNarrowSearchUpperChar, write=FNarrowSearchUpperChar, default=255};
	__property Classes::TStrings* Query = {read=FQuery, write=SetQuery};
	__property TableName  = {read=GetTableName, write=SetTableName};
	__property bool ValidateWithMask = {read=FUsePictureMask, write=FUsePictureMask, nodefault};
	__property Wwtypes::TwwInvalidValueEvent OnInvalidValue = {read=FOnInvalidValue, write=FOnInvalidValue};
	__property TwwTableFilterEvent OnFilter = {read=FOnFilter, write=SetOnFilter};
	__property Db::TDataSetNotifyEvent OnFilterEscape = {read=FOnFilterEscape, write=FOnFilterEscape};
	__property Wwtypes::TwwOnFilterOptions OnFilterOptions = {read=FOnFilterOptions, write=SetOnFilterOptions, default=3};
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, Wwtable)
extern PACKAGE void __fastcall Register(void);

}	/* namespace Wwtable */
using namespace Wwtable;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Wwtable
