// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDGenericList.pas' rev: 31.00 (Windows)

#ifndef LmdgenericlistHPP
#define LmdgenericlistHPP

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
#include <Vcl.Consts.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomContainer.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdgenericlist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDGenericListItem;
class DELPHICLASS TLMDGenericList;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDGenericListItem : public Lmdcustomcontainer::TLMDListItem
{
	typedef Lmdcustomcontainer::TLMDListItem inherited;
	
private:
	System::Classes::TMemoryStream* FMemoryStream;
	System::UnicodeString FFilename;
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual bool __fastcall GetEmpty(void);
	virtual void __fastcall ReadData(System::Classes::TStream* Stream);
	virtual void __fastcall WriteData(System::Classes::TStream* Stream);
	virtual System::Byte __fastcall WriteFlag(void);
	
public:
	__fastcall virtual TLMDGenericListItem(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDGenericListItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall FreeData(void);
	void __fastcall LoadFromFile(System::UnicodeString FileName);
	void __fastcall SaveToFile(System::UnicodeString FileName);
	HIDESBASE void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	HIDESBASE void __fastcall SaveToStream(System::Classes::TStream* Stream);
	System::UnicodeString __fastcall SaveToTempFile(void);
	__property System::Classes::TMemoryStream* Data = {read=FMemoryStream};
	__property Compressed = {default=0};
	__property Description = {default=0};
	__property Ident;
	__property System::UnicodeString FileName = {read=FFilename};
};


class PASCALIMPLEMENTATION TLMDGenericList : public Lmdcustomcontainer::TLMDCustomContainer
{
	typedef Lmdcustomcontainer::TLMDCustomContainer inherited;
	
public:
	TLMDGenericListItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDGenericListItem* __fastcall GetArrayItem(int index);
	TLMDGenericListItem* __fastcall GetArrayNameItem(System::UnicodeString Index);
	
public:
	__fastcall virtual TLMDGenericList(System::Classes::TComponent* AOwner);
	__property TLMDGenericListItem* Items[int Index] = {read=GetArrayItem/*, default*/};
	__property TLMDGenericListItem* ItemByName[System::UnicodeString Index] = {read=GetArrayNameItem};
	
__published:
	__property DefaultCompressed = {default=0};
public:
	/* TLMDCustomContainer.Destroy */ inline __fastcall virtual ~TLMDGenericList(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdgenericlist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDGENERICLIST)
using namespace Lmdgenericlist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdgenericlistHPP
