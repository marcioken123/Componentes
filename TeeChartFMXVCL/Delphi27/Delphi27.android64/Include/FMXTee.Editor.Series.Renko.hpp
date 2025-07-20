// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Renko.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Series_RenkoHPP
#define Fmxtee_Editor_Series_RenkoHPP

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
#include <FMX.Colors.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMXTee.Editor.Brush.hpp>
#include <FMXTee.Series.Renko.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Renko
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TRenkoSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TRenkoSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Colors::TComboColorBox* CBColorUp;
	Fmx::Stdctrls::TCheckBox* CBDraw3D;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Stdctrls::TTrackBar* TBBoxSize;
	Fmx::Stdctrls::TLabel* LSize;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TTrackBar* TBTransp;
	Fmx::Stdctrls::TLabel* LTransp;
	Fmx::Tabcontrol::TTabItem* TabBorder;
	Fmx::Tabcontrol::TTabItem* TabPattern;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Colors::TComboColorBox* CBColorDown;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBDraw3DChange(System::TObject* Sender);
	void __fastcall TBBoxSizeChange(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	
private:
	Fmxtee::Editor::Stroke::TStrokeEditor* FBorder;
	Fmxtee::Editor::Brush::TBrushEditor* FBrush;
	Fmxtee::Series::Renko::TRenkoSeries* Renko;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TRenkoSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRenkoSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRenkoSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TRenkoSeriesEditor* RenkoSeriesEditor;
}	/* namespace Renko */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_RENKO)
using namespace Fmxtee::Editor::Series::Renko;
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
#endif	// Fmxtee_Editor_Series_RenkoHPP
