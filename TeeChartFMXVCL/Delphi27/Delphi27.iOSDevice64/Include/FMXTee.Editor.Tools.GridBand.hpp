// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.GridBand.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Editor_Tools_GridbandHPP
#define Fmxtee_Editor_Tools_GridbandHPP

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
#include <FMXTee.Editor.Tools.Axis.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMXTee.Tools.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Colors.hpp>
#include <FMX.Layouts.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Gridband
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGridBandToolEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TGridBandToolEdit : public Fmxtee::Editor::Tools::Axis::TAxisToolEditor
{
	typedef Fmxtee::Editor::Tools::Axis::TAxisToolEditor inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabItem1;
	Fmx::Tabcontrol::TTabItem* TabItem2;
	Fmx::Layouts::TLayout* LayoutBand;
	Fmx::Stdctrls::TButton* BGradient;
	Fmx::Colors::TComboColorBox* CBColor;
	Fmx::Stdctrls::TButton* BBand;
	Fmx::Stdctrls::TLabel* Label8;
	Fmx::Spinbox::TSpinBox* UDTrans;
	Fmx::Stdctrls::TLabel* Label2;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BBandClick(System::TObject* Sender);
	void __fastcall CBColorChange(System::TObject* Sender);
	void __fastcall BGradientClick(System::TObject* Sender);
	void __fastcall UDTransChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	
private:
	Fmxtee::Tools::TGridBandTool* GridBand;
	Fmxtee::Tools::TGridBandBrush* __fastcall Band();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TGridBandToolEdit(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Axis::TAxisToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TGridBandToolEdit(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Axis::TAxisToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TGridBandToolEdit() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Gridband */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_GRIDBAND)
using namespace Fmxtee::Editor::Tools::Gridband;
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
#endif	// Fmxtee_Editor_Tools_GridbandHPP
