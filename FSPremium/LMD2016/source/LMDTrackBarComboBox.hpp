// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTrackBarComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdtrackbarcomboboxHPP
#define LmdtrackbarcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <Winapi.Windows.hpp>
#include <LMDTrackBar.hpp>
#include <LMDCustomExtCombo.hpp>
#include <LMDGraph.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMDClass.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtrackbarcombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTrackBarComboBox;
class DELPHICLASS TLMDLabeledTrackBarComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTrackBarComboBox : public Lmdcustomextcombo::TLMDCustomExtCombo
{
	typedef Lmdcustomextcombo::TLMDCustomExtCombo inherited;
	
private:
	System::UnicodeString FOld;
	System::Uitypes::TColor FTrackColor;
	int FTrackBorder;
	int FTrackHeight;
	int FTrackWidth;
	bool FBorder;
	HIDESBASE void __fastcall SetColor(const System::Uitypes::TColor aValue);
	HIDESBASE void __fastcall SetInteger(int Index, int aValue);
	void __fastcall SetIValue(const int aValue);
	int __fastcall GetValue(void);
	Lmdtrackbar::TLMDTrackBar* __fastcall GetTrackBar(void);
	void __fastcall DrawComboFrame(System::TObject* Sender);
	
protected:
	virtual void __fastcall CreateControl(void);
	virtual Vcl::Controls::TWinControl* __fastcall GetControl(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall ReModifyControl(void);
	virtual void __fastcall DisplayControl(void);
	virtual void __fastcall ModifyControl(void);
	virtual void __fastcall Cancel(void);
	virtual void __fastcall Accept(void);
	void __fastcall DoChange(System::TObject* Sender);
	void __fastcall DoDblClick(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDTrackBarComboBox(System::Classes::TComponent* aOwner);
	__property Lmdtrackbar::TLMDTrackBar* TrackBar = {read=GetTrackBar};
	virtual void __fastcall Init(void);
	__property CtlXP = {default=1};
	__property int Value = {read=GetValue, write=SetIValue, nodefault};
	
__published:
	__property MinValue = {index=1, default=0};
	__property MaxValue = {index=2, default=0};
	__property RangeCheck = {default=0};
	__property Suffix = {default=0};
	__property System::Uitypes::TColor TrackBarColor = {read=FTrackColor, write=SetColor, default=16777215};
	__property bool TrackBarBorder = {read=FBorder, write=FBorder, default=1};
	__property int TrackBarMargin = {read=FTrackBorder, write=SetInteger, index=0, default=4};
	__property int TrackBarHeight = {read=FTrackHeight, write=SetInteger, index=1, default=40};
	__property int TrackBarWidth = {read=FTrackWidth, write=SetInteger, index=2, default=230};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
public:
	/* TLMDCustomExtCombo.Destroy */ inline __fastcall virtual ~TLMDTrackBarComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTrackBarComboBox(HWND ParentWindow) : Lmdcustomextcombo::TLMDCustomExtCombo(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledTrackBarComboBox : public TLMDTrackBarComboBox
{
	typedef TLMDTrackBarComboBox inherited;
	
public:
	__fastcall virtual TLMDLabeledTrackBarComboBox(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomExtCombo.Destroy */ inline __fastcall virtual ~TLMDLabeledTrackBarComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledTrackBarComboBox(HWND ParentWindow) : TLMDTrackBarComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtrackbarcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTRACKBARCOMBOBOX)
using namespace Lmdtrackbarcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtrackbarcomboboxHPP
