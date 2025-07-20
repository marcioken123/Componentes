// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeFrameToolEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeframetooleditorHPP
#define Vcltee_TeeframetooleditorHPP

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
#include <Vcl.Buttons.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeFilters.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeFrameTool.hpp>
#include <VCLTee.TeeFiltersEditor.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeframetooleditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFrameToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TFrameToolEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TScrollBar* SBSize;
	Vcl::Stdctrls::TButton* BBrowse;
	Vcl::Stdctrls::TCheckBox* CBResize;
	Vcl::Comctrls::TTabSheet* TabPaspartou;
	Vcl::Stdctrls::TLabel* LSize;
	Vcltee::Tecanvas::TComboFlat* CBStyle;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Stdctrls::TCheckBox* CBChangeColor;
	Vcl::Stdctrls::TGroupBox* GroupColors;
	Vcl::Stdctrls::TScrollBar* SBRed;
	Vcl::Stdctrls::TScrollBar* SBGreen;
	Vcl::Stdctrls::TScrollBar* SBBlue;
	Vcl::Stdctrls::TLabel* LRed;
	Vcl::Stdctrls::TLabel* LGreen;
	Vcl::Stdctrls::TLabel* LBlue;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TScrollBar* SBPasSize;
	Vcl::Stdctrls::TLabel* LPasSize;
	Vcl::Comctrls::TPageControl* PagePaspartou;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabPattern;
	Vcl::Comctrls::TTabSheet* TabFilters;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall SBSizeChange(System::TObject* Sender);
	void __fastcall BBrowseClick(System::TObject* Sender);
	void __fastcall CBResizeClick(System::TObject* Sender);
	void __fastcall SBPasSizeChange(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	void __fastcall SBRedChange(System::TObject* Sender);
	void __fastcall CBChangeColorClick(System::TObject* Sender);
	void __fastcall SBGreenChange(System::TObject* Sender);
	void __fastcall SBBlueChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall PagePaspartouChange(System::TObject* Sender);
	
private:
	Vcltee::Teeframetool::TFrameTool* Tool;
	Vcltee::Teefilterseditor::TFiltersEditor* IFilters;
	void __fastcall ChangedFilters(System::TObject* Sender);
	void __fastcall CheckColorFilter();
	Vcltee::Teefilters::TColorFilter* __fastcall ColorFilter();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFrameToolEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFrameToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFrameToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFrameToolEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeframetooleditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEFRAMETOOLEDITOR)
using namespace Vcltee::Teeframetooleditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeframetooleditorHPP
