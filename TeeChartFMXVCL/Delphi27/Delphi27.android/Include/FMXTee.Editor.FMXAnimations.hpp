// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.FMXAnimations.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Editor_FmxanimationsHPP
#define Fmxtee_Editor_FmxanimationsHPP

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
#include <FMX.Objects.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.Ani.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Menus.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Fmxanimations
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAnimationsEditor;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TAnimationsEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Stdctrls::TPanel* Panel1;
	Fmx::Listbox::TListBox* ListBox1;
	Fmx::Objects::TPaintBox* PaintScales;
	Fmx::Stdctrls::TSplitter* Splitter1;
	Fmx::Stdctrls::TCheckBox* CBPause;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Listbox::TComboBox* CBInstances;
	Fmx::Menus::TMenuBar* MenuBar1;
	Fmx::Menus::TMenuItem* MenuAdd;
	Fmx::Menus::TMenuItem* MenuItem1;
	Fmx::Menus::TMenuItem* MenuItem2;
	Fmx::Menus::TMenuItem* MenuItem3;
	Fmx::Stdctrls::TStatusBar* StatusBar1;
	Fmx::Types::TTimer* Timer1;
	Fmx::Stdctrls::TLabel* LabelData;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Listbox::TComboBox* CBScale;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Listbox::TListBoxItem* ListBoxItem3;
	Fmx::Listbox::TListBoxItem* ListBoxItem4;
	Fmx::Stdctrls::TPanel* Indicators;
	Fmx::Stdctrls::TScrollBar* ScrollBar1;
	Fmx::Stdctrls::TScrollBar* ScrollBar2;
	void __fastcall ListBox1ChangeCheck(System::TObject* Sender);
	void __fastcall PaintScalesPaint(System::TObject* Sender, Fmx::Graphics::TCanvas* Canvas);
	void __fastcall ListBox1Change(System::TObject* Sender);
	void __fastcall CBPauseChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ListBox1ApplyStyleLookup(System::TObject* Sender);
	void __fastcall CBInstancesChange(System::TObject* Sender);
	void __fastcall ListBox1KeyUp(System::TObject* Sender, System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	void __fastcall Timer1Timer(System::TObject* Sender);
	void __fastcall CBScaleChange(System::TObject* Sender);
	void __fastcall ScrollBar2Change(System::TObject* Sender);
	void __fastcall ScrollBar1Change(System::TObject* Sender);
	
private:
	Fmx::Types::TFmxObject* FObject;
	float ScaleFactor;
	void __fastcall AddColor(System::TObject* Sender);
	void __fastcall AddFloat(System::TObject* Sender);
	void __fastcall AddInteger(System::TObject* Sender);
	void __fastcall AddSequence(System::TObject* Sender);
	void __fastcall CreateIndicator(int t, Fmx::Ani::TAnimation* const a);
	void __fastcall FillAnimations(Fmx::Types::TFmxObject* const AObject);
	void __fastcall IndicatorClick(System::TObject* Sender);
	void __fastcall Refill();
	void __fastcall SelectAnimation(Fmx::Ani::TAnimation* const A);
	void __fastcall UpdateLabelData(Fmx::Ani::TAnimation* const A);
	
public:
	__classmethod void __fastcall Edit(System::Classes::TComponent* const AOwner, Fmx::Types::TFmxObject* const AObject);
	void __fastcall RefreshObject(Fmx::Types::TFmxObject* const AObject);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAnimationsEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAnimationsEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAnimationsEditor() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Fmxanimations */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_FMXANIMATIONS)
using namespace Fmxtee::Editor::Fmxanimations;
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
#endif	// Fmxtee_Editor_FmxanimationsHPP
