// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.ColorBand.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_Tools_ColorbandHPP
#define Fmxtee_Editor_Tools_ColorbandHPP

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
#include <FMXTee.Procs.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMXTee.Tools.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Colors.hpp>
#include <FMXTee.Editor.Stroke.hpp>
#include <FMXTee.Editor.Brush.hpp>
#include <FMXTee.Editor.Picture.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Colorband
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TColorBandToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TColorBandToolEditor : public Fmxtee::Editor::Tools::Axis::TAxisToolEditor
{
	typedef Fmxtee::Editor::Tools::Axis::TAxisToolEditor inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabValues;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Stdctrls::TButton* BEnd;
	Fmx::Stdctrls::TCheckBox* CBEnd;
	Fmx::Stdctrls::TCheckBox* CBEndActive;
	Fmx::Edit::TEdit* EEnd;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Stdctrls::TLabel* Label8;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Stdctrls::TCheckBox* CBStartActive;
	Fmx::Edit::TEdit* EStart;
	Fmx::Stdctrls::TCheckBox* CBStart;
	Fmx::Stdctrls::TButton* BStart;
	Fmx::Stdctrls::TCheckBox* CBDrawBehind;
	Fmx::Listbox::TComboBox* CBCursor;
	Fmx::Stdctrls::TCheckBox* CBBeforeAxes;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Colors::TComboColorBox* CBColor;
	Fmx::Stdctrls::TCheckBox* CBAllowDrag;
	Fmx::Stdctrls::TTrackBar* TBTransp;
	Fmx::Stdctrls::TLabel* LTransp;
	Fmx::Tabcontrol::TTabItem* TabPattern;
	Fmx::Tabcontrol::TTabItem* TabBorder;
	Fmx::Tabcontrol::TTabItem* TabPicture;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBCursorChange(System::TObject* Sender);
	void __fastcall BStartClick(System::TObject* Sender);
	void __fastcall BEndClick(System::TObject* Sender);
	void __fastcall CBColorChange(System::TObject* Sender);
	void __fastcall EStartChange(System::TObject* Sender);
	void __fastcall EEndChange(System::TObject* Sender);
	void __fastcall CBStartActiveChange(System::TObject* Sender);
	void __fastcall CBEndActiveChange(System::TObject* Sender);
	void __fastcall CBStartChange(System::TObject* Sender);
	void __fastcall CBEndChange(System::TObject* Sender);
	void __fastcall CBDrawBehindChange(System::TObject* Sender);
	void __fastcall CBBeforeAxesChange(System::TObject* Sender);
	void __fastcall CBAllowDragChange(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	
private:
	Fmxtee::Tools::TColorBandTool* ColorBand;
	Fmxtee::Editor::Brush::TBrushEditor* IPattern;
	Fmxtee::Editor::Stroke::TStrokeEditor* IBorder;
	Fmxtee::Editor::Picture::TBackImageEditor* IPicture;
	void __fastcall SetLTransp();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TColorBandToolEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Axis::TAxisToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TColorBandToolEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Axis::TAxisToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TColorBandToolEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Colorband */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_COLORBAND)
using namespace Fmxtee::Editor::Tools::Colorband;
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
#endif	// Fmxtee_Editor_Tools_ColorbandHPP
