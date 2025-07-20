// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Shape.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Editor_Series_ShapeHPP
#define Fmxtee_Editor_Series_ShapeHPP

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
#include <FMX.TabControl.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.ComboTrackBar.hpp>
#include <FMXTee.RadioGroup.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Memo.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Colors.hpp>
#include <FMX.ListBox.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Editor.Font.hpp>
#include <FMXTee.Series.Shape.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Shape
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TChartShapeEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TChartShapeEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Listbox::TComboBox* CBStyle;
	Fmx::Colors::TComboColorBox* BShapeColor;
	Fmx::Stdctrls::TButton* Button2;
	Fmx::Stdctrls::TButton* Button3;
	Fmx::Listbox::TComboBox* CBUnits;
	Fmx::Memo::TMemo* MemoText;
	Fmx::Stdctrls::TCheckBox* CBRound;
	Fmx::Stdctrls::TCheckBox* CBTrans;
	Fmx::Combotrackbar::TComboTrackBar* UDTransp;
	Fmx::Combotrackbar::TComboTrackBar* SEX1;
	Fmx::Combotrackbar::TComboTrackBar* SEX0;
	Fmx::Combotrackbar::TComboTrackBar* SEY0;
	Fmx::Combotrackbar::TComboTrackBar* SEY1;
	Fmxtee::Radiogroup::TRadioGroup* RGAlign;
	Fmxtee::Radiogroup::TRadioGroup* RGVertAlign;
	Fmx::Tabcontrol::TTabItem* TabFont;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBUnitsChange(System::TObject* Sender);
	void __fastcall CBRoundChange(System::TObject* Sender);
	void __fastcall RGVertAlignChange(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	void __fastcall CBTransChange(System::TObject* Sender);
	void __fastcall RGAlignChange(System::TObject* Sender);
	void __fastcall MemoTextChangeTracking(System::TObject* Sender);
	void __fastcall BShapeBrushClick(System::TObject* Sender);
	void __fastcall BShapeColorChange(System::TObject* Sender);
	
private:
	bool CreatingForm;
	Fmxtee::Editor::Font::TFontEditor* FEditFont;
	Fmxtee::Series::Shape::TChartShape* TheSeries;
	void __fastcall EnableRound();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TChartShapeEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TChartShapeEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TChartShapeEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Shape */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_SHAPE)
using namespace Fmxtee::Editor::Series::Shape;
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
#endif	// Fmxtee_Editor_Series_ShapeHPP
