// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.AxisScrollBar.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Tools_AxisscrollbarHPP
#define Fmxtee_Editor_Tools_AxisscrollbarHPP

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
#include <System.Rtti.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMXTee.Editor.Tools.Axis.hpp>
#include <FMX.ListBox.hpp>
#include <FMXTee.Tools.hpp>
#include <FMXTee.Engine.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Editor.Tools.LegendScrollBar.hpp>
#include <FMX.Edit.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Axisscrollbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAxisScrollBarEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TAxisScrollBarEditor : public Fmxtee::Editor::Tools::Axis::TAxisToolEditor
{
	typedef Fmxtee::Editor::Tools::Axis::TAxisToolEditor inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabItem1;
	Fmx::Tabcontrol::TTabItem* TabItem2;
	Fmx::Stdctrls::TCheckBox* CBAllowResize;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Spinbox::TSpinBox* UDMargin;
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall CBAllowResizeChange(System::TObject* Sender);
	void __fastcall UDMarginChangeTracking(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	
private:
	Fmxtee::Editor::Tools::Legendscrollbar::TScrollbarEditor* IEditor;
	
protected:
	virtual Fmxtee::Engine::TChartAxis* __fastcall GetAxis();
	virtual void __fastcall SetAxis(Fmxtee::Engine::TChartAxis* const AAxis);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAxisScrollBarEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Axis::TAxisToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAxisScrollBarEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Axis::TAxisToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAxisScrollBarEditor() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Axisscrollbar */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_AXISSCROLLBAR)
using namespace Fmxtee::Editor::Tools::Axisscrollbar;
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
#endif	// Fmxtee_Editor_Tools_AxisscrollbarHPP
