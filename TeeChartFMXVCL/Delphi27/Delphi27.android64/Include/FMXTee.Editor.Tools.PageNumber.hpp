// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.PageNumber.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Tools_PagenumberHPP
#define Fmxtee_Editor_Tools_PagenumberHPP

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
#include <FMXTee.Tools.PageNumber.hpp>
#include <FMX.SpinBox.hpp>
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
namespace Pagenumber
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPageNumToolEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPageNumToolEdit : public Fmxtee::Editor::Tools::Annotation::TAnnotationToolEdit
{
	typedef Fmxtee::Editor::Tools::Annotation::TAnnotationToolEdit inherited;
	
__published:
	Fmx::Tabcontrol::TTabItem* TabPaging;
	Fmx::Stdctrls::TCheckBox* CBButtons;
	Fmx::Stdctrls::TLabel* Label20;
	Fmx::Spinbox::TSpinBox* UDButtonWidth;
	Fmx::Stdctrls::TButton* BEnabled;
	Fmx::Stdctrls::TButton* BDisabled;
	Fmx::Stdctrls::TButton* BBorder;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBButtonsChange(System::TObject* Sender);
	void __fastcall BEnabledClick(System::TObject* Sender);
	void __fastcall BDisabledClick(System::TObject* Sender);
	void __fastcall BBorderClick(System::TObject* Sender);
	void __fastcall UDButtonWidthChange(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Pagenumber::TPageNumTool* PageNum;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPageNumToolEdit(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Annotation::TAnnotationToolEdit(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPageNumToolEdit(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Annotation::TAnnotationToolEdit(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPageNumToolEdit() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Pagenumber */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_PAGENUMBER)
using namespace Fmxtee::Editor::Tools::Pagenumber;
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
#endif	// Fmxtee_Editor_Tools_PagenumberHPP
