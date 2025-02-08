// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFxImageList.pas' rev: 31.00 (Windows)

#ifndef LmdfximagelistHPP
#define LmdfximagelistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <LMDFxEffect.hpp>
#include <LMDFxAnimation.hpp>
#include <LMDFxBase.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfximagelist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFxChangeLink;
class DELPHICLASS TLMDFxImageItem;
class DELPHICLASS TLMDFxImageCollection;
class DELPHICLASS TLMDFxImageList;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFxChangeLink : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDFxImageList* FSender;
	System::Classes::TNotifyEvent FOnChange;
	
public:
	__fastcall virtual ~TLMDFxChangeLink(void);
	DYNAMIC void __fastcall Change(void);
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TLMDFxImageList* Sender = {read=FSender, write=FSender};
public:
	/* TObject.Create */ inline __fastcall TLMDFxChangeLink(void) : System::TObject() { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxImageItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Vcl::Graphics::TPicture* FPicture;
	int FTag;
	void __fastcall SetPicture(Vcl::Graphics::TPicture* Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	void __fastcall OnChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDFxImageItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDFxImageItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcl::Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
	__property Index;
	__property int Tag = {read=FTag, write=FTag, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxImageCollection : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDFxImageItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDFxImageList* FImageList;
	HIDESBASE TLMDFxImageItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDFxImageItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDFxImageCollection(TLMDFxImageList* ImageList);
	HIDESBASE TLMDFxImageItem* __fastcall Add(void);
	__property TLMDFxImageItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDFxImageCollection(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDFxImageList : public Lmdfxbase::TLMDFxComponent
{
	typedef Lmdfxbase::TLMDFxComponent inherited;
	
private:
	TLMDFxImageCollection* FImages;
	System::Classes::TList* FClients;
	
protected:
	DYNAMIC void __fastcall Change(void);
	
public:
	__fastcall virtual TLMDFxImageList(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFxImageList(void);
	bool __fastcall IsValidItem(int index);
	void __fastcall RegisterChanges(TLMDFxChangeLink* aValue);
	void __fastcall UnRegisterChanges(TLMDFxChangeLink* aValue);
	
__published:
	__property TLMDFxImageCollection* Images = {read=FImages, write=FImages};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfximagelist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFXIMAGELIST)
using namespace Lmdfximagelist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfximagelistHPP
