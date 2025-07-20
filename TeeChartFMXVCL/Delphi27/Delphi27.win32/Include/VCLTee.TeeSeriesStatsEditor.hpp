// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSeriesStatsEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeseriesstatseditorHPP
#define Vcltee_TeeseriesstatseditorHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeeToolSeriesEdit.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeSeriesStats.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeseriesstatseditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSeriesStatsEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSeriesStatsEditor : public Vcltee::Teetoolseriesedit::TSeriesToolEditor
{
	typedef Vcltee::Teetoolseriesedit::TSeriesToolEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TCheckBox* CheckBox1;
	Vcl::Stdctrls::TCheckBox* CheckBox2;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TMemo* Memo1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TCheckBox* CheckBox3;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Stdctrls::TCheckBox* CheckBox4;
	Vcl::Stdctrls::TButton* Button4;
	Vcl::Stdctrls::TCheckBox* CheckBox5;
	Vcl::Stdctrls::TButton* Button5;
	Vcl::Stdctrls::TCheckBox* CheckBox6;
	Vcl::Stdctrls::TButton* Button6;
	Vcl::Stdctrls::TButton* BRemoveAll;
	HIDESBASE void __fastcall CBSeriesChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CheckBox1Click(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall CheckBox2Click(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CheckBox3Click(System::TObject* Sender);
	void __fastcall CheckBox4Click(System::TObject* Sender);
	void __fastcall CheckBox5Click(System::TObject* Sender);
	void __fastcall CheckBox6Click(System::TObject* Sender);
	void __fastcall BRemoveAllClick(System::TObject* Sender);
	
private:
	void __fastcall CheckFunction(Vcl::Stdctrls::TCheckBox* const ABox, Vcltee::Teengine::TTeeFunctionClass AFunctionClass);
	void __fastcall EnableControls();
	void __fastcall EnableRemoveAll();
	void __fastcall RefreshInfo();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSeriesStatsEditor(System::Classes::TComponent* AOwner) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSeriesStatsEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSeriesStatsEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSeriesStatsEditor(HWND ParentWindow) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeseriesstatseditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESERIESSTATSEDITOR)
using namespace Vcltee::Teeseriesstatseditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeseriesstatseditorHPP
