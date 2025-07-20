// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.SurfaceNearest.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Tools_SurfacenearestHPP
#define Fmxtee_Editor_Tools_SurfacenearestHPP

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
#include <FMXTee.Tools.Surface.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Colors.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Surfacenearest
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSurfaceNearest;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TSurfaceNearest : public Fmxtee::Editor::Tools::Series::TSeriesToolEditor
{
	typedef Fmxtee::Editor::Tools::Series::TSeriesToolEditor inherited;
	
__published:
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Stdctrls::TCheckBox* CBCellDefault;
	Fmx::Colors::TComboColorBox* CBCell;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Colors::TComboColorBox* CBRow;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Colors::TComboColorBox* CBColumn;
	Fmx::Stdctrls::TCheckBox* CBRowDefault;
	Fmx::Stdctrls::TCheckBox* CBColumnDefault;
	Fmx::Stdctrls::TCheckBox* CBCellNone;
	Fmx::Stdctrls::TCheckBox* CBRowNone;
	Fmx::Stdctrls::TCheckBox* CBColumnNone;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBCellDefaultChange(System::TObject* Sender);
	void __fastcall CBRowDefaultChange(System::TObject* Sender);
	void __fastcall CBColumnDefaultChange(System::TObject* Sender);
	void __fastcall CBCellNoneChange(System::TObject* Sender);
	void __fastcall CBRowNoneChange(System::TObject* Sender);
	void __fastcall CBColumnNoneChange(System::TObject* Sender);
	void __fastcall CBCellChange(System::TObject* Sender);
	void __fastcall CBRowChange(System::TObject* Sender);
	void __fastcall CBColumnChange(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Surface::TSurfaceNearestTool* SurfaceNearest;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSurfaceNearest(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSurfaceNearest(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSurfaceNearest() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Surfacenearest */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_SURFACENEAREST)
using namespace Fmxtee::Editor::Tools::Surfacenearest;
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
#endif	// Fmxtee_Editor_Tools_SurfacenearestHPP
