// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDImageListConnector.pas' rev: 31.00 (Windows)

#ifndef LmdimagelistconnectorHPP
#define LmdimagelistconnectorHPP

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
#include <Vcl.ImgList.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDCustomContainer.hpp>
#include <System.ImageList.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdimagelistconnector
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBorImageListItem;
class DELPHICLASS TLMDBorImageListItems;
class DELPHICLASS TLMDImageListConnector;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBorImageListItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Vcl::Imglist::TCustomImageList* FImageList;
	Vcl::Imglist::TChangeLink* FChangeLink;
	System::UnicodeString FName;
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	void __fastcall SetName(System::UnicodeString aValue);
	TLMDImageListConnector* __fastcall GetConnector(void);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TLMDBorImageListItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDBorImageListItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall ImageListChange(System::TObject* Sender);
	__property TLMDImageListConnector* Connector = {read=GetConnector};
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList};
	__property Index;
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBorImageListItems : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDBorImageListItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDImageListConnector* FConnector;
	HIDESBASE TLMDBorImageListItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDBorImageListItem* aValue);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDBorImageListItems(TLMDImageListConnector* Connector);
	__fastcall virtual ~TLMDBorImageListItems(void);
	HIDESBASE TLMDBorImageListItem* __fastcall Add(void);
	__property TLMDBorImageListItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDImageListConnector : public Lmdcustomimagelist::TLMDCustomImageList
{
	typedef Lmdcustomimagelist::TLMDCustomImageList inherited;
	
private:
	TLMDBorImageListItems* FImageLists;
	Lmdcustomcontainer::TLMDListItem* FDummyItem;
	void __fastcall SetImageLists(TLMDBorImageListItems* aValue);
	
protected:
	virtual int __fastcall GetCount(void);
	virtual bool __fastcall GetEmpty(void);
	virtual Lmdcustomcontainer::TLMDListItem* __fastcall GetItem(int Index);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDImageListConnector(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDImageListConnector(void);
	virtual Vcl::Graphics::TCanvas* __fastcall BmpCanvas(int index);
	virtual System::Types::TRect __fastcall ItemRect(int index, int item);
	virtual int __fastcall Dimensions(int index, System::Byte tp);
	virtual void __fastcall GetBitmapItem(int index, int item, Vcl::Graphics::TBitmap* tb);
	virtual bool __fastcall IsValidItem(int index, int item);
	virtual int __fastcall ItemCount(int index);
	virtual bool __fastcall Masked(int index);
	virtual HPALETTE __fastcall Palette(int index);
	virtual System::Uitypes::TColor __fastcall TransparentColor(int index, int item);
	virtual System::Uitypes::TColor __fastcall GetColorAtPoint(const System::Types::TPoint &aPoint, int index, int item);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, int X, int Y, int ListIndex, int Index);
	virtual System::Types::TRect __fastcall DrawExt(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &target, System::Word flags, int ListIndex, int Index);
	virtual void __fastcall ClipDraw(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &target, System::Word flags, int pos, System::Uitypes::TColor transColor, int ListIndex, int index);
	__property Lmdcustomcontainer::TLMDListItem* Contents[int Index] = {read=GetItem};
	
__published:
	__property TLMDBorImageListItems* ImageLists = {read=FImageLists, write=SetImageLists};
public:
	/* TCustomImageList.CreateSize */ inline __fastcall TLMDImageListConnector(int AWidth, int AHeight) : Lmdcustomimagelist::TLMDCustomImageList(AWidth, AHeight) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdimagelistconnector */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIMAGELISTCONNECTOR)
using namespace Lmdimagelistconnector;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdimagelistconnectorHPP
