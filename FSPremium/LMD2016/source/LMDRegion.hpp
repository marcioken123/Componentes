// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRegion.pas' rev: 31.00 (Windows)

#ifndef LmdregionHPP
#define LmdregionHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDObject.hpp>
#include <LMDRegionMask.hpp>
#include <LMDShadow.hpp>
#include <LMDGraph.hpp>
#include <LMDPointList.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdregion
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRgnShadow;
class DELPHICLASS TLMDRegionBorder;
class DELPHICLASS TLMDRegion;
class DELPHICLASS TLMDBorderRegion;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDRegionShape : unsigned char { rsRect, rsRoundRect, rsBitmap, rsNoseRect, rsRoundNoseRect, rsElliptic, rsStar, rsRoundShield, rsSharpShield, rsDiamond, rsOctagon, rsComb, rsHalfRound, rsUserRegion, rsThinkBubble, rsRoundThinkBubble, rsEllipticThinkBubble, rsPointList };

enum DECLSPEC_DENUM TLMDRegionBorderStyle : unsigned char { rbNone, rbLowered, rbRaised, rbSingle, rbSingleRaised, rbSingleLowered, rbRaisedpsb, rbLoweredpsb };

typedef void __fastcall (__closure *TLMDBorderDrawEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect);

enum DECLSPEC_DENUM TLMDExtPos : unsigned char { epLeftTop, epTopLeft, epTopRight, epRightTop, epRightBottom, epBottomRight, epBottomLeft, epLeftBottom };

class PASCALIMPLEMENTATION TLMDRgnShadow : public Lmdshadow::TLMDShadow
{
	typedef Lmdshadow::TLMDShadow inherited;
	
public:
	__fastcall virtual TLMDRgnShadow(System::Classes::TPersistent* Owner);
	
__published:
	__property Style = {default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDRgnShadow(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRegionBorder : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	TLMDRegionBorderStyle FBorderStyle;
	System::Uitypes::TColor FUpColor;
	System::Uitypes::TColor FDnColor;
	System::Uitypes::TColor FSiColor;
	int FWidth;
	void __fastcall SetBorderStyle(TLMDRegionBorderStyle aValue);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetColor(int index, System::Uitypes::TColor aValue);
	
public:
	__fastcall virtual TLMDRegionBorder(System::Classes::TPersistent* Owner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TLMDRegionBorderStyle Style = {read=FBorderStyle, write=SetBorderStyle, default=3};
	__property int Width = {read=FWidth, write=SetWidth, default=2};
	__property System::Uitypes::TColor LightColor = {read=FUpColor, write=SetColor, index=0, default=-16777196};
	__property System::Uitypes::TColor ShadowColor = {read=FDnColor, write=SetColor, index=1, default=-16777200};
	__property System::Uitypes::TColor SingleColor = {read=FSiColor, write=SetColor, index=2, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDRegionBorder(void) { }
	
};


class PASCALIMPLEMENTATION TLMDRegion : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	TLMDRegionShape FShape;
	TLMDRegionBorder* FBorder;
	Lmdregionmask::TLMDRegionMask* FMask;
	int FBubbleCount;
	int FUserRgnDataSize;
	int FRoundX;
	int FRoundY;
	HRGN FNewHandle;
	HRGN FHandleInUse;
	Vcl::Controls::TWinControl* FOwner;
	_RGNDATA *FUserRgnData;
	TLMDExtPos FNosePos;
	TLMDRgnShadow* FShadow;
	System::Types::TPoint FOffsetRgn;
	bool FTurnOffShadow;
	Lmdpointlist::TLMDPointList* FPointList;
	void __fastcall SetRegionShape(TLMDRegionShape aValue);
	void __fastcall SetBorder(TLMDRegionBorder* aValue);
	void __fastcall SetMask(Lmdregionmask::TLMDRegionMask* aValue);
	void __fastcall SetInteger(int index, int aValue);
	void __fastcall SetShadow(TLMDRgnShadow* aValue);
	void __fastcall SetNosePos(TLMDExtPos aValue);
	void __fastcall GetPointListChange(System::TObject* Sender);
	void __fastcall WriteData(System::Classes::TWriter* Writer);
	void __fastcall ReadData(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TLMDRegion(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDRegion(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC void __fastcall CreateRegion(const System::Types::TRect &aRect);
	void __fastcall CreateSpecialRectRgn(const System::Types::TRect &aRect);
	void __fastcall SetRegion(void);
	void __fastcall DrawShadow(Vcl::Graphics::TCanvas* aCanvas, System::Types::TRect &aRect);
	void __fastcall FreeRegion(void);
	DYNAMIC void __fastcall PaintRegionShape(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect);
	void __fastcall SetUserRgn(HRGN aRGN);
	void __fastcall SetUserPolygonRgn(const System::Types::TPoint *points, const int points_High);
	__property HRGN CreatedHandle = {read=FNewHandle, nodefault};
	__property HRGN Handle = {read=FHandleInUse, nodefault};
	__property TLMDRegionBorder* Border = {read=FBorder, write=SetBorder};
	__property Vcl::Controls::TWinControl* Owner = {read=FOwner, write=FOwner};
	__property System::Types::TPoint OffsetRegion = {read=FOffsetRgn, write=FOffsetRgn};
	__property bool TurnOffShadow = {read=FTurnOffShadow, write=FTurnOffShadow, default=0};
	
__published:
	__property Lmdpointlist::TLMDPointList* Points = {read=FPointList, write=FPointList};
	__property TLMDRegionShape Shape = {read=FShape, write=SetRegionShape, default=1};
	__property TLMDExtPos ExtPos = {read=FNosePos, write=SetNosePos, default=0};
	__property Lmdregionmask::TLMDRegionMask* Mask = {read=FMask, write=SetMask};
	__property int RoundX = {read=FRoundX, write=SetInteger, index=0, default=20};
	__property int RoundY = {read=FRoundY, write=SetInteger, index=1, default=20};
	__property TLMDRgnShadow* Shadow = {read=FShadow, write=SetShadow};
};


class PASCALIMPLEMENTATION TLMDBorderRegion : public TLMDRegion
{
	typedef TLMDRegion inherited;
	
__published:
	__property Border;
public:
	/* TLMDRegion.Create */ inline __fastcall virtual TLMDBorderRegion(System::Classes::TPersistent* Owner) : TLMDRegion(Owner) { }
	/* TLMDRegion.Destroy */ inline __fastcall virtual ~TLMDBorderRegion(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE HRGN __fastcall LMDCreateDiamondRgn(const System::Types::TRect &aRect);
extern DELPHI_PACKAGE HRGN __fastcall LMDCreateStarRgn(const System::Types::TRect &aRect);
extern DELPHI_PACKAGE HRGN __fastcall LMDCreateOctagonRgn(const System::Types::TRect &aRect);
extern DELPHI_PACKAGE HRGN __fastcall LMDCreateCombRgn(const System::Types::TRect &aRect);
extern DELPHI_PACKAGE HRGN __fastcall LMDCreateRoundShieldRgn(const System::Types::TRect &aRect);
extern DELPHI_PACKAGE HRGN __fastcall LMDCreateSharpShieldRgn(const System::Types::TRect &aRect);
extern DELPHI_PACKAGE HRGN __fastcall LMDCreateNoseRectRgn(const System::Types::TRect &aRect, int ns, TLMDExtPos Pos);
extern DELPHI_PACKAGE HRGN __fastcall LMDCreateRoundNoseRectRgn(const System::Types::TRect &aRect, int ns, int xround, int yround, const TLMDExtPos Pos);
extern DELPHI_PACKAGE HRGN __fastcall LMDCreateThinkBubbleRgn(const System::Types::TRect &aRect, int bs, int bc, TLMDExtPos Pos);
extern DELPHI_PACKAGE HRGN __fastcall LMDCreateRoundThinkBubbleRgn(const System::Types::TRect &aRect, int bs, int bc, TLMDExtPos Pos, int roundx, int roundy);
extern DELPHI_PACKAGE HRGN __fastcall LMDCreateEllipticThinkBubbleRgn(const System::Types::TRect &aRect, int bs, int bc, TLMDExtPos Pos);
extern DELPHI_PACKAGE void __fastcall LMDFrameThinkBubbleRgn(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, int bs, int bc, TLMDExtPos Pos, System::Uitypes::TColor colorUp, System::Uitypes::TColor colorDn, System::Uitypes::TColor colorSi, TLMDRegionBorderStyle style, int AFrameWidth = 0x2);
extern DELPHI_PACKAGE void __fastcall LMDFrameRoundThinkBubbleRgn(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, int bs, int bc, TLMDExtPos Pos, int roundx, int roundy, System::Uitypes::TColor colorUp, System::Uitypes::TColor colorDn, System::Uitypes::TColor colorSi, TLMDRegionBorderStyle style, int AFrameWidth = 0x2);
extern DELPHI_PACKAGE void __fastcall LMDFrameEllipticThinkBubbleRgn(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, int bs, int bc, TLMDExtPos Pos, System::Uitypes::TColor colorUp, System::Uitypes::TColor colorDn, System::Uitypes::TColor colorSi, TLMDRegionBorderStyle style, int AFrameWidth = 0x2);
extern DELPHI_PACKAGE void __fastcall LMDFrameDiamondRgn(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, System::Uitypes::TColor colorUp, System::Uitypes::TColor colorDn, System::Uitypes::TColor colorSi, TLMDRegionBorderStyle style, int AFrameWidth = 0x2);
extern DELPHI_PACKAGE void __fastcall LMDFrameStarRgn(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, System::Uitypes::TColor colorUp, System::Uitypes::TColor colorDn, System::Uitypes::TColor colorSi, TLMDRegionBorderStyle style, int AFrameWidth = 0x2);
extern DELPHI_PACKAGE void __fastcall LMDFrameOctagonRgn(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, System::Uitypes::TColor colorUp, System::Uitypes::TColor colorDn, System::Uitypes::TColor colorSi, TLMDRegionBorderStyle style, int AFrameWidth = 0x2);
extern DELPHI_PACKAGE void __fastcall LMDFrameCombRgn(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, System::Uitypes::TColor colorUp, System::Uitypes::TColor colorDn, System::Uitypes::TColor colorSi, TLMDRegionBorderStyle style, int AFrameWidth = 0x2);
extern DELPHI_PACKAGE void __fastcall LMDFrameRoundShieldRgn(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, System::Uitypes::TColor colorUp, System::Uitypes::TColor colorDn, System::Uitypes::TColor colorSi, TLMDRegionBorderStyle style, int AFrameWidth = 0x2);
extern DELPHI_PACKAGE void __fastcall LMDFrameSharpShieldRgn(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, System::Uitypes::TColor colorUp, System::Uitypes::TColor colorDn, System::Uitypes::TColor colorSi, TLMDRegionBorderStyle style, int AFrameWidth = 0x2);
extern DELPHI_PACKAGE void __fastcall LMDFrameEllipticRgn(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, System::Uitypes::TColor colorUp, System::Uitypes::TColor colorDn, System::Uitypes::TColor colorSi, TLMDRegionBorderStyle style, int AFrameWidth = 0x2);
extern DELPHI_PACKAGE void __fastcall LMDFrameRoundRectRgn(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, System::Uitypes::TColor colorUp, System::Uitypes::TColor colorDn, System::Uitypes::TColor colorSi, TLMDRegionBorderStyle style, int RX, int RY, int AFrameWidth = 0x2);
extern DELPHI_PACKAGE void __fastcall LMDFrameHalfRoundRgn(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, System::Uitypes::TColor colorUp, System::Uitypes::TColor colorDn, System::Uitypes::TColor colorSi, TLMDRegionBorderStyle style, int AFrameWidth = 0x2);
extern DELPHI_PACKAGE void __fastcall LMDFrameRectRgn(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, System::Uitypes::TColor colorUp, System::Uitypes::TColor colorDn, System::Uitypes::TColor colorSi, TLMDRegionBorderStyle style, int AFrameWidth = 0x2);
}	/* namespace Lmdregion */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDREGION)
using namespace Lmdregion;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdregionHPP
