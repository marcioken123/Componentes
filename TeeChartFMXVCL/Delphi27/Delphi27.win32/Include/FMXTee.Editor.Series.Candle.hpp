// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Candle.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_Series_CandleHPP
#define Fmxtee_Editor_Series_CandleHPP

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
#include <FMXTee.RadioGroup.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Series.Candle.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Colors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Candle
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCandleEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCandleEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabItem2;
	Fmx::Tabcontrol::TTabItem* TabItem3;
	Fmxtee::Radiogroup::TRadioGroup* RGStyle;
	Fmx::Stdctrls::TRadioButton* RadioButton1;
	Fmx::Stdctrls::TRadioButton* RadioButton2;
	Fmx::Stdctrls::TRadioButton* RadioButton3;
	Fmx::Stdctrls::TRadioButton* RadioButton4;
	Fmx::Stdctrls::TCheckBox* CBShowOpen;
	Fmx::Stdctrls::TCheckBox* CBShowClose;
	Fmx::Stdctrls::TCheckBox* CBDraw3D;
	Fmx::Stdctrls::TCheckBox* CBDark3D;
	Fmx::Stdctrls::TButton* Button1;
	Fmx::Stdctrls::TButton* Button2;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Listbox::TComboBox* CBColorStyle;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Spinbox::TSpinBox* UDWidth;
	Fmx::Spinbox::TSpinBox* UDDepth;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Stdctrls::TButton* Button3;
	Fmx::Stdctrls::TButton* Button4;
	Fmx::Colors::TComboColorBox* BColorUp;
	Fmx::Colors::TComboColorBox* BColorDown;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Stdctrls::TLabel* Label4;
	void __fastcall RGStyleChange(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBShowOpenChange(System::TObject* Sender);
	void __fastcall CBShowCloseChange(System::TObject* Sender);
	void __fastcall CBDraw3DChange(System::TObject* Sender);
	void __fastcall CBDark3DChange(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall UDWidthChange(System::TObject* Sender);
	void __fastcall UDDepthChange(System::TObject* Sender);
	void __fastcall CBColorStyleChange(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall BColorUpChange(System::TObject* Sender);
	void __fastcall BColorDownChange(System::TObject* Sender);
	
private:
	Fmxtee::Series::Candle::TCandleSeries* Candle;
	void __fastcall RefreshControls();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TCandleEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCandleEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCandleEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Candle */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_CANDLE)
using namespace Fmxtee::Editor::Series::Candle;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES)
using namespace Fmxtee::Editor::Series;
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
#endif	// Fmxtee_Editor_Series_CandleHPP
