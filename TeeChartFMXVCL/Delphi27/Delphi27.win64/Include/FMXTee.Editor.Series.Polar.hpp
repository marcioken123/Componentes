// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Polar.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_Series_PolarHPP
#define Fmxtee_Editor_Series_PolarHPP

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
#include <FMXTee.Chart.ListBox.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Series.Polar.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Colors.hpp>
#include <FMX.Layouts.hpp>
#include <FMXTee.Editor.Font.hpp>
#include <FMXTee.Editor.Series.Circled.hpp>
#include <FMXTee.Editor.Series.Pointer.hpp>
#include <FMXTee.Engine.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Polar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPolarSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPolarSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabLabels;
	Fmx::Tabcontrol::TTabItem* TabFont;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Stdctrls::TButton* BPen;
	Fmx::Stdctrls::TButton* BBrush;
	Fmx::Spinbox::TSpinBox* UDTransp;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Stdctrls::TCheckBox* CBColorEach;
	Fmx::Listbox::TComboBox* CBNulls;
	Fmx::Listbox::TListBoxItem* ListBoxItem7;
	Fmx::Listbox::TListBoxItem* ListBoxItem8;
	Fmx::Listbox::TListBoxItem* ListBoxItem9;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Edit::TEdit* SEAngleInc;
	Fmx::Stdctrls::TLabel* LAngleInc;
	Fmx::Edit::TEdit* SERadiusInc;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Stdctrls::TButton* BPiePen;
	Fmx::Stdctrls::TCheckBox* CBClose;
	Fmx::Stdctrls::TCheckBox* CBAngleLabels;
	Fmx::Stdctrls::TCheckBox* CBLabelsRot;
	Fmx::Stdctrls::TCheckBox* CBClockWise;
	Fmx::Stdctrls::TCheckBox* CBInside;
	Fmx::Spinbox::TSpinBox* UDMargin;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Colors::TComboColorBox* CBColor;
	Fmx::Stdctrls::TCheckBox* CBPointerBehind;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BPenClick(System::TObject* Sender);
	void __fastcall BBrushClick(System::TObject* Sender);
	void __fastcall CBColorEachChange(System::TObject* Sender);
	void __fastcall UDTranspChange(System::TObject* Sender);
	void __fastcall SEAngleIncChange(System::TObject* Sender);
	void __fastcall CBNullsChange(System::TObject* Sender);
	void __fastcall SERadiusIncChange(System::TObject* Sender);
	void __fastcall BPiePenClick(System::TObject* Sender);
	void __fastcall CBCloseChange(System::TObject* Sender);
	void __fastcall CBColorChange(System::TObject* Sender);
	void __fastcall CBAngleLabelsChange(System::TObject* Sender);
	void __fastcall CBLabelsRotChange(System::TObject* Sender);
	void __fastcall CBClockWiseChange(System::TObject* Sender);
	void __fastcall CBInsideChange(System::TObject* Sender);
	void __fastcall UDMarginChange(System::TObject* Sender);
	void __fastcall ComboColorBox1Change(System::TObject* Sender);
	void __fastcall CBPointerBehindChange(System::TObject* Sender);
	
private:
	Fmxtee::Editor::Series::Circled::TCircledSeriesEditor* FCircledEditor;
	Fmxtee::Editor::Series::Pointer::TSeriesPointerEditor* FPointerEditor;
	void __fastcall EnableLabels();
	
protected:
	Fmxtee::Series::Polar::TCustomPolarSeries* Polar;
	virtual void __fastcall HideAngleInc();
	virtual Fmxtee::Series::Polar::TCustomPolarSeries* __fastcall CreatePolar();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPolarSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPolarSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPolarSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Polar */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_POLAR)
using namespace Fmxtee::Editor::Series::Polar;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES)
using namespace Fmxtee::Editor::Series;
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
#endif	// Fmxtee_Editor_Series_PolarHPP
