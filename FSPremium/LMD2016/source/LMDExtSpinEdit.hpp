// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDExtSpinEdit.pas' rev: 31.00 (Windows)

#ifndef LmdextspineditHPP
#define LmdextspineditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCurrencySettings.hpp>
#include <LMDTypes.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdextspinedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDExtSpinEdit;
class DELPHICLASS TLMDLabeledExtSpinEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDExtSpinEdit : public Lmdcustomextspinedit::TLMDCustomExtSpinEdit
{
	typedef Lmdcustomextspinedit::TLMDCustomExtSpinEdit inherited;
	
__published:
	__property CurrencySettings;
	__property Decimals = {index=0, default=1};
	__property MinValue = {index=1, default=0};
	__property MaxValue = {index=2, default=0};
	__property Suffix = {default=0};
	__property EditType = {default=0};
	__property Value = {index=2, default=0};
	__property InfiniteMax = {default=0};
	__property InfiniteMin = {default=0};
	__property LargeStep = {default=0};
	__property FractionStep = {default=0};
	__property TabOnEnter = {default=0};
public:
	/* TLMDCustomExtSpinEdit.Create */ inline __fastcall virtual TLMDExtSpinEdit(System::Classes::TComponent* aOwner) : Lmdcustomextspinedit::TLMDCustomExtSpinEdit(aOwner) { }
	/* TLMDCustomExtSpinEdit.Destroy */ inline __fastcall virtual ~TLMDExtSpinEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDExtSpinEdit(HWND ParentWindow) : Lmdcustomextspinedit::TLMDCustomExtSpinEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledExtSpinEdit : public TLMDExtSpinEdit
{
	typedef TLMDExtSpinEdit inherited;
	
public:
	__fastcall virtual TLMDLabeledExtSpinEdit(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomExtSpinEdit.Destroy */ inline __fastcall virtual ~TLMDLabeledExtSpinEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledExtSpinEdit(HWND ParentWindow) : TLMDExtSpinEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdextspinedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDEXTSPINEDIT)
using namespace Lmdextspinedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdextspineditHPP
