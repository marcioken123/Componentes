// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDBDTPick.pas' rev: 31.00 (Windows)

#ifndef EldbdtpickHPP
#define EldbdtpickHPP

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
#include <System.Variants.hpp>
#include <ElDTPick.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <LMDTypes.hpp>
#include <System.Types.hpp>
#include <ElVCLUtils.hpp>
#include <Vcl.Menus.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <ElXPThemedControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldbdtpick
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElDBDateTimePicker;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElDBDateTimePicker : public Eldtpick::TElDateTimePicker
{
	typedef Eldtpick::TElDateTimePicker inherited;
	
private:
	System::Classes::TShortCut FNullValueKey;
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	bool FNowForNULLValues;
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall ActiveChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall SetDataSource(Data::Db::TDataSource* Value);
	void __fastcall UpdateData(System::TObject* Sender);
	bool __fastcall GetDBReadOnlyState(void);
	
protected:
	virtual void __fastcall SetDateTime(System::TDateTime newValue);
	bool __fastcall DataLink_GetReadOnly(void);
	void __fastcall DataLink_SetReadOnly(bool Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetModified(bool newValue);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Message);
	virtual void __fastcall CloseUp(bool AcceptValue);
	virtual void __fastcall DropDown(void);
	HIDESBASE void __fastcall SpinUpClick(System::TObject* Sender, double Increment);
	HIDESBASE void __fastcall SpinDownClick(System::TObject* Sender, double Increment);
	
public:
	__fastcall virtual TElDBDateTimePicker(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBDateTimePicker(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Data::Db::TField* Field = {read=GetField};
	
__published:
	__property System::Classes::TShortCut NullValueKey = {read=FNullValueKey, write=FNullValueKey, default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=DataLink_GetReadOnly, write=DataLink_SetReadOnly, default=0};
	__property bool NowForNULLValues = {read=FNowForNULLValues, write=FNowForNULLValues, default=0};
	__property UnassignedAllowed = {default=1};
	__property DisplayReadOnlyOptions;
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBDateTimePicker(HWND ParentWindow) : Eldtpick::TElDateTimePicker(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eldbdtpick */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDBDTPICK)
using namespace Eldbdtpick;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldbdtpickHPP
