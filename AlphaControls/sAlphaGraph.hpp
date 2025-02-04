// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sAlphaGraph.pas' rev: 27.00 (Windows)

#ifndef SalphagraphHPP
#define SalphagraphHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <System.Math.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sMaskData.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Salphagraph
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TsCorner : unsigned char { scLeftTop, scLeftBottom, scRightTop, scRightBottom };

typedef System::Set<TsCorner, TsCorner::scLeftTop, TsCorner::scRightBottom> TsCorners;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE unsigned __fastcall SwapLong(unsigned Value)/* overload */;
extern DELPHI_PACKAGE void __fastcall UpdateAlpha(Vcl::Graphics::TBitmap* Img)/* overload */;
extern DELPHI_PACKAGE void __fastcall UpdateAlpha(Vcl::Graphics::TBitmap* Img, const System::Types::TRect &R)/* overload */;
extern DELPHI_PACKAGE Sconst::TsColor __fastcall GetAPixel(Vcl::Graphics::TBitmap* const Bmp, int x, int y);
extern DELPHI_PACKAGE void __fastcall SetAPixel(Vcl::Graphics::TBitmap* const Bmp, int x, int y, const Sconst::TsColor Value);
extern DELPHI_PACKAGE void __fastcall FillTransPixels32(Vcl::Graphics::TBitmap* const DstBmp, Vcl::Graphics::TBitmap* const SrcBmp, const System::Types::TRect &DstRect, const System::Types::TPoint &SrcPoint, int MaskIndex = 0xffffffff, System::TObject* SkinManager = (System::TObject*)(0x0), unsigned MaskPos = (unsigned)(0xd));
extern DELPHI_PACKAGE void __fastcall WriteText32(Vcl::Graphics::TBitmap* const Bmp, System::WideChar * Text, bool Enabled, System::Types::TRect &aRect, unsigned Flags, int SkinIndex, bool Hot, System::TObject* SkinManager = (System::TObject*)(0x0), bool IsAnsi = false);
extern DELPHI_PACKAGE void __fastcall FillDCBorder32(Vcl::Graphics::TBitmap* const Bmp, const System::Types::TRect &aRect, const int wl, const int wt, const int wr, const int wb, const System::Uitypes::TColor Color);
extern DELPHI_PACKAGE void __fastcall BlendColorRect(Vcl::Graphics::TBitmap* Bmp, const System::Types::TRect &R, Sconst::TPercent Transparency, System::Uitypes::TColor Color);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall SwapColor(System::Uitypes::TColor Color);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall SwapRedBlue(const System::Uitypes::TColor Color);
extern DELPHI_PACKAGE void __fastcall FillRect32(Vcl::Graphics::TBitmap* const Bmp, const System::Types::TRect &R, const System::Uitypes::TColor Color, System::Byte Alpha = (System::Byte)(0xff));
extern DELPHI_PACKAGE void __fastcall FillAlphaRect(Vcl::Graphics::TBitmap* const Bmp, const System::Types::TRect &R, System::Byte Value, System::Uitypes::TColor TransparentColor = (System::Uitypes::TColor)(0x1fffffff));
extern DELPHI_PACKAGE void __fastcall BmpDisabledKind(Vcl::Graphics::TBitmap* const Bmp, const Sconst::TsDisabledKind DisabledKind, Vcl::Controls::TControl* Parent, const Sconst::TCacheInfo &CI, const System::Types::TPoint &Offset);
extern DELPHI_PACKAGE void __fastcall DrawSmallSkinRect(Vcl::Graphics::TBitmap* Bmp, const System::Types::TRect &R, const Sconst::TCacheInfo &ci, const Smaskdata::TsMaskData &MaskData, int State);
extern DELPHI_PACKAGE void __fastcall DrawSkinRect(Vcl::Graphics::TBitmap* const Bmp, const System::Types::TRect &R, const Sconst::TCacheInfo &ci, const Smaskdata::TsMaskData &MaskData, const int State, const bool UpdateCorners);
extern DELPHI_PACKAGE void __fastcall CopyMasterRect(const System::Types::TRect &R1, const System::Types::TRect &R2, Vcl::Graphics::TBitmap* const Bmp, const Sconst::TCacheInfo &CI, const Smaskdata::TsMaskData &MaskData);
extern DELPHI_PACKAGE void __fastcall CopyMasterRectA(const System::Types::TRect &R1, const System::Types::TRect &R2, Vcl::Graphics::TBitmap* const Bmp, const Sconst::TCacheInfo &CI, const Smaskdata::TsMaskData &MaskData);
extern DELPHI_PACKAGE void __fastcall CopyByMask32(const System::Types::TRect &R1, const System::Types::TRect &R2, Vcl::Graphics::TBitmap* const Bmp1, Vcl::Graphics::TBitmap* const Bmp2, const Sconst::TCacheInfo &CI, const Smaskdata::TsMaskData &MaskData);
extern DELPHI_PACKAGE void __fastcall CopyByMask32Ex(const System::Types::TRect &R1, const System::Types::TRect &R2, Vcl::Graphics::TBitmap* Bmp1, Vcl::Graphics::TBitmap* Bmp2, const Sconst::TCacheInfo &CI, const Smaskdata::TsMaskData &MaskData, int Opacity);
extern DELPHI_PACKAGE void __fastcall DrawSkinGlyph(Vcl::Graphics::TBitmap* Bmp, const System::Types::TPoint &P, int State, int AddedTransparency, const Smaskdata::TsMaskData &MaskData, const Sconst::TCacheInfo &CI);
extern DELPHI_PACKAGE void __fastcall StretchBltMask(int DstX1, int DstY1, int Dst_Width, int Dst_Height, int SrcX1, int SrcY1, int Src_Width, int Src_Height, Vcl::Graphics::TBitmap* BmpDst, Vcl::Graphics::TBitmap* BmpSrc, int MaskOffset, bool NoStdStretch = false);
extern DELPHI_PACKAGE void __fastcall StretchBltMask32(int DstX1, int DstY1, int Dst_Width, int Dst_Height, int SrcX1, int SrcY1, int Src_Width, int Src_Height, Vcl::Graphics::TBitmap* BmpDst, Vcl::Graphics::TBitmap* BmpSrc, int MaskOffset, bool NoStdStretch = false);
extern DELPHI_PACKAGE void __fastcall StretchBltMask32Ex(int DstX1, int DstY1, int Dst_Width, int Dst_Height, int SrcX1, int SrcY1, int Src_Width, int Src_Height, Vcl::Graphics::TBitmap* BmpDst, Vcl::Graphics::TBitmap* BmpSrc, int MaskOffset, int Opacity, bool NoStdStretch = false);
extern DELPHI_PACKAGE void __fastcall BlendGlyphByMask(const System::Types::TRect &R1, const System::Types::TRect &R2, Vcl::Graphics::TBitmap* Bmp1, Vcl::Graphics::TBitmap* Bmp2, int AddedTransparency, const Smaskdata::TsMaskData &MaskData);
extern DELPHI_PACKAGE void __fastcall UpdateCorners(Scommondata::TsCommonData* SkinData, int State, TsCorners Corners = (TsCorners() << TsCorner::scLeftTop << TsCorner::scLeftBottom << TsCorner::scRightTop << TsCorner::scRightBottom ));
extern DELPHI_PACKAGE void __fastcall FillLongword(void *X, int Count, unsigned Value);
extern DELPHI_PACKAGE void __fastcall ConvertMaskToAlpha(Vcl::Graphics::TBitmap* const DstBmp, Vcl::Graphics::TBitmap* const SrcBmp, const System::Types::TRect &DstRect, const System::Types::TRect &SrcRect);
extern DELPHI_PACKAGE void __fastcall PaintItem32(int SkinIndex, bool Filling, int State, const System::Types::TRect &R, const System::Types::TPoint &pP, Vcl::Graphics::TBitmap* ItemBmp, System::TObject* SkinManager = (System::TObject*)(0x0))/* overload */;
extern DELPHI_PACKAGE void __fastcall PaintItemBG32(int SkinIndex, int State, const System::Types::TRect &R, Vcl::Graphics::TBitmap* ItemBmp, System::TObject* SkinManager, System::Uitypes::TColor CustomColor = (System::Uitypes::TColor)(0xff00ff));
extern DELPHI_PACKAGE void __fastcall DrawSkinRect32(Vcl::Graphics::TBitmap* const Bmp, const System::Types::TRect &R, const Sconst::TCacheInfo &ci, const Smaskdata::TsMaskData &MaskData, const int State);
extern DELPHI_PACKAGE void __fastcall DrawSkinRect32Ex(Vcl::Graphics::TBitmap* Bmp, const System::Types::TRect &R, const Sconst::TCacheInfo &ci, const Smaskdata::TsMaskData &MaskData, int State, const System::Types::TRect &MaxWidths, int Opacity);
}	/* namespace Salphagraph */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SALPHAGRAPH)
using namespace Salphagraph;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SalphagraphHPP
