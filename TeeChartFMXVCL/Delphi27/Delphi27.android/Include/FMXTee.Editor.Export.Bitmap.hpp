// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Export.Bitmap.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Export_BitmapHPP
#define Fmxtee_Editor_Export_BitmapHPP

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
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.Dialogs.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Editor.Export.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Layouts.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Export
{
namespace Bitmap
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBitmapExportEditor;
class DELPHICLASS TBitmapExportFormat;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TBitmapExportEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TImageControl* ImageControl1;
	void __fastcall FormActivate(System::TObject* Sender);
	
private:
	Fmx::Graphics::TBitmap* __fastcall PreviewBitmap();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TBitmapExportEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TBitmapExportEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TBitmapExportEditor() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TBitmapExportFormat : public Fmxtee::Editor::Export::TTeeExportFormat
{
	typedef Fmxtee::Editor::Export::TTeeExportFormat inherited;
	
protected:
	System::UnicodeString IFormat;
	__classmethod virtual void __fastcall AddSubFormats(Fmxtee::Procs::TCustomTeePanel* const APanel, Fmx::Listbox::TListBox* const AList, int &FilterIndex);
	Fmx::Graphics::TBitmap* __fastcall Bitmap(TBitmapExportEditor* const AOptions);
	virtual void __fastcall DoCopyToClipboard();
	
public:
	virtual System::UnicodeString __fastcall Description();
	virtual Fmx::Forms::TForm* __fastcall Editor(System::Classes::TComponent* AOwner);
	virtual System::UnicodeString __fastcall FileExtension();
	__classmethod virtual System::UnicodeString __fastcall FileFilter();
	__classmethod virtual void __fastcall SaveToFile(Fmxtee::Procs::TCustomTeePanel* APanel, const System::UnicodeString FileName, Fmx::Forms::TForm* const AOptions, int AWidth, int AHeight)/* overload */;
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream)/* overload */;
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream, Fmx::Forms::TForm* const AOptions)/* overload */;
	__property System::UnicodeString Format = {read=IFormat, write=IFormat};
public:
	/* TTeeExportFormat.Create */ inline __fastcall virtual TBitmapExportFormat() : Fmxtee::Editor::Export::TTeeExportFormat() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TBitmapExportFormat() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SaveToFile(const System::UnicodeString FileName){ Fmxtee::Editor::Export::TTeeExportFormat::SaveToFile(FileName); }
	inline void __fastcall  SaveToFile(const System::UnicodeString FileName, Fmx::Forms::TForm* const AOptions){ Fmxtee::Editor::Export::TTeeExportFormat::SaveToFile(FileName, AOptions); }
	inline void __fastcall  SaveToFile(Fmxtee::Procs::TCustomTeePanel* const APanel, const System::UnicodeString FileName){ Fmxtee::Editor::Export::TTeeExportFormat::SaveToFile(APanel, FileName); }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Bitmap */
}	/* namespace Export */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_EXPORT_BITMAP)
using namespace Fmxtee::Editor::Export::Bitmap;
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
#endif	// Fmxtee_Editor_Export_BitmapHPP
