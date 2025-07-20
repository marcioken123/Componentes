// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.AxisScroll.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Editor_Tools_AxisscrollHPP
#define Fmxtee_Editor_Tools_AxisscrollHPP

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
#include <FMXTee.Procs.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMXTee.Tools.hpp>
#include <FMX.Colors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Axisscroll
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAxisScrollEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAxisScrollEditor : public Fmxtee::Editor::Tools::Axis::TAxisToolEditor
{
	typedef Fmxtee::Editor::Tools::Axis::TAxisToolEditor inherited;
	
__published:
	Fmx::Stdctrls::TCheckBox* CBInverted;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBInvertedChange(System::TObject* Sender);
	
private:
	Fmxtee::Tools::TAxisScrollTool* AxisScroll;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAxisScrollEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Axis::TAxisToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAxisScrollEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Axis::TAxisToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAxisScrollEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Axisscroll */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_AXISSCROLL)
using namespace Fmxtee::Editor::Tools::Axisscroll;
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
#endif	// Fmxtee_Editor_Tools_AxisscrollHPP
