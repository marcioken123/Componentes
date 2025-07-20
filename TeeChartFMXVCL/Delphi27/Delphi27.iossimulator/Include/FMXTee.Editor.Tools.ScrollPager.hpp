// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.ScrollPager.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Editor_Tools_ScrollpagerHPP
#define Fmxtee_Editor_Tools_ScrollpagerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Rtti.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMXTee.Editor.Tools.Series.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Colors.hpp>
#include <FMX.Edit.hpp>
#include <FMXTee.Editor.Series.Pointer.hpp>
#include <FMXTee.Tools.ScrollPager.hpp>
#include <FMXTee.Editor.Tools.SubChart.hpp>
#include <FMXTee.Editor.Tools.ColorBand.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Scrollpager
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TScrollPagerEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TScrollPagerEditor : public Fmxtee::Editor::Tools::Series::TSeriesToolEditor
{
	typedef Fmxtee::Editor::Tools::Series::TSeriesToolEditor inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* PageControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabSubChart;
	Fmx::Tabcontrol::TTabItem* TabColorBand;
	Fmx::Tabcontrol::TTabItem* TabPointers;
	Fmx::Tabcontrol::TTabControl* PagePointers;
	Fmx::Tabcontrol::TTabItem* TabStart;
	Fmx::Tabcontrol::TTabItem* TabEnd;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Edit::TEdit* UDDivision;
	Fmx::Stdctrls::TCheckBox* CBNoLimitDrag;
	Fmx::Listbox::TComboBox* CBAlign;
	Fmx::Colors::TComboColorBox* BHighLight;
	Fmx::Stdctrls::TLabel* Label4;
	void __fastcall CBAlignChange(System::TObject* Sender);
	void __fastcall CBNoLimitDragChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall PagePointersChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall UDDivisionChangeTracking(System::TObject* Sender);
	void __fastcall UDDivisionChange(System::TObject* Sender);
	void __fastcall BHighLightChange(System::TObject* Sender);
	
private:
	Fmxtee::Editor::Series::Pointer::TSeriesPointerEditor* IStart;
	Fmxtee::Editor::Series::Pointer::TSeriesPointerEditor* IEnd;
	Fmxtee::Tools::Scrollpager::TScrollPagerTool* Tool;
	Fmxtee::Editor::Tools::Subchart::TSubChartEditor* SubChart;
	Fmxtee::Editor::Tools::Colorband::TColorBandToolEditor* ColorBand;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TScrollPagerEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TScrollPagerEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TScrollPagerEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Scrollpager */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_SCROLLPAGER)
using namespace Fmxtee::Editor::Tools::Scrollpager;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS)
using namespace Fmxtee::Editor::Tools;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR)
using namespace Fmxtee::Editor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Editor_Tools_ScrollpagerHPP
