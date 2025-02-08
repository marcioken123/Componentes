// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDRTFActDescr.pas' rev: 31.00 (Windows)

#ifndef PlmdrtfactdescrHPP
#define PlmdrtfactdescrHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDRTFActions.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdrtfactdescr
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRTFActionDescriptor;
class DELPHICLASS TLMDRTFActionDescriptors;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFActionDescriptor : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Lmdrtfactions::TLMDRichEditActionClass fCls;
	System::UnicodeString fCaption;
	int fImageIndex;
	System::UnicodeString fCategory;
	System::UnicodeString fHint;
	
public:
	Lmdrtfactions::TLMDRichEditAction* __fastcall CreateAction(System::Classes::TComponent* aOwner);
	__property Lmdrtfactions::TLMDRichEditActionClass Cls = {read=fCls, write=fCls};
	__property System::UnicodeString Caption = {read=fCaption, write=fCaption};
	__property System::UnicodeString Hint = {read=fHint, write=fHint};
	__property int ImageIndex = {read=fImageIndex, write=fImageIndex, nodefault};
	__property System::UnicodeString Category = {read=fCategory, write=fCategory};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDRTFActionDescriptor(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDRTFActionDescriptor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFActionDescriptors : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDRTFActionDescriptor* operator[](int Ind) { return this->Items[Ind]; }
	
private:
	TLMDRTFActionDescriptor* __fastcall GetItems(int Ind);
	
public:
	__fastcall TLMDRTFActionDescriptors(void);
	void __fastcall RegisterAction(Lmdrtfactions::TLMDRichEditActionClass Cls, const System::UnicodeString Caption, const System::UnicodeString Category = System::UnicodeString(), int ImageIndex = 0xffffffff);
	Lmdrtfactions::TLMDRichEditAction* __fastcall CreateAction(Lmdrtfactions::TLMDRichEditActionClass Cls, System::Classes::TComponent* aOwner);
	__property TLMDRTFActionDescriptor* Items[int Ind] = {read=GetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDRTFActionDescriptors(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDRTFActionDescriptors* __fastcall CreateStdLMDRTFActionDescriptors(void);
extern DELPHI_PACKAGE TLMDRTFActionDescriptors* __fastcall StdLMDRTFActionDescriptors(void);
extern DELPHI_PACKAGE Vcl::Controls::TImageList* __fastcall CreateLMDRTFActionImageList(System::Classes::TComponent* aOwner);
}	/* namespace Plmdrtfactdescr */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDRTFACTDESCR)
using namespace Plmdrtfactdescr;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdrtfactdescrHPP
