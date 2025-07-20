// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.WorldMap.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Editor_Series_WorldmapHPP
#define Fmxtee_Editor_Series_WorldmapHPP

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
#include <FMXTee.Editor.Series.Map.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Colors.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Series.World.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Worldmap
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TWorldSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TWorldSeriesEditor : public Fmxtee::Editor::Series::Map::TMapSeriesEditor
{
	typedef Fmxtee::Editor::Series::Map::TMapSeriesEditor inherited;
	
__published:
	Fmx::Tabcontrol::TTabItem* TabLayers;
	Fmx::Stdctrls::TCheckBox* CBFlags;
	Fmx::Stdctrls::TCheckBox* CBStates;
	Fmx::Stdctrls::TCheckBox* CBCities;
	Fmx::Stdctrls::TPanel* Panel1;
	Fmx::Layouts::TLayout* LayoutTop;
	Fmx::Stdctrls::TLabel* LMap;
	Fmx::Listbox::TListBox* LWorldMap;
	Fmx::Stdctrls::TCheckBox* CBKeepAspect;
	Fmx::Stdctrls::TLabel* LCitySize;
	Fmx::Listbox::TComboBox* CBCitySize;
	Fmx::Edit::TEdit* ECitySize;
	Fmx::Stdctrls::TLabel* LRender;
	Fmx::Listbox::TComboBox* CBRender;
	void __fastcall CBFlagsChange(System::TObject* Sender);
	void __fastcall CBStatesChange(System::TObject* Sender);
	void __fastcall CBCitiesChange(System::TObject* Sender);
	void __fastcall CBKeepAspectChange(System::TObject* Sender);
	void __fastcall LWorldMapChange(System::TObject* Sender);
	void __fastcall CBCitySizeChange(System::TObject* Sender);
	void __fastcall ECitySizeChangeTracking(System::TObject* Sender);
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBRenderChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	bool PreparedMapList;
	void __fastcall FreeWorldMapListObjects();
	Fmxtee::Series::World::TWorldSeries* __fastcall World();
	
public:
	__classmethod void __fastcall PrepareWorldMapListBox(System::Classes::TStrings* const AItems);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TWorldSeriesEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Series::Map::TMapSeriesEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TWorldSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Series::Map::TMapSeriesEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TWorldSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Worldmap */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_WORLDMAP)
using namespace Fmxtee::Editor::Series::Worldmap;
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
#endif	// Fmxtee_Editor_Series_WorldmapHPP
