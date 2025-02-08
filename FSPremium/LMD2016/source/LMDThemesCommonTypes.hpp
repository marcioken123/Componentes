// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDThemesCommonTypes.pas' rev: 31.00 (Windows)

#ifndef LmdthemescommontypesHPP
#define LmdthemescommontypesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Graphics.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Themes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdthemescommontypes
{
//-- forward type declarations -----------------------------------------------
struct TLMDThemeDetailMetaData;
struct TLMDThemeElementMetaData;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDColorIndex : unsigned char { ciStart, ciEnd };

enum DECLSPEC_DENUM TLMDDetailPropKind : unsigned char { dpkFill, dpkFrame, dpkEnabledText, dpkDisabledText };

typedef System::Set<TLMDDetailPropKind, TLMDDetailPropKind::dpkFill, TLMDDetailPropKind::dpkDisabledText> TLMDDetailPropKindSet;

typedef System::Set<TLMDColorIndex, TLMDColorIndex::ciStart, TLMDColorIndex::ciEnd> TLMDColorIndexSet;

typedef System::Set<Vcl::Themes::TThemedElement, Vcl::Themes::TThemedElement::teButton, Vcl::Themes::TThemedElement::teSearchIndicators> TThemedElementSet;

enum DECLSPEC_DENUM TLMDGradientColorCountType : unsigned char { gccCalculated, gccFixed };

struct DECLSPEC_DRECORD TLMDThemeDetailMetaData
{
public:
	System::Typinfo::TTypeInfo *DetailTypeInfo;
	void *FillData;
	void *FrameData;
	void *TextData;
	void *AuxData;
};


struct DECLSPEC_DRECORD TLMDThemeElementMetaData
{
	
private:
	typedef System::DynamicArray<TLMDThemeDetailMetaData> _TLMDThemeElementMetaData__1;
	
	
public:
	System::Typinfo::TTypeInfo *ElementTypeInfo;
	_TLMDThemeElementMetaData__1 DetailData;
};


typedef TLMDThemeElementMetaData *PLMDThemeElementMetaData;

typedef System::StaticArray<System::StaticArray<System::Uitypes::TColor, 2>, 256> TLMDGradientColorsData;

typedef TLMDGradientColorsData *PLMDGradientColorsData;

typedef System::StaticArray<System::Uitypes::TColor, 256> TLMDColorsData;

typedef TLMDColorsData *PLMDColorsData;

//-- var, const, procedure ---------------------------------------------------
#define CAllDetailPropKinds (System::Set<TLMDDetailPropKind, TLMDDetailPropKind::dpkFill, TLMDDetailPropKind::dpkDisabledText>() << TLMDDetailPropKind::dpkFill << TLMDDetailPropKind::dpkFrame << TLMDDetailPropKind::dpkEnabledText << TLMDDetailPropKind::dpkDisabledText )
}	/* namespace Lmdthemescommontypes */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTHEMESCOMMONTYPES)
using namespace Lmdthemescommontypes;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdthemescommontypesHPP
