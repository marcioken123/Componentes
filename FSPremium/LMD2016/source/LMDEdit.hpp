// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDEdit.pas' rev: 31.00 (Windows)

#ifndef LmdeditHPP
#define LmdeditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDTypes.hpp>
#include <LMDEditAutoComplete.hpp>
#include <LMDBevel.hpp>
#include <LMDCaret.hpp>
#include <System.UITypes.hpp>
#include <LMDSBtn.hpp>
#include <LMDButtonBase.hpp>
#include <LMD3DCaption.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDEdit;
class DELPHICLASS TLMDLabeledEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDEdit : public Lmdcustomedit::TLMDCustomEdit
{
	typedef Lmdcustomedit::TLMDCustomEdit inherited;
	
__published:
	__property About = {default=0};
	__property AutoComplete;
	__property AutoSelect = {index=4, default=0};
	__property AutoSize = {default=0};
	__property Bevel;
	__property Caret;
	__property CharCase = {default=0};
	__property Alignment = {default=0};
	__property CustomButtons;
	__property CustomButtonsStyle = {default=9};
	__property CustomButtonWidth = {default=16};
	__property CustomButtonParentCtlXP = {default=1};
	__property Flat = {default=0};
	__property FocusOnMouseAbove = {index=6, default=0};
	__property Font;
	__property Font3D;
	__property HideSelection = {index=0, default=1};
	__property HighlightBack = {default=-16777203};
	__property HighlightText = {default=-16777202};
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property MaxLength = {index=0, default=0};
	__property OEMConvert = {index=5, default=0};
	__property Options = {default=56};
	__property PasswordChar;
	__property ReadOnly = {index=1, default=0};
	__property TabOnEnter = {default=0};
	__property Text;
	__property Transparent = {default=0};
	__property OnBtnClick;
public:
	/* TLMDCustomEdit.Create */ inline __fastcall virtual TLMDEdit(System::Classes::TComponent* aOwner) : Lmdcustomedit::TLMDCustomEdit(aOwner) { }
	/* TLMDCustomEdit.Destroy */ inline __fastcall virtual ~TLMDEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDEdit(HWND ParentWindow) : Lmdcustomedit::TLMDCustomEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledEdit : public TLMDEdit
{
	typedef TLMDEdit inherited;
	
public:
	__fastcall virtual TLMDLabeledEdit(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomEdit.Destroy */ inline __fastcall virtual ~TLMDLabeledEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledEdit(HWND ParentWindow) : TLMDEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDEDIT)
using namespace Lmdedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdeditHPP
