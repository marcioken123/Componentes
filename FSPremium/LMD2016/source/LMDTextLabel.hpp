// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextLabel.pas' rev: 31.00 (Windows)

#ifndef LmdtextlabelHPP
#define LmdtextlabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDTextCustomLabel.hpp>
#include <Vcl.Controls.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <LMDTextObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextlabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextLabel : public Lmdtextcustomlabel::TLMDTextCustomLabel
{
	typedef Lmdtextcustomlabel::TLMDTextCustomLabel inherited;
	
__published:
	__property Color = {default=-16777211};
	__property Lines;
public:
	/* TLMDTextCustomLabel.Create */ inline __fastcall virtual TLMDTextLabel(System::Classes::TComponent* aOwner) : Lmdtextcustomlabel::TLMDTextCustomLabel(aOwner) { }
	/* TLMDTextCustomLabel.Destroy */ inline __fastcall virtual ~TLMDTextLabel(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextlabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTLABEL)
using namespace Lmdtextlabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextlabelHPP
