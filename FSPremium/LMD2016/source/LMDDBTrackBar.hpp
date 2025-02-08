// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBTrackBar.pas' rev: 31.00 (Windows)

#ifndef LmddbtrackbarHPP
#define LmddbtrackbarHPP

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
#include <LMDCustomTrackBar.hpp>
#include <LMDDBBase.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbtrackbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBTrackBar;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBTrackBar : public Lmdcustomtrackbar::TLMDCustomTrackBar
{
	typedef Lmdcustomtrackbar::TLMDCustomTrackBar inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	HIDESBASE bool __fastcall GetReadOnly(void);
	void __fastcall SetReadOnly(bool aValue);
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	void __fastcall SetDataField(const System::UnicodeString aValue);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	Data::Db::TDataLink* __fastcall GetDataLink(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall DoEnter(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual int __fastcall GetPosition(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int x, int y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int x, int y);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDDBTrackBar(System::Classes::TComponent* AOwner);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* AAction);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* AAction);
	__fastcall virtual ~TLMDDBTrackBar(void);
	
__published:
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBTrackBar(HWND ParentWindow) : Lmdcustomtrackbar::TLMDCustomTrackBar(ParentWindow) { }
	
private:
	void *__IDataControl;	// Lmddbbase::IDataControl 
	
public:
	operator Lmddbbase::IDataControl*(void) { return (Lmddbbase::IDataControl*)&__IDataControl; }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbtrackbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBTRACKBAR)
using namespace Lmddbtrackbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbtrackbarHPP
