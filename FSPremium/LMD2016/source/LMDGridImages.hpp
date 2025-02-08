// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDGridImages.pas' rev: 31.00 (Windows)

#ifndef LmdgridimagesHPP
#define LmdgridimagesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdgridimages
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDGridImagesForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDGridImagesForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Controls::TImageList* Images;
	Vcl::Controls::TImageList* IndicatorImages;
	Vcl::Controls::TImageList* ArrowImages;
	Vcl::Controls::TImageList* ChooserImages;
	Vcl::Controls::TImageList* OtherImages;
	Vcl::Menus::TPopupMenu* SelectColumnsMenu;
	Vcl::Menus::TMenuItem* N11;
	Vcl::Menus::TMenuItem* N21;
	Vcl::Menus::TMenuItem* N31;
	Vcl::Menus::TMenuItem* N41;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDGridImagesForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDGridImagesForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDGridImagesForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDGridImagesForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDGridImagesForm* LMDGridImagesForm;
}	/* namespace Lmdgridimages */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDGRIDIMAGES)
using namespace Lmdgridimages;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdgridimagesHPP
