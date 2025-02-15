// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwstorep.pas' rev: 6.00

#ifndef wwstorepHPP
#define wwstorepHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <BDE.hpp>	// Pascal unit
#include <Wwtypes.hpp>	// Pascal unit
#include <Wwtable.hpp>	// Pascal unit
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

namespace Wwstorep
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwStoredProc;
typedef void __fastcall (__closure *TwwStoredProcFilterEvent)(TwwStoredProc* StoredProc, bool &Accept);

class PASCALIMPLEMENTATION TwwStoredProc : public Dbtables::TStoredProc 
{
	typedef Dbtables::TStoredProc inherited;
	
private:
	Classes::TStrings* FLookupFields;
	Classes::TStrings* FLookupLinks;
	Classes::TStrings* FControlType;
	Classes::TStrings* FPictureMasks;
	bool FUsePictureMask;
	Wwtypes::TwwInvalidValueEvent FOnInvalidValue;
	Wwtypes::TwwOnFilterOptions FOnFilterOptions;
	Db::TDataSetNotifyEvent FOnFilterEscape;
	TwwStoredProcFilterEvent FOnFilter;
	void *FFilterBuffer;
	char *FFilterFieldBuffer;
	Bde::_hDBIObj *hFilterFunction;
	Db::TParam* FFilterParam;
	void __fastcall SetOnFilter(TwwStoredProcFilterEvent val);
	Classes::TStrings* __fastcall GetLookupFields(void);
	void __fastcall SetLookupFields(Classes::TStrings* sel);
	Classes::TStrings* __fastcall GetLookupLinks(void);
	void __fastcall SetLookupLinks(Classes::TStrings* sel);
	Classes::TStrings* __fastcall GetControlType(void);
	void __fastcall SetControlType(Classes::TStrings* sel);
	Classes::TStrings* __fastcall GetPictureMasks(void);
	void __fastcall SetPictureMasks(Classes::TStrings* sel);
	void __fastcall SetOnFilterOptions(Wwtypes::TwwOnFilterOptions val);
	
protected:
	virtual void __fastcall DoOnCalcFields(void);
	virtual void __fastcall DoAfterOpen(void);
	virtual void __fastcall DoBeforePost(void);
	virtual void __fastcall DataEvent(Db::TDataEvent Event, int Info);
	virtual int __fastcall GetNextRecords(void);
	void __fastcall ResetMouseCursor(void);
	
public:
	Classes::TList* LookupTables;
	bool InFilterEvent;
	bool ProcessingOnFilter;
	virtual bool __fastcall IsSequenced(void);
	__fastcall virtual TwwStoredProc(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwStoredProc(void);
	bool __fastcall IsValidField(AnsiString fieldName);
	void __fastcall RemoveObsoleteLinks(void);
	void __fastcall FreeLookupTables(void);
	Db::TParam* __fastcall wwFilterField(AnsiString AFieldName);
	
__published:
	__property Classes::TStrings* ControlType = {read=GetControlType, write=SetControlType};
	__property Classes::TStrings* LookupFields = {read=GetLookupFields, write=SetLookupFields};
	__property Classes::TStrings* LookupLinks = {read=GetLookupLinks, write=SetLookupLinks};
	__property Classes::TStrings* PictureMasks = {read=GetPictureMasks, write=SetPictureMasks};
	__property bool ValidateWithMask = {read=FUsePictureMask, write=FUsePictureMask, nodefault};
	__property TwwStoredProcFilterEvent OnFilter = {read=FOnFilter, write=SetOnFilter};
	__property Db::TDataSetNotifyEvent OnFilterEscape = {read=FOnFilterEscape, write=FOnFilterEscape};
	__property Wwtypes::TwwOnFilterOptions OnFilterOptions = {read=FOnFilterOptions, write=SetOnFilterOptions, default=3};
	__property Wwtypes::TwwInvalidValueEvent OnInvalidValue = {read=FOnInvalidValue, write=FOnInvalidValue};
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwstorep)
extern PACKAGE void __fastcall Register(void);

}	/* namespace Wwstorep */
using namespace Wwstorep;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwstorep
