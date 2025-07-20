// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Languages.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_LanguagesHPP
#define Fmxtee_Editor_LanguagesHPP

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
#include <FMX.StdCtrls.hpp>
#include <FMX.Controls.Presentation.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.ListBox.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Languages
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAskLanguage;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAskLanguage : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Listbox::TListBox* LBLangs;
	Fmx::Stdctrls::TButton* OkBtn;
	Fmx::Stdctrls::TButton* Button2;
	void __fastcall LBLangsDblClick(System::TObject* Sender);
	void __fastcall OkBtnClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
public:
	__classmethod void __fastcall Choose(System::Classes::TComponent* const AOwner);
	__classmethod int __fastcall GetDefaultLanguage();
	__classmethod void __fastcall SetDefaultLanguage(int Value);
	int __fastcall SelectedLanguage();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAskLanguage(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAskLanguage(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAskLanguage() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Languages */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_LANGUAGES)
using namespace Fmxtee::Editor::Languages;
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
#endif	// Fmxtee_Editor_LanguagesHPP
