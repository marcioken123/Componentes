// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sHintManager.pas' rev: 27.00 (Windows)

#ifndef ShintmanagerHPP
#define ShintmanagerHPP

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
#include <System.Types.hpp>	// Pascal unit
#include <sGraphUtils.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <System.IniFiles.hpp>	// Pascal unit
#include <sHtmlParse.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Shintmanager
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TsMousePosition : unsigned char { mpLeftTop, mpLeftBottom, mpRightTop, mpRightBottom };

enum DECLSPEC_DENUM TsHintsEffectsMode : unsigned char { hmNone, hmSystem, hmCustom };

typedef Vcl::Controls::THintInfo THintInfo;

class DELPHICLASS TsHintKind;
class DELPHICLASS TsHintManager;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TsHintKind : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TsHintManager* FOwner;
	bool FShadowEnabled;
	int FMarginV;
	int FTexturePercent;
	int FShadowBlur;
	int FTransparency;
	int FGradientPercent;
	int FMarginH;
	int FExOffset;
	int FShadowTransparency;
	int FShadowOffset;
	int FBevelWidth;
	int FMaxWidth;
	int FRadius;
	int FBevel;
	System::UnicodeString FGradientData;
	System::UnicodeString FTextureFile;
	System::Uitypes::TColor FColorBorderTop;
	System::Uitypes::TColor FColorBorderBottom;
	System::Uitypes::TColor FColor;
	System::Uitypes::TColor FShadowColor;
	Vcl::Graphics::TFont* FFont;
	Vcl::Graphics::TPicture* FTexture;
	Sconst::TsHintStyle FStyle;
	int FBlur;
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetStyle(const Sconst::TsHintStyle Value);
	void __fastcall SetTexture(Vcl::Graphics::TPicture* const Value);
	bool __fastcall GetShadowEnabled(void);
	int __fastcall GetShadowBlur(void);
	int __fastcall GetShadowOffset(void);
	int __fastcall GetShadowTransparency(void);
	void __fastcall SetBlur(const int Value);
	void __fastcall SetShadowColor(const System::Uitypes::TColor Value);
	
public:
	__fastcall TsHintKind(TsHintManager* AOwner);
	__fastcall virtual ~TsHintKind(void);
	
__published:
	__property Sconst::TsHintStyle Style = {read=FStyle, write=SetStyle, default=2};
	__property int Radius = {read=FRadius, write=FRadius, default=20};
	__property int BevelWidth = {read=FBevelWidth, write=FBevelWidth, default=1};
	__property int Blur = {read=FBlur, write=SetBlur, default=0};
	__property int ExOffset = {read=FExOffset, write=FExOffset, default=32};
	__property System::UnicodeString GradientData = {read=FGradientData, write=FGradientData};
	__property Vcl::Graphics::TPicture* Texture = {read=FTexture, write=SetTexture};
	__property System::UnicodeString TextureFile = {read=FTextureFile, write=FTextureFile};
	__property int GradientPercent = {read=FGradientPercent, write=FGradientPercent, default=0};
	__property int TexturePercent = {read=FTexturePercent, write=FTexturePercent, default=0};
	__property int Bevel = {read=FBevel, write=FBevel, nodefault};
	__property System::Uitypes::TColor Color = {read=FColor, write=FColor, nodefault};
	__property System::Uitypes::TColor ColorBorderTop = {read=FColorBorderTop, write=FColorBorderTop, nodefault};
	__property System::Uitypes::TColor ColorBorderBottom = {read=FColorBorderBottom, write=FColorBorderBottom, nodefault};
	__property int Transparency = {read=FTransparency, write=FTransparency, nodefault};
	__property int ShadowBlur = {read=GetShadowBlur, write=FShadowBlur, nodefault};
	__property System::Uitypes::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=0};
	__property bool ShadowEnabled = {read=GetShadowEnabled, write=FShadowEnabled, nodefault};
	__property int ShadowOffset = {read=GetShadowOffset, write=FShadowOffset, nodefault};
	__property int ShadowTransparency = {read=GetShadowTransparency, write=FShadowTransparency, nodefault};
	__property int MarginH = {read=FMarginH, write=FMarginH, default=15};
	__property int MarginV = {read=FMarginV, write=FMarginV, default=10};
	__property int MaxWidth = {read=FMaxWidth, write=FMaxWidth, default=200};
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TacShowHintEvent)(System::UnicodeString &HintStr, bool &CanShow, Vcl::Controls::THintInfo &HintInfo, Vcl::Forms::TFrame* &Frame);

class DELPHICLASS TsCustomHintWindow;
class PASCALIMPLEMENTATION TsHintManager _DEPRECATED_ATTRIBUTE1("Use TacAlphaHints instead")  : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	int FPauseHide _DEPRECATED_ATTRIBUTE0 ;
	bool FHTMLMode _DEPRECATED_ATTRIBUTE0 ;
	Sconst::TsHintsPredefinitions FPredefinitions _DEPRECATED_ATTRIBUTE0 ;
	TacShowHintEvent FOnShowHint _DEPRECATED_ATTRIBUTE0 ;
	TsHintKind* FHintKind _DEPRECATED_ATTRIBUTE0 ;
	TsMousePosition FDefaultMousePos _DEPRECATED_ATTRIBUTE0 ;
	bool FAnimated _DEPRECATED_ATTRIBUTE0 ;
	System::Types::TPoint FHintPos _DEPRECATED_ATTRIBUTE0 ;
	System::UnicodeString FSkinSection _DEPRECATED_ATTRIBUTE0 ;
	bool FUseSkinData _DEPRECATED_ATTRIBUTE0 ;
	void __fastcall SetNewStyle _DEPRECATED_ATTRIBUTE0 (Sconst::TsHintStyle hs);
	void __fastcall SetPredefinitions _DEPRECATED_ATTRIBUTE0 (const Sconst::TsHintsPredefinitions Value);
	bool __fastcall GetAnimated _DEPRECATED_ATTRIBUTE0 (void);
	void __fastcall SetSkinData _DEPRECATED_ATTRIBUTE0 (const bool Value);
	void __fastcall SetPauseHide _DEPRECATED_ATTRIBUTE0 (const int Value);
	
public:
	TsCustomHintWindow* FTempHint _DEPRECATED_ATTRIBUTE0 ;
	Vcl::Graphics::TBitmap* FCacheBmp _DEPRECATED_ATTRIBUTE0 ;
	void __fastcall OnShowHintApp _DEPRECATED_ATTRIBUTE0 (System::UnicodeString &HintStr, bool &CanShow, Vcl::Controls::THintInfo &HintInfo);
	__fastcall virtual TsHintManager _DEPRECATED_ATTRIBUTE0 (System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsHintManager _DEPRECATED_ATTRIBUTE0 (void);
	virtual void __fastcall Loaded _DEPRECATED_ATTRIBUTE0 (void);
	virtual void __fastcall AfterConstruction _DEPRECATED_ATTRIBUTE0 (void);
	void __fastcall Invalidate _DEPRECATED_ATTRIBUTE0 (void);
	void __fastcall PaintBG _DEPRECATED_ATTRIBUTE0 (Vcl::Graphics::TBitmap* BGBmp, const System::Types::TRect &R, const Sconst::TCacheInfo &ci);
	void __fastcall ShowHint _DEPRECATED_ATTRIBUTE0 (Vcl::Controls::TControl* TheControl, const System::UnicodeString HintText);
	void __fastcall HideHint _DEPRECATED_ATTRIBUTE0 (void);
	void __fastcall UpdateProperties _DEPRECATED_ATTRIBUTE0 (void);
	bool __fastcall Skinned _DEPRECATED_ATTRIBUTE0 (void);
	
__published:
	__property TacShowHintEvent OnShowHint = {read=FOnShowHint, write=FOnShowHint};
	__property bool Animated = {read=GetAnimated, write=FAnimated, default=1};
	__property TsMousePosition DefaultMousePos = {read=FDefaultMousePos, write=FDefaultMousePos, default=0};
	__property TsHintKind* HintKind = {read=FHintKind, write=FHintKind};
	__property bool HTMLMode = {read=FHTMLMode, write=FHTMLMode, default=0};
	__property int PauseHide = {read=FPauseHide, write=SetPauseHide, default=5000};
	__property Sconst::TsHintsPredefinitions Predefinitions = {read=FPredefinitions, write=SetPredefinitions, default=3};
	__property System::UnicodeString SkinSection = {read=FSkinSection, write=FSkinSection};
	__property bool UseSkinData = {read=FUseSkinData, write=SetSkinData, default=0};
};


class PASCALIMPLEMENTATION TsCustomHintWindow : public Vcl::Controls::THintWindow
{
	typedef Vcl::Controls::THintWindow inherited;
	
private:
	System::Types::TPoint FHintLocation;
	HIDESBASE MESSAGE void __fastcall WMEraseBkGND(Winapi::Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMPaint &Message);
	void __fastcall PrepareMask(void);
	
protected:
	int SkinIndex;
	int BorderIndex;
	int BGIndex;
	HRGN rgn;
	int dx;
	int dy;
	TsMousePosition FMousePos;
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual System::Types::TPoint __fastcall GetMousePosition(void);
	DYNAMIC System::Types::TRect __fastcall MainRect(void);
	int __fastcall ShadowTransparency(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	int __fastcall SkinMargin(System::Byte Border);
	
public:
	Vcl::Graphics::TBitmap* BodyBmp;
	Vcl::Graphics::TBitmap* MaskBmp;
	Vcl::Graphics::TBitmap* ScreenBmp;
	Vcl::Graphics::TBitmap* AlphaBmp;
	DYNAMIC Vcl::Graphics::TBitmap* __fastcall GetMask(void);
	DYNAMIC Vcl::Graphics::TBitmap* __fastcall GetBody(void);
	virtual void __fastcall PaintShadow(Vcl::Graphics::TBitmap* Bmp = (Vcl::Graphics::TBitmap*)(0x0));
	__property System::Types::TPoint HintLocation = {read=FHintLocation, write=FHintLocation};
	virtual void __fastcall Paint(void);
	void __fastcall PaintBG(Vcl::Graphics::TBitmap* Bmp, const System::Types::TRect &aRect);
	DYNAMIC void __fastcall PaintBorder(Vcl::Graphics::TBitmap* Bmp);
	void __fastcall TextOut(Vcl::Graphics::TBitmap* Bmp);
	virtual System::Types::TRect __fastcall CalcHintRect(int MaxWidth, const System::UnicodeString AHint, void * AData);
	virtual void __fastcall ActivateHint(const System::Types::TRect &Rect, const System::UnicodeString AHint);
	__fastcall virtual TsCustomHintWindow(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsCustomHintWindow(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TsCustomHintWindow(HWND ParentWindow) : Vcl::Controls::THintWindow(ParentWindow) { }
	
};


class DELPHICLASS TsSimplyHintWindow;
class PASCALIMPLEMENTATION TsSimplyHintWindow : public TsCustomHintWindow
{
	typedef TsCustomHintWindow inherited;
	
public:
	virtual void __fastcall PaintShadow(Vcl::Graphics::TBitmap* Bmp = (Vcl::Graphics::TBitmap*)(0x0));
	DYNAMIC Vcl::Graphics::TBitmap* __fastcall GetMask(void);
	DYNAMIC Vcl::Graphics::TBitmap* __fastcall GetBody(void);
	virtual System::Types::TPoint __fastcall GetMousePosition(void);
	DYNAMIC void __fastcall PaintBorder(Vcl::Graphics::TBitmap* Bmp);
public:
	/* TsCustomHintWindow.Create */ inline __fastcall virtual TsSimplyHintWindow(System::Classes::TComponent* AOwner) : TsCustomHintWindow(AOwner) { }
	/* TsCustomHintWindow.Destroy */ inline __fastcall virtual ~TsSimplyHintWindow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsSimplyHintWindow(HWND ParentWindow) : TsCustomHintWindow(ParentWindow) { }
	
};


class DELPHICLASS TsComicsHintWindow;
class PASCALIMPLEMENTATION TsComicsHintWindow : public TsCustomHintWindow
{
	typedef TsCustomHintWindow inherited;
	
public:
	DYNAMIC System::Types::TRect __fastcall MainRect(void);
	virtual void __fastcall PaintShadow(Vcl::Graphics::TBitmap* Bmp = (Vcl::Graphics::TBitmap*)(0x0));
	DYNAMIC Vcl::Graphics::TBitmap* __fastcall GetMask(void);
	System::Types::TPoint __fastcall GetArrowPosition(void);
	virtual System::Types::TRect __fastcall CalcHintRect(int MaxWidth, const System::UnicodeString AHint, void * AData);
	DYNAMIC Vcl::Graphics::TBitmap* __fastcall GetBody(void);
	DYNAMIC void __fastcall PaintBorder(Vcl::Graphics::TBitmap* Bmp);
public:
	/* TsCustomHintWindow.Create */ inline __fastcall virtual TsComicsHintWindow(System::Classes::TComponent* AOwner) : TsCustomHintWindow(AOwner) { }
	/* TsCustomHintWindow.Destroy */ inline __fastcall virtual ~TsComicsHintWindow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsComicsHintWindow(HWND ParentWindow) : TsCustomHintWindow(ParentWindow) { }
	
};


class DELPHICLASS TsEllipseHintWindow;
class PASCALIMPLEMENTATION TsEllipseHintWindow : public TsCustomHintWindow
{
	typedef TsCustomHintWindow inherited;
	
public:
	System::Types::TPoint __fastcall GetArrowPosition(void);
	DYNAMIC Vcl::Graphics::TBitmap* __fastcall GetBody(void);
	DYNAMIC Vcl::Graphics::TBitmap* __fastcall GetMask(void);
	DYNAMIC System::Types::TRect __fastcall MainRect(void);
	virtual void __fastcall PaintShadow(Vcl::Graphics::TBitmap* Bmp = (Vcl::Graphics::TBitmap*)(0x0));
	virtual System::Types::TRect __fastcall CalcHintRect(int MaxWidth, const System::UnicodeString AHint, void * AData);
	DYNAMIC void __fastcall PaintBorder(Vcl::Graphics::TBitmap* Bmp);
public:
	/* TsCustomHintWindow.Create */ inline __fastcall virtual TsEllipseHintWindow(System::Classes::TComponent* AOwner) : TsCustomHintWindow(AOwner) { }
	/* TsCustomHintWindow.Destroy */ inline __fastcall virtual ~TsEllipseHintWindow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsEllipseHintWindow(HWND ParentWindow) : TsCustomHintWindow(ParentWindow) { }
	
};


class DELPHICLASS TsBalloonHintWindow;
class PASCALIMPLEMENTATION TsBalloonHintWindow : public TsCustomHintWindow
{
	typedef TsCustomHintWindow inherited;
	
public:
	int BalloonCount;
	int Divid;
	virtual void __fastcall PaintShadow(Vcl::Graphics::TBitmap* Bmp = (Vcl::Graphics::TBitmap*)(0x0));
	DYNAMIC Vcl::Graphics::TBitmap* __fastcall GetMask(void);
	Vcl::Graphics::TBitmap* __fastcall GetCustMask(bool Shadow);
	DYNAMIC Vcl::Graphics::TBitmap* __fastcall GetBody(void);
	System::Types::TPoint __fastcall GetArrowPosition(void);
	virtual System::Types::TRect __fastcall CalcHintRect(int MaxWidth, const System::UnicodeString AHint, void * AData);
	__fastcall virtual TsBalloonHintWindow(System::Classes::TComponent* AOwner);
	DYNAMIC System::Types::TRect __fastcall MainRect(void);
	DYNAMIC void __fastcall PaintBorder(Vcl::Graphics::TBitmap* Bmp);
public:
	/* TsCustomHintWindow.Destroy */ inline __fastcall virtual ~TsBalloonHintWindow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsBalloonHintWindow(HWND ParentWindow) : TsCustomHintWindow(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const Sconst::TsHintStyle DefStyle = (Sconst::TsHintStyle)(2);
static const System::Byte DefAnimationTime = System::Byte(0xfa);
extern DELPHI_PACKAGE System::StaticArray<Sconst::TsHintsPredefinitions, 9> asHintsPredefinitions;
extern DELPHI_PACKAGE bool acHintsInEditor;
extern DELPHI_PACKAGE TsHintManager* Manager;
extern DELPHI_PACKAGE void __fastcall SumByMask(Vcl::Graphics::TBitmap* &Src1, Vcl::Graphics::TBitmap* &Src2, Vcl::Graphics::TBitmap* &MskBmp, const System::Types::TRect &aRect);
}	/* namespace Shintmanager */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SHINTMANAGER)
using namespace Shintmanager;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ShintmanagerHPP
