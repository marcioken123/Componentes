// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDToolBarEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdtoolbareditordlgHPP
#define PlmdtoolbareditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDSimplePanel.hpp>
#include <LMDControl.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDButtonPanel.hpp>
#include <LMDCustomToolBar.hpp>
#include <LMDToolBar.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDPNGImageList.hpp>
#include <LMDCustomScrollBox.hpp>
#include <LMDScrollBox.hpp>
#include <LMDBaseControl.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDSpeedButton.hpp>
#include <LMDPanelFill.hpp>
#include <LMDDrawEdge.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDIniCtrl.hpp>
#include <LMDVistaDialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDCustomButton.hpp>
#include <LMDDockButton.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDSpinEdit.hpp>
#include <LMDButton.hpp>
#include <LMDThemedComboBox.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDComboBox.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDGraphicList.hpp>
#include <LMDBitmapList.hpp>
#include <LMDImageList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdtoolbareditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDToolBarEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDToolBarEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdsimplepanel::TLMDSimplePanel* pnlEditTools;
	Lmdsimplepanel::TLMDSimplePanel* pnlOkCancel;
	Lmdpngimagelist::TLMDPNGImageList* pngImageList;
	Vcl::Forms::TScrollBox* sbx;
	Lmdbuttonpanel::TLMDButtonPanel* bpImages;
	Lmdspeedbutton::TLMDSpeedButton* sbAddButton;
	Lmdspeedbutton::TLMDSpeedButton* sbAddSeparator;
	Lmdspeedbutton::TLMDSpeedButton* sbEditSeparatorFill;
	Lmdspeedbutton::TLMDSpeedButton* sbEditToolBarFill;
	Lmdtoolbar::TLMDToolBar* tb;
	Lmdinictrl::TLMDIniCtrl* IniCtrl;
	Lmdvistadialogs::TLMDFileOpenDialog* OpenDialog;
	Lmdspeedbutton::TLMDSpeedButton* sbEditBevel;
	Lmddrawedge::TLMDDrawEdge* LMDDrawEdge1;
	Lmddrawedge::TLMDDrawEdge* LMDDrawEdge2;
	Lmddrawedge::TLMDDrawEdge* LMDDrawEdge3;
	Lmdspeedbutton::TLMDSpeedButton* spbMakeFirst;
	Lmdspeedbutton::TLMDSpeedButton* spbMoveRight;
	Lmdspeedbutton::TLMDSpeedButton* spbMoveLeft;
	Lmdspeedbutton::TLMDSpeedButton* spbMakeLast;
	Lmdspinedit::TLMDSpinEdit* speButtonMargin;
	Vcl::Stdctrls::TLabel* Label1;
	Lmdspinedit::TLMDSpinEdit* speButtonW;
	Lmdspinedit::TLMDSpinEdit* speButtonH;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Lmdspeedbutton::TLMDSpeedButton* sbLoadGlyFX;
	Lmdspeedbutton::TLMDSpeedButton* sbLoadPack1;
	Lmdspeedbutton::TLMDSpeedButton* sbLoadPack2;
	Lmdbutton::TLMDButton* btnOk;
	Lmdbutton::TLMDButton* btnCancel;
	Lmdcombobox::TLMDComboBox* cbThemeMode;
	Vcl::Stdctrls::TLabel* Label4;
	Lmdcombobox::TLMDComboBox* cbBtnStyle;
	Vcl::Stdctrls::TLabel* Label5;
	Lmdspeedbutton::TLMDSpeedButton* spbRemove;
	Lmdspeedbutton::TLMDSpeedButton* spbClear;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall sbxResize(System::TObject* Sender);
	void __fastcall bpImagesButtonClick(System::TObject* Sender, System::TObject* SendBtn, int Btn);
	void __fastcall sbAddButtonClick(System::TObject* Sender);
	void __fastcall sbAddSeparatorClick(System::TObject* Sender);
	void __fastcall tbButtonClick(System::TObject* Sender, System::TObject* SendBtn, int Btn);
	void __fastcall sbEditSeparatorFillClick(System::TObject* Sender);
	void __fastcall sbEditToolBarFillClick(System::TObject* Sender);
	void __fastcall sbLoadGlyFXClick(System::TObject* Sender);
	void __fastcall LoadImages(void);
	void __fastcall sbLoadPack1Click(System::TObject* Sender);
	void __fastcall sbEditBevelClick(System::TObject* Sender);
	void __fastcall spbMakeFirstClick(System::TObject* Sender);
	void __fastcall speButtonMarginChange(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall speButtonWChange(System::TObject* Sender);
	void __fastcall speButtonHChange(System::TObject* Sender);
	void __fastcall cbThemeModeChange(System::TObject* Sender);
	void __fastcall cbBtnStyleChange(System::TObject* Sender);
	void __fastcall spbRemoveClick(System::TObject* Sender);
	void __fastcall spbClearClick(System::TObject* Sender);
	void __fastcall btnCancelClick(System::TObject* Sender);
	
private:
	Lmdcustomtoolbar::TLMDToolButton* cbutton;
	int oldimgcount;
	void __fastcall UpdateEditFields(void);
	Vcl::Imglist::TCustomImageList* __fastcall GetImgList(void);
	
public:
	void __fastcall FillGlyphButtonBar(void);
	__property Lmdtoolbar::TLMDToolBar* ToolBar = {read=tb};
	__property Vcl::Imglist::TCustomImageList* ToolbarImgList = {read=GetImgList};
	__property Lmdbuttonpanel::TLMDButtonPanel* ImagePack = {read=bpImages};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDToolBarEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDToolBarEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDToolBarEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDToolBarEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDToolBarEditorDlg* LMDToolBarEditorDlg;
}	/* namespace Plmdtoolbareditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDTOOLBAREDITORDLG)
using namespace Plmdtoolbareditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdtoolbareditordlgHPP
