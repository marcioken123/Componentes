// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStringList.pas' rev: 31.00 (Windows)

#ifndef LmdstringlistHPP
#define LmdstringlistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Consts.hpp>
#include <Vcl.Controls.hpp>
#include <LMDClass.hpp>
#include <LMDStrings.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDCustomContainer.hpp>
#include <LMDBaseController.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstringlist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStringListItem;
class DELPHICLASS TLMDStringList;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStringListItem : public Lmdcustomcontainer::TLMDListItem
{
	typedef Lmdcustomcontainer::TLMDListItem inherited;
	
private:
	System::Classes::TStringList* FStrList;
	System::Classes::TStrings* __fastcall GetList(void);
	void __fastcall SetList(System::Classes::TStrings* aValue);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual bool __fastcall GetEmpty(void);
	virtual void __fastcall ReadData(System::Classes::TStream* Stream);
	virtual void __fastcall WriteData(System::Classes::TStream* Stream);
	virtual System::Byte __fastcall WriteFlag(void);
	
public:
	__fastcall virtual TLMDStringListItem(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDStringListItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall FreeData(void);
	__property Compressed = {default=0};
	
__published:
	__property System::Classes::TStrings* Items = {read=GetList, write=SetList, stored=false};
	__property Description = {default=0};
	__property Ident;
};


class PASCALIMPLEMENTATION TLMDStringList : public Lmdcustomcontainer::TLMDCustomContainer
{
	typedef Lmdcustomcontainer::TLMDCustomContainer inherited;
	
public:
	TLMDStringListItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDStringListItem* __fastcall GetArrayItem(int index);
	TLMDStringListItem* __fastcall GetArrayNameItem(System::UnicodeString Index);
	
public:
	__fastcall virtual TLMDStringList(System::Classes::TComponent* AOwner);
	__property TLMDStringListItem* Items[int Index] = {read=GetArrayItem/*, default*/};
	__property TLMDStringListItem* ItemByName[System::UnicodeString Index] = {read=GetArrayNameItem};
	
__published:
	__property DefaultCompressed = {default=0};
public:
	/* TLMDCustomContainer.Destroy */ inline __fastcall virtual ~TLMDStringList(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstringlist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTRINGLIST)
using namespace Lmdstringlist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstringlistHPP
