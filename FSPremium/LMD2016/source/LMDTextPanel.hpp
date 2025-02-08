// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextPanel.pas' rev: 31.00 (Windows)

#ifndef LmdtextpanelHPP
#define LmdtextpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDTextCustomPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <LMDGraph.hpp>
#include <LMDTextObject.hpp>
#include <LMDTextContainer.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextpanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextPanel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextPanel : public Lmdtextcustompanel::TLMDTextCustomPanel
{
	typedef Lmdtextcustompanel::TLMDTextCustomPanel inherited;
	
__published:
	__property Alignment = {default=4};
	__property AutoSize = {default=0};
	__property Lines;
	__property OnLinkClick;
	__property TextContainer;
	__property TextIndex = {default=0};
	__property CheckContainerLinks = {default=0};
public:
	/* TLMDTextCustomPanel.Create */ inline __fastcall virtual TLMDTextPanel(System::Classes::TComponent* aOwner) : Lmdtextcustompanel::TLMDTextCustomPanel(aOwner) { }
	/* TLMDTextCustomPanel.Destroy */ inline __fastcall virtual ~TLMDTextPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTextPanel(HWND ParentWindow) : Lmdtextcustompanel::TLMDTextCustomPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextpanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTPANEL)
using namespace Lmdtextpanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextpanelHPP
