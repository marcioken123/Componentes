// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeDesignOptions.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeedesignoptionsHPP
#define Vcltee_TeedesignoptionsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeTranslate.hpp>
#include <VCLTee.TeeTranslateEditor.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeGalleryPanel.hpp>
#include <VCLTee.TeeEditCha.hpp>
#include <VCLTee.TeeFilters.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teedesignoptions
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TOptionsForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TOptionsForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabLanguage;
	Vcl::Comctrls::TTabSheet* TabGallery;
	Vcl::Comctrls::TTabSheet* TabEditor;
	Vcl::Comctrls::TTabSheet* TabNewChart;
	Vcl::Stdctrls::TCheckBox* CBSmooth;
	Vcl::Stdctrls::TCheckBox* CBSize;
	Vcl::Stdctrls::TCheckBox* CBPosition;
	Vcl::Stdctrls::TCheckBox* CBTree;
	Vcl::Stdctrls::TButton* Button4;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Extctrls::TRadioGroup* RGGalleryMode;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TListBox* LBTheme;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Extctrls::TPanel* Panel5;
	Vcltee::Teefilters::TImageFiltered* ImageFiltered1;
	Vcl::Stdctrls::TCheckBox* CBGallerySize;
	Vcl::Stdctrls::TButton* BEditorFont;
	Vcl::Stdctrls::TCheckBox* CBDefaultFont;
	Vcl::Extctrls::TPanel* Panel6;
	Vcltee::Tecanvas::TComboFlat* CBPalette;
	Vcl::Extctrls::TPanel* Panel7;
	Vcl::Stdctrls::TLabel* LabelTheme;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Stdctrls::TLabel* Label3;
	Vcltee::Tecanvas::TComboFlat* CBGalleryRender;
	Vcl::Stdctrls::TLabel* Label4;
	Vcltee::Tecanvas::TComboFlat* CBNewRender;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TEdit* ECols;
	Vcl::Comctrls::TUpDown* UDCols;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall LBThemeClick(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall CBPaletteChange(System::TObject* Sender);
	void __fastcall BEditorFontClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CBDefaultFontClick(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	
private:
	Vcl::Graphics::TFont* FEditorFont;
	bool IChangedFont;
	Vcltee::Teetranslateeditor::TAskLanguage* tmpLang;
	void __fastcall ResizeImage();
	
public:
	bool ScaledChart;
	void __fastcall Save();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TOptionsForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TOptionsForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TOptionsForm() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TOptionsForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 TeeNewChartDefaultTheme = System::Int8(0x9);
static const System::Int8 TeeNewChartDefaultPalette = System::Int8(0xd);
extern DELPHI_PACKAGE int TeeNewChartTheme;
extern DELPHI_PACKAGE int TeeNewChartPalette;
}	/* namespace Teedesignoptions */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEDESIGNOPTIONS)
using namespace Vcltee::Teedesignoptions;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeedesignoptionsHPP
