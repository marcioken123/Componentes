// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sComboBox.pas' rev: 27.00 (Windows)

#ifndef ScomboboxHPP
#define ScomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sDefaults.hpp>	// Pascal unit
#include <acSBUtils.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Scombobox
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsCustomComboBox;
class PASCALIMPLEMENTATION TsCustomComboBox : public Vcl::Stdctrls::TCustomComboBox
{
	typedef Vcl::Stdctrls::TCustomComboBox inherited;
	
private:
	System::Classes::TAlignment FAlignment;
	bool FReadOnly;
	Sconst::TsDisabledKind FDisabledKind;
	Scommondata::TsCtrlSkinData* FCommonData;
	Scommondata::TsBoundLabel* FBoundLabel;
	bool FShowButton;
	System::Classes::TVerticalAlignment FVerticalAlignment;
	void __fastcall SetAlignment(const System::Classes::TAlignment Value);
	void __fastcall SetReadOnly(const bool Value);
	void __fastcall SetDisabledKind(const Sconst::TsDisabledKind Value);
	void __fastcall SetShowButton(const bool Value);
	void __fastcall SetVerticalAlignment(const System::Classes::TVerticalAlignment Value);
	
protected:
	HWND lboxhandle;
	int actM;
	int actD;
	Acsbutils::TacScrollWnd* ListSW;
	DYNAMIC void __fastcall ChangeScale(int M, int D);
	HIDESBASE MESSAGE void __fastcall CNMeasureItem(Winapi::Messages::TWMMeasureItem &Message);
	void __fastcall PrepareCache(void);
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Winapi::Messages::TWMDrawItem &Message);
	void __fastcall OurPaintHandler(HDC iDC);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	virtual int __fastcall GetItemHt(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	bool __fastcall HandleAlphaMsg(Winapi::Messages::TMessage &Message);
	virtual void __fastcall ComboWndProc(Winapi::Messages::TMessage &Message, HWND ComboWnd, void * ComboProc);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TMessage &Message);
	virtual void __fastcall SetDropDownCount(const int Value);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	
public:
	bool FDropDown;
	__fastcall virtual TsCustomComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsCustomComboBox(void);
	int __fastcall IndexOf(const System::UnicodeString s);
	virtual void __fastcall Invalidate(void);
	System::Types::TRect __fastcall ButtonRect(void);
	void __fastcall PaintButton(void);
	int __fastcall ButtonHeight(void);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC bool __fastcall Focused(void);
	__property bool ShowButton = {read=FShowButton, write=SetShowButton, default=1};
	
__published:
	__property AutoCloseUp = {default=0};
	__property AutoDropDown = {default=0};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property AutoCompleteDelay = {default=500};
	__property Scommondata::TsBoundLabel* BoundLabel = {read=FBoundLabel, write=FBoundLabel};
	__property Sconst::TsDisabledKind DisabledKind = {read=FDisabledKind, write=SetDisabledKind, default=1};
	__property DropDownCount = {default=16};
	__property Scommondata::TsCtrlSkinData* SkinData = {read=FCommonData, write=FCommonData};
	__property System::Classes::TVerticalAlignment VerticalAlignment = {read=FVerticalAlignment, write=SetVerticalAlignment, nodefault};
	__property TextHint = {default=0};
	__property Touch;
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsCustomComboBox(HWND ParentWindow) : Vcl::Stdctrls::TCustomComboBox(ParentWindow) { }
	
};


class DELPHICLASS TsComboBox;
class PASCALIMPLEMENTATION TsComboBox : public TsCustomComboBox
{
	typedef TsCustomComboBox inherited;
	
__published:
	__property Style = {default=0};
	__property AutoComplete = {default=1};
	__property BiDiMode;
	__property CharCase = {default=0};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property DropDownCount = {default=16};
	__property Enabled = {default=1};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property ItemHeight;
	__property ItemIndex;
	__property MaxLength = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Sorted = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Text = {default=0};
	__property Visible = {default=1};
	__property AutoDropDown = {default=0};
	__property OnCloseUp;
	__property OnSelect;
	__property OnChange;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnDropDown;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMeasureItem;
	__property OnStartDock;
	__property OnStartDrag;
	__property Items;
	__property BoundLabel;
	__property DisabledKind = {default=1};
	__property SkinData;
	__property ReadOnly = {default=0};
public:
	/* TsCustomComboBox.Create */ inline __fastcall virtual TsComboBox(System::Classes::TComponent* AOwner) : TsCustomComboBox(AOwner) { }
	/* TsCustomComboBox.Destroy */ inline __fastcall virtual ~TsComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsComboBox(HWND ParentWindow) : TsCustomComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Scombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SCOMBOBOX)
using namespace Scombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ScomboboxHPP
