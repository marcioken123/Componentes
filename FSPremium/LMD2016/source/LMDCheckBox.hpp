// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCheckBox.pas' rev: 31.00 (Windows)

#ifndef LmdcheckboxHPP
#define LmdcheckboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomCheckBox.hpp>
#include <LMDCustomControl.hpp>
#include <LMDButtonControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <Vcl.StdCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcheckbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCheckBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCheckBox : public Lmdcustomcheckbox::TLMDCustomCheckBox
{
	typedef Lmdcustomcheckbox::TLMDCustomCheckBox inherited;
	
__published:
	__property BackFX;
	__property Checked = {default=0};
	__property State = {default=0};
public:
	/* TLMDCustomCheckBox.Create */ inline __fastcall virtual TLMDCheckBox(System::Classes::TComponent* aOwner) : Lmdcustomcheckbox::TLMDCustomCheckBox(aOwner) { }
	/* TLMDCustomCheckBox.Destroy */ inline __fastcall virtual ~TLMDCheckBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCheckBox(HWND ParentWindow) : Lmdcustomcheckbox::TLMDCustomCheckBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcheckbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHECKBOX)
using namespace Lmdcheckbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcheckboxHPP
