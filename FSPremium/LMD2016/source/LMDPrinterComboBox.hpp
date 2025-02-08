// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPrinterComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdprintercomboboxHPP
#define LmdprintercomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDThemedComboBox.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdprintercombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPrinterComboBox;
class DELPHICLASS TLMDLabeledPrinterCombobox;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDPrinterCBOption : unsigned char { poDisplaySymbol, poActivatePrinter, poStartWithActive };

typedef System::Set<TLMDPrinterCBOption, TLMDPrinterCBOption::poDisplaySymbol, TLMDPrinterCBOption::poStartWithActive> TLMDPrinterCBOptions;

class PASCALIMPLEMENTATION TLMDPrinterComboBox : public Lmdcustomcombobox::TLMDCustomComboBox
{
	typedef Lmdcustomcombobox::TLMDCustomComboBox inherited;
	
private:
	Vcl::Graphics::TBitmap* FBuffer;
	TLMDPrinterCBOptions FOptions;
	void __fastcall SetOptions(TLMDPrinterCBOptions aValue);
	void __fastcall SetSelectedPrinter(const System::UnicodeString aValue);
	System::UnicodeString __fastcall GetSelectedPrinter(void);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChange(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Message);
	
protected:
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall InitHeight(void);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDPrinterComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDPrinterComboBox(void);
	void __fastcall InitPrinterList(void);
	void __fastcall Init(void);
	__property System::UnicodeString SelectedPrinter = {read=GetSelectedPrinter, write=SetSelectedPrinter};
	__property Text = {default=0};
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
	__property Flat = {index=0, default=0};
	__property FocusControl;
	__property Font;
	__property TLMDPrinterCBOptions Options = {read=FOptions, write=SetOptions, default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
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
	/* TWinControl.CreateParented */ inline __fastcall TLMDPrinterComboBox(HWND ParentWindow) : Lmdcustomcombobox::TLMDCustomComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledPrinterCombobox : public TLMDPrinterComboBox
{
	typedef TLMDPrinterComboBox inherited;
	
public:
	__fastcall virtual TLMDLabeledPrinterCombobox(System::Classes::TComponent* AOwner);
	
__published:
	__property ItemIndex;
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDPrinterComboBox.Destroy */ inline __fastcall virtual ~TLMDLabeledPrinterCombobox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledPrinterCombobox(HWND ParentWindow) : TLMDPrinterComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdprintercombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPRINTERCOMBOBOX)
using namespace Lmdprintercombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdprintercomboboxHPP
