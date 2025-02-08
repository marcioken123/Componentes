// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFontSizeComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdfontsizecomboboxHPP
#define LmdfontsizecomboboxHPP

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
#include <LMDFontListBox.hpp>
#include <LMDCustomComboBox.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDThemedComboBox.hpp>
#include <LMDCustomImageListBox.hpp>
#include <LMDCustomListBox.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfontsizecombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSpecialFontComboBox;
class DELPHICLASS TLMDSpecialFontListBox;
class DELPHICLASS TLMDFontSizeComboBox;
class DELPHICLASS TLMDLabeledFontSizeComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSpecialFontComboBox : public Lmdfontcombobox::TLMDFontComboBox
{
	typedef Lmdfontcombobox::TLMDFontComboBox inherited;
	
public:
	__property OnFontChange;
public:
	/* TLMDFontComboBox.Create */ inline __fastcall virtual TLMDSpecialFontComboBox(System::Classes::TComponent* AOwner) : Lmdfontcombobox::TLMDFontComboBox(AOwner) { }
	/* TLMDFontComboBox.Destroy */ inline __fastcall virtual ~TLMDSpecialFontComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSpecialFontComboBox(HWND ParentWindow) : Lmdfontcombobox::TLMDFontComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDSpecialFontListBox : public Lmdfontlistbox::TLMDFontListBox
{
	typedef Lmdfontlistbox::TLMDFontListBox inherited;
	
public:
	__property OnFontChange;
public:
	/* TLMDFontListBox.Create */ inline __fastcall virtual TLMDSpecialFontListBox(System::Classes::TComponent* aOwner) : Lmdfontlistbox::TLMDFontListBox(aOwner) { }
	/* TLMDFontListBox.Destroy */ inline __fastcall virtual ~TLMDSpecialFontListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSpecialFontListBox(HWND ParentWindow) : Lmdfontlistbox::TLMDFontListBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDFontSizeComboBox : public Lmdcustomcombobox::TLMDCustomComboBox
{
	typedef Lmdcustomcombobox::TLMDCustomComboBox inherited;
	
private:
	System::Uitypes::TFontName FFontName;
	Vcl::Controls::TWinControl* FFontControl;
	bool FEditorEnabled;
	bool FUseNearest;
	int FDefaultSize;
	int VRES;
	int CHECK;
	int FSIZE;
	void __fastcall SetEditorEnabled(bool aValue);
	void __fastcall SetFontControl(Vcl::Controls::TWinControl* aValue);
	void __fastcall SetFontComboControl(Lmdfontcombobox::TLMDFontComboBox* aValue);
	Lmdfontcombobox::TLMDFontComboBox* __fastcall GetFontComboControl(void);
	void __fastcall SetFontListControl(Lmdfontlistbox::TLMDFontListBox* aValue);
	Lmdfontlistbox::TLMDFontListBox* __fastcall GetFontListControl(void);
	void __fastcall SetSelected(int aValue);
	HIDESBASE void __fastcall SetFont(const System::Uitypes::TFontName aValue);
	void __fastcall GetNearestValue(int &aValue);
	int __fastcall GetSelected(void);
	int __fastcall CheckValue(int aValue);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChange(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateWnd(void);
	void __fastcall CreateFontSizeList(void);
	void __fastcall GetChange(System::TObject* Sender);
	void __fastcall InitHeight(void);
	bool __fastcall IsValidChar(System::WideChar Key);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDFontSizeComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFontSizeComboBox(void);
	virtual void __fastcall Loaded(void);
	void __fastcall Init(void);
	__property CtlXP = {default=1};
	__property int FontSize = {read=GetSelected, write=SetSelected, nodefault};
	
__published:
	__property About = {default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property int DefaultSize = {read=FDefaultSize, write=FDefaultSize, default=10};
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property DropDownCount = {default=8};
	__property DropDownWidth = {index=0, default=0};
	__property bool EditorEnabled = {read=FEditorEnabled, write=SetEditorEnabled, default=1};
	__property Enabled = {default=1};
	__property Flat = {index=0, default=0};
	__property FocusControl;
	__property Font;
	__property Lmdfontcombobox::TLMDFontComboBox* FontCombo = {read=GetFontComboControl, write=SetFontComboControl};
	__property Lmdfontlistbox::TLMDFontListBox* FontList = {read=GetFontListControl, write=SetFontListControl};
	__property System::Uitypes::TFontName FontName = {read=FFontName, write=SetFont};
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
	__property bool UseNearestSize = {read=FUseNearest, write=FUseNearest, default=0};
	__property UseGlobalTimer = {default=0};
	__property Visible = {default=1};
	__property OnSelect;
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDropDown;
	__property OnEditClick;
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
	/* TWinControl.CreateParented */ inline __fastcall TLMDFontSizeComboBox(HWND ParentWindow) : Lmdcustomcombobox::TLMDCustomComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledFontSizeComboBox : public TLMDFontSizeComboBox
{
	typedef TLMDFontSizeComboBox inherited;
	
public:
	__fastcall virtual TLMDLabeledFontSizeComboBox(System::Classes::TComponent* AOwner);
	
__published:
	__property ItemIndex;
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDFontSizeComboBox.Destroy */ inline __fastcall virtual ~TLMDLabeledFontSizeComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledFontSizeComboBox(HWND ParentWindow) : TLMDFontSizeComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdfontsizecombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFONTSIZECOMBOBOX)
using namespace Lmdfontsizecombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfontsizecomboboxHPP
