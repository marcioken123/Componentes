// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElAppBarForm.pas' rev: 31.00 (Windows)

#ifndef ElappbarformHPP
#define ElappbarformHPP

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
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Types.hpp>
#include <Winapi.ShellAPI.hpp>
#include <Vcl.Menus.hpp>
#include <ElAppBar.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elappbarform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElAppBarForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElAppBarForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
protected:
	Elappbar::TElAppBar* FAppBar;
	Elappbar::TAppBarEdge __fastcall GetEdge(void);
	void __fastcall SetAlwaysOnTop(bool bAlwaysOnTop);
	void __fastcall SetAutoHide(bool bAutoHide);
	void __fastcall SetEdge(Elappbar::TAppBarEdge abEdge);
	void __fastcall SetFlags(Elappbar::TAppBarFlags newValue);
	void __fastcall SetKeepSize(bool newValue);
	void __fastcall SetPreventOffScreen(bool newValue);
	bool __fastcall GetAlwaysOnTop(void);
	bool __fastcall GetAutoHide(void);
	bool __fastcall GetAutoHideIsVisible(void);
	System::Types::TRect __fastcall GetDockDims(void);
	Elappbar::TAppBarFlags __fastcall GetFlags(void);
	System::Types::TRect __fastcall GetFloatRect(void);
	int __fastcall GetHorzSizeInc(void);
	void __fastcall SetHorzSizeInc(int Value);
	bool __fastcall GetKeepSize(void);
	int __fastcall GetMaxHeight(void);
	void __fastcall SetMaxHeight(int Value);
	int __fastcall GetMaxWidth(void);
	void __fastcall SetMaxWidth(int Value);
	int __fastcall GetMinHeight(void);
	void __fastcall SetMinHeight(int Value);
	int __fastcall GetMinWidth(void);
	void __fastcall SetMinWidth(int Value);
	System::Classes::TNotifyEvent __fastcall GetOnEdgeChanged(void);
	void __fastcall SetOnEdgeChanged(System::Classes::TNotifyEvent Value);
	System::Classes::TNotifyEvent __fastcall GetOnForcedToDocked(void);
	void __fastcall SetOnForcedToDocked(System::Classes::TNotifyEvent Value);
	bool __fastcall GetPreventOffScreen(void);
	Elappbar::TElAppBarTaskEntry __fastcall GetTaskEntry(void);
	void __fastcall SetTaskEntry(Elappbar::TElAppBarTaskEntry Value);
	int __fastcall GetVertSizeInc(void);
	void __fastcall SetVertSizeInc(int Value);
	
public:
	__fastcall virtual TElAppBarForm(System::Classes::TComponent* AOwner);
	void __fastcall SetDockDims(const System::Types::TRect &rc);
	void __fastcall SetFloatRect(const System::Types::TRect &rc);
	__property bool AutoHideIsVisible = {read=GetAutoHideIsVisible, nodefault};
	__property System::Types::TRect DockDims = {read=GetDockDims, write=SetDockDims};
	__property System::Types::TRect FloatRect = {read=GetFloatRect, write=SetFloatRect};
	
__published:
	__property bool AlwaysOnTop = {read=GetAlwaysOnTop, write=SetAlwaysOnTop, nodefault};
	__property bool AutoHide = {read=GetAutoHide, write=SetAutoHide, nodefault};
	__property Elappbar::TAppBarEdge Edge = {read=GetEdge, write=SetEdge, nodefault};
	__property Elappbar::TAppBarFlags Flags = {read=GetFlags, write=SetFlags, nodefault};
	__property int HorzSizeInc = {read=GetHorzSizeInc, write=SetHorzSizeInc, nodefault};
	__property bool KeepSize = {read=GetKeepSize, write=SetKeepSize, nodefault};
	__property int MaxHeight = {read=GetMaxHeight, write=SetMaxHeight, nodefault};
	__property int MaxWidth = {read=GetMaxWidth, write=SetMaxWidth, nodefault};
	__property int MinHeight = {read=GetMinHeight, write=SetMinHeight, nodefault};
	__property int MinWidth = {read=GetMinWidth, write=SetMinWidth, nodefault};
	__property System::Classes::TNotifyEvent OnEdgeChanged = {read=GetOnEdgeChanged, write=SetOnEdgeChanged};
	__property System::Classes::TNotifyEvent OnForcedToDocked = {read=GetOnForcedToDocked, write=SetOnForcedToDocked};
	__property bool PreventOffScreen = {read=GetPreventOffScreen, write=SetPreventOffScreen, default=0};
	__property Elappbar::TElAppBarTaskEntry TaskEntry = {read=GetTaskEntry, write=SetTaskEntry, nodefault};
	__property int VertSizeInc = {read=GetVertSizeInc, write=SetVertSizeInc, nodefault};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TElAppBarForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TElAppBarForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElAppBarForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elappbarform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELAPPBARFORM)
using namespace Elappbarform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElappbarformHPP
