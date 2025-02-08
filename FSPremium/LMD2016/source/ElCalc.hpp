// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElCalc.pas' rev: 31.00 (Windows)

#ifndef ElcalcHPP
#define ElcalcHPP

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
#include <Vcl.Clipbrd.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.TypInfo.hpp>
#include <ElStyleMan.hpp>
#include <ElComponent.hpp>
#include <ElXPThemedControl.hpp>
#include <ElEdits.hpp>
#include <ElBtnCtl.hpp>
#include <ElPopBtn.hpp>
#include <ElPanel.hpp>
#include <ElPromptDlg.hpp>
#include <ElVCLUtils.hpp>
#include <ElScrollBox.hpp>
#include <ElCaption.hpp>
#include <ElCGControl.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elcalc
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS EElMathError;
class DELPHICLASS TElCalculatorForm;
class DELPHICLASS TElCalculatorDialog;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION EElMathError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EElMathError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EElMathError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EElMathError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EElMathError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EElMathError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EElMathError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EElMathError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EElMathError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElMathError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EElMathError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElMathError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EElMathError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EElMathError(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TElMathErrorEvent)(System::TObject* Sender, Lmdtypes::TLMDString AError);

typedef void __fastcall (__closure *TElCalcDeactivateEvent)(System::TObject* Sender, int &ModalResult);

enum DECLSPEC_DENUM TElDialogStyle : unsigned char { edsDialog, edsPopup };

class PASCALIMPLEMENTATION TElCalculatorForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Elpanel::TElPanel* ElCalcPanel;
	Elpanel::TElPanel* ButtonPanel;
	Elpopbtn::TElPopupButton* bOk;
	Elpopbtn::TElPopupButton* bCancel;
	Elpopbtn::TElGraphicButton* b1;
	Elpopbtn::TElGraphicButton* b2;
	Elpopbtn::TElGraphicButton* b3;
	Elpopbtn::TElGraphicButton* b4;
	Elpopbtn::TElGraphicButton* b5;
	Elpopbtn::TElGraphicButton* b6;
	Elpopbtn::TElGraphicButton* b7;
	Elpopbtn::TElGraphicButton* b8;
	Elpopbtn::TElGraphicButton* b9;
	Elpopbtn::TElGraphicButton* b0;
	Elpopbtn::TElGraphicButton* bSign;
	Elpopbtn::TElGraphicButton* bPoint;
	Elpopbtn::TElGraphicButton* bMC;
	Elpopbtn::TElGraphicButton* bMR;
	Elpopbtn::TElGraphicButton* bMS;
	Elpopbtn::TElGraphicButton* bMPlus;
	Elpopbtn::TElGraphicButton* bDiv;
	Elpopbtn::TElGraphicButton* bMul;
	Elpopbtn::TElGraphicButton* bMinus;
	Elpopbtn::TElGraphicButton* bPlus;
	Elpopbtn::TElGraphicButton* bSqrt;
	Elpopbtn::TElGraphicButton* bPercent;
	Elpopbtn::TElGraphicButton* bDivX;
	Elpopbtn::TElGraphicButton* bEval;
	Elpopbtn::TElGraphicButton* bBackspace;
	Elpopbtn::TElGraphicButton* bCE;
	Elpopbtn::TElGraphicButton* bC;
	Elscrollbox::TElScrollBox* MemoryBox;
	Elpanel::TElPanel* Memory;
	Elcaption::TElFormCaption* FormCaption;
	void __fastcall EditorKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall EditorEnter(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall b7Click(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
private:
	bool Modified;
	
protected:
	TElCalcDeactivateEvent FOnDeactivate;
	TElDialogStyle FDialogStyle;
	Eledits::TElEdit* FEditor;
	System::Extended FFirst;
	System::Extended FLast;
	System::WideChar FLastOp;
	System::Extended FValue;
	System::Extended FMemory;
	bool FNew;
	TElMathErrorEvent FOnError;
	System::WideChar FOperator;
	bool FSep;
	bool IsModal;
	bool FShowControlButtons;
	System::Extended __fastcall GetResult(void);
	HIDESBASE MESSAGE void __fastcall WMQueryEndSession(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMActivate(Winapi::Messages::TWMActivate &Msg);
	void __fastcall SetDialogStyle(const TElDialogStyle Value);
	System::Extended __fastcall GetValue(void);
	void __fastcall SetValue(System::Extended Value);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	
public:
	__property Eledits::TElEdit* Editor = {read=FEditor, write=FEditor, default=0};
	__property System::Extended Result = {read=GetResult};
	__property TElDialogStyle DialogStyle = {read=FDialogStyle, write=SetDialogStyle, default=0};
	__property TElMathErrorEvent OnError = {read=FOnError, write=FOnError};
	__property TElCalcDeactivateEvent OnDeactivate = {read=FOnDeactivate, write=FOnDeactivate};
	__property System::Extended Value = {read=GetValue, write=SetValue};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TElCalculatorForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TElCalculatorForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TElCalculatorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElCalculatorForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElCalculatorDialog : public Elcomponent::TElBaseDlgComponent
{
	typedef Elcomponent::TElBaseDlgComponent inherited;
	
protected:
	Lmdtypes::TLMDString FCaption;
	bool FResetValue;
	Vcl::Graphics::TFont* FDigitButtonFont;
	Vcl::Graphics::TFont* FMemoryButtonFont;
	Vcl::Graphics::TFont* FOperatorButtonFont;
	double FResult;
	Vcl::Graphics::TFont* FServiceButtonFont;
	double FInitialValue;
	Eledits::TCustomElEdit* FEditor;
	TElMathErrorEvent FOnError;
	System::Classes::TNotifyEvent FOnShow;
	System::Classes::TNotifyEvent FOnClose;
	bool FShowControlButtons;
	TElCalcDeactivateEvent FOnDeactivate;
	Elstyleman::TElStyleManager* FStyleManager;
	System::UnicodeString FStyleName;
	bool FUseXPThemes;
	Vcl::Forms::TPosition FPosition;
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	void __fastcall PrepareDlg(TElCalculatorForm* ElCalcForm);
	virtual void __fastcall DoError(System::TObject* Sender, Lmdtypes::TLMDString AError);
	virtual void __fastcall DoClose(void);
	virtual void __fastcall DoShow(void);
	virtual void __fastcall DoDeactivate(System::TObject* Sender, int &ModalResult);
	virtual void __fastcall InitCalculatorForm(TElCalculatorForm* ElCalculatorForm);
	
public:
	__fastcall virtual TElCalculatorDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElCalculatorDialog(void);
	virtual bool __fastcall Execute(void);
	
__published:
	__property Elstyleman::TElStyleManager* StyleManager = {read=FStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
	__property Vcl::Graphics::TFont* MemoryButtonFont = {read=FMemoryButtonFont, write=FMemoryButtonFont};
	__property Vcl::Graphics::TFont* DigitButtonFont = {read=FDigitButtonFont, write=FDigitButtonFont};
	__property Vcl::Graphics::TFont* OperatorButtonFont = {read=FOperatorButtonFont, write=FOperatorButtonFont};
	__property Vcl::Graphics::TFont* ServiceButtonFont = {read=FServiceButtonFont, write=FServiceButtonFont};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=FCaption};
	__property double Result = {read=FResult};
	__property double InitialValue = {read=FInitialValue, write=FInitialValue};
	__property Eledits::TCustomElEdit* Editor = {read=FEditor, write=FEditor};
	__property TElMathErrorEvent OnError = {read=FOnError, write=FOnError};
	__property System::Classes::TNotifyEvent OnShow = {read=FOnShow, write=FOnShow};
	__property System::Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
	__property bool ShowControlButtons = {read=FShowControlButtons, write=FShowControlButtons, default=1};
	__property TElCalcDeactivateEvent OnDeactivate = {read=FOnDeactivate, write=FOnDeactivate};
	__property bool UseXPThemes = {read=FUseXPThemes, write=FUseXPThemes, default=1};
	__property Vcl::Forms::TPosition Position = {read=FPosition, write=FPosition, nodefault};
	__property bool ResetValue = {read=FResetValue, write=FResetValue, default=0};
};


typedef System::StaticArray<System::UnicodeString, 4> Elcalc__4;

typedef System::StaticArray<System::UnicodeString, 3> Elcalc__5;

typedef System::StaticArray<System::UnicodeString, 10> Elcalc__6;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Elcalc__4 ElMemoryButtons;
extern DELPHI_PACKAGE Elcalc__5 ElServiceButtons;
extern DELPHI_PACKAGE Elcalc__6 ElOperatorButtons;
extern DELPHI_PACKAGE void __fastcall LoadCalculatorDefaultGlyph(Vcl::Graphics::TBitmap* Glyph);
}	/* namespace Elcalc */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELCALC)
using namespace Elcalc;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElcalcHPP
