// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomExtCombo.pas' rev: 31.00 (Windows)

#ifndef LmdcustomextcomboHPP
#define LmdcustomextcomboHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <LMDButtonBase.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomextcombo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomExtCombo;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDDropDownStyle : unsigned char { csDropDown, csDropDownList };

typedef void __fastcall (__closure *TLMDAllowDropEvent)(System::TObject* Sender, bool &AllowDrop);

class PASCALIMPLEMENTATION TLMDCustomExtCombo : public Lmdcustommaskedit::TLMDCustomMaskEdit
{
	typedef Lmdcustommaskedit::TLMDCustomMaskEdit inherited;
	
private:
	bool FDroppedDown;
	int FDropDownHeight;
	int FDropDownWidth;
	TLMDAllowDropEvent FOnCanDropDown;
	System::Classes::TNotifyEvent FOnBeforeDropDown;
	System::Classes::TNotifyEvent FOnDropDownAccept;
	System::Classes::TNotifyEvent FOnDropDownCancel;
	System::Classes::TNotifyEvent FOnDropDown;
	System::Classes::TWndMethod FOldControlProc;
	bool FAllowDownKey;
	TLMDDropDownStyle FDropDownStyle;
	HIDESBASE void __fastcall SetBoolean(bool aValue);
	void __fastcall SetDropDownStyle(TLMDDropDownStyle aValue);
	HIDESBASE MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMKEYDown(Winapi::Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSYSKEYDOWN(Winapi::Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMKEYUP(Winapi::Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMCHAR(Winapi::Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	MESSAGE void __fastcall CMCancelMode(Vcl::Controls::TCMCancelMode &Message);
	HIDESBASE MESSAGE void __fastcall WMCancelMode(Winapi::Messages::TWMNoParams &Msg);
	
protected:
	Vcl::Controls::TWinControl* FControl;
	int FItemIndex;
	bool FClickHandled;
	virtual void __fastcall AdjustDropDownPosition(System::Types::TPoint &P);
	void __fastcall NewControlProc(Winapi::Messages::TMessage &Msg);
	virtual bool __fastcall GetListMode(void);
	virtual void __fastcall DrawSpecialTextBackground(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect);
	void __fastcall CreateAndSetup(void);
	void __fastcall DoDropDownClick(System::TObject* Sender);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseEnter(void);
	void __fastcall DoBtnMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall DoBtnMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall DropDown(void);
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall CreateControl(void) = 0 ;
	virtual void __fastcall ModifyControl(void);
	virtual void __fastcall ReModifyControl(void);
	virtual bool __fastcall CanDropDown(void);
	virtual void __fastcall DisplayControl(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall Cancel(void);
	virtual void __fastcall Accept(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall CheckModified(void);
	HIDESBASE virtual Vcl::Controls::TWinControl* __fastcall GetControl(void);
	virtual void __fastcall DoDownKey(void);
	virtual void __fastcall DoUpKey(void);
	__property bool AllowDownKey = {read=FAllowDownKey, write=FAllowDownKey, nodefault};
	__property TLMDDropDownStyle Style = {read=FDropDownStyle, write=SetDropDownStyle, default=0};
	
public:
	__fastcall virtual TLMDCustomExtCombo(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomExtCombo(void);
	virtual void __fastcall Open(void);
	void __fastcall Close(bool acc = false);
	virtual void __fastcall Init(void);
	__property bool DroppedDown = {read=FDroppedDown, write=SetBoolean, default=0};
	__property Vcl::Controls::TWinControl* Control = {read=GetControl};
	__property int DropDownWidth = {read=FDropDownWidth, write=FDropDownWidth, default=0};
	__property int DropDownHeight = {read=FDropDownHeight, write=FDropDownHeight, default=0};
	
__published:
	__property Alignment = {default=0};
	__property CustomButtonsStyle = {default=10};
	__property CustomButtonWidth = {default=16};
	__property System::Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property TLMDAllowDropEvent OnAllowDropDown = {read=FOnCanDropDown, write=FOnCanDropDown};
	__property System::Classes::TNotifyEvent OnBeforeDropDown = {read=FOnBeforeDropDown, write=FOnBeforeDropDown};
	__property System::Classes::TNotifyEvent OnDropDownAccept = {read=FOnDropDownAccept, write=FOnDropDownAccept};
	__property System::Classes::TNotifyEvent OnDropDownCancel = {read=FOnDropDownCancel, write=FOnDropDownCancel};
	__property Options = {default=56};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomExtCombo(HWND ParentWindow) : Lmdcustommaskedit::TLMDCustomMaskEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomextcombo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMEXTCOMBO)
using namespace Lmdcustomextcombo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomextcomboHPP
