// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeDashBoardEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeedashboardeditHPP
#define Vcltee_TeedashboardeditHPP

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
#include <System.Variants.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeeSubChartEditor.hpp>
#include <VCLTee.TeeSubChart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teedashboardedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDashBoardEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDashBoardEditor : public Vcltee::Teesubcharteditor::TSubChartEditor
{
	typedef Vcltee::Teesubcharteditor::TSubChartEditor inherited;
	
__published:
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	HIDESBASE void __fastcall BAddClick(System::TObject* Sender);
	HIDESBASE void __fastcall BDeleteClick(System::TObject* Sender);
	HIDESBASE void __fastcall BDownClick(System::TObject* Sender);
	HIDESBASE void __fastcall BUpClick(System::TObject* Sender);
	
public:
	Vcltee::Teesubchart::TSubChartTool* ATool;
	void __fastcall SetTool(Vcltee::Teesubchart::TSubChartTool* ATool);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDashBoardEditor(System::Classes::TComponent* AOwner) : Vcltee::Teesubcharteditor::TSubChartEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDashBoardEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teesubcharteditor::TSubChartEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDashBoardEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TDashBoardEditor(HWND ParentWindow) : Vcltee::Teesubcharteditor::TSubChartEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teedashboardedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEDASHBOARDEDIT)
using namespace Vcltee::Teedashboardedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeedashboardeditHPP
