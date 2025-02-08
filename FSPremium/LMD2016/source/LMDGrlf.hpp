// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDGrlf.pas' rev: 31.00 (Windows)

#ifndef LmdgrlfHPP
#define LmdgrlfHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDFXCaption.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdgrlf
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
typedef short TLMDToggle;

enum DECLSPEC_DENUM TLMDTransLabelTypes : unsigned char { tmWave, tmNone, tmHalfcircle, tmArrow, tmSpeaker, tmInvSpeaker, tmFly, tmChair, tmStairs, tmInvStairs, tmBuckled, tmEnterprise, tmLNoseUp, tmLNoseDown, tmRNoseUp, tmRNoseDown, tmCube, tmHalfmoon };

enum DECLSPEC_DENUM TLMDTransLabelAttributes : unsigned char { taPerspective, taToggled, taAutoToggled, taEqualLetters };

typedef System::Set<TLMDTransLabelAttributes, TLMDTransLabelAttributes::taPerspective, TLMDTransLabelAttributes::taEqualLetters> TLMDTransLabelAttr;

enum DECLSPEC_DENUM TLMDPerspective : unsigned char { tpFrog, tpBird };

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall CalcPosAndSize(int X, int Y, int i, int FFactor, int MinSize, int FToggle, int FPerspectiveDepth, Vcl::Graphics::TFont* FFont, TLMDTransLabelAttr FTransAttr, TLMDTransLabelTypes FTransform, float bm, System::UnicodeString DCaption, Vcl::Graphics::TCanvas* Canvas, tagLOGFONTW &LogRec, Lmdfxcaption::TLMDFxCaption* FFontFX, System::Types::TSize &TS, int &X2, int &Y2);
extern DELPHI_PACKAGE void __fastcall CalcSize(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &aRect, Vcl::Graphics::TFont* FFont, Lmdfxcaption::TLMDFxCaption* FFontFX, System::UnicodeString Caption, TLMDTransLabelTypes FTransform, TLMDToggle FToggle, int FFactor, bool FInvertCaption, TLMDPerspective FPerspective, int FPerspectiveDepth, TLMDTransLabelAttr FTransAttr);
extern DELPHI_PACKAGE void __fastcall SpecialTextOut(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &aRect, Vcl::Graphics::TFont* FFont, Lmdfxcaption::TLMDFxCaption* FFontFX, System::UnicodeString Caption, TLMDTransLabelTypes FTransform, TLMDToggle FToggle, int FFactor, bool FInvertCaption, TLMDPerspective FPerspective, int FPerspectiveDepth, TLMDTransLabelAttr FTransAttr);
}	/* namespace Lmdgrlf */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDGRLF)
using namespace Lmdgrlf;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdgrlfHPP
