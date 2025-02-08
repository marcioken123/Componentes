// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBLEDLabel.pas' rev: 31.00 (Windows)

#ifndef LmddbledlabelHPP
#define LmddbledlabelHPP

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
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <LMDLEDCustomLabel.hpp>
#include <LMDDBBase.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbledlabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBLEDLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBLEDLabel : public Lmdledcustomlabel::TLMDLEDCustomLabel
{
	typedef Lmdledcustomlabel::TLMDLEDCustomLabel inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::UnicodeString __fastcall GetDataField(void);
	System::UnicodeString __fastcall GetFieldText(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetDataField(const System::UnicodeString aValue);
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	void __fastcall DataChange(System::TObject* Sender);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	Data::Db::TDataLink* __fastcall GetDataLink(void);
	virtual System::UnicodeString __fastcall GetLabelText(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBLEDLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBLEDLabel(void);
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	
__published:
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
private:
	void *__IDataControl;	// Lmddbbase::IDataControl 
	
public:
	operator Lmddbbase::IDataControl*(void) { return (Lmddbbase::IDataControl*)&__IDataControl; }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbledlabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBLEDLABEL)
using namespace Lmddbledlabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbledlabelHPP
