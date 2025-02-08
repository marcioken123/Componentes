// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDBCurrEdit.pas' rev: 31.00 (Windows)

#ifndef EldbcurreditHPP
#define EldbcurreditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <ElDBCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <ElCurrEdit.hpp>
#include <LMDTypes.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <ElXPThemedControl.hpp>
#include <ElVCLUtils.hpp>
#include <ElEdits.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldbcurredit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElDBCurrencyEdit;
class DELPHICLASS TElHackCurrPartEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElDBCurrencyEdit : public Elcurredit::TElCurrencyEdit
{
	typedef Elcurredit::TElCurrencyEdit inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::Classes::TShortCut FNullValueKey;
	System::Word __fastcall SKey(void);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	void __fastcall DataChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	HIDESBASE bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	void __fastcall UpdateData(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	bool __fastcall GetDBReadOnlyState(void);
	void __fastcall ActiveChange(System::TObject* Sender);
	
protected:
	virtual void __fastcall SetValueUndefined(bool Value);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall DoOnChange(void);
	
public:
	__fastcall virtual TElDBCurrencyEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBCurrencyEdit(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Data::Db::TField* Field = {read=GetField};
	
__published:
	__property System::Classes::TShortCut NullValueKey = {read=FNullValueKey, write=FNullValueKey, default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property DisplayReadOnlyOptions;
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBCurrencyEdit(HWND ParentWindow) : Elcurredit::TElCurrencyEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElHackCurrPartEdit : public Elcurredit::TElCurrPartEdit
{
	typedef Elcurredit::TElCurrPartEdit inherited;
	
public:
	/* TCustomElEdit.Create */ inline __fastcall virtual TElHackCurrPartEdit(System::Classes::TComponent* AOwner) : Elcurredit::TElCurrPartEdit(AOwner) { }
	/* TCustomElEdit.Destroy */ inline __fastcall virtual ~TElHackCurrPartEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElHackCurrPartEdit(HWND ParentWindow) : Elcurredit::TElCurrPartEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eldbcurredit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDBCURREDIT)
using namespace Eldbcurredit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldbcurreditHPP
