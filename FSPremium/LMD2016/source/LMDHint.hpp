// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHint.pas' rev: 31.00 (Windows)

#ifndef LmdhintHPP
#define LmdhintHPP

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
#include <LMDCustomHint.hpp>
#include <LMDCustomShapeHint.hpp>
#include <LMDShapeHint.hpp>
#include <LMDNativeHint.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>
#include <LMD3DCaption.hpp>
#include <LMDGradient.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhint
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHint;
class DELPHICLASS TLMDHintWindow;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDHint : public Lmdcustomshapehint::TLMDCustomShapeHint
{
	typedef Lmdcustomshapehint::TLMDCustomShapeHint inherited;
	
private:
	bool FBackgroundedBevel;
	void __fastcall SetBackgroundedBevel(const bool Value);
	
protected:
	virtual Vcl::Controls::THintWindowClass __fastcall GetHintClass(void);
	
public:
	__fastcall virtual TLMDHint(System::Classes::TComponent* AOwner);
	
__published:
	__property About = {default=0};
	__property Bevel;
	__property Color = {default=-16777192};
	__property DefaultTitle = {default=0};
	__property DefaultIcon = {default=2};
	__property Enabled = {default=1};
	__property Font3D;
	__property Gradient;
	__property IsBalloon = {default=0};
	__property HideAccelChar = {default=1};
	__property Options;
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property TitleFont;
	__property TitleFont3D;
	__property bool BackgroundedBevel = {read=FBackgroundedBevel, write=SetBackgroundedBevel, default=1};
	__property UseGradient = {default=0};
public:
	/* TLMDCustomShapeHint.Destroy */ inline __fastcall virtual ~TLMDHint(void) { }
	
};


class PASCALIMPLEMENTATION TLMDHintWindow : public Lmdcustomshapehint::TLMDShapeHintWindow
{
	typedef Lmdcustomshapehint::TLMDShapeHintWindow inherited;
	
protected:
	virtual void __fastcall AdjustTextRect(System::Types::TRect &aRect, bool aShowIcon, bool aShowCloseBtn);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* ACanvas, Lmdcustomshapehint::TLMDHintPosition AHintPosition, System::Types::TRect &TxRect, const System::Types::TPoint &Pos);
	virtual void __fastcall AdjustHintRect(System::Types::TRect &aRect);
	
public:
	HIDESBASE TLMDHint* __fastcall HintControl(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
public:
	/* TLMDShapeHintWindow.Create */ inline __fastcall virtual TLMDHintWindow(System::Classes::TComponent* AOwner) : Lmdcustomshapehint::TLMDShapeHintWindow(AOwner) { }
	/* TLMDShapeHintWindow.Destroy */ inline __fastcall virtual ~TLMDHintWindow(void) { }
	
public:
	/* TLMDBaseHintWindow.CreateCustom */ inline __fastcall TLMDHintWindow(System::Classes::TComponent* AOwner, Lmdnativehint::TLMDBaseHint* AHintControl) : Lmdcustomshapehint::TLMDShapeHintWindow(AOwner, AHintControl) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDHintWindow(HWND ParentWindow) : Lmdcustomshapehint::TLMDShapeHintWindow(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdhint */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHINT)
using namespace Lmdhint;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhintHPP
