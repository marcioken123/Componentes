// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomImageList.pas' rev: 31.00 (Windows)

#ifndef LmdcustomimagelistHPP
#define LmdcustomimagelistHPP

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
#include <LMDProcs.hpp>
#include <LMDCustomContainer.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <System.ImageList.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomimagelist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomImageList;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomImageList : public Vcl::Imglist::TCustomImageList
{
	typedef Vcl::Imglist::TCustomImageList inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	System::Word FUpdateCount;
	Lmdcustomcontainer::TLMDListItem* __fastcall GetItemByName(System::UnicodeString index);
	void __fastcall SetIndex(int aValue);
	void __fastcall SetSource(Lmdcustomcontainer::TLMDContainerSource aValue);
	void __fastcall SetPrefix(Lmdprocs::TLMDPathPrefix aValue);
	HIDESBASE void __fastcall ReadLeft(System::Classes::TReader* Reader);
	HIDESBASE void __fastcall ReadTop(System::Classes::TReader* Reader);
	HIDESBASE void __fastcall WriteLeft(System::Classes::TWriter* Writer);
	HIDESBASE void __fastcall WriteTop(System::Classes::TWriter* Writer);
	
protected:
	bool FDefault;
	Lmdprocs::TLMDPathPrefix FPrefix;
	Lmdcustomcontainer::TLMDContainerSource FSource;
	System::Sysutils::TFileName FFileName;
	System::Classes::TList* FList;
	Lmdcustomcontainer::TLMDListItemClass FListClass;
	Lmdcustomcontainer::TLMDListItemClassType FListType;
	int FIndex;
	Lmdgraph::TLMDSavePixelFormat FDefaultPixel;
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	DYNAMIC System::Classes::TComponent* __fastcall GetChildOwner(void);
	virtual int __fastcall GetCount(void);
	virtual bool __fastcall GetEmpty(void);
	virtual Lmdcustomcontainer::TLMDListItem* __fastcall GetItem(int index);
	virtual void __fastcall ReadData(System::Classes::TStream* Stream);
	virtual void __fastcall WriteData(System::Classes::TStream* Stream);
	virtual void __fastcall ReadStream(System::Classes::TStream* Stream, bool flag);
	virtual void __fastcall WriteStream(System::Classes::TStream* Stream, bool flag);
	void __fastcall Update(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDCustomImageList(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomImageList(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Change(void);
	virtual Vcl::Graphics::TCanvas* __fastcall BmpCanvas(int index) = 0 ;
	virtual System::Types::TRect __fastcall ItemRect(int index, int item) = 0 ;
	virtual int __fastcall Dimensions(int index, System::Byte tp) = 0 ;
	virtual int __fastcall ItemCount(int index) = 0 ;
	virtual bool __fastcall IsValidItem(int index, int item) = 0 ;
	virtual void __fastcall GetBitmapItem(int index, int item, Vcl::Graphics::TBitmap* tb) = 0 ;
	HIDESBASE virtual bool __fastcall Masked(int index) = 0 ;
	virtual HPALETTE __fastcall Palette(int index) = 0 ;
	virtual System::Uitypes::TColor __fastcall TransparentColor(int index, int item) = 0 ;
	virtual System::Uitypes::TColor __fastcall GetColorAtPoint(const System::Types::TPoint &aPoint, int index, int item) = 0 ;
	HIDESBASE virtual void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, int X, int Y, int ListIndex, int Index) = 0 ;
	virtual System::Types::TRect __fastcall DrawExt(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &target, System::Word flags, int ListIndex, int Index) = 0 ;
	virtual void __fastcall ClipDraw(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &target, System::Word flags, int pos, System::Uitypes::TColor transColor, int ListIndex, int index) = 0 ;
	HIDESBASE virtual int __fastcall Add(Lmdcustomcontainer::TLMDListItem* aValue = (Lmdcustomcontainer::TLMDListItem*)(0x0));
	void __fastcall AddList(TLMDCustomImageList* aValue);
	HIDESBASE void __fastcall Clear(void);
	HIDESBASE void __fastcall Delete(int Index);
	int __fastcall IndexOf(Lmdcustomcontainer::TLMDListItem* aValue);
	HIDESBASE void __fastcall Insert(int Index, Lmdcustomcontainer::TLMDListItem* aValue = (Lmdcustomcontainer::TLMDListItem*)(0x0));
	HIDESBASE void __fastcall Move(int OldIndex, int NewIndex);
	void __fastcall LoadFromFile(const System::UnicodeString Filename);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall SaveToFile(const System::UnicodeString Filename);
	HIDESBASE void __fastcall BeginUpdate(void);
	bool __fastcall IsUpdating(void);
	HIDESBASE void __fastcall EndUpdate(bool aValue = true);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	__property int Index = {read=FIndex, write=SetIndex, default=0};
	__property Lmdgraph::TLMDSavePixelFormat DefaultPixelFormat = {read=FDefaultPixel, write=FDefaultPixel, default=0};
	__property bool Empty = {read=GetEmpty, nodefault};
	__property Lmdcustomcontainer::TLMDListItem* Contents[int Index] = {read=GetItem};
	__property Lmdcustomcontainer::TLMDListItem* ContentsByName[System::UnicodeString Index] = {read=GetItemByName};
	__property bool DefaultCompressed = {read=FDefault, write=FDefault, default=0};
	__property Lmdcustomcontainer::TLMDContainerSource Source = {read=FSource, write=SetSource, default=0};
	__property System::Sysutils::TFileName FileName = {read=FFileName, write=FFileName};
	__property Lmdprocs::TLMDPathPrefix FilePrefix = {read=FPrefix, write=SetPrefix, default=2};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property OnChange;
public:
	/* TCustomImageList.CreateSize */ inline __fastcall TLMDCustomImageList(int AWidth, int AHeight) : Vcl::Imglist::TCustomImageList(AWidth, AHeight) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::StaticArray<int, 5> LMDPixelFormatColors;
static const System::Int8 ITF_BMPMONO = System::Int8(0x10);
static const System::Int8 ITF_BMP16 = System::Int8(0x20);
static const System::Int8 ITF_BMP256 = System::Int8(0x40);
static const System::Byte ITF_BMP65K = System::Byte(0x80);
extern DELPHI_PACKAGE bool __fastcall LMDBmpLoad(NativeUInt hlib, int index, Vcl::Graphics::TBitmap* aBitmap);
extern DELPHI_PACKAGE bool __fastcall LMDBmpLoadFromFile(const System::UnicodeString FileName, int index, Vcl::Graphics::TBitmap* aBitmap);
}	/* namespace Lmdcustomimagelist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMIMAGELIST)
using namespace Lmdcustomimagelist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomimagelistHPP
