// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sCalculator.pas' rev: 27.00 (Windows)

#ifndef ScalculatorHPP
#define ScalculatorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <sCalcUnit.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Scalculator
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TacCalcTitleButton : unsigned char { cbClose, cbMinimize };

typedef System::Set<TacCalcTitleButton, TacCalcTitleButton::cbClose, TacCalcTitleButton::cbMinimize> TacCalcTitleButtons;

class DELPHICLASS TsCalculator;
class PASCALIMPLEMENTATION TsCalculator : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Scalcunit::TsCalcForm* FCalc;
	System::Extended FValue;
	System::Extended FMemory;
	System::UnicodeString FCaption;
	System::Byte FPrecision;
	bool FBeepOnError;
	System::Classes::THelpContext FHelpContext;
	System::Classes::TNotifyEvent FOnChange;
	Vcl::Controls::TKeyPressEvent FOnCalcKey;
	System::Classes::TNotifyEvent FOnDisplayChange;
	TacCalcTitleButtons FTitleButtons;
	int FScaleIncrement;
	System::Extended __fastcall GetDisplay(void);
	void __fastcall SetScaleIncrement(const int Value);
	
protected:
	bool Scaled;
	void __fastcall Change(void);
	void __fastcall CalcKey(System::WideChar &Key);
	void __fastcall DisplayChange(void);
	
public:
	__fastcall virtual TsCalculator(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsCalculator(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall AfterConstruction(void);
	__property System::Extended CalcDisplay = {read=GetDisplay};
	__property System::Extended Memory = {read=FMemory};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property System::Classes::TNotifyEvent OnDisplayChange = {read=FOnDisplayChange, write=FOnDisplayChange};
	bool __fastcall Execute(bool IsModal = false, int LeftPos = 0xffffffff, int TopPos = 0xffffffff);
	
__published:
	__property bool BeepOnError = {read=FBeepOnError, write=FBeepOnError, default=1};
	__property System::Byte Precision = {read=FPrecision, write=FPrecision, default=24};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property System::Extended Value = {read=FValue, write=FValue};
	__property int ScaleIncrement = {read=FScaleIncrement, write=SetScaleIncrement, nodefault};
	__property TacCalcTitleButtons TitleButtons = {read=FTitleButtons, write=FTitleButtons, default=3};
	__property System::Classes::THelpContext HelpContext = {read=FHelpContext, write=FHelpContext, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Scalculator */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SCALCULATOR)
using namespace Scalculator;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ScalculatorHPP
