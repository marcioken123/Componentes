// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.PointFigure.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Series_PointfigureHPP
#define Fmxtee_Editor_Series_PointfigureHPP

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
#include <FMX.StdCtrls.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Series.OHLC.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Series.hpp>
#include <FMX.Edit.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Editor.Series.Pointer.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Pointfigure
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPointFigureSeriesEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TPointFigureSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TLabel* LHeight;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Edit::TEdit* EBoxSize;
	Fmx::Edit::TEdit* EReversal;
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabFormat;
	Fmx::Tabcontrol::TTabItem* TabUp;
	Fmx::Tabcontrol::TTabItem* TabDown;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall EBoxSizeChange(System::TObject* Sender);
	void __fastcall EReversalChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Fmx::Forms::TCustomForm* UpForm;
	Fmx::Forms::TCustomForm* DownForm;
	Fmxtee::Series::Ohlc::TPointFigureSeries* PointFigure;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPointFigureSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPointFigureSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPointFigureSeriesEditor() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TPointFigureSeriesEditor* PointFigureSeriesEditor;
}	/* namespace Pointfigure */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_POINTFIGURE)
using namespace Fmxtee::Editor::Series::Pointfigure;
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
#endif	// Fmxtee_Editor_Series_PointfigureHPP
