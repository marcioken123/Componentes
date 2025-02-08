// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CoolDBUtils.pas' rev: 5.00

#ifndef CoolDBUtilsHPP
#define CoolDBUtilsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Registry.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Bde.hpp>	// Pascal unit
#include <FileCtrl.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Cooldbutils
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TTablesAction { taAll, taFromMask, taFromList };
#pragma option pop

typedef SmallString<128>  TBDEString;

typedef void __fastcall (__closure *TActionInProgress)(System::TObject* Sender, int TablesNum, AnsiString 
	CurName, int CurNum);

class DELPHICLASS TDBCUAboutBox;
class PASCALIMPLEMENTATION TDBCUAboutBox : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TDBCUAboutBox(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TDBCUAboutBox(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCoolDBComponent;
class PASCALIMPLEMENTATION TCoolDBComponent : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TDBCUAboutBox* FAboutBox;
	TBDEString FDatabaseName;
	TTablesAction FTablesAction;
	Classes::TStrings* FTables;
	AnsiString FTablesMask;
	TActionInProgress FOnActionInProgress;
	Classes::TNotifyEvent FOnExecuteBegin;
	Classes::TNotifyEvent FOnExecuteEnd;
	void __fastcall SetDatabaseName( TBDEString &Value);
	void __fastcall SetTables(Classes::TStrings* Value);
	
protected:
	DYNAMIC void __fastcall BeginExecute(void);
	DYNAMIC void __fastcall EndExecute(void);
	
public:
	__fastcall virtual TCoolDBComponent(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolDBComponent(void);
	DYNAMIC void __fastcall Execute(void) = 0 ;
	__property TBDEString DatabaseName = {read=FDatabaseName, write=SetDatabaseName};
	__property TTablesAction TablesAction = {read=FTablesAction, write=FTablesAction, default=0};
	__property Classes::TStrings* Tables = {read=FTables, write=SetTables};
	__property AnsiString TablesMask = {read=FTablesMask, write=FTablesMask};
	__property TActionInProgress OnActionInProgress = {read=FOnActionInProgress, write=FOnActionInProgress
		};
	__property Classes::TNotifyEvent OnExecuteBegin = {read=FOnExecuteBegin, write=FOnExecuteBegin};
	__property Classes::TNotifyEvent OnExecuteEnd = {read=FOnExecuteEnd, write=FOnExecuteEnd};
	
__published:
	__property TDBCUAboutBox* About = {read=FAboutBox, write=FAboutBox};
};


class DELPHICLASS TCoolDBBackup;
class PASCALIMPLEMENTATION TCoolDBBackup : public TCoolDBComponent 
{
	typedef TCoolDBComponent inherited;
	
private:
	TBDEString FDatabaseBackupName;
	bool FDeleteOnDone;
	bool FPackOnProgress;
	void __fastcall SetDatabaseBackupName( TBDEString &Value);
	
public:
	__fastcall virtual TCoolDBBackup(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Execute(void);
	
__published:
	__property TBDEString DatabaseBackupName = {read=FDatabaseBackupName, write=SetDatabaseBackupName};
		
	__property bool DeleteOnDone = {read=FDeleteOnDone, write=FDeleteOnDone, default=0};
	__property bool PackOnProgress = {read=FPackOnProgress, write=FPackOnProgress, default=0};
	__property DatabaseName ;
	__property TablesAction ;
	__property Tables ;
	__property TablesMask ;
	__property OnActionInProgress ;
	__property OnExecuteBegin ;
	__property OnExecuteEnd ;
public:
	#pragma option push -w-inl
	/* TCoolDBComponent.Destroy */ inline __fastcall virtual ~TCoolDBBackup(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCoolDBPack;
class PASCALIMPLEMENTATION TCoolDBPack : public TCoolDBComponent 
{
	typedef TCoolDBComponent inherited;
	
public:
	DYNAMIC void __fastcall Execute(void);
	
__published:
	__property DatabaseName ;
	__property TablesAction ;
	__property Tables ;
	__property TablesMask ;
	__property OnActionInProgress ;
	__property OnExecuteBegin ;
	__property OnExecuteEnd ;
public:
	#pragma option push -w-inl
	/* TCoolDBComponent.Create */ inline __fastcall virtual TCoolDBPack(Classes::TComponent* AOwner) : 
		TCoolDBComponent(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCoolDBComponent.Destroy */ inline __fastcall virtual ~TCoolDBPack(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TSortType { stAscending, stDescending };
#pragma option pop

typedef void __fastcall (__closure *TTableSortEvent)(System::TObject* Sender, Dbtables::TTable* Table
	, int &SortFieldIdx, TSortType &SortType);

class DELPHICLASS TCoolDBSort;
class PASCALIMPLEMENTATION TCoolDBSort : public TCoolDBComponent 
{
	typedef TCoolDBComponent inherited;
	
private:
	TBDEString FDatabaseSortedName;
	int FSortFieldIndex;
	TSortType FSortType;
	TTableSortEvent FOnTableSort;
	void __fastcall SetDatabaseSortedName( TBDEString &Value);
	
public:
	__fastcall virtual TCoolDBSort(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Execute(void);
	
__published:
	__property TBDEString DatabaseSortedName = {read=FDatabaseSortedName, write=SetDatabaseSortedName};
		
	__property int SortFieldIndex = {read=FSortFieldIndex, write=FSortFieldIndex, nodefault};
	__property TSortType SortType = {read=FSortType, write=FSortType, nodefault};
	__property TTableSortEvent OnTableSort = {read=FOnTableSort, write=FOnTableSort};
	__property DatabaseName ;
	__property TablesAction ;
	__property Tables ;
	__property TablesMask ;
	__property OnActionInProgress ;
	__property OnExecuteBegin ;
	__property OnExecuteEnd ;
public:
	#pragma option push -w-inl
	/* TCoolDBComponent.Destroy */ inline __fastcall virtual ~TCoolDBSort(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCoolDBStructureExporter;
class PASCALIMPLEMENTATION TCoolDBStructureExporter : public TCoolDBComponent 
{
	typedef TCoolDBComponent inherited;
	
private:
	AnsiString FFileName;
	
public:
	DYNAMIC void __fastcall Execute(void);
	
__published:
	__property AnsiString FileName = {read=FFileName, write=FFileName};
	__property DatabaseName ;
	__property TablesAction ;
	__property Tables ;
	__property TablesMask ;
	__property OnActionInProgress ;
	__property OnExecuteBegin ;
	__property OnExecuteEnd ;
public:
	#pragma option push -w-inl
	/* TCoolDBComponent.Create */ inline __fastcall virtual TCoolDBStructureExporter(Classes::TComponent* 
		AOwner) : TCoolDBComponent(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCoolDBComponent.Destroy */ inline __fastcall virtual ~TCoolDBStructureExporter(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCoolDBStructureRestorer;
class PASCALIMPLEMENTATION TCoolDBStructureRestorer : public TCoolDBComponent 
{
	typedef TCoolDBComponent inherited;
	
private:
	AnsiString FFileName;
	
public:
	DYNAMIC void __fastcall Execute(void);
	
__published:
	__property AnsiString FileName = {read=FFileName, write=FFileName};
	__property DatabaseName ;
	__property TablesAction ;
	__property Tables ;
	__property TablesMask ;
	__property OnActionInProgress ;
	__property OnExecuteBegin ;
	__property OnExecuteEnd ;
public:
	#pragma option push -w-inl
	/* TCoolDBComponent.Create */ inline __fastcall virtual TCoolDBStructureRestorer(Classes::TComponent* 
		AOwner) : TCoolDBComponent(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCoolDBComponent.Destroy */ inline __fastcall virtual ~TCoolDBStructureRestorer(void) { }
	#pragma option pop
	
};


class DELPHICLASS TCoolDBUpdater;
class PASCALIMPLEMENTATION TCoolDBUpdater : public TCoolDBComponent 
{
	typedef TCoolDBComponent inherited;
	
private:
	TBDEString FDatabaseImporterName;
	bool FDeleteOnDone;
	void __fastcall SetDatabaseImporterName( TBDEString &Value);
	
public:
	__fastcall virtual TCoolDBUpdater(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Execute(void);
	
__published:
	__property TBDEString DatabaseImporterName = {read=FDatabaseImporterName, write=SetDatabaseImporterName
		};
	__property bool DeleteOnDone = {read=FDeleteOnDone, write=FDeleteOnDone, default=0};
	__property DatabaseName ;
	__property TablesAction ;
	__property Tables ;
	__property TablesMask ;
	__property OnActionInProgress ;
	__property OnExecuteBegin ;
	__property OnExecuteEnd ;
public:
	#pragma option push -w-inl
	/* TCoolDBComponent.Destroy */ inline __fastcall virtual ~TCoolDBUpdater(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TUpdateOption { uoUpdateFields, uoUpdateIndexes, uoUpdateRI };
#pragma option pop

typedef Set<TUpdateOption, uoUpdateFields, uoUpdateRI>  TUpdateOptions;

class DELPHICLASS TCoolDBUpdater2;
class PASCALIMPLEMENTATION TCoolDBUpdater2 : public TCoolDBUpdater 
{
	typedef TCoolDBUpdater inherited;
	
private:
	TUpdateOptions FUpdateOptions;
	
protected:
	virtual void __fastcall UpdateRI(void);
	
public:
	__fastcall virtual TCoolDBUpdater2(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Execute(void);
	
__published:
	__property TUpdateOptions UpdateOptions = {read=FUpdateOptions, write=FUpdateOptions, default=7};
public:
		
	#pragma option push -w-inl
	/* TCoolDBComponent.Destroy */ inline __fastcall virtual ~TCoolDBUpdater2(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TResultType { rtFieldsUniqueOne, rtFieldsUniqueTwo, rtFieldsAlike, rtFieldsDifferent, rtIndexesUniqueOne, 
	rtIndexesUniqueTwo, rtIndexesAlike, rtIndexesDifferent, rtRIntsUniqueOne, rtRIntsUniqueTwo, rtRIntsAlike, 
	rtRIntsDifferent };
#pragma option pop

class DELPHICLASS TCoolDBTablesCompare;
class PASCALIMPLEMENTATION TCoolDBTablesCompare : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TDBCUAboutBox* FAboutBox;
	Dbtables::TTable* FTableOne;
	Dbtables::TTable* FTableTwo;
	TResultType FResultType;
	Classes::TStringList* FResultList;
	Classes::TNotifyEvent FOnExecuteBegin;
	Classes::TNotifyEvent FOnExecuteEnd;
	bool __fastcall CompareFieldsUniqueOne(void);
	bool __fastcall CompareFieldsUniqueTwo(void);
	bool __fastcall CompareFieldsAlike(void);
	bool __fastcall CompareFieldsDifferent(void);
	bool __fastcall CompareIndexesUniqueOne(void);
	bool __fastcall CompareIndexesUniqueTwo(void);
	bool __fastcall CompareIndexesAlike(void);
	bool __fastcall CompareIndexesDifferent(void);
	bool __fastcall CompareRIntsUniqueOne(void);
	bool __fastcall CompareRIntsUniqueTwo(void);
	bool __fastcall CompareRIntsAlike(void);
	bool __fastcall CompareRIntsDifferent(void);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	DYNAMIC void __fastcall BeginExecute(void);
	DYNAMIC void __fastcall EndExecute(void);
	
public:
	__property Classes::TStringList* ResultList = {read=FResultList};
	__fastcall virtual TCoolDBTablesCompare(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolDBTablesCompare(void);
	bool __fastcall Execute(void);
	
__published:
	__property TDBCUAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property Dbtables::TTable* TableOne = {read=FTableOne, write=FTableOne};
	__property Dbtables::TTable* TableTwo = {read=FTableTwo, write=FTableTwo};
	__property TResultType ResultType = {read=FResultType, write=FResultType, default=2};
	__property Classes::TNotifyEvent OnExecuteBegin = {read=FOnExecuteBegin, write=FOnExecuteBegin};
	__property Classes::TNotifyEvent OnExecuteEnd = {read=FOnExecuteEnd, write=FOnExecuteEnd};
};


#pragma option push -b-
enum TDBResultType { dbrtTablesUniqueOne, dbrtTablesUniqueTwo, dbrtTablesAlike, dbrtTablesDifferent 
	};
#pragma option pop

class DELPHICLASS TCoolDBDatabasesCompare;
class PASCALIMPLEMENTATION TCoolDBDatabasesCompare : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TDBCUAboutBox* FAboutBox;
	TDBResultType FDBResultType;
	TBDEString FDatabaseOneName;
	TBDEString FDatabaseTwoName;
	Classes::TStringList* FResultList;
	Classes::TNotifyEvent FOnExecuteBegin;
	Classes::TNotifyEvent FOnExecuteEnd;
	TActionInProgress FOnActionInProgress;
	void __fastcall SetDatabaseOneName( TBDEString &Value);
	void __fastcall SetDatabaseTwoName( TBDEString &Value);
	bool __fastcall CompareTablesUniqueOne(void);
	bool __fastcall CompareTablesUniqueTwo(void);
	bool __fastcall CompareTablesAlike(void);
	bool __fastcall CompareTablesDifferent(void);
	
protected:
	virtual bool __fastcall CompareTables(Dbtables::TTable* tblOne, Dbtables::TTable* tblTwo);
	DYNAMIC void __fastcall BeginExecute(void);
	DYNAMIC void __fastcall EndExecute(void);
	
public:
	__property Classes::TStringList* ResultList = {read=FResultList};
	__fastcall virtual TCoolDBDatabasesCompare(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolDBDatabasesCompare(void);
	bool __fastcall Execute(void);
	
__published:
	__property TDBCUAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property TBDEString DatabaseOneName = {read=FDatabaseOneName, write=SetDatabaseOneName};
	__property TBDEString DatabaseTwoName = {read=FDatabaseTwoName, write=SetDatabaseTwoName};
	__property TDBResultType ResultType = {read=FDBResultType, write=FDBResultType, default=2};
	__property TActionInProgress OnActionInProgress = {read=FOnActionInProgress, write=FOnActionInProgress
		};
	__property Classes::TNotifyEvent OnExecuteBegin = {read=FOnExecuteBegin, write=FOnExecuteBegin};
	__property Classes::TNotifyEvent OnExecuteEnd = {read=FOnExecuteEnd, write=FOnExecuteEnd};
};


class DELPHICLASS TCoolBDEInformant;
class PASCALIMPLEMENTATION TCoolBDEInformant : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TDBCUAboutBox* FAboutBox;
	Bde::SYSVersion __fastcall GetBDEVersionInfo(void);
	Word __fastcall GetBDEVersion(void);
	Word __fastcall GetBDEInterfaceLevel(void);
	System::TDateTime __fastcall GetBDEVersionTime(void);
	System::TDateTime __fastcall GetBDEVersionDate(void);
	Bde::SYSInfo __fastcall GetBDEInfo(void);
	Word __fastcall GetBDEBufferSpace(void);
	Word __fastcall GetBDEHeapSpace(void);
	Word __fastcall GetBDEDrivers(void);
	Word __fastcall GetBDEClients(void);
	Word __fastcall GetBDESessions(void);
	Word __fastcall GetBDEDatabases(void);
	Word __fastcall GetBDECursors(void);
	Bde::SYSConfig __fastcall GetBDEConfigInfo(void);
	bool __fastcall GetBDELocalShare(void);
	AnsiString __fastcall GetBDENetType(void);
	AnsiString __fastcall GetBDEUserName(void);
	AnsiString __fastcall GetBDEIniFile(void);
	AnsiString __fastcall GetBDELangDriver(void);
	
public:
	__property Word BDEVersion = {read=GetBDEVersion, nodefault};
	__property Word BDEInterfaceLevel = {read=GetBDEInterfaceLevel, nodefault};
	__property System::TDateTime BDEVersionTime = {read=GetBDEVersionTime};
	__property System::TDateTime BDEVersionDate = {read=GetBDEVersionDate};
	__property Word BDEBufferSpace = {read=GetBDEBufferSpace, nodefault};
	__property Word BDEHeapSpace = {read=GetBDEHeapSpace, nodefault};
	__property Word BDEDrivers = {read=GetBDEDrivers, nodefault};
	__property Word BDEClients = {read=GetBDEClients, nodefault};
	__property Word BDESessions = {read=GetBDESessions, nodefault};
	__property Word BDEDatabases = {read=GetBDEDatabases, nodefault};
	__property Word BDECursors = {read=GetBDECursors, nodefault};
	__property bool BDELocalShare = {read=GetBDELocalShare, nodefault};
	__property AnsiString BDENetType = {read=GetBDENetType};
	__property AnsiString BDEUserName = {read=GetBDEUserName};
	__property AnsiString BDEIniFile = {read=GetBDEIniFile};
	__property AnsiString BDELangDriver = {read=GetBDELangDriver};
	
__published:
	__property TDBCUAboutBox* About = {read=FAboutBox, write=FAboutBox};
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TCoolBDEInformant(Classes::TComponent* AOwner) : 
		Classes::TComponent(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TCoolBDEInformant(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall CopyTable(Dbtables::TTable* &Table, AnsiString SrcTableName, AnsiString 
	DestName);
extern PACKAGE bool __fastcall AliasExists(AnsiString AliasName);
extern PACKAGE bool __fastcall TableExists(AnsiString AliasName, AnsiString TableName);
extern PACKAGE AnsiString __fastcall GetAliasPath(AnsiString AliasName);
extern PACKAGE void __fastcall ChangeField(Dbtables::TTable* Table, Db::TField* Field, Bde::pFLDDesc 
	FieldsDesc);
extern PACKAGE void __fastcall AddField(Dbtables::TTable* Table, Bde::pFLDDesc FieldsDesc);
extern PACKAGE void __fastcall InsertField(Dbtables::TTable* Table, Bde::pFLDDesc FieldsDesc, int NewOrd
	);
extern PACKAGE void __fastcall DeleteField(Dbtables::TTable* Table, Db::TField* Field);
extern PACKAGE void __fastcall MoveField(Dbtables::TTable* Tbl, AnsiString Fldname, int NewOrd);
extern PACKAGE Classes::TStringList* __fastcall GetFields(Dbtables::TTable* Table);
extern PACKAGE bool __fastcall GetFieldDesc(Dbtables::TTable* Table, AnsiString FieldName, Bde::FLDDesc 
	&FieldDesc);
extern PACKAGE bool __fastcall FieldsEqual(const Bde::FLDDesc &FieldDesc1, const Bde::FLDDesc &FieldDesc2
	);
extern PACKAGE void __fastcall TableRestructure(Dbtables::TTable* tblSource, Dbtables::TTable* tblDestination
	);
extern PACKAGE void __fastcall AddPrimaryIndex(Dbtables::TTable* Table);
extern PACKAGE void __fastcall AddAnyIndex(Dbtables::TTable* Table, const Bde::IDXDesc &NewIndex);
extern PACKAGE bool __fastcall IndexesEqual(const Bde::IDXDesc &IndexDesc1, const Bde::IDXDesc &IndexDesc2
	);
extern PACKAGE void __fastcall ChangeIndex(Dbtables::TTable* Table, const Bde::IDXDesc &IndexDesc, int 
	Index);
extern PACKAGE Classes::TStringList* __fastcall GetIndexes(Dbtables::TTable* Table);
extern PACKAGE bool __fastcall GetIndexDesc(Dbtables::TTable* Table, AnsiString IndexName, Bde::IDXDesc 
	&IndexDesc);
extern PACKAGE void __fastcall IndexesRestructure(Dbtables::TTable* tblSource, Dbtables::TTable* tblDestination
	);
extern PACKAGE Classes::TStringList* __fastcall GetRIs(Dbtables::TTable* Table);
extern PACKAGE bool __fastcall GetRIDesc(Dbtables::TTable* Table, AnsiString RiName, Bde::RINTDesc &
	RiDesc);
extern PACKAGE bool __fastcall RIEqual(const Bde::RINTDesc &RIDesc1, const Bde::RINTDesc &RIDesc2);
extern PACKAGE void __fastcall RemoveRITotal(Dbtables::TTable* Detail);
extern PACKAGE void __fastcall RIRestructure(Dbtables::TTable* TableToGet, Dbtables::TTable* TableToModify
	);
extern PACKAGE bool __fastcall DelphiRunning(void);
extern PACKAGE bool __fastcall DelphiRunningByExeName(AnsiString AFileName);

}	/* namespace Cooldbutils */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Cooldbutils;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CoolDBUtils
