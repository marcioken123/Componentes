// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElBiProgr.pas' rev: 31.00 (Windows)

#ifndef ElbiprogrHPP
#define ElbiprogrHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <System.Math.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.TypInfo.hpp>
#include <Winapi.UxTheme.hpp>
#include <Vcl.Themes.hpp>
#include <ElStyleMan.hpp>
#include <ElImgFrm.hpp>
#include <ElVCLUtils.hpp>
#include <ElXPThemedControl.hpp>
#include <LMDUtils.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>
#include <LMDThemes.hpp>
#include <System.UITypes.hpp>
#include <LMDClass.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elbiprogr
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElBiProgressBar;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TProgrShowMode : unsigned char { psmAllFull, psmLightHalf, psmDarkHalf, psmAllHalf };

enum DECLSPEC_DENUM TElBevelStyle : unsigned char { ebsNone, ebsLowered, ebsRaised };

enum DECLSPEC_DENUM TElProgrOrientation : unsigned char { poHorizontal, poVertical };

class PASCALIMPLEMENTATION TElBiProgressBar : public Elxpthemedcontrol::TElXPThemedControl
{
	typedef Elxpthemedcontrol::TElXPThemedControl inherited;
	
private:
	int FMinValue;
	TElProgrOrientation FOrientation;
	bool FSmooth;
	int FScale;
	bool FAdditive;
	TProgrShowMode FProgrShowMode;
	bool FLightTextFullLine;
	bool FDarkTextFullLine;
	bool FLightButtonStyle;
	bool FDarkButtonStyle;
	TElBevelStyle FBevelStyle;
	Lmdtypes::TLMDString FDarkText;
	Lmdtypes::TLMDString FLightText;
	System::Uitypes::TColor FDarkTextColor;
	System::Uitypes::TColor FLightTextColor;
	System::Uitypes::TColor FLightColor;
	System::Uitypes::TColor FDarkColor;
	int FLightValue;
	int FDarkValue;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	Elimgfrm::TElImageForm* FImgForm;
	Lmdtypes::TLMDString FCaption;
	Vcl::Graphics::TBitmap* FBitmap;
	bool FInfiniteMode;
	bool FMarquee;
	int FMarqueeSize;
	int FMarqueeUpdateInterval;
	Vcl::Extctrls::TTimer* FMarqueeTimer;
	int FMarqueeValue;
	System::Uitypes::TColor FMarqueeColor;
	bool FMarqueeDirection;
	void __fastcall SetMarquee(bool Value);
	void __fastcall SetMarqueeSize(int Value);
	void __fastcall SetMarqueeUpdateInterval(int Value);
	void __fastcall OnMarqueeTimer(System::TObject* Sender);
	virtual void __fastcall SetImageForm(Elimgfrm::TElImageForm* NewValue);
	void __fastcall ImageFormChange(System::TObject* Sender);
	void __fastcall SetMarqueeColor(System::Uitypes::TColor aValue);
	void __fastcall SetLightColor(System::Uitypes::TColor aValue);
	void __fastcall SetDarkColor(System::Uitypes::TColor aValue);
	void __fastcall SetScale(int aValue);
	void __fastcall SetLightValue(int aValue);
	void __fastcall SetDarkValue(int aValue);
	void __fastcall SetAdditive(bool aValue);
	void __fastcall SetProgrShowMode(TProgrShowMode aValue);
	void __fastcall SetDarkText(Lmdtypes::TLMDString NewValue);
	void __fastcall SetLightText(Lmdtypes::TLMDString NewValue);
	void __fastcall SetCaption(Lmdtypes::TLMDString NewValue);
	void __fastcall SetDarkTextColor(System::Uitypes::TColor NewValue);
	void __fastcall SetLightTextColor(System::Uitypes::TColor NewValue);
	void __fastcall SetBevelStyle(TElBevelStyle NewValue);
	void __fastcall SetMinValue(int NewValue);
	void __fastcall SetLightButtonStyle(bool NewValue);
	void __fastcall SetDarkButtonStyle(bool NewValue);
	void __fastcall SetLightTextFullLine(bool NewValue);
	void __fastcall SetDarkTextFullLine(bool NewValue);
	void __fastcall SetDarkGradient(bool Value);
	void __fastcall SetDarkGradientSteps(int Value);
	void __fastcall SetLightGradient(bool Value);
	void __fastcall SetLightGradientSteps(int Value);
	void __fastcall SetOrientation(TElProgrOrientation NewValue);
	void __fastcall SetSmooth(bool NewValue);
	
protected:
	Lmdtypes::TLMDString FHint;
	bool FTransparent;
	bool FDarkGradient;
	int FDarkGradientSteps;
	bool FLightGradient;
	int FLightGradientSteps;
	virtual void __fastcall Paint(void);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	virtual Vcl::Themes::TThemedElement __fastcall GetThemedElement(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadBorderStyle(System::Classes::TReader* Reader);
	void __fastcall SetTransparent(bool NewValue);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TElBiProgressBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElBiProgressBar(void);
	void __fastcall SetValues(int ALightValue, int ADarkValue, int AScale, bool AAdditive);
	
__published:
	__property bool Marquee = {read=FMarquee, write=SetMarquee, default=0};
	__property int MarqueeSize = {read=FMarqueeSize, write=SetMarqueeSize, default=20};
	__property int MarqueeUpdateInterval = {read=FMarqueeUpdateInterval, write=SetMarqueeUpdateInterval, default=25};
	__property System::Uitypes::TColor MarqueeColor = {read=FMarqueeColor, write=SetMarqueeColor, default=128};
	__property System::Uitypes::TColor LightColor = {read=FLightColor, write=SetLightColor, default=255};
	__property System::Uitypes::TColor DarkColor = {read=FDarkColor, write=SetDarkColor, default=128};
	__property int Scale = {read=FScale, write=SetScale, default=100};
	__property int LightValue = {read=FLightValue, write=SetLightValue, default=0};
	__property int DarkValue = {read=FDarkValue, write=SetDarkValue, default=0};
	__property bool Additive = {read=FAdditive, write=SetAdditive, default=0};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property TProgrShowMode ProgressShowMode = {read=FProgrShowMode, write=SetProgrShowMode, default=0};
	__property bool LightTextFullLine = {read=FLightTextFullLine, write=SetLightTextFullLine, default=0};
	__property bool DarkTextFullLine = {read=FDarkTextFullLine, write=SetDarkTextFullLine, default=0};
	__property Lmdtypes::TLMDString DarkText = {read=FDarkText, write=SetDarkText};
	__property Lmdtypes::TLMDString LightText = {read=FLightText, write=SetLightText};
	__property System::Uitypes::TColor DarkTextColor = {read=FDarkTextColor, write=SetDarkTextColor, default=-16777198};
	__property System::Uitypes::TColor LightTextColor = {read=FLightTextColor, write=SetLightTextColor, default=-16777198};
	__property TElBevelStyle BevelStyle = {read=FBevelStyle, write=SetBevelStyle, default=0};
	__property int MinValue = {read=FMinValue, write=SetMinValue, default=0};
	__property bool LightButtonStyle = {read=FLightButtonStyle, write=SetLightButtonStyle, default=0};
	__property bool DarkButtonStyle = {read=FDarkButtonStyle, write=SetDarkButtonStyle, default=0};
	__property TElProgrOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property bool Smooth = {read=FSmooth, write=SetSmooth, default=0};
	__property bool InfiniteMode = {read=FInfiniteMode, write=FInfiniteMode, default=0};
	__property bool DarkGradient = {read=FDarkGradient, write=SetDarkGradient, default=0};
	__property int DarkGradientSteps = {read=FDarkGradientSteps, write=SetDarkGradientSteps, default=64};
	__property bool LightGradient = {read=FLightGradient, write=SetLightGradient, default=0};
	__property int LightGradientSteps = {read=FLightGradientSteps, write=SetLightGradientSteps, default=64};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Align = {default=0};
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentColor = {default=0};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property DragKind = {default=0};
	__property DoubleBuffered;
public:
	/* TWinControl.CreateParented */ inline __fastcall TElBiProgressBar(HWND ParentWindow) : Elxpthemedcontrol::TElXPThemedControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elbiprogr */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELBIPROGR)
using namespace Elbiprogr;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElbiprogrHPP
