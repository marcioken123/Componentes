// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBFieldComboBox.pas' rev: 31.00 (Windows)

#ifndef LmddbfieldcomboboxHPP
#define LmddbfieldcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <System.Classes.hpp>
#include <LMDCustomExtCombo.hpp>
#include <LMDCustomListComboBox.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbfieldcombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBFieldComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBFieldComboBox : public Lmdcustomlistcombobox::TLMDCustomListComboBox
{
	typedef Lmdcustomlistcombobox::TLMDCustomListComboBox inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall ActiveChange(System::TObject* Sender);
	Data::Db::TField* __fastcall GetField(void);
	
protected:
	virtual void __fastcall BeforeDropDown(void);
	void __fastcall UpdateItems(void);
	virtual void __fastcall Accept(void);
	virtual bool __fastcall CanDropDown(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBFieldComboBox(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDDBFieldComboBox(void);
	void __fastcall SelectByFieldName(const System::UnicodeString aFieldName);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* AAction);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* AAction);
	__property Data::Db::TField* Field = {read=GetField};
	
__published:
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property OnSelected;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBFieldComboBox(HWND ParentWindow) : Lmdcustomlistcombobox::TLMDCustomListComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbfieldcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBFIELDCOMBOBOX)
using namespace Lmddbfieldcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbfieldcomboboxHPP
