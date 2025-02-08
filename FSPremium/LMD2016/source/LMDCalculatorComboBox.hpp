// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCalculatorComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdcalculatorcomboboxHPP
#define LmdcalculatorcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDGraph.hpp>
#include <LMDCalculator.hpp>
#include <LMDButtonBase.hpp>
#include <LMDCustomExtCombo.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDTypes.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcalculatorcombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCalculatorComboBox;
class DELPHICLASS TLMDLabeledCalculatorComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCalculatorComboBox : public Lmdcustomextcombo::TLMDCustomExtCombo
{
	typedef Lmdcustomextcombo::TLMDCustomExtCombo inherited;
	
private:
	System::Extended FOld;
	Lmdbuttonbase::TLMDUserButtonStyle FCBtn;
	bool FCXP;
	Lmdcalculator::TLMDCalculator* __fastcall GetCalculator(void);
	double __fastcall GetValue(void);
	void __fastcall SetDValue(const double Value);
	void __fastcall SetCBtn(const Lmdbuttonbase::TLMDUserButtonStyle Value);
	void __fastcall SetCXP(const bool Value);
	HIDESBASE void __fastcall ReadOldBtnStyle(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall DoCalc(System::TObject* Sender);
	void __fastcall DoWork(System::TObject* Sender, System::UnicodeString s);
	virtual void __fastcall CreateControl(void);
	virtual void __fastcall ModifyControl(void);
	virtual void __fastcall DisplayControl(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall Cancel(void);
	virtual void __fastcall Accept(void);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDCalculatorComboBox(System::Classes::TComponent* aOwner);
	virtual void __fastcall Init(void);
	__property Text = {stored=false};
	__property Lmdcalculator::TLMDCalculator* Calculator = {read=GetCalculator};
	__property double Value = {read=GetValue, write=SetDValue};
	__property Lmdbuttonbase::TLMDUserButtonStyle CalculatorBtnStyle = {read=FCBtn, write=SetCBtn, nodefault};
	
__published:
	__property Lmdbuttonbase::TLMDUserButtonStyle CalcButtonStyle = {read=FCBtn, write=SetCBtn, default=7};
	__property bool CalcButtonCtlXP = {read=FCXP, write=SetCXP, default=0};
public:
	/* TLMDCustomExtCombo.Destroy */ inline __fastcall virtual ~TLMDCalculatorComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCalculatorComboBox(HWND ParentWindow) : Lmdcustomextcombo::TLMDCustomExtCombo(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledCalculatorComboBox : public TLMDCalculatorComboBox
{
	typedef TLMDCalculatorComboBox inherited;
	
public:
	__fastcall virtual TLMDLabeledCalculatorComboBox(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomExtCombo.Destroy */ inline __fastcall virtual ~TLMDLabeledCalculatorComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledCalculatorComboBox(HWND ParentWindow) : TLMDCalculatorComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcalculatorcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCALCULATORCOMBOBOX)
using namespace Lmdcalculatorcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcalculatorcomboboxHPP
