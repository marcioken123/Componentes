// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDGradientFrames.pas' rev: 31.00 (Windows)

#ifndef LmdgradientframesHPP
#define LmdgradientframesHPP

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
#include <LMDGraph.hpp>
#include <LMDFigures.hpp>
#include <LMDFillers.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdgradientframes
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDGradientFramePartBase;
class DELPHICLASS TLMDGradientRectFramePart;
class DELPHICLASS TLMDGradientCircleFramePart;
class DELPHICLASS TLMDBaseGradientFrame;
class DELPHICLASS TLMDGradientRectFrame;
class DELPHICLASS TLMDGradientCircleFrame;
class DELPHICLASS TLMDGradientComplexFrame;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDGradientSimpleFramePartKind : unsigned char { sfpOuterBorder, sfpInnerBorder, sfpInnerSpace };

typedef System::Set<TLMDGradientSimpleFramePartKind, TLMDGradientSimpleFramePartKind::sfpOuterBorder, TLMDGradientSimpleFramePartKind::sfpInnerSpace> TLMDGradientSimpleFramePartKinds;

enum DECLSPEC_DENUM TLMDGradientComplexFramePartKind : unsigned char { cfpTopLeftOuterCorner, cfpTopOuterBorder, cfpTopRightOuterCorner, cfpRightOuterBorder, cfpBottomRightOuterCorner, cfpBottomOuterBorder, cfpBottomLeftOuterCorner, cfpLeftOuterBorder, cfpTopLeftInnerCorner, cfpTopInnerBorder, cfpTopRightInnerCorner, cfpRightInnerBorder, cfpBottomRightInnerCorner, cfpBottomInnerBorder, cfpBottomLeftInnerCorner, cfpLeftInnerBorder, cfpSpace, cfpSpaceTopLeftInnerCorner, cfpSpaceTopRightInnerCorner, cfpSpaceBottomRightInnerCorner, cfpSpaceBottomLeftInnerCorner, cfpSpaceTopLeftOuterCorner, cfpSpaceTopRightOuterCorner, cfpSpaceBottomRightOuterCorner, cfpSpaceBottomLeftOuterCorner };

typedef System::Set<TLMDGradientComplexFramePartKind, TLMDGradientComplexFramePartKind::cfpTopLeftOuterCorner, TLMDGradientComplexFramePartKind::cfpSpaceBottomLeftOuterCorner> TLMDGradientComplexFramePartKinds;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGradientFramePartBase : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FWidth;
	int FEdgeWidth;
	System::Uitypes::TColor FEdgeColor;
	bool FAntiAliasing;
	bool FSoftEdge;
	Lmdfillers::TLMDFiller* FFiller;
	
public:
	__fastcall virtual TLMDGradientFramePartBase(void);
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property int EdgeWidth = {read=FEdgeWidth, write=FEdgeWidth, nodefault};
	__property System::Uitypes::TColor EdgeColor = {read=FEdgeColor, write=FEdgeColor, nodefault};
	__property bool AntiAliasing = {read=FAntiAliasing, write=FAntiAliasing, nodefault};
	__property bool SoftEdge = {read=FSoftEdge, write=FSoftEdge, nodefault};
	__property Lmdfillers::TLMDFiller* Filler = {read=FFiller, write=FFiller};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDGradientFramePartBase(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGradientRectFramePart : public TLMDGradientFramePartBase
{
	typedef TLMDGradientFramePartBase inherited;
	
private:
	int FInnerCutX;
	int FInnerCutY;
	int FOuterCutX;
	int FOuterCutY;
	Lmdgraph::TLMDValueType FInnerCutXValueType;
	Lmdgraph::TLMDValueType FInnerCutYValueType;
	Lmdgraph::TLMDValueType FOuterCutXValueType;
	Lmdgraph::TLMDValueType FOuterCutYValueType;
	
public:
	Lmdgraph::TLMDCornerCut OuterCutType;
	Lmdgraph::TLMDCornerCut InnerCutType;
	__fastcall virtual TLMDGradientRectFramePart(void);
	__property int InnerCutX = {read=FInnerCutX, write=FInnerCutX, nodefault};
	__property int InnerCutY = {read=FInnerCutY, write=FInnerCutY, nodefault};
	__property int OuterCutX = {read=FOuterCutX, write=FOuterCutX, nodefault};
	__property int OuterCutY = {read=FOuterCutY, write=FOuterCutY, nodefault};
	__property Lmdgraph::TLMDValueType InnerCutXValueType = {read=FInnerCutXValueType, write=FInnerCutXValueType, nodefault};
	__property Lmdgraph::TLMDValueType InnerCutYValueType = {read=FInnerCutYValueType, write=FInnerCutYValueType, nodefault};
	__property Lmdgraph::TLMDValueType OuterCutXValueType = {read=FOuterCutXValueType, write=FOuterCutXValueType, nodefault};
	__property Lmdgraph::TLMDValueType OuterCutYValueType = {read=FOuterCutYValueType, write=FOuterCutYValueType, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDGradientRectFramePart(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGradientCircleFramePart : public TLMDGradientFramePartBase
{
	typedef TLMDGradientFramePartBase inherited;
	
private:
	int FRadius;
	System::Types::TPoint FCenter;
	
public:
	__fastcall virtual TLMDGradientCircleFramePart(void);
	__property int Radius = {read=FRadius, write=FRadius, nodefault};
	__property System::Types::TPoint Center = {read=FCenter, write=FCenter};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDGradientCircleFramePart(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBaseGradientFrame : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDGradientFramePartBase* FOuterBorder;
	TLMDGradientFramePartBase* FInnerSpace;
	TLMDGradientFramePartBase* FInnerBorder;
	int FOuterBorderGap;
	int FInnerBorderGap;
	int FTopSpaceWidth;
	int FRightSpaceWidth;
	int FBottomSpaceWidth;
	int FLeftSpaceWidth;
	System::Types::TRect FOuterBorderRect;
	System::Types::TRect FInnerBorderRect;
	System::Uitypes::TColor FOuterBorderGapColor;
	System::Uitypes::TColor FInnerBorderGapColor;
	System::Types::TRect FContentsRect;
	System::Types::TRect FBoundsRect;
	Vcl::Graphics::TPixelFormat FUsePixelFormat;
	TLMDGradientSimpleFramePartKinds FVisibleParts;
	void __fastcall SetOuterBorderGap(const int Value);
	void __fastcall SetInnerBorderGap(const int Value);
	void __fastcall SetBottomSpaceWidth(const int Value);
	void __fastcall SetLeftSpaceWidth(const int Value);
	void __fastcall SetRightSpaceWidth(const int Value);
	void __fastcall SetTopSpaceWidth(const int Value);
	
protected:
	virtual void __fastcall SetContentsRect(const System::Types::TRect &Value);
	__property int TopSpaceWidth = {read=FTopSpaceWidth, write=SetTopSpaceWidth, nodefault};
	__property int RightSpaceWidth = {read=FRightSpaceWidth, write=SetRightSpaceWidth, nodefault};
	__property int BottomSpaceWidth = {read=FBottomSpaceWidth, write=SetBottomSpaceWidth, nodefault};
	__property int LeftSpaceWidth = {read=FLeftSpaceWidth, write=SetLeftSpaceWidth, nodefault};
	
public:
	__fastcall virtual TLMDBaseGradientFrame(void);
	__fastcall virtual ~TLMDBaseGradientFrame(void);
	virtual System::Types::TRect __fastcall CalcBoundsRect(const System::Types::TRect &aContentsRect, bool aCalcOuterBorderRect = true);
	virtual System::Types::TRect __fastcall CalcContentsRect(const System::Types::TRect &aBoundsRect);
	virtual System::Types::TRect __fastcall CalcInnerBorderRect(const System::Types::TRect &aContentsRect);
	virtual System::Types::TRect __fastcall CalcOuterBorderRect(const System::Types::TRect &aContentsRect, bool aCalcInnerBorderRect = true);
	virtual void __fastcall Draw(Vcl::Graphics::TBitmap* aTargetBmp, const System::Types::TRect &aDestRect, Vcl::Graphics::TPixelFormat aPixelFormat = (Vcl::Graphics::TPixelFormat)(0x6)) = 0 /* overload */;
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* aTargetCanvas, const System::Types::TRect &aDestRect, Vcl::Graphics::TPixelFormat aPixelFormat = (Vcl::Graphics::TPixelFormat)(0x6))/* overload */;
	virtual void __fastcall Draw(HDC aTargetDC, const System::Types::TRect &aDestRect, Vcl::Graphics::TPixelFormat aPixelFormat = (Vcl::Graphics::TPixelFormat)(0x6))/* overload */;
	virtual void __fastcall DrawOuterBorder(Vcl::Graphics::TBitmap* aTargetBmp, Lmdfillers::TLMDFiller* aFiller) = 0 ;
	virtual void __fastcall DrawInnerBorder(Vcl::Graphics::TBitmap* aTargetBmp, Lmdfillers::TLMDFiller* aFiller) = 0 ;
	virtual void __fastcall DrawInnerSpace(Vcl::Graphics::TBitmap* aTargetBmp, Lmdfillers::TLMDFiller* aFiller) = 0 ;
	__property System::Types::TRect OuterBorderRect = {read=FOuterBorderRect};
	__property System::Types::TRect InnerBorderRect = {read=FInnerBorderRect};
	__property System::Uitypes::TColor OuterBorderGapColor = {read=FOuterBorderGapColor, write=FOuterBorderGapColor, nodefault};
	__property System::Uitypes::TColor InnerBorderGapColor = {read=FInnerBorderGapColor, write=FInnerBorderGapColor, nodefault};
	__property System::Types::TRect ContentsRect = {read=FContentsRect, write=SetContentsRect};
	__property System::Types::TRect BoundsRect = {read=FBoundsRect};
	__property int OuterBorderGap = {read=FOuterBorderGap, write=SetOuterBorderGap, nodefault};
	__property int InnerBorderGap = {read=FInnerBorderGap, write=SetInnerBorderGap, nodefault};
	__property Vcl::Graphics::TPixelFormat UsePixelFormat = {read=FUsePixelFormat, write=FUsePixelFormat, nodefault};
	__property TLMDGradientSimpleFramePartKinds VisibleParts = {read=FVisibleParts, write=FVisibleParts, nodefault};
	__property TLMDGradientFramePartBase* OuterBorder = {read=FOuterBorder};
	__property TLMDGradientFramePartBase* InnerSpace = {read=FInnerSpace};
	__property TLMDGradientFramePartBase* InnerBorder = {read=FInnerBorder};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGradientRectFrame : public TLMDBaseGradientFrame
{
	typedef TLMDBaseGradientFrame inherited;
	
private:
	TLMDGradientSimpleFramePartKinds FVisibleParts;
	Lmdgraph::TLMDCutValueUsage FCutValueUsage;
	Lmdgraph::TLMDFrameSides FOuterBorderSides;
	Lmdgraph::TLMDFrameSides FInnerBorderSides;
	TLMDGradientRectFramePart* __fastcall GetInnerBorder(void);
	TLMDGradientRectFramePart* __fastcall GetInnerSpace(void);
	TLMDGradientRectFramePart* __fastcall GetOuterBorder(void);
	
protected:
	virtual void __fastcall DrawMainFigure(Vcl::Graphics::TBitmap* aTargetBmp, const System::Types::TRect &R1, const System::Types::TRect &R2, Lmdgraph::TLMDFrameSides aFrameSides, int aEdgeWidth, System::Uitypes::TColor aEdgeColor, Lmdgraph::TLMDCornerCut aOuterCornerCutType, Lmdgraph::TLMDCornerCut aInnerCornerCutType, int aCutX1, int aCutY1, int aCutX2, int aCutY2, Lmdgraph::TLMDValueType aCutXVType1, Lmdgraph::TLMDValueType aCutYVType1, Lmdgraph::TLMDValueType aCutXVType2, Lmdgraph::TLMDValueType aCutYVType2, Lmdfillers::TLMDFiller* aFiller, Vcl::Graphics::TPixelFormat aPixelFormat, bool aAntiAliasing = true, bool aSoftEdge = false);
	
public:
	__fastcall virtual TLMDGradientRectFrame(void);
	__fastcall virtual ~TLMDGradientRectFrame(void);
	virtual void __fastcall Draw(Vcl::Graphics::TBitmap* aTargetBmp, const System::Types::TRect &aDestRect, Vcl::Graphics::TPixelFormat aPixelFormat)/* overload */;
	virtual void __fastcall DrawOuterBorder(Vcl::Graphics::TBitmap* aTargetBmp, Lmdfillers::TLMDFiller* aFiller);
	virtual void __fastcall DrawInnerBorder(Vcl::Graphics::TBitmap* aTargetBmp, Lmdfillers::TLMDFiller* aFiller);
	virtual void __fastcall DrawInnerSpace(Vcl::Graphics::TBitmap* aTargetBmp, Lmdfillers::TLMDFiller* aFiller);
	__property TopSpaceWidth;
	__property RightSpaceWidth;
	__property BottomSpaceWidth;
	__property LeftSpaceWidth;
	__property Lmdgraph::TLMDCutValueUsage CutValueUsage = {read=FCutValueUsage, write=FCutValueUsage, default=1};
	__property TLMDGradientSimpleFramePartKinds VisibleParts = {read=FVisibleParts, write=FVisibleParts, nodefault};
	__property Lmdgraph::TLMDFrameSides OuterBorderSides = {read=FOuterBorderSides, write=FOuterBorderSides, nodefault};
	__property Lmdgraph::TLMDFrameSides InnerBorderSides = {read=FInnerBorderSides, write=FInnerBorderSides, nodefault};
	__property TLMDGradientRectFramePart* OuterBorder = {read=GetOuterBorder};
	__property TLMDGradientRectFramePart* InnerSpace = {read=GetInnerSpace};
	__property TLMDGradientRectFramePart* InnerBorder = {read=GetInnerBorder};
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Draw(Vcl::Graphics::TCanvas* aTargetCanvas, const System::Types::TRect &aDestRect, Vcl::Graphics::TPixelFormat aPixelFormat = (Vcl::Graphics::TPixelFormat)(0x6)){ TLMDBaseGradientFrame::Draw(aTargetCanvas, aDestRect, aPixelFormat); }
	inline void __fastcall  Draw(HDC aTargetDC, const System::Types::TRect &aDestRect, Vcl::Graphics::TPixelFormat aPixelFormat = (Vcl::Graphics::TPixelFormat)(0x6)){ TLMDBaseGradientFrame::Draw(aTargetDC, aDestRect, aPixelFormat); }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGradientCircleFrame : public TLMDBaseGradientFrame
{
	typedef TLMDBaseGradientFrame inherited;
	
private:
	int FContentsRadius;
	System::Types::TPoint FContentsCenter;
	TLMDGradientSimpleFramePartKinds FVisibleParts;
	int __fastcall GetSpaceWidth(void);
	void __fastcall SetSpaceWidth(const int Value);
	void __fastcall SetContentsRadius(const int Value);
	TLMDGradientCircleFramePart* __fastcall GetInnerBorder(void);
	TLMDGradientCircleFramePart* __fastcall GetInnerSpace(void);
	TLMDGradientCircleFramePart* __fastcall GetOuterBorder(void);
	
protected:
	virtual void __fastcall SetContentsRect(const System::Types::TRect &Value);
	virtual void __fastcall DrawMainFigure(Vcl::Graphics::TBitmap* aTargetBmp, const System::Types::TPoint &aCenter1, const System::Types::TPoint &aCenter2, int aRadius1, int aRadius2, int aEdgeWidth, System::Uitypes::TColor aEdgeColor, Lmdfillers::TLMDFiller* aFiller, Vcl::Graphics::TPixelFormat aPixelFormat, bool aAntiAliasing = true, bool aSoftEdge = false);
	
public:
	__fastcall virtual TLMDGradientCircleFrame(void);
	__fastcall virtual ~TLMDGradientCircleFrame(void);
	virtual System::Types::TRect __fastcall CalcBoundsRect(const System::Types::TRect &aContentsRect, bool aCalcOuterBorderRect = true);
	virtual void __fastcall Draw(Vcl::Graphics::TBitmap* aTargetBmp, const System::Types::TRect &aDestRect, Vcl::Graphics::TPixelFormat aPixelFormat = (Vcl::Graphics::TPixelFormat)(0x6))/* overload */;
	virtual void __fastcall DrawOuterBorder(Vcl::Graphics::TBitmap* aTargetBmp, Lmdfillers::TLMDFiller* aFiller);
	virtual void __fastcall DrawInnerBorder(Vcl::Graphics::TBitmap* aTargetBmp, Lmdfillers::TLMDFiller* aFiller);
	virtual void __fastcall DrawInnerSpace(Vcl::Graphics::TBitmap* aTargetBmp, Lmdfillers::TLMDFiller* aFiller);
	__property TLMDGradientSimpleFramePartKinds VisibleParts = {read=FVisibleParts, write=FVisibleParts, nodefault};
	__property int SpaceWidth = {read=GetSpaceWidth, write=SetSpaceWidth, nodefault};
	__property System::Types::TPoint ContentsCenter = {read=FContentsCenter};
	__property int ContentsRadius = {read=FContentsRadius, write=SetContentsRadius, nodefault};
	__property TLMDGradientCircleFramePart* OuterBorder = {read=GetOuterBorder};
	__property TLMDGradientCircleFramePart* InnerSpace = {read=GetInnerSpace};
	__property TLMDGradientCircleFramePart* InnerBorder = {read=GetInnerBorder};
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Draw(Vcl::Graphics::TCanvas* aTargetCanvas, const System::Types::TRect &aDestRect, Vcl::Graphics::TPixelFormat aPixelFormat = (Vcl::Graphics::TPixelFormat)(0x6)){ TLMDBaseGradientFrame::Draw(aTargetCanvas, aDestRect, aPixelFormat); }
	inline void __fastcall  Draw(HDC aTargetDC, const System::Types::TRect &aDestRect, Vcl::Graphics::TPixelFormat aPixelFormat = (Vcl::Graphics::TPixelFormat)(0x6)){ TLMDBaseGradientFrame::Draw(aTargetDC, aDestRect, aPixelFormat); }
	
};

#pragma pack(pop)

typedef bool __fastcall (*TLMDModifyGradientCFrameFillerFunc)(TLMDGradientComplexFramePartKind aFramePart, Lmdfillers::TLMDFiller* &aFiller);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGradientComplexFrame : public TLMDBaseGradientFrame
{
	typedef TLMDBaseGradientFrame inherited;
	
private:
	TLMDGradientComplexFramePartKinds FVisibleParts;
	System::StaticArray<Lmdgraph::TLMDCutType, 25> FCutType;
	TLMDModifyGradientCFrameFillerFunc FModifyFillerFunc;
	System::Uitypes::TColor FInnerSpaceOuterCornersColor;
	System::Byte FInnerSpaceOuterCornersAlpha;
	Lmdfillers::TLMDFiller* FOuterCornersFiller;
	Lmdfillers::TLMDFiller* FInnerCornersFiller;
	TLMDGradientRectFramePart* __fastcall GetInnerBorder(void);
	TLMDGradientRectFramePart* __fastcall GetInnerSpace(void);
	TLMDGradientRectFramePart* __fastcall GetOuterBorder(void);
	
protected:
	virtual bool __fastcall ModifyFiller(TLMDGradientComplexFramePartKind aFramePart, Lmdfillers::TLMDFiller* &aFiller);
	
public:
	__fastcall virtual TLMDGradientComplexFrame(void);
	virtual void __fastcall Draw(Vcl::Graphics::TBitmap* aTargetBmp, const System::Types::TRect &aDestRect, Vcl::Graphics::TPixelFormat aPixelFormat = (Vcl::Graphics::TPixelFormat)(0x6))/* overload */;
	virtual void __fastcall DrawOuterBorder(Vcl::Graphics::TBitmap* aTargetBmp, Lmdfillers::TLMDFiller* aFiller);
	virtual void __fastcall DrawInnerBorder(Vcl::Graphics::TBitmap* aTargetBmp, Lmdfillers::TLMDFiller* aFiller);
	virtual void __fastcall DrawOuterCorners(Vcl::Graphics::TBitmap* aTargetBmp, Lmdfillers::TLMDFiller* aFiller);
	virtual void __fastcall DrawInnerCorners(Vcl::Graphics::TBitmap* aTargetBmp, Lmdfillers::TLMDFiller* aFiller);
	virtual void __fastcall DrawInnerSpace(Vcl::Graphics::TBitmap* aTargetBmp, Lmdfillers::TLMDFiller* aFiller);
	__property TLMDModifyGradientCFrameFillerFunc ModifyFillerFunc = {read=FModifyFillerFunc, write=FModifyFillerFunc};
	__property Lmdfillers::TLMDFiller* OuterCornersFiller = {read=FOuterCornersFiller, write=FOuterCornersFiller};
	__property Lmdfillers::TLMDFiller* InnerCornersFiller = {read=FInnerCornersFiller, write=FInnerCornersFiller};
	__property TopSpaceWidth;
	__property RightSpaceWidth;
	__property BottomSpaceWidth;
	__property LeftSpaceWidth;
	__property TLMDGradientComplexFramePartKinds VisibleParts = {read=FVisibleParts, write=FVisibleParts, nodefault};
	__property TLMDGradientRectFramePart* OuterBorder = {read=GetOuterBorder};
	__property TLMDGradientRectFramePart* InnerSpace = {read=GetInnerSpace};
	__property TLMDGradientRectFramePart* InnerBorder = {read=GetInnerBorder};
public:
	/* TLMDBaseGradientFrame.Destroy */ inline __fastcall virtual ~TLMDGradientComplexFrame(void) { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Draw(Vcl::Graphics::TCanvas* aTargetCanvas, const System::Types::TRect &aDestRect, Vcl::Graphics::TPixelFormat aPixelFormat = (Vcl::Graphics::TPixelFormat)(0x6)){ TLMDBaseGradientFrame::Draw(aTargetCanvas, aDestRect, aPixelFormat); }
	inline void __fastcall  Draw(HDC aTargetDC, const System::Types::TRect &aDestRect, Vcl::Graphics::TPixelFormat aPixelFormat = (Vcl::Graphics::TPixelFormat)(0x6)){ TLMDBaseGradientFrame::Draw(aTargetDC, aDestRect, aPixelFormat); }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
#define cGradientSFrameAllParts (System::Set<TLMDGradientSimpleFramePartKind, TLMDGradientSimpleFramePartKind::sfpOuterBorder, TLMDGradientSimpleFramePartKind::sfpInnerSpace>() << TLMDGradientSimpleFramePartKind::sfpOuterBorder << TLMDGradientSimpleFramePartKind::sfpInnerBorder << TLMDGradientSimpleFramePartKind::sfpInnerSpace )
#define cGradientCFrameAllParts (System::Set<TLMDGradientComplexFramePartKind, TLMDGradientComplexFramePartKind::cfpTopLeftOuterCorner, TLMDGradientComplexFramePartKind::cfpSpaceBottomLeftOuterCorner>() << TLMDGradientComplexFramePartKind::cfpTopLeftOuterCorner << TLMDGradientComplexFramePartKind::cfpTopOuterBorder << TLMDGradientComplexFramePartKind::cfpTopRightOuterCorner << TLMDGradientComplexFramePartKind::cfpRightOuterBorder << TLMDGradientComplexFramePartKind::cfpBottomRightOuterCorner << TLMDGradientComplexFramePartKind::cfpBottomOuterBorder << TLMDGradientComplexFramePartKind::cfpBottomLeftOuterCorner << TLMDGradientComplexFramePartKind::cfpLeftOuterBorder << TLMDGradientComplexFramePartKind::cfpTopLeftInnerCorner << TLMDGradientComplexFramePartKind::cfpTopInnerBorder \
	<< TLMDGradientComplexFramePartKind::cfpTopRightInnerCorner << TLMDGradientComplexFramePartKind::cfpRightInnerBorder << TLMDGradientComplexFramePartKind::cfpBottomRightInnerCorner << TLMDGradientComplexFramePartKind::cfpBottomInnerBorder << TLMDGradientComplexFramePartKind::cfpBottomLeftInnerCorner << TLMDGradientComplexFramePartKind::cfpLeftInnerBorder << TLMDGradientComplexFramePartKind::cfpSpace << TLMDGradientComplexFramePartKind::cfpSpaceTopLeftInnerCorner << TLMDGradientComplexFramePartKind::cfpSpaceTopRightInnerCorner << TLMDGradientComplexFramePartKind::cfpSpaceBottomRightInnerCorner << TLMDGradientComplexFramePartKind::cfpSpaceBottomLeftInnerCorner << TLMDGradientComplexFramePartKind::cfpSpaceTopLeftOuterCorner << TLMDGradientComplexFramePartKind::cfpSpaceTopRightOuterCorner \
	<< TLMDGradientComplexFramePartKind::cfpSpaceBottomRightOuterCorner << TLMDGradientComplexFramePartKind::cfpSpaceBottomLeftOuterCorner )
#define cGradientCFrameOuterBorders (System::Set<TLMDGradientComplexFramePartKind, TLMDGradientComplexFramePartKind::cfpTopLeftOuterCorner, TLMDGradientComplexFramePartKind::cfpSpaceBottomLeftOuterCorner>() << TLMDGradientComplexFramePartKind::cfpTopOuterBorder << TLMDGradientComplexFramePartKind::cfpRightOuterBorder << TLMDGradientComplexFramePartKind::cfpBottomOuterBorder << TLMDGradientComplexFramePartKind::cfpLeftOuterBorder )
#define GradientCFrameOuterCorners (System::Set<TLMDGradientComplexFramePartKind, TLMDGradientComplexFramePartKind::cfpTopLeftOuterCorner, TLMDGradientComplexFramePartKind::cfpSpaceBottomLeftOuterCorner>() << TLMDGradientComplexFramePartKind::cfpTopLeftOuterCorner << TLMDGradientComplexFramePartKind::cfpTopRightOuterCorner << TLMDGradientComplexFramePartKind::cfpBottomRightOuterCorner << TLMDGradientComplexFramePartKind::cfpBottomLeftOuterCorner )
#define cGradientCFrameInnerBorders (System::Set<TLMDGradientComplexFramePartKind, TLMDGradientComplexFramePartKind::cfpTopLeftOuterCorner, TLMDGradientComplexFramePartKind::cfpSpaceBottomLeftOuterCorner>() << TLMDGradientComplexFramePartKind::cfpTopInnerBorder << TLMDGradientComplexFramePartKind::cfpRightInnerBorder << TLMDGradientComplexFramePartKind::cfpBottomInnerBorder << TLMDGradientComplexFramePartKind::cfpLeftInnerBorder )
#define cGradientCFrameInnerCorners (System::Set<TLMDGradientComplexFramePartKind, TLMDGradientComplexFramePartKind::cfpTopLeftOuterCorner, TLMDGradientComplexFramePartKind::cfpSpaceBottomLeftOuterCorner>() << TLMDGradientComplexFramePartKind::cfpTopLeftInnerCorner << TLMDGradientComplexFramePartKind::cfpTopRightInnerCorner << TLMDGradientComplexFramePartKind::cfpBottomRightInnerCorner << TLMDGradientComplexFramePartKind::cfpBottomLeftInnerCorner )
#define cGradientCompositeFramSpaceInnerCorners (System::Set<TLMDGradientComplexFramePartKind, TLMDGradientComplexFramePartKind::cfpTopLeftOuterCorner, TLMDGradientComplexFramePartKind::cfpSpaceBottomLeftOuterCorner>() << TLMDGradientComplexFramePartKind::cfpSpaceTopLeftInnerCorner << TLMDGradientComplexFramePartKind::cfpSpaceTopRightInnerCorner << TLMDGradientComplexFramePartKind::cfpSpaceBottomRightInnerCorner << TLMDGradientComplexFramePartKind::cfpSpaceBottomLeftInnerCorner )
#define cGradientCFrameSpaceOuterCorners (System::Set<TLMDGradientComplexFramePartKind, TLMDGradientComplexFramePartKind::cfpTopLeftOuterCorner, TLMDGradientComplexFramePartKind::cfpSpaceBottomLeftOuterCorner>() << TLMDGradientComplexFramePartKind::cfpSpaceTopLeftOuterCorner << TLMDGradientComplexFramePartKind::cfpSpaceTopRightOuterCorner << TLMDGradientComplexFramePartKind::cfpSpaceBottomRightOuterCorner << TLMDGradientComplexFramePartKind::cfpSpaceBottomLeftOuterCorner )
#define cGradientCFrameSpace (System::Set<TLMDGradientComplexFramePartKind, TLMDGradientComplexFramePartKind::cfpTopLeftOuterCorner, TLMDGradientComplexFramePartKind::cfpSpaceBottomLeftOuterCorner>() << TLMDGradientComplexFramePartKind::cfpSpace << TLMDGradientComplexFramePartKind::cfpSpaceTopLeftInnerCorner << TLMDGradientComplexFramePartKind::cfpSpaceTopRightInnerCorner << TLMDGradientComplexFramePartKind::cfpSpaceBottomRightInnerCorner << TLMDGradientComplexFramePartKind::cfpSpaceBottomLeftInnerCorner << TLMDGradientComplexFramePartKind::cfpSpaceTopLeftOuterCorner << TLMDGradientComplexFramePartKind::cfpSpaceTopRightOuterCorner << TLMDGradientComplexFramePartKind::cfpSpaceBottomRightOuterCorner << TLMDGradientComplexFramePartKind::cfpSpaceBottomLeftOuterCorner )
}	/* namespace Lmdgradientframes */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDGRADIENTFRAMES)
using namespace Lmdgradientframes;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdgradientframesHPP
