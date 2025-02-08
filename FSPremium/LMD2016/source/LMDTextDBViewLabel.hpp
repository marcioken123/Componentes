// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextDBViewLabel.pas' rev: 31.00 (Windows)

#ifndef LmdtextdbviewlabelHPP
#define LmdtextdbviewlabelHPP

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
#include <Vcl.Graphics.hpp>
#include <LMDTextCustomLabel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDTextObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextdbviewlabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextDBViewLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextDBViewLabel : public Lmdtextcustomlabel::TLMDTextCustomLabel
{
	typedef Lmdtextcustomlabel::TLMDTextCustomLabel inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	void __fastcall DataChange(System::TObject* Sender);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	virtual System::UnicodeString __fastcall GetLabelText(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	virtual void __fastcall DoGraphicError(System::TObject* Sender, Vcl::Graphics::TPicture* aPicture, const System::UnicodeString aFileName, int aImageIndex);
	virtual System::UnicodeString __fastcall DoGetVariable(System::TObject* Sender, const System::UnicodeString aVarName);
	
public:
	__fastcall virtual TLMDTextDBViewLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDTextDBViewLabel(void);
	virtual void __fastcall Paint(void);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Data::Db::TField* Field = {read=GetField};
	
__published:
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Lines;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextdbviewlabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTDBVIEWLABEL)
using namespace Lmdtextdbviewlabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextdbviewlabelHPP
