// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCalc.pas' rev: 31.00 (Windows)

#ifndef LmdcalcHPP
#define LmdcalcHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDButtonBase.hpp>
#include <LMDClass.hpp>
#include <LMDFXCaption.hpp>
#include <LMDButtonLayout.hpp>
#include <LMDGraph.hpp>
#include <LMDLabel.hpp>
#include <LMDSpeedButton.hpp>
#include <LMDStack.hpp>
#include <LMDEmbeddedObject.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomControl.hpp>
#include <System.UITypes.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcalc
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomCalculator;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDCalcBtns : unsigned char { cb0, cb1, cb2, cb3, cb4, cb5, cb6, cb7, cb8, cb9, cbPlus, cbMinus, cbMUL, cbDIV, cbFloatDiv, cbMOD, cbEqual, cbClear, cbBack, cbEuler, cbPI, cbSQR, cbSQRT, cbLN, cbEXP, cbPercent, cbPower, cbStore, cbRCL, cbStorePlus, cbStoreMinus, cbKehr, cbFac, cbDecimalDel, cbOpenBraket, cbCloseBraket, cbSIN, cbCOS, cbTAN, cbINV };

typedef void __fastcall (__closure *TLMDCalcWorkEvent)(System::TObject* Sender, System::UnicodeString repLine);

typedef void __fastcall (__closure *TLMDManualBtnSetupEvent)(System::TObject* Sender, Vcl::Graphics::TFont* aFont, Lmdfxcaption::TLMDFxCaption* aFontFX, Lmdbuttonlayout::TLMDButtonLayout* aBtnLayout, Vcl::Graphics::TBitmap* aGlyph, System::UnicodeString &aCaption, System::Uitypes::TColor &aColor);

class PASCALIMPLEMENTATION TLMDCustomCalculator : public Lmdcustompanelfill::TLMDCustomPanelFill
{
	typedef Lmdcustompanelfill::TLMDCustomPanelFill inherited;
	
private:
	Lmdspeedbutton::TLMDSpeedButton* FSB0;
	Lmdspeedbutton::TLMDSpeedButton* FSB1;
	Lmdspeedbutton::TLMDSpeedButton* FSB2;
	Lmdspeedbutton::TLMDSpeedButton* FSB3;
	Lmdspeedbutton::TLMDSpeedButton* FSB4;
	Lmdspeedbutton::TLMDSpeedButton* FSB5;
	Lmdspeedbutton::TLMDSpeedButton* FSB6;
	Lmdspeedbutton::TLMDSpeedButton* FSB7;
	Lmdspeedbutton::TLMDSpeedButton* FSB8;
	Lmdspeedbutton::TLMDSpeedButton* FSB9;
	Lmdspeedbutton::TLMDSpeedButton* FSB_PLUS;
	Lmdspeedbutton::TLMDSpeedButton* FSB_MINUS;
	Lmdspeedbutton::TLMDSpeedButton* FSB_MUL;
	Lmdspeedbutton::TLMDSpeedButton* FSB_DIV;
	Lmdspeedbutton::TLMDSpeedButton* FSB_PERCENT;
	Lmdspeedbutton::TLMDSpeedButton* FSB_SIN;
	Lmdspeedbutton::TLMDSpeedButton* FSB_COS;
	Lmdspeedbutton::TLMDSpeedButton* FSB_TAN;
	Lmdspeedbutton::TLMDSpeedButton* FSB_E;
	Lmdspeedbutton::TLMDSpeedButton* FSB_PI;
	Lmdspeedbutton::TLMDSpeedButton* FSB_SQRT;
	Lmdspeedbutton::TLMDSpeedButton* FSB_SQR;
	Lmdspeedbutton::TLMDSpeedButton* FSB_XY;
	Lmdspeedbutton::TLMDSpeedButton* FSB_BACK;
	Lmdspeedbutton::TLMDSpeedButton* FSB_CLEAR;
	Lmdspeedbutton::TLMDSpeedButton* FSB_EX;
	Lmdspeedbutton::TLMDSpeedButton* FSB_LN;
	Lmdspeedbutton::TLMDSpeedButton* FSB_STORE;
	Lmdspeedbutton::TLMDSpeedButton* FSB_STOREPLUS;
	Lmdspeedbutton::TLMDSpeedButton* FSB_STOREMINUS;
	Lmdspeedbutton::TLMDSpeedButton* FSB_RCL;
	Lmdspeedbutton::TLMDSpeedButton* FSB_FAC;
	Lmdspeedbutton::TLMDSpeedButton* FSB_DELIM;
	Lmdspeedbutton::TLMDSpeedButton* FSB_KEHR;
	Lmdspeedbutton::TLMDSpeedButton* FSB_INV;
	Lmdspeedbutton::TLMDSpeedButton* FSB_OPENBRAKET;
	Lmdspeedbutton::TLMDSpeedButton* FSB_CLOSEBRAKET;
	Lmdspeedbutton::TLMDSpeedButton* FSB_EQUAL;
	Lmdlabel::TLMDLabel* FLABEL;
	Lmdbuttonbase::TLMDUserButtonStyle FBtnStyle;
	Lmdstack::TLMDStack* operands;
	Lmdstack::TLMDStack* values;
	bool FFrac;
	bool FDel;
	TLMDCalcWorkEvent FOnWork;
	System::Classes::TNotifyEvent FOnCalc;
	System::Extended FStoredValue;
	System::Extended FValue;
	Lmdembeddedobject::TLMDEmbeddedObject* FDisplaySet;
	int FLastZero;
	int FDecimals;
	Lmdcustommaskedit::TLMDNumberType FEditType;
	Vcl::Graphics::TFont* FBtnFont;
	TLMDManualBtnSetupEvent FOnManualBtnSetup;
	int FPrecision;
	void __fastcall SetTheValue(System::Extended aValue);
	void __fastcall SetBtnStyle(Lmdbuttonbase::TLMDUserButtonStyle aValue);
	void __fastcall SetDisplaySet(Lmdembeddedobject::TLMDEmbeddedObject* aValue);
	void __fastcall SetInteger(const int Index, const int aValue);
	void __fastcall SetEditType(Lmdcustommaskedit::TLMDNumberType aValue);
	HIDESBASE void __fastcall SetFont(Vcl::Graphics::TFont* aValue);
	void __fastcall ReadOldBtnStyle(System::Classes::TReader* Reader);
	System::Extended __fastcall ExtractTopValue(void);
	TLMDCalcBtns __fastcall ExtractTopOperand(void);
	void __fastcall PushValue(System::Extended aValue);
	void __fastcall PushOperand(TLMDCalcBtns op);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall DoGetValueSize(System::TObject* Sender, void * Item, int &size);
	void __fastcall DoGetOperandSize(System::TObject* Sender, void * Item, int &size);
	void __fastcall DoFreeItem(System::TObject* Sender, void * Item);
	virtual void __fastcall DoThemeChanged(void);
	bool __fastcall calc(void);
	void __fastcall AddOperator(TLMDCalcBtns op);
	void __fastcall DoClick(System::TObject* Sender);
	void __fastcall DoSimpleOp(TLMDCalcBtns op);
	System::Extended __fastcall GetValue(void);
	void __fastcall SetValue(System::Extended aValue);
	HIDESBASE void __fastcall SetText(const System::UnicodeString aValue);
	void __fastcall report(TLMDCalcBtns op);
	void __fastcall Input(TLMDCalcBtns inputbtn);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual bool __fastcall GetEmpty(void);
	__property Lmdbuttonbase::TLMDUserButtonStyle ButtonStyle = {read=FBtnStyle, write=SetBtnStyle, default=1};
	__property ThemeMode = {default=0};
	__property int Decimals = {read=FDecimals, write=SetInteger, index=1, default=1};
	__property int Precision = {read=FPrecision, write=SetInteger, index=2, default=15};
	__property Lmdembeddedobject::TLMDEmbeddedObject* DisplaySettings = {read=FDisplaySet, write=SetDisplaySet};
	__property Lmdcustommaskedit::TLMDNumberType EditType = {read=FEditType, write=SetEditType, default=1};
	__property Vcl::Graphics::TFont* BtnFont = {read=FBtnFont, write=SetFont};
	__property ParentBackground = {default=0};
	__property System::Extended Value = {read=FValue, write=SetTheValue};
	__property System::Classes::TNotifyEvent OnCalc = {read=FOnCalc, write=FOnCalc};
	__property TLMDCalcWorkEvent OnWork = {read=FOnWork, write=FOnWork};
	__property TLMDManualBtnSetupEvent OnManualBtnSetup = {read=FOnManualBtnSetup, write=FOnManualBtnSetup};
	
public:
	__fastcall virtual TLMDCustomCalculator(System::Classes::TComponent* aOwner);
	virtual void __fastcall Loaded(void);
	__fastcall virtual ~TLMDCustomCalculator(void);
	void __fastcall DoKey(System::WideChar Key);
	void __fastcall ManualBtnChange(void);
	__property Lmdbuttonbase::TLMDUserButtonStyle BtnStyle = {read=FBtnStyle, write=SetBtnStyle, nodefault};
	__property CtlXP = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomCalculator(HWND ParentWindow) : Lmdcustompanelfill::TLMDCustomPanelFill(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcalc */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCALC)
using namespace Lmdcalc;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcalcHPP
