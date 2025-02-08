// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdcustomcomboboxHPP
#define LmdcustomcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Themes.hpp>
#include <LMDClass.hpp>
#include <LMDBase.hpp>
#include <LMDVldBase.hpp>
#include <LMDTypes.hpp>
#include <LMDThemedComboBox.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomcombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomComboBox : public Lmdthemedcombobox::TLMDThemedComboBox
{
	typedef Lmdthemedcombobox::TLMDThemedComboBox inherited;
	
private:
	Lmdclass::TLMDTimer* FTimerId;
	System::Classes::TNotifyEvent FOnSelect;
	bool FFocused;
	bool FKeyed;
	bool FSearch;
	bool FRepaint;
	bool FFlat;
	int FWidth;
	int FTimerInterval;
	Vcl::Controls::TWinControl* FFocusCtrl;
	int FMRUCount;
	int FMRUMax;
	bool FMRUList;
	System::Classes::TNotifyEvent FOnEditClick;
	bool FUseGlobalTimer;
	void __fastcall SetBoolean(int index, bool aValue);
	void __fastcall SetSearch(bool aValue);
	void __fastcall SetInteger(int index, int aValue);
	HIDESBASE MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMThemeChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	void __fastcall RepaintBorder(void);
	void __fastcall DoTimerEvent(System::TObject* Sender);
	void __fastcall CreateTimer(void);
	void __fastcall FreeTimer(void);
	void __fastcall ExitCtrl(void);
	HWND __fastcall GetTopParentHandleFocusCtrl(void);
	
protected:
	Lmdvldbase::TLMDValidationEntity* FValidator;
	Lmdtypes::TLMDString FValidationMsgString;
	bool FErrorIndication;
	Lmdvldbase::TLMDValidationErrorEvent FOnValidationError;
	Lmdvldbase::TLMDValidatedListValue FValidatedValue;
	void __fastcall SetValidationMsgString(Lmdtypes::TLMDString val);
	Lmdtypes::TLMDString __fastcall GetValidationMsgString(void);
	HIDESBASE Vcl::Controls::TControl* __fastcall GetControl(void);
	Vcl::Graphics::TBrush* __fastcall GetControlBackBrush(void);
	Vcl::Graphics::TFont* __fastcall GetControlFont(void);
	Lmdtypes::TLMDString __fastcall GetValueToValidate(void);
	void __fastcall PaintSeparatorLine(const System::Types::TRect &aRect, int index);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall DoSelect(void);
	virtual void __fastcall ComboWndProc(Winapi::Messages::TMessage &Message, HWND ComboWnd, void * ComboProc);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDCustomComboBox(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomComboBox(void);
	bool __fastcall SupportsDefaultIndication(void);
	__property Vcl::Graphics::TFont* ControlFont = {read=GetControlFont};
	__property Vcl::Graphics::TBrush* ControlBackBrush = {read=GetControlBackBrush};
	void __fastcall RespondToError(int ErrorLevel);
	void __fastcall SetValidator(Lmdvldbase::TLMDValidationEntity* Validator);
	Lmdvldbase::TLMDValidationEntity* __fastcall GetValidator(void);
	bool __fastcall isMRUItem(int index);
	__property bool Flat = {read=FFlat, write=SetBoolean, index=0, default=0};
	__property bool Search = {read=FSearch, write=SetSearch, default=0};
	__property Vcl::Controls::TWinControl* FocusControl = {read=FFocusCtrl, write=FFocusCtrl};
	__property int Interval = {read=FTimerInterval, write=FTimerInterval, default=1500};
	__property int DropDownWidth = {read=FWidth, write=SetInteger, index=0, default=0};
	__property bool MRUList = {read=FMRUList, write=SetBoolean, index=1, default=0};
	__property int MRUMax = {read=FMRUMax, write=SetInteger, index=1, default=5};
	__property System::Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property System::Classes::TNotifyEvent OnEditClick = {read=FOnEditClick, write=FOnEditClick};
	__property bool UseGlobalTimer = {read=FUseGlobalTimer, write=FUseGlobalTimer, default=0};
	
__published:
	__property Lmdtypes::TLMDString ValidationMsgString = {read=GetValidationMsgString, write=SetValidationMsgString};
	__property Lmdvldbase::TLMDValidationEntity* Validator = {read=GetValidator, write=SetValidator};
	__property Lmdvldbase::TLMDValidatedListValue ValidatedValue = {read=FValidatedValue, write=FValidatedValue, default=0};
	__property Lmdvldbase::TLMDValidationErrorEvent OnValidationError = {read=FOnValidationError, write=FOnValidationError};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomComboBox(HWND ParentWindow) : Lmdthemedcombobox::TLMDThemedComboBox(ParentWindow) { }
	
private:
	void *__ILMDValidatedControl;	// Lmdvldbase::ILMDValidatedControl 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {ED0CAB4C-DBF2-4078-8C06-000841566690}
	operator Lmdvldbase::_di_ILMDValidatedControl()
	{
		Lmdvldbase::_di_ILMDValidatedControl intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdvldbase::ILMDValidatedControl*(void) { return (Lmdvldbase::ILMDValidatedControl*)&__ILMDValidatedControl; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 defHeight = System::Int8(0x10);
static const System::Int8 defBufferHeight = System::Int8(0xa);
}	/* namespace Lmdcustomcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMCOMBOBOX)
using namespace Lmdcustomcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomcomboboxHPP
