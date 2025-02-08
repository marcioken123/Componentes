// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElStyleManProp.pas' rev: 31.00 (Windows)

#ifndef PlmdelstylemanpropHPP
#define PlmdelstylemanpropHPP

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
#include <Vcl.Dialogs.hpp>
#include <DesignEditors.hpp>
#include <DesignWindows.hpp>
#include <DsnConst.hpp>
#include <DesignIntf.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDTypes.hpp>
#include <pLMDCst.hpp>
#include <ElIni.hpp>
#include <LMDStrings.hpp>
#include <ElFrmPers.hpp>
#include <ElXPThemedControl.hpp>
#include <ElEdits.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDUnicode.hpp>
#include <pLMDElStyleImageSelect.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <LMDProcs.hpp>
#include <ElHeader.hpp>
#include <ElInputDlg.hpp>
#include <ElClrCmb.hpp>
#include <ElTreeStdEditors.hpp>
#include <ElPromptDlg.hpp>
#include <ElStyleMan.hpp>
#include <Vcl.Buttons.hpp>
#include <ElVCLUtils.hpp>
#include <ElTree.hpp>
#include <ElTreeGrids.hpp>
#include <ElPopBtn.hpp>
#include <ElToolBar.hpp>
#include <ElPanel.hpp>
#include <ElCombos.hpp>
#include <ElBtnCtl.hpp>
#include <ElCLabel.hpp>
#include <ElLabel.hpp>
#include <ElSplit.hpp>
#include <ElTreeComboBox.hpp>
#include <ElTreeDTPickEdit.hpp>
#include <ElTreeMemoEdit.hpp>
#include <ElTreeSpinEdit.hpp>
#include <ElTreeBtnEdit.hpp>
#include <ElTreeColorCombo.hpp>
#include <ElTreeTreeComboEdit.hpp>
#include <ElComponent.hpp>
#include <ElCGControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelstylemanprop
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmLMDElStyleManProp;
class DELPHICLASS TElStyleManEditor;
class DELPHICLASS TElPropListItem;
class DELPHICLASS TElPropListCollection;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrmLMDElStyleManProp : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Elpanel::TElPanel* Panel1;
	Vcl::Dialogs::TOpenDialog* OpenDialog;
	Vcl::Dialogs::TSaveDialog* SaveDialog;
	Eltoolbar::TElToolBar* ElToolBar1;
	Eltoolbar::TElToolButton* btnLoadFromFile;
	Elpopbtn::TElPopupButton* OkButton;
	Elpopbtn::TElPopupButton* CancelButton;
	Eltoolbar::TElToolButton* btnSaveToFile;
	Eltoolbar::TElToolButton* ElToolButton3;
	Eltoolbar::TElToolButton* btnAddStyle;
	Eltoolbar::TElToolButton* btnAddProp;
	Eltoolbar::TElToolButton* btnDelete;
	Eltoolbar::TElToolButton* ElToolButton7;
	Elpanel::TElPanel* LeftPanel;
	Elsplit::TElSplitter* ElSplitter1;
	Eltreegrids::TElTreeStringGrid* gridProps;
	Elpanel::TElPanel* ElPanel2;
	Eltreegrids::TElTreeStringGrid* gridStyles;
	Ellabel::TElLabel* ElLabel1;
	Ellabel::TElLabel* ElLabel2;
	Eltreecombobox::TElTreeInplaceComboBox* inpComboEnum;
	Eltreecombobox::TElTreeInplaceComboBox* inpComboBoolean;
	Eltreestdeditors::TElTreeInplaceEdit* inpEditText;
	Eltreespinedit::TElTreeInplaceSpinEdit* inpEditInt;
	Eltreespinedit::TElTreeInplaceFloatSpinEdit* inpEditFloat;
	Eltreecolorcombo::TElTreeInplaceColorCombo* inpComboColor;
	Eltreetreecomboedit::TElTreeInplaceTreeComboEdit* inpComboSet;
	Elfrmpers::TElFormPersist* ElFormPersist1;
	Elini::TElIniFile* ElIniFile1;
	Eltreebtnedit::TElTreeInplaceButtonEdit* inpEditImage;
	Eltreedtpickedit::TElTreeInplaceDateTimePicker* inpDTPick;
	Elpopbtn::TElPopupButton* ElPopupButton1;
	Vcl::Extctrls::TPanel* Panel2;
	Eledits::TElEdit* ElEdit1;
	void __fastcall LoadClick(System::TObject* Sender);
	void __fastcall SaveClick(System::TObject* Sender);
	void __fastcall gridPropsItemFocused(System::TObject* Sender);
	void __fastcall gridStylesItemFocused(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall gridPropsDblClick(System::TObject* Sender);
	void __fastcall btnAddPropClick(System::TObject* Sender);
	void __fastcall btnDeleteClick(System::TObject* Sender);
	void __fastcall inpComboBooleanBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpComboBooleanAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall inpComboColorAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall inpComboColorBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpDTPickAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall inpDTPickBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpEditFloatBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpEditFloatAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall inpEditIntBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpEditIntAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall inpEditTextBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpEditTextAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall inpComboEnumAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall inpComboEnumBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpComboSetBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpComboSetAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall btnAddStyleClick(System::TObject* Sender);
	void __fastcall inpEditImageBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall inpEditImageAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	void __fastcall ImageButtonClick(System::TObject* Sender);
	void __fastcall gridStylesCompareItems(System::TObject* Sender, Eltree::TElTreeItem* Item1, Eltree::TElTreeItem* Item2, int &res);
	void __fastcall gridStylesInplaceEditorNeeded(System::TObject* Sender, Eltree::TElTreeItem* Item, int SectionIndex, Elheader::TElFieldType SupposedFieldType, Eltreeinplaceeditors::TElTreeInplaceEditor* &Editor);
	void __fastcall ElPopupButton1Click(System::TObject* Sender);
	void __fastcall ElEdit1KeyPress(System::TObject* Sender, System::WideChar &Key);
	
private:
	Elstyleman::TElStyleManager* FStyleManager;
	Elstyleman::TElStyleManager* FSM;
	System::Classes::TStringList* SL;
	Eltree::TElTreeItem* RootStyleItem;
	System::Classes::TMemoryStream* ImageStream;
	
protected:
	void __fastcall AddProperty(void);
	System::UnicodeString __fastcall GetDisplayValue(System::UnicodeString StyleName, TElPropListItem* Item);
	void __fastcall inpComboSetItemChecked(System::TObject* Sender, Eltree::TElTreeItem* Item);
	void __fastcall UpdateButtons(void);
	
public:
	void __fastcall SetData(Elstyleman::TElStyleManager* StyleManager);
	void __fastcall GetData(Elstyleman::TElStyleManager* StyleManager);
	void __fastcall SetDataFromStyles(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmLMDElStyleManProp(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmLMDElStyleManProp(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmLMDElStyleManProp(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmLMDElStyleManProp(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElStyleManEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TElStyleManEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TElStyleManEditor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElPropListItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
protected:
	System::UnicodeString FPropertyName;
	System::TTypeKind FTypeKind;
	System::UnicodeString FTypeName;
	System::UnicodeString FAClassName;
	
public:
	__property System::UnicodeString PropertyName = {read=FPropertyName, write=FPropertyName};
	__property System::TTypeKind TypeKind = {read=FTypeKind, write=FTypeKind, nodefault};
	__property System::UnicodeString TypeName = {read=FTypeName, write=FTypeName};
	__property System::UnicodeString AClassName = {read=FAClassName, write=FAClassName};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TElPropListItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TElPropListItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElPropListCollection : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TElPropListItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TStringList* FExclusions;
	
protected:
	TElPropListItem* __fastcall GetItems(int Index);
	void __fastcall SetItems(int Index, TElPropListItem* Value);
	bool __fastcall PropertyExcluded(System::UnicodeString PropName);
	
public:
	HIDESBASE TElPropListItem* __fastcall Add(void);
	__fastcall TElPropListCollection(void);
	TElPropListItem* __fastcall FindItemByName(const System::UnicodeString Name);
	__fastcall virtual ~TElPropListCollection(void);
	void __fastcall ExcludeProperty(System::UnicodeString PropName);
	__property TElPropListItem* Items[int Index] = {read=GetItems, write=SetItems/*, default*/};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TElPropListCollection* PropList;
extern DELPHI_PACKAGE void __fastcall RegisterStyleMgrClass(System::Classes::TPersistentClass AnObject, System::UnicodeString Prefix);
}	/* namespace Plmdelstylemanprop */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELSTYLEMANPROP)
using namespace Plmdelstylemanprop;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelstylemanpropHPP
