// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.IsoSurface.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Series_IsosurfaceHPP
#define Fmxtee_Editor_Series_IsosurfaceHPP

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
#include <FMXTee.Editor.Series.Surface.hpp>
#include <FMX.Edit.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Series.Surface.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMX.StdCtrls.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Isosurface
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TIsoSurfaceSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TIsoSurfaceSeriesEditor : public Fmxtee::Editor::Series::Surface::TSurfaceSeriesEditor
{
	typedef Fmxtee::Editor::Series::Surface::TSurfaceSeriesEditor inherited;
	
__published:
	Fmx::Tabcontrol::TTabItem* TabBands;
	Fmx::Stdctrls::TGroupBox* GroupBox2;
	Fmx::Edit::TEdit* EYPosition;
	Fmx::Stdctrls::TCheckBox* CBUseY;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBUseYChange(System::TObject* Sender);
	void __fastcall EYPositionChange(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	
private:
	bool IModifying;
	Fmxtee::Editor::Stroke::TStrokeEditor* FBandPen;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TIsoSurfaceSeriesEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Series::Surface::TSurfaceSeriesEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TIsoSurfaceSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Series::Surface::TSurfaceSeriesEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TIsoSurfaceSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TIsoSurfaceSeriesEditor* IsoSurfaceSeriesEditor;
}	/* namespace Isosurface */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_ISOSURFACE)
using namespace Fmxtee::Editor::Series::Isosurface;
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
#endif	// Fmxtee_Editor_Series_IsosurfaceHPP
