// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomExtSpinEdit.pas' rev: 31.00 (Windows)

#ifndef LmdcustomextspineditHPP
#define LmdcustomextspineditHPP

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
#include <LMDTypes.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDSpinButton.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDSBtn.hpp>
#include <LMDButtonBase.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomextspinedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomExtSpinEdit;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDOnValueChangingEvent)(System::TObject* Sender, double &Val, bool &CanModify);

typedef void __fastcall (__closure *TLMDOnValueChangedEvent)(System::TObject* Sender, double OldVal, double NewVal);

class PASCALIMPLEMENTATION TLMDCustomExtSpinEdit : public Lmdcustommaskedit::TLMDCustomMaskEdit
{
	typedef Lmdcustommaskedit::TLMDCustomMaskEdit inherited;
	
private:
	bool FAutoDisableButtons;
	Lmdspinbutton::TLMDSpinButton* FSpinBtn;
	int FSpinBtnWidth;
	bool FInfiniteMax;
	bool FInfiniteMin;
	bool FEditorEnabled;
	Lmdcustommaskedit::TLMDNumberType FType;
	double FValue;
	double FFractionStep;
	double FLargeStep;
	double FStep;
	System::Classes::TNotifyEvent FOnUpClick;
	System::Classes::TNotifyEvent FOnDownClick;
	TLMDOnValueChangedEvent FOnValueChanged;
	TLMDOnValueChangingEvent FOnValueChanging;
	bool FCheckOnExitOnly;
	bool FCheckBounds;
	HIDESBASE void __fastcall SetInteger(int index, int aValue);
	void __fastcall SetType(Lmdcustommaskedit::TLMDNumberType aValue);
	HIDESBASE void __fastcall SetDouble(int index, double aValue);
	HIDESBASE void __fastcall SetColor(int Index, const System::Uitypes::TColor Value);
	void __fastcall SetDiag(const bool Value);
	void __fastcall SetInterval(const System::Word Value);
	System::Uitypes::TColor __fastcall GetColor(int Index);
	System::Word __fastcall GetInterval(void);
	bool __fastcall GetDiag(void);
	bool __fastcall IsNoDefault(void);
	bool __fastcall IsNoFractionDefault(void);
	bool __fastcall IsNoLargeDefault(void);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMKILLFOCUS(Winapi::Messages::TWMKillFocus &Message);
	void __fastcall SetAutoDisableButtons(const bool Value);
	void __fastcall SetCheckOnExitOnly(const bool Value);
	bool __fastcall GetSpinBtnVisible(void);
	void __fastcall SetSpinBtnVisible(const bool Value);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DoInc(System::TObject* Sender);
	virtual void __fastcall DoDec(System::TObject* Sender);
	virtual void __fastcall DoValueChanging(System::TObject* Sender, double &Val, bool &CanModify);
	virtual void __fastcall DoValueChanged(System::TObject* Sender, double OldVal, double NewVal);
	void __fastcall Increment(double by);
	void __fastcall Decrement(double by);
	DYNAMIC void __fastcall GetCommandKey(System::Word &KeyCode, System::Classes::TShiftState Shift);
	virtual void __fastcall ChangedText(int At);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual bool __fastcall AllowedOperation(Lmdtypes::TLMDString textToInsert);
	System::UnicodeString __fastcall GetOutString(double aValue);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseExit(void);
	virtual void __fastcall DoThemeChanged(void);
	DYNAMIC bool __fastcall DoMouseWheelDown(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	virtual void __fastcall ModifyPaintRect(void);
	void __fastcall UpdateSpinButtons(void);
	__property bool SpinBtnVisible = {read=GetSpinBtnVisible, write=SetSpinBtnVisible, default=1};
	__property Lmdcustommaskedit::TLMDNumberType EditType = {read=FType, write=SetType, default=0};
	__property double Value = {read=FValue, write=SetDouble, index=2};
	__property bool InfiniteMax = {read=FInfiniteMax, write=FInfiniteMax, default=0};
	__property bool InfiniteMin = {read=FInfiniteMin, write=FInfiniteMin, default=0};
	__property double LargeStep = {read=FLargeStep, write=FLargeStep, stored=IsNoLargeDefault};
	__property double FractionStep = {read=FFractionStep, write=FFractionStep, stored=IsNoFractionDefault};
	
public:
	__fastcall virtual TLMDCustomExtSpinEdit(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomExtSpinEdit(void);
	
__published:
	__property AutoSize = {default=0};
	__property bool AutoDisableButtons = {read=FAutoDisableButtons, write=SetAutoDisableButtons, default=0};
	__property Alignment = {default=0};
	__property bool CheckOnExitOnly = {read=FCheckOnExitOnly, write=SetCheckOnExitOnly, default=0};
	__property CustomButtons;
	__property CustomButtonsStyle = {default=9};
	__property CustomButtonWidth = {default=16};
	__property CustomButtonParentCtlXP = {default=1};
	__property ForceOverwriteMode = {default=0};
	__property System::Word Interval = {read=GetInterval, write=SetInterval, default=100};
	__property int SpinBtnWidth = {read=FSpinBtnWidth, write=SetInteger, index=0, default=-1};
	__property System::Uitypes::TColor SpinBtnColor = {read=GetColor, write=SetColor, index=0, default=-16777201};
	__property bool SpinBtnDiag = {read=GetDiag, write=SetDiag, default=1};
	__property System::Uitypes::TColor SpinBtnHotColor = {read=GetColor, write=SetColor, index=1, default=8421376};
	__property double Step = {read=FStep, write=FStep, stored=IsNoDefault};
	__property bool EditorEnabled = {read=FEditorEnabled, write=FEditorEnabled, default=1};
	__property ReadOnly = {index=1, default=0};
	__property System::Classes::TNotifyEvent OnSpinBtnUpClick = {read=FOnUpClick, write=FOnUpClick};
	__property System::Classes::TNotifyEvent OnSpinBtnDownClick = {read=FOnDownClick, write=FOnDownClick};
	__property TLMDOnValueChangedEvent OnValueChanged = {read=FOnValueChanged, write=FOnValueChanged};
	__property TLMDOnValueChangingEvent OnValueChanging = {read=FOnValueChanging, write=FOnValueChanging};
	__property Options = {default=56};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomExtSpinEdit(HWND ParentWindow) : Lmdcustommaskedit::TLMDCustomMaskEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomextspinedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMEXTSPINEDIT)
using namespace Lmdcustomextspinedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomextspineditHPP
