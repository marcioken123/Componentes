// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomHeaderPanel.pas' rev: 31.00 (Windows)

#ifndef LmdcustomheaderpanelHPP
#define LmdcustomheaderpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Menus.hpp>
#include <LMDButtonBase.hpp>
#include <LMDMain.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDSpeedButton.hpp>
#include <LMDGraph.hpp>
#include <LMDBevel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomheaderpanel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomHeaderPanel;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysButtonMode : unsigned char { sbPin, sbClose };

enum DECLSPEC_DENUM TLMDHeaderOption : unsigned char { hoHeaderButton, hoHideSysButton };

typedef System::Set<TLMDHeaderOption, TLMDHeaderOption::hoHeaderButton, TLMDHeaderOption::hoHideSysButton> TLMDHeaderOptions;

typedef void __fastcall (__closure *TLMDCloseEvent)(System::TObject* Sender, bool wasPinned);

class PASCALIMPLEMENTATION TLMDCustomHeaderPanel : public Lmdcustompanelfill::TLMDCustomPanelFill
{
	typedef Lmdcustompanelfill::TLMDCustomPanelFill inherited;
	
private:
	int FBorderWidth;
	int FHeaderHeight;
	int FRealHeaderHeight;
	Lmdspeedbutton::TLMDSpeedButton* FHeaderButton;
	Lmdspeedbutton::TLMDSpeedButton* FSysButton;
	Vcl::Menus::TPopupMenu* FDropMenu;
	bool FShowMode;
	Lmdbuttonbase::TLMDUserButtonStyle FBtnStyle;
	TLMDSysButtonMode FSysBtnMode;
	TLMDCloseEvent FOnClose;
	TLMDHeaderOptions FHeaderOptions;
	System::Classes::TNotifyEvent FOnModeChange;
	System::Classes::TNotifyEvent FOnHButton;
	System::Classes::TNotifyEvent FOnSButton;
	System::Classes::TNotifyEvent FOnOpen;
	System::Classes::TNotifyEvent FOnOpenFixed;
	Vcl::Controls::TWinControl* FOldParentControl;
	Vcl::Forms::TForm* FContainer;
	bool FOldTransparent;
	Vcl::Controls::TAlign FOldAlign;
	System::Types::TPoint FOldPos;
	System::Types::TRect FOldParentRect;
	Lmdbevel::TLMDBevel* FOldBevel;
	void __fastcall SetHeaderHeight(int aValue);
	Lmdbuttonbase::TLMDUserButtonStyle __fastcall GetStyle(void);
	void __fastcall SetStyle(const Lmdbuttonbase::TLMDUserButtonStyle aValue);
	void __fastcall SetDropMenu(Vcl::Menus::TPopupMenu* aValue);
	void __fastcall SetSysBtnMode(TLMDSysButtonMode aValue);
	void __fastcall SetHeaderOptions(TLMDHeaderOptions aValue);
	bool __fastcall GetPinned(void);
	bool __fastcall GetUnPinned(void);
	HIDESBASE void __fastcall SetBorderWidth(int aValue);
	void __fastcall DoHeaderButtonClick(System::TObject* Sender);
	void __fastcall DoHeaderButtonMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall DoSystemButtonClick(System::TObject* Sender);
	void __fastcall CalcHeaderSize(void);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall CMEnableChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &message);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall AdjustClientRect(System::Types::TRect &Rect);
	virtual void __fastcall DrawCaption(const System::Types::TRect &aRect, Lmdgraph::TLMDAlignment aAlignment);
	virtual void __fastcall DoThemeChanged(void);
	void __fastcall Restore(void);
	void __fastcall DoOnOpen(void);
	void __fastcall DoOnOpenFixed(void);
	void __fastcall DoOnClose(bool wasPinned);
	void __fastcall DoClose(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	__property int HeaderHeight = {read=FHeaderHeight, write=SetHeaderHeight, default=0};
	__property Vcl::Menus::TPopupMenu* HeaderDropMenu = {read=FDropMenu, write=SetDropMenu};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, nodefault};
	__property System::Classes::TNotifyEvent OnHeaderButtonClick = {read=FOnHButton, write=FOnHButton};
	__property System::Classes::TNotifyEvent OnSystemButtonClick = {read=FOnSButton, write=FOnSButton};
	__property Lmdbuttonbase::TLMDUserButtonStyle ButtonStyle = {read=GetStyle, write=SetStyle, default=8};
	__property System::Classes::TNotifyEvent OnOpen = {read=FOnOpen, write=FOnOpen};
	__property System::Classes::TNotifyEvent OnOpenFixed = {read=FOnOpenFixed, write=FOnOpenFixed};
	__property TLMDCloseEvent OnClose = {read=FOnClose, write=FOnClose};
	__property System::Classes::TNotifyEvent OnModeChange = {read=FOnModeChange, write=FOnModeChange};
	
public:
	__fastcall virtual TLMDCustomHeaderPanel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomHeaderPanel(void);
	void __fastcall Open(void);
	void __fastcall OpenFixed(void);
	void __fastcall Close(void);
	__property int RealHeaderHeight = {read=FRealHeaderHeight, nodefault};
	__property Lmdspeedbutton::TLMDSpeedButton* HeaderButton = {read=FHeaderButton};
	__property TLMDSysButtonMode SysButtonMode = {read=FSysBtnMode, write=SetSysBtnMode, default=1};
	__property bool Pinned = {read=GetPinned, nodefault};
	__property bool UnPinned = {read=GetUnPinned, nodefault};
	__property TLMDHeaderOptions HeaderOptions = {read=FHeaderOptions, write=SetHeaderOptions, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomHeaderPanel(HWND ParentWindow) : Lmdcustompanelfill::TLMDCustomPanelFill(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomheaderpanel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMHEADERPANEL)
using namespace Lmdcustomheaderpanel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomheaderpanelHPP
