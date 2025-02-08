// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDckStyleElems.pas' rev: 31.00 (Windows)

#ifndef LmddckstyleelemsHPP
#define LmddckstyleelemsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <Vcl.Graphics.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.GraphUtil.hpp>
#include <System.StrUtils.hpp>
#include <System.Math.hpp>
#include <Vcl.Controls.hpp>
#include <intfLMDBase.hpp>
#include <LMDUnicode.hpp>
#include <LMDTypes.hpp>
#include <LMDXML.hpp>
#include <LMDDckClass.hpp>
#include <LMDDckCst.hpp>
#include <LMDDckStyles.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddckstyleelems
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSiteBackElem;
class DELPHICLASS TLMDPinAreaBase;
class DELPHICLASS TLMDLeftPinAreaElem;
class DELPHICLASS TLMDTopPinAreaElem;
class DELPHICLASS TLMDRightPinAreaElem;
class DELPHICLASS TLMDBottomPinAreaElem;
class DELPHICLASS TLMDPinPanelBase;
class DELPHICLASS TLMDLeftPinPanelElem;
class DELPHICLASS TLMDTopPinPanelElem;
class DELPHICLASS TLMDRightPinPanelElem;
class DELPHICLASS TLMDBottomPinPanelElem;
class DELPHICLASS TLMDSeqZoneBase;
class DELPHICLASS TLMDHorzZoneElem;
class DELPHICLASS TLMDVertZoneElem;
struct TLMDTabedAreaPart;
struct TLMDTabedAreaColor;
class DELPHICLASS TLMDTabedAreaBase;
class DELPHICLASS TLMDTabedAreaBtnBase;
class DELPHICLASS TLMDTabZoneElem;
class DELPHICLASS TLMDTabZoneButtonElem;
class DELPHICLASS TLMDDocsZoneElem;
class DELPHICLASS TLMDDocsZoneButtonElem;
class DELPHICLASS TLMDPanelZoneElem;
class DELPHICLASS TLMDEmptyZoneElem;
struct TLMDButtonsData;
class DELPHICLASS TLMDFrameBtnBase;
class DELPHICLASS TLMDPanelButtonElem;
class DELPHICLASS TLMDPanelElem;
class DELPHICLASS TLMDFloatFrameBase;
class DELPHICLASS TLMDCaptionFrameBase;
class DELPHICLASS TLMDPanelFormElem;
class DELPHICLASS TLMDGroupFormButtonElem;
class DELPHICLASS TLMDGroupFormElem;
class DELPHICLASS TLMDDocFormButtonElem;
class DELPHICLASS TLMDDocFormElem;
class DELPHICLASS TLMDHotspotBase;
class DELPHICLASS TLMDSideHotspotBase;
class DELPHICLASS TLMDLeftHotspotElem;
class DELPHICLASS TLMDTopHotspotElem;
class DELPHICLASS TLMDRightHotspotElem;
class DELPHICLASS TLMDBottomHotspotElem;
class DELPHICLASS TLMDCrossHotspotBase;
class DELPHICLASS TLMDSmallCrossElem;
class DELPHICLASS TLMDBigCrossElem;
class DELPHICLASS TLMDDockElems;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDPanelBtnKind : unsigned char { pbMenu, pbPin, pbMaximize, pbClose };

typedef System::Set<TLMDPanelBtnKind, TLMDPanelBtnKind::pbMenu, TLMDPanelBtnKind::pbClose> TLMDPanelBtnKinds;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSiteBackElem : public Lmddckstyles::TLMDStyleElem
{
	typedef Lmddckstyles::TLMDStyleElem inherited;
	
private:
	bool FDragContent;
	bool FAnimateDragRect;
	bool FAnimateHotSpots;
	
public:
	__fastcall virtual TLMDSiteBackElem(Lmddckstyles::TLMDDockStyle* AStyle);
	Lmddckstyles::TLMDElemState* __fastcall GetBack(bool AIsFloating, bool AIdDoc);
	void __fastcall GetAreas(const System::Types::TRect &R, bool AIsFloating, bool AIdDoc, /* out */ System::Types::TRect &AContent);
	
__published:
	__property Lmddckstyles::TLMDElemState* Normal = {read=GetState, index=0};
	__property Lmddckstyles::TLMDMargins* NormalContent = {read=GetMargins, index=0};
	__property Lmddckstyles::TLMDElemState* Floating = {read=GetState, index=1};
	__property Lmddckstyles::TLMDMargins* FloatingContent = {read=GetMargins, index=1};
	__property Lmddckstyles::TLMDElemState* Doc = {read=GetState, index=2};
	__property Lmddckstyles::TLMDMargins* DocContent = {read=GetMargins, index=2};
	__property bool DragContent = {read=FDragContent, write=FDragContent, nodefault};
	__property bool AnimateDragRect = {read=FAnimateDragRect, write=FAnimateDragRect, nodefault};
	__property bool AnimateHotSpots = {read=FAnimateHotSpots, write=FAnimateHotSpots, nodefault};
	__property System::Uitypes::TColor DragRectBack = {read=GetColor, write=SetColor, index=0, nodefault};
	__property System::Uitypes::TColor DragRectBorder = {read=GetColor, write=SetColor, index=1, nodefault};
public:
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDSiteBackElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPinAreaBase : public Lmddckstyles::TLMDStyleElem
{
	typedef Lmddckstyles::TLMDStyleElem inherited;
	
private:
	Vcl::Controls::TAlign FSide;
	int FSpacerSize;
	bool FShowTabImage;
	
protected:
	__property int SpacerWidth = {read=FSpacerSize, write=FSpacerSize, nodefault};
	__property int SpacerHeight = {read=FSpacerSize, write=FSpacerSize, nodefault};
	
public:
	int __fastcall GetSize(Vcl::Graphics::TFont* AFont);
	int __fastcall GetSpacerSize(void);
	Lmddckstyles::TLMDElemState* __fastcall GetTab(bool AIsHot);
	System::Uitypes::TColor __fastcall GetTextColor(bool AIsHot);
	
__published:
	__property Lmddckstyles::TLMDElemState* Background = {read=GetState, index=0};
	__property Lmddckstyles::TLMDMargins* Content = {read=GetMargins, index=0};
	__property Lmddckstyles::TLMDElemState* NormalTab = {read=GetState, index=1};
	__property System::Uitypes::TColor NormalTextColor = {read=GetColor, write=SetColor, index=0, nodefault};
	__property Lmddckstyles::TLMDElemState* HotTab = {read=GetState, index=2};
	__property System::Uitypes::TColor HotTextColor = {read=GetColor, write=SetColor, index=1, nodefault};
	__property Lmddckstyles::TLMDMargins* TabContent = {read=GetMargins, index=1};
	__property bool ShowTabImage = {read=FShowTabImage, write=FShowTabImage, nodefault};
	__property Lmddckstyles::TLMDElemState* Spacer = {read=GetState, index=3};
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDPinAreaBase(Lmddckstyles::TLMDDockStyle* AStyle) : Lmddckstyles::TLMDStyleElem(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDPinAreaBase(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLeftPinAreaElem : public TLMDPinAreaBase
{
	typedef TLMDPinAreaBase inherited;
	
__published:
	__property SpacerHeight;
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDLeftPinAreaElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDPinAreaBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDLeftPinAreaElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTopPinAreaElem : public TLMDPinAreaBase
{
	typedef TLMDPinAreaBase inherited;
	
__published:
	__property SpacerWidth;
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDTopPinAreaElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDPinAreaBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDTopPinAreaElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRightPinAreaElem : public TLMDPinAreaBase
{
	typedef TLMDPinAreaBase inherited;
	
__published:
	__property SpacerHeight;
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDRightPinAreaElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDPinAreaBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDRightPinAreaElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBottomPinAreaElem : public TLMDPinAreaBase
{
	typedef TLMDPinAreaBase inherited;
	
__published:
	__property SpacerWidth;
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDBottomPinAreaElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDPinAreaBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDBottomPinAreaElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPinPanelBase : public Lmddckstyles::TLMDStyleElem
{
	typedef Lmddckstyles::TLMDStyleElem inherited;
	
private:
	int FSplitterSize;
	Vcl::Controls::TAlign FSide;
	
protected:
	__property int SplitterWidth = {read=FSplitterSize, write=FSplitterSize, nodefault};
	__property int SplitterHeight = {read=FSplitterSize, write=FSplitterSize, nodefault};
	
public:
	void __fastcall GetAreas(const System::Types::TRect &R, /* out */ System::Types::TRect &ASplitter, /* out */ System::Types::TRect &AContent);
	
__published:
	__property Lmddckstyles::TLMDElemState* Background = {read=GetState, index=0};
	__property Lmddckstyles::TLMDElemState* Splitter = {read=GetState, index=1};
	__property Lmddckstyles::TLMDMargins* Content = {read=GetMargins, index=0};
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDPinPanelBase(Lmddckstyles::TLMDDockStyle* AStyle) : Lmddckstyles::TLMDStyleElem(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDPinPanelBase(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLeftPinPanelElem : public TLMDPinPanelBase
{
	typedef TLMDPinPanelBase inherited;
	
__published:
	__property SplitterWidth;
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDLeftPinPanelElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDPinPanelBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDLeftPinPanelElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTopPinPanelElem : public TLMDPinPanelBase
{
	typedef TLMDPinPanelBase inherited;
	
__published:
	__property SplitterHeight;
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDTopPinPanelElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDPinPanelBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDTopPinPanelElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRightPinPanelElem : public TLMDPinPanelBase
{
	typedef TLMDPinPanelBase inherited;
	
__published:
	__property SplitterWidth;
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDRightPinPanelElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDPinPanelBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDRightPinPanelElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBottomPinPanelElem : public TLMDPinPanelBase
{
	typedef TLMDPinPanelBase inherited;
	
__published:
	__property SplitterHeight;
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDBottomPinPanelElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDPinPanelBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDBottomPinPanelElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSeqZoneBase : public Lmddckstyles::TLMDStyleElem
{
	typedef Lmddckstyles::TLMDStyleElem inherited;
	
private:
	int FSplitterSize;
	
protected:
	__property int SplitterWidth = {read=FSplitterSize, write=FSplitterSize, nodefault};
	__property int SplitterHeight = {read=FSplitterSize, write=FSplitterSize, nodefault};
	
public:
	int __fastcall GetSplitterSize(void);
	
__published:
	__property Lmddckstyles::TLMDElemState* Background = {read=GetState, index=0};
	__property Lmddckstyles::TLMDMargins* Content = {read=GetMargins, index=0};
	__property Lmddckstyles::TLMDElemState* Splitter = {read=GetState, index=1};
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDSeqZoneBase(Lmddckstyles::TLMDDockStyle* AStyle) : Lmddckstyles::TLMDStyleElem(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDSeqZoneBase(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHorzZoneElem : public TLMDSeqZoneBase
{
	typedef TLMDSeqZoneBase inherited;
	
__published:
	__property SplitterWidth;
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDHorzZoneElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDSeqZoneBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDHorzZoneElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVertZoneElem : public TLMDSeqZoneBase
{
	typedef TLMDSeqZoneBase inherited;
	
__published:
	__property SplitterHeight;
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDVertZoneElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDSeqZoneBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDVertZoneElem(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDZoneTabState : unsigned char { ztsNormal, ztsSelected, ztsHot };

struct DECLSPEC_DRECORD TLMDTabedAreaPart
{
	
private:
	enum DECLSPEC_DENUM _TLMDTabedAreaPart__1 : unsigned char { tapBack, tapTabArea, tapTab, tapSpacer };
	
	
public:
	bool IsActive;
	_TLMDTabedAreaPart__1 Part;
	TLMDZoneTabState TabState;
};


struct DECLSPEC_DRECORD TLMDTabedAreaColor
{
public:
	bool IsActive;
	TLMDZoneTabState TabState;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTabedAreaBase : public Lmddckstyles::TLMDStyleElem
{
	typedef Lmddckstyles::TLMDStyleElem inherited;
	
private:
	int FSpacerWidth;
	bool FShowTabImage;
	
protected:
	virtual Lmddckstyles::TLMDElemState* __fastcall GetPart(const TLMDTabedAreaPart P) = 0 ;
	virtual System::Uitypes::TColor __fastcall GetClr(const TLMDTabedAreaColor C) = 0 ;
	virtual bool __fastcall TabsAtTop(void) = 0 ;
	
public:
	Lmddckstyles::TLMDElemState* __fastcall GetBack(bool AIsActive);
	Lmddckstyles::TLMDElemState* __fastcall GetTabArea(bool AIsActive);
	Lmddckstyles::TLMDElemState* __fastcall GetTab(bool AIsActive, TLMDZoneTabState AState);
	System::Uitypes::TColor __fastcall GetTextColor(bool AIsActive, TLMDZoneTabState AState);
	Lmddckstyles::TLMDElemState* __fastcall GetSpacer(bool AIsActive);
	void __fastcall GetAreas(const System::Types::TRect &R, Vcl::Graphics::TFont* AFont, /* out */ System::Types::TRect &AContent, /* out */ System::Types::TRect &ATabArea);
	
__published:
	__property Lmddckstyles::TLMDMargins* Content = {read=GetMargins, index=0};
	__property Lmddckstyles::TLMDMargins* ContentClip = {read=GetMargins, index=1};
	__property Lmddckstyles::TLMDMargins* TabAreaContent = {read=GetMargins, index=2};
	__property Lmddckstyles::TLMDMargins* TabContent = {read=GetMargins, index=3};
	__property bool ShowTabImage = {read=FShowTabImage, write=FShowTabImage, nodefault};
	__property Lmddckstyles::TLMDMargins* SelectedMargins = {read=GetMargins, index=4};
	__property int SpacerWidth = {read=FSpacerWidth, write=FSpacerWidth, nodefault};
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDTabedAreaBase(Lmddckstyles::TLMDDockStyle* AStyle) : Lmddckstyles::TLMDStyleElem(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDTabedAreaBase(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDTabBtnKind : unsigned char { tbClose, tbLeft, tbRight, tbMenu };

typedef System::Set<TLMDTabBtnKind, TLMDTabBtnKind::tbClose, TLMDTabBtnKind::tbMenu> TLMDTabBtnKinds;

typedef System::StaticArray<System::Types::TRect, 4> TLMDTabBtnAreas;

enum DECLSPEC_DENUM Lmddckstyleelems__61 : unsigned char { tbsAreaActive, tbsTabSelected, tbsTabHot, tbsHot, tbsHotDown };

typedef System::Set<Lmddckstyleelems__61, Lmddckstyleelems__61::tbsAreaActive, Lmddckstyleelems__61::tbsHotDown> TLMDTabedAreaBtnState;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTabedAreaBtnBase : public Lmddckstyles::TLMDStyleElem
{
	typedef Lmddckstyles::TLMDStyleElem inherited;
	
private:
	int FWidth;
	int FHeight;
	bool FShowClose;
	System::Types::TRect __fastcall DoGetArea(const System::Types::TRect &AParent, int AWidth, int AHeight, Lmddckstyles::TLMDMargins* AMargins)/* overload */;
	System::Types::TRect __fastcall DoGetArea(const System::Types::TRect &AParent, Lmddckstyles::TLMDMargins* AMargins)/* overload */;
	
public:
	virtual TLMDTabBtnKinds __fastcall ShowButtons(void) = 0 ;
	virtual void __fastcall GetCloseArea(const System::Types::TRect &AParent, /* out */ System::Types::TRect &AButton) = 0 ;
	virtual void __fastcall GetGroupAreas(const System::Types::TRect &AParent, TLMDTabBtnKinds AKinds, /* out */ TLMDTabBtnAreas &AButtons, /* out */ System::Types::TRect &AGroup) = 0 ;
	virtual Lmddckstyles::TLMDElemState* __fastcall GetStates(TLMDTabBtnKind AKind, TLMDTabedAreaBtnState AState) = 0 ;
	
__published:
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
	__property bool ShowClose = {read=FShowClose, write=FShowClose, nodefault};
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDTabedAreaBtnBase(Lmddckstyles::TLMDDockStyle* AStyle) : Lmddckstyles::TLMDStyleElem(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDTabedAreaBtnBase(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTabZoneElem : public TLMDTabedAreaBase
{
	typedef TLMDTabedAreaBase inherited;
	
protected:
	virtual Lmddckstyles::TLMDElemState* __fastcall GetPart(const TLMDTabedAreaPart P);
	virtual System::Uitypes::TColor __fastcall GetClr(const TLMDTabedAreaColor C);
	virtual bool __fastcall TabsAtTop(void);
	
__published:
	__property Lmddckstyles::TLMDElemState* Background = {read=GetState, index=0};
	__property Lmddckstyles::TLMDElemState* TabArea = {read=GetState, index=1};
	__property Lmddckstyles::TLMDElemState* NormalTab = {read=GetState, index=2};
	__property System::Uitypes::TColor NormalTextColor = {read=GetColor, write=SetColor, index=0, nodefault};
	__property Lmddckstyles::TLMDElemState* HotTab = {read=GetState, index=3};
	__property System::Uitypes::TColor HotTextColor = {read=GetColor, write=SetColor, index=1, nodefault};
	__property Lmddckstyles::TLMDElemState* SelectedTab = {read=GetState, index=4};
	__property System::Uitypes::TColor SelectedTextColor = {read=GetColor, write=SetColor, index=2, nodefault};
	__property Lmddckstyles::TLMDElemState* Spacer = {read=GetState, index=5};
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDTabZoneElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDTabedAreaBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDTabZoneElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTabZoneButtonElem : public TLMDTabedAreaBtnBase
{
	typedef TLMDTabedAreaBtnBase inherited;
	
public:
	virtual TLMDTabBtnKinds __fastcall ShowButtons(void);
	virtual void __fastcall GetCloseArea(const System::Types::TRect &AParent, /* out */ System::Types::TRect &AButton);
	virtual void __fastcall GetGroupAreas(const System::Types::TRect &AParent, TLMDTabBtnKinds AKinds, /* out */ TLMDTabBtnAreas &AButtons, /* out */ System::Types::TRect &AGroup);
	virtual Lmddckstyles::TLMDElemState* __fastcall GetStates(TLMDTabBtnKind AKind, TLMDTabedAreaBtnState AState);
	
__published:
	__property Lmddckstyles::TLMDElemState* NormalClose = {read=GetState, index=0};
	__property Lmddckstyles::TLMDElemState* SelectedClose = {read=GetState, index=1};
	__property Lmddckstyles::TLMDElemState* TabHotClose = {read=GetState, index=2};
	__property Lmddckstyles::TLMDElemState* HotClose = {read=GetState, index=3};
	__property Lmddckstyles::TLMDElemState* DownClose = {read=GetState, index=4};
	__property Lmddckstyles::TLMDMargins* CloseMargins = {read=GetMargins, index=0};
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDTabZoneButtonElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDTabedAreaBtnBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDTabZoneButtonElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDocsZoneElem : public TLMDTabedAreaBase
{
	typedef TLMDTabedAreaBase inherited;
	
protected:
	virtual Lmddckstyles::TLMDElemState* __fastcall GetPart(const TLMDTabedAreaPart P);
	virtual System::Uitypes::TColor __fastcall GetClr(const TLMDTabedAreaColor C);
	virtual bool __fastcall TabsAtTop(void);
	
__published:
	__property Lmddckstyles::TLMDElemState* InactiveBack = {read=GetState, index=0};
	__property Lmddckstyles::TLMDElemState* ActiveBack = {read=GetState, index=1};
	__property Lmddckstyles::TLMDElemState* InactiveTabArea = {read=GetState, index=2};
	__property Lmddckstyles::TLMDElemState* ActiveTabArea = {read=GetState, index=3};
	__property Lmddckstyles::TLMDElemState* NormalTab = {read=GetState, index=4};
	__property System::Uitypes::TColor NormalTextColor = {read=GetColor, write=SetColor, index=0, nodefault};
	__property Lmddckstyles::TLMDElemState* HotTab = {read=GetState, index=5};
	__property System::Uitypes::TColor HotTextColor = {read=GetColor, write=SetColor, index=1, nodefault};
	__property Lmddckstyles::TLMDElemState* InactiveSelectedTab = {read=GetState, index=6};
	__property System::Uitypes::TColor InactiveSelectedTextColor = {read=GetColor, write=SetColor, index=2, nodefault};
	__property Lmddckstyles::TLMDElemState* ActiveSelectedTab = {read=GetState, index=7};
	__property System::Uitypes::TColor ActiveSelectedTextColor = {read=GetColor, write=SetColor, index=3, nodefault};
	__property Lmddckstyles::TLMDElemState* Spacer = {read=GetState, index=8};
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDDocsZoneElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDTabedAreaBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDDocsZoneElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDocsZoneButtonElem : public TLMDTabedAreaBtnBase
{
	typedef TLMDTabedAreaBtnBase inherited;
	
public:
	virtual TLMDTabBtnKinds __fastcall ShowButtons(void);
	virtual void __fastcall GetCloseArea(const System::Types::TRect &AParent, /* out */ System::Types::TRect &AButton);
	virtual void __fastcall GetGroupAreas(const System::Types::TRect &AParent, TLMDTabBtnKinds AKinds, /* out */ TLMDTabBtnAreas &AButtons, /* out */ System::Types::TRect &AGroup);
	virtual Lmddckstyles::TLMDElemState* __fastcall GetStates(TLMDTabBtnKind AKind, TLMDTabedAreaBtnState AState);
	
__published:
	__property Lmddckstyles::TLMDElemState* InactiveClose = {read=GetState, index=0};
	__property Lmddckstyles::TLMDElemState* InactiveSelectedClose = {read=GetState, index=1};
	__property Lmddckstyles::TLMDElemState* ActiveClose = {read=GetState, index=2};
	__property Lmddckstyles::TLMDElemState* ActiveSelectedClose = {read=GetState, index=3};
	__property Lmddckstyles::TLMDElemState* TabHotClose = {read=GetState, index=4};
	__property Lmddckstyles::TLMDElemState* HotClose = {read=GetState, index=5};
	__property Lmddckstyles::TLMDElemState* DownClose = {read=GetState, index=6};
	__property Lmddckstyles::TLMDMargins* CloseMargins = {read=GetMargins, index=0};
	__property Lmddckstyles::TLMDElemState* InactiveLeft = {read=GetState, index=7};
	__property Lmddckstyles::TLMDElemState* ActiveLeft = {read=GetState, index=8};
	__property Lmddckstyles::TLMDElemState* HotLeft = {read=GetState, index=9};
	__property Lmddckstyles::TLMDElemState* DownLeft = {read=GetState, index=10};
	__property Lmddckstyles::TLMDElemState* InactiveRight = {read=GetState, index=11};
	__property Lmddckstyles::TLMDElemState* ActiveRight = {read=GetState, index=12};
	__property Lmddckstyles::TLMDElemState* HotRight = {read=GetState, index=13};
	__property Lmddckstyles::TLMDElemState* DownRight = {read=GetState, index=14};
	__property Lmddckstyles::TLMDElemState* InactiveMenu = {read=GetState, index=15};
	__property Lmddckstyles::TLMDElemState* ActiveMenu = {read=GetState, index=16};
	__property Lmddckstyles::TLMDElemState* HotMenu = {read=GetState, index=17};
	__property Lmddckstyles::TLMDElemState* DownMenu = {read=GetState, index=18};
	__property Lmddckstyles::TLMDMargins* GroupContent = {read=GetMargins, index=1};
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDDocsZoneButtonElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDTabedAreaBtnBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDDocsZoneButtonElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPanelZoneElem : public Lmddckstyles::TLMDStyleElem
{
	typedef Lmddckstyles::TLMDStyleElem inherited;
	
__published:
	__property Lmddckstyles::TLMDElemState* Background = {read=GetState, index=0};
	__property Lmddckstyles::TLMDMargins* Content = {read=GetMargins, index=0};
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDPanelZoneElem(Lmddckstyles::TLMDDockStyle* AStyle) : Lmddckstyles::TLMDStyleElem(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDPanelZoneElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEmptyZoneElem : public Lmddckstyles::TLMDStyleElem
{
	typedef Lmddckstyles::TLMDStyleElem inherited;
	
__published:
	__property Lmddckstyles::TLMDElemState* Background = {read=GetState, index=0};
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDEmptyZoneElem(Lmddckstyles::TLMDDockStyle* AStyle) : Lmddckstyles::TLMDStyleElem(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDEmptyZoneElem(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDVertAlign : unsigned char { vaTop, vaCenter, vaBottom };

enum DECLSPEC_DENUM Lmddckstyleelems__42 : unsigned char { fbsActive, fbsPinned, fbsMaximized };

typedef System::Set<Lmddckstyleelems__42, Lmddckstyleelems__42::fbsActive, Lmddckstyleelems__42::fbsMaximized> TLMDFrameBtnState;

struct DECLSPEC_DRECORD TLMDButtonsData
{
public:
	TLMDPanelBtnKinds Kinds;
	System::Types::TRect Group;
	System::StaticArray<System::Types::TRect, 4> Buttons;
	System::StaticArray<System::Types::TRect, 4> Spacers;
	TLMDPanelBtnKind Hot;
	bool HotDown;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFrameBtnBase : public Lmddckstyles::TLMDStyleElem
{
	typedef Lmddckstyles::TLMDStyleElem inherited;
	
private:
	int FWidth;
	int FHeight;
	int FSpacerWidth;
	TLMDVertAlign FGroupVertAlign;
	
public:
	void __fastcall GetAreas(const System::Types::TRect &AParent, TLMDPanelBtnKinds AKinds, TLMDButtonsData &AData);
	Lmddckstyles::TLMDElemState* __fastcall GetStates(TLMDPanelBtnKind AKind, const TLMDButtonsData &AData, TLMDFrameBtnState AState);
	void __fastcall Draw(Vcl::Graphics::TCanvas* ACanvas, const TLMDButtonsData &AData, TLMDFrameBtnState AState);
	
__published:
	__property Lmddckstyles::TLMDElemState* GroupBack = {read=GetState, index=0};
	__property TLMDVertAlign GroupVertAlign = {read=FGroupVertAlign, write=FGroupVertAlign, nodefault};
	__property Lmddckstyles::TLMDMargins* GroupContent = {read=GetMargins, index=0};
	__property Lmddckstyles::TLMDElemState* InactiveMenu = {read=GetState, index=1};
	__property Lmddckstyles::TLMDElemState* ActiveMenu = {read=GetState, index=2};
	__property Lmddckstyles::TLMDElemState* HotMenu = {read=GetState, index=3};
	__property Lmddckstyles::TLMDElemState* DownMenu = {read=GetState, index=4};
	__property Lmddckstyles::TLMDElemState* InactivePin = {read=GetState, index=5};
	__property Lmddckstyles::TLMDElemState* ActivePin = {read=GetState, index=6};
	__property Lmddckstyles::TLMDElemState* HotPin = {read=GetState, index=7};
	__property Lmddckstyles::TLMDElemState* DownPin = {read=GetState, index=8};
	__property Lmddckstyles::TLMDElemState* InactiveUnpin = {read=GetState, index=9};
	__property Lmddckstyles::TLMDElemState* ActiveUnpin = {read=GetState, index=10};
	__property Lmddckstyles::TLMDElemState* HotUnpin = {read=GetState, index=11};
	__property Lmddckstyles::TLMDElemState* DownUnpin = {read=GetState, index=12};
	__property Lmddckstyles::TLMDElemState* InactiveMaximize = {read=GetState, index=13};
	__property Lmddckstyles::TLMDElemState* ActiveMaximize = {read=GetState, index=14};
	__property Lmddckstyles::TLMDElemState* HotMaximize = {read=GetState, index=15};
	__property Lmddckstyles::TLMDElemState* DownMaximize = {read=GetState, index=16};
	__property Lmddckstyles::TLMDElemState* InactiveRestore = {read=GetState, index=17};
	__property Lmddckstyles::TLMDElemState* ActiveRestore = {read=GetState, index=18};
	__property Lmddckstyles::TLMDElemState* HotRestore = {read=GetState, index=19};
	__property Lmddckstyles::TLMDElemState* DownRestore = {read=GetState, index=20};
	__property Lmddckstyles::TLMDElemState* InactiveClose = {read=GetState, index=21};
	__property Lmddckstyles::TLMDElemState* ActiveClose = {read=GetState, index=22};
	__property Lmddckstyles::TLMDElemState* HotClose = {read=GetState, index=23};
	__property Lmddckstyles::TLMDElemState* DownClose = {read=GetState, index=24};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
	__property Lmddckstyles::TLMDMargins* Margins = {read=GetMargins, index=1};
	__property Lmddckstyles::TLMDElemState* Spacer = {read=GetState, index=25};
	__property int SpacerWidth = {read=FSpacerWidth, write=FSpacerWidth, nodefault};
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDFrameBtnBase(Lmddckstyles::TLMDDockStyle* AStyle) : Lmddckstyles::TLMDStyleElem(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDFrameBtnBase(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPanelButtonElem : public TLMDFrameBtnBase
{
	typedef TLMDFrameBtnBase inherited;
	
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDPanelButtonElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDFrameBtnBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDPanelButtonElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPanelElem : public Lmddckstyles::TLMDStyleElem
{
	typedef Lmddckstyles::TLMDStyleElem inherited;
	
private:
	bool FShowHeaderImage;
	
public:
	void __fastcall GetAreas(const System::Types::TRect &R, bool AShowCaption, Vcl::Graphics::TFont* AFont, /* out */ System::Types::TRect &ACaption, /* out */ System::Types::TRect &AContent);
	Lmddckstyles::TLMDElemState* __fastcall GetCaption(bool AIsActive);
	System::Uitypes::TColor __fastcall GetTextColor(bool AIsActive);
	Lmddckstyles::TLMDElemState* __fastcall GetFiller(bool AIsActive);
	
__published:
	__property Lmddckstyles::TLMDElemState* InactiveCaption = {read=GetState, index=0};
	__property System::Uitypes::TColor InactiveTextColor = {read=GetColor, write=SetColor, index=0, nodefault};
	__property Lmddckstyles::TLMDElemState* InactiveFiller = {read=GetState, index=1};
	__property Lmddckstyles::TLMDElemState* ActiveCaption = {read=GetState, index=2};
	__property System::Uitypes::TColor ActiveTextColor = {read=GetColor, write=SetColor, index=1, nodefault};
	__property Lmddckstyles::TLMDElemState* ActiveFiller = {read=GetState, index=3};
	__property Lmddckstyles::TLMDMargins* CaptionContent = {read=GetMargins, index=0};
	__property Lmddckstyles::TLMDMargins* FillerMargins = {read=GetMargins, index=1};
	__property bool ShowHeaderImage = {read=FShowHeaderImage, write=FShowHeaderImage, nodefault};
	__property System::Uitypes::TColor DefaultColor = {read=GetColor, write=SetColor, index=2, nodefault};
	__property System::Uitypes::TColor DefaultFontColor = {read=GetColor, write=SetColor, index=3, nodefault};
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDPanelElem(Lmddckstyles::TLMDDockStyle* AStyle) : Lmddckstyles::TLMDStyleElem(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDPanelElem(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDFloatBorderKind : unsigned char { fbNormal, fbTool, fbCustom };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFloatFrameBase : public Lmddckstyles::TLMDStyleElem
{
	typedef Lmddckstyles::TLMDStyleElem inherited;
	
private:
	bool FShowHeaderImage;
	TLMDFloatBorderKind FBorderKind;
	
public:
	virtual bool __fastcall HasCaption(void);
	void __fastcall GetAreas(const System::Types::TRect &R, Vcl::Graphics::TFont* AFont, /* out */ System::Types::TRect &ACaption, /* out */ System::Types::TRect &AFrameContent);
	Lmddckstyles::TLMDElemState* __fastcall GetFrame(bool AIsActive);
	Lmddckstyles::TLMDElemState* __fastcall GetGlow(bool AIsActive);
	Lmddckstyles::TLMDElemState* __fastcall GetCaption(bool AIsActive);
	System::Uitypes::TColor __fastcall GetTextColor(bool AIsActive);
	Lmddckstyles::TLMDElemState* __fastcall GetFiller(bool AIsActive);
	
protected:
	__property Lmddckstyles::TLMDMargins* CaptionMargins = {read=GetMargins, index=0};
	__property Lmddckstyles::TLMDElemState* InactiveCaption = {read=GetState, index=0};
	__property System::Uitypes::TColor InactiveTextColor = {read=GetColor, write=SetColor, index=0, nodefault};
	__property Lmddckstyles::TLMDElemState* InactiveFiller = {read=GetState, index=1};
	__property Lmddckstyles::TLMDElemState* ActiveCaption = {read=GetState, index=2};
	__property System::Uitypes::TColor ActiveTextColor = {read=GetColor, write=SetColor, index=1, nodefault};
	__property Lmddckstyles::TLMDElemState* ActiveFiller = {read=GetState, index=3};
	__property Lmddckstyles::TLMDMargins* CaptionContent = {read=GetMargins, index=1};
	__property Lmddckstyles::TLMDMargins* FillerMargins = {read=GetMargins, index=2};
	__property bool ShowHeaderImage = {read=FShowHeaderImage, write=FShowHeaderImage, nodefault};
	
__published:
	__property Lmddckstyles::TLMDElemState* InactiveFrame = {read=GetState, index=4};
	__property Lmddckstyles::TLMDElemState* ActiveFrame = {read=GetState, index=5};
	__property Lmddckstyles::TLMDMargins* FrameContent = {read=GetMargins, index=3};
	__property Lmddckstyles::TLMDElemState* InactiveGlow = {read=GetState, index=6};
	__property Lmddckstyles::TLMDElemState* ActiveGlow = {read=GetState, index=7};
	__property Lmddckstyles::TLMDMargins* GlowContent = {read=GetMargins, index=4};
	__property TLMDFloatBorderKind BorderKind = {read=FBorderKind, write=FBorderKind, nodefault};
	__property Lmddckstyles::TLMDElemState* WindowRegion = {read=GetState, index=8};
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDFloatFrameBase(Lmddckstyles::TLMDDockStyle* AStyle) : Lmddckstyles::TLMDStyleElem(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDFloatFrameBase(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCaptionFrameBase : public TLMDFloatFrameBase
{
	typedef TLMDFloatFrameBase inherited;
	
public:
	virtual bool __fastcall HasCaption(void);
	
__published:
	__property CaptionMargins;
	__property InactiveCaption;
	__property InactiveTextColor;
	__property InactiveFiller;
	__property ActiveCaption;
	__property ActiveTextColor;
	__property ActiveFiller;
	__property CaptionContent;
	__property FillerMargins;
	__property ShowHeaderImage;
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDCaptionFrameBase(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDFloatFrameBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDCaptionFrameBase(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPanelFormElem : public TLMDFloatFrameBase
{
	typedef TLMDFloatFrameBase inherited;
	
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDPanelFormElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDFloatFrameBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDPanelFormElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGroupFormButtonElem : public TLMDFrameBtnBase
{
	typedef TLMDFrameBtnBase inherited;
	
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDGroupFormButtonElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDFrameBtnBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDGroupFormButtonElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGroupFormElem : public TLMDCaptionFrameBase
{
	typedef TLMDCaptionFrameBase inherited;
	
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDGroupFormElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDCaptionFrameBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDGroupFormElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDocFormButtonElem : public TLMDFrameBtnBase
{
	typedef TLMDFrameBtnBase inherited;
	
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDDocFormButtonElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDFrameBtnBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDDocFormButtonElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDocFormElem : public TLMDCaptionFrameBase
{
	typedef TLMDCaptionFrameBase inherited;
	
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDDocFormElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDCaptionFrameBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDDocFormElem(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDHotSpotKind : unsigned char { hsLeft, hsTop, hsRight, hsBottom, hsCenter };

typedef System::Set<TLMDHotSpotKind, TLMDHotSpotKind::hsLeft, TLMDHotSpotKind::hsCenter> TLMDHotSpotKinds;

enum DECLSPEC_DENUM TLMDActiveArea : unsigned char { hsaSiteLeft, hsaSiteTop, hsaSiteRight, hsaSiteBottom, hsaZoneLeft, hsaZoneTop, hsaZoneRight, hsaZoneBottom, hsaDocsLeft, hsaDocsTop, hsaDocsRight, hsaDocsBottom, hsaTabs, hsaSplitters, hsaTabAreas };

typedef System::Set<TLMDActiveArea, TLMDActiveArea::hsaSiteLeft, TLMDActiveArea::hsaTabAreas> TLMDActiveAreas;

typedef System::StaticArray<System::Types::TRect, 13> TLMDHotSpotLayout;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHotspotBase : public Lmddckstyles::TLMDStyleElem
{
	typedef Lmddckstyles::TLMDStyleElem inherited;
	
private:
	int FWidth;
	int FHeight;
	
public:
	virtual void __fastcall GetAreas(/* out */ TLMDHotSpotLayout &ALayout) = 0 ;
	virtual bool __fastcall GetActiveArea(bool AEnabled, TLMDActiveArea AArea, /* out */ Lmddckstyles::TLMDElemState* &AState) = 0 ;
	
__published:
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
	__property Lmddckstyles::TLMDElemState* Background = {read=GetState, index=0};
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDHotspotBase(Lmddckstyles::TLMDDockStyle* AStyle) : Lmddckstyles::TLMDStyleElem(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDHotspotBase(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSideHotspotBase : public TLMDHotspotBase
{
	typedef TLMDHotspotBase inherited;
	
private:
	Vcl::Controls::TAlign FSide;
	void __fastcall InitSide(void);
	
public:
	virtual void __fastcall GetAreas(/* out */ TLMDHotSpotLayout &ALayout);
	virtual bool __fastcall GetActiveArea(bool AEnabled, TLMDActiveArea AArea, /* out */ Lmddckstyles::TLMDElemState* &AState);
	
__published:
	__property Lmddckstyles::TLMDElemState* Enabled = {read=GetState, index=1};
	__property Lmddckstyles::TLMDElemState* Disabled = {read=GetState, index=2};
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDSideHotspotBase(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDHotspotBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDSideHotspotBase(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLeftHotspotElem : public TLMDSideHotspotBase
{
	typedef TLMDSideHotspotBase inherited;
	
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDLeftHotspotElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDSideHotspotBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDLeftHotspotElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTopHotspotElem : public TLMDSideHotspotBase
{
	typedef TLMDSideHotspotBase inherited;
	
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDTopHotspotElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDSideHotspotBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDTopHotspotElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRightHotspotElem : public TLMDSideHotspotBase
{
	typedef TLMDSideHotspotBase inherited;
	
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDRightHotspotElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDSideHotspotBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDRightHotspotElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBottomHotspotElem : public TLMDSideHotspotBase
{
	typedef TLMDSideHotspotBase inherited;
	
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDBottomHotspotElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDSideHotspotBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDBottomHotspotElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCrossHotspotBase : public TLMDHotspotBase
{
	typedef TLMDHotspotBase inherited;
	
public:
	virtual void __fastcall GetAreas(/* out */ TLMDHotSpotLayout &ALayout);
	virtual bool __fastcall GetActiveArea(bool AEnabled, TLMDActiveArea AArea, /* out */ Lmddckstyles::TLMDElemState* &AState);
	
__published:
	__property Lmddckstyles::TLMDElemState* EnabledLeft = {read=GetState, index=1};
	__property Lmddckstyles::TLMDElemState* DisabledLeft = {read=GetState, index=2};
	__property Lmddckstyles::TLMDMargins* LeftMargins = {read=GetMargins, index=0};
	__property Lmddckstyles::TLMDElemState* EnabledTop = {read=GetState, index=3};
	__property Lmddckstyles::TLMDElemState* DisabledTop = {read=GetState, index=4};
	__property Lmddckstyles::TLMDMargins* TopMargins = {read=GetMargins, index=1};
	__property Lmddckstyles::TLMDElemState* EnabledRight = {read=GetState, index=5};
	__property Lmddckstyles::TLMDElemState* DisabledRight = {read=GetState, index=6};
	__property Lmddckstyles::TLMDMargins* RightMargins = {read=GetMargins, index=2};
	__property Lmddckstyles::TLMDElemState* EnabledBottom = {read=GetState, index=7};
	__property Lmddckstyles::TLMDElemState* DisabledBottom = {read=GetState, index=8};
	__property Lmddckstyles::TLMDMargins* BottomMargins = {read=GetMargins, index=3};
	__property Lmddckstyles::TLMDElemState* EnabledLeftDoc = {read=GetState, index=9};
	__property Lmddckstyles::TLMDElemState* DisabledLeftDoc = {read=GetState, index=10};
	__property Lmddckstyles::TLMDMargins* LeftDocMargins = {read=GetMargins, index=4};
	__property Lmddckstyles::TLMDElemState* EnabledTopDoc = {read=GetState, index=11};
	__property Lmddckstyles::TLMDElemState* DisabledTopDoc = {read=GetState, index=12};
	__property Lmddckstyles::TLMDMargins* TopDocMargins = {read=GetMargins, index=5};
	__property Lmddckstyles::TLMDElemState* EnabledRightDoc = {read=GetState, index=13};
	__property Lmddckstyles::TLMDElemState* DisabledRightDoc = {read=GetState, index=14};
	__property Lmddckstyles::TLMDMargins* RightDocMargins = {read=GetMargins, index=6};
	__property Lmddckstyles::TLMDElemState* EnabledBottomDoc = {read=GetState, index=15};
	__property Lmddckstyles::TLMDElemState* DisabledBottomDoc = {read=GetState, index=16};
	__property Lmddckstyles::TLMDMargins* BottomDocMargins = {read=GetMargins, index=7};
	__property Lmddckstyles::TLMDElemState* EnabledTabs = {read=GetState, index=17};
	__property Lmddckstyles::TLMDElemState* DisabledTabs = {read=GetState, index=18};
	__property Lmddckstyles::TLMDMargins* TabsMargins = {read=GetMargins, index=8};
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDCrossHotspotBase(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDHotspotBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDCrossHotspotBase(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSmallCrossElem : public TLMDCrossHotspotBase
{
	typedef TLMDCrossHotspotBase inherited;
	
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDSmallCrossElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDCrossHotspotBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDSmallCrossElem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBigCrossElem : public TLMDCrossHotspotBase
{
	typedef TLMDCrossHotspotBase inherited;
	
public:
	/* TLMDStyleElem.Create */ inline __fastcall virtual TLMDBigCrossElem(Lmddckstyles::TLMDDockStyle* AStyle) : TLMDCrossHotspotBase(AStyle) { }
	/* TLMDStyleElem.Destroy */ inline __fastcall virtual ~TLMDBigCrossElem(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDFloatFormKind : unsigned char { ffPanel, ffGroup, ffDoc };

class PASCALIMPLEMENTATION TLMDDockElems : public Lmddckstyles::TLMDElemSet
{
	typedef Lmddckstyles::TLMDElemSet inherited;
	
private:
	TLMDSiteBackElem* FSiteBack;
	TLMDPanelElem* FPanel;
	TLMDPanelButtonElem* FPanelButton;
	TLMDBottomPinAreaElem* FBottomPinArea;
	TLMDTopPinAreaElem* FTopPinArea;
	TLMDLeftPinAreaElem* FLeftPinArea;
	TLMDRightPinAreaElem* FRightPinArea;
	TLMDBottomPinPanelElem* FBottomPinPanel;
	TLMDTopPinPanelElem* FTopPinPanel;
	TLMDLeftPinPanelElem* FLeftPinPanel;
	TLMDRightPinPanelElem* FRightPinPanel;
	TLMDVertZoneElem* FVertZone;
	TLMDHorzZoneElem* FHorzZone;
	TLMDTabZoneElem* FTabZone;
	TLMDTabZoneButtonElem* FTabZoneButton;
	TLMDDocsZoneElem* FDocsZone;
	TLMDDocsZoneButtonElem* FDocsZoneButton;
	TLMDPanelZoneElem* FPanelZone;
	TLMDEmptyZoneElem* FEmptyZone;
	TLMDDocFormElem* FDocForm;
	TLMDPanelFormElem* FPanelForm;
	TLMDGroupFormElem* FGroupForm;
	TLMDGroupFormButtonElem* FGroupFormButton;
	TLMDDocFormButtonElem* FDocFormButton;
	TLMDBottomHotspotElem* FBottomHotspot;
	TLMDSmallCrossElem* FSmallCross;
	TLMDBigCrossElem* FBigCross;
	TLMDTopHotspotElem* FTopHotspot;
	TLMDLeftHotspotElem* FLeftHotspot;
	TLMDRightHotspotElem* FRightHotspot;
	void __fastcall SetSiteBack(TLMDSiteBackElem* const Value);
	
public:
	TLMDPinAreaBase* __fastcall GetPinArea(Vcl::Controls::TAlign ASide);
	TLMDPinPanelBase* __fastcall GetPinPanel(Vcl::Controls::TAlign ASide);
	TLMDSeqZoneBase* __fastcall GetSeqZone(bool AIsVert);
	TLMDTabedAreaBase* __fastcall GetTabedArea(bool AIsDocHost);
	TLMDTabedAreaBtnBase* __fastcall GetTabedAreaButton(bool AIsDocHost);
	TLMDHotspotBase* __fastcall GetHotSpot(TLMDHotSpotKind AKind, bool ANeedBigCross);
	TLMDFloatFrameBase* __fastcall GetForm(TLMDFloatFormKind AKind);
	TLMDFrameBtnBase* __fastcall GetFormButton(TLMDFloatFormKind AKind);
	
__published:
	__property TLMDSiteBackElem* SiteBack = {read=FSiteBack, write=SetSiteBack};
	__property TLMDLeftPinAreaElem* LeftPinArea = {read=FLeftPinArea, write=FLeftPinArea};
	__property TLMDTopPinAreaElem* TopPinArea = {read=FTopPinArea, write=FTopPinArea};
	__property TLMDRightPinAreaElem* RightPinArea = {read=FRightPinArea, write=FRightPinArea};
	__property TLMDBottomPinAreaElem* BottomPinArea = {read=FBottomPinArea, write=FBottomPinArea};
	__property TLMDLeftPinPanelElem* LeftPinPanel = {read=FLeftPinPanel, write=FLeftPinPanel};
	__property TLMDTopPinPanelElem* TopPinPanel = {read=FTopPinPanel, write=FTopPinPanel};
	__property TLMDRightPinPanelElem* RightPinPanel = {read=FRightPinPanel, write=FRightPinPanel};
	__property TLMDBottomPinPanelElem* BottomPinPanel = {read=FBottomPinPanel, write=FBottomPinPanel};
	__property TLMDHorzZoneElem* HorzZone = {read=FHorzZone, write=FHorzZone};
	__property TLMDVertZoneElem* VertZone = {read=FVertZone, write=FVertZone};
	__property TLMDTabZoneElem* TabZone = {read=FTabZone, write=FTabZone};
	__property TLMDTabZoneButtonElem* TabZoneButton = {read=FTabZoneButton, write=FTabZoneButton};
	__property TLMDDocsZoneElem* DocsZone = {read=FDocsZone, write=FDocsZone};
	__property TLMDDocsZoneButtonElem* DocsZoneButton = {read=FDocsZoneButton, write=FDocsZoneButton};
	__property TLMDPanelZoneElem* PanelZone = {read=FPanelZone, write=FPanelZone};
	__property TLMDEmptyZoneElem* EmptyZone = {read=FEmptyZone, write=FEmptyZone};
	__property TLMDPanelElem* Panel = {read=FPanel, write=FPanel};
	__property TLMDPanelButtonElem* PanelButton = {read=FPanelButton, write=FPanelButton};
	__property TLMDPanelFormElem* PanelForm = {read=FPanelForm, write=FPanelForm};
	__property TLMDGroupFormElem* GroupForm = {read=FGroupForm, write=FGroupForm};
	__property TLMDGroupFormButtonElem* GroupFormButton = {read=FGroupFormButton, write=FGroupFormButton};
	__property TLMDDocFormElem* DocForm = {read=FDocForm, write=FDocForm};
	__property TLMDDocFormButtonElem* DocFormButton = {read=FDocFormButton, write=FDocFormButton};
	__property TLMDLeftHotspotElem* LeftHotspot = {read=FLeftHotspot, write=FLeftHotspot};
	__property TLMDTopHotspotElem* TopHotspot = {read=FTopHotspot, write=FTopHotspot};
	__property TLMDRightHotspotElem* RightHotspot = {read=FRightHotspot, write=FRightHotspot};
	__property TLMDBottomHotspotElem* BottomHotspot = {read=FBottomHotspot, write=FBottomHotspot};
	__property TLMDSmallCrossElem* SmallCross = {read=FSmallCross, write=FSmallCross};
	__property TLMDBigCrossElem* BigCross = {read=FBigCross, write=FBigCross};
public:
	/* TLMDElemSet.Create */ inline __fastcall TLMDDockElems(void)/* overload */ : Lmddckstyles::TLMDElemSet() { }
	/* TLMDElemSet.Create */ inline __fastcall TLMDDockElems(Lmddckstyles::TLMDDockStyle* AStyle)/* overload */ : Lmddckstyles::TLMDElemSet(AStyle) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDDockElems(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const TLMDPanelBtnKind pbNone = (TLMDPanelBtnKind)(255);
static const TLMDTabBtnKind tbNone = (TLMDTabBtnKind)(255);
static const TLMDActiveArea hsaNone = (TLMDActiveArea)(255);
}	/* namespace Lmddckstyleelems */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDCKSTYLEELEMS)
using namespace Lmddckstyleelems;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddckstyleelemsHPP
