// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.Link.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Editor_Tools_LinkHPP
#define Fmxtee_Editor_Tools_LinkHPP

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
#include <FMX.ListBox.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Edit.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Memo.hpp>
#include <FMXTee.Tools.Link.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Editor.Tools.Annotation.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Link
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLinkToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLinkToolEditor : public Fmxtee::Editor::Tools::Annotation::TAnnotationToolEdit
{
	typedef Fmxtee::Editor::Tools::Annotation::TAnnotationToolEdit inherited;
	
__published:
	Fmx::Tabcontrol::TTabItem* TabLink;
	Fmx::Stdctrls::TLabel* Label20;
	Fmx::Stdctrls::TLabel* Label18;
	Fmx::Stdctrls::TLabel* Label19;
	Fmx::Edit::TEdit* EText;
	Fmx::Edit::TEdit* EURL;
	Fmx::Edit::TEdit* EHint;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall ETextChange(System::TObject* Sender);
	void __fastcall EURLChange(System::TObject* Sender);
	void __fastcall EHintChange(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Link::TLinkTool* Link;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLinkToolEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Annotation::TAnnotationToolEdit(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLinkToolEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Annotation::TAnnotationToolEdit(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLinkToolEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Link */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_LINK)
using namespace Fmxtee::Editor::Tools::Link;
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
#endif	// Fmxtee_Editor_Tools_LinkHPP
