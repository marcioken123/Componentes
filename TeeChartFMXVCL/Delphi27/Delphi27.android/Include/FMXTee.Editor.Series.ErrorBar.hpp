// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.ErrorBar.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Series_ErrorbarHPP
#define Fmxtee_Editor_Series_ErrorbarHPP

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
#include <FMX.Edit.hpp>
#include <FMX.Colors.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Series.Error.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMXTee.Procs.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Errorbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TErrorBarSeriesEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TErrorBarSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabBorder;
	Fmx::Stdctrls::TGroupBox* RGStyle;
	Fmx::Stdctrls::TRadioButton* rbTop;
	Fmx::Stdctrls::TRadioButton* rbRight;
	Fmx::Stdctrls::TRadioButton* rbLeft;
	Fmx::Stdctrls::TRadioButton* rbBottom;
	Fmx::Stdctrls::TRadioButton* rbLeftRight;
	Fmx::Stdctrls::TRadioButton* rbTopBottom;
	Fmx::Colors::TComboColorBox* BColor;
	Fmx::Stdctrls::TCheckBox* CBColorEach;
	Fmx::Stdctrls::TLabel* LHeight;
	Fmx::Spinbox::TSpinBox* UDBarWidth;
	Fmx::Stdctrls::TGroupBox* GroupBox2;
	Fmx::Stdctrls::TRadioButton* rbPixels;
	Fmx::Stdctrls::TRadioButton* rbPercent;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall UDBarWidthChange(System::TObject* Sender);
	void __fastcall CBColorEachChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall BColorChange(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	
private:
	Fmxtee::Series::Error::TCustomErrorSeries* ErrorSeries;
	Fmx::Forms::TCustomForm* FBarForm;
	Fmxtee::Editor::Stroke::TStrokeEditor* IPenEditor;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TErrorBarSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TErrorBarSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TErrorBarSeriesEditor() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Errorbar */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_ERRORBAR)
using namespace Fmxtee::Editor::Series::Errorbar;
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
#endif	// Fmxtee_Editor_Series_ErrorbarHPP
