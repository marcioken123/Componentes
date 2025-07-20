// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Chart3D.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Editor_Chart3dHPP
#define Fmxtee_Editor_Chart3dHPP

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
#include <FMX.Edit.hpp>
#include <FMX.Colors.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.TreeView.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.Controls3D.hpp>
#include <FMX.MaterialSources.hpp>
#include <FMX.Viewport3D.hpp>
#include <FMX.Forms3D.hpp>
#include <FMX.Graphics.hpp>
#include <System.Math.Vectors.hpp>
#include <FMX.Text.hpp>
#include <FMX.Types3D.hpp>
#include <FMX.Objects3D.hpp>
#include <FMXTee.Editor.ThreeD.Lights.hpp>
#include <FMX.ComboTrackBar.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Chart3d
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TObject3D;
class DELPHICLASS TAxis3D;
class DELPHICLASS TMouse3D;
class DELPHICLASS TChart3DEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TObject3D : public Fmx::Controls3d::TControl3D
{
	typedef Fmx::Controls3d::TControl3D inherited;
	
private:
	System::UnicodeString FFileName;
	void __fastcall SetFileName(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall Render();
	virtual void __fastcall SetVisible(const bool Value);
	
public:
	void __fastcall Embedd(Fmx::Types::TFmxObject* const AObject);
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	virtual bool __fastcall RayCastIntersect(const System::Math::Vectors::TPoint3D &RayPos, const System::Math::Vectors::TPoint3D &RayDir, System::Math::Vectors::TPoint3D &Intersection);
	
__published:
	__property System::UnicodeString FileName = {read=FFileName, write=SetFileName};
public:
	/* TControl3D.Create */ inline __fastcall virtual TObject3D(System::Classes::TComponent* AOwner) : Fmx::Controls3d::TControl3D(AOwner) { }
	/* TControl3D.Destroy */ inline __fastcall virtual ~TObject3D() { }
	
};


class PASCALIMPLEMENTATION TAxis3D : public Fmx::Objects3d::TShape3D
{
	typedef Fmx::Objects3d::TShape3D inherited;
	
private:
	Fmx::Graphics::TFont* FFont;
	void __fastcall SetFont(Fmx::Graphics::TFont* const Value);
	
protected:
	void __fastcall FontChanged(System::TObject* Sender);
	virtual void __fastcall Render();
	virtual void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall virtual TAxis3D(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TAxis3D();
	virtual bool __fastcall RayCastIntersect(const System::Math::Vectors::TPoint3D &RayPos, const System::Math::Vectors::TPoint3D &RayDir, System::Math::Vectors::TPoint3D &Intersection);
	
__published:
	__property Fmx::Graphics::TFont* Font = {read=FFont, write=SetFont};
};


class PASCALIMPLEMENTATION TMouse3D : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Fmx::Controls3d::TCamera* FCamera;
	Fmx::Controls3d::TControl3D* FControl;
	Fmx::Controls3d::TMouseEvent3D FOnMouseDown;
	Fmx::Controls3d::TMouseEvent3D FOnMouseUp;
	Fmx::Controls3d::TMouseMoveEvent3D FOnMouseMove;
	System::StaticArray<bool, 3> Down;
	bool OldAuto;
	System::Types::TPointF Old;
	Fmx::Controls3d::TMouseEvent3D OldDown;
	Fmx::Controls3d::TMouseEvent3D OldUp;
	Fmx::Controls3d::TMouseMoveEvent3D OldMove;
	Fmx::Types::TMouseWheelEvent OldWheel;
	Fmx::Controls3d::TControl3D* ITarget;
	void __fastcall MouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, float X, float Y, const System::Math::Vectors::TVector3D &RayPos, const System::Math::Vectors::TVector3D &RayDir);
	void __fastcall MouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y, const System::Math::Vectors::TVector3D &RayPos, const System::Math::Vectors::TVector3D &RayDir);
	void __fastcall MouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y, const System::Math::Vectors::TVector3D &RayPos, const System::Math::Vectors::TVector3D &RayDir);
	void __fastcall MouseWheel(System::TObject* Sender, System::Classes::TShiftState Shift, int WheelDelta, bool &Handled);
	
public:
	__fastcall TMouse3D(Fmx::Controls3d::TControl3D* const AControl, Fmx::Controls3d::TCamera* const ACamera);
	__fastcall virtual ~TMouse3D();
	__property Fmx::Controls3d::TMouseEvent3D OnMouseDown = {read=FOnMouseDown, write=FOnMouseDown};
	__property Fmx::Controls3d::TMouseMoveEvent3D OnMouseMove = {read=FOnMouseMove, write=FOnMouseMove};
	__property Fmx::Controls3d::TMouseEvent3D OnMouseUp = {read=FOnMouseUp, write=FOnMouseUp};
};


class PASCALIMPLEMENTATION TChart3DEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Treeview::TTreeView* TreeView1;
	Fmx::Stdctrls::TSplitter* Splitter1;
	Fmx::Layouts::TVertScrollBox* VertScrollBox1;
	Fmx::Stdctrls::TExpander* Expander1;
	Fmx::Stdctrls::TLabel* LClass;
	Fmx::Listbox::TComboBox* CBClass;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Listbox::TListBoxItem* ListBoxItem3;
	Fmx::Listbox::TListBoxItem* ListBoxItem4;
	Fmx::Listbox::TListBoxItem* ListBoxItem5;
	Fmx::Listbox::TListBoxItem* ListBoxItem6;
	Fmx::Listbox::TListBoxItem* ListBoxItem7;
	Fmx::Stdctrls::TExpander* Expander2;
	Fmx::Colors::TComboColorBox* CBDiffuse;
	Fmx::Colors::TComboColorBox* CBBackDiffuse;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Combotrackbar::TComboTrackBar* CBOpacity;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Stdctrls::TCheckBox* CBTwoSide;
	Fmx::Stdctrls::TExpander* Expander3;
	Fmx::Combotrackbar::TComboTrackBar* CBPosX;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Combotrackbar::TComboTrackBar* CBPosY;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Combotrackbar::TComboTrackBar* CBPosZ;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Stdctrls::TExpander* Expander4;
	Fmx::Combotrackbar::TComboTrackBar* CBRotX;
	Fmx::Combotrackbar::TComboTrackBar* CBRotY;
	Fmx::Combotrackbar::TComboTrackBar* CBRotZ;
	Fmx::Stdctrls::TExpander* Expander5;
	Fmx::Combotrackbar::TComboTrackBar* CBWidth;
	Fmx::Combotrackbar::TComboTrackBar* CBHeight;
	Fmx::Combotrackbar::TComboTrackBar* CBDepth;
	Fmx::Viewport3d::TViewport3D* Viewport3D1;
	Fmx::Stdctrls::TLabel* LName;
	Fmx::Controls3d::TLight* Light3;
	Fmx::Stdctrls::TButton* BBitmap;
	Fmx::Stdctrls::TCheckBox* CBLighting;
	Fmx::Colors::TComboColorBox* CBViewPortColor;
	Fmx::Listbox::TComboBox* CBMultiSample;
	Fmx::Listbox::TListBoxItem* ListBoxItem8;
	Fmx::Listbox::TListBoxItem* ListBoxItem9;
	Fmx::Listbox::TListBoxItem* ListBoxItem10;
	Fmx::Tabcontrol::TTabItem* TabItem1;
	Fmx::Tabcontrol::TTabItem* TabLighting;
	Fmx::Stdctrls::TSplitter* Splitter2;
	Fmx::Stdctrls::TButton* BReset;
	Fmx::Stdctrls::TCheckBox* CBWire;
	Fmx::Menus::TMenuBar* MenuBar1;
	Fmx::Menus::TMenuItem* MenuItem1;
	Fmx::Menus::TMenuItem* View3DViews;
	Fmx::Stdctrls::TPanel* Panel3DViews;
	Fmx::Viewport3d::TViewport3D* ViewportTop;
	Fmx::Stdctrls::TSplitter* Splitter3;
	Fmx::Stdctrls::TSplitter* Splitter4;
	Fmx::Controls3d::TLight* Light1;
	Fmx::Viewport3d::TViewport3D* ViewportFront;
	Fmx::Controls3d::TLight* Light2;
	Fmx::Menus::TMenuItem* ViewObjectEditor;
	Fmx::Controls3d::TCamera* Camera1;
	Fmx::Controls3d::TCamera* Camera2;
	Fmx::Stdctrls::TLabel* Label7;
	Fmx::Stdctrls::TExpander* Expander6;
	Fmx::Stdctrls::TLabel* Label8;
	Fmx::Stdctrls::TLabel* Label9;
	Fmx::Stdctrls::TLabel* Label10;
	Fmx::Combotrackbar::TComboTrackBar* CBScaleX;
	Fmx::Stdctrls::TLabel* Label11;
	Fmx::Combotrackbar::TComboTrackBar* CBScaleY;
	Fmx::Stdctrls::TLabel* Label12;
	Fmx::Combotrackbar::TComboTrackBar* CBScaleZ;
	Fmx::Viewport3d::TViewport3D* ViewportSide;
	Fmx::Controls3d::TCamera* Camera3;
	Fmx::Controls3d::TLight* Light4;
	Fmx::Menus::TMenuItem* MenuItem2;
	Fmx::Objects3d::TDummy* Dummy1;
	Fmx::Menus::TMenuItem* MenuAxes;
	Fmx::Stdctrls::TLabel* Label13;
	Fmx::Stdctrls::TLabel* Label14;
	Fmx::Stdctrls::TLabel* Label15;
	Fmx::Stdctrls::TExpander* Expander7;
	Fmx::Listbox::TComboBox* CBCursor;
	Fmx::Controls3d::TProxyObject* ProxyTop;
	Fmx::Controls3d::TProxyObject* ProxyFront;
	Fmx::Controls3d::TProxyObject* ProxySide;
	Fmx::Stdctrls::TSplitter* Splitter5;
	void __fastcall CBClassChange(System::TObject* Sender);
	void __fastcall CBRotYChange(System::TObject* Sender);
	void __fastcall CBRotZChange(System::TObject* Sender);
	void __fastcall CBRotXChange(System::TObject* Sender);
	void __fastcall TreeView1Change(System::TObject* Sender);
	void __fastcall TreeView1ChangeCheck(System::TObject* Sender);
	void __fastcall CBDiffuseChange(System::TObject* Sender);
	void __fastcall CBOpacityChange(System::TObject* Sender);
	void __fastcall CBTwoSideChange(System::TObject* Sender);
	void __fastcall CBWidthChange(System::TObject* Sender);
	void __fastcall CBHeightChange(System::TObject* Sender);
	void __fastcall CBDepthChange(System::TObject* Sender);
	void __fastcall CBPosXChange(System::TObject* Sender);
	void __fastcall CBPosYChange(System::TObject* Sender);
	void __fastcall CBPosZChange(System::TObject* Sender);
	void __fastcall CBBackDiffuseChange(System::TObject* Sender);
	void __fastcall BBitmapClick(System::TObject* Sender);
	void __fastcall CBLightingChange(System::TObject* Sender);
	void __fastcall CBViewPortColorChange(System::TObject* Sender);
	void __fastcall CBMultiSampleChange(System::TObject* Sender);
	void __fastcall BResetClick(System::TObject* Sender);
	void __fastcall CBWireChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall View3DViewsClick(System::TObject* Sender);
	void __fastcall ViewportTopPaint(System::TObject* Sender, Fmx::Graphics::TCanvas* Canvas, const System::Types::TRectF &ARect);
	void __fastcall ViewObjectEditorClick(System::TObject* Sender);
	void __fastcall CBScaleXChange(System::TObject* Sender);
	void __fastcall CBScaleYChange(System::TObject* Sender);
	void __fastcall CBScaleZChange(System::TObject* Sender);
	void __fastcall ViewportTopMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall ViewportFrontMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall ViewportSideMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall MenuItem2Click(System::TObject* Sender);
	void __fastcall Dummy1Render(System::TObject* Sender, Fmx::Types3d::TContext3D* Context);
	void __fastcall Viewport3D1MouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall MenuAxesClick(System::TObject* Sender);
	void __fastcall CBCursorChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Viewport3D1MouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall Viewport3D1Paint(System::TObject* Sender, Fmx::Graphics::TCanvas* Canvas, const System::Types::TRectF &ARect);
	
private:
	bool Changing;
	Fmx::Controls3d::TControl3D* FControl;
	Fmxtee::Editor::Threed::Lights::TLightsEditor* ILights;
	Fmx::Types::TFmxObject* CurrentViewport;
	TMouse3D* FMouse3D;
	TAxis3D* FAxes;
	Fmx::Controls3d::TControl3D* Start;
	bool IReady;
	Fmx::Controls3d::TControl3D* __fastcall Current();
	void __fastcall DrawBounds(Fmx::Types3d::TContext3D* const Context, Fmx::Types::TFmxObject* const AObject, bool HoveredOnly = false);
	void __fastcall FillTree(Fmx::Controls3d::TControl3D* const Visual);
	void __fastcall MouseUp3D(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y, const System::Math::Vectors::TVector3D &RayPos, const System::Math::Vectors::TVector3D &RayDir);
	void __fastcall RefreshLights();
	void __fastcall RefreshViewport(Fmx::Types::TFmxObject* const AViewport);
	void __fastcall RemoveOnMouseDown();
	void __fastcall RepaintViews();
	
public:
	__classmethod void __fastcall Edit(System::Classes::TComponent* const AOwner, Fmx::Controls3d::TControl3D* const AControl);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TChart3DEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TChart3DEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TChart3DEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Chart3d */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_CHART3D)
using namespace Fmxtee::Editor::Chart3d;
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
#endif	// Fmxtee_Editor_Chart3dHPP
