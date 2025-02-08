// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBColorComboBox.pas' rev: 31.00 (Windows)

#ifndef LmddbcolorcomboboxHPP
#define LmddbcolorcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDCustomColorComboBox.hpp>
#include <LMDDBBase.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDThemedComboBox.hpp>
#include <Vcl.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbcolorcombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBColorComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBColorComboBox : public Lmdcustomcolorcombobox::TLMDCustomColorComboBox
{
	typedef Lmdcustomcolorcombobox::TLMDCustomColorComboBox inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetReadOnly(bool aValue);
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	void __fastcall SetDataField(const System::UnicodeString aValue);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	Data::Db::TDataLink* __fastcall GetDataLink(void);
	DYNAMIC void __fastcall Change(void);
	virtual System::Uitypes::TColor __fastcall GetColorValue(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBColorComboBox(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* AAction);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* AAction);
	__fastcall virtual ~TLMDDBColorComboBox(void);
	
__published:
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBColorComboBox(HWND ParentWindow) : Lmdcustomcolorcombobox::TLMDCustomColorComboBox(ParentWindow) { }
	
private:
	void *__IDataControl;	// Lmddbbase::IDataControl 
	
public:
	operator Lmddbbase::IDataControl*(void) { return (Lmddbbase::IDataControl*)&__IDataControl; }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbcolorcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBCOLORCOMBOBOX)
using namespace Lmddbcolorcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbcolorcomboboxHPP
