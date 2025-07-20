// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Map.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Editor_Series_MapHPP
#define Fmxtee_Editor_Series_MapHPP

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
#include <System.Rtti.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMXTee.Chart.ListBox.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMX.Controls.Presentation.hpp>
#include <FMX.EditBox.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Series.Map.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Colors.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Grid.hpp>
#include <FMXTee.Chart.Grid.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMXTee.Editor.Brush.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Map
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TMapSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TMapSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControlMap;
	Fmx::Tabcontrol::TTabItem* TabGlobal;
	Fmx::Tabcontrol::TTabItem* TabShadow;
	Fmx::Tabcontrol::TTabItem* TabEmboss;
	Fmx::Stdctrls::TCheckBox* CBTransparent;
	Fmx::Stdctrls::TButton* BBorder;
	Fmx::Stdctrls::TButton* BBrush;
	Fmx::Spinbox::TSpinBox* UDMapTransp;
	Fmx::Stdctrls::TLabel* LTransp;
	Fmx::Spinbox::TSpinBox* UDPointSize;
	Fmx::Stdctrls::TLabel* LPointSize;
	Fmx::Tabcontrol::TTabItem* TabShapes;
	Fmx::Stdctrls::TPanel* PanelShapes;
	Fmx::Stdctrls::TPanel* PanelShapeButtons;
	Fmx::Stdctrls::TPanel* PanelShapesLeft;
	Fmx::Tabcontrol::TTabControl* TabControlShape;
	Fmx::Stdctrls::TSplitter* SplitterShapes;
	Fmx::Tabcontrol::TTabItem* TabValues;
	Fmx::Tabcontrol::TTabItem* TabFormat;
	Fmx::Tabcontrol::TTabItem* TabPoints;
	Fmx::Edit::TEdit* EText;
	Fmx::Edit::TEdit* EditZ;
	Fmx::Stdctrls::TLabel* LShapeText;
	Fmx::Stdctrls::TLabel* LShapeZ;
	Fmx::Stdctrls::TLabel* LShapeIndex;
	Fmx::Stdctrls::TLabel* ShapeIndex;
	Fmx::Colors::TComboColorBox* CBColor;
	Fmx::Stdctrls::TLabel* LColor;
	Fmx::Stdctrls::TCheckBox* CBGlobalPen;
	Fmx::Stdctrls::TCheckBox* CBGlobalBrush;
	Fmx::Stdctrls::TCheckBox* CBDefaultColor;
	Fmx::Stdctrls::TCheckBox* CBClosed;
	Fmx::Stdctrls::TCheckBox* CBVisible;
	Fmx::Spinbox::TSpinBox* UDTransp;
	Fmx::Stdctrls::TLabel* LFormatTransp;
	Fmx::Stdctrls::TButton* SBAdd;
	Fmx::Stdctrls::TButton* SBDelete;
	Fmx::Tabcontrol::TTabItem* TabGrid3D;
	Fmxtee::Chart::Listbox::TChartListBox* LBShapes;
	Fmx::Stdctrls::TLabel* LabelCode;
	Fmx::Edit::TEdit* ECode;
	Fmx::Tabcontrol::TTabItem* TabBorder;
	Fmx::Tabcontrol::TTabItem* TabPattern;
	Fmx::Tabcontrol::TTabItem* TabMarks;
	Fmx::Stdctrls::TGroupBox* GBMapMarks;
	Fmx::Listbox::TComboBox* CBMarksText;
	Fmx::Stdctrls::TCheckBox* CBMarksAutoSize;
	Fmx::Stdctrls::TCheckBox* CBMarksUpper;
	Fmx::Stdctrls::TCheckBox* CBMarksCentroids;
	Fmx::Stdctrls::TCheckBox* CBAutoColor;
	Fmx::Tabcontrol::TTabItem* TabLegend;
	Fmx::Stdctrls::TGroupBox* GBLegend;
	Fmx::Stdctrls::TCheckBox* CBLegendZero;
	Fmx::Stdctrls::TCheckBox* CBLegendEmpty;
	Fmx::Listbox::TComboBox* CBLegendSort;
	Fmx::Stdctrls::TLabel* LSortBy;
	Fmx::Stdctrls::TCheckBox* CBLegendInverted;
	Fmx::Stdctrls::TLabel* LLegendStyle;
	Fmx::Listbox::TComboBox* CBLegendStyle;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBTransparentChange(System::TObject* Sender);
	void __fastcall BBorderClick(System::TObject* Sender);
	void __fastcall BBrushClick(System::TObject* Sender);
	void __fastcall UDMapTranspChange(System::TObject* Sender);
	void __fastcall UDPointSizeChange(System::TObject* Sender);
	void __fastcall ETextChange(System::TObject* Sender);
	void __fastcall EditZChange(System::TObject* Sender);
	void __fastcall LBShapesClick(System::TObject* Sender);
	void __fastcall CBColorChange(System::TObject* Sender);
	void __fastcall TabControlMapChange(System::TObject* Sender);
	void __fastcall CBGlobalPenChange(System::TObject* Sender);
	void __fastcall CBGlobalBrushChange(System::TObject* Sender);
	void __fastcall SBDeleteClick(System::TObject* Sender);
	void __fastcall SBAddClick(System::TObject* Sender);
	void __fastcall CBDefaultColorChange(System::TObject* Sender);
	void __fastcall CBClosedChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBVisibleChange(System::TObject* Sender);
	void __fastcall UDTranspChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall LBShapesChangeCheck(System::TObject* Sender);
	void __fastcall ECodeChange(System::TObject* Sender);
	void __fastcall TabControlShapeChange(System::TObject* Sender);
	void __fastcall CBMarksTextChange(System::TObject* Sender);
	void __fastcall CBMarksAutoSizeChange(System::TObject* Sender);
	void __fastcall CBMarksUpperChange(System::TObject* Sender);
	void __fastcall CBMarksCentroidsChange(System::TObject* Sender);
	void __fastcall CBAutoColorChange(System::TObject* Sender);
	void __fastcall CBLegendZeroChange(System::TObject* Sender);
	void __fastcall CBLegendEmptyChange(System::TObject* Sender);
	void __fastcall CBLegendSortChange(System::TObject* Sender);
	void __fastcall CBLegendInvertedChange(System::TObject* Sender);
	void __fastcall CBLegendStyleChange(System::TObject* Sender);
	
private:
	bool ChangingColor;
	bool ChangingText;
	Fmx::Forms::TCustomForm* Grid3DForm;
	Fmxtee::Chart::Grid::TChartGrid* FChartGrid;
	bool IReady;
	Fmxtee::Editor::Stroke::TStrokeEditor* IShapeBorder;
	Fmxtee::Editor::Brush::TBrushEditor* IShapeBrush;
	void __fastcall CheckDefaultColor();
	void __fastcall EnableTabs();
	void __fastcall FillShapes();
	Fmxtee::Series::Map::TTeePolygon* __fastcall SelectedShape();
	void __fastcall ChartGridSetEditText(System::TObject* Sender, const int ACol, const int ARow, const System::Rtti::TValue &Value);
	
protected:
	Fmxtee::Series::Map::TMapSeries* Map;
	bool DirtyList;
	
public:
	System::TObject* InitialShape;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TMapSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TMapSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TMapSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Map */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_MAP)
using namespace Fmxtee::Editor::Series::Map;
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
#endif	// Fmxtee_Editor_Series_MapHPP
