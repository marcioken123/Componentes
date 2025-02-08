// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFontSizeListBox.pas' rev: 31.00 (Windows)

#ifndef LmdfontsizelistboxHPP
#define LmdfontsizelistboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <LMDFontComboBox.hpp>
#include <LMDFontSizeComboBox.hpp>
#include <LMDFontListBox.hpp>
#include <LMDCustomImageListBox.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDCustomListBox.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfontsizelistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFontSizeListBox;
class DELPHICLASS TLMDLabeledFontSizeListBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFontSizeListBox : public Lmdcustomimagelistbox::TLMDCustomDerivedImageListBox
{
	typedef Lmdcustomimagelistbox::TLMDCustomDerivedImageListBox inherited;
	
private:
	System::Uitypes::TFontName FFontName;
	Vcl::Controls::TWinControl* FFontControl;
	bool FUseNearest;
	int FDefaultSize;
	int VRES;
	int CHECK;
	int FSIZE;
	void __fastcall SetFontControl(Vcl::Controls::TWinControl* aValue);
	void __fastcall SetFontComboControl(Lmdfontcombobox::TLMDFontComboBox* aValue);
	Lmdfontcombobox::TLMDFontComboBox* __fastcall GetFontComboControl(void);
	void __fastcall SetFontListControl(Lmdfontlistbox::TLMDFontListBox* aValue);
	Lmdfontlistbox::TLMDFontListBox* __fastcall GetFontListControl(void);
	HIDESBASE void __fastcall SetSelected(int aValue);
	HIDESBASE void __fastcall SetFont(const System::Uitypes::TFontName aValue);
	void __fastcall GetNearestValue(int &aValue);
	HIDESBASE int __fastcall GetSelected(void);
	int __fastcall CheckValue(int aValue);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChange(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateWnd(void);
	void __fastcall CreateFontSizeList(void);
	void __fastcall GetFontChange(System::TObject* Sender);
	void __fastcall InitHeight(void);
	bool __fastcall IsValidChar(System::WideChar Key);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	
public:
	__fastcall virtual TLMDFontSizeListBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFontSizeListBox(void);
	void __fastcall Init(void);
	__property int FontSize = {read=GetSelected, write=SetSelected, nodefault};
	
__published:
	__property About = {default=0};
	__property int DefaultSize = {read=FDefaultSize, write=FDefaultSize, default=10};
	__property Lmdfontcombobox::TLMDFontComboBox* FontCombo = {read=GetFontComboControl, write=SetFontComboControl};
	__property Lmdfontlistbox::TLMDFontListBox* FontList = {read=GetFontListControl, write=SetFontListControl};
	__property System::Uitypes::TFontName FontName = {read=FFontName, write=SetFont};
	__property bool UseNearestSize = {read=FUseNearest, write=FUseNearest, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFontSizeListBox(HWND ParentWindow) : Lmdcustomimagelistbox::TLMDCustomDerivedImageListBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledFontSizeListBox : public TLMDFontSizeListBox
{
	typedef TLMDFontSizeListBox inherited;
	
public:
	__fastcall virtual TLMDLabeledFontSizeListBox(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDFontSizeListBox.Destroy */ inline __fastcall virtual ~TLMDLabeledFontSizeListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledFontSizeListBox(HWND ParentWindow) : TLMDFontSizeListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfontsizelistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFONTSIZELISTBOX)
using namespace Lmdfontsizelistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfontsizelistboxHPP
