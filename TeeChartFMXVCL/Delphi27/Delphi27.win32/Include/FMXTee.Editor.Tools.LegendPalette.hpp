// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.LegendPalette.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_Tools_LegendpaletteHPP
#define Fmxtee_Editor_Tools_LegendpaletteHPP

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
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMXTee.Editor.Tools.Series.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMXTee.Tools.LegendPalette.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Colors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Legendpalette
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLegendPaletteEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLegendPaletteEditor : public Fmxtee::Editor::Tools::Series::TSeriesToolEditor
{
	typedef Fmxtee::Editor::Tools::Series::TSeriesToolEditor inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabPosition;
	Fmx::Tabcontrol::TTabItem* TabPanel;
	Fmx::Stdctrls::TButton* BPen;
	Fmx::Stdctrls::TCheckBox* CBVertical;
	Fmx::Stdctrls::TCheckBox* CBInverted;
	Fmx::Stdctrls::TCheckBox* CBTransparent;
	Fmx::Stdctrls::TCheckBox* CBSmooth;
	Fmx::Stdctrls::TButton* BBorder;
	Fmx::Stdctrls::TGroupBox* GBAxis;
	Fmx::Stdctrls::TRadioButton* RBDefault;
	Fmx::Stdctrls::TRadioButton* RBOther;
	Fmx::Stdctrls::TRadioButton* RBBoth;
	Fmx::Listbox::TComboBox* CBUnits;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Spinbox::TSpinBox* UDLeft;
	Fmx::Spinbox::TSpinBox* UDTop;
	Fmx::Spinbox::TSpinBox* UDWidth;
	Fmx::Spinbox::TSpinBox* UDHeight;
	Fmx::Tabcontrol::TTabItem* TabAxes;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BPenClick(System::TObject* Sender);
	void __fastcall BBorderClick(System::TObject* Sender);
	void __fastcall CBVerticalChange(System::TObject* Sender);
	void __fastcall CBInvertedChange(System::TObject* Sender);
	void __fastcall CBTransparentChange(System::TObject* Sender);
	void __fastcall CBSmoothChange(System::TObject* Sender);
	void __fastcall RBDefaultChange(System::TObject* Sender);
	void __fastcall RBOtherChange(System::TObject* Sender);
	void __fastcall RBBothChange(System::TObject* Sender);
	void __fastcall UDLeftChange(System::TObject* Sender);
	void __fastcall UDTopChange(System::TObject* Sender);
	void __fastcall UDWidthChange(System::TObject* Sender);
	void __fastcall UDHeightChange(System::TObject* Sender);
	void __fastcall CBUnitsChange(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Legendpalette::TLegendPaletteTool* LegendPalette;
	Fmx::Forms::TForm* IAxes;
	Fmx::Forms::TForm* IPanel;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLegendPaletteEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLegendPaletteEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLegendPaletteEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Legendpalette */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_LEGENDPALETTE)
using namespace Fmxtee::Editor::Tools::Legendpalette;
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
#endif	// Fmxtee_Editor_Tools_LegendpaletteHPP
