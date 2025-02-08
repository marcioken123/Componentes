// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBSimpleLabel.pas' rev: 31.00 (Windows)

#ifndef LmddbsimplelabelHPP
#define LmddbsimplelabelHPP

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
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDDBBase.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDBaseControl.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbsimplelabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBSimpleLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBSimpleLabel : public Lmdcustomsimplelabel::TLMDCustomSimpleLabel
{
	typedef Lmdcustomsimplelabel::TLMDCustomSimpleLabel inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::Classes::TNotifyEvent FOnDataChange;
	void __fastcall SetDataField(const System::UnicodeString aValue);
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	System::UnicodeString __fastcall GetFieldText(void);
	void __fastcall DataChange(System::TObject* Sender);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	Data::Db::TDataLink* __fastcall GetDataLink(void);
	virtual System::UnicodeString __fastcall GetLabelText(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBSimpleLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBSimpleLabel(void);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Data::Db::TField* Field = {read=GetField};
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* Action);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* Action);
	
__published:
	__property About = {default=0};
	__property Action;
	__property Align = {default=0};
	__property ActiveColor = {index=0, default=8388736};
	__property InActiveColor = {index=1, default=16711680};
	__property JumpUnderline = {default=1};
	__property JumpMode = {default=2};
	__property ShowURLInHint = {default=0};
	__property ShowURLMenu = {default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property System::Classes::TNotifyEvent OnDataChange = {read=FOnDataChange, write=FOnDataChange};
private:
	void *__IDataControl;	// Lmddbbase::IDataControl 
	
public:
	operator Lmddbbase::IDataControl*(void) { return (Lmddbbase::IDataControl*)&__IDataControl; }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbsimplelabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBSIMPLELABEL)
using namespace Lmddbsimplelabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbsimplelabelHPP
