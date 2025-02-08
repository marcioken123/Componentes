// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCheckGroupButton.pas' rev: 31.00 (Windows)

#ifndef LmdcheckgroupbuttonHPP
#define LmdcheckgroupbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <LMDCustomCheckGroup.hpp>
#include <LMDCheckBox.hpp>
#include <LMDButtonControl.hpp>
#include <LMDCustomCheckBox.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcheckgroupbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCheckGroupButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCheckGroupButton : public Lmdcheckbox::TLMDCheckBox
{
	typedef Lmdcheckbox::TLMDCheckBox inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMKey(Winapi::Messages::TWMKey &Msg);
	
protected:
	virtual bool __fastcall CanModify(void);
	DYNAMIC void __fastcall ChangeScale(int M, int D)/* overload */;
	virtual void __fastcall Toggle(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Msg);
	
public:
	__fastcall TLMDCheckGroupButton(Lmdcustomcheckgroup::TLMDCustomCheckGroup* Group);
	__fastcall virtual ~TLMDCheckGroupButton(void);
	__property Transparent = {default=1};
public:
	/* TLMDCustomCheckBox.Create */ inline __fastcall virtual TLMDCheckGroupButton(System::Classes::TComponent* aOwner) : Lmdcheckbox::TLMDCheckBox(aOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCheckGroupButton(HWND ParentWindow) : Lmdcheckbox::TLMDCheckBox(ParentWindow) { }
	
	/* Hoisted overloads: */
	
protected:
	DYNAMIC inline void __fastcall  ChangeScale(int M, int D, bool isDpiChange){ Vcl::Controls::TWinControl::ChangeScale(M, D, isDpiChange); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcheckgroupbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHECKGROUPBUTTON)
using namespace Lmdcheckgroupbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcheckgroupbuttonHPP
