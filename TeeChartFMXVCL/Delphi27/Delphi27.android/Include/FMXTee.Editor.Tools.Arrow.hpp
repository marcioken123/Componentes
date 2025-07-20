// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.Arrow.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_Tools_ArrowHPP
#define Fmxtee_Editor_Tools_ArrowHPP

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
#include <FMXTee.Tools.Arrow.hpp>
#include <FMX.Edit.hpp>
#include <FMX.TabControl.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Arrow
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TArrowToolEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TArrowToolEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabPosition;
	Fmx::Tabcontrol::TTabItem* TabFormat;
	Fmx::Stdctrls::TCheckBox* CBDraw2D;
	Fmx::Stdctrls::TTrackBar* SBZ;
	Fmx::Stdctrls::TLabel* LabelZ;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Stdctrls::TButton* BPen;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Spinbox::TSpinBox* UDFromX;
	Fmx::Spinbox::TSpinBox* UDFromY;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Stdctrls::TGroupBox* GroupBox2;
	Fmx::Spinbox::TSpinBox* UDToX;
	Fmx::Spinbox::TSpinBox* UDToY;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Stdctrls::TLabel* Label7;
	Fmx::Stdctrls::TArcDial* ADAngle;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Stdctrls::TButton* BBrush;
	Fmx::Stdctrls::TCheckBox* CBFilled;
	Fmx::Stdctrls::TTrackBar* SBWidth;
	Fmx::Stdctrls::TLabel* LabelWidth;
	Fmx::Stdctrls::TLabel* Label8;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TTrackBar* SBHeight;
	Fmx::Stdctrls::TLabel* LabelHeight;
	Fmx::Stdctrls::TLabel* Label9;
	Fmx::Stdctrls::TTrackBar* SBPercent;
	Fmx::Stdctrls::TLabel* LabelPercent;
	Fmx::Stdctrls::TLabel* Label10;
	Fmx::Stdctrls::TTrackBar* SBTransparency;
	Fmx::Stdctrls::TLabel* LabelTrans;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBDraw2DChange(System::TObject* Sender);
	void __fastcall SBZChange(System::TObject* Sender);
	void __fastcall BPenClick(System::TObject* Sender);
	void __fastcall UDFromXChange(System::TObject* Sender);
	void __fastcall UDFromYChange(System::TObject* Sender);
	void __fastcall UDToXChange(System::TObject* Sender);
	void __fastcall UDToYChange(System::TObject* Sender);
	void __fastcall ADAngleChange(System::TObject* Sender);
	void __fastcall BBrushClick(System::TObject* Sender);
	void __fastcall CBFilledChange(System::TObject* Sender);
	void __fastcall SBWidthChange(System::TObject* Sender);
	void __fastcall SBHeightChange(System::TObject* Sender);
	void __fastcall SBPercentChange(System::TObject* Sender);
	void __fastcall SBTransparencyChange(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Arrow::TArrowTool* Arrow;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TArrowToolEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TArrowToolEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TArrowToolEditor() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Arrow */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_ARROW)
using namespace Fmxtee::Editor::Tools::Arrow;
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
#endif	// Fmxtee_Editor_Tools_ArrowHPP
