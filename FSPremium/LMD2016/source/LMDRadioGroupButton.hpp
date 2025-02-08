// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRadioGroupButton.pas' rev: 31.00 (Windows)

#ifndef LmdradiogroupbuttonHPP
#define LmdradiogroupbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <LMDCustomRadioGroup.hpp>
#include <LMDCustomButtonGroup.hpp>
#include <LMDRadioButton.hpp>
#include <LMDButtonControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdradiogroupbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRadioGroupButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRadioGroupButton : public Lmdradiobutton::TLMDRadioButton
{
	typedef Lmdradiobutton::TLMDRadioButton inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyUp(Winapi::Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMKey(Winapi::Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMLMouseDown(Winapi::Messages::TWMMouse &Msg);
	MESSAGE void __fastcall WMLMouseUp(Winapi::Messages::TWMMouse &Msg);
	MESSAGE void __fastcall WMRMouseDown(Winapi::Messages::TWMMouse &Msg);
	MESSAGE void __fastcall WMRMouseUp(Winapi::Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Msg);
	
protected:
	virtual bool __fastcall CanModify(void);
	virtual void __fastcall SetChecked(bool aValue);
	DYNAMIC void __fastcall ChangeScale(int M, int D)/* overload */;
	DYNAMIC void __fastcall DblClick(void);
	
public:
	__fastcall TLMDRadioGroupButton(Lmdcustomradiogroup::TLMDCustomRadioGroup* Group);
	__fastcall virtual ~TLMDRadioGroupButton(void);
	__property Transparent = {default=1};
public:
	/* TLMDRadioButton.Create */ inline __fastcall virtual TLMDRadioGroupButton(System::Classes::TComponent* aOwner) : Lmdradiobutton::TLMDRadioButton(aOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRadioGroupButton(HWND ParentWindow) : Lmdradiobutton::TLMDRadioButton(ParentWindow) { }
	
	/* Hoisted overloads: */
	
protected:
	DYNAMIC inline void __fastcall  ChangeScale(int M, int D, bool isDpiChange){ Vcl::Controls::TWinControl::ChangeScale(M, D, isDpiChange); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdradiogroupbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRADIOGROUPBUTTON)
using namespace Lmdradiogroupbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdradiogroupbuttonHPP
