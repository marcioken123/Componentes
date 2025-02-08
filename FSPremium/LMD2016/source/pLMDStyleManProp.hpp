// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDStyleManProp.pas' rev: 31.00 (Windows)

#ifndef PlmdstylemanpropHPP
#define PlmdstylemanpropHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <DesignWindows.hpp>
#include <DsnConst.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Buttons.hpp>
#include <pLMDCst.hpp>
#include <LMDCFCStateObject.hpp>
#include <LMDList.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDCustomGroupBox.hpp>
#include <LMDCustomButtonGroup.hpp>
#include <LMDCustomRadioGroup.hpp>
#include <LMDRadioGroup.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDBaseController.hpp>
#include <LMDContainerComponent.hpp>
#include <LMDBaseDialog.hpp>
#include <LMDInputDlg.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDSpeedButton.hpp>
#include <LMDSimplePanel.hpp>
#include <LMDHeader.hpp>
#include <LMDCustomHeaderPanel.hpp>
#include <LMDHeaderPanel.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDButtonControl.hpp>
#include <LMDCustomCheckBox.hpp>
#include <LMDCheckBox.hpp>
#include <LMDCustomContainer.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDBitmapList.hpp>
#include <LMDBackPanel.hpp>
#include <LMDCustomButton.hpp>
#include <LMDButton.hpp>
#include <LMDListComboBox.hpp>
#include <LMDColorComboBox.hpp>
#include <LMDCustomColorComboBox.hpp>
#include <LMDEdit.hpp>
#include <LMDSpinEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDExtSpinEdit.hpp>
#include <LMDCalendarComboBox.hpp>
#include <LMDCheckListComboBox.hpp>
#include <LMDCustomCheckListDlg.hpp>
#include <LMDCheckListDlg.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDControl.hpp>
#include <LMDClass.hpp>
#include <LMDStyleMan.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdstylemanprop
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmLMDStyleManProp;
class DELPHICLASS TLMDStyleManEditor;
class DELPHICLASS TLMDPropListItem;
class DELPHICLASS TLMDPropList;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDPropViewGrouping : unsigned char { pvgTypeName, pvgClassName };

class PASCALIMPLEMENTATION TfrmLMDStyleManProp : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Dialogs::TOpenDialog* OpenDialog;
	Vcl::Dialogs::TSaveDialog* SaveDialog;
	Vcl::Controls::TImageList* ImageList1;
	Lmdinputdlg::TLMDInputDlg* LMDInputDlg1;
	Vcl::Extctrls::TPanel* PropTreePanel;
	Vcl::Comctrls::TTreeView* PropTree;
	Vcl::Comctrls::TListView* PropView;
	Vcl::Extctrls::TSplitter* Splitter3;
	Vcl::Stdctrls::TLabel* Label1;
	Lmdradiogroup::TLMDRadioGroup* PVGrouping;
	Vcl::Extctrls::TPanel* TopPanel;
	Lmdspeedbutton::TLMDSpeedButton* bttLoadFromFile;
	Lmdspeedbutton::TLMDSpeedButton* btnSaveToFile;
	Lmdspeedbutton::TLMDSpeedButton* btnAddStyle;
	Vcl::Extctrls::TSplitter* Splitter4;
	Vcl::Extctrls::TPanel* StylesPanel;
	Vcl::Comctrls::TTreeView* Styles;
	Vcl::Comctrls::THeaderControl* HeaderControl;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Extctrls::TPanel* PreviewToolPanel;
	Vcl::Stdctrls::TLabel* Label2;
	Lmdcheckbox::TLMDCheckBox* cbCtlXp;
	Vcl::Extctrls::TBevel* Bevel1;
	Lmdcheckbox::TLMDCheckBox* cbAlign;
	Lmdbitmaplist::TLMDBitmapList* LMDBitmapList1;
	Lmdspeedbutton::TLMDSpeedButton* btnDeleteStyle;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TBevel* Bevel2;
	Lmdcheckbox::TLMDCheckBox* cbStateStyles;
	Lmdcheckbox::TLMDCheckBox* cbConfirmDeletion;
	Lmdbackpanel::TLMDBackPanel* PreviewPanel;
	Lmdcheckbox::TLMDCheckBox* cbUseBgr;
	Vcl::Extctrls::TPanel* BottomPanel;
	Vcl::Extctrls::TBevel* Bevel3;
	Lmdbutton::TLMDButton* btnOk;
	Lmdbutton::TLMDButton* btnCancel;
	Lmdcheckbox::TLMDCheckBox* cbCascade;
	Lmdspeedbutton::TLMDSpeedButton* btnAddComponent;
	Lmdchecklistdlg::TLMDCheckListDlg* LMDCheckListDlg1;
	Lmdspeedbutton::TLMDSpeedButton* btnCreateStyle;
	Vcl::Extctrls::TPanel* FilterPanel;
	Lmdedit::TLMDEdit* fltEdit;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall PVGroupingClick(System::TObject* Sender);
	void __fastcall PropTreeClick(System::TObject* Sender);
	void __fastcall StylesDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall StylesDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall StylesCompare(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node1, Vcl::Comctrls::TTreeNode* Node2, int Data, int &Compare);
	void __fastcall HeaderControlSectionResize(Vcl::Comctrls::THeaderControl* HeaderControl, Vcl::Comctrls::THeaderSection* Section);
	void __fastcall StylesAdvancedCustomDrawItem(Vcl::Comctrls::TCustomTreeView* Sender, Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage, bool &PaintImages, bool &DefaultDraw);
	void __fastcall StylesEditing(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, bool &AllowEdit);
	void __fastcall StylesClick(System::TObject* Sender);
	void __fastcall StylesDblClick(System::TObject* Sender);
	void __fastcall EditorControlKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall EditorControlExit(System::TObject* Sender);
	void __fastcall cbCtlXpClick(System::TObject* Sender);
	void __fastcall StylesMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall PropViewClick(System::TObject* Sender);
	void __fastcall cbAlignClick(System::TObject* Sender);
	void __fastcall bttLoadFromFileClick(System::TObject* Sender);
	void __fastcall btnSaveToFileClick(System::TObject* Sender);
	void __fastcall btnAddStyleClick(System::TObject* Sender);
	void __fastcall btnDeleteStyleClick(System::TObject* Sender);
	void __fastcall PreviewPanelResize(System::TObject* Sender);
	void __fastcall StylesKeyUp(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall PropTreeCustomDrawItem(Vcl::Comctrls::TCustomTreeView* Sender, Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, bool &DefaultDraw);
	void __fastcall PropTreeExpanding(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, bool &AllowExpansion);
	void __fastcall cbUseBgrClick(System::TObject* Sender);
	void __fastcall btnOkClick(System::TObject* Sender);
	void __fastcall StylesKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall cbStateStylesClick(System::TObject* Sender);
	void __fastcall cbCascadeClick(System::TObject* Sender);
	void __fastcall StylesEdited(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, System::UnicodeString &S);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall btnAddComponentClick(System::TObject* Sender);
	void __fastcall btnCreateStyleClick(System::TObject* Sender);
	void __fastcall fltEditKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall fltEditCustomButtons0Click(System::TObject* Sender, int index);
	void __fastcall fltEditChange(System::TObject* Sender);
	
private:
	System::Classes::TComponent* FOwnerForm;
	Lmdstyleman::TLMDStyleManager* FStyleManager;
	Vcl::Comctrls::TTreeNode* FDefStyleNode;
	Vcl::Controls::TControl* FEditorControl;
	Vcl::Controls::TControl* FPreviewControl;
	Vcl::Comctrls::TTreeNode* FEditingPropNode;
	Vcl::Comctrls::TTreeNode* FCurPropNode;
	bool FPropValueSaved;
	System::Classes::TShiftState FShiftState;
	System::UnicodeString FOldStyleName;
	
protected:
	void __fastcall AdjustPreviewControl(void);
	void __fastcall AddStateStyles(Vcl::Comctrls::TTreeNode* ATreeNode);
	void __fastcall ApplyStyleToPreviewControl(void);
	bool __fastcall AllSubStylesValid(Vcl::Comctrls::TTreeNode* ANode, System::UnicodeString &msg);
	void __fastcall BuildStylesTreeView(void);
	void __fastcall CreateEditorControl(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall DeleteStyleNode(void);
	void __fastcall FillPropTree(TLMDPropViewGrouping AGrouping);
	Vcl::Comctrls::TTreeNode* __fastcall FindNode(Vcl::Comctrls::TTreeView* ATreeView, System::UnicodeString ACaption, Vcl::Comctrls::TTreeNode* ANode = (Vcl::Comctrls::TTreeNode*)(0x0), int ALevel = 0xffffffff);
	Vcl::Comctrls::TTreeNode* __fastcall FindNodeByFullStyleName(Vcl::Comctrls::TTreeNode* AStartNode, System::UnicodeString AFullStyleName);
	System::UnicodeString __fastcall FindAncestorStyle(Vcl::Comctrls::TTreeNode* ANode);
	System::UnicodeString __fastcall GetDisplayValue(Vcl::Comctrls::TTreeNode* ANode);
	System::UnicodeString __fastcall GetFullPropName(Vcl::Comctrls::TTreeNode* ANode);
	int __fastcall GetSubStyleCount(Vcl::Comctrls::TTreeNode* ANode);
	System::UnicodeString __fastcall GetTypedFullPropName(Vcl::Comctrls::TTreeNode* ANode);
	System::Types::TRect __fastcall GetValueRect(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall ShowPreviewControl(System::UnicodeString AClassName);
	void __fastcall SavePropValue(void);
	void __fastcall SavePropsToStyle(System::TObject* AComponent, Vcl::Comctrls::TTreeNode* ANode, System::UnicodeString AStyleName);
	bool __fastcall IsNonGraphicClass(Vcl::Comctrls::TTreeNode* ANode)/* overload */;
	bool __fastcall IsNonGraphicClass(TLMDPropListItem* AItem)/* overload */;
	bool __fastcall IsValidStylePlacement(Vcl::Comctrls::TTreeNode* ANode, System::UnicodeString AStyleName, System::UnicodeString &Msg);
	
public:
	void __fastcall SetData(Lmdstyleman::TLMDStyleManager* StyleManager);
	void __fastcall GetData(Lmdstyleman::TLMDStyleManager* StyleManager);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmLMDStyleManProp(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmLMDStyleManProp(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmLMDStyleManProp(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmLMDStyleManProp(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStyleManEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TLMDStyleManEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDStyleManEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPropListItem : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	System::UnicodeString FPropertyName;
	System::TTypeKind FTypeKind;
	System::UnicodeString FTypeName;
	System::UnicodeString FAClassName;
	System::UnicodeString FContainerPropName;
	
public:
	__property System::UnicodeString PropertyName = {read=FPropertyName, write=FPropertyName};
	__property System::TTypeKind TypeKind = {read=FTypeKind, write=FTypeKind, nodefault};
	__property System::UnicodeString TypeName = {read=FTypeName, write=FTypeName};
	__property System::UnicodeString AClassName = {read=FAClassName, write=FAClassName};
	__property System::UnicodeString ContainerPropName = {read=FContainerPropName, write=FContainerPropName};
public:
	/* TObject.Create */ inline __fastcall TLMDPropListItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDPropListItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPropList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDPropListItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TStringList* FExclusions;
	System::Classes::TStringList* FProps;
	int __fastcall GetCount(void);
	
protected:
	TLMDPropListItem* __fastcall GetItems(int Index);
	void __fastcall SetItems(int Index, TLMDPropListItem* Value);
	
public:
	void __fastcall AddProperty(TLMDPropListItem* APropItem);
	__fastcall TLMDPropList(void);
	void __fastcall Clear(void);
	TLMDPropListItem* __fastcall FindItemByName(const System::UnicodeString AName);
	TLMDPropListItem* __fastcall FindItemByNameAndClassName(const System::UnicodeString AName, const System::UnicodeString AClassName, System::UnicodeString AContainerPropName = System::UnicodeString());
	TLMDPropListItem* __fastcall FindItemByNameAndTypeName(const System::UnicodeString AName, const System::UnicodeString ATypeName, System::UnicodeString AContainerPropName = System::UnicodeString());
	__fastcall virtual ~TLMDPropList(void);
	void __fastcall ExcludeProperty(System::UnicodeString PropName);
	__property TLMDPropListItem* Items[int Index] = {read=GetItems, write=SetItems/*, default*/};
	__property int Count = {read=GetCount, nodefault};
	__property System::Classes::TStringList* Props = {read=FProps};
	bool __fastcall PropertyExcluded(System::UnicodeString PropName);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDPropList* PropList;
extern DELPHI_PACKAGE void __fastcall RegisterStyleMgrClass(System::Classes::TPersistentClass AnObject, System::UnicodeString AContainerPropName);
}	/* namespace Plmdstylemanprop */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDSTYLEMANPROP)
using namespace Plmdstylemanprop;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdstylemanpropHPP
