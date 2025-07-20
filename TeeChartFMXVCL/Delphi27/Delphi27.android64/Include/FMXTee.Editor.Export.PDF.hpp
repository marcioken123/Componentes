// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Export.PDF.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Export_PdfHPP
#define Fmxtee_Editor_Export_PdfHPP

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
#include <System.Rtti.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.ComboEdit.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMXTee.Canvas.PDF.hpp>
#include <FMXTee.RadioGroup.hpp>
#include <FMX.ListBox.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Export
{
namespace Pdf
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPDFOptions;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPDFOptions : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Listbox::TComboBox* CBPageSize;
	Fmxtee::Radiogroup::TRadioGroup* RGOrient;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Listbox::TComboBox* CBPosition;
	Fmx::Stdctrls::TRadioButton* RadioButton1;
	Fmx::Stdctrls::TRadioButton* RadioButton2;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	
private:
	Fmxtee::Canvas::Pdf::TPDFExportFormat* IFormat;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPDFOptions(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPDFOptions(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPDFOptions() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Pdf */
}	/* namespace Export */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_EXPORT_PDF)
using namespace Fmxtee::Editor::Export::Pdf;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_EXPORT)
using namespace Fmxtee::Editor::Export;
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
#endif	// Fmxtee_Editor_Export_PdfHPP
