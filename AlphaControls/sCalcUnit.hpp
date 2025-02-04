// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sCalcUnit.pas' rev: 27.00 (Windows)

#ifndef ScalcunitHPP
#define ScalcunitHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <sPanel.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Vcl.Clipbrd.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <sSpeedButton.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Scalcunit
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TsCalcState : unsigned char { csFirst, csValid, csError };

class DELPHICLASS TsCalcForm;
class PASCALIMPLEMENTATION TsCalcForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Menus::TMenuItem* OK1;
	Vcl::Menus::TMenuItem* Cancel1;
	Spanel::TsPanel* FMainPanel;
	Vcl::Menus::TPopupMenu* PopupMenu1;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* N2;
	Spanel::TsPanel* FCalculatorPanel;
	Spanel::TsPanel* FCalcPanel;
	Sspeedbutton::TsSpeedButton* sSpeedButton1;
	Sspeedbutton::TsSpeedButton* sSpeedButton2;
	Sspeedbutton::TsSpeedButton* sSpeedButton3;
	Sspeedbutton::TsSpeedButton* sSpeedButton4;
	Sspeedbutton::TsSpeedButton* sSpeedButton5;
	Sspeedbutton::TsSpeedButton* sSpeedButton6;
	Sspeedbutton::TsSpeedButton* sSpeedButton7;
	Sspeedbutton::TsSpeedButton* sSpeedButton8;
	Sspeedbutton::TsSpeedButton* sSpeedButton9;
	Sspeedbutton::TsSpeedButton* sSpeedButton10;
	Sspeedbutton::TsSpeedButton* sSpeedButton11;
	Sspeedbutton::TsSpeedButton* sSpeedButton12;
	Sspeedbutton::TsSpeedButton* sSpeedButton13;
	Sspeedbutton::TsSpeedButton* sSpeedButton14;
	Sspeedbutton::TsSpeedButton* sSpeedButton15;
	Sspeedbutton::TsSpeedButton* sSpeedButton16;
	Sspeedbutton::TsSpeedButton* sSpeedButton17;
	Sspeedbutton::TsSpeedButton* sSpeedButton18;
	Sspeedbutton::TsSpeedButton* sSpeedButton19;
	Sspeedbutton::TsSpeedButton* sSpeedButton20;
	Sspeedbutton::TsSpeedButton* sSpeedButton21;
	Sspeedbutton::TsSpeedButton* sSpeedButton22;
	Sspeedbutton::TsSpeedButton* sSpeedButton23;
	Sspeedbutton::TsSpeedButton* sSpeedButton24;
	Sspeedbutton::TsSpeedButton* sSpeedButton25;
	Sspeedbutton::TsSpeedButton* sSpeedButton26;
	Spanel::TsPanel* FDisplayPanel;
	Spanel::TsDragBar* sDragBar1;
	Sspeedbutton::TsSpeedButton* sToolButton3;
	Sspeedbutton::TsSpeedButton* sToolButton1;
	void __fastcall sSpeedButton22Click(System::TObject* Sender);
	void __fastcall FormKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall N1Click(System::TObject* Sender);
	void __fastcall N2Click(System::TObject* Sender);
	void __fastcall PopupMenu1Popup(System::TObject* Sender);
	void __fastcall sSpeedButton24Click(System::TObject* Sender);
	void __fastcall sSpeedButton23Click(System::TObject* Sender);
	void __fastcall sSpeedButton25Click(System::TObject* Sender);
	void __fastcall sSpeedButton26Click(System::TObject* Sender);
	void __fastcall sSpeedButton19Click(System::TObject* Sender);
	void __fastcall sSpeedButton13Click(System::TObject* Sender);
	void __fastcall sSpeedButton7Click(System::TObject* Sender);
	void __fastcall sSpeedButton21Click(System::TObject* Sender);
	void __fastcall sSpeedButton15Click(System::TObject* Sender);
	void __fastcall sSpeedButton9Click(System::TObject* Sender);
	void __fastcall sSpeedButton3Click(System::TObject* Sender);
	void __fastcall OK1Click(System::TObject* Sender);
	void __fastcall Cancel1Click(System::TObject* Sender);
	void __fastcall sSpeedButton2Click(System::TObject* Sender);
	void __fastcall sSpeedButton14Click(System::TObject* Sender);
	void __fastcall sSpeedButton8Click(System::TObject* Sender);
	void __fastcall sSpeedButton20Click(System::TObject* Sender);
	void __fastcall sSpeedButton1Click(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall sToolButton3Click(System::TObject* Sender);
	void __fastcall sToolButton1Click(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormDeactivate(System::TObject* Sender);
	
protected:
	System::Extended FOperand;
	System::Classes::TNotifyEvent FOnError;
	System::Classes::TNotifyEvent FOnOk;
	System::Classes::TNotifyEvent FOnCancel;
	System::Classes::TNotifyEvent FOnResult;
	System::Classes::TNotifyEvent FOnTextChange;
	Vcl::Controls::TKeyPressEvent FOnCalcKey;
	System::Classes::TNotifyEvent FOnDisplayChange;
	
private:
	void __fastcall TextChanged(void);
	
public:
	System::UnicodeString FText;
	System::Extended FMemory;
	System::Byte FPrecision;
	bool FBeepOnError;
	TsCalcState FStatus;
	System::WideChar FOperator;
	Vcl::Mask::TCustomMaskEdit* FEditor;
	void __fastcall FillArOR(void);
	HRGN __fastcall GetRgnFromArOR(void);
	System::Variant __fastcall GetValue(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	void __fastcall SetValue(const System::Variant &Value);
	HIDESBASE void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall CheckFirst(void);
	void __fastcall CalcKey(System::WideChar Key);
	void __fastcall Clear(void);
	void __fastcall Error(void);
	void __fastcall SetDisplay(System::Extended R);
	System::Extended __fastcall GetDisplay(void);
	void __fastcall UpdateMemoryLabel(void);
	void __fastcall Copy(void);
	void __fastcall Paste(void);
	__property System::Extended DisplayValue = {read=GetDisplay, write=SetDisplay};
	__property System::UnicodeString Text = {read=FText};
	__property System::Classes::TNotifyEvent OnResultClick = {read=FOnResult, write=FOnResult};
	__property System::Classes::TNotifyEvent OnError = {read=FOnError, write=FOnError};
	__property System::Classes::TNotifyEvent OnTextChange = {read=FOnTextChange, write=FOnTextChange};
	__property Vcl::Controls::TKeyPressEvent OnCalcKey = {read=FOnCalcKey, write=FOnCalcKey};
	__property System::Classes::TNotifyEvent OnDisplayChange = {read=FOnDisplayChange, write=FOnDisplayChange};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TsCalcForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TsCalcForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TsCalcForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsCalcForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Scalcunit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SCALCUNIT)
using namespace Scalcunit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ScalcunitHPP
