// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCheckGroup.pas' rev: 31.00 (Windows)

#ifndef LmdcheckgroupHPP
#define LmdcheckgroupHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomCheckGroup.hpp>
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

namespace Lmdcheckgroup
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCheckGroup;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCheckGroup : public Lmdcustomcheckgroup::TLMDCustomCheckGroup
{
	typedef Lmdcustomcheckgroup::TLMDCustomCheckGroup inherited;
	
__published:
	__property Value = {default=0};
	__property IgnoreValue = {default=0};
public:
	/* TLMDCustomCheckGroup.Create */ inline __fastcall virtual TLMDCheckGroup(System::Classes::TComponent* aOwner) : Lmdcustomcheckgroup::TLMDCustomCheckGroup(aOwner) { }
	
public:
	/* TLMDCustomButtonGroup.Destroy */ inline __fastcall virtual ~TLMDCheckGroup(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCheckGroup(HWND ParentWindow) : Lmdcustomcheckgroup::TLMDCustomCheckGroup(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcheckgroup */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHECKGROUP)
using namespace Lmdcheckgroup;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcheckgroupHPP
