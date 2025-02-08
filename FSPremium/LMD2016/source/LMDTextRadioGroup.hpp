// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextRadioGroup.pas' rev: 31.00 (Windows)

#ifndef LmdtextradiogroupHPP
#define LmdtextradiogroupHPP

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
#include <LMDCustomRadioGroup.hpp>
#include <LMDCustomButtonGroup.hpp>
#include <LMDCustomGroupBox.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextradiogroup
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextRadioGroup;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextRadioGroup : public Lmdcustomradiogroup::TLMDCustomRadioGroup
{
	typedef Lmdcustomradiogroup::TLMDCustomRadioGroup inherited;
	
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
	__fastcall virtual TLMDTextRadioGroup(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDTextRadioGroup(void);
	
__published:
	__property ItemIndex = {default=-1};
	__property Lmdtextobject::TLMDTextObject* TextSettings = {read=FText, write=SetTextObject};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTextRadioGroup(HWND ParentWindow) : Lmdcustomradiogroup::TLMDCustomRadioGroup(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextradiogroup */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTRADIOGROUP)
using namespace Lmdtextradiogroup;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextradiogroupHPP
