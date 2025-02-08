// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextCheckGroup.pas' rev: 31.00 (Windows)

#ifndef LmdtextcheckgroupHPP
#define LmdtextcheckgroupHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDTextObject.hpp>
#include <LMDText.hpp>
#include <LMDCustomCheckGroup.hpp>
#include <LMDCustomButtonGroup.hpp>
#include <LMDCustomGroupBox.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextcheckgroup
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextCheckGroup;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextCheckGroup : public Lmdcustomcheckgroup::TLMDCustomCheckGroup
{
	typedef Lmdcustomcheckgroup::TLMDCustomCheckGroup inherited;
	
private:
	Lmdtextobject::TLMDTextObject* FText;
	Lmdtext::TLMDGetVariableEvent FOnGetVariable;
	void __fastcall SetTextObject(Lmdtextobject::TLMDTextObject* aValue);
	
protected:
	virtual System::UnicodeString __fastcall DoGetVariable(System::TObject* Sender, const System::UnicodeString aVarName);
	void __fastcall DoTxtChange(System::TObject* Sender);
	virtual void __fastcall SetButtonCount(int aValue);
	virtual void __fastcall UpdateButtons(void);
	
public:
	__fastcall virtual TLMDTextCheckGroup(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDTextCheckGroup(void);
	
__published:
	__property Lmdtextobject::TLMDTextObject* TextSettings = {read=FText, write=SetTextObject};
	__property Value = {default=0};
	__property IgnoreValue = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTextCheckGroup(HWND ParentWindow) : Lmdcustomcheckgroup::TLMDCustomCheckGroup(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextcheckgroup */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTCHECKGROUP)
using namespace Lmdtextcheckgroup;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextcheckgroupHPP
