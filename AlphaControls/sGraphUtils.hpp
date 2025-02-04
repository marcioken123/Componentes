// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sGraphUtils.pas' rev: 27.00 (Windows)

#ifndef SgraphutilsHPP
#define SgraphutilsHPP

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
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <System.Math.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <sMaskData.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <acTinyJPG.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sgraphutils
{
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TsHSV
{
public:
	int h;
	double s;
	double v;
};


enum DECLSPEC_DENUM TFilterType : unsigned char { ftBox, ftTriangle, ftHermite, ftBell, ftSpline, ftLanczos3, ftMitchell };

typedef System::StaticArray<System::Sysutils::PByteArray, 1000001> TByteArrays;

typedef TByteArrays *PByteArrays;

typedef System::Int8 TKernelSize;

typedef void __fastcall (*TacChangeColor)(Sconst::TsColor_ &Color, const int Param);

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 MaxKernelSize = System::Int8(0x10);
extern DELPHI_PACKAGE NativeUInt User32Lib;
extern DELPHI_PACKAGE bool __stdcall (*SetLayeredWindowAttributes)(NativeUInt Hwnd, unsigned crKey, System::Byte bAlpha, unsigned dwFlags);
extern DELPHI_PACKAGE bool __stdcall (*UpdateLayeredWindow)(NativeUInt Handle, HDC hdcDest, System::Types::PPoint pptDst, System::Types::PSize _psize, HDC hdcSrc, System::Types::PPoint pptSrc, unsigned crKey, Winapi::Windows::PBlendFunction pblend, unsigned dwFlags);
extern DELPHI_PACKAGE void __fastcall SetFontSmoothing(Vcl::Graphics::TFont* AFont);
extern DELPHI_PACKAGE void __fastcall CopyBmp(Vcl::Graphics::TBitmap* DstBmp, Vcl::Graphics::TBitmap* SrcBmp);
extern DELPHI_PACKAGE bool __fastcall InitLine(Vcl::Graphics::TBitmap* Bmp, void * &Line0, int &Delta);
extern DELPHI_PACKAGE void __fastcall DrawColorArrow(Vcl::Graphics::TCanvas* const Canvas, const System::Uitypes::TColor Color, const System::Types::TRect &R, const Sconst::TacSide Direction)/* overload */;
extern DELPHI_PACKAGE HFONT __fastcall MakeAngledFont(HDC DC, Vcl::Graphics::TFont* Font, int Orient);
extern DELPHI_PACKAGE int __fastcall CheckWidth(System::TObject* const SkinManager, const bool SmallGlyphs = true);
extern DELPHI_PACKAGE int __fastcall CheckHeight(System::TObject* const SkinManager, const bool SmallGlyphs = true);
extern DELPHI_PACKAGE void __fastcall acDrawCheck(const System::Types::TRect &R, const Vcl::Stdctrls::TCheckBoxState AState, const bool AEnabled, Vcl::Graphics::TBitmap* const Bmp, const Sconst::TCacheInfo &CI, System::TObject* const SkinManager, const bool SmallGlyphs = true);
extern DELPHI_PACKAGE void __fastcall ChangeBitmapPixels(Vcl::Graphics::TBitmap* Bmp, TacChangeColor ChangeProc, int Param, System::Uitypes::TColor SkipColor);
extern DELPHI_PACKAGE void __fastcall ChangeColorBrightness(Sconst::TsColor_ &Prop, const int Param);
extern DELPHI_PACKAGE void __fastcall ChangeColorSaturation(Sconst::TsColor_ &Prop, const int Param);
extern DELPHI_PACKAGE void __fastcall ChangeColorHUE(Sconst::TsColor_ &Prop, const int Param);
extern DELPHI_PACKAGE void __fastcall ChangeColorTone(Sconst::TsColor_ &Prop, const int Param);
extern DELPHI_PACKAGE void __fastcall MakeAlphaPixel(Sconst::TsColor_ &Prop, const int Param);
extern DELPHI_PACKAGE bool __fastcall acLayered(void);
extern DELPHI_PACKAGE int __fastcall SwapInteger(const int i);
extern DELPHI_PACKAGE Sconst::TsColor_ __fastcall ChangeTone(const Sconst::TsColor_ Color, const Sconst::TsColor_RGB Tone)/* overload */;
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall ChangeTone(const System::Uitypes::TColor Color, const System::Uitypes::TColor Tone)/* overload */;
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall ChangeBrightness(const System::Uitypes::TColor Color, const int Delta);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall ChangeSaturation(const System::Uitypes::TColor Color, const int Delta)/* overload */;
extern DELPHI_PACKAGE Sconst::TsColor_ __fastcall ChangeSaturation(const int Delta, const Sconst::TsColor_ Color)/* overload */;
extern DELPHI_PACKAGE Sconst::TsColor __fastcall Hsv2Rgb(double h, double s, double v);
extern DELPHI_PACKAGE TsHSV __fastcall Rgb2Hsv(Sconst::TsColor C);
extern DELPHI_PACKAGE Sconst::TsColor_ __fastcall ChangeHue(const int Delta, Sconst::TsColor_ C)/* overload */;
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall ChangeHue(const int Delta, const System::Uitypes::TColor Color)/* overload */;
extern DELPHI_PACKAGE void __fastcall HSVtoRGB(const double H, const double S, const double V, double &R, double &G, double &B);
extern DELPHI_PACKAGE void __fastcall RGBToHSV(const double R, const double G, const double B, double &H, double &S, double &V);
extern DELPHI_PACKAGE void __fastcall GetRgnFromBmp(HRGN &rgn, Vcl::Graphics::TBitmap* MaskBmp, System::Uitypes::TColor TransColor);
extern DELPHI_PACKAGE bool __fastcall GetBGInfo(const Sconst::PacBGInfo BGInfo, const NativeUInt Handle, bool PleaseDraw = false)/* overload */;
extern DELPHI_PACKAGE Sconst::TCacheInfo __fastcall BGInfoToCI(const Sconst::PacBGInfo BGInfo);
extern DELPHI_PACKAGE bool __fastcall GetBGInfo(const Sconst::PacBGInfo BGInfo, Vcl::Controls::TControl* const Control, bool PleaseDraw = false)/* overload */;
extern DELPHI_PACKAGE void __fastcall AddRgnBmp(Sconst::TAOR &AOR, Vcl::Graphics::TBitmap* MaskBmp, Sconst::TsColor TransColor);
extern DELPHI_PACKAGE void __fastcall AddRgn(Sconst::TAOR &AOR, int Width, const Smaskdata::TsMaskData &MaskData, int VertOffset, bool Bottom);
extern DELPHI_PACKAGE void __fastcall CopyImage(Vcl::Graphics::TBitmap* const Glyph, Vcl::Imglist::TCustomImageList* const ImageList, const int Index);
extern DELPHI_PACKAGE void __fastcall PaintItemBG(int SkinIndex, const System::UnicodeString SkinSection, const Sconst::TCacheInfo &ci, int State, const System::Types::TRect &R, const System::Types::TPoint &pP, Vcl::Graphics::TBitmap* ItemBmp, System::TObject* SkinManager = (System::TObject*)(0x0), int TextureIndex = 0xffffffff, int HotTextureIndex = 0xffffffff, System::Uitypes::TColor CustomColor = (System::Uitypes::TColor)(0xff00ff))/* overload */;
extern DELPHI_PACKAGE void __fastcall PaintItemBG(Scommondata::TsCommonData* SkinData, const Sconst::TCacheInfo &ci, int State, const System::Types::TRect &R, const System::Types::TPoint &pP, Vcl::Graphics::TBitmap* ItemBmp, int OffsetX = 0x0, int OffsetY = 0x0)/* overload */;
extern DELPHI_PACKAGE void __fastcall PaintItemBGFast(int SkinIndex, int BGIndex, int BGHotIndex, const System::UnicodeString SkinSection, const Sconst::TCacheInfo &ci, int State, const System::Types::TRect &R, const System::Types::TPoint &pP, Vcl::Graphics::TBitmap* ItemBmp, System::TObject* SkinManager = (System::TObject*)(0x0));
extern DELPHI_PACKAGE void __fastcall PaintItem(int SkinIndex, const System::UnicodeString SkinSection, const Sconst::TCacheInfo &ci, bool Filling, int State, const System::Types::TRect &R, const System::Types::TPoint &pP, HDC DC, System::TObject* SkinManager = (System::TObject*)(0x0))/* overload */;
extern DELPHI_PACKAGE void __fastcall PaintItem(int SkinIndex, const System::UnicodeString SkinSection, const Sconst::TCacheInfo &ci, bool Filling, int State, const System::Types::TRect &R, const System::Types::TPoint &pP, Vcl::Graphics::TBitmap* ItemBmp, System::TObject* SkinManager = (System::TObject*)(0x0), int BGIndex = 0xffffffff, int BGHotIndex = 0xffffffff)/* overload */;
extern DELPHI_PACKAGE void __fastcall PaintItemFast(int SkinIndex, int MaskIndex, int BGIndex, int BGHotIndex, const System::UnicodeString SkinSection, const Sconst::TCacheInfo &ci, bool Filling, int State, const System::Types::TRect &R, const System::Types::TPoint &pP, Vcl::Graphics::TBitmap* ItemBmp, System::TObject* SkinManager = (System::TObject*)(0x0))/* overload */;
extern DELPHI_PACKAGE void __fastcall PaintSmallItem(int SkinIndex, const System::UnicodeString SkinSection, const Sconst::TCacheInfo &ci, bool Filling, int State, const System::Types::TRect &R, const System::Types::TPoint &pP, Vcl::Graphics::TBitmap* ItemBmp, System::TObject* SkinManager = (System::TObject*)(0x0))/* overload */;
extern DELPHI_PACKAGE int __fastcall PaintSection(Vcl::Graphics::TBitmap* const Bmp, System::UnicodeString Section, const System::UnicodeString SecondSection, const int State, System::TObject* const Manager, const System::Types::TPoint &ParentOffset, const System::Uitypes::TColor BGColor, HDC ParentDC = (HDC)(0x0));
extern DELPHI_PACKAGE void __fastcall PaintItem(Scommondata::TsCommonData* SkinData, const Sconst::TCacheInfo &ci, bool Filling, int State, const System::Types::TRect &R, const System::Types::TPoint &pP, Vcl::Graphics::TBitmap* ItemBmp, bool UpdateCorners, int OffsetX = 0x0, int OffsetY = 0x0)/* overload */;
extern DELPHI_PACKAGE bool __fastcall PaintSkinControl(Scommondata::TsCommonData* const SkinData, Vcl::Controls::TControl* const Parent, const bool Filling, int State, const System::Types::TRect &R, const System::Types::TPoint &pP, Vcl::Graphics::TBitmap* const ItemBmp, const bool UpdateCorners, const int OffsetX = 0x0, const int OffsetY = 0x0);
extern DELPHI_PACKAGE void __fastcall CopyChannel32(Vcl::Graphics::TBitmap* const DstBmp, Vcl::Graphics::TBitmap* const SrcBmp, const int Channel)/* overload */;
extern DELPHI_PACKAGE void __fastcall CopyChannel32(Vcl::Graphics::TBitmap* const DstBmp, Vcl::Graphics::TBitmap* const SrcBmp, const int Channel, const System::Types::TRect &DstRect, const System::Types::TRect &SrcRect)/* overload */;
extern DELPHI_PACKAGE void __fastcall CopyChannel(Vcl::Graphics::TBitmap* const Bmp32, Vcl::Graphics::TBitmap* const Bmp8, const int Channel, const bool From32To8);
extern DELPHI_PACKAGE void __fastcall PaintControlByTemplate(Vcl::Graphics::TBitmap* const DstBmp, Vcl::Graphics::TBitmap* const SrcBmp, const System::Types::TRect &DstRect, const System::Types::TRect &SrcRect, const System::Types::TRect &BorderWidths, const System::Types::TRect &BorderMaxWidths, const System::Types::TRect &DrawModes, const bool StretchCenter, bool FillCenter = true);
extern DELPHI_PACKAGE void __fastcall DrawGlyphEx(Vcl::Graphics::TBitmap* Glyph, Vcl::Graphics::TBitmap* DstBmp, const System::Types::TRect &R, int NumGlyphs, bool Enabled, Sconst::TsDisabledGlyphKind DisabledGlyphKind, int State, int Blend, bool Down = false, bool Reflected = false);
extern DELPHI_PACKAGE void __fastcall FillDC(HDC DC, const System::Types::TRect &aRect, const System::Uitypes::TColor Color);
extern DELPHI_PACKAGE void __fastcall FillDCBorder(const HDC DC, const System::Types::TRect &aRect, const int wl, const int wt, const int wr, const int wb, const System::Uitypes::TColor Color);
extern DELPHI_PACKAGE void __fastcall BitBltBorder(const HDC DestDC, const int X, const int Y, const int Width, const int Height, const HDC SrcDC, const int XSrc, const int YSrc, const int BorderWidth);
extern DELPHI_PACKAGE void __fastcall ExcludeControls(const HDC DC, Vcl::Controls::TWinControl* const Ctrl, const Sconst::TacCtrlType CtrlType, const int OffsetX, const int OffsetY);
extern DELPHI_PACKAGE void __fastcall GrayScale(Vcl::Graphics::TBitmap* Bmp);
extern DELPHI_PACKAGE void __fastcall GrayScaleTrans(Vcl::Graphics::TBitmap* Bmp, const Sconst::TsColor TransColor);
extern DELPHI_PACKAGE System::UnicodeString __fastcall CutText(Vcl::Graphics::TCanvas* Canvas, const System::UnicodeString Text, int MaxLength);
extern DELPHI_PACKAGE void __fastcall WriteText(Vcl::Graphics::TCanvas* Canvas, System::WideChar * Text, bool Enabled, System::Types::TRect &aRect, unsigned Flags);
extern DELPHI_PACKAGE void __fastcall WriteTextOnDC(HDC DC, System::WideChar * Text, bool Enabled, System::Types::TRect &aRect, unsigned Flags);
extern DELPHI_PACKAGE int __fastcall acDrawText(HDC hDC, const System::UnicodeString Text, System::Types::TRect &lpRect, unsigned uFormat);
extern DELPHI_PACKAGE int __fastcall acTextWidth(Vcl::Graphics::TCanvas* const Canvas, const System::UnicodeString Text);
extern DELPHI_PACKAGE int __fastcall acTextHeight(Vcl::Graphics::TCanvas* const Canvas, const System::UnicodeString Text);
extern DELPHI_PACKAGE System::Types::TSize __fastcall acTextExtent(Vcl::Graphics::TCanvas* const Canvas, const System::UnicodeString Text);
extern DELPHI_PACKAGE void __fastcall acTextRect(Vcl::Graphics::TCanvas* const Canvas, const System::Types::TRect &Rect, int X, int Y, const System::UnicodeString Text);
extern DELPHI_PACKAGE BOOL __fastcall acGetTextExtent(const HDC DC, const System::UnicodeString Str, System::Types::TSize &Size);
extern DELPHI_PACKAGE void __fastcall acDrawGlowForText(Vcl::Graphics::TBitmap* const DstBmp, System::WideChar * Text, const System::Types::TRect &aRect, unsigned Flags, unsigned Side, int BlurSize, System::Uitypes::TColor Color, Vcl::Graphics::TBitmap* &MaskBmp);
extern DELPHI_PACKAGE void __fastcall Blur8(Vcl::Graphics::TBitmap* theBitmap, double radius);
extern DELPHI_PACKAGE void __fastcall QBlur(Vcl::Graphics::TBitmap* Bmp);
extern DELPHI_PACKAGE void __fastcall acWriteTextEx(Vcl::Graphics::TCanvas* const Canvas, const System::WideChar * Text, const bool Enabled, System::Types::TRect &aRect, const unsigned Flags, Scommondata::TsCommonData* const SkinData, const bool Hot, System::TObject* const SkinManager = (System::TObject*)(0x0))/* overload */;
extern DELPHI_PACKAGE void __fastcall acWriteTextEx(Vcl::Graphics::TCanvas* const Canvas, const System::WideChar * Text, const bool Enabled, System::Types::TRect &aRect, const unsigned Flags, const int SkinIndex, const bool Hot, System::TObject* const SkinManager = (System::TObject*)(0x0))/* overload */;
extern DELPHI_PACKAGE void __fastcall acWriteText(Vcl::Graphics::TCanvas* const Canvas, const System::WideChar * Text, const bool Enabled, System::Types::TRect &aRect, const unsigned Flags);
extern DELPHI_PACKAGE void __fastcall WriteTextEx(Vcl::Graphics::TCanvas* const Canvas, System::WideChar * Text, bool Enabled, System::Types::TRect &aRect, unsigned Flags, int SkinIndex, bool Hot, System::TObject* SkinManager = (System::TObject*)(0x0))/* overload */;
extern DELPHI_PACKAGE void __fastcall WriteTextEx(Vcl::Graphics::TCanvas* const Canvas, System::WideChar * Text, bool Enabled, System::Types::TRect &aRect, unsigned Flags, Scommondata::TsCommonData* SkinData, bool Hot)/* overload */;
extern DELPHI_PACKAGE void __fastcall FadeRect(Vcl::Graphics::TCanvas* CanvasSrc, const System::Types::TRect &RSrc, HDC CanvasDst, const System::Types::TPoint &PDst, int Transparency, System::Uitypes::TColor Color, int Blur, Sconst::TsShadowingShape Shape)/* overload */;
extern DELPHI_PACKAGE void __fastcall FadeRect(Vcl::Graphics::TCanvas* CanvasSrc, const System::Types::TRect &RSrc, HDC CanvasDst, const System::Types::TPoint &PDst, int Transparency, System::Uitypes::TColor Color, int Blur, Sconst::TsShadowingShape Shape, int Radius)/* overload */;
extern DELPHI_PACKAGE void __fastcall FadeBmp(Vcl::Graphics::TBitmap* FadedBmp, const System::Types::TRect &aRect, int Transparency, const Sconst::TsColor Color, int Blur, int Radius);
extern DELPHI_PACKAGE void __fastcall BlendTransRectangle(Vcl::Graphics::TBitmap* Dst, int X, int Y, Vcl::Graphics::TBitmap* Src, const System::Types::TRect &aRect, double Blend, System::Uitypes::TColor TransColor = (System::Uitypes::TColor)(0xff00ff));
extern DELPHI_PACKAGE void __fastcall BlendTransBitmap(Vcl::Graphics::TBitmap* Bmp, double Blend, const Sconst::TsColor Color);
extern DELPHI_PACKAGE void __fastcall BlendBmpByMask(Vcl::Graphics::TBitmap* SrcBmp, Vcl::Graphics::TBitmap* MskBmp, const Sconst::TsColor BlendColor);
extern DELPHI_PACKAGE void __fastcall SumBitmaps(Vcl::Graphics::TBitmap* SrcBmp, Vcl::Graphics::TBitmap* MskBmp, const System::Byte AlphaValue);
extern DELPHI_PACKAGE void __fastcall SumBmpRect(Vcl::Graphics::TBitmap* const DstBmp, Vcl::Graphics::TBitmap* const SrcBmp, const System::Byte AlphaValue, const System::Types::TRect &SrcRect, const System::Types::TPoint &DstPoint);
extern DELPHI_PACKAGE void __fastcall CopyByMask(const System::Types::TRect &R1, const System::Types::TRect &R2, Vcl::Graphics::TBitmap* const Bmp1, Vcl::Graphics::TBitmap* const Bmp2, const Sconst::TCacheInfo &CI, const bool UpdateTrans)/* overload */;
extern DELPHI_PACKAGE void __fastcall CopyBmp32(const System::Types::TRect &R1, const System::Types::TRect &R2, Vcl::Graphics::TBitmap* const Bmp1, Vcl::Graphics::TBitmap* const Bmp2, const Sconst::TCacheInfo &CI, const bool UpdateTrans, System::Uitypes::TColor GrayedColor, const int Blend, const bool Reflected);
extern DELPHI_PACKAGE void __fastcall CopyByMask(const System::Types::TRect &R1, const System::Types::TRect &R2, Vcl::Graphics::TBitmap* const Bmp1, Vcl::Graphics::TBitmap* const Bmp2, const Sconst::TCacheInfo &CI, const bool UpdateTrans, const Smaskdata::TsMaskData &MaskData)/* overload */;
extern DELPHI_PACKAGE void __fastcall CopyTransBitmaps(Vcl::Graphics::TBitmap* DstBmp, Vcl::Graphics::TBitmap* SrcBmp, int X, int Y, Sconst::TsColor TransColor);
extern DELPHI_PACKAGE void __fastcall CopyTransRect(Vcl::Graphics::TBitmap* DstBmp, Vcl::Graphics::TBitmap* SrcBmp, int X, int Y, const System::Types::TRect &SrcRect, System::Uitypes::TColor TransColor, const Sconst::TCacheInfo &CI, bool UpdateTrans);
extern DELPHI_PACKAGE void __fastcall CopyTransRectA(Vcl::Graphics::TBitmap* DstBmp, Vcl::Graphics::TBitmap* SrcBmp, int X, int Y, const System::Types::TRect &SrcRect, System::Uitypes::TColor TransColor, const Sconst::TCacheInfo &CI);
extern DELPHI_PACKAGE void __fastcall SumBitmapsByMask(Vcl::Graphics::TBitmap* &DstBmp, Vcl::Graphics::TBitmap* &Src1, Vcl::Graphics::TBitmap* &Src2, Vcl::Graphics::TBitmap* MskBmp, System::Word Percent = (System::Word)(0x0));
extern DELPHI_PACKAGE void __fastcall SumByMaskWith32(Vcl::Graphics::TBitmap* const DstBmp, Vcl::Graphics::TBitmap* const SrcBmp, Vcl::Graphics::TBitmap* const MskBmp, const System::Types::TRect &aRect);
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* __fastcall MakeRotated90(Vcl::Graphics::TBitmap* &Bmp, bool CW, bool KillSource = true);
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* __fastcall CreateBmpLike(Vcl::Graphics::TBitmap* const Bmp);
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* __fastcall CreateAlphaBmp(Vcl::Graphics::TBitmap* const SrcMaskedBmp, const System::Types::TRect &SrcRect);
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* __fastcall CreateBmp24(const int Width, const int Height);
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* __fastcall CreateBmp32(const int Width, const int Height);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall ChangeColor(const System::Uitypes::TColor ColorBegin, const System::Uitypes::TColor ColorEnd, const double i);
extern DELPHI_PACKAGE Sconst::TsColor __fastcall AverageColor(const Sconst::TsColor ColorBegin, const Sconst::TsColor ColorEnd)/* overload */;
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall AverageColor(const System::Uitypes::TColor ColorBegin, const System::Uitypes::TColor ColorEnd)/* overload */;
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall MixColors(const System::Uitypes::TColor Color1, const System::Uitypes::TColor Color2, const double PercentOfColor1);
extern DELPHI_PACKAGE void __fastcall DrawRectangleOnDC(HDC DC, System::Types::TRect &R, System::Uitypes::TColor ColorTop, System::Uitypes::TColor ColorBottom, int &Width);
extern DELPHI_PACKAGE void __fastcall TileBitmap(Vcl::Graphics::TCanvas* const Canvas, const System::Types::TRect &aRect, Vcl::Graphics::TGraphic* const Graphic)/* overload */;
extern DELPHI_PACKAGE void __fastcall TileBitmap(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &aRect, Vcl::Graphics::TGraphic* Graphic, const Smaskdata::TsMaskData &MaskData, Sconst::TacFillMode FillMode = (Sconst::TacFillMode)(0x0))/* overload */;
extern DELPHI_PACKAGE void __fastcall TileMasked(Vcl::Graphics::TBitmap* Bmp, System::Types::TRect &aRect, const Sconst::TCacheInfo &CI, const Smaskdata::TsMaskData &MaskData, Sconst::TacFillMode FillMode = (Sconst::TacFillMode)(0xa));
extern DELPHI_PACKAGE void __fastcall CalcButtonLayout(const System::Types::TRect &Client, const System::Types::TPoint &GlyphSize, const System::Types::TSize &TextRectSize, Vcl::Buttons::TButtonLayout Layout, System::Classes::TAlignment Alignment, int Margin, int Spacing, System::Types::TPoint &GlyphPos, System::Types::TRect &TextBounds, int BiDiFlags);
extern DELPHI_PACKAGE int __fastcall GetFontHeight(HWND hFont);
extern DELPHI_PACKAGE System::Types::TSize __fastcall GetStringSize(HGDIOBJ hFont, const System::UnicodeString Text, unsigned Flags = (unsigned)(0x0), bool WrapText = false, int MaxWidth = 0x7fffffff);
extern DELPHI_PACKAGE bool __fastcall LoadJpegOrBmp(Vcl::Graphics::TPicture* Image, const System::UnicodeString FileName, bool Gray);
extern DELPHI_PACKAGE void __fastcall FocusRect(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, System::Uitypes::TColor LightColor = (System::Uitypes::TColor)(0xff00000f), System::Uitypes::TColor DarkColor = (System::Uitypes::TColor)(0x0));
extern DELPHI_PACKAGE void __fastcall Stretch(Vcl::Graphics::TBitmap* const Src, Vcl::Graphics::TBitmap* const Dst, const int Width, const int Height, const TFilterType Filter, const int Param = 0x0);
}	/* namespace Sgraphutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SGRAPHUTILS)
using namespace Sgraphutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SgraphutilsHPP
