// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Animations.Transform.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Editor_Animations_TransformHPP
#define Fmxtee_Editor_Animations_TransformHPP

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
#include <System.Variants.hpp>
#include <FMX.Types.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.Layouts.hpp>
#include <FMXTee.Chart.GalleryPanel.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.ListBox.hpp>
#include <FMXTee.Animate.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMXTee.Animations.Tools.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Animations
{
namespace Transform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTransformEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTransformEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabGallery;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabTarget;
	Fmxtee::Chart::Gallerypanel::TChartGalleryPanel* Gallery;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Listbox::TComboBox* CBTranslate;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Listbox::TComboBox* CBZoom;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Listbox::TComboBox* CBScale;
	Fmx::Stdctrls::TCheckBox* CBRotate;
	Fmx::Stdctrls::TCheckBox* CBUseBounds;
	Fmx::Stdctrls::TCheckBox* CBClip;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Listbox::TComboBox* CBTarget;
	Fmx::Listbox::TComboBox* CBSeries;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Listbox::TComboBox* CBAxes;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Stdctrls::TLabel* Label7;
	Fmx::Listbox::TComboBox* CBFade;
	void __fastcall GalleryChangeChart(System::TObject* Sender);
	void __fastcall CBTranslateChange(System::TObject* Sender);
	void __fastcall CBRotateChange(System::TObject* Sender);
	void __fastcall CBZoomChange(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBScaleChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CBAxesChange(System::TObject* Sender);
	void __fastcall CBClipChange(System::TObject* Sender);
	void __fastcall CBUseBoundsChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall CBTargetChange(System::TObject* Sender);
	void __fastcall CBSeriesChange(System::TObject* Sender);
	void __fastcall CBFadeChange(System::TObject* Sender);
	
private:
	Fmxtee::Animate::TTeeAnimate* IAnimate;
	void __fastcall CreateGallery();
	void __fastcall EnableCombos();
	void __fastcall PrepareControls();
	
protected:
	Fmxtee::Animations::Tools::TTransformAnimation* Animation;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTransformEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTransformEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTransformEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Transform */
}	/* namespace Animations */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_ANIMATIONS_TRANSFORM)
using namespace Fmxtee::Editor::Animations::Transform;
#endif
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
#endif	// Fmxtee_Editor_Animations_TransformHPP
