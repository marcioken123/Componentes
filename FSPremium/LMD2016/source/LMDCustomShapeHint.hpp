// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomShapeHint.pas' rev: 31.00 (Windows)

#ifndef LmdcustomshapehintHPP
#define LmdcustomshapehintHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <LMDTypes.hpp>
#include <LMDButtonBase.hpp>
#include <LMD3DCaption.hpp>
#include <LMDShadow.hpp>
#include <LMDPNGImage.hpp>
#include <LMDNativeHint.hpp>
#include <LMDCustomHint.hpp>
#include <LMDGradient.hpp>
#include <LMDClass.hpp>
#include <LMDThemes.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomshapehint
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShapeHintWindow;
class DELPHICLASS TLMDCustomShapeHint;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDHintStyle : unsigned char { hsRect, hsRoundRect, hsEllipse, hsNoseRect, hsNoseRoundRect, hsNoseEllipse };

enum DECLSPEC_DENUM TLMDHintPosition : unsigned char { hpAboveLeft, hpAboveRight, hpBelowLeft, hpBelowRight };

enum DECLSPEC_DENUM TLMDHintOption : unsigned char { hoShowTitle, hoShowCloseButton, hoShowIcon, hoRightAngledNose };

typedef System::Set<TLMDHintOption, TLMDHintOption::hoShowTitle, TLMDHintOption::hoRightAngledNose> TLMDHintOptions;

enum DECLSPEC_DENUM TLMDHintCloseBtnType : unsigned char { hcbCustom, hcbToolTip, hcbToolWindow };

enum DECLSPEC_DENUM TLMDHintIconType : unsigned char { hitCustom, hitError, hitInfo, hitQuestion, hitWarning };

class PASCALIMPLEMENTATION TLMDShapeHintWindow : public Lmdcustomhint::TLMDCustomHTMLHintWindow
{
	typedef Lmdcustomhint::TLMDCustomHTMLHintWindow inherited;
	
private:
	Lmdpngimage::TLMDPNGObject* FIcon;
	TLMDHintIconType FIconType;
	System::Types::TRect FCloseBtnRect;
	bool FCloseBtnPressed;
	Lmdtypes::TLMDString FTitle;
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	int __fastcall ShadowDepth(void);
	void __fastcall SetTitle(const Lmdtypes::TLMDString Value);
	void __fastcall SetIcon(Lmdpngimage::TLMDPNGObject* const Value);
	void __fastcall SetIconType(const TLMDHintIconType Value);
	
protected:
	System::Types::TPoint FOrigin;
	System::Types::TSize FCloseBtnSize;
	virtual void __fastcall AdjustTextRect(System::Types::TRect &aRect, bool aShowIcon, bool aShowCloseBtn);
	virtual void __fastcall CalculateDimensions(System::Types::TRect &aRect);
	virtual void __fastcall PreCreateWnd(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall Paint(void);
	virtual void __fastcall PrepareIcon(void);
	virtual void __fastcall PaintHintWindow(void);
	virtual void __fastcall PaintCloseBtn(const System::Types::TRect &ARect, TLMDHintCloseBtnType ABtnType, Lmdbuttonbase::TLMDButtonState aButtonState);
	virtual void __fastcall PaintBgr(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* ACanvas, TLMDHintPosition AHintPosition, System::Types::TRect &TxRect, const System::Types::TPoint &Pos);
	void __fastcall SetPosition(const System::Types::TPoint &Origin, TLMDHintPosition &pos, System::Types::TRect &aRect);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DrawTextTo(Vcl::Graphics::TCanvas* ACanvas, Lmdtypes::TLMDString ACaption, const System::Types::TRect &ATextRect);
	virtual void __fastcall DrawTitleTo(Vcl::Graphics::TCanvas* ACanvas, Lmdtypes::TLMDString ACaption, const System::Types::TRect &ATextRect);
	void __fastcall GetTitleSize(System::UnicodeString ACaption, System::Types::TRect &aRect);
	virtual bool __fastcall UseSystemShadow(void);
	
public:
	__fastcall virtual TLMDShapeHintWindow(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDShapeHintWindow(void);
	HIDESBASE TLMDCustomShapeHint* __fastcall HintControl(void);
	virtual void __fastcall ActivateHint(const System::Types::TRect &aRect, const System::UnicodeString AHint);
	void __fastcall ActivateHintExt(const System::Types::TRect &aRect, const System::UnicodeString aHint);
	__property Lmdtypes::TLMDString Title = {read=FTitle, write=SetTitle};
	__property Lmdpngimage::TLMDPNGObject* Icon = {read=FIcon, write=SetIcon};
	__property TLMDHintIconType IconType = {read=FIconType, write=SetIconType, nodefault};
public:
	/* TLMDBaseHintWindow.CreateCustom */ inline __fastcall TLMDShapeHintWindow(System::Classes::TComponent* AOwner, Lmdnativehint::TLMDBaseHint* AHintControl) : Lmdcustomhint::TLMDCustomHTMLHintWindow(AOwner, AHintControl) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDShapeHintWindow(HWND ParentWindow) : Lmdcustomhint::TLMDCustomHTMLHintWindow(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomShapeHint : public Lmdcustomhint::TLMDCustomHTMLHint
{
	typedef Lmdcustomhint::TLMDCustomHTMLHint inherited;
	
private:
	Lmdtypes::TLMDString FDefaultTitle;
	Vcl::Graphics::TFont* FTitleFont;
	Lmd3dcaption::TLMD3DCaption* FTitleFont3D;
	TLMDHintOptions FOptions;
	TLMDHintCloseBtnType FCloseBtnType;
	Lmdbuttonbase::TLMDUserButtonStyle FCloseBtnStyle;
	TLMDHintIconType FDefaultIcon;
	System::Uitypes::TColor FBorderColor;
	TLMDHintPosition FPosition;
	TLMDHintStyle FStyle;
	Lmdshadow::TLMDShadow* FShadow;
	System::Classes::TNotifyEvent FOnClose;
	bool FUseSystemShadow;
	System::Byte FNoseLength;
	System::Byte FNoseWidth;
	System::Byte FNoseAndleWidth;
	System::Byte FRoundRect;
	System::Byte FDistance;
	bool FIsBalloon;
	Lmdgradient::TLMDGradient* FGradient;
	bool FUseGradient;
	bool FThemeGlobalMode;
	Lmdclass::TLMDThemeMode FThemeMode;
	void __fastcall SetShadow(Lmdshadow::TLMDShadow* aValue);
	void __fastcall SetIsBalloon(const bool Value);
	void __fastcall SetOptions(const TLMDHintOptions Value);
	void __fastcall SetTitleFont3D(Lmd3dcaption::TLMD3DCaption* const Value);
	void __fastcall SetTitleFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetCloseButtonType(const TLMDHintCloseBtnType Value);
	void __fastcall SetCloseButtonStyle(const Lmdbuttonbase::TLMDUserButtonStyle Value);
	void __fastcall SetDefaultIcon(const TLMDHintIconType Value);
	void __fastcall SetUseSystemShadow(const bool Value);
	void __fastcall SetGradient(Lmdgradient::TLMDGradient* const Value);
	void __fastcall SetThemeGlobalMode(const bool Value);
	void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	void __fastcall SetUseGradient(const bool Value);
	
protected:
	virtual Vcl::Controls::THintWindowClass __fastcall GetHintClass(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	__property TLMDHintCloseBtnType CloseBtnType = {read=FCloseBtnType, write=SetCloseButtonType, default=1};
	__property Lmdbuttonbase::TLMDUserButtonStyle CloseBtnStyle = {read=FCloseBtnStyle, write=SetCloseButtonStyle, default=1};
	__property Lmdtypes::TLMDString DefaultTitle = {read=FDefaultTitle, write=FDefaultTitle};
	__property System::Byte Distance = {read=FDistance, write=FDistance, default=1};
	__property TLMDHintIconType DefaultIcon = {read=FDefaultIcon, write=SetDefaultIcon, default=2};
	__property Lmdgradient::TLMDGradient* Gradient = {read=FGradient, write=SetGradient};
	__property bool IsBalloon = {read=FIsBalloon, write=SetIsBalloon, default=0};
	__property System::Byte NoseLength = {read=FNoseLength, write=FNoseLength, default=25};
	__property System::Byte NoseWidth = {read=FNoseWidth, write=FNoseWidth, default=25};
	__property System::Byte NoseAngleWidth = {read=FNoseAndleWidth, write=FNoseAndleWidth, default=25};
	__property TLMDHintOptions Options = {read=FOptions, write=SetOptions, nodefault};
	__property TLMDHintPosition Position = {read=FPosition, write=FPosition, default=1};
	__property System::Byte RoundRectWidth = {read=FRoundRect, write=FRoundRect, default=18};
	__property Lmdshadow::TLMDShadow* Shadow = {read=FShadow, write=SetShadow};
	__property TLMDHintStyle Style = {read=FStyle, write=FStyle, default=4};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property Lmd3dcaption::TLMD3DCaption* TitleFont3D = {read=FTitleFont3D, write=SetTitleFont3D};
	__property bool UseGradient = {read=FUseGradient, write=SetUseGradient, default=0};
	__property bool UseSystemShadow = {read=FUseSystemShadow, write=SetUseSystemShadow, default=0};
	
public:
	__fastcall virtual TLMDCustomShapeHint(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomShapeHint(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	bool __fastcall IsThemed(void);
	__property HideAccelChar = {default=1};
	
__published:
	__property About = {default=0};
	__property System::Uitypes::TColor BorderColor = {read=FBorderColor, write=FBorderColor, default=0};
	__property Color = {default=-16777192};
	__property Enabled = {default=1};
	__property System::Classes::TNotifyEvent OnCloseHintWindow = {read=FOnClose, write=FOnClose};
	__property Vcl::Graphics::TFont* TitleFont = {read=FTitleFont, write=SetTitleFont};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomshapehint */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMSHAPEHINT)
using namespace Lmdcustomshapehint;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomshapehintHPP
