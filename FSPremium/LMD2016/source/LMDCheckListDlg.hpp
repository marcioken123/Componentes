// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCheckListDlg.pas' rev: 31.00 (Windows)

#ifndef LmdchecklistdlgHPP
#define LmdchecklistdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Forms.hpp>
#include <System.Classes.hpp>
#include <LMDCustomCheckListDlg.hpp>
#include <LMDBaseDialog.hpp>
#include <LMDContainerComponent.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchecklistdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCheckListDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCheckListDlg : public Lmdcustomchecklistdlg::TLMDCustomCheckListDlg
{
	typedef Lmdcustomchecklistdlg::TLMDCustomCheckListDlg inherited;
	
__published:
	__property Items;
public:
	/* TLMDCustomCheckListDlg.Create */ inline __fastcall virtual TLMDCheckListDlg(System::Classes::TComponent* aOwner) : Lmdcustomchecklistdlg::TLMDCustomCheckListDlg(aOwner) { }
	/* TLMDCustomCheckListDlg.Destroy */ inline __fastcall virtual ~TLMDCheckListDlg(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchecklistdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHECKLISTDLG)
using namespace Lmdchecklistdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchecklistdlgHPP
