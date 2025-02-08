// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBFilter.pas' rev: 31.00 (Windows)

#ifndef LmddbfilterHPP
#define LmddbfilterHPP

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
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbfilter
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFilterDataLink;
class DELPHICLASS TLMDDBFilter;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFilterDataLink : public Data::Db::TDataLink
{
	typedef Data::Db::TDataLink inherited;
	
private:
	TLMDDBFilter* FFilter;
	
protected:
	virtual void __fastcall ActiveChanged(void);
	
public:
	__fastcall TLMDFilterDataLink(TLMDDBFilter* aValue);
	__fastcall virtual ~TLMDFilterDataLink(void);
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDDBFilter : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	bool FFiltered;
	TLMDFilterDataLink* FDataLink;
	Data::Db::TFilterRecordEvent FOnFilter;
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetFiltered(bool aValue);
	void __fastcall SetOnFiltered(Data::Db::TFilterRecordEvent aValue);
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBFilter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBFilter(void);
	void __fastcall ActivateFilter(void);
	void __fastcall DeActivateFilter(void);
	
__published:
	__property About = {default=0};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool Filtered = {read=FFiltered, write=SetFiltered, default=0};
	__property Data::Db::TFilterRecordEvent OnFilterRecord = {read=FOnFilter, write=SetOnFiltered};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbfilter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBFILTER)
using namespace Lmddbfilter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbfilterHPP
