// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_ToolsHPP
#define Fmxtee_Editor_ToolsHPP

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
#include <FMX.Forms.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Dialogs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Menus.hpp>
#include <FMX.Objects.hpp>
#include <FMX.Memo.hpp>
#include <FMX.TreeView.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TToolsEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TToolsEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TSplitter* Splitter1;
	Fmx::Listbox::TListBox* LBTools;
	Fmx::Stdctrls::TPanel* PanelToolEditor;
	Fmx::Stdctrls::TPanel* PTop;
	Fmx::Stdctrls::TButton* BAdd;
	Fmx::Stdctrls::TButton* BDelete;
	Fmx::Stdctrls::TCheckBox* CBActive;
	Fmx::Stdctrls::TPanel* Panel2;
	Fmx::Stdctrls::TButton* BMoveUp;
	Fmx::Stdctrls::TButton* BMoveDown;
	Fmx::Stdctrls::TCheckBox* CBShowInEditor;
	Fmx::Stdctrls::TPanel* PBottom;
	Fmx::Menus::TPopupMenu* PopupMenu1;
	Fmx::Objects::TText* BottomText;
	Fmx::Stdctrls::TButton* BClone;
	Fmx::Layouts::TLayout* Layout1;
	Fmx::Controls::TStyleBook* StyleBook1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall BCloneClick(System::TObject* Sender);
	void __fastcall BAddClick(System::TObject* Sender);
	void __fastcall BDeleteClick(System::TObject* Sender);
	void __fastcall BMoveUpClick(System::TObject* Sender);
	void __fastcall BMoveDownClick(System::TObject* Sender);
	void __fastcall PBottomClick(System::TObject* Sender);
	void __fastcall LBToolsChange(System::TObject* Sender);
	void __fastcall CBActiveChange(System::TObject* Sender);
	void __fastcall CBShowInEditorChange(System::TObject* Sender);
	
private:
	Fmxtee::Chart::TCustomChart* Chart;
	Fmx::Forms::TCommonCustomForm* FLastForm;
	void __fastcall AddTool(Fmxtee::Engine::TTeeCustomTool* const ATool);
	void __fastcall AddToolEditor();
	Fmxtee::Engine::TTeeCustomTool* __fastcall CloneTool(Fmxtee::Engine::TTeeCustomTool* const Tool);
	Fmxtee::Engine::TTeeCustomTool* __fastcall CurrentTool();
	void __fastcall DeleteForm();
	Fmxtee::Engine::TTeeCustomTool* __fastcall DoAddNewTool(const Fmxtee::Engine::TTeeCustomToolClass AClass, const System::UnicodeString ADefaultName);
	void __fastcall EnableButtons();
	void __fastcall FillTools();
	Fmxtee::Engine::TTeeCustomTool* __fastcall GetNewTool();
	void __fastcall RefreshChart(Fmxtee::Chart::TCustomChart* const AChart);
	void __fastcall RefreshTool(Fmxtee::Engine::TTeeCustomTool* const ATool);
	void __fastcall SetPanelBottom();
	void __fastcall SwapTool(int A, int B);
	Fmxtee::Engine::TTeeCustomTool* __fastcall Tool();
	void __fastcall TryAddEditorNode(Fmxtee::Engine::TTeeCustomTool* const ATool);
	
protected:
	System::Classes::TNotifyEvent OnAdded;
	System::Classes::TNotifyEvent OnDeleted;
	
public:
	Fmx::Treeview::TTreeViewItem* EditorNode;
	__classmethod TToolsEditor* __fastcall CreateEditor(System::Classes::TComponent* const AOwner, Fmxtee::Chart::TCustomChart* const AChart);
	__classmethod void __fastcall Edit(System::Classes::TComponent* const AOwner, Fmxtee::Engine::TTeeCustomTool* const ATool);
	void __fastcall EditTool(Fmxtee::Engine::TTeeCustomTool* const Value);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TToolsEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TToolsEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TToolsEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
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
#endif	// Fmxtee_Editor_ToolsHPP
