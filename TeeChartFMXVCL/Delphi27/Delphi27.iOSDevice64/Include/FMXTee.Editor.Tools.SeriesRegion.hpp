// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.SeriesRegion.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Editor_Tools_SeriesregionHPP
#define Fmxtee_Editor_Tools_SeriesregionHPP

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
#include <FMXTee.Procs.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMXTee.Tools.SeriesRegion.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Colors.hpp>
#include <FMX.SpinBox.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Seriesregion
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSeriesRegionEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSeriesRegionEditor : public Fmxtee::Editor::Tools::Series::TSeriesToolEditor
{
	typedef Fmxtee::Editor::Tools::Series::TSeriesToolEditor inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabFormat;
	Fmx::Stdctrls::TButton* BPen;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Stdctrls::TCheckBox* CBUseOrigin;
	Fmx::Edit::TEdit* EOrigin;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Spinbox::TSpinBox* UDTransp;
	Fmx::Stdctrls::TGroupBox* GroupBox2;
	Fmx::Stdctrls::TCheckBox* CBAutoBounds;
	Fmx::Edit::TEdit* ELower;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Stdctrls::TLabel* Label7;
	Fmx::Edit::TEdit* EUpper;
	Fmx::Stdctrls::TCheckBox* CBBehind;
	Fmx::Colors::TComboColorBox* CBColor;
	Fmx::Stdctrls::TButton* BBrush;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Stdctrls::TButton* BGradient;
	Fmx::Tabcontrol::TTabItem* TabOrigin;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BPenClick(System::TObject* Sender);
	void __fastcall UDTranspChange(System::TObject* Sender);
	void __fastcall EOriginChange(System::TObject* Sender);
	void __fastcall CBUseOriginChange(System::TObject* Sender);
	void __fastcall CBAutoBoundsChange(System::TObject* Sender);
	void __fastcall ELowerChange(System::TObject* Sender);
	void __fastcall EUpperChange(System::TObject* Sender);
	void __fastcall CBBehindChange(System::TObject* Sender);
	void __fastcall BBrushClick(System::TObject* Sender);
	void __fastcall CBColorChange(System::TObject* Sender);
	void __fastcall BGradientClick(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Seriesregion::TSeriesRegionTool* SeriesRegion;
	Fmxtee::Editor::Stroke::TStrokeEditor* FOrigin;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSeriesRegionEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSeriesRegionEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSeriesRegionEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Seriesregion */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_SERIESREGION)
using namespace Fmxtee::Editor::Tools::Seriesregion;
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
#endif	// Fmxtee_Editor_Tools_SeriesregionHPP
