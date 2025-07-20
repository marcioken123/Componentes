// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.ErrorPoint3D.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Series_Errorpoint3dHPP
#define Fmxtee_Editor_Series_Errorpoint3dHPP

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
#include <FMX.Colors.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.ListBox.hpp>
#include <FMXTee.Series.ErrorPoint.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMX.Layouts.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Series.Error.hpp>
#include <FMXTee.Editor.Series.Pointer.hpp>
#include <FMXTee.Constants.hpp>
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
namespace Errorpoint3d
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TErrorPoint3DSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TErrorPoint3DSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Stdctrls::TCheckBox* CBColorEach;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Stdctrls::TTrackBar* UDBarWidth;
	Fmx::Stdctrls::TLabel* LErrorWidth;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Listbox::TComboBox* CBWidthUnits;
	Fmx::Listbox::TListBoxItem* percent;
	Fmx::Listbox::TListBoxItem* pixels;
	Fmx::Tabcontrol::TTabItem* TabBorder;
	Fmx::Listbox::TListBox* LBBorders;
	Fmx::Listbox::TListBoxItem* LBLeft;
	Fmx::Listbox::TListBoxItem* LBTop;
	Fmx::Listbox::TListBoxItem* LBRight;
	Fmx::Listbox::TListBoxItem* LBBottom;
	Fmx::Tabcontrol::TTabItem* TabPointer;
	Fmx::Listbox::TListBoxItem* LBFront;
	Fmx::Listbox::TListBoxItem* LBBack;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBWidthUnitsChange(System::TObject* Sender);
	void __fastcall UDBarWidthChange(System::TObject* Sender);
	void __fastcall CBColorEachChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall LBBordersClick(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	
private:
	Fmxtee::Series::Errorpoint::TCustomErrorPoint3DSeries* ErrorPoint3DSeries;
	Fmx::Forms::TCustomForm* FPointForm;
	Fmxtee::Editor::Stroke::TStrokeEditor* IPenEditor;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TErrorPoint3DSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TErrorPoint3DSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TErrorPoint3DSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TErrorPoint3DSeriesEditor* ErrorPoint3DSeriesEditor;
}	/* namespace Errorpoint3d */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_ERRORPOINT3D)
using namespace Fmxtee::Editor::Series::Errorpoint3d;
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
#endif	// Fmxtee_Editor_Series_Errorpoint3dHPP
