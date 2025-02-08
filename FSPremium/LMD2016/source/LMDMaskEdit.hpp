// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDMaskEdit.pas' rev: 31.00 (Windows)

#ifndef LmdmaskeditHPP
#define LmdmaskeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <LMDCaret.hpp>
#include <System.UITypes.hpp>
#include <LMDCurrencySettings.hpp>
#include <LMDSBtn.hpp>
#include <LMDButtonBase.hpp>
#include <LMDDateFormat.hpp>
#include <Vcl.Graphics.hpp>
#include <LMD3DCaption.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDTimeFormat.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdmaskedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMaskEdit;
class DELPHICLASS TLMDLabeledMaskEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDMaskEdit : public Lmdcustommaskedit::TLMDCustomMaskEdit
{
	typedef Lmdcustommaskedit::TLMDCustomMaskEdit inherited;
	
__published:
	__property About = {default=0};
	__property Alignment = {default=0};
	__property AutoSelect = {index=4, default=0};
	__property Bevel;
	__property BlankChar = {default=95};
	__property Caret;
	__property CharCase = {default=0};
	__property CurrencySettings;
	__property CustomButtons;
	__property CustomButtonsStyle = {default=9};
	__property CustomButtonWidth = {default=16};
	__property CustomButtonParentCtlXP = {default=1};
	__property DateSettings;
	__property Decimals = {index=0, default=1};
	__property Flat = {default=0};
	__property FocusOnMouseAbove = {index=6, default=0};
	__property Font;
	__property Font3D;
	__property ForceMaskCheck = {default=0};
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property Mask = {default=0};
	__property MaskType = {default=8};
	__property MaxLength = {index=0, default=0};
	__property NumberBase = {default=10};
	__property OEMConvert = {index=5, default=0};
	__property Options = {default=56};
	__property ProcessBlankChar = {default=0};
	__property SuppressBlankCharOnDelete = {default=0};
	__property ReadOnly = {index=1, default=0};
	__property Suffix = {default=0};
	__property TabOnEnter = {default=0};
	__property Text;
	__property TimeSettings;
	__property Transparent = {default=0};
	__property OnBtnClick;
	__property OnUserRule;
public:
	/* TLMDCustomMaskEdit.Create */ inline __fastcall virtual TLMDMaskEdit(System::Classes::TComponent* aOwner) : Lmdcustommaskedit::TLMDCustomMaskEdit(aOwner) { }
	/* TLMDCustomMaskEdit.Destroy */ inline __fastcall virtual ~TLMDMaskEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDMaskEdit(HWND ParentWindow) : Lmdcustommaskedit::TLMDCustomMaskEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledMaskEdit : public TLMDMaskEdit
{
	typedef TLMDMaskEdit inherited;
	
public:
	__fastcall virtual TLMDLabeledMaskEdit(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomMaskEdit.Destroy */ inline __fastcall virtual ~TLMDLabeledMaskEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledMaskEdit(HWND ParentWindow) : TLMDMaskEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdmaskedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDMASKEDIT)
using namespace Lmdmaskedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdmaskeditHPP
