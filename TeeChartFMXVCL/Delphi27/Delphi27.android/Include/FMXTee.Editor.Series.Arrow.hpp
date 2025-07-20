// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Arrow.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Series_ArrowHPP
#define Fmxtee_Editor_Series_ArrowHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Dialogs.hpp>
#include <FMXTee.Series.Arrow.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Arrow
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TArrowSeriesEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TArrowSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Stdctrls::TLabel* LPercent;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Stdctrls::TButton* BPen;
	Fmx::Stdctrls::TButton* BBrush;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Stdctrls::TCheckBox* CBColorEach;
	Fmx::Stdctrls::TButton* BArrowColor;
	Fmx::Spinbox::TSpinBox* UDArrowWidth;
	Fmx::Spinbox::TSpinBox* UDArrowHeight;
	Fmx::Stdctrls::TScrollBar* SBPercent;
	Fmx::Stdctrls::TButton* BGradient;
	Fmx::Spinbox::TSpinBox* UDTransp;
	void __fastcall BBrushClick(System::TObject* Sender);
	void __fastcall SBPercentChange(System::TObject* Sender);
	void __fastcall CBColorEachChange(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BGradientClick(System::TObject* Sender);
	void __fastcall UDTranspChange(System::TObject* Sender);
	void __fastcall BPenClick(System::TObject* Sender);
	void __fastcall BArrowColorClick(System::TObject* Sender);
	void __fastcall UDArrowWidthChange(System::TObject* Sender);
	void __fastcall UDArrowHeightChange(System::TObject* Sender);
	
private:
	Fmxtee::Series::Arrow::TArrowSeries* Arrow;
	void __fastcall RefreshArrow(Fmxtee::Series::Arrow::TArrowSeries* const AArrow);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TArrowSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TArrowSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TArrowSeriesEditor() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Arrow */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_ARROW)
using namespace Fmxtee::Editor::Series::Arrow;
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
#endif	// Fmxtee_Editor_Series_ArrowHPP
