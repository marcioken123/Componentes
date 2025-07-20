// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeScrollPagerEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeescrollpagereditorHPP
#define Vcltee_TeescrollpagereditorHPP

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
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeScrollPagerTool.hpp>
#include <VCLTee.TeeToolSeriesEdit.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeSubChartEditor.hpp>
#include <VCLTee.TeeColorBandEdit.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teescrollpagereditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TScrollPagerEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TScrollPagerEditor : public Vcltee::Teetoolseriesedit::TSeriesToolEditor
{
	typedef Vcltee::Teetoolseriesedit::TSeriesToolEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* tsOptions;
	Vcl::Comctrls::TTabSheet* tsSubChartTool;
	Vcl::Comctrls::TTabSheet* tsColorBandTool;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* udDivision;
	Vcltee::Tecanvas::TButtonColor* BHighlight;
	Vcl::Comctrls::TTabSheet* TabPointers;
	Vcl::Comctrls::TPageControl* PagePointers;
	Vcl::Comctrls::TTabSheet* TabStart;
	Vcl::Comctrls::TTabSheet* TabEnd;
	Vcl::Stdctrls::TCheckBox* CBNoLimitDrag;
	Vcl::Stdctrls::TLabel* Label3;
	Vcltee::Tecanvas::TComboFlat* CBAlign;
	void __fastcall udDivisionClick(System::TObject* Sender, Vcl::Comctrls::TUDBtnType Button);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall PagePointersChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall CBNoLimitDragClick(System::TObject* Sender);
	void __fastcall CBAlignChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	
private:
	Vcltee::Teescrollpagertool::TScrollPagerTool* Tool;
	Vcltee::Teesubcharteditor::TSubChartEditor* SubChart;
	Vcltee::Teecolorbandedit::TColorBandToolEditor* ColorBand;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TScrollPagerEditor(System::Classes::TComponent* AOwner) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TScrollPagerEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TScrollPagerEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TScrollPagerEditor(HWND ParentWindow) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teescrollpagereditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESCROLLPAGEREDITOR)
using namespace Vcltee::Teescrollpagereditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeescrollpagereditorHPP
