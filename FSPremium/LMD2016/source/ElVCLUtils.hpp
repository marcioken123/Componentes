// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElVCLUtils.pas' rev: 31.00 (Windows)

#ifndef ElvclutilsHPP
#define ElvclutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDTypes.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.MultiMon.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <System.Win.Registry.hpp>
#include <System.Math.hpp>
#include <Vcl.Clipbrd.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDUtils.hpp>
#include <LMDInprocHookAPI.hpp>
#include <LMDGraph.hpp>
#include <LMDSysIn.hpp>
#include <LMDProcs.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elvclutils
{
//-- forward type declarations -----------------------------------------------
struct TBlendFunction;
class DELPHICLASS TElReader;
class DELPHICLASS TElDisplayOptions;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TBlendFunction
{
public:
	System::Byte BlendOp;
	System::Byte BlendFlags;
	System::Byte SourceConstantAlpha;
	System::Byte AlphaFormat;
};


typedef _GRADIENT_RECT *PGradientRect;

typedef _GRADIENT_RECT TGradientRect;

typedef System::LongBool __stdcall (*TAlphaBlend)(HDC hdcDest, int nXOriginDest, int nYOriginDest, int nWidthDest, int nHeightDest, HDC hdcSrc, int nXOriginSrc, int nYOriginSrc, int nWidthSrc, int nHeightSrc, int blendFunction);

enum DECLSPEC_DENUM TElLinkCtlPos : unsigned char { lcpLeftTop, lcpLeftBottom, lcpLeftCenter, lcpTopLeft, lcpTopRight, lcpTopCenter, lcpRightTop, lcpRightBottom, lcpRightCenter, lcpBottomLeft, lcpBottomRight, lcpBottomCenter };

enum DECLSPEC_DENUM TElFlatBorderType : unsigned char { fbtFlat, fbtSunken, fbtSunkenInner, fbtSunkenOuter, fbtRaised, fbtRaisedInner, fbtRaisedOuter, fbtBump, fbtBigBump, fbtEtched, fbtFramed, fbtLine, fbtLineBorder, fbtNone, fbtColorLineBorder };

typedef Lmdgraph::TLMDTextDrawType TElTextDrawType;

enum DECLSPEC_DENUM TTaskbarEdge : unsigned char { tbeBottom, tbeLeft, tbeTop, tbeRight };

enum DECLSPEC_DENUM TElTextCase : unsigned char { etcNoChange, etcUppercase, etcLowercase };

enum DECLSPEC_DENUM TElGradientEdge : unsigned char { egeTopLeft, egeTopRight, egeBottomLeft, egeBottomRight };

typedef void * PtrToPixel;

class PASCALIMPLEMENTATION TElReader : public System::Classes::TReader
{
	typedef System::Classes::TReader inherited;
	
public:
	void __fastcall ReadPropertyFix(System::Classes::TPersistent* AInstance);
	void __fastcall FakeDefineProperty(System::Classes::TFiler* Filer);
	HIDESBASE void __fastcall SkipValue(void);
	void __fastcall FakeValue(System::Classes::TReader* Reader);
	void __fastcall FakeInteger(System::Classes::TReader* Reader);
	void __fastcall FakeBoolean(System::Classes::TReader* Reader);
	void __fastcall FakeStr(System::Classes::TReader* Reader);
	void __fastcall FakeIdent(System::Classes::TReader* Reader);
public:
	/* TReader.Destroy */ inline __fastcall virtual ~TElReader(void) { }
	
public:
	/* TFiler.Create */ inline __fastcall TElReader(System::Classes::TStream* Stream, int BufSize) : System::Classes::TReader(Stream, BufSize) { }
	
};


class PASCALIMPLEMENTATION TElDisplayOptions : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FEnabled;
	System::Uitypes::TColor FTextColor;
	System::Uitypes::TColor FBkColor;
	System::Classes::TNotifyEvent FOnChange;
	
protected:
	virtual void __fastcall Changed(void);
	virtual void __fastcall TriggerOnChange(void);
	virtual void __fastcall SetBkColor(const System::Uitypes::TColor Value);
	virtual void __fastcall SetEnabled(const bool Value);
	virtual void __fastcall SetTextColor(const System::Uitypes::TColor Value);
	
public:
	__fastcall TElDisplayOptions(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
	__property System::Uitypes::TColor BkColor = {read=FBkColor, write=SetBkColor, default=-16777211};
	__property System::Uitypes::TColor TextColor = {read=FTextColor, write=SetTextColor, default=-16777208};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TElDisplayOptions(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 MOUSE_WHEEL_DELTA = System::Int8(0x78);
static const System::Word WM_UPDATESBFRAME = System::Word(0x912);
static const System::Word EL_SETTINGCHANGE = System::Word(0x913);
static const System::Word SC_DRAGMOVE = System::Word(0xf012);
static const int DT_ELCUSTOMDRAW = int(0x10000000);
extern DELPHI_PACKAGE unsigned ParentControlRepaintedMessage;
extern DELPHI_PACKAGE Lmdgraph::TLMDBorderSides AllBorderSides;
extern DELPHI_PACKAGE System::StaticArray<unsigned, 2> smXEdge;
extern DELPHI_PACKAGE System::StaticArray<unsigned, 2> smYEdge;
extern DELPHI_PACKAGE System::Uitypes::TCursor WaitCursor;
extern DELPHI_PACKAGE System::WideChar __fastcall GetTimeAMChar(void);
extern DELPHI_PACKAGE System::WideChar __fastcall GetTimePMChar(void);
extern DELPHI_PACKAGE void __fastcall RotateBitmap(Vcl::Graphics::TBitmap* const ASource, /* out */ Vcl::Graphics::TBitmap* &ADest, double AAngle)/* overload */;
extern DELPHI_PACKAGE void __fastcall RotateBitmap(Vcl::Graphics::TBitmap* const ASource, /* out */ Vcl::Graphics::TBitmap* &ADest, double AAngle, const System::Types::TPoint &AOldCenter, System::Types::TPoint &ANewCenter)/* overload */;
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall ColorLighter(const System::Uitypes::TColor Color, const System::Byte Percent);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall ColorDarker(const System::Uitypes::TColor OriginalColor, const System::Byte Percent);
extern DELPHI_PACKAGE int __fastcall IncColor(const System::Uitypes::TColor Color, int RInc, int GInc, int BInc);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall InvertColor(System::Uitypes::TColor aColor);
extern DELPHI_PACKAGE System::Types::TRect __fastcall GetWorkSpaceRect(void);
extern DELPHI_PACKAGE int __fastcall GetWorkSpaceTop(void);
extern DELPHI_PACKAGE int __fastcall GetWorkSpaceLeft(void);
extern DELPHI_PACKAGE int __fastcall GetWorkSpaceBottom(void);
extern DELPHI_PACKAGE int __fastcall GetWorkSpaceRight(void);
extern DELPHI_PACKAGE System::Types::TRect __fastcall GetDesktopRect(void);
extern DELPHI_PACKAGE int __fastcall GetDesktopTop(void);
extern DELPHI_PACKAGE int __fastcall GetDesktopLeft(void);
extern DELPHI_PACKAGE int __fastcall GetDesktopBottom(void);
extern DELPHI_PACKAGE int __fastcall GetDesktopRight(void);
extern DELPHI_PACKAGE void __fastcall RepaintControlBorder(HWND Wnd);
extern DELPHI_PACKAGE void __fastcall MinimizeToTray(HWND Wnd);
extern DELPHI_PACKAGE System::Types::TRect __fastcall GetSysTrayRect(void);
extern DELPHI_PACKAGE System::Types::TRect __fastcall GetTaskbarRect(void);
extern DELPHI_PACKAGE TTaskbarEdge __fastcall GetTaskbarEdge(void);
extern DELPHI_PACKAGE int __fastcall GetKeybTimes(int TimeKind);
extern DELPHI_PACKAGE void __fastcall GradientFillEx(HDC DC, const System::Types::TRect &DCRect, const System::Types::TRect &R, const System::Types::TPoint &Origin, System::Uitypes::TColor StartColor, System::Uitypes::TColor EndColor, int Steps, bool Vertical);
extern DELPHI_PACKAGE void __fastcall GradientFill(HDC DC, const System::Types::TRect &R, System::Uitypes::TColor StartColor, System::Uitypes::TColor EndColor, int Steps, bool Vertical);
extern DELPHI_PACKAGE void __fastcall GradientEdge(HDC DC, const System::Types::TRect &R, System::Uitypes::TColor StartColor, System::Uitypes::TColor EndColor, int Steps, TElGradientEdge Edge, bool Rounded);
extern DELPHI_PACKAGE bool __fastcall RectsIntersect(const System::Types::TRect &R1, const System::Types::TRect &R2);
extern DELPHI_PACKAGE bool __fastcall RectVisible(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
extern DELPHI_PACKAGE Vcl::Controls::TWinControl* __fastcall FindVCLChild(Vcl::Controls::TWinControl* Control, HWND ChildHandle);
extern DELPHI_PACKAGE void __fastcall DrawTransparentBitmapEx(HDC DC, Vcl::Graphics::TBitmap* Bitmap, int X, int Y, const System::Types::TRect &Src, System::Uitypes::TColor Transparent);
extern DELPHI_PACKAGE void __fastcall DrawTypedTextW(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Bounds, System::WideString Text, int Flags, Lmdgraph::TLMDTextDrawType DrawType);
extern DELPHI_PACKAGE void __fastcall DrawTypedText(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Bounds, System::UnicodeString Text, int Flags, Lmdgraph::TLMDTextDrawType DrawType);
extern DELPHI_PACKAGE void __fastcall Draw3dRectEx(HDC DC, int x, int y, int cx, int cy, unsigned clrTopLeft, unsigned clrBottomRight, Lmdgraph::TLMDBorderSides BorderSides);
extern DELPHI_PACKAGE void __fastcall Draw3dBorder(HDC DC, const System::Types::TRect &rc, System::Uitypes::TColor nColor1, System::Uitypes::TColor nColor2, System::Uitypes::TColor nColor3, System::Uitypes::TColor nColor4);
extern DELPHI_PACKAGE int __fastcall RGBtoHLS(int rgbc);
extern DELPHI_PACKAGE int __fastcall HLStoRGB(int hlsc);
extern DELPHI_PACKAGE int __fastcall HLS(System::Word H, System::Word L, System::Word S);
extern DELPHI_PACKAGE void __fastcall DrawButtonFrameEx3(HDC DC, const System::Types::TRect &rc, bool Focused, bool Pushed, System::Uitypes::TColor ButtonColor, bool Thin, Lmdgraph::TLMDBorderSides BorderSides);
extern DELPHI_PACKAGE void __fastcall DrawButtonFrame(HDC DC, const System::Types::TRect &rc, bool Focused, bool Pushed);
extern DELPHI_PACKAGE void __fastcall DrawButtonFrameEx2(HDC DC, const System::Types::TRect &rc, bool Focused, bool Pushed, System::Uitypes::TColor ButtonColor, bool Thin, System::Uitypes::TColor clrHighlight, System::Uitypes::TColor clrDkShadow, System::Uitypes::TColor clrFace, System::Uitypes::TColor clrShadow, Lmdgraph::TLMDBorderSides BorderSides);
extern DELPHI_PACKAGE void __fastcall DrawFlatFrameEx2(HDC DC, const System::Types::TRect &R, System::Uitypes::TColor Color, System::Uitypes::TColor BkColor, bool Focused, bool Enabled, Lmdgraph::TLMDBorderSides BorderSides, TElFlatBorderType BorderType, System::Uitypes::TColor Color1, System::Uitypes::TColor Color2, System::Uitypes::TColor Color3, System::Uitypes::TColor Color4, System::Uitypes::TColor Color5);
extern DELPHI_PACKAGE void __fastcall DrawFlatFrameEx(HDC DC, const System::Types::TRect &R, System::Uitypes::TColor BkColor, bool Focused, bool Enabled);
extern DELPHI_PACKAGE System::Types::TRect __fastcall DrawFlatFrame(HDC DC, const System::Types::TRect &R, System::Uitypes::TColor BkColor, bool Focused);
extern DELPHI_PACKAGE System::Types::TRect __fastcall DrawFlatFrame2(HDC DC, const System::Types::TRect &R, System::Uitypes::TColor BkColor, bool Focused, Lmdgraph::TLMDBorderSides BorderSides);
extern DELPHI_PACKAGE void __fastcall TiledPaint(Vcl::Graphics::TCanvas* Canvas, Vcl::Graphics::TBitmap* Bitmap, const System::Types::TRect &Rect)/* overload */;
extern DELPHI_PACKAGE void __fastcall TiledPaint(HDC ADC, Vcl::Graphics::TBitmap* Bitmap, const System::Types::TRect &Rect)/* overload */;
extern DELPHI_PACKAGE int __fastcall HitTest(const System::Types::TRect &R, const System::Types::TPoint &Pt, int CornerSize, int BorderSize);
extern DELPHI_PACKAGE HWND __fastcall GetTopWindowHandle(HWND Child);
extern DELPHI_PACKAGE Vcl::Controls::TControl* __fastcall GetTopOwnerControl(System::Classes::TComponent* Component);
extern DELPHI_PACKAGE System::Classes::TComponent* __fastcall GetComponentByName(System::Classes::TComponent* AOwner, System::UnicodeString AName);
extern DELPHI_PACKAGE System::Classes::TComponent* __fastcall GetRootComponent(System::Classes::TComponent* Component);
extern DELPHI_PACKAGE void __fastcall StartWait(void);
extern DELPHI_PACKAGE void __fastcall StopWait(void);
extern DELPHI_PACKAGE void __fastcall DrawFlatScrollbarThumb(HDC DC, const System::Types::TRect &rc, bool Focused);
extern DELPHI_PACKAGE bool __fastcall AlphaBlend(HDC hdcDest, int nXOriginDest, int nYOriginDest, int nWidthDest, int nHeightDest, HDC hdcSrc, int nXOriginSrc, int nYOriginSrc, int nWidthSrc, int nHeightSrc, System::Byte SourceConstantAlpha, System::Byte srcAlpha);
extern DELPHI_PACKAGE System::Types::TRect __fastcall DrawFlatScrollbars(HWND Wnd, HDC DC, const System::Types::TRect &Rect, bool Focused, System::Uitypes::TScrollStyle ScrollBars, bool DragHorz, bool DragVert, bool IsControl, int Style, int ExStyle);
extern DELPHI_PACKAGE void __fastcall DrawFlatScrollBarEx(HWND Wnd, HDC DC, const System::Types::TRect &Rect, int nType, bool bScrollbarCtrl, bool Dragging, bool Focused, System::Uitypes::TColor BkColor, System::Uitypes::TColor DitherColor, System::Uitypes::TColor ButtonColor, System::Uitypes::TColor ArrowColor, System::Uitypes::TColor HotButtonColor, bool DrawFrames, bool DitherBack);
extern DELPHI_PACKAGE void __fastcall DrawFlatScrollBarsEx(HWND Wnd, HDC DC, const System::Types::TRect &Rect, bool Focused, System::Uitypes::TScrollStyle ScrollBars, bool DragHorz, bool DragVert, bool IsControl, System::Uitypes::TColor BkColor, System::Uitypes::TColor DitherColor, System::Uitypes::TColor ButtonColor, System::Uitypes::TColor ArrowColor, System::Uitypes::TColor HotButtonColor, bool DrawFrames, bool DitherBack);
extern DELPHI_PACKAGE System::Types::TRect __fastcall DrawBevel(HDC DC, const System::Types::TRect &R, System::Uitypes::TColor Color1, System::Uitypes::TColor Color2, Lmdgraph::TLMDBorderSides Sides);
extern DELPHI_PACKAGE void __fastcall AlphaCopyRect(HDC DestDC, const System::Types::TRect &Dest, HDC SourceDC, const System::Types::TRect &Source, System::Byte AlphaLevel, bool UseAlphaLevel);
extern DELPHI_PACKAGE void __fastcall AlphaCopyRect2(HDC DestDC, const System::Types::TRect &Dest, HDC SourceDC, const System::Types::TRect &Source, Vcl::Graphics::TBitmap* Mask, System::Byte AlphaLevel);
extern DELPHI_PACKAGE bool __fastcall IsAlphaEmpty(Vcl::Graphics::TBitmap* bmp);
extern DELPHI_PACKAGE void __fastcall ClearAlpha(Vcl::Graphics::TBitmap* &bmp);
extern DELPHI_PACKAGE void __fastcall AlphaFillRect(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &ARect, System::Uitypes::TColor Color, System::Byte AlphaLevel);
extern DELPHI_PACKAGE int __fastcall DrawTextW(HDC hDC, System::WideChar * lpString, int nCount, System::Types::TRect &lpRect, unsigned uFormat);
extern DELPHI_PACKAGE HPEN __fastcall GetSysColorPen(unsigned Color);
extern DELPHI_PACKAGE void __fastcall DrawFocus(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
extern DELPHI_PACKAGE bool __fastcall Win2KHideUIState(void);
extern DELPHI_PACKAGE bool __fastcall ModalFormVisible(void);
extern DELPHI_PACKAGE int __fastcall ShiftStateToKeyData(System::Classes::TShiftState Shift);
extern DELPHI_PACKAGE void __fastcall DrawEdge(HDC DC, System::Types::TRect &RC, unsigned edge, unsigned grfFlags);
extern DELPHI_PACKAGE void __fastcall DrawEdgeEx(HDC DC, System::Types::TRect &RC, unsigned edge, unsigned grfFlags, System::Uitypes::TColor Color1, System::Uitypes::TColor Color2, System::Uitypes::TColor Color3, System::Uitypes::TColor Color4);
extern DELPHI_PACKAGE TElReader* __fastcall GetElReader(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall DWordToStr(unsigned Value);
extern DELPHI_PACKAGE bool __fastcall IsAnyBitsInOwnerDrawState(const Winapi::Windows::TOwnerDrawState State, const System::Word Bits);
extern DELPHI_PACKAGE int __fastcall GetScrollBarPos(NativeUInt hWnd, int BarFlag);
extern DELPHI_PACKAGE int __fastcall ElFileOpen(const Lmdtypes::TLMDString FileName, unsigned Mode);
extern DELPHI_PACKAGE int __fastcall ElFileCreate(const Lmdtypes::TLMDString FileName);
}	/* namespace Elvclutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELVCLUTILS)
using namespace Elvclutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElvclutilsHPP
