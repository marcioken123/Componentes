// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.Fibonacci.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Tools_FibonacciHPP
#define Fmxtee_Editor_Tools_FibonacciHPP

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
#include <FMXTee.Editor.Tools.Series.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMXTee.Tools.Fibonacci.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Colors.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Fibonacci
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFibonacciEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TFibonacciEditor : public Fmxtee::Editor::Tools::Series::TSeriesToolEditor
{
	typedef Fmxtee::Editor::Tools::Series::TSeriesToolEditor inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabTrendline;
	Fmx::Tabcontrol::TTabItem* TabLevels;
	Fmx::Stdctrls::TGroupBox* GroupBox2;
	Fmx::Edit::TEdit* EXStart;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Stdctrls::TLabel* Label7;
	Fmx::Edit::TEdit* EYStart;
	Fmx::Stdctrls::TButton* BRemoveLevel;
	Fmx::Stdctrls::TButton* BAdd;
	Fmx::Listbox::TComboBox* CBStyle;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Listbox::TListBoxItem* ListBoxItem3;
	Fmx::Tabcontrol::TTabItem* TabLabels;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Edit::TEdit* EXEnd;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TLabel* Label8;
	Fmx::Edit::TEdit* EYEnd;
	Fmx::Stdctrls::TButton* BTrendPen;
	Fmx::Stdctrls::TButton* BReset;
	Fmx::Stdctrls::TGroupBox* GBLevels;
	Fmx::Stdctrls::TButton* BPen;
	Fmx::Spinbox::TSpinBox* UDLevel;
	Fmx::Edit::TEdit* ELevelValue;
	Fmx::Stdctrls::TCheckBox* CBLabels;
	Fmx::Stdctrls::TButton* BFont;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Spinbox::TSpinBox* UDAngle;
	HIDESBASE void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall UDLevelChange(System::TObject* Sender);
	void __fastcall EXStartChange(System::TObject* Sender);
	void __fastcall EYStartChange(System::TObject* Sender);
	void __fastcall BTrendPenClick(System::TObject* Sender);
	void __fastcall CBLabelsChange(System::TObject* Sender);
	void __fastcall EXEndChange(System::TObject* Sender);
	void __fastcall EYEndChange(System::TObject* Sender);
	void __fastcall BAddClick(System::TObject* Sender);
	void __fastcall BPenClick(System::TObject* Sender);
	void __fastcall BRemoveLevelClick(System::TObject* Sender);
	void __fastcall BResetClick(System::TObject* Sender);
	void __fastcall UDAngleChange(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	void __fastcall BFontClick(System::TObject* Sender);
	void __fastcall ELevelValueChange(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Fibonacci::TFibonacciTool* Fibonacci;
	void __fastcall SetLevel(int Index);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFibonacciEditor(System::Classes::TComponent* AOwner) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFibonacciEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmxtee::Editor::Tools::Series::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFibonacciEditor() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Fibonacci */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_FIBONACCI)
using namespace Fmxtee::Editor::Tools::Fibonacci;
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
#endif	// Fmxtee_Editor_Tools_FibonacciHPP
