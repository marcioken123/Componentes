// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.SeriesStats.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_Tools_SeriesstatsHPP
#define Fmxtee_Editor_Tools_SeriesstatsHPP

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
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMXTee.Tools.SeriesStats.hpp>
#include <FMXTee.Engine.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Memo.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Seriesstats
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSeriesStatsEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSeriesStatsEditor : public Fmxtee::Editor::Tools::Series::TSeriesToolEditor
{
	typedef Fmxtee::Editor::Tools::Series::TSeriesToolEditor inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabStats;
	Fmx::Tabcontrol::TTabItem* TabInfo;
	Fmx::Stdctrls::TCheckBox* CheckBox1;
	Fmx::Stdctrls::TButton* Button1;
	Fmx::Stdctrls::TCheckBox* CheckBox2;
	Fmx::Stdctrls::TButton* Button2;
	Fmx::Stdctrls::TCheckBox* CheckBox3;
	Fmx::Stdctrls::TButton* Button3;
	Fmx::Stdctrls::TCheckBox* CheckBox4;
	Fmx::Stdctrls::TButton* Button4;
	Fmx::Stdctrls::TCheckBox* CheckBox5;
	Fmx::Stdctrls::TButton* Button5;
	Fmx::Stdctrls::TCheckBox* CheckBox6;
	Fmx::Stdctrls::TButton* Button6;
	Fmx::Memo::TMemo* Memo1;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	HIDESBASE void __fastcall CBSeriesChange(System::TObject* Sender);
	void __fastcall CheckBox1Change(System::TObject* Sender);
	void __fastcall ButtonClick(System::TObject* Sender);
	void __fastcall CheckBox2Change(System::TObject* Sender);
	void __fastcall CheckBox3Change(System::TObject* Sender);
	void __fastcall CheckBox4Change(System::TObject* Sender);
	void __fastcall CheckBox5Change(System::TObject* Sender);
	void __fastcall CheckBox6Change(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Seriesstats::TSeriesStatsTool* SeriesStats;
	void __fastcall EnableControls();
	void __fastcall RefreshInfo();
	void __fastcall CheckFunction(Fmx::Stdctrls::TCheckBox* const ABox, const Fmxtee::Engine::TTeeFunctionClass AFunctionClass);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSeriesStatsEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSeriesStatsEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSeriesStatsEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Seriesstats */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_SERIESSTATS)
using namespace Fmxtee::Editor::Tools::Seriesstats;
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
#endif	// Fmxtee_Editor_Tools_SeriesstatsHPP
