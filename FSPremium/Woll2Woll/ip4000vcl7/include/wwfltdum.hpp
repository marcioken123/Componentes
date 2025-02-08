// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Wwfltdum.pas' rev: 6.00

#ifndef WwfltdumHPP
#define WwfltdumHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ComCtrls.hpp>	// Pascal unit
#include <Wwtypes.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <wwstorep.hpp>	// Pascal unit
#include <Wwqbe.hpp>	// Pascal unit
#include <Wwquery.hpp>	// Pascal unit
#include <Wwtable.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
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

namespace Wwfltdum
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwDummyForm;
class PASCALIMPLEMENTATION TwwDummyForm : public Forms::TCustomForm 
{
	typedef Forms::TCustomForm inherited;
	
private:
	Db::TParam* FFilterParam;
	char *FFilterFieldBuffer;
	
public:
	Classes::TComponent* DlgComponent;
	bool MatchAny;
	Db::TDataSet* DataSet;
	Classes::TMemoryStream* MemoryStream;
	Comctrls::TRichEdit* TempRichEdit;
	void __fastcall OnFilterEvent(Db::TDataSet* table, bool &Accept);
	Db::TParam* __fastcall GetFilterField(AnsiString AFieldName);
	bool __fastcall IsNullValue(AnsiString Token, AnsiString Value, AnsiString NullStr);
	bool __fastcall CheckFilterField(int Index);
	__fastcall virtual TwwDummyForm(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwDummyForm(void);
public:
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TwwDummyForm(Classes::TComponent* AOwner, int Dummy) : Forms::TCustomForm(AOwner, Dummy) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwDummyForm(HWND ParentWindow) : Forms::TCustomForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, Wwfltdum)
extern PACKAGE TwwDummyForm* wwDummyForm;

}	/* namespace Wwfltdum */
using namespace Wwfltdum;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Wwfltdum
