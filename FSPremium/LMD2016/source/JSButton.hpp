// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSButton.pas' rev: 31.00 (Windows)

#ifndef JsbuttonHPP
#define JsbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.UITypes.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Buttons.hpp>
#include <JSTypes.hpp>
#include <JSGraphUtil.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jsbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TJSCommandLinkColors;
class DELPHICLASS TJSCustomCommandLinkButton;
class DELPHICLASS TJSCommandLinkButton;
class DELPHICLASS TJSSymbolButton;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TPaintStage : unsigned char { psBorder, psFocus, psGlyph, psCaption, psInfo, psPicture };

enum DECLSPEC_DENUM TJSButtonStyle : unsigned char { jsbNative, jsbClassic };

class PASCALIMPLEMENTATION TJSCommandLinkColors : public Jstypes::TJSChangePersistent
{
	typedef Jstypes::TJSChangePersistent inherited;
	
private:
	bool FEnabled;
	System::Uitypes::TColor FBorderInner;
	System::Uitypes::TColor FPressedGradientStart;
	System::Uitypes::TColor FGradientEnd;
	System::Uitypes::TColor FHotGradientEnd;
	System::Uitypes::TColor FPressedGradientEnd;
	System::Uitypes::TColor FBorderOuter;
	System::Uitypes::TColor FGradientStart;
	System::Uitypes::TColor FHotGradientStart;
	System::Uitypes::TColor FFontColor;
	System::Uitypes::TColor FFontHotColor;
	System::Uitypes::TColor FGradientPen;
	System::Uitypes::TColor FFontDisabledColor;
	System::Uitypes::TColor FDefaultBorderOuter;
	System::Uitypes::TColor FDefaultBorderInner;
	System::Uitypes::TColor FFontPressedColor;
	TJSCustomCommandLinkButton* FCommandLinkButton;
	System::Uitypes::TColor FColor;
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetBorderInner(const System::Uitypes::TColor Value);
	void __fastcall SetBorderOuter(const System::Uitypes::TColor Value);
	void __fastcall SetGradientEnd(const System::Uitypes::TColor Value);
	void __fastcall SetGradientStart(const System::Uitypes::TColor Value);
	void __fastcall SetHotGradientEnd(const System::Uitypes::TColor Value);
	void __fastcall SetHotGradientStart(const System::Uitypes::TColor Value);
	void __fastcall SetPressedGradientEnd(const System::Uitypes::TColor Value);
	void __fastcall SetPressedGradientStart(const System::Uitypes::TColor Value);
	void __fastcall SetFontColor(const System::Uitypes::TColor Value);
	void __fastcall SetFontHotColor(const System::Uitypes::TColor Value);
	void __fastcall SetGradientPen(const System::Uitypes::TColor Value);
	void __fastcall SetFontDisabledColor(const System::Uitypes::TColor Value);
	void __fastcall SetDefaultBorderInner(const System::Uitypes::TColor Value);
	void __fastcall SetDefaultBorderOuter(const System::Uitypes::TColor Value);
	void __fastcall SetFontPressedColor(const System::Uitypes::TColor Value);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	
public:
	__fastcall TJSCommandLinkColors(TJSCustomCommandLinkButton* AButton);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	bool __fastcall LoadFromFile(const System::UnicodeString AFilename);
	void __fastcall SaveToFile(const System::UnicodeString AFilename);
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
	__property System::Uitypes::TColor BorderInner = {read=FBorderInner, write=SetBorderInner, default=13027014};
	__property System::Uitypes::TColor BorderOuter = {read=FBorderOuter, write=SetBorderOuter, default=15395562};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=-16777211};
	__property System::Uitypes::TColor DefaultBorderInner = {read=FDefaultBorderInner, write=SetDefaultBorderInner, default=16773038};
	__property System::Uitypes::TColor DefaultBorderOuter = {read=FDefaultBorderOuter, write=SetDefaultBorderOuter, default=16774343};
	__property System::Uitypes::TColor FontColor = {read=FFontColor, write=SetFontColor, default=5577749};
	__property System::Uitypes::TColor FontDisabledColor = {read=FFontDisabledColor, write=SetFontDisabledColor, default=-16777199};
	__property System::Uitypes::TColor FontHotColor = {read=FFontHotColor, write=SetFontHotColor, default=15026695};
	__property System::Uitypes::TColor FontPressedColor = {read=FFontPressedColor, write=SetFontPressedColor, default=536870911};
	__property System::Uitypes::TColor GradientEnd = {read=FGradientEnd, write=SetGradientEnd, default=536870911};
	__property System::Uitypes::TColor GradientPen = {read=FGradientPen, write=SetGradientPen, default=16514043};
	__property System::Uitypes::TColor GradientStart = {read=FGradientStart, write=SetGradientStart, default=536870911};
	__property System::Uitypes::TColor HotGradientEnd = {read=FHotGradientEnd, write=SetHotGradientEnd, default=16185078};
	__property System::Uitypes::TColor HotGradientStart = {read=FHotGradientStart, write=SetHotGradientStart, default=16777215};
	__property System::Uitypes::TColor PressedGradientEnd = {read=FPressedGradientEnd, write=SetPressedGradientEnd, default=15527147};
	__property System::Uitypes::TColor PressedGradientStart = {read=FPressedGradientStart, write=SetPressedGradientStart, default=15527147};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TJSCommandLinkColors(void) { }
	
};


class PASCALIMPLEMENTATION TJSCustomCommandLinkButton : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	bool FMouseInControl;
	Vcl::Graphics::TPicture* FPicture;
	Vcl::Graphics::TPicture* FGlyph;
	Vcl::Graphics::TIcon* FHotGlyph;
	Vcl::Graphics::TIcon* FColdGlyph;
	Vcl::Graphics::TIcon* FDownGlyph;
	Vcl::Graphics::TIcon* FDisabledGlyph;
	System::Classes::TStrings* FInfo;
	Vcl::Graphics::TFont* FInfoFont;
	System::Uitypes::TModalResult FModalResult;
	bool FShowIcon;
	int FDefaultHeight;
	bool FDefault;
	bool FCancel;
	bool FElevationRequired;
	HRGN FRgn;
	TJSButtonStyle FStyle;
	bool FMouseButtonPressed;
	System::LongBool FShowHotKey;
	bool FProcessEnter;
	bool FProcessSpace;
	Jstypes::TJSBackground* FBackground;
	System::UnicodeString FCaption;
	Vcl::Imglist::TCustomImageList* FPictureImages;
	int FPictureIndex;
	Vcl::Imglist::TCustomImageList* FGlyphImages;
	int FGlyphIndex;
	TJSCommandLinkColors* FCommandLinkColors;
	void __fastcall InfoChangeHandler(System::TObject* Sender);
	void __fastcall SetMouseInControl(const bool Value);
	void __fastcall SetGlyph(Vcl::Graphics::TPicture* const Value);
	void __fastcall SetPicture(Vcl::Graphics::TPicture* const Value);
	void __fastcall SetInfo(System::Classes::TStrings* const Value);
	void __fastcall SetInfoFont(Vcl::Graphics::TFont* const Value);
	void __fastcall PictureChangeHandler(System::TObject* Sender);
	void __fastcall SetShowIcon(const bool Value);
	void __fastcall SetDefaultHeight(const int Value);
	void __fastcall SetDefault(const bool Value);
	void __fastcall SetCancel(const bool Value);
	void __fastcall SetElevationRequired(const bool Value);
	void __fastcall SetStyle(const TJSButtonStyle Value);
	void __fastcall DeleteRegion(void);
	bool __fastcall IsMouseButtonPressed(void);
	void __fastcall SetShowHotKey(const System::LongBool Value);
	int __fastcall GetMinimumWidth(void);
	int __fastcall LeftMargin(const TPaintStage AStage);
	void __fastcall SetPictureImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetPictureIndex(const int Value);
	void __fastcall SetGlyphImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetGlyphIndex(const int Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetCommandLinkColors(TJSCommandLinkColors* const Value);
	
protected:
	virtual void __fastcall InitialiseGlyphs(void);
	virtual void __fastcall InitialiseFonts(void);
	DYNAMIC void __fastcall AdjustBounds(void);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontchanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseenter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseleave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMTextchanged(Winapi::Messages::TMessage &Message);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CustomColorsChangeHandler(System::TObject* Sender);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, System::Classes::TShiftState Shift);
	virtual System::Types::TRect __fastcall GetRect(TPaintStage AStage);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	virtual void __fastcall PaintBorder(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall PaintCaption(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall PaintDefaultBorder(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall PaintFocus(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall PaintGlyph(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall PaintInfo(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall PaintPicture(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect);
	virtual void __fastcall RecreateRegion(void);
	virtual System::UnicodeString __fastcall GetInfoText(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall SetAutoSize(bool Value);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	bool __fastcall PictureAssigned(void);
	int __fastcall PictureHeight(void);
	int __fastcall PictureWidth(void);
	bool __fastcall GlyphAssigned(void);
	int __fastcall GlyphHeight(void);
	int __fastcall GlyphWidth(void);
	
public:
	__fastcall virtual TJSCustomCommandLinkButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TJSCustomCommandLinkButton(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Color = {default=-16777211};
	__property TJSCommandLinkColors* CommandLinkColors = {read=FCommandLinkColors, write=SetCommandLinkColors};
	__property bool Default = {read=FDefault, write=SetDefault, default=0};
	__property bool Cancel = {read=FCancel, write=SetCancel, default=0};
	__property bool MouseInControl = {read=FMouseInControl, write=SetMouseInControl, nodefault};
	__property TabStop = {default=1};
	__property int DefaultHeight = {read=FDefaultHeight, write=SetDefaultHeight, default=-1};
	__property bool ElevationRequired = {read=FElevationRequired, write=SetElevationRequired, default=0};
	__property Vcl::Graphics::TPicture* Glyph = {read=FGlyph, write=SetGlyph};
	__property int GlyphIndex = {read=FGlyphIndex, write=SetGlyphIndex, default=-1};
	__property Vcl::Imglist::TCustomImageList* GlyphImages = {read=FGlyphImages, write=SetGlyphImages};
	__property System::Classes::TStrings* Info = {read=FInfo, write=SetInfo};
	__property Vcl::Graphics::TFont* InfoFont = {read=FInfoFont, write=SetInfoFont};
	__property ParentColor = {default=0};
	__property Vcl::Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
	__property int PictureIndex = {read=FPictureIndex, write=SetPictureIndex, default=-1};
	__property Vcl::Imglist::TCustomImageList* PictureImages = {read=FPictureImages, write=SetPictureImages};
	__property System::LongBool ShowHotKey = {read=FShowHotKey, write=SetShowHotKey, nodefault};
	__property bool ShowIcon = {read=FShowIcon, write=SetShowIcon, default=1};
	__property TJSButtonStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property System::Uitypes::TModalResult ModalResult = {read=FModalResult, write=FModalResult, default=0};
	__property int MinimumWidth = {read=GetMinimumWidth, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TJSCustomCommandLinkButton(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TJSCommandLinkButton : public TJSCustomCommandLinkButton
{
	typedef TJSCustomCommandLinkButton inherited;
	
__published:
	__property AutoSize = {default=0};
	__property Caption;
	__property BiDiMode;
	__property Color = {default=-16777211};
	__property CommandLinkColors;
	__property Default = {default=0};
	__property DefaultHeight = {default=-1};
	__property ElevationRequired = {default=0};
	__property Font;
	__property Glyph;
	__property GlyphIndex = {default=-1};
	__property GlyphImages;
	__property Hint = {default=0};
	__property Info;
	__property InfoFont;
	__property ModalResult = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentShowHint = {default=1};
	__property Picture;
	__property PictureIndex = {default=-1};
	__property PictureImages;
	__property ShowIcon = {default=1};
	__property Style = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property OnClick;
public:
	/* TJSCustomCommandLinkButton.Create */ inline __fastcall virtual TJSCommandLinkButton(System::Classes::TComponent* AOwner) : TJSCustomCommandLinkButton(AOwner) { }
	/* TJSCustomCommandLinkButton.Destroy */ inline __fastcall virtual ~TJSCommandLinkButton(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TJSCommandLinkButton(HWND ParentWindow) : TJSCustomCommandLinkButton(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TSymbolButtonStyle : unsigned char { sbsNone, sbsEllipsis, sbsArrowDown, sbsArrowUp, sbsArrowLeft, sbsArrowRight };

class PASCALIMPLEMENTATION TJSSymbolButton : public Vcl::Buttons::TSpeedButton
{
	typedef Vcl::Buttons::TSpeedButton inherited;
	
private:
	TSymbolButtonStyle FStyle;
	int FArrowSize;
	System::Uitypes::TColor FSymbolColor;
	System::Uitypes::TColor FSymbolShadowColor;
	void __fastcall SetStyle(const TSymbolButtonStyle Value);
	void __fastcall SetArrowSize(const int Value);
	void __fastcall SetSymbolColor(const System::Uitypes::TColor Value);
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TJSSymbolButton(System::Classes::TComponent* AOwner);
	
__published:
	__property int ArrowSize = {read=FArrowSize, write=SetArrowSize, default=4};
	__property System::Uitypes::TColor SymbolColor = {read=FSymbolColor, write=SetSymbolColor, default=536870911};
	__property System::Uitypes::TColor SymbolShadowColor = {read=FSymbolShadowColor, write=FSymbolShadowColor, default=536870911};
	__property TSymbolButtonStyle Style = {read=FStyle, write=SetStyle, default=0};
public:
	/* TSpeedButton.Destroy */ inline __fastcall virtual ~TJSSymbolButton(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Jsbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSBUTTON)
using namespace Jsbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JsbuttonHPP
