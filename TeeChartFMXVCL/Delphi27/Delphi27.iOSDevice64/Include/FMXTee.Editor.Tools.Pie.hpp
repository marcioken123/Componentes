// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.Pie.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Editor_Tools_PieHPP
#define Fmxtee_Editor_Tools_PieHPP

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
#include <FMXTee.Tools.Pie.hpp>
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
namespace Pie
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPieToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPieToolEditor : public Fmxtee::Editor::Tools::Series::TSeriesToolEditor
{
	typedef Fmxtee::Editor::Tools::Series::TSeriesToolEditor inherited;
	
__published:
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Stdctrls::TRadioButton* RBFocus;
	Fmx::Stdctrls::TRadioButton* RBExplode;
	Fmx::Stdctrls::TButton* BPen;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BPenClick(System::TObject* Sender);
	void __fastcall RBFocusChange(System::TObject* Sender);
	void __fastcall RBExplodeChange(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Pie::TPieTool* Pie;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPieToolEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPieToolEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPieToolEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Pie */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_PIE)
using namespace Fmxtee::Editor::Tools::Pie;
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
#endif	// Fmxtee_Editor_Tools_PieHPP
