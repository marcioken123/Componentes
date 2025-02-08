// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElLabel.pas' rev: 31.00 (Windows)

#ifndef EllabelHPP
#define EllabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <Winapi.UxTheme.hpp>
#include <Vcl.Themes.hpp>
#include <ElCLabel.hpp>
#include <ElXPThemedControl.hpp>
#include <LMDTypes.hpp>
#include <LMDThemes.hpp>
#include <LMDGraphUtils.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Ellabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElLabel;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElLabelTextStyle : unsigned char { ltsNormal, ltsEmbossed, ltsRecessed, ltsOutlined };

enum DECLSPEC_DENUM TElLabelEffectStyle : unsigned char { lesNone, lesShadow, lesExtrude };

enum DECLSPEC_DENUM TElLabelExtrudePosition : unsigned char { lepLeft, lepLeftTop, lepTop, lepRightTop, lepRight, lepRightBottom, lepBottom, lepLeftBottom };

class PASCALIMPLEMENTATION TElLabel : public Elclabel::TCustomElLabel
{
	typedef Elclabel::TCustomElLabel inherited;
	
private:
	int FAngle;
	Vcl::Graphics::TBitmap* FBuffer;
	System::Uitypes::TColor FDarkColor;
	int FDepth;
	System::Uitypes::TColor FDisabledDarkColor;
	System::Uitypes::TColor FDisabledLightColor;
	TElLabelEffectStyle FEffect;
	System::Uitypes::TColor FFarColor;
	System::Uitypes::TColor FLightColor;
	System::Uitypes::TColor FNearColor;
	System::Uitypes::TColor FOutlineColor;
	TElLabelExtrudePosition FPosition;
	System::Uitypes::TColor FShadowColor;
	bool FStriated;
	TElLabelTextStyle FStyle;
	int FXOffset;
	int FYOffset;
	void __fastcall SetAngle(int Value);
	void __fastcall SetDarkColor(const System::Uitypes::TColor Value);
	void __fastcall SetDepth(const int Value);
	void __fastcall SetDisabledDarkColor(const System::Uitypes::TColor Value);
	void __fastcall SetDisabledLightColor(const System::Uitypes::TColor Value);
	void __fastcall SetEffect(const TElLabelEffectStyle Value);
	void __fastcall SetExtrudePosition(const TElLabelExtrudePosition Value);
	void __fastcall SetFarColor(const System::Uitypes::TColor Value);
	void __fastcall SetLightColor(const System::Uitypes::TColor Value);
	void __fastcall SetNearColor(const System::Uitypes::TColor Value);
	void __fastcall SetOutlineColor(const System::Uitypes::TColor Value);
	void __fastcall SetShadowColor(const System::Uitypes::TColor Value);
	void __fastcall SetStriated(const bool Value);
	void __fastcall SetStyle(const TElLabelTextStyle Value);
	void __fastcall SetXOffset(const int Value);
	void __fastcall SetYOffset(const int Value);
	
protected:
	DYNAMIC void __fastcall DoDrawText(System::Types::TRect &Rect, int Flags);
	virtual void __fastcall DrawDisabledText(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &Rect, Lmdtypes::TLMDString Text, int Flags);
	DYNAMIC void __fastcall DrawEffect(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &Rect, int Flags);
	void __fastcall DrawExtrusion(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &Rect, Lmdtypes::TLMDString Text, int Flags, System::Uitypes::TColor NearColor, System::Uitypes::TColor FarColor);
	void __fastcall DrawNormalText(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &Rect, Lmdtypes::TLMDString Text, int Flags);
	void __fastcall DrawOutlinedText(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &Rect, Lmdtypes::TLMDString Text, int Flags, System::Uitypes::TColor OutlineColor);
	void __fastcall DrawRaisedText(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &Rect, Lmdtypes::TLMDString Text, int Flags, System::Uitypes::TColor LeftTop, System::Uitypes::TColor RightBottom);
	void __fastcall DrawShadow(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &Rect, Lmdtypes::TLMDString Text, int Flags, int X, int Y, System::Uitypes::TColor ShadowColor);
	DYNAMIC void __fastcall DrawText(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &Rect, int Flags);
	virtual void __fastcall Paint(void);
	virtual void __fastcall SetName(const System::Classes::TComponentName Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	__property int Angle = {read=FAngle, write=SetAngle, default=0};
	
public:
	__fastcall virtual TElLabel(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElLabel(void);
	
__published:
	__property System::Uitypes::TColor DarkColor = {read=FDarkColor, write=SetDarkColor, default=-16777200};
	__property int Depth = {read=FDepth, write=SetDepth, default=10};
	__property System::Uitypes::TColor DisabledDarkColor = {read=FDisabledDarkColor, write=SetDisabledDarkColor, default=-16777200};
	__property System::Uitypes::TColor DisabledLightColor = {read=FDisabledLightColor, write=SetDisabledLightColor, default=-16777196};
	__property TElLabelEffectStyle Effect = {read=FEffect, write=SetEffect, default=0};
	__property TElLabelExtrudePosition ExtrudePosition = {read=FPosition, write=SetExtrudePosition, default=5};
	__property System::Uitypes::TColor FarColor = {read=FFarColor, write=SetFarColor, default=0};
	__property System::Uitypes::TColor LightColor = {read=FLightColor, write=SetLightColor, default=-16777196};
	__property System::Uitypes::TColor NearColor = {read=FNearColor, write=SetNearColor, default=0};
	__property System::Uitypes::TColor OutlineColor = {read=FOutlineColor, write=SetOutlineColor, default=16777215};
	__property System::Uitypes::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=-16777200};
	__property bool Striated = {read=FStriated, write=SetStriated, default=0};
	__property TElLabelTextStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property int XOffset = {read=FXOffset, write=SetXOffset, default=2};
	__property int YOffset = {read=FYOffset, write=SetYOffset, default=2};
	__property Transparent = {default=1};
	__property EndEllipsis = {default=0};
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property AutoSize = {default=1};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property Color;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property FocusControl;
	__property Font;
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowAccelChar = {default=1};
	__property ShowHint;
	__property Layout = {default=0};
	__property Visible = {default=1};
	__property WordWrap = {default=0};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnStartDock;
	__property OnStartDrag;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Ellabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELLABEL)
using namespace Ellabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EllabelHPP
