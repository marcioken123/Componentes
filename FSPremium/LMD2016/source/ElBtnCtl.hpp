// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElBtnCtl.pas' rev: 31.00 (Windows)

#ifndef ElbtnctlHPP
#define ElbtnctlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Menus.hpp>
#include <System.Types.hpp>
#include <Vcl.Themes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ActnList.hpp>
#include <System.Classes.hpp>
#include <ElVCLUtils.hpp>
#include <ElXPThemedControl.hpp>
#include <LMDSysIn.hpp>
#include <LMDGraph.hpp>
#include <LMDTypes.hpp>
#include <LMDUtils.hpp>
#include <System.Actions.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elbtnctl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElButtonControl;
class DELPHICLASS TElButtonActionLink;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElButtonControl : public Elxpthemedcontrol::TElXPThemedControl
{
	typedef Elxpthemedcontrol::TElXPThemedControl inherited;
	
private:
	HIDESBASE bool __fastcall IsCaptionStored(void);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	
protected:
	bool FTransparent;
	Lmdgraph::TLMDTextDrawType FTextDrawType;
	bool F2000DrawFocus;
	bool F2000DrawAccel;
	HIDESBASE MESSAGE void __fastcall WMMove(Winapi::Messages::TWMMove &Msg);
	void __fastcall SetTextDrawType(Lmdgraph::TLMDTextDrawType newValue);
	bool ClicksDisabled;
	Lmdtypes::TLMDString FCaption;
	Lmdtypes::TLMDString FHint;
	bool FMoneyFlat;
	System::Uitypes::TColor FMoneyFlatActiveColor;
	System::Uitypes::TColor FMoneyFlatInactiveColor;
	System::Uitypes::TColor FMoneyFlatDownColor;
	HIDESBASE bool __fastcall IsHintStored(void);
	virtual bool __fastcall GetChecked(void) = 0 ;
	virtual void __fastcall SetChecked(bool newValue) = 0 ;
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall SetTransparent(bool newValue);
	DYNAMIC Vcl::Controls::TControlActionLinkClass __fastcall GetActionLinkClass(void);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	__property bool Checked = {read=GetChecked, write=SetChecked, default=0};
	__property Lmdgraph::TLMDTextDrawType TextDrawType = {read=FTextDrawType, write=SetTextDrawType, default=0};
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	void __fastcall SetCaption(Lmdtypes::TLMDString Value);
	virtual Vcl::Themes::TThemedElement __fastcall GetThemedElement(void);
	bool __fastcall GetUIStateDrawFocus(void);
	bool __fastcall GetUIStateDrawAccel(void);
	MESSAGE void __fastcall WMUpdateUIState(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMChangeUIState(Winapi::Messages::TMessage &Message);
	void __fastcall SetMoneyFlat(bool Value);
	void __fastcall SetMoneyFlatActiveColor(System::Uitypes::TColor Value);
	void __fastcall SetMoneyFlatInactiveColor(System::Uitypes::TColor Value);
	void __fastcall SetMoneyFlatDownColor(System::Uitypes::TColor Value);
	bool __fastcall GetMoneyFlat(void);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation operation);
	
public:
	__fastcall virtual TElButtonControl(System::Classes::TComponent* Owner);
	__fastcall virtual ~TElButtonControl(void);
	__property Color;
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption, stored=IsCaptionStored};
	__property bool MoneyFlat = {read=GetMoneyFlat, write=SetMoneyFlat, default=0};
	__property System::Uitypes::TColor MoneyFlatActiveColor = {read=FMoneyFlatActiveColor, write=SetMoneyFlatActiveColor, stored=GetMoneyFlat, nodefault};
	__property System::Uitypes::TColor MoneyFlatInactiveColor = {read=FMoneyFlatInactiveColor, write=SetMoneyFlatInactiveColor, stored=GetMoneyFlat, nodefault};
	__property System::Uitypes::TColor MoneyFlatDownColor = {read=FMoneyFlatDownColor, write=SetMoneyFlatDownColor, stored=GetMoneyFlat, nodefault};
	__property bool UIStateDrawFocus = {read=GetUIStateDrawFocus, nodefault};
	__property bool UIStateDrawAccel = {read=GetUIStateDrawAccel, nodefault};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	
__published:
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint, stored=IsHintStored};
	__property DoubleBuffered;
public:
	/* TWinControl.CreateParented */ inline __fastcall TElButtonControl(HWND ParentWindow) : Elxpthemedcontrol::TElXPThemedControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElButtonActionLink : public Vcl::Controls::TWinControlActionLink
{
	typedef Vcl::Controls::TWinControlActionLink inherited;
	
protected:
	TElButtonControl* FClient;
	virtual void __fastcall SetCaption(const System::UnicodeString Value);
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual bool __fastcall IsImageIndexLinked(void);
	virtual void __fastcall SetChecked(bool Value);
	virtual void __fastcall SetHint(const System::UnicodeString Value);
	virtual bool __fastcall IsCaptionLinked(void);
	virtual bool __fastcall IsHintLinked(void);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TElButtonActionLink(System::TObject* AClient) : Vcl::Controls::TWinControlActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TElButtonActionLink(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elbtnctl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELBTNCTL)
using namespace Elbtnctl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElbtnctlHPP
