// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.TransposeSeries.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Tools_TransposeseriesHPP
#define Fmxtee_Editor_Tools_TransposeseriesHPP

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
#include <FMXTee.Tools.TransposeSeries.hpp>
#include <FMX.Edit.hpp>
#include <FMX.TabControl.hpp>
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
namespace Transposeseries
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTransposeSeriesToolEdit;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TTransposeSeriesToolEdit : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TButton* BTranspose;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BTransposeClick(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Transposeseries::TTransposeSeriesTool* TransposeSeries;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTransposeSeriesToolEdit(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTransposeSeriesToolEdit(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTransposeSeriesToolEdit() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Transposeseries */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_TRANSPOSESERIES)
using namespace Fmxtee::Editor::Tools::Transposeseries;
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
#endif	// Fmxtee_Editor_Tools_TransposeseriesHPP
