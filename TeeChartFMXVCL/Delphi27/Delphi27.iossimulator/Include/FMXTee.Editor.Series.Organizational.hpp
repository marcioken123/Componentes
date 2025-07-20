// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Editor.Series.Organizational.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Editor_Series_OrganizationalHPP
#define Fmxtee_Editor_Series_OrganizationalHPP

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
#include <FMXTee.Chart.ListBox.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.SpinBox.hpp>
#include <FMX.Controls.Presentation.hpp>
#include <FMX.EditBox.hpp>
#include <FMX.TabControl.hpp>
#include <FMXTee.Series.Organizational.hpp>
#include <FMXTee.Editor.CustomShape.hpp>
#include <FMXTee.Editor.Margins.hpp>
#include <FMX.Edit.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.Colors.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.TreeView.hpp>
#include <FMX.Memo.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Editor
{
namespace Series
{
namespace Organizational
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TOrgSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TOrgSeriesEditor : public Fmx::Forms::TForm
{
	typedef Fmx::Forms::TForm inherited;
	
__published:
	Fmx::Tabcontrol::TTabControl* TabControl1;
	Fmx::Tabcontrol::TTabItem* TabOptions;
	Fmx::Stdctrls::TButton* BLines;
	Fmx::Listbox::TComboBox* CBLineStyle;
	Fmx::Stdctrls::TLabel* Label1;
	Fmx::Listbox::TListBoxItem* ListBoxItem1;
	Fmx::Listbox::TListBoxItem* ListBoxItem2;
	Fmx::Stdctrls::TGroupBox* GroupBox1;
	Fmx::Stdctrls::TLabel* Label2;
	Fmx::Stdctrls::TLabel* Label3;
	Fmx::Stdctrls::TTrackBar* TrackBar1;
	Fmx::Stdctrls::TTrackBar* TrackBar2;
	Fmx::Tabcontrol::TTabItem* TabNodes;
	Fmx::Stdctrls::TPanel* Panel1;
	Fmx::Treeview::TTreeView* TreeNodes;
	Fmx::Stdctrls::TSplitter* Splitter1;
	Fmx::Tabcontrol::TTabControl* TabControl2;
	Fmx::Tabcontrol::TTabItem* TabText;
	Fmx::Tabcontrol::TTabItem* TabSize;
	Fmx::Tabcontrol::TTabItem* TabMargins;
	Fmx::Stdctrls::TButton* SBAdd;
	Fmx::Stdctrls::TButton* SBDelete;
	Fmx::Stdctrls::TButton* BDefaultFormat;
	Fmx::Stdctrls::TLabel* Label4;
	Fmx::Memo::TMemo* Memo1;
	Fmx::Stdctrls::TCheckBox* CBVisible;
	Fmx::Stdctrls::TButton* BEdit;
	Fmx::Listbox::TComboBox* CBCursor;
	Fmx::Stdctrls::TLabel* Label5;
	Fmx::Listbox::TComboBox* ComboAlign;
	Fmx::Listbox::TListBoxItem* ListBoxItem3;
	Fmx::Listbox::TListBoxItem* ListBoxItem4;
	Fmx::Listbox::TListBoxItem* ListBoxItem5;
	Fmx::Stdctrls::TLabel* Label7;
	Fmx::Stdctrls::TCheckBox* CBDefaultFormat;
	Fmx::Spinbox::TSpinBox* UDWidth;
	Fmx::Spinbox::TSpinBox* UDHeight;
	Fmx::Stdctrls::TLabel* Label8;
	Fmx::Stdctrls::TLabel* Label9;
	Fmx::Stdctrls::TCheckBox* CBAutoSize;
	Fmx::Stdctrls::TCheckBox* CBClip;
	Fmx::Tabcontrol::TTabItem* TabShape;
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall BLinesClick(System::TObject* Sender);
	void __fastcall CBLineStyleChange(System::TObject* Sender);
	void __fastcall CBCursorChange(System::TObject* Sender);
	void __fastcall TrackBar1Change(System::TObject* Sender);
	void __fastcall TrackBar2Change(System::TObject* Sender);
	void __fastcall SBAddClick(System::TObject* Sender);
	void __fastcall SBDeleteClick(System::TObject* Sender);
	void __fastcall BDefaultFormatClick(System::TObject* Sender);
	void __fastcall Memo1Change(System::TObject* Sender);
	void __fastcall CBVisibleChange(System::TObject* Sender);
	void __fastcall BEditClick(System::TObject* Sender);
	void __fastcall ComboAlignChange(System::TObject* Sender);
	void __fastcall CBDefaultFormatChange(System::TObject* Sender);
	void __fastcall CBAutoSizeChange(System::TObject* Sender);
	void __fastcall UDWidthChange(System::TObject* Sender);
	void __fastcall UDHeightChange(System::TObject* Sender);
	void __fastcall CBClipChange(System::TObject* Sender);
	void __fastcall TreeNodesChange(System::TObject* Sender);
	
private:
	Fmxtee::Editor::Customshape::TTeeShapeEditor* ShapeEditor;
	Fmx::Forms::TForm* MarginsEditor;
	void __fastcall AddListNodes(int Current);
	Fmxtee::Series::Organizational::TOrgItem* __fastcall CurrentItem();
	void __fastcall ShowHideFormatTabs(Fmxtee::Series::Organizational::TOrgItem* const OrgItem, bool DoShow);
	
protected:
	Fmxtee::Series::Organizational::TCustomOrgSeries* Org;
	bool IChanging;
	int __fastcall CurrentIndex()/* overload */;
	int __fastcall CurrentIndex(Fmx::Treeview::TTreeViewItem* const ANode)/* overload */;
	void __fastcall RefreshNode(int Index);
	virtual void __fastcall SetItemProperties(int Index);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TOrgSeriesEditor(System::Classes::TComponent* AOwner) : Fmx::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TOrgSeriesEditor(System::Classes::TComponent* AOwner, NativeInt Dummy) : Fmx::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TOrgSeriesEditor() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Organizational */
}	/* namespace Series */
}	/* namespace Editor */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_EDITOR_SERIES_ORGANIZATIONAL)
using namespace Fmxtee::Editor::Series::Organizational;
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
#endif	// Fmxtee_Editor_Series_OrganizationalHPP
