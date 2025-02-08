// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCalculatorEdit.pas' rev: 31.00 (Windows)

#ifndef LmdcalculatoreditHPP
#define LmdcalculatoreditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDGraph.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDButtonBase.hpp>
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
#include <LMDSBtn.hpp>
#include <Vcl.Graphics.hpp>
#include <LMD3DCaption.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDClass.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcalculatoredit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCalculatorEdit;
class DELPHICLASS TLMDLabeledCalculatorEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCalculatorEdit : public Lmdcustommaskedit::TLMDCustomMaskEdit
{
	typedef Lmdcustommaskedit::TLMDCustomMaskEdit inherited;
	
private:
	Lmdcustommaskedit::TLMDNumberType FType;
	Lmdbuttonbase::TLMDUserButtonStyle FCBtn;
	System::Classes::TNotifyEvent FOnDlgChange;
	System::Classes::TNotifyEvent FOnShow;
	System::Classes::TNotifyEvent FOnClose;
	bool FCXP;
	void __fastcall SetType(Lmdcustommaskedit::TLMDNumberType aValue);
	HIDESBASE void __fastcall ReadOldBtnStyle(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	HIDESBASE void __fastcall SetMaskType(void);
	void __fastcall DoOnBrowseClick(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDCalculatorEdit(System::Classes::TComponent* aOwner);
	virtual void __fastcall Loaded(void);
	__property Lmdbuttonbase::TLMDUserButtonStyle CalculatorBtnStyle = {read=FCBtn, write=FCBtn, nodefault};
	__property CtlXP = {default=1};
	
__published:
	__property About = {default=0};
	__property AutoSelect = {index=4, default=0};
	__property Bevel;
	__property Caret;
	__property CharCase = {default=0};
	__property CustomButtons;
	__property CustomButtonsStyle = {default=9};
	__property CustomButtonWidth = {default=16};
	__property CustomButtonParentCtlXP = {default=1};
	__property Decimals = {index=0, default=1};
	__property Lmdcustommaskedit::TLMDNumberType EditType = {read=FType, write=SetType, default=1};
	__property Lmdbuttonbase::TLMDUserButtonStyle CalcButtonStyle = {read=FCBtn, write=FCBtn, default=7};
	__property bool CalcButtonCtlXP = {read=FCXP, write=FCXP, default=0};
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
	__property ReadOnly = {index=1, default=0};
	__property Transparent = {default=0};
	__property System::Classes::TNotifyEvent OnDlgChange = {read=FOnDlgChange, write=FOnDlgChange};
	__property System::Classes::TNotifyEvent OnDlgClose = {read=FOnClose, write=FOnClose};
	__property System::Classes::TNotifyEvent OnDlgShow = {read=FOnShow, write=FOnShow};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
public:
	/* TLMDCustomMaskEdit.Destroy */ inline __fastcall virtual ~TLMDCalculatorEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCalculatorEdit(HWND ParentWindow) : Lmdcustommaskedit::TLMDCustomMaskEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledCalculatorEdit : public TLMDCalculatorEdit
{
	typedef TLMDCalculatorEdit inherited;
	
public:
	__fastcall virtual TLMDLabeledCalculatorEdit(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomMaskEdit.Destroy */ inline __fastcall virtual ~TLMDLabeledCalculatorEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledCalculatorEdit(HWND ParentWindow) : TLMDCalculatorEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcalculatoredit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCALCULATOREDIT)
using namespace Lmdcalculatoredit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcalculatoreditHPP
