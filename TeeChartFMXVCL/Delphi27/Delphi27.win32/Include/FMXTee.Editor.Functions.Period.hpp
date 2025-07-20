// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Functions.Period.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_Functions_PeriodHPP
#define Fmxtee_Editor_Functions_PeriodHPP

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
#include <FMX.Dialogs.hpp>
#include <FMXTee.Editor.Functions.Base.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Functions
{
namespace Period
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeFunctionEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTeeFunctionEditor : public Fmxtee::Editor::Functions::Base::TBaseFunctionEditor
{
	typedef Fmxtee::Editor::Functions::Base::TBaseFunctionEditor inherited;
	
__published:
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Listbox::TComboBox* CBStyle;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Listbox::TListBoxItem* ListBoxItem3;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Edit::TEdit* ENum;
	Fmx::Stdctrls::TButton* BChange;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Listbox::TComboBox* CBAlign;
	Fmx::Listbox::TListBoxItem* ListBoxItem4;
	Fmx::Listbox::TListBoxItem* ListBoxItem5;
	Fmx::Listbox::TListBoxItem* ListBoxItem6;
	void __fastcall BChangeClick(System::TObject* Sender);
	void __fastcall CBAlignChange(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	void __fastcall ENumTyping(System::TObject* Sender);
	
protected:
	virtual void __fastcall ApplyFormChanges();
	virtual void __fastcall SetFunction();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTeeFunctionEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Functions::Base::TBaseFunctionEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTeeFunctionEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Functions::Base::TBaseFunctionEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTeeFunctionEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Period */
}	/* namespace Functions */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_FUNCTIONS_PERIOD)
using namespace Fmxtee::Editor::Functions::Period;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_FUNCTIONS)
using namespace Fmxtee::Editor::Functions;
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
#endif	// Fmxtee_Editor_Functions_PeriodHPP
