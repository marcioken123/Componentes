// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBitmapList.pas' rev: 31.00 (Windows)

#ifndef LmdbitmaplistHPP
#define LmdbitmaplistHPP

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
#include <Vcl.ImgList.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDBaseController.hpp>
#include <LMDCustomContainer.hpp>
#include <LMDCustomComponent.hpp>
#include <System.ImageList.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbitmaplist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBitmapListItem;
class DELPHICLASS TLMDBitmapList;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDBitmapListItem : public Lmdcustomcontainer::TLMDListItem
{
	typedef Lmdcustomcontainer::TLMDListItem inherited;
	
private:
	Vcl::Graphics::TBitmap* FBitmap;
	Lmdgraph::TLMDSavePixelFormat FPixelFormat;
	Vcl::Graphics::TBitmap* __fastcall GetBitmap(void);
	void __fastcall SetBitmap(Vcl::Graphics::TBitmap* aValue);
	
protected:
	virtual bool __fastcall GetEmpty(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall ReadData(System::Classes::TStream* Stream);
	virtual void __fastcall WriteData(System::Classes::TStream* Stream);
	virtual System::Byte __fastcall WriteFlag(void);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	
public:
	__fastcall virtual TLMDBitmapListItem(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDBitmapListItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall FreeData(void);
	
__published:
	__property Vcl::Graphics::TBitmap* Bitmap = {read=GetBitmap, write=SetBitmap, stored=false};
	__property Compressed = {default=0};
	__property Ident = {stored=false};
	__property Description = {stored=false, default=0};
	__property Lmdgraph::TLMDSavePixelFormat PixelFormat = {read=FPixelFormat, write=FPixelFormat, default=0};
};


class PASCALIMPLEMENTATION TLMDBitmapList : public Lmdcustomimagelist::TLMDCustomImageList
{
	typedef Lmdcustomimagelist::TLMDCustomImageList inherited;
	
public:
	TLMDBitmapListItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDBitmapListItem* __fastcall GetArrayItem(int Index);
	TLMDBitmapListItem* __fastcall GetArrayNameItem(System::UnicodeString Index);
	HIDESBASE Vcl::Graphics::TBitmap* __fastcall GetBitmap(void);
	
public:
	__fastcall virtual TLMDBitmapList(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDBitmapList(void);
	virtual Vcl::Graphics::TCanvas* __fastcall BmpCanvas(int index);
	virtual System::Types::TRect __fastcall ItemRect(int index, int item);
	virtual int __fastcall Dimensions(int index, System::Byte tp);
	virtual bool __fastcall IsValidItem(int index, int item);
	virtual void __fastcall GetBitmapItem(int index, int item, Vcl::Graphics::TBitmap* tb);
	virtual int __fastcall ItemCount(int index);
	virtual bool __fastcall Masked(int index);
	virtual HPALETTE __fastcall Palette(int index);
	virtual System::Uitypes::TColor __fastcall TransparentColor(int index, int item);
	virtual System::Uitypes::TColor __fastcall GetColorAtPoint(const System::Types::TPoint &aPoint, int index, int item);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, int X, int Y, int ListIndex, int Index);
	virtual System::Types::TRect __fastcall DrawExt(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &target, System::Word flags, int ListIndex, int Index);
	virtual void __fastcall ClipDraw(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &target, System::Word flags, int pos, System::Uitypes::TColor transColor, int ListIndex, int index);
	__property Vcl::Graphics::TBitmap* Item = {read=GetBitmap};
	__property TLMDBitmapListItem* Items[int Index] = {read=GetArrayItem/*, default*/};
	__property TLMDBitmapListItem* ItemByName[System::UnicodeString Index] = {read=GetArrayNameItem};
	
__published:
	__property DefaultCompressed = {default=0};
	__property DefaultPixelFormat = {default=0};
public:
	/* TCustomImageList.CreateSize */ inline __fastcall TLMDBitmapList(int AWidth, int AHeight) : Lmdcustomimagelist::TLMDCustomImageList(AWidth, AHeight) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall LMDBMLGetItem(const System::UnicodeString FileName, int index, Vcl::Graphics::TBitmap* aBitmap);
}	/* namespace Lmdbitmaplist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBITMAPLIST)
using namespace Lmdbitmaplist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbitmaplistHPP
