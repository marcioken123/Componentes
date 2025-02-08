// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomBrowseEdit.pas' rev: 31.00 (Windows)

#ifndef LmdcustombrowseeditHPP
#define LmdcustombrowseeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDClass.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDSBtn.hpp>
#include <LMDButtonBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustombrowseedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomBrowseEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomBrowseEdit : public Lmdcustomedit::TLMDCustomEdit
{
	typedef Lmdcustomedit::TLMDCustomEdit inherited;
	
private:
	System::Classes::TNotifyEvent FOnDlgChange;
	System::Classes::TNotifyEvent FOnBeforeBrowse;
	System::Classes::TNotifyEvent FOnAfterBrowse;
	
protected:
	void __fastcall DoOnBrowseClick(System::TObject* Sender, int index);
	virtual void __fastcall DoBrowse(void);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDCustomBrowseEdit(System::Classes::TComponent* aOwner);
	
__published:
	__property CustomButtons;
	__property CustomButtonsStyle = {default=9};
	__property CustomButtonWidth = {default=16};
	__property CustomButtonParentCtlXP = {default=1};
	__property OnChange;
	__property System::Classes::TNotifyEvent OnDlgChange = {read=FOnDlgChange, write=FOnDlgChange};
	__property System::Classes::TNotifyEvent OnBeforeBrowse = {read=FOnBeforeBrowse, write=FOnBeforeBrowse};
	__property System::Classes::TNotifyEvent OnBrowse = {read=FOnAfterBrowse, write=FOnAfterBrowse};
public:
	/* TLMDCustomEdit.Destroy */ inline __fastcall virtual ~TLMDCustomBrowseEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomBrowseEdit(HWND ParentWindow) : Lmdcustomedit::TLMDCustomEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustombrowseedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMBROWSEEDIT)
using namespace Lmdcustombrowseedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustombrowseeditHPP
