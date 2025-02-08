// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElImgLst.pas' rev: 31.00 (Windows)

#ifndef ElimglstHPP
#define ElimglstHPP

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
#include <System.Types.hpp>
#include <Vcl.Consts.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Graphics.hpp>
#include <ElVCLUtils.hpp>
#include <LMDTypes.hpp>
#include <intfLMDBase.hpp>
#include <System.ImageList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elimglst
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElImageList;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElImageList : public Vcl::Controls::TImageList
{
	typedef Vcl::Controls::TImageList inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	
protected:
	void __fastcall GetFullImages(Vcl::Graphics::TBitmap* Image, Vcl::Graphics::TBitmap* Mask);
	HIDESBASE void __fastcall ReadLeft(System::Classes::TReader* Reader);
	HIDESBASE void __fastcall ReadTop(System::Classes::TReader* Reader);
	HIDESBASE void __fastcall WriteLeft(System::Classes::TWriter* Writer);
	HIDESBASE void __fastcall WriteTop(System::Classes::TWriter* Writer);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TElImageList(System::Classes::TComponent* AOwner);
	void __fastcall ReadImg(System::Classes::TStream* Stream);
	void __fastcall WriteImg(System::Classes::TStream* Stream);
	HIDESBASE bool __fastcall Equal(TElImageList* IL);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
public:
	/* TCustomImageList.CreateSize */ inline __fastcall TElImageList(int AWidth, int AHeight) : Vcl::Controls::TImageList(AWidth, AHeight) { }
	/* TCustomImageList.Destroy */ inline __fastcall virtual ~TElImageList(void) { }
	
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
extern DELPHI_PACKAGE int __fastcall DecodeRLE(const void * Source, const void * Target, unsigned Count, unsigned ColorDepth);
extern DELPHI_PACKAGE int __fastcall EncodeRLE(const System::PByte Source, const System::PByte Target, int Count, int BPP);
}	/* namespace Elimglst */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELIMGLST)
using namespace Elimglst;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElimglstHPP
