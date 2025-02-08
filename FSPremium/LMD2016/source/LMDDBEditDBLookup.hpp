// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBEditDBLookup.pas' rev: 31.00 (Windows)

#ifndef LmddbeditdblookupHPP
#define LmddbeditdblookupHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDEditDBLookup.hpp>
#include <LMDDBBase.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDSBtn.hpp>
#include <LMDButtonBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbeditdblookup
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBEditDBLookup;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBEditDBLookup : public Lmdeditdblookup::TLMDEditDBLookup
{
	typedef Lmdeditdblookup::TLMDEditDBLookup inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::Classes::TNotifyEvent FOnDataChange;
	void __fastcall SetDataField(const System::UnicodeString aValue);
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	void __fastcall EditingChange(System::TObject* Sender);
	void __fastcall UpDateData(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Msg);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	Data::Db::TDataLink* __fastcall GetDataLink(void);
	virtual void __fastcall DataChange(System::TObject* Sender);
	virtual void __fastcall lookup(void);
	virtual void __fastcall ChangedText(int At);
	virtual void __fastcall BeforeChangeText(void);
	DYNAMIC void __fastcall GetCommandKey(System::Word &KeyCode, System::Classes::TShiftState Shift);
	virtual void __fastcall DrawEditText(int from)/* overload */;
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDDBEditDBLookup(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBEditDBLookup(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* AAction);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* AAction);
	__property Data::Db::TField* Field = {read=GetField};
	
__published:
	__property Alignment = {default=0};
	__property CustomButtons;
	__property CustomButtonWidth = {default=16};
	__property CustomButtonsStyle = {default=9};
	__property ReadOnly = {index=1, default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property System::Classes::TNotifyEvent OnDataChange = {read=FOnDataChange, write=FOnDataChange};
	__property OnBtnClick;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBEditDBLookup(HWND ParentWindow) : Lmdeditdblookup::TLMDEditDBLookup(ParentWindow) { }
	
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  DrawEditText(int from, const Lmdtypes::TLMDString aTxt){ Lmdcustomedit::TLMDCustomEdit::DrawEditText(from, aTxt); }
	
private:
	void *__IDataControl;	// Lmddbbase::IDataControl 
	
public:
	operator Lmddbbase::IDataControl*(void) { return (Lmddbbase::IDataControl*)&__IDataControl; }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbeditdblookup */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBEDITDBLOOKUP)
using namespace Lmddbeditdblookup;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbeditdblookupHPP
