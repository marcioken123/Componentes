// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeCustomLegendToolEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecustomlegendtooleditorHPP
#define Vcltee_TeecustomlegendtooleditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.ImgList.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeeAnnToolEdit.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeCustomLegendTool.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecustomlegendtooleditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomLegendToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomLegendToolEditor : public Vcltee::Teeanntooledit::TAnnotationToolEdit
{
	typedef Vcltee::Teeanntooledit::TAnnotationToolEdit inherited;
	
__published:
	Vcl::Stdctrls::TCheckBox* CBDrag1;
	Vcl::Stdctrls::TCheckBox* CBResize1;
	Vcl::Comctrls::TTabSheet* TabGrid;
	Vcl::Stdctrls::TLabel* Label18;
	Vcl::Stdctrls::TLabel* Label19;
	Vcl::Stdctrls::TLabel* Label24;
	Vcl::Stdctrls::TEdit* EColCount;
	Vcl::Comctrls::TUpDown* UDColCount;
	Vcl::Stdctrls::TLabel* Label17;
	Vcl::Stdctrls::TLabel* Label20;
	Vcl::Stdctrls::TLabel* Label21;
	Vcl::Stdctrls::TEdit* ERowCount;
	Vcl::Comctrls::TUpDown* UDRowCount;
	Vcl::Stdctrls::TEdit* EFixedCols;
	Vcl::Comctrls::TUpDown* UDFixedCols;
	Vcl::Stdctrls::TEdit* EFixedRows;
	Vcl::Comctrls::TUpDown* UDFixedRows;
	Vcl::Stdctrls::TLabel* Label22;
	Vcl::Stdctrls::TLabel* Label23;
	Vcl::Stdctrls::TEdit* EGridWidth;
	Vcl::Comctrls::TUpDown* UDGridWidth;
	Vcl::Stdctrls::TEdit* EGridHeight;
	Vcl::Comctrls::TUpDown* UDGridHeight;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBDrag1Click(System::TObject* Sender);
	void __fastcall CBResize1Click(System::TObject* Sender);
	void __fastcall EColCountChange(System::TObject* Sender);
	HIDESBASE void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall EFixedColsChange(System::TObject* Sender);
	void __fastcall EFixedRowsChange(System::TObject* Sender);
	void __fastcall EGridWidthChange(System::TObject* Sender);
	void __fastcall EGridHeightChange(System::TObject* Sender);
	
public:
	Vcltee::Teecustomlegendtool::TCustomLegendTool* CustomLegend;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TCustomLegendToolEditor(System::Classes::TComponent* AOwner) : Vcltee::Teeanntooledit::TAnnotationToolEdit(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCustomLegendToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teeanntooledit::TAnnotationToolEdit(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCustomLegendToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomLegendToolEditor(HWND ParentWindow) : Vcltee::Teeanntooledit::TAnnotationToolEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecustomlegendtooleditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECUSTOMLEGENDTOOLEDITOR)
using namespace Vcltee::Teecustomlegendtooleditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecustomlegendtooleditorHPP
