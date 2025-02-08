// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElMenuBar.pas' rev: 31.00 (Windows)

#ifndef ElmenubarHPP
#define ElmenubarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Menus.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <Vcl.ToolWin.hpp>
#include <LMDTypes.hpp>
#include <LMDSysIn.hpp>
#include <LMDGraph.hpp>
#include <LMDClass.hpp>
#include <ElHook.hpp>
#include <ElShadowWindow.hpp>
#include <ElToolBar.hpp>
#include <ElPopBtn.hpp>
#include <ElMenus.hpp>
#include <ElVCLUtils.hpp>
#include <ElPanel.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <ElBtnCtl.hpp>
#include <ElXPThemedControl.hpp>
#include <System.UITypes.hpp>
#include <Vcl.StdCtrls.hpp>
#include <ElImgFrm.hpp>
#include <Vcl.ImgList.hpp>
#include <ElIni.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elmenubar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElMenuBarButton;
class DELPHICLASS TElSystemButton;
class DELPHICLASS TElMenuBar;
class DELPHICLASS TLMDWndHoolHelper;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElMenuBarButton : public Eltoolbar::TCustomElToolButton
{
	typedef Eltoolbar::TCustomElToolButton inherited;
	
private:
	Elmenus::TElMenuItem* FMenuItem;
	bool FMouseMenu;
	Vcl::Menus::TMenuDrawItemEvent FOnDrawItem;
	Elshadowwindow::TElShadow* FShadow;
	Vcl::Menus::TAdvancedMenuDrawItemEvent FOnAdvancedDrawItem;
	
protected:
	virtual void __fastcall DoPullMenu(void);
	virtual bool __fastcall Focused(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	virtual System::Types::TPoint __fastcall MeasureButton(bool LockHeight);
	virtual void __fastcall DoClick(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	void __fastcall CopyFromMenuItem(Elmenus::TElMenuItem* Item);
	void __fastcall MasterChange(System::TObject* Sender, Elmenus::TElMenuItem* MenuItem, bool Rebuild);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	
public:
	__fastcall virtual TElMenuBarButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElMenuBarButton(void);
	__property ParentFont = {default=1};
};


class PASCALIMPLEMENTATION TElSystemButton : public Elpopbtn::TElPopupButton
{
	typedef Elpopbtn::TElPopupButton inherited;
	
private:
	unsigned FButtonType;
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	__property unsigned ButtonType = {read=FButtonType, write=FButtonType, nodefault};
public:
	/* TElPopupButton.Create */ inline __fastcall virtual TElSystemButton(System::Classes::TComponent* AOwner) : Elpopbtn::TElPopupButton(AOwner) { }
	
public:
	/* TCustomElPopupButton.Destroy */ inline __fastcall virtual ~TElSystemButton(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElSystemButton(HWND ParentWindow) : Elpopbtn::TElPopupButton(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElMenuBar : public Eltoolbar::TCustomElToolBar
{
	typedef Eltoolbar::TCustomElToolBar inherited;
	
protected:
	TElMenuBarButton* FFocusedButton;
	Elhook::TElHook* FHook;
	bool FInMenu;
	bool FDroppedDown;
	bool FInitSelect;
	Elmenus::TElMainMenu* FMenu;
	bool IgnoreAltDn;
	bool IgnoreAltUp;
	HWND OldFocus;
	System::Types::TPoint FLastMousePos;
	Elmenus::TElPopupMenu* FIntMenu;
	bool FChFocusButton;
	Elpopbtn::TElPopupButton* FSysButton;
	TElSystemButton* FSysMinButton;
	TElSystemButton* FSysCloseButton;
	TElSystemButton* FSysRestoreButton;
	HWND FActiveMDIForm;
	HMENU FSysMenu;
	void __fastcall PullDownMenuDropDown(System::TObject* Sender);
	void __fastcall OnSystemMDIButtonClick(System::TObject* Sender);
	void __fastcall CheckChildWindowChanging(HWND AHandle, System::Word ACommand);
	void __fastcall ShowMDIButtons(HWND AHandle);
	void __fastcall HideMDIButtons(void);
	void __fastcall AlignSysMDIButtons(void);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall SetRightToLeft(bool Value);
	void __fastcall CancelMenu(bool ManualCancel);
	MESSAGE void __fastcall CMMenuChanged(Winapi::Messages::TMessage &Message);
	virtual Eltoolbar::TElToolButtonClass __fastcall GetButtonClass(void);
	void __fastcall GetFont(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall MouseOut(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall OnBeforeHook(System::TObject* Sender, Winapi::Messages::TMessage &Message, bool &Handled);
	void __fastcall OnAfterHook(System::TObject* Sender, Winapi::Messages::TMessage &Message, bool &Handled);
	void __fastcall PopupMenuPopup(System::TObject* Sender);
	void __fastcall RebuildMenuBar(void);
	HIDESBASE void __fastcall SetFocusedButton(TElMenuBarButton* Value);
	void __fastcall SetMenu(Elmenus::TElMainMenu* Value);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	MESSAGE void __fastcall ElActivateMenu(Winapi::Messages::TMessage &Message);
	void __fastcall PopupMenuEndPopup(System::TObject* Sender, bool ManualCancel);
	void __fastcall PopupMenuNavigateKey(System::TObject* Sender, System::Word Key);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Message);
	virtual void __fastcall SetOrientation(Eltoolbar::TElBarOrientation newValue);
	MESSAGE void __fastcall ELShortcut(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall ELCancelMenu(Winapi::Messages::TMessage &Message);
	void __fastcall CopyMenuProperties(void);
	void __fastcall MasterChange(System::TObject* Sender, Elmenus::TElMenuItem* MenuItem, bool Rebuild);
	MESSAGE void __fastcall ELRefocusButton(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMCancelMode(Winapi::Messages::TWMNoParams &Message);
	__property TElMenuBarButton* FocusedButton = {read=FFocusedButton, write=SetFocusedButton};
	virtual void __fastcall DoThemeChanged(void);
	
public:
	__fastcall virtual TElMenuBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElMenuBar(void);
	void __fastcall PopupWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall RequestAlign(void);
	
__published:
	__property ParentFont = {default=1};
	__property TabOrder = {default=-1};
	__property Font;
	__property BorderSides = {default=15};
	__property BorderColorDkShadow = {default=-16777195};
	__property BorderColorFace = {default=-16777201};
	__property BorderColorShadow = {default=-16777200};
	__property BorderColorHighlight = {default=-16777196};
	__property BorderColorWindow = {default=-16777211};
	__property BorderType = {default=1};
	__property AlphaLevel = {default=0};
	__property AlwaysPaintBackground = {default=0};
	__property Background;
	__property BackgroundType = {default=2};
	__property GradientEndColor = {default=0};
	__property GradientStartColor = {default=0};
	__property GradientSteps = {default=16};
	__property Alignment = {default=2};
	__property Layout = {default=1};
	__property OwnerDraw = {default=0};
	__property ImageForm;
	__property TopGrabHandle;
	__property RightGrabHandle;
	__property LeftGrabHandle;
	__property BottomGrabHandle;
	__property Enabled = {default=1};
	__property MouseCapture = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ShowHint;
	__property Visible = {default=1};
	__property OnResize;
	__property ParentShowHint = {default=1};
	__property Resizable = {default=0};
	__property Movable = {default=0};
	__property OnMove;
	__property OnPaint;
	__property SizeGrip = {default=0};
	__property Align;
	__property BevelSpaceColor = {default=-16777201};
	__property BevelWidth = {default=1};
	__property BorderStyle = {default=0};
	__property BorderWidth = {default=0};
	__property BevelInner = {default=0};
	__property BevelOuter = {default=0};
	__property BtnOffsHorz = {default=1};
	__property BtnOffsVert = {default=1};
	__property GlyphLayout = {default=0};
	__property Elmenus::TElMainMenu* Menu = {read=FMenu, write=SetMenu};
	__property MinSize;
	__property ShowCaption = {default=1};
	__property RightToLeft = {default=0};
	__property BtnWidth = {default=24};
	__property BtnHeight = {default=24};
	__property AutoWrap = {default=0};
	__property ShowGlyph = {default=1};
	__property LargeSize = {default=0};
	__property LargeBtnWidth = {default=48};
	__property LargeBtnHeight = {default=48};
	__property Spacing = {default=4};
	__property Margin = {default=-1};
	__property Flat = {default=1};
	__property AutoSize = {default=1};
	__property ButtonColor = {default=-16777201};
	__property ButtonImageForm;
	__property Orientation = {default=0};
	__property UseLargeGlyphs = {default=0};
	__property Images;
	__property HotImages;
	__property DisabledImages;
	__property DownImages;
	__property AlphaForImages;
	__property AlphaForHotImages;
	__property AlphaForDisabledImages;
	__property AlphaForDownImages;
	__property UseImageList = {default=0};
	__property TransparentButtons = {default=0};
	__property ThinButtons = {default=0};
	__property Storage;
	__property StoragePath = {default=0};
	__property AdjustButtonWidth = {default=1};
	__property AdjustButtonHeight = {default=1};
	__property ShowBorder = {default=1};
	__property ShowMoreMenu = {default=0};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property BevelKind = {default=0};
	__property DoubleBuffered;
	__property DragKind = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElMenuBar(HWND ParentWindow) : Eltoolbar::TCustomElToolBar(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWndHoolHelper : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TList* FMenusList;
	TElMenuBar* __fastcall GetItem(int AIndex);
	int __fastcall GetCount(void);
	
public:
	__fastcall TLMDWndHoolHelper(void);
	__fastcall virtual ~TLMDWndHoolHelper(void);
	void __fastcall Subscribe(TElMenuBar* AnElMenuBar);
	void __fastcall Unsubsribe(TElMenuBar* AnElMenuBar);
	__property int Count = {read=GetCount, nodefault};
	__property TElMenuBar* Items[int Index] = {read=GetItem};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Word EL_ACTIVATEMENU = System::Word(0x6b4);
static const System::Word EL_SHORTCUT = System::Word(0x6b5);
static const System::Word EL_CANCELMENU = System::Word(0x6b6);
static const System::Word EL_REFOCUSBUTTON = System::Word(0x6b7);
static const System::Word EL_SHOWMENU = System::Word(0x6b8);
extern DELPHI_PACKAGE void __fastcall CopyElMenuItems(Elmenus::TElMenuItem* Dest, Elmenus::TElMenuItem* Source, Elmenus::TElMenuItemClass MenuItemClass);
extern DELPHI_PACKAGE NativeInt __stdcall HookProc(int code, NativeUInt wparam, NativeInt lparam);
}	/* namespace Elmenubar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELMENUBAR)
using namespace Elmenubar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElmenubarHPP
