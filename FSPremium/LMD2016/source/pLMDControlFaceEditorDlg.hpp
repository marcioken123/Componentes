// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDControlFaceEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdcontrolfaceeditordlgHPP
#define PlmdcontrolfaceeditordlgHPP

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
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDCFCStateObject.hpp>
#include <LMDCustomListBox.hpp>
#include <LMDCustomImageListBox.hpp>
#include <LMDCustomCheckListBox.hpp>
#include <LMDCheckListBox.hpp>
#include <Vcl.Menus.hpp>
#include <LMDBaseController.hpp>
#include <LMDCustomContainer.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDImageListConnector.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDFaceController.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDSpeedButton.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomExtCombo.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDSimpleLabel.hpp>
#include <LMDCustomScrollBox.hpp>
#include <LMDScrollBox.hpp>
#include <LMDSplt.hpp>
#include <LMDCustomButton.hpp>
#include <LMDButton.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDSimplePanel.hpp>
#include <LMDImageList.hpp>
#include <LMDCustomBrowseEdit.hpp>
#include <LMDBrowseEdit.hpp>
#include <LMDIniCtrl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDControl.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdcontrolfaceeditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmLMDControlFaceComponentEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrmLMDControlFaceComponentEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdsimplepanel::TLMDSimplePanel* dialogPanel;
	Lmdfacecontroller::TLMDFaceController* EditFaceController;
	Lmdimagelistconnector::TLMDImageListConnector* ImgCon;
	Vcl::Controls::TImageList* settingObjectsPics;
	Vcl::Menus::TPopupMenu* PopupMenu1;
	Vcl::Menus::TMenuItem* mnuAddState;
	Lmdsplt::TLMDSplitterPanel* SplitterPanel;
	Lmdsplt::TLMDSplitterPane* LMDSplitterPane5;
	Lmdsplt::TLMDSplitterPane* LMDSplitterPane6;
	Lmdsimplepanel::TLMDSimplePanel* LMDSimplePanel2;
	Lmdsimplepanel::TLMDSimplePanel* statesHeaderPanel;
	Lmdsimplepanel::TLMDSimplePanel* LMDSimplePanel3;
	Lmdchecklistbox::TLMDCheckListBox* controllerStateList;
	Lmdsplt::TLMDSplitterPane* LMDSplitterPane1;
	Lmdsimplepanel::TLMDSimplePanel* stateObjectInfoPanel;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel3;
	Vcl::Comctrls::TListView* stateObjectList;
	Lmdimagelist::TLMDImageList* LMDImageList1;
	Lmdspeedbutton::TLMDSpeedButton* btnLoad;
	Lmdspeedbutton::TLMDSpeedButton* btnSave;
	Lmdspeedbutton::TLMDSpeedButton* btnAddState;
	Lmdspeedbutton::TLMDSpeedButton* remove;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel1;
	Lmdspeedbutton::TLMDSpeedButton* clear;
	Lmdsimplepanel::TLMDSimplePanel* objectsEditPanel;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel4;
	Lmdspeedbutton::TLMDSpeedButton* LMDSpeedButton1;
	Lmdspeedbutton::TLMDSpeedButton* LMDSpeedButton2;
	Lmdspeedbutton::TLMDSpeedButton* LMDSpeedButton3;
	Lmdspeedbutton::TLMDSpeedButton* LMDSpeedButton4;
	Lmdspeedbutton::TLMDSpeedButton* btnProp;
	Lmdspeedbutton::TLMDSpeedButton* LMDSpeedButton5;
	Lmdspeedbutton::TLMDSpeedButton* LMDSpeedButton6;
	Lmdspeedbutton::TLMDSpeedButton* LMDSpeedButton7;
	Lmdspeedbutton::TLMDSpeedButton* LMDSpeedButton8;
	Lmdspeedbutton::TLMDSpeedButton* LMDSpeedButton9;
	Lmdspeedbutton::TLMDSpeedButton* LMDSpeedButton10;
	Vcl::Comctrls::TListView* controllerObjectsList;
	Vcl::Menus::TMenuItem* mnuProperties;
	Vcl::Menus::TPopupMenu* popMnuStateObjects;
	Vcl::Menus::TMenuItem* Edit1;
	Vcl::Menus::TMenuItem* mnuRemove;
	Vcl::Stdctrls::TButton* LMDButton3;
	Vcl::Stdctrls::TButton* LMDButton4;
	Lmdinictrl::TLMDIniCtrl* ini;
	Lmdbrowseedit::TLMDBrowseEdit* FEdit;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Dialogs::TOpenDialog* odlg;
	Vcl::Dialogs::TSaveDialog* sdlg;
	Lmdspeedbutton::TLMDSpeedButton* LMDSpeedButton11;
	Lmdspeedbutton::TLMDSpeedButton* LMDSpeedButton13;
	void __fastcall controllerStateListClick(System::TObject* Sender);
	void __fastcall stateObjectListDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall stateObjectListDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall btnAddObject(System::TObject* Sender);
	void __fastcall btnStateClick(System::TObject* Sender);
	void __fastcall mnuAddStateClick(System::TObject* Sender);
	void __fastcall btnObjectClick(System::TObject* Sender);
	void __fastcall controllerObjectsListKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall controllerObjectsListEdited(System::TObject* Sender, Vcl::Comctrls::TListItem* Item, System::UnicodeString &S);
	void __fastcall stateObjectListDblClick(System::TObject* Sender);
	void __fastcall PopupMenu1Popup(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	System::Classes::TStringList* FUsedStates;
	void __fastcall getAddInfo(Vcl::Comctrls::TListItem* l);
	void __fastcall updateControllerObjectList(void);
	void __fastcall updateStateList(void);
	void __fastcall updateStateObjectList(void);
	void __fastcall BuildStateList(Lmdcfcstateobject::TLMDStateKind bs, System::UnicodeString s, System::Classes::TStringList* sl);
	
public:
	void __fastcall Edit(Lmdfacecontroller::TLMDFaceController* aFaceController)/* overload */;
	void __fastcall Edit(Lmdcfcstateobject::TLMDCFCStateObjects* aFaceStatesCollection)/* overload */;
	Lmdfacecontroller::TLMDFaceController* __fastcall FaceController(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmLMDControlFaceComponentEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmLMDControlFaceComponentEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmLMDControlFaceComponentEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmLMDControlFaceComponentEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrmLMDControlFaceComponentEditor* frmLMDControlFaceComponentEditor;
}	/* namespace Plmdcontrolfaceeditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCONTROLFACEEDITORDLG)
using namespace Plmdcontrolfaceeditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdcontrolfaceeditordlgHPP
