// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextCheckGroupButton.pas' rev: 31.00 (Windows)

#ifndef LmdtextcheckgroupbuttonHPP
#define LmdtextcheckgroupbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Messages.hpp>
#include <LMDCustomCheckGroup.hpp>
#include <LMDTextCheckBox.hpp>
#include <LMDButtonControl.hpp>
#include <LMDCustomCheckBox.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextcheckgroupbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextCheckGroupButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextCheckGroupButton : public Lmdtextcheckbox::TLMDTextCheckBox
{
	typedef Lmdtextcheckbox::TLMDTextCheckBox inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMKey(Winapi::Messages::TWMKey &Msg);
	
protected:
	virtual bool __fastcall CanModify(void);
	DYNAMIC void __fastcall ChangeScale(int M, int D)/* overload */;
	virtual void __fastcall Toggle(void);
	
public:
	__fastcall TLMDTextCheckGroupButton(Lmdcustomcheckgroup::TLMDCustomCheckGroup* Group);
	__fastcall virtual ~TLMDTextCheckGroupButton(void);
	__property Transparent = {default=1};
public:
	/* TLMDTextCheckBox.Create */ inline __fastcall virtual TLMDTextCheckGroupButton(System::Classes::TComponent* aOwner) : Lmdtextcheckbox::TLMDTextCheckBox(aOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTextCheckGroupButton(HWND ParentWindow) : Lmdtextcheckbox::TLMDTextCheckBox(ParentWindow) { }
	
	/* Hoisted overloads: */
	
protected:
	DYNAMIC inline void __fastcall  ChangeScale(int M, int D, bool isDpiChange){ Vcl::Controls::TWinControl::ChangeScale(M, D, isDpiChange); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextcheckgroupbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTCHECKGROUPBUTTON)
using namespace Lmdtextcheckgroupbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextcheckgroupbuttonHPP
