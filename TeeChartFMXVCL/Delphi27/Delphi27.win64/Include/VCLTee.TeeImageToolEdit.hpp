// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeImageToolEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeimagetooleditHPP
#define Vcltee_TeeimagetooleditHPP

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
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtDlgs.hpp>
#include <VCLTee.TeeToolSeriesEdit.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeimagetooledit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TChartImageToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TChartImageToolEditor : public Vcltee::Teetoolseriesedit::TSeriesToolEditor
{
	typedef Vcltee::Teetoolseriesedit::TSeriesToolEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Extctrls::TImage* Image1;
	Vcl::Stdctrls::TButton* BSave;
	void __fastcall Button1Click(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall BSaveClick(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	Vcltee::Teetools::TChartImageTool* Image;
	void __fastcall CheckImageButton();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TChartImageToolEditor(System::Classes::TComponent* AOwner) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TChartImageToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TChartImageToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TChartImageToolEditor(HWND ParentWindow) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeimagetooledit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEIMAGETOOLEDIT)
using namespace Vcltee::Teeimagetooledit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeimagetooleditHPP
