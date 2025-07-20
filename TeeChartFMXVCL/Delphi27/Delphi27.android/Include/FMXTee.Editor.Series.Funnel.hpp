// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Funnel.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Series_FunnelHPP
#define Fmxtee_Editor_Series_FunnelHPP

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
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMX.Colors.hpp>
#include <FMXTee.Series.Funnel.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Funnel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFunnelSeriesEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TFunnelSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TLabel* LAboveColor;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Stdctrls::TButton* BLines;
	Fmx::Stdctrls::TButton* BPattern;
	Fmx::Stdctrls::TButton* BLineBorder;
	Fmx::Spinbox::TSpinBox* UDDifLimit;
	Fmx::Stdctrls::TLabel* LHeight;
	Fmx::Colors::TComboColorBox* BColorAbove;
	Fmx::Colors::TComboColorBox* BColorWithin;
	Fmx::Colors::TComboColorBox* BColorBelow;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BPatternClick(System::TObject* Sender);
	void __fastcall UDDifLimitChange(System::TObject* Sender);
	void __fastcall BLinesClick(System::TObject* Sender);
	void __fastcall BLineBorderClick(System::TObject* Sender);
	
private:
	Fmxtee::Series::Funnel::TFunnelSeries* Funnel;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFunnelSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFunnelSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFunnelSeriesEditor() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TFunnelSeriesEditor* FunnelSeriesEditor;
}	/* namespace Funnel */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_FUNNEL)
using namespace Fmxtee::Editor::Series::Funnel;
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
#endif	// Fmxtee_Editor_Series_FunnelHPP
