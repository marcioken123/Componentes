// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sToolBar.pas' rev: 27.00 (Windows)

#ifndef StoolbarHPP
#define StoolbarHPP

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
#include <Vcl.ToolWin.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sDefaults.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Stoolbar
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsToolBar;
class PASCALIMPLEMENTATION TsToolBar : public Vcl::Comctrls::TToolBar
{
	typedef Vcl::Comctrls::TToolBar inherited;
	
private:
	int HotButtonIndex;
	Scommondata::TsCommonData* FCommonData;
	Sconst::TsDisabledKind FDisabledKind;
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Message);
	void __fastcall SetDisabledKind(const Sconst::TsDisabledKind Value);
	
protected:
	Vcl::Comctrls::TToolButton* DroppedButton;
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	int __fastcall OffsetX(void);
	int __fastcall OffsetY(void);
	bool __fastcall PrepareCache(void);
	void __fastcall OurAdvancedCustomDraw(Vcl::Comctrls::TToolBar* Sender, const System::Types::TRect &ARect, Vcl::Comctrls::TCustomDrawStage Stage, bool &DefaultDraw);
	void __fastcall OurAdvancedCustomDrawButton(Vcl::Comctrls::TToolBar* Sender, Vcl::Comctrls::TToolButton* Button, Vcl::Comctrls::TCustomDrawState State, Vcl::Comctrls::TCustomDrawStage Stage, Vcl::Comctrls::TTBCustomDrawFlags &Flags, bool &DefaultDraw);
	System::Types::TRect __fastcall GetButtonRect(int Index);
	int __fastcall IndexByMouse(const System::Types::TPoint &MousePos);
	void __fastcall RepaintButton(int Index);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TsToolBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsToolBar(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Loaded(void);
	void __fastcall UpdateEvents(void);
	
__published:
	__property Flat = {default=1};
	__property Sconst::TsDisabledKind BtnDisabledKind = {read=FDisabledKind, write=SetDisabledKind, default=1};
	__property Scommondata::TsCommonData* SkinData = {read=FCommonData, write=FCommonData};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsToolBar(HWND ParentWindow) : Vcl::Comctrls::TToolBar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Stoolbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_STOOLBAR)
using namespace Stoolbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// StoolbarHPP
