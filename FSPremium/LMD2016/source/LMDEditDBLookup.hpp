// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDEditDBLookup.pas' rev: 31.00 (Windows)

#ifndef LmdeditdblookupHPP
#define LmdeditdblookupHPP

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
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDSBtn.hpp>
#include <LMDButtonBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdeditdblookup
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDEditDBLookup;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDTypeMode : unsigned char { tmLookup, tmFree, tmLookupNew };

typedef void __fastcall (__closure *TLMDNewEntryQueryEvent)(System::TObject* Sender, System::UnicodeString value, bool &accept);

class PASCALIMPLEMENTATION TLMDEditDBLookup : public Lmdcustomedit::TLMDCustomEdit
{
	typedef Lmdcustomedit::TLMDCustomEdit inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FLookupDataLink;
	TLMDTypeMode FTypeMode;
	System::Classes::TNotifyEvent FOnDataChange;
	TLMDNewEntryQueryEvent FOnNewEntry;
	void __fastcall SetLDataField(const System::UnicodeString aValue);
	void __fastcall SetLDataSource(Data::Db::TDataSource* aValue);
	System::UnicodeString __fastcall GetLDataField(void);
	Data::Db::TDataSource* __fastcall GetLDataSource(void);
	Data::Db::TField* __fastcall GetLField(void);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Winapi::Messages::TWMKey &Msg);
	
protected:
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
	__fastcall virtual TLMDEditDBLookup(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDEditDBLookup(void);
	__property Data::Db::TField* LookupField = {read=GetLField};
	
__published:
	__property Alignment = {default=0};
	__property CustomButtons;
	__property CustomButtonsStyle = {default=9};
	__property CustomButtonWidth = {default=16};
	__property CustomButtonParentCtlXP = {default=1};
	__property ReadOnly = {index=1, default=0};
	__property System::UnicodeString LookupDataField = {read=GetLDataField, write=SetLDataField};
	__property Data::Db::TDataSource* LookupDataSource = {read=GetLDataSource, write=SetLDataSource};
	__property Options = {default=56};
	__property TLMDTypeMode TypeMode = {read=FTypeMode, write=FTypeMode, default=1};
	__property TLMDNewEntryQueryEvent OnNewEntry = {read=FOnNewEntry, write=FOnNewEntry};
	__property System::Classes::TNotifyEvent OnDataChange = {read=FOnDataChange, write=FOnDataChange};
	__property OnBtnClick;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDEditDBLookup(HWND ParentWindow) : Lmdcustomedit::TLMDCustomEdit(ParentWindow) { }
	
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  DrawEditText(int from, const Lmdtypes::TLMDString aTxt){ Lmdcustomedit::TLMDCustomEdit::DrawEditText(from, aTxt); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdeditdblookup */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDEDITDBLOOKUP)
using namespace Lmdeditdblookup;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdeditdblookupHPP
