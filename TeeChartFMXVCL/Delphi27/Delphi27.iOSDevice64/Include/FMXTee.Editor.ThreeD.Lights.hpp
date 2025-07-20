// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.ThreeD.Lights.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Editor_Threed_LightsHPP
#define Fmxtee_Editor_Threed_LightsHPP

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
#include <FMX.StdCtrls.hpp>
#include <FMX.Controls3D.hpp>
#include <FMX.MaterialSources.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Dialogs.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Types3D.hpp>
#include <FMX.ComboTrackBar.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Colors.hpp>
#include <FMX.Edit.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Threed
{
namespace Lights
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLightsEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLightsEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Listbox::TComboBox* CBLight;
	Fmx::Stdctrls::TCheckBox* CBEnabled;
	Fmx::Stdctrls::TTrackBar* TrackBar1;
	Fmx::Stdctrls::TTrackBar* TrackBar2;
	Fmx::Stdctrls::TTrackBar* TrackBar3;
	Fmx::Stdctrls::TTrackBar* TrackBar4;
	Fmx::Stdctrls::TTrackBar* TrackBar5;
	Fmx::Listbox::TComboBox* CBLightType;
	Fmx::Listbox::TListBoxItem* ListBoxItem11;
	Fmx::Listbox::TListBoxItem* ListBoxItem12;
	Fmx::Listbox::TListBoxItem* ListBoxItem13;
	Fmx::Stdctrls::TButton* Button1;
	Fmx::Stdctrls::TButton* BDelete;
	Fmx::Stdctrls::TLabel* LPosX;
	Fmx::Stdctrls::TLabel* LPosY;
	Fmx::Stdctrls::TLabel* LPosZ;
	Fmx::Stdctrls::TLabel* LRotX;
	Fmx::Stdctrls::TLabel* LRotY;
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabItem1;
	Fmx::Tabcontrol::TTabItem* TabItem2;
	Fmx::Stdctrls::TPanel* Panel1;
	Fmx::Tabcontrol::TTabItem* TabItem3;
	Fmx::Colors::TColorButton* CBAmbient;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Tabcontrol::TTabItem* TabItem4;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Colors::TColorButton* CBDiffuse;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Colors::TColorButton* CBSpecular;
	Fmx::Combotrackbar::TComboTrackBar* CBSpotCutoff;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Combotrackbar::TComboTrackBar* CBSpotExponent;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Tabcontrol::TTabItem* TabItem5;
	Fmx::Stdctrls::TTrackBar* TBConstantAtt;
	Fmx::Stdctrls::TTrackBar* TBLinearAtt;
	Fmx::Stdctrls::TTrackBar* TBQuadraticAtt;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Stdctrls::TLabel* Label7;
	Fmx::Stdctrls::TLabel* Label8;
	void __fastcall CBLightChange(System::TObject* Sender);
	void __fastcall CBEnabledChange(System::TObject* Sender);
	void __fastcall CBLightTypeChange(System::TObject* Sender);
	void __fastcall TrackBar1Change(System::TObject* Sender);
	void __fastcall TrackBar2Change(System::TObject* Sender);
	void __fastcall TrackBar3Change(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall BDeleteClick(System::TObject* Sender);
	void __fastcall TrackBar4Change(System::TObject* Sender);
	void __fastcall TrackBar5Change(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBAmbientChange(System::TObject* Sender);
	void __fastcall CBDiffuseClick(System::TObject* Sender);
	void __fastcall CBSpecularClick(System::TObject* Sender);
	void __fastcall CBSpotExponentChange(System::TObject* Sender);
	void __fastcall CBSpotCutoffChange(System::TObject* Sender);
	void __fastcall TBConstantAttChange(System::TObject* Sender);
	void __fastcall TBLinearAttChange(System::TObject* Sender);
	void __fastcall TBQuadraticAttChange(System::TObject* Sender);
	
private:
	Fmx::Types::TFmxObject* IView;
	bool IReady;
	void __fastcall AddComboLight(Fmx::Types::TFmxObject* const ALight);
	System::UnicodeString __fastcall CoordToString(const float AValue);
	Fmx::Controls3d::TLight* __fastcall Light();
	void __fastcall RepaintView();
	
public:
	void __fastcall RefreshViewport(Fmx::Types::TFmxObject* const AViewPort);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLightsEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLightsEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLightsEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lights */
}	/* namespace Threed */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_THREED_LIGHTS)
using namespace Fmxtee::Editor::Threed::Lights;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_THREED)
using namespace Fmxtee::Editor::Threed;
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
#endif	// Fmxtee_Editor_Threed_LightsHPP
