// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.PolarGrid.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_Series_PolargridHPP
#define Fmxtee_Editor_Series_PolargridHPP

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
#include <FMXTee.Editor.Series.Polar.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Colors.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Editor.Series.Grid.hpp>
#include <FMXTee.Series.PolarGrid.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Polargrid
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPolarGridSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPolarGridSeriesEditor : public Fmxtee::Editor::Series::Polar::TPolarSeriesEditor
{
	typedef Fmxtee::Editor::Series::Polar::TPolarSeriesEditor inherited;
	
__published:
	Fmx::Stdctrls::TCheckBox* CBCentered;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Listbox::TComboBox* CBGridStyle;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	void __fastcall CBCenteredChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CBGridStyleChange(System::TObject* Sender);
	
private:
	Fmxtee::Editor::Series::Grid::TGrid3DSeriesEditor* I3DEditor;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPolarGridSeriesEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Series::Polar::TPolarSeriesEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPolarGridSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Series::Polar::TPolarSeriesEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPolarGridSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TPolarGridSeriesEditor* PolarGridSeriesEditor;
}	/* namespace Polargrid */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_POLARGRID)
using namespace Fmxtee::Editor::Series::Polargrid;
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
#endif	// Fmxtee_Editor_Series_PolargridHPP
