// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeGanttToolEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeegantttooleditorHPP
#define Vcltee_TeegantttooleditorHPP

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
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.GanttCh.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeGanttTool.hpp>
#include <VCLTee.TeeToolSeriesEdit.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teegantttooleditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGanttToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TGanttToolEditor : public Vcltee::Teetoolseriesedit::TSeriesToolEditor
{
	typedef Vcltee::Teetoolseriesedit::TSeriesToolEditor inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UpDown1;
	Vcl::Stdctrls::TCheckBox* CBAllowDrag;
	Vcl::Stdctrls::TCheckBox* CBAllowResize;
	Vcl::Stdctrls::TLabel* Label3;
	Vcltee::Tecanvas::TComboFlat* CBCursorDrag;
	Vcl::Stdctrls::TLabel* Label4;
	Vcltee::Tecanvas::TComboFlat* CBCursorResize;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Buttons::TSpeedButton* SpeedButton2;
	void __fastcall Edit1Change(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBAllowDragClick(System::TObject* Sender);
	void __fastcall CBAllowResizeClick(System::TObject* Sender);
	void __fastcall CBCursorDragChange(System::TObject* Sender);
	void __fastcall CBCursorResizeChange(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	
private:
	bool CreatingForm;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TGanttToolEditor(System::Classes::TComponent* AOwner) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TGanttToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TGanttToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGanttToolEditor(HWND ParentWindow) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teegantttooleditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEGANTTTOOLEDITOR)
using namespace Vcltee::Teegantttooleditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeegantttooleditorHPP
