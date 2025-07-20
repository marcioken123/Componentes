// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Animations.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Editor_AnimationsHPP
#define Fmxtee_Editor_AnimationsHPP

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
#include <System.Rtti.hpp>
#include <System.Classes.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Animations.Tools.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Menus.hpp>
#include <FMXTee.Animate.hpp>
#include <FMXTee.Editor.Animation.hpp>
#include <FMX.ComboTrackBar.hpp>
#include <FMX.Edit.hpp>
#include <FMX.TreeView.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Animations
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TChartAnimationsEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TChartAnimationsEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Layouts::TLayout* LayoutAnims;
	Fmx::Stdctrls::TPanel* Panel1;
	Fmx::Listbox::TListBox* LBAnims;
	Fmx::Stdctrls::TSplitter* Splitter1;
	Fmx::Layouts::TLayout* PanelEditor;
	Fmx::Stdctrls::TPanel* Panel2;
	Fmx::Layouts::TLayout* Layout3;
	Fmx::Layouts::TLayout* Layout4;
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Stdctrls::TSplitter* Splitter2;
	Fmx::Tabcontrol::TTabItem* TabAniOptions;
	Fmx::Tabcontrol::TTabItem* TabAnimation;
	Fmx::Stdctrls::TPanel* Panel3;
	Fmx::Listbox::TListBox* LBItems;
	Fmx::Stdctrls::TButton* SBAddItem;
	Fmx::Stdctrls::TButton* BDeleteItem;
	Fmx::Stdctrls::TButton* BAdd;
	Fmx::Stdctrls::TButton* BDelete;
	Fmx::Stdctrls::TButton* BRename;
	Fmx::Stdctrls::TCheckBox* CBLoop;
	Fmx::Listbox::TComboBox* CBSpeed;
	Fmx::Stdctrls::TButton* SBPlay;
	Fmx::Stdctrls::TButton* SBPause;
	Fmx::Stdctrls::TButton* SBStop;
	Fmx::Menus::TPopupMenu* PopupMenu1;
	Fmx::Combotrackbar::TComboTrackBar* TBFramesPerSecond;
	Fmx::Stdctrls::TLabel* Label1;
	void __fastcall BAddClick(System::TObject* Sender);
	void __fastcall BDeleteClick(System::TObject* Sender);
	void __fastcall BRenameClick(System::TObject* Sender);
	void __fastcall LBAnimsChange(System::TObject* Sender);
	void __fastcall SBPlayClick(System::TObject* Sender);
	void __fastcall SBPauseClick(System::TObject* Sender);
	void __fastcall SBStopClick(System::TObject* Sender);
	void __fastcall SBAddItemClick(System::TObject* Sender);
	void __fastcall BDeleteItemClick(System::TObject* Sender);
	void __fastcall CBLoopChange(System::TObject* Sender);
	void __fastcall CBSpeedChange(System::TObject* Sender);
	void __fastcall LBItemsChange(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall TBFramesPerSecondChangeTracking(System::TObject* Sender);
	
private:
	Fmxtee::Animations::Tools::TTeeAnimationTool* IOldAnimation;
	Fmxtee::Editor::Animation::TAnimationEditor* IAnimEditor;
	Fmxtee::Animations::Tools::TTeeAnimationTool* IAnimation;
	void __fastcall ChangedAnimation(System::TObject* Sender);
	void __fastcall CheckPlayButtons(System::TObject* Sender);
	void __fastcall ClearOnChangeEvent();
	void __fastcall FillAnimations();
	Fmxtee::Animations::Tools::TTeeAnimationTool* __fastcall NewAnimation();
	void __fastcall PopupSelected(System::TObject* Sender);
	Fmxtee::Animations::Tools::TTeeAnimationTool* __fastcall SelectedAnimation();
	Fmxtee::Animate::TTeeAnimation* __fastcall SelectedItem();
	void __fastcall SetInternalEvents(const System::Classes::TNotifyEvent AEvent);
	void __fastcall UnselectedAnimation();
	
protected:
	System::Classes::TNotifyEvent OnAdded;
	System::Classes::TNotifyEvent OnDeleted;
	
public:
	Fmxtee::Engine::TChartAnimations* Animations;
	Fmx::Treeview::TTreeViewItem* EditorNode;
	void __fastcall EditAnimation(Fmxtee::Engine::TTeeCustomAnimation* const Value);
	void __fastcall RefreshAnimations(Fmxtee::Engine::TChartAnimations* const Value);
	void __fastcall Reload();
	void __fastcall SelectAnimation(Fmxtee::Engine::TTeeCustomAnimation* const Value);
	void __fastcall SelectIfAny();
	__classmethod TChartAnimationsEditor* __fastcall CreateEditor(System::Classes::TComponent* const AOwner, Fmxtee::Engine::TChartAnimations* const Anims);
	__classmethod void __fastcall Edit(System::Classes::TComponent* const AOwner, Fmxtee::Animations::Tools::TTeeAnimationTool* const Animation);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TChartAnimationsEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TChartAnimationsEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TChartAnimationsEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Animations */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_ANIMATIONS)
using namespace Fmxtee::Editor::Animations;
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
#endif	// Fmxtee_Editor_AnimationsHPP
