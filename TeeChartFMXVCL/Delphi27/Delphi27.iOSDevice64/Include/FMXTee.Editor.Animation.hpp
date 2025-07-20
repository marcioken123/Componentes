// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Animation.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Editor_AnimationHPP
#define Fmxtee_Editor_AnimationHPP

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
#include <FMX.Controls.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Layouts.hpp>
#include <FMXTee.Chart.GalleryPanel.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ComboTrackBar.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Animate.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Animation
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAnimationEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAnimationEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabTiming;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Combotrackbar::TComboTrackBar* EDuration;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Combotrackbar::TComboTrackBar* EStartTime;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Stdctrls::TCheckBox* CBEnabled;
	Fmx::Stdctrls::TCheckBox* CBLoop;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Edit::TEdit* ETitle;
	Fmx::Stdctrls::TPanel* Panel1;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Listbox::TComboBox* CBTiming;
	Fmxtee::Chart::Gallerypanel::TChartGalleryPanel* Gallery;
	Fmx::Stdctrls::TCheckBox* CBTwoWay;
	Fmx::Stdctrls::TCheckBox* CBInverted;
	Fmx::Listbox::TComboBox* CBEasing;
	Fmx::Stdctrls::TLabel* Label7;
	void __fastcall CBTimingChange(System::TObject* Sender);
	void __fastcall GalleryChangeChart(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall EDurationChangeTracking(System::TObject* Sender);
	void __fastcall EStartTimeChangeTracking(System::TObject* Sender);
	void __fastcall CBEnabledChange(System::TObject* Sender);
	void __fastcall CBLoopChange(System::TObject* Sender);
	void __fastcall CBTwoWayChange(System::TObject* Sender);
	void __fastcall CBInvertedChange(System::TObject* Sender);
	void __fastcall CBEasingChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Fmxtee::Animate::TTeeAnimation* Animation;
	System::Classes::TNotifyEvent FOnChanged;
	Fmxtee::Animate::TTeeAnimation* IPointerAnim;
	void __fastcall CreateTimingGallery();
	void __fastcall DoChanged();
	void __fastcall PointerAnimFrame(Fmxtee::Animate::TTeeAnimation* Sender, const float Fraction);
	
public:
	void __fastcall RefreshAnimation(Fmxtee::Animate::TTeeAnimation* const AAnimation);
	__property System::Classes::TNotifyEvent OnChanged = {read=FOnChanged, write=FOnChanged};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAnimationEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAnimationEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAnimationEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Animation */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_ANIMATION)
using namespace Fmxtee::Editor::Animation;
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
#endif	// Fmxtee_Editor_AnimationHPP
