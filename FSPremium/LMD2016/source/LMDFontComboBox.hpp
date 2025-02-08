// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFontComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdfontcomboboxHPP
#define LmdfontcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDThemedComboBox.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfontcombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFontComboBox;
class DELPHICLASS TLMDLabeledFontComboBox;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDFontCBOption : unsigned char { foPrinterFonts, foScreenFonts, foTrueTypeOnly, foDisplayFont, foDisplaySymbol, foDisplaySelectedFont, foHideAtPrefixedFonts };

typedef System::Set<TLMDFontCBOption, TLMDFontCBOption::foPrinterFonts, TLMDFontCBOption::foHideAtPrefixedFonts> TLMDFontCBOptions;

enum DECLSPEC_DENUM TLMDFontComboExampleAlign : unsigned char { eaComboBox, eaDropDownList };

class PASCALIMPLEMENTATION TLMDFontComboBox : public Lmdcustomcombobox::TLMDCustomComboBox
{
	typedef Lmdcustomcombobox::TLMDCustomComboBox inherited;
	
private:
	Vcl::Graphics::TBitmap* FBuffer;
	TLMDFontCBOptions FOptions;
	System::Classes::TNotifyEvent FSizeChange;
	bool FShowExample;
	bool FFastMode;
	Vcl::Controls::THintWindow* FHintWnd;
	int FExampleFontSize;
	System::UnicodeString FExampleText;
	TLMDFontComboExampleAlign FExampleAlign;
	void __fastcall SetSelectedFont(const System::Uitypes::TFontName aValue);
	void __fastcall SetOptions(TLMDFontCBOptions aValue);
	System::Uitypes::TFontName __fastcall GetSelectedFont(void);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChange(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Message);
	
protected:
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall CreateWnd(void);
	void __fastcall CreateFontList(void);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &pRect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall InitFontHeight(void);
	__property System::Classes::TNotifyEvent OnFontChange = {read=FSizeChange, write=FSizeChange};
	
public:
	__fastcall virtual TLMDFontComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFontComboBox(void);
	virtual void __fastcall Loaded(void);
	__property System::Uitypes::TFontName SelectedFont = {read=GetSelectedFont, write=SetSelectedFont};
	__property Text = {default=0};
	void __fastcall Init(void);
	__property CtlXP = {default=1};
	
__published:
	__property About = {default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property DropDownCount = {default=8};
	__property DropDownWidth = {index=0, default=0};
	__property Enabled = {default=1};
	__property TLMDFontComboExampleAlign ExampleAlign = {read=FExampleAlign, write=FExampleAlign, default=0};
	__property System::UnicodeString ExampleText = {read=FExampleText, write=FExampleText};
	__property int ExampleFontSize = {read=FExampleFontSize, write=FExampleFontSize, default=12};
	__property bool FastMode = {read=FFastMode, write=FFastMode, default=0};
	__property Flat = {index=0, default=0};
	__property FocusControl;
	__property Font;
	__property MRUList = {index=1, default=0};
	__property MRUMax = {index=1, default=5};
	__property TLMDFontCBOptions Options = {read=FOptions, write=SetOptions, default=50};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property bool ShowExample = {read=FShowExample, write=FShowExample, default=0};
	__property ShowHint;
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property UseGlobalTimer = {default=0};
	__property Visible = {default=1};
	__property OnSelect;
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDropDown;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnCloseUp;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFontComboBox(HWND ParentWindow) : Lmdcustomcombobox::TLMDCustomComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledFontComboBox : public TLMDFontComboBox
{
	typedef TLMDFontComboBox inherited;
	
public:
	__fastcall virtual TLMDLabeledFontComboBox(System::Classes::TComponent* AOwner);
	
__published:
	__property ItemIndex;
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDFontComboBox.Destroy */ inline __fastcall virtual ~TLMDLabeledFontComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledFontComboBox(HWND ParentWindow) : TLMDFontComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfontcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFONTCOMBOBOX)
using namespace Lmdfontcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfontcomboboxHPP
