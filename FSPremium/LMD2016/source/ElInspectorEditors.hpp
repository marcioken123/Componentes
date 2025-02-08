// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElInspectorEditors.pas' rev: 31.00 (Windows)

#ifndef ElinspectoreditorsHPP
#define ElinspectoreditorsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <System.TypInfo.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDTypes.hpp>
#include <LMDUtils.hpp>
#include <ElTree.hpp>
#include <ElEdits.hpp>
#include <ElInspector.hpp>
#include <ElSpin.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElTreeStdEditors.hpp>
#include <ElTreeColorCombo.hpp>
#include <ElTreeDTPickEdit.hpp>
#include <ElTreeComboBox.hpp>
#include <ElTreeCurrEdit.hpp>
#include <ElTreeMaskEdit.hpp>
#include <ElTreeMemoComboEdit.hpp>
#include <ElTreeMemoEdit.hpp>
#include <ElTreeModalEdit.hpp>
#include <ElTreeSpinEdit.hpp>
#include <ElTreeBtnEdit.hpp>
#include <ElClrCmb.hpp>
#include <ElCapPropDlg.hpp>
#include <ElPictPropDlg.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDObjectList.hpp>
#include <ElXPThemedControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elinspectoreditors
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElInspectorProxy;
class DELPHICLASS TElInspectorInplaceManager;
class DELPHICLASS TElHelperEditor;
class DELPHICLASS TElInspectorInplaceColorCombo;
class DELPHICLASS TElInspectorInplaceComboBox;
class DELPHICLASS TElInspectorInplaceSpinEdit;
class DELPHICLASS TElInspectorInplaceFloatSpinEdit;
class DELPHICLASS TElInspectorInplaceEdit;
class DELPHICLASS TElInspectorInplaceButtonEdit;
class DELPHICLASS TElInspectorInplaceStringsEdit;
class DELPHICLASS TElInspectorInplaceFontEdit;
class DELPHICLASS TElInspectorInplacePictureEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElInspectorProxy : public Elinspector::TCustomElInspector
{
	typedef Elinspector::TCustomElInspector inherited;
	
public:
	/* TCustomElInspector.Create */ inline __fastcall virtual TElInspectorProxy(System::Classes::TComponent* AOwner) : Elinspector::TCustomElInspector(AOwner) { }
	/* TCustomElInspector.Destroy */ inline __fastcall virtual ~TElInspectorProxy(void) { }
	
public:
	/* TCustomElTree.CreateClass */ inline __fastcall TElInspectorProxy(System::Classes::TComponent* AOwner, Eltree::TElTreeItemClass ItemClass) : Elinspector::TCustomElInspector(AOwner, ItemClass) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElInspectorProxy(HWND ParentWindow) : Elinspector::TCustomElInspector(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElInspectorInplaceManager : public Eltreeinplaceeditors::TElTreeInplaceManager
{
	typedef Eltreeinplaceeditors::TElTreeInplaceManager inherited;
	
public:
	HIDESBASE Eltreeinplaceeditors::TElTreeInplaceEditor* __fastcall GetSuitableEditor(System::TClass AEditorClass);
public:
	/* TElTreeInplaceManager.Create */ inline __fastcall virtual TElInspectorInplaceManager(System::Classes::TComponent* AOwner) : Eltreeinplaceeditors::TElTreeInplaceManager(AOwner) { }
	/* TElTreeInplaceManager.Destroy */ inline __fastcall virtual ~TElInspectorInplaceManager(void) { }
	
};


class PASCALIMPLEMENTATION TElHelperEditor : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Eltreeinplaceeditors::TElTreeInplaceEditor* FOwner;
	bool FRebuild;
	Eledits::TCustomElEdit* Editor;
	System::Classes::TWndMethod OldEditorProc;
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	
protected:
	void __fastcall DoAfterOperation(void);
	void __fastcall DoBeforeOpeation(void);
	void __fastcall AssignValue(void);
	
public:
	__fastcall TElHelperEditor(Eltreeinplaceeditors::TElTreeInplaceEditor* AOwner, Eledits::TCustomElEdit* const AEditor);
	__fastcall virtual ~TElHelperEditor(void);
};


class PASCALIMPLEMENTATION TElInspectorInplaceColorCombo : public Eltreecolorcombo::TElTreeInplaceColorCombo
{
	typedef Eltreecolorcombo::TElTreeInplaceColorCombo inherited;
	
private:
	TElHelperEditor* FElHelper;
	
protected:
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	void __fastcall TriggerChange(System::TObject* Sender);
	
public:
	__fastcall virtual TElInspectorInplaceColorCombo(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElInspectorInplaceColorCombo(void);
};


class PASCALIMPLEMENTATION TElInspectorInplaceComboBox : public Eltreecombobox::TElTreeInplaceComboBox
{
	typedef Eltreecombobox::TElTreeInplaceComboBox inherited;
	
private:
	TElHelperEditor* FElHelper;
	
protected:
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	void __fastcall TriggerChange(System::TObject* Sender);
	
public:
	__fastcall virtual TElInspectorInplaceComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElInspectorInplaceComboBox(void);
	virtual void __fastcall TriggerValidateResult(bool &InputValid);
};


class PASCALIMPLEMENTATION TElInspectorInplaceSpinEdit : public Eltreespinedit::TElTreeInplaceSpinEdit
{
	typedef Eltreespinedit::TElTreeInplaceSpinEdit inherited;
	
private:
	TElHelperEditor* FElHelper;
	
protected:
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	
public:
	__fastcall virtual TElInspectorInplaceSpinEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElInspectorInplaceSpinEdit(void);
	virtual void __fastcall TriggerValidateResult(bool &InputValid);
};


class PASCALIMPLEMENTATION TElInspectorInplaceFloatSpinEdit : public Eltreespinedit::TElTreeInplaceFloatSpinEdit
{
	typedef Eltreespinedit::TElTreeInplaceFloatSpinEdit inherited;
	
private:
	TElHelperEditor* FElHelper;
	
protected:
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	
public:
	__fastcall virtual TElInspectorInplaceFloatSpinEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElInspectorInplaceFloatSpinEdit(void);
	virtual void __fastcall TriggerValidateResult(bool &InputValid);
};


class PASCALIMPLEMENTATION TElInspectorInplaceEdit : public Eltreestdeditors::TElTreeInplaceEdit
{
	typedef Eltreestdeditors::TElTreeInplaceEdit inherited;
	
private:
	TElHelperEditor* FElHelper;
	
protected:
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	
public:
	__fastcall virtual TElInspectorInplaceEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElInspectorInplaceEdit(void);
};


class PASCALIMPLEMENTATION TElInspectorInplaceButtonEdit : public Eltreebtnedit::TElTreeInplaceButtonEdit
{
	typedef Eltreebtnedit::TElTreeInplaceButtonEdit inherited;
	
private:
	TElHelperEditor* FElHelper;
	
protected:
	virtual void __fastcall BtnClick(System::TObject* Sender);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	
public:
	__fastcall virtual TElInspectorInplaceButtonEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElInspectorInplaceButtonEdit(void);
	virtual void __fastcall TriggerValidateResult(bool &InputValid);
};


class PASCALIMPLEMENTATION TElInspectorInplaceStringsEdit : public Eltreebtnedit::TElTreeInplaceButtonEdit
{
	typedef Eltreebtnedit::TElTreeInplaceButtonEdit inherited;
	
protected:
	void __fastcall BtnClick(System::TObject* Sender);
	
public:
	__fastcall virtual TElInspectorInplaceStringsEdit(System::Classes::TComponent* AOwner);
public:
	/* TElTreeInplaceButtonEdit.Destroy */ inline __fastcall virtual ~TElInspectorInplaceStringsEdit(void) { }
	
};


class PASCALIMPLEMENTATION TElInspectorInplaceFontEdit : public Eltreebtnedit::TElTreeInplaceButtonEdit
{
	typedef Eltreebtnedit::TElTreeInplaceButtonEdit inherited;
	
protected:
	void __fastcall BtnClick(System::TObject* Sender);
	
public:
	__fastcall virtual TElInspectorInplaceFontEdit(System::Classes::TComponent* AOwner);
public:
	/* TElTreeInplaceButtonEdit.Destroy */ inline __fastcall virtual ~TElInspectorInplaceFontEdit(void) { }
	
};


class PASCALIMPLEMENTATION TElInspectorInplacePictureEdit : public Eltreebtnedit::TElTreeInplaceButtonEdit
{
	typedef Eltreebtnedit::TElTreeInplaceButtonEdit inherited;
	
protected:
	void __fastcall BtnClick(System::TObject* Sender);
	
public:
	__fastcall virtual TElInspectorInplacePictureEdit(System::Classes::TComponent* AOwner);
public:
	/* TElTreeInplaceButtonEdit.Destroy */ inline __fastcall virtual ~TElInspectorInplacePictureEdit(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Elinspector::TElInspectorClassesList* ElRegisteredEditors;
}	/* namespace Elinspectoreditors */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELINSPECTOREDITORS)
using namespace Elinspectoreditors;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElinspectoreditorsHPP
