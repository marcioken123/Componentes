// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTechnicalLine.pas' rev: 31.00 (Windows)

#ifndef LmdtechnicallineHPP
#define LmdtechnicallineHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtechnicalline
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTechnicalLine;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDTechnicalLineTypes : unsigned char { lsStraightLeftToRight, lsStraightTopToBottom, lsTopLeftToBottomRight, lsBottomLeftToTopRight, lsTopLeftEdge, lsBottomLeftEdge, lsTopRightEdge, lsBottomRightEdge, lsTopLeftCurve, lsBottomLeftCurve, lsTopRightCurve, lsBottomRightCurve };

enum DECLSPEC_DENUM TLMDLineEndings : unsigned char { leNothing, leOpenArrowUp, leOpenArrowDown, leOpenArrowRight, leOpenArrowLeft, leClosedArrowUp, leClosedArrowDown, leClosedArrowLeft, leClosedArrowRight, leDiamond, leCircle, leRectangle, leRoundRect, leParallelogramm, leComb, leHalfCircleLeft, leHalfCircleRight, leHalfCircleUp, leHalfCircleDown };

enum DECLSPEC_DENUM TLMDSignPlaces : unsigned char { spEnd, spStart, spBoth, spNoWhere };

class PASCALIMPLEMENTATION TLMDTechnicalLine : public Lmdgraphiccontrol::TLMDGraphicControl
{
	typedef Lmdgraphiccontrol::TLMDGraphicControl inherited;
	
private:
	TLMDTechnicalLineTypes FTechnicalLineType;
	TLMDLineEndings FLineEndingsign;
	TLMDLineEndings FLineStartSign;
	Vcl::Graphics::TPen* FLineSettings;
	bool FArrowed;
	int FShadowDepth;
	int FSignSize;
	TLMDSignPlaces FSignPlaces;
	System::Uitypes::TColor FShadowColor;
	System::Uitypes::TColor FFillColor;
	bool FShapeOnlyMouse;
	bool FShadowVisible;
	HRGN drawnShape;
	void __fastcall SetTechnicalLineType(TLMDTechnicalLineTypes Value);
	void __fastcall SetLineEnding(TLMDLineEndings Value);
	void __fastcall SetLineStart(TLMDLineEndings Value);
	void __fastcall SetSignSize(int Value);
	void __fastcall SetSignPlaces(TLMDSignPlaces Value);
	void __fastcall SetFillColor(System::Uitypes::TColor Value);
	void __fastcall SetShadowColor(System::Uitypes::TColor Value);
	void __fastcall SetShadowVisible(bool Value);
	void __fastcall SetShadowDepth(int Value);
	void __fastcall SetArrowed(bool Value);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	
protected:
	virtual bool __fastcall GetEmpty(void);
	virtual void __fastcall Paint(void);
	void __fastcall PaintIt(const System::Types::TRect &aRect);
	
public:
	__fastcall virtual TLMDTechnicalLine(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDTechnicalLine(void);
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Bevel;
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property TLMDTechnicalLineTypes LineType = {read=FTechnicalLineType, write=SetTechnicalLineType, default=0};
	__property TLMDLineEndings LineEndingsign = {read=FLineEndingsign, write=SetLineEnding, default=8};
	__property ParentColor = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property int SignSize = {read=FSignSize, write=SetSignSize, default=40};
	__property TLMDSignPlaces SignPlaces = {read=FSignPlaces, write=SetSignPlaces, default=0};
	__property TLMDLineEndings LineStartSign = {read=FLineStartSign, write=SetLineStart, default=0};
	__property Vcl::Graphics::TPen* LineSettings = {read=FLineSettings, write=FLineSettings};
	__property System::Uitypes::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=-16777200};
	__property bool ShadowVisible = {read=FShadowVisible, write=SetShadowVisible, default=0};
	__property int ShadowDepth = {read=FShadowDepth, write=SetShadowDepth, default=6};
	__property System::Uitypes::TColor FillColor = {read=FFillColor, write=SetFillColor, default=536870911};
	__property bool Arrowed = {read=FArrowed, write=SetArrowed, default=0};
	__property bool ShapeOnly = {read=FShapeOnlyMouse, write=FShapeOnlyMouse, default=0};
	__property Transparent = {default=1};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property DragKind = {default=0};
	__property Constraints;
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtechnicalline */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTECHNICALLINE)
using namespace Lmdtechnicalline;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtechnicallineHPP
