// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElFormPgCtl.pas' rev: 31.00 (Windows)

#ifndef ElformpgctlHPP
#define ElformpgctlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <System.Math.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Consts.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Menus.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <ElFormDisplay.hpp>
#include <ElPgCtl.hpp>
#include <ElXPThemedControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elformpgctl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElFormPageControl;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElFormPageControl : public Elpgctl::TElPageControl
{
	typedef Elpgctl::TElPageControl inherited;
	
private:
	Elformdisplay::TElFormDisplayChangeLink* FChangeLink;
	Elformdisplay::TElFormDisplay* FFormDisplay;
	void __fastcall SetFormDisplay(Elformdisplay::TElFormDisplay* const Value);
	
protected:
	virtual void __fastcall Change(void);
	void __fastcall DoFormDisplayChange(System::TObject* Sender);
	
public:
	__fastcall virtual TElFormPageControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElFormPageControl(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation operation);
	
__published:
	__property Elformdisplay::TElFormDisplay* FormDisplay = {read=FFormDisplay, write=SetFormDisplay};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElFormPageControl(HWND ParentWindow) : Elpgctl::TElPageControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elformpgctl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELFORMPGCTL)
using namespace Elformpgctl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElformpgctlHPP
