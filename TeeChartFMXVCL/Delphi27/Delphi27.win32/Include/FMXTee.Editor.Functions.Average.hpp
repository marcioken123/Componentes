// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Functions.Average.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_Functions_AverageHPP
#define Fmxtee_Editor_Functions_AverageHPP

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
#include <FMX.StdCtrls.hpp>
#include <FMXTee.Editor.Functions.Period.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMXTee.Editor.Functions.Base.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Functions
{
namespace Average
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAverageFuncEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAverageFuncEditor : public Fmxtee::Editor::Functions::Period::TTeeFunctionEditor
{
	typedef Fmxtee::Editor::Functions::Period::TTeeFunctionEditor inherited;
	
__published:
	Fmx::Stdctrls::TCheckBox* CBNulls;
	void __fastcall CBNullsChange(System::TObject* Sender);
	
protected:
	virtual void __fastcall ApplyFormChanges();
	virtual void __fastcall SetFunction();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAverageFuncEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Functions::Period::TTeeFunctionEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAverageFuncEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Functions::Period::TTeeFunctionEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAverageFuncEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Average */
}	/* namespace Functions */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_FUNCTIONS_AVERAGE)
using namespace Fmxtee::Editor::Functions::Average;
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
#endif	// Fmxtee_Editor_Functions_AverageHPP
