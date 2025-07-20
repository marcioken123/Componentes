// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeTagCloudEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeetagcloudeditorHPP
#define Vcltee_TeetagcloudeditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Grids.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeGriEd.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <VCLTee.TeeChartGrid.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeBrushDlg.hpp>
#include <VCLTee.TeeEdiGrad.hpp>
#include <VCLTee.TeeTagCloud.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teetagcloudeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTagCloudEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTagCloudEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabFont;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* EFilter;
	Vcl::Stdctrls::TCheckBox* CBClip;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* ESep;
	Vcl::Comctrls::TUpDown* UDSep;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TButton* Button2;
	Vcltee::Tecanvas::TComboFlat* ComboFlat1;
	Vcltee::Tecanvas::TComboFlat* ComboFlat2;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabPattern;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Comctrls::TTrackBar* TBTransp;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall EFilterChange(System::TObject* Sender);
	void __fastcall CBClipClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ESepChange(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Vcltee::Teegried::TGrid3DSeriesEditor* IGrid3D;
	Vcltee::Teetagcloud::TTagCloudSeries* TagCloud;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTagCloudEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTagCloudEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTagCloudEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTagCloudEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teetagcloudeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETAGCLOUDEDITOR)
using namespace Vcltee::Teetagcloudeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeetagcloudeditorHPP
