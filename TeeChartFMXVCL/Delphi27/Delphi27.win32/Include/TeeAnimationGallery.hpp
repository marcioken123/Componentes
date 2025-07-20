// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeAnimationGallery.pas' rev: 34.00 (Windows)

#ifndef TeeanimationgalleryHPP
#define TeeanimationgalleryHPP

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
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <TeeSelectProperty.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeanimationgallery
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAnimationGallery;
//-- type declarations -------------------------------------------------------
typedef System::TMetaClass* TPropertySelectorClass;

class PASCALIMPLEMENTATION TAnimationGallery : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TButton* BOK;
	Vcl::Stdctrls::TButton* BCancel;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* Label1;
	Vcltee::Tecanvas::TComboFlat* ComboClasses;
	void __fastcall ComboClassesChange(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	Teeselectproperty::TPropertySelector* ISelect;
	void __fastcall CheckSelect();
	Vcltee::Teeanimate::TTeeAnimationClass __fastcall SelectedClass();
	void __fastcall TreeObjectsClick(System::TObject* Sender);
	void __fastcall TreePropsClick(System::TObject* Sender);
	
public:
	Vcltee::Teeanimate::TTeeAnimate* Animate;
	Vcltee::Teeanimate::TTeeAnimation* ParentAnimation;
	void __fastcall CreateSelector(const TPropertySelectorClass AClass);
	Vcltee::Teeanimate::TTeeAnimation* __fastcall GetAnimation(System::Classes::TComponent* const AOwner);
	__property Teeselectproperty::TPropertySelector* Selector = {read=ISelect};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAnimationGallery(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAnimationGallery(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAnimationGallery() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAnimationGallery(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeanimationgallery */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEANIMATIONGALLERY)
using namespace Teeanimationgallery;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeanimationgalleryHPP
