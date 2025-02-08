// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDImageList.pas' rev: 31.00 (Windows)

#ifndef LmdimagelistHPP
#define LmdimagelistHPP

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
#include <LMDGraph.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDCustomContainer.hpp>
#include <LMDCustomComponent.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <Vcl.ImgList.hpp>
#include <System.ImageList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdimagelist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDImageListItem;
class DELPHICLASS TLMDImageList;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDDrawingStyle : unsigned char { dsFocus, dsSelected, dsNormal, dsTransparent };

enum DECLSPEC_DENUM TLMDImageType : unsigned char { itImage, itMask };

class PASCALIMPLEMENTATION TLMDImageListItem : public Lmdcustomcontainer::TLMDListItem
{
	typedef Lmdcustomcontainer::TLMDListItem inherited;
	
private:
	int FAllocBy;
	int FHeight;
	int FUsed;
	int FWidth;
	Lmdgraph::TLMDSavePixelFormat FPixelFormat;
	System::Uitypes::TColor FBKColor;
	System::Uitypes::TColor FBlendColor;
	TLMDDrawingStyle FDrawingStyle;
	Vcl::Graphics::TBitmap* FImage;
	Vcl::Graphics::TBitmap* FMask;
	System::Classes::TList* FInfo;
	TLMDImageType FImageType;
	bool FMasked;
	bool FShareImages;
	int __fastcall GetCount(void);
	void __fastcall SetInteger(int Index, int aValue);
	void __fastcall SetMaskedState(bool aValue);
	void __fastcall BuildInfoList(int aValue);
	void __fastcall CreatePattern(Vcl::Graphics::TBitmap* aValue, System::Byte aInt);
	void __fastcall ReadStream(System::Classes::TStream* Stream);
	void __fastcall WriteStream(System::Classes::TStream* Stream);
	void __fastcall ClearImageInfoList(void);
	
protected:
	bool __fastcall CheckImage(Vcl::Graphics::TBitmap* aValue);
	void __fastcall ConvertBmpToIML(Vcl::Graphics::TBitmap* aValue, int Count, bool Masked);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual bool __fastcall GetEmpty(void);
	int __fastcall PrepareSpace(void);
	virtual void __fastcall ReadData(System::Classes::TStream* Stream);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual void __fastcall WriteData(System::Classes::TStream* Stream);
	virtual System::Byte __fastcall WriteFlag(void);
	void __fastcall InitAttributes(int aWidth = 0x10, int aHeight = 0x10);
	__property bool ShareImages = {read=FShareImages, write=FShareImages, default=0};
	
public:
	__fastcall virtual TLMDImageListItem(System::Classes::TComponent* aOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall TLMDImageListItem(int AWidth, int AHeight);
	__fastcall virtual ~TLMDImageListItem(void);
	virtual void __fastcall FreeData(void);
	bool __fastcall LoadFromBitmap(const System::UnicodeString FileName, int Count, bool Masked);
	void __fastcall GetBitmap(int Index, Vcl::Graphics::TBitmap* Image);
	void __fastcall GetMaskBitmap(int Index, Vcl::Graphics::TBitmap* MaskBmp);
	Vcl::Graphics::TBitmap* __fastcall GetImageBitmap(void);
	Vcl::Graphics::TBitmap* __fastcall GetImageMaskBitmap(void);
	System::Types::TRect __fastcall GetImageRect(int Index);
	int __fastcall Add(Vcl::Graphics::TBitmap* Image, Vcl::Graphics::TBitmap* Mask);
	int __fastcall AddMasked(Vcl::Graphics::TBitmap* Image, System::Uitypes::TColor MaskColor);
	void __fastcall AddImages(TLMDImageListItem* aValue);
	void __fastcall Clear(void);
	void __fastcall Delete(int Index);
	HIDESBASE void __fastcall Insert(int Index, Vcl::Graphics::TBitmap* Image, Vcl::Graphics::TBitmap* Mask);
	void __fastcall InsertImages(int Index, TLMDImageListItem* aValue);
	void __fastcall InsertMasked(int Index, Vcl::Graphics::TBitmap* Image, System::Uitypes::TColor MaskColor);
	void __fastcall Move(int OldIndex, int NewIndex);
	void __fastcall Replace(int Index, Vcl::Graphics::TBitmap* Image, Vcl::Graphics::TBitmap* Mask);
	void __fastcall ReplaceMasked(int Index, Vcl::Graphics::TBitmap* Image, System::Uitypes::TColor MaskColor);
	void __fastcall LoadFromFile(const System::UnicodeString Filename);
	void __fastcall SaveToFile(const System::UnicodeString Filename);
	void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, int X, int Y, int Index);
	System::Types::TRect __fastcall DrawExt(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &target, System::Word flags, int Index);
	void __fastcall ClipDraw(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &target, System::Word flags, int pos, System::Uitypes::TColor transColor, int index);
	System::Uitypes::TColor __fastcall TransparentColor(int Index);
	System::Uitypes::TColor __fastcall GetColorAtPoint(const System::Types::TPoint &aPoint, int Index);
	__property int Count = {read=GetCount, nodefault};
	__property System::Classes::TList* Info = {read=FInfo};
	__property System::Uitypes::TColor BKColor = {read=FBKColor, write=FBKColor, default=536870911};
	__property System::Uitypes::TColor BlendColor = {read=FBlendColor, write=FBlendColor, default=536870911};
	__property TLMDDrawingStyle DrawingStyle = {read=FDrawingStyle, write=FDrawingStyle, default=2};
	__property TLMDImageType ImageType = {read=FImageType, write=FImageType, default=0};
	__property Lmdgraph::TLMDSavePixelFormat PixelFormat = {read=FPixelFormat, write=FPixelFormat, default=0};
	__property Compressed = {default=0};
	
__published:
	__property int AllocBy = {read=FAllocBy, write=FAllocBy, default=4};
	__property Description = {default=0};
	__property bool Masked = {read=FMasked, write=SetMaskedState, default=0};
	__property int Height = {read=FHeight, write=SetInteger, index=1, default=16};
	__property int Width = {read=FWidth, write=SetInteger, index=0, default=16};
};


class PASCALIMPLEMENTATION TLMDImageList : public Lmdcustomimagelist::TLMDCustomImageList
{
	typedef Lmdcustomimagelist::TLMDCustomImageList inherited;
	
public:
	TLMDImageListItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDImageListItem* __fastcall GetList(void);
	TLMDImageListItem* __fastcall GetArrayItem(int Index);
	TLMDImageListItem* __fastcall GetArrayNameItem(System::UnicodeString Index);
	
protected:
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	DYNAMIC System::Classes::TComponent* __fastcall GetChildOwner(void);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual TLMDImageList(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDImageList(void);
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
	__property TLMDImageListItem* Item = {read=GetList};
	__property TLMDImageListItem* Items[int Index] = {read=GetArrayItem/*, default*/};
	__property TLMDImageListItem* ItemByName[System::UnicodeString Index] = {read=GetArrayNameItem};
	
__published:
	__property DefaultCompressed = {default=0};
	__property DefaultPixelFormat = {default=0};
public:
	/* TCustomImageList.CreateSize */ inline __fastcall TLMDImageList(int AWidth, int AHeight) : Lmdcustomimagelist::TLMDCustomImageList(AWidth, AHeight) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall LMDIMLGetItem(const System::UnicodeString FileName, int index, TLMDImageListItem* aItem);
}	/* namespace Lmdimagelist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIMAGELIST)
using namespace Lmdimagelist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdimagelistHPP
