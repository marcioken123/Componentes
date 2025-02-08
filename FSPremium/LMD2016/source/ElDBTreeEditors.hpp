// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDBTreeEditors.pas' rev: 31.00 (Windows)

#ifndef EldbtreeeditorsHPP
#define EldbtreeeditorsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDTypes.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Graphics.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <System.Types.hpp>
#include <ElStyleMan.hpp>
#include <ElTree.hpp>
#include <ElHeader.hpp>
#include <ElEdits.hpp>
#include <ElDBSpin.hpp>
#include <ElDBCurrEdit.hpp>
#include <LMDUnicodeStrings.hpp>
#include <ElCalc.hpp>
#include <ElDBXTree.hpp>
#include <ElDBTree.hpp>
#include <ElDBCtrls.hpp>
#include <ElDBDTPick.hpp>
#include <ElCombos.hpp>
#include <ElTreeCombo.hpp>
#include <ElDBWideLookupComboGrid.hpp>
#include <ElDBBoxes.hpp>
#include <ElCurrEdit.hpp>
#include <ElDBWideLookupControls.hpp>
#include <LMDElDBConst.hpp>
#include <LMDUnicode.hpp>
#include <LMDThemes.hpp>
#include <Vcl.Themes.hpp>
#include <System.Math.hpp>
#include <ElDBLookupCtrls.hpp>
#include <ElVCLUtils.hpp>
#include <LMDGraph.hpp>
#include <LMDUtils.hpp>
#include <ElDTPick.hpp>
#include <LMDProcs.hpp>
#include <LMDVldBase.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElBtnEdit.hpp>
#include <ElXPThemedControl.hpp>
#include <ElMaskEdit.hpp>
#include <Vcl.Mask.hpp>
#include <HTMLLbx.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldbtreeeditors
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THackTreeCombo;
class DELPHICLASS THackEditorCombo;
class DELPHICLASS THackElTree;
class DELPHICLASS THackElDBEdit;
class DELPHICLASS THackElWideDBEdit;
class DELPHICLASS THackDBInplaceCurrencyEdit;
class DELPHICLASS THackControl;
class DELPHICLASS THackDBComboBox;
class DELPHICLASS TElDBTreeLookupComboGridEdit;
class DELPHICLASS TElDBTreeLookupComboBoxEdit;
class DELPHICLASS TElDBTreeWideStringEdit;
class DELPHICLASS TElDBTreeSpinEdit;
class DELPHICLASS TElDBTreeFloatSpinEdit;
class DELPHICLASS TElWideDBTEdit;
class DELPHICLASS TElDBTreeEdit;
class DELPHICLASS TDBMemoForm;
class DELPHICLASS TElInpDBMemo;
class DELPHICLASS TElDBTreeMemoEdit;
class DELPHICLASS TElDBTreeCheckBoxEdit;
class DELPHICLASS TElDBTreeDateTimePickerEdit;
class DELPHICLASS TElDBTreeCurrencyEdit;
class DELPHICLASS TElDBTreeComboBoxEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION THackTreeCombo : public Eltreecombo::TCustomElTreeCombo
{
	typedef Eltreecombo::TCustomElTreeCombo inherited;
	
public:
	/* TCustomElTreeCombo.Create */ inline __fastcall virtual THackTreeCombo(System::Classes::TComponent* AOwner) : Eltreecombo::TCustomElTreeCombo(AOwner) { }
	/* TCustomElTreeCombo.Destroy */ inline __fastcall virtual ~THackTreeCombo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THackTreeCombo(HWND ParentWindow) : Eltreecombo::TCustomElTreeCombo(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION THackEditorCombo : public Elcombos::TCustomElComboBox
{
	typedef Elcombos::TCustomElComboBox inherited;
	
public:
	/* TCustomElComboBox.Create */ inline __fastcall virtual THackEditorCombo(System::Classes::TComponent* AOwner) : Elcombos::TCustomElComboBox(AOwner) { }
	/* TCustomElComboBox.Destroy */ inline __fastcall virtual ~THackEditorCombo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THackEditorCombo(HWND ParentWindow) : Elcombos::TCustomElComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION THackElTree : public Eldbtree::TElDBTree
{
	typedef Eldbtree::TElDBTree inherited;
	
__published:
	__property ExplorerEditMode = {default=0};
public:
	/* TCustomElDBTree.Create */ inline __fastcall virtual THackElTree(System::Classes::TComponent* AOwner) : Eldbtree::TElDBTree(AOwner) { }
	/* TCustomElDBTree.Destroy */ inline __fastcall virtual ~THackElTree(void) { }
	
public:
	/* TCustomElTree.CreateClass */ inline __fastcall THackElTree(System::Classes::TComponent* AOwner, Eltree::TElTreeItemClass ItemClass) : Eldbtree::TElDBTree(AOwner, ItemClass) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THackElTree(HWND ParentWindow) : Eldbtree::TElDBTree(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION THackElDBEdit : public Eldbctrls::TElDBEdit
{
	typedef Eldbctrls::TElDBEdit inherited;
	
public:
	/* TElDBEdit.Create */ inline __fastcall virtual THackElDBEdit(System::Classes::TComponent* AOwner) : Eldbctrls::TElDBEdit(AOwner) { }
	/* TElDBEdit.Destroy */ inline __fastcall virtual ~THackElDBEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THackElDBEdit(HWND ParentWindow) : Eldbctrls::TElDBEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION THackElWideDBEdit : public Eldbctrls::TElWideDBEdit
{
	typedef Eldbctrls::TElWideDBEdit inherited;
	
public:
	/* TElWideDBEdit.Create */ inline __fastcall virtual THackElWideDBEdit(System::Classes::TComponent* AOwner) : Eldbctrls::TElWideDBEdit(AOwner) { }
	/* TElWideDBEdit.Destroy */ inline __fastcall virtual ~THackElWideDBEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THackElWideDBEdit(HWND ParentWindow) : Eldbctrls::TElWideDBEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION THackDBInplaceCurrencyEdit : public Eldbcurredit::TElDBCurrencyEdit
{
	typedef Eldbcurredit::TElDBCurrencyEdit inherited;
	
public:
	/* TElDBCurrencyEdit.Create */ inline __fastcall virtual THackDBInplaceCurrencyEdit(System::Classes::TComponent* AOwner) : Eldbcurredit::TElDBCurrencyEdit(AOwner) { }
	/* TElDBCurrencyEdit.Destroy */ inline __fastcall virtual ~THackDBInplaceCurrencyEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THackDBInplaceCurrencyEdit(HWND ParentWindow) : Eldbcurredit::TElDBCurrencyEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION THackControl : public Vcl::Controls::TControl
{
	typedef Vcl::Controls::TControl inherited;
	
public:
	/* TControl.Create */ inline __fastcall virtual THackControl(System::Classes::TComponent* AOwner) : Vcl::Controls::TControl(AOwner) { }
	/* TControl.Destroy */ inline __fastcall virtual ~THackControl(void) { }
	
};


class PASCALIMPLEMENTATION THackDBComboBox : public Eldbboxes::TElDBComboBox
{
	typedef Eldbboxes::TElDBComboBox inherited;
	
protected:
	virtual void __fastcall ComboWndProc(Winapi::Messages::TMessage &Message, NativeUInt ComboWnd, void * ComboProc);
public:
	/* TElDBComboBox.Create */ inline __fastcall virtual THackDBComboBox(System::Classes::TComponent* AOwner) : Eldbboxes::TElDBComboBox(AOwner) { }
	/* TElDBComboBox.Destroy */ inline __fastcall virtual ~THackDBComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THackDBComboBox(HWND ParentWindow) : Eldbboxes::TElDBComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElDBTreeLookupComboGridEdit : public Eldbxtree::TElDBTreeInplaceEditor
{
	typedef Eldbxtree::TElDBTreeInplaceEditor inherited;
	
private:
	bool FAccepted;
	System::Variant FOldVal;
	System::Classes::TWndMethod SaveWndProc;
	int FWidth;
	void __fastcall SetStressShortCut(System::Classes::TShortCut Value);
	System::Classes::TShortCut __fastcall GetStressShortCut(void);
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall SetShowGripper(bool Value);
	bool __fastcall GetShowGripper(void);
	System::UnicodeString __fastcall GetListFieldName(void);
	void __fastcall SetListFieldName(const System::UnicodeString Value);
	void __fastcall SetNullValueKey(System::Classes::TShortCut Value);
	System::Classes::TShortCut __fastcall GetNullValueKey(void);
	System::UnicodeString __fastcall GetValidationMsgString(void);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	void __fastcall SetValidationMsgString(const System::UnicodeString Value);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* const Value);
	Lmdvldbase::TLMDValidationErrorEvent __fastcall GetOnValidationError(void);
	void __fastcall SetOnValidationError(const Lmdvldbase::TLMDValidationErrorEvent Value);
	
protected:
	Eldbwidelookupcombogrid::TElWideDBLookupComboGrid* __fastcall GetEditor(void);
	virtual void __fastcall SetEditorParent(void);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	Elstyleman::TElStyleManager* __fastcall GetStyleManager(void);
	System::UnicodeString __fastcall GetStyleName(void);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TElDBTreeLookupComboGridEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBTreeLookupComboGridEdit(void);
	virtual void __fastcall StartOperation(void);
	virtual void __fastcall CompleteOperation(bool Accepted);
	__property Eldbwidelookupcombogrid::TElWideDBLookupComboGrid* Editor = {read=GetEditor};
	
__published:
	__property Elstyleman::TElStyleManager* StyleManager = {read=GetStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=GetStyleName, write=SetStyleName};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=true};
	__property bool ShowGripper = {read=GetShowGripper, write=SetShowGripper, default=0};
	__property System::UnicodeString ListField = {read=GetListFieldName, write=SetListFieldName};
	__property System::Classes::TShortCut NullValueKey = {read=GetNullValueKey, write=SetNullValueKey, default=0};
	__property System::Classes::TShortCut StressShortCut = {read=GetStressShortCut, write=SetStressShortCut, default=0};
	__property System::UnicodeString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=GetOnValidationError, write=SetOnValidationError};
};


class PASCALIMPLEMENTATION TElDBTreeLookupComboBoxEdit : public Eldbxtree::TElDBTreeInplaceEditor
{
	typedef Eldbxtree::TElDBTreeInplaceEditor inherited;
	
private:
	bool FAccepted;
	System::Variant FOldVal;
	System::Classes::TWndMethod SaveWndProc;
	void __fastcall SetStressShortCut(System::Classes::TShortCut Value);
	System::Classes::TShortCut __fastcall GetStressShortCut(void);
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall SetShowGripper(bool Value);
	bool __fastcall GetShowGripper(void);
	void __fastcall SetNullValueKey(System::Classes::TShortCut Value);
	System::Classes::TShortCut __fastcall GetNullValueKey(void);
	System::UnicodeString __fastcall GetValidationMsgString(void);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	void __fastcall SetValidationMsgString(const System::UnicodeString Value);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* const Value);
	Lmdvldbase::TLMDValidationErrorEvent __fastcall GetOnValidationError(void);
	void __fastcall SetOnValidationError(const Lmdvldbase::TLMDValidationErrorEvent Value);
	
protected:
	bool FInitiallyDropped;
	Eldbwidelookupcontrols::TElWideDBLookupComboBox* __fastcall GetEditor(void);
	virtual void __fastcall SetEditorParent(void);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	Elstyleman::TElStyleManager* __fastcall GetStyleManager(void);
	System::UnicodeString __fastcall GetStyleName(void);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TElDBTreeLookupComboBoxEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBTreeLookupComboBoxEdit(void);
	virtual void __fastcall StartOperation(void);
	virtual void __fastcall CompleteOperation(bool Accepted);
	__property Eldbwidelookupcontrols::TElWideDBLookupComboBox* Editor = {read=GetEditor};
	
__published:
	__property System::Classes::TShortCut NullValueKey = {read=GetNullValueKey, write=SetNullValueKey, default=0};
	__property bool InitiallyDropped = {read=FInitiallyDropped, write=FInitiallyDropped, default=0};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=true};
	__property Elstyleman::TElStyleManager* StyleManager = {read=GetStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=GetStyleName, write=SetStyleName};
	__property bool ShowGripper = {read=GetShowGripper, write=SetShowGripper, default=0};
	__property System::Classes::TShortCut StressShortCut = {read=GetStressShortCut, write=SetStressShortCut, default=0};
	__property System::UnicodeString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=GetOnValidationError, write=SetOnValidationError};
};


class PASCALIMPLEMENTATION TElDBTreeWideStringEdit : public Eldbxtree::TElDBTreeInplaceEditor
{
	typedef Eldbxtree::TElDBTreeInplaceEditor inherited;
	
private:
	bool FAccepted;
	System::Classes::TWndMethod SaveWndProc;
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	Lmdeldbconst::TElDBUnicodeMode __fastcall GetUnicodeMode(void);
	void __fastcall SetUnicodeMode(Lmdeldbconst::TElDBUnicodeMode Value);
	void __fastcall SetStressShortCut(System::Classes::TShortCut Value);
	System::Classes::TShortCut __fastcall GetStressShortCut(void);
	System::UnicodeString __fastcall GetValidationMsgString(void);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	void __fastcall SetValidationMsgString(const System::UnicodeString Value);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* const Value);
	Lmdvldbase::TLMDValidationErrorEvent __fastcall GetOnValidationError(void);
	void __fastcall SetOnValidationError(const Lmdvldbase::TLMDValidationErrorEvent Value);
	
protected:
	Eldbctrls::TElWideDBEdit* __fastcall GetEditor(void);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall SetEditorParent(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	
public:
	__fastcall virtual TElDBTreeWideStringEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBTreeWideStringEdit(void);
	virtual void __fastcall CompleteOperation(bool Accepted);
	virtual void __fastcall StartOperation(void);
	__property Eldbctrls::TElWideDBEdit* Editor = {read=GetEditor};
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=true};
	__property Lmdeldbconst::TElDBUnicodeMode UnicodeMode = {read=GetUnicodeMode, write=SetUnicodeMode, default=0};
	__property System::Classes::TShortCut StressShortCut = {read=GetStressShortCut, write=SetStressShortCut, default=0};
	__property System::UnicodeString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=GetOnValidationError, write=SetOnValidationError};
};


class PASCALIMPLEMENTATION TElDBTreeSpinEdit : public Eldbxtree::TElDBTreeInplaceEditor
{
	typedef Eldbxtree::TElDBTreeInplaceEditor inherited;
	
private:
	bool FAccepted1;
	System::Classes::TWndMethod SaveWndProc;
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall SetMaxValue(int Value);
	int __fastcall GetMaxValue(void);
	void __fastcall SetMinValue(int Value);
	int __fastcall GetMinValue(void);
	System::UnicodeString __fastcall GetValidationMsgString(void);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	void __fastcall SetValidationMsgString(const System::UnicodeString Value);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* const Value);
	Lmdvldbase::TLMDValidationErrorEvent __fastcall GetOnValidationError(void);
	void __fastcall SetOnValidationError(const Lmdvldbase::TLMDValidationErrorEvent Value);
	
protected:
	Eldbspin::TElDBSpinEdit* __fastcall GetEditor(void);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall SetEditorParent(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	Elstyleman::TElStyleManager* __fastcall GetStyleManager(void);
	System::UnicodeString __fastcall GetStyleName(void);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TElDBTreeSpinEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBTreeSpinEdit(void);
	virtual void __fastcall CompleteOperation(bool Accepted);
	virtual void __fastcall StartOperation(void);
	__property Eldbspin::TElDBSpinEdit* Editor = {read=GetEditor};
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=true};
	__property Elstyleman::TElStyleManager* StyleManager = {read=GetStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=GetStyleName, write=SetStyleName};
	__property int MaxValue = {read=GetMaxValue, write=SetMaxValue, default=10000000};
	__property int MinValue = {read=GetMinValue, write=SetMinValue, default=-10000000};
	__property System::UnicodeString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=GetOnValidationError, write=SetOnValidationError};
};


class PASCALIMPLEMENTATION TElDBTreeFloatSpinEdit : public Eldbxtree::TElDBTreeInplaceEditor
{
	typedef Eldbxtree::TElDBTreeInplaceEditor inherited;
	
private:
	bool FAccepted1;
	System::Classes::TWndMethod SaveWndProc;
	bool __fastcall IsStoreMax(void);
	bool __fastcall IsStoreMin(void);
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall SetMaxValue(double Value);
	double __fastcall GetMaxValue(void);
	void __fastcall SetMinValue(double Value);
	double __fastcall GetMinValue(void);
	void __fastcall SetDigits(int Value);
	int __fastcall GetDigits(void);
	System::UnicodeString __fastcall GetValidationMsgString(void);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	void __fastcall SetValidationMsgString(const System::UnicodeString Value);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* const Value);
	Lmdvldbase::TLMDValidationErrorEvent __fastcall GetOnValidationError(void);
	void __fastcall SetOnValidationError(const Lmdvldbase::TLMDValidationErrorEvent Value);
	
protected:
	Eldbspin::TElDBFloatSpinEdit* __fastcall GetEditor(void);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall SetEditorParent(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	Elstyleman::TElStyleManager* __fastcall GetStyleManager(void);
	System::UnicodeString __fastcall GetStyleName(void);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TElDBTreeFloatSpinEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBTreeFloatSpinEdit(void);
	virtual void __fastcall CompleteOperation(bool Accepted);
	virtual void __fastcall StartOperation(void);
	__property Eldbspin::TElDBFloatSpinEdit* Editor = {read=GetEditor};
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=true};
	__property Elstyleman::TElStyleManager* StyleManager = {read=GetStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=GetStyleName, write=SetStyleName};
	__property double MaxValue = {read=GetMaxValue, write=SetMaxValue, stored=IsStoreMax};
	__property double MinValue = {read=GetMinValue, write=SetMinValue, stored=IsStoreMin};
	__property int Digits = {read=GetDigits, write=SetDigits, default=3};
	__property System::UnicodeString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=GetOnValidationError, write=SetOnValidationError};
};


class PASCALIMPLEMENTATION TElWideDBTEdit : public Eldbctrls::TElWideDBEdit
{
	typedef Eldbctrls::TElWideDBEdit inherited;
	
protected:
	virtual void __fastcall DataChange(System::TObject* Sender);
public:
	/* TElWideDBEdit.Create */ inline __fastcall virtual TElWideDBTEdit(System::Classes::TComponent* AOwner) : Eldbctrls::TElWideDBEdit(AOwner) { }
	/* TElWideDBEdit.Destroy */ inline __fastcall virtual ~TElWideDBTEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElWideDBTEdit(HWND ParentWindow) : Eldbctrls::TElWideDBEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElDBTreeEdit : public Eldbxtree::TElDBTreeInplaceEditor
{
	typedef Eldbxtree::TElDBTreeInplaceEditor inherited;
	
private:
	bool FAccepted;
	System::Classes::TWndMethod SaveWndProc;
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall SetStressShortCut(System::Classes::TShortCut Value);
	System::Classes::TShortCut __fastcall GetStressShortCut(void);
	System::UnicodeString __fastcall GetValidationMsgString(void);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	void __fastcall SetValidationMsgString(const System::UnicodeString Value);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* const Value);
	Lmdvldbase::TLMDValidationErrorEvent __fastcall GetOnValidationError(void);
	void __fastcall SetOnValidationError(const Lmdvldbase::TLMDValidationErrorEvent Value);
	
protected:
	Eldbctrls::TElWideDBEdit* __fastcall GetEditor(void);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall SetEditorParent(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	
public:
	__fastcall virtual TElDBTreeEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBTreeEdit(void);
	virtual void __fastcall CompleteOperation(bool Accepted);
	virtual void __fastcall StartOperation(void);
	__property Eldbctrls::TElWideDBEdit* Editor = {read=GetEditor};
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=true};
	__property System::Classes::TShortCut StressShortCut = {read=GetStressShortCut, write=SetStressShortCut, default=0};
	__property System::UnicodeString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=GetOnValidationError, write=SetOnValidationError};
};


class PASCALIMPLEMENTATION TDBMemoForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
private:
	TElDBTreeMemoEdit* FTreeMemoEdit;
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Winapi::Messages::TWMMouseActivate &Msg);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	MESSAGE void __fastcall WMEnterSizeMove(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMExitSizeMove(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Winapi::Messages::TWMGetMinMaxInfo &Message);
	
public:
	__fastcall virtual TDBMemoForm(System::Classes::TComponent* AOwner, int Dummy);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDBMemoForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDBMemoForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBMemoForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElInpDBMemo : public Eldbctrls::TElWideDBMemo
{
	typedef Eldbctrls::TElWideDBMemo inherited;
	
private:
	TElDBTreeMemoEdit* FTreeMemoEdit;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	
protected:
	virtual void __fastcall Paint(void);
public:
	/* TElWideDBMemo.Create */ inline __fastcall virtual TElInpDBMemo(System::Classes::TComponent* AOwner) : Eldbctrls::TElWideDBMemo(AOwner) { }
	/* TElWideDBMemo.Destroy */ inline __fastcall virtual ~TElInpDBMemo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElInpDBMemo(HWND ParentWindow) : Eldbctrls::TElWideDBMemo(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElDBTreeMemoEdit : public Eldbxtree::TElDBTreeInplaceEditor
{
	typedef Eldbxtree::TElDBTreeInplaceEditor inherited;
	
private:
	bool FAccepted;
	bool FShowGripper;
	TDBMemoForm* FForm;
	bool FIgnoreFocus;
	void __fastcall SetHeight(int value);
	int __fastcall GetHeight(void);
	Lmdeldbconst::TElDBUnicodeMode __fastcall GetUnicodeMode(void);
	void __fastcall SetUnicodeMode(Lmdeldbconst::TElDBUnicodeMode Value);
	void __fastcall SetStressShortCut(System::Classes::TShortCut Value);
	System::Classes::TShortCut __fastcall GetStressShortCut(void);
	void __fastcall SetShowGripper(bool Value);
	System::UnicodeString __fastcall GetValidationMsgString(void);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	void __fastcall SetValidationMsgString(const System::UnicodeString Value);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* const Value);
	Lmdvldbase::TLMDValidationErrorEvent __fastcall GetOnValidationError(void);
	void __fastcall SetOnValidationError(const Lmdvldbase::TLMDValidationErrorEvent Value);
	
protected:
	Eldbctrls::TElWideDBMemo* __fastcall GetEditor(void);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall SetEditorParent(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	Elstyleman::TElStyleManager* __fastcall GetStyleManager(void);
	System::UnicodeString __fastcall GetStyleName(void);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TElDBTreeMemoEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBTreeMemoEdit(void);
	virtual void __fastcall CompleteOperation(bool Accepted);
	virtual void __fastcall StartOperation(void);
	__property Eldbctrls::TElWideDBMemo* Editor = {read=GetEditor};
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=true};
	__property int Height = {read=GetHeight, write=SetHeight, stored=true, default=89};
	__property System::Classes::TShortCut StressShortCut = {read=GetStressShortCut, write=SetStressShortCut, default=0};
	__property Elstyleman::TElStyleManager* StyleManager = {read=GetStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=GetStyleName, write=SetStyleName};
	__property Lmdeldbconst::TElDBUnicodeMode UnicodeMode = {read=GetUnicodeMode, write=SetUnicodeMode, default=0};
	__property bool ShowGripper = {read=FShowGripper, write=SetShowGripper, default=0};
	__property System::UnicodeString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=GetOnValidationError, write=SetOnValidationError};
};


class PASCALIMPLEMENTATION TElDBTreeCheckBoxEdit : public Eldbxtree::TElDBTreeInplaceEditor
{
	typedef Eldbxtree::TElDBTreeInplaceEditor inherited;
	
private:
	bool FAccepted;
	System::Classes::TWndMethod SaveWndProc;
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	
protected:
	Eldbctrls::TElDBCheckBox* __fastcall GetEditor(void);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall SetEditorParent(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	
public:
	__fastcall virtual TElDBTreeCheckBoxEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBTreeCheckBoxEdit(void);
	virtual void __fastcall CompleteOperation(bool Accepted);
	virtual void __fastcall StartOperation(void);
	__property Eldbctrls::TElDBCheckBox* Editor = {read=GetEditor};
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=true};
};


class PASCALIMPLEMENTATION TElDBTreeDateTimePickerEdit : public Eldbxtree::TElDBTreeInplaceEditor
{
	typedef Eldbxtree::TElDBTreeInplaceEditor inherited;
	
private:
	bool FAccepted;
	System::Classes::TWndMethod SaveWndProc;
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall SetShowPopupCalendar(bool Value);
	bool __fastcall GetShowPopupCalendar(void);
	void __fastcall SetShowCalendarClock(bool Value);
	bool __fastcall GetShowCalendarClock(void);
	void __fastcall SetFormat(Eldtpick::TElDatePickerFormat Value);
	Eldtpick::TElDatePickerFormat __fastcall GetFormat(void);
	
protected:
	bool FIgnoreKillFocus;
	Eldbdtpick::TElDBDateTimePicker* __fastcall GetEditor(void);
	void __fastcall CalDropDown(System::TObject* Sender);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall SetEditorParent(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	Elstyleman::TElStyleManager* __fastcall GetStyleManager(void);
	System::UnicodeString __fastcall GetStyleName(void);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TElDBTreeDateTimePickerEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBTreeDateTimePickerEdit(void);
	virtual void __fastcall CompleteOperation(bool Accepted);
	virtual void __fastcall StartOperation(void);
	__property Eldbdtpick::TElDBDateTimePicker* Editor = {read=GetEditor};
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=true};
	__property Elstyleman::TElStyleManager* StyleManager = {read=GetStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=GetStyleName, write=SetStyleName};
	__property bool ShowPopupCalendar = {read=GetShowPopupCalendar, write=SetShowPopupCalendar, default=0};
	__property Eldtpick::TElDatePickerFormat Format = {read=GetFormat, write=SetFormat, default=0};
	__property bool CalendarShowClock = {read=GetShowCalendarClock, write=SetShowCalendarClock, default=0};
};


class PASCALIMPLEMENTATION TElDBTreeCurrencyEdit : public Eldbxtree::TElDBTreeInplaceEditor
{
	typedef Eldbxtree::TElDBTreeInplaceEditor inherited;
	
private:
	bool FAccepted;
	bool FCalcDlgButtonVisible;
	System::Variant FOldVal;
	System::Classes::TWndMethod SaveIntWndProc1;
	System::Classes::TWndMethod SaveIntWndProc2;
	System::Classes::TWndMethod SaveWndProc;
	System::UnicodeString __fastcall GetValidationMsgString(void);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	void __fastcall SetValidationMsgString(const System::UnicodeString Value);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* const Value);
	Lmdvldbase::TLMDValidationErrorEvent __fastcall GetOnValidationError(void);
	void __fastcall SetOnValidationError(const Lmdvldbase::TLMDValidationErrorEvent Value);
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall IntEditorWndProc1(Winapi::Messages::TMessage &Message);
	void __fastcall IntEditorWndProc2(Winapi::Messages::TMessage &Message);
	void __fastcall SetNegativeSignColor(System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetNegativeSignColor(void);
	void __fastcall SetSign(bool Value);
	bool __fastcall GetSign(void);
	void __fastcall SetEnableSign(bool Value);
	bool __fastcall GetEnableSign(void);
	void __fastcall SetNegativeValueTextColor(System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetNegativeValueTextColor(void);
	void __fastcall SetDecimalPlaces(System::Byte Value);
	System::Byte __fastcall GetDecimalPlaces(void);
	void __fastcall SetUseSystemDecimalPlaces(bool Value);
	bool __fastcall GetUseSystemDecimalPlaces(void);
	void __fastcall SetCurrencySymbol(Lmdtypes::TLMDString Value);
	Lmdtypes::TLMDString __fastcall GetCurrencySymbol(void);
	void __fastcall SetCurrencySymbolPosition(Elcurredit::TElCurrencySymbolPosition Value);
	Elcurredit::TElCurrencySymbolPosition __fastcall GetCurrencySymbolPosition(void);
	void __fastcall SetUseSystemCurrencySymbol(bool Value);
	bool __fastcall GetUseSystemCurrencySymbol(void);
	void __fastcall SetUseThousandSeparator(bool Value);
	bool __fastcall GetUseThousandSeparator(void);
	
protected:
	bool FIgnoreKillFocus;
	Eldbcurredit::TElDBCurrencyEdit* __fastcall GetEditor(void);
	Elstyleman::TElStyleManager* __fastcall GetStyleManager(void);
	System::UnicodeString __fastcall GetStyleName(void);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	void __fastcall RealWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall SetEditorParent(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	void __fastcall OnCalcDlg(System::TObject* Sender);
	void __fastcall OnCalcDlgClose(System::TObject* Sender);
	
public:
	__fastcall virtual TElDBTreeCurrencyEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBTreeCurrencyEdit(void);
	virtual void __fastcall CompleteOperation(bool Accepted);
	virtual void __fastcall StartOperation(void);
	__property Eldbcurredit::TElDBCurrencyEdit* Editor = {read=GetEditor};
	
__published:
	__property Elstyleman::TElStyleManager* StyleManager = {read=GetStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=GetStyleName, write=SetStyleName};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=true};
	__property bool Sign = {read=GetSign, write=SetSign, default=0};
	__property bool EnableSign = {read=GetEnableSign, write=SetEnableSign, default=0};
	__property System::Uitypes::TColor NegativeSignColor = {read=GetNegativeSignColor, write=SetNegativeSignColor, default=536870911};
	__property System::Uitypes::TColor NegativeValueTextColor = {read=GetNegativeValueTextColor, write=SetNegativeValueTextColor, default=536870911};
	__property System::Byte DecimalPlaces = {read=GetDecimalPlaces, write=SetDecimalPlaces, default=2};
	__property bool UseSystemDecimalPlaces = {read=GetUseSystemDecimalPlaces, write=SetUseSystemDecimalPlaces, default=1};
	__property Lmdtypes::TLMDString CurrencySymbol = {read=GetCurrencySymbol, write=SetCurrencySymbol};
	__property Elcurredit::TElCurrencySymbolPosition CurrencySymbolPosition = {read=GetCurrencySymbolPosition, write=SetCurrencySymbolPosition, default=1};
	__property bool UseSystemCurrencySymbol = {read=GetUseSystemCurrencySymbol, write=SetUseSystemCurrencySymbol, default=0};
	__property bool CalcDlgButtonVisible = {read=FCalcDlgButtonVisible, write=FCalcDlgButtonVisible, default=0};
	__property bool UseThousandSeparator = {read=GetUseThousandSeparator, write=SetUseThousandSeparator, default=0};
	__property System::UnicodeString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=GetOnValidationError, write=SetOnValidationError};
};


class PASCALIMPLEMENTATION TElDBTreeComboBoxEdit : public Eldbxtree::TElDBTreeInplaceEditor
{
	typedef Eldbxtree::TElDBTreeInplaceEditor inherited;
	
private:
	bool FAccepted;
	System::Classes::TWndMethod SaveWndProc;
	System::Variant FOldVal;
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	System::Classes::TStrings* __fastcall GetItems(void);
	void __fastcall SetItems(System::Classes::TStrings* Value);
	void __fastcall SetStressShortCut(System::Classes::TShortCut Value);
	System::Classes::TShortCut __fastcall GetStressShortCut(void);
	void __fastcall SetShowGripper(bool Value);
	bool __fastcall GetShowGripper(void);
	System::UnicodeString __fastcall GetValidationMsgString(void);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	void __fastcall SetValidationMsgString(const System::UnicodeString Value);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* const Value);
	Lmdvldbase::TLMDValidationErrorEvent __fastcall GetOnValidationError(void);
	void __fastcall SetOnValidationError(const Lmdvldbase::TLMDValidationErrorEvent Value);
	
protected:
	bool FInitiallyDropped;
	Eldbboxes::TElDBComboBox* __fastcall GetEditor(void);
	virtual void __fastcall SetEditorParent(void);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	Elstyleman::TElStyleManager* __fastcall GetStyleManager(void);
	System::UnicodeString __fastcall GetStyleName(void);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TElDBTreeComboBoxEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDBTreeComboBoxEdit(void);
	virtual void __fastcall TriggerValidateResult(bool &InputValid);
	virtual void __fastcall StartOperation(void);
	virtual void __fastcall CompleteOperation(bool Accepted);
	__property Eldbboxes::TElDBComboBox* Editor = {read=GetEditor};
	
__published:
	__property Elstyleman::TElStyleManager* StyleManager = {read=GetStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=GetStyleName, write=SetStyleName};
	__property bool InitiallyDropped = {read=FInitiallyDropped, write=FInitiallyDropped, default=0};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont, stored=true};
	__property System::Classes::TStrings* Items = {read=GetItems, write=SetItems, stored=true};
	__property bool ShowGripper = {read=GetShowGripper, write=SetShowGripper, default=0};
	__property System::Classes::TShortCut StressShortCut = {read=GetStressShortCut, write=SetStressShortCut, default=0};
	__property System::UnicodeString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=GetOnValidationError, write=SetOnValidationError};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eldbtreeeditors */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDBTREEEDITORS)
using namespace Eldbtreeeditors;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldbtreeeditorsHPP
