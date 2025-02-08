// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDBSpin.pas' rev: 31.00 (Windows)

#ifndef EldbspinHPP
#define EldbspinHPP

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
#include <ElSpin.hpp>
#include <Vcl.Forms.hpp>
#include <LMDTypes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <ElEdits.hpp>
#include <ElXPThemedControl.hpp>
#include <ElVCLUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldbspin
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElDBSpinEdit;
class DELPHICLASS TElDBFloatSpinEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElDBSpinEdit : public Elspin::TElSpinEdit
{
	typedef Elspin::TElSpinEdit inherited;
	
private:
	System::Classes::TShortCut FNullValueKey;
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall DataChange(System::TObject* Sender);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	bool __fastcall GetCReadOnly(void);
	HIDESBASE void __fastcall SetCReadOnly(bool Value);
	void __fastcall UpdateData(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	bool __fastcall GetDBReadOnlyState(void);
	void __fastcall ActiveChange(System::TObject* Sender);
	
protected:
	virtual void __fastcall SetValueUndefined(bool Value);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SpinDownClick(System::TObject* Sender, double Increment);
	virtual void __fastcall SpinDrag(System::TObject* Sender, double NewValue);
	virtual void __fastcall SpinUpClick(System::TObject* Sender, double Increment);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Msg);
	
public:
	__fastcall virtual TElDBSpinEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBSpinEdit(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Data::Db::TField* Field = {read=GetField};
	
__published:
	__property System::Classes::TShortCut NullValueKey = {read=FNullValueKey, write=FNullValueKey, default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetCReadOnly, write=SetCReadOnly, default=0};
	__property DisplayReadOnlyOptions;
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBSpinEdit(HWND ParentWindow) : Elspin::TElSpinEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElDBFloatSpinEdit : public Elspin::TElFloatSpinEdit
{
	typedef Elspin::TElFloatSpinEdit inherited;
	
private:
	System::Classes::TShortCut FNullValueKey;
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	void __fastcall DataChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	bool __fastcall GetCReadOnly(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	HIDESBASE void __fastcall SetCReadOnly(bool Value);
	void __fastcall UpdateData(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	bool __fastcall GetDBReadOnlyState(void);
	void __fastcall ActiveChange(System::TObject* Sender);
	
protected:
	virtual void __fastcall SetValueUndefined(bool Value);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SpinDownClick(System::TObject* Sender, double Increment);
	virtual void __fastcall SpinDrag(System::TObject* Sender, double NewValue);
	virtual void __fastcall SpinUpClick(System::TObject* Sender, double Increment);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Msg);
	
public:
	__fastcall virtual TElDBFloatSpinEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBFloatSpinEdit(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Data::Db::TField* Field = {read=GetField};
	
__published:
	__property System::Classes::TShortCut NullValueKey = {read=FNullValueKey, write=FNullValueKey, default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetCReadOnly, write=SetCReadOnly, default=0};
	__property DisplayReadOnlyOptions;
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBFloatSpinEdit(HWND ParentWindow) : Elspin::TElFloatSpinEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eldbspin */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDBSPIN)
using namespace Eldbspin;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldbspinHPP
