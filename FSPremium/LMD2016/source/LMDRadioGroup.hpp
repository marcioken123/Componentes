// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRadioGroup.pas' rev: 31.00 (Windows)

#ifndef LmdradiogroupHPP
#define LmdradiogroupHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomRadioGroup.hpp>
#include <LMDCustomButtonGroup.hpp>
#include <LMDCustomGroupBox.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdradiogroup
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRadioGroup;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRadioGroup : public Lmdcustomradiogroup::TLMDCustomRadioGroup
{
	typedef Lmdcustomradiogroup::TLMDCustomRadioGroup inherited;
	
__published:
	__property ItemIndex = {default=-1};
public:
	/* TLMDCustomRadioGroup.Create */ inline __fastcall virtual TLMDRadioGroup(System::Classes::TComponent* AOwner) : Lmdcustomradiogroup::TLMDCustomRadioGroup(AOwner) { }
	
public:
	/* TLMDCustomButtonGroup.Destroy */ inline __fastcall virtual ~TLMDRadioGroup(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRadioGroup(HWND ParentWindow) : Lmdcustomradiogroup::TLMDCustomRadioGroup(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdradiogroup */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRADIOGROUP)
using namespace Lmdradiogroup;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdradiogroupHPP
