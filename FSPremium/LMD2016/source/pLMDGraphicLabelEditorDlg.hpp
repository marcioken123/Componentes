// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDGraphicLabelEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdgraphiclabeleditordlgHPP
#define PlmdgraphiclabeleditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.TabNotBk.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <pLMDCPGetMain.hpp>
#include <LMDCustomColorComboBox.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDCustomGraphicLabel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDSimplePanel.hpp>
#include <LMDGraphicLabel.hpp>
#include <LMDSimpleLabel.hpp>
#include <LMDFontComboBox.hpp>
#include <LMDFontSizeComboBox.hpp>
#include <LMDColorComboBox.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDCustomControl.hpp>
#include <LMDButtonControl.hpp>
#include <LMDCustomCheckBox.hpp>
#include <LMDCheckBox.hpp>
#include <LMDCustomButton.hpp>
#include <LMDButton.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDSpinEdit.hpp>
#include <LMDControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDThemes.hpp>
#include <LMDThemedComboBox.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdgraphiclabeleditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFormGraphicLabelEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFormGraphicLabelEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Dialogs::TFontDialog* FontDialog;
	Lmdsimplepanel::TLMDSimplePanel* LMDSPCarryAll;
	Vcl::Comctrls::TPageControl* TabbedNotebookProperties;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel7;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel8;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel9;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel10;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel11;
	Lmdspinedit::TLMDSpinEdit* LMDSpinEditAngle;
	Lmdspinedit::TLMDSpinEdit* LMDSpinEditLightDepth;
	Lmdspinedit::TLMDSpinEdit* LMDSpinEditShadowDepth;
	Lmdspinedit::TLMDSpinEdit* LMDSpinEditTracing;
	Vcl::Stdctrls::TComboBox* ComboBoxStyle;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel4;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel5;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel6;
	Lmdfontcombobox::TLMDFontComboBox* LMDFontComboBox;
	Lmdcolorcombobox::TLMDColorComboBox* LMDColorComboBox;
	Lmdfontsizecombobox::TLMDFontSizeComboBox* LMDFontSizeComboBox;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel1;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel2;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel3;
	Lmdspinedit::TLMDSpinEdit* LMDSpinEditToggle;
	Lmdspinedit::TLMDSpinEdit* LMDSpinEditPerspectiveDepth;
	Vcl::Stdctrls::TComboBox* ComboBoxPerspective;
	Lmdsimplepanel::TLMDSimplePanel* LMDSPCarryControls;
	Vcl::Stdctrls::TComboBox* ComboBoxTransform;
	Vcl::Stdctrls::TLabel* Label1;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel12;
	Lmdspinedit::TLMDSpinEdit* LMDSpinEditFactor;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel13;
	Lmdcolorcombobox::TLMDColorComboBox* LMDLightColorComboBox;
	Lmdcolorcombobox::TLMDColorComboBox* LMDShadowColorComboBox;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel14;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel15;
	Lmdgraphiclabel::TLMDGraphicLabel* LMDGraphicLabel;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Comctrls::TTabSheet* TabSheet4;
	Lmdbutton::TLMDButton* LMDButton1;
	Lmdbutton::TLMDButton* LMDButton2;
	Lmdbutton::TLMDButton* ButtonFillObjectDialog;
	Lmdbutton::TLMDButton* ButtonFontDialog;
	Lmdcheckbox::TLMDCheckBox* CheckBoxEqualLetters;
	Lmdcheckbox::TLMDCheckBox* CheckBoxAutoToggle;
	Lmdcheckbox::TLMDCheckBox* CheckBoxToggled;
	void __fastcall ButtonFontDialogClick(System::TObject* Sender);
	void __fastcall LMDFontComboBoxChange(System::TObject* Sender);
	void __fastcall LMDColorComboBoxChange(System::TObject* Sender);
	void __fastcall LMDFontSizeComboBoxChange(System::TObject* Sender);
	void __fastcall CheckBoxAutoToggleClick(System::TObject* Sender);
	void __fastcall CheckBoxToggledClick(System::TObject* Sender);
	void __fastcall CheckBoxEqualLettersClick(System::TObject* Sender);
	void __fastcall ComboBoxPerspectiveChange(System::TObject* Sender);
	void __fastcall LMDSpinEditPerspectiveDepthChange(System::TObject* Sender);
	void __fastcall LMDSpinEditToggleChange(System::TObject* Sender);
	void __fastcall LMDSpinEditLightDepthChange(System::TObject* Sender);
	void __fastcall LMDSpinEditShadowDepthChange(System::TObject* Sender);
	void __fastcall LMDSpinEditAngleChange(System::TObject* Sender);
	void __fastcall LMDSpinEditTracingChange(System::TObject* Sender);
	void __fastcall ComboBoxStyleChange(System::TObject* Sender);
	void __fastcall LMDSpinEditFactorChange(System::TObject* Sender);
	void __fastcall ComboBoxTransformChange(System::TObject* Sender);
	void __fastcall SetValue(Lmdgraphiclabel::TLMDGraphicLabel* Value);
	void __fastcall LMDLightColorComboBoxChange(System::TObject* Sender);
	void __fastcall LMDShadowColorComboBoxChange(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDFormGraphicLabelEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDFormGraphicLabelEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDFormGraphicLabelEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFormGraphicLabelEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdgraphiclabeleditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDGRAPHICLABELEDITORDLG)
using namespace Plmdgraphiclabeleditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdgraphiclabeleditordlgHPP
