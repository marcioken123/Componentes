// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.SeriesBand.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Tools_SeriesbandHPP
#define Fmxtee_Editor_Tools_SeriesbandHPP

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
#include <System.UIConsts.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMXTee.Editor.Tools.Series.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.ListBox.hpp>
#include <FMXTee.Tools.SeriesBand.hpp>
#include <FMX.Edit.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.RadioGroup.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Seriesband
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSeriesBandToolEdit;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TSeriesBandToolEdit : public Fmxtee::Editor::Tools::Series::TSeriesToolEditor
{
	typedef Fmxtee::Editor::Tools::Series::TSeriesToolEditor inherited;
	
__published:
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Spinbox::TSpinBox* UDTransparency;
	Fmx::Stdctrls::TCheckBox* CBDrawBehindSeries;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Listbox::TComboBox* CBSeries2;
	Fmx::Stdctrls::TButton* BPen;
	Fmx::Stdctrls::TButton* BBrush;
	Fmx::Stdctrls::TButton* BGradient;
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabItem1;
	Fmx::Tabcontrol::TTabItem* TabItem2;
	Fmxtee::Radiogroup::TRadioGroup* RGCondition;
	Fmx::Stdctrls::TRadioButton* RadioButton1;
	Fmx::Stdctrls::TRadioButton* RadioButton2;
	Fmx::Stdctrls::TRadioButton* RadioButton3;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall UDTransparencyChange(System::TObject* Sender);
	void __fastcall CBDrawBehindSeriesChange(System::TObject* Sender);
	void __fastcall CBSeries2Change(System::TObject* Sender);
	void __fastcall BPenClick(System::TObject* Sender);
	void __fastcall BBrushClick(System::TObject* Sender);
	void __fastcall BGradientClick(System::TObject* Sender);
	void __fastcall RGConditionChange(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Seriesband::TSeriesBandTool* SeriesBand;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSeriesBandToolEdit(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSeriesBandToolEdit(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSeriesBandToolEdit() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Seriesband */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_SERIESBAND)
using namespace Fmxtee::Editor::Tools::Seriesband;
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
#endif	// Fmxtee_Editor_Tools_SeriesbandHPP
