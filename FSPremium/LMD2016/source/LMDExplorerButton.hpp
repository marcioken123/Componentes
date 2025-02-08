// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDExplorerButton.pas' rev: 31.00 (Windows)

#ifndef LmdexplorerbuttonHPP
#define LmdexplorerbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDButtonBase.hpp>
#include <LMDOfficeButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdexplorerbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDExplorerButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDExplorerButton : public Lmdofficebutton::TLMDOfficeButton
{
	typedef Lmdofficebutton::TLMDOfficeButton inherited;
	
protected:
	void __fastcall ColReadIdent(System::Classes::TReader* Reader);
	void __fastcall TransReadIdent(System::Classes::TReader* Reader);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TLMDExplorerButton(System::Classes::TComponent* AOwner);
	__property Transparent = {default=1};
	
__published:
	__property bool AllowAllUp = {read=GetAllowAllUp, write=SetAllowAllUp, default=0};
	__property bool UnColorMain = {read=GetUnColorMain, write=SetUnColorMain, default=1};
	__property GroupIndex = {default=0};
	__property Pressed = {default=0};
	__property Style;
public:
	/* TLMDCustomSpeedButton.Destroy */ inline __fastcall virtual ~TLMDExplorerButton(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdexplorerbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDEXPLORERBUTTON)
using namespace Lmdexplorerbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdexplorerbuttonHPP
