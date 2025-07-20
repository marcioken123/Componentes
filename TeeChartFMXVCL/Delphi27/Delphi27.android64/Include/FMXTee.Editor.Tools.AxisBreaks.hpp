// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.AxisBreaks.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Tools_AxisbreaksHPP
#define Fmxtee_Editor_Tools_AxisbreaksHPP

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
#include <FMXTee.Editor.Tools.Axis.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMXTee.Tools.AxisBreaks.hpp>
#include <FMX.Layouts.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Axisbreaks
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAxisBreaksEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAxisBreaksEditor : public Fmxtee::Editor::Tools::Axis::TAxisToolEditor
{
	typedef Fmxtee::Editor::Tools::Axis::TAxisToolEditor inherited;
	
__published:
	Fmx::Stdctrls::TButton* BBrush;
	Fmx::Stdctrls::TPanel* Panel2;
	Fmx::Stdctrls::TPanel* Panel3;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TButton* SBAdd;
	Fmx::Stdctrls::TButton* SBDelete;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Stdctrls::TTrackBar* TrackBar1;
	Fmx::Listbox::TListBox* LBreaks;
	Fmx::Stdctrls::TLabel* LStart;
	Fmx::Edit::TEdit* EStart;
	Fmx::Stdctrls::TLabel* LEnd;
	Fmx::Edit::TEdit* EEnd;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BBrushClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall LBreaksClick(System::TObject* Sender);
	void __fastcall LBreaksChangeCheck(System::TObject* Sender);
	void __fastcall SBAddClick(System::TObject* Sender);
	void __fastcall SBDeleteClick(System::TObject* Sender);
	void __fastcall EStartChange(System::TObject* Sender);
	void __fastcall EEndChange(System::TObject* Sender);
	void __fastcall TrackBar1Change(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Axisbreaks::TAxisBreaksTool* AxisBreaks;
	void __fastcall FillBreaks();
	Fmxtee::Tools::Axisbreaks::TAxisBreak* __fastcall CurrentBreak();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAxisBreaksEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Axis::TAxisToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAxisBreaksEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Axis::TAxisToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAxisBreaksEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Axisbreaks */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_AXISBREAKS)
using namespace Fmxtee::Editor::Tools::Axisbreaks;
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
#endif	// Fmxtee_Editor_Tools_AxisbreaksHPP
