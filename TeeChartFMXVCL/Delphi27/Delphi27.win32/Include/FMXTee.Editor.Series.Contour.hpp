// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Contour.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_Series_ContourHPP
#define Fmxtee_Editor_Series_ContourHPP

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
#include <FMX.Graphics.hpp>
#include <FMX.SpinBox.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Series.Surface.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Colors.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Grid.hpp>
#include <FMXTee.Chart.Grid.hpp>
#include <FMXTee.Editor.Series.Pointer.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Contour
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TContourSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TContourSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Stdctrls::TCheckBox* CBSmooth;
	Fmx::Stdctrls::TButton* BPen;
	Fmx::Stdctrls::TButton* BFrame;
	Fmx::Spinbox::TSpinBox* UDContourTransp;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Tabcontrol::TTabItem* TabGrid3D;
	Fmx::Stdctrls::TButton* BCellPen;
	Fmx::Stdctrls::TCheckBox* CBColorEach;
	Fmx::Stdctrls::TCheckBox* CBInterpolate;
	Fmx::Stdctrls::TCheckBox* CBFill;
	Fmx::Tabcontrol::TTabItem* TabLevels;
	Fmx::Tabcontrol::TTabItem* TabMarks;
	Fmx::Tabcontrol::TTabItem* TabPointer;
	Fmx::Tabcontrol::TTabItem* TabPosition;
	Fmx::Stdctrls::TCheckBox* CBAutoLevels;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Spinbox::TSpinBox* UDNum;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Spinbox::TSpinBox* UDLevel;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Edit::TEdit* EText;
	Fmx::Edit::TEdit* EValue;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Stdctrls::TButton* BLevelPen;
	Fmx::Stdctrls::TButton* BLevelColor;
	Fmx::Stdctrls::TCheckBox* CBEmpty;
	Fmx::Stdctrls::TCheckBox* CBDefaultPen;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Stdctrls::TLabel* LSegmentCount;
	Fmx::Spinbox::TSpinBox* UDDensity;
	Fmx::Stdctrls::TLabel* Label7;
	Fmx::Spinbox::TSpinBox* UDMargin;
	Fmx::Stdctrls::TLabel* Label8;
	Fmx::Stdctrls::TCheckBox* CBMarks;
	Fmx::Stdctrls::TCheckBox* CBMarksColor;
	Fmx::Stdctrls::TCheckBox* CBMarksSegments;
	Fmx::Stdctrls::TCheckBox* CBOverlap;
	Fmx::Stdctrls::TCheckBox* CBYPosLevel;
	Fmx::Edit::TEdit* SEYPos;
	Fmx::Stdctrls::TLabel* Label9;
	Fmx::Stdctrls::TCheckBox* CBBottom;
	Fmx::Colors::TColorComboBox* BMarksColor;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBSmoothChange(System::TObject* Sender);
	void __fastcall BPenClick(System::TObject* Sender);
	void __fastcall BFrameClick(System::TObject* Sender);
	void __fastcall UDContourTranspChange(System::TObject* Sender);
	void __fastcall BCellPenClick(System::TObject* Sender);
	void __fastcall CBInterpolateChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CBColorEachChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall BLevelPenClick(System::TObject* Sender);
	void __fastcall UDNumChange(System::TObject* Sender);
	void __fastcall CBYPosLevelChange(System::TObject* Sender);
	void __fastcall SEYPosChange(System::TObject* Sender);
	void __fastcall CBAutoLevelsChange(System::TObject* Sender);
	void __fastcall BLevelColorClick(System::TObject* Sender);
	void __fastcall CBEmptyChange(System::TObject* Sender);
	void __fastcall UDLevelChange(System::TObject* Sender);
	void __fastcall ETextChange(System::TObject* Sender);
	void __fastcall CBDefaultPenChange(System::TObject* Sender);
	void __fastcall CBFillChange(System::TObject* Sender);
	void __fastcall CBMarksColorChange(System::TObject* Sender);
	void __fastcall CBMarksSegmentsChange(System::TObject* Sender);
	void __fastcall UDDensityChange(System::TObject* Sender);
	void __fastcall UDMarginChange(System::TObject* Sender);
	void __fastcall CBMarksChange(System::TObject* Sender);
	void __fastcall CBBottomChange(System::TObject* Sender);
	void __fastcall CBOverlapChange(System::TObject* Sender);
	void __fastcall EValueChange(System::TObject* Sender);
	
private:
	bool CreatingForm;
	Fmx::Forms::TCustomForm* Grid3DForm;
	Fmxtee::Series::Surface::TContourSeries* Contour;
	void __fastcall CheckBottom();
	void __fastcall DoCreateAutoLevels();
	Fmxtee::Series::Surface::TContourLevel* __fastcall Level();
	void __fastcall SetLevel();
	System::Uitypes::TAlphaColor __fastcall VisualColor();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TContourSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TContourSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TContourSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Contour */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_CONTOUR)
using namespace Fmxtee::Editor::Series::Contour;
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
#endif	// Fmxtee_Editor_Series_ContourHPP
