// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElShadowWindow.pas' rev: 31.00 (Windows)

#ifndef ElshadowwindowHPP
#define ElshadowwindowHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Messages.hpp>
#include <LMDProcs.hpp>
#include <LMDGraphUtils.hpp>
#include <ElVCLUtils.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elshadowwindow
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElShadowRect;
class DELPHICLASS TElVerticalShadow;
class DELPHICLASS TElHorizontalShadow;
class DELPHICLASS TElShadow;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElShadowRect : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
protected:
	Vcl::Graphics::TBitmap* FShadowMask;
	Vcl::Graphics::TBitmap* FSavedBack;
	int FShadowIntensity;
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall Paint(void);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Winapi::Messages::TWMMouseActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	
public:
	__fastcall virtual TElShadowRect(System::Classes::TComponent* Owner);
	__fastcall virtual ~TElShadowRect(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
public:
	/* TWinControl.CreateParented */ inline __fastcall TElShadowRect(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElVerticalShadow : public TElShadowRect
{
	typedef TElShadowRect inherited;
	
public:
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
public:
	/* TElShadowRect.Create */ inline __fastcall virtual TElVerticalShadow(System::Classes::TComponent* Owner) : TElShadowRect(Owner) { }
	/* TElShadowRect.Destroy */ inline __fastcall virtual ~TElVerticalShadow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElVerticalShadow(HWND ParentWindow) : TElShadowRect(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElHorizontalShadow : public TElShadowRect
{
	typedef TElShadowRect inherited;
	
public:
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
public:
	/* TElShadowRect.Create */ inline __fastcall virtual TElHorizontalShadow(System::Classes::TComponent* Owner) : TElShadowRect(Owner) { }
	/* TElShadowRect.Destroy */ inline __fastcall virtual ~TElHorizontalShadow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElHorizontalShadow(HWND ParentWindow) : TElShadowRect(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElShadow : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Vcl::Controls::TControl* FControl;
	TElShadowRect* FVertShadow;
	TElShadowRect* FHorzShadow;
	int FShadowWidth;
	System::Types::TPoint FTopLeftPoint;
	System::Byte FShadowIntensity;
	bool FVisibleHorzShadow;
	bool __fastcall GetVisibleHorizontalShadow(void);
	void __fastcall SetVisibleHorizontalShadow(const bool Value);
	void __fastcall SetShadowIntensity(const System::Byte Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetBounds(const System::Types::TPoint &LTopLeftPoint);
	virtual void __fastcall SetShadowWidth(const int Value);
	virtual void __fastcall SetControl(Vcl::Controls::TControl* const Value);
	bool __fastcall GetVisible(void);
	void __fastcall SetVisble(const bool Value);
	
public:
	__fastcall virtual TElShadow(System::Classes::TComponent* AOwner);
	void __fastcall Show(void);
	void __fastcall Hide(void);
	__fastcall virtual ~TElShadow(void);
	__property bool VisibleHorizontalShadow = {read=GetVisibleHorizontalShadow, write=SetVisibleHorizontalShadow, default=1};
	__property bool Visible = {read=GetVisible, write=SetVisble, nodefault};
	__property Vcl::Controls::TControl* Control = {read=FControl, write=SetControl};
	__property int ShadowWidth = {read=FShadowWidth, write=SetShadowWidth, default=4};
	__property System::Byte ShadowIntensity = {read=FShadowIntensity, write=SetShadowIntensity, default=49};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elshadowwindow */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELSHADOWWINDOW)
using namespace Elshadowwindow;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElshadowwindowHPP
