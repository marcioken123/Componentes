// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Kagi.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Editor_Series_KagiHPP
#define Fmxtee_Editor_Series_KagiHPP

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
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMXTee.Series.Kagi.hpp>
#include <FMXTee.Editor.Series.Pointer.hpp>
#include <FMX.TabControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Kagi
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TKagiSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TKagiSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabUp;
	Fmx::Tabcontrol::TTabItem* TabDown;
	Fmx::Tabcontrol::TTabItem* TabBuy;
	Fmx::Tabcontrol::TTabItem* TabSell;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	
private:
	Fmxtee::Series::Kagi::TKagiSeries* Kagi;
	Fmxtee::Editor::Stroke::TStrokeEditor* FUpSwing;
	Fmxtee::Editor::Stroke::TStrokeEditor* FDownSwing;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TKagiSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TKagiSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TKagiSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TKagiSeriesEditor* KagiSeriesEditor;
}	/* namespace Kagi */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_KAGI)
using namespace Fmxtee::Editor::Series::Kagi;
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
#endif	// Fmxtee_Editor_Series_KagiHPP
