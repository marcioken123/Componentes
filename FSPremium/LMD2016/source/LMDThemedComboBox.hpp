// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDThemedComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdthemedcomboboxHPP
#define LmdthemedcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Themes.hpp>
#include <LMDClass.hpp>
#include <LMDTypes.hpp>
#include <intfLMDBase.hpp>
#include <LMDBoundLabel.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdthemedcombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDThemedComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDThemedComboBox : public Vcl::Stdctrls::TCustomComboBox
{
	typedef Vcl::Stdctrls::TCustomComboBox inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	int FBtnWidth;
	bool FPressed;
	bool FMouseAbove;
	bool FMouseAboveBtn;
	NativeUInt FListBoxHandle;
	HBRUSH FEditBrushHandle;
	System::Uitypes::TColor FBgrColor;
	int FSbWidth;
	bool FPainting;
	bool FFillListBoxBgr;
	Lmdclass::TLMDThemeMode FThemeMode;
	bool FParentThemeMode;
	bool FThemeGlobalMode;
	void *FListBoxWndProcOld;
	void *FListBoxInstance;
	bool FHasBoundLabel;
	Lmdboundlabel::TLMDBoundLabel* FEditLabel;
	Vcl::Extctrls::TLabelPosition FLabelPosition;
	int FLabelSpacing;
	bool FLabelSync;
	void __fastcall SetLabelPosition(const Vcl::Extctrls::TLabelPosition Value);
	void __fastcall SetLabelSpacing(const int Value);
	void __fastcall SetHasLabel(bool aValue);
	void __fastcall SetLabelSync(const bool Value);
	void __fastcall ReadEditLabel(System::Classes::TStream* Stream);
	void __fastcall set_CtlXP(bool aValue);
	bool __fastcall get_CtlXP(void);
	void __fastcall ReadCtlXP(System::Classes::TReader* Reader);
	void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	void __fastcall SetThemeGlobalMode(const bool Value);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMRecreateWnd(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Msg);
	MESSAGE void __fastcall WMThemeChanged(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall CMLMDBOUNDLABELCHANGE(Winapi::Messages::TMessage &Message);
	void __fastcall SetParentThemeMode(const bool Value);
	
protected:
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetName(const System::Classes::TComponentName Value);
	virtual void __fastcall SetParent(Vcl::Controls::TWinControl* AParent);
	void __fastcall CallPrevListBoxWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	System::Types::TRect __fastcall GetBtnRect(void);
	void __fastcall ListBoxWndProc(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseEnter(void);
	virtual void __fastcall MouseExit(void);
	virtual void __fastcall Paint(HDC DestDC);
	System::Uitypes::TColor __fastcall GetThemedBkColor(void);
	System::Uitypes::TColor __fastcall GetThemedFontColor(void);
	void __fastcall SetNewListBoxWndProc(void);
	void __fastcall RestoreListBoxWndProc(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	__property bool MouseAbove = {read=FMouseAbove, nodefault};
	__property bool CtlXP = {read=get_CtlXP, write=set_CtlXP, default=1};
	__property Lmdboundlabel::TLMDBoundLabel* EditLabel = {read=FEditLabel};
	__property Vcl::Extctrls::TLabelPosition LabelPosition = {read=FLabelPosition, write=SetLabelPosition, default=0};
	__property bool LabelSync = {read=FLabelSync, write=SetLabelSync, default=0};
	__property int LabelSpacing = {read=FLabelSpacing, write=SetLabelSpacing, default=3};
	__property bool HasBoundLabel = {read=FHasBoundLabel, write=SetHasLabel, nodefault};
	
public:
	__fastcall virtual TLMDThemedComboBox(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDThemedComboBox(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall SetupEditLabel(void);
	bool __fastcall IsThemed(void);
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property ListHandle;
	__property OnDropDown;
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property bool ParentThemeMode = {read=FParentThemeMode, write=SetParentThemeMode, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDThemedComboBox(HWND ParentWindow) : Vcl::Stdctrls::TCustomComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdthemedcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTHEMEDCOMBOBOX)
using namespace Lmdthemedcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdthemedcomboboxHPP
