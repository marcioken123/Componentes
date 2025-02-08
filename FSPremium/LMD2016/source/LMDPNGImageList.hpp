// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPNGImageList.pas' rev: 31.00 (Windows)

#ifndef LmdpngimagelistHPP
#define LmdpngimagelistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Consts.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <intfLMDBase.hpp>
#include <LMDProcs.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDTypes.hpp>
#include <LMDObjectList.hpp>
#include <LMDPNGImage.hpp>
#include <System.ImageList.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdpngimagelist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPNGImageList;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDPNGImageList : public Vcl::Imglist::TCustomImageList
{
	typedef Vcl::Imglist::TCustomImageList inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Lmdobjectlist::TLMDObjectList* FPngList;
	Lmdpngimage::TLMDPNGObject* __fastcall GetPNGs(int Index);
	Lmdpngimage::TLMDPNGObject* __fastcall GetPngsByName(Lmdtypes::TLMDString Index);
	
protected:
	Lmdpngimage::TLMDPNGObject* __fastcall MaskedPNG(Vcl::Graphics::TBitmap* AImage, Vcl::Graphics::TBitmap* AMask);
	Lmdpngimage::TLMDPNGObject* __fastcall MaskedColorPNG(Vcl::Graphics::TBitmap* AImage, System::Uitypes::TColor AMaskColor);
	HIDESBASE void __fastcall ReadLeft(System::Classes::TReader* Reader);
	HIDESBASE void __fastcall ReadTop(System::Classes::TReader* Reader);
	HIDESBASE void __fastcall WriteLeft(System::Classes::TWriter* Writer);
	HIDESBASE void __fastcall WriteTop(System::Classes::TWriter* Writer);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall DoDraw(int Index, Vcl::Graphics::TCanvas* Canvas, int X, int Y, unsigned Style, bool Enabled = true);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual TLMDPNGImageList(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDPNGImageList(void);
	HIDESBASE System::Types::TRect __fastcall Draw(Vcl::Graphics::TCanvas* ACanvas, int X, int Y, System::Word flags, int ListIndex);
	System::Types::TRect __fastcall DrawExt(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, System::Word flags, int Index);
	void __fastcall ReadImg(System::Classes::TStream* Stream);
	void __fastcall WriteImg(System::Classes::TStream* Stream);
	HIDESBASE virtual int __fastcall Add(Vcl::Graphics::TBitmap* Image, Vcl::Graphics::TBitmap* Mask);
	HIDESBASE virtual int __fastcall AddMasked(Vcl::Graphics::TBitmap* AImage, System::Uitypes::TColor AMaskColor);
	virtual int __fastcall AddPng(Lmdpngimage::TLMDPNGObject* Image);
	HIDESBASE virtual int __fastcall AddIcon(Vcl::Graphics::TIcon* Image);
	HIDESBASE virtual void __fastcall Clear(void);
	HIDESBASE virtual void __fastcall Delete(int Index);
	HIDESBASE virtual void __fastcall Insert(int AIndex, Vcl::Graphics::TBitmap* AImage, Vcl::Graphics::TBitmap* AMask);
	HIDESBASE virtual void __fastcall InsertIcon(int AIndex, Vcl::Graphics::TIcon* AImage);
	HIDESBASE virtual void __fastcall InsertMasked(int AIndex, Vcl::Graphics::TBitmap* AImage, System::Uitypes::TColor AMaskColor);
	HIDESBASE virtual void __fastcall Move(int CurIndex, int NewIndex);
	HIDESBASE virtual void __fastcall Replace(int AIndex, Vcl::Graphics::TBitmap* AImage, Vcl::Graphics::TBitmap* AMask);
	HIDESBASE virtual void __fastcall ReplaceIcon(int AIndex, Vcl::Graphics::TIcon* AImage);
	HIDESBASE virtual void __fastcall ReplaceMasked(int AIndex, Vcl::Graphics::TBitmap* AImage, System::Uitypes::TColor AMaskColor);
	bool __fastcall GetPNG(int Index, Lmdpngimage::TLMDPNGObject* Image);
	HIDESBASE bool __fastcall GetBitmap(int Index, Vcl::Graphics::TBitmap* Image);
	Lmdtypes::TLMDString __fastcall GetPngFileNameByIndex(const int AIndex);
	HIDESBASE bool __fastcall Equal(TLMDPNGImageList* IL);
	int __fastcall IndexOf(Lmdpngimage::TLMDPNGObject* AObject);
	__property Lmdpngimage::TLMDPNGObject* PNG[int Index] = {read=GetPNGs};
	__property Lmdpngimage::TLMDPNGObject* PNGByName[Lmdtypes::TLMDString Index] = {read=GetPngsByName};
	HIDESBASE int __fastcall AddImage(Vcl::Imglist::TCustomImageList* Value, int Index);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Height = {default=16};
	__property Width = {default=16};
	__property OnChange;
public:
	/* TCustomImageList.CreateSize */ inline __fastcall TLMDPNGImageList(int AWidth, int AHeight) : Vcl::Imglist::TCustomImageList(AWidth, AHeight) { }
	
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
}	/* namespace Lmdpngimagelist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPNGIMAGELIST)
using namespace Lmdpngimagelist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdpngimagelistHPP
