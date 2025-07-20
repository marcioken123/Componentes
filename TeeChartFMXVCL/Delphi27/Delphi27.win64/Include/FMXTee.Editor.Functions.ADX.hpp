// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Functions.ADX.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_Functions_AdxHPP
#define Fmxtee_Editor_Functions_AdxHPP

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
#include <FMXTee.Editor.Functions.Base.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.Edit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Functions
{
namespace Adx
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TADXFuncEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TADXFuncEditor : public Fmxtee::Editor::Functions::Base::TBaseFunctionEditor
{
	typedef Fmxtee::Editor::Functions::Base::TBaseFunctionEditor inherited;
	
__published:
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Spinbox::TSpinBox* SBPeriod;
	Fmx::Stdctrls::TButton* Button1;
	Fmx::Stdctrls::TButton* Button2;
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall SBPeriodChange(System::TObject* Sender);
	
protected:
	virtual void __fastcall ApplyFormChanges();
	virtual void __fastcall SetFunction();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TADXFuncEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Functions::Base::TBaseFunctionEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TADXFuncEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Functions::Base::TBaseFunctionEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TADXFuncEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Adx */
}	/* namespace Functions */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_FUNCTIONS_ADX)
using namespace Fmxtee::Editor::Functions::Adx;
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
#endif	// Fmxtee_Editor_Functions_AdxHPP
