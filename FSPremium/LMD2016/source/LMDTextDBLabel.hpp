// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextDBLabel.pas' rev: 31.00 (Windows)

#ifndef LmdtextdblabelHPP
#define LmdtextdblabelHPP

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
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <LMDTextCustomLabel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextdblabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextDBLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextDBLabel : public Lmdtextcustomlabel::TLMDTextCustomLabel
{
	typedef Lmdtextcustomlabel::TLMDTextCustomLabel inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	void __fastcall SetDataField(const System::UnicodeString aValue);
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	System::UnicodeString __fastcall GetFieldText(void);
	void __fastcall DataChange(System::TObject* Sender);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	virtual System::UnicodeString __fastcall GetLabelText(void);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDTextDBLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDTextDBLabel(void);
	__property Data::Db::TField* Field = {read=GetField};
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	
__published:
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextdblabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTDBLABEL)
using namespace Lmdtextdblabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextdblabelHPP
