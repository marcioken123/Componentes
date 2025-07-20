// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.DataTable.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_Tools_DatatableHPP
#define Fmxtee_Editor_Tools_DatatableHPP

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
#include <FMX.ListBox.hpp>
#include <FMXTee.Tools.hpp>
#include <FMX.Edit.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Memo.hpp>
#include <FMXTee.Tools.DataTable.hpp>
#include <FMXTee.Editor.Margins.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Datatable
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDataTableEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDataTableEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabFormat;
	Fmx::Tabcontrol::TTabItem* TabLegend;
	Fmx::Stdctrls::TCheckBox* CBInverted;
	Fmx::Stdctrls::TCheckBox* CBClip;
	Fmx::Tabcontrol::TTabItem* TabText;
	Fmx::Stdctrls::TButton* BRowsPen;
	Fmx::Stdctrls::TButton* BColumnsPen;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Stdctrls::TCheckBox* CBAutoPos;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Spinbox::TSpinBox* UDLeft;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Spinbox::TSpinBox* UDTop;
	Fmx::Tabcontrol::TTabControl* TabControl2;
	Fmx::Tabcontrol::TTabItem* TabLegendFormat;
	Fmx::Tabcontrol::TTabItem* TabLegendSymbol;
	Fmx::Tabcontrol::TTabItem* TabLegendText;
	Fmx::Stdctrls::TCheckBox* CBLegVisible;
	Fmx::Stdctrls::TCheckBox* CBFontColor;
	Fmx::Stdctrls::TCheckBox* CBOtherSide;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBInvertedChange(System::TObject* Sender);
	void __fastcall UDLeftChange(System::TObject* Sender);
	void __fastcall BRowsPenClick(System::TObject* Sender);
	void __fastcall CBClipChange(System::TObject* Sender);
	void __fastcall CBAutoPosChange(System::TObject* Sender);
	void __fastcall UDTopChange(System::TObject* Sender);
	void __fastcall BColumnsPenClick(System::TObject* Sender);
	void __fastcall CBLegVisibleChange(System::TObject* Sender);
	void __fastcall CBFontColorChange(System::TObject* Sender);
	void __fastcall CBOtherSideChange(System::TObject* Sender);
	
private:
	Fmxtee::Tools::Datatable::TDataTableTool* DataTable;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDataTableEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDataTableEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDataTableEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Datatable */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_DATATABLE)
using namespace Fmxtee::Editor::Tools::Datatable;
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
#endif	// Fmxtee_Editor_Tools_DatatableHPP
