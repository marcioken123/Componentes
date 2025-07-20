// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Functions.Base.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_Functions_BaseHPP
#define Fmxtee_Editor_Functions_BaseHPP

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
#include <FMX.StdCtrls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMXTee.Engine.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Functions
{
namespace Base
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBaseFunctionEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBaseFunctionEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	
protected:
	bool CreatingForm;
	Fmxtee::Engine::TTeeFunction* IFunction;
	virtual void __fastcall ApplyFormChanges();
	void __fastcall EnableApply();
	void __fastcall FillSeries(System::Classes::TStrings* const Items);
	virtual void __fastcall SetFunction();
	
public:
	virtual void __fastcall ActivateFunction();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TBaseFunctionEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TBaseFunctionEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TBaseFunctionEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Base */
}	/* namespace Functions */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_FUNCTIONS_BASE)
using namespace Fmxtee::Editor::Functions::Base;
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
#endif	// Fmxtee_Editor_Functions_BaseHPP
