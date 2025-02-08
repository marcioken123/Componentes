// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHeaderPanelButton.pas' rev: 31.00 (Windows)

#ifndef LmdheaderpanelbuttonHPP
#define LmdheaderpanelbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDCustomHeaderPanel.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDButtonBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdheaderpanelbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHeaderPanelButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDHeaderPanelButton : public Lmdcustomspeedbutton::TLMDCustomSpeedButton
{
	typedef Lmdcustomspeedbutton::TLMDCustomSpeedButton inherited;
	
private:
	Lmdcustomheaderpanel::TLMDCustomHeaderPanel* FHeaderPanel;
	void __fastcall SetHeaderPanel(Lmdcustomheaderpanel::TLMDCustomHeaderPanel* aValue);
	
protected:
	void __fastcall DoModeChange(System::TObject* Sender);
	
public:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall Click(void);
	
__published:
	__property Lmdcustomheaderpanel::TLMDCustomHeaderPanel* HeaderPanel = {read=FHeaderPanel, write=SetHeaderPanel};
	__property ButtonStyle = {default=1};
public:
	/* TLMDCustomSpeedButton.Create */ inline __fastcall virtual TLMDHeaderPanelButton(System::Classes::TComponent* AOwner) : Lmdcustomspeedbutton::TLMDCustomSpeedButton(AOwner) { }
	/* TLMDCustomSpeedButton.Destroy */ inline __fastcall virtual ~TLMDHeaderPanelButton(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdheaderpanelbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHEADERPANELBUTTON)
using namespace Lmdheaderpanelbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdheaderpanelbuttonHPP
