// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CoolUtility.pas' rev: 5.00

#ifndef CoolUtilityHPP
#define CoolUtilityHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <DBTables.hpp>	// Pascal unit
#include <Bde.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <FileCtrl.hpp>	// Pascal unit
#include <CoolDBUtils.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Coolutility
{
//-- type declarations -------------------------------------------------------
typedef Word hTUses;

typedef Word *phTUses;

#pragma option push -b-
enum TUVerifyProcess { TUVerifyHeader, TUVerifyIndex, TUVerifyData, TUVerifySXHeader, TUVerifySXIndex, 
	TUVerifySXData, TUVerifySXIntegrity, TUVerifyTableName, TURebuild };
#pragma option pop

struct TUVerifyCallBack
{
	Word PercentDone;
	char TableName[261];
	TUVerifyProcess Process;
	Word CurrentIndex;
	Word TotalIndex;
} ;

typedef void __fastcall (__closure *TProgressEvent)(System::TObject* Sender, int PercentDone);

#pragma option push -b-
enum TDatabaseAction { daVerify, daRepair, daVerifyAndRepair };
#pragma option pop

class DELPHICLASS TCoolDBUtility;
class PASCALIMPLEMENTATION TCoolDBUtility : public Cooldbutils::TCoolDBComponent 
{
	typedef Cooldbutils::TCoolDBComponent inherited;
	
private:
	TDatabaseAction FDatabaseAction;
	int FCheckResult;
	Cooldbutils::TBDEString FServiceDatabaseName;
	AnsiString FPassword;
	TProgressEvent FOnHeaderProgress;
	TProgressEvent FOnIndexesProgress;
	TProgressEvent FOnDataProgress;
	TProgressEvent FOnRebuildProgress;
	void __fastcall RegisterCallback(void);
	void __fastcall UnregisterCallback(void);
	char * __fastcall ServiceTablePath(AnsiString Original);
	void __fastcall SetServiceDatabaseName( Cooldbutils::TBDEString &Value);
	void __fastcall SetPassword(AnsiString Value);
	
protected:
	TUVerifyCallBack CbInfo;
	#pragma pack(push, 1)
	Bde::CURProps TUProps;
	#pragma pack(pop)
	
	Word vhTSes;
	int __fastcall TableRepair(AnsiString TableName);
	int __fastcall TableVerify(AnsiString TableName);
	
public:
	__fastcall virtual TCoolDBUtility(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolDBUtility(void);
	DYNAMIC void __fastcall Execute(void);
	
__published:
	__property int CheckResult = {read=FCheckResult, nodefault};
	__property TDatabaseAction DatabaseAction = {read=FDatabaseAction, write=FDatabaseAction, default=0
		};
	__property Cooldbutils::TBDEString ServiceDatabaseName = {read=FServiceDatabaseName, write=SetServiceDatabaseName
		};
	__property AnsiString Password = {read=FPassword, write=SetPassword};
	__property DatabaseName ;
	__property TablesAction ;
	__property Tables ;
	__property TablesMask ;
	__property OnActionInProgress ;
	__property OnExecuteBegin ;
	__property OnExecuteEnd ;
	__property TProgressEvent OnHeaderProgress = {read=FOnHeaderProgress, write=FOnHeaderProgress};
	__property TProgressEvent OnIndexesProgress = {read=FOnIndexesProgress, write=FOnIndexesProgress};
	__property TProgressEvent OnDataProgress = {read=FOnDataProgress, write=FOnDataProgress};
	__property TProgressEvent OnRebuildProgress = {read=FOnRebuildProgress, write=FOnRebuildProgress};
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE unsigned LibHandle;
extern PACKAGE Word __stdcall (*TUInit)(Word &hTUSession);
extern PACKAGE Word __stdcall (*TUVerifyTable)(Word hTUSession, char * pszTableName, char * pszDriverType
	, char * pszErrTableName, char * pszPassword, int iOptions, int &piErrorLevel);
extern PACKAGE Word __stdcall (*TURebuildTable)(Word hTUSession, char * pszTableName, char * pszDriverType
	, char * pszBackupTableName, char * pszKeyviolName, char * pszProblemTableName, Bde::pCRTblDesc pCrDesc
	);
extern PACKAGE Word __stdcall (*TUGetCRTblDescCount)(Word hTUSession, char * pszTableName, Word &iFldCount
	, Word &iIdxCount, Word &iSecRecCount, Word &iValChkCount, Word &iRintCount, Word &iOptParams, Word 
	&iOptDataLen);
extern PACKAGE Word __stdcall (*TUFillCRTblDesc)(Word hTUSession, Bde::pCRTblDesc pCrDesc, char * pszTableName
	, char * pszPassword);
extern PACKAGE Word __stdcall (*TUFillCURProps)(Word hTUSession, char * pszTableName, Bde::CURProps 
	&tblProps);
extern PACKAGE Word __stdcall (*TUGetExtTblProps)(Word hTUSession, char * pszTableName, double &pTS, 
	bool &pbReadOnly);
extern PACKAGE Word __stdcall (*TUExit)(Word hTUSession);
extern PACKAGE Word __stdcall (*TUGetErrorString)(Word iErrorcode, char * pszError);

}	/* namespace Coolutility */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Coolutility;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CoolUtility
