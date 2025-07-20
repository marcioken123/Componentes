// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TreeAnimationGallery.pas' rev: 34.00 (Windows)

#ifndef TreeanimationgalleryHPP
#define TreeanimationgalleryHPP

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
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <TreeAnimate.hpp>
#include <TeeTree.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeGDIPlus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Treeanimationgallery
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTreeAnimationGallery;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTreeAnimationGallery : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TListBox* ListBox1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Teetree::TTree* Tree1;
	Treeanimate::TTreeAnimate* TreeAnimate1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ListBox1Click(System::TObject* Sender);
	void __fastcall ListBox1DblClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	void __fastcall PreviewAnimation();
	
public:
	__classmethod Vcltee::Teeanimate::TTeeAnimationClass __fastcall Select();
	Vcltee::Teeanimate::TTeeAnimationClass __fastcall SelectedClass();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTreeAnimationGallery(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTreeAnimationGallery(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTreeAnimationGallery() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTreeAnimationGallery(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Treeanimationgallery */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TREEANIMATIONGALLERY)
using namespace Treeanimationgallery;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TreeanimationgalleryHPP
