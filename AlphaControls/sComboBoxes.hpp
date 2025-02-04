// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sComboBoxes.pas' rev: 27.00 (Windows)

#ifndef ScomboboxesHPP
#define ScomboboxesHPP

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
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sDefaults.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit
#include <sGraphUtils.hpp>	// Pascal unit
#include <acSBUtils.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Scomboboxes
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsCustomComboBoxEx;
class PASCALIMPLEMENTATION TsCustomComboBoxEx : public Vcl::Comctrls::TCustomComboBoxEx
{
	typedef Vcl::Comctrls::TCustomComboBoxEx inherited;
	
private:
	Sconst::TsDisabledKind FDisabledKind;
	Scommondata::TsCtrlSkinData* FCommonData;
	Scommondata::TsBoundLabel* FBoundLabel;
	bool FReadOnly;
	bool FShowButton;
	HWND ExHandle;
	void __fastcall SetDisabledKind(const Sconst::TsDisabledKind Value);
	HIDESBASE virtual void __fastcall WMDrawItem(Winapi::Messages::TWMDrawItem &Message);
	void __fastcall SetReadOnly(const bool Value);
	HIDESBASE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	void __fastcall SetShowButton(const bool Value);
	Vcl::Comctrls::TComboExItem* __fastcall GetSelectedItem(void);
	
protected:
	bool FDropDown;
	HWND lboxhandle;
	Acsbutils::TacScrollWnd* ListSW;
	virtual int __fastcall GetItemHt(void);
	int __fastcall BrdWidth(void);
	virtual bool __fastcall DrawSkinItem(int aIndex, const System::Types::TRect &aRect, Winapi::Windows::TOwnerDrawState aState, HDC aDC);
	int __fastcall ButtonHeight(void);
	System::Types::TRect __fastcall ButtonRect(void);
	void __fastcall PaintButton(void);
	void __fastcall PrepareCache(void);
	virtual void __fastcall ComboWndProc(Winapi::Messages::TMessage &Message, HWND ComboWnd, void * ComboProc);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	
public:
	__fastcall virtual TsCustomComboBoxEx(System::Classes::TComponent* AOwner);
	virtual void __fastcall CreateWnd(void);
	__fastcall virtual ~TsCustomComboBoxEx(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	__property Vcl::Comctrls::TComboExItem* SelectedItem = {read=GetSelectedItem};
	
__published:
	__property Scommondata::TsBoundLabel* BoundLabel = {read=FBoundLabel, write=FBoundLabel};
	__property Sconst::TsDisabledKind DisabledKind = {read=FDisabledKind, write=SetDisabledKind, default=1};
	__property bool ShowButton = {read=FShowButton, write=SetShowButton, default=1};
	__property Scommondata::TsCtrlSkinData* SkinData = {read=FCommonData, write=FCommonData};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsCustomComboBoxEx(HWND ParentWindow) : Vcl::Comctrls::TCustomComboBoxEx(ParentWindow) { }
	
};


class DELPHICLASS TsComboBoxEx;
class PASCALIMPLEMENTATION TsComboBoxEx : public TsCustomComboBoxEx
{
	typedef TsCustomComboBoxEx inherited;
	
__published:
	__property AutoCompleteOptions = {default=2};
	__property ItemsEx;
	__property Style = {default=0};
	__property StyleEx = {default=0};
	__property Action;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property ItemIndex;
	__property ItemHeight;
	__property MaxLength = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Text = {default=0};
	__property Visible = {default=1};
	__property OnBeginEdit;
	__property OnChange;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDropDown;
	__property OnEndEdit;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnSelect;
	__property OnStartDock;
	__property OnStartDrag;
	__property Images;
	__property DropDownCount = {default=8};
public:
	/* TsCustomComboBoxEx.Create */ inline __fastcall virtual TsComboBoxEx(System::Classes::TComponent* AOwner) : TsCustomComboBoxEx(AOwner) { }
	/* TsCustomComboBoxEx.Destroy */ inline __fastcall virtual ~TsComboBoxEx(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsComboBoxEx(HWND ParentWindow) : TsCustomComboBoxEx(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TsColorBoxStyles : unsigned char { cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbIncludeDefault, cbCustomColor, cbPrettyNames, cbCustomColors, cbSavedColors };

typedef System::Set<TsColorBoxStyles, TsColorBoxStyles::cbStandardColors, TsColorBoxStyles::cbSavedColors> TsColorBoxStyle;

class DELPHICLASS TsCustomColorBox;
typedef void __fastcall (__closure *TGetColorsEvent)(TsCustomColorBox* Sender, System::Classes::TStrings* Items);

typedef void __fastcall (__closure *TOnColorName)(TsCustomColorBox* Sender, System::Uitypes::TColor Value, System::UnicodeString &ColorName);

class PASCALIMPLEMENTATION TsCustomColorBox : public TsCustomComboBoxEx
{
	typedef TsCustomComboBoxEx inherited;
	
private:
	TsColorBoxStyle FStyle;
	bool FListSelected;
	System::Uitypes::TColor FDefaultColorColor;
	System::Uitypes::TColor FNoneColorColor;
	System::Uitypes::TColor FSelectedColor;
	bool FShowColorName;
	int FMargin;
	TGetColorsEvent FOnGetColors;
	TOnColorName FOnColorName;
	System::Uitypes::TColor __fastcall GetColor(int Index);
	System::UnicodeString __fastcall GetColorName(int Index);
	System::Uitypes::TColor __fastcall GetSelected(void);
	void __fastcall SetSelected(const System::Uitypes::TColor AColor);
	void __fastcall ColorCallBack(const System::UnicodeString AName);
	void __fastcall SetDefaultColorColor(const System::Uitypes::TColor Value);
	void __fastcall SetNoneColorColor(const System::Uitypes::TColor Value);
	void __fastcall SetShowColorName(const bool Value);
	void __fastcall SetMargin(const int Value);
	virtual void __fastcall WMDrawItem(Winapi::Messages::TWMDrawItem &Message);
	
protected:
	DYNAMIC void __fastcall CloseUp(void);
	System::Types::TRect __fastcall ColorRect(const System::Types::TRect &SourceRect, Winapi::Windows::TOwnerDrawState State);
	virtual bool __fastcall DrawSkinItem(int aIndex, const System::Types::TRect &aRect, Winapi::Windows::TOwnerDrawState aState, HDC aDC);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	bool __fastcall PickCustomColor(void);
	virtual int __fastcall GetItemHt(void);
	void __fastcall PopulateList(void);
	DYNAMIC void __fastcall Select(void);
	HIDESBASE void __fastcall SetStyle(TsColorBoxStyle AStyle);
	
public:
	__fastcall virtual TsCustomColorBox(System::Classes::TComponent* AOwner);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall CreateWnd(void);
	__property System::UnicodeString ColorNames[int Index] = {read=GetColorName};
	__property System::Uitypes::TColor Colors[int Index] = {read=GetColor};
	
__published:
	__property TsColorBoxStyle Style = {read=FStyle, write=SetStyle, default=7};
	__property int Margin = {read=FMargin, write=SetMargin, default=0};
	__property System::Uitypes::TColor Selected = {read=GetSelected, write=SetSelected, default=0};
	__property bool ShowColorName = {read=FShowColorName, write=SetShowColorName, default=1};
	__property System::Uitypes::TColor DefaultColorColor = {read=FDefaultColorColor, write=SetDefaultColorColor, default=0};
	__property System::Uitypes::TColor NoneColorColor = {read=FNoneColorColor, write=SetNoneColorColor, default=0};
	__property TOnColorName OnColorName = {read=FOnColorName, write=FOnColorName};
	__property TGetColorsEvent OnGetColors = {read=FOnGetColors, write=FOnGetColors};
public:
	/* TsCustomComboBoxEx.Destroy */ inline __fastcall virtual ~TsCustomColorBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsCustomColorBox(HWND ParentWindow) : TsCustomComboBoxEx(ParentWindow) { }
	
};


class DELPHICLASS TsColorBox;
class PASCALIMPLEMENTATION TsColorBox : public TsCustomColorBox
{
	typedef TsCustomColorBox inherited;
	
__published:
	__property Align = {default=0};
	__property DisabledKind = {default=1};
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property BiDiMode;
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property DropDownCount = {default=8};
	__property Enabled = {default=1};
	__property Font;
	__property ItemHeight;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnChange;
	__property OnCloseUp;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDropDown;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnSelect;
	__property OnStartDock;
	__property OnStartDrag;
	__property Style = {default=7};
	__property Margin = {default=0};
	__property Selected = {default=0};
	__property ShowColorName = {default=1};
	__property DefaultColorColor = {default=0};
	__property NoneColorColor = {default=0};
	__property SkinData;
public:
	/* TsCustomColorBox.Create */ inline __fastcall virtual TsColorBox(System::Classes::TComponent* AOwner) : TsCustomColorBox(AOwner) { }
	
public:
	/* TsCustomComboBoxEx.Destroy */ inline __fastcall virtual ~TsColorBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsColorBox(HWND ParentWindow) : TsCustomColorBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Vcl::Dialogs::TColorDialog* ColDlg;
}	/* namespace Scomboboxes */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SCOMBOBOXES)
using namespace Scomboboxes;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ScomboboxesHPP
