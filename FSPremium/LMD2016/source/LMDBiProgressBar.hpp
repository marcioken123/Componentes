// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBiProgressBar.pas' rev: 31.00 (Windows)

#ifndef LmdbiprogressbarHPP
#define LmdbiprogressbarHPP

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
#include <LMDCustomControl.hpp>
#include <LMDFillObject.hpp>
#include <LMDGraph.hpp>
#include <LMDUtils.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>
#include <LMDThemes.hpp>
#include <LMD3DCaption.hpp>
#include <LMDBevel.hpp>
#include <LMDControl.hpp>
#include <System.UITypes.hpp>
#include <LMDClass.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbiprogressbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBiProgressBar;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDProgressShowMode : unsigned char { psmAllFull, psmLightHalf, psmDarkHalf, psmAllHalf };

class PASCALIMPLEMENTATION TLMDBiProgressBar : public Lmdcustomcontrol::TLMDCustomControl
{
	typedef Lmdcustomcontrol::TLMDCustomControl inherited;
	
private:
	int FMinValue;
	Lmdgraph::TLMDMeterDirection FDirection;
	bool FSmooth;
	int FScale;
	bool FAdditive;
	TLMDProgressShowMode FProgressShowMode;
	bool FLightTextFullLine;
	bool FDarkTextFullLine;
	Lmdtypes::TLMDString FDarkText;
	Lmdtypes::TLMDString FLightText;
	System::Uitypes::TColor FDarkTextColor;
	System::Uitypes::TColor FLightTextColor;
	System::Uitypes::TColor FLightColor;
	System::Uitypes::TColor FDarkColor;
	int FLightValue;
	int FDarkValue;
	Lmdtypes::TLMDString FCaption;
	Vcl::Graphics::TBitmap* FBitmap;
	bool FInfiniteMode;
	bool FMarquee;
	int FMarqueeSize;
	int FMarqueeUpdateInterval;
	Vcl::Extctrls::TTimer* FMarqueeTimer;
	int FMarqueeValue;
	bool FMarqueeDirection;
	Lmdfillobject::TLMDFillObject* FMarqueeFillObject;
	Lmdfillobject::TLMDFillObject* FDarkFillObject;
	Lmdfillobject::TLMDFillObject* FLightFillObject;
	Lmdgraph::TLMDBorderStyle FDarkBar3D;
	Lmdgraph::TLMDBorderStyle FLightBar3D;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	Lmdbevel::TLMDBevel* FBevel;
	Lmdfillobject::TLMDFillObject* FBackFillObject;
	System::Uitypes::TColor FBrushBackColor;
	Lmdgraph::TLMDMeterTextOptions FDarkTextOptions;
	Lmdgraph::TLMDMeterTextOptions FLightTextOptions;
	Lmdtypes::TLMDMargins* FLightMargins;
	Lmdtypes::TLMDMargins* FDarkMargins;
	void __fastcall SetMarquee(bool Value);
	void __fastcall SetMarqueeSize(int Value);
	void __fastcall SetMarqueeUpdateInterval(int Value);
	void __fastcall OnMarqueeTimer(System::TObject* Sender);
	void __fastcall SetScale(int aValue);
	void __fastcall SetLightValue(int aValue);
	void __fastcall SetDarkValue(int aValue);
	void __fastcall SetAdditive(bool aValue);
	void __fastcall SetProgressShowMode(TLMDProgressShowMode aValue);
	void __fastcall SetDarkText(Lmdtypes::TLMDString NewValue);
	void __fastcall SetLightText(Lmdtypes::TLMDString NewValue);
	void __fastcall SetCaption(Lmdtypes::TLMDString NewValue);
	void __fastcall SetDarkTextColor(System::Uitypes::TColor NewValue);
	void __fastcall SetLightTextColor(System::Uitypes::TColor NewValue);
	void __fastcall SetMinValue(int NewValue);
	void __fastcall SetLightTextFullLine(bool NewValue);
	void __fastcall SetDarkTextFullLine(bool NewValue);
	void __fastcall SetDirection(Lmdgraph::TLMDMeterDirection NewValue);
	void __fastcall SetSmooth(bool NewValue);
	void __fastcall SetDarkFillObject(Lmdfillobject::TLMDFillObject* const Value);
	void __fastcall SetLightFillObject(Lmdfillobject::TLMDFillObject* const Value);
	void __fastcall SetDarkBar3D(const Lmdgraph::TLMDBorderStyle Value);
	void __fastcall SetLightBar3D(const Lmdgraph::TLMDBorderStyle Value);
	void __fastcall SetMarqueeFillObject(Lmdfillobject::TLMDFillObject* const Value);
	Lmdfillobject::TLMDFillObject* __fastcall GetDarkFillObject(void);
	void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* const Value);
	Lmdfillobject::TLMDFillObject* __fastcall GetMarqueeFillObject(void);
	void __fastcall SetBevel(Lmdbevel::TLMDBevel* const Value);
	void __fastcall SetBackFillObject(Lmdfillobject::TLMDFillObject* const Value);
	void __fastcall SetBrushBackColor(const System::Uitypes::TColor Value);
	void __fastcall SetDarkTextOptions(const Lmdgraph::TLMDMeterTextOptions Value);
	void __fastcall SetLightTextOptions(const Lmdgraph::TLMDMeterTextOptions Value);
	void __fastcall SetLightMargins(Lmdtypes::TLMDMargins* const Value);
	void __fastcall SetDarkMargins(Lmdtypes::TLMDMargins* const Value);
	void __fastcall RepaintControl(System::TObject* Sender);
	Lmdfillobject::TLMDFillObject* __fastcall GetBackFillObject(void);
	Lmdfillobject::TLMDFillObject* __fastcall GetLightFillObject(void);
	
protected:
	Lmdtypes::TLMDString FHint;
	bool FTransparent;
	virtual void __fastcall Paint(void);
	HIDESBASE void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall ReadBorderStyle(System::Classes::TReader* Reader);
	HIDESBASE void __fastcall SetTransparent(bool NewValue);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDBiProgressBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDBiProgressBar(void);
	void __fastcall SetValues(int ALightValue, int ADarkValue, int AScale, bool AAdditive);
	
__published:
	__property bool Marquee = {read=FMarquee, write=SetMarquee, default=0};
	__property int MarqueeSize = {read=FMarqueeSize, write=SetMarqueeSize, default=20};
	__property int MarqueeUpdateInterval = {read=FMarqueeUpdateInterval, write=SetMarqueeUpdateInterval, default=25};
	__property Lmdfillobject::TLMDFillObject* MarqueeFillObject = {read=GetMarqueeFillObject, write=SetMarqueeFillObject};
	__property int Scale = {read=FScale, write=SetScale, default=100};
	__property int LightValue = {read=FLightValue, write=SetLightValue, default=0};
	__property int DarkValue = {read=FDarkValue, write=SetDarkValue, default=0};
	__property bool Additive = {read=FAdditive, write=SetAdditive, default=0};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property TLMDProgressShowMode ProgressShowMode = {read=FProgressShowMode, write=SetProgressShowMode, default=0};
	__property bool LightTextFullLine = {read=FLightTextFullLine, write=SetLightTextFullLine, default=0};
	__property bool DarkTextFullLine = {read=FDarkTextFullLine, write=SetDarkTextFullLine, default=0};
	__property Lmdtypes::TLMDString DarkText = {read=FDarkText, write=SetDarkText};
	__property Lmdtypes::TLMDString LightText = {read=FLightText, write=SetLightText};
	__property System::Uitypes::TColor DarkTextColor = {read=FDarkTextColor, write=SetDarkTextColor, default=-16777198};
	__property System::Uitypes::TColor LightTextColor = {read=FLightTextColor, write=SetLightTextColor, default=-16777198};
	__property int MinValue = {read=FMinValue, write=SetMinValue, default=0};
	__property Lmdgraph::TLMDBorderStyle LightBar3D = {read=FLightBar3D, write=SetLightBar3D, default=0};
	__property Lmdgraph::TLMDBorderStyle DarkBar3D = {read=FDarkBar3D, write=SetDarkBar3D, default=0};
	__property Lmdgraph::TLMDMeterDirection Direction = {read=FDirection, write=SetDirection, default=0};
	__property bool Smooth = {read=FSmooth, write=SetSmooth, default=0};
	__property bool InfiniteMode = {read=FInfiniteMode, write=FInfiniteMode, default=0};
	__property Lmdfillobject::TLMDFillObject* DarkFillObject = {read=GetDarkFillObject, write=SetDarkFillObject};
	__property Lmdfillobject::TLMDFillObject* LightFillObject = {read=GetLightFillObject, write=SetLightFillObject};
	__property Lmdfillobject::TLMDFillObject* BackFillObject = {read=GetBackFillObject, write=SetBackFillObject};
	__property System::Uitypes::TColor BrushBackColor = {read=FBrushBackColor, write=SetBrushBackColor, default=-16777201};
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3D};
	__property Lmdbevel::TLMDBevel* Bevel = {read=FBevel, write=SetBevel};
	__property Lmdgraph::TLMDMeterTextOptions LightTextOptions = {read=FLightTextOptions, write=SetLightTextOptions, default=0};
	__property Lmdgraph::TLMDMeterTextOptions DarkTextOptions = {read=FDarkTextOptions, write=SetDarkTextOptions, default=0};
	__property Lmdtypes::TLMDMargins* LightMargins = {read=FLightMargins, write=SetLightMargins};
	__property Lmdtypes::TLMDMargins* DarkMargins = {read=FDarkMargins, write=SetDarkMargins};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property ThemeMode = {default=1};
	__property ParentThemeMode = {default=1};
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
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDBiProgressBar(HWND ParentWindow) : Lmdcustomcontrol::TLMDCustomControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbiprogressbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBIPROGRESSBAR)
using namespace Lmdbiprogressbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbiprogressbarHPP
