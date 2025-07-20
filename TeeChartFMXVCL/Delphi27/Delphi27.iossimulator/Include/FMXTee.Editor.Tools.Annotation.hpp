// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Tools.Annotation.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Editor_Tools_AnnotationHPP
#define Fmxtee_Editor_Tools_AnnotationHPP

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
#include <FMXTee.Editor.CustomShape.hpp>
#include <FMXTee.Editor.Margins.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Editor.Series.Pointer.hpp>
#include <FMXTee.Editor.Stroke.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Tools
{
namespace Annotation
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAnnotationToolEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAnnotationToolEdit : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Tabcontrol::TTabItem* TabPosition;
	Fmx::Stdctrls::TCheckBox* CBVisible;
	Fmx::Listbox::TComboBox* CBTextAlign;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Listbox::TListBoxItem* ListBoxItem3;
	Fmx::Memo::TMemo* MemoText;
	Fmx::Stdctrls::TLabel* Label6;
	Fmx::Stdctrls::TButton* BEdit;
	Fmx::Listbox::TComboBox* CBCursor;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TCheckBox* CBClip;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Listbox::TComboBox* CBPos;
	Fmx::Listbox::TListBoxItem* ListBoxItem4;
	Fmx::Listbox::TListBoxItem* ListBoxItem5;
	Fmx::Listbox::TListBoxItem* ListBoxItem6;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Spinbox::TSpinBox* UDLeft;
	Fmx::Listbox::TListBoxItem* ListBoxItem7;
	Fmx::Listbox::TListBoxItem* ListBoxItem8;
	Fmx::Stdctrls::TCheckBox* CBCustPos;
	Fmx::Spinbox::TSpinBox* UDTop;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Stdctrls::TLabel* Label7;
	Fmx::Listbox::TComboBox* CBUnits;
	Fmx::Listbox::TListBoxItem* ListBoxItem9;
	Fmx::Listbox::TListBoxItem* ListBoxItem10;
	Fmx::Listbox::TListBoxItem* ListBoxItem11;
	Fmx::Listbox::TListBoxItem* ListBoxItem12;
	Fmx::Listbox::TListBoxItem* ListBoxItem13;
	Fmx::Stdctrls::TCheckBox* CBDraw3D;
	Fmx::Spinbox::TSpinBox* UDZPos;
	Fmx::Stdctrls::TLabel* Label8;
	Fmx::Tabcontrol::TTabItem* TabSize;
	Fmx::Spinbox::TSpinBox* UDWidth;
	Fmx::Spinbox::TSpinBox* UDHeight;
	Fmx::Stdctrls::TLabel* Label9;
	Fmx::Stdctrls::TLabel* Label10;
	Fmx::Stdctrls::TCheckBox* CBAutoSize;
	Fmx::Tabcontrol::TTabItem* TabCallout;
	Fmx::Tabcontrol::TTabItem* TabMargins;
	Fmx::Tabcontrol::TTabItem* TabShape;
	Fmx::Tabcontrol::TTabControl* TabControlCallout;
	Fmx::Tabcontrol::TTabItem* TabCalloutOptions;
	Fmx::Tabcontrol::TTabItem* TabCalloutBorder;
	Fmx::Tabcontrol::TTabItem* TabCalloutPointer;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Stdctrls::TLabel* Label11;
	Fmx::Stdctrls::TLabel* Label12;
	Fmx::Stdctrls::TLabel* Label13;
	Fmx::Spinbox::TSpinBox* UDX;
	Fmx::Spinbox::TSpinBox* UDY;
	Fmx::Spinbox::TSpinBox* UDZ;
	Fmx::Stdctrls::TLabel* Label14;
	Fmx::Spinbox::TSpinBox* UDArrowDist;
	Fmx::Stdctrls::TLabel* Label15;
	Fmx::Listbox::TComboBox* CBHead;
	Fmx::Listbox::TListBoxItem* ListBoxItem14;
	Fmx::Listbox::TListBoxItem* ListBoxItem15;
	Fmx::Listbox::TListBoxItem* ListBoxItem16;
	Fmx::Stdctrls::TLabel* Label16;
	Fmx::Spinbox::TSpinBox* UDHeadSize;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall CBCursorChange(System::TObject* Sender);
	void __fastcall CBVisibleChange(System::TObject* Sender);
	void __fastcall CBTextAlignChange(System::TObject* Sender);
	void __fastcall CBPosChange(System::TObject* Sender);
	void __fastcall UDLeftChange(System::TObject* Sender);
	void __fastcall EFormatChange(System::TObject* Sender);
	void __fastcall CBClipChange(System::TObject* Sender);
	void __fastcall BEditClick(System::TObject* Sender);
	void __fastcall CBCustPosChange(System::TObject* Sender);
	void __fastcall UDTopChange(System::TObject* Sender);
	void __fastcall CBUnitsChange(System::TObject* Sender);
	void __fastcall CBDraw3DChange(System::TObject* Sender);
	void __fastcall UDZPosChange(System::TObject* Sender);
	void __fastcall CBAutoSizeChange(System::TObject* Sender);
	void __fastcall UDWidthChange(System::TObject* Sender);
	void __fastcall UDHeightChange(System::TObject* Sender);
	void __fastcall UDXChange(System::TObject* Sender);
	void __fastcall UDYChange(System::TObject* Sender);
	void __fastcall UDZChange(System::TObject* Sender);
	void __fastcall UDArrowDistChange(System::TObject* Sender);
	void __fastcall CBHeadChange(System::TObject* Sender);
	void __fastcall UDHeadSizeChange(System::TObject* Sender);
	void __fastcall TabControl1Change(System::TObject* Sender);
	void __fastcall TabControlCalloutChange(System::TObject* Sender);
	
private:
	Fmxtee::Tools::TAnnotationTool* Annotation;
	Fmx::Forms::TForm* MarginsForm;
	Fmxtee::Editor::Customshape::TTeeShapeEditor* ShapeForm;
	Fmxtee::Editor::Stroke::TStrokeEditor* ICalloutBorder;
	Fmxtee::Editor::Series::Pointer::TSeriesPointerEditor* ICalloutPointer;
	void __fastcall EnableCustomPosition();
	void __fastcall EnableCustomSize();
	
public:
	void __fastcall HideText();
	__classmethod TAnnotationToolEdit* __fastcall InsertForm(Fmxtee::Tools::TAnnotationTool* const Annotation, Fmx::Types::TFmxObject* const AParent, bool ShowPositionTab = false);
	void __fastcall RefreshControls(Fmxtee::Tools::TAnnotationTool* const ATool);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAnnotationToolEdit(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAnnotationToolEdit(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAnnotationToolEdit() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Annotation */
}	/* namespace Tools */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_TOOLS_ANNOTATION)
using namespace Fmxtee::Editor::Tools::Annotation;
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
#endif	// Fmxtee_Editor_Tools_AnnotationHPP
