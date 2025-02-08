// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTreeCurrEdit.pas' rev: 31.00 (Windows)

#ifndef EltreecurreditHPP
#define EltreecurreditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <LMDProcs.hpp>
#include <LMDTypes.hpp>
#include <LMDStrings.hpp>
#include <LMDVldBase.hpp>
#include <ElStyleMan.hpp>
#include <ElCalc.hpp>
#include <ElTree.hpp>
#include <ElHeader.hpp>
#include <ElCurrEdit.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElXPThemedControl.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltreecurredit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THackInplaceCurrencyEdit;
class DELPHICLASS TElTreeInplaceCurrencyEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION THackInplaceCurrencyEdit : public Elcurredit::TElCurrencyEdit
{
	typedef Elcurredit::TElCurrencyEdit inherited;
	
__published:
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState ShiftState);
public:
	/* TElCurrencyEdit.Create */ inline __fastcall virtual THackInplaceCurrencyEdit(System::Classes::TComponent* AOwner) : Elcurredit::TElCurrencyEdit(AOwner) { }
	/* TElCurrencyEdit.Destroy */ inline __fastcall virtual ~THackInplaceCurrencyEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THackInplaceCurrencyEdit(HWND ParentWindow) : Elcurredit::TElCurrencyEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElTreeInplaceCurrencyEdit : public Eltreeinplaceeditors::TElTreeInplaceEditor
{
	typedef Eltreeinplaceeditors::TElTreeInplaceEditor inherited;
	
private:
	bool FCalcDlgButtonVisible;
	System::StaticArray<System::Classes::TWndMethod, 2> SaveIntWndProc;
	System::Classes::TWndMethod SaveWndProc;
	System::UnicodeString __fastcall GetValidationMsgString(void);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	void __fastcall SetValidationMsgString(const System::UnicodeString Value);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* const Value);
	Lmdvldbase::TLMDValidationErrorEvent __fastcall GetOnValidationError(void);
	void __fastcall SetOnValidationError(const Lmdvldbase::TLMDValidationErrorEvent Value);
	void __fastcall EditorWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall IntEditorWndProc2(Winapi::Messages::TMessage &Message);
	void __fastcall IntEditorWndProc1(Winapi::Messages::TMessage &Message);
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
	
protected:
	bool FIgnoreKillFocus;
	virtual void __fastcall AdjustBounds(void);
	Elcurredit::TElCurrencyEdit* __fastcall GetEditor(void);
	virtual void __fastcall DoStartOperation(void);
	virtual void __fastcall DoStopOperation(bool Accepted);
	virtual bool __fastcall GetVisible(void);
	virtual void __fastcall TriggerAfterOperation(bool &Accepted, bool &DefaultConversion);
	virtual void __fastcall TriggerBeforeOperation(bool &DefaultConversion);
	virtual void __fastcall SetEditorParent(void);
	void __fastcall RealWndProc(Winapi::Messages::TMessage &Message);
	Elstyleman::TElStyleManager* __fastcall GetStyleManager(void);
	System::UnicodeString __fastcall GetStyleName(void);
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	void __fastcall OnCalcDlg(System::TObject* Sender);
	void __fastcall OnCalcDlgClose(System::TObject* Sender);
	
public:
	__fastcall virtual TElTreeInplaceCurrencyEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTreeInplaceCurrencyEdit(void);
	__property Elcurredit::TElCurrencyEdit* Editor = {read=GetEditor};
	
__published:
	__property Elstyleman::TElStyleManager* StyleManager = {read=GetStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=GetStyleName, write=SetStyleName};
	__property Font;
	__property bool Sign = {read=GetSign, write=SetSign, nodefault};
	__property bool EnableSign = {read=GetEnableSign, write=SetEnableSign, nodefault};
	__property System::Uitypes::TColor NegativeSignColor = {read=GetNegativeSignColor, write=SetNegativeSignColor, nodefault};
	__property System::Uitypes::TColor NegativeValueTextColor = {read=GetNegativeValueTextColor, write=SetNegativeValueTextColor, nodefault};
	__property System::Byte DecimalPlaces = {read=GetDecimalPlaces, write=SetDecimalPlaces, nodefault};
	__property bool UseSystemDecimalPlaces = {read=GetUseSystemDecimalPlaces, write=SetUseSystemDecimalPlaces, nodefault};
	__property Lmdtypes::TLMDString CurrencySymbol = {read=GetCurrencySymbol, write=SetCurrencySymbol};
	__property Elcurredit::TElCurrencySymbolPosition CurrencySymbolPosition = {read=GetCurrencySymbolPosition, write=SetCurrencySymbolPosition, nodefault};
	__property bool UseSystemCurrencySymbol = {read=GetUseSystemCurrencySymbol, write=SetUseSystemCurrencySymbol, nodefault};
	__property bool CalcDlgButtonVisible = {read=FCalcDlgButtonVisible, write=FCalcDlgButtonVisible, stored=true, nodefault};
	__property System::UnicodeString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=GetOnValidationError, write=SetOnValidationError};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eltreecurredit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTREECURREDIT)
using namespace Eltreecurredit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltreecurreditHPP
